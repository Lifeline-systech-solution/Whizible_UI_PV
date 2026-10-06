
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_BackupPlans.aspx.vb" Inherits="Whizible.PM_BackupPlans" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%=MyBase.GetResourceString("C_PageTitle")%></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css">
</head>

    <style>
        .AdvanceFilterIconClicked {
           background-color: #1359a6 !important;
           color: white !important;
           border-radius: 8px !important;
           border: none !important;
         }
         
        #ClearAllFilter {
            display: none !important;
        }
        
        #ClearAllFilter.show {
            display: inline-block !important;
        }
        body{background:#f8f9fa;margin:0;padding:0 0 80px;color:#333}
        body.offcanvas-open{overflow:hidden}
        body:not(.offcanvas-open){overflow:auto}
        .header-section{max-width:1400px;background:white;position:relative}
        .header-white-card{padding:0;position:relative}
        .header-content{display:flex;align-items:center;padding:1rem 0;position:relative}
        .header-left{display:flex;align-items:center;padding-left:1rem;margin-left:0}
        .header-icon{color:#1e40af;margin-right:0.75rem;transition:all .3s cubic-bezier(.4,0,.2,1)}
        .header-icon:hover{transform:scale(1.05)}
        .header-text{display:flex;flex-direction:column;gap:0.25rem}
        .header-title{margin:0;color:#1e40af;letter-spacing:-.8px;line-height:1.2;transition:all .3s ease}
        .header-title:hover{transform:translateX(1px)}
        .header-description{margin:0;color:#6b7280;line-height:1.4;opacity:.9;transition:all .3s ease}
        .header-description:hover{color:#475569;transform:translateX(2px)}
        .header-right{display:flex;align-items:center;gap:20px}
        .clearalllink{color:#1359a6;text-decoration:none;}

        .backup-table-section{max-width:1400px;margin:0 auto 32px;background:white;border-radius:0;box-shadow:0 4px 20px rgba(0,0,0,.08),0 1px 3px rgba(0,0,0,.1);overflow:hidden;border:1px solid rgba(226,232,240,.8);transition:all .3s cubic-bezier(.4,0,.2,1);position:relative}
        .backup-table-section:hover{transform:translateY(-1px);box-shadow:0 6px 25px rgba(0,0,0,.1),0 2px 6px rgba(0,0,0,.12)}


        .addNewBtns {
            padding: 5px 10px;
        }

        /* Form styling matching training plan layout */
        .AddNewDtlsInfo .form-group {
            margin-bottom: 1rem;
        }

        .AddNewDtlsInfo .form-group label {
            color: #374151;
            margin-bottom: 0.25rem;
        }

        .AddNewDtlsInfo .form-control {
            border: 1px solid #d1d5db;
            border-radius: 0.25rem;
            padding: 0.5rem 0.75rem;
            width: 100%;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }

        .AddNewDtlsInfo .form-control:focus {
            border-color: #3b82f6;
            outline: 0;
            box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25);
        }

        .AddNewDtlsInfo textarea.form-control {
            resize: vertical;
            min-height: 80px;
        }

        .AddNewDtlsInfo .row {
            margin-bottom: 0.5rem;
        }

        .AddNewDtlsInfo .col-sm-4 {
            padding-left: 0.5rem;
            padding-right: 0.5rem;
        }


        /* Ensure filter panel is visible when shown */
        .filterpanel.collapse.show {
            display: block !important;
        }
        
        .filterpanel.collapse:not(.show) {
            display: none !important;
        }


        /* Filter and Search Section Styles - Matching Image Design */
        .filter-search-section {
            max-width: 1400px;
            margin: 0 auto 16px;
            background: #f0f2f5;
            border-radius: 0;
            padding: 6px 12px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }


        .search-filter-container {
            display: flex;
            align-items: center;
            gap: 0;
            justify-content: flex-end;
        }

        .search-input-wrapper {
            position: relative;
            display: inline-block;
            width: 230px;
            margin-right: 8px;
        }

        .search-input-wrapper input {
            width: 100%;
            height: 32px;
            padding: 6px 12px;
            line-height: 1.42857143;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #d0d0d0;
            border-radius: 4px;
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 2px 4px rgba(0,0,0,0.1);
            transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
        }

        .search-input-wrapper input:focus {
            border-color: #66afe9;
            outline: 0;
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 2px 4px rgba(0,0,0,0.1), 0 0 8px rgba(102, 175, 233, .6);
        }

        /* Consistent Form Control Focus Styling */
        .form-control:focus,
        .form-select:focus,
        .bootstrap-select .dropdown-toggle:focus,
        .selectpicker:focus,
        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus,
        input[type="number"]:focus,
        input[type="date"]:focus,
        input[type="datetime-local"]:focus,
        input[type="time"]:focus,
        textarea:focus,
        select:focus {
            border-color: #66afe9 !important;
            outline: 0 !important;
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 2px 4px rgba(0,0,0,0.1), 0 0 8px rgba(102, 175, 233, .6) !important;
        }

        /* Bootstrap Select Focus Styling */
        .bootstrap-select .dropdown-toggle:focus {
            border-color: #66afe9 !important;
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 2px 4px rgba(0,0,0,0.1), 0 0 8px rgba(102, 175, 233, .6) !important;
        }

        /* Override existing focus styles to be consistent */
        .EdtScreen .form-control:focus,
        .filterpanelbody .form-control:focus {
            border-color: #66afe9 !important;
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 2px 4px rgba(0,0,0,0.1), 0 0 8px rgba(102, 175, 233, .6) !important;
            outline: none !important;
        }

        .search-input-wrapper .search-btn {
            position: absolute;
            right: 0;
            top: 0;
            height: 32px;
            width: 32px;
            padding: 0;
            background: #f0f2f5;
            border: 1px solid #d0d0d0;
            border-left: 1px solid #d0d0d0;
            border-radius: 0 4px 4px 0;
            color: #333333;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }

        .search-input-wrapper .search-btn:hover {
            background: #e7e7e7;
            color: #333;
        }


        /* Additional styling to match the image exactly */

        .search-input-wrapper input::placeholder {
            color: #a0a0a0;
        }

        /* Responsive Design for Filter Search Section */
        @media (max-width: 768px) {
            .filter-search-section {
                margin: 12px;
                padding: 6px 12px;
            }
            
            .search-filter-container {
                flex-direction: column;
                gap: 6px;
                align-items: stretch;
            }
            
            .search-input-wrapper {
                width: 100%;
                margin-right: 0;
            }
            
            .dropdown-container select {
                max-width: 100%;
            }
        }

        @media (max-width: 480px) {
            .filter-search-section {
                margin: 8px;
                padding: 6px 10px;
            }
            
            .search-filter-container {
                gap: 4px;
            }
        }



        /* Hide all scrollbars */
        * {
            scrollbar-width: none; /* Firefox */
            -ms-overflow-style: none; /* Internet Explorer 10+ */
        }

        *::-webkit-scrollbar {
            display: none; /* WebKit browsers (Chrome, Safari, Edge) */
        }

        /* Ensure content is still scrollable but without visible scrollbars */
        body, html {
            scrollbar-width: none; /* Firefox */
            -ms-overflow-style: none; /* Internet Explorer 10+ */
        }

        body::-webkit-scrollbar, html::-webkit-scrollbar {
            display: none; /* WebKit browsers */
        }

        /* Hide scrollbars for all divs and containers */
        div, .container, .row, .col, [class*="col-"] {
            scrollbar-width: none; /* Firefox */
            -ms-overflow-style: none; /* Internet Explorer 10+ */
        }

        div::-webkit-scrollbar, .container::-webkit-scrollbar, .row::-webkit-scrollbar, .col::-webkit-scrollbar, [class*="col-"]::-webkit-scrollbar {
            display: none; /* WebKit browsers */
        }

        /* Hide scrollbars for DataTables and other specific elements */
        .dataTables_scrollBody, .dataTables_wrapper, .table-responsive {
            scrollbar-width: none; /* Firefox */
            -ms-overflow-style: none; /* Internet Explorer 10+ */
        }

        .dataTables_scrollBody::-webkit-scrollbar, .dataTables_wrapper::-webkit-scrollbar, .table-responsive::-webkit-scrollbar {
            display: none; /* WebKit browsers */
        }

        /* Sticky Pagination Controls */
        .cstm_pagination {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: #fff;
            border-top: 1px solid #e2e8f0;
            box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Enhanced disabled pagination button styling */
        .fa-disabled {
            opacity: 0.4 !important;
            cursor: not-allowed !important;
            pointer-events: none !important;
            background-color: #f8f9fa !important;
            color: #6c757d !important;
            border-color: #dee2e6 !important;
        }

        .required::after {
    content: " *";
    color: red;
}
        .fa-disabled .page-link {
            opacity: 0.4 !important;
            cursor: not-allowed !important;
            pointer-events: none !important;
            background-color: #f8f9fa !important;
            color: #6c757d !important;
            border-color: #dee2e6 !important;
        }

        .fa-disabled .page-link:hover {
            background-color: #f8f9fa !important;
            color: #6c757d !important;
            border-color: #dee2e6 !important;
            transform: none !important;
        }

        .fa-disabled .page-link:focus {
            background-color: #f8f9fa !important;
            color: #6c757d !important;
            border-color: #dee2e6 !important;
            box-shadow: none !important;
        }

        /* Ensure content doesn't get hidden behind sticky pagination */
        body {
            padding-bottom: 80px;
        }

        /* Responsive adjustments for sticky pagination */
        @media (max-width: 768px) {
            .cstm_pagination {
                padding: 8px 15px;
                flex-direction: column;
                gap: 8px;
            }
            
            body {
                padding-bottom: 100px;
            }
        }

        @media (max-width: 480px) {
            .cstm_pagination {
                padding: 6px 10px;
            }
            
            body {
                padding-bottom: 90px;
            }
        }

    </style>

<body class="hold-transition bgwhite sidebar-mini fixed">
     <%If m_blnViewAccess = True Then%>
    <div class="bgwhite">
    <form id="form1" runat="server">
        <!-- Header Section with Icon and Subtitle -->
        <div style="background: white; padding: 1rem 0;">
            <div style="padding-left: 1rem; margin-left: 0;">
                <h2 style="color: #1e40af; font-weight: 600; font-size: 18px; margin: 0 0 0.25rem 0; display: flex; align-items: center;">
                    <i class="fas fa-database" style="color: #1e40af; font-size: 1.5rem; margin-right: 0.75rem;"></i>
                  <%=MyBase.GetResourceString("C_HeaderTitle")%> 
                </h2>
                <p style="color: #6b7280; font-size: 0.7rem; margin: 0;"> <%=MyBase.GetResourceString("C_HeaderDescription")%>  </p>
            </div>
        </div>

        <!-- Search and Filter Section -->
        <div style="background: rgb(231, 237, 240); padding: 0.5rem 1rem; margin-left: 2px;">
            <div style="display: flex; align-items: center; justify-content: space-between; gap: 0.75rem;">
                <!-- Left Side - Project Dropdown -->
                <div style="display: flex; align-items: center; gap: 0.5rem;">
                    <label style="color: #374151; font-size: 11.5px; font-weight: 500; margin: 0;"><%=MyBase.GetResourceString("C_SelectProject")%></label>
                    <div style="min-width: 200px;">
                        <%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='PlotProjectonChange();' class='selectpicker' data-live-search='true'",,,) %>
                    </div>
                </div>
                <!-- Right Side - Search and Filter -->
                <div style="display: flex; align-items: center; gap: 0.75rem;">
                    <div style="display: flex; align-items: center; background: white; border-radius: 0.25rem; border: 1px solid #d1d5db; overflow: hidden; height: 2rem; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);">
                        <input id="serchBackup_planInput" type="text" placeholder="<%=MyBase.GetResourceString("C_SearchPlaceholder")%>" oninput="handleSearchInput()" style="border: none; outline: none; padding: 0.25rem 0.5rem; flex: 1; background: transparent; height: 100%;">
                        <button id="searchBtn" type="button" onclick="handleSearchInput()" style="background: #f3f4f6; border: none; padding: 0.25rem 0.5rem; color: #374151; cursor: pointer; height: 100%; display: flex; align-items: center; border-left: 1px solid #d1d5db; ">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                    <a href="javascript:;" class="clearalllink pe-3" id="ClearAllFilter" data-bs-toggle="tooltip" title="Clear All" onclick="clearAllFilters()" style="color: #1359a6; text-decoration: none; margin-right: 0; display: none;"><%=MyBase.GetResourceString("C_ClearAll")%></a>
                    <span data-bs-toggle="tooltip" title="Filter">
                        <button data-bs-toggle="collapse" data-bs-target="#filterpanel" id="AdvanceFilterIcon" autocomplete="off" class="" aria-expanded="false" style="background: none; border: none; color: #374151; cursor: pointer; padding: 0.5rem;">
                            <i class="fas fa-filter"></i>
                        </button>
                    </span>
                </div>
            </div>
        </div>

        <!--filter panel-->
        <div id="filterpanel" class="filterpanel collapse">
            <div class="bglightgray container-fluid py-1 filterpanelheader">
                <div class="cust_tabpanel">
                    <ul class="nav nav-tabs">
                        <li class="nav-item active" style="margin-left: 0px;">
                            <a class="nav-link" href="#PlanBasicFilters" data-bs-toggle="tab" aria-expanded="true"><%=MyBase.GetResourceString("C_BasicFilters")%>
                                </a>
                        </li>
                    </ul>
                </div>

                <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="PlanBasicFilters" class="tab-pane">
                            <div class="filterpanelbody">
                                <div class="text-center mb-3">
                                    <button class="btn btnyellow" id="applyFilterBtn"><%=MyBase.GetResourceString("C_Apply")%></button>
                                </div>

                                <div class="filterSection">
                                    <div class="row d-flex justify-content-center">
                                        <div class="col-sm-8">

                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="PlanRespFilter" class="text-end"><%=MyBase.GetResourceString("C_Responsibility")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <input id="PlanRespFilter" type="text" class="form-control" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="PlanDirLocFilter" class="text-end"><%=MyBase.GetResourceString("C_DirectoryLocation")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <input id="PlanDirLocFilter" type="text" class="form-control" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="PlanFrequencyFilter" class="text-end"><%=MyBase.GetResourceString("C_Frequency")%></label>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <input id="PlanFrequencyFilter" type="text" class="form-control" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="PlanMediaFilter" class="text-end"><%=MyBase.GetResourceString("C_Media")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <input id="PlanMediaFilter" type="text" class="form-control" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="PlanNoCopiesFilter" class="text-end"><%=MyBase.GetResourceString("C_NumberOfCopies")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <input id="PlanNoCopiesFilter" type="number" class="form-control" min="1" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="PlanRemarksFilter" class="text-end"><%=MyBase.GetResourceString("C_Remarks")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="PlanRemarksFilter" rows="3"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end filter panel-->

        <div class="content">

        <!-- Add Backup Plan Details start here -->
        <div class="accordion WF_TopAccordianPanel my-3" id="AddDtlsAcc">
            <div class="accordion-item mb-3">
                    <h2 class="accordion-header">
                                                             <% If m_blnAddAccess Then %>
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#AddBkPlanDtlsTab" aria-expanded="false">
                        <i class="fas fa-plus addIcn pe-2"></i><%=MyBase.GetResourceString("C_NewBackupPlan")%>
                        </button>
                    <% End If %>
                    </h2>

                    <div id="AddBkPlanDtlsTab" class="accordion-collapse collapse">
                    <div class="accordion-body">
                            <div class="AddNewDtlsInfo">
                                <div class="row">
                                    <div class="col-sm-11">
                                        <div class="AddContent">
                                        <!-- Row 1 -->
                                        <div class="row">
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="BkPlanAddDesc" class="required text-end"><%=MyBase.GetResourceString("C_Description")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <textarea class="form-control" id="BkPlanAddDesc" maxlength="1000" rows="3"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="BkPlanAddRespnsblty" class="text-end"><%=MyBase.GetResourceString("C_Responsibility")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <input id="BkPlanAddRespnsblty" type="text" class="form-control" maxlength="500" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="BkPlanAddDirctLoc" class="text-end"><%=MyBase.GetResourceString("C_DirectoryLocation")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <input id="BkPlanAddDirctLoc" type="text" class="form-control" maxlength="500" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Row 2 -->
                                        <div class="row">
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="BkPlanAddFrequency" class="text-end"><%=MyBase.GetResourceString("C_Frequency")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <input id="BkPlanAddFrequency" type="text" class="form-control" maxlength="200" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="BkPlanAddMedia" class="text-end"><%=MyBase.GetResourceString("C_Media")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <input id="BkPlanAddMedia" type="text" class="form-control" maxlength="200" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="BkPlanAddNoCopies" class="text-end"><%=MyBase.GetResourceString("C_NumberOfCopies")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <input id="BkPlanAddNoCopies" type="number" class="form-control" min="1" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Row 3 -->
                                        <div class="row">
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="BkPlanAddRemarks" class="text-end"><%=MyBase.GetResourceString("C_Remarks")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <textarea class="form-control" id="BkPlanAddRemarks" maxlength="500" rows="3"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <!-- Empty column for spacing -->
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row mt-4">
                                                    <div class="col-sm-12 d-flex justify-content-center gap-2" style="margin-left: -2rem;">
                                                        <% If m_blnAddAccess Then %>
                                                        <i class="fas fa-check clickYes pe-2" id="AddClickYes" data-bs-toggle="tooltip" title="Save" style="color: #28a745; cursor: pointer; background: white; border: 1px solid #d1d5db; border-radius: 50%; padding: 0.5rem; display: flex; align-items: center; justify-content: center; width: 2rem; height: 2rem;"></i>
                                                        <% End If %>
                                                        <i class="fas fa-times clickNo" id="AddClickNo" data-bs-toggle="tooltip" title="Clear" style="color: #dc3545; cursor: pointer; background: white; border: 1px solid #d1d5db; border-radius: 50%; padding: 0.5rem; display: flex; align-items: center; justify-content: center; width: 2rem; height: 2rem;"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-1">
                                        <!-- Right spacing column -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="resize_wrapper">
                <table id="backupPlansTbl" class="table bgwhite table-bordered table-fixed-header alocatedresourcereqtbl" style="width: 100%;">
                    <thead>
                        <tr>
                            <th class="col-sm-3"><%=MyBase.GetResourceString("C_TableDescription")%></th>
                            <th class="col-sm-3"><%=MyBase.GetResourceString("C_TableResponsibility")%></th>
                            <th class="col-sm-4"><%=MyBase.GetResourceString("C_TableDirectoryLocation")%></th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("C_TableFrequency")%></th>
                            <th class="col-sm-1">&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="clearfix"></div>
            
            <!-- Pagination Controls - Matching PM_ProjectList.aspx exactly -->
            <div class="cstm_pagination" id="paginationControls" style="margin-top: 5px; display: none;">
                <div class="d-flex justify-content-end w-100">
                    <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                        <span id="" class="spntotal"><%=MyBase.GetResourceString("C_TotalRecords")%></span>
                        <span class="spntotal" id="TotalRecords"></span>
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-end" style="margin: 0px!important">
                                <li class="page-item" id="btnprevious">
                                    <a class="page-link" aria-label="<%=MyBase.GetResourceString("C_PreviousPage")%>" onclick='PrevList()' data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousTooltip")%>" id="LinkPrevious">
                                        <i class="fas fa-angle-double-left"></i>
                                    </a>
                                </li>
                                <li class="page-item" id="btnnext">
                                    <a class="page-link" aria-label="<%=MyBase.GetResourceString("C_NextPage")%>" onclick='NextList()' data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextTooltip")%>" id="LinkNext">
                                        <i class="fas fa-angle-double-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>


            <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
                id="offcanvas_EdtBkPlans" aria-labelledby="offcanvas_EdtBkPlan">
                <div class="offcanvas-body">
                    <div id="edtBkPlan_Details" class="edtBkPlan_Details">
                        <div class="container-fluid py-2 graybg mb-2">
                            <div class="row">
                                <div class="col-sm-10">
                                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_HeaderTitle")%></h5>
                                </div>
                                <div class="col-sm-2 text-end">
                                    <button type="button" class="btn btn-sm btn-danger-modern"
                                        data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_CloseTooltip")%>" data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="container-fluid">
                            <div class="row my-2">
                                <div class="col-sm-12">
                                    <div class="d-flex justify-content-end align-items-center flex-wrap gap-2">
                                            <a href="javascript:;" class="textUndrln me-3" id="BkPlansShowHisBtn"
                                                onclick="ShowHistoryTab()">
                                                <span data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_ShowHistoryTooltip")%>"><%=MyBase.GetResourceString("C_ShowHistory")%></span>
                                            </a>
                                            <% If m_blnEditAccess Then %>
                                            <button type="button" class="btn btn-sm btnyellow" id="saveEdtPlanBtn" data-bs-toggle="tooltip"
                                                title="<%=MyBase.GetResourceString("C_SaveTooltip")%>"><%=MyBase.GetResourceString("C_Save")%></button>
                                            <% End If %>
                                            <% If m_blnEditAccess And m_blnAddAccess Then %>
                                            <button type="button" class="btn btn-sm btnyellow" id="saveAddEdtPlanBtn" data-bs-toggle="tooltip"
                                                title="<%=MyBase.GetResourceString("C_SaveAndAddTooltip")%>"><%=MyBase.GetResourceString("C_SaveAndAdd")%></button>
                                            <% End If %>
                                            <% If m_blnDeleteAccess Then %>
                                            <button type="button" class="btn borderbtn nobtnstyle-xs canclebtn" id="deleteBkPlanBtn" data-bs-toggle="tooltip"
                                                title="<%=MyBase.GetResourceString("C_DeleteTooltip")%>"><%=MyBase.GetResourceString("C_Delete")%></button>
                                            <% End If %>
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-2">
                                <div class="col-sm-12 text-end">
                                    <label class="form-label ">(<font color="red">*</font>
                                        <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                                </div>
                            </div>

                            <div class="EdtScreen">
                                <div class="row">
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanEdtDesc" class="col-sm-4 required text-end"><%=MyBase.GetResourceString("C_Description")%></label>
                                            <div class="col-sm-8">
                                                <textarea class="form-control" id="BkPlanEdtDesc" maxlength="1000"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanEdtRespnsblty" class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_Responsibility")%></label>
                                            <div class="col-sm-8">
                                                <input id="BkPlanEdtRespnsblty" type="text" class="form-control" maxlength="500" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanEdtDirctLoc" class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_DirectoryLocation")%></label>
                                            <div class="col-sm-8">
                                                <input id="BkPlanEdtDirctLoc" type="text" class="form-control" maxlength="500" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanEdtFrequency" class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_Frequency")%></label>
                                            <div class="col-sm-6">
                                                <input id="BkPlanEdtFrequency" type="text" class="form-control" maxlength="200" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanEdtMedia" class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_Media")%></label>
                                            <div class="col-sm-6">
                                                <input id="BkPlanEdtMedia" type="text" class="form-control" maxlength="200" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanEdtNoCopies" class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_NumberOfCopies")%></label>
                                            <div class="col-sm-3">
                                                <input id="BkPlanEdtNoCopies" type="number" class="form-control" min="1" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanEdtRemarks" class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_Remarks")%></label>
                                            <div class="col-sm-8">
                                                <textarea class="form-control" id="BkPlanEdtRemarks" maxlength="500"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Hidden fields for update operations -->
                            <input type="hidden" id="BkPlanEdtProjectId" value="1" />
                            <input type="hidden" id="BkPlanEdtBackPlanId" value="" />

                        </div>

                            <!-- Show History Details Panel start here -->
                            <div class="ShowHisDetailpanel mb-4">
                                <div class="pgdetailinner p-0">
                                    <hr />
                                    <div class="BkPlanHistory">
                                        <ul class="nav nav-tabs detailsubtabs mt-4">
                                            <li class="nav-item">
                                                <a class="nav-link active" href="#BkPlanHisTab" data-bs-toggle="tab"
                                                    id=""><%=MyBase.GetResourceString("C_History")%></a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <!-- History Tab -->
                                            <div id="BkPlanHisTab" class="tab-pane active mt-2">
                                                <div class="container-fluid">
                                                <div class="form-inline hstryfltr pb-1">
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            &nbsp;
                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="d-flex justify-content-end gap-2 pe-2">
                                                                <button type="button" class="btn borderbtn nobtnstyle-xs canclebtn cancelEdtDetpanel"
                                                                    id="CancelBtn" data-bs-toggle="tooltip"
                                                                    title="<%=MyBase.GetResourceString("C_Cancel")%>"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
                                                    <div class="row mt-3">
                                                        <div class="col-sm-6">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end">
                                                                    <label><%=MyBase.GetResourceString("C_ModifiedField")%> </label>
        </div>
                                                                <div class="col-sm-8">
                                                                    <select class="selectpicker" data-live-search="true" data-dropup-auto="false"
                                                                        id="modifiedHisField">
                                                                        <option value=""><%=MyBase.GetResourceString("C_SelectModifiedField")%></option>
                                                                    </select>
            </div>
                        </div>
                    </div>
                                                        <div class="col-sm-6">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end">
                                                                    <label><%=MyBase.GetResourceString("C_ModifiedBy")%> </label>
                    </div>
                                                                <div class="col-sm-8">
                                                                    <select class="selectpicker" data-live-search="true" data-dropup-auto="false"
                                                                        id="modifiedHisBy">
                                                                        <option value=""><%=MyBase.GetResourceString("C_SelectModifiedBy")%></option>
                                                                    </select>
                    </div>
                            </div>
                            </div>
                        </div>
                    </div>
                    
                                                <div class="table-responsive">
                                                    <table id="BkPlanShowHisTable" class="table table-stripped"
                                                        style="width:100%;">
                                                        <thead>
                                                            <tr>
                                                                <th class="col-sm-3"><%=MyBase.GetResourceString("C_TableModifiedField")%></th>
                                                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_TableOldValue")%></th>
                                                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_TableNewValue")%></th>
                                                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_TableModifiedDate")%></th>
                                                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_TableModifiedBy")%></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                            </div>
                                                <br />
                    </div>
                    
                                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
                </div>
                        <!-- Show History Details Panel end here -->
            </div>
        </div>
            </div>
            <!-- Edit Backup Plan Section ends here -->

            <!-- Add New Backup Plan Offcanvas start here -->
            <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
                id="offcanvas_AddBkPlans" aria-labelledby="offcanvas_AddBkPlan">
                <div class="offcanvas-body">
                    <div id="addBkPlan_Details" class="addBkPlan_Details">
                        <div class="container-fluid py-2 graybg mb-2">
                            <div class="row">
                                <div class="col-sm-10">
                                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_HeaderTitle")%></h5>
                                </div>
                                <div class="col-sm-2 text-end">
                                    <button type="button" class="btn btn-sm btn-danger-modern"
                                        data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_CloseTooltip")%>" data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="container-fluid">
                            <div class="row my-2">
                                <div class="col-sm-12">
                                    <div class="d-flex justify-content-end align-items-center flex-wrap gap-2">
                                        <% If m_blnAddAccess Then %>
                                        <button type="button" class="btn btn-sm btnyellow" id="saveAddPlanBtn" data-bs-toggle="tooltip"
                                            title="<%=MyBase.GetResourceString("C_SaveTooltip")%>"><%=MyBase.GetResourceString("C_Save")%></button>
                                        <% End If %>
                                        <% If m_blnAddAccess Then %>
                                        <button type="button" class="btn btn-sm btnyellow" id="saveAddNewPlanBtn" data-bs-toggle="tooltip"
                                            title="<%=MyBase.GetResourceString("C_SaveAndAddTooltip")%>"><%=MyBase.GetResourceString("C_SaveAndAdd")%></button>
                                        <% End If %>
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-2">
                                <div class="col-sm-12 text-end">
                                    <label class="form-label ">(<font color="red">*</font>
                                        <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                                </div>
                            </div>

                            <div class="AddScreen">
                                <div class="row">
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanAddOffcanvasDesc" class="col-sm-4 required text-end"><%=MyBase.GetResourceString("C_Description")%></label>
                                            <div class="col-sm-8">
                                                <textarea class="form-control" id="BkPlanAddOffcanvasDesc" maxlength="1000"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanAddOffcanvasRespnsblty" class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_Responsibility")%></label>
                                            <div class="col-sm-8">
                                                <input id="BkPlanAddOffcanvasRespnsblty" type="text" class="form-control" maxlength="500" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanAddOffcanvasDirctLoc" class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_DirectoryLocation")%></label>
                                            <div class="col-sm-8">
                                                <input id="BkPlanAddOffcanvasDirctLoc" type="text" class="form-control" maxlength="500" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanAddOffcanvasFrequency" class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_Frequency")%></label>
                                            <div class="col-sm-6">
                                                <input id="BkPlanAddOffcanvasFrequency" type="text" class="form-control" maxlength="200" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanAddOffcanvasMedia" class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_Media")%></label>
                                            <div class="col-sm-6">
                                                <input id="BkPlanAddOffcanvasMedia" type="text" class="form-control" maxlength="200" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanAddOffcanvasNoCopies" class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_NumberOfCopies")%></label>
                                            <div class="col-sm-3">
                                                <input id="BkPlanAddOffcanvasNoCopies" type="number" class="form-control" min="1" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="BkPlanAddOffcanvasRemarks" class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_Remarks")%></label>
                                            <div class="col-sm-8">
                                                <textarea class="form-control" id="BkPlanAddOffcanvasRemarks" maxlength="500"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Hidden fields for add operations -->
                            <input type="hidden" id="BkPlanAddOffcanvasProjectId" value="1" />

                        </div>
                    </div>
                </div>
            </div>
            <!-- Add New Backup Plan Offcanvas ends here -->

        <div class="clearfix"></div>
        </div>
    </form>

    <!-- REQUIRED JS SCRIPTS -->
    
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js"></script>
    <script>
        // Global variables
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString()%>';

        var LoginType = '<%= Session("LoginType") %>';

        // Role Access Variables
        var m_blnAddAccess = <%=m_blnAddAccess.ToString().ToLower()%>;
        var m_blnEditAccess = <%=m_blnEditAccess.ToString().ToLower()%>;
        var m_blnDeleteAccess = <%=m_blnDeleteAccess.ToString().ToLower()%>;
        var m_blnViewAccess = <%=m_blnViewAccess.ToString().ToLower()%>;
        var EmployeeId = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        // Get ProjectID from session storage (consistent with other PM pages)
        var ProjectID = '<%= Session("intProjectID") %>';
        
        // Global variables for filter editing
        var GlobalFilterID = '';
        var GlobalFilterFlag = 0;
        var isEditActive = 0;
        
        // Global variable to track user's selected project ID
        var userSelectedProjectID = null;
        

        // Global Configuration Object
        var BackupPlansConfig = {
            // State management
            userSelectedProjectID: null,
            isLoadingBackupPlans: false,
            userHasSelectedProject: false,
            dropdownPopulated: false,
            dataTableInitialized: false,
            errorAlertShown: false,
            
            // Constants
            fieldLimits: {
                description: 1000,
                responsibility: 500,
                directoryLocation: 500,
                frequency: 200,
                media: 200,
                remarks: 500,
                numberOfCopies: 9999
            },
            
            // Field mappings for validation
            fieldMappings: {
                edit: {
                    description: '#BkPlanEdtDesc',
                    responsibility: '#BkPlanEdtRespnsblty',
                    directoryLocation: '#BkPlanEdtDirctLoc',
                    frequency: '#BkPlanEdtFrequency',
                    media: '#BkPlanEdtMedia',
                    numberOfCopies: '#BkPlanEdtNoCopies',
                    remarks: '#BkPlanEdtRemarks',
                    projectId: '#BkPlanEdtProjectId'
                },
                add: {
                    description: '#BkPlanAddDesc',
                    responsibility: '#BkPlanAddRespnsblty',
                    directoryLocation: '#BkPlanAddDirctLoc',
                    frequency: '#BkPlanAddFrequency',
                    media: '#BkPlanAddMedia',
                    numberOfCopies: '#BkPlanAddNoCopies',
                    remarks: '#BkPlanAddRemarks'
                },
                addOffcanvas: {
                    description: '#BkPlanAddOffcanvasDesc',
                    responsibility: '#BkPlanAddOffcanvasRespnsblty',
                    directoryLocation: '#BkPlanAddOffcanvasDirctLoc',
                    frequency: '#BkPlanAddOffcanvasFrequency',
                    media: '#BkPlanAddOffcanvasMedia',
                    numberOfCopies: '#BkPlanAddOffcanvasNoCopies',
                    remarks: '#BkPlanAddOffcanvasRemarks',
                    projectId: '#BkPlanAddOffcanvasProjectId'
                }
            }
        };
        
        // Validation function to check if at least one filter value is provided
        function validateFilterValues() {
            var hasValue = false;
            
            // Check all filter fields for any non-empty values
            var filterFields = [
                '#PlanRespFilter',
                '#PlanDirLocFilter', 
                '#PlanFrequencyFilter',
                '#PlanMediaFilter',
                '#PlanNoCopiesFilter',
                '#PlanRemarksFilter'
            ];
            
            for (var i = 0; i < filterFields.length; i++) {
                var fieldValue = $(filterFields[i]).val();
                if (fieldValue && fieldValue.trim() !== '') {
                    hasValue = true;
                    break;
                }
            }
            
            return hasValue;
        }
        
        // Initialize global variables
        function setUserSelectedProjectID(value) {
            BackupPlansConfig.userSelectedProjectID = value;
        }
        
        // Initialize project ID from various sources
        function initializeProjectID() {
        var urlProjectId = '<%= Request.QueryString("ProjectID") %>';
        var sessionProjectId = '<%= Session("intProjectID") %>';
        
        // Priority: URL parameter > Session project > null
        if (urlProjectId && urlProjectId !== '' && urlProjectId !== 'null' && urlProjectId !== '0') {
                BackupPlansConfig.userHasSelectedProject = true;
                BackupPlansConfig.userSelectedProjectID = urlProjectId;
                ProjectID = urlProjectId;
        } else if (sessionProjectId && sessionProjectId !== '' && sessionProjectId !== 'null' && sessionProjectId !== '0') {
                BackupPlansConfig.userHasSelectedProject = true;
                BackupPlansConfig.userSelectedProjectID = sessionProjectId;
                ProjectID = sessionProjectId;
        } else {
            ProjectID = null;
        }
        }
        
        // Initialize on page load
        initializeProjectID();
        
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
        
        
        // HTML escaping helper
        function escapeHtml(text) {
            if (!text) return '';
            var map = {
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#039;'
            };
            return text.replace(/[&<>"']/g, function(m) { return map[m]; });
        }
        
        // Date formatting helper
        function formatDateTime(dateString) {
            if (!dateString) return '<%=MyBase.GetResourceString("A_NA")%>';
            
            try {
                var date = new Date(dateString);
                if (isNaN(date.getTime())) return '<%=MyBase.GetResourceString("A_NA")%>';
                
                var options = {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                    hour12: false
                };
                
                return date.toLocaleString('en-US', options);
            } catch (error) {
                return '<%=MyBase.GetResourceString("A_NA")%>';
            }
        }

        function initializeDataTable() {
            if ($.fn.dataTable && !BackupPlansConfig.dataTableInitialized) {
                try {
                    // Check if table has data before initializing DataTable
                    var rowCount = $('#backupPlansTbl tbody tr').length;
                    
                    // Check if table structure is correct
                    var headerCount = $('#backupPlansTbl thead th').length;
                    
                    if (rowCount > 0 && headerCount === 5) {
                        // Destroy any existing DataTable first
                        if ($.fn.DataTable.isDataTable('#backupPlansTbl')) {
                            $('#backupPlansTbl').DataTable().destroy();
                        }
                        
                        // Initialize DataTable with configuration - remove columns definition to avoid conflicts
                        $("#backupPlansTbl").dataTable({
                            scrollY: true,
                            scrollX: true,
                            paging: false,
                            bLengthChange: false,
                            bFilter: false,
                            ordering: false,
                            responsive: true,
                            destroy: true,
                            retrieve: false,
                            info: false,
                            autoWidth: false,
                            language: {
                                emptyTable: emptyTableText,
                                zeroRecords: zeroRecordsText
                            },
                            columnDefs: [
                                { targets: [0, 1, 2, 3, 4], className: 'text-center' }
                            ]
                        });
                        BackupPlansConfig.dataTableInitialized = true;
                    }
                    
                    // Re-initialize tooltips after DataTable initialization
                    initializeTooltips();
                } catch (error) {
                    // Fallback: just show the table without DataTable features
                    $('#backupPlansTbl').show();
                }
            } else if (BackupPlansConfig.dataTableInitialized) {
                // DataTable already initialized, skipping...
            } else {
                // Fallback: just show the table without DataTable features
                $('#backupPlansTbl').show();
            }
        }

        function populateBackupPlansTable(backupPlans, paginationInfo) {
            var tbody = $('#backupPlansTbl tbody');
            tbody.empty();
            
            // Store pagination info globally for pagination controls
            if (paginationInfo) {
                window.currentPaginationInfo = paginationInfo;
                updatePaginationControls(paginationInfo);
            }

            try {
                // Determine table state and populate accordingly
                var tableState = determineTableState(backupPlans);
                
                switch (tableState.type) {
                    case 'error':
                        handleError('table', tbody, '<%=MyBase.GetResourceString("A_UnableToLoadData")%>' + tableState.data.projectName + '. ' + tableState.data.message);
                        break;
                    case 'data':
                        populateDataRows(tbody, backupPlans);
                        break;
                    case 'empty':
                        tbody.html(createEmptyMessage(tableState.data));
                        break;
                }

                // Initialize DataTable and tooltips
                initializeTableAfterPopulation();
                
            } catch (error) {
                handleError('table', tbody, '<%=MyBase.GetResourceString("A_AnUnexpectedErrorOccurredWhileLoadingData")%>');
            }
        }
        
        // Helper function to determine table state
        function determineTableState(backupPlans) {
            if (backupPlans && Array.isArray(backupPlans) && backupPlans.length > 0) {
                if (backupPlans[0].error) {
                    return { type: 'error', data: backupPlans[0] };
                }
                return { type: 'data', data: backupPlans };
            }
            
            var currentProjectID = getCurrentProjectID();
            var projectName = $('#cboProject option:selected').text();
            return { type: 'empty', data: { currentProjectID: currentProjectID, projectName: projectName } };
        }
        
        
        // Helper function to create empty message HTML
        function createEmptyMessage(emptyData) {
            return '<tr><td colspan="5" class="text-center py-2">' +
                        '<div class="empty-state">' +
                        '<p class=" mb-0"><%=MyBase.GetResourceString("C_NoDataAvailableInTable")%></p>' +
                        '</div>' +
                        '</td></tr>';
        }
        
        // Helper function to populate data rows
        function populateDataRows(tbody, backupPlans) {
            var rows = [];
            backupPlans.forEach(function(plan) {
                // Handle both uppercase and lowercase property names for ID check
                var backPlanID = plan.BackPlanID || plan.backPlanID;
                if (plan && backPlanID) {
                    rows.push(createDataRow(plan));
                }
            });
            tbody.html(rows.join(''));
        }
        
        // Helper function to create a single data row
        function createDataRow(plan) {
            // Handle both uppercase and lowercase property names
            var description = plan.Description || plan.description || '';
            var responsibility = plan.Responsibility || plan.responsibility || '';
            var directoryLocation = plan.DirectoryLocation || plan.directoryLocation || '';
            var frequency = plan.Frequency || plan.frequency || '';
            var backPlanID = plan.BackPlanID || plan.backPlanID || '';
            
            // Build action buttons based on role access
            var actionButtons = '';
            // Always show offcanvas trigger - access control is handled by individual buttons inside
            actionButtons += '<a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_EdtBkPlans" ' +
                'aria-controls="offcanvasWithBothOptions" onclick="editBackupPlan(' + backPlanID + ')">' +
                    '<i class="fas fa-ellipsis-h" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_MoreDetailsTooltip")%>"></i>' +
                '</a>';
            
            return '<tr>' +
                '<td class="col-sm-3">' + escapeHtml(description) + '</td>' +
                '<td class="col-sm-3">' + escapeHtml(responsibility) + '</td>' +
                '<td class="col-sm-4">' + escapeHtml(directoryLocation) + '</td>' +
                '<td class="col-sm-1">' + escapeHtml(frequency) + '</td>' +
                '<td class="col-sm-1">' + actionButtons + '</td>' +
            '</tr>';
        }
        
        // Helper function to initialize table after population
        function initializeTableAfterPopulation() {
            if (!BackupPlansConfig.dataTableInitialized) {
                    setTimeout(function() {
                        var table = $('#backupPlansTbl');
                        var headerCount = table.find('thead th').length;
                    var hasDataRows = table.find('a[onclick*="editBackupPlan"]').length > 0;
                        
                        if (headerCount === 5 && hasDataRows) {
                            initializeDataTable();
                    } else if (headerCount === 5) {
                            initializeTooltips();
                        }
                    }, 150);
                } else {
                    initializeTooltips();
            }
        }


        function editBackupPlan(backPlanId) {
            // Note: Access control is handled by individual buttons inside the offcanvas
            // This function just opens the offcanvas and populates the form
            
            // Store the current backup plan ID for history loading
            window.currentBackPlanID = backPlanId;
            
            var currentProjectID = getCurrentProjectID();
            if (!currentProjectID) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SelectProjectError")%>');
                return;
            }
            
            // Get specific backup plan by ID using the new filter parameter
            var backupPlanParameter = {
                ProjectId: currentProjectID,
                EmployeeID: parseInt(EmployeeId),
                UserName: UserName,
                LoginType: LoginType,
                BackPlanID: parseInt(backPlanId)
            };

            var result = AJAXCallWithResult('api/BackupPlans/GetBackupPlans', JSON.stringify(backupPlanParameter), false);
            
            if (result) {
                // Handle paginated response structure
                var backupPlan;
                if (result.data && Array.isArray(result.data) && result.data.length > 0) {
                    backupPlan = result.data[0]; // Get first item from data array (lowercase)
                } else if (result.Data && Array.isArray(result.Data) && result.Data.length > 0) {
                    backupPlan = result.Data[0]; // Fallback for uppercase Data array
                } else if (Array.isArray(result) && result.length > 0) {
                    backupPlan = result[0]; // Fallback for direct array response
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_BackupPlanNotFound")%>');
                    return;
                }
                
                // Hide history panel before opening offcanvas
                $(".ShowHisDetailpanel").hide();
                
                // Clear history table and reset history state
                $('#BkPlanShowHisTable tbody').empty();
                $('#modifiedHisField').val('').selectpicker('refresh');
                $('#modifiedHisBy').val('').selectpicker('refresh');
                
                // First open the offcanvas
                $('#offcanvas_EdtBkPlans').offcanvas('show');
                
                // Reset offcanvas to edit mode
                resetEditOffcanvasToEditMode();
                
                // Initially hide the Show History link until we check for data
                $('#BkPlansShowHisBtn').hide();
                
                // Wait for offcanvas to be fully shown, then populate form
                setTimeout(function() {
                    populateEditForm(backupPlan);
                    // History panel will only show when "Show History" link is clicked
                }, 300); // Small delay to ensure offcanvas is fully rendered
            } else {
                var errorMessage = '<%=MyBase.GetResourceString("A_ErrorLoadingBackupPlan")%>: ';
                if (!result || result.length === 0) {
                    errorMessage = '<%=MyBase.GetResourceString("A_BackupPlanNotFound")%>';
                } else {
                    errorMessage += '<%=MyBase.GetResourceString("A_UnknownError")%>';
                }
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(errorMessage);
            }
        }

        function populateEditForm(planData) {
            // Handle both uppercase and lowercase property names
            $('#BkPlanEdtDesc').val(planData.Description || planData.description || '');
            $('#BkPlanEdtRespnsblty').val(planData.Responsibility || planData.responsibility || '');
            $('#BkPlanEdtDirctLoc').val(planData.DirectoryLocation || planData.directoryLocation || '');
            $('#BkPlanEdtFrequency').val(planData.Frequency || planData.frequency || '');
            $('#BkPlanEdtMedia').val(planData.Media || planData.media || '');
            $('#BkPlanEdtNoCopies').val(planData.NumberOfCopies || planData.numberOfCopies || '');
            $('#BkPlanEdtRemarks').val(planData.Remarks || planData.remarks || '');
            $('#BkPlanEdtProjectId').val(planData.ProjectID || planData.projectID || 1);
            
            // Store the BackPlanID in hidden field (standard ASPX pattern)
            var backPlanID = planData.BackPlanID || planData.backPlanID;
            $('#BkPlanEdtBackPlanId').val(backPlanID || '');
            
            // Set global variable for history functionality
            window.currentBackPlanID = backPlanID;
            
            // Check if history data exists and show/hide Show History link accordingly
            checkHistoryDataAndToggleLink();
            
            // Clear validation errors and update character counters
            $('.form-control').removeClass('is-invalid');
            $('.invalid-feedback').remove();
            $('#BkPlanEdtDesc, #BkPlanEdtRespnsblty, #BkPlanEdtDirctLoc, #BkPlanEdtFrequency, #BkPlanEdtMedia, #BkPlanEdtRemarks').trigger('input');
        }

        // Function to check if history data exists and toggle Show History link visibility
        function checkHistoryDataAndToggleLink() {
            var currentBackPlanID = window.currentBackPlanID;
            
            if (!currentBackPlanID) {
                // Hide Show History link if no backup plan ID
                $('#BkPlansShowHisBtn').hide();
                return;
            }

            // Show loading state on the Show History link
            $('#BkPlansShowHisBtn span').html('<i class="fas fa-spinner fa-spin"></i> <%=MyBase.GetResourceString("C_CheckingHistory")%>');
            $('#BkPlansShowHisBtn').show();

            // Prepare API call parameters to check for history data
            var historyParameter = {
                BackPlanID: currentBackPlanID,
                ModifiedField: null,
                ModifiedBy: null
            };

            try {
                // Make a lightweight API call to check if history data exists
                var result = AJAXCallWithResult('api/BackupPlans/GetBackupPlanAuditTrailHistory', JSON.stringify(historyParameter), false);

                if (result) {
                    // Handle different response structures
                    var historyData = null;
                    if (result.data && Array.isArray(result.data)) {
                        historyData = result.data;
                    } else if (result.Data && Array.isArray(result.Data)) {
                        historyData = result.Data;
                    } else if (Array.isArray(result)) {
                        historyData = result;
                    }

                    // Show or hide the Show History link based on data availability
                    if (historyData && historyData.length > 0) {
                        $('#BkPlansShowHisBtn span').html('<%=MyBase.GetResourceString("C_ShowHistory")%>');
                        $('#BkPlansShowHisBtn').show();
                    } else {
                        $('#BkPlansShowHisBtn').hide();
                    }
                } else {
                    // Hide Show History link if no response
                    $('#BkPlansShowHisBtn').hide();
                }
            } catch (error) {
                // Hide Show History link on error
                $('#BkPlansShowHisBtn').hide();
                console.log('Error checking history data: ' + error.message);
            }
        }

        function updateBackupPlan(saveAndAdd = false) {
            
            var backPlanId = $('#BkPlanEdtBackPlanId').val();
            var isAddMode = !backPlanId; // If no backPlanId, we're in add mode
            
            if (isAddMode) {
                // Handle add mode - call the add function instead
                addBackupPlanFromEditOffcanvas(saveAndAdd);
                return;
            }

            // Validate form before proceeding - this prevents invalid data from being sent to API
            if (!validateEditForm()) {
                // Validation errors are already shown by validateForm function
                return false;
            }

            var currentProjectID = getCurrentProjectID();
            if (!currentProjectID) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SelectProjectError")%>');
                return false;
            }
            
            var updateData = {
                BackPlanID: parseInt(backPlanId),
                ProjectId: currentProjectID,
                Description: ($('#BkPlanEdtDesc').val() || '').trim(),
                Responsibility: ($('#BkPlanEdtRespnsblty').val() || '').trim(),
                DirectoryLocation: ($('#BkPlanEdtDirctLoc').val() || '').trim(),
                Frequency: ($('#BkPlanEdtFrequency').val() || '').trim(),
                Media: ($('#BkPlanEdtMedia').val() || '').trim(),
                NumberOfCopies: parseInt($('#BkPlanEdtNoCopies').val()) || 0,
                Remarks: ($('#BkPlanEdtRemarks').val() || '').trim(),
                ModifiedBy: UserName || 'Unknown User'
            };

            // Store original button content and show loading state with spinner
            var $saveBtn = $('#saveEdtPlanBtn');
            var $saveAddBtn = $('#saveAddEdtPlanBtn');
            var originalSaveText = $saveBtn.html();
            var originalSaveAddText = $saveAddBtn.html();

            // Show loading state with spinner and improved styling
            $saveBtn.prop('disabled', true)
                .addClass('btn-loading')
                .html('<i class="fas fa-spinner fa-spin me-2"></i><%=MyBase.GetResourceString("C_Saving")%>');
            $saveAddBtn.prop('disabled', true)
                .addClass('btn-loading')
                .html('<i class="fas fa-spinner fa-spin me-2"></i><%=MyBase.GetResourceString("C_Saving")%>');

            // Add visual feedback with opacity change
            $saveBtn.css('opacity', '0.8');
            $saveAddBtn.css('opacity', '0.8');

            try {
                var result = AJAXCallWithResult('api/BackupPlans/UpdateBackupPlan', JSON.stringify(updateData), false);
                
                // Handle both uppercase and lowercase success property names
                if (result && (result.Success || result.success)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('<%=MyBase.GetResourceString("A_BackupPlanUpdatedSuccess")%>');
                    
                    if (saveAndAdd) {
                        // Close the edit panel
                        $('.ShowHisDetailpanel').hide();
                        
                        // Reload the backup plans list
                        loadBackupPlans(false);
                        
                        // Switch the current offcanvas to add mode (keep it open)
                        switchEditOffcanvasToAddMode();
                    } else {
                        // Regular save - close the edit panel
                        $('.ShowHisDetailpanel').hide();
                        // Reload the backup plans list
                        loadBackupPlans(false);
                        // Refresh the Show History link visibility after save
                        checkHistoryDataAndToggleLink();
                    }
                } else {
                    // Handle case where result is null or undefined (AJAX error)
                    var errorMessage = '<%=MyBase.GetResourceString("A_FailedToUpdateBackupPlan")%>: <%=MyBase.GetResourceString("A_UnknownErrorOccurred")%>';
                    alertify.set('notifier', 'position', 'top-right');
                alertify.error(errorMessage);
                }
            } catch (error) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_UnexpectedError")%>');
            } finally {
                // Reset button states
                $saveBtn.prop('disabled', false)
                    .removeClass('btn-loading')
                    .html(originalSaveText)
                    .css('opacity', '1');
                $saveAddBtn.prop('disabled', false)
                    .removeClass('btn-loading')
                    .html(originalSaveAddText)
                    .css('opacity', '1');
            }
            
            return true;
        }
        /**
         * Universal validation function that handles ALL validation scenarios
         */
        function validateForm(options, showNotifications = true, realTime = false) {
            // Handle both string (legacy) and object (new) parameter formats
            var config = typeof options === 'string' ? 
                { formType: options, showNotifications: showNotifications, realTime: realTime } : 
                Object.assign({ formType: 'edit', showNotifications: true, realTime: false }, options);
            
            var isValid = true;
            var errors = [];
            var errorFields = [];
            var fieldMappings = BackupPlansConfig.fieldMappings[config.formType];
            var limits = BackupPlansConfig.fieldLimits;

            // Clear previous validation errors (unless real-time)
            if (!config.realTime) {
            $('.form-control').removeClass('is-invalid');
            $('.invalid-feedback').remove();
            }

            // Enhanced validation rules with more validation types
            var validationRules = [
                {
                    field: 'description',
                    required: true,
                    maxLength: limits.description,
                    type: 'text',
                    errorMessages: {
                        required: '<%=MyBase.GetResourceString("A_DescriptionRequired")%>',
                        maxLength: '<%=MyBase.GetResourceString("A_DescriptionMaxLength")%>'
                    }
                },
                {
                    field: 'responsibility',
                    required: false,
                    maxLength: limits.responsibility,
                    type: 'text',
                    errorMessages: {
                        maxLength: '<%=MyBase.GetResourceString("A_ResponsibilityMaxLength")%>'
                    }
                },
                {
                    field: 'directoryLocation',
                    required: false,
                    maxLength: limits.directoryLocation,
                    type: 'text',
                    errorMessages: {
                        maxLength: '<%=MyBase.GetResourceString("A_DirectoryLocationMaxLength")%>'
                    }
                },
                {
                    field: 'frequency',
                    required: false,
                    maxLength: limits.frequency,
                    type: 'text',
                    errorMessages: {
                        maxLength: '<%=MyBase.GetResourceString("A_FrequencyMaxLength")%>'
                    }
                },
                {
                    field: 'media',
                    required: false,
                    maxLength: limits.media,
                    type: 'text',
                    errorMessages: {
                        maxLength: '<%=MyBase.GetResourceString("A_MediaMaxLength")%>'
                    }
                },
                {
                    field: 'remarks',
                    required: false,
                    maxLength: limits.remarks,
                    type: 'text',
                    errorMessages: {
                        maxLength: '<%=MyBase.GetResourceString("A_RemarksMaxLength")%>'
                    }
                },
                {
                    field: 'numberOfCopies',
                    required: false,
                    type: 'number',
                    min: 1,
                    max: limits.numberOfCopies,
                    errorMessages: {
                        invalid: '<%=MyBase.GetResourceString("A_NumberOfCopiesPositive")%>',
                        maxValue: '<%=MyBase.GetResourceString("A_NumberOfCopiesMaxValue")%>'
                    }
                }
            ];

            // Validate each field using unified logic
            validationRules.forEach(function(rule) {
                var fieldSelector = fieldMappings[rule.field];
                if (!fieldSelector) return; // Skip if field doesn't exist for this form type
                
                var fieldValue = $(fieldSelector).val();
                var value = fieldValue ? fieldValue.trim() : '';
                
                // Required field validation
                if (rule.required && !value) {
                    if (config.realTime) {
                        handleError('field', fieldSelector, rule.errorMessages.required);
                    }
                isValid = false;
                    errors.push(rule.field.charAt(0).toUpperCase() + rule.field.slice(1) + ' is required');
                    errorFields.push(rule.field.charAt(0).toUpperCase() + rule.field.slice(1));
                }
                // Text field validation
                else if (rule.type === 'text' && value && value.length > rule.maxLength) {
                    if (config.realTime) {
                        handleError('field', fieldSelector, rule.errorMessages.maxLength);
                    }
                isValid = false;
                    errors.push(rule.field.charAt(0).toUpperCase() + rule.field.slice(1) + ' cannot exceed ' + rule.maxLength + ' characters');
                    errorFields.push(rule.field.charAt(0).toUpperCase() + rule.field.slice(1));
                }
                // Number field validation
                else if (rule.type === 'number' && value) {
                    var numValue = parseInt(value);
                    if (isNaN(numValue) || numValue < rule.min) {
                        if (config.realTime) {
                            handleError('field', fieldSelector, rule.errorMessages.invalid);
                        }
                isValid = false;
                        errors.push(rule.field.charAt(0).toUpperCase() + rule.field.slice(1) + ' must be a positive number');
                        errorFields.push(rule.field.charAt(0).toUpperCase() + rule.field.slice(1));
                    } else if (numValue > rule.max) {
                        if (config.realTime) {
                            handleError('field', fieldSelector, rule.errorMessages.maxValue);
                        }
                    isValid = false;
                        errors.push(rule.field.charAt(0).toUpperCase() + rule.field.slice(1) + ' cannot exceed ' + rule.max);
                        errorFields.push(rule.field.charAt(0).toUpperCase() + rule.field.slice(1));
                    }
                }
            });

            // Special validation for ProjectID (edit form only)
            if (config.formType === 'edit' && fieldMappings.projectId) {
                var projectIdValue = $(fieldMappings.projectId).val();
                if (!projectIdValue || parseInt(projectIdValue) <= 0) {
                    if (config.realTime) {
                        handleError('field', fieldMappings.projectId, '<%=MyBase.GetResourceString("A_ProjectIDRequired")%>');
                    }
                isValid = false;
                    errors.push('Project ID is required');
                    errorFields.push('Project ID');
                }
            }

            // Handle validation errors (only for non-real-time validation)
            if (!isValid && config.showNotifications && !config.realTime) {
                // Show only the first error message without generic prefix
                var errorMessage = errors[0];
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(errorMessage);
                
                // Focus on first error field
                if (errorFields.length > 0) {
                    var firstErrorField = getFirstErrorField(errorFields);
                    if (firstErrorField) {
                        firstErrorField.focus();
                        if (config.formType === 'add') {
                        firstErrorField.scrollIntoView({ behavior: 'smooth', block: 'center' });
                        }
                    }
                }
                
                // Add visual indicator for add form
                if (config.formType === 'add') {
                $('.form-control.is-invalid').first().closest('.offcanvas, .modal, .card').addClass('validation-error-highlight');
                setTimeout(function() {
                    $('.validation-error-highlight').removeClass('validation-error-highlight');
                }, 3000);
                }
            }

            return {
                isValid: isValid,
                errors: errors,
                errorFields: errorFields
            };
        }

        function setupRealTimeValidation(formType = 'both') {
            var limits = BackupPlansConfig.fieldLimits;
            var fieldMappings = BackupPlansConfig.fieldMappings;
            
            // Get field configurations based on form type
            var fieldConfigs = [];
            
            // Define field requirements
            var fieldRequirements = {
                description: true,
                responsibility: false,
                directoryLocation: false,
                frequency: false,
                media: false,
                remarks: false
            };
            
            if (formType === 'both' || formType === 'add') {
                Object.keys(fieldMappings.add).forEach(function(fieldName) {
                    if (fieldName !== 'numberOfCopies') {
                        fieldConfigs.push({
                            id: fieldMappings.add[fieldName],
                            maxLength: limits[fieldName],
                            label: fieldName.charAt(0).toUpperCase() + fieldName.slice(1).replace(/([A-Z])/g, ' $1').trim(),
                            formType: 'add',
                            required: fieldRequirements[fieldName] || false
                        });
                    }
                });
            }
            
            if (formType === 'both' || formType === 'edit') {
                Object.keys(fieldMappings.edit).forEach(function(fieldName) {
                    if (fieldName !== 'numberOfCopies' && fieldName !== 'projectId') {
                        fieldConfigs.push({
                            id: fieldMappings.edit[fieldName],
                            maxLength: limits[fieldName],
                            label: fieldName.charAt(0).toUpperCase() + fieldName.slice(1).replace(/([A-Z])/g, ' $1').trim(),
                            formType: 'edit',
                            required: fieldRequirements[fieldName] || false
                        });
                    }
                });
            }

            // Setup validation for text fields
            fieldConfigs.forEach(function(field) {
                var $field = $(field.id);
                if ($field.length) {
                    setupFieldValidation($field, field);
                }
            });

            // Setup number field validation
            if (formType === 'both' || formType === 'add') {
                setupNumberFieldValidation('#BkPlanAddNoCopies', 'add');
            }
            if (formType === 'both' || formType === 'edit') {
                setupNumberFieldValidation('#BkPlanEdtNoCopies', 'edit');
            }
        }
        
        /**
         * Sets up individual field validation with real-time feedback
         */
        function setupFieldValidation($field, field) {
                    // Real-time validation
                    $field.on('input', function() {
                        var value = $(this).val();
                        var length = value.length;
                        
                        // Clear previous validation
                handleError('clear', field.id);
                
                // Real-time validation for this specific field only
                var isValid = true;
                var errorMessage = '';
                
                // Check if field is required and empty
                if (field.required && !value.trim()) {
                    isValid = false;
                    errorMessage = field.label + ' is required';
                }
                // Check max length
                else if (value && length > field.maxLength) {
                    isValid = false;
                    errorMessage = field.label + ' cannot exceed ' + field.maxLength + ' characters';
                }
                
                // Apply validation result
                if (!isValid) {
                            $(this).addClass('is-invalid');
                    $(this).after('<div class="invalid-feedback">' + errorMessage + '</div>');
                        }
                    });
                }
        
        /**
         * Sets up number field validation
         * @param {string} selector - Field selector
         * @param {string} formType - Form type for validation
         */
        function setupNumberFieldValidation(selector, formType) {
            // Prevent 'e', 'E' and other non-numeric characters from being entered
            $(selector).on('keypress', function(e) {
                // Allow: backspace, delete, tab, escape, enter
                if ([8, 9, 27, 13, 46].indexOf(e.keyCode) !== -1 ||
                    // Allow: Ctrl+A, Ctrl+C, Ctrl+V, Ctrl+X
                    (e.keyCode === 65 && e.ctrlKey === true) ||
                    (e.keyCode === 67 && e.ctrlKey === true) ||
                    (e.keyCode === 86 && e.ctrlKey === true) ||
                    (e.keyCode === 88 && e.ctrlKey === true) ||
                    // Allow: home, end, left, right
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                    return;
                }
                // Block 'e' and 'E' specifically
                if (e.keyCode === 69 || e.keyCode === 101) {
                    e.preventDefault();
                    return;
                }
                // Ensure that it is a number and stop the keypress
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault();
                }
            });
            
            $(selector).on('input', function() {
                var value = $(this).val();
                var numValue = parseInt(value);
                var limits = BackupPlansConfig.fieldLimits;
                
                $(this).removeClass('is-invalid');
                $(this).next('.invalid-feedback').remove();
                
                if (value && (isNaN(numValue) || numValue < 1)) {
                    $(this).addClass('is-invalid');
                    $(this).after('<div class="invalid-feedback"><%=MyBase.GetResourceString("A_NumberOfCopiesPositive")%></div>');
                } else if (value && numValue > limits.numberOfCopies) {
                    $(this).addClass('is-invalid');
                    $(this).after('<div class="invalid-feedback"><%=MyBase.GetResourceString("A_NumberOfCopiesMaxValue")%> ' + limits.numberOfCopies + '</div>');
                }
            });
        }

        // Backward compatibility wrappers
        function validateEditForm(){return validateForm('edit').isValid}
        function validateAddForm(){return validateForm('add').isValid}

        /**
         * Validates data integrity using the unified validation system
         */

        function getFirstErrorField(errorFields) {
            var fieldMap = {
                'Description': ['#BkPlanAddDesc', '#BkPlanEdtDesc'],
                'Responsibility': ['#BkPlanAddRespnsblty', '#BkPlanEdtRespnsblty'],
                'Directory Location': ['#BkPlanAddDirctLoc', '#BkPlanEdtDirctLoc'],
                'Frequency': ['#BkPlanAddFrequency', '#BkPlanEdtFrequency'],
                'Media': ['#BkPlanAddMedia', '#BkPlanEdtMedia'],
                'Number of Copies': ['#BkPlanAddNoCopies', '#BkPlanEdtNoCopies'],
                'Remarks': ['#BkPlanAddRemarks', '#BkPlanEdtRemarks'],
                'Project ID': ['#BkPlanEdtProjectId']
            };
            
            for (var i = 0; i < errorFields.length; i++) {
                var fieldName = errorFields[i];
                var selectors = fieldMap[fieldName];
                if (selectors) {
                    for (var j = 0; j < selectors.length; j++) {
                        var $field = $(selectors[j]).filter(':visible').first();
                        if ($field.length > 0) {
                            return $field[0];
                        }
                    }
                }
            }
            return null;
        }

        /**
         * Unified error handling system - replaces multiple error functions
         */
        function handleError(type, target, message, options = {}) {
            switch (type) {
                case 'field':
                    // Clear existing field errors first
                    $(target).removeClass('is-invalid');
                    $(target).siblings('.invalid-feedback').remove();
                    $(target).nextAll('.invalid-feedback').remove();
                    
                    // Add error styling and message
                    $(target).addClass('is-invalid');
                    $(target).after('<div class="invalid-feedback">' + message + '</div>');
                    
                    // Add event listener to clear error when user starts typing
                    $(target).off('input.validation-clear').on('input.validation-clear', function() {
                        handleError('field', target, '', { clear: true });
                    });
                    break;
                    
                case 'table':
                    var errorHtml = '<tr><td colspan="5" class="text-center ">' +
                        '<div class="empty-state ">' +
                        '<p class="mb-0"><%=MyBase.GetResourceString("A_ErrorLoadingData")%></p>' +
                        '</div>' +
                        '</td></tr>';
                    $(target).html(errorHtml);
                    break;
                    
                case 'history':
                    var tbody = $('#BkPlanShowHisTable tbody');
                    tbody.html('<tr><td colspan="5" class="text-center">' +
                        '<div class="empty-state ">' +
                        '<p class="mb-0"><%=MyBase.GetResourceString("A_ErrorLoadingData")%></p>' +
                        '</div>' +
                        '</td></tr>');
                    break;
                    
                case 'clear':
                    if (target) {
                        $(target).removeClass('is-invalid');
                        $(target).siblings('.invalid-feedback').remove();
                        $(target).nextAll('.invalid-feedback').remove();
                    } else {
                        // Clear all field errors
                        $('.form-control').removeClass('is-invalid');
                        $('.invalid-feedback').remove();
                    }
                    break;
            }
        }

        function loadBackupPlans(applyFilters = false, isPagination = false, isSearch = false) {
            // Prevent multiple simultaneous calls
            if (BackupPlansConfig.isLoadingBackupPlans) {
                return;
            }
            BackupPlansConfig.isLoadingBackupPlans = true;
            
            // Get ProjectID from dropdown selection
            var selectedProjectID = getCurrentProjectID();
            
            if (!selectedProjectID) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SelectProjectError")%>');
                BackupPlansConfig.isLoadingBackupPlans = false; // Reset loading flag
                return;
            }

            // Reset pagination when applying filters (not when paginating)
            if (applyFilters && !isPagination) {
                currentPage = 1;
            }

            // Show loading state
            showLoadingState();

            var backupPlanParameter = {
                ProjectId: selectedProjectID,
                EmployeeID: parseInt(EmployeeId),
                UserName: UserName,
                LoginType: LoginType,
                PageNumber: currentPage || 1,
                PageSize: pageSize || 10
            };

            // Get search term if searching
            var searchTerm = isSearch ? $('#serchBackup_planInput').val().trim() || null : null;

            // Apply filters if requested
            if (applyFilters) {
                backupPlanParameter.Responsibility = $('#PlanRespFilter').val().trim() || null;
                backupPlanParameter.DirectoryLocation = $('#PlanDirLocFilter').val().trim() || null;
                backupPlanParameter.Frequency = $('#PlanFrequencyFilter').val().trim() || null;
                backupPlanParameter.Media = $('#PlanMediaFilter').val().trim() || null;
                backupPlanParameter.NumberOfCopies = $('#PlanNoCopiesFilter').val() ? parseInt($('#PlanNoCopiesFilter').val()) : null;
                backupPlanParameter.Remarks = $('#PlanRemarksFilter').val().trim() || null;
            } else if (isSearch && searchTerm) {
                // When searching, use search term only for Description parameter
                backupPlanParameter.Responsibility = null;
                backupPlanParameter.DirectoryLocation = null;
                backupPlanParameter.Frequency = null;
                backupPlanParameter.Media = null;
                backupPlanParameter.NumberOfCopies = null;
                backupPlanParameter.Remarks = null;
                backupPlanParameter.Description = searchTerm;
            } else {
                // Explicitly set all filter parameters to null when not applying filters or search
                backupPlanParameter.Responsibility = null;
                backupPlanParameter.DirectoryLocation = null;
                backupPlanParameter.Frequency = null;
                backupPlanParameter.Media = null;
                backupPlanParameter.NumberOfCopies = null;
                backupPlanParameter.Remarks = null;
                backupPlanParameter.Description = null;
            }

            try {
                var result = AJAXCallWithResult('api/BackupPlans/GetBackupPlans', JSON.stringify(backupPlanParameter), false);
                
                if (result) {
                    // Reset error flag on successful data load
                    BackupPlansConfig.errorAlertShown = false;
                    
                    // Handle new paginated response structure
                    if (result.data && Array.isArray(result.data)) {
                        // Handle response format: {message: "...", data: [...], paginationEntities: [...]}
                        var paginationInfo = result.paginationEntities && result.paginationEntities.length > 0 ? result.paginationEntities[0] : null;
                        populateBackupPlansTable(result.data, paginationInfo);
                    } else if (result.Data && Array.isArray(result.Data)) {
                        // Handle response format: {Data: [...]}
                        populateBackupPlansTable(result.Data, result);
                    } else if (Array.isArray(result)) {
                        // Handle direct array response
                        populateBackupPlansTable(result);
                    } else {
                        populateBackupPlansTable([]);
                    }
                    
                    // Show notification when filters are applied successfully
                    if (applyFilters) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success('<%=MyBase.GetResourceString("A_FilterAppliedSuccess")%>');
                    }
                } else {
                    // Handle case where result is null or undefined (AJAX error)
                    var errorMessage = '<%=MyBase.GetResourceString("A_ErrorLoadingData")%>';
                    if (!BackupPlansConfig.errorAlertShown) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(errorMessage);
                        BackupPlansConfig.errorAlertShown = true;
                    }
                    // Show error state instead of empty table
                    var projectName = $('#cboProjects option:selected').text();
                    var errorState = [{
                        error: true,
                        projectName: projectName,
                        message: errorMessage
                    }];
                    // Create pagination info with TotalRecords = 0 for error case
                    var errorPaginationInfo = {
                        CurrentPage: 1,
                        PageSize: 10,
                        TotalRecords: 0,
                        TotalPages: 0
                    };
                    populateBackupPlansTable(errorState, errorPaginationInfo);
                }
            } catch (error) {
                if (!BackupPlansConfig.errorAlertShown) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_ErrorLoadingData")%>');
                    BackupPlansConfig.errorAlertShown = true;
                }
                // Create pagination info with TotalRecords = 0 for error case
                var errorPaginationInfo = {
                    CurrentPage: 1,
                    PageSize: 10,
                    TotalRecords: 0,
                    TotalPages: 0
                };
                populateBackupPlansTable([], errorPaginationInfo);
            } finally {
                hideLoadingState();
                BackupPlansConfig.isLoadingBackupPlans = false; // Reset loading flag
            }
        }

        function showLoadingState() {
            var tbody = $('#backupPlansTbl tbody');
            var currentProjectID = getCurrentProjectID();
            var projectName = $('#cboProject option:selected').text();
            
            var loadingMessage = '';
            if (currentProjectID) {
                loadingMessage = '<tr><td colspan="5" class="text-center py-4">' +
                    '<div class="empty-state">' +
                    '<i class="fas fa-spinner fa-spin fa-2x text-primary mb-3"></i>' +
                    '</div>' +
                    '</td></tr>';
            } else {
                loadingMessage = '<tr><td colspan="5" class="text-center py-4">' +
                    '<div class="empty-state">' +
                    '<i class="fas fa-spinner fa-spin fa-2x text-primary mb-3"></i>' +
                    '</div>' +
                    '</td></tr>';
            }
            tbody.html(loadingMessage);
        }

        function hideLoadingState() {
            // Loading state will be replaced by populateBackupPlansTable
        }

        // Initialize tooltips consistently with other NewAPI files
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();
        
        // Pagination functions - Matching PM_ProjectList.aspx pattern
        var currentPage = 1;
        var pageSize = 10;
        var TotalRecords = 0;
        var totalPages = 0;

        function updatePaginationControls(paginationInfo) {
            if (!paginationInfo) {
                return;
            }

            // Handle both uppercase and lowercase property names
            currentPage = paginationInfo.CurrentPage || paginationInfo.currentPage || 1;
            pageSize = paginationInfo.PageSize || paginationInfo.pageSize || 10;
            TotalRecords = paginationInfo.TotalRecords || paginationInfo.totalRecords || 0;
            totalPages = paginationInfo.TotalPages || paginationInfo.totalPages || 0;

            // Always show pagination controls if there are records
            if (TotalRecords > 0) {
                $('#paginationControls').show();
                
                // Update total records display
                $("#TotalRecords").html(TotalRecords);
                
                // Update pagination state
                Pagination();
            } else {
                $('#paginationControls').hide();
                // Reset pagination state when no records
                currentPage = 1;
                TotalRecords = 0;
                totalPages = 0;
            }
        }

        function Pagination() {
            
            // Reset button states first
            $("#btnprevious").removeClass("fa-disabled");
            $("#btnnext").removeClass("fa-disabled");
            $("#LinkPrevious").removeClass("disabled");
            $("#LinkNext").removeClass("disabled");
            $("#LinkPrevious").attr("onclick", "PrevList()");
            $("#LinkNext").attr("onclick", "NextList()");
            
            // Re-enable pointer events
            $("#btnprevious").css("pointer-events", "auto");
            $("#btnnext").css("pointer-events", "auto");
            $("#LinkPrevious").css("pointer-events", "auto");
            $("#LinkNext").css("pointer-events", "auto");
            
            // Handle case where there are no records
            if (parseInt(TotalRecords) == 0) {
                $("#btnprevious").addClass("fa-disabled");
                $("#btnnext").addClass("fa-disabled");
                $("#LinkPrevious").addClass("disabled");
                $("#LinkNext").addClass("disabled");
                $("#LinkPrevious").prop("onclick", null).off("click");
                $("#LinkNext").prop("onclick", null).off("click");
                $("#btnprevious").css("pointer-events", "none");
                $("#btnnext").css("pointer-events", "none");
                $("#LinkPrevious").css("pointer-events", "none");
                $("#LinkNext").css("pointer-events", "none");
                return;
            }
            
            // Handle first page - disable previous button
            if (parseInt(currentPage) == 1) {
                $("#btnprevious").addClass("fa-disabled");
                $("#LinkPrevious").addClass("disabled");
                $("#LinkPrevious").prop("onclick", null).off("click");
                $("#btnprevious").css("pointer-events", "none");
                $("#LinkPrevious").css("pointer-events", "none");
            }
            
            // Handle last page - disable next button
            if (parseInt(currentPage) >= totalPages) {
                $("#btnnext").addClass("fa-disabled");
                $("#LinkNext").addClass("disabled");
                $("#LinkNext").prop("onclick", null).off("click");
                $("#btnnext").css("pointer-events", "none");
                $("#LinkNext").css("pointer-events", "none");
            }
        }

        function PrevList() {
            // Safety check - prevent navigation if disabled
            if ($("#btnprevious").hasClass("fa-disabled") || $("#LinkPrevious").hasClass("disabled")) {
                return false;
            }
            
            if (currentPage <= 1) {
                currentPage = 1;
            }
            else {
                currentPage -= 1;
            }
            
            // Check if there's an active search term and preserve it during pagination
            var searchTerm = $('#serchBackup_planInput').val().trim();
            var isSearchActive = searchTerm && searchTerm.length > 0;
            loadBackupPlans(false, true, isSearchActive); // Don't apply filters, but do paginate, preserve search if active
        }

        function NextList() {
            // Safety check - prevent navigation if disabled
            if ($("#btnnext").hasClass("fa-disabled") || $("#LinkNext").hasClass("disabled")) {
                return false;
            }
            
            // Only increment if not on last page
            if (currentPage < totalPages) {
                currentPage += 1;
                
                // Check if there's an active search term and preserve it during pagination
                var searchTerm = $('#serchBackup_planInput').val().trim();
                var isSearchActive = searchTerm && searchTerm.length > 0;
                loadBackupPlans(false, true, isSearchActive); // Don't apply filters, but do paginate, preserve search if active
            }
        }

        // Comprehensive tooltip initialization function - consistent with NewAPI pattern
        function initializeTooltips() {
            $('[data-bs-toggle="tooltip"]').tooltip({
                trigger: 'hover',
                container: 'body'
            });
        }
        
        // Function to configure letter-wise search for Bootstrap Select dropdowns
        function configureLetterWiseSearch(selector) {
            $(selector).on('show.bs.select', function() {
                var $dropdown = $(this).next('.bootstrap-select');
                var $searchBox = $dropdown.find('.bs-searchbox input');
                
                if ($searchBox.length > 0) {
                    // Remove any existing handlers
                    $searchBox.off('input.letterwise keyup.letterwise');
                    
                    // Add custom letter-wise search handler
                    $searchBox.on('input.letterwise keyup.letterwise', function() {
                        var searchTerm = $(this).val().toLowerCase().trim();
                        var $allOptions = $dropdown.find('.dropdown-menu li:not(.no-results)');
                        
                        if (searchTerm === '') {
                            // Show all options when search is empty
                            $allOptions.show();
                        } else {
                            // Filter options that start with search term
                            $allOptions.each(function() {
                                var $option = $(this);
                                var optionText = $option.text().toLowerCase().trim();
                                
                                if (optionText.startsWith(searchTerm)) {
                                    $option.show();
                                } else {
                                    $option.hide();
                                }
                            });
                        }
                    });
                }
            });
        }
        
        // Fill Project Combo Box - DISABLED: Now using server-side DrawComboBox
        // This function is no longer needed as we're using server-side rendering
        function FillProjectCombox() {
            // Server-side dropdown is already populated, no need for AJAX calls
            return;
        }

        // Helper function to get current ProjectID from dropdown
        function getCurrentProjectID() {
            var selectedProjectID = $('#cboProject').val();
            
            if (!selectedProjectID || selectedProjectID === '' || selectedProjectID === '0') {
                return null;
            }
            return parseInt(selectedProjectID);
        }

        // PlotProjectonChange function - Server-side dropdown change handler
        function PlotProjectonChange() {

            ProjectID = $("#cboProject").val();
            setUserSelectedProjectID(ProjectID); // Store user's selection
            BackupPlansConfig.userHasSelectedProject = true; // Mark that user has made a selection
            BackupPlansConfig.dropdownPopulated = true; // Mark dropdown as populated
            
            // Reset the user cleared filters flag for new project
            userClearedFilters = false;
            
            // Clear any existing filters without showing notification
            clearAll(false);
            
            // Hide Clear All button when project changes
            $('#ClearAllFilter').removeClass('show');
            
            // Remove filter button clicked state when project changes (filters are cleared)
            $('#AdvanceFilterIcon').removeClass('AdvanceFilterIconClicked');
            
            // Reload backup plans for the new project
            loadBackupPlans();
        }

        // Change Project function - Legacy function for compatibility
        function ChangeProject(obj) {
            ProjectID = obj.value;
            setUserSelectedProjectID(obj.value); // Store user's selection
            BackupPlansConfig.userHasSelectedProject = true; // Mark that user has made a selection
            BackupPlansConfig.dropdownPopulated = true; // Mark dropdown as populated to prevent FillProjectCombox from overriding
            
            // Reset the user cleared filters flag for new project
            userClearedFilters = false;
            
            // Clear any existing filters without showing notification
            clearAll(false);
            
            // Hide Clear All button when project changes
            $('#ClearAllFilter').removeClass('show');
            
            // Remove filter button clicked state when project changes (filters are cleared)
            $('#AdvanceFilterIcon').removeClass('AdvanceFilterIconClicked');
            
            // Reload backup plans for the new project
            loadBackupPlans();
        }
        
        $(function () {
            
            // Ensure Clear All button is hidden on page load
            $('#ClearAllFilter').removeClass('show');
            
            // Initialize bootstrap tooltips
            initializeTooltips();
            
            // Set the dropdown to the session project on page load
            if (BackupPlansConfig.userHasSelectedProject && BackupPlansConfig.userSelectedProjectID) {
                // Set the dropdown to the user's selection
                $('#cboProject').val(BackupPlansConfig.userSelectedProjectID);
                ProjectID = BackupPlansConfig.userSelectedProjectID;
                BackupPlansConfig.dropdownPopulated = true; // Mark dropdown as populated to prevent FillProjectCombox from overriding
                
                // Trigger the project change event to load data
                PlotProjectonChange();
            }
            
            // Initialize Bootstrap collapse manually if needed
            if (typeof bootstrap !== 'undefined' && bootstrap.Collapse) {
                var collapseElement = document.getElementById('filterpanel');
                if (collapseElement) {
                    var collapseInstance = new bootstrap.Collapse(collapseElement, {
                        toggle: false
                    });
                }
            }
            
            // Filter button click handler
            $('#AdvanceFilterIcon').on('click', function(e) {
                e.preventDefault();
                
                // Don't toggle the clicked class here - it's controlled by filter state
                // The class is added when filters are applied and removed when cleared
                
                // Try multiple methods to toggle the panel
                if (typeof bootstrap !== 'undefined' && bootstrap.Collapse) {
                    var collapseElement = document.getElementById('filterpanel');
                    var collapse = bootstrap.Collapse.getOrCreateInstance(collapseElement);
                    collapse.toggle();
                } else if ($.fn.collapse) {
                    $('#filterpanel').collapse('toggle');
                } else {
                    // Fallback: simple show/hide
                    $('#filterpanel').toggle();
                }
            });

            // Search button click handler - now handled by onclick attribute

            // Server-side dropdown is already populated, no need to call FillProjectCombox()
            // Mark dropdown as populated since it's server-side rendered
            BackupPlansConfig.dropdownPopulated = true;
            
            // Initialize pagination controls
            $('#paginationControls').hide();
            
            // Hide Clear All button on page load
            $('#ClearAllFilter').removeClass('show');
            
            // Load backup plans on page load only if project is selected
            var currentProjectID = getCurrentProjectID();
            if (currentProjectID) {
                setUserSelectedProjectID(currentProjectID.toString()); // Store initial selection
                BackupPlansConfig.userHasSelectedProject = true; // Mark that user has made a selection
                loadBackupPlans();
            } else {
                // Show empty state for no project selected
                var tbody = $('#backupPlansTbl tbody');
                var emptyMessage = '<tr><td colspan="5" class="text-center py-4">' +
                    '<div class="empty-state">' +
                    '<i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>' +
                    '<h5 class="text-muted"><%=MyBase.GetResourceString("C_PleaseSelectProject")%></h5>' +
                    '<p class="text-muted mb-0"><%=MyBase.GetResourceString("C_SelectProjectFromDropdown")%></p>' +
                    '</div>' +
                    '</td></tr>';
                tbody.html(emptyMessage);
            }
            
            
            // Add event handlers for filter functionality
            $('#applyFilterBtn').on('click', function(e) {
                e.preventDefault();
                
                // Validate that at least one filter value is provided before applying
                if (!validateFilterValues()) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_AtLeastOneFilterRequired")%>');
                    return;
                }
                
                loadBackupPlans(true); // Apply filters
                
                // Show Clear All button when filters are applied
                $('#ClearAllFilter').addClass('show');
                
                // Apply filter button clicked state when filters are applied
                $('#AdvanceFilterIcon').addClass('AdvanceFilterIconClicked');
            });
            
            // Add event handler for Clear All button
            $('.clearalllink').on('click', function(e) {
                e.preventDefault();
                ClearAllFilters();
            });
            
            
            // Add event handlers for add functionality
            $('#AddClickYes').on('click', function() {
                addBackupPlan();
            });
            
            $('#AddClickNo').on('click', function() {
                clearAddForm();
            });

            // Clear validation errors when user starts typing
            $('#BkPlanEdtDesc, #BkPlanAddDesc').on('input', function() {
                $(this).removeClass('is-invalid');
                $(this).next('.invalid-feedback').remove();
            });

            // Real-time validation for all form fields
            setupRealTimeValidation();

            // Add event handlers for edit functionality
            $('#saveEdtPlanBtn').on('click', function() {
                updateBackupPlan(false); // false = regular save
            });
            
            $('#saveAddEdtPlanBtn').on('click', function() {
                updateBackupPlan(true); // true = save and add new
            });

            // Add event handler for delete functionality
            $('#deleteBkPlanBtn').on('click', function() {
                deleteBackupPlan();
            });

            // Add event handlers for add offcanvas functionality
            $('#saveAddPlanBtn').on('click', function() {
                addBackupPlanOffcanvas(false); // false = regular save
            });
            
            $('#saveAddNewPlanBtn').on('click', function() {
                addBackupPlanOffcanvas(true); // true = save and add new
            });

            // Handle offcanvas close events properly
            // Handle offcanvas close button
            $('[data-bs-dismiss="offcanvas"]').on('click', function() {
                $('body').removeClass('offcanvas-open');
                // Hide history panel when closing offcanvas
                $(".ShowHisDetailpanel").hide();
            });
            
            // Handle offcanvas backdrop click
            $('#offcanvasBackdrop').on('click', function() {
                $('body').removeClass('offcanvas-open');
                // Hide history panel when closing offcanvas
                $(".ShowHisDetailpanel").hide();
            });
            
            // Handle offcanvas hidden event
            $('#offcanvas_EdtBkPlans').on('hidden.bs.offcanvas', function() {
                $('body').removeClass('offcanvas-open');
                // Hide history panel when offcanvas is hidden
                $(".ShowHisDetailpanel").hide();
            });

            // Handle add offcanvas hidden event
            $('#offcanvas_AddBkPlans').on('hidden.bs.offcanvas', function() {
                $('body').removeClass('offcanvas-open');
            });
            
            // Handle escape key
            $(document).on('keydown', function(e) {
                if (e.key === 'Escape' && $('.offcanvas.show').length > 0) {
                    $('body').removeClass('offcanvas-open');
                    // Hide history panel when closing offcanvas with escape key
                    $(".ShowHisDetailpanel").hide();
                }
            });

            // Global offcanvas close handler - catch all close events
            $(document).on('hidden.bs.offcanvas', '.offcanvas', function() {
                $('body').removeClass('offcanvas-open');
                // Hide history panel when any offcanvas is hidden
                $(".ShowHisDetailpanel").hide();
            });

            // Additional safety - check for offcanvas state periodically
            setInterval(function() {
                if ($('.offcanvas.show').length === 0) {
                    $('body').removeClass('offcanvas-open');
                }
            }, 100);
        })
        // Tooltip cleanup on click - consistent with other NewAPI files
        $('body').on('click', function () {
            $('.tooltip').remove();
        });

        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
            // Add blue color to filter button when panel opens
            $('#AdvanceFilterIcon').addClass('AdvanceFilterIconClicked');
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
            // Only remove blue color from filter button if no filters are applied
            if (!$('#ClearAllFilter').hasClass('show')) {
                $('#AdvanceFilterIcon').removeClass('AdvanceFilterIconClicked');
            }
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $("#PPTTbl_wrapper .dataTables_scrollBody").css({ height: tblheight - 232, "overflow-y": "auto" });
            $("#BkPlanShowHisTable_wrapper .dataTables_scrollBody").css({ height: tblheight - 400, "overflow-y": "auto" });
            $('#backupPlansTbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 280, "overflow-y": "auto" });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

// for Search script start here
function searchBackup_plan() {
    // Reset to first page when searching
    currentPage = 1;
    // Load backup plans with search term
    loadBackupPlans(false, false, true);
}

// Handle search input oninput event
function handleSearchInput() {
    searchBackup_plan();
}
// for Search script End here


        // Clear All function for filter panel
        function clearAll(showNotificationFlag = true) {
            // Clear all filter inputs
            $('#PlanRespFilter').val('');
            $('#PlanDirLocFilter').val('');
            $('#PlanFrequencyFilter').val('');
            $('#PlanMediaFilter').val('');
            $('#PlanNoCopiesFilter').val('');
            $('#PlanRemarksFilter').val('');
            
            // Note: Search input is intentionally NOT cleared - only basic filters are cleared
            
            // Hide Clear All button after clearing filters
            $('#ClearAllFilter').removeClass('show');
            
            // Remove filter button clicked state when filters are cleared
            $('#AdvanceFilterIcon').removeClass('AdvanceFilterIconClicked');
            
            // Reset pagination to first page when clearing filters
            currentPage = 1;
            
            // Show notification only if requested
            if (showNotificationFlag) {
                try {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('<%=MyBase.GetResourceString("A_AllFiltersClearedSuccess")%>');
                } catch (error) {
                    // Continue execution even if notification fails
                }
            }
            
            // Reload data without filters
            loadBackupPlans(false, false);
        }

        // Clear All Filters function - called by Clear All button
        function clearAllFilters() {
            clearAll(true);
        }


        // Add new backup plan
        function addBackupPlan() {
            
            // Validate form before proceeding - this prevents invalid data from being sent to API
            if (!validateAddForm()) {
                // Validation errors are already shown by validateForm function
                return false;
            }

            // Get current project ID from dropdown
            var currentProjectID = getCurrentProjectID();
            if (!currentProjectID) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SelectProjectError")%>');
                return false;
            }
            
            // Prepare data for API call
            var backupPlanData = {
                ProjectId: currentProjectID,
                Description: ($('#BkPlanAddDesc').val() || '').trim(),
                Responsibility: ($('#BkPlanAddRespnsblty').val() || '').trim(),
                DirectoryLocation: ($('#BkPlanAddDirctLoc').val() || '').trim(),
                Frequency: ($('#BkPlanAddFrequency').val() || '').trim(),
                Media: ($('#BkPlanAddMedia').val() || '').trim(),
                NumberOfCopies: parseInt($('#BkPlanAddNoCopies').val()) || 0,
                Remarks: ($('#BkPlanAddRemarks').val() || '').trim(),
                CreatedBy: UserName || '<%=MyBase.GetResourceString("A_UnknownUser")%>'
            };

            // Show loading state
            $('#AddClickYes').addClass('loading').html('<i class="fas fa-spinner fa-spin"></i>').prop('disabled', true);

            try {
                var result = AJAXCallWithResult('api/BackupPlans/InsertBackupPlan', JSON.stringify(backupPlanData), false);
                // Handle both uppercase and lowercase success property names
                if (result && (result.Success || result.success)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('<%=MyBase.GetResourceString("A_BackupPlanAddedSuccess")%>');
                    clearAddForm();
                    
                    // Close any open modals/offcanvas
                    $('.offcanvas').offcanvas('hide');
                    
                    // Close the add backup plan accordion section
                    $('#AddBkPlanDtlsTab').collapse('hide');
                    
                    // Reset pagination and reload the backup plans list
                    currentPage = 1;
                    loadBackupPlans(false);
                } else {
                    // Handle case where result is null or undefined (AJAX error)
                    var errorMessage = '<%=MyBase.GetResourceString("A_FailedToAddBackupPlan")%>: <%=MyBase.GetResourceString("A_UnknownErrorOccurred")%>';
                    alertify.set('notifier', 'position', 'top-right');
                alertify.error(errorMessage);
                }
            } catch (error) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_UnexpectedError")%>');
            } finally {
                // Reset button state
                $('#AddClickYes').removeClass('loading').html('').prop('disabled', false);
            }
            
            return true;
        }

        // Clear add form
        function clearAddForm() {
            $('#BkPlanAddDesc').val('');
            $('#BkPlanAddRespnsblty').val('');
            $('#BkPlanAddDirctLoc').val('');
            $('#BkPlanAddFrequency').val('');
            $('#BkPlanAddMedia').val('');
            $('#BkPlanAddNoCopies').val('');
            $('#BkPlanAddRemarks').val('');
            
            // Clear validation errors
            $('.form-control').removeClass('is-invalid');
            $('.invalid-feedback').remove();
        }

        // Clear add offcanvas form
        function clearAddOffcanvasForm() {
            $('#BkPlanAddOffcanvasDesc').val('');
            $('#BkPlanAddOffcanvasRespnsblty').val('');
            $('#BkPlanAddOffcanvasDirctLoc').val('');
            $('#BkPlanAddOffcanvasFrequency').val('');
            $('#BkPlanAddOffcanvasMedia').val('');
            $('#BkPlanAddOffcanvasNoCopies').val('');
            $('#BkPlanAddOffcanvasRemarks').val('');
            
            // Clear validation errors
            $('.form-control').removeClass('is-invalid');
            $('.invalid-feedback').remove();
        }

        // Switch edit offcanvas to add mode (keep offcanvas open)
        function switchEditOffcanvasToAddMode() {
            // Clear all edit form fields
            $('#BkPlanEdtBackPlanId').val('');
            $('#BkPlanEdtDesc').val('');
            $('#BkPlanEdtRespnsblty').val('');
            $('#BkPlanEdtDirctLoc').val('');
            $('#BkPlanEdtFrequency').val('');
            $('#BkPlanEdtMedia').val('');
            $('#BkPlanEdtNoCopies').val('');
            $('#BkPlanEdtRemarks').val('');
            
            // Clear validation errors
            $('.form-control').removeClass('is-invalid');
            $('.invalid-feedback').remove();
            
            // Hide the Show History button and panel
            $('#BkPlansShowHisBtn').hide();
            $('.ShowHisDetailpanel').hide();
            
            // Keep the header title consistent
            // $('.pgtitle').text('<%=MyBase.GetResourceString("C_AddNewBackupPlan")%>');
            
            // Show only Save and Save & Add buttons (hide Delete button)
            $('#saveEdtPlanBtn').show();
            $('#saveAddEdtPlanBtn').show();
            $('#deleteBkPlanBtn').hide();
            
            // Focus on the first input field
            $('#BkPlanEdtDesc').focus();
        }

        // Reset edit offcanvas to edit mode
        function resetEditOffcanvasToEditMode() {
            // Show the Show History button
            $('#BkPlansShowHisBtn').show();
            
            // Keep the header title consistent
            // $('.pgtitle').text('<%=MyBase.GetResourceString("C_HeaderTitle")%>');
            
            // Show all buttons (Save, Save & Add, Delete)
            $('#saveEdtPlanBtn').show();
            $('#saveAddEdtPlanBtn').show();
            $('#deleteBkPlanBtn').show();
        }

        // Add new backup plan from edit offcanvas (when in add mode)
        function addBackupPlanFromEditOffcanvas(saveAndAdd) {
            
            // Validate form before proceeding
            if (!validateEditForm()) {
                return false;
            }

            // Get current project ID from dropdown
            var currentProjectID = getCurrentProjectID();
            if (!currentProjectID) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SelectProjectError")%>');
                return false;
            }
            
            // Prepare data for API call
            var backupPlanData = {
                ProjectId: currentProjectID,
                Description: ($('#BkPlanEdtDesc').val() || '').trim(),
                Responsibility: ($('#BkPlanEdtRespnsblty').val() || '').trim(),
                DirectoryLocation: ($('#BkPlanEdtDirctLoc').val() || '').trim(),
                Frequency: ($('#BkPlanEdtFrequency').val() || '').trim(),
                Media: ($('#BkPlanEdtMedia').val() || '').trim(),
                NumberOfCopies: parseInt($('#BkPlanEdtNoCopies').val()) || 0,
                Remarks: ($('#BkPlanEdtRemarks').val() || '').trim(),
                CreatedBy: UserName || '<%=MyBase.GetResourceString("A_UnknownUser")%>'
            };

            // Show loading state
            var $saveBtn = $('#saveEdtPlanBtn');
            var $saveAddBtn = $('#saveAddEdtPlanBtn');
            var originalSaveText = $saveBtn.html();
            var originalSaveAddText = $saveAddBtn.html();

            $saveBtn.prop('disabled', true)
                .addClass('btn-loading')
                .html('<i class="fas fa-spinner fa-spin me-2"></i><%=MyBase.GetResourceString("C_Saving")%>');
            $saveAddBtn.prop('disabled', true)
                .addClass('btn-loading')
                .html('<i class="fas fa-spinner fa-spin me-2"></i><%=MyBase.GetResourceString("C_Saving")%>');

            try {
                var result = AJAXCallWithResult('api/BackupPlans/InsertBackupPlan', JSON.stringify(backupPlanData), false);
                // Handle both uppercase and lowercase success property names
                if (result && (result.Success || result.success)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('<%=MyBase.GetResourceString("A_BackupPlanAddedSuccess")%>');
                    
                    if (saveAndAdd) {
                        // Clear the form and keep the offcanvas open for adding another record
                        switchEditOffcanvasToAddMode();
                        // Reload the backup plans list
                        loadBackupPlans(false);
                    } else {
                        // Close the offcanvas and reload the list
                        $('#offcanvas_EdtBkPlans').offcanvas('hide');
                        $('body').removeClass('offcanvas-open');
                        // Reload the backup plans list
                        loadBackupPlans(false);
                    }
                } else {
                    // Handle case where result is null or undefined (AJAX error)
                    var errorMessage = '<%=MyBase.GetResourceString("A_FailedToAddBackupPlan")%>: <%=MyBase.GetResourceString("A_UnknownErrorOccurred")%>';
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(errorMessage);
                }
            } catch (error) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_UnexpectedError")%>');
            } finally {
                // Reset button states
                $saveBtn.prop('disabled', false)
                    .removeClass('btn-loading')
                    .html(originalSaveText);
                $saveAddBtn.prop('disabled', false)
                    .removeClass('btn-loading')
                    .html(originalSaveAddText);
            }
            
            return true;
        }

        // Add new backup plan from offcanvas
        function addBackupPlanOffcanvas(saveAndAdd) {
            
            // Validate form before proceeding
            if (!validateAddOffcanvasForm()) {
                return false;
            }

            // Get current project ID from dropdown
            var currentProjectID = getCurrentProjectID();
            if (!currentProjectID) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SelectProjectError")%>');
                return false;
            }
            
            // Prepare data for API call
            var backupPlanData = {
                ProjectId: currentProjectID,
                Description: ($('#BkPlanAddOffcanvasDesc').val() || '').trim(),
                Responsibility: ($('#BkPlanAddOffcanvasRespnsblty').val() || '').trim(),
                DirectoryLocation: ($('#BkPlanAddOffcanvasDirctLoc').val() || '').trim(),
                Frequency: ($('#BkPlanAddOffcanvasFrequency').val() || '').trim(),
                Media: ($('#BkPlanAddOffcanvasMedia').val() || '').trim(),
                NumberOfCopies: parseInt($('#BkPlanAddOffcanvasNoCopies').val()) || 0,
                Remarks: ($('#BkPlanAddOffcanvasRemarks').val() || '').trim(),
                CreatedBy: UserName || '<%=MyBase.GetResourceString("A_UnknownUser")%>'
            };

            // Show loading state
            var $saveBtn = $('#saveAddPlanBtn');
            var $saveAddBtn = $('#saveAddNewPlanBtn');
            var originalSaveText = $saveBtn.html();
            var originalSaveAddText = $saveAddBtn.html();

            $saveBtn.prop('disabled', true)
                .addClass('btn-loading')
                .html('<i class="fas fa-spinner fa-spin me-2"></i><%=MyBase.GetResourceString("C_Saving")%>');
            $saveAddBtn.prop('disabled', true)
                .addClass('btn-loading')
                .html('<i class="fas fa-spinner fa-spin me-2"></i><%=MyBase.GetResourceString("C_Saving")%>');

            try {
                var result = AJAXCallWithResult('api/BackupPlans/InsertBackupPlan', JSON.stringify(backupPlanData), false);
                // Handle both uppercase and lowercase success property names
                if (result && (result.Success || result.success)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('<%=MyBase.GetResourceString("A_BackupPlanAddedSuccess")%>');
                    
                    if (saveAndAdd) {
                        // Clear the form and keep the offcanvas open for adding another record
                        clearAddOffcanvasForm();
                        // Reload the backup plans list
                        loadBackupPlans(false);
                        // Ensure the offcanvas stays in add mode (refresh the form state)
                        $('#offcanvas_AddBkPlans').offcanvas('show');
                        $('body').addClass('offcanvas-open');
                    } else {
                        // Close the offcanvas and reload the list
                        $('#offcanvas_AddBkPlans').offcanvas('hide');
                        $('body').removeClass('offcanvas-open');
                        // Reload the backup plans list
                        loadBackupPlans(false);
                    }
                } else {
                    // Handle case where result is null or undefined (AJAX error)
                    var errorMessage = '<%=MyBase.GetResourceString("A_FailedToAddBackupPlan")%>: <%=MyBase.GetResourceString("A_UnknownErrorOccurred")%>';
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(errorMessage);
                }
            } catch (error) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_UnexpectedError")%>');
            } finally {
                // Reset button states
                $saveBtn.prop('disabled', false)
                    .removeClass('btn-loading')
                    .html(originalSaveText);
                $saveAddBtn.prop('disabled', false)
                    .removeClass('btn-loading')
                    .html(originalSaveAddText);
            }
            
            return true;
        }

        // Validate add offcanvas form
        function validateAddOffcanvasForm() {
            var isValid = true;
            var errors = [];
            var errorFields = [];

            // Clear previous validation errors
            $('.form-control').removeClass('is-invalid');
            $('.invalid-feedback').remove();

            // Validate Description (required)
            var description = $('#BkPlanAddOffcanvasDesc').val().trim();
            if (!description) {
                errors.push('<%=MyBase.GetResourceString("A_DescriptionRequired")%>');
                errorFields.push('#BkPlanAddOffcanvasDesc');
                isValid = false;
            } else if (description.length > 1000) {
                errors.push('<%=MyBase.GetResourceString("A_DescriptionTooLong")%>');
                errorFields.push('#BkPlanAddOffcanvasDesc');
                isValid = false;
            }

            // Validate other fields for length
            var responsibility = $('#BkPlanAddOffcanvasRespnsblty').val().trim();
            if (responsibility.length > 500) {
                errors.push('<%=MyBase.GetResourceString("A_ResponsibilityTooLong")%>');
                errorFields.push('#BkPlanAddOffcanvasRespnsblty');
                isValid = false;
            }

            var directoryLocation = $('#BkPlanAddOffcanvasDirctLoc').val().trim();
            if (directoryLocation.length > 500) {
                errors.push('<%=MyBase.GetResourceString("A_DirectoryLocationTooLong")%>');
                errorFields.push('#BkPlanAddOffcanvasDirctLoc');
                isValid = false;
            }

            var frequency = $('#BkPlanAddOffcanvasFrequency').val().trim();
            if (frequency.length > 200) {
                errors.push('<%=MyBase.GetResourceString("A_FrequencyTooLong")%>');
                errorFields.push('#BkPlanAddOffcanvasFrequency');
                isValid = false;
            }

            var media = $('#BkPlanAddOffcanvasMedia').val().trim();
            if (media.length > 200) {
                errors.push('<%=MyBase.GetResourceString("A_MediaTooLong")%>');
                errorFields.push('#BkPlanAddOffcanvasMedia');
                isValid = false;
            }

            var remarks = $('#BkPlanAddOffcanvasRemarks').val().trim();
            if (remarks.length > 500) {
                errors.push('<%=MyBase.GetResourceString("A_RemarksTooLong")%>');
                errorFields.push('#BkPlanAddOffcanvasRemarks');
                isValid = false;
            }

            // Show validation errors
            if (!isValid) {
                errorFields.forEach(function(fieldId) {
                    $(fieldId).addClass('is-invalid');
                });

                if (errors.length > 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(errors[0]); // Show first error
                }
            }

            return isValid;
        }

        // Unified delete function for both single and bulk deletion
        function deleteBackupPlan(backPlanId) {
            
            // If no backPlanId provided, try to get it from the edit form
            if (!backPlanId) {
                backPlanId = $('#BkPlanEdtBackPlanId').val();
            }
            
            if (!backPlanId) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_InvalidBackupPlanIDDelete")%>');
                return;
            }

            // Store the backup plan ID for deletion
            $('#DeleteBackupPlanId').attr('value', backPlanId);
            
            // Show the delete confirmation modal
            $('#deleteBackupPlanModal').modal('show');
        }

        // Function to confirm deletion after modal confirmation
        function confirmDeleteBackupPlan() {
            var backPlanId = $('#DeleteBackupPlanId').attr('value');
            
            if (!backPlanId) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_InvalidBackupPlanIDDelete")%>');
                return;
            }

            // Show loading state
            var $deleteBtn = $('#deleteBkPlanBtn');
            if ($deleteBtn.length) {
                $deleteBtn.prop('disabled', true).text('Deleting...');
            }

            // Call the actual delete API
            var deleteParameter = {
                BackPlanID: parseInt(backPlanId)
            };
            
            // Use async call to properly handle the response
            $.ajax({
                url: encodeURI(strUrl + '/api/BackupPlans/DeleteBackupPlan'),
                type: "POST",
                data: JSON.stringify(deleteParameter),
                async: true,
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                    xhr.setRequestHeader("Params", encryptString(JSON.stringify(deleteParameter)));
                },
                success: function (data) {
                    // Check if the response indicates success (handle both uppercase and lowercase)
                    if (data && (data.Success || data.success)) {
                        // Remove the row from the table
                        $('#backupPlansTbl tbody tr').each(function() {
                            var rowBackPlanId = $(this).find('a[onclick*="editBackupPlan"]').attr('onclick');
                            if (rowBackPlanId && rowBackPlanId.includes(backPlanId)) {
                                $(this).fadeOut(300, function() {
                                    $(this).remove();
                                });
                            }
                        });
                        
                        // Reinitialize DataTable
                        if ($.fn.DataTable.isDataTable('#backupPlansTbl')) {
                            $('#backupPlansTbl').DataTable().draw();
                        }
                        
                        // Refresh data to update pagination properly
                        loadBackupPlans();
                        
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(data.Message || data.message || '<%=MyBase.GetResourceString("A_BackupPlanDeletedSuccess")%>');
                        // Close the edit panel
                        $('.ShowHisDetailpanel').hide();
                        // Close the offcanvas after successful delete
                        $('#offcanvas_EdtBkPlans').offcanvas('hide');
                        $('body').removeClass('offcanvas-open');
                    } else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('<%=MyBase.GetResourceString("A_ErrorDeletingBackupPlan")%> ' + (data.Message || data.message || '<%=MyBase.GetResourceString("A_UnknownError")%>'));
                    }
                },
                error: function (xhr, status, error) {
                    var errorMessage = '<%=MyBase.GetResourceString("A_ErrorDeletingBackupPlan")%> ';
                    try {
                        var errorData = JSON.parse(xhr.responseText);
                        errorMessage += errorData.Message || errorData.message || error;
                    } catch (e) {
                        errorMessage += error;
                    }
                    alertify.set('notifier', 'position', 'top-right');
                alertify.error(errorMessage);
                },
                complete: function() {
                    if ($deleteBtn.length) {
                        $deleteBtn.prop('disabled', false).text('Delete');
                    }
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
            
            // Load backup plan history when showing history tab
            loadBackupPlanHistory();
            
            // Refresh selectpicker dropdowns to ensure proper display
            setTimeout(function() {
                if (typeof $.fn.selectpicker !== 'undefined') {
                    // Store current values before refresh
                    var modifiedFieldValue = $('#modifiedHisField').val();
                    var modifiedByValue = $('#modifiedHisBy').val();
                    
                    // Refresh all selectpickers
                    $('.selectpicker').selectpicker('refresh');
                    
                    // Restore the selected values after refresh
                    if (modifiedFieldValue) {
                        $('#modifiedHisField').selectpicker('val', modifiedFieldValue);
                    }
                    if (modifiedByValue) {
                        $('#modifiedHisBy').selectpicker('val', modifiedByValue);
                    }
                }
                // Re-initialize tooltips for dynamically shown content
                initializeTooltips();
            }, 100);
        }

        // Function to load backup plan audit trail history
        function loadBackupPlanHistory() {
            
            var currentProjectID = getCurrentProjectID();
            var currentBackPlanID = window.currentBackPlanID; // This should be set when editing a backup plan
            
            if (!currentProjectID) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SelectProjectError")%>');
                return;
            }
            
            if (!currentBackPlanID) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_NoBackupPlanSelectedHistory")%>');
                return;
            }

            // Show loading state
            var historyTbody = $('#BkPlanShowHisTable tbody');
            historyTbody.html('<tr><td colspan="5" class="text-center py-4"><i class="fas fa-spinner fa-spin"></i></td></tr>');

            // Load filter dropdowns first
            loadFilterDropdowns(currentBackPlanID);

            // Load history with current filter selections
            loadHistoryWithFilters();
        }

        // Function to load history with current filter selections
        function loadHistoryWithFilters() {
            var currentBackPlanID = window.currentBackPlanID;

            // Get current filter values
            var selectedField = $('#modifiedHisField').val() || '';
            var selectedModifiedBy = $('#modifiedHisBy').val() || '';

            // Prepare API call parameters with filters
            // Convert empty strings to null for proper API filtering
            var historyParameter = {
                BackPlanID: currentBackPlanID,
                ModifiedField: selectedField === '' ? null : selectedField,
                ModifiedBy: selectedModifiedBy === '' ? null : selectedModifiedBy
            };

            try {
                var result = AJAXCallWithResult('api/BackupPlans/GetBackupPlanAuditTrailHistory', JSON.stringify(historyParameter), false);

                if (result) {
                    // Handle different response structures
                    var historyData = null;
                    if (result.data && Array.isArray(result.data)) {
                        historyData = result.data;
                    } else if (result.Data && Array.isArray(result.Data)) {
                        historyData = result.Data;
                    } else if (Array.isArray(result)) {
                        historyData = result;
                    }

                    if (historyData) {
                        populateHistoryTable(historyData);
                    } else {
                        handleError('history', null, 'No history data found in response');
                    }
                } else {
                    var errorMessage = result ? (result.Message || result.message || 'Unknown error') : 'No response from server';
                    handleError('history', null, 'Error loading history: ' + errorMessage);
                }
            } catch (error) {
                handleError('history', null, 'Error loading history: ' + error.message);
            }
        }

        // Function to load filter dropdowns for history
        function loadFilterDropdowns(backPlanID) {
            try {
                var filterParameter = {
                    BackPlanID: backPlanID
                };

                var result = AJAXCallWithResult('api/BackupPlans/GetBackupPlanFilterDropdowns', JSON.stringify(filterParameter), false);

                if (result) {
                    // Handle different response structures
                    var filterData = null;
                    if (result.data && Array.isArray(result.data)) {
                        filterData = result.data;
                    } else if (result.Data && Array.isArray(result.Data)) {
                        filterData = result.Data;
                    } else if (Array.isArray(result)) {
                        filterData = result;
                    } else if (result && typeof result === 'object') {
                        filterData = result;
                    }

                    if (filterData) {
                        populateFilterDropdowns(filterData);
                    }
                }
            } catch (error) {
                // Don't show error notification for dropdowns as it's not critical
            }
        }

        // Function to populate filter dropdowns
        function populateFilterDropdowns(filterData) {
            try {
                // Clear existing options except the first one
                $('#modifiedHisField option:not(:first)').remove();
                $('#modifiedHisBy option:not(:first)').remove();

                // Handle different response structures
                var dataArray = [];
                if (filterData && Array.isArray(filterData)) {
                    // Direct array response
                    dataArray = filterData;
                } else if (filterData && typeof filterData === 'object') {
                    // Check if it's a DataTable response with $values property
                    if (filterData.$values && Array.isArray(filterData.$values)) {
                        dataArray = filterData.$values;
                    } else if (filterData.Rows && Array.isArray(filterData.Rows)) {
                        // Handle DataTable Rows property
                        dataArray = filterData.Rows;
                    } else if (filterData.data && Array.isArray(filterData.data)) {
                        // Handle nested data property
                        dataArray = filterData.data;
                    }
                }


                // Get unique field names and modified by values
                var fieldNames = [];
                var modifiedByValues = [];

                $.each(dataArray, function (index, item) {
                    // Handle different possible field names from the stored procedure (including the typo "mofiedFieldName")
                    var fieldName = item.ModifiedFieldName || item.ModifiedField || item.FieldName || item.Field || item.MofiedFieldName || item.mofiedFieldName;
                    var modifiedBy = item.ModifiedBy || item.ModifiedByUser || item.User || item.modifiedBy;

                    if (fieldName && fieldNames.indexOf(fieldName) === -1) {
                        fieldNames.push(fieldName);
                    }
                    if (modifiedBy && modifiedByValues.indexOf(modifiedBy) === -1) {
                        modifiedByValues.push(modifiedBy);
                    }
                });


                // Sort arrays
                fieldNames.sort();
                modifiedByValues.sort();

                // Populate Modified Field dropdown
                $.each(fieldNames, function (index, fieldName) {
                    $('#modifiedHisField').append('<option value="' + escapeHtml(fieldName) + '">' + escapeHtml(fieldName) + '</option>');
                });

                // Populate Modified By dropdown
                $.each(modifiedByValues, function (index, modifiedBy) {
                    $('#modifiedHisBy').append('<option value="' + escapeHtml(modifiedBy) + '">' + escapeHtml(modifiedBy) + '</option>');
                });

                // Refresh selectpicker dropdowns first
                if (typeof $.fn.selectpicker !== 'undefined') {
                    $('#modifiedHisField').selectpicker('refresh');
                    $('#modifiedHisBy').selectpicker('refresh');
                }

                // Add change event handlers for filtering after refresh
                $('#modifiedHisField, #modifiedHisBy').off('change.historyFilter').on('change.historyFilter', function () {
                    filterHistoryTable();
                });

            } catch (error) {
                // Error handling for filter dropdown population
            }
        }

        // Note: Server-side filtering is now used instead of client-side filtering

        // Function to populate the history table
        function populateHistoryTable(historyData) {
            var tbody = $('#BkPlanShowHisTable tbody');
            tbody.empty();

            try {
                if (historyData && historyData.length > 0) {

                    // Check if DataTable is already initialized
                    var isDataTable = $.fn.dataTable.isDataTable('#BkPlanShowHisTable');

                    if (isDataTable) {
                        // Destroy existing DataTable
                        $('#BkPlanShowHisTable').DataTable().destroy();
                    }

                    // Clear tbody completely after DataTable destruction
                    tbody.empty();

                    // Add rows to tbody
                    $.each(historyData, function (index, record) {
                        if (record) {
                            // Handle both uppercase and lowercase property names
                            var modifiedFieldName = record.ModifiedFieldName || record.modifiedFieldName || '';
                            var oldValue = record.OldValue || record.oldValue || 'N/A';
                            var newValue = record.NewValue || record.newValue || 'N/A';
                            var modifiedDate = record.ModifiedDate || record.modifiedDate;
                            var modifiedBy = record.ModifiedBy || record.modifiedBy || '';

                            var row = '<tr>' +
                                '<td class="col-sm-3">' + escapeHtml(modifiedFieldName) + '</td>' +
                                '<td class="col-sm-2">' + escapeHtml(oldValue) + '</td>' +
                                '<td class="col-sm-2">' + escapeHtml(newValue) + '</td>' +
                                '<td class="col-sm-2">' + formatDateTime(modifiedDate) + '</td>' +
                                '<td class="col-sm-2">' + escapeHtml(modifiedBy) + '</td>' +
                                '</tr>';
                            tbody.append(row);
                        }
                    });


                    // Initialize DataTable after a small delay to ensure DOM is updated
                    setTimeout(function () {
                        if (typeof $.fn.dataTable !== 'undefined') {
                            $('#BkPlanShowHisTable').DataTable({
                                scrollY: true,
                                scrollX: true,
                                paging: false,
                                bLengthChange: false,
                                bFilter: false,
                                ordering: false,
                                responsive: true,
                                destroy: true,
                                retrieve: false,
                                info: false,
                                autoWidth: false,
                                columnDefs: [
                                    { targets: [0, 1, 2, 3, 4], className: 'text-center' }
                                ]
                            });
                        }
                    }, 100);

                } else {
                    // The Show History link will be hidden when there's no data
                }
            } catch (error) {
                handleError('history', null, 'Error displaying history data: ' + error.message);
            }
        }

        // Function to filter history table based on dropdown selections (now uses server-side filtering)
        function filterHistoryTable() {
            try {
                // Show loading state
                var historyTbody = $('#BkPlanShowHisTable tbody');
                historyTbody.html('<tr><td colspan="5" class="text-center py-4"><i class="fas fa-spinner fa-spin"></i> <%=MyBase.GetResourceString("C_Filtering")%></td></tr>');

                // Reload history with current filter selections from server
                loadHistoryWithFilters();

            } catch (error) {
                handleError('history', null, 'Error filtering history: ' + error.message);
            }
        }


        $(".cancelEdtDetpanel").click(function () {
            $("table tr").removeClass("rowhiglight");
            $(".ShowHisDetailpanel").hide();
            // $(".backbtn, .addbtn, .deletebtn, .borderbox, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();
        });


        // Consolidated document ready function
        $(document).ready(function () {
            // DataTables will be initialized when data is loaded in populateBackupPlansTable function

            // Initialize all selectpicker dropdowns
            if (typeof $.fn.selectpicker !== 'undefined') {
                // Initialize project dropdown with custom search behavior
                $('#cboProject').selectpicker({
                    liveSearch: true,
                    liveSearchStyle: 'startsWith'
                });

                // Initialize other selectpickers normally
                $('.selectpicker:not(#cboProject)').selectpicker();

                // Configure letter-wise search for project dropdown
                configureLetterWiseSearch('#cboProject');

                // Set the session project after selectpicker is initialized
                if (BackupPlansConfig.userHasSelectedProject && BackupPlansConfig.userSelectedProjectID) {
                    $('#cboProject').val(BackupPlansConfig.userSelectedProjectID);
                    $('#cboProject').selectpicker('refresh');
                }
            }

            // Setup number field validation for filter field
            setupNumberFieldValidation('#PlanNoCopiesFilter', 'filter');

            // Search functionality is now handled by oninput event in HTML


            // Load filters when page loads
            if (typeof getCurrentProjectID === 'function') {
                var currentProjectID = getCurrentProjectID();
                if (currentProjectID) {
                    // getMyFilters(); // Function not defined - commented out
                    // getDefaultFilter(); // Function not defined - commented out
                }
            }
        });

        // History table will be initialized when data is loaded in populateHistoryTable function
        $(".collapse").on("show.bs.collapse", function (e) {
            $(".table").resize();
            // Re-initialize tooltips when collapse panel is shown
            initializeTooltips();
        });
        $(".collapse").on("hidden.bs.collapse", function (e) {
            $(".table").resize();
            // Re-initialize tooltips when collapse panel is hidden
            initializeTooltips();
        });

        $('a[data-bs-toggle="tab"]').on("shown.bs.tab", function (e) {
            $(".table").resize();
            // Re-initialize tooltips when tab is shown
            initializeTooltips();
        });





        // ===== FILTER MANAGEMENT FUNCTIONS =====
        // Global variables for filter management
        var module = "BackupPlans";
    </script>

    <!-- Delete Backup Plan Confirmation Modal -->
    <div id="deleteBackupPlanModal" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog modalsmall">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%= MyBase.GetResourceString("C_Delete") %></h4>
                </div>

                <div class="modal-body">
                    <span id="DeleteBackupPlanId" style="display: none;"></span>
                    <p align="center"><%= MyBase.GetResourceString("C_DeleteNote") %></p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Cancel") %></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" onclick="confirmDeleteBackupPlan()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Ok") %></button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- Delete Backup Plan Confirmation Modal End -->
    <%Else%>
    <div style="text-align:center;overflow: auto;width: 100%;margin-top:3%;"><p style="margin-top:6%;"><center><%=MyBase.GetResourceString("A_NotAuthorizedToViewRecord")%></center></p></div>
    <%End If%>
</body>
</html>