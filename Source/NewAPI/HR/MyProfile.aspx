<%@ Page Language="vb" AutoEventWireup="false" CodeFile="HR_MyProfile.aspx.vb" Inherits="Whizible.MyProfile" meta:resourcekey="PageResource1" Culture="auto" UICulture="auto" %>

<!DOCTYPE html>

<html>
<%CommonFunctions.General.PlotPageHeadTag("My Profile")%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">

    <style type="text/css">
        body {
            background: #f5f5f5;
            font-family: Roboto, sans-serif;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }
        .main-container {
            padding: 0;
            background: #f5f5f5;
            min-height: 100vh;
        }
        .page-header {
            background: #f5f7fa;
            padding: 4px 24px 4px 3px;
            margin-bottom: 0;
            display: block;
            border-bottom: 1px solid #e5e7eb;
        }
        .title-row {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 0;
            }

        html {
            scroll-behavior: smooth;
        }
        .header-icon-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            flex-shrink: 0;
        }
        .header-icon-title-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 2px;
        }

        .profile-picture-wrapper {
            position: relative;
            width: 40px;
            height: 30px;
            border-radius: 50%;
           /* border: 2px solid #1e40af;*/
            background: #f5f7fa;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }
        .profile-picture-icon {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
            display: block;
            position: absolute;
            top: 0;
            left: 0;
        }
        .profile-picture-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(30, 64, 175, 0.8);
            color: #fff;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
            border-radius: 50%;
            font-size: 10px;
        }
        
        .profile-picture-overlay i {
                font-size: 11.5px;
                margin-bottom: 1px;
        }

        .profile-picture-overlay span {
                font-size: 7px;
                font-weight: 500;
        }

        .profile-picture-wrapper:hover .profile-picture-overlay {
            opacity: 1;
        }

        .profile-picture-wrapper:hover .profile-picture-icon {
            opacity: 0.5;
        }

        .profile-picture-wrapper:hover .profile-picture-img {
            opacity: 0.5;
        }

        .page-title {
            color: #4263c1;
            font-size: 18px;
            font-weight: 600;
            margin: 0;
            line-height: 1.2;
        }
        .content-section {
            background: #fff;
            margin: 5px 0 0px 0;
            padding: 0;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .section-header {
            color: #4263c1;
            font-size: 11.5px;
            font-weight: 500;
            margin-bottom: 0;
            margin-top: 0;
            margin-left: 0;
            margin-right: 0;
            background: #f5f7fa;
            background-color: #f5f7fa;
            padding: 2px 24px;
            border: none;
            border-bottom: 1px solid #e5e7eb;
            border-radius: 8px 8px 0 0;
            width: 100%;
            box-sizing: border-box;
            transition: background-color 0.3s ease, color 0.2s ease;
            cursor: pointer;
        }
        .section-header:hover {
                color: #1e40af;
                background-color: #f0f4ff;
        }

        /* Content wrapper inside section to add padding for content */
        .content-section > .form-row,
        .content-section > .address-group,
        .content-section > .info-section,
        .content-section > .professional-cards-container {
            padding-left: 24px;
            padding-right: 24px;
            padding-top: 0;
            padding-bottom: 0;
        }
        .content-section > .form-row:first-of-type {
            padding-top: 0;
         }

        .content-section > .form-row:last-of-type {
            padding-bottom: 24px;
        }

        .content-section > .address-group:last-child {
             padding-bottom: 24px;
        }

        .content-section > .info-section {
            padding-bottom: 8px;
         }

        .content-section > .professional-cards-container {
             padding-bottom: 24px;
        }

        .subsection-header {
            color: #374151;
            font-size: 15px;
            font-weight: 500;
            letter-spacing: 0.1px;
            margin-bottom: 20px;
            margin-top: 0;
            padding: 0 0 10px 0;
            background: transparent;
            border-left: none;
            border-radius: 0;
            position: relative;
            display: flex;
            align-items: center;
            text-transform: none;
        }

        .address-group .subsection-header {
            margin-bottom: 20px;
            padding-bottom: 10px;
        }

        .same-address-checkbox {
           margin-bottom: 15px;
           display: inline-flex;
           align-items: center;
           gap: 6px;          
           white-space: nowrap; 
        }
        .same-address-checkbox input[type="checkbox"] {
                margin-right: 8px;
                cursor: pointer;
                width: 14px;
                height: 14px;
        }
        .same-address-checkbox label {
                margin: 0;
                cursor: pointer;
                font-weight: 400;
                color: #374151;
                font-size: 11.5px;
            }

        .address-group .form-control:disabled,
        .address-group .form-control[readonly] {
            background-color: #f9fafb;
            cursor: not-allowed;
            opacity: 0.7;
        }
        .address-group .form-label {
                font-size: 11.5px;
                color: #374151;
                font-weight: 500;
                margin-bottom: 6px;
        }
        .address-group .form-control {
                border: 1px solid #d1d5db;
                border-radius: 6px;
                padding: 10px 14px;
                font-size: 11.5px;
                transition: all 0.2s ease;
                background: #fff;
                width: 250px;
        }
        .address-group .form-control[type="text"],
        .address-group .form-control:not(textarea) {
        height: 30px;
                }
        .address-group textarea.form-control {
                min-height: 30px;
                resize: vertical;
        }
        .txtAddress {
        width: 250px !important;
        }

        .address-group .form-control:focus {
        border-color: #3b82f6;
        box-shadow: 0 0 0 3px rgba(59,130,246,.1);
        outline: none;
        }

        .address-group .form-control::placeholder {
                color: #9ca3af;
                font-size: 11.5px;
            }

        .address-group .form-row {
                margin-bottom: 20px;
         }

        .address-group .form-row:last-child {
                    margin-bottom: 0;
         }

        .address-group .form-col {
                padding: 0;
        }

        .form-group {
            margin-bottom: 0;
        }

        .form-label {
            display: block;
            margin-bottom: 6px;
            font-weight: 500;
            color: #374151;
            font-size: 11.5px;
        }

        .form-label.required::after {
                content: " *";
                color: #dc3545;
         }

        .form-control {
            width: 250px;
            padding: 10px 14px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 11.5px;
            color: #374151;
            margin: 0;
            box-sizing: border-box;
            height: 30px;
            line-height: 1.5;
            transition: all 0.2s ease;
        }
        .form-control:focus {
                outline: none;
                border-color: #3b82f6;
                box-shadow: 0 0 0 3px rgba(59,130,246,.1);
        }

        .form-control[readonly] {
                background-color: #f3f4f6;
                cursor: not-allowed;
        }

        .textareaSkill {
            width: 250px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 12px;
            align-items: flex-start;
        }

        .form-row:first-of-type {
                margin-top: 0;
        }

        .form-row:last-child {
                margin-bottom: 0;
        }

        .form-col {
            flex: 1;
            display: flex;
            flex-direction: column;
            min-width: 0;
        }

        .form-col-half {
            flex: 0 0 50%;
            min-width: 0;
        }

        .form-col .form-group {
            margin-bottom: 0;
            width: 100%;
        }

        @media (max-width: 768px) {
        .form-row {
                flex-direction: column;
                gap: 0;
        }

            /*.form-col-half {
                flex: 1;
                max-width: 250px;
            }*/
        .form-col .form-group {
                margin-bottom: 15px;
        }

        .address-group .form-row {
                flex-direction: column;
                gap: 0;
        }
        .address-group .form-col {
                width: 100%;
                max-width: 100%;
            }
        }

        .btn-save {
            background: #f6a637;
            color: #fff;
            border: 1px solid #f6a637;
            padding: 4px 16px;
            border-radius: 6px;
            font-size: 11.5px;
            font-weight: normal;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-save:hover {
                background: #fbb03b;
                border-color: #fbb03b;
                transform: translateY(-1px);
                box-shadow: 0 2px 6px rgba(0,0,0,0.12);
         }

        .date-picker-wrapper {
            position: relative;
            width: 100%;
            margin: 0;
            padding: 0;
            z-index: 1;
        }
     
        .date-picker {
            position: relative;
            width: 32%;
            margin: 0;
            padding: 0;
            z-index: 1;
        }
        .ui-datepicker {
            z-index: 1050 !important;
        }
        body.modal-open .ui-datepicker {
            z-index: 1055 !important;
        }

        #deleteConfirmModal {
            z-index: 1060 !important;
        }

        #deleteConfirmModal .modal-dialog {
                z-index: 1061 !important;
        }

        .date-picker-icon {
            position: relative;
       /*     dominant-baseline: middle;*/
            top: 40%;
            transform: translateY(-50%);
            color: #6c757d;
            pointer-events: none;
            z-index: 1;
        }

        .form-control.date-input {
            padding-right: 38px;
            width: 210px;
            margin: 0;
            box-sizing: border-box;
            height: 30px;
            line-height: 1.5;
        }
     
        /* Read-only Information Section */
        .info-section {
            background: #f9fafb;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        .info-row {
            display: flex;
            padding: 8px 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .info-row:last-child {
                border-bottom: none;
            }

        .info-label {
            font-weight: normal;
            color: #374151;
            width: 200px;
            flex-shrink: 0;
        }

        .info-value {
            color: #6b7280;
            flex: 1;
        }

        /* Professional Background Cards/Accordion */
        .professional-cards-container {
            display: flex;
            flex-direction: column;
            gap: 0;
            margin-left: 20px;
            padding-left: 20px;
            border-left: solid #e5e7eb;
        }

        .professional-card {
            background: transparent;
            border: none;
            border-radius: 0;
            box-shadow: none;
            transition: all 0.3s ease;
            margin-bottom: 10px;
        }

        .professional-card:last-child {
                margin-bottom: 0;
        }

        .professional-card:hover {
                box-shadow: none;
                border-color: transparent;
        }

        .professional-card-header {
            background: transparent;
            padding: 0;
            border-bottom: 1px solid #e5e7eb;
            cursor: pointer;
            display: none;
            align-items: center;
            justify-content: space-between;
            transition: all 0.3s ease;
            margin-bottom: 8px;
            border-radius: 6px 6px 0 0;
        }

        .professional-card-header:hover {
                background: transparent;
            }

        .professional-card-header:hover .professional-card-title {
                    background: #dbeafe;
        }

        .professional-card-header.active {
                background: transparent;
                border-bottom-color: #e5e7eb;
        }

        .professional-card-header.active .professional-card-title {
                    background: #eff6ff;
                }

        .professional-card-title {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 0;
            color: #1e40af;
            font-size: 11.5px;
            font-weight: 500;
            padding: 12px 16px;
            background: #eff6ff;
            background-color: #eff6ff;
            border-radius: 6px 6px 0 0;
            margin-bottom: 0;
            transition: background-color 0.3s ease;
        }

        .professional-card-title i {
                font-size: 11.5px;
                color: #1e40af;
        }

        .professional-card-header.active .professional-card-title {
            color: #374151;
        }

        .professional-card-body {
            padding: 0;
            padding-left: 0;
            padding-top: 0;
            display: none;
            position: relative;
            margin-top: 0;
        }

        .professional-card-body.active {
                display: block;
                padding-top: 0;
                margin-top: 0;
        }

        .professional-card-body-actions {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 15px;
            margin-top: 0;
            padding-top: 0;
            position: relative;
            top: 0;
            right: 0;
            z-index: 10;
        }

        /* Ensure consistent spacing between tabs and content for all cards */
        .professional-card-body.active .professional-card-body-actions {
            margin-top: 0;
            padding-top: 0;
        }

        .professional-card-body.active .data-table-wrapper {
            margin-top: 0;
            padding-top: 0;
        }

        .professional-card-body-actions .btn {
            display: flex;
            align-items: center;
            gap: 2px;
        }

        .professional-card-body-actions .btn-primary {
            background: #4263c1;
            border-color: #4263c1;
            color: #ffffff;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .professional-card-body-actions .btn-primary:hover {
                background: #fbb03b;
                border-color: #fbb03b;
                color: #fbb03b;
                box-shadow: 0 2px 4px rgba(66, 99, 193, 0.3);
        }

        .professional-card-body-actions .btn-primary:active,
        .professional-card-body-actions .btn-primary:focus {
                background: #fbb03b;
                border-color: #fbb03b;
                color: #ffffff;
        }


        @media (max-width: 768px) {
        .page-header {
              padding: 6px 16px;
        }

        .page-title {
              font-size: 11.5px;
        }

        .header-icon-title-row {
                margin-bottom: 4px;
        }

        .profile-picture-wrapper {
              width: 36px;
              height: 36px;
        }

        .profile-picture-icon {
             font-size: 24px;
        }

        .profile-picture-overlay i {
             font-size: 10px;
        }

        .profile-picture-overlay span {
             font-size: 6px;
        }

        .professional-card-header {
              padding: 0;
        }

        .professional-card-title {
              font-size: 11.5px;
        }

        .professional-card-body {
             padding: 0;
        }

        .professional-cards-container {
                margin-left: 10px;
                padding-left: 10px;
                gap: 8px;
                margin-top: 0;
        }

        .professional-card + .professional-card {
                margin-top: 0;
         }
        }
        .btn-primary {
            background: #f6a637;
            color: #fff;
            border: 1px solid #f6a637;
            padding: 4px 16px;
            border-radius: 6px;
            font-size: 11.5px;
            font-weight: normal;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-primary:hover {
                background: #fbb03b;
                border-color: #fbb03b;
                transform: translateY(-1px);
                box-shadow: 0 2px 6px rgba(0,0,0,0.12);
        }

        .btn-secondary {
            background: #ffffff;
            color: #1359a6;
            border: 1px solid;
            padding: 4px 12px;
            border-radius: 6px;
            font-size: 11.5px;
            font-weight: normal;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-secondary:hover {
                background: #1359a6;
                border-color: #1359a6;
                transform: translateY(-1px);
                box-shadow: 0 2px 6px rgba(0,0,0,0.12);
        }

        .bootstrap-select.form-control:not([class*="col-"]) {
                 width: 70%;
               }

        .data-table-wrapper {
            margin-top: 0;
            border: 1px solid #e5e7eb;
            border-radius: 4px;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            margin: 0;
        }

        .data-table thead {
                background: #f3f4f6;
        }

        .data-table th {
                padding: 12px 16px;
                text-align: left;
                font-weight: 600;
                color: #374151;
                font-size: 11.5px;
                border-bottom: 1px solid #e5e7eb;
                border-right: 1px solid #e5e7eb;
                white-space: nowrap;
        }

        .data-table th:last-child {
                    border-right: none;
        }

        .data-table td {
                padding: 12px 16px;
                border-bottom: 1px solid #e5e7eb;
                border-right: 1px solid #e5e7eb;
                color: #374151;
                font-size: 11.5px;
                background: #fff;
         }

        .data-table td:last-child {
                border-right: none;
        }

        .data-table td small.text-muted {
                display: block;
                margin-top: 4px;
                color: #9ca3af;
                font-size: 0.875em;
                line-height: 1.4;
        }

        .data-table tbody tr:hover {
                background: #f9fafb;
         }

        .data-table tbody tr:last-child td {
                border-bottom: none;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #9ca3af;
            font-size: 11.5px;
        }

        .pagination-container {
            display: flex;
            align-items: center;
            justify-content: end;
            gap: 8px;
            padding: 10px 0;
            margin-top: 10px;
        }
        .modal-content {
            width:80%;
            border: none;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        #certificationModal .modal-dialog,
        #qualificationModal .modal-dialog,
        #workExperienceModal .modal-dialog,
        #assignmentModal .modal-dialog,
        #skillModal .modal-dialog {
            max-width: 600px;
        }

        .modal-header {
            background: #4263c1;
            border-bottom: none;
            padding: 16px 20px;
            border-radius: 8px 8px 0 0;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .modal-title {
            color: #ffffff;
            font-size: 14px;
            /* Modified By Madhuri.K On 01-04-2026 */
            font-weight: 600;
            margin: 0;
            text-align: center;
            flex: 1;
        }

        .modal-header .btn-close {
            position: absolute;
            right: 12px;
            opacity: 1;
            filter: invert(1) grayscale(100%) brightness(200%);
        }

         .modal-header .btn-close:hover {
                opacity: 1;
         }

        .modal-body .form-row-horizontal {
            display: flex;
            align-items: center;
            margin-bottom: 16px;
            min-height: 30px;
            justify-content: flex-start;
        }

        .modal-body .form-row-horizontal .form-label {
            width: 160px;
            min-width: 160px;
            margin-bottom: 0;
            margin-right: 12px;
            text-align: left; 
            flex-shrink: 0;
            padding-top: 0;
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */
            color: #374151;
            font-weight: 500;
            line-height: 30px;
        }

        .modal-body .form-row-horizontal .form-control-wrapper {
            flex: 0 0 auto;
            max-width: 300px;
            width: 300px;
            margin-left: 0;
        }

        .modal-body .form-row-horizontal .form-control-wrapper .form-control,
        .modal-body .form-row-horizontal .form-control-wrapper select {
            width: 90%;
            height: 30px;
        }

        .modal-body .form-row-horizontal .form-control-wrapper textarea.form-control {
              height: auto;
              min-height: 60px;
        }

        #qualificationModal button[data-id="modalQualificationName"] {
               width: 250px !important;
               max-width: 250px !important;
         }

        #qualificationModal button[data-id="modalQualificationName"] .filter-option-inner-inner {
                max-width: 80%;
                white-space: nowrap;
        }

        .modal-body .form-row-horizontal:has(#modalPassingYear) .form-control-wrapper,
        .modal-body .form-row-horizontal:has(#modalPercentageGrade) .form-control-wrapper {
            max-width: 140px;
            width: 140px;
        }

        .modal-body .form-row-horizontal:has(#txtmodalScore) .form-control-wrapper {
            max-width: 200px;
            width: 200px;
        }

        .modal-body .form-row-horizontal:has(#modalFromDate) .form-control-wrapper,
        .modal-body .form-row-horizontal:has(#modalTillDate) .form-control-wrapper {
            max-width: 200px;
            width: 200px;
        }

        .modal-body .form-row-horizontal:has(#modalCertificationDate) .form-control-wrapper,
        .modal-body .form-row-horizontal:has(#modalValidUpTo) .form-control-wrapper {
            max-width: 200px;
            width: 200px;
        }

        .fixed-width-combo {
            width: 250px !important; 
        }

        .fixed-width-combo + .dropdown-toggle {
                width: 250px !important; 
         }

        .modal-body .info-note {
            margin-left: 220px;
            margin-top: -12px;
            margin-bottom: 15px;
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */
            color: #6b7280;
            font-style: italic;
        }

        .modal-body {
            padding: 25px;
        }

        .modal-body .btn-secondary {
            background: #ffffff;
            border: 2px solid #1e40af;
            color: #1359a6;
            font-weight: 600;
            padding: 6px 20px;
            font-size: 11.5px;
            border-radius: 6px;
            min-width: 90px;
        }

        .modal-body .btn-secondary:hover {
                background: #ffffff;
                border-color: #1359a6;
                color: #1359a6;
        }

        .modal-body .btn-primary {
            background: #e9961f;
            border: 2px solid #e9961f;
            color: #ffffff;
            font-weight: 600;
            padding: 6px 20px;
            font-size: 11.5px;
            border-radius: 6px;
            min-width: 90px;
        }

        .modal-body .btn-primary:hover {
                background: #d6891c;
                border-color: #d6891c;
                color: #ffffff;
        }

        .modal-body .form-group {
            margin-bottom: 20px;
        }

        .modal-body .form-label {
            font-size: 11.5px;
            color: #374151;
            font-weight: 500;
            margin-bottom: 6px;
        }

        .modal-body .form-label.required::after {
                content: "*";
                color: #dc3545;
                margin-left: 4px;
                font-weight: 600;
        }

        .modal-body .form-control:focus {
            border-color: #1e40af;
            box-shadow: 0 0 0 3px rgba(30, 64, 175, 0.1);
            outline: none;
        }

        .modal-body .input-group {
            width: 250px;
        }

        .modal-body .input-group .form-control {
                flex: 1;
                width: 250px;
        }

        .modal-body .input-group-text {
            border: 1px solid #d1d5db;
            border-left: none;
            background: #fff;
            flex-shrink: 0;
        }

         .date-fixed-width {
         display: flex;
         flex-wrap: nowrap;
          width: 280px;   
         }

        .modal-body .date-picker-wrapper {
            position: relative;
        }

        .modal-body .date-picker-wrapper .date-input {
         padding-right: 40px !important;
        }

        .input-group-btn button.btn.btncalendar {
            margin: 0;
            height: 32px;
            width:auto;
        }
   
        .input-group-btn button.btn.btncalendar {
                height: 30px;
                margin-left: -3px;
                background:#eee;
        }

        .modal-body #modalCreatedBy {
            width: 250px !important;
        }

        .modal-body #modalCreatedDate {
            padding-right: 40px !important;
            width: 250px !important;
        }

        .modal-body #modalCreatedDate .date-picker-icon {
                position: relative;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                color: #6c757d;
                pointer-events: auto;
                cursor: pointer;
                z-index: 10;
                background: transparent;
        }

        .modal-body .date-picker-wrapper:has(#modalCreatedDate) {
            position: relative;
            width: 250px;
        }

        .modal-body .date-picker-wrapper textarea {
            padding-right: 35px;
        }

        .professional-tabs {
            display: flex;
            flex-wrap: nowrap;
            border-bottom: 2px solid #e5e7eb;
            margin: 16px 0 8px 0;
            padding: 0;
            list-style: none;
        }

        .professional-tabs .nav-item {
                flex-shrink: 0;
        }

        .professional-tabs .nav-link {
                padding: 10px 16px;
                color: #6b7280;
                background: transparent;
                border: none;
                border-bottom: 2px solid transparent;
                cursor: pointer;
                white-space: nowrap;
                font-size: 11.5px;
                font-weight: 500;
                transition: all 0.2s ease;
        }
        
        .professional-tabs .nav-link:hover {
               color: #1e40af;
               background: #eff6ff;
         }

        .professional-tabs .nav-link.active {
                color: #1e40af;
                background: #eff6ff;
                border-bottom: 2px solid #1e40af;
        }

        .modal .ui-datepicker {
            z-index: 9999 !important;
            position: fixed !important;
        }

        .modal .ui-datepicker-div {
            z-index: 9999 !important;
            position: fixed !important;
        }

        .modal .ui-datepicker-header {
            z-index: 9999 !important;
        }

        @media (max-width: 768px) {
            .nav-tabs .nav-link {
             padding: 8px 12px;
             font-size: 11.5px;
            }
         }

        .alertify .ajs-commands {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
        }

        .custmodal .modal-content {
            border-radius: 10px;
        }

        .custmodal .modal-header {
            position: relative;
            background-color: #4263c1;
            color: #fff;
            justify-content: center;
            padding: 10px 16px;
            border-bottom: none;
            border-radius: 10px 10px 0 0;
        }

        .custmodal .modal-title {
            font-size: 11.5px;
            font-weight: 600;
        }

        .custmodal .modal-close {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 20px;
            color: #fff;
            cursor: pointer;
            font-weight: 800;
            line-height: 1;
        }

        .custmodal .modal-close:hover {
                opacity: 1;
        }

        .custmodal .modal-body {
            text-align: left;
            padding: 20px;
            font-size: 11.5px;
        }

        .custmodal .modal-body .d-flex {
                justify-content: flex-end;
        }

        .custmodal .borderbtn {
            border: 1px solid #4263c1;
            color: #4263c1;
            background: #fff;
            padding: 4px 17px;
        }

        .custmodal .btnyellow {
            background-color: #f5a623;
            color: #fff;
            padding: 4px 8px;
        }
    </style>
</head>

<body>
    <%If m_blnViewAccess = True Then%>
    <div class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="title-row">
                <div class="header-icon-container">
                    <div class="header-icon-title-row">
                            <div class="profile-picture-wrapper">
                                <img id="ProfilePicURL" src="../../../Whizible2.0-new/dist/img/blankprofile.png"  class="profile-picture-icon" onerror="this.onerror=null;this.src='../../../Images/Photo/no-photo.png'" />
                            </div>
                        <h1 class="page-title"><%=MyBase.GetResourceString("C_MyProfile")%></h1>
                    </div>
                </div>
                <%If m_blnEditAccess = True Then%>
                <div style="display: flex; align-items: center; gap: 12px;">
                    <span style="color: #6c757d; font-size: 11.5px; font-weight: 500;"> <%=MyBase.GetResourceString("C_Mandatory")%></span>
                <button type="button" class="btn-save" onclick="SaveProfile_Onclick()"><%=MyBase.GetResourceString("C_Save")%></button>
                </div>
                <%End If%>
          </div>
      </div>
      <div id="section-personal" class="content-section">
            <!-- Personal Information Section -->
          <div class="section-header" onclick="navigateToSection('personal')"><%=MyBase.GetResourceString("C_PersonalInformation")%></div>
            <div style="margin-top: 16px; margin-bottom: 12px;">
                <div class="row ps-3">
                    <div class="col-sm-3" style="padding-right: 15px;">
                        <div class="form-row-horizontal" style="display: flex; align-items: center; margin-bottom: 16px;">
                            <label class="form-label required" for="txtEmployeeName" style="width: 140px; min-width: 140px; margin-bottom: 0; margin-right: 12px; text-align: left; flex-shrink: 0;"><%=MyBase.GetResourceString("C_EmployeeName")%></label>
                            <div class="form-control-wrapper" style="flex: 1;">
                                <input type="Textbox" name="EmployeeName" id="EmployeeName" class="clsTextBoxReadOnly EmpNameInput form-control" style="text-align: left; width: 250PX;" readonly="" maxlength="30" disabled="">
                            </div>
                        </div>
                        <div class="form-row-horizontal" style="display: flex; align-items: center; margin-bottom: 16px;">
                            <label class="form-label" for="cboBloodGroup" style="width: 100px; min-width: 140px; margin-bottom: 0; margin-right: 12px; text-align: left; flex-shrink: 0;"><%=MyBase.GetResourceString("C_BloodGroup")%></label>
                            <div class="form-control-wrapper" style="width:200px ">
                                <%CommonFunctions.HTMLControls.DrawComboBox("cboBloodGroup", "usp_Sel_BloodGroup",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                            </div>
                        </div>
                        <div class="form-row-horizontal" style="display: flex; align-items: center; margin-bottom: 16px;">
                       <label class="form-label required" for="dtBirthDate" style="width: 140px; min-width: 140px; margin-bottom: 0; margin-right: 12px; text-align: left; flex-shrink: 0;"><%=MyBase.GetResourceString("C_BirthDate")%></label>
                             <% CommonFunctions.HTMLControls.DrawTextBox("dtBirthDate", "dtBirthDate", "form-control date-input", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                             <span class="input-group-btn"> <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt date-picker-icon"></i></button></span>
                       </div>
                 </div>
           </div>
       </div>
        <!-- Permanent Address Subsection -->
       <div class="row">
              <div class="col-sm-6">
                    <div class="row">
                        <div class="col-sm-4">
                              <label class="form-label text-end"><%=MyBase.GetResourceString("C_PermanentAddress")%> </label>
                       </div>
                   </div>
                   <div class="form-col form-col-half">
                        <div class="form-group row">
                             <div class="col-sm-4">
                                    <label class="form-label text-end" for="txtPermanentAddress"><%=MyBase.GetResourceString("C_Address")%></label>
                             </div>
                             <div class="col-sm-8">
                                    <textarea wrap="soft" name="txtAddress" id="txtAddress" class="form-control clsTextArea"  maxlength="255" style="width: 250px; text-align: left;" tabindex="6" rows="2" oninput="this.value = this.value.replace(/\s+/g, ' ')" ></textarea>
                            </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="form-col from-col-half">
                                    <div class="form-group row ">
                                        <div class="col-sm-4">
                                            <label class="form-label text-end" for="txtPermanentCity"><%=MyBase.GetResourceString("C_City")%></label>
                                        </div>
                                        <div class="col-sm-8">
                                              <%CommonFunctions.HTMLControls.DrawTextBox("txtPermanentCity", "txtPermanentCity", "form-control", maxLength:=30)%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-col from-col-half">
                                    <div class="form-group row ">
                                        <div class="col-sm-4">
                                            <label class="form-label text-end" for="txtcboPermanentState"><%=MyBase.GetResourceString("C_State")%></label>
                                        </div>
                                        <div class="col-sm-8">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtcboPermanentState", "txtcboPermanentState", "form-control", maxLength:=30)%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-col from-col-half">
                                    <div class="form-group row">
                                        <div class="col-sm-4">
                                            <label class="form-label text-end" for="txtPinCode"><%=MyBase.GetResourceString("C_PinCode")%></label>
                                        </div>
                                        <div class="col-sm-8">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPinCode", "txtPinCode", "form-control", maxLength:=6)%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-col from-col-half">
                                    <div class="form-group row ">
                                        <div class="col-sm-4">
                                            <label class="form-label text-end" for="txtPhone"><%=MyBase.GetResourceString("C_Phone")%></label>
                                        </div>
                                        <div class="col-sm-8">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPhone", "txtPhone", "form-control", maxLength:=11)%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                         <div class="row">
                        <div class="col-sm-4">
                            <label class="form-label text-end "><%=MyBase.GetResourceString("C_CurrentAddress")%></label>
                        </div>
                        <div class="col-sm-8">
                            <div class="same-address-checkbox">
                                <input type="checkbox" id="chkSameAsPermanent" /> 
                                <label for="chkSameAsPermanent"><%=MyBase.GetResourceString("C_SameasPermanentAddress")%></label>
                            </div>
                        </div>
                    </div>
                        <div class="form-row">
                            <div class="form-col form-col-half">
                                <div class="form-group row">
                                    <div class="col-sm-8">
                                        <label class="form-label text-end" for="txtPermanentAddress"><%=MyBase.GetResourceString("C_CurrentAddress")%></label>
                                    </div>
                                    <div class="col-sm-4">
                                   <textarea wrap="Soft" name="textCurrentAddress" id="textCurrentAddress" maxlength="255" class="form-control clsTextArea" style="width: 250px; text-align: left" tabindex="6" oninput="this.value = this.value.replace(/\s+/g, ' ')"></textarea>                                           
                                    </div>
                                </div>
                                <div class="form-row mt-2">
                                    <div class="form-col from-col-half">
                                        <div class="form-group row ">
                                            <div class="col-sm-8">
                                                <label class="form-label text-end" for="txtCurrentCity"><%=MyBase.GetResourceString("C_CurrentCity")%></label>
                                            </div>
                                            <div class="col-sm-4">
                                                  <%CommonFunctions.HTMLControls.DrawTextBox("txtCurrentCity", "txtCurrentCity", "form-control", maxLength:=30)%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-col from-col-half">
                                        <div class="form-group row ">
                                            <div class="col-sm-8">
                                                <label class="form-label text-end" for="txtcboCurrentState"><%=MyBase.GetResourceString("C_CurrentState")%></label>
                                            </div>
                                            <div class="col-sm-4">
                                                   <%CommonFunctions.HTMLControls.DrawTextBox("txtcboCurrentState", "txtcboCurrentState", "form-control", maxLength:=30)%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-col from-col-half">
                                        <div class="form-group row">
                                            <div class="col-sm-8">
                                                <label class="form-label text-end" for="txtCurrentPinCode"><%=MyBase.GetResourceString("C_CurrentPinCode")%></label>
                                            </div>
                                            <div class="col-sm-4">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtCurrentPinCode", "txtCurrentPinCode", "form-control", maxLength:=6)%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-col from-col-half">
                                        <div class="form-group row ">
                                            <div class="col-sm-8">
                                                <label class="form-label text-end" for="txtCurrentPhone"><%=MyBase.GetResourceString("C_CurrentPhone")%></label>
                                            </div>
                                            <div class="col-sm-4">
                                                   <%CommonFunctions.HTMLControls.DrawTextBox("txtCurrentPhone", "txtCurrentPhone", "form-control", maxLength:=11)%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <!-- Other Information Section (Read-only) -->
       <div id="section-other" class="content-section">
          <div class="section-header" onclick="navigateToSection('other')"><%=MyBase.GetResourceString("C_OtherInformation")%></div>
                <div class="info-section">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="info-row">
                                <div class="info-label"><%=MyBase.GetResourceString("C_RoleName")%></div>
                                <div class="info-value" id="lblRoleName">-</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label"><%=MyBase.GetResourceString("C_BusinessGroup")%></div>
                                <div class="info-value" id="lblBusinessGroup">-</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label"><%=MyBase.GetResourceString("C_EmployeeType")%></div>
                                <div class="info-value" id="lblEmployeeType">-</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label"><%=MyBase.GetResourceString("C_EmailID")%></div>
                                <div class="info-value" id="lblEmailID">-</div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="info-row">
                                <div class="info-label"><%=MyBase.GetResourceString("C_Department")%></div>
                                <div class="info-value" id="lblDepartment">-</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label"><%=MyBase.GetResourceString("C_OrganizationUnit")%></div>
                                <div class="info-value" id="lblOrganizationUnit">-</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label"><%=MyBase.GetResourceString("C_JoiningDate")%></div>
                                <div class="info-value" id="lblJoiningDate">-</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label"><%=MyBase.GetResourceString("C_Gender")%></div>
                                <div class="info-value" id="lblGender">-</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Passport Details Section -->
            <div id="section-passport" class="content-section">
                <div class="section-header" onclick="navigateToSection('passport')"><%=MyBase.GetResourceString("C_PassportDetails")%></div>
                <div class="info-section" style="background: #ffffff; padding: 15px;">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="info-row" style="border-bottom: none; padding: 4px 0;">
                                <div class="info-label" style="width: 150px; margin-right: 8px;"><%=MyBase.GetResourceString("C_PassportNumber")%></div>
                                <div class="info-value">
                                           <%CommonFunctions.HTMLControls.DrawTextBox("txtPassportNumber", "txtPassportNumber", "form-control", maxLength:=9)%>
                                </div>
                            </div>
                            <div class="info-row" style="border-bottom: none; padding: 4px 0;">
                                <div class="info-label" style="width: 150px; margin-right: 8px;"><%=MyBase.GetResourceString("C_FullName")%></div>
                                <div class="info-value">
                                     <%CommonFunctions.HTMLControls.DrawTextBox("txtFullName", "txtFullName", "form-control", maxLength:=100)%>
                                </div>
                            </div>
                            <div class="info-row" style="border-bottom: none; padding: 4px 0;">
                                <div class="info-label" style="width: 150px; margin-right: 8px;"><%=MyBase.GetResourceString("C_DateOfIssue")%></div>
                                       <% CommonFunctions.HTMLControls.DrawTextBox("dtDateOfIssue", "dtDateOfIssue", "form-control date-input", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                                      <span class="input-group-btn"> <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt date-picker-icon"></i></button></span>
                            </div>
                        </div>
                        <div class="col-sm-6">
                           <div class="info-row" style="border-bottom: none; padding: 4px 0; display:flex; align-items:center;">
                             <div class="info-label" style="width:150px; margin-right:8px;"> <%= MyBase.GetResourceString("C_ExpiryDate") %> 
                             </div>
                                 <% CommonFunctions.HTMLControls.DrawTextBox("dtExpiryDate", "dtExpiryDate", "form-control date-input", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                                        <span class="input-group-btn"> <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt date-picker-icon"></i></button></span>
                            </div>
                            <div class="info-row" style="border-bottom: none; padding: 4px 0;">
                                <div class="info-label" style="width: 150px; margin-right: 8px;"><%=MyBase.GetResourceString("C_PlaceOfIssue")%></div>
                                <div class="info-value">
                                      <%CommonFunctions.HTMLControls.DrawTextBox("txtPlaceOfIssue", "txtPlaceOfIssue", "form-control", maxLength:=50)%>
                                </div>
                            </div>
                            <div class="info-row" style="border-bottom: none; padding: 4px 0;">
                                <div class="info-label" style="width: 150px; margin-right: 8px;"><%=MyBase.GetResourceString("C_MobileNumber(s)")%></div>
                                <div class="info-value">
                                       <%CommonFunctions.HTMLControls.DrawTextBox("txtMobileNumbers", "txtMobileNumbers", "form-control", maxLength:=12)%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="info-row" style="border-bottom: none; padding: 4px 0;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;"><%=MyBase.GetResourceString("C_InstantMessengerIds")%></div>
                        <div class="info-value">
                            <textarea wrap="soft" name="InstantMessengerIds" id="txtInstantMessengerIds" maxlength="300" class="form-control clsTextArea" style="width: 250px; text-align: left;" rows="2" placeholder="<%=MyBase.GetResourceString("C_EnterinstantmessengerIDs")%>" tabindex="6" oninput="this.value = this.value.replace(/\s+/g, ' ')"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Professional Background Section -->   
            <div id="section-professional" class="content-section">
                <div class="section-header" onclick="navigateToSection('professional')"><%=MyBase.GetResourceString("C_ProfessionalBackground")%></div>
                <ul class="nav nav-tabs professional-tabs" style="display: flex; flex-wrap: nowrap; border-bottom: 2px solid #e5e7eb; margin: 16px 0 8px 0; padding: 0; list-style: none;">
                    <li class="nav-item" style="flex-shrink: 0;">
                             <%If m_blnViewAccess_Certification = True Then%>
                        <a class="nav-link professional-tab-link" href="javascript:void(0);" data-tab="certifications" onclick="switchProfessionalTab('certifications'); return false;" style="padding: 10px 16px; color: #6b7280; background: transparent; border: none; border-bottom: 2px solid transparent; cursor: pointer; white-space: nowrap; font-size: 11.5px; font-weight: 500;"><%=MyBase.GetResourceString("C_Certifications")%></a>
                              <%End If %>
                    </li>
                    <li class="nav-item" style="flex-shrink: 0;">
                         <%If m_blnViewAccess_Qualifications = True Then%>
                        <a class="nav-link professional-tab-link" href="javascript:void(0);" data-tab="qualifications" onclick="switchProfessionalTab('qualifications'); return false;" style="padding: 10px 16px; color: #6b7280; background: transparent; border: none; border-bottom: 2px solid transparent; cursor: pointer; white-space: nowrap; font-size: 11.5px; font-weight: 500;"><%=MyBase.GetResourceString("C_Qualifications")%></a>
                          <%End If %>
                    </li>
                    <li class="nav-item" style="flex-shrink: 0;">
                         <%If m_blnViewAccess_PrevWorkExp = True Then%>
                        <a  class="nav-link professional-tab-link" href="javascript:void(0);" data-tab="workexperience" onclick="switchProfessionalTab('workexperience'); return false;" style="padding: 10px 16px; color: #6b7280; background: transparent; border: none; border-bottom: 2px solid transparent; cursor: pointer; white-space: nowrap; font-size: 11.5px; font-weight: 500;"><%=MyBase.GetResourceString("C_Prev.WorkExp.")%></a>
                          <%End If %>
                    </li>
                    <li class="nav-item" style="flex-shrink: 0;">
                         <%If m_blnViewAccess_Assignments = True Then%>
                        <a class="nav-link professional-tab-link" href="javascript:void(0);" data-tab="assignments" onclick="switchProfessionalTab('assignments'); return false;" style="padding: 10px 16px; color: #6b7280; background: transparent; border: none; border-bottom: 2px solid transparent; cursor: pointer; white-space: nowrap; font-size: 11.5px; font-weight: 500;"><%=MyBase.GetResourceString("C_Prev.Assignments")%></a>
                          <%End If %>
                    </li>
                    <li class="nav-item" style="flex-shrink: 0;">
                         <%If m_blnViewAccess_Skills = True Then%>
                        <a  class="nav-link professional-tab-link" href="javascript:void(0);" data-tab="skills" onclick="switchProfessionalTab('skills'); return false;" style="padding: 10px 16px; color: #6b7280; background: transparent; border: none; border-bottom: 2px solid transparent; cursor: pointer; white-space: nowrap; font-size: 11.5px; font-weight: 500;"><%=MyBase.GetResourceString("C_Skills")%></a>
                          <%End If %>
                    </li>
                </ul>
                  
                <!-- Professional Cards Container -->
                <div class="professional-card">
                    <div class="professional-card-header" onclick="toggleCard('certifications')">
                        <h3 class="professional-card-title">
                            <i class="fas fa-certificate"></i>
                            <span><%=MyBase.GetResourceString("C_Certifications")%></span>
                        </h3>
                    </div>
                    <div id="card-certifications" class="professional-card-body">
                        <div class="professional-card-body-actions" style="display: flex; justify-content: space-between; align-items: center;">
                            <div style="flex: 1;"></div>
                            <div style="display: flex; align-items: center; gap: 10px; flex: 1; justify-content: center;">
                                <label for="certificationDrop" style="margin: 0; font-weight: 500; font-size: 11.5px; color: #333; white-space: nowrap;"><%=MyBase.GetResourceString("C_CertificationName")%></label>
                                <%CommonFunctions.HTMLControls.DrawComboBox("certificationDrop", "usp_Whizible2_Sel_tbl_PM_Certifications_MyProfile",,, "class='selectpicker form-control' data-live-search='true'",,,) %>
                            </div>
                            <div style="flex: 1; display: flex; justify-content: flex-end; gap: 10px; align-items: center;">
                                <% If m_blnAddAccess_Certification = True Then %>
                                <a class="btn borderbtn addbtn mr-5" onclick="OpenCertificationModal_Offcanvas();" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="<%=MyBase.GetResourceString("C_AddCertification")%>" style="height: 32px; padding: 4px 10px; font-size: 11.5px; min-width: auto;"><i class="fa fa-plus" aria-hidden="true"></i><%=MyBase.GetResourceString("C_Add")%></a>
                                <%End If %>
                                <% If m_blnDeleteAccess_Certification = True Then %>
                                <a href="javascript:void(0);" class="btn borderbtn deletebtn mr-5" onclick="OpenDeleteConfirmModal()" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<%=MyBase.GetResourceString("C_DeleteSelected")%>" style="height: 32px; padding: 4px 10px; font-size: 11.5px;"><%=MyBase.GetResourceString("C_Delete")%></a>
                                <%End If %>
                            </div>
                        </div>
                        <div class="data-table-wrapper">
                            <table class="data-table" id="tblCertifications">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_CertificationName")%></th>
                                        <th><%=MyBase.GetResourceString("C_CertificationDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_Score")%></th>
                                        <th style="text-align: center; width: 60px;">
                                            <input type="checkbox" id="selectAllCertifications" title="<%=MyBase.GetResourceString("C_SelectAll")%>" />
                                        </th>
                                    </tr>
                                </thead>
                              <tbody id="tblCertificationsBody">
                                       <tr>
                                           <td colspan="6" class="empty-state">
                                                <div><%=MyBase.GetResourceString("C_Nodataavailableintable")%></div>
                                           </td>
                                       </tr>
                               </tbody>
                            </table>
                            <div class="pagination-container" id="certPaginationContainer" style="display: none;">
                                <div style="margin-left: auto;"></div>
                                <div style="color: #374151; font-size: 11.5px;">
                                    <span id="certTotalRecords"></span>
                                </div>
                                <div style="display: flex; gap: 0.5rem;">
                                    <button id="certFirstPageBtn" onclick="goToCertPreviousPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                        <i class="fas fa-angle-double-left"></i>
                                    </button>
                                    <button id="certLastPageBtn" onclick="goToCertNextPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                        <i class="fas fa-angle-double-right"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Qualifications Card -->
                <div class="professional-card">
                    <div class="professional-card-header" onclick="toggleCard('qualifications')">
                        <h3 class="professional-card-title">
                            <i class="fas fa-graduation-cap"></i>
                            <span><%=MyBase.GetResourceString("C_Qualifications")%></span>
                        </h3>
                    </div>
                    <div id="card-qualifications" class="professional-card-body">
                        <div class="professional-card-body-actions" style="display: flex; justify-content: flex-end; gap: 10px; align-items: center;">
                            <% If m_blnAddAccess_Qualifications Then %>
                            <a class="btn borderbtn addbtn mr-5" onclick="OpenQualificationModal_Offcanvas()" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="<%=MyBase.GetResourceString("C_AddQualification")%>" style="height: 32px; padding: 4px 10px; font-size: 11.5px; min-width: auto;"><i class="fa fa-plus" aria-hidden="true"></i><%=MyBase.GetResourceString("C_Add")%></a>
                            <%End If %>
                            <% If m_blnDeleteAccess_Qualifications Then %>
                            <a class="btn borderbtn deletebtn mr-5" onclick="DeleteSelectedQualifications()" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="<%=MyBase.GetResourceString("C_DeleteSelected")%>" style="height: 32px; padding: 4px 10px; font-size: 11.5px; min-width: auto;"><%=MyBase.GetResourceString("C_Delete")%></a>
                            <%End If %>
                        </div>
                        <div class="data-table-wrapper">
                            <table class="data-table" id="tblQualifications">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_UniversityName")%></th>
                                        <th><%=MyBase.GetResourceString("C_PassoutYear")%></th>
                                        <th><%=MyBase.GetResourceString("C_Class")%></th>
                                        <th><%=MyBase.GetResourceString("C_Percentage/Points")%></th>
                                        <th><%=MyBase.GetResourceString("C_QualificationName")%></th>
                                        <th style="text-align: center; width: 60px;">
                                            <input type="checkbox" id="selectAllQualifications" title="<%=MyBase.GetResourceString("C_SelectAll")%>" />
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="tblQualificationsBody">
                                    <tr>
                                        <td colspan="6" class="empty-state">
                                            <div><%=MyBase.GetResourceString("C_Nodataavailableintable")%></div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="pagination-container" id="qualPaginationContainer" style="display: none;">
                                <div style="color: #374151; font-size: 11.5px;">
                                    <span id="qualTotalRecords"></span>
                                </div>
                                <div style="display: flex; gap: 0.5rem;">
                                    <button id="qualFirstPageBtn" onclick="goToQualPreviousPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                        <i class="fas fa-angle-double-left"></i>
                                    </button>
                                    <button id="qualLastPageBtn" onclick="goToQualNextPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                        <i class="fas fa-angle-double-right"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Previous Work Experience Card -->
                <div class="professional-card">
                    <div class="professional-card-header" onclick="toggleCard('workexperience')">
                        <h3 class="professional-card-title">
                            <i class="fas fa-briefcase"></i>
                            <span><%=MyBase.GetResourceString("C_PreviousWorkExperience")%></span>
                        </h3>
                    </div>
                    <div id="card-workexperience" class="professional-card-body">
                        <div class="professional-card-body-actions" style="display: flex; justify-content: flex-end; gap: 10px; align-items: center;">
                            <% If m_blnAddAccess_PrevWorkExp Then %>
                            <a class="btn borderbtn addbtn mr-5" onclick="OpenWorkExperienceModal_OffCanvas()" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="<%=MyBase.GetResourceString("C_AddWorkExperience")%>" style="height: 32px; padding: 4px 10px; font-size: 11.5px; min-width: auto;"><i class="fa fa-plus" aria-hidden="true"></i><%=MyBase.GetResourceString("C_Add")%></a>
                            <%End If %>
                            <% If m_blnDeleteAccess_PrevWorkExp Then %>
                            <a class="btn borderbtn deletebtn mr-5" onclick="DeleteSelectedWorkExperience()" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="<%=MyBase.GetResourceString("C_DeleteSelected")%>" style="height: 32px; padding: 4px 10px; font-size: 11.5px; min-width: auto;"><%=MyBase.GetResourceString("C_Delete")%></a>
                            <%End If %>
                        </div>
                        <div class="data-table-wrapper">
                            <table class="data-table" id="tblWorkExperience">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_OrganizationName")%></th>
                                        <th><%=MyBase.GetResourceString("C_PositionHeld")%></th>
                                        <th><%=MyBase.GetResourceString("C_FromDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_TillDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_WorkProfile")%></th>
                                        <th style="text-align: center; width: 60px;">
                                            <input type="checkbox" id="selectAllWorkExperience" title="<%=MyBase.GetResourceString("C_SelectAll")%>" />
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="tblWorkExperienceBody">
                                    <tr>
                                        <td colspan="6" class="empty-state">
                                            <div><%=MyBase.GetResourceString("C_Nodataavailableintable")%></div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="pagination-container" id="workExpPaginationContainer" style="display: none;">
                                <div style="margin-left: auto;"></div>
                                <div style="color: #374151; font-size: 11.5px;">
                                    <span id="workExpTotalRecords"></span>
                                </div>
                                <div style="display: flex; gap: 0.5rem;">
                                    <button id="workExpFirstPageBtn" onclick="goToWorkExpPreviousPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                        <i class="fas fa-angle-double-left"></i>
                                    </button>
                                    <button id="workExpLastPageBtn" onclick="goToWorkExpNextPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                        <i class="fas fa-angle-double-right"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Previous Assignments Card -->
                <div class="professional-card">
                    <div class="professional-card-header" onclick="toggleCard('assignments')">
                        <h3 class="professional-card-title">
                            <i class="fas fa-project-diagram"></i>
                            <span><%=MyBase.GetResourceString("C_PreviousAssignments")%></span>
                        </h3>
                    </div>
                    <div id="card-assignments" class="professional-card-body">
                        <div class="professional-card-body-actions" style="display: flex; justify-content: flex-end; gap: 10px; align-items: center;">
                            <% If m_blnAddAccess_Assignments Then %>
                            <a class="btn borderbtn addbtn mr-5" onclick="OpenAssignmentModal_OffCanvas()" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="<%=MyBase.GetResourceString("C_AddAssignment")%>" style="height: 32px; padding: 4px 10px; font-size: 11.5px; min-width: auto;"><i class="fa fa-plus" aria-hidden="true"></i><%=MyBase.GetResourceString("C_Add")%></a>
                            <%End If %>
                            <% If m_blnDeleteAccess_Assignments Then %>
                            <a class="btn borderbtn deletebtn mr-5" onclick="DeleteSelectedAssignments()" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="<%=MyBase.GetResourceString("C_DeleteSelected")%>" style="height: 32px; padding: 4px 10px; font-size: 11.5px; min-width: auto;"><%=MyBase.GetResourceString("C_Delete")%></a>
                            <%End If %>
                        </div>
                        <div class="data-table-wrapper">
                            <table class="data-table" id="tblAssignments">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_AssignmentName")%></th>
                                        <th><%=MyBase.GetResourceString("C_Duration(Years)")%></th>
                                        <th><%=MyBase.GetResourceString("C_TeamSize")%></th>
                                        <th><%=MyBase.GetResourceString("C_FunctionalRole")%></th>
                                        <th><%=MyBase.GetResourceString("C_CreatedBy")%></th>
                                        <th><%=MyBase.GetResourceString("C_CreatedDate")%></th>
                                        <th style="text-align: center; width: 60px;">
                                            <input type="checkbox" id="selectAllAssignments" title="<%=MyBase.GetResourceString("C_SelectAll")%>" />
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="tblAssignmentsBody">
                                    <tr>
                                        <td colspan="7" class="empty-state">
                                            <div><%=MyBase.GetResourceString("C_Nodataavailableintable")%></div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="pagination-container" id="AssigPaginationContainer" style="display: none;">
                                <div style="margin-left: auto;"></div>
                                  <div style="color: #374151; font-size: 11.5px;">
                                    <span id="AssigTotalRecords"></span>
                                  </div>
                                <div style="display: flex; gap: 0.5rem;">
                                    <button id="AssigFirstPageBtn" onclick="goToAssigPreviousPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                        <i class="fas fa-angle-double-left"></i>
                                    </button>
                                    <button id="AssigLastPageBtn" onclick="goToAssigNextPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                        <i class="fas fa-angle-double-right"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="professional-card">
                    <div class="professional-card-header" onclick="toggleCard('skills')">
                        <h3 class="professional-card-title">
                            <i class="fas fa-code"></i>
                            <span><%=MyBase.GetResourceString("C_Skills")%></span>
                        </h3>
                    </div>
                    <div id="card-skills" class="professional-card-body">
                        <div class="professional-card-body-actions" style="display: flex; justify-content: flex-end; gap: 10px; align-items: center;">
                            <% If m_blnAddAccess_Skills Then %>
                            <a class="btn borderbtn addbtn mr-5" onclick="OpenSkillModal_OffCanvas()" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="<%=MyBase.GetResourceString("C_AddSkill")%>" style="height: 32px; padding: 4px 10px; font-size: 11.5px; min-width: auto;"><i class="fa fa-plus" aria-hidden="true"></i></i><%=MyBase.GetResourceString("C_Add")%></a>
                            <%End If %>
                            <% If m_blnDeleteAccess_Skills Then %>
                            <a class="btn borderbtn deletebtn mr-5" onclick="DeleteSelectedSkills()" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="<%=MyBase.GetResourceString("C_DeleteSelected")%>" style="height: 32px; padding: 4px 10px; font-size: 11.5px; min-width: auto;"><%=MyBase.GetResourceString("C_Delete")%></a>
                            <%End If %>
                        </div>
                        <div class="data-table-wrapper">
                            <table class="data-table" id="tblSkills">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_Skills")%></th>
                                        <th><%=MyBase.GetResourceString("C_Experience(Years)")%></th>
                                        <th><%=MyBase.GetResourceString("C_Experience(Months)")%></th>
                                        <th><%=MyBase.GetResourceString("C_Proficiency")%></th>
                                        <th><%=MyBase.GetResourceString("C_CoreCompetency")%></th>
                                        <th style="text-align: center; width: 60px;">
                                            <input type="checkbox" id="selectAllSkills" title="<%=MyBase.GetResourceString("C_SelectAll")%>" />
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="tblSkillsBody">
                                    <tr>
                                        <td colspan="6" class="empty-state">
                                            <div><%=MyBase.GetResourceString("C_Nodataavailableintable")%></div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="pagination-container" id="skillsPaginationContainer" style="display: none;">
                                <div style="margin-left: auto;"></div>
                                <div style="color: #374151; font-size: 11.5px;">
                                    <span id="skillsTotalRecords"></span>
                                </div>
                                <div style="display: flex; gap: 0.5rem;">
                                    <button id="skillsFirstPageBtn" onclick="goToSkillsPreviousPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                        <i class="fas fa-angle-double-left"></i>
                                    </button>
                                    <button id="skillsLastPageBtn" onclick="goToSkillsNextPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                        <i class="fas fa-angle-double-right"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="action-bar" style="display: none;">
    </div>
    <%Else %>
    <div class="main-container" style="display: flex; align-items: center; justify-content: center; min-height: 100vh; background: #f5f5f5;">
        <div style="text-align: center; padding: 40px; background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
            <i class="fas fa-lock" style="font-size: 48px; color: #dc3545; margin-bottom: 20px;"></i>
            <h3 style="color: #374151; margin-bottom: 10px; font-weight: normal;"><%=MyBase.GetResourceString("C_AccessDenied")%></h3>
            <p style="color: #6c757d;"><%=MyBase.GetResourceString("C_Youdonothavepermissiontoviewthispage.")%></p>
        </div>
    </div>
    <%End If%>
    <!-- Delete confirmation modal -->
    <div class="modal fade custmodal Issuesave_filter" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteConfirmModalLabel"> <%= MyBase.GetResourceString("C_ConfirmDelete") %></h5>
                    <span class="modal-close" data-bs-dismiss="modal" onclick="CancelConfirmation()">&times;</span>
                </div>
                <div class="modal-body">
                    <p id="CheckModal"><%= MyBase.GetResourceString("C_Areyousureyouwanttodeletethisrecord?") %> </p>
                    <div class="mt-3 d-flex justify-content-end">
                        <a class="btn borderbtn me-2" onclick="DeleteConfirmation()"><%= MyBase.GetResourceString("C_OK") %> </a>
                        <a class="btn btnyellow ms-2" onclick="CancelConfirmation()"><%= MyBase.GetResourceString("C_Cancel") %> </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="certificationModal_OffCanvas" aria-labelledby="certificationOffcanvasLabel">
        <div class="graybg container-fluid py-1 mb-2">
            <div class="row align-items-center">
                <div class="col-sm-10"><h5 class="pgtitle mb-0"><%=MyBase.GetResourceString("C_CertificationDetails")%></h5> </div>
                <div class="col-sm-2 text-end">
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 text-end mb-2" style="white-space: nowrap;">
                <% If m_blnAddAccess_Certification = True Then %>
                <button type="button" class="btn-primary me-2" onclick="SaveCertificationFromModal()"><%=MyBase.GetResourceString("C_Save")%></button>
                <% End If %>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas"><%=MyBase.GetResourceString("C_Cancel")%></button>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-sm-12 text-end">
                <label class="form-label "><%=MyBase.GetResourceString("C_Mandatory")%></label>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-sm-10 mx-auto">
                <div class="info-row" style="border-bottom: none; padding: 3px 60px;">
                    <div class="info-label" style="width: 150px; margin-right: 8px;"><%= MyBase.GetResourceString("C_CertificationName") %><span class="text-danger">*</span> </div>
                    <div class="info-value">
                            <%CommonFunctions.HTMLControls.DrawComboBox("certificationNameFilter", "usp_Whizible2_Sel_tbl_PM_Certifications_MyProfile",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                        </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-sm-10 mx-auto">
                <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                    <div class="info-label" style="width: 150px; margin-right: 8px;"> <%= MyBase.GetResourceString("C_CertificationDate") %><span class="text-danger">*</span>  </div>
                        <% CommonFunctions.HTMLControls.DrawTextBox("modalCertificationDate", "modalCertificationDate", "form-control date-input", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                        <span class="input-group-btn"> <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt date-picker-icon"></i></button></span>
                </div>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-sm-10 mx-auto">
                <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                    <div class="info-label" style="width: 150px; margin-right: 8px;"> <%= MyBase.GetResourceString("C_ValidUpTo") %></div>
                     <% CommonFunctions.HTMLControls.DrawTextBox("modalValidUpTo", "modalValidUpTo", "form-control date-input", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                      <span class="input-group-btn"> <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt date-picker-icon"></i></button></span>
                </div>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-sm-10 mx-auto">
                <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                    <div class="info-label" style="width: 150px; margin-right: 8px;"> <%= MyBase.GetResourceString("C_Score") %>
                    </div>
                    <div class="info-value">
                        <div style="width: 60%;">
                             <%CommonFunctions.HTMLControls.DrawTextBox("txtmodalScore", "txtmodalScore", "form-control", maxLength:=8)%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-sm-10 mx-auto">
                <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                    <div class="info-label" style="width: 150px; margin-right: 8px;">
                        <%= MyBase.GetResourceString("C_OutOf") %>
                    </div>
                    <div class="info-value">
                        <div style="width: 60%;">
                             <%CommonFunctions.HTMLControls.DrawTextBox("txtmodalScoreOutOf", "txtmodalScoreOutOf", "form-control", maxLength:=8)%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="qualificationModal_OffCanvas" aria-labelledby="qualificationOffcanvasLabel">
        <div class="graybg container-fluid py-1 mb-2">
            <div class="row align-items-center">
                <div class="col-sm-10">
                    <h5 class="pgtitle mb-0">
                        <%=MyBase.GetResourceString("C_QualificationDetails")%>
                    </h5>
                </div>
                <div class="col-sm-2 text-end">
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 text-end mb-2" style="white-space: nowrap;">
                <% If m_blnAddAccess_Qualifications = True Then %>
                <button type="button" class="btn-primary me-2" onclick="SaveQualificationFromModal()"><%=MyBase.GetResourceString("C_Save")%></button>
                <% End If %>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas"><%=MyBase.GetResourceString("C_Cancel")%></button>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-sm-12 text-end">
                <label class="form-label">
                    <%=MyBase.GetResourceString("C_Mandatory")%>
                </label>
            </div>
        </div>
        <form id="qualificationForm">
            <div class="row mt-3">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label required">
                            <%=MyBase.GetResourceString("C_QualificationName")%>
                            <span class="text-danger">*</span>
                        </div>
                        <div class="info-value w-60">
                            <%CommonFunctions.HTMLControls.DrawComboBox("modalQualificationName", "usp_Whizible2_sel_tbl_PM_Qualifications_New", ,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'", ,, ) %>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label required">
                            <%=MyBase.GetResourceString("C_UniversityName")%>
                            <span class="text-danger">*</span>
                        </div>
                        <div class="info-value w-60">
                                     <%CommonFunctions.HTMLControls.DrawTextBox("modalUniversityBoard", "modalUniversityBoard", "form-control", maxLength:=200)%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label required">
                            <%=MyBase.GetResourceString("C_PassoutYear")%>
                            <span class="text-danger">*</span>
                        </div>
                        <div class="info-value">
                           <%CommonFunctions.HTMLControls.DrawComboBox("modalPassingYear", "usp_Whizible2_sel_tbl_PM_Years_New",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'", ,, ) %>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label"> <%=MyBase.GetResourceString("C_Class")%>  </div>
                        <div class="info-value w-60">
                              <%CommonFunctions.HTMLControls.DrawTextBox("modalClass", "modalClass", "form-control", maxLength:=50)%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label"><%=MyBase.GetResourceString("C_Percentage/Points")%></div>
                        <div class="info-value w-60">
                             <%CommonFunctions.HTMLControls.DrawTextBox("modalPercentageGrade", "modalPercentageGrade", "form-control", maxLength:=15)%>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="workExperienceModal_OffCanvas" aria-labelledby="workExperienceModalLabel">
        <div class="graybg container-fluid py-1 mb-2">
            <div class="row align-items-center">
                <div class="col-sm-10">
                    <h5 class="pgtitle mb-0"> <%=MyBase.GetResourceString("C_WorkExperienceDetails")%></h5>
                </div>
                <div class="col-sm-2 text-end">
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 text-end mb-2" style="white-space: nowrap;">
                <% If m_blnAddAccess_PrevWorkExp = True Then %>
                <button type="button" class="btn-primary me-2" onclick="SaveWorkExperienceFromModal()"><%=MyBase.GetResourceString("C_Save")%></button>
                <% End If %>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas"><%=MyBase.GetResourceString("C_Cancel")%> </button>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-sm-12 text-end">
                <label class="form-label"><%=MyBase.GetResourceString("C_Mandatory")%> </label>
            </div>
        </div>
        <form id="workExperienceForm">
            <div class="row mt-3">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;">
                            <%=MyBase.GetResourceString("C_OrganizationName")%> <span class="text-danger">*</span>
                        </div>
                        <div class="info-value">
                            <div style="width: 60%;">
                                  <%CommonFunctions.HTMLControls.DrawTextBox("modalOrganizationName", "modalOrganizationName", "form-control", maxLength:=100)%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;">
                            <%=MyBase.GetResourceString("C_PositionHeld")%> <span class="text-danger">*</span>
                        </div>
                        <div class="info-value">
                            <div style="width: 60%;">
                                 <%CommonFunctions.HTMLControls.DrawTextBox("modalPositionHeld", "modalPositionHeld", "form-control", maxLength:=100)%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;">
                            <%=MyBase.GetResourceString("C_FromDate")%><span class="text-danger">*</span>
                        </div>
                          <% CommonFunctions.HTMLControls.DrawTextBox("modalFromDate", "modalFromDate", "form-control date-input", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                            <span class="input-group-btn"> <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt date-picker-icon"></i></button></span>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;">
                            <%=MyBase.GetResourceString("C_TillDate")%><span class="text-danger">*</span>
                        </div>
                        <% CommonFunctions.HTMLControls.DrawTextBox("modalTillDate", "modalTillDate", "form-control date-input", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                         <span class="input-group-btn"> <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt date-picker-icon"></i></button></span>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;">
                            <%=MyBase.GetResourceString("C_WorkProfile")%>
                        </div>
                        <div class="info-value">
                            <div style="width: 60%;">
                                <%CommonFunctions.HTMLControls.DrawComboBox("modalWorkProfile", "usp_Whizible2_sel_WorkProfile_New", ,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;">
                            <%=MyBase.GetResourceString("C_Summary")%>
                        </div>
                        <div class="info-value">
                            <div style="width: 60%;">
                                <textarea id="modalSummary" class="form-control" rows="4" maxlength="400" placeholder="<%=MyBase.GetResourceString("A_Enterworksummary")%>" style="height: 52px; width: 250px; resize: vertical;"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="assignmentModal_OffCanvas" aria-labelledby="assignmentModalLabel">
        <div class="graybg container-fluid py-1 mb-2">
            <div class="row align-items-center">
                <div class="col-sm-10">
                    <h5 class="pgtitle mb-0" id="assignmentModalLabel"><%=MyBase.GetResourceString("C_AssignmentDetails")%></h5>
                </div>
                <div class="col-sm-2 text-end">
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 text-end mb-2">
                <% If m_blnAddAccess_Assignments = True Or m_blnEditAccess_Assignments = True Then %>
                <button type="button" class="btn btn-primary me-2" onclick="SaveAssignmentFromModal()"><%=MyBase.GetResourceString("C_Save")%> </button>
                <% End If %>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas">
                    <%=MyBase.GetResourceString("C_Cancel")%>
                </button>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-sm-12 text-end">
                <label class="form-label">
                    <%=MyBase.GetResourceString("C_Mandatory")%>
                </label>
            </div>
        </div>
    <div class="offcanvas-body">
    <form id="assignmentForm">
        <input type="hidden" id="hdnAssignmentID" />
        <div class="row mt-3 align-items-center">
            <div class="col-sm-4 text-end">
                <label for="modalAssignmentName"><%=MyBase.GetResourceString("C_AssignmentName")%><span class="text-danger">*</span></label>
            </div>
            <div class="col-sm-8">
                   <%CommonFunctions.HTMLControls.DrawTextBox("modalAssignmentName", "modalAssignmentName", "form-control", maxLength:=50)%>
            </div>
        </div>
        <div class="row mt-3 align-items-center">
            <div class="col-sm-4 text-end">
                <label for="modalDuration"><%=MyBase.GetResourceString("C_Duration(Years)")%> <span class="text-danger">*</span></label>
            </div>
            <div class="col-sm-8">
                   <%CommonFunctions.HTMLControls.DrawTextBox("modalDuration", "modalDuration", "form-control", maxLength:=15)%>
            </div>
        </div>
        <div class="row mt-3 align-items-center">
            <div class="col-sm-4 text-end">
                <label for="modalTeamSize"><%=MyBase.GetResourceString("C_TeamSize")%> <span class="text-danger">*</span></label>
            </div>
            <div class="col-sm-8">
                 <%CommonFunctions.HTMLControls.DrawTextBox("modalTeamSize", "modalTeamSize", "form-control", maxLength:=15)%>
            </div>
        </div>
        <div class="row mt-3 align-items-center">
            <div class="col-sm-4 text-end">
                <label for="modalFunctionalRole"><%=MyBase.GetResourceString("C_FunctionalRole")%> <span class="text-danger">*</span></label>
            </div>
            <div class="col-sm-8">
                   <%CommonFunctions.HTMLControls.DrawTextBox("modalFunctionalRole", "modalFunctionalRole", "form-control", maxLength:=50)%>
            </div>
        </div>
        <div class="row mt-3 align-items-start">
            <div class="col-sm-4 text-end">
                <label for="modalEnvironment"><%=MyBase.GetResourceString("C_Environment")%></label>
            </div>
            <div class="col-sm-8">
                <textarea id="modalEnvironment" class="form-control" rows="10"   maxlength="200" placeholder="<%=MyBase.GetResourceString("A_Enterenvironment")%>" style="height: 75px;" oninput="this.value = this.value.replace(/\s+/g, ' ')"></textarea>
            </div>
        </div>
        <div class="row mt-3 align-items-start">
            <div class="col-sm-4 text-end">
                <label for="modalAssignmentSkills"><%=MyBase.GetResourceString("C_Skills")%></label>
            </div>
            <div class="col-sm-8">
                <textarea id="modalAssignmentSkills" class="form-control" rows="10"   maxlength="200" placeholder="<%=MyBase.GetResourceString("A_Enterassignmentskills")%>" style="height: 75px;" oninput="this.value = this.value.replace(/\s+/g, ' ')"></textarea>
            </div>
        </div>
        <div class="row mt-3 align-items-start">
            <div class="col-sm-4 text-end">
                <label for="modalDescription"><%=MyBase.GetResourceString("C_Description")%></label>
            </div>
            <div class="col-sm-8">
                <textarea id="modalDescription" class="form-control" rows="10"   maxlength="200" placeholder="<%=MyBase.GetResourceString("A_Enterdescription")%>" style="height: 75px;" oninput="this.value = this.value.replace(/\s+/g, ' ')"></textarea>
            </div>
        </div>
        <div class="row mt-3 align-items-start">
            <div class="col-sm-4 text-end">
                <label for="CreatedBy"><%=MyBase.GetResourceString("C_CreatedBy")%> </label>
            </div>
            <div class="col-sm-8">
                <%--   <%CommonFunctions.HTMLControls.DrawTextBox("CreatedBy", "CreatedBy", "clsTextBoxReadOnly EmpNameInput form-control", maxLength:=50)%>--%>
                <input type="Textbox" name="CreatedBy" id="CreatedBy" class="clsTextBoxReadOnly EmpNameInput form-control" style="text-align: left; width: 250PX;" readonly="" maxlength="50" disabled="">
            </div>
        </div>
        <div class="row mt-3 align-items-center">
          <div class="col-sm-4 text-end">
                <label for="modalCreatedDate"><%=MyBase.GetResourceString("C_CreatedDate")%></label>
            </div>
                 <div class="input-group date-fixed-width">
                       <% CommonFunctions.HTMLControls.DrawTextBox("modalCreatedDate", "modalCreatedDate", "form-control date-input", , ,,,, ,,,, "readonly='readonly' onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                       <span class="input-group-btn"> <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt date-picker-icon"></i></button></span>
<%--                  <input type="Textbox" name="modalCreatedDate" id="modalCreatedDate" class="clsTextBoxReadOnly EmpNameInput form-control" style="text-align: left; width: 250PX;"  disabled="">--%>
                </div>
            </div>
       </form>
    </div>
</div>
    <!-- Skill Offcanvas -->
    <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="skillModel_Offcanvas" aria-labelledby="skillOffcanvasLabel">
        <div class="graybg container-fluid py-1 mb-2">
            <div class="row align-items-center">
                <div class="col-sm-10">
                    <h5 class="pgtitle mb-0" id="skillOffcanvasLabel">  <%=MyBase.GetResourceString("C_SkillDetails")%> </h5>
                </div>
                <div class="col-sm-2 text-end">
                    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 text-end mb-2">
                <% If m_blnAddAccess_Skills = True Then %>
                <button type="button" class="btn btn-primary me-2" onclick="SaveSkillFromModal()">
                    <%=MyBase.GetResourceString("C_Save")%>
                </button>
                <% End If %>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas">
                    <%=MyBase.GetResourceString("C_Cancel")%>
                </button>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-sm-12 text-end">
                <label class="form-label"> <%=MyBase.GetResourceString("C_Mandatory")%></label>
            </div>
        </div>
        <div class="offcanvas-body">
            <form id="skillForm">
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row">
                            <div class="info-label required"><%=MyBase.GetResourceString("C_Skills")%><span class="text-danger">*</span></div>
                            <div class="info-value">
                                <div style="width: 60%;">
                                    <%CommonFunctions.HTMLControls.DrawComboBox("modalSkills", "usp_Sel_tbl_PM_Tools_PopulateCombo_New " & If(Session("intUserID") Is Nothing, 0, Session("intUserID")),,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row">
                           <div class="info-label"><%=MyBase.GetResourceString("C_Experience(Years)")%></div>
                            <div class="info-value">
                                <div style="width: 60%;">
                                <%CommonFunctions.HTMLControls.DrawComboBox("modalExperienceYears", "usp_Sel_GetExperienceDropdown",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                            </div>
                          </div>
                        </div>
                    </div>
                 </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row">
                            <div class="info-label"> <%=MyBase.GetResourceString("C_Experience(Months)")%></div>
                            <div class="info-value">
                                 <div style="width: 60%;">
                                <%CommonFunctions.HTMLControls.DrawComboBox("modalExperienceMonths", "usp_Sel_GetExperienceMonthsDropdown",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                            </div>
                           </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row">
                            <div class="info-label"> <%=MyBase.GetResourceString("C_Proficiency")%> </div>
                            <div class="info-value">
                                <div style="width: 60%;">
                                    <%CommonFunctions.HTMLControls.DrawComboBox("modalProficiency", "usp_Whizible2_sel_ParameterID_Value_New",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row">
                            <div class="info-label"><%=MyBase.GetResourceString("C_CoreCompetency")%></div>
                            <div class="info-value">
                                <div class="form-check pt-2">
                                    <input type="checkbox" id="modalCoreCompetency" class="form-check-input" />
                                    <label class="form-check-label ms-2 fw-normal" for="modalCoreCompetency">
                                        <%=MyBase.GetResourceString("C_MarkasCoreCompetency")%>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row">
                            <div class="info-label"> <%=MyBase.GetResourceString("C_Notes")%> </div>
                            <div class="info-value">
                                <textarea id="modalSkillNotes" class="form-control textareaSkill" rows="2"  maxlength="200" placeholder="<%=MyBase.GetResourceString("A_Enteradditionalnotes")%>" oninput="this.value = this.value.replace(/\s+/g, ' ')"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- Update Skill Offcanvas -->
    <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="UpdateSkillModal_OffCanvas" aria-labelledby="updateSkillOffcanvasLabel">
        <div class="graybg container-fluid py-1 mb-2">
            <div class="row align-items-center">
                <div class="col-sm-10">
                    <h5 class="pgtitle mb-0" id="updateSkillOffcanvasLabel"> <%=MyBase.GetResourceString("C_SkillDetails")%> </h5>
                 </div>
                <div class="col-sm-2 text-end">
                    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 text-end mb-2">
                <% If m_blnEditAccess_Skills = True Then %>
                <button type="button" class="btn btn-primary me-2" onclick="UpdateSaveSkillFromModal()"> <%=MyBase.GetResourceString("C_Save")%></button>
                <% End If %>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas"> <%=MyBase.GetResourceString("C_Cancel")%></button>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-sm-12 text-end">
                <label class="form-label"><%=MyBase.GetResourceString("C_Mandatory")%> </label>
            </div>
        </div>
        <div class="offcanvas-body">
            <form id="UpdateSkillForm">
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row">
                            <div class="info-label required"> <%=MyBase.GetResourceString("C_Skills")%><span class="text-danger">*</span> </div>
                            <div class="info-value">
                                <div style="width: 60%;">
                                 <%CommonFunctions.HTMLControls.DrawComboBox("UpdateModalSkill", "usp_Sel_tbl_PM_Tools_PopulateCombo_New " & If(Session("intUserID") Is Nothing, 0, Session("intUserID")),,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row">
                            <div class="info-label"><%=MyBase.GetResourceString("C_Proficiency")%> </div>
                            <div class="info-value">
                                <div style="width: 60%;">
                                    <%CommonFunctions.HTMLControls.DrawComboBox("UpdateModalProficiency", "usp_Whizible2_sel_ParameterID_Value_New",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row">
                            <div class="info-label"><%=MyBase.GetResourceString("C_Experience(Years)")%></div>
                            <div class="info-value">
                                <div style="width: 60%;">
                                    <%CommonFunctions.HTMLControls.DrawComboBox("UpdateModalExperienceYears", "usp_Sel_GetExperienceDropdown",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row">
                            <div class="info-label"><%=MyBase.GetResourceString("C_Experience(Months)")%> </div>
                            <div class="info-value">
                                <div style="width: 60%;">
                                    <%CommonFunctions.HTMLControls.DrawComboBox("UpdateModalExperienceMonths", "usp_Sel_GetExperienceMonthsDropdown",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row">
                            <div class="info-label"> <%=MyBase.GetResourceString("C_CoreCompetency")%></div>
                            <div class="info-value">
                                <div class="form-check pt-2">
                                    <input type="checkbox" id="UpdateModalCoreCompetency" class="form-check-input" />
                                    <label class="form-check-label ms-2 fw-normal" for="UpdateModalCoreCompetency">
                                        <%=MyBase.GetResourceString("C_MarkasCoreCompetency")%>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row">
                            <div class="info-label"><%=MyBase.GetResourceString("C_Notes")%></div>
                            <div class="info-value">
                                <textarea id="UpdateModalSkillNotes" class="form-control textareaSkill" rows="2"  maxlength="200" placeholder="<%=MyBase.GetResourceString("A_Enteradditionalnotes")%>" oninput="this.value = this.value.replace(/\s+/g, ' ')"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="hdnSkillID" />
            </form>
        </div>
    </div>
    <!-- Certification update Offcanvas-->
    <div class="Update offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="UpdateCertificationModal_OffCanvas" aria-labelledby="certificationOffcanvasLabel">
        <div class="graybg container-fluid py-1 mb-2">
            <div class="row align-items-center">
                <div class="col-sm-10">
                    <h5 class="pgtitle mb-0" id="certificationOffcanvasLabel"><%=MyBase.GetResourceString("C_CertificationDetails")%></h5>
                </div>
                <div class="col-sm-2 text-end">
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 text-end mb-2">
                <% If m_blnEditAccess_Certification = True Then %>
                <button type="button" class="btn btn-primary me-2" onclick="SaveUpdatedCertificationFromModal()"><%=MyBase.GetResourceString("C_Save")%></button>
                <% End If %>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas"> <%=MyBase.GetResourceString("C_Cancel")%></button>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-sm-12 text-end">
                <label class="form-label"><%=MyBase.GetResourceString("C_Mandatory")%></label>
            </div>
        </div>
        <div class="offcanvas-body">
            <form id="updateCertificationName">
                <div class="row mt-3">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row" style="border-bottom: none; padding: 3px 60px;">
                            <div class="info-label" style="width: 150px; margin-right: 8px;">
                                <%=MyBase.GetResourceString("C_CertificationName")%> <span class="text-danger">*</span>
                            </div>
                            <div class="info-value">
                                <%CommonFunctions.HTMLControls.DrawComboBox("updateCertificationForm", "usp_Whizible2_Sel_tbl_PM_Certifications_MyProfile",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                            <div class="info-label" style="width: 150px; margin-right: 8px;">
                                <%= MyBase.GetResourceString("C_CertificationDate") %> <span class="text-danger">*</span>
                            </div>
                              <% CommonFunctions.HTMLControls.DrawTextBox("updateCertificationDate", "updateCertificationDate", "form-control date-input", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                            <span class="input-group-btn"> <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt date-picker-icon"></i></button></span>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                            <div class="info-label" style="width: 150px; margin-right: 8px;">
                                <%=MyBase.GetResourceString("C_ValidUpTo")%>
                            </div>
                             <% CommonFunctions.HTMLControls.DrawTextBox("updateValidUpTo", "updateValidUpTo", "form-control date-input", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                            <span class="input-group-btn"> <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt date-picker-icon"></i></button></span>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                            <div class="info-label" style="width: 150px; margin-right: 8px;">
                                <%=MyBase.GetResourceString("C_Score")%>
                            </div>
                            <div class="info-value">
                                <div style="width: 60%;">
                                     <%CommonFunctions.HTMLControls.DrawTextBox("updateScore", "updateScore", "form-control", maxLength:=8)%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-10 mx-auto">
                        <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                            <div class="info-label" style="width: 150px; margin-right: 8px;">
                                <%=MyBase.GetResourceString("C_OutOf")%>
                            </div>
                            <div class="info-value">
                                <div style="width: 60%;">
                                     <%CommonFunctions.HTMLControls.DrawTextBox("updateScoreOutOf", "updateScoreOutOf", "form-control", maxLength:=8)%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <input type="hidden" id="updateEmployeeCertificationID" />
            </form>
        </div>
    </div>
    <!--   Update Qualification -->
    <div class="Update offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="UpdateQualificationModel_Offcanvas" aria-labelledby="qualificationOffcanvasLabel">
        <div class="graybg container-fluid py-1 mb-2">
            <div class="row align-items-center">
                <div class="col-sm-10">
                    <h5 class="pgtitle mb-0">  <%=MyBase.GetResourceString("C_QualificationDetails")%></h5>
                </div>
                <div class="col-sm-2 text-end">
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 text-end mb-2">
                <% If m_blnEditAccess_Qualifications = True Then %>
                <button type="button" class="btn btn-primary me-2" onclick="SaveUpdateQualificationModal()"> <%=MyBase.GetResourceString("C_Save")%></button>
                <% End If %>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas"> <%=MyBase.GetResourceString("C_Cancel")%> </button>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-sm-12 text-end">
                <label class="form-label"><%=MyBase.GetResourceString("C_Mandatory")%> </label>
            </div>
        </div>
        <form id="UpdatequalificationForm">
            <div class="row mt-3">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label required"><%=MyBase.GetResourceString("C_QualificationName")%><span class="text-danger">*</span>
                        </div>
                        <div class="info-value w-60">
                            <%CommonFunctions.HTMLControls.DrawComboBox("UpdateModalQualificationName", "usp_Whizible2_sel_tbl_PM_Qualifications_New",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,, ) %>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label required"><%=MyBase.GetResourceString("C_UniversityName")%> <span class="text-danger">*</span> </div>
                        <div class="info-value w-60">
                                  <%CommonFunctions.HTMLControls.DrawTextBox("UpdateModalUniversityBoard", "UpdateModalUniversityBoard", "form-control", maxLength:=200)%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label required"><%=MyBase.GetResourceString("C_PassoutYear")%><span class="text-danger">*</span> </div>
                        <div class="info-value" >
                             <%CommonFunctions.HTMLControls.DrawComboBox("UpdateModalPassingYear", "usp_Whizible2_sel_tbl_PM_Years_New",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'", ,, ) %>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label"> <%=MyBase.GetResourceString("C_Class")%></div>
                        <div class="info-value w-60">
                             <%CommonFunctions.HTMLControls.DrawTextBox("UpdateModalClass", "UpdateModalClass", "form-control", maxLength:=50)%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label"> <%=MyBase.GetResourceString("C_Percentage/Points")%></div>
                        <div class="info-value w-60">
                              <%CommonFunctions.HTMLControls.DrawTextBox("UpdateModalPercentageGrade", "UpdateModalPercentageGrade", "form-control", maxLength:=15)%>
                        </div>
                    </div>
                </div>
            </div>
            <input type="hidden" id="hdnEmployeeQualificationID" />
        </form>
    </div>
    <!-- Update Work Experience Offcanvas -->
    <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="UpdateWorkExperienceModal_OffCanvas" aria-labelledby="workExperienceModalLabel">
        <div class="graybg container-fluid py-1 mb-2">
            <div class="row align-items-center">
                <div class="col-sm-10">
                    <h5 class="pgtitle mb-0"> <%=MyBase.GetResourceString("C_WorkExperienceDetails")%> </h5>
                </div>
                <div class="col-sm-2 text-end">
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 text-end mb-2">
                <% If m_blnEditAccess_PrevWorkExp = True Then %>
                <button type="button" class="btn btn-primary me-2" onclick="UpdateSaveWorkExperienceModal()"> <%=MyBase.GetResourceString("C_Save")%> </button>
                <% End If %>
                <button type="button" class="btn btn-secondary"data-bs-dismiss="offcanvas"><%=MyBase.GetResourceString("C_Cancel")%></button>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-sm-12 text-end">
                <label class="form-label"> <%=MyBase.GetResourceString("C_Mandatory")%></label>
            </div>
        </div>
        <form id="UpdateWorkExperienceForm">
            <div class="row mt-3">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;">
                            <%=MyBase.GetResourceString("C_OrganizationName")%>
                            <span class="text-danger">*</span>
                        </div>
                        <div class="info-value">
                            <div style="width: 60%;">
                                 <%CommonFunctions.HTMLControls.DrawTextBox("UpdateModalOrganizationName", "UpdateModalOrganizationName", "form-control", maxLength:=100)%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;">
                            <%=MyBase.GetResourceString("C_PositionHeld")%>
                            <span class="text-danger">*</span>
                        </div>
                        <div class="info-value">
                            <div style="width: 60%;">
                              <%CommonFunctions.HTMLControls.DrawTextBox("UpdateModalPositionHeld", "UpdateModalPositionHeld", "form-control", maxLength:=100)%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
         <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;">
                            <%=MyBase.GetResourceString("C_FromDate")%><span class="text-danger">*</span>
                        </div>
                         <% CommonFunctions.HTMLControls.DrawTextBox("UpdateModalFromDate", "UpdateModalFromDate", "form-control date-input", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                         <span class="input-group-btn"> <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt date-picker-icon"></i></button></span>
                    </div>
                </div>
            </div>
           <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;">
                            <%=MyBase.GetResourceString("C_TillDate")%><span class="text-danger">*</span>
                        </div>
                         <% CommonFunctions.HTMLControls.DrawTextBox("UpdateModalTillDate", "UpdateModalTillDate", "form-control date-input", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                         <span class="input-group-btn"> <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt date-picker-icon"></i></button></span>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;">
                            <%=MyBase.GetResourceString("C_WorkProfile")%>
                        </div>
                        <div class="info-value">
                            <div style="width: 60%;">
                                <%CommonFunctions.HTMLControls.DrawComboBox("UpdatemodalWorkProfile", "usp_Whizible2_sel_WorkProfile_New",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-sm-10 mx-auto">
                    <div class="info-row" style="border-bottom: none; padding: 4px 60px;">
                        <div class="info-label" style="width: 150px; margin-right: 8px;">
                            <%=MyBase.GetResourceString("C_Summary")%>
                        </div>
                        <div class="info-value">
                            <div style="width: 60%;">
                                <textarea id="UpdateModalSummary" class="form-control" rows="4" maxlength="400"  placeholder="<%=MyBase.GetResourceString("A_Enterworksummary")%>" style="height: 52px; width: 250px; resize: vertical;"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <input type="hidden" id="hdnWorkExperienceID" />
        </form>
    </div>

    <script type="text/javascript">
        (function () {
            'use strict';
            function removeProblematicCSS() {
                var links = document.querySelectorAll('link[rel="stylesheet"]');
                links.forEach(function (link) {
                    if (link.href &&
                        (link.href.includes('StyleSheetChanakya_Blue.css') ||
                            link.href.includes('StyleSheetChanakya'))) {
                        link.remove();
                    }
                });
            }
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', removeProblematicCSS);
            } else {
                removeProblematicCSS();
            }
        })();

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString()%>';
        if (typeof alertify !== 'undefined') {
            alertify.set('notifier', 'position', 'top-right');
        }
        var LoginType = '<%= Session("LoginType") %>';
        var UserId = '<%= If(Session("intUserID") Is Nothing, 0, Session("intUserID")) %>';
        var UserName = '<%= Session("strUserName") %>';
        var defaultProjectID = 0;
        <% If Not Session("intProjectID") Is Nothing Then %>
        defaultProjectID = <%= Session("intProjectID") %>;
        <% End If %>

        var specialCharactersList = '<%= System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString %>';

        var escapedSpecialChars = specialCharactersList.replace(/[\]\\^-]/g, function(match) {
            return '\\' + match;
        });
        var invalidCharsPattern = new RegExp('[' + escapedSpecialChars + ']');
        var strPageName = "MyProfile.aspx";
  
        var blnViewAccess = <%= If(m_blnViewAccess, "true", "false") %>;
        var blnAddAccess = <%= If(m_blnAddAccess, "true", "false") %>;
        var blnEditAccess = <%= If(m_blnEditAccess, "true", "false") %>;
        var blnDeleteAccess = <%= If(m_blnDeleteAccess, "true", "false") %>;

        // Pagination variables for Certifications
        var certCurrentPage = 1;
        var certPageSize = 5;
        var certTotalPages = 1;
        var certTotalRecords = 0; 
        var certAllCertifications = [];
        var selectedCertificationIDs = []; 

        var qualCurrentPage = 1;
        var qualPageSize = 5;
        var qualTotalPages = 1;
        var qualTotalRecords = 0; 
        var selectedQualificationIDs = []; 

        var workExpCurrentPage = 1;
        var workExpPageSize = 5;
        var workExpTotalPages = 1;
        var workExpTotalRecords = 0; 
        var selectedWorkExperienceIDs = []; 

        var assignmentsCurrentPage = 1;
        var assignmentsPageSize = 5;
        var assignmentsTotalPages = 1;
        var assignmentsTotalRecords = 0;
        var selectedAssignmentIDs = []; 
        var assignmentModeFlag = 1; 

        var skillsCurrentPage = 1;
        var skillsPageSize = 5;
        var skillsTotalPages = 1;
        var skillsTotalRecords = 0; 
        var selectedSkillIDs = []; 

        // Handle image loading errors (404, missing file, etc.)
        function handleImageError(img) {
            img.onerror = null; 
            img.src = '../../../Images/Photo/no-photo.png';
        }

        function formatDateFromAPI(dateString) {
            if (!dateString) {
                return '';
            }
            try {
                var date = new Date(dateString);
                date.setDate(date.getDate() + 1);
                var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                var day = date.getDate();
                var month = monthNames[date.getMonth()];
                var year = date.getFullYear();

                return day + ' ' + month + ' ' + year;
            } catch (e) {
                console.error('Error parsing date:', e);
                return '';
            }
        }

        // Initialize date pickers and tabs
        $(document).ready(function () {
    
            // Initialize all datepickers together
            $('#dtBirthDate, #dtDateOfIssue, #dtExpiryDate').datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '-100:+10',
                dateFormat: 'dd M yy',
                showOn: 'focus',
                onClose: function () {
                    $(':focus').blur();
                }
            });

            $('#modalCertificationDate, #modalValidUpTo, #updateCertificationDate, #updateValidUpTo, \ #modalFromDate, #modalTillDate, #UpdateModalFromDate, #UpdateModalTillDate,  \#dtWorkExpFromDate, #dtWorkExpToDate')
                .datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '-100:+10',
                dateFormat: 'dd M yy',
                showOn: 'focus',
                onClose: function () {
                    $(':focus').blur();
                }
                });

            $(function () {
                $('#modalCreatedDate, #UpdatemodalCreatedDate')
                    .datepicker({
                        changeMonth: true,
                        changeYear: true,
                        yearRange: '-100:+10',
                        dateFormat: 'dd M yy',
                        beforeShow: function () {
                            return false;   
                        }
                    })
                    .attr('readonly', true)
                    .on('focus click', function (e) {
                        e.preventDefault();
                        $(this).blur();
                    });

            });


            $(document).on('change', '#certificationDrop', function () {
                var selectedName = $(this).find('option:selected').text().trim();
                var selectedValue = $(this).val();
                if (!selectedName || !selectedValue || selectedName === '-- Select Certification --' || selectedValue === '' || selectedValue === '0') {
                    $('#tblCertificationsBody tr').each(function () {
                        if ($(this).find('.empty-state').length) {
                            $(this).hide();
                        } else {
                            $(this).show();
                        }
                    });
                    return;
                }
                var hasVisibleRows = false;
                $('#tblCertificationsBody tr').each(function () {
                    var $row = $(this);
                    if ($row.find('.empty-state').length) {
                        $row.hide();
                        return;
                    }
                    var certName =
                        $row.find('td:first a').text().trim() ||
                        $row.find('td:first').text().trim();
                    var isMatch = certName === selectedName;
                    $row.toggle(isMatch);
                    if (isMatch) hasVisibleRows = true;
                });
                if (!hasVisibleRows) {
                    var $tbody = $('#tblCertificationsBody');
                    if ($tbody.find('.empty-state').length === 0) {
                        $tbody.append('<tr><td colspan="4" class="empty-state"><div><%=MyBase.GetResourceString("C_Nodataavailableintable")%></div></td></tr>');
                    } else {
                        $tbody.find('.empty-state').closest('tr').show();
                    }
                }
            });

            window.initializeModalDatePickers = function (modalId) {
                var $modal = $('#' + modalId);
                if ($modal.length === 0) return;
                var $dateInputs = $modal.find('input.date-input, input[placeholder*="MM/DD/YYYY"], input[placeholder*="mm/dd/yyyy"]');
                $modal.find('input[type="text"]').each(function () {
                    var $input = $(this);
                    var id = $input.attr('id') || '';
                    if ((id.indexOf('date') !== -1 || id.indexOf('Date') !== -1) &&
                        $dateInputs.filter(function () { return this === $input[0]; }).length === 0) {
                        $dateInputs = $dateInputs.add($input);
                    }
                });

                if ($dateInputs.length > 0) {
                    $dateInputs.datepicker({
                        changeMonth: true,
                        changeYear: true,
                        yearRange: '-100:+10',
                        dateFormat: 'mm/dd/yy',
                        showOn: 'focus',
                        beforeShow: function (input, inst) {
                            setTimeout(function () {
                                inst.dpDiv.css({
                                    'z-index': 10050
                                });
                            }, 0);
                        },
                        onClose: function () {
                            $(':focus').blur();
                        }
                    });
                    $dateInputs.off('click focus').on('click focus', function () {
                        $(this).datepicker('show');
                    });
                }

                // Add click handler for calendar icons in the modal
                $modal.off('mousedown click', '.date-picker-icon').on('mousedown click', '.date-picker-icon', function (e) {
                    e.preventDefault();
                    e.stopPropagation();
                    var $wrapper = $(this).closest('.date-picker-wrapper');
                    var $input = $wrapper.find('input.date-input, input[placeholder*="MM/DD/YYYY"], input[placeholder*="mm/dd/yyyy"]');

                    if ($input.length === 0) {
                        $input = $wrapper.find('input[type="text"]');
                    }
                    if ($input.length > 0) {
                        $input.focus();
                        setTimeout(function () {
                            $input.datepicker('show');
                        }, 50);
                    }
                });
            };

            // Initialize qualification modal form reset
            $('#qualificationModal').on('hidden.bs.modal', function () {
                $('#qualificationForm')[0].reset();
            });

            // Initialize work experience modal date pickers when modal is shown - same approach as page load
            $('#workExperienceModal').on('shown.bs.modal', function () {
                $('#modalFromDate, #modalTillDate').datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '-100:+10',
                    dateFormat: 'dd M yy',
                    showOn: 'focus',
                    onClose: function () {
                        $(':focus').blur();
                    }
                });
                $('#modalFromDate, #modalTillDate').off('click focus').on('click focus', function () {
                    $(this).datepicker('show');
                });
                if (typeof initializeModalDatePickers === 'function') {
                    initializeModalDatePickers('workExperienceModal');
                }
            });

            // Clear work experience modal form when modal is hidden
            $('#workExperienceModal').on('hidden.bs.modal', function () {
                $('#workExperienceForm')[0].reset();
                $(this).find('input.date-input, input[placeholder*="MM/DD/YYYY"], input[placeholder*="mm/dd/yyyy"]').each(function () {
                    try {
                        $(this).datepicker('destroy');
                        $(this).removeData('datepicker-initialized');
                    } catch (e) { }
                });
            });


            $(document).on('shown.bs.modal', '.modal', function () {
                var modalId = $(this).attr('id');
                if (modalId) {
                    setTimeout(function () {
                        initializeModalDatePickers(modalId);
                    }, 100);
                }
            });

     
            // Universal handler to destroy datepickers when any modal is hidden
            $(document).on('hidden.bs.modal', '.modal', function () {
                var $modal = $(this);
                var $dateInputs = $modal.find('input.date-input, input[placeholder*="MM/DD/YYYY"], input[placeholder*="mm/dd/yyyy"], input[placeholder*="Date"], input[type="date"]');

                // Also check for inputs with IDs containing "Date"
                $modal.find('input[type="text"]').each(function () {
                    var $input = $(this);
                    var id = $input.attr('id') || '';
                    if ((id.indexOf('date') !== -1 || id.indexOf('Date') !== -1) &&
                        $dateInputs.filter(function () { return this === $input[0]; }).length === 0) {
                        $dateInputs = $dateInputs.add($input);
                    }
                });

                $dateInputs.each(function () {
                    try {
                        $(this).datepicker('destroy');
                        $(this).removeData('datepicker-initialized');
                    } catch (e) { }
                });
            });

            $('#skillModal').on('hidden.bs.modal', function () {
                $('#skillForm')[0].reset();
                $('#modalCoreCompetency').prop('checked', false);
            });

            // Reset Experience Years and Months to 0 when skill offcanvas is hidden
            $('#skillModel_Offcanvas').on('hidden.bs.offcanvas', function () {
                $('#modalExperienceYears').val('0').selectpicker('refresh');
                $('#modalExperienceMonths').val('0').selectpicker('refresh');
            });
            setTimeout(function () {
                LoadCertificationsForDropdown();
            }, 200);

            var actualScore = $('#txtActualScore').val();
            var outOfScore = $('#txtOutOfScore').val();

            if (actualScore && outOfScore && actualScore.trim() !== '' && outOfScore.trim() !== '') {
                try {
                    var actual = parseFloat(actualScore.trim());
                    var outOf = parseFloat(outOfScore.trim());

                    if (!isNaN(actual) && !isNaN(outOf)) {
                        if (actual > outOf) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('<%=MyBase.GetResourceString("A_ActualscorecannotbegreaterthantheOutofvalue.")%>');
                            $('#txtActualScore').focus();
                            return;
                        }
                    }
                } catch (e) {
                    console.error('Error validating scores:', e);
                }
            }
         
            // Initialize Professional Background tabs - no cards active by default
            $('.professional-card-body').removeClass('active');
            $('.professional-tabs .nav-link').removeClass('active');
            $('.professional-tabs .nav-link').each(function () {
                $(this).attr('style', 'padding: 10px 16px; color: #6b7280; background: transparent; border: none; border-bottom: 2px solid transparent; cursor: pointer; white-space: nowrap; font-size: 11.5px; font-weight: 500;');
            });
            $('.professional-card-header').removeClass('active');
            
            switchProfessionalTab('certifications');

            InitializeSameAddressCheckbox();

            if (UserId && UserId !== 0 && UserId !== '0') {
                LoadEmployeeDetails();
                setTimeout(function () {
                    LoadCertifications();
                }, 500);
                setTimeout(function () {
                    LoadQualifications();
                }, 600);
                setTimeout(function () {
                    LoadWorkExperience();
                }, 700);
                setTimeout(function () {
                    LoadAssignments();
                }, 800);
                setTimeout(function () {
                    LoadSkills();
                }, 900);
                setTimeout(function () {
                    LoadCertificationsForDropdown();
                }, 700);
            } else {
                console.warn('Employee ID not available. Profile data will not be loaded.');
            }
        });

        function switchProfessionalTab(tabName) {
            selectedCertificationIDs = [];
            selectedQualificationIDs = [];
            selectedWorkExperienceIDs = [];
            selectedAssignmentIDs = [];
            selectedSkillIDs = [];
            
            certCurrentPage = 1;
            qualCurrentPage = 1;
            workExpCurrentPage = 1;
            assignmentsCurrentPage = 1;
            skillsCurrentPage = 1;
            
            $('.certification-checkbox, .qualification-checkbox, .workexperience-checkbox, .assignment-checkbox, .skill-checkbox').prop('checked', false);
            $('#selectAllCertifications, #selectAllQualifications, #selectAllWorkExperience, #selectAllAssignments, #selectAllSkills').prop('checked', false);
            
            $('.professional-tabs .nav-link').removeClass('active');
            $('.professional-tabs .nav-link').each(function () {
                $(this).attr('style', 'padding: 10px 16px; color: #6b7280; background: transparent; border: none; border-bottom: 2px solid transparent; cursor: pointer; white-space: nowrap; font-size: 11.5px; font-weight: 500;');
            });

            var $targetTab = $('.professional-tabs .nav-link[data-tab="' + tabName + '"]');
            if ($targetTab.length > 0) {
                $targetTab.addClass('active').attr('style',
                    'padding: 10px 16px; color: #1e40af; background: #eff6ff; border: none; border-bottom: 2px solid #1e40af; cursor: pointer; white-space: nowrap; font-size: 11.5px; font-weight: 500;'
                );
            }
            $('.professional-card-body').removeClass('active');
            $('.professional-card-header').removeClass('active');
            $('#card-' + tabName).addClass('active');
            $('.professional-card-header[onclick*="' + tabName + '"]').addClass('active');
            
            if (tabName === 'certifications') {
                LoadCertifications();
            } else if (tabName === 'qualifications') {
                LoadQualifications();
            } else if (tabName === 'workexperience') {
                LoadWorkExperience();
            } else if (tabName === 'assignments') {
                LoadAssignments();
            } else if (tabName === 'skills') {
                LoadSkills();
            }
        }

        function InitializeSameAddressCheckbox() {
            $('#chkSameAsPermanent').on('change', function () {
                if ($(this).is(':checked')) {
                    $('#textCurrentAddress').val($('#txtAddress').val() || '');
                    $('#txtcboCurrentState').val($('#txtcboPermanentState').val() || '');
                    $('#txtCurrentCity').val($('#txtPermanentCity').val() || '');
                    $('#txtCurrentPinCode').val($('#txtPinCode').val() || '');
                    $('#txtCurrentPhone').val($('#txtPhone').val() || '');
                } else {
                    $('#textCurrentAddress').val('');
                    $('#txtcboCurrentState').val('');
                    $('#txtCurrentCity').val('');
                $('#txtCurrentPinCode').val('');
                    $('#txtCurrentPhone').val('');
                }
            });
        }
        var GlobalEmpName = '';
        function LoadEmployeeDetails() {
            try {
                alertify.set('notifier', 'position', 'top-right');
                var employeeId = parseInt(UserId) || 0;
                if (!employeeId) {
                    alertify.error('<%=MyBase.GetResourceString("A_EmployeeIDnotavailablePleaseensureyouareloggeIn.")%>');
                    return;
                }

                var result = AJAXCallWithResult("api/MyProfile/GetEmployeeDetails", JSON.stringify({ EmployeeID: employeeId }), false);
                var employeeData = (result && result.data && Array.isArray(result.data)) ? result.data :
                    (result && result.data && result.data.EmployeeDetailsEntity && Array.isArray(result.data.EmployeeDetailsEntity)) ? result.data.EmployeeDetailsEntity :
                    (result && result.EmployeeDetailsEntity && Array.isArray(result.EmployeeDetailsEntity)) ? result.EmployeeDetailsEntity :
                    (Array.isArray(result)) ? result : [];

                if (employeeData && employeeData.length > 0) {
                    var emp = employeeData[0];
                    var profilePicUrl = emp.profilePicURL || emp.ProfilePicURL || '';
                    if (profilePicUrl && profilePicUrl.trim() !== '') {

                        $('#ProfilePicURL')
                            .off('error')
                            .on('error', function () {
                                handleImageError(this);
                            })
                            .attr('src', profilePicUrl);
                        $('#hiddenProfilePath').val(profilePicUrl);
                    } else {
                        $('#ProfilePicURL')
                            .attr('src', '../../../Images/Photo/no-photo.png');

                        $('#hiddenProfilePath').val('');
                    }

                        $('#EmployeeName').val(emp.employeeName || '');
                    GlobalEmpName = emp.employeeName;
                    var bloodGroupField = document.getElementById('cboBloodGroup');
                    if (bloodGroupField) {
                        var bloodGroupValue = emp.bloodGroup || '';
                        $('#cboBloodGroup').val(bloodGroupValue);
                        bloodGroupField.value = bloodGroupValue;
                        if ($('#cboBloodGroup').hasClass('selectpicker') || $('#cboBloodGroup').data('selectpicker')) {
                            try { $('#cboBloodGroup').selectpicker('refresh'); } catch (e) { }
                        }
                    }

                    $('#dtBirthDate').val(emp.birthDate ? formatDateFromAPI(emp.birthDate) : '');

                        $('#txtAddress').val(emp.address || '');
                        $('#txtcboPermanentState').val(emp.state || '');
                        if ($('#txtcboPermanentState').hasClass('selectpicker') || $('#txtcboPermanentState').data('selectpicker')) {
                        try { $('#txtcboPermanentState').selectpicker('refresh'); } catch (e) { }
                        }
                        $('#txtPermanentCity').val(emp.city || '');
                    $('#txtPinCode').val(emp.pinCode || emp.PinCode || '');
                        $('#txtPhone').val(emp.phone || '');

                        $('#textCurrentAddress').val(emp.currentAddress || '');
                    $('#txtcboCurrentState').val(emp.currentState || '');
                    $('#txtCurrentCity').val(emp.currentCity || emp.CurrentCity || '');
                    $('#txtCurrentPinCode').val(emp.currentPinCode || emp.CurrentPinCode || '');
                        $('#txtCurrentPhone').val(emp.currentPhone || '');

                    if (emp.currentAddress && emp.address && emp.currentAddress.trim() === emp.address.trim() &&
                        emp.currentState && emp.state && emp.currentState.trim() === emp.state.trim()) {
                        $('#chkSameAsPermanent').prop('checked', true).trigger('change');
                        }

                    var setLabel = function(id, value) {
                        var el = document.getElementById(id);
                        if (el) {
                            var val = value || '-';
                            $(el).text(val);
                            el.textContent = val;
                        }
                    };
                    setLabel('lblRoleName', emp.roleName);
                    setLabel('lblBusinessGroup', emp.businessGroup);
                    setLabel('lblEmployeeType', emp.employeeType);
                    setLabel('lblEmailID', emp.emailID);
                    setLabel('lblDepartment', emp.department);
                    setLabel('lblOrganizationUnit', emp.location);
                    setLabel('lblJoiningDate', emp.joiningDate ? formatDateFromAPI(emp.joiningDate) : '-');
                    setLabel('lblGender', emp.gender);

                    $('#txtPassportNumber').val(emp.passportNumber || '');
                    $('#txtFullName').val(emp.pP_FullName || '');
                    $('#dtDateOfIssue').val(emp.pP_DateOfIssue ? formatDateFromAPI(emp.pP_DateOfIssue) : '');
                    $('#dtExpiryDate').val(emp.pP_ExpiryDate ? formatDateFromAPI(emp.pP_ExpiryDate) : '');
                    $('#txtPlaceOfIssue').val(emp.pP_PlaceOfIssue || '');
                    $('#txtMobileNumbers').val(emp.mobileNumber || '');
                    $('#txtInstantMessengerIds').val(emp.communicationID || '');


                    } else {
                    alertify.error('<%=MyBase.GetResourceString("A_Noemployeedatafound.")%>');
                }
            } catch (error) {
                alertify.error('<%=MyBase.GetResourceString("A_Errorloadingemployeedetails")%> ' + (error.message || error));
            }
        }

        // Load Certifications - Using AJAXCallWithResult pattern (matching GetEmployeeDetails pattern)
        function LoadCertifications(certificationID) {
            try {
                if ($.fn.DataTable.isDataTable('#tblCertifications')) {
                    try {
                        $('#tblCertifications').DataTable().destroy();
                    } catch (e) {
                        try {
                            var table = $('#tblCertifications').dataTable();
                            if (table && typeof table.fnDestroy === 'function') {
                                table.fnDestroy();
                            }
                        } catch (e2) {
                            console.log('DataTable destroy failed, clearing table manually');
                        }
                    }
                }
                if (certificationID === undefined || certificationID === null) {
                    var selectedFilter = $('#certificationDrop').val();
                    certificationID = selectedFilter && selectedFilter !== '' ? parseInt(selectedFilter) : null;
                }
                var certificationIDParam = null;
                if (certificationID !== null && certificationID !== undefined && certificationID !== '') {
                    certificationIDParam = parseInt(certificationID);
                    if (isNaN(certificationIDParam)) {
                        certificationIDParam = null;
                    }
                }
                var param = {
                    EmployeeID: UserId,
                    PageNumber: certCurrentPage,
                    PageSize: certPageSize
                };
                param = JSON.stringify(param);

                var url = "api/MyProfile/GetCertificationEmployees";
                var result = AJAXCallWithResult(url, param, false);
                if (!result) {
                    var $tbody = $('#tblCertificationsBody');
                    $tbody.html('<tr><td colspan="4" class="empty-state"><div>There are no items to show in this view.</div></td></tr>');
                    $('#certPaginationContainer').hide();
                    return;
                }

                var certifications = [];
                if (result && result.data && Array.isArray(result.data)) {
                    certifications = result.data;
                } else if (Array.isArray(result)) {
                    certifications = result;
                }
                var paginationInfo = null;
                if (result && result.paginationEntities && Array.isArray(result.paginationEntities) && result.paginationEntities.length > 0) {
                    paginationInfo = result.paginationEntities[0];
                }
                // Update pagination variables from API response
                if (paginationInfo) {
                    certCurrentPage = paginationInfo.currentPage || certCurrentPage;
                    certPageSize = paginationInfo.pageSize || certPageSize;
                    certTotalRecords = paginationInfo.totalRecords || 0;
                    certTotalPages = Math.ceil((paginationInfo.totalRecords || 0) / (paginationInfo.pageSize || certPageSize));
                    if (certTotalPages < 1) certTotalPages = 1;
                }

                // Clear existing table - Remove all rows including empty state
                var $tbody = $('#tblCertificationsBody');
                $tbody.empty();

                if (certifications && certifications.length > 0) {
                    var rowsHTML = '';
                   
                    certifications.forEach(function (cert) {              
                        var certificationID = cert.CertificationID || cert.certificationID;
                        var certificationName = cert.CertificationName || cert.certificationName || '-';
                        var certificationDate = cert.CertificationDate || cert.certificationDate;
                        var validUpTo = cert.ValidUpto || cert.validUpto || cert.valid_upto || '';
                        var score = cert.Score || cert.score || '';
                        var scoreOutOf = cert.ScoreOutOf || cert.scoreOutOf || '';
                        var employeeCertificationID = cert.EmployeeCertificationID || cert.employeeCertificationID || cert.id || cert.ID || cert.CertificationID || cert.certificationID || null;
                        var scoreDisplay = '-';
                        var scoreStr = String(score || '').trim();
                        var scoreOutOfStr = String(scoreOutOf || '').trim();
                        if (scoreStr && scoreStr !== '0' && scoreOutOfStr && scoreOutOfStr !== '0') {
                            scoreDisplay = escapeHtml(scoreStr) + '/' + escapeHtml(scoreOutOfStr);
                        } else if (scoreStr && scoreStr !== '0') {
                            scoreDisplay = escapeHtml(scoreStr);
                        }                        
                        var checkbox = '';
                        var employeeCertificationIDNum = parseInt(employeeCertificationID) || 0;
                        var isChecked = employeeCertificationIDNum > 0 && selectedCertificationIDs.indexOf(employeeCertificationIDNum) !== -1;
                        if (employeeCertificationID && employeeCertificationID !== 0) {
                            console.log('Certification Checkbox ID:', employeeCertificationID);
                            checkbox = '<input type="checkbox" class="certification-checkbox" data-certification-id="' + employeeCertificationID + '" ' + (isChecked ? 'checked' : '') + ' style="display: block; margin: 0 auto;" />';
                        } else {
                            checkbox = '<input type="checkbox" class="certification-checkbox" data-certification-id="" disabled style="display: block; margin: 0 auto;" />';
                        }

                        var certDateFormatted = certificationDate ? formatDateFromAPI(certificationDate) : '-';
                        var validUpToFormatted = validUpTo ? formatDateFromAPI(validUpTo) : '';

                        rowsHTML += '<tr data-certification-id="' + (employeeCertificationID || '') + '">' +
                            '<td>' +
                            '<a href="javascript:void(0);" onclick="OpenUpdateCertificationModal(' +  employeeCertificationID + ',' +
                            certificationID + ',' +
                            '\'' + certDateFormatted + '\',' +
                            '\'' + validUpToFormatted + '\',' +
                            '\'' + score + '\',' +
                            '\'' + scoreOutOf + '\'' +
                            ')">' +
                            escapeHtml(certificationName) +
                            '</a>' +
                            '</td>' +
                            '<td>' + certDateFormatted + '</td>' +
                            '<td>' + escapeHtml(scoreDisplay) + '</td>' +
                            '<td style="text-align:center;">' + checkbox + '</td>' +
                            '</tr>';

                    });

                    // Set all rows at once
                    $tbody.html(rowsHTML);
                    var totalEnabledRecords = certTotalRecords; 
                    var allSelected = totalEnabledRecords > 0 && selectedCertificationIDs.length === totalEnabledRecords;
                    $('#selectAllCertifications').prop('checked', allSelected);
                    
                    if (paginationInfo && paginationInfo.totalRecords > 0) {
                        renderCertPagination(paginationInfo.totalRecords);
                    } else {
                        $('#certPaginationContainer').hide();
                    }
                    InitializeCertificationFilter();
                } else {
                    $tbody.html('<tr><td colspan="4" class="empty-state"><div>There are no items to show in this view.</div></td></tr>');
                    $('#certPaginationContainer').hide();
                }
            } catch (error) {
                if (typeof alertify !== 'undefined') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_Errorloadingcertifications")%> ' + (error.message || error));
                } else {
                    alert('<%=MyBase.GetResourceString("A_Errorloadingcertifications")%> ' + (error.message || error));
                }
            }
        }

        // Render Certification Pagination
        function renderCertPagination(totalRecords) {
            var $container = $('#certPaginationContainer');
            var $prevBtn = $('#certFirstPageBtn');
            var $nextBtn = $('#certLastPageBtn');
            var $totalRecords = $('#certTotalRecords');

            if (!totalRecords || totalRecords === 0) {
                $container.hide();
                return;
            }
            if (certTotalPages <= 0) {
                certTotalPages = Math.ceil(totalRecords / certPageSize);
            }
            if (certTotalPages < 1) certTotalPages = 1;

            if (certTotalPages <= 1) {
                $container.hide();
                return;
            }

            $container.css('display', 'flex');
            $container.css('justify-content', 'space-between');

            $totalRecords.text('Total Records: ' + totalRecords);

            $prevBtn.prop('disabled', certCurrentPage === 1);
            if (certCurrentPage === 1) {
                $prevBtn.css('opacity', '0.5');
                $prevBtn.css('cursor', 'not-allowed');
            } else {
                $prevBtn.css('opacity', '1');
                $prevBtn.css('cursor', 'pointer');
            }
            $nextBtn.prop('disabled', certCurrentPage >= certTotalPages);
            if (certCurrentPage >= certTotalPages) {
                $nextBtn.css('opacity', '0.5');
                $nextBtn.css('cursor', 'not-allowed');
            } else {
                $nextBtn.css('opacity', '1');
                $nextBtn.css('cursor', 'pointer');
            }
        }

        // Go to Certification Previous Page
        function goToCertPreviousPage() {
            if (certCurrentPage > 1) {
                certCurrentPage--;
                LoadCertifications();
            }
        }
        // Go to Certification Next Page
        function goToCertNextPage() {
            if (certCurrentPage < certTotalPages) {
                certCurrentPage++;
                LoadCertifications();
            }
        }

        // Load Qualifications - Using server-side pagination (matching LoadCertifications pattern)
        function LoadQualifications() {
            try {
                if (selectedQualificationIDs.length > 0) {
                    console.log('LoadQualifications - Selected IDs count:', selectedQualificationIDs.length, 'Current page:', qualCurrentPage);
                }
                var employeeId = parseInt(UserId) || 0;

                if (!employeeId || employeeId === 0) {
                    console.warn('Employee ID not available. UserId:', UserId);
                    if (typeof alertify !== 'undefined') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('<%=MyBase.GetResourceString("A_EmployeeIDnotavailablePleaseensureyouareloggeIn.")%>');
                    }
                    return;
                }
                // Send pagination parameters to API
                var param = {
                    EmployeeID: employeeId,
                    PageNumber: qualCurrentPage,
                    PageSize: qualPageSize
                };
                param = JSON.stringify(param);

                var url = "api/MyProfile/GetEmployeeQualifications";
                var result = AJAXCallWithResult(url, param, false);
                if (!result) {
                    var $tbody = $('#tblQualificationsBody');
                    $tbody.html('<tr><td colspan="6" class="empty-state"><div>No data available in table.</div></td></tr>');
                    return;
                }
                var qualifications = [];
                if (result && result.data) {
                    console.log('Result.data type:', typeof result.data);
                    console.log('Result.data is Array:', Array.isArray(result.data));
                    console.log('Result.data keys:', result.data ? Object.keys(result.data) : 'null');

                    if (result.data.EmployeeQualificationentity) {
                        console.log('Found EmployeeQualificationentity:', result.data.EmployeeQualificationentity);
                        console.log('EmployeeQualificationentity is Array:', Array.isArray(result.data.EmployeeQualificationentity));
                        console.log('EmployeeQualificationentity length:', result.data.EmployeeQualificationentity ? result.data.EmployeeQualificationentity.length : 0);
                    }
                }

                // ResponseHelper.BuildResponse returns response.Data directly
                if (result && result.data && Array.isArray(result.data)) {
                    qualifications = result.data;
                    console.log('Found qualifications in result.data:', qualifications.length, 'items');
                } else if (result && result.data && result.data.EmployeeQualificationentity && Array.isArray(result.data.EmployeeQualificationentity)) {
                    qualifications = result.data.EmployeeQualificationentity;
                    console.log('Found qualifications in result.data.EmployeeQualificationentity:', qualifications.length, 'items');
                } else if (result && result.data && result.data.EmployeeQualificationEntity && Array.isArray(result.data.EmployeeQualificationEntity)) {
                    qualifications = result.data.EmployeeQualificationEntity;
                    console.log('Found qualifications in result.data.EmployeeQualificationEntity:', qualifications.length, 'items');
                } else if (result && result.data && result.data.data && Array.isArray(result.data.data)) {
                    qualifications = result.data.data;
                    console.log(' Found qualifications in result.data.data:', qualifications.length, 'items');
                } else if (result && result.EmployeeQualificationentity && Array.isArray(result.EmployeeQualificationentity)) {
                    qualifications = result.EmployeeQualificationentity;
                    console.log('Found qualifications in result.EmployeeQualificationentity:', qualifications.length, 'items');
                } else if (Array.isArray(result)) {
                    qualifications = result;
                    console.log(' Found qualifications as direct array:', qualifications.length, 'items');
                } else {
                    console.warn('No qualifications array found in response structure');
                    console.warn('Response structure:', JSON.stringify(result, null, 2));
                }
                // paginationEntities is an array with one object: [{currentPage: 1, pageSize: 10, totalRecords: 14, totalPages: 2}]
                var paginationInfo = null;
                if (result && result.paginationEntities && Array.isArray(result.paginationEntities) && result.paginationEntities.length > 0) {
                    paginationInfo = result.paginationEntities[0];
                }

                // Update pagination variables from API response
                if (paginationInfo) {
                    qualCurrentPage = paginationInfo.currentPage || qualCurrentPage;
                    qualPageSize = paginationInfo.pageSize || qualPageSize;
                    qualTotalRecords = paginationInfo.totalRecords || 0;
                    qualTotalPages = Math.ceil((paginationInfo.totalRecords || 0) / (paginationInfo.pageSize || qualPageSize));
                    if (qualTotalPages < 1) qualTotalPages = 1;
                }

                console.log('Extracted Qualifications Data:', qualifications);
                console.log('Qualifications array length:', qualifications ? qualifications.length : 0);

                var $tbody = $('#tblQualificationsBody');
                $tbody.empty();

                if (qualifications && qualifications.length > 0) {
                    console.log('Binding qualifications data to table. Qualifications count:', qualifications.length);
                    var rowsHTML = '';
                    qualifications.forEach(function (qual) {
                        var qualificationID = qual.QualificationID || qual.qualificationID || 0;
                        var universityName = qual.UniversityName || qual.universityName || '-';
                        var passoutYear = qual.PassoutYear || qual.passoutYear;
                        var classValue = qual.Class || qual.class || '-';
                        var percentagePoints = qual.Percentagepoints || qual.percentagepoints;
                        var qualificationName = qual.QualificationName || qual.qualificationName || '-';
                        var employeeQualificationID = qual.EmployeeQualificationID || qual.employeeQualificationID || 0;
                        var passoutYearStr =(passoutYear !== null && passoutYear !== undefined && passoutYear !== '') ? String(passoutYear).trim() : '';
                        //var percentagePointsStr = (percentagePoints !== null && percentagePoints !== undefined) ? String(percentagePoints) : '-';
                        console.log('Processing qualification:', {
                            qualificationID: qualificationID,
                            universityName: universityName,
                            passoutYearStr: passoutYear,
                            classValue: classValue,
                            percentagePoints: percentagePoints,
                            qualificationName: qualificationName,
                            employeeQualificationID: employeeQualificationID
                        });

                        rowsHTML += '<tr data-qualification-id="' + employeeQualificationID + '">' +
                            '<td>' +
                            '<a href="javascript:void(0);" onclick="OpenUpdateQualificationModal(' + employeeQualificationID + ',' +
                            qualificationID + ',' +
                            '\'' + escapeJsString(universityName) + '\',' +
                            '\'' + escapeJsString(passoutYearStr)  + '\',' +
                            '\'' + escapeJsString(classValue) + '\',' +
                            '\'' + escapeJsString(percentagePoints) + '\'' +             
                            ')">' +
                            escapeHtml(String(universityName)) +
                            '</a>' +
                            '</td>' +
                            '<td>' + escapeHtml(passoutYearStr) + '</td>' +
                            '<td>' + escapeHtml(String(classValue)) + '</td>' +
                            '<td>' + (percentagePoints !== null && percentagePoints !== undefined && percentagePoints !== '' ? escapeHtml(String(percentagePoints)) + '%' : '-') + '</td>' +
                            '<td>' + escapeHtml(qualificationName) + '</td>' +

                            '<td style="text-align: center;">' + (function () {                    
                                var checkbox = '';
                                var isChecked = false;
                                if (employeeQualificationID && employeeQualificationID !== 0) {
                                    var qualIdNum = parseInt(employeeQualificationID) || 0;
                                    if (qualIdNum > 0 && selectedQualificationIDs.length > 0) {
                                        for (var i = 0; i < selectedQualificationIDs.length; i++) {
                                            if (parseInt(selectedQualificationIDs[i]) === qualIdNum) {
                                                isChecked = true;
                                                break;
                                            }
                                        }
                                    }
                                    checkbox = '<input type="checkbox" class="qualification-checkbox" data-qualification-id="' + employeeQualificationID + '" ' + (isChecked ? 'checked' : '') + ' onclick="event.stopPropagation();" style="display: block; margin: 0 auto; cursor: pointer; pointer-events: auto;" />';
                                } else {
                                    checkbox = '<input type="checkbox" class="qualification-checkbox"  style="display: block; margin: 0 auto;" />';
                                }
                                return checkbox;
                            })() + '</td>' +
                            '</tr>';
                    });

                    // Set all rows at once
                    $tbody.html(rowsHTML);
                    if (paginationInfo && paginationInfo.totalRecords > 0) {
                        renderQualPagination(paginationInfo.totalRecords);
                    } else {
                        $('#qualPaginationContainer').hide();
                    }
                    InitializeQualificationCheckboxes();              
                    var totalEnabledRecords = qualTotalRecords || 0;
                    var allSelected = false;
                    if (totalEnabledRecords > 0 && selectedQualificationIDs.length > 0 && totalEnabledRecords === selectedQualificationIDs.length) {
                        allSelected = true;
                    }
                    $('#selectAllQualifications').prop('checked', allSelected);
                } else {
                    $tbody.html('<tr><td colspan="6" class="empty-state"><div>No data available in table.</div></td></tr>');
                    $('#qualPaginationContainer').hide();
                }
            } catch (error) {
                console.error('Error loading qualifications:', error);
                if (typeof alertify !== 'undefined') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_Errorloadingqualifications")%> ' + (error.message || error));
                }
            }
        }

        // Render Qualifications Pagination
        function renderQualPagination(totalRecords) {
            var $container = $('#qualPaginationContainer');
            var $prevBtn = $('#qualFirstPageBtn');
            var $nextBtn = $('#qualLastPageBtn');
            var $totalRecords = $('#qualTotalRecords');

            if (!totalRecords || totalRecords === 0) {
                $container.hide();
                return;
            }

            if (qualTotalPages <= 0) {
                qualTotalPages = Math.ceil(totalRecords / qualPageSize);
            }
            if (qualTotalPages < 1) qualTotalPages = 1;
            if (qualTotalPages <= 1) {
                $container.hide();
                return;
            }
            $container.css('display', 'flex');
            $totalRecords.text('Total Records: ' + totalRecords);
            $prevBtn.prop('disabled', qualCurrentPage === 1);
            if (qualCurrentPage === 1) {
                $prevBtn.css('opacity', '0.5');
                $prevBtn.css('cursor', 'not-allowed');
            } else {
                $prevBtn.css('opacity', '1');
                $prevBtn.css('cursor', 'pointer');
            }
            $nextBtn.prop('disabled', qualCurrentPage >= qualTotalPages);
            if (qualCurrentPage >= qualTotalPages) {
                $nextBtn.css('opacity', '0.5');
                $nextBtn.css('cursor', 'not-allowed');
            } else {
                $nextBtn.css('opacity', '1');
                $nextBtn.css('cursor', 'pointer');
            }
        }
        // Go to Qualifications Previous Page
        function goToQualPreviousPage() {
            if (qualCurrentPage > 1) {
                qualCurrentPage--;
                LoadQualifications();
            }
        }
        function goToQualNextPage() {
            if (qualCurrentPage < qualTotalPages) {
                qualCurrentPage++;
                LoadQualifications();
            }
        }

        // Load Work Experience - Using AJAXCallWithResult pattern (matching GetEmployeeQualifications pattern)
        function LoadWorkExperience() {
            try {
                var employeeId = parseInt(UserId) || 0;

                if (!employeeId || employeeId === 0) {
                    return;
                }
                var param = {
                    EmployeeID: employeeId,
                    PageNumber: workExpCurrentPage,
                    PageSize: workExpPageSize
                };
                param = JSON.stringify(param);
                var url = "api/MyProfile/GetEmployeeWorkExperience";
                var result = AJAXCallWithResult(url, param, false);
                console.log('GetEmployeeWorkExperience API Response:', result);
                var workExp = [];
                if (result && result.data) {
                    console.log('Result.data type:', typeof result.data);
                    console.log('Result.data is Array:', Array.isArray(result.data));
                    console.log('Result.data keys:', result.data ? Object.keys(result.data) : 'null');

                    if (result.data.EmployeeWorkExperienceEntity) {
                        console.log('Found EmployeeWorkExperienceEntity:', result.data.EmployeeWorkExperienceEntity);
                        console.log('EmployeeWorkExperienceEntity is Array:', Array.isArray(result.data.EmployeeWorkExperienceEntity));
                        console.log('EmployeeWorkExperienceEntity length:', result.data.EmployeeWorkExperienceEntity ? result.data.EmployeeWorkExperienceEntity.length : 0);
                    }
                }
                if (result && result.data && result.data.EmployeeWorkExperienceEntity && Array.isArray(result.data.EmployeeWorkExperienceEntity)) {
                    
                    workExp = result.data.EmployeeWorkExperienceEntity;
                    console.log(' Found work experience in result.data.EmployeeWorkExperienceEntity:', workExp.length, 'items');
                } else if (result && result.data && Array.isArray(result.data)) {
                    workExp = result.data;
                    console.log(' Found work experience as direct array in result.data:', workExp.length, 'items');
                } else if (result && result.data && result.data.data && Array.isArray(result.data.data)) {
                   
                    workExp = result.data.data;
                    console.log('Found work experience in result.data.data:', workExp.length, 'items');
                } else if (result && result.EmployeeWorkExperienceEntity && Array.isArray(result.EmployeeWorkExperienceEntity)) {
                
                    workExp = result.EmployeeWorkExperienceEntity;
                    console.log('Found work experience in result.EmployeeWorkExperienceEntity:', workExp.length, 'items');
                } else if (Array.isArray(result)) {
                  
                    workExp = result;
                    console.log('Found work experience as direct array:', workExp.length, 'items');
                } else {
                    console.warn(' No work experience array found in response structure');
                    console.warn('Response structure:', JSON.stringify(result, null, 2));
                }

                var paginationInfo = null;
                if (result && result.paginationEntities && Array.isArray(result.paginationEntities) && result.paginationEntities.length > 0) {
                    paginationInfo = result.paginationEntities[0];
                }
                // Update pagination variables from API response
                if (paginationInfo) {
                    workExpCurrentPage = paginationInfo.currentPage || workExpCurrentPage;
                    workExpPageSize = paginationInfo.pageSize || workExpPageSize;
                    workExpTotalRecords = paginationInfo.totalRecords || 0;
                    workExpTotalPages = Math.ceil((paginationInfo.totalRecords || 0) / (paginationInfo.pageSize || workExpPageSize));
                    if (workExpTotalPages < 1) workExpTotalPages = 1;
                }

                console.log('Extracted Work Experience Data:', workExp);
                console.log('Work Experience array length:', workExp ? workExp.length : 0);

                // Clear existing table
                var $tbody = $('#tblWorkExperienceBody');
                $tbody.empty();

                if (!workExp || workExp.length === 0) {
                    $tbody.html('<tr><td colspan="6" class="empty-state"><div>No data available in table.</div></td></tr>');
                    $('#workExpPaginationContainer').hide();
                    console.log('No work experience data to display');
                    return;
                }
       
                // Build rows HTML string for better performance
                var rowsHTML = '';

                // Populate table
                workExp.forEach(function (exp) {
                    var employeeHistoryID = exp.EmployeeHistoryID || exp.employeeHistoryID || exp.EmployeeHistoryId || exp.employeeHistoryId || '';
                    var organizationName = exp.OrganizationName || exp.organizationName || '-';
                    var positionHeld = exp.PositionHeld || exp.positionHeld || '-';
                    var fromDate = exp.FromDate || exp.fromDate || null;
                    var tillDate = exp.TillDate || exp.tillDate || null;
                    var workProfileID = exp.WorkProfile || exp.workProfile || null;
                    var workProfileName = exp.WorkProfile || exp.workProfile || '-';
                    var summary = exp.Summary || exp.summary || '';
                    // Convert Work Profile ID to Name for display
                    var workProfile = '-';
                    if (workProfileID !== null && workProfileID !== undefined && workProfileID !== '') {
                        var workProfileIDInt = parseInt(workProfileID);
                        if (!isNaN(workProfileIDInt) && workProfileMap[workProfileIDInt]) {
                            workProfile = workProfileMap[workProfileIDInt];
                        } else {
                            workProfile = String(workProfileID);
                        }
                    }
                    // Format dates using formatDateFromAPI (same as Birth Date)
                    var fromDateFormatted = fromDate ? formatDateFromAPI(fromDate) : '';
                    var tillDateFormatted = tillDate ? formatDateFromAPI(tillDate) : '';

                    rowsHTML += '<tr data-workexperience-id="' + employeeHistoryID + '">' +
                        '<td>' +
                        '<a href="javascript:void(0);" onclick="OpenUpdateWorkExperienceModal(' +
                        employeeHistoryID + ', ' +
                        '\'' + escapeJsString(organizationName) + '\',' +
                        '\'' + escapeJsString(positionHeld) + '\',' +
                        '\'' + escapeJsString(fromDateFormatted) + '\',' +
                        '\'' + escapeJsString(tillDateFormatted) + '\',' +
                        '\'' + escapeJsString(workProfile) + '\' ,' +
                        '\'' + escapeJsString(summary) + '\' ' +
                        ')">' +
                        escapeHtml(organizationName) +
                        '</a>' +
                        '</td>' +
                        '<td>' + escapeHtml(String(positionHeld)) + '</td>' +
                        '<td>' + (fromDateFormatted || '-') + '</td>' +
                        '<td>' + (tillDateFormatted || '-') + '</td>' +
                        '<td>' + escapeHtml(String(workProfile)) + '</td>' +
                        '<td style="text-align: center;">' + (function () {
                            if (employeeHistoryID && employeeHistoryID !== 0 && employeeHistoryID !== '') {
                                var isChecked = selectedWorkExperienceIDs.some(function (id) {
                                    return id == employeeHistoryID || parseInt(id) === parseInt(employeeHistoryID);
                                });
                                return '<input type="checkbox" ' +
                                    'class="workexperience-checkbox" ' +
                                    'data-workexperience-id="' + employeeHistoryID + '" ' +
                                    'value="' + employeeHistoryID + '" ' +
                                    (isChecked ? 'checked ' : '') +
                                    'onclick="event.stopPropagation();" ' +
                                    'style="display: block; margin: 0 auto; cursor:pointer;" />';
                            } else {
                                return '<input type="checkbox" class="workexperience-checkbox"  style="display: block; margin: 0 auto;" />';
                            }
                        })() + '</td>' +
                        '</tr>';
                });

                // Set all rows at once
                $tbody.html(rowsHTML);

                var totalEnabledRecords = workExpTotalRecords; 
                var allSelected = totalEnabledRecords > 0 && selectedWorkExperienceIDs.length === totalEnabledRecords;
                $('#selectAllWorkExperience').prop('checked', allSelected);
                if (paginationInfo && paginationInfo.totalRecords > 0) {
                    renderWorkExpPagination(paginationInfo.totalRecords);
                } else {
                    $('#workExpPaginationContainer').hide();
                }
                InitializeWorkExperienceCheckboxes();
            } catch (error) {
                console.error('Error loading work experience:', error);
                if (typeof alertify !== 'undefined') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_Errorloadingworkexperience")%> ' + (error.message || error));
                }
            }
        }

        // Render Work Experience Pagination (matching Qualifications pagination exactly)
        function renderWorkExpPagination(totalRecords) {
            var $container = $('#workExpPaginationContainer');
            var $prevBtn = $('#workExpFirstPageBtn');
            var $nextBtn = $('#workExpLastPageBtn');
            var $totalRecords = $('#workExpTotalRecords');

            if (!totalRecords || totalRecords === 0) {
                $container.hide();
                return;
            }

            if (workExpTotalPages <= 0) {
                workExpTotalPages = Math.ceil(totalRecords / workExpPageSize);
            }
            if (workExpTotalPages < 1) workExpTotalPages = 1;

            if (workExpTotalPages <= 1) {
                $container.hide();
                return;
            }

            $container.css('display', 'flex');
            $container.css('justify-content', 'space-between');
            $totalRecords.text('Total Records: ' + totalRecords);
            $prevBtn.prop('disabled', workExpCurrentPage === 1);
            if (workExpCurrentPage === 1) {
                $prevBtn.css('opacity', '0.5');
                $prevBtn.css('cursor', 'not-allowed');
            } else {
                $prevBtn.css('opacity', '1');
                $prevBtn.css('cursor', 'pointer');
            }
            $nextBtn.prop('disabled', workExpCurrentPage >= workExpTotalPages);
            if (workExpCurrentPage >= workExpTotalPages) {
                $nextBtn.css('opacity', '0.5');
                $nextBtn.css('cursor', 'not-allowed');
            } else {
                $nextBtn.css('opacity', '1');
                $nextBtn.css('cursor', 'pointer');
            }
        }
        // Go to Work Experience Previous Page
        function goToWorkExpPreviousPage() {
            if (workExpCurrentPage > 1) {
                workExpCurrentPage--;
                LoadWorkExperience();
            }
        }
        function goToWorkExpNextPage() {
            if (workExpCurrentPage < workExpTotalPages) {
                workExpCurrentPage++;
                LoadWorkExperience();
            }
        }

        // Load Assignments - Using AJAXCallWithResult pattern (matching GetEmployeeQualifications pattern)
        function LoadAssignments() {
            try {
                if ($.fn.DataTable.isDataTable('#tblAssignments')) {
                    try {
                        $('#tblAssignments').DataTable().destroy();
                    } catch (e) {
                        try {
                            var table = $('#tblAssignments').dataTable();
                            if (table && typeof table.fnDestroy === 'function') {
                                table.fnDestroy();
                            }
                        } catch (e2) {
                            console.log('DataTable destroy failed, clearing table manually');
                        }
                    }
                }
                var employeeId = parseInt(UserId) || 0;
                if (!employeeId || employeeId === 0) {
                    console.warn('LoadAssignments: Invalid EmployeeID:', employeeId);
                    return;
                }
                var param = {
                    EmployeeID: employeeId,
                    PageNumber: assignmentsCurrentPage,
                    PageSize: assignmentsPageSize
                };
                param = JSON.stringify(param);
                var url = "api/MyProfile/GetEmployeeHistoryAssignment";
                var result = AJAXCallWithResult(url, param, false);

                // Check if API call failed
                if (!result) {
                    var $tbody = $('#tblAssignmentsBody');
                    $tbody.html('<tr><td colspan="7" class="empty-state"><div>No data available in table.</div></td></tr>');
                    $('#AssigPaginationContainer').hide();
                    return;
                }

                if (result && result.data && result.data.EmployeeHistoryAssignmentEntity && Array.isArray(result.data.EmployeeHistoryAssignmentEntity)) {
                   
                    assignments = result.data.EmployeeHistoryAssignmentEntity;
                    console.log('Found assignments in result.data.EmployeeHistoryAssignmentEntity:', assignments.length, 'items');
                } else if (result && result.data && Array.isArray(result.data)) {
                    
                    assignments = result.data;
                    console.log('Found assignments as direct array in result.data:', assignments.length, 'items');
                } else if (result && result.data && result.data.data && Array.isArray(result.data.data)) {
                   
                    assignments = result.data.data;
                    console.log(' Found assignments in result.data.data:', assignments.length, 'items');
                } else if (result && result.EmployeeHistoryAssignmentEntity && Array.isArray(result.EmployeeHistoryAssignmentEntity)) {
                    
                    assignments = result.EmployeeHistoryAssignmentEntity;
                    console.log(' Found assignments in result.EmployeeHistoryAssignmentEntity:', assignments.length, 'items');
                } else if (Array.isArray(result)) {
                   
                    assignments = result;
                    console.log('Found assignments as direct array:', assignments.length, 'items');
                } else {
                    console.warn(' No assignments array found in response structure');
                    console.warn('Response structure:', JSON.stringify(result, null, 2));
                }

                // Extract pagination info from response
                var paginationInfo = null;
                if (result && result.paginationEntities && Array.isArray(result.paginationEntities) && result.paginationEntities.length > 0) {
                    paginationInfo = result.paginationEntities[0];
                    console.log('Found paginationEntities at result.paginationEntities:', paginationInfo);
                } else if (result && result.data && result.data.paginationEntities && Array.isArray(result.data.paginationEntities) && result.data.paginationEntities.length > 0) {
                    paginationInfo = result.data.paginationEntities[0];
                    console.log('Found paginationEntities at result.data.paginationEntities:', paginationInfo);
                } else if (result && result.data && result.data.paginationInfo) {
                    paginationInfo = result.data.paginationInfo;
                    console.log('Found paginationInfo at result.data.paginationInfo:', paginationInfo);
                } else {
                    console.log('No pagination info found in response. Checking result structure:', Object.keys(result || {}));
                }

                // Update pagination variables from API response
                if (paginationInfo) {
                    assignmentsCurrentPage = paginationInfo.currentPage || assignmentsCurrentPage;
                    assignmentsPageSize = paginationInfo.pageSize || assignmentsPageSize;
                    assignmentsTotalRecords = paginationInfo.totalRecords || 0;
                    assignmentsTotalPages = Math.ceil((paginationInfo.totalRecords || 0) / (paginationInfo.pageSize || assignmentsPageSize));
                    if (assignmentsTotalPages < 1) assignmentsTotalPages = 1;
                    console.log('Pagination info extracted - CurrentPage:', assignmentsCurrentPage, 'PageSize:', assignmentsPageSize, 'TotalRecords:', paginationInfo.totalRecords, 'TotalPages:', assignmentsTotalPages);
                } else {
                    if (assignments && assignments.length > 0) {
                        assignmentsTotalRecords = assignments.length;
                        assignmentsTotalPages = Math.ceil(assignments.length / assignmentsPageSize);
                        if (assignmentsTotalPages < 1) assignmentsTotalPages = 1;
                        paginationInfo = {
                            totalRecords: assignments.length,
                            currentPage: assignmentsCurrentPage,
                            pageSize: assignmentsPageSize
                        };
                        console.log('No pagination info from API, using array length - TotalRecords:', assignments.length, 'TotalPages:', assignmentsTotalPages);
                    }
                }

                console.log('Extracted Assignments Data:', assignments);
                console.log('Assignments array length:', assignments ? assignments.length : 0);

                // Clear existing table
                var $tbody = $('#tblAssignmentsBody');
                $tbody.empty();

                if (!assignments || assignments.length === 0) {
                    $tbody.html('<tr><td colspan="7" class="empty-state"><div>No data available in table</div></td></tr>');
                    $('#AssigPaginationContainer').hide();
                    console.log('No assignments data to display');
                    return;
                }

                var rowsHTML = '';

                // Populate table
                assignments.forEach(function (assign) {
                    var employeeHistoryProjectID = assign.EmployeeHistoryProjectID || assign.employeeHistoryProjectID || assign.EmployeeHistoryProjectId || assign.employeeHistoryProjectId || '';
                    var assignmentName = assign.AssignmentName || assign.assignmentName || '-';
                    var durationYears = assign.DurationYears || assign.durationYears || '-';
                    var teamSize = assign.TeamSize || assign.teamSize || '-';
                    var functionalRole = assign.FunctionalRole || assign.functionalRole || '-';
                    var environment = assign.Environment || assign.environment || '';
                    var skills = assign.Skills || assign.skills || '';
                    var description = assign.Description || assign.description || '';
                    var createdBy = assign.CreatedBy || assign.createdBy || '-';

                    var createdDateRaw = (assign.CreatedDate !== null && assign.CreatedDate !== undefined && assign.CreatedDate !== '') 
                        ? assign.CreatedDate 
                        : ((assign.createdDate !== null && assign.createdDate !== undefined && assign.createdDate !== '') 
                            ? assign.createdDate 
                            : null);
                    
                    var createdDate = (!createdDateRaw || createdDateRaw === 'null' || createdDateRaw === 'undefined' || createdDateRaw === '' || createdDateRaw === '-') ? null : createdDateRaw;
                    var createdDateFormatted = createdDate ? formatDateFromAPI(createdDate) : '';

                    rowsHTML += '<tr data-assignment-id="' + employeeHistoryProjectID + '">' +
                        '<td>' +
                        '<a href="javascript:void(0);" onclick="OpenUpdateAssignmentModal(' +
                        '\'' + employeeHistoryProjectID + '\',' +
                        '\'' + escapeJsString(assignmentName) + '\',' +
                        '\'' + durationYears + '\',' +
                        '\'' + teamSize + '\',' +
                        '\'' + escapeJsString(functionalRole) + '\',' +
                        '\'' + escapeJsString(environment) + '\',' +
                        '\'' + escapeJsString(skills) + '\',' +
                        '\'' + escapeJsString(description) + '\',' +
                        '\'' + escapeJsString(createdBy) + '\', ' +
                        (createdDateFormatted ? '\'' + escapeJsString(createdDateFormatted) + '\'' : 'null') +
                        ')">' +
                        escapeHtml(assignmentName) +
                        '</a>' +
                        '</td>' +
                        '<td>' + escapeHtml(String(durationYears)) + '</td>' +
                        '<td>' + escapeHtml(String(teamSize)) + '</td>' +
                        '<td>' + escapeHtml(String(functionalRole)) + '</td>' +
                        '<td>' + escapeHtml(String(createdBy)) + '</td>' +
                        '<td>' + (createdDateFormatted || '-') + '</td>' +
                        '<td style="text-align: center;">' + (function () {
                            if (employeeHistoryProjectID && employeeHistoryProjectID !== 0) {
                                var isChecked = selectedAssignmentIDs.indexOf(employeeHistoryProjectID) !== -1;
                                return '<input type="checkbox" class="assignment-checkbox" data-assignment-id="' + employeeHistoryProjectID + '" ' + (isChecked ? 'checked' : '') + ' style="display: block; margin: 0 auto;" />';
                            } else {
                                return '<input type="checkbox" class="assignment-checkbox" disabled style="display: block; margin: 0 auto;" />';
                            }
                        })() + '</td>' +
                        '</tr>';
                });

                $tbody.html(rowsHTML);

                // Update Select All checkbox state based on all records across all pages
                var totalEnabledRecords = assignmentsTotalRecords; // Total records that can be selected
                var allSelected = totalEnabledRecords > 0 && selectedAssignmentIDs.length === totalEnabledRecords;
                $('#selectAllAssignments').prop('checked', allSelected);

                // Render pagination controls
                if (paginationInfo && paginationInfo.totalRecords > 0) {
                    renderAssignmentsPagination(paginationInfo.totalRecords);
                } else if (assignments && assignments.length > 0) {
                    if (assignments.length >= assignmentsPageSize) {
                        renderAssignmentsPagination(assignments.length + 1);
                    } else {
                        renderAssignmentsPagination(assignments.length);
                    }
                } else {
                    $('#AssigPaginationContainer').hide();
                }
                InitializeAssignmentCheckboxes();
            } catch (error) {
                console.error('Error loading assignments:', error);
                if (typeof alertify !== 'undefined') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_Errorloadingassignments")%> ' + (error.message || error));
                } else {
                    alertify.error('<%=MyBase.GetResourceString("A_Errorloadingassignments")%> ' + (error.message || error));
                }
            }
        }

        // Render Assignments Pagination (matching Work Experience pagination exactly)
        function renderAssignmentsPagination(totalRecords) {
            var $container = $('#AssigPaginationContainer');
            var $prevBtn = $('#AssigFirstPageBtn');
            var $nextBtn = $('#AssigLastPageBtn');
            var $totalRecords = $('#AssigTotalRecords');

            if (!totalRecords || totalRecords === 0) {
                $container.hide();
                return;
            }
            if (assignmentsTotalPages <= 0) {
                assignmentsTotalPages = Math.ceil(totalRecords / assignmentsPageSize);
            }
            if (assignmentsTotalPages < 1) assignmentsTotalPages = 1;
            // Show pagination if there are records and more than one page, or if totalRecords suggests more data
            if (assignmentsTotalPages <= 1 && totalRecords <= assignmentsPageSize) {
                $container.hide();
                return;
            }

            $container.css('display', 'flex');
            $container.css('justify-content', 'space-between');
            $totalRecords.text('Total Records: ' + totalRecords);

            // Update Previous button
            $prevBtn.prop('disabled', assignmentsCurrentPage === 1);
            if (assignmentsCurrentPage === 1) {
                $prevBtn.css('opacity', '0.5');
                $prevBtn.css('cursor', 'not-allowed');
            } else {
                $prevBtn.css('opacity', '1');
                $prevBtn.css('cursor', 'pointer');
            }

            // Update Next button
            $nextBtn.prop('disabled', assignmentsCurrentPage >= assignmentsTotalPages);
            if (assignmentsCurrentPage >= assignmentsTotalPages) {
                $nextBtn.css('opacity', '0.5');
                $nextBtn.css('cursor', 'not-allowed');
            } else {
                $nextBtn.css('opacity', '1');
                $nextBtn.css('cursor', 'pointer');
            }
        }

        function goToAssigPreviousPage() {
            if (assignmentsCurrentPage > 1) {
                assignmentsCurrentPage--;
                LoadAssignments();
            }
        }
        function goToAssigNextPage() {
           
            if (assignmentsCurrentPage < assignmentsTotalPages) {
                assignmentsCurrentPage++;
                LoadAssignments();
            }
        }
        // Load Skills - Using AJAXCallWithResult pattern (matching LoadAssignments pattern)
        function LoadSkills() {
            try {
                if ($.fn.DataTable.isDataTable('#tblSkills')) {
                    try {
                        $('#tblSkills').DataTable().destroy();
                    } catch (e) {
                        try {
                            var table = $('#tblSkills').dataTable();
                            if (table && typeof table.fnDestroy === 'function') {
                                table.fnDestroy();
                            }
                        } catch (e2) {
                            console.log('DataTable destroy failed, clearing table manually');
                        }
                    }
                }
                var employeeId = parseInt(UserId) || 0;
                if (!employeeId || employeeId === 0) {
                    console.warn('LoadSkills: Invalid EmployeeID:', employeeId);
                    return;
                }
                var param = {
                    EmployeeID: employeeId,
                    PageNumber: skillsCurrentPage,
                    PageSize: skillsPageSize
                };
                param = JSON.stringify(param);

                var url = "api/MyProfile/GetEmployeeSkillMatrix";
                var result = AJAXCallWithResult(url, param, false);

                console.log('GetEmployeeSkillMatrix API Response:', result);
                if (!result) {
                    console.error('GetEmployeeSkillMatrix API returned null or undefined');
                    $('#tblSkillsBody').html('<tr><td colspan="6" class="empty-state"><div>Error loading skills data</div></td></tr>');
                    if (typeof alertify !== 'undefined') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('<%=MyBase.GetResourceString("A_Errorloadingskills")%>');
                    }
                    return;
                }
                var skills = [];
                if (result && (result.error || result.status === 'ERROR' || (result.status && result.status !== 'SUCCESS'))) {
                    var errorMessage = result.message || result.error || 'Failed to load skills';
                    console.error('GetEmployeeSkillMatrix API Error:', errorMessage);
                    $('#tblSkillsBody').html('<tr><td colspan="6" class="empty-state"><div>Error: ' + escapeHtml(errorMessage) + '</div></td></tr>');
                    return;
                }

                if (result && result.data) {
                    console.log('Result.data type:', typeof result.data);
                    console.log('Result.data is Array:', Array.isArray(result.data));
                    console.log('Result.data keys:', result.data ? Object.keys(result.data) : 'null');
                }
                if (result && result.data && result.data.data && Array.isArray(result.data.data)) {
                    skills = result.data.data;
                    console.log(' Found skills in result.data.data (nested structure):', skills.length, 'items');
                }
                else if (result && result.data && Array.isArray(result.data)) {
                    skills = result.data;
                    console.log('Found skills as direct array in result.data:', skills.length, 'items');
                }
                else if (result && result.data && result.data.EmployeeSkillMatrixEntity && Array.isArray(result.data.EmployeeSkillMatrixEntity)) {
                    skills = result.data.EmployeeSkillMatrixEntity;
                    console.log(' Found skills in result.data.EmployeeSkillMatrixEntity:', skills.length, 'items');
                }
                else if (result && result.EmployeeSkillMatrixEntity && Array.isArray(result.EmployeeSkillMatrixEntity)) {
                    skills = result.EmployeeSkillMatrixEntity;
                    console.log(' Found skills in result.EmployeeSkillMatrixEntity:', skills.length, 'items');
                }
                else if (Array.isArray(result)) {
                    skills = result;
                    console.log('Found skills as direct array:', skills.length, 'items');
                }
                else {
                    console.warn(' No skills array found in response structure');
                    console.warn('Response structure:', JSON.stringify(result, null, 2));
                }
                var paginationInfo = null;
                if (result && result.paginationEntities && Array.isArray(result.paginationEntities) && result.paginationEntities.length > 0) {
                    paginationInfo = result.paginationEntities[0];
                    console.log('Found paginationEntities at result.paginationEntities:', paginationInfo);
                } else if (result && result.data && result.data.paginationEntities && Array.isArray(result.data.paginationEntities) && result.data.paginationEntities.length > 0) {
                    paginationInfo = result.data.paginationEntities[0];
                    console.log('Found paginationEntities at result.data.paginationEntities:', paginationInfo);
                } else if (result && result.data && result.data.paginationInfo) {
                    paginationInfo = result.data.paginationInfo;
                    console.log('Found paginationInfo at result.data.paginationInfo:', paginationInfo);
                } else {
                    console.log('No pagination info found in response. Checking result structure:', Object.keys(result || {}));
                }

                // Update pagination variables from API response
                if (paginationInfo) {
                    skillsCurrentPage = paginationInfo.currentPage || skillsCurrentPage;
                    skillsPageSize = paginationInfo.pageSize || skillsPageSize;
                    skillsTotalRecords = paginationInfo.totalRecords || 0;
                    skillsTotalPages = Math.ceil((paginationInfo.totalRecords || 0) / (paginationInfo.pageSize || skillsPageSize));
                    if (skillsTotalPages < 1) skillsTotalPages = 1;
                    console.log('Pagination info extracted - CurrentPage:', skillsCurrentPage, 'PageSize:', skillsPageSize, 'TotalRecords:', paginationInfo.totalRecords, 'TotalPages:', skillsTotalPages);
                } else {
                    if (skills && skills.length > 0) {
                        skillsTotalRecords = skills.length;
                        skillsTotalPages = Math.ceil(skills.length / skillsPageSize);
                        if (skillsTotalPages < 1) skillsTotalPages = 1;
                        paginationInfo = {
                            totalRecords: skills.length,
                            currentPage: skillsCurrentPage,
                            pageSize: skillsPageSize
                        };
                        console.log('No pagination info from API, using array length - TotalRecords:', skills.length, 'TotalPages:', skillsTotalPages);
                    }
                }

                console.log('Extracted Skills Data:', skills);
                console.log('Skills array length:', skills ? skills.length : 0);

                var $tbody = $('#tblSkillsBody');
                $tbody.empty();

                if (!skills || skills.length === 0) {
                    $tbody.html('<tr><td colspan="6" class="empty-state"><div>No data available in table</div></td></tr>');
                    $('#skillsPaginationContainer').hide();
                    console.log('No skills data to display');
                    return;
                }

                var rowsHTML = '';

                skills.forEach(function (skill, index) {
                    var employeeSkillID = skill.EmployeeSkillID || skill.employeeSkillID || 0;
                    var skillID = skill.SkillID || skill.skillID || skill.ToolID || skill.toolID || 0;
                    var skillsName = skill.Skill || skill.skill || '-';
                    var skillsName = skill.Skill || skill.skill || '-';
                    var experienceYears = skill.ExperienceYears || skill.experienceYears || '-';
                    var experienceMonths = skill.ExperienceMonths || skill.experienceMonths || '-';
                    var proficiency =
                        skill.Proficiency || skill.proficiency || '-';

                    var coreCompetency = skill.CoreCompetency !== undefined
                        ? skill.CoreCompetency
                        : (skill.coreCompetency !== undefined ? skill.coreCompetency : false);

                    var notes = skill.Notes || skill.notes || '';

                    var skillIdNum = parseInt(employeeSkillID);
                    if (isNaN(skillIdNum) || skillIdNum === 0) {
                        skillIdNum = 0;
                    }

                    var checkbox = '';
                    var isChecked = selectedSkillIDs.indexOf(skillIdNum) !== -1;
                    if (skillIdNum > 0) {
                        checkbox = '<input type="checkbox" class="skill-checkbox" data-skill-id="' + skillIdNum +
                            '" ' + (isChecked ? 'checked' : '') + ' style="display:block;margin:0 auto;" />';
                    } else {
                        checkbox = '<input type="checkbox" class="skill-checkbox" disabled style="display:block;margin:0 auto;" />';
                    }
                    rowsHTML += '<tr data-skill-id="' + (skillIdNum > 0 ? skillIdNum : index) + '" data-skill-index="' + index + '">' +
                        '<td>' +
                        '<a href="javascript:void(0);" onclick="OpenUpdateSkillModal(' +
                        employeeSkillID + ',' +
                        '\'' + skillID + '\',' +
                        '\'' + experienceYears + '\',' +
                        '\'' + experienceMonths + '\',' +
                        '\'' + proficiency + '\',' +
                        (coreCompetency ? 'true' : 'false') + ',' +
                        '\'' + escapeJsString(notes) + '\'' +
                        ')">' +
                        escapeHtml(skillsName) +
                        '</a>' +
                        '</td>' +
                        '<td>' + escapeHtml(String(experienceYears)) + '</td>' +
                        '<td>' + escapeHtml(String(experienceMonths)) + '</td>' +
                        '<td>' + escapeHtml(String(proficiency)) + '</td>' +
                        '<td>' + (coreCompetency ? 'Yes' : 'No') + '</td>' +
                        '<td style="text-align: center;">' + checkbox + '</td>' +
                        '</tr>';
                });

                $tbody.html(rowsHTML);

                var totalEnabledRecords = skillsTotalRecords; 
                var allSelected = totalEnabledRecords > 0 && selectedSkillIDs.length === totalEnabledRecords;
                $('#selectAllSkills').prop('checked', allSelected);

                if (paginationInfo && paginationInfo.totalRecords > 0) {
                    renderSkillsPagination(paginationInfo.totalRecords);
                } else if (skills && skills.length > 0) {
                    if (skills.length >= skillsPageSize) {
                        renderSkillsPagination(skills.length + 1);
                    } else {
                        renderSkillsPagination(skills.length);
                    }
                } else {
                    $('#skillsPaginationContainer').hide();
                }
                InitializeSkillCheckboxes();
            } catch (error) {
                console.error('Error loading skills:', error);
                if (typeof alertify !== 'undefined') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_Errorloadingskills")%> ' + (error.message || error));
                } else {
                    alertify.error('<%=MyBase.GetResourceString("A_Errorloadingskills")%>' + (error.message || error));
                }
            }
        }

        // Render Skills Pagination (matching Work Experience pagination exactly)
        function renderSkillsPagination(totalRecords) {
            var $container = $('#skillsPaginationContainer');
            var $prevBtn = $('#skillsFirstPageBtn');
            var $nextBtn = $('#skillsLastPageBtn');
            var $totalRecords = $('#skillsTotalRecords');

            if (!totalRecords || totalRecords === 0) {
                $container.hide();
                return;
            }
            if (skillsTotalPages <= 0) {
                skillsTotalPages = Math.ceil(totalRecords / skillsPageSize);
            }
            if (skillsTotalPages < 1) skillsTotalPages = 1;
            if (skillsTotalPages <= 1 && totalRecords <= skillsPageSize) {
                $container.hide();
                return;
            }
            $container.css('display', 'flex');
            $container.css('justify-content', 'space-between');
            $totalRecords.text('Total Records: ' + totalRecords);

            // Update Previous button
            $prevBtn.prop('disabled', skillsCurrentPage === 1);
            if (skillsCurrentPage === 1) {
                $prevBtn.css('opacity', '0.5');
                $prevBtn.css('cursor', 'not-allowed');
            } else {
                $prevBtn.css('opacity', '1');
                $prevBtn.css('cursor', 'pointer');
            }

            // Update Next button
            $nextBtn.prop('disabled', skillsCurrentPage >= skillsTotalPages);
            if (skillsCurrentPage >= skillsTotalPages) {
                $nextBtn.css('opacity', '0.5');
                $nextBtn.css('cursor', 'not-allowed');
            } else {
                $nextBtn.css('opacity', '1');
                $nextBtn.css('cursor', 'pointer');
            }
        }

        function goToSkillsPreviousPage() {
            if (skillsCurrentPage > 1) {
                skillsCurrentPage--;
                LoadSkills();
            }
        }
        function goToSkillsNextPage() {
            if (skillsCurrentPage < skillsTotalPages) {
                skillsCurrentPage++;
                LoadSkills();
            }
        }

        function SaveProfile_Onclick() {
            alertify.set('notifier', 'position', 'top-right');
            var employeeId = parseInt(UserId) || 0;
            if (!employeeId || employeeId === 0) {
                alertify.error('<%=MyBase.GetResourceString("A_EmployeeIDisrequired")%>');
                return;
            }
            var employeeName = $('#EmployeeName').val();
            if (!employeeName || employeeName.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_EmployeeNamerequired.")%>');
                $('#EmployeeName').focus();
                return;
            }
     
            var birthDate = $('#dtBirthDate').val();
            if (!birthDate || birthDate.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_BirthDateisrequired")%>');
              $('#dtBirthDate').focus();
               return;
                }

              var joiningDateText = $('#lblJoiningDate').text();
              if (birthDate && joiningDateText && joiningDateText !== '-' &&
               birthDate.trim() !== '' && joiningDateText.trim() !== '') {
               try {
               var birthDateObj = formatDateOnly(birthDate.trim());
                 var joiningDateObj = formatDateOnly(joiningDateText.trim());

                if (birthDateObj && joiningDateObj && birthDateObj > joiningDateObj) {
                        alertify.error('<%=MyBase.GetResourceString("A_Birthdatecanbegreaterthanjoiningdate.")%>');
                        $('#dtBirthDate').focus();
                        return;
                    }
                } catch (e) { }
            }

            var dateOfIssue = $('#dtDateOfIssue').val();
            var expiryDate = $('#dtExpiryDate').val();

            if (dateOfIssue && dateOfIssue.trim() !== '') {
                try {
                    var issueDateObj = formatDateOnly(dateOfIssue.trim());
                    var today = new Date();
                    today.setHours(0, 0, 0, 0); // ignore time

                    if (issueDateObj > today) {
                        $('#dtDateOfIssue').focus();
                        return; // stop execution if future date
                    }
                    if (expiryDate && expiryDate.trim() !== '') {
                        var expiryDateObj = formatDateOnly(expiryDate.trim());

                        if (expiryDateObj && issueDateObj > expiryDateObj) {
                            $('#dtExpiryDate').focus();
                            return; // stop execution if Issue Date > Expiry Date
                        }
                    }
                } catch (e) { }
            }

            var actualScore = $('#txtActualScore').val();
            var outOfScore = $('#txtOutOfScore').val();
            if (actualScore && outOfScore && actualScore.trim() !== '' && outOfScore.trim() !== '') {
                try {
                    var actual = parseFloat(actualScore.trim());
                    var outOf = parseFloat(outOfScore.trim());
                    if (!isNaN(actual) && !isNaN(outOf) && actual > outOf) {
                        alertify.error('<%=MyBase.GetResourceString("A_ActualscorecannotexceedtheOutofvalue.")%>');
                            $('#txtActualScore').focus();
                            return;
                        }
                } catch (e) { }
            }
            var invalidChars = invalidCharsPattern;
            var address = $('#txtAddress').val();
            if (address && invalidChars.test(address)) {
                alertify.error('<%=MyBase.GetResourceString("A_Addresscannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                $('#txtAddress').focus();
                return;
            }

            var city = ($('#txtPermanentCity').val() || '').trim();
            city = city.replace(/\s+/g, ' ');
            if (city && invalidChars.test(city)) {
                alertify.error('<%=MyBase.GetResourceString("A_ACitycannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                $('#txtPermanentCity').focus();
                return;
            }
            $('#txtPermanentCity').val(city);

            var numberPattern = /\d/;
            if (numberPattern.test(city)) {
                alertify.error('<%=MyBase.GetResourceString("A_cannotcontainNumbers")%>');
                return;
            }

            var currentCity = ($('#txtCurrentCity').val() || '').trim();
            currentCity = currentCity.replace(/\s+/g, ' ');
            if (currentCity && invalidChars.test(currentCity)) {
                alertify.error('<%=MyBase.GetResourceString("A_ACurrentCitycannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                $('#txtCurrentCity').focus();
                return;
            }
            $('#txtCurrentCity').val(currentCity);

            var numberPattern = /\d/;
            if (numberPattern.test(currentCity)) {
                alertify.error('<%=MyBase.GetResourceString("A_cannotcontainNumbers")%>');
                return;
            }
            var state = ($('#txtcboPermanentState').val() || '').trim();
            state = state.replace(/\s+/g, ' ');
            if (state && invalidChars.test(state)) {
                alertify.error('<%=MyBase.GetResourceString("A_AStatecannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                $('#txtcboPermanentState').focus();
                return;
            }
            $('#txtcboPermanentState').val(state);

            var numberPattern = /\d/;
            if (numberPattern.test(state)) {
                alertify.error('<%=MyBase.GetResourceString("A_cannotcontainNumbers")%>');
                return;
            }

            var currentAddress = $('#textCurrentAddress').val(); 
            if (currentAddress && invalidChars.test(currentAddress)) {
                alertify.error('<%=MyBase.GetResourceString("A_Addresscannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
            $('#textCurrentAddress').focus();
              return;
            }

            var currentState = ($('#txtcboCurrentState').val() || '').trim(); currentState = currentState.replace(/\s+/g, ' ');
            if (currentState && invalidChars.test(currentState)) {
                alertify.error('<%=MyBase.GetResourceString("A_ACurrentStatecannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                $('#txtcboCurrentState').focus();
                return;
            }
            $('#txtcboCurrentState').val(state);

            var numberPattern = /\d/;
            if (numberPattern.test(currentState)) {
                alertify.error('<%=MyBase.GetResourceString("A_cannotcontainNumbers")%>');
                return;
            }

            var fullName = ($('#txtPlaceOfIssue').val() || '').replace(/\s+/g, ' ').trim();
            $('#txtPlaceOfIssue').val(fullName);
            var placeOfIssue = ($('#txtPlaceOfIssue').val() || '').trim();
            if (placeOfIssue && invalidChars.test(placeOfIssue)) {
                alertify.error('<%=MyBase.GetResourceString("A_APlaceOfIssuecannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                $('#txtPlaceOfIssue').focus();
                return;
            }
            var fullName = ($('#txtFullName').val() || '').replace(/\s+/g, ' ').trim();
            $('#txtFullName').val(fullName);
            if (fullName && invalidChars.test(fullName)) {
                alertify.error('<%=MyBase.GetResourceString("A_AFullNamecannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                $('#txtFullName').focus();
                return;
            }

            var pinCode = ($('#txtPinCode').val() || '').trim();
            if (pinCode && pinCode !== '') {
                if (invalidChars.test(pinCode) || !/^\d+$/.test(pinCode)) {
                    alertify.dismissAll();
                    alertify.error('<%=MyBase.GetResourceString("A_Pleaseenteronlyintegervalue")%>' || 'Please enter only integer value');
                    $('#txtPinCode').focus();
                    return;
                }
                if (pinCode.length !== 6) {
                    alertify.dismissAll();
                    alertify.error('<%=MyBase.GetResourceString("A_PinCodemustbe6digits")%>');
                    $('#txtPinCode').focus();
                    return;
                }
            }
            var phone = ($('#txtPhone').val() || '').trim();
            if (phone && phone !== '' && (invalidChars.test(phone) || !/^\d+$/.test(phone))) {
                alertify.dismissAll();
                alertify.error('<%=MyBase.GetResourceString("A_Pleaseenteronlyintegervalue")%>' || 'Please enter only integer value');
                $('#txtPhone').focus();
                return;
            }
            var currentPinCode = ($('#txtCurrentPinCode').val() || '').trim();
            if (currentPinCode && currentPinCode !== '') {
                if (invalidChars.test(currentPinCode) || !/^\d+$/.test(currentPinCode)) {
                    alertify.dismissAll();
                    alertify.error('<%=MyBase.GetResourceString("A_Pleaseenteronlyintegervalue")%>' || 'Please enter only integer value');
                    $('#txtCurrentPinCode').focus();
                    return;
                }
                if (currentPinCode.length !== 6) {
                    alertify.dismissAll();
                    alertify.error('<%=MyBase.GetResourceString("A_PinCodemustbe6digits")%>');
                    $('#txtCurrentPinCode').focus();
                    return;
                }
            }
            var currentPhone = ($('#txtCurrentPhone').val() || '').trim();
            if (currentPhone && currentPhone !== '' && (invalidChars.test(currentPhone) || !/^\d+$/.test(currentPhone))) {
                alertify.dismissAll();
                alertify.error('<%=MyBase.GetResourceString("A_Pleaseenteronlyintegervalue")%>' || 'Please enter only integer value');
                $('#txtCurrentPhone').focus();
                return;
            }
            var mobileNumbers = ($('#txtMobileNumbers').val() || '').trim();
            if (mobileNumbers && mobileNumbers !== '' && (invalidChars.test(mobileNumbers) || !/^\d+$/.test(mobileNumbers))) {
                alertify.dismissAll();
                alertify.error('<%=MyBase.GetResourceString("A_Pleaseenteronlyintegervalue")%>' || 'Please enter only integer value');
                $('#txtMobileNumbers').focus();
                return;
            }

            var passportNumber = ($('#txtPassportNumber').val() || '') .replace(/\s+/g, '') .trim();
            $('#txtPassportNumber').val(passportNumber); 
            if (passportNumber && invalidChars.test(passportNumber)) {
                alertify.error('<%=MyBase.GetResourceString("A_APassportNumbercannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                $('#txtPassportNumber').focus();
                return;
            }

            var birthDateVal = $('#dtBirthDate').val();
            var dateOfIssueVal = $('#dtDateOfIssue').val();
            var expiryDateVal = $('#dtExpiryDate').val();
            var birthDateFormatted = (birthDateVal && birthDateVal.trim() !== '') ? formatDateOnly(birthDateVal.trim()) : null;
            var dateOfIssueFormatted = (dateOfIssueVal && dateOfIssueVal.trim() !== '') ? formatDateOnly(dateOfIssueVal.trim()) : null;
            var expiryDateFormatted = (expiryDateVal && expiryDateVal.trim() !== '') ? formatDateOnly(expiryDateVal.trim()) : null;

            const clean = v => v ? v.replace(/\s+/g, ' ').trim() : null;

       
            var updateData = {
                EmployeeID: employeeId,
                BloodGroup: $('#cboBloodGroup').val() || null,
                BirthDate: birthDateFormatted,
                Address: $('#txtAddress').val() || null,
                CurrentAddress: $('#textCurrentAddress').val() || null,
                City: $('#txtPermanentCity').val() || null,
                CurrentCity: $('#txtCurrentCity').val() || null,
                State: $('#txtcboPermanentState').val() || null,
                CurrentState: $('#txtcboCurrentState').val() || null,
                PinCode: $('#txtPinCode').val() || null,
                CurrentPinCode: $('#txtCurrentPinCode').val() || null,
                Phone: ($('#txtPhone').val() || '').replace(/\s/g, '') || null,
                CurrentPhone: ($('#txtCurrentPhone').val() || '').replace(/\s/g, '') || null,
                PassportNumber: $('#txtPassportNumber').val() || null,
                PP_DateOfIssue: dateOfIssueFormatted,
                PP_ExpiryDate: expiryDateFormatted,
                PP_FullName: $('#txtFullName').val() || null,
                PP_PlaceOfIssue: $('#txtPlaceOfIssue').val() || null,
                MobileNumber: ($('#txtMobileNumbers').val() || '').replace(/\s/g, '') || null,
               /* ProfilePicURL: $('#txtProfilePicURL').val() ||null,*/
                CommunicationID: ($('#txtInstantMessengerIds').val() && $('#txtInstantMessengerIds').val().trim()) ? $('#txtInstantMessengerIds').val().trim() : null
            };

            <%--alertify.message('<%=MyBase.GetResourceString("A_Savingprofile")%>', 0);--%>
            try {
                var param = JSON.stringify(updateData);
                var url = "api/MyProfile/UpdateEmployeeDetails";
                var result = AJAXCallWithResult(url, param, false);
                if (!result) {
                    alertify.dismissAll();
                    alertify.error('<%=MyBase.GetResourceString("A_FailedtoupdateprofileTheAPIreturnednoresponse.")%>');
                    return;
                }
                if (result.error || result.status === 'ERROR' || (result.status && result.status !== 'SUCCESS')) {
                    var errorMessage = result.message || result.error || result.data?.message || 'Failed to update profile';
                        alertify.dismissAll();
                    alertify.error('<%=MyBase.GetResourceString("A_Error")%> ' + errorMessage);
                    return;
                }
                var successDetected = false;
                var successMessage = 'Profile updated successfully!';
                if (result && result.message) {
                    successDetected = true;
                    successMessage = result.message;
                } else if (result && result.data && result.data.message) {
                    successDetected = true;
                    successMessage = result.data.message;
                } else if (result && result.status === 'SUCCESS') {
                    successDetected = true;
                    successMessage = result.message || result.data?.message || 'Profile updated successfully!';
                } else if (result && (result.rowsAffected !== undefined || (result.data && result.data.rowsAffected !== undefined))) {
                    successDetected = true;
                    var rowsAffected = result.rowsAffected || result.data.rowsAffected || 0;
                    successMessage = rowsAffected > 0 ? 'Profile updated successfully!' : 'Profile may not have been updated';
                }
                alertify.dismissAll();
                alertify.success('Profile updated successfully!');

                setTimeout(function () {
                    LoadEmployeeDetails();
                }, 500);

            } catch (error) {
                    alertify.dismissAll();
                alertify.error('<%=MyBase.GetResourceString("A_Errorupdatingprofile")%> ' + (error.message || error));
            }
        }
        var certificationsList = [];
        var certificationIdCounter = 1;

        // Save Certification from Modal - Using AJAXCallWithResult pattern (matching PM_TrainingPlan.aspx pattern)
        function SaveCertificationFromModal() {
                alertify.set('notifier', 'position', 'top-right');
            var employeeId = parseInt(UserId) || 0;
            if (!employeeId) {
                alertify.error('<%=MyBase.GetResourceString("A_EmployeeIDisrequired.")%>');
                return;
            }
            var certificationID = $('#certificationNameFilter').val();
            if (!certificationID || certificationID === '' || certificationID === '0') {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectaCertificationName")%>');
                return;
            }
            var selectedCertName = $('#certificationNameFilter option:selected').text().trim().toLowerCase();
            var isExists = false;
            $('#tblCertificationsBody tr').each(function () {
                if ($(this).find('td').eq(0).text().trim().toLowerCase() === selectedCertName) {
                    isExists = true;
                    return false;
                }
            });
            if (isExists) {
                alertify.error('<%=MyBase.GetResourceString("A_Certificationalreadyexists")%>');
                return;
            }
            var certificationDate = $('#modalCertificationDate').val();
            if (!certificationDate || certificationDate.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectCertificationDate")%>');
                return;
            }
            var validUpTo = $('#modalValidUpTo').val();
            if (validUpTo && validUpTo.trim() !== '') {
                try {
                    var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                    var parseDate = function(dateStr) {
                        var parts = dateStr.trim().split(/\s+/);
                        if (parts.length === 3) {
                            var month = monthNames.indexOf(parts[1]);
                            if (month !== -1) return new Date(parseInt(parts[2]), month, parseInt(parts[0], 10));
                    }
                        parts = dateStr.trim().split('/');
                        if (parts.length === 3) return new Date(parseInt(parts[2]), parseInt(parts[0]) - 1, parseInt(parts[1]));
                        return null;
                    };
                    var certDate = parseDate(certificationDate);
                    var validDate = parseDate(validUpTo);
                    if (certDate && validDate && validDate <= certDate) {
                        alertify.error('<%=MyBase.GetResourceString("A_ValidUpTodateshouldbegreaterthanCertificationdate.")%>');
                        $('#modalValidUpTo').focus();
                        return;
                    }
                } catch (e) { }
            }
            var score = $('#txtmodalScore').val() || null;
            var scoreOutOf = $('#txtmodalScoreOutOf').val() || null;

            if (score && score.trim() !== '' && !/^\d*\.?\d+$/.test(score.trim())) {
                alertify.error('<%=MyBase.GetResourceString("A_Pleaseenteronlynumericvalues")%>');
                $('#txtmodalScore').focus();
                        return;
                    }
            if (scoreOutOf && scoreOutOf.trim() !== '' && !/^\d*\.?\d+$/.test(scoreOutOf.trim())) {
                alertify.error('<%=MyBase.GetResourceString("A_Pleaseenteronlynumericvalues")%>');
                $('#txtmodalScoreOutOf').focus();
                return;
            }
            var scoreValue = null;
            var scoreOutOfValue = null;
            if (score && score.trim() !== '') {
                var scoreNum = parseInt(score.trim());
                scoreValue = (!isNaN(scoreNum) && scoreNum >= 0) ? scoreNum : null;
            }
            if (scoreOutOf && scoreOutOf.trim() !== '') {
                var outOfNum = parseInt(scoreOutOf.trim());
                scoreOutOfValue = (!isNaN(outOfNum) && outOfNum >= 0) ? outOfNum : null;
            }

            if (scoreValue !== null && scoreOutOfValue !== null && scoreValue > scoreOutOfValue) {
                alertify.error('<%=MyBase.GetResourceString("A_ScorecannotbegreaterthanOutofScore.")%>');
                $('#txtmodalScore').focus();
                return;
            }
            var apiData = {
                EmployeeID: employeeId,
                CertificationID: parseInt(certificationID),
                CertificationDate: formatDateOnly(certificationDate),
                ValidUptoDate: formatDateOnly(validUpTo),
                ActualScore: scoreValue,
                OutOf: scoreOutOfValue
            };

            try {
                var result = AJAXCallWithResult("api/MyProfile/AddEmployeeCertificationDetails", JSON.stringify(apiData), false);

                if (!result) {
                    alertify.error('<%=MyBase.GetResourceString("A_FailedtoaddcertificationTheAPIreturnednoresponse.")%>');
                    return;
                }

                if (result.error || result.status === 'ERROR' || (result.status && result.status !== 'SUCCESS')) {
                    alertify.error('<%=MyBase.GetResourceString("A_Erroraddingcertification")%> ' + (result.message || result.error || result.data?.message || 'Failed to add certification'));
                    return;
                }

                var successMessage = 'Certification added successfully!';
                if (result.message && (result.message.toLowerCase().includes('success') || result.message.toLowerCase().includes('added'))) {
                    successMessage = result.message;
                } else if (result.data && result.data.message && (result.data.message.toLowerCase().includes('success') || result.data.message.toLowerCase().includes('added'))) {
                    successMessage = result.data.message;
                }

                    var offcanvasEl = document.getElementById('certificationModal_OffCanvas');
                    var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                if (bsOffcanvas) bsOffcanvas.hide();

                    var $form = $('#certificationModal_OffCanvas');
                    if ($form.length) {
                        $form.find('input, select, textarea').val('').trigger('change');
                        $('#certificationNameFilter').selectpicker('refresh');
                    }

                    alertify.success(successMessage);
                    setTimeout(function () {
                    certCurrentPage = 1;
                        LoadCertifications();
                    }, 500);
            } catch (error) {
                alertify.error('<%=MyBase.GetResourceString("A_Erroraddingcertification")%> ' + (error.message || error));
            }
        }

        function formatDateOnly(dateStr) {
            if (!dateStr || dateStr.trim() === '') {
                return null;
            }
            try {
                dateStr = dateStr.trim();
                
                var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                var parts = dateStr.split(/\s+/);
                if (parts.length === 3) {
                    var day = parseInt(parts[0], 10);
                    var monthName = parts[1].charAt(0).toUpperCase() + parts[1].slice(1).toLowerCase();
                    var year = parseInt(parts[2], 10);
                    var monthIndex = monthNames.indexOf(monthName);
                    if (monthIndex !== -1 && !isNaN(day) && !isNaN(year)) {
                        var d = new Date(year, monthIndex, day);
                        return new Date(d.getFullYear(), d.getMonth(), d.getDate());
                    }
                }
                parts = dateStr.split('/');
                if (parts.length === 3) {
                    var month = parseInt(parts[0], 10) ;
                    var day = parseInt(parts[1], 10);
                    var year = parseInt(parts[2], 10);
                    if (!isNaN(month) && !isNaN(day) && !isNaN(year)) {
                        var d = new Date(year, month, day);
                        return new Date(d.getFullYear(), d.getMonth(), d.getDate());
                    }
                }
                
                var d = new Date(dateStr);
                if (!isNaN(d.getTime())) {
                    return new Date(d.getFullYear(), d.getMonth(), d.getDate());
                }
            } catch (e) {
                console.error('Error in formatDateOnly:', e, 'Input:', dateStr);
            }
            return null;
        }

        //Save Updated Certification From Modal
        function SaveUpdatedCertificationFromModal() {
            var employeeId = parseInt(UserId) || 0;

            if (!employeeId || employeeId === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_EmployeeIDisrequired.")%>');
                return;
            }
            var certificationID = $('#updateCertificationForm').val();
            if (!certificationID || certificationID === '' || certificationID === '0') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectaCertificationName")%>');
                return;
            }

            var certName = $('#updateCertificationForm option:selected').text().trim();
            var empCertId = $('#updateEmployeeCertificationID').val();

            if ($('#tblCertificationsBody tr').filter(function () {
                return $(this).data('certification-id') != empCertId &&
                    $(this).find('td:first').text().trim() === certName;
            }).length) {
                alertify.error('<%=MyBase.GetResourceString("A_Certificationalreadyexists")%>');
                return;
            }

            var certificationDate = $('#updateCertificationDate').val();
            if (!certificationDate || certificationDate.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectCertificationDate")%>');
                return;
            }

            var validUpTo = $('#updateValidUpTo').val();
            if (validUpTo && validUpTo.trim() !== '') {
                try {
                    var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                    var certDate = null, validDate = null;
                    
                    var certParts = certificationDate.trim().split(/\s+/);
                    if (certParts.length === 3) {
                        var day = parseInt(certParts[0], 10);
                        var month = monthNames.indexOf(certParts[1]);
                        var year = parseInt(certParts[2], 10);
                        if (month !== -1) certDate = new Date(year, month, day);
                    }       
                    var validParts = validUpTo.trim().split(/\s+/);
                    if (validParts.length === 3) {
                        var day = parseInt(validParts[0], 10);
                        var month = monthNames.indexOf(validParts[1]);
                        var year = parseInt(validParts[2], 10);
                        if (month !== -1) validDate = new Date(year, month, day);
                    }
                    
                    if (!certDate) {
                        certParts = certificationDate.trim().split('/');
                        if (certParts.length === 3) {
                            certDate = new Date(parseInt(certParts[2]), parseInt(certParts[0]) - 1, parseInt(certParts[1]));
                        }
                    }
                    if (!validDate) {
                        validParts = validUpTo.trim().split('/');
                        if (validParts.length === 3) {
                            validDate = new Date(parseInt(validParts[2]), parseInt(validParts[0]) - 1, parseInt(validParts[1]));
                        }
                    }
                    if (certDate && validDate && validDate <= certDate) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('<%=MyBase.GetResourceString("A_ValidUpTodateshouldbegreaterthanCertificationdate.")%>');
                        $('#updateValidUpTo').focus();
                        return;
                    }
                } catch (e) {
                    console.warn("Date comparison error:", e);
                }
            }
            var score = $('#updateScore').val() || null;
            var scoreOutOf = $('#updateScoreOutOf').val() || null;

            if (score && score.trim() !== '' && !/^\d*\.?\d+$/.test(score.trim())) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Pleaseenteronlynumericvalues")%>');
                $('#updateScore').focus();
                return;
            }
            if (scoreOutOf && scoreOutOf.trim() !== '' && !/^\d*\.?\d+$/.test(scoreOutOf.trim())) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Pleaseenteronlynumericvalues")%>');
                $('#updateScoreOutOf').focus();
                return;
            }
            var scoreValue = null;
            var scoreOutOfValue = null;
            if (score && score.trim() !== '') {
                var scoreNum = parseInt(score.trim());
                scoreValue = (!isNaN(scoreNum) && scoreNum >= 0) ? scoreNum : null;
            }
            if (scoreOutOf && scoreOutOf.trim() !== '') {
                var outOfNum = parseInt(scoreOutOf.trim());
                scoreOutOfValue = (!isNaN(outOfNum) && outOfNum >= 0) ? outOfNum : null;
            }
            if (scoreValue !== null && scoreOutOfValue !== null && scoreValue > scoreOutOfValue) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ScorecannotbegreaterthanOutofScore.")%>');
                $('#updateScore').focus();
                return;
            }

            var employeeCertificationID = $('#updateEmployeeCertificationID').val();
            var apiData = {
                EmployeeCertificationID: parseInt(employeeCertificationID),
                EmployeeID: employeeId,
                CertificationID: parseInt(certificationID),
                CertificationDate: formatDateOnly(certificationDate),
                ValidUptoDate: formatDateOnly(validUpTo),
                ActualScore: scoreValue,
                TotalScore: scoreOutOfValue
            };

            try {
                var param = JSON.stringify(apiData);
                var url = "api/MyProfile/UpdateEmployeeCertification";
                var result = AJAXCallWithResult(url, param, false);

                if (!result) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_Failedtoupdatecertification.")%>');
                    return;
                }

                if (result.error || 
                    result.status === 'ERROR' || 
                    result.Status === 'ERROR' ||
                    (result.status && result.status !== 'SUCCESS') ||
                    (result.Status && result.Status !== 'SUCCESS')) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(result.message || result.Message || 'Failed to update certification.');
                    return;
                }

                // Success detection
                var success = false;
                var successMessage = "Certification updated successfully!";
                if (result.Status === 'SUCCESS' || result.status === 'SUCCESS') {
                    success = true;
                    var rowsAffected = (result.Data && result.Data.rowsAffected !== undefined) ? result.Data.rowsAffected : 
                                      ((result.data && result.data.rowsAffected !== undefined) ? result.data.rowsAffected : 
                                      (result.rowsAffected !== undefined ? result.rowsAffected : 0));
                    if (rowsAffected > 0) {
                        success = true;
                    }
                    if (result.Data && result.Data.message) {
                        successMessage = result.Data.message;
                    } else if (result.data && result.data.message) {
                        successMessage = result.data.message;
                    } else if (result.message) {
                        successMessage = result.message;
                    }
                } else if (result.message && result.message.toLowerCase().includes('success')) {
                    success = true;
                    successMessage = result.message;
                } else if (result.data?.message && result.data.message.toLowerCase().includes('success')) {
                    success = true;
                    successMessage = result.data.message;
                } else if (result.rowsAffected > 0 || result.data?.rowsAffected > 0 || result.Data?.rowsAffected > 0) {
                    success = true;
                } else {
                    success = true;
                }

                if (success) {
                    var offcanvasEl = document.getElementById('UpdateCertificationModal_OffCanvas');
                    var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                    if (bsOffcanvas) bsOffcanvas.hide();
                    $('#updateCertificationForm')
                        .find('input, select, textarea')
                        .val('')
                        .trigger('change');

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success(successMessage);
                    if (typeof certCurrentPage !== 'undefined') {
                        certCurrentPage = 1;
                    }
                    setTimeout(function() {
                        if (typeof LoadCertifications === 'function') {
                            LoadCertifications();
                        } else if (typeof LoadEmployeeCertifications === 'function') {
                            LoadEmployeeCertifications(employeeId);
                        }
                    }, 300); 

                }
            } catch (e) {
                alertify.error('<%=MyBase.GetResourceString("A_Unexpectederroroccurredwhileupdating.")%>');
                console.error(e);
            }
        }
        var pendingDeleteItems = [];

        // Delete certification row
        function DeleteCertificationRow(id) {
            window.pendingDeleteId = id;
            window.pendingDeleteType = 'certification';
            var messageText = '<%=MyBase.GetResourceString("A_Areyousureyouwanttodeletetheselectedrecords")%>' || 'Are you sure, you want to delete the selected records?';
            $('#CheckModal').html(messageText);
            var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            deleteModal.show();
        }

        // Delete Confirm 
        function OpenDeleteConfirmModal() {
            var selectedCheckboxes = $('.certification-checkbox:checked');
            if (selectedCheckboxes.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Pleaseselectatleastonerecordtodelete.")%>');
                return;
            }
            window.pendingDeleteItems = selectedCheckboxes;
            window.pendingDeleteType = 'certification';
            var messageText = '<%=MyBase.GetResourceString("A_Areyousureyouwanttodeletetheselectedrecords")%>' || 'Are you sure, you want to delete the selected records?';
            $('#CheckModal').html(messageText);
            var modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            modal.show();
        }

        function DeleteConfirmation() {
            var selectedCheckboxes = window.pendingDeleteItems;
            var deleteType = window.pendingDeleteType || 'certification';
            if (!selectedCheckboxes || selectedCheckboxes.length === 0) {
                alertify.error('<%=MyBase.GetResourceString("A_SelectRecordsFromtable")%>');
                return;
            }
            var deletedCount = 0;
            var failedCount = 0;
            selectedCheckboxes.each(function () {
                var $row = $(this).closest('tr');
                var id, param, url;
                if (deleteType === 'qualification') {
                    id = parseInt($(this).data('qualification-id'));
                    param = JSON.stringify({ EmployeeQualificationID: id });
                    url = "api/MyProfile/DeleteEmployeeQualification";
                } else if (deleteType === 'workexperience') {
                    id = parseInt($(this).data('workexperience-id'));
                    param = JSON.stringify({ EmployeeHistoryID: id });
                    url = "api/MyProfile/DeleteEmployeeWorkHistory";
                } else if (deleteType === 'assignment') {
                    id = parseInt($(this).data('assignment-id'));
                    param = JSON.stringify({ EmployeeHistoryProjectID: id });
                    url = "api/MyProfile/DeleteEmployeeHistoryAssignment";
                } else if (deleteType === 'skill') {
                    id = parseInt($(this).data('skill-id'));
                    param = JSON.stringify({ EmployeeSkillID: id });
                    url = "api/MyProfile/DeleteEmployeeSkill";
                } else {
                    id = parseInt($(this).data('certification-id'));
                    param = JSON.stringify({ EmployeeCertificationID: id });
                    url = "api/MyProfile/DeleteEmployeeCertifications";
                }
                if (id && id > 0) {
                    try {
                        var result = AJAXCallWithResult(url, param, false);
                        if (result && !result.error && result.status !== 'ERROR' && (result.status === 'SUCCESS' || result.message && result.message.toLowerCase().includes('success'))) {
                            deletedCount++;
                            $row.remove();
                        } else {
                            failedCount++;
                        }
                    } catch (err) {
                        failedCount++;
                    }
                } else {
                    failedCount++;
                }
            });
            if (deleteType === 'qualification') {
                var remain = $('#tblQualificationsBody tr').not('.empty-state').length;
                if (remain === 0) {
                    $('#tblQualificationsBody').html('<tr><td colspan="6" class="empty-state"><div>There are no items to show in this view.</div></td></tr>');
                }
                if (deletedCount > 0 && typeof LoadQualifications === 'function') {
                    if (remain === 0 && qualCurrentPage > 1) qualCurrentPage = 1;
                    LoadQualifications();
                }
            } else if (deleteType === 'workexperience') {
                var remain = $('#tblWorkExperienceBody tr').not('.empty-state').length;
                if (remain === 0) {
                    $('#tblWorkExperienceBody').html('<tr><td colspan="6" class="empty-state"><div>There are no items to show in this view.</div></td></tr>');
                }
                if (deletedCount > 0 && typeof LoadWorkExperience === 'function') {
                    if (remain === 0 && workExpCurrentPage > 1) workExpCurrentPage = 1;
                    LoadWorkExperience();
                }
            } else if (deleteType === 'assignment') {
                var remain = $('#tblAssignmentsBody tr').not('.empty-state').length;
                if (remain === 0) {
                    $('#tblAssignmentsBody').html('<tr><td colspan="7" class="empty-state"><div>There are no items to show in this view.</div></td></tr>');
                }
                if (deletedCount > 0 && typeof LoadAssignments === 'function') {
                    if (remain === 0 && assignmentsCurrentPage > 1) assignmentsCurrentPage = 1;
                    LoadAssignments();
                }
            } else if (deleteType === 'skill') {
                var remain = $('#tblSkillsBody tr').not('.empty-state').length;
                if (remain === 0) {
                    $('#tblSkillsBody').html('<tr><td colspan="6" class="empty-state"><div>There are no items to show in this view.</div></td></tr>');
                }
                if (deletedCount > 0 && typeof LoadSkills === 'function') {
                    if (remain === 0 && skillsCurrentPage > 1) skillsCurrentPage = 1;
                    LoadSkills();
                }
            } else {
                var remain = $('#tblCertificationsBody tr').not('.empty-state').length;
                if (remain === 0) {
                    $('#tblCertificationsBody').html('<tr><td colspan="4" class="empty-state"><div>There are no items to show in this view.</div></td></tr>');
                }
                if (deletedCount > 0 && typeof LoadCertifications === 'function') {
                    if (remain === 0 && certCurrentPage > 1) certCurrentPage = 1;
                    LoadCertifications();
                }
            }
            alertify.set('notifier', 'position', 'top-right');
            if (deletedCount > 0) alertify.success(deletedCount + " record(s) deleted successfully.");
            if (failedCount > 0) alertify.error(failedCount + " record(s) failed to delete.");
            window.pendingDeleteItems = [];
            window.pendingDeleteType = null;
            var modal = bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal'));
            if (modal) modal.hide();
        }

        function CancelConfirmation() {
            window.pendingDeleteItems = [];
                        window.pendingDeleteType = null;
            var modal = bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal'));
            if (modal) modal.hide();
        }

        function showDeleteSuccess() {
            var deleteModal = bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal'));
            if (deleteModal) {
                deleteModal.hide();
            }
            if (typeof alertify !== 'undefined') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_Recorddeletedsuccessfully.")%>');
            } else {
                alertify.success('<%=MyBase.GetResourceString("A_Recorddeletedsuccessfully.")%>');
            }
            window.pendingDeleteId = null;
            window.pendingDeleteType = null;
        }

        // Fetch all Qualification IDs from all pages
        function fetchAllCertificationIDs(callback) {
            try {
                var employeeId = parseInt(UserId) || 0;
                if (!employeeId || employeeId === 0) {
                    if (callback) callback([]);
                    return;
                    }
                var param = {
                    EmployeeID: employeeId,
                    PageNumber: 1,
                    PageSize: 9999
                };
                param = JSON.stringify(param);
                var url = "api/MyProfile/GetCertificationEmployees";
                var result = AJAXCallWithResult(url, param, false);
                var allIDs = [];
                if (result && result.data && Array.isArray(result.data)) {
                    result.data.forEach(function (cert) {
                        var id = cert.EmployeeCertificationID || cert.employeeCertificationID;
                        if (id && id !== 0) {
                            allIDs.push(id);
                        }
                    });
                } else if (Array.isArray(result)) {
                    result.forEach(function (cert) {
                        var id = cert.EmployeeCertificationID || cert.employeeCertificationID;
                        if (id && id !== 0) {
                            allIDs.push(id);
                        }
                    });
                }
                if (callback) callback(allIDs);
            } catch (error) {
                console.error('Error fetching all Certification IDs:', error);
                if (callback) callback([]);
            }
        }

        function fetchAllQualificationIDs(callback) {
            try {
                var employeeId = parseInt(UserId) || 0;

                if (!employeeId || employeeId === 0) {
                    console.warn('Employee ID not available for fetching all Qualification IDs');
                    if (callback) callback([]);
                    return;
                }
                var param = {
                    EmployeeID: employeeId,
                    PageNumber: 1,
                    PageSize: 9999
                };
                param = JSON.stringify(param);

                var url = "api/MyProfile/GetEmployeeQualifications";
                var result = AJAXCallWithResult(url, param, false);
                var allIDs = [];
                if (result && result.data && Array.isArray(result.data)) {
                    result.data.forEach(function (qual) {
                        var id = qual.EmployeeQualificationID || qual.employeeQualificationID;
                        if (id && id !== 0) allIDs.push(id);
                    });
                } else if (result && result.data && result.data.EmployeeQualificationentity && Array.isArray(result.data.EmployeeQualificationentity)) {
                    result.data.EmployeeQualificationentity.forEach(function (qual) {
                        var id = qual.EmployeeQualificationID || qual.employeeQualificationID;
                        if (id && id !== 0) allIDs.push(id);
                    });
                } else if (Array.isArray(result)) {
                    result.forEach(function (qual) {
                        var id = qual.EmployeeQualificationID || qual.employeeQualificationID;
                        if (id && id !== 0) allIDs.push(id);
                    });
                }
                if (callback) callback(allIDs);

            } catch (error) {
                console.error('Error fetching all Qualification IDs:', error);
                if (callback) callback([]);
            }
        }

        // Fetch all Work Experience IDs from all pages
        function fetchAllWorkExperienceIDs(callback) {
            try {
                var employeeId = parseInt(UserId) || 0;

                if (!employeeId || employeeId === 0) {
                    console.warn('Employee ID not available for fetching all Work Experience IDs');
                    if (callback) callback([]);
                    return;
                }

                var param = {
                    EmployeeID: employeeId,
                    PageNumber: 1,
                    PageSize: 9999 
                };
                param = JSON.stringify(param);

                var url = "api/MyProfile/GetEmployeeWorkExperience";
                var result = AJAXCallWithResult(url, param, false);

                var allIDs = [];
                var workExp = [];
                if (result && result.data && result.data.EmployeeWorkExperienceEntity && Array.isArray(result.data.EmployeeWorkExperienceEntity)) {
                    workExp = result.data.EmployeeWorkExperienceEntity;
                } else if (result && result.data && Array.isArray(result.data)) {
                    workExp = result.data;
                } else if (Array.isArray(result)) {
                    workExp = result;
                }

                workExp.forEach(function (exp) {
                    var id = exp.EmployeeHistoryID || exp.employeeHistoryID;
                    if (id && id !== 0) allIDs.push(id);
                });
                if (callback) callback(allIDs);
            } catch (error) {
                console.error('Error fetching all Work Experience IDs:', error);
                if (callback) callback([]);
            }
        }

        // Fetch all Assignment IDs from all pages
        function fetchAllAssignmentIDs(callback) {
            try {
                var employeeId = parseInt(UserId) || 0;
                if (!employeeId || employeeId === 0) {
                    console.error('Employee ID not available for fetching all Assignment IDs');
                    if (callback) callback([]);
                    return;
                }
                var param = {
                    EmployeeID: employeeId,
                    PageNumber: 1,
                    PageSize: 9999
                };
                param = JSON.stringify(param);
                var url = "api/MyProfile/GetEmployeeHistoryAssignment";
                var result = AJAXCallWithResult(url, param, false);

                var allIDs = [];
                var assignments = [];
                if (result && result.data && result.data.EmployeeHistoryAssignmentEntity && Array.isArray(result.data.EmployeeHistoryAssignmentEntity)) {
                    assignments = result.data.EmployeeHistoryAssignmentEntity;
                } else if (result && result.data && Array.isArray(result.data)) {
                    assignments = result.data;
                } else if (Array.isArray(result)) {
                    assignments = result;
                }

                assignments.forEach(function (assign) {
                    var id = assign.EmployeeHistoryProjectID || assign.employeeHistoryProjectID;
                    if (id && id !== 0) allIDs.push(id);
                });
                if (callback) callback(allIDs);
            } catch (error) {
                console.error('Error fetching all Assignment IDs:', error);
                if (callback) callback([]);
            }
        }

        // Generic checkbox handler for all tabs
        function initializeCheckboxes(config) {
            var selectAllId = config.selectAllId;
            var checkboxClass = config.checkboxClass;
            var dataAttr = config.dataAttr;
            var selectedArray = config.selectedArray;
            var fetchAllFn = config.fetchAllFn;
            var tbodySelector = config.tbodySelector;
            var totalRecords = config.totalRecords;
            var selectAllSelector = '#' + selectAllId;
            $(selectAllSelector).off('change').on('change', function () {
                var isChecked = $(this).is(':checked');
                if (isChecked) {
                    if (fetchAllFn) {
                        fetchAllFn(function (allIDs) {
                            selectedArray.length = 0;
                        allIDs.forEach(function (id) {
                                var itemId = parseInt(id) || 0;
                                if (itemId > 0) selectedArray.push(itemId);
                            });
                            var $checkboxes = $(tbodySelector + ' .' + checkboxClass + ':not(:disabled)');
                            $checkboxes.prop('checked', true);
                        });
                } else {
                        selectedArray.length = 0;
                        var $checkboxes = $(tbodySelector + ' .' + checkboxClass + ':not(:disabled)');
                        $checkboxes.each(function () {
                            var itemId = parseInt($(this).data(dataAttr)) || 0;
                            if (itemId > 0) selectedArray.push(itemId);
                    });
                        $checkboxes.prop('checked', true);
                    }
                } else {
                    selectedArray.length = 0;
                    var $checkboxes = $(tbodySelector + ' .' + checkboxClass + ':not(:disabled)');
                    $checkboxes.prop('checked', false);
                }
            });
            $(document).off('change', '.' + checkboxClass).on('change', '.' + checkboxClass, function () {
                var itemId = parseInt($(this).data(dataAttr));
                var isChecked = $(this).is(':checked');
                if (itemId && itemId > 0) {
                    var index = selectedArray.indexOf(itemId);
                    if (isChecked && index === -1) {
                        selectedArray.push(itemId);
                    } else if (!isChecked && index !== -1) {
                        selectedArray.splice(index, 1);
                    }
                    }
                var allSelected = totalRecords > 0 && selectedArray.length === totalRecords;
                $(selectAllSelector).prop('checked', allSelected);
            });
        }

        function InitializeCertificationFilter() {
            $('#selectAllCertifications').off('change').on('change', function () {
                var isChecked = $(this).is(':checked');

                if (isChecked) {
                    fetchAllCertificationIDs(function (allIDs) {
                        selectedCertificationIDs = [];
                        allIDs.forEach(function (id) {
                            var certId = parseInt(id) || 0;
                            if (certId > 0 && selectedCertificationIDs.indexOf(certId) === -1) {
                                selectedCertificationIDs.push(certId);
                            }
                        });

                        $('#tblCertificationsBody .certification-checkbox:not(:disabled)').each(function () {
                            var certId = parseInt($(this).data('certification-id'));
                            if (certId && certId > 0 && selectedCertificationIDs.indexOf(certId) !== -1) {
                                $(this).prop('checked', true);
                            }
                        });
                        console.log(
                            'Selected all Certification IDs across all pages. Total selected:',
                            selectedCertificationIDs.length
                        );
                    });

                } else {
                    selectedCertificationIDs = [];
                    $('#tblCertificationsBody .certification-checkbox:not(:disabled)').each(function () {
                        $(this).prop('checked', false);
                    });

                    console.log(
                        'Unselected all Certification IDs across all pages. Total selected:',
                        selectedCertificationIDs.length
                    );
                }
            });

            $(document).off('change', '.certification-checkbox').on('change', '.certification-checkbox', function () {
                var certId = parseInt($(this).data('certification-id'));
                var isChecked = $(this).is(':checked');
                if (certId && certId > 0) {
                    if (isChecked) {
                        if (selectedCertificationIDs.indexOf(certId) === -1) {
                            selectedCertificationIDs.push(certId);
                        }
                    } else {
                        var index = selectedCertificationIDs.indexOf(certId);
                        if (index !== -1) {
                            selectedCertificationIDs.splice(index, 1);
                        }
                    }
                }
                var totalEnabledRecords = certTotalRecords; 
                var allSelected = totalEnabledRecords > 0 && selectedCertificationIDs.length === totalEnabledRecords;
                $('#selectAllCertifications').prop('checked', allSelected);
            });
        }

        function InitializeQualificationCheckboxes() {
            $('#selectAllQualifications').off('change').on('change', function () {
                var isChecked = $(this).is(':checked');
                if (isChecked) {
                    fetchAllQualificationIDs(function (allIDs) {
                        selectedQualificationIDs = [];
                        allIDs.forEach(function (id) {
                            var qualId = parseInt(id) || 0;
                            if (qualId > 0 && selectedQualificationIDs.indexOf(qualId) === -1) {
                                selectedQualificationIDs.push(qualId);
                            }
                        });
                        $('#tblQualificationsBody .qualification-checkbox:not(:disabled)').each(function () {
                            var qualId = parseInt($(this).data('qualification-id'));
                            if (qualId && qualId > 0 && selectedQualificationIDs.indexOf(qualId) !== -1) {
                                $(this).prop('checked', true);
                            }
                        });
                    });
                } else {
                    selectedQualificationIDs = [];
                    $('#tblQualificationsBody .qualification-checkbox:not(:disabled)').each(function () {
                        $(this).prop('checked', false);
                    });
                }
            });
            $(document).off('change', '.qualification-checkbox').on('change', '.qualification-checkbox', function () {
                var qualId = parseInt($(this).data('qualification-id'));
                var isChecked = $(this).is(':checked');
                if (qualId && qualId > 0) {
                    if (isChecked) {
                        if (selectedQualificationIDs.indexOf(qualId) === -1) {
                            selectedQualificationIDs.push(qualId);
                        }
                    } else {
                        var index = selectedQualificationIDs.indexOf(qualId);
                        if (index !== -1) {
                            selectedQualificationIDs.splice(index, 1);
                        }
                    }
                }
                var allSelected = qualTotalRecords > 0 && selectedQualificationIDs.length === qualTotalRecords;
                $('#selectAllQualifications').prop('checked', allSelected);
            });
        }

        function InitializeWorkExperienceCheckboxes() {
            $('#selectAllWorkExperience').off('change').on('change', function () {
                var isChecked = $(this).is(':checked');
                if (isChecked) {
                    fetchAllWorkExperienceIDs(function (allIDs) {
                        selectedWorkExperienceIDs = [];
                        allIDs.forEach(function (id) {
                            var expId = parseInt(id) || 0;
                            if (expId > 0 && selectedWorkExperienceIDs.indexOf(expId) === -1) {
                                selectedWorkExperienceIDs.push(expId);
                            }
                        });
                        $('#tblWorkExperienceBody .workexperience-checkbox:not(:disabled)').each(function () {
                            var expId = parseInt($(this).data('workexperience-id'));
                            if (expId && expId > 0 && selectedWorkExperienceIDs.indexOf(expId) !== -1) {
                                    $(this).prop('checked', true);
                            }
                        });
                    });
                } else {
                    selectedWorkExperienceIDs = [];
                    $('#tblWorkExperienceBody .workexperience-checkbox:not(:disabled)').each(function () {
                        $(this).prop('checked', false);
                    });
                }
            });
            $(document).off('change', '.workexperience-checkbox').on('change', '.workexperience-checkbox', function () {
                var expId = parseInt($(this).data('workexperience-id'));
                var isChecked = $(this).is(':checked');
                if (expId && expId > 0) {
                    if (isChecked) {
                        if (selectedWorkExperienceIDs.indexOf(expId) === -1) {
                            selectedWorkExperienceIDs.push(expId);
                        }
                    } else {
                        var index = selectedWorkExperienceIDs.indexOf(expId);
                        if (index !== -1) {
                            selectedWorkExperienceIDs.splice(index, 1);
                        }
                    }
                }
                var allSelected = workExpTotalRecords > 0 && selectedWorkExperienceIDs.length === workExpTotalRecords;
                $('#selectAllWorkExperience').prop('checked', allSelected);
            });
        }

        function InitializeAssignmentCheckboxes() {
            $('#selectAllAssignments').off('change').on('change', function () {
                var isChecked = $(this).is(':checked');
                if (isChecked) {
                    fetchAllAssignmentIDs(function (allIDs) {
                        selectedAssignmentIDs = [];
                        allIDs.forEach(function (id) {
                            var assignId = parseInt(id) || 0;
                            if (assignId > 0 && selectedAssignmentIDs.indexOf(assignId) === -1) {
                                selectedAssignmentIDs.push(assignId);
                            }
                        });
                        $('#tblAssignmentsBody .assignment-checkbox:not(:disabled)').each(function () {
                            var assignId = parseInt($(this).data('assignment-id'));
                            if (assignId && assignId > 0 && selectedAssignmentIDs.indexOf(assignId) !== -1) {
                                $(this).prop('checked', true);
                            }
                        });
                    });
                } else {
                    selectedAssignmentIDs = [];
                    $('#tblAssignmentsBody .assignment-checkbox:not(:disabled)').each(function () {
                        $(this).prop('checked', false);
                    });
                }
            });
            $(document).off('change', '.assignment-checkbox').on('change', '.assignment-checkbox', function () {
                var assignId = parseInt($(this).data('assignment-id'));
                var isChecked = $(this).is(':checked');
                if (assignId && assignId > 0) {
                    if (isChecked) {
                        if (selectedAssignmentIDs.indexOf(assignId) === -1) {
                            selectedAssignmentIDs.push(assignId);
                        }
                    } else {
                        var index = selectedAssignmentIDs.indexOf(assignId);
                        if (index !== -1) {
                            selectedAssignmentIDs.splice(index, 1);
                        }
                    }
                }
                var allSelected = assignmentsTotalRecords > 0 && selectedAssignmentIDs.length === assignmentsTotalRecords;
                $('#selectAllAssignments').prop('checked', allSelected);
            });
        }

        function fetchAllSkillIDs(callback) {
            try {
                var employeeId = parseInt(UserId) || 0;
                if (!employeeId || employeeId === 0) {
                    if (callback) callback([]);
                    return;
                }
                var param = {
                    EmployeeID: employeeId,
                    PageNumber: 1,
                    PageSize: 9999
                };
                param = JSON.stringify(param);
                var url = "api/MyProfile/GetEmployeeSkillMatrix";
                var result = AJAXCallWithResult(url, param, false);
                var allIDs = [];
                if (result && result.data && result.data.data && Array.isArray(result.data.data)) {
                    result.data.data.forEach(function (skill) {
                        var id = skill.EmployeeSkillID || skill.employeeSkillID;
                        if (id && id !== 0) allIDs.push(id);
                    });
                } else if (result && result.data && Array.isArray(result.data)) {
                    result.data.forEach(function (skill) {
                        var id = skill.EmployeeSkillID || skill.employeeSkillID;
                        if (id && id !== 0) allIDs.push(id);
                    });
                } else if (result && result.data && result.data.EmployeeSkillMatrixEntity && Array.isArray(result.data.EmployeeSkillMatrixEntity)) {
                    result.data.EmployeeSkillMatrixEntity.forEach(function (skill) {
                        var id = skill.EmployeeSkillID || skill.employeeSkillID;
                        if (id && id !== 0) allIDs.push(id);
                    });
                } else if (result && result.EmployeeSkillMatrixEntity && Array.isArray(result.EmployeeSkillMatrixEntity)) {
                    result.EmployeeSkillMatrixEntity.forEach(function (skill) {
                        var id = skill.EmployeeSkillID || skill.employeeSkillID;
                        if (id && id !== 0) allIDs.push(id);
                    });
                } else if (Array.isArray(result)) {
                    result.forEach(function (skill) {
                        var id = skill.EmployeeSkillID || skill.employeeSkillID;
                        if (id && id !== 0) allIDs.push(id);
                    });
                }
                if (callback) callback(allIDs);
            } catch (error) {
                console.error('Error fetching all Skill IDs:', error);
                if (callback) callback([]);
            }
        }

        function InitializeSkillCheckboxes() {
            $('#selectAllSkills').off('change').on('change', function () {
                var isChecked = $(this).is(':checked');
                if (isChecked) {
                    fetchAllSkillIDs(function (allIDs) {
                        selectedSkillIDs = [];
                        allIDs.forEach(function (id) {
                            var skillId = parseInt(id) || 0;
                            if (skillId > 0 && selectedSkillIDs.indexOf(skillId) === -1) {
                                selectedSkillIDs.push(skillId);
                            }
                        });
                        $('#tblSkillsBody .skill-checkbox:not(:disabled)').each(function () {
                            var skillId = parseInt($(this).data('skill-id'));
                            if (skillId && skillId > 0 && selectedSkillIDs.indexOf(skillId) !== -1) {
                                $(this).prop('checked', true);
                            }
                        });
                    });
                } else {
                    selectedSkillIDs = [];
                    $('#tblSkillsBody .skill-checkbox:not(:disabled)').each(function () {
                        $(this).prop('checked', false);
                    });
                }
            });
            $(document).off('change', '.skill-checkbox').on('change', '.skill-checkbox', function () {
                var skillId = parseInt($(this).data('skill-id'));
                var isChecked = $(this).is(':checked');
                if (skillId && skillId > 0) {
                    if (isChecked) {
                        if (selectedSkillIDs.indexOf(skillId) === -1) {
                            selectedSkillIDs.push(skillId);
                        }
                    } else {
                        var index = selectedSkillIDs.indexOf(skillId);
                        if (index !== -1) {
                            selectedSkillIDs.splice(index, 1);
                        }
                    }
                }
                var allSelected = skillsTotalRecords > 0 && selectedSkillIDs.length === skillsTotalRecords;
                $('#selectAllSkills').prop('checked', allSelected);
            });
        }

        // Escape JavaScript string for safe use in HTML attributes
        function escapeJsString(text) {
            if (text === null || text === undefined) {
                return '';
                    }
            return String(text).replace(/\\/g, '\\\\').replace(/'/g, "\\'").replace(/"/g, '\\"').replace(/\n/g, '\\n').replace(/\r/g, '\\r');
        }

        function escapeHtml(text) {
            if (text === null || text === undefined) {
                return '';
            }
            var textStr = String(text);
            var map = {
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#039;'
            };
            return textStr.replace(/[&<>"']/g, function (m) { return map[m]; });
        }

        var qualificationsList = [];
        var qualificationIdCounter = 1;

        // Save Qualification from Modal - Using AJAXCallWithResult pattern (matching PM_TrainingPlan.aspx pattern)
        function SaveQualificationFromModal() {
 
            alertify.set('notifier', 'position', 'top-right');
            var employeeId = parseInt(UserId) || 0;
            if (!employeeId) {
                alertify.error('<%=MyBase.GetResourceString("A_EmployeeIDisrequired.")%>');
                return;
            }

            var qualificationIDValue = $('#modalQualificationName').val();
            if (!qualificationIDValue) {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectaQualificationName")%>');
                return;
            }

            var qualificationID = parseInt(qualificationIDValue);
            if (isNaN(qualificationID) || qualificationID === 0) {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectaQualificationName")%>');
                return;
            }

            var selectedQualName = $('#modalQualificationName option:selected').text().trim().toLowerCase();
            var isExists = false;

            $('#tblQualificationsBody tr').each(function () {
                if ($(this).hasClass('empty-state')) return true; // skip empty row

                var existingQualName = $(this).find('td:eq(4)').text().trim().toLowerCase(); // 5th column
                if (existingQualName === selectedQualName) {
                    isExists = true;
                    return false;
                }
            });
            if (isExists) {
                alertify.error('Qualification name already exists');
                return;
            }

            var universityBoard = ($('#modalUniversityBoard').val() || '').replace(/\s+/g, ' ').trim();
            $('#modalUniversityBoard').val(universityBoard);
            var universityBoard = $('#modalUniversityBoard').val();
            if (!universityBoard || universityBoard.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenterUniversityName")%>');
                return;
            }
            
            if (invalidCharsPattern.test(universityBoard)) {
                alertify.error('<%=MyBase.GetResourceString("A_UniversityNamecannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                $('#modalUniversityBoard').focus();
                return;
            }
            var numberPattern = /\d/;
            if (numberPattern.test(universityBoard)) {
                alertify.error('<%=MyBase.GetResourceString("A_cannotcontainNumbers")%>');
                return;
            }

            var passingYear = ($('#modalPassingYear').val() || '').trim();
            if (!passingYear || passingYear === '0') {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenterPassoutYear")%>');
                return;
            }

            var passoutYearInt = parseInt(passingYear);
            if (isNaN(passoutYearInt)) {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenteravalidPassoutYearnumericvalue")%>');
                return;
            }

            var classValue = $('#modalClass').val() || null;
            if (classValue && invalidCharsPattern.test(classValue)) {
                alertify.error('<%=MyBase.GetResourceString("A_Classcannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                return;
            }

            var percentagePoints = ($('#modalPercentageGrade').val() || '').trim();
            var percentageNumber = Number(percentagePoints);
            if (isNaN(percentageNumber) || percentageNumber < 0 || percentageNumber > 100) {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenteronlypositiveInteger")%> (0 to 100 allowed)');
                return;
            }

            var apiData = {
                EmployeeID: employeeId,
                QualificationID: qualificationID,
                UniversityName: universityBoard.trim(),
                PassoutYear: passoutYearInt,
                Class: (classValue && classValue.trim() !== '') ? classValue.trim() : null,
                PercentagePoints: (percentagePoints && percentagePoints.trim() !== '') ? percentagePoints.trim() : null
            };

            try {
                var result = AJAXCallWithResult("api/MyProfile/AddEmployeeQualification", JSON.stringify(apiData), false);

                if (!result) {
                    alertify.error('<%=MyBase.GetResourceString("A_FailedtoaddqualificationTheAPIreturnednoresponse.")%>');
                    return;
                }

                var isSuccess = (result.message && (result.message.toLowerCase().includes('success') || result.message.toLowerCase().includes('added'))) ||
                    result.status === 'SUCCESS' ||
                    (result.rowsAffected !== undefined && result.rowsAffected > 0) ||
                    (result.data && result.data.rowsAffected !== undefined && result.data.rowsAffected > 0) ||
                    (result.message && !result.message.toLowerCase().includes('error') && !result.message.toLowerCase().includes('fail'));

                if (isSuccess) {
                    var offcanvasEl = document.getElementById('qualificationModal_OffCanvas');
                    var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                    if (bsOffcanvas) bsOffcanvas.hide();

                    $('#qualificationForm')[0].reset();
                    alertify.success(result.message || 'Qualification added successfully');
                    setTimeout(function () {
                        qualCurrentPage = 1;
                        if ($.fn.DataTable.isDataTable('#tblQualifications')) {
                            try {
                                $('#tblQualifications').DataTable().clear().destroy();
                            } catch (e) { }
                            }
                        LoadQualifications();
                    }, 500);
                } else {
                    throw new Error((result && result.message) || (result && result.error) || 'Failed to add qualification');
                }
            } catch (error) {
                alertify.error('<%=MyBase.GetResourceString("A_Erroraddingqualification")%> ' + (error.message || error));
            }
        }

        function SaveUpdateQualificationModal() {
                alertify.set('notifier', 'position', 'top-right');
            var employeeId = parseInt(UserId) || 0;
            if (!employeeId) {
                alertify.error('<%=MyBase.GetResourceString("A_EmployeeIDisrequired.")%>');
                return;
            }
            var employeeQualificationId = parseInt($('#hdnEmployeeQualificationID').val()) || 0;
            if (!employeeQualificationId) {
                alertify.error('<%=MyBase.GetResourceString("A_Invalidqualificationrecordselectedforupdate.")%>');
                return;
            }
            var qualificationIDValue = $('#UpdateModalQualificationName').val();
            if (!qualificationIDValue) {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectQualificationName")%>');
                return;
            }
            var qualificationID = parseInt(qualificationIDValue);
            if (isNaN(qualificationID) || qualificationID === 0) {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectQualificationName")%>');
                return;
            }
            var universityBoard = ($('#UpdateModalUniversityBoard').val() || '').replace(/\s+/g, ' ').trim();
            $('#UpdateModalUniversityBoard').val(universityBoard);
            var universityBoard = $('#UpdateModalUniversityBoard').val();
            if (!universityBoard || universityBoard.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenterUniversityName")%>');
                return;
            }
            if (invalidCharsPattern.test(universityBoard)) {
                alertify.error('<%=MyBase.GetResourceString("A_UniversityNamecannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                $('#UpdateModalUniversityBoard').focus();
                return;
            }
            var numberPattern = /\d/;
            if (numberPattern.test(universityBoard)) {
                alertify.error('<%=MyBase.GetResourceString("A_cannotcontainNumbers")%>');
                return;
            }
            var passingYear = $('#UpdateModalPassingYear').val();
            if (!passingYear) {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectPassoutYear")%>');
                return;
            }

            var passoutYearInt = parseInt(passingYear);
            if (isNaN(passoutYearInt)) {
                alertify.error('<%=MyBase.GetResourceString("A_InvalidPassoutYear")%>');
                return;
            }

            var classValue = $('#UpdateModalClass').val() || null;
            if (classValue && invalidCharsPattern.test(classValue)) {
                alertify.error('<%=MyBase.GetResourceString("A_Classcannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                return;
            }

            var percentagePoints = $('#UpdateModalPercentageGrade').val() || null;
            if (isNaN(percentagePoints)) {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenteronlypositiveInteger")%>');
                return;
            }

            var apiData = {
                EmployeeQualificationID: employeeQualificationId,
                QualificationID: qualificationID,
                University: universityBoard.trim(),
                PassoutYear: passoutYearInt,
                Class: classValue && classValue.trim() !== '' ? classValue.trim() : null,
                Percentage: percentagePoints && percentagePoints.trim() !== '' ? parseFloat(percentagePoints.trim()) : null
            };

            try {
                var result = AJAXCallWithResult("api/MyProfile/UpdateEmployeeQualification", JSON.stringify(apiData), false);

                if (!result) {
                    alertify.error('<%=MyBase.GetResourceString("A_UpdatefailedNoresponsefromserver.")%>');
                    return;
                }

                var isSuccess = (result.message && result.message.toLowerCase().includes('success')) ||
                    result.status === 'SUCCESS' ||
                    (result.rowsAffected && result.rowsAffected > 0) ||
                    (result.data && result.data.rowsAffected > 0);

                if (isSuccess) {
                    var offcanvasEl = document.getElementById('UpdateQualificationModel_Offcanvas');
                    var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                    if (offcanvas) offcanvas.hide();

                    $('#UpdatequalificationForm')[0].reset();
                    $('#UpdateModalQualificationName').val('').selectpicker('refresh');
                    alertify.success(result.message || 'Qualification updated successfully');

                    setTimeout(function () {
                        qualCurrentPage = 1;
                        if ($.fn.DataTable.isDataTable('#tblQualifications')) {
                            $('#tblQualifications').DataTable().clear().destroy();
                        }
                        LoadQualifications();
                    }, 500);
                } else {
                    throw new Error(result.message || 'Failed to update qualification');
                }
            } catch (error) {
                alertify.error('<%=MyBase.GetResourceString("A_Errorupdatingqualification")%> ' + error.message);
            }
        }

        // Delete qualification row
        function DeleteQualificationRow(id) {
            window.pendingDeleteId = id;
            window.pendingDeleteType = 'qualification';
            var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            deleteModal.show();
        }

        // Delete selected qualifications
        function DeleteSelectedQualifications() {
            var selectedCheckboxes = $('.qualification-checkbox:checked');
            if (selectedCheckboxes.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Pleaseselectatleastonequalificationtodelete.")%>');
                return;
            }
            window.pendingDeleteItems = selectedCheckboxes;
            window.pendingDeleteType = 'qualification';
            var messageText = '<%=MyBase.GetResourceString("A_Areyousureyouwanttodeletetheselectedrecords")%>' || 'Are you sure, you want to delete the selected records?';
            $('#CheckModal').html(messageText);
            var modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            modal.show();
        }

        var workExperienceList = [];
        var workExperienceIdCounter = 1;

        // Save Work Experience from Modal - Using AJAXCallWithResult pattern (matching PM_TrainingPlan.aspx pattern)
        function SaveWorkExperienceFromModal() {
                alertify.set('notifier', 'position', 'top-right');
            var employeeId = parseInt(UserId) || 0;
            if (!employeeId) {
                alertify.error('<%=MyBase.GetResourceString("A_EmployeeIDisrequired.")%>');
                return;
            }

            var organizationName = ($('#modalOrganizationName').val() || '').replace(/\s+/g, ' ').trim();
            $('#modalOrganizationName').val(organizationName);
            var organizationName = $('#modalOrganizationName').val();
            if (!organizationName || organizationName.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenterOrganizationName")%>');
                return;
            }
            if (invalidCharsPattern.test(organizationName)) {
                alertify.error('<%=MyBase.GetResourceString("A_OrganizationNamecannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                return;
            }

            var positionHeld = $('#modalPositionHeld').val();
            if (!positionHeld || positionHeld.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenterPositionHeld")%>');
                return;
            }
            positionHeld = positionHeld.trim();
            if (invalidCharsPattern.test(positionHeld)) {
                alertify.error('<%=MyBase.GetResourceString("A_PositionHeldcannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                return;
            }
            var numberPattern = /\d/; 
            if (numberPattern.test(positionHeld)) {
                alertify.error('<%=MyBase.GetResourceString("A_PositionHeldcannotcontainNumbers")%>');
               return;
             }

            var fromDate = $('#modalFromDate').val();
            if (!fromDate || fromDate.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectFromDate")%>');
                return;
            }

            var tillDate = $('#modalTillDate').val();
            if (!tillDate || tillDate.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectTillDate")%>');
                return;
            }

            try {
                var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                var parseDate = function(dateStr) {
                    var parts = dateStr.trim().split(/\s+/);
                    if (parts.length === 3) {
                        var month = monthNames.indexOf(parts[1]);
                        if (month !== -1) return new Date(parseInt(parts[2]), month, parseInt(parts[0], 10));
                    }
                    parts = dateStr.trim().split('/');
                    if (parts.length === 3) return new Date(parseInt(parts[2]), parseInt(parts[0]) - 1, parseInt(parts[1]));
                    return null;
                };
                var fromDateObj = parseDate(fromDate);
                var tillDateObj = parseDate(tillDate);
                if (!fromDateObj || !tillDateObj) {
                    alertify.error('Please enter valid dates.');
                    return;
                }
                if (tillDateObj <= fromDateObj) {
                    alertify.error('Till Date should be greater than From Date.');
                    return;
                }
                var joiningDateText = $('#lblJoiningDate').text();
                if (joiningDateText && joiningDateText !== '-') {
                    var joiningDateObj = parseDate(joiningDateText);
                    if (joiningDateObj && tillDateObj >= joiningDateObj) {
                        alertify.error('Till Date should be less than Joining Date.');
                        return;
                    }
                }
            } catch (e) {
                alertify.error('Please enter valid dates.');
                return;
            }

            var workProfileValue = $('#modalWorkProfile').val();
            var workProfile = null;
            if (workProfileValue) {
                var workProfileInt = parseInt(workProfileValue);
                if (!isNaN(workProfileInt)) workProfile = workProfileInt;
            }

            var summary = $('#modalSummary').val();
            summary = (summary && summary.trim() !== '') ? summary.trim() : null;

            var apiData = {
                EmployeeID: employeeId,
                OrganizationName: organizationName.trim(),
                PositionHeld: positionHeld,
                FromDate: formatDateOnly(fromDate),
                TillDate: formatDateOnly(tillDate),
                WorkProfile: workProfile,
                Summary: summary
            };

            try {
                var result = AJAXCallWithResult("api/MyProfile/AddEmployeeWorkExperience", JSON.stringify(apiData), false);
                
                if (!result) {
                    alertify.error('<%=MyBase.GetResourceString("A_FailedtoaddworkexperienceAPIreturnednoresponse.")%>');
                    return;
                }

                if (result.error || result.status === 'ERROR' || (result.status && result.status !== 'SUCCESS')) {
                    alertify.error('<%=MyBase.GetResourceString("A_AddEmployeeWorkExperienceAPIError")%>');
                    return;
                }

                    var offcanvasEl = document.getElementById('workExperienceModal_OffCanvas');
                    var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                if (bsOffcanvas) bsOffcanvas.hide();

                alertify.success('<%=MyBase.GetResourceString("A_Addedrecordssuccessfully")%>');
                setTimeout(function () { LoadWorkExperience(); }, 500);
            } catch (error) {
                alertify.error('<%=MyBase.GetResourceString("A_Erroraddingworkexperience")%> ' + (error.message || error));
            }
        }

        function UpdateSaveWorkExperienceModal() {
            var employeeId = parseInt(UserId) || 0;
            var workExperienceId = parseInt($('#hdnWorkExperienceID').val()) || 0;

            if (!employeeId || employeeId === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_EmployeeIDisrequired.")%>');
                return;
            }

            if (!workExperienceId || workExperienceId === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_WorkExperienceIDisrequired.")%>');
                return;
            }

            var organizationName = ($('#UpdateModalOrganizationName').val() || '').replace(/\s+/g, ' ').trim();
            $('#UpdateModalOrganizationName').val(organizationName);
            var organizationName = $('#UpdateModalOrganizationName').val();
            if (!organizationName || organizationName.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenterOrganizationName")%>');
                return;
            }
            
            var invalidChars = invalidCharsPattern;
            if (invalidChars.test(organizationName)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_OrganizationNamecannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                return;
            }

            var organizationName = ($('#UpdateModalPositionHeld').val() || '').replace(/\s+/g, ' ').trim();
            $('#UpdateModalPositionHeld').val(organizationName);
            var positionHeld = $('#UpdateModalPositionHeld').val();
            if (!positionHeld || positionHeld.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenterPositionHeld")%>');
                return;
            }
            var numberPattern = /\d/;
            if (numberPattern.test(positionHeld)) {
                alertify.error('<%=MyBase.GetResourceString("A_PositionHeldcannotcontainNumbers")%>');
                return;
            }
            positionHeld = positionHeld.trim();
            var invalidChars = invalidCharsPattern;
            if (invalidChars.test(positionHeld)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PositionHeldcannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                $('#UpdateModalPositionHeld').focus();
                return;
            }
            var fromDate = $('#UpdateModalFromDate').val();
            if (!fromDate || fromDate.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectFromDate")%>');
                return;
            }

            var tillDate = $('#UpdateModalTillDate').val();
            if (!tillDate || tillDate.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PleaseselectTillDate")%>');
                return;
            }

            try {
                var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                var parseDate = function(dateStr) {
                    var parts = dateStr.trim().split(/\s+/);
                    if (parts.length === 3) {
                        var month = monthNames.indexOf(parts[1]);
                        if (month !== -1) return new Date(parseInt(parts[2]), month, parseInt(parts[0], 10));
                    }
                    parts = dateStr.trim().split('/');
                    if (parts.length === 3) return new Date(parseInt(parts[2]), parseInt(parts[0]) - 1, parseInt(parts[1]));
                    return null;
                };
                var fromDateObj = parseDate(fromDate);
                var tillDateObj = parseDate(tillDate);
                if (!fromDateObj || !tillDateObj) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Please enter valid dates.');
                    return;
                }
                if (tillDateObj <= fromDateObj) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Till Date should be greater than From Date.');
                    return;
                }
                var joiningDateText = $('#lblJoiningDate').text();
                if (joiningDateText && joiningDateText !== '-') {
                    var joiningDateObj = parseDate(joiningDateText);
                    if (joiningDateObj && tillDateObj >= joiningDateObj) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Till Date should be less than Joining Date.');
                        return;
                    }
                }
            } catch (e) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter valid dates.');
                return;
            }

            var workProfileValue = $('#UpdatemodalWorkProfile').val();
            var summary = $('#UpdateModalSummary').val() || null;

            //var workProfile = null;
            //if (workProfileValue && workProfileValue !== '') {
            //    var workProfileInt = parseInt(workProfileValue);
            //    if (!isNaN(workProfileInt)) {
            //        workProfile = workProfileInt;
            //    }
            //}
            
            // Prepare API data
            var apiData = {
                EmployeeHistoryID: workExperienceId,
                OrganizationName: organizationName.trim(),
                PositionHeld: positionHeld.trim(),
                WorkedFrom: formatDateOnly(fromDate),
                WorkedTill: formatDateOnly(tillDate),
                WorkProfile: workProfile,
                Summary: (summary && summary.trim() !== '') ? summary.trim() : null
            };

            console.log('UpdateEmployeeWorkExperience API Request:', apiData);

            try {
                var param = JSON.stringify(apiData);
                var url = "api/MyProfile/UpdateEmployeeHistory";
                var result = AJAXCallWithResult(url, param, false);

                console.log('UpdateEmployeeWorkExperience API Response:', result);

                if (!result) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_Failedtoupdateworkexperience.")%>');
                    return;
                }
                if (result.error || result.status === 'ERROR') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(result.message || 'Update failed');
                    return;
                }

                if (result && result.message) {

                    var offcanvasEl = document.getElementById('UpdateWorkExperienceModal_OffCanvas');
                    var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                    if (bsOffcanvas) {
                        bsOffcanvas.hide();
                    }

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success(result.message || 'Work experience updated successfully');

                    setTimeout(function () {
                        LoadWorkExperience();
                    }, 500);

                } else {
                    throw new Error('Unexpected API response');
                }

            } catch (error) {
                console.error('Error updating work experience:', error);
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Errorupdatingworkexperience")%> ' + (error.message || error));
            }
        }

        function formatDateForAPI(dateStr) {
            if (!dateStr) return null;
            if (dateStr.includes('-')) {
                return dateStr;
            }
            var parts = dateStr.split('/');
            if (parts.length === 3) {
                return parts[2] + '-' + parts[1] + '-' + parts[0];
            }

            return null;
        }

        // Delete work experience row
        function DeleteWorkExperienceRow(id) {
            window.pendingDeleteId = id;
            window.pendingDeleteType = 'workexperience';
            var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            deleteModal.show();
        }

        // Delete selected work experience
        function DeleteSelectedWorkExperience() {
            var selectedCheckboxes = $('.workexperience-checkbox:checked');
            if (selectedCheckboxes.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Pleaseselectatleastoneworkexperiencetodelete.")%>');
                return;
            }
            window.pendingDeleteItems = selectedCheckboxes;
            window.pendingDeleteType = 'workexperience';
            var messageText = '<%=MyBase.GetResourceString("A_Areyousureyouwanttodeletetheselectedrecords")%>' || 'Are you sure, you want to delete the selected records?';
            $('#CheckModal').html(messageText);
            var modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            modal.show();
        }

        var assignmentsList = [];
        var assignmentIdCounter = 1;

        // Save Assignment from Modal - Using AJAXCallWithResult pattern (matching SaveWorkExperienceFromModal pattern)
        function SaveAssignmentFromModal() {  
            var employeeId = parseInt(UserId) || 0;

            if (!employeeId) {
                alertify.error('<%=MyBase.GetResourceString("A_EmployeeIDisrequired.")%>');
                return;
            }
            var duration = $('#modalDuration').val();
            if (!duration || duration.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Enterdurationinyears")%>');
                $('#modalDuration').focus();
                return;
            }
            var durationTrimmed = duration.trim();
            if (!/^\d*\.?\d+$/.test(durationTrimmed)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenteronlypositivenumericvalueforDurationYears")%>');
                $('#modalDuration').focus();
                return;
            }
            var durationNum = parseFloat(durationTrimmed);
            if (isNaN(durationNum) || durationNum < 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenteronlypositivenumericvalueforDurationYears")%>');
                $('#modalDuration').focus();
                return;
            }

            var teamSize = $('#modalTeamSize').val();
            if (!teamSize || teamSize.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Enterteamsize")%>');
                $('#modalTeamSize').focus();
                return;
            }
            var teamSizeNum = parseInt(teamSize.trim());
            if (isNaN(teamSizeNum) || teamSizeNum <= 0 || !/^\d+$/.test(teamSize.trim())) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenteronlypositiveInteger")%>');
                $('#modalTeamSize').focus();
                return;
            }

            var functionalRole = ($('#modalFunctionalRole').val() || '').replace(/\s+/g, ' ').trim();
            $('#modalFunctionalRole').val(functionalRole);
            var functionalRole = $('#modalFunctionalRole').val();
            if (!functionalRole || functionalRole.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_FunctionalRoleisrequired")%>');
                return;
            }
            var invalidChars = invalidCharsPattern;
            if (invalidChars.test(functionalRole)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_FunctionalRolecannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                return;
            }

            var assignmentName = ($('#modalAssignmentName').val() || '').replace(/\s+/g, ' ').trim();
            $('#modalAssignmentName').val(assignmentName);

            var assignmentName = $('#modalAssignmentName').val();
            if (assignmentName && assignmentName.trim() !== '') {
                var invalidChars = invalidCharsPattern;
                if (invalidChars.test(assignmentName)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_AssignmentNamecannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                    return;
                }
            }
            var environment = $('#modalEnvironment').val();
            var skills = $('#modalAssignmentSkills').val();
            var description = $('#modalDescription').val();
            var assignmentId = $('#hdnAssignmentID').val();
            var isUpdate = (assignmentModeFlag === 0 && assignmentId && assignmentId !== '');

            if (isUpdate) {
                // Update mode - flag = 0
                var createdByInput = $('#CreatedBy').val();
                if (createdByInput && createdByInput.trim() !== '') {
                    var invalidChars = invalidCharsPattern;
                    if (invalidChars.test(createdByInput)) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('<%=MyBase.GetResourceString("A_CreatedBycannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                        return;
                    }
                }
                var createdBy = createdByInput && createdByInput.trim() !== '' ? createdByInput.trim() : null;
                var createdDateInput = $('#modalCreatedDate').val();
                var createdDateFormatted = createdDateInput && createdDateInput.trim() !== '' ? formatDateOnly(createdDateInput.trim()) : null;
                
                var updateData = {
                    EmployeeHistoryProjectID: parseInt(assignmentId),
                    AssignmentName: assignmentName ? assignmentName.trim() : null,
                    Duration: parseFloat(duration),
                    TeamSize: parseInt(teamSize),
                    FunctionalRole: functionalRole.trim(),
                    Environment: environment ? environment.trim() : null,
                    Skills: skills ? skills.trim() : null,
                    Description: description ? description.trim() : null,
                    CreatedBy: createdBy,
                    CreatedDate: createdDateFormatted
                };

                console.log('Update API Request (flag=0):', updateData);

                var param = JSON.stringify(updateData);
                var url = "api/MyProfile/UpdateEmployeeHistoryProject";
                var result = AJAXCallWithResult(url, param, false);

                if (result && (result.message || result.status === "SUCCESS")) {
                    var offcanvasEl = document.getElementById('assignmentModal_OffCanvas');
                    var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                    if (offcanvas) offcanvas.hide();
                    $('#assignmentForm')[0].reset();
                    $('#hdnAssignmentID').val('');
                    alertify.success(result.message || 'Assignment updated successfully');
                    setTimeout(LoadAssignments, 500);
                } else {
                    alertify.error(result?.message || 'Failed to update assignment');
                }
            } else {
                // Add mode - flag = 1
                var createdByInput = $('#CreatedBy').val();
                if (createdByInput && createdByInput.trim() !== '') {
                    var invalidChars = invalidCharsPattern;
                    if (invalidChars.test(createdByInput)) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('<%=MyBase.GetResourceString("A_CreatedBycannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                        return;
                    }
                }
                var createdBy = createdByInput && createdByInput.trim() !== '' ? createdByInput.trim() : null;
                var createdDateInput = $('#modalCreatedDate').val();
                var createdDate = createdDateInput && createdDateInput.trim() !== '' ? formatDateOnly(createdDateInput.trim()) : null;

                var apiData = {
                    EmployeeID: employeeId,
                    AssignmentName: assignmentName?.trim() || null,
                    DurationYears: parseFloat(duration),
                    TeamSize: parseInt(teamSize),
                    FunctionalRole: functionalRole.trim(),
                    Environment: environment?.trim() || null,
                    Skills: skills?.trim() || null,
                    Description: description?.trim() || null,
                    CreatedBy: createdBy,
                    CreatedDate: createdDate
                };

                console.log('Add API Request (flag=1):', apiData);
                var param = JSON.stringify(apiData);
                var url = "api/MyProfile/AddEmployeeHistoryAssignment";
                var result = AJAXCallWithResult(url, param, false);

                if (result && result.message) {
                    var offcanvasEl = document.getElementById('assignmentModal_OffCanvas');
                    var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                    if (offcanvas) offcanvas.hide();
                    $('#assignmentForm')[0].reset();
                    $('#hdnAssignmentID').val('');
                    alertify.success(result.message);
                    setTimeout(LoadAssignments, 500);
                } else {
                    alertify.error(result?.message || 'Failed to add assignment');
                }
            }
        }

        function SaveUpdateAssignmentModal() {
            var assignmentId = $('#hdnAssignmentID').val();
            if (!assignmentId || assignmentId === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Assignment ID is required.');
                return;
            }

            var assignmentName = ($('#modalAssignmentName').val() || '').replace(/\s+/g, ' ').trim();
            $('#modalAssignmentName').val(assignmentName);
            var assignmentName = $('#modalAssignmentName').val()?.trim() || null;
            if (assignmentName && assignmentName !== '') {
                var invalidChars = invalidCharsPattern;
                if (invalidChars.test(assignmentName)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_AssignmentNamecannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                    return;
                }
            }
            var duration = $('#modalDuration').val().trim();
            if (!duration || duration === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Enterdurationinyears")%>');
                return;
            }
            if (!/^\d*\.?\d+$/.test(duration)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenteronlypositivenumericvalueforDurationYears")%>');
                return;
            }
            var durationNum = parseFloat(duration);
            if (isNaN(durationNum) || durationNum <0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenteronlypositivenumericvalueforDurationYears")%>');
                return;
            }
            var teamSize = $('#modalTeamSize').val().trim();
            if (!teamSize || teamSize === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Enterteamsize")%>');
                return;
            }
            var teamSizeNum = parseInt(teamSize);
            if (isNaN(teamSizeNum) || teamSizeNum <= 0 || !/^\d+$/.test(teamSize)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PleaseenteronlypositiveInteger")%>');
                return;
            }
            var functionalRole = ($('#modalFunctionalRole').val() || '').replace(/\s+/g, ' ').trim();
            $('#modalFunctionalRole').val(functionalRole);
            var functionalRole = $('#modalFunctionalRole').val().trim();
            if (!functionalRole || functionalRole === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_FunctionalRoleisrequired")%>');
                return;
            }
            var invalidChars = invalidCharsPattern;
            if (invalidChars.test(functionalRole)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_FunctionalRolecannotcontainanyofthesecharacters.")%> ' + specialCharactersList);
                return;
            }
            var environment = $('#modalEnvironment').val()?.trim() || null;
            var skills = $('#modalAssignmentSkills').val()?.trim() || null;
            var description = $('#modalDescription').val()?.trim() || null;
            var createdBy = $('#CreatedBy').val()?.trim() || null;
            var createdDate = $('#modalCreatedDate').val()?.trim() || null;
            var createdDateFormatted = createdDate ? formatDateOnly(createdDate) : null;
            
            var updateData = {
                EmployeeHistoryProjectID: parseInt(assignmentId),
                AssignmentName: assignmentName,
                Duration: durationNum,
                TeamSize: teamSizeNum,
                FunctionalRole: functionalRole,
                Environment: environment,
                Skills: skills,
                Description: description,
                CreatedBy: createdBy,
                CreatedDate: createdDateFormatted
            };
            var param = JSON.stringify(updateData);
            var url = "api/MyProfile/UpdateEmployeeHistoryProject";
            var result = AJAXCallWithResult(url, param, false);
            if (result && (result.message || result.status === "SUCCESS")) {
                var offcanvasEl = document.getElementById('assignmentModal_OffCanvas');
                var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                if (offcanvas) offcanvas.hide();
                $('#assignmentForm')[0].reset();
                $('#hdnAssignmentID').val('');
                alertify.set('notifier', 'position', 'top-right');
                alertify.success(result.message || '<%=MyBase.GetResourceString("A_Assignmentsavedsuccessfully")%>');
                if (typeof LoadAssignments === 'function') {
                    LoadAssignments();
                }
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(result?.message || 'Failed to update assignment');
            }
        }

        // update Employee History Project 
        function UpdateEmployeeHistoryProject() {
            var assignmentName = $('#txtAssignmentName').val() || null;
            var duration = $('#txtDuration').val() || null;
            var teamSize = $('#txtTeamSize').val() || null;
            var functionalRole = $('#txtFunctionalRole').val() || null;

            var updateData = {
                AssignmentName: assignmentName,
                Duration: duration,
                TeamSize: teamSize,
                FunctionalRole: functionalRole
            };
            if (typeof alertify !== 'undefined') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.message('Updating Employee Project History...', 0);
            }
            try {
                var param = JSON.stringify(updateData);
                console.log("UpdateEmployeeHistoryProject API Request Data:", updateData);
                console.log("UpdateEmployeeHistoryProject API JSON:", param);

                var url = "api/MyProfile/UpdateEmployeeHistoryProject";
                var result = AJAXCallWithResult(url, param, false);

                console.log("UpdateEmployeeHistoryProject API Response:", result);

                if (!result) {
                    alertify.dismissAll();
                    alertify.error('<%=MyBase.GetResourceString("A_APIreturnednoresponseCheckconsole.")%>');
                    return;
                }
                if (result.error ||
                    result.status === "ERROR" ||
                    (result.status && result.status !== "SUCCESS")) {

                    var errorMessage =
                        result.message ||
                        result.error ||
                        result.data?.message ||
                        "Failed to update employee project history";

                    alertify.dismissAll();
                    alertify.error('<%=MyBase.GetResourceString("A_Error")%> ' + errorMessage);
                    return;
                }
                var successDetected = false;
                var successMessage = "Project history updated successfully!";
                if (result.message) {
                    successDetected = true;
                    successMessage = result.message;
                }
                else if (result.data && result.data.message) {
                    successDetected = true;
                    successMessage = result.data.message;
                }
                else if (result.status === "SUCCESS") {
                    successDetected = true;
                    successMessage =
                        result.message || result.data?.message || successMessage;
                }
                else if (result.rowsAffected !== undefined ||
                    (result.data && result.data.rowsAffected !== undefined)) {

                    successDetected = true;
                    var rows = result.rowsAffected || result.data.rowsAffected;
                    successMessage = rows > 0 ? successMessage : "No rows updated";
                }

                if (successDetected) {
                    alertify.dismissAll();
                    alertify.success(successMessage);
                    setTimeout(function () {
                        console.log("Reloading Employee Project History...");
                        LoadEmployeeHistoryProject();
                    }, 500);

                    $('#employeeHistoryProjectUpdateModal').modal('hide');
                }
                else {
                    alertify.dismissAll();
                    alertify.error('<%=MyBase.GetResourceString("A_UnexpectedAPIresponseCheckconsole.")%>');
                }

            } catch (error) {
                console.error("Error updating employee project history:", error);
                alertify.dismissAll();
                alertify.error('<%=MyBase.GetResourceString("A_Error")%> ' + (error.message || error));
            }
        }
        // Delete assignment row
        function DeleteAssignmentRow(id) {
            window.pendingDeleteId = id;
            window.pendingDeleteType = 'assignment';

            var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            deleteModal.show();
        }

        // Delete selected assignments
        function DeleteSelectedAssignments() {
            var selectedCheckboxes = $('.assignment-checkbox:checked');
            if (selectedCheckboxes.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one assignment to delete.');
                return;
            }
            window.pendingDeleteItems = selectedCheckboxes;
            window.pendingDeleteType = 'assignment';
            var messageText = '<%=MyBase.GetResourceString("A_Areyousureyouwanttodeletetheselectedrecords")%>' || 'Are you sure, you want to delete the selected records?';
            $('#CheckModal').html(messageText);
            var modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            modal.show();
        }

        // Save Skill from Modal - Using AJAXCallWithResult pattern (matching SaveWorkExperienceFromModal pattern)
        function SaveSkillFromModal() {
                alertify.set('notifier', 'position', 'top-right');
            var employeeId = parseInt(UserId) || 0;
            if (!employeeId) {
                alertify.error('<%=MyBase.GetResourceString("A_EmployeeIDisrequired.")%>');
                return;
            }
            var skillValue = $('#modalSkills').val();
            if (!skillValue) {
                alertify.error('Please select a Skill');
                return;
            }

            var skillID = parseInt(skillValue);
            if (isNaN(skillID) || skillID === 0) {
                alertify.error('Please select a Skill from the dropdown.');
                return;
            }

            var proficiencyValue = $('#modalProficiency').val() || $('#modalProficiency option:selected').val();
            var proficiencyID = null;
            if (proficiencyValue && proficiencyValue !== '' && proficiencyValue !== '0') {
                proficiencyID = parseInt(proficiencyValue);
                if (isNaN(proficiencyID) || proficiencyID <= 0) proficiencyID = null;
            }
            var experienceYearsValue = $('#modalExperienceYears').val();
            var experienceYears = 0;
            if (experienceYearsValue) {
                experienceYears = experienceYearsValue === '10+' ? 10 : (parseInt(experienceYearsValue) || 0);
            }
            var experienceMonths = parseInt($('#modalExperienceMonths').val()) || 0;
            var notes = $('#modalSkillNotes').val();
            notes = (notes && notes.trim() !== '') ? notes.trim() : null;

            var apiData = {
                EmployeeID: employeeId,
                SkillID: skillID,
                ExperienceYears: experienceYears,
                ExperienceMonths: experienceMonths,
                Proficiency: proficiencyID,
                CoreCompetency: $('#modalCoreCompetency').is(':checked'),
                Notes: notes,
            
            };

            try {
                var result = AJAXCallWithResult("api/MyProfile/AddEmployeeSkill", JSON.stringify(apiData), false);
                
                if (!result) {
                    alertify.error('Failed to add skill. The API returned no response.');
                    return;
                }
                if (result.error || result.status === 'ERROR' || result.Status === 'ERROR') {
                    var errorMessage = result.message || result.error ||
                        (result.Data && result.Data.message) ||
                        (result.data && result.data.message) ||
                        'Failed to add skill';
                    alertify.error('Error: ' + errorMessage);
                    return;
                }

                var successMessage = 'Skill added successfully';
                if (result.Status === 'SUCCESS' || result.status === 'SUCCESS') {
                    successMessage = (result.Data && result.Data.message) || 
                        (result.data && result.data.message) || 
                        result.message || 
                        successMessage;
                    } else if (result.message) {
                        successMessage = result.message;
                } else if (result.Data && result.Data.message) {
                    successMessage = result.Data.message;
                } else if (result.data && result.data.message) {
                    successMessage = result.data.message;
                }

                    skillsCurrentPage = 1;
                    var offcanvasEl = document.getElementById('skillModel_Offcanvas');
                    var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                if (bsOffcanvas) bsOffcanvas.hide();

                    $('#modalSkills option[value="' + skillID + '"]').remove();
                    $('#modalSkills').selectpicker('refresh');

                    $('#skillForm')[0].reset();
                    $('#modalCoreCompetency').prop('checked', false);
                        alertify.success(successMessage);
                    LoadSkills();
                setTimeout(function () { LoadSkills(); }, 500);
            } catch (error) {
                    alertify.error('Error adding skill: ' + (error.message || error));
                }
            }
     
        function UpdateSaveSkillFromModal() {
       
            var employeeId = parseInt(UserId) || 0;
            if (!employeeId || employeeId === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_EmployeeIDisrequired.")%>');
                return;
            }
            var employeeSkillID = parseInt($('#hdnSkillID').val()) || 0;
            if (employeeSkillID === 0) {
                alertify.error('Invalid Skill record selected for update.');
                return;
            }

            var skillValue = $('#UpdateModalSkill').val();
            if (!skillValue || skillValue === '') {
                alertify.error('Please select a Skill');
                return;
            }
            var experienceYearsValue = $('#UpdateModalExperienceYears').val();
            var experienceMonthsValue = $('#UpdateModalExperienceMonths').val();

            var proficiencyValue = $('#UpdateModalProficiency').val();
            if (!proficiencyValue || proficiencyValue === '') {
                proficiencyValue = $('#UpdateModalProficiency option:selected').val();
            }

            console.log('Update Proficiency Raw:', proficiencyValue);

            var coreCompetency = $('#UpdateModalCoreCompetency').is(':checked');
            var notes = $('#UpdateModalSkillNotes').val() || null;
            var experienceYears = 0;
            if (experienceYearsValue) {
                experienceYears = (experienceYearsValue === '10+') ? 10 : parseInt(experienceYearsValue) || 0;
            }
            var experienceMonths = 0;
            if (experienceMonthsValue) {
                experienceMonths = parseInt(experienceMonthsValue) || 0;
            }
            var skillID = parseInt(skillValue);
            if (isNaN(skillID) || skillID === 0) {
                alertify.error('Please select a valid Skill.');
                return;
            }
            var proficiencyID = null;
            if (proficiencyValue && proficiencyValue !== '0') {
                proficiencyID = parseInt(proficiencyValue);
                if (isNaN(proficiencyID) || proficiencyID <= 0) {
                    proficiencyID = null;
                }
            }

            console.log('Update Proficiency Parsed:', proficiencyID);
            var apiData = {
                EmployeeSkillID: employeeSkillID,
                SkillID: skillID,
                YearsOfExperience: experienceYears,
                MonthsOfExperience: experienceMonths,
                Proficiency: proficiencyID || proficiency ,
                HasCoreCompetency: coreCompetency,
                Notes: (notes && notes.trim() !== '') ? notes.trim() : null
            };
            console.log('UpdateEmployeeSkill API Request:', apiData);
            try {
                var param = JSON.stringify(apiData);
                var url = "api/MyProfile/UpdateEmployeeSkill"; 
                var result = AJAXCallWithResult(url, param, false);

                console.log('UpdateEmployeeSkill API Response:', result);

                if (!result) {
                    alertify.error('Update failed. No response from API.');
                    return;
                }
                if (result.error || result.Status === 'ERROR' || result.status === 'ERROR') {
                    var errorMessage = result.message || 'Failed to update skill';
                    alertify.error(errorMessage);
                    return;
                }
                var successMessage = 'Skill updated successfully';
                if (result.Data && result.Data.message) {
                    successMessage = result.Data.message;
                } else if (result.message) {
                    successMessage = result.message;
                }
                var offcanvasEl = document.getElementById('UpdateSkillModal_OffCanvas');
                var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                if (offcanvas) {
                    offcanvas.hide();
                }
                alertify.set('notifier', 'position', 'top-right');
                alertify.success(successMessage);
             /*   console.log('Reloading skills after update...');*/
                LoadSkills();
                setTimeout(function () {
                    LoadSkills();
                }, 500);

            } catch (error) {
                console.error('Error updating skill:', error);
                alertify.error('Error updating skill: ' + (error.message || error));
            }
        }

        // Delete selected skills
        function DeleteSelectedSkills() {
            var selectedCheckboxes = $('.skill-checkbox:checked');
            if (selectedCheckboxes.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one skill to delete.');
                return;
            }
            window.pendingDeleteItems = selectedCheckboxes;
            window.pendingDeleteType = 'skill';
            var messageText = '<%=MyBase.GetResourceString("A_Areyousureyouwanttodeletetheselectedrecords")%>' || 'Are you sure, you want to delete the selected records?';
            $('#CheckModal').html(messageText);
            var modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            modal.show();
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
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

        function OpenCertificationModal_Offcanvas() {
            var offcanvasElement = document.getElementById('certificationModal_OffCanvas');
            var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
            bsOffcanvas.show();
            // Clear fields when opening - set to first option (Select Certification)
            var firstOptionValue = $('#certificationNameFilter option:first').val();
            $('#certificationNameFilter').val(firstOptionValue || '').selectpicker('refresh');
            $('#modalCertificationDate').val('');
            $('#modalValidUpTo').val('');
            $('#txtmodalScore').val('');
            $('#txtmodalScoreOutOf').val('');
        }

        function OpenQualificationModal_Offcanvas() {
            var offcanvasElement = document.getElementById('qualificationModal_OffCanvas');
            var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
            bsOffcanvas.show();
            // Clear fields on open - set to first option (Select Qualification)
            var firstQualOptionValue = $('#modalQualificationName option:first').val();
            $('#modalQualificationName').val(firstQualOptionValue || '').selectpicker('refresh');
            var firstYearOptionValue = $('#modalPassingYear option:first').val();
            $('#modalPassingYear').val(firstYearOptionValue || '').selectpicker('refresh');
            $('#modalUniversityBoard').val('');
            $('#modalClass').val('');
            $('#modalPercentageGrade').val('');
        }

        function OpenWorkExperienceModal_OffCanvas() {
            var offcanvasEl = document.getElementById('workExperienceModal_OffCanvas');
            var offcanvas = new bootstrap.Offcanvas(offcanvasEl);
            offcanvas.show();

            // Clear all fields before opening - set Work Profile to first option
            $('#modalOrganizationName').val('');
            $('#modalPositionHeld').val('');
            var firstWorkProfileValue = $('#modalWorkProfile option:first').val();
            $('#modalWorkProfile').val(firstWorkProfileValue || '').selectpicker('refresh');
            $('#modalFromDate').val('');
            $('#modalTillDate').val('');
            $('#modalSummary').val('');
        }

        function OpenAssignmentModal_OffCanvas() {
            assignmentModeFlag = 1; 
            var offcanvasEl = document.getElementById('assignmentModal_OffCanvas');
            var offcanvas = new bootstrap.Offcanvas(offcanvasEl);
            offcanvas.show();
            // Clear all fields before opening
            $('#hdnAssignmentID').val('');
            $('#modalAssignmentName').val('');
            $('#modalDuration').val('');
            $('#modalTeamSize').val('');
            $('#modalFunctionalRole').val('');
            $('#CreatedBy').val(GlobalEmpName);
            $('#modalCreatedDate').datepicker('setDate', new Date());
            $('#modalCreatedDate').val($('#modalCreatedDate').val().toUpperCase());
            $('#modalEnvironment').val('');
            $('#modalAssignmentSkills').val('');
            $('#modalDescription').val('');
        }

        function OpenSkillModal_OffCanvas() {
            var offcanvasEl = document.getElementById('skillModel_Offcanvas');
            var offcanvas = new bootstrap.Offcanvas(offcanvasEl);
            offcanvas.show();

            var firstSkillValue = $('#modalSkills option:first').val();
            $('#modalSkills').val(firstSkillValue || '').selectpicker('refresh');
            var firstProficiencyValue = $('#modalProficiency option:first').val();
            $('#modalProficiency').val(firstProficiencyValue || '').selectpicker('refresh');
            $('#modalExperienceYears').val('0').selectpicker('refresh');
            $('#modalExperienceMonths').val('0').selectpicker('refresh');
            $('#modalCoreCompetency').prop("checked", false);
            $('#modalSkillNotes').val('');
            LoadSkillsForDropdown();
        }

        function OpenUpdateCertificationModal(employeeCertificationID,certificationID,  certificationDate, validUpTo, score, scoreOutOf) {
            var offcanvasElement = document.getElementById('UpdateCertificationModal_OffCanvas');
            var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
            bsOffcanvas.show();

            $('#updateEmployeeCertificationID').val(employeeCertificationID);
            $('#updateCertificationForm').val(String(certificationID)).selectpicker('refresh');
            $('#updateCertificationDate').val(certificationDate);
            $('#updateValidUpTo').val(validUpTo);

            if (score && score.indexOf('/') !== -1) {
                var parts = score.split('/');
                $('#updateScore').val(parts[0]);        
                $('#updateScoreOutOf').val(parts[1]);   
            } else {
                $('#updateScore').val(score || '');
                $('#updateScoreOutOf').val(scoreOutOf || '');
            }
        }

        function OpenUpdateQualificationModal( employeeQualificationID, qualificationID, universityName, passoutYear, classValue, percentagePoints) {
            var offcanvasEl = document.getElementById('UpdateQualificationModel_Offcanvas');
            var offcanvas = new bootstrap.Offcanvas(offcanvasEl);
            offcanvas.show();

            $('#hdnEmployeeQualificationID').val(employeeQualificationID);
            $('#UpdateModalQualificationName').val('').selectpicker('refresh');
            $('#UpdateModalUniversityBoard').val('');
            $('#UpdateModalPassingYear').val('');
            $('#UpdateModalClass').val('');
            $('#UpdateModalPercentageGrade').val('');
            $('#UpdateModalQualificationName') .val(String(qualificationID)) .selectpicker('refresh');
            $('#UpdateModalUniversityBoard').val(universityName);
            $('#UpdateModalPassingYear').selectpicker('val', String(passoutYear).trim()).selectpicker('refresh');

            $('#UpdateModalClass').val(classValue);
            $('#UpdateModalPercentageGrade').val(percentagePoints ?? '');
        }

        function OpenUpdateWorkExperienceModal(employeeHistoryID, organizationName, positionHeld, fromDate, tillDate, workProfile, summary) {
          
            var offcanvasElement = document.getElementById('UpdateWorkExperienceModal_OffCanvas');
            var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
            bsOffcanvas.show();

            $('#hdnWorkExperienceID').val('');
            $('#UpdateModalOrganizationName').val('');
            $('#UpdateModalPositionHeld').val('');
            $('#UpdateModalFromDate').val('');
            $('#UpdateModalTillDate').val('');
            $('#UpdatemodalWorkProfile').val('');
            $('#UpdateModalSummary').val('');
            // Set values for Update
            $('#UpdatemodalWorkProfile').val('');
            if ($('#UpdatemodalWorkProfile').hasClass('selectpicker')) {
                $('#UpdatemodalWorkProfile').selectpicker('refresh');
            }
            $('#hdnWorkExperienceID').val(employeeHistoryID);
            $('#UpdateModalOrganizationName').val(organizationName);
            $('#UpdateModalPositionHeld').val(positionHeld);
            $('#UpdateModalFromDate').val(fromDate);
            $('#UpdateModalTillDate').val(tillDate);
            $('#UpdateModalSummary').val(summary);

            setTimeout(function () {
                var isSet = false;
                if (workProfile) {
                    $('#UpdatemodalWorkProfile option').each(function () {
                        if ($(this).text().trim() === String(workProfile).trim()) {
                            $('#UpdatemodalWorkProfile').val($(this).val());
                            isSet = true;
                            return false; 
                        }
                    });
                }
                if (!isSet) {
                    $('#UpdatemodalWorkProfile').val($('#UpdatemodalWorkProfile option:first').val());
                }
                if ($('#UpdatemodalWorkProfile').hasClass('selectpicker')) {
                    $('#UpdatemodalWorkProfile').selectpicker('refresh');
                }
            }, 0);
        }

        function OpenUpdateAssignmentModal(employeeHistoryProjectID, assignmentName, durationYears, teamSize, functionalRole, environment, skills, description, createdBy, createdDate) {
            assignmentModeFlag = 0;
            var offcanvasEl = document.getElementById('assignmentModal_OffCanvas');
            var offcanvas = new bootstrap.Offcanvas(offcanvasEl);
            offcanvas.show();
            // Clear fields first (safe practice)
            $('#hdnAssignmentID').val('');
            $('#modalAssignmentName').val('');
            $('#modalDuration').val('');
            $('#modalTeamSize').val('');
            $('#modalFunctionalRole').val('');
            $('#modalEnvironment').val('');
            $('#modalAssignmentSkills').val('');
            $('#modalDescription').val('');
            $('#CreatedBy').val('');
            $('#modalCreatedDate').val('');

            // Set values for Update
            $('#hdnAssignmentID').val(employeeHistoryProjectID);
            $('#modalAssignmentName').val(assignmentName);
            $('#modalDuration').val(durationYears);
            $('#modalTeamSize').val(teamSize);
            $('#modalFunctionalRole').val(functionalRole);
            $('#modalEnvironment').val(environment);
            $('#modalAssignmentSkills').val(skills);
            $('#modalDescription').val(description);
            $('#CreatedBy').val(createdBy);
            $('#modalCreatedDate').val(createdDate);
        }

        function OpenUpdateSkillModal(EmployeeSkillID, SkillID, experienceYears, experienceMonths, proficiency, isCoreCompetency, notes) {
            var offcanvasEl = document.getElementById('UpdateSkillModal_OffCanvas');
            var offcanvas = new bootstrap.Offcanvas(offcanvasEl);
            offcanvas.show();

            $('#hdnSkillID').val('');
            $('#UpdateModalSkill').val('');
            $('#UpdateModalExperienceYears').val('');
            $('#UpdateModalExperienceMonths').val('');
            $('#UpdateModalProficiency').val('');
            $('#UpdateModalCoreCompetency').prop('checked', false);
            $('#UpdateModalSkillNotes').val('');
            $('#hdnSkillID').val(EmployeeSkillID);
            
            $(offcanvasEl).one('shown.bs.offcanvas', function() {
                if (SkillID && SkillID !== '0' && SkillID !== '' && SkillID !== null && SkillID !== undefined) {
                    var skillIDStr = String(SkillID).trim();
                    var skillName = $('a[onclick*="OpenUpdateSkillModal(' + EmployeeSkillID + '"]').text().trim();
                    if ($('#UpdateModalSkill option[value="' + skillIDStr + '"]').length === 0 && skillName) {
                        $('#UpdateModalSkill').append('<option value="' + skillIDStr + '">' + escapeHtml(skillName) + '</option>');
                        $('#UpdateModalSkill').selectpicker('destroy').selectpicker();
                    }
                    // Set value and refresh
                    $('#UpdateModalSkill').val(skillIDStr);
                    $('#UpdateModalSkill').selectpicker('refresh');
                }
                
                // Set Experience Years
                if (experienceYears && experienceYears !== '' && experienceYears !== '-' && experienceYears !== '0'
                    && experienceYears !== null && experienceYears !== undefined) {

                    $('#UpdateModalExperienceYears').val(String(experienceYears).trim());
                    $('#UpdateModalExperienceYears').selectpicker('refresh');

                } else {
                    $('#UpdateModalExperienceYears')
                        .val($('#UpdateModalExperienceYears option:first').val() || '');
                    $('#UpdateModalExperienceYears').selectpicker('refresh');
                }
                // Set Experience Months
                if (experienceMonths && experienceMonths !== '' && experienceMonths !== '-' && experienceMonths !== '0'
                    && experienceMonths !== null && experienceMonths !== undefined) {

                    $('#UpdateModalExperienceMonths').val(String(experienceMonths).trim());
                    $('#UpdateModalExperienceMonths').selectpicker('refresh');

                } else {
                    // Default to "Select Experience Months"
                    $('#UpdateModalExperienceMonths')
                        .val($('#UpdateModalExperienceMonths option:first').val() || '');
                    $('#UpdateModalExperienceMonths').selectpicker('refresh');
                }
                // Set Proficiency - if NULL, '-', '0', or empty, show default "Select Proficiency"
                if (proficiency && proficiency !== '' && proficiency !== '-' && proficiency !== '0' && proficiency !== null && proficiency !== undefined) {
                    var proficiencySet = false;
                    $('#UpdateModalProficiency option').each(function () {
                        if ($(this).text().trim() === String(proficiency).trim()) {
                            $('#UpdateModalProficiency').val($(this).val());
                            proficiencySet = true;
                            return false;
                        }
                    });
                    if (!proficiencySet && $('#UpdateModalProficiency option[value="' + proficiency + '"]').length > 0) {
                        $('#UpdateModalProficiency').val(proficiency);
                    }
                    $('#UpdateModalProficiency').selectpicker('refresh');
                } else {
                    // If proficiency is NULL, '-', '0', or empty, set to first option (Select Proficiency)
                    $('#UpdateModalProficiency').val($('#UpdateModalProficiency option:first').val() || '');
                    $('#UpdateModalProficiency').selectpicker('refresh');
                }
                var isCore = false;
                if (isCoreCompetency === true || isCoreCompetency === 'true') {
                    isCore = true;
                }
                $('#UpdateModalCoreCompetency').prop('checked', isCore);
                $('#UpdateModalSkillNotes').val(notes || '');
            });
        }
    </script>
</body>
</html>

