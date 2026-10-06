<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_GDPRSettings.aspx.vb" Inherits="Whizible.RM_GDPRSettings" %>


<!DOCTYPE html>
<html>
<%CommonFunctions.General.PlotPageHeadTag("GDPR Settings")%>
<head>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
</head>
<style type="text/css">
    .dropdown-item.active, .dropdown-item:active {
        background-color: #f3f3f3;
    }
    .table-stripped tbody tr:nth-child(even) {
    background: #fbfbfb;
}
    h5.pgtitle {
        margin: 6px 0 0;
        font-weight: 700;
        color: #4263c1;
        font-size: 16px;
    }

    .panel-default > .panel-heading {
        color: #333;
        font-weight: 500;
        padding: 10px 15px;
    }

    .p-0 {
        padding: 0 !important;
    }
    /* Added by Aditya J. - GDPR tab active/inactive text colors */
    #gdprConfigTabs .nav-link {
        color: #000 !important;
    }

        #gdprConfigTabs .nav-link.active {
            color: #4263c1 !important;
        }
    /* GDPR toggle switch - ON = enabled (1), OFF = disabled (0); UI only */
    .gdpr-toggle-wrap {
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }
    /* Grey out only toggle when field/subtab is disabled (toggle OFF) */
    #gdprSettingsTbl tbody tr.gdpr-row-disabled td:last-child .gdpr-toggle-wrap,
    #gdprSubtabTbl tbody tr.gdpr-row-disabled td:last-child .gdpr-toggle-wrap {
        opacity: 0.45;
    }
    /* Smaller toggle - override global cmn-toggle-round-flat (same size for Fields & Subtab) */
    #gdprSettingsTbl .gdpr-toggle-wrap input.cmn-toggle-round-flat + label,
    #gdprSubtabTbl .gdpr-toggle-wrap input.cmn-toggle-round-flat + label {
        width: 38px;
        height: 20px;
        padding: 2px;
        top: 0;
    }

        #gdprSettingsTbl .gdpr-toggle-wrap input.cmn-toggle-round-flat + label:before,
        #gdprSubtabTbl .gdpr-toggle-wrap input.cmn-toggle-round-flat + label:before {
            top: 2px;
            left: 2px;
            bottom: 2px;
            right: 2px;
        }

        #gdprSettingsTbl .gdpr-toggle-wrap input.cmn-toggle-round-flat + label:after,
        #gdprSubtabTbl .gdpr-toggle-wrap input.cmn-toggle-round-flat + label:after {
            width: 14px;
            top: 3px;
            right: 3px;
            bottom: 3px;
        }

    #gdprSettingsTbl .gdpr-toggle-wrap input.cmn-toggle-round-flat:checked + label:after,
    #gdprSubtabTbl .gdpr-toggle-wrap input.cmn-toggle-round-flat:checked + label:after {
        margin-right: 22px;
    }
    /* Added by Aditya J. - make Enable/Visible column slightly wider */
    #gdprSettingsTbl th:last-child,
    #gdprSettingsTbl td:last-child,
    #gdprSubtabTbl th:last-child,
    #gdprSubtabTbl td:last-child {
        width: 110px;
        min-width: 110px;
    }

    /* Added by Gauri - Fullscreen loader overlay for this page */
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

    /* Added by Gauri - Initial page-load preloader (center GIF before JS runs) */
    .preloader {
        position: fixed;
        top: 50%;
        left: 50%;
        width: 100px;
        height: 100px;
        margin: -50px 0 0 -50px;
        background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
        z-index: 2100;
        /* above overlay so GIF is visible even before JS initializes */
    }

    /* Added by Aditya J. - GDPR Settings History offcanvas styling */
    .offcanvas {
        --bs-offcanvas-width: 85%;
    }

    /* Matches PM_ProjectSites offcanvas close button look */
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

    /* Added by Aditya J. - GDPR history filter dropdown styling
           Match Project Charter rectangular bootstrap-select look */
    #gdprSettingsHistoryOffcanvas .selectpicker {
        background-color: #fff !important;
        border: 1px solid #ccc !important;
        border-radius: 4px !important;
        color: #000 !important;
    }

    #gdprSettingsHistoryOffcanvas .bootstrap-select {
        width: 100% !important;
    }

        #gdprSettingsHistoryOffcanvas .bootstrap-select > .dropdown-toggle {
            width: 100% !important;
            min-height: 30px !important;
            height: 30px !important;
            padding: 4px 10px !important;
            border: 1px solid #ced4da !important;
            border-radius: 4px !important;
            background-color: #fff !important;
            color: #000 !important;
            box-shadow: none !important;
        }

        #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-toggle .filter-option-inner-inner {
            color: #000 !important;
            font-size: 12px !important;
            line-height: 20px !important;
        }

        #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu li {
            position: relative;
            font-size: 12px !important;
        }

            #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu li a,
            #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu li a span,
            #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu li .text,
            #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu .dropdown-item,
            #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu .dropdown-item span,
            #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu .dropdown-item .text {
                color: #000 !important;
                opacity: 1 !important;
            }

                #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu .dropdown-item:hover,
                #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu .dropdown-item:focus,
                #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu .selected .dropdown-item {
                    color: #000 !important;
                    background-color: #f8f9fa !important;
                }

                /* Added by Aditya J. - force bootstrap-select option text visibility in history filters */
                #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu .inner,
                #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu .inner.show,
                #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu li,
                #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu li a,
                #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu li a span.text,
                #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu .dropdown-item,
                #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-menu .dropdown-item .text {
                    display: block !important;
                    visibility: visible !important;
                    color: #000 !important;
                    font-size: 12px !important;
                    line-height: 18px !important;
                }

        #gdprSettingsHistoryOffcanvas .bootstrap-select .bs-searchbox input {
            color: #000 !important;
            background-color: #fff !important;
        }

        #gdprSettingsHistoryOffcanvas .bootstrap-select .dropdown-toggle:focus,
        #gdprSettingsHistoryOffcanvas .bootstrap-select > .dropdown-toggle.show,
        #gdprSettingsHistoryOffcanvas .bootstrap-select > .dropdown-toggle:hover {
            border-color: #000 !important;
            box-shadow: none !important;
            outline: none !important;
        }
</style>
<body class="hold-transition skin-blue-light sidebar-mini fixed settings-para" id="BodyGDPRSettings">
    <!-- Added by Gauri - Initial page-load preloader -->
    <div id="GDPRSec" class="preloader"></div>

    <!-- Page Loader - Show during AJAX calls -->
    <div class="loader-overlay" id="loaderOverlay" style="display: none;">
        <div class="loader"></div>
    </div>

    <div id="GDPRWrapper" style="display: none;">
        <%If m_blnViewAccess = True Then%>
        <div class="bgwhite">
            <div class="pt-1 pb-1 graybg">
                <div class="col-sm-12">
                    <h2 style="color: #1e40af; font-weight: 600; font-size: 18px; margin: 0 0 0.25rem 0; display: flex; align-items: center;">
                        <i class="fas fa-shield-alt" style="color: #1e40af; font-size: 1.5rem; margin-right: 0.75rem;" data-bs-toggle="tooltip" title="GDPR Settings"></i>
                        <%=MyBase.GetResourceString("C_PageCaption") %>
                </h2>
                    <p style="color: #6b7280; font-size: 0.7rem; margin: 0;"><%=MyBase.GetResourceString("C_PageHeadNote") %></p>
                </div>
                <div class="clearfix"></div>
            </div>

            <div class="content pt-1">
                <div class="container-fluid pt-1 text-right">
                    <%If m_blnAddAccess = True Then%>
                    <button type="button" class="btn btnyellow mr-5" id="btnSaveGDPR" onclick="gdprSaveConfig();"><%=MyBase.GetResourceString("C_SaveSettings") %></button>
                    <!-- Added by Aditya J. - GDPR Settings History -->
                    <button type="button"
                        class="btn borderbtn btn-sm"
                        id="btnShowGDPRHistory"
                        data-bs-toggle="offcanvas"
                        data-bs-target="#gdprSettingsHistoryOffcanvas"
                        aria-controls="gdprSettingsHistoryOffcanvas">
                        Show History
                       
                    </button>
                    <%End If%>
                </div>
                <div class="pt-2">
                    <div style="background: #fdecea; border: 1px solid #f5c6cb; border-radius: 4px; padding: 8px 10px; margin-bottom: 15px;">
                        <strong><%=MyBase.GetResourceString("C_HiddenFileds") %>:</strong><br />
                        <span class="badge" style="background: #dc3545; color: #fff; padding: 3px 8px; border-radius: 3px; margin-top: 4px; display: inline-block;"><%=MyBase.GetResourceString("C_BloodGroup") %></span>
                        <span class="badge" style="background: #dc3545; color: #fff; padding: 3px 8px; border-radius: 3px; margin-top: 4px; display: inline-block;"><%=MyBase.GetResourceString("C_PassportDetails") %></span>
                    </div>
                    <p><strong><%=MyBase.GetResourceString("C_ConfigurableFields") %>:</strong> <%=MyBase.GetResourceString("C_PageNote") %></p>
                    <ul class="nav nav-tabs mb-2" id="gdprConfigTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="tab-fields" data-bs-toggle="tab" data-bs-target="#pane-fields" type="button" role="tab" aria-controls="pane-fields" aria-selected="true"><%=MyBase.GetResourceString("C_Fields") %></button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="tab-subtab" data-bs-toggle="tab" data-bs-target="#pane-subtab" type="button" role="tab" aria-controls="pane-subtab" aria-selected="false"><%=MyBase.GetResourceString("C_Subtabs") %></button>
                        </li>
                    </ul>
                    <div class="tab-content" id="gdprConfigTabContent">
                        <div class="tab-pane fade show active" id="pane-fields" role="tabpanel" aria-labelledby="tab-fields">
                            <div class="table-responsive">
                                <table class="table table-bordered table-sm" id="gdprSettingsTbl">
                                    <thead style="background: #f5f5f5;">
                                        <tr>
                                            <th><%=MyBase.GetResourceString("C_Field") %></th>
                                            <th style="width: 110px; text-align: center;"><%=MyBase.GetResourceString("C_Visible") %></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_BirthDate") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprChkBirthDate" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox" checked>
                                                    <label for="gdprChkBirthDate"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_EmailID") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprChkEmail" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox" checked>
                                                    <label for="gdprChkEmail"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_Gender") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprChkGender" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox" checked>
                                                    <label for="gdprChkGender"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_EmployeeType") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprChkEmployeeType" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox" checked>
                                                    <label for="gdprChkEmployeeType"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_MessengerID") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprChkMessanger" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox" checked>
                                                    <label for="gdprChkMessanger"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_ExtensionNo") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprChkExtensionNo" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox" checked>
                                                    <label for="gdprChkExtensionNo"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_CPermAddress") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprChkAddress" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox" checked>
                                                    <label for="gdprChkAddress"></label>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="pane-subtab" role="tabpanel" aria-labelledby="tab-subtab">
                            <div class="table-responsive">
                                <table class="table table-bordered table-sm" id="gdprSubtabTbl">
                                    <thead style="background: #f5f5f5;">
                                        <tr>
                                            <th><%=MyBase.GetResourceString("C_Subtabs") %></th>
                                            <th style="width: 110px; text-align: center;">Enable</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_AdvancedInfo") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprSubtabAdvancedInfo" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox">
                                                    <label for="gdprSubtabAdvancedInfo"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_Certifications") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprSubtabCertifications" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox">
                                                    <label for="gdprSubtabCertifications"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_VisaDetails") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprSubtabVisaDetails" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox">
                                                    <label for="gdprSubtabVisaDetails"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_Qualifications") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprSubtabQualifications" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox">
                                                    <label for="gdprSubtabQualifications"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_PrevWorkExp") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprSubtabPrevWorkExp" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox">
                                                    <label for="gdprSubtabPrevWorkExp"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="gdpr-row">
                                            <td><%=MyBase.GetResourceString("C_PrevAssignment") %></td>
                                            <td style="text-align: center;">
                                                <div class="gdpr-toggle-wrap">
                                                    <input id="gdprSubtabPrevAssignment" class="gdpr-toggle cmn-toggle cmn-toggle-round-flat" type="checkbox">
                                                    <label for="gdprSubtabPrevAssignment"></label>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%If m_blnAddAccess = True Then%>
            <!-- Added by Aditya J. - GDPR Settings History (Offcanvas + Dynamic API load) -->
            <div class="offcanvas offcanvas-end" data-bs-scroll="true" tabindex="-1" id="gdprSettingsHistoryOffcanvas"
                aria-labelledby="gdprSettingsHistoryOffcanvasLabel">
                <div class="offcanvas-body px-0" style="padding-top: 0px;">
                    <ul class="nav nav-tabs detailsubtabs mt-2 d-flex align-items-center">
                        <li class="nav-item">
                            <a class="nav-link active" href="#gdprHistoryTab" data-bs-toggle="tab"><%=MyBase.GetResourceString("C_History") %></a>
                        </li>
                        <li class="nav-item ms-auto border-0 d-flex align-items-center pe-2">
                            <button type="button"
                                class="offcanvas-close-btn"
                                data-bs-dismiss="offcanvas"
                                aria-label="Close"
                                data-bs-toggle="tooltip"
                                data-bs-custom-class="black-tooltip"
                                data-bs-placement="top"
                                title="Close">
                                &#x2715;</button>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <div id="gdprHistoryTab" class="tab-pane active mt-4">
                            <div class="projDetailsContent projDetailsShowHistory">
                                <div class="container-fluid">
                                    <div class="ShowHistoryContent">
                                        <!-- Added by Aditya J. - GDPR Settings History filters (aligned like Project Charter) -->
                                        <div class="row mb-2 px-3 align-items-center">
                                            <div class="col-sm-2 text-end">
                                                <label class="form-label mb-0"><%=MyBase.GetResourceString("C_ModifiedField") %></label>
                                            </div>
                                            <div class="col-sm-3">
                                                <select id="gdprModifiedHisField" class="selectpicker w-100" data-live-search="true">
                                                </select>
                                            </div>
                                            <div class="col-sm-2 text-end">
                                                <label class="form-label mb-0"><%=MyBase.GetResourceString("C_ModifiedBy") %></label>
                                            </div>
                                            <div class="col-sm-3">
                                                <select id="gdprModifiedHisBy" class="form-control selectpicker w-100" data-live-search="true" title="Select Modified By">
                                                </select>
                                            </div>
                                        </div>

                                        <div class="table-responsive mt-1">
                                            <table id="gdprSettingsHistoryTbl"
                                                class="table table-stripped modalDTtabl"
                                                style="width: 100%;">
                                                <thead>
                                                    <tr>
                                                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_ModifiedField") %></th>
                                                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_OldValue") %></th>
                                                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_NewValue") %></th>
                                                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_ModifiedDate") %></th>
                                                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_ModifiedBy") %></th>
                                                    </tr>
                                                </thead>
                                                <tbody id="gdprSettingsHistoryTbody">
                                                    <tr>
                                                        <td colspan="5" class="text-center text-muted">Click Show History to load GDPR settings history.
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>

                                        <div class="cstm_pagination mt-2" id="gdprHistoryPaginationControls">
                                            <div class="d-flex justify-content-end w-100">
                                                <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                                    <span class="spntotal"><%=MyBase.GetResourceString("C_TotalRecords") %>: </span>
                                                    <span class="spntotal" id="gdprHistoryTotalRecords">0</span>
                                                    <nav aria-label="Page navigation example">
                                                        <ul class="pagination justify-content-end" style="margin: 0px!important">
                                                            <li class="page-item fa-disabled" style="cursor: not-allowed" id="gdprHistoryBtnPrevious">
                                                                <a class="page-link" aria-label="Previous" href="javascript:;" data-bs-toggle="tooltip"
                                                                    title="Previous" id="gdprHistoryLinkPrevious" onclick="gdprGoToHistoryPreviousPage(); return false;">
                                                                    <i class="fas fa-angle-double-left"></i>
                                                                </a>
                                                            </li>
                                                            <li class="page-item fa-disabled" style="cursor: not-allowed" id="gdprHistoryBtnNext">
                                                                <a class="page-link" aria-label="Next" href="javascript:;" data-bs-toggle="tooltip"
                                                                    title="Next" id="gdprHistoryLinkNext" onclick="gdprGoToHistoryNextPage(); return false;">
                                                                    <i class="fas fa-angle-double-right"></i>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </nav>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%End If%>
            <div class="clearfix"></div>
            <%Else %>
            <div id="ViewAccess" class="tab-pane" style="height: 448px">
                <div style="text-align: center">
                    <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess") %></p>
                </div>
            </div>
            <%End If %>
        </div>
        <!-- /#GDPRWrapper -->
    </div>

    <script src="../../../Whizible2.0-new/dist/js/CommonValidations.js"></script>
    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';

        // Added by Gauri - Loader state variables
        var loaderShown = false;
        var loaderStartTime = 0;

        // Added by Gauri - Loader functions
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

        // Added by Aditya J. - GDPR Settings History
        // Tracks whether the history is loaded for the current offcanvas open cycle.
        var gdprHistoryLoaded = false;
        // Added by Aditya J. - GDPR Settings History
        // Keeps full list for client-side filter (Modified Field / Modified By).
        var gdprFullHistoryList = [];

        function gdprRefreshSelectPicker(selector) {
            if ($.fn.selectpicker) {
                var $ddl = $(selector);
                // Added by Aditya J. - GDPR Settings History
                // Ensure bootstrap-select is initialized before refresh so dropdown options are rendered.
                if (!$ddl.parent().hasClass('bootstrap-select')) {
                    $ddl.selectpicker();
                }
                $ddl.selectpicker('refresh');
            }
        }

        // Added by Aditya J. - GDPR Settings History
        // Populate "Modified Field" filter dropdown from GetGDPRModifiedField API.
        function gdprPopulateModifiedFieldOptions() {

            var $ddl = $('#gdprModifiedHisField');

            var strHTML = '<option value="">Select Modified Field</option>';

            $.ajax({
                url: strUrl + 'api/GDPR_Settings/GetGDPRModifiedField',
                type: 'POST',
                data: JSON.stringify({}),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                },
                success: function (result) {

                    // ✅ Same structure as ModifiedBy
                    var Result = result?.data || [];

                    for (var i = 0; i < Result.GDPR_ModifiedField.length; i++) {

                        var item = Result.GDPR_ModifiedField[i];

                        // skip default option (optional)
                        //if (item.modifiedField === 'Select Modified Field') continue;

                        strHTML += '<option value="' + item.modifiedField + '">' + item.modifiedField + '</option>';
                    }

                    $ddl.html(strHTML);
                    $ddl.val('');
                    gdprRefreshSelectPicker('#gdprModifiedHisField');
                },
                error: function () {
                    console.log('Error loading Modified Field');
                }
            });
        }

        // Added by Aditya J. - GDPR Settings History
        // Populate "Modified By" filter dropdown from GetGDPRModifiedBy API.
        function gdprPopulateModifiedByOptions() {

            var $ddl = $('#gdprModifiedHisBy');

            var strHTML = '<option value="">Select Modified By</option>';
            $.ajax({
                url: strUrl + 'api/GDPR_Settings/GetGDPRModifiedBy',
                type: 'POST',
                data: JSON.stringify({}),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                },
                success: function (result) {

                    // ✅ Correct data extraction
                    var Result = result?.data || [];

                    for (var i = 0; i < Result.GDPR_ModifiedBy.length; i++) {

                        var item = Result.GDPR_ModifiedBy[i];

                        // skip default option coming from SP
                        //if (item.modifiedField === 'Select Modified Field') continue;

                        strHTML += '<option value="' + item.modifiedBy + '">' + item.modifiedBy + '</option>';
                    }

                    $ddl.html(strHTML);
                    $ddl.val('');
                    gdprRefreshSelectPicker('#gdprModifiedHisBy');
                },
                error: function () {
                    console.log('Error loading Modified Field');
                }
            });
        }

        // Added by Aditya J. - GDPR Settings History
        // Apply client-side filters like Project Charter history section.
        function gdprApplyHistoryFilters() {
            var selectedField = ($.trim($('#gdprModifiedHisField').val() || ''));
            var selectedBy = ($.trim($('#gdprModifiedHisBy').val() || ''));

            var filteredData = (gdprFullHistoryList || []).filter(function (item) {
                var modifiedField = $.trim(item.ModifiedField || '');
                var modifiedBy = $.trim(item.ModifiedBy || '');
                var matchField = !selectedField || modifiedField === selectedField;
                var matchBy = !selectedBy || modifiedBy === selectedBy;
                return matchField && matchBy;
            });

            gdprRenderHistoryTable(filteredData);
        }

        // Added by Aditya J. - GDPR Settings History
        // Single render function used by initial load and filters.
        function gdprRenderHistoryTable(mappedData) {

            var $tbody = $("#gdprSettingsHistoryTbody");

            if (!Array.isArray(mappedData) || mappedData.length === 0) {
                if ($.fn.DataTable.isDataTable("#gdprSettingsHistoryTbl")) {
                    $("#gdprSettingsHistoryTbl").DataTable().destroy();
                }
                $tbody.empty().append(
                    '<tr><td colspan="5" class="text-center text-muted">No GDPR settings history found.</td></tr>'
                );
                $("#gdprHistoryTotalRecords").text(0);
                $("#gdprHistoryBtnPrevious").addClass("fa-disabled");
                $("#gdprHistoryBtnNext").addClass("fa-disabled");
                return;
            }

            if ($.fn.DataTable.isDataTable("#gdprSettingsHistoryTbl")) {
                $("#gdprSettingsHistoryTbl").DataTable().destroy();
            }
            $tbody.empty();

            $("#gdprSettingsHistoryTbl").DataTable({
                data: mappedData,
                columns: [
                    { data: 'ModifiedField' },
                    { data: 'OldValue' },
                    { data: 'NewValue' },
                    { data: 'ModifiedDate' },
                    { data: 'ModifiedBy' }
                ],
                scrollY: true,
                scrollX: true,
                paging: true,
                pageLength: 5,
                lengthChange: false,
                searching: false,
                ordering: false,
                responsive: true,
                destroy: true,
                retrieve: true,
                info: false,
                pagingType: "simple",
                language: {
                    paginate: {
                        previous: "Previous",
                        next: "Next"
                    }
                }
            });

            $("#gdprSettingsHistoryTbl_wrapper .dataTables_paginate").css("display", "none");
            $("#gdprSettingsHistoryTbl").off('draw.dt').on('draw.dt', function () {
                gdprUpdateHistoryPagination();
            });
            gdprUpdateHistoryPagination();
        }

        // Added by Aditya J. - GDPR Settings History
        // Loads GDPR Settings History dynamically by calling:
        // api/GDPR_Settings/GetGDPRSettingsHistory
        function gdprLoadSettingsHistory() {
            
            showLoader();

            // Temporary loader row until API returns.
            var $tbody = $("#gdprSettingsHistoryTbody");
            $tbody.empty().append(
                '<tr><td colspan="5" class="text-center text-muted">Loading GDPR settings history...</td></tr>'
            );

            $.ajax({
                url: strUrl + 'api/GDPR_Settings/GetGDPRSettingsHistory',
                type: 'POST',
                data: JSON.stringify({}),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                },
                success: function (response) {
                    hideLoader();

                    // The API response can be array-direct or nested under response.data.*.
                    var rows = response;
                    if (response && response.data) {
                        rows =
                            response.data.RM_GDPR_Settings_History ||  // ✅ correct key
                            response.data.GDPRSettingsHistory ||
                            response.data.history ||
                            response.data;
                    }

                    if (!Array.isArray(rows) || rows.length === 0) {
                        gdprFullHistoryList = [];
                        gdprRenderHistoryTable([]);
                        return;
                    }

                    function getFirst(obj, keys) {
                        for (var i = 0; i < keys.length; i++) {
                            var k = keys[i];
                            if (obj && obj[k] !== undefined && obj[k] !== null && obj[k] !== '') {
                                return obj[k];
                            }
                        }
                        return '';
                    }

                    // Added by Aditya J. - GDPR Settings History
                    // Map API rows into DataTable row objects.
                    var mappedData = $.map(rows, function (item) {
                        return {
                            ModifiedField: getFirst(item, ['FieldName', 'fieldName']),
                            OldValue: getFirst(item, ['OldValue', 'oldValue']),
                            NewValue: getFirst(item, ['NewValue', 'newValue']),
                            ModifiedDate: getFirst(item, ['ModifiedDate', 'modifiedDate']),
                            ModifiedBy: getFirst(item, ['ModifiedBy', 'modifiedBy'])
                        };
                    });

                    gdprFullHistoryList = mappedData;
                    gdprApplyHistoryFilters();
                },
                error: function () {
                    hideLoader();
                    $tbody.empty().append(
                        '<tr><td colspan="5" class="text-center text-danger">Failed to load GDPR settings history.</td></tr>'
                    );
                }
            });
        }

        // Added by Aditya J. - GDPR Settings History
        // History pagination helpers (mirror PM_ProjectSites show history controls).
        let gdprHistoryCurrentPage = 1;
        let gdprHistoryItemsPerPage = 10;
        let gdprHistoryTotalPages = 1;

        function gdprUpdateHistoryPagination() {
            var table = $("#gdprSettingsHistoryTbl").DataTable();
            var info = table.page.info();
            var totalRecords = info.recordsTotal;

            $("#gdprHistoryTotalRecords").text(totalRecords);

            gdprHistoryCurrentPage = info.page + 1;
            gdprHistoryTotalPages = info.pages;

            if (gdprHistoryCurrentPage <= 1) {
                $("#gdprHistoryBtnPrevious").addClass("fa-disabled");
            } else {
                $("#gdprHistoryBtnPrevious").removeClass("fa-disabled");
            }

            if (gdprHistoryCurrentPage >= gdprHistoryTotalPages) {
                $("#gdprHistoryBtnNext").addClass("fa-disabled");
            } else {
                $("#gdprHistoryBtnNext").removeClass("fa-disabled");
            }
        }

        function gdprGoToHistoryPreviousPage() {
            // Hide any visible tooltips
            $('[data-bs-toggle="tooltip"]').tooltip('hide');
            if (!$.fn.DataTable.isDataTable("#gdprSettingsHistoryTbl")) return;

            var table = $("#gdprSettingsHistoryTbl").DataTable();
            var info = table.page.info();
            if (info.page > 0) {
                table.page('previous').draw('page');
                gdprUpdateHistoryPagination();
            }
        }

        function gdprGoToHistoryNextPage() {
            // Hide any visible tooltips
            $('[data-bs-toggle="tooltip"]').tooltip('hide');
            if (!$.fn.DataTable.isDataTable("#gdprSettingsHistoryTbl")) return;

            var table = $("#gdprSettingsHistoryTbl").DataTable();
            var info = table.page.info();
            if (info.page < info.pages - 1) {
                table.page('next').draw('page');
                gdprUpdateHistoryPagination();
            }
        }

        // Field-level GDPR config (Fields tab)
        var gdprFieldMap = [
            { key: 'BirthDate', chkId: 'gdprChkBirthDate' },
            { key: 'Email', chkId: 'gdprChkEmail' },
            { key: 'Gender', chkId: 'gdprChkGender' },
            { key: 'EmployeeType', chkId: 'gdprChkEmployeeType' },
            { key: 'Messanger', chkId: 'gdprChkMessanger' },
            { key: 'ExtensionNo', chkId: 'gdprChkExtensionNo' },
            { key: 'Address', chkId: 'gdprChkAddress' }
        ];

        // Subtab-level GDPR config (Subtab tab)
        var gdprSubtabMap = [
            { key: 'AdvancedInfo', dbKey: 'AdditionlInfo', chkId: 'gdprSubtabAdvancedInfo' },
            { key: 'Certifications', chkId: 'gdprSubtabCertifications' },
            { key: 'VisaDetails', chkId: 'gdprSubtabVisaDetails' },
            { key: 'Qualifications', chkId: 'gdprSubtabQualifications' },
            { key: 'PrevWorkExp', chkId: 'gdprSubtabPrevWorkExp' },
            { key: 'PrevAssignment', chkId: 'gdprSubtabPrevAssignment' }
        ];

        function gdprLoadConfig(flag) {

            // flag: 0 = Fields, 1 = Subtab
            if (flag === undefined || flag === null) {
                flag = 0;
            }

            var activeMap = (flag === 1 ? gdprSubtabMap : gdprFieldMap);

            showLoader();
            $.ajax({
                url: strUrl + 'api/GDPR_Settings/GetGDPRFieldConfig?flag=' + flag,
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                },
                success: function (response) {

                    var config = {};

                    var list = response &&
                        response.data &&
                        response.data.RM_GDPR_FieldConfig;

                    if (Array.isArray(list) && list.length > 0) {

                        $.each(list, function (i, item) {
                            config[item.fieldName] = item.isVisible;
                        });

                    } else {

                        // Fallback: show all as enabled (ON) — use 0 so binding shows checked
                        $.each(activeMap, function (i, f) {
                            config[f.key] = 0;
                        });
                    }

                    // Apply checkbox state for active map
                    // API returns inverse of DB; DB 1 = enabled (ON), DB 0 = disabled (OFF)
                    //$.each(activeMap, function (i, f) {
                    //    var apiVal = config[f.key];
                    //    var isEnabled = (apiVal === 0 || apiVal === false);
                    //    $('#' + f.chkId).prop('checked', isEnabled);
                    //});
                    $.each(activeMap, function (i, f) {
                        var keyToUse = f.dbKey || f.key; // fallback to key if dbKey not present
                        var apiVal = config[keyToUse];
                        var isEnabled = (apiVal === 0 || apiVal === false);
                        $('#' + f.chkId).prop('checked', isEnabled);
                    });
                    // Greyed-out styling for whichever grid is active
                    gdprUpdateRowStates();
                    hideLoader();
                },
                error: function () {
                    $.each(activeMap, function (i, f) {
                        $('#' + f.chkId).prop('checked', true);
                    });
                    gdprUpdateRowStates();
                    hideLoader();
                }
            });
        }

        function gdprUpdateRowStates() {
            // Toggle CSS shows checked = knob left (visual OFF), unchecked = knob right (visual ON)
            // So apply faint only when checked (visual OFF = disabled)
            $('#gdprSettingsTbl tbody tr.gdpr-row, #gdprSubtabTbl tbody tr.gdpr-row').each(function () {
                var $row = $(this);
                var $chk = $row.find('input.gdpr-toggle');
                $row.toggleClass('gdpr-row-disabled', $chk.is(':checked'));
            });
        }

        function gdprSaveConfig() {
            var payload = { ModifiedBy: '<%= Session("strUserName") %>' };
                // Fields tab: backend expects inverse, so send negation so ON→1, OFF→0 in DB
                $.each(gdprFieldMap, function (i, f) {
                    payload[f.key] = !$('#' + f.chkId).is(':checked');
                });
                // Subtab tab: toggles share same visual behavior (checked = OFF), so also send negation
                // Visual ON (unchecked)  -> !false = true  -> DB 1
                // Visual OFF (checked)   -> !true  = false -> DB 0
                $.each(gdprSubtabMap, function (i, f) {
                    payload[f.key] = !$('#' + f.chkId).is(':checked');
                });
                showLoader();
                $.ajax({
                    url: strUrl + 'api/GDPR_Settings/SaveGDPRFieldConfig',
                    type: 'POST',
                    data: JSON.stringify(payload),
                    dataType: 'json',
                    contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                        if (payload) {
                            xhr.setRequestHeader("Params", typeof encryptString === 'function' ? encryptString(JSON.stringify(payload)) : JSON.stringify(payload));
                        }
                    },
                    success: function () {
                        gdprUpdateRowStates();
                        hideLoader();
                        // Added by Aditya J. - GDPR Settings History
                        // Mark history as stale so next offcanvas open refreshes from the API.
                        gdprHistoryLoaded = false;
                        if (typeof alertify !== 'undefined') {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success('<%=MyBase.GetResourceString("A_SettingsSaved") %>');
                            //alertify.success('GDPR configuration settings saved succesfully.');
                        } else {
                            alert('GDPR field visibility settings saved.');
                        }
                    },
                    error: function () {
                        hideLoader();
                        if (typeof alertify !== 'undefined') {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('<%=MyBase.GetResourceString("A_SettingsFailed") %>');
                        } else {
                            alert('Failed to save GDPR settings. Please try again.');
                        }
                    }
                });
        }

        function gdprCancelOrReset() {
            gdprLoadConfig(0);
        }

        $(document).ready(function () {
            // Initial load for Fields tab
            gdprLoadConfig(0);
            $('#gdprSettingsTbl').on('change', 'input.gdpr-toggle', gdprUpdateRowStates);
            $('#gdprSubtabTbl').on('change', 'input.gdpr-toggle', gdprUpdateRowStates);
            // Added by Aditya J. - GDPR Settings History filters
            $('#gdprModifiedHisField, #gdprModifiedHisBy').on('change', gdprApplyHistoryFilters);

            // Added by Aditya J. - GDPR Settings History
            // Load the history content when the offcanvas is opened first time.
            $('#gdprSettingsHistoryOffcanvas').on('shown.bs.offcanvas', function () {
                gdprPopulateModifiedFieldOptions();
                gdprPopulateModifiedByOptions();
                //if (gdprHistoryLoaded) return;
                //gdprHistoryLoaded = true;
                gdprLoadSettingsHistory();
            });

            // Reload configuration when switching tabs
            $('#tab-fields').on('shown.bs.tab', function () {
                gdprLoadConfig(0);
            });
            $('#tab-subtab').on('shown.bs.tab', function () {
                gdprLoadConfig(1);
            });

            // Added by Gauri - Initial page load complete: hide preloader and show main content
            $("#GDPRSec").hide();
            $("#GDPRWrapper").show();
        });
    </script>
</body>
</html>
