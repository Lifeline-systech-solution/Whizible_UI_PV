<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_ProjectInfraResource.aspx.vb" Inherits="PbNIT.RM_ProjectInfraResource" %>

<!DOCTYPE html>
<html>
       <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head>
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>


</head>
        <style type="text/css">
        a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }

        .filter.pull-right {
            margin: 2px 0 0 8px;
        }

        .JStableOuter > table {
            overflow: initial;
        }

        .SRtopfilter ul.tab-slider--tabs {
            background: #f5f5f5;
            color: #464a4c;
        }

            .SRtopfilter ul.tab-slider--tabs li {
                color: #464a4c;
            }

        .SRtopfilter .tab-slider--tabs:after, .SRtopfilter .tab-slider--trigger.active {
            color: #fff;
        }

        .SRtopfilter .tab-slider--tabs {
            margin-top: 5px;
            height: 28px;
        }

        .SRtopfilter .tab-slider--trigger {
            padding: 8px 20px 8px 15px;
        }

        .PRweekdaytbl td span {
            display: block;
        }

        .multiselect-container {
            max-width: 260px;
        }



        .multiselect-filter .input-group .multiselect-clear-filter {
            padding: 6px 12px;
        }


        .projectallocationpanel .custom_chckbox label:before {
            margin-right: 0;
        }

        /*.JStableOuter > table > tbody > tr > td:nth-child(2) {
            position: relative;
            z-index: 1;            
            height: 40px;
            background-color: #fff;
            box-shadow: 0 0px 1px 0px #ddd;
            text-align: left;
        }*/
        .PRsubinfotbl td {
            position: relative;
            text-align: center;
            min-width: 30px;
            padding: 0 0px;
            /*width: auto;*/
            height: 53px;
            border: 1px solid #ccc;
        }

        .JStableOuter > table > tbody > tr > td {
            min-width: auto;
        }

        .PRweekdaytbl td::after {
            top: -3px;
            z-index: 1;
        }

        .PRweekdaytbl td {
            min-width: 30px;
            padding:0
        }

        .JStableOuter > table > tbody > tr > td td.PRstatusLightblue {
            background: #bcd0e8;
        }

        span.PRhrs.PRhrsSkyblue {
            background: #1359a6;
            display: block;
            color: #fff;
            margin: 0 -5px;
            text-align: center;
            padding: 0 5px;
        }



        /**/
        .ui-widget.ui-widget-content {
            z-index: 9999 !important;
        }

        .sortbyrole div.col-sm-4 {
            padding-left: 0px;
            font-size: 13px;
        }

        .SRtopfilter ul.tab-slider--tabs {
            margin-top: 0px;
        }

        .SRtopfilter ul.tab-slider--tabs {
            margin: 0 auto;
            float: none;
        }

        .SRtopfilter .tab-slider--trigger {
            min-width: 160px;
        }

        .weeklyanddaily.availNDallocate.text-center {
            width: 330px;
            margin: 0 auto;
        }

        #filterpanel .cust_tabpanel .nav-tabs > li > a:focus {
            color: #fff;
        }

        .projectallocationpanel .JStableOuter > table > tbody > tr > td:nth-child(1) {
            min-width: 260px;
        }

        #MEdetails .control-label, #basicfilters label {
            line-height: 18px;
            text-align: right;
        }

        .PRrolename .smallsubtext {
            margin-bottom: 0px;
            padding: 0px 5px 0px 6px;
        }

        .edit_filter {
            cursor: pointer;
        }

        .JStableOuter > table.PRtable > tbody > tr > td:last-child {
            padding: 0 !important;
        }

        table.PRsubinfotbl {
            width: 100%;
        }

        #CRTable > tr:first-child > td {
            background: #e7edf0 !important;
        }

        a.IRR_Arrow.IRRInfraPrevMonth.pull-left img {
            transform: rotate(275deg);
        }

        a.IRR_Arrow.IRRInfraPrevMonth.pull-right img {
            transform: rotate(90deg);
        }

        .IRR_Arrow img {
            width: 16px;
        }

        .LabelBooked {
            background: #eb1c24;
            color: #fff;
        }

        .Labelorange {
            background: #fbb03b;
            color: #fff;
        }

        .LabelForSat {
            background: #C0C0C0;
            color: #000;
        }

        ul.dropdownlinks {
            box-shadow: 0px 0px 5px 0px #000;
        }

        table.PRweekdaytbl {
            color: #000;
            background: #e7edf0;
            min-height: 40px;
        }

        .tooltip {
            z-index: 9999;
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
        /*New css*/
        .PRweekdaytbl td::after {
            height: calc(100vh - 51.5vh);
        }

        .DisableContent {
            pointer-events: none;
            opacity: 0.5;
        }

        .clsShowHide {
            display: none !important;
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
        /*Added by Reshma Chavan content 8th Dec 2021 form page header*/
        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }
        #IRRmodal .form-group{display:flex;}
        .PRrolename a.projectCRmenu{background:none}
       #IMchngAllocationModal .modal-body .form-group{display:inline-flex} 
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodyProjectInfraResource-group">

    <!-- Main Header -->
    <!-- Content Wrapper. Contains page content -->
    <div class="bgwhite resource_allocation">

        <div class="pt-1 pb-1 graybg row px-2">
            <div class="col-sm-3">
                <h5 class="pgtitle pull-left">Project Infrastructure Resource</h5>
            </div>
            <div class="col-sm-9">
                <div class="text-right" style="padding-top: 5px;">
                    <a href="javascript:;" data-bs-toggle="modal" class="btn borderbtn" id="BtnResourceRequest" onclick="IrOpenBookRequest()">Resource Request</a>
                    <%--Added by imran Query String for back page on 15-12-2021--%>
                    <%--<a href="RM_IrRequestApproval.aspx?Flag=True" class="btn borderbtn">Requested Resource</a>--%>
                    <a href="#" class="btn borderbtn" onclick="OpenIrRequestApproval()">Requested Resource</a>
                    <%--End Commented by imran 15-12-2021--%>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>


        <div class="pt-1 pb-1 container-fluid">
            <input type="hidden" id="hdnInfraInputDate" name="hdnInfraInputDate">
            <ul class="nav nav-tabs main_graybgtbs">
                <li>
                    <a href="#TabProAllocation" class="active" role="tab" data-bs-toggle="tab">Project Allocation</a>
                </li>
                <li class="">
                    <a href="#TabProAvailability" role="tab" data-bs-toggle="tab" onclick="IrGetAvalilableList()">Availability</a>
                </li>
            </ul>
        </div>

        <!-- Main content -->
        <section class="content">

            <div class="tab-content">
                <div id="TabProAllocation" class="tab-pane active">
                    <div class="bhwhite">
                        <div class="row pb-1">
                            <div class="col-sm-3">
                                <% CommonFunctions.HTMLControls.DrawComboBox("CboIrProjectForList", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee " & Convert.ToInt32(Session("intUserId").ToString()),,, "class='form-control'  onChange='javascript:CboIrProjectForList_OnChange(this.value);'", False,,) %>
                            </div>
                            <div class="col-sm-4">&nbsp;</div>
                        </div>
                        <div class="projectallocationpanel">
                            <div class="JStableOuter">
                                <table id="table1" class="PRtable ProAllocationTbl">
                                    <thead>
                                    </thead>
                                    <tbody id="CRTable">
                                        <tr>
                                            <td class="text-left dropdown PRrolename" style="min-width:20%">
                                                <input type="search" class="form-control" value="" id="txtSearchAllocationResource" placeholder="search" style="min-width:200px">
                                            </td>
                                            <td class="text-left dropdown PRrolename" style="min-width:80%">
                                                <div class="tblmnthname" style="text-align:center;">
                                                    <a href="#" class="IRR_Arrow IRRInfraPrevMonth pull-left">
                                                        <%--Commented & Added By Dipali V On 28th March 2023 For Tooltip issue--%>
                                                        <%--<img class="uparrow" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Previous Month" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="" data-original-title="Previous Month" onclick="GetNextPrevMonth('Prev',1)" ></a>--%>
                                                        <img class="uparrow" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Previous Month" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="" data-original-title="Previous Month" onclick="GetNextPrevMonth('Prev',1)" ></a>
                                                    <label id="lblProjectAllocationCurrentMOnth"></label>
                                                    <a href="javascript:;" class="IRR_Arrow IRRInfraPrevMonth pull-right">
                                                        <%--Commented & Added By Dipali V On 28th March 2023 For Tooltip issue--%>
                                                        <%--<img class="uparrow" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Next Month" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Next Month" onclick="GetNextPrevMonth('Next',1)"></a>--%>
                                                        <img class="uparrow" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Next Month" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Next Month" onclick="GetNextPrevMonth('Next',1)"></a>
                                                </div>
                                            </td>

                                        </tr>
                                        <tr>

                                            <td class="text-left sortbyrole">
                                                <div class="col-sm-4">
                                                    <label id="lblProjectTotalAllocation"></label>
                                                    Resources
                                                </div>
                                                <div class="col-sm-8">
                                                </div>
                                            </td>
                                            <td class="p-0" style="width: 77%;";>
                                                <table class="PRweekdaytbl" width="100%" cellspacing="0" cellpadding="10">
                                                    <tbody id="IrProjectallocatedTbodyDayHeader">
                                                    </tbody>
                                                </table>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td colspan="32">
                                                <input type="hidden" id="hdnInfraAllocationMonthDate" name="hdnInfraAllocationMonthDate">
                                                <table id="IrPRsubinfotbl" class="PRsubinfotbl">
                                                    <tbody id="IrProjectallocatedTbodyDayRow">
                                                       <tr>
                                                           <td  colspan="32" >Please Select Project </td> 
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>


                                        </tr>

                                    </tbody>
                                </table>

                               <%-- <div id="pagination" class="pull-right"></div>--%>
                                <div class="clearfix"></div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div id="TabProAvailability" class="tab-pane">
                    <div class="bhwhite">

                        <div class="pull-right">
                            <!--<div class="filter pull-right resourcefltr ml-1" style="margin-top:-55px;">

                                    <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Advanced Filter" autocomplete="off" class="collapsed" aria-expanded="false">
                                        <i class="fas fa-filter" data-bs-toggle="tooltip" data-original-title="Filter"></i>
                                    </button>
                                </div>
                                <a href="javascript:;" class="clearalllink pull-right" style="" onclick="clearAll" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-placement="bottom" title=""><strong>Clear All</strong></a>-->

                        </div>

                        <!--filter panel-->
                        <!--<div id="filterpanel" class="filterpanel collapse">
                                <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                                    <div class="cust_tabpanel">
                                        <ul class="nav nav-tabs">
                                            <li class="dropdown">
                                                <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">My Filters  <span class="caret"></span></a>
                                                <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                                    <li>
                                                        <label class="customradio">
                                                            <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-placement="bottom" id="project2" type="checkbox" name="project2" onchange="cbChange(this)" data-original-title="" title=""> <span data-bs-toggle="tooltip" data-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                                        </label>
                                                        <label class="">
                                                            <span for="project2" class="radiotextsty filtername">Project 2 and 3</span>
                                                        </label>

                                                        <div class="issfilter_actiondropdown">
                                                            <div class="custom_chckbox_markblue">
                                                                <input id="IssueselproOne" type="checkbox" name="">
                                                                <label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" for="IssueselproOne" data-original-title="Apply filter"></label>
                                                            </div> <span class="edit_filter"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" data-original-title="Edit filter"></span>
                                                            <span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <label class="customradio">
                                                            <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-placement="bottom" id="task" type="checkbox" name="task" onchange="cbChange(this)" data-original-title="" title=""> <span data-bs-toggle="tooltip" data-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                                        </label>
                                                        <label class="">
                                                            <span for="task" class="radiotextsty">Task and milestones</span>
                                                        </label>

                                                        <div class="issfilter_actiondropdown">
                                                            <div class="custom_chckbox_markblue">
                                                                <input id="IssueselproTwo" type="checkbox" name="">
                                                                <label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" for="IssueselproTwo" data-original-title="Apply filter"></label>
                                                            </div> <span class="edit_filter"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" data-original-title="Edit filter"></span>
                                                            <span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <label class="customradio">
                                                            <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-placement="bottom" id="groupcompany" type="checkbox" name="groupcompany" onchange="cbChange(this)" data-original-title="" title=""> <span data-bs-toggle="tooltip" data-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                                        </label>
                                                        <label class="">
                                                            <span for="groupcompany" class="radiotextsty">For group company</span>
                                                        </label>

                                                        <div class="issfilter_actiondropdown">
                                                            <div class="custom_chckbox_markblue">
                                                                <input id="IssueselproThree" type="checkbox" name="">
                                                                <label data-container="body" data-bs-toggle="tooltip" data-placement="bottom" title="" for="IssueselproThree" data-original-title="Apply filter"></label>
                                                            </div> <span class="edit_filter"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" data-original-title="Edit filter"></span>
                                                            <span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
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
                                                    <div class="fscroll">
                                                        <div class="row">
                                                            <div class="col-sm-6 form-group">
                                                                <label class="col-sm-4">Infra resource</label>
                                                                <div class="col-sm-8">
                                                                    <div class="row">
                                                                        <div class="col-xs-4">
                                                                            <select class="form-control input-sm">
                                                                                <option>=</option>
                                                                                <option><></option>

                                                                            </select>
                                                                        </div>
                                                                        <div class="col-sm-8 pl-0">
                                                                            <select class="form-control input-sm">
                                                                                <option>Select Infra Resource</option>
                                                                                <option>&nbsp;</option>
                                                                                <option>&nbsp;</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-6 form-group">
                                                                <label class="col-sm-4">Project Name</label>
                                                                <div class="col-sm-8">
                                                                    <div class="row">
                                                                        <div class="col-xs-4">
                                                                            <select class="form-control input-sm">
                                                                                <option>Contains</option>
                                                                                <option>Ends With</option>
                                                                                <option>Exact Word</option>
                                                                                <option>Not Contains</option>
                                                                                <option>Starts With</option>
                                                                            </select>
                                                                        </div>
                                                                        <div class="col-sm-8 pl-0">
                                                                            <input type="text" class="form-control input-sm" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="clearfix"></div>

                                                            <div class="col-sm-6 form-group">
                                                                <label class="col-sm-4">From Date</label>
                                                                <div class="col-sm-8">
                                                                    <div class="row">
                                                                        <div class="col-xs-4">
                                                                            <select class="form-control input-sm">
                                                                                <option>=</option>
                                                                                <option><=</option>
                                                                                <option><></option>
                                                                                <option>=</option>
                                                                                <option>></option>
                                                                                <option>>=</option>
                                                                            </select>
                                                                        </div>
                                                                        <div class="col-sm-8 pl-0">
                                                                            <div class="input-group">
                                                                                <input id="PIRFltrFromDatefield" type="text" class="form-control input-sm">
                                                                                <span class="input-group-btn">
                                                                                    <button class="btn btncalendar" type="button" style="height:30px;"><i class="fas fa-calendar-alt"></i></button>
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
                                                                        <div class="col-xs-4">
                                                                            <select class="form-control input-sm">
                                                                                <option>=</option>
                                                                                <option><=</option>
                                                                                <option><></option>
                                                                                <option>=</option>
                                                                                <option>></option>
                                                                                <option>>=</option>
                                                                            </select>
                                                                        </div>
                                                                        <div class="col-sm-8 pl-0">
                                                                            <div class="input-group">
                                                                                <input id="PIRFltrToDatefield" type="text" class="form-control input-sm">
                                                                                <span class="input-group-btn">
                                                                                    <button class="btn btncalendar" type="button" style="height:30px;"><i class="fas fa-calendar-alt"></i></button>
                                                                                </span>
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
                            </div>-->
                        <!--end filter panel-->

                        <div class="projectallocationpanel">
                            <div class="JStableOuter">
                                <table id="tablavailable" class="PRtable proavailibilityTbl">
                                    <tbody>
                                        <tr>
                                            <td class="">
                                                <input type="search" class="form-control" value="" id="txtSearchAvailable" placeholder="Enter infra name ">
                                            </td>
                                            <td>
                                                <div class="tblmnthname" style="text-align:center">
                                                    <a href="javascript:;" class="IRR_Arrow IRRInfraPrevMonth pull-left">
                                                      <%--  Commented & Addeed By Dipali V On 29th March 2023 For Tooltip Issue--%>
                                                        <img class="uparrow" data-bs-toggle="tooltip"  data-bs-placement="top" data-bs-container="body" title="Previous Month" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="" data-original-title="Previous Month" onclick="GetNextPrevMonth('Prev',0)"></a> <label id="lblAvailableCurrentMOnth" ></label> <a href="javascript:;" class="IRR_Arrow IRRInfraPrevMonth pull-right">
                                                        <%--<img class="uparrow" data-toggle="tooltip"  data-placement="top" data-container="body" title="Previous Month" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="" data-original-title="Previous Month" onclick="GetNextPrevMonth('Prev',0)"></a> <label id="lblAvailableCurrentMOnth" ></label> <a href="javascript:;" class="IRR_Arrow IRRInfraPrevMonth pull-right">--%>
                                                        <%--<img class="uparrow" data-bs-toggle="tooltip" data-placement="top" data-container="body" title="Next Month" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Next Month" onclick="GetNextPrevMonth('Next',0)"></a>--%>
                                                        <img class="uparrow" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Next Month" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Next Month" onclick="GetNextPrevMonth('Next',0)"></a>
                                                        <%--  End of Commented & Addeed By Dipali V On 29th March 2023 For Tooltip Issue--%>
                                                    </div>
                                            </td>

                                        </tr>
                                        <tr>

                                            <td class="text-left sortbyrole">
                                                <div class="col-sm-4">
                                                    <label id="lblTotalAvailable"></label>
                                                    Resources
                                                </div>
                                                <div class="col-sm-8">
                                                </div>
                                            </td>
                                            <td>
                                                <table class="PRweekdaytbl" width="100%" cellspacing="0" cellpadding="10">
                                                    <tbody id="IrAvailableTbodyDayHeader">
                                                    </tbody>
                                                </table>
                                            </td>

                                        </tr>
                                        <tr class="pgrow">
                                            <td colspan="32">
                                                <input type="hidden" id="hdnInfraAvailableMonthDate" name="hdnInfraAvailableMonthDate">
                                                <table id="tblIrAvailable" class="PRsubinfotbl">

                                                    <tbody id="IrAvailableTbodyDayRow">
                                                    </tbody>
                                                </table>
                                            </td>

                                    </tbody>
                                </table>

                               <%-- <div id="pagination2" class="pull-right"></div>--%>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="clearfix"></div>



        </section>
        <div class="modal custmodal  fade" id="bulkallocation" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Allocation details</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="form-group">
                                <label class="col-sm-4 text-right">Resources</label>
                                <div class="col-sm-8">
                                    <div class="inputtags">
                                        <input id="" type="text" class="form-control" rows="3" value="" />
                                    </div>

                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 text-right">Project (pre-populated)</label>
                                <div class="col-sm-8">
                                    <select class="form-control selectpicker">
                                        <option>Select Project</option>
                                        <option>Timesheet</option>
                                        <option>Help desk</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 text-right">Plan Start Date</label>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <input id="ADPlanStartDate" type="text" class="form-control" value="June 08 2018">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 text-right">Plan End Date</label>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <input id="ADPlanEndDate" type="text" class="form-control" value="June 21 2018">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 text-right">Resource Status</label>
                                <div class="col-sm-8">
                                    <select class="form-control selectpicker">
                                        <option>Retrive</option>
                                        <option>Buffor</option>
                                        <option>Shadow</option>
                                    </select>
                                </div>
                            </div>

                            <br>
                            <div class="form-group">&nbsp;</div>
                            <div class="form-group text-center">
                                <button class="btn borderbtn borderbtnfill" data-bs-dismiss="modal">Allocate</button>
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <!--modal-end-here-->
        <!--Infra resource-request modal Start-->
        <div class="modal custmodal  fade" id="IRRmodal" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Resource Request</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="form-group">
                                <label class="col-sm-4 text-right required">Select Resource</label>
                                <div class="col-sm-8">
                                    <div class="inputtags">
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboIrResource", "usp_Whizible2_Sel_tbl_RM_InfraResourceMaster",,, "class='form-control issueselectprojects' onChange='javascript:CboIrResource_OnChange(this.value);'",,,) %>
                                    </div>

                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 text-right required" style="white-space:pre!important;">Project (pre-populated)</label>
                                <div class="col-sm-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("CboIrProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee " & Convert.ToInt32(Session("intUserId").ToString()),,, "class='form-control'", False, ) %>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 text-right required">Start Date</label>
                                <div class="col-sm-8">

                                    <div class="input-group datefielddiv">
                                        <%--<input id="txtIrStartdate" type="text" class="form-control" value="">--%>
                                          <% CommonFunctions.HTMLControls.DrawTextBox("txtIrStartdate", "txtIrStartdate", "form-control",,,,,,, True, "White",, "autocomplete='Off'") %>
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 text-right required">End Date</label>
                                <div class="col-sm-8">
                                    <div class="input-group datefielddiv">
                                        <%--<input id="txtIrEnddate" type="text" class="form-control" value="">--%>
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtIrEnddate", "txtIrEnddate", "form-control",,,,,,, True, "White",, "autocomplete='Off'") %>
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>

                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 text-right required">Quantity</label>
                                <div class="col-sm-8 form-inline">
                                    <div class="form-group">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtIrQuantity", "txtIrQuantity", "form-control", widthInPixel:=0, maxLength:=5) %>
                                        <%--<input id="txtIrQuantity" type="text" class="form-control" name="" maxlength="5">--%>
                                        <%--Commented And Added By Reshma Chavan on 2nd Feb 2022--%>
                                       <%-- Available Qty. :--%>
                                             <%--<label id="lblIrAvailableQuantity" class="cllblIrAvailableQuantity"></label>--%>
                                        <%CommonFunctions.HTMLControls.DrawTextBox("lblIrAvailableQuantity", "lblIrAvailableQuantity",, IsHidden:=True, EnableHTMLEncode:=True) %>
                                       <%--End of Commented And Added By Reshma Chavan on 2nd Feb 2022--%>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">&nbsp;</div>
                            <div class="text-center">
                                <button class="btn borderbtn borderbtnfill" onclick="IrBookResource(0)">Book</button>
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>


        <!--modal_start_here-->
        <div class="modal custmodal  fade" id="IRRmodal" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Resource request</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <ul class="nav nav-tabs popupboxtabs">
                            <li class="active">
                                <a href="#Rrequesttab" data-bs-toggle="tab">Request</a>
                            </li>
                            <li class="">
                                <a href="#Rskillsettab" data-bs-toggle="tab">Skillset</a>
                            </li>
                        </ul>
                        <div class="tab-content ">
                            <div class="tab-pane active" id="Rskillsettab">
                                <div class="row">
                                    <div class="form-group">
                                        <label class="col-sm-3">Skills</label>
                                        <div class="col-sm-9">
                                            <div class="inputtags">
                                                <input id="resourcetaglist" type="text" class="form-control" rows="3" value="Test1,Test2, test3, test4, ThisIsABigVeryBigTest" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3">Experience</label>
                                        <div class="col-sm-9">
                                            <div class="form-inline experience_duration">
                                                <div class="for-group">
                                                    <input type="text" id="Expyearfrom" class="form-control" value="0">
                                                    <span>to</span>
                                                    <input type="text" class="form-control" id="Expyearfrom" value="5">Years
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3">Proficiency</label>
                                        <div class="col-sm-9 proficiency">
                                            <div class="custom_chckbox">
                                                <input type="checkbox" id="ffresher" class="chcktbl">
                                                <label for="ffresher">Fresher</label>
                                            </div>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" id="fImidiate" class="chcktbl">
                                                <label for="fImidiate">Imidiate</label>
                                            </div>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" id="fAdvance" class="chcktbl">
                                                <label for="fAdvance">Advanced</label>
                                            </div>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" id="fMaster" class="chcktbl">
                                                <label for="fMaster">Master</label>
                                            </div>
                                        </div>
                                    </div>
                                    <br>
                                    <div class="form-group">&nbsp;</div>
                                    <div class="form-group text-center">
                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                        <button class="btn btnyellow" data-bs-dismiss="modal">Next</button>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="Rrequesttab">
                                <div class="row">
                                    <div class="form-group">
                                        <label class="col-sm-4">Select Project role</label>
                                        <div class="col-sm-8">
                                            <select class="form-control selectpicker">
                                                <option>Whizible</option>
                                                <option>Timesheet</option>
                                                <option>Help desk</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4">No. of resources</label>
                                        <div class="col-sm-8 form-inline">
                                            <div class="form-group">
                                                <input type="text" class="form-control" value="06">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4">Configuration</label>
                                        <div class="col-sm-8">
                                            <select class="form-control selectpicker">
                                                <option>Select</option>
                                                <option></option>
                                                <option></option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4">Start date and end date</label>
                                        <div class="col-sm-8">
                                            <div class="input-group-box">
                                                <div class="input-group" id="DateDemo">
                                                    <input data-bs-toggle="tooltip" data-placement="top" title="Select week date" class="form-control" type="text" id="weekPicker3" value="" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4">Works hours</label>
                                        <div class="col-sm-8 form-inline">
                                            <div class="form-group">
                                                <input type="text" class="form-control" value="06">
                                            </div>
                                            type
                                                <div class="form-group">
                                                    <select class="form-control selectpicker">
                                                        <option>Per day</option>
                                                        <option></option>
                                                        <option></option>
                                                    </select>
                                                </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4">Status</label>
                                        <div class="col-sm-8 form-inline">
                                            <div class="form-group">
                                                <select class="form-control selectpicker">
                                                    <option>Select status</option>
                                                    <option></option>
                                                    <option></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4">Reporting to</label>
                                        <div class="col-sm-8 form-inline">
                                            <div class="form-group">
                                                <select class="form-control selectpicker">
                                                    <option>Billable</option>
                                                    <option></option>
                                                    <option></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4">Responsibility</label>
                                        <div class="col-sm-8">
                                            <textarea class="form-control"></textarea>
                                            <br />
                                            <a href="#">Add comment</a>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4">&nbsp;</label>
                                        <div class="col-sm-8">
                                            <div class="file_attach">
                                                <form>
                                                    <input type="file" multiple>
                                                    <p>Attache file or drop here</p>
                                                    <button type="submit">Upload</button>
                                                </form>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <br>
                                    <div class="form-group">&nbsp;</div>
                                    <div class="form-group text-center">
                                        <button class="btn borderbtn borderbtnfill" data-bs-dismiss="modal">Request</button>
                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
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
        <!--modal_end_here-->
    </div>
    <!-- /.content-wrapper -->

    <!--Changeallocation status-->
    <div class="modal custmodal  fade" id="IMchngAllocationModal" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true">
        <input type="hidden" id="hdnIrChangeAllocationResourcetId" name="hdnIrChangeAllocationResourcetId">
        <input type="hidden" id="hdnIrChangeAllocationLastEndDate" name="hdnIrChangeAllocationLastEndDate">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Change Allocation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-4 text-right">Request Id</label>
                            <div class="col-sm-8">

                                <div class="input-group datefielddiv">                                 
                                    <% CommonFunctions.HTMLControls.DrawComboBox("CboIrResourceId", "Select 0,'   ' ",,, " class='form-control issueselectprojects' onChange='javascript:CboIrResourceId_OnChange(this.value);' ",,, True) %>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-4 text-right">From Date</label>
                            <div class="col-sm-8">

                                <div class="input-group datefielddiv">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtIrChangeAllocationStartDate", "txtIrChangeAllocationStartDate", "form-control",,,,,,,,,, "PlaceHolder ='Select Start Date ' autocomplete='off'",,,,,,, True) %>
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 text-right">To Date</label>
                            <div class="col-sm-8">
                                <div class="input-group datefielddiv">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtIrChangeAllocationEndDate", "txtIrChangeAllocationEndDate", "form-control",,,,,,,,,, "PlaceHolder ='Select End Date ' autocomplete='off'",,,,,,, True) %>
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>

                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-4 text-right">Quantity/no. of licences</label>
                            <div class="col-sm-8">
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtIrChangeAllocationQuantity", "txtIrChangeAllocationQuantity", "form-control",,,,,,,,,, "PlaceHolder ='Enter Quantity'",,,,,,, False) %>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 text-right">Comments</label>
                            <div class="col-sm-8">
                                 <% CommonFunctions.HTMLControls.DrawTextArea("txatIrChangeAllocationComments", "txatIrChangeAllocationComments", "Enter Comment (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Comments (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>

                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group">&nbsp;</div>
                        <div class="form-group text-center" style="display:block">
                            <button class="btn borderbtn borderbtnfill" onclick="IrSaveChangedAllocation()">Save</button>
                            <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!--end modal popup-->
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
                                        <label class="control-label col-md-4 p-0 text-right">Filter Name :</label>
                                        <span class="col-md-8">
                                            <input type="text" class="form-control" name=""><br />
                                            <div class="btnrow">
                                                <button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>
                                                <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right">Cancel</button>
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
    <!--Release status-->
    <div class="modal custmodal  fade" id="IMReleaseModal" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true">
        <input type="hidden" id="hdnIrreleaseResourcetId" name="hdnIrreleaseResourcetId">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Release</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                 
                <div class="modal-body">
                    <div>
                         <div class="form-group" style="display:flex">
                            <label class="col-sm-4 text-right">Select Request </label>
                            <div class="col-sm-8">

                                <div class="input-group datefielddiv">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("CboIrClosedRequest", "Select 0,'   ' ",,, " class='form-control issueselectprojects' onChange='javascript:CboIrClosedRequest_OnChange(this.value);' ",,, False) %>
                                   <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboIrResource", "usp_Whizible2_Sel_tbl_RM_InfraResourceRequest_ClosedRequest",, "Contingency Plan", "class='form-control issueselectprojects' onChange='javascript:CboIrResource_OnChange(this.value);'", True,,) %>--%>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group" style="display:flex">
                            <label class="col-sm-4 text-right">Allocated</label>
                            <div class="col-sm-8">

                                <div class="input-group datefielddiv">
                                  <label id="lblReleaseAllocatedCount"></label>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                         
                    </div>
                    <div id="dvRelseBody">
                    <p align="center">Are you sure you want to release the Resource before End date?</p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-left">
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                 
                                 <button class="btn btnyellow ml-1 pull-right" onclick="ConfirmRelease()">Yes</button>
                                 <button class="btn borderbtn ml-1  pull-right" data-bs-dismiss="modal" onclick="Cancel_modal()">No</button>
                            </div>
                        </div>
                    </div>

                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!--end modal popup-->
        </div>





    <!-- REQUIRED JS SCRIPTS -->
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
	<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>

    <script>

        //change date format
        var months = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];
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
        //$('#ADPlanStartDate, #ADPlanEndDate,#IMEndDate, #PIRFltrFromDatefield, #PIRFltrToDatefield').datepicker({
        //    autoclose: true,
        //    changeMonth: true,
        //    changeYear: true,
        //    dateFormat: 'yy MM dd'
        //});


        //start script for display dropdown hide behind div
        (function () {
            // hold onto the drop down menu
            var dropdownMenu;

            // and when you show it, move it to the body
            $(window).on('show.bs.dropdown', function (e) {

                // grab the menu
                dropdownMenu = $(e.target).find('.multiselect-container.dropdown-menu');

                // detach it and append it to the body
                $('body').append(dropdownMenu.detach());

                // grab the new offset position
                var eOffset = $(e.target).offset();

                // make sure to place it where it would normally go (this could be improved)
                dropdownMenu.css({
                    'display': 'block',
                    'top': eOffset.top + $(e.target).outerHeight(),
                    'left': eOffset.left
                });
            });

            $('#txtIrQuantity').keypress(function (event) {
                if ((event.which != 46 || $(this).val().indexOf('.') != -1) &&
                    ((event.which < 48 || event.which > 57) &&
                        (event.which != 0 && event.which != 8))) {
                    event.preventDefault();
                }

                var text = $(this).val();

                if ((text.indexOf('.') != -1) &&
                    (text.substring(text.indexOf('.')).length > 2) &&
                    (event.which != 0 && event.which != 8) &&
                    ($(this)[0].selectionStart >= text.length - 2)) {
                    event.preventDefault();
                }
            });
            // and when you hide it, reattach the drop down, and hide it normally
            $(window).on('hide.bs.dropdown', function (e) {
                $(e.target).append(dropdownMenu.detach());
                dropdownMenu.hide();
            });
        })();
        //End script for display dropdown hide behind div


        $(document).on('click.bs.dropdown.data-api', '.dropdown.keep-inside-clicks-open', function (e) {
            e.stopPropagation();
        });

        $('[data-bs-toggle="tooltip"]').tooltip();


        //dynamically set height
        function resizeSection(tag) {
            var JStableOuter = $(window).height();
            $('.JStableOuter > table, .PRweekdaytbl td::after').css({ 'height': JStableOuter - 190, "overflow-y": "auto" });

            var JStabledividerHeight = $(window).height();
            $('.PRweekdaytbl td::after').css({ 'height': JStabledividerHeight - 150 });

            //$(".PRweekdaytbl td::after").css({'height':JStableOuter});

        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        $('.sortbyrole .selectpicker').selectpicker({
            container: 'body'
        });

        //freez table
        //$('.JStableOuter > table').scroll(function (e) {

        //    $('.JStableOuter > table > thead').css("left", -$(".JStableOuter > tbody").scrollLeft());
        //    $('.JStableOuter > table > thead > tr > th:nth-child(1)').css("left", $(".JStableOuter > table").scrollLeft() - 0);
        //    $('.JStableOuter > table > tbody > tr > td:nth-child(1), .JStableOuter > table > tbody > tr > td:nth-child(2)').css("left", $(".JStableOuter > table").scrollLeft());

        //    $('.JStableOuter > table > thead').css("top", -$(".JStableOuter > tbody").scrollTop());
        //    $('.JStableOuter > table > thead > tr > th').css("top", $(".JStableOuter > table").scrollTop());
        //});


        //colappse row
        $(".UpDowncollapseArrow").click(function () {
            $(this).toggleClass("in");

        });

        //Tagsinput

        $('#RAtaglist').tagsinput({
            typeahead: {
                source: ['Amsterdam', 'Washington', 'Sydney', 'Beijing', 'Cairo'],
                afterSelect: function () {
                    this.$element[0].value = '';
                }
            }
        });

        $('#resourcetaglist').tagsinput({
            typeahead: {
                source: ['Amsterdam', 'Washington', 'Sydney', 'Beijing', 'Cairo'],
                afterSelect: function () {
                    this.$element[0].value = '';
                }
            }
        });
    </script>
    <script type="text/javascript">
        //this is for file attache and drop script

        $('form input').change(function () {
            $('form p').text(this.files.length + " file(s) selected");
        });


    </script>
    <script>
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

        // script Added for Search Resource
        var $rows = $('.ProAllocationTbl tbody tr:not(:first-child)');
        $('#txtSearchAllocationResource').keyup(function () {

            var SearchedInfraNameText = $("#txtSearchAllocationResource").val();
            var FilterallocationList = IrProjectAllocationList.filter(function (x) { return x.ResourceName.toLowerCase().indexOf(SearchedInfraNameText.toLowerCase()) !== -1 });
            ReloadTableSearchForAllocation(FilterallocationList);

        });
        // script Added for Search Resource
        var $rows2 = $('.proavailibilityTbl tr:not(:first-child)');
        $('#txtSearchAvailable').keyup(function () {

            var SearchedAvailableInfraNameText = $("#txtSearchAvailable").val();
            var FilterAvailableList = IrAvailableList.filter(function (x) { return x.ResourceName.toLowerCase().indexOf(SearchedAvailableInfraNameText.toLowerCase()) !== -1 });
            ReloadTableSearchForAvailable(FilterAvailableList);


        });


        //Script added for pagination
        $(function ($) {
            var items = $(".ProAllocationTbl tbody tr.pgrow");

            var numItems = items.length;
            var perPage = 5;

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

        $(function ($) {
            var items = $(".proavailibilityTbl tbody tr.pgrow");

            var numItems = items.length;
            var perPage = 5;

            // Only show the first 2 (or first `per_page`) items initially.
            items.slice(perPage).hide();

            // Now setup the pagination using the `#pagination` div.
            $("#pagination2").pagination({
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
    </script>


    <%--Dev code --%>
    <script type="text/javascript">
        var strUrl = '';
        var NoDataFound = "No data found.";
        var DeleteRecord = "Please select at least one record to delete.";
        var DeleteConfirm = "Are you sure, you want to delete the selected records?";
        strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';

        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var SessionProjectId = '<%= Session("intProjectId") %>';
        var tableRisk = '';
        var tableHistoryRisk = '';
        var tablePlanRisk = '';
        var tableEarlyWarningRisk = '';
        var tableDocumentRisk = '';
        var tableMatrixRisk = '';
        var blnCreateContingencyTask = false;
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var TagID = '<%= m_TagId%>';
        var InputDateFormat = '';
        var Parameters = "";

        $(document).ready(function () {
            
            GetDateFormat();
            //Added By Dipali V On 28th March 2023 For Tooltip Issue
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
            //End of Added By Dipali V On 28th March 2023 For Tooltip Issue
            //Added By Reshma Chavan on 10th March 2022
             Parameters = getParameters();
             var ProjectID = unescape(Parameters["ProjectID"]);
             if (ProjectID != "undefined") {
                SessionProjectId = ProjectID;               
             }           
            //End of Added By Reshma Chavan on 10th March 2022

            if (SessionProjectId != '' && SessionProjectId != 'undefined' && SessionProjectId > 0) {
                $('#CboIrProjectForList').val(SessionProjectId);
                //GetIrProjectAllocations
                CboIrProjectForList_OnChange(SessionProjectId);
            }

            

            if (blnAddAccess == "False") {
                $("#BtnResourceRequest").addClass("clsShowHide");
                //$('#BtnResourceRequest').attr("disabled", true);

            }
            else {
                $("#BtnResourceRequest").removeClass("clsShowHide");
                //$("#btnSaveBGManager").removeClass("clsShowHide");
                //$('#BtnResourceRequest').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#btnBGDelete").addClass("clsShowHide");
            }
            else {
                $("#btnBGDelete").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {

            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";
            }
            //Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
            BindPlaceholder("CboIrResource", "Resource");
            //End of Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
        });

        //Added By Reshma Chavan on 10th March 2022
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

        //Added By Dipali V On 1st March 2022 For After Release Resource Refresh Page
        function RefreshGrid() {
            var currentMonthDate = new Date($("#hdnInfraAllocationMonthDate").val());
            GetIrProjectAllocations(currentMonthDate);
        }
           //End of Added By Dipali V On 1st March 2022 For After Release Resource Refresh Page

        $(".ui-datepicker").click(function () {
            $('.tooltip').removeClass('show');
        });

        function dtFormat(strDateFormat) {

            //debugger;

            var sprintDateFormat = '';
            switch (strDateFormat) {
                case 'DD.MM.YYYY':
                    sprintDateFormat = 'dd.mm.yy';
                    break;

                case 'DD-MM-YYYY':
                    sprintDateFormat = 'dd-mm-yy';
                    break;

                case 'DD/MM/YYYY':
                    sprintDateFormat = 'dd/mm/yy';
                    break;

                case 'MM-DD-YYYY':
                    sprintDateFormat = 'mm-dd-yy';
                    break;

                case 'MM/DD/YYYY':
                    sprintDateFormat = 'mm/dd/yy';
                    break;

                case 'MM.DD.YYYY':
                    sprintDateFormat = 'mm.dd.yy';
                    break;

                case 'YYYY-DD-MM':
                    sprintDateFormat = 'yy-dd-mm';
                    break;

                case 'YYYY.DD.MM':
                    sprintDateFormat = 'yy.dd.mm';
                    break;

                case 'YYYY/DD/MM':
                    sprintDateFormat = 'yy/dd/mm';
                    break;

                case 'YYYY-MM-DD':
                    sprintDateFormat = 'yy-mm-dd';
                    break;

                case 'YYYY/MM/DD':
                    sprintDateFormat = 'yy/mm/dd';
                    break;

                case 'YYYY.MM.DD':
                    sprintDateFormat = 'yy.mm.dd';
                    break;

            }
            return sprintDateFormat;
        }

        function getInputDateFormat(dtStartDate, dtEndDate, Flag, strDateFormat) {
            var dtstart = ''
            
            switch (strDateFormat) {
                case 'DD.MM.YYYY':
                    var arrStartDate = dtStartDate.value.toString().split(".");
                    var dd = arrStartDate[0];
                    var mm = arrStartDate[1];
                    var yyyy = arrStartDate[2];
                    dtstart = mm + '/' + dd + '/' + yyyy;
                    dtsdt = yyyy + '-' + mm + '-' + dd;
                    dtvsdt = mm + '/' + dd + '/' + yyyy;
                    var arrEndDate = dtEndDate.value.toString().split(".");
                    var dd = arrEndDate[0];
                    var mm = arrEndDate[1];
                    var yyyy = arrEndDate[2];
                    dtend = mm + '/' + dd + '/' + yyyy;
                    dtedt = yyyy + '-' + mm + '-' + dd;
                    dtvedt = mm + '/' + dd + '/' + yyyy;
                    if (dtStartDate.value != "" && dtEndDate.value != "") {
                        dtStartDate.value = dtsdt;
                        dtEndDate.value = dtedt;
                    }
                    dtstart = new Date(dtstart);
                    dtend = new Date(dtend);
                    break;
                case 'DD-MM-YYYY':
                    var arrStartDate = dtStartDate.value.toString().split("-");
                    var dd = arrStartDate[0];
                    var mm = arrStartDate[1];
                    var yyyy = arrStartDate[2];
                    dtstart = mm + '/' + dd + '/' + yyyy;
                    dtsdt = yyyy + '-' + mm + '-' + dd;
                    dtvsdt = mm + '/' + dd + '/' + yyyy;
                    var arrEndDate = dtEndDate.value.toString().split("-");
                    var dd = arrEndDate[0];
                    var mm = arrEndDate[1];
                    var yyyy = arrEndDate[2];
                    dtend = mm + '/' + dd + '/' + yyyy;
                    dtedt = yyyy + '-' + mm + '-' + dd;
                    dtvedt = mm + '/' + dd + '/' + yyyy;
                    if (dtStartDate.value != "" && dtEndDate.value != "") {
                        dtStartDate.value = dtsdt;
                        dtEndDate.value = dtedt;
                    }
                    dtstart = new Date(dtstart);
                    dtend = new Date(dtend);
                    break;

                case 'DD/MM/YYYY':
                    var arrStartDate = dtStartDate.value.toString().split("/");
                    var dd = arrStartDate[0];
                    var mm = arrStartDate[1];
                    var yyyy = arrStartDate[2];
                    dtstart = mm + '/' + dd + '/' + yyyy;
                    dtsdt = yyyy + '-' + mm + '-' + dd;
                    dtvsdt = mm + '/' + dd + '/' + yyyy;
                    var arrEndDate = dtEndDate.value.toString().split("/");
                    var dd = arrEndDate[0];
                    var mm = arrEndDate[1];
                    var yyyy = arrEndDate[2];
                    dtend = mm + '/' + dd + '/' + yyyy;
                    dtedt = yyyy + '-' + mm + '-' + dd;
                    dtvedt = mm + '/' + dd + '/' + yyyy;
                    if (dtStartDate.value != "" && dtEndDate.value != "") {
                        dtStartDate.value = dtsdt;
                        dtEndDate.value = dtedt;
                    }
                    dtstart = new Date(dtstart);
                    dtend = new Date(dtend);
                    break;

                case 'YYYY-DD-MM':
                    alert(dtStartDate)
                    var arrStartDate = dtStartDate.toString().split("-");
                    //var arrStartDate = dtStartDate.value.toString().split("-");
                    var dd = arrStartDate[1];
                    var mm = arrStartDate[2];
                    var yyyy = arrStartDate[0];
                    dtstart = mm + '/' + dd + '/' + yyyy;
                    dtsdt = yyyy + '-' + mm + '-' + dd;
                    dtvsdt = mm + '/' + dd + '/' + yyyy;
                    dtsd2t = yyyy + '/' + mm + '/' + dd;
                    //var arrEndDate = dtEndDate.value.toString().split("-");
                    //var dd = arrEndDate[1];
                    //var mm = arrEndDate[2];
                    //var yyyy = arrEndDate[0];
                    //dtend = mm + '/' + dd + '/' + yyyy;
                    //dtedt = yyyy + '-' + mm + '-' + dd;
                    //dtvedt = mm + '/' + dd + '/' + yyyy;
                    //if (dtStartDate.value != "" && dtEndDate.value != "") {
                    //    dtStartDate.value = dtsdt;
                    //    dtEndDate.value = dtedt;
                    //}
                    dtstart = dtsd2t;
                    //dtend = new Date(dtend);
                    break;

                case 'YYYY.DD.MM':
                    var arrStartDate = dtStartDate.value.toString().split(".");
                    var dd = arrStartDate[1];
                    var mm = arrStartDate[2];
                    var yyyy = arrStartDate[0];
                    dtstart = mm + '/' + dd + '/' + yyyy;
                    dtsdt = yyyy + '-' + mm + '-' + dd;
                    dtvsdt = mm + '/' + dd + '/' + yyyy;
                    var arrEndDate = dtEndDate.value.toString().split(".");
                    var dd = arrEndDate[1];
                    var mm = arrEndDate[2];
                    var yyyy = arrEndDate[0];
                    dtend = mm + '/' + dd + '/' + yyyy;
                    dtedt = yyyy + '-' + mm + '-' + dd;
                    dtvedt = mm + '/' + dd + '/' + yyyy;
                    if (dtStartDate.value != "" && dtEndDate.value != "") {
                        dtStartDate.value = dtsdt;
                        dtEndDate.value = dtedt;
                    }
                    dtstart = new Date(dtstart);
                    dtend = new Date(dtend);
                    break;

                case 'YYYY/DD/MM':
                    var arrStartDate = dtStartDate.value.toString().split("/");
                    var dd = arrStartDate[1];
                    var mm = arrStartDate[2];
                    var yyyy = arrStartDate[0];
                    dtstart = mm + '/' + dd + '/' + yyyy;
                    dtsdt = yyyy + '-' + mm + '-' + dd;
                    dtvsdt = mm + '/' + dd + '/' + yyyy;
                    //var arrEndDate = dtEndDate.value.toString().split("/");
                    //var dd = arrEndDate[1];
                    //var mm = arrEndDate[2];
                    //var yyyy = arrEndDate[0];
                    //dtend = mm + '/' + dd + '/' + yyyy;
                    //dtedt = yyyy + '-' + mm + '-' + dd;
                    //dtvedt = mm + '/' + dd + '/' + yyyy;
                    //if (dtStartDate.value != "" && dtEndDate.value != "") {
                    //    dtStartDate.value = dtsdt;
                    //    dtEndDate.value = dtedt;
                    //}
                    dtstart = new Date(dtstart);
                    ///dtend = new Date(dtend);
                    alert(dtstart)
                    break;

                case 'YYYY-MM-DD':
                  
                    var arrStartDate = dtStartDate.value.toString().split("-");
                    var dd = arrStartDate[2];
                    var mm = arrStartDate[1];
                    var yyyy = arrStartDate[0];
                    dtstart = mm + '/' + dd + '/' + yyyy;
                    dtsdt = yyyy + '-' + mm + '-' + dd;
                    dtvsdt = mm + '/' + dd + '/' + yyyy;
                    //var arrEndDate = dtEndDate.value.toString().split("-");
                    //var dd = arrEndDate[2];
                    //var mm = arrEndDate[1];
                    //var yyyy = arrEndDate[0];
                    //dtend = mm + '/' + dd + '/' + yyyy;
                    //dtedt = yyyy + '-' + mm + '-' + dd;
                    //dtvedt = mm + '/' + dd + '/' + yyyy;
                    //if (dtStartDate.value != "" && dtEndDate.value != "") {
                    //    dtStartDate.value = dtsdt;
                    //    dtEndDate.value = dtedt;
                    //}
                    dtstart = new Date(dtstart);
                    //dtend = new Date(dtend);
                    break;

                case 'YYYY.MM.DD':
                    var arrStartDate = dtStartDate.value.toString().split(".");
                    var dd = arrStartDate[2];
                    var mm = arrStartDate[1];
                    var yyyy = arrStartDate[0];
                    dtstart = mm + '/' + dd + '/' + yyyy;
                    dtsdt = yyyy + '-' + mm + '-' + dd;
                    dtvsdt = mm + '/' + dd + '/' + yyyy;
                    var arrEndDate = dtEndDate.value.toString().split(".");
                    var dd = arrEndDate[2];
                    var mm = arrEndDate[1];
                    var yyyy = arrEndDate[0];
                    dtend = mm + '/' + dd + '/' + yyyy;
                    dtedt = yyyy + '-' + mm + '-' + dd;
                    dtvedt = mm + '/' + dd + '/' + yyyy;
                    if (dtStartDate.value != "" && dtEndDate.value != "") {
                        dtStartDate.value = dtsdt;
                        dtEndDate.value = dtedt;
                    }
                    dtstart = new Date(dtstart);
                    dtend = new Date(dtend);
                    break;

                case 'YYYY/MM/DD':
                    var arrStartDate = dtStartDate.value.toString().split("/");
                    var dd = arrStartDate[2];
                    var mm = arrStartDate[1];
                    var yyyy = arrStartDate[0];
                    dtstart = mm + '/' + dd + '/' + yyyy;
                    dtsdt = yyyy + '-' + mm + '-' + dd;
                    dtvsdt = mm + '/' + dd + '/' + yyyy;
                    var arrEndDate = dtEndDate.value.toString().split("/");
                    var dd = arrEndDate[2];
                    var mm = arrEndDate[1];
                    var yyyy = arrEndDate[0];
                    dtend = mm + '/' + dd + '/' + yyyy;
                    dtedt = yyyy + '-' + mm + '-' + dd;
                    dtvedt = mm + '/' + dd + '/' + yyyy;
                    if (dtStartDate.value != "" && dtEndDate.value != "") {
                        dtStartDate.value = dtsdt;
                        dtEndDate.value = dtedt;
                    }
                    dtstart = new Date(dtstart);
                    dtend = new Date(dtend);
                    alert(dtstart)
                    break;
                case 'MM-DD-YYYY':
                    var arrStartDate = dtStartDate.value.toString().split("-");
                    var dd = arrStartDate[1];
                    var mm = arrStartDate[0];
                    var yyyy = arrStartDate[2];
                    dtstart = mm + '/' + dd + '/' + yyyy;
                    dtsdt = yyyy + '-' + mm + '-' + dd;
                    dtvsdt = mm + '/' + dd + '/' + yyyy;
                    var arrEndDate = dtEndDate.value.toString().split("-");
                    var dd = arrEndDate[1];
                    var mm = arrEndDate[0];
                    var yyyy = arrEndDate[2];
                    dtend = mm + '/' + dd + '/' + yyyy;
                    dtedt = yyyy + '-' + mm + '-' + dd;
                    dtvedt = mm + '/' + dd + '/' + yyyy;
                    if (dtStartDate.value != "" && dtEndDate.value != "") {
                        dtStartDate.value = dtsdt;
                        dtEndDate.value = dtedt;
                    }
                    dtstart = new Date(dtstart);
                    dtend = new Date(dtend);
                    break;
                case 'MM.DD.YYYY':
                    var arrStartDate = dtStartDate.value.toString().split(".");
                    var dd = arrStartDate[1];
                    var mm = arrStartDate[0];
                    var yyyy = arrStartDate[2];
                    dtstart = mm + '/' + dd + '/' + yyyy;
                    dtsdt = yyyy + '-' + mm + '-' + dd;
                    dtvsdt = mm + '/' + dd + '/' + yyyy;
                    var arrEndDate = dtEndDate.value.toString().split(".");
                    var dd = arrEndDate[1];
                    var mm = arrEndDate[0];
                    var yyyy = arrEndDate[2];
                    dtend = mm + '/' + dd + '/' + yyyy;
                    dtedt = yyyy + '-' + mm + '-' + dd;
                    dtvedt = mm + '/' + dd + '/' + yyyy;
                    if (dtStartDate.value != "" && dtEndDate.value != "") {
                        dtStartDate.value = dtsdt;
                        dtEndDate.value = dtedt;
                    }
                    dtstart = new Date(dtstart);
                    dtend = new Date(dtend);
                    break;
                case 'MM/DD/YYYY':
                    var arrStartDate = dtStartDate.value.toString().split("/");
                    var dd = arrStartDate[1];
                    var mm = arrStartDate[0];
                    var yyyy = arrStartDate[2];
                    dtstart = mm + '/' + dd + '/' + yyyy;
                    dtsdt = yyyy + '-' + mm + '-' + dd;
                    dtvsdt = mm + '/' + dd + '/' + yyyy;
                    var arrEndDate = dtEndDate.value.toString().split("/");
                    var dd = arrEndDate[1];
                    var mm = arrEndDate[0];
                    var yyyy = arrEndDate[2];
                    dtend = mm + '/' + dd + '/' + yyyy;
                    dtedt = yyyy + '-' + mm + '-' + dd;
                    dtvedt = mm + '/' + dd + '/' + yyyy;
                    if (dtStartDate.value != "" && dtEndDate.value != "") {
                        dtStartDate.value = dtsdt;
                        dtEndDate.value = dtedt;
                    }
                    dtstart = new Date(dtstart);
                    dtend = new Date(dtend);
                    alert(dtstart)
                    break;


            }
            alert('at end' + dtstart);
            return dtstart

        }

        function IrOpenBookRequest(ResourceId) {
            var InputDate = dtFormat($('#hdnInfraInputDate').val())
            $('#txtIrStartdate, #txtIrEnddate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy MM dd'
            });

            if (ResourceId > 0 && ResourceId != 'undeifned') {
                $("#CboIrResource").val(ResourceId);
                CboIrResource_OnChange(ResourceId);
            } else {
                $("#CboIrResource").val('0');
            }

            var CurrentProjectId = $('#CboIrProjectForList').val();
            if (CurrentProjectId != '' && CurrentProjectId != 'undefined' && CurrentProjectId > 0) {
                $("#CboIrProject").val(CurrentProjectId)
            } else {
                $("#CboIrProject").val(0);
            }

            $("#txtIrStartdate").val('');
            $("#txtIrEnddate").val('');
            $("#txtIrQuantity").val('');
            //$('#lblIrAvailableQuantity').html(0);
            $('#lblIrAvailableQuantity').val(0);
            $('#IRRmodal').modal('show');
        }
        function IrBookResource(isFromSaveAndclick) {
            var isValid = validateIrBookResource()
          
            if (isValid == true) {
                $("#btnbook").hide();//Added By Dipali V On 15th Feb 2022 For Avoid Duplicate Entries
                var IrBookResourceParmas = {
                    InfraRequestId: 0,
                    InfraResourceId: $("#CboIrResource").val(),
                    ProjectId: $("#CboIrProject").val(),
                    Quantity: $("#txtIrQuantity").val(),
                    StartDate: $("#txtIrStartdate").val(),
                    EndDate: $("#txtIrEnddate").val(),
                    Status: 'Pending For Approval',
                    CreatedBy: UserName,
                    RequestedBy: UserName,
                    RequestedUserId: SessionEmployeeId,
                    IsUpdate: "Book"
                }
                
                $.ajax({
                    url: strUrl + '/api/RM_ProjectInfraResources/AddOrUpdateInfraRequest',
                    type: "POST",
                    data: JSON.stringify(IrBookResourceParmas),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (IrBookResourceParmas) {
                            xhr.setRequestHeader("Params", encryptString(isJson(IrBookResourceParmas) ? IrBookResourceParmas : JSON.stringify(IrBookResourceParmas)));
                        }
                    },
                    success: function (data) {

                        var IssavedId = parseInt(data);
                        if (IssavedId != 'NaN' && IssavedId != 'undefined' && IssavedId > 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success('Request Added Successfully.');
                            $("#btnbook").show();//Added By Dipali V On 15th Feb 2022 For Avoid Duplicate Entries
                            window.open('../Email/SendEmail.aspx?MessageID=35002&RequestId=' + IssavedId + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                            $('#IRRmodal').modal('hide');//Added By Dipali V On 15th Feb 2022 For Avoid Duplicate Entries
                        } else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                             $("#btnbook").show();
                        }

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.notify(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                        }
                        else if (xhr.statusText == "Created") {

                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                    }

                })

            }
        }

        function CboIrResource_OnChange(value) {
            //$('#lblIrAvailableQuantity').html(0);
            $('#lblIrAvailableQuantity').val(0);
            var IrResourceIdParmas = { InfraResourceId: value }
            if (IrResourceIdParmas.InfraResourceId > 0) {
                GetAvailableQuatity(IrResourceIdParmas);
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select Resource.');
            }

        }

        function CheckAvailableResource() {
            var IrResourceIdParmas = { InfraResourceId: $("#CboIrResource").val(), StartDate: $("#txtIrStartdate").val(), EndDate: $("#txtIrEnddate").val() }
            GetAvailableQuatity(IrResourceIdParmas)
        }

        function GetAvailableQuatity(IrResourceIdParmas) {
            $.ajax({
                url: strUrl + '/api/RM_ProjectInfraResources/GetTotalQuantityForResourceId',
                type: "POST",
                data: JSON.stringify(IrResourceIdParmas),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (IrResourceIdParmas) {
                        xhr.setRequestHeader("Params", encryptString(isJson(IrResourceIdParmas) ? IrResourceIdParmas : JSON.stringify(IrResourceIdParmas)));
                    }
                },
                success: function (data) {
                   // $('#lblIrAvailableQuantity').html(parseInt(data));
                    $('#lblIrAvailableQuantity').val(parseInt(data));

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue 
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue 
                    }
                    else if (xhr.statusText == "Created") {
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(thrownError);
                    }
                }

            })
        }

        var validateflag = false;
        function validateIrBookResource() {
            
            var RequestId = $('#CboIrResource').val();
            var RequestProjectId = $('#CboIrProject').val();
            var RequestStartDate = $('#txtIrStartdate').val();
            var RequestEndDate = $('#txtIrEnddate').val();
            var currentDate = new Date();
            var RequestQuantity = parseInt($('#txtIrQuantity').val());
            var RequestStartDateCheck = new Date(RequestStartDate);
            var RequestEndDateCheck = new Date(RequestEndDate);
            //var AvailableQuantity = parseInt($('#lblIrAvailableQuantity').html());
            var AvailableQuantity = parseInt($('#lblIrAvailableQuantity').val());
            //Commented and added by Chetan M on 20 Jul 2021 for Placeholder issue
            //if (RequestId == 'undefined' || RequestId == "" || RequestId == null) {
            if (RequestId == 'undefined' || RequestId == "" || RequestId == null || RequestId == 0) {
                //End of Commented and added by Chetan M on 20 Jul 2021 for Placeholder issue
                $('#CboIrResource').focus();
                alertify.set('notifier', 'position', 'top-right');
                //Commented And Added By Reshma Chavan on 8th dec 2021 for correct Spelling
                //alertify.error("Please select Resouce.");
                alertify.error("Please select Resource.");
                //End of Commented And Added By Reshma Chavan on 8th dec 2021 for correct Spelling
                return false;
            }
            else if (RequestProjectId == 'undefined' || RequestProjectId == "" || RequestProjectId == null || RequestProjectId == '0') {
                $('#CboIrProject').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select project.");
                return false;
            }
            else if (RequestStartDateCheck == undefined || RequestStartDateCheck == "" || RequestStartDateCheck == "Invalid Date") {
                $('#txtIrStartdate').focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Start date' should not left blank.");
                return false;
            }
            else if (RequestEndDateCheck == 'undefined' || RequestEndDateCheck == "" || RequestEndDateCheck == "Invalid Date") {
                $('#txtIrEnddate').focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("' End Date' should not left blank.");
                return false;
            }

            else if (RequestStartDateCheck > RequestEndDateCheck) {
                $('#txtIrStartdate').focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Start date' must be less than 'End date'");
                return false;
            }
            else if ($('#txtIrQuantity').val() == "" || RequestQuantity == 'undefined' || RequestQuantity == "NaN" || RequestQuantity == "" || RequestQuantity == '0') {
                $('#txtIrQuantity').focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Quantity' should not left blank/Zero.");
                return false;
            }
            else if (RequestQuantity > AvailableQuantity) {
                $('#txtIrQuantity').focus();
                alertify.set('notifier', 'position', 'top-right');
                //Commented And Added By Reshma chavan on 11 feb 2022
                //alertify.error("Please enter the quantity less than the Available quantity ");
                alertify.error("Please enter the quantity less than the Available quantity " + AvailableQuantity + ".");
                return false;
            }
            else if (RequestQuantity != null && $('#txtIrQuantity').val().match(/^(-?\d*)((\.(\d{0,0})?)?)$/i) == null && checkSpecialCharacter($('#txtIrQuantity').val(), WebConfigSpecialCharacters) == true) {
                $('#txtIrQuantity').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter numbers only in the quantity ");
                return false;
            }
            //else if (ValidateAvailableResourceForDateRange(RequestStartDateCheck, RequestEndDateCheck, RequestQuantity) > AvailableQuantity) {

            //    $('#txtIrQuantity').focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("Requested quantity exceeds the Available quantity .");
            //    return false;

            //}
            else {

                validateflag = true;
                return true;
            }
        }

        function ValidateAvailableResourceForDateRange(StartDate, EndDate, ReqQuantity) {

            var time_difference = EndDate.getTime() - StartDate.getTime();
            var days_difference = time_difference / (1000 * 60 * 60 * 24);
            return days_difference * ReqQuantity;


        }


        ////list binidng code on project change
        function CboIrProjectForList_OnChange(SelectProjectID) {

            if (SelectProjectID > 0) {
                GetIrProjectAllocations();
            } else {
                $('#CboIrProjectForList').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Project.");
                return false;

            }

        }

        ///Handel on next prev  key
        $(document).keydown(function (e) {
            if (event.keyCode == 37) {
                if ($('#TabProAllocation').hasClass('active')) {
                    GetNextPrevMonth('Prev', 1)
                } else {
                    GetNextPrevMonth('Prev', 0)
                }
                //$('#next').click(); //on left arrow, click next (since your next is on the left)
            } else if (event.keyCode == 39) {
                if ($('#TabProAllocation').hasClass('active')) {
                    GetNextPrevMonth('Next', 1)
                } else {
                    GetNextPrevMonth('Next', 0)
                }
            }
        });



        function GetNextPrevMonth(FormNextPrev, isFromAllocation) {
           // debugger;
            var currentMonthDate = ''
            if (isFromAllocation == 1) {
                currentMonthDate = new Date($("#hdnInfraAllocationMonthDate").val());
            } else {
                currentMonthDate = new Date($("#hdnInfraAvailableMonthDate").val());
            }

            var SetDate = '';
            if (FormNextPrev == 'Next') {
                SetDate = (addMonths(currentMonthDate, 1));
                //currentMonthDate.setMonth(currentMonthDate.getMonth() + 1);
            }
            if (FormNextPrev == 'Prev') {
                SetDate = (addMonths(currentMonthDate, -1));
                //currentMonthDate.setMonth(currentMonthDate.getMonth() -1);
            }
            if (isFromAllocation == 1) {
                GetIrProjectAllocations(SetDate.toString('yyyy-MM-dd'))
            } else {
                GetIrAvailableList(SetDate.toString('yyyy-MM-dd'))
            }


        }


        function addMonths(date, months) {
            var d = date.getDate();
            date.setMonth(date.getMonth() + +months);
            if (date.getDate() != d) {
                date.setDate(0);
            }
            //console.log(d.toLocaleDateString());
            return date.toString('yyyy-MM-dd');
        }

        function convert(str)
        {
            var date = new Date(str),
                mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                day = ("0" + date.getDate()).slice(-2);
            return [date.getFullYear(), mnth, day].join("-");
        }

        const monthNames = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];


        //
        //document.write("The current month is " + months[d.getMonth()]);
        //// Allocation list 
        var IrProjectAllocationList = '';
        var IrDayListHeader = '';
        function GetIrProjectAllocations(currentMonthDate) {

            var CurrentDate = new Date(currentMonthDate);
            var NextPrevDate = "";
            var IrDayListHeader = '';
            var DayNameForSat = 'Sat';
            var DayNameForSun = 'Sun';
            var ProjectId = $('#CboIrProjectForList').val();
            var strHTMLHeader = "";

            ///var NextPrevDate = CurrentDate == 'undefined' && CurrentDate == null && CurrentDate == "Invalid Date" ? 'NULL' : convert(CurrentDate);
			// ('#lblProjectAllocationCurrentMOnth').html()

            //Commented by imran 13-10-2021
            //var IrAllocationParmas = {
            //    ProjectId: ProjectId,
            //    CurrentDate: NextPrevDate
            //}
            //End by imran 13-10-2021

            if (ProjectId != null && ProjectId > 0) {

                //var CurrSelectedMonth = $("#hdnInfraAllocationMonthDate").val();
                if (CurrentDate != "Invalid Date") {
                    NextPrevDate = CurrentDate == "Invalid Date" ? "" : convert(CurrentDate);
                    $("#hdnInfraAllocationMonthDate").val(NextPrevDate);
                } else {
                    CurrentDate = new Date();
                }
                var MonthName = monthNames[CurrentDate.getMonth()].toString();
                $('#lblProjectAllocationCurrentMOnth').html(MonthName + ' (' + CurrentDate.getFullYear() + ') ');
                $("#hdnInfraAllocationMonthDate").val(convert(CurrentDate));

				//Added by imran 13-10-2021
					var IrAllocationParmas = {
                    ProjectId: ProjectId,
                    CurrentDate: NextPrevDate
                }
                //End by imran 13-10-2021
				
                StartLoader("#bodyProjectInfraResource-group");
                $.ajax({
                    url: strUrl + '/api/RM_ProjectInfraResources/GetIrProjectAllocation',
                    method: 'POST',
                    data: JSON.stringify(IrAllocationParmas),
                    dataType: 'json',
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (IrAllocationParmas) {
                            xhr.setRequestHeader("Params", encryptString(isJson(IrAllocationParmas) ? IrAllocationParmas : JSON.stringify(IrAllocationParmas)));
                        }
                    },
                    success: function (data) {
                        IrDayListHeader = data["IrDayListHeader"];
                        strHTMLHeader += '<tr>';
                        if (IrDayListHeader != null && IrDayListHeader != 'undefined' && IrDayListHeader.length > 0) {
                            $.each(IrDayListHeader, function (indexDayHeader, objDayHeader) {
                                var Name = objDayHeader.split("_");
                                if (Name[0] == "Sat" || Name[0] == "Sun") {
                                    strHTMLHeader += '<td class="PRpercentage LabelForSat">' + Name[1] + '<span>' + Name[0] + '</span></td>'
                                } else {
                                    strHTMLHeader += '<td>' + Name[1] + '<span>' + Name[0] + '</span></td>'
                                }


                            });
                        }
                        strHTMLHeader += '</tr>';
                        $("#IrProjectallocatedTbodyDayHeader").html(strHTMLHeader);
                        if (data != null || data != 'undefined' || data != '') {
                            ///Main list
                            IrProjectAllocationList = data["IrProjectAllocationList"];
                            ReloadTableSearchForAllocation(IrProjectAllocationList);
                        }
                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.notify(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    StopAjaxLoader("#bodyProjectInfraResource-group");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                       // alert(xhr.responseText);
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                               // window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        StopAjaxLoader("#bodyProjectInfraResource-group");
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Project.");
            }

        }

        //For search filter

        function ReloadTableSearchForAllocation(IrProjectAllocationList) {

            // $("#IrProjectallocatedTbodyDayRow").html('');
            //$("#CboIrProject").val()

            var strHTMLHeadeRow = "";
            $("#IrProjectallocatedTbodyDayRow").html(strHTMLHeadeRow);

            //if (data != null || data != 'undefined' || data != '') {
            ///Main list
            //IrProjectAllocationList = data["IrProjectAllocationList"];
            if (IrProjectAllocationList != null && IrProjectAllocationList != 'undefined' && IrProjectAllocationList.length > 0) {


                //$('#lblProjectAllocationCurrentMOnth').html(IrProjectAllocationList[0]['MonthName']);

                $('#lblProjectTotalAllocation').html(IrProjectAllocationList.length);

                $.each(IrProjectAllocationList, function (indexIrProjectAllocationList, objIrProjectAllocationList) {
                    $("#hdnInfraAllocationMonthDate").val(objIrProjectAllocationList.MontDate);
                    strHTMLHeadeRow += '<tr class="pgrow">';
                    strHTMLHeadeRow += '<td class="text-left dropdown PRrolename" style="padding-left:3px";> ' + objIrProjectAllocationList.ResourceName + ' <br />'
                    strHTMLHeadeRow += ' <div class="smallsubtext"><span class="pull-left">' + objIrProjectAllocationList.AvailableCount + ' Available</span>  <span class="pull-right">' + objIrProjectAllocationList.TotalAllocatedQuantityForallProject + ' Allocated</span> <div class="clearfix"></div></div> '
                    strHTMLHeadeRow += '  <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a> '
                    strHTMLHeadeRow += ' <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu"> '
                    strHTMLHeadeRow += ' <li> <a class="dropdown-item" href="#" data-bs-toggle="modal"  onclick="(IrOpenChnageAllocationResource(' + objIrProjectAllocationList.InfraResourceId + ' ))\" >Change allocation</a> </li> <li><a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=\"(IrOpenReleaseResource(' + objIrProjectAllocationList.InfraResourceId + ' ))\"  >Release</a> </li> </ul> '
                    strHTMLHeadeRow += ' </td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_1 + '">' + objIrProjectAllocationList.Day_1 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_2 + '">' + objIrProjectAllocationList.Day_2 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_3 + '">' + objIrProjectAllocationList.Day_3 + '</td>'
                    strHTMLHeadeRow += '<td class= "' + objIrProjectAllocationList.ClDay_4 + '">' + objIrProjectAllocationList.Day_4 + '</td>'
                    strHTMLHeadeRow += '<td class ="' + objIrProjectAllocationList.ClDay_5 + '">' + objIrProjectAllocationList.Day_5 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_6 + '">' + objIrProjectAllocationList.Day_6 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_7 + '">' + objIrProjectAllocationList.Day_7 + '</td>'

                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_8 + '">' + objIrProjectAllocationList.Day_8 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_9 + '">' + objIrProjectAllocationList.Day_9 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_10 + '">' + objIrProjectAllocationList.Day_10 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_11 + '">' + objIrProjectAllocationList.Day_11 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_12 + '">' + objIrProjectAllocationList.Day_12 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_13 + '">' + objIrProjectAllocationList.Day_13 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_14 + '">' + objIrProjectAllocationList.Day_14 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_15 + '">' + objIrProjectAllocationList.Day_15 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_16 + '">' + objIrProjectAllocationList.Day_16 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_17 + '">' + objIrProjectAllocationList.Day_17 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_18 + '">' + objIrProjectAllocationList.Day_18 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_19 + '">' + objIrProjectAllocationList.Day_19 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_20 + '">' + objIrProjectAllocationList.Day_20 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_21 + '">' + objIrProjectAllocationList.Day_21 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_22 + '">' + objIrProjectAllocationList.Day_22 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_23 + '">' + objIrProjectAllocationList.Day_23 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_24 + '">' + objIrProjectAllocationList.Day_24 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_25 + '">' + objIrProjectAllocationList.Day_25 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_26 + '">' + objIrProjectAllocationList.Day_26 + '</td>'
                    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_27 + '">' + objIrProjectAllocationList.Day_27 + '</td>'

                    if (objIrProjectAllocationList.Day_28 != null && objIrProjectAllocationList.ClDay_28 != null && IrDayListHeader != 'undefined') {
                        strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_28 + '">' + objIrProjectAllocationList.Day_28 + '</td>'
                    }
                    //if (IrDayListHeader != null && IrDayListHeader != 'undefined' && IrDayListHeaderLength > 27) {
                    //    strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_28 + '">' + objIrProjectAllocationList.Day_28 + '</td>'
                    //}
                    //if (IrDayListHeader != null && IrDayListHeader != 'undefined' && IrDayListHeaderLength > 28) {
                    if (objIrProjectAllocationList.Day_29 != null && objIrProjectAllocationList.ClDay_29 != null && IrDayListHeader != 'undefined') {
                        strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_29 + '">' + objIrProjectAllocationList.Day_29 + '</td>'
                    }
                    //if (IrDayListHeader != null && IrDayListHeader != 'undefined' && IrDayListHeaderLength > 29) {
                    if (objIrProjectAllocationList.Day_30 != null && objIrProjectAllocationList.ClDay_30 != null && IrDayListHeader != 'undefined') {

                        strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_30 + '">' + objIrProjectAllocationList.Day_30 + '</td>'
                    }
                    // if (IrDayListHeader != null && IrDayListHeader != 'undefined' && IrDayListHeaderLength > 30) {
                    if (objIrProjectAllocationList.Day_31 != null && objIrProjectAllocationList.ClDay_31 != null && IrDayListHeader != 'undefined') {
                        strHTMLHeadeRow += '<td class="' + objIrProjectAllocationList.ClDay_31 + '">' + objIrProjectAllocationList.Day_31 + '</td>'
                    }

                    strHTMLHeadeRow += '</tr>';
                });

            }
            else {

                // StopAjaxLoader("#bodyCapacityPalning-group");
                strHTMLHeadeRow += '<tr> <td colspan="31">' + NoDataFound + '</td></tr>';
                StopAjaxLoader("#bodyProjectInfraResource-group");
                $('#lblProjectTotalAllocation').html(0);


            }

            $("#IrProjectallocatedTbodyDayRow").html(strHTMLHeadeRow);

            // $('#IrProjectallocatedTbodyDayRow').dataTable().fnDestroy();
            // LoadPagination('#PRtable ', IrProjectAllocationList);

            //StopAjaxLoader("#bodyProjectInfraResource-group");
            StopAjaxLoader("#bodyProjectInfraResource-group");
            //}
            //else {
            //    //alert("No Data Found");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("No Data Found");
            //    StopAjaxLoader("#bodyProjectInfraResource-group");
            //}

        }

        ///  allocation list

        ///Release resource 

        function IrOpenReleaseResource(ResourceId) {
            $('#CboIrClosedRequest').val(0);
            $('#lblReleaseAllocatedCount').html('');
            $('#hdnIrreleaseResourcetId').val(ResourceId);
            $('#IMReleaseModal').modal('show');
            $('#hdnIrChangeAllocationResourcetId').val(ResourceId);
            var ProjectId = $('#CboIrProjectForList').val();
            GetResourcesByResourceId(ResourceId, ProjectId, 'Closed')
            //$('#IMchngAllocationModal').modal('show');

        }

        function ConfirmRelease() {
            var ResourceId = $('#hdnIrreleaseResourcetId').val();
            var ProjectId = $('#CboIrProjectForList').val();
            var RequestId = $('#CboIrClosedRequest').val();
            if (RequestId > 0) {
                var objInfraRequest = {
                    InfraResourceId: ResourceId,
                    InfraRequestId: RequestId,
                    ProjectId: ProjectId,
                    Status: 'Released',
                    RoleID: RoleID,
                    UserID: SessionEmployeeId,
                    IsFromEdit: 1  //to check release or change allocation
                }
                UpdateRequest(objInfraRequest)
                window.open('../Email/SendEmail.aspx?MessageID=35003&RequestId=' + RequestId + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
               //Added By Dipali V On 1st March 2022 For After Release Resource Refresh Page
                 RefreshGrid();
                //Update resource
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Request Id");
            }
        }

        ////Change allocation

        function ClearAllaoction() {
            $('#txtIrChangeAllocationStartDate').val('')
            $('#txtIrChangeAllocationEndDate').val('')
            $('#txtIrChangeAllocationQuantity').val('')
            $('#txatIrChangeAllocationComments').val('')

        }

        function IrOpenChnageAllocationResource(ResourceId)
        {
            var InputDate = dtFormat($('#hdnInfraInputDate').val())
            $('#txtIrChangeAllocationEndDate, #txtIrChangeAllocationStartDate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                 //Comment And Added by Reshma 19-10-2021
                //dateFormat: 'yy MMM dd'
                dateFormat: 'yy MM dd'
                //End Comment 19-10-2021
            });

            $('#hdnIrChangeAllocationResourcetId').val(ResourceId);
            var ProjectId = $('#CboIrProjectForList').val();
            $('#IMchngAllocationModal').modal('show');
            ClearAllaoction()
            GetResourcesByResourceId(ResourceId, ProjectId)

        }
        /// Save changed allocation call
        function IrSaveChangedAllocation() {

            var ResourceID = $('#hdnIrChangeAllocationResourcetId').val();
            var RequestID = $('#CboIrResourceId').val();
            var ProjectId = $('#CboIrProjectForList').val();
            var NewEndDate = $('#txtIrChangeAllocationEndDate').val();
            var StartDate = $('#txtIrChangeAllocationStartDate').val();
            //var LastEndDate = $('#hdnIrChangeAllocationLastEndDate').val(); //old date for compare

            var dtStartDate = new Date(StartDate);
            var dtEndDate = new Date(NewEndDate);
            //Added By Reshma Chavan on 18th oct 2021 getting page crash issue
            if (RequestID == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Select Request Id');
                $("#CboIrResourceId").focus();

            }

            //End of Added By Reshma Chavan on 18th oct 2021 getting page crash issue
            //dtLastDate.setDate(dtLastDate.getDate() + 1);
             else if (dtEndDate < dtStartDate) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Select End date must be greater than last end date');

            }
            else if (dtEndDate == 'undefined' || dtEndDate == "" || dtEndDate == "Invalid Date") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('End date shoul not be blank');

            }

            else {
                debugger;
                var objInfraRequest = {
                    InfraResourceId: ResourceID,
                    InfraRequestId: RequestID,
                     //Commented And added by imran 13-10-2021
                    //StartDate: $('#txtIrChangeAllocationStartDate').val(),
                    //EndDate: $('#txtIrChangeAllocationEndDate').val(),
                    //End Comment 13-10-2021
					StartDate: convert($('#txtIrChangeAllocationStartDate').val()),
                    EndDate: convert($('#txtIrChangeAllocationEndDate').val()),
                    Comments: $('#txatIrChangeAllocationComments').val(),
                    Quantity: $('#txtIrChangeAllocationQuantity').val(),
                    ProjectId: ProjectId,
                    RoleID: RoleID,
                    UserID: SessionEmployeeId,
                    //IsFromEdit: 0  //to check release or change allocation
                    IsFromEdit: "0"  //to check release or change allocation
                };
                UpdateRequest(objInfraRequest);
                //$("#IMchngAllocationModal").modal('hide');
            }

        }

        ////Change allocation


        function UpdateRequest(objInfraRequest) {

            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_ProjectInfraResources/UpdateResourceInfraResource',
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
                success: function (data)
                {
                    alertify.set('notifier', 'position', 'top-right');
                    //Commented & Added By Rutuja D. on 11 Feb 2022 Validation missing
                    //var IsBookResource = parseInt(data)
                    //if (IsBookResource != 'NAN')
                    //{
                    //    //comment And Added by imran 13-10-2021
                    //    //alertify.success(data);
                    //     alertify.success('Allocation Changed ');
                    //    //End by imran 13-10-2021
                    //}
                    //else {
                    //    alertify.success('Allocation Changed ');
                    //}
                    var IsBookResource = data
                    if (IsBookResource.indexOf('Request End date must be less  than resource Available till Date') > -1) {
                        $("#IMchngAllocationModal").modal('show');
                        alertify.error(IsBookResource);
                    } else if (IsBookResource.indexOf('Please select end date must be greater then') > -1){
                        $("#IMchngAllocationModal").modal('show');
                        alertify.error(IsBookResource);
                    }
                    else if (IsBookResource == 'Resource has been released.') {
                        alertify.success(IsBookResource);
                        $("#IMReleaseModal").modal('hide');
                    }
                    else if (parseInt(data) != 'NAN') {
                        //Commented And Added By Reshma Chavan on 7th March 2022 to rephrase alert
                        //alertify.success('Allocation changed.');
                        alertify.success('Change Allocation request submitted successfully.');
                         //End of Commented And Added By Reshma Chavan on 7th March 2022 to rephrase alert
                        $("#IMchngAllocationModal").modal('hide');
                    }                    
                    else {
                         //Commented And Added By Reshma Chavan on 7th March 2022 to rephrase alert
                        //alertify.success('Allocation changed.');
                        alertify.success('Change Allocation request submitted successfully.');
                         //End of Commented And Added By Reshma Chavan on 7th March 2022 to rephrase alert
                        $("#IMchngAllocationModal").modal('hide');
                    }
                    //End of Commented & Added By Rutuja D. on 11 Feb 2022 Validation missing

                    //StopAjaxLoader("#bodyBusiness-group");
                    //window.open('../Email/SendEmail.aspx?MessageID=20052&RequestId=' + RequestId + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue  
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue  
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(thrownError);
                    }
                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    // StopAjaxLoader("#bodyBusiness-group");
                }
            })

            // window.open('../Email/SendEmail.aspx?MessageID=20052&RequestId=' + RequestId + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
        }

        //End release resource

        var RequestList = '';
        function GetResourcesByResourceId(ResourceId, ProjectId, Status) {
            var IrGetResourceParmas = ''
            if (Status == 'Closed') {
                IrGetResourceParmas = { InfraResourceId: ResourceId, ProjectId: ProjectId, Status: Status }
            } else {
                IrGetResourceParmas = { InfraResourceId: ResourceId, ProjectId: ProjectId }
            }

            var strResourceIdHTML = ''
            $.ajax({
                url: strUrl + '/api/RM_ProjectInfraResources/GetResourcesByResourceId',
                type: "POST",
                data: JSON.stringify(IrGetResourceParmas),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (IrGetResourceParmas) {
                        xhr.setRequestHeader("Params", encryptString(isJson(IrGetResourceParmas) ? IrGetResourceParmas : JSON.stringify(IrGetResourceParmas)));
                    }
                },
                success: function (data) {
                    RequestList = data;
                    strResourceIdHTML += "<option value='0'>Select Request Id </option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strResourceIdHTML += ('<option value=' + listComponent.InfraRequestId + ' >' + listComponent.InfraRequestId + '</option>');

                    }
                    if (Status == 'Closed') {
                        $("#CboIrClosedRequest").html(strResourceIdHTML);
                    } else {

                        $("#CboIrResourceId").html(strResourceIdHTML);
                    }

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue    
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue    
                    }
                    else if (xhr.statusText == "Created") {
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(thrownError);
                    }
                }

            })
        }

        function CboIrResourceId_OnChange(RequestId)
        {
            $('#txtIrChangeAllocationStartDate').addClass("DisableContent");
            $('#txtIrChangeAllocationQuantity').addClass("DisableContent");

            GetRequestByRequestId(RequestId, 1);
        }
        function CboIrClosedRequest_OnChange(RequestId) {

            GetRequestByRequestId(RequestId, 0)
        }


        function GetRequestByRequestId(RequestId, IsFromAllocation) {

            if (RequestId > 0) {
                var SearchedInfraNameText = $("#txtSearchAllocationResource").val();
                var FilterRequest = RequestList.filter(function (x) { return x.InfraRequestId == RequestId });
                if (IsFromAllocation == 1) {
                    var dCurrentDate = new Date();
                    var dtFormat2 = dtFormat(InputDateFormat);                   
                    $('#hdnIrChangeAllocationLastEndDate').val(FilterRequest[0].StartDate);
                    //$('#txtIrChangeAllocationStartDate').val(convert(FilterRequest[0].StartDate));
                    //InputDateFormat var InputDate= dtFormat($('#hdnInfraInputDate').val())
                    var dtLastDate = new Date(FilterRequest[0].EndDate);
                    //var dtNewEndDate = new Date(NewEndDate);
                    dtLastDate.setDate(dtLastDate.getDate() + 1);
                    //getInputDateFormat(dtStartDate, dtEndDate, Flag, strDateFormat) {
                    //var InputDatmmme = getInputDateFormat(convert(dtLastDate), dtLastDate, '', "YYYY-DD-MM")//
                    ///geting date from company info.
                    
                    //Commented And Added By reshma Chavan on 20th Oct 2021 date format issue
                    //$('#txtIrChangeAllocationStartDate').val(convert(dtLastDate));
                    $('#txtIrChangeAllocationStartDate').val(convertformat(dtLastDate));
                    //End of Commented And Added By reshma Chavan on 20th Oct 2021 date format issue

                    if (RequestList[0].EndDate < dCurrentDate) {
                        $('#txtIrChangeAllocationEndDate').addClass("DisableContent");

                    } else {
                        $('#txtIrChangeAllocationEndDate').removeClass("DisableContent");

                    }
                    //$('#txtIrChangeAllocationEndDate').val(convert(FilterRequest[0].EndDate))

                    $('#txtIrChangeAllocationQuantity').val(FilterRequest[0].Quantity)
                    $('#txatIrChangeAllocationComments').val(FilterRequest[0].Comments)

                } else {
                    //alert(FilterRequest[0].Quantity);
                    $('#lblReleaseAllocatedCount').html(FilterRequest[0].AllocatedQuantity)
                }


                //console.log(data);

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Select Request Id');
            }
        }

        //Open change all0cation popup

        //End change allocation popup
        //Added By reshma Chavan on 20th Oct 2021 date format issue
        function convertformat(str) {
            var MonthFormat = '';
            var date = new Date(str),
                mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                day = ("0" + date.getDate()).slice(-2);
            if (monthNames[mnth - 1] <= 9) {
                MonthFormat = monthNames[mnth - 1];
            }
            else {
                MonthFormat = monthNames[mnth - 1].replace("0", "");
            }
            return [date.getFullYear(), MonthFormat, day].join(" ");
        }
        //End of Added By reshma Chavan on 20th Oct 2021 date format issue

        /////Available  api call

        function IrGetAvalilableList() {
            GetIrAvailableList('');
        }

        var IrAvailableList = '';
        var IrDayAvailableListHeader = '';
        function GetIrAvailableList(currentMonthDate) {
            //Added By Dipali V On 28th March 2023 For Tooltip Issue
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
            //End of Added By Dipali V On 28th March 2023 For Tooltip Issue
            var CurrentDate = new Date(currentMonthDate);
            var NextPrevDate = "";
            var strHTMLHeader = "";
            //var CurrSelectedMonth = $("#hdnInfraAllocationMonthDate").val();
            if (CurrentDate != "Invalid Date") {
                NextPrevDate = CurrentDate == "Invalid Date" ? "" : convert(CurrentDate);
                $("#hdnInfraAvailableMonthDate").val(NextPrevDate);
            } else {
                CurrentDate = new Date();
            }
            var MonthName = monthNames[CurrentDate.getMonth()].toString();
            $('#lblAvailableCurrentMOnth').html(MonthName + '(' + CurrentDate.getFullYear() + ')');
            $("#hdnInfraAvailableMonthDate").val(convert(CurrentDate));
            var IrAavilableParmas = {
                CurrentDate: NextPrevDate
            }


            StartLoader("#bodyProjectInfraResource-group");
            $.ajax({
                url: strUrl + '/api/RM_ProjectInfraResources/GetIrResourceAvailablity',
                method: 'POST',
                data: JSON.stringify(IrAavilableParmas),
                dataType: 'json',
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (IrAavilableParmas) {
                        xhr.setRequestHeader("Params", encryptString(isJson(IrAavilableParmas) ? IrAavilableParmas : JSON.stringify(IrAavilableParmas)));
                    }
                },
                success: function (data) {
                    IrDayAvailableListHeader = data["IrAvailableDayListHeader"];
                    StopAjaxLoader("#bodyProjectInfraResource-group");
                    strHTMLHeader += '<tr>';
                    if (IrDayAvailableListHeader != null && IrDayAvailableListHeader != 'undefined' && IrDayAvailableListHeader.length > 0) {
                        $.each(IrDayAvailableListHeader, function (indexDayHeader, objDayHeader) {
                            var Name = objDayHeader.split("_")
                            if (Name[0] == "Sat" || Name[0] == "Sun") {
                                strHTMLHeader += '<td class="PRpercentage LabelForSat">' + Name[1] + '<span>' + Name[0] + '</span></td>'
                            } else {
                                strHTMLHeader += '<td>' + Name[1] + '<span>' + Name[0] + '</span></td>'
                            }


                        });
                    }
                    strHTMLHeader += '</tr>';
                    $("#IrAvailableTbodyDayHeader").html(strHTMLHeader);
                    if (data != null || data != 'undefined' || data != '') {
                        ///Main list
                        IrAvailableList = data["IrAvailableList"];
                        ReloadTableSearchForAvailable(IrAvailableList);
                    }
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyProjectInfraResource-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                           // window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyProjectInfraResource-group");
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

        }




        function ReloadTableSearchForAvailable(IrAvailableList) {
            var strHTMLAvailableHeadeRow = "";
            $("#IrAvailableTbodyDayRow").html(strHTMLAvailableHeadeRow);
            if (IrAvailableList != null && IrAvailableList != 'undefined' && IrAvailableList.length > 0) {
                //$('#lblAvailableCurrentMOnth').html(IrAvailableList[0]['MonthName']);

                $('#lblTotalAvailable').html(IrAvailableList.length);

                $.each(IrAvailableList, function (indexIrAvailableList, objIrAvailableList) {
                    $("#hdnInfraAvailableMonthDate").val(objIrAvailableList.MontDate);

                    strHTMLAvailableHeadeRow += '<tr class="pgrow">';
                    strHTMLAvailableHeadeRow += '<td class="text-left dropdown PRrolename" style="padding-left:3px"";> ' + objIrAvailableList.ResourceName + ' <br />'
                    strHTMLAvailableHeadeRow += ' <div class="smallsubtext"><span class="pull-left">' + objIrAvailableList.AvailableCount + ' Available</span>  <span class="pull-right">' + objIrAvailableList.TotalQuantityForMonth + ' Total</span> <div class="clearfix"></div></div> '
                    strHTMLAvailableHeadeRow += '  <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a> '
                    strHTMLAvailableHeadeRow += ' <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu"> '
                    strHTMLAvailableHeadeRow += ' <li><a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=\"(IrOpenBookRequest(' + objIrAvailableList.InfraResourceId + ' ))\"  >Resource Request</a> </li> </ul> '
                    strHTMLAvailableHeadeRow += ' </td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_1 + '">' + objIrAvailableList.Day_1 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_2 + '">' + objIrAvailableList.Day_2 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_3 + '">' + objIrAvailableList.Day_3 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class= "' + objIrAvailableList.ClDay_4 + '">' + objIrAvailableList.Day_4 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class ="' + objIrAvailableList.ClDay_5 + '">' + objIrAvailableList.Day_5 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_6 + '">' + objIrAvailableList.Day_6 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_7 + '">' + objIrAvailableList.Day_7 + '</td>'

                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_8 + '">' + objIrAvailableList.Day_8 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_9 + '">' + objIrAvailableList.Day_9 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_10 + '">' + objIrAvailableList.Day_10 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_11 + '">' + objIrAvailableList.Day_11 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_12 + '">' + objIrAvailableList.Day_12 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_13 + '">' + objIrAvailableList.Day_13 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_14 + '">' + objIrAvailableList.Day_14 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_15 + '">' + objIrAvailableList.Day_15 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_16 + '">' + objIrAvailableList.Day_16 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_17 + '">' + objIrAvailableList.Day_17 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_18 + '">' + objIrAvailableList.Day_18 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_19 + '">' + objIrAvailableList.Day_19 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_20 + '">' + objIrAvailableList.Day_20 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_21 + '">' + objIrAvailableList.Day_21 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_22 + '">' + objIrAvailableList.Day_22 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_23 + '">' + objIrAvailableList.Day_23 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_24 + '">' + objIrAvailableList.Day_24 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_25 + '">' + objIrAvailableList.Day_25 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_26 + '">' + objIrAvailableList.Day_26 + '</td>'
                    strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_27 + '">' + objIrAvailableList.Day_27 + '</td>'
                    if (objIrAvailableList.ClDay_28 != null) {
                        strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_28 + '">' + objIrAvailableList.Day_28 + '</td>'
                    }
                    if (objIrAvailableList.ClDay_29 != null) {
                        strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_29 + '">' + objIrAvailableList.Day_29 + '</td>'
                    }
                    if (objIrAvailableList.ClDay_30 != null) {

                        strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_30 + '">' + objIrAvailableList.Day_30 + '</td>'
                    }
                    if (objIrAvailableList.ClDay_31 != null) {
                        strHTMLAvailableHeadeRow += '<td class="' + objIrAvailableList.ClDay_31 + '">' + objIrAvailableList.Day_31 + '</td>'
                    }

                    strHTMLAvailableHeadeRow += '</tr>';
                });

            }
            else {

                // StopAjaxLoader("#bodyCapacityPalning-group");
                strHTMLAvailableHeadeRow += '<tr> <td colspan="31">' + NoDataFound + '</td></tr>';
                $('#lblTotalAvailable').html(0);
                StopAjaxLoader("#bodyProjectInfraResource-group");

                //$('#lblProjectTotalAllocation').html(0);
                //var dCurrentDate = new Date();
                //$("#hdnInfraAvailableMonthDate").val(dCurrentDate.getMonth() -1);



            }
            $("#IrAvailableTbodyDayRow").html(strHTMLAvailableHeadeRow);
            ///$("#IrAvailableTbodyDayHeader").html(strHTMLAvailableHeadeRow);

            // $('#IrAvailableTbodyDayHeader').dataTable().fnDestroy();
            // LoadPagination('#PRtable ', IrAvailableList);

            //StopAjaxLoader("#bodyProjectInfraResource-group");
            StopAjaxLoader("#bodyProjectInfraResource-group");

        }



        ///AAvilable Api call


        //Get date format
        function GetDateFormat() {
            $.ajax({
                url: strUrl + '/api/RM_ProjectInfraResources/GetDateCompanyDateFormat',
                type: "POST",
                data: JSON.stringify(SessionEmployeeId),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (SessionEmployeeId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(SessionEmployeeId) ? SessionEmployeeId : JSON.stringify(SessionEmployeeId)));
                    }
                },
                success: function (data) {
                    // console.log(data.InputDateFormat)
                    InputDateFormat = data.InputDateFormat
                    //console.log(InputDateFormat)
                    $('#hdnInfraInputDate').val(data.InputDateFormat)

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue  
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue  
                    }
                    else if (xhr.statusText == "Created") {

                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(thrownError);

                    }
                }

            })
        }


        function LoadPagination(tblId, data) {
            $.fn.DataTable.ext.pager.numbers_length = 10;
            $(tblId).dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": '100',
                "scrollResize": true,
                "scrollcollapse": true,
                "iDisplayLength": 1,
                "lengthChange": false,
                "searching": false,
                "destroy": true,

            });

        }

        //Added By Chetan M. For Bind Filter Placeholder on 20 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, 0), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value=0]").prop('selected', true);
            }
        }
        //End of Added By Chetan M. For Bind Filter Placeholder on 20 July 2021


        function OpenIrRequestApproval() {
            //debugger;
            var CurrentProjectId = $('#CboIrProjectForList').val();
            if (CurrentProjectId != '' && CurrentProjectId != 'undefined' && CurrentProjectId > 0) {
                $("#CboIrProjectForList").val(CurrentProjectId)
            } else {
                $("#CboIrProjectForList").val(0);
            }
            var ProjectID = $('#CboIrProjectForList').val();
            
            var url = "RM_IrRequestApproval.aspx?&ProjectID=" + ProjectID + "&Flag=True";
           
            window.location.href = url;
        }

        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
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
    </script>



</body>

</html>
