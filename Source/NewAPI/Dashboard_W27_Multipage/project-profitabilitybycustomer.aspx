<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="project-profitabilitybycustomer.aspx.vb" Inherits="PbNIT.project_profitabilitybycustomer" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Project Profitability By Customer</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css" />
    <style type="text/css">
        body {
            background-color: #ffffff;
            background: #ffffff;
        }

        .form-inline{ display: flex; }
        .dataTables_scrollBody thead tr[role="row"] { visibility: collapse !important; }
        a.clearalllink { font-weight: bold; margin: 7px 0px 0 8px; display: none; }
        .filter.pull-right { margin: 2px 0 0 8px; }
        table tr th { vertical-align: middle !important; }
        table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before { margin-right: 0; }
        .notebox { padding: 10px; margin-bottom: 10px; border-radius: 4px; }
        .Resourcedetailpanel { margin: 40px 15px 0; display: none; border: 1px solid #ddd; border-radius: 4px; }
        .pgdetailinner { padding: 10px; }
        .Resourcedetailpanel .tab-pane { padding: 20px 0; }
        tr.rowhiglight { background: #c3dbff; }
        .DisableContent { pointer-events: none; opacity: 0.5; }
        .DisableContent:hover { cursor: no-drop; }
        .dataTables_scrollBody.DisableContent { height: auto !important; }
        h5.pgtitle { margin: 6px 0 0; font-weight: 700; color: #4263c1; font-size: 16px; }
        .dblock { display: block; }
        ul.statustext.hidden-xs { padding: 0; }
        .tblheadingrow td { text-align: left !important; font-weight: 500; }
        tr.totalrow { background: #ccc; font-weight: 500; }
        .ppcTbllist tr td:nth-child(2) { text-align: left; }
        /* Added By Vyankat B. on 26th Aug 2026
           Freeze table header same as Project_Profitability.aspx */
        .custVal1.Tblbox.table-responsive {
            overflow: visible;
        }
        .ppcTbllist {
            table-layout: fixed;
            width: 100%;
            border-collapse: separate !important;
            border-spacing: 0;
        }
        .ppcTbllist thead th {
            position: -webkit-sticky;
            position: sticky;
            top: 0;
            z-index: 5;
            background: #F8FAFC;
            box-shadow: 0 1px 0 #dee2e6;
        }
        /* End of Added By Vyankat B. on 26th Aug 2026 */
        .lightgraybg { background: #f5f5f5; }
        .informationtbl { margin-bottom: 15px; }
        .informationtbl tr th { text-align: right; color: #6a9bff;font-weight: 400;}
        body .informationtbl tr td { text-align: left; }
        .informationtbl th, .informationtbl td { padding: 2px 4px; }
        table.informationtbl { width: 100%; }
        td.Agpm { color: #eb1c24; }
        .togglerup .collapseup { display: block; }
        .togglerup .collapsedown { display: none; }
        .togglerdown .collapsedown { display: block; }
        .togglerdown .collapseup { display: none; }
        .infoToggler { margin: 5px 0 0; }
        .hideprofitabilityinfo { position: absolute; right: 10px; top: 50%; transform: translateY(-50%); margin: 0; }
        .profitabilityinfopanel { margin-bottom: 16px; }
        .profitabilityinfopanel .panel.panel-default { padding: 0; position: relative; }
        .profitabilityinfopanel .panel.lightgraybg { background: transparent; }
        .profitabilityinfopanel .panel-collapse,
        .profitabilityinfopanel .panel-body {
            background: #ffffff !important;
        }
        .profitabilityinfopanel .panel-default > .panel-heading {
            padding: 0;
            background: #e7edf0;
            cursor: pointer;
        }
        .profitabilityinfopanel .panel-default > .panel-heading .panel-title { margin: 0; font-size: 14px; }
        .profitabilityinfopanel .panel-default > .panel-heading .panel-title > a {
            display: block;
            width: 100%;
            padding: 10px 40px 10px 12px;
            color: #464a4c;
            text-decoration: none;
            position: relative;
        }
        .profitabilityinfopanel .panel-default > .panel-heading .panel-title > a:hover,
        .profitabilityinfopanel .panel-default > .panel-heading .panel-title > a:focus {
            color: #464a4c;
            text-decoration: none;
        }
        #TabGrossProfit > .table-responsive { margin-bottom: 12px; }
        .informationtbl td, .informationtbl th { vertical-align: top !important; font-size: 11.5px; line-height: normal; }

        /* MyAlerts-style near full-page offcanvas */
        #PPCGrossProfittmodal {
            --bs-offcanvas-width: 85% !important;
            width: 85% !important;
            max-width: 1200px !important;
        }
        #PPCGrossProfittmodal .offcanvas-body {
            padding: 0 1rem 1rem;
            background-color: #fff;
        }
        a.ppc-project-link {
            color: #0d6efd;
            text-decoration: underline !important;
            cursor: pointer;
        }
        a.ppc-project-link:hover {
            color: #0a58ca;
            text-decoration: underline !important;
        }
        a.ppc-project-link.oc-link-active {
            color: #084298;
            text-decoration: underline !important;
            font-weight: 700;
        }
        @media (max-width: 768px) {
            #PPCGrossProfittmodal {
                --bs-offcanvas-width: 95% !important;
                width: 95% !important;
                max-width: 100% !important;
            }
        }
        .GPMtbl { table-layout: fixed; width: 100%; }
        .GPMtbl tr td[align="right"] { text-align: right; }
        .GPMtbl tr td[align="left"] { text-align: left; }
        .GPMtbl tr td:nth-child(2), .GPMtbl tr th:nth-child(2) { width: 150px; }
        .GPMtbl tr td:nth-child(3), .GPMtbl tr th:nth-child(3) { width: 180px; }
        .table .grouprow th { background: #e7edf0; }
        .grossprofitinfo { padding: 0; border-radius: 4px; font-weight: 500; overflow: hidden; }
        .grossprofitinfo p { margin: 0; font-weight: bold; padding: 15px; }
        .grossprofitinfo .gpm-footer-tbl { margin: 0; width: 100%; border: 0; table-layout: fixed; }
        .grossprofitinfo .gpm-footer-tbl td { border: 0; font-weight: bold; padding: 15px; vertical-align: middle; }
        .grossprofitinfo .gpm-footer-tbl td:nth-child(2) { width: 150px; text-align: right; }
        .grossprofitinfo .gpm-footer-tbl td:nth-child(3) { width: 180px; text-align: right; }
        body .informationtbl tr td.colan { padding: 3px 2px; }
        tr.ttlrow { font-weight: bold; }
        .borderbox { border: 1px solid #ddd; margin: 15px; background: #f7f7f7; }
        .statustext { padding-bottom: 0; }
        .gpmpositivelbl .fa-flag{ color:#9dd824;}
        .gpmnegativelbl .fa-flag{ color:#eb1c24;}
        .gpmalllbl .fa-flag{ color:#fbb03b;}
        .GPMfiltr.mr-1{display:inline-block;float:right;background:transparent;padding:5px 10px;border:1px solid transparent;border-radius:5px}
        .GPMfiltr:hover{background:#fff;padding:5px 10px;border:1px solid #ddd;border-radius:5px}
        .GPMfiltr label{margin-bottom:0}
        .custom_radio input[type="radio"]{display:none}
        .custom_radio input[type="radio"] + label span{display:inline-block;width:15px;height:15px;background:transparent;vertical-align:middle;border:1px solid #464a4c;border-radius:50%;padding:2px;margin:0 3px}
        .custom_radio input[type="radio"]:checked + label span{width:15px;height:15px;background:#464a4c;background-clip:content-box}
        .management-dashboard-page {
            background: #ffffff; min-height: auto; }
        .management-dashboard-header { align-items: center; background: #fff; border-bottom: 1px solid #eef2f7; box-shadow: rgba(0, 0, 0, 0.06) 0 5px 5px -3px, rgba(0, 0, 0, 0.043) 0 8px 10px 1px, rgba(0, 0, 0, 0.035) 0 3px 14px 2px; display: flex; justify-content: space-between; padding: 1rem 1.25rem; }
        .management-dashboard-title { align-items: center; color: #1e40af; display: flex; font-size: 18px; font-weight: 600; gap: 0.75rem; margin: 0 0 0.25rem; }
        .management-dashboard-title i { color: #1e40af; font-size: 1.5rem; }
        .management-dashboard-subtitle { color: #6b7280; font-size: 0.72rem; margin: 0; }
        .management-dashboard-tabs-wrapper { background: #fff; border-bottom: 1px solid #e0e0e0; margin: 0 2px 15px; padding: 0 15px; }
        .management-dashboard-tabs { border-bottom: 0; gap: 5px; margin-bottom: 0; overflow: hidden; white-space: normal; }
        .management-dashboard-tabs .nav-link { align-items: center; background: transparent; border: 0; border-bottom: 2px solid transparent; color: #666; display: flex; font-weight: 400; gap: 0.4rem; padding: 8px 10px; }
        .management-dashboard-tabs .nav-link:hover { background: #f8fbff; color: #1359a6; }
        .management-dashboard-tabs .nav-link.active { background: #f0f7ff; border-bottom-color: #1359a6; color: #1359a6; }
        .management-dashboard-current-page { align-items: center; background: #fff; border: 1px solid #e5e7eb; border-radius: 10px; box-shadow: 0 1px 3px rgba(15, 23, 42, 0.08); display: flex; justify-content: space-between; margin: 12px 15px 14px; padding: 14px 16px; }
        .management-dashboard-current-title { align-items: center; color: #1e40af; display: flex; font-size: 16px; font-weight: 600; gap: 0.65rem; margin: 0 0 0.25rem; }
        .management-dashboard-current-title i { color: #1e40af; font-size: 1.2rem; }
        .management-dashboard-current-note { color: #6b7280; font-size: 0.72rem; margin: 0; }
        @media (max-width: 767px) {
            .management-dashboard-current-page { align-items: flex-start; flex-direction: column; gap: 0.75rem; }
        }
    
       /* Added By Madhuri.K on 24-08-2026 */
        /* Plan vs Actual searchable multi-select */
        .ppc-msel-native { display: none !important; }
        .ppc-filter-bar {
            overflow: visible;
        }
        .ppc-filter-bar label {
            display: block;
            font-size: 11px;
            letter-spacing: .4px;
            color: #4b5563;
            font-weight: 600;
            margin: 0 0 4px;
        }
        .ppc-filter-bar .msel {
            position: relative;
            width: 100%;
        }
        .ppc-filter-bar .msel-btn {
            width: 100%;
            height: 34px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
            padding: 6px 8px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            background: #fff;
            color: #1a2536;
            font-size: 11.5px;
            text-align: left;
            cursor: pointer;
            white-space: nowrap;
            overflow: hidden;
        }
        .ppc-filter-bar .msel-btn:hover,
        .ppc-filter-bar .msel-btn:focus {
            border-color: #1359a6;
            outline: none;
        }
        .ppc-filter-bar .msel-btn .msel-label {
            min-width: 0;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .ppc-filter-bar .msel-btn .count {
            flex: 0 0 auto;
            padding: 1px 7px;
            border-radius: 10px;
            background: #1359a6;
            color: #fff;
            font-size: 10px;
            font-weight: 600;
        }
        .ppc-filter-bar .msel-btn .chev {
            flex: 0 0 auto;
            color: #6b7280;
            font-size: 10px;
            line-height: 1;
        }
        .ppc-filter-bar .msel-btn .chev i { font-size: 10px; }
        .ppc-filter-bar .msel-panel {
            position: absolute;
            top: calc(100% + 4px);
            left: 0;
            z-index: 2055;
            display: none;
            width: 100%;
            min-width: 220px;
            max-height: 260px;
            padding: 8px;
            overflow-y: auto;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            background: #fff;
            box-shadow: 0 8px 24px rgba(20,30,50,.14);
        }
        .ppc-filter-bar .msel-panel.open { display: block; }
        .ppc-filter-bar .msel-search {
            position: sticky;
            top: -8px;
            z-index: 2;
            width: 100%;
            box-sizing: border-box;
            margin-bottom: 6px;
            padding: 6px 8px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            background: #fff;
            font-size: 11.5px;
        }
        .ppc-filter-bar .msel-search:focus {
            border-color: #1359a6;
            outline: none;
        }
        .ppc-filter-bar .msel-row {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0;
            padding: 6px 8px;
            border-radius: 4px;
            color: #374151;
            font-size: 11.5px;
            font-weight: 400;
            cursor: pointer;
        }
        .ppc-filter-bar .msel-row:hover { background: #f1f5f9; }
        .ppc-filter-bar .msel-row input { margin: 0; }
        .ppc-filter-bar .msel-empty {
            padding: 10px 8px;
            color: #6b7280;
            font-size: 11.5px;
            text-align: center;
        }
        .ppc-filter-bar .msel-actions {
            position: sticky;
            bottom: -8px;
            display: flex;
            justify-content: space-between;
            margin-top: 6px;
            padding: 4px 6px 2px;
            border-top: 1px solid #e5e7eb;
            background: #fff;
        }
        .ppc-filter-bar .msel-actions button {
            padding: 4px;
            border: 0;
            background: none;
            color: #1359a6;
            font-size: 11.5px;
            font-weight: 600;
            cursor: pointer;
        }

        /* Pagination UI same as Project_health_sheet.aspx */
        .ppc-footer-row {
            margin: 10px 0 0;
            align-items: center;
        }

        .ppc-footer-row .spntotal {
            font-size: 12px;
            font-weight: 600;
            color: #374151;
            white-space: nowrap;
        }

        .ppc-footer-row .pagination {
            margin: 0;
        }

        .ppc-footer-row .page-link {
            cursor: pointer;
            color: #1359a6;
            border: 1px solid #dee2e6;
            padding: 0.25rem 0.55rem;
            font-size: 12px;
        }

        .ppc-footer-row .page-item.disabled .page-link {
            color: #9ca3af;
            pointer-events: none;
            background: #f9fafb;
        }

    </style>
</head>
<body class="hold-transition skin-blue-light sidebar-mini fixed">
    <form id="form1" runat="server">
    <%If m_blnViewAccess = True Then%>
       
    <div class="bgwhite management-dashboard-page">
            <div class="management-dashboard-current-page">
                <div>
                    <h3 class="management-dashboard-current-title">
                        <i class="fas fa-users" data-bs-toggle="tooltip" title="Project Profitability By Customer"></i>
                        Project Profitability By Customer
                    </h3>
                    <p class="management-dashboard-current-note">Compare customer-level profitability and gross profit movement.</p>
                </div>
            </div>



       
            
            <div class="innerpgiframe">
                <!--filter panel-->
                <div id="filterpanel" class="filterpanel collapse">
                    <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                        <div class="cust_tabpanel">
                            <ul class="nav nav-tabs">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">My Filters  <span class="caret"></span></a>
                                    <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                    </ul>
                                </li>
                                <li class="">
                                    <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                                </li>


                            </ul>
                        </div>

                        <div class="Fwrapper">
                            <div class="tab-content">
                                <div id="basicfilters" class="tab-pane">
                                    <div class="filterpanelbody">
                                        <div class="text-center hidden-xs centerbtn">
                                            <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="offcanvas" data-bs-target="#Issuesavefilter">Save and Apply</button>
                                            <button class="btn btnyellow">Apply</button>
                                        </div>
                                        <br />

                                        <div class="row">
                                            <div class="col-sm-4 form-group">
                                                <label>Parameter Group</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>=</option>
                                                            <option><></option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option value="">&nbsp;</option>
                                                        </select>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-sm-4 form-group">
                                                <label>Parameter Value</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>Contains</option>
                                                            <option>End With</option>
                                                            <option>Exact Word</option>
                                                            <option>Not Contains</option>
                                                            <option>Start With</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <input class="form-control input-sm" type="text" id="Fparavalue" />
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-sm-4 form-group">
                                                <label>Order Number</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>=</option>
                                                            <option><=</option>
                                                            <option><></option>
                                                            <option>></option>
                                                            <option>>=</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <input id="FOrdrNo" type="text" class="form-control" />
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="col-sm-4 form-group">
                                                <label>Description</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>Contains</option>
                                                            <option>End With</option>
                                                            <option>Exact Word</option>
                                                            <option>Not Contains</option>
                                                            <option>Start With</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <textarea class="form-control">&nbsp;</textarea>
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
                <!--end filter panel-->
                <!--<div class="container-fluid pt-1 pb-1 text-end">
            <button class="btn borderbtn addbtn mr-5" id="" onclick="addWp()"><i class="fa fa-plus" aria-hidden="true"></i> Add</button>
            <a href="resource-plan-index.html" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Back to Resource Configuration">Back</a>
            <button class="btn borderbtn deletebtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete">Delete</button>
        </div>-->
                <div class="clearfix"></div>
               <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
                <div class=" container-fluid pt-1 pb-1 borderbox ppc-filter-bar">
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <label for="PPCSelectBG">Business Group</label>
                            <select id="PPCSelectBG" multiple title="Select Business Group" class="ppc-msel-native"></select>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <label for="PPCSelectOU">Organization Unit</label>
                            <select id="PPCSelectOU" multiple title="Select Organization Unit" class="ppc-msel-native"></select>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <label for="PPCselectPro">Project</label>
                            <select id="PPCselectPro" multiple title="Select Project" class="ppc-msel-native"></select>
                        </div>
                    </div>
                    <div class="row mt-2 align-items-end">
                        <div class="col-sm-4 col-md-4">
                            <label for="PPCustmrselect">Customer</label>
                            <select id="PPCustmrselect" multiple title="Select Customer" class="ppc-msel-native"></select>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <label for="PPCSelectPeriod">Period</label>
                            <select id="PPCSelectPeriod" title="Select Period" class="ppc-msel-native"></select>
                        </div>
                        <div class="col-sm-4 col-md-4 text-end">
                            <!--<ul class="statustext hidden-xs">
        <li><strong>GPM :</strong> </li>
        <li data-bs-toggle="tooltip" data-bs-placement="top" title="" class=" greenstatuslbl active" data-bs-original-title="Negative GPM"><a href="javascript:;"><span class="statustextno"><i class="far fa-flag"></i></span>Positive GPM</a></li>
        <li data-bs-toggle="tooltip" data-bs-placement="top" title="" class="criticle" data-bs-original-title="Negative GPM"><a href="javascript:;"><span class="statustextno"><i class="far fa-flag"></i></span>Negative GPM</a></li>
        <li data-bs-toggle="tooltip" data-bs-placement="top" title="" class="pending" data-bs-original-title="All GPM"><a href="javascript:;"><span class="statustextno"><i class="far fa-flag"></i></span>All GPM</a></li>
    </ul>-->
                            <div class="GPMfiltr mr-1">
                                <div class="d-inline-block">
                                    <div class="custom_radio d-inline-block gpmpositivelbl">
                                        <input id="GPMpositive" name="Rgroup1" value="GPM1" type="radio">
                                        <label for="GPMpositive"><span></span> <i class="far fa-flag" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Positive GPM"></i></label>
                                    </div>
                                </div>
                                <div class="d-inline-block  ml-1">
                                    <div class="custom_radio d-inline-block gpmnegativelbl">
                                        <input id="GPMNegative" name="Rgroup1" value="GPM2" type="radio">
                                        <label for="GPMNegative"><span></span> <i class="far fa-flag" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Negative GPM"></i></label>
                                    </div>
                                </div>
                                <div class="d-inline-block  ml-1">
                                    <div class="custom_radio d-inline-block gpmalllbl">
                                        <input id="GPMAll" name="Rgroup1" value="GPM3" type="radio" checked="checked">
                                        <label for="GPMAll"><span></span> <i class="far fa-flag" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="All GPM"></i></label>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>

                <div class="content pt-0">
                    <div>
                        <strong></strong> <span id="spancurr" class="text-end pull-right"><small>( All Figures In : Rs )</small></span>
                    </div>
                    <!-- Added By Vyankat B. on 26th Aug 2026 -->
                    <div class="custVal1 Tblbox table-responsive">
                    <table id="PPCTbl" class="table table-bordered ppcTbllist mb-0" style="width:100%;">
                        <thead>
                            <tr>
                                <th class="">Customer</th>
                                <th>Project Name</th>
                                <th>As On Date</th>
                                <th>Accrued Revenue</th>
                                <th>Accrued Cost</th>
                                <th>Accrued GPM</th>
                                <th>Accrued GPM %</th>
                                <th>Invoice Revenue</th>
                            </tr>
                        </thead>
                        <tbody id="PPCTblBody">
                            <tr>
                                <td colspan="8" class="text-center text-muted">Loading...</td>
                            </tr>
                        </tbody>
                    </table>
                    </div>
                    <!-- End of Added By Vyankat B. on 26th Aug 2026 -->
                    <div class="row footer-row ppc-footer-row" id="ppcProfitPager">
                        <div class="col-sm-6"></div>
                        <div class="col-sm-6 d-flex justify-content-end align-items-center">
                            <span class="spntotal me-3 ppc-total-records">Total Records: 0</span>
                            <nav aria-label="Pagination">
                                <ul class="pagination mb-0">
                                    <li class="page-item disabled"><a class="page-link ppc-page-prev" href="javascript:;" title="Previous"><i class="fas fa-angle-double-left"></i></a></li>
                                    <li class="page-item disabled"><a class="page-link ppc-page-next" href="javascript:;" title="Next"><i class="fas fa-angle-double-right"></i></a></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>

            </div>
            <div class="clearfix"></div>
      

        <!-- Save filter Modal start here-->
        <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="Issuesavefilter" aria-labelledby="IssuesavefilterLabel">
    <div class="graybg container-fluid py-1 mb-2">
        <div class="row align-items-center">
            <div class="col-sm-10"><h5 class="pgtitle mb-0" id="IssuesavefilterLabel">Save Filter As</h5></div>
            <div class="col-sm-2 text-end">
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Close" title="Close" aria-label="Close"></button>
                    </div>
        </div>
    </div>
    <div class="offcanvas-body">
                        <div id="Issuesavrefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end">Filter Name :</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name=""><br />
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>
                                                    <button data-bs-dismiss="offcanvas" class="btn canclesaveasbtn borderbtn pull-right">Cancel</button>
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
        <!-- Save filter Modal End here-->
        <!-- Project people cost Modal start here-->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="PPCGrossProfittmodal" aria-labelledby="PPCGrossProfittmodalLabel" style="width: 85%; max-width: 1200px;">
            <div class="offcanvas-body">
                <div class="graybg container-fluid py-1 mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-10"><h5 class="pgtitle mb-0" id="PPCGrossProfittmodalLabel">Gross Profit Margin</h5></div>
                        <div class="col-sm-2 text-end">
                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Close" title="Close" aria-label="Close" onclick="$('body').removeClass('offcanvas-open');"></button>
                        </div>
                    </div>
                </div>
                        <div id="TabGrossProfit" class="tab-pane">
                            <!--Information table start here-->
                            <div class="panel-group profitabilityinfopanel" id="accordion" role="tablist" aria-multiselectable="true">
                                <div class="panel panel-default panel-horizontal lightgraybg">
                                    <div class="panel-heading" role="tab" id="headingThree">
                                        <h4 class="panel-title">
                                            <a role="button" data-bs-toggle="collapse" data-bs-parent="#accordion" href="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
                                                <span class="hideprofitabilityinfo infoToggler togglerup pull-right ml-1">
                                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-bs-original-title="Expand">
                                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-bs-original-title="Collapse">
                                                </span>
                                                Project Details
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseThree" class="panel-collapse collapse show" role="tabpanel" aria-labelledby="headingThree">
                                        <div class="panel-body">
                                            <table class="informationtbl mb-0" id="tblprjdtl">
                                                <tbody>
                                                    <tr>
                                                        <th>Project Name</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3"><span class="lmtname" id="gpmProjectName">-</span></td>
                                                        <th>Project Value</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3" id="gpmProjectValue">-</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Commercial Type</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3" id="gpmCommercialType">-</td>
                                                        <td colspan="3">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Start Date</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3" id="gpmStartDate">-</td>
                                                        <th>End Date</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3" id="gpmEndDate">-</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Cost Method</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3" id="gpmCostMethod">-</td>
                                                        <td colspan="3">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Actual Start Date</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3" id="gpmActualStartDate"></td>
                                                        <th>Actual End Date</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3" id="gpmActualEndDate"></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--Information table End here-->

                            <div class="table-responsive">
                                <table id="gpmDetailTbl" class="table table-bordered GPMtbl">
                                    <tbody>
                                        <tr>
                                            <td colspan="3" class="text-center text-muted">Select a project to view GPM details.</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="grossprofitinfo graybg" id="gpmProfitInfo">
                                <p>Gross Profit Margin = Total Revenue - Total Cost</p>
                            </div>


                        </div>


            </div>
        </div>
    <!-- Project people cost Modal End here-->




    <div class="clearfix"></div>
    </div>


    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 3.7.1 -->
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <!-- Bootstrap 5.3.2 -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <!-- bootstrap-select (after Bootstrap) -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <!-- Bootstrap 5.3.2 -->
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

    <!--chart js-->
    <script src="../../../Whizible2.0-new/plugins/chartjs/chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/chartjs-plugin-datalabels.js"></script>

    <script>

        $("[data-bs-toggle='tooltip']").each(function () {
            if (window.bootstrap && bootstrap.Tooltip) {
                bootstrap.Tooltip.getOrCreateInstance(this);
            } else if ($.fn.tooltip) {
                $(this).tooltip();
            }
        });
        $(".GPMfiltr .fa-flag").each(function () {
            if (window.bootstrap && bootstrap.Tooltip) {
                bootstrap.Tooltip.getOrCreateInstance(this);
            } else if ($.fn.tooltip) {
                $(this).tooltip();
            }
        });

        function editPHSDetail() {
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 20
            }, 'slow');
            //used for disable grid
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
        }
        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

        });

        function initDashboardSelectPicker() {
            if (!$.fn.selectpicker) return;
            // <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
            $('select').not('.ppc-msel-native').each(function () {
                var $select = $(this);
                if ($select.closest('.ppc-filter-bar').length) return;
                if ($select.data('selectpicker')) {
                    try { $select.selectpicker('refresh'); } catch (e) { }
                    return;
                }
                $select.addClass('selectpicker form-control fixed-width-combo');
                $select.attr('data-live-search', 'true');
                $select.selectpicker({
                    liveSearch: true,
                    container: 'body',
                    dropupAuto: true,
                    width: '100%'
            });
            });
        }


        $(document).ready(function () {
            initDashboardSelectPicker();
        });


        $(".collapse").on('show.bs.collapse', function (e) {
            var $toggler = $(e.target).closest('.panel').find('.infoToggler');
            $toggler.removeClass('togglerdown').addClass('togglerup');
            $(".table").resize();
        });
        $(".collapse").on('hide.bs.collapse', function (e) {
            var $toggler = $(e.target).closest('.panel').find('.infoToggler');
            $toggler.removeClass('togglerup').addClass('togglerdown');
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        // Entire Project Details header bar toggles accordion
        $(document).on('click', '.profitabilityinfopanel .panel-heading', function (e) {
            if ($(e.target).closest('a[data-bs-toggle="collapse"]').length) return;
            var $toggle = $(this).find('a[data-bs-toggle="collapse"]').first();
            if ($toggle.length) $toggle.trigger('click');
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        $('#TskMngmentTblID_wrapper').on('draw.dt', function () {
            $(".table").resize();
        });
        $('.paginate_button').on('draw.dt', function () {
            $(".table").resize();
        });
        
        //$('#next').on('click', function () {
        //    table.page('next').draw('page');
        //});

        //$('#previous').on('click', function () {
        //    table.page('previous').draw('page');
        //});

        function resizeSection() {
            var tblheight = $(window).height();
            $('#healthshetprojectList_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 450, "overflow-y": "auto" });

            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });




        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".chcktbl").click(function () {

            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
            }

        });



    </script>

    <script type="text/javascript">
      /* Added By Madhuri.K - Main grid/GPM: GET /api/ProjectProfitByCustomer/* */
      (function () {
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard").ToString%>';
        if (strUrl && strUrl.endsWith('/')) strUrl = strUrl.slice(0, -1);
        var accessibleProjectIds = [];
        var roleLevelProjectIds = [];
        // <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
        var defaultLoginID = <%=If(Session("intUserID") Is Nothing, 61, Session("intUserID"))%>;
        var ppcFilterMasters = { bg: [], ou: [], projects: [], customers: [], periods: [] };
        var ppcSuppressFilterChange = false;
        var gpmContext = { projectCurrency: '', baseCurrency: '' };
        var lastGpmRow = null;
        var ppcProfitRows = [];
        var ppcPagerState = { page: 1, size: 5 };

        function toQuery(params) {
          var parts = [];
          Object.keys(params || {}).forEach(function (k) {
            var v = params[k];
            if (v == null || v === '') return;
            parts.push(encodeURIComponent(k) + '=' + encodeURIComponent(v));
          });
          return parts.length ? ('?' + parts.join('&')) : '';
        }

        function isJson(str) {
          try {
            JSON.parse(str);
          } catch (e) {
            return false;
          }
          return true;
        }

        function encryptString(value) {
          var intStrArr = [];
          var strEncryptedString = '';
          var intEncryptNum = 1;
          var i;
          if (String(value).length > 0) {
            for (i = 0; i <= value.length - 1; i++) {
              intStrArr[i] = String(String(String(value[i])).charCodeAt(0) + intEncryptNum);
              intEncryptNum = intEncryptNum + 2;
            }
            strEncryptedString = intStrArr.join('-');
            if (String(strEncryptedString).substring(0, 1) == '-') {
              strEncryptedString = String(strEncryptedString).substring(1, String(strEncryptedString).length - 1);
            }
          }
          return strEncryptedString;
        }

        function apiHeaders(param, includeJsonContentType) {
          var headers = {
            'Authorization': 'bearer ' + (sessionStorage.getItem('access_token_W27_Dashboard') || '')
          };
          if (includeJsonContentType !== false) {
            headers['Content-Type'] = 'application/json';
          }
          if (param) {
            headers['Params'] = encryptString(isJson(param) ? param : JSON.stringify(param));
          }
          return headers;
        }

        function apiPost(path, payload) {
          return fetch(encodeURI(strUrl) + path, {
            method: 'POST',
            headers: apiHeaders(payload || {}),
            body: JSON.stringify(payload || {})
          });
        }

        function apiGet(path, payload) {
          return fetch(encodeURI(strUrl) + path + toQuery(payload || {}), {
            method: 'GET',
            headers: apiHeaders(payload || {}, false)
          });
        }

        function apiVal(obj) {
          if (!obj) return undefined;
          for (var i = 1; i < arguments.length; i++) {
            var k = arguments[i];
            if (Object.prototype.hasOwnProperty.call(obj, k) && obj[k] != null) return obj[k];
            var found = Object.keys(obj).find(function (ok) { return ok.toLowerCase() === String(k).toLowerCase(); });
            if (found != null && obj[found] != null) return obj[found];
          }
          return undefined;
        }

        function apiNum(obj) {
          var v = apiVal.apply(null, arguments);
          var n = Number(v);
          return isNaN(n) ? 0 : n;
        }

        function unwrapPayload(json) {
          if (!json) return {};
          var d = json.data != null ? json.data : (json.Data != null ? json.Data : json);
          if (!d || typeof d !== 'object' || Array.isArray(d)) return d || {};
          var inner = d.data != null ? d.data : d.Data;
          if (inner && typeof inner === 'object' && !Array.isArray(inner) &&
              (inner.ProjectProfitByCustomerModel != null || inner.ProjectProfitabilityGpmModel != null ||
               inner.ProjectTaskCaseStructureModel != null || inner.ProjectProfitByCustomerAccessFilterModel != null ||
               inner.CustomerDropdownModel != null || inner.ProjectDropdownModel != null ||
               inner.ProjectProfitFilterBusinessGroupModel != null || inner.ProjectProfitFilterCustomerModel != null ||
               apiVal(inner, 'ProjectProfitByCustomerModel', 'ProjectProfitabilityGpmModel',
                 'ProjectTaskCaseStructureModel', 'ProjectProfitByCustomerAccessFilterModel',
                 'CustomerDropdownModel', 'ProjectDropdownModel',
                 'ProjectProfitFilterBusinessGroupModel', 'ProjectProfitFilterOrganizationUnitModel',
                 'ProjectProfitFilterProjectModel', 'ProjectProfitFilterCustomerModel',
                 'ProjectProfitFilterPeriodModel'))) {
            return inner;
          }
          return d;
        }

        //  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
        var ppcOpenMultiSelectId = null;
        var ppcMultiSelectSearch = {};

        function closePpcMultiSelects(exceptId) {
          $('.ppc-filter-bar .msel-panel.open').each(function () {
            var id = $(this).closest('.msel').attr('data-select-id');
            if (!exceptId || id !== exceptId) $(this).removeClass('open');
          });
          if (!exceptId) ppcOpenMultiSelectId = null;
        }

        function renderPpcMultiSelect($el) {
          if (!$el || !$el.length) return;
          var selectId = $el.attr('id');
          var isMultiple = !!$el.prop('multiple');
          var placeholder = $el.attr('title') || 'Select';
          var $host = $el.next('.ppc-msel-host');

          if (!$host.length) {
            $host = $('<div class="msel ppc-msel-host"></div>')
              .attr('data-select-id', selectId)
              .insertAfter($el);
          }

          var selected = [];
          $el.find('option:selected').each(function () {
            if (this.value === '' && !isMultiple) return;
            selected.push({ value: String(this.value), text: $(this).text() });
          });

          var buttonText = placeholder;
          if (selected.length === 1) buttonText = selected[0].text;
          else if (selected.length > 1) buttonText = 'Selected';

          $host.empty();
          var $button = $('<button type="button" class="msel-btn"></button>');
          $('<span class="msel-label"></span>').text(buttonText).appendTo($button);
          if (isMultiple && selected.length > 1) {
            $('<span class="count"></span>').text(selected.length).appendTo($button);
          } else {
            $('<span class="chev"><i class="fas fa-chevron-down"></i></span>').appendTo($button);
          }
//  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
          var $panel = $('<div class="msel-panel"></div>');
          if (ppcOpenMultiSelectId === selectId) $panel.addClass('open');
          var $search = $('<input type="text" class="msel-search" />')
            .attr('placeholder', 'Search ' + placeholder.replace(/^Select\s+/i, '') + '...')
            .val(ppcMultiSelectSearch[selectId] || '');
          var $rows = $('<div class="msel-rows"></div>');
          var $empty = $('<div class="msel-empty">No matches</div>').hide();

          $el.find('option').each(function () {
            var option = this;
            if (!isMultiple && String(option.value) === '') return;
            var label = $(option).text();
            var $row = $('<label class="msel-row"></label>')
              .attr('data-label', label.toLowerCase());
            var $input = $('<input />')
              .attr('type', isMultiple ? 'checkbox' : 'radio')
              .attr('name', 'ppc-msel-' + selectId)
              .prop('checked', option.selected);
            $input.on('change', function () {
              if (isMultiple) {
                $(option).prop('selected', this.checked);
              } else {
                $el.val(String(option.value));
              }
              ppcOpenMultiSelectId = selectId;
              renderPpcMultiSelect($el);
              $el.trigger('change');
            });
            $row.append($input).append($('<span></span>').text(label));
            $rows.append($row);
          });

          function applySearch() {
            var term = String($search.val() || '').trim().toLowerCase();
            var visible = 0;
            $rows.find('.msel-row').each(function () {
              var show = !term || String($(this).attr('data-label')).indexOf(term) > -1;
              $(this).toggle(show);
              if (show) visible++;
            });
            $empty.toggle(visible === 0);
          }

          $search.on('input', function () {
            ppcMultiSelectSearch[selectId] = this.value;
            applySearch();
          });

          var $actions = $('<div class="msel-actions"></div>');
          $('<button type="button">Clear</button>').on('click', function () {
            if (isMultiple) {
              $el.find('option').prop('selected', false);
            } else {
              $el.val('');
            }
            ppcMultiSelectSearch[selectId] = '';
            ppcOpenMultiSelectId = selectId;
            renderPpcMultiSelect($el);
            $el.trigger('change');
          }).appendTo($actions);
          $('<button type="button">Close</button>').on('click', function () {
            ppcOpenMultiSelectId = null;
            $panel.removeClass('open');
          }).appendTo($actions);

          $panel.append($search, $rows, $empty, $actions);
          $host.append($button, $panel);
          applySearch();

          $button.on('click', function (e) {
            e.stopPropagation();
            if (ppcOpenMultiSelectId === selectId) {
              ppcOpenMultiSelectId = null;
              $panel.removeClass('open');
            } else {
              ppcOpenMultiSelectId = selectId;
              closePpcMultiSelects(selectId);
              $panel.addClass('open');
              $search.trigger('focus');
            }
          });
          $panel.on('click', function (e) { e.stopPropagation(); });
        }

        function refreshSelect($el) {
          if (!$el || !$el.length) return;
          if ($el.data('selectpicker') && $.fn.selectpicker) {
            try { $el.selectpicker('destroy'); } catch (e) { }
          }
          $el.removeClass('selectpicker form-control fixed-width-combo')
            .addClass('ppc-msel-native');
          renderPpcMultiSelect($el);
        }

        $(document).off('click.ppcMsel').on('click.ppcMsel', function () {
          closePpcMultiSelects();
        });

        function extractList(data) {
          if (!data) return [];
          if (Array.isArray(data)) return data;
          var rows = apiVal(data,
            'ProjectProfitByCustomerAccessFilterModel', 'projectProfitByCustomerAccessFilterModel',
            'RoleLevelAccessFilterModel', 'roleLevelAccessFilterModel'
          );
          if (Array.isArray(rows)) return rows;
          if (rows && typeof rows === 'object') return [rows];
          return [];
        }

        function collectProjectIds(rows) {
          var ids = [];
          (rows || []).forEach(function (r) {
            var id = apiVal(r, 'projectID', 'ProjectID', 'projectId', 'ProjectId');
            if (id == null || id === '' || String(id) === '0') return;
            if (ids.indexOf(String(id)) === -1) ids.push(String(id));
          });
          return ids;
        }

        function asList(rows) {
          if (!rows) return [];
          if (Array.isArray(rows)) return rows;
          if (typeof rows === 'object') return [rows];
          return [];
        }

        //  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
        function isNaName(name) {
          if (name == null || name === '') return false;
          var n = String(name).trim().toLowerCase();
          return n === 'na' || n === 'n/a' || n === 'n.a.' || n === 'n.a' || n === 'not applicable';
        }

        function isNullId(id) {
          return id == null || id === '';
        }

        function selectedIds($el, keepZero) {
          var value = $el && $el.length ? $el.val() : null;
          if (value == null || value === '') return [];
          if (!Array.isArray(value)) value = [value];
          return value.map(function (id) { return String(id); })
            .filter(function (id) {
              if (id === '') return false;
              if (!keepZero && id === '0') return false;
              return true;
            });
        }

        function restoreSelections($sel, previous) {
          var wanted = Array.isArray(previous)
            ? previous.map(String)
            : (previous == null || previous === '' ? [] : [String(previous)]);
          var available = {};
          $sel.find('option').each(function () { available[String(this.value)] = true; });
          var valid = wanted.filter(function (id) { return available[id]; });
          if ($sel.prop('multiple')) $sel.val(valid);
          else $sel.val(valid.length ? valid[0] : '');
        }

        function bindSelectOptions($sel, html, prev) {
          $sel.html(html);
          restoreSelections($sel, prev);
          refreshSelect($sel);
        }
//  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
        function extractNamedList(data, names) {
          if (!data) return [];
          if (Array.isArray(data)) return data;
          var rows = apiVal.apply(null, [data].concat(names));
          return asList(rows);
        }

        function extractProjectList(data) {
          return extractNamedList(data, [
            'ProjectProfitFilterProjectModel', 'projectProfitFilterProjectModel',
            'ProjectDropdownModel', 'projectDropdownModel'
          ]);
        }

        function extractCustomerList(data) {
          if (!data) return [];
          if (Array.isArray(data)) return data;
          if (data.data != null || data.Data != null) {
            var nested = extractCustomerList(data.data != null ? data.data : data.Data);
            if (nested.length) return nested;
          }
          var rows = extractNamedList(data, [
            'ProjectProfitFilterCustomerModel', 'projectProfitFilterCustomerModel',
            'CustomerDropdownModel', 'customerDropdownModel'
          ]);
          if (rows.length) return rows;
          var keys = Object.keys(data || {});
          for (var i = 0; i < keys.length; i++) {
            if (Array.isArray(data[keys[i]])) return data[keys[i]];
          }
          return [];
        }

        function bindBusinessGroupDropdown(rows, keep) {
          var $sel = $('#PPCSelectBG');
          var prev = keep ? $sel.val() : [];
          var html = '';
          (rows || []).forEach(function (r) {
            var id = apiVal(r, 'businessGroupID', 'BusinessGroupID', 'businessGroupId');
            var name = apiVal(r, 'businessGroupName', 'BusinessGroupName', 'name', 'Name') || id;
            if (isNullId(id) && isNaName(name)) id = 0;
            if (isNullId(id)) return;
            html += '<option value="' + esc(id) + '">' + esc(name) + '</option>';
          });
          bindSelectOptions($sel, html, prev);
        }

        function bindOrganizationUnitDropdown(rows, keep) {
          var $sel = $('#PPCSelectOU');
          var prev = keep ? $sel.val() : [];
          var html = '';
          var seen = {};
          (rows || []).forEach(function (r) {
            var id = apiVal(r, 'organizationUnitID', 'OrganizationUnitID', 'organizationUnitId');
            var name = apiVal(r, 'organizationUnitName', 'OrganizationUnitName', 'name', 'Name') || id;
            if (isNullId(id) && isNaName(name)) id = 0;
            if (isNullId(id)) return;
            if (seen[String(id)]) return;
            seen[String(id)] = true;
            html += '<option value="' + esc(id) + '">' + esc(name) + '</option>';
          });
          bindSelectOptions($sel, html, prev);
        }

        function bindProjectDropdown(rows, keep) {
          var $sel = $('#PPCselectPro');
          var prev = keep ? $sel.val() : [];
          var html = '';
          (rows || []).forEach(function (r) {
            var id = apiVal(r, 'projectID', 'ProjectID', 'projectId', 'ProjectId', 'id', 'ID');
            if (id == null || id === '' || String(id) === '0') return;
            var name = apiVal(r, 'projectName', 'ProjectName', 'name', 'Name', 'title', 'Title') || id;
            html += '<option value="' + esc(id) + '">' + esc(name) + '</option>';
          });
          bindSelectOptions($sel, html, prev);
        }

        function bindCustomerDropdown(rows, keep) {
          var $sel = $('#PPCustmrselect');
          if (!$sel.length) {
            console.error('PPCustmrselect not found');
            return;
          }
          var prev = keep ? $sel.val() : [];
          var html = '';
          (rows || []).forEach(function (r) {
            var id = apiVal(r, 'customer', 'Customer', 'customerID', 'CustomerID', 'customerId');
            if (id == null || id === '' || String(id) === '0') return;
            var name = apiVal(r, 'customerName', 'CustomerName', 'name', 'Name') || id;
            html += '<option value="' + esc(id) + '">' + esc(name) + '</option>';
          });
          bindSelectOptions($sel, html, prev);
        }
//  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
        function bindPeriodDropdown(rows, keep) {
          var $sel = $('#PPCSelectPeriod');
          var prev = keep ? $sel.val() : '';
          var list = (rows || []).slice().sort(function (a, b) {
            var oa = Number(apiVal(a, 'sortOrder', 'SortOrder') || 0);
            var ob = Number(apiVal(b, 'sortOrder', 'SortOrder') || 0);
            return oa - ob;
          });
          var html = '';
          list.forEach(function (r) {
            var value = apiVal(r, 'periodValue', 'PeriodValue');
            if (value == null || String(value) === '') return;
            var text = apiVal(r, 'periodText', 'PeriodText', 'name', 'Name') || value;
            html += '<option value="' + esc(value) + '">' + esc(text) + '</option>';
          });
          bindSelectOptions($sel, html, prev);
        }

       
        function idInList(id, ids) {
          return ids.indexOf(String(id)) !== -1;
        }
//  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
        function filterOrganizationUnits(bgIds) {
          var rows = ppcFilterMasters.ou || [];
          if (!bgIds || !bgIds.length) return rows;
          return rows.filter(function (r) {
            var rBg = apiVal(r, 'businessGroupID', 'BusinessGroupID', 'businessGroupId');
            return bgIds.some(function (bgId) {
              if (String(bgId) === '0') return isNullId(rBg) || String(rBg) === '0';
              return String(rBg) === String(bgId);
            });
          });
        }

        function getFilteredProjects() {
          var bgIds = selectedIds($('#PPCSelectBG'), false);
          var ouIds = selectedIds($('#PPCSelectOU'), false);
          var rows = ppcFilterMasters.projects || [];
          // Added By Vyankat B. on 26th Aug 2026
          // Cascade like usp_Sel_GetProjectNameList_Profitability:
          // selected BG / OU must match the project mapping. Do not keep
          // GlobalProject or null-BG/OU rows when a filter is set.
          return rows.filter(function (r) {
            var pId = apiVal(r, 'projectID', 'ProjectID', 'projectId', 'ProjectId');
            if (roleLevelProjectIds.length && roleLevelProjectIds.indexOf(String(pId)) === -1) {
              return false;
            }
            var pBg = apiVal(r, 'businessGroupID', 'BusinessGroupID', 'businessGroupId');
            var pOu = apiVal(r, 'organizationUnitID', 'OrganizationUnitID', 'organizationUnitId');
            if (bgIds.length && !idInList(pBg, bgIds)) {
              return false;
            }
            if (ouIds.length && !idInList(pOu, ouIds)) {
              return false;
            }
            return true;
          });
          // End of Added By Vyankat B. on 26th Aug 2026
        }

        function resolveDefaultProjectIds() {
          if (!roleLevelProjectIds.length) {
            return collectProjectIds(getFilteredProjects());
          }
          var bgIds = selectedIds($('#PPCSelectBG'), true);
          var ouIds = selectedIds($('#PPCSelectOU'), true);
          if (!bgIds.length && !ouIds.length) {
            return roleLevelProjectIds.slice();
          }
          var filtered = collectProjectIds(getFilteredProjects());
          return filtered.length ? filtered : roleLevelProjectIds.slice();
        }

        function applyCascade(options) {
          options = options || {};
          var keep = options.keep === true;

          ppcSuppressFilterChange = true;
          bindBusinessGroupDropdown(ppcFilterMasters.bg, keep);
          bindOrganizationUnitDropdown(filterOrganizationUnits(selectedIds($('#PPCSelectBG'), true)), keep);
          bindProjectDropdown(getFilteredProjects(), keep);
          bindCustomerDropdown(ppcFilterMasters.customers, keep);
          bindPeriodDropdown(ppcFilterMasters.periods, keep);
          accessibleProjectIds = resolveDefaultProjectIds();
          setTimeout(function () { ppcSuppressFilterChange = false; }, 0);
        }

        function storeFilterMasters(data) {
          ppcFilterMasters.bg = extractNamedList(data, [
            'ProjectProfitFilterBusinessGroupModel', 'projectProfitFilterBusinessGroupModel'
          ]);
          ppcFilterMasters.ou = extractNamedList(data, [
            'ProjectProfitFilterOrganizationUnitModel', 'projectProfitFilterOrganizationUnitModel'
          ]);
          ppcFilterMasters.projects = extractProjectList(data);
          ppcFilterMasters.customers = extractCustomerList(data);
          ppcFilterMasters.periods = extractNamedList(data, [
            'ProjectProfitFilterPeriodModel', 'projectProfitFilterPeriodModel'
          ]);
        }

        function loadFilterMasters(options) {
          options = options || {};
          var customerID = options.customerID;
          if (customerID == null) customerID = parseInt($('#PPCustmrselect').val(), 10) || 0;
          var payload = {
            loginID: defaultLoginID,
            customerID: customerID
          };

          return apiPost('/api/ProjectProfitByCustomer/GetFilterMasters', payload)
          .then(function (res) {
            if (!res.ok) throw new Error('GetFilterMasters failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            storeFilterMasters(data);
            if (!ppcFilterMasters.customers.length) storeFilterMasters(json);
            applyCascade({
              keep: options.keep === true,
              resetFrom: options.resetFrom || ''
            });
          })
          .catch(function (err) {
            console.error(err);
            storeFilterMasters({});
            applyCascade({ keep: false });
          });
        }

        function loadRoleLevelAccessFilter() {
          var payload = {
            AccessParameter: 'ProjectID',
            UserID: defaultLoginID,
            LoginType: 'E',
            RoleLevel: 2,
            ShowReleasedProjects: true
          };

          return apiGet('/api/ProjectProfitByCustomer/GetRoleLevelAccessFilter', payload)
          .then(function (res) {
            if (!res.ok) throw new Error('GetRoleLevelAccessFilter failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            var rows = extractList(data);
            roleLevelProjectIds = collectProjectIds(rows);
            accessibleProjectIds = roleLevelProjectIds.slice();
          })
          .catch(function (err) {
            console.error(err);
            roleLevelProjectIds = [];
            accessibleProjectIds = [];
          });
        }

        function isEmptyDate(v) {
          if (v == null || v === '') return true;
          var s = String(v).trim();
          if (!s) return true;
          if (s.indexOf('1900-01-01') === 0) return true;
          return false;
        }

        function resetProjectHeader() {
          $('#gpmProjectName').text('-');
          $('#gpmProjectValue').text('-');
          $('#gpmCommercialType').text('-');
          $('#gpmStartDate').text('-');
          $('#gpmEndDate').text('-');
          $('#gpmCostMethod').text('-');
          $('#gpmActualStartDate').text('');
          $('#gpmActualEndDate').text('');
        }

        function renderProjectHeader(row) {
          if (!row) {
            resetProjectHeader();
            return;
          }
          var currency = apiVal(row, 'currencySymbol', 'CurrencySymbol') || '';
          if (currency) gpmContext.projectCurrency = currency;
          if (lastGpmRow) renderGpmDetail(lastGpmRow);
          var contractVal = apiVal(row, 'contractValue', 'ContractValue');
          var projectValue = '-';
          if (contractVal != null && contractVal !== '') {
            projectValue = (currency ? (currency + ' ') : '') + fmtNum(contractVal);
          }

          $('#gpmProjectName').text(apiVal(row, 'projectName', 'ProjectName') || '-');
          $('#gpmProjectValue').text(projectValue);
          $('#gpmCommercialType').text(apiVal(row, 'nodeLabel', 'NodeLabel') || '-');
          var startDt = apiVal(row, 'expectedStartDate', 'ExpectedStartDate');
          var endDt = apiVal(row, 'expectedEndDate', 'ExpectedEndDate');
          $('#gpmStartDate').text(isEmptyDate(startDt) ? '-' : (String(startDt).indexOf('-') === 2 || String(startDt).match(/[A-Za-z]/) ? String(startDt) : fmtDateDash(startDt)));
          $('#gpmEndDate').text(isEmptyDate(endDt) ? '-' : (String(endDt).indexOf('-') === 2 || String(endDt).match(/[A-Za-z]/) ? String(endDt) : fmtDateDash(endDt)));
          $('#gpmCostMethod').text(apiVal(row, 'costMethod', 'CostMethod') || '-');

          var actualStart = apiVal(row, 'actualStartDate', 'ActualStartDate');
          var actualEnd = apiVal(row, 'actualEndDate', 'ActualEndDate');
          $('#gpmActualStartDate').text(isEmptyDate(actualStart) ? '' : fmtDateDash(actualStart));
          $('#gpmActualEndDate').text(isEmptyDate(actualEnd) ? '' : fmtDateDash(actualEnd));
        }

        function loadTaskCaseStructure(projectId) {
          var pid = parseInt(projectId, 10) || 0;
          resetProjectHeader();
          if (!pid) return;

          var payload = { ProjectId: pid };
          apiPost('/api/ProjectProfitByCustomer/GetTaskCaseStructure', payload)
          .then(function (res) {
            if (!res.ok) throw new Error('GetTaskCaseStructure failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            var rows = apiVal(data, 'ProjectTaskCaseStructureModel', 'projectTaskCaseStructureModel', 'TaskCaseStructureModel') || [];
            if (!Array.isArray(rows)) {
              // Some APIs return the model object / array directly under data
              if (Array.isArray(data)) rows = data;
              else if (data && typeof data === 'object' && (apiVal(data, 'projectName', 'ProjectName') != null || apiVal(data, 'haveSubTaskTypes', 'HaveSubTaskTypes') != null))
                rows = [data];
              else rows = [];
            }
            renderProjectHeader(rows.length ? rows[0] : null);
          })
          .catch(function (err) {
            console.error(err);
            resetProjectHeader();
          });
        }

        function fmtNum(v) {
          var n = Number(v);
          if (isNaN(n)) return '0.00';
          return n.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        }

        function fmtDate(v) {
          if (v == null || v === '') return '';
          var d = new Date(v);
          if (isNaN(d.getTime())) return String(v);
          var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
          return d.getDate() + ' ' + months[d.getMonth()] + ' ' + d.getFullYear();
        }

        function fmtDateDash(v) {
          if (v == null || v === '') return '';
          var d = new Date(v);
          if (isNaN(d.getTime())) return String(v);
          var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
          var day = ('0' + d.getDate()).slice(-2);
          return day + '-' + months[d.getMonth()] + '-' + d.getFullYear();
        }

        function esc(s) {
          return String(s == null ? '' : s)
            .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
        }

        function getGpmTrend() {
          if (document.getElementById('GPMpositive') && document.getElementById('GPMpositive').checked) return 1;
          if (document.getElementById('GPMNegative') && document.getElementById('GPMNegative').checked) return -1;
          return 0;
        }

        function buildRequest() {
          var payload = {
            gpmTrend: getGpmTrend(),
            loginID: defaultLoginID
          };
          var customerIds = selectedIds($('#PPCustmrselect'));
          var projectIds = selectedIds($('#PPCselectPro'));
          var bgIds = selectedIds($('#PPCSelectBG'), true);
          var ouIds = selectedIds($('#PPCSelectOU'), true);
          var period = $('#PPCSelectPeriod').val() || '';

          if (bgIds.length) {
            payload.businessGroupIDs = bgIds.join(',');
            payload.BusinessGroupIDs = payload.businessGroupIDs;
            if (bgIds.length === 1) {
              payload.businessGroupID = parseInt(bgIds[0], 10);
              payload.BusinessGroupID = payload.businessGroupID;
            }
          }
          if (ouIds.length) {
            payload.organizationUnitIDs = ouIds.join(',');
            payload.OrganizationUnitIDs = payload.organizationUnitIDs;
            if (ouIds.length === 1) {
              payload.organizationUnitID = parseInt(ouIds[0], 10);
              payload.OrganizationUnitID = payload.organizationUnitID;
            }
          }
          var resolvedProjectIds = projectIds.length
            ? projectIds
            : resolveDefaultProjectIds();
          if (resolvedProjectIds.length) {
            payload.projectIDs = resolvedProjectIds.join(',');
            payload.ProjectIDs = payload.projectIDs;
            if (projectIds.length === 1) {
              payload.projectID = parseInt(projectIds[0], 10) || 0;
              payload.ProjectID = payload.projectID;
            }
          }
          if (customerIds.length) {
            payload.customerIDs = customerIds.join(',');
            if (customerIds.length === 1) {
              payload.customerID = parseInt(customerIds[0], 10) || 0;
            }
          }
          if (period) {
            payload.period = period;
            payload.periodValue = period;
          }
          return payload;
        }

        function fmtMoney(v, symbol) {
          var amt = fmtNum(v);
          var sym = String(symbol == null ? '' : symbol).trim();
          return sym ? (esc(sym) + ' ' + amt) : amt;
        }

        // Added By Vishal M. on 03-09-2026 - Accrued GPM % for Total / Grand Total = (GPM / Revenue) * 100
        function calcGpmPercent(gpm, revenue) {
          var rev = Number(revenue);
          if (!rev || isNaN(rev)) return 0;
          var pct = (Number(gpm) / rev) * 100;
          return isNaN(pct) ? 0 : pct;
        }
        // End of Added By Vishal M. on 03-09-2026

          var GlobalBaseCurrency;
          function renderProfitGrid(rows, totalsRows) {
          var $body = $('#PPCTblBody');
          var allRows = (totalsRows && totalsRows.length) ? totalsRows : rows;
          if (!rows || !rows.length) {
            $body.html('<tr><td colspan="8" class="text-center text-muted">No data found for the selected filters.</td></tr>');
              $('#spancurr').html('<small>( All Figures In : - )</small>');

              var html = '';
              var currentCustomer = null;
              var grand = { rev: 0, cost: 0, gpm: 0, inv: 0 };
              var customerTotals = {};
              var baseSym = apiVal(allRows[0] || rows[0], 'baseCurrencySymbol', 'BaseCurrencySymbol') || '';
              if (rows.length > 0) {
                  GlobalBaseCurrency = baseSym;
              }
              $('#spancurr').html('<small>( All Figures In : ' + esc(GlobalBaseCurrency || '-') + ' )</small>');

            return;
          }

          var html = '';
          var currentCustomer = null;
          var grand = { rev: 0, cost: 0, gpm: 0, inv: 0 };
          var customerTotals = {};
            var baseSym = apiVal(allRows[0] || rows[0], 'baseCurrencySymbol', 'BaseCurrencySymbol') || '';
            if (rows.length > 0) {
                GlobalBaseCurrency = baseSym;
            }
            $('#spancurr').html('<small>( All Figures In : ' + esc(GlobalBaseCurrency || '-') + ' )</small>');

          // Customer and grand totals always reflect the complete dataset, not just the visible page
          allRows.forEach(function (r) {
            var cust = apiVal(r, 'customerName', 'CustomerName') || 'Unknown';
            if (!customerTotals[cust]) customerTotals[cust] = { rev: 0, cost: 0, gpm: 0, inv: 0 };
            var rowRev = apiNum(r, 'accruedRevenue', 'AccruedRevenue');
            var rowCost = apiNum(r, 'accruedCost', 'AccruedCost');
            var rowGpm = apiNum(r, 'accruedGPM', 'AccruedGPM');
            var rowInv = apiNum(r, 'invoiceRevenue', 'InvoiceRevenue');
            customerTotals[cust].rev += rowRev;
            customerTotals[cust].cost += rowCost;
            customerTotals[cust].gpm += rowGpm;
            customerTotals[cust].inv += rowInv;
            grand.rev += rowRev; grand.cost += rowCost; grand.gpm += rowGpm; grand.inv += rowInv;
          });

          function flushGroupTotal() {
            if (currentCustomer == null) return;
            var group = customerTotals[currentCustomer] || { rev: 0, cost: 0, gpm: 0, inv: 0 };
            html += '<tr class="totalrow">';
            html += '<td>Total</td><td></td><td></td>';
            html += '<td>' + fmtMoney(group.rev, baseSym) + '</td>';
            html += '<td>' + fmtMoney(group.cost, baseSym) + '</td>';
            html += '<td>' + fmtMoney(group.gpm, baseSym) + '</td>';
            // Added By Vishal M. on 03-09-2026 - show Accrued GPM % on customer Total row
            html += '<td>' + fmtNum(calcGpmPercent(group.gpm, group.rev)) + '</td>';
            // End of Added By Vishal M. on 03-09-2026
            html += '<td>' + fmtMoney(group.inv, baseSym) + '</td>';
            html += '</tr>';
          }

          rows.forEach(function (r) {
            var cust = apiVal(r, 'customerName', 'CustomerName') || 'Unknown';
            var projectId = apiVal(r, 'projectID', 'ProjectID') || 0;
            var projectName = apiVal(r, 'projectName', 'ProjectName', 'name', 'Name') || '';
            var asOn = apiVal(r, 'toDate', 'ToDate', 'asOnDate', 'AsOnDate', 'asOn', 'AsOn');
            var rev = apiNum(r, 'accruedRevenue', 'AccruedRevenue');
            var cost = apiNum(r, 'accruedCost', 'AccruedCost');
            var gpm = apiNum(r, 'accruedGPM', 'AccruedGPM');
            var gpmPct = apiNum(r, 'accruedGPMPercent', 'AccruedGPMPercent', 'accruedGpmPercent');
            var inv = apiNum(r, 'invoiceRevenue', 'InvoiceRevenue');
            var profitId = apiVal(r, 'projectProfitabilityID', 'ProjectProfitabilityID') || '';
            var rowBaseSym = apiVal(r, 'baseCurrencySymbol', 'BaseCurrencySymbol') || baseSym;
            var rowProjSym = apiVal(r, 'currencySymbol', 'CurrencySymbol') || '';

            if (currentCustomer !== cust) {
              flushGroupTotal();
              currentCustomer = cust;
              html += '<tr class="tblheadingrow graybg"><td colspan="8">' + esc(cust) + '</td></tr>';
            }

            html += '<tr data-profit-id="' + esc(profitId) + '" data-project-id="' + esc(projectId) + '" data-base-currency="' + esc(rowBaseSym) + '" data-currency="' + esc(rowProjSym) + '">';
            html += '<td></td>';
            html += '<td><a href="javascript:;" class="ppc-project-link" data-project-id="' + esc(projectId) + '" data-base-currency="' + esc(rowBaseSym) + '" data-currency="' + esc(rowProjSym) + '">' + esc(projectName) + '</a></td>';
            html += '<td>' + esc(fmtDate(asOn)) + '</td>';
            html += '<td>' + fmtNum(rev) + '</td>';
            html += '<td>' + fmtNum(cost) + '</td>';
            html += '<td>' + fmtNum(gpm) + '</td>';
            html += '<td>' + fmtNum(gpmPct) + '</td>';
            html += '<td>' + fmtNum(inv) + '</td>';
            html += '</tr>';
          });

          flushGroupTotal();
          html += '<tr class="totalrow">';
          html += '<td>Grand Total</td><td></td><td></td>';
          html += '<td>' + fmtMoney(grand.rev, baseSym) + '</td>';
          html += '<td>' + fmtMoney(grand.cost, baseSym) + '</td>';
          html += '<td>' + fmtMoney(grand.gpm, baseSym) + '</td>';
          // Added By Vishal M. on 03-09-2026 - show Accrued GPM % on Grand Total row
          html += '<td>' + fmtNum(calcGpmPercent(grand.gpm, grand.rev)) + '</td>';
          // End of Added By Vishal M. on 03-09-2026
          html += '<td>' + fmtMoney(grand.inv, baseSym) + '</td>';
          html += '</tr>';

          $body.html(html);
        }

        /* ---------- Client side pagination (Project_health_sheet.aspx style) ---------- */
        function renderProfitPager(total) {
          var $pager = $('#ppcProfitPager');
          if (!$pager.length) return;

          var totalPages = total > 0 ? Math.ceil(total / ppcPagerState.size) : 1;
          if (ppcPagerState.page < 1) ppcPagerState.page = 1;
          if (ppcPagerState.page > totalPages) ppcPagerState.page = totalPages;

          $pager.find('.ppc-total-records').text('Total Records: ' + total);
          $pager.find('.ppc-page-prev').closest('.page-item').toggleClass('disabled', ppcPagerState.page <= 1);
          $pager.find('.ppc-page-next').closest('.page-item').toggleClass('disabled', ppcPagerState.page >= totalPages || total <= 0);
        }

        function renderProfitPage() {
          var total = ppcProfitRows.length;
          var totalPages = total > 0 ? Math.ceil(total / ppcPagerState.size) : 1;
          if (ppcPagerState.page < 1) ppcPagerState.page = 1;
          if (ppcPagerState.page > totalPages) ppcPagerState.page = totalPages;

          var start = (ppcPagerState.page - 1) * ppcPagerState.size;
          renderProfitGrid(ppcProfitRows.slice(start, start + ppcPagerState.size), ppcProfitRows);
          renderProfitPager(total);
        }

        function loadProjectProfitByCustomer() {
          var $body = $('#PPCTblBody');
          $body.html('<tr><td colspan="8" class="text-center text-muted">Loading...</td></tr>');

          var payload = buildRequest();
          apiPost('/api/ProjectProfitByCustomer/GetProjectProfitByCustomer', payload)
          .then(function (res) {
            if (!res.ok) throw new Error('GetProjectProfitByCustomer failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            var rows = apiVal(data, 'ProjectProfitByCustomerModel', 'projectProfitByCustomerModel') || [];
            if (!Array.isArray(rows)) rows = [];
            ppcProfitRows = rows;
            ppcPagerState.page = 1;
            renderProfitPage();
          })
          .catch(function (err) {
            console.error(err);
            ppcProfitRows = [];
            ppcPagerState.page = 1;
            $body.html('<tr><td colspan="8" class="text-center text-danger">Unable to load profitability data.</td></tr>');
            renderProfitPager(0);
          });
        }

        function renderGpmDetail(row) {
          var $tbl = $('#gpmDetailTbl tbody');
          var $info = $('#gpmProfitInfo');
          if (!row) {
            $tbl.html('<tr><td colspan="3" class="text-center text-muted">No GPM details found.</td></tr>');
            $info.html('<p>Gross Profit Margin = Total Revenue - Total Cost</p>');
            return;
          }

          var peopleRev = apiNum(row, 'peopleRevenue', 'PeopleRevenue');
          var billExp = apiNum(row, 'accruedBillableExpenses', 'AccruedBillableExpenses', 'accuredBillableExpenses', 'AccuredBillableExpenses');
          var totalRev = apiNum(row, 'total', 'Total', 'totalRevenue', 'TotalRevenue');
          if (!totalRev && (peopleRev || billExp)) totalRev = peopleRev + billExp;

          var basePeopleRev = apiNum(row, 'basePeopleRevenue', 'BasePeopleRevenue');
          var baseBillExp = apiNum(row, 'baseAccruedBillableExpenses', 'BaseAccruedBillableExpenses', 'baseAccuredBillableExpenses', 'BaseAccuredBillableExpenses');
          var baseTotalRev = apiNum(row, 'baseTotal', 'BaseTotal', 'baseTotalRevenue', 'BaseTotalRevenue');
          if (!baseTotalRev && (basePeopleRev || baseBillExp)) baseTotalRev = basePeopleRev + baseBillExp;

          var peopleCost = apiNum(row, 'peopleCost', 'PeopleCost');
          var totalCost = apiNum(row, 'totalCost', 'TotalCost', 'cost', 'Cost');
          var basePeopleCost = apiNum(row, 'basePeopleCost', 'BasePeopleCost');
          var baseTotalCost = apiNum(row, 'baseTotalCost', 'BaseTotalCost', 'baseCost', 'BaseCost');

          // Project Currency: TaskCaseStructure.currencySymbol (e.g. Rs.)
          // Corporate Base Currency: grid baseCurrencySymbol / GPM currencySymbol when different (e.g. S$)
          var gpmSym = String(apiVal(row, 'currencySymbol', 'CurrencySymbol') || '').trim();
          var projSym = String(gpmContext.projectCurrency || '').trim();
          var baseSym = String(gpmContext.baseCurrency || apiVal(row, 'baseCurrencySymbol', 'BaseCurrencySymbol') || '').trim();
          if (!projSym) projSym = gpmSym;
          if (!baseSym && gpmSym && gpmSym !== projSym) baseSym = gpmSym;
          if (!baseSym) baseSym = gpmSym;

          var toDate = apiVal(row, 'toDate', 'ToDate', 'asOn', 'AsOn', 'fromDate', 'FromDate');
          var gpm = totalRev - totalCost;

          var html = '';
          html += '<tr class="grouprow">';
          html += '<th align="left">Accrued Revenue</th>';
          html += '<th>Project Currency' + (projSym ? '(' + esc(projSym) + ')' : '') + '</th>';
          html += '<th class="text-end">Corporate Base Currency' + (baseSym ? '(' + esc(baseSym) + ')' : '') + '</th>';
          html += '</tr>';
          html += '<tr><td align="left">People Revenue</td><td align="right">' + fmtNum(peopleRev) + '</td><td align="right">' + fmtNum(basePeopleRev) + '</td></tr>';
          html += '<tr><td align="left">Accured Billable Expenses</td><td align="right">' + fmtNum(billExp) + '</td><td align="right">' + fmtNum(baseBillExp) + '</td></tr>';
          html += '<tr class="ttlrow"><td align="left">Total Revenue</td><td align="right">' + fmtMoney(totalRev, projSym) + '</td><td align="right">' + fmtMoney(baseTotalRev, baseSym) + '</td></tr>';
          html += '<tr class="grouprow"><th align="left">Accrued Cost</th><th>&nbsp;</th><th>&nbsp;</th></tr>';
          html += '<tr><td align="left">People Cost</td><td align="right">' + fmtNum(peopleCost) + '</td><td align="right">' + fmtNum(basePeopleCost) + '</td></tr>';
          html += '<tr class="ttlrow"><td align="left">Total Cost</td><td align="right">' + fmtMoney(totalCost, projSym) + '</td><td align="right">' + fmtMoney(baseTotalCost, baseSym) + '</td></tr>';
          $tbl.html(html);

          var asOnLabel = toDate ? fmtDateDash(toDate) : '';
          var gpmBase = baseTotalRev - baseTotalCost;
          var infoHtml = '<table class="gpm-footer-tbl"><tr>';
          infoHtml += '<td>Gross Profit Margin' + (asOnLabel ? ' (as on : ' + esc(asOnLabel) + ' )' : '') + ' = Total Revenue - Total Cost</td>';
          infoHtml += '<td>' + fmtMoney(gpm, projSym) + '</td>';
          infoHtml += '<td>' + fmtMoney(gpmBase, baseSym) + '</td>';
          infoHtml += '</tr></table>';
          $info.html(infoHtml);
        }

        function loadGpmDetail(projectId) {
          var pid = parseInt(projectId, 10) || 0;
          var $tbl = $('#gpmDetailTbl tbody');
          var $info = $('#gpmProfitInfo');
          if (!pid) {
            $tbl.html('<tr><td colspan="3" class="text-center text-muted">Invalid project.</td></tr>');
            return;
          }

          $tbl.html('<tr><td colspan="3" class="text-center text-muted">Loading GPM details...</td></tr>');
          $info.html('<p>Gross Profit Margin = Total Revenue - Total Cost</p>');

          var payload = { ProjectID: pid };
          apiPost('/api/ProjectProfitByCustomer/GetGpm', payload)
          .then(function (res) {
            if (!res.ok) throw new Error('GetGpm failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            var rows = apiVal(data, 'ProjectProfitabilityGpmModel', 'projectProfitabilityGpmModel') || [];
            if (!Array.isArray(rows)) rows = [];
            // Prefer latest / last row when multiple snapshots returned
            var row = rows.length ? rows[rows.length - 1] : null;
            lastGpmRow = row;
            renderGpmDetail(row);
          })
          .catch(function (err) {
            console.error(err);
            lastGpmRow = null;
            $tbl.html('<tr><td colspan="3" class="text-center text-danger">Unable to load GPM details.</td></tr>');
          });
        }

        function openGpmModal(projectId) {
          loadTaskCaseStructure(projectId);
          loadGpmDetail(projectId);
          // Keep Project Details expanded (as per UI)
          var $collapse = $('#collapseThree');
          $collapse.addClass('show');
          $collapse.closest('.panel').find('.infoToggler').removeClass('togglerdown').addClass('togglerup');
          $collapse.closest('.panel').find('[data-bs-toggle="collapse"]').attr('aria-expanded', 'true');

          var modalEl = document.getElementById('PPCGrossProfittmodal');
          $('body').addClass('offcanvas-open');
          if (window.bootstrap && bootstrap.Offcanvas) {
            bootstrap.Offcanvas.getOrCreateInstance(modalEl).show();
          } else {
            $(modalEl).offcanvas('show');
          }
        }

        $(document).ready(function () {
          loadRoleLevelAccessFilter()
            .then(function () { return loadFilterMasters({ keep: false, customerID: 0 }); })
            .then(function () { loadProjectProfitByCustomer(); });

          $('#PPCSelectBG').on('change', function () {
            if (ppcSuppressFilterChange) return;
            applyCascade({ keep: true });
            loadProjectProfitByCustomer();
          });
          $('#PPCSelectOU').on('change', function () {
            if (ppcSuppressFilterChange) return;
            applyCascade({ keep: true });
            loadProjectProfitByCustomer();
          });
          $('#PPCselectPro').on('change', function () {
            if (ppcSuppressFilterChange) return;
            loadProjectProfitByCustomer();
          });
          $('#PPCustmrselect').on('change', function () {
            if (ppcSuppressFilterChange) return;
            loadProjectProfitByCustomer();
          });
          $('#PPCSelectPeriod').on('change', function () {
            if (ppcSuppressFilterChange) return;
            loadProjectProfitByCustomer();
          });
          $('input[name="Rgroup1"]').on('change', loadProjectProfitByCustomer);
          $('#PPCTblBody').on('click', '.ppc-project-link', function (e) {
            e.preventDefault();
            var $link = $(this);
            $('.ppc-project-link').removeClass('oc-link-active');
            $link.addClass('oc-link-active');
            gpmContext.baseCurrency = $link.attr('data-base-currency') || $link.closest('tr').attr('data-base-currency') || '';
            gpmContext.projectCurrency = $link.attr('data-currency') || $link.closest('tr').attr('data-currency') || '';
            var projectId = $link.attr('data-project-id') || $link.closest('tr').attr('data-project-id');
            openGpmModal(projectId);
          });
          $('#PPCGrossProfittmodal').on('hidden.bs.offcanvas', function () {
            $('.ppc-project-link').removeClass('oc-link-active');
            $('body').removeClass('offcanvas-open');
          });
          $('#ppcProfitPager').on('click', '.ppc-page-prev', function (e) {
            e.preventDefault();
            if ($(this).closest('.page-item').hasClass('disabled')) return;
            if (ppcPagerState.page > 1) {
              ppcPagerState.page -= 1;
              renderProfitPage();
            }
          });
          $('#ppcProfitPager').on('click', '.ppc-page-next', function (e) {
            e.preventDefault();
            if ($(this).closest('.page-item').hasClass('disabled')) return;
            var totalPages = ppcProfitRows.length > 0 ? Math.ceil(ppcProfitRows.length / ppcPagerState.size) : 1;
            if (ppcPagerState.page < totalPages) {
              ppcPagerState.page += 1;
              renderProfitPage();
            }
          });
        });
      })();
    </script>

    <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;">You are not authorize to view this page .</p>
        </div>
    </div>
    <%End If%>

    </form>
</body>
</html>
