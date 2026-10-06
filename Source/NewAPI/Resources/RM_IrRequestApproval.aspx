<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_IrRequestApproval.aspx.vb" Inherits="Whizible.RM_InfraResourceRequestApproval" %>

<!DOCTYPE html>
<html> 
      <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
	<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

  
</head>
  <style type="text/css">
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }
        /*a.clearalllink {font-weight: bold;margin: 7px 0px 0 8px;display: none;}*/
        .filter.float-end {
            margin: 2px 0 0 8px;
        }

        table tr th {
            vertical-align: middle !important;
        }

            table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
                margin-right: 0;
            }

        .notebox {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }

        /*a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }*/

        .filter.float-end {
            margin: 2px 0 0 8px;
        }

        table tr th {
            vertical-align: middle !important;
        }

            table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
                margin-right: 0;
            }

        .notebox {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }

        .dropdown-submenu .dropdown-submenu > a:after {
            border-color: transparent transparent transparent #fff;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            content: " ";
            display: block;
            float: right;
            height: 0;
            margin-right: 10px;
            margin-top: 5px;
            width: 0;
        }

        .dropdown-submenu > .dropdown-submenu:hover a:after {
            border-color: transparent transparent transparent #464a4c;
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        /*New css start*/

        .roundedCheckbox {
            position: relative
        }

            .roundedCheckbox label {
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 50%;
                cursor: pointer;
                height: 18px;
                left: 0;
                position: absolute;
                top: 0;
                width: 18px
            }

                .roundedCheckbox label:after {
                    border: 2px solid #fff;
                    border-top: none;
                    border-right: none;
                    content: "";
                    height: 6px;
                    left: 3px;
                    opacity: 0;
                    position: absolute;
                    top: 4px;
                    transform: rotate(-45deg);
                    width: 10px
                }

            .roundedCheckbox input[type="checkbox"] {
                visibility: hidden
            }

                .roundedCheckbox input[type="checkbox"]:checked + label {
                    background-color: #4263c1;
                    border-color: #4262bd
                }

                    .roundedCheckbox input[type="checkbox"]:checked + label:after {
                        opacity: 1
                    }

        .actioncolumn > .roundedCheckbox {
            width: 18px;
        }

        .actioncolumn > a, .actioncolumn > div {
            display: inline-block;
            vertical-align: middle;
        }

        .ClassRresourcename {
            position: relative;
            padding-right: 24px;
        }

            .ClassRresourcename .UpDowncollapseArrow {
                position: absolute;
                right: 10px;
            }

        .UpDowncollapseArrow .downarrow {
            width: 14px;
        }

        .weekcheckbox label:before {
            padding: 6px !important;
            border-color: #999 !important;
        }

        .table tr td .weekcheckbox label:before {
            margin-right: 8px !important;
        }

        input:checked + label:after {
            /* Modified and added by Vishal Mane on 10/10/2024 to fix extra (,) in front of cross mark */
            /*left: 3px !important;*/
            left: 0px !important;
            /* End of Modified and added by Vishal Mane on 10/10/2024 to fix extra (,) in front of cross mark */
        }

        .bglightblue {
            background: #bcd0e8;
        }

        span.RsrsCount {
            margin: 4px 0px 0px;
            display: block;
            right: 0;
            height: auto;
            font-size: 9px;
        }

        .InfraReqWeektable th, .InfraReqWeektable td {
            padding: 6px !important;
            font-size: 13px;
        }

        .rsrsPercentage {
            font-style: italic;
            font-size: 12px !important;
        }

        .bgHighlightDarkblue {
            background: #1359a6;
            color: #fff;
        }

        #MEdetails .control-label, #basicfilters label {
            line-height: 20px;
            text-align: right;
        }

        #basicfilters .input-group button {
            height: 35px;
        }

        .subtblheading {
            background: #1359ac;
            color: #fff;
            text-align: left;
            padding: 10px;
            font-size: 14px;
        }

            .subtblheading h4 {
                margin: 0;
                font-size: 14px;
            }
        /*Detailpanel*/
        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
            min-height: 92vh;
        }

        .pgdetailinner {
            padding: 10px;
        }

        .Resourcedetailpanel .tab-pane {
            padding: 20px 0;
        }

        tr.rowhiglight {
            background: #c3dbff;
        }

        .DisableContent {
            pointer-events: none;
            opacity: 0.5;
        }

            .DisableContent:hover {
                cursor: no-drop;
            }

        .dataTables_scrollBody.DisableContent {
            height: auto !important
        }

        ul.nav.nav-tabs.detailsubtabs {
            background: #f5f5f5;
            margin: -11px -11px;
            padding: 10px 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0;
            display:block;
            height:45px
        }

        .nav.detailsubtabs > li > a:hover, .nav.nav.detailsubtabs > li > a:active, .nav.nav.detailsubtabs > li > a:focus {
            background: #fff;
            color: #1359ac;
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .dblock {
            display: block;
        }

        .mr-5 {
            margin-right: 5px;
        }

        .Resourcedetailpanel .form-group .control-label {
            text-align: right;
        }

        .Resourcedetailpanel .tab-pane {
            padding: 20px 0;
        }

        .detailsubtabsbtn {
            margin-bottom: 15px;
        }

        .RRstatusbtn {
            display: block;
        }

        td.rsrsPercentage.bgHighlightDarkblue a {
            color: #fff;
        }

        /*simple pagination style*/
        .simple-pagination {
            display: inline-block;
            padding-left: 0;
            margin-top: 1rem;
            margin-bottom: 1rem;
            border-radius: .25rem
        }

            .simple-pagination li {
                display: inline
            }

            .simple-pagination .page-link, .simple-pagination .ellipse, .simple-pagination .current {
                display: inline-block;
                position: relative;
                float: left;
                padding: .5rem .75rem;
                margin-left: -1px;
                color: #0275d8;
                text-decoration: none;
                background-color: #fff;
                border: 1px solid #ddd
            }

            .simple-pagination li:first-child .page-link {
                margin-left: 0;
                border-bottom-left-radius: .25rem;
                border-top-left-radius: .25rem
            }

            .simple-pagination li:last-child .page-link {
                border-bottom-right-radius: .2rem;
                border-top-right-radius: .2rem
            }

            .simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
                z-index: 2;
                color: #fff;
                cursor: default;
                background-color: #0275d8;
                border-color: #0275d8
            }

                .simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
                    background: #1359ac;
                }
        /*End of pagination style*/

        a.IRR_Arrow.IRRInfraPrevMonth.float-start img {
            transform: rotate(275deg);
        }

        a.IRR_Arrow.IRRInfraPrevMonth.float-end img {
            transform: rotate(90deg);
        }

        .approval_crossandcheckbtn.mvapproval_crossandcheckbtn {
            text-align: center;
            display: inline-block;
            vertical-align: middle;
            margin-right: 5px;
        }

            .approval_crossandcheckbtn.mvapproval_crossandcheckbtn .input-group .btn[disabled] {
                opacity: 0.4;
            }

            .approval_crossandcheckbtn.mvapproval_crossandcheckbtn .input-group {
                margin: 0 auto;
            }

        #filterpanel .cust_tabpanel .nav-tabs > li > a:focus {
            color: #fff;
        }

        .tooltip {
            z-index: 9999;
        }

        .edit_filter {
            cursor: pointer;
        }

        .filterpanel .issfilter_actiondropdown {
            float: right;
        }

        .issfilter_actiondropdown {
            float: right;
        }

        .filterpanel .MyFiltersdropdown li span i {
            font-size: 14px;
            cursor: pointer;
            padding: 9px;
        }

        .issuefilter_container .filterpanelbody {
            background: #ffffff;
        }

        .clsFilterHighlight {
            background: #1359a6 !important;
            color: #ffffff !important;
        }

        .filter button[aria-expanded="true"] {
            background: NONE;
            color: #4263c1;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }

        .clsShowHide {
            display: none !important;
        }

        a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }

        .filter.float-end {
            margin: 2px 0 0 8px;
        }

        .IRRapprovrsname {
            color: #4263c1;
            font-weight: bold;
        }

        a.disabled:hover {
            cursor: not-allowed;
        }

        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999 !important;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            /*word-break: break-all;*/
        }

        .actioncolumn {
            width: 6% !important;
        }

/*Added by praidp on 11-3-2022 for Grid table overflow sccroll*/
#infrarequestTbl thead th:nth-child(6), #infrarequestTbl thead th:nth-child(7), #infrarequestTbl thead th:nth-child(8){min-width:90px;}
#infrarequestTbl thead th:nth-child(2), #infrarequestTbl thead th:nth-child(3){ min-width:200px;}
#infrarequestTbl thead th{min-width:80px;}
#thirdcontainer{ overflow:auto;}
.ClassRresourcename{ padding-right:30px;}
#infrarequestTbl thead {position: sticky;top: 0;z-index: 1;}
#infrarequestTbl span.idlabel{display:block;}
#infrarequestTbl tr:nth-child(2) th {margin-top: -1px;position: relative;top: -1px;}
/*End css Added by praidp on 11-3-2022*/

.filterpanelbody .form-group, .filterpanelbody .input-group{display:flex!important}
.filterpanelbody .btncalendar {
    margin-top: 0px !important;
    margin-left: 0px !important;
}
.paginated .collapse.show{display:revert!important}
.btn-group-xs > .btn, .btn-xs {
    /* Modified By Madhuri.K On 26-03-2026 */
    font-size: 11.5px;
}
#MIdetails .form-group{display:flex}
.disabled {
    pointer-events: none;
}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" style="background: #fff;" id="bodyRequest-Approval">

    <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 mb-0 text-end graybg" style="display:table">
            <h5 class="pgtitle float-start">Infrastructure Resource Request Approval</h5>


            <a href="javascript:;" class="mainclearalllink" onclick="closeFilterPanel()" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-bs-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div>
        </div>


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
                        <div id="basicfilters" class="tab-pane stackbasicfilter">
                            <div class="filterpanelbody">
                                <div class="fscroll">
                                    <div class="text-center hidden-xs centerbtn">
                                        <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="checkFiltervalidationForInfraRes();">Save and Apply</button>
                                        <button class="btn btnyellow" onclick="ApplyFilter();">Apply</button>
                                    </div>
                                    <br />
                                    <div class="row">
                                    <div class="col-sm-6 form-group">
                                        <label class="col-sm-4">Approval Date</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboApprovalFilterApprovalDate">
                                                        <option value="=">=</option>
                                                        <option value="<="><=</option>
                                                        <option value="<>"><></option>
                                                        <option value="<"><</option>
                                                        <option value=">">></option>
                                                        <option value=">=">>=</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <div class="input-group">
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtApprovalFilterApprovalDate", "txtApprovalFilterApprovalDate", "form-control",,,,,, , True, "White",, "autocomplete='off'",, ,,,,, True) %>
                                                        <span class="input-group-btn">
                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="col-sm-6 form-group">
                                        <label class="col-sm-4">Requested Date</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboApprovalFilterRequestedDate">
                                                        <option value="=">=</option>
                                                        <option value="<="><=</option>
                                                        <option value="<>"><></option>
                                                        <option value="<"><</option>
                                                        <option value=">">></option>
                                                        <option value=">=">>=</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <div class="input-group">
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtApprovalFilterRequestedDate", "txtApprovalFilterRequestedDate", "form-control",,,,,, , True, "White",, "autocomplete='off'",, ,,,,, True) %>
                                                        <span class="input-group-btn">
                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <label class="col-sm-4">Infrastructure Resources</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboApprovalFilterInfraResourceId">
                                                        <option value="=">=</option>
                                                        <option value="<>"><></option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtApprovalFilterInfraResourceId", "usp_Whizible2_Sel_tbl_RM_InfraResourceMaster",,, "class='form-control' ",,,, ,) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6 form-group">
                                        <label class="col-sm-4">From Date</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboApprovalFilterStartDate">
                                                        <option value="=">=</option>
                                                        <option value="<="><=</option>
                                                        <option value="<>"><></option>
                                                        <option value="<"><</option>
                                                        <option value=">">></option>
                                                        <option value=">=">>=</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <div class="input-group">
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtApprovalFilterStartDate", "txtApprovalFilterStartDate", "form-control",,,,,, , True, "White",, "autocomplete='off'",, ,,,,, True) %>
                                                        <span class="input-group-btn">
                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <label class="col-sm-4">To Date</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboApprovalFilterEndDate">
                                                        <option value="=">=</option>
                                                        <option value="<="><=</option>
                                                        <option value="<>"><></option>
                                                        <option value="<"><</option>
                                                        <option value=">">></option>
                                                        <option value=">=">>=</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <div class="input-group">
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtApprovalFilterEndDate", "txtApprovalFilterEndDate", "form-control",,,,,, , True, "White",, "autocomplete='off'",, ,,,,, True) %>
                                                        <span class="input-group-btn">
                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="col-sm-6 form-group">
                                        <%--Commented And Added By Reshma Chavan on 14th Dec 2021 To Rename Caption--%>
                                        <%--<label class="col-sm-4">Required Quantity</label>--%>
                                        <label class="col-sm-4">Requested Quantity</label>
                                        <%--End of Commented And Added By Reshma Chavan on 14th Dec 2021 To Rename Caption--%>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboApprovalFilterQuantity">
                                                        <option value="=">=</option>
                                                        <option value="<="><=</option>
                                                        <option value="<>"><></option>
                                                        <option value="<"><</option>
                                                        <option value=">">></option>
                                                        <option value=">=">>=</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <%-- <% CommonFunctions.HTMLControls.DrawTextBox("txtApprovalFilterQuantity", "txtApprovalFilterQuantity", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %>--%>
                                                    <input id="txtApprovalFilterQuantity" type="number" class="form-control input-sm" min="1" max="15">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <label class="col-sm-4">Allocated Quantity</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboApprovalFilterAllocated">
                                                        <option value="=">=</option>
                                                        <option value="<="><=</option>
                                                        <option value="<>"><></option>
                                                        <option value="<"><</option>
                                                        <option value=">">></option>
                                                        <option value=">=">>=</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <%-- <% CommonFunctions.HTMLControls.DrawTextBox("txtApprovalFilterAllocated", "txtApprovalFilterAllocated", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %>--%>
                                                    <input id="txtApprovalFilterAllocated" type="number" class="form-control input-sm" min="1" max="15">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6 form-group">
                                        <label class="col-sm-4">Status</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboApprovalFilterStatus">
                                                        <option value="=">=</option>
                                                        <option value="<>"><></option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <select class="form-control input-sm" id="txtApprovalFilterStatus">
                                                        <option value="">Select Status</option>
                                                        <option value="Closed">Closed</option>
                                                        <option value="Rejected">Rejected</option>
                                                        <option value="Cancelled">Cancelled</option>
                                                        <option value="Pending For Approval">Pending For Approval</option>
                                                        <option value="Ready For Assignment">Ready For Assignment</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <label class="col-sm-4">Approval By</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboApprovalFilterApprovalBy">
                                                        <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <%--Commented And Added By Reshma Chavan on 7th oct 2021 To set maxlength issueID-29516--%>
                                                    <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtApprovalFilterApprovalBy", "txtApprovalFilterApprovalBy", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %>--%>
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtApprovalFilterApprovalBy", "txtApprovalFilterApprovalBy", "form-control",, 50,,,, ,,,, "onkeypress ='return restrictSpecialChars(event)' autocomplete='Off'",, ,,,,, True) %>
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
        <!--moved div by pradip on 21-7-2021-->
        <div class="pt-1 pb-1 text-end row mx-1">
            <div class="col-sm-3">
                <% CommonFunctions.HTMLControls.DrawComboBox("CboIrProjectForList", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee " & Convert.ToInt32(Session("intUserId").ToString()),,, "class='form-control'  onChange='javascript:CboIrProjectForList_OnChange(this.value);'", False,,) %>
            </div>
            <div class="col-sm-9 text-end" style="padding-top: 5px;">
                <%--<a href="javascript:;" data-bs-toggle="modal" data-bs-target="#InfraCRmodal" class="btn borderbtn" onclick="bulkApproveOrReject('Cancelled')">Cancel Request</a>--%>
                <%--Commented & Added By Rutuja D. on 7 Sept 2021--%>
                <%--<a href="javascript:;" data-bs-toggle="modal" class="btn borderbtn" onclick="bulkApproveOrReject('Cancelled')">Cancel Request</a>--%>
                <%--<a href="javascript:;" class="btn borderbtn" onclick="bulkApproveOrReject('Pending For Approval')">Approve</a>--%>                
                <%--<a href="javascript:;" class="btn borderbtn" onclick="bulkApproveOrReject('Rejected')">Reject</a>--%>
                <% If m_blnAddAccess = True Or m_blnEditAccess = True Then %>
                <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" id="btnGridCancel" onclick="CheckSelectionCount('Cancelled')">Cancel Request</a>
                <a href="javascript:;" class="btn borderbtn" id="btnGridApprove" onclick="CheckSelectionCount('Pending For Approval')">Approve</a>
                <a href="javascript:;" class="btn borderbtn" id="btnGridReject" onclick="CheckSelectionCount('Rejected')">Reject</a>
                <% End If %>
                <%-- Added by imran on 14-12-2021--%>
                <%-- Commented and Added by Reshma Chavan on 10th macrh 2022--%>
                <%--<a class="btn borderbtn" onclick="history.back()" id="BtnBack">Back</a>--%>
                <a  class="btn borderbtn" id="BtnBack">Back</a>
                <%-- End of Commented and Added by Reshma Chavan on 10th macrh 2022--%>
                <%--End by imran on 14-12-2021--%>

                <%--End of Commented & Added By Rutuja D. on 7 Sept 2021--%>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <!--end filter panel-->

    <!-- Save filter Modal start here-->
    <div class="modal custmodal InfraRessavefiltersave_filter fade" id="InfraRessavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Save Filter As</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="InfraRessavefiltersavrefilterbox" class="box-panel">

                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-end required">Filter Name :</label>
                                        <span class="col-md-8">
                                            <%--Commented And Added By Reshma Chavan to Set maxlength 50 Chracters IssueID-29502--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control",, maxLength:=100) %><br />--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control",, maxLength:=50) %><br />
                                            <%--End of Commented And Added By Reshma Chavan to Set maxlength 50 Chracters--%>
                                            <div class="btnrow">
                                                <button class="btn btnyellow float-start" id="btnSaveFilter" onclick="SaveApproveFilterDetails()">Save</button>
                                                <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end">Cancel</button>
                                            </div>
                                        </span>
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
    <!-- Save filter Modal End here-->
    <div class="content pt-0">
        <div class="clearfix"></div>
        <div id="thirdcontainer">
            <table id="infrarequestTbl" class="table table-bordered paginated" style="width: 100%;">
            </table>
                        
            <div class="clearfix"></div>
        </div>
        <div id="pagination" class="float-end"></div>

    </div>



    <div class="Resourcedetailpanel">
        <div class="pgdetailinner">
            <ul class="nav nav-tabs detailsubtabs">
                <li><a href="#MIdetails" class="active" data-bs-toggle="tab" id="">Details</a></li>

            </ul>
            <div class="clearfix"></div>

            <div class="tab-content">
                <div id="MIdetails" class="tab-pane active">
                    <div class="detailsubtabsbtn pb-1 text-end">
                        <%--<a href="javascript:;" data-bs-toggle="modal" data-bs-target="#InfraCRmodal" class="btn borderbtn mr-5" id="btnCancel">Cancel Request</a>--%>
                        <%-- <a href="javascript:;" class="btn borderbtn mr-5" id="btnApprove" onclick="UpdateInfraRequest(1)">Approve</a>
                        <a href="javascript:;" class="btn borderbtn mr-5" id="btnReject" onclick="UpdateInfraRequest(0)">Reject</a>--%>
                        <% If m_blnAddAccess = True Or m_blnEditAccess = True Then %>
                        <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#InfraCRmodal" class="btn borderbtn mr-5" id="btnCancel">Cancel Request</a>
                        <a href="javascript:;" class="btn borderbtn mr-5" id="btnApprove" onclick="OpenEditApprovePopup('Approve')">Approve</a>
                        <a href="javascript:;" class="btn borderbtn mr-5" id="btnReject" onclick="OpenEditApprovePopup('Reject')">Reject</a>
                        <a href="javascript:;" onclick="bookResource()" class="btn btnyellow mr-5" id="">Save</a>
                        <% End If %>
                        <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="CancleDetails()">Cancel</button>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label">Request ID</label>
                                    <div class="col-sm-8 pl-0">
                                        <input disabled id="IRRdetailReqID" type="text" class="form-control">
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                &nbsp;
                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label">Infrastructure Resource</label>
                                    <div class="col-sm-8 pl-0">
                                        <input disabled id="IRRdetailReqName" type="text" class="form-control" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label">Request Date</label>
                                    <div class="col-sm-8 pl-0">
                                        <div class="input-group datefielddiv">
                                            <input disabled id="IRRDetailReqDate" type="text" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label">From Date</label>
                                    <div class="col-sm-8 pl-0">
                                        <div class="input-group datefielddiv">
                                            <input disabled id="IRRDetailFromDate" type="text" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label">To Date</label>
                                    <div class="col-sm-8 pl-0">
                                        <div class="input-group datefielddiv">
                                            <input disabled id="IRRDetailToDate" type="text" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label">Required Quantity</label>
                                    <div class="col-sm-8 pl-0">
                                        <input disabled id="IRRDetailRequiredQuantity" type="number" class="form-control" min="1" max="15" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label required">Allocated Quantity</label>
                                    <div class="col-sm-8 pl-0">
                                        <input disabled id="IRRDetailAllocatedQuantity" type="number" class="form-control" min="1" max="15" />
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label">Allocated Date</label>
                                    <div class="col-sm-8 pl-0">
                                        <div class="input-group datefielddiv">
                                            <input disabled id="IRRDetailAllocatedDate" type="text" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label">Allocated To</label>
                                    <div class="col-sm-8 pl-0">
                                        <input disabled id="IRRDetailAllocatedBy" type="text" class="form-control" />
                                    </div>

                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label">Approval Status</label>
                                    <div class="col-sm-8 pl-0">
                                        <select class="form-control" disabled id="IRRDetailApprovalStatus">
                                            <option>Select Status</option>
                                            <option>Pending For Approval</option>
                                            <option>Ready For Assignment</option>
                                            <option>Rejected</option>
                                            <option>Closed</option>
                                            <option>Cancelled</option>
                                            <option>Assigned</option>

                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label">Approval Comments</label>
                                    <div class="col-sm-8 pl-0">
                                        <%--<textarea id="IRRDetailApprovalComments" class="form-control"></textarea>--%>
                                        <% CommonFunctions.HTMLControls.DrawTextArea("IRRDetailApprovalComments", "IRRDetailApprovalComments", "Enter Summary (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Comment (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                                    </div>

                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label">Approval by</label>
                                    <div class="col-sm-8 pl-0">
                                        <input disabled id="IRRDetailApprovalBy" type="text" class="form-control" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="row">
                                    <label for="" class="col-sm-4 control-label">Approval Date</label>
                                    <div class="col-sm-8 pl-0">
                                        <div class="input-group datefielddiv">
                                            <input disabled id="IRRDtailApprvlDate" type="text" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-6">
                                <div class="row IRRapprovrsnamecls">
                                    <label for="" class="col-sm-4 control-label">Request Approver</label>
                                    <div class="col-sm-8 pl-0">
                                        <div class="IRRapprovrsname">
                                            <label id="IRRapprovrsname"></label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                &nbsp;
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


        <!-- ./wrapper -->

    <div class="modal custmodal fade" id="InfraCRmodal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Cancel Request</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <div class="col-sm-12">
                            <label class="">Comment</label>
                            <textarea id="IRRCancelComment" class="form-control"></textarea>
                        </div>

                    </div>
                    <input type="hidden" id="hdnInfraRequestID" name="hdnInfraRequestID">
                    <br />
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        <button class="btn btnyellow" data-bs-dismiss="modal" onclick="CancelRequest()">Save</button>

                    </div>

                </div>
            </div>
        </div>
    </div>


    <div class="modal custmodal fade" id="BulkInfraCRmodal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><span id="WhichInfraRequest"></span> Request</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <div class="col-sm-12">
                            <label class="">Comment</label>
                            <textarea id="BulkIRRCancelComment" class="form-control"></textarea>
                        </div>

                    </div>
                    <input type="hidden" id="BulkhdnInfraRequestID" name="hdnInfraRequestID">
                    <input type="hidden" id="BulkhdnInfraRequest" name="BulkhdnInfraRequest">
                    <br />
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        <button class="btn btnyellow" onclick="CheckCommentValidation()">Save</button>

                    </div>

                </div>
            </div>
        </div>
    </div>

    <%--Added by mahesh 5 oct 2021--%>


    <div class="modal custmodal fade" id="EditInfraCRmodal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><span id="EditWhichInfraRequest"></span>Request</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <div class="col-sm-12">
                            <label class="">Comment</label>
                            <textarea id="EditIRRCancelComment" class="form-control"></textarea>
                        </div>

                    </div>
                    <input type="hidden" id="EdithdnInfraRequestID" name="EdithdnInfraRequestID">
                    <input type="hidden" id="EdithdnInfraRequest" name="EdithdnInfraRequest">
                    <br />
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        <button class="btn btnyellow" onclick="UpdateEditApprovePopup()">Save</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <%--End  Added by mahesh 5 oct 2021--%>

      <div class="modal custmodal fade" id="CollapseInfraCRmodal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><span id="CollapseWhichInfraRequest"></span>Request</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <div class="col-sm-12">
                            <label class="">Comment</label>
                            <textarea id="CollapseIRRCancelComment" class="form-control"></textarea>
                        </div>

                    </div>
                    <input type="hidden" id="CollapsehdnInfraRequestID" name="CollapsehdnInfraRequestID">
                    <input type="hidden" id="CollapsehdnInfraRequest" name="CollapsehdnInfraRequest">
                    <input type="hidden" id="CollapsehdnInfraRequestAllocated" name="CollapsehdnInfraRequest">
                    <br />
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        <button class="btn btnyellow" onclick="ApproveRejectRequest()">Save</button>
                    </div>

                </div>
            </div>
        </div>
    </div>


    <!-- REQUIRED JS SCRIPTS -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
  --%>  <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
<%--	<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.simplePagination.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script> --%>
<%--    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></scrip--%>t>
    <!-- Commented and Added by Vishal Mane on 30/12/2025 for version upgrade of moment.js for W26 --> 
    <%--<script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/moment-2.30.1.js"></script>
    <!-- End of Commented and Added by Vishal Mane on 30/12/2025 for version upgrade of moment.js for W26 -->

    <div class="modal custmodal fade" id="AprvRejectConfirmMModal" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="StuatusChange"></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                   <%-- Commented & Added By Dipali V On 23rd March 2023 For Alignment issue--%>
                    <%--<div class="form-group row">--%>
                    <div class="form-group">
                         <%--End of Commented & Added By Dipali V On 23rd March 2023 For Alignment issue--%>
                        <%--<strong>Note:</strong> <span id="Note"></span> <br />--%>
                        <strong>
                            <label id="lbldltCount"></label>
                        </strong><span id="deleted"></span>
                        <br />
                        <strong>
                            <label id="lblNotdltCount"></label>
                        </strong><span id="notdeleted"></span>
                        <br />
                        <p id="showdeleterow"></p>
                    </div>

                    <div class="text-end">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <%--Added by Rutuja D on 6th July 2021--%>
    <div id="deleteConfirmAlert" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                    <h4 class="modal-title">Delete Confirmation</h4>
                </div>
                <div class="modal-body">
                    <input type="text" id="DFilterID" hidden="hidden" />
                    <input type="text" id="DFilterName" hidden="hidden" />
                    <input type="text" id="DIsApplyed" hidden="hidden" />
                    <p id="deleteConfirmMsg">
                        <center>Are you sure to delete the selected filter?</center>
                    </p>
                </div>
                <div class="modal-footer">
                    <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal">No</button>
                    <button class="btn btnyellow" data-bs-toggle="modal" data-bs-original-title="" data-bs-dismiss="modal" title="" onclick="confirmDelete()">Yes</button>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>

    <%--End of Added by Rutuja D on 6th July 2021--%>

    <script>
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        //Added By Rehan C To add Validator for Special characters on 11th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var RoleDes = '';
        var SessionProjectId = '<%= Session("intProjectId") %>';
     <%--    var RoleName = '<%= Session("strRoleName") %>';--%>
        var selectedProjectID = '<%= Session("IntProjectID") %>';


        if (SessionProjectId != '' && SessionProjectId != 'undefined' && SessionProjectId > 0) {
            $('#CboIrProjectForList').val(SessionProjectId);
            CboIrProjectForList_OnChange(SessionProjectId);
        }

        var DeleteRecord = "Please select at least one record to delete.";
        var NoDataFound = "No data found.";

        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';
        var noOfRowsPerPage = 10;

        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var TagID = '<%= m_TagId%>';
        var UserRoleLevel = '<%= m_RoleLevel%>';
        var Parameters = "";
        var BackPageName='';
        $(document).ready(function ()
        {

            //Commented and Added by Reshma Chavan on 10th macrh 2022
            //Added by imran on 15-12-2021 BAck button show hide
           // var url = window.location.href
            //var Urlflag = url.split("?")[1]
            //if (Urlflag != "Flag=True")
            //{
            //    $("#BtnBack").hide();
            //} 
             Parameters = getParameters();
            var ProjectID = unescape(Parameters["ProjectID"]);
            var Urlflag = unescape(Parameters["Flag"]);
            BackPageName = unescape(Parameters["PageName"]); 
            if (Urlflag != "True")
            {
                $("#BtnBack").hide();
            } 
            if (ProjectID != "undefined") {
                $('#CboIrProjectForList').val(ProjectID);              
             } 
            
            //End comment by imran on 15 12-2021
            //End of Commented and Added by Reshma Chavan on 10th macrh 2022

            //Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
            BindPlaceholder("txtApprovalFilterInfraResourceId", "Infrastructure Resources")
            //End of Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
            if (blnViewAccess == "True") {
                GetMyInfraResFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);
                    FilterApplied();

                } else {
                    var whereClause = "ProjectId = " + $('#CboIrProjectForList').val();
                    GetInfraResDetails(whereClause);
                    FilterNotApplied();
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
            //Added BY Rutuja D. on 6 Jun 2022 For Check User Is Infra Approver
            //GetUserIsInfraApprover();
            //Added BY Rutuja D. on 6 Jun 2022 For Check User Is Infra Approver

        });

        /*Added By Dipali V On 31st Jan 2023 for hide tooltip*/
        $(".ui-datepicker").click(function () {
            $('.tooltip').removeClass('show');
        });

        $("#txtApprovalFilterRequestedDate,#txtApprovalFilterApprovalDate,#txtApprovalFilterStartDate,#txtApprovalFilterEndDate").on("change", function () {
            $('.btn').tooltip({ trigger: 'hover' });
            $('span').tooltip({ trigger: 'hover' });
            $('.ui-datepicker-calendar th span').tooltip('hide');
            $('.tooltip-inner').tooltip('hide');
            $(".tooltip").removeClass('show');
        });
        /*End of Added By Dipali V On 31st Jan 2023 for hide tooltip*/

        //filter validation
        function checkFiltervalidationForInfraRes() {
            var approvalDate = $("#txtApprovalFilterApprovalDate").val() == "" ? null : $("#txtApprovalFilterApprovalDate").val();
            var resourceId = $("#txtApprovalFilterInfraResourceId").val() == "" ? null : $("#txtApprovalFilterInfraResourceId").val();
            var requestedDate = $("#txtApprovalFilterRequestedDate").val() == "" ? null : $("#txtApprovalFilterRequestedDate").val();
            var startDate = $("#txtApprovalFilterStartDate").val() == "" ? null : $("#txtApprovalFilterStartDate").val();
            var endDate = $("#txtApprovalFilterEndDate").val() == "" ? null : $("#txtApprovalFilterEndDate").val();
            var quantity = $("#txtApprovalFilterQuantity").val() == "" ? null : $("#txtApprovalFilterQuantity").val();
            var allocated = $("#txtApprovalFilterAllocated").val() == "" ? null : $("#txtApprovalFilterAllocated").val();
            var status = $("#txtApprovalFilterStatus").val() == "" ? null : $("#txtApprovalFilterStatus").val();
            var approvalBy = $("#txtApprovalFilterApprovalBy").val() == "" ? null : $("#txtApprovalFilterApprovalBy").val();
            var ProjectId = $('#CboIrProjectForList').val();
            if ((approvalDate == null || approvalDate == 'undefined' || approvalDate == ' ') && (resourceId == null || resourceId == 'undefined' || resourceId == ' ' || resourceId == 0) && (requestedDate == null || requestedDate == 'undefined' || requestedDate == ' ') && (startDate == null || startDate == 'undefined' || startDate == ' ') && (endDate == null || endDate == 'undefined' || endDate == '') && (quantity == null || quantity == 'undefined' || quantity == ' ') && (allocated == null || allocated == 'undefined' || allocated == ' ') && (status == null || status == 'undefined' || status == ' ' || status == 0) && (approvalBy == null || approvalBy == 'undefined' || approvalBy == ' ')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                $('#InfraRessavefilter').modal('hide');
                //Added by Vishal Mane on 10/10/2024 To fix crash issue when nothing is selected from dropdowns, need to restrict to insert blank data
                return false;
                //End of Added by Vishal Mane on 10/10/2024 To fix crash issue when nothing is selected from dropdowns, need to restrict to insert blank data
            }
            if (ProjectId == '0' || ProjectId == 'undefined') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select project');
                return false;
            }
           //Added By Reshma Chavan on 8th Oct 2021 For negative number validation IssueID-29515 And 29503
            //commented and added by imran 
            //if (quantity != "") {
            if (quantity != "" && quantity != null && quantity != "null") {                
                   if (quantity < 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Please Enter Positive Numeric Value For Required Quantity');
                    $('#txtApprovalFilterQuantity').focus();
                    filterFlag = false;
                    return false;
                }
                //Added by imran on 15-12-2021
                else {
                    $('#InfraRessavefilter').modal('show');
                }
                //End by imran 15-12-2021
            }
            
            if (allocated != "" && allocated != null && allocated != "null") {               
                if (allocated < 0)
                {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Please Enter Positive Numeric Value For Allocated Quantity');
                    $('#txtApprovalFilterAllocated').focus();
                    filterFlag = false;
                    return false;
                }
                //Added by imran on 15-12-2021
                else {
                    $('#InfraRessavefilter').modal('show');
                }
                //End by imran 15-12-2021
            }
             //End of Added By Reshma Chavan on 8th Oct 2021 For negative number validation IssueID-29515 And 29503
            else {
                $('#InfraRessavefilter').modal('show');
            }
        }

        //Added By Rehan C To add Validator for Special characters on 12th Nov 2022
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


        function AvoidSpace(input) {
            if (/^\s/.test(input.value))
                input.value = '';
        }
        // FilterDetails
        function ApplyFilter() {
            var filterFlag = true;
            var approvalDate = $("#txtApprovalFilterApprovalDate").val() == "" ? null : $("#txtApprovalFilterApprovalDate").val();
            var resourceId = $("#txtApprovalFilterInfraResourceId").val() == "" ? null : $("#txtApprovalFilterInfraResourceId").val();
            var requestedDate = $("#txtApprovalFilterRequestedDate").val() == "" ? null : $("#txtApprovalFilterRequestedDate").val();
            var startDate = $("#txtApprovalFilterStartDate").val() == "" ? null : $("#txtApprovalFilterStartDate").val();
            var endDate = $("#txtApprovalFilterEndDate").val() == "" ? null : $("#txtApprovalFilterEndDate").val();
            var quantity = $("#txtApprovalFilterQuantity").val() == "" ? null : $("#txtApprovalFilterQuantity").val();
            var allocated = $("#txtApprovalFilterAllocated").val() == "" ? null : $("#txtApprovalFilterAllocated").val();
            var status = $("#txtApprovalFilterStatus").val() == "" ? null : $("#txtApprovalFilterStatus").val();
            var approvalBy = $("#txtApprovalFilterApprovalBy").val() == "" ? null : $("#txtApprovalFilterApprovalBy").val();
            var ProjectId = $('#CboIrProjectForList').val();
            if ((approvalDate == null || approvalDate == 'undefined' || approvalDate == ' ') && (resourceId == null || resourceId == 'undefined' || resourceId == ' ' || resourceId == 0) && (requestedDate == null || requestedDate == 'undefined' || requestedDate == ' ') && (startDate == null || startDate == 'undefined' || startDate == ' ') && (endDate == null || endDate == 'undefined' || endDate == '') && (quantity == null || quantity == 'undefined' || quantity == ' ') && (allocated == null || allocated == 'undefined' || allocated == ' ') && (status == null || status == 'undefined' || status == ' ' || status == 0) && (approvalBy == null || approvalBy == 'undefined' || approvalBy == ' ')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                filterFlag = false;
                return false;
            }
            if (ProjectId == '0' || ProjectId == 'undefined') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select project');
                filterFlag = false;
                return false;
            }
            //Added By Reshma Chavan on 8th Oct 2021 For negative number validation IssueID-29515 And 29503
            if (quantity != "") {
                
                   if (quantity < 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Please Enter Positive Numeric Value For Required Quantity');
                    $('#txtApprovalFilterQuantity').focus();
                    filterFlag = false;
                    return false;
                }
            }
            if (allocated != "") {               
                   if (allocated < 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Please Enter Positive Numeric Value For Allocated Quantity');
                    $('#txtApprovalFilterAllocated').focus();
                    filterFlag = false;
                    return false;
                }
            }
           
             //End of Added By Reshma Chavan on 8th Oct 2021 For negative number validation IssueID-29515 And 29503
            if (filterFlag == true) {
               
                currentFilterID = 0;
                var filter = "";
                var AllInfraFilter = ["ApprovalDate", "RequestedDate", "InfraResourceId", "StartDate", "EndDate", "Quantity", "Allocated", "Status", "ApprovalBy"];
                var filterWhereClause2 = GenerateApprovalBasicFilterQuery("Approval", AllInfraFilter);
                var filterWhereClause = (filterWhereClause2).replace(/"/g, "\'");
                //filter = { UniqueID: '0', WhereClause: encodeURIComponent(filterWhereClause) }
                FilterApplied();
                var whereClause = " AND ProjectId = " + $('#CboIrProjectForList').val();
                filterWhereClause = filterWhereClause + whereClause;

                GetAllResourceRequests(encodeURIComponent(filterWhereClause));
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");

            }
        }

        function GenerateApprovalBasicFilterQuery(module, filterField) {
            try { 
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();

                    if (strvalue != "" && strvalue != undefined && strvalue != 0) {
                        //Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        strvalue = strvalue.replace(/"/g, "\'");
                        strvalue = strvalue.replace(/'/g, "''");
                        //Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        if (strqtext != "") strqtext += " AND ";
                        if (strOp == "Contains") {
                            strqtext += filterField[i] + " LIKE ";
                            //strqtext += " ''%" + strvalue + "%''";
                            //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "%' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "%' + strvalue + '%"';
                            }
                            //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Ends With") {
                            strqtext += filterField[i] + " LIKE ";
                            // strqtext += " ''%" + strvalue + "''";
                            //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "%' + strvalue + '"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "%' + strvalue + '"';
                            }
                            //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Exact Word") {
                            strqtext += filterField[i] + " = ";
                            //strqtext += " ''" + strvalue + "''";
                            strqtext += ' "' + strvalue + '"';
                        }
                        else if (strOp == "Not Contains") {
                            strqtext += filterField[i] + " ";
                            //strqtext += " NOT LIKE ''%" + strvalue + "%''";
                            //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' NOT LIKE "%' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' NOT LIKE "%' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' NOT LIKE "%' + strvalue + '%"';
                            }
                            //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Starts With") {
                            strqtext += filterField[i] + " LIKE ";
                            // strqtext += " ''" + strvalue + "%''";
                            //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' "' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "' + strvalue + '%"';
                            }
                            //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        }

                        else {

                            strqtext += filterField[i] + " ";
                            if ($.isNumeric(strvalue) == false) {
                                // strqtext += strOp + " ''" + strvalue + "''";
                                //strqtext += strOp + " ''" + strvalue + "''";

                                strqtext += strOp + " '" + strvalue + "'";
                            }
                            else {

                                //strqtext += strOp + " " + strvalue + "";
                                strqtext += strOp + ' "' + strvalue + '"';
                            }
                        }
                    }
                }

                strqtext = strqtext.replace('Over', '[Over]')
                //strqtext = strqtext.replace(/'/g, "''");
                //strqtext = strqtext.replace(/"/g, "''");                
                return strqtext;
            }
            catch (ex) {
                //alert(ex.message);
            }

        }

        function SaveApproveFilterDetails() {
            var fltFilterName = $("#txtFilterName").val();
            if (fltFilterName == "" || fltFilterName == " ") {
                //$('#BgSavefilter').modal('show');
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name');
                //$('#BgSavefilter').modal('show')

                $("#txtFilterName").focus();

                //return false
            }
            //Added By Rehan C To add Validator for Special characters on 12th Nov 2022
            else if (checkSpecialCharacter(fltFilterName, WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $(ControlValidationFieldID[i]).focus()
                $("#txtFilterName").focus();


            }
            //else if ($("#txtFilterName").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtFilterName").focus();
            //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Filter Name can not contain any of these /\:*?<>|,"+- characters.');
            //}
            else {
               
                var filterExists = 0;
                var AllInfraFilter = ["ApprovalDate", "RequestedDate", "InfraResourceId", "StartDate", "EndDate", "Quantity", "Allocated", "Status", "ApprovalBy"];
                //var isActiveFilter = 'True';/// $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GenerateApprovalBasicFilterQuery("Approval", AllInfraFilter);
                //Commented and Added by Riddhesh Patil on 02 Oct 2024 for filter issue
                /*                var whereClause = " ProjectId = " + $('#CboIrProjectForList').val();*/
                var whereClause = " AND ProjectId = " + $('#CboIrProjectForList').val();
                //End of Commented and Added by Riddhesh Patil on 02 Oct 2024 for filter issue
                filterWhereClause2 = filterWhereClause2 + whereClause;
                filterWhereClause = filterWhereClause2.replace(/"/g, "\'");

                var paramFilterID = 0;
                paramFilterID = currentFilterID;

                //if (currentFilterID != 0) {
                //    if (fltFilterName != savedFilterName) {
                //        paramFilterID = 0;
                //    }
                //}

                var paramFlag = 0;
                if (paramFilterID == 0) {
                    paramFlag = 0;
                }
                else {
                    paramFlag = 1;
                }

                var Parameters = {
                    TagID: encodeURI(TagID),
                    ProjectID: 0,
                    EmployeeID: encodeURI(SessionEmployeeId),
                    FilterName: encodeURI(fltFilterName),
                    LoginType: encodeURI(SessionLoginType),
                    CreatedBy: encodeURI(UserName),
                    WhereClause: encodeURIComponent(filterWhereClause),
                    Flag: encodeURI(paramFlag),
                    FilterID: encodeURI(paramFilterID)
                }
                console.log(Parameters);

                $.ajax({
                    url: encodeURI(strUrl) + '/api/RM_MyFilter/SaveMyFilter',

                    method: 'Post',
                    data: JSON.stringify(Parameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json",  /*;charset-utf=8*/
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    success: function (data) {

                        if (data == "Filter name already exist") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                            // $('#OuSavefilter').modal('show');
                            // currentFilterID = 0;
                        }
                        else {
                            if (data != undefined && data != "") {
                                currentFilterID = data;
                                currentappliedfilter = currentFilterID;
                            }
                            $('#InfraRessavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            ApplyFilter();
                            FilterApplied();
                            GetMyInfraResFilter(0);
                            savedFilterName = fltFilterName;
                            $("#txtFilterName").val("");
                            //clearTooltip();
                            // ClearFilterDetails("");
                        }


                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (xhr, errorThrown) {
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    //},
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                //window.open("../../../Default.aspx", "_top");
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            } else {
                                //window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                });
                //}
            }
        }

        function GetMyInfraResFilter(flag) {
            var Parameters = {
                ProjectID: 0,
                TagID: encodeURI(TagID),
                LoginType: encodeURI(SessionLoginType),
                EmployeeID: encodeURI(SessionEmployeeId)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/RM_MyFilter/GetMyFilters',
                method: 'POST',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {
                    var strHTML = "";
                    var defaultFilterId = 0;
                    $("#MyFiltersdropdown").empty();
                    if ($("#MyFiltersdropdown").hasClass("dropdown-menu")) {

                    }
                    else {
                        $("#MyFiltersdropdown").addClass("dropdown-menu");
                    }

                    if (data.length != 0) {

                        for (var i = 0; i < data.length; i++) {
                            var ObjMyFilter = data[i];
                            strHTML += "<li>";
                            if (ObjMyFilter.SetDefault === true) {
                                defaultFilterId = ObjMyFilter.FilterId;
                                currentDefaultFilterID = defaultFilterId;

                                strHTML += "<label class='customradio'>";

                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-bs-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='radio' name='project2' onclick='SetDefaultFilter(this.id,&quot;default&quot;)' checked='checked'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-bs-placement='right' title='Remove Default filter' class='checkmark'></span>";
                                strHTML += "</label>";

                            }
                            else {
                                strHTML += "<label class='customradio'>";
                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-bs-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='radio' name='project2' onclick='SetDefaultFilter(this.id,&quot;&quot;)'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-bs-placement='right' title='Set Default filter' class='checkmark'></span>";
                                strHTML += "</label>";
                            }

                            strHTML += "<label class=''>";
                            strHTML += "<span for='project2' class='radiotextsty filtername'>" + ObjMyFilter.FilterName + "</span>";
                            strHTML += "</label>";

                            strHTML += "<div class='custom_chckbox_markblue'>";

                            var blnApply = false;
                            if (currentappliedfilter != 0 && flag != 3) {
                                if (currentappliedfilter == ObjMyFilter.FilterId) {
                                    blnApply = true;
                                }
                            }

                            if (ObjMyFilter.SetDefault == "True") {
                                strHTML += "<div class='custom_chckbox_markblue'>";

                                if (currentappliedfilter != 0 && flag != 3) {
                                    if (blnApply == true) {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                    }
                                    else {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                    }
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }

                                strHTML += "</div>";
                            }
                            else {
                                strHTML += "<div class='custom_chckbox_markblue'>";
                                if (blnApply == true) {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }
                            }

                            strHTML += "<span onclick='OpenBasicFilter()' class='edit_filter'>";

                            strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Edit filter' id='" + ObjMyFilter.FilterId + "' class='fas fa-pencil-alt' onclick='EditFilter(this.id);'></i>";

                            strHTML += "</span>";

                            strHTML += "<span>";
                            if (blnApply == true) {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id,3);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3);'></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                            }
                            else {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;);></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                            }

                            strHTML += "</span>";

                            strHTML += "</div>";

                            strHTML += "</li>";

                        }

                        $("#MyFiltersdropdown").html(strHTML);
                        if (strHTML != "" && defaultFilterId != 0 && flag != 0 && flag != 3) {
                            ApplySavedFilter(defaultFilterId, 1);
                        }
                        //else {
                        //    GetBusinessGroups(null);
                        //}

                        $("#MyFiltersdropdown").removeClass("clsShowHide");
                    }
                    else {
                        $("#MyFiltersdropdown").addClass("clsShowHide");
                        $("#MyFiltersdropdown").removeClass("dropdown-menu");
                    }
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (xhr, errorThrown) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                //},
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                           // window.open("../../../Default.aspx", "_top");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        } else {
                           // window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                },
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
            clearTooltip();
        }

        function ExistInfraResFilter(filtername) {

            var isFilterExists = 0;
            var Parameters = {
                FilterName: encodeURI(filtername),
                TagID: encodeURI(TagID),
                ProjectID: 0,
                EmployeeID: encodeURI(SessionEmployeeId),
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/RM_MyFilter/ExistMyFilter',
                method: 'POST',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {

                    if (data == 0) {
                        isFilterExists = 0;
                    }
                    else if (data == 1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Filter already exit");
                        isFilterExists = 1;
                    }
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (xhr, errorThrown) {
                //    isFilterExists = 1;
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                //},
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                           // window.open("../../../Default.aspx", "_top");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        } else {
                           // window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
            return isFilterExists;
        }
        //Delete filter
        //Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on 6 July 2021
        // function DeleteFilter(FilterID, IsApplyed) {
        function DeleteFilter(FilterID, FilterName, IsApplyed) {
            //End of Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on on 6 July 2021
            $.ajax({
                url: strUrl + '/api/RM_MyFilter/DeleteMyFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {
                    if (result == null) {
                        alertify.set('notifier', 'position', 'top-right');
                        //Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on 6 July 2021
                        //alertify.success('Filter deleted successfully');
                        if (FilterName.indexOf("'") > -1) {
                            FilterName = FilterName.replace(/''/g, "'");
                        }
                        alertify.success("'" + FilterName + "'" + ' Filter deleted successfully');
                        //End of Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on 6 July 2021
                        if (IsApplyed == 3) {
                            var whereClause = "ProjectId = " + $('#CboIrProjectForList').val();
                            GetAllResourceRequests(whereClause);
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyInfraResFilter(0);
                        currentappliedfilter = 0;
                    }
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            //window.open("../../../Default.aspx", "_top");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        } else {
                            //window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
        }

        function EditFilter(FilterID) {
            savedFilterName = "";
            ClearFilterDetails("edit");
            $.ajax({
                url: strUrl + '/api/RM_MyFilter/EditMyFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {

                    for (var i = 0; i < result.length; i++) {
                        var ObjFilterDtls = result[i];

                        var currentFilterName = ObjFilterDtls.FilterName;
                        currentFilterID = ObjFilterDtls.FilterId;
                        $("#txtFilterName").val(currentFilterName);
                        savedFilterName = currentFilterName;
                        if (ObjFilterDtls.QueryText.toString().indexOf("AND") != -1) {

                            var arrFields = ObjFilterDtls.QueryText.split("AND");
                            try {
                                for (var i = 0; i < arrFields.length; i++) {
                                    setfiltervalues(arrFields[i]);
                                }
                            }
                            catch (ex) {
                                //alert(ex.message);
                            }
                        }
                        else {
                            var currWhereClause = ObjFilterDtls.QueryText.toString();
                            setfiltervalues(currWhereClause);
                        }//else                        
                    }
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                           // window.open("../../../Default.aspx", "_top");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        } else {
                           // window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
        }

        function ApplySavedFilter(FilterID, isDefault, isFromDefault) {
            //Changed  by imran by Filter Issue on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {
                var whereClause = "ProjectId = " + $('#CboIrProjectForList').val();
                GetAllResourceRequests(whereClause);
                GetMyInfraResFilter(isDefault);
                FilterNotApplied();
                ClearFilterDetails(""); // Added By Reshma Chavan on 31st Jan 2022 for clearing filter
                $('#AdvanceFilterIcon').attr("aria-expanded", false);
                //added by imran on 21 july 2021
                if ((isFromDefault === false || isFromDefault == 'false') && (isDefault == 3)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Filter removed successfully.");
                }
            }
            if (isDefault == undefined || isDefault == 2) {
                currentappliedfilter = FilterID;
                $.ajax({
                    url: strUrl + '/api/RM_MyFilter/GetMyWhereClauseOfFilter',
                    method: 'POST',
                    data: JSON.stringify(FilterID),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (FilterID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                        }
                    },
                    success: function (result) {
                        var Querytext = result;
                        if (Querytext != null) {
                            var arrayFilter = Querytext.split("AND");
                            if (arrayFilter.length > 0) {
                                var ProjectIndex = arrayFilter.length;
                                var ProjectID = arrayFilter[ProjectIndex - 1].split('=');
                                $('#CboIrProjectForList').val(parseInt(ProjectID[1]))
                            }
                            currentappliedfilterclause = Querytext;
                            GetInfraResDetails(Querytext);
                        }
                         //Added By Reshma Chavan on 31st Jan 2022 for NOT displalying data after apply filter
                        if (Querytext.toString().indexOf("AND") != -1) {
                            var arrFields = Querytext.split("AND");
                            try {
                                for (var i = 0; i < arrFields.length; i++) {
                                    setfiltervalues(arrFields[i]);
                                }
                            }
                            catch (ex) {
                                //alert(ex.message);
                            }
                        }
                        else {
                            var currWhereClause = Querytext.toString();
                            setfiltervalues(currWhereClause);
                        }                      
                        //End of Added By Reshma Chavan on 31st jan 2022 for NOT displalying data after apply filter
                        FilterApplied();
                        //GetBGDetails(Querytext);
                        // call business group getRiskDetails(currentselectedProjectID, 0, "", "defaultfilterapply", Querytext);
                        if (currentDefaultFilterID > 0) {
                            FilterApplied();
                        }
                        if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                            GetMyInfraResFilter(0);
                        }
                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                //window.open("../../../Default.aspx", "_top");
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            } else {
                                //window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire

                });
                if (isDefault == undefined) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Filter applied successfully.");
                }
            }
        }
        //To set the default filter.
        function SetDefaultFilter(FilterID, flag) {
            var removeDefault = 0;
            if (flag == "default") {
                removeDefault = 1;
            }
            var Parameters = {
                ProjectID: 0,
                LoginType: encodeURI(SessionLoginType),
                EmployeeID: encodeURI(SessionEmployeeId),
                TagID: encodeURI(TagID),
                FilterID: FilterID,
                Flag: removeDefault
            }

            $.ajax({
                url: strUrl + '/api/RM_MyFilter/SetMyDefaultFilter',
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (result) {
                    alertify.set('notifier', 'position', 'top-right');
                    //alert(removeDefault);
                    if (removeDefault == 0) {
                        //alertify.success('Success');
                        // ApplySavedFilter(FilterID, 2);
                        ApplySavedFilter(FilterID, 2, true);
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        //alertify.success('Default');
                        // FilterNotApplied();  
                        ApplySavedFilter(FilterID, 3, true);
                        alertify.success('Default Filter Is Successfully Removed!');
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        FilterNotApplied();
                    }
                    GetMyInfraResFilter(0);
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            //window.open("../../../Default.aspx", "_top");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        } else {
                           // window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
        }

        function GetInfraResDetails(whereClause) {
           
            var filter = "";
            if (whereClause != null) {
                //var whereClauseFormated = whereClause.replace(/'/g, "\''");
                var filter = whereClause.replace(/"/g, "\'");
                /*{ UniqueID: '0', WhereClause: encodeURIComponent(whereClause) };*/
            }
            GetAllResourceRequests(filter);
        }

        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtFilterName').val("");
            }
        }


        function ClearFilterDetails(flag) {
            if ($("#cboApprovalFilterApprovalDate").val() != "=") {
                setFilterComboValue("cboApprovalFilterApprovalDate", "=");
            }
            if ($("#txtApprovalFilterApprovalDate").val() != "") {
                $("#txtApprovalFilterApprovalDate").val("");
            }
            if ($("#cboApprovalFilterRequestedDate").val() != "=") {
                setFilterComboValue("cboApprovalFilterRequestedDate", "=");
            }
            if ($("#txtApprovalFilterRequestedDate").val() != "") {
                $("#txtApprovalFilterRequestedDate").val("");
            }
            if ($("#cboApprovalFilterStartDate").val() != "=") {
                setFilterComboValue("cboApprovalFilterStartDate", "=");
            }
            if ($("#txtApprovalFilterStartDate").val() != "") {
                $("#txtApprovalFilterStartDate").val("");
            }
            if ($("#cboApprovalFilterEndDate").val() != "=") {
                setFilterComboValue("cboApprovalFilterEndDate", "=");
            }
            if ($("#txtApprovalFilterEndDate").val() != "") {
                $("#txtApprovalFilterEndDate").val("");
            }
            if ($("#cboApprovalFilterQuantity").val() != "=") {
                setFilterComboValue("cboApprovalFilterQuantity", "=");
            }
            if ($("#txtApprovalFilterQuantity").val() != "") {
                $("#txtApprovalFilterQuantity").val("");
            }
            if ($("#cboApprovalFilterAllocated").val() != "=") {
                setFilterComboValue("cboApprovalFilterAllocated", "=");
            }
            if ($("#txtApprovalFilterAllocated").val() != "") {
                $("#txtApprovalFilterAllocated").val("");
            }
            if ($("#cboApprovalFilterStatus").val() != "=") {
                setFilterComboValue("cboApprovalFilterStatus", "=");
            }
            if ($("#txtApprovalFilterStatus").val() != "") {
                $("#txtApprovalFilterStatus").val("");
            }
            if ($("#cboApprovalFilterApprovalBy").val() != "Contains") {
                setFilterComboValue("cboApprovalFilterApprovalBy", "Contains");
            }
            if ($("#txtApprovalFilterApprovalBy").val() != "") {
                $("#txtApprovalFilterApprovalBy").val("");
            }

            if ($("#cboApprovalFilterInfraResourceId").val() != "=") {
                setFilterComboValue("cboApprovalFilterInfraResourceId", "=");
            }
            if ($("#txtApprovalFilterInfraResourceId").val() != "") {
                $("#txtApprovalFilterInfraResourceId").val("");
            }
            savedFilterName = "";
            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {

                    $(this).removeAttr("checked");
                });
            }

        }

        function OpenBasicFilter() {
            //Start Script for edit basic filter           
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
            //End Script for edit basic filter
        }
        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
        }
        function FilterApplied() {
            $(".mainclearalllink").removeClass("clsShowHide");
            $(".filter >  button").addClass("clsFilterHighlight");
        }
        function FilterNotApplied() {
            $(".mainclearalllink").addClass("clsShowHide");
            $(".filter >  button").removeClass("clsFilterHighlight");
            $('#AdvanceFilterIcon').attr("aria-expanded", false);
        }
        $(".mainclearalllink").click(function () {
            $(".filter").removeClass("active");
            //$('.filterpanel').collapse('toggle');                

            FilterNotApplied();
            $(".filter").removeClass("active");
            if ($('.filterpanel').hasClass("in")) {
                $('.filterpanel').removeClass("in");
            }
            $(".clsHideTooltip").each(function () {
                $(this).attr("data-bs-original-title", "Apply filter");
            });
            $('[data-bs-toggle="tooltip"]').tooltip();

            fltPersonResponsible = "";
            currentappliedfilter = 0;
            currentFilterID = 0;
            currentappliedfilterclause = "";
            ClearFilterDetails("");
            //changed by mahesh on 21 july 2021
            GetMyInfraResFilter(0);
            //End changed by mahesh on 21 july 2021
            var whereClause = "ProjectId = " + $('#CboIrProjectForList').val();
            GetInfraResDetails(whereClause);
        });

        function setfiltervalues(QueryText) {

            var currWhereClause = QueryText.toString().trim();

            currValue = currWhereClause.toString().trim();
            if (currValue.substring(currValue.length - 1) == ")") {
                currValue = currValue.substring(0, currValue.length - 1);
            }
            if (currValue.substring(0, 1) == "(") {
                currValue = currValue.substring(1);
            }
            currWhereClause = currValue;

            if (currWhereClause.indexOf("NOT LIKE") != -1) {
                currWhereClause = currWhereClause.replace("NOT LIKE", "notlike");
            }

            var str = currWhereClause;

            var regex = /'[^"]+'|[^\s]+/g;
            result = str.match(regex);

            var str = result.toString();
            var arr = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);
            //var arr = str.match(/(\([^\)]+\)|\S+|\s+)/);
            //var arr = str.match(/('.*?'|[^',\s]+[^(.*?),\s]+)(?=\s*,|\s*$)/g);
            for (var i = 0; i < arr.length; i++) {
                //alert(arr[i]);
            }

            var arrFields = currWhereClause.split(" ");
            arrFields = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);
            if (arrFields[0] == "ApprovalDate") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboApprovalFilterApprovalDate", "txtApprovalFilterApprovalDate");
            }
            if (arrFields[0] == "RequestedDate") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboApprovalFilterRequestedDate", "txtApprovalFilterRequestedDate");
            }
            if (arrFields[0] == "StartDate") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboApprovalFilterStartDate", "txtApprovalFilterStartDate");
            }
            if (arrFields[0] == "EndDate") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboApprovalFilterEndDate", "txtApprovalFilterEndDate");
            }
            if (arrFields[0] == "Quantity") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboApprovalFilterQuantity", "txtApprovalFilterQuantity");
            }
            if (arrFields[0] == "Allocated") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "txtApprovalFilterAllocated", "txtApprovalFilterAllocated");
            }
            if (arrFields[0] == "ApprovalBy") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboApprovalFilterApprovalBy", "txtApprovalFilterApprovalBy");
            }
            if (arrFields[0] == "Status") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboApprovalFilterStatus", "txtApprovalFilterStatus");
            }

            if (arrFields[0] == "InfraResourceId") {
                var currOpToolCategory = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                setFilterComboValue("cboApprovalFilterInfraResourceId", currOpToolCategory);
                setFilterComboValue("txtApprovalFilterInfraResourceId", currValue);
            }

        }
        function setFilterComboValue(fieldName, fieldValue, flag) {
            $("#" + fieldName).val(fieldValue);
        }
        function setFilterOpComboFieldValue(currWhereClause, arrFields, OpComboName, ValueComboName) {
            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") != -1 && currWhereClause.indexOf("'%") != -1) {
                setFilterComboValue(OpComboName, "Contains");

            }
            if (arrFields[1] == "notlike") {
                setFilterComboValue(OpComboName, "Not Contains");
            }

            if (arrFields[1] == "=") {
                setFilterComboValue(OpComboName, "=");
            }
            if (arrFields[1] == "<>") {
                setFilterComboValue(OpComboName, "<>");
            }
            if (arrFields[1] == "<=") {
                setFilterComboValue(OpComboName, "<=");
            }
            if (arrFields[1] == "<") {
                setFilterComboValue(OpComboName, "<");
            }
            if (arrFields[1] == ">") {
                setFilterComboValue(OpComboName, ">");
            }
            if (arrFields[1] == ">=") {
                setFilterComboValue(OpComboName, ">=");
            }
            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") != -1 && currWhereClause.indexOf("'%") == -1) {
                setFilterComboValue(OpComboName, "Starts With");
            }

            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") == -1 && currWhereClause.indexOf("'%") != -1) {
                setFilterComboValue(OpComboName, "Ends With");
            }

            var currValue = arrFields[2].replace("'%", "");
            currValue = currValue.replace("%'", "");
            currValue = currValue.toString().trim();
            if (currValue.substring(currValue.length - 1) == "'") {
                currValue = currValue.substring(0, currValue.length - 1);
            }
            if (currValue.substring(0, 1) == "'") {
                currValue = currValue.substring(1);
            }


            //Commented & added by mahesh on  27 july 2021
            //$("#" + ValueComboName).val(currValue);
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }

        $(function ($) {
            var items = $("#infrarequestTbl tbody tr.pgrow");

            var numItems = items.length;
            var perPage = 8;

            // Only show the first 2 (or first `per_page`) items initially.
            items.slice(perPage).hide();

            // Now setup the pagination using the `#pagination` div.
            $("#pagination").pagination({
                items: numItems,
                itemsOnPage: perPage,
                cssStyle: "light-theme",

                // This is the actual page changing functionality.
                onPageClick: function (pageNumber) {
                    // We need to show and hide `tr`s appropriately.
                    var showFrom = perPage * (pageNumber - 1);
                    var showTo = showFrom + perPage;

                    // We'll first hide everything...
                    items.hide()
                        // ... and then only show the appropriate rows.
                        .slice(showFrom, showTo).show();
                }
            });
        });



        function editIM(requestId, openStatus, IsInfraApprover) {
            // if (IsInfraApprover == true) {
            if (openStatus == 'Cancelled' || openStatus == 'Closed') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Request is already " + openStatus + ".");

            }
            else {
                //$(".dataTables_scrollBody").css("height", "auto!important");
                $(".Resourcedetailpanel").show();
                $('html,body').animate({
                    scrollTop: $(".Resourcedetailpanel").offset().top - 60
                }, 'slow');
                //used for disable grid
                $("#MInfraListTbl_wrapper .dataTables_scrollBody, .srchrequest, .weekly_calender, .backbtn, .addbtn, .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");

                $(".table").resize();

                GetRequestById(requestId);
            }

            $(".BGdetalilink").click(function () {
                $(this).closest('tr').addClass('rowhiglight');
            });
            //}
            //else {
            //    alert("Plz mark as resource allocator and manager");
            //}
        }



        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#MInfraListTbl_wrapper .dataTables_scrollBody, .srchrequest, .weekly_calender, .backbtn, .addbtn, .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();
        });




        function resizeSection() {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 280, "overflow-y": "auto" });

            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });

            //Added by praidp on 11-3-2022 
             var Gridtblheight = $(window).height(); 
            $('#thirdcontainer').css({ 'height': Gridtblheight - 155,  "overflow-y": "auto" }); //End Added by praidp on 11-3-2022 

            

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

        //colappse row
        $(".UpDowncollapseArrow").click(function () {
            // alert(1);
            $(this).toggleClass("in");

        });
        //Datefield
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

        //datepicker
        $('#txtApprovalFilterApprovalDate, #txtApprovalFilterRequestedDate, #txtApprovalFilterStartDate, #txtApprovalFilterEndDate, #IRRFltrApprovalDate, #IRRDetailReqDate, #IRRDetailFromDate, #IRRDetailToDate, #IRRDetailAllocatedDate, #IRRDtailApprvlDate').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd M yy'
        });


        function bookResource() {
            if ($("#IRRDetailAllocatedQuantity").val() == "" || $("#IRRDetailAllocatedQuantity").val() == null || $("#IRRDetailAllocatedQuantity").val() == "undefined") {
                $('#IRRDetailAllocatedQuantity').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Allocated Quantity' sholuld not left blank.");
                return false;
            }
            //Added By Reshma Chavan on 14th Oct 2021 for Allocated Quantity Greater than 0
            else if (parseInt($("#IRRDetailAllocatedQuantity").val()) <= 0) {
                $('#IRRDetailAllocatedQuantity').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Allocated Quantity' sholuld be greater than 0.");
                return false;
            }
            else if (parseInt($("#IRRDetailAllocatedQuantity").val()) > parseInt($("#IRRDetailRequiredQuantity").val())) {
                $('#IRRDetailAllocatedQuantity').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Allocated Quantity' sholuld not be greater than 'Required Quantity'.");
                return false;
            }
            //else if (($("#IRRDetailApprovalStatus").val() == "Ready For Assignment" || $("#IRRDetailApprovalStatus").val() == "Closed" || $("#IRRDetailApprovalStatus").val() == "Cancelled") && (UserRoleLevel == 1 || UserRoleLevel==2)) {
            //    console.log("ra");
            //     alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("You are not allowded to save request.");
            //     return false;
            //}

            // else if (($("#IRRDetailApprovalStatus").val() == "Pending For Approval" || ($("#IRRDetailApprovalStatus").val() == "Ready For Assignment" || $("#IRRDetailApprovalStatus").val() == "Closed" || $("#IRRDetailApprovalStatus").val() == "Cancelled") && (UserRoleLevel == 2) && (RoleDes.trim()  == "PROJECT MANAGER" || RoleDes.trim()  == "Project Manager"))) {
            //Commented & Added By Rutuja D. on 2 Feb 2022 For not allow to Infra Approver
            //else if (($("#IRRDetailApprovalStatus").val() == "Pending For Approval" || $("#IRRDetailApprovalStatus").val() == "Ready For Assignment" || $("#IRRDetailApprovalStatus").val() == "Closed" || $("#IRRDetailApprovalStatus").val() == "Cancelled") && (UserRoleLevel == 2) && (RoleDes.trim() == "PROJECT MANAGER" || RoleDes.trim() == "Project Manager")) {
            else if (IsApproverManager == 0) {
            //End of Commented & Added By Rutuja D. on 2 Feb 2022 For not allow to Infra Approver
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("You are not allowded to save request.");
                return false;
            }
            //else if (($("#IRRDetailApprovalStatus").val() == "Pending For Approval" || $("#IRRDetailApprovalStatus").val() == "Closed" || $("#IRRDetailApprovalStatus").val() == "Cancelled") && (UserRoleLevel == 1) && (RoleDes.trim() == "PROJECT MANAGER" || RoleDes.trim() == "Project Manager")) {
            else if (IsApproverManager == 0) {
                //console.log("PM");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("You are not allowded to save request.");
                return false;
            }
            //else if (($("#IRRDetailApprovalStatus").val() == "Pending For Approval") && (UserRoleLevel == 3) && (RoleDes.trim() == "PROJECT MANAGER" || RoleDes.trim() == "Project Manager")) {
            else if (IsApproverManager == 0) {
            //  console.log("PM");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("You are not allowded to save request.");
                return false;
            }
            else if (($("#IRRDetailApprovalStatus").val() == "Ready For Assignment" || $("#IRRDetailApprovalStatus").val() == "Closed" || $("#IRRDetailApprovalStatus").val() == "Cancelled") && (UserRoleLevel == 1) && (RoleDes == "RESOURCE MANAGER" || RoleDes == "Resource Manager" || RoleDes == "APPLICATION ADMINISTRATOR" || RoleDes == "Application Administrator")) {
                // console.log("RMA");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("You are not allowded to save request.");
                return false;
            }
            else {
                var bookResourceParmas = {
                    InfraRequestId: $("#IRRdetailReqID").val(),
                    // RequestedDate:$("#IRRDetailReqDate").val(),
                    //  StartDate:  $("#IRRDetailFromDate").val(),
                    // EndDate: $("#IRRDetailToDate").val(),
                    Quantity: $("#IRRDetailRequiredQuantity").val(),
                    AllocatedQuantity: $("#IRRDetailAllocatedQuantity").val(),
                    // Status: $("#IRRDetailApprovalStatus").val(),
                    Comments: $("#IRRDetailApprovalComments").val(),
                    ModifiedBy: UserName,
                    // RequestedBy: UserName,
                    //RequestedUserId: SessionEmployeeId,
                    Approvalby: $("#IRRDetailApprovalBy").val(),
                    //ApprovalDate: $("#IRRDtailApprvlDate").val(),
                    //AllocatedDate: $("#IRRDetailAllocatedDate").val(),
                    AlloctedBy: $("#IRRDetailAllocatedBy").val(),
                    IsUpdate: "Update"
                }
                // console.log('bookResource');
                //  console.log(bookResourceParmas);
                $.ajax({
                    url: strUrl + '/api/RM_ProjectInfraResources/AddOrUpdateInfraRequest',
                    type: "POST",
                    data: JSON.stringify(bookResourceParmas),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (bookResourceParmas) {
                            xhr.setRequestHeader("Params", encryptString(isJson(bookResourceParmas) ? bookResourceParmas : JSON.stringify(bookResourceParmas)));
                        }
                    },
                    success: function (data) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(data);                      
                        $('#IRRmodal').modal('hide');
                        //window.open('../Email/SendEmail.aspx?MessageID=20051&RequestId=' + 1 + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (xhr, ajaxOptions, thrownError) {
                    //    if (ajaxOptions == "error") {
                    //        console.log(thrownError);
                    //        alertify.set('notifier', 'position', 'top-right');
                    //        alertify.notify(xhr.responseJSON.Message);
                    //    }
                    //    else if (xhr.statusText == "Created") {
                    //        //ShowBGManager();
                    //    }
                    //    else {
                    //        alertify.set('notifier', 'position', 'top-right');
                    //        alertify.error(thrownError);

                    //    }
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                //window.open("../../../Default.aspx", "_top");
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            } else {
                               
                              //  window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire

                })
            }

        }
        //jquery for weekly and daily view calendar
        $(".tab-slider--nav li").click(function () {

            if ($("#Dailytab").is(":visible")) {
                $("#dailyviewcal").hide();
                $("#weeklyviewcal").show();
            } else {
                $("#weeklyviewcal").hide();
                $("#dailyviewcal").show();
            }

        });

        //weeekly and daily tab

        $(".tab-slider--body").hide();
        $(".tab-slider--body:first").show();
        //$("#dailyviewcal").show();



        $(".tab-slider--nav li").click(function () {
            $(".tab-slider--body").hide();
            var activeTab = $(this).attr("rel");
            $("#" + activeTab).fadeIn();
            if ($(this).attr("rel") == "Dailytab") {
                $('.tab-slider--tabs').addClass('slide');
            } else {
                $('.tab-slider--tabs').removeClass('slide');
            }
            $(".tab-slider--nav li").removeClass("active");
            $(this).addClass("active");
        });

        function GetAllResourceRequests(whereClause) {
          
            if (whereClause == '' || whereClause == "" || whereClause == "undefined") {
                whereClause = "";
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Project.");
                return false;
            }

            else {
                var infraFilterParameter = {
                    WhereClause: whereClause,
                    RoleID: RoleID,
                    LoginUserID: SessionEmployeeId
                }
                var strHTML = "";
                StartLoader("#bodyRequest-Approval");
                $.ajax({
                    url: strUrl + '/api/RM_InfraRequests/GetAll',
                    type: "POST",
                    data: JSON.stringify(infraFilterParameter),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (infraFilterParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(infraFilterParameter) ? infraFilterParameter : JSON.stringify(infraFilterParameter)));
                        }
                    },
                    success: function (data) {

                        var InfraResourceRequestList = data;

                        strHTML = '  <thead> ';
                        strHTML += '  <tr>';
                        strHTML += '  <th>Request Id</th>';
                        strHTML += '  <th width="240" class="text-start">Infrastructure Resource</th>';
                        strHTML += '  <th>Project Name</th>';
                        strHTML += '  <th colspan="2">No. of Resource</th>';
                        strHTML += '  <th>Requested Date</th>';
                        strHTML += '  <th>From Date</th>';
                        strHTML += '  <th>To Date</th>';
                        strHTML += '  <th>Available Licenses</th>';
                        strHTML += '  <th style="min-width:173px">Status</th>';
                        strHTML += '  <th>Action</th>';
                        strHTML += '    </tr>';
                        strHTML += '    <tr>';
                        strHTML += '     <th></th>';
                        strHTML += '     <th class="text-start"></th>';
                        strHTML += '        <th>&nbsp;</th>';
                        strHTML += '        <th>Requested</th>';
                        strHTML += '        <th>Allocated</th>';
                        strHTML += '        <th></th>';
                        strHTML += '        <th></th>';
                        strHTML += '        <th></th>';
                        strHTML += '        <th></th>';
                        strHTML += '        <th></th>';
                        strHTML += '        <th></th>';
                        strHTML += '    </tr>';
                        strHTML += '</thead>';
                        strHTML += '<tbody class="pginatebody">';


                        if (InfraResourceRequestList.length > 0) {
                            $.each(InfraResourceRequestList, function (index, obj) {
                                index = index + 1;

                                if (blnEditAccess == "True") {
                                    if (obj.Status == 'Rejected' || obj.Status == 'Cancelled') {
                                        strHTML += "<tr class='pgrow'><td><a class='RreqID' onclick='RREdit()'><span data-bs-toggle='tooltip' title='' class='idlabel' data-bs-original-title='Click here to detail view'>" + obj.RequestId + "</span></a></td>" +
                                            "<td class='text-start ClassRresourcename'>" + obj.InfraName +
                                            "<a  class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' onclick=\"(GetSmiliarRequests(" + obj.RequestId + "," + index + "))\" data-bs-target='.PRhiderow" + index + "' data-bs-original-title='' title=''>" +
                                            "<img  class='uparrow' data-bs-toggle='tooltip'  data-bs-placement='top'  title='' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' data-bs-original-title='Hide Resource Detail'>" +
                                            "<img  class='downarrow' data-bs-toggle='tooltip'  data-bs-placement='top'   title='' src='../../../Whizible2.0-new/dist/img/down.svg' alt='' width='15px' data-bs-original-title='Show Resource Detail'>" +
                                            "</a></td>" +
                                            "<td>" + obj.ProjectName + "</td><td>" + obj.Requested + "</td> <td>" + obj.Allocated + "</td><td>" + convert(obj.RequestedDate) + "</td><td>" + convert(obj.FromDate) + "</td><td>" + convert(obj.ToDate) + "</td><td>" + obj.AvailableLicenses + "</td>" +
                                            "<td><label class='btn btn-red btn-xs RRstatusbtn' autocomplete='off'>" + obj.Status + "</label></td>" +
                                            //Added By Dipali V On 7th Feb 2022 For If disabled then Blocker should come
                                            // "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'  Style='color:grey;'><input type='checkbox'  id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>" +
                                            "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'  Style='color:grey;'><input type='checkbox' disabled  id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "' style='cursor:not-allowed'></label></div>" +
                                            //End of Added By Dipali V On 7th Feb 2022 For If disabled then Blocker should come
                                            "<a id='' disabled style='cursor:not-allowed' class='' href='javascript:;' title=''><img src='../../../Whizible2.0-new/dist/img/edit.svg' width='16px' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-bs-original-title='Edit'></a> </td></tr>";

                                    }
                                    else if (obj.Status == 'Closed') {
                                        strHTML += "<tr class='pgrow'><td><a class='RreqID' onclick='RREdit()'><span data-bs-toggle='tooltip' title='' class='idlabel' data-bs-original-title='Click here to detail view'>" + obj.RequestId + "</span></a></td>" +
                                            "<td class='text-start ClassRresourcename'>" + obj.InfraName +
                                            "<a  class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' onclick=\"(GetSmiliarRequests(" + obj.RequestId + "," + index + "))\" data-bs-target='.PRhiderow" + index + "' data-bs-original-title='' title=''>" +
                                            "<img  class='uparrow' data-bs-toggle='tooltip'  data-bs-placement='top'  title='' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' data-bs-original-title='Hide Resource Detail'>" +
                                            "<img  class='downarrow' data-bs-toggle='tooltip'  data-bs-placement='top'   title='' src='../../../Whizible2.0-new/dist/img/down.svg' alt='' width='15px' data-bs-original-title='Show Resource Detail'>" +
                                            "</a></td>" +
                                            "<td>" + obj.ProjectName + "</td><td>" + obj.Requested + "</td> <td>" + obj.Allocated + "</td><td>" + convert(obj.RequestedDate) + "</td><td>" + convert(obj.FromDate) + "</td><td>" + convert(obj.ToDate) + "</td><td>" + obj.AvailableLicenses + "</td>" +
                                            "<td><label class='btn btn-success btn-xs RRstatusbtn' autocomplete='off'>" + obj.Status + "</label></td>" +
                                            //"<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox' Style='pointer-events: none;color:grey;'><input type='checkbox' id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>" +
                                            //Added By Dipali V On 7th Feb 2022 For If disabled then Blocker should come
                                            // "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox' Style='pointer-events: none;color:grey;'><input type='checkbox' id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>" +
                                            "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'  Style='color:grey;'><input type='checkbox' disabled  id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "' style='cursor:not-allowed'></label></div>" +
                                            //End of Added By Dipali V On 7th Feb 2022 For If disabled then Blocker should come
                                            
                                            "<a id='' disabled style='cursor:not-allowed' class='' href='javascript:;' title=''><img src='../../../Whizible2.0-new/dist/img/edit.svg' width='16px' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-bs-original-title='Edit'></a> </td></tr>";

                                    }
                                    else if (obj.Status == 'Ready For Assignment') {
                                        strHTML += "<tr class='pgrow'><td><a class='RreqID' onclick='RREdit()'><span data-bs-toggle='tooltip' title='' class='idlabel' data-bs-original-title='Click here to detail view'>" + obj.RequestId + "</span></a></td>" +
                                            "<td class='text-start ClassRresourcename'>" + obj.InfraName +
                                            "<a  class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' onclick=\"(GetSmiliarRequests(" + obj.RequestId + "," + index + "))\" data-bs-target='.PRhiderow" + index + "' data-bs-original-title='' title=''>" +
                                            "<img  class='uparrow' data-bs-toggle='tooltip'  data-bs-placement='top'  title='' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' data-bs-original-title='Hide Resource Detail'>" +
                                            "<img  class='downarrow' data-bs-toggle='tooltip'  data-bs-placement='top'   title='' src='../../../Whizible2.0-new/dist/img/down.svg' alt='' width='15px' data-bs-original-title='Show Resource Detail'>" +
                                            "</a></td>" +
                                            "<td>" + obj.ProjectName + "</td><td>" + obj.Requested + "</td> <td>" + obj.Allocated + "</td><td>" + convert(obj.RequestedDate) + "</td><td>" + convert(obj.FromDate) + "</td><td>" + convert(obj.ToDate) + "</td><td>" + obj.AvailableLicenses + "</td>" +
                                            "<td><label class='btn btn-success btn-xs RRstatusbtn' autocomplete='off'>" + obj.Status + "</label></td>"
                                        //"<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'><input type='checkbox' id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>" +
                                        if (obj.IsApproverManager == true || obj.IsApproverManager == 1) {
                                            strHTML += "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'><input type='checkbox' id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>"
                                        } else {
                                            strHTML += "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'  Style='color:grey;'><input type='checkbox' disabled id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "' style='cursor:not-allowed'></label></div>"
                                        }
                                        strHTML += "<a id='' class='' href='javascript:;' title='' onclick=\"(editIM(" + obj.RequestId + ",'" + obj.Status + "'))\"><img src='../../../Whizible2.0-new/dist/img/edit.svg' width='16px' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-bs-original-title='Edit'></a> </td></tr>";

                                    }
                                    else {
                                        strHTML += "<tr class='pgrow'><td><a class='RreqID' onclick='RREdit()'><span data-bs-toggle='tooltip' title='' class='idlabel' data-bs-original-title='Click here to detail view'>" + obj.RequestId + "</span></a></td>" +
                                            "<td class='text-start ClassRresourcename'>" + obj.InfraName +
                                            "<a  class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' onclick=\"(GetSmiliarRequests(" + obj.RequestId + "," + index + "))\" data-bs-target='.PRhiderow" + index + "' data-bs-original-title='' title=''>" +
                                            "<img  class='uparrow' data-bs-toggle='tooltip'  data-bs-placement='top'  title='' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' data-bs-original-title='Hide Resource Detail'>" +
                                            "<img  class='downarrow' data-bs-toggle='tooltip'  data-bs-placement='top'   title='' src='../../../Whizible2.0-new/dist/img/down.svg' alt='' width='15px' data-bs-original-title='Show Resource Detail'>" +
                                            "</a></td>" +
                                            "<td>" + obj.ProjectName + "</td><td>" + obj.Requested + "</td> <td>" + obj.Allocated + "</td><td>" + convert(obj.RequestedDate) + "</td><td>" + convert(obj.FromDate) + "</td><td>" + convert(obj.ToDate) + "</td><td>" + obj.AvailableLicenses + "</td>" +
                                            "<td><label class='btn btn-primary btn-xs RRstatusbtn' autocomplete='off'>" + obj.Status + "</label></td>"
                                        //"<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'><input type='checkbox' id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>" +
                                        if (obj.IsApproverManager == true || obj.IsApproverManager == 1) {
                                            strHTML += "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'><input type='checkbox' id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>"
                                        }
                                        else {
                                            strHTML += "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'  Style='color:grey;'><input type='checkbox' disabled id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "' style='cursor:not-allowed'></label></div>"
                                        }
                                        strHTML += "<a id='' class='' href='javascript:;' title='' onclick=\"(editIM(" + obj.RequestId + ",'" + obj.Status + "'))\"><img src='../../../Whizible2.0-new/dist/img/edit.svg' width='16px' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-bs-original-title='Edit'></a> </td></tr>";

                                    }
                                }
                                else {
                                    if (obj.Status == 'Rejected' || obj.Status == 'Cancelled') {
                                        strHTML += "<tr class='pgrow'><td><a class='RreqID' onclick='RREdit()'><span data-bs-toggle='tooltip' title='' class='idlabel' data-bs-original-title='Click here to detail view'>" + obj.RequestId + "</span></a></td>" +
                                            "<td class='text-start ClassRresourcename'>" + obj.InfraName +
                                            "<a  class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' onclick=\"(GetSmiliarRequests(" + obj.RequestId + "," + index + "))\" data-bs-target='.PRhiderow" + index + "' data-bs-original-title='' title=''>" +
                                            "<img  class='uparrow' data-bs-toggle='tooltip'  data-bs-placement='top'  title='' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' data-bs-original-title='Hide Resource Detail'>" +
                                            "<img  class='downarrow' data-bs-toggle='tooltip'  data-bs-placement='top'   title='' src='../../../Whizible2.0-new/dist/img/down.svg' alt='' width='15px' data-bs-original-title='Show Resource Detail'>" +
                                            "</a></td>" +
                                            "<td>" + obj.ProjectName + "</td><td>" + obj.Requested + "</td> <td>" + obj.Allocated + "</td><td>" + convert(obj.RequestedDate) + "</td><td>" + convert(obj.FromDate) + "</td><td>" + convert(obj.ToDate) + "</td><td>" + obj.AvailableLicenses + "</td>" +
                                            "<td><label class='btn btn-red btn-xs RRstatusbtn' autocomplete='off'>" + obj.Status + "</label></td>" +
                                            //"<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox' Style='pointer-events: none;color:grey;'><input type='checkbox'  id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>" +
                                            "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox' Style='color:grey;'><input type='checkbox'  id='IRRListCheck1_" + index + "' disabled onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "' style='cursor:not-allowed'></label></div>" +
                                            "</td></tr>";

                                    }
                                    else if (obj.Status == 'Closed') {
                                        strHTML += "<tr class='pgrow'><td><a class='RreqID' onclick='RREdit()'><span data-bs-toggle='tooltip' title='' class='idlabel' data-bs-original-title='Click here to detail view'>" + obj.RequestId + "</span></a></td>" +
                                            "<td class='text-start ClassRresourcename'>" + obj.InfraName +
                                            "<a  class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' onclick=\"(GetSmiliarRequests(" + obj.RequestId + "," + index + "))\" data-bs-target='.PRhiderow" + index + "' data-bs-original-title='' title=''>" +
                                            "<img  class='uparrow' data-bs-toggle='tooltip'  data-bs-placement='top'  title='' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' data-bs-original-title='Hide Resource Detail'>" +
                                            "<img  class='downarrow' data-bs-toggle='tooltip'  data-bs-placement='top'   title='' src='../../../Whizible2.0-new/dist/img/down.svg' alt='' width='15px' data-bs-original-title='Show Resource Detail'>" +
                                            "</a></td>" +
                                            "<td>" + obj.ProjectName + "</td><td>" + obj.Requested + "</td> <td>" + obj.Allocated + "</td><td>" + convert(obj.RequestedDate) + "</td><td>" + convert(obj.FromDate) + "</td><td>" + convert(obj.ToDate) + "</td><td>" + obj.AvailableLicenses + "</td>" +
                                            "<td><label class='btn btn-success btn-xs RRstatusbtn' autocomplete='off'>" + obj.Status + "</label></td>" +
                                           // "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox' Style='pointer-events: none;color:grey;'><input type='checkbox' id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>" +
                                            "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox' Style='color:grey;'><input type='checkbox' disabled id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "' style='cursor: not-allowed'></label></div>" +
                                            "</td></tr>";

                                    }
                                    else if (obj.Status == 'Ready For Assignment') {
                                        strHTML += "<tr class='pgrow'><td><a class='RreqID' onclick='RREdit()'><span data-bs-toggle='tooltip' title='' class='idlabel' data-bs-original-title='Click here to detail view'>" + obj.RequestId + "</span></a></td>" +
                                            "<td class='text-start ClassRresourcename'>" + obj.InfraName +
                                            "<a  class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' onclick=\"(GetSmiliarRequests(" + obj.RequestId + "," + index + "))\" data-bs-target='.PRhiderow" + index + "' data-bs-original-title='' title=''>" +
                                            "<img  class='uparrow' data-bs-toggle='tooltip'  data-bs-placement='top'  title='' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' data-bs-original-title='Hide Resource Detail'>" +
                                            "<img  class='downarrow' data-bs-toggle='tooltip'  data-bs-placement='top'   title='' src='../../../Whizible2.0-new/dist/img/down.svg' alt='' width='15px' data-bs-original-title='Show Resource Detail'>" +
                                            "</a></td>" +
                                            "<td>" + obj.ProjectName + "</td><td>" + obj.Requested + "</td> <td>" + obj.Allocated + "</td><td>" + convert(obj.RequestedDate) + "</td><td>" + convert(obj.FromDate) + "</td><td>" + convert(obj.ToDate) + "</td><td>" + obj.AvailableLicenses + "</td>" +
                                            "<td><label class='btn btn-success btn-xs RRstatusbtn' autocomplete='off'>" + obj.Status + "</label></td>"
                                        //"<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'><input type='checkbox' id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>" +
                                        if (obj.IsApproverManager == true || obj.IsApproverManager == 1) {
                                            strHTML += "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'><input type='checkbox' id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>"
                                        }
                                        else {
                                            strHTML += "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'  Style='color:grey;'><input type='checkbox' disabled id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "' style='cursor:not-allowed'></label></div>"
                                        }
                                        strHTML += "</td></tr>";

                                    }
                                    else {
                                        strHTML += "<tr class='pgrow'><td><a class='RreqID' onclick='RREdit()'><span data-bs-toggle='tooltip' title='' class='idlabel' data-bs-original-title='Click here to detail view'>" + obj.RequestId + "</span></a></td>" +
                                            "<td class='text-start ClassRresourcename'>" + obj.InfraName +
                                            "<a  class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' onclick=\"(GetSmiliarRequests(" + obj.RequestId + "," + index + "))\" data-bs-target='.PRhiderow" + index + "' data-bs-original-title='' title=''>" +
                                            "<img  class='uparrow' data-bs-toggle='tooltip'  data-bs-placement='top'  title='' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' data-bs-original-title='Hide Resource Detail'>" +
                                            "<img  class='downarrow' data-bs-toggle='tooltip'  data-bs-placement='top'   title='' src='../../../Whizible2.0-new/dist/img/down.svg' alt='' width='15px' data-bs-original-title='Show Resource Detail'>" +
                                            "</a></td>" +
                                            "<td>" + obj.ProjectName + "</td><td>" + obj.Requested + "</td> <td>" + obj.Allocated + "</td><td>" + convert(obj.RequestedDate) + "</td><td>" + convert(obj.FromDate) + "</td><td>" + convert(obj.ToDate) + "</td><td>" + obj.AvailableLicenses + "</td>" +
                                            "<td><label class='btn btn-primary btn-xs RRstatusbtn' autocomplete='off'>" + obj.Status + "</label></td>"
                                        //"<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'><input type='checkbox' id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>" +
                                        if (obj.IsApproverManager == true || obj.IsApproverManager == 1) {
                                            strHTML += "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'><input type='checkbox' id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "'></label></div>"
                                        }
                                        else {
                                            strHTML += "<td class='actioncolumn'><input type='hidden' name='hdn_RequestID' id='hdn_RequestID' value= " + obj.RequestId + "><div class='roundedCheckbox'  Style='color:grey;'><input type='checkbox' disabled id='IRRListCheck1_" + index + "' onclick=\"(GetSelectedForApprove(this))\"/><label for='IRRListCheck1_" + index + "' style='cursor:not-allowed'></label></div>"
                                        }
                                        strHTML += "</td></tr>";

                                    }
                                }
                                strHTML += "<tr class='PRhiderow" + index + " collapse'>";
                                strHTML += "<td colspan='11'>";
                                if (obj.IsApproverManager == false || obj.IsApproverManager == 0) {
                                    strHTML += "   <div class='pt-1 pb-1 text-end'>";
                                    strHTML += "        <a href='javascript:;' Style='pointer-events: none;' data-bs-toggle='modal' data-bs-target='#InfraCRmodal' class='disabled btn borderbtn ml-1' onclick=\"(OpenCancelPopUp(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Cancel Request</a>";
                                    //strHTML += "        <a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn' onclick=\"(ApproveRejectRequest(" + obj.RequestId + ",'" + obj.Status + "',1,'" + obj.Requested + "'))\"' >Approve</a><a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn'onclick=\"(ApproveRejectRequest(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Reject</a>";
                                    strHTML += "        <a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn' onclick=\"(CollapseApproveRejectPopup(" + obj.RequestId + ",'" + obj.Status + "',1,'" + obj.Allocated + "'))\"' >Approve</a><a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn'onclick=\"(CollapseApproveRejectPopup(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Reject</a>";
                                    strHTML += "    </div>";
                                }
                                //if ((obj.Status == 'Rejected' || obj.Status == 'Cancelled' || obj.Status == 'Closed') && (obj.RoleName == "Resource Manager" || obj.RoleName == "RESOURCE MANAGER")) {
                                else if ((obj.Status == 'Rejected' || obj.Status == 'Cancelled' || obj.Status == 'Closed') && (obj.IsApproverManager == false || obj.IsApproverManager == 0)) {
                                    strHTML += "   <div class='pt-1 pb-1 text-end'>";
                                    strHTML += "        <a href='javascript:;' Style='pointer-events: none;' data-bs-toggle='modal' data-bs-target='#InfraCRmodal' class='disabled btn borderbtn ml-1' onclick=\"(OpenCancelPopUp(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Cancel Request</a>";
                                    //strHTML += "        <a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn' onclick=\"(ApproveRejectRequest(" + obj.RequestId + ",'" + obj.Status + "',1,'" + obj.Requested + "'))\"' >Approve</a><a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn'onclick=\"(ApproveRejectRequest(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Reject</a>";
                                    strHTML += "        <a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn' onclick=\"(CollapseApproveRejectPopup(" + obj.RequestId + ",'" + obj.Status + "',1,'" + obj.Requested + "'))\"' >Approve</a><a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn'onclick=\"(CollapseApproveRejectPopup(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Reject</a>";
                                    strHTML += "    </div>";
                                }
                                //else if ((obj.Status == 'Rejected') && (obj.RoleName == "Project Manager" || obj.RoleName == "PROJECT MANAGER")) {
                                else if ((obj.Status == 'Rejected') && (obj.IsApproverManager == false || obj.IsApproverManager == 0)) {

                                    strHTML += "   <div class='pt-1 pb-1 text-end'>";
                                    strHTML += "        <a href='javascript:;' data-bs-toggle='modal' data-bs-target='#InfraCRmodal' class='btn borderbtn ml-1' onclick=\"(OpenCancelPopUp(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Cancel Request</a>";
                                    //strHTML += "        <a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn' onclick=\"(ApproveRejectRequest(" + obj.RequestId + ",'" + obj.Status + "',1,'" + obj.Requested + "'))\"' >Approve</a><a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn'onclick=\"(ApproveRejectRequest(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Reject</a>";
                                    strHTML += "        <a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn' onclick=\"(CollapseApproveRejectPopup(" + obj.RequestId + ",'" + obj.Status + "',1,'" + obj.Requested + "'))\"' >Approve</a><a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn'onclick=\"(CollapseApproveRejectPopup(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Reject</a>";
                                    strHTML += "    </div>";
                                }
                                //else if ((obj.Status == 'Pending For Approval') && (obj.RoleName == "Project Manager" || obj.RoleName == "PROJECT MANAGER")) {
                                else if ((obj.Status == 'Pending For Approval') && (obj.IsApproverManager == false || obj.IsApproverManager == 0)) {

                                    strHTML += "   <div class='pt-1 pb-1 text-end'>";
                                    strHTML += "        <a href='javascript:;' data-bs-toggle='modal' data-bs-target='#InfraCRmodal' class='btn borderbtn ml-1' onclick=\"(OpenCancelPopUp(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Cancel Request</a>";
                                    //strHTML += "        <a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn' onclick=\"(ApproveRejectRequest(" + obj.RequestId + ",'" + obj.Status + "',1,'" + obj.Requested + "'))\"' >Approve</a><a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn'onclick=\"(ApproveRejectRequest(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Reject</a>";
                                    strHTML += "        <a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn' onclick=\"(CollapseApproveRejectPopup(" + obj.RequestId + ",'" + obj.Status + "',1,'" + obj.Requested + "'))\"' >Approve</a><a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn'onclick=\"(CollapseApproveRejectPopup(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Reject</a>";
                                    strHTML += "    </div>";
                                }

                                else if (obj.Status == 'Closed' || obj.Status == 'Cancelled') {
                                    strHTML += "   <div class='pt-1 pb-1 text-end'>";
                                    strHTML += "        <a href='javascript:;' Style='pointer-events: none;' data-bs-toggle='modal' data-bs-target='#InfraCRmodal' class='disabled btn borderbtn ml-1' onclick=\"(OpenCancelPopUp(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Cancel Request</a>";
                                    //strHTML += "        <a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn' onclick=\"(ApproveRejectRequest(" + obj.RequestId + ",'" + obj.Status + "',1,'" + obj.Requested + "'))\"' >Approve</a><a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn'onclick=\"(ApproveRejectRequest(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Reject</a>";
                                    strHTML += "        <a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn' onclick=\"(CollapseApproveRejectPopup(" + obj.RequestId + ",'" + obj.Status + "',1,'" + obj.Requested + "'))\"' >Approve</a><a href='javascript:;' Style='pointer-events: none;' class='disabled btn borderbtn'onclick=\"(CollapseApproveRejectPopup(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Reject</a>";
                                    strHTML += "    </div>";
                                }

                                else {
                                    strHTML += "   <div class='pt-1 pb-1 text-end'>";
                                    strHTML += "        <a href='javascript:;' data-bs-toggle='modal' data-bs-target='#InfraCRmodal' class='btn borderbtn ml-1' onclick=\"(OpenCancelPopUp(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Cancel Request</a>";
                                    //strHTML += "        <a href='javascript:;' class='btn borderbtn' onclick=\"(ApproveRejectRequest(" + obj.RequestId + ",'" + obj.Status + "',1,'" + obj.Requested + "'))\"' >Approve</a><a href='javascript:;' class='btn borderbtn'onclick=\"(ApproveRejectRequest(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Reject</a>";
                                    strHTML += "        <a href='javascript:;' class='btn borderbtn' onclick=\"(CollapseApproveRejectPopup(" + obj.RequestId + ",'" + obj.Status + "',1,'" + obj.Allocated + "'))\"' >Approve</a><a href='javascript:;' class='btn borderbtn'onclick=\"(CollapseApproveRejectPopup(" + obj.RequestId + ",'" + obj.Status + ",0'))\"'>Reject</a>";
                                    strHTML += "    </div>";
                                }

                                strHTML += "    <div class='subtblheading'>";
                                strHTML += "       <h4>Similar Request</h4>";
                                strHTML += "    </div>";
                                strHTML += "    <div class='table-responsive'>";
                                strHTML += "       <table class='table table-bordered InfraReqWeektable' id='tblWeek" + index + "'>";
                                strHTML += '            <thead>';
                                strHTML += '                <tr>';
                                strHTML += '                    <th colspan="5">';
                                strHTML += '                        <a href="javascript:;" class="IRR_Arrow IRRInfraPrevMonth float-start"><img class="uparrow" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-bs-original-title="Previous Month"></a>';
                                strHTML += '                        Sep 2018';
                                strHTML += '                    </th>';
                                strHTML += '                    <th colspan="5">Oct 2018</th>';
                                strHTML += '                    <th colspan="5">Nov 2018 <a href="javascript:;" class="IRR_Arrow IRRInfraPrevMonth float-end"><img class="uparrow" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-bs-original-title="Next Month"></a></th>';
                                strHTML += '                </tr>';
                                strHTML += '                <tr>';
                                //strHTML += '                    <th>';
                                //strHTML += '                        Week 1';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 2';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 3';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 4';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 5';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 6';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 7';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 8';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 9';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 10';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 11';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 12';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 13';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 14';
                                //strHTML += '                     </th>';
                                //strHTML += '                     <th>';
                                //strHTML += '                         Week 15';
                                //strHTML += '                     </th>';
                                strHTML += '                 </tr>';
                                strHTML += '             </thead>';
                                strHTML += '             <tbody>';
                                strHTML += '                 <tr>';
                                //strHTML += '                     <td class="rsrsPercentage bglightblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 05</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bglightblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 05</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bglightblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 02</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bgHighlightDarkblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 05</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bgHighlightDarkblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 05</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bgHighlightDarkblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 05</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bglightblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 05</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bglightblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 04</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bglightblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 03</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bglightblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 02</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bglightblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 01</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bglightblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 06</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bglightblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 07</span></a></td>';
                                //strHTML += '                     <td class="rsrsPercentage bglightblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 02</span></a></td>';
                                //strHTML += '                      <td class="rsrsPercentage bglightblue"><a href="javascript:;" class="" data-bs-toggle="collapse" data-bs-target=".IRRSubdetail" onclick=""><span class="RsrsCount"><i class="fa fa-user" aria-hidden="true"></i> 05</span></a></td>';
                                strHTML += '                 </tr>';
                                strHTML += '             </tbody>';
                                strHTML += '         </table>';
                                strHTML += '        <div class="InfraResourceRequestSubdetail IRRSubdetail collapse">';
                                strHTML += '            <table class="table table-bordered" style="width:100%;">';
                                strHTML += '                <thead>';
                                strHTML += '                    <tr>';
                                strHTML += '                        <th>Request ID</th>';
                                strHTML += '                        <th>Infrastructure Resource</th>';
                                strHTML += '                        <th>Project Name</th>';
                                strHTML += '                        <th colspan="2">No. Of Resource</th>';
                                strHTML += '                        <th>Requested Date</th>';
                                strHTML += '                        <th>From Date</th>';
                                strHTML += '                        <th>To Date</th>';
                                strHTML += '                        <th>Available Licenses</th>';
                                strHTML += '                        <th>Status</th>';
                                strHTML += '                        <th>Requested By</th>';
                                strHTML += '                    </tr>';
                                strHTML += '    <tr>';
                                strHTML += '     <th></th>';
                                strHTML += '     <th class="text-start"></th>';
                                strHTML += '        <th>&nbsp;</th>';
                                strHTML += '        <th>Requested</th>';
                                strHTML += '        <th>Allocated</th>';
                                strHTML += '        <th></th>';
                                strHTML += '        <th></th>';
                                strHTML += '        <th></th>';
                                strHTML += '        <th></th>';
                                strHTML += '        <th></th>';
                                strHTML += '        <th></th>';
                                strHTML += '    </tr>';
                                strHTML += '                </thead>';
                                strHTML += "              <tbody id = 'tblIRRSubdetail" + obj.RequestId + "'>";
                                strHTML += '                    <tr>';
                                strHTML += '                        <td>';
                                strHTML += '                            <a href="javascript:;" class="RreqID" onclick="RREdit()">';
                                //strHTML += '                                <span data-bs-toggle="tooltip" title="" class="idlabel" data-bs-original-title="">GD-001</span>';
                                strHTML += '                            </a>';
                                strHTML += '                        </td>';
                                //strHTML += '                        <td>Air Flow Labs 2</td>';
                                //strHTML += '                        <td>Whizible</td>';
                                //strHTML += '                        <td>03</td>';
                                //strHTML += '                        <td>Requested Date</td>';
                                //strHTML += '                        <td>From Date</td>';
                                //strHTML += '                        <td>To Date</td>';
                                //strHTML += '                        <td>05</td>';
                                //strHTML += '                        <td class="text-center">Ready For Assignment</td>';
                                //strHTML += '                        <td>John</td>';

                                strHTML += '                     </tr>';
                                strHTML += '                     <tr>';
                                strHTML += '                         <td>';
                                strHTML += '                             <a href="javascript:;" class="RreqID" onclick="RREdit()">';
                                //strHTML += '                                 <span data-bs-toggle="tooltip" title="" class="idlabel" data-bs-original-title="">GD-001</span>';
                                strHTML += '                             </a>';
                                strHTML += '                         </td>';
                                //strHTML += '                         <td>Air Flow Labs 2</td>';
                                //strHTML += '                         <td>Helpdesk</td>';
                                //strHTML += '                         <td>03</td>';
                                //strHTML += '                         <td>Requested Date</td>';
                                //strHTML += '                         <td>From Date</td>';
                                //strHTML += '                         <td>To Date</td>';
                                //strHTML += '                         <td>02</td>';
                                //strHTML += '                         <td class="text-center">Rejected</td>';
                                //strHTML += '                         <td>Mac</td>';
                                strHTML += '                     </tr>';
                                strHTML += '                     <tr>';
                                strHTML += '                         <td>';
                                strHTML += '                             <a href="javascript:;" class="RreqID" onclick="RREdit()">';
                                //strHTML += '                                 <span data-bs-toggle="tooltip" title="" class="idlabel" data-bs-original-title="">GD-001</span>';
                                strHTML += '                             </a>';
                                strHTML += '                         </td>';
                                //strHTML += '                         <td>Air Flow Labs 2</td>';
                                //strHTML += '                         <td>New Project</td>';
                                //strHTML += '                         <td>03</td>';
                                //strHTML += '                         <td>Requested Date</td>';
                                //strHTML += '                         <td>From Date</td>';
                                //strHTML += '                         <td>To Date</td>';
                                //strHTML += '                         <td>07</td>';
                                //strHTML += '                         <td class="text-center">Assigned</td>';
                                //strHTML += '                         <td>Lawrel</td>';

                                strHTML += '                     </tr>';
                                strHTML += '                     <tr>';
                                strHTML += '                         <td>';
                                strHTML += '                             <a href="javascript:;" class="RreqID" onclick="RREdit()">';
                                //strHTML += '                                 <span data-bs-toggle="tooltip" title="" class="idlabel" data-bs-original-title="">GD-001</span>';
                                strHTML += '                             </a>';
                                strHTML += '                         </td>';
                                //strHTML += '                         <td>Air Flow Labs 2</td>';
                                //strHTML += '                         <td>Agile</td>';
                                //strHTML += '                         <td>03</td>';
                                //strHTML += '                         <td>Requested Date</td>';
                                //strHTML += '                         <td>From Date</td>';
                                //strHTML += '                         <td>To Date</td>';
                                //strHTML += '                         <td>03</td>';
                                //strHTML += '                         <td class="text-center">Pending For Approval</td>';
                                //strHTML += '                        <td>Kewin</td>';
                                strHTML += '                     </tr>';
                                strHTML += "                 </tbody>";
                                strHTML += "            </table>";
                                strHTML += "        </div>";

                                strHTML += "     </div>";
                                strHTML += " </td>";
                                strHTML += " </tr>";

                            });
                        }
                        else {
                            strHTML += "<tr><td class='text-center' colspan='11'>" + NoDataFound + " </td></tr>";
                        }

                        strHTML += "</tbody>";
                        $("#infrarequestTbl").html(strHTML);
                        StopAjaxLoader("#bodyRequest-Approval");
                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (xhr, ajaxOptions, thrownError) {
                    //    if (ajaxOptions == "error") {
                    //        console.log(thrownError);
                    //        alertify.set('notifier', 'position', 'top-right');
                    //        alertify.notify(xhr.responseJSON.Message);
                    //    }
                    //    else {
                    //        alertify.set('notifier', 'position', 'top-right');
                    //        alertify.notify(thrownError);
                    //    }
                    //    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    // StopAjaxLoader("#bodyBusiness-group");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                               // window.open("../../../Default.aspx", "_top");
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            } else {
                               // window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                })
            }
        }
        var SelectedEmpID = [];
        //var selectedCertificationUniqueId = '';
        function GetSelectedForApprove(currentObject) {
            // debugger;
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedEmpID.push(parseInt(row.find('#hdn_RequestID').val()));
                //  console.log("SelectedEmpID", SelectedEmpID);
            }
            else {
                if (SelectedEmpID != 'undefined' && SelectedEmpID.length > 0) {
                    var removeEmp = row.find('#hdn_RequestID').val();
                    SelectedEmpID.remove(parseInt(removeEmp));
                    //SelectedEmpID.remove(removeEmp);
                }
            }
        }

        Array.prototype.remove = function () {
            var what, a = arguments, L = a.length, ax;
            while (L && this.length) {
                what = a[--L];
                while ((ax = this.indexOf(what)) !== -1) {
                    this.splice(ax, 1);
                }
            }
            return this;
        };
        function BulkPopup(action) {
            if (action == 'Cancelled') {
                $('#StuatusChange').text('Cancel Status');
                //$('#Note').text('Requests with status Ready For Assignment can not be Cancelled.');
                $("#deleted").text('Request(s) Cancelled.');
                $("#notdeleted").text('Request(s) can not be cancelled.');
            }
            else if (action == 'Pending For Approval') {
                $('#StuatusChange').text('Approve Status');
                // $('#Note').text('Requests with status Ready For Assignment can not be Approved again.');
                $('#deleted').text('Request(s) Approved.');
                $('#notdeleted').text('Request(s) can not be approved.');
            }
            else if (action == 'Rejected') {
                $('#StuatusChange').text('Reject Status');
                // $('#Note').text('Requests with status Ready For Assignment can not be Rejected.');
                $('#deleted').text('Request(s) Rejected.');
                $('#notdeleted').text('Request(s) can not be rejected.');
            }
            else {
                //$('#StuatusChange').text('');
                //$('#Note').text('');
                //$('#deleted').text('');
                //$('#notdeleted').text('');
            }
        }


        function bulkApproveOrReject(bulkAction) {
            BulkPopup(bulkAction);
            var strHTML = "";
            var IrParameter = SelectedEmpID.toString();
            if (IrParameter.length > 0) {
                var Comments = $("#BulkIRRCancelComment").val();
                //    var infraFilterParameter = { InfraRequestIds: IrParameter, Approvalby: UserName, RoleID: RoleID, UserID: SessionEmployeeId, Status: bulkAction }                    
                var infraFilterParameter = { InfraRequestIds: IrParameter, Approvalby: UserName, RoleID: RoleID, UserID: SessionEmployeeId, Status: bulkAction, Comments: Comments }
                StartLoader("#bodyRequest-Approval");
                $.ajax({
                    url: strUrl + '/api/RM_InfraRequests/UpdateRequestStatusMulti',
                    type: "POST",
                    data: JSON.stringify(infraFilterParameter),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        // StartLoader("#bodyCertification-Details");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (infraFilterParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(infraFilterParameter) ? infraFilterParameter : JSON.stringify(infraFilterParameter)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //}

                        StopAjaxLoader("#bodyRequest-Approval");
                        var whereClause = "ProjectId = " + $('#CboIrProjectForList').val();
                        GetAllResourceRequests(whereClause);
                        $('#lbldltCount').text(data.deletedCount);
                        $('#lblNotdltCount').text(data.notDeletedCount);
                        //var strHTMLRecords = data.deletedCount + '</br>' + data.notDeletedCount;                       
                        // $('#showdeleterow').html(strHTMLRecords);
                        $('#AprvRejectConfirmMModal').modal('show');
                        $("#BulkInfraCRmodal").modal('hide');

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                //window.open("../../../Default.aspx", "_top");
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            } else {
                              //  window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "OK") {  //200
                            GetCertificateDetails();
                            $('#AprvRejectConfirmMModal').modal('hide');
                            // alertify.set('notifier', 'position', 'top-right');
                            //alertify.notify("Deleted");
                        }

                        // StopAjaxLoader("#bodyCertification-Details");
                        $('#AprvRejectConfirmMModal').modal('hide');
                    }
                })
            } else {
                if (bulkAction == 'Cancelled') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please select at least one record to Cancel.");
                }
                else if (bulkAction == 'Rejected') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please select at least one record to Reject.");
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please select at least one record to Approve.");
                }
                return false;
            }
            SelectedEmpID = [];
            IrParameter = "";
        }
        function GetSimilarRequestsNextPrevious(RequestId, index, Month) {
        
          //Commemted & Added By Dipali V On 31th Jan 2023 For Get Proper date Formate to validate 
            //var nextMonth = new Date(Month);
            //nextMonth.setMonth(nextMonth.getMonth() + 1, 1);
            var nextMonth = moment(Month).add(1, 'months').format('MM/DD/YYYY');
            GetSmiliarRequests(RequestId, index, nextMonth);
          //Commemted & Added By Dipali V On 31th Jan 2023 For Get Proper date Formate to validate 
        }
        function GetSimilarRequestsPrevious(RequestId, index, Month) {
            //Commemted & Added By Dipali V On 31th Jan 2023 For Get Proper date Formate to validate 
            //var nextMonth = new Date(Month);
            //nextMonth.setMonth(nextMonth.getMonth() - 1, 1);
            var nextMonth = moment(Month).subtract(1, 'months').format('MM/DD/YYYY');
            GetSmiliarRequests(RequestId, index, nextMonth);
          //End of Commemted & Added By Dipali V On 31th Jan 2023 For Get Proper date Formate to validate 
        }

        function GetSmiliarRequests(RequestId, index, Month) {
            var strHTML = "";
            var resourceWeekWise = {
                MonthDateTime: Month
            }
          
            StartLoader("#bodyRequest-Approval");
            $.ajax({
                url: strUrl + '/api/RM_InfraRequests/GetSmiliarRequests?requestId=' + RequestId,
                type: "POST",
                data: JSON.stringify(resourceWeekWise),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (resourceWeekWise) {
                        xhr.setRequestHeader("Params", encryptString(isJson(resourceWeekWise) ? resourceWeekWise : JSON.stringify(resourceWeekWise)));
                    }
                },
                success: function (data) {
                    //console.log(data);
                    var MonthsList = data;
                    // console.log(MonthsList);

                    strHTML = '<thead>';
                    strHTML += '                <tr>';
                    strHTML += '                    <th colspan="5">';
                    //strHTML += '                        <a href="javascript:;" class="IRR_Arrow IRRInfraPrevMonth float-start"><img class="uparrow" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-bs-original-title="Previous Month"></a>';
                    strHTML += "                        <a href='javascript:;' class='IRR_Arrow IRRInfraPrevMonth float-start'><img class='uparrow' data-bs-toggle='tooltip' data-bs-placement='top' title='' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' data-bs-original-title='Previous Month' onclick=\"(GetSimilarRequestsPrevious(" + RequestId + "," + index + ",'" + MonthsList[0].MonthDateTime + "'))\"'></a>";
                    strHTML += '                        ' + MonthsList[0].MonthName;
                    strHTML += '                    </th>';
                    strHTML += '                    <th colspan="5">' + MonthsList[1].MonthName + '</th>';
                    strHTML += "                    <th colspan='5'>" + MonthsList[2].MonthName + " <a href='javascript:;' class='IRR_Arrow IRRInfraPrevMonth float-end'><img class='uparrow data-bs-toggle='tooltip' data-bs-placement='top' title='' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' data-bs-original-title='Next Month'onclick=\"(GetSimilarRequestsNextPrevious(" + RequestId + "," + index + ",'" + MonthsList[0].MonthDateTime + "'))\"'></a></th>";
                    strHTML += '                </tr>';
                    strHTML += '                <tr>';

                    $.each(MonthsList[0].ResourceWeekWiseDetails, function (index, obj) {
                        strHTML += '                    <th>';
                        strHTML += '                        ' + obj.Week;
                        strHTML += '                     </th>';
                    });

                    $.each(MonthsList[1].ResourceWeekWiseDetails, function (index, obj) {
                        strHTML += '                    <th>';
                        strHTML += '                        ' + obj.Week;
                        strHTML += '                     </th>';
                    });

                    $.each(MonthsList[2].ResourceWeekWiseDetails, function (index, obj) {
                        strHTML += '                    <th>';
                        strHTML += '                        ' + obj.Week;
                        strHTML += '                     </th>';
                    });

                    strHTML += '                 </tr>';
                    strHTML += '             </thead>';
                    strHTML += '             <tbody>';
                    strHTML += '                 <tr>';


                    $.each(MonthsList[0].ResourceWeekWiseDetails, function (index, obj) {
                        strHTML += "<td class='rsrsPercentage bglightblue'><a href='javascript:;' class='' data-bs-toggle='collapse' data-bs-target='.IRRSubdetail' onclick=\"(GetSmiliarRequestsDetails('" + obj.Month + "','" + obj.MonthDateTime + "','" + obj.Week + "'," + obj.Count + ",'" + obj.WeekStartDateTime + "','" + obj.WeekEndDateTime + "'," + RequestId + "))\"'><span class='RsrsCount'><i class='fa fa-user' aria-hidden='true'></i> " + obj.Count + "</span></a></td>";
                    });

                    $.each(MonthsList[1].ResourceWeekWiseDetails, function (index, obj) {
                        strHTML += "<td class='rsrsPercentage bglightblue'><a href='javascript:;' class='' data-bs-toggle='collapse' data-bs-target='.IRRSubdetail' onclick=\"(GetSmiliarRequestsDetails('" + obj.Month + "','" + obj.MonthDateTime + "','" + obj.Week + "'," + obj.Count + ",'" + obj.WeekStartDateTime + "','" + obj.WeekEndDateTime + "'," + RequestId + "))\"'><span class='RsrsCount'><i class='fa fa-user' aria-hidden='true'></i> " + obj.Count + "</span></a></td>";
                    });

                    $.each(MonthsList[2].ResourceWeekWiseDetails, function (index, obj) {
                        strHTML += "<td class='rsrsPercentage bglightblue'><a href='javascript:;' class='' data-bs-toggle='collapse' data-bs-target='.IRRSubdetail' onclick=\"(GetSmiliarRequestsDetails('" + obj.Month + "','" + obj.MonthDateTime + "','" + obj.Week + "'," + obj.Count + ",'" + obj.WeekStartDateTime + "','" + obj.WeekEndDateTime + "'," + RequestId + "))\"'><span class='RsrsCount'><i class='fa fa-user' aria-hidden='true'></i> " + obj.Count + "</span></a></td>";
                    });

                    strHTML += '                 </tr>';
                    strHTML += '             </tbody>';


                    $("#tblWeek" + index).html(strHTML);

                    StopAjaxLoader("#bodyRequest-Approval");
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        //console.log(thrownError);
                        ////alertify.set('notifier', 'position', 'top-right');
                        ////alertify.notify(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                         //   window.open("../../../Default.aspx", "_top");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        } else {
                           // window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    }
                    else {
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify(thrownError);
                    }
                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    // StopAjaxLoader("#bodyBusiness-group");
                }
            })
        }

        function GetSmiliarRequestsDetails(Month, MonthDateTime, Week, Count, WeekStartDateTime, WeekEndDateTime, RequestId) {
            var strHTML = "";
            var ResourceWeekWiseDetails = {
                Month: Month,
                MonthDateTime: MonthDateTime,
                Week: Week,
                Count: Count,
                WeekStartDateTime: WeekStartDateTime,
                WeekEndDateTime: WeekEndDateTime
            };
            //   console.log(ResourceWeekWiseDetails);
            StartLoader("#bodyRequest-Approval");
            $.ajax({
                url: strUrl + '/api/RM_InfraRequests/GetSmiliarRequestsDetails?requestId=' + RequestId,
                type: "POST",
                data: JSON.stringify(ResourceWeekWiseDetails),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (ResourceWeekWiseDetails) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ResourceWeekWiseDetails) ? ResourceWeekWiseDetails : JSON.stringify(ResourceWeekWiseDetails)));
                    }
                },
                success: function (data) {
                    //    console.log(data);
                    var reqData = data;
                    if (reqData.length > 0) {
                        $.each(reqData, function (index, obj) {
                            strHTML += '                    <tr>';
                            strHTML += '                        <td>';
                            strHTML += '                            <a href="javascript:;" class="RreqID" onclick="RREdit()">';
                            strHTML += '                                <span data-bs-toggle="tooltip" title="" class="idlabel" data-bs-original-title="">' + obj.RequestId + '</span>';
                            strHTML += '                            </a>';
                            strHTML += '                        </td>';
                            strHTML += '                        <td>' + obj.InfraName + '</td>';
                            strHTML += '                        <td>' + obj.ProjectName + '</td>';
                            strHTML += '                        <td>' + obj.Requested + '</td>';
                            strHTML += '                        <td>' + obj.Allocated + '</td>';
                            strHTML += '                        <td>' + convert(obj.RequestedDate) + '</td>';
                            strHTML += '                        <td>' + convert(obj.FromDate) + '</td>';
                            strHTML += '                        <td>' + convert(obj.ToDate) + '</td>';
                            strHTML += '                        <td>' + obj.AvailableLicenses + '</td>';
                            strHTML += '                        <td class="text-center">' + obj.Status + '</td>';
                            strHTML += '                        <td>' + obj.RequestedBy + '</td>';

                            strHTML += '                     </tr>';

                        });
                    } else {
                        strHTML += '<tr><td class="text-center" colspan="12"> No Data Found </td></tr>';
                    }


                    $("#tblIRRSubdetail" + RequestId).html(strHTML);
                    // $("#tblWeek2").html(strHTML);
                    StopAjaxLoader("#bodyRequest-Approval");
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        //console.log(thrownError);
                        ////alertify.set('notifier', 'position', 'top-right');
                        ////alertify.notify(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                           // window.open("../../../Default.aspx", "_top");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        } else {
                           // window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    }
                    else {
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify(thrownError);
                    }
                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    // StopAjaxLoader("#bodyBusiness-group");
                }
            })
        }
        function convert(str) {
            var date = new Date(str),
                mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                day = ("0" + date.getDate()).slice(-2);
            return [date.getFullYear(), mnth, day].join("-");
        }
        function CancleDetails() {
            //alert("sd");
            $("#btnApprove").removeClass("disabled");
            $("#btnReject").removeClass("disabled");
            $("#btnCancel").removeClass("disabled");
            var SelectProjectID = $('#CboIrProjectForList').val();
            if (SelectProjectID != null && SelectProjectID != 'undefined' && SelectProjectID > 0) {
                var whereClause = "ProjectId = " + SelectProjectID;
                GetAllResourceRequests(whereClause);
            }
        }
        var IsApproverManager = "";
        function GetRequestById(RequestId) {
            var strHTML = "";
            $("#hdnInfraRequestID").val(RequestId);
            StartLoader("#bodyRequest-Approval");
            $.ajax({
                url: strUrl + '/api/RM_InfraRequests/GetById?requestId=' + RequestId + '&LoggedUserID=' + SessionEmployeeId + '',
                type: "POST",
                //data: JSON.stringify(ResourceWeekWiseDetails),
                //dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    //if (Parameters) {
                    //    xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    //}
                },
                success: function (data) {
                    var reqData = data;
                    //   console.log(reqData);
                    RoleDes = reqData.RoleName;
                    IsApproverManager = reqData.IsApproverManager;
                    $('#IRRDetailApprovalComments').attr("disabled", true);
                    $('#IRRDetailFromDate').attr("disabled", true);
                    $('#IRRDetailToDate').attr("disabled", true);
                    $('#IRRDetailRequiredQuantity').attr("disabled", true);
                    if ((reqData.RoleName == "RESOURCE MANAGER" || reqData.RoleName == "Resource Manager" || reqData.RoleName == "APPLICATION ADMINISTRATOR" || reqData.RoleName == "Application Administrator") && reqData.Status.trim() == "Pending For Approval") {
                        $('#IRRDetailApprovalComments').attr("disabled", false);
                        $('#IRRDetailAllocatedQuantity').attr("disabled", false);
                    }
                    else {
                        //      console.log("re");
                        $('#IRRDetailAllocatedQuantity').attr("disabled", true);
                    }
                    if ((reqData.RoleName == "PROJECT MANAGER" || reqData.RoleName == "Project Manager") && (reqData.Status.trim() == "Cancelled" || reqData.Status.trim() == "Rejected")) {
                        //alert();
                        $('#IRRDetailFromDate').attr("disabled", false);
                        $('#IRRDetailToDate').attr("disabled", false);
                        $('#IRRDetailRequiredQuantity').attr("disabled", false);


                    }
                    if ((reqData.RoleName == "RESOURCE MANAGER" || reqData.RoleName == "Resource Manager" || reqData.RoleName == "APPLICATION ADMINISTRATOR" || reqData.RoleName == "Application Administrator") && (reqData.Status.trim() == "Rejected")) {
                        $("#btnApprove").addClass("disabled");
                        $("#btnReject").addClass("disabled");
                        $("#btnCancel").addClass("disabled");
                    }
                    if ((reqData.RoleName == "PROJECT MANAGER" || reqData.RoleName == "Project Manager") && (reqData.Status.trim() == "Rejected")) {

                        $("#btnApprove").addClass("disabled");
                        $("#btnReject").addClass("disabled");
                    }
                    $("#IRRdetailReqID").val(reqData.RequestId);
                    $("#IRRdetailReqName").val(reqData.InfraName);
                    if (reqData.AllocatedDate == "1900-01-01T00:00:00" || reqData.AllocatedDate == "1970-01-01T00:00:00" || reqData.AllocatedDate == null) {
                        $("#IRRDetailAllocatedDate").val("");
                    } else {
                        $("#IRRDetailAllocatedDate").val(convert(reqData.AllocatedDate));
                    }
                    if (reqData.ApprovalDate == "1900-01-01T00:00:00" || reqData.ApprovalDate == "1970-01-01T00:00:00" || reqData.ApprovalDate == null) {
                        $("#IRRDtailApprvlDate").val("");
                    } else {
                        $("#IRRDtailApprvlDate").val(convert(reqData.ApprovalDate));
                    }

                    if (reqData.RequestedDate == "1900-01-01T00:00:00") {
                        $("#IRRDetailReqDate").val("");
                    } else {
                        $("#IRRDetailReqDate").val(convert(reqData.RequestedDate));
                    }
                    if (reqData.FromDate == "1900-01-01T00:00:00") {
                        $("#IRRDetailFromDate").val("");
                    } else {
                        $("#IRRDetailFromDate").val(convert(reqData.FromDate));
                    }
                    if (reqData.ToDate == "1900-01-01T00:00:00") {
                        $("#IRRDetailToDate").val("");
                    } else {
                        $("#IRRDetailToDate").val(convert(reqData.ToDate));
                    }
                    $("#IRRDetailRequiredQuantity").val(reqData.Requested);
                    $("#IRRDetailAllocatedQuantity").val(reqData.Allocated);
                    $("#IRRDetailApprovalStatus").val(reqData.Status);
                    //$("#IRRDetailAllocatedBy").val(UserName);
                    //$("#IRRDetailApprovalBy").val(UserName);
                    $("#IRRDetailApprovalComments").val(reqData.Comments)
                    var approvars = "";
                    if (reqData.RequestApprovers != null && reqData.RequestApprovers.length > 0) {
                        $.each(reqData.RequestApprovers, function (index, obj) {
                            approvars += obj.EmployeeName + "/";
                        });
                        $("#IRRapprovrsname").text(approvars);
                    }
                    //Added By Rutuja D. on 1 Feb 2022 For IssueID = 31766
                    if (reqData.IsApproverManager == 1) {
                        $("#btnCancel").removeClass("disabled");
                        $("#btnApprove").removeClass("disabled");
                        $("#btnReject").removeClass("disabled");
                    }
                    else {
                        $("#btnCancel").addClass("disabled");
                        $("#btnApprove").addClass("disabled");
                        $("#btnReject").addClass("disabled");
                    }
                    if (reqData.IsApproverManager == 1 && reqData.Status == 'Pending For Approval') {
                        $('#IRRDetailAllocatedQuantity').attr("disabled", false);
                    } else{
                        $('#IRRDetailAllocatedQuantity').attr("disabled", true);
                    }
                    $("#IRRDetailAllocatedBy").val(reqData.RequestedUserName);
                    $("#IRRDetailApprovalBy").val(reqData.Approvalby);
                    StopAjaxLoader("#bodyRequest-Approval");
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        //console.log(thrownError);
                        ////alertify.set('notifier', 'position', 'top-right');
                        ////alertify.notify(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                           // window.open("../../../Default.aspx", "_top");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        } else {
                            //window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    }
                    else {
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify(thrownError);
                    }
                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    // StopAjaxLoader("#bodyBusiness-group");
                }
            })
        }

       // function ApproveRejectRequest(RequestId, Status, IsApprove, Quantity) {
        function ApproveRejectRequest() {
            alertify.set('notifier', 'position', 'top-right');
            var RequestStatus = $("#CollapsehdnInfraRequest").val();
            var RequestId = $("#CollapsehdnInfraRequestID").val();
            var Comments = $("#CollapseIRRCancelComment").val();
            var Allocated = $("#CollapsehdnInfraRequestAllocated").val();
            if (Comments == "") {
                alertify.error("Comment Should not be left bank.");
                $("#CollapseInfraCRmodal").modal('show');
                return false;
            }
            else {
                var objInfraRequest = {
                    InfraRequestId: RequestId,
                    Status: RequestStatus,
                    RoleID: RoleID,
                    UserID: SessionEmployeeId,
                    IsFromEdit: 0,
                    Approvalby: UserName,
                    Comments: Comments,
                    AllocatedQuantity:Allocated
                }
                //StartLoader("#bodyRequest-Approval");
                $.ajax({
                    url: strUrl + '/api/RM_InfraRequests/UpdateRequestStatus',
                    type: "POST",
                    data: JSON.stringify(objInfraRequest),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (objInfraRequest) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objInfraRequest) ? objInfraRequest : JSON.stringify(objInfraRequest)));
                        }
                    },
                    success: function (data) {
                        if (data == "Updated sucessfully.") {
                            if (RequestStatus == "Pending For Approval" || RequestStatus == 'Ready For Assignment') {
                                alertify.success("Approved Successfully.");
                            }
                            else if (RequestStatus == "Rejected") {
                                alertify.success("Rejected Successfully.");
                            }
                            if (RequestStatus != 'Ready For Assignment') {
                                window.open('../Email/SendEmail.aspx?MessageID=35001&RequestId=' + RequestId + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                            }
                            var whereClause = "ProjectId = " + $('#CboIrProjectForList').val();
                            GetAllResourceRequests(whereClause);
                            $("#CollapseInfraCRmodal").modal('hide');
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.notify(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                //window.open("../../../Default.aspx", "_top");
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            } else {
                                //window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify(thrownError);
                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        // StopAjaxLoader("#bodyBusiness-group");
                    }
                })

                //window.open('../Email/SendEmail.aspx?MessageID=20052&RequestId=' + RequestId + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
            }
        }

        function OpenCancelPopUp(RequestId, Status) {
            $("#hdnInfraRequestID").val(RequestId);
            $("#IRRCancelComment").val('');
        }

        function CancelRequest(RequestId, IsfromEdit) {
         
            var Comments = $("#IRRCancelComment").val();
            var reuestID = $("#hdnInfraRequestID").val();
            var objInfraRequest = {
                InfraRequestId: parseInt(reuestID),
                Status: "Cancelled",
                RoleID: parseInt(RoleID),
                UserID: parseInt(SessionEmployeeId),
                Comments: Comments,
                IsFromEdit: 0,
                StartDate: new Date($("#IRRDetailFromDate").val()),
                EndDate:   new Date($("#IRRDetailToDate").val())
            }
            //Added By Rutuja D. on 20 Aug 2021 For Mandatory alert missing
            if (Comments == "" || Comments == undefined) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Comment should not be left blank.");
                $("#InfraCRmodal").modal('show');
                return false;
            }
            //End of Added By Rutuja D. on 20 Aug 2021 For Mandatory alert missing
            else {
                StartLoader("#bodyRequest-Approval");
                $.ajax({
                    url: strUrl + '/api/RM_InfraRequests/UpdateRequestStatus',
                    type: "POST",
                    data: JSON.stringify(objInfraRequest),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (objInfraRequest) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objInfraRequest) ? objInfraRequest : JSON.stringify(objInfraRequest)));
                        }
                    },
                    success: function (data) {
                        //   console.log(data);
                        if (data == "Updated sucessfully.") {
                            window.open('../Email/SendEmail.aspx?MessageID=35001&RequestId=' + reuestID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                            var whereClause = "ProjectId = " + $('#CboIrProjectForList').val();
                            GetAllResourceRequests(whereClause);
                            $("#InfraCRmodal").modal('hide');
                            $("#IRRCancelComment").val('');
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                        }

                        StopAjaxLoader("#bodyRequest-Approval");

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.notify(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                //window.open("../../../Default.aspx", "_top");
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            } else {
                               // window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify(thrownError);
                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        // StopAjaxLoader("#bodyBusiness-group");
                    }
                })
            }
        }

        //Added by mahesh 5 oct 2021
        function OpenEditApprovePopup(popupType) {
            $("#EditIRRCancelComment").val('');
            $("#EdithdnInfraRequestID").text('');
            $("#EdithdnInfraRequest").text('');
            $("#BulkhdnInfraRequest").val(popupType);
            if (popupType == 'Approve') {
                $("#EditWhichInfraRequest").text('Approve ');
            }
            else if (popupType == 'Reject') {
                //Commented and Added By Reshma Chavan on 22nd Dec 2021 for not passing status Rejected
                //$("#EditWhichInfraRequest").text('Reject ');
                $("#EditWhichInfraRequest").text('Reject');
                //End of Commented and Added By Reshma Chavan on 22nd Dec 2021 for not passing status Rejected
               
            } else {
                $("#EditWhichInfraRequest").text(popupType);
            }
            $("#EditInfraCRmodal").modal('show');
        }
        //Update status : call UpdateInfraRequest
        //Added by mahesh 7 oct 2021
        function UpdateEditApprovePopup() {
            var IsApprove = 0;
            var RejectStatus = $("#EditWhichInfraRequest").text();
            if (RejectStatus == 'Reject') {
                IsApprove = 0
            } else {
                IsApprove = 1;//$("#IRRDetailApprovalStatus").val();
            }

            var ApproveRejectComments = $("#EditIRRCancelComment").val();
            if (ApproveRejectComments == "" || ApproveRejectComments == undefined) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Comment should not be left blank.");
                return false;
            }
            //if (ApproveRejectComments != "" || ApproveRejectComments != undefined ) {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("Comment should not be left blank.");
            //    return false;
            //}
            else {
                UpdateInfraRequest(IsApprove,RejectStatus)
            }
            //End Added by mahesh 7 oct 2021
            
        }


        //End Added by mahesh 5 oct 2021

        function UpdateInfraRequest(IsApprove,RejectStatus) {
            //if (($("#IRRDetailApprovalStatus").val() == "Ready For Assignment" || $("#IRRDetailApprovalStatus").val() == "Closed") && (UserRoleLevel == 1)) {
            //    console.log("ra");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("You are not allowded to save request.");
            //    return false;
            //}
            //else {
            if (IsApprove == 1) {
                var ApprovalStatus = $("#IRRDetailApprovalStatus").val();
            }
            else {
                var ApprovalStatus = "Rejected";
            }
            var RoleId = RoleID;

            var InfraRequestId = $("#IRRdetailReqID").val();
            //changed by mahesh 7 oct 2o21
            var ApprovalComments = $("#EditIRRCancelComment").val();
            //changed by mahesh 7 oct 2o21
            var ApprovalBy = $("#IRRDetailApprovalBy").val();
            var AllocatedDate = new Date($("#IRRDetailAllocatedDate").val());
            var AllocatedBy = $("#IRRDetailAllocatedBy").val();
            var ApprvlDate = new Date($("#IRRDtailApprvlDate").val());
            var AllocatedQuantity = $("#IRRDetailAllocatedQuantity").val();

            var StartDate = new Date($("#IRRDetailFromDate").val());
            var EndDate = new Date($("#IRRDetailToDate").val());
            var quantity = $("#IRRDetailRequiredQuantity").val();

           //Added By Reshma Chavan on 14th Oct 2021 for Allocated Quantity Greater than 0
            if (parseInt(AllocatedQuantity) <= 0) {
                $('#IRRDetailAllocatedQuantity').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Allocated Quantity' sholuld be greater than 0.");
                return false;
            }
            //End of Added By Reshma Chavan on 14th Oct 2021 for Allocated Quantity Greater than 0
            if (parseInt(AllocatedQuantity) > parseInt(quantity)) {
                $('#IRRDetailAllocatedQuantity').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Allocated Quantity' sholuld not be greater than 'Required Quantity'.");
                return false;
            }

            //Added By Reshma Chavan on 14th Dec 2021
             if (parseInt(quantity) > parseInt(quantity)) {
                $('#IRRDetailAllocatedQuantity').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Allocated Quantity' sholuld not be greater than 'Required Quantity'.");
                return false;
            }else {
                var objInfraRequest = {
                    RoleID: parseInt(RoleID),
                    UserID: parseInt(SessionEmployeeId),
                    InfraRequestId: parseInt(InfraRequestId),
                    // InfraResourceId:,
                    Quantity: quantity,
                    StartDate: StartDate,
                    EndDate: EndDate,
                    Status: ApprovalStatus,
                    ModifiedBy: SessionEmployeeId,
                    //RequestedDate:,
                    // RequestedBy:,
                    Approvalby: ApprovalBy,
                    Comments: ApprovalComments,
                    AllocatedDate: AllocatedDate,
                    AllocatedBy: AllocatedBy,
                    ApprovalDate: ApprvlDate,
                    AllocatedQuantity: parseInt(AllocatedQuantity),
                    IsFromEdit: 1
                };
                StartLoader("#bodyRequest-Approval");
                $.ajax({
                    url: strUrl + '/api/RM_InfraRequests/UpdateRequestStatus',
                    type: "POST",
                    data: JSON.stringify(objInfraRequest),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (objInfraRequest) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objInfraRequest) ? objInfraRequest : JSON.stringify(objInfraRequest)));
                        }
                    },
                    success: function (data) {
                        var reqData = data;
                        if (data == "Updated sucessfully.") {
                            alertify.set('notifier', 'position', 'top-right');
                            //alertify.success(data);
                            //Added by Chetan M on 12 Aug 2021
                            if (ApprovalStatus == "Pending For Approval" && RejectStatus=='Approve') {
                                alertify.success("Approved Successfully.");
                            }
                            else if (ApprovalStatus == "Rejected") {
                                alertify.success("Rejected Successfully.");
                            }
                            //End of Added by Chetan M on 12 Aug 2021
                            if (ApprovalStatus != 'Ready For Assignment') {
                            window.open('../Email/SendEmail.aspx?MessageID=35001&RequestId=' + InfraRequestId + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                            }
                            var whereClause = "ProjectId = " + $('#CboIrProjectForList').val();
                            GetAllResourceRequests(whereClause);   
                            //Added By Reshma Chavan on 13th oct 2021 for Refresh issue of detail section
                            GetRequestById(InfraRequestId);                           
                            $("#EditInfraCRmodal").modal('hide');
                            //End of Added By Reshma Chavan on 13th oct 2021 for Refresh issue of detail section
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                        }

                        StopAjaxLoader("#bodyRequest-Approval");
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.notify(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                //window.open("../../../Default.aspx", "_top");
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            } else {
                              //  window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify(thrownError);
                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        // StopAjaxLoader("#bodyBusiness-group");
                    }
                })
                //}
            }
        }

        function CboIrProjectForList_OnChange(SelectProjectID) {

            if (SelectProjectID != null && SelectProjectID != 'undefined' && SelectProjectID > 0) {
                var whereClause = "ProjectId = " + SelectProjectID;
                GetAllResourceRequests(whereClause);
            }
            else {
                $('#CboIrProjectForList').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Project.");
                return false;

            }

            //if (SelectProjectID>0) {
            //      alert(SelectProjectID);
            //} else {
            //    $('#CboIrProjectForList').focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("Please select Project.");
            //    return false;

            //}

        }
        //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
        function btnDeleteFilter(FilterID, FilterName, Flag) {
            FilterName = unescape(FilterName).trim();
            $('#DFilterID').val(FilterID);
            $('#DFilterName').val(FilterName);
            $('#DIsApplyed').val(Flag);
            $('#deleteConfirmAlert').modal('show');
        }

        function confirmDelete() {
            var FilterID = $('#DFilterID').val();
            var FilterName = $('#DFilterName').val();
            var FilterIsApplyed = $('#DIsApplyed').val();
            if (FilterIsApplyed == 3) {
                DeleteFilter(FilterID, FilterName, 3);
            } else {
                DeleteFilter(FilterID, FilterName);
            }
        }
        //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021

        //Added By Rutuja D. For Bind Filter Placeholder on 15 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }
        //End of Added By Rutuja D. For Bind Filter Placeholder on 15 July 2021

        //Added BY Rutuja D. on 7 Sep 2021 For Cancel Request Modal is missing
        function CheckSelectionCount(bulkAction) {
            alertify.set('notifier', 'position', 'top-right');
            BulkPopup(bulkAction);
            var strHTML = "";
            var IrParameter = SelectedEmpID.toString();
            if (IrParameter.length > 0) {
                $("#BulkIRRCancelComment").val('');
                $("#BulkhdnInfraRequest").val('');
                $("#BulkhdnInfraRequest").text('');
                $("#WhichInfraRequest").text('');
                $("#BulkInfraCRmodal").modal('show');
                $("#BulkhdnInfraRequest").val(bulkAction);
                if (bulkAction == 'Pending For Approval') {
                    $("#WhichInfraRequest").text('Approve');
                }
                else if (bulkAction == 'Rejected') {
                    $("#WhichInfraRequest").text('Reject');
                } else {
                    $("#WhichInfraRequest").text(bulkAction);
                }
            } else {
                if (bulkAction == 'Cancelled') {
                    alertify.error("Please select at least one record to Cancel.");
                }
                else if (bulkAction == 'Rejected') {
                    alertify.error("Please select at least one record to Reject.");
                }
                else {
                    alertify.error("Please select at least one record to Approve.");
                }
                return false;
            }
        }

        function CheckCommentValidation() {
            alertify.set('notifier', 'position', 'top-right');
            var CancelRequest = $("#BulkIRRCancelComment").val();
            var WhichRequest = $("#BulkhdnInfraRequest").val();
            if (CancelRequest == "") {
                alertify.error("Comment Should not be left bank.")
                return false;
            } else {
                if (WhichRequest == 'Pending For Approval') {
                    bulkApproveOrReject('Pending For Approval')
                } else if (WhichRequest == 'Cancelled') {
                    bulkApproveOrReject('Cancelled')
                } else {
                    bulkApproveOrReject('Rejected')
                }
            }
        }

        //End of Added BY Rutuja D. on 7 Sep 2021 For Cancel Request Modal is missing
        //Added By Reshma Chavan on 8th Oct 2021 To restrict Special Operators For IssuID-29505 And 29506
         //Restrict Special Charaters onkeypress
        function restrictSpecialChars(e) {

            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57));
        }
        //End ofAdded By Reshma Chavan on 8th Oct 2021 To restrict Special Operators

        //Added By Rutuja D. on 16 Dec 2021 For Ceck Loged User is Infra Approver or not
        function GetUserIsInfraApprover() {
            var userID = SessionEmployeeId;
            $.ajax({
                url: strUrl + '/api/RM_IrRequestApproval/GetUserIsInfraApprover',
                type: "POST",
                data: JSON.stringify(userID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                success: function (data) {
                    if (data == "AuthenticationError") {

                    }
                    else {
                        for (var i = 0; i < data.length; i++) {
                            var IsInfraApprover = data[i]["IsInfraApprover"];
                            var IsOUManager = data[i]["IsOUManager"]
                            if (IsInfraApprover == 0 || IsOUManager == 0) { //Rutuja Change the If Condition on 4 Feb 2022 For enable Disabled Button
                                $("#btnGridCancel").addClass("disabled");
                                $("#btnGridApprove").addClass("disabled");
                                $("#btnGridReject").addClass("disabled");
                                //$("#btnCancel").addClass("disabled");
                                //$("#btnApprove").addClass("disabled");
                                //$("#btnReject").addClass("disabled");

                                $("#btnGridCancel").addClass("DisableContent").parent().css("cursor", "no-drop");
                                $("#btnGridApprove").addClass("DisableContent").parent().css("cursor", "no-drop");
                                $("#btnGridReject").addClass("DisableContent").parent().css("cursor", "no-drop");
                                //$("#btnCancel").addClass("DisableContent").parent().css("cursor", "no-drop");
                                //$("#btnApprove").addClass("DisableContent").parent().css("cursor", "no-drop");
                                //$("#btnReject").addClass("DisableContent").parent().css("cursor", "no-drop");

                            }
                        }
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                          //  window.open("../../../Default.aspx", "_top");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        } else {
                          //  window.location.href = "../../../default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
            });
        }
        //End of Added By Rutuja D. on 16 Dec 2021 For Ceck Loged User is Infra Approver or not

        function CollapseApproveRejectPopup(RequestId, Status, IsApprove, AllocatedQuantity) {
            var RequestStatus = '';
            if (IsApprove == 1) {
                RequestStatus = Status;
            }
            else {
                RequestStatus = "Rejected";
            }
            if (parseInt(AllocatedQuantity) <= 0 && Status == 'Pending For Approval') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Allocated Quantity' sholuld be greater than 0.");
                return false;
            } else {
                $("#CollapseIRRCancelComment").val('');
                $("#CollapsehdnInfraRequestID").val('');
                $("#CollapseWhichInfraRequest").val('');
                $("#CollapsehdnInfraRequestAllocated").val('');
                $("#CollapseWhichInfraRequest").text('');
                $("#WhichInfraRequest").text('');
                $("#CollapseInfraCRmodal").modal('show');
                $("#CollapsehdnInfraRequest").val(RequestStatus);
                $("#CollapsehdnInfraRequestID").val(RequestId);
                $("#CollapsehdnInfraRequestAllocated").val(AllocatedQuantity);
                if (RequestStatus == 'Pending For Approval' || RequestStatus == 'Ready For Assignment') {
                    $("#CollapseWhichInfraRequest").text('Approve ');
                }
                else if (RequestStatus == 'Rejected') {
                    $("#CollapseWhichInfraRequest").text('Reject ');
                }
            }
        }

        

        function CollapseCommentValidation() {
            alertify.set('notifier', 'position', 'top-right');
            var CancelRequest = $("#BulkIRRCancelComment").val();
            var WhichRequest = $("#BulkhdnInfraRequest").val();
            if (CancelRequest == "") {
                alertify.error("Comment Should not be left bank.")
                return false;
            } else {
                if (WhichRequest == 'Pending For Approval') {
                    bulkApproveOrReject('Pending For Approval')
                } else if (WhichRequest == 'Cancelled') {
                    bulkApproveOrReject('Cancelled')
                } else {
                    bulkApproveOrReject('Rejected')
                }
            }
        }
        
        //Added By Reshma Chavan on 10th March 2022
        $("#BtnBack").click(function ()
        { 
            var CurrentProjectId = $('#CboIrProjectForList').val();
            if (CurrentProjectId != '' && CurrentProjectId != 'undefined' && CurrentProjectId > 0) {
                $("#CboIrProjectForList").val(CurrentProjectId)
            } else {
                $("#CboIrProjectForList").val(0);
            }

            var ProjectID = $('#CboIrProjectForList').val();
            //Added by imran on 30-01-2023
            if (BackPageName == "RM_ResourceManagementInfra.aspx") {
                window.location.href = "RM_ResourceManagementInfra.aspx?ProjectID=" + ProjectID + "";
            }
            else {
                window.location.href = "RM_ProjectInfraResource.aspx?ProjectID=" + ProjectID + "";
            }
            //End of comment by imran on 30-01-2023
        });

        //Resquest QueryString Parameter
        function getParameters() {

            var params = {},
                pairs = document.URL.split('?')
                    .pop()
                    .split('&');
            for (var i = 0, p; i < pairs.length; i++) {
                p = pairs[i].split('=');
                params[p[0]] = p[1];
            }
            return params;
        }
        //End of Added By Reshma Chavan on 10th March 2022


        function closeFilterPanel() {
            $("#filterpanel").removeClass('show');
        }
    </script>

</body>

</html>
