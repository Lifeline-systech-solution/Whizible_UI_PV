<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectHealth.aspx.vb" Inherits="PbNIT.ProjectHealth" %>

<!DOCTYPE html>
<html>
       <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("Resource")%>
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    
    
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">--%>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
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

        /*New css start here*/
        .circleIndicator {
        }

        .ciYellow {
            color: #f4cd0f;
        }

        .ciGreen {
            color: #81cf09;
        }

        .ciRed {
            color: #eb1c24;
        }

        #healthshetprojectList tr th:first-child, #healthshetprojectList tr td:first-child {
            text-align: left;
        }

        #healthshetprojectList tr th, #healthshetprojectList tr th {
            text-align: center;
        }

        .informationtbl tr th {
            text-align: right;
            font-weight: 500;
        }

        .informationtbl th, .informationtbl td {
            padding: 2px 4px;
        }

            .informationtbl td.colan {
                padding: 0px;
            }

        .borderbox {
            padding: 15px 10px 10px;
            border: 1px solid #ddd;
            min-height: 91px;
            margin: 0 0 10px;
            border-radius: 4px;
            background: #f5f5f5;
        }
        /*chartbox css start here*/
        .chartbox {
            position: relative;
            border-radius: 4px;
            background: #fff;
            margin-bottom: 20px
        }

            .chartbox .box-body {
                border: 1px solid #d2d6de;
                box-shadow: 0 1px 1px rgba(0,0,0,0.1);
                padding: 15px
            }

            .chartbox .box-header {
                background: #4263c1;
                color: #fff;
                padding: 10px
            }

                .chartbox .box-header h3 {
                    margin: 0;
                    color: #fff;
                    font-size: 16px
                }

        .bluehighlight {
            background: #0d95d3
        }

        .bluelight {
            background: #87c9eb
        }
        /*chartbox css end here*/


        /*New css end here*/
        .modal-header{display:block}
    </style>

<body class="hold-transition skin-blue-light sidebar-mini fixed">
      
        <div class="innerpgiframe">
            <div class="container-fluid pt-1 pb-1 text-end graybg" style="display:inline-flex">
                <h5 class="pgtitle float-start">Project health Sheet</h5>
            </div>

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
                                            </div> <span class="edit_filter"><img src="../../../Whizible2.0/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
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
                                            </div> <span class="edit_filter"><img src="../../../Whizible2.0/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
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
                                            </div> <span class="edit_filter"><img src="../../../Whizible2.0/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
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

            <div class="content pt-1">
                <p><strong>SQERT Details till 04-Sep-2020</strong> <span class="text-end float-end" style="color:red; font-weight:500;"><small>(Activities in Red Indicates Slippage Overdue)</small></span></p>
                <table id="sqertListTbl" class="table table-bordered profiencyTbllist" style="width:100%;">
                    <thead>
                        <tr>
                            <th class="text-start">Project Name</th>
                            <th>Reporting Date</th>
                            <th>Scope</th>
                            <th>Quality</th>
                            <th>Effort</th>
                            <th>Risk</th>
                            <th>Time</th>
                            <th>Project Overview</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="text-start"><a href="javascript:;" onclick="editPHSDetail()">Accellerte</a></td>
                            <td>28 Nov 2019</td>
                            <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>
                            <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>
                            <td>&nbsp;</td>
                            <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>
                            <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>
                            <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>
                        </tr>
                        <tr>
                            <td class="text-start"><a href="javascript:;" onclick="editPHSDetail()">Digital Banking solution Development</a></td>
                            <td>09 Oct 2019</td>
                            <td><i class="fas fa-circle circleIndicator ciRed"></i></td>
                            <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td><i class="fas fa-circle circleIndicator ciRed"></i></td>
                        </tr>
                        <tr>
                            <td class="text-start"><a href="javascript:;" onclick="editPHSDetail()">Entry Gate Automation</a></td>
                            <td>04 Sep 2018</td>
                            <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>
                            <td><i class="fas fa-circle circleIndicator ciRed"></i></td>
                            <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</i></td>
                            <td><i class="fas fa-circle circleIndicator ciRed"></i></td>
                        </tr>
                        <tr class="overviewrow graybglight">
                            <td class="text-start"><strong>OVERVIEW</strong></td>
                            <td>&nbsp;</td>
                            <td><i class="fas fa-circle circleIndicator ciRed"></i></td>
                            <td><i class="fas fa-circle circleIndicator ciRed"></i></td>
                            <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>
                            <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>
                            <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>
                            <td><i class="fas fa-circle circleIndicator ciRed"></i></td>

                        </tr>
                    </tbody>
                </table>
                <div class="clearfix"></div>
                <p><strong>List of Projects which were not locked till 04-Sep-2020</strong></p>


                <table id="healthshetprojectList" class="table table-bordered" style="width:100%;">
                    <thead>
                        <tr>
                            <th class="text-start">Project Name</th>
                            <th width="200">Project Start Date</th>
                            <th width="200">Project End Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Agile Document management System</td>
                            <td>01 Jan 2019</td>
                            <td>31 Dec 2020</td>
                        </tr>
                        <tr>
                            <td>Agile Document management System</td>
                            <td>01 Jan 2019</td>
                            <td>31 Dec 2020</td>
                        </tr>
                        <tr>
                            <td>Agile Document management System</td>
                            <td>01 Jan 2019</td>
                            <td>31 Dec 2020</td>
                        </tr>
                        <tr>
                            <td>Agile Document management System</td>
                            <td>01 Jan 2019</td>
                            <td>31 Dec 2020</td>
                        </tr>
                        <tr>
                            <td>Agile Document management System</td>
                            <td>01 Jan 2019</td>
                            <td>31 Dec 2020</td>
                        </tr>
                        <tr>
                            <td>Agile Document management System</td>
                            <td>01 Jan 2019</td>
                            <td>31 Dec 2020</td>
                        </tr>
                        <tr>
                            <td>Agile Document management System</td>
                            <td>01 Jan 2019</td>
                            <td>31 Dec 2020</td>
                        </tr>
                        <tr>
                            <td>Agile Document management System</td>
                            <td>01 Jan 2019</td>
                            <td>31 Dec 2020</td>
                        </tr>
                        <tr>
                            <td>Agile Document management System</td>
                            <td>01 Jan 2019</td>
                            <td>31 Dec 2020</td>
                        </tr>
                        <tr>
                            <td>Agile Document management System</td>
                            <td>01 Jan 2019</td>
                            <td>31 Dec 2020</td>
                        </tr>
                        <tr>
                            <td>Agile Document management System</td>
                            <td>01 Jan 2019</td>
                            <td>31 Dec 2020</td>
                        </tr>
                        <tr>
                            <td>Agile Document management System</td>
                            <td>01 Jan 2019</td>
                            <td>31 Dec 2020</td>
                        </tr>
                    </tbody>
                </table>
            </div>


            <div class="Resourcedetailpanel">
                <div class="pgdetailinner">
                    <ul class="nav nav-tabs detailsubtabs">
                        <li><a href="#PHSInfo" class="active" data-bs-toggle="tab" aria-expanded="true">PHS Report Info</a><div></div></li>
                        <li class=""><a href="#PHSDetailtabTwo" data-bs-toggle="tab" aria-expanded="true">Key Achievements</a><div></div></li>
                        <li class=""><a href="#PHSDetailtab3" data-bs-toggle="tab" aria-expanded="true">Issue Details</a><div></div></li>
                        <li class=""><a href="#PHSDetailtab4" data-bs-toggle="tab" aria-expanded="true">SQERT</a><div></div></li>
                        <li class=""><a href="#PHSDetailtab5" data-bs-toggle="tab" aria-expanded="true">Milestone</a><div></div></li>
                        <li class=""><a href="#PHSDetailtab6" data-bs-toggle="tab" aria-expanded="true">Active Resource</a><div></div></li>
                        <li class=""><a href="#PHSDetailtab7" data-bs-toggle="tab" aria-expanded="true">Graph</a><div></div></li>
                    </ul>
                    <div class="tab-content">

                        <div id="PHSInfo" class="tab-pane active">
                            <div class="detailsubtabsbtn pb-1 text-end">

                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                            </div>

                            <div class="">
                                <table class="informationtbl" style="width:100%; text-align:center;">
                                    <tbody>
                                        <tr>
                                            <th>Request ID</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start"><span class="lmtname">3510</span></td>


                                            <th>Requested On</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start">11 Aug 2020</td>



                                        </tr>
                                        <tr>
                                            <th>Project</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start"> Training Project</td>

                                            <th>Role</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start">Business Developement Manager</td>


                                        </tr>
                                        <tr>
                                            <th>Business Group</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start"> Service</td>

                                            <th>From Date</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start">01 Jun 2014</td>

                                        </tr>

                                        <tr>
                                            <th>Organization Unit</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start">
                                                Developement
                                            </td>


                                            <th>Workhours Percent</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start">01</td>

                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div id="PHSDetailtabTwo" class="tab-pane">
                            <h5 class="float-start mt-1">Key Achievement in the Reporting Period</h5>
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                            </div>

                            <table class="table table-bordered" style="width:100%;">
                                <thead>
                                    <tr>
                                        <th>Task</th>
                                        <th>Total Planned</th>
                                        <th>completed</th>
                                        <th>To be Completed in Next Month reporting Period</th>
                                        <th>Task Slipping</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Task</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td>Deliverables</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td>Deliverables</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td>Deliverables</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td>Deliverables</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td>Deliverables</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div id="PHSDetailtab3" class="tab-pane">
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                            </div>

                            <table class="table table-bordered" style="width:100%;">
                                <thead>
                                    <tr>
                                        <th colspan="5">Issue details</th>
                                        <th colspan="3">Aging Analysis(Only Open Isssues)</th>
                                        <th>Shown To Customer</th>
                                        <th>Total Overdue Issues</th>
                                    </tr>
                                    <tr>
                                        <th>Issue Type</th>
                                        <th>Open</th>
                                        <th>Closed</th>
                                        <th>Others</th>
                                        <th>Total</th>
                                        <th>Up To 5 Days</th>
                                        <th>5 To 10 Days</th>
                                        <th>More than 10 Days</th>
                                        <th>&nbsp;</th>
                                        <th>&nbsp;</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Change Request</td>
                                        <td>3</td>
                                        <td>0</td>
                                        <td>4</td>
                                        <td>7</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>3</td>
                                        <td>0</td>
                                        <td>1</td>
                                    </tr>
                                    <tr>
                                        <td>Defect</td>
                                        <td>3</td>
                                        <td>0</td>
                                        <td>4</td>
                                        <td>7</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>3</td>
                                        <td>0</td>
                                        <td>1</td>
                                    </tr>
                                    <tr>
                                        <td>Enhancement</td>
                                        <td>3</td>
                                        <td>0</td>
                                        <td>4</td>
                                        <td>7</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>3</td>
                                        <td>0</td>
                                        <td>1</td>
                                    </tr>
                                    <tr>
                                        <td>Project Issue</td>
                                        <td>3</td>
                                        <td>0</td>
                                        <td>4</td>
                                        <td>7</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>3</td>
                                        <td>0</td>
                                        <td>1</td>
                                    </tr>
                                    <tr class="graybglight">
                                        <td><strong>Total</strong></td>
                                        <td>19</td>
                                        <td>5</td>
                                        <td>8</td>
                                        <td>32</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>9</td>
                                        <td>0</td>
                                        <td>4</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div id="PHSDetailtab4" class="tab-pane">
                            <div class="detailsubtabsbtn pb-1 text-end">

                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                            </div>
                            <table class="table table-bordered" style="width:100%;">
                                <thead>
                                    <tr>
                                        <th width="100">Title</th>
                                        <th width="100">Value</th>
                                        <th width="100">Rating</th>
                                        <th width="100">Trend</th>
                                        <th class="text-start">Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Scope</td>
                                        <td>20</td>
                                        <td><i class="fas fa-circle circleIndicator ciRed"></i></td>
                                        <td><i class="fas fa-arrows-alt-h"></i></td>
                                        <td class="text-start">Scope Completion</td>
                                    </tr>
                                    <tr>
                                        <td>Quality</td>
                                        <td>30</td>
                                        <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>
                                        <td><i class="fas fa-arrows-alt-h"></i></td>
                                        <td class="text-start">Quality Status</td>
                                    </tr>
                                    <tr>
                                        <td>Effort</td>
                                        <td>-5</td>
                                        <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>
                                        <td><i class="fas fa-arrows-alt-h"></i></td>
                                        <td class="text-start">Effort details</td>
                                    </tr>
                                    <tr>
                                        <td>Risk</td>
                                        <td>-1</td>
                                        <td><i class="fas fa-circle circleIndicator"></i></td>
                                        <td><i class="fas fa-arrows-alt-h"></i></td>
                                        <td class="text-start">Risk In The Project</td>
                                    </tr>
                                    <tr>
                                        <td>Time</td>
                                        <td>19</td>
                                        <td><i class="fas fa-circle circleIndicator ciRed"></i></td>
                                        <td><i class="fas fa-arrows-alt-h"></i></td>
                                        <td class="text-start">Time Ution</td>
                                    </tr>
                                    <tr>
                                        <td>Scope</td>
                                        <td>20</td>
                                        <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>
                                        <td><i class="fas fa-arrows-alt-h"></i></td>
                                        <td class="text-start">Scope Completion</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div id="PHSDetailtab5" class="tab-pane ">
                            <div class="detailsubtabsbtn pb-1 text-end">

                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                            </div>
                            <table class="table table-bordered" style="width:100%;">
                                <thead>
                                    <tr>
                                        <th>Milestone Name</th>
                                        <th>Ready For Billing</th>
                                        <th>Amount</th>
                                        <th>planned Start Date</th>
                                        <th>planned Completion Date</th>
                                        <th>Actual Start Date</th>
                                        <th>Actual End Date</th>
                                        <th>Slippage(In Days)</th>
                                        <th>Milestone Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Milestone 1</td>
                                        <td>-</td>
                                        <td>100</td>
                                        <td>1 Jan 2018</td>
                                        <td>31 Dec 2018</td>
                                        <td>2 Feb 2018</td>
                                        <td>31 Mar 2019</td>
                                        <td>4</td>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <td>Milestone 2</td>
                                        <td>-</td>
                                        <td>300</td>
                                        <td>1 Jan 2018</td>
                                        <td>31 Dec 2018</td>
                                        <td>2 Feb 2018</td>
                                        <td>31 Mar 2019</td>
                                        <td>6</td>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <td>Milestone 3</td>
                                        <td>-</td>
                                        <td>700</td>
                                        <td>1 Jan 2018</td>
                                        <td>31 Dec 2018</td>
                                        <td>2 Feb 2018</td>
                                        <td>31 Mar 2019</td>
                                        <td>2</td>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <td>Milestone 4</td>
                                        <td>-</td>
                                        <td>500</td>
                                        <td>1 Jan 2018</td>
                                        <td>31 Dec 2019</td>
                                        <td>2 Feb 2018</td>
                                        <td>31 Mar 2019</td>
                                        <td>8</td>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <td>Milestone 5</td>
                                        <td>-</td>
                                        <td>600</td>
                                        <td>1 Jan 2019</td>
                                        <td>31 Dec 2019</td>
                                        <td>2 Feb 2018</td>
                                        <td>31 Mar 2020</td>
                                        <td>2</td>
                                        <td>-</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div id="PHSDetailtab6" class="tab-pane ">
                            <div class="detailsubtabsbtn pb-1 text-end">

                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                            </div>
                            <table class="table table-bordered" style="width:100%;">
                                <thead>
                                    <tr>
                                        <th width="400">Resource</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Work(Hrs)</th>
                                        <th>Actual work(hrs)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>John C</td>
                                        <td>01 Jan 2020</td>
                                        <td>31 Dec 2020</td>
                                        <td>7.00</td>
                                        <td>0.00</td>
                                    </tr>
                                    <tr>
                                        <td>Mac Henry</td>
                                        <td>01 mar 2019</td>
                                        <td>31 Apr 2019</td>
                                        <td>4.00</td>
                                        <td>1.00</td>
                                    </tr>
                                    <tr>
                                        <td>Donald D</td>
                                        <td>01 Feb 2018</td>
                                        <td>31 Nov 2018</td>
                                        <td>5.00</td>
                                        <td>2.00</td>
                                    </tr>
                                    <tr>
                                        <td>Lawrel C</td>
                                        <td>01 Jan 2019</td>
                                        <td>31 Dec 2019</td>
                                        <td>8.00</td>
                                        <td>3.00</td>
                                    </tr>
                                    <tr>
                                        <td>Ken K</td>
                                        <td>01 Jan 2018</td>
                                        <td>31 Dec 2018</td>
                                        <td>6.00</td>
                                        <td>2.00</td>
                                    </tr>
                                    <tr>
                                        <td>Sam L</td>
                                        <td>01 Jan 2019</td>
                                        <td>31 Dec 2019</td>
                                        <td>9.00</td>
                                        <td>5.00</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div id="PHSDetailtab7" class="tab-pane ">
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                            </div>

                            <div class="graphwrapper">
                                <div class="row px-1">
                                    <div class="col-sm-4 chartbox">
                                        <div class="box box-panel box-solid">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3>Total Tasks V/s Completion Status</h3>
                                            </div>
                                            <div class="box-body text-center">
                                                <canvas id="CompletionstatusGraph" height="245"></canvas>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4 chartbox">
                                        <div class="box box-panel box-solid">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3>Total Tasks V/s Delay in Days(By Project)</h3>
                                            </div>
                                            <div class="box-body text-center">
                                                <canvas id="DelayinDayschart" height="200"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 chartbox">
                                        <div class="box box-panel box-solid">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3>Monthly Resource Cost</h3>
                                            </div>
                                            <div class="box-body text-center">
                                                <canvas id="MonthlyResourceCostChart" height="200"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
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

            <div class="clearfix"></div>

        </div>


       <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>


<script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<%--<script src="../../../Whizible2.0-new/plugins/chartjs/chartjs-plugin-datalabels.js"></script>--%>

    <script>

        //$("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        function editPHSDetail() {
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 20
            }, 'fast');
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
        $('#healthshetprojectList').dataTable({
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
        //$('#healthshetprojectList').DataTable().columns.adjust().draw();

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
            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 0);
        });

        //setTimeout(function () {
        //    $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        //}, 0);

        //function resizeSection() {
        //    var tblheight = $(window).height();
        //    $('.dataTables_scrollBody').css({ 'height': tblheight - 450, "overflow-y": "auto" });

        //    var tblheight = $(window).height();
        //    $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        //}
        //$(window).on("load resize scroll", function (e) {
        //    resizeSection(this);
        //    setTimeout(function () {
        //        $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        //    }, 0);
        //});

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