<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_BenchResourceManagement.aspx.vb" Inherits="Whizible.RM_BenchResourceManagement" %>


<!DOCTYPE html>
<html lang="en">
    <%CommonFunctions.General.PlotPageHeadTag("Bench Resource Management")%>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%= MyBase.GetResourceString("C_BenchDashboard") %></title> 
  
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    
    
    <style>

        /* Added by Vishal Mane on 20/05/2026 to wrap resource cell properly */

        /* Added by Vishal Mane on 20/05/2026 for proper employee name wrapping */

        body {
            font-size: 12px !important;
                }
                .form-control, .btn, a, p, input, select.form-select {
            font-size: 12px !important;
        }

        .res-cell {
            display: flex;
            align-items: center;
            gap: 8px;
            min-width: 0;
        }

        .res-avatar {
            flex-shrink: 0;
        }

        .res-name {
            white-space: normal;
            word-break: normal;
            overflow-wrap: break-word;
            line-height: 18px;
        }

        .history-popover {
            cursor: pointer;
            word-break: break-word;
        }

        .history-bs-popover.popover {
            --bs-popover-bg: #000;
            --bs-popover-body-color: #fff;
            --bs-popover-border-color: #000;
            max-width: 500px !important;
            width: 500px !important;
        }

        .history-bs-popover .popover-body {
            background-color: #000;
            color: #fff;
        }

        .history-bs-popover .history-popover-content {
            max-height: 300px;
            overflow-y: auto;
            white-space: pre-wrap;
            word-break: break-word;
            font-size: 13px;
            line-height: 1.5;
            color: #fff;
        }
        .btnyellow {
            background: #e29214 !important;
            color: #fff !important;
        }

            .btnyellow:hover {
                background: #e29214 !important;
                color: #fff !important;
            }

        :root {
            --bg: #f4f5f7;
            --surface: #ffffff;
            --surface2: #f9fafb;
            --border: #e5e7eb;
            --text-primary: #111827;
            --text-secondary: #6b7280;
            --text-muted: #9ca3af;
            --accent: #4f46e5;
            --accent-light: #eef2ff;
            --green: #16a34a;
            --green-bg: #f0fdf4;
            --orange: #ea580c;
            --orange-bg: #fff7ed;
            --red: #dc2626;
            --red-bg: #fef2f2;
            --yellow: #d97706;
            --yellow-bg: #fffbeb;
            --badge-bench: #e0f2fe;
            --badge-bench-text: #0369a1;
            --badge-shadow: #fef9c3;
            --badge-shadow-text: #a16207;
            --shadow-sm: 0 1px 2px rgba(0,0,0,0.05);
            --shadow: 0 1px 3px rgba(0,0,0,0.08), 0 1px 2px rgba(0,0,0,0.04);
            --shadow-md: 0 4px 6px -1px rgba(0,0,0,0.07), 0 2px 4px -1px rgba(0,0,0,0.04);
            --radius: 10px;
            --radius-sm: 6px;
        }

        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            /* font-family: "Segoe UI", Arial, sans-serif; */
            background: var(--bg);
            color: var(--text-primary);
            font-size: 11.5px;
            min-height: 100vh;
        }

        /* ── MAIN CONTENT ── */
        .main-content {
            padding: 0 8px 8px;
            max-width: none;
            margin: 0;
        }

        /* ── HEADER ── */
        .page-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            margin-bottom: 12px;
        }

        /* Added by Vishal Mane on 12/05/2026 to align top section with Employee Master page. */
        .bench-page-titlebar {
            min-height: 34px;
            border-bottom: 1px solid #e5e7eb;
        }

            .bench-page-titlebar h5.pgtitle {
                margin: 6px 0 0;
                font-weight: 700;
                color: #4263c1;
                font-size: 16px;
            }

            .bench-page-titlebar .filter.inline {
                margin: 2px 0 0 8px;
            }

                .bench-page-titlebar .filter.inline button {
                    border: 0;
                    background: transparent;
                    color: #111827;
                    padding: 4px 6px;
                    line-height: 1;
                }

                    .bench-page-titlebar .filter.inline button:hover,
                    .bench-page-titlebar .filter.inline button.active {
                        color: #4263c1;
                    }

        .bench-list-toolbar {
            background: #fff;
            margin-bottom: 4px;
        }

            .bench-list-toolbar .srchrequest {
                max-width: 300px;
            }

            .bench-list-toolbar .search-query {
                height: 30px;
                font-size: 11.5px;
            }

            .bench-list-toolbar .btn-default {
                border: 1px solid #ddd;
                background: #f8f8f8;
            }

            .bench-list-toolbar .btn-export {
                display: inline-flex;
                margin-right: 5px;
                height: 30px;
                padding: 4px 10px;
                border-radius: 4px;
                box-shadow: none;
            }

            .bench-list-toolbar .borderbtn {
                height: 30px;
                align-items: center;
            }

        .page-title {
            font-size: 19px !important;
            font-weight: 700;
            letter-spacing: -0.5px;
            color: #1e40af;
        }

        .page-subtitle {
            font-size: 11.5px;
            color: var(--text-secondary);
            margin-top: 2px;
        }

        .btn-export {
            display: flex;
            align-items: center;
            gap: 7px;
            background: var(--surface);
            border: 1px solid var(--border);
            color: var(--text-primary);
            font-family: "Segoe UI", Arial, sans-serif;
            font-size: 11.5px;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: var(--radius-sm);
            cursor: pointer;
            transition: all .15s;
            box-shadow: var(--shadow-sm);
        }

            .btn-export:hover {
                background: var(--surface2);
                border-color: #d1d5db;
            }

        .page-header-actions {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-shrink: 0;
        }

        .btn-filter-toggle {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 38px;
            padding: 0;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            color: var(--accent);
            cursor: pointer;
            transition: all .15s;
            box-shadow: var(--shadow-sm);
        }

            .btn-filter-toggle:hover {
                background: var(--surface2);
                border-color: #d1d5db;
            }

            .btn-filter-toggle.active {
                background: var(--accent-light);
                border-color: var(--accent);
            }

            .btn-filter-toggle i {
                font-size: 15px;
            }

        /* ── KPI CARDS ── */
        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
            margin-bottom: 12px;
        }

        .kpi-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 10px 12px;
            box-shadow: var(--shadow);
            display: flex;
            gap: 10px;
            align-items: center;
            transition: box-shadow .2s;
        }

            .kpi-card:hover {
                box-shadow: var(--shadow-md);
            }

        .kpi-icon-wrap {
            width: 30px;
            height: 30px;
            border-radius: 7px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 11.5px;
        }

            .kpi-icon-wrap.blue {
                background: var(--accent-light);
                color: var(--accent);
            }

            .kpi-icon-wrap.orange {
                background: var(--orange-bg);
                color: var(--orange);
            }

            .kpi-icon-wrap.teal {
                background: #f0fdfa;
                color: #0d9488;
            }

        .kpi-label {
            font-size: 11.5px;
            color: var(--text-secondary);
            font-weight: 500;
            margin-bottom: 2px;
        }

        .kpi-value {
            font-size: 14px;
            font-weight: 700;
            letter-spacing: -0.5px;
            line-height: 1;
        }

        .kpi-delta {
            font-size: 11.5px;
            margin-top: 3px;
            display: flex;
            align-items: center;
            gap: 4px;
            font-weight: 500;
        }

            .kpi-delta.up {
                color: var(--green);
            }

            .kpi-delta.down {
                color: var(--red);
            }

            .kpi-delta.neutral {
                color: var(--accent);
            }

        /* ── FILTERS ── */
        .filters-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 16px 20px;
            margin-bottom: 16px;
            box-shadow: var(--shadow);
        }

            .filters-card.filters-hidden {
                display: none;
            }

        .filters-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
        }

        .filters-label {
            font-size: 11.5px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 7px;
            color: var(--text-primary);
        }

        .filters-actions {
            display: flex;
            gap: 8px;
        }

        .filters-row {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 4px;
            flex: 0 0 calc((100% - 24px) / 3);
            max-width: calc((100% - 24px) / 3);
            min-width: 220px;
        }

            .filter-group label {
                font-size: 11.5px;
                font-weight: 500;
                color: var(--text-secondary);
            }

        select.filter-select, .filter-search {
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 7px 10px;
            font-family: "Segoe UI", Arial, sans-serif;
            font-size: 11.5px;
            color: var(--text-primary);
            background: var(--surface);
            outline: none;
            transition: border .15s, box-shadow .15s;
            width: 100%;
        }

            select.filter-select:focus, .filter-search:focus {
                border-color: var(--accent);
                box-shadow: 0 0 0 3px rgba(79,70,229,.1);
            }

        .bootstrap-select.filter-select {
            border: none !important;
            box-shadow: none !important;
        }

            .bootstrap-select.filter-select > .dropdown-toggle {
                border: 1px solid var(--border);
                border-radius: var(--radius-sm);
                padding: 7px 10px;
                font-family: "Segoe UI", Arial, sans-serif;
                font-size: 11.5px;
                color: var(--text-primary);
                background: var(--surface);
                line-height: 1.2;
            }

                .bootstrap-select.filter-select > .dropdown-toggle:focus,
                .bootstrap-select.filter-select > .dropdown-toggle:active {
                    border-color: var(--accent);
                    box-shadow: 0 0 0 3px rgba(79,70,229,.1);
                    outline: none !important;
                }

            .bootstrap-select.filter-select .dropdown-toggle::after {
                margin-top: 0;
            }

        .filter-search-wrap {
            position: relative;
        }

            .filter-search-wrap i {
                position: absolute;
                left: 10px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--text-muted);
                font-size: 11.5px;
            }

            .filter-search-wrap .filter-search {
                padding-left: 30px;
            }

        /*Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor*/
        .bench-dept-multiselect,
        .bench-ms-multiselect {
            position: relative;
            width: 100%;
        }

        .bench-dept-toggle,
        .bench-ms-toggle {
            width: 100%;
            text-align: left;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 7px 28px 7px 10px;
            font-family: "Segoe UI", Arial, sans-serif;
            font-size: 11.5px;
            color: var(--text-primary);
            background: var(--surface);
            cursor: pointer;
            position: relative;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .bench-dept-toggle::after,
        .bench-ms-toggle::after {
            content: '';
            position: absolute;
            right: 10px;
            top: 50%;
            margin-top: -2px;
            border: 5px solid transparent;
            border-top-color: var(--text-secondary);
        }

        .bench-dept-panel,
        .bench-ms-panel {
            position: absolute;
            top: calc(100% + 4px);
            left: 0;
            right: 0;
            z-index: 1060;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.12);
            max-height: 280px;
            display: flex;
            flex-direction: column;
        }

        .bench-dept-search-wrap,
        .bench-ms-search-wrap {
            padding: 8px;
            border-bottom: 1px solid var(--border);
        }

        .bench-dept-search-wrap input,
        .bench-ms-search-wrap input {
            width: 100%;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 6px 8px;
            font-size: 11.5px;
            outline: none;
        }

        .bench-dept-search-wrap input:focus,
        .bench-ms-search-wrap input:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(79,70,229,.1);
        }

        .bench-dept-list,
        .bench-ms-list {
            overflow-y: auto;
            max-height: 220px;
            padding: 4px 0;
        }

        .bench-dept-option,
        .bench-ms-option {
            display: flex;
            align-items: flex-start;
            gap: 8px;
            padding: 6px 10px;
            cursor: pointer;
            font-size: 11.5px;
            line-height: 1.35;
        }

        .bench-dept-option:hover,
        .bench-ms-option:hover {
            background: var(--surface2, #f8fafc);
        }

        .bench-dept-option input[type="checkbox"],
        .bench-ms-option input[type="checkbox"] {
            margin-top: 2px;
            flex-shrink: 0;
        }

        .bench-dept-option.hidden-by-search,
        .bench-ms-option.hidden-by-search {
            display: none;
        }
        /*End of Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor*/

        .btn-show {
            display: flex;
            align-items: center;
            gap: 6px;
            background: var(--accent);
            color: #fff;
            border: none;
            border-radius: var(--radius-sm);
            font-family: "Segoe UI", Arial, sans-serif;
            font-size: 11.5px;
            font-weight: 600;
            padding: 8px 18px;
            cursor: pointer;
            transition: background .15s;
        }

            .btn-show:hover {
                background: #4338ca;
            }

        .btn-more-filters, .btn-reset {
            display: flex;
            align-items: center;
            gap: 6px;
            background: var(--surface);
            color: var(--text-secondary);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            font-family: "Segoe UI", Arial, sans-serif;
            font-size: 11.5px;
            font-weight: 500;
            padding: 7px 14px;
            cursor: pointer;
            transition: all .15s;
        }

            .btn-more-filters:hover, .btn-reset:hover {
                background: var(--surface2);
                color: var(--text-primary);
            }

        .filters-actions {
            position: relative;
        }

        .more-filters-popover {
            position: absolute;
            top: calc(100% + 8px);
            left: 0;
            width: 100%;
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 12px;
            box-shadow: var(--shadow-md);
            padding: 14px 16px;
            z-index: 250;
            display: none;
        }

            .more-filters-popover.show {
                display: block;
            }

        .more-filters-title {
            font-size: 11.5px;
            font-weight: 700;
            color: #6b7280;
            letter-spacing: 0.4px;
            margin-bottom: 10px;
        }

        .more-filter-option {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
            font-size: 11.5px;
            color: #111827;
            cursor: pointer;
        }

            .more-filter-option:last-child {
                margin-bottom: 0;
            }

            .more-filter-option input {
                width: 16px;
                height: 16px;
                cursor: pointer;
            }

        #dynamicFiltersHost {
            display: contents;
        }

        .filter-group.dynamic-filter {
            position: relative;
            padding-right: 18px;
        }

        .remove-dynamic-filter {
            position: absolute;
            top: 0;
            right: 0;
            width: 14px;
            height: 14px;
            border: none;
            background: #ef4444;
            color: #fff;
            border-radius: 50%;
            font-size: 11.5px;
            line-height: 14px;
            text-align: center;
            cursor: pointer;
            padding: 0;
        }

        /* ── TABLE SECTION ── */
        .table-section {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .table-header {
            padding: 8px 10px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .table-title {
            font-size: 14px;
            font-weight: 600;
        }

        .table-count {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: var(--accent-light);
            color: var(--accent);
            font-size: 11.5px;
            font-weight: 700;
            border-radius: 20px;
            padding: 1px 8px;
            margin-left: 8px;
        }

        .table-responsive {
            /* Modified by Vishal Mane on 12/05/2026 to remove internal vertical scroll for 10-row pagination */
            overflow-x: auto;
            overflow-y: visible;
            margin: 0;
            padding: 0;
            max-height: none;
        }

        /*Added by Vishal Mane on 26/05/2026 to fix the static header part*/
        .main-content.bench-main-layout {
            display: flex;
            flex-direction: column;
            height: calc(100vh - 30px);
            min-height: 0;
            box-sizing: border-box;
        }

        .main-content.bench-main-layout .bench-page-titlebar,
        .main-content.bench-main-layout .filters-card {
            flex-shrink: 0;
        }

        .table-section.bench-table-section {
            flex: 1 1 auto;
            display: flex;
            flex-direction: column;
            min-height: 0;
            overflow: hidden;
        }

        .table-section.bench-table-section .table-header,
        .table-section.bench-table-section .table-footer {
            flex-shrink: 0;
        }

        .table-section .bench-table-scroll {
            flex: 1 1 auto;
            min-height: 0;
            height: auto;
            max-height: none;
            overflow-x: auto;
            overflow-y: auto;
            -webkit-overflow-scrolling: touch;
        }

        /*Added by Vishal Mane on 27/05/2026 to freeze Employee Name column (same pattern as HR_TimesheetCompliance #tableCalVeiw)*/
        #benchTable {
            --bench-sticky-col1-width: 280px;
        }

            table#benchTable {
                border-collapse: separate !important;
                border-spacing: 0;
            }

        .table-section .bench-table-scroll #benchTable thead th {
            position: sticky;
            top: 0;
            z-index: 10;
            background: var(--surface2);
            box-shadow: 0 1px 0 var(--border);
        }

        /* Day/other headers must slide behind frozen Employee Name column on horizontal scroll */
        .table-section .bench-table-scroll #benchTable thead th:not(:nth-child(1)) {
            z-index: 1 !important;
        }

            #benchTable thead th:nth-child(1),
            #benchTable tbody td:nth-child(1) {
                min-width: var(--bench-sticky-col1-width);
                max-width: var(--bench-sticky-col1-width);
                width: var(--bench-sticky-col1-width);
                position: sticky;
                left: 0;
            }

            #benchTable thead th:nth-child(1) {
                top: 0;
                z-index: 50 !important;
                background: var(--surface2);
                box-shadow: 1px 0 0 var(--border);
            }

            #benchTable tbody td:nth-child(1) {
                z-index: 40 !important;
                background: var(--surface);
                box-shadow: 1px 0 0 var(--border);
            }

            #benchTable tbody tr:hover td:nth-child(1) {
                background: #fafafa;
            }
        /*End of Added by Vishal Mane on 27/05/2026 to freeze Employee Name column*/

        table {
            width: 100%;
            border-collapse: collapse;
            border-spacing: 0;
            white-space: nowrap;
            margin: 0;
        }

        thead th {
            font-size: 11.5px;
            font-weight: 600;
            letter-spacing: 0.5px;
            color: #080808;
            padding: 6px 8px;
            background: var(--surface2);
            border-bottom: 1px solid var(--border);
            cursor: pointer;
            user-select: none;
            white-space: normal;
            line-height: 1.25;
        }

            thead th:hover {
                color: var(--text-primary);
            }

        tbody tr {
            border-bottom: 1px solid var(--border);
            transition: background .1s;
        }

            tbody tr:last-child {
                border-bottom: none;
            }

            tbody tr:hover {
                background: #fafafa;
            }

        tbody td {
            padding: 6px 8px;
            vertical-align: middle;
            font-size: 11.5px;
            line-height: 1.2;
        }

        /* ── RESOURCE CELL ── */
        .res-cell {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .res-avatar {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 9px;
            font-weight: 700;
            color: #fff;
            flex-shrink: 0;
            letter-spacing: 0.5px;
        }

        .avatar-0 {
            background: #4f46e5;
        }

        .avatar-1 {
            background: #0891b2;
        }

        .avatar-2 {
            background: #16a34a;
        }

        .avatar-3 {
            background: #ea580c;
        }

        .avatar-4 {
            background: #9333ea;
        }

        .avatar-5 {
            background: #db2777;
        }

        .avatar-6 {
            background: #0d9488;
        }

        .avatar-7 {
            background: #d97706;
        }

        .res-name {
            font-weight: 600;
            font-size: 11.5px;
            color: var(--text-primary);
        }

        .res-id {
            font-size: 11.5px;
            color: #080808;
            font-family: "Consolas", monospace;
        }

        /* ── SKILLS ── */
        .skill-tags {
            display: flex;
            flex-direction: column;
            gap: 1px;
        }

        .skill-tag {
            font-size: 11.5px;
            font-weight: 500;
            color: var(--accent);
            background: var(--accent-light);
            border-radius: 3px;
            padding: 0 5px;
            display: inline-block;
            width: fit-content;
        }

        .skill-more {
            font-size: 11.5px;
            color: var(--text-muted);
            font-weight: 500;
        }

        /* ── STATUS BADGE ── */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 11.5px;
            font-weight: 600;
            padding: 2px 6px;
            border-radius: 20px;
            cursor: default;
        }

            .status-badge.bench {
                background: var(--badge-bench);
                color: var(--badge-bench-text);
            }

            .status-badge.shadow {
                background: var(--badge-shadow);
                color: var(--badge-shadow-text);
            }

            .status-badge .edit-icon {
                font-size: 11.5px;
                opacity: 0.7;
            }

        /* ── AGING ── */
        .aging-badge {
            font-weight: 600;
            font-size: 12.5px;
        }

        .aging-badge.low {
    color: #000000; /* Black */
}

.aging-badge.medium {
    color: #ff6b6b; /* Light Red */
}

.aging-badge.high {
    color: #ff0000; /* Red */
}

        /* ── ALLOC BAR ── */
        .alloc-wrap {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .alloc-bar-track {
            width: 52px;
            height: 4px;
            background: #e5e7eb;
            border-radius: 99px;
            overflow: hidden;
        }

        .alloc-bar-fill {
            height: 100%;
            border-radius: 99px;
        }

            .alloc-bar-fill.empty {
                background: #e5e7eb;
            }

            .alloc-bar-fill.low {
                background: #f59e0b;
            }

            .alloc-bar-fill.high {
                background: #10b981;
            }

            .alloc-bar-fill.w-0 {
                width: 0%;
            }

            .alloc-bar-fill.w-10 {
                width: 10%;
            }

            .alloc-bar-fill.w-20 {
                width: 20%;
            }

            .alloc-bar-fill.w-30 {
                width: 30%;
            }

            .alloc-bar-fill.w-40 {
                width: 40%;
            }

            .alloc-bar-fill.w-50 {
                width: 50%;
            }

            .alloc-bar-fill.w-60 {
                width: 60%;
            }

            .alloc-bar-fill.w-70 {
                width: 70%;
            }

            .alloc-bar-fill.w-80 {
                width: 80%;
            }

            .alloc-bar-fill.w-90 {
                width: 90%;
            }

            .alloc-bar-fill.w-100 {
                width: 100%;
            }

        .alloc-pct {
            font-size: 11.5px;
            font-weight: 500;
            color: var(--text-secondary);
        }

        .accent-icon {
            color: var(--accent);
        }

        /* ── AVAIL ── */
        .avail-pct {
            font-weight: 700;
            font-size: 11.5px;
        }

        .avail-pct.full {
            color: #008000; /* Green */
        }

        .avail-pct.partial {
            color: #ff8c00; /* Orange */
        }
/* ── AVAILABILITY ── */
        .avail-tag {
            font-size: 11.5px;
            font-weight: 600;
        }

            .avail-tag.immediate {
                color: var(--green);
            }

            .avail-tag.date {
                color: var(--text-secondary);
            }

        /* ── LOCATION ── */
        .loc-cell {
            display: flex;
            align-items: center;
            gap: 3px;
            color: #080808;
            font-size: 11.5px;
        }

            .loc-cell i {
                font-size: 11.5px;
                color: var(--text-muted);
            }

        .date-cell {
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

            .date-cell i {
                font-size: 11.5px;
                color: var(--text-muted);
            }

        /* ── REMARKS ── */
        .remarks-cell {
            max-width: 150px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            color: var(--text-secondary);
            font-size: 11.5px;
        }

        /* ── ACTIONS ── */
        .actions-cell {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .action-btn {
            width: 22px;
            height: 22px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid var(--border);
            background: var(--surface);
            color: var(--text-muted);
            cursor: pointer;
            transition: all .15s;
            font-size: 11.5px;
        }

            .action-btn:hover {
                background: var(--accent-light);
                color: var(--accent);
                border-color: transparent;
            }

        /* Added by Vishal Mane on 13/05/2026 for inline Bench Status / Remarks in grid */
        /*.bench-status-select {
            min-width: 108px;
            max-width: 140px;
            font-size: 11px;
            padding: 3px 6px;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            background: var(--surface);
            color: var(--text-primary);
        }*/

        /*.bootstrap-select > .dropdown-toggle {
            position: relative;
            width: 75%;
        }*/

        /* Added by Vishal Mane on 18/05/2026 to reduce Bench Status dropdown width properly */

        .bootstrap-select.bench-status-select {
            width: 160px !important;
        }

        .bootstrap-select.bench-status-select > .dropdown-toggle {
            width: 100% !important;
        }

        .bench-remarks-input {
            width: 100%;
            min-width: 120px;
            max-width: 220px;
            min-height: 35px;
            font-size: 11px;
            padding: 4px 6px;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            resize: vertical;
        }

        /* ── PAGINATION ── */
        .table-footer {
            padding: 6px 10px;
            border-top: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: var(--surface2);
        }

        .page-info {
            font-size: 11.5px;
            color: var(--text-secondary);
        }

        .pagination-btns {
            display: flex;
            gap: 4px;
        }

        .pg-btn {
            width: 30px;
            height: 30px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid var(--border);
            background: var(--surface);
            font-size: 12.5px;
            font-weight: 500;
            cursor: pointer;
            transition: all .15s;
            color: var(--text-secondary);
        }

            .pg-btn:hover, .pg-btn.active {
                background: var(--accent);
                color: #fff;
                border-color: var(--accent);
            }

            .pg-btn.disabled {
                opacity: 0.4;
                cursor: not-allowed;
            }

        /* ── TOAST ── */
        .toast-wrap {
            position: fixed;
            bottom: 24px;
            right: 24px;
            z-index: 9999;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .toast-item {
            background: var(--text-primary);
            color: #fff;
            padding: 10px 16px;
            border-radius: var(--radius-sm);
            font-size: 11.5px;
            font-weight: 500;
            box-shadow: var(--shadow-md);
            animation: slideUp .2s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(8px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .history-filter-row {
            display: flex;
            gap: 10px;
            align-items: center;
            margin-bottom: 12px;
            flex-wrap: wrap;
        }

        .detail-accordion .accordion-item {
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            margin-bottom: 10px;
            overflow: hidden;
        }

        .detail-accordion .accordion-button {
            font-size: 11.5px;
            font-weight: 600;
            padding: 10px 12px;
            background: #f8fafc;
            color: #111827;
            box-shadow: none;
        }

            .detail-accordion .accordion-button:not(.collapsed) {
                background: #eef2ff;
                color: #1f2937;
            }

        .history-timeline {
            position: relative;
            margin: 0;
            padding: 0 0 0 18px;
            list-style: none;
        }

            .history-timeline::before {
                content: "";
                position: absolute;
                left: 6px;
                top: 2px;
                bottom: 2px;
                width: 2px;
                background: #dbeafe;
            }

        .history-item {
            position: relative;
            margin-bottom: 12px;
            padding: 10px 12px;
            border: 1px solid #dbe4f5;
            border-radius: 10px;
            background: linear-gradient(180deg, #ffffff 0%, #f8fbff 100%);
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.06);
        }

            .history-item:last-child {
                margin-bottom: 0;
            }

            .history-item::before {
                content: "";
                position: absolute;
                left: -17px;
                top: 12px;
                width: 10px;
                height: 10px;
                border-radius: 50%;
                background: #4f46e5;
                border: 2px solid #eef2ff;
            }

        .history-item-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 8px;
            margin-bottom: 8px;
        }

        .history-field {
            font-size: 10.5px;
            font-weight: 600;
            color: #4338ca;
            background: #eef2ff;
            border: 1px solid #c7d2fe;
            border-radius: 999px;
            padding: 2px 8px;
        }

        .offcanvas-title {
            font-size: 14px !important;
        }

        .history-meta {
            font-size: 11.5px;
            color: #64748b;
            white-space: nowrap;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 999px;
            padding: 4px 10px;
        }

            .history-meta .history-meta-item {
                display: inline-flex;
                align-items: center;
                gap: 3px;
            }

            .history-meta .history-date {
                display: inline-flex;
                align-items: center;
                gap: 3px;
            }

            .history-meta i {
                color: #8aa0c6;
                font-size: 11px;
            }

        .history-change {
            font-size: 11.5px;
            color: #374151;
            display: flex;
            align-items: center;
            gap: 6px;
            flex-wrap: wrap;
        }

        .history-pill {
            display: inline-flex;
            align-items: center;
            border-radius: 999px;
            padding: 2px 8px;
            font-size: 11px;
            border: 1px solid #e5e7eb;
            background: #fff;
            color: #111827;
        }

            .history-pill.new {
                border-color: #bbf7d0;
                background: #f0fdf4;
                color: #166534;
            }

        .history-arrow {
            color: #64748b;
            font-weight: 700;
        }

        .history-empty {
            padding: 10px 12px;
            border: 1px dashed #cbd5e1;
            border-radius: 8px;
            color: #64748b;
            background: #f8fafc;
            font-size: 11.5px;
        }

        .history-pagination {
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
        }

        .history-page-info {
            font-size: 11px;
            color: #64748b;
        }

        .history-page-btns {
            display: flex;
            gap: 4px;
        }

        .detail-offcanvas {
            width: 55% !important;
            max-width: 760px;
        }

        /* History audit grid: wrap long Old/New values so the offcanvas does not grow a horizontal scrollbar */
        #historyCollapse .table-responsive {
            overflow-x: hidden;
        }

        #cityShowHisTable {
            table-layout: fixed;
            width: 100% !important;
        }

        #cityShowHisTable th,
        #cityShowHisTable td {
            white-space: normal !important;
            word-wrap: break-word;
            overflow-wrap: anywhere;
            word-break: break-word;
            vertical-align: top;
        }

        #cityShowHisTable_wrapper table.dataTable > thead > tr > th,
        #cityShowHisTable_wrapper table.dataTable > tbody > tr > td {
            white-space: normal !important;
            word-wrap: break-word;
            overflow-wrap: anywhere;
            word-break: break-word;
            vertical-align: top;
        }

        /* Added by Vishal Mane on 25/05/2026 — custom history pagination (Total Records + << >>) */
        #cityShowHisTable_wrapper .dataTables_info,
        #cityShowHisTable_wrapper .dataTables_paginate {
            display: none !important;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            column-gap: 18px;
            row-gap: 6px;
        }

        .detail-item {
            display: grid;
            grid-template-columns: 170px 1fr;
            align-items: start;
            gap: 8px;
            padding: 2px 0;
            border: none;
            background: transparent;
        }

        .detail-key {
            font-size: 11.5px;
            color: #5980ff;
            font-weight: 500;
            white-space: nowrap;
            text-align: right;
        }

            .detail-key::after {
                content: ":";
                margin-left: 4px;
            }

        .detail-value {
            font-size: 11.5px;
            color: #111827;
            text-align: left;
            word-break: break-word;
        }

        .detail-item.remarks-row {
            grid-column: 1 / -1;
        }

        .details-actions {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 8px;
        }

        .detail-input, .detail-textarea {
            width: 100%;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 11.5px;
            color: #111827;
            padding: 5px 8px;
            background: #fff;
        }

        .detail-textarea {
            min-height: 74px;
            resize: vertical;
            max-width: 760px;
        }

        .remarks-limit {
            margin-top: 3px;
            font-size: 11.5px;
            color: #6b7280;
            text-align: right;
        }

        /* Added Loader by Vishal Mane on 26/05/2026 */
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
        /* End of Added Loader by Vishal Mane on 26/05/2026 */

        /* ── RESPONSIVE ── */
        @media (max-width: 900px) {
            .kpi-grid {
                grid-template-columns: 1fr;
            }

            .filters-row {
                flex-direction: column;
            }

            .filter-group {
                flex: 0 0 100%;
                max-width: 100%;
                min-width: 100%;
            }

            .detail-grid {
                grid-template-columns: 1fr;
            }

            .detail-item {
                grid-template-columns: 150px 1fr;
            }
        }
    </style>
</head>
<body class="hold-transition bgwhite sidebar-mini fixed">
    <div class="loader-overlay" id="loaderOverlay" style="display: none !important;">
        <div class="loader"></div>
    </div>
    <%-- End of Added Loader by Vishal Mane on 26/05/2026 --%>
    <!-- MAIN -->
    <% If m_blnViewAccess = True Then %>
    <%--Added by Vishal Mane on 26/05/2026 to fix the static header part--%>
    <div class="main-content bench-main-layout">
        <!-- PAGE HEADER -->
        <%--Added by Vishal Mane on 12/05/2026 to align top section with Employee Master page--%>

        <div class="container-fluid pt-1 pb-1 mb-0 graybg bench-page-titlebar">
            <div class="d-flex justify-content-between align-items-center flex-wrap">
                <!-- Left Side -->
                <div>
                    <div class="page-title pgtitle mb-0">
                        <%= MyBase.GetResourceString("C_BenchDashboard") %>
                    </div>
                    <div class="page-subtitle pgsubtitle">
                        <%= MyBase.GetResourceString("C_BenchDashboardSubtitle") %>
                    </div>
                </div>
                <!-- Right Side -->
                <div class="page-header-actions d-flex align-items-center gap-2">
                    <button type="button" class="btn-export" id="btnGenerateFile">
                        <i class="fas fa-file-excel"></i>
                        <%= MyBase.GetResourceString("C_ExportToExcel") %>
                    </button>
                    <button type="button"
                        class="btn-filter-toggle"
                        id="btnToggleFilters"
                        title="<%= MyBase.GetResourceString("C_ShowFilters") %>"
                        aria-expanded="false"
                        aria-controls="filtersCardSection">
                        <i class="fas fa-filter"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- FILTERS -->
        <div class="filters-card filters-hidden" id="filtersCardSection">
            <div class="filters-top">
                <div class="filters-label"><i class="fas fa-sliders accent-icon"></i><%= MyBase.GetResourceString("C_Filters") %></div>
                <div class="filters-actions">
                    <%--<button class="btn-more-filters" id="btnMoreFilters"><i class="fas fa-plus"></i>More Filters</button>--%>
                    <button class="btn-reset" id="btnReset"><i class="fas fa-rotate-right"></i>Clear All</button>
                    <button class="btn-show" id="btnShow"><i class="fas fa-magnifying-glass"></i><%= MyBase.GetResourceString("C_Show") %></button>
                    <div class="more-filters-popover" id="moreFiltersPopover">
                        <div class="more-filters-title"><%= MyBase.GetResourceString("C_SelectMoreFilters") %></div>
                        <label class="more-filter-option">
                            <input type="checkbox" class="more-filter-checkbox" data-filter-key="businessUnit">
                            <%= MyBase.GetResourceString("C_BusinessUnit") %></label>
                        <label class="more-filter-option">
                            <input type="checkbox" class="more-filter-checkbox" data-filter-key="department">
                            <%= MyBase.GetResourceString("C_Department") %></label>
                        <label class="more-filter-option">
                            <input type="checkbox" class="more-filter-checkbox" data-filter-key="skillsTech">
                            <%= MyBase.GetResourceString("C_SkillsTechnology") %></label>
                        <label class="more-filter-option">
                            <input type="checkbox" class="more-filter-checkbox" data-filter-key="experienceBand">
                            <%= MyBase.GetResourceString("C_Experience") %></label>
                        <label class="more-filter-option">
                            <input type="checkbox" class="more-filter-checkbox" data-filter-key="availabilityStatus">
                            <%= MyBase.GetResourceString("C_Availability") %></label>
                        <label class="more-filter-option">
                            <input type="checkbox" class="more-filter-checkbox" data-filter-key="benchDuration">
                            <%= MyBase.GetResourceString("C_BenchDuration") %></label>
                    </div>
                </div>
            </div>
            <div class="filters-row">
                <div class="filter-group">
                    <label>Department/Unit</label>
                    <%--Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor--%>
                    <div class="bench-dept-multiselect" id="benchDeptFilterWrap">
                        <button type="button" class="bench-dept-toggle" id="benchDeptToggle">Select Department/Unit</button>
                        <div class="bench-dept-panel" id="benchDeptPanel" style="display: none;">
                            <div class="bench-dept-search-wrap">
                                <input type="text" id="benchDeptSearch" placeholder="Search" autocomplete="off" />
                            </div>
                            <div class="bench-dept-list" id="benchDeptList"></div>
                        </div>
                    </div>
                    <%--End of Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor--%>
                </div>                
                <div class="filter-group">
                    <label><%= MyBase.GetResourceString("C_Grade") %></label>
                    <%--Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor--%>
                    <div class="bench-ms-multiselect" id="benchGradeFilterWrap">
                        <button type="button" class="bench-ms-toggle" id="benchGradeToggle">Select Grade</button>
                        <div class="bench-ms-panel" id="benchGradePanel" style="display: none;">
                            <div class="bench-ms-search-wrap">
                                <input type="text" id="benchGradeSearch" placeholder="Search" autocomplete="off" />
                            </div>
                            <div class="bench-ms-list" id="benchGradeList"></div>
                        </div>
                    </div>
                    <%--End of Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor--%>
                </div>
                <div class="filter-group">
                    <label>Business Group</label>
                    <%--Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor--%>
                    <div class="bench-ms-multiselect" id="benchBgFilterWrap">
                        <button type="button" class="bench-ms-toggle" id="benchBgToggle">Select Business Group</button>
                        <div class="bench-ms-panel" id="benchBgPanel" style="display: none;">
                            <div class="bench-ms-search-wrap">
                                <input type="text" id="benchBgSearch" placeholder="Search" autocomplete="off" />
                            </div>
                            <div class="bench-ms-list" id="benchBgList"></div>
                        </div>
                    </div>
                    <%--End of Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor--%>
                </div>
                <div class="filter-group">
                    <label>Organization Unit</label>
                    <%--Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor--%>
                    <div class="bench-ms-multiselect" id="benchLocationFilterWrap">
                        <button type="button" class="bench-ms-toggle" id="benchLocationToggle">Select Location</button>
                        <div class="bench-ms-panel" id="benchLocationPanel" style="display: none;">
                            <div class="bench-ms-search-wrap">
                                <input type="text" id="benchLocationSearch" placeholder="Search" autocomplete="off" />
                            </div>
                            <div class="bench-ms-list" id="benchLocationList"></div>
                        </div>
                    </div>
                    <%--End of Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor--%>
                </div>
                <div class="filter-group">
                    <label>Designation</label>
                    <%--Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor--%>
                    <div class="bench-ms-multiselect" id="benchDesignationFilterWrap">
                        <button type="button" class="bench-ms-toggle" id="benchDesignationToggle">Select Designation</button>
                        <div class="bench-ms-panel" id="benchDesignationPanel" style="display: none;">
                            <div class="bench-ms-search-wrap">
                                <input type="text" id="benchDesignationSearch" placeholder="Search" autocomplete="off" />
                            </div>
                            <div class="bench-ms-list" id="benchDesignationList"></div>
                        </div>
                    </div>
                    <%--End of Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor--%>
                </div>                
                <div class="filter-group">
                    <label><%= MyBase.GetResourceString("C_EmployeeNameCode") %></label>
                    <div class="filter-search-wrap">
                        <i class="fas fa-search"></i>
                        <input type="text" class="filter-search" id="filterSearch" placeholder="<%= MyBase.GetResourceString("C_SearchByNameOrCode") %>">
                    </div>
                </div>
                <div id="dynamicFiltersHost"></div>
            </div>
        </div>

        <!-- TABLE -->
        <%--Added by Vishal Mane on 26/05/2026 to fix the static header part--%>
        <div class="table-section bench-table-section">
            <div class="table-header">
                <div>
                    <span class="table-title"><%= MyBase.GetResourceString("C_BenchResources") %></span>
                    <span class="table-count" id="tableCount"></span>
                </div>
            </div>
            <div class="table-responsive bench-table-scroll">
                <table id="benchTable">
                    <thead>
                        <tr>
                            <th><%= MyBase.GetResourceString("C_EmployeeName") %></th>
                            <th><%= MyBase.GetResourceString("C_EmployeeCode") %></th>
                            <th>Department/Unit</th>
                            <th>Grade</th>                            
                            <th>Designation</th>
                            <th>Business Group</th>
                            <th>Organization Unit</th>
                            <th><%= MyBase.GetResourceString("C_AvailablePercent") %></th>
                            <th><%= MyBase.GetResourceString("C_BenchStartDate") %></th>
                            <th><%= MyBase.GetResourceString("C_TentativeLeavingDate") %></th>
                            <th><%= MyBase.GetResourceString("C_AgingInDays") %></th>
                            <th><%= MyBase.GetResourceString("C_BenchStatus") %></th>
                            <th><%= MyBase.GetResourceString("C_Remarks") %></th>
                            <th><%= MyBase.GetResourceString("C_Action") %></th>
                        </tr>
                    </thead>
                    <tbody id="tableBody"></tbody>
                </table>
            </div>
            <div class="table-footer">
                <div class="page-info" id="pageInfo"></div>
                <div class="pagination-btns" id="pagination"></div>
            </div>
        </div>

    </div>
    <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%= MyBase.GetResourceString("C_NoAccess") %></p>
        </div>
    </div>
    <%End If %>
    <!-- TOAST -->
    <div class="toast-wrap" id="toastWrap"></div>

    <!-- View Details offcanvas -->
    <div class="offcanvas offcanvas-end detail-offcanvas" data-bs-scroll="true" tabindex="-1" id="offcvsBenchDetails">
        <div class="offcanvas-header graybg">
            <h5 class="offcanvas-title"><%= MyBase.GetResourceString("C_ResourceHistoryDetails") %></h5>
            <span  data-bs-dismiss="offcanvas" aria-label="<%= MyBase.GetResourceString("C_Close") %>"><i class="fas fa-times"></i></span>
            <%--<button type="button" data-bs-dismiss="offcanvas" aria-label="<%= MyBase.GetResourceString("C_Close") %>"></button>--%>
        </div>
        <div class="offcanvas-body">
            <input type="hidden" id="hiddenBenchHistoryUserId" value="" />
            <div class="accordion detail-accordion" id="benchDetailsAccordion">
                <div class="accordion-item" hidden>
                    <h2 class="accordion-header" id="detailsHeading">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#detailsCollapse" aria-expanded="true" aria-controls="detailsCollapse">
                            <%= MyBase.GetResourceString("C_Details") %>
                        </button>
                    </h2>
                    <div id="detailsCollapse" class="accordion-collapse collapse show" aria-labelledby="detailsHeading">
                        <div class="accordion-body">
                            <div class="details-actions">
                                <button type="button" class="btn btnyellow" id="btnDetailsSave"><%= MyBase.GetResourceString("C_Save") %></button>
                            </div>
                            <div class="detail-grid" id="benchDetailsBody"></div>
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header" id="historyHeading">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#historyCollapse" aria-expanded="false" aria-controls="historyCollapse">
                            <%= MyBase.GetResourceString("C_History") %>
                        </button>
                    </h2>
                    <div id="historyCollapse" class="accordion-collapse collapse" aria-labelledby="historyHeading">
                        <div class="accordion-body">
                            <div class="history-filter-row row d-flex justify-content-center mt-3">
                                <div class="col-sm-5">
                                    <div class="row form-group">
                                        <div class="col-sm-5 d-flex justify-content-end">
                                            <label><%= MyBase.GetResourceString("C_ModifiedFieldLabel") %></label>
                                        </div>
                                        <div class="col-sm-7 px-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("modifiedHisField", "Select 1",,, "onchange='onChngDrpdown()' class='form-control selectpicker' data-live-search='true'",,,) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-5">
                                    <div class="row form-group">
                                        <div class="col-sm-5 d-flex justify-content-end">
                                            <label><%= MyBase.GetResourceString("C_ModifiedByLabel") %></label>
                                        </div>
                                        <div class="col-sm-7 px-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("modifiedHisBy", "Select 1",,, "onchange='onChngDrpdown()' class='form-control selectpicker' data-live-search='true'",,,) %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table id="cityShowHisTable" class="table table-bordered" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th><%= MyBase.GetResourceString("C_ModifiedField") %></th>
                                            <th><%= MyBase.GetResourceString("C_OldValue") %></th>
                                            <th><%= MyBase.GetResourceString("C_NewValue") %></th>
                                            <th><%= MyBase.GetResourceString("C_ModifiedDate") %></th>
                                            <th><%= MyBase.GetResourceString("C_ModifiedBy") %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="cityhistory"></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>

    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>

    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>
        const AVATAR_CLASS = ['avatar-0', 'avatar-1', 'avatar-2', 'avatar-3', 'avatar-4', 'avatar-5', 'avatar-6', 'avatar-7'];
        const EXTRA_FILTER_CONFIG = {
            businessUnit: { label: 'Business Unit', id: 'filterBusinessUnit', options: ['Enterprise Apps', 'Digital', 'Data', 'Infra'] },
            department: { label: 'Department', id: 'filterDepartment', options: ['Engineering', 'QA', 'Design', 'DevOps', 'Analytics'] },
            skillsTech: { label: 'Skills / Technology', id: 'filterSkillsTech', options: ['React', 'Node.js', 'Java', '.NET', 'Python', 'AWS'] },
            experienceBand: { label: 'Experience', id: 'filterExperienceBand', options: ['0-3 Years', '3-5 Years', '5-8 Years', '8+ Years'] },
            availabilityStatus: { label: 'Availability', id: 'filterAvailabilityStatus', options: ['Immediate', 'Near Term', 'Planned'] },
            benchDuration: { label: 'Bench Duration', id: 'filterBenchDuration', options: ['0-15 Days', '16-30 Days', '31+ Days'] }
        };
        const BENCH_DATA = [];
        // Bench status master from GetBenchStatus — loaded once and reused by getBenchStatusSelectHtml / buildRow.
        var benchStatusMasterList = null;
        var cityHistoryTable = null;

        // Added Loader by Vishal Mane on 26/05/2026
        var loaderShown = false;
        var loaderStartTime = 0;
        var benchLoaderCount = 0;

        function showLoader() {
            benchLoaderCount++;
            var loaderEl = document.getElementById('loaderOverlay');
            if (loaderEl) {
                loaderEl.style.display = 'block';
            }
            if (benchLoaderCount === 1) {
                loaderShown = true;
                loaderStartTime = Date.now();
            }
        }

        function hideLoader() {
            if (benchLoaderCount <= 0) {
                return;
            }
            benchLoaderCount--;
            if (benchLoaderCount > 0) {
                return;
            }
            var loaderEl = document.getElementById('loaderOverlay');
            var hideOverlay = function () {
                if (loaderEl) {
                    loaderEl.style.display = 'none';
                }
                loaderShown = false;
            };
            if (!loaderShown) {
                hideOverlay();
                return;
            }
            var elapsedTime = Date.now() - loaderStartTime;
            var minDisplayTime = 500;
            if (elapsedTime < minDisplayTime) {
                setTimeout(hideOverlay, minDisplayTime - elapsedTime);
            } else {
                hideOverlay();
            }
        }

        function runWithLoader(workFn) {
            showLoader();
            setTimeout(function () {
                try {
                    if (typeof workFn === 'function') {
                        workFn();
                    }
                } catch (ex) {
                    console.error(ex);
                } finally {
                    hideLoader();
                }
            }, 0);
        }
        //End of Added Loader by Vishal Mane on 26/05/2026

        $(document).ready(function () {
            //Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor
            initBenchMsFilters();
            //End of Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor
            // Added Loader by Vishal Mane on 26/05/2026
            runWithLoader(function () {
                loadBenchResourcesData(1);
                loadBenchLocationDropdown();
            });
            //End of Added Loader by Vishal Mane on 26/05/2026
        });

        //Added by Vishal Mane on 12/05/2026 to format API/SP date values for grid display
        function formatBenchDate(value) {
            if (value === undefined || value === null || value === '') return '—';
            var dt = new Date(value);
            if (isNaN(dt.getTime())) return value;
            return dt.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
        }

        ////Added by Vishal Mane on 12/05/2026 to prepare initials for employee avatar
        function getBenchInitials(employeeName) {
            var name = String(employeeName || '').trim();
            if (name === '') {
                return '--';
            }
            var parts = name.split(/\s+/);
            //------------------------------------------------------------
            // Single word
            //------------------------------------------------------------
            if (parts.length === 1) {
                return parts[0].charAt(0).toUpperCase();
            }
            //------------------------------------------------------------
            // Two or more words
            // Take First + Last word initials
            //------------------------------------------------------------
            return (
                parts[0].charAt(0) +
                parts[parts.length - 1].charAt(0)
            ).toUpperCase();
        }

        //Added by Vishal Mane on 13/05/2026 for inline row save (ISO date fragment for API).
        function toBenchDateIso(value) {
            if (value === undefined || value === null || value === '') return '';
            var s = typeof value === 'string' ? value : String(value);
            if (s.indexOf('/Date(') === 0) {
                var m = /\/Date\((\d+)\)\//.exec(s);
                if (m) {
                    var d = new Date(parseInt(m[1], 10));
                    if (!isNaN(d.getTime())) return d.toISOString().split('T')[0];
                }
            }
            var dt = new Date(s);
            if (!isNaN(dt.getTime())) return dt.toISOString().split('T')[0];
            var idx = s.indexOf('T');
            if (idx > 0) return s.substring(0, 10);
            return s.length >= 10 ? s.substring(0, 10) : s;
        }

        function escapeBenchHtmlText(val) {
            return String(val == null ? '' : val)
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;');
        }

        function escapeBenchHtmlAttr(val) {
            return String(val == null ? '' : val)
                .replace(/&/g, '&amp;')
                .replace(/"/g, '&quot;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;');
        }

        //Added by Vishal Mane on 13/05/2026 to normalize status code/text from API row.
        function normalizeBenchStatusValue(rawStatus) {
            if (rawStatus === undefined || rawStatus === null) return 'Bench';
            var statusText = String(rawStatus).trim();
            if (!statusText) return 'Bench';

            if (/^\d+$/.test(statusText)) {
                var statusCode = parseInt(statusText, 10);
                switch (statusCode) {
                    case 1: return 'Full Bench';
                    case 2: return 'Partial Bench';
                    case 3: return 'Shadow';
                    case 4: return 'Bench';
                    case 5: return 'Allocated';
                    default: return statusText;
                }
            }
            return statusText;
        }

        //Added by Vishal Mane on 12/05/2026 to convert SP/API row into existing BENCH_DATA object structure
        var GlobalAllocationPer = 0;
        function mapBenchResourceRow(row) {
            var totalAllocation = parseFloat(getBenchApiProp(row, 'TotalAllocation', 'totalAllocation') || 0);
            GlobalAllocationPer = totalAllocation;
            var availablePercentage = parseFloat(getBenchApiProp(row, 'AvailablePercentage', 'availablePercentage') || 0);
            var agingDays = parseInt(getBenchApiProp(row, 'AgingDays', 'agingDays') || 0, 10);
            var benchStatusRaw = getBenchApiProp(row, 'BenchStatus', 'benchStatus');
            var benchState = normalizeBenchStatusValue(benchStatusRaw);
            var rowRemarks = getBenchApiProp(row, 'Remarks', 'remarks') || getBenchApiProp(row, 'Remark', 'remark') || '';
            var employeeName = getBenchApiProp(row, 'EmployeeName', 'employeeName') || '';
            var employeeId = getBenchApiProp(row, 'EmployeeID', 'employeeID');
            return {
                employeeID: employeeId,
                name: employeeName,
                initials: getBenchInitials(employeeName),
                empId: getBenchApiProp(row, 'EmployeeCode', 'employeeCode') || employeeId || '',
                cbu: getBenchApiProp(row, 'CBUName', 'cbuName') || '—',
                vertical: getBenchApiProp(row, 'VerticalName', 'verticalName'),
                subVertical: getBenchApiProp(row, 'SubVerticalName', 'subVerticalName') || '—',
                grade: (function () {
                    var gradeVal = getBenchApiProp(row, 'GradeDescription', 'gradeDescription') || getBenchApiProp(row, 'Grade', 'grade');
                    if (gradeVal === undefined || gradeVal === null || String(gradeVal).trim() === '') return '—';
                    return String(gradeVal);
                })(),
                role: getBenchApiProp(row, 'Role', 'role') || '—',
                skills: getBenchApiProp(row, 'ToolsExperience', 'toolsExperience') ? [getBenchApiProp(row, 'ToolsExperience', 'toolsExperience')] : [],
                exp: getBenchApiProp(row, 'RelevantExperience', 'relevantExperience') || getBenchApiProp(row, 'CurrentCompanyExperience', 'currentCompanyExperience') || '',
                status: benchState,
                benchStart: formatBenchDate(getBenchApiProp(row, 'BenchStartDate', 'benchStartDate')),
                benchStartDateIso: toBenchDateIso(getBenchApiProp(row, 'BenchStartDate', 'benchStartDate')),
                agingDays: isNaN(agingDays) ? 0 : agingDays,
                alloc: isNaN(totalAllocation) ? 0 : totalAllocation,
                avail: isNaN(availablePercentage) ? 0 : availablePercentage,
                lastProject: '',
                availability: availablePercentage >= 100 ? 'Immediate' : 'Partial',
                tentLeaving: formatBenchDate(getBenchApiProp(row, 'TentativeLeavingDate', 'tentativeLeavingDate') || getBenchApiProp(row, 'LeavingDate', 'leavingDate')),
                location: getBenchApiProp(row, 'Location', 'location') || getBenchApiProp(row, 'CurrentLocationName', 'currentLocationName') || '—',
                businessGroupID: getBenchApiProp(row, 'BusinessGroupID', 'businessGroupID') || null,
                departmentID: getBenchApiProp(row, 'DepartmentID', 'departmentID') || null,
                remarks: rowRemarks,
                benchStatus: benchStatusRaw,
                department: (function () {
                    var deptVal = getBenchApiProp(row, 'Department', 'department');
                    if (deptVal === undefined || deptVal === null || String(deptVal).trim() === '') return '—';
                    return String(deptVal);
                })(),
                designationName: getBenchApiProp(row, 'DesignationName', 'designationName') || '',
                businessGroup: getBenchApiProp(row, 'BusinessGroup', 'businessGroup') || '',

            };
        }

        //Added by Vishal Mane on 12/05/2026 to enrich dynamic BENCH_DATA with filter helper fields
        function prepareBenchData() {
            BENCH_DATA.forEach((e) => {
                // department, businessGroup, designationName, location come from API via mapBenchResourceRow — do not overwrite with placeholder values.
                e.businessUnit = e.businessGroup || '';
                e.skillsTech = (e.skills && e.skills.length > 0) ? e.skills[0] : '';
                e.experienceBand = (() => {
                    const yrs = parseFloat(e.exp);
                    if (isNaN(yrs)) return '';
                    if (yrs < 3) return '0-3 Years';
                    if (yrs < 5) return '3-5 Years';
                    if (yrs < 8) return '5-8 Years';
                    return '8+ Years';
                })();
                e.availabilityStatus = e.availability === 'Immediate' ? 'Immediate' : (e.availability === '—' ? 'Planned' : 'Near Term');
                e.benchDuration = e.agingDays <= 15 ? '0-15 Days' : (e.agingDays <= 30 ? '16-30 Days' : '31+ Days');
            });
        }

        //Added by Vishal Mane on 12/05/2026 to safely read selected filter ID values.
        //If dropdown value is blank, undefined, null, or non-numeric, null is passed to API/SP.
        function getNullableFilterID(selector) {
            var value = $(selector).val();
            if (value === undefined || value === null || value === '') return null;

            var parsedValue = parseInt(value, 10);
            return isNaN(parsedValue) ? null : parsedValue;
        }

        //Added by Vishal Mane on 12/05/2026 to safely read selected text/value filters.
        function getNullableFilterText(selector) {
            //debugger
            var value = $(selector).val();
            if (value === undefined || value === null || value === '') return null;
            return value;
        }

        //Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor
        var BENCH_MS_FILTER_CONFIG = {
            department: {
                apiUrl: '/api/RM_BenchResourceManagement/GetDepartments',
                wrap: '#benchDeptFilterWrap',
                toggle: '#benchDeptToggle',
                panel: '#benchDeptPanel',
                search: '#benchDeptSearch',
                list: '#benchDeptList',
                idKeys: ['DepartmentID', 'departmentID'],
                nameKeys: ['Department', 'department'],
                placeholder: 'Select Department/Unit',
                paramName: 'DepartmentID',
                emptyText: 'No departments found'
            },
            grade: {
                apiUrl: '/api/RM_BenchResourceManagement/GetGrades',
                wrap: '#benchGradeFilterWrap',
                toggle: '#benchGradeToggle',
                panel: '#benchGradePanel',
                search: '#benchGradeSearch',
                list: '#benchGradeList',
                idKeys: ['GradeID', 'gradeID'],
                nameKeys: ['Grade', 'grade'],
                placeholder: 'Select Grade',
                paramName: 'GradeID',
                emptyText: 'No grades found'
            },
            businessGroup: {
                apiUrl: '/api/RM_BenchResourceManagement/GetBusinessGroups',
                wrap: '#benchBgFilterWrap',
                toggle: '#benchBgToggle',
                panel: '#benchBgPanel',
                search: '#benchBgSearch',
                list: '#benchBgList',
                idKeys: ['BusinessGroupID', 'businessGroupID'],
                nameKeys: ['BusinessGroup', 'businessGroup'],
                placeholder: 'Select Business Group',
                paramName: 'BusinessGroupID',
                emptyText: 'No business groups found',
                onSelectionChange: bindCboLocationByBusinessGroup
            },
            designation: {
                apiUrl: '/api/RM_BenchResourceManagement/GetDesignations',
                wrap: '#benchDesignationFilterWrap',
                toggle: '#benchDesignationToggle',
                panel: '#benchDesignationPanel',
                search: '#benchDesignationSearch',
                list: '#benchDesignationList',
                idKeys: ['DesignationID', 'designationID'],
                nameKeys: ['DesignationName', 'designationName'],
                placeholder: 'Select Designation',
                paramName: 'DesignationID',
                emptyText: 'No designations found'
            },
            location: {
                isDynamic: true,
                wrap: '#benchLocationFilterWrap',
                toggle: '#benchLocationToggle',
                panel: '#benchLocationPanel',
                search: '#benchLocationSearch',
                list: '#benchLocationList',
                idKeys: ['OUPoolID', 'ouPoolID'],
                nameKeys: ['Location', 'location'],
                placeholder: 'Select Location',
                paramName: 'LocationID',
                emptyText: 'No locations found'
            }
        };

        var benchMsFilterData = { department: [], grade: [], businessGroup: [], designation: [], location: [] };

        function getBenchMsRowProp(row, keys) {
            if (!row || !keys) return undefined;
            for (var i = 0; i < keys.length; i++) {
                var val = getBenchApiProp(row, keys[i], keys[i].charAt(0).toLowerCase() + keys[i].slice(1));
                if (val !== undefined && val !== null) return val;
            }
            return undefined;
        }

        function loadBenchMsFilter(filterKey) {
            var cfg = BENCH_MS_FILTER_CONFIG[filterKey];
            if (!cfg || cfg.isDynamic) return;
            var rows = AJAXCallWithResult(cfg.apiUrl, '', false);
            benchMsFilterData[filterKey] = parseBenchHistoryApiArray(rows);
            renderBenchMsFilterList(filterKey);
            updateBenchMsToggleLabel(filterKey);
        }

        function renderBenchMsFilterList(filterKey) {
            var cfg = BENCH_MS_FILTER_CONFIG[filterKey];
            if (!cfg) return;
            var options = benchMsFilterData[filterKey] || [];
            var html = '';
            for (var i = 0; i < options.length; i++) {
                var row = options[i] || {};
                var itemId = getBenchMsRowProp(row, cfg.idKeys);
                var itemName = getBenchMsRowProp(row, cfg.nameKeys);
                if (itemId === undefined || itemId === null) continue;
                var idNum = parseInt(itemId, 10);
                if (isNaN(idNum) || idNum <= 0) continue;
                var nameRaw = itemName == null ? '' : String(itemName);
                var safeName = escapeBenchHtmlText(nameRaw);
                html += '<label class="bench-ms-option" data-filter-key="' + filterKey + '" data-search-name="' + escapeBenchHtmlAttr(nameRaw) + '">' +
                    '<input type="checkbox" class="bench-ms-chk" data-filter-key="' + filterKey + '" value="' + String(idNum) + '" />' +
                    '<span>' + safeName + '</span></label>';
            }
            if (!html) {
                html = '<div class="bench-ms-option" style="cursor:default;">' + escapeBenchHtmlText(cfg.emptyText) + '</div>';
            }
            $(cfg.list).html(html);
            filterBenchMsFilterList(filterKey, $(cfg.search).val());
        }

        function filterBenchMsFilterList(filterKey, searchText) {
            var cfg = BENCH_MS_FILTER_CONFIG[filterKey];
            if (!cfg) return;
            var q = String(searchText || '').trim().toLowerCase();
            $(cfg.list + ' .bench-ms-option').each(function () {
                var name = String($(this).data('search-name') || '').toLowerCase();
                $(this).toggleClass('hidden-by-search', q !== '' && name.indexOf(q) === -1);
            });
        }

        function getBenchMsFilterCsv(filterKey) {
            var cfg = BENCH_MS_FILTER_CONFIG[filterKey];
            if (!cfg) return null;
            var ids = [];
            $(cfg.list + ' .bench-ms-chk:checked').each(function () {
                var parsedValue = parseInt($(this).val(), 10);
                if (!isNaN(parsedValue) && parsedValue > 0) {
                    ids.push(String(parsedValue));
                }
            });
            return ids.length > 0 ? ids.join(',') : null;
        }

        function updateBenchMsToggleLabel(filterKey) {
            var cfg = BENCH_MS_FILTER_CONFIG[filterKey];
            if (!cfg) return;
            var selectedNames = [];
            $(cfg.list + ' .bench-ms-chk:checked').each(function () {
                var label = $(this).closest('.bench-ms-option').find('span').first().text();
                if (label) selectedNames.push(label);
            });
            var text = selectedNames.length === 0
                ? cfg.placeholder
                : (selectedNames.length === 1 ? selectedNames[0] : selectedNames.length + ' selected');
            $(cfg.toggle).text(text);
        }

        function resetBenchMsFilter(filterKey) {
            var cfg = BENCH_MS_FILTER_CONFIG[filterKey];
            if (!cfg) return;
            $(cfg.list + ' .bench-ms-chk').prop('checked', false);
            $(cfg.search).val('');
            filterBenchMsFilterList(filterKey, '');
            updateBenchMsToggleLabel(filterKey);
        }

        function resetAllBenchMsFilters() {
            for (var key in BENCH_MS_FILTER_CONFIG) {
                if (BENCH_MS_FILTER_CONFIG.hasOwnProperty(key)) {
                    resetBenchMsFilter(key);
                }
            }
        }

        function initBenchMsFilters() {
            for (var filterKey in BENCH_MS_FILTER_CONFIG) {
                if (!BENCH_MS_FILTER_CONFIG.hasOwnProperty(filterKey)) continue;
                (function (key) {
                    var cfg = BENCH_MS_FILTER_CONFIG[key];
                    if (!cfg.isDynamic) {
                        loadBenchMsFilter(key);
                    }
                    $(cfg.toggle).on('click', function (e) {
                        e.stopPropagation();
                        $(cfg.panel).toggle();
                    });
                    $(cfg.search).on('input', function () {
                        filterBenchMsFilterList(key, $(this).val());
                    });
                })(filterKey);
            }

            $(document).on('change', '.bench-ms-chk', function () {
                var filterKey = $(this).data('filter-key');
                updateBenchMsToggleLabel(filterKey);
                var cfg = BENCH_MS_FILTER_CONFIG[filterKey];
                if (cfg && cfg.onSelectionChange) {
                    cfg.onSelectionChange();
                }
            });

            $(document).on('click', function (e) {
                for (var key in BENCH_MS_FILTER_CONFIG) {
                    if (!BENCH_MS_FILTER_CONFIG.hasOwnProperty(key)) continue;
                    var cfg = BENCH_MS_FILTER_CONFIG[key];
                    if (!$(e.target).closest(cfg.wrap).length) {
                        $(cfg.panel).hide();
                    }
                }
            });
        }
        //End of Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor

        //Added by Vishal Mane on 25/05/2026 — bind location from usp_Whizible2_Sel_OU_BRM (@BusinessGroupID) when business group changes.
        function loadBenchLocationDropdown() {
            //Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor
            var businessGroupId = getBenchMsFilterCsv('businessGroup');
            if (!businessGroupId) {
                //When no Business Group is selected, Location must be cleared (no stale values/selections).
                benchMsFilterData.location = [];
                renderBenchMsFilterList('location');
                updateBenchMsToggleLabel('location');
                return;
            }

            var payload = JSON.stringify({ BusinessGroupID: businessGroupId });
            var rows = AJAXCallWithResult(
                '/api/RM_BenchResourceManagement/GetOrganizationUnitsByBusinessGroup',
                payload,
                false
            );
            benchMsFilterData.location = parseBenchHistoryApiArray(rows);
            renderBenchMsFilterList('location');
            updateBenchMsToggleLabel('location');
            //End of Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor
        }

        function bindCboLocationByBusinessGroup() {
            runWithLoader(function () {
                loadBenchLocationDropdown();
            });
        }

        //Added by Vishal Mane on 12/05/2026 to pass all static filter parameters to GetBenchResources API.
        function buildBenchResourceFilterParams(pageNo) {
            //debugger
            //Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor
            var benchFilterParams = {
                PageNo: pageNo || 1,
                PageSize: PAGE_SIZE,
                IsExport: 0,
                SearchText: getNullableFilterText('#filterSearch')
            };
            for (var filterKey in BENCH_MS_FILTER_CONFIG) {
                if (!BENCH_MS_FILTER_CONFIG.hasOwnProperty(filterKey)) continue;
                var cfg = BENCH_MS_FILTER_CONFIG[filterKey];
                var csvIds = getBenchMsFilterCsv(filterKey);
                if (csvIds) {
                    benchFilterParams[cfg.paramName] = csvIds;
                }
            }
            //End of Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor
            return benchFilterParams;
        }

        // Added by Vishal Mane on 25/05/2026 — normalize W27 API camelCase vs legacy PascalCase response.
        function getBenchApiProp(obj, pascalKey, camelKey) {
            if (!obj) return undefined;
            if (obj[pascalKey] !== undefined) return obj[pascalKey];
            if (camelKey && obj[camelKey] !== undefined) return obj[camelKey];
            return undefined;
        }

        function parseBenchResourceFilteredResult(result) {
            var resourceRows = [];
            var totalCount = 0;
            var summary = null;

            if (!result) {
                return { resourceRows: resourceRows, benchTotalCount: 0, benchSummary: null };
            }
            if (Array.isArray(result)) {
                return { resourceRows: result, benchTotalCount: result.length, benchSummary: null };
            }

            var data = getBenchApiProp(result, 'Data', 'data');
            var countData = getBenchApiProp(result, 'CountData', 'countData');
            summary = getBenchApiProp(result, 'Summary', 'summary');

            if (Array.isArray(data)) {
                resourceRows = data;
            }

            var totalCountRaw = getBenchApiProp(result, 'TotalCount', 'totalCount');
            if (totalCountRaw !== undefined && totalCountRaw !== null && totalCountRaw !== '') {
                totalCount = parseInt(totalCountRaw, 10);
            } else if (Array.isArray(countData) && countData.length > 0) {
                var countRow = countData[0] || {};
                totalCount = parseInt(getBenchApiProp(countRow, 'TotalCount', 'totalCount') || 0, 10);
            }

            if (isNaN(totalCount)) {
                totalCount = 0;
            }

            return { resourceRows: resourceRows, benchTotalCount: totalCount, benchSummary: summary };
        }

        function ensureBenchStatusMasterLoaded() {
            if (benchStatusMasterList !== null) {
                return benchStatusMasterList;
            }
            var data = AJAXCallWithResult("/api/RM_BenchResourceManagement/GetBenchStatus", '', false);
            if (!data) {
                benchStatusMasterList = [];
                return benchStatusMasterList;
            }
            if (!Array.isArray(data)) {
                benchStatusMasterList = [];
                return benchStatusMasterList;
            }
            benchStatusMasterList = data;
            return benchStatusMasterList;
        }

        function loadBenchResourcesData(pageNo) {
            //Added by Vishal Mane on 12/05/2026 to bind BENCH_DATA dynamically from API instead of static data
            //debugger
            pageNo = pageNo || 1;
            ensureBenchStatusMasterLoaded();
            var benchParams = buildBenchResourceFilterParams(pageNo);
            var Result = AJAXCallWithResult("/api/RM_BenchResourceManagement/GetBenchResources_Filtered", JSON.stringify(benchParams), false);
            var parsed = parseBenchResourceFilteredResult(Result);
            var resourceRows = parsed.resourceRows;
            benchTotalCount = parsed.benchTotalCount;
            benchSummary = parsed.benchSummary;

            //Modified by Vishal Mane on 12/05/2026.
            //Always clear old/static rows first, so null or empty API results show No Data available.
            BENCH_DATA.length = 0;
            if (resourceRows && resourceRows.length > 0) {
                resourceRows.forEach(function (row) {
                    BENCH_DATA.push(mapBenchResourceRow(row));
                });
            }
            prepareBenchData();
            if (typeof filteredData !== 'undefined') {
                filteredData = [...BENCH_DATA];
                currentPage = pageNo;
            }
            if (typeof renderTable === 'function') {
                renderTable();
            }
            if (typeof updateKPIs === 'function') {
                updateKPIs();
            }
        }

        function GetBenchResources(pageNo) {
            runWithLoader(function () {
                loadBenchResourcesData(pageNo);
            });
        }
        let filteredData = [...BENCH_DATA];
        const PAGE_SIZE = 10;
        let currentPage = 1;
        let benchTotalCount = BENCH_DATA.length;
        let benchSummary = null;

        function getAgingClass(days) {
            if (days >= 30) return 'high';
            if (days >= 10) return 'medium';
            return 'low';
        }

        function getAllocColorClass(pct) {
            if (pct === 0) return 'empty';
            if (pct <= 40) return 'low';
            return 'high';
        }

        function getAllocWidthClass(pct) {
            const value = Math.max(0, Math.min(100, Math.round(pct / 10) * 10));
            return `w-${value}`;
        }

        function getAvailClass(pct) { return pct === GlobalAllocationPer ? 'full' : 'partial'; }

        function getBenchStatusRowId(row) {
            if (!row) return '';
            if (row.StatusID !== undefined && row.StatusID !== null) return row.StatusID;
            if (row.statusID !== undefined && row.statusID !== null) return row.statusID;
            return '';
        }

        function getBenchStatusRowName(row) {
            if (!row) return '';
            if (row.BenchStatus !== undefined && row.BenchStatus !== null) return row.BenchStatus;
            if (row.benchStatus !== undefined && row.benchStatus !== null) return row.benchStatus;
            return '';
        }

        function getBenchStatusSelectHtml(benchStatusID, BenchStatusName) {
            var list = ensureBenchStatusMasterLoaded();
            //var strHTML = '<select class="bench-status-select selectpicker" data-live-search="true" title="Select Bench Status">';
            //Added by Vishal Mane on 15/05/2026 to render dropdown outside grid container to avoid UI clipping issue
            var strHTML = '<select class="bench-status-select selectpicker" data-live-search="true" data-container="body" title="Select Bench Status">';
            var currentId = benchStatusID !== undefined && benchStatusID !== null ? String(benchStatusID) : '';
            var isStatusFound = false;    // Added by Vishal Mane on 10/06/2026 to display old Bench Status even if it is no longer available in master data.
            for (var i = 0; i < list.length; i++) {
                var listComponent = list[i];
                var sid = getBenchStatusRowId(listComponent);
                var sname = getBenchStatusRowName(listComponent);
                // Added by Vishal Mane on 10/06/2026 to display old Bench Status even if it is no longer available in master data.
                if (String(sid) === currentId) {
                    isStatusFound = true;
                }
                // End of Added by Vishal Mane on 10/06/2026 to display old Bench Status even if it is no longer available in master data.
                var selected = (String(sid) === currentId) ? 'selected' : '';
                var safeVal = String(sid).replace(/"/g, '&quot;');
                strHTML += '<option value="' + safeVal + '" ' + selected + '>' + escapeBenchHtmlText(sname) + '</option>';
            }

            // Added by Vishal Mane on 10/06/2026 to display old Bench Status even if it is no longer available in master data.
            if (
                !isStatusFound &&
                currentId !== '' &&
                BenchStatusName !== undefined &&
                BenchStatusName !== null &&
                BenchStatusName !== ''
            )
            {

                strHTML += '<option value="' + currentId.replace(/"/g, '&quot;') + '" selected>'
                    + escapeBenchHtmlText(BenchStatusName)
                    + '</option>';
            }
            // End of Added by Vishal Mane on 10/06/2026 to display old Bench Status even if it is no longer available in master data.

            strHTML += '</select>';
            return strHTML;
        }

        function buildRow(emp, idx) {
            //debugger
            const BenchStatusName = emp.vertical;
            const avatarClass = AVATAR_CLASS[idx % AVATAR_CLASS.length];
            const agingClass = getAgingClass(emp.agingDays);
            const availClass = getAvailClass(emp.avail);
            const statusSelect = getBenchStatusSelectHtml(emp.benchStatus, BenchStatusName);
            const remarksEscaped = escapeBenchHtmlText(emp.remarks);
            var strHTML = "";
            //return `<tr data-emp="${emp.employeeID}" data-employee-id="${emp.employeeID}">
            strHTML += `<tr data-emp="${emp.employeeID}" data-employee-id="${emp.employeeID}">
                      <td>
                        <div class="res-cell">
                          <div class="res-avatar ${avatarClass}">${emp.initials}</div>
                          <div>
                            <div class="res-name">${emp.name}</div>
                          </div>
                        </div>
                      </td>
                      <td><span class="res-id">${emp.empId}</span></td>
                      <td>${emp.department}</td>
                      <td>${emp.grade}</td>
                      <td>${emp.designationName}</td>
                      <td>${emp.businessGroup}</td>
                      
                      <td><div class="loc-cell"><i class="fas fa-location-dot"></i> ${emp.location}</div></td>
                      <td><span class="avail-pct ${availClass}">${emp.avail}%</span></td>
                      <td><span class="date-cell">${emp.benchStart}</span></td>
                      <td><span class="date-cell">${emp.tentLeaving}</span></td>
                      <td><span class="aging-badge ${agingClass}">${emp.agingDays} Days</span></td>`
                   
            if (AddAccess == "True" || EditAccess == "True") {
                strHTML += `<td>${statusSelect}</td>
                 <td>
                    <textarea class="bench-remarks-input"
                              maxlength="500"
                              rows="2"
                              placeholder="Remarks">${remarksEscaped}</textarea>
                 </td>
                 <td>
                    <div class="actions-cell">
                        <div class="action-btn action-save" title="Save">
                            <i class="fas fa-save"></i>
                        </div>`;

            } else {
                //Added by Vishal Mane on 16/05/2026 to make Bench Status and Remarks read-only for users without Add/Edit access
                var disabledStatusSelect = statusSelect.replace(
                    '<select',
                    '<select disabled="disabled"'
                );
                strHTML += `<td>${disabledStatusSelect}</td>
                 <td>
                    <textarea class="bench-remarks-input"
                              maxlength="500"
                              rows="2"
                              placeholder="Remarks"
                              disabled="disabled">${remarksEscaped}</textarea>
                 </td>
                 <td>
                    <div class="actions-cell">
                        <div class="action-btn action-save disabled"
                             title="No Access"
                             style="pointer-events:none;opacity:0.5;">

                            <i class="fas fa-save"></i>

                        </div>`;
            }

            strHTML += `<div class="action-btn action-history" title="History"><i class="fas fa-history"></i></div>
                                            </div >
                                          </td >
                                        </tr >`
            return strHTML;
                        
        }

        //Added by Vishal Mane on 13/05/2026 to save inline row Bench Status / Remarks via API.
        function syncBenchDataFromRow(employeeID, patch) {
            var id = parseInt(employeeID, 10);
            if (isNaN(id)) return;
            [BENCH_DATA, filteredData].forEach(function (arr) {
                if (!arr) return;
                for (var i = 0; i < arr.length; i++) {
                    if (arr[i].employeeID === id) {
                        if (patch.status !== undefined) arr[i].status = patch.status;
                        if (patch.benchStatus !== undefined) arr[i].benchStatus = patch.benchStatus;
                        if (patch.remarks !== undefined) arr[i].remarks = patch.remarks;
                        break;
                    }
                }
            });
        }

        // Added by Vishal Mane on 25/05/2026 — W27 API returns ResponseEntity; legacy API returned plain "success" string.
        function isBenchSaveSuccess(result) {
            if (result == null || result === undefined) return false;

            if (typeof result === 'string') {
                var s = result.replace(/^"|"$/g, '').trim();
                return s.length > 0 && s.toLowerCase().indexOf('success') >= 0;
            }

            var topStatus = getBenchApiProp(result, 'Status', 'status');
            if (topStatus === 1 || String(topStatus).toUpperCase() === 'FAILURE') {
                return false;
            }
            if (topStatus === 0 || String(topStatus).toUpperCase() === 'SUCCESS') {
                return true;
            }

            var data = getBenchApiProp(result, 'Data', 'data');
            if (data != null) {
                if (typeof data === 'string') {
                    var ds = data.replace(/^"|"$/g, '').trim();
                    return ds.toLowerCase().indexOf('success') >= 0;
                }
                var innerStatus = getBenchApiProp(data, 'Status', 'status');
                if (String(innerStatus).toUpperCase() === 'SUCCESS') {
                    return true;
                }
                var msg = getBenchApiProp(data, 'Message', 'message');
                if (msg && String(msg).toLowerCase().indexOf('success') >= 0) {
                    return true;
                }
            }

            return false;
        }

        <%--function getBenchSaveSuccessMessage(result) {
            //Added by Vishal Mane to fix the alert issue comeing from API side
            var defaultMsg = 'Bench Resource details saved successfully';
            //var defaultMsg = <%= MyBase.GetResourceString("A_SavedSuccessfully") %>;
            //if (!result || typeof result !== 'object') return defaultMsg;
            //var data = getBenchApiProp(result, 'Data', 'data');
            //if (data && typeof data === 'object') {
            //    return getBenchApiProp(data, 'Message', 'message') || defaultMsg;
            //}
            return defaultMsg;
        }--%>

        function getBenchSaveErrorMessage(result) {
            if (!result) return 'unknown';
            if (typeof result === 'string') return result;
            var data = getBenchApiProp(result, 'Data', 'data');
            if (data && typeof data === 'object') {
                return getBenchApiProp(data, 'Message', 'message') || JSON.stringify(data);
            }
            if (typeof data === 'string') return data;
            return JSON.stringify(result);
        }

        function saveBenchResourceRow($tr) {
            alertify.set('notifier', 'position', 'top-right');
            var employeeID = parseInt($tr.attr('data-employee-id'), 10);
            if (isNaN(employeeID) || employeeID <= 0) {
                showToast('Invalid employee for save.');
                return;
            }
            var emp = BENCH_DATA.find(function (e) { return e.employeeID === employeeID; });
            if (!emp) {
                showToast('Row data not found.');
                return;
            }
            //var benchStatus = ($tr.find('.bench-status-select').val() || '').trim();
            var benchStatus = $tr.find('.bench-status-select').selectpicker('val') || '';
            var remarks = ($tr.find('.bench-remarks-input').val() || '').substring(0, 500);

            //if (checkSpecialCharacter(remarks.trim(), WebConfigSpecialCharacters) == true) {                
            //    alertify.error('Remarks should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            //    $tr.find('.bench-remarks-input').focus();
            //    return false;
            //}

            if (remarks.length > 500) {
                alertify.error('Remarks cannot exceed 500 characters.');
                $tr.find('.bench-remarks-input').focus();
                return false;
            }

            var payload = {
                EmployeeID: employeeID,
                AvailablePercentage: parseFloat(emp.avail),
                BenchStartDate: emp.benchStartDateIso || '',
                AgingDays: parseInt(emp.agingDays, 10) || 0,
                BenchStatus: benchStatus,
                Remarks: remarks,
                UpdatedBy: (typeof UserName !== 'undefined' && UserName) ? UserName : '',
                UserID: SessionEmployeeId,
            };
            if (isNaN(payload.AvailablePercentage)) payload.AvailablePercentage = 0;
            var requestJson = JSON.stringify(payload);
            runWithLoader(function () {
                var result = AJAXCallWithResult("/api/RM_BenchResourceManagement/SaveBenchResourceDetails", requestJson, false);
                if (isBenchSaveSuccess(result)) {
                    syncBenchDataFromRow(employeeID, { status: benchStatus, benchStatus: benchStatus, remarks: remarks });
                    alertify.success('<%= MyBase.GetResourceString("A_SavedSuccessfully") %>');
                } else {
                    showToast('Save failed: ' + getBenchSaveErrorMessage(result));
                }
            });
        }

        function renderTable() {
            //debugger
            const start = (currentPage - 1) * PAGE_SIZE;
            const displayTotal = benchTotalCount > 0 ? benchTotalCount : filteredData.length;
            const end = Math.min(start + filteredData.length, displayTotal);
            //Added by Vishal Mane on 12/05/2026.
            //BENCH_DATA now contains server-paginated records, so render current page rows directly.
            const pageData = filteredData.slice(0, PAGE_SIZE);
            if (pageData.length === 0) {
                $('#tableBody').html('<tr><td colspan="14" class="text-center">No Data available</td></tr>');
            }
            else {
                $('#tableBody').html(pageData.map((e, i) => buildRow(e, start + i)).join(''));
                $('.selectpicker').selectpicker('refresh');
            }
            $('#tableCount').text(displayTotal);
            $('#pageInfo').text(`Showing ${displayTotal === 0 ? 0 : start + 1}–${end} of ${displayTotal}`);
            renderPagination();
        }

        function renderPagination() {
            const displayTotal = benchTotalCount > 0 ? benchTotalCount : filteredData.length;
            if (displayTotal === 0) {
                $('#pagination').html('');
                return;
            }
            const totalPages = Math.max(1, Math.ceil(displayTotal / PAGE_SIZE));
            //Added by Vishal Mane on 12/05/2026 to show compact pagination instead of all page numbers.
            let html = `<div class="pg-btn ${currentPage === 1 ? 'disabled' : ''}" id="pgFirst" title="First Page">&lt;&lt;</div>`;
            html += `<div class="pg-btn ${currentPage === 1 ? 'disabled' : ''}" id="pgPrev" title="Previous Page">&lt;</div>`;
            html += `<div class="pg-btn active" title="Current Page">${currentPage}</div>`;
            html += `<div class="pg-btn ${currentPage === totalPages ? 'disabled' : ''}" id="pgNext" title="Next Page">&gt;</div>`;
            html += `<div class="pg-btn ${currentPage === totalPages ? 'disabled' : ''}" id="pgLast" title="Last Page">&gt;&gt;</div>`;
            $('#pagination').html(html);
        }

        function applyFilters() {
            //Modified by Vishal Mane on 12/05/2026.
            //Static filters are now applied from API/SP, so reload first page with selected filter IDs.
            GetBenchResources(1);
        }

        function getSummaryNumber(summary, keys, fallbackValue) {
            if (!summary) return fallbackValue;
            for (var i = 0; i < keys.length; i++) {
                var pascalKey = keys[i];
                var camelKey = pascalKey.charAt(0).toLowerCase() + pascalKey.slice(1);
                var value = getBenchApiProp(summary, pascalKey, camelKey);
                if (value !== undefined && value !== null && value !== '') {
                    var parsedValue = parseFloat(value);
                    return isNaN(parsedValue) ? fallbackValue : parsedValue;
                }
            }
            return fallbackValue;
        }

        function updateKpiDelta(selector, currentValue, previousValue) {
            var current = parseFloat(currentValue || 0);
            var previous = parseFloat(previousValue || 0);
            var percent = 0;
            if (previous > 0) {
                percent = ((current - previous) / previous) * 100;
            }
            else if (current > 0) {
                percent = 100;
            }

            var cssClass = percent > 0 ? 'up' : (percent < 0 ? 'down' : 'neutral');
            var iconClass = percent > 0 ? 'fa-arrow-up' : (percent < 0 ? 'fa-arrow-down' : 'fa-minus');
            $(selector)
                .removeClass('up down neutral')
                .addClass(cssClass)
                .html('<i class="fas ' + iconClass + '"></i>' + Math.abs(percent).toFixed(1) + '% vs last week');
        }

        function updateKPIs() {
            //Modified by Vishal Mane on 12/05/2026 to bind KPI counts and "vs last week" percentages dynamically.
            const totalFallback = benchTotalCount > 0 ? benchTotalCount : filteredData.length;
            const criticalFallback = filteredData.filter(e => e.agingDays > 30).length;
            const immediateFallback = filteredData.filter(e => String(e.availability || '').toLowerCase() === 'immediate').length;

            const total = getSummaryNumber(benchSummary, ['TotalBenchResources'], totalFallback);
            const critical = getSummaryNumber(benchSummary, ['CriticalBench'], criticalFallback);
            const immediate = getSummaryNumber(benchSummary, ['AvailableImmediately'], immediateFallback);
            const previousTotal = getSummaryNumber(benchSummary, ['PreviousTotalBenchResources', 'PreviousTotalBench'], 0);
            const previousCritical = getSummaryNumber(benchSummary, ['PreviousCriticalBench'], 0);
            const previousImmediate = getSummaryNumber(benchSummary, ['PreviousAvailableImmediately'], 0);

            $('#kpiTotal').text(total);
            $('#kpiCritical').text(critical);
            $('#kpiImmediate').text(immediate);
            updateKpiDelta('#kpiTotalDelta', total, previousTotal);
            updateKpiDelta('#kpiCriticalDelta', critical, previousCritical);
            updateKpiDelta('#kpiImmediateDelta', immediate, previousImmediate);
        }

        function showToast(msg) {
            const $t = $(`<div class="toast-item">${msg}</div>`);
            $('#toastWrap').append($t);
            setTimeout(() => $t.fadeOut(300, () => $t.remove()), 2500);
        }


        function renderDetails(emp) {
            const labels = {
                name: 'Employee Name',
                empId: 'Employee Code',
                cbu: 'CBU Name',
                vertical: 'Vertical Name',
                subVertical: 'Sub Vertical Name',
                grade: 'Grade',
                location: 'Current Location Name',
                benchStart: 'Bench Start Date',
                tentLeaving: 'Tentative Leaving Date',
                agingDays: 'Aging (in days)',
                status: 'Bench Status',
                avail: 'Available Percentage',
                remarks: 'Remarks'
            };
            const keys = ['name', 'empId', 'cbu', 'vertical', 'subVertical', 'grade', 'location', 'benchStart', 'tentLeaving', 'agingDays', 'status', 'avail', 'remarks'];
            const html = keys.map((key) => {
                let val = emp[key];
                if (key === 'agingDays') val = `${emp.agingDays} Days`;
                if (key === 'avail') val = `${emp.avail}%`;
                if (val === undefined || val === null || val === '') val = '-';
                if (key === 'benchStart' || key === 'tentLeaving') {
                    val = `<span class="date-cell"><i class="far fa-calendar-alt"></i>${val}</span>`;
                }
                if (key === 'status') {
                    return `<div class="detail-item"><div class="detail-key">${labels[key]}</div><div class="detail-value"><select id="detailStatusInput" class="selectpicker" data-live-search="true" data-width="100%"><option value="Bench" ${emp.status === 'Bench' ? 'selected' : ''}>Bench</option><option value="Shadow" ${emp.status === 'Shadow' ? 'selected' : ''}>Shadow</option></select></div></div>`;
                }
                if (key === 'remarks') {
                    const safeVal = String(emp.remarks || '').replace(/"/g, '&quot;');
                    return `<div class="detail-item remarks-row"><div class="detail-key">${labels[key]}</div><div class="detail-value"><textarea id="detailRemarksInput" class="detail-textarea" maxlength="500">${safeVal}</textarea><div class="remarks-limit"><span id="detailRemarksCount">${String(emp.remarks || '').length}</span>/500</div></div></div>`;
                }
                return `<div class="detail-item"><div class="detail-key">${labels[key]}</div><div class="detail-value">${val}</div></div>`;
            }).join('');
            $('#benchDetailsBody').html(html);
            if ($('#detailStatusInput').length) {
                $('#detailStatusInput').selectpicker();
            }
        }

        function renderDynamicFilter(key) {
            const cfg = EXTRA_FILTER_CONFIG[key];
            if (!cfg || document.getElementById(cfg.id)) return;
            const optionsHtml = cfg.options.map(opt => `<option>${opt}</option>`).join('');
            const html = `
                        <div class="filter-group dynamic-filter" id="group-${cfg.id}">
                          <label>${cfg.label}</label>
                          <button type="button" class="remove-dynamic-filter" data-filter-key="${key}" title="Remove">×</button>
                          <select class="selectpicker filter-select dynamic-select" data-live-search="true" data-width="100%" id="${cfg.id}">
                            <option value="">Select ${cfg.label}</option>
                            ${optionsHtml}
                          </select>
                        </div>`;
            $('#dynamicFiltersHost').append(html);
            $(`#${cfg.id}`).selectpicker();
        }

        function removeDynamicFilter(key) {
            const cfg = EXTRA_FILTER_CONFIG[key];
            if (!cfg) return;
            $(`#group-${cfg.id}`).remove();
            $(`.more-filter-checkbox[data-filter-key="${key}"]`).prop('checked', false);
            applyFilters();
        }

        $(function () {
            $('.selectpicker').selectpicker();
            renderTable();

            $('#btnMoreFilters').on('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                $('#moreFiltersPopover').toggleClass('show');
            });

            $(document).on('click', function (e) {
                if (!$(e.target).closest('#btnMoreFilters, #moreFiltersPopover').length) {
                    $('#moreFiltersPopover').removeClass('show');
                }
            });

            $(document).on('change', '.more-filter-checkbox', function () {
                const key = $(this).data('filter-key');
                if (this.checked) renderDynamicFilter(key);
                else removeDynamicFilter(key);
            });

            $(document).on('click', '.remove-dynamic-filter', function () {
                removeDynamicFilter($(this).data('filter-key'));
            });

            $('#btnShow').on('click', applyFilters);
            $('#btnSearchBench').on('click', applyFilters);
            $('#filterSearch').on('keyup', function (e) { if (e.key === 'Enter') applyFilters(); });

            $('#btnReset').on('click', function () {
                //Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor
                resetAllBenchMsFilters();
                //End of Added by Vishal Mane on 27/05/2026 to get comma separated filter ID values using cursor
                $('.dynamic-select').val('');
                $('.more-filter-checkbox').prop('checked', false);
                $('#dynamicFiltersHost').empty();
                $('#moreFiltersPopover').removeClass('show');
                $('#filterSearch').val('');
                //Added by Vishal Mane on 25/05/2026 — reset location dropdown from usp_Whizible2_Sel_OU_BRM with NULL BusinessGroupID.
                bindCboLocationByBusinessGroup();
                $('.selectpicker').selectpicker('refresh');
                //Modified by Vishal Mane on 12/05/2026 to reload unfiltered records from API/SP.
                GetBenchResources(1);
                //showToast('Filters cleared');
            });

            //$('#btnGenerateFile').on('click', function ()
            //{ showToast('Exporting to Excel…'); });


            $(document).ready(function () {
                $("#btnGenerateFile").on('click', function (e) {
                    DownLoadTemplateUpdated();
                });
            });

            function DownLoadTemplateUpdated() {
                //debugger
                var taskParameters = {
                    intEmployeeID: SessionEmployeeId,
                }
                showLoader();
                $.ajax({
                    url: strUrl + '/api/RM_BenchResourceManagement/DownloadBenchResourceExcel',
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
                        var fileName = 'BenchResourceReport.xlsx';
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
                    },
                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    },
                    complete: function () {
                        hideLoader();
                    }
                });
            }


            $('#btnToggleFilters').on('click', function () {
                const $panel = $('#filtersCardSection');
                const $btn = $(this);
                const nowHidden = $panel.hasClass('filters-hidden');
                if (nowHidden) {
                    $panel.removeClass('filters-hidden');
                    $btn.addClass('active').attr('aria-expanded', 'true').attr('title', 'Hide filters');
                    setTimeout(function () { $('.selectpicker').selectpicker('refresh'); }, 0);
                } else {
                    $panel.addClass('filters-hidden');
                    $btn.removeClass('active').attr('aria-expanded', 'false').attr('title', 'Show filters');
                    $('#moreFiltersPopover').removeClass('show');
                }
            });

            $(document).on('click', '.pg-btn[data-page]', function () {
                GetBenchResources(parseInt($(this).data('page'), 10));
            });
            $(document).on('click', '#pgFirst', function () {
                if (currentPage > 1) { GetBenchResources(1); }
            });
            $(document).on('click', '#pgPrev', function () {
                if (currentPage > 1) { GetBenchResources(currentPage - 1); }
            });
            $(document).on('click', '#pgNext', function () {
                const total = Math.max(1, Math.ceil((benchTotalCount > 0 ? benchTotalCount : filteredData.length) / PAGE_SIZE));
                if (currentPage < total) { GetBenchResources(currentPage + 1); }
            });
            $(document).on('click', '#pgLast', function () {
                const total = Math.max(1, Math.ceil((benchTotalCount > 0 ? benchTotalCount : filteredData.length) / PAGE_SIZE));
                if (currentPage < total) { GetBenchResources(total); }
            });

            let selectedHistoryEmp = null;
            let selectedDetailsEmp = null;
            const detailsCollapseEl = document.getElementById('detailsCollapse');
            const historyCollapseEl = document.getElementById('historyCollapse');
            const detailsCollapse = detailsCollapseEl ? new bootstrap.Collapse(detailsCollapseEl, { toggle: false }) : null;
            const historyCollapse = historyCollapseEl ? new bootstrap.Collapse(historyCollapseEl, { toggle: false }) : null;

            function openDetailsPanel(emp, showHistory) {
                selectedHistoryEmp = emp;
                selectedDetailsEmp = emp;
                renderDetails(emp);
                const panel = new bootstrap.Offcanvas(document.getElementById('offcvsBenchDetails'));
                panel.show();
                if (showHistory) {
                    detailsCollapse && detailsCollapse.hide();
                    historyCollapse && historyCollapse.show();
                    showHisTab(emp.employeeID);
                } else {
                    historyCollapse && historyCollapse.hide();
                    detailsCollapse && detailsCollapse.show();
                }
            }

            $(document).on('click', '.action-save', function () {
                saveBenchResourceRow($(this).closest('tr'));
            });

            $(document).on('click', '.action-history', function () {
                //debugger
                const row = $(this).closest('tr');
                const empId = row.data('emp');
                const emp = BENCH_DATA.find(e => e.employeeID === empId);
                if (!emp) return;
                openDetailsPanel(emp, true);
            });

            $(document).on('click', '.action-view', function () {
                const row = $(this).closest('tr');
                const empId = row.data('emp');
                const emp = BENCH_DATA.find(e => e.empId === empId);
                if (!emp) return;
                openDetailsPanel(emp, false);
            });

            $(document).on('input', '#detailRemarksInput', function () {
                $('#detailRemarksCount').text($(this).val().length);
            });

            $('#btnDetailsSave').on('click', function () {
                if (!selectedDetailsEmp) return;
                const status = $('#detailStatusInput').val() || selectedDetailsEmp.status;
                const remarks = ($('#detailRemarksInput').val() || '').substring(0, 500);
                selectedDetailsEmp.status = status;
                selectedDetailsEmp.remarks = remarks;
                renderDetails(selectedDetailsEmp);
                applyFilters();
                showToast('Details saved');
            });

            // Sort
            $('thead th').on('click', function () {
                const idx = $(this).index();
                const cols = ['name', 'empId', 'cbu', 'vertical', 'subVertical', 'grade', 'location', 'avail', 'benchStart', 'tentLeaving', 'agingDays', 'status', 'remarks'];
                const key = cols[idx];
                if (!key) return;
                filteredData.sort((a, b) => {
                    const av = a[key]; const bv = b[key];
                    if (typeof av === 'number') return av - bv;
                    return String(av).localeCompare(String(bv));
                });
                renderTable();
            });
        });

        //var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';   
        strUrl = strUrl ? strUrl.replace(/\/+$/, '') : '';
        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';

        var AddAccess = '<%= m_blnAddAccess%>';
        var EditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';

        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'


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


        // History APIs expect BenchResourceUpdateRequest.UserID (see RM_BenchResourceManagementController).
        function parseBenchHistoryApiArray(data) {
            //debugger
            if (!data) return [];
            if (Object.prototype.toString.call(data) === '[object Array]') return data;
            return [];
        }

        function destroyCityHistoryPopovers() {
            $('#cityhistory .history-popover').each(function () {
                var inst = bootstrap.Popover.getInstance(this);
                if (inst) {
                    inst.dispose();
                }
            });
        }

        function initCityHistoryPopovers() {
            if (typeof bootstrap === 'undefined' || !bootstrap.Popover) {
                return;
            }
            $('#cityhistory .history-popover[data-bs-toggle="popover"]').each(function () {
                var el = this;
                var existing = bootstrap.Popover.getInstance(el);
                if (existing) {
                    existing.dispose();
                }
                var fullText = el.getAttribute('data-full-text') || '';
                new bootstrap.Popover(el, {
                    container: 'body',
                    trigger: 'hover focus',
                    placement: 'top',
                    html: true,
                    customClass: 'history-bs-popover',
                    content: '<div class="history-popover-content">' + escapeBenchHtmlText(fullText) + '</div>'
                });
            });
        }

        function buildHistoryPopoverCellHtml(fullVal) {
            var text = String(fullVal == null ? '' : fullVal);
            if (text.length <= 100) {
                return escapeBenchHtmlText(text);
            }
            var shortVal = text.substring(0, 100) + '...';
            return '<span class="history-popover" tabindex="0" role="button" '
                + 'data-bs-toggle="popover" '
                + 'data-full-text="' + escapeBenchHtmlAttr(text) + '">'
                + escapeBenchHtmlText(shortVal)
                + '</span>';
        }

        function destroyCityHistoryDataTable() {
            destroyCityHistoryPopovers();
            var $tbl = $('#cityShowHisTable');
            if ($tbl.length && $.fn.DataTable && $.fn.DataTable.isDataTable($tbl[0])) {
                $tbl.DataTable().destroy();
            }
            cityHistoryTable = null;
            $('#cityHistoryCustomPagination').hide();
        }

        function renderCityHistoryBody(rows) {
            var html = '';
            var list = parseBenchHistoryApiArray(rows);
            for (var i = 0; i < list.length; i++) {
                var r = list[i] || {};
                var oldVal = getBenchApiProp(r, 'OldValue', 'oldValue') == null ? '' : String(getBenchApiProp(r, 'OldValue', 'oldValue'));
                var newVal = getBenchApiProp(r, 'NewValue', 'newValue') == null ? '' : String(getBenchApiProp(r, 'NewValue', 'newValue'));

                html += '<tr>';
                html += '<td>' + escapeBenchHtmlText(getBenchApiProp(r, 'ModifiedField', 'modifiedField') == null ? '' : getBenchApiProp(r, 'ModifiedField', 'modifiedField')) + '</td>';
                html += '<td>' + buildHistoryPopoverCellHtml(oldVal) + '</td>';
                html += '<td>' + buildHistoryPopoverCellHtml(newVal) + '</td>';
                html += '<td>' + escapeBenchHtmlText(getBenchApiProp(r, 'ModifiedDate', 'modifiedDate') == null ? '' : getBenchApiProp(r, 'ModifiedDate', 'modifiedDate')) + '</td>';
                html += '<td>' + escapeBenchHtmlText(getBenchApiProp(r, 'ModifiedBy', 'modifiedBy') == null ? '' : getBenchApiProp(r, 'ModifiedBy', 'modifiedBy')) + '</td>';
                html += '</tr>';
            }
            $('#cityhistory').html(html);
        }

        // Added by Vishal Mane on 25/05/2026 — same pagination style as RM_EmployeeSkillsUpload.aspx (tbluploadedfiles).
        function renderCityHistoryPagination() {
            if (!cityHistoryTable) return;

            var info = cityHistoryTable.page.info();
            var totalRecords = info.recordsDisplay || 0;
            var currentPage = (info.page || 0) + 1;
            var totalPages = info.pages || 0;

            if ($('#cityHistoryCustomPagination').length === 0) {
                $('#cityShowHisTable').closest('.table-responsive').after(
                    '<div id="cityHistoryCustomPagination" class="d-flex justify-content-end align-items-center mt-2"></div>'
                );
            }

            if (totalRecords === 0) {
                $('#cityHistoryCustomPagination').hide();
                return;
            }

            var paginationHtml = '<div class="me-3">Total Records: ' + totalRecords + '</div><div class="btn-group">';

            if (currentPage > 1) {
                paginationHtml += '<button type="button" class="btn btn-light border" onclick="navigateCityHistoryPage(' + (currentPage - 1) + ')">&laquo;</button>';
            } else {
                paginationHtml += '<button type="button" class="btn btn-light border" disabled>&laquo;</button>';
            }

            if (currentPage < totalPages) {
                paginationHtml += '<button type="button" class="btn btn-light border" onclick="navigateCityHistoryPage(' + (currentPage + 1) + ')">&raquo;</button>';
            } else {
                paginationHtml += '<button type="button" class="btn btn-light border" disabled>&raquo;</button>';
            }

            paginationHtml += '</div>';
            $('#cityHistoryCustomPagination').html(paginationHtml).show();
        }

        function navigateCityHistoryPage(pageNumber) {
            if (!cityHistoryTable) return;
            cityHistoryTable.page(pageNumber - 1).draw('page');
        }

        function initCityHistoryDataTable() {
            var actualRows = $('#cityhistory tr').length;
            if (actualRows === 0) {
                cityHistoryTable = null;
                $('#cityHistoryCustomPagination').hide();
                return;
            }

            var dynamicPageLength = Math.min(5, actualRows);

            cityHistoryTable = $('#cityShowHisTable').DataTable({
                autoWidth: false,
                paging: true,
                pageLength: dynamicPageLength,
                lengthChange: false,
                searching: false,
                ordering: false,
                responsive: true,
                destroy: true,
                info: false,
                pagingType: 'simple',
                dom: 'rt<"d-flex justify-content-end align-items-center gap-2"ip>',
                language: {
                    info: 'Total Records: _TOTAL_',
                    infoEmpty: 'Total Records: 0',
                    paginate: {
                        previous: '<<',
                        next: '>>'
                    }
                }
            });

            $('#cityShowHisTable_wrapper .dataTables_info, #cityShowHisTable_wrapper .dataTables_paginate').hide();
            cityHistoryTable.off('draw').on('draw', function () {
                renderCityHistoryPagination();
            });
            renderCityHistoryPagination();
        }

        function refreshBenchHistoryTableFromApi() {
            destroyCityHistoryDataTable();
            var uid = parseInt($('#hiddenBenchHistoryUserId').val(), 10) || 0;
            if (uid <= 0) {
                $('#cityhistory').html('');
                return;
            }
            runWithLoader(function () {
                var Parameter = {
                    UserID: uid,
                    ModifiedField: $('#modifiedHisField').val() || '',
                    ModifiedBy: $('#modifiedHisBy').val() || ''
                };
                var Param = JSON.stringify(Parameter);
                var apiRows = AJAXCallWithResult('/api/RM_BenchResourceManagement/GetBenchResourceHistory', Param, false);
                var list = parseBenchHistoryApiArray(apiRows);
                if (!list || list.length === 0) {
                    $('#cityhistory').html('<tr><td colspan="5" class="text-center">No records found</td></tr>');
                    $('#cityHistoryCustomPagination').hide();
                    return;
                }
                renderCityHistoryBody(apiRows);
                initCityHistoryDataTable();
                initCityHistoryPopovers();
            });
        }

        function brmhisdrpdown(userId) {
            var uid = parseInt(userId, 10) || 0;
            $('#hiddenBenchHistoryUserId').val(uid);
            var $mf = $('#modifiedHisField');
            var $mb = $('#modifiedHisBy');
            var phField = 'Select Modified Field';
            var phBy = 'Select Modified By';
            var phFieldLower = phField.toLowerCase();
            var phByLower = phBy.toLowerCase();

            if ($mf.data('selectpicker')) {
                $mf.selectpicker('destroy');
            }
            if ($mb.data('selectpicker')) {
                $mb.selectpicker('destroy');
            }

            $mf.empty();
            $mb.empty();
            $mf.append($('<option>').val('').text(phField));
            $mb.append($('<option>').val('').text(phBy));

            function initHistorySelects() {
                $mf.selectpicker();
                $mb.selectpicker();
            }

            if (uid <= 0) {
                initHistorySelects();
                return;
            }
            runWithLoader(function () {
                var paramJson = JSON.stringify({ UserID: uid });
                var fieldData = parseBenchHistoryApiArray(AJAXCallWithResult('/api/RM_BenchResourceManagement/ModifiedFieldDropdown', paramJson, false));
                var byData = parseBenchHistoryApiArray(AJAXCallWithResult('/api/RM_BenchResourceManagement/ModifiedByDropdown', paramJson, false));
                var i, row, v, key;
                var seenField = {};
                var seenBy = {};
                for (i = 0; i < fieldData.length; i++) {
                    row = fieldData[i] || {};
                    v = getBenchApiProp(row, 'ModifiedField', 'modifiedField');
                    if (v == null || v === '') continue;
                    v = String(v).trim();
                    if (!v) continue;
                    if (v.toLowerCase() === phFieldLower) continue;
                    key = v.toLowerCase();
                    if (seenField[key]) continue;
                    seenField[key] = true;
                    $mf.append($('<option>').val(v).text(v));
                }
                for (i = 0; i < byData.length; i++) {
                    row = byData[i] || {};
                    v = getBenchApiProp(row, 'ModifiedBy', 'modifiedBy');
                    if (v == null || v === '') continue;
                    v = String(v).trim();
                    if (!v) continue;
                    if (v.toLowerCase() === phByLower) continue;
                    key = v.toLowerCase();
                    if (seenBy[key]) continue;
                    seenBy[key] = true;
                    $mb.append($('<option>').val(v).text(v));
                }
                initHistorySelects();
            });
        }

        
        function onChngDrpdown() {
            refreshBenchHistoryTableFromApi();
        }

        function showHisTab(empId) {
            //debugger
            var uid = parseInt(empId, 10) || 0;
            brmhisdrpdown(uid);
            refreshBenchHistoryTableFromApi();
        }
    </script>
</body>
</html>

