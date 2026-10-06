<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyAlerts.aspx.vb" Inherits="Whizible.MyAlerts" %>

<!DOCTYPE html>
<html>
<!-- Commented by Madhuri.K On 09-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("My Alerts")%>
<head>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <%--    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
</head>
<style>
    /*Changed by Madhuri.K content 11-06-2026*/
    body {
        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
    }

    .form-control, .btn, a, p, input, select.form-select {
        /* Modified By Madhuri.K On 26-03-2026 */
        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
    }

    .alertify-notifier {
        z-index: 99999 !important;
    }

    div#NoDataDivID {
        width: 60%;
        margin: 100px auto;
        text-align: center;
        background-color: #fff;
        padding: 50px;
        border-radius: 10px;
        box-shadow: 0px 0px 15px 0px #ddd;
    }

    #NoDataDivID i {
        font-size: 20px; /* Modified By Madhuri.K On 26-03-2026 */
        vertical-align: middle;
        margin-right: 10px;
        color: #ed1c24;
    }

    body {
        background-color: #f8f9fa;
    }

    .offcanvas .pgtitle {
        color: #4263c1 !important;
        font-weight: 700;
        font-size: 14px;
    }

    .btn-danger-modern {
        background-color: transparent;
        border: none;
        color: #333;
        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        padding: 0.25rem 0.5rem;
        transition: none;
        box-shadow: none;
    }

        .btn-danger-modern:hover {
            background-color: transparent;
            color: #333;
            box-shadow: none;
        }

        .btn-danger-modern i {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            line-height: 1;
        }

    #alertsConfigureFrame {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* Modern Tab Structure with Icons - compact spacing like PM_QuickTaskNew */
    .modern-tab-container {
        background: white;
        border-bottom: 1px solid #e5e7eb;
        padding: 0;
        margin: 0.5rem 1rem 0 1rem;
        overflow: hidden;
    }

    .modern-tabs {
        border-bottom: none;
        margin: 0;
        padding: 0;
        display: flex;
        flex-wrap: nowrap;
        /*overflow-x: auto;*/
        background: white;
        width: 100%;
    }

        .modern-tabs .nav-item {
            margin-bottom: 0;
            flex-shrink: 0;
        }

            .modern-tabs .nav-item:last-child .nav-link {
                margin-right: 0;
            }

        .modern-tabs .nav-link {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 10px 18px;
            border: none;
            border-radius: 8px 8px 0 0;
            background-color: #ffffff;
            color: #6b7280;
            font-size: 12px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
            white-space: nowrap;
            transition: all 0.2s ease;
            margin-right: 2px;
            position: relative;
            cursor: pointer;
            min-height: 42px;
        }

            .modern-tabs .nav-link i {
                font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
                color: #6b7280;
                transition: color 0.2s ease;
                line-height: 1;
            }

            .modern-tabs .nav-link span {
                display: inline-block;
                line-height: 1.2;
            }

            .modern-tabs .nav-link:hover {
                background-color: #f9fafb;
                color: #374151;
            }

                .modern-tabs .nav-link:hover i {
                    color: #374151;
                }

            .modern-tabs .nav-link.active {
                background-color: #dbeafe;
                color: #1e40af;
                font-weight: 600;
                box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.05);
                z-index: 10;
                padding: 10px 16px;
                gap: 5px;
            }

                .modern-tabs .nav-link.active i {
                    color: #1e40af;
                }

                .modern-tabs .nav-link.active::after {
                    content: '';
                    position: absolute;
                    bottom: -1px;
                    left: 0;
                    right: 0;
                    height: 2px;
                    background-color: #dbeafe;
                    z-index: 11;
                }

        /* Smooth scrollbar for tabs on mobile */
        .modern-tabs::-webkit-scrollbar {
            height: 4px;
        }

        .modern-tabs::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        .modern-tabs::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 2px;
        }

            .modern-tabs::-webkit-scrollbar-thumb:hover {
                background: #94a3b8;
            }

    /* Duration dropdown width (bootstrap-select) */
    /*.FilterDropdown.bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
        width: 200px;
    }*/

    /* Project Alerts Configuration Table Styles - compact spacing, checkboxes match PM_ToolsSkills (custom_chckbox) */
    #ProjectAlertsConfigTbl {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        table-layout: fixed;
        border: none !important;
        border-collapse: separate;
        border-spacing: 0;
    }

        #ProjectAlertsConfigTbl thead th {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 600;
            color: #374151;
            background-color: #e7edf0;
            border-bottom: 2px solid #cbd5e1;
            border-top: none !important;
            border-left: none !important;
            border-right: none !important;
            padding: 10px 8px;
        }

        #ProjectAlertsConfigTbl tbody td {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #374151;
            vertical-align: middle;
            white-space: nowrap;
            border-left: none !important;
            border-right: none !important;
            border-top: none !important;
            padding: 10px 8px;
        }

        #ProjectAlertsConfigTbl tbody tr {
            border-left: none !important;
            border-right: none !important;
            transition: background-color 0.2s ease;
        }

            #ProjectAlertsConfigTbl tbody tr:hover {
                background-color: #f9fafb;
            }

            /* Section Header Styling */
            #ProjectAlertsConfigTbl tbody tr.section-header {
                background-color: #f8f9fa;
                border-bottom: 2px solid #dee2e6;
                border-top: 2px solid #dee2e6;
            }

                #ProjectAlertsConfigTbl tbody tr.section-header:first-of-type {
                    border-top: none;
                }

                #ProjectAlertsConfigTbl tbody tr.section-header td:first-child {
                    padding: 10px 8px;
                    font-weight: 600;
                    font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
                    color: #1e40af;
                    letter-spacing: 0.3px;
                    text-transform: none;
                    background-color: #f8f9fa;
                    text-align: left;
                }

                #ProjectAlertsConfigTbl tbody tr.section-header td:not(:first-child) {
                    background-color: #f8f9fa;
                    padding: 0;
                }

            /* Alert Row Styling */
            #ProjectAlertsConfigTbl tbody tr.alert-row {
                border-bottom: 1px solid #e5e7eb;
                background-color: #fff;
            }

                #ProjectAlertsConfigTbl tbody tr.alert-row:hover {
                    background-color: #f9fafb;
                }

                #ProjectAlertsConfigTbl tbody tr.alert-row:last-child {
                    border-bottom: none;
                }

                /* Ensure consistent padding in alert rows */
                #ProjectAlertsConfigTbl tbody tr.alert-row td {
                    padding: 10px 8px;
                }

                    /* Improve input and select alignment - compact gap to match other pages */
                    #ProjectAlertsConfigTbl tbody tr.alert-row td:first-child > div {
                        display: flex;
                        align-items: center;
                        gap: 4px;
                    }

                /* Better spacing for text inputs */
                #ProjectAlertsConfigTbl tbody tr.alert-row input[type="text"] {
                    margin-left: 4px;
                    margin-right: 0;
                }

                /* Better spacing for unit labels */
                #ProjectAlertsConfigTbl tbody tr.alert-row span[style*="color: #6b7280"] {
                    margin-left: 4px;
                }

        /* Use custom_chckbox (same as PM_ToolsSkills) - no large native checkbox */
        #ProjectAlertsConfigTbl .custom_chckbox {
            display: inline-block;
            flex-shrink: 0;
        }
        #ProjectAlertsConfigTbl .custom_chckbox label:before {
            margin-right: 0;
        }

        #ProjectAlertsConfigTbl input[type="text"] {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            padding: 6px 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            flex-shrink: 0;
        }

            #ProjectAlertsConfigTbl input[type="text"]:focus {
                outline: none;
                border-color: #1359a6;
                box-shadow: 0 0 0 2px rgba(19, 89, 166, 0.1);
            }

            #ProjectAlertsConfigTbl input[type="text"]:disabled {
                background-color: #f3f4f6;
                color: #9ca3af;
                cursor: not-allowed;
            }

        #ProjectAlertsConfigTbl select {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            padding: 6px 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }

            #ProjectAlertsConfigTbl select:focus {
                outline: none;
                border-color: #1359a6;
                box-shadow: 0 0 0 2px rgba(19, 89, 166, 0.1);
            }

            #ProjectAlertsConfigTbl select:disabled {
                background-color: #f3f4f6;
                color: #9ca3af;
                cursor: not-allowed;
            }

        #ProjectAlertsConfigTbl label {
            font-weight: 500;
            color: #374151;
            cursor: pointer;
            margin: 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* Ensure table cells don't wrap */
        #ProjectAlertsConfigTbl td,
        #ProjectAlertsConfigTbl th {
            white-space: nowrap;
            overflow: hidden;
        }

            /* Task column - allow text to truncate if needed */
            #ProjectAlertsConfigTbl td:first-child {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

                #ProjectAlertsConfigTbl td:first-child > div {
                    white-space: nowrap;
                    overflow: hidden;
                }

                #ProjectAlertsConfigTbl td:first-child label {
                    overflow: hidden;
                    text-overflow: ellipsis;
                    display: inline-block;
                    max-width: 100%;
                }

    /* MyAlerts Table Styling - Matching Project Alerts Table */
    #MyAlertsTbl {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        table-layout: fixed;
        border: none !important;
        border-collapse: separate;
        border-spacing: 0;
    }

        #MyAlertsTbl thead th {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 600;
            color: #374151;
            background-color: #e7edf0;
            border-bottom: 2px solid #cbd5e1;
            border-top: none !important;
            border-left: none !important;
            border-right: none !important;
            padding: 14px 12px;
            vertical-align: middle;
        }

        #MyAlertsTbl tbody td {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #374151;
            vertical-align: middle;
            white-space: nowrap;
            border-left: none !important;
            border-right: none !important;
            border-top: none !important;
            padding: 14px 12px;
            border-bottom: 1px solid #e5e7eb;
        }

        #MyAlertsTbl tbody tr {
            border-left: none !important;
            border-right: none !important;
            transition: background-color 0.2s ease;
        }

            #MyAlertsTbl tbody tr:hover {
                background-color: #f9fafb;
            }

            #MyAlertsTbl tbody tr:last-child td {
                border-bottom: none;
            }

    /* Project Selection Offcanvas Styles */
    #offcanvasProjectSelection .offcanvas-body {
        padding: 0;
    }

    #offcanvasProjectSelection select[multiple] {
        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        color: #374151;
        background-color: #fff;
    }

        #offcanvasProjectSelection select[multiple] option {
            padding: 6px 10px;
            cursor: pointer;
        }

            #offcanvasProjectSelection select[multiple] option:hover {
                background-color: #f3f4f6;
            }

            #offcanvasProjectSelection select[multiple] option:checked {
                background-color: #dbeafe;
                color: #1e40af;
            }

    #offcanvasProjectSelection .btn-sm {
        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        padding: 6px 10px;
    }

    /* Set Alerts Offcanvas Width - Increased from 70% to 85% */
    #offcanvasSetAlerts {
        --bs-offcanvas-width: 85% !important;
        width: 85% !important;
        max-width: 1200px !important;
    }

    @media (max-width: 768px) {
        #offcanvasSetAlerts {
            --bs-offcanvas-width: 95% !important;
            width: 95% !important;
            max-width: 100% !important;
        }
    }

    /* Select Customers Modal Styles */
    #selectCustomersModal .modal-content {
        border-radius: 0;
        border: none;
    }

    #selectCustomersModal .modal-header {
        border-bottom: none;
    }
    #selectCustomersModal .custom_chckbox {
        display: inline-block;
    }
    #selectCustomersModal .custom_chckbox label:before {
        margin-right: 0;
    }

    #selectCustomersModal .modal-footer {
        border-top: none;
    }

    #selectCustomersModal .table tbody tr {
        cursor: pointer;
    }

        #selectCustomersModal .table tbody tr:hover {
            background-color: #f9fafb;
        }

        #selectCustomersModal .table tbody tr td {
            padding: 10px 12px;
            vertical-align: middle;
            border-bottom: 1px solid #e5e7eb;
        }

    #selectCustomersModal .alphabet-filter:hover {
        background-color: rgba(255, 255, 255, 0.1);
        border-radius: 3px;
    }

    #selectCustomersModal .alphabet-filter.active {
        font-weight: bold;
        background-color: rgba(255, 255, 255, 0.2);
        border-radius: 3px;
    }

    /* Select Employees Modal Styles */
    #selectEmployeesModal .modal-content {
        border-radius: 0;
        border: none;
    }

    #selectEmployeesModal .modal-header {
        border-bottom: none;
    }
    #selectEmployeesModal .custom_chckbox {
        display: inline-block;
    }
    #selectEmployeesModal .custom_chckbox label:before {
        margin-right: 0;
    }

    #selectEmployeesModal .modal-footer {
        border-top: none;
    }

    #selectEmployeesModal .table tbody tr {
        cursor: pointer;
    }

        #selectEmployeesModal .table tbody tr:hover {
            background-color: #f9fafb;
        }

        #selectEmployeesModal .table tbody tr td {
            padding: 10px 12px;
            vertical-align: middle;
            border-bottom: 1px solid #e5e7eb;
        }

    /* Ensure Save/Reset buttons are hidden by default (for Alerts tab) */
    #projectAlertsButtons {
        display: none !important;
    }

    /* Show Save/Reset buttons only when Project Alerts tab is active */
    #project-alerts-tab.active ~ * #projectAlertsButtons,
    body:has(#project-alerts-tab.active) #projectAlertsButtons {
        display: flex !important;
    }

    /* Pagination Styles */
    #alertsPagination {
        border-top: 1px solid #dee2e6;
        background: white;
    }

        #alertsPagination .btn-sm {
            min-width: 36px;
            padding: 6px 10px;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

            #alertsPagination .btn-sm:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }

            #alertsPagination .btn-sm:not(:disabled):hover {
                background-color: #1359a6;
                color: white;
                border-color: #1359a6;
            }

    .symbol-note-wrap {
        background: #f3f4f6;
        padding: 8px 10px 6px;
        border-radius: 4px;
    }

    .symbol-note-text {
        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        color: #111827;
        margin-bottom: 4px;
    }

    .symbol-legend {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        align-items: center;
        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        color: #111827;
    }

    .sym-item {
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .sym-box {
        width: 25px;
        height: 25px;
        border: 1px solid #bbbbbb;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        font-weight: 500;
        border-radius: 2px;
        background-color: #e9e9e9;
    }

    .alerts-pagination {
        display: flex;
        justify-content: flex-end; /* ⬅ everything to the right */
        align-items: center;
        gap: 12px; /* space between text & buttons */
        padding: 10px 12px;
        border-top: 1px solid #dee2e6;
        background: #fff;
    }

        .alerts-pagination .total-records {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #6b7280;
            white-space: nowrap;
        }

        .alerts-pagination .pagination-actions {
            display: flex;
            gap: 6px;
        }


    .alerts-pagination {
        padding-right: 20px;
    }

    .alerts-table td {
        white-space: normal !important; /* allow wrapping */
        word-break: break-word; /* break long words */
        overflow-wrap: anywhere; /* modern wrapping */
        vertical-align: top; /* better alignment */
    }

    .alerts-table th {
        white-space: nowrap; /* headers stay clean */
    }
    .form-check-input {
        -webkit-appearance: auto;
        -moz-appearance: auto;
        appearance: auto;
    }
    .btn-close {
        --bs-btn-close-color: #fff;
    }

    /* Fullscreen loader overlay (same as PM_ProjectProfitability) */
    .loader-overlay {
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
    .loader-overlay .loader {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 100px;
        height: 100px;
        margin: -50px 0 0 -50px;
        background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
    }
    /* Initial page-load preloader */
    .preloader {
        position: fixed;
        top: 50%;
        left: 50%;
        width: 100px;
        height: 100px;
        margin: -50px 0 0 -50px;
        background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
        z-index: 2100;
    }
</style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="MyAlerts">
    <div id="MyAlertsPreloader" class="preloader"></div>
    <div class="loader-overlay" id="loaderOverlay" style="display: none;">
        <div class="loader"></div>
    </div>
    <%If m_blnViewAccess = True Then%>
    <div id="MyAlertsWrapper" style="display: none;">
    <div class="bgwhite">
        <!-- Header Section with Icon and Subtitle -->
<%--        Class Added By Madhuri.K On 11-03-2026--%>
        <div class="graybg" style="padding: 1rem 0; margin-bottom: 0.5rem;">
            <div style="padding-left: 1rem; margin-left: 0;">
                <h2 style="color: #1e40af; font-weight: 600; font-size: 18px; margin: 0 0 0.25rem 0; display: flex; align-items: center;">
                    <i class="fas fa-bell" style="color: #1e40af; font-size: 1.5rem; margin-right: 0.75rem;" data-bs-toggle="tooltip" title="My Alerts"></i>
                    My Alerts
                </h2>
                <p style="color: #6b7280; font-size: 0.7rem; margin: 0;"><%=MyBase.GetResourceString("C_PageNote") %></p>
            </div>
        </div>

        <!-- Tabs with Icons -->
        <div class="modern-tab-container">
            <ul class="nav nav-tabs modern-tabs" id="AlertsTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" id="alerts-tab" data-bs-toggle="tab" href="#alerts-pane" role="tab" aria-controls="alerts-pane" aria-selected="true" onclick="SwitchTab('alerts')">
                        <i class="fas fa-bell"></i>
                        <span><%=MyBase.GetResourceString("C_Alerts") %></span>
                    </a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="project-alerts-tab" data-bs-toggle="tab" href="#project-alerts-pane" role="tab" aria-controls="project-alerts-pane" aria-selected="false" onclick="SwitchTab('project-alerts')">
                        <i class="fas fa-project-diagram"></i>
                        <span><%=MyBase.GetResourceString("C_ProjectAlerts") %></span>
                    </a>
                </li>
            </ul>
        </div>

        <!-- Search and Filter Section (spacing aligned with PM_QuickTaskNew header) -->
        <div style="background: rgb(231, 237, 240); padding: 0.5rem 1rem; margin: 0.5rem 1rem 0 1rem;">
            <div style="display: flex; align-items: center; justify-content: space-between; gap: 0.75rem;">
                <!-- Left Side - Project and Duration Dropdowns -->
                <div id="filterControlsLeft" style="display: flex; align-items: center; gap: 0.75rem; flex-wrap: wrap;">
                    <!-- Duration Dropdown -->
                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                        <label style="color: #374151; font-size: 11.5px; font-weight: 500; margin: 0;" id="durationid"><%=MyBase.GetResourceString("C_Duration") %>:</label>
                        <div class="bs-wrapper">
                            <%--<select id="cboDuration" class="selectpicker form-select" data-live-search="true"  onchange="FilterAlerts();">--%>
                            <select id="cboDuration" class="selectpicker form-select form-select-sm" data-live-search="true" style="width: 200px; max-width: 100%; padding: 0.35rem 0.75rem; font-size: 11.5px; height: 34px;"  onchange="FilterAlerts();">
                                <%--<option value="All">All</option>
                        <option value="Today">Today</option>
                        <option value="ThisWeek">This Week</option>
                        <option value="ThisMonth">This Month</option>
                        <option value="LastMonth">Last Month</option>--%>
                            </select>
                        </div>
                    </div>
                </div>
                <!-- Right Side - Action Buttons -->
                <div style="display: flex; align-items: center; gap: 0.75rem; margin-left: auto;">
                    <!-- Set Alerts Button (Hidden for Project Alerts tab) -->
                    <a href="javascript:void(0);" id="btnSetAlerts" class="btn borderbtn btn-sm" onclick="SetAlerts(); return false;" data-bs-toggle="tooltip" title="Set Alerts"><%=MyBase.GetResourceString("C_SetAlerts") %></a>
                    <!-- Save Button (Only shown for Project Alerts tab) -->
                    <div id="projectAlertsButtons" style="display: none; gap: 0.5rem;" class="d-flex align-items-center">
                        <%If m_blnAddAccess = True Then%>
                        <button type="button" class="btn btnyellow btn-sm" id="btnSaveProjectAlertsTop" onclick="SaveProjectAlerts();"><%=MyBase.GetResourceString("C_Save") %></button>
                        <%End If%>
                    </div>
                    <%--<span data-bs-toggle="tooltip" title="Filters">
                        <button data-bs-toggle="collapse" data-bs-target="#filterpanel" id="AdvanceFilterIcon" autocomplete="off" class="" aria-expanded="false" style="background: none; border: none; color: #374151; cursor: pointer; padding: 0.5rem;">
                            <i class="fas fa-filter"></i>
                        </button>
                    </span>--%>
                </div>
            </div>
        </div>

        <!-- Filter Panel -->
        <%--<div id="filterpanel" class="filterpanel collapse">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                <div class="cust_tabpanel mt-3">
                    <ul class="nav nav-tabs">
                        <li class="">
                            <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true"><%=MyBase.GetResourceString("C_BasicFilters") %></a>
                        </li>
                    </ul>
                </div>
                <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="basicfilters" class="tab-pane">
                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn mb-3">
                                    <button class="btn btnyellow" id="applyFilterBtn" data-bs-toggle="tooltip" title="Apply Filter"><%=MyBase.GetResourceString("C_Apply") %></button>
                                </div>
                                <br />
                                <!-- Filter content can be added here -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
        <!-- End Filter Panel -->

        <!-- Tab Content -->
        <div class="content pt-0">
            <div class="tab-content">
                <!-- Alerts Tab -->
                <div class="tab-pane fade show active" id="alerts-pane" role="tabpanel" aria-labelledby="alerts-tab">
                    <div class="container-fluid" style="background: white; padding: 1rem;">
                        <div style="overflow-x: auto; border: 1px solid #dee2e6; background-color: #fff;">
                            <table id="MyAlertsTbl" class="table alerts-table" style="width: 100%; margin-bottom: 0; table-layout: fixed; border-collapse: separate; border-spacing: 0;">
                                <thead style="background-color: #e7edf0;">
                                    <tr>
                                        <th style="width: 80px; text-align: center; padding: 14px 12px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1; border-right: none;">
                                            <i class="fa fa-flag pe-2"></i><%=MyBase.GetResourceString("C_Flag") %>
                                </th>
                                        <th style="text-align: center; padding: 14px 12px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1; border-left: none; border-right: none;">
                                            <%=MyBase.GetResourceString("C_ProjectName") %> 
                                </th>
                                        <th style="text-align: center; padding: 14px 12px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1; border-left: none; border-right: none;"><%=MyBase.GetResourceString("C_Name") %></th>
                                        <th style="text-align: center; padding: 14px 12px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1; border-left: none; border-right: none;"><%=MyBase.GetResourceString("C_ResourceCustomer") %></th>
                                        <th style="text-align: center; padding: 14px 12px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1; border-left: none; border-right: none;"><%=MyBase.GetResourceString("C_Status") %></th>
                                        <th style="text-align: center; padding: 14px 12px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1; border-left: none; border-right: none;"><%=MyBase.GetResourceString("C_DueDate") %></th>
                                        <%--<th style="width: 80px; text-align: center; padding: 14px 12px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1; border-left: none; border-right: none;">Action</th>--%>
                                    </tr>
                                </thead>
                                <tbody id="MyAlertsTblBody" style="background-color: #fff;">
                                    <tr>
                                        <td colspan="6" style="text-align: center !important; padding: 30px; border-left: none; border-right: none;"><%=MyBase.GetResourceString("C_NoItems") %></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- Pagination Controls -->
                        <%--<div id="alertsPagination" style="display: none; padding: 1rem; background: white; border-top: 1px solid #dee2e6;">
                            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <span style="color: #374151; font-size: 11.5px;">Showing</span>
                                    <span id="alertsPaginationInfo" style="color: #1e40af; font-weight: 500; font-size: 11.5px;">0 - 0 of 0</span>
                                    <span style="color: #374151; font-size: 11.5px;">records</span>
                                </div>
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <button type="button" id="alertsPaginationFirst" class="btn borderbtn btn-sm" onclick="GoToAlertsPage(1);" disabled>
                                        <i class="fas fa-angle-double-left"></i>
                                    </button>
                                    <button type="button" id="alertsPaginationPrev" class="btn borderbtn btn-sm" onclick="GoToAlertsPage(currentAlertsPage - 1);" disabled>
                                        <i class="fas fa-angle-left"></i>
                                    </button>
                                    <span style="color: #374151; font-size: 11.5px; padding: 0 0.5rem;">
                                        Page <span id="alertsCurrentPage" style="font-weight: 500;">1</span> of <span id="alertsTotalPages" style="font-weight: 500;">1</span>
                                    </span>
                                    <button type="button" id="alertsPaginationNext" class="btn borderbtn btn-sm" onclick="GoToAlertsPage(currentAlertsPage + 1);" disabled>
                                        <i class="fas fa-angle-right"></i>
                                    </button>
                                    <button type="button" id="alertsPaginationLast" class="btn borderbtn btn-sm" onclick="GoToAlertsPage(totalAlertsPages);" disabled>
                                        <i class="fas fa-angle-double-right"></i>
                                    </button>
                                </div>
                            </div>
                        </div>--%>

                        <div class="pagination-container alerts-pagination">
                            <span id="alertsTotalRecords" class="total-records">Total Records: 0
                            </span>

                            <div class="pagination-actions">
                                <button class="btn borderbtn"
                                    id="alertsPrevBtn"
                                    onclick="goToPreviousAlertsPage()"
                                    title="Previous Page">
                                    <i class="fas fa-angle-double-left"></i>
                                </button>

                                <button class="btn borderbtn"
                                    id="alertsNextBtn"
                                    onclick="goToNextAlertsPage()"
                                    title="Next Page">
                                    <i class="fas fa-angle-double-right"></i>
                                </button>
                            </div>
                        </div>


                        <div class="clearfix"></div>

                        <div class="symbol-note-wrap">
                            <div class="symbol-note-text">
                                <strong><%=MyBase.GetResourceString("C_Note") %>:</strong> <%=MyBase.GetResourceString("C_BelowNote") %>
                            </div>

                            <div class="symbol-legend">
                                <span class="sym-item"><span class="sym-box sym-d">D</span> <%=MyBase.GetResourceString("C_Deliverable") %></span>
                                <span class="sym-item"><span class="sym-box sym-h">H</span> <%=MyBase.GetResourceString("C_HelpRequest") %></span>
                                <span class="sym-item"><span class="sym-box sym-i">I</span> <%=MyBase.GetResourceString("C_Issue") %></span>
                                <span class="sym-item"><span class="sym-box sym-m">M</span> <%=MyBase.GetResourceString("C_Milestone") %></span>
                                <span class="sym-item"><span class="sym-box sym-r">R</span> <%=MyBase.GetResourceString("C_Risk") %></span>
                                <span class="sym-item"><span class="sym-box sym-t">T</span> <%=MyBase.GetResourceString("C_Task") %></span>
                                <span class="sym-item"><span class="sym-box sym-w">W</span> <%=MyBase.GetResourceString("C_Review") %></span>
                                <span class="sym-item"><span class="sym-box sym-w">Mod</span> Module</span>
                            </div>
                        </div>


                    </div>
                </div>

                <!-- Project Alerts Tab -->
                <div class="tab-pane fade" id="project-alerts-pane" role="tabpanel" aria-labelledby="project-alerts-tab">
                    <div class="container-fluid" style="background: white; padding: 0.5rem;">
                        <!-- Header Section -->
                        <div style="margin-bottom: 0.5rem;">
                            <h4 style="color: #1e40af; font-weight: 600; font-size: 11.5px; margin: 0;"><%=MyBase.GetResourceString("C_SelectAlerts") %></h4>
                        </div>

                        <!-- Alerts Configuration Table -->
                        <div style="overflow-x: auto; border: 1px solid #dee2e6; background-color: #fff;">
                            <table id="ProjectAlertsConfigTbl" class="table" style="width: 100%; margin-bottom: 0; table-layout: fixed; border-collapse: separate; border-spacing: 0;">
                                <thead style="background-color: #e7edf0;">
                                    <tr>
                                        <th style="width: 52%; text-align: left; padding: 10px 8px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1; border-right: none;"><%=MyBase.GetResourceString("C_Task") %></th>
                                        <th style="width: 13%; text-align: center; padding: 10px 8px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1; border-left: none; border-right: none;">
                                            <a href="javascript:void(0);" onclick="SelectProjectForAlerts('Task'); return false;" style="color: #1359a6; text-decoration: underline; cursor: pointer;"><%=MyBase.GetResourceString("C_ProjectSelection") %></a>
                                        </th>
                                        <th style="width: 20%; text-align: center; padding: 10px 8px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1; border-left: none; border-right: none;"><%=MyBase.GetResourceString("C_Frequency") %></th>
                                        <th style="width: 15%; text-align: center; padding: 10px 8px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1; border-left: none;"><%=MyBase.GetResourceString("C_SendMail") %></th>
                                    </tr>
                                </thead>
                                <tbody id="ProjectAlertsTblBody" style="background-color: #fff;">
                                    <%--<!-- Data will be loaded dynamically -->
                                    <tr>
                                        <td colspan="4" style="text-align:center !important; padding: 30px;">Loading...</td>
                                    </tr>--%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- Set Alerts Offcanvas -->
        <div class="offcanvas offcanvas-end" data-bs-scroll="false" tabindex="-1" id="offcanvasSetAlerts" aria-labelledby="offcanvasSetAlertsLabel" style="width: 85%; max-width: 1200px;">
            <div class="offcanvas-body">
                <div class="Edit_Details">
                    <!-- Header -->
                    <div class="graybg container-fluid py-1 mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-10">
                                <h5 class="pgtitle" style="margin: 0;"><%=MyBase.GetResourceString("C_SetAlerts") %></h5>
                            </div>
                            <div class="col-sm-2 text-end">
                                <button type="button"
                                        class="btn-close"
                                        data-bs-dismiss="offcanvas"
                                        aria-label="Close"
                                        onclick="$('body').removeClass('offcanvas-open');"></button>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="row my-2">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-2"></div>
                                <div class="col-sm-10 text-end" style="white-space: nowrap;">
                                    <%If m_blnAddAccess = True Then%>
                                    <button type="button" class="btn btnyellow me-2" id="btnSaveAlerts" onclick="SaveAlertsConfiguration();"><%=MyBase.GetResourceString("C_Save") %></button>
                                    <%End If%>
                                    <%--<button type="button" class="btn borderbtn closebtn" data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');"><%=MyBase.GetResourceString("C_Close") %></button>--%>
                                    <%--<button type="button" class="btn borderbtn ms-2" onclick="ShowSetAlertsHelp();">
                                     <%=MyBase.GetResourceString("C_Help") %>
                                </button>--%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Mandatory Label -->
                    <%--<div class="row mb-2">
                    <div class="col-sm-12 text-end">--%>
                    <%--<label class="form-label"><%=MyBase.GetResourceString("C_Mandatory")%></label>--%>
                    <%--<label class="form-label"><%=MyBase.GetResourceString("C_Mandatory")%></label>--%>
                    <%--</div>
                </div>--%>


                    <!-- Set Alerts Content -->
                    <div class="container-fluid" style="padding: 1rem 0;">
                        <!-- Email Address Display -->
                        <div class="row mb-3">
                            <div class="col-sm-12">
                                <p style="margin: 0; font-size: 11.5px; color: #374151;">
                                    <%=MyBase.GetResourceString("C_SendMeAlertsOn")%> - <strong id="alertEmailAddress" style="color: #1359a6;"></strong>
                                </p>
                            </div>
                        </div>

                        <!-- Help-Desk Related Alerts Section -->
                        <div class="row mb-4">
                            <div class="col-sm-12">
                                <div style="background-color: #e7edf0; padding: 10px 15px; margin-bottom: 15px; border-left: 4px solid #1359a6;">
                                    <h6 style="margin: 0; font-weight: 600; color: #1e40af; font-size: 11.5px;"><%=MyBase.GetResourceString("C_HelpRelAlerts")%></h6>
                                </div>

                                <div style="padding-left: 15px;">
                                    <!-- Alert me immediately when Help Request is entered by -->
                                    <div class="row mb-3 align-items-center">
                                        <div class="col-sm-12">
                                            <div style="display: flex; align-items: center; gap: 10px;">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="chkHelpRequestEntered" name="chkHelpRequestEntered" />
                                                    <label for="chkHelpRequestEntered"></label>
                                                </div>
                                                <label for="chkHelpRequestEntered" style="margin: 0; font-weight: 500; color: #374151; cursor: pointer;">
                                                    <%=MyBase.GetResourceString("C_Alertmeimmediately")%>
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Customers Employees Links -->
                                    <div class="row mb-3" style="padding-left: 28px;">
                                        <div class="col-sm-12">
                                            <div style="display: flex; align-items: center; gap: 15px; flex-wrap: wrap;">
                                                <a href="javascript:void(0);" onclick="SelectCustomersForAlerts();" style="color: #1359a6; text-decoration: underline; cursor: pointer;" id="custmerlinkid"><%=MyBase.GetResourceString("C_Customers")%></a>
                                                <a href="javascript:void(0);" onclick="SelectEmployeesForAlerts();" style="color: #1359a6; text-decoration: underline; cursor: pointer;" id="employeelinkid"><%=MyBase.GetResourceString("C_Employees")%></a>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Alert me if help request is not resolved/closed -->
                                    <div class="row mb-3 align-items-center">
                                        <div class="col-sm-12">
                                            <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="chkHelpRequestNotResolved" name="chkHelpRequestNotResolved" />
                                                    <label for="chkHelpRequestNotResolved"></label>
                                                </div>
                                                <label for="chkHelpRequestNotResolved" style="margin: 0; font-weight: 500; color: #374151; cursor: pointer;">
                                                    <%=MyBase.GetResourceString("C_AlertMeIF")%>
                                                </label>
                                                <input type="text" id="txtHelpRequestNotResolved" name="txtHelpRequestNotResolved" class="form-control" style="width: 80px; text-align: right; flex-shrink: 0;" maxlength="5" disabled oninput="allowTwoDigitPositiveNumberOnly(this)" />
                                                Day(s)

                                            </div>
                                        </div>
                                    </div>

                                    <!-- Send Me Reminder for Help-Desk -->
                                    <div class="row mb-3 align-items-center">
                                        <div class="col-sm-12">
                                            <div style="display: flex; align-items: center; gap: 10px;">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="chkHelpDeskReminder" name="chkHelpDeskReminder" />
                                                    <label for="chkHelpDeskReminder"></label>
                                                </div>
                                                <label for="chkHelpDeskReminder" style="margin: 0; font-weight: 500; color: #374151; cursor: pointer;">
                                                    <%=MyBase.GetResourceString("C_SendMeReminder")%>
                                                </label>
                                                <input type="text" id="txtSendMeRembefexpresdt" name="txtSendMeRembefexpresdt" class="form-control" style="width: 80px; text-align: right; flex-shrink: 0;" maxlength="5" disabled oninput="allowTwoDigitPositiveNumberOnly(this)" />
                                                <span style="color: #6b7280; white-space: nowrap; font-size: 11.5px;"><%=MyBase.GetResourceString("C_DaysBeforeResolution")%></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Other Alerts Section -->
                        <div class="row mb-4">
                            <div class="col-sm-12">
                                <div style="background-color: #e7edf0; padding: 10px 15px; margin-bottom: 15px; border-left: 4px solid #1359a6;">
                                    <h6 style="margin: 0; font-weight: 600; color: #1e40af; font-size: 11.5px;"><%=MyBase.GetResourceString("C_OtherAlerts")%></h6>
                                </div>

                                <div style="padding-left: 15px;">
                                    <!-- Send Me Reminder - Task Due Date -->
                                    <div class="row mb-3 align-items-center">
                                        <div class="col-sm-12">
                                            <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="chkTaskDueDateReminder" name="chkTaskDueDateReminder" />
                                                    <label for="chkTaskDueDateReminder"></label>
                                                </div>
                                                <label for="chkTaskDueDateReminder" style="margin: 0; font-weight: 500; color: #374151; cursor: pointer;">
                                                    <%=MyBase.GetResourceString("C_SendMeReminder")%>
                                                </label>
                                                <input type="text" id="txtTaskDueDateReminder" name="txtTaskDueDateReminder" class="form-control" style="width: 80px; text-align: right; flex-shrink: 0;" maxlength="5" disabled oninput="allowTwoDigitPositiveNumberOnly(this)" />
                                                <span style="color: #6b7280; white-space: nowrap; font-size: 11.5px;">Day(s) before <strong>Task</strong> <%=MyBase.GetResourceString("C_DueDate")%></span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Send Me Reminder - Review Due Date -->
                                    <div class="row mb-3 align-items-center">
                                        <div class="col-sm-12">
                                            <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="chkReviewDueDateReminder" name="chkReviewDueDateReminder" />
                                                    <label for="chkReviewDueDateReminder"></label>
                                                </div>
                                                <label for="chkReviewDueDateReminder" style="margin: 0; font-weight: 500; color: #374151; cursor: pointer;">
                                                    <%=MyBase.GetResourceString("C_SendMeReminder")%>
                                                </label>
                                                <input type="text" id="txtReviewDueDateReminder" name="txtReviewDueDateReminder" class="form-control" style="width: 80px; text-align: right; flex-shrink: 0;" maxlength="5" disabled oninput="allowTwoDigitPositiveNumberOnly(this)" />
                                                <span style="color: #6b7280; white-space: nowrap; font-size: 11.5px;">Day(s) before <strong>Review</strong> <%=MyBase.GetResourceString("C_DueDate")%></span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Send Me Reminder - Deliverable Due Date -->
                                    <div class="row mb-3 align-items-center">
                                        <div class="col-sm-12">
                                            <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="chkDeliverableDueDateReminder" name="chkDeliverableDueDateReminder" />
                                                    <label for="chkDeliverableDueDateReminder"></label>
                                                </div>
                                                <label for="chkDeliverableDueDateReminder" style="margin: 0; font-weight: 500; color: #374151; cursor: pointer;">
                                                    <%=MyBase.GetResourceString("C_SendMeReminder")%>
                                                </label>
                                                <input type="text" id="txtDeliverableDueDateReminder" name="txtDeliverableDueDateReminder" class="form-control" style="width: 80px; text-align: right; flex-shrink: 0;" maxlength="5" disabled oninput="allowTwoDigitPositiveNumberOnly(this)" />
                                                <span style="color: #6b7280; white-space: nowrap; font-size: 11.5px;">Day(s) before <strong>Deliverable</strong> <%=MyBase.GetResourceString("C_DueDate")%></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Set Alerts Offcanvas End -->

        <!-- Tracking Details Offcanvas (compact size) -->
        <div class="offcanvas offcanvas-end" data-bs-scroll="false" tabindex="-1" id="offcanvasTrackingDetails" aria-labelledby="offcanvasTrackingDetailsLabel" style="width: 600px; max-width: 95vw;">
            <div class="offcanvas-header" style="background-color: #1359a6; color: white; padding: 0.6rem 1rem; display: flex; justify-content: space-between; align-items: center;">
                <h5 class="offcanvas-title" id="offcanvasTrackingDetailsLabel" style="font-weight: 600; margin: 0; font-size: 1rem;"><%=MyBase.GetResourceString("C_TrackingDetails")%></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close" onclick="$('body').removeClass('offcanvas-open');"></button>
            </div>
            <div class="offcanvas-body" style="padding: 1rem;">
                <!-- Action Buttons -->
                <div class="d-flex justify-content-end gap-2 mb-3" style="border-bottom: 1px solid #dee2e6; padding-bottom: 0.75rem;">
                    <button type="button" class="btn borderbtn" id="btnClearFlag" onclick="ClearTrackingFlag();" style="display: none;"><%=MyBase.GetResourceString("C_ClearFlag")%></button>
                    <%--<button type="button" class="btn borderbtn" data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');"><%=MyBase.GetResourceString("C_Close")%></button>--%>
                    <button type="button" class="btn btnyellow" onclick="SaveTrackingDetails();"><%=MyBase.GetResourceString("C_Save")%></button>
                </div>
                <div class="mb-2 text-end">
                    <span style="color: #dc2626; font-size: 11.5px; font-weight: 500;">* <%=MyBase.GetResourceString("C_Mandatory")%>
                    </span>
                </div>

                <div class="mb-2">
                    <p style="color: #6b7280; font-size: 11.5px; margin-bottom: 0;">
                        <%=MyBase.GetResourceString("C_FlaggingNote")%>
                    </p>
                </div>

                <div class="mb-2">
                    <label class="form-label" style="font-weight: 500; color: #374151; font-size: 11.5px;"><%=MyBase.GetResourceString("C_RequestID")%> :</label>
                    <span id="trackingRequestID" style="color: #374151; font-weight: 500;"></span>
                </div>

                <%--<div class="mb-3">
                    <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_HelpRequest")%> :</label>
                    <span id="trackingHelpRequest" style="color: #374151;"></span>
                </div>--%>

                <div class="mb-2">
                    <label class="form-label" style="font-weight: 500; color: #374151; font-size: 11.5px;"><%=MyBase.GetResourceString("C_Flagto")%> <span style="color: red;">*</span></label>
                    <select id="cboFlagTo" class="form-select form-select-sm" style="width: 250px; max-width: 100%; padding: 0.35rem 0.75rem; font-size: 13px; height: 34px;">
                        <option value="-1">-- Select --</option>
                    </select>
                    <span id="trackingFlagToError" style="color: red; font-size: 11.5px; display: none;"><%=MyBase.GetResourceString("C_SelFlagTo")%></span>
                </div>

                <div class="mb-2">
                    <label class="form-label" style="font-weight: 500; color: #374151; font-size: 11.5px;"><%=MyBase.GetResourceString("C_Dueby")%> <span style="color: red;">*</span></label>
                    <div class="input-group input-group-sm" style="width: 250px; max-width: 100%;">
                        <input type="text" id="trackingDueDate" class="form-control" placeholder="DD/MM/YYYY" style="padding: 0.35rem 0.75rem; font-size: 13px; height: 34px;" readonly />
                        <span class="input-group-text" style="cursor: pointer; background-color: #e7edf0; padding: 0.35rem 0.75rem; height: 34px;" id="trackingDatePickerIcon">
                            <i class="fa fa-calendar" style="color: #1359a6;"></i>
                        </span>
                    </div>
                    <span id="trackingDueDateError" style="color: red; font-size: 12px; display: none;"><%=MyBase.GetResourceString("C_SelDueDt")%></span>
                </div>

                <div class="mb-0">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="chkFlagComplete" style="width: 16px; height: 16px; cursor: pointer;" />
                        <label class="form-check-label" for="chkFlagComplete" style="font-weight: 500; color: #374151; cursor: pointer; margin-left: 6px; font-size: 11.5px;">
                            <%=MyBase.GetResourceString("C_Complete")%>
                        </label>
                    </div>
                </div>

                <!-- Hidden fields -->
                <input type="hidden" id="hdnTrackingUniqueID" value="0" />
                <input type="hidden" id="hdnTrackingContextID" value="0" />
                <input type="hidden" id="hdnTrackingContextType" value="" />
                <input type="hidden" id="hdnTrackingProjectID" value="0" />
            </div>
        </div>
        <!-- Tracking Details Offcanvas End -->

        <!-- Request Details Offcanvas -->
        <div class="offcanvas offcanvas-end" data-bs-scroll="true" tabindex="-1" id="offcanvasRequestDetails" aria-labelledby="offcanvasRequestDetailsLabel" style="width: 90%; max-width: 1400px;">
            <div class="offcanvas-header" style="background-color: #1359a6; color: white; padding: 1rem; display: flex; justify-content: space-between; align-items: center;">
                <h5 class="offcanvas-title" id="offcanvasRequestDetailsLabel" style="font-weight: 600; margin: 0;"><%=MyBase.GetResourceString("C_RequestDetails")%></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close" onclick="$('body').removeClass('offcanvas-open');"></button>
            </div>
            <div class="offcanvas-body" style="padding: 1.5rem; background-color: #fff;">
                <!-- Request Overview Section -->
                <div class="mb-4" style="background-color: #f8f9fa; padding: 1rem; border-radius: 4px; border-left: 4px solid #1359a6;">
                    <div class="row mb-2">
                        <div class="col-md-6">
                            <label class="form-label" style="font-weight: 600; color: #374151; margin-bottom: 0.25rem;"><%=MyBase.GetResourceString("C_RequestID")%>:</label>
                            <span id="requestDetailsID" style="color: #374151; font-weight: 500; font-size: 11.5px;"></span>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" style="font-weight: 600; color: #374151; margin-bottom: 0.25rem;"><%=MyBase.GetResourceString("C_Requestor")%>:</label>
                            <span id="requestDetailsRequestor" style="color: #374151;"></span>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-md-6">
                            <label class="form-label" style="font-weight: 600; color: #374151; margin-bottom: 0.25rem;"><%=MyBase.GetResourceString("C_RequestedOn")%>:</label>
                            <span id="requestDetailsRequestedOn" style="color: #374151;"></span>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" style="font-weight: 600; color: #374151; margin-bottom: 0.25rem;"><%=MyBase.GetResourceString("C_Priority")%>:</label>
                            <span id="requestDetailsPriority" style="color: #374151;"></span>
                        </div>
                    </div>
                </div>

                <!-- Request Details Form (Read-Only) -->
                <div class="container-fluid" style="padding: 0;">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_Department")%> <span style="color: red;">*</span></label>
                            <input type="text" id="requestDetailsDepartment" class="form-control" readonly />
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_RequestType")%> <span style="color: red;">*</span></label>
                            <input type="text" id="requestDetailsRequestType" class="form-control" readonly />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_Subject")%> <span style="color: red;">*</span></label>
                            <input type="text" id="requestDetailsSubject" class="form-control" readonly />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_Description")%></label>
                            <textarea id="requestDetailsDescription" class="form-control" rows="3" readonly></textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_SubRequestType")%> <span style="color: red;">*</span></label>
                            <input type="text" id="requestDetailsSubRequestType" class="form-control" readonly />
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_SubHelpDeskType")%> <span style="color: red;">*</span></label>
                            <input type="text" id="requestDetailsSubHelpDeskType" class="form-control" readonly />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_Product")%></label>
                            <input type="text" id="requestDetailsProduct" class="form-control" readonly />
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_ModuleComponent")%></label>
                            <input type="text" id="requestDetailsModuleComponent" class="form-control" readonly />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_Priority")%> <span style="color: red;">*</span></label>
                            <input type="text" id="requestDetailsPrioritySelect" class="form-control" readonly />
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_Severity")%> <span style="color: red;">*</span></label>
                            <input type="text" id="requestDetailsSeverity" class="form-control" readonly />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_Status")%> <span style="color: red;">*</span></label>
                            <input type="text" id="requestDetailsStatus" class="form-control" readonly />
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_AssignedTo")%></label>
                            <input type="text" id="requestDetailsAssignedTo" class="form-control" readonly />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_OrganizationUnit")%> <span style="color: red;">*</span></label>
                            <input type="text" id="requestDetailsOrgUnit" class="form-control" readonly />
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_StatusChangeDate")%></label>
                            <input type="text" id="requestDetailsStatusChangeDate" class="form-control" readonly />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_StatusChangeTime")%></label>
                            <input type="text" id="requestDetailsStatusChangeTime" class="form-control" readonly />
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_Deliverable")%></label>
                            <input type="text" id="requestDetailsDeliverable" class="form-control" readonly />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label" style="font-weight: 500; color: #374151;"><%=MyBase.GetResourceString("C_Project")%></label>
                            <input type="text" id="requestDetailsProject" class="form-control" readonly />
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <!-- Request Details Offcanvas End -->

        <!-- Select Customers Modal -->
        <div class="modal fade custmodal" id="selectCustomersModal" tabindex="-1" role="dialog" aria-labelledby="selectCustomersModalLabel" aria-hidden="true" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document" style="max-width: 900px;">
                <div class="modal-content">
                    <!-- Header (title only) -->
                    <div class="modal-header" style="background-color: #1359a6; color: white; padding: 12px 20px;">
                        <h5 class="modal-title" id="selectCustomersModalLabel" style="margin: 0; font-weight: 600; font-size: 11.5px;"><%=MyBase.GetResourceString("C_SelectCustomers")%></h5>
                    </div>

                    <!-- Action buttons (below header, above filter) -->
                    <div style="background-color: #f5f5f5; padding: 10px 20px; border-bottom: 1px solid #dee2e6; display: flex; align-items: center; justify-content: flex-end; gap: 10px; flex-wrap: wrap;">
                        <a href="javascript:void(0);" onclick="SetSelectedCustomers();" style="color: #1359a6; text-decoration: underline; font-size: 13px; cursor: pointer;"><%=MyBase.GetResourceString("C_SetCustomers")%></a>
                        <span style="color: #999;">|</span>
                        <a href="javascript:void(0);" id="lnkShowSelected" onclick="ShowSelectedCustomers();" style="color: #1359a6; text-decoration: underline; font-size: 13px; cursor: pointer;"><%=MyBase.GetResourceString("C_ShowSelectedCustomers")%></a>
                        <a href="javascript:void(0);" id="lnkShowAll" onclick="ShowAllCustomers(); return false;" style="display: none; color: #1359a6; text-decoration: underline; font-size: 13px; cursor: pointer;">Show All Customers</a>
                        <span style="color: #999;">|</span>
                        <a href="javascript:void(0);" class="text-decoration-none" data-bs-dismiss="modal" style="color: #1359a6; font-size: 13px; cursor: pointer;" data-bs-toggle="tooltip" title="Close"><%=MyBase.GetResourceString("C_Close")%></a>
                    </div>

                    <!-- Filter Section of Customer Link-->
                    <div class="modal-body" style="padding: 15px 20px;">
                        <div class="row mb-3">
                            <div class="col-sm-12">
                                <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                                    <label style="margin: 0; font-weight: 500; color: #374151; font-size: 11.5px;"><%=MyBase.GetResourceString("C_CustFilter")%>:</label>
                                    <input type="text" id="txtCustomerFilter" class="form-control" style="width: 150px; display: inline-block;" placeholder="Enter letters" />
                                    <button type="button" class="btn borderbtn btn-sm" onclick="ApplyCustomerFilter();"><%=MyBase.GetResourceString("C_Show")%></button>
                                    <button type="button" class="btn borderbtn btn-sm" onclick="ClearCustomerFilter();"><%=MyBase.GetResourceString("C_Clear")%></button>
                                </div>
                            </div>
                        </div>

                        <!-- Customer Table -->
                        <div style="max-height: 400px; overflow-y: auto; border: 1px solid #dee2e6;">
                            <table class="table table-hover" style="margin-bottom: 0;">
                                <thead style="background-color: #e7edf0; position: sticky; top: 0; z-index: 10;">
                                    <tr>
                                        <th style="width: 25%; padding: 12px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1;"><%=MyBase.GetResourceString("C_CustomerID")%></th>
                                        <th style="width: 60%; padding: 12px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1;"><%=MyBase.GetResourceString("C_CustomerName")%></th>
                                        <th style="width: 15%; padding: 12px; text-align: center; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1;"><%=MyBase.GetResourceString("C_Select")%></th>
                                    </tr>
                                </thead>
                                <tbody id="customersTableBody">
                                    <!-- Customers will be loaded dynamically -->
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- Select Customers Modal End -->

        <!-- Select Employees Modal -->
        <div class="modal fade custmodal" id="selectEmployeesModal" tabindex="-1" role="dialog" aria-labelledby="selectEmployeesModalLabel" aria-hidden="true" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document" style="max-width: 900px;">
                <div class="modal-content">
                    <!-- Header (title only) -->
                    <div class="modal-header" style="background-color: #1359a6; color: white; padding: 12px 20px;">
                        <h5 class="modal-title" id="selectEmployeesModalLabel" style="margin: 0; font-weight: 600; font-size: 11.5px;"><%=MyBase.GetResourceString("C_SelectEmployees")%></h5>
                    </div>

                    <!-- Action buttons (below header, above filter) -->
                    <div style="background-color: #f5f5f5; padding: 10px 20px; border-bottom: 1px solid #dee2e6; display: flex; align-items: center; justify-content: flex-end; gap: 10px; flex-wrap: wrap;">
                        <a href="javascript:void(0);" onclick="SetSelectedEmployees();" style="color: #1359a6; text-decoration: underline; font-size: 13px; cursor: pointer;"><%=MyBase.GetResourceString("C_SetEmployees")%></a>
                        <span style="color: #999;">|</span>
                        <a href="javascript:void(0);" id="lnkshowselectedemp" onclick="ShowSelectedEmployees();" style="color: #1359a6; text-decoration: underline; font-size: 13px; cursor: pointer;"><%=MyBase.GetResourceString("C_ShowSelectedEmployees")%></a>
                        <a href="javascript:void(0);" id="lnkShowAllEmp" onclick="ShowAllEmployees(); return false;" style="display: none; color: #1359a6; text-decoration: underline; font-size: 13px; cursor: pointer;"><%=MyBase.GetResourceString("C_ShowAllEmployees")%></a>
                        <span style="color: #999;">|</span>
                        <a href="javascript:void(0);" class="text-decoration-none" data-bs-dismiss="modal" style="color: #1359a6; font-size: 13px; cursor: pointer;" data-bs-toggle="tooltip" title="Close"><%=MyBase.GetResourceString("C_Close")%></a>
                    </div>

                    <!-- Filter Section Of Employee Link-->
                    <div class="modal-body" style="padding: 15px 20px;">
                        <div class="row mb-3">
                            <div class="col-sm-12">
                                <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                                    <label style="margin: 0; font-weight: 500; color: #374151; font-size: 11.5px;"><%=MyBase.GetResourceString("C_CustFilter")%>:</label>
                                    <input type="text" id="txtEmployeeFilter" class="form-control" style="width: 150px; display: inline-block;" placeholder="Enter letters" />
                                    <button type="button" class="btn borderbtn btn-sm" onclick="ApplyEmployeeFilter();"><%=MyBase.GetResourceString("C_Show")%></button>
                                    <button type="button" class="btn borderbtn btn-sm" onclick="ClearEmployeeFilter();"><%=MyBase.GetResourceString("C_Clear")%></button>
                                </div>
                            </div>
                        </div>

                        <!-- Employee Table -->
                        <div style="max-height: 400px; overflow-y: auto; border: 1px solid #dee2e6;">
                            <table class="table table-hover" style="margin-bottom: 0;">
                                <thead style="background-color: #e7edf0; position: sticky; top: 0; z-index: 10;">
                                    <tr>
                                        <th style="width: 25%; padding: 12px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1;"><%=MyBase.GetResourceString("C_EmployeeCode")%></th>
                                        <th style="width: 60%; padding: 12px; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1;"><%=MyBase.GetResourceString("C_EmployeeName")%></th>
                                        <th style="width: 15%; padding: 12px; text-align: center; font-weight: 600; color: #374151; border-bottom: 2px solid #cbd5e1;"><%=MyBase.GetResourceString("C_Select")%></th>
                                    </tr>
                                </thead>
                                <tbody id="employeesTableBody">
                                    <!-- Employees will be loaded dynamically -->
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- Select Employees Modal End -->

        <!-- Start of help off canvas -->
        <div class="offcanvas offcanvas-end"
            tabindex="-1"
            id="offcanvasTrackingHelp"
            aria-labelledby="offcanvasTrackingHelpLabel"
            style="width: 50%; max-width: 650px;">

            <!-- Header -->
            <div class="offcanvas-header"
                style="background-color: #d1d1d1; padding: 0.75rem 1rem;">
                <h6 class="offcanvas-title fw-bold text-dark"
                    id="offcanvasTrackingHelpLabel">
                    <%=MyBase.GetResourceString("C_Tracking")%>
                </h6>
                <button type="button"
                    class="btn-close"
                    data-bs-dismiss="offcanvas"
                    aria-label="Close">
                </button>
            </div>

            <!-- Body -->
            <div class="offcanvas-body" style="padding: 1.5rem;">

                <!-- Section Title -->
                <h4 style="color: #ff7a00; font-weight: 500; margin-bottom: 1rem;">
                    <%=MyBase.GetResourceString("C_TrackingDetails")%>
                </h4>

                <!-- Description -->
                <p style="font-size: 11.5px; color: #374151; line-height: 1.6;">
                    <%=MyBase.GetResourceString("C_HelpNoteone")%> <b><%=MyBase.GetResourceString("C_HelpNotetwo")%></b><%=MyBase.GetResourceString("C_HelpNotethree")%>
                    <i><%=MyBase.GetResourceString("C_HelpNotefour")%></i>. <%=MyBase.GetResourceString("C_HelpNotefive")%>
                </p>

                <!-- Steps -->
                <ol style="font-size: 11.5px; color: #374151; margin-top: 1rem;">
                    <li class="mb-2">
                        <%=MyBase.GetResourceString("C_Helpnotesix")%> <b><%=MyBase.GetResourceString("C_RequestDetails")%></b> <%=MyBase.GetResourceString("C_Helpnoteseven")%>
                        <b><%=MyBase.GetResourceString("C_Helpnoteeight")%></b> <%=MyBase.GetResourceString("C_Helpnotenine")%>
                    </li>
                    <li class="mb-2">On the <b>Tracking Details</b> <%=MyBase.GetResourceString("C_Helpnoteten")%>
                        <b><%=MyBase.GetResourceString("C_Complete")%></b> <%=MyBase.GetResourceString("C_HelpnOteele")%>
                        <b><%=MyBase.GetResourceString("C_ClearFlag")%></b> <%=MyBase.GetResourceString("C_link")%>
                    </li>
                    <li class="mb-2">
                        <%=MyBase.GetResourceString("C_Click")%> <b><%=MyBase.GetResourceString("C_Save")%></b> <%=MyBase.GetResourceString("C_toclearflag")%>
                    </li>
                </ol>

            </div>
        </div>

        <!--End of help off canvas -->

        <!-- Project Selection Offcanvas -->
        <div class="offcanvas offcanvas-end" data-bs-scroll="false" tabindex="-1" id="offcanvasProjectSelection" aria-labelledby="offcanvasProjectSelectionLabel" style="width: 85%; max-width: 1200px;">
            <div class="offcanvas-body">
                <!-- Header -->
                <div class="graybg container-fluid py-1 mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-10">
                            <h5 class="pgtitle mb-0" id="projectSelectionTitle"><%=MyBase.GetResourceString("C_ProjectSelectionTask")%></h5>
                        </div>
                        <div class="col-sm-2 text-end">
                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close" onclick="$('body').removeClass('offcanvas-open');"></button>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="row">
                    <div class="col-sm-12 text-end mb-2" style="white-space: nowrap;">
                        <%If m_blnAddAccess = True Then%>
                        <button type="button" class="btn btnyellow me-2" id="btnSaveProjectSelection" onclick="SaveProjectSelection();">
                            <%=MyBase.GetResourceString("C_Save")%>
                        </button>
                        <%End If%>
                        <%--<button type="button" class="btn borderbtn me-2" data-bs-dismiss="offcanvas">
                            <%=MyBase.GetResourceString("C_Close")%>
                        </button>--%>
                        <%--<button type="button" class="btn borderbtn" onclick="ShowProjectSelectionHelp();">
                         <%=MyBase.GetResourceString("C_Help")%>
                    </button>--%>
                    </div>
                </div>

                <!-- Project Selection Content -->
                <div class="container-fluid" style="padding: 1rem 0;">
                    <div class="row" style="min-height: 400px;">
                        <!-- List of Projects -->
                        <div class="col-md-5">
                            <div style="margin-bottom: 0.5rem;">
                                <label style="font-weight: 600; color: #374151; font-size: 11.5px; margin: 0;"><%=MyBase.GetResourceString("C_ListofProjects")%></label>
                            </div>
                            <select id="lstAvailableProjects" multiple size="15" class="form-control" style="width: 100%; height: 400px; border: 1px solid #ced4da; padding: 8px;">
                                <!-- Projects will be loaded dynamically -->
                            </select>
                        </div>

                        <!-- Control Buttons -->
                        <div class="col-md-2" style="display: flex; flex-direction: column; justify-content: center; align-items: center; gap: 10px; padding-top: 2rem;">
                            <button type="button" class="btn borderbtn btn-sm" onclick="MoveAllToSelected();" style="width: 50px; padding: 6px;" title="Move All">
                                <i class="fas fa-angle-double-right"></i>
                            </button>
                            <button type="button" class="btn borderbtn btn-sm" onclick="MoveToSelected();" style="width: 50px; padding: 6px;" title="Move Selected">
                                <i class="fas fa-angle-right"></i>
                            </button>
                            <button type="button" class="btn borderbtn btn-sm" onclick="MoveToAvailable();" style="width: 50px; padding: 6px;" title="Remove Selected">
                                <i class="fas fa-angle-left"></i>
                            </button>
                            <button type="button" class="btn borderbtn btn-sm" onclick="MoveAllToAvailable();" style="width: 50px; padding: 6px;" title="Remove All">
                                <i class="fas fa-angle-double-left"></i>
                            </button>
                        </div>

                        <!-- Selected Projects -->
                        <div class="col-md-5">
                            <div style="margin-bottom: 0.5rem;">
                                <label style="font-weight: 600; color: #374151; font-size: 11.5px; margin: 0;"><%=MyBase.GetResourceString("C_SelectedProjects")%></label>
                            </div>
                            <select id="lstSelectedProjects" multiple size="15" class="form-control" style="width: 100%; height: 400px; border: 1px solid #ced4da; padding: 8px;">
                                <!-- Selected projects will be loaded dynamically -->
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Project Selection Offcanvas End -->
        </div>
        <!-- /MyAlertsWrapper -->
        <%Else %>
        <div id="ViewAccess" class="tab-pane" style="height: 448px">
            <div style="text-align: center">
                <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess")%></p>
            </div>
        </div>
        <%End If %>
        <!-- ./wrapper -->
        <!-- REQUIRED JS SCRIPTS -->

        <!-- Commented by Madhuri.K On 09-Aug-2024 for JQuery and Bootstrap version upgrade -->
        <%--   <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
        <!-- jqueryUI js -->
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>         
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
        <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>

    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?v=1"></script>--%>

        <script>
            //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
            var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>'
            alertify.set('notifier', 'position', 'top-right');

            var AlertID;
            var ajaxResult = "";
            var EmployeeID = '<%= Session("intUserId") %>';
            var UserName = '<%= Session("strUserName") %>';

            // Loader state (same as PM_ProjectProfitability)
            var loaderShown = false;
            var loaderStartTime = 0;

            // Pagination variables for My Alerts table
            $(document).ready(function () {
                // Initial page load: hide preloader and show main content
                $("#MyAlertsPreloader").hide();
                if ($("#MyAlertsWrapper").length) {
                    $("#MyAlertsWrapper").show();
                }

                // Initialize bootstrap-select for any selectpicker dropdowns (e.g. Duration)
                if ($.fn.selectpicker) {
                    $('.selectpicker').selectpicker();
                }

                // Initialize page - API calls will be added later
                // GetAlertsList();
                GetMyAlerts(0);
                BindDurationDropdown();
                // Handle tab switching
                $('#AlertsTab a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                    // Tab switching is handled by Bootstrap, just ensure data loads
                    var targetId = $(e.target).attr('href');
                    if (targetId === '#alerts-pane') {
                        SwitchTab('alerts');
                        // Show Select Project and Set Alerts, hide Save/Reset
                        $('#selectProjectDiv').show();
                        $('#btnSetAlerts').show();
                        $('#projectAlertsButtons').attr('style', 'display: none !important');
                    } else if (targetId === '#project-alerts-pane') {
                        SwitchTab('project-alerts');
                        // Hide Select Project and Set Alerts, show Save/Reset
                        $('#selectProjectDiv').hide();
                        $('#btnSetAlerts').hide();
                        $('#projectAlertsButtons').attr('style', 'display: flex !important');
                        // Ensure Duration dropdown is properly refreshed when tab is shown
                        setTimeout(function () {
                            if ($("#cboDuration").hasClass('selectpicker')) {
                                $("#cboDuration").selectpicker('refresh');
                            }
                        }, 100);
                    }
                });

                // Initialize project alerts handlers on page load if Project Alerts tab is active
                if ($('#project-alerts-tab').hasClass('active')) {
                    initializeProjectAlertsHandlers();
                    // Hide Select Project and Set Alerts, show Save/Reset
                    $('#selectProjectDiv').hide();
                    $('#btnSetAlerts').hide();
                    $('#projectAlertsButtons').attr('style', 'display: flex !important');
                } else {
                    // Show Select Project and Set Alerts, hide Save/Reset
                    $('#selectProjectDiv').show();
                    $('#btnSetAlerts').show();
                    $('#projectAlertsButtons').attr('style', 'display: none !important');
                }

            });

            function SwitchTab(tabName) {

                if (tabName == 'alerts') {
                    $("#cboDuration").show();
                    $("#durationid").show();
                    // Load alerts data
                    //GetAlertsList();

                } else if (tabName == 'project-alerts') {
                    // Load project alerts configuration
                    //BindDurationDropdown();
                    $("#cboDuration").hide();
                    $("#durationid").hide();
                    GetProjectAlertsList();

                }


            }

            function ProjectonChange() {
                // Handle project selection change
                var selectedProject = $("#cboMyAlertsProject").val();
                // Reload alerts based on selected project
                var activeTab = $('.nav-tabs .nav-link.active').attr('id');
                if (activeTab == 'alerts-tab') {
                    GetAlertsList();
                } else {
                    GetProjectAlertsList();
                }
            }

            function SetAlerts() {

                // Load alert configuration data
                var Parameters = {
                    EmployeeID: EmployeeID
                }
                var param = JSON.stringify(Parameters);
                var Result = AJAXCallWithResult("/api/MyAlerts/GetEmployeeEmail", param, false);
                if (Result && Result.data) {
                    $("#alertEmailAddress").text(Result.data);
                }
                LoadAlertsConfiguration();

                LoadTrackingConfiguration();
                // Show the offcanvas using Bootstrap
                var offcanvasElement = document.getElementById('offcanvasSetAlerts');
                var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
                bsOffcanvas.show();
                $('body').addClass('offcanvas-open');
            }

            function LoadAlertsConfiguration() {
                // TODO: Load alert configuration from API
                // For now, initialize with default values
                // Example API call:
                // var param = JSON.stringify({ UserId: SessionEmployeeId });
                // var response = AJAXCallWithResult("/api/PM_MyAlerts/GetAlertConfiguration", param, false);
                // if (response && response.data) {
                //     // Populate form fields
                // }

                // Initialize checkbox handlers
                initializeAlertCheckboxes();
            }

            function initializeAlertCheckboxes() {
                // Help Request Not Resolved
                //$('#chkHelpRequestNotResolved').on('change', function() {
                //    $('#txtHelpRequestNotResolved').prop('disabled', !$(this).is(':checked'));
                //});
                $('#chkHelpRequestNotResolved').on('change', function () {
                    if ($(this).is(':checked')) {
                        $('#txtHelpRequestNotResolved').prop('disabled', false);
                    } else {
                        $('#txtHelpRequestNotResolved')
                            .val(0)
                            .prop('disabled', true);
                    }
                });


                // Task Due Date Reminder
                //$('#chkTaskDueDateReminder').on('change', function() {
                //    $('#txtTaskDueDateReminder').prop('disabled', !$(this).is(':checked'));
                //});

                //// Review Due Date Reminder
                //$('#chkReviewDueDateReminder').on('change', function() {
                //    $('#txtReviewDueDateReminder').prop('disabled', !$(this).is(':checked'));
                //});

                //// Deliverable Due Date Reminder
                //$('#chkDeliverableDueDateReminder').on('change', function() {
                //    $('#txtDeliverableDueDateReminder').prop('disabled', !$(this).is(':checked'));
                //});

                // Task Due Date Reminder
                $('#chkTaskDueDateReminder').on('change', function () {
                    if ($(this).is(':checked')) {
                        $('#txtTaskDueDateReminder').prop('disabled', false);
                    } else {
                        $('#txtTaskDueDateReminder')
                            .val(0)
                            .prop('disabled', true);
                    }
                });

                // Review Due Date Reminder
                $('#chkReviewDueDateReminder').on('change', function () {
                    if ($(this).is(':checked')) {
                        $('#txtReviewDueDateReminder').prop('disabled', false);
                    } else {
                        $('#txtReviewDueDateReminder')
                            .val(0)
                            .prop('disabled', true);
                    }
                });

                // Deliverable Due Date Reminder
                $('#chkDeliverableDueDateReminder').on('change', function () {
                    if ($(this).is(':checked')) {
                        $('#txtDeliverableDueDateReminder').prop('disabled', false);
                    } else {
                        $('#txtDeliverableDueDateReminder')
                            .val(0)
                            .prop('disabled', true);
                    }
                });

                $('#chkHelpDeskReminder').on('change', function () {
                    if ($(this).is(':checked')) {
                        $('#txtSendMeRembefexpresdt').prop('disabled', false);
                    } else {
                        $('#txtSendMeRembefexpresdt')
                            .val(0)
                            .prop('disabled', true);
                    }
                });

            }

            function SelectCustomersForAlerts() {
                // Load customers data
                LoadCustomersList();

                // Show the modal
                var modal = new bootstrap.Modal(document.getElementById('selectCustomersModal'));
                modal.show();
            }

            function LoadCustomersList() {
                var result = AJAXCallWithResult(
                    "/api/MyAlerts/GetCustomerSelectionList?EmployeeID=" + EmployeeID,
                    null,
                    false
                );

                if (result && result.data && result.data.length > 0) {
                    PopulateCustomersTable(result.data);
                } else {
                    PopulateCustomersTable([]);
                }
            }

            function PopulateCustomersTable(customers) {
                var tbody = $('#customersTableBody');
                tbody.empty();

                if (customers && customers.length > 0) {
                    customers.forEach(function (customer, idx) {
                        var row = $('<tr>');
                        row.append($('<td>').text(customer.CustomerID || customer.customerID || ''));
                        row.append($('<td>').text(customer.CustomerName || customer.customerName || ''));

                        var chkId = 'chkCust_' + idx;
                        var checkboxCell = $('<td>').css('text-align', 'center');
                        var wrap = $('<div>').addClass('custom_chckbox');
                        var checkbox = $('<input>')
                            .attr('type', 'checkbox')
                            .attr('id', chkId)
                            .addClass('customer-checkbox')
                            .attr('data-customer-id', customer.CustomerID || customer.customerID || '')
                            .attr('data-customer-name', customer.CustomerName || customer.customerName || '')
                            .prop('checked', customer.isChecked === 1);
                        wrap.append(checkbox);
                        wrap.append($('<label>').attr('for', chkId));
                        checkboxCell.append(wrap);
                        row.append(checkboxCell);

                        tbody.append(row);
                    });
                } else {
                    tbody.append($('<tr>').append($('<td>').attr('colspan', '3').css('text-align', 'center').css('padding', '20px').text('No customers found.')));
                }
            }

            function FilterCustomersByLetter(letter) {
                // Update active filter state
                $('.alphabet-filter').css('font-weight', 'normal').removeClass('active');
                $('.alphabet-filter').filter(function () {
                    return $(this).text().trim() === letter;
                }).css('font-weight', 'bold').addClass('active');

                // Filter table rows
                if (letter === 'ALL') {
                    $('#customersTableBody tr').show();
                } else {
                    $('#customersTableBody tr').each(function () {
                        var customerId = $(this).find('td:first').text().trim().toUpperCase();
                        if (customerId.indexOf(letter) === 0) {
                            $(this).show();
                        } else {
                            $(this).hide();
                        }
                    });
                }
            }

            //function ApplyCustomerFilter() {
            //    var filterText = $('#txtCustomerFilter').val().trim().toUpperCase();
            //    var visibleCount = 0;
            //    if (filterText) {
            //        // Filter table rows
            //        $('#customersTableBody tr').each(function() {
            //            var customerId = $(this).find('td:first').text().toUpperCase();
            //            var customerName = $(this).find('td:nth-child(2)').text().toUpperCase();

            //            if (customerId.indexOf(filterText) === 0 || customerName.indexOf(filterText) === 0) {
            //                $(this).show();
            //                visibleCount++;
            //            } else {
            //                $(this).hide();
            //            }
            //        });
            //    } else {
            //        $('#customersTableBody tr').show();
            //    }
            //}
            function ApplyCustomerFilter() {
                var filterText = $('#txtCustomerFilter').val().trim().toUpperCase();
                var $tbody = $('#customersTableBody');

                // Remove existing "no records" row if any
                $tbody.find('.no-records-row').remove();

                var visibleCount = 0;

                if (filterText) {
                    $tbody.find('tr').each(function () {
                        var customerId = $(this).find('td:first').text().toUpperCase();
                        var customerName = $(this).find('td:nth-child(2)').text().toUpperCase();

                        if (
                            customerId.indexOf(filterText) === 0 ||
                            customerName.indexOf(filterText) === 0
                        ) {
                            $(this).show();
                            visibleCount++;
                        } else {
                            $(this).hide();
                        }
                    });
                } else {
                    $tbody.find('tr').show();
                    visibleCount = $tbody.find('tr').length;
                }

                // If no visible records, append message row dynamically
                if (visibleCount === 0) {
                    $tbody.append(
                        '<tr class="no-records-row">' +
                        '<td colspan="2" style="text-align:center; color:#6b7280;">' +
                        'There are no items to show in this view.' +
                        '</td>' +
                        '</tr>'
                    );
                }
            }


            function ClearCustomerFilter() {
                $('#txtCustomerFilter').val('');
                $('#customersTableBody tr').show();
                $('.alphabet-filter').css('font-weight', 'normal').removeClass('active');
            }

            function SetSelectedCustomers() {
                //debugger
                var selectedCustomers = [];
                $('.customer-checkbox:checked').each(function () {
                    selectedCustomers.push({
                        CustomerID: $(this).data('customer-id'),
                        CustomerName: $(this).data('customer-name')
                    });
                });

                if (selectedCustomers.length === 0) {
                    alertify.error('Please select at least one customer');
                    return;
                }

                // Build comma-separated list of Customer IDs
                var customerIDs = selectedCustomers.map(function (customer) {
                    return customer.CustomerID;
                }).join(',');

                // Prepare request payload
                var parameter = {
                    EmployeeID: EmployeeID,
                    CustomerID: customerIDs
                };

                var param = JSON.stringify(parameter);
                var response = AJAXCallWithResult("/api/MyAlerts/InsertCustomerFlagForTracking", param, false);

                if (response || response.message || response.message === '1' || response.message === 'Customer flag saved successfully') {
                    var successMessage = '<%=MyBase.GetResourceString("A_CustSave")%>';
                    //if (response.data && response.data.message) {
                    //    successMessage = response.data.message;
                    //}
                    alertify.success(successMessage);

                    // Close modal
                    var modal = bootstrap.Modal.getInstance(document.getElementById('selectCustomersModal'));
                    if (modal) {
                        modal.hide();
                    }
                } else {
                    var errorMessage = '<%=MyBase.GetResourceString("A_Failsavecust")%>';
                    if (response && response.data) {
                        errorMessage = response.data.toString();
                    } else if (response && response.Status === 'FAILURE') {
                        errorMessage = response.data ? response.data.toString() : '<%=MyBase.GetResourceString("A_Failsaveselcust")%>';
                    }
                    alertify.error(errorMessage);
                }
            }

            function ShowSelectedCustomers() {
                var selectedCount = $('.customer-checkbox:checked').length;
                if (selectedCount === 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_NoCustsel")%>');
                    return;
                }

                // Show only selected rows
                $('#customersTableBody tr').each(function () {
                    if ($(this).find('.customer-checkbox').is(':checked')) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });

                // Toggle links
                $('#lnkShowSelected').hide();
                $('#lnkShowAll')
                    //.css('color', '#ffffff')
                    .show();
            }

            function ShowAllCustomers() {
                // Show all rows
                $('#customersTableBody tr').show();

                // Toggle links back
                $('#lnkShowAll').hide();
                $('#lnkShowSelected').show();
            }

            //function ShowCustomersHelp() {
            //    alertify.message('Help: Select customers by checking the boxes. Use the alphabet filter or search field to find specific customers.');
            //}

            function SelectEmployeesForAlerts() {
                // Load employees data
                LoadEmployeesList();

                // Show the modal
                var modal = new bootstrap.Modal(document.getElementById('selectEmployeesModal'));
                modal.show();
            }

            function LoadEmployeesList() {
                // Load employees from API
                var result = AJAXCallWithResult(
                    "/api/MyAlerts/GetEmployeeSelectionList?EmployeeID=" + EmployeeID,
                    null,
                    false
                );

                if (result && result.data && result.data.length > 0) {
                    PopulateEmployeesTable(result.data);
                } else {
                    PopulateEmployeesTable([]);
                }
            }

            function PopulateEmployeesTable(employees) {
                var tbody = $('#employeesTableBody');
                tbody.empty();

                if (employees && employees.length > 0) {
                    employees.forEach(function (employee, idx) {
                        var row = $('<tr>');
                        row.append($('<td>').text(employee.EmployeeCode || employee.employeeCode || ''));
                        row.append($('<td>').text(employee.EmployeeName || employee.employeeName || ''));

                        var chkId = 'chkEmp_' + idx;
                        var checkboxCell = $('<td>').css('text-align', 'center');
                        var wrap = $('<div>').addClass('custom_chckbox');
                        var checkbox = $('<input>')
                            .attr('type', 'checkbox')
                            .attr('id', chkId)
                            .addClass('employee-checkbox')
                            .attr('data-employee-code', employee.EmployeeCode || employee.employeeCode || '')
                            .attr('data-employee-name', employee.EmployeeName || employee.employeeName || '')
                            .prop('checked', employee.isChecked === 1);
                        wrap.append(checkbox);
                        wrap.append($('<label>').attr('for', chkId));
                        checkboxCell.append(wrap);
                        row.append(checkboxCell);

                        tbody.append(row);
                    });
                } else {
                    tbody.append($('<tr>').append($('<td>').attr('colspan', '3').css('text-align', 'center').css('padding', '20px').text('No employees found.')));
                }
            }

            //function ApplyEmployeeFilter() {
            //    var filterText = $('#txtEmployeeFilter').val().trim().toUpperCase();
            //    if (filterText) {
            //        // Filter table rows
            //        $('#employeesTableBody tr').each(function() {
            //            var employeeCode = $(this).find('td:first').text().toUpperCase();
            //            var employeeName = $(this).find('td:nth-child(2)').text().toUpperCase();

            //            if (employeeCode.indexOf(filterText) === 0 || employeeName.indexOf(filterText) === 0) {
            //                $(this).show();
            //            } else {
            //                $(this).hide();
            //            }
            //        });
            //    } else {
            //        $('#employeesTableBody tr').show();
            //    }
            //}

            function ApplyEmployeeFilter() {
                var filterText = $('#txtEmployeeFilter').val().trim().toUpperCase();
                var $tbody = $('#employeesTableBody');

                // Remove existing "no records" row if any
                $tbody.find('.no-records-row').remove();

                var visibleCount = 0;

                if (filterText) {
                    $tbody.find('tr').each(function () {
                        var employeeCode = $(this).find('td:first').text().toUpperCase();
                        var employeeName = $(this).find('td:nth-child(2)').text().toUpperCase();

                        if (
                            employeeCode.indexOf(filterText) === 0 ||
                            employeeName.indexOf(filterText) === 0
                        ) {
                            $(this).show();
                            visibleCount++;
                        } else {
                            $(this).hide();
                        }
                    });
                } else {
                    $tbody.find('tr').show();
                    visibleCount = $tbody.find('tr').length;
                }

                // If no visible records, append message row dynamically
                if (visibleCount === 0) {
                    $tbody.append(
                        '<tr class="no-records-row">' +
                        '<td colspan="2" style="text-align:center; color:#6b7280;">' +
                        'There are no items to show in this view.' +
                        '</td>' +
                        '</tr>'
                    );
                }
            }

            function ClearEmployeeFilter() {
                $('#txtEmployeeFilter').val('');
                $('#employeesTableBody tr').show();
            }

            function SetSelectedEmployees() {
                //debugger
                var selectedEmployees = [];
                $('.employee-checkbox:checked').each(function () {
                    selectedEmployees.push({
                        EmployeeCode: $(this).data('employee-code'),
                        EmployeeName: $(this).data('employee-name')
                    });
                });

                if (selectedEmployees.length === 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_plzselatlstoneemp")%>');
                    return;
                }

                var employeeIDs = selectedEmployees.map(function (emp) {
                    return emp.EmployeeName;
                }).join(',');

                var parameter = {
                    EmployeeID: EmployeeID,
                    EmployeeList: employeeIDs
                };
                // TODO: Save selected employees via API
                // var param = JSON.stringify({ SelectedEmployees: selectedEmployees });
                // var response = AJAXCallWithResult("/api/PM_MyAlerts/SaveSelectedEmployees", param, false);
                var param = JSON.stringify(parameter);
                var response = AJAXCallWithResult("/api/MyAlerts/InsertCustomerFlagForTrackingEmployeeList", param, false);

                if (response.message === 'Customer flag (Employee List) saved successfully') {
                    alertify.success('<%=MyBase.GetResourceString("A_Empsavesuccess")%>');
                }


                // Close modal
                var modal = bootstrap.Modal.getInstance(document.getElementById('selectEmployeesModal'));
                if (modal) {
                    modal.hide();
                }
            }

            function ShowSelectedEmployees() {
                var selectedCount = $('.employee-checkbox:checked').length;
                if (selectedCount === 0) {
                    alertify.error('No employees selected');
                    return;
                }

                // Show only selected rows
                $('#employeesTableBody tr').each(function () {
                    if ($(this).find('.employee-checkbox').is(':checked')) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });

                $('#lnkshowselectedemp').hide();
                $('#lnkShowAllEmp')
                    //.css('color', '#ffffff')
                    .show();
            }

            function ShowAllEmployees() {
                // Show all rows
                $('#employeesTableBody tr').show();
                // Toggle links back
                $('#lnkShowAllEmp').hide();
                $('#lnkshowselectedemp').show();
            }

            //function ShowEmployeesHelp() {
            //    alertify.message('Help: Select employees by checking the boxes. Use the search field to find specific employees.');
            //}

            function SaveAlertsConfiguration() {

                // Validate and collect form data - using field names matching the API parameter structure
                var alertConfig = {
                    EmployeeID: EmployeeID,
                    CustomerFlag: $('#chkHelpRequestEntered').is(':checked') ? 1 : 0,
                    CustomerID: null, // Will be populated from selected customers if needed
                    TaskFlag: $('#chkTaskDueDateReminder').is(':checked') ? 1 : 0,
                    TaskDays: parseInt($('#txtTaskDueDateReminder').val()) || 0,
                    ReviewFlag: $('#chkReviewDueDateReminder').is(':checked') ? 1 : 0,
                    ReviewDays: parseInt($('#txtReviewDueDateReminder').val()) || 0,
                    HelpRequestFlag: $('#chkHelpDeskReminder').is(':checked') ? 1 : 0,
                    HelpRequestDays: parseInt($('#txtSendMeRembefexpresdt').val()) || 0,
                    DeliverableFlag: $('#chkDeliverableDueDateReminder').is(':checked') ? 1 : 0,
                    DeliverableDays: parseInt($('#txtDeliverableDueDateReminder').val()) || 0,
                    HelpRequestAfterFlag: $('#chkHelpRequestNotResolved').is(':checked') ? 1 : 0,
                    HelpRequestAfterDays: parseInt($('#txtHelpRequestNotResolved').val()) || 0
                };

                // Save via API
                var param = JSON.stringify(alertConfig);
                var response = AJAXCallWithResult("/api/MyAlerts/InsertFlagForTrackingConfigure", param, false);

                if (response && (response.message === '1' || response.message === '1')) {
                    // Check if the response contains an INSERT/UPDATE flag
                    // Backend should return: isInserted (boolean), isNewRecord (boolean), or operationType ('INSERT'/'UPDATE')
                    var responseData = response.data || {};
                    var isInserted = false;

                    // Check for various possible flag formats
                    if (responseData.isInserted !== undefined) {
                        isInserted = responseData.isInserted === true || responseData.isInserted === 1;
                    } else if (responseData.isNewRecord !== undefined) {
                        isInserted = responseData.isNewRecord === true || responseData.isNewRecord === 1;
                    } else if (responseData.operationType) {
                        isInserted = responseData.operationType === 'INSERT';
                    } else if (responseData.operation) {
                        // Handle "InsertOrUpdate" - check if we can determine from rowsAffected or other means
                        // For now, default to UPDATE if operation is "InsertOrUpdate" (API should be enhanced to return specific flag)
                        isInserted = responseData.operation === 'INSERT';
                        // If rowsAffected is 1 and operation is InsertOrUpdate, it could be either
                        // The backend should be enhanced to return isInserted flag explicitly
                    }

                    // Show appropriate message based on INSERT or UPDATE
                    if (isInserted) {
                        alertify.success('<%=MyBase.GetResourceString("A_Alertsetsuccess")%>');
                    } else {
                        alertify.success('<%=MyBase.GetResourceString("A_Alertsetsuccess")%>');
                    }

                    if ($('#chkHelpRequestEntered').is(':checked')) {
                        $('#custmerlinkid').show();
                        $('#employeelinkid').show();
                        $('#chkHelpRequestNotResolved').prop('disabled', false);
                    } else {
                        $('#custmerlinkid').hide();
                        $('#employeelinkid').hide();
                        $('#chkHelpRequestNotResolved')
                            .prop('checked', false)
                            .prop('disabled', true);
                        $('#txtHelpRequestNotResolved').prop('disabled', true);
                        $('#txtHelpRequestNotResolved').val('0');


                    }
                    // Close the offcanvas
                    //var offcanvas = bootstrap.Offcanvas.getInstance(document.getElementById('offcanvasSetAlerts'));
                    //if (offcanvas) {
                    //    offcanvas.hide();
                    //}
                    //$('body').removeClass('offcanvas-open');
                } else {
                    var errorMessage = '<%=MyBase.GetResourceString("A_failsavealrtconfig")%>';
                    if (response && response.data) {
                        errorMessage = response.data.toString();
                    } else if (response && response.Status === 'FAILURE') {
                        errorMessage = response.data ? response.data.toString() : '<%=MyBase.GetResourceString("A_failsavealrtconfig")%>';
                    }
                    alertify.error(errorMessage);
                }
            }

            function ShowSetAlertsHelp() {
                /*alertify.message('Help: Configure your alert preferences by selecting the checkboxes and entering the required values.');*/
                var offcanvasElement = document.getElementById('offcanvasTrackingHelp');
                var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
                bsOffcanvas.show();
                $('body').addClass('offcanvas-open');
            }

            //function injectIframeStyles(iframe) {
            //    try {
            //        // Wait a bit for iframe to fully load
            //        setTimeout(function() {
            //            try {
            //                var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
            //                if (!iframeDoc) return;

            //                var iframeHead = iframeDoc.head || iframeDoc.getElementsByTagName('head')[0];
            //                if (!iframeHead) return;

            //                // Check if styles already injected
            //                if (iframeDoc.getElementById('alerts-ui-styles')) {
            //                    return;
            //                }

            //                var style = iframeDoc.createElement('style');
            //                style.id = 'alerts-ui-styles';
            //                style.textContent = getIframeStyles();
            //                iframeHead.appendChild(style);
            //            } catch (e) {
            //                console.log('Could not inject styles into iframe:', e);
            //            }
            //        }, 500);
            //    } catch (e) {
            //        console.log('Error setting up iframe style injection:', e);
            //    }
            //}

            //function getIframeStyles() {
            //    return `
            //        /* Consistent UI Styles for Alerts Configure - Matching Certification Details */
            //        * {
            //            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
            //        }

            //        body {
            //            font-size: 14px !important;
            //            color: #333 !important;
            //            background-color: #fff !important;
            //            padding: 15px 20px !important;
            //            line-height: 1.5 !important;
            //        }

            //        /* Headings - Matching Certification Details title style */
            //        h1, h2, h3, h4, h5, h6,
            //        .clsTRSectionHeader,
            //        .clsTRMenu td:first-child {
            //            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
            //            font-weight: 600 !important;
            //            color: #1359a6 !important;
            //            font-size: 18px !important;
            //            margin-bottom: 15px !important;
            //        }

            //        /* Labels - Standard font size, regular weight */
            //        label,
            //        td label,
            //        .clsTRMenu label,
            //        td {
            //            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
            //            font-size: 13px !important;
            //            font-weight: normal !important;
            //            color: #333 !important;
            //            margin-bottom: 5px !important;
            //        }

            //        /* Required field asterisk */
            //        label.required::after,
            //        .required::after {
            //            content: " *" !important;
            //            color: #dc3545 !important;
            //            font-weight: bold !important;
            //        }

            //        /* Input fields - Matching Certification Details style */
            //        input[type="text"],
            //        input[type="number"],
            //        input[type="email"],
            //        textarea,
            //        select {
            //            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
            //            font-size: 13px !important;
            //            padding: 6px 10px !important;
            //            border: 1px solid #ced4da !important;
            //            border-radius: 4px !important;
            //            color: #333 !important;
            //            background-color: #fff !important;
            //            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out !important;
            //        }

            //        input[type="text"]:focus,
            //        input[type="number"]:focus,
            //        input[type="email"]:focus,
            //        textarea:focus,
            //        select:focus {
            //            outline: none !important;
            //            border-color: #1359a6 !important;
            //            box-shadow: 0 0 0 2px rgba(19, 89, 166, 0.1) !important;
            //        }

            //        /* Placeholder text */
            //        input::placeholder,
            //        textarea::placeholder {
            //            color: #999 !important;
            //            font-size: 13px !important;
            //        }

            //        /* Checkboxes */
            //        input[type="checkbox"] {
            //            width: 16px !important;
            //            height: 16px !important;
            //            margin-right: 8px !important;
            //            cursor: pointer !important;
            //            accent-color: #1359a6 !important;
            //        }

            //        /* Buttons - Matching Certification Details style */
            //        input[type="button"],
            //        input[type="submit"],
            //        button,
            //        .btn,
            //        .button {
            //            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
            //            font-size: 13px !important;
            //            font-weight: 500 !important;
            //            padding: 6px 16px !important;
            //            border-radius: 4px !important;
            //            cursor: pointer !important;
            //            transition: all 0.2s ease-in-out !important;
            //        }

            //        /* Save button - Orange/yellow style matching Certification Details */
            //        input[value="Save"],
            //        input[value*="Save"],
            //        .btn-success,
            //        button:contains("Save") {
            //            background-color: #ffc107 !important;
            //            color: #333 !important;
            //            border: 1px solid #ffc107 !important;
            //            font-weight: 500 !important;
            //        }

            //        input[value="Save"]:hover,
            //        input[value*="Save"]:hover,
            //        .btn-success:hover,
            //        button:contains("Save"):hover {
            //            background-color: #e0a800 !important;
            //            border-color: #e0a800 !important;
            //            color: #333 !important;
            //        }

            //        /* Cancel/Close button - Blue text on white matching Certification Details */
            //        input[value="Cancel"],
            //        input[value="Close"],
            //        input[value*="Cancel"],
            //        input[value*="Close"],
            //        .btn-secondary,
            //        .btn-close,
            //        button:contains("Cancel"),
            //        button:contains("Close") {
            //            background-color: #fff !important;
            //            color: #1359a6 !important;
            //            border: 1px solid #1359a6 !important;
            //            font-weight: 500 !important;
            //        }

            //        input[value="Cancel"]:hover,
            //        input[value="Close"]:hover,
            //        input[value*="Cancel"]:hover,
            //        input[value*="Close"]:hover,
            //        .btn-secondary:hover,
            //        .btn-close:hover,
            //        button:contains("Cancel"):hover,
            //        button:contains("Close"):hover {
            //            background-color: #1359a6 !important;
            //            color: #fff !important;
            //        }

            //        /* Links */
            //        a {
            //            color: #1359a6 !important;
            //            text-decoration: none !important;
            //            font-size: 13px !important;
            //        }

            //        a:hover {
            //            color: #0d3d73 !important;
            //            text-decoration: underline !important;
            //        }

            //        /* Tables */
            //        table {
            //            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
            //            font-size: 13px !important;
            //        }

            //        table td {
            //            padding: 8px 12px !important;
            //            vertical-align: middle !important;
            //        }

            //        /* Spacing */
            //        .clsTRMenu td {
            //            padding: 10px 15px !important;
            //        }

            //        /* Email text and spans */
            //        span,
            //        div {
            //            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
            //            font-size: 13px !important;
            //            color: #333 !important;
            //        }

            //        /* Bold text in labels - matching Certification Details */
            //        b,
            //        strong {
            //            font-weight: 600 !important;
            //            color: #1359a6 !important;
            //        }

            //        /* Mandatory note text */
            //        .mandatory-note,
            //        span:contains("Mandatory") {
            //            font-size: 12px !important;
            //            color: #6c757d !important;
            //            font-weight: normal !important;
            //        }

            //        /* Hide Save button in iframe - using parent's save button instead */
            //        input[type="button"][value*="Save"],
            //        input[type="submit"][value*="Save"],
            //        input[value="Save"],
            //        input[value="Save & Add"],
            //        button[onclick*="Save"],
            //        .btn-success,
            //        .btnyellow {
            //            display: none !important;
            //        }

            //        /* Show only Cancel/Close buttons in iframe */
            //        input[value="Cancel"],
            //        input[value="Close"],
            //        .btn-secondary,
            //        .borderbtn {
            //            display: inline-block !important;
            //        }
            //    `;
            //}

            //function updateIframeHeight() {
            //    var iframe = document.getElementById('alertsConfigureFrame');
            //    if (iframe) {
            //        // Set iframe height based on viewport minus header, buttons, and mandatory label
            //        var headerHeight = 120; // Header + buttons + mandatory label height
            //        iframe.style.height = (window.innerHeight - headerHeight) + 'px';
            //    }
            //}

            // Handle window resize for iframe
            $(window).on('resize', function () {
                if ($('#offcanvasSetAlerts').hasClass('show')) {
                    updateIframeHeight();
                }
            });

            // Clean up when offcanvas is hidden
            $('#offcanvasSetAlerts').on('hidden.bs.offcanvas', function () {
                $('body').removeClass('offcanvas-open');
                var iframe = document.getElementById('alertsConfigureFrame');
                if (iframe) {
                    // Optionally clear iframe src to prevent memory leaks
                    // iframe.src = '';
                }
            });

            // Clean up when alert offcanvas is hidden
            $('#offcanvas_my_alerts').on('hidden.bs.offcanvas', function () {
                $('body').removeClass('offcanvas-open');
            });

            // Clean up when Request Details offcanvas is hidden
            $('#offcanvasRequestDetails').on('hidden.bs.offcanvas', function () {
                $('body').removeClass('offcanvas-open');
            });

            function SaveAlertsFromIframe() {
                // Trigger save in the iframe
                try {
                    var iframe = document.getElementById('alertsConfigureFrame');
                    var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
                    var iframeWindow = iframe.contentWindow;

                    // Look for save button or form submit in iframe
                    if (iframeWindow && typeof iframeWindow.SaveDetails === 'function') {
                        iframeWindow.SaveDetails();
                    } else {
                        // Try to find and click save button
                        var saveBtn = iframeDoc.querySelector('input[value*="Save"], button:contains("Save"), .btn-success');
                        if (saveBtn) {
                            saveBtn.click();
                        }
                    }
                } catch (e) {
                    console.log('Could not trigger save in iframe:', e);
                    alertify.message('<%=MyBase.GetResourceString("C_plzusesavebutonform")%>');
                }
            }

            //function ShowFilters() {
            //    // Show filter panel/modal
            //    alertify.message("Filter functionality will be implemented");
            //}

            function showLoader() {
                var el = document.getElementById('loaderOverlay');
                if (el) {
                    el.style.display = 'block';
                    loaderShown = true;
                    loaderStartTime = Date.now();
                }
            }
            function hideLoader() {
                if (!loaderShown) return;
                var elapsedTime = Date.now() - loaderStartTime;
                var minDisplayTime = 1500;
                var el = document.getElementById('loaderOverlay');
                if (!el) return;
                if (elapsedTime < minDisplayTime) {
                    setTimeout(function () {
                        el.style.display = 'none';
                        loaderShown = false;
                    }, minDisplayTime - elapsedTime);
                } else {
                    el.style.display = 'none';
                    loaderShown = false;
                }
            }

            function GetProjectAlertsList() {

                //BindDurationDropdown();
                // Load project alerts configuration
                showLoader();

                // Call API to get alert entity details
                var result = AJAXCallWithResult(
                    "/api/MyAlerts/GetAlertEntityDetails?EmployeeID=" + EmployeeID,
                    null,
                    false
                );

                if (result && result.data) {
                    RenderProjectAlerts(result.data);
                } else {
                    $("#ProjectAlertsTblBody").html('<tr><td colspan="4" style="text-align:center !important; padding: 30px;">There are no items to show in this view.</td></tr>');
                }

                hideLoader();
            }

            function RenderProjectAlerts(alerts) {
                //debugger
                var $tbody = $("#ProjectAlertsTblBody");
                $tbody.empty();
                var issueTypeDropdownRendered = false;
                var isInIssueSection = false;
                var issueTypeControllerChkId = null; // second Issue checkbox
                if (!alerts || alerts.length === 0) {
                    $tbody.html('<tr><td colspan="4" style="text-align:center !important; padding: 30px;">There are no items to show in this view.</td></tr>');
                    return;
                }

                var currentEntity = "";

                $.each(alerts, function (i, item) {
                    // Section Header (Task / Milestone / Deliverable / Module / Issue / Change Request)
                    if (currentEntity !== item.entityName) {
                        currentEntity = item.entityName;
                        isInIssueSection = (currentEntity.toLowerCase() === "issue");
                        if (currentEntity.toLowerCase() !== "task") {
                            $tbody.append(`
                        <tr class="section-header">
                            <td style="padding-left: 12px;">
                                ${currentEntity}
                            </td>
                            <td style="text-align: center;">
                                <a href="javascript:void(0);" onclick="SelectProjectForAlerts('${currentEntity}'); return false;" style="color: #1359a6; text-decoration: underline; cursor: pointer;">Project Selection</a>
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                    `);
                        }
                    }

                    // Split description & unit (entityDetialDescription contains "label | unit")
                    var description = item.entityDetialDescription || item.entityDetailDescription || '';
                    var parts = description.split('|');
                    var labelText = parts[0].trim();
                    var unit = parts.length > 1 ? parts[1].trim() : '';

                    var checked = item.isSelected ? "checked" : "";
                    var disabled = item.isSelected ? "" : "disabled";

                    // Frequency Mapping (D=Daily, W=Weekly, M=Monthly)
                    var freq = item.frequency || "";
                    var freqOptions = `
                    <option value="">Select Frequency</option>
                    <option value="D" ${freq === 'D' ? 'selected' : ''}>Daily</option>
                    <option value="W" ${freq === 'W' ? 'selected' : ''}>Weekly</option>
                    <option value="M" ${freq === 'M' ? 'selected' : ''}>Monthly</option>
                `;

                    // Generate unique IDs for each row
                    var rowId = 'row_' + item.alertEntityDetailID;
                    var chkId = 'chk_' + item.alertEntityDetailID;
                    var txtId = 'txt_' + item.alertEntityDetailID;
                    var freqId = 'freq_' + item.alertEntityDetailID;
                    var mailId = 'mail_' + item.alertEntityDetailID;

                    $tbody.append(`
                    <tr class="alert-row" data-entity-detail-id="${item.alertEntityDetailID}" data-entity-id="${item.alertEntityID}">
                        <td style="padding: 10px 2px 10px 8px; vertical-align: middle; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; border-right: none;">
                            <div style="display: flex; align-items: center; gap: 4px; white-space: nowrap;">
                                <div class="custom_chckbox">
                                    <input type="checkbox" id="${chkId}" name="${chkId}" class="alert-checkbox" ${checked} />
                                    <label for="${chkId}"></label>
                                </div>
                                <label for="${chkId}" style="margin: 0; font-weight: 500; color: #374151; cursor: pointer; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                    ${labelText}
                                </label>
                                <input type="text" id="${txtId}" name="${txtId}" class="alert-duration form-control" style="width: 70px; text-align: right; flex-shrink: 0; margin-left: 4px;" maxlength="5" value="${disabled ? 0 : (item.duration || '')}" ${disabled} oninput="allowThreeDigitPositiveNumberOnly(this)"/>
                                <span style="color: #6b7280; white-space: nowrap; font-size: 13px; margin-left: 4px;">${unit}</span>
                            </div>
                        </td>
                        <td style="padding: 10px 8px 10px 2px; vertical-align: middle; border-left: none; border-right: none;">
                        </td>
                        <td style="padding: 10px 8px; text-align: center; vertical-align: middle; border-left: none; border-right: none;">
                            <select id="${freqId}" name="${freqId}" class="alert-frequency form-control form-select" style="width: 100%; max-width: 180px; margin: 0 auto;" ${disabled}>
                                ${freqOptions}
                            </select>
                        </td>
                        <td style="padding: 10px 8px; text-align: center; vertical-align: middle; border-left: none;">
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <div class="custom_chckbox">
                                    <input type="checkbox" id="${mailId}" name="${mailId}" class="alert-sendmail" ${item.sendMail ? 'checked' : ''} ${disabled} />
                                    <label for="${mailId}"></label>
                                </div>
                            </div>
                        </td>
                    </tr>
                `);

                    //if (labelText == 'The Task has exceeded  its baseline efforts by more than') {
                    if (item.alertEntityDetailID == 3) {
                        $tbody.append(`
                <div style="
                    margin-top: 4px;
                    font-size: 11.5px;
                    color: #6b7280;
                    font-weight: normal;
                ">
                    [Note: Issue tasks and Review Tasks not displayed for Exceeded baseline efforts alert.]
                </div>
            `);
                    }


                    // If Issue section just ended, append Issue Type dropdowns
                    var nextItem = alerts[i + 1];

                    if (
                        isInIssueSection &&
                        !issueTypeDropdownRendered &&
                        (!nextItem || nextItem.entityName.toLowerCase() !== "issue")
                    ) {
                        issueTypeDropdownRendered = true;
                        if (!issueTypeControllerChkId) {
                            issueTypeControllerChkId = chkId;
                        }
                        //                for (var j = 1; j <= 3; j++) {
                        //                    $tbody.append(`
                        //    <tr class="alert-row issue-extra-row">
                        //        <td></td>
                        //        <td></td>
                        //        <td style="text-align:center;">
                        //            <select class="form-control form-select"
                        //                    style="max-width:180px;margin:0 auto;">
                        //                <option value="Defect">Defect</option>
                        //            </select>
                        //        </td>
                        //        <td></td>
                        //    </tr>
                        //`);
                        //                }
                        
                        var otheralertConfig = {
                            AlertEntityDetailsID: item.alertEntityDetailID,
                            EmployeeID: EmployeeID
                        };

                        // Save via API
                        var param = JSON.stringify(otheralertConfig);
                        var response = AJAXCallWithResult("/api/MyAlerts/GetAlertOtherAttributes", param, false);
                       
                        for (var j = 1; j <= 1; j++) {
                            $tbody.append(`
                                    <tr class="alert-row issue-extra-row">
                                        <td></td>
                                        <td></td>
                                        <td style="text-align:center;">
                                            <select
                                                id="issueType_${j}"
                                                class="form-control form-select issue-type-dropdown"
                                                data-issue-type="${j}"
                                                disabled
                                                style="max-width:180px;margin:0 auto;">
                    
                                                <option value="0" selected>Select Issue Type</option>
                                                <option value="Defect">Defect</option>
                                            </select>
                                        </td>
                                        <td></td>
                                    </tr>
                                `);
                        }
                        
                        if (response && response.data && response.data.length > 0) {
                            var otherType = response.data[0].otherType;

                            if (otherType && otherType !== "0") {
                                $("#issueType_1").val(otherType);
                            } else {
                                $("#issueType_1").val("0");
                            }
                        }


                    }



                });

                // Initialize checkbox handlers for dynamically created rows
                initializeDynamicAlertHandlers();

                $('.alert-checkbox:checked').each(function () {
                    var $row = $(this).closest('tr.alert-row');

                    $row.next('.issue-extra-row')
                        .find('.issue-type-dropdown')
                        .prop('disabled', false);
                });

            }

            function initializeDynamicAlertHandlers() {
                // Handle checkbox change for dynamically created rows
                $('.alert-checkbox').off('change').on('change', function () {
                    var $row = $(this).closest('tr.alert-row');
                    var isChecked = $(this).is(':checked');

                    $row.find('.alert-duration').prop('disabled', !isChecked);
                    $row.find('.alert-frequency').prop('disabled', !isChecked);
                    $row.find('.alert-sendmail').prop('disabled', !isChecked);

                    var $issueDropdown = $row.next('.issue-extra-row')
                        .find('.issue-type-dropdown');

                    $issueDropdown.prop('disabled', !isChecked);

                    if (!isChecked) {
                        $issueDropdown.val('0');
                    }

                    if (!isChecked) {
                        $row.find('.alert-duration').val('0');
                        $row.find('.alert-frequency').val('');
                        $row.find('.alert-sendmail').prop('checked', false);
                        $('.issue-type-dropdown')
                            .prop('disabled', true)
                            .val('0');
                    }
                    else {
                        $('.issue-type-dropdown').prop('disabled', false);
                    }
                });
            }

            function buildIssueTypeOptions(issueTypes) {
                var options = `<option value="0">Select Issue Type</option>`;

                issueTypes.forEach(function (t) {
                    options += `<option value="${t.OtherType}" selected>${t.OtherType}</option>`;
                });

                return options;
            }


            function initializeProjectAlertsHandlers() {
                // Helper function to setup alert handlers
                function setupAlertHandler(chkId, txtId, freqId, mailId) {
                    $('#' + chkId).off('change').on('change', function () {
                        var isChecked = $(this).is(':checked');
                        $('#' + txtId).prop('disabled', !isChecked);
                        $('#' + freqId).prop('disabled', !isChecked);
                        $('#' + mailId).prop('disabled', !isChecked);
                        if (!isChecked) {
                            $('#' + txtId).val('');
                            $('#' + freqId).val('');
                            $('#' + mailId).prop('checked', false);
                        }
                    });
                }

                // Task Alerts
                setupAlertHandler('chkOverdueTasks', 'txtOverdueTasks', 'cboFrequencyOverdue', 'chkSendMailOverdue');
                setupAlertHandler('chkDelayedTask', 'txtDelayedTask', 'cboFrequencyDelayed', 'chkSendMailDelayed');
                setupAlertHandler('chkTaskExceededEfforts', 'txtTaskExceededEfforts', 'cboFrequencyTaskExceededEfforts', 'chkSendMailTaskExceededEfforts');

                // Milestone Alerts
                setupAlertHandler('chkMilestoneDelayed', 'txtMilestoneDelayed', 'cboFrequencyMilestoneDelayed', 'chkSendMailMilestoneDelayed');
                setupAlertHandler('chkMilestoneDueIn', 'txtMilestoneDueIn', 'cboFrequencyMilestoneDueIn', 'chkSendMailMilestoneDueIn');
                setupAlertHandler('chkMilestoneDelayedBaseline', 'txtMilestoneDelayedBaseline', 'cboFrequencyMilestoneDelayedBaseline', 'chkSendMailMilestoneDelayedBaseline');
                setupAlertHandler('chkMilestoneExceededEfforts', 'txtMilestoneExceededEfforts', 'cboFrequencyMilestoneExceededEfforts', 'chkSendMailMilestoneExceededEfforts');

                // Deliverable Alerts
                setupAlertHandler('chkDeliverableDelayed', 'txtDeliverableDelayed', 'cboFrequencyDeliverableDelayed', 'chkSendMailDeliverableDelayed');
                setupAlertHandler('chkDeliverableDueIn', 'txtDeliverableDueIn', 'cboFrequencyDeliverableDueIn', 'chkSendMailDeliverableDueIn');
                setupAlertHandler('chkDeliverableDelayedBaseline', 'txtDeliverableDelayedBaseline', 'cboFrequencyDeliverableDelayedBaseline', 'chkSendMailDeliverableDelayedBaseline');
                setupAlertHandler('chkDeliverableExceededEfforts', 'txtDeliverableExceededEfforts', 'cboFrequencyDeliverableExceededEfforts', 'chkSendMailDeliverableExceededEfforts');

                // Module Alerts
                setupAlertHandler('chkModuleDelayed', 'txtModuleDelayed', 'cboFrequencyModuleDelayed', 'chkSendMailModuleDelayed');
                setupAlertHandler('chkModuleDueIn', 'txtModuleDueIn', 'cboFrequencyModuleDueIn', 'chkSendMailModuleDueIn');
                setupAlertHandler('chkModuleDelayedBaseline', 'txtModuleDelayedBaseline', 'cboFrequencyModuleDelayedBaseline', 'chkSendMailModuleDelayedBaseline');
                setupAlertHandler('chkModuleExceededEfforts', 'txtModuleExceededEfforts', 'cboFrequencyModuleExceededEfforts', 'chkSendMailModuleExceededEfforts');

                // Issue Alerts
                setupAlertHandler('chkIssueDelayed', 'txtIssueDelayed', 'cboFrequencyIssueDelayed', 'chkSendMailIssueDelayed');
                setupAlertHandler('chkIssueDueIn', 'txtIssueDueIn', 'cboFrequencyIssueDueIn', 'chkSendMailIssueDueIn');

                // Change Request Alerts
                setupAlertHandler('chkChangeRequestDelayed', 'txtChangeRequestDelayed', 'cboFrequencyChangeRequestDelayed', 'chkSendMailChangeRequestDelayed');
                setupAlertHandler('chkChangeRequestDueIn', 'txtChangeRequestDueIn', 'cboFrequencyChangeRequestDueIn', 'chkSendMailChangeRequestDueIn');
            }

            function SaveProjectAlerts() {
                var isValid = true;
                var alertData = [];

                // Collect data from dynamically rendered alert rows
                $('#ProjectAlertsTblBody tr.alert-row').each(function () {
                    var $row = $(this);
                    var $checkbox = $row.find('.alert-checkbox');

                    // Only process checked alerts
                    if ($checkbox.is(':checked')) {
                        var alertEntityDetailID = $row.data('entity-detail-id');
                        var alertEntityID = $row.data('entity-id');
                        var duration = $row.find('.alert-duration').val().trim();
                        var frequency = $row.find('.alert-frequency').val();
                        var sendMail = $row.find('.alert-sendmail').is(':checked') ? 1 : 0;

                        // Validate duration
                        if (duration === '') {
                            alertify.error('<%=MyBase.GetResourceString("A_plzentervalforalrt")%>');
                            $row.find('.alert-duration').focus();
                            isValid = false;
                            return false;
                        }

                        // Validate duration is a valid number
                        if (isNaN(duration) || parseFloat(duration) < 0) {
                            alertify.error('<%=MyBase.GetResourceString("A_plzentrposval")%>');
                            $row.find('.alert-duration').focus();
                            isValid = false;
                            return false;
                        }

                        // Validate frequency
                        if (frequency === '' || frequency === null) {
                            alertify.error('<%=MyBase.GetResourceString("A_plzentrfreq")%>');
                            $row.find('.alert-frequency').focus();
                            isValid = false;
                            return false;
                        }

                        alertData.push({
                            AlertEntityDetailID: alertEntityDetailID,
                            AlertEntityID: alertEntityID,
                            Duration: parseFloat(duration),
                            Frequency: frequency,
                            SendMail: sendMail
                        });
                    }
                });

                if (!isValid) {
                    return;
                }

                //if (alertData.length === 0) {
                //    alertify.error('Please select at least one alert to configure');
                //    return;
                //}

                // Build comma-separated strings for API call
                var entityDetailIDs = [];
                var entityDetailValues = [];
                var frequencies = [];
                var alertEntityIDs = [];
                var sendEmailIDs = [];

                var issueType1 = null;
                var issueType2 = null;
                var issueType3 = null;

                $('.issue-type-dropdown').each(function () {
                    var typeIndex = $(this).data('issue-type');
                    var value = $(this).val();

                    if (value && value !== '') {
                        if (typeIndex === 1) issueType1 = value;
                        if (typeIndex === 2) issueType2 = value;
                        if (typeIndex === 3) issueType3 = value;
                    }
                });


                alertData.forEach(function (item) {
                    // Convert all values to strings for comma-separated format
                    // Values are already validated above, so they should be valid
                    entityDetailIDs.push(String(item.AlertEntityDetailID));
                    entityDetailValues.push(String(item.Duration));
                    frequencies.push(String(item.Frequency));
                    alertEntityIDs.push(String(item.AlertEntityID));
                    // For SendEmailIDs, use entityDetailID if SendMail is checked, otherwise use '0' to align with count
                    if (item.SendMail === 1) {
                        sendEmailIDs.push(String(item.AlertEntityDetailID));
                    } else {
                        sendEmailIDs.push('0');
                    }
                });

                // Build parameter for API call
                // All CSV parameters must end with trailing comma, and non-applicable values should use '0' to match count
                var alertCount = alertData.length;
                var parameter = {
                    EmployeeID: EmployeeID,
                    EmployeeAlertID: 0, // 0 for new records
                    EntityDetailIDs: alertCount > 0 ? entityDetailIDs.join(',') + ',' : '',
                    EntityDetailValues: alertCount > 0 ? entityDetailValues.join(',') + ',' : '',
                    Frequency: alertCount > 0 ? frequencies.join(',') + ',' : '',
                    AlertEntityIDs: alertCount > 0 ? alertEntityIDs.join(',') + ',' : '',
                    SendEmailIDs: alertCount > 0 ? sendEmailIDs.join(',') + ',' : '',
                    SendSMSIDs: alertCount > 0 ? Array(alertCount).fill('0').join(',') + ',' : '', // Default to zeros matching alert count
                    IssueType1: issueType1,
                    IssueType2: issueType2,
                    IssueType3: issueType3
                };

                var param = JSON.stringify(parameter);
                var response = AJAXCallWithResult("/api/MyAlerts/InsertEmployeeAlertDetails", param, false);

                if (response && response.message && response.message === '1') {
                    alertify.success('<%=MyBase.GetResourceString("A_prjtalrtssavesuccess")%>');
            } else {
                var errorMessage = '<%=MyBase.GetResourceString("A_faldtosavealrts")%>';
                if (response && response.data) {
                    errorMessage = response.data.toString();
                } else if (response && response.Status === 'FAILURE') {
                    errorMessage = response.data ? response.data.toString() : '<%=MyBase.GetResourceString("A_faldtosavealrts")%>';
                    }
                    alertify.error(errorMessage);
                }
            }

            var currentSectionType = '';

            function SelectProjectForAlerts(sectionType) {
                //debugger
                // Store the current section type
                currentSectionType = sectionType || '';

                // Update the title
                $('#projectSelectionTitle').text('Project Selection - ' + sectionType);

                // Load available projects
                LoadAvailableProjects();

                // Load selected projects for this section
                LoadSelectedProjects(sectionType);

                // Show the offcanvas
                var offcanvasElement = document.getElementById('offcanvasProjectSelection');
                var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
                bsOffcanvas.show();
                $('body').addClass('offcanvas-open');
            }
            var intcurrentSectionType = '';
            function LoadAvailableProjects() {
                //debugger
                var $availableList = $('#lstAvailableProjects');
                var $selectedList = $('#lstSelectedProjects');
                $availableList.empty();
                $selectedList.empty();
                // Get list of already selected project IDs to prevent duplicates
                //var selectedProjectIds = [];
                //$selectedList.find('option').each(function() {
                //    selectedProjectIds.push($(this).val());
                //});

                if (currentSectionType === 'Task') {
                    intcurrentSectionType = "1";
                }

                if (currentSectionType === 'Milestone') {
                    intcurrentSectionType = "2";
                }

                if (currentSectionType === 'Deliverable') {
                    intcurrentSectionType = "3";
                }

                if (currentSectionType === 'Module') {
                    intcurrentSectionType = "4";
                }

                if (currentSectionType === 'Issue') {
                    intcurrentSectionType = "5";
                }

                if (currentSectionType === 'Change Request') {
                    intcurrentSectionType = "6";
                }

                // Determine which API to call based on section type
                if (currentSectionType === 'Task') {
                    // Get AlertEntityID for Task section from the first row
                    var alertEntityID = null;
                    $('#ProjectAlertsTblBody tr.section-header').each(function () {
                        var $header = $(this);
                        var sectionText = $header.find('td:first').text().trim();
                        if (sectionText === currentSectionType) {
                            var $firstRow = $header.next('tr.alert-row');
                            if ($firstRow.length > 0) {
                                alertEntityID = $firstRow.data('entity-id');
                            }
                            return false; // Break the loop
                        }
                    });

                    // Build parameter object for GetAccessibleProjectsForProjectAlerts
                    var parameter = {
                        UserID: EmployeeID,
                        FromDA: false,
                        ShowGlobalProject: false,
                        OnlyProjectID: null,
                        FromIssueBase: false,
                        LoginType: '<%= Session("LoginType") %>' || 'E',
                        ShowReleasedProject: false,
                        LoginID: parseInt(EmployeeID),
                        CheckTaskStatus: 0,
                        ShowInactiveProjects: false,
                        EntryDate: null,
                        AlertEntityID: intcurrentSectionType || 0
                    };

                    var param = JSON.stringify(parameter);
                    var result = AJAXCallWithResult(
                        "/api/MyAlerts/GetAccessibleProjectsForProjectAlerts",
                        param,
                        false
                    );

                    if (result && result.data && result.data.length > 0) {
                        result.data.forEach(function (project) {
                            var projectId = project.ProjectId || project.projectID || '';
                            var projectName = project.ProjectName || project.projectName || '';
                            // Only add if not already in selected list
                            //if (projectId && projectName && selectedProjectIds.indexOf(projectId) === -1) {
                            //    $availableList.append('<option value="' + projectId + '">' + projectName + '</option>');
                            //}
                            $availableList.append('<option value="' + projectId + '">' + projectName + '</option>');
                        });
                    }
                } else if (currentSectionType) {
                    // For other sections, get AlertEntityID from the first row of the section
                    var alertEntityID = null;

                    // Find the section header and get the first alert row's entity ID
                    $('#ProjectAlertsTblBody tr.section-header').each(function () {
                        var $header = $(this);
                        var sectionText = $header.find('td:first').text().trim();
                        if (sectionText === currentSectionType) {
                            // Find the first alert row after this header
                            var $firstRow = $header.next('tr.alert-row');
                            if ($firstRow.length > 0) {
                                alertEntityID = $firstRow.data('entity-id');
                            }
                            return false; // Break the loop
                        }
                    });

                    if (alertEntityID) {
                        // Call GetAlertWiseProjects for other sections
                        //var result = AJAXCallWithResult(
                        //    "/api/MyAlerts/GetAlertWiseProjects?AlertEntityID=" + intcurrentSectionType + "&UserID=" + EmployeeID,
                        //    null,
                        //    false
                        //);
                        var parameter = {
                            UserID: EmployeeID,
                            FromDA: false,
                            ShowGlobalProject: false,
                            OnlyProjectID: null,
                            FromIssueBase: false,
                            LoginType: '<%= Session("LoginType") %>' || 'E',
                            ShowReleasedProject: false,
                            LoginID: parseInt(EmployeeID),
                            CheckTaskStatus: 0,
                            ShowInactiveProjects: false,
                            EntryDate: null,
                            AlertEntityID: alertEntityID || 0
                        };

                        var param = JSON.stringify(parameter);
                        var result = AJAXCallWithResult(
                            "/api/MyAlerts/GetAccessibleProjectsForProjectAlerts",
                            param,
                            false
                        );
                        if (result && result.data && result.data.length > 0) {
                            result.data.forEach(function (project) {
                                var projectId = project.ProjectId || project.projectID || '';
                                var projectName = project.ProjectName || project.projectName || '';
                                // Only add if not already in selected list
                                //if (projectId && projectName && selectedProjectIds.indexOf(projectId) === -1) {
                                //    $availableList.append('<option value="' + projectId + '">' + projectName + '</option>');
                                //}
                                $availableList.append('<option value="' + projectId + '">' + projectName + '</option>');
                            });
                        }
                    }
                }

                var result1 = AJAXCallWithResult(
                    "/api/MyAlerts/GetAlertWiseProjects?AlertEntityID=" + intcurrentSectionType + "&UserID=" + EmployeeID,
                    null,
                    false
                );

                if (result1 && result1.data && result1.data.length > 0) {
                    result1.data.forEach(function (project) {
                        var selectedprojectId = project.ProjectId || project.projectId || '';
                        var selectedprojectName = project.ProjectName || project.projectName || '';
                        $selectedList.append('<option value="' + selectedprojectId + '">' + selectedprojectName + '</option>');
                    });
                }
                console.log('Options count:', $selectedList.find('option').length);
            }

            function LoadSelectedProjects(sectionType) {
                // TODO: Load selected projects for the specific section from API
                var $selectedList = $('#lstSelectedProjects');
                //$selectedList.empty();

                // Sample - replace with actual API call
                // var selectedProjects = AJAXCallWithResult("/api/PM_MyAlerts/GetSelectedProjects?SectionType=" + sectionType, paramater, false);

                // Example structure:
                // selectedProjects.forEach(function(project) {
                //     $selectedList.append('<option value="' + project.ProjectID + '">' + project.ProjectName + '</option>');
                // });
            }

            function MoveToSelected() {
                //debugger
                var $available = $('#lstAvailableProjects');
                var $selected = $('#lstSelectedProjects');

                $available.find('option:selected').each(function () {
                    var $option = $(this);
                    var optionValue = $option.val();
                    // Check if option with same value already exists in selected list
                    //if ($selected.find('option[value="' + optionValue + '"]').length === 0) {
                    //    $option.appendTo($selected);
                    //}
                    $option.appendTo($selected);
                });
            }

            function MoveAllToSelected() {
                var $available = $('#lstAvailableProjects');
                var $selected = $('#lstSelectedProjects');

                $available.find('option').each(function () {
                    var $option = $(this);
                    var optionValue = $option.val();
                    // Check if option with same value already exists in selected list
                    //if ($selected.find('option[value="' + optionValue + '"]').length === 0) {
                    //    $option.appendTo($selected);
                    //}
                    $option.appendTo($selected);
                });
            }

            function MoveToAvailable() {
                var $available = $('#lstAvailableProjects');
                var $selected = $('#lstSelectedProjects');

                $selected.find('option:selected').each(function () {
                    var $option = $(this);
                    var optionValue = $option.val();
                    // Check if option with same value already exists in available list
                    //if ($available.find('option[value="' + optionValue + '"]').length === 0) {
                    //    $option.appendTo($available);
                    //}
                    $option.appendTo($available);
                });
            }

            function MoveAllToAvailable() {
                var $available = $('#lstAvailableProjects');
                var $selected = $('#lstSelectedProjects');

                $selected.find('option').each(function () {
                    var $option = $(this);
                    var optionValue = $option.val();
                    // Check if option with same value already exists in available list
                    //if ($available.find('option[value="' + optionValue + '"]').length === 0) {
                    //    $option.appendTo($available);
                    //}
                    $option.appendTo($available);
                });
            }

            //function SaveProjectSelection() {
            //    var selectedProjects = [];
            //    $('#lstSelectedProjects option').each(function() {
            //        selectedProjects.push({
            //            ProjectID: $(this).val(),
            //            ProjectName: $(this).text()
            //        });
            //    });

            //    if (selectedProjects.length === 0) {
            //        alertify.warning('Please select at least one project');
            //        return;
            //    }

            //    // TODO: Save selected projects via API
            //    // var AlertParameters = {
            //    //     SectionType: currentSectionType,
            //    //     SelectedProjects: JSON.stringify(selectedProjects)
            //    // }
            //    // var paramater = JSON.stringify(AlertParameters);
            //    // var strResult = AJAXCallWithResult("/api/PM_MyAlerts/SaveProjectSelection", paramater, false);
            //    // alertify.success(strResult);

            //    alertify.success('Project selection saved successfully for ' + currentSectionType);

            //    // Close offcanvas
            //    var offcanvasElement = document.getElementById('offcanvasProjectSelection');
            //    var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
            //    if (bsOffcanvas) {
            //        bsOffcanvas.hide();
            //    }
            //    $('body').removeClass('offcanvas-open');
            //}

            function SaveProjectSelection() {
                //debugger
                var selectedProjectIds1 = [];
                $('#lstSelectedProjects option').each(function () {
                    selectedProjectIds1.push($(this).val());
                });

                if (selectedProjectIds1.length === 0) {
                    alertify.error('Please select at least one project');
                    return;
                }

                var request = {
                    //EmployeeAlertID: null,   // set this from page context
                    ProjectIDs: selectedProjectIds1.join(','), // "1,2,3"
                    AlertEntityID: intcurrentSectionType,         // e.g. "TASK"
                    UserID: EmployeeID                     // employee/user id
                };

                var paramater = JSON.stringify(request);

                var result = AJAXCallWithResult(
                    "/api/MyAlerts/SaveEmployeeAlertProjects",
                    paramater,
                    false
                );
                //var result = "";
                if (result || result.message === "SUCCESS") {
                    alertify.success('Project selection saved successfully');

                    // Close offcanvas
                    var offcanvasElement = document.getElementById('offcanvasProjectSelection');
                    var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                    if (bsOffcanvas) {
                        bsOffcanvas.hide();
                    }
                    $('body').removeClass('offcanvas-open');
                }
                else {
                    alertify.error(result?.Data || 'Failed to save project selection');
                }
            }


            //function ShowProjectSelectionHelp() {
            //    alertify.message('Help: Select projects from the left list and use arrow buttons to move them to the right list.');
            //}

            // Clean up when project selection offcanvas is hidden
            $('#offcanvasProjectSelection').on('hidden.bs.offcanvas', function () {
                $('body').removeClass('offcanvas-open');
            });

            function ResetProjectAlerts() {
                // Helper function to reset alert
                function resetAlert(chkId, txtId, freqId, mailId) {
                    $('#' + chkId).prop('checked', false);
                    $('#' + txtId).prop('disabled', true);
                    $('#' + freqId).val('').prop('disabled', true);
                    $('#' + mailId).prop('checked', false).prop('disabled', true);
                }

                // Task Alerts
                resetAlert('chkOverdueTasks', 'txtOverdueTasks', 'cboFrequencyOverdue', 'chkSendMailOverdue');
                resetAlert('chkDelayedTask', 'txtDelayedTask', 'cboFrequencyDelayed', 'chkSendMailDelayed');
                resetAlert('chkTaskExceededEfforts', 'txtTaskExceededEfforts', 'cboFrequencyTaskExceededEfforts', 'chkSendMailTaskExceededEfforts');

                // Milestone Alerts
                resetAlert('chkMilestoneDelayed', 'txtMilestoneDelayed', 'cboFrequencyMilestoneDelayed', 'chkSendMailMilestoneDelayed');
                resetAlert('chkMilestoneDueIn', 'txtMilestoneDueIn', 'cboFrequencyMilestoneDueIn', 'chkSendMailMilestoneDueIn');
                resetAlert('chkMilestoneDelayedBaseline', 'txtMilestoneDelayedBaseline', 'cboFrequencyMilestoneDelayedBaseline', 'chkSendMailMilestoneDelayedBaseline');
                resetAlert('chkMilestoneExceededEfforts', 'txtMilestoneExceededEfforts', 'cboFrequencyMilestoneExceededEfforts', 'chkSendMailMilestoneExceededEfforts');

                // Deliverable Alerts
                resetAlert('chkDeliverableDelayed', 'txtDeliverableDelayed', 'cboFrequencyDeliverableDelayed', 'chkSendMailDeliverableDelayed');
                resetAlert('chkDeliverableDueIn', 'txtDeliverableDueIn', 'cboFrequencyDeliverableDueIn', 'chkSendMailDeliverableDueIn');
                resetAlert('chkDeliverableDelayedBaseline', 'txtDeliverableDelayedBaseline', 'cboFrequencyDeliverableDelayedBaseline', 'chkSendMailDeliverableDelayedBaseline');
                resetAlert('chkDeliverableExceededEfforts', 'txtDeliverableExceededEfforts', 'cboFrequencyDeliverableExceededEfforts', 'chkSendMailDeliverableExceededEfforts');

                // Module Alerts
                resetAlert('chkModuleDelayed', 'txtModuleDelayed', 'cboFrequencyModuleDelayed', 'chkSendMailModuleDelayed');
                resetAlert('chkModuleDueIn', 'txtModuleDueIn', 'cboFrequencyModuleDueIn', 'chkSendMailModuleDueIn');
                resetAlert('chkModuleDelayedBaseline', 'txtModuleDelayedBaseline', 'cboFrequencyModuleDelayedBaseline', 'chkSendMailModuleDelayedBaseline');
                resetAlert('chkModuleExceededEfforts', 'txtModuleExceededEfforts', 'cboFrequencyModuleExceededEfforts', 'chkSendMailModuleExceededEfforts');

                // Issue Alerts
                resetAlert('chkIssueDelayed', 'txtIssueDelayed', 'cboFrequencyIssueDelayed', 'chkSendMailIssueDelayed');
                resetAlert('chkIssueDueIn', 'txtIssueDueIn', 'cboFrequencyIssueDueIn', 'chkSendMailIssueDueIn');

                // Change Request Alerts
                resetAlert('chkChangeRequestDelayed', 'txtChangeRequestDelayed', 'cboFrequencyChangeRequestDelayed', 'chkSendMailChangeRequestDelayed');
                resetAlert('chkChangeRequestDueIn', 'txtChangeRequestDueIn', 'cboFrequencyChangeRequestDueIn', 'chkSendMailChangeRequestDueIn');
            }

            //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
            function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
                if (WebConfigSpecialCharacters != '') {
                    var regularExpression = WebConfigSpecialCharacters;
                    regularExpression += '"';
                    var isSpecialCharacter = 0;
                    for (var i = 0; i < regularExpression.length; i++) {
                        if (value.indexOf(regularExpression[i]) != -1) {
                            isSpecialCharacter = 1
                        }
                    }
                    if (isSpecialCharacter == 1) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                else {
                    return false;
                }
            }

            function GetAlertsList() {
                // API call will be added here later
                showLoader();

                // Placeholder for API call
                // var AlertParameters = {
                //     AlertID: encodeURI(0),
                //     UserID: encodeURI(UserID)
                // }
                // var paramater = JSON.stringify(AlertParameters);
                // var strResult = AJAXCallWithResult("/api/PM_MyAlerts/GetAlertsList", paramater, false);

                $("#MyAlertsTblBody").html('');
                $("#MyAlertsTblBody").html('<tr><td colspan="6" style="text-align:center !important; padding: 30px;">There are no items to show in this view.</td></tr>');

                hideLoader();
            }

            function AddAlert(AlertID) {
                if (AlertID == 0) {
                    $("#txtAlertTitle").val('');
                    $("#txtAlertDescription").val('');
                    $('#SpanAlertID').val(AlertID);

                    // Show offcanvas
                    var offcanvasElement = document.getElementById('offcanvas_my_alerts');
                    var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
                    bsOffcanvas.show();
                    $('body').addClass('offcanvas-open');
                }
                else {
                    EditAlert(AlertID);
                }
            }

            function EditAlert(AlertID) {
                $('#SpanAlertID').val(AlertID);

                // Show offcanvas
                var offcanvasElement = document.getElementById('offcanvas_my_alerts');
                var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
                bsOffcanvas.show();
                $('body').addClass('offcanvas-open');

                // API call will be added here later
                // var AlertParameters = {
                //     AlertID: encodeURI(AlertID)
                // }
                // var paramater = JSON.stringify(AlertParameters);
                // var strResult = AJAXCallWithResult("/api/PM_MyAlerts/GetAlertByID", paramater, false);
                // 
                // $("#txtAlertTitle").val(strResult.AlertTitle);
                // $("#txtAlertDescription").val(strResult.Description);
            }

            function SaveAlert() {
                var Checkval = false;
                var AlertID = $("#SpanAlertID").val();
                var AlertTitle = $("#txtAlertTitle").val();
                var Description = $("#txtAlertDescription").val();

                AlertTitle = $.trim(AlertTitle);
                Description = $.trim(Description);

                if (AlertTitle == '') {
                    alertify.error("Alert Title is required");
                    $("#txtAlertTitle").focus();
                    Checkval = false;
                }
                else if (Description == '') {
                    alertify.error("Description is required");
                    $("#txtAlertDescription").focus();
                    Checkval = false;
                }
                else if (checkSpecialCharacter(AlertTitle, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Alert Title should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtAlertTitle").focus();
                    Checkval = false;
                }
                else {
                    Checkval = true;
                }

                if (Checkval == true) {
                    // API call will be added here later
                    // var AlertParameters = {
                    //     AlertTitle: encodeURI(AlertTitle),
                    //     Description: encodeURI(Description),
                    //     AlertID: encodeURI(AlertID)
                    // }
                    // var Parameter = JSON.stringify(AlertParameters);
                    // var strResult = AJAXCallWithResult("/api/PM_MyAlerts/InsertORUpdateAlert", Parameter, false);
                    // alertify.success(strResult);
                    // GetAlertsList();

                    alertify.success("<%=MyBase.GetResourceString("A_alrtsavesuccess")%>");

                    // Close offcanvas
                    var offcanvasElement = document.getElementById('offcanvas_my_alerts');
                    var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                    if (bsOffcanvas) {
                        bsOffcanvas.hide();
                    }
                    $('body').removeClass('offcanvas-open');

                    GetAlertsList();
                }
            }

            function FilterAlerts() {

                var durationValue = $("#cboDuration").val();
                // Filter logic will be implemented when API calls are added
                var activeTab = $('.nav-tabs .nav-link.active').attr('id');
                if (activeTab == 'alerts-tab') {
                    //GetAlertsList(durationValue);
                    GetMyAlerts(durationValue);
                } else {
                    GetProjectAlertsList();
                }
            }

            function DeleteAlert() {
                // API call will be added here later
                // var AlertParameters = {
                //     DelAlertIDs: encodeURI(AlertID)
                // }
                // var paramater = JSON.stringify(AlertParameters);
                // var strResult = AJAXCallWithResult("/api/PM_MyAlerts/DeleteAlert", paramater, false);
                // alertify.success(strResult);

                alertify.success("Alert(s) deleted successfully");
                var activeTab = $('.nav-tabs .nav-link.active').attr('id');
                if (activeTab == 'alerts-tab') {
                    GetAlertsList();
                } else {
                    GetProjectAlertsList();
                }
            }

            var alertsPerPage = 5;
            var currentAlertsPage = 1;
            var totalAlertsPages = 1;
            var allAlertsData = [];

            //function GetMyAlerts(durationflag) {

            //    var parameter = {
            //        EmployeeID: EmployeeID,
            //        Duration: durationflag
            //    }

            //    var param = JSON.stringify(parameter);
            //    var strResult = AJAXCallWithResult("/api/MyAlerts/GetMyAlerts", param, false);
            //    if (strResult) {
            //        var alertsList = strResult.data;
            //        // Store full alerts data for pagination
            //        allAlertsData = alertsList || [];
            //        // Initialize pagination
            //        currentAlertsPage = 1;
            //        totalAlertsPages = Math.ceil(allAlertsData.length / alertsPerPage) || 1;
            //        // Render first page
            //        RenderAlertsWithPagination();
            //    }
            //}

            function GetMyAlerts(durationflag) {

                var parameter = {
                    EmployeeID: EmployeeID,
                    Duration: durationflag
                };

                var param = JSON.stringify(parameter);
                var strResult = AJAXCallWithResult("/api/MyAlerts/GetMyAlerts", param, false);

                if (strResult && strResult.data) {

                    allAlertsData = strResult.data || [];
                    totalRecords = allAlertsData.length;

                    totalPages = Math.ceil(totalRecords / alertsPerPage) || 1;
                    currentPageNumber = 1;

                    RenderAlertsPage();
                    updateAlertsPaginationButtons();
                    updateAlertsTotalRecords();
                }
            }

            function RenderAlertsPage() {

                var startIndex = (currentPageNumber - 1) * alertsPerPage;
                var endIndex = startIndex + alertsPerPage;

                var paginatedData = allAlertsData.slice(startIndex, endIndex);

                PopulateAlertsTable(paginatedData);
            }

            function goToPreviousAlertsPage() {
                if (currentPageNumber > 1) {
                    currentPageNumber--;
                    RenderAlertsPage();
                    updateAlertsPaginationButtons();
                }
            }

            function goToNextAlertsPage() {
                if (currentPageNumber < totalPages) {
                    currentPageNumber++;
                    RenderAlertsPage();
                    updateAlertsPaginationButtons();
                }
            }

            function updateAlertsPaginationButtons() {

                var prevBtn = document.getElementById('alertsPrevBtn');
                var nextBtn = document.getElementById('alertsNextBtn');

                if (!prevBtn || !nextBtn) return;

                // Previous
                if (currentPageNumber <= 1 || totalRecords === 0) {
                    prevBtn.disabled = true;
                    prevBtn.style.opacity = '0.5';
                    prevBtn.style.cursor = 'not-allowed';
                } else {
                    prevBtn.disabled = false;
                    prevBtn.style.opacity = '1';
                    prevBtn.style.cursor = 'pointer';
                }

                // Next
                if (currentPageNumber >= totalPages || totalRecords === 0) {
                    nextBtn.disabled = true;
                    nextBtn.style.opacity = '0.5';
                    nextBtn.style.cursor = 'not-allowed';
                } else {
                    nextBtn.disabled = false;
                    nextBtn.style.opacity = '1';
                    nextBtn.style.cursor = 'pointer';
                }
            }

            function updateAlertsTotalRecords() {
                $('#alertsTotalRecords').text('Total Records: ' + totalRecords);
            }


            function RenderAlertsWithPagination() {
                // Calculate pagination
                var startIndex = (currentAlertsPage - 1) * alertsPerPage;
                var endIndex = startIndex + alertsPerPage;
                var paginatedData = allAlertsData.slice(startIndex, endIndex);

                // Call existing PopulateAlertsTable with paginated data
                PopulateAlertsTable(paginatedData);
                // Update pagination controls
                UpdateAlertsPaginationControls();
            }

            function UpdateAlertsPaginationControls() {
                var totalRecords = allAlertsData.length;
                var startRecord = totalRecords > 0 ? ((currentAlertsPage - 1) * alertsPerPage) + 1 : 0;
                var endRecord = Math.min(currentAlertsPage * alertsPerPage, totalRecords);

                // Update pagination info
                $('#alertsPaginationInfo').text(startRecord + ' - ' + endRecord + ' of ' + totalRecords);
                $('#alertsCurrentPage').text(currentAlertsPage);
                $('#alertsTotalPages').text(totalAlertsPages);

                // Show/hide pagination
                if (totalRecords > 0) {
                    $('#alertsPagination').show();
                } else {
                    $('#alertsPagination').hide();
                }

                // Enable/disable navigation buttons
                $('#alertsPaginationFirst').prop('disabled', currentAlertsPage === 1);
                $('#alertsPaginationPrev').prop('disabled', currentAlertsPage === 1);
                $('#alertsPaginationNext').prop('disabled', currentAlertsPage >= totalAlertsPages);
                $('#alertsPaginationLast').prop('disabled', currentAlertsPage >= totalAlertsPages);
            }

            function GoToAlertsPage(page) {
                if (page < 1 || page > totalAlertsPages) {
                    return;
                }
                currentAlertsPage = page;
                RenderAlertsWithPagination();
            }

            function PopulateAlertsTable(alertsList) {
                //debugger
                var tbody = $("#MyAlertsTblBody");

                tbody.empty();

                if (!alertsList || alertsList.length === 0) {

                    tbody.html('<tr><td colspan="6" style="text-align:center !important; padding: 30px; border-left: none; border-right: none;">There are no items to show in this view.</td></tr>');

                    return;

                }

                // Group alerts by dueDateStatus
                var groupedAlerts = {};
                alertsList.forEach(function (alert) {
                    var dueDateStatus = alert.dueDateStatus || '';
                    if (!groupedAlerts[dueDateStatus]) {
                        groupedAlerts[dueDateStatus] = [];
                    }
                    groupedAlerts[dueDateStatus].push(alert);
                });

                // Sort groups by numeric prefix (e.g., "2. Today" before "4. This Week")
                var sortedGroups = Object.keys(groupedAlerts).sort(function (a, b) {
                    var numA = parseInt(a.split('.')[0]) || 999;
                    var numB = parseInt(b.split('.')[0]) || 999;
                    return numA - numB;
                });

                // Render grouped alerts
                sortedGroups.forEach(function (groupKey) {
                    var groupAlerts = groupedAlerts[groupKey];

                    // Add group header row
                    var groupHeaderRow = $('<tr>');
                    groupHeaderRow.append($('<td>').attr('colspan', '6').css({
                        'background-color': '#f8f9fa',
                        'padding': '8px 0 8px 12px',
                        'font-weight': '600',
                        'color': '#374151',
                        'border-top': '1px solid #dee2e6',
                        'border-bottom': '1px solid #dee2e6',
                        'border-left': 'none',
                        'border-right': 'none',
                        'text-align': 'left'
                    }).text(groupKey));
                    tbody.append(groupHeaderRow);

                    // Render alerts in this group
                    groupAlerts.forEach(function (alert) {

                        var row = $('<tr>');

                        // Flag column - Check flagTo field (1 = flagged) and make it clickable
                        var flagIcon = '';
                        var flagTo = alert.flagTo || alert.FlagTo || '';
                        var contextID = alert.contextID || alert.ContextID || alert.id || '';
                        var contextType = alert.contextType || alert.ContextType || 'HelpDeskRequest';
                        var entityName = alert.entityName || alert.EntityName || '';
                        var projectID = alert.projectID || alert.ProjectID || 0;

                        if (flagTo === '1' || flagTo === 1 || contextID) {

                            var dueDateState = alert.dueDateState || '';
                            var flagColor = '#dc3545'; // default red
                            var tooltipText = 'Delayed'; // default

                            if (dueDateState === 'B') {
                                flagColor = '#16a34a';      // Green
                                tooltipText = 'Completed';
                            } else if (dueDateState === 'S') {
                                flagColor = '#facc15';      // Yellow
                                tooltipText = 'Today';
                            } else if (dueDateState === 'G') {
                                flagColor = '#fb923c';      // Orange
                                tooltipText = 'Future';
                            } else if (dueDateState === 'L') {
                                flagColor = '#dc2626';      // Red
                                tooltipText = 'Delayed';
                            }

                            flagIcon = `
                            <i class="fa fa-flag"
                               style="color:${flagColor}; cursor:pointer;"
                               data-bs-toggle="tooltip"
                               data-bs-placement="top"
                               title="${tooltipText}"
                               onclick="OpenTrackingDetails(${contextID}, '${contextType}', '${entityName.replace(/'/g, "\\'")}', ${projectID});">
                            </i>`;
                        }

                        row.append($('<td>').css('text-align', 'center').html(flagIcon));

                        // Project Name column - Show contextTypeChar in box, then projectName or N/A
                        var contextTypeChar = alert.contextTypeChar || alert.ContextTypeChar || '';
                        var contextTypeCharTooltip = '';
                        var projectName = alert.projectName || alert.ProjectName || '';
                        var projectNameHtml = '';

                        if (contextTypeChar == 'H') {
                            contextTypeCharTooltip = 'Help Request';
                        }

                        if (contextTypeChar == 'D') {
                            contextTypeCharTooltip = 'Deliverable';
                        }

                        if (contextTypeChar == 'I') {
                            contextTypeCharTooltip = 'Issue';
                        }

                        if (contextTypeChar == 'M') {
                            contextTypeCharTooltip = 'Milestone';
                        }

                        if (contextTypeChar == 'R') {
                            contextTypeCharTooltip = 'Risk';
                        }

                        if (contextTypeChar == 'T') {
                            contextTypeCharTooltip = 'Task';
                        }

                        if (contextTypeChar == 'W') {
                            contextTypeCharTooltip = 'Review';
                        }

                        if (contextTypeChar == 'Mod') {
                            contextTypeCharTooltip = 'Module';
                        }

                        if (contextTypeChar) {
                            /*projectNameHtml += '<span style="display: inline-block; padding: 2px 8px; background-color: #e7edf0; border: 1px solid #cbd5e1; border-radius: 3px; margin-right: 5px; font-weight: 500; color: #374151;">' + contextTypeChar + '</span>';*/
                            projectNameHtml +=
                                '<span ' +
                                'data-bs-toggle="tooltip" ' +
                                'data-bs-placement="top" ' +
                                'title="' + contextTypeCharTooltip + '" ' +
                                'style="display: inline-block; padding: 2px 8px; background-color: #e7edf0; border: 1px solid #cbd5e1; border-radius: 3px; margin-right: 5px; font-weight: 500; color: #374151;">' +
                                contextTypeChar +
                                '</span>';

                        }
                        projectNameHtml += (projectName || 'N/A');
                        row.append($('<td>').html(projectNameHtml));

                        // Name column (entityName) - Make it a clickable link
                        var entityName = alert.entityName || alert.EntityName || alert.Name || alert.name || '';
                        /*var nameLink = '<a href="javascript:void(0);" style="color: #1359a6; text-decoration: underline; cursor: pointer;">' + entityName + '</a>';*/
                        row.append($('<td>').html(entityName));

                        // Resource/Customer column (employeeName) - Make it a clickable link
                        // API already includes "(Customer)" suffix in employeeName when applicable
                        var employeeName = alert.employeeName || alert.EmployeeName || '';
                        /*var resourceCustomerLink = '<a href="javascript:void(0);" style="color: #1359a6; text-decoration: underline; cursor: pointer;">' + employeeName + '</a>';*/
                        var resourceCustomerLink = '<span>' + employeeName + '</span>';
                        row.append($('<td>').html(resourceCustomerLink));

                        // Status column - Make it a clickable link with badge styling
                        //var status = alert.status || alert.Status || '';
                        //var statusClass = '';
                        //if (status.toLowerCase() === 'active' || status.toLowerCase() === 'open') {
                        //    statusClass = 'badge bg-success';
                        //} else if (status.toLowerCase() === 'closed' || status.toLowerCase() === 'resolved') {
                        //    statusClass = 'badge bg-secondary';
                        //} else if (status.toLowerCase() === 'pending') {
                        //    statusClass = 'badge bg-warning';
                        //} else if (status.toLowerCase() === 'submitted') {
                        //    statusClass = 'badge bg-info';
                        //} else {
                        //    statusClass = 'badge bg-info';
                        //}
                        //var statusLink = '<a href="javascript:void(0);" style="color: inherit; text-decoration: none; cursor: auto;"><span class="' + statusClass + '">' + status + '</span></a>';
                        //row.append($('<td>').css('text-align', 'center').html(statusLink));
                    //    var status = (alert.status || alert.Status || '').toLowerCase();
                    //    var statusClass = 'badge bg-secondary'; // default

                    //    if (status === 'submitted') {
                    //        statusClass = 'badge bg-info';
                    //    } else if (status === 'assigned') {
                    //        statusClass = 'badge bg-primary';
                    //    } else if (status === 'resolved') {
                    //        statusClass = 'badge bg-success';
                    //    } else if (status === 'closed') {
                    //        statusClass = 'badge bg-secondary';
                    //    }else if (status === 'yet to start') {
                    //    statusClass = 'badge bg-warning text-dark'; // Yellow badge

                    //} else if (status === 'open') {
                    //    statusClass = 'badge bg-danger'; // Red badge
                    //}
                        

                        //var displayStatus = alert.status || alert.Status || '';

                        //var statusLink = `
                        //    <a href="javascript:void(0);" style="color: inherit; text-decoration: none; cursor: auto;">
                        //        <span class="${statusStyle}">${displayStatus}</span>
                        //    </a>
                        //`;

                        //row.append(
                        //    $('<td>').css('text-align', 'center').html(statusLink)
                        //);

                        var displayStatus = (alert.status || alert.Status || '').trim();

                        var statusHtml = "";

                        // Only show badge if status has value
                        if (displayStatus !== "") {

                            var status = displayStatus.toLowerCase();

                            var statusStyle = "background-color: white; color: black; padding:4px 10px; border-radius:12px; font-size:12px; border:1px solid #ccc;";

                            if (status === "submitted") {
                                statusStyle = "background-color: #0d6efd; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "assigned") {
                                statusStyle = "background-color: #198754; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "resolved") {
                                statusStyle = "background-color: #20c997; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "closed") {
                                statusStyle = "background-color: #212529; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "yet to start") {
                                statusStyle = "background-color: #ffc107; color: black; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "open") {
                                statusStyle = "background-color: #dc3545; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "acknowledgement") {
                                statusStyle = "background-color: #6f42c1; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "on hold") {
                                statusStyle = "background-color: #fd7e14; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "analysis completed") {
                                statusStyle = "background-color: #0dcaf0; color: black; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "in progress") {
                                statusStyle = "background-color: #6610f2; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "milestone closed") {
                                statusStyle = "background-color: #343a40; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "ready for analysis") {
                                statusStyle = "background-color: #17a2b8; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "not started") {
                                statusStyle = "background-color: #adb5bd; color: black; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "completed") {
                                statusStyle = "background-color: #28a745; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "approved") {
                                statusStyle = "background-color: #007bff; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }
                            else if (status === "rejected") {
                                statusStyle = "background-color: #b02a37; color: white; padding:4px 10px; border-radius:12px; font-size:12px;";
                            }

                            // Create badge only when status exists
                            statusHtml = `
                            <span style="${statusStyle}">
                                ${displayStatus}
                            </span>
                        `;
                        }

                        // Append Status Column
                        row.append(
                            $('<td>').css('text-align', 'center').html(statusHtml)
                        );



                        // Due Date column - Format as DD/MM/YYYY
                        var dueDate = alert.dueDate || alert.DueDate || alert.Due_Date || alert.due_date || '';
                        var formattedDate = '';
                        if (dueDate) {
                            try {
                                // Parse ISO date string (e.g., "2026-01-08T00:00:00")
                                var dateStr = dueDate.split('T')[0]; // Extract date part before 'T'
                                var dateParts = dateStr.split('-');
                                if (dateParts.length === 3) {
                                    // Format as DD/MM/YYYY
                                    var year = dateParts[0];
                                    var month = dateParts[1];
                                    var day = dateParts[2];
                                    formattedDate = day + '/' + month + '/' + year;
                                } else {
                                    // Fallback to Date object parsing
                                    var dateObj = new Date(dueDate);
                                    if (!isNaN(dateObj.getTime())) {
                                        var day = String(dateObj.getDate()).padStart(2, '0');
                                        var month = String(dateObj.getMonth() + 1).padStart(2, '0');
                                        var year = dateObj.getFullYear();
                                        formattedDate = day + '/' + month + '/' + year;
                                    }
                                }
                            } catch (e) {
                                formattedDate = dueDate;
                            }
                        }
                        row.append($('<td>').css('text-align', 'center').text(formattedDate));

                        // Action column - Three-dot icon that opens Request Details in off-canvas
                        var alertId = alert.id || alert.ID || alert.AlertID || alert.alertID || '';
                        // QueryID should be the actual Help Desk Request ID (contextID), but fallback to alertId if contextID not available
                        var queryId = alert.contextID || alert.ContextID || alertId;

                        
                        //if (contextTypeChar == 'H') {
                        //    var actionIcon = '<i class="fa fa-ellipsis-v" style="color: #6b7280; cursor: pointer; font-size: 11.5px;" onclick="OpenRequestDetailsInOffcanvas(' + queryId + ');" title="View Request Details"></i>';
                        //    //row.append($('<td>').css('text-align', 'center').html(actionIcon));
                        //}
                        //else {
                        //    var actionIcon = '<span style="cursor: no-drop;"><i class="fa fa-ellipsis-v" style="color: #6b7280;  pointer-events:none; font-size: 11.5px;" onclick="OpenRequestDetailsInOffcanvas(' + queryId + ');" title="View Request Details"></i></span>';
                        //    //row.append($('<td>').css('text-align', 'center').html(actionIcon));
                        //}
                        
                        
                        tbody.append(row);

                    });
                });

                // Initialize tooltips

                $('[data-bs-toggle="tooltip"]').tooltip();

            }

            function BindDurationDropdown() {
                //debugger
                var strHTML = "";

                var Result = AJAXCallWithResult("/api/MyAlerts/GetAlertDurationList", '', false);
                if (Result && Result.data && Result.data.length > 0) {
                    for (var i = 0; i < Result.data.length; i++) {
                        var ListComponent = Result.data[i];

                        //strHTML += ('<option value=' + ListComponent.ModifiedField + ' onclick = "ShowUnitHstory()">' + ListComponent.ModifiedField + '</option>');
                        strHTML += ('<option value="' + ListComponent.id + '">' + ListComponent.disp + '</option>');

                    }
                }

                // Destroy selectpicker if it exists, then set HTML and reinitialize
                if ($("#cboDuration").hasClass('selectpicker') && $("#cboDuration").data('selectpicker')) {
                    $("#cboDuration").selectpicker('destroy');
                }

                $("#cboDuration").html(strHTML);

                // Reinitialize selectpicker
                if ($("#cboDuration").hasClass('selectpicker')) {
                    $("#cboDuration").selectpicker('refresh');
                } else {
                    //$("#cboDuration").addClass('selectpicker').selectpicker();
                }
            }

            function LoadAlertEntityDetails() {

                var param = JSON.stringify({
                    EmployeeID: EmployeeID,
                    EmployeeAlertID: null   // or selected alert id
                });

                var Result = AJAXCallWithResult(
                    "/api/MyAlerts/GetAlertEntityDetails",
                    param,
                    false
                );

                if (Result && Result.data && Result.data.data) {
                    BindAlertEntities(Result.data.data);
                }
            }

            function BindAlertEntities(alertList) {

                var html = "";
                var currentEntity = "";

                $.each(alertList, function (i, item) {

                    // Entity header (Task / Milestone / Deliverable)
                    if (currentEntity !== item.EntityType) {
                        currentEntity = item.EntityType;

                        html += `
                <div class="fw-bold text-primary mt-3">
                    ${currentEntity}
                </div>
            `;
                    }

                    html += `
            <div class="row align-items-center mb-2">
                <div class="col-md-5">
                    <input type="checkbox" class="form-check-input me-2 alert-check">
                    ${item.AlertText}
                    ${item.HasValue ? `<input type="text" class="form-control d-inline-block ms-2" style="width:80px;"> ${item.Unit}` : ``}
                </div>

                <div class="col-md-3">
                    ${item.HasProjectSelection ? `<a href="#">Project Selection</a>` : ``}
                </div>

                <div class="col-md-2">
                    ${item.HasFrequency ? `
                        <select class="form-select">
                            <option value="">Select Frequency</option>
                        </select>` : ``}
                </div>

                <div class="col-md-2 text-center">
                    ${item.HasSendMail ? `<input type="checkbox">` : ``}
                </div>
            </div>
        `;
                });

                $("#alertEntityContainer").html(html);
            }

            function LoadTrackingConfiguration() {
                //debugger
                var parameters = {
                    EmployeeID: EmployeeID
                };

                var result = AJAXCallWithResult(
                    "/api/MyAlerts/GetFlagForTrackingConfigure?EmployeeID=" + EmployeeID,
                    null,
                    false
                );

                if (!result || !result.data || result.data.length === 0) {
                    $("#custmerlinkid").hide();
                    $("#employeelinkid").hide();
                    return;
                }

                var config = result.data[0];

                /* Help Desk Alerts */
                $("#chkHelpRequestEntered")
                    .prop("checked", config.customerFlag === 1);

                /* Enable / Disable Not Resolved checkbox based on Help Request Entered */
                if (config.customerFlag === 1) {
                    $("#chkHelpRequestNotResolved").prop("disabled", false);

                } else {
                    $("#chkHelpRequestNotResolved")
                        .prop("checked", false)
                        .prop("disabled", true);

                    $("#txtHelpRequestNotResolved")
                        .val(0)
                        .prop("disabled", true);
                }

                $("#chkHelpRequestNotResolved")
                    .prop("checked", config.helpRequestAfterFlag === 1);

                $("#txtHelpRequestNotResolved")
                    .val(config.helpRequestAfterDays)
                    .prop("disabled", config.helpRequestAfterFlag !== 1);

                //Send Me Reminder Day(s) before expected resolution date
                $("#chkHelpDeskReminder")
                    .prop("checked", config.helpRequestAlertFlag === 1);

                $("#txtSendMeRembefexpresdt")
                    .val(config.helpRequestAlertDays)
                    .prop("disabled", config.helpRequestAlertFlag !== 1);

                /* Task Due Date Alert */
                $("#chkTaskDueDateReminder")
                    .prop("checked", config.taskAlertFlag === 1);

                $("#txtTaskDueDateReminder")
                    .val(config.taskAlertDays)
                    .prop("disabled", config.taskAlertFlag !== 1);

                /* Review Due Date Alert */
                $("#chkReviewDueDateReminder")
                    .prop("checked", config.reviewAlertFlag === 1);

                $("#txtReviewDueDateReminder")
                    .val(config.reviewAlertDays)
                    .prop("disabled", config.reviewAlertFlag !== 1);

                /* Deliverable Due Date Alert */
                $("#chkDeliverableDueDateReminder")
                    .prop("checked", config.deliverableAlertFlag === 1);

                $("#txtDeliverableDueDateReminder")
                    .val(config.deliverableAlertDays)
                    .prop("disabled", config.deliverableAlertFlag !== 1);

                if ($('#chkHelpRequestEntered').is(':checked')) {
                    $('#chkHelpRequestNotResolved').prop('disabled', false);
                } else {
                    $('#chkHelpRequestNotResolved')
                        .prop('checked', false)
                        .prop('disabled', true);

                    $('#txtHelpRequestNotResolved').prop('disabled', true);
                    $('#txtHelpRequestNotResolved').val('0');
                }

                var isAnyChecked =
                    config.customerFlag === 1 ||
                    config.helpRequestAfterFlag === 1 ||
                    config.taskAlertFlag === 1 ||
                    config.reviewAlertFlag === 1 ||
                    config.deliverableAlertFlag === 1;

                if (isAnyChecked && config.customerFlag === 1) {
                    $("#custmerlinkid").show();
                    $("#employeelinkid").show();
                } else {
                    $("#custmerlinkid").hide();
                    $("#employeelinkid").hide();
                }
            }

            // Initialize Tracking Details Date Picker on page load
            $(document).ready(function () {
                if ($('#trackingDueDate').length > 0) {
                    $('#trackingDueDate').datepicker({
                        dateFormat: 'dd/mm/yy',
                        changeMonth: true,
                        changeYear: true,
                        showButtonPanel: true,
                        yearRange: '2020:2030',
                        minDate: 0
                    });

                    // Trigger datepicker when calendar icon is clicked
                    $('#trackingDatePickerIcon').on('click', function () {
                        $('#trackingDueDate').datepicker('show');
                    });
                }

                // Initialize Request Details Date Picker
                if ($('#requestDetailsStatusChangeDate').length > 0) {
                    $('#requestDetailsStatusChangeDate').datepicker({
                        dateFormat: 'dd-mm-yy',
                        changeMonth: true,
                        changeYear: true,
                        showButtonPanel: true,
                        yearRange: '2020:2030'
                    });

                    // Trigger datepicker when calendar icon is clicked
                    $('#requestDetailsDatePickerIcon').on('click', function () {
                        $('#requestDetailsStatusChangeDate').datepicker('show');
                    });
                }

                // Load Flag To dropdown options
                LoadFlagToOptions();
            });

            function LoadFlagToOptions() {
                
                // Load Flag To options from API
                var $flagToDropdown = $('#cboFlagTo');
                $flagToDropdown.empty();

                // Add default "-- Select --" option
                //$flagToDropdown.append($('<option></option>').val('-1').text('-- Select --'));

                // Call API to get Flag To options
                var Result = AJAXCallWithResult("/api/MyAlerts/GetMyAlertsFlagToCombo", '', false);
                if (Result && Result.data && Result.data.length > 0) {
                    for (var i = 0; i < Result.data.length; i++) {
                        var ListComponent = Result.data[i];
                        // Use text as both value and display text (backend stores text values like "Review", "Follow Up")
                        var optionValue = ListComponent.text || '';
                        var optionText = ListComponent.text || '';
                        //$flagToDropdown.append($('<option></option>').val(optionValue).text(optionText));
                        if (optionValue) {
                            $flagToDropdown.append($('<option></option>').val(optionValue).text(optionText));
                        }
                    }
                }
            }

            function LoadContextName(contextID, contextType) {
                // Load context name from API
                var parameter = {
                    contextID: parseInt(contextID),
                    contextType: contextType || 'HelpDeskRequest'
                };

                var param = JSON.stringify(parameter);
                var Result = AJAXCallWithResult("/api/MyAlerts/GetMyAlertsContextName", param, false);

                if (Result && Result.data && Result.data.MyAlertsContextNameDto && Result.data.MyAlertsContextNameDto.length > 0) {
                    var contextName = Result.data.MyAlertsContextNameDto[0].contextName || '';
                    if (contextName) {
                        $('#trackingHelpRequest').text(contextName);
                    }
                }
            }

            function LoadTrackingDetailsFromAPI(contextID, contextType) {
                
                // Load tracking details from GetMyAlertsTrackingEditDetails API
                var parameter = {
                    contextID: parseInt(contextID),
                    contextType: contextType || 'HelpDeskRequest',
                    employeeID: parseInt(EmployeeID)
                };

                var param = JSON.stringify(parameter);
                var Result = AJAXCallWithResult("/api/MyAlerts/GetMyAlertsTrackingEditDetails", param, false);

                if (Result && Result.data && Result.data.length > 0) {
                    var tracking = Result.data[0];

                    // Bind Request ID (contextID)
                    if (tracking.contextID) {
                        $('#trackingRequestID').text(tracking.contextID);
                    }

                    // Bind UniqueID
                    if (tracking.uniqueID) {
                        $('#hdnTrackingUniqueID').val(tracking.uniqueID);
                        if (tracking.uniqueID !== 0) {
                            $('#btnClearFlag').show();
                        }
                    }

                    // Bind Flag To
                    if (tracking.flagTo !== undefined && tracking.flagTo !== null && tracking.flagTo !== '') {
                        //$('#cboFlagTo').val(tracking.flagTo.toString());
                        var flagValue;

                        if (tracking.flagTo === 1 || tracking.flagTo === '1' || tracking.flagTo === 'Review') {
                            flagValue = 'Review';
                        } else {
                            flagValue = 'Follow Up';
                        }

                        $('#cboFlagTo').val(flagValue);
                    }
                    else {
                        $('#cboFlagTo').val('Review');
                    }

                    // Bind Due Date (format as DD/MM/YYYY)
                    if (tracking.dueDate && tracking.dueDate !== '') {
                        try {
                            // Parse ISO date string (e.g., "2026-01-08T12:53:39.17")
                            var dateStr = tracking.dueDate.split('T')[0]; // Extract date part
                            var dateParts = dateStr.split('-');
                            if (dateParts.length === 3) {
                                // Format as DD/MM/YYYY
                                var day = dateParts[2];
                                var month = dateParts[1];
                                var year = dateParts[0];
                                var formattedDate = day + '/' + month + '/' + year;
                                $('#trackingDueDate').val(formattedDate);
                            } else {
                                // Fallback to Date object parsing
                                var dateObj = new Date(tracking.dueDate);
                                if (!isNaN(dateObj.getTime())) {
                                    var day = String(dateObj.getDate()).padStart(2, '0');
                                    var month = String(dateObj.getMonth() + 1).padStart(2, '0');
                                    var year = dateObj.getFullYear();
                                    var formattedDate = day + '/' + month + '/' + year;
                                    $('#trackingDueDate').val(formattedDate);
                                }
                            }
                        } catch (e) {
                            console.log('Error parsing due date:', e);
                        }
                    }

                    // Bind Complete checkbox
                    if (tracking.isComplete === true || tracking.isComplete === 'true' || tracking.isComplete === 1 || tracking.isComplete === '1') {
                        $('#chkFlagComplete').prop('checked', true);
                        //$('#btnClearFlag').hide();
                    } else {
                        $('#chkFlagComplete').prop('checked', false);
                        if (tracking.uniqueID && tracking.uniqueID !== 0) {
                            $('#btnClearFlag').show();
                        }
                    }
                }
            }

            function OpenRequestDetailsInOffcanvas(queryId) {



                var result = AJAXCallWithResult(
                    "/api/MyAlerts/GetMyAlertsRequestDetails?RequestID=" + queryId,
                    null,
                    false
                );

                if (!result || !result.data || !result.data.MyAlertsRequestDetailsDto || result.data.MyAlertsRequestDetailsDto.length === 0) {
                    return;
                }

                var data = result.data.MyAlertsRequestDetailsDto[0];

                // Bind values
                $('#requestDetailsID').text(data.queryID);
                $('#requestDetailsRequestor').text(data.customerID);
                $('#requestDetailsRequestedOn').text(data.submittedDate);
                $('#requestDetailsPriority').text(data.priority);
                $('#requestDetailsSubject').val(data.subject);
                $('#requestDetailsDescription').val(data.description);
                $('#requestDetailsDepartment').val(data.department);
                $('#requestDetailsRequestType').val(data.requestType);
                $('#requestDetailsSubRequestType').val(data.subRequestType);
                $('#requestDetailsSubHelpDeskType').val(''); // Not available in API
                $('#requestDetailsProduct').val(data.productID);
                $('#requestDetailsModuleComponent').val(data.componentID);
                $('#requestDetailsPrioritySelect').val(data.priority);
                $('#requestDetailsSeverity').val(data.severity);
                $('#requestDetailsStatus').val(data.status);
                $('#requestDetailsAssignedTo').val(data.assignedToEmployee);
                $('#requestDetailsOrgUnit').val(data.location);
                $('#requestDetailsStatusChangeDate').val(data.statusChangeDate);
                $('#requestDetailsStatusChangeTime').val(data.statusChangeTime);
                $('#requestDetailsDeliverable').val(data.deliverableID);
                $('#requestDetailsProject').val(data.projectID);

                // Show offcanvas
                var offcanvasElement = document.getElementById('offcanvasRequestDetails');
                var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
                bsOffcanvas.show();
                $('body').addClass('offcanvas-open');
            }


            function LoadRequestDetailsData(queryId) {
                var contextName = '';

                // Load context name (Subject) from API
                var parameter = {
                    contextID: parseInt(queryId),
                    contextType: 'HelpDeskRequest'
                };
                var param = JSON.stringify(parameter);
                var contextResult = AJAXCallWithResult("/api/MyAlerts/GetMyAlertsContextName", param, false);

                if (contextResult && contextResult.data && contextResult.data.MyAlertsContextNameDto && contextResult.data.MyAlertsContextNameDto.length > 0) {
                    contextName = contextResult.data.MyAlertsContextNameDto[0].contextName || '';
                    if (contextName) {
                        $('#requestDetailsSubject').text(contextName);
                    }
                }

                // Load tracking details to get additional information
                var trackingParameter = {
                    contextID: parseInt(queryId),
                    contextType: 'HelpDeskRequest',
                    employeeID: parseInt(EmployeeID)
                };
                var trackingParam = JSON.stringify(trackingParameter);
                var trackingResult = AJAXCallWithResult("/api/MyAlerts/GetMyAlertsTrackingEditDetails", trackingParam, false);

                if (trackingResult && trackingResult.data && trackingResult.data.length > 0) {
                    var tracking = trackingResult.data[0];

                    // Set Status Change Date if available
                    if (tracking.dueDate && tracking.dueDate !== '') {
                        try {
                            var dateStr = tracking.dueDate.split('T')[0];
                            var dateParts = dateStr.split('-');
                            if (dateParts.length === 3) {
                                var formattedDate = dateParts[2] + '/' + dateParts[1] + '/' + dateParts[0];
                                $('#requestDetailsStatusChangeDate').text(formattedDate);
                            }
                        } catch (e) {
                            console.log('Error formatting date:', e);
                        }
                    }
                }

                // Find the alert data from the current alerts list to get additional info
                if (allAlertsData && allAlertsData.length > 0) {
                    var alertData = allAlertsData.find(function (alert) {
                        return (alert.contextID || alert.id) == queryId;
                    });

                    if (alertData) {
                        // Set Requestor (from employeeName)
                        if (alertData.employeeName) {
                            $('#requestDetailsRequestor').text(alertData.employeeName);
                        }

                        // Set Status
                        if (alertData.status) {
                            $('#requestDetailsStatus').text(alertData.status);
                        }

                        // Set Priority (if available in alert data)
                        if (alertData.priority) {
                            $('#requestDetailsPrioritySelect').text(alertData.priority);
                            $('#requestDetailsPriority').text(alertData.priority);
                        }

                        // Set Subject if not already set
                        if (!contextName && alertData.entityName) {
                            $('#requestDetailsSubject').text(alertData.entityName);
                        }

                        // Set Description (if available)
                        if (alertData.description) {
                            $('#requestDetailsDescription').text(alertData.description);
                        } else {
                            $('#requestDetailsDescription').text('--');
                        }

                        // Set Requested On (from dueDate or other date field)
                        if (alertData.dueDate) {
                            try {
                                var dateStr = alertData.dueDate.split('T')[0];
                                var dateParts = dateStr.split('-');
                                if (dateParts.length === 3) {
                                    var formattedDate = dateParts[2] + '/' + dateParts[1] + '/' + dateParts[0];
                                    $('#requestDetailsRequestedOn').text(formattedDate);
                                }
                            } catch (e) {
                                console.log('Error formatting requested date:', e);
                            }
                        }

                        // Set Project Name (if available)
                        if (alertData.projectName) {
                            $('#requestDetailsProject').text(alertData.projectName);
                        }

                        // Set Department, Request Type, Sub Request Type, Product, Module/Component, Severity, Assigned To, Org Unit, Deliverable
                        // These fields may not be available in alert data, so they will remain as "--" unless we have an API to fetch them
                        // For now, we'll leave them as "--" or empty if not available
                        if (alertData.department) {
                            $('#requestDetailsDepartment').text(alertData.department);
                        }
                        if (alertData.requestType) {
                            $('#requestDetailsRequestType').text(alertData.requestType);
                        }
                        if (alertData.subRequestType) {
                            $('#requestDetailsSubRequestType').text(alertData.subRequestType);
                        }
                        if (alertData.subHelpDeskType) {
                            $('#requestDetailsSubHelpDeskType').text(alertData.subHelpDeskType);
                        }
                        if (alertData.product) {
                            $('#requestDetailsProduct').text(alertData.product);
                        }
                        if (alertData.moduleComponent) {
                            $('#requestDetailsModuleComponent').text(alertData.moduleComponent);
                        }
                        if (alertData.severity) {
                            $('#requestDetailsSeverity').text(alertData.severity);
                        }
                        if (alertData.assignedTo) {
                            $('#requestDetailsAssignedTo').text(alertData.assignedTo);
                        }
                        if (alertData.orgUnit) {
                            $('#requestDetailsOrgUnit').text(alertData.orgUnit);
                        }
                        if (alertData.deliverable) {
                            $('#requestDetailsDeliverable').text(alertData.deliverable);
                        }
                        if (alertData.statusChangeTime) {
                            $('#requestDetailsStatusChangeTime').text(alertData.statusChangeTime);
                        }
                    }
                }
            }

            function OpenTrackingDetails(contextID, contextType, contextName, projectID) {
                if (!contextID || contextID === 0) {
                    alertify.warning('Invalid context ID');
                    return;
                }

                // Set hidden fields
                $('#hdnTrackingContextID').val(contextID);
                $('#hdnTrackingContextType').val(contextType || 'HelpDeskRequest');
                $('#hdnTrackingProjectID').val(projectID || 0);
                $('#trackingRequestID').text(contextID);
                $('#trackingHelpRequest').text(contextName || ''); // Set initial value, will be updated from API

                // Clear previous values
                $('#cboFlagTo').val('-1');
                $('#trackingDueDate').val('');
                $('#chkFlagComplete').prop('checked', false);
                $('#hdnTrackingUniqueID').val('0');
                $('#btnClearFlag').hide();
                $('#trackingFlagToError').hide();
                $('#trackingDueDateError').hide();

                // Load context name from API
                LoadContextName(contextID, contextType || 'HelpDeskRequest');

                // Load tracking details using GetMyAlertsTrackingEditDetails API
                LoadTrackingDetailsFromAPI(contextID, contextType || 'HelpDeskRequest');

                // Show off-canvas
                var offcanvasElement = document.getElementById('offcanvasTrackingDetails');
                var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
                bsOffcanvas.show();
                $('body').addClass('offcanvas-open');
            }

            //function LoadTrackingDetails(contextID, contextType) {
            //    // Use WebMethod from CRM_RequestDetailsNew.aspx for Help Desk Requests
            //    if (contextType === 'HelpDeskRequest' || contextType === 'HelpRequest') {
            //        $.ajax({
            //            type: "POST",
            //            url: "../../HelpdeskEnhancement/Request/CRM_RequestDetailsNew.aspx/GetFlagDetails",
            //            data: JSON.stringify({ RequestID: contextID.toString() }),
            //            contentType: "application/json; charset=utf-8",
            //            dataType: "json",
            //            success: function(response) {
            //                if (response && response.d) {
            //                    var result = response.d;
            //                    if (result && result !== "Bad Request found") {
            //                        var parts = result.split("#$#");
            //                        if (parts.length >= 5) {
            //                            var uniqueID = parts[0];
            //                            var isComplete = parts[1];
            //                            var dueDate = parts[2];
            //                            var flagTo = parts[3];
            //                            var contextValue = parts[4] || '';

            //                            $('#hdnTrackingUniqueID').val(uniqueID || '0');
            //                            if (flagTo && flagTo !== '') {
            //                                $('#cboFlagTo').val(flagTo);
            //                            }
            //                            if (dueDate && dueDate !== '') {
            //                                try {
            //                                    // Parse date and set in datepicker format (DD/MM/YYYY)
            //                                    var dateObj = new Date(dueDate);
            //                                    if (!isNaN(dateObj.getTime())) {
            //                                        var day = String(dateObj.getDate()).padStart(2, '0');
            //                                        var month = String(dateObj.getMonth() + 1).padStart(2, '0');
            //                                        var year = dateObj.getFullYear();
            //                                        var formattedDate = day + '/' + month + '/' + year;
            //                                        $('#trackingDueDate').val(formattedDate);
            //                                    }
            //                                } catch (e) {
            //                                    $('#trackingDueDate').val(dueDate);
            //                                }
            //                            }
            //                            if (isComplete === 'True' || isComplete === '1') {
            //                                $('#chkFlagComplete').prop('checked', true);
            //                                $('#btnClearFlag').hide();
            //                            } else {
            //                                $('#chkFlagComplete').prop('checked', false);
            //                                if (uniqueID && uniqueID !== '0') {
            //                                    $('#btnClearFlag').show();
            //                                }
            //                            }
            //                            if (contextValue && contextValue !== '') {
            //                                $('#trackingHelpRequest').text(contextValue);
            //                            }
            //                        }
            //                    }
            //                }
            //            },
            //            error: function(xhr, status, error) {
            //                console.log('Error loading tracking details:', error);
            //            }
            //        });
            //    } else {
            //        // For other context types (Issues, Tasks, etc.), use the API endpoint
            //        var issueParameters = {
            //            intEmployeeID: EmployeeID,
            //            ContextID: parseInt(contextID)
            //        };
            //        var param = JSON.stringify(issueParameters);
            //        var strResult = AJAXCallWithResult("/api/Issue/GetTrackingDetails", param, false);

            //        if (strResult && strResult.length > 0) {
            //            var tracking = strResult[0];
            //            $('#hdnTrackingUniqueID').val(tracking.UniqueID || '0');
            //            if (tracking.FlagTo && tracking.FlagTo !== '') {
            //                $('#cboFlagTo').val(tracking.FlagTo);
            //            }
            //            if (tracking.DueDate && tracking.DueDate !== '') {
            //                try {
            //                    var dateObj = new Date(tracking.DueDate);
            //                    if (!isNaN(dateObj.getTime())) {
            //                        var day = String(dateObj.getDate()).padStart(2, '0');
            //                        var month = String(dateObj.getMonth() + 1).padStart(2, '0');
            //                        var year = dateObj.getFullYear();
            //                        var formattedDate = day + '/' + month + '/' + year;
            //                        $('#trackingDueDate').val(formattedDate);
            //                    }
            //                } catch (e) {
            //                    $('#trackingDueDate').val(tracking.DueDate);
            //                }
            //            }
            //            if (tracking.IsComplete === '1' || tracking.IsComplete === 1) {
            //                $('#chkFlagComplete').prop('checked', true);
            //                $('#btnClearFlag').hide();
            //            } else {
            //                $('#chkFlagComplete').prop('checked', false);
            //                if (tracking.UniqueID && tracking.UniqueID !== 0) {
            //                    $('#btnClearFlag').show();
            //                }
            //            }
            //        }
            //    }
            //}

            function SaveTrackingDetails() {
                //debugger
                // Validate required fields
                var flagTo = $('#cboFlagTo').val();
                var dueDate = $('#trackingDueDate').val();

                if (!flagTo || flagTo === '-1' || flagTo === 'Select Flag To') {
                    //$('#trackingFlagToError').show();
                    alertify.error('<%=MyBase.GetResourceString("A_Flagtonotblank")%>');
                    $('#cboFlagTo').focus();
                    return;
                } else {
                    $('#trackingFlagToError').hide();
                }

                if (!dueDate || dueDate.trim() === '') {
                    $('#trackingDueDateError').show();
                    $('#trackingDueDate').focus();
                    return;
                } else {
                    $('#trackingDueDateError').hide();
                }

                var contextID = $('#hdnTrackingContextID').val();
                var contextType = $('#hdnTrackingContextType').val();
                var projectID = $('#hdnTrackingProjectID').val();
                var uniqueID = $('#hdnTrackingUniqueID').val();
                var isComplete = $('#chkFlagComplete').is(':checked') ? 1 : 0;

                // Convert date to proper format for API (MM/DD/YYYY or YYYY-MM-DD)
                var dueDate = $('#trackingDueDate').val(); // "13/01/2026"
                var dateParts = dueDate.split('/'); // ["13","01","2026"]

                // JS date 
                var jsDate = new Date(dateParts[2], dateParts[1] - 1, dateParts[0]); // month 0-based

                if (isNaN(jsDate.getTime())) {
                    //alert('Invalid due date');
                    return;
                }

                // SQL Server friendly format
                var sqlDate = jsDate.getFullYear() + '-' +
                    String(jsDate.getMonth() + 1).padStart(2, '0') + '-' +
                    String(jsDate.getDate()).padStart(2, '0');
                //sqlDate = "2026-01-13";
                // Save based on context type
                var saveParams = {
                    EmployeeID: EmployeeID,
                    Type: contextType,
                    ContextID: contextID,
                    ProjectID: projectID,
                    FlagTo: flagTo,
                    DueDate: sqlDate,
                    IsComplete: $('#chkFlagComplete').is(':checked')
                };
                var param = JSON.stringify(saveParams);
                var result = AJAXCallWithResult("/api/MyAlerts/SaveMyAlertsTrackingDetails", param, false);

                if (result) {
                    // Check if the result indicates success
                    var isSuccess = false;
                    if (result.message === '1' || result.message === 'Tracking details saved successfully' || result === '1' || result === 'Success') {
                        isSuccess = true;
                    } else if (result.data && (result.data === '1' || result.data === 'Success')) {
                        isSuccess = true;
                    } else if (result && typeof result === 'string' && (result === '1' || result === 'Success')) {
                        isSuccess = true;
                    }

                    if (isSuccess) {
                        alertify.success('<%=MyBase.GetResourceString("A_trackingdtlssavedsuccess")%>');
                        GetMyAlerts(0);
                        //var offcanvasElement = document.getElementById('offcanvasTrackingDetails');
                        //var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                        //if (bsOffcanvas) {
                        //    bsOffcanvas.hide();
                        //}
                        //$('body').removeClass('offcanvas-open');
                    } else {
                        var errorMsg = result.message || result.data || result || 'Failed to save tracking details';
                        alertify.error(errorMsg);
                    }
                }
                <%--if (contextType === 'HelpDeskRequest' || contextType === 'HelpRequest') {
                    // For Help Desk Requests, use AJAXCallWithResult to call the API endpoint
                    //var saveParams = {
                    //    EmployeeID: EmployeeID,
                    //    Type: contextType,
                    //    ContextID: contextID,
                    //    ProjectID: projectID || '0',
                    //    FlagTo: flagTo,
                    //    DueDate: apiDate,
                    //    IsComplete: isComplete
                    //};
                    var saveParams = {
                        EmployeeID: EmployeeID,
                        Type: contextType,
                        ContextID: contextID,
                        ProjectID: projectID,
                        FlagTo: flagTo,
                        DueDate: sqlDate,
                        IsComplete: $('#chkFlagComplete').is(':checked')
                    };
                    var param = JSON.stringify(saveParams);
                    var result = AJAXCallWithResult("/api/MyAlerts/SaveMyAlertsTrackingDetails", param, false);

                    if (result) {
                        // Check if the result indicates success
                        var isSuccess = false;
                        if (result.message === '1' || result.message === 'Tracking details saved successfully' || result === '1' || result === 'Success') {
                            isSuccess = true;
                        } else if (result.data && (result.data === '1' || result.data === 'Success')) {
                            isSuccess = true;
                        } else if (result && typeof result === 'string' && (result === '1' || result === 'Success')) {
                            isSuccess = true;
                        }

                        if (isSuccess) {
                            alertify.success('<%=MyBase.GetResourceString("A_trackingdtlssavedsuccess")%>');
                        GetMyAlerts(0);
                        //var offcanvasElement = document.getElementById('offcanvasTrackingDetails');
                        //var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                        //if (bsOffcanvas) {
                        //    bsOffcanvas.hide();
                        //}
                        //$('body').removeClass('offcanvas-open');
                    } else {
                        var errorMsg = result.message || result.data || result || 'Failed to save tracking details';
                        alertify.error(errorMsg);
                    }
                } else {
                    alertify.error('<%=MyBase.GetResourceString("A_fldsavetrckngdtls")%>');
                }
            } else {
                // Use API endpoint for other context types
                var saveParams = {
                    UserID: EmployeeID,
                    ProjectID: parseInt(projectID) || 0,
                    IssueID: parseInt(contextID),
                    Flagg: 'Y',
                    FlagTo: flagTo,
                    DueDate: apiDate,
                    isComplete: isComplete
                };
                var param = JSON.stringify(saveParams);
                var result = AJAXCallWithResult("/api/PMDshBoard/SaveIssueFlagDetails", param, false);

                if (result) {
                    alertify.success('<%=MyBase.GetResourceString("A_trackingdtlssavedsuccess")%>');
                    // Reload alerts to reflect changes
                    GetMyAlerts(0);
                    // Close off-canvas
                    //var offcanvasElement = document.getElementById('offcanvasTrackingDetails');
                    //var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                    //if (bsOffcanvas) {
                    //    bsOffcanvas.hide();
                    //}
                    //$('body').removeClass('offcanvas-open');
                } else {
                    alertify.error('<%=MyBase.GetResourceString("A_fldsavetrckngdtls")%>');
                    }
                }--%>
            }

            <%--function ClearTrackingFlag() {

                var uniqueID = $('#hdnTrackingUniqueID').val();
                if (!uniqueID || uniqueID === '0') {
                    alertify.error('<%=MyBase.GetResourceString("A_Noflgtclr")%>');
                    return;
                }

                alertify.confirm('Are you sure you want to clear this flag?', function (e) {
                    if (e) {
                        // Clear flag using AJAXCallWithResult
                        //var parameter = {
                        //    uniqueID: uniqueID
                        //};
                        //var param = JSON.stringify(parameter);
                        //var result = AJAXCallWithResult("/api/MyAlerts/DeleteMyAlertsTrackingDetails", param, false);
                        var result = AJAXCallWithResult(
                            "/api/MyAlerts/DeleteMyAlertsTrackingDetails?uniqueID=" + uniqueID,
                            null,
                            false
                        );

                        //var result = "";

                        if (result) {
                            // Check if the result indicates success
                            var isSuccess = false;
                            if (result.Result === '1' || result.Result === 'Tracking details deleted successfully' || result === '1' || result === 'Success') {
                                isSuccess = true;
                            } else if (result.data && (result.data === '1' || result.data === 'Success')) {
                                isSuccess = true;
                            } else if (result && typeof result === 'string' && (result === '1' || result === 'Success')) {
                                isSuccess = true;
                            }

                            if (result.message === 'My Alerts Tracking Details') {
                                isSuccess = true;
                            }

                            if (isSuccess) {
                                alertify.success('Flag Cleared Successfully');
                                // Reload alerts to reflect changes
                                GetMyAlerts(0);
                                // Close off-canvas
                                var offcanvasElement = document.getElementById('offcanvasTrackingDetails');
                                var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                                if (bsOffcanvas) {
                                    bsOffcanvas.hide();
                                }
                                $('body').removeClass('offcanvas-open');
                            } else {
                                var errorMsg = result.message || result.data || result || 'Failed to clear flag';
                                alertify.error(errorMsg);
                            }
                        } else {
                            alertify.error('Failed to clear flag');
                        }
                    }
                });
            }--%>

            function ClearTrackingFlag() {
                
                var uniqueID = $('#hdnTrackingUniqueID').val();
                if (!uniqueID || uniqueID === '0') {
                    alertify.error('<%=MyBase.GetResourceString("A_Noflgtclr")%>');
                    return;
                }

                // Directly call API (no confirmation popup)
                var result = AJAXCallWithResult(
                    "/api/MyAlerts/DeleteMyAlertsTrackingDetails?uniqueID=" + uniqueID,
                    null,
                    false
                );

                if (result) {
                    var isSuccess = false;

                    if (result.Result === '1' ||
                        result.Result === 'Tracking details deleted successfully' ||
                        result === '1' ||
                        result === 'Success') {
                        isSuccess = true;
                    }
                    else if (result.data && (result.data === '1' || result.data === 'Success')) {
                        isSuccess = true;
                    }
                    else if (typeof result === 'string' && (result === '1' || result === 'Success')) {
                        isSuccess = true;
                    }
                    else if (result.message === 'My Alerts Tracking Details') {
                        isSuccess = true;
                    }

                    if (isSuccess) {
                        alertify.success('Flag Cleared Successfully');

                        // Refresh alerts list
                        GetMyAlerts(0);

                        // Close offcanvas
                        var offcanvasElement = document.getElementById('offcanvasTrackingDetails');
                        var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                        if (bsOffcanvas) {
                            bsOffcanvas.hide();
                        }

                        $('body').removeClass('offcanvas-open');
                    } else {
                        alertify.error(result.message || result.data || 'Failed to clear flag');
                    }
                } else {
                    alertify.error('Failed to clear flag');
                }
            }


            function allowTwoDigitPositiveNumberOnly(input) {
                // Remove anything that is not a digit
                input.value = input.value.replace(/[^0-9]/g, '');

                // Remove leading zeros
                //input.value = input.value.replace(/^0+/, '');

                // Limit to 2 digits
                if (input.value.length > 2) {
                    input.value = input.value.substring(0, 2);
                }
            }

            function allowThreeDigitPositiveNumberOnly(input) {
                // Remove anything that is not a digit
                input.value = input.value.replace(/[^0-9]/g, '');

                // Limit to 3 digits
                if (input.value.length > 3) {
                    input.value = input.value.substring(0, 3);
                }
            }


            $('#selectCustomersModal').on('hidden.bs.modal', function () {
                $("#txtCustomerFilter").val('');
            });

            $('#selectEmployeesModal').on('hidden.bs.modal', function () {
                $("#txtEmployeeFilter").val('');
            });
            //document.getElementById('offcanvasRequestDetails')
            //    .addEventListener('shown.bs.offcanvas', function () {
            //        loadRequestDetails();
            //    });

            //function loadRequestDetails() {
            //    alert('Offcanvas opened - loading request details');

            //}


            //AjaxCall Function
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
