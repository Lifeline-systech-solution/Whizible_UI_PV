<%@ Page Language="VB" AutoEventWireup="false" CodeBehind="PM_EarnedValueReports.aspx.vb" Inherits="PbNIT.PM_EarnedValueReports" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%CommonFunctions.General.PlotPageHeadTag("Earned Value Report")%>
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Earned Value Report</title>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2" />

    <style>
        .no-results{
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */
        }
        :root {
            --nav-primary: #486AC0;
            --nav-primary-dark: #3b5aa5;
            --nav-primary-light: #e7ecfa;
        }
        .filter-option-inner-inner{
            margin-top: -3px;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
/*        Added by Madhuri.K content 26-03-2026*/
        .bootstrap-select .dropdown-toggle .filter-option-inner-inner {
    margin-top: -5px;
}
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            color: #333;
            line-height: 1.6;
        }
        
        .bgwhite {
            font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .offcanvas-75 {
            width: 75% !important;
        }

        .earned-value-container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .ev-header {
            background: linear-gradient( 135deg, var(--nav-primary), var(--nav-primary-dark) );
            border-radius: 8px;
            padding: 16px 24px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }


        .bootstrap-select .dropdown-menu {
            max-height: 300px; /* restored height */
            overflow-y: auto;
            padding-top: 0 !important;
            margin-top: 0 !important;
        }

        .ev-filter-row {
            align-items: flex-start;
        }

        .bootstrap-select {
            width: 100% !important;
        }

            .bootstrap-select > .dropdown-toggle {
                width: 100%;
                height: 34px !important;
                min-height: 34px !important;
                font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
                padding-top: 0 !important;
                padding-bottom: 0 !important;
                line-height: 34px !important;
            }

            /* ===============================
   Bootstrap-select dropdown unify styles
   =============================== */

            .bootstrap-select .dropdown-menu {
                padding-top: 0;
                padding-bottom: 0;
                border-radius: 4px;
            }

                .bootstrap-select .dropdown-menu .dropdown-item {
                    font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
                    padding: 5px 10px !important;
                    color: #333 !important;
                }

                    /* Hover & active – SAME as normal select look */
                    .bootstrap-select .dropdown-menu .dropdown-item:hover,
                    .bootstrap-select .dropdown-menu .dropdown-item:focus {
                        background-color: #f5f5f5;
                        color: #333;
                    }

                    /* Selected item */
                    .bootstrap-select .dropdown-menu .dropdown-item.active,
                    .bootstrap-select .dropdown-menu .dropdown-item.active:hover {
                        background-color: #486AC0;
                        color: #fff;
                    }

            .bootstrap-select .dropdown-header {
                display: none !important;
            }

        .ev-header-content {
            display: flex;
            align-items: flex-start; /* was center */
            justify-content: flex-start;
        }

        .ev-header-left {
            display: flex;
            align-items: flex-start; /* align top */
            gap: 12px;
        }

        .main_acordian_panel {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

.WF_ApprHeading {
    color: #555;
    line-height: 1.5;
}

.ev-info-title {
    font-weight: 600;
    margin-bottom: 10px;
}

.ev-info-subtitle {
    font-weight: 600;
    margin-top: 15px;
}

.ev-info-content code {
    background: #f4f6f9;
    padding: 2px 6px;
    border-radius: 4px;
    font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
}

        .ev-header-title-group {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .ev-header-title {
            font-size: 20px; /* was 24px */
            font-weight: 600; /* same as My Profile */
            line-height: 1.3;
            margin: 0;
        }

        .ev-header-subtitle {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 400;
            opacity: 0.9;
            margin: 0;
        }

        .ev-header-right {
            display: flex;
            align-items: center;
        }

        /* Filter Section */
        .ev-filter-section {
            background: #ffffff;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .ev-filter-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            flex-wrap: wrap;
            align-items: flex-end;
        }

            .ev-filter-row:last-child {
                margin-bottom: 0;
            }

        .ev-filter-item {
            display: flex;
            flex-direction: column;
            flex: 1;
            min-width: 200px;
        }

            .ev-filter-item.hidden {
                display: none;
            }

        .ev-filter-label {
            font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
            color: #333;
            margin-bottom: 6px;
        }

        .ev-required {
            color: #e74c3c;
        }

        .ev-select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #333;
            background-color: #fff;
            cursor: pointer;
            transition: border-color 0.3s;
        }

            .ev-select:hover,
            .ev-date-input:hover {
                border-color: var(--nav-primary);
            }

        .ev-radio-group {
            display: flex;
            gap: 0;
            flex-wrap: wrap;
            margin-top: 8px;
            border-radius: 20px;
            overflow: hidden;
            background-color: #f5f5f5;
            padding: 2px;
        }

        .ev-radio-label {
            position: relative;
            display: inline-flex;
            align-items: center;
            cursor: pointer;
            font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
            margin: 0;
            gap: 6px;
            flex: 1;
            min-width: 0;
        }

            .ev-radio-label input[type="radio"] {
                position: absolute;
                opacity: 0;
                width: 0;
                height: 0;
                margin: 0;
                cursor: pointer;
            }

            .ev-radio-label span {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 6px;
                padding: 6px 12px;
                border: 1px solid #e0e0e0;
                border-radius: 14px;
                background-color: #ffffff;
                color: #666;
                transition: all 0.3s ease;
                white-space: nowrap;
                font-weight: 500;
                user-select: none;
                width: 100%;
                position: relative;
            }

                /* Radio button circle indicator */
                .ev-radio-label span::before {
                    content: '';
                    width: 16px;
                    height: 16px;
                    border-radius: 50%;
                    border: 2px solid #999;
                    background-color: transparent;
                    display: inline-block;
                    transition: all 0.3s ease;
                    flex-shrink: 0;
                }

            /* Unselected state - light gray with empty circle */
            .ev-radio-label span {
                background-color: #ffffff;
                border-color: #e0e0e0;
                color: #666;
            }

                .ev-radio-label span::before {
                    border-color: #999;
                    background-color: transparent;
                }

            /* Selected state - blue background with white filled circle */
            .ev-radio-label input[type="radio"]:checked + span {
                background-color: var(--nav-primary);
                border-color: var(--nav-primary);
                color: #fff;
            }

                .ev-radio-label input[type="radio"]:checked + span::before {
                    border-color: #ffffff;
                    background-color: #ffffff;
                }

            /* Hover state for unselected */
            .ev-radio-label:hover span {
                border-color: var(--nav-primary);
                color: var(--nav-primary);
            }

                .ev-radio-label:hover span::before {
                    border-color: var(--nav-primary);
                }

            /* Override hover for selected state */
            .ev-radio-label:hover input[type="radio"]:checked + span {
                background-color: var(--nav-primary);
                color: #ffffff;
                border-color: var(--nav-primary);
            }

                .ev-radio-label:hover input[type="radio"]:checked + span::before {
                    border-color: #ffffff;
                    background-color: #ffffff;
                }

            /* Focus state */
            .ev-radio-label input[type="radio"]:focus + span {
                outline: 2px solid rgba(41, 105, 243, 0.3);
                outline-offset: 2px;
            }

        .ev-date-range {
            flex: 0 0 180px;
        }

        .ev-date-input-wrapper {
            position: relative;
        }

        .ev-date-input {
            width: 100%;
            padding: 10px 35px 10px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #333;
            background-color: #fff;
            cursor: pointer;
            transition: border-color 0.3s;
        }

            .ev-select:focus,
            .ev-date-input:focus {
                outline: none;
                border-color: var(--nav-primary);
                box-shadow: 0 0 0 3px rgba(47, 95, 215, 0.15);
            }

        .ev-date-fixed {
            background-color: #f1f3f8;
            cursor: not-allowed;
        }

            .ev-date-fixed:focus {
                outline: none;
                box-shadow: none;
            }

        .ev-date-icon {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            pointer-events: none;
        }

        .ev-filter-button {
            flex: 0 0 auto;
            min-width: auto;
        }
        /* Correct stacking order */
        .offcanvas-backdrop {
            z-index: 1040 !important;
        }

        .offcanvas {
            z-index: 1050 !important;
        }

        /* Allow dropdown to escape filter section */
        .ev-filter-section {
            overflow: visible !important;
        }

        /* Keep layout safe */
        .ev-filter-row,
        .ev-filter-item {
            overflow: visible;
        }

        .ev-btn-primary {
            background-color: var(--nav-primary);
            color: #ffffff;
            border: none;
            border-radius: 4px;
            padding: 7px 16px;
            font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: background-color 0.3s, transform 0.2s;
            white-space: nowrap;
        }

            .ev-btn-primary:hover {
                background-color: var(--nav-primary-dark);
                transform: translateY(-1px);
            }

            .ev-btn-primary:active {
                transform: translateY(0);
            }

        /* KPI Cards Section */
        .ev-kpi-section {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 20px;
            min-width: 0;
        }

        .ev-kpi-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 16px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 12px;
            transition: transform 0.3s, box-shadow 0.3s;
            min-width: 0;
            overflow: hidden;
        }

            .ev-kpi-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }

        .ev-kpi-icon {
            width: 42px;
            height: 42px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }

        .ev-kpi-icon-pv {
            background-color: var(--nav-primary-light);
            color: var(--nav-primary);
        }

        .ev-kpi-icon-ev {
            background-color: #e8f5e9;
            color: #388e3c;
        }

        .ev-kpi-icon-ac {
            background-color: #fff3e0;
            color: #f57c00;
        }

        .ev-kpi-icon-cpi {
            background-color: #fde7eb;
            color: var(--nav-primary);
        }

        .ev-kpi-content {
            flex: 1;
        }

        .ev-kpi-value {
            font-size: 14px;
            /* Modified By Madhuri.K On 01-04-2026 */
            font-weight: 600;
            color: #333;
            margin-bottom: 3px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .ev-kpi-label {
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */

            color: #666;
        }

        /* Main Content Section */
        .ev-main-content {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        /* Chart Section */
        .ev-chart-section {
            width: 100%;
        }

        /*.ev-chart-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            height: 100%;
        }*/

        .ev-chart-title {
            font-size: 14px;
            /* Modified By Madhuri.K On 01-04-2026 */
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
        }

        /* Main page chart card */
        .ev-main-content .ev-chart-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        /* Main page chart — plain fixed height, not affected by offcanvas */
        .ev-main-content .ev-chart-container {
            position: relative;
            height: 340px;
        }

        /* Offcanvas Styles — mirrors main project-header */
        .ev-offcanvas-header {
            background-color: #e7edf0;
            border-bottom: 1px solid #e9ecef;
            padding: 10px 14px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: nowrap;
            gap: 12px;
            min-height: 52px;
        }

        /* Chart-aligned colors */
        .ev-pv {
            color: #2969f3 !important;
        }

        .ev-ev {
            color: #4caf50 !important;
        }

        .ev-ac {
            color: #ff9800 !important;
        }

        .ev-total {
            color: #9e9e9e !important;
        }

        /* Default text (fallback) */
        .ev-default {
            color: #000 !important;
        }

        .ev-offcanvas-header-left {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex: 1;
            gap: 16px;
            min-width: 0;
        }

        .ev-offcanvas-title-group {
            display: flex;
            flex-direction: column;
            gap: 1px;
            flex: 1;
            min-width: 0;
        }

        .ev-offcanvas-title {
            font-size: 14px;
            font-weight: 600;
            color: #1e40af;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 6px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .ev-offcanvas-project-info {
            font-size: 11.5px;
            color: #666;
        }

        .ev-offcanvas-header-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: nowrap;
            align-items: center;
            flex-shrink: 0;
        }

        .ev-offcanvas-btn {
            background-color: #f5f5f5;
            color: #333;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 5px 10px;
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: background-color 0.3s, border-color 0.3s;
            white-space: nowrap;
        }

            .ev-offcanvas-btn:hover {
                background-color: #eeeeee;
                border-color: var(--nav-primary);
                color: var(--nav-primary);
            }

        .ev-offcanvas-header .btn-close {
            flex-shrink: 0;
            margin-left: 4px;
            align-self: center;
        }

        .ev-offcanvas-body {
            padding: 16px 20px;
            background-color: #f5f5f5;
            overflow-y: auto;
            overflow-x: hidden;
            /* height is set dynamically by syncEVLayout() */
            height: calc(100dvh - 52px);
            box-sizing: border-box;
        }

        .ev-offcanvas-main-content {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 16px;
            margin-bottom: 16px;
            align-items: start;
        }
        /* Chart Section (offcanvas) */
        .ev-chart-section {
            width: 100%;
        }

        .ev-chart-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 16px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            box-sizing: border-box;
        }

        .ev-chart-title {
            font-size: 14px;
            font-weight: 600;
            color: #333;
            margin-bottom: 12px;
            flex-shrink: 0;
        }

        /* Offcanvas chart container — height via CSS var, width from grid column */
        .ev-chart-container {
            position: relative;
            height: var(--ev-chart-h, 380px);
            width: 100%;
            overflow: hidden;
        }

        /* Force canvas to never exceed its container width */
        #earnedValueOffcanvas canvas {
            max-width: 100% !important;
            width: 100% !important;
        }

        .ev-no-data-label {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */
            font-weight: 600;
            color: #888;
            display: none;          /* hidden by default */
            pointer-events: none;  /* clicks pass through */
        }

        /* EV Details Section */
        .ev-details-section {
            width: 100%;
        }

        .ev-details-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 14px 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            /* height matches chart card, set by JS */
            height: var(--ev-chart-h, 380px);
            box-sizing: border-box;
        }

        .ev-details-title {
            font-size: 14px;
            /* Modified By Madhuri.K On 01-04-2026 */
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
            flex-shrink: 0;
        }

        .ev-details-list-wrapper {
            overflow-y: auto;
            flex: 1;
            min-height: 0;
            /* thin custom scrollbar */
            scrollbar-width: thin;
            scrollbar-color: #c1c9d6 transparent;
        }

        .ev-details-list-wrapper::-webkit-scrollbar {
            width: 4px;
        }

        .ev-details-list-wrapper::-webkit-scrollbar-track {
            background: transparent;
        }

        .ev-details-list-wrapper::-webkit-scrollbar-thumb {
            background-color: #c1c9d6;
            border-radius: 4px;
        }

        .ev-details-list {
            display: flex;
            flex-direction: column;
            gap: 0;
        }

        .ev-details-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 5px 0;
            gap: 8px;
            border-bottom: 1px solid #eee;
        }

            .ev-details-item:last-child {
                border-bottom: none;
                padding-bottom: 0;
            }

        .ev-details-label {
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */
            color: #666;
            flex: 1;
        }

        .ev-details-value {
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */
            font-weight: 600;
            color: #333;
        }

        .ev-value-orange {
            color: #f57c00;
        }

        .ev-value-red {
            color: #e74c3c;
        }
        
        /* Project Status Section */
        .ev-status-section {
            margin-bottom: 20px;
        }

        .ev-status-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: flex-start;
            gap: 15px;
        }

        .ev-status-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }

        .ev-status-icon-info {
            background-color: #e3f2fd;
            color: #1976d2;
        }

        .ev-status-content {
            flex: 1;
        }

        .ev-status-text {
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */
            color: #333;
            line-height: 1.5;
        }

        .ev-status-highlight {
            font-weight: 600;
        }

        .ev-status-orange {
            color: #f57c00;
        }

        /* Possible Causes Section */
        .ev-causes-section {
            margin-bottom: 20px;
        }

        .ev-causes-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: flex-start;
            gap: 15px;
        }

        .ev-causes-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }

        .ev-causes-icon-warning {
            background-color: #fff3e0;
            color: #f57c00;
        }

        .ev-causes-content {
            flex: 1;
        }

        .ev-causes-title {
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }

        .ev-causes-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

            .ev-causes-list li {
                font-size: 11.5px;
                /* Modified By Madhuri.K On 01-04-2026 */
                color: #666;
                padding: 5px 0;
                padding-left: 16px;
                position: relative;
                line-height: 1.5;
            }

                .ev-causes-list li:before {
                    content: "•";
                    position: absolute;
                    left: 0;
                    color: #f57c00;
                    font-weight: bold;
                    font-size: 14px;
                }

        /* Recommended Actions Section */
        .ev-actions-section {
            margin-bottom: 20px;
        }

        .ev-actions-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: flex-start;
            gap: 15px;
        }

        .ev-actions-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }

        .ev-actions-icon-success {
            background-color: #e8f5e9;
            color: #388e3c;
        }

        .ev-actions-content {
            flex: 1;
        }

        .ev-actions-title {
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }

        .ev-actions-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

            .ev-actions-list li {
                font-size: 11.5px;
                /* Modified By Madhuri.K On 01-04-2026 */
                color: #666;
                padding: 5px 0;
                padding-left: 16px;
                position: relative;
                line-height: 1.5;
            }

                .ev-actions-list li:before {
                    content: "•";
                    position: absolute;
                    left: 0;
                    color: #388e3c;
                    font-weight: bold;
                    font-size: 14px;
                }

        /* Offcanvas Specific Adjustments */
        .offcanvas {
            max-width: 90%;
            overflow: hidden !important;
            z-index: 1100;
        }

        .offcanvas-body {
            overflow-y: auto;
        }

        @media (min-width: 1200px) {
            .offcanvas {
                max-width: 1200px;
            }
        }

        @media (max-width: 1024px) {
            .ev-offcanvas-main-content {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .ev-offcanvas-header {
                padding: 15px 20px;
            }

            .ev-offcanvas-body {
                padding: 15px 20px;
            }

            .ev-offcanvas-header-left {
                flex-direction: column;
                width: 100%;
            }

            .ev-offcanvas-header-buttons {
                width: 100%;
                margin-top: 15px;
            }

            .ev-offcanvas-btn {
                flex: 1;
                justify-content: center;
            }

            .ev-chart-container {
                min-height: 220px;
            }
        }

        .pageHeading {
            color: #1e40af;
            font-weight: 600;
            font-size: 16px; /* Modified By Madhuri.K On 26-03-2026 */
            margin: 0 0 0.25rem 0;
            display: flex;
            align-items: center;
        }

        .project-header {
            /*background-color: #e7edf0;*/
            padding: 12px 14px;
            margin-bottom: 0;
            display: flex;
            align-items: flex-start;
            border-bottom: 1px solid #e9ecef;
            margin: 0px;
        }

       .project-header .small {
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */
       }
        /* ===============================
   Unified dropdown hover color
   =============================== */

        /* Bootstrap-select dropdown items */
        .bootstrap-select .dropdown-menu .dropdown-item:hover,
        .bootstrap-select .dropdown-menu .dropdown-item:focus {
            background-color: rgb(225, 227, 233) !important;
            color: #333 !important;
        }

        /* Active item hover (keyboard / mouse) */
        .bootstrap-select .dropdown-menu .dropdown-item.active:hover,
        .bootstrap-select .dropdown-menu .dropdown-item.active:focus {
            background-color: rgb(225, 227, 233) !important;
            color: #333 !important;
        }

        /* Normal HTML select (fallback – browser driven) */
        .ev-select option:hover {
            background-color: rgb(225, 227, 233);
        }

        /* ── Base 11px for all filter + offcanvas body text ── */
        .ev-filter-section,
        .ev-offcanvas-body,
        .ev-offcanvas-header {
            font-size: 11.5px !important;
            /* Modified By Madhuri.K On 01-04-2026 */
        }

        /* Ensure datepicker inputs are 11px — !important beats Bootstrap */
        .ev-filter-section .form-control,
        .ev-filter-section input[type="text"],
        .ev-filter-section input[type="date"],
        .ev-filter-section input,
        .ev-filter-section select {
            font-size: 11.5px !important;
            /* Modified By Madhuri.K On 01-04-2026 */
            height: 34px !important;
        }

        /* bootstrap-select search box inside dropdown */
        .bootstrap-select .bs-searchbox .form-control {
            font-size: 11.5px !important;
            /* Modified By Madhuri.K On 01-04-2026 */
            height: 28px !important;
        }

        /* calendar button and all .btn inside filter section */
        .ev-filter-section .input-group .btn,
        .ev-filter-section .input-group-btn .btn,
        .ev-filter-section .btncalendar {
            height: 34px !important;
            padding-top: 0 !important;
            padding-bottom: 0 !important;
            font-size: 11.5px !important;
            /* Modified By Madhuri.K On 01-04-2026 */
            line-height: 34px !important;
        }

        /* KPI cards — prevent any wrapping at narrow viewport */
        .ev-kpi-section {
            overflow-x: auto;
        }

        .ev-kpi-card .ev-kpi-content {
            min-width: 0;
        }

        /* Close button aligned with report buttons */
        .ev-close-btn {
            opacity: 0.6;
            transition: opacity 0.15s ease;
            align-self: center;
        }

        .ev-close-btn:hover {
            opacity: 1;
        }

        /* Offcanvas header responsive — stack on narrow panels */
        @media (max-width: 600px) {
            .ev-offcanvas-header {
                flex-wrap: wrap;
            }

            .ev-offcanvas-header-buttons {
                flex-wrap: wrap;
                width: 100%;
            }
        }
    
    /* Loader overlay — matches PM_ReportUIBuilder / PM_ProjectProfitability */
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

    /* Centered loader GIF inside overlay */
    .loader-overlay .loader {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 100px;
        height: 100px;
        margin: -50px 0 0 -50px;
        background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
    }
</style>
</head>
<body class="hold-transition bgwhite sidebar-mini fixed">
    <!-- Page Loader — matches PM_ReportUIBuilder style -->
    <div class="loader-overlay" id="pageLoader" style="display: none;">
        <div class="loader"></div>
    </div>
    <%If m_blnViewAccess = True Then%>
    <div class="earned-value-container" id="ProjProfWrapper" style="display: none;">
        <!-- Header Section -->
        <div class="graybg project-header">
            <div>
                <h2 class="pageHeading">
                    <i class="fas fa-chart-line ev-header-icon pe-2"></i>
                    <%=MyBase.GetResourceString("C_PageHeader")%>
                </h2>
                <p class="ev-header-subtitle"><%=MyBase.GetResourceString("C_PageSubtitle")%></p>
            </div>
        </div>

<!-- Hide / Show link -->
<div class="d-flex">
    <a href="javascript:;"
       id="showWFApprSecBtn"
       class="textUndrln ms-auto"
       data-bs-toggle="collapse"
       data-bs-target="#WF_ApprDetailsTab"
       aria-expanded="false">
       Show Details
    </a>
</div>
        <!-- Workflow Approval Info Section -->
<div class="container-fluid mt-2 mb-3">
    <div class="accordion main_acordian_panel" id="WF_ApprAcc">
        <div class="accordion-item">
            <div id="WF_ApprDetailsTab"
                 class="accordion-collapse collapse"
                 data-bs-parent="#WF_ApprAcc">
                <div class="accordion-body p-0">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col-12 WF_ApprHeading">
                                <div class="ev-info-content font-12">

    <h5 class="ev-info-title">Earned Value Analysis</h5>

    <p>
        <strong>Earned Value Analysis</strong> is an industry standard technique used to measure project progress,
        forecast the project’s date of completion along with its final cost, and provide schedule and budget
        variances throughout the project lifecycle.
    </p>

    <p>
        Earned Value provides an objective measurement of how much work has been accomplished on a project.
        Using the Earned Value process, management can readily compare how much work has actually been completed
        against the amount of work planned to be accomplished.
    </p>

    <p>
        The attributes of Earned Value are threefold.
    </p>

    <p>
        Whizible SEM allows for the calculation of Earned Value at various levels of the project. Accordingly,
        Earned Value can be calculated on completion of a Phase, Subproject, Deliverable, Milestone, or Module.
    </p>

    <p>
        The common terminologies in Earned Value computation are as follows.
    </p>

    <hr />

    <h6 class="ev-info-subtitle">Primary Parameters of Earned Value Analysis</h6>

    <p>The three primary parameters of the Earned Value Analysis Report are:</p>

    <ol>
        <li>
            <strong>BCWS – Budgeted Cost of Work Scheduled (Planned Value – PV)</strong><br />
            Total Budgeted Man Days / Planned Value
        </li>
        <li>
            <strong>ACWP – Actual Cost of Work Performed (Actual Cost – AC)</strong>
        </li>
        <li>
            <strong>BCWP – Budgeted Cost of Work Performed (Earned Value – EV)</strong>
        </li>
    </ol>

    <p>Based on these three parameters, the following values are calculated:</p>

    <ol>
        <li>CV – Cost Variance</li>
        <li>SV – Schedule Variance</li>
        <li>CPI – Cost Performance Index</li>
        <li>SPI – Schedule Performance Index</li>
        <li>ETC – Estimate to Complete</li>
        <li>EAC – Estimate at Completion</li>
    </ol>

    <hr />

    <h6 class="ev-info-subtitle">Earned Value Terminologies and Definitions</h6>

    <p>
        <strong>1. Total Budgeted Man Days:</strong><br />
        The Total Budgeted Man Days stands for BCWS and refers to the total effort planned for the completion of
        the project or project phase for which Earned Value is being computed.
    </p>

    <p>
        <strong>2. BCWS – Budgeted Cost of Work Scheduled:</strong><br />
        The budget represents the approved estimated cost planned to be spent on the project during a given
        period of time.
        <br />
        <em>(Total Planned Effort / Work Hours / LCE of Project)</em>
    </p>

    <p>
        <strong>3. ACWP – Actual Cost of Work Performed:</strong><br />
        The total of direct costs incurred in performing work during a given period.
        <br />
        <em>(Actual hours spent on completed deliverables or tasks by project resources during the given period)</em>
    </p>

    <p>
        <strong>4. BCWP – Budgeted Cost of Work Performed (Earned Value):</strong><br />
        Represents the portion of the total budget corresponding to the work actually completed.
        <br />
        <em>(Total planned hours for completed tasks or deliverables during the given period)</em>
    </p>

    <hr />

    <h6 class="ev-info-subtitle">Earned Value Performance Metrics</h6>

    <p>
        <strong>5. CV – Cost Variance:</strong><br />
        <code>CV = BCWP (Earned Value) – ACWP (Actual Cost)</code><br />
        Positive CV indicates work completed at lower cost than planned.<br />
        Negative CV indicates work completed at higher cost than planned.
    </p>

    <p>
        <strong>6. SV – Schedule Variance:</strong><br />
        <code>SV = BCWP (Earned Value) – BCWS (Planned Value)</code><br />
        Positive SV indicates work ahead of schedule.<br />
        Negative SV indicates work behind schedule.
    </p>

    <p>
        <strong>7. CPI – Cost Performance Index:</strong><br />
        <code>CPI = BCWP / ACWP</code><br />
        CPI greater than 1 indicates cost underrun.<br />
        CPI less than 1 indicates cost overrun.
    </p>

    <p>
        <strong>8. SPI – Schedule Performance Index:</strong><br />
        <code>SPI = BCWP / BCWS</code><br />
        SPI greater than 1 indicates ahead of schedule.<br />
        SPI less than 1 indicates behind schedule.
    </p>

    <p>
        <strong>9. ETC – Estimate to Complete:</strong><br />
        <code>ETC = (BCWS – BCWP) / CPI</code>
    </p>

    <p>
        <strong>10. EAC – Estimate at Completion:</strong><br />
        <code>EAC = ETC + ACWP</code>
    </p>

</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


        <!-- Filter Section -->
        <div class="ev-filter-section">
            <div class="ev-filter-row">
                <div class="ev-filter-item" id="projectSelectContainer">
                    <label class="ev-filter-label">
                        <%=MyBase.GetResourceString("C_SelProj")%> <span class="ev-required">*</span>
                    </label>
                    <div class="bs-wrapper">
                        <%CommonFunctions.HTMLControls.DrawComboBox("projectSelect", "usp_Whizible2_Sel_Project_For_DA_Active_InActive_Projects_ForEarnValueReport " & Session("intUserID"), 0, If(Session("intProjectID") Is Nothing, "0", Session("intProjectID").ToString()), "Select Project", False, False, "'selectpicker' data-live-search='true'", False, "../../Images/Star.gif", False, -1)%>
                    </div>
                </div>
                <div class="ev-filter-item">
                    <label class="ev-filter-label"><%=MyBase.GetResourceString("C_FilterBy")%></label>
                    <div class="ev-radio-group">
                        <label class="ev-radio-label">
                            <input type="radio" name="filterBy" value="phase" checked>
                            <span><%=MyBase.GetResourceString("C_Phase")%></span>

                        </label>
                        <label class="ev-radio-label">
                            <input type="radio" name="filterBy" value="subproject">
                            <span><%=MyBase.GetResourceString("C_Subproject")%></span>

                        </label>
                        <label class="ev-radio-label">
                            <input type="radio" name="filterBy" value="deliverable">
                            <span><%=MyBase.GetResourceString("C_Deliverable")%></span>

                        </label>
                        <label class="ev-radio-label">
                            <input type="radio" name="filterBy" value="module">
                            <span><%=MyBase.GetResourceString("C_Module")%></span>

                        </label>
                        <label class="ev-radio-label">
                            <input type="radio" name="filterBy" value="milestone">
                            <span><%=MyBase.GetResourceString("C_Milestone")%></span>
                        </label>
                    </div>
                </div>
            </div>
            <div class="ev-filter-row">
                <div class="ev-filter-item hidden" id="phaseSelectContainer">
                    <label class="ev-filter-label">Select Phase</label>
                    <select class="selectpicker" data-live-search="true" id="phaseSelect">
                        <option value="0">Select Phase</option>
                    </select>
                </div>

                <div class="ev-filter-item hidden" id="subprojectSelectContainer">
                    <label class="ev-filter-label">Select Subproject</label>
                    <select class="selectpicker" data-live-search="true" id="subprojectSelect">
                        <option value=""></option>
                    </select>
                </div>

                <div class="ev-filter-item hidden" id="deliverableSelectContainer">
                    <label class="ev-filter-label">Select Deliverable</label>
                    <select class="selectpicker" data-live-search="true" id="deliverableSelect">
                        <option value=""></option>
                    </select>
                </div>

                <div class="ev-filter-item hidden" id="moduleSelectContainer">
                    <label class="ev-filter-label">Select Module</label>
                    <select class="selectpicker" data-live-search="true" id="moduleSelect">
                        <option value="0">Select Module</option>
                    </select>
                </div>

                <div class="ev-filter-item hidden" id="milestoneSelectContainer">
                    <label class="ev-filter-label">Select Milestone</label>
                    <select class="selectpicker" data-live-search="true" id="milestoneSelect">
                        <option value="0">Select Milestone</option>
                    </select>
                </div>
                <div class="ev-filter-item ev-date-range">
                    <label class="ev-filter-label"><%=MyBase.GetResourceString("C_FromDate")%></label>

                    <div class="input-group ev-date-input-wrapper">
                        <% CommonFunctions.HTMLControls.DrawTextBox("txtALExpectedStartDate", "fromDate", "form-control ev-date-fixed", , ,,,, , True,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>

                        <span class="input-group-btn">
                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                        </span>
                    </div>
                </div>
                <div class="ev-filter-item ev-date-range">
                    <label class="ev-filter-label"><%=MyBase.GetResourceString("C_ToDate")%></label>

                    <div class="input-group ev-date-input-wrapper">
                        <% CommonFunctions.HTMLControls.DrawTextBox("txtALExpectedEndDate", "toDate", "form-control", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>

                        <span class="input-group-btn">
                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                        </span>
                    </div>
                </div>

                <div class="ev-filter-item ev-filter-button">
                    <button class="ev-btn-primary" id="showEarnedValueBtn">
                        <%=MyBase.GetResourceString("C_ShowEarnedValue")%> <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- KPI Cards Section -->
        <div class="ev-kpi-section">
            <div class="ev-kpi-card">
                <div class="ev-kpi-icon ev-kpi-icon-pv">
                    <i class="fas fa-bullseye"></i>
                </div>
                <div class="ev-kpi-content">
                    <div class="ev-kpi-value" id="pvValue"></div>
                    <div class="ev-kpi-label"><%=MyBase.GetResourceString("C_PlannedValue")%></div>
                </div>
            </div>

            <div class="ev-kpi-card">
                <div class="ev-kpi-icon ev-kpi-icon-ev">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="ev-kpi-content">
                    <div class="ev-kpi-value" id="evValue"></div>
                    <div class="ev-kpi-label"><%=MyBase.GetResourceString("C_EarnedValue")%></div>
                </div>
            </div>

            <div class="ev-kpi-card">
                <div class="ev-kpi-icon ev-kpi-icon-ac">
                    <span id="currencySymbol" class="ev-currency-symbol"> </span>
                </div>
                <div class="ev-kpi-content">
                    <div class="ev-kpi-value" id="acValue"></div>
                    <div class="ev-kpi-label"><%=MyBase.GetResourceString("C_ActualCost")%></div>
                </div>
            </div>

            <div class="ev-kpi-card">
                <div class="ev-kpi-icon ev-kpi-icon-cpi">
                    <i class="fas fa-arrow-down" id="cpiArrow"></i>
                </div>
                <div class="ev-kpi-content">
                    <div class="ev-kpi-value" id="cpiValue"></div>
                    <div class="ev-kpi-label"><%=MyBase.GetResourceString("C_CostPerformance")%></div>
                </div>
            </div>
        </div>

        <!-- Main Content Section -->
        <div class="ev-main-content">
            <!-- Chart Section -->
            <div class="ev-chart-section">
                <div class="ev-chart-card">
                    <h2 class="ev-chart-title"><%=MyBase.GetResourceString("C_EarnedValueAnalysis")%></h2>
                    <div class="ev-chart-container">
                        <canvas id="earnedValueChartMain"></canvas>
                         <div id="evNoDataLabelMain" class="ev-no-data-label">
                            No Data Available
                         </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Offcanvas -->
    <div class="offcanvas offcanvas-end offcanvas-75" tabindex="-1" id="earnedValueOffcanvas" aria-labelledby="earnedValueOffcanvasLabel">
        <div class="offcanvas-header ev-offcanvas-header">
            <div class="ev-offcanvas-header-left">
                <div class="ev-offcanvas-title-group">
                    <h2 class="ev-offcanvas-title" id="earnedValueOffcanvasLabel">
                        <i class="fas fa-chart-line ev-header-icon pe-1"></i>
                        <%=MyBase.GetResourceString("C_PageHeader")%>
                    </h2>
                    <span class="ev-offcanvas-project-info" id="offcanvasProjectInfo">Sonata T&M Customization 2025-26 • Apr 2025 - Mar 2026</span>
                </div>
                <div class="ev-offcanvas-header-buttons">

    <!-- Summary Dropdown -->
    <div class="dropdown d-inline-block">
        <button class="ev-offcanvas-btn dropdown-toggle" type="button"
                id="btnEVSummary" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-file-alt"></i>
            <%=MyBase.GetResourceString("C_WeeklySummaryReport")%>
        </button>
        <ul class="dropdown-menu">
            <li>
                <a class="dropdown-item ev-summary-download" data-format="excel" href="#">
                    <i class="fas fa-file-excel text-success"></i> Excel
                </a>
            </li>
            <li>
                <a class="dropdown-item ev-summary-download" data-format="pdf" href="#">
                    <i class="fas fa-file-pdf text-danger"></i> PDF
                </a>
            </li>
        </ul>
    </div>

    <!-- Details Dropdown -->
    <div class="dropdown d-inline-block">
        <button class="ev-offcanvas-btn dropdown-toggle" type="button"
                id="btnEVDetails" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-file-invoice"></i>
            <%=MyBase.GetResourceString("C_WeeklyDetailsReport")%>
        </button>
        <ul class="dropdown-menu">
            <li>
                <a class="dropdown-item ev-details-download" data-format="excel" href="#">
                    <i class="fas fa-file-excel text-success"></i> Excel
                </a>
            </li>
            <li>
                <a class="dropdown-item ev-details-download" data-format="pdf" href="#">
                    <i class="fas fa-file-pdf text-danger"></i> PDF
                </a>
            </li>
        </ul>
    </div>

    <!-- Close button — sits flush next to report buttons -->
    <button type="button" class="btn-close ev-close-btn" data-bs-dismiss="offcanvas" aria-label="Close"></button>

</div>

            </div>
        </div>
        <div class="offcanvas-body ev-offcanvas-body">
            <!-- Main Content -->
            <div class="ev-offcanvas-main-content">
                <!-- Chart Section -->
                <div class="ev-chart-section">
                    <div class="ev-chart-card">
                        <h2 class="ev-chart-title"><%=MyBase.GetResourceString("C_EarnedValueAnalysis")%></h2>
                        <div class="ev-chart-container">
                            <canvas id="earnedValueChart"></canvas>
                            <div id="evNoDataLabel" class="ev-no-data-label">
                                No Data Available
                            </div>
                        </div>
                    </div>
                </div>

                <!-- EV Details Section -->
                <div class="ev-details-section">
                    <div class="ev-details-card">
                        <h2 class="ev-details-title"><%=MyBase.GetResourceString("C_EVDetails")%></h2>
                        <div class="ev-details-list-wrapper">
                            <div class="ev-details-list">
                                <div class="ev-details-item">
                                    <span class="ev-details-label budgeted-mandays"><%=MyBase.GetResourceString("C_TotalBudgetedMandays")%></span>
                                    <span class="ev-details-value" id="lblTotalMandays"></span>
                                </div>
                                <div class="ev-details-item">
                                    <span class="ev-details-label"><%=MyBase.GetResourceString("C_PV")%></span>
                                    <span class="ev-details-value" id="lblPV"></span>
                                </div>
                                <div class="ev-details-item">
                                    <span class="ev-details-label"><%=MyBase.GetResourceString("C_EV")%></span>
                                    <span class="ev-details-value" id="lblEV"></span>
                                </div>
                                <div class="ev-details-item">
                                    <span class="ev-details-label"><%=MyBase.GetResourceString("C_AC")%></span>
                                    <span class="ev-details-value" id="lblAC"></span>
                                </div>
                                <div class="ev-details-item">
                                    <span class="ev-details-label"><%=MyBase.GetResourceString("C_CPI")%></span>
                                    <span class="ev-details-value ev-value-orange" id="lblCPI"></span>
                                </div>
                                <div class="ev-details-item">
                                    <span class="ev-details-label"><%=MyBase.GetResourceString("C_CV")%></span>
                                    <span class="ev-details-value ev-value-red" id="lblCV"></span>
                                </div>
                                <div class="ev-details-item">
                                    <span class="ev-details-label"><%=MyBase.GetResourceString("C_SPI")%></span>
                                    <span class="ev-details-value ev-value-red" id="lblSPI"></span>
                                </div>
                                <div class="ev-details-item">
                                    <span class="ev-details-label"><%=MyBase.GetResourceString("C_SV")%></span>
                                    <span class="ev-details-value ev-value-red" id="lblSV"></span>
                                </div>
                                <div class="ev-details-item">
                                    <span class="ev-details-label"><%=MyBase.GetResourceString("C_ETC")%></span>
                                    <span class="ev-details-value" id="lblETC"></span>
                                </div>
                                <div class="ev-details-item">
                                    <span class="ev-details-label"><%=MyBase.GetResourceString("C_EAC")%></span>
                                    <span class="ev-details-value" id="lblEAC"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Project Status Section -->
            <div class="ev-status-section">
                <div class="ev-status-card">
                    <div class="ev-status-icon ev-status-icon-info">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="ev-status-content">
                        <div class="ev-status-text" id="evStatusText"></div>
                    </div>
                </div>
            </div>

            <!-- Possible Causes Section -->
            <div class="ev-causes-section">
                <div class="ev-causes-card">
                    <div class="ev-causes-icon ev-causes-icon-warning">
                        <i class="fas fa-exclamation-circle"></i>
                    </div>
                    <div class="ev-causes-content">
                        <h3 class="ev-causes-title"><%=MyBase.GetResourceString("C_PCauses")%></h3>
                        <ul class="ev-causes-list" id="evCausesList"></ul>
                    </div>
                </div>
            </div>

            <!-- Recommended Actions Section -->
            <div class="ev-actions-section">
                <div class="ev-actions-card">
                    <div class="ev-actions-icon ev-actions-icon-success">
                        <i class="fas fa-lightbulb"></i>
                    </div>
                    <div class="ev-actions-content">
                        <h3 class="ev-actions-title"><%=MyBase.GetResourceString("C_RAction")%></h3>
                        <ul class="ev-actions-list" id="evActionsList"></ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;">You are not authorized to view this record.</p>
        </div>
    </div>
    <%End If %>
    <script src="../../../Whizible2.0-new/plugins/chartjs/chart.min.js"></script>
    <script type="text/javascript">
        var loggedInEmployeeID = <%= Session("intUserID") %>;
        var projectID = <%= Session("intProjectID") %>;
        var viewAccess = <%= m_blnViewAccess.ToString().ToLower() %>;
    </script>
    <script>
        // Earned Value Report JavaScript
        let earnedValueChart = null;
        let earnedValueChartMain = null;
        var strUrl = '<%=ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';

        // Initialize the page when DOM is ready
        $(document).ready(function () {
            $("#ProjProfSec").hide();
            $("#ProjProfWrapper").show();
            $('input[name="filterBy"]').prop('checked', false);
            $('input[name="filterBy"][value="phase"]').prop('checked', true);
            $("#currencySymbol").text(" ");
            applyFilterUI('phase');
            initEVDatePickers();
            if (viewAccess) {
                if (projectID && projectID > 0) {
                    loadProjectCurrencySymbol(projectID);
                    loadExpectedDatesByProject(projectID);
                    loadEVFilters(projectID, "phase");
                    loadEarnedValueReport();
                }
            }

        });

        function applyFilterUI(filterBy) {

            const containers = [
                '#phaseSelectContainer',
                '#subprojectSelectContainer',
                '#deliverableSelectContainer',
                '#moduleSelectContainer',
                '#milestoneSelectContainer'
            ];

            // Hide all
            $(containers.join(',')).addClass('hidden');

            const map = {
                phase: '#phaseSelectContainer',
                subproject: '#subprojectSelectContainer',
                deliverable: '#deliverableSelectContainer',
                module: '#moduleSelectContainer',
                milestone: '#milestoneSelectContainer'
            };

            if (map[filterBy]) {
                const container = $(map[filterBy]);
                container.removeClass('hidden');

                // 🔥 CRITICAL: force bootstrap-select to recalc UI
                container.find('.selectpicker')
                    .selectpicker('render')
                    .selectpicker('refresh');
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

                // ✅ SHOW loader before API call
                beforeSend: function (xhr) {
                    showLoader();
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    // Always add Params header for POST requests
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
                        alertify.notify('<%=MyBase.GetResourceString("A_AuthenticationFailed")%>', 'error', 5);
                    } else {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error;
                    }
                },

                complete: function () {
                    hideLoader();
                }
            });

            // For synchronous calls
            if (!async) {
                return result;
            }

            return result;
        }

        function showLoader() {
            document.getElementById('pageLoader').style.display = 'block';
            loaderShown = true;
            loaderStartTime = Date.now();
        }

        function hideLoader() {
            if (!loaderShown) return;

            var elapsedTime = Date.now() - loaderStartTime;
            var minDisplayTime = 1500;

            if (elapsedTime < minDisplayTime) {
                setTimeout(function () {
                    document.getElementById('pageLoader').style.display = 'none';
                    loaderShown = false;
                }, minDisplayTime - elapsedTime);
            } else {
                document.getElementById('pageLoader').style.display = 'none';
                loaderShown = false;
            }
        }

        function loadExpectedDatesByProject(projectID) {
            if (!projectID || projectID <= 0) {
                $("#fromDate").val("").attr("placeholder", "From Date");
                $("#toDate").val("").attr("placeholder", "To Date");
                return;
            }

            var request = {
                projectID: projectID
            };

            var response = AJAXCallWithResult(
                "api/PM_EarnedValueReport/GetExpectedDates",
                JSON.stringify(request),
                false
            );

            if (!response || !response.data || response.data.length === 0) {
                $("#fromDate").val("").attr("placeholder", "From Date");
                $("#toDate").val("").attr("placeholder", "To Date");
                return;
            }

            var expectedDates = response.data[0];

            $("#fromDate").datepicker("setDate",
                $.datepicker.parseDate("mm/dd/yy", expectedDates.expectedStartDate)
            );

            $("#toDate").datepicker("setDate",
                $.datepicker.parseDate("mm/dd/yy", expectedDates.expectedEndDate)
            );

        }

        function loadProjectCurrencySymbol(projectID) {

            if (!projectID || projectID <= 0) {
                $("#currencySymbol").text(" "); // fallback
                return;
            }
            var request = {
                projectID: projectID
            };
            var response = AJAXCallWithResult(
                "api/PM_EarnedValueReport/GetProjectCurrency",
                JSON.stringify(request),
                false
            );

            if (!response || !response.data) {
                $("#currencySymbol").text(" "); // fallback
                return;
            }

            $("#currencySymbol").text(response.data[0].currencySymbol);
        }

        function convertToISODate(dateStr) {
            // MM/dd/yyyy → yyyy-MM-dd (required by input[type=date])
            var parts = dateStr.split('/');
            return parts[2] + '-' + parts[0].padStart(2, '0') + '-' + parts[1].padStart(2, '0');
        }

        function onProjectChanged(projectID) {
            loadProjectCurrencySymbol(projectID);
            resetToPhase(projectID);
            loadExpectedDatesByProject(projectID);
            loadEarnedValueReport();
        }

        $(document).on('changed.bs.select', '#projectSelect', function (e, clickedIndex, isSelected, previousValue) {
            var projectID = parseInt($(this).val(), 10);
            if (projectID > 0) {
                onProjectChanged(projectID);
            } else{
                $("#currencySymbol").text(" ");
                resetToPhase(projectID);
                loadExpectedDatesByProject(projectID);
                loadEarnedValueReport();
            }
        });

        function resetToPhase(projectID) {
            $('input[name="filterBy"][value="phase"]').prop('checked', true);
            applyFilterUI("phase");
            resetAllDropdowns();
            loadEVFilters(projectID, "phase");
        }

        $('#WF_ApprDetailsTab')
            .on('shown.bs.collapse', function () {
                $('#showWFApprSecBtn').text('Hide');
            })
            .on('hidden.bs.collapse', function () {
                $('#showWFApprSecBtn').text('Show Details');
            });

        $('#showWFApprSecBtn').on('click', function () {
            const isExpanded = $(this).attr('aria-expanded') === 'true';
            $(this).text(isExpanded ? 'Show Details' : 'Hide');
        });

        $(document).on("change", 'input[name="filterBy"]', function () {

            var selectedFilter = $(this).val();
            var projectID = parseInt($("#projectSelect").val(), 10);

            if (!projectID || projectID <= 0) {    
                applyFilterUI(selectedFilter);
                resetAllDropdowns();
                loadEVFilters(projectID, selectedFilter);
                return;
            }
            applyFilterUI(selectedFilter);
            resetAllDropdowns();
            loadEVFilters(projectID, selectedFilter);
            loadExpectedDatesByProject(projectID);
            loadEarnedValueReport();
        });

        $('#fromDate, #toDate').on('change', function () {
            if (!validateDateRange()) return;
            loadEarnedValueReport();
        });

        $('#phaseSelect, #subprojectSelect, #deliverableSelect, #moduleSelect, #milestoneSelect')
            .on('change', function () {

                var projectID = parseInt($("#projectSelect").val());
                if (!projectID || projectID <= 0) return;

                var filterBy = $('input[name="filterBy"]:checked').val();
                var type = getFilterTypeValue(filterBy);
                var id = $(this).val();

                // ✅ FORCE bootstrap-select to show selected text
                $(this).selectpicker('val', id);
                $(this).selectpicker('refresh');
                if (Number(id) > 0) {
                    loadEVExpectedDates(projectID, type, id);
                } else {
                    loadExpectedDatesByProject(projectID);
                }
                loadEarnedValueReport();
            });

        function getFilterTypeValue(filterBy) {
            switch (filterBy) {
                case "phase": return 1;
                case "subproject": return 2;
                case "deliverable": return 5;
                case "module": return 3;
                case "milestone": return 4;
                default: return 1;
            }
        }

        function loadEVFilters(projectID, filterBy) {

            const ddl = $(getDropdownId(filterBy));
            const type = getFilterTypeValue(filterBy);

            if (!projectID || projectID <= 0) {
                switch (filterBy) {
                    case "phase": 
                        ddl.append(`<option value="0">Select Phase</option>`);
                        break;
                    case "subproject": 
                        ddl.append(`<option value="0">Select Subproject</option>`);
                        break;
                    case "deliverable": 
                        ddl.append(`<option value="0">Select Deliverable</option>`);
                        break;
                    case "module": 
                        ddl.append(`<option value="0">Select Module</option>`);
                        break;
                    case "milestone": 
                        ddl.append(`<option value="0">Select Milestone</option>`);
                        break;
                    default: 
                        ddl.append(`<option value="0">Select Phase</option>`);
                        break;
                }
                // Recreate picker
                ddl.selectpicker({
                liveSearch: true
                });

                // 🔥 FORCE UI update
                ddl.selectpicker('refresh');
                return;
            }
            // Destroy completely
            ddl.selectpicker('destroy');
            ddl.empty();

            const request = { projectID, type };

            const response = AJAXCallWithResult(
                "api/PM_EarnedValueReport/GetEVFiltersForEarnedValue",
                JSON.stringify(request),
                false
            );

            if (response?.data?.length) {
                response.data.forEach(item => {
                    ddl.append(`<option value="${item.id}">${item.name}</option>`);
                });

                // ✅ IMPORTANT: select FIRST option
                ddl.val(response.data[0].id);
            }

            // Recreate picker
            ddl.selectpicker({
                liveSearch: true
            });

            // 🔥 FORCE UI update
            ddl.selectpicker('refresh');
        }

        function getDropdownId(filterBy) {
            switch (filterBy) {
                case "phase": return "#phaseSelect";
                case "subproject": return "#subprojectSelect";
                case "deliverable": return "#deliverableSelect";
                case "module": return "#moduleSelect";
                case "milestone": return "#milestoneSelect";
                default: return "#phaseSelect";
            }
        }

        function loadEarnedValueReport() {
            var projectID = parseInt($("#projectSelect").val());
            if (!projectID || projectID <= 0) {
                clearKPIs();
                clearEarnedValueCharts();
                return;
            }

            var filterBy = $('input[name="filterBy"]:checked').val();
            var flag = 0;
            var pid = getSelectedFilterPID(filterBy) || 0;
            var type = 0;
            if (pid > 0) {
                type = 4;
                flag = getFilterTypeValue(filterBy);
            }
            var request = {
                ProjectID: projectID,
                StartDate: toISODateFromPicker($("#fromDate").val()),
                EndDate: toISODateFromPicker($("#toDate").val()),
                Type: type,
                PID: pid,
                Flag: flag
            };

            var response = AJAXCallWithResult(
                "api/PM_EarnedValueReport/GetEarnedValueDetailReport",
                JSON.stringify(request),
                false
            );

            if (!response || !response.data || response.data.length === 0) {
                clearKPIs();
                clearEarnedValueCharts();
                return;
            }
            $("#evNoDataLabel").hide();
            $("#evNoDataLabelMain").hide();
            bindKPIs(response.data);
            updateEarnedValueCharts(response.data); // 🔥 THIS IS KEY
        }

        function clearKPIs() {
            $("#pvValue").text("0.00");
            $("#evValue").text("0.00");
            $("#acValue").text("0.00");
            $("#cpiValue").text("0.00");
            $("#cpiArrow").removeClass("fa-arrow-up text-success");     
            $("#cpiArrow").addClass("fa-arrow-down text-danger");
        }

        function clearEarnedValueCharts() {

            if (earnedValueChartMain) {
                earnedValueChartMain.destroy();
                earnedValueChartMain = null;
            }

            if (earnedValueChart) {
                earnedValueChart.destroy();
                earnedValueChart = null;
            }

            // Show "No Data Available"
            $("#evNoDataLabelMain").show();
            // Show "No Data Available"
            $("#evNoDataLabel").show();
        }

        function formatToDDMMYYYY(dateStr) {
            if (!dateStr) return '';

            var parts = dateStr.split('/'); // [mm, dd, yyyy]
            return parts[1] + '/' + parts[0] + '/' + parts[2];
        }

        function updateEarnedValueCharts(data) {

            var labels = [];
            var pv = [];
            var ev = [];
            var ac = [];
            var totalBudget = [];

            var weekSet = new Set();

            $.each(data, function (i, item) {

                if (!weekSet.has(item.weeks)) {
                    weekSet.add(item.weeks);
    
                    labels.push(formatToDDMMYYYY(item.weeks));
                    pv.push(item.pV_PlannedValue || 0);
                    ev.push(item.eV_EarnedValue || 0);
                    ac.push(item.aC_ActualCost || 0);
                    totalBudget.push(item.totalBudgetedCosts || 0);
                }
            });

            renderChart("earnedValueChartMain", labels, totalBudget, pv, ev, ac, true);
        }

        function getSelectedFilterPID(filterBy) {
            switch (filterBy) {
                case "phase": return $("#phaseSelect").val();
                case "subproject": return $("#subprojectSelect").val();
                case "deliverable": return $("#deliverableSelect").val();
                case "module": return $("#moduleSelect").val();
                case "milestone": return $("#milestoneSelect").val();
                default: return 0;
            }
        }

        function loadEVExpectedDates(projectID, type, id) {
            if (!projectID || projectID <= 0) return;

            var request = {
                ProjectID: projectID,
                ID: id || 0,
                Type: type
            };

            var response = AJAXCallWithResult(
                "api/PM_EarnedValueReport/GetEVExpectedDates",
                JSON.stringify(request),
                false
            );

            if (!response || !response.data) return;

            // API may return single object or list
            var dates = response.data[0] || response.data;

            var startDate = new Date(dates.expectedStartDate);
            var endDate = new Date(dates.expectedEndDate);

            $("#fromDate").datepicker("setDate", startDate);
            $("#toDate").datepicker("setDate", endDate);

        }

        function toISODateFromPicker(dateStr) {
            if (!dateStr) return null;

            // dd-MM-yyyy → yyyy-MM-dd
            const parts = dateStr.split("-");
            return `${parts[2]}-${parts[1]}-${parts[0]}`;
        }

        function bindKPIs(data) {
            if (!data || data.length === 0) {
                clearKPIs();
                return;
            }

            var last = data[data.length - 1];

            var pv = last.pV_PlannedValue || 0;
            var ev = last.eV_EarnedValue || 0;
            var ac = last.aC_ActualCost || 0;
            var cpi = ac > 0 ? (ev / ac) : 0;

            $("#pvValue").text(pv.toFixed(2));
            $("#evValue").text(ev.toFixed(2));
            $("#acValue").text(ac.toFixed(2));
            $("#cpiValue").text(cpi.toFixed(2));

            // 🔽🔼 CPI arrow logic
            if (cpi > 1) {
                $("#cpiArrow")
                    .removeClass("fa-arrow-down text-danger")
                    .addClass("fa-arrow-up text-success");
            } else {
                $("#cpiArrow")
                    .removeClass("fa-arrow-up text-success")
                    .addClass("fa-arrow-down text-danger");
            }
        }

        function renderChart(canvasId, labels, totalBudget, pv, ev, ac, isMain) {

            var ctx = document.getElementById(canvasId);
            if (!ctx) return;

            var chartRef = isMain ? earnedValueChartMain : earnedValueChart;
            if (chartRef) chartRef.destroy();

            var chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: 'Total Budgeted Cost',
                            data: totalBudget,
                            borderColor: '#9e9e9e',
                            borderDash: [5, 5],
                            fill: false,
                            pointRadius: 0
                        },
                        {
                            label: 'PV',
                            data: pv,
                            borderColor: '#2969f3',
                            fill: false
                        },
                        {
                            label: 'EV',
                            data: ev,
                            borderColor: '#4caf50',
                            fill: true
                        },
                        {
                            label: 'AC',
                            data: ac,
                            borderColor: '#ff9800',
                            fill: true
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: { mode: 'index', intersect: false },
                    plugins: { legend: { position: 'bottom' } },
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: 'Weeks'
                            }
                        },
                        y: {
                            title: {
                                display: true,
                                text: 'Man Days'
                            },
                        }
                    }
                }
            });

            if (isMain) earnedValueChartMain = chart;
            else earnedValueChart = chart;
        }

        function loadEarnedValueSummaryForOffcanvas() {

            var projectID = parseInt($("#projectSelect").val(), 10);
            if (!projectID || projectID <= 0) return;

            var filterBy = $('input[name="filterBy"]:checked').val();
            var flag = 0;
            var pid = getSelectedFilterPID(filterBy) || 0;
            if (pid > 0){
                flag = getFilterTypeValue(filterBy);
            }
            var request = {
                PProjectID: projectID,
                PStartDate: toISODateFromPicker($("#fromDate").val()),
                PDateEnd: toISODateFromPicker($("#toDate").val()),
                PEmployeeID: null,
                FromPM: true,
                PID: pid,
                Flag: flag
            };

            var response = AJAXCallWithResult(
                "api/PM_EarnedValueReport/GetEarnedValueReport",
                JSON.stringify(request),
                false
            );

            // ✅ CORRECT PATH
            var list = response?.data || [];

            if (!Array.isArray(list) || list.length === 0) {
                clearOffcanvasEVDetails();
                return;
            }

            var evMap = mapEVSummary(list);
            bindEVSummaryLabels(evMap);
            bindEVNarratives(evMap);
        }

        function initEVDatePickers() {
            $("#fromDate, #toDate").datepicker({
                dateFormat: "dd-mm-yy",
                changeMonth: true,
                changeYear: true,
                showOtherMonths: true,
                selectOtherMonths: true
            });
            $("#fromDate")
                .prop("readonly", true)
                .datepicker("disable");
        }

        $(document).on("click", "#fromDate, #fromDate + .input-group-btn", function (e) {
            e.preventDefault();
            return false;
        });

        function bindEVNarratives(evMap) {

            /* ========== STATUS ========== */
            if (evMap.Status && evMap.Status.trim() !== "0") {
                $("#evStatusText").text(evMap.Status);
                $("#evStatusSection").show();
            } else {
                $("#evStatusSection").hide();
            }

            /* ========== POSSIBLE CAUSES ========== */
            if (evMap.PossibleCauses && evMap.PossibleCauses.trim() !== "0") {
                var causes = evMap.PossibleCauses.split("<BR>");
                var html = "";

                causes.forEach(c => {
                    if (c.trim()) {
                        var text = c.trim().replace(/^[\.\u00B7\u2022]\s*/, '');
                        html += `<li>${text}</li>`;
                    }
                });

                $("#evCausesList").html(html);
                $("#evCausesSection").show();
            } else {
                $("#evCausesSection").hide();
            }

            /* ========== POSSIBLE SOLUTIONS ========== */
            if (evMap.PossibleSolutions && evMap.PossibleSolutions.trim() !== "0") {
                var solutions = evMap.PossibleSolutions.split("<BR>");
                var html = "";

                solutions.forEach(s => {
                    if (s.trim()) {
                        var text = s.trim().replace(/^[\.\u00B7\u2022]\s*/, '');
                        html += `<li>${text}</li>`;
                    }
                });

                $("#evActionsList").html(html);
                $("#evActionsSection").show();
            } else {
                $("#evActionsSection").hide();
            }
        }

        function mapEVSummary(list) {
            var map = {};

            list.forEach(function (item) {
                if (item.evElementName) {
                    map[item.evElementName] = item.fieldValue; // ✅ FIXED
                    if (item.evElementName == "Status" || item.evElementName == "PossibleCauses" || item.evElementName == "PossibleSolutions") {
                        map[item.evElementName] = item.fieldName;
                    }
                }
            });

            return map;
        }

        function formatEV(value, decimals = 2) {
            if (value === null || value === undefined || isNaN(value)) {
                return "0.00";
            }
            return Number(value).toFixed(decimals);
        }

        function bindEVSummaryLabels(evMap) {

            // Reset all to default black first
            $("#lblPV, #lblEV, #lblAC")
                .removeClass("ev-pv ev-ev ev-ac")
                .addClass("ev-default");

            // Values
            $("#lblTotalMandays")
                .text(formatEV(evMap.TotalBudget, 2))
                .removeClass("ev-default")
                .addClass("ev-total");

            $("#lblPV")
                .text(formatEV(evMap.PV))
                .removeClass("ev-default")
                .addClass("ev-pv");   // 🔵 PV = Blue

            $("#lblEV")
                .text(formatEV(evMap.EV))
                .removeClass("ev-default")
                .addClass("ev-ev");   // 🟢 EV = Green

            $("#lblAC")
                .text(formatEV(evMap.AC))
                .removeClass("ev-default")
                .addClass("ev-ac");   // 🟠 AC = Orange

            $("#lblCPI").text(formatEV(evMap.CPI));
            $("#lblCV").text(formatEV(evMap.CV));

            $("#lblSPI").text(formatEV(evMap.SPI));
            $("#lblSV").text(formatEV(evMap.SV));

            $("#lblETC").text(formatEV(evMap.ETC));
            $("#lblEAC").text(formatEV(evMap.EAC));

            // Keep existing KPI color logic
            applyEVColorLogic(evMap);
        }

        function applyEVColorLogic(evMap) {

            // CPI
            $("#lblCPI")
                .removeClass("ev-value-red ev-value-green ev-value-orange")
                .addClass(
                    evMap.CPI >= 1 ? "ev-value-green" :
                        evMap.CPI >= 0.9 ? "ev-value-orange" :
                            "ev-value-red"
                );

            // SPI
            $("#lblSPI")
                .removeClass("ev-value-red ev-value-green ev-value-orange")
                .addClass(
                    evMap.SPI >= 1 ? "ev-value-green" :
                        evMap.SPI >= 0.9 ? "ev-value-orange" :
                            "ev-value-red"
                );

            // CV
            $("#lblCV")
                .removeClass("ev-value-red ev-value-green")
                .addClass(evMap.CV >= 0 ? "ev-value-green" : "ev-value-red");

            // SV
            $("#lblSV")
                .removeClass("ev-value-red ev-value-green")
                .addClass(evMap.SV >= 0 ? "ev-value-green" : "ev-value-red");
        }

        function validateDateRange() {
            var fromDate = $("#fromDate").datepicker("getDate");
            var toDate = $("#toDate").datepicker("getDate");

            if (!fromDate || !toDate) return true;

            if (toDate < fromDate) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("To Date should not be earlier than From Date.", "error", 5);
                loadExpectedDatesByProject($("#projectSelect").val());
                return false;
            }
            return true;
        }

        var offcanvasEl = document.getElementById('earnedValueOffcanvas');
        var offcanvas = new bootstrap.Offcanvas(offcanvasEl);

        // ── syncEVLayout ──────────────────────────────────────────────────
        // Sets --ev-chart-h on the offcanvas body = viewport height minus
        // header, padding, status/causes sections, and a safe margin.
        // Both the chart container and the EV details card read this var.
        // Called on: open, window resize, zoom change.
        // ─────────────────────────────────────────────────────────────────
        function syncEVLayout() {
            var panel = document.getElementById('earnedValueOffcanvas');
            if (!panel || !panel.classList.contains('show')) return;

            var headerEl    = panel.querySelector('.ev-offcanvas-header');
            var bodyEl      = panel.querySelector('.ev-offcanvas-body');
            var chartCard   = panel.querySelector('.ev-chart-card');
            var detailsCard = panel.querySelector('.ev-details-card');
            var chartCanvas = panel.querySelector('#earnedValueChart');
            if (!headerEl || !bodyEl) return;

            // ── STEP 1: Calculate chart height from real panel dimensions ──
            var panelH  = panel.getBoundingClientRect().height;
            var headerH = headerEl.getBoundingClientRect().height;
            var bodyPadT = parseInt(window.getComputedStyle(bodyEl).paddingTop)  || 16;
            var bodyPadB = parseInt(window.getComputedStyle(bodyEl).paddingBottom) || 16;
            var bodyH   = panelH - headerH;
            var chartH  = Math.max(300, Math.floor(bodyH * 0.58) - bodyPadT - bodyPadB);

            // ── STEP 2: Set CSS custom property for height ──
            // This drives both .ev-chart-container and .ev-details-card heights.
            bodyEl.style.setProperty('--ev-chart-h', chartH + 'px');

            // ── STEP 3: Reset canvas inline dimensions before Chart.js resize ──
            // Chart.js bakes px width onto the canvas element as an inline style.
            // When zoom decreases the panel narrows but the canvas retains its
            // old wider inline width — clearing it forces a clean re-measure.
            if (chartCanvas) {
                chartCanvas.style.width  = '';
                chartCanvas.style.height = '';
            }

            // ── STEP 4: Tell Chart.js to resize AFTER CSS has propagated ──
            requestAnimationFrame(function() {
                if (earnedValueChart && earnedValueChart.canvas) {
                    earnedValueChart.resize();
                }

                // ── STEP 5: Match details-card height to chart-card real height ──
                // Read real rendered height (includes padding) for pixel-perfect match.
                if (chartCard && detailsCard) {
                    var realH = chartCard.getBoundingClientRect().height;
                    if (realH > 0) {
                        detailsCard.style.height = realH + 'px';
                    }
                }
            });
        }

        // ── ResizeObserver on the offcanvas PANEL ────────────────────────
        // Fires whenever the panel is resized: window resize, zoom change.
        var _evRO = null;
        function startEVResizeObserver() {
            if (_evRO) { _evRO.disconnect(); _evRO = null; }
            if (!window.ResizeObserver) return;
            _evRO = new ResizeObserver(function() {
                clearTimeout(_evRO._t);
                _evRO._t = setTimeout(syncEVLayout, 80);
            });
            _evRO.observe(offcanvasEl);
        }
        function stopEVResizeObserver() {
            if (_evRO) { _evRO.disconnect(); _evRO = null; }
        }

        offcanvasEl.addEventListener('shown.bs.offcanvas', function() {
            setTimeout(function() {
                syncEVLayout();
                startEVResizeObserver();
            }, 150);
        });

        offcanvasEl.addEventListener('hidden.bs.offcanvas', function() {
            stopEVResizeObserver();
        });

        window.addEventListener('resize', function() {
            clearTimeout(window._evWRT);
            window._evWRT = setTimeout(syncEVLayout, 100);
        });

        $("#showEarnedValueBtn").on("click", function () {

            var projectID = parseInt($("#projectSelect").val());
            if (!projectID || projectID <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Please select a project.", "error", 5);
                return;
            }

            // Update header info
            updateOffcanvasProjectInfo();
            loadEarnedValueReportForCanvas();
            // 🔥 Load API-driven chart + table
            loadEarnedValueSummaryForOffcanvas();
            offcanvas.show(); // 🔥 open only when valid
        });

        function loadEarnedValueReportForCanvas() {

            var projectID = parseInt($("#projectSelect").val());
            if (!projectID || projectID <= 0) return;

            var filterBy = $('input[name="filterBy"]:checked').val();
            var flag = 0;
            var pid = getSelectedFilterPID(filterBy) || 0;
            var type = 0;
            if (pid > 0) {
                type = 4;
                flag = getFilterTypeValue(filterBy);
            }
            var request = {
                ProjectID: projectID,
                StartDate: toISODateFromPicker($("#fromDate").val()),
                EndDate: toISODateFromPicker($("#toDate").val()),
                Type: type,
                PID: pid,
                Flag: flag
            };

            var response = AJAXCallWithResult(
                "api/PM_EarnedValueReport/GetEarnedValueDetailReport",
                JSON.stringify(request),
                false
            );

            if (!response || !response.data || response.data.length === 0) {
                destroyCanvasChart();
                return;
            }
            $("#evNoDataLabel").hide();
            bindCanvasChart(response.data);
        }

        function bindCanvasChart(data) {

            var labels = [];
            var pv = [];
            var ev = [];
            var ac = [];
            var totalBudget = [];

            var weekSet = new Set(); // 🔒 to ensure uniqueness

            $.each(data, function (i, item) {

                if (!weekSet.has(item.weeks)) {
                    weekSet.add(item.weeks);

                    labels.push(formatToDDMMYYYY(item.weeks));
                    pv.push(item.pV_PlannedValue || 0);
                    ev.push(item.eV_EarnedValue || 0);
                    ac.push(item.aC_ActualCost || 0);
                    totalBudget.push(item.totalBudgetedCosts || 0);
                }
            });

            renderChart(
                "earnedValueChart",
                labels,
                totalBudget,
                pv,
                ev,
                ac,
                false
            );
        }

        function destroyCanvasChart() {
            if (earnedValueChart) {
                earnedValueChart.destroy();
                earnedValueChart = null;
            }
            // Show "No Data Available"
            $("#evNoDataLabel").show();
        }
        // Update offcanvas project info
        function updateOffcanvasProjectInfo() {
            const projectText = $('#projectSelect option:selected').text();
            const fromDate = $('#fromDate').val();
            const toDate = $('#toDate').val();

            // Format dates
            const fromDateObj = $("#fromDate").datepicker("getDate");
            const toDateObj = $("#toDate").datepicker("getDate");

            const fromMonth = fromDateObj.toLocaleDateString('en-US', { month: 'short' });
            const fromYear = fromDateObj.getFullYear();
            const toMonth = toDateObj.toLocaleDateString('en-US', { month: 'short' });
            const toYear = toDateObj.getFullYear();

            const dateRange = `${fromMonth} ${fromYear} - ${toMonth} ${toYear}`;

            // Extract project name (remove project code if present)
            let projectName = projectText;
            if (projectText.includes(' - ')) {
                projectName = projectText.split(' - ')[1];
            }

            $('#offcanvasProjectInfo').text(`${projectName} • ${dateRange}`);
        }

        function getDefaultOptionText(filterBy) {
            switch (filterBy) {
                case "phase": return "Select Phase";
                case "subproject": return "Select Subproject";
                case "deliverable": return "Select Deliverable";
                case "module": return "Select Module";
                case "milestone": return "Select Milestone";
                default: return "Select";
            }
        }

        function resetAllDropdowns() {

            const filters = ["phase", "subproject", "deliverable", "module", "milestone"];

            filters.forEach(f => {
                const ddl = $(getDropdownId(f));
                ddl.empty();
                ddl.val(null);          // ✅ correct reset
                ddl.selectpicker('refresh');
            });
        }

        function formatDateTime(dt) {
            var yyyy = dt.getFullYear();
            var MM = String(dt.getMonth() + 1).padStart(2, '0');
            var dd = String(dt.getDate()).padStart(2, '0');
            var HH = String(dt.getHours()).padStart(2, '0');
            var mm = String(dt.getMinutes()).padStart(2, '0');
            var ss = String(dt.getSeconds()).padStart(2, '0');

            return yyyy + MM + dd + "_" + HH + mm + ss;
        }
        let strCompanyLogo = "";

        var directory = '<%=System.Configuration.ConfigurationManager.AppSettings("VirtualDirectoryName").ToString%>';

        function loadCompanyLogo(callback) {

            var fullUrl = strUrl + "api/PM_EarnedValueReport/GetCompanyLogo";

            $.ajax({
                url: fullUrl,
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({}),
                beforeSend: function (xhr) {
                    showLoader();
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                },
                success: function (data) {

                    if (data && data.systemFileName) {
                        strCompanyLogo = data.systemFileName;
                    }

                    callback();
                },

                error: function (xhr) {

                    console.log("Status:", xhr.status);
                    console.log("Response:", xhr.responseText);

                    callback();
                }
            });
        }

        function getLogo(callback) {

            let logoName = strCompanyLogo;

            if (!logoName) {
                callback(""); // No logo
                return;
            }

            var logoUrl;

            if (directory && directory !== "null") {
                logoUrl = window.location.origin + "/" + directory + "/Images/" + logoName;
            }
            else {
                logoUrl = window.location.origin + "/Images/" + logoName;
            }

            fetch(logoUrl)
                .then(res => {

                    if (!res.ok) {
                        console.log("Logo not found");
                        callback("");
                        return null;
                    }

                    return res.blob();
                })
                .then(blob => {

                    if (!blob) return;

                    if (blob.size === 0) {
                        callback("");
                        return;
                    }

                    var reader = new FileReader();

                    reader.onloadend = function () {
                        callback(reader.result || "");
                    };

                    reader.readAsDataURL(blob);

                })
                .catch(err => {

                    console.log("Logo fetch error:", err);

                    callback("");
                });
        }

        function downloadReport(url, type, format) {

            getLogo(function (logoBase64) {
                var fullUrl = strUrl.endsWith('/')
                    ? strUrl + url
                    : strUrl + '/' + url;

                var selectedProjectID = parseInt($("#projectSelect").val());
                var filterBy = $('input[name="filterBy"]:checked').val();

                if (!selectedProjectID || selectedProjectID <= 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("Please select a project.", 'error', 5);
                    return;
                }

                var pid = getSelectedFilterPID(filterBy) || 0;
                var flag = pid > 0 ? getFilterTypeValue(filterBy) : 0;

                var request = {
                    projectID: selectedProjectID,
                    startDate: toISODateFromPicker($("#fromDate").val()),
                    CompanyLogo: logoBase64,
                    endDate: toISODateFromPicker($("#toDate").val()),
                    pid: pid,
                    flag: flag
                };

                $.ajax({
                    url: fullUrl,
                    type: "POST",
                    data: JSON.stringify(request),
                    contentType: "application/json",
                    xhrFields: { responseType: 'blob' },
                    beforeSend: function (xhr) {
                        showLoader();
                        var token = sessionStorage.getItem("access_token_W26API");
                        if (token) xhr.setRequestHeader('Authorization', 'bearer ' + token);
                    },
                    success: function (blob, status) {

                        if (status === "nocontent") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("No data available for download", 'error', 5);
                            return;
                        }

                        var dateTimeSuffix = formatDateTime(new Date());
                        var ext = format === "pdf" ? ".pdf" : ".xlsx";

                        var fileName = type === 1
                            ? "EV_Summary_" + dateTimeSuffix + ext
                            : "EV_Details_" + dateTimeSuffix + ext;

                        var blobUrl = window.URL.createObjectURL(blob);
                        var a = document.createElement('a');
                        a.href = blobUrl;
                        a.download = fileName;
                        document.body.appendChild(a);
                        a.click();

                        window.URL.revokeObjectURL(blobUrl);
                        document.body.removeChild(a);
                    },
                    error: function (xhr) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(
                            xhr.status === 204
                                ? "No data available for download"
                                : "Failed to generate report",
                            'error',
                            5
                        );
                    },
                    complete: function () {
                        hideLoader();
                    }
                });
            });
        }


        // SUMMARY
        $(document).on("click", ".ev-summary-download", function (e) {

            e.preventDefault();

            var format = $(this).data("format");

            var url = format === "excel"
                ? "api/PM_EarnedValueReport/ExportEarnedValueSummaryExcel"
                : "api/PM_EarnedValueReport/ExportEarnedValueSummaryPdf";

            loadCompanyLogo(function () {

                downloadReport(url, 1, format);

            });
        });

        // DETAILS
        $(document).on("click", ".ev-details-download", function (e) {

            e.preventDefault();

            var format = $(this).data("format");

            var url = format === "excel"
                ? "api/PM_EarnedValueReport/ExportEarnedValueDetailsExcel"
                : "api/PM_EarnedValueReport/ExportEarnedValueDetailsPdf";

            loadCompanyLogo(function () {

                downloadReport(url, 2, format);

            });
        });

        // Export functions for external use
        window.EarnedValueReport = {
            updateOffcanvasProjectInfo: updateOffcanvasProjectInfo
        };
    </script>
</body>
</html>