<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MDBilling.aspx.vb" Inherits="PbNIT.MDBilling" %>

<!DOCTYPE html>
<html>
     <%CommonFunctions.General.PlotPageHeadTag("Resource Plan Vs Actual")%>
<head>
     <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->

    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />



</head>
        <style type="text/css">
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }

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

        /*Detailpanel*/
        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
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



        /*New css end here*/

        .lightgraybg {
            background: #f5f5f5;
        }

        /*Information table start here*/
        .informationtbl {
            margin-bottom: 15px
        }

            .informationtbl tr th {
                text-align: right;
                font-weight: 500
            }

        body .informationtbl tr td {
            text-align: left
        }

        .informationtbl th, .informationtbl td {
            padding: 2px 4px
        }

        body .informationtbl tr td.pr-3 {
            padding-right: 3em
        }

        table.informationtbl {
            width: 100%
        }

        td.Agpm {
            color: #eb1c24
        }

        .togglerup .collapseup {
            display: block
        }

        .togglerup .collapsedown {
            display: none
        }

        .togglerdown .collapsedown {
            display: block
        }

        .togglerdown .collapseup {
            display: none
        }

        .infoToggler {
            margin: 5px 0 0
        }

        .hideprofitabilityinfo {
            position: absolute;
            right: 10px
        }

        .profitabilityinfopanel .panel.panel-default {
            padding: 0;
            position: relative
        }

        .profitabilityinfopanel .panel-default > .panel-heading {
            padding-right: 35px;
            background: #e7edf0
        }

            .profitabilityinfopanel .panel-default > .panel-heading a:hover, .profitabilityinfopanel .panel-default > .panel-heading a:focus {
                color: #464a4c
            }

            .profitabilityinfopanel .panel-default > .panel-heading a span img {
                opacity: .5
            }

                .profitabilityinfopanel .panel-default > .panel-heading a span img:hover {
                    opacity: 1
                }
        /*Information table End here*/
        .informationtbl td, .informationtbl th {
            vertical-align: top !important;
            font-size: 14px;
            line-height: normal
        }

        .informationtbl tr th {
            min-width: 120px
        }

        tr.totalrow {
            background: #ccc
        }
        .form-inline{display:inline-flex}
        .form-inline .form-group{display:contents}
        .informationtbl th{padding-top:8px}
        .modal-header{display:block}

        .dataTables_paginate {
            margin-top: 10px;
        }
    </style>

<body class="hold-transition skin-blue-light sidebar-mini fixed">

    <div class="bgwhite">

        <div class="col-sm-12 pt-1 pb-1 text-end graybg">
            <h5 class="pgtitle text-start">Project Dashboard Billing</h5>
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
                                        <li>
                                            <label class="customradio">
                                                <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="project2" type="checkbox" name="project2" onchange="cbChange(this)" data-original-title="" title=""> <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                            </label>
                                            <label class="">
                                                <span for="project2" class="radiotextsty filtername">Project 2 and 3</span>
                                            </label>

                                            <div class="issfilter_actiondropdown">
                                                <div class="custom_chckbox_markblue">
                                                    <input id="IssueselproOne" type="checkbox" name="">
                                                    <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproOne" data-original-title="Apply filter"></label>
                                                </div> <span class="edit_filter"><img src="../../../Whizible2.0/../../../Whizible2.0/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
                                                <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                            </div>
                                        </li>
                                        <li>
                                            <label class="customradio">
                                                <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="task" type="checkbox" name="task" onchange="cbChange(this)" data-original-title="" title=""> <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                            </label>
                                            <label class="">
                                                <span for="task" class="radiotextsty">Task and milestones</span>
                                            </label>

                                            <div class="issfilter_actiondropdown">
                                                <div class="custom_chckbox_markblue">
                                                    <input id="IssueselproTwo" type="checkbox" name="">
                                                    <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproTwo" data-original-title="Apply filter"></label>
                                                </div> <span class="edit_filter"><img src="../../../Whizible2.0/../../../Whizible2.0/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
                                                <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                            </div>
                                        </li>
                                        <li>
                                            <label class="customradio">
                                                <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="groupcompany" type="checkbox" name="groupcompany" onchange="cbChange(this)" data-original-title="" title=""> <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                            </label>
                                            <label class="">
                                                <span for="groupcompany" class="radiotextsty">For group company</span>
                                            </label>

                                            <div class="issfilter_actiondropdown">
                                                <div class="custom_chckbox_markblue">
                                                    <input id="IssueselproThree" type="checkbox" name="">
                                                    <label data-bs-container="body" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" for="IssueselproThree" data-original-title="Apply filter"></label>
                                                </div> <span class="edit_filter"><img src="../../../Whizible2.0/../../../Whizible2.0/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
                                                <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                            </div>
                                        </li>
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
                                            <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-target="#Issuesavefilter" data-bs-dismiss="modal">Save and Apply</button>
                                            <button class="btn btnyellow">Apply</button>
                                        </div>
                                        <br />

                                        <div class="row">
                                            <div class="col-sm-4 form-group">
                                                <label>Parameter Group</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm">
                                                            <option>=</option>
                                                            <option><></option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>&nbsp;</option>
                                                            <option>Work Profile</option>
                                                        </select>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-sm-4 form-group">
                                                <label>Parameter Value</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm">
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
                                                        <select class="form-control input-sm">
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
                                                        <select class="form-control input-sm">
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
                <div class=" container-fluid pt-1 pb-1">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-inline">
                                <div class="form-group">
                                    <label for="email">Sales Period : </label>
                                    <select id="PPCselectPro" class="form-control" style="width:200px">
                                        <option>Select Sales Period</option>
                                        <option>Current Financial year</option>
                                        <option>Previous Financial year</option>
                                        <option>2021 / 01</option>
                                        <option>2021 / 02</option>
                                        <option>2021 / 03</option>
                                        <option>2021 / 04</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="email">Business Group : </label>
                                    <select id="PPCustmrselect" class="form-control" style="width:200px">
                                        <option>Select Business Group</option>
                                        <option>Busines Group 01</option>
                                        <option>Busines Group 02</option>
                                        <option>Busines Group 03</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="email">Organization Unit : </label>
                                    <select id="PPCustmrselect" class="form-control" style="width:200px">
                                        <option>Select Organization Unit</option>
                                        <option>Organization Unit 01</option>
                                        <option>Organization Unit 02</option>
                                        <option>Organization Unit 03</option>
                                    </select>
                                </div>

                            </div>
                        </div>

                    </div>

                </div>

                <div class="content pt-0">

                    <table id="dashBillingTbl" class="table table-bordered dashbillingTbllist" style="width:100%;">
                        <thead>
                            <tr>
                                <th class="">&nbsp;</th>
                                <th>&nbsp;</th>
                                <th>No</th>
                                <th>Amount</th>
                                <th>No</th>
                                <th>Amount</th>
                                <th>No</th>
                                <th>Amount</th>
                                <th>No</th>
                                <th>Amount</th>
                                <th>No</th>
                                <th>Amount</th>
                                <th>No</th>
                                <th>Amount</th>
                            </tr>
                            <tr>
                                <th>Company</th>
                                <th>Rotate Currencies</th>
                                <th colspan="2">IRs Made</th>
                                <th colspan="2">Invoices Made</th>
                                <th colspan="2">PDF Files Sent</th>
                                <th colspan="2">Physical Invoice Dispatched</th>
                                <th colspan="2">Softex Forms Required</th>
                                <th colspan="2">Softex Forms Sent</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="compname">Lifeline Systech Solutions</td>
                                <td>
                                    <select class="form-control input-sm">
                                        <option>&nbsp;</option>
                                        <option>INR</option>
                                    </select>
                                </td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">6</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                            </tr>
                            <tr>
                                <td class="compname">Lifeline Systech Solutions</td>
                                <td>
                                    <select class="form-control input-sm">
                                        <option>&nbsp;</option>
                                        <option>INR</option>
                                    </select>
                                </td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">6</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                            </tr>
                            <tr>
                                <td class="compname">Lifeline Systech Solutions</td>
                                <td>
                                    <select class="form-control input-sm">
                                        <option>&nbsp;</option>
                                        <option>INR</option>
                                    </select>
                                </td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">6</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                            </tr>
                            <tr>
                                <td class="compname">Lifeline Systech Solutions</td>
                                <td>
                                    <select class="form-control input-sm">
                                        <option>&nbsp;</option>
                                        <option>INR</option>
                                    </select>
                                </td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">6</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                            </tr>
                            <tr>
                                <td class="compname">Lifeline Systech Solutions</td>
                                <td>
                                    <select class="form-control input-sm">
                                        <option>&nbsp;</option>
                                        <option>INR</option>
                                    </select>
                                </td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">6</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicedashdetail">1</a></td>
                                <td class="text-end">5,220.00 INR</td>
                            </tr>

                        </tbody>
                    </table>
                    <div class="clearfix"></div>



                </div>

            </div>
     

        <!-- Save filter Modal start here-->
        <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="Issuesavrefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end">Filter Name :</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name=""><br />
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow float-start">Save</button>
                                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end">Cancel</button>
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
        <!-- Save filter Modal End here-->
        <!-- Invoice dashboard details Modal start here-->
        <div class="modal custmodal fade" id="invoicedashdetail" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Invoice Dashboard Details</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">

                        <div id="TabGrossProfit" class="tab-pane">
                            <!--Information table start here-->
                            <div class="panel-group profitabilityinfopanel" id="accordion" role="tablist" aria-multiselectable="true">
                                <div class="panel panel-default panel-horizontal lightgraybg">
                                    <div class="panel-heading" role="tab" id="headingThree">
                                        <h4 class="panel-title">
                                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
                                                <span class="hideprofitabilityinfo float-end ml-1">
                                                    <img class="" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="dist/img/close-black.svg" alt="" width="12px" data-original-title="Close Details">
                                                </span>
                                                <span class="infoToggler togglerdown float-end">
                                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                                </span>
                                                IRs made
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                        <div class="panel-body">
                                            <table class="informationtbl mb-0">
                                                <tbody>
                                                    <tr>
                                                        <th>Company</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3"><span class="lmtname">Lifeline Systech Solutions</span></td>

                                                        <th>Business Group</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3">Business Group 01</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Organization Unit</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3"> Organization Unit 01</td>

                                                        <th>Posting Period</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3">31 Oct 2013</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--Information table End here-->

                            <div class="table-responsive">
                                <table class="table table-bordered Irsmadetbl">
                                    <thead>
                                        <tr class="">
                                            <th align="left">Customer</th>
                                            <th class="text-center">No.Of IRs</th>
                                            <th class="text-center">Equiv. INR value</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td align="left"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicesubdashdetail">British Telecommunication</a></td>
                                            <td align="right">5</td>
                                            <td align="right">2,400.00</td>
                                        </tr>
                                        <tr>
                                            <td align="left"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#invoicesubdashdetail">Hitech Systems</a></td>
                                            <td align="right">5</td>
                                            <td align="right">2,980.00</td>
                                        </tr>
                                        <tr class="totalrow">
                                            <td align="left"><strong>Total</strong></td>
                                            <td align="right">10</td>
                                            <td align="right">5,380.00</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>


                        </div>

                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Invoice dashboard details Modal End here-->
        <!-- Invoice sub dashboard details Modal start here-->
        <div class="modal custmodal fade" id="invoicesubdashdetail" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Invoice Dashboard Details</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">


                        <!--Information table start here-->
                        <div class="panel-group profitabilityinfopanel" id="accordion" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default panel-horizontal lightgraybg">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                        <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#invoicesubdetailscollapse" aria-expanded="true" aria-controls="collapseThree">
                                            <span class="hideprofitabilityinfo float-end ml-1">
                                                <img class="" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="dist/img/close-black.svg" alt="" width="12px" data-original-title="Close Details">
                                            </span>
                                            <span class="infoToggler togglerdown float-end">
                                                <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                                <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                            </span>
                                            IRs made
                                        </a>
                                    </h4>
                                </div>
                                <div id="invoicesubdetailscollapse" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                    <div class="panel-body">
                                        <table class="informationtbl mb-0">
                                            <tbody>
                                                <tr>
                                                    <th>Customer</th>
                                                    <td class="colan">:</td>
                                                    <td class="pr-3"><span class="lmtname">British Telecommunication</span></td>

                                                    <th>Company</th>
                                                    <td class="colan">:</td>
                                                    <td class="pr-3"><span class="lmtname">Lifeline Systech Solutions</span></td>
                                                </tr>
                                                <tr>
                                                    <th>Business Group</th>
                                                    <td class="colan">:</td>
                                                    <td class="pr-3">Business Group 01</td>

                                                    <th>Organization Unit</th>
                                                    <td class="colan">:</td>
                                                    <td class="pr-3"> Organization Unit 01</td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!--Information table End here-->

                        <div class="table-responsive">
                            <table class="table table-bordered Irsmadetbl">
                                <thead>
                                    <tr class="">
                                        <th class="text-center">IR ID</th>
                                        <th class="text-center">IR Raised On</th>
                                        <th class="text-start">Description</th>
                                        <th>Currency</th>
                                        <th>Amount</th>
                                        <th>Equiv. INR value</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>5</td>
                                        <td>21 Nov 2021</td>
                                        <td class="text-start">Product - Development Implementation & Training - Domestic</td>
                                        <td>INR</td>
                                        <td class="text-end">0.00</td>
                                        <td class="text-end">0.00</td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td>21 Nov 2021</td>
                                        <td class="text-start">Product - Development Implementation & Training - Domestic</td>
                                        <td>INR</td>
                                        <td class="text-end">0.00</td>
                                        <td class="text-end">0.00</td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td>21 Nov 2021</td>
                                        <td class="text-start">Product - Development Implementation & Training - Domestic</td>
                                        <td>USD</td>
                                        <td class="text-end">0.00</td>
                                        <td class="text-end">0.00</td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td>21 Nov 2021</td>
                                        <td class="text-start">Product - Development Implementation & Training - Domestic</td>
                                        <td>INR</td>
                                        <td class="text-end">0.00</td>
                                        <td class="text-end">0.00</td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td>21 Nov 2021</td>
                                        <td class="text-start">Product - Development Implementation & Training - Domestic</td>
                                        <td>USD</td>
                                        <td class="text-end">0.00</td>
                                        <td class="text-end">0.00</td>
                                    </tr>
                                    <tr class="totalrow">
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td class="text-end">Total Amount</td>
                                        <td class="text-end">0.00</td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>



                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Invoice sub dashboard details Modal End here-->


        <div class="clearfix"></div>
    </div>
         <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>

    <script>

        //$("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

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


        $(document).ready(function () {

        });


        //datatable
        $('#dashBillingTbl').dataTable({
            "scrollY": true,
            "scrollX": true,
            "pageLength": 10,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,

        });

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);
        $('#healthshetprojectList').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

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



        //Graph script start Frome Here

        //Total Task vs Completion Status
        var ctx1 = document.getElementById("CompletionstatusGraph");
        var myChart = new Chart(ctx1, {
            type: 'doughnut',
            data: {
                labels: ["10%", "20%", "30%", "40%", "50%"],
                datasets: [{
                    label: '# 1',
                    data: [8, 7, 10, 15, 12],
                    backgroundColor: [
                        'rgba(235, 28, 36, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        '#afd037',
                        '#4bc0c0',

                    ],
                    borderColor: [
                        '#fff',
                        '#fff',
                        '#fff',
                        '#fff',
                        '#fff',

                    ],
                    borderWidth: 0
                }]
            },
            options: {
                cutoutPercentage: 60,
                responsive: false,
                segmentShowStroke: true,
                legend: {
                    display: true,
                    position: 'right',
                    labels: {
                        fontColor: "#000080",
                    }
                },

            }
        });
        //End Graph

        //Delay in days graph start
        var ctx = document.getElementById("DelayinDayschart").getContext("2d");

        var data = {
            labels: ["1Day", "3Day", "5Day", "7Day", "9Day"],
            datasets: [{
                label: "Delay Count",
                text: "label",
                backgroundColor: "#fbb03b",
                data: [2, 3, 6, 0, 1]
            }]
        };

        var tooltipsLabel = ['1Day', '3Day', '5Day', '7Day', '9Day']
        var myBarChart = new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                title: {
                    display: true,
                    responsive: true,
                    //text: ''
                },
                barValueSpacing: 20,
                scales: {
                    xAxes: [{
                        maxBarThickness: 50,
                        barPercentage: 0.6,
                    }],
                    yAxes: [{
                        maxBarThickness: 20,
                        ticks: {
                            max: 10,
                            min: 0
                        }
                    }]
                },
                responsive: true,


                plugins: {
                    datalabels: {
                        align: 'end',
                        anchor: 'end',
                        //backgroundColor: function (context) {
                        //    return context.dataset.backgroundColor;
                        //},
                        borderRadius: 4,
                        color: 'white',
                        formatter: function (value) {
                            return value + " % ";
                        }
                    }
                }
            }
        });

        //delay in days graph end

        //Monthly Resource Cost graph start
        var ctx = document.getElementById("MonthlyResourceCostChart").getContext("2d");

        var data = {
            labels: ["Feb19", "Nov20", "Dec21"],
            datasets: [{
                label: "Resource Cost",
                text: "label",
                backgroundColor: "#fbb03b",
                data: [1100, 2100, 250]
            }]
        };

        var tooltipsLabel = ['Dhaka', 'Rajshahi', 'NewYork', 'London']
        var myBarChart = new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                title: {
                    display: true,
                    responsive: true,
                    //text: ''
                },
                barValueSpacing: 20,
                scales: {
                    xAxes: [{
                        maxBarThickness: 50,
                        barPercentage: 0.6,
                    }],
                    yAxes: [{
                        maxBarThickness: 20,
                        ticks: {
                            max: 500,
                            min: 0
                        }
                    }]
                },
                responsive: true,


                plugins: {
                    datalabels: {
                        align: 'end',
                        anchor: 'end',
                        //backgroundColor: function (context) {
                        //    return context.dataset.backgroundColor;
                        //},
                        borderRadius: 4,
                        color: 'white',
                        formatter: function (value) {
                            return value + " % ";
                        }
                    }
                }

            }
        });

                        //Monthly Resource Cost graph end





                        //Graph script end here



    </script>

</body>

</html>