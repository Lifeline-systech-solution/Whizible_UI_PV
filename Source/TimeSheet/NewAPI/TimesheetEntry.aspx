<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TimesheetEntry.aspx.vb" Inherits="PbNIT.TimesheetEntry" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="X-UA-Compatible" content="IE=11">
    <title>Weekly Timesheet</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/jquery-ui.css">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap.min.css?v=1">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap-select.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0/fontawesome/css/all.css">
    <!-- bootstrap datepicker -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/bootstrap-datepicker.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/skins/_all-skins.min.css">
    <!-- custom scrollbar -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/jquery.mCustomScrollbar.css">

    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/animate.css">
    <!-- sticky table -->
    <link href='../../../Whizible2.0/dist/css/table-fixed-header.css' rel='stylesheet'>

    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom.css?v=2">

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/media_queries.css?v=1">

    <!--<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700" rel="stylesheet">-->
    <style type="text/css">
        /*body{ overflow: hidden; }*/

        .timesheettable .tbl-content {
            height: auto;
        }
    </style>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="bodyTSEntry" style="padding-right: 0px!important;">

    <section class="content">

        <!--Start html code for Desktop view only-->
        <div class="weeklytimesheetwrap hidden-xs">
            <div id="DivDailyTimesheetHeader" class="timesheetrow graybg container-fluid pt-1 pb-1 headertopp" style="display: none;">
                <div class="row">
                    <div class="col-md-3 col-sm-3 col-xs-6" title="Select Proxy User" id="ProxyResource">
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboProxyResource", "usp_Whizible2_Sel_tbl_CNF_ProxyUser_Mapping_Detail " & Session("intUserID"),,, "class='form-control selectpicker' onChange='javascript:ChangeProxyUser(this.value)'",,, ) %>
                    </div>
                    <div class="col-md-3 col-sm-3 col-xs-6" id="DivSelectedResource" style="display: none;">
                        <label class="resourcelabel pt-1"></label>
                    </div>

                    <div class="col-md-5 col-sm-5 col-xs-6">
                        <div class="weekly_calender" id="weeklyviewcal">

                            <button data-toggle="tooltip" data-placement="bottom" title="Previous Week" id="prev"><i class="fas fa-caret-left"></i></button>
                            <div class="input-group-box">
                                <div class="input-group" id="DateDemo">
                                    <input data-toggle="tooltip" data-placement="bottom" title="Select week date" class="form-control" type="text" id="weekPicker2" />
                                </div>
                            </div>
                            <button id="next" data-toggle="tooltip" data-placement="bottom" title="Next Week"><i class="fas fa-caret-right"></i></button>
                        </div>

                        <div class="weekly_calender" id="dailyviewcal" style="display: none;">
                            <button data-toggle="tooltip" data-placement="bottom" title="Previous Day" class="prev-day"><i class="fas fa-caret-left"></i></button>
                            <div class="input-group-box">
                                <div class="input-group" id="DateDemo">

                                    <input data-toggle="tooltip" data-placement="bottom" title="Select Day" id="dailyviewdatepicker" type="text" class="form-control" name="">
                                </div>

                            </div>
                            <button class="next-day" data-toggle="tooltip" data-placement="bottom" title="Next Day"><i class="fas fa-caret-right"></i></button>
                            <!-- /.input group -->
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-4 col-xs-12" id="DivTEFilterSection" style="display: none;">
                        <div class="weeklyanddaily">

                            <div class="tab-slider--nav">
                                <ul class="tab-slider--tabs">
                                    <li class="tab-slider--trigger active" rel="Weeklytab" data-toggle="tooltip" data-placement="bottom" title="Weekly Task View" onclick="changeView(1)"><span>Weekly</span></li>
                                    <li data-toggle="tooltip" data-placement="bottom" title="Daily Task View" class="tab-slider--trigger" onclick="changeView(0)" rel="Dailytab">Daily</li>
                                </ul>
                            </div>

                            <div class="filter pull-right">
                                <button data-toggle="collapse" data-target="#filterpanel"><i data-toggle="tooltip" data-placement="bottom" title="Advanced Filter" class="fas fa-filter"></i></button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-4  col-xs-12 pt-1" id="DivTVStatusSection" style="display: none;">

                        <strong>Status:</strong> <span class="Status"></span>

                        <div class="pull-right">
                            <div class="dropdown filedownload">
                                <button class="nostylebtn dropdown-toggle" data-toggle="dropdown" data-original-title="" title=""><i data-toggle="tooltip" title="Click here to download" class="fas fa-download" data-placement="bottom"></i></button>
                                <ul class="dropdown-menu">
                                    <li><a href="#" onclick="Export_PDFClick('PDF')">
                                        <img src="../../../Whizible2.0/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                    <li><a href="#" onclick="Export_PDFClick('EXCEL')">
                                        <img src="../../../Whizible2.0/dist/img/xls.svg" width="18px">Xlsx</a></li>
                                    <li><a href="#" onclick="Export_PDFClick('XML')">
                                        <img src="../../../Whizible2.0/dist/img/xml.svg" width="18px">Xml</a></li>
                                    <li><a href="#" onclick="Export_PDFClick('TEXT')">
                                        <img src="../../../Whizible2.0/dist/img/doc.svg" width="18px">Doc</a></li>
                                </ul>

                            </div>

                        </div>

                    </div>
                </div>
            </div>

            <%--  View Timesheet--%>
            <div class="timesheetrow bgwhite ts_headerbot container-fluid" id="DivViewTimesheetHeader" style="display: none;">

                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-5 pull-right">
                        <ul class="pull-right btnlistinline" id="ulBackButton" style="display: none;">
                            <li>
                                <a onclick="goBack()" id="" class="btn backbtn btnyellow ml-1 nobtnstyle-xs">Back</a>

                            </li>

                        </ul>
                        <ul class="pull-right btnlistinline" id="ulVTEdit">
                            <li>
                                <a onclick="goBack()" id="" class="btn backbtn btnyellow ml-1 nobtnstyle-xs">Back</a>
                                <a href="javascript:;" id="" class="btn borderbtn ml-1 nobtnstyle-xs editviewtimesheet" onclick="ShowEditMode()">Edit</a>

                                <a href="javascript:;" id="btnSaveVT" onclick="Save_VTOnClick()" class="btn savebtn btnyellow ml-1 nobtnstyle-xs viewtimesheetsavetbtn hidebtn">Save</a>

                            </li>
                            <li>
                                <button id="btnSubmit" class="btn savebtn btnyellow ml-1 nobtnstyle-xs" style="display: none;" onclick="SubmitTS_OnClick()">Submit</button>
                            </li>
                        </ul>
                        <ul class="pull-right btnlistinline" id="ulVTSave" style="display: none">
                            <li>
                                <a href="javascript:;" id="" class="btn borderbtn ml-1 nobtnstyle-xs editviewtimesheet" style="display: none;">Edit</a>
                                <a onclick="goBack()" id="" class="btn backbtn btnyellow ml-1 nobtnstyle-xs hidebtn" style="display: inline;">Back</a>
                                <a href="javascript:;" id="btnSaveVT" onclick="Save_VTOnClick()" class="btn savebtn btnyellow ml-1 nobtnstyle-xs viewtimesheetsavetbtn hidebtn" style="display: inline;">Save</a>

                            </li>
                            <li>
                                <button class="btn savebtn btnyellow ml-1 nobtnstyle-xs">Submit</button>
                            </li>
                        </ul>


                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-7">

                        <div class="input-group_btnbox workbtndiv pt-1 pb-1">

                            <div class="btn-group">
                                <button type="button" class="btn btn-default ">
                                    <span class="ActualHours">0</span>
                                </button>
                                <button type="button" class="btn btn-default workbtn">Actual Hours</button>
                            </div>
                            &nbsp;&nbsp;
                <div class="btn-group">
                    <button type="button" class="btn btn-default">
                        <span class="ExpectedHours">0</span>
                    </button>
                    <button type="button" class="btn btn-default workbtn">Expected Hours</button>
                </div>



                        </div>



                    </div>
                    <div class="clearfix"></div>
                </div>

            </div>
            <%--  Timesheet Approval Detail --%>
            <div id="DivTimesheetApprovalHeader" class="timesheetrow graybg container-fluid pt-1 pb-1 headertopp" style="display: none">
                <div class="row">
                    <div class="col-md-3 col-sm-3 col-xs-6">
                        <label class="resourcelabel pt-1"></label>
                    </div>
                    <div class="col-md-5 col-sm-5 col-xs-6">

                        <div class="weekly_calender" id="weeklyviewcal">

                            <button data-toggle="tooltip" data-placement="bottom" title="Previous Week" id="prev"><i class="fas fa-caret-left"></i></button>
                            <div class="input-group-box">
                                <div class="input-group" id="DateDemo">
                                    <input data-toggle="tooltip" data-placement="bottom" title="Select week date" class="form-control" type="text" id="weekPicker2" />
                                </div>
                            </div>
                            <button id="next" data-toggle="tooltip" data-placement="bottom" title="Next Week"><i class="fas fa-caret-right"></i></button>
                            <!-- /.input group -->
                        </div>


                    </div>
                    <div class="col-md-4 col-sm-4 col-xs-12 pt-1">

                        <strong>Status:</strong> <span class="Status">Not Submitted</span>

                        <div class="pull-right">
                            <div class="dropdown filedownload">
                                <button class="nostylebtn dropdown-toggle" data-toggle="dropdown"><i data-toggle="tooltip" title="Click here to download" class="fas fa-download" data-placement="bottom"></i></button>
                                <ul class="dropdown-menu">
                                    <li><a href="#" onclick="Export_PDFClick('PDF')">
                                        <img src="../../../Whizible2.0/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                    <li><a href="#" onclick="Export_PDFClick('EXCEL')">
                                        <img src="../../../Whizible2.0/dist/img/xls.svg" width="18px">Xlsx</a></li>
                                    <li><a href="#" onclick="Export_PDFClick('XML')">
                                        <img src="../../../Whizible2.0/dist/img/xml.svg" width="18px">Xml</a></li>
                                    <li><a href="#" onclick="Export_PDFClick('TEXT')">
                                        <img src="../../../Whizible2.0/dist/img/doc.svg" width="18px">Doc</a></li>
                                </ul>

                            </div>

                        </div>

                    </div>
                </div>
            </div>

            <!--filter panel start here-->
            <div id="filterpanel" class="collapse filterpanelwrap">
                <div class="filterpanelbody">

                    <div class="row hidden-xs">
                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div class="fplist_title">Projects</div>

                                <div id="Filterproject" class="selectpicker autocompletepicker" data-clear="true" data-live="true">

                                    <div class="dropdown-menu" style="display: block;">
                                        <div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true">
                                            <label class="sr-only" for="input-bts-ex-6">Search...</label>
                                            <div class="search-box">
                                                <div class="input-group">
                                                    <span class="input-group-addon" id="search-icon5">
                                                        <span class="fa fa-search"></span>
                                                        <a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Clear filter</span></a>
                                                    </span>
                                                    <input type="text" onkeyup="EmployeeSearchFuntion(this)" placeholder="Search..." id="input-bts-ex-5" class="form-control live-search" aria-describedby="search-icon5" tabindex="1" />
                                                </div>
                                            </div>
                                            <div class="list-to-filter">
                                                <ul class="list-unstyled">
                                                    <li class="optgroup">
                                                        <span class="optgroup-header">
                                                            <input id="checkAll" class="checkbox checkAll" type="checkbox" onchange="FilterProjectData()">All <span class="subtext"></span></span>
                                                        <ul class="list-unstyled fplist" id="ProjectFilterList">
                                                        </ul>
                                                    </li>
                                                </ul>
                                                <div class="no-search-results">
                                                    <div class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>No entry for <strong>'<span></span>'</strong> was found.</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" name="Filterproject" value="">
                                </div>

                            </div>
                        </div>

                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div class="fplist_title">Tasks type</div>

                                <div id="Filtertasktype" class="selectpicker autocompletepicker" data-clear="true" data-live="true">

                                    <div class="dropdown-menu" style="display: block;">
                                        <div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true">
                                            <label class="sr-only" for="input-bts-ex-6">Search...</label>
                                            <div class="search-box">
                                                <div class="input-group">
                                                    <span class="input-group-addon" id="search-icon5">
                                                        <span class="fa fa-search"></span>
                                                        <a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Clear filter</span></a>
                                                    </span>
                                                    <input type="text" placeholder="Search..." id="input-bts-ex-5" class="form-control live-search" aria-describedby="search-icon5" tabindex="1" />
                                                </div>
                                            </div>
                                            <div class="list-to-filter">
                                                <ul class="list-unstyled">
                                                    <li class="optgroup">
                                                        <span class="optgroup-header">
                                                            <input class="checkbox checkAll" type="checkbox">
                                                            All <span class="subtext"></span></span>
                                                        <ul class="list-unstyled fplist" id="TaskTypeFilterList">
                                                        </ul>
                                                    </li>
                                                </ul>
                                                <div class="no-search-results">
                                                    <div class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>No entry for <strong>'<span></span>'</strong> was found.</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" name="Filterproject" value="">
                                </div>

                            </div>
                        </div>

                        <div class="col-sm-2">
                            <div class="fplistbox" style="margin-bottom: 20px;">
                                <div class="fplist_title">Tasks Categories</div>

                                <ul class="fplist" id="TaskCategoryFilterList">
                                </ul>
                            </div>

                            <div class="fplistbox">
                                <div class="fplist_title">Billable</div>
                                <ul class="fplist" id="BillableFilterList">
                                </ul>
                            </div>
                        </div>

                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div class="fplist_title">Status</div>
                                <ul class="fplist" id="TaskStatusFilterList">
                                </ul>
                            </div>
                        </div>

                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div class="fplist_title">Priority</div>
                                <ul class="fplist" id="TaskPriorityFilterList">
                                </ul>
                            </div>
                        </div>

                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div class="fplist_title">Phase</div>
                                <ul class="fplist" id="TaskPhaseFilterList">
                                </ul>
                            </div>
                        </div>

                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div class="fplist_title">Milestone</div>
                                <ul class="fplist" id="TaskMilestoneFilterList">
                                </ul>
                            </div>
                        </div>

                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div class="fplist_title">Deliverable</div>
                                <ul class="fplist" id="TaskDeliverableFilterList">
                                </ul>
                            </div>
                        </div>

                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div class="fplist_title">Sub Project</div>
                                <ul class="fplist" id="TaskSubProjectFilterList">
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div class="fplist_title">Module</div>
                                <ul class="fplist" id="TaskModuleFilterList">
                                </ul>
                            </div>
                        </div>

                        <div class="clearfix"></div>
                    </div>

                    <div class="fp_button text-center hidden-xs">
                        <a href="javascript:;" class="uncheckbtn btn borderbtn" data-toggle="collapse" data-target="#filterpanel">Cancel</a>
                        <a href="javascript:;" class="btn borderbtn active" data-toggle="modal" onclick="GetFilterResultCount()">Apply</a>
                    </div>

                </div>
            </div>
            <!--filter panel end here-->

            <div id="DivDailyFilterPanel" class="timesheetrow container-fluid bgwhite ts_headerbot" style="display: none;">
                <div class="row">
                    <div class="col-md-6 col-sm-5 col-xs-5 pull-right">
                        <ul class="pull-right btnlistinline">
                            <li class="hidden-xs">
                                <a onclick="ViewTimesheet()" class="btn borderbtn ml-1 nobtnstyle-xs">View Timesheet</a>
                            </li>
                            <li>
                                <button id="modalapendbtn" class="btn borderbtn ml-1 nobtnstyle-xs" data-toggle="modal" onclick="clearCreateTaskData()" data-target="#createtaskmodal">Create Task <i class="fas fa-eye"></i></button>
                            </li>
                            <li>
                                <button id="btnSave" class="btn savebtn btnyellow ml-1 nobtnstyle-xs" onclick="Save_OnClick();">SAVE <i class="fas fa-save"></i></button>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-6 col-sm-7 col-xs-7 pr-0 ">
                        <ul class="statustext hidden-xs">
                            <li onclick='TaskCounterOnClick(this,"Critical")' id="CriticalTaskCounter" data-toggle="tooltip" data-placement="bottom" title="All mpp tasks marked as critical task will be displayed" class="criticle"><a href="javascript:;"><span class="statustextno" id="CriticalTask"></span>Critical Task</a></li>
                            <li onclick='TaskCounterOnClick(this,"Pending")' id="PendingTaskCounter" data-toggle="tooltip" data-placement="bottom" title="All the assigned tasks which are not completed will be displayed" class="overdue"><a href="javascript:;"><span class="statustextno" id="PendingTask"></span>Pending Task</a></li>
                            <li onclick='TaskCounterOnClick(this,"Slippage")' id="SlippageTaskCounter" data-toggle="tooltip" data-placement="bottom" title="This displays tasks slipping by efforts, not started as per start date, and not completed as per end date" class="pending"><a href="javascript:;"><span class="statustextno" id="SlippingTask"></span>Slipping Task</a></li>
                            <li onclick='TaskCounterOnClick(this,"Schedule")' id="ScheduleTaskCounter" data-toggle="tooltip" data-placement="bottom" title="Scheduled Task" class="schedule"><a href="javascript:;"><span class="statustextno" id="ScheduledTask"></span>Scheduled</a></li>
                        </ul>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>

            <!-- Timesheet Approval -->
            <div id="DivTAFilterPanel" class="timesheetrow bgwhite ts_headerbot container-fluid" style="display: none;">

                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-5 pull-right">
                        <ul class="pull-right btnlistinline mt-1">
                            <li>
                                <a href="TimesheetApproval.aspx?Flag=3&StartDate=<%= Request.QueryString("StartDate")%>&SelectedStatus=<%= Request.QueryString("SelectedStatus")%>" id="" class="btn backbtn btnyellow ml-1 nobtnstyle-xs hidebtn" style="display: inline;">Back</a>
                            </li>
                            <li>
                                <button id="btnRejectT" onclick="RejectTimesheet()" class="btn borderbtn ml-1 nobtnstyle-xs" data-target="#rejectmodal">Reject</button>
                            </li>
                            <li>
                                <button id="btnApproveT" data-toggle="modal" onclick="ApproveTimesheet()" class="btn savebtn btnyellow ml-1 nobtnstyle-xs">Approve</button>
                            </li>
                        </ul>


                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-7">

                        <div class="input-group_btnbox workbtndiv pt-1 pb-1">

                            <div class="btn-group">
                                <button type="button" class="btn btn-default ">
                                    <span class="ActualHours">0</span>
                                </button>
                                <button type="button" class="btn btn-default workbtn">Actual Hours</button>
                            </div>
                            &nbsp;&nbsp;
                <div class="btn-group">
                    <button type="button" class="btn btn-default">
                        <span class="ExpectedHours">0</span>
                    </button>
                    <button type="button" class="btn btn-default workbtn">Expected Hours</button>
                </div>



                        </div>



                    </div>
                    <div class="clearfix"></div>
                </div>

            </div>
            <!--bootstrap_Alertify-->
            <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" hidden="hidden">
                <button type="button" class="close">×</button>
                <p id="alertMsg"></p>
            </div>
            <!--bootstrap_Alertify-->

            <div id="Weeklytab" class="tab-slider--body">

                <div class="table-outer">
                    <div class="timesheettable">
                        <div class="tbl-content">
                            <table class="table table-hover table-bordered table-fixed-header approvaldetailtble">
                                <thead class='header' id="timesheetHeader">
                                </thead>

                                <tbody id="timesheetBody">
                                </tbody>
                            </table>


                        </div>
                        <div class="clearfix"></div>
                    </div>

                </div>
            </div>

            <!--weekly-tab-end-->

            <!--Daily tab content start here-->
            <div id="Dailytab" class="tab-slider--body">
                <div class="table-outer">
                    <div class="timesheettable hidden-xs">
                        <div class="tbl-content">
                            <table class="table table-hover table-bordered table-fixed-header" id="dailyTimesheetTable">
                            </table>
                            <!--project end here-->

                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <!--Daily tab content end here-->

            <!--all modal start here-->

            <!-- Modal -->
            <div id="Schedule" class="modal fade custmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Schedule time entry</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-2"></div>
                                <div class="col-md-8">
                                    <div class="entryform scheduleform" id="ScheduleTSEntryForm">
                                    </div>
                                </div>
                                <div class="col-md-2"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--modalEnd-->

            <!--create task modal -->
            <div id="createtaskmodal" class="modal fade custmodal largcustmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Create Task</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="entryform scheduleform">

                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-4 text-right">Select Date:</div>
                                                <div class="col-xs-12 col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-10 col-sm-8">
                                                            <input type="text" class="form-control" id="CTselectdate" placeholder="Select Date" name="">
                                                            <span class="startdateicon">
                                                                <img class="weeklycalender_icon" src="../../../Whizible2.0/dist/img/calendar.svg" alt="" width="20px"></span>
                                                        </div>
                                                        <%--<div class="col-xs-2 col-sm-4">
                                                            <span class="startdateicon">
                                                                <img class="weeklycalender_icon" src="../../../Whizible2.0/dist/img/calendar.svg" alt="" width="20px"></span>
                                                        </div>--%>
                                                        <div class="clearfix"></div>
                                                        <small class="mandatorymsg">* Future date as task completion date may impact all the reports in the Whizible</small>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-4 text-right">Select Project:</div>
                                                <div class="col-xs-12 col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-10 col-sm-8">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_ListOfProject_QuickTask " & Session("intUserID"),,, "class='form-control selectpicker' onChange='javascript:ProjectOnChange(this.value);'", True,, ) %>
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4"></div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-4 text-right">Task:</div>
                                                <div class="col-xs-12 col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-10 col-sm-8">
                                                            <input class="form-control" type="text" id="txtTaskName" value="" placeholder="Task" name="">
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4"></div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-4 text-right">Task Type:</div>
                                                <div class="col-xs-12 col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-10 col-sm-8">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", "select '' ",,, "class='form-control selectpicker' onChange='javascript:TaskTypeOnChange(this.value);'", True,,) %>
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4"></div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-4 text-right">Sub Task:</div>
                                                <div class="col-xs-12 col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-10 col-sm-8">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboSubTaskType", "select '' ",,, "class='form-control selectpicker'", True,, ) %>
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4"></div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-4 text-right">Priority</div>
                                                <div class="col-xs-12 col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-10 col-sm-8">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_Whizible2_Sel_tbl_IB_Priorities",,, "class='form-control selectpicker'", True,, ) %>
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4"></div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-4 text-right">Actual Time:</div>
                                                <div class="col-xs-12 col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-10 col-sm-8">
                                                            <input class="hrss form-control" type="text" value="" id="txtWorkHrs" placeholder="00:00" name="">
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4"></div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-4 text-right">% Actual Complete:</div>
                                                <div class="col-xs-12 col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-10 col-sm-8">
                                                            <input class="form-control" type="text" id="txtActualComplete" value="" placeholder="Hrs" name="">
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4"></div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-4 text-right">Description:</div>
                                                <div class="col-xs-12 col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-12">
                                                            <textarea class="form-control" id="txtDescription"></textarea>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group mt-4">
                                            <div class="row">
                                                <div class="col-xs-6 col-sm-6 text-left">
                                                    <button class="btn borderbtn ml-1" data-dismiss="modal">Cancel</button>
                                                </div>
                                                <div class="col-xs-6 col-sm-6 text-right">
                                                    <button id="btnCreateTask" class="btn savebtn btn-success ml-1" onclick="CreateTask_Save_OnClick(1);">Save</button>
                                                    <button id="btnSaveCreateTask" class="btn btnyellow ml-1" onclick="CreateTask_Save_OnClick(2);">Save & create new</button>
                                                </div>
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
            <!--modalEnd-->
            <!--create task modal end-->

            <!--create task modal -->
            <div id="requestadditionaltime" class="modal fade custmodal largcustmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Request Additional Time</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="entryform scheduleform" id="requestadditionaltimePopup">
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--modalEnd-->
            <!--create task modal end-->

            <!-- View Timesheet -->
            <div id="viewtimesheet" class="modal fade custmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">View Timesheet</h4>
                        </div>
                        <div class="modal-body">
                            Coming Soon

                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--modalEnd-->

            <div id="selectprojecttask" class="modal fade custmodal largcustmodal selectprojecttask" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Select Project / Task</h4>
                        </div>

                        <div class="modal_task_hader graybg">
                            <div class="row">
                                <div class="col-sm-6 col-md-6">
                                    <div class="row">
                                        <label class="col-xs-3">Project :</label>
                                        <div class="col-xs-9">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboFilteredProject", "Select '' ",,, "class='form-control selectpicker' onChange='javascript:ProjectFilterDrop_OnChange(this.value);'",,, ) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-2 col-md-2">
                                    <div class="modalhead_projectid" id="ProjectCode"></div>
                                </div>
                                <div class="col-sm-3 col-md-3">
                                    <div class="modalheader_startandenddate" id="startdateandenddate">
                                    </div>
                                </div>
                                <div class="col-sm-1 col-md-1">
                                    <i data-toggle="collapse" data-target="#modaltaskfilte" data-placement="top" title="Advanced Filter" class="fas fa-filter modalheadtaskfilter"></i>

                                    <div id="modaltaskfilte" class="selectpicker autocompletepicker collapse tblfiltering" data-clear="true" data-live="true">
                                        <div class="dropdown-menu" style="display: block;">
                                            <div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true">
                                                <label class="sr-only" for="input-bts-ex-6">Search...</label>
                                                <div class="search-box">
                                                    <div class="input-group">
                                                        <span class="input-group-addon" id="search-icon5">
                                                            <span class="fa fa-search"></span>
                                                            <a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Clear filter</span></a>
                                                        </span>
                                                        <input type="text" placeholder="Search..." id="input-bts-ex-5" class="form-control live-search" aria-describedby="search-icon5" tabindex="1" />
                                                    </div>
                                                </div>
                                                <div class="list-to-filter">
                                                    <ul class="list-unstyled">
                                                        <li class="optgroup">
                                                            <span class="optgroup-header">
                                                                <input id="checkAll" class="checkbox checkAll" type="checkbox" onchange="TaskCategory_OnChange()">All <span class="subtext"></span></span>

                                                            <ul class="list-unstyled" id="FilterTaskCategories">
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                    <div class="no-search-results">
                                                        <div class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>No entry for <strong>'<span></span>'</strong> was found.</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="Filterproject" value="">
                                        <div class="clarfix"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-body">
                            <div class="fixedtable_container">
                                <table id="fixedtbl1" class="table cust_fixed_tbl">
                                    <thead>
                                        <tr>
                                            <th>
                                                <div class="custom_chckbox">
                                                    <input class="checkAll" type="checkbox" id="Tapprovalall">
                                                    <label for="Tapprovalall"></label>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="row">
                                                    <label class="col-xs-3">Task</label>
                                                    <div class="col-xs-9">
                                                        <div class="tasksearch" style="max-width: 300px;">
                                                            <div class="input-group stylish-input-group">

                                                                <input id="projecttasksearch" type="text" class="form-control" placeholder="Search" autocomplete="off">
                                                                <span class="input-group-addon">
                                                                    <button type="submit">
                                                                        <span class="glyphicon glyphicon-search"></span>
                                                                    </button>
                                                                </span>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </th>

                                        </tr>
                                    </thead>
                                    <tbody id="FilterTaskBody">
                                    </tbody>

                                </table>
                                <div class="clearfix"></div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button class="btn borderbtn pull-left uncheckbtn" data-dismiss="modal">Cancel</button>
                            <button class="btn btnyellow" onclick="FilterTaskFromList()">Select</button>
                            <div class="clearfix"></div>
                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--modalEnd-->

            <div id="selectsubtask" class="modal fade custmodal largcustmodal selectprojecttask" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Select sub tasks</h4>
                        </div>

                        <div class="modal_task_hader graybg">
                            <div class="row">
                                <div class="col-md-4" id="subTaskListPopupProjectName">
                                </div>
                                <div class="col-md-7" id="subTaskListPopupTaskName">
                                    <div class=""></div>
                                </div>

                            </div>
                        </div>

                        <div class="modal-body">
                            <div class="fixedtable_container">
                                <table id="fixedtbl2" class="table table-stripped cust_fixed_tbl">
                                    <thead>
                                        <tr>
                                            <th>
                                                <div class="custom_chckbox">
                                                    <input class="checkAll" type="checkbox" id="chkSubTask">
                                                    <label for="chkSubTask"></label>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="row">
                                                    <label class="col-xs-3">Task</label>
                                                    <div class="col-xs-9">
                                                        <div class="tasksearch" style="max-width: 300px;">
                                                            <div class="input-group stylish-input-group">

                                                                <input id="subtasksearch" type="text" class="form-control" placeholder="Search" autocomplete="off">
                                                                <span class="input-group-addon">
                                                                    <button type="submit">
                                                                        <span class="glyphicon glyphicon-search"></span>
                                                                    </button>
                                                                </span>
                                                            </div>

                                                        </div>

                                                    </div>
                                                </div>
                                            </th>

                                        </tr>
                                    </thead>
                                    <tbody id="SubTaskListTable">
                                    </tbody>

                                </table>
                                <div class="clearfix"></div>
                            </div>
                            <div class="clearfix"></div>

                        </div>

                        <div class="modal-footer">
                            <button class="btn borderbtn pull-left" data-dismiss="modal">Cancel</button>
                            <button class="btn btnyellow" onclick="SelectSubTask_OnClick()">Save</button>
                            <div class="clearfix"></div>
                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--modalEnd-->

            <div id="projecttimeinfomodal" class="modal fade custmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Lorem Ipsum</h4>
                        </div>
                        <div class="modal-body">
                            Coming Soon

                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--modalEnd-->
            <!--modalstart-->
            <div id="entryfiltermodalinfo" class="modal fade custmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Advance Filter Result</h4>
                        </div>
                        <div class="modal-body">
                            <p id="FilterResultMsg"></p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn borderbtn pull-left uncheckbtn" data-dismiss="modal">No</button>
                            <button class="btn btnyellow" data-toggle="modal" data-target="#selectprojecttask" data-original-title="" data-dismiss="modal" title="" onclick="PlotFilterTaskList(0)">Yes</button>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--modalEnd-->
            <!--Confirmation message Modal-->
            <div id="ConfirmMessagemodalinfo" class="modal fade custmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Message</h4>
                        </div>
                        <div class="modal-body">
                            <p id="ConfirmationMsg"></p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn borderbtn pull-left uncheckbtn" data-dismiss="modal" onclick="SendConfirmationResponse(0)">No</button>
                            <button class="btn btnyellow" data-toggle="modal" data-original-title="" data-dismiss="modal" title="" onclick="SendConfirmationResponse(1)">Yes</button>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--Confirmation message Modal modalEnd-->
            <!--Confirmation message Modal-->
            <div id="ConfirmMessageModalCreateTask" class="modal fade custmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Message</h4>
                        </div>
                        <div class="modal-body">
                            <p id="ConfirmationMsgCreateTask"></p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn borderbtn pull-left" data-dismiss="modal" onclick="SendConfirmationResponseForCreateTask(0)">No</button>
                            <button class="btn btnyellow" data-toggle="modal" data-original-title="" data-dismiss="modal" title="" onclick="SendConfirmationResponseForCreateTask(1)">Yes</button>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--Confirmation message Modal modalEnd-->

            <!--rejectmodal-->
            <div id="rejecttaskmodal" class="modal fade custmodal rejecttaskmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header ui-draggable-handle">
                            <button type="button" class="close" data-dismiss="modal">×</button>
                            <h4 id="lblEmployeeName" class="modal-title" style="display: none;">Reject Timesheet - Employee Name 1</h4>
                            <h4 id="lblRejectTaskEmployeeName" class="modal-title" style="display: none;">Reject Task - Employee Name 1</h4>
                            <center><small id="lblFromDateToDate">28-05-2018 &nbsp;To &nbsp; 03-06-2018</small></center>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4 text-right">Reason for rejection:</div>
                                    <div class="col-xs-12 col-sm-8">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-12">
                                                <textarea class="form-control" id="txtRejectionComment" maxlength="200">
                                                                      
                                                                    </textarea>
                                            </div>
                                            <div class="col-xs-2 col-sm-4"></div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4 text-right">&nbsp;</div>
                                    <div class="col-xs-12 col-sm-8">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-12">

                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="rejecttaskmodalcheckbox">
                                                    <label for="rejecttaskmodalcheckbox">Allow resource to change timesheet and resubmit</label>
                                                </div>

                                            </div>
                                            <div class="col-xs-2 col-sm-4"></div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-left">
                                        <button class="btn borderbtn ml-1" data-dismiss="modal">Cancel</button>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 pull-right" id="btnRejectTimesheet" onclick="RejectAllTimesheet()">Reject</button>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--modalEnd-->

            <!--approvemodal-->
            <div id="approvetaskbtnmodal" class="modal fade custmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Approve Timesheet</h4>
                        </div>

                        <div class="modal-body">

                            <div class="form-group" id="divTaskBlock">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4 text-right">Task Name:</div>
                                    <div class="col-xs-12 col-sm-8">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-12" id="divTaskName">
                                                Lorem Ipsum dummy task
                                            </div>
                                            <div class="col-xs-2 col-sm-4"></div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4 text-right">Comment:</div>
                                    <div class="col-xs-12 col-sm-8">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-12">
                                                <textarea class="form-control" id="txtApprovalComment" maxlength="200">
                                                                      
                                                                    </textarea>
                                            </div>
                                            <div class="col-xs-2 col-sm-4"></div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-left">
                                        <button class="btn borderbtn ml-1" data-dismiss="modal">Cancel</button>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 pull-right" id="btnApproveTimesheet" onclick="ApproveAllTimesheet()">Approve</button>

                                    </div>
                                </div>
                            </div>


                        </div>


                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--modalEnd-->

            <!--all modal end here-->

        </div>

        <div class="clearfix"></div>

        <!--end Entry screen desktop View-->

    </section>

    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
    <script src="../../../Whizible2.0/plugins/jQuery/jQuery-2.1.4.min.js"></script>

    <!-- <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->

    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0/plugins/jQueryUI/jquery-ui.min.js"></script>

    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap-select.js"></script>

    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap.min.js"></script>

    <!--daterangepicker-->
    <script src="../../../Whizible2.0/dist/js/moment.min.js"></script>
    <!--bootstrapdatepicker-->
    <!-- <script src="../../../Whizible2.0/dist/js/bootstrap-datepicker.min.js"></script> -->
    <script src="../../General/CommonValidations.js"></script>
    <!--autofilter-->
    <script src="../../../Whizible2.0/dist/js/autocomplete/tabcomplete.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/autocomplete/livefilter.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/autocomplete/bootstrap-select-autocomplete.js"></script>
    <!-- stickytable js -->
    <!--<script src="../../../Whizible2.0/dist/js/table-fixed-header.js"></script>-->

    <script src="../../../Whizible2.0/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/loadingoverlay_progress.js"></script>
    <!-- custome js -->
    <script src="../../../Whizible2.0/dist/js/custom.js"></script>

    <script>
        $("#ProxyResource").mouseover(function () {
            $("#ProxyResource .dropdown-toggle").tooltip('hide');
        });
        //filter_search
        function EmployeeSearchFuntion(element) {

            var value = $(element).val().toLowerCase();
            $("#ProjectFilterList > li").each(function () {
                if ($(this).text().toLowerCase().indexOf(value) > -1) {
                    $(this).show();

                } else {
                    $(this).hide();

                }
            });
        }

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var startingDayOfWeek;
        var FinancialYearStart;
        //$(document).ready(function () {
        $.ajax({
            url: strUrl + '/api/Common/GetCompanyInformation',
            type: "POST",
            dataType: "json",
            contentType: "application/json;charset-utf=8",
            async: false,
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
            },
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    var d = data[i];
                    startingDayOfWeek = d.StartingDayOfWeek;
                    FinancialYearStart = d.FinancialYearStart;
                }
            },
            error: function (err) {
                console.log(err);
            }
        });
        //});
        var isWeeklyView = 1;
        var actionOnDuration = false;
        var intMaxEntry = 24;
    </script>
    <!--weekpicker-->
    <script type="text/javascript" src="../../../Whizible2.0/dist/js/weekPicker.js"></script>

    <script type="text/javascript">
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

        var EmployeeID;
        var UserName;
        EmployeeID = '<%= Session("intUserID") %>';
        UserName ='<%= Session("strUserName") %>';
        $('#next').click(function () {
            if (PageFlag == 2) {
                setWeekCalendar($('#weekPicker2'), 'next', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("StartDate")%>'));
                ReloadTApprovalData(EmployeeID);
            }
            else if (PageFlag == 3) {
                setWeekCalendar($('#weekPicker2'), 'next', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("FromDate")%>'));
                ReloadTApprovalData(EmployeeID);
            }
            else {
                setWeekCalendar($('#weekPicker2'), 'next', 1, startingDayOfWeek, FinancialYearStart);
                ReloadData(EmployeeID);
            }
        });

        $('#prev').click(function () {
            if (PageFlag == 2) {
                setWeekCalendar($('#weekPicker2'), 'prev', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("StartDate")%>'));
                ReloadTApprovalData(EmployeeID);
            }
            else if (PageFlag == 3) {
                setWeekCalendar($('#weekPicker2'), 'prev', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("FromDate")%>'));
                ReloadTApprovalData(EmployeeID);
            }
            else {
                setWeekCalendar($('#weekPicker2'), 'prev', 1, startingDayOfWeek, FinancialYearStart);
                ReloadData(EmployeeID);
            }
        });


        $('.next-day').click(function () {
            setWeekCalendar($('#dailyviewdatepicker'), 'next', 0, startingDayOfWeek, FinancialYearStart);
            plotDailyTaskList();
        });

        $('.prev-day').click(function () {
            setWeekCalendar($('#dailyviewdatepicker'), 'prev', 0, startingDayOfWeek, FinancialYearStart);
            plotDailyTaskList();
        });
        var PageFlag = 0;
        var TimesheetID = 0;
        var ViewTimesheetID = 0;
        $(document).ready(function () {
            PageFlag = '<%= Request.QueryString("Flag")%>';


            showSection();
            if ($('#cboProxyResource option').length <= 1) {
                $(".selectpicker").selectpicker('refresh');
                $('#ProxyResource .bootstrap-select').css("display", "none");
            }
            if (PageFlag == 2) {
                setWeekCalendar($('#weekPicker2'), 'Selected', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("StartDate")%>'));
                EmployeeID = '<%= Request.QueryString("EmployeeID")%>';
               
                $("#cboProxyResource option[value='" + EmployeeID + "']").attr("selected", "selected");
                 if (EmployeeID == 0) {EmployeeID = '<%= Session("intUserID") %>';}
            }
            else if (PageFlag == 3) {
                setWeekCalendar($('#weekPicker2'), 'Selected', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("FromDate")%>'));
            }
            else if (PageFlag == 1) {
                setWeekCalendar($('#weekPicker2'), 'Selected', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("StartDate")%>'));
                setWeekCalendar($('#dailyviewdatepicker'), 'Selected', 0, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("StartDate")%>'));
                EmployeeID = '<%= Request.QueryString("EmployeeID")%>';

                $("#cboProxyResource option[value='" + EmployeeID + "']").attr("selected", "selected");
                 if (EmployeeID == 0) {EmployeeID = '<%= Session("intUserID") %>';}
            }
            else {
                setWeekCalendar($('#weekPicker2'), 'yes', 1, startingDayOfWeek, FinancialYearStart);
                setWeekCalendar($('#dailyviewdatepicker'), 'yes', 0, startingDayOfWeek, FinancialYearStart);
            }


            if (PageFlag == 0 || PageFlag == 1) {
                if (isWeeklyView == 1)
                    ReloadData(EmployeeID);
                else
                    plotDailyTaskList();
            }
            else if (PageFlag == 2) {
                ViewTimesheetID = '<%= Request.QueryString("TimesheetID")%>';
                
                ReloadTApprovalData(EmployeeID);
            }
            else if (PageFlag == 3) { ReloadTApprovalData(EmployeeID); }
            $("#fixedtbl1").freezeHeader({
                'height': '300px'
            });
            $("#fixedtbl2").freezeHeader({
                'height': '300px'
            });
            $("#weekPicker2").change(function () {
                if (PageFlag == 2) {
                    ReloadTApprovalData(EmployeeID);
                }
                else {
                    ReloadData(EmployeeID);
                }
            })
            $("#dailyviewdatepicker").change(function () {
                plotDailyTaskList();
            })
            $("#CTselectdate").change(function () {
                BindProjects();
            })
            $('.ClosaeblealertMsg').hide();

            $(document).on('click', '.close', function () {
                //alert(this.id);
                //debugger
                var id = this.id.split("close_")[1];
                //$('#popover-content-' + id).parent().hide();
                $(".popover").hide();
                //$(this).parent().hide();
            });
        });
        function showSection() {

            if (PageFlag == 0 || PageFlag == 1) {
                $("#DivDailyTimesheetHeader").attr('style', 'display:block');
                $("#DivDailyFilterPanel").attr('style', 'display:block');
                $("#DivTEFilterSection").attr('style', 'display:block');
            }
            if (PageFlag == 2) {
                $("#DivDailyTimesheetHeader").attr('style', 'display:block');
                $("#DivViewTimesheetHeader").attr('style', 'display:block');
                $("#DivTVStatusSection").attr('style', 'display:block');
                //$(".timenoinput").prop('disabled', true);

                //$(".timenoinput").attr('disabled','disabled');
            }
            if (PageFlag == 3) {
                $("#DivDailyTimesheetHeader").attr('style', 'display:block');
                $("#DivSelectedResource").css("display", "block");
                $("#ProxyResource").css("display", "none");
                //$("#DivTimesheetApprovalHeader").attr('style', 'display:block');
                $("#DivTVStatusSection").attr('style', 'display:block');
                $("#DivTAFilterPanel").attr('style', 'display:block');
                $('#weeklyviewcal').css('pointer-events', 'none');
            }

        }
        function ShowEditMode() {
            // alert(ViewTimesheetID);
            if (ViewTimesheetID != 0) {
                //ViewTimesheetID = 0;
                ReloadData(EmployeeID);
            }
            //debugger;
            //$("#ulVTEdit").attr('style', 'display:none');
            //$("#ulVTSave").attr('style', 'display:block');
            $('.timenoinput').css('pointer-events', 'unset');

        }

        function ChangeProxyUser(intEmployeeID) {
            if (intEmployeeID == 0) {
                intEmployeeID = '<%= Session("intUserID") %>';
            }
            (PageFlag == 2 ? ReloadTApprovalData(intEmployeeID) : ReloadData(intEmployeeID))
        }
        function ViewTimesheet() {
            var EmpID = $("#cboProxyResource option:selected").val();
           
            var startDate = new Date($("#weekPicker2").attr("StartDate"));
            window.location.href = "TimesheetEntry.aspx?Flag=2&StartDate=" + startDate + "&TimesheetID=" + TimesheetID + "&EmployeeID="+ EmpID +"";
        }
        function Save_VTOnClick() {
            Save_OnClick();
            //$("#ulVTEdit").css('display', 'block');
            $('.timenoinput').css('pointer-events', 'none');
        }
        function goBack() {
            // debugger;
            var startDate
            if (isWeeklyView == 1)
                startDate = new Date($("#weekPicker2").attr("StartDate"));
            else
                startdate = new Date($('#dailyviewdatepicker').attr("selecteddate"));

            var EmpID = $("#cboProxyResource option:selected").val();
            //setWeekCalendar($('#weekPicker2'), 'Selected', 1, startingDayOfWeek, FinancialYearStart, new Date(startDate));
            //setWeekCalendar($('#dailyviewdatepicker'), 'Selected', 0, startingDayOfWeek, FinancialYearStart, new Date(startDate));
            if ('<%= Request.QueryString("FromPage")%>' == 'MyTimesheet') {
                window.location.href = "MyTimesheet.aspx?PageFlag=4&EmployeeID="+EmpID+"";
            }
            else {
                window.location.href = "TimesheetEntry.aspx?Flag=1&StartDate=" + startDate + "&EmployeeID="+ EmpID +""
            }
            
        }
        function clearCreateTaskData() {
            $("#txtTaskName").val("");
            $("#txtActualComplete").val("");
            $("#txtDescription").val("");
            //$(".selectpicker").selectpicker('refresh');
            //$('#cboProject').text("");
            $('#cboProject option[value=""]').prop('selected', false);
            $('#cboProject option').each(function () {
                $(this).removeAttr("selected");
            });
        }
        var WhichTask = "";
        function TaskCounterOnClick(obj, filter) {
            if ($('#CriticalTaskCounter').hasClass("active"))
                $('#CriticalTaskCounter').removeClass("active");
            if ($('#PendingTaskCounter').hasClass("active"))
                $('#PendingTaskCounter').removeClass("active");
            if ($('#SlippageTaskCounter').hasClass("active"))
                $('#SlippageTaskCounter').removeClass("active");
            if ($('#ScheduleTaskCounter').hasClass("active"))
                $('#ScheduleTaskCounter').removeClass("active");

            $(obj).addClass("active");
            WhichTask = filter;
            if (isWeeklyView == 1)
                ReloadData(EmployeeID);
            else
                plotDailyTaskList();
        }
        var IsDefault = 0;
        function ReloadData(ProxyResourceID) {
            if (ProxyResourceID == 0)
                ProxyResourceID = EmployeeID;
            else
                EmployeeID = ProxyResourceID;
            var taskParameters = {
                intEmployeeID: ProxyResourceID,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                intIsDefault: IsDefault,
                strWhichTask: WhichTask,
                strTaskIDList: TaskIDList,
                strFilterProjectList: "",
                strFilterTaskTypeList: "",
                strFilterTaskCategories: "",
                strFilterBillable: "",
                strFilterPriorityList: "",
                strFilterPhaseList: "",
                strFilterMilestoneList: "",
                strFilterSubProjectList: "",
                strFilterModuleList: "",
                strFilterDeliverableList: "",
                strFilterTaskStatus: "",
                SubTaskTypeList: SubTaskTypeList
            }
            StartLoader("#bodyTSEntry");
            $.ajax({
                url: strUrl + '/api/Timesheet/GetTaskData',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var Timesheet = data;
                    plotHeaderSection(Timesheet.headerColumns);
                    plotCountSection(Timesheet.TaskCount);
                    plotProjectFilterSection(Timesheet.ProjectFilterLists);
                    plotTaskTypeFilterSection(Timesheet.filters.TaskTypeFilterLists);
                    plotCategoryFilterSection(Timesheet.TaskCategoryFilterLists);
                    plotStatusFilterSection(Timesheet.TaskStatusFilterLists);
                    plotPriorityFilterSection(Timesheet.TaskPriorityFilterLists);
                    plotBillableFilterSection(Timesheet.BillableFilterLists);
                    plotPhaseFilterSection(Timesheet.filters.PhaseFilterLists);
                    plotMileStoneFilterSection(Timesheet.filters.MileStoneFilterLists);
                    plotDeliverableFilterSection(Timesheet.filters.DeliverableFilterLists);
                    plotSubProjectFilterSection(Timesheet.filters.SubProjectFilterLists);
                    plotModuleFilterSection(Timesheet.filters.ModuleFilterLists);
                    plotTaskList(Timesheet.timesheetLists);
                    plotWeekTotal(Timesheet.WeekTotalLists);



                    AfterPlot();
                    StopAjaxLoader("#bodyTSEntry");
                },
                error: function (err) {
                    console.log(err);
                }
            })
        }

        function ReloadTApprovalData(ProxyResourceID) {

            if (ProxyResourceID == 0)
                ProxyResourceID = EmployeeID;
            if (PageFlag == 3) {
                var taskParameters = {
                    intEmployeeID: '<%= Request.QueryString("intEmployeeID")%>',
                    dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                    dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                    intTimesheetID: '<%= Request.QueryString("intTimesheetId")%>',
                    intApproverID: EmployeeID,
                }
            }

            if (PageFlag == 2) {
                //alert(ViewTimesheetID);
                if (ViewTimesheetID != 0) {
                    var taskParameters = {
                        intEmployeeID: ProxyResourceID,
                        dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                        dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                        intTimesheetID: '<%= Request.QueryString("TimesheetID")%>',
                    }
                }
                else {
                    var taskParameters = {
                        intEmployeeID: ProxyResourceID,
                        dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                        dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                    }
                }
            }
            StartLoader("#bodyTSEntry");
            $.ajax({
                url: strUrl + '/api/TimesheetApprovalDetail/GetTimesheetApprovalData',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    console.log(data);
                    //alert("Success");
                    //debugger;
                    var TimesheetApprovalDetail = data;
                    PlotTAHeaderSection(TimesheetApprovalDetail.GetActualExpectedHours);
                    plotHeaderSection(TimesheetApprovalDetail.headerColumns);
                    //PlotTableHeaderSection(TimesheetApprovalDetail.headerColumns);
                    plotWeekTotal(TimesheetApprovalDetail.WeekTotalLists);
                    plotTaskList(TimesheetApprovalDetail.timesheetLists);

                    if (PageFlag == 2) {
                        var Status = "";
                        if (TimesheetApprovalDetail.GetActualExpectedHours != null) {
                            Status = TimesheetApprovalDetail.GetActualExpectedHours.Status;
                            if (Status.toUpperCase() == "READY FOR APPROVAL")
                                Status = "Submitted";
                        }
                        var MoreProjectTaskLevel = document.getElementsByName("btnMoreProjectTaskLevel");
                        var TSActions = document.getElementsByName("btnTSActions");
                        var QuickEntryHeader = document.getElementsByName("chkQuickEntry");
                        var IsTaskComplete = document.getElementsByName("IsTaskComplete");
                        var DescriptionSave = document.getElementsByName("btnDescriptionSave");
                        $('.timenoinput').css('pointer-events', 'none');
                        if (Status.toUpperCase() == "" || Status.toUpperCase() == "SUBMITTED" || Status.toUpperCase() == "APPROVED") {
                            $("#btnMoreProjects").attr('style', 'display:none !important');
                            $(MoreProjectTaskLevel).attr('style', 'display:none !important');
                            $(TSActions).attr('style', 'display:none !important');
                            $("#txtQuickEntry").attr('style', 'display:none !important');
                            $("#btnQuickEntry").attr('style', 'display:none !important');
                            $(QuickEntryHeader).prop("disabled", true);
                            $(QuickEntryHeader).attr('style', 'cursor: not-allowed !important');
                            $(IsTaskComplete).prop("disabled", true);
                            $(IsTaskComplete).attr('style', 'cursor: not-allowed !important');
                            $(DescriptionSave).attr('style', 'display:none !important');
                        }
                        else {
                            $("#btnMoreProjects").attr('style', 'display:inline-block !important');
                            $(MoreProjectTaskLevel).attr('style', 'display:inline-block !important');
                            $(TSActions).attr('style', 'display:inline-block !important');
                            $("#txtQuickEntry").attr('style', 'display:inline-block !important');
                            $("#btnQuickEntry").attr('style', 'display:inline-block !important');
                            $(QuickEntryHeader).prop("disabled", false);
                            $(QuickEntryHeader).attr('style', 'cursor: pointer !important');
                            $(IsTaskComplete).prop("disabled", false);
                            $(IsTaskComplete).attr('style', 'cursor: pointer !important');
                            $(DescriptionSave).attr('style', 'display:inline-block !important');
                        }
                    }
                    if (PageFlag == 3) {
                        $(".timenoinput").css("pointer-events", "none");
                    }
                    AfterPlot();
                    StopAjaxLoader("#bodyTSEntry");
                    $(".notelisticon").tooltip();
                    $('#ProxyResource').tooltip({ placement: 'bottom' });
                    $('[data-toggle="tooltip"]').tooltip();
                },
                error: function (err) {
                    console.log(err);
                    alert("Error");
                }
            })

        }

        function plotHeaderSection(headerList) {
            $("#timesheetHeader").html("");
            var htmlString = "";

            htmlString += '<tr>';
            htmlString += '<th>Projects / Tasks / Sub-Task<span>'
            if (PageFlag != 3) {
                htmlString += '<button id="btnMoreProjects" class="btn borderbtn ml-1 mt-onehalf" data-toggle="modal" data-target="#selectprojecttask"><span class="" data-toggle="tooltip" data-placement="bottom" title="Select More Projects" onclick="PlotFilterTaskList(0)">More Projects +</span></button>'
            }
            htmlString += '</span>'
            htmlString += '</th>'
            if (PageFlag != 3) {
                htmlString += '<th name="QuickEntryHeader">Quick Entry<span data-toggle="tooltip" data-placement="bottom" title="Add Quick Entry(hh.mm format)" class="quickentryrecord"><input type="text" id="txtQuickEntry" value="" placeholder="00:00">'
                htmlString += '<button id="btnQuickEntry" onclick="QuickEntry_Click()"><i class="fas fa-check"></i></button>'
                htmlString += '</span></th>'
            }
            for (var i = 0; i < headerList.length; i++) {
                var header = headerList[i];
                var EntryDate = header.EntryDate;
                var DayName = header.DayName;
                var IsWorking = header.IsWorking;
                if (IsWorking == 1) {
                    htmlString += "<th class='toggleDisplay weekcolumnred'>";
                }
                else if (IsWorking == 2) {
                    htmlString += '<th class="exapnd_and_collaps_column weekdayscol">';
                }
                else if (IsWorking == 3) {
                    htmlString += "<th class='weekcolumnred'>";
                }
                else {
                    htmlString += "<th>";
                }
                htmlString += '' + EntryDate + ',<span>' + DayName + '</span>'
                if (IsWorking == 2) {
                    htmlString += '<i title="" class="click-me fas fa-caret-left"></i>'
                }
                htmlString += "</th>";
            }
            htmlString += '<th class="exapnd_and_collaps_column">Weekly<span>total</span><i title="" class="click-me fas fa-caret-right"></i></th>'
            htmlString += '<th>% Work Complete</th>'
            htmlString += '<th>Task Complete</th>'
            if (PageFlag == 3) {
                htmlString += '<th>Action</th>'
            }
            htmlString += "</tr>";
            htmlString += '<tr class="table_row_divider">'
            htmlString += '<td colspan="10">&nbsp;</td>'
            htmlString += '<td class="toggleDisplay weekcolumnred">&nbsp;</td>'
            htmlString += '</tr>'
            htmlString += '<tr class="task totalworkcountrow" id="WeekTotal">'
            htmlString += '</tr>'
            $("#timesheetHeader").html(htmlString);
            //$(".click-me").click(function () {
            //    $(".table .toggleDisplay").toggleClass("in");
            //    $(".exapnd_and_collaps_column").toggleClass("extraweekdaycolshow");
            //});
            // $('.table-fixed-header').fixedHeader();
        }

        function PlotTAHeaderSection(GetActualExpectedHours) {
            var Status = "";
            if (GetActualExpectedHours != null) {
                var ActualHours = GetActualExpectedHours.ActualHours;
                var ExpectedHours = GetActualExpectedHours.ExpectedHours;
                Status = GetActualExpectedHours.Status;
                if (Status.toUpperCase() == "READY FOR APPROVAL")
                    Status = "Submitted";
                var EmployeeName = GetActualExpectedHours.EmployeeName;
                $(".ActualHours").html(ActualHours);
                $(".ExpectedHours").html(ExpectedHours);
                $(".Status").html(Status);
                //if (Status.toUpperCase() == "REJECTED") { $("#DivAction").css("display", "none");}
            }
            if (Status.toUpperCase() == "" || Status.toUpperCase() == "SUBMITTED" || Status.toUpperCase() == "APPROVED") {
                $("#ulVTEdit").attr('style', 'display:none');
                $("#ulBackButton").attr('style', 'display:block');

            }
            else {
                $("#ulVTEdit").attr('style', 'display:block');
                $("#ulBackButton").attr('style', 'display:none');
            }

            if (Status.toUpperCase() == "REJECTED" || Status.toUpperCase() == "NOT SUBMITTED") { $("#btnSubmit").css('display', 'block'); }

            else { $("#btnSubmit").css('display', 'none'); }

            if (PageFlag == 3) {
                $(".resourcelabel").html(EmployeeName);
                $("#lblEmployeeName").text("Reject Timesheet - " + EmployeeName);
                $("#lblRejectTaskEmployeeName").text("Reject Task - " + EmployeeName);
                $("#lblFromDateToDate").text("" +  '<%= Request.QueryString("FromDate")%>' + " To " + '<%= Request.QueryString("ToDate")%>' + "");
                if (Status.toUpperCase() == "APPROVED") {
                    $("#btnApproveT").css("display", "none");
                }
                else if (Status.toUpperCase() == "REJECTED") {
                    $("#btnRejectT").css("display", "none");
                    $("#btnApproveT").css("display", "none");
                }

            }


        }

        function plotCountSection(TaskCount) {
            var CriticalTask = TaskCount.CriticalTask;
            var PendingTask = TaskCount.PendingTask;
            var SlippageTask = TaskCount.SlippageTask;
            var ScheduledTask = TaskCount.ScheduledTask;

            $("#CriticalTask").html(CriticalTask);
            $("#PendingTask").html(PendingTask);
            $("#SlippingTask").html(SlippageTask);
            $("#ScheduledTask").html(ScheduledTask);
        }

        var ProjectIDList = "";
        var TaskTypeIDList = "";
        var TaskCategoryList = "";
        var TaskStatusList = "";
        var TaskPriorityList = "";
        var TaskBillableList = "";
        var TaskPhaseList = "";
        var TaskMilestoneList = "";
        var TaskDeliverableList = "";
        var TaskSubProjectList = "";
        var TaskModuleList = "";
        function FilterProjectData() {

            ProjectIDList = "";
            var ProjectList = document.getElementsByName("ProjectList");
            for (var i = 0; i < ProjectList.length; i++) {
                if (ProjectList[i].checked == true) {
                    if (ProjectIDList == "") {
                        ProjectIDList += ProjectList[i].value;
                    }
                    else {
                        ProjectIDList += ',' + ProjectList[i].value;
                    }
                }
            }
            var taskParameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                intIsDefault: 0,
                strWhichTask: WhichTask,
                strTaskIDList: "",
                strFilterProjectList: ProjectIDList,
                strFilterTaskTypeList: "",
                strFilterTaskCategories: "",
                strFilterBillable: "",
                strFilterPriorityList: "",
                strFilterPhaseList: "",
                strFilterMilestoneList: "",
                strFilterSubProjectList: "",
                strFilterModuleList: "",
                strFilterDeliverableList: "",
                strFilterTaskStatus: "",
            }

            $.ajax({
                url: strUrl + '/api/Timesheet/GetFilters',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var filters = data;
                    plotTaskTypeFilterSection(filters.TaskTypeFilterLists);
                    plotPhaseFilterSection(filters.PhaseFilterLists);
                    plotMileStoneFilterSection(filters.MileStoneFilterLists);
                    plotDeliverableFilterSection(filters.DeliverableFilterLists);
                    plotSubProjectFilterSection(filters.SubProjectFilterLists);
                    plotModuleFilterSection(filters.ModuleFilterLists);
                },
                error: function (err) {
                    console.log(err);
                }
            })

        }
        function PlotAdditionalTimeRequestData(TaskID, SubTaskTypeID) {
            var requestadditionaltimePopupHTML = "";
            $("#requestadditionaltimePopup").html(requestadditionaltimePopupHTML);
            var taskParameters = {
                TaskID: TaskID,
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/GetAdditionalRequestedTime',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var AdditionalTimeRequestData = data;

                    var TaskID = AdditionalTimeRequestData[0].TaskID;
                    var StartDate = AdditionalTimeRequestData[0].StartDate;
                    var ProjectName = AdditionalTimeRequestData[0].ProjectName;
                    var TaskName = AdditionalTimeRequestData[0].TaskName;
                    var SubTaskType = AdditionalTimeRequestData[0].SubTaskType;
                    var work = AdditionalTimeRequestData[0].work;
                    var ETC = AdditionalTimeRequestData[0].ETC;
                    var Reason = AdditionalTimeRequestData[0].Reason;
                    var ActualWork = AdditionalTimeRequestData[0].ActualWork;
                    var ProjectID = AdditionalTimeRequestData[0].ProjectID;

                    requestadditionaltimePopupHTML += ' <div class="form-group">';
                    requestadditionaltimePopupHTML += '                        <div class="row">';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-4 text-right">Select Start Date:</div>';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-8">';
                    requestadditionaltimePopupHTML += '                                <div class="row">';
                    requestadditionaltimePopupHTML += '                                    <div class="col-xs-10 col-sm-8">';
                    requestadditionaltimePopupHTML += '                                        <input id="RTselectdate" type="text" class="form-control" name="" placeholder="Select Date"  value=' + StartDate + '>';
                    requestadditionaltimePopupHTML += '                                        <span class="startdateicon">';
                    requestadditionaltimePopupHTML += '                                            <img class="weeklycalender_icon" src="../../../Whizible2.0/dist/img/calendar.svg" alt="" width="20px"></span>';
                    requestadditionaltimePopupHTML += '                                    </div>';
                    //requestadditionaltimePopupHTML += '                                    <div class="col-xs-2 col-sm-4">';
                    //requestadditionaltimePopupHTML += '                                        <span class="startdateicon">';
                    //requestadditionaltimePopupHTML += '                                            <img class="weeklycalender_icon" src="../../../Whizible2.0/dist/img/calendar.svg" alt="" width="20px"></span>';
                    //requestadditionaltimePopupHTML += '                                    </div>';
                    requestadditionaltimePopupHTML += '                                </div>';
                    requestadditionaltimePopupHTML += '                            </div>';
                    requestadditionaltimePopupHTML += '                        </div>';
                    requestadditionaltimePopupHTML += '                    </div>';
                    requestadditionaltimePopupHTML += '                    <div class="form-group">';
                    requestadditionaltimePopupHTML += '                        <div class="row">';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-4 text-right">Project:</div>';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-8">';
                    requestadditionaltimePopupHTML += '                                <div class="row">';
                    requestadditionaltimePopupHTML += '                                    <div class="col-xs-10 col-sm-8">';
                    requestadditionaltimePopupHTML += ProjectName;
                    requestadditionaltimePopupHTML += '                                    </div>';
                    requestadditionaltimePopupHTML += '                                    <div class="col-xs-2 col-sm-4"></div>';
                    requestadditionaltimePopupHTML += '                                </div>';
                    requestadditionaltimePopupHTML += '                            </div>';
                    requestadditionaltimePopupHTML += '                        </div>';
                    requestadditionaltimePopupHTML += '                    </div>';
                    requestadditionaltimePopupHTML += '                    <div class="form-group">';
                    requestadditionaltimePopupHTML += '                        <div class="row">';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-4 text-right">Task:</div>';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-8">';
                    requestadditionaltimePopupHTML += '                                <div class="row">';
                    requestadditionaltimePopupHTML += '                                    <div class="col-xs-10 col-sm-8">';
                    requestadditionaltimePopupHTML += TaskName;
                    requestadditionaltimePopupHTML += '                                    </div>';
                    requestadditionaltimePopupHTML += '                                    <div class="col-xs-2 col-sm-4"></div>';
                    requestadditionaltimePopupHTML += '                                </div>';
                    requestadditionaltimePopupHTML += '                            </div>';
                    requestadditionaltimePopupHTML += '                        </div>';
                    requestadditionaltimePopupHTML += '                    </div>';
                    requestadditionaltimePopupHTML += '                    <div class="form-group">';
                    requestadditionaltimePopupHTML += '                        <div class="row">';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-4 text-right">Sub-Task:</div>';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-8">';
                    requestadditionaltimePopupHTML += '                                <div class="row">';
                    requestadditionaltimePopupHTML += '                                    <div class="col-xs-10 col-sm-8">';
                    requestadditionaltimePopupHTML += SubTaskType;
                    requestadditionaltimePopupHTML += '                                    </div>';
                    requestadditionaltimePopupHTML += '                                    <div class="col-xs-2 col-sm-4"></div>';
                    requestadditionaltimePopupHTML += '                                </div>';
                    requestadditionaltimePopupHTML += '                            </div>';
                    requestadditionaltimePopupHTML += '                        </div>';
                    requestadditionaltimePopupHTML += '                    </div>';
                    requestadditionaltimePopupHTML += '                    <div class="form-group">';
                    requestadditionaltimePopupHTML += '                        <div class="row">';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-4 text-right">Allocated Time:</div>';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-8">';
                    requestadditionaltimePopupHTML += '                                <div class="row">';
                    requestadditionaltimePopupHTML += '                                    <div class="col-xs-10 col-sm-8">';
                    requestadditionaltimePopupHTML += work;
                    requestadditionaltimePopupHTML += '                                    <input type="hidden" id="hdnProjectID" value="' + ProjectID + '" />';
                    requestadditionaltimePopupHTML += '                                    <input type="hidden" id="hdnTaskID" value="' + TaskID + '" />';
                    requestadditionaltimePopupHTML += '                                    <input type="hidden" id="txtAllocatedWork" value="' + work + '" />';
                    requestadditionaltimePopupHTML += '                                    <input type="hidden" id="txtActualWork" value="' + ActualWork + '" />';
                    requestadditionaltimePopupHTML += '                                    </div>';
                    requestadditionaltimePopupHTML += '                                    <div class="col-xs-2 col-sm-4"></div>';
                    requestadditionaltimePopupHTML += '                                </div>';
                    requestadditionaltimePopupHTML += '                            </div>';
                    requestadditionaltimePopupHTML += '                        </div>';
                    requestadditionaltimePopupHTML += '                    </div>';
                    requestadditionaltimePopupHTML += '                    <div class="form-group">';
                    requestadditionaltimePopupHTML += '                        <div class="row">';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-4 text-right">Request Time*:</div>';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-8">';
                    requestadditionaltimePopupHTML += '                                <div class="row">';
                    requestadditionaltimePopupHTML += '                                    <div class="col-xs-10 col-sm-8">';
                    requestadditionaltimePopupHTML += '                                        <input class="form-control" id="txtETC" type="text" value="" placeholder="' + ETC + '" name="" value=' + ETC + '>';
                    requestadditionaltimePopupHTML += '                                    </div>';
                    requestadditionaltimePopupHTML += '                                    <div class="col-xs-2 col-sm-4"></div>';
                    requestadditionaltimePopupHTML += '                                </div>';
                    requestadditionaltimePopupHTML += '                            </div>';
                    requestadditionaltimePopupHTML += '                        </div>';
                    requestadditionaltimePopupHTML += '                    </div>';
                    requestadditionaltimePopupHTML += '                    <div class="form-group">';
                    requestadditionaltimePopupHTML += '                        <div class="row">';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-4 text-right">Reason:</div>';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-12 col-sm-8">';
                    requestadditionaltimePopupHTML += '                                <div class="row">';
                    requestadditionaltimePopupHTML += '                                    <div class="col-xs-12">';
                    requestadditionaltimePopupHTML += '                                        <textarea id="txtReason" class="form-control" value=' + Reason + '>' + Reason + '</textarea>';
                    requestadditionaltimePopupHTML += '                                    </div>';
                    requestadditionaltimePopupHTML += '                                </div>';
                    requestadditionaltimePopupHTML += '                            </div>';
                    requestadditionaltimePopupHTML += '                        </div>';
                    requestadditionaltimePopupHTML += '                    </div>';
                    requestadditionaltimePopupHTML += '                    <div class="form-group mt-4">';
                    requestadditionaltimePopupHTML += '                        <div class="row">';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-6 col-sm-6 text-left">';
                    requestadditionaltimePopupHTML += '                                <button class="btn borderbtn ml-1" data-dismiss="modal">Cancel</button>';
                    requestadditionaltimePopupHTML += '                            </div>';
                    requestadditionaltimePopupHTML += '                            <div class="col-xs-6 col-sm-6 text-right">';
                    requestadditionaltimePopupHTML += '                                <button class="btn btnyellow ml-1" onclick="ETC_Save()">Request</button>';
                    requestadditionaltimePopupHTML += '                            </div>';
                    requestadditionaltimePopupHTML += '                        </div>';
                    requestadditionaltimePopupHTML += '                    </div>';
                    $("#requestadditionaltimePopup").html(requestadditionaltimePopupHTML);
                    AfterPlot();
                },
                error: function (err) {
                    console.log(err);
                }
            })
        }
        function ETC_Save() {
            var objtxtETC = document.getElementById('txtETC');
            var objtxtAllocatedWork = document.getElementById('txtAllocatedWork');
            var objtxtActualWork = document.getElementById('txtActualWork');
            var txtReason = document.getElementById("txtReason");
            var objRTselectdate = document.getElementById("RTselectdate");
            var objProjectID = document.getElementById("hdnProjectID");
            var objTaskID = document.getElementById("hdnTaskID");

            if (RestrictNonNumeric(objtxtETC) == true) {
                showAlert('Please enter a numeric value for the estimated hours.', 'alert-danger');
                return false;
            }
            if (objtxtETC.value == "0") {
                showAlert('The value of the estimated Hours cannot be 0.', 'alert-danger');
                return false;
            }            if ((((objtxtETC.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) - 0).toFixed(0) != ((objtxtETC.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)) {
                showAlert('Please specify the ETC (hrs) in multiples of ' + <%=CommonFunctions.Application.MinHoursForDAEntry%> + ' ) hours.  This is necessary because the user can only fill a minimum of ' + <%=CommonFunctions.Application.MinHoursForDAEntry%> + ' hours in the timesheet.', 'alert-danger');
                return false;
            }
            var ETCLowerLimit = 0;
            if ((objtxtAllocatedWork.value - 0) > ((objtxtActualWork.value - 0) + (objtxtETC.value - 0))) {
                ETCLowerLimit = ((objtxtActualWork.value - 0) + (objtxtETC.value - 0)) - (objtxtAllocatedWork.value - 0);
            }
            if ((objtxtETC.value - 0) < (ETCLowerLimit - 0)) {

                showAlert('The value of the estimated hours cannot be lesser than ' + ETCLowerLimit + ' !!', 'alert-danger');
                return false;
            }
            var taskParameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: objRTselectdate.value,
                ProjectID: objProjectID.value,
                TaskID: objTaskID.value,
                Duration: objtxtETC.value,
                Description: txtReason.value
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/SaveETC',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    //debugger;
                    var flag = data.split("_Flag")[1];
                    var MessageID = data.split("_Flag")[0];

                    if (flag == 1) {
                        window.open('../Email/SendEmail.aspx?MessageID=20047&intETCRequestID=' + MessageID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        function PlotScheduleTSEntryData(TaskID, SubTaskTypeID) {
            var ScheduleTSEntryHTML = "";
            $("#ScheduleTSEntryForm").html(ScheduleTSEntryHTML);
            var taskParameters = {
                TaskID: TaskID,
                SubTaskTypeID: SubTaskTypeID,
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/GetScheduleTSEntryData',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var ScheduleTSEntry = data;

                    var TaskID = ScheduleTSEntry[0].TaskID;
                    var PostWorkHrs = ScheduleTSEntry[0].PostWorkHrs;
                    var StartDate = ScheduleTSEntry[0].StartDate;
                    var PostEndDate = ScheduleTSEntry[0].PostEndDate;
                    var ProjectName = ScheduleTSEntry[0].ProjectName;
                    var TaskName = ScheduleTSEntry[0].TaskName;
                    var SubTaskType = ScheduleTSEntry[0].SubTaskType;
                    var work = ScheduleTSEntry[0].work;
                    var IsTaskComplete = ScheduleTSEntry[0].IsTaskComplete;

                    ScheduleTSEntryHTML += '<div class="form-group">';
                    ScheduleTSEntryHTML += '<div class="row">';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-5 text-right">Start Date:</div>';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-7">';
                    ScheduleTSEntryHTML += '<div class="row">';
                    ScheduleTSEntryHTML += '<div class="col-xs-10">';
                    ScheduleTSEntryHTML += '<input id="STselectdate" type="text" class="form-control" name="" placeholder="Select Date" value=' + StartDate + '>';
                    ScheduleTSEntryHTML += '<span class="startdateicon">';
                    ScheduleTSEntryHTML += '<img class="weeklycalender_icon" src="../../../Whizible2.0/dist/img/calendar.svg" alt="" width="20px"></span>';
                    ScheduleTSEntryHTML += '</div>';
                    //ScheduleTSEntryHTML += '<div class="col-xs-2">';
                    //ScheduleTSEntryHTML += '<span class="startdateicon">';
                    //ScheduleTSEntryHTML += '<img class="weeklycalender_icon" src="../../../Whizible2.0/dist/img/calendar.svg" alt="" width="20px"></span>';
                    //ScheduleTSEntryHTML += '</div>';

                    ScheduleTSEntryHTML += '</div>';

                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '<div class="form-group">';
                    ScheduleTSEntryHTML += '<div class="row">';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-5 text-right">Post till Date:</div>';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-7">';
                    ScheduleTSEntryHTML += '<div class="row">';
                    ScheduleTSEntryHTML += '<div class="col-xs-10">';
                    ScheduleTSEntryHTML += '<input id="STpostdate" type="text" class="form-control" name="" placeholder="Select Date" value=' + PostEndDate + '>';
                    ScheduleTSEntryHTML += '<span class="startdateicon">';
                    ScheduleTSEntryHTML += '<img class="weeklycalender_icon" src="../../../Whizible2.0/dist/img/calendar.svg" alt="" width="20px"></span>';
                    ScheduleTSEntryHTML += '</div>';
                    //ScheduleTSEntryHTML += '<div class="col-xs-2">';
                    //ScheduleTSEntryHTML += '<span class="startdateicon">';
                    //ScheduleTSEntryHTML += '<img class="weeklycalender_icon" src="../../../Whizible2.0/dist/img/calendar.svg" alt="" width="20px"></span>';
                    //ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';

                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '<div class="form-group">';
                    ScheduleTSEntryHTML += '<div class="row">';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-5 text-right">Project:</div>';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-7">' + ProjectName + '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '<div class="form-group">';
                    ScheduleTSEntryHTML += '<div class="row">';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-5 text-right">Task:</div>';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-7">' + TaskName + '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '<div class="form-group">';
                    ScheduleTSEntryHTML += '<div class="row">';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-5 text-right">Sub Task:</div>';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-7">' + SubTaskType + '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '<div class="form-group">';
                    ScheduleTSEntryHTML += '<div class="row">';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-5 text-right">Hours to Post:</div>';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-7">';
                    ScheduleTSEntryHTML += '<input type="hidden" id="hdnTaskID" value="' + TaskID + '" />';
                    ScheduleTSEntryHTML += '<input type="hidden" id="hdnAllocatedWork" value="' + work + '" />';
                    ScheduleTSEntryHTML += '<input class="notexfieldstyle form-control" type="text" id="HoursToPost" placeholder=' + PostWorkHrs + ' value=' + PostWorkHrs + '>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '<div class="form-group">';
                    ScheduleTSEntryHTML += '<div class="row">';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-5 text-right">Close task after end date:</div>';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-7">';
                    ScheduleTSEntryHTML += '<div class="custom_chckbox">';
                    if (IsTaskComplete == 1)
                        ScheduleTSEntryHTML += '<input id="chkCloseTask" type="checkbox" checked value=' + TaskID + '>';
                    else
                        ScheduleTSEntryHTML += '<input id="chkCloseTask" type="checkbox" value=' + TaskID + '>';
                    ScheduleTSEntryHTML += '<label for="chkCloseTask"></label>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '<div class="form-group mt-4">';
                    ScheduleTSEntryHTML += '<div class="row">';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-6 text-left">';
                    ScheduleTSEntryHTML += '<button class="btn borderbtn ml-1" data-dismiss="modal">Cancel</button>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-6 text-right">';
                    if (StartDate == "") {
                        ScheduleTSEntryHTML += '<button class="btn savebtn btnyellow ml-1" onclick="ScheduleTS_Save(1)">Schedule</button>';
                    }
                    else {
                        ScheduleTSEntryHTML += '<button id="btnScheduleTSUpdate" class="btn savebtn btnyellow ml-1" onclick="ScheduleTS_Save(0)">Update</button>';
                    }


                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';

                    $("#ScheduleTSEntryForm").html(ScheduleTSEntryHTML);

                    AfterPlot();

                },
                error: function (err) {
                    console.log(err);
                }
            })
        }
        function ScheduleTS_Save(flag) {
            var objHoursToPost = document.getElementById("HoursToPost");
            var objSTselectdate = document.getElementById("STselectdate");
            var objSTpostdate = document.getElementById("STpostdate");
            var objhdnAllocatedWork = document.getElementById("hdnAllocatedWork");
            var objchkCloseTask = document.getElementById("chkCloseTask");
            var objTaskID = document.getElementById("hdnTaskID");

            if (parseFloat(objHoursToPost.value) <= 0) {
                showAlert('Value should be greater than zero !', "alert-danger");
                return false;
            }
            if (objHoursToPost.value == "") {
                showAlert('Post Effort On Working Day should not be blank !', "alert-danger");
                return false;
            }
            if (RestrictNonNumeric(objHoursToPost) == true) {
                showAlert('Please enter numeric value !', 'alert-danger');
                return false;
            }
            if (parseFloat(objHoursToPost.value) > 24) {
                showAlert('The range for actual working hours is 0-24.', "alert-danger");
                return false;
            }
            if (parseFloat(objhdnAllocatedWork.value) < parseFloat(objHoursToPost.value)) {
                showAlert('Post effort should be less than or equal to allocated work hours !', "alert-danger");
                return false;
            }
            if (objSTselectdate.value == "") {
                showAlert('Start date should not be blank !', 'alert-danger');
                return false;
            }
            if (objSTpostdate.value == "") {
                showAlert('Post till date should not be blank !', 'alert-danger');
                return false;
            }
            var taskParameters = {
                TaskID: objTaskID.value,
                dtFromDate: objSTselectdate.value,
                dtToDate: objSTpostdate.value
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/ValidateScheduleTask',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    if (data != "") {
                        showAlert(data, 'alert-danger');
                        return false;
                    }
                    else {
                        ReloadData(EmployeeID);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
            var taskParameters = {
                TaskID: objTaskID.value,
                intEmployeeID: EmployeeID,
                dtFromDate: objSTselectdate.value,
                dtToDate: objSTpostdate.value,
                Duration: objHoursToPost.value,
                IsTaskComplete: objchkCloseTask.checked,
                bitFlag: flag
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/SaveScheduledTask',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    if (data == -1) {
                        showAlert('Scheduled task saved successfully.', 'alert-success', 'btnSave');
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        function PlotSubTaskList(ProjectID, TaskID) {
            var subtaskListHTML = "";
            $("#subTaskListPopupProjectName").html("");
            $("#subTaskListPopupTaskName").html("");
            $("#SubTaskListTable").html(subtaskListHTML);
            var taskParameters = {
                ProjectID: ProjectID,
                TaskID: TaskID,
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/GetSubTaskList',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var subTaskList = data;

                    for (var i = 0; i < subTaskList.length; i++) {
                        var SubTaskTypeID = subTaskList[i].SubTaskTypeID;
                        var SubTaskType = subTaskList[i].SubTaskType;
                        var TaskName = subTaskList[i].TaskName;
                        var ProjectName = subTaskList[i].ProjectName;

                        subtaskListHTML += '<tr>';
                        subtaskListHTML += '<td>';
                        subtaskListHTML += '<div class="custom_chckbox">';
                        subtaskListHTML += '<input type="hidden" id="hdnTaskForSubTask" value=' + TaskID + '>';
                        subtaskListHTML += '<input type="checkbox" name="chkSubTask" id="chkSubTask_' + SubTaskTypeID + '" value=' + SubTaskTypeID + '>';
                        subtaskListHTML += '<label for="chkSubTask_' + SubTaskTypeID + '"></label>';
                        subtaskListHTML += '</div>';
                        subtaskListHTML += '</td>';
                        subtaskListHTML += '<td>' + SubTaskType + '</td>';
                        subtaskListHTML += '</tr>';
                    }
                    $("#subTaskListPopupProjectName").html("Project Name : " + ProjectName);
                    $("#subTaskListPopupTaskName").html("Task Name : " + TaskName);
                    $("#SubTaskListTable").html(subtaskListHTML);
                },
                error: function (err) {
                    console.log(err);
                }
            })
        }
        function GetFilterResultCount() {
            ProjectIDList = "";
            var ProjectList = document.getElementsByName("ProjectList");
            for (var i = 0; i < ProjectList.length; i++) {
                if (ProjectList[i].checked == true) {
                    if (ProjectIDList == "") {
                        ProjectIDList += ProjectList[i].value;
                    }
                    else {
                        ProjectIDList += ',' + ProjectList[i].value;
                    }
                }
            }
            if (ProjectIDList == "") {
                $('#entryfiltermodalinfo').modal('hide');
                showAlert("Please select atleast one Project.", "alert-danger");

                return false;
            }
            else {
                $('#entryfiltermodalinfo').modal('show');
            }
            TaskTypeIDList = "";
            var TaskTypeList = document.getElementsByName("TaskTypeList");
            for (var i = 0; i < TaskTypeList.length; i++) {
                if (TaskTypeList[i].checked == true) {
                    if (TaskTypeIDList == "") {
                        TaskTypeIDList += TaskTypeList[i].value;
                    }
                    else {
                        TaskTypeIDList += ',' + TaskTypeList[i].value;
                    }
                }
            }

            TaskCategoryList = "";
            var TaskCategory = document.getElementsByName("TaskCategoryList");
            for (var i = 0; i < TaskCategory.length; i++) {
                if (TaskCategory[i].checked == true) {
                    if (TaskCategoryList == "") {
                        TaskCategoryList += TaskCategory[i].value;
                    }
                    else {
                        TaskCategoryList += ',' + TaskCategory[i].value;
                    }
                }
            }

            TaskStatusList = "";
            var TaskStatus = document.getElementsByName("TaskStatusList");
            for (var i = 0; i < TaskStatus.length; i++) {
                if (TaskStatus[i].checked == true) {
                    if (TaskStatusList == "") {
                        TaskStatusList += TaskStatus[i].value;
                    }
                    else {
                        TaskStatusList += ',' + TaskStatus[i].value;
                    }
                }
            }

            TaskPriorityList = "";
            var TaskPriority = document.getElementsByName("TaskPriorityList");
            for (var i = 0; i < TaskPriority.length; i++) {
                if (TaskPriority[i].checked == true) {
                    if (TaskPriorityList == "") {
                        TaskPriorityList += TaskPriority[i].value;
                    }
                    else {
                        TaskPriorityList += ',' + TaskPriority[i].value;
                    }
                }
            }

            TaskBillableList = "";
            var TaskBillable = document.getElementsByName("TaskBillableList");
            for (var i = 0; i < TaskBillable.length; i++) {
                if (TaskBillable[i].checked == true) {
                    if (TaskBillableList == "") {
                        TaskBillableList += TaskBillable[i].value;
                    }
                    else {
                        TaskBillableList += ',' + TaskBillable[i].value;
                    }
                }
            }

            TaskPhaseList = "";
            var TaskPhase = document.getElementsByName("TaskPhaseList");
            for (var i = 0; i < TaskPhase.length; i++) {
                if (TaskPhase[i].checked == true) {
                    if (TaskPhaseList == "") {
                        TaskPhaseList += TaskPhase[i].value;
                    }
                    else {
                        TaskPhaseList += ',' + TaskPhase[i].value;
                    }
                }
            }

            TaskMilestoneList = "";
            var TaskMilestone = document.getElementsByName("TaskMilestoneList");
            for (var i = 0; i < TaskMilestone.length; i++) {
                if (TaskMilestone[i].checked == true) {
                    if (TaskMilestoneList == "") {
                        TaskMilestoneList += TaskMilestone[i].value;
                    }
                    else {
                        TaskMilestoneList += ',' + TaskMilestone[i].value;
                    }
                }
            }

            TaskDeliverableList = "";
            var TaskDeliverable = document.getElementsByName("TaskDeliverableList");
            for (var i = 0; i < TaskDeliverable.length; i++) {
                if (TaskDeliverable[i].checked == true) {
                    if (TaskDeliverableList == "") {
                        TaskDeliverableList += TaskDeliverable[i].value;
                    }
                    else {
                        TaskDeliverableList += ',' + TaskDeliverable[i].value;
                    }
                }
            }

            TaskSubProjectList = "";
            var TaskSubProject = document.getElementsByName("TaskSubProjectList");
            for (var i = 0; i < TaskSubProject.length; i++) {
                if (TaskSubProject[i].checked == true) {
                    if (TaskSubProjectList == "") {
                        TaskSubProjectList += TaskSubProject[i].value;
                    }
                    else {
                        TaskSubProjectList += ',' + TaskSubProject[i].value;
                    }
                }
            }

            TaskModuleList = "";
            var TaskModule = document.getElementsByName("TaskModuleList");
            for (var i = 0; i < TaskModule.length; i++) {
                if (TaskModule[i].checked == true) {
                    if (TaskModuleList == "") {
                        TaskModuleList += TaskModule[i].value;
                    }
                    else {
                        TaskModuleList += ',' + TaskModule[i].value;
                    }
                }
            }

            var taskParameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                intIsDefault: 0,
                strWhichTask: WhichTask,
                strTaskIDList: "",
                strFilterProjectList: ProjectIDList,
                strFilterTaskTypeList: TaskTypeIDList,
                strFilterTaskCategories: TaskCategoryList,
                strFilterBillable: TaskBillableList,
                strFilterPriorityList: TaskPriorityList,
                strFilterPhaseList: TaskPhaseList,
                strFilterMilestoneList: TaskMilestoneList,
                strFilterSubProjectList: TaskSubProjectList,
                strFilterModuleList: TaskModuleList,
                strFilterDeliverableList: TaskDeliverableList,
                strFilterTaskStatus: TaskStatusList,
            }

            $.ajax({
                url: strUrl + '/api/Timesheet/GetFilterResultCount',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    $("#FilterResultMsg").html("Your filter result returned " + data + " records. Do you want to view them?");
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        function PlotFilterTaskList(ProjectID) {
            ProjectIDList = "";
            var ProjectList = document.getElementsByName("ProjectList");
            for (var i = 0; i < ProjectList.length; i++) {
                if (ProjectList[i].checked == true) {
                    if (ProjectIDList == "") {
                        ProjectIDList += ProjectList[i].value;
                    }
                    else {
                        ProjectIDList += ',' + ProjectList[i].value;
                    }
                }
            }
            if (ProjectID != 0) {
                ProjectIDList = '';
                ProjectIDList = ProjectID;
                document.getElementById('cboFilteredProject').value = ProjectID;
                $('select[name=cboFilteredProject]').val(ProjectID);
                //document.getElementById('cboFilteredProject').disabled = true;
                $(".selectpicker").selectpicker('refresh');
            }
            TaskTypeIDList = "";
            var TaskTypeList = document.getElementsByName("TaskTypeList");
            for (var i = 0; i < TaskTypeList.length; i++) {
                if (TaskTypeList[i].checked == true) {
                    if (TaskTypeIDList == "") {
                        TaskTypeIDList += TaskTypeList[i].value;
                    }
                    else {
                        TaskTypeIDList += ',' + TaskTypeList[i].value;
                    }
                }
            }

            TaskCategoryList = "";
            var TaskCategory = document.getElementsByName("TaskCategoryList");
            for (var i = 0; i < TaskCategory.length; i++) {
                if (TaskCategory[i].checked == true) {
                    if (TaskCategoryList == "") {
                        TaskCategoryList += TaskCategory[i].value;
                    }
                    else {
                        TaskCategoryList += ',' + TaskCategory[i].value;
                    }
                }
            }

            TaskStatusList = "";
            var TaskStatus = document.getElementsByName("TaskStatusList");
            for (var i = 0; i < TaskStatus.length; i++) {
                if (TaskStatus[i].checked == true) {
                    if (TaskStatusList == "") {
                        TaskStatusList += TaskStatus[i].value;
                    }
                    else {
                        TaskStatusList += ',' + TaskStatus[i].value;
                    }
                }
            }

            TaskPriorityList = "";
            var TaskPriority = document.getElementsByName("TaskPriorityList");
            for (var i = 0; i < TaskPriority.length; i++) {
                if (TaskPriority[i].checked == true) {
                    if (TaskPriorityList == "") {
                        TaskPriorityList += TaskPriority[i].value;
                    }
                    else {
                        TaskPriorityList += ',' + TaskPriority[i].value;
                    }
                }
            }

            TaskBillableList = "";
            var TaskBillable = document.getElementsByName("TaskBillableList");
            for (var i = 0; i < TaskBillable.length; i++) {
                if (TaskBillable[i].checked == true) {
                    if (TaskBillableList == "") {
                        TaskBillableList += TaskBillable[i].value;
                    }
                    else {
                        TaskBillableList += ',' + TaskBillable[i].value;
                    }
                }
            }

            TaskPhaseList = "";
            var TaskPhase = document.getElementsByName("TaskPhaseList");
            for (var i = 0; i < TaskPhase.length; i++) {
                if (TaskPhase[i].checked == true) {
                    if (TaskPhaseList == "") {
                        TaskPhaseList += TaskPhase[i].value;
                    }
                    else {
                        TaskPhaseList += ',' + TaskPhase[i].value;
                    }
                }
            }

            TaskMilestoneList = "";
            var TaskMilestone = document.getElementsByName("TaskMilestoneList");
            for (var i = 0; i < TaskMilestone.length; i++) {
                if (TaskMilestone[i].checked == true) {
                    if (TaskMilestoneList == "") {
                        TaskMilestoneList += TaskMilestone[i].value;
                    }
                    else {
                        TaskMilestoneList += ',' + TaskMilestone[i].value;
                    }
                }
            }

            TaskDeliverableList = "";
            var TaskDeliverable = document.getElementsByName("TaskDeliverableList");
            for (var i = 0; i < TaskDeliverable.length; i++) {
                if (TaskDeliverable[i].checked == true) {
                    if (TaskDeliverableList == "") {
                        TaskDeliverableList += TaskDeliverable[i].value;
                    }
                    else {
                        TaskDeliverableList += ',' + TaskDeliverable[i].value;
                    }
                }
            }

            TaskSubProjectList = "";
            var TaskSubProject = document.getElementsByName("TaskSubProjectList");
            for (var i = 0; i < TaskSubProject.length; i++) {
                if (TaskSubProject[i].checked == true) {
                    if (TaskSubProjectList == "") {
                        TaskSubProjectList += TaskSubProject[i].value;
                    }
                    else {
                        TaskSubProjectList += ',' + TaskSubProject[i].value;
                    }
                }
            }

            TaskModuleList = "";
            var TaskModule = document.getElementsByName("TaskModuleList");
            for (var i = 0; i < TaskModule.length; i++) {
                if (TaskModule[i].checked == true) {
                    if (TaskModuleList == "") {
                        TaskModuleList += TaskModule[i].value;
                    }
                    else {
                        TaskModuleList += ',' + TaskModule[i].value;
                    }
                }
            }

            var taskParameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                intIsDefault: 0,
                strWhichTask: WhichTask,
                strTaskIDList: "",
                strFilterProjectList: ProjectIDList,
                strFilterTaskTypeList: TaskTypeIDList,
                strFilterTaskCategories: TaskCategoryList,
                strFilterBillable: TaskBillableList,
                strFilterPriorityList: TaskPriorityList,
                strFilterPhaseList: TaskPhaseList,
                strFilterMilestoneList: TaskMilestoneList,
                strFilterSubProjectList: TaskSubProjectList,
                strFilterModuleList: TaskModuleList,
                strFilterDeliverableList: TaskDeliverableList,
                strFilterTaskStatus: TaskStatusList,
            }

            $.ajax({
                url: strUrl + '/api/Timesheet/GetProjectDropdownValuesForFilter',
                type: "POST",
                data: JSON.stringify(taskParameters),
                async:false,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var selHTML = "";
                    selHTML += "<option title='Select Project' value='0'>Select Project</option>"
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        var ProjectID = d.ProjectID;
                        var ProjectName = d.ProjectName;
                        selHTML += "<option title='" + ProjectName + "' value='" + ProjectID + "'>" + ProjectName + "</option>";
                    }
                    $("#cboFilteredProject").html(selHTML);
                    $(".selectpicker").selectpicker('refresh');
                },
                error: function (err) {
                    console.log(err);
                }
            });
            if (ProjectID != 0) {
                $(".selectpicker").selectpicker('refresh');
                ProjectFilterDrop_OnChange(ProjectID);
            }
            //FilterTaskCategories
            $.ajax({
                url: strUrl + '/api/Timesheet/GetTaskCategories',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    $("#FilterTaskCategories").html('');
                    var strHTML = "";
                    for (var i = 0; i < data.length; i++) {
                        var TaskCategoryObject = data[i];
                        var ID = TaskCategoryObject.ID;
                        var Value = TaskCategoryObject.Value;

                        strHTML += '<li class="filter-item items" data-filter="' + Value + '" data-value="' + ID + '">';
                        strHTML += '<input type="checkbox" name="FilterTaskCategoryList" value="' + ID + '" onchange="TaskCategory_OnChange()">';
                        strHTML += "" + Value + "</li>";
                    }
                    $("#FilterTaskCategories").html(strHTML);
                },
                error: function (err) {
                    console.log(err);
                }
            });


            PlotTaskList(taskParameters, 0);
        }
        function PlotTaskList(taskParameters, flag) {
            var taskFilterListHTML = "";
            $("#FilterTaskBody").html(taskFilterListHTML);
            $("#ProjectCode").html("");
            $("#startdateandenddate").html("");
            $.ajax({
                url: strUrl + '/api/Timesheet/GetTaskListFromAdvanceSearch',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var filters = data;
                    var ProjectCode;
                    var ProjectStartDate;
                    var ProjectEndDate;
                    for (var i = 0; i < filters.length; i++) {
                        var taskID = filters[i].TaskID;
                        var taskName = filters[i].TaskName;
                        var Tasknotes = filters[i].Tasknotes;
                        var StartDate = filters[i].StartDate;
                        var EndDate = filters[i].EndDate;
                        var Work = filters[i].Work;
                        var MileStone = filters[i].MileStone;
                        var Phase = filters[i].Phase;
                        var SubProjectName = filters[i].SubProjectName;
                        var DeliverableName = filters[i].DeliverableName;
                        var ModuleName = filters[i].ModuleName;
                        var Issue = filters[i].Issue;
                        var ProjectName = filters[i].ProjectName;
                        var ActualWork = filters[i].ActualWork;
                        ProjectCode = filters[i].ProjectCode;
                        ProjectStartDate = filters[i].ProjectStartDate;
                        ProjectEndDate = filters[i].ProjectEndDate;

                        taskFilterListHTML += '<tr>'
                        taskFilterListHTML += '<td>'
                        taskFilterListHTML += '<div class="custom_chckbox">'
                        taskFilterListHTML += '<input type="checkbox" id="FilterTaskList' + taskID + '" name="FilterTaskList" value="' + taskID + '">';
                        taskFilterListHTML += ' <label for="FilterTaskList' + taskID + '"></label>'
                        taskFilterListHTML += ' </div>'
                        taskFilterListHTML += '</td>';
                        taskFilterListHTML += '<td>';
                        taskFilterListHTML += '<div class="more">' + taskName + '</div>';

                        taskFilterListHTML += '    <div class="dropdown modalprojectinfo">';
                        taskFilterListHTML += '<img title="Project Info" data-placement="left" data-container="body" class="dropdown-toggle pull-right " src="../../../Whizible2.0/dist/img/exclaim.svg" width="13px" alt="" data-toggle="dropdown" aria-expanded="true">';

                        taskFilterListHTML += '<div class="dropdown-menu modalpop_projectinfo" role="menu" aria-labelledby="menu1">';
                        taskFilterListHTML += '<div class="arrow-right"></div>';
                        taskFilterListHTML += '<div class="projecttaskinfo_tooltipbox">';
                        taskFilterListHTML += '<button type="button" class="close" data-toggle="collapse" aria-expanded="false">';
                        taskFilterListHTML += '<img width="20px" src="../../../Whizible2.0/dist/img/close-gray.svg"></button>';
                        taskFilterListHTML += '<div class="PTItooltipbox_hading">';
                        taskFilterListHTML += ProjectName;
                        taskFilterListHTML += '<br />';
                        taskFilterListHTML += '<span class="PTItooltipbox_hading">' + taskName + '</span>';
                        taskFilterListHTML += '</div>';
                        taskFilterListHTML += '<p>' + Tasknotes + '</p>';
                        taskFilterListHTML += '<div class="row">';
                        taskFilterListHTML += '<div class="col-sm-6 pr0">';
                        taskFilterListHTML += '<div class="projecttaskinfo_tooltipbox_schedule">';
                        taskFilterListHTML += '<div class="row">';
                        taskFilterListHTML += '<div class="col-xs-5">Start Date:</div>';
                        taskFilterListHTML += '     <div class="col-xs-7">' + StartDate + '</div>';
                        taskFilterListHTML += ' </div>';
                        taskFilterListHTML += ' <div class="row">';
                        taskFilterListHTML += '     <div class="col-xs-5">End Date:</div>';
                        taskFilterListHTML += '     <div class="col-xs-7">' + EndDate + '</div>';
                        taskFilterListHTML += ' </div>';
                        taskFilterListHTML += ' <div class="row">';
                        taskFilterListHTML += '     <div class="col-xs-5">Alloted Work:</div>';
                        taskFilterListHTML += '     <div class="col-xs-7">' + Work + '</div>';
                        taskFilterListHTML += ' </div>';
                        taskFilterListHTML += ' <div class="row">';
                        taskFilterListHTML += '     <div class="col-xs-5">Actual Work:</div>';
                        taskFilterListHTML += '     <div class="col-xs-7">' + ActualWork + '</div>';
                        taskFilterListHTML += ' </div>';
                        taskFilterListHTML += '     </div>';
                        taskFilterListHTML += ' </div>';
                        taskFilterListHTML += ' <div class="col-sm-6 pl0 projecttaskinfo_tooltipbox_schedule_borderleft">';
                        taskFilterListHTML += '     <div class="projecttaskinfo_tooltipbox_schedule">';
                        taskFilterListHTML += '         <div class="row">';
                        taskFilterListHTML += '             <div class="col-xs-5">Phase:</div>';
                        taskFilterListHTML += '             <div class="col-xs-7">' + Phase + '</div>';
                        taskFilterListHTML += '         </div>';
                        taskFilterListHTML += '         <div class="row">';
                        taskFilterListHTML += '             <div class="col-xs-5">Milestone:</div>';
                        taskFilterListHTML += '             <div class="col-xs-7">' + MileStone + '</div>';
                        taskFilterListHTML += '         </div>';
                        taskFilterListHTML += '         <div class="row">';
                        taskFilterListHTML += '             <div class="col-xs-5">Sub Project:</div>';
                        taskFilterListHTML += '             <div class="col-xs-7">' + SubProjectName + '</div>';
                        taskFilterListHTML += '         </div>';
                        taskFilterListHTML += '         <div class="row">';
                        taskFilterListHTML += '             <div class="col-xs-5">Issue:</div>';
                        taskFilterListHTML += '             <div class="col-xs-7">' + Issue + '</div>';
                        taskFilterListHTML += '         </div>';
                        taskFilterListHTML += '         <div class="row">';
                        taskFilterListHTML += '             <div class="col-xs-5">Deliverable:</div>';
                        taskFilterListHTML += '             <div class="col-xs-7">' + DeliverableName + '</div>';
                        taskFilterListHTML += '         </div>';
                        taskFilterListHTML += '         <div class="row">';
                        taskFilterListHTML += '             <div class="col-xs-5">Module:</div>';
                        taskFilterListHTML += '             <div class="col-xs-7">' + ModuleName + '</div>';
                        taskFilterListHTML += '         </div>';
                        taskFilterListHTML += '     </div>';
                        taskFilterListHTML += '                    </div>';
                        taskFilterListHTML += '                </div>';
                        taskFilterListHTML += '            </div>';
                        taskFilterListHTML += '        </div>';
                        taskFilterListHTML += '    </div>';
                        taskFilterListHTML += '</td>';

                        taskFilterListHTML += '</tr>';
                    }
                    $("#FilterTaskBody").html(taskFilterListHTML);
                    if (flag == 1) {
                        if (taskParameters.FilterProjectID != 0) {
                            if (ProjectCode != undefined) {
                                $("#ProjectCode").html("Project ID: " + ProjectCode);
                                var dateHTML = "";
                                dateHTML += " Start Date: " + ProjectStartDate;
                                dateHTML += "<br />";
                                dateHTML += "End Date&nbsp;&nbsp;: " + ProjectEndDate;
                                $("#startdateandenddate").html(dateHTML);
                            }
                        }
                    }
                    var showChar = 80;  // How many characters are shown by default
                    var ellipsestext = "...";
                    var moretext = "more >";
                    var lesstext = "< less";


                    $('.more').each(function () {
                        var content = $(this).html();

                        if (content.length > showChar) {

                            var c = content.substr(0, showChar);
                            var h = content.substr(showChar, content.length - showChar);

                            var html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';

                            $(this).html(html);
                        }

                    });

                    $(".morelink").click(function () {
                        if ($(this).hasClass("less")) {
                            $(this).removeClass("less");
                            $(this).html(moretext);
                        } else {
                            $(this).addClass("less");
                            $(this).html(lesstext);
                        }
                        $(this).parent().prev().toggle();
                        $(this).prev().toggle();
                        return false;
                    });
                },
                error: function (err) {
                    console.log(err);
                }
            })
        }
        function ProjectFilterDrop_OnChange(ProjectID) {
            var taskParameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                intIsDefault: 0,
                strWhichTask: WhichTask,
                strTaskIDList: "",
                strFilterProjectList: ProjectIDList,
                strFilterTaskTypeList: TaskTypeIDList,
                strFilterTaskCategories: TaskCategoryList,
                strFilterBillable: TaskBillableList,
                strFilterPriorityList: TaskPriorityList,
                strFilterPhaseList: TaskPhaseList,
                strFilterMilestoneList: TaskMilestoneList,
                strFilterSubProjectList: TaskSubProjectList,
                strFilterModuleList: TaskModuleList,
                strFilterDeliverableList: TaskDeliverableList,
                strFilterTaskStatus: TaskStatusList,
                FilterProjectID: ProjectID,
            }
            PlotTaskList(taskParameters, 1);
        }
        function TaskCategory_OnChange() {
            TaskCategoryList = "";
            var TaskCategory = document.getElementsByName("FilterTaskCategoryList");
            for (var i = 0; i < TaskCategory.length; i++) {
                if (TaskCategory[i].checked == true) {
                    if (TaskCategoryList == "") {
                        TaskCategoryList += TaskCategory[i].value;
                    }
                    else {
                        TaskCategoryList += ',' + TaskCategory[i].value;
                    }
                }
            }

            var taskParameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                intIsDefault: 0,
                strWhichTask: WhichTask,
                strTaskIDList: "",
                strFilterProjectList: ProjectIDList,
                strFilterTaskTypeList: TaskTypeIDList,
                strFilterTaskCategories: TaskCategoryList,
                strFilterBillable: TaskBillableList,
                strFilterPriorityList: TaskPriorityList,
                strFilterPhaseList: TaskPhaseList,
                strFilterMilestoneList: TaskMilestoneList,
                strFilterSubProjectList: TaskSubProjectList,
                strFilterModuleList: TaskModuleList,
                strFilterDeliverableList: TaskDeliverableList,
                strFilterTaskStatus: TaskStatusList,
            }
            PlotTaskList(taskParameters, 0);
        }
        var TaskIDList = "";
        function FilterTaskFromList() {
            TaskIDList = "";
            var FilterTaskList = document.getElementsByName("FilterTaskList");
            for (var i = 0; i < FilterTaskList.length; i++) {
                if (FilterTaskList[i].checked == true) {
                    if (TaskIDList == "") {
                        TaskIDList = FilterTaskList[i].value;
                    }
                    else {
                        TaskIDList += "," + FilterTaskList[i].value;
                    }
                }
            }
            if (TaskIDList == "") {
                showAlert("Please select atleast one task.", "alert-danger");
                return false;
            }
            IsDefault = 1;
            if (isWeeklyView == 1)
                ReloadData(EmployeeID);
            else
                plotDailyTaskList();
            $("#selectprojecttask").modal('hide');
            //$("#filterpanel").hide();
            //added by pradip
            $("#filterpanel").removeClass('in');
            $("body").css("padding-right", "0px!important");
        }
        function plotProjectFilterSection(ProjectFilterLists) {
            $("#ProjectFilterList").html('');
            var strHTML = "";
            for (var i = 0; i < ProjectFilterLists.length; i++) {
                var ProjectObject = ProjectFilterLists[i];
                var ProjectID = ProjectObject.ProjectID;
                var ProjectName = ProjectObject.ProjectName;

                strHTML += "<li class='filter-item items' data-filter='" + ProjectName + "' data-value='" + ProjectID + "'>";
                strHTML += "<input class='checkbox' type='checkbox' name='ProjectList' onchange='FilterProjectData()' value='" + ProjectID + "'>";
                strHTML += "" + ProjectName + "</li>";
            }
            $("#ProjectFilterList").html(strHTML);
        }
        function plotTaskTypeFilterSection(TaskTypeFilterLists) {
            $("#TaskTypeFilterList").html('');
            var strHTML = "";
            for (var i = 0; i < TaskTypeFilterLists.length; i++) {
                var TaskTypeObject = TaskTypeFilterLists[i];
                var TaskTypeID = TaskTypeObject.TaskTypeID;
                var TaskType = TaskTypeObject.TaskType;

                strHTML += "<li class='filter-item items' data-filter='" + TaskType + "' data-value='" + TaskTypeID + "'>";
                strHTML += "<input class='checkbox' type='checkbox' name='TaskTypeList' value='" + TaskTypeID + "'>";
                strHTML += "" + TaskType + "</li>";
            }
            $("#TaskTypeFilterList").html(strHTML);
        }
        function plotCategoryFilterSection(TaskCategoryFilterLists) {
            $("#TaskCategoryFilterList").html('');
            var strHTML = "";
            for (var i = 0; i < TaskCategoryFilterLists.length; i++) {
                var TaskCategoryObject = TaskCategoryFilterLists[i];
                var ID = TaskCategoryObject.ID;
                var Value = TaskCategoryObject.Value;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' name='TaskCategoryList' value='" + ID + "'>";
                strHTML += "" + Value + "</li>";
            }
            $("#TaskCategoryFilterList").html(strHTML);
        }
        function plotStatusFilterSection(TaskStatusFilterLists) {
            $("#TaskStatusFilterList").html('');
            var strHTML = "";
            for (var i = 0; i < TaskStatusFilterLists.length; i++) {
                var TaskStatusObject = TaskStatusFilterLists[i];
                var StatusID = TaskStatusObject.StatusID;
                var Status = TaskStatusObject.Status;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' name='TaskStatusList' value='" + StatusID + "'>";
                strHTML += "" + Status + "</li>";
            }
            $("#TaskStatusFilterList").html(strHTML);
        }
        function plotPriorityFilterSection(TaskPriorityFilterLists) {
            $("#TaskPriorityFilterList").html('');
            var strHTML = "";
            for (var i = 0; i < TaskPriorityFilterLists.length; i++) {
                var TaskPriorityObject = TaskPriorityFilterLists[i];
                var PriorityID = TaskPriorityObject.PriorityID;
                var Priority = TaskPriorityObject.Priority;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' name='TaskPriorityList' value='" + PriorityID + "'>";
                strHTML += "" + Priority + "</li>";
            }
            $("#TaskPriorityFilterList").html(strHTML);
        }
        function plotBillableFilterSection(BillableFilterLists) {
            $("#BillableFilterList").html('');
            var strHTML = "";
            for (var i = 0; i < BillableFilterLists.length; i++) {
                var BillableObject = BillableFilterLists[i];
                var ID = BillableObject.ID;
                var Value = BillableObject.Value;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' name='TaskBillableList' value='" + ID + "'>";
                strHTML += "" + Value + "</li>";
            }
            $("#BillableFilterList").html(strHTML);
        }
        function plotPhaseFilterSection(PhaseFilterLists) {
            $("#TaskPhaseFilterList").html('');
            var strHTML = "";
            for (var i = 0; i < PhaseFilterLists.length; i++) {
                var TaskPhaseObject = PhaseFilterLists[i];
                var PhaseID = TaskPhaseObject.PhaseID;
                var Phase = TaskPhaseObject.Phase;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' name='TaskPhaseList' value='" + PhaseID + "'>";
                strHTML += "" + Phase + "</li>";
            }
            $("#TaskPhaseFilterList").html(strHTML);
        }
        function plotMileStoneFilterSection(MileStoneFilterLists) {
            $("#TaskMilestoneFilterList").html('');
            var strHTML = "";
            for (var i = 0; i < MileStoneFilterLists.length; i++) {
                var TaskMileStoneObject = MileStoneFilterLists[i];
                var MileStoneId = TaskMileStoneObject.MileStoneId;
                var MileStone = TaskMileStoneObject.MileStone;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' name='TaskMilestoneList' value='" + MileStoneId + "'>";
                strHTML += "" + MileStone + "</li>";
            }
            $("#TaskMilestoneFilterList").html(strHTML);
        }
        function plotDeliverableFilterSection(DeliverableFilterLists) {
            $("#TaskDeliverableFilterList").html('');
            var strHTML = "";
            for (var i = 0; i < DeliverableFilterLists.length; i++) {
                var TaskDeliverableObject = DeliverableFilterLists[i];
                var DeliverableID = TaskDeliverableObject.DeliverableID;
                var Title = TaskDeliverableObject.Title;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' name='TaskDeliverableList' value='" + DeliverableID + "'>";
                strHTML += "" + Title + "</li>";
            }
            $("#TaskDeliverableFilterList").html(strHTML);
        }
        function plotSubProjectFilterSection(SubProjectFilterLists) {
            $("#TaskSubProjectFilterList").html('');
            var strHTML = "";
            for (var i = 0; i < SubProjectFilterLists.length; i++) {
                var TaskSubProjectObject = SubProjectFilterLists[i];
                var SubProjectId = TaskSubProjectObject.SubProjectId;
                var SubProjectName = TaskSubProjectObject.SubProjectName;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' name='TaskSubProjectList' value='" + SubProjectId + "'>";
                strHTML += "" + SubProjectName + "</li>";
            }
            $("#TaskSubProjectFilterList").html(strHTML);
        }
        function plotModuleFilterSection(ModuleFilterLists) {
            $("#TaskModuleFilterList").html('');
            var strHTML = "";
            for (var i = 0; i < ModuleFilterLists.length; i++) {
                var TaskModuleObject = ModuleFilterLists[i];
                var ModuleId = TaskModuleObject.ModuleId;
                var ModuleName = TaskModuleObject.ModuleName;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' name='TaskModuleList' value='" + ModuleId + "'>";
                strHTML += "" + ModuleName + "</li>";
            }
            $("#TaskModuleFilterList").html(strHTML);
        }
        function plotWeekTotal(WeekTotalLists) {
            $("#WeekTotal").html('');
            var strHTML = "";
            strHTML += "<td class='totalworkcountrow'>Total work for a week</td>";
            if (PageFlag != 3) {
                strHTML += "<td name='QuickEntryHeader'><label class='pro_Calculate_count'>&nbsp;</label></td>";
            }
            var AllTotal;
            for (var i = 0; i <= WeekTotalLists.length - 1; i++) {
                var WeekTotalObject = WeekTotalLists[i];
                var Total = WeekTotalObject.Total;
                var EntryDate = WeekTotalObject.EntryDate;
                AllTotal = WeekTotalObject.AllTotal;
                var WeekDays = WeekTotalObject.WeekDays;

                if (i >= WeekDays) {
                    strHTML += "<td class='toggleDisplay'><label class='pro_Calculate_count'>" + Total + "</label></td>";
                }
                else {
                    strHTML += "<td><label class='pro_Calculate_count'>" + Total + "</label></td>";
                }
            }

            strHTML += "<td><label class='pro_Calculate_count'>" + AllTotal + "</label></td>";
            strHTML += "<td>&nbsp;</td><td>&nbsp;</td>";
            if (PageFlag == 3) {
                strHTML += "<td>&nbsp;</td>";
            }
            $("#WeekTotal").html(strHTML);
        }
        function plotTaskList(taskList) {
            var taskHTML = "";
            var taskCounter = 0;
            var subTaskCounter = 0;
            $("#timesheetBody").html(taskHTML);
            for (var i = 0; i < taskList.length; i++) {
                var task = taskList[i];
                var TaskID = task.TaskID;
                var TaskName = task.TaskName;
                var SubTaskType = task.SubTaskType;
                var ProjectID = task.ProjectID;
                var ProjectName = task.ProjectName;
                var Description = task.Description;
                var MonDAID = task.MonDAID;
                var TueDAID = task.TueDAID;
                var WedDAID = task.WedDAID;
                var ThuDAID = task.ThuDAID;
                var FriDAID = task.FriDAID;
                var SatDAID = task.SatDAID;
                var SunDAID = task.SunDAID;
                var Mon = task.Mon;
                var Tue = task.Tue;
                var Wed = task.Wed;
                var Thu = task.Thu;
                var Fri = task.Fri;
                var Sat = task.Sat;
                var Sun = task.Sun;
                var MonStoryPoint = task.MonStoryPoint;
                var TueStoryPoint = task.TueStoryPoint;
                var WedStoryPoint = task.WedStoryPoint;
                var ThuStoryPoint = task.ThuStoryPoint;
                var FriStoryPoint = task.FriStoryPoint;
                var SatStoryPoint = task.SatStoryPoint;
                var SunStoryPoint = task.SunStoryPoint;
                var MonDescription = task.MonDescription;
                var TueDescription = task.TueDescription;
                var WedDescription = task.WedDescription;
                var ThuDescription = task.ThuDescription;
                var FriDescription = task.FriDescription;
                var SatDescription = task.SatDescription;
                var SunDescription = task.SunDescription;
                var ActualWork = task.ActualWork;
                var TaskActualWork = task.TaskActualWork;
                var ActualStartDate = task.ActualStartDate;
                var ActualEndDate = task.ActualEndDate;
                var ActualPercentComplete = task.ActualPercentComplete;
                var ResourcePercentComplete = task.ResourcePercentComplete;
                var IsTaskComplete = task.IsTaskComplete;
                var WhichTask = task.WhichTask;
                var SubTaskTypeID = task.SubTaskTypeID;
                var IsProject = task.IsProject;
                var Percentage = task.Percentage;
                var Tasknotes = task.Tasknotes;
                var StartDate = task.StartDate;
                var EndDate = task.EndDate;
                var Work = task.Work;
                var MileStone = task.MileStone;
                var Phase = task.Phase;
                var SubProjectName = task.SubProjectName;
                var DeliverableName = task.DeliverableName;
                var ModuleName = task.ModuleName;
                var Issue = task.Issue;
                var IsAgileProject = task.IsAgileProject;
                var ResourceLevelTaskCompletion = task.ResourceLevelTaskCompletion;
                var ApplyEffortDistribution = task.ApplyEffortDistribution;
                var IsVerified = task.IsVerified;
                var IsApprover = task.IsApprover;
                var StatusFlag = task.StatusFlag;
                var MonStatusFlag = task.MonStatusFlag;
                var TueStatusFlag = task.TueStatusFlag;
                var WedStatusFlag = task.WedStatusFlag;
                var ThuStatusFlag = task.ThuStatusFlag;
                var FriStatusFlag = task.FriStatusFlag;
                var SatStatusFlag = task.SatStatusFlag;
                var SunStatusFlag = task.SunStatusFlag;
                var RestrictByMinHours = task.RestrictByMinHours;
                if (PageFlag != 2 || PageFlag != 3) {
                    TimesheetID = task.TimesheetID;
                }
                if (PageFlag == 3) {
                    var IsApprover = task.IsApprover;
                }
                if (IsProject == 1) {
                    taskCounter = 0;
                    taskHTML += '<tr class="table_row_divider">'
                    taskHTML += '    <td colspan="10">&nbsp;</td>'
                    taskHTML += '    <td class="toggleDisplay">&nbsp;</td>'
                    taskHTML += ' </tr>'


                    taskHTML += '  <tr class="task">'
                    taskHTML += '                    <td>'
                    taskHTML += '                        <div class="tbl-projecttitle">'
                    taskHTML += '                           <img src="../../../Whizible2.0/dist/img/Projects_icon_blue.svg" width="20px"> ' + ProjectName
                    taskHTML += '                                    <div class="pull-right projecttitle_actions">'
                    if (PageFlag != 3) {
                        taskHTML += '                                        <a name="btnMoreProjectTaskLevel" class="nostyle hidden-xs" data-toggle="modal" data-target="#selectprojecttask" onclick="PlotFilterTaskList(' + ProjectID + ')">';
                        taskHTML += '                                            <img data-toggle="tooltip" data-placement="top" title="Add Task" src="../../../Whizible2.0/dist/img/Sub-tasks.svg" alt="" class="" width="15px"></a>'
                    }
                    taskHTML += '                                        <a class="nostyle hidden-xs" id="UpDownArrow" data-toggle="collapse" data-target=".projecthide' + ProjectID + '">'
                    taskHTML += '                                            <img data-toggle="tooltip" data-placement="top" title="Hide Task" src="../../../Whizible2.0/dist/img/up.svg" alt="" class="" width="15px"></a>'
                    taskHTML += '                                    </div>'
                    taskHTML += '                        </div>'
                    taskHTML += '                    </td>'
                    if (PageFlag != 3) {
                        taskHTML += '                    <td name="QuickEntryHeader">'
                        taskHTML += '                        <label class="pro_Calculate_count">&nbsp;</label>'
                        taskHTML += '                    </td>'
                    }
                    taskHTML += '                    <td>'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Mon + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td>'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Tue + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td>'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Wed + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td>'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Thu + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td>'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Fri + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td>'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Sat + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td class="toggleDisplay ">'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Sun + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td>'
                    taskHTML += '                        <label class="pro_Calculate_count">' + ActualWork + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td>'
                    taskHTML += '                        <label class="pro_Calculate_count"></label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td>'
                    taskHTML += '                        <label class="pro_Calculate_count">&nbsp;</label>'
                    taskHTML += '                    </td>'

                    if (PageFlag == 3) {
                        taskHTML += '<td class="text-center crossandcheckactions">'
                        //taskHTML += '   <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">'
                        //taskHTML += '      <div class="input-group">'
                        //taskHTML += '         <button data-toggle="modal" data-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>'
                        //taskHTML += '        <button data-toggle="modal" data-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-toggle="tooltip" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>'
                        //taskHTML += '   </div>'
                        //taskHTML += '</div>'
                        taskHTML += '</td>'
                    }
                    taskHTML += '                </tr>'

                }
                else {


                    if (SubTaskTypeID == 0)
                        taskHTML += '<tr class="task projecthide' + ProjectID + ' collapse in">'
                    else
                        taskHTML += '<tr class="task projecthide' + ProjectID + ' collapse in hidden-xs">'

                    taskHTML += '          <td>'
                    if (SubTaskTypeID == 0) {
                        taskCounter += 1
                        subTaskCounter = 0;
                        taskHTML += '              <div class="subtasklist subtasktitle dropdown hidden-xs">'
                        if (MonStatusFlag == 'J' || TueStatusFlag == 'J' || WedStatusFlag == 'J' || ThuStatusFlag == 'J' || FriStatusFlag == 'J' || SatStatusFlag == 'J' || SunStatusFlag == 'J') {
                            taskHTML += '                  <span class="subtask" style="color:red;" title="' + TaskName.replace("'", "\"") + '"  data-toggle="tooltip" data-placement="bottom" data-container="body">' + TaskName + '</span>&nbsp;'
                        }
                        else {
                            taskHTML += '                  <span class="subtask" title="' + TaskName.replace("'", "\"") + '"  data-toggle="tooltip" data-placement="bottom" data-container="body">' + TaskName + '</span>&nbsp;'
                        }
                    }
                    else {
                        subTaskCounter += 1;
                        taskHTML += '              <div class="subtasklist subtasktitle dropdown subtasklistsmall hidden-xs">'
                        taskHTML += '                 <span class="subtask" title="' + SubTaskType.replace("'", "\"") + '"  data-toggle="tooltip" data-placement="bottom" data-container="body">' + SubTaskType + '</span>&nbsp;'
                    }

                    taskHTML += '<div class="pull-right" data-toggle="tooltip" data-placement="top" title="Project Info">'
                    taskHTML += '<div id="popover-content-' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="dropdown-menu timeinfopopup hide" role="menu" aria-labelledby="menu1">'
                    //taskHTML += '<div class="arrow-left"></div>'
                    taskHTML += '<div class="projecttaskinfo_tooltipbox">'
                    taskHTML += '<button type="button" class="close"  id="close_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '">'
                    taskHTML += '<img width="20px" src="../../../Whizible2.0/dist/img/close-gray.svg"></button>'
                    taskHTML += '<div class="PTItooltipbox_hading">'
                    taskHTML += '' + ProjectName + ''
                    taskHTML += '<br />'
                    taskHTML += '<span class="PTItooltipbox_hading">' + TaskName + ' ' + (SubTaskTypeID == 0 ? "" : "/  " + SubTaskType) + '</span>                                                                                                                              '
                    taskHTML += '</div>'
                    taskHTML += '<p>' + Tasknotes + '</p>'
                    taskHTML += '<div class="projecttaskinfo_tooltipbox_schedule">'
                    taskHTML += '<div class="row">'
                    taskHTML += '<div class="col-xs-4">Start Date:</div>'
                    taskHTML += '<div class="col-xs-8">' + StartDate + '</div>'
                    taskHTML += '</div>'
                    taskHTML += '<div class="row">'
                    taskHTML += '<div class="col-xs-4">End Date:</div>'
                    taskHTML += '<div class="col-xs-8">' + EndDate + '</div>'
                    taskHTML += '</div>'
                    taskHTML += '<div class="row">'
                    taskHTML += '<div class="col-xs-4">Alloted Work:</div>'
                    taskHTML += '<div class="col-xs-8">' + Work + '</div>'
                    taskHTML += '</div>'
                    taskHTML += '<div class="row">'
                    taskHTML += '<div class="col-xs-4">Actual Work:</div>'
                    taskHTML += '<div class="col-xs-8">' + TaskActualWork + '</div>'
                    taskHTML += '</div>'
                    taskHTML += '</div>'
                    taskHTML += ''
                    taskHTML += '<hr />'
                    taskHTML += '<div class="projecttaskinfo_tooltipbox_schedule">'
                    taskHTML += '<div class="row">'
                    taskHTML += '<div class="col-xs-4">Phase:</div>'
                    taskHTML += '<div class="col-xs-8">' + Phase + '</div>'
                    taskHTML += '</div>'
                    taskHTML += '<div class="row">                                                                                                                            '
                    taskHTML += '<div class="col-xs-4">Milestone:</div>                                                                                                   '
                    taskHTML += '                                                  <div class="col-xs-8">' + MileStone + '</div>                                                                                                  '
                    taskHTML += '                                              </div>                                                                                                                                       '
                    taskHTML += '                                              <div class="row">                                                                                                                            '
                    taskHTML += '                                                  <div class="col-xs-4">Sub Project:</div>                                                                                                 '
                    taskHTML += '                                                  <div class="col-xs-8">' + SubProjectName + '</div>                                                                                   '
                    taskHTML += '                                              </div>'
                    taskHTML += '                                              <div class="row">                                                                                                                            '
                    taskHTML += '                                                  <div class="col-xs-4">Deliverable:</div>                                                                                                 '
                    taskHTML += '                                                  <div class="col-xs-8">' + DeliverableName + '</div>                                                                                   '
                    taskHTML += '                                              </div>'
                    taskHTML += '                                              <div class="row">                                                                                                                            '
                    taskHTML += '                                                  <div class="col-xs-4">Module:</div>                                                                                                 '
                    taskHTML += '                                                  <div class="col-xs-8">' + ModuleName + '</div>                                                                                   '
                    taskHTML += '                                              </div>'
                    taskHTML += '                                              <div class="row">                                                                                                                            '
                    taskHTML += '                                                  <div class="col-xs-4">Issue:</div>                                                                                                       '
                    taskHTML += '                                                  <div class="col-xs-8"><span class="issuetext" title="' + Issue.replace("'", "\"") + '"  data-toggle="tooltip" data-placement="top" >' + Issue + '</span></div>                                                                                   '
                    taskHTML += '                                              </div>                                                                                                                                       '
                    taskHTML += '                                          </div>                                                                                                                                           '
                    taskHTML += '                                                                                                                                                                                           '
                    taskHTML += '                                      </div>                                                                                                                                               '
                    taskHTML += '                                  </div>                                                                                                                                                   '
                    taskHTML += '                                  <img class="pull-right" src="../../../Whizible2.0/dist/img/exclaim.svg" width="13px" alt="" data-toggle="popover" data-container="body" data-placement="right" type="button" data-html="true" href="#" id="' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"> '
                    taskHTML += '                          </div>'
                    taskHTML += '                  <div class="clearfix"></div>'
                    taskHTML += '                  <div class="relativediv">'
                    if (SubTaskTypeID == 0) {
                        if (Percentage > 100) {
                            taskHTML += '                      <div data-toggle="tooltip" data-placement="top" title="Task Progress ' + Percentage + '%" class="progress progress-xs" style="background:#eb1c24 !important;">';
                            taskHTML += '                          <div class="progress-bar" style="width: ' + Percentage + '%;background:#eb1c24 !important;"></div>'
                            taskHTML += '                      </div>'
                        }
                        else {
                            taskHTML += '                      <div data-toggle="tooltip" data-placement="top" title="Task Progress ' + Percentage + '%" class="progress progress-xs" style="background:#ddd !important;">';
                            taskHTML += '                          <div class="progress-bar" style="width: ' + Percentage + '%"></div>'
                            taskHTML += '                      </div>'
                        }

                    }
                    taskHTML += '                      <ul class="projectsmenuicon">'
                    taskHTML += '                          <li class="dropdown">'
                    if (PageFlag != 3) {
                        taskHTML += '                              <a name="btnTSActions" data-toggle="dropdown" class="nostyle hidden-xs dropdown-toggle"><i class="fas fa-ellipsis-h" title="Action" data-toggle="tooltip" data-placement="top"></i></a>'
                    }
                    taskHTML += '                              <ul id="projects-menu" class="dropdown-menu clearfix" role="menu">'
                    if (SubTaskTypeID == 0) {
                        if (ApplyEffortDistribution == 1) {
                            taskHTML += '                                  <li data-toggle="tooltip" data-placement="top" title="Add Sub Tasks">'
                            taskHTML += '                                      <a href="javascript:;" class="nostyle hidden-xs" data-toggle="modal" data-target="#selectsubtask" onclick="PlotSubTaskList(' + ProjectID + ',' + TaskID + ')">';
                            taskHTML += '                                          <img src="../../../Whizible2.0/dist/img/Sub-tasks.svg" alt="" class="" width="15px">'
                            taskHTML += '                                          Add Sub Tasks</a>'
                            taskHTML += '                                  </li>'
                        }
                        taskHTML += '                                  <li data-toggle="tooltip" data-placement="top" title="Schedule Time Entry">'
                        taskHTML += '                                      <a href="javascript:;" class="nostyle hidden-xs" data-toggle="modal" data-target="#Schedule" onclick="PlotScheduleTSEntryData(' + TaskID + ',' + SubTaskTypeID + ')">'
                        taskHTML += '                                          <img src="../../../Whizible2.0/dist/img/Calendar with clock.svg" alt="" class="" width="15px">'
                        taskHTML += '                                          Schedule Time Entry</a>'
                        taskHTML += '                                  </li>'
                    }
                    if ((WhichTask == "M" || WhichTask == "O") && IsTaskComplete == 0) {
                        taskHTML += '                                  <li data-toggle="tooltip" data-placement="top" title="Request Additional Time">'
                        taskHTML += '                                      <a href="javascript:;" class="nostyle hidden-xs" data-toggle="modal" data-target="#requestadditionaltime" onclick="PlotAdditionalTimeRequestData(' + TaskID + ',' + SubTaskTypeID + ')">'
                        taskHTML += '                                          <img src="../../../Whizible2.0/dist/img/Time.svg" alt="" class="" width="10px">'
                        taskHTML += '                                          Request Additional Time</a>'
                        taskHTML += '                                  </li>'
                    }
                    taskHTML += '  '
                    taskHTML += '                              </ul>'
                    taskHTML += '                          </li>'
                    taskHTML += '  '
                    taskHTML += '                      </ul>'
                    taskHTML += '  '
                    taskHTML += '                  </div>'
                    taskHTML += '              </div>'
                    taskHTML += '  '
                    taskHTML += '              <div class="clearfix"></div>'
                    taskHTML += '<input type="hidden" name="hdnTaskData" id="hdnTaskData" value="' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" />';
                    taskHTML += '          </td>'
                    taskHTML += '  '
                    var className = ''
                    if (SubTaskTypeID == 0) {
                        //className = "taskdisabledcolum";

                    }
                    else {

                    }
                    if (PageFlag != 3) {
                        taskHTML += '          <td name="QuickEntryHeader" class="' + className + '">'
                        taskHTML += '              <div class="custom_chckbox">'
                        taskHTML += '                  <input type="checkbox" name="chkQuickEntry" id="chkQuickEntry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '" ">'
                        taskHTML += '                  <label name="chkQuickEntry" for="chkQuickEntry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                        taskHTML += '              </div>'
                        taskHTML += '          </td>'
                    }
                    if (IsTaskComplete == 0) {
                        //Monday
                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"  title="Description" data-placement="bottom">';
                        if (MonDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (MonStatusFlag == 'R' || MonStatusFlag == 'V') {
                            taskHTML += '             <input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" class="timenoinput dropdown-toggle" type="text" value="' + Mon + '" placeholder="' + Mon + '" name="" role="button" aria-haspopup="true" aria-expanded="true"  title="Effort" data-placement="bottom" readonly>';
                        }
                        else {
                            taskHTML += '             <input OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" class="timenoinput dropdown-toggle" type="text" value="' + Mon + '" placeholder="' + Mon + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  title="Effort" data-placement="bottom" >';
                        }

                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" type="hidden" value="' + new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US") + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" type="hidden" value="' + MonDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Mon != 0) {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" class="form-control" placeholder="Enter Description...">' + MonDescription + '</textarea>';
                            if (MonStatusFlag == 'R' || MonStatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',1)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                }
                            }
                        }
                        else {

                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" class="form-control" placeholder="Enter Description...">' + MonDescription + '</textarea>';
                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '           <input data-toggle="tooltip" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" type="text" value="' + MonStoryPoint + '" placeholder="' + MonStoryPoint + '" name="" data-placement="bottom" title="Story Point">';
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        //Tuesday
                        var NextDay = new Date();
                        NextDay.setDate(new Date($("#weekPicker2").attr("StartDate")).getDate() + 1);

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"  title="Description" data-placement="bottom">';
                        if (TueDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (TueStatusFlag == 'R' || TueStatusFlag == 'V') {
                            taskHTML += '             <input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" class="timenoinput dropdown-toggle" type="text" value="' + Tue + '" placeholder="' + Tue + '" name=""  role="button" aria-haspopup="true" aria-expanded="true" title="Effort" data-placement="bottom" readonly>';
                        }
                        else {
                            taskHTML += '             <input OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" class="timenoinput dropdown-toggle" type="text" value="' + Tue + '" placeholder="' + Tue + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true" title="Effort" data-placement="bottom">';
                        }

                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US")) + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" type="hidden" value="' + TueDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Tue != 0) {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" class="form-control" placeholder="Enter Description...">' + TueDescription + '</textarea>';
                            if (TueStatusFlag == 'R' || TueStatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',1)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                }
                            }
                        }
                        else {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" class="form-control" placeholder="Enter Description...">' + TueDescription + '</textarea>';
                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '           <input data-toggle="tooltip" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2"  type="text" value="' + TueStoryPoint + '" placeholder="' + TueStoryPoint + '" name="" data-placement="bottom" title="Story Point">';
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        //Wednesday
                        var NextDay = new Date();
                        NextDay.setDate(new Date($("#weekPicker2").attr("StartDate")).getDate() + 2);

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (WedDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (WedStatusFlag == 'R' || WedStatusFlag == 'V') {
                            taskHTML += '             <input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" class="timenoinput dropdown-toggle" type="text" value="' + Wed + '" placeholder="' + Wed + '" name="" role="button" aria-haspopup="true" aria-expanded="true"  title="Effort" data-placement="bottom" readonly>';
                        } else {
                            taskHTML += '             <input OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" class="timenoinput dropdown-toggle" type="text" value="' + Wed + '" placeholder="' + Wed + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  title="Effort" data-placement="bottom" >';
                        }

                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US")) + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" type="hidden" value="' + WedDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Wed != 0) {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" class="form-control" placeholder="Enter Description...">' + WedDescription + '</textarea>';
                            if (WedStatusFlag == 'R' || WedStatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',1)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                }
                            }
                        }
                        else {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" class="form-control" placeholder="Enter Description...">' + WedDescription + '</textarea>';
                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '           <input data-toggle="tooltip" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3"  type="text" value="' + WedStoryPoint + '" placeholder="' + WedStoryPoint + '" name="" data-placement="bottom" title="Story Point">';
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        //Thursday
                        var NextDay = new Date();
                        NextDay.setDate(new Date($("#weekPicker2").attr("StartDate")).getDate() + 3);

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (ThuDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V') {
                            taskHTML += '             <input  id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" class="timenoinput dropdown-toggle" type="text" value="' + Thu + '" placeholder="' + Thu + '" name="" role="button" aria-haspopup="true" aria-expanded="true"  title="Effort" data-placement="bottom" readonly>';
                        } else {
                            taskHTML += '             <input OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" class="timenoinput dropdown-toggle" type="text" value="' + Thu + '" placeholder="' + Thu + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  title="Effort" data-placement="bottom">';
                        }

                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US")) + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" type="hidden" value="' + ThuDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Thu != 0) {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" class="form-control" placeholder="Enter Description...">' + ThuDescription + '</textarea>';
                            if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',1)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                }
                            }
                        }
                        else {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" class="form-control" placeholder="Enter Description...">' + ThuDescription + '</textarea>';
                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '           <input data-toggle="tooltip" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" type="text" value="' + ThuStoryPoint + '" placeholder="' + ThuStoryPoint + '" name="" data-placement="bottom" title="Story Point">';
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        //Friday
                        var NextDay = new Date();
                        NextDay.setDate(new Date($("#weekPicker2").attr("StartDate")).getDate() + 4);

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (FriDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (FriStatusFlag == 'R' || FriStatusFlag == 'V') {
                            taskHTML += '             <input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" class="timenoinput dropdown-toggle" type="text" value="' + Fri + '" placeholder="' + Fri + '" name=""  role="button" aria-haspopup="true" aria-expanded="true"  title="Effort" data-placement="bottom" readonly>';
                        } else {
                            taskHTML += '             <input OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" class="timenoinput dropdown-toggle" type="text" value="' + Fri + '" placeholder="' + Fri + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  title="Effort" data-placement="bottom">';
                        }

                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US")) + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="' + FriDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Fri != 0) {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" class="form-control" placeholder="Enter Description...">' + FriDescription + '</textarea>';
                            if (FriStatusFlag == 'R' || FriStatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',1)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                }
                            }
                        }
                        else {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" class="form-control" placeholder="Enter Description...">' + FriDescription + '</textarea>';
                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '           <input data-toggle="tooltip" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5"  type="text" value="' + FriStoryPoint + '" placeholder="' + FriStoryPoint + '" name="" data-placement="bottom" title="Story Point">';
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        //Saturday
                        var NextDay = new Date();
                        NextDay.setDate(new Date($("#weekPicker2").attr("StartDate")).getDate() + 5);

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (SatDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (SatStatusFlag == 'R' || SatStatusFlag == 'V') {
                            taskHTML += '             <input  id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" class="timenoinput dropdown-toggle" type="text" value="' + Sat + '" placeholder="' + Sat + '" name="" role="button" aria-haspopup="true" aria-expanded="true"  title="Effort" data-placement="bottom" readonly>';
                        } else {
                            taskHTML += '             <input OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" class="timenoinput dropdown-toggle" type="text" value="' + Sat + '" placeholder="' + Sat + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  title="Effort" data-placement="bottom">';
                        }

                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US")) + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + SatDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Sat != 0) {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" class="form-control" placeholder="Enter Description...">' + SatDescription + '</textarea>';
                            if (SatStatusFlag == 'R' || SatStatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',1)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                }
                            }
                        }
                        else {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" class="form-control" placeholder="Enter Description...">' + SatDescription + '</textarea>';
                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '           <input data-toggle="tooltip" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6"  type="text" value="' + SatStoryPoint + '" placeholder="' + SatStoryPoint + '" name="" data-placement="bottom" title="Story Point">';
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        //Sunday
                        var NextDay = new Date();
                        NextDay.setDate(new Date($("#weekPicker2").attr("StartDate")).getDate() + 6);

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (SunDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (SatStatusFlag == 'R' || SatStatusFlag == 'V') {
                            taskHTML += '             <input  id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" class="timenoinput dropdown-toggle" type="text" value="' + Sun + '" placeholder="' + Sun + '" name="" role="button" aria-haspopup="true" aria-expanded="true"  title="Effort" data-placement="bottom" readonly>';
                        } else {
                            taskHTML += '             <input OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" class="timenoinput dropdown-toggle" type="text" value="' + Sun + '" placeholder="' + Sun + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  title="Effort" data-placement="bottom">';
                        }

                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US")) + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="' + SunDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Sun != 0) {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" class="form-control" placeholder="Enter Description...">' + SunDescription + '</textarea>';
                            if (SatStatusFlag == 'R' || SatStatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',1)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                }
                            }
                        }
                        else {
                            taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" class="form-control" placeholder="Enter Description...">' + SunDescription + '</textarea>';
                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '           <input data-toggle="tooltip" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7"  type="text" value="' + SunStoryPoint + '" placeholder="' + SunStoryPoint + '" name="" data-placement="bottom" title="Story Point">';
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        taskHTML += '          <td class="' + className + '">'
                        taskHTML += '              <label class="pro_Calculate_count">' + ActualWork + '</label>'
                        taskHTML += '          </td>'
                        taskHTML += '          <td><span class="workcomplted">'
                        if (SubTaskTypeID == 0) {
                            taskHTML += '              <input id="WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="timenoinput" type="text" value="' + ActualPercentComplete + '" placeholder="' + ActualPercentComplete + '%" name=""></span></td>'
                            taskHTML += '              <input id="RestrictByMinHours_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + RestrictByMinHours + '" name="">';
                        }
                        taskHTML += '          </span></td>'
                    }
                    else {
                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (MonDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Mon + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description...">' + MonDescription + '</textarea>';
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '                        <label class="pro_Calculate_count" title="Story Point" data-toggle="tooltip" data-placement="bottom">' + MonStoryPoint + '</label>'
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (TueDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Mon + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description...">' + TueDescription + '</textarea>';
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno" >'
                            taskHTML += '                        <label class="pro_Calculate_count" title="Story Point" data-toggle="tooltip" data-placement="bottom">' + TueStoryPoint + '</label>'
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (WedDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Wed + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description...">' + WedDescription + '</textarea>';
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '                        <label class="pro_Calculate_count" title="Story Point" data-toggle="tooltip" data-placement="bottom">' + WedStoryPoint + '</label>'
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (ThuDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Thu + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description...">' + ThuDescription + '</textarea>';
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '                        <label class="pro_Calculate_count" title="Story Point" data-toggle="tooltip" data-placement="bottom">' + ThuStoryPoint + '</label>'
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (FriDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Fri + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description...">' + FriDescription + '</textarea>';
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '                        <label class="pro_Calculate_count" title="Story Point" data-toggle="tooltip" data-placement="bottom">' + FriStoryPoint + '</label>'
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (SatDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Sat + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description...">' + SatDescription + '</textarea>';
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '                        <label class="pro_Calculate_count" title="Story Point" data-toggle="tooltip" data-placement="bottom">' + SatStoryPoint + '</label>'
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (SunDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Sun + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description...">' + SunDescription + '</textarea>';
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '                        <label class="pro_Calculate_count">' + SunStoryPoint + '</label>'
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        taskHTML += '                    <td>'
                        taskHTML += '                        <label class="pro_Calculate_count">' + ActualWork + '</label>'
                        taskHTML += '                    </td>'
                        taskHTML += '                    <td>'
                        taskHTML += '                        <label class="pro_Calculate_count">' + ActualPercentComplete + '%</label>'
                        taskHTML += '                    </td>'
                    }
                    if (SubTaskTypeID == 0) {
                        if (PageFlag != 3) {
                            if (ResourceLevelTaskCompletion == 1) {
                                taskHTML += '          <td>'
                                taskHTML += '              <div class="custom_chckbox">'
                                if (IsTaskComplete == 1) {

                                    taskHTML += '                  <input type="checkbox" name="IsTaskComplete" id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '" checked disabled style="cursor:not-allowed!important">'
                                    taskHTML += '<label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" style="cursor:not-allowed!important"></label>'
                                }
                                else {
                                    taskHTML += '                  <input type="checkbox" name="IsTaskComplete" id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '">'
                                    taskHTML += '                  <label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                                }

                                taskHTML += '              <input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                taskHTML += '              </div>'
                                taskHTML += '          </td>'
                            }
                            else {
                                taskHTML += '          <td>'
                                taskHTML += '              <div class="custom_chckbox">N/A';
                                taskHTML += '              <input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                taskHTML += '              </div>'
                                taskHTML += '          </td>'
                            }
                        }
                        else {
                            taskHTML += '          <td>'
                            taskHTML += '              <div class="custom_chckbox">'
                            if (IsTaskComplete == 1) {
                                taskHTML += '                  <input type="checkbox" name="IsTaskComplete" id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '" checked disabled style="cursor:not-allowed!important">'
                                taskHTML += '                  <label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" style="cursor:not-allowed!important"></label>'
                            }
                            else {
                                taskHTML += '                  <input type="checkbox" name="IsTaskComplete" id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '">'
                                taskHTML += '                  <label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                            }

                            taskHTML += '              <input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                            taskHTML += '              </div>'
                            taskHTML += '          </td>'
                        }
                    }
                    else {
                        taskHTML += '          <td>'
                        taskHTML += '              <div class="custom_chckbox">'
                        taskHTML += '              <input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                        taskHTML += '              </div>'
                        taskHTML += '          </td>'
                    }

                    if (PageFlag == 3) {
                        taskHTML += '<td class="text-center crossandcheckactions">'
                        if (IsApprover == 1) {


                            taskHTML += '<div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn" name="DivAction">'
                            taskHTML += '<div class="input-group">'

                            if (StatusFlag == "J" || $(".Status").html() == "Rejected") { $("#btnApproveT").css("display", "none"); }
                            else if (StatusFlag == "V") {
                                taskHTML += "                                  <button data-toggle='modal' id='btnRejectTask' onclick=RejectPopup(this," + TaskID + ",'" + escape(TaskName) + "') class='btn btn-outline-secondary btn-red' type='button' data-placement='top' title='' data-original-title='Reject'><i class='fas fa-times'></i></button>"
                            }
                            else {
                                taskHTML += "                                  <button data-toggle='modal' id='btnApproveTask' onclick=ApprovePopup(this," + TaskID + ",'" + escape(TaskName) + "') class='btn btn-outline-secondary btn-success' type='button' data-placement='top' title='' data-original-title='Approve'><i class='fas fa-check'></i></button>"
                                taskHTML += "                                  <button data-toggle='modal' id='btnRejectTask' onclick=RejectPopup(this," + TaskID + ",'" + escape(TaskName) + "') class='btn btn-outline-secondary btn-red' type='button' data-placement='top' title='' data-original-title='Reject'><i class='fas fa-times'></i></button>"
                            }

                            taskHTML += '</div>'
                            taskHTML += '</div>'
                            taskHTML += '</td>'
                        }
                    }
                    taskHTML += '      </tr>'
                }
            }
            $("#timesheetBody").html(taskHTML);

            var x = $("#timesheetHeader tr:first-child th.toggleDisplay");
            var txt = "";
            var i;
            for (i = 0; i < x.length; i++) {
                $("#timesheetBody td:nth-child(" + (parseInt(x[i].cellIndex) + 1) + ")").addClass("toggleDisplay");
            }
        }

        function changeView(flag) {
            isWeeklyView = flag;
            if (isWeeklyView == 1) {
                $("#dailyviewcal").hide();
                $("#weeklyviewcal").show();

                ReloadData(EmployeeID);
            }
            else {
                $("#weeklyviewcal").hide();
                $("#dailyviewcal").show();

                plotDailyTaskList();
            }
        }


        function plotDailyTaskList() {
            // debugger;
            var taskHTML = "";
            var taskCounter = 0;
            var subTaskCounter = 0;
            $("#dailyTimesheetTable").html(taskHTML);
            var taskParameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: new Date($('#dailyviewdatepicker').attr("selecteddate")).toLocaleDateString("en-US"),
                dtToDate: "",
                intIsDefault: IsDefault,
                strWhichTask: WhichTask,
                strTaskIDList: TaskIDList,
                strFilterProjectList: "",
                strFilterTaskTypeList: "",
                strFilterTaskCategories: "",
                strFilterBillable: "",
                strFilterPriorityList: "",
                strFilterPhaseList: "",
                strFilterMilestoneList: "",
                strFilterSubProjectList: "",
                strFilterModuleList: "",
                strFilterDeliverableList: "",
                strFilterTaskStatus: "",
                SubTaskTypeList: SubTaskTypeList
            }
            // alert(taskParameters.dtFromDate);
            StartLoader("#bodyTSEntry");
            $.ajax({
                url: strUrl + '/api/Timesheet/GetTaskListDayView',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var WeekTotalLists = data.WeekTotalLists;
                    var headerColumns = data.headerColumns;
                    var timesheetLists = data.timesheetLists;

                    taskHTML += ' <thead class="header">'
                    taskHTML += '     <tr>'
                    taskHTML += '         <th>Projects / Tasks / Sub-Task<span>'
                    taskHTML += '             <button id="btnMoreProjects" class="btn borderbtn ml-1 mt-onehalf" data-toggle="modal" data-target="#selectprojecttask" onclick="PlotFilterTaskList(0)" title="Select More Projects" data-placement="bottom">More Projects+</button></span></th>'
                    taskHTML += '         <th>Quick Entry<span class="quickentryrecord" title="Add Quick Entry(hh.mm format)" data-toggle="tooltip" data-placement="bottom"><input type="text" id="txtQuickEntryDaily" value="00:00">'
                    taskHTML += '             <button id="btnQuickEntry" onclick="QuickEntry_Click()"><i class="fas fa-check"></i></button>'
                    taskHTML += '         </span></th>'
                    for (var i = 0; i < headerColumns.length; i++) {
                        var header = headerColumns[i];
                        var EntryDate = header.EntryDate;
                        var DayName = header.DayName;
                        taskHTML += "<th>";
                        taskHTML += '' + EntryDate + ',<span>' + DayName + '</span>'
                        taskHTML += "</th>";
                    }
                    taskHTML += '         <th>Weekly<span>total</span></th>'
                    taskHTML += '         <th>% Work <span>Complete</span></th>'
                    taskHTML += '         <th>Task <span>Complete</span></th>'
                    taskHTML += '     </tr>'
                    for (var i = 0; i <= WeekTotalLists.length - 1; i++) {
                        var WeekTotalObject = WeekTotalLists[i];
                        var Total = WeekTotalObject.Total;
                        var EntryDate = WeekTotalObject.EntryDate;
                        var AllTotal = WeekTotalObject.AllTotal;
                        var WeekDays = WeekTotalObject.WeekDays;
                        taskHTML += '     <tr class="task totalworkcountrow">'
                        taskHTML += '         <td class="totalworkcountrow">Totale work for a week</td>'
                        taskHTML += '         <td>&nbsp;</td>'
                        taskHTML += '         <td>'
                        taskHTML += '             <label class="pro_Calculate_count">' + Total + '</label>'
                        taskHTML += '         </td>'
                        taskHTML += '         <td>'
                        taskHTML += '             <label class="pro_Calculate_count">' + AllTotal + '</label>'
                        taskHTML += '         </td>'
                        taskHTML += '         <td>&nbsp;</td>'
                        taskHTML += '         <td>&nbsp;</td>'
                        taskHTML += '     </tr>'
                    }
                    taskHTML += ' </thead>'

                    for (var i = 0; i < timesheetLists.length; i++) {
                        var task = timesheetLists[i];
                        var TaskID = task.TaskID;
                        var TaskName = task.TaskName;
                        var SubTaskType = task.SubTaskType;
                        var ProjectID = task.ProjectID;
                        var ProjectName = task.ProjectName;
                        var Description = task.Description;
                        var Duration = task.Duration;
                        var DayName = task.DayName;
                        var ActualWork = task.ActualWork;
                        var TaskActualWork = task.TaskActualWork;
                        var ActualStartDate = task.ActualStartDate;
                        var ActualEndDate = task.ActualEndDate;
                        var ActualPercentComplete = task.ActualPercentComplete;
                        var ResourcePercentComplete = task.ResourcePercentComplete;
                        var IsTaskComplete = task.IsTaskComplete;
                        var WhichTask = task.WhichTask;
                        var SubTaskTypeID = task.SubTaskTypeID;
                        var IsProject = task.IsProject;
                        var Percentage = task.Percentage;
                        var Tasknotes = task.Tasknotes;
                        var StartDate = task.StartDate;
                        var EndDate = task.EndDate;
                        var Work = task.Work;
                        var MileStone = task.MileStone;
                        var Phase = task.Phase;
                        var SubProjectName = task.SubProjectName;
                        var DeliverableName = task.DeliverableName;
                        var ModuleName = task.ModuleName;
                        var Issue = task.Issue;
                        var DAID = task.DAID;
                        var StoryPoint = task.StoryPoint;
                        var IsAgileProject = task.IsAgileProject;
                        var ResourceLevelTaskCompletion = task.ResourceLevelTaskCompletion;
                        var ApplyEffortDistribution = task.ApplyEffortDistribution;
                        var StatusFlag = task.StatusFlag;
                        var AllowToResubmit = task.AllowToResubmit;
                        if (IsProject == 1) {
                            taskCounter = 0;
                            taskHTML += '<tr class="table_row_divider">'
                            taskHTML += '    <td colspan="6">&nbsp;</td>'
                            taskHTML += '    <td class="toggleDisplay ">&nbsp;</td>'
                            taskHTML += ' </tr>'


                            taskHTML += '  <tr class="task">'
                            taskHTML += '                    <td>'
                            taskHTML += '                        <div class="tbl-projecttitle">'
                            taskHTML += '                           <img src="../../../Whizible2.0/dist/img/Projects_icon_blue.svg" width="20px"> ' + ProjectName
                            taskHTML += '                                    <div class="pull-right projecttitle_actions">'
                            taskHTML += '                                        <a name="btnMoreProjectTaskLevel" class="nostyle hidden-xs" data-toggle="modal" data-target="#selectprojecttask" onclick="PlotFilterTaskList(' + ProjectID + ')">';
                            taskHTML += '                                            <img data-toggle="tooltip" data-placement="top" title="Select Project" src="../../../Whizible2.0/dist/img/Sub-tasks.svg" alt="" class="" width="15px"></a>'
                            taskHTML += '                                        <a class="nostyle hidden-xs" id="UpDownArrow" data-toggle="collapse" data-target=".projecthide' + ProjectID + '">'
                            taskHTML += '                                            <img data-toggle="tooltip" data-placement="top" title="Hide Task" src="../../../Whizible2.0/dist/img/up.svg" alt="" class="" width="15px"></a>'
                            taskHTML += '                                    </div>'
                            taskHTML += '                        </div>'
                            taskHTML += '                    </td>'
                            taskHTML += '                    <td>'
                            taskHTML += '                        <label class="pro_Calculate_count">&nbsp;</label>'
                            taskHTML += '                    </td>'
                            taskHTML += '                    <td>'
                            taskHTML += '                        <label class="pro_Calculate_count">' + Duration + '</label>'
                            taskHTML += '                    </td>'
                            taskHTML += '                    <td>'
                            taskHTML += '                        <label class="pro_Calculate_count">' + ActualWork + '</label>'
                            taskHTML += '                    </td>'
                            taskHTML += '                    <td>'
                            taskHTML += '                        <label class="pro_Calculate_count"></label>'
                            taskHTML += '                    </td>'
                            taskHTML += '                    <td>'
                            taskHTML += '                        <label class="pro_Calculate_count">&nbsp;</label>'
                            taskHTML += '                    </td>'
                            taskHTML += '                </tr>'

                        }
                        else {


                            if (SubTaskTypeID == 0)
                                taskHTML += '<tr class="task projecthide' + ProjectID + ' collapse in">'
                            else
                                taskHTML += '<tr class="task projecthide' + ProjectID + ' collapse in hidden-xs">'

                            taskHTML += '          <td>'
                            if (SubTaskTypeID == 0) {
                                taskCounter += 1
                                subTaskCounter = 0;

                                taskHTML += '              <div class="subtasklist subtasktitle dropdown hidden-xs">'

                                if (StatusFlag == 'J') {
                                    taskHTML += '                  <span class="subtask" style="color:red;" title="' + TaskName.replace("'", "\"") + '"  data-toggle="tooltip" data-placement="bottom" data-container="body">' + TaskName + '</span>&nbsp;'
                                    //taskHTML += '                 <span style="color: red;">' + TaskName + '&nbsp;</span>'
                                }
                                else {
                                    taskHTML += '                 <span class="subtask"  title="' + TaskName.replace("'", "\"") + '"  data-toggle="tooltip" data-placement="bottom" data-container="body">' + TaskName + '</span>&nbsp;'
                                }
                            }
                            else {
                                subTaskCounter += 1;
                                taskHTML += '              <div class="subtasklist subtasktitle dropdown subtasklistsmall hidden-xs">'
                                taskHTML += '                   <span class="subtask"  title="' + SubTaskType.replace("'", "\"") + '"  data-toggle="tooltip" data-placement="bottom" data-container="body">' + SubTaskType + '</span>&nbsp;'

                            }

                            taskHTML += '<div class="pull-right" data-toggle="tooltip" data-placement="top" title="Project Info">'
                            taskHTML += '<div id="popover-content-' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">'
                            taskHTML += '<div class="arrow-left"></div>'
                            taskHTML += '<div class="projecttaskinfo_tooltipbox">'
                            taskHTML += '<button type="button" class="close"  id="close_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '">'
                            taskHTML += '<img width="20px" src="../../../Whizible2.0/dist/img/close-gray.svg"></button>'
                            taskHTML += '<div class="PTItooltipbox_hading">'
                            taskHTML += '' + ProjectName + ''
                            taskHTML += '<br />'
                            taskHTML += '<span class="PTItooltipbox_hading">' + TaskName + ' ' + (SubTaskTypeID == 0 ? "" : "/  " + SubTaskType) + '</span>                                                                                                                              '
                            taskHTML += '</div>'
                            taskHTML += '<p>' + Tasknotes + '</p>'
                            taskHTML += '<div class="projecttaskinfo_tooltipbox_schedule">'
                            taskHTML += '<div class="row">'
                            taskHTML += '<div class="col-xs-4">Start Date:</div>'
                            taskHTML += '<div class="col-xs-8">' + StartDate + '</div>'
                            taskHTML += '</div>'
                            taskHTML += '<div class="row">'
                            taskHTML += '<div class="col-xs-4">End Date:</div>'
                            taskHTML += '<div class="col-xs-8">' + EndDate + '</div>'
                            taskHTML += '</div>'
                            taskHTML += '<div class="row">'
                            taskHTML += '<div class="col-xs-4">Alloted Work:</div>'
                            taskHTML += '<div class="col-xs-8">' + Work + '</div>'
                            taskHTML += '</div>'
                            taskHTML += '<div class="row">'
                            taskHTML += '<div class="col-xs-4">Actual Work:</div>'
                            taskHTML += '<div class="col-xs-8">' + TaskActualWork + '</div>'
                            taskHTML += '</div>'
                            taskHTML += '</div>'
                            taskHTML += ''
                            taskHTML += '<hr />'
                            taskHTML += '<div class="projecttaskinfo_tooltipbox_schedule">'
                            taskHTML += '<div class="row">'
                            taskHTML += '<div class="col-xs-4">Phase:</div>'
                            taskHTML += '<div class="col-xs-8">' + Phase + '</div>'
                            taskHTML += '</div>'
                            taskHTML += '<div class="row">                                                                                                                            '
                            taskHTML += '<div class="col-xs-4">Milestone:</div>                                                                                                   '
                            taskHTML += '                                                  <div class="col-xs-8">' + MileStone + '</div>                                                                                                  '
                            taskHTML += '                                              </div>                                                                                                                                       '
                            taskHTML += '                                              <div class="row">                                                                                                                            '
                            taskHTML += '                                                  <div class="col-xs-4">Sub Project:</div>                                                                                                 '
                            taskHTML += '                                                  <div class="col-xs-8">' + SubProjectName + '</div>                                                                                   '
                            taskHTML += '                                              </div>'
                            taskHTML += '                                              <div class="row">                                                                                                                            '
                            taskHTML += '                                                  <div class="col-xs-4">Deliverable:</div>                                                                                                 '
                            taskHTML += '                                                  <div class="col-xs-8">' + DeliverableName + '</div>                                                                                   '
                            taskHTML += '                                              </div>'
                            taskHTML += '                                              <div class="row">                                                                                                                            '
                            taskHTML += '                                                  <div class="col-xs-4">Module:</div>                                                                                                 '
                            taskHTML += '                                                  <div class="col-xs-8">' + ModuleName + '</div>                                                                                   '
                            taskHTML += '                                              </div>'
                            taskHTML += '                                              <div class="row">                                                                                                                            '
                            taskHTML += '                                                  <div class="col-xs-4">Issue:</div>                                                                                                       '
                            taskHTML += '                                                   <div class="col-xs-8"><span class="issuetext" title="' + Issue.replace("'", "\"") + '"  data-toggle="tooltip" data-placement="top" >' + Issue + '</span></div>                                                                                   '
                            taskHTML += '                                              </div>                                                                                                                                       '
                            taskHTML += '                                          </div>                                                                                                                                           '
                            taskHTML += '                                                                                                                                                                                           '
                            taskHTML += '                                      </div>                                                                                                                                               '
                            taskHTML += '                                  </div>                                                                                                                                                   '
                            taskHTML += '                                  <img class="pull-right" src="../../../Whizible2.0/dist/img/exclaim.svg" width="13px" alt="" data-toggle="popover" data-container="body" data-placement="right" type="button" data-html="true" href="#" id="' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"> '
                            taskHTML += '                          </div>'
                            taskHTML += '                  <div class="clearfix"></div>'
                            taskHTML += '                  <div class="relativediv">'
                            if (SubTaskTypeID == 0) {
                                if (Percentage > 100) {
                                    taskHTML += '                      <div data-toggle="tooltip" data-placement="top" title="Task Progress ' + Percentage + '%" class="progress progress-xs" style="background:#eb1c24 !important;">'
                                    taskHTML += '                          <div class="progress-bar" style="width: ' + Percentage + '%;background:#eb1c24 !important;"></div>'
                                    taskHTML += '                      </div>'
                                } else {
                                    taskHTML += '                      <div data-toggle="tooltip" data-placement="top" title="Task Progress ' + Percentage + '%" class="progress progress-xs" style="background:#ddd !important;">'
                                    taskHTML += '                          <div class="progress-bar" style="width: ' + Percentage + '%"></div>'
                                    taskHTML += '                      </div>'
                                }
                            }
                            taskHTML += '                      <ul class="projectsmenuicon">'
                            taskHTML += '                          <li class="dropdown">'
                            taskHTML += '                              <a name="btnTSActions" data-toggle="dropdown" class="nostyle hidden-xs dropdown-toggle" ><i class="fas fa-ellipsis-h" title="Action" data-toggle="tooltip" data-placement="top"></i></a>'
                            taskHTML += '                              <ul id="projects-menu" class="dropdown-menu clearfix" role="menu">'
                            if (SubTaskTypeID == 0) {
                                if (ApplyEffortDistribution == 1) {
                                    taskHTML += '                                  <li data-toggle="tooltip" data-placement="top" title="Add Sub Tasks">'
                                    taskHTML += '                                      <a href="javascript:;" class="nostyle hidden-xs" data-toggle="modal" data-target="#selectsubtask" onclick="PlotSubTaskList(' + ProjectID + ',' + TaskID + ')"">'
                                    taskHTML += '                                          <img src="../../../Whizible2.0/dist/img/Sub-tasks.svg" alt="" class="" width="15px">'
                                    taskHTML += '                                          Add Sub Tasks</a>'
                                    taskHTML += '                                  </li>'
                                }
                                taskHTML += '  '
                                taskHTML += '                                  <li data-toggle="tooltip" data-placement="top" title="Schedule Time Entry">'
                                taskHTML += '                                      <a href="javascript:;" class="nostyle hidden-xs" data-toggle="modal" data-target="#Schedule" onclick="PlotScheduleTSEntryData(' + TaskID + ',' + SubTaskTypeID + ')">'
                                taskHTML += '                                          <img src="../../../Whizible2.0/dist/img/Calendar with clock.svg" alt="" class="" width="15px">'
                                taskHTML += '                                          Schedule Time Entry</a>'
                                taskHTML += '                                  </li>'
                            }
                            if ((WhichTask == "M" || WhichTask == "O") && IsTaskComplete == 0) {
                                taskHTML += '                                  <li data-toggle="tooltip" data-placement="top" title="Request Additional Time">'
                                taskHTML += '                                      <a href="javascript:;" class="nostyle hidden-xs" data-toggle="modal" data-target="#requestadditionaltime" onclick="PlotAdditionalTimeRequestData(' + TaskID + ',' + SubTaskTypeID + ')">'
                                taskHTML += '                                          <img src="../../../Whizible2.0/dist/img/Time.svg" alt="" class="" width="10px">'
                                taskHTML += '                                          Request Additional Time</a>'
                                taskHTML += '                                  </li>'
                            }
                            taskHTML += '  '
                            taskHTML += '                              </ul>'
                            taskHTML += '                          </li>'
                            taskHTML += '  '
                            taskHTML += '                      </ul>'
                            taskHTML += '  '
                            taskHTML += '                  </div>'
                            taskHTML += '              </div>'
                            taskHTML += '  '
                            taskHTML += '              <div class="clearfix"></div>'
                            taskHTML += '<input type="hidden" name="hdnTaskDataDaily" id="hdnTaskDataDaily" value="' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" />';
                            taskHTML += '  '
                            taskHTML += '          </td>'
                            taskHTML += '  '
                            var className = ''
                            if (SubTaskTypeID == 0) {
                                //className = "taskdisabledcolum";

                            }
                            else {

                            }
                            taskHTML += '          <td class="' + className + '">'
                            taskHTML += '              <div class="custom_chckbox">'
                            taskHTML += '                  <input type="checkbox" name="chkQuickEntryDaily" id="chkQuickEntryDaily_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '">'
                            taskHTML += '                  <label for="chkQuickEntryDaily_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                            taskHTML += '              </div>'
                            taskHTML += '          </td>'
                            if (IsTaskComplete == 0) {
                                taskHTML += '<td class="pr">'
                                taskHTML += '    <div class="dropdown">'
                                taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                                if (Description != "") {
                                    taskHTML += '        <i class="far fa-list-alt"></i>'
                                }
                                taskHTML += '        </span>';
                                if (StatusFlag == 'R' || StatusFlag == 'V') {
                                    taskHTML += '             <input  id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="timenoinput dropdown-toggle" type="text" value="' + Duration + '" placeholder="' + Duration + '" name="" role="button" aria-haspopup="true" aria-expanded="true" title="Effort" data-placement="bottom" readonly>';
                                } else {
                                    taskHTML += '             <input OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="timenoinput dropdown-toggle" type="text" value="' + Duration + '" placeholder="' + Duration + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true" title="Effort" data-placement="bottom">';
                                }

                                taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + (new Date($('#dailyviewdatepicker').attr("selecteddate")).toLocaleDateString("en-US")) + '" name="">';
                                taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + DAID + '" name="">';
                                taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="0" name="">';
                                taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                                if (Duration != 0) {
                                    taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="form-control" placeholder="Enter Description...">' + Description + '</textarea>';
                                    if (StatusFlag == 'R' || StatusFlag == 'V') {

                                    }
                                    else {
                                        if (PageFlag != 3) {
                                            taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',1)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                        }
                                    }
                                }
                                else {
                                    taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="form-control" placeholder="Enter Description...">' + Description + '</textarea>';
                                }
                                taskHTML += '              </div>'
                                taskHTML += '    </div>'
                                if (IsAgileProject == 1) {
                                    taskHTML += '    <span class="timeno">'
                                    taskHTML += '       <span class="selecttimeno">'
                                    taskHTML += '           <input data-toggle="tooltip" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-placement="bottom" title="" type="text" value="' + StoryPoint + '" placeholder="' + StoryPoint + '" name="" data-placement="bottom" title="Story Point">';
                                    taskHTML += '       </span>';
                                    taskHTML += '    </span>';
                                }
                                taskHTML += '</td>';
                            }
                            else {
                                taskHTML += '<td class="pr">'
                                taskHTML += '    <div class="dropdown">'
                                taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom"><i class="far fa-list-alt"></i></span>'
                                taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Duration + '</label>'
                                taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                                taskHTML += '                  <textarea class="form-control" placeholder="Enter Description...">' + Description + '</textarea>';
                                taskHTML += '              </div>'
                                taskHTML += '    </div>'
                                if (IsAgileProject == 1) {
                                    taskHTML += '    <span class="timeno">'
                                    taskHTML += '       <span class="selecttimeno">'
                                    taskHTML += '                        <label class="pro_Calculate_count">' + StoryPoint + '</label>'
                                    taskHTML += '       </span>';
                                    taskHTML += '    </span>';
                                }
                                taskHTML += '</td>';
                            }

                            taskHTML += '   <td> <label class="pro_Calculate_count">' + ActualWork + '</label></td>'


                            taskHTML += '   <td><span class="workcomplted">'
                            if (SubTaskTypeID == 0) {

                                taskHTML += '       <input id="WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="timenoinput" type="text" value="" placeholder="' + ActualPercentComplete + '%" name="">'


                            }
                            taskHTML += '   </span></td>'
                            if (SubTaskTypeID == 0) {
                                if (ResourceLevelTaskCompletion == 1) {
                                    taskHTML += '          <td>'
                                    taskHTML += '              <div class="custom_chckbox">'
                                    if (IsTaskComplete == 1) {
                                        taskHTML += '                  <input type="checkbox" name="IsTaskComplete" id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '" checked disabled style="cursor:not-allowed!important;>'
                                    }
                                    else {
                                        taskHTML += '                  <input type="checkbox" name="IsTaskComplete" id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '">'
                                    }
                                    taskHTML += '                  <label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                                    taskHTML += '              <input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                    taskHTML += '              </div>'
                                    taskHTML += '          </td>'
                                }
                                else {
                                    taskHTML += '          <td>'
                                    taskHTML += '              <div class="custom_chckbox">N/A';
                                    taskHTML += '              <input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                    taskHTML += '              </div>'
                                    taskHTML += '          </td>'
                                }
                            }
                            else {
                                taskHTML += '          <td>'
                                taskHTML += '              <div class="custom_chckbox">'
                                taskHTML += '              <input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                taskHTML += '              </div>'
                                taskHTML += '          </td>'
                            }
                            taskHTML += '</tr>'

                        }
                    }
                    $("#dailyTimesheetTable").html(taskHTML);
                    AfterPlot();
                    StopAjaxLoader("#bodyTSEntry");
                },
                error: function (err) {
                    console.log(err);
                }
            })
        }
        function BindProjects() {
            var taskParameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: $("#CTselectdate").val(),
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/BindProject',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var selHTML = "";
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        var ProjectID = d.ProjectID;
                        var ProjectName = d.ProjectName;
                        selHTML += "<option title='" + ProjectName + "' value='" + ProjectID + "'>" + ProjectName + "</option>";
                    }
                    $("#cboProject").html(selHTML);
                    $(".selectpicker").selectpicker('refresh');
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        function ProjectOnChange(ProjectID) {
            var taskParameters = {
                FilterProjectID: ProjectID,
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/GetTaskTypeFromProject',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var selHTML = "";
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        var TaskTypeID = d.TaskTypeID;
                        var TaskType = d.TaskType;
                        selHTML += "<option title='" + TaskType + "' value='" + TaskTypeID + "'>" + TaskType + "</option>";
                    }
                    $("#cboTaskType").html(selHTML);
                    $(".selectpicker").selectpicker('refresh');
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        function TaskTypeOnChange(TaskTypeID) {
            var ProjectID = document.getElementById("cboProject").value;
            var taskParameters = {
                FilterProjectID: ProjectID,
                FilterTaskTypeID: TaskTypeID,
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/GetSubTaskTypeFromProject',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var selHTML = "";
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        var SubTaskTypeID = d.SubTaskTypeID;
                        var SubTaskType = d.SubTaskType;
                        selHTML += "<option title='" + SubTaskType + "' value='" + SubTaskTypeID + "'>" + SubTaskType + "</option>";
                    }
                    $("#cboSubTaskType").html(selHTML);
                    $(".selectpicker").selectpicker('refresh');
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        function RestrictNonNumeric(obj) {
            if (obj == null) { return false; }
            if (isBlank(getInputValue(obj))) { return false; }

            var dofocus = (arguments.length > 1) ? arguments[1] : true;
            if (!isNumeric(getInputValue(obj))) {
                if (dofocus) {
                    setFocus(obj);
                }
                return true;
            }
            return false;
        }
        function showAlert(Msg, className, id) {
            $('.ClosaeblealertMsg').show();
            if (id != undefined) {
                $('#' + id).prop("disabled", true);
            }
            if (className == 'alert-danger') {
                $('#CloseableAlert').removeClass("alert-success");
                $('#CloseableAlert').addClass("alert-danger");
            }
            else if (className == 'alert-success') {
                $('#CloseableAlert').removeClass("alert-danger");
                $('#CloseableAlert').addClass("alert-success");
            }
            $('#alertMsg').html(Msg);
            $('.ClosaeblealertMsg').delay(5000).fadeOut("fast", function () {
                if (id != undefined) {
                    $('#' + id).prop("disabled", false);
                }
            });
        }
        function StoryPoint_OnChange(objTextBox) {
            if (isNaN(objTextBox.value)) {
                showAlert('Please enter numeric value', 'alert-danger');
                objTextBox.value = "";
                return false;
            }
            if (objTextBox.value != "") {
                if (RestrictNonNumeric(objTextBox) == true) {
                    showAlert('Please Enter positive numeric value for Story Point', 'alert-danger');
                    objTextBox.value = "";
                    return false;
                }
                if (objTextBox.value < "0") {
                    showAlert('Please Enter only positive numeric value greater than 0 For Story Point', 'alert-danger');
                    objTextBox.value = "";
                    return false;
                }
                var EntryID = (objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'Entry');
                var arrData = EntryID.split('_');
                var TaskID = arrData[2];
                //var TaskID = getNewTaskID(id);
                var taskParameters = {
                    TaskID: TaskID,
                    StoryPoint: objTextBox.value,
                }
                // data = JSON.stringify({ TaskID: TaskID, StoryPoint: objTextBox.value });
                // strResult = AJAXCallWithResult("TS_Scrum_WeeklyTimesheet.aspx/ValidateStoryPoint", data, false);
                $.ajax({
                    url: strUrl + '/api/Timesheet/ValidateStoryPoint',
                    type: "POST",
                    data: JSON.stringify(taskParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (data) {
                        if (data != "") {
                            showAlert(data, 'alert-danger');
                            objTextBox.value = "";
                            return false;
                        }
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });

            }
        }
        var DATextbox;
        var objDuChRow;

        function Hours_OnChange(objTextBox) {
            // debugger;

            if (objTextBox.Value != "") {
                var dblColSum;
                dblColSum = 0;
                var objHoursComplete = document.getElementById(objTextBox.id);
                objHoursComplete.value = objHoursComplete.value.replace(/:/g, ".");
                var precision = objHoursComplete.value.split(".")[1];

                if (precision > 60) {
                    showAlert('Please enter number after decimal point less than 60.', 'alert-danger');
                    return false;
                }
                if (precision == 60) {
                    objHoursComplete.value = (objHoursComplete.value.split(".")[0] - 0) + 1;
                }
                DATextbox = objTextBox.id;

                if (RestrictNonNumeric(objHoursComplete) == true) {
                    showAlert('Please enter numeric values.', 'alert-danger');
                    return false;
                }
                if ((objHoursComplete.value - 0) >= 0 && (objHoursComplete.value - 0) <= intMaxEntry) {
                } else {
                    showAlert('The Range of Actual Working Hours is [0.00 to ' + intMaxEntry.toFixed(2) + ']', 'alert-danger');
                    return false;
                }
                objHoursComplete.value = (objHoursComplete.value - 0).toFixed(2);



                var EntryID = (objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'Entry');
                var arrData = EntryID.split('_')
                var ProjectID = arrData[1];
                var TaskID = arrData[2];
                var SubTaskTypeID = arrData[3];
                var objEntryDate = document.getElementById(EntryID);
                var objIsTaskComplete = document.getElementById('IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                var IsTaskCompleteCheck = 0;
                var RestrictByMinHours = document.getElementById('RestrictByMinHours_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                if (objIsTaskComplete != null)
                    IsTaskCompleteCheck = objIsTaskComplete.checked;
                objDuChRow = (objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'txtDuChRow');
                if (RestrictByMinHours != null) {
                    if (RestrictByMinHours.value == 1) {
                        if ((((objTextBox.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) - 0).toFixed(0) != ((objTextBox.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)) {
                            showAlert('Please enter hours complete in multiples of ' + <%=CommonFunctions.Application.MinHoursForDAEntry%>, 'alert-danger');
                            return false;
                        }
                    }
                }
                var taskParameters = {
                    intEmployeeID: EmployeeID,
                    dtFromDate: objEntryDate.value,
                    ProjectID: ProjectID,
                    TaskID: TaskID,
                    SubTaskTypeID: SubTaskTypeID,
                    Duration: objHoursComplete.value,
                    IsTaskComplete: IsTaskCompleteCheck
                }
                $.ajax({
                    url: strUrl + '/api/Timesheet/ValidateDA',
                    type: "POST",
                    data: JSON.stringify(taskParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (data) {
                        if (data != "") {
                            if (data.indexOf('$$') >= 0) {
                                var oldValue = objHoursComplete.value;
                                var arrValue = data.split('$$');
                                showAlert(arrValue[1], 'alert-danger');
                                objHoursComplete.value = oldValue - arrValue[0];
                                if (((oldValue - 0) - (arrValue[0] - 0)) < 0)
                                    objHoursComplete.value = '0.00';
                                return false;
                            }
                            else if (data.indexOf('@@') >= 0) {
                                objHoursComplete.value = "";
                                var arrValue = data.split('@@');
                                showAlert(arrValue[1], 'alert-danger');
                                if (arrValue[0] == 3 || arrValue[0] == 6 || arrValue[0] == 7) {
                                    if (objIsTaskComplete != null) {
                                        objIsTaskComplete.checked = false;
                                    }
                                }
                                return false;
                            }
                            else if (data.indexOf('##') >= 0) {
                                var arrValue = data.split('##');
                                if (arrValue[0] == 1) {
                                    showAlert(arrValue[1], 'alert-danger');
                                    return false;
                                }
                                else if (arrValue[0] == 0) {
                                    if (arguments.length == 1) {
                                        if (document.getElementById(objDuChRow).value == 0) {

                                            $("#ConfirmMessagemodalinfo").modal('show');
                                            $("#ConfirmationMsg").html(arrValue[1]);
                                        }
                                    }
                                }
                            }
                            else {
                                showAlert(data, 'alert-danger');
                                objHoursComplete.value = "";
                                return false;
                            }
                        }
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
            }
        }
        function SendConfirmationResponse(response) {
            var objDATextbox = document.getElementById(DATextbox);
            if (response == 0) {
                objDATextbox.value = "";
            }
            else {
                document.getElementById(objDuChRow).value = 1;
            }
        }
        function SaveDescription_OnClick(ProjectID, TaskID, SubTaskTypeID, k) {
            //debugger;
            var isValid = 0;
            if (isWeeklyView == 1) {
                var daParams = [];
                var objEntryDate = document.getElementById('Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + k);
                if (objEntryDate != null) {
                    objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + k);
                    objDAID = document.getElementById('DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + k);
                    objDescription = document.getElementById('Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + k);
                    txtDuChRow = document.getElementById('txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + k);
                    objIsTaskComplete = document.getElementById('IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                    var IsTaskCompleteCheck = 0;
                    if (objIsTaskComplete != null)
                        IsTaskCompleteCheck = objIsTaskComplete.checked;
                    if (Hours_OnChange(objDuration) == false) { isValid = 1; };
                    objWorkCompleted = document.getElementById('WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                    objResourceLevelTaskCompletion = document.getElementById('ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                    objStoryPoint = document.getElementById('StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + k);

                    var storypoint = 0;
                    if (objStoryPoint != null) {
                        if (StoryPoint_OnChange(objStoryPoint, 1) == false) { isValid = 1; };
                        storypoint = objStoryPoint.value;
                        if (objDuration.value == 0) {
                            showAlert('Please Enter Daily Activity', 'alert-danger');
                            //objDuration.focus();
                        }
                    }

                    if (objDuration.value != 0) {
                        daParams.push({
                            DailyActivityEntryID: objDAID.value,
                            TaskID: TaskID,
                            ProjectID: ProjectID,
                            EmployeeID: EmployeeID,
                            EntryDate: objEntryDate.value,
                            Duration: objDuration.value,
                            Description: objDescription.value,
                            SubTasktypeID: SubTaskTypeID,
                            IsDurationChange: txtDuChRow.value,
                            IsTaskComplete: IsTaskCompleteCheck,
                            ActualPercentComplete: objWorkCompleted.value,
                            bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                            StoryPoint: storypoint
                        });
                    }
                }
                console.log(daParams);
                if (isValid == 0) {
                    $.ajax({
                        url: strUrl + '/api/Timesheet/SaveDailyActivity',
                        type: "POST",
                        data: { '': daParams },
                        dataType: "json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                        },
                        success: function (data) {
                            if (data == 1) {
                                showAlert('Daily Activity entered successfully.', 'alert-success', 'btnSave');
                                ReloadData(EmployeeID);
                            }
                        },
                        error: function (err) {
                            console.log(err);
                        }
                    });
                }
            }
            else {
                var daParams = [];
                objEntryDate = document.getElementById('Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objDAID = document.getElementById('DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objDescription = document.getElementById('Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                txtDuChRow = document.getElementById('txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objIsTaskComplete = document.getElementById('IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                var IsTaskCompleteCheck = 0;
                if (objIsTaskComplete != null)
                    IsTaskCompleteCheck = objIsTaskComplete.checked;
                if (Hours_OnChange(objDuration) == false) { isValid = 1; };
                objWorkCompleted = document.getElementById('WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objResourceLevelTaskCompletion = document.getElementById('ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objStoryPoint = document.getElementById('StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);

                var storypoint = 0;
                if (objStoryPoint != null) {
                    if (StoryPoint_OnChange(objStoryPoint, 1) == false) { isValid = 1; };
                    storypoint = objStoryPoint.value;
                    if (objDuration.value == 0) {
                        showAlert('Please Enter Daily Activity', 'alert-danger');
                        ReloadData(EmployeeID);
                        //objDuration.focus();
                    }
                }


                if (objDuration.value != 0) {
                    daParams.push({
                        DailyActivityEntryID: objDAID.value,
                        TaskID: TaskID,
                        ProjectID: ProjectID,
                        EmployeeID: EmployeeID,
                        EntryDate: objEntryDate.value,
                        Duration: objDuration.value,
                        Description: objDescription.value,
                        SubTasktypeID: SubTaskTypeID,
                        IsDurationChange: txtDuChRow.value,
                        IsTaskComplete: IsTaskCompleteCheck,
                        ActualPercentComplete: objWorkCompleted.value,
                        bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                        StoryPoint: storypoint
                    });
                }
                console.log(daParams);
                if (isValid == 0) {
                    $.ajax({
                        url: strUrl + '/api/Timesheet/SaveDailyActivity',
                        type: "POST",
                        data: { '': daParams },
                        dataType: "json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                        },
                        success: function (data) {
                            if (data == 1) {
                                showAlert('Daily Activity entered successfully.', 'alert-success', 'btnSave');
                                plotDailyTaskList();
                            }
                        },
                        error: function (err) {
                            console.log(err);
                        }
                    });
                }
            }


        }
        var arrayWeekDays = [];
        function Save_OnClick() {
            // debugger;
            var isValid = 0;
            if ($('#CloseableAlert').css('display') == 'none') {
                if (isWeeklyView == 1) {
                    var daParams = [];
                    var hdnTaskData = document.getElementsByName("hdnTaskData");
                    for (var i = 0; i < hdnTaskData.length; i++) {
                        var arrTaskData = hdnTaskData[i].value.split("_");
                        var ProjectID = arrTaskData[0];
                        var TaskID = arrTaskData[1];
                        var SubTaskTypeID = arrTaskData[2];
                        var objEntryDate;
                        var objDuration;
                        var objDAID;
                        var objDescription;
                        var txtDuChRow;
                        var objIsTaskComplete;
                        var objWorkCompleted;
                        var objResourceLevelTaskCompletion;
                        var objStoryPoint;

                        arrayWeekDays = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];
                        for (var k = 0; k < arrayWeekDays.length; k++) {
                            objEntryDate = document.getElementById('Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                            if (objEntryDate != null) {
                                objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                objDAID = document.getElementById('DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                objDescription = document.getElementById('Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                txtDuChRow = document.getElementById('txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                objIsTaskComplete = document.getElementById('IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                                var IsTaskCompleteCheck = 0;
                                if (objIsTaskComplete != null)
                                    IsTaskCompleteCheck = objIsTaskComplete.checked;

                                if (objDuration.value != objDuration.defaultValue) {
                                    if (Hours_OnChange(objDuration, 1) == false) { isValid = 1; };
                                }
                                objWorkCompleted = document.getElementById('WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                                objResourceLevelTaskCompletion = document.getElementById('ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                                objStoryPoint = document.getElementById('StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));

                                var storypoint = 0;
                                if (objStoryPoint != null) {
                                    if (StoryPoint_OnChange(objStoryPoint, 1) == false) { isValid = 1; };
                                    storypoint = objStoryPoint.value;
                                    if (objDuration.value == 0) {
                                        showAlert('Please Enter Daily Activity', 'alert-danger');
                                        //objDuration.focus();
                                        isValid = 1;
                                    }
                                }

                                if (objDuration.value != 0) {
                                    daParams.push({
                                        DailyActivityEntryID: objDAID.value,
                                        TaskID: TaskID,
                                        ProjectID: ProjectID,
                                        EmployeeID: EmployeeID,
                                        EntryDate: objEntryDate.value,
                                        Duration: objDuration.value,
                                        Description: objDescription.value,
                                        SubTasktypeID: SubTaskTypeID,
                                        IsDurationChange: txtDuChRow.value,
                                        IsTaskComplete: IsTaskCompleteCheck,
                                        ActualPercentComplete: objWorkCompleted.value,
                                        bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                                        StoryPoint: storypoint
                                    });
                                }
                            }
                        }
                    }
                    console.log(daParams);
                    if (daParams.length == 0) {
                        showAlert('Please fill daily activity', 'alert-danger');
                        //objDuration.focus();
                        isValid = 1;
                    }
                    if (isValid == 0) {
                        StartLoader("#bodyTSEntry");
                        $.ajax({
                            url: strUrl + '/api/Timesheet/SaveDailyActivity',
                            type: "POST",
                            data: { '': daParams },
                            dataType: "json",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                            },
                            success: function (data) {
                                if (data == 1) {
                                    showAlert('Daily Activity entered successfully.', 'alert-success', 'btnSave');
                                    ReloadData(EmployeeID);
                                }
                            },
                            error: function (err) {
                                StopAjaxLoader("#bodyTSEntry");
                                console.log(err);
                            }
                        });
                    }
                }
                else {
                    var daParams = [];
                    var hdnTaskData = document.getElementsByName("hdnTaskDataDaily");
                    for (var i = 0; i < hdnTaskData.length; i++) {
                        var arrTaskData = hdnTaskData[i].value.split("_");
                        var ProjectID = arrTaskData[0];
                        var TaskID = arrTaskData[1];
                        var SubTaskTypeID = arrTaskData[2];
                        var objEntryDate;
                        var objDuration;
                        var objDAID;
                        var objDescription;
                        var txtDuChRow;
                        var objIsTaskComplete;
                        var objWorkCompleted;
                        var objResourceLevelTaskCompletion;
                        var objStoryPoint;

                        objEntryDate = document.getElementById('Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                        objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                        objDAID = document.getElementById('DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                        objDescription = document.getElementById('Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                        txtDuChRow = document.getElementById('txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                        objIsTaskComplete = document.getElementById('IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                        var IsTaskCompleteCheck = 0;
                        if (objIsTaskComplete != null)
                            IsTaskCompleteCheck = objIsTaskComplete.checked;
                        if (Hours_OnChange(objDuration, 1) == false) { isValid = 1; };
                        objWorkCompleted = document.getElementById('WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                        objResourceLevelTaskCompletion = document.getElementById('ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                        objStoryPoint = document.getElementById('StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);

                        var storypoint = 0;
                        if (objStoryPoint != null) {
                            if (StoryPoint_OnChange(objStoryPoint, 1) == false) { isValid = 1; };
                            storypoint = objStoryPoint.value;
                            if (objDuration.value == 0) {
                                showAlert('Please Enter Daily Activity', 'alert-danger');
                                //ReloadData(EmployeeID);
                                //objDuration.focus();
                                isValid = 1;
                            }
                        }


                        if (objDuration.value != 0) {
                            daParams.push({
                                DailyActivityEntryID: objDAID.value,
                                TaskID: TaskID,
                                ProjectID: ProjectID,
                                EmployeeID: EmployeeID,
                                EntryDate: objEntryDate.value,
                                Duration: objDuration.value,
                                Description: objDescription.value,
                                SubTasktypeID: SubTaskTypeID,
                                IsDurationChange: txtDuChRow.value,
                                IsTaskComplete: IsTaskCompleteCheck,
                                ActualPercentComplete: objWorkCompleted.value,
                                bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                                StoryPoint: storypoint
                            });
                        }
                    }
                    console.log(daParams);
                    if (daParams.length == 0) {
                        showAlert('Please fill daily activity', 'alert-danger');
                        //objDuration.focus();
                        isValid = 1;
                    }
                    if (isValid == 0) {
                        StartLoader("#bodyTSEntry");
                        $.ajax({
                            url: strUrl + '/api/Timesheet/SaveDailyActivity',
                            type: "POST",
                            data: { '': daParams },
                            dataType: "json",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                            },
                            success: function (data) {
                                if (data == 1) {
                                    showAlert('Daily Activity entered successfully.', 'alert-success', 'btnSave');
                                    plotDailyTaskList();
                                }
                            },
                            error: function (err) {
                                StopAjaxLoader("#bodyTSEntry");
                                console.log(err);
                            }
                        });
                    }
                }
            }
        }
        function ValidateCreateTask() {
            var objcboProject = document.getElementById("cboProject");
            var objtxtTaskName = document.getElementById("txtTaskName");
            var objcboTaskType = document.getElementById("cboTaskType");
            var objcboPriority = document.getElementById("cboPriority");
            var objtxtWorkHrs = document.getElementById("txtWorkHrs");
            var objtxtActualComplete = document.getElementById("txtActualComplete");
            var objtxtDescription = document.getElementById("txtDescription");
            var objCTselectdate = document.getElementById("CTselectdate");

            var taskParameters = {
                dtFromDate: objCTselectdate.value,
                ProjectID: objcboProject.value
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/ValidateCreateTask',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    if (data != "") {
                        showAlert(data, 'alert-danger');
                        return false;
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });

            if (objCTselectdate != null) {
                if (objCTselectdate.value == "") {
                    showAlert('Please select Date.', 'alert-danger');
                    objCTselectdate.focus();
                    return false;
                }
            }

            //Project Validation
            if (objcboProject != null) {
                if (objcboProject.value == "") {
                    showAlert('Please select Project.', 'alert-danger');
                    objcboProject.focus();
                    return false;
                }
            }

            if (objtxtTaskName != null) {
                if (objtxtTaskName.value == "") {
                    showAlert('Task Name can not left blank.', 'alert-danger');
                    objtxtTaskName.value = "";
                    objtxtTaskName.focus();
                    return false;
                }
            }
            if (objtxtTaskName != null) {
                if ((objtxtTaskName).length > 200) {
                    showAlert('Max length for Task Name is 200.', 'alert-danger');
                    objtxtTaskName.focus();
                    return false;
                }
            }
            //TaskType Validation
            if (objcboTaskType != null) {
                if (objcboTaskType.value == "") {
                    showAlert('Please select Task Type.', 'alert-danger');
                    objcboTaskType.focus();
                    return false;
                }
            }

            //Priority Validation
            if (objcboPriority != null) {
                if (objcboPriority.value == "") {
                    showAlert('Please select Priority.', 'alert-danger');
                    ObjPriority.focus();
                    return false;
                }
            }
            if (objtxtWorkHrs != null) {
                if (RestrictNonNumeric(objtxtWorkHrs) == true) {
                    showAlert('Please enter only positive numeric value!!!', 'alert-danger');
                    return false;
                }
                if ((objtxtWorkHrs.value - 0) >= 0 && (objtxtWorkHrs.value - 0) <= 24) {
                } else {
                    showAlert('Work should be in a range (0 - 24) Hours.', 'alert-danger');
                    return false;
                }

                if ((((objtxtWorkHrs.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) - 0).toFixed(0) != ((objtxtWorkHrs.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)) {
                    showAlert('Please specify the work (hours) in multiples of ' +<%=CommonFunctions.Application.MinHoursForDAEntry%>+' hours.\nThis is necessary because the user can only fill a minimum of ' +<%=CommonFunctions.Application.MinHoursForDAEntry%>+' hours in the timesheet.', 'alert-danger');
                    return false;
                }

                var taskParameters = {
                    ProjectID: objcboProject.value,
                    Duration: objtxtWorkHrs.value,
                    TaskName: objtxtTaskName.value
                }
                $.ajax({
                    url: strUrl + '/api/Timesheet/ValidateCreateTask_Work',
                    type: "POST",
                    data: JSON.stringify(taskParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (data) {
                        if (data != "") {
                            if (data.indexOf('$$') >= 0) {
                                var arrValue = data.split('$$');
                                if (arrValue[0] == "1") {
                                    $("#ConfirmMessageModalCreateTask").modal('show');
                                    $("#ConfirmationMsgCreateTask").html(arrValue[1]);
                                }
                            }
                            else {
                                showAlert(data, 'alert-danger');
                                return false;
                            }
                        }
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
            }
            if (objtxtActualComplete != null) {
                if (RestrictNonNumeric(objtxtActualComplete) == true) {
                    showAlert('Please enter only positive numeric value!!!', 'alert-danger');
                    return false;
                }
                if ((objtxtActualComplete.value - 0) >= 0 && (objtxtActualComplete.value - 0) <= 100) {
                } else {
                    showAlert('Actual Percent complete should be in a range (0 - 100) Hours.', 'alert-danger');
                    return false;
                }
            }
        }
        function CreateTask_Save_OnClick(flag) {
            var objcboProject = document.getElementById("cboProject");
            var objtxtTaskName = document.getElementById("txtTaskName");
            var objcboTaskType = document.getElementById("cboTaskType");
            var objcboSubTaskType = document.getElementById('cboSubTaskType');
            var objcboPriority = document.getElementById("cboPriority");
            var objtxtWorkHrs = document.getElementById("txtWorkHrs");
            var objtxtActualComplete = document.getElementById("txtActualComplete");
            var objtxtDescription = document.getElementById("txtDescription");
            var objCTselectdate = document.getElementById("CTselectdate");

            var chkFlag;
            chkFlag = ValidateCreateTask();
            if (chkFlag != false) {
                var taskParameters = {
                    intEmployeeID: EmployeeID,
                    ProjectID: objcboProject.value,
                    TaskName: objtxtTaskName.value,
                    Duration: objtxtWorkHrs.value,
                    FilterTaskTypeID: objcboTaskType.value,
                    SubTasktypeID: objcboSubTaskType.value,
                    CreatedBy: UserName,
                    dtFromDate: objCTselectdate.value,
                    PriorityID: objcboPriority.value,
                    ActualPercentComplete: objtxtActualComplete.value,
                    Description: objtxtDescription.value,
                    bitFlag: flag
                }
                $.ajax({
                    url: strUrl + '/api/Timesheet/SaveCreateTask',
                    type: "POST",
                    data: JSON.stringify(taskParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (data) {
                        if (data != '') {
                            if (flag == 1) {
                                showAlert('Task created and actual filled successfully.', 'alert-success');

                                //TaskIDList = data;
                                //IsDefault = 1;
                                if (isWeeklyView == 1)
                                    ReloadData(EmployeeID);
                                else
                                    plotDailyTaskList();
                                $("#createtaskmodal").modal('hide');
                            }
                            else if (flag == 2) {
                                showAlert('Task created and actual filled successfully.', 'alert-success');

                                TaskIDList = data;
                                IsDefault = 1;
                                if (isWeeklyView == 1)
                                    ReloadData(EmployeeID);
                                else
                                    plotDailyTaskList();

                                objCTselectdate.value = "";
                                objcboProject.value = "";
                                objtxtTaskName.value = "";
                                objcboTaskType.vale = "";
                                objcboSubTaskType.value = "";
                                objcboPriority.value = "";
                                objtxtWorkHrs.value = "";
                                objtxtActualComplete.value = "";
                                objtxtDescription.value = "";
                                $(".selectpicker").selectpicker('refresh');
                            }
                        }
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
            }
        }
        function SendConfirmationResponseForCreateTask(response) {
            var objCreateTaskWorkHrs = document.getElementById('txtWorkHrs');
            if (response == 0) {
                objCreateTaskWorkHrs.value = "";
            }
        }
        function QuickEntry_Click() {
            var objtxtQuickEntry;
            var quickflag = 0;
            var errorFlag = 0;
            if (isWeeklyView == 1) {
                objtxtQuickEntry = document.getElementById("txtQuickEntry");
            }
            else {
                objtxtQuickEntry = document.getElementById("txtQuickEntryDaily");
            }
            if (objtxtQuickEntry != null) {
                if (objtxtQuickEntry.value == "") {
                    showAlert('Please enter numeric value !', 'alert-danger');
                    objtxtQuickEntry.value = "";
                    objtxtQuickEntry.focus();
                    return false;
                }
                if (RestrictNonNumeric(objtxtQuickEntry) == true) {
                    showAlert('Please enter only positive numeric value!!!', 'alert-danger');
                    objtxtQuickEntry.value = "";
                    objtxtQuickEntry.focus();
                    return false;
                }
                if (objtxtQuickEntry.value < 0) {
                    showAlert('Only positive number allowed !', 'alert-danger');
                    objtxtQuickEntry.value = "";
                    objtxtQuickEntry.focus();
                    return false;
                }
                if ((((objtxtQuickEntry.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) - 0).toFixed(0) != ((objtxtQuickEntry.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)) {
                    showAlert("Please enter hours complete in multiples of " + <%=CommonFunctions.Application.MinHoursForDAEntry%>, "alert-danger");
                    objtxtQuickEntry.value = "";
                    objtxtQuickEntry.focus();
                    return false;
                }
                if ((objtxtQuickEntry.value - 0) > 24 || (objtxtQuickEntry.value - 0) < 0) {
                    showAlert("The Range of Actual Working Hours is [0.00 to 24.00]", "a;ert-danger");
                    objtxtQuickEntry.value = "";
                    objtxtQuickEntry.focus();
                    return false;
                }

                if (isWeeklyView == 1) {
                    var strTimesheetIDs;
                    strTimesheetIDs = $('input[name=chkQuickEntry]:checked').map(function () {
                        return this.id;
                    }).get().join(',');

                    if (strTimesheetIDs == "") {
                        showAlert('Please select atleast one task.', 'alert-danger');
                        return false;
                    }
                    var arrQuickCheck = strTimesheetIDs.split(",")

                    for (var i = 0; i < arrQuickCheck.length; i++) {
                        var arrTaskData = arrQuickCheck[i].split("_");
                        var ProjectID = arrTaskData[1];
                        var TaskID = arrTaskData[2];
                        var SubTaskTypeID = arrTaskData[3];

                        arrayWeekDays = ["mon", "tue", "wed", "thu", "fri"];
                        for (var k = 0; k < arrayWeekDays.length; k++) {
                            objEntryDate = document.getElementById('Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                            objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));

                            if (objDuration.value == "0") {
                                var taskParameters = {
                                    intEmployeeID: EmployeeID,
                                    dtFromDate: objEntryDate.value,
                                    ProjectID: ProjectID,
                                    TaskID: TaskID,
                                    SubTaskTypeID: SubTaskTypeID,
                                    Duration: objDuration.value,
                                    IsTaskComplete: 0
                                }
                                $.ajax({
                                    url: strUrl + '/api/Timesheet/ValidateDA',
                                    type: "POST",
                                    data: JSON.stringify(taskParameters),
                                    dataType: "json",
                                    async: false,
                                    contentType: "application/json;charset-utf=8",
                                    beforeSend: function (xhr) {
                                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                                    },
                                    success: function (data) {
                                        if (data == "") {
                                            objDuration.value = objtxtQuickEntry.value;
                                            if (quickflag == 0)
                                                quickflag = 1;
                                        }
                                        else {
                                            errorFlag = 1;
                                        }
                                    },
                                    error: function (err) {
                                        console.log(err);
                                    }
                                });
                            }
                        }
                    }
                }
                else {
                    var strTimesheetIDs;
                    strTimesheetIDs = $('input[name=chkQuickEntryDaily]:checked').map(function () {
                        return this.id;
                    }).get().join(',');

                    if (strTimesheetIDs == "") {
                        showAlert('Please select atleast one task.', 'alert-danger');
                        return false;
                    }

                    var arrQuickCheck = strTimesheetIDs.split(",")

                    for (var i = 0; i < arrQuickCheck.length; i++) {
                        var arrTaskData = arrQuickCheck[i].split("_");
                        var ProjectID = arrTaskData[1];
                        var TaskID = arrTaskData[2];
                        var SubTaskTypeID = arrTaskData[3];

                        objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);

                        if (objDuration.value == "0") {
                            var taskParameters = {
                                intEmployeeID: EmployeeID,
                                dtFromDate: objEntryDate.value,
                                ProjectID: ProjectID,
                                TaskID: TaskID,
                                SubTaskTypeID: SubTaskTypeID,
                                Duration: objDuration.value,
                                IsTaskComplete: 0
                            }
                            $.ajax({
                                url: strUrl + '/api/Timesheet/ValidateDA',
                                type: "POST",
                                data: JSON.stringify(taskParameters),
                                dataType: "json",
                                contentType: "application/json;charset-utf=8",
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                                },
                                success: function (data) {
                                    if (data == "") {
                                        objDuration.value = objtxtQuickEntry.value;
                                        if (quickflag == 0)
                                            quickflag = 1;
                                    }
                                    else {
                                        errorFlag = 1;
                                    }
                                },
                                error: function (err) {
                                    console.log(err);
                                }
                            });
                        }
                    }
                }

                if (errorFlag == 1) {
                    showAlert('Some of the days are not allowed to fill DA for task.', 'alert-danger');
                }
                if (quickflag == 1) {
                    Save_OnClick();
                }

            }
        }
        var SubTaskTypeList = "";
        function SelectSubTask_OnClick() {
            TaskIDList = document.getElementById("hdnTaskForSubTask").value;

            var SubTaskList = document.getElementsByName("chkSubTask");
            for (var i = 0; i < SubTaskList.length; i++) {
                if (SubTaskList[i].checked == true) {
                    if (SubTaskTypeList == "") {
                        SubTaskTypeList += SubTaskList[i].value;
                    }
                    else {
                        SubTaskTypeList += ',' + SubTaskList[i].value;
                    }
                }
            }

            IsDefault = 1;
            if (isWeeklyView == 1)
                ReloadData(EmployeeID);
            else
                plotDailyTaskList();
            $("#selectsubtask").modal('hide');
        }
        function ApprovePopup(btn, TaskID, TaskName) {
            // debugger;
            $("#approvetaskbtnmodal").modal('show');
            $("#txtApprovalComment").val("");
            $("#divTaskBlock").css("display", "block");
            $("#divTaskName").text(unescape(TaskName));
            var TaskCompleteChecked = 0;
            if (jQuery(btn).closest('tr').find('[type=checkbox]').is(":checked")) { TaskCompleteChecked = 1; };
            document.getElementById("btnApproveTimesheet").setAttribute("onClick", "ApproveRejectTask(" + TaskID + ",'V'," + TaskCompleteChecked + ");");

            //ApproveRejectTask(TaskID,'V')
        }
        function RejectPopup(btn, TaskID, TaskName) {
            $("#rejecttaskmodal").modal('show');
            $("#txtRejectionComment").val("");
            $("#lblEmployeeName").css('display', 'none');
            $("#lblRejectTaskEmployeeName").css('display', 'block');
            var TaskCompleteChecked = 0;
            if (jQuery(btn).closest('tr').find('[type=checkbox]').is(":checked")) { TaskCompleteChecked = 1; };
            document.getElementById("btnRejectTimesheet").setAttribute("onClick", "ApproveRejectTask(" + TaskID + ",'J'," + TaskCompleteChecked + ");");


        }
        function ApproveTimesheet() {

            $("#approvetaskbtnmodal").modal('show');
            $("#txtApprovalComment").val("");
            $("#divTaskBlock").css("display", "none");
            document.getElementById("btnApproveTimesheet").setAttribute("onClick", "ApproveAllTimesheet();");


        }
        function RejectTimesheet() {
            $("#rejecttaskmodal").modal('show');
            $("#txtRejectionComment").val("");
            $("#lblEmployeeName").css('display', 'block');
            $("#lblRejectTaskEmployeeName").css('display', 'none');
            document.getElementById("btnRejectTimesheet").setAttribute("onClick", "RejectAllTimesheet();");
        }
        function ApproveRejectTask(TaskID, strStatus, TaskCompleteChecked) {
            // alert(TaskCompleteChecked);
            var strComment = "";
            var bitAllowToResubmit = 0;

            if (strStatus == "V") {
                strComment = $("#txtApprovalComment").val();
            }
            else if (strStatus == "J") {
                strComment = $("#txtRejectionComment").val();
                bitAllowToResubmit = ($("#rejecttaskmodalcheckbox").is(':checked') ? 1 : 0);
                if (bitAllowToResubmit == 1) { TaskCompleteChecked = 0; }
            }

            var taskParameters = {
                intTimesheetID:  '<%= Request.QueryString("intTimesheetId")%>',
                Status: strStatus,
                intEmployeeID: EmployeeID,
                strComment: strComment,
                intTaskID: TaskID,
                intAllowToResubmit: bitAllowToResubmit,
                TaskCompleteChecked: TaskCompleteChecked,
            }
            $.ajax({
                url: strUrl + '/api/TimesheetApprovalDetail/SaveApproveRejectTask',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    //alert("Success")
                    if (strStatus == "V") { $("#approvetaskbtnmodal").modal('hide'); }
                    else { $("#rejecttaskmodal").modal('hide'); }
                    ReloadTApprovalData(EmployeeID);
                },
                error: function (err) {
                    console.log(err);
                    alert("Error")
                }
            })
        }

        function ApproveAllTimesheet() {
            var strComment = "";
            strComment = $("#txtApprovalComment").val();
            var taskParameters = {
                intTimesheetID:  '<%= Request.QueryString("intTimesheetId")%>',
                Status: 'V',
                intEmployeeID: EmployeeID,
                strComment: strComment,
                intResourceID:'<%= Request.QueryString("intEmployeeID")%>',
            }
            $.ajax({
                url: strUrl + '/api/TimesheetApproval/PostTimesheetData',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    // alert("success")
                    UpdateCompleteTasks();
                    if (data == 1) {
                        window.open('../Email/SendEmail.aspx?MessageID=435&VerifiedBy=' + EmployeeID + '&ResourceID=' + '<%= Request.QueryString("intEmployeeID")%>' + '&FromDate=' + '<%= Request.QueryString("FromDate")%>' + '&ToDate=' + '<%= Request.QueryString("ToDate")%>' + '&TimesheetID=' + '<%= Request.QueryString("intTimesheetId")%>' + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=580');
                    }
                    $("#approvetaskbtnmodal").modal('hide');
                    ReloadTApprovalData(EmployeeID);
                },
                error: function (err) {
                    console.log(err);
                    alert("Error")
                }
            })
        }
        function UpdateCompleteTasks() {
            // debugger;
            var TaskList = [];
            $.each($("input[name='IsTaskComplete']:checked"), function () {
                var TaskID = $(this).val();
                //TaskList +=""+ TaskID +","
                TaskList.push(TaskID);
                //CheckedTimesheetIDs.push(Tid);
            });
            if (TaskList != "") {
                var taskParameters = {
                    TaskList: TaskList.toString(),
                }
                $.ajax({
                    url: strUrl + '/api/TimesheetApprovalDetail/UpdateTaskCompleted',
                    type: "POST",
                    data: JSON.stringify(taskParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (data) {
                        //alert("Success")
                    },
                    error: function (err) {
                        console.log(err);
                        alert("Error")
                    }
                })
            }


        }
        function RejectAllTimesheet() {
            //debugger;
            var strComment = "";
            strComment = $("#txtRejectionComment").val();
            var bitAllowToResubmit = ($("#rejecttaskmodalcheckbox").is(':checked') ? 1 : 0);
            var taskParameters = {
                intTimesheetID:  '<%= Request.QueryString("intTimesheetId")%>',
                Status: 'J',
                intEmployeeID: EmployeeID,
                strComment: strComment,
                intAllowToResubmit: bitAllowToResubmit,
                intResourceID:'<%= Request.QueryString("intEmployeeID")%>',
            }
            $.ajax({
                url: strUrl + '/api/TimesheetApproval/PostTimesheetData',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    if (bitAllowToResubmit == 0) { UpdateCompleteTasks(); }
                    if (data == 1) {
                        window.open('../Email/SendEmail.aspx?MessageID=436&VerifiedBy=' + EmployeeID + '&ResourceID=' + '<%= Request.QueryString("intEmployeeID")%>' + '&FromDate=' + '<%= Request.QueryString("FromDate")%>' + '&ToDate=' + '<%= Request.QueryString("ToDate")%>' + '&TimesheetID=' + '<%= Request.QueryString("intTimesheetId")%>' + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=580');

                    }
                    $("#rejecttaskmodal").modal('hide');
                    ReloadTApprovalData(EmployeeID);
                },
                error: function (err) {
                    console.log(err);
                    alert("Error")
                }
            })
        }

        function Export_PDFClick(ReportFormat) {

            if (PageFlag == 3) {
                var parameters = {
                    ReportFormat: ReportFormat,
                    intTimesheetID: '<%= Request.QueryString("intTimesheetId")%>'
                }
            }
            if (PageFlag == 2) {
                var parameters = {
                    ReportFormat: ReportFormat,
                    intEmployeeID: EmployeeID,
                    dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                    dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                }
            }
            $.ajax({
                url: strUrl + '/api/TimesheetApprovalDetail/ExportDocument',
                type: "POST",
                data: JSON.stringify(parameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    console.log(data);
                    //alert("Success");
                    window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + data, "_report", "");
                },
                error: function (err) {
                    console.log(err);
                    //alert("Error");
                }
            })
        }
        function ValidateSubmitTS() {
            var taskparameters = {
                employeeID: EmployeeID,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
            }
            $.ajax({
                url: strUrl + '/api/MyTimesheet/ValidateTimesheet',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    console.log(data);
                    if (data == "") {
                    }
                    else {
                        showAlert(data, 'alert-danger');
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            })
        }
        function SubmitTS_OnClick() {
            ValidateSubmitTS();
            var taskparameters = {
                employeeID: EmployeeID,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                intTimesheetID: 0,
                StatusCode: "R",
            }
            $.ajax({
                url: strUrl + '/api/MyTimesheet/GenerateTimesheet',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    //debugger;
                    var arrData = data.split('$');
                    if (arrData[0] == 1) {
                        window.open('../Email/SendEmail.aspx?MessageID=434&TimesheetID=' + arrData[1] + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    }
                    ReloadTApprovalData(EmployeeID);
                },
                error: function (err) {
                    console.log(err);
                }
            })
        }
    </script>

    <!--freezetbl_header_in_modalpopupbox-->
    <script type="text/javascript" src="../../../Whizible2.0/dist/js/jquery.freezeheader.js"></script>





</body>

</html>
