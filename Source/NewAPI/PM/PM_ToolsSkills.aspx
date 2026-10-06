<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ToolsSkills.aspx.vb" Inherits="Whizible.PM_ToolsSkills" %>

<!DOCTYPE html>
<html>
 <%CommonFunctions.General.PlotPageHeadTag("Non-People Resources")%>
<head>
    <%--
    Modified By : Vaibhav K 
    Date: 11-02-26
        --%>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Non-People Resources</title>

    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css" />--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css" />--%>

    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.min.css?v=2">--%>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=3">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.2">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>




    <style type="text/css">

          #AdvanceFilterIconClicked {
            background-color: #1359a6;
            color: white;
          }

        .filterpanel .radiotextsty {
            width: 170px;
        }
        .disabled-link {
             pointer-events: none;
             cursor: default;
             opacity: 0.5;
        }

        .ui-datepicker {
            width: 20em;
        }
        .filterpanel .issuefilter_container .filterpanelbody {
            padding: 30px 25px;
            max-height: none;
        }
            .borderbtn {
            background: #fff;
            border-color: #1359a6;
            color: #1359a6;
            font-weight: 500;
        }
        .tbl-tool-skill {
            table-layout: fixed;
        }
        .bg-tbl-head {
            background-color: #f1f5f8;
        }
        a.filter-wrap {
            padding: 5px 8px;
            margin-left: 5px;
            background: #1359ac;
            color: #fff;
            border-radius: 4px;
        }

            a.filter-wrap.collapsed {
                background: none;
                color: #464ac4;
            }
            button[data-id="txtFilter_usage"] {
    color: #999;
}
                        button[data-id="txtFilter_usage2"] {
    color: #999;
}
        button[data-id="toolUsageAdd"] {
            color: #999;
        }
        button[data-id="toolUsage"] {
    color: #999;
}
                        button[data-id="skillUsage"] {
    color: #999;
}
                        button[data-id="skillUsageAdd"] {
    color: #999;
}
            a.filter-wrap.active {
                border-radius: 3px;
                background-color: #1359a6;
                color: #fff;
                transition: 0.8s;
            }

        .filterpanel .filterpanelheader {
            background: #fafafa;
            border-bottom: 1px solid #eee;
        }
        .filterpanelwrapbasicfilter {
            background: #fafafa;
        }

        .filterpanelplnReview .cust_tabpanel .MyFiltersdropdown {
            z-index: 999;
        }

        .filterpanelplnReviewCR .cust_tabpanel .MyFiltersdropdown {
            z-index: 999;
        }

        .filter button[aria-expanded="true"] {
            background: NONE;
            color: #464a4c;
            padding: 4px 6px;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            border-radius: 4px;
        }

  
        .stackbasicfilter .form-inline .form-control {
            max-width: 165px;
        }

        a.clearalllink {
            font-weight: bold;
            padding-top: 2px;
        }

        .stackbasicfilter .box label {
            width: 160px;
            text-align: right;
            margin-right: 10px;
            display: inline-block;
        }

        .dashmain .box {
            border: none;
            background-color: #fff;
        }



        .stackbasicfilter .form-inline .form-control {
            width: auto;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            height: 28px;
            padding: 3px 12px;
            border-radius: 4px;
            margin-right: 2px;
        }
        .stackbasicfilter textarea {
            min-height: 60px !important;
            height: auto !important;
        }

        .stackbasicfilter .box .form-group {
            margin-bottom: 8px;
        }

        /* ── Checkbox appearance — matches My_Leaves native style ── */
        .chckHead,
        .chcktbl,
        .chckHead1,
        .chcksite,
        .mainchck,
        .main_Skills,
        .custom_chckbox input[type="checkbox"] {
            -webkit-appearance: auto !important;
            -moz-appearance: auto !important;
            appearance: auto !important;
            opacity: 1 !important;
            position: static !important;
            display: inline-block !important;
            width: 14px !important;
            height: 14px !important;
            min-width: 14px !important;
            cursor: pointer !important;
            vertical-align: middle;
            accent-color: #486AC0;
        }

        /* Remove pseudo-element fake box — native checkbox is now visible */
        .custom_chckbox input[type="checkbox"] + label:before,
        .custom_chckbox input[type="checkbox"] + label:after {
            display: none !important;
            content: none !important;
        }

        /* Keep label in flow but collapse it — click area stays on the input */
        .custom_chckbox input[type="checkbox"] + label {
            display: inline-block !important;
            margin: 2px !important;
            padding: 2px !important;
        }

        /* Center checkbox in its table cell */
        .custom_chckbox {
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
        }

        .filter-wrap.active + .filterpanelwrapbasicfilter {
            display: block;
        }

        .stackbasicfilter .box .custom_chckbox label {
            text-align: left;
            width: 15px;
        }


        .ui-widget.ui-widget-content {
            z-index: 9999 !important;
        }
        .tbl-tool-skill tr th:last-child, .tbl-tool-skill tr td:last-child {
            text-align: center !important;
        }
     
        td.bg-tbl-head.text-start {
            font-weight: bold;
        }

        .accordion-toggle {
            cursor: pointer;
        }

        .collapsicon {
            margin-right: 8px;
        }

        .tooltip {
            z-index: 9999 !important;
        }

        .dropdown-menu {
            -webkit-box-shadow: 0 6px 12px rgba(0,0,0,.175);
            box-shadow: 0 6px 12px rgba(0,0,0,.175);
        }
        label{
            font-weight:500;
        }
        .offcanvas {
            width: 85% !important;
        }
        .completiontbl tr td:first-child {
            text-align: center;
        }
        .available_icon {
            color: #009f06;
            font-size: 16px;
            font-weight: 600;
        }
        .not_available_icon {
            color: #f10c0ce8;
            font-size: 16px;
            font-weight: 600;
        }
/*
        .page-icon {
    font-size: 26px;
    color: #2b6cb0;
}*/
.page-icon {
    font-size: 26px;
    color: #2b6cb0;
}

body {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;
        }
        .form-control, .btn, a, p, input, select.form-select {
    /* Modified By Madhuri.K On 26-03-2026 */
    font-size: 11.5px !important;
}
        /* Pagination - match Releases/Lessons Learnt (Total Records + Prev/Next) */
        #tools_tbl_wrapper .dataTables_paginate,
        #tools_tbl_wrapper .dataTables_info,
        #skills_tbl_wrapper .dataTables_paginate,
        #skills_tbl_wrapper .dataTables_info,
        #Tools_Show_History_Tbl_wrapper .dataTables_paginate,
        #Tools_Show_History_Tbl_wrapper .dataTables_info,
        #Skills_Show_History_Tbl_wrapper .dataTables_paginate,
        #Skills_Show_History_Tbl_wrapper .dataTables_info,
        #tools_selectio_Tbl_wrapper .dataTables_paginate,
        #tools_selectio_Tbl_wrapper .dataTables_info,
        #skill_selectio_Tbl_wrapper .dataTables_paginate,
        #skill_selectio_Tbl_wrapper .dataTables_info {
            display: none !important;
        }
        .pagination-container {
            background: white;
            display: flex !important;
            justify-content: flex-end;
            align-items: center;
            padding: 1rem;
            gap: 1rem;
            margin-top: 0;
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 1000;
        }
        .pagination-container .btn-page {
            background: white;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
            padding: 0.5rem 0.75rem;
            color: #3b82f6;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 40px;
        }
        .pagination-container .btn-page:disabled {
            background: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
            opacity: 0.5;
        }
        body.tools-skills-pagination {
            padding-bottom: 80px;
        }
        /* Inline pagination (History + Modal) - same look, flows below table */
        .pagination-container-inline {
            background: white;
            display: flex !important;
            justify-content: flex-end;
            align-items: center;
            padding: 1rem;
            gap: 1rem;
            margin-top: 0;
            margin-bottom: 0.5rem;
        }
        .pagination-container-inline .btn-page {
            background: white;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
            padding: 0.5rem 0.75rem;
            color: #3b82f6;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 40px;
        }
        .pagination-container-inline .btn-page:disabled {
            background: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
            opacity: 0.5;
        }
        .custmodal .modal-content .modal-header {
  
    text-align: center;
    justify-content: center;
}

        /* Modal selection tables — fixed layout, narrow Select column */
        #tools_selectio_Tbl,
        #skill_selectio_Tbl {
            table-layout: fixed !important;
            width: 100% !important;
        }
        #tools_selectio_Tbl th:first-child,
        #tools_selectio_Tbl td:first-child,
        #skill_selectio_Tbl th:first-child,
        #skill_selectio_Tbl td:first-child {
            width: 78% !important;
            text-align: left !important;
            word-break: break-word;
        }
        #tools_selectio_Tbl th:last-child,
        #tools_selectio_Tbl td:last-child,
        #skill_selectio_Tbl th:last-child,
        #skill_selectio_Tbl td:last-child {
            width: 22% !important;
            text-align: center !important;
        }



        /* Offcanvas header × close button */
        .offcanvas-title-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
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

    
        /* Black tooltip — matches PM_ProjectSites page style */
        .black-tooltip .tooltip-inner {
            background-color: #000;
            color: #fff;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            padding: 6px 10px;
        }
        .black-tooltip .tooltip-arrow::before {
            border-top-color: #000;
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
<body class="hold-transition bgwhite sidebar-mini dashmain fixed">
<!-- Page Loader — matches PM_ReportUIBuilder style -->
<div class="loader-overlay" id="pageLoader" style="display: none;">
    <div class="loader"></div>
</div>

   <%If m_blnViewAccess = True Then%>
    <div class=" bgwhite">
        <div class="graybg container-fluid py-1 mb-2 statckmainheader" style="margin-top:10px">
            <div class="row ">

                <div class="col-sm-6">
    <div style="padding-left: 0; margin-left: 0;">
        <%-- Added By Dipali V On 5th Jun 2026 — Back to Bulk Allocation; visible only when opened from PM_BulkResAllocation.aspx (fromBulkAlloc=1) --%>
        <button type="button" id="btnBackToBulkAlloc" class="btn borderbtn mb-2" style="display: none;"
            onclick="backToBulkAllocation()">
            <i class="fas fa-arrow-left me-1"></i><%=MyBase.GetResourceString("C_Back")%>
        </button>
        <h2 style="color: #1e40af; font-weight: 600; font-size: 18px; margin: 0 0 0.25rem 0; display: flex; align-items: center;">
            <i class="fas fa-cogs" style="color: #1e40af; font-size: 1.5rem; margin-right: 0.75rem;"></i>
            <%=MyBase.GetResourceString("C_PageName")%>
        </h2>
        <p style="color: #6b7280; font-size: 0.7rem; margin: 0;">
           
             <%=MyBase.GetResourceString("C_SubPageName")%>
        </p>
    </div>
</div>


                <div class="col-sm-6 d-flex justify-content-end form-inline text-end pt-0">
                    <a href="javascript:;" class="clearalllink pe-3" id="ProjectClearAllFilter" data-bs-toggle="tooltip" title="Clear All" onclick="clearAllFilters()" style="color: #1359a6; text-decoration: none; font-size: 11.5px; margin-right: 0; display: none;"><strong><%=MyBase.GetResourceString("C_ClearAll")%></strong></a>
                    <span data-bs-toggle="tooltip" title="Filter">
                        <button data-bs-toggle="collapse" data-bs-target="#filterpanel" id="AdvanceFilterIcon" autocomplete="off" class="" aria-expanded="false" onclick="checkActiveTab()" style="background: none; border: none; color: #374151; font-size: 11.5px; cursor: pointer; padding: 0.5rem;">
                            <i class="fas fa-filter"></i>
                        </button>
                    </span>
                </div>
                </div>
            </div>
        </div>
        <div class="row  pt-1 pb-1 mx-1 ">
            <div class="col-sm-4 d-flex">
                <%--<label for="ddl_Projects" class="me-2 mb-0 fw-bold" style="white-space: nowrap;">Select Project</label>--%>
                <label for="cboProject" style="color: #374151; font-size: 11.5px; font-weight: 500; margin: 0; margin-right: 0.5rem; white-space: nowrap;">Select Project</label>
                <%-- //Added by Aditya J. on 19-08-2026 for showing closed project also in the project dropdown --%>
                <%-- <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_Projects", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "onchange='GetProjectSkillORToolDetails();' class='selectpicker' data-live-search='true' data-width='260px'",,,) %> --%>
                <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_Projects", "usp_Whizible2_Sel_AccessibleProjects_WithSelected " & Session("intUserID") & ",'" & Session("LoginType") & "',1,0,'[Over] = ''0''','ProjectName ASC'," & IIf(String.IsNullOrEmpty(Convert.ToString(Session("intProjectID"))) OrElse Convert.ToString(Session("intProjectID")) = "0", "NULL", Session("intProjectID")),,, "onchange='GetProjectSkillORToolDetails();' class='selectpicker' data-live-search='true' data-width='260px'",,,) %>
                <%-- //End of Added by Aditya J. on 19-08-2026 for showing closed project also in the project dropdown --%>

            </div>
        </div>
                <!--filter_panel_section_satrts_here-->
                <div id="filterpanel" class="collapse filterpanel filterpanelML">
                    <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                        <div class="row">
                            <div class="col-md-7 col-sm-7">
                                <div class="cust_tabpanel">
                                    <ul class="nav nav-tabs">
                                   
                                        <li>
                                            <a href="#tools_skills_filter" data-bs-toggle="tab" onclick="setDefaultFilterFields()"> <%=MyBase.GetResourceString("C_BasicFilters")%></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-5 col-sm-5">
                                <div class="form-inline float-end">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="issuefilter_container">
                        <div class="tab-content issuefilter_tabcontent">
                            <div id="tools_skills_filter" class="tab-pane stackbasicfilter">
                                <!--filter panel start here-->
                                <div class="filterpanelwrapbasicfilter">
                                    <div class="filterpanelbody" id="accordion">
                                        <div class="fp_button text-center hidden-xs centerbtn" style="margin:0 0 40px;">
                                            
                                            <%--<button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-target="#Issuesavefilter" data-bs-dismiss="modal"> <%=MyBase.GetResourceString("C_SaveAndApply")%></button>--%>
                                           
                                            
                                            <button class="btn btnyellow" id="filterApply" onclick="applyProjectToolOrSkillFilter()"><%=MyBase.GetResourceString("C_Apply")%></button>
                                        </div>
                                        <div class="row hidden-xs IB_filterlist">
                                            <!--basic filter conduct review start here-->
                                            <div class="row form-group mb-2">
                                                <div class="col-sm-6">
                                                    <div class="row form-group">
                                                        <div class="col-sm-12">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label class="lb_filter_usage" for="txtFilter_usage"><%=MyBase.GetResourceString("C_Usage")%></label>
                                                                </div>
                                                                <div class="col-sm-8">
                                                                    <%--<%=CommonFunctions.HTMLControls.DrawComboBox("txtFilter_usage", "usp_Whizible2_Sel_tbl_PM_ToolParameters ",,, "class='form-select'",,,) %>--%>
                                        <%=CommonFunctions.HTMLControls.DrawComboBox("txtFilter_usage", "usp_Whizible2_Sel_tbl_PM_ToolParameters ",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                                
                                                                </div>




                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row form-group">
                                                        <div class="col-sm-12">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label class="lb_filter_version" for="txt_filter_version"><%=MyBase.GetResourceString("C_Version")%></label>
                                                                </div>
                                                                <div class="col-sm-8">
                                                                    <%CommonFunctions.HTMLControls.DrawTextBox("text", "txt_filter_version", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=50 ",,,,,,, True) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
        
                                            </div>
        
                                            <div class="row form-group mb-2">
                                                <div class="col-sm-6">
                                                    <div class="row form-group">
                                                        <div class="col-sm-12">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label for="txt_filter_util"><%=MyBase.GetResourceString("C_Utilization")%></label>
                                                                </div>
                                                                <div class="col-sm-8">
                                                                    <%CommonFunctions.HTMLControls.DrawTextBox("text", "txt_filter_util", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=5 ",,,,,,, True) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row form-group">
                                                        <div class="col-sm-12">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label for="supplied_cust"><%=MyBase.GetResourceString("C_IsSuppByCustomer")%></label>
                                                                </div>
                                                                <div class="col-sm-8 mt-2">
                                                                    <select class="selectpicker form-control" data-live-search="true" id="supplied_cust_filter" data-none-selected-text="">
                                                                        <option value="">Select</option>
                                                                        <option value="1">Yes</option>
                                                                        <option value="0">No</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
        
                                            </div>
                                            <div class="row form-group mb-2">
                                                <div class="col-sm-6">
                                                    <div class="row form-group">
                                                        <div class="col-sm-12">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label for="filter_critical"><%=MyBase.GetResourceString("C_IsCritical")%></label>
                                                                </div>
                                                                <div class="col-sm-8 mt-2">
                                                                    <select class="selectpicker form-control" data-live-search="true" id="filter_critical" data-none-selected-text="">
                                                                        <option value="">Select</option>
                                                                        <option value="1">Yes</option>
                                                                        <option value="0">No</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row form-group">
                                                        <div class="col-sm-12">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label for="filter_procured"><%=MyBase.GetResourceString("C_IsProcured")%></label>
                                                                </div>
                                                                <div class="col-sm-8 mt-2">
                                                                    <select class="selectpicker form-control" data-live-search="true" id="filter_procured" data-none-selected-text="">
                                                                        <option value="">Select</option>
                                                                        <option value="1">Yes</option>
                                                                        <option value="0">No</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row form-group mb-2">
                                                <div class="col-sm-6">
                                                    <div class="row form-group">
                                                        <div class="col-sm-12">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label for="txt_desc"><%=MyBase.GetResourceString("C_BriefDescription")%></label>
                                                                </div>
                                                                <div class="col-sm-8 mt-2">
                                                                    <textarea class="form-control" id="txt_desc"></textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row form-group">
                                                        <div class="col-sm-12">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label for="txt_copies"><%=MyBase.GetResourceString("C_NumberOfCopies")%></label>
                                                                </div>
                                                                <div class="col-sm-8 mt-2">
                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("text", "txt_copies", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=4 ",,,,,,, True) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
        
                                            </div>
        
                                            <div class="row form-group mb-2">
        
                                                <div class="col-sm-6">
                                                    <div class="row form-group">
                                                        <div class="col-sm-12">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label for="Planned_indate"><%=MyBase.GetResourceString("C_PlannedInDate")%></label>
                                                                </div>
                                                                <div class="col-sm-8 mt-2">
                                                                    <div class="input-group datefielddiv">
                                                                        <%CommonFunctions.HTMLControls.DrawTextBox("date", "Planned_indate", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                                                        <span class="input-group-btn">
                                                                            <button class="btn btncalendar" type="button">
                                                                                <i class="fas fa-calendar-alt"></i>
                                                                            </button>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row form-group">
                                                        <div class="col-sm-12">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label for="Planned_out_date"><%=MyBase.GetResourceString("C_PlannedOutDate")%></label>
                                                                </div>
                                                                <div class="col-sm-8 mt-2">
                                                                    <div class="input-group datefielddiv">
                                                                        <%CommonFunctions.HTMLControls.DrawTextBox("date", "Planned_out_date", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                                                        <span class="input-group-btn">
                                                                            <button class="btn btncalendar" type="button">
                                                                                <i class="fas fa-calendar-alt"></i>
                                                                            </button>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row form-group mb-2">
        
                                                <div class="col-sm-6">
                                                    <div class="row form-group">
                                                        <div class="col-sm-12">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label for="txt_filter_status"><%=MyBase.GetResourceString("C_Status")%></label>
                                                                </div>
                                                                <div class="col-sm-8 mt-2">
                                                                    <select class="selectpicker form-control" data-live-search="true" id="txt_filter_status">
                                                                        <option value="">Select Status</option>
                                                                        <option value="Available" data-content="<span class='far fa-check-circle mx-1 mt-1 available_icon'></span> Available"></option>
                                                                        <option value="Not Available" data-content="<span class='fas fa-times-circle mx-1 mt-1 not_available_icon'></span>Not Available"></option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%--<div class="col-sm-6">
                                                    <div class="row form-group">
                                                        <div class="col-sm-12">
                                                            <div class="row form-group">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label for="filter_projectname"><%=MyBase.GetResourceString("C_ProjectName")%> :</label>
                                                                </div>
                                                                <div class="col-sm-8 mt-2">
                                                                    <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_Projects_filter", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "class='form-select'",,,) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>--%>
        
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
        
                                </div>
                            </div>
        
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>

                    </div>
        <div class="row graybg ">
            <div class=" col-sm-6 pt-2 pb-2">
                <ul class="nav nav-tabs main_graybgtbs" id="Tools_skills_Tabs" style="pointer-events: auto;">
                    <li class="nav-item"><a class="nav-link active" href="#Tab_Tools_trend" rol="tab" data-bs-toggle="tab" id=""><span><i class="fas fa-wrench"></i></span>&nbsp; Tools</a></li>
                    <li class="nav-item"><a class="nav-link" href="#Tab_skills_trend" rol="tab" data-bs-toggle="tab" id=""><span><i class="fas fa-certificate"></i></span>&nbsp; Skills</a></li>
                </ul>
            </div>
         
        </div>

        <div class="tab-content mt-2">
            <div id="Tab_Tools_trend" class="tab-pane active">

                <div class="row  pb-1 mx-1 ">
                    <div class="col-sm-3">
                    </div>
                    <div class="col-sm-9">
                        <div class="pstbl_Tools pt-0  active" id="pstbl_Tools">
                            <div class="float-end" style="margin-top:3px;">
                                <%If m_blnAddAccess = True Then%>
                                <a class="btn borderbtn mr-5" id="addTool" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_ToolsAdd"
                                   aria-controls="offcanvas_Tools" onclick="resetToolDetails()"><i class="fa fa-plus" aria-hidden="true"></i> <%=MyBase.GetResourceString("C_Add")%></a>
                                <%End If %>
                                 <%If m_blnDeleteAccess = True Then%>
                                <a id="delete_row" class="btn borderbtn" onclick="showDelModalHardware()"><%=MyBase.GetResourceString("C_Delete")%></a>
                                <%End If %>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>

                </div>
                <div class="container-fluid">
                    <table class="table table-bordered tbl-keywords" id="tools_tbl" style="width:100%;">
                        <thead>
                            <tr>
                                <th class="col-sm-3"><%=MyBase.GetResourceString("C_Tools")%></th>
                                <th class="col-sm-1"><%=MyBase.GetResourceString("C_Version")%></th>
                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_Usage")%></th>
                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_Status")%></th>
                                <th class="col-sm-1"><%=MyBase.GetResourceString("C_Utilization")%></th>
           
                                <th class="sm-wid col-sm-1">
                                    <div class="custom_chckbox">
                                        <input id="toolsSltAll" class="chckHead" type="checkbox">
                                        <label for="toolsSltAll"></label>
                                    </div>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                         
                        </tbody>
                    </table>
                    <div class="pagination-container" id="tools_pagination_container" style="display: none;">
                        <div style="color: #374151; font-size: 11.5px;">
                            <span id="toolsTotalRecords">Total Records: 0</span>
                        </div>
                        <div style="display: flex; gap: 0.5rem;">
                            <button type="button" id="toolsFirstPageBtn" class="btn-page" title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
                            <button type="button" id="toolsLastPageBtn" class="btn-page" title="Next Page"><i class="fas fa-angle-double-right"></i></button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="Tab_skills_trend" class="tab-pane ">

                <div class="row  pb-1 mx-1 ">
                    <div class="col-sm-3">
                    </div>
                    <div class="col-sm-9">
                        <div class="pstbl_skills pt-0 " id="pstbl_skills">
                            <div class="float-end" style="margin-top:3px;">
                                 <%If m_blnAddAccess = True Then%>
                                <a class="btn borderbtn mr-5" id="addTool2" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_SkillsAdd"
                                   aria-controls="offcanvas_SkillsAdd" onclick="resetSkillDetails()"><i class="fa fa-plus" aria-hidden="true"></i> <%=MyBase.GetResourceString("C_Add")%></a>
                                <%End If %>
                                <%If m_blnDeleteAccess = True Then%>
                                <a id="delete_skill_row" class="btn borderbtn" onclick="showDelModalSkill()"><%=MyBase.GetResourceString("C_Delete")%></a>
                                <%End If %>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>

                </div>
                <div class="container-fluid">
                    <table class="table table-bordered tbl-keywords " id="skills_tbl" style="width:100%;">
                        <thead>
                            <tr>
                                <th class="col-sm-3"><%=MyBase.GetResourceString("C_Skills")%></th>
                                <th class="col-sm-1"><%=MyBase.GetResourceString("C_Version")%></th>
                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_Usage")%></th>
                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_Status")%></th>
                                <th class="col-sm-1"><%=MyBase.GetResourceString("C_Utilization")%></th>
                                <th class="sm-wid col-sm-1">
                                    <div class="custom_chckbox">
                                        <input id="Skills_checkAll" class="chckHead" type="checkbox">
                                        <label for="Skills_checkAll"></label>
                                    </div>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                    <div class="pagination-container" id="skills_pagination_container" style="display: none;">
                        <div style="color: #374151; font-size: 11.5px;">
                            <span id="skillsTotalRecords">Total Records: 0</span>
                        </div>
                        <div style="display: flex; gap: 0.5rem;">
                            <button type="button" id="skillsFirstPageBtn" class="btn-page" title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
                            <button type="button" id="skillsLastPageBtn" class="btn-page" title="Next Page"><i class="fas fa-angle-double-right"></i></button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <!--tab end here-->

        <!--Tools offcanvas Section Start Here-->
        <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1"
             id="offcanvas_Tools" aria-labelledby="offcanvas_Tools">
            <div class="offcanvas-body">
                <div id="NOI_Details_Sec" class="NOI_Details">
                    <div class="NOI_Details_Header d-flex justify-content-between">
                        <div class="Overlay-title"></div>
                        <div class="NOI_HeaderBtns">
                        </div>
                    </div>
                    <div class="graybg container-fluid  py-1 mb-2 statckmainheader">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="offcanvas-title-row">
                                    <h5 class="pgtitle mb-0"><%=MyBase.GetResourceString("C_Tools")%></h5>
                                    <button type="button" class="offcanvas-close-btn" onclick="closeNOIDetails()" data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Close">&#x2715;</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-2 mb-2 project_timeperiod">
                        <div class="col-sm-12 ">
                            <div class="row">
                                <div class="col-sm-8">
                                </div>
                                <div class="col-sm-4 text-end">
                                    <%If m_blnEditAccess = True Then%>
                                    <a href="javascript:;" class="btn btnyellow " id="Sv_tools_info"
                                       data-bs-toggle="tooltip" data-bs-container="body"
                                       data-bs-placement="top" title="Save" onclick="saveToolData()"><%=MyBase.GetResourceString("C_Save")%></a>
                                    <%End If %>
                                    <a href="javascript:;" class="btn borderbtn " id="Show_history_tools_info"
                                       data-bs-toggle="tooltip" data-bs-container="body"
                                       data-bs-placement="top" title="Show History" onclick="NextResdetailTool();"><%=MyBase.GetResourceString("C_ShowHistory")%></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="NOI_Details_content">
                        <div class="tab-content detailsmenutab">
                            <div class="tab-pane active" id="Basic_tools_DetailsTab">
                                <div class="BasicDetailsContent">
                                    <div class="row">
                                        <div class="col-sm-12 text-end">
                                            <label class="form-label ">(<font color="red">*</font> <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 form-group">
                                        <div class="row mt-1 mb-2">

                                            <div class="col-sm-4 mt-1 text-start">
                                                <label class="control-label required"><%=MyBase.GetResourceString("C_Tool")%></label>
                                                <div class="row ">
                                                    <div class="col-sm-10 pr-0">
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("text", "toolDescription", "form-control", , ,,,,,,,, " autocomplete='off' disabled=true",,,,,,, True) %>
                                                    </div>
                                                    <div class="col-sm-1 mt-1">
                                                        <a href="javascript:;" data-bs-toggle="modal"
                                                           data-bs-target="#Tools_Selection_modal" onclick="fillAvailableToolsForProjectToDropdown()" class="disabled-link">
                                                            <span data-bs-toggle="tooltip" data-bs-placement="top" title="Select Tools">
                                                                <i class="fa fa-link" aria-hidden="true"
                                                                   style=" margin: 5px -17px 0;"></i>
                                                            </span>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <label class="required"><%=MyBase.GetResourceString("C_Usage")%></label>
                                                <%=CommonFunctions.HTMLControls.DrawComboBox("toolUsage", "usp_Whizible2_Sel_tbl_PM_ToolParameters ",,, "class='selectpicker' data-live-search='true'",,,) %>
                                            </div>
                                            <div class="col-sm-4">
                                                <label><%=MyBase.GetResourceString("C_Version")%></label>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("text", "toolVersion", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=5 ",,,,,,, True) %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 form-group">
                                        <div class="row mb-2">

                                            <div class="col-sm-4">
                                                <label><%=MyBase.GetResourceString("C_Utilization")%></label>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("text", "toolPercentageUtilization", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=5 ",,,,,,, True) %>
                                            </div>
                                            <div class="col-sm-4">
                                                <label><%=MyBase.GetResourceString("C_Status")%></label>
                                                <select class="selectpicker form-control" data-live-search="true" id="toolStatus">
                                                    <option value="">Select Status</option>
                                                    <option value="Available" data-content="<span class='far fa-check-circle mx-1 mt-1 available_icon'></span> Available"></option>
                                                    <option value="Not Available" data-content="<span class='fas fa-times-circle mx-1 mt-1 not_available_icon'></span>Not Available"></option>
                                                </select>
                                            </div>
                                            <div class="col-sm-4">
                                                <label><%=MyBase.GetResourceString("C_NumberOfCopies")%></label>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("text", "toolNumberOfCopies", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=4 ",,,,,,, True) %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 form-group">
                                        <div class="row mb-2">
                                            <div class="col-sm-4">
                                                <label>&nbsp;</label>
                                                <div class="custom_chckbox">
                                                    <input class="chckHead" type="checkbox" id="toolIsCustomerSupplied">
                                                    <label for="toolIsCustomerSupplied"><%=MyBase.GetResourceString("C_IsSuppByCustomer")%></label>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <label>&nbsp;</label>
                                                <div class="custom_chckbox">
                                                    <input class="chckHead" type="checkbox" id="toolIsCritical">
                                                    <label for="toolIsCritical"><%=MyBase.GetResourceString("C_IsCritical")%></label>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <label>&nbsp;</label>
                                                <div class="custom_chckbox">
                                                    <input class="chckHead" type="checkbox" id="toolIsProcured">
                                                    <label for="toolIsProcured"><%=MyBase.GetResourceString("C_IsProcured")%></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-12 form-group">
                                        <div class="row mb-2">
                                            <div class="col-sm-4">
                                                <label><%=MyBase.GetResourceString("C_PlannedInDate")%></label>
                                                <div class="input-group datefielddiv">
                                                    <%CommonFunctions.HTMLControls.DrawTextBox("date", "plannedDateModalForTool", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                                    <span class="input-group-btn">
                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <label><%=MyBase.GetResourceString("C_PlannedOutDate")%></label>
                                                <div class="input-group datefielddiv">
                                                     <%CommonFunctions.HTMLControls.DrawTextBox("date", "plannedOutDateModalForTool", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                                    <span class="input-group-btn">
                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                    </span>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                    <div class="col-sm-12 form-group">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <label><%=MyBase.GetResourceString("C_BriefDescription")%></label>
                                                <%CommonFunctions.HTMLControls.DrawTextArea("text", "toolBriefDescription", "", "form-control", , , , , , , 2000, , , , , , , , "maxlength='500' ondrag= 'return false'; ondrop='return false;'", , , , , , , , , , True)%> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>

                                </div>
                            </div>
                        </div>

                        <div class="Resourcedetailpanel">
                            <div class="pgdetailinner p-0">
                                <ul class="nav nav-tabs detailsubtabs">
                                    <li class="nav-item">
                                        <a class="nav-link active" href="#toolsdetails_history_Tab" data-bs-toggle="tab"
                                           id=""><span class="active_tab"> <%=MyBase.GetResourceString("C_History")%></span></a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div id="toolsdetails_history_Tab" class="tab-pane active pt-0">
                                        <div class="ResAllctnContent AllocateResourceSec">
                                            <div class="row mx-2">
                                                <div class="col-sm-6">
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="nextBtnDiv d-flex justify-content-end gap-2 mt-2">
                                                        <a href="javascript:;" class="btn borderbtn canceldetailpanel"
                                                           id="toolCancelBtn"><%=MyBase.GetResourceString("C_Cancel")%></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                            <div class="container-fluid">
                                                <div class="row mx-2 mt-2 ">
                                                    <div class="col-sm-6">
                                                        <div class="row form-group">
                                                            <div class="col-sm-4 d-flex justify-content-end">
                                                                <label for="tools_modifiedHisField"><%=MyBase.GetResourceString("C_ModifiedField")%> : </label>
                                                            </div>
                                                            <div class="col-sm-8">
                                                                <select class="selectpicker" data-live-search="true" id="modifiedHisFieldTool">
                                                                   
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="row form-group">
                                                            <div class="col-sm-4 d-flex justify-content-end">
                                                                <label for="tools_modifiedHisBy"><%=MyBase.GetResourceString("C_ModifiedBy")%> : </label>
                                                            </div>
                                                            <div class="col-sm-8">
                                                                <select class="selectpicker" data-live-search="true" id="modifiedHisByTool">
                                                                   
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                               </div> 
                                                <div class="clearfix"></div>
                                                <div class="container-fluid">
                                                    <table class="table table-stripped table-bordered mt-2 mb-2" id="Tools_Show_History_Tbl" width="100%">
                                                        <thead>
                                                             <tr>
                                                                 <th><%=MyBase.GetResourceString("C_ModifiedField")%></th>
                                                                 <th><%=MyBase.GetResourceString("C_ModifiedDate")%></th>
                                                                 <%--<th><%=MyBase.GetResourceString("C_Value")%></th>--%>
                                                                 <th><%=MyBase.GetResourceString("C_OldValue")%></th>
                                                                   <th><%=MyBase.GetResourceString("C_NewValue")%></th>

                                                                 <th><%=MyBase.GetResourceString("C_ModifiedBy")%></th>
                                                             </tr>
                                                        </thead>
                                                        <tbody>
                                                           
                                                        </tbody>
                                                    </table>
                                                    <div class="pagination-container-inline" id="tools_history_pagination">
                                                        <div style="color: #374151; font-size: 11.5px;"><span id="toolsHistoryTotalRecords">Total Records: 0</span></div>
                                                        <div style="display: flex; gap: 0.5rem;">
                                                            <button type="button" id="toolsHistoryFirstPageBtn" class="btn-page" title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
                                                            <button type="button" id="toolsHistoryLastPageBtn" class="btn-page" title="Next Page"><i class="fas fa-angle-double-right"></i></button>
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
        </div>
        </div>  
        <!--Tools Skills offcanvas Section End Here-->

        <!--Skills offcanvas Section Start Here-->
        <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1"
             id="offcanvas_Skills" aria-labelledby="offcanvas_Skills">
            <div class="offcanvas-body">
                <div id="Skills_Details" class="NOI_Details">
                    <div class="NOI_Details_Header d-flex justify-content-between">
                        <div class="Overlay-title"></div>
                        <div class="NOI_HeaderBtns">
                        </div>
                    </div>
                    <div class="graybg container-fluid py-1 mb-2 statckmainheader">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="offcanvas-title-row">
                                    <h5 class="pgtitle mb-0"><%=MyBase.GetResourceString("C_Skills")%></h5>
                                    <button type="button" class="offcanvas-close-btn" onclick="closeNOIDetails()" data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Close">&#x2715;</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-2 mb-2 project_timeperiod">
                        <div class="col-sm-12 ">
                            <div class="row">
                                <div class="col-sm-8">
                                </div>
                                <div class="col-sm-4 text-end">
                                    <%If m_blnEditAccess = True Then%>
                                    <a href="javascript:;" class="btn btnyellow " id="Sv_Skills_info" data-bs-toggle="tooltip" data-bs-container="body"
                                       data-bs-placement="top" title="Save" onclick="saveSkillData()"><%=MyBase.GetResourceString("C_Save")%></a>
                                     <%End If %>
                                    <a href="javascript:;" class="btn borderbtn " id="Show_history_Skills_info"
                                       data-bs-toggle="tooltip" data-bs-container="body"
                                       data-bs-placement="top" title="Show History" onclick="NextResdetailSkill();"><%=MyBase.GetResourceString("C_ShowHistory")%></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="NOI_Details_content">
                        <div class="tab-content detailsmenutab">
                            <div class="tab-pane active" id="Basic_Skills_DetailsTab">
                                <div class="BasicDetailsContent">
                                    <div class="row">
                                        <div class="col-sm-12 text-end">
                                            <label class="form-label ">(<font color="red">*</font> <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 form-group">
                                        <div class="row mt-1 mb-3">
                                            <div class="col-sm-4 mt-1 text-start">
                                                <label class="control-label required"><%=MyBase.GetResourceString("C_Skills")%></label>
                                                <div class="row ">
                                                    <div class="col-sm-10 pr-0">
                                                        <%CommonFunctions.HTMLControls.DrawTextBox("text", "skillDescription", "form-control", , ,,,,,,,, " autocomplete='off' disabled=true",,,,,,, True) %>
                                                    </div>
                                                    <div class="col-sm-1 mt-1">
                                                        <a href="javascript:;" data-bs-toggle="modal"
                                                           data-bs-target="#Skills_Selection_modal" class="disabled-link">
                                                            <span data-bs-toggle="tooltip" data-bs-placement="top" title="Select Skills" onclick="fillAvailableSkillsForProjectToDropdown()">
                                                                <i class="fa fa-link" aria-hidden="true"
                                                                   style=" margin: 5px -17px 0;"></i>
                                                            </span>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <label class="required"><%=MyBase.GetResourceString("C_Usage")%></label>
                                               <%=CommonFunctions.HTMLControls.DrawComboBox("skillUsage", "usp_Whizible2_Sel_tbl_PM_ToolParameters ",,, "class='selectpicker' data-live-search='true'",,,) %>

                                            </div>
                                            <div class="col-sm-4">
                                                <label><%=MyBase.GetResourceString("C_Version")%></label>
                                                <%CommonFunctions.HTMLControls.DrawTextBox("text", "skillVersion", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=5 ",,,,,,, True) %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 form-group">
                                        <div class="row ">

                                            <div class="col-sm-4">
                                                <label><%=MyBase.GetResourceString("C_Utilization")%></label>
                                                <%CommonFunctions.HTMLControls.DrawTextBox("text", "skillPercentageUtilization", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=5 ",,,,,,, True) %>
                                            </div>
                                            <div class="col-sm-4">
                                                <label><%=MyBase.GetResourceString("C_Status")%></label>
                                                <select class="selectpicker form-control" data-live-search="true" id="skillStatus">
                                                    <option value="">Select Status</option>
                                                    <option value="Available" data-content="<span class='far fa-check-circle mx-1 mt-1 available_icon'></span> Available"></option>
                                                    <option value="Not Available" data-content="<span class='fas fa-times-circle mx-1 mt-1 not_available_icon'></span>Not Available"></option>
                                                </select>
                                            </div>
                                            <div class="col-sm-4">
                                                <label><%=MyBase.GetResourceString("C_NumberOfCopies")%></label>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("text", "skillNumberOfCopies", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=4 ",,,,,,, True) %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 form-group">
                                        <div class="row mb-3">
                                            <div class="col-sm-4">
                                                <label>&nbsp;</label>
                                                <div class="custom_chckbox">
                                                    <input class="chckHead" type="checkbox" id="skillIsCustomerSupplied">
                                                    <label for="skillIsCustomerSupplied"><%=MyBase.GetResourceString("C_IsSuppByCustomer")%></label>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <label>&nbsp;</label>
                                                <div class="custom_chckbox">
                                                    <input class="chckHead" type="checkbox" id="skillIsCritical">
                                                    <label for="skillIsCritical"><%=MyBase.GetResourceString("C_IsCritical")%></label>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <label>&nbsp;</label>
                                                <div class="custom_chckbox">
                                                    <input class="chckHead" type="checkbox" id="skillIsProcured">
                                                    <label for="skillIsProcured"><%=MyBase.GetResourceString("C_IsProcured")%></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-12 form-group">
                                        <div class="row mb-2">
                                            <div class="col-sm-4">
                                                <label><%=MyBase.GetResourceString("C_PlannedInDate")%></label>
                                                <div class="input-group datefielddiv">
                                                    <%CommonFunctions.HTMLControls.DrawTextBox("date", "plannedDateModalForSkill", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                                    <span class="input-group-btn">
                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <label><%=MyBase.GetResourceString("C_PlannedOutDate")%></label>
                                                <div class="input-group datefielddiv">
                                                    <%CommonFunctions.HTMLControls.DrawTextBox("date", "plannedOutDateModalForSkill", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                                    <span class="input-group-btn">
                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                    </span>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                    <div class="col-sm-12 form-group">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <label><%=MyBase.GetResourceString("C_BriefDescription")%></label>
                                                <%CommonFunctions.HTMLControls.DrawTextArea("text", "skillBriefDescription", "", "form-control", , , , , , , 2000, , , , , , , , "maxlength='500' ondrag= 'return false'; ondrop='return false;'", , , , , , , , , , True)%> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>

                                </div>
                            </div>
                        </div>
                    </div>


                </div>

                <div class="Resourcedetailpanel">
                    <div class="pgdetailinner p-0">
                        <ul class="nav nav-tabs detailsubtabs">
                            <li class="nav-item">
                                <a class="nav-link active" href="#skill_details_history_Tab" data-bs-toggle="tab"
                                   id=""><span class="active_tab"> <%=MyBase.GetResourceString("C_History")%></span></a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div id="skill_details_history_Tab" class="tab-pane active pt-0">
                                <div class="ResAllctnContent AllocateResourceSec">

                                    <div class="row mx-2">
                                        <div class="col-sm-6">

                                        </div>
                                        <div class="col-sm-6">
                                            <div class="nextBtnDiv d-flex justify-content-end gap-2 mt-2">
                                                <a href="javascript:;" class="btn borderbtn canceldetailpanel"
                                                   id="skillCancelBtn"><%=MyBase.GetResourceString("C_Cancel")%></a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="container-fluid">
                                        <div class="row mx-2 mt-2 ">
                                            <div class="col-sm-6">
                                                <div class="row form-group">
                                                    <div class="col-sm-4 d-flex justify-content-end">
                                                        <label><%=MyBase.GetResourceString("C_ModifiedField")%> : </label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <select class="selectpicker" data-live-search="true" id="modifiedHisFieldSkill">
                                                        
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row form-group">
                                                    <div class="col-sm-4 d-flex justify-content-end">
                                                        <label><%=MyBase.GetResourceString("C_ModifiedBy")%> : </label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <select class="selectpicker" data-live-search="true" id="modifiedHisBySkill">
                                                          
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="container-fluid">
                                        <table class="table table-stripped table-bordered mt-2 mb-2" id="Skills_Show_History_Tbl" width="100%">
                                            <thead>
                                                 <tr>
                                                     <th><%=MyBase.GetResourceString("C_ModifiedField")%></th>
                                                     <th><%=MyBase.GetResourceString("C_ModifiedDate")%></th>
                                                     <%--<th><%=MyBase.GetResourceString("C_Value")%></th>--%>
                                                     <th><%=MyBase.GetResourceString("C_OldValue")%></th>
                                                   <th><%=MyBase.GetResourceString("C_NewValue")%></th>
                                                     <th><%=MyBase.GetResourceString("C_ModifiedBy")%></th>
                                                 </tr>
                                            </thead>
                                            <tbody>
                                              
                                            </tbody>
                                        </table>
                                        <div class="pagination-container-inline" id="skills_history_pagination">
                                            <div style="color: #374151; font-size: 11.5px;"><span id="skillsHistoryTotalRecords">Total Records: 0</span></div>
                                            <div style="display: flex; gap: 0.5rem;">
                                                <button type="button" id="skillsHistoryFirstPageBtn" class="btn-page" title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
                                                <button type="button" id="skillsHistoryLastPageBtn" class="btn-page" title="Next Page"><i class="fas fa-angle-double-right"></i></button>
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
        <!-- Skills offcanvas Section End Here-->
        
        <!--Durgesh : Add Tools Selection Modal start here-->
             <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1"
                    id="offcanvas_ToolsAdd" aria-labelledby="offcanvas_ToolsAdd">
                <div class="offcanvas-body">
         <div id="NOI_Details_SecAdd" class="NOI_Details">
             <div class="NOI_Details_Header d-flex justify-content-between">
                 <div class="Overlay-title"></div>
                 <div class="NOI_HeaderBtns">
                 </div>
             </div>
             <div class="graybg container-fluid py-1 mb-2 statckmainheader">
                 <div class="row">
                     <div class="col-sm-12">
                         <div class="offcanvas-title-row">
                             <h5 class="pgtitle mb-0"><%=MyBase.GetResourceString("C_Tools")%></h5>
                             <button type="button" class="offcanvas-close-btn" onclick="closeNOIDetails()" data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Close">&#x2715;</button>
                         </div>
                     </div>
                 </div>
             </div>
             <div class="row mt-2 mb-2 project_timeperiod">
                 <div class="col-sm-12 ">
                     <div class="row">
                         <div class="col-sm-8">
                         </div>
                         <div class="col-sm-4 text-end">
                             <%If m_blnEditAccess = True Then%>
                             <a href="javascript:;" class="btn btnyellow " id="Sv_tools_infoAdd"
                                data-bs-toggle="tooltip" data-bs-container="body"
                                data-bs-placement="top" title="Save" onclick="addNewToolData()"><%=MyBase.GetResourceString("C_Save")%></a>
                             <%End If %>
                         </div>
                     </div>
                 </div>
             </div>
             <div class="NOI_Details_content">
                 <div class="tab-content detailsmenutab">
                     <!--<%-- First Tab - Basic Details --%>-->
                     <div class="tab-pane active" id="Basic_tools_DetailsTabAdd">
                         <div class="BasicDetailsContent">
                             <div class="row">
                                 <div class="col-sm-12 text-end">
                                     <label class="form-label ">(<font color="red">*</font> <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                                 </div>
                             </div>
                             <div class="col-sm-12 form-group">
                                 <div class="row mt-1 mb-2">

                                     <div class="col-sm-4 mt-1 text-start">
                                         <label class="control-label required"><%=MyBase.GetResourceString("C_Tool")%></label>
                                         <div class="row ">
                                             <div class="col-sm-10 pr-0">
                                                 <%CommonFunctions.HTMLControls.DrawTextBox("text", "toolDescriptionAdd", "form-control", , ,,,,,,,, " autocomplete='off' disabled=true",,,,,,, True) %>
                                             </div>
                                             <div class="col-sm-1 mt-1">
                                                 <a href="javascript:;" data-bs-toggle="modal"
                                                    data-bs-target="#Tools_Selection_modal" onclick="fillAvailableToolsForProjectToDropdown()">
                                                     <span data-bs-toggle="tooltip" data-bs-placement="top" title="Select Tools">
                                                         <i class="fa fa-link" aria-hidden="true"
                                                            style=" margin: 5px -17px 0;"></i>
                                                     </span>
                                                 </a>
                                             </div>
                                         </div>
                                     </div>
                                     <div class="col-sm-4">
                                         <label class="required"><%=MyBase.GetResourceString("C_Usage")%></label>
                                         <%=CommonFunctions.HTMLControls.DrawComboBox("toolUsageAdd", "usp_Whizible2_Sel_tbl_PM_ToolParameters ",,, "class='selectpicker' data-live-search='true'",,,) %>
                                     </div>
                                     <div class="col-sm-4">
                                         <label>Version</label>
                                         <%CommonFunctions.HTMLControls.DrawTextBox("text", "toolVersionAdd", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=5 ",,,,,,, True) %>
                                     </div>
                                 </div>
                             </div>
                             <div class="col-sm-12 form-group">
                                 <div class="row mb-2">

                                     <div class="col-sm-4">
                                         <label><%=MyBase.GetResourceString("C_Utilization")%></label>
                                         <%CommonFunctions.HTMLControls.DrawTextBox("text", "toolPercentageUtilizationAdd", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=5 ",,,,,,, True) %>
                                     </div>
                                     <div class="col-sm-4">
                                         <label><%=MyBase.GetResourceString("C_Status")%></label>
                                         <select class="selectpicker form-control" data-live-search="true" id="toolStatusAdd">
                                             <option value="">Select Status</option>
                                             <option value="Available" data-content="<span class='far fa-check-circle mx-1 mt-1 available_icon'></span> Available"></option>
                                             <option value="Not Available" data-content="<span class='fas fa-times-circle mx-1 mt-1 not_available_icon'></span>Not Available"></option>
                                         </select>
                                     </div>
                                     <div class="col-sm-4">
                                         <label><%=MyBase.GetResourceString("C_NumberOfCopies")%></label>
                                         <% CommonFunctions.HTMLControls.DrawTextBox("text", "toolNumberOfCopiesAdd", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=4 ",,,,,,, True) %>
                                     </div>
                                 </div>
                             </div>
                             <div class="col-sm-12 form-group">
                                 <div class="row mb-2">
                                     <div class="col-sm-4">
                                         <label>&nbsp;</label>
                                         <div class="custom_chckbox">
                                             <input class="chckHead" type="checkbox" id="toolIsCustomerSuppliedAdd">
                                             <label for="toolIsCustomerSuppliedAdd"><%=MyBase.GetResourceString("C_IsSuppByCustomer")%></label>
                                         </div>
                                     </div>
                                     <div class="col-sm-4">
                                         <label>&nbsp;</label>
                                         <div class="custom_chckbox">
                                             <input class="chckHead" type="checkbox" id="toolIsCriticalAdd">
                                             <label for="toolIsCriticalAdd"><%=MyBase.GetResourceString("C_IsCritical")%></label>
                                         </div>
                                     </div>
                                     <div class="col-sm-4">
                                         <label>&nbsp;</label>
                                         <div class="custom_chckbox">
                                             <input class="chckHead" type="checkbox" id="toolIsProcuredAdd">
                                             <label for="toolIsProcuredAdd"><%=MyBase.GetResourceString("C_IsProcured")%></label>
                                         </div>
                                     </div>
                                 </div>
                             </div>

                             <div class="col-sm-12 form-group">
                                 <div class="row mb-2">
                                     <div class="col-sm-4">
                                         <label><%=MyBase.GetResourceString("C_PlannedInDate")%></label>
                                         <div class="input-group datefielddiv">
                                             <%CommonFunctions.HTMLControls.DrawTextBox("date", "plannedDateModalForToolAdd", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                             <span class="input-group-btn">
                                                 <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                             </span>
                                         </div>
                                     </div>
                                     <div class="col-sm-4">
                                         <label><%=MyBase.GetResourceString("C_PlannedOutDate")%></label>
                                         <div class="input-group datefielddiv">
                                             <%CommonFunctions.HTMLControls.DrawTextBox("date", "plannedOutDateModalForToolAdd", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                             <span class="input-group-btn">
                                                 <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                             </span>
                                         </div>
                                     </div>


                                 </div>
                             </div>
                             <div class="col-sm-12 form-group">
                                 <div class="row">
                                     <div class="col-sm-12">
                                         <label><%=MyBase.GetResourceString("C_BriefDescription")%></label>
                                         <%CommonFunctions.HTMLControls.DrawTextArea("text", "toolBriefDescriptionAdd", "", "form-control", , , , , , , 2000, , , , , , , , "maxlength='500' ondrag= 'return false'; ondrop='return false;'", , , , , , , , , , True)%> 
                                     </div>
                                 </div>
                             </div>
                             <div class="clearfix"></div>

                         </div>
                     </div>
                 </div>
                
         </div>
     </div>
 </div>
 </div>  
        <!--Add Tools Skills offcanvas Section End Here-->
        
        <!--Durgesh : Add Skill Selection Modal start here-->
     <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1"
      id="offcanvas_SkillsAdd" aria-labelledby="offcanvas_Skills">
     <div class="offcanvas-body">
         <div id="Skills_DetailsAdd" class="NOI_Details">
             <div class="NOI_Details_Header d-flex justify-content-between">
                 <div class="Overlay-title"></div>
                 <div class="NOI_HeaderBtns">
                 </div>
             </div>
             <div class="graybg container-fluid py-1 mb-2 statckmainheader">
                 <div class="row">
                     <div class="col-sm-12">
                         <div class="offcanvas-title-row">
                             <h5 class="pgtitle mb-0"><%=MyBase.GetResourceString("C_Skills")%></h5>
                             <button type="button" class="offcanvas-close-btn" onclick="closeNOIDetails()" data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Close">&#x2715;</button>
                         </div>
                     </div>
                 </div>
             </div>

             <div class="row mt-2 mb-2 project_timeperiod">
                 <div class="col-sm-12 ">
                     <div class="row">
                         <div class="col-sm-8">
                         </div>
                         <div class="col-sm-4 text-end">
                             <%If m_blnEditAccess = True Then%>
                             <a href="javascript:;" class="btn btnyellow " id="Sv_Skills_infoAdd" data-bs-toggle="tooltip" data-bs-container="body"
                                data-bs-placement="top" title="Save" onclick="addNewSkillData()"><%=MyBase.GetResourceString("C_Save")%></a>
                              <%End If %>
                         </div>
                     </div>
                 </div>
             </div>
             <div class="NOI_Details_content">
                 <div class="tab-content detailsmenutab">
                     <!--<%-- First Tab - Basic Details --%>-->
                     <div class="tab-pane active" id="Basic_Skills_DetailsTabAdd">
                         <div class="BasicDetailsContent">
                             <div class="row">
                                 <div class="col-sm-12 text-end">
                                     <label class="form-label ">(<font color="red">*</font> <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                                 </div>
                             </div>
                             <div class="col-sm-12 form-group">
                                 <div class="row mt-1 mb-3">
                                     <div class="col-sm-4 mt-1 text-start">
                                         <label class="control-label required"><%=MyBase.GetResourceString("C_Skills")%></label>
                                         <div class="row ">
                                             <div class="col-sm-10 pr-0">
                                                 <%CommonFunctions.HTMLControls.DrawTextBox("text", "skillDescriptionAdd", "form-control", , ,,,,,,,, " autocomplete='off' disabled=true",,,,,,, True) %>
                                             </div>
                                             <div class="col-sm-1 mt-1">
                                                 <a href="javascript:;" data-bs-toggle="modal"
                                                    data-bs-target="#Skills_Selection_modal">
                                                     <span data-bs-toggle="tooltip" data-bs-placement="top" title="Select Skills" onclick="fillAvailableSkillsForProjectToDropdown()">
                                                         <i class="fa fa-link" aria-hidden="true"
                                                            style=" margin: 5px -17px 0;"></i>
                                                     </span>
                                                 </a>
                                             </div>
                                         </div>
                                     </div>
                                     <div class="col-sm-4">
                                         <label class="required"><%=MyBase.GetResourceString("C_Usage")%></label>
                                        <%=CommonFunctions.HTMLControls.DrawComboBox("skillUsageAdd", "usp_Whizible2_Sel_tbl_PM_ToolParameters ",,, "class='selectpicker' data-live-search='true'",,,) %>

                                     </div>
                                     <div class="col-sm-4">
                                         <label><%=MyBase.GetResourceString("C_Version")%></label>
                                         <%CommonFunctions.HTMLControls.DrawTextBox("text", "skillVersionAdd", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=5 ",,,,,,, True) %>
                                     </div>
                                 </div>
                             </div>
                             <div class="col-sm-12 form-group">
                                 <div class="row ">

                                     <div class="col-sm-4">
                                         <label><%=MyBase.GetResourceString("C_Utilization")%></label>
                                         <%CommonFunctions.HTMLControls.DrawTextBox("text", "skillPercentageUtilizationAdd", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=5 ",,,,,,, True) %>
                                     </div>
                                     <div class="col-sm-4">
                                         <label><%=MyBase.GetResourceString("C_Status")%></label>
                                         <select class="selectpicker form-control" data-live-search="true" id="skillStatusAdd">
                                             <option value="">Select Status</option>
                                             <option value="Available" data-content="<span class='far fa-check-circle mx-1 mt-1 available_icon'></span> Available"></option>
                                             <option value="Not Available" data-content="<span class='fas fa-times-circle mx-1 mt-1 not_available_icon'></span>Not Available"></option>
                                         </select>
                                     </div>
                                     <div class="col-sm-4">
                                         <label><%=MyBase.GetResourceString("C_NumberOfCopies")%></label>
                                         <% CommonFunctions.HTMLControls.DrawTextBox("text", "skillNumberOfCopiesAdd", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=4 ",,,,,,, True) %>
                                     </div>
                                 </div>
                             </div>
                             <div class="col-sm-12 form-group">
                                 <div class="row mb-3">
                                     <div class="col-sm-4">
                                         <label>&nbsp;</label>
                                         <div class="custom_chckbox">
                                             <input class="chckHead" type="checkbox" id="skillIsCustomerSuppliedAdd">
                                             <label for="skillIsCustomerSuppliedAdd"><%=MyBase.GetResourceString("C_IsSuppByCustomer")%></label>
                                         </div>
                                     </div>
                                     <div class="col-sm-4">
                                         <label>&nbsp;</label>
                                         <div class="custom_chckbox">
                                             <input class="chckHead" type="checkbox" id="skillIsCriticalAdd">
                                             <label for="skillIsCriticalAdd"><%=MyBase.GetResourceString("C_IsCritical")%></label>
                                         </div>
                                     </div>
                                     <div class="col-sm-4">
                                         <label>&nbsp;</label>
                                         <div class="custom_chckbox">
                                             <input class="chckHead" type="checkbox" id="skillIsProcuredAdd">
                                             <label for="skillIsProcuredAdd"><%=MyBase.GetResourceString("C_IsProcured")%></label>
                                         </div>
                                     </div>
                                 </div>
                             </div>

                             <div class="col-sm-12 form-group">
                                 <div class="row mb-2">
                                     <div class="col-sm-4">
                                         <label><%=MyBase.GetResourceString("C_PlannedInDate")%></label>
                                         <div class="input-group datefielddiv">
                                             <%CommonFunctions.HTMLControls.DrawTextBox("date", "plannedDateModalForSkillAdd", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                             <span class="input-group-btn">
                                                 <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                             </span>
                                         </div>
                                     </div>
                                     <div class="col-sm-4">
                                         <label><%=MyBase.GetResourceString("C_PlannedOutDate")%></label>
                                         <div class="input-group datefielddiv">
                                             <%CommonFunctions.HTMLControls.DrawTextBox("date", "plannedOutDateModalForSkillAdd", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                             <span class="input-group-btn">
                                                 <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                             </span>
                                         </div>
                                     </div>


                                 </div>
                             </div>
                             <div class="col-sm-12 form-group">
                                 <div class="row">
                                     <div class="col-sm-12">
                                         <label><%=MyBase.GetResourceString("C_BriefDescription")%></label>
                                          <%CommonFunctions.HTMLControls.DrawTextArea("text", "skillBriefDescriptionAdd", "", "form-control", , , , , , , 2000, , , , , , , , "maxlength='500' ondrag= 'return false'; ondrop='return false;'", , , , , , , , , , True)%> 
                                     </div>
                                 </div>
                             </div>
                             <div class="clearfix"></div>

                         </div>
                     </div>
                 </div>
             </div>


         </div>

     </div>
 </div>
        <!--Add Skill Skills offcanvas Section End Here-->

        <!--Durgesh : Edit Filter  Modal start here-->
        <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1"
     id="offcanvas_FiltersAdd" aria-labelledby="offcanvas_Filters">
    <div class="offcanvas-body">
        <div id="Filters_DetailsAdd" class="NOI_Details">
            <div class="NOI_Details_Header d-flex justify-content-between">
                <div class="Overlay-title"></div>
                <div class="NOI_HeaderBtns">
                </div>
            </div>
            <div class="graybg container-fluid py-1 mb-2 statckmainheader">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="offcanvas-title-row">
                            <h5 class="pgtitle mb-0"><%=MyBase.GetResourceString("C_EditFilter")%></h5>
                            <button type="button" class="offcanvas-close-btn" onclick="closeNOIDetails()" data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Close">&#x2715;</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-2 mb-2 project_timeperiod">
                <div class="col-sm-12 ">
                    <div class="row">
                        <div class="col-sm-8">
                        </div>
                        <div class="col-sm-4 text-end">
                            <%If m_blnEditAccess = True Then%>
                            <a href="javascript:;" class="btn btnyellow " id="Sv_Filters_infoAdd" data-bs-toggle="tooltip" data-bs-container="body"
                               data-bs-placement="top" title="Save" onclick="UpdateFilter()"><%=MyBase.GetResourceString("C_Save")%></a>
                             <%End If %>
                        </div>
                    </div>
                </div>
            </div>

            <div id="tools_skills_filter2" class="tab-pane stackbasicfilter">
     <!--filter panel start here-->
     <div class="filterpanelwrapbasicfilter">
         <div class="filterpanelbody" id="accordion2">
             <div class="row hidden-xs IB_filterlist">
                 <!--basic filter conduct review start here-->
                 <div class="row form-group mb-2">
                     <div class="col-sm-6">
                         <div class="row form-group">
                             <div class="col-sm-12">
                                 <div class="row form-group">
                                     <div class="col-sm-4 text-end mt-2">
                                         <label class="lb_filter_usage" for="txtFilter_usage2"><%=MyBase.GetResourceString("C_Usage")%> :</label>
                                     </div>
                                     <div class="col-sm-8">
                                         <%=CommonFunctions.HTMLControls.DrawComboBox("txtFilter_usage2", "usp_Whizible2_Sel_tbl_PM_ToolParameters ",,, "class='selectpicker' data-live-search='true'",,,) %>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                     <div class="col-sm-6">
                         <div class="row form-group">
                             <div class="col-sm-12">
                                 <div class="row form-group">
                                     <div class="col-sm-4 text-end mt-2">
                                         <label class="lb_filter_version" for="txt_filter_version2"><%=MyBase.GetResourceString("C_Version")%> :</label>
                                     </div>
                                     <div class="col-sm-8">
                                         <%CommonFunctions.HTMLControls.DrawTextBox("text", "txt_filter_version2", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
        
                 </div>
        
                 <div class="row form-group mb-2">
                     <div class="col-sm-6">
                         <div class="row form-group">
                             <div class="col-sm-12">
                                 <div class="row form-group">
                                     <div class="col-sm-4 text-end mt-2">
                                         <label for="txt_filter_util2"><%=MyBase.GetResourceString("C_Utilization")%> :</label>
                                     </div>
                                     <div class="col-sm-8">
                                         <%CommonFunctions.HTMLControls.DrawTextBox("text", "txt_filter_util2", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=5 ",,,,,,, True) %>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                     <div class="col-sm-6">
                         <div class="row form-group">
                             <div class="col-sm-12">
                                 <div class="row form-group">
                                     <div class="col-sm-4 text-end mt-2">
                                         <label for="supplied_cust"><%=MyBase.GetResourceString("C_IsSuppByCustomer")%> :</label>
                                     </div>
                                     <div class="col-sm-8 mt-2">
                                         <select class="selectpicker form-control" data-live-search="true" id="supplied_cust_filter2" data-none-selected-text="">
                                             <option value=""></option>
                                             <option value="1">Yes</option>
                                             <option value="0">No</option>
                                         </select>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
        
                 </div>
                 <div class="row form-group mb-2">
                     <div class="col-sm-6">
                         <div class="row form-group">
                             <div class="col-sm-12">
                                 <div class="row form-group">
                                     <div class="col-sm-4 text-end mt-2">
                                         <label for="filter_critical2"><%=MyBase.GetResourceString("C_IsCritical")%> :</label>
                                     </div>
                                     <div class="col-sm-8 mt-2">
                                         <select class="selectpicker form-control" data-live-search="true" id="filter_critical2" data-none-selected-text="">
                                             <option value=""></option>
                                             <option value="1">Yes</option>
                                             <option value="0">No</option>
                                         </select>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                     <div class="col-sm-6">
                         <div class="row form-group">
                             <div class="col-sm-12">
                                 <div class="row form-group">
                                     <div class="col-sm-4 text-end mt-2">
                                         <label for="filter_procured2"><%=MyBase.GetResourceString("C_IsProcured")%> :</label>
                                     </div>
                                     <div class="col-sm-8 mt-2">
                                         <select class="selectpicker form-control" data-live-search="true" id="filter_procured2" data-none-selected-text="">
                                             <option value=""></option>
                                             <option value="1">Yes</option>
                                             <option value="0">No</option>
                                         </select>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
                 <div class="row form-group mb-2">
                     <div class="col-sm-6">
                         <div class="row form-group">
                             <div class="col-sm-12">
                                 <div class="row form-group">
                                     <div class="col-sm-4 text-end mt-2">
                                         <label for="txt_desc2"><%=MyBase.GetResourceString("C_BriefDescription")%> :</label>
                                     </div>
                                     <div class="col-sm-8 mt-2">
                                         <%CommonFunctions.HTMLControls.DrawTextArea("text", "txt_desc2", "", "form-control", , , , , , , 2000, , , , , , , , "maxlength='500' ondrag= 'return false'; ondrop='return false;'", , , , , , , , , , True)%> 
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                     <div class="col-sm-6">
                         <div class="row form-group">
                             <div class="col-sm-12">
                                 <div class="row form-group">
                                     <div class="col-sm-4 text-end mt-2">
                                         <label for="txt_copies2"><%=MyBase.GetResourceString("C_NumberOfCopies")%> :</label>
                                     </div>
                                     <div class="col-sm-8 mt-2">
                                         <% CommonFunctions.HTMLControls.DrawTextBox("text", "txt_copies2", "form-control", , ,,,,,,,, " autocomplete='off' maxlength=4 ",,,,,,, True) %>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
        
                 </div>
        
                 <div class="row form-group mb-2">
        
                     <div class="col-sm-6">
                         <div class="row form-group">
                             <div class="col-sm-12">
                                 <div class="row form-group">
                                     <div class="col-sm-4 text-end mt-2">
                                         <label for="Planned_indate2"><%=MyBase.GetResourceString("C_PlannedInDate")%> :</label>
                                     </div>
                                     <div class="col-sm-8 mt-2">
                                         <div class="input-group datefielddiv">
                                             <%CommonFunctions.HTMLControls.DrawTextBox("date", "Planned_indate2", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                             <span class="input-group-btn">
                                                 <button class="btn btncalendar" type="button">
                                                     <i class="fas fa-calendar-alt"></i>
                                                 </button>
                                             </span>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                     <div class="col-sm-6">
                         <div class="row form-group">
                             <div class="col-sm-12">
                                 <div class="row form-group">
                                     <div class="col-sm-4 text-end mt-2">
                                         <label for="Planned_out_date2"><%=MyBase.GetResourceString("C_PlannedOutDate")%> :</label>
                                     </div>
                                     <div class="col-sm-8 mt-2">
                                         <div class="input-group datefielddiv">
                                             <%CommonFunctions.HTMLControls.DrawTextBox("date", "Planned_out_date2", "form-control", , ,,,,,,,, " autocomplete='off' ",,,,,,, True) %>
                                             <span class="input-group-btn">
                                                 <button class="btn btncalendar" type="button">
                                                     <i class="fas fa-calendar-alt"></i>
                                                 </button>
                                             </span>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
                 <div class="row form-group mb-2">
        
                     <div class="col-sm-6">
                         <div class="row form-group">
                             <div class="col-sm-12">
                                 <div class="row form-group">
                                     <div class="col-sm-4 text-end mt-2">
                                         <label for="txt_filter_status2"><%=MyBase.GetResourceString("C_Status")%> :</label>
                                     </div>
                                     <div class="col-sm-8 mt-2">
                                         <select class="selectpicker form-control" data-live-search="true" id="txt_filter_status2">
                                             <option value="">Select Status</option>
                                             <option value="Available" data-content="<span class='far fa-check-circle mx-1 mt-1 available_icon'></span> Available"></option>
                                             <option value="Not Available" data-content="<span class='fas fa-times-circle mx-1 mt-1 not_available_icon'></span>Not Available"></option>
                                         </select>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                     <div class="col-sm-6">
                         <div class="row form-group">
                             <div class="col-sm-12">
                                 <div class="row form-group">
                                     <div class="col-sm-4 text-end mt-2">
                                         <label for="filter_projectname"><%=MyBase.GetResourceString("C_ProjectName")%> :</label>
                                     </div>
                                     <div class="col-sm-8 mt-2">
                                         <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_Projects_filter2", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "class='form-select'",,,) %>
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
</div>
        <!--Edit Filter offcanvas Section End Here-->


     <%--Commented & Added By Vyankat B. For For Tools Delete on 07thJuly 2025--%>     
                     <div id="deleteConfirm" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-bs-dismiss="modal">
                        <div class="modal-dialog ui-draggable">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header ui-draggable-handle">
                                    <button type="button" class="close" data-bs-dismiss="modal">×</button>                                    
                                    <h4 class="modal-title"><%= MyBase.GetResourceString("C_DeleteConf")%></h4>
                                </div>
                                <div class="modal-body">
                                   
                                    <p id="deleteConfirmTPlan"><center><%= MyBase.GetResourceString("C_DeleAlert")%></center></p>

                                </div>
                                <div class="modal-footer">
                                    <button class="btn borderbtn float-start uncheckbtn me-auto" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_No")%></button>
                                    <button class="btn btnyellow" data-bs-toggle="modal" data-original-title="" data-bs-dismiss="modal" title="" onclick="collectSelectedToolIDsToolTabTable()"><%= MyBase.GetResourceString("C_Yes")%></button>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
    
       <%--End of Commented & Added By Vyankat B. For Tools Delete on 07thJuly 2025--%>  

     <%--Commented & Added By Vyankat B. For Skill Delete  on 07thJuly 2025--%>     
                     <div id="deleteSkill" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-bs-dismiss="modal">
                        <div class="modal-dialog ui-draggable">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header ui-draggable-handle">
                                    <button type="button" class="close" data-bs-dismiss="modal">×</button>  
                                    <h4 class="modal-title"><%= MyBase.GetResourceString("C_DeleteConf")%></h4>
                                </div>
                                <div class="modal-body">
                                   
                                    <p id="deleteSkillTPlan"><center><%= MyBase.GetResourceString("C_DeleAlert")%></center></p>

                                </div>
                                <div class="modal-footer">
                                    <button class="btn borderbtn float-start uncheckbtn me-auto" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_No")%></button>
                                    <button class="btn btnyellow" data-bs-toggle="modal" data-original-title="" data-bs-dismiss="modal" title="" onclick="collectSelectedSkillIDsSkillTabTable()"><%= MyBase.GetResourceString("C_Yes")%></button>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
    
       <%--End of Commented & Added By Vyankat B. For Skill Delete on 07thJuly 2025--%> 


        <!--Filter modal start here-->
        <div class="modal custmodal  fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="taskeditorlabel" aria-hidden="false">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header d-block">
                        <h5 class="modal-title text-center" id=""><%=MyBase.GetResourceString("C_SaveFilterAs")%> </h5>
                         <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end"><%=MyBase.GetResourceString("C_FilterName")%> :</label>
                                            <div class="col-md-8">
                                                <input type="hidden" name="FilterID" id="FilterID" value="0">
                                                <input type="hidden" name="QueryID" id="QueryID" value="0">
                                                <input type="text" name="filterName" id="txtFilterName" class="form-control" style="text-align:Left" maxlength="500" value="" autocomplete="off"><br>
                                                <div class="btnrow">
                                                    <button class="btn btnyellow float-start savefilter" id="btnSaveBasicFilter" onclick="saveFilter()"><%=MyBase.GetResourceString("C_Save")%></button>
                                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end"><%=MyBase.GetResourceString("C_Cancel")%></button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <!-- /.content -->
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <!--Skills Selection Modal start here-->
        <div class="modal custmodal fade" id="Skills_Selection_modal" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header d-block">
                        <h5 class="modal-title text-center" id="">
                            <%=MyBase.GetResourceString("C_SkillsSelection")%>
                        </h5>
                        <button type="button" id="clstheModal" class="close" data-bs-dismiss="modal" aria-label="Close">
                             <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mx-2 mb-2">
                            <div class="col-sm-3 text-end">
                                <label> <%=MyBase.GetResourceString("C_SkillSubCategory")%></label>
                            </div>
                            <div class="col-sm-4">
                                <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_SkillSubCategory", "usp_Whizible2_sel_tbl_PM_Tools_Category_CategoryName ",,, "onchange='AppendSkillsForSubCategory(this.value);' class='form-select'",,,) %>
                            </div>
                            <div class="col-sm-1"></div>

                            <div class="col-sm-4 text-center">
                                <div class="input-group">
                                    <%CommonFunctions.HTMLControls.DrawTextBox("text", "skills_input", "form-control", , ,,,,,,,, " autocomplete='off' placeholder=Search.. onkeyup= search_skills() ",,,,,,, True) %>
                                    <div class="input-group-btn">
                                        <button class="btn btn-default srchBtn" type="submit"><i class="fas fa-search"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 px-3 mb-2">
                            <table class="table table-stripped modalDTtabl table-bordered completiontbl" id="skill_selectio_Tbl" style="width:100%; margin-bottom:2px; margin-top:10px;">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_Skills")%></th>
                                        <th><%=MyBase.GetResourceString("C_Select")%></th>
                                    </tr>
                                </thead>
                                <tbody>
                                   
                                </tbody>
                            </table>
                            <div class="pagination-container-inline" id="skills_selection_pagination" style="padding: 0.5rem 0; margin-top: 20px;">
                                <div style="color: #374151; font-size: 11.5px;"><span id="skillsSelectionTotalRecords">Total Records: 0</span></div>
                                <div style="display: flex; gap: 0.5rem;">
                                    <button type="button" id="skillsSelectionFirstPageBtn" class="btn-page" title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
                                    <button type="button" id="skillsSelectionLastPageBtn" class="btn-page" title="Next Page"><i class="fas fa-angle-double-right"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="form-group text-center ">
                            <button class="btn btnyellow mt-3" id="Select_skills" onclick="collectSelectedSkillIDs()"><%=MyBase.GetResourceString("C_Select")%></button>
                            <button class="btn borderbtn mt-3 ml-1" data-bs-dismiss="modal" id="cls_skills"><%=MyBase.GetResourceString("C_Cancel")%></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Skills Selection modal end here-->

        <!--Tools Selection Modal start here-->
        <div class="modal custmodal fade" id="Tools_Selection_modal" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header d-block">
                        <h5 class="modal-title text-center" id="">
                            <%=MyBase.GetResourceString("C_ToolSelection")%>
                        </h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mx-1 mb-2">
                            <div class="col-sm-8"></div>
                            <div class="col-sm-4 text-center">
                                <div class="input-group">
                                    <%CommonFunctions.HTMLControls.DrawTextBox("text", "tools_input", "form-control input-sm", , ,,,,,,,, " autocomplete='off' placeholder=Search.. onkeyup=search_tools()",,,,,,, True) %>
                                    <div class="input-group-btn">
                                        <button class="btn btn-default srchBtn" type="submit"><i class="fas fa-search"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 px-2 mb-2">
                            <table class="table table-stripped modalDTtabl table-bordered completiontbl" id="tools_selectio_Tbl" style="width:100%">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_Tools")%></th>
                                        <th><%=MyBase.GetResourceString("C_Select")%></th>
                                    </tr>
                                </thead>
                                <tbody>
                                   
                                </tbody>
                            </table>
                            <div class="pagination-container-inline" id="tools_selection_pagination" style="padding: 0.5rem 0; margin-top: 20px;">
                                <div style="color: #374151; font-size: 11.5px;"><span id="toolsSelectionTotalRecords">Total Records: 0</span></div>
                                <div style="display: flex; gap: 0.5rem;">
                                    <button type="button" id="toolsSelectionFirstPageBtn" class="btn-page" title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
                                    <button type="button" id="toolsSelectionLastPageBtn" class="btn-page" title="Next Page"><i class="fas fa-angle-double-right"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="form-group text-center ">
                            <button class="btn btnyellow mt-3" id="Select_Tools" onclick="collectSelectedToolIDs()"><%=MyBase.GetResourceString("C_Select")%></button>
                            <button class="btn borderbtn mt-3 ml-1" data-bs-dismiss="modal" id="cls_Tools"><%=MyBase.GetResourceString("C_Cancel")%></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Tools Selection modal end here-->

        <div class="clearfix"></div>

    <%Else %>
        <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
         <p style="margin-top: 136px; font-weight: 700;">You are not authorized to view this page.</p>
        </div>
        </div>
    <%End If %>
 


        <!-- ./wrapper -->
        <!-- REQUIRED JS SCRIPTS -->
        <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>--%>
        <!-- jqueryUI js -->
        <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>--%>
       <%-- <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>--%>
   <%-- <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
<script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>--%>
        <%--<script src="../../../Whizible2.0-new/dist/js/jquery.simplePagination.js"></script>--%>
        <!--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>-->
       <%-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
        <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>
        <script>


            var toolIDSSelectedForDeletion;
            // Cross-page selection state for Tools and Skills (Select All + individual checkboxes)
            var selectedToolIDsSet = new Set();
            var selectedSkillIDsSet = new Set();
            // All row IDs when table is built (so Select All works across all pages without page loop)
            var toolsTableAllIDs = [];
            var skillsTableAllIDs = [];
            //Code Added By Durgesh Dalvi
            
// Loader state — mirrors PM_ReportUIBuilder logic
var loaderShown = false;
var loaderStartTime = 0;

function showLoader() {
    document.getElementById('pageLoader').style.display = 'block';
    loaderShown = true;
    loaderStartTime = Date.now();
}

function hideLoader() {
    if (!loaderShown) return;
    var elapsedTime = Date.now() - loaderStartTime;
    var minDisplayTime = 1500; // Minimum 1.5 seconds
    if (elapsedTime < minDisplayTime) {
        setTimeout(function() {
            document.getElementById('pageLoader').style.display = 'none';
            loaderShown = false;
        }, minDisplayTime - elapsedTime);
    } else {
        document.getElementById('pageLoader').style.display = 'none';
        loaderShown = false;
    }
}

$(document).ajaxStart(function () {
    showLoader();
});

$(document).ajaxStop(function () {
    hideLoader();
});

            $(document).ready(function () {
                //debugger
                //Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
                $.ajax({
                    type: 'POST',
                    dataType: 'JSON',
                    contentType: 'application/json',
                    url: 'PM_ToolsSkills.aspx/CheckProjectIsClosed',
                    data: JSON.stringify({ ProjectID: $('#ddl_Projects').val() }),
                    success: function (Result) {
                    },
                    error: function (xhr) {
                    }
                });
                //End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects

                var ViewAccess = '<%=m_blnViewAccess%>';
                var EditAccess = '<%=m_blnEditAccess%>';
        var DeleteAccess = '<%=m_blnDeleteAccess%>';
                var AddAccess = '<%=m_blnAddAccess%>';


                var lastAppliedFilterParams = null;
           

                selectedProjectID = defaultProjectID;
                var projectDropdown = document.getElementById('ddl_Projects');
                projectDropdown.value = '0';
                for (var i = 0; i < projectDropdown.options.length; i++) {
                    if (projectDropdown.options[i].value == defaultProjectID) {
                        projectDropdown.selectedIndex = i;
                        break;
                    }
                }
                $('.selectpicker').selectpicker('refresh');

                // Hide Clear All button initially - only show after applying filters
                toggleClearAllSpan(0);
                // Ensure Clear All button is hidden on page load
                document.getElementById('ProjectClearAllFilter').style.display = 'none';

                populateToolsTable(defaultProjectID);
                //populateSkillsTable(defaultProjectID);

                /* Added By Dipali V On 5th Jun 2026 — Show Back when opened from Bulk Allocation skill confirm (Yes) */
                initBulkAllocBackButton();

                // -----------------------------------------------------------
                // Code Added by Vaibhav K To Trigger API Calls on Tab Switch on 09-02-25
              
                // -----------------------------------------------------------
                // Reset flags to force API calls on tab switch
                $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                    var targetTab = $(e.target).attr('href');

                   

                    if (targetTab === '#Tab_Tools_trend') {
                        populateToolsTable(selectedProjectID);
                        $('#tools_pagination_container').show();
                        $('#skills_pagination_container').hide();
                        setTimeout(function() { updateToolsPaginationUI(); }, 50);
                    } else if (targetTab === '#Tab_skills_trend') {
                        populateSkillsTable(selectedProjectID);
                        $('#skills_pagination_container').show();
                        $('#tools_pagination_container').hide();
                        setTimeout(function() {
                            //Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                            if (skillsTableNeedsInit || !$.fn.DataTable.isDataTable('#skills_tbl')) {
                                initializeSkillsDataTable();
                            }
                            //End of Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                            updateSkillsPaginationUI();
                        }, 100);
                    }
                });
                //End of Code Added by Vaibhav K To Trigger API Calls on Tab Switch on 09-02-25

                // Pagination - Total Records + Prev/Next (match Releases/Lessons Learnt)
                $('body').addClass('tools-skills-pagination');
                $('#tools_pagination_container').show();
                $('#skills_pagination_container').hide();
                $(document).on('draw.dt', '#tools_tbl', function() { updateToolsPaginationUI(); });
                $(document).on('draw.dt', '#skills_tbl', function() { updateSkillsPaginationUI(); });
                setTimeout(function() { updateToolsPaginationUI(); }, 300);
                $('#toolsFirstPageBtn').on('click', function() {
                    if ($.fn.DataTable.isDataTable('#tools_tbl')) {
                        var dt = $('#tools_tbl').DataTable();
                        if (dt.page.info().page > 0) { dt.page('previous').draw('page'); }
                    }
                });
                $('#toolsLastPageBtn').on('click', function() {
                    if ($.fn.DataTable.isDataTable('#tools_tbl')) {
                        var dt = $('#tools_tbl').DataTable();
                        var info = dt.page.info();
                        if (info.page < info.pages - 1) { dt.page('next').draw('page'); }
                    }
                });
                $('#skillsFirstPageBtn').on('click', function() {
                    if ($.fn.DataTable.isDataTable('#skills_tbl')) {
                        var dt = $('#skills_tbl').DataTable();
                        if (dt.page.info().page > 0) { dt.page('previous').draw('page'); }
                    }
                });
                $('#skillsLastPageBtn').on('click', function() {
                    if ($.fn.DataTable.isDataTable('#skills_tbl')) {
                        var dt = $('#skills_tbl').DataTable();
                        var info = dt.page.info();
                        if (info.page < info.pages - 1) { dt.page('next').draw('page'); }
                    }
                });
                // History + Selection modal tables - same pagination UI
                $(document).on('draw.dt', '#Tools_Show_History_Tbl', function() { updateToolsHistoryPaginationUI(); });
                $(document).on('draw.dt', '#Skills_Show_History_Tbl', function() { updateSkillsHistoryPaginationUI(); });
                $(document).on('draw.dt', '#tools_selectio_Tbl', function() { updateToolsSelectionPaginationUI(); });
                $(document).on('draw.dt', '#skill_selectio_Tbl', function() { updateSkillsSelectionPaginationUI(); });
                $('#toolsHistoryFirstPageBtn').on('click', function() {
                    if ($.fn.DataTable.isDataTable('#Tools_Show_History_Tbl')) {
                        var dt = $('#Tools_Show_History_Tbl').DataTable();
                        if (dt.page.info().page > 0) { dt.page('previous').draw('page'); }
                    }
                });
                $('#toolsHistoryLastPageBtn').on('click', function() {
                    if ($.fn.DataTable.isDataTable('#Tools_Show_History_Tbl')) {
                        var dt = $('#Tools_Show_History_Tbl').DataTable();
                        var info = dt.page.info();
                        if (info.page < info.pages - 1) { dt.page('next').draw('page'); }
                    }
                });
                $('#skillsHistoryFirstPageBtn').on('click', function() {
                    if ($.fn.DataTable.isDataTable('#Skills_Show_History_Tbl')) {
                        var dt = $('#Skills_Show_History_Tbl').DataTable();
                        if (dt.page.info().page > 0) { dt.page('previous').draw('page'); }
                    }
                });
                $('#skillsHistoryLastPageBtn').on('click', function() {
                    if ($.fn.DataTable.isDataTable('#Skills_Show_History_Tbl')) {
                        var dt = $('#Skills_Show_History_Tbl').DataTable();
                        var info = dt.page.info();
                        if (info.page < info.pages - 1) { dt.page('next').draw('page'); }
                    }
                });
                $('#toolsSelectionFirstPageBtn').on('click', function() {
                    if ($.fn.DataTable.isDataTable('#tools_selectio_Tbl')) {
                        var dt = $('#tools_selectio_Tbl').DataTable();
                        if (dt.page.info().page > 0) { dt.page('previous').draw('page'); }
                    }
                });
                $('#toolsSelectionLastPageBtn').on('click', function() {
                    if ($.fn.DataTable.isDataTable('#tools_selectio_Tbl')) {
                        var dt = $('#tools_selectio_Tbl').DataTable();
                        var info = dt.page.info();
                        if (info.page < info.pages - 1) { dt.page('next').draw('page'); }
                    }
                });
                $('#skillsSelectionFirstPageBtn').on('click', function() {
                    if ($.fn.DataTable.isDataTable('#skill_selectio_Tbl')) {
                        var dt = $('#skill_selectio_Tbl').DataTable();
                        if (dt.page.info().page > 0) { dt.page('previous').draw('page'); }
                    }
                });
                $('#skillsSelectionLastPageBtn').on('click', function() {
                    if ($.fn.DataTable.isDataTable('#skill_selectio_Tbl')) {
                        var dt = $('#skill_selectio_Tbl').DataTable();
                        var info = dt.page.info();
                        if (info.page < info.pages - 1) { dt.page('next').draw('page'); }
                    }
                });
            // -----------------------------------------------------------


                var selectElement = document.getElementById("ddl_SkillSubCategory");

                var newOption = document.createElement("option");
                newOption.text = "Select Option";
                newOption.value = "0";

                selectElement.insertBefore(newOption, selectElement.firstChild);
                //availableFiltersForUser();

                document.getElementById('ddl_Projects').remove(0);

            });

            function AJAXCallWithResult(url, param, async) {
                //if (!url.startsWith("/")) {
                //    url = "/" + url;
                //}
                var ajaxResult = null;
                $.ajax({
                    url: encodeURI(strUrl + url),
                    type: "POST",
                    data: JSON.stringify(param),
                    async: async,
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                        if (param) {
                            xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                        }

                    },
                    success: function (data) {
                        ajaxResult = data;
                    },
                    error: function (err) {
                        ajaxResult = undefined;
                        console.error("AJAX Error: ", err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + encodeURIComponent(err.responseText);
                    }
                });

                return ajaxResult;
            }

            //var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString()%>';
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString()%>';


            var LoginType = '<%= Session("LoginType") %>';
            var RoleID = '<%= Session("intPostID") %>';
            var UserId = '<%= Session("intUserID") %>';
            var UserName = '<%= Session("strUserName") %>';
            var defaultProjectID = <%= Session("intProjectID")%>;

            var SpecialCharactersList = '<%= System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString %>';

            var invalidCharactersRegex = new RegExp("[" +
                SpecialCharactersList.replace(/[-\/\\^$*+?.()|[\]{}'"!:;,`~#&]/g, '\\$&') +
                "]");

            /* Added By Dipali V On 5th Jun 2026 — Return navigation when opened from Bulk Resource Allocation */
            var _BULK_ALLOC_RETURN_URL = 'PM_BulkResAllocation.aspx';

            function _tsGetUrlParams() {
                var params = {};
                var qs = (window.location.search || '').replace(/^\?/, '');
                if (!qs) return params;
                qs.split('&').forEach(function (pair) {
                    var parts = pair.split('=');
                    if (parts[0]) params[decodeURIComponent(parts[0])] = decodeURIComponent(parts[1] || '');
                });
                return params;
            }

            /* Show Back button only when navigated from Bulk Allocation (fromBulkAlloc=1 query string) */
            function initBulkAllocBackButton() {
                var params = _tsGetUrlParams();
                if (params.fromBulkAlloc !== '1') return;
                var btn = document.getElementById('btnBackToBulkAlloc');
                if (btn) btn.style.display = '';
                var projectId = parseInt(params.ProjectID, 10) || 0;
                if (projectId > 0) {
                    var projectDropdown = document.getElementById('ddl_Projects');
                    if (projectDropdown) {
                        projectDropdown.value = String(projectId);
                        selectedProjectID = projectId;
                        if (typeof $ !== 'undefined' && $.fn.selectpicker) {
                            $('.selectpicker').selectpicker('refresh');
                        }
                        if (typeof populateToolsTable === 'function') populateToolsTable(projectId);
                    }
                }
            }

            function backToBulkAllocation() {
                window.location.href = _BULK_ALLOC_RETURN_URL;
            }

            var selectedProjectID;
            var ProjectSkills;
            var ProjectTools;
            var toolParameters;
            var toolOrSkillDetails;
            var toolIDSSelected;
            var skillIDSSelected;

            var hyperLinkedSkillID;
            var hyperLinkedToolID;

            var skillhistory;
            var toolhistory;

            var activeTab;

            var AvailableToolsForProject;
            var AvailableSkillsForProject;

            var skillSubCatID;
            var selectedFilterID;
            var clearFilters = 0;

            var defFilter = 0;
            var basicFilterApplied = 0;
            var basicFilterAppliedOnApplyClick = 0;
            var isFilterCanceled = 0;
            var saveAndApplyFilterName;

            var isDefFilterEnabled = 0;
            var isAppliedFilterBeingEdited = null;
            //Added by Vishal Mane on 05/06/2026 to fix datatable crash issue
            var skillsTableNeedsInit = false;
            //End of Added by Vishal Mane on 05/06/2026 to fix datatable crash issue

            //Function to Set the newly selected projectID from the Master Project Dropdown
            function setSelectedProjectId() {
                var projectDropdown = document.getElementById("ddl_Projects");
                var val = projectDropdown.options[projectDropdown.selectedIndex].value;
                selectedProjectID = val ? val : 1;
            }
            //End of above function

            // Function to populate Tools table
            function populateToolsTable(projectID) {
               
                selectedToolIDsSet.clear();
                toolsTableAllIDs = [];
                if (document.getElementById("toolsSltAll")) { document.getElementById("toolsSltAll").checked = false; }
              
                if (basicFilterAppliedOnApplyClick == 1 && lastAppliedFilterParams) {
                    var toolsTableBody = $('#tools_tbl tbody');
                    var table = $('#tools_tbl');

                    if ($.fn.DataTable.isDataTable(table)) {
                        table.DataTable().destroy();
                    }
                    table.find('tbody').empty();

                    // Use the stored parameters
                    ProjectTools = AJAXCallWithResult("api/PM_ToolsSkill/ApplyFilter", lastAppliedFilterParams, false);

                    toolsTableAllIDs = [];
                    if (ProjectTools && ProjectTools.data && ProjectTools.data.length > 0) {
                        ProjectTools.data.forEach(function (data) {
                            toolsTableAllIDs.push(String(data.projectToolID || ''));
                            var row = '<tr>' +
                                '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" aria-controls="offcanvas_Tools" onclick="handleToolClick(\'' + (data.projectToolID || '') + '\')">' + (data.description || data.parameterName || '') + '</a></td>' +
                                '<td>' + (data.version ? data.version : '') + '</td>' +
                                '<td>' + (data.parameterDesc ? data.parameterDesc : '') + '</td>' +
                                '<td>' +
                                '<span>' +
                                (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                    data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                                '</span>' + (data.status ? data.status : '') +
                                '</td>' +
                                '<td>' + (data.percentageUtilization ? data.percentageUtilization : '') + '</td>' +
                                '<td class="sm-wid">' +
                                '<div class="custom_chckbox">' +
                                '<input id="' + data.projectToolID + '" class="chckHead mainchck" type="checkbox">' +
                                '<label for="' + data.projectToolID + '"></label>' +
                                '</div>' +
                                '</td>' +
                                '</tr>';
                            toolsTableBody.append(row);
                        });
                    } else {
                        appendNoRecordsMessage(toolsTableBody, 6);
                    }

                    $('#tools_tbl').DataTable({
                        "paging": true,
                        "pageLength": 10,
                        "bLengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": false,
                        "retrieve": true,
                        "bAutoWidth": false,
                        "info": false
                    });
                    return;
                }
                if (isFilterCanceled == 1) {
                    var toolsTableBody = $('#tools_tbl tbody');

                    var table = $('#tools_tbl');

                    if ($.fn.DataTable.isDataTable(table)) {
                        table.DataTable().destroy();
                    }

                    table.find('tbody').empty();



                    var Parameter = {
                        ProjId: projectID
                    };

                    // 1. Call the API
                    var response = AJAXCallWithResult("api/PM_ToolsSkill/GetToolsOfProjectsByProjID", Parameter, false);

                    //Access the 'data' array from the response
                    var ProjectTools = response.data || response.Data || [];

                    

                    if (ProjectTools && ProjectTools.length > 0) {
                        ProjectTools.forEach(function (data) {
                            toolsTableAllIDs.push(String(data.projectToolID || ''));
                            var row = '<tr>' +
                                '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" aria-controls="offcanvas_Tools" onclick="handleToolClick(\'' + data.projectToolID + '\')">' + (data.description ||  '') + '</a></td>' +
                                '<td>' + (data.version || '') + '</td>' +                                '<td>' + (data.parameterDesc || '') + '</td>' +
                                '<td>' +
                                '<span>' +
                                (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                    data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                                '</span>' + (data.status || '') +
                                '</td>' +

                                '<td>' + (data.percentageUtilization || '') + '</td>' +

                                '<td class="sm-wid">' +
                                '<div class="custom_chckbox">' +
                                '<input id="' + data.projectToolID + '" class="chckHead mainchck" type="checkbox">' +
                                '<label for="' + data.projectToolID + '"></label>' +
                                '</div>' +
                                '</td>' +
                                '</tr>';
                            toolsTableBody.append(row);
                        });

                    
                    }
                 else {
                        appendNoRecordsMessage(toolsTableBody, 6);
                        return;
                }
                    $('#tools_tbl').DataTable({
                        "paging": true,
                        "pageLength": 10,
                        "bLengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": false,
                        "retrieve": true,
                        "bAutoWidth": false,
                        "info": false,
                        //"language": {
                        //    "emptyTable": "There are no records to view",
                        //    "zeroRecords": "There are no records to view"
                        //}
                    });
                    return;
                }

                if (selectedFilterID != null || selectedFilterID != undefined) {
                    var Parameters = {
                        FilterID: selectedFilterID
                    };
                    var response = AJAXCallWithResult("api/PM_ToolsSkill/GetSelectedFilterParameter", Parameters, false);

                    var whereClause = JSON.parse(response[0].WhereClause);

                    var ApplyFilterParameters = {
                        ProjectIDFF: String(selectedProjectID),
                        ParameterIdFF: String(whereClause.ParameterIdF !== null ? whereClause.ParameterIdF : ""),
                        VersionFF: String(whereClause.VersionF !== null ? whereClause.VersionF : ""),
                        PercentageUtilizationFF: String(whereClause.PercentageUtilizationF !== null ? whereClause.PercentageUtilizationF : ""),
                        IsCustomerSuppliedFF: String(whereClause.IsCustomerSuppliedF !== null ? whereClause.IsCustomerSuppliedF : ""),
                        IsCriticalFF: String(whereClause.IsCriticalF !== null ? whereClause.IsCriticalF : ""),
                        IsProcuredFF: String(whereClause.IsProcuredF !== null ? whereClause.IsProcuredF : ""),
                        BriefDescriptionFF: String(whereClause.BriefDescriptionF !== null ? whereClause.BriefDescriptionF : ""),
                        NumberOfCopiesFF: String(whereClause.NumberOfCopiesF !== null ? whereClause.NumberOfCopiesF : ""),
                        StatusFF: String(whereClause.StatusF !== null ? whereClause.StatusF : ""),
                        PlannedInDateFF: String(whereClause.PlannedInDateF !== null ? whereClause.PlannedInDateF : ""),
                        PlannedOutDateFF: String(whereClause.PlannedOutDateF !== null ? whereClause.PlannedOutDateF : ""),
                        IsSkillFF: "false"
                    };

                    var toolsTableBody = $('#tools_tbl tbody');


                    var table = $('#tools_tbl');

                    if ($.fn.DataTable.isDataTable(table)) {
                        table.DataTable().destroy();
                    }

                    table.find('tbody').empty();




                    var ProjectTools = AJAXCallWithResult("api/PM_ToolsSkill/ApplyFilter", ApplyFilterParameters, false);

                    ProjectTools.data.forEach(function (data) {
                        toolsTableAllIDs.push(String(data.projectToolID ||  ''));
                        var row = '<tr>' +
                            //'<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" aria-controls="offcanvas_Tools" onclick="handleToolClick(\'' + data.ProjectToolID + '\')">' + data.Description + '</a></td>' +

                            '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" aria-controls="offcanvas_Tools" onclick="handleToolClick(\'' + (data.projectToolID || '') + '\')">' + (data.description || data.parameterName || '') + '</a></td>' +


                            '<td>' + (data.version ? data.version : '') + '</td>' +
                            '<td>' + (data.parameterDesc ? data.parameterDesc : '') + '</td>' +
                            '<td>' +
                            '<span>' +
                            (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                            '</span>' + (data.status ? data.status : '') +
                            '</td>' +
                            '<td>' + (data.percentageUtilization ? data.percentageUtilization : '') + '</td>' +
                            '<td class="sm-wid">' +
                            '<div class="custom_chckbox">' +
                            '<input id="' + data.projectToolID + '" class="chckHead mainchck" type="checkbox">' +
                            '<label for="' + data.projectToolID + '"></label>' +
                            '</div>' +
                            '</td>' +
                            '</tr>';
                        toolsTableBody.append(row);
                    });

                    if (ProjectTools.data.length === 0) {
                        appendNoRecordsMessage(toolsTableBody, 6);
                    }

                    $('#tools_tbl').DataTable({
                        "paging": true,
                        "pageLength": 10,
                        "bLengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": false,
                        "retrieve": true,
                        "bAutoWidth": false,
                        "info": false,
                        //"language": {
                        //    "emptyTable": "There are no records to view",
                        //    "zeroRecords": "There are no records to view"
                        //}
                    });
                    return;
                }


                var Parameters = {
                    UserId: UserId,
                    TagID: 35
                };

                var response = AJAXCallWithResult("api/PM_ToolsSkill/GetDefaultFilterParameter", Parameters, false);

                if (response && response.length > 0 && clearFilters == 0) {
                    isDefFilterEnabled = 1;
                    var whereClause = JSON.parse(response[0].WhereClause);

                    if (whereClause != null) {

                        var ApplyFilterParameters = {
                            ProjectIDFF: String(projectID),
                            ParameterIdFF: String(whereClause.ParameterIdF !== null ? whereClause.ParameterIdF : ""),
                            VersionFF: String(whereClause.VersionF !== null ? whereClause.VersionF : ""),
                            PercentageUtilizationFF: String(whereClause.PercentageUtilizationF !== null ? whereClause.PercentageUtilizationF : ""),
                            IsCustomerSuppliedFF: String(whereClause.IsCustomerSuppliedF !== null ? whereClause.IsCustomerSuppliedF : ""),
                            IsCriticalFF: String(whereClause.IsCriticalF !== null ? whereClause.IsCriticalF : ""),
                            IsProcuredFF: String(whereClause.IsProcuredF !== null ? whereClause.IsProcuredF : ""),
                            BriefDescriptionFF: String(whereClause.BriefDescriptionF !== null ? whereClause.BriefDescriptionF : ""),
                            NumberOfCopiesFF: String(whereClause.NumberOfCopiesF !== null ? whereClause.NumberOfCopiesF : ""),
                            StatusFF: String(whereClause.StatusF !== null ? whereClause.StatusF : ""),
                            PlannedInDateFF: String(whereClause.PlannedInDateF !== null ? whereClause.PlannedInDateF : ""),
                            PlannedOutDateFF: String(whereClause.PlannedOutDateF !== null ? whereClause.PlannedOutDateF : ""),
                            IsSkillFF: "false"
                        };


                        ProjectTool = AJAXCallWithResult("api/PM_ToolsSkill/ApplyFilter", ApplyFilterParameters, false);

                        if (ProjectTool && ProjectTool.data.length > 0) {
                            var toolsTableBody = $('#tools_tbl tbody');

                            //if ($.fn.DataTable.isDataTable('#tools_tbl')) {
                            //    $('#tools_tbl').DataTable().clear().destroy();
                            //}
                            //toolsTableBody.empty();

                            var table = $('#tools_tbl');

                            if ($.fn.DataTable.isDataTable(table)) {
                                table.DataTable().destroy();
                            }

                            table.find('tbody').empty();
                            toolsTableAllIDs = [];
                            ProjectTool.data.forEach(function (data) {
                                toolsTableAllIDs.push(String(data.projectToolID || data.toolID || ''));
                                var row = '<tr>' +
                                    //'<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" aria-controls="offcanvas_Tools" onclick="handleToolClick(\'' + data.ProjectToolID + '\')">' + data.Description + '</a></td>' +

                                    '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" aria-controls="offcanvas_Tools" onclick="handleToolClick(\'' + (data.projectToolID || data.toolID) + '\')">' + (data.description || data.parameterName || '') + '</a></td>' +


                                    '<td>' + (data.version ? data.version : '') + '</td>' +
                                    '<td>' + (data.parameterDesc ? data.parameterDesc : '') + '</td>' +
                                    '<td>' +
                                    '<span>' +
                                    (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                        data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                                    '</span>' + (data.status ? data.status : '') +
                                    '</td>' +
                                    '<td>' + (data.percentageUtilization ? data.percentageUtilization : '') + '</td>' +
                                    '<td class="sm-wid">' +
                                    '<div class="custom_chckbox">' +
                                    '<input id="' + data.projectToolID + '" class="chckHead mainchck" type="checkbox">' +
                                    '<label for="' + data.projectToolID + '"></label>' +
                                    '</div>' +
                                    '</td>' +
                                    '</tr>';
                                toolsTableBody.append(row);
                            });

                            if (ProjectTool.data.length === 0) {
                                appendNoRecordsMessage(toolsTableBody, 6);
                            }


                            $('#tools_tbl').DataTable({
                                "paging": true,
                                "pageLength": 10,
                                "bLengthChange": false,
                                "bFilter": false,
                                "ordering": false,
                                "responsive": true,
                                "destroy": false,
                                "retrieve": true,
                                "bAutoWidth": false,
                                "info": false,
                                //"language": {
                                //    "emptyTable": "There are no records to view",
                                //    "zeroRecords": "There are no records to view"
                                //}
                            });
                            toggleClearAllSpan(isDefFilterEnabled);
                        } else {

                            //console.error('ProjectTool response is invalid or empty');
                            appendNoRecordsMessage(toolsTableBody, 6);
                        }
                    } else {
                        console.error('Parsed WhereClause is null');
                    }
                } else {
                    toggleClearAllSpan(isDefFilterEnabled);
                    var toolsTableBody = $('#tools_tbl tbody');

                    //if ($.fn.DataTable.isDataTable('#tools_tbl')) {
                    //    $('#tools_tbl').DataTable().clear().destroy();
                    //}
                    //toolsTableBody.empty();

                    var table = $('#tools_tbl');

                    if ($.fn.DataTable.isDataTable(table)) {
                        table.DataTable().destroy();
                    }

                    table.find('tbody').empty();



                    var Parameter = {
                        ProjId: projectID
                    };
                    var ProjectTools = AJAXCallWithResult("api/PM_ToolsSkill/GetToolsOfProjectsByProjID", Parameter, false);

                    if (ProjectTools && ProjectTools.data.length > 0) {
                        ProjectTools.data.forEach(function (data) {
                            toolsTableAllIDs.push(String(data.projectToolID || data.toolID || ''));
                            var row = '<tr>' +
                                // Use data.toolID as the ID
                                '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" aria-controls="offcanvas_Tools" onclick="handleToolClick(\'' + (data.projectToolID || data.toolID) + '\')">' + (data.description || data.Description || '') + '</a></td>' +
                                // These fields are missing in your JSON, so they will show empty unless the API returns them
                                '<td>' + (data.version || data.Version || '') + '</td>' +
                                '<td>' + (data.parameterDesc || data.ParameterDesc || '') + '</td>' +
                                '<td>' +
                                '<span>' +
                                (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                    data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                                '</span>' + (data.status || data.Status || '') +
                                '</td>' +
                                '<td>' + (data.percentageUtilization || data.PercentageUtilization || '') + '</td>' +
                                '<td class="sm-wid">' +
                                '<div class="custom_chckbox">' +
                                // Use data.toolID for the checkbox ID
                                //'<input id="' + (data.toolID || data.ToolId) + '" class="chckHead mainchck" type="checkbox">' +
                                //'<label for="' + (data.toolID || data.ToolId) + '"></label>' +
                            
                                '<input id="' + data.projectToolID + '" class="chckHead mainchck" type="checkbox">' +
                                '<label for="' + data.projectToolID + '"></label>' +
                               


                                '</div>' +
                                '</td>' +
                                '</tr>';
                            toolsTableBody.append(row);
                        });
                        if (ProjectTools.data.length === 0) {
                            appendNoRecordsMessage(toolsTableBody, 6);
                        }


                        $('#tools_tbl').DataTable({
                            "paging": true,
                            "pageLength": 10,
                            "bLengthChange": false,
                            "bFilter": false,
                            "ordering": false,
                            "responsive": true,
                            "destroy": false,
                            "retrieve": true,
                            "bAutoWidth": false,
                            "info": false,
                            //"language": {
                            //    "emptyTable": "There are no records to view",
                            //    "zeroRecords": "There are no records to view"
                            //}
                        });
                    } else {
                        /* console.error('ProjectTools response is invalid or empty');*/
                        //if (toolsTableBody.find('tr').length === 0) {
                        //    appendNoRecordsMessage(toolsTableBody, 7);
                        //}
                        if (ProjectTools.data.length === 0) {
                            appendNoRecordsMessage(toolsTableBody, 6);
                        }
                    }
                }


                console.log("reached end");
            }
            //End of above function

            // Pagination UI - match Releases/Lessons Learnt (Total Records + Prev/Next)
            function updateToolsPaginationUI() {
                var el = document.getElementById('toolsTotalRecords');
                var prevBtn = document.getElementById('toolsFirstPageBtn');
                var nextBtn = document.getElementById('toolsLastPageBtn');
                if (!el || !prevBtn || !nextBtn) return;
                if (!$.fn.DataTable.isDataTable('#tools_tbl')) {
                    el.textContent = 'Total Records: 0';
                    prevBtn.disabled = true;
                    nextBtn.disabled = true;
                    return;
                }
                var info = $('#tools_tbl').DataTable().page.info();
                var total = info.recordsTotal || 0;
                el.textContent = 'Total Records: ' + total;
                prevBtn.disabled = info.page <= 0 || total === 0;
                nextBtn.disabled = info.pages <= 1 || info.page >= info.pages - 1 || total === 0;
            }
            function updateSkillsPaginationUI() {
                var el = document.getElementById('skillsTotalRecords');
                var prevBtn = document.getElementById('skillsFirstPageBtn');
                var nextBtn = document.getElementById('skillsLastPageBtn');
                if (!el || !prevBtn || !nextBtn) return;
                if (!$.fn.DataTable.isDataTable('#skills_tbl')) {
                    el.textContent = 'Total Records: 0';
                    prevBtn.disabled = true;
                    nextBtn.disabled = true;
                    return;
                }
                var info = $('#skills_tbl').DataTable().page.info();
                var total = info.recordsTotal || 0;
                el.textContent = 'Total Records: ' + total;
                prevBtn.disabled = info.page <= 0 || total === 0;
                nextBtn.disabled = info.pages <= 1 || info.page >= info.pages - 1 || total === 0;
            }

            // Generic pagination UI for History + Selection modal tables (same as main list)
            function updateTablePaginationUI(tableSelector, totalElId, prevBtnId, nextBtnId) {
                var el = document.getElementById(totalElId);
                var prevBtn = document.getElementById(prevBtnId);
                var nextBtn = document.getElementById(nextBtnId);
                if (!el || !prevBtn || !nextBtn) return;
                if (!$.fn.DataTable.isDataTable(tableSelector)) {
                    el.textContent = 'Total Records: 0';
                    prevBtn.disabled = true;
                    nextBtn.disabled = true;
                    return;
                }
                var info = $(tableSelector).DataTable().page.info();
                var total = info.recordsTotal || 0;
                el.textContent = 'Total Records: ' + total;
                prevBtn.disabled = info.page <= 0 || total === 0;
                nextBtn.disabled = info.pages <= 1 || info.page >= info.pages - 1 || total === 0;
            }
            function updateToolsHistoryPaginationUI() { updateTablePaginationUI('#Tools_Show_History_Tbl', 'toolsHistoryTotalRecords', 'toolsHistoryFirstPageBtn', 'toolsHistoryLastPageBtn'); }
            function updateSkillsHistoryPaginationUI() { updateTablePaginationUI('#Skills_Show_History_Tbl', 'skillsHistoryTotalRecords', 'skillsHistoryFirstPageBtn', 'skillsHistoryLastPageBtn'); }
            function updateToolsSelectionPaginationUI() { updateTablePaginationUI('#tools_selectio_Tbl', 'toolsSelectionTotalRecords', 'toolsSelectionFirstPageBtn', 'toolsSelectionLastPageBtn'); }
            function updateSkillsSelectionPaginationUI() { updateTablePaginationUI('#skill_selectio_Tbl', 'skillsSelectionTotalRecords', 'skillsSelectionFirstPageBtn', 'skillsSelectionLastPageBtn'); }

            //Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
            function isSkillsTabActive() {
                return $('a[href="#Tab_skills_trend"].nav-link').hasClass('active');
            }

            function getSkillsDataArray(apiResponse) {
                if (!apiResponse) {
                    return [];
                }
                if (Array.isArray(apiResponse)) {
                    return apiResponse;
                }
                if (Array.isArray(apiResponse.data)) {
                    return apiResponse.data;
                }
                if (Array.isArray(apiResponse.Data)) {
                    return apiResponse.Data;
                }
                return [];
            }

            function removeSkillsColspanRows() {
                $('#skills_tbl tbody tr').each(function () {
                    if ($(this).find('td[colspan]').length > 0) {
                        $(this).remove();
                    }
                });
            }
            //End of Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue

            // Helper function to safely initialize DataTables on skills_tbl only if tab is visible
            function initializeSkillsDataTable() {
                var skillsTable = $('#skills_tbl');

                if (skillsTable.length === 0) {
                    return false;
                }

                //Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                if (!isSkillsTabActive()) {
                    skillsTableNeedsInit = true;
                    return false;
                }
                skillsTableNeedsInit = false;
                removeSkillsColspanRows();
                //End of Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue

                if ($.fn.DataTable.isDataTable('#skills_tbl')) {
                    return true;
                }

                var tbody = skillsTable.find('tbody');
                var thead = skillsTable.find('thead');
                if (tbody.length === 0 || thead.length === 0) {
                    console.warn('Skills table missing tbody or thead');
                    return false;
                }

                try {
                    skillsTable.DataTable({
                        "paging": true,
                        "pageLength": 10,
                        "bLengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": false,
                        "destroy": true,
                        "bAutoWidth": false,
                        "info": false,
                        "language": {
                            "emptyTable": "<%=MyBase.GetResourceString("C_NoRecordsToView")%>",
                            "zeroRecords": "<%=MyBase.GetResourceString("C_NoRecordsToView")%>"
                        }
                    });
                    return true;
                } catch (e) {
                    console.error('Error initializing Skills DataTable:', e);
                    return false;
                }
            }

            //Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
            function resetSkillsTableBody() {
                var skillsTableBody = $('#skills_tbl tbody');
                if ($.fn.DataTable.isDataTable('#skills_tbl')) {
                    $('#skills_tbl').DataTable().clear().destroy();
                }
                skillsTableBody.empty();
                skillsTableAllIDs = [];
            }

            function showSkillsTableNoRecords() {
                resetSkillsTableBody();
                initializeSkillsDataTable();
            }
            //End of Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
            // Add this JavaScript after your existing datepicker initialization
            $(document).on('click', '.btncalendar', function () {
                $(this).closest('.datefielddiv').find('input[type="Textbox"]').datepicker('show');
            });
            // Function to populate Skills table
            function populateSkillsTable(projectID) {
               
                selectedSkillIDsSet.clear();
                skillsTableAllIDs = [];
                if (document.getElementById("Skills_checkAll")) { document.getElementById("Skills_checkAll").checked = false; }
                if (basicFilterAppliedOnApplyClick == 1) {

                    var ProjectID = selectedProjectID;
                    if (ProjectID == 0) {
                        ProjectID = null;
                    }
                    var ParameterId = document.getElementById('txtFilter_usage').value || null;
                    var Version = document.getElementById('txt_filter_version').value || null;
                    var PercentageUtilization = document.getElementById('txt_filter_util').value || null;
                    var IsCustomerSupplied = document.getElementById('supplied_cust_filter').value || null;
                    var IsCritical = document.getElementById('filter_critical').value || null;
                    var IsProcured = document.getElementById('filter_procured').value || null;
                    var BriefDescription = document.getElementById('txt_desc').value || null;
                    var NumberOfCopies = document.getElementById('txt_copies').value || null;
                    var Status = document.getElementById('txt_filter_status').value || null;
                    var PlannedInDate = $('#Planned_indate').datepicker('getDate') ? formatDateToYMD($('#Planned_indate').datepicker('getDate')) : null;
                    var PlannedOutDate = $('#Planned_out_date').datepicker('getDate') ? formatDateToYMD($('#Planned_out_date').datepicker('getDate')) : null;

                    checkActiveTab();
                        var Parameters = {
                            ProjectIDFF: String(ProjectID),
                            ParameterIdFF: String(ParameterId !== null ? ParameterId : ""),
                            VersionFF: String(Version !== null ? Version : ""),
                            PercentageUtilizationFF: String(PercentageUtilization !== null ? PercentageUtilization : ""),
                            IsCustomerSuppliedFF: String(IsCustomerSupplied !== null ? IsCustomerSupplied : ""),
                            IsCriticalFF: String(IsCritical !== null ? IsCritical : ""),
                            IsProcuredFF: String(IsProcured !== null ? IsProcured : ""),
                            BriefDescriptionFF: String(BriefDescription !== null ? BriefDescription : ""),
                            NumberOfCopiesFF: String(NumberOfCopies !== null ? NumberOfCopies : ""),
                            StatusFF: String(Status !== null ? Status : ""),
                            PlannedInDateFF: String(PlannedInDate !== null ? PlannedInDate : ""),
                            PlannedOutDateFF: String(PlannedOutDate !== null ? PlannedOutDate : ""),
                            IsSkillFF: "true"
                        };

                        ProjectSkills = AJAXCallWithResult("api/PM_ToolsSkill/ApplyFilter", Parameters, false);

                        var skillsTableBody = $('#skills_tbl tbody');
                        var skillsData = getSkillsDataArray(ProjectSkills);

                        //Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                        if (skillsData.length === 0) {
                            showSkillsTableNoRecords();
                            return;
                        }
                        //End of Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue

                        if ($.fn.DataTable.isDataTable('#skills_tbl')) {
                            $('#skills_tbl').DataTable().clear().destroy();
                        }

                        skillsTableBody.empty();
                        skillsTableAllIDs = [];
                        skillsData.forEach(function (data) {
                            skillsTableAllIDs.push(String(data.projectToolID || data.projectToolID || ''));
                            var row = '<tr>' +
                       
                                '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" aria-controls="offcanvas_Tools" onclick="handleToolClick(\'' + data.projectToolID + '\')">' + (data.description ||  '') + '</a></td>' +

                                '<td>' + (data.version ? data.version : '') + '</td>' +
                                '<td>' + (data.parameterDesc ? data.parameterDesc : '') + '</td>' +
                                '<td>' +
                                '<span>' +
                                (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                    data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                                '</span>' + (data.status ? data.status : '') +
                                '</td>' +
                                '<td>' + (data.percentageUtilization ? data.percentageUtilization : '') + '</td>' +
                                '<td class="sm-wid">' +
                                '<div class="custom_chckbox">' +
                                '<input id="' + data.projectToolID + '" class="chckHead main_Skills" type="checkbox">' +
                                '<label for="' + data.projectToolID + '"></label>' +
                                '</div>' +
                                '</td>' +
                                '</tr>';
                            skillsTableBody.append(row);
                        });

                        // Use helper function to safely initialize DataTable
                        initializeSkillsDataTable();

                    //availableFiltersForUser();
                    return;
                }

                if ( isFilterCanceled == 1) {

                    var Parameter = {
                        ProjId: projectID
                    };

                    //var ProjectSkills = AJAXCallWithResult("api/PM_ToolsSkill/GetSkillsOfProjectsByProjID", Parameter, false);


                    // 1. Call the API
                    var response = AJAXCallWithResult("api/PM_ToolsSkill/GetSkillsOfProjectsByProjID", Parameter, false);

                    var skillsData = getSkillsDataArray(response);

                    //Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                    if (skillsData.length === 0) {
                        showSkillsTableNoRecords();
                        return;
                    }
                    //End of Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue

                    if (skillsData && Array.isArray(skillsData)) {
                        var skillsTableBody = $('#skills_tbl tbody');

                        if ($.fn.DataTable.isDataTable('#skills_tbl')) {
                            $('#skills_tbl').DataTable().clear().destroy();
                        }

                        skillsTableBody.empty();
                        skillsTableAllIDs = [];
                        skillsData.forEach(function (data) {
                            skillsTableAllIDs.push(String(data.projectToolID || ''));
                            var row = '<tr>' +
                                
                                '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Skills" aria-controls="offcanvas_Skills" onclick="handleSkillClick(\'' + data.projectToolID + '\')">' + (data.description || '') + '</a></td>' +

                               
                                '<td>' + (data.version || '') + '</td>' +

                               
                                '<td>' + (data.parameterDesc || '') + '</td>' +

                                '<td>' +
                                '<span>' +
                               
                                (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                    data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                                '</span>' + (data.status || '') +
                                '</td>' +

                               
                                '<td>' + (data.percentageUtilization || '') + '</td>' +

                                '<td class="sm-wid">' +
                                '<div class="custom_chckbox">' +

                                
                                '<input id="' + data.projectToolID + '" class="chckHead main_Skills" type="checkbox">' +
                                '<label for="' + data.projectToolID + '"></label>' +

                                '</div>' +
                                '</td>' +
                                '</tr>';
                            skillsTableBody.append(row);
                        });

                        initializeSkillsDataTable();
                    } else {
                        showSkillsTableNoRecords();
                    }
                    return;
                }

                if (selectedFilterID != null || selectedFilterID != undefined) {

                    var Parameters = {
                        FilterID: selectedFilterID
                    };
                    var response = AJAXCallWithResult("api/PM_ToolsSkill/GetSelectedFilterParameter", Parameters, false);

                    var whereClause = JSON.parse(response[0].WhereClause);

                    var ApplyFilterParameters = {
                        ProjectIDFF: String(selectedProjectID),
                        ParameterIdFF: String(whereClause.ParameterIdF !== null ? whereClause.ParameterIdF : ""),
                        VersionFF: String(whereClause.VersionF !== null ? whereClause.VersionF : ""),
                        PercentageUtilizationFF: String(whereClause.PercentageUtilizationF !== null ? whereClause.PercentageUtilizationF : ""),
                        IsCustomerSuppliedFF: String(whereClause.IsCustomerSuppliedF !== null ? whereClause.IsCustomerSuppliedF : ""),
                        IsCriticalFF: String(whereClause.IsCriticalF !== null ? whereClause.IsCriticalF : ""),
                        IsProcuredFF: String(whereClause.IsProcuredF !== null ? whereClause.IsProcuredF : ""),
                        BriefDescriptionFF: String(whereClause.BriefDescriptionF !== null ? whereClause.BriefDescriptionF : ""),
                        NumberOfCopiesFF: String(whereClause.NumberOfCopiesF !== null ? whereClause.NumberOfCopiesF : ""),
                        StatusFF: String(whereClause.StatusF !== null ? whereClause.StatusF : ""),
                        PlannedInDateFF: String(whereClause.PlannedInDateF !== null ? whereClause.PlannedInDateF : ""),
                        PlannedOutDateFF: String(whereClause.PlannedOutDateF !== null ? whereClause.PlannedOutDateF : ""),
                        IsSkillFF: "true"
                    };

                    var ProjectSkills = AJAXCallWithResult("api/PM_ToolsSkill/ApplyFilter", ApplyFilterParameters, false);
                    var skillsData = getSkillsDataArray(ProjectSkills);

                    //Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                    if (skillsData.length === 0) {
                        showSkillsTableNoRecords();
                        return;
                    }
                    //End of Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue

                    var skillsTableBody = $('#skills_tbl tbody');

                    if ($.fn.DataTable.isDataTable('#skills_tbl')) {
                        $('#skills_tbl').DataTable().clear().destroy();
                    }

                    skillsTableBody.empty();
                    skillsTableAllIDs = [];
                    skillsData.forEach(function (data) {
                        skillsTableAllIDs.push(String( data.projectToolID || data.projectToolID || ''));
                        var row = '<tr>' +
                            '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Skills" aria-controls="offcanvas_Skills" onclick="handleSkillClick(\'' + data.projectToolID + '\')">' + (data.description || '') + '</a></td>' +
                            '<td>' + (data.version ? data.version : '') + '</td>' +
                            '<td>' + (data.parameterDesc ? data.parameterDesc : '') + '</td>' +
                            '<td>' +
                            '<span>' +
                            (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                            '</span>' + (data.status ? data.status : '') +
                            '</td>' +
                            '<td>' + (data.percentageUtilization ? data.percentageUtilization : '') + '</td>' +
                            '<td class="sm-wid">' +
                            '<div class="custom_chckbox">' +
                            '<input id="' + data.projectToolID + '" class="chckHead main_Skills" type="checkbox">' +
                            '<label for="' + data.projectToolID + '"></label>' +
                            '</div>' +
                            '</td>' +
                            '</tr>';
                        skillsTableBody.append(row);
                    });
                    initializeSkillsDataTable();
                   
                    return;
                }

                var Parameters = {
                    UserId: UserId,
                    TagID: 35
                };

                var response = AJAXCallWithResult("api/PM_ToolsSkill/GetDefaultFilterParameter", Parameters, false);

                if (response && response.data.length > 0 && clearFilters == 0) {
                    isDefFilterEnabled = 1;
                    var whereClause = JSON.parse(response[0].WhereClause);

                    if (whereClause != null) {

                        var ApplyFilterParameters = {
                            ProjectIDFF: String(projectID),
                            ParameterIdFF: String(whereClause.ParameterIdF !== null ? whereClause.ParameterIdF : ""),
                            VersionFF: String(whereClause.VersionF !== null ? whereClause.VersionF : ""),
                            PercentageUtilizationFF: String(whereClause.PercentageUtilizationF !== null ? whereClause.PercentageUtilizationF : ""),
                            IsCustomerSuppliedFF: String(whereClause.IsCustomerSuppliedF !== null ? whereClause.IsCustomerSuppliedF : ""),
                            IsCriticalFF: String(whereClause.IsCriticalF !== null ? whereClause.IsCriticalF : ""),
                            IsProcuredFF: String(whereClause.IsProcuredF !== null ? whereClause.IsProcuredF : ""),
                            BriefDescriptionFF: String(whereClause.BriefDescriptionF !== null ? whereClause.BriefDescriptionF : ""),
                            NumberOfCopiesFF: String(whereClause.NumberOfCopiesF !== null ? whereClause.NumberOfCopiesF : ""),
                            StatusFF: String(whereClause.StatusF !== null ? whereClause.StatusF : ""),
                            PlannedInDateFF: String(whereClause.PlannedInDateF !== null ? whereClause.PlannedInDateF : ""),
                            PlannedOutDateFF: String(whereClause.PlannedOutDateF !== null ? whereClause.PlannedOutDateF : ""),
                            IsSkillFF: "true"
                        };


                        var ProjectSkills = AJAXCallWithResult("api/PM_ToolsSkill/ApplyFilter", ApplyFilterParameters, false);
                        var skillsData = getSkillsDataArray(ProjectSkills);

                        //Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                        if (skillsData.length === 0) {
                            showSkillsTableNoRecords();
                            return;
                        }
                        //End of Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue

                        var skillsTableBody = $('#skills_tbl tbody');

                        if ($.fn.DataTable.isDataTable('#skills_tbl')) {
                            $('#skills_tbl').DataTable().clear().destroy();
                        }

                        skillsTableBody.empty();
                        skillsTableAllIDs = [];
                        skillsData.forEach(function (data) {
                            skillsTableAllIDs.push(String( data.projectToolID || ''));
                            var row = '<tr>' +
                                '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Skills" aria-controls="offcanvas_Skills" onclick="handleSkillClick(\'' + data.projectToolID + '\')">' + (data.description || data.parameterName || '') + '</a></td>' +
                                '<td>' + (data.version || '') + '</td>' +
                                '<td>' + (data.parameterDesc || '') + '</td>' +
                                '<td>' +
                                '<span>' +
                                (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                    data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                                '</span>' + (data.status || '') +
                                '</td>' +
                                '<td>' + (data.percentageUtilization || '') + '</td>' +
                                '<td class="sm-wid">' +
                                '<div class="custom_chckbox">' +
                                '<input id="' + data.projectToolID + '" class="chckHead main_Skills" type="checkbox">' +
                                '<label for="' + data.projectToolID + '"></label>' +
                                '</div>' +
                                '</td>' +
                                '</tr>';
                            skillsTableBody.append(row);
                        });

                        initializeSkillsDataTable();
                    } else {
                        console.error('Parsed WhereClause is null');
                    }
                } else {
                    //console.warn("Invalid response from GetDefaultFilterParameter. Falling back to GetSkillsOfProjectsByProjID.");
                    toggleClearAllSpan(isDefFilterEnabled);
                    var Parameter = {
                        ProjId: projectID
                    };
                    var RespProjectSkills = AJAXCallWithResult("api/PM_ToolsSkill/GetSkillsOfProjectsByProjID", Parameter, false);
                    var skillsData = getSkillsDataArray(RespProjectSkills);

                    //Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                    if (skillsData.length === 0) {
                        showSkillsTableNoRecords();
                        return;
                    }
                    //End of Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue

                    if (skillsData && Array.isArray(skillsData)) {
                        var skillsTableBody = $('#skills_tbl tbody');

                        if ($.fn.DataTable.isDataTable('#skills_tbl')) {
                            $('#skills_tbl').DataTable().clear().destroy();
                        }

                        skillsTableBody.empty();
                        skillsTableAllIDs = [];
                        skillsData.forEach(function (data) {
                            skillsTableAllIDs.push(String( data.projectToolID || data.projectToolID || ''));
                            var row = '<tr>' +
                                '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Skills" aria-controls="offcanvas_Skills" onclick="handleSkillClick(\'' + data.projectToolID + '\')">' + (data.description || '') + '</a></td>' +
                                '<td>' + (data.version || '') + '</td>' +
                                '<td>' + (data.parameterDesc || '') + '</td>' +
                                '<td>' +
                                '<span>' +
                                (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                    data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                                '</span>' + (data.status || '') +
                                '</td>' +
                                '<td>' + (data.percentageUtilization || '') + '</td>' +
                                '<td class="sm-wid">' +
                                '<div class="custom_chckbox">' +
                                '<input id="' + data.projectToolID + '" class="chckHead main_Skills" type="checkbox">' +
                                '<label for="' + data.projectToolID + '"></label>' +
                                '</div>' +
                                '</td>' +
                                '</tr>';
                            skillsTableBody.append(row);
                        });
                        // Use helper function to safely initialize DataTable
                        initializeSkillsDataTable();
                    } else {
                        //Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                        showSkillsTableNoRecords();
                        //End of Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                    }
                }
            }
            //End of above function

            //Function to Populate Tabs When the Dropdown Value Changes
            function GetProjectSkillORToolDetails() {
                setSelectedProjectId();
                populateToolsTable(selectedProjectID);
                
                // Only populate Skills table if Skills tab is active
                if (isSkillsTabActive()) {
                    populateSkillsTable(selectedProjectID);
                } else {
                    skillsTableNeedsInit = true;
                }
            }
            //End of above function

            //Function to get Tools Parameter 
            function getToolParameterForUtilizatioDropdown() {
                toolParameters = AJAXCallWithResult("api/PM_ToolsSkill/GetToolParameterForUsageParameter", null, false);
            }
            //End of above function

           
            //Function To Process Data On Offcanvas Trigger
            function handleSkillClick(ToolOrSkillID) {
                hyperLinkedSkillID = ToolOrSkillID;
                document.getElementById('skillCancelBtn').click();

                var Parameter = {
                    ProjToolID: ToolOrSkillID
                };

                var response = AJAXCallWithResult("api/PM_ToolsSkill/GetSkillsOrToolsDetailOfProjectsByProjToolID", Parameter, false);

               
                toolOrSkillDetails = response.data || response.Data || response;

                if (Array.isArray(toolOrSkillDetails) && toolOrSkillDetails.length > 0) {
                    var firstDetail = toolOrSkillDetails[0];

                    // FIX 2: Use camelCase property names
                    var skillDescriptionInput = document.getElementById('skillDescription');
                    if (skillDescriptionInput) {
                        skillDescriptionInput.value = firstDetail.description || firstDetail.parameterName || '';
                    }

                    var skillVersionInput = document.getElementById('skillVersion');
                    if (skillVersionInput) {
                        skillVersionInput.value = firstDetail.version || '';
                    }

                    var skillPercentageUtilizationInput = document.getElementById('skillPercentageUtilization');
                    if (skillPercentageUtilizationInput) {
                        skillPercentageUtilizationInput.value = (firstDetail.percentageUtilization !== null) ? firstDetail.percentageUtilization : '';
                    }

                    var skillNumberOfCopiesInput = document.getElementById('skillNumberOfCopies');
                    if (skillNumberOfCopiesInput) {
                        skillNumberOfCopiesInput.value = (firstDetail.numberOfCopies !== null) ? firstDetail.numberOfCopies : '';
                    }

                    var skillBriefDescriptionInput = document.getElementById('skillBriefDescription');
                    if (skillBriefDescriptionInput) {
                        skillBriefDescriptionInput.value = firstDetail.briefDescription || '';
                    }

                    var skillUsageDropdown = document.getElementById('skillUsage');
                    if (skillUsageDropdown) {
                        skillUsageDropdown.selectedIndex = 0;
                        
                        var parameterDesc = firstDetail.parameterDesc || '';
                        if (parameterDesc) {
                            for (var i = 0; i < skillUsageDropdown.options.length; i++) {
                                if (skillUsageDropdown.options[i].text === parameterDesc) {
                                    skillUsageDropdown.selectedIndex = i;
                                    break;
                                }
                            }
                        }
                        $('.selectpicker').selectpicker('refresh');
                    }

                    // FIX 4: Use 'status'
                    var statusDropdown = document.getElementById('skillStatus');
                    if (statusDropdown) {
                        statusDropdown.value = '';
                        if (firstDetail.status === "Available") {
                            statusDropdown.value = "Available";
                        } else if (firstDetail.status === "Not Available") {
                            statusDropdown.value = "Not Available";
                        }
                        $('.selectpicker').selectpicker('refresh');
                    }

                    // FIX 5: Use 'plannedInDate' and 'plannedOutDate'
                    var plannedInDate = formatDate(firstDetail.plannedInDate);
                    var plannedOutDate = formatDate(firstDetail.plannedOutDate);

              


                    if ($('#plannedDateModalForSkill').length > 0) {
                        $('#plannedDateModalForSkill').datepicker('setDate', plannedInDate);
                    }
                    if ($('#plannedOutDateModalForSkill').length > 0) {
                        $('#plannedOutDateModalForSkill').datepicker('setDate', plannedOutDate);
                    }

                    // FIX 6: Use 'isCustomerSupplied', 'isCritical', 'isProcured'
                    var checkboxCustomerSupplied = document.getElementById('skillIsCustomerSupplied');
                    if (checkboxCustomerSupplied) {
                        checkboxCustomerSupplied.checked = !!firstDetail.isCustomerSupplied;
                    }

                    var checkboxIsCritical = document.getElementById('skillIsCritical');
                    if (checkboxIsCritical) {
                        checkboxIsCritical.checked = !!firstDetail.isCritical;
                    }

                    var checkboxIsProcured = document.getElementById('skillIsProcured');
                    if (checkboxIsProcured) {
                        checkboxIsProcured.checked = !!firstDetail.isProcured;
                    }
                }
            }



            //End of above function

            //Function to handle Tool Hyperlink click
           
            function handleToolClick(ToolOrSkillID) {
                

                hyperLinkedToolID = ToolOrSkillID;

                document.getElementById('toolCancelBtn').click();

                var Parameter = {
                    ProjToolID: ToolOrSkillID
                };

                var response = AJAXCallWithResult("api/PM_ToolsSkill/GetSkillsOrToolsDetailOfProjectsByProjToolID", Parameter, false);
                
                // Extract the array from the 'data' property
                 toolOrSkillDetails = response.data || response.Data || response;

                if (Array.isArray(toolOrSkillDetails) && toolOrSkillDetails.length > 0) {
                    var firstDetail = toolOrSkillDetails[0];

                    document.getElementById('toolDescription').value = firstDetail.description || firstDetail.description || '';

                    document.getElementById('toolVersion').value = firstDetail.version || '';
                    document.getElementById('toolPercentageUtilization').value = (firstDetail.percentageUtilization !== null) ? firstDetail.percentageUtilization : '';
                    document.getElementById('toolNumberOfCopies').value = (firstDetail.numberOfCopies !== null) ? firstDetail.numberOfCopies : '';
                    document.getElementById('toolBriefDescription').value = firstDetail.briefDescription || '';

                    var skillUsageDropdown = document.getElementById('toolUsage');

                    // Reset dropdown
                    skillUsageDropdown.selectedIndex = 0;

                   
                    var parameterDesc = firstDetail.parameterDesc || '';

                    if (parameterDesc) {
                        for (var i = 0; i < skillUsageDropdown.options.length; i++) {
                            if (skillUsageDropdown.options[i].text === parameterDesc) {
                                skillUsageDropdown.selectedIndex = i;
                                break;
                            }
                        }
                    }



                   
                    var statusDropdown = document.getElementById('toolStatus');
                    statusDropdown.value = '';
                    if (firstDetail.status === "Available") {
                        statusDropdown.value = "Available";
                    } else if (firstDetail.status === "Not Available") {
                        statusDropdown.value = "Not Available";
                    }
                    $('.selectpicker').selectpicker('refresh');

               
                    var plannedInDate = formatDate(firstDetail.plannedInDate);
                    var plannedOutDate = formatDate(firstDetail.plannedOutDate);
                    $('#plannedDateModalForTool').datepicker('setDate', plannedInDate);
                    $('#plannedOutDateModalForTool').datepicker('setDate', plannedOutDate);

                    
                    var checkboxCustomerSupplied = document.getElementById('toolIsCustomerSupplied');
                    checkboxCustomerSupplied.checked = !!firstDetail.isCustomerSupplied;

                    var checkboxIsCritical = document.getElementById('toolIsCritical');
                    checkboxIsCritical.checked = !!firstDetail.isCritical;

                    var checkboxIsProcured = document.getElementById('toolIsProcured');
                    checkboxIsProcured.checked = !!firstDetail.isProcured;
                }
            }
            //End of above function

            //Function to handle cancel functionaity on History
            $("#toolCancelBtn, #skillCancelBtn").on("click", function () {
                $(".Resourcedetailpanel").hide();
            });
             //End of above function

            //Function to format date for the dropown 
            function formatDate(dateString) {
                if (!dateString) return '';
                var date = new Date(dateString);
                var day = date.getDate().toString().padStart(2, '0');
                var month = date.toLocaleString('default', { month: 'short' });
                var year = date.getFullYear();
                return `${day} ${month} ${year}`;
            }
            //End of above function

            //Function to pass date properly during updation and insertion of tool/skill
            function formatDateToYMD(date) {
                var year = date.getFullYear();
                var month = (date.getMonth() + 1).toString().padStart(2, '0');
                var day = date.getDate().toString().padStart(2, '0');
                return `${year}-${month}-${day}`;
            }
            //End of above function

            //Function To Update Skill
            function saveSkillData() {
                


                var Details = toolOrSkillDetails[0];
                var Parameters = {
                    ProjectToolID: Details.projectToolID,
                    ProjectID: Details.projectID,
                    ParameterId: (document.getElementById('skillUsage').value || "").trim(),
                    Version: (document.getElementById('skillVersion').value || "").trim(),
                    //PercentageUtilization: (document.getElementById('skillPercentageUtilization').value || 0).toString().trim(),
                    PercentageUtilization: (function () {
                        var val = document.getElementById('skillPercentageUtilization').value;
                        return (val && val.trim() !== '') ? parseFloat(val) : null;
                    })(),


                    IsCustomerSupplied: document.getElementById('skillIsCustomerSupplied').checked || false,
                    IsCritical: document.getElementById('skillIsCritical').checked || false,
                    IsProcured: document.getElementById('skillIsProcured').checked || false,
                    BriefDescription: (document.getElementById('skillBriefDescription').value || "").trim(),
                    NumberOfCopies: (document.getElementById('skillNumberOfCopies').value || "").trim() || null, // Ensures null for empty input
                    Status: (document.getElementById('skillStatus').value || "").trim(),
                    PlannedInDate: $('#plannedDateModalForSkill').datepicker('getDate')
                        ? formatDateToYMD($('#plannedDateModalForSkill').datepicker('getDate')).trim()
                        : "",
                    PlannedOutDate: $('#plannedOutDateModalForSkill').datepicker('getDate')
                        ? formatDateToYMD($('#plannedOutDateModalForSkill').datepicker('getDate')).trim()
                        : "",
                    CreatedBy: UserName.trim()
                };

                let isValid = true;
                let errorMessage = "";

                //var invalidCharactersRegexForVersion = /[\/\\\:\*\?\<\>\|\'\"\,\+\-]/;

                //invalidCharactersRegexForVersion = new RegExp("[" + (SpecialCharactersList + `^&()[]|\\'":;,` + "`~#").replace(/[-\/\\^$*+?.()|[\]{}'"!:;,`~#&]/g, '\\$&') + "]");

                if (Parameters.ParameterId && Parameters.ParameterId == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_Usage_Blank")%></span>");
                    return;
                }

                if (Parameters.Version && invalidCharactersRegex.test(Parameters.Version)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'Version' cannot contain any of these /\\:*?<>'|,\"+- characters.</span>");
                    return;
                }

              <%--  if (Parameters.PercentageUtilization
                    //&& isNaN(Parameters.PercentageUtilization.trim())

                ) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationShouldBeValidNumber")%></span>");
                  return;
                }--%>
                var Paramvalue = Parameters.PercentageUtilization;

                if (Paramvalue !== null && Paramvalue !== undefined && Paramvalue.toString().trim() !== "") {

                    var num = Number(Paramvalue);

                    if (isNaN(num)) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationShouldBeValidNumber")%></span>");
                        return;
                    }
                }




                if (Parameters.PercentageUtilization && parseFloat(Parameters.PercentageUtilization) > 100) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationCannotExceed")%></span>");
                return;
                }

                if (Parameters.NumberOfCopies && (isNaN(Parameters.NumberOfCopies.trim()) || !/^\d+$/.test(Parameters.NumberOfCopies) || parseInt(Parameters.NumberOfCopies) < 0)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_NoOfCopiesShouldBeValidNumber")%></span>");
                    return;
                }

                if (Parameters.PlannedOutDate && Parameters.PlannedInDate && Parameters.PlannedOutDate < Parameters.PlannedInDate) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_PlannedOutDateCannot")%></span>");
                    return;
                }

               


                if (Parameters.BriefDescription && invalidCharactersRegex.test(Parameters.BriefDescription)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'BriefDescription' cannot contain any of these /\\:*?<>'|,\"+- characters</span>");
                    return;
                }

                if (Parameters.BriefDescription.length > 1000) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>"
                        + "<%=MyBase.GetResourceString("A_BriefDescriptionMaxLengthExceeded")%> "
                        + "<%=MyBase.GetResourceString("A_YouHaveEntered")%> " + Parameters.BriefDescription.length + " <%=MyBase.GetResourceString("A_Characters")%>."
                        + "</span>");

                    return;
                }   

                if (!isValid) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>" + errorMessage.replace(/\n/g, "<br>") + "</span>");
                    return;
                }

                AJAXCallWithResult("api/PM_ToolsSkill/UpdateProjectToolOrSkill", Parameters, false);

                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_SkillUpdatedSuccessfully")%></span>");


                
                if ($(".Resourcedetailpanel").is(":visible")) {
                    NextResdetailSkill();
                }
                populateToolsTable(selectedProjectID);
                populateSkillsTable(selectedProjectID);

            }
            //End of above function

            //Function To Update Tool
            function saveToolData() {

                var Details = toolOrSkillDetails[0];

                var Parameters = {
                    ProjectToolID: Details.projectToolID,
                    ProjectID: Details.projectID,
                    ParameterId: (document.getElementById('toolUsage').value || "").trim(),
                    Version: (document.getElementById('toolVersion').value || "").trim(),
                    //PercentageUtilization: (document.getElementById('toolPercentageUtilization').value || 0).toString().trim(),
                    PercentageUtilization: (function () {
                        var val = document.getElementById('toolPercentageUtilization').value;
                        return (val && val.trim() !== '') ? parseFloat(val) : null;
                    })(),

                    IsCustomerSupplied: document.getElementById('toolIsCustomerSupplied').checked || false,
                    IsCritical: document.getElementById('toolIsCritical').checked || false,
                    IsProcured: document.getElementById('toolIsProcured').checked || false,
                    BriefDescription: (document.getElementById('toolBriefDescription').value || "").trim(),
                    NumberOfCopies: (document.getElementById('toolNumberOfCopies').value || "").trim() || null,
                    Status: (document.getElementById('toolStatus').value || "").trim(),
                    PlannedInDate: $('#plannedDateModalForTool').datepicker('getDate')
                        ? formatDateToYMD($('#plannedDateModalForTool').datepicker('getDate')).trim()
                        : "",
                    PlannedOutDate: $('#plannedOutDateModalForTool').datepicker('getDate')
                        ? formatDateToYMD($('#plannedOutDateModalForTool').datepicker('getDate')).trim()
                        : "",
                    CreatedBy: UserName.trim()
                };

                let isValid = true;
                let errorMessage = "";

                /* var invalidCharactersRegexForVersion = /[\/\\\:\*\?\<\>\|\'\"\,\+\-]/;*/

                //invalidCharactersRegexForVersion = new RegExp("[" + (SpecialCharactersList + `^&()[]|\\'":;,` + "`~#").replace(/[-\/\\^$*+?.()|[\]{}'"!:;,`~#&]/g, '\\$&') + "]");

                if (Parameters.ParameterId && Parameters.ParameterId == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_Usage_Blank")%></span>");
                    return;
                }

                if (Parameters.Version && invalidCharactersRegex.test(Parameters.Version)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'Version' cannot contain any of these /\\:*?<>'|,\"+- characters.</span>");
                    return;
                }

<%--                if (Parameters.PercentageUtilization
                    //&& isNaN(Parameters.PercentageUtilization.trim())
                ) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationShouldBeValidNumber")%></span>");
                    return;
                }--%>
                var Paramvalue = Parameters.PercentageUtilization;

                if (Paramvalue !== null && Paramvalue !== undefined && Paramvalue.toString().trim() !== "") {

                    var num = Number(Paramvalue);

                    if (isNaN(num)) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationShouldBeValidNumber")%></span>");
                        return;
                    }
                }


                if (Parameters.PercentageUtilization && parseFloat(Parameters.PercentageUtilization) > 100) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationCannotExceed")%></span>");
                return;
                }

                if (Parameters.NumberOfCopies && (isNaN(Parameters.NumberOfCopies.trim()) || !/^\d+$/.test(Parameters.NumberOfCopies) || parseInt(Parameters.NumberOfCopies) < 0)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_NoOfCopiesShouldBeValidNumber")%></span>");
                    return;
                }

                if (Parameters.PlannedOutDate && Parameters.PlannedInDate && Parameters.PlannedOutDate < Parameters.PlannedInDate) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_PlannedOutDateCannot")%></span>");
                    return;
                }


                if (Parameters.BriefDescription && invalidCharactersRegex.test(Parameters.BriefDescription)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'BriefDescription' cannot contain any of these /\\:*?<>'|,\"+- characters</span>");
                     return;
                }


                if (Parameters.BriefDescription.length > 1000) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>"
                        + "<%=MyBase.GetResourceString("A_BriefDescriptionMaxLengthExceeded")%> "
                    + "<%=MyBase.GetResourceString("A_YouHaveEntered")%> " + Parameters.BriefDescription.length + " <%=MyBase.GetResourceString("A_Characters")%>."
                    + "</span>");
                    return;
                }

                if (!isValid) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>" + errorMessage.replace(/\n/g, "<br>") + "</span>");
                    return;
                }

                AJAXCallWithResult("api/PM_ToolsSkill/UpdateProjectToolOrSkill", Parameters, false);

                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_ToolUpdatedSuccessfully")%></span>");


               
                if ($(".Resourcedetailpanel").is(":visible")) {
                    NextResdetailTool();
                }
                populateToolsTable(selectedProjectID);
                populateSkillsTable(selectedProjectID);
            }
            //End of above function

            //Function To Reset the Tool Modal While Adding a new Tool
            function resetToolDetails() {

                document.getElementById("toolCancelBtn").click();
                document.getElementById('toolDescriptionAdd').value = '';
                document.getElementById('toolVersionAdd').value = '';
                document.getElementById('toolPercentageUtilizationAdd').value = '';
                document.getElementById('toolNumberOfCopiesAdd').value = '';
                document.getElementById('toolBriefDescriptionAdd').value = '';

                var skillUsageDropdown = document.getElementById('toolUsageAdd');
                skillUsageDropdown.selectedIndex = 0;
                $('.selectpicker').selectpicker('refresh');

                var statusDropdown = document.getElementById('toolStatusAdd');
                statusDropdown.value = '';
                $('.selectpicker').selectpicker('refresh');

                $('#plannedDateModalForToolAdd').datepicker('setDate', null);
                $('#plannedOutDateModalForToolAdd').datepicker('setDate', null);

                document.getElementById('toolIsCustomerSuppliedAdd').checked = false;
                document.getElementById('toolIsCriticalAdd').checked = false;
                document.getElementById('toolIsProcuredAdd').checked = false;
            }
            //End of above function

            //Function To Reset the Skill Modal While Adding a new Skill
            function resetSkillDetails() {
                document.getElementById("skillCancelBtn").click();
                document.getElementById('skillDescriptionAdd').value = '';
                document.getElementById('skillVersionAdd').value = '';
                document.getElementById('skillPercentageUtilizationAdd').value = '';
                document.getElementById('skillNumberOfCopiesAdd').value = '';
                document.getElementById('skillBriefDescriptionAdd').value = '';

                var skillUsageDropdown = document.getElementById('skillUsageAdd');
                skillUsageDropdown.selectedIndex = 0;
                $('.selectpicker').selectpicker('refresh');

                var statusDropdown = document.getElementById('skillStatusAdd');
                statusDropdown.value = '';
                $('.selectpicker').selectpicker('refresh');

                $('#plannedDateModalForSkillAdd').datepicker('setDate', null);
                $('#plannedOutDateModalForSkillAdd').datepicker('setDate', null);

                document.getElementById('skillIsCustomerSuppliedAdd').checked = false;
                document.getElementById('skillIsCriticalAdd').checked = false;
                document.getElementById('skillIsProcuredAdd').checked = false;
            }
            //End of above function

         
            //Function to Append available tools for the projects
            function fillAvailableToolsForProjectToDropdown() {
                
                AvailableToolsForProject = null;
                document.getElementById('tools_input').value = '';

                var Parameter = {
                    ProjId: selectedProjectID,
                    IsSkill: false // Set to FALSE for Tools
                };

                var response = AJAXCallWithResult("api/PM_ToolsSkill/GetAvailableSkillsOrToolsOfProjectsByProjectID", Parameter, false);

                // FIX: Access the 'data' array from the JSON response
                AvailableToolsForProject = response.data || response.Data;

                var tableBody = document.getElementById('tools_selectio_Tbl').getElementsByTagName('tbody')[0];

                if ($.fn.DataTable.isDataTable('#tools_selectio_Tbl')) {
                    $('#tools_selectio_Tbl').DataTable().clear().destroy();
                }

                tableBody.innerHTML = '';

                // FIX: Loop over the array and use camelCase properties
                if (AvailableToolsForProject && AvailableToolsForProject.length > 0) {
                    for (var i = 0; i < AvailableToolsForProject.length; i++) {
                        var tool = AvailableToolsForProject[i];

                        var rowHTML = `
                <tr>
                    <td><span>${tool.description}</span></td>
                    <td>
                        <div class="custom_chckbox">
                            <input id="${tool.toolID}" class="mainchck" type="checkbox">
                            <label for="${tool.toolID}"></label>
                        </div>
                    </td>
                </tr>
            `;

                        tableBody.innerHTML += rowHTML;
                    }
                }

                $('#tools_selectio_Tbl').DataTable({
                    "pageLength": 10,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    //"destroy": false,
                    //"retrieve": true,
                    "destroy": true,  // Change to true
                    "retrieve": false, // Change to false
                    "responsive": true
                });
            }
            //End of above function

          
            //Function to Append available skills for the projects
            function fillAvailableSkillsForProjectToDropdown() {
                skillSubCatID = 0;
                document.getElementById('skills_input').value = '';
                document.getElementById('ddl_SkillSubCategory').value = 0;
                AvailableSkillsForProject = null;
                var skillSubCategoryDropdown = document.getElementById('ddl_SkillSubCategory');
                skillSubCategoryDropdown.value = '0';

                var Parameter = {
                    ProjId: selectedProjectID,
                    IsSkill: true // Set to TRUE for Skills
                };

                var response = AJAXCallWithResult("api/PM_ToolsSkill/GetAvailableSkillsOrToolsOfProjectsByProjectID", Parameter, false);
                AvailableSkillsForProject = response.data || response.Data;

                var tableBody = document.getElementById('skill_selectio_Tbl').getElementsByTagName('tbody')[0];

                if ($.fn.DataTable.isDataTable('#skill_selectio_Tbl')) {
                    $('#skill_selectio_Tbl').DataTable().clear().destroy();
                }

                tableBody.innerHTML = '';

                if (AvailableSkillsForProject && AvailableSkillsForProject.length > 0) {
                    for (var i = 0; i < AvailableSkillsForProject.length; i++) {
                        var tool = AvailableSkillsForProject[i];

                        var rowHTML = `
                 <tr>
                     <td><span>${tool.description}</span></td>
                     <td>
                         <div class="custom_chckbox">
                             <input id="${tool.toolID}" class="mainchck" type="checkbox">
                             <label for="${tool.toolID}"></label>
                         </div>
                     </td>
                 </tr>
             `;

                        tableBody.innerHTML += rowHTML;
                    }
                }
                $('#skill_selectio_Tbl').DataTable({
                    "pageLength": 10,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true,
                    "retrieve": false
                });
            }
            //End of above function

            //Function to get selected available tools while ading new tool
            function collectSelectedToolIDs() {
                var dataTable = $("#tools_selectio_Tbl").DataTable();
                var selectedToolsIDs = [];
                var selectedToolNames = [];

                dataTable.rows().every(function (rowIdx, tableLoop, rowLoop) {
                    var row = this.node();
                    var checkbox = $(row).find(".mainchck");
                    if (checkbox.prop("checked")) {
                        var toolID = checkbox.attr("id");
                        var toolName = $(row).find('td:first span').text().trim() || $(row).find('td:first').text().trim();
                        selectedToolsIDs.push(toolID);
                        selectedToolNames.push(toolName);
                    }
                });

                let isValid = true;
                let errorMessage = "";

                if (!selectedToolsIDs || selectedToolsIDs.length === 0) {
                    errorMessage += "<%=MyBase.GetResourceString("A_SelectAtleastOneTool")%>.\n";
                    isValid = false;
                }

                if (!isValid) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>" + errorMessage.replace(/\n/g, "<br>") + "</span>");
                    return;
                }

                toolIDSSelected = selectedToolsIDs.length > 0 ? selectedToolsIDs.join(',') + ',' : "";

                var toolDescriptionInput = document.getElementById('toolDescription');
                toolDescriptionInput.value = selectedToolNames.join(', ');

                var toolDescriptionInputAdd = document.getElementById('toolDescriptionAdd');
                toolDescriptionInputAdd.value = selectedToolNames.join(', ');

                document.getElementById('cls_Tools').click();

                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_ToolSelectedSuccessfully!")%></span>");
            }

            //End of above function

            //Function to get selected available tools while ading new tool
            function collectSelectedSkillIDs() {
                var dataTable = $("#skill_selectio_Tbl").DataTable();
                var selectedSkillsIDs = [];
                var selectedSkillNames = [];

                dataTable.rows().every(function (rowIdx, tableLoop, rowLoop) {
                    var row = this.node();
                    var checkbox = $(row).find(".mainchck");
                    if (checkbox.prop("checked")) {
                        var skillID = checkbox.attr("id");
                        var skillName = $(row).find('td:first span').text().trim() || $(row).find('td:first').text().trim() || "Unknown Skill";
                        selectedSkillsIDs.push(skillID);
                        selectedSkillNames.push(skillName);
                    }
                });

                let isValid = true;
                let errorMessage = "";

                if (!selectedSkillsIDs || selectedSkillsIDs.length === 0) {
                    errorMessage += "<%=MyBase.GetResourceString("A_SelectAtleastOneSkill")%>\n";
                    isValid = false;
                }

                if (!isValid) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>" + errorMessage.replace(/\n/g, "<br>") + "</span>");
                    return;
                }

                skillIDSSelected = selectedSkillsIDs.join(',') + ',';

                var skillDescriptionInput = document.getElementById('skillDescription');
                if (skillDescriptionInput) {
                    skillDescriptionInput.value = selectedSkillNames.join(', ');
                }

                var skillDescriptionInputAdd = document.getElementById('skillDescriptionAdd');
                if (skillDescriptionInputAdd) {
                    skillDescriptionInputAdd.value = selectedSkillNames.join(', ');
                }

                var closeModalButton = document.getElementById('clstheModal');
                if (closeModalButton) {
                    closeModalButton.click();
                }

                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_SkillSelectedSuccessfully!")%></span>");
            }


            //End of above function


            //Function to Add New Tool
            function addNewToolData() {
                var Parameters = {
                    ProjectID: selectedProjectID,
                    ParameterId: (document.getElementById('toolUsageAdd').value || "").trim(),
                    Version: (document.getElementById('toolVersionAdd').value || "").trim(),
                    //PercentageUtilization: (document.getElementById('toolPercentageUtilizationAdd').value || '').toString().trim(),
                    PercentageUtilization: (document.getElementById('toolPercentageUtilizationAdd').value || '').toString().trim(), PercentageUtilization: (function () {
                        var val = document.getElementById('toolPercentageUtilizationAdd').value;
                        return (val && val.trim() !== '') ? parseFloat(val) : null;
                    })(),
                    CustomerSupplied: document.getElementById('toolIsCustomerSuppliedAdd').checked ? "on" : "",
                    Critical: document.getElementById('toolIsCriticalAdd').checked ? "on" : "",
                    Procured: document.getElementById('toolIsProcuredAdd').checked ? "on" : "",
                    BriefDescription: (document.getElementById('toolBriefDescriptionAdd').value || "").trim(),
                    NumberOfCopies: (document.getElementById('toolNumberOfCopiesAdd').value || "").trim() || null,
                    Status: (document.getElementById('toolStatusAdd').value || "").trim(),
                    PlannedInDate: $('#plannedDateModalForToolAdd').datepicker('getDate')
                        ? formatDateToYMD($('#plannedDateModalForToolAdd').datepicker('getDate')).trim()
                        : "",
                    PlannedOutDate: $('#plannedOutDateModalForToolAdd').datepicker('getDate')
                        ? formatDateToYMD($('#plannedOutDateModalForToolAdd').datepicker('getDate')).trim()
                        : "",
                    ToolIDs: toolIDSSelected,
                    CreatedBy: UserName.trim(),
                };


                let isValid = true;
                let errorMessage = "";

                if (toolIDSSelected === '' || toolIDSSelected === undefined) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_ToolCannotBeLeftEmpty")%></span>");
                    return;
                }

                //var invalidCharactersRegexForVersion = /[\/\\\:\*\?\<\>\|\'\"\,\+\-]/;

                //invalidCharactersRegexForVersion = new RegExp("[" + (SpecialCharactersList + `^&()[]|\\'":;,` + "`~#").replace(/[-\/\\^$*+?.()|[\]{}'"!:;,`~#&]/g, '\\$&') + "]");

                if (Parameters.ParameterId && Parameters.ParameterId == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_Usage_Blank")%></span>");
                    return;
                }

                if (Parameters.Version && invalidCharactersRegex.test(Parameters.Version)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'Version' cannot contain any of these /\\:*?<>'|,\"+- characters.</span>");
                    return;
                }

             <%--   if (Parameters.PercentageUtilization
                    //&& isNaN(Parameters.PercentageUtilization.trim())
                    ) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationShouldBeValidNumber")%></span>");
                    return;
                }--%>

                var Paramvalue = Parameters.PercentageUtilization;

                if (Paramvalue !== null && Paramvalue !== undefined && Paramvalue.toString().trim() !== "") {

                    var num = Number(Paramvalue);

                    if (isNaN(num)) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationShouldBeValidNumber")%></span>");
                        return;
                    }
                }


                if (Parameters.PercentageUtilization && parseFloat(Parameters.PercentageUtilization) > 100) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationCannotExceed")%></span>");
                    return;
                }

                if (Parameters.NumberOfCopies && (isNaN(Parameters.NumberOfCopies.trim()) || !/^\d+$/.test(Parameters.NumberOfCopies) || parseInt(Parameters.NumberOfCopies) < 0)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_NoOfCopiesShouldBeValidNumber")%></span>");
                    return;
                }

                if (Parameters.PlannedOutDate && Parameters.PlannedInDate && Parameters.PlannedOutDate < Parameters.PlannedInDate) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_PlannedOutDateCannot")%></span>");
                    return;
                }


                if (Parameters.BriefDescription && invalidCharactersRegex.test(Parameters.BriefDescription)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'BriefDescription' cannot contain any of these /\\:*?<>'|,\"+- characters</span>");
                     return;
                }

                if (Parameters.BriefDescription.length > 1000) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>"
                        + "<%=MyBase.GetResourceString("A_BriefDescriptionMaxLengthExceeded")%> "
                    + "<%=MyBase.GetResourceString("A_YouHaveEntered")%> " + Parameters.BriefDescription.length + " <%=MyBase.GetResourceString("A_Characters")%>."
                    + "</span>");
                    return;
                }

                if (!isValid) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>" + errorMessage.replace(/\n/g, "<br>") + "</span>");
                    return;
                }

                AJAXCallWithResult("api/PM_ToolsSkill/AddProjectToolOrSkill", Parameters, false);

                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_ToolAddedSuccessfully!")%></span>");

                // ADD THIS CODE TO CLOSE THE OFFCAVAS
                var offcanvasElement = document.getElementById('offcanvas_ToolsAdd');
                var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                if (offcanvas) {
                    offcanvas.hide();
                }

                toolIDSSelected = '';

                populateToolsTable(selectedProjectID);
                populateSkillsTable(selectedProjectID);
                resetToolDetails();
            }
            //End of above function

            //Function to Add New Skill
            function addNewSkillData() {

                var Parameters = {
                    ProjectID: selectedProjectID,
                    ParameterId: (document.getElementById('skillUsageAdd').value || "").trim(),
                    Version: (document.getElementById('skillVersionAdd').value || "").trim(),
                    //PercentageUtilization: (document.getElementById('skillPercentageUtilizationAdd').value || 0).toString().trim(),
                    PercentageUtilization: (function () {
                        var val = document.getElementById('skillPercentageUtilizationAdd').value;
                        return (val && val.trim() !== '') ? parseFloat(val) : null;
                    })(),
                    Critical: document.getElementById('skillIsCriticalAdd').checked ? "on" : "",
                    Procured: document.getElementById('skillIsProcuredAdd').checked ? "on" : "",
                    BriefDescription: (document.getElementById('skillBriefDescriptionAdd').value || "").trim(),
                    NumberOfCopies: (document.getElementById('skillNumberOfCopiesAdd').value || "").trim() || null,
                    Status: (document.getElementById('skillStatusAdd').value || "").trim(),
                    PlannedInDate: $('#plannedDateModalForSkillAdd').datepicker('getDate')
                        ? formatDateToYMD($('#plannedDateModalForSkillAdd').datepicker('getDate')).trim()
                        : "",
                    //PlannedOutDate: $('#plannedOutDateModalForSkillAdd').datepicker('getDate')
                    //    ? formatDateToYMD($('#plannedDateModalForSkillAdd').datepicker('getDate')).trim()
                    //    : "",
                    PlannedOutDate: $('#plannedOutDateModalForSkillAdd').datepicker('getDate')
                        ? formatDateToYMD($('#plannedOutDateModalForSkillAdd').datepicker('getDate')).trim()
                        : "",

                    ToolIDs: skillIDSSelected,
                    CreatedBy: UserName.trim(),
                };



                let isValid = true;
                let errorMessage = "";

                if (skillIDSSelected === "" || skillIDSSelected === undefined) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_SkillShouldntBeLeftEmpty")%></span>");
                    return;
                }

                //var invalidCharactersRegexForVersion = /[\/\\\:\*\?\<\>\|\'\"\,\+\-]/;

                //invalidCharactersRegexForVersion = new RegExp("[" + (SpecialCharactersList + `^&()[]|\\'":;,` + "`~#").replace(/[-\/\\^$*+?.()|[\]{}'"!:;,`~#&]/g, '\\$&') + "]");


                if (Parameters.ParameterId && Parameters.ParameterId==0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_Usage_Blank")%></span>");
                    return;
                }

                if (Parameters.Version && invalidCharactersRegex.test(Parameters.Version)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'Version' cannot contain any of these /\\:*?<>'|,\"+- characters.</span>");
                    return;
                }

               <%-- if (Parameters.PercentageUtilization
                    //&& isNaN(Parameters.PercentageUtilization.trim()))
                    ) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationShouldBeValidNumber")%></span>");
                    return;
                }--%>
                var Paramvalue = Parameters.PercentageUtilization;

                if (Paramvalue !== null && Paramvalue !== undefined && Paramvalue.toString().trim() !== "") {

                    var num = Number(Paramvalue);

                    if (isNaN(num)) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationShouldBeValidNumber")%></span>");
                        return;
                    }
                }


                if (Parameters.PercentageUtilization && parseFloat(Parameters.PercentageUtilization) > 100) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationCannotExceed")%></span>");
                return;
                }

                if (Parameters.NumberOfCopies && (isNaN(Parameters.NumberOfCopies.trim()) || !/^\d+$/.test(Parameters.NumberOfCopies) || parseInt(Parameters.NumberOfCopies) < 0)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_NoOfCopiesShouldBeValidNumber")%></span>");
                    return;
                }

                if (Parameters.PlannedOutDate && Parameters.PlannedInDate && Parameters.PlannedOutDate < Parameters.PlannedInDate) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_PlannedOutDateCannot")%></span>");
                    return;
                }

                if (Parameters.BriefDescription && invalidCharactersRegex.test(Parameters.BriefDescription)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'BriefDescription' cannot contain any of these /\\:*?<>'|,\"+- characters.</span>");
                    return;
                }


                if (Parameters.BriefDescription.length > 500){
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>"
                    + "<%=MyBase.GetResourceString("A_BriefDescriptionMaxLengthExceeded")%> "
                    + "<%=MyBase.GetResourceString("A_YouHaveEntered")%> " + Parameters.BriefDescription.length + " <%=MyBase.GetResourceString("A_Characters")%>."
                    + "</span>");
                    return;
                }
               
                if (!isValid) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>" + errorMessage.replace(/\n/g, "<br>") + "</span>");
                    return;
                }

                AJAXCallWithResult("api/PM_ToolsSkill/AddProjectToolOrSkill", Parameters, false);

                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_SkillAddedSuccessfully!")%></span>");

                
                var offcanvasElement = document.getElementById('offcanvas_SkillsAdd');
                var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                if (offcanvas) {
                    offcanvas.hide();
                }


                skillIDSSelected = '';

                populateToolsTable(selectedProjectID);
                populateSkillsTable(selectedProjectID);
                resetSkillDetails();

            }
            //End of above function

        
            //Function to Reflect Skill available dropdown on the basis of the sub category change
            function AppendSkillsForSubCategory(subCatID) {

                skillSubCatID = subCatID;

                document.getElementById('skills_input').value = '';
                var Parameter = {
                    ProjId: selectedProjectID,
                    IsSkill: true // Set to TRUE for Skills
                };

                var response = AJAXCallWithResult("api/PM_ToolsSkill/GetAvailableSkillsOrToolsOfProjectsByProjectID", Parameter, false);

                var toolsList = response.data || response.Data;

                var tableBody = document.getElementById('skill_selectio_Tbl').getElementsByTagName('tbody')[0];

                if ($.fn.DataTable.isDataTable('#skill_selectio_Tbl')) {
                    $('#skill_selectio_Tbl').DataTable().clear().destroy();
                }

                tableBody.innerHTML = '';

                if (toolsList && toolsList.length > 0) {
                    for (var i = 0; i < toolsList.length; i++) {
                        var tool = toolsList[i];

                       
                        if (tool.tools_CategoryID == subCatID || subCatID == 0) {
                            var rowHTML = `
                  <tr>
                      <td><span>${tool.description}</span></td>
                      <td>
                          <div class="custom_chckbox">
                              <input id="${tool.toolID}" class="mainchck" type="checkbox">
                              <label for="${tool.toolID}"></label>
                          </div>
                      </td>
                  </tr>
              `;

                            tableBody.innerHTML += rowHTML;
                        }
                    }
                }
                $('#skill_selectio_Tbl').DataTable({
                    "pageLength": 10,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false
                });

            }
            //End of above function

           

            //Function to collect selected Tools from Tool Tab Table
         function collectSelectedToolIDsToolTabTable() {
                


                var Parameters = {
                    ProjID: selectedProjectID,
                    ProjectToolSkillIDs: toolIDSSelectedForDeletion
                };
              

                var response = AJAXCallWithResult("api/PM_ToolsSkill/DeleteSelectedToolsOrSkills", Parameters, false);
               

                if (Array.isArray(response.data) && response.data.length > 0) {
                    response.data.forEach(function (item) {
                        if (item.statusMessage === "is deleted successfully.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success("<span style='font-size:14px;'>" + item.toolDescription + " : " + item.statusMessage + "</span>");
                        } else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("<span style='font-size:14px;'>" + item.toolDescription + " : " + item.statusMessage + "</span>");
                        }
                    });
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;\"><%=MyBase.GetResourceString("A_UnexpError")%></span>");
                }

                toolIDSSelectedForDeletion = '';
                selectedToolIDsSet.clear();
                populateToolsTable(selectedProjectID);
                populateSkillsTable(selectedProjectID);
                if (document.getElementById("toolsSltAll")) { document.getElementById("toolsSltAll").checked = false; }
            }

            // Function to collect selected Skills from Skill Tab Table and call delete API
            function collectSelectedSkillIDsSkillTabTable() {
                var Parameters = {
                    ProjID: selectedProjectID,
                    ProjectToolSkillIDs: skillIDSSelectedForDeletion
                };
                var response = AJAXCallWithResult("api/PM_ToolsSkill/DeleteSelectedToolsOrSkills", Parameters, false);
                if (Array.isArray(response.data) && response.data.length > 0) {
                    response.data.forEach(function (item) {
                        if (item.statusMessage === "is deleted successfully.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success("<span style='font-size:14px;'>" + item.toolDescription + " : " + item.statusMessage + "</span>");
                        } else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("<span style='font-size:14px;'>" + item.toolDescription + " : " + item.statusMessage + "</span>");
                        }
                    });
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;\"><%=MyBase.GetResourceString("A_UnexpError")%></span>");
                }
                skillIDSSelectedForDeletion = '';
                selectedSkillIDsSet.clear();
                populateToolsTable(selectedProjectID);
                populateSkillsTable(selectedProjectID);
                if (document.getElementById("Skills_checkAll")) { document.getElementById("Skills_checkAll").checked = false; }
            }
      
          

            //End of above function


         

            // Added By Vyankat B on 18/04/2025 Function show the Delete Model 
   function showDelModalHardware() {
                if (!$.fn.DataTable.isDataTable('#tools_tbl')) { return; }
                // Use cross-page selection set so all selected IDs (all pages) are sent for delete
                toolIDSSelectedForDeletion = Array.from(selectedToolIDsSet).join(',');

                let isValid = true;
                let errorMessage = "";

                if (toolIDSSelectedForDeletion === '' || toolIDSSelectedForDeletion === undefined) {
                    errorMessage += "<%=MyBase.GetResourceString("A_NoToolSelectedForDeletion")%>\n";
                    isValid = false;
                }

                if (!isValid) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>" + errorMessage.replace(/\n/g, "<br>") + "</span>");
                    return;
                }

                var modal = new bootstrap.Modal(document.getElementById('deleteConfirm'));
                modal.show();
            }

  
        // End of Added By Vyankat B on 18/04/2025 Function show the Delete Model


             var skillIDSSelectedForDeletion;

            // Added By Vyankat B on 18/04/2025 Function show the Delete Model 
       function showDelModalSkill() {
                

                // Get DataTable instance for #skills_tbl
                if (!$.fn.DataTable.isDataTable('#skills_tbl')) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>Skills table is not initialized. Please wait or refresh the page.</span>");
                    return;
                }
                // Use cross-page selection set so all selected IDs (all pages) are sent for delete
                skillIDSSelectedForDeletion = Array.from(selectedSkillIDsSet).join(',');

                let isValid = true;
                let errorMessage = "";

                if (skillIDSSelectedForDeletion === '' || skillIDSSelectedForDeletion === undefined) {
                    errorMessage += "<%=MyBase.GetResourceString("A_NoSkillSelectedForDeletion")%>\n";
                    isValid = false;
                }

                if (!isValid) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>" + errorMessage.replace(/\n/g, "<br>") + "</span>");
                    return;
                }

                var modal = new bootstrap.Modal(document.getElementById('deleteSkill'));
                modal.show();
            }
        // End of Added By Vyankat B on 18/04/2025 Function show the Delete Model


            //Function to filter Skill history depending upon dropdown change
            function filterAndAppendSkillData() {
                var selectedField = document.getElementById('modifiedHisFieldSkill').value;
                var selectedUser = document.getElementById('modifiedHisBySkill').value;

                var filteredData = skillhistory.filter(function (data) {
                    return (selectedField === 'Select Option' || data.fieldName === selectedField) &&
                        (selectedUser === 'Select Option' || data.modifiedBy === selectedUser);
                });

                var tableBody = document.getElementById('Skills_Show_History_Tbl').getElementsByTagName('tbody')[0];
                if ($.fn.DataTable.isDataTable('#Skills_Show_History_Tbl')) {
                    $('#Skills_Show_History_Tbl').DataTable().clear().destroy();
                }
                tableBody.innerHTML = '';

                var dateOptions = { day: 'numeric', month: 'long', year: 'numeric' };

                filteredData.forEach(function (data, index) {
                    var dateStr = '';
                    if (data.date) {
                        dateStr = new Date(data.date).toLocaleDateString('en-US', dateOptions);
                    }

                    var row = '<tr class="' + (index % 2 === 0 ? 'even' : 'odd') + '">' +
                        '<td>' + (data.fieldName || '') + '</td>' +
                        '<td>' + dateStr + '</td>' +
                        //'<td>' + (data.value || '') + '</td>' +
                        '<td>' + (data.oldValue || '') + '</td>' +
                        '<td>' + (data.newValue || '') + '</td>' +

                        '<td>' + (data.modifiedBy || '') + '</td>' +
                        '</tr>';
                    tableBody.innerHTML += row;
                });

                $('#Skills_Show_History_Tbl').DataTable({
                    "pageLength": 5,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "autoWidth": false,
                    "info": false
                });
            }
            //End of above function

            //Function to filter Tool history depending upon dropdown change
            
            function filterAndAppendToolData() {
                var selectedField = document.getElementById('modifiedHisFieldTool').value;
                var selectedUser = document.getElementById('modifiedHisByTool').value;

               
                var filteredData = toolhistory.filter(function (data) {
                    return (selectedField === 'Select Option' || data.fieldName === selectedField) &&
                        (selectedUser === 'Select Option' || data.modifiedBy === selectedUser);
                });

                var tableBody = document.getElementById('Tools_Show_History_Tbl').getElementsByTagName('tbody')[0];
                if ($.fn.DataTable.isDataTable('#Tools_Show_History_Tbl')) {
                    $('#Tools_Show_History_Tbl').DataTable().clear().destroy();
                }
                tableBody.innerHTML = '';

                var dateOptions = { day: 'numeric', month: 'long', year: 'numeric' };

                filteredData.forEach(function (data, index) {

                    var dateStr = '';
                    if (data.modifiedDate) {
                        dateStr = new Date(data.modifiedDate).toLocaleDateString('en-US', dateOptions);
                    }

                    var row = '<tr class="' + (index % 2 === 0 ? 'even' : 'odd') + '">' +
                        '<td>' + (data.fieldName || '') + '</td>' +
                        '<td>' + dateStr + '</td>' +
                        '<td>' + (data.oldValue || '') + '</td>' +
                        '<td>' + (data.newValue || '') + '</td>' +
                        '<td>' + (data.modifiedBy || '') + '</td>' +
                        '</tr>';
                    tableBody.innerHTML += row;
                });

                $('#Tools_Show_History_Tbl').DataTable({
                    "pageLength": 5,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "autoWidth": false,
                    "info": false
                });
            }
            //End of above function

            //Function to check which tab is active
            //function checkActiveTab() {
            //   
            //    var toolsTab = document.querySelector('a[href="#Tab_Tools_trend"]');
            //    var skillsTab = document.querySelector('a[href="#Tab_skills_trend"]');

            //    if (toolsTab.classList.contains('active')) {
            //        activeTab = 'Tools'
            //    }

            //    if (skillsTab.classList.contains('active')) {
            //        activeTab = 'Skills';
            //    }
            //    // Show clear all button when filter panel is opened
            //    var clearAllSpan = document.querySelector("span[data-bs-toggle='collapse'][data-bs-target='#filterpanel']");
            //    if (clearAllSpan) {
            //        clearAllSpan.style.display = "inline"; // or "inline-block"
            //    }
            //}
            function checkActiveTab() {
               
                var toolsTab = document.querySelector('a[href="#Tab_Tools_trend"]');
                var skillsTab = document.querySelector('a[href="#Tab_skills_trend"]');

                if (toolsTab && toolsTab.classList.contains('active')) {
                    activeTab = 'Tools';
                }
                if (skillsTab && skillsTab.classList.contains('active')) {
                    activeTab = 'Skills';
                }
                // Show clear all button when filter panel is opened
                var clearAllLink = document.querySelector('a.clearalllink');
                if (clearAllLink) {
                    var clearAllSpan = clearAllLink.querySelector('span[data-bs-toggle="collapse"][data-bs-target="#filterpanel"]');
                    if (clearAllSpan) {
                        clearAllSpan.style.display = "inline";
                    }
                }
            }
            //End of above function

            //Function to apply the filter Of Project Tool Or Skill : Button {Apply}
            function applyProjectToolOrSkillFilter() {

               

               


                saveAndApplyFilterName = null;
                basicFilterApplied = 1;
                basicFilterAppliedOnApplyClick = 1;
                isDefFilterEnabled = 1;

                //var ProjectID = (document.getElementById('ddl_Projects_filter').value || "").trim();
                var ProjectID =defaultProjectID


                if (ProjectID == 0) {
                    ProjectID = "";
                }
                var value = document.getElementById('txtFilter_usage')?.value;
                var ParameterId = (!value || value === "0") ? "" : value.trim();

                //var ParameterId = (document.getElementById('txtFilter_usage').value || "").trim();

                // ... validation ...
                isFilterCanceled = 0;   // <-- ADD
                checkActiveTab();

                var Version = (document.getElementById('txt_filter_version').value || "").trim();
                var PercentageUtilization = (document.getElementById('txt_filter_util').value || "").trim();
                var IsCustomerSupplied = (document.getElementById('supplied_cust_filter').value || "").trim();
                var IsCritical = (document.getElementById('filter_critical').value || "").trim();
                var IsProcured = (document.getElementById('filter_procured').value || "").trim();
                var BriefDescription = (document.getElementById('txt_desc').value || "").trim();
                var NumberOfCopies = (document.getElementById('txt_copies').value || "").trim();
                var Status = (document.getElementById('txt_filter_status').value || "").trim();
                var PlannedInDate = $('#Planned_indate').datepicker('getDate')
                    ? formatDateToYMD($('#Planned_indate').datepicker('getDate')).trim()
                    : null;
                var PlannedOutDate = $('#Planned_out_date').datepicker('getDate')
                    ? formatDateToYMD($('#Planned_out_date').datepicker('getDate')).trim()
                    : null;

                let isValid = true;
                let errorMessage = "";

                //var invalidCharactersRegexForVersion = /[\/\\\:\*\?\<\>\|\'\"\,\+\-]/;

                //invalidCharactersRegexForVersion = new RegExp("[" + (SpecialCharactersList + `^&()[]|\\'":;,` + "`~#").replace(/[-\/\\^$*+?.()|[\]{}'"!:;,`~#&]/g, '\\$&') + "]");

              <%--  if (Parameters.ParameterId && Parameters.ParameterId == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_Usage_Blank")%></span>");
                        return;
                    }--%>


                if (Version && invalidCharactersRegex.test(Version)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'Version' cannot contain any of these /\\:*?<>'|,\"+- characters.</span>");
                    return;
                }

                if (PercentageUtilization && isNaN(PercentageUtilization.trim())) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("C_Select")%></span>");
                    return;
                }

                if (PercentageUtilization && parseFloat(PercentageUtilization) > 100) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("C_Select")%></span>");
                return;
                }

                if (BriefDescription && invalidCharactersRegex.test(BriefDescription)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'BriefDescription' cannot contain any of these /\\:*?<>'|,\"+- characters</span>");
                    return;
                }

                if (BriefDescription!== null && BriefDescription.length > 1000) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>"
                    + "<%=MyBase.GetResourceString("C_Cancel")%> "
                    + "<%=MyBase.GetResourceString("C_YouHaveEntered")%> " + BriefDescription.length + " <%=MyBase.GetResourceString("A_Characters")%>."
                    + "</span>");
                    return;
                }

                if (NumberOfCopies && (isNaN(NumberOfCopies.trim()) || !/^\d+$/.test(NumberOfCopies) || parseInt(NumberOfCopies) < 0)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_NoOfCopiesShouldBeValidNumber")%></span>");
                    return;
                }


                if (PlannedOutDate && PlannedInDate && PlannedOutDate < PlannedInDate) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_PlannedOutDateCannot")%></span>");
                    return;
                }

                if (!isValid) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>" + errorMessage.replace(/\n/g, "<br>") + "</span>");
                    return;
                }


                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_FilterApplied")%></span>");


                checkActiveTab();

                    var Parameters = {
                        ProjectIDFF: String(ProjectID),
                        //ParameterIdFF: String((ParameterId !== null|| 0) ? ParameterId : ""),
                        ParameterIdFF: (!ParameterId || ParameterId === "0")
                            ? ""
                            : String(ParameterId),


                        VersionFF: String(Version !== null ? Version : ""),
                        PercentageUtilizationFF: String(PercentageUtilization !== null ? PercentageUtilization : ""),
                        IsCustomerSuppliedFF: String(IsCustomerSupplied !== null ? IsCustomerSupplied : ""),
                        IsCriticalFF: String(IsCritical !== null ? IsCritical : ""),
                        IsProcuredFF: String(IsProcured !== null ? IsProcured : ""),
                        BriefDescriptionFF: String(BriefDescription !== null ? BriefDescription : ""),
                        NumberOfCopiesFF: String(NumberOfCopies !== null ? NumberOfCopies : ""),
                        StatusFF: String(Status !== null ? Status : ""),
                        PlannedInDateFF: String(PlannedInDate !== null ? PlannedInDate : ""),
                        PlannedOutDateFF: String(PlannedOutDate !== null ? PlannedOutDate : ""),
                        IsSkillFF: "false"
                    };

                lastAppliedFilterParams = Parameters;
                    var toolsTableBody = $('#tools_tbl tbody');


                //table.find('tbody').empty();
                var table = $('#tools_tbl');

             

                // Always clear the tbody manually
                table.find('tbody').empty();
                    toolsTableAllIDs = [];
                    ProjectTools = AJAXCallWithResult("api/PM_ToolsSkill/ApplyFilter", Parameters, false);

                    ProjectTools.data.forEach(function (data) {
                        toolsTableAllIDs.push(String(data.projectToolID || ''));
                        var row = '<tr>' +
                            //'<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" aria-controls="offcanvas_Tools" onclick="handleToolClick(\'' + data.projectToolID + '\')">' + data.Description + '</a></td>' +
                            '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" aria-controls="offcanvas_Tools" onclick="handleToolClick(\'' + data.projectToolID + '\')">' + (data.description || data.Description || '') + '</a></td>' +


                            '<td>' + (data.version ? data.version : '') + '</td>' +
                            '<td>' + (data.parameterDesc ? data.parameterDesc : '') + '</td>' +
                            '<td>' +
                            '<span>' +
                            (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                            '</span>' + (data.status ? data.status : '') +
                            '</td>' +
                            '<td>' + (data.percentageUtilization ? data.percentageUtilization : '') + '</td>' +
                            '<td class="sm-wid">' +
                            '<div class="custom_chckbox">' +
                            '<input id="' + data.projectToolID + '" class="chckHead mainchck" type="checkbox">' +
                            '<label for="' + data.projectToolID + '"></label>' +
                            '</div>' +
                            '</td>' +
                            '</tr>';
                        toolsTableBody.append(row);
                    });
                    $('#tools_tbl').DataTable({
                        "paging": true,
                        "pageLength": 10,
                        "bLengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": false,
                        "retrieve": true,
                        "bAutoWidth": false,
                        "info": false,
                        //"language": {
                        //    "emptyTable": "There are no records to view",
                        //    "zeroRecords": "There are no records to view"
                        //}
                    });


                    var Parameters = {
                        ProjectIDFF: String(ProjectID),
                        //ParameterIdFF: String(ParameterId !== null || "0" ? ParameterId : ""),

                        ParameterIdFF: (!ParameterId || ParameterId === "0")
                            ? ""
                            : String(ParameterId),
                        VersionFF: String(Version !== null ? Version : ""),
                        PercentageUtilizationFF: String(PercentageUtilization !== null ? PercentageUtilization : ""),
                        IsCustomerSuppliedFF: String(IsCustomerSupplied !== null ? IsCustomerSupplied : ""),
                        IsCriticalFF: String(IsCritical !== null ? IsCritical : ""),
                        IsProcuredFF: String(IsProcured !== null ? IsProcured : ""),
                        BriefDescriptionFF: String(BriefDescription !== null ? BriefDescription : ""),
                        NumberOfCopiesFF: String(NumberOfCopies !== null ? NumberOfCopies : ""),
                        StatusFF: String(Status !== null ? Status : ""),
                        PlannedInDateFF: String(PlannedInDate !== null ? PlannedInDate : ""),
                        PlannedOutDateFF: String(PlannedOutDate !== null ? PlannedOutDate : ""),
                        IsSkillFF: "true"
                    };

                    ProjectSkills = AJAXCallWithResult("api/PM_ToolsSkill/ApplyFilter", Parameters, false);

                    //Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                    if (isSkillsTabActive()) {
                        var filterSkillsData = getSkillsDataArray(ProjectSkills);
                        if (filterSkillsData.length === 0) {
                            showSkillsTableNoRecords();
                        } else {
                            var skillsTableBody = $('#skills_tbl tbody');

                            if ($.fn.DataTable.isDataTable('#skills_tbl')) {
                                $('#skills_tbl').DataTable().clear().destroy();
                            }

                            skillsTableBody.empty();
                            skillsTableAllIDs = [];
                            filterSkillsData.forEach(function (data) {
                                skillsTableAllIDs.push(String(data.projectToolID || ''));
                                var row = '<tr>' +
                                    '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Skills" aria-controls="offcanvas_Skills" onclick="handleSkillClick(\'' + data.projectToolID + '\')">' + (data.description || '') + '</a></td>' +
                                    '<td>' + (data.version ? data.version : '') + '</td>' +
                                    '<td>' + (data.parameterDesc ? data.parameterDesc : '') + '</td>' +
                                    '<td>' +
                                    '<span>' +
                                    (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                        data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                                    '</span>' + (data.status ? data.status : '') +
                                    '</td>' +
                                    '<td>' + (data.percentageUtilization ? data.percentageUtilization : '') + '</td>' +
                                    '<td class="sm-wid">' +
                                    '<div class="custom_chckbox">' +
                                    '<input id="' + data.projectToolID + '" class="chckHead main_Skills" type="checkbox">' +
                                    '<label for="' + data.projectToolID + '"></label>' +
                                    '</div>' +
                                    '</td>' +
                                    '</tr>';
                                skillsTableBody.append(row);
                            });
                            initializeSkillsDataTable();
                        }
                    } else {
                        skillsTableNeedsInit = true;
                    }
                    //End of Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue

                toggleClearAllSpan(isDefFilterEnabled);
                //availableFiltersForUser();
            }
            //End of above function

            //Function to clear the filter fields
            function clearAll() {
                document.getElementById('txtFilterName').value = '';
                //document.getElementById('ddl_Projects_filter').value = '0';
                document.getElementById('txtFilter_usage').value = 0;
                document.getElementById('txt_filter_version').value = '';
                document.getElementById('txt_filter_util').value = '';
                document.getElementById('supplied_cust_filter').value = '';
                document.getElementById('filter_critical').value = '';
                document.getElementById('filter_procured').value = '';
                document.getElementById('txt_desc').value = '';
                document.getElementById('txt_copies').value = '';
                document.getElementById('txt_filter_status').value = '';
                $('#Planned_indate').datepicker('setDate', null);
                $('#Planned_out_date').datepicker('setDate', null);
            }
            //End of above function

            //function to search through the available project tools
            
            function search_tools() {
                var inputValue = document.getElementById('tools_input').value.trim().toLowerCase();

                //  Ensure AvailableToolsForProject is the array
                var filteredTools = AvailableToolsForProject.filter(function (tool) {
                    //  Use tool.description
                    return tool.description.toLowerCase().includes(inputValue);
                });

                var tableBody = document.getElementById('tools_selectio_Tbl').getElementsByTagName('tbody')[0];

                if ($.fn.DataTable.isDataTable('#tools_selectio_Tbl')) {
                    $('#tools_selectio_Tbl').DataTable().clear().destroy();
                }

                tableBody.innerHTML = '';

                filteredTools.forEach(function (tool) {
                    var rowHTML = `
            <tr>
                <td><span>${tool.description}</span></td>
                <td>
                    <div class="custom_chckbox">
                        <input id="${tool.toolID}" class="mainchck" type="checkbox">
                        <label for="${tool.toolID}"></label>
                    </div>
                </td>
            </tr>
        `;

                    tableBody.innerHTML += rowHTML;
                });

                $('#tools_selectio_Tbl').DataTable({
                    "pageLength": 10,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "responsive": true
                });
            }
//End of above function
       

            //function to search through the available project skills
       
            function search_skills() {

                var inputValue = document.getElementById('skills_input').value.trim().toLowerCase();

                var subCatSkillsID = skillSubCatID;

        
                var filteredSkills = AvailableSkillsForProject.filter(function (skill) {
             
                    return skill.description.toLowerCase().includes(inputValue);
                });

                var tableBody = document.getElementById('skill_selectio_Tbl').getElementsByTagName('tbody')[0];

                if ($.fn.DataTable.isDataTable('#skill_selectio_Tbl')) {
                    $('#skill_selectio_Tbl').DataTable().clear().destroy();
                }

                tableBody.innerHTML = '';

            
                if (AvailableSkillsForProject && AvailableSkillsForProject.length > 0) {
                    for (var i = 0; i < AvailableSkillsForProject.length; i++) {
                        var skill = AvailableSkillsForProject[i];

                       
                        if ((skill.description.toLowerCase().includes(inputValue) || inputValue === '') &&
                            (skill.tools_CategoryID == subCatSkillsID || subCatSkillsID == 0)) {
                            var rowHTML = `
                    <tr>
                        <td><a href="javascript:;">${skill.description}</a></td>
                        <td>
                            <div class="custom_chckbox">
                                <input id="${skill.toolID}" class="mainchck" type="checkbox">
                                <label for="${skill.toolID}"></label>
                            </div>
                        </td>
                        </tr>
                    `;

                            tableBody.innerHTML += rowHTML;
                        }
                    }
                }

                $('#skill_selectio_Tbl').DataTable({
                    "pageLength": 10,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "responsive": true
                });
            }
//End of above function
           
            //Function to Save Filter Proper Way : Buttton {save and apply} here
            function saveFilter() {
                var FilterName = (document.getElementById('txtFilterName').value || "").trim();
                saveAndApplyFilterName = (document.getElementById('txtFilterName').value || "").trim();
                //var ProjectID = (document.getElementById('ddl_Projects_filter').value || "").trim();
                //if (ProjectID == 0) {
                //    ProjectID = "";
                //}
                var ProjectID = selectedProjectID || "";
                if (ProjectID == 0) { ProjectID = ""; }


                var ParameterId = (document.getElementById('txtFilter_usage').value || "").trim();
                var Version = (document.getElementById('txt_filter_version').value || "").trim();
                var PercentageUtilization = (document.getElementById('txt_filter_util').value || "").trim();
                var IsCustomerSupplied = (document.getElementById('supplied_cust_filter').value || "").trim();
                var IsCritical = (document.getElementById('filter_critical').value || "").trim();
                var IsProcured = (document.getElementById('filter_procured').value || "").trim();
                var BriefDescription = (document.getElementById('txt_desc').value || "").trim();
                var NumberOfCopies = (document.getElementById('txt_copies').value || "").trim();
                var Status = (document.getElementById('txt_filter_status').value || "").trim();
                var PlannedInDate = $('#Planned_indate').datepicker('getDate')
                    ? formatDateToYMD($('#Planned_indate').datepicker('getDate')).trim()
                    : null;
                var PlannedOutDate = $('#Planned_out_date').datepicker('getDate')
                    ? formatDateToYMD($('#Planned_out_date').datepicker('getDate')).trim()
                    : null;

                let isValid = true;
                let errorMessage = "";

                //invalidCharactersRegexForVersion = new RegExp("[" + (SpecialCharactersList + `^&()[]|\\'":;,` + "`~#").replace(/[-\/\\^$*+?.()|[\]{}'"!:;,`~#&]/g, '\\$&') + "]");

                 //invalidCharactersRegexForVersion = new RegExp("[" +
                 //   SpecialCharactersList.replace(/[-\/\\^$*+?.()|[\]{}'"!:;,`~#&]/g, '\\$&') +
                 //   "]");
                //var invalidCharactersRegex = /[\/\\\:\*\?\<\>\|\,\"\+\-\']/;
                if (FilterName && invalidCharactersRegex.test(FilterName)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_FilterNameValidation")%></span>");
                    return;
                }

                //var invalidCharactersRegexForVersion = /[\/\\\:\*\?\<\>\|\'\"\,\+\-]/;

                //invalidCharactersRegexForVersion = new RegExp("[" + (SpecialCharactersList + `^&()[]|\\'":;,` + "`~#").replace(/[-\/\\^$*+?.()|[\]{}'"!:;,`~#&]/g, '\\$&') + "]");


          <%--      if (Parameters.ParameterId && Parameters.ParameterId == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_Usage_Blank")%></span>");
                    return;
                }--%>


                if (Version && invalidCharactersRegex.test(Version)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'Version' cannot contain any of these /\\:*?<>'|,\"+- characters.</span>");
                    return;
                }

                if (PercentageUtilization && isNaN(PercentageUtilization.trim())) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationShouldBeValidNumber")%></span>");
                    return;
                }

                if (PercentageUtilization && parseFloat(PercentageUtilization) > 100) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationCannotExceed")%></span>");
                    return;
                }

                if (BriefDescription && invalidCharactersRegex.test(BriefDescription)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'BriefDescription' cannot contain any of these /\\:*?<>'|,\"+- characters</span>");
                    return;
                }

                if (BriefDescription !== null && BriefDescription.length > 1000) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>"
                        + "<%=MyBase.GetResourceString("A_BriefDescriptionMaxLengthExceeded")%> "
                        + "<%=MyBase.GetResourceString("A_YouHaveEntered")%> " + BriefDescription.length + " <%=MyBase.GetResourceString("A_Characters")%>."
                        + "</span>");
                    return;
                }

                if (BriefDescription) {
                    BriefDescription = BriefDescription.replace(/'/g, "''");
                } 

                if (NumberOfCopies && (isNaN(NumberOfCopies.trim()) || !/^\d+$/.test(NumberOfCopies) || parseInt(NumberOfCopies) < 0)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_NoOfCopiesShouldBeValidNumber")%></span>");
                    return;
                }

                if (PlannedOutDate && PlannedInDate && PlannedOutDate < PlannedInDate) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_PlannedOutDateCannot")%></span>");
                    return;
                }

                 if (!isValid) {
                     alertify.set('notifier', 'position', 'top-right');
                     alertify.error("<span style='font-size:14px;'>" + errorMessage.replace(/\n/g, "<br>") + "</span>");
                     return;
                 }

                 alertify.set('notifier', 'position', 'top-right');
                 alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_FilterApplied")%></span>");


                var WhereClause = {
                    ProjectIDF: ProjectID,
                    ParameterIdF: ParameterId,
                    VersionF: Version,
                    PercentageUtilizationF: PercentageUtilization,
                    IsCustomerSuppliedF: IsCustomerSupplied,
                    IsCriticalF: IsCritical,
                    IsProcuredF: IsProcured,
                    BriefDescriptionF: BriefDescription,
                    NumberOfCopiesF: NumberOfCopies,
                    StatusF: Status,
                    PlannedInDateF: PlannedInDate,
                    PlannedOutDateF: PlannedOutDate
                };

                var Parameters = {
                    ProjectIDF: null,
                    UserId: UserId,
                    WhereClause: JSON.stringify(WhereClause),
                    LoginType: LoginType,
                    CreatedBy: UserName,
                    FilterName: FilterName
                };


                var response = AJAXCallWithResult("api/PM_ToolsSkill/SaveFilterProper", Parameters, false);

                var savedFilterId = response[0].FilterId;

                document.querySelector('button.close[data-bs-dismiss="modal"]').click();
                document.getElementById('txtFilterName').value = '';

                if (savedFilterId !== null || savedFilterId !== undefined) {
                    //availableFiltersForUser();
                    applySelectedFilter(savedFilterId, 1);
                } else {
                    applyProjectToolOrSkillFilter();
                }

                isDefFilterEnabled = 1;

                toggleClearAllSpan(isDefFilterEnabled);
            }
            //End of above function

           

            //Function to delete the selected Filter
            function deleteSelectedFilter(filterID) {

                var defaultFilterRadio = document.getElementById(`filter${filterID}`);
                if (defaultFilterRadio && defaultFilterRadio.checked) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_DefFilCannotDeleted")%></span>");
                    return;
                }

                const checkbox = document.getElementById(`Issueselpro${filterID}`);

                if (checkbox && checkbox.checked) {

                    isFilterCanceled = 1;
                    var Parameters = {
                        FilterID: filterID,
                        UserId: UserId,
                        TagID: 35
                    };

                    AJAXCallWithResult("api/PM_ToolsSkill/DeleteSelectedFilters", Parameters, false);

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_FilterDeletedSuccessfully!")%></span>");

                    clearAllFilters();

                    var Parameters = {
                        UserId: UserId,
                        TagID: 35
                    };

                    var availableFilters = AJAXCallWithResult("api/PM_ToolsSkill/RetrieveAvailableFilters", Parameters, false);

                    var filtersDropdown = document.getElementById('MyFiltersdropdown');

                    filtersDropdown.innerHTML = '';

                    availableFilters.forEach(function (filter) {
                        var filterHTML = `
                                          <li>
                                              <label class="customradio">
                                                  <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="filter${filter.FilterID}" type="checkbox" name="defaultFilter" onclick="setDefaultFilter(${filter.FilterID}, this.checked ? 1 : 0)" ${filter.SetDefault ? 'checked' : ''}> 
                                                  <span data-bs-toggle="tooltip" data-bs-placement="right" class="checkmark" aria-label="Set Default filter" data-bs-original-title="Set Default filter"></span>
                                              </label>
                                              <label class="">
                                                  <span for="filter${filter.FilterID}" class="radiotextsty">${filter.FilterName}</span>
                                              </label>
                                              <div class="issfilter_actiondropdown">
                                                  <div class="custom_chckbox_markblue">
                                                      <input id="Issueselpro${filter.FilterID}" type="checkbox" name="applyFilter" onclick="applySelectedFilter(${filter.FilterID}, this.checked ? 1 : 0)">
                                                      <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" for="Issueselpro${filter.FilterID}" aria-label="Apply filter" data-bs-original-title="Apply filter"></label>
                                                  </div> 
                                                  <span class="edit_filter">
                                                     <i data-bs-toggle="offcanvas" data-bs-target="#offcanvas_FiltersAdd" aria-controls="offcanvas_FiltersAdd" class="fas fa-pencil-alt" onclick="EditSelectedFilter(${filter.FilterID},document.getElementById('Issueselpro${filter.FilterID}').checked ? 1 : 0);" aria-label="Edit filter" data-bs-original-title="Edit filter"></i>
                                                  </span>
                                                  <span>
                                                      <i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" class="far fa-trash-alt" onclick="deleteSelectedFilter(${filter.FilterID});" aria-label="Delete filter" data-bs-original-title="Delete filter"></i>
                                                  </span>
                                              </div>
                                          </li>
                                      `;

                        filtersDropdown.innerHTML += filterHTML;
                    });
                    return;
                } 

                var Parameters = {
                    FilterID: filterID,
                    UserId: UserId,
                    TagID: 35
                };

                AJAXCallWithResult("api/PM_ToolsSkill/DeleteSelectedFilters", Parameters, false);

                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_FilterDeletedSuccessfully!")%></span>");

                //availableFiltersForUser();
            }
            //End of above function

            //Function to apply the filters
            function applySelectedFilter(filterID, isChecked) {
                isFilterCanceled = 1;
                basicFilterApplied = 0;
                basicFilterAppliedOnApplyClick = 0;
                selectedFilterID = filterID;
                clearFilters = 0;
                if (isChecked == 1) {
                    isDefFilterEnabled = 1;
                    isFilterCanceled = 0;
                    var applyFilters = document.getElementsByName('applyFilter');
                    applyFilters.forEach(function (checkbox) {
                        checkbox.checked = false;
                    });

                    var checkbox = document.getElementById(`Issueselpro${filterID}`);
                    checkbox.checked = true;

                    var Parameters = {
                        FilterID: filterID
                    };
                    var response = AJAXCallWithResult("api/PM_ToolsSkill/GetSelectedFilterParameter", Parameters, false);

                    var whereClause = JSON.parse(response[0].WhereClause);

                    var ApplyFilterParameters = {
                        ProjectIDFF: String(selectedProjectID),
                        ParameterIdFF: String(whereClause.ParameterIdF !== null ? whereClause.ParameterIdF : ""),
                        VersionFF: String(whereClause.VersionF !== null ? whereClause.VersionF : ""),
                        PercentageUtilizationFF: String(whereClause.PercentageUtilizationF !== null ? whereClause.PercentageUtilizationF : ""),
                        IsCustomerSuppliedFF: String(whereClause.IsCustomerSuppliedF !== null ? whereClause.IsCustomerSuppliedF : ""),
                        IsCriticalFF: String(whereClause.IsCriticalF !== null ? whereClause.IsCriticalF : ""),
                        IsProcuredFF: String(whereClause.IsProcuredF !== null ? whereClause.IsProcuredF : ""),
                        BriefDescriptionFF: String(whereClause.BriefDescriptionF !== null ? whereClause.BriefDescriptionF : ""),
                        NumberOfCopiesFF: String(whereClause.NumberOfCopiesF !== null ? whereClause.NumberOfCopiesF : ""),
                        StatusFF: String(whereClause.StatusF !== null ? whereClause.StatusF : ""),
                        PlannedInDateFF: String(whereClause.PlannedInDateF !== null ? whereClause.PlannedInDateF : ""),
                        PlannedOutDateFF: String(whereClause.PlannedOutDateF !== null ? whereClause.PlannedOutDateF : ""),
                        IsSkillFF: "false"
                    };
                    lastAppliedFilterParams = ApplyFilterParameters;
                    var toolsTableBody = $('#tools_tbl tbody');

                    //if ($.fn.DataTable.isDataTable('#tools_tbl')) {
                    //    $('#tools_tbl').DataTable().clear().destroy();
                    //}
                    //toolsTableBody.empty();

                    var table = $('#tools_tbl');

                    if ($.fn.DataTable.isDataTable(table)) {
                        table.DataTable().destroy();
                    }

                    table.find('tbody').empty();



                    var ProjectTools = AJAXCallWithResult("api/PM_ToolsSkill/ApplyFilter", ApplyFilterParameters, false);
                    toolsTableAllIDs = [];
                    ProjectTools.data.forEach(function (data) {
                        toolsTableAllIDs.push(String(data.projectToolID || ''));
                        var row = '<tr>' +
                            //'<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" aria-controls="offcanvas_Tools" onclick="handleToolClick(\'' + data.projectToolID + '\')">' + data.Description + '</a></td>' +
                            
                            '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" aria-controls="offcanvas_Tools" onclick="handleToolClick(\'' + (data.projectToolID ||'') + '\')">' + (data.description || data.parameterName || '') + '</a></td>' +


                            '<td>' + (data.version ? data.version : '') + '</td>' +
                            '<td>' + (data.parameterDesc ? data.parameterDesc : '') + '</td>' +
                            '<td>' +
                            '<span>' +
                            (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                            '</span>' + (data.status ? data.status : '') +
                            '</td>' +
                            '<td>' + (data.percentageUtilization ? data.percentageUtilization : '') + '</td>' +
                            '<td class="sm-wid">' +
                            '<div class="custom_chckbox">' +
                            '<input id="' + data.projectToolID + '" class="chckHead mainchck" type="checkbox">' +
                            '<label for="' + data.projectToolID + '"></label>' +
                            '</div>' +
                            '</td>' +
                            '</tr>';
                        toolsTableBody.append(row);
                    });

                    $('#tools_tbl').DataTable({
                        "paging": true,
                        "pageLength": 10,
                        "bLengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": false,
                        "retrieve": true,
                        "bAutoWidth": false,
                        "info": false,
                        "language": {
                            "emptyTable": "There are no records to view",
                            "zeroRecords": "There are no records to view"
                        }
                    });

                    var ApplyFilterParameters = {
                        ProjectIDFF: String(selectedProjectID),
                        ParameterIdFF: String(whereClause.ParameterIdF !== null ? whereClause.ParameterIdF : ""),
                        VersionFF: String(whereClause.VersionF !== null ? whereClause.VersionF : ""),
                        PercentageUtilizationFF: String(whereClause.PercentageUtilizationF !== null ? whereClause.PercentageUtilizationF : ""),
                        IsCustomerSuppliedFF: String(whereClause.IsCustomerSuppliedF !== null ? whereClause.IsCustomerSuppliedF : ""),
                        IsCriticalFF: String(whereClause.IsCriticalF !== null ? whereClause.IsCriticalF : ""),
                        IsProcuredFF: String(whereClause.IsProcuredF !== null ? whereClause.IsProcuredF : ""),
                        BriefDescriptionFF: String(whereClause.BriefDescriptionF !== null ? whereClause.BriefDescriptionF : ""),
                        NumberOfCopiesFF: String(whereClause.NumberOfCopiesF !== null ? whereClause.NumberOfCopiesF : ""),
                        StatusFF: String(whereClause.StatusF !== null ? whereClause.StatusF : ""),
                        PlannedInDateFF: String(whereClause.PlannedInDateF !== null ? whereClause.PlannedInDateF : ""),
                        PlannedOutDateFF: String(whereClause.PlannedOutDateF !== null ? whereClause.PlannedOutDateF : ""),
                        IsSkillFF: "true"
                    };


                    var ProjectSkills = AJAXCallWithResult("api/PM_ToolsSkill/ApplyFilter", ApplyFilterParameters, false);
                    var savedFilterSkillsData = getSkillsDataArray(ProjectSkills);

                    //Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                    if (savedFilterSkillsData.length === 0) {
                        showSkillsTableNoRecords();
                    } else {
                        var skillsTableBody = $('#skills_tbl tbody');

                        if ($.fn.DataTable.isDataTable('#skills_tbl')) {
                            $('#skills_tbl').DataTable().clear().destroy();
                        }

                        skillsTableBody.empty();
                        skillsTableAllIDs = [];
                        savedFilterSkillsData.forEach(function (data) {
                            skillsTableAllIDs.push(String(data.projectToolID || data.projectToolID || ''));
                            var row = '<tr>' +
                                '<td><a href="#" class="text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Skills" aria-controls="offcanvas_Skills" onclick="handleSkillClick(\'' + data.projectToolID + '\')">' + (data.description || data.parameterName || '') + '</a></td>' +
                                '<td>' + (data.version ? data.version : '') + '</td>' +
                                '<td>' + (data.parameterDesc ? data.parameterDesc : '') + '</td>' +
                                '<td>' +
                                '<span>' +
                                (data.status === "Available" ? '<i class="far fa-check-circle mx-1 mt-1 available_icon"></i>' :
                                    data.status === "Not Available" ? '<i class="far fa-times-circle mx-1 mt-1 not_available_icon"></i>' : '') +
                                '</span>' + (data.status ? data.status : '') +
                                '</td>' +
                                '<td>' + (data.percentageUtilization ? data.percentageUtilization : '') + '</td>' +
                                '<td class="sm-wid">' +
                                '<div class="custom_chckbox">' +
                                '<input id="' + data.projectToolID + '" class="chckHead mainchck" type="checkbox">' +
                                '<label for="' + data.projectToolID + '"></label>' +
                                '</div>' +
                                '</td>' +
                                '</tr>';
                            skillsTableBody.append(row);
                        });
                        initializeSkillsDataTable();
                    }
                    //End of Added and commented by Vishal Mane on 05/06/2026 to fix datatable crash issue
                    toggleClearAllSpan(isDefFilterEnabled);
                } else {
                    isDefFilterEnabled = 0;
                    selectedFilterID = null;
                    populateSkillsTable(selectedProjectID);
                    populateToolsTable(selectedProjectID);
                }
                toggleClearAllSpan(isDefFilterEnabled);
            }
            //End of above function

            //Function to append the data of selected filter to the edit filter offcanvas
            function EditSelectedFilter(filterID, isChecked) {
                if (isChecked == 1) {
                    isAppliedFilterBeingEdited = 1;
                } else {
                    isAppliedFilterBeingEdited = 0;
                }
                selectedFilterID = filterID;
                var Parameters = {
                    FilterID: filterID
                };
                var response = AJAXCallWithResult("api/PM_ToolsSkill/GetSelectedFilterParameter", Parameters, false);

                var whereClause = JSON.parse(response[0].WhereClause);
                var ProjectID = whereClause.ProjectIDF !== null ? parseInt(whereClause.ProjectIDF) : null;
                var ParameterId = whereClause.ParameterIdF !== null ? parseInt(whereClause.ParameterIdF) : null;
                var Version = whereClause.VersionF;
                var PercentageUtilization = whereClause.PercentageUtilizationF !== null ? parseFloat(whereClause.PercentageUtilizationF) : null;
                var IsCustomerSupplied = whereClause.IsCustomerSuppliedF !== null ? parseInt(whereClause.IsCustomerSuppliedF) : null;
                var IsCritical = whereClause.IsCriticalF !== null ? parseInt(whereClause.IsCriticalF) : null;
                var IsProcured = whereClause.IsProcuredF !== null ? parseInt(whereClause.IsProcuredF) : null;
                var BriefDescription = whereClause.BriefDescriptionF;
                var NumberOfCopies = whereClause.NumberOfCopiesF !== null ? parseInt(whereClause.NumberOfCopiesF) : null;
                var Status = whereClause.StatusF;
                var PlannedInDate = whereClause.PlannedInDateF;
                var PlannedOutDate = whereClause.PlannedOutDateF;

                document.getElementById('txt_filter_version2').value = Version;
                document.getElementById('txt_filter_util2').value = (PercentageUtilization === null || isNaN(PercentageUtilization)) ? "" : PercentageUtilization;
                document.getElementById('txt_desc2').value = BriefDescription;
                document.getElementById('txt_copies2').value = (NumberOfCopies === null || NumberOfCopies === undefined || isNaN(NumberOfCopies)) ? "" : NumberOfCopies;

               
                var UsageDropdown = document.getElementById('txtFilter_usage2');
                UsageDropdown.selectedIndex = -1;

                for (var i = 0; i < UsageDropdown.options.length; i++) {
                    if (parseInt(UsageDropdown.options[i].value) === ParameterId) {
                        UsageDropdown.selectedIndex = i;
                        break;
                    }
                }

                var statusDropdown = document.getElementById('txt_filter_status2');
                statusDropdown.value = '';
                if (Status === "Available") {
                    statusDropdown.value = "Available";
                } else if (Status === "Not Available") {
                    statusDropdown.value = "Not Available";
                } else {
                    statusDropdown.value = '';
                }

                var pID = formatDate(PlannedInDate);
                var pOD = formatDate(PlannedOutDate);
                $('#Planned_indate2').datepicker('setDate', pID);
                $('#Planned_out_date2').datepicker('setDate', pOD);

                var iCS = document.getElementById('supplied_cust_filter2');
                if (IsCustomerSupplied === 1) {
                    iCS.value = "1";
                } else if (IsCustomerSupplied === 0) {
                    iCS.value = "0";
                } else {
                    iCS.value = "";
                }

                var iC = document.getElementById('filter_critical2');
                if (IsCritical === 1) {
                    iC.value = "1";
                } else if (IsCritical === 0) {
                    iC.value = "0";
                } else {
                    iC.value = "";
                }

                var iP = document.getElementById('filter_procured2'); 
                if (IsProcured === 1) {
                    iP.value = "1";
                } else if (IsProcured === 0) {
                    iP.value = "0";
                } else {
                    iP.value = "";
                }

                var projectDropdown = document.getElementById('ddl_Projects_filter2');
                projectDropdown.selectedIndex = -1;

                if (ProjectID === null) {
                    projectDropdown.value = "0";
                } else {
                    projectDropdown.value = String(ProjectID);
                }

                $('.selectpicker').selectpicker('refresh');

            }
            //End of above function

            //Function To actually update the selected Filter
            function UpdateFilter() {
                var ProjectID = (document.getElementById('ddl_Projects_filter2').value || "").trim();
                if (ProjectID == 0) {
                    ProjectID = null;
                }
                var ParameterId = (document.getElementById('txtFilter_usage2').value || "").trim();
                var Version = (document.getElementById('txt_filter_version2').value || "").trim();
                var PercentageUtilization = (document.getElementById('txt_filter_util2').value || "").trim();
                var IsCustomerSupplied = (document.getElementById('supplied_cust_filter2').value || "").trim();
                var IsCritical = (document.getElementById('filter_critical2').value || "").trim();
                var IsProcured = (document.getElementById('filter_procured2').value || "").trim();
                var BriefDescription = (document.getElementById('txt_desc2').value || "").trim();
                var NumberOfCopies = (document.getElementById('txt_copies2').value || "").trim();
                var Status = (document.getElementById('txt_filter_status2').value || "").trim();
                var PlannedInDate = $('#Planned_indate2').datepicker('getDate')
                    ? formatDateToYMD($('#Planned_indate2').datepicker('getDate')).trim()
                    : null;
                var PlannedOutDate = $('#Planned_out_date2').datepicker('getDate')
                    ? formatDateToYMD($('#Planned_out_date2').datepicker('getDate')).trim()
                    : null;

                let isValid = true;
                let errorMessage = "";

                //var invalidCharactersRegexForVersion = /[\/\\\:\*\?\<\>\|\'\"\,\+\-]/;

                //invalidCharactersRegexForVersion = new RegExp("[" + (SpecialCharactersList + `^&()[]|\\'":;,` + "`~#").replace(/[-\/\\^$*+?.()|[\]{}'"!:;,`~#&]/g, '\\$&') + "]");


             <%--   if (Parameters.ParameterId && Parameters.ParameterId == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_Usage_Blank")%></span>");
                    return;
                }--%>

                if (Version && invalidCharactersRegex.test(Version)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'Version' cannot contain any of these /\\:*?<>'|,\"+- characters.</span>");
                    return;
                }

                if (PercentageUtilization /*&& isNaN(PercentageUtilization.trim())*/) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationShouldBeValidNumber")%></span>");
                    return;
                }

                if (PercentageUtilization && parseFloat(PercentageUtilization) > 100) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_UtilizationCannotExceed")%></span>");
                    return;
                }

                if (BriefDescription && invalidCharactersRegex.test(BriefDescription)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>A 'BriefDescription' cannot contain any of these /\\:*?<>'|,\"+- characters</span>");
                    return;
                }

                if (BriefDescription!== null && BriefDescription.length > 1000) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>"
                    + "<%=MyBase.GetResourceString("A_BriefDescriptionMaxLengthExceeded")%> "
                    + "<%=MyBase.GetResourceString("A_YouHaveEntered")%> " + BriefDescription.length + " <%=MyBase.GetResourceString("A_Characters")%>."
                    + "</span>");
                    return;
                }

                if (BriefDescription) {
                    BriefDescription = BriefDescription.replace(/'/g, "''");
                }

                if (NumberOfCopies && (isNaN(NumberOfCopies.trim()) || !/^\d+$/.test(NumberOfCopies) || parseInt(NumberOfCopies) < 0)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_NoOfCopiesShouldBeValidNumber")%></span>");
                    return;
                }

                if (PlannedOutDate && PlannedInDate && PlannedOutDate < PlannedInDate) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_PlannedOutDateCannot")%></span>");
                    return;
                }

                if (!isValid) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>" + errorMessage.replace(/\n/g, "<br>") + "</span>");
                    return;
                }

                var WhereClause = {
                    ProjectIDF: ProjectID,
                    ParameterIdF: ParameterId,
                    VersionF: Version,
                    PercentageUtilizationF: PercentageUtilization,
                    IsCustomerSuppliedF: IsCustomerSupplied,
                    IsCriticalF: IsCritical,
                    IsProcuredF: IsProcured,
                    BriefDescriptionF: BriefDescription,
                    NumberOfCopiesF: NumberOfCopies,
                    StatusF: Status,
                    PlannedInDateF: PlannedInDate,
                    PlannedOutDateF: PlannedOutDate
                };

                var Parameters = {
                    FilterID: selectedFilterID,
                    UserId: UserId,
                    WhereClause: JSON.stringify(WhereClause),
                };

                var updateResult = AJAXCallWithResult("api/PM_ToolsSkill/UpdateExistingFilter", Parameters, false);

                if (updateResult) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_FilterUpdatedSuccessfully!")%></span>");

                    if (isAppliedFilterBeingEdited === 1) {
                        applySelectedFilter(selectedFilterID, 1);
                    }

                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_ErrorUpdatingFilter!")%></span>");
                }
            }
            //End of above function

            //Function to set default expected values for filter fields
            function setDefaultFilterFields() {


                var UsageDropdown = document.getElementById('txtFilter_usage');
                UsageDropdown.selectedIndex = 0;

                $('.selectpicker').selectpicker('refresh');

                const filterElement = document.getElementById("tools_skills_filter");
                if (filterElement.style.display === "none" || filterElement.style.display === "") {
                    filterElement.style.display = "block";
                } else {
                    filterElement.style.display = "none";
                }
            }
            //End of above function

            //function to clear all the applied filter even the default one
          
            function clearAllFilters() {
                
                // Reset filter state flags
                basicFilterAppliedOnApplyClick = 0;
                selectedFilterID = null;
                clearFilters = 1;
                isDefFilterEnabled = 0;
                isFilterCanceled = 1;          // Ensure unfiltered data is loaded
                lastAppliedFilterParams = null;

                // Hide the filter panel using Bootstrap's collapse method
                $('#filterpanel').collapse('hide');


                // Remove any inline styles from filter panel inner elements
                const filterPanelBody = document.querySelector('.filterpanelbody');
                if (filterPanelBody) {
                    filterPanelBody.style.display = '';
                }
                const filterElement = document.getElementById("tools_skills_filter");
                if (filterElement) {
                    filterElement.style.display = '';
                }

                // Clear all filter input fields
                document.getElementById('txtFilter_usage').value =0;
                document.getElementById('txt_filter_version').value = "";
                document.getElementById('txt_filter_util').value = "";
                document.getElementById('supplied_cust_filter').selectedIndex = 0;
                document.getElementById('filter_critical').selectedIndex = 0;
                document.getElementById('filter_procured').selectedIndex = 0;
                document.getElementById('txt_desc').value = "";
                document.getElementById('txt_copies').value = "";
                document.getElementById('txt_filter_status').value = "";
                $('#Planned_indate').datepicker('setDate', null);
                $('#Planned_out_date').datepicker('setDate', null);

                // Refresh select pickers
                $('.selectpicker').selectpicker('refresh');

                // Reload tables without filters
                var selectedProjectID = document.getElementById('ddl_Projects') ? document.getElementById('ddl_Projects').value : defaultProjectID;
                if (!selectedProjectID || selectedProjectID === "0") {
                    selectedProjectID = defaultProjectID;
                }
                populateToolsTable(selectedProjectID);
                populateSkillsTable(selectedProjectID);

                // Update the Clear All button and filter icon appearance
                toggleClearAllSpan(isDefFilterEnabled);

                // Success message
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_ClearedSuccessfully")%></span>");
            }
            //End of above function

            //Function for History date formating
          
            function formatHistoryDate(dateStr) {
                if (!dateStr) return '';

                // Try to extract a clean date part (ignore time and timezone)
                let match = dateStr.match(/^(\d{4})-(\d{2})-(\d{2})/);
                if (!match) {
                    // Try ISO format with T
                    match = dateStr.match(/^(\d{4})-(\d{2})-(\d{2})T/);
                }
                if (!match) return dateStr; // fallback

                const year = match[1];
                const month = parseInt(match[2], 10) - 1;
                const day = parseInt(match[3], 10);

                const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

                return `${day.toString().padStart(2, '0')} ${months[month]} ${year}`;
            }
            //End of above function



            //Function to fetch history of tool and append it to the table
            function NextResdetailTool() {
                $(".Resourcedetailpanel").show();
                $(".offcanvas-body").animate(
                    {
                        scrollTop: $(".Resourcedetailpanel").offset().top - 60,
                    },
                    "slow"
                );
                $(".table").resize();

                var Parameters = {
                    ProjID: selectedProjectID,
                    UniqueID: hyperLinkedToolID
                }

               
                var response = AJAXCallWithResult("api/PM_ToolsSkill/GetHistoryOfSelectedToolsOrSkills", Parameters, false);

                
                toolhistory = (response && response.data) ? response.data : [];

                var tableBody = document.getElementById('Tools_Show_History_Tbl').getElementsByTagName('tbody')[0];
                if ($.fn.DataTable.isDataTable('#Tools_Show_History_Tbl')) {
                    $('#Tools_Show_History_Tbl').DataTable().clear().destroy();
                }
                tableBody.innerHTML = '';

                //var dateOptions = { day: 'numeric', month: 'long', year: 'numeric' };
                var dateOptions = { day: '2-digit', month: 'short', year: 'numeric' };

                var fieldNames = new Set();
                var modifiedBy = new Set();

                toolhistory.forEach(function (data, index) {
                 

                    //var dateStr = '';
                    //if (data.date) {
                    //    dateStr = new Date(data.date).toLocaleDateString('en-US', dateOptions);
                    //}
                    var dateStr = data.date ? formatHistoryDate(data.date) : '';

                    // Format old/new values if the field is a date
                    var oldVal = data.oldValue || '';
                    var newVal = data.newValue || '';
                    if (data.fieldName && data.fieldName.toLowerCase().includes('date')) {
                        oldVal = formatHistoryDate(oldVal);
                        newVal = formatHistoryDate(newVal);
                    }

                    var row = '<tr class="' + (index % 2 === 0 ? 'even' : 'odd') + '">' +
                        '<td>' + (data.fieldName || '') + '</td>' +
                        '<td>' + dateStr + '</td>' +
                        //'<td>' + (data.value || '') + '</td>' +
                        //'<td>' + (data.oldValue || '') + '</td>' +
                        //'<td>' + (data.newValue || '') + '</td>' +
                        '<td>' + oldVal + '</td>' +
                        '<td>' + newVal + '</td>' +

                        '<td>' + (data.modifiedBy || '') + '</td>' +
                        '</tr>';
                    tableBody.innerHTML += row;

                    if (data.fieldName) fieldNames.add(data.fieldName);
                    if (data.modifiedBy) modifiedBy.add(data.modifiedBy);
                });

                // Populate Filter Dropdowns
                var fieldNameDropdown = document.getElementById('modifiedHisFieldTool');
                fieldNameDropdown.innerHTML = '';
                fieldNameDropdown.innerHTML = '<option>Select Option</option>';
                fieldNames.forEach(function (fieldName) {
                    var option = document.createElement('option');
                    option.text = fieldName;
                    fieldNameDropdown.add(option);
                });

                var modifiedByDropdown = document.getElementById('modifiedHisByTool');
                modifiedByDropdown.innerHTML = '';
                modifiedByDropdown.innerHTML = '<option>Select Option</option>';
                modifiedBy.forEach(function (user) {
                    var option = document.createElement('option');
                    option.text = user;
                    modifiedByDropdown.add(option);
                });

                $('#Tools_Show_History_Tbl').DataTable({
                    "pageLength": 5,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "responsive": true
                });

                $(modifiedByDropdown).selectpicker('refresh');
                $(fieldNameDropdown).selectpicker('refresh');

                document.getElementById('modifiedHisFieldTool').addEventListener('change', filterAndAppendToolData);
                document.getElementById('modifiedHisByTool').addEventListener('change', filterAndAppendToolData);
            }
            //End of above function


            function NextResdetailSkill() {
               
                $(".Resourcedetailpanel").show();
                $(".offcanvas-body").animate(
                    {
                        scrollTop: $(".Resourcedetailpanel").offset().top - 60,
                    },
                    "slow"
                );
                $(".table").resize();

                var Parameters = {
                    ProjID: selectedProjectID,
                    UniqueID: hyperLinkedSkillID
                };

                var response = AJAXCallWithResult("api/PM_ToolsSkill/GetHistoryOfSelectedToolsOrSkills", Parameters, false);

                skillhistory = (response && response.data) ? response.data : [];

                var tableBody = document.getElementById('Skills_Show_History_Tbl').getElementsByTagName('tbody')[0];
                if ($.fn.DataTable.isDataTable('#Skills_Show_History_Tbl')) {
                    $('#Skills_Show_History_Tbl').DataTable().clear().destroy();
                }
                tableBody.innerHTML = '';

                //var dateOptions = { day: 'numeric', month: 'long', year: 'numeric' };
                //var dateOptions = { day: '2-digit', month: 'short', year: 'numeric' };



                var fieldNames = new Set();
                var modifiedBy = new Set();

                skillhistory.forEach(function (data, index) {

                    //var dateStr = '';
                    //if (data.date) {
                    //    dateStr = new Date(data.date).toLocaleDateString('en-US', dateOptions);
                    //}
                    var dateStr = data.date ? formatHistoryDate(data.date) : '';

                    // Format old/new values if the field is a date
                    var oldVal = data.oldValue || '';
                    var newVal = data.newValue || '';
                    if (data.fieldName && data.fieldName.toLowerCase().includes('date')) {
                        oldVal = formatHistoryDate(oldVal);
                        newVal = formatHistoryDate(newVal);
                    }

                    

                    var row = '<tr class="' + (index % 2 === 0 ? 'even' : 'odd') + '">' +
                        '<td>' + (data.fieldName || '') + '</td>' +
                        '<td>' + dateStr + '</td>' +
                        //'<td>' + (data.value || '') + '</td>' +
                        //'<td>' + (data.oldValue || '') + '</td>' +
                        //'<td>' + (data.newValue || '') + '</td>' +
                        '<td>' + oldVal + '</td>' +
                        '<td>' + newVal + '</td>' +
                        '<td>' + (data.modifiedBy || '') + '</td>' +
                        '</tr>';
                    tableBody.innerHTML += row;

                    if (data.fieldName) fieldNames.add(data.fieldName);
                    if (data.modifiedBy) modifiedBy.add(data.modifiedBy);
                });

                var fieldNameDropdown = document.getElementById('modifiedHisFieldSkill');
                fieldNameDropdown.innerHTML = '';
                fieldNameDropdown.innerHTML = '<option>Select Option</option>';
                fieldNames.forEach(function (fieldName) {
                    var option = document.createElement('option');
                    option.text = fieldName;
                    fieldNameDropdown.add(option);
                });

                var modifiedByDropdown = document.getElementById('modifiedHisBySkill');
                modifiedByDropdown.innerHTML = '';
                modifiedByDropdown.innerHTML = '<option>Select Option</option>';
                modifiedBy.forEach(function (user) {
                    var option = document.createElement('option');
                    option.text = user;
                    modifiedByDropdown.add(option);
                });

                $('#Skills_Show_History_Tbl').DataTable({
                    "pageLength": 5,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "autoWidth": false,
                    "info": false
                });

                $(modifiedByDropdown).selectpicker('refresh');
                $(fieldNameDropdown).selectpicker('refresh');

                document.getElementById('modifiedHisFieldSkill').addEventListener('change', filterAndAppendSkillData);
                document.getElementById('modifiedHisBySkill').addEventListener('change', filterAndAppendSkillData);
            }
            //End of above function

            //Function to Toggle the clear all option 
         
            function toggleClearAllSpan(isDefFilterEnabled) {
                var clearAllSpan = document.getElementById('ProjectClearAllFilter');

                if (isDefFilterEnabled === 0) {
                    clearAllSpan.style.display = 'none';
                    // Reset to simple black icon when no filter is applied
                    document.getElementById('AdvanceFilterIcon').style.backgroundColor = 'transparent';
                    document.getElementById('AdvanceFilterIcon').style.color = '#374151';
                    document.getElementById('AdvanceFilterIcon').style.borderRadius = '0';
                    document.getElementById('AdvanceFilterIcon').style.width = 'auto';
                    document.getElementById('AdvanceFilterIcon').style.height = 'auto';
                    document.getElementById('AdvanceFilterIcon').style.display = 'inline-block';
                    document.getElementById('AdvanceFilterIcon').style.alignItems = 'normal';
                    document.getElementById('AdvanceFilterIcon').style.justifyContent = 'normal';
                } else {
                    clearAllSpan.style.display = 'inline';
                    // Apply blue square styling when filter is applied
                    document.getElementById('AdvanceFilterIcon').style.backgroundColor = '#1359a6';
                    document.getElementById('AdvanceFilterIcon').style.color = 'white';
                    document.getElementById('AdvanceFilterIcon').style.borderRadius = '0.375rem';
                    document.getElementById('AdvanceFilterIcon').style.width = '2rem';
                    document.getElementById('AdvanceFilterIcon').style.height = '2rem';
                    document.getElementById('AdvanceFilterIcon').style.display = 'flex';
                    document.getElementById('AdvanceFilterIcon').style.alignItems = 'center';
                    document.getElementById('AdvanceFilterIcon').style.justifyContent = 'center';
                }
            }
            //End of above fucntion




            // ------------------------------------------
            // Select All for Tools (all pages) - use toolsTableAllIDs so all records are selected and sent to delete API
            // ------------------------------------------
            $("#toolsSltAll").on("click", function () {
                var isChecked = $(this).prop("checked");
                if (!$.fn.DataTable.isDataTable('#tools_tbl')) return;
                var table = $("#tools_tbl").DataTable();
                if (isChecked) {
                    selectedToolIDsSet.clear();
                    for (var i = 0; i < toolsTableAllIDs.length; i++) {
                        selectedToolIDsSet.add(String(toolsTableAllIDs[i]));
                    }
                } else {
                    selectedToolIDsSet.clear();
                }
                table.rows({ page: 'current' }).nodes().each(function () {
                    var cb = $(this).find(".mainchck");
                    cb.prop("checked", selectedToolIDsSet.has(String(cb.attr("id"))));
                });
                $(this).prop('checked', isChecked);
            });

            // ------------------------------------------
            // Select All for Skills (all pages) - use skillsTableAllIDs so all records are selected and sent to delete API
            // ------------------------------------------
            $("#Skills_checkAll").on("click", function () {
                var isChecked = $(this).prop("checked");
                if (!$.fn.DataTable.isDataTable('#skills_tbl')) return;
                var table = $("#skills_tbl").DataTable();
                if (isChecked) {
                    selectedSkillIDsSet.clear();
                    for (var i = 0; i < skillsTableAllIDs.length; i++) {
                        selectedSkillIDsSet.add(String(skillsTableAllIDs[i]));
                    }
                } else {
                    selectedSkillIDsSet.clear();
                }
                table.rows({ page: 'current' }).nodes().each(function () {
                    var cb = $(this).find(".main_Skills");
                    cb.prop("checked", selectedSkillIDsSet.has(String(cb.attr("id"))));
                });
                $(this).prop('checked', isChecked);
            });

            // Individual tool checkbox: update set and sync header (uncheck header if any unchecked)
            $('#tools_tbl tbody').on('change', '.mainchck', function () {
                var id = String($(this).attr("id"));
                if (!id) return;
                if ($(this).prop("checked")) {
                    selectedToolIDsSet.add(id);
                } else {
                    selectedToolIDsSet.delete(id);
                }
                var table = $('#tools_tbl').DataTable();
                var totalRows = table.rows({ page: 'all' }).count();
                $('#toolsSltAll').prop('checked', totalRows > 0 && selectedToolIDsSet.size === totalRows);
            });
            // Individual skill checkbox: update set and sync header (uncheck header if any unchecked)
            $('#skills_tbl tbody').on('change', '.main_Skills', function () {
                var id = String($(this).attr("id"));
                if (!id) return;
                if ($(this).prop("checked")) {
                    selectedSkillIDsSet.add(id);
                } else {
                    selectedSkillIDsSet.delete(id);
                }
                if ($.fn.DataTable.isDataTable('#skills_tbl')) {
                    var table = $('#skills_tbl').DataTable();
                    var totalRows = table.rows({ page: 'all' }).count();
                    $('#Skills_checkAll').prop('checked', totalRows > 0 && selectedSkillIDsSet.size === totalRows);
                }
            });

            // On page change / draw: re-apply Tools selection from set so checkboxes stay correct
            $(document).on('draw.dt', '#tools_tbl', function () {
                if (!$.fn.DataTable.isDataTable('#tools_tbl')) return;
                var table = $('#tools_tbl').DataTable();
                table.rows({ page: 'current' }).nodes().each(function () {
                    var cb = $(this).find(".mainchck");
                    cb.prop("checked", selectedToolIDsSet.has(String(cb.attr("id"))));
                });
                var totalRows = table.rows({ page: 'all' }).count();
                $('#toolsSltAll').prop('checked', totalRows > 0 && selectedToolIDsSet.size === totalRows);
            });
            // On page change / draw: re-apply Skills selection from set
            $(document).on('draw.dt', '#skills_tbl', function () {
                if (!$.fn.DataTable.isDataTable('#skills_tbl')) return;
                var table = $('#skills_tbl').DataTable();
                table.rows({ page: 'current' }).nodes().each(function () {
                    var cb = $(this).find(".main_Skills");
                    cb.prop("checked", selectedSkillIDsSet.has(String(cb.attr("id"))));
                });
                var totalRows = table.rows({ page: 'all' }).count();
                $('#Skills_checkAll').prop('checked', totalRows > 0 && selectedSkillIDsSet.size === totalRows);
            });

            //change date format
            var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            var uDatepicker = $.datepicker._updateDatepicker;
            $.datepicker._updateDatepicker = function () {
                var ret = uDatepicker.apply(this, arguments);
                var $sel = this.dpDiv.find('select');
                $sel.find('option').each(function (i) {
                    $(this).text(months[i]);
                });
                return ret;
            };

            $('#Planned_indate, #Planned_out_date, #Planned_indate2, #Planned_out_date2').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd M yy'
            });


            $('#RRdate').datepicker({
                autoclose: true,
                changeYear: true,
            });

            $('#plannedDate, #plannedOutDate, #plannedDateModal, #plannedOutDateModal, #plannedDateModalForSkill, #plannedOutDateModalForSkill,#plannedDateModalForTool, #plannedOutDateModalForTool, #plannedDateModalForSkillAdd, #plannedOutDateModalForSkillAdd,#plannedDateModalForToolAdd, #plannedOutDateModalForToolAdd,  #datetimepicker1').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd M yy'
            });

            $('[data-bs-toggle="tooltip"]').tooltip();

            $('.hiddenRow').on('show.bs.collapse', function () {
                $(this).prev(".accordion-toggle").toggleClass("in");
            });
            $('.hiddenRow').on('hidden.bs.collapse', function () {
                $(this).prev(".accordion-toggle").removeClass("in");
            });


            $(function () {
                $('[data-bs-toggle="tooltip"]').tooltip()
            })
            $(document).on("click", function () {
                $(".tooltip").remove();
            });

            // Filter panel collapse event handlers - show/hide Clear All button and style filter icon
            $("#filterpanel").on("show.bs.collapse", function () {
                // Change filter button to blue square with white icon when panel opens
                document.getElementById('AdvanceFilterIcon').style.backgroundColor = '#1359a6';
                document.getElementById('AdvanceFilterIcon').style.color = 'white';
                document.getElementById('AdvanceFilterIcon').style.borderRadius = '0.375rem';
                document.getElementById('AdvanceFilterIcon').style.width = '2rem';
                document.getElementById('AdvanceFilterIcon').style.height = '2rem';
                document.getElementById('AdvanceFilterIcon').style.display = 'flex';
                document.getElementById('AdvanceFilterIcon').style.alignItems = 'center';
                document.getElementById('AdvanceFilterIcon').style.justifyContent = 'center';
            });
            $("#filterpanel").on("hide.bs.collapse", function () {
                // Only reset filter icon styling if no filters are currently applied
                if (basicFilterAppliedOnApplyClick === 0 && isDefFilterEnabled === 0) {
                    // Change filter button back to simple black icon when panel closes and no filters are applied
                    document.getElementById('AdvanceFilterIcon').style.backgroundColor = 'transparent';
                    document.getElementById('AdvanceFilterIcon').style.color = '#374151';
                    document.getElementById('AdvanceFilterIcon').style.borderRadius = '0';
                    document.getElementById('AdvanceFilterIcon').style.width = 'auto';
                    document.getElementById('AdvanceFilterIcon').style.height = 'auto';
                    document.getElementById('AdvanceFilterIcon').style.display = 'inline-block';
                    document.getElementById('AdvanceFilterIcon').style.alignItems = 'normal';
                    document.getElementById('AdvanceFilterIcon').style.justifyContent = 'normal';
                }
            });


            //Function to append no records message
            function appendNoRecordsMessage(tableBody, colspan) {
                tableBody.append('<tr><td colspan="' + colspan + '" class="text-center" style="padding:20px;">  <%=MyBase.GetResourceString("C_NoRecordsToView")%></td></tr>');
            }
        </script>
        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
</body>

</html> 
