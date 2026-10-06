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
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/jquery-ui.css?v=2">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap.min.css?v=2">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap-select.css?v=2">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0/fontawesome/css/all.css?v=2">
    <!-- bootstrap datepicker -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/bootstrap-datepicker.min.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/AdminLTE.min.css?v=2">
    <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/skins/_all-skins.min.css?v=2">
    <!-- custom scrollbar -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/jquery.mCustomScrollbar.css?v=2">

    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/animate.css?v=2">
    <!-- sticky table -->
    <link href='../../../Whizible2.0/dist/css/table-fixed-header.css?v=2' rel='stylesheet'>
    <!-- Landing page stylesheet -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/landing.css">

    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom.css?v=9.5">

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/media_queries.css?v=6">






    <!--<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700" rel="stylesheet">-->
    <style type="text/css">
        /*body{ overflow: hidden; }*/
         /*Added by Yasmin for Task name content 21-05-19*/
      .tooltip >.tooltip-inner{
       
         word-wrap: break-word;
         -ms-hyphens:auto;
         word-break:keep-all;
         hyphens:auto;
          
        }
      
        /*.tasktooltip + .tooltip > .tooltip-inner {background-color: #f00;}*/
        .subtasklist .subtask[data-toggle="tooltip"]+.tooltip{
            background-color: green!important;

        }
        .timesheettable .tbl-content {
            height: auto;
        }

        .bootstrap-select > .dropdown-toggle:focus {
            border-color: #3c8dbc !important;
        }

        .ClsNodata {
            background-color: white !important;
            border: none !important;
            color: black !important;
            text-align: center !important;
        }


        /*Added_by_pradip_21_06_2019_for_Timesheet_landing_modal_popup*/
div#landingpgmodal { right: 0;margin: 0 auto;padding: 0;width:100%;}
div#landingpgmodal .modal-dialog {width: 90%;margin: 30px auto;}
.TL_treecirclecolumn {margin-top: 0;}
.TL_treecirclecolumn.TL_treecirclecolumnBrown.Tl_treecolumOdd {margin-top: 11.5em;}
.TL_treecirclecolumn.Tl_treecolumOdd {margin-top: 11.5em;}
div#landingpgmodal .modal-content .modal-body {padding: 15px;}

/*Added_by_pradip_21_06_2019*/



        @media only screen and (max-width:3400px) and (min-width:1921px) {
            table#clone {
                width: 98.8% !important;
            }
        }

        

        @media only screen and (max-width:1920px) and (min-width:1400px) {
            table#clone {
                width: 98.3% !important;
            }
        }
        /*.exapnd_and_collaps_column .tooltip-inner{
           font-size:11px;
           padding:5px;
       }*/

/*added by pradip on 03-04-2020*/
        .weeklyanddaily { width:230px;}
        button#landingpginfobtn {margin-top: 6px;}


         /*.ui-datepicker-current-day a { background:#ccc!important;}
        .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover { background:#007fff!important;
        }
        .ui-datepicker-days-cell-over{ background:none!important;}*/
        .entryselectpro_selectfield .tooltip{ display:none!important;}/*added by pradip on 23-03-2020*/

        html body table tr td.ui-datepicker-current-day, html body table tr td.ui-datepicker-current-day a.ui-state-default {background: #ccc;}
        a.ui-state-default.ui-priority-secondary{ opacity:0.6;}
        html body table tr td.ui-datepicker-current-day a.ui-state-default.ui-priority-secondary { background:#fafafa;}

        .tbl-projecttitle{ padding-left:26px;}
        .tbl-projecttitle > img{ position:absolute; left:0;}
       /*Added By Dipali V On 5th  March 2021 Css for Note */
        
        .ClsNote {
            float: right;
            font-size: 10px;
            color: red;
            margin-top: 2px;
        }
           /*End of Added By Dipali V On 5th  March 2021 Css for Note */

           /*Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings*/
           .clsHide
           {
               display:none!important;
           }
        .clsLI {
            list-style-type: inherit;
            font-size: 12px;
        }

 #allowoverridenote {
            font-weight:400!important;
        }
         #allowoverridenote span {
            font-weight:400!important;
            font-size:12px!important;
               
        }
           /*End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings*/
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
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboProxyResource", "usp_Whizible2_Sel_tbl_CNF_ProxyUser_Mapping_Detail " & Session("intUserID").ToString,,, "class='form-control selectpicker' onChange='javascript:ChangeProxyUser(this.value)'",,, ) %>
                    </div>
                    <div class="col-md-3 col-sm-3 col-xs-6" id="DivSelectedResource" style="display: none;">
                        <label class="resourcelabel pt-1"></label>
                    </div>

                    <div class="col-md-5 col-sm-5 col-xs-6">
                        <div class="weekly_calender" id="weeklyviewcal">

                            <button data-toggle="tooltip" data-placement="bottom" title="Previous Week" id="prev"><i class="fas fa-caret-left"></i></button>
                            <div class="input-group-box">
                                <div class="input-group" id="DateDemo">
                                    <input data-toggle="tooltip" data-placement="bottom" title="Select week date" class="form-control" type="text" id="weekPicker2" autocomplete="off" />
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
                    <!--modified by pradip on 03-04-2020-->
                    <div class="col-md-4 col-sm-4 col-xs-12 text-right" id="DivTEFilterSection" style="display: none;">
                        <div class="weeklyanddaily pull-right">

                            <div class="tab-slider--nav">
                                <ul class="tab-slider--tabs">
                                    <li class="tab-slider--trigger active" rel="Weeklytab" data-toggle="tooltip" data-placement="bottom" title="Weekly Task View" onclick="changeView(1)"><span>Weekly</span></li>
                                    <li data-toggle="tooltip" data-placement="bottom" title="Daily Task View" class="tab-slider--trigger" onclick="changeView(0)" rel="Dailytab">Daily</li>
                                </ul>
                            </div>
                            <button id="landingpginfobtn" class="nostyle" data-toggle="modal"  data-target="#landingpgmodal"><img class=" pull-right" src="../../../Whizible2.0/dist/img/exclaim.svg" width="16px" alt="" data-toggle="tooltip" data-placement="bottom" title="Click here to View Info"> </button>
                            <div class="filter pull-right">
                                <button data-toggle="collapse" data-target="#filterpanel" data-placement="bottom" title="Advanced Filter" id="AdvanceFilterIcon"><i class="fas fa-filter"></i></button>
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
                   <%--/*Added By Dipali V On 5th  March 2021 Css for Note */--%>
                <%--<span class="ClsNote">Note :- Task without daily activity cannot be closed by user</span>--%>
            
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
                                <a href="#" id="" class="btn borderbtn ml-1 nobtnstyle-xs editviewtimesheet" onclick="ShowEditMode()">Edit</a>

                                <a href="#" id="btnSaveVT" onclick="Save_VTOnClick()" class="btn savebtn btnyellow ml-1 nobtnstyle-xs viewtimesheetsavetbtn hidebtn">Save</a>

                            </li>
                            <li>
                                <button id="btnSubmit" class="btn savebtn btnyellow ml-1 nobtnstyle-xs" style="display: none;" onclick="SubmitTS_OnClick()">Submit</button>
                            </li>
                        </ul>
                        <ul class="pull-right btnlistinline" id="ulVTSave" style="display: none">
                            <li>
                                <a href="#" id="" class="btn borderbtn ml-1 nobtnstyle-xs editviewtimesheet" style="display: none;">Edit</a>
                                <a onclick="goBack()" id="" class="btn backbtn btnyellow ml-1 nobtnstyle-xs hidebtn" style="display: inline;">Back</a>
                                <a href="#" id="btnSaveVT" onclick="Save_VTOnClick()" class="btn savebtn btnyellow ml-1 nobtnstyle-xs viewtimesheetsavetbtn hidebtn" style="display: inline-block;">Save</a>

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
                                    <input data-toggle="tooltip" data-placement="bottom" title="Select week date" class="form-control" type="text" id="weekPicker2" autocomplete="off" />
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

                                <div id="Filterproject" class="selectpicker autocompletepicker">

                                    <div class="pfbox" style="display: block;">
                                        <div class="live-filtering" data-autocomplete="true">
                                            <label class="sr-only" for="input-bts-ex-6">Search</label>
                                            <div class="search-box">
                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <span class="fa fa-search"></span>
                                                        <a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Clear filter</span></a>
                                                    </span>
                                                    <input type="text" placeholder="Search" id="txtSearchBoxProjectNames" name="txtSearchBox" class="form-control live-search" tabindex="1" />
                                                </div>
                                            </div>
                                            <div class="list-to-filter">
                                                <ul class="list-unstyled">
                                                    <li class="optgroup">
                                                        <span class="optgroup-header"></span>
                                                        <ul class="list-unstyled fplist" id="ProjectFilterList">
                                                        </ul>
                                                    </li>
                                                </ul>
                                                <%--    <div class="no-search-results" style="display: none!important">
                                                    <div style="display: none" id="txtSearchBoxProjectNamesNoSearch" class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>No entry for <strong>'<span></span>'</strong> was found.</div>
                                                </div>--%>
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

                                <div id="Filtertasktype" class="selectpicker autocompletepicker">

                                    <div class="dropdown-menu" style="display: block;">
                                        <div class="live-filtering" data-autocomplete="true">
                                            <label class="sr-only" for="input-bts-ex-6">Search</label>
                                            <div class="search-box">
                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <span class="fa fa-search"></span>
                                                        <a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Clear filter</span></a>
                                                    </span>
                                                    <input type="text" placeholder="Search" id="txtSearchBoxTaskTypes" name="txtSearchBox" class="form-control" tabindex="1" />
                                                </div>
                                            </div>
                                            <div class="list-to-filter">
                                                <ul class="list-unstyled">
                                                    <li class="optgroup">
                                                        <span class="optgroup-header">
                                                            <%--<input class="checkbox checkAll" type="checkbox">All <span class="subtext"></span>--%>

                                                        </span>
                                                        <ul class="list-unstyled fplist" id="TaskTypeFilterList">
                                                        </ul>
                                                    </li>
                                                </ul>
                                                <%--<div class="no-search-results">
                                                    <div style="display: none" id="txtSearchBoxTaskTypesNoSearch" class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>No entry for <strong>'<span></span>'</strong> was found.</div>
                                                </div>--%>
                                                <%--<div style="display:none;" id="txtSearchBoxTaskTypesNoSearch" class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>No entry for <strong>'<span></span>'</strong> was found.</div>--%>
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
                                <div id="lblTaskPhaseFilterList" class="fplist_title">Phase</div>
                                <ul class="fplist" id="TaskPhaseFilterList">
                                </ul>
                            </div>
                        </div>

                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div id="lblTaskMilestoneFilterList" class="fplist_title">Milestone</div>
                                <ul class="fplist" id="TaskMilestoneFilterList">
                                </ul>
                            </div>
                        </div>

                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div id="lblTaskDeliverableFilterList" class="fplist_title">Deliverable</div>
                                <ul class="fplist" id="TaskDeliverableFilterList">
                                </ul>
                            </div>
                        </div>

                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div id="lblTaskSubProjectFilterList" class="fplist_title">Sub Project</div>
                                <ul class="fplist" id="TaskSubProjectFilterList">
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="fplistbox">
                                <div id="lblTaskModuleFilterList" class="fplist_title">Module</div>
                                <ul class="fplist" id="TaskModuleFilterList">
                                </ul>
                            </div>
                        </div>

                        <div class="clearfix"></div>
                    </div>

                    <div class="fp_button text-center hidden-xs">
                        <a href="#" class="uncheckbtn btn borderbtn" onclick="ClearFilterTextBoxes()" data-toggle="collapse" data-target="#filterpanel">Cancel</a>
                        <a href="#" class="btn borderbtn active" data-toggle="modal" onclick="GetFilterResultCount();ClearFilterTextBoxes()">Apply</a>
                    </div>

                </div>
            </div>
            <!--filter panel end here-->

            <div id="DivDailyFilterPanel" class="timesheetrow container-fluid bgwhite ts_headerbot" style="display: none;">
                              <div class="row">
                    <!--modified by pradip on 14-10-2020-->
                    <div class="col-sm-4 pull-right">
                          <span class="ClsNote">Note :- 01) Task without daily activity cannot be closed by user <br />
                              <%--Commented & Added By Dipali V On 13th Jan 2021 For Rephrase Alert--%>
                              <%--02) Weekly total will display more/Different, if already  effort is captured which May be Inactive or blocked.--%>
                               02) Weekly total will display more/different,if already effort is captured for the task which May be Inactive or project is blocked.
                              <%--End of Commented & Added By Dipali V On 13th Jan 2021 For Rephrase Alert--%>
                          </span>
            
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
                    <div class="col-sm-8 pr-0 ">
                        <ul class="statustext hidden-xs">
                            <li onclick='TaskCounterOnClick(this,"Critical")' id="CriticalTaskCounter" data-toggle="tooltip" data-placement="bottom" data-container="body" title="All mpp tasks marked as critical task will be displayed" class="criticle"><a href="#"><span class="statustextno" id="CriticalTask"></span>Critical Task</a></li>
                            <li onclick='TaskCounterOnClick(this,"Pending")' id="PendingTaskCounter" data-toggle="tooltip" data-placement="bottom" data-container="body" title="All the assigned tasks which are not completed will be displayed" class="overdue"><a href="#"><span class="statustextno" id="PendingTask"></span>Pending Task</a></li>
                            <li onclick='TaskCounterOnClick(this,"Slippage")' id="SlippageTaskCounter" data-toggle="tooltip" data-placement="bottom" data-container="body" title="This displays tasks slipping by efforts, not started as per start date, and not completed as per end date" class="pending"><a href="#"><span class="statustextno" id="SlippingTask"></span>Slipping Task</a></li>
                            <li onclick='TaskCounterOnClick(this,"Schedule")' id="ScheduleTaskCounter" data-toggle="tooltip" data-placement="bottom" data-container="body" title="Scheduled Task" class="schedule"><a href="#"><span class="statustextno" id="ScheduledTask"></span>Scheduled</a></li>
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
                                <a onclick="goBackToApprovalPage()" id="" class="btn backbtn btnyellow ml-1 nobtnstyle-xs hidebtn" style="display: inline;">Back</a>
                            </li>
                            <li>
                                <button id="btnRejectT" onclick="RejectTimesheet()" class="btn borderbtn ml-1 nobtnstyle-xs" data-target="#rejectmodal">Reject</button>
                            </li>
                            <li>
                                <button id="btnApproveT" data-toggle="modal" onclick="ApproveTimesheet()" class="btn savebtn btnyellow ml-1 nobtnstyle-xs">Approve</button>
                            </li>
                            <li>
                                <a onclick="goNextToApprovalPage()" id="btnNext" class="btn backbtn btnyellow ml-1 nobtnstyle-xs hidebtn" style="display: inline;">Next</a>
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
                <button type="button" onclick="CloseShowAlert()" class="close">×</button>
                <p id="alertMsg"></p>
            </div>
            <!--bootstrap_Alertify-->

            <div id="Weeklytab" class="tab-slider--body">

                <div class="table-outer">
                    <div class="timesheettable">
                        <div class="tbl-content" id="table-container">
                            <table id="tableheadfixer" class="table table-hover table-bordered table-fixed-header approvaldetailtble">
                                <thead class='header' id="timesheetHeader">
                                </thead>

                                <tbody id="timesheetBody">
                                </tbody>
                            </table>
                            <div id="bottom_anchor"></div>

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

             <!--modalstart-->
                     <div id="landingpgmodal" class="modal fade custmodal modal-lg" role="dialog">
                        <div class="modal-dialog">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Timesheet Info</h4>
                                </div>
                                <div class="modal-body">
 <!-- Main content -->
            <section class="content TLmain graybg">

               <div class="landingpg_wrapper">

                   <div class="tl_wrap">  
                   <!--task list start-->                 
                       <div class="TL_treecirclecolumn first">
                         <ul class="TL_treelist">
                        <li><span>Tasks,Sub tasks<br/>by Project</span></li>
                        <li><span>Pending,Critical,Slipping<br/>Planned & Unplanned</span></li>
                        <li><span>Switch between<br/>Weekly/Daily views</span></li>
                        </ul>

                           <div class="TL_treecirclebox TL_treecircleboxRed">
                            <div class="TL_treecircleboxinner"><p class="tl_circletitle">Task List<span>&nbsp;</span></p></div>
                           </div>
                           <div class="clearfix"></div>
                       </div><!--task list end-->                 

                            <!--Time Entry start-->   
                       <div class="TL_treecirclecolumn TL_treecirclecolumnBrown Tl_treecolumOdd">                        
                           <div class="TL_treecirclebox TL_treecircleboxBrown">
                            <div class="TL_treecircleboxinner"><p class="tl_circletitle">Time Entry</p></div>
                           </div>
                           <ul class="TL_treelist ">
                        <li><span>Navigate Previous<br/>and Current</span></li>
                        <li><span>Use Advanced filters<br/>Category,Status,Priority</span></li>
                        <li><span>List all Task or<br/>based on categories</span></li>
                        </ul>
                           <div class="clearfix"></div>
                       </div> <!--Time entry end-->   


<!--Monitor start-->   
<div class="TL_treecirclecolumn TL_treecirclecolumnLightyellow">
                        <ul class="TL_treelist">
                        <li><span>Quick Entry on<br/>Multiple tasks</span></li>
                        <li><span>Enter detail description<br/>on task progress</span></li>
                        <li><span>Enter Completion on<br/>each task</span></li>
                        <li><span>Submit Weekly <br/>Timesheet for approval</span></li>
                        </ul>

                           <div class="TL_treecirclebox TL_treecircleboxLightyellow">
                            <div class="TL_treecircleboxinner"><p class="tl_circletitle">Monitor<span>&nbsp;</span></p></div>
                           </div>
                           <div class="clearfix"></div>
                       </div> <!--Monitor end-->   

<!--Curate start-->   
                       <div class="TL_treecirclecolumn TL_treecirclecolumnGreen Tl_treecolumOdd">
                         <div class="TL_treecirclebox TL_treecircleboxGreen">
                            <div class="TL_treecircleboxinner"><p class="tl_circletitle">Curate<span>&nbsp;</span></p></div>
                           </div>
                           <ul class="TL_treelist">
                        <li><span>View actual time<br/>already spent on tasks</span></li>
                        <li><span>View planned<br/>dates on tasks</span></li>
                        <li><span>View Pending,Critical<br/>Slipping tasks</span></li>
                        <li><span>Approve<br/>Submitted Timesheet</span></li>
                        </ul>
                           <div class="clearfix"></div>
                       </div> <!--Curate End--> 

<!--Analyse start--> 
                       <%--<div class="TL_treecirclecolumn TL_treecirclecolumnLightblue last">
                          <ul class="TL_treelist">
                        <li><span>Get task details for you<br/>from all source</span></li>
                        <li><span>Get task details for you<br/>from all source</span></li>
                        <li><span>Get task details for you<br/>from all source</span></li>
                        </ul>
                           <div class="TL_treecirclebox TL_treecircleboxLightblue">
                            <div class="TL_treecircleboxinner"><p class="tl_circletitle">Analyse<span>&nbsp;</span></p></div>
                           </div>
                          
                           <div class="clearfix"></div>
                       </div>--%>
                        <!--Analyse end--> 

<div class="clearfix"></div>
                   </div>
               </div>

            </section>
                 </div>
                                
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <!--modalEnd-->




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
            <!--deletmodal-->
            <div id="deleteinfomodal" class="modal fade custmodal" role="dialog">
                <div class="modal-dialog modalsmall">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Delete</h4>
                        </div>

                        <div class="modal-body">
                            <p align="center">Are you sure you want to delete Schedule Time Entry?</p>

                            <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-left">
                                        <button class="btn borderbtn ml-1" data-dismiss="modal">No</button>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 pull-right" onclick="DeleteData()">Yes</button>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--deletmodalend-->

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
                                                        <small class="mandatorymsg" style="margin-left: 10px!important;">* If Future date is selected as task completion date then it may impact all the reports in the Whizible</small>
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
                                                            <input class="form-control" type="text" id="txtTaskName" value="" placeholder="Enter Task Name" onkeyup="limitText(this,255)" maxlength="255" name="">
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
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_Whizible2_Sel_tbl_IB_Priorities 1",,, "class='form-control selectpicker'", ,, ) %>
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
                                                            <input class="hrss form-control" type="text" value="" maxlength="5" id="txtWorkHrs" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name="">
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
                                                            <input class="form-control" type="text" id="txtActualComplete" value="" placeholder="Enter Completion Percentage" name="">
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
                                                            <textarea class="form-control" id="txtDescription" maxlength="2000" placeholder="Enter Description" onkeyup="limitText(this,2000)"></textarea>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group mt-4">
                                            <div class="row">
                                                <div class="col-xs-6 col-sm-6 text-left">
                                                     <%--//Commented and Added by Chetan M on 04th Aug 2020 for All E Tech Issue ID = 25712--%>
                                                    <%--<button class="btn borderbtn ml-1" data-dismiss="modal">Cancel</button>--%>
                                                    <button class="btn borderbtn ml-1 close1" data-dismiss="modal">Cancel</button>
                                                    <%--//End of Commented and Added by Chetan M on 04th Aug 2020 for All E Tech Issue ID = 25712--%>
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
                            <button type="button" class="close" data-dismiss="modal" onclick="ClearallData()">&times;</button>
                            <h4 class="modal-title">Select Project / Task</h4>
                        </div>

                        <div class="modal_task_hader graybg">
                            <div class="row">
                                <div class="col-sm-6 col-md-6">
                                    <div class="row">
                                        <label class="col-xs-3">Project :</label>
                                        <div class="col-xs-9 entryselectpro_selectfield">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboFilteredProject", "Select '' ",,, "class='form-control selectpicker' onChange='javascript:ProjectFilterDrop_OnChange(this.value);'",,, ) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-5 col-md-5">
                                    <div class="modalhead_projectid" id="ProjectCode"></div>
                                    <div class="modalheader_startandenddate" id="startdateandenddate">
                                    </div>
                                </div>

                                <div class="col-sm-1 col-md-1">
                                    <i data-toggle="collapse" data-target="#modaltaskfilte" data-placement="top" title="Filter" class="fas fa-filter modalheadtaskfilter"></i>

                                    <div id="modaltaskfilte" class="collapse tblfiltering">
                                        <div class="dropdown-menu" style="display: block;" id="divTaskCategories">
                                            <div class="" data-autocomplete="true">
                                                <label class="sr-only" for="input-bts-ex-6">Search</label>
                                                <div class="search-box">
                                                    <div class="input-group">
                                                        <span class="input-group-addon" id="search-icon5">
                                                            <span class="fa fa-search"></span>
                                                            <a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Clear filter</span></a>
                                                        </span>
                                                        <%--Commented & Added By Dipali V ON 26th March 2020 For Filter Issues--%>
                                                        <%--<input type="text" placeholder="Search" id="TaskCategoriesSearch" class="form-control" tabindex="1" />--%>
                                                        <input type="text" placeholder="Search" id="TaskCategoriesSearch"  onkeyup="TaskCategoriesSearch(this)" class="form-control live-search" tabindex="1" />
                                                        <%--End of Commented & Added By Dipali V ON 26th March 2020 For Filter Issues--%>
                                                    </div>
                                                </div>
                                                <div class="list-to-filter">
                                                    <ul class="list-unstyled">
                                                        <li class="optgroup">
                                                            <%-- <span class="optgroup-header">
                                                                <input id="checkAll" class="checkbox checkAll" type="checkbox" onchange="TaskCategory_OnChange()">All <span class="subtext"></span>

                                                            </span>--%>

                                                            <ul class="list-unstyled" id="FilterTaskCategories">
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                    <%-- <div class="no-search-results">
                                                        <div class="alert alert-warning" id="txtTaskCategoriesNoSearch" role="alert"><i class="fa fa-warning margin-right-sm"></i>No entry for <strong>'<span></span>'</strong> was found.</div>
                                                    </div>--%>
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
                                <%--<div class="no-search-results" style="display: none!important">
                                    <div style="display: none" id="FilterTaskBodytxtSearchBoxProjectNamesNoSearch" class="ClsNodata" role="alert"><i class=""></i>No entry for <strong>'<span></span>'</strong> was found.</div>
                                </div>--%>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <%-- Commented & added by dipali V On 26th March 2020 For Clear filter data--%>
                            <%--<button class="btn borderbtn uncheckbtn pull-left" data-dismiss="modal">Cancel</button>--%>
                            <button class="btn borderbtn uncheckbtn pull-left" data-dismiss="modal" onclick="ClearallData()">Cancel</button>
                            <%--End of added & commented by dipali V On 26th March 2020 For Clear filter data--%>
                            <button class="btn btnyellow pull-right" onclick="FilterTaskFromList()">Select</button>

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
                            <button type="button" class="close" data-dismiss="modal" onclick="clearSubtask()">&times;</button>
                            <h4 class="modal-title">Select sub tasks</h4>
                        </div>

                        <div class="modal_task_hader graybg">
                            <div class="row">
                                <%-- <div class="col-md-4" id="subTaskListPopupProjectName">
                                </div>
                                <div class="col-md-7" id="subTaskListPopupTaskName">
                                    <div class=""></div>
                                </div>--%>
                                <div class="col-md-12" id="subTaskListPopupProjectName">
                                </div>
                                <div class="col-md-12" id="subTaskListPopupTaskName">
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
                            <button class="btn borderbtn pull-left" data-dismiss="modal" onclick="clearSubtask()">Cancel</button>
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
                            <%--Added By Usha Pandit On 03.03.2021 For Filter issue--%>
                            <%--<button type="button" class="close" data-dismiss="modal">&times;</button>--%>
                            <button type="button" class="close" data-dismiss="modal" onclick="onDataDismiss()">&times;</button>
                            <%--Added By Usha Pandit On 03.03.2021 For Filter issue--%>
                            <h4 class="modal-title">Advance Filter Result</h4>
                        </div>
                        <div class="modal-body">
                            <p id="FilterResultMsg"></p>
                        </div>
                        <div class="modal-footer">
                            <%--Added By Usha Pandit On 03.03.2021 For Filter issue--%>
                            <%--<button class="btn borderbtn pull-left uncheckbtn" data-dismiss="modal" id='AdvanFilterNo'>No</button>--%>
                            <button class="btn borderbtn pull-left uncheckbtn" data-dismiss="modal" id='AdvanFilterNo' onclick="onDataDismiss()">No</button>
                            <%--Added By Usha Pandit On 03.03.2021 For Filter issue--%>
                            <%--Added By Usha Pandit On 03.03.2021 For Filter issue--%>
                            <%--<button class="btn btnyellow" data-original-title="" data-dismiss="modal" title="" onclick="PlotFilterTaskList(0)" id='AdvanFilterYes'>Yes</button>--%>
                            <button class="btn btnyellow" data-original-title="" data-dismiss="modal" title="" onclick="PlotFilterTaskList(0, this)" id='AdvanFilterYes'>Yes</button>
                            <%--Added By Usha Pandit On 03.03.2021 For Filter issue--%>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

            <!--modalEnd-->
            <!--Confirmation message Modal-->
            <div id="ConfirmMessagemodalinfoSch" class="modal fade custmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Message</h4>
                        </div>
                        <div class="modal-body">
                            <p id="ConfirmationMsgsch"></p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn borderbtn pull-left uncheckbtn" data-dismiss="modal" onclick="SendConfirmationResponsesch(0)">No</button>
                            <button class="btn btnyellow" data-toggle="modal" data-original-title="" data-dismiss="modal" title="" onclick="ScheduleTS_Save(0)">Yes</button>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--Confirmation message Modal modalEnd-->




            <!--Confirmation message Modal-->
            <div id="ConfirmMessagemodalinfo" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <%--    <button type="button" class="close" onclick="CloseConfirmationResponse(0)" data-dismiss="modal">&times;</button>--%>
                            <button type="button" class="close" onclick="SendConfirmationResponse(0)" data-dismiss="modal">&times;</button>
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
            <div id="ConfirmMessageModalCreateTask" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
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
                            <button class="btn btnyellow" data-toggle="modal" data-original-title="" data-dismiss="modal" title="" onclick="SaveCreateTask(1)">Yes</button>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

            <!--Confirmation message Modal modalEnd-->
            <!--Confirmation message Modal-->
            <div id="ConfirmMessageModalLeave" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Message</h4>
                        </div>
                        <div class="modal-body">
                            <p id="ConfirmMessageModalLeaveDate"></p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn borderbtn pull-left" data-dismiss="modal" onclick="ConfirmLeaveForCreateTask(0)">No</button>
                            <button class="btn btnyellow" data-toggle="modal" data-original-title="" data-dismiss="modal" title="" onclick="ConfirmLeaveForCreateTask(1)">Yes</button>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--Confirmation message Modal modalEnd-->
            <!--rejectmodal-->
            <div id="rejecttaskmodal" class="modal fade custmodal rejecttaskmodal" role="dialog" data-backdrop="static" data-keyboard="false">
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
                                                <textarea class="form-control" id="txtRejectionComment" maxlength="100">
                                                                      
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
                                                    <%--Commented And Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings--%>    
                                                    <%--<input type="checkbox" id="rejecttaskmodalcheckbox">
                                                    <label for="rejecttaskmodalcheckbox">Allow resource to change timesheet and resubmit</label>--%>
                                                    <input type="checkbox" id="rejecttaskmodalcheckbox" class ="clsHide">
                                                    <label class ="clsHide" for="rejecttaskmodalcheckbox">Allow resource to change timesheet and resubmit</label>
                                                    <span id ="allowoverridenote" style="font-weight:700;"></span>
                                                    <%--End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings--%>    
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
                                        <button class="btn borderbtn ml-1" data-dismiss="modal" onclick="CancelReject()">Cancel</button>
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
            <div id="approvetaskbtnmodal" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
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
                                                <textarea class="form-control" id="txtApprovalComment" maxlength="100">
                                                                      
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
    <%--<script src="../../../Whizible2.0/plugins/jQuery/jQuery-2.1.4.min.js"></script>--%> 
   
    <%--<script src="../../../Whizible2.0/plugins/jQuery/jQuery-2.1.4.min.js"></script>--%>
     <script src="../../../Whizible2.0/plugins/jQuery/jquery-3.5.1.min.js"></script>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
    <!-- <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->

    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0/plugins/jQueryUI/jquery-ui.min.js"></script>

    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap-select.js"></script>

    <!-- Bootstrap 3.3.5 -->
    <%--<script src="../../../Whizible2.0/bootstrap/js/bootstrap.min.js"></script>--%>
    <script src="../../Agile/js/Updatebootstrap.min.js"></script>
    <!--daterangepicker-->
    <%--<script src="../../../Whizible2.0/dist/js/moment.min.js"></script>--%>
    <script src="../../../Whizible2.0/dist/UpdatedJs/Moment.js"></script>
    <!--bootstrapdatepicker-->
    <!-- <script src="../../../Whizible2.0/dist/js/bootstrap-datepicker.min.js"></script> -->
    <script src="../../General/CommonValidations.js"></script>
    <!--autofilter-->
    <script src="../../../Whizible2.0/dist/js/autocomplete/tabcomplete.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/autocomplete/livefilter.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/autocomplete/bootstrap-select-autocomplete.js"></script>
    <!-- stickytable js -->
   <%--//Commeted by dipali V On 23rd Dec 2020 For Jquery Version--%>
    <script src="../../../Whizible2.0/dist/js/jquery.freezeheader.js"></script>
    <%--//End of Commeted by dipali V On 23rd Dec 2020 For Jquery Version--%>
    <script src="../../../Whizible2.0/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/loadingoverlay_progress.js"></script>
    <!-- custome js -->
    <script src="../../../Whizible2.0/dist/js/custom.js?v=1.6"></script>







    <script>
        $("#ProxyResource").mouseover(function () {
            $("#ProxyResource .dropdown-toggle").tooltip('hide');
        });
        //$("#ProxyResource").on("click", function () {
       
        //    $('<style>#ProxyResource .bootstrap-select::before{display:none!important;}</style>');

        //});
        $('#ProxyResource').hover(function (e) {
          
            //    $('<style>#ProxyReso
            $('<style>div#ProxyResource:hover .bootstrap-select::after{display:none!important;}</style>');
            $(this).attr('title', '');
        });


        var Search = 0;
        //filter_search
        function EmployeeSearchFuntion(evt, element, ulID) {
            
            var value = $(element).val().toLowerCase();
            //Added By Dipali V On 23st Jan 2019 For Filter Issue
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                value = "   ";
                //$("#FilterTaskBody").css("display", "none");
            }
            //End of Added By Dipali V On 23st Jan 2019 For Filter Issue
            $("#" + ulID + " > li").each(function () {

                if ($(this).text().toLowerCase().indexOf(value) > -1) {
                    $(this).show();
                    Search = 1;
                } else {
                    $(this).hide();

                }
            });
            if ($("#" + ulID + " > li:visible").length == 0) {
                if (ulID == 'ProjectFilterList' && Search == 1) { $("#txtSearchBoxProjectNamesNoSearch").css('display', 'block'); }
                else if (ulID == 'TaskTypeFilterList' && element.value != "") { $("#txtSearchBoxTaskTypesNoSearch").css('display', 'block'); }
                else {
                    $("#txtSearchBoxProjectNamesNoSearch").css('display', 'none');
                    $("#txtSearchBoxTaskTypesNoSearch").css('display', 'none');
                }

            }
            else {
                $("#txtSearchBoxProjectNamesNoSearch").css('display', 'none');
                $("#txtSearchBoxTaskTypesNoSearch").css('display', 'none');
            }

        }
        //Added & Commented By Dipali V On 26th March 2020 For Filter Issues
        //function TaskCategoriesSearch(evt, element) {
           
        //    var value = $(element).val().toLowerCase();
        //    //Added By Dipali V On 21st Jan 2019 For Filter Issue
        //    //if (value == " " || value == "  ") {
        //    //    value = "   ";
        //    //}
        //    evt = (evt) ? evt : window.event;
        //    var charCode = (evt.which) ? evt.which : evt.keyCode;
        //    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        //        value = "   ";
        //        //$("#FilterTaskBody").css("display", "none");
        //    }
        //    //End of Added By Dipali V On 21st Jan 2019 For Filter Issue
        //    // if (value != " ") {

        //    $("#FilterTaskCategories > li").each(function () {
        //        //alert();
        //        if ($(this).text().toLowerCase().indexOf(value) > -1) {
        //            $(this).show();
        //        } else {
        //            $(this).hide();
        //        }
        //    });
        //    if ($("#FilterTaskCategories > li:visible").length != 0) {
        //        $("#txtTaskCategoriesNoSearch").css('display', 'none');
        //    }
        //    else {
        //        $("#txtTaskCategoriesNoSearch").css('display', 'block');
        //    }

        //    //}
        //    //else {

        //    //    $("#FilterTaskCategories").css('display', 'none');
        //    //     $("#txtTaskCategoriesNoSearch").css('display', 'block');
        //    //}


        //}

        function TaskCategoriesSearch(element) {

            var value = $(element).val().toLowerCase();
            //Added By Dipali V On 21st Jan 2019 For Filter Issue
            //if (value == " " || value == "  ") {
            //    value = "   ";
            //}
            //evt = (evt) ? evt : window.event;
            //var charCode = (evt.which) ? evt.which : evt.keyCode;
            //if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            //    value = "   ";
            //    //$("#FilterTaskBody").css("display", "none");
            //}
            //End of Added By Dipali V On 21st Jan 2019 For Filter Issue
            // if (value != " ") {

            $("#FilterTaskCategories > li").each(function () {
                //alert();
                if ($(this).text().toLowerCase().indexOf(value) > -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
            if ($("#FilterTaskCategories > li:visible").length != 0) {
                $("#txtTaskCategoriesNoSearch").css('display', 'none');
            }
            else {
                $("#txtTaskCategoriesNoSearch").css('display', 'block');
            }

            //}
            //else {

            //    $("#FilterTaskCategories").css('display', 'none');
            //     $("#txtTaskCategoriesNoSearch").css('display', 'block');
            //}


        }
         //End of Added & Commented By Dipali V On 26th March 2020 For Filter Issues

        //function TaskSearch(evt, element) {
        //    var value = $(element).val().toLowerCase();
        //    var searchFlag = 0;
        //    evt = (evt) ? evt : window.event;
        //    var charCode = (evt.which) ? evt.which : evt.keyCode;
        //    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        //        value = "   ";
        //    }

        //    $("#FilterTaskBody tr").each(function () {
        //        if ($(this).text().toLowerCase().indexOf(value) > -1) {
        //            $(this).show();
        //        } else {
        //            $(this).hide();
        //        }
        //    });
        //    if ($("#FilterTaskBody tr:visible").length != 0) {
        //        $(".NoData").css('display', 'none');
        //    }
        //    else {
        //        $(".NoData").css('display', 'block');
        //        $('.NoData td').text("No Entry for " + value + " was found.");
        //    }
        //}
        function SelectAllTaskType(chk) {
           
            var checked = $(chk).is(':checked');
            $("#TaskTypeFilterList > li").find(".checkbox").prop("checked", checked);
            $("input[type='checkbox'].clsTaskTypes").click(function () {
                var a = $("input[type='checkbox'].clsTaskTypes");
                if (a.length == a.filter(":checked").length) {

                    $("#chkAllTaskType").prop('checked', true);

                }
            });
        }

        //Added By Reshma for issue
        function SelectAllTaskCategory(chk) {
            
            var checked = $(chk).is(':checked');
            $("#TaskCategoryFilterList > li").find(".checkbox").prop("checked", checked);
        }

        function SelectAllTaskPriority(chk) {
           
            var checked = $(chk).is(':checked');
            $("#TaskPriorityFilterList > li").find(".checkbox").prop("checked", checked);
        }

        function SelectAllTaskPhase(chk) {
            
            var checked = $(chk).is(':checked');
            $("#TaskPhaseFilterList > li").find(".checkbox").prop("checked", checked);
        }

        function SelectAllTaskDeliverable(chk) {
           
            var checked = $(chk).is(':checked');
            $("#TaskDeliverableFilterList > li").find(".checkbox").prop("checked", checked);
        }
        function SelectAllTaskMileStone(chk) {
            
            var checked = $(chk).is(':checked');
            $("#TaskMilestoneFilterList > li").find(".checkbox").prop("checked", checked);
        }


        function SelectAllTaskSubProject(chk) {
            
            var checked = $(chk).is(':checked');
            $("#TaskSubProjectFilterList > li").find(".checkbox").prop("checked", checked);
        }
        function SelectAllTaskModule(chk) {
           
            var checked = $(chk).is(':checked');
            $("#TaskModuleFilterList > li").find(".checkbox").prop("checked", checked);
        }

        //End By Reshma for issue



        function ClearFilterTextBoxes() {
           
            $("#txtSearchBoxTaskTypes").val("");
            $("#txtSearchBoxProjectNames").val("");
            //Added By Rutuja D. on 16 April 2020 For IssueID = 23579
            $(".filter-item").css('display', 'block'); 
            //End Added By Rutuja D. on 16 April 2020 For IssueID = 23579

            //  document.getElementsByName("txtSearchBox").values = '';
        }

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var startingDayOfWeek;
        var FinancialYearStart;
        var TodaysDate;
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
                    TodaysDate = d.TodaysDate;
                }
            },
            error: function (err) {
                console.log(err);
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        });
        //});
        var isWeeklyView = 1;
        var actionOnDuration = false;
        var intMaxEntry = 24;
        
        var MinDAENtryDisplay = "";
        var MinDAEntry = <%=CommonFunctions.Application.MinHoursForDAEntry%>;
        var GlobalRestrictByMinHours = 0;
        var GlobalHoursFlag = 1;
        if (GlobalHoursFlag == 1) {
            if (MinDAEntry == 0.25) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:15"
            }
            else if (MinDAEntry == 0.50) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:30"
            }
            else if (MinDAEntry == 0.75) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:45"
            }
            //else if (MinDAEntry == 0.016) {
            //    MinDAEntry = MinDAEntry
            //         MinDAENtryDisplay = MinDAEntry
            //}
        }
        else {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = MinDAEntry
        }


    </script>
    <!--weekpicker-->
    <script type="text/javascript" src="../../../Whizible2.0/dist/js/weekPicker.js?v=1.8"></script>

    <script type="text/javascript">
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

        var EmployeeID;
        var UserName;
        EmployeeID = '<%= Session("intUserID") %>';
        UserName = '<%= Session("strUserName") %>';

        $('#next').click(function () {
            // alert();
            //debugger;
            if (PageFlag == 2) {
                setWeekCalendar($('#weekPicker2'), 'next', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("StartDate")%>'), new Date(TodaysDate));
                ViewTimesheetID = '<%= Request.QueryString("TimesheetID")%>';
                var EmpID = $("#cboProxyResource option:selected").val();
                if (EmpID == 0) {
                    ReloadTApprovalData('<%= Session("intUserID") %>');
                }
                else {
                    ReloadTApprovalData(EmpID);
                }
               
               
            }
            else if (PageFlag == 3) {
                setWeekCalendar($('#weekPicker2'), 'next', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("FromDate")%>'), new Date(TodaysDate));
                ReloadTApprovalData(EmployeeID);
            }
            else {
                setWeekCalendar($('#weekPicker2'), 'next', 1, startingDayOfWeek, FinancialYearStart, '', new Date(TodaysDate));
                ReloadData(EmployeeID);
            }

            
            //var default_date = new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US");
            //$(".hasDatepicker").datepicker("setDate", default_date);
            //   $('#dailyviewdatepicker').datepicker( {
            //    changeMonth: true,
            //    changeYear: true,
            //    showButtonPanel: true,
            //    dateFormat: 'MM yy',
            //    onClose: function(dateText, inst) { 
            //        var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            //        var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            //        $(this).datepicker('setDate', new Date(year, month, 1));
            //    }
            //});

            //$(".ui-datepicker-next").click(function () {
            //   alert('H');
            // });
           
            //$(".ui-icon-circle-triangle-e").trigger("click")
            //showWeekCalendar(this);
            //var datepickerValue= $("#weekPicker2").attr("selecteddate")
            //alert(datepickerValue);
        });


        $('#prev').click(function () {
            if (PageFlag == 2) {
                
                setWeekCalendar($('#weekPicker2'), 'prev', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("StartDate")%>'), new Date(TodaysDate));
                ViewTimesheetID = '<%= Request.QueryString("TimesheetID")%>';
                var EmpID = $("#cboProxyResource option:selected").val();
                if (EmpID == 0) {
                    ReloadTApprovalData('<%= Session("intUserID") %>');
                }
                else {
                    ReloadTApprovalData(EmpID);
                }

            }
            else if (PageFlag == 3) {
                setWeekCalendar($('#weekPicker2'), 'prev', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("FromDate")%>'), new Date(TodaysDate));
                ReloadTApprovalData(EmployeeID);
            }
            else {
                setWeekCalendar($('#weekPicker2'), 'prev', 1, startingDayOfWeek, FinancialYearStart, '', new Date(TodaysDate));
                ReloadData(EmployeeID);
            }

            //debugger;
             
             
        });


        $('.next-day').click(function () {
            setWeekCalendar($('#dailyviewdatepicker'), 'next', 0, startingDayOfWeek, FinancialYearStart, '', new Date(TodaysDate));
            plotDailyTaskList(EmployeeID);
        });

        $('.prev-day').click(function () {
            setWeekCalendar($('#dailyviewdatepicker'), 'prev', 0, startingDayOfWeek, FinancialYearStart, '', new Date(TodaysDate));
            plotDailyTaskList(EmployeeID);
        });
        var PageFlag = 0;
        var TimesheetID = 0;
        var ViewTimesheetID = 0;
        var chkISVALID = 0;
        var CTinvalidData = "";

        //Added by Usha on 27.12.2018 for disable field on view 
        var strEnableDisable = '';
        //End of Added by Usha on 27.12.2018 for disable field on view 

       

        //$('.hasDatepicker').datepicker({
        //    // ...
        //});

        var arrTimesheetApprovalLists = [];
         //Added By Dipali V On 18th jun 2021
        var len = 0;
        var AllText = 0;
        var Disabled = 0;
        //End of Added By Dipali V On 18th jun 2021

        $(document).ready(function () {


           
            //alert(startingDayOfWeek);

            //debugger;

            //Added by Usha on 27.12.2018 for disable field on view 
            var IsView = '<%= Request.QueryString("IsView")%>';
            if (IsView == 1) {
                strEnableDisable = 'disabled';
            }
            //End of Added by Usha on 27.12.2018 for disable field on view 

            PageFlag = '<%= Request.QueryString("Flag")%>';

            if (EmployeeID == '') {
                alert('Your session is expired. Please login again.');
                window.location.href = "../../Default.aspx?Message=SessionExpired";
            }
            showSection();
            if ($('#cboProxyResource option').length <= 1) {
                $(".selectpicker").selectpicker('refresh');
                $('#ProxyResource .bootstrap-select').css("display", "none");
            }
            if (PageFlag == 2) {

                setWeekCalendar($('#weekPicker2'), 'Selected', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("StartDate")%>'), new Date(TodaysDate));
                EmployeeID = '<%= Request.QueryString("EmployeeID")%>';

                $("#cboProxyResource option[value='" + EmployeeID + "']").attr("selected", "selected");
                if (EmployeeID == 0) { EmployeeID = '<%= Session("intUserID") %>'; }
                $("#btnMoreProjects").css('display', 'none!important');
            }
            else if (PageFlag == 3) {

                setWeekCalendar($('#weekPicker2'), 'Selected', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("FromDate")%>'), new Date(TodaysDate));
                arrTimesheetApprovalLists = JSON.parse(localStorage.arrTimesheetApprovalList);
                if (parseInt(localStorage.arrNextCount) + 1 == arrTimesheetApprovalLists.length) {
                    $("#btnNext").css("display", "none")
                }
            }
            else if (PageFlag == 1) {

                setWeekCalendar($('#weekPicker2'), 'Selected', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("StartDate")%>'), new Date(TodaysDate));
                setWeekCalendar($('#dailyviewdatepicker'), 'Selected', 0, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("StartDate")%>'), new Date(TodaysDate));
                // setWeekCalendar($('#dailyviewdatepicker'), 'yes', 0, startingDayOfWeek, FinancialYearStart);
                EmployeeID = '<%= Request.QueryString("EmployeeID")%>';
                // alert(EmployeeID);
                //Added by swapna to select EmployeeID as Selected in dropdown 
                $("#cboProxyResource option[value='" + EmployeeID + "']").attr("selected", "selected");
                if (EmployeeID == 0) { EmployeeID = '<%= Session("intUserID") %>'; }
            }
            else {

                setWeekCalendar($('#weekPicker2'), 'yes', 1, startingDayOfWeek, FinancialYearStart, '', new Date(TodaysDate));
                setWeekCalendar($('#dailyviewdatepicker'), 'yes', 0, startingDayOfWeek, FinancialYearStart, '', new Date(TodaysDate));
            }


            if (PageFlag == 0 || PageFlag == 1) {
                if (isWeeklyView == 1) {
                   
                    ReloadData(EmployeeID);
                     //Added By Dipali V On 18th jun 2021
                    $("#timesheetBody .timenoinput").each(function () {
                        
                         AllText = $("#timesheetBody .timenoinput").length;
                        var attr = $(this).attr("style");
                        if (attr == "pointer-events: none;") {
                            len = len + 1;
                        }
                    });
                   
                    if (AllText == len) {
                        Disabled = 1;
                    }
                //End of Added By Dipali V On 18th jun 2021
                }
                else {
                    plotDailyTaskList(EmployeeID);
                }
            }
            else if (PageFlag == 2) {
                ViewTimesheetID = '<%= Request.QueryString("TimesheetID")%>';

                ReloadTApprovalData(EmployeeID);
            }
            else if (PageFlag == 3) { ReloadTApprovalData(EmployeeID); }
            //$("#fixedtbl1").freezeHeader({
            //    'height': '300px'
            //});
            $("#fixedtbl1").freezeHeader({ 'height': '300px' });
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
                //Added By Reshma chavan on 11th Nov 2021 to Hide datepicker
                //$(this).datepicker('hide');
                //End of Added By Reshma chavan on 11th Nov 2021 to Hide datepicker

            })
            $("#dailyviewdatepicker").change(function () {
                plotDailyTaskList(EmployeeID);
            })
            $("#CTselectdate").change(function () {
                BindProjects();
            })
            $('.ClosaeblealertMsg').hide();



            $(document).on('click', '.close', function () {
                //alert(this.id);

                var id = this.id.split("close_")[1];
                //Added by Chetan M on 04th Aug 2020 for All E Tech Issue ID = 25712
                $('#cboPriority option:selected').attr("selected", null);
                //End of Added by Chetan M on 04th Aug 2020 for All E Tech Issue ID = 25712
                //$('#popover-content-' + id).parent().hide();
                $(".popover").hide();
                //$(this).parent().hide();
            });
            //Added by Chetan M on 04th Aug 2020 for All E Tech Issue ID = 25712
            $(document).on('click', '.close1', function () {
                $('#cboPriority option:selected').attr("selected", null);
            });
            //End of Added by Chetan M on 04th Aug 2020 for All E Tech Issue ID = 25712
            //alert($('#dailyviewdatepicker').datepicker('getDate'));
            $('#dailyviewdatepicker').datepicker({
                dateFormat: 'M dd',
                onSelect: function (dateText, inst) {
                    //$('.weekNo').val($.datepicker.iso8601Week(new Date(dateText)));
                    //$('#dailyviewdatepicker').attr("SelectedDate", dateText);
                }

            });

            BindProjects();
            $("#cboProject").selectpicker({
                noneSelectedText: 'Select Project' // by this default 'Nothing selected' -->will change to Select Task Category
            });
            $("#cboTaskType").selectpicker({
                noneSelectedText: 'Select Task Type' // by this default 'Nothing selected' -->will change to Select Task Category
            });

            $("#cboSubTaskType").selectpicker({
                noneSelectedText: 'Select Sub Task Type' // by this default 'Nothing selected' -->will change to Select Task Category
            });

            //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
            globalOverrideTSCheck = getCorporateOverrideTSCheck();
            var AllowToResubmitCheck = getCorporateAllowToResubmitCheck();
            //debugger;
            //Added By Dipali V On 23rd March 2021 For Note checking back Days
            if (AllowToResubmitCheck != "") {
                globalAllowToResubmitCheck = AllowToResubmitCheck[0];
                globalProjectLevelBackWardDays = AllowToResubmitCheck[2];
                globalProjectLevelForWardDays = AllowToResubmitCheck[4];

                if (globalAllowToResubmitCheck == 0) {
                    globalAllowToResubmitCheck = false;
                }
                else {
                    globalAllowToResubmitCheck = true;
                }

                 if (globalProjectLevelBackWardDays == 0) {
                    globalProjectLevelBackWardDays = false;
                }
                else {
                    globalProjectLevelBackWardDays = true;
                }

                 if (globalProjectLevelForWardDays == 0) {
                    globalProjectLevelForWardDays = false;
                }
                else {
                    globalProjectLevelForWardDays = true;
                }
                //End of Added By Dipali V On 23rd March 2021 For Note checking back Days
            }
            globalBackdatingNoDays = getBackdatingNoDays();
            //debugger;
           
            //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
        });
        //Added By Usha Pandit On 03.03.2021 For Filter issue
        function onDataDismiss() {            
            modalDismiss = true;
        }
        var modalDismiss = false;
        //Added By Usha Pandit On 03.03.2021 For Filter issue
        //$("#ui-datepicker-div").find(".ui-datepicker-next").click(function () {
        //      alert('C');
        //  });
        //Added by Usha on 27.12.2018 for disable field on view 
        function disableOnView() {
            $("#btnMoreProjects").attr('disabled', true);
            strEnableDisable = 'disabled';
        }

        function enableOnEdit() {
            //$("#btnMoreProjects").removeAttr("disabled");
            strEnableDisable = '';
            $('#btnMoreProjects').removeAttr('disabled');

            $('#txtQuickEntry').prop("disabled", false);
            $('#btnQuickEntry').prop("disabled", false);

            $('*[id*=IsTaskComplete_]').prop("disabled", false);
            $('*[id*=chkQuickEntry_]').prop("disabled", false);


            //alert(AllTotal)
            //$(".ActualHours").html(1);
        }

        //End of Added by Usha on 27.12.2018 for disable field on view 

       


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
        var EditMode = 0;
        function ShowEditMode() {
            EditMode = 1;
            // alert(ViewTimesheetID);
            if (ViewTimesheetID != 0) {
                //ViewTimesheetID = 0;
                ReloadData(EmployeeID);
            }
            
            //$("#ulVTEdit").attr('style', 'display:none');
            //$("#ulVTSave").attr('style', 'display:block');
            $('.timenoinput').css('pointer-events', 'unset');
            $("#btnMoreProjectTaskLevel").attr('style', 'display:inline-block !important');
            $("#btnSaveVT").attr('style', 'display:inline-block !important');
            $("#btnSubmit").attr('style', 'display:inline-block !important');

            //$(".Status").html("Not Submitted")
            //Added by Usha on 27.12.2018 for disable field on view 
            enableOnEdit();
            //End of Added by Usha on 27.12.2018 for disable field on view 
        }

        function ChangeProxyUser(intEmployeeID) {

            $('#ProxyResource button').hover(function (e) {
                $(this).attr('title', '');
            });


            /// });
            if (intEmployeeID == 0) {
                intEmployeeID = '<%= Session("intUserID") %>';
            }
            TaskIDList = "";
            IsDefault = 0;
            if (isWeeklyView == 1) {
                (PageFlag == 2 ? ReloadTApprovalData(intEmployeeID) : ReloadData(intEmployeeID))
            }
            else {
                plotDailyTaskList(intEmployeeID);
            }
            BindProjects();



        }
        function ViewTimesheet() {
            var EmpID = $("#cboProxyResource option:selected").val();

            var startDate = new Date($("#weekPicker2").attr("StartDate"));

            var d = new Date($("#weekPicker2").attr("StartDate")),
                month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();

            if (month.length < 2) month = '0' + month;
            if (day.length < 2) day = '0' + day;

            var newStartDate = [year, month, day].join('-');
            //Add  By Dipali V  On 18th March 2021 For Restirct Work Hours
            isNotAllowQuickEntry = false;
            //Add  By Dipali V On 18th March 2021 For Restirct Work Hours
            //Commented and Added by Usha on 27.12.2018 for disable field on view 
            //window.location.href = "TimesheetEntry.aspx?Flag=2&StartDate=" + startDate + "&TimesheetID=" + TimesheetID + "&EmployeeID=" + EmpID + "";
            window.location.href = "TimesheetEntry.aspx?Flag=2&StartDate=" + newStartDate + "&TimesheetID=" + TimesheetID + "&EmployeeID=" + EmpID + "&IsView=1";
            //End of Added by Usha on 27.12.2018 for disable field on view 
        }
        function Save_VTOnClick() {

            Save_OnClick();
            //$("#ulVTEdit").css('display', 'block');
            //$('.timenoinput').css('pointer-events', 'none');
            $("#btnMoreProjectTaskLevel").attr('style', 'display:none !important');
        }
        function goBackToApprovalPage() {

            var dat = '<%= Request.QueryString("StartDate")%>'
            var yourdate = dat.split("/").reverse();
            var tmp = yourdate[2];
            yourdate[2] = yourdate[1];
            yourdate[1] = tmp;
            yourdate = yourdate.join("-");
            window.location.href = "TimesheetApproval.aspx?Flag=3&StartDate=" + yourdate +"&SelectedStatus=<%= Request.QueryString("SelectedStatus")%>";
        }
       
        function goNextToApprovalPage() {
           
            localStorage.arrNextCount = parseInt(localStorage.arrNextCount) + 1;
            var nTimesheetID, nEmployeeID;
            var nFromDate, nTodate;
            for (var i = 1; i < arrTimesheetApprovalLists.length; i++) {

                if (i == parseInt(localStorage.arrNextCount)) {
                    nTimesheetID = arrTimesheetApprovalLists[i].arrTimesheetID;
                    nEmployeeID = arrTimesheetApprovalLists[i].arrEmployeeID;
                    nFromDate = arrTimesheetApprovalLists[i].arrFromDate;
                    nTodate = arrTimesheetApprovalLists[i].arrToDate;

                }

            }
            if (localStorage.arrNextCount < arrTimesheetApprovalLists.length) {
                window.location.href = "TimesheetEntry.aspx?intTimesheetId=" + nTimesheetID + "&Flag=3&intEmployeeID=" + nEmployeeID + "&FromDate=" + nFromDate + "&ToDate=" + nTodate + "&StartDate=" + '<%=Request.QueryString("StartDate")%>' + "&SelectedStatus=" + '<%=Request.QueryString("SelectedStatus")%>' + "";
            }
            
        }
        function goBack() {

            var startDate
            var StatusSelected = "";
            if (isWeeklyView == 1)
                startDate = new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US");
            else
                startdate = new Date($('#dailyviewdatepicker').attr("selecteddate"));

            if ('<%=Request.QueryString("selectedStatus")%>' != "") {

                StatusSelected ='<%=Request.QueryString("selectedStatus")%>';
            }
            //else {
            //     //$(".Status").text('');
            //     StatusSelected = $(".Status").text();

            //}
            var startDate = new Date($("#weekPicker2").attr("StartDate"));

            var d = new Date($("#weekPicker2").attr("StartDate")),
                month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();

            if (month.length < 2) month = '0' + month;
            if (day.length < 2) day = '0' + day;

            var newStartDate = [year, month, day].join('-');
            //alert(startDate);
            var EmpID = $("#cboProxyResource option:selected").val();
            //setWeekCalendar($('#weekPicker2'), 'Selected', 1, startingDayOfWeek, FinancialYearStart, new Date(startDate));
            //setWeekCalendar($('#dailyviewdatepicker'), 'Selected', 0, startingDayOfWeek, FinancialYearStart, new Date(startDate));
            if ('<%= Request.QueryString("FromPage")%>' == 'MyTimesheet') {
                
                window.location.href = "MyTimesheet.aspx?PageFlag=4&EmployeeID=" + EmpID + "&StatusSelected=" + StatusSelected + "";
            }
            else {
                window.location.href = "TimesheetEntry.aspx?Flag=1&StartDate=" + newStartDate + "&EmployeeID=" + EmpID + ""
            }

        }
        function clearCreateTaskData() {
            
            $("#CTselectdate").val("");
            $("#txtTaskName").val("");
            $("#txtActualComplete").val("");
            $("#txtDescription").val("");
            $('#txtWorkHrs').val("");
            //Added by Chetan M on 10 Feb 2021 for Clear Priority dropdown
            $('#cboPriority').val("");
            //$('#cboPriority option:selected').attr("selected", null);
            //End of Added by Chetan M on 10 Feb 2021 for Clear Priority dropdown
            $('#cboProject').html("");
            //$('#cboProject').html("<option title='Select Project' value='0' selected>Select Project</option>");

            //$('#cboProject').val(null).trigger('change');
            $('#cboTaskType').html("");
            $('#cboSubTaskType').html("");
            $("#btnCreateTask,#btnSaveCreateTask").css("display", "inline-block");
           $(".selectpicker").selectpicker('refresh');
            AfterPlot();

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
                plotDailyTaskList(EmployeeID);
        }
        var IsDefault = 0;
        function ReloadData(ProxyResourceID) {
            var varEmployeeID;

            varEmployeeID = '<%= Session("intUserID") %>'.toString();

            TotalHoliday = 0;
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
                // async:false
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var Timesheet = data;
                    // alert(Timesheet.filters.TaskTypeFilterLists);
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
                     //Added By Usha Pandit On 03.03.2021 For adding note to inform timesheet is edited when status is rejected                    
                    if (updatedAllTotal != actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("EmployeeID")%>' != "") {
                        //Commented And Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                        //$(".Status").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b>Actual hours are changed,Please re-submit the Timesheet.<span>");
                        $(".Status").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b>For any changes in Timesheet details, Timesheet should be Re-Submitted.<span>");                        
                        //End Of Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                        $("#btnSubmit").text("Re-Submit");
                    }
                    else if (updatedAllTotal == actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("EmployeeID")%>' != "") {
                        //Commented And Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                        //$(".Status").html(curStatus);
                        //$("#btnSubmit").text("Submit");
                        $(".Status").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b>For any changes in Timesheet details, Timesheet should be Re-Submitted.<span>");
                        $("#btnSubmit").text("Re-Submit");
                        //End Of Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                    }
                    if (updatedAllTotal != actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("intEmployeeID")%>' != "") {
                        //Commented By Usha Pandit On 17.05.2021 For generic note given for rejected timesheet
                        //$(".Status").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b> User has modified this timesheet effort<span>");                        
                        //Commented By Usha Pandit On 17.05.2021 For generic note given for rejected timesheet
                    }
                    else if(updatedAllTotal == actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("intEmployeeID")%>' != ""){
                        $(".Status").html(curStatus);
                    }
                    if (curStatus == "Not Submitted") {
                        $("#btnSubmit").text("Submit");
                    }
                    //End Of Added By Usha Pandit On 03.03.2021 For adding note to inform timesheet is edited when status is rejected
                    StopAjaxLoader("#bodyTSEntry");
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
        
        function ReloadTApprovalData(ProxyResourceID) {
            var varEmployeeID;

            varEmployeeID = '<%= Session("intUserID") %>'.toString();
            if (ProxyResourceID == 0)
                ProxyResourceID = EmployeeID;

            
            if (PageFlag == 3) {
                var taskParameters = {
                    intEmployeeID: '<%= Request.QueryString("intEmployeeID")%>',
                    dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                    dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                    
                    intTimesheetID: '<%= Request.QueryString("intTimesheetId")%>',                    
                       
                    intApproverID: EmployeeID,
                    PageFlag: PageFlag,

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
                        
                        //intTimesheetID:0,
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
                  // debugger
                    var TimesheetApprovalDetail = data;
                    if (TimesheetApprovalDetail.timesheetLists.length != "0") {
                        PlotTAHeaderSection(TimesheetApprovalDetail.GetActualExpectedHours);
                    
                    } else {
                        PlotTAHeaderSection(null);
                    }
                    plotHeaderSection(TimesheetApprovalDetail.headerColumns);
                    //PlotTableHeaderSection(TimesheetApprovalDetail.headerColumns);
                    plotWeekTotal(TimesheetApprovalDetail.WeekTotalLists);
                    plotTaskList(TimesheetApprovalDetail.timesheetLists);
                    if (TimesheetApprovalDetail.timesheetLists.length == 0) {
                        $("#ulVTEdit").attr('style', 'display:none');
                        $("#ulBackButton").attr('style', 'display:block');
                    }
                    $('.spCls').css('pointer-events', 'none');
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
                       
                        //var Label= IsTaskComplete.find('label')
                        //Commented by Usha on 27.12.2018 for disable field on view
                        //$('.timenoinput').css('pointer-events', 'none');
                        //End of Commented by Usha on 27.12.2018 for disable field on view

                        // $('.spCls').css('pointer-events', 'none');
                        if (Status.toUpperCase() == "" || Status.toUpperCase() == "SUBMITTED" || Status.toUpperCase() == "APPROVED") {
                            $("#btnMoreProjects").attr('style', 'display:none !important');
                            $(MoreProjectTaskLevel).attr('style', 'display:none !important');
                            $(TSActions).attr('style', 'display:none !important');
                            $("#txtQuickEntry").attr('style', 'display:none !important');
                            $("#btnQuickEntry").attr('style', 'display:none !important');
                            $(QuickEntryHeader).prop("disabled", true);
                            $(QuickEntryHeader).attr('style', 'cursor: not-allowed !important');
                            $(IsTaskComplete).prop("disabled", true);
                            $(IsTaskComplete).attr('style', 'cursor: no-drop !important');
                            $(DescriptionSave).attr('style', 'display:none !important');
                            //Added by Usha on 27.12.2018 for disable field on view
                            $('.timenoinput').css('pointer-events', 'none');
                            $("#btnMoreProjectTaskLevel").attr('style', 'display:none !important');
                            //End of Added by Usha on 27.12.2018 for disable field on view
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

                            //Added by Usha on 27.12.2018 for disable field on view
                            $('.timenoinput').css('pointer-events', 'unset');
                            $("#btnMoreProjectTaskLevel").attr('style', 'display:inline-block !important');
                            if (strEnableDisable != '') {

                                $('*[id*=IsTaskComplete_]').prop("disabled", true);
                                $('*[id*=chkQuickEntry_]').prop("disabled", true);
                                $('.timenoinput').css('pointer-events', 'none');
                                $("#btnMoreProjectTaskLevel").attr('style', 'display:none !important');
                            }

                            //End of Added by Usha on 27.12.2018 for disable field on view 
                        }
                    }
                    if (PageFlag == 3) {
                        $(".timenoinput").css("pointer-events", "none");
                        // $('.spCls').css("pointer-events", "none");
                    }
                    AfterPlot();
                    StopAjaxLoader("#bodyTSEntry");
                    $(".notelisticon").tooltip();
                    $('#ProxyResource').tooltip({ placement: 'bottom' });
                    $('[data-toggle="tooltip"]').tooltip();
                    
                    //Added By Dipali V  On 6th March 2021
                    //Added By Usha Pandit On 03.03.2021 For adding note to inform timesheet is edited when status is rejected                    
                   
                    if ($("#DivTVStatusSection .Status").text() == "Rejected") {
                        if (updatedAllTotal != actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("EmployeeID")%>' != "") {
                            //Commented And Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                            //$(".Status").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b>Actual hours are changed,Please re-submit the Timesheet.<span>");
                            $(".Status").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b>For any changes in Timesheet details, Timesheet should be Re-Submitted.<span>");
                            //End Of Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                            $("#btnSubmit").text("Re-Submit");
                        }
                        else if (updatedAllTotal == actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("EmployeeID")%>' != "") {
                            //Commented And Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                            //$(".Status").html(curStatus);
                            //$("#btnSubmit").text("Submit");
                            $(".Status").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b>For any changes in Timesheet details, Timesheet should be Re-Submitted.<span>");
                            $("#btnSubmit").text("Re-Submit");
                            //End Of Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                        }
                        if (updatedAllTotal != actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("intEmployeeID")%>' != "") {
                            //Commented By Usha Pandit On 17.05.2021 For generic note given for rejected timesheet
                            //$(".Status").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b> User has modified this timesheet effort<span>");
                            //Commented By Usha Pandit On 17.05.2021 For generic note given for rejected timesheet
                        }
                        else if (updatedAllTotal == actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("intEmployeeID")%>' != "") {
                            $(".Status").html(curStatus);
                        }
                    }
                    if (curStatus == "Not Submitted") {
                        $("#btnSubmit").text("Submit");
                    }

                    //Added By Dipali V On 22nd March 2021 For Non Submitted TS More Project Button should disabled
                    if (PageFlag == "2") {
                        if ($("#DivTVStatusSection .Status").text() == "Not Submitted") {
                            $("#btnMoreProjects").attr("disabled", "disabled");
                        }
                    }
                     //End of Added By Dipali V On 22nd March 2021 For Non Submitted TS More Project Button should disabled
                   
                    //End Of Added By Usha Pandit On 03.03.2021 For adding note to inform timesheet is edited when status is rejected
                   //End of Added By Dipali V  On 6th March 2021

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })

        }
        var TotalHoliday = 0;
        function plotHeaderSection(headerList) {
           
            TotalHoliday = 0;
            $("#timesheetHeader").html("");
            var htmlString = "";

            htmlString += '<tr>';
            htmlString += '<th>Projects / Tasks / Sub-Task<span>'
            if (PageFlag != 3) {

                //Commented and Added by Usha on 27.12.2018 for disable field on view
                //htmlString += '  <button id="btnMoreProjects" class="btn borderbtn ml-1 mt-onehalf" data-toggle="modal" data-container="body" data-target="#selectprojecttask" onclick="PlotFilterTaskList(0)" title="Select More Projects" data-placement="bottom">More Projects+</button></span></th>'
                htmlString += '  <button id="btnMoreProjects" ' + strEnableDisable + ' class="btn borderbtn ml-1 mt-onehalf" data-toggle="modal" data-container="body" data-target="#" onclick="PlotFilterTaskList(0)" title="Select More Projects" data-placement="bottom">More Projects+</button></span></th>'
                //End of Added by Usha on 27.12.2018 for disable field on view 


                //htmlString += '<button id="btnMoreProjects" class="btn borderbtn ml-1 mt-onehalf" data-toggle="modal" data-target="#selectprojecttask"><span class="" data-toggle="tooltip" data-placement="bottom" title="Select More Projects" onclick="PlotFilterTaskList(0)">More Projects +</span></button>'
            }
            htmlString += '</span>'
            htmlString += '</th>'
            if (PageFlag != 3) {

                //Commented and Added by Usha on 27.12.2018 for disable field on view

                //htmlString += '<th name="QuickEntryHeader">Quick Entry<span data-toggle="tooltip" data-placement="bottom" data-container="body" data-container="body" title="Add Quick Entry(hh.mm format)" class="quickentryrecord"><input type="text" id="txtQuickEntry" value="" placeholder="00:00">'
                //htmlString += '<button id="btnQuickEntry" onclick="QuickEntry_Click()"><i class="fas fa-check"></i></button>'
                //Added & Commented By Dipali V On 22nd March 2021 For Change Quick Entry Tooltip
                //htmlString += '<th name="QuickEntryHeader">Quick Entry<span data-toggle="tooltip" data-placement="bottom" data-container="body" data-container="body" title="Add Quick Entry(hh:mm format)" class="quickentryrecord"><input type="text" ' + strEnableDisable + ' id="txtQuickEntry" value="" placeholder="00:00"   onkeypress="return isNumber(event,this.value,this)" maxlength="5">'
                 htmlString += '<th name="QuickEntryHeader">Quick Entry<span data-toggle="tooltip" data-placement="bottom" data-container="body" data-container="body" title="Add Quick Entry(hh:mm , Applicable for blank rows)" class="quickentryrecord"><input type="text" ' + strEnableDisable + ' id="txtQuickEntry" value="" placeholder="00:00"   onkeypress="return isNumber(event,this.value,this)" maxlength="5">'
               //End of Added & Commented By Dipali V On 22nd March 2021 For Change Quick Entry Tooltip
                htmlString += '<button id="btnQuickEntry" ' + strEnableDisable + ' onclick="QuickEntry_Click()"><i class="fas fa-check"></i></button>'

                //End of Added by Usha on 27.12.2018 for disable field on view 

                htmlString += '</span></th>'
            }
            var IsWeekendPresent = 1;
           
            for (var i = 0; i < headerList.length; i++) {
               
                var header = headerList[i];
                var EntryDate = header.EntryDate;
                var DayName = header.DayName;
                var IsWorking = header.IsWorking;
                if (IsWorking == 1) {
                    htmlString += "<th class='toggleDisplay weekcolumnred'>";
                    TotalHoliday = TotalHoliday + 1;
                }
                else if (IsWorking == 2) {
                    htmlString += '<th class="exapnd_and_collaps_column weekdayscol">';
                }
                else if (IsWorking == 4) {
                    IsWeekendPresent = 0;
                    htmlString += '<th>';
                }
                else if (IsWorking == 3) {
                    htmlString += "<th class='weekcolumnred'>";
                }
                else if (IsWorking == 5) {
                    htmlString += "<th class='weekcolumnred exapnd_and_collaps_column weekdayscol'>";
                }
                else {
                    htmlString += "<th>";
                }
                htmlString += '' + EntryDate + ',<span>' + DayName + '</span>'
                if (IsWorking == 2) {
                    htmlString += '<i data-toggle="tooltip" data-container="body" data-placement="bottom" title="Expand/Collapse To View Weekend " class="click-me fas fa-caret-left"></i>'
                }
                else if (IsWorking == 5) {
                    htmlString += '<i data-toggle="tooltip" data-container="body" data-placement="bottom" title="Expand/Collapse To View Weekend " class="click-me fas fa-caret-left" style="color:black !important;"></i>'
                }
                htmlString += "</th>";
            }
            if (IsWeekendPresent == 1 && TotalHoliday != 0)
                htmlString += '<th class="exapnd_and_collaps_column">Weekly<span>total</span><i data-toggle="tooltip" data-container="body" data-placement="bottom" title="Expand/Collapse To View Weekend " class="click-me fas fa-caret-right"></i></th>';
            else
                htmlString += '<th>Weekly<span>total</span></th>';

            htmlString += '<th>% Work Complete</th>'
            htmlString += '<th>Task Complete</th>'
            if (PageFlag == 3) {
                htmlString += '<th>Action</th>'
            }
            htmlString += "</tr>";
            htmlString += '<tr class="table_row_divider">'

            if (TotalHoliday == 2)
                htmlString += '<td colspan="10">&nbsp;</td>';
            else if (TotalHoliday == 3)
                htmlString += '<td colspan="9">&nbsp;</td>';
            else if (TotalHoliday == 4)
                htmlString += '<td colspan="8">&nbsp;</td>';
            else if (TotalHoliday == 5)
                htmlString += '<td colspan="7">&nbsp;</td>';
            else if (TotalHoliday == 6)
                htmlString += '<td colspan="6">&nbsp;</td>';
            else if (TotalHoliday == 7)
                htmlString += '<td colspan="5">&nbsp;</td>';
            else
                htmlString += '<td colspan="10">&nbsp;</td>';

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

            $(".click-me ").click(function () {




                //var temp=$("table.timesheettable tr th.toggleDisplay");
                //$("table.timesheettable tr th").each(function(i,v) {
                //    temp[i].width=v.width;
                //});

                //                 var firstTableWidth = [];
                //               
                //$('.table th').each(function(i, item) {
                //  firstTableWidth.push($(this).attr("width"));
                //})

                //                 $('.table th.toggleDisplay').each(function (i, item) {
                //                     $(this).attr("width", firstTableWidth[i]);
                //                 });


                //             var $tableBodyCell = $('.timesheettable .table tr th.toggleDisplay');
                //            
                //var $headerCell = $('.timesheettable .table tr th');
                //$tableBodyCell.each(function(index){
                //     $headerCell.eq(index).width($(this).width());
                //});







            });

        }
        //Added By Usha Pandit On 03.03.2021 For Note regarding efforts change
        var actualHoursSum = 0.0;
        var updatedAllTotal = 0.0;
        var curStatus = '';
        //Added By Usha Pandit On 03.03.2021 For Note regarding efforts change
        function PlotTAHeaderSection(GetActualExpectedHours) {
           //debugger
            var Status = "NOT SUBMITTED";
            if (GetActualExpectedHours != null) {
                var ActualHours = GetActualExpectedHours.ActualHours;
                var ExpectedHours = GetActualExpectedHours.ExpectedHours;
                Status = GetActualExpectedHours.Status;
                if (Status.toUpperCase() == "READY FOR APPROVAL")
                    Status = "Submitted";
                var EmployeeName = GetActualExpectedHours.EmployeeName;
                // alert(ActualHours);
                $(".ActualHours").html(ActualHours);
                $(".ExpectedHours").html(ExpectedHours);
                $(".Status").html(Status);
                //Added By Usha Pandit On 03.03.2021 For Note regarding efforts change
                actualHoursSum = ActualHours;
                curStatus = Status;
                //Added By Usha Pandit On 03.03.2021 For Note regarding efforts change
                
                //if (Status.toUpperCase() == "REJECTED") { $("#DivAction").css("display", "none");}
            }
           
            if (GetActualExpectedHours == null) {

                $(".Status").html("Not Submitted");
                $(".ActualHours").html("0");

                // if (GetActualExpectedHours.ExpectedHours != null) {

                //}
            } else {
                $(".ExpectedHours").html(GetActualExpectedHours.ExpectedHours);
            }

            if (Status.toUpperCase() == "" || Status.toUpperCase() == "SUBMITTED" || Status.toUpperCase() == "APPROVED") {
                $("#ulVTEdit").attr('style', 'display:none');
                $("#ulBackButton").attr('style', 'display:block');

            }
            else {
                $("#ulVTEdit").attr('style', 'display:block');
                $("#ulBackButton").attr('style', 'display:none');
            }

            if (Status.toUpperCase() == "REJECTED" || Status.toUpperCase() == "NOT SUBMITTED") { $("#btnSubmit").css('display', 'inline-block'); }

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

        ////$("#hdScrollfixedtbl1 #Tapprovalall").click(function () {
        ////    //
        ////    if (this.checked) {
        ////        $("#fixedtbl1 input[type='checkbox']").attr("checked", true)

        ////    }
        ////    else {


        ////        $("#fixedtbl1 input[type='checkbox']").attr("checked", false)
        ////    }


        ////});

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

        function FilterAllProjectData(chk) {

            var checked = $(chk).is(':checked');
            $("#ProjectFilterList > li").find(".checkbox").prop("checked", checked);
            FilterProjectData();
        }
        function FilterProjectData() {

            ProjectIDList = "";
            var flag = 0;
            //var ProjectList = [];



            var ProjectList = document.getElementsByName("ProjectList");
            //$('#ProjectFilterList #checkAll').click(function (event) {  //on click 
            //    
            //    if (this.checked) {
            //        // flag = 0;
            //        $("#ProjectFilterList [type=checkbox]").prop("checked", true);
            //        ProjectList = document.getElementsByName("ProjectList");
            //    }
            //    else {
            //        //flag = 1;
            //        $("#ProjectFilterList [type=checkbox]").prop("checked", false);

            //    }
            //});



            for (var i = 0; i < ProjectList.length; i++) {
                //if (flag == 0) {
                //    ProjectList[i].checked = true;
                //}
                //else {


                //}
                if (ProjectList[i].checked == true) {
                    if (ProjectIDList == "") {
                        ProjectIDList += ProjectList[i].value;
                    }
                    else {
                        ProjectIDList += ',' + ProjectList[i].value;
                    }
                    //}
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
                async: false,
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
                    $("#txtSearchBoxTaskTypes").val("");
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
            //Added By Yasmin on 15th Feb 2019 For Projet type 
            $("input[type='checkbox'].clsProject").click(function () {

                var a = $("input[type='checkbox'].clsProject");
                if (a.length == a.filter(":checked").length) {

                    $("#ProjectFilterList #checkAll").prop('checked', true);


                }
            });
            //Added By Yasmin on 15th Feb 2019 For Projet type 
            $("input[type='checkbox'].clsTaskTypes").click(function () {


                var a = $("input[type='checkbox'].clsTaskTypes");
                if (a.length == a.filter(":checked").length) {

                    $("#chkAllTaskType").prop('checked', true);

                }
            });
            //Added By Yasmin on 15th Feb 2019 For task categories
            $("input[type='checkbox'].clsTaskCategorylist").click(function () {


                var a = $("input[type='checkbox'].clsTaskCategorylist");
                if (a.length == a.filter(":checked").length) {

                    $("#chkAllTaskCategory").prop('checked', true);

                }
            });
            //Added By Yasmin on 15th Feb 2019 For Priority
            $("input[type='checkbox'].clsTaskPriorityList").click(function () {


                var a = $("input[type='checkbox'].clsTaskPriorityList");
                if (a.length == a.filter(":checked").length) {

                    $("#TaskPriorityFilterList #chkAllTaskCategory").prop('checked', true);

                }
            });
            //Added By Yasmin on 15th Feb 2019 For Phase
            $("input[type='checkbox'].clsPhase").click(function () {


                var a = $("input[type='checkbox'].clsPhase");
                if (a.length == a.filter(":checked").length) {

                    $("#chkAllTaskPhase").prop('checked', true);

                }
            });
            //Added By Yasmin on 15th Feb 2019 For Milestone
            $("input[type='checkbox'].clsMilestone").click(function () {


                var a = $("input[type='checkbox'].clsMilestone");
                if (a.length == a.filter(":checked").length) {

                    $("#chkAllTaskMilestone").prop('checked', true);

                }
            });
            //Added By Yasmin on 15th Feb 2019 For Deliverable
            $("input[type='checkbox'].clsTaslDeleverable").click(function () {


                var a = $("input[type='checkbox'].clsTaslDeleverable");
                if (a.length == a.filter(":checked").length) {

                    $("#chkAllTaskDeliverable").prop('checked', true);

                }
            });
            //Added By Yasmin on 15th Feb 2019 For Deliverable
            $("input[type='checkbox'].clsTaskSubProject").click(function () {


                var a = $("input[type='checkbox'].clsTaskSubProject");
                if (a.length == a.filter(":checked").length) {

                    $("#chkAllTaskSubProject").prop('checked', true);

                }
            });
            //Added By Yasmin on 15th Feb 2019 For TaskModule
            $("input[type='checkbox'].clasTaskModule").click(function () {


                var a = $("input[type='checkbox'].clasTaskModule");
                if (a.length == a.filter(":checked").length) {

                    $("#chkAllTaskModule").prop('checked', true);

                }
            });

        }
        function PlotAdditionalTimeRequestData(TaskID, SubTaskTypeID) {
            var requestadditionaltimePopupHTML = "";
            $("#requestadditionaltimePopup").html(requestadditionaltimePopupHTML);
            var taskParameters = {
                TaskID: TaskID,
                SubTaskTypeID: SubTaskTypeID,
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
                    requestadditionaltimePopupHTML +=  ConvertToDecimal(work);
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
                    //requestadditionaltimePopupHTML += '                                        <input class="form-control" id="txtETC" type="text" value="' + ETC + '" placeholder="Enter Request Efforts" name="" >';
                    //requestadditionaltimePopupHTML += '                                        <input class="form-control" id="txtETC" type="text" value="" placeholder="Request Efforts" name=""  onkeypress="return isNumber(event,this.value,this)" maxlength="8">';
                    requestadditionaltimePopupHTML += '                                        <input class="form-control" id="txtETC" type="text" value="" placeholder="Request Efforts" name=""  onkeypress="" maxlength="5">';
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
                    // requestadditionaltimePopupHTML += '                                        <textarea id="txtReason" class="form-control" value=' + Reason + '>' + Reason + '</textarea>';
                    requestadditionaltimePopupHTML += '                                        <textarea id="txtReason" class="form-control" placeholder="Enter Reason"  value=' + Reason + ' ></textarea>';
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
                    requestadditionaltimePopupHTML += '                                <button class="btn btnyellow ml-1" onclick="ETC_Save()" id="btnETC">Request</button>';
                    requestadditionaltimePopupHTML += '                            </div>';
                    requestadditionaltimePopupHTML += '                        </div>';
                    requestadditionaltimePopupHTML += '                    </div>';
                    $("#requestadditionaltimePopup").html(requestadditionaltimePopupHTML);
                    AfterPlot();
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
        //Added By Usha Pandit On 17.04.2020 For getting project work hours
        function checkLCETotal(ProjectID, ETC) {            
            var result = false;
            var param = JSON.stringify(projectId = ProjectID);
            var ProjectBalanceEfforts = 0;
            //var strResult = AJAXCallWithResult("/api/Timesheet/GetProjectWorkHours", param, false);
            $.ajax({
                url: strUrl + '/api/Timesheet/GetProjectWorkHours',
                type: "POST",
                data: param,
                dataType: "json",
                async:false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (strResult) {
                    if (strResult != undefined) {
                       // debugger;
                        var ProjectEfforts = strResult.LCETotal;
                        var ProjectAllocatedEfforts = strResult.AllocatedLCETotal;
                        if (ProjectEfforts != "" && ProjectAllocatedEfforts != "") {
                            ProjectBalanceEfforts = ProjectEfforts - ProjectAllocatedEfforts;
                        }
                        
                        var curETC = ConvertToDecimal(ETC);
                        
                        if (parseFloat(curETC) > parseFloat(ProjectBalanceEfforts)) {
                            //Added By Dipali V ON 21st May 2020 For Issue ID 23359
                            if (ProjectBalanceEfforts != "") {
                                var RequestParameters = {
                                    WorkHrs: encodeURI(ProjectBalanceEfforts),
                                    Flag: encodeURI(1),
                                }
                                var param = JSON.stringify(RequestParameters);
                                var ProjectBalanceEfforts = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);

                            }
                            //End of Added By Dipali V ON 21st May 2020 For Issue ID 23359
                            if (ProjectBalanceEfforts != "") {
                                showAlert("The total requested work (hours) of the tasks should not exceed the project work hours.Balance work hours are (" + ProjectBalanceEfforts + ") ", "alert-danger");
                                result = false;
                            }
                        }
                        else {
                            result = true;
                        }
                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return result;
        }




        //Added By Dipali V ON 21st May 2020 For Issue ID 23359
          function AJAXCallWithResult(url, param, async) {

            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    //StopAjaxLoader("#WBSBody");
                    ajaxResult = data;
                },
                error: function (err) {
                    //StopAjaxLoader("#WBSBody");
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }
        //Added By Usha Pandit On 17.05.2021 For HHMM validation
        function HHMMETC() {
            var blnHMFormat = true;
            var objHMEffort = document.getElementById('txtETC');
            var objVal = objHMEffort.value;
            var objnewVal = objHMEffort.value;
            var checkFlag = 0;
            objHMEffort.value = objHMEffort.value.replace(":", ".");
            var isdigit = isNumeric(objHMEffort.value);
            objHMEffort.value = objVal;

            if (isdigit == false) {
                showAlert('Please Enter only positive numeric value For Request Time in H:M format.', 'alert-danger');
                objHMEffort.focus();
                blnHMFormat = false;
                objHMEffort.value = objVal;
                isValid = 1;
                checkFlag = 1;
            }
            if (checkFlag == 0) {
                if (objHMEffort.value.indexOf(":") == -1) {
                    objHMEffort.value = objnewVal + ':00';
                    objnewVal = objHMEffort.value;
                }

                if (objHMEffort.value.indexOf(":") != -1) {
                    objHMEffort.value = objHMEffort.value.replace(':', '.');
                }
            }
            var tempEffort = objHMEffort.value.replace('-', '');
            if (checkSpecialCharacter(tempEffort) == true) {
                showAlert('Request Time cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters', 'alert-danger');                
                objHMEffort.value = objVal;
                isValid = 1;
                checkFlag = 1;
            }
            if (blnHMFormat == true) {
                if (RestrictNonNumeric(document.getElementById('txtETC')) == true) {
                    showAlert('Please enter Request Time in H:M format.', 'alert-danger');                       
                    objHMEffort.value = objVal;
                    blnHMFormat = false;
                    isValid = 1;
                    checkFlag = 1;
                }
            }

            
            if (blnHMFormat == true) {
                objHMEffort.value = objHMEffort.value.replace('.', ':');

                var WorkHour = objHMEffort.value;

                WorkHour = WorkHour.trim();
                var idxColon = WorkHour.indexOf(':');

                var hrs = WorkHour.substring(0, idxColon);

                var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                if (mins.length == 1 && mins > 5) {
                    mins = mins + "0";
                }
                if (mins == "") {
                    //mins = "00";
                    showAlert("Please enter Request Time in H:M format.", "alert-danger");
                    objHMEffort.value = objVal;
                    blnHMFormat = false;
                    isValid = 1;
                    checkFlag = 1;
                }

                if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                    showAlert('Request Time should not be less than or equal to zero (0).', 'alert-danger');
                    blnHMFormat = false;
                    isValid = 1;
                    checkFlag = 1;
                }

                if (blnHMFormat == true) {
                    if (mins.length > 2) {
                        showAlert('Please enter minutes in two decimal and less than 60.', 'alert-danger');
                        blnHMFormat = false;
                        isValid = 1;
                        checkFlag = 1;
                    }
                }

                if (blnHMFormat == true) {
                    if (mins > 59 || mins < 0) {
                        showAlert('Please enter minutes between (0-59) range', 'alert-danger');
                        blnHMFormat = false;
                        isValid = 1;
                        checkFlag = 1;
                    }
                }
            }           
            return checkFlag;
        }
        function checkSpecialCharacter(value) {
            var regularExpression = '{}|`~[]<>\!"@#$%^&*()_+-=/';
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
       
        //End Of Added By Usha Pandit On 17.05.2021 For HHMM validation
        //End Of Added By Usha Pandit On 17.04.2020 For getting project work hours
        function ETC_Save() {
           
            //Added By Chetan M On 17 jully 2020 to avoid enter duplicate data  for IssueID = 25656
            // $("#btnETC").hide();
            //StartLoader("#bodyTSEntry");
            //End of Added By Chetan M On 17 jully 2020 to avoid enter duplicate data for IssueID = 25656
            var objtxtETC = document.getElementById('txtETC');
            var objtxtAllocatedWork = document.getElementById('txtAllocatedWork');
            var objtxtActualWork = document.getElementById('txtActualWork');
            var txtReason = document.getElementById("txtReason");
            var objRTselectdate = document.getElementById("RTselectdate");
            var objProjectID = document.getElementById("hdnProjectID");
            var objTaskID = document.getElementById("hdnTaskID");
            //objtxtETC.value=
            //Commented By Usha Pandit On 17.05.2021 For HHMM validation
            //objtxtETC.value = objtxtETC.value.replace(/:/g, ".");
            //End Of Commented By Usha Pandit On 17.05.2021 For HHMM validation
            //if (RestrictNonNumeric(objtxtETC) == true) {
            //    showAlert('Please enter a numeric value for the Request Time.', 'alert-danger');
            //    objtxtETC.focus();
            //    return false;
            //}
            if (objtxtETC.value == "0") {
                showAlert('The value of the Request Time cannot be 0.', 'alert-danger');
                objtxtETC.focus();
                return false;
            }
            //Added By Reshma on 25th Dec 2018 for issue
            if (objtxtETC.value == "") {
                showAlert('The value of the Request Time cannot be blank.', 'alert-danger');
                objtxtETC.focus();
                return false;
            }
            //Added By Usha Pandit On 17.05.2021 For HHMM validation
            if (objtxtETC.value != "") {
                var curFlag = HHMMETC();                
                if (curFlag == 1) {
                    return false;
                }
            }
            //End Of Added By Usha Pandit On 17.05.2021 For HHMM validation
            //End By Reshma on 25th Dec 2018 for issue
            //Commented By Usha Pandit On 17.05.2021 For HHMM validation
            //if (checkNumber(objtxtETC.value) == false) {
            //    showAlert('Please enter Request Time in proper hh:mm format.', 'alert-danger');
            //    objtxtETC.value = objtxtETC.value.split('.').join(':');
            //    objtxtETC.focus();
            //    return false;
            //}
           //End Of Commented By Usha Pandit On 17.05.2021 For HHMM validation
            //Added By Usha Pandit On 17.04.2020 For getting project work hours
            if (objtxtETC.value != "") {                
                if (checkLCETotal(objProjectID.value, objtxtETC.value) == false) {
                    objtxtETC.focus();                    
                    return false;
                }
            }
            //End Of Added By Usha Pandit On 17.04.2020 For getting project work hours
            if (GlobalHoursFlag == 1) {
                var minutes = objtxtETC.value.split('.');
                var p = minutes[0];
                var dec = minutes[1];
                if (dec == undefined) { dec = 0; }
                d = (dec - 0) / 60 + (p - 0);
            }
            else {
                var d = objtxtETC.value;
            }
            //
            // 
            //Added By Usha Pandit On 25.05.2021 For multiple of 15 validation 
            var RequestParameters = {
                WorkHrs: encodeURI(objtxtETC.value),
                Flag: encodeURI(2),
            }

            var paramHr = JSON.stringify(RequestParameters);
            var d = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", paramHr, false);
            //End Of Added By Usha Pandit On 25.05.2021 For multiple of 15 validation 

            if (MinDAENtryDisplay != "") {
                if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                    showAlert('Please specify the ETC (hrs) in multiples of ( ' + MinDAENtryDisplay + ' ) hours.  This is necessary because the user can only fill minimum of ' + MinDAENtryDisplay + ' hours in the timesheet.', 'alert-danger');
                    objtxtETC.focus();
                    return false;
                }
            }
            var ETCLowerLimit = 0;
            if ((objtxtAllocatedWork.value - 0) > ((objtxtActualWork.value - 0) + (objtxtETC.value - 0))) {
                ETCLowerLimit = ((objtxtActualWork.value - 0) + (objtxtETC.value - 0)) - (objtxtAllocatedWork.value - 0);
            }
            if ((objtxtETC.value - 0) < (ETCLowerLimit - 0)) {

                showAlert('The value of the Request Time cannot be lesser than ' + ETCLowerLimit + ' !!', 'alert-danger');
                objtxtETC.focus();
                return false;
            }
            var precision = objtxtETC.value.split(".")[1];
            if (precision == 60) {
                objtxtETC.value = (objtxtETC.value.split(".")[0] - 0) + 1;

            }


            if (txtReason.value.length > 200) {
                showAlert('You can enter 200 characters for Reason.', 'alert-danger');
                txtReason.focus();
                return false;

            }

            //Added By Reshma Chavan on 18 June 2021 For not saving Request additional Time Issue
            var txtETCValue = "";
             if (objtxtETC.value != "") {
                var RequestParameters = {
                    WorkHrs: encodeURI(objtxtETC.value),
                    Flag: encodeURI(2),
                }
                var param = JSON.stringify(RequestParameters);
                txtETCValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);

            }
            //End of Added By Reshma Chavan on 18 June 2021 For not saving Request additional Time Issue
            
            //Added By Usha Pandit On 17.05.2021 For loader issue
            $("#btnETC").hide();
            StartLoader("#bodyTSEntry");
            //End Of Added By Usha Pandit On 17.05.2021 For loader issue
            var taskParameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: objRTselectdate.value,
                ProjectID: objProjectID.value,
                TaskID: objTaskID.value,
                //Added By Reshma Chavan on 18 June 2021 For not saving Request additional Time Issue
                //Duration: objtxtETC.value,
                Duration: txtETCValue,
                //End of Added By Reshma Chavan on 18 June 2021 For not saving Request additional Time Issue
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
                    //
                    var flag = data.split("_Flag")[1];
                    var MessageID = data.split("_Flag")[0];
                    //Added By Dipali V On 22nd Jan 2019 For restrict multiple Entry Issue
                    $("#btnETC").attr("disabled", "disabled");
                    //End of Added By Dipali V On 22nd Jan 2019 For restrict multiple Entry Issue
                    if (flag == 1) {
                        //Commented And Added By Reshma Chavan on 7th Dec 2020 For Incorrect To EmailID on Mail Popup
                        //window.open('../Email/SendEmail.aspx?MessageID=20047&intETCRequestID=' + MessageID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                        window.open('../Email/SendEmail.aspx?MessageID=20047&intETCRequestID=' + MessageID + '&intProjectID='+ objProjectID.value +'', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                        //End of Commented And Added By Reshma Chavan on 7th Dec 2020 For Incorrect To EmailID on Mail Popup
                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
           
            //Added By Chetan M On 17 jully 2020 to avoid enter duplicate data for IssueID = 25656
             $("#btnETC").show();
            StopAjaxLoader("#bodyTSEntry");
            //End of Added By Chetan M On 17 jully 2020 to avoid enter duplicate data for IssueID = 25656
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
                   // debugger;
                  var TaskActualWork = PostWorkHrs.toString().replace('.', ':');
                     var fmtWork = 0;
                if (TaskActualWork.length == 1) {
                    fmtWork = '0' + TaskActualWork + ':00';
                    TaskActualWork = fmtWork;
                }
                if (TaskActualWork.length == 2) {
                    fmtWork = TaskActualWork + ':00';
                    TaskActualWork = fmtWork;
                }
                if (TaskActualWork.length == 3) {
                    fmtWork = TaskActualWork.replace('.', ':');
                    fmtindx = fmtWork.indexOf(':');
                    if (fmtindx == 1) {
                        TaskActualWork = '0' + fmtWork + '0';
                    }
                    if (fmtindx == -1) {
                        TaskActualWork = TaskActualWork + ':00';
                    }
                }
                if (TaskActualWork.length == 4) {
                    fmtWork = TaskActualWork.replace('.', ':');
                    fmtindx = fmtWork.indexOf(':');
                    if (fmtindx == 2)
                        TaskActualWork = '' + fmtWork + '0';
                    if (fmtindx == 1)
                        TaskActualWork = '0' + fmtWork + '';
                }
                if (TaskActualWork.length == 5) {
                    //
                    fmtWork = TaskActualWork.replace('.', ':');
                    fmtindx = fmtWork.indexOf(':');
                    if (fmtindx == 3) {
                        TaskActualWork = fmtWork + '0';
                    }
                    else {
                        TaskActualWork = fmtWork;
                    }
                    }
                    PostWorkHrs = TaskActualWork;

                    ScheduleTSEntryHTML += '<div class="form-group">';
                    ScheduleTSEntryHTML += '<div class="row">';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-5 text-right">Start Date:</div>';
                    ScheduleTSEntryHTML += '<div class="col-xs-12 col-sm-7">';
                    ScheduleTSEntryHTML += '<div class="row">';
                    ScheduleTSEntryHTML += '<div class="col-xs-10">';
                    if (StartDate != "") {
                        ScheduleTSEntryHTML += '<input id="STselectdate" type="text" class="form-control" name="" placeholder="Select Date" value="' + StartDate.split(' ')[0] + '" >';
                    }
                    else {
                        ScheduleTSEntryHTML += '<input id="STselectdate" type="text" class="form-control" name="" placeholder="Select Date"  value="' + StartDate.split(' ')[0] + '" >';
                    }
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
                    ScheduleTSEntryHTML += '<input class="notexfieldstyle form-control" type="text" id="HoursToPost" placeholder=' + PostWorkHrs + ' value=' + PostWorkHrs + '   onkeypress="return isNumber(event,this.value,this)" maxlength="5">';
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
                    if (PostEndDate == "") {
                        ScheduleTSEntryHTML += '<button class="btn savebtn btnyellow ml-1" onclick="ScheduleTS_Save(1)">Schedule</button>';
                    }
                    else {
                        ScheduleTSEntryHTML += '<button id="btnScheduleTSUpdate"  class="btn savebtn btnyellow ml-1" onclick="ShowConformation()">Update</button>';
                        ScheduleTSEntryHTML += '<button id="btnScheduleTSDelete" class="btn savebtn btnyellow ml-1" onclick="ScheduleTS_Delete(' + TaskID + ')">Delete</button>';
                    }


                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';
                    ScheduleTSEntryHTML += '</div>';

                    $("#ScheduleTSEntryForm").html(ScheduleTSEntryHTML);

                    AfterPlot();

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
        var Msg = "";
        var IsValid = 0;
        function ScheduleTS_Save(flag) {
            //
            var objHoursToPost = document.getElementById("HoursToPost");
            var objSTselectdate = document.getElementById("STselectdate");
            var objSTpostdate = document.getElementById("STpostdate");
            var objhdnAllocatedWork = document.getElementById("hdnAllocatedWork");
            var objchkCloseTask = document.getElementById("chkCloseTask");
            var objTaskID = document.getElementById("hdnTaskID");
            objHoursToPost.value = objHoursToPost.value.replace(/:/g, ".");
            
            if (parseFloat(objHoursToPost.value) <= 0) {
                showAlert('Value should be greater than zero !', "alert-danger");
                //Added By Rutuja D. on 16 April 2020 For IssueID = 23585
                objHoursToPost.value = objHoursToPost.value.replace(".", ":");
                //End Added By Rutuja D. on 16 April 2020 For IssueID = 23585

                return false;
            }
            if (objHoursToPost.value == "") {
                showAlert('Post Effort On Working Day should not be blank !', "alert-danger");
                // Added By Rutuja D. on 16 April 2020 For IssueID = 23585
                 objHoursToPost.value = objHoursToPost.value.replace(".", ":");
                //End Added By Rutuja D. on 16 April 2020 For IssueID = 23585

                return false;
            }
            if (RestrictNonNumeric(objHoursToPost) == true) {
                showAlert('Please enter numeric value !', 'alert-danger');
                // Added By Rutuja D. on 16 April 2020 For IssueID = 23585
             objHoursToPost.value = objHoursToPost.value.replace(".", ":");
                //End Added By Rutuja D. on 16 April 2020 For IssueID = 23585

                return false;
            }
            if (parseFloat(objHoursToPost.value) > 24) {
                //showAlert('The range for actual working hours is 0-24.', "alert-danger");
                showAlert('The range for actual working hours is 1-24.', "alert-danger");
                // Added By Rutuja D. on 16 April 2020 For IssueID = 23585

                objHoursToPost.value = objHoursToPost.value.replace(".", ":");
                //End Added By Rutuja D. on 16 April 2020 For IssueID = 23585

                return false;
            }
            if (parseFloat(objhdnAllocatedWork.value) < parseFloat(objHoursToPost.value)) {
                showAlert('Post effort should be less than or equal to allocated work hours !', "alert-danger");
                objHoursToPost.value = objHoursToPost.value.replace(".", ":");
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
            //Added By Dipali V On 21st jan 2019 For Validation
            if (objSTpostdate.value != "") {
                var nowDate = new Date();
                if (new Date(objSTselectdate.value) > new Date(objSTpostdate.value)) {
                    showAlert('Post till date should be greater Start date.', 'alert-danger');
                    return false;
                }
            }

            if (GlobalRestrictByMinHours == 1) {
                if (GlobalHoursFlag == 1) {
                    var minutes = objHoursToPost.value.split('.');
                    var p = minutes[0];
                    var dec = minutes[1];
                    if (dec == undefined) { dec = 0; }
                    d = (dec - 0) / 60 + (p - 0);
                }
                else {
                    var d = objHoursToPost.value;
                }
                //if (parseInt(d, 10) % MinDAEntry !== 0) {
                //    showAlert('Please enter hours complete in multiples of ' + MinDAENtryDisplay, 'alert-danger');
                //    Isvalid = 1;
                //}
                if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                    showAlert('Please enter hours complete in multiples of ' + MinDAENtryDisplay, 'alert-danger');
                    Isvalid = 1;
                    return false;
                }
            }

            //End of Added By Dipali V On 21st jan 2019 For Validation
            var taskParameters = {
                TaskID: objTaskID.value,
                dtFromDate: objSTselectdate.value,
                dtToDate: objSTpostdate.value
            }

            //Commented & Added by Sagar N on 27-Dec-2018 for ISSUE ID:16625
            //$.ajax({
            //    url: strUrl + '/api/Timesheet/ValidateScheduleTask',
            //    type: "POST",
            //    data: JSON.stringify(taskParameters),
            //    dataType: "json",
            //    contentType: "application/json;charset-utf=8",
            //    beforeSend: function (xhr) {
            //        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
            //    },
            //    success: function (data) {
            //         

            //        if (data != "") {
            //            showAlert(data, 'alert-danger');
            //            alert(data)
            //            flag = 1;
            //            return false;
            //        }
            //        else {

            //            var taskParameters = {
            //                TaskID: objTaskID.value,
            //                intEmployeeID: EmployeeID,
            //                dtFromDate: objSTselectdate.value,
            //                dtToDate: objSTpostdate.value,
            //                Duration: objHoursToPost.value,
            //                IsTaskComplete: objchkCloseTask.checked,
            //                bitFlag: flag
            //            }
            //            $.ajax({
            //                url: strUrl + '/api/Timesheet/SaveScheduledTask',
            //                type: "POST",
            //                data: JSON.stringify(taskParameters),
            //                dataType: "json",
            //                contentType: "application/json;charset-utf=8",
            //                beforeSend: function (xhr) {
            //                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
            //                },
            //                success: function (data) {
            //                    if (data == -1) {
            //                        showAlert('Scheduled task saved successfully.', 'alert-success', 'btnSave');
            //                    }
            //                },
            //                error: function (err) {
            //                    console.log(err);
            //                }
            //            });
            //            ReloadData(EmployeeID);
            //        }
            //    },

            //    error: function (err) {
            //        console.log(err);
            //    }
            //});

            $.ajax({
                url: strUrl + '/api/Timesheet/ValidateScheduleTask',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {

                    if (data != "") {
                        Msg = data;
                        IsValid = 1

                    }

                    //if (data != "") {
                    //    showAlert(data, 'alert-danger');
                    //    return false;
                    //}
                    //else {
                    //    ReloadData(EmployeeID);
                    //}
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

            if (IsValid == 1) {
                showAlert(Msg, 'alert-danger');
                return false;
            } else {



                //return;
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
                    async: false,
                    data: JSON.stringify(taskParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (data) {
                        if (data == -1) {
                            showAlert('Scheduled task saved successfully.', 'alert-success', 'btnSave');
                            if (isWeeklyView == 1) {
                                (PageFlag == 2 ? ReloadTApprovalData(EmployeeID) : ReloadData(EmployeeID))
                            }
                            else {
                                plotDailyTaskList(intEmployeeID);
                            }
                            $("#Schedule").modal('hide');
                        }
                    },
                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
        }

        function ShowConformation() {
            $("#ConfirmationMsgsch").html("Are you sure to update the record?");
            $("#ConfirmMessagemodalinfoSch").modal('show');

        }

        function SendConfirmationResponsesch(response) {
            //
            //alert();
            if (response == 0) {
                $("#ConfirmMessagemodalinfoSch").modal('hide');
                $("#Schedule").modal('hide');
            }
            else {

            }
        }

        var ScheduleTaskID;
        function ScheduleTS_Delete(TaskID) {
            ScheduleTaskID = TaskID;
            $("#btnScheduleTSDelete").attr('data-toggle', 'modal');
            $("#btnScheduleTSDelete").attr('data-target', '#deleteinfomodal');
        }
        function DeleteData() {
            var taskParameters = {
                TaskID: ScheduleTaskID
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/DeleteScheduleTask',
                type: "POST",
                async: false,
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    if (data == -1) {
                        showAlert('Scheduled task deleted successfully.', 'alert-success');
                    }
                    $("#deleteinfomodal").modal('hide');
                    $("#Schedule").modal('hide');
                    ReloadData(EmployeeID);
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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
                        //Added By Dipali V On 3rd Apr 2019 For SubTask Type not mapped to Task Type
                        if (SubTaskType != "") {
                            subtaskListHTML += '<tr>';
                            subtaskListHTML += '<td>';
                            subtaskListHTML += '<div class="custom_chckbox">';
                            subtaskListHTML += '<input type="hidden" id="hdnTaskForSubTask" value=' + TaskID + '>';
                            subtaskListHTML += '<input type="checkbox" name="chkSubTask" id="chkSubTask_' + SubTaskTypeID + '" value=' + SubTaskTypeID + ' class="Subtask">';
                            subtaskListHTML += '<label for="chkSubTask_' + SubTaskTypeID + '"></label>';
                            subtaskListHTML += '</div>';
                            subtaskListHTML += '</td>';
                            subtaskListHTML += '<td>' + SubTaskType + '</td>';
                            subtaskListHTML += '</tr>';
                            //End of Added By Dipali V On 3rd Apr 2019 For SubTask Type not mapped to Task Type
                        }

                    }
                    if (ProjectName != undefined && TaskName != undefined) {
                        $("#subTaskListPopupProjectName").html("Project Name : " + ProjectName);
                        $("#subTaskListPopupTaskName").html("Task Name : " + TaskName);
                    }
                    $("#SubTaskListTable").html(subtaskListHTML);
                    //Added By Dipali V On 3rd April 2019 For CheckBox All Issue for Subtask
                    $("input[type='checkbox'].Subtask").click(function () {
                        var a = $("input[type='checkbox'].Subtask");
                        if (a.length == a.filter(":checked").length) {

                            $("#chkSubTask").prop('checked', true);

                        }
                        else {
                            $("#chkSubTask").prop('checked', false);
                        }
                        //End of Added By Dipali V On 3rd April 2019 For CheckBox All Issue for Subtask
                    });
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
        var noData = 0;
        function GetFilterResultCount() {
            //
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
                 //Add By Dipali V On 23th For Remove Tooltip
                    $("#txtQuickEntry").blur();
                //End of Add By Dipali V On 23th For Remove Tooltip
                return false;
            }
            else {
                //Commented By Dipali V On 26th March 2020 For Data Bind late(Performance Issue)
                //$('#entryfiltermodalinfo').modal('show');
                //End Of Commented By Dipali V On 26th March 2020 For Data Bind late(Performance Issue)
            }
            StartLoader("#bodyTSEntry");//Added By Dipali V ON 26thMarch 2020 for Performance issue
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
            StopAjaxLoader("#bodyTSEntry")//Added by Dipali V On 26th March 2020 For Perfomance issues
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
                    //Added By Dipali V On 26th March 2020 For Data Bind late(Performance Issue)
                    $('#entryfiltermodalinfo').modal('show');
                     //End of Added By Dipali V On 26th March 2020 For Data Bind late(Performance Issue)
                    $("#FilterResultMsg").html("Your filter result returned " + data + " records. Do you want to view them?");
                    if (data == 0) {
                        // 
                        // noData = 1;
                        $("#AdvanFilterNo").attr("disabled", "disabled");
                        $("#AdvanFilterYes").attr("disabled", "disabled")
                        //$("#AdvanFilterNo").hover("background", "white");

                        //}, function () {
                        //    $(this).css("background-color", "pink");

                    } else {
                        $("#AdvanFilterNo").removeAttr("disabled", "");
                        $("#AdvanFilterYes").removeAttr("disabled", "")
                    }


                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });


        }



        //if (noData == 0) {
        //    $("#AdvanFilterNo").hover(function () {
        //        alert();
        //          $(this).css("background-color", "white");
        //      });

        //  }


        //Added By Usha Pandit On 03.03.2021 For filter issue
        //function PlotFilterTaskList(ProjectID) {
        function PlotFilterTaskList(ProjectID, eve) {
            //Added By Usha Pandit On 03.03.2021 For filter issue
            //debugger;
            //  $("#btnMoreProjects").prop("disabled", true);
            // $("#btnMoreProjects").css('pointer-events', 'none');
            $("#Tapprovalall").prop("checked", false);
            $("#projecttasksearch").val("");
            //added By dipali V On 22nd May 2019 for Clear Flilter
            $("#TaskCategoriesSearch").val("");
           // $("#divTaskCategories").attr("");
           //Added By Usha Pandit On 03.03.2021 For filter issue
            if (eve != undefined) {                
                if ($(eve).attr("id") == "AdvanFilterYes") {
                    modalDismiss = true;
                }
            }
            //Added By Usha Pandit On 03.03.2021 For filter issue
            //End of added By dipali V On 22nd May 2019 for Clear Flilter
            // 
            //Added By Dipali V On 2nd Jan 2019 For Closed Pop_up Issue
            //if ($("#modaltaskfilte").hasClass('in')) {

            //    $("#modaltaskfilte").removeClass('in')
            //    //$("#selectprojecttask .fas").css("color", "black!important");
            //    //$("#selectprojecttask .fas").css("background", "white!important");
            //    //Added By Dipali V On 21nd Jan 2019 For Removing selected filter
            //    $("i.fas.fa-filter").attr("aria-expanded", "false");
            //     $("#btnMoreProjects").prop("disabled", false);
            //    //End of Added By Dipali V On 21nd Jan 2019 For Removing selected filter
            //} else {
            //   $("#btnMoreProjects").prop("disabled", false);

            //}
            //End of Added By Dipali V On 2nd Jan 2019 For Closed Pop_up Issue
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

           // debugger;
            if (ProjectID != 0) {
                ProjectIDList = '';
                ProjectIDList = ProjectID;
                document.getElementById('cboFilteredProject').value = ProjectID;
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
            //Added by Chetan M on 6th Aug 2020 for project get selected on project dropdown.
            var gblProjectID = 0;
            //End of Added by Chetan M on 6th Aug 2020 for project get selected on project dropdown.
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


            // $("#btnMoreProjects").prop("disabled", false);


            $.ajax({
                url: strUrl + '/api/Timesheet/GetProjectDropdownValuesForFilter',
                type: "POST",
                data: JSON.stringify(taskParameters),
                async: false,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    var selHTML = "";
                    var COUNT = "";
                   // debugger;
                    //selHTML += "<option selected  value=''>Select Project</option>"c
                    for (var i = 0; i < data.length; i++) {
                      //  COUNT = COUNT = +1;
                        var d = data[i];
                        var ProjectID = d.ProjectID;
                        var ProjectName = d.ProjectName;
                        selHTML += "<option title='" + ProjectName + "' value='" + ProjectID + "'>" + ProjectName + "</option>";
                        COUNT = ProjectName
                    }
                   //alert(data.length);
                    //Commnted & Added By Dipali V On 13th May 2020 For Issues ID 24351
                    // if (data == "") {
                    if (COUNT == "--Select Project--") {
                   
                         //End of Commnted & Added By Dipali V On 13th May 2020 For Issues ID 24351
                        //showAlert("Resource is not assigned with any project.", "alert-danger");
                        setTimeout(function () {

                            showAlert("Resource is not assigned with any project.", "alert-danger");
                        }, 3000);
                        return false;

                    } else {
                        $("#selectprojecttask").modal('show');
                    }
                    $("#cboFilteredProject").html(selHTML);                    
                    $(".selectpicker").selectpicker('refresh');
                    //Added by Chetan M on 6th Aug 2020 for project get selected on project dropdown.
                    //Commented By Usha Pandit On 21.12.2020 For not showing task if project is not in session
                    //if (data.length == 2) {
                    //    for (var k = 0; k < data.length; k++) {
                    //       // debugger
                    //        var ProjectID1 = data[k].ProjectID;
                    //        if (ProjectID1 != "0") {
                    //            ProjectID = ProjectID1;
                    //            gblProjectID = ProjectID1;                    
                    //            ProjectFilterDrop_OnChange(ProjectID1);                                
                    //        }
                    //    }                     
                    //}
                    //$(".selectpicker").selectpicker('refresh');
                    //End Of Commented By Usha Pandit On 21.12.2020 For not showing task if project is not in session
                    //End of Added by Chetan M on 6th Aug 2020 for project get selected on project dropdown.
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            //cOMMENTED & added by Dipali V On 17th Dec 2020 For Session project should get selected with rest task
           //Added by Chetan M on 6th Aug 2020 for project get selected on project dropdown.
            ProjectID = gblProjectID;
            var ProjectID1 = '<%= Session("intProjectID") %>';
            //End of Added by Chetan M on 6th Aug 2020 for project get selected on project dropdown.
            //alert(ProjectID1);
            if (ProjectID1 != 0) {
                $('select[name=cboFilteredProject]').val(ProjectID1);
                 //    document.getElementById('cboFilteredProject').disabled = true;
                $(".selectpicker").selectpicker('refresh');
                 ProjectFilterDrop_OnChange(ProjectID1);
            }
           //Added by Dipali V On 23th March for Selected Filter Project Name Should display as selected
            if (ProjectIDList != "") {
                if (ProjectIDList.indexOf(",") != -1) {

                }
                else {
                    // if (ProjectIDLists.toString.length == 1) {
                    ProjectFilterDrop_OnChange(ProjectIDList);
                    $('select[name=cboFilteredProject]').val(ProjectIDList);
                    $(".selectpicker").selectpicker('refresh');
                    // }
                }
            }
            //End of Added by Dipali V On 23th March for Selected Filter Project Name Should display as selected
            //}
            //else {
            //    document.getElementById('cboFilteredProject').disabled = false;
            //    $(".selectpicker").selectpicker('refresh');
            //}
             //End of cOMMENTED & added by Dipali V On 17th Dec 2020 For Session project should get selected with rest task
            //FilterTaskCategories
            $.ajax({
                url: strUrl + '/api/Timesheet/GetTaskCategories',
                type: "POST",
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    $("#FilterTaskCategories").html('');
                    var strHTML = "";
                    if (data.length != 0) {
                        strHTML += '<li class="optgroup">';
                        strHTML += ' <span class="optgroup-header">';
                        strHTML += ' <input id="checkAll" class="checkbox checkAll" type="checkbox" onchange="TaskCategory_SelectAll(this)">All <span class="subtext"></span>';
                        strHTML += '</span>';
                        strHTML += '</li>';

                    }
                    for (var i = 0; i < data.length; i++) {
                        var TaskCategoryObject = data[i];
                        var ID = TaskCategoryObject.ID;
                        var Value = TaskCategoryObject.Value;

                        if (TaskCategoryList != "") {
                            if (TaskCategoryList.indexOf(ID) > -1) {
                                strHTML += '<li class="filter-item items" data-filter="' + Value + '" data-value="' + ID + '">';
                                strHTML += '<input type="checkbox" class="clsFilterTaskCategoryList" name="FilterTaskCategoryList" value="' + ID + '" onchange="TaskCategory_OnChange()">';
                                strHTML += "" + Value + "</li>";
                            }
                        }
                        else {
                            strHTML += '<li class="filter-item items" data-filter="' + Value + '" data-value="' + ID + '">';
                            strHTML += '<input type="checkbox" class="clsFilterTaskCategoryList" name="FilterTaskCategoryList" value="' + ID + '" onchange="TaskCategory_OnChange()">';
                            strHTML += "" + Value + "</li>";
                        }
                    }
                    $("#FilterTaskCategories").html(strHTML);

                    AfterPlot();
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

            if (ProjectID != 0) {
                PlotTaskList(taskParameters, 1);
            }
            //Added By Dipali V On 23th March 2021 For As per filter Data should list out
            else if (ProjectIDList != 0) {
                PlotTaskList(taskParameters, 0);
            }
            //End of Added By Dipali V On 23th March 2021 For As per filter Data should list out
            $('[data-toggle="dropdown"]').tooltip();
            //
            //Added By Dipali V On 3rd April 2019 of Select all Issue of Task 
            $("input[type='checkbox'].task").click(function () {


                var a = $("input[type='checkbox'].task");
                if (a.length == a.filter(":checked").length) {

                    $("#Tapprovalall").prop('checked', true);

                }
                else {
                    $("#Tapprovalall").prop('checked', false);
                }
            });
            //End of Added By Dipali V On 3rd April 2019 of Select all Issue of Task 

          
        }
        function TaskCategory_SelectAll(element) {

            var checked = $(element).is(':checked');

            $(".clsFilterTaskCategoryList").prop("checked", checked);
            TaskCategory_OnChange();
        }
        function PlotTaskList(taskParameters, flag) {
           // alert(ProjectID);
            var taskFilterListHTML = "";
            $("#FilterTaskBody").html("");
            $("#ProjectCode").html("");
            $("#startdateandenddate").html("");
            $("#Tapprovalall").prop('checked', false);
            //if (ProjectID != 0) {
                $.ajax({
                    url: strUrl + '/api/Timesheet/GetTaskListFromAdvanceSearch',
                    type: "POST",
                    data: JSON.stringify(taskParameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (data) {
                        var filters = data;
                        //alert(filters.d);
                        var ProjectCode;
                        var ProjectStartDate;
                        var ProjectEndDate;
                        for (var i = 0; i < filters.length; i++) {
                           // debugger;
                            //if (filters[i].TaskName != "") {
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
                            var WhichTask = filters[i].WhichTask;
                            ProjectCode = filters[i].ProjectCode;
                            ProjectStartDate = filters[i].ProjectStartDate;
                            ProjectEndDate = filters[i].ProjectEndDate;

                            if (taskID != 0) {
                                taskFilterListHTML += '<tr>'
                                taskFilterListHTML += '<td>'
                                taskFilterListHTML += '<div class="custom_chckbox">'
                                taskFilterListHTML += '<input type="checkbox" id="FilterTaskList' + taskID + '" name="FilterTaskList" class="task" value="' + taskID + '">';
                                taskFilterListHTML += ' <label for="FilterTaskList' + taskID + '"></label>'
                                taskFilterListHTML += ' </div>'
                                taskFilterListHTML += '</td>';
                                taskFilterListHTML += '<td>';
                                taskFilterListHTML += '<div id="more' + taskID + '" class="more">' + taskName + '</div>';

                                taskFilterListHTML += '    <div class="dropdown modalprojectinfo">';
                                taskFilterListHTML += '<img title="Task Info" data-placement="left" data-container="body" class="dropdown-toggle pull-right " src="../../../Whizible2.0/dist/img/exclaim.svg" width="13px" alt="" data-toggle="dropdown" aria-expanded="true">';

                                taskFilterListHTML += '<div class="dropdown-menu modalpop_projectinfo" role="menu" aria-labelledby="menu1">';
                                taskFilterListHTML += '<div class="arrow-right"></div>';
                                taskFilterListHTML += '<div class="projecttaskinfo_tooltipbox">';
                                taskFilterListHTML += '<button type="button" class="close" data-toggle="collapse" aria-expanded="false">';
                                taskFilterListHTML += '<img width="20px" src="../../../Whizible2.0/dist/img/close-gray.svg"></button>';
                                taskFilterListHTML += '<div class="PTItooltipbox_hading" style="word-break: break-word;">';
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
                                if (WhichTask != 'D') {
                                    taskFilterListHTML += ' <div class="row">';
                                    taskFilterListHTML += '     <div class="col-xs-5">Allocated Work:</div>';
                                    taskFilterListHTML += '     <div class="col-xs-7">' + ConvertToDecimal(Work) + '</div>';
                                    taskFilterListHTML += ' </div>';
                                }
                                //alert(ActualWork);
                                //Added By Dipali V on 6th Oct 2021 For Get Actual work hours with 2 decimal
                                 var fmtWork = 0;
                                if (ActualWork.length == 1) {
                                    fmtWork = '0' + ActualWork + ':00';
                                    ActualWork = fmtWork;
                                }
                                if (ActualWork.length == 2) {
                                    fmtWork = ActualWork + ':00';
                                    ActualWork = fmtWork;
                                }
                                if (ActualWork.length == 3) {
                                    fmtWork = ActualWork.replace('.', ':');
                                    fmtindx = fmtWork.indexOf(':');
                                    if (fmtindx == 1) {
                                        ActualWork = '0' + fmtWork + '0';
                                    }
                                    if (fmtindx == -1) {
                                        ActualWork = ActualWork + ':00';
                                    }
                                }
                                if (ActualWork.length == 4) {
                                    fmtWork = ActualWork.replace('.', ':');
                                    fmtindx = fmtWork.indexOf(':');
                                    if (fmtindx == 2)
                                        ActualWork = '' + fmtWork + '0';
                                    if (fmtindx == 1)
                                        ActualWork = '0' + fmtWork + '';
                                }
                                if (ActualWork.length == 5) {
                                    //
                                    fmtWork = ActualWork.replace('.', ':');
                                    fmtindx = fmtWork.indexOf(':');
                                    if (fmtindx == 3) {
                                        ActualWork = fmtWork + '0';
                                    }
                                    else {
                                        ActualWork = fmtWork;
                                    }
                                }
                                if (ActualWork.length > 5) {
                                    fmtWork = ActualWork.replace('.', ':');
                                    fmtindx = fmtWork.indexOf(':');

                                    ActualWork = fmtWork;

                                }
                                //End of Added By Dipali V on 6th Oct 2021 For Get Actual work hours with 2 decimal

                                taskFilterListHTML += ' <div class="row">';
                                taskFilterListHTML += '     <div class="col-xs-5">Actual Work:</div>';
                                //Commented & Added By Dipali V on 6th Oct 2021 For Get Actual work hours with 2 decimal 
                                //taskFilterListHTML += '     <div class="col-xs-7">' + ConvertToDecimal(ActualWork) + '</div>';
                                taskFilterListHTML += '     <div class="col-xs-7">' + ActualWork + '</div>';
                                //End of Commented By Dipali V on 6th Oct 2021 For Get Actual work hours with 2 decimal
                                taskFilterListHTML += ' </div>';
                                taskFilterListHTML += '     </div>';
                                taskFilterListHTML += ' </div>';
                                taskFilterListHTML += ' <div class="col-sm-6 pl0 projecttaskinfo_tooltipbox_schedule_borderleft">';
                                taskFilterListHTML += '     <div class="projecttaskinfo_tooltipbox_schedule">';
                                if (Phase != '') {
                                    taskFilterListHTML += '         <div class="row">';
                                    taskFilterListHTML += '             <div class="col-xs-5">Phase:</div>';
                                    taskFilterListHTML += '             <div class="col-xs-7"><span class="issuetext" title="' + Phase + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + Phase + '</span></div>';
                                    taskFilterListHTML += '         </div>';
                                }
                                if (MileStone != '') {
                                    taskFilterListHTML += '         <div class="row">';
                                    taskFilterListHTML += '             <div class="col-xs-5">Milestone:</div>';
                                    taskFilterListHTML += '             <div class="col-xs-7"><span class="issuetext" title="' + MileStone + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + MileStone + '</span></div>';
                                    taskFilterListHTML += '         </div>';
                                }
                                if (SubProjectName != '') {
                                    taskFilterListHTML += '         <div class="row">';
                                    taskFilterListHTML += '             <div class="col-xs-5">Sub Project:</div>';
                                    taskFilterListHTML += '             <div class="col-xs-7"><span class="issuetext" title="' + SubProjectName + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + SubProjectName + '</span></div>';
                                    taskFilterListHTML += '         </div>';
                                }
                                if (Issue != '') {
                                    taskFilterListHTML += '         <div class="row">';
                                    taskFilterListHTML += '             <div class="col-xs-5">Issue:</div>';
                                    taskFilterListHTML += '             <div class="col-xs-7"><span class="issuetext" title="' + Issue.replace("\"", "'") + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + Issue.replace("\"", "'") + '</span></div>';
                                    taskFilterListHTML += '         </div>';
                                }
                                if (DeliverableName != '') {
                                    taskFilterListHTML += '         <div class="row">';
                                    taskFilterListHTML += '             <div class="col-xs-5">Deliverable:</div>';
                                    taskFilterListHTML += '             <div class="col-xs-7"><span class="issuetext" title="' + DeliverableName + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + DeliverableName + '</span></div>';
                                    taskFilterListHTML += '         </div>';
                                }
                                if (ModuleName != '') {
                                    taskFilterListHTML += '         <div class="row">';
                                    taskFilterListHTML += '             <div class="col-xs-5">Module:</div>';
                                    taskFilterListHTML += '             <div class="col-xs-7"><span class="issuetext" title="' + ModuleName + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + ModuleName + '</span></div>';
                                    taskFilterListHTML += '         </div>';
                                }
                                taskFilterListHTML += '     </div>';
                                taskFilterListHTML += '                    </div>';
                                taskFilterListHTML += '                </div>';
                                taskFilterListHTML += '            </div>';
                                taskFilterListHTML += '        </div>';
                                taskFilterListHTML += '    </div>';
                                taskFilterListHTML += '</td>';

                                taskFilterListHTML += '</tr>';
                            }
                        }

                        $("#FilterTaskBody").html(taskFilterListHTML);

                        AfterPlot();
                        if (flag == 1) {
                            if (taskParameters.FilterProjectID != 0) {
                                if (ProjectCode != undefined) {
                                    //$("#ProjectCode").html("Project ID: " + ProjectCode);//Commented & Added By Dipali V On 14th May 2020 
                                    $("#ProjectCode").html("Project Code : " + ProjectCode);
                                    var dateHTML = "";
                                    dateHTML += " Start Date: " + ProjectStartDate;
                                    dateHTML += "<br />";
                                    dateHTML += "End Date&nbsp;&nbsp;: " + ProjectEndDate;
                                    $("#startdateandenddate").html(dateHTML);
                                }
                            }
                        }
                        // 
                        //var taskdesc = $(".projecttaskinfo_tooltipbox p").text();
                        //if (taskdesc != "") {
                        //    $(".projecttaskinfo_tooltipbox p").css({"height": "300px", "overflow-y": "auto"});
                        //}
                        //Commented and added by Chetan M on 4th Aug 2020 for Issue ID : 25728
                        //var showChar = 75;  // How many characters are shown by default
                        var showChar = 100;  // How many characters are shown by default
                        //End of Commented and added by Chetan M on 4th Aug 2020 for Issue ID : 25728
                        var ellipsestext = "...";
                        var moretext = "more >";
                        var lesstext = "< less";


                        $('.more').each(function () {
                            var content = $(this).html();

                            if (content.length > showChar) {

                                var c = content.substr(0, showChar);
                                var h = content.substr(showChar, content.length - showChar);

                                var html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="#" class="morelink">' + moretext + '</a></span>';

                                $(this).html(html);
                            }

                        });


                        //Added by pradip_03-1-2018 for hide label when no data
                        $('.selectprojecttask .dropdown.modalprojectinfo img.dropdown-toggle').on('click', function (e) {

                            $(".modalpop_projectinfo .projecttaskinfo_tooltipbox_schedule .row .col-xs-7:empty").parent().hide();
                            //$(".projecttaskinfo_tooltipbox_schedule .row .issuetext:empty").parent().hide();
                            //if ($('.projecttaskinfo_tooltipbox_schedule .row .col-xs-7').is(':empty')) {                            
                            //    $('.modalpop_projectinfo .projecttaskinfo_tooltipbox_schedule_borderleft .projecttaskinfo_tooltipbox_schedule').hide()

                            //} else {
                            //    ('.modalpop_projectinfo .projecttaskinfo_tooltipbox_schedule_borderleft .projecttaskinfo_tooltipbox_schedule').show()
                            //}
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
                        //
                        // alert(taskFilterListHTML);
                        //$('#FilterTaskBody td.modalprojectinfo').on('click', function (e) {
                        //    alert("1");

                        //});

                    },
                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
           // }
        }
        function ProjectFilterDrop_OnChange(ProjectID) {
           
            $("#Tapprovalall").prop("checked", false);
            $("#projecttasksearch").val("");
            if (ProjectID != 0) {
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
                //debugger;
                //alert(ProjectID);
                PlotTaskList(taskParameters, 1);
                $("input[type='checkbox'].task").click(function () {


                    var a = $("input[type='checkbox'].task");
                    if (a.length == a.filter(":checked").length) {

                        $("#Tapprovalall").prop('checked', true);

                    }
                    else {
                        $("#Tapprovalall").prop('checked', false);
                    }
                });
            } else {
                $('#ProjectCode').html('');
                $('#startdateandenddate').html('');
                //Added By Usha Pandit On 21.12.2020 For not showing task if project is not selected
                $("#FilterTaskBody").html("");
                //End Of Added By Usha Pandit On 21.12.2020 For not showing task if project is not selected
            }
        }
        function TaskCategory_OnChange() {
            TaskCategoryList = "";
            //  
            //Added By dipali V On 8th Jan 2019 For All checkbox issue
            if ($(".clsFilterTaskCategoryList").prop('checked') == false) {
                //$("#checkAll").prop('checked', false);
                $("#divTaskCategories #checkAll").prop('checked', false);
            }
            //End of Added By dipali V On 8th Jan 2019 For All checkbox issue

            //Added By dipali V On 22nd Jan 2019 For All checkbox issue
            $("input[type='checkbox'].clsFilterTaskCategoryList").click(function () {

                var a = $("input[type='checkbox'].clsFilterTaskCategoryList");
                if (a.length == a.filter(":checked").length) {

                    $("#FilterTaskCategories #checkAll").prop('checked', true);

                }
            });

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
            if (TaskCategoryList == "") {
                if ($("#divTaskCategories #checkAll").prop('checked') == false) {
                    for (var i = 0; i < TaskCategory.length; i++) {
                        if (TaskCategoryList == "") {
                            TaskCategoryList += TaskCategory[i].value;
                        }
                        else {
                            TaskCategoryList += ',' + TaskCategory[i].value;
                        }
                    }
                }
            }
            var ProjectID = null;
            if ($("#cboFilteredProject").val() != '') {
                ProjectID = $("#cboFilteredProject").val()
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
                FilterProjectID: ProjectID,
            }
            PlotTaskList(taskParameters, 1);
            // 

        }
        var TaskIDList = "";
        function FilterTaskFromList() {
            //
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
            SubTaskTypeList = "";
            IsDefault = 1;
            if (isWeeklyView == 1)
                ReloadData(EmployeeID);
            else
                plotDailyTaskList(EmployeeID);
            $("#selectprojecttask").modal('hide');
            //$("#filterpanel").hide();
            //added by pradip
            $("#filterpanel").removeClass('in');
            $("body").css("padding-right", "0px!important");
            $("#modaltaskfilte").removeClass("in");
            //$("i.fas.fa-filter").attr("aria-expanded", "false");
            $(".optgroup-header input[type='checkbox']").attr("checked", false);
            //Added By Dipali V On 21nd Jan 2019 For Removing selected filter
            $("#AdvanceFilterIcon").attr("aria-expanded", "false");
            //End of Added By Dipali V On 21nd Jan 2019 For Removing selected filter
        }
        function plotProjectFilterSection(ProjectFilterLists) {
            $("#ProjectFilterList").html('');
            var strHTML = "";
            if (ProjectFilterLists.length != 0) {
                strHTML += '<li class="filter-item items">';
                strHTML += '<input id="checkAll" class="checkbox checkAll"  type="checkbox" onchange="FilterAllProjectData(this)">All <span class="subtext"></span>';
                strHTML += '</li>';
            }
            for (var i = 0; i < ProjectFilterLists.length; i++) {
                var ProjectObject = ProjectFilterLists[i];
                var ProjectID = ProjectObject.ProjectID;
                var ProjectName = ProjectObject.ProjectName;
                //Added BY Dipali V On 18th Jan 2020 For Issue ID 24353
                if (ProjectObject.ProjectName != "--Select Project--") {
                    strHTML += "<li class='filter-item items' data-filter='" + ProjectName + "' data-value='" + ProjectID + "'>";
                    strHTML += "<input class='checkbox clsProject' type='checkbox' name='ProjectList' onchange='FilterProjectData()' value='" + ProjectID + "'>";
                    strHTML += "" + ProjectName + "</li>";
                }
                 //END OF Added BY Dipali V On 18th Jan 2020 For Issue ID 24353
            }
            $("#ProjectFilterList").html(strHTML);
        }
        function plotTaskTypeFilterSection(TaskTypeFilterLists) {
            //Added By Usha Pandit On 03.03.2021 For filter issue
            var val = [];
            if (modalDismiss == true) {
                var cnt = 0;
                $("#TaskTypeFilterList > li").each(function (i) {
                    if ($(this).find(".checkbox").is(':checked')) {
                        val[cnt] = $(this).find(".checkbox").val();
                        cnt = cnt + 1;
                    }
                });
            }            
            //Added By Usha Pandit On 03.03.2021 For filter issue
            //
            var strHTML = "";
            $("#TaskTypeFilterList").html('');
            if (TaskTypeFilterLists.length != 0) {

                strHTML += '<li class="filter-item items">';
                strHTML += '<input class="checkbox checkAll" id="chkAllTaskType" onclick="SelectAllTaskType(this)" type="checkbox">All <span class="subtext"></span>';
                strHTML += '</li>';
            }
            for (var i = 0; i < TaskTypeFilterLists.length; i++) {
                var TaskTypeObject = TaskTypeFilterLists[i];
                var TaskTypeID = TaskTypeObject.TaskTypeID;
                var TaskType = TaskTypeObject.TaskType;

                strHTML += "<li class='filter-item items' data-filter='" + TaskType + "' data-value='" + TaskTypeID + "'>";
                strHTML += "<input class='checkbox clsTaskTypes' type='checkbox' name='TaskTypeList' value='" + TaskTypeID + "'>";
                strHTML += "" + TaskType + "</li>";
            }
            $("#TaskTypeFilterList").html(strHTML);
            //Added By Usha Pandit On 03.03.2021 For filter issue
            if (modalDismiss == true) {
                $("#TaskTypeFilterList > li").each(function (i) {                    
                    if (val != "" && val != undefined) {
                        for (var i = 0; i < val.length; i++) {
                            if ($(this).find(".checkbox").val() == val[i]) {
                                $(this).find(".checkbox").prop('checked', true);
                            }
                        }
                    }
                });
            }
            //Added By Usha Pandit On 03.03.2021 For filter issue
        }
        function plotCategoryFilterSection(TaskCategoryFilterLists) {
            $("#TaskCategoryFilterList").html('');
            var strHTML = "";
            //Added By Reshma for issue
            if (TaskCategoryFilterLists.length != 0) {
                strHTML += '<li class="filter-item items">';
                strHTML += '<input class="checkbox checkAll" id="chkAllTaskCategory" onclick="SelectAllTaskCategory(this)" type="checkbox">All <span class="subtext"></span>';
                strHTML += '</li>';
            }
            for (var i = 0; i < TaskCategoryFilterLists.length; i++) {
                var TaskCategoryObject = TaskCategoryFilterLists[i];
                var ID = TaskCategoryObject.ID;
                var Value = TaskCategoryObject.Value;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' class='clsTaskCategorylist' name='TaskCategoryList' value='" + ID + "'>";
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
            if (TaskPriorityFilterLists.length != 0) {
                strHTML += '<li class="filter-item items">';
                strHTML += '<input class="checkbox checkAll" id="chkAllTaskCategory" onclick="SelectAllTaskPriority(this)" type="checkbox">All <span class="subtext"></span>';
                strHTML += '</li>';
            }
            for (var i = 0; i < TaskPriorityFilterLists.length; i++) {
                var TaskPriorityObject = TaskPriorityFilterLists[i];
                var PriorityID = TaskPriorityObject.PriorityID;
                var Priority = TaskPriorityObject.Priority;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' class='clsTaskPriorityList' name='TaskPriorityList' value='" + PriorityID + "'>";
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
            if (PhaseFilterLists.length != 0) {
                $("#lblTaskPhaseFilterList").parent().css('display', 'block');
                //Added By Usha Pandit On 20.04.2020 For phase heading display issue if attributes not mapped to task
                $("#lblTaskPhaseFilterList").css('display', 'block');
                //End Of Added By Usha Pandit On 20.04.2020 For phase heading display issue if attributes not mapped to task
                strHTML += '<li class="filter-item items">';
                strHTML += '<input class="checkbox checkAll" id="chkAllTaskPhase" onclick="SelectAllTaskPhase(this)" type="checkbox">All <span class="subtext"></span>';
                strHTML += '</li>';
            }
            else {
                $("#lblTaskPhaseFilterList").parent().css('display', 'none');
            }
            for (var i = 0; i < PhaseFilterLists.length; i++) {
                var TaskPhaseObject = PhaseFilterLists[i];
                var PhaseID = TaskPhaseObject.PhaseID;
                var Phase = TaskPhaseObject.Phase;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' class='checkbox clsPhase' name='TaskPhaseList' value='" + PhaseID + "'>";
                strHTML += "" + Phase + "</li>";
            }
            $("#TaskPhaseFilterList").html(strHTML);
        }
        function plotMileStoneFilterSection(MileStoneFilterLists) {
            var strHTML = "";
            $("#TaskMilestoneFilterList").html('');            
            if (MileStoneFilterLists.length != 0) {
                $("#lblTaskMilestoneFilterList").parent().css('display', 'block');
                //Added By Usha Pandit On 20.04.2020 For phase heading display issue if attributes not mapped to task
                $("#lblTaskMilestoneFilterList").css('display', 'block');
                //End Of Added By Usha Pandit On 20.04.2020 For phase heading display issue if attributes not mapped to task
                strHTML += '<li class="filter-item items">';
                strHTML += '<input class="checkbox checkAll" id="chkAllTaskMilestone" onclick="SelectAllTaskMileStone(this)" type="checkbox">All <span class="subtext"></span>';
                strHTML += '</li>';
            }
            else {
                $("#lblTaskMilestoneFilterList").parent().css('display', 'none');
            }

            for (var i = 0; i < MileStoneFilterLists.length; i++) {
                var TaskMileStoneObject = MileStoneFilterLists[i];
                var MileStoneId = TaskMileStoneObject.MileStoneId;
                var MileStone = TaskMileStoneObject.MileStone;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' name='TaskMilestoneList' class='checkbox clsMilestone' value='" + MileStoneId + "'>";
                strHTML += "" + MileStone + "</li>";
            }
            $("#TaskMilestoneFilterList").html(strHTML);
        }
        function plotDeliverableFilterSection(DeliverableFilterLists) {
            $("#TaskDeliverableFilterList").html('');
            var strHTML = "";
            if (DeliverableFilterLists.length != 0) {
                $("#lblTaskDeliverableFilterList").parent().css('display', 'block');
                strHTML += '<li class="filter-item items">';
                strHTML += '<input class="checkbox checkAll" id="chkAllTaskDeliverable" onclick="SelectAllTaskDeliverable(this)" type="checkbox">All <span class="subtext"></span>';
                strHTML += '</li>';
            }
            else {
                $("#lblTaskDeliverableFilterList").parent().css('display', 'none');
            }
            for (var i = 0; i < DeliverableFilterLists.length; i++) {
                var TaskDeliverableObject = DeliverableFilterLists[i];
                var DeliverableID = TaskDeliverableObject.DeliverableID;
                var Title = TaskDeliverableObject.Title;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' class='checkbox clsTaslDeleverable' name='TaskDeliverableList' value='" + DeliverableID + "'>";
                strHTML += "" + Title + "</li>";
            }
            $("#TaskDeliverableFilterList").html(strHTML);
        }
        function plotSubProjectFilterSection(SubProjectFilterLists) {
            $("#TaskSubProjectFilterList").html('');
            var strHTML = "";
            if (SubProjectFilterLists.length != 0) {
                $("#lblTaskSubProjectFilterList").parent().css('display', 'block');
                strHTML += '<li class="filter-item items">';
                strHTML += '<input class="checkbox checkAll" id="chkAllTaskSubProject" onclick="SelectAllTaskSubProject(this)" type="checkbox">All <span class="subtext"></span>';
                strHTML += '</li>';
            }
            else {
                $("#lblTaskSubProjectFilterList").parent().css('display', 'none');
            }
            for (var i = 0; i < SubProjectFilterLists.length; i++) {
                var TaskSubProjectObject = SubProjectFilterLists[i];
                var SubProjectId = TaskSubProjectObject.SubProjectId;
                var SubProjectName = TaskSubProjectObject.SubProjectName;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' class='checkbox clsTaskSubProject' name='TaskSubProjectList' value='" + SubProjectId + "'>";
                strHTML += "" + SubProjectName + "</li>";
            }
            $("#TaskSubProjectFilterList").html(strHTML);
        }
        function plotModuleFilterSection(ModuleFilterLists) {
            $("#TaskModuleFilterList").html('');
            var strHTML = "";
            if (ModuleFilterLists.length != 0) {
                $("#lblTaskModuleFilterList").parent().css('display', 'block');
                strHTML += '<li class="filter-item items">';
                strHTML += '<input class="checkbox checkAll"  id="chkAllTaskModule" onclick="SelectAllTaskModule(this)" type="checkbox">All <span class="subtext"></span>';
                strHTML += '</li>';
            }
            else {
                $("#lblTaskModuleFilterList").parent().css('display', 'none');
            }
            for (var i = 0; i < ModuleFilterLists.length; i++) {
                var TaskModuleObject = ModuleFilterLists[i];
                var ModuleId = TaskModuleObject.ModuleId;
                var ModuleName = TaskModuleObject.ModuleName;

                strHTML += "<li>";
                strHTML += "<input type='checkbox' class='checkbox clasTaskModule'  name='TaskModuleList' value='" + ModuleId + "'>";
                strHTML += "" + ModuleName + "</li>";
            }
            $("#TaskModuleFilterList").html(strHTML);
        }
        function plotWeekTotal(WeekTotalLists) {
            $("#WeekTotal").html('');
            var strHTML = "";
            strHTML += "<th class='totalworkcountrow'>Total work for a Day</th>";
            if (PageFlag != 3) {
                strHTML += "<th name='QuickEntryHeader'><label class='pro_Calculate_count'>&nbsp;</label></th>";
            }
            var AllTotal;
            // alert();
            // 
            for (var i = 0; i <= WeekTotalLists.length - 1; i++) {
                var WeekTotalObject = WeekTotalLists[i];
                //var Total = WeekTotalObject.Total;

                //Commented and Added By Reshma for Issue
                var Total = '' + WeekTotalObject.Total + '';
                //alert(Total.length);
                if (Total.length == 1) {
                    var fmtTotal = '0' + Total + ':00';
                    Total = fmtTotal;
                }
                if (Total.length == 2) {
                    var fmtTotal = Total + ':00';
                    Total = fmtTotal;
                }
                if (Total.length == 3) {
                    var fmtTotal = Total.replace('.', ':');
                    fmtTotalx = fmtTotal.indexOf(':');
                    if (fmtTotalx == 1) {
                        Total = '0' + fmtTotal + '0';
                    }
                    if (fmtTotalx == -1) {
                        Total = Total + ':00';
                    }
                }
                if (Total.length == 4) {
                    var fmtTotal = Total.replace('.', ':');
                    fmtTotalx = fmtTotal.indexOf(':');
                    if (fmtTotalx == 2)
                        Total = '' + fmtTotal + '0';
                    if (fmtTotalx == 1)
                        Total = '0' + fmtTotal + '';
                }
                if (Total.length >= 5) {

                    var fmtTotal = Total.replace('.', ':');
                    fmtTotalx = fmtTotal.indexOf(':');
                    if (fmtTotalx == 1)
                        Total = '0' + fmtTotal + '';
                    if (fmtTotalx == 2)
                        Total = '' + fmtTotal + '';
                    if (fmtTotalx == 3) {
                        Total = fmtTotal + '0';
                    }
                    if (fmtTotalx == 4 && fmtTotal.length > 5) {
                        Total = fmtTotal + '0';
                    }
                    else {
                        Total = fmtTotal;
                    }
                }
                //Adding Ends here for issue

                var EntryDate = WeekTotalObject.EntryDate;
                //AllTotal = WeekTotalObject.AllTotal;

                //AllTotal = WeekTotalObject.AllTotal;
                var AllTotal = '' + WeekTotalObject.AllTotal + '';
                //alert(AllTotal.length);
                if (AllTotal.length == 1) {
                    var fmtTotal = '0' + AllTotal + ':00';
                    AllTotal = fmtTotal;
                }
                if (AllTotal.length == 2) {
                    var fmtAllTotal = AllTotal + ':00';
                    AllTotal = fmtAllTotal;
                }
                if (AllTotal.length == 3) {
                    var fmtAllTotal = AllTotal.replace('.', ':');
                    fmtAllTotalx = fmtAllTotal.indexOf(':');
                    if (fmtAllTotalx == 1) {
                        AllTotal = '0' + fmtAllTotal + '0';
                    }
                    if (fmtAllTotalx == -1) {
                        AllTotal = AllTotal + ':00';
                    }
                }
                if (AllTotal.length == 4) {
                    var fmtAllTotal = AllTotal.replace('.', ':');
                    fmtAllTotalx = fmtAllTotal.indexOf(':');
                    if (fmtAllTotalx == 2)
                        AllTotal = '' + fmtAllTotal + '0';
                    if (fmtAllTotalx == 1)
                        AllTotal = '0' + fmtAllTotal + '';
                }
                if (AllTotal.length >= 5) {

                    var fmtAllTotal = AllTotal.replace('.', ':');
                    fmtAllTotalx = fmtAllTotal.indexOf(':');
                    if (fmtAllTotalx == 1)
                        AllTotal = '0' + fmtAllTotal + '';
                    if (fmtAllTotalx == 2)
                        AllTotal = '' + fmtAllTotal + '';
                    if (fmtAllTotalx == 3) {
                        AllTotal = fmtAllTotal + '0';
                    }
                    if (fmtAllTotalx == 4 && fmtAllTotal.length > 5) {
                        AllTotal = fmtAllTotal + '0';
                    }
                    else {
                        AllTotal = fmtAllTotal;
                    }
                }

                var WeekDays = WeekTotalObject.WeekDays;

                if (i >= WeekDays) {
                    strHTML += "<th class='toggleDisplay'><label class='pro_Calculate_count'>" + Total + "</label></th>";
                }
                else {
                    strHTML += "<th><label class='pro_Calculate_count'>" + Total + "</label></th>";
                }
            }
            //Added By Usha Pandit On 03.03.2021 For Note regarding efforts change
            updatedAllTotal = AllTotal;
           
            var RequestParameters = {
                WorkHrs: encodeURI(updatedAllTotal),
                Flag: encodeURI(2),
            }
            var param = JSON.stringify(RequestParameters);
            updatedAllTotal = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
            //Added By Usha Pandit On 03.03.2021 For Note regarding efforts change
            
            strHTML += "<th><label class='pro_Calculate_count' ID='IdAllTotal'>" + AllTotal + "</label></th>";
            // alert(Total);
            strHTML += "<th>&nbsp;</th><th>&nbsp;</th>";
            if (PageFlag == 3) {
                strHTML += "<th>&nbsp;</th>";

            }
            if (PageFlag == 2 || PageFlag == 3) {
                $(".ActualHours").html(AllTotal);
            }

            $("#WeekTotal").html(strHTML);
        }
        function plotTaskList(taskList) {
            debugger
            var taskHTML = "";
            var taskCounter = 0;
            var subTaskCounter = 0;

            //Added By Usha Pandit On 05.08.2020 For checking if any task is rejected
            var blnIsAnyTaskRejected = false;
            //End Of Added By Usha Pandit On 05.08.2020 For checking if any task is rejected

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
                //var Mon = task.Mon;
                //var Tue = task.Tue;
                //var Wed = task.Wed;
                //var Thu = task.Thu;
                //var Fri = task.Fri;
                //var Sat = task.Sat;
                //var Sun = task.Sun;

                //Commented and added By Reshma for issue
                //Monday
                var Mon = '' + task.Mon + '';
                //alert(Mon.length);
                if (Mon.length == 1) {
                    var fmtMon = '0' + Mon + ':00';
                    Mon = fmtMon;
                }
                if (Mon.length == 2) {
                    var fmtMon = Mon + ':00';
                    Mon = fmtMon;
                }
                if (Mon.length == 3) {
                    var fmtMon = Mon.replace('.', ':');
                    fmtMonx = fmtMon.indexOf(':');
                    if (fmtMonx == 1) {
                        Mon = '0' + fmtMon + '0';
                    }
                    if (fmtMonx == -1) {
                        Mon = Mon + ':00';
                    }
                }
                if (Mon.length == 4) {
                    var fmtMon = Mon.replace('.', ':');
                    fmtMonx = fmtMon.indexOf(':');
                    if (fmtMonx == 2)
                        Mon = '' + fmtMon + '0';
                    if (fmtMonx == 1)
                        Mon = '0' + fmtMon + '';
                }
                if (Mon.length >= 5) {

                    var fmtMon = Mon.replace('.', ':');
                    fmtMonx = fmtMon.indexOf(':');
                    if (fmtMonx == 1)
                        Mon = '0' + fmtMon + '';
                    if (fmtMonx == 2)
                        Mon = '' + fmtMon + '';
                    if (fmtMonx == 3) {
                        Mon = fmtMon + '0';
                    }
                    if (fmtMonx == 4 && fmtMon.length > 5) {
                        Mon = fmtMon + '0';
                    }
                    else {
                        Mon = fmtMon;
                    }
                }

                //Tuesday
                var Tue = '' + task.Tue + '';
                if (Tue.length == 1) {
                    var fmtTue = '0' + Tue + ':00';
                    Tue = fmtTue;
                }
                if (Tue.length == 2) {
                    var fmtTue = Tue + ':00';
                    Tue = fmtTue;
                }
                if (Tue.length == 3) {

                    var fmtTue = Tue.replace('.', ':');
                    fmtTuex = fmtTue.indexOf(':');
                    if (fmtTuex == 1) {
                        Tue = '0' + fmtTue + '0';
                    }
                    if (fmtTuex == -1) {
                        Tue = Tue + ':00';

                    }
                }
                if (Tue.length == 4) {
                    var fmtTue = Tue.replace('.', ':');
                    fmtTuex = fmtTue.indexOf(':');
                    if (fmtTuex == 2)
                        Tue = '' + fmtMon + '0';
                    if (fmtTuex == 1)
                        Tue = '0' + fmtTue + '';
                }
                if (Tue.length >= 5) {

                    var fmtTue = Tue.replace('.', ':');
                    fmtTuex = fmtTue.indexOf(':');
                    if (fmtTuex == 1)
                        Tue = '0' + fmtTue + '';
                    if (fmtTuex == 2)
                        Tue = '' + fmtTue + '';
                    if (fmtTuex == 3) {
                        Tue = fmtTue + '0';
                    }
                    if (fmtTuex == 4 && fmtTue.length > 5) {
                        Tue = fmtTue + '0';
                    }
                    else {
                        Tue = fmtTue;
                    }
                }

                //Wedensday
                var Wed = '' + task.Wed + '';
                if (Wed.length == 1) {
                    var fmtWed = '0' + Wed + ':00';
                    Wed = fmtWed;
                }
                if (Wed.length == 2) {
                    var fmtWed = Wed + ':00';
                    Wed = fmtWed;
                }
                if (Wed.length == 3) {
                    var fmtWed = Wed.replace('.', ':');
                    fmtWedx = fmtWed.indexOf(':');
                    if (fmtWedx == 1) {
                        Wed = '0' + fmtWed + '0';
                    }
                    if (fmtWedx == -1) {
                        Wed = Wed + ':00';
                    }
                }
                if (Wed.length == 4) {
                    var fmtWed = Wed.replace('.', ':');
                    fmtWedx = fmtWed.indexOf(':');
                    if (fmtWedx == 2)
                        Wed = '' + fmtWed + '0';
                    if (fmtWedx == 1)
                        Wed = '0' + fmtWed + '';
                }
                if (Wed.length >= 5) {

                    var fmtWed = Wed.replace('.', ':');
                    fmtWedx = fmtWed.indexOf(':');
                    if (fmtWedx == 1)
                        Wed = '0' + fmtWed + '';
                    if (fmtWedx == 2)
                        Wed = '' + fmtWed + '';
                    if (fmtWedx == 3) {
                        Wed = fmtWed + '0';
                    }
                    if (fmtWedx == 4 && fmtWed.length > 5) {
                        Wed = fmtWed + '0';
                    }
                    else {
                        Wed = fmtWed;
                    }
                }

                //Thursday

                var Thu = '' + task.Thu + '';
                //alert(Thu.length);
                if (Thu.length == 1) {
                    var fmtThu = '0' + Thu + ':00';
                    Thu = fmtThu;
                }
                if (Thu.length == 2) {
                    var fmtThu = Thu + ':00';
                    Thu = fmtThu;
                }
                if (Thu.length == 3) {
                    //
                    var fmtThu = Thu.replace('.', ':');
                    fmtThux = fmtThu.indexOf(':');
                    if (fmtThux == 1) {
                        Thu = '0' + fmtThu + '0';
                    }
                    if (fmtThux == -1) {
                        Thu = Thu + ':00';
                    }
                }
                if (Thu.length == 4) {
                    var fmtThu = Thu.replace('.', ':');
                    fmtThux = fmtThu.indexOf(':');
                    if (fmtThux == 2)
                        Thu = '' + fmtThu + '0';
                    if (fmtThux == 1)
                        Thu = '0' + fmtThu + '';
                }
                if (Thu.length >= 5) {

                    var fmtThu = Thu.replace('.', ':');
                    fmtThux = fmtThu.indexOf(':');
                    if (fmtThux == 1)
                        Thu = '0' + fmtThu + '';
                    if (fmtThux == 2)
                        Thu = '' + fmtThu + '';
                    if (fmtThux == 3) {
                        Thu = fmtThu + '0';
                    }
                    if (fmtThux == 4 && fmtThu.length > 5) {
                        Thu = fmtThu + '0';
                    }
                    else {
                        Thu = fmtThu;
                    }
                }
                //Friday
                var Fri = '' + task.Fri + '';
                //alert(Fri.length);
                if (Fri.length == 1) {
                    var fmtFri = '0' + Fri + ':00';
                    Fri = fmtFri;
                }
                if (Fri.length == 2) {
                    var fmtFri = Fri + ':00';
                    Fri = fmtFri;
                }
                if (Fri.length == 3) {
                    var fmtFri = Fri.replace('.', ':');
                    fmtFrix = fmtFri.indexOf(':');

                    if (fmtFrix == 1) {
                        Fri = '0' + fmtFri + '0';
                    }
                    if (fmtFrix == -1) {
                        Fri = Fri + ':00';

                    }
                }
                if (Fri.length == 4) {
                    var fmtFri = Fri.replace('.', ':');
                    fmtFrix = fmtFri.indexOf(':');
                    if (fmtFrix == 2)
                        Fri = '' + fmtFri + '0';
                    if (fmtFrix == 1)
                        Fri = '0' + fmtFri + '';
                }
                if (Fri.length >= 5) {

                    var fmtFri = Fri.replace('.', ':');
                    fmtFrix = fmtFri.indexOf(':');
                    if (fmtFrix == 1)
                        Fri = '0' + fmtFri + '';
                    if (fmtFrix == 2)
                        Fri = '' + fmtFri + '';
                    if (fmtFrix == 3) {
                        Fri = fmtFri + '0';
                    }
                    if (fmtFrix == 4 && fmtFri.length > 5) {
                        Fri = fmtFri + '0';
                    }
                    else {
                        Fri = fmtFri;
                    }
                }

                //Saturdaty
                var Sat = '' + task.Sat + '';
                if (Sat.length == 1) {
                    var fmtSat = '0' + Sat + ':00';
                    Sat = fmtSat;
                }
                if (Sat.length == 2) {
                    var fmtSat = Sat + ':00';
                    Sat = fmtSat;
                }
                if (Sat.length == 3) {
                    var fmtSat = Sat.replace('.', ':');
                    fmtSatx = fmtSat.indexOf(':');

                    if (fmtSatx == 1) {
                        Sat = '0' + fmtSat + '0';
                    }
                    if (fmtSatx == -1) {
                        Sat = Sat + ':00';

                    }
                }
                if (Sat.length == 4) {
                    var fmtSat = Sat.replace('.', ':');
                    fmtSatx = fmtSat.indexOf(':');
                    if (fmtSatx == 2)
                        Sat = '' + fmtSat + '0';
                    if (fmtSatx == 1)
                        Sat = '0' + fmtSat + '';
                }
                if (Sat.length >= 5) {

                    var fmtSat = Sat.replace('.', ':');
                    fmtSatx = fmtSat.indexOf(':');
                    if (fmtSatx == 1)
                        Sat = '0' + fmtSat + '';
                    if (fmtSatx == 2)
                        Sat = '' + fmtSat + '';
                    if (fmtSatx == 3) {
                        Sat = fmtSat + '0';
                    }
                    if (fmtSatx == 4 && fmtSat.length > 5) {
                        Sat = fmtSat + '0';
                    }
                    else {
                        Sat = fmtSat;
                    }
                }

                //Sunday
                var Sun = '' + task.Sun + '';
                if (Sun.length == 1) {
                    var fmtSun = '0' + Sun + ':00';
                    Sun = fmtSun;
                }
                if (Sun.length == 2) {
                    var fmtSun = Sun + ':00';
                    Sun = fmtSun;
                }
                if (Sun.length == 3) {
                    var fmtSun = Sun.replace('.', ':');
                    fmtSunx = fmtSun.indexOf(':');

                    if (fmtSunx == 1) {
                        Sun = '0' + fmtSun + '0';
                    }
                    if (fmtSunx == -1) {
                        Sun = Sun + ':00';

                    }
                }
                if (Sun.length == 4) {
                    var fmtSun = Sun.replace('.', ':');
                    fmtSunx = fmtSun.indexOf(':');
                    if (fmtSunx == 2)
                        Sun = '' + fmtSun + '0';
                    if (fmtSunx == 1)
                        Sun = '0' + fmtSun + '';
                }
                if (Sun.length >= 5) {

                    var fmtSun = Sun.replace('.', ':');
                    fmtSunx = fmtSun.indexOf(':');
                    if (fmtSunx == 1)
                        Sun = '0' + fmtSun + '';
                    if (fmtSunx == 2)
                        Sun = '' + fmtSun + '';
                    if (fmtSunx == 3) {
                        Sun = fmtSun + '0';
                    }
                    if (fmtSunx == 4 && fmtSun.length > 5) {
                        Sun = fmtSun + '0';
                    }
                    else {
                        Sun = fmtSun;
                    }
                }
                //Commented and added end here By Reshma for issue

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
                var MonDAType = task.MonDAType;
                var TueDAType = task.TueDAType;
                var WedDAType = task.WedDAType;
                var ThuDAType = task.ThuDAType;
                var FriDAType = task.FriDAType;
                var SatDAType = task.SatDAType;
                var SunDAType = task.SunDAType;
                //var ActualWork = task.ActualWork;
                var ActualWork = '' + task.ActualWork + '';
                //alert(ActualWork.length);
                if (ActualWork.length == 1) {
                    var fmtActualWork = '0' + ActualWork + ':00';
                    ActualWork = fmtActualWork;
                }
                if (ActualWork.length == 2) {
                    var fmtActualWork = ActualWork + ':00';
                    ActualWork = fmtActualWork;
                }
                if (ActualWork.length == 3) {
                    var fmtActualWork = ActualWork.replace('.', ':');
                    fmtActualWorkx = fmtActualWork.indexOf(':');

                    if (fmtActualWorkx == 1) {
                        ActualWork = '0' + fmtActualWork + '0';
                    }
                    if (fmtActualWorkx == -1) {
                        ActualWork = ActualWork + ':00';
                    }
                }
                if (ActualWork.length == 4) {
                    var fmtActualWork = ActualWork.replace('.', ':');
                    fmtActualWorkx = fmtActualWork.indexOf(':');
                    if (fmtActualWorkx == 2)
                        ActualWork = '' + fmtActualWork + '0';
                    if (fmtActualWorkx == 1)
                        ActualWork = '0' + fmtActualWork + '';
                }
                if (ActualWork.length >= 5) {

                    var fmtActualWork = ActualWork.replace('.', ':');
                    fmtActualWorkx = fmtActualWork.indexOf(':');
                    if (fmtActualWorkx == 1)
                        ActualWork = '0' + fmtActualWork + '';
                    if (fmtActualWorkx == 2)
                        ActualWork = '' + fmtActualWork + '';
                    if (fmtActualWorkx == 3) {
                        ActualWork = fmtActualWork + '0';
                    }
                    if (fmtActualWorkx == 4 && fmtActualWork.length > 5) {
                        ActualWork = fmtActualWork + '0';
                    }
                    else {
                        ActualWork = fmtActualWork;
                    }
                }
                //alert(ActualWork);

                //Commented & added by Sagar Nipane on 26-Dec-2018 For IssueID:16364
                var TaskActualWork = '' + task.TaskActualWork + '';
                //End  of Commenting & added by Sagar Nipane on 26-Dec-2018 For IssueID:16364
                //Added by Sagar N On: 26-Dec-2018 Purpose: For formatting ActualWork in  HH:mm format
                //alert(TaskActualWork.length);
                var fmtWork = 0;
                if (TaskActualWork.length == 1) {
                    fmtWork = '0' + TaskActualWork + ':00';
                    TaskActualWork = fmtWork;
                }
                if (TaskActualWork.length == 2) {
                    fmtWork = TaskActualWork + ':00';
                    TaskActualWork = fmtWork;
                }
                if (TaskActualWork.length == 3) {
                    fmtWork = TaskActualWork.replace('.', ':');
                    fmtindx = fmtWork.indexOf(':');
                    if (fmtindx == 1) {
                        TaskActualWork = '0' + fmtWork + '0';
                    }
                    if (fmtindx == -1) {
                        TaskActualWork = TaskActualWork + ':00';
                    }
                }
                if (TaskActualWork.length == 4) {
                    fmtWork = TaskActualWork.replace('.', ':');
                    fmtindx = fmtWork.indexOf(':');
                    if (fmtindx == 2)
                        TaskActualWork = '' + fmtWork + '0';
                    if (fmtindx == 1)
                        TaskActualWork = '0' + fmtWork + '';
                }
                if (TaskActualWork.length == 5) {
                    //
                    fmtWork = TaskActualWork.replace('.', ':');
                    fmtindx = fmtWork.indexOf(':');
                    if (fmtindx == 3) {
                        TaskActualWork = fmtWork + '0';
                    }
                    else {
                        TaskActualWork = fmtWork;
                    }
                }
                if (TaskActualWork.length > 5) {
                    fmtWork = TaskActualWork.replace('.', ':');
                    fmtindx = fmtWork.indexOf(':');

                    TaskActualWork = fmtWork;

                }
                //End of adding by Sagar N On: 26-Dec-2018 Purpose: For formatting ActualWork in  HH:mm format




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
                var AllowActivityLevelDA = task.AllowActivityLevelDA;
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

                var MonAllowToResubmit = task.MonAllowToResubmit;
                var TueAllowToResubmit = task.TueAllowToResubmit;
                var WedAllowToResubmit = task.WedAllowToResubmit;
                var ThuAllowToResubmit = task.ThuAllowToResubmit;
                var FriAllowToResubmit = task.FriAllowToResubmit;
                var SatAllowToResubmit = task.SatAllowToResubmit;
                var SunAllowToResubmit = task.SunAllowToResubmit;
                var TaskStatusFlag = task.TaskStatusFlag
                var IsSubTaskFilled = task.IsSubTaskFilled;
                var RestrictByMinHours = task.RestrictByMinHours;
                GlobalRestrictByMinHours = RestrictByMinHours;
               
                // 
                //  if (PageFlag != 2 || PageFlag != 3) {
                if (PageFlag != 3) {
                    TimesheetID = task.TimesheetID;                     
                }
                if (PageFlag == 3) {
                    var IsApprover = task.IsApprover;
                }
                if (IsProject == 1) {
                    taskCounter = 0;
                    taskHTML += '<tr class="table_row_divider">'
                    if (TotalHoliday == 2)
                        taskHTML += '<td colspan="10">&nbsp;</td>';
                    else if (TotalHoliday == 3)
                        taskHTML += '<td colspan="9">&nbsp;</td>';
                    else if (TotalHoliday == 4)
                        taskHTML += '<td colspan="8">&nbsp;</td>';
                    else if (TotalHoliday == 5)
                        taskHTML += '<td colspan="7">&nbsp;</td>';
                    else if (TotalHoliday == 6)
                        taskHTML += '<td colspan="6">&nbsp;</td>';
                    else if (TotalHoliday == 7)
                        taskHTML += '<td colspan="5">&nbsp;</td>';
                    else
                        taskHTML += '<td colspan="10">&nbsp;</td>';
                    taskHTML += '    <td class="toggleDisplay">&nbsp;</td>'
                    taskHTML += ' </tr>'


                    taskHTML += '  <tr class="task">'
                    taskHTML += '                    <td>'
                    taskHTML += '                        <div class="tbl-projecttitle">'
                    taskHTML += '                           <img src="../../../Whizible2.0/dist/img/Projects_icon_blue.svg" width="20px"> ' + ProjectName
                    taskHTML += '                                    <div class="pull-right projecttitle_actions">'
                    if (PageFlag != 3) {
                        taskHTML += '                                        <a id="btnMoreProjectTaskLevel" name="btnMoreProjectTaskLevel" class="nostyle hidden-xs" data-toggle="modal" data-target="#" onclick="PlotFilterTaskList(' + ProjectID + ')">';
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
                    taskHTML += '                    <td class="daytotlecount">'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Mon + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td class="daytotlecount">'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Tue + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td class="daytotlecount">'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Wed + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td class="daytotlecount">'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Thu + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td class="daytotlecount">'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Fri + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td class="daytotlecount">'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Sat + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td class="daytotlecount">'
                    taskHTML += '                        <label class="pro_Calculate_count" title="Effort" data-toggle="tooltip" data-placement="bottom">' + Sun + '</label>'
                    taskHTML += '                    </td>'
                    taskHTML += '                    <td class="daytotlecount">'
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
                        if ((MonStatusFlag == 'J' || TueStatusFlag == 'J' || WedStatusFlag == 'J' || ThuStatusFlag == 'J' || FriStatusFlag == 'J' || SatStatusFlag == 'J' || SunStatusFlag == 'J') && TimesheetID != 0) {
                            taskHTML += '                  <span class="subtask" style="color:red;" title="' + TaskName + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + TaskName + '</span>&nbsp;'
                        }
                        else {
                            taskHTML += '                  <span class="subtask tasktooltip" title="' + TaskName + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + TaskName + '</span>&nbsp;'
                        }
                    }
                    else {
                        subTaskCounter += 1;
                        taskHTML += '              <div class="subtasklist subtasktitle dropdown subtasklistsmall hidden-xs">'
                        if ((MonStatusFlag == 'J' || TueStatusFlag == 'J' || WedStatusFlag == 'J' || ThuStatusFlag == 'J' || FriStatusFlag == 'J' || SatStatusFlag == 'J' || SunStatusFlag == 'J') && TimesheetID != 0) {
                            taskHTML += '                 <span class="subtask" style="color:red;" title="' + SubTaskType + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + SubTaskType + '</span>&nbsp;'
                        }
                        else {
                            taskHTML += '                 <span class="subtask" title="' + SubTaskType + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + SubTaskType + '</span>&nbsp;'
                        }
                    }

                    taskHTML += '<div class="pull-right" data-toggle="tooltip" data-placement="top" title="Task Info">'
                    taskHTML += '<div id="popover-content-' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="dropdown-menu timeinfopopup hide" role="menu" aria-labelledby="menu1">'
                    //taskHTML += '<div class="arrow-left"></div>'
                    taskHTML += '<div class="projecttaskinfo_tooltipbox">'
                    taskHTML += '<button type="button" class="close"  id="close_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '">'
                    taskHTML += '<img width="20px" src="../../../Whizible2.0/dist/img/close-gray.svg"></button>'
                    taskHTML += '<div class="PTItooltipbox_hading" style="word-break: break-word;">'
                    taskHTML += '' + ProjectName + ''
                    taskHTML += '<br />'
                    taskHTML += '<span class="PTItooltipbox_hading">' + TaskName + ' ' + (SubTaskTypeID == 0 ? "" : "<br />  " + SubTaskType) + '</span>                                                                                                                              '
                    taskHTML += '</div>'
                    if (Tasknotes != "") {
                        taskHTML += '<p class="taskdescription">' + Tasknotes + '</p>';
                    }
                    else {
                        taskHTML += '<p>' + Tasknotes + '</p>';
                    }
                    taskHTML += '<div class="projecttaskinfo_tooltipbox_schedule">'
                    taskHTML += '<div class="row">'
                    taskHTML += '<div class="col-xs-5">Start Date:</div>'
                    taskHTML += '<div class="col-xs-7">' + StartDate + '</div>'
                    taskHTML += '</div>'
                    taskHTML += '<div class="row">'
                    taskHTML += '<div class="col-xs-5">End Date:</div>'
                    taskHTML += '<div class="col-xs-7">' + EndDate + '</div>'
                    taskHTML += '</div>';
                    if (WhichTask != 'D') {
                        taskHTML += '<div class="row">'
                        taskHTML += '<div class="col-xs-5">Allocated Work:</div>'
                        taskHTML += '<div class="col-xs-7">' + ConvertToDecimal(Work) + '</div>'
                        taskHTML += '</div>'
                    }
                    taskHTML += '<div class="row">'
                    taskHTML += '<div class="col-xs-5">Actual Work:</div>'
                    taskHTML += '<div class="col-xs-7">' + TaskActualWork + '</div>'
                    taskHTML += '<input id="TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ConvertToDecimal(Work) + '"</input>'
                    taskHTML += '<input id="TotalActualDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input>'
                    taskHTML += '<input id="TotalActualDynamicDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input>';
                    taskHTML += '</div>'
                    taskHTML += '</div>'
                    taskHTML += ''
                    taskHTML += '<hr />'
                    taskHTML += '<div class="projecttaskinfo_tooltipbox_schedule">';
                    if (Phase != '') {
                        taskHTML += '<div class="row">'
                        taskHTML += '<div class="col-xs-5">Phase:</div>'
                        taskHTML += '<div class="col-xs-7"><span class="issuetext" title="' + Phase + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + Phase + '</span></div>'
                        taskHTML += '</div>';
                    }
                    if (MileStone != '') {
                        taskHTML += '<div class="row">                                                                                                                            '
                        taskHTML += '<div class="col-xs-5">Milestone:</div>                                                                                                   '
                        taskHTML += '                                                  <div class="col-xs-7"><span class="issuetext" title="' + MileStone + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + MileStone + '</span></div>                                                                                                  '
                        taskHTML += '                                              </div>                                                                                                                                       ';
                    }
                    if (SubProjectName != '') {
                        taskHTML += '                                              <div class="row">                                                                                                                            '
                        taskHTML += '                                                  <div class="col-xs-5">Sub Project:</div>                                                                                                 '
                        taskHTML += '                                                  <div class="col-xs-7"><span class="issuetext" title="' + SubProjectName + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + SubProjectName + '</span></div>                                                                                   '
                        taskHTML += '                                              </div>'
                    }
                    if (DeliverableName != '') {
                        taskHTML += '                                              <div class="row">                                                                                                                            '
                        taskHTML += '                                                  <div class="col-xs-5">Deliverable:</div>                                                                                                 '
                        taskHTML += '                                                  <div class="col-xs-7"><span class="issuetext" title="' + DeliverableName + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + DeliverableName + '</span></div>                                                                                   '
                        taskHTML += '                                              </div>'
                    }
                    if (ModuleName != '') {
                        taskHTML += '                                              <div class="row">                                                                                                                            '
                        taskHTML += '                                                  <div class="col-xs-5">Module:</div>                                                                                                 '
                        taskHTML += '                                                  <div class="col-xs-7"><span class="issuetext" title="' + ModuleName + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + ModuleName + '</span></div>                                                                                   '
                        taskHTML += '                                              </div>'
                    }
                    if (Issue != '') {
                        taskHTML += '                                              <div class="row">                                                                                                                            '
                        taskHTML += '                                                  <div class="col-xs-5">Issue:</div>                                                                                                       '
                        taskHTML += '                                                  <div class="col-xs-7"><span class="issuetext" title="' + Issue + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + Issue + '</span></div>                                                                                   '
                        taskHTML += '                                              </div>                                                                                                                                       '
                    }
                    taskHTML += '                                          </div>                                                                                                                                           '
                    taskHTML += '                                                                                                                                                                                           '
                    taskHTML += '                                      </div>                                                                                                                                               '
                    taskHTML += '                                  </div>                                                                                                                                                   '
                    taskHTML += '<img class="pull-right" src="../../../Whizible2.0/dist/img/exclaim.svg" width="13px" alt="" data-toggle="popover" data-container="body" data-placement="right" type="button" data-html="true" href="#" id="' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"> '
                    taskHTML += '                          </div>'
                    taskHTML += '                  <div class="clearfix"></div>'
                    taskHTML += '                  <div class="relativediv">'
                    if (SubTaskTypeID == 0) {
                        if (Percentage > 100) {
                            taskHTML += '                      <div data-toggle="tooltip" data-placement="top" title="Task Progress ' + Percentage.toFixed(2) + '%" class="progress progress-xs" style="background:#eb1c24 !important;">';
                            taskHTML += '                          <div class="progress-bar" style="width: ' + Percentage.toFixed(2) + '%;background:#eb1c24 !important;"></div>'
                            taskHTML += '                      </div>'
                        }
                        else {
                            taskHTML += '                      <div data-toggle="tooltip" data-placement="top" title="Task Progress ' + Percentage.toFixed(2) + '%" class="progress progress-xs" style="background:#ddd !important;">';
                            taskHTML += '                          <div class="progress-bar" style="width: ' + Percentage.toFixed(2) + '%"></div>'
                            taskHTML += '                      </div>'
                        }

                    }
                    taskHTML += '                      <ul class="projectsmenuicon">'
                    taskHTML += '                          <li class="dropdown">'
                    if (PageFlag != 3) {
                        if (IsTaskComplete == 0) {
                            taskHTML += '                              <a name="btnTSActions" data-toggle="dropdown" class="nostyle hidden-xs dropdown-toggle"><i class="fas fa-ellipsis-h" title="More Action" data-toggle="tooltip" data-placement="top"></i></a>'
                        }
                    }
                    taskHTML += '                              <ul id="projects-menu" class="dropdown-menu clearfix" role="menu">'
                    if (SubTaskTypeID == 0) {
                        if (IsTaskComplete == 0) {
                            
                            if (AllowActivityLevelDA == 1) {
                                taskHTML += '                                  <li data-toggle="tooltip" data-placement="top" title="Add Sub Tasks">'
                                taskHTML += '                                      <a href="#" class="nostyle hidden-xs" data-toggle="modal" data-target="#selectsubtask" onclick="PlotSubTaskList(' + ProjectID + ',' + TaskID + ')">';
                                taskHTML += '                                          <img src="../../../Whizible2.0/dist/img/Sub-tasks.svg" alt="" class="" width="15px">'
                                taskHTML += '                                          Add Sub Tasks</a>'
                                taskHTML += '                                  </li>'
                            }
                            if (WhichTask != "D") {
                                taskHTML += '                                  <li data-toggle="tooltip" data-placement="top" title="Schedule Time Entry">'
                                taskHTML += '                                      <a href="#" class="nostyle hidden-xs" data-toggle="modal" data-target="#Schedule" onclick="PlotScheduleTSEntryData(' + TaskID + ',' + SubTaskTypeID + ')">'
                                taskHTML += '                                          <img src="../../../Whizible2.0/dist/img/Calendar with clock.svg" alt="" class="" width="15px">'
                                taskHTML += '                                          Schedule Time Entry</a>'
                                taskHTML += '                                  </li>';

                            }

                        }
                    }
                    if ((WhichTask == "M" || WhichTask == "O") && IsTaskComplete == 0) {
                        taskHTML += '                                  <li data-toggle="tooltip" data-placement="top" title="Request Additional Time">'
                        taskHTML += '                                      <a href="#" class="nostyle hidden-xs" data-toggle="modal" data-target="#requestadditionaltime" onclick="PlotAdditionalTimeRequestData(' + TaskID + ',' + SubTaskTypeID + ')">'
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
                        if (IsTaskComplete == 0) {

                            //Commented and Added by Usha on 27.12.2018 for disable field on view 

                            //taskHTML += '                  <input type="checkbox" name="chkQuickEntry" id="chkQuickEntry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '" ">'
                            taskHTML += '                  <input type="checkbox" name="chkQuickEntry" id="chkQuickEntry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '" ' + strEnableDisable + '>'
                            taskHTML += '                  <label name="chkQuickEntry" for="chkQuickEntry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                            //Added by Nikhil A on 16-Apr-2021
                            taskHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                             //Added by Nikhil A on 16-Apr-2021
                            //End of Added by Usha on 27.12.2018 for disable field on view 
                        }
                        else {
                            taskHTML += '                  <input type="checkbox" name="chkQuickEntry" id="chkQuickEntry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '" disabled style="cursor:not-allowed!important">'
                            taskHTML += '                  <label name="chkQuickEntry" for="chkQuickEntry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" style="cursor:not-allowed!important"></label>'
                                   //Added by Nikhil A on 16-Apr-2021
                            taskHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                             //Added by Nikhil A on 16-Apr-2021
                        }

                        taskHTML += '              </div>'
                        taskHTML += '          </td>'
                    }
                    if (IsTaskComplete == 0) {
                        //Monday
                        // 
                        var dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"));

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"  title="Description" data-placement="bottom">';
                        if (MonDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                            taskHTML += '             <input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" class="timenoinput dropdown-toggle" type="text" value="' + Mon + '" name="" role="button" aria-haspopup="true" aria-expanded="true"  data-toggle="tooltip"   title="Enter Your Effort in hh:mm format" style="pointer-events: none;" data-placement="bottom" readonly>';
                        }
                        else {
                            if (IsSubTaskFilled == 1) {
                                taskHTML += '             <input  maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" class="timenoinput dropdown-toggle" type="text" value="' + Mon + '" name="" data-toggle="tooltip" role="button" aria-haspopup="true" aria-expanded="true"  title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57" style="pointer-events: none;"   readonly>';
                            }
                            else {
                                taskHTML += '             <input  maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" class="timenoinput dropdown-toggle" type="text" value="' + Mon + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57" >';
                            }

                        }
                        taskHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" value="' + MonAllowToResubmit + '" />';
                        taskHTML += '<input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" type="hidden" value="' + new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US") + '" name="">';
                        taskHTML += '<input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" type="hidden" value="' + MonDAID + '" name="">';
                        taskHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" type="hidden" value="0" name="">';
                        taskHTML += '<div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Mon != 0) {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + MonDescription + '</textarea > ';
                          
                            if ((MonDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID +'_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Call Back</label>'
                            }
                            else if ((MonDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Call Back</label>'
                            }
                            else if ((MonDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Call Back</label>'
                            }
                            else if ((MonDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Call Back</label>'
                            }
                            
                            //taskHTML += '<small id="counttxtreason" style="float: right;display:none;"></small>';
                            if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    if (MonDAID != "") {
                                        taskHTML += '<button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',1)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                    }

                                }
                            }
                        }
                        else {

                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + MonDescription + '</textarea>';
                            //Added By Nikhil Adkar
                           
                            if ((MonDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Call Back</label>'
                            }
                            else if ((MonDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Call Back</label>'
                            }
                            else if ((MonDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Call Back</label>'
                            }
                            else if ((MonDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" > <label>Call Back</label>'
                            }
                            //taskHTML += '<small id="counttxtreason" style="float: right;display:none;"></small>';

                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            //  taskHTML += '           <input data-toggle="tooltip" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" type="text" value="' + MonStoryPoint + '" placeholder=" " name="" data-placement="bottom" title="Story Point">';
                            if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                taskHTML += '           <input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" type="text" onkeypress="return isNumberSP(event,this.value,this)" value="' + MonStoryPoint + '" placeholder=" " name="" data-placement="bottom" title="Story Point" readonly autocomplete="off">';
                            }
                            else {
                                taskHTML += '           <input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '1" type="text" onkeypress="return isNumberSP(event,this.value,this)" value="' + MonStoryPoint + '" placeholder=" " name="" data-placement="bottom" title="Story Point" autocomplete="off">';
                            }

                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        //Tuesday
                        //
                        var NextDay = new Date();
                        dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                        //alert(dtstartDate.getDate())
                        NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 1));
                        // NextDay.setDate(new Date($("#weekPicker2").attr("StartDate")).getDate() + 1);

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"  title="Description" data-placement="bottom">';
                        if (TueDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                            taskHTML += '             <input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" class="timenoinput dropdown-toggle" type="text" value="' + Tue + '"  name=""  role="button" aria-haspopup="true" aria-expanded="true" data-toggle="tooltip" title="Enter Your Effort in hh:mm format" data-placement="bottom" style="pointer-events: none;" readonly>';
                        }
                        else {
                            if (IsSubTaskFilled == 1) {
                                taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" class="timenoinput dropdown-toggle" type="text" value="' + Tue + '" name="" data-toggle="tooltip" role="button" aria-haspopup="true" aria-expanded="true" title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57" style="pointer-events: none;"  readonly>';
                            } else {
                                taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" class="timenoinput dropdown-toggle" type="text" value="' + Tue + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true" title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57">';
                            }

                        }
                        taskHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" value="' + TueAllowToResubmit + '" />';
                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US")) + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" type="hidden" value="' + TueDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Tue != 0) {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + TueDescription + '</textarea>';
                            //Added By Nikhil Adkar
                            
                            if ((TueDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Call Back</label>'
                            }
                            else if ((TueDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Call Back</label>'
                            }
                            else if ((TueDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Call Back</label>'
                            }
                            else if ((TueDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Call Back</label>'
                            }
                            //End of Added By Nikhil Adkar

                            if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    if (TueDAID != "") {
                                        taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',2)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                    }
                                }
                            }
                        }
                        else {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000) >' + TueDescription + '</textarea>';
                             //Added By Nikhil Adkar
                            
                            if ((TueDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Call Back</label>'
                            }
                            else if ((TueDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Call Back</label>'
                            }
                            else if ((TueDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Call Back</label>'
                            }
                            else if ((TueDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType2_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2" > <label>Call Back</label>'
                            }
                             //End of Added Added By Nikhil Adkar

                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                taskHTML += '           <input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2"  type="text" onkeypress="return isNumberSP(event,this.value,this)" value="' + TueStoryPoint + '" placeholder="' + TueStoryPoint + '" name="" data-placement="bottom" title="Story Point" readonly autocomplete="off">';
                            }
                            else {
                                taskHTML += '           <input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '2"  type="text" onkeypress="return isNumberSP(event,this.value,this)" value="' + TueStoryPoint + '" placeholder="' + TueStoryPoint + '" name="" data-placement="bottom" title="Story Point" autocomplete="off">';
                            }

                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        //Wednesday
                        var NextDay = new Date();
                        dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                        NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 2));
                        // NextDay.setDate(new Date($("#weekPicker2").attr("StartDate")).getDate() + 2);

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (WedDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                            taskHTML += '             <input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" class="timenoinput dropdown-toggle" type="text" value="' + Wed + '" name="" role="button" aria-haspopup="true" aria-expanded="true" data-toggle="tooltip"  title="Enter Your Effort in hh:mm format" data-placement="bottom" style="pointer-events: none;" readonly>';
                        } else {
                            if (IsSubTaskFilled == 1) {
                                taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" class="timenoinput dropdown-toggle" type="text" value="' + Wed + '" name="" data-toggle="tooltip" role="button" aria-haspopup="true" aria-expanded="true"  title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57" style="pointer-events: none;"  readonly>';
                            } else {
                                taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" class="timenoinput dropdown-toggle" type="text" value="' + Wed + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57">';
                            }

                        }
                        taskHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" value="' + WedAllowToResubmit + '" />';
                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US")) + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" type="hidden" value="' + WedDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Wed != 0) {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + WedDescription + '</textarea>';
                             //Added By Nikhil Adkar
                            if ((WedDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Call Back</label>'
                            }
                            else if ((WedDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Call Back</label>'
                            }
                            else if ((WedDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Call Back</label>'
                            }
                            else if ((WedDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Call Back</label>'
                            }
                             //End of Added By Nikhil Adkar
                            if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    if (WedDAID != "") {
                                        taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',3)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                    }
                                }
                            }
                        }
                        else {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + WedDescription + '</textarea>';
                            //Added By Nikhil Adkar
                        
                            //Added By Nikhil Adkar
                            if ((WedDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Call Back</label>'
                            }
                            else if ((WedDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Call Back</label>'
                            }
                            else if ((WedDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Call Back</label>'
                            }
                            else if ((WedDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType3_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" > <label>Call Back</label>'
                            }
                             //End of Added By Nikhil Adkar
                             //End of Added By Nikhil Adkar
                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                taskHTML += '           <input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" onkeypress="return isNumberSP(event,this.value,this)" type="text" value="' + WedStoryPoint + '" placeholder="' + WedStoryPoint + '" name="" data-placement="bottom" title="Story Point" readonly>';
                            }
                            else {
                                taskHTML += '           <input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '3" onkeypress="return isNumberSP(event,this.value,this)" type="text" value="' + WedStoryPoint + '" placeholder="' + WedStoryPoint + '" name="" data-placement="bottom" title="Story Point">';
                            }

                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        //Thursday
                        var NextDay = new Date();
                        dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                        NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 3));
                        // NextDay.setDate(new Date($("#weekPicker2").attr("StartDate")).getDate() + 3);

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (ThuDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                            taskHTML += '             <input  id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" class="timenoinput dropdown-toggle" type="text" value="' + Thu + '" name="" role="button" aria-haspopup="true" aria-expanded="true" data-toggle="tooltip"  title="Enter Your Effort in hh:mm format" data-placement="bottom" style="pointer-events: none;" readonly>';
                        } else {
                            if (IsSubTaskFilled == 1) {
                                taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" class="timenoinput dropdown-toggle" type="text" value="' + Thu + '"  name="" data-toggle="tooltip" role="button" aria-haspopup="true" aria-expanded="true"  title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57" style="pointer-events: none;"  readonly>';
                            } else {
                                taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" class="timenoinput dropdown-toggle" type="text" value="' + Thu + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57">';
                            }

                        }
                        taskHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" value="' + ThuAllowToResubmit + '" />';
                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US")) + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" type="hidden" value="' + ThuDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Thu != 0) {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + ThuDescription + '</textarea>';
                            //Added By Nikhil Adkar
                       
                            //Added By Nikhil Adkar
                            if ((ThuDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Call Back</label>'
                            }
                            else if ((ThuDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Call Back</label>'
                            }
                            else if ((ThuDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Call Back</label>'
                            }
                            else if ((ThuDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Call Back</label>'
                            }
                             //End of Added By Nikhil Adkar
                            //End of Added By Nikhil Adkar
                            if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    if (ThuDAID != "") {
                                        taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',4)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                    }
                                }
                            }
                        }
                        else {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + ThuDescription + '</textarea>';
                             //Added By Nikhil Adkar
                          
                            if ((ThuDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Call Back</label>'
                            }
                            else if ((ThuDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Call Back</label>'
                            }
                            else if ((ThuDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Call Back</label>'
                            }
                            else if ((ThuDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType4_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" > <label>Call Back</label>'
                            }
                             //End of Added By Nikhil Adkar

                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                taskHTML += '           <input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" type="text" onkeypress="return isNumberSP(event,this.value,this)" value="' + ThuStoryPoint + '" placeholder="' + ThuStoryPoint + '" name="" data-placement="bottom" title="Story Point" readonly autocomplete="off">';
                            }
                            else {
                                taskHTML += '           <input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '4" type="text" onkeypress="return isNumberSP(event,this.value,this)" value="' + ThuStoryPoint + '" placeholder="' + ThuStoryPoint + '" name="" data-placement="bottom" title="Story Point" autocomplete="off">';
                            }

                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        //Friday
                        var NextDay = new Date();
                        dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                        NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 4));
                        //   NextDay.setDate(new Date($("#weekPicker2").attr("StartDate")).getDate() + 4);

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (FriDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                            taskHTML += '             <input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" class="timenoinput dropdown-toggle" type="text" value="' + Fri + '"  name=""  role="button" aria-haspopup="true" aria-expanded="true" data-toggle="tooltip"  title="Enter Your Effort in hh:mm format" data-placement="bottom" style="pointer-events: none;" readonly>';
                        } else {
                            if (IsSubTaskFilled == 1) {
                                taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" class="timenoinput dropdown-toggle" type="text" value="' + Fri + '" name="" data-toggle="tooltip" role="button" aria-haspopup="true" aria-expanded="true"  title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57"  style="pointer-events: none;"  readonly>';
                            } else {
                                taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" class="timenoinput dropdown-toggle" type="text" value="' + Fri + '" name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57">';
                            }

                        }
                        taskHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" value="' + FriAllowToResubmit + '" />';
                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US")) + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="' + FriDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Fri != 0) {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + FriDescription + '</textarea>';
                            //Added By Nikhil Adkar
                           
                            if ((FriDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Call Back</label>'
                            }
                            else if ((FriDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Call Back</label>'
                            }
                            else if ((FriDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Call Back</label>'
                            }
                            else if ((FriDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Call Back</label>'
                            }
                            //End of Added By Nikhil Adkar
                            if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    if (FriDAID != "") {
                                        taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',5)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                    }
                                }
                            }
                        }
                        else {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + FriDescription + '</textarea>';
                           
                            if ((FriDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Call Back</label>'
                            }
                            else if ((FriDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Call Back</label>'
                            }
                            else if ((FriDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Call Back</label>'
                            }
                            else if ((FriDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType5_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" > <label>Call Back</label>'
                            }
                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                taskHTML += '           <input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5"  type="text" onkeypress="return isNumberSP(event,this.value,this)" value="' + FriStoryPoint + '" placeholder="' + FriStoryPoint + '" name="" data-placement="bottom" title="Story Point" readonly autocomplete="off">';
                            }
                            else {
                                taskHTML += '           <input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5"  type="text" onkeypress="return isNumberSP(event,this.value,this)" value="' + FriStoryPoint + '" placeholder="' + FriStoryPoint + '" name="" data-placement="bottom" title="Story Point" autocomplete="off">';
                            }

                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        //Saturday
                        var NextDay = new Date();
                        dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                        NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 5));
                        //NextDay.setDate(new Date($("#weekPicker2").attr("StartDate")).getDate() + 5);

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (SatDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                            taskHTML += '             <input  id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" class="timenoinput dropdown-toggle" type="text" value="' + Sat + '" name="" role="button" aria-haspopup="true" aria-expanded="true" data-toggle="tooltip"  title="Enter Your Effort in hh:mm format" data-placement="bottom" style="pointer-events: none;" readonly>';
                        } else {
                            if (IsSubTaskFilled == 1) {
                                taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" class="timenoinput dropdown-toggle" type="text" value="' + Sat + '"  name="" data-toggle="tooltip" role="button" aria-haspopup="true" aria-expanded="true"  title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57" style="pointer-events: none;"  readonly>';
                            } else {
                                taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" class="timenoinput dropdown-toggle" type="text" value="' + Sat + '"  name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57">';
                            }

                        }
                        taskHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" value="' + SatAllowToResubmit + '" />';
                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US")) + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + SatDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Sat != 0) {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + SatDescription + '</textarea>';
                           
                            if ((SatDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Call Back</label>'
                            }
                            else if ((SatDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Call Back</label>'
                            }
                            else if ((SatDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Call Back</label>'
                            }
                            else if ((SatDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Call Back</label>'
                            }
                            if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    if (SatDAID != "") {
                                        taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',6)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                    }
                                }
                            }
                        }
                        else {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + SatDescription + '</textarea>';
                           
                            if ((SatDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Call Back</label>'
                            }
                            else if ((SatDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Call Back</label>'
                            }
                            else if ((SatDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Call Back</label>'
                            }
                            else if ((SatDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType6_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" > <label>Call Back</label>'
                            }
                        }
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                taskHTML += '           <input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6"  type="text" onkeypress="return isNumberSP(event,this.value,this)" value="' + SatStoryPoint + '" placeholder="' + SatStoryPoint + '" name="" data-placement="bottom" title="Story Point" readonly autocomplete="off">';
                            }
                            else {
                                taskHTML += '           <input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6"  type="text" onkeypress="return isNumberSP(event,this.value,this)" value="' + SatStoryPoint + '" placeholder="' + SatStoryPoint + '" name="" data-placement="bottom" title="Story Point" autocomplete="off">';
                            }

                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        //Sunday
                        var NextDay = new Date();
                        dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                        NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 6));
                        //   NextDay.setDate(new Date($("#weekPicker2").attr("StartDate")).getDate() + 6);

                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (SunDescription != "") {
                            taskHTML += '        <i class="far fa-list-alt"></i>'
                        }
                        taskHTML += '        </span>';
                        if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                            taskHTML += '             <input  id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" class="timenoinput dropdown-toggle" type="text" value="' + Sun + '"  name="" role="button" aria-haspopup="true" aria-expanded="true" data-toggle="tooltip" title="Enter Your Effort in hh:mm format" data-placement="bottom" style="pointer-events: none;" readonly>';
                        } else {
                            if (IsSubTaskFilled == 1) {
                                taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" class="timenoinput dropdown-toggle" type="text" value="' + Sun + '"  name="" data-toggle="tooltip" role="button" aria-haspopup="true" aria-expanded="true"  title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57" style="pointer-events: none;"  readonly>';
                            } else {
                                taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" class="timenoinput dropdown-toggle" type="text" value="' + Sun + '"  name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57">';
                            }

                        }
                        taskHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" value="' + SunAllowToResubmit + '" />';
                        taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US")) + '" name="">';
                        taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="' + SunDAID + '" name="">';
                        taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="0" name="">';
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';

                        if (Sun != 0) {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + SunDescription + '</textarea>';
                          
                            if ((SunDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Call Back</label>'
                            }
                            else if ((SunDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Call Back</label>'
                            }
                            else if ((SunDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Call Back</label>'
                            }
                            else if ((SunDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Call Back</label>'
                            }
                            if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {

                            }
                            else {
                                if (PageFlag != 3) {
                                    if (SunDAID != "") {
                                        taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ',7)" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                    }
                                }
                            }
                        }
                        else {
                            taskHTML += '<textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + SunDescription + '</textarea>';
                           
                            if ((SunDAType == 'N') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Call Back</label>'
                            }
                            else if ((SunDAType == 'T') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" checked > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Call Back</label>'
                            }
                            else if ((SunDAType == 'S') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" checked> <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Call Back</label>'
                            }
                            else if ((SunDAType == 'B') && (PageFlag == 1 || PageFlag == '')) {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" checked> <label>Call Back</label>'
                            }
                            else if (PageFlag == 1 || PageFlag == '') {
                                taskHTML += 'Activity: <br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>On Call Support</label><br>'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Over-Time</label> &nbsp'
                                taskHTML += '<input type="radio"  name ="DAType7_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" > <label>Call Back</label>'
                            }
                        }
                        taskHTML += '</div>'
                        taskHTML += '</div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '<span class="timeno">'
                            taskHTML += '<span class="selecttimeno">'
                            if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                taskHTML += '<input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" onkeypress="return isNumberSP(event,this.value,this)" type="text" value="' + SunStoryPoint + '" placeholder="' + SunStoryPoint + '" name="" data-placement="bottom" title="Story Point" readonly autocomplete="off">';
                            }
                            else {
                                taskHTML += '<input data-toggle="tooltip" class="spCls" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" onkeypress="return isNumberSP(event,this.value,this)" type="text" value="' + SunStoryPoint + '" placeholder="' + SunStoryPoint + '" name="" data-placement="bottom" title="Story Point" autocomplete="off">';
                            }

                            taskHTML += '</span>';
                            taskHTML += '</span>';
                        }
                        taskHTML += '</td>';

                        taskHTML += '<td class="' + className + ' daytotlecount">'
                        taskHTML += '<label class="pro_Calculate_count" id = "pro_Calculate_count_' + TaskID + '">' + ActualWork + '</label>'
                        taskHTML += '</td>'
                        taskHTML += '<td><span class="workcomplted">';
                        if (WhichTask != 'D') {
                            if (SubTaskTypeID == 0) {
                                taskHTML += '<input class="" id="WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="text" value="' + ActualPercentComplete + '%" placeholder="' + ActualPercentComplete + '%" name="" onkeypress="return onlyNumbersWithPercent(event)" autocomplete="off"></span></td>'
                                taskHTML += '<input id="RestrictByMinHours_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + RestrictByMinHours + '" name="">';
                            }
                            else {
                                // taskHTML += '<input id="WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="text" value="' + ActualPercentComplete + '%" placeholder="' + ActualPercentComplete + '%" name="" onkeypress="return onlyNumbersWithPercent(event)" autocomplete="off" style="pointer-events:none"></span></td>'
                                taskHTML += '              <input id="RestrictByMinHours_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + RestrictByMinHours + '" name="">';
                            }
                        }
                        taskHTML += '          </span></td>'
                    }
                    else {
                        //Monday
                        taskHTML += '<td class="pr">'
                        taskHTML += '<div class="dropdown">'
                        taskHTML += '<span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (MonDescription != "") {
                            taskHTML += '<i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '</span>';
                        taskHTML += '<label class="pro_Calculate_count" title="Enter Your Effort in hh:mm format" data-toggle="tooltip" data-placement="bottom">' + Mon + '</label>'
                        taskHTML += '<div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '<textarea class="form-control" placeholder="Enter Description..."  maxlength="2000">' + MonDescription + '</textarea>';
                        taskHTML += '</div>'
                        taskHTML += '</div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '<span class="timeno">'
                            taskHTML += '<span class="selecttimeno">'
                            taskHTML += '<label class="pro_Calculate_count" title="Story Point" data-toggle="tooltip" data-placement="bottom">' + MonStoryPoint + '</label>'
                            taskHTML += '</span>';
                            taskHTML += '</span>';
                        }
                        taskHTML += '</td>';

                        //Tuesday
                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (TueDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Enter Your Effort in hh:mm format" data-toggle="tooltip" data-placement="bottom">' + Tue + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description..."  maxlength="2000">' + TueDescription + '</textarea>';
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

                        //Wednesday
                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (WedDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Enter Your Effort in hh:mm format" data-toggle="tooltip" data-placement="bottom">' + Wed + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description..."  maxlength="2000">' + WedDescription + '</textarea>';
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

                        //Thursday
                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (ThuDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Enter Your Effort in hh:mm format" data-toggle="tooltip" data-placement="bottom">' + Thu + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description..."  maxlength="2000">' + ThuDescription + '</textarea>';
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

                        //Friday
                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (FriDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Enter Your Effort in hh:mm format" data-toggle="tooltip" data-placement="bottom">' + Fri + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description..."  maxlength="2000">' + FriDescription + '</textarea>';
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

                        //Saturday
                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (SatDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Enter Your Effort in hh:mm format" data-toggle="tooltip" data-placement="bottom">' + Sat + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description..."  maxlength="2000">' + SatDescription + '</textarea>';
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

                        //Sunday
                        taskHTML += '<td class="pr">'
                        taskHTML += '    <div class="dropdown">'
                        taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom">';
                        if (SunDescription != "") {
                            taskHTML += '           <i class="far fa-list-alt"></i>';
                        }
                        taskHTML += '        </span>';
                        taskHTML += '                        <label class="pro_Calculate_count" title="Enter Your Effort in hh:mm format" data-toggle="tooltip" data-placement="bottom">' + Sun + '</label>'
                        taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        taskHTML += '                  <textarea class="form-control" placeholder="Enter Description..."  maxlength="2000">' + SunDescription + '</textarea>';
                        taskHTML += '              </div>'
                        taskHTML += '    </div>'
                        if (IsAgileProject == 1) {
                            taskHTML += '    <span class="timeno">'
                            taskHTML += '       <span class="selecttimeno">'
                            taskHTML += '                        <label title="Story Point" data-toggle="tooltip" data-placement="bottom" class="pro_Calculate_count">' + SunStoryPoint + '</label>'
                            taskHTML += '       </span>';
                            taskHTML += '    </span>';
                        }
                        taskHTML += '</td>';

                        taskHTML += '                    <td class="daytotlecount">'
                        taskHTML += '                        <label class="pro_Calculate_count">' + ActualWork + '</label>'
                        taskHTML += '                    </td>'

                        taskHTML += '                    <td>'
                        if (WhichTask != 'D') {
                            taskHTML += '                        <label class="pro_Calculate_count">' + ActualPercentComplete + '%</label>'
                        }
                        taskHTML += '                    </td>';

                    }

                    if (WhichTask != 'D') {
                        // 
                        if (SubTaskTypeID == 0) {
                            if (PageFlag != 3) {
                                if (ResourceLevelTaskCompletion == 1) {
                                    taskHTML += '          <td>'
                                    taskHTML += '              <div class="custom_chckbox">'/*custom_chckbox*/
                                    if (IsTaskComplete == 1) {

                                        taskHTML += '<input type="checkbox" name="IsTaskComplete" id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '" checked disabled style="cursor:not-allowed!important">'
                                        taskHTML += '<label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                                    }
                                    else {

                                        //Commented and Added by Usha on 27.12.2018 for disable field on view 

                                        //taskHTML += '                  <input type="checkbox" name="IsTaskComplete" id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '">'
                                        //taskHTML += '                  <label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'

                                        taskHTML += '                  <input type="checkbox" name="IsTaskComplete" ' + strEnableDisable + ' id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '">'
                                        taskHTML += '                  <label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'

                                        //End of Added by Usha on 27.12.2018 for disable field on view 
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
                                taskHTML += '              <div class="custom_chckbox">'/*custom_chckbox*/
                                if (IsTaskComplete == 1) {

                                    taskHTML += '                  <input type="checkbox" name="IsTaskComplete" id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '" checked disabled style="cursor:not-allowed!important">'
                                    taskHTML += '                  <label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" style="cursor:not-allowed!important"></label>'


                                }
                                else {

                                    //Commented and Added by Usha on 27.12.2018 for disable field on view 

                                    //taskHTML += '                  <input type="checkbox" name="IsTaskComplete" id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '">'
                                    //taskHTML += '                  <label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                                    if (IsApprover == 1) {
                                        taskHTML += '                  <input type="checkbox" name="IsTaskComplete" ' + strEnableDisable + ' id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '">'
                                        taskHTML += '                  <label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'

                                    }
                                    else {
                                        taskHTML += '                  <input type="checkbox" name="IsTaskComplete" ' + strEnableDisable + ' id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" disabled value="' + TaskID + '" style="cursor:not-allowed!important">'
                                        taskHTML += '                  <label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" style="cursor:not-allowed!important"></label>'

                                    }

                                    //End of Added by Usha on 27.12.2018 for disable field on view 

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
                    }
                    else {
                        taskHTML += '          <td>'
                        taskHTML += '              <div class="custom_chckbox">'
                        taskHTML += '              <input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                        taskHTML += '              </div>'
                        taskHTML += '          </td>'
                    }

                    if (PageFlag == 3) {
                       // debugger;
                        taskHTML += '<td class="text-center crossandcheckactions">'
                        if (IsApprover == 1) {


                            taskHTML += '<div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn" name="DivAction">'
                            taskHTML += '<div class="input-group">'
                            
                            if (StatusFlag == "J" && $(".Status").html() == "Rejected")//Added & Commented By Dipali V On 25th May  2020
                            {
                                //Added By Usha Pandit On 05.08.2020 For checking if any task is rejected
                                blnIsAnyTaskRejected = true;
                                //End Of Added By Usha Pandit On 05.08.2020 For checking if any task is rejected
                                $("#btnApproveT").css("display", "none");
                            }
                            else if (StatusFlag == "V") {
                                taskHTML += "                                  <button data-toggle='modal' id='btnRejectTask' onclick=RejectPopup(this," + TaskID + ",'" + escape(TaskName) + "'," + ProjectID + ") class='btn btn-outline-secondary btn-red' type='button' data-placement='top' title='' data-original-title='Reject'><i class='fas fa-times'></i></button>"
                            }
                            else {
                                taskHTML += "                                  <button data-toggle='modal' id='btnApproveTask' onclick=ApprovePopup(this," + TaskID + ",'" + escape(TaskName) + "'," + ProjectID + ") class='btn btn-outline-secondary btn-success' type='button' data-placement='top' title='' data-original-title='Approve'><i class='fas fa-check'></i></button>"
                                taskHTML += "                                  <button data-toggle='modal' id='btnRejectTask' onclick=RejectPopup(this," + TaskID + ",'" + escape(TaskName) + "'," + ProjectID + ") class='btn btn-outline-secondary btn-red' type='button' data-placement='top' title='' data-original-title='Reject'><i class='fas fa-times'></i></button>"
                                //Commented And Added By Usha Pandit On 05.08.2020 For checking if any task is rejected
                                //$("#btnApproveT").css("display", "block");
                                if (blnIsAnyTaskRejected == false) {
                                    $("#btnApproveT").css("display", "block");
                                }
                                //End Of Added By Usha Pandit On 05.08.2020 For checking if any task is rejected
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
             //Added By Dipali V On 19thMarch 2021 For Disbaled Quick entry if TS is Submitted
            var Isallowquickentry = 0;
            $("#timesheetBody .timenoinput").each(function () {
               
                var ID = $(this).attr('id');
                if ($("#" + ID).css('pointer-events') == "none") {
                    Isallowquickentry = 0;
                }
                else {
                    Isallowquickentry = 1;
                    return;
                }
            });
            if (Isallowquickentry == 0) {
                $("#txtQuickEntry").attr("disabled","disabled");
            } else {
                $("#txtQuickEntry").removeAttr("disabled", "");
            }
            //End of Added By Dipali V On 19thMarch 2021 For Disbaled Quick entry if TS is Submitted
          
            var taskbodyheight = $(window).height();
            $(".taskdescription").css({ "max-height": taskbodyheight - 500, "overflow-y": "auto" });
            // 
            //        var taskdesc = $(".projecttaskinfo_tooltipbox p").text();
            //        if (taskdesc != "") {
            //            $(".projecttaskinfo_tooltipbox p").css({"height": "300px", "overflow-y": "auto"});
            //}
            // else {
            //            $(".projecttaskinfo_tooltipbox p").css("height", "100%");
            //        }
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
                //Added By Dipali V On 18th jun 2021
                $("#timesheetBody .timenoinput").each(function () {
                    
                     AllText = $("#timesheetBody .timenoinput").length;
                    var attr = $(this).attr("style");
                    if (attr == "pointer-events: none;") {
                        len = len + 1;
                    }
                });
               
                if (AllText == len) {
                    Disabled = 1;
                }
                //End of Added By Dipali V On 18th jun 2021
               
            }
            else {
                $("#weeklyviewcal").hide();
                $("#dailyviewcal").show();
                setWeekCalendar($('#dailyviewdatepicker'), 'yes', 0, startingDayOfWeek, FinancialYearStart, new Date(new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US")), new Date(TodaysDate));
               // $("#dailyviewdatepicker").val(new Date('<%= Request.QueryString("StartDate")%>'));
                Disabled = 0;
                plotDailyTaskList(EmployeeID);
            }
        }


        function plotDailyTaskList(intEmployeeID) {
            // 
          
            var taskHTML = "";
            var taskCounter = 0;
            var subTaskCounter = 0;
            $("#dailyTimesheetTable").html(taskHTML);
            var taskParameters = {
                intEmployeeID: intEmployeeID,
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
                async:false,
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

                    //Commented and Added by Usha on 27.12.2018 for disable field on view 

                    //taskHTML += '             <button id="btnMoreProjects" class="btn borderbtn ml-1 mt-onehalf" data-toggle="modal" data-target="#selectprojecttask" onclick="PlotFilterTaskList(0)" title="Select More Projects" data-placement="bottom">More Projects+</button></span></th>'
                    taskHTML += '             <button id="btnMoreProjects" ' + strEnableDisable + ' class="btn borderbtn ml-1 mt-onehalf" data-toggle="modal" data-target="#" onclick="PlotFilterTaskList(0)" title="Select More Projects" data-placement="bottom">More Projects+</button></span></th>'

                    //End of Added by Usha on 27.12.2018 for disable field on view

                    taskHTML += '         <th>Quick Entry<span class="quickentryrecord" title="Add Quick Entry(hh:mm format)" data-toggle="tooltip" data-placement="bottom"><input type="text" id="txtQuickEntryDaily" value="" placeholder="00:00"  onkeypress="return isNumber(event,this.value,this)" maxlength="5">'

                    //Commented and Added by Usha on 27.12.2018 for disable field on view 

                    //taskHTML += '             <button id="btnQuickEntry" onclick="QuickEntry_Click()"><i class="fas fa-check"></i></button>'
                    taskHTML += '             <button id="btnQuickEntry" ' + strEnableDisable + ' onclick="QuickEntry_Click()"><i class="fas fa-check"></i></button>'

                    //End of Added by Usha on 27.12.2018 for disable field on view

                    taskHTML += '         </span></th>'
                    for (var i = 0; i < headerColumns.length; i++) {
                        //
                        var header = headerColumns[i];
                        var EntryDate = header.EntryDate;
                        var DayName = header.DayName;
                        var IsWorking = header.IsWorking;
                        var IsWeekendPresent = "";
                        //taskHTML += "<th>";
                        //taskHTML += '' + EntryDate + ',<span>' + DayName + '</span>'
                        //taskHTML += "</th>";
                        if (IsWorking == 1) {
                            taskHTML += "<th class='weekcolumnred'>";
                        }
                        else if (IsWorking == 2) {
                            taskHTML += '<th class="weekdayscol">';
                        }
                        else if (IsWorking == 4) {
                            IsWeekendPresent = 0;
                            taskHTML += '<th>';
                        }
                        else if (IsWorking == 3) {
                            taskHTML += "<th class='weekcolumnred'>";
                        }
                        else if (IsWorking == 5) {
                            taskHTML += "<th class='weekcolumnred exapnd_and_collaps_column weekdayscol'>";
                        }
                        else {
                            taskHTML += "<th>";
                        }


                        taskHTML += '' + EntryDate + ',<span>' + DayName + '</span>'
                        taskHTML += "</th>";
                    }


                    taskHTML += '         <th>Weekly<span>total</span></th>'
                    taskHTML += '         <th>% Work <span>Complete</span></th>'
                    taskHTML += '         <th>Task <span>Complete</span></th>'
                    taskHTML += '     </tr>'
                    for (var i = 0; i <= WeekTotalLists.length - 1; i++) {
                        var WeekTotalObject = WeekTotalLists[i];
                        //var Total = WeekTotalObject.Total;

                        //var Total = WeekTotalObject.Total;

                        //Commented and Added By Reshma for Issue
                        var Total = '' + WeekTotalObject.Total + '';
                        //alert(Total.length);
                        if (Total.length == 1) {
                            var fmtTotal = '0' + Total + ':00';
                            Total = fmtTotal;
                        }
                        if (Total.length == 2) {
                            var fmtTotal = Total + ':00';
                            Total = fmtTotal;
                        }
                        if (Total.length == 3) {
                            var fmtTotal = Total.replace('.', ':');
                            fmtTotalx = fmtTotal.indexOf(':');
                            if (fmtTotalx == 1) {
                                Total = '0' + fmtTotal + '0';
                            }
                            if (fmtTotalx == -1) {
                                Total = Total + ':00';
                            }
                        }
                        if (Total.length == 4) {
                            var fmtTotal = Total.replace('.', ':');
                            fmtTotalx = fmtTotal.indexOf(':');
                            if (fmtTotalx == 2)
                                Total = '' + fmtTotal + '0';
                            if (fmtTotalx == 1)
                                Total = '0' + fmtTotal + '';
                        }
                        if (Total.length >= 5) {

                            var fmtTotal = Total.replace('.', ':');
                            fmtTotalx = fmtTotal.indexOf(':');
                            if (fmtTotalx == 1)
                                Total = '0' + fmtTotal + '';
                            if (fmtTotalx == 2)
                                Total = '' + fmtTotal + '';
                            if (fmtTotalx == 3) {
                                Total = fmtTotal + '0';
                            }
                            if (fmtTotalx == 4 && fmtTotal.length > 5) {
                                Total = fmtTotal + '0';
                            }
                            else {
                                Total = fmtTotal;
                            }
                        }
                        //Adding Ends here for issue

                        var EntryDate = WeekTotalObject.EntryDate;
                        //var AllTotal = WeekTotalObject.AllTotal;

                        //AllTotal = WeekTotalObject.AllTotal;

                        //AllTotal = WeekTotalObject.AllTotal;
                        var AllTotal = '' + WeekTotalObject.AllTotal + '';
                        //alert(Total.length);
                        if (AllTotal.length == 1) {
                            var fmtTotal = '0' + AllTotal + ':00';
                            AllTotal = fmtTotal;
                        }
                        if (AllTotal.length == 2) {
                            var fmtAllTotal = AllTotal + ':00';
                            AllTotal = fmtAllTotal;
                        }
                        if (AllTotal.length == 3) {
                            var fmtAllTotal = AllTotal.replace('.', ':');
                            fmtAllTotalx = fmtAllTotal.indexOf(':');
                            if (fmtAllTotalx == 1) {
                                AllTotal = '0' + fmtAllTotal + '0';
                            }
                            if (fmtAllTotalx == -1) {
                                AllTotal = AllTotal + ':00';
                            }
                        }
                        if (AllTotal.length == 4) {
                            var fmtAllTotal = AllTotal.replace('.', ':');
                            fmtAllTotalx = fmtAllTotal.indexOf(':');
                            if (fmtAllTotalx == 2)
                                AllTotal = '' + fmtAllTotal + '0';
                            if (fmtAllTotalx == 1)
                                AllTotal = '0' + fmtAllTotal + '';
                        }
                        if (AllTotal.length >= 5) {

                            var fmtAllTotal = AllTotal.replace('.', ':');
                            fmtAllTotalx = fmtAllTotal.indexOf(':');
                            if (fmtAllTotalx == 1)
                                AllTotal = '0' + fmtAllTotal + '';
                            if (fmtAllTotalx == 2)
                                AllTotal = '' + fmtAllTotal + '';
                            if (fmtAllTotalx == 3) {
                                AllTotal = fmtAllTotal + '0';
                            }
                            if (fmtAllTotalx == 4 && fmtAllTotal.length > 5) {
                                AllTotal = fmtAllTotal + '0';
                            }
                            else {
                                AllTotal = fmtAllTotal;
                            }
                        }

                        var WeekDays = WeekTotalObject.WeekDays;
                        taskHTML += '     <tr class="task totalworkcountrow">'
                        taskHTML += '         <th class="totalworkcountrow">Total work for a week</th>'
                        taskHTML += '         <th>&nbsp;</th>'
                        taskHTML += '         <th>'
                        taskHTML += '             <label class="pro_Calculate_count">' + Total + '</label>'
                        taskHTML += '         </th>'
                        taskHTML += '         <th>'
                        taskHTML += '             <label class="pro_Calculate_count" id="IdAllTotal_Daily">' + AllTotal + '</label>'
                        taskHTML += '         </th>'
                        taskHTML += '         <th>&nbsp;</th>'
                        taskHTML += '         <th>&nbsp;</th>'
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
                        //Added By Nikhil Adkar on 10-Sept-2024 for Showing DA Type
                        var DAType = task.DAType;
                         //End of Added By Nikhil Adkar on 10-Sept-2024 for Showing DA Type
                        //var Duration = task.Duration;

                        //Commented and added By reshma For Issue ID=16762
                        var Duration = '' + task.Duration + '';
                        //alert(Duration.length);
                        if (Duration.length == 1) {
                            var fmtDuration = '0' + Duration + ':00';
                            Duration = fmtDuration;
                        }
                        if (Duration.length == 2) {
                            var fmtDuration = Duration + ':00';
                            Duration = fmtDuration;
                        }
                        if (Duration.length == 3) {
                            var fmtDuration = Duration.replace('.', ':');
                            fmtDurationx = fmtDuration.indexOf(':');
                            if (fmtDurationx == 1) {
                                Duration = '0' + fmtDuration + '0';
                            }
                            if (fmtDurationx == -1) {
                                Duration = Duration + ':00';
                            }
                        }
                        if (Duration.length == 4) {
                            var fmtDuration = Duration.replace('.', ':');
                            fmtDurationx = fmtDuration.indexOf(':');
                            if (fmtDurationx == 2)
                                Duration = '' + fmtDuration + '0';
                            if (fmtDurationx == 1)
                                Duration = '0' + fmtDuration + '';
                        }
                        if (Duration.length >= 5) {

                            var fmtDuration = Duration.replace('.', ':');
                            fmtDurationx = fmtDuration.indexOf(':');
                            if (fmtDurationx == 1)
                                Duration = '0' + fmtDuration + '';
                            if (fmtDurationx == 2)
                                Duration = '' + fmtDuration + '';
                            if (fmtDurationx == 3) {
                                Duration = fmtDuration + '0';
                            }
                            if (fmtDurationx == 4 && fmtDuration.length > 5) {
                                Duration = fmtDuration + '0';
                            }
                            else {
                                Duration = fmtDuration;
                            }
                        }
                        //End Added here for Issue ID=16762

                        var DayName = task.DayName;
                        //var ActualWork = task.ActualWork;

                        //Commented and added By Reshma for Issue ID=16762
                        var ActualWork = '' + task.ActualWork + '';
                        if (ActualWork.length == 1) {
                            var fmtActualWork = '0' + ActualWork + ':00';
                            ActualWork = fmtActualWork;
                        }
                        if (ActualWork.length == 2) {
                            var fmtActualWork = ActualWork + ':00';
                            ActualWork = fmtActualWork;
                        }
                        if (ActualWork.length == 3) {
                            var fmtActualWork = ActualWork.replace('.', ':');
                            fmtActualWorkx = fmtActualWork.indexOf(':');
                            if (fmtActualWorkx == 1) {
                                ActualWork = '0' + fmtActualWork + '0';
                            }
                            if (fmtActualWorkx == -1) {
                                ActualWork = ActualWork + ':00';
                            }
                        }
                        if (ActualWork.length == 4) {
                            var fmtActualWork = ActualWork.replace('.', ':');
                            fmtActualWorkx = fmtActualWork.indexOf(':');
                            if (fmtActualWorkx == 2)
                                ActualWork = '' + fmtActualWork + '0';
                            if (fmtActualWorkx == 1)
                                ActualWork = '0' + fmtActualWork + '';
                        }
                        if (ActualWork.length >= 5) {

                            var fmtActualWork = ActualWork.replace('.', ':');
                            fmtActualWorkx = ActualWork.indexOf(':');
                            if (fmtActualWorkx == 1)
                                ActualWork = '0' + fmtActualWork + '';
                            if (fmtActualWorkx == 2)
                                ActualWork = '' + fmtActualWork + '';
                            if (fmtActualWorkx == 3) {
                                ActualWork = fmtActualWork + '0';
                            }
                            if (fmtActualWorkx == 4 && fmtActualWork.length > 5) {
                                ActualWork = fmtActualWork + '0';
                            }
                            else {
                                ActualWork = fmtActualWork;
                            }
                        }
                        //Added Ends here for Issue ID=16762

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
                        var AllowActivityLevelDA = task.AllowActivityLevelDA;
                        var StatusFlag = task.StatusFlag;
                        var IsSubTaskFilled = task.IsSubTaskFilled;
                        var AllowToResubmit = task.AllowToResubmit;
                        //Added By Dipali V On 18th jun 2021
                        if (StatusFlag == "" || StatusFlag==null) {
                            if (Disabled == 1) {
                                StatusFlag = "R";
                            }
                        }
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
                            taskHTML += '                                        <a id="btnMoreProjectTaskLevel" name="btnMoreProjectTaskLevel" class="nostyle hidden-xs" data-toggle="modal" data-target="#" onclick="PlotFilterTaskList(' + ProjectID + ')">';
                            taskHTML += '                                            <img data-toggle="tooltip" data-placement="top" title="Select Project" src="../../../Whizible2.0/dist/img/Sub-tasks.svg" alt="" class="" width="15px"></a>'
                            taskHTML += '                                        <a class="nostyle hidden-xs" id="UpDownArrow" data-toggle="collapse" data-target=".projecthide' + ProjectID + '">'
                            taskHTML += '                                            <img data-toggle="tooltip" data-placement="top" title="Hide Task" src="../../../Whizible2.0/dist/img/up.svg" alt="" class="" width="15px"></a>'
                            taskHTML += '                                    </div>'
                            taskHTML += '                        </div>'
                            taskHTML += '                    </td>'
                            taskHTML += '                    <td>'
                            taskHTML += '                        <label class="pro_Calculate_count">&nbsp;</label>'
                            taskHTML += '                    </td>'
                            taskHTML += '                    <td class="daytotlecount">'
                            taskHTML += '                        <label class="pro_Calculate_count">' + Duration + '</label>'
                            taskHTML += '                    </td>'
                            taskHTML += '                    <td class="daytotlecount">'
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
                            if (Tasknotes != "") {
                                taskHTML += '<p class="taskdescription">' + Tasknotes + '</p>';
                            }
                            else {
                                taskHTML += '<p>' + Tasknotes + '</p>';
                            }
                            taskHTML += '<div class="projecttaskinfo_tooltipbox_schedule">'
                            taskHTML += '<div class="row">'
                            taskHTML += '<div class="col-xs-5">Start Date:</div>'
                            taskHTML += '<div class="col-xs-7">' + StartDate + '</div>'
                            taskHTML += '</div>'
                            taskHTML += '<div class="row">'
                            taskHTML += '<div class="col-xs-5">End Date:</div>'
                            taskHTML += '<div class="col-xs-7">' + EndDate + '</div>'
                            taskHTML += '</div>';
                            if (WhichTask != 'D') {
                                taskHTML += '<div class="row">'
                                taskHTML += '<div class="col-xs-5">Allocated Work:</div>'
                                taskHTML += '<div class="col-xs-7">' + Work + '</div>'
                                taskHTML += '</div>'
                            }
                          
                            taskHTML += '<div class="row">'
                            taskHTML += '<div class="col-xs-5">Actual Work:</div>'
                            taskHTML += '<div class="col-xs-7">' + TaskActualWork + '</div>'

                            //Added By Usha Pandit On 18.05.2021 For correct DA duration selection
                            taskHTML += '<input id="TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ConvertToDecimal(Work) + '"</input>'
                            taskHTML += '<input id="TotalActualDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ConvertToDecimal(TaskActualWork) + '"</input>'
                            taskHTML += '<input id="TotalActualDynamicDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ConvertToDecimal(TaskActualWork) + '"</input>';
                            //End Of Added By Usha Pandit On 18.05.2021 For correct DA duration selection
                            taskHTML += '</div>'
                            taskHTML += '</div>'
                            taskHTML += ''
                            taskHTML += '<hr />'
                            taskHTML += '<div class="projecttaskinfo_tooltipbox_schedule">'

                            if (Phase != '') {
                                taskHTML += '<div class="row">'
                                taskHTML += '<div class="col-xs-5">Phase:</div>'
                                taskHTML += '<div class="col-xs-7"><span class="issuetext" title="' + Phase + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + Phase + '</span></div>'
                                taskHTML += '</div>'
                            }
                            if (MileStone != '') {
                                taskHTML += '<div class="row">                                                                                                                            '
                                taskHTML += '<div class="col-xs-5">Milestone:</div>                                                                                                   '
                                taskHTML += '                                                  <div class="col-xs-7"><span class="issuetext" title="' + MileStone + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + MileStone + '</span></div>                                                                                                  '
                                taskHTML += '                                              </div>                                                                                                                                       ';
                            }
                            if (SubProjectName != '') {
                                taskHTML += '                                              <div class="row">                                                                                                                            '
                                taskHTML += '                                                  <div class="col-xs-5">Sub Project:</div>                                                                                                 '
                                taskHTML += '                                                  <div class="col-xs-7"><span class="issuetext" title="' + SubProjectName + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + SubProjectName + '</span></div>                                                                                   '
                                taskHTML += '                                              </div>';
                            }
                            if (DeliverableName != '') {
                                taskHTML += '                                              <div class="row">                                                                                                                            '
                                taskHTML += '                                                  <div class="col-xs-5">Deliverable:</div>                                                                                                 '
                                taskHTML += '                                                  <div class="col-xs-7"><span class="issuetext" title="' + DeliverableName + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + DeliverableName + '</span></div>                                                                                   '
                                taskHTML += '                                              </div>';
                            }
                            if (ModuleName != '') {
                                taskHTML += '                                              <div class="row">                                                                                                                            '
                                taskHTML += '                                                  <div class="col-xs-5">Module:</div>                                                                                                 '
                                taskHTML += '                                                  <div class="col-xs-7"><span class="issuetext" title="' + ModuleName + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + ModuleName + '</span></div>                                                                                   '
                                taskHTML += '                                              </div>';
                            }
                            if (Issue != '') {
                                taskHTML += '<div class="row">                                                                                                                            '
                                taskHTML += '<div class="col-xs-5">Issue:</div>                                                                                                       '
                                taskHTML += '<div class="col-xs-7"><span class="issuetext" title="' + Issue + '"  data-toggle="tooltip" data-placement="top" data-container="body">' + Issue + '</span></div>                                                                                   '
                                taskHTML += '</div>                                                                                                                                       '
                            }
                            taskHTML += '</div>                                                                                                                                           '
                            taskHTML += ''
                            taskHTML += '</div>                                                                                                                                               '
                            taskHTML += '</div>                                                                                                                                                   '
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
                            if (IsTaskComplete == 0) {
                                taskHTML += '                              <a name="btnTSActions" data-toggle="dropdown" class="nostyle hidden-xs dropdown-toggle" ><i class="fas fa-ellipsis-h" title="More Action" data-toggle="tooltip" data-placement="top"></i></a>'
                            }
                            taskHTML += '                              <ul id="projects-menu" class="dropdown-menu clearfix" role="menu">'
                            if (SubTaskTypeID == 0) {
                                if (IsTaskComplete == 0) {
                                    if (AllowActivityLevelDA == 1) {
                                        taskHTML += '                                  <li data-toggle="tooltip" data-placement="top" title="Add Sub Tasks">'
                                        taskHTML += '                                      <a href="#" class="nostyle hidden-xs" data-toggle="modal" data-target="#selectsubtask" onclick="PlotSubTaskList(' + ProjectID + ',' + TaskID + ')"">'
                                        taskHTML += '                                          <img src="../../../Whizible2.0/dist/img/Sub-tasks.svg" alt="" class="" width="15px">'
                                        taskHTML += '                                          Add Sub Tasks</a>'
                                        taskHTML += '                                  </li>'
                                    }
                                    if (WhichTask != "D") {
                                        taskHTML += '  '
                                        taskHTML += '                                  <li data-toggle="tooltip" data-placement="top" title="Schedule Time Entry">'
                                        taskHTML += '                                      <a href="#" class="nostyle hidden-xs" data-toggle="modal" data-target="#Schedule" onclick="PlotScheduleTSEntryData(' + TaskID + ',' + SubTaskTypeID + ')">'
                                        taskHTML += '                                          <img src="../../../Whizible2.0/dist/img/Calendar with clock.svg" alt="" class="" width="15px">'
                                        taskHTML += '                                          Schedule Time Entry</a>'
                                        taskHTML += '                                  </li>'
                                    }
                                }
                            }
                            if ((WhichTask == "M" || WhichTask == "O") && IsTaskComplete == 0) {
                                taskHTML += '                                  <li data-toggle="tooltip" data-placement="top" title="Request Additional Time">'
                                taskHTML += '                                      <a href="#" class="nostyle hidden-xs" data-toggle="modal" data-target="#requestadditionaltime" onclick="PlotAdditionalTimeRequestData(' + TaskID + ',' + SubTaskTypeID + ')">'
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
                            if (IsTaskComplete == 0) {
                                taskHTML += '                  <input type="checkbox" name="chkQuickEntryDaily" id="chkQuickEntryDaily_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '">'
                            }
                            else {
                                taskHTML += '                  <input type="checkbox" name="chkQuickEntryDaily" id="chkQuickEntryDaily_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '" disabled style="cursor:not-allowed!important">'
                            }
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
                                    taskHTML += '             <input  id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="timenoinput dropdown-toggle" type="text" value="' + Duration + '"  name="" role="button" aria-haspopup="true" aria-expanded="true" data-toggle="tooltip" title="Enter Your Effort in hh:mm format" data-placement="bottom" style="pointer-events: none;" readonly>';
                                } else {
                                    if (IsSubTaskFilled == 1) {
                                        taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="timenoinput dropdown-toggle" type="text" value="' + Duration + '"  name="" data-toggle="tooltip" role="button" aria-haspopup="true" aria-expanded="true" title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57" style="pointer-events: none;"  readonly>';
                                    } else {
                                        taskHTML += '             <input maxlength="5" OnBlur=Hours_OnChange(this); id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="timenoinput dropdown-toggle" type="text" value="' + Duration + '"  name="" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true" title="Enter Your Effort in hh:mm format" data-placement="bottom" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57">';
                                    }

                                }

                                taskHTML += '              <input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + (new Date($('#dailyviewdatepicker').attr("selecteddate")).toLocaleDateString("en-US")) + '" name="">';
                                taskHTML += '              <input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + DAID + '" name="">';
                                taskHTML += '              <input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="0" name="">';
                                taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                                
                                if (Duration != 0) {
                                    taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + Description + '</textarea>';
                                    if (DAType == "N") {
                                        taskHTML += 'Activity: <br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>On Call Support</label><br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" > <label>Over-Time</label> &nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>Call Back</label>'
                                    }
                                    else if (DAType == "T") {
                                        taskHTML += 'Activity: <br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>On Call Support</label><br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" checked> <label>Over-Time</label> &nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>Call Back</label>'
                                    }
                                    else if (DAType == "S") {
                                        taskHTML += 'Activity: <br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" checked> <label>On Call Support</label><br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"> <label>Over-Time</label> &nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>Call Back</label>'
                                    }
                                    else if (DAType == "B") {
                                        taskHTML += 'Activity: <br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"> <label>On Call Support</label><br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"> <label>Over-Time</label> &nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" checked> <label>Call Back</label>'
                                    }
                                    else {
                                        taskHTML += 'Activity: <br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>On Call Support</label><br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>Over-Time</label> &nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>Call Back</label>'
                                    }
                                    
                                    if (StatusFlag == 'R' || StatusFlag == 'V') {

                                    }
                                    else {
                                        if (PageFlag != 3) {
                                            if (DAID != "") {
                                                taskHTML += '                  <button name="btnDescriptionSave" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SubTaskTypeID + ')" class="btn btnyellow mt-onehalf pull-right">Save</button>'
                                            }
                                        }
                                    }
                                }
                                else {
                                    taskHTML += '                  <textarea id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="form-control" placeholder="Enter Description..."  maxlength="2000" onkeyup=limitText(this,2000)>' + Description + '</textarea>';
                                    if (DAType == "N") {
                                        taskHTML += 'Activity: <br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>On Call Support</label><br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>Over-Time</label> &nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>Call Back</label>'
                                    }
                                    else if (DAType == "T") {
                                        taskHTML += 'Activity: <br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>On Call Support</label><br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" checked> <label>Over-Time</label> &nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>Call Back</label>'
                                    }
                                    else if (DAType == "S") {
                                        taskHTML += 'Activity: <br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" checked> <label>On Call Support</label><br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"> <label>Over-Time</label> &nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>Call Back</label>'
                                    }
                                    else if (DAType == "B") {
                                        taskHTML += 'Activity: <br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"> <label>On Call Support</label><br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'"> <label>Over-Time</label> &nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" checked> <label>Call Back</label>'
                                    }
                                    else {
                                        taskHTML += 'Activity: <br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" checked> <label>Normal</label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>On Call Support</label><br>'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>Over-Time</label> &nbsp'
                                        taskHTML += '<input type="radio"  name ="DailyDAType1_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  id="DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID +'" > <label>Call Back</label>'
                                    }

                                }
                                taskHTML += '              </div>'
                                taskHTML += '    </div>'
                                if (IsAgileProject == 1) {
                                    taskHTML += '    <span class="timeno">'
                                    taskHTML += '       <span class="selecttimeno">'
                                    if (StatusFlag == 'R' || StatusFlag == 'V') {
                                        taskHTML += '           <input data-toggle="tooltip" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" onkeypress="return isNumberSP(event,this.value,this)" data-placement="bottom" title="Story Point" type="text" value="' + StoryPoint + '" placeholder="' + StoryPoint + '" name="" data-placement="bottom" title="Story Point" readonly autocomplete="off">';
                                    }
                                    else {
                                        taskHTML += '           <input data-toggle="tooltip" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" onkeypress="return isNumberSP(event,this.value,this)" data-placement="bottom" title="Story Point" type="text" value="' + StoryPoint + '" placeholder="' + StoryPoint + '" name="" data-placement="bottom" title="Story Point" autocomplete="off">';
                                    }

                                    taskHTML += '       </span>';
                                    taskHTML += '    </span>';
                                }
                                taskHTML += '</td>';
                            }
                            else {
                                taskHTML += '<td class="pr">'
                                taskHTML += '    <div class="dropdown">'
                                taskHTML += '        <span class="notelisticon dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Description" data-placement="bottom"><i class="far fa-list-alt"></i></span>'
                                taskHTML += '                        <label class="pro_Calculate_count" title="Enter Your Effort in hh:mm format" data-toggle="tooltip" data-placement="bottom">' + Duration + '</label>'
                                taskHTML += '             <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                                taskHTML += '                  <textarea class="form-control" placeholder="Enter Description..."  maxlength="2000">' + Description + '</textarea>';
                                taskHTML += '              </div>'
                                taskHTML += '    </div>'
                                if (IsAgileProject == 1) {
                                    taskHTML += '    <span class="timeno">'
                                    taskHTML += '       <span class="selecttimeno">'
                                    taskHTML += '                        <label title="Story Point" data-toggle="tooltip" data-placement="bottom" class="pro_Calculate_count">' + StoryPoint + '</label>'
                                    taskHTML += '       </span>';
                                    taskHTML += '    </span>';
                                }
                                taskHTML += '</td>';
                            }

                            taskHTML += '   <td class="daytotlecount"> <label class="pro_Calculate_count">' + ActualWork + '</label></td>'


                            taskHTML += '   <td><span class="workcomplted">'
                            if (WhichTask != 'D') {
                                if (SubTaskTypeID == 0) {

                                    taskHTML += '       <input id="dailyWorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="text" value="' + ActualPercentComplete + '%" placeholder="' + ActualPercentComplete + '%" name="" autocomplete="off">'


                                }

                            }
                            taskHTML += '   </span></td>';
                            if (WhichTask != 'D') {
                                if (SubTaskTypeID == 0) {
                                    if (ResourceLevelTaskCompletion == 1) {
                                        taskHTML += '          <td>'
                                        taskHTML += '              <div class="">'/*custom_chckbox*/
                                        if (IsTaskComplete == 1) {
                                            taskHTML += '                  <input type="checkbox" name="IsTaskComplete" id="dailyIsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '" checked disabled style="cursor:not-allowed!important;>'
                                        }
                                        else {

                                            //Commented and Added by Usha on 27.12.2018 for disable field on view 

                                            //taskHTML += '                  <input type="checkbox" name="IsTaskComplete" id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '">'
                                            taskHTML += '                  <input type="checkbox" name="IsTaskComplete" ' + strEnableDisable + ' id="dailyIsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" value="' + TaskID + '">'

                                            //End of Added by Usha on 27.12.2018 for disable field on view 
                                        }
                                        taskHTML += '                  <label for="dailyIsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
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
                    var taskbodyheight = $(window).height();
                    $(".taskdescription").css({ "max-height": taskbodyheight - 500, "overflow-y": "auto" });
                    // 
                    //var taskdesc = $(".projecttaskinfo_tooltipbox p").text();
                    //if (taskdesc != "") {
                    //    $(".projecttaskinfo_tooltipbox p").css({"height": "300px", "overflow-y": "auto"});
                    //}
                    // else {
                    //    $(".projecttaskinfo_tooltipbox p").css("height", "100%");
                    //}
                    AfterPlot();
                    StopAjaxLoader("#bodyTSEntry");
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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
                    selHTML += "<option  selected  value=''>Select Project</option>"
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
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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
                    selHTML += "<option   selected  value=''>Select Task Type</option>"
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
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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
                    selHTML += "<option  selected  value=''>Select Sub Task Type</option>"
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
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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
        function CheckHHMMFormat(obj) {
            //alert(obj.value);
            var totalDuration = obj.value.replace(".", ":");
            if (!(/^\d{2}:\d{2}$/.test(totalDuration))) {
                return true;
            }
            return false;
        }
        function onlyNumbersWithPercent(e) {
            //
            var charCode;
            if (e.keyCode > 0) {
                charCode = e.which || e.keyCode;
            }
            else if (typeof (e.charCode) != "undefined") {
                charCode = e.which || e.keyCode;
            }
            if (charCode == 37 || charCode == 46)
                return true
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
        function checkNumber(sNum) {
            var pattern = /^\d+(\.\d{1,2})?$/;
            if (pattern.test(sNum)) {
                return true;
            }
            else {
                return false;
            }
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
            $('.ClosaeblealertMsg').delay(6000).fadeOut("fast", function () {
                if (id != undefined) {
                    $('#' + id).prop("disabled", false);
                }
            });
        }


        function CloseShowAlert() {
            $('.ClosaeblealertMsg').hide();
        }

        var StoryPointCount = 0;
         var OldTaskID=0, CurrentTaskID = 0;
        function StoryPoint_OnChange(objTextBox) {
            
            //StoryPointCount = 0;
            var fn_argument = arguments.length;
           
            var Isvalid = 0;
            if (isNaN(objTextBox.value)) {
                showAlert('Please enter numeric value', 'alert-danger');
                objTextBox.value = "";
                Isvalid = 1;
                // return false;
            }
            if (objTextBox.value != "") {
                if (RestrictNonNumeric(objTextBox) == true) {
                    showAlert('Please Enter positive numeric value for Story Point', 'alert-danger');
                    objTextBox.value = "";
                    Isvalid = 1;
                    // return false;
                }
                if (objTextBox.value < "0") {
                    showAlert('Please Enter only positive numeric value greater than 0 For Story Point', 'alert-danger');
                    objTextBox.value = "";
                    Isvalid = 1;
                    //return false;
                }

                // data = JSON.stringify({ TaskID: TaskID, StoryPoint: objTextBox.value });
                // strResult = AJAXCallWithResult("TS_Scrum_WeeklyTimesheet.aspx/ValidateStoryPoint", data, false);
                if (objTextBox.value != objTextBox.defaultValue) {
                
                 
                    var EntryID = (objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'Entry');
                    var DAID=(objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'DA');
                    var arrData = EntryID.split('_');
                    var ProjectID = arrData[1];
                    var TaskID = arrData[2];
                    var SubTaskTypeID = arrData[3];
                    //var TaskID = getNewTaskID(id);
                    var objEntryDate = document.getElementById(EntryID);
                    var objDAID =document.getElementById(DAID);
                    //    arrayWeekDays = ["mon", "tue", "wed", "thu", "fri","sat","sun"];
                    //for (var k = 0; k < arrayWeekDays.length; k++) {

                    //          StoryPointCount =StoryPointCount + ((document.getElementById('StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1)).value)- 0);
                    //}
                    //debugger;
                    CurrentTaskID = TaskID;
                    if (OldTaskID == 0) {
                        OldTaskID = CurrentTaskID;
                    }
                
                  
                    if (fn_argument == 2) {
                        if (CurrentTaskID == OldTaskID) {
                            StoryPointCount = (StoryPointCount - 0) + (objTextBox.value - 0);
                        }
                        else {
                            StoryPointCount = 0;
                        }

                        var taskParameters = {
                            TaskID: TaskID,
                            StoryPoint: StoryPointCount,
                            dtFromDate: objEntryDate.value,
                            DAID:objDAID.value,
                        }
                    }
                    else {
                        var taskParameters = {
                            TaskID: TaskID,
                            StoryPoint: objTextBox.value,
                            dtFromDate: objEntryDate.value,
                            DAID:objDAID.value,
                        }
                    }
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
                                //
                                showAlert(data, 'alert-danger');
                                //Commented for after alert field is blank
                                objTextBox.value = "0";
                               // objTextBox.focus();
                                Isvalid = 1;
                                //return false;
                            }
                        },
                        error: function (err) {
                            console.log(err);
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
            }
            if (Isvalid == 1) {
                //  
                return false;
            }
            else {
                return true
            }
        }
        function WorkComplete_OnChange(objTextBox) {
            if (objTextBox.value > 100) {
                showAlert('Percentage completion should not exceed 100.', 'alert-danger');
            }
        }
        var DATextbox;
        var objDuChRow;

        //Added By Usha Pandit On 30.07.2019 for DA fill 24 hours per day validation   
        function getPosition(string, subString, index) {
            return string.split(subString, index).join(subString).length;
        }
        //End Of Added By Usha Pandit On 30.07.2019 for DA fill 24 hours per day validation   
        //Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
        var totalEnteredHours = 0;
        var totalEnteredNewHours = 0;
        var totalEnteredDynamicHours = 0;
        var DynamicDurationhiddenId = '';
        var totalEnteredDynamicWeekHours = 0;
        var totalActualPreviousWeekHours = 0;
        var totalActualPreviousWeekHoursWeekly = 0;
        var TotalAllocationDurationhidden = 0;
        //End of Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
        function Hours_OnChange(objTextBox) {

            debugger
            var Isvalid = 0;
            var fn_argument = arguments.length;


            if (objTextBox.Value != "") {
                var dblColSum;
                dblColSum = 0;

                var objHoursComplete = document.getElementById(objTextBox.id);

                // if (RestrictNonNumeric(objHoursComplete) == true) {
                //    showAlert('Please enter numeric values for duration proper in hh:mm format.', 'alert-danger');
                //    Isvalid = 1;
                //    objHoursComplete.value = objHoursComplete.value.replace(".", ":");
                //    return false;
                //}
                // var ObjNewValue = objHoursComplete.value;
                
                objHoursComplete.value = ConvertToDecimal(objHoursComplete.value);
                
                objHoursComplete.value = objHoursComplete.value.replace(/:/g, ".");
               
                // alert(escape(objHoursComplete.value));
                //alert(unescape(objHoursComplete.value));
                var EntryID = (objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'Entry');
                var arrData = EntryID.split('_')
                var ProjectID = arrData[1];
                var TaskID = arrData[2];
                var SubTaskTypeID = arrData[3];
                var objEntryDate = document.getElementById(EntryID);
                var objIsTaskComplete = document.getElementById('IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                var IsTaskCompleteCheck = 0;
                var RestrictByMinHours = document.getElementById('RestrictByMinHours_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                var objAllowToResubmit = document.getElementById('txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                if (objIsTaskComplete != null)
                    IsTaskCompleteCheck = objIsTaskComplete.checked;
                objDuChRow = (objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'txtDuChRow');
                var precision = objHoursComplete.value.split(".")[1];
                //if (RestrictByMinHours != null) {
                //    if (RestrictByMinHours.value == 1) {
                if (precision > 60) {
                    //showAlert('Please enter minutes less than 60.', 'alert-danger');
                    showAlert('Please enter minutes in two decimal and less than 60.', 'alert-danger');
                    Isvalid = 1;
                    //return false;
                }
                //    }
                //}

                if (precision == 60) {
                    objHoursComplete.value = (objHoursComplete.value.split(".")[0] - 0) + 1;
                    Hours_OnChange(objTextBox);
                    return false;
                }
                DATextbox = objTextBox.id;
                // 

                if (CheckHHMMFormat(objHoursComplete) == true) {
                    showAlert('Please enter numeric values for duration proper in hh:mm format.', 'alert-danger');
                    Isvalid = 1;
                    objHoursComplete.value = objHoursComplete.value.replace(".", ":");
                    return false;
                }
                if (RestrictNonNumeric(objHoursComplete) == true) {
                    showAlert('Please enter numeric values for duration proper in hh:mm format.', 'alert-danger');
                    Isvalid = 1;
                    objHoursComplete.value = objHoursComplete.value.replace(".", ":");
                    return false;
                }

                if (objHoursComplete.value.indexOf(".") == -1) {
                    showAlert('Please enter duration in hh:mm format.', 'alert-danger');
                    Isvalid = 1;
                    objHoursComplete.value = objHoursComplete.value.replace(".", ":");
                    return false;
                }
                //
                var ObjOldValue = objHoursComplete.defaultValue.replace(/:/g, ".")
                var ObjNewvalue = objHoursComplete.value;
                var onjNewIndex = objHoursComplete.value.split(".")[0];
                if (onjNewIndex.length == 1) {
                    ObjNewvalue = '0' + ObjNewvalue;
                }

                // objHoursComplete.value = ObjNewvalue;
                //if (precision == undefined) {
                //    var ObjOldValue = objHoursComplete.defaultValue + '.00';
                //}
                //else {
                //    var ObjOldValue = (objHoursComplete.defaultValue - 0).toFixed(2);

                //}
                if (RestrictNonNumeric(objHoursComplete) == true) {
                    showAlert('Please enter numeric values.', 'alert-danger');
                    Isvalid = 1;
                    //return false;
                }

                if ((objHoursComplete.value - 0) >= 0 && (objHoursComplete.value - 0) <= intMaxEntry) {
                } else {
                     
                    //Commented & Added By Dipali v on 9th April 2019 For Consists Alter
                    //showAlert('The Range of Actual Working Hours is [0.00 to ' + intMaxEntry.toFixed(2) + ']', 'alert-danger');
                    //Commented By Usha Pandit On 16.04.2020 for correct alert for 24 hrs validation
                    //showAlert('You can not enter more than ' + intMaxEntry.toFixed(2) + ' hours a day.', 'alert-danger');                    
                    //2020
                    //End of Commented & Added By Dipali v on 9th April 2019 For Consists Alter
                    //Isvalid = 1; //2020
                    //objTextBox.value = ObjOldValue; //2020
                    //objTextBox.focus(); //2020
                    //End Of Commented By Usha Pandit On 16.04.2020 for correct alert for 24 hrs validation
                    //return false;
                }
                
                //Commented By Dipali v On 24th Jan 2019 For Remove 0 Issue
                //objHoursComplete.value = (objHoursComplete.value - 0).toFixed(2);
                //End of Commented By Dipali v On 24th Jan 2019 For Remove 0 Issue


                //var EntryID = (objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'Entry');
                //var arrData = EntryID.split('_')
                //var ProjectID = arrData[1];
                //var TaskID = arrData[2];
                //var SubTaskTypeID = arrData[3];
                //var objEntryDate = document.getElementById(EntryID);
                //var objIsTaskComplete = document.getElementById('IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                //var IsTaskCompleteCheck = 0;
                //var RestrictByMinHours = document.getElementById('RestrictByMinHours_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                //var objAllowToResubmit = document.getElementById('txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                //if (objIsTaskComplete != null)
                //    IsTaskCompleteCheck = objIsTaskComplete.checked;
                //objDuChRow = (objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'txtDuChRow');
                // 
                //
                // 
                if (RestrictByMinHours != null) {
                    if (RestrictByMinHours.value == 1) {
                        if (GlobalHoursFlag == 1) {
                            var minutes = objTextBox.value.split('.');
                            var p = minutes[0];
                            var dec = minutes[1];
                            if (dec == undefined) { dec = 0; }
                            d = (dec - 0) / 60 + (p - 0);
                        }
                        else {
                            var d = objTextBox.value;
                        }
                        //if (parseInt(d, 10) % MinDAEntry !== 0) {
                        //    showAlert('Please enter hours complete in multiples of ' + MinDAENtryDisplay, 'alert-danger');
                        //    Isvalid = 1;
                        //}
                        if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                            if (ObjOldValue != ObjNewvalue) {
                                showAlert('Please enter hours complete in multiples of ' + MinDAENtryDisplay, 'alert-danger');
                                Isvalid = 1;
                            }
                            //return false;
                        }
                    }
                }
                // 

                
                //Added By Usha Pandit On 30.07.2019 for DA fill 24 hours per day validation           
               
                var arrHours = [];
                var cntTaskWeekLoop = 1;
                var startIndex = 0;

                //Added By Usha Pandit On 16.04.2020 for correct alert for 24 hrs validation
                var arrPosHours = [];
                var cntPosHoursLoop = 1;
                var startIndexPos = 0;
                //End Of Added By Usha Pandit On 16.04.2020 for correct alert for 24 hrs validation             
                totalEnteredHours = 0;
                totalEnteredNewHours = 0;
                //totalEnteredDynamicWeekHours = 0;
                totalActualPreviousWeekHoursWeekly = 0;
                TotalActualDurationhidden = 0;
                TotalAllocationDecimalWeekly = 0;
                TotalAllocationDurationhidden = '';
                try {
                    //debugger;
                    //Commented And Added By Usha Pandit On 16.04.2020 for correct alert for 24 hrs validation
                    $('*[id*=Duration_]').each(function () {                        
                        //if ($(this).attr("id").substr(pos + 1) == 2) {
                        //    //alert($(this).val());
                        //}
                        if ((isWeeklyView == 1) && $(this).attr("id").substr(pos + 1) != "") {
                            var pos = getPosition($(this).attr("id"), '_', 4);
                            var AjaxResultPos = 0;
                            if (timeToDecimal($(this).val()) > 0) {
                                var currentval = $(this).val();
                                currentval = currentval.split('.').join(':');
                                AjaxResultPos = timeToDecimal(currentval);
                            }
                            if (cntPosHoursLoop == 1) {
                                startIndexPos = $(this).attr("id").substr(pos + 1);
                            }
                            else {
                                if ($(this).attr("id").substr(pos + 1) == startIndexPos) {
                                    //alert($(this).attr("id").substr(pos + 1));
                                    cntPosHoursLoop = 1;
                                }
                            }

                            if (cntPosHoursLoop == $(this).attr("id").substr(pos + 1)) {
                                if (arrPosHours[cntPosHoursLoop - 1] == undefined) {
                                    arrPosHours[cntPosHoursLoop - 1] = parseFloat(AjaxResultPos);
                                }
                                else {
                                    arrPosHours[cntPosHoursLoop - 1] = parseFloat(arrPosHours[cntPosHoursLoop - 1]) + parseFloat(AjaxResultPos);
                                }
                            }
                            cntPosHoursLoop = cntPosHoursLoop + 1;
                        }
                    });
                    //End Of Added By Usha Pandit On 16.04.2020 for correct alert for 24 hrs validation
                    $('*[id*=Duration_]').each(function () {
                        
                        var pos = getPosition($(this).attr("id"), '_', 4);
                       
                        // alert($("#IsTaskComplete_" + posProjVal + "_" + posTaskVal + "_" + posSubTaskTypeVal));
                        //alert(posProjVal + "," + posTaskVal + "," + posSubTaskTypeVal);
                        var AjaxResult = 0;
                        if (timeToDecimal($(this).val()) > 0) {
                            var currentval = $(this).val();
                            currentval = currentval.split('.').join(':');
                            AjaxResult = timeToDecimal(currentval);
                        }
                        
                        if ((isWeeklyView == 1) && $(this).attr("id").substr(pos + 1) != "") {
                            if (cntTaskWeekLoop == 1) {
                                startIndex = $(this).attr("id").substr(pos + 1);
                            }
                            else {
                                if ($(this).attr("id").substr(pos + 1) == startIndex) {
                                    //alert($(this).attr("id").substr(pos + 1));
                                    cntTaskWeekLoop = 1;
                                    if (objTextBox.id.toString().indexOf($(this).attr("id").substr(0, pos + 1)) != -1) {                                        
                                        totalEnteredHours = 0;
                                       /// totalEnteredNewHours = 0;
                                    }
                                }
                            }
                            if (cntTaskWeekLoop == $(this).attr("id").substr(pos + 1)) {
                                if (arrHours[cntTaskWeekLoop - 1] == undefined) {
                                    arrHours[cntTaskWeekLoop - 1] = parseFloat(AjaxResult);
                                }
                                else {
                                    arrHours[cntTaskWeekLoop - 1] = parseFloat(arrHours[cntTaskWeekLoop - 1]) + parseFloat(AjaxResult);
                                }
                                
                                if (arrHours[cntTaskWeekLoop - 1] > 24) {
                                    
                                    //Commented And Added By Usha Pandit On 16.04.2020 for correct alert for 24 hrs validation
                                    //showAlert("You can not enter more than 24.00 hours a day.", "alert-danger");
                                    //Commented & Added By Dipali V On 15th May 2020 For Issue ID 24384
                                    var totalbookedval = (parseFloat(arrPosHours[cntTaskWeekLoop - 1]) - parseFloat(ObjNewvalue)) + parseFloat(ObjOldValue);
                                    //showAlert("You can book only 24 hours in a day. You have already booked " + totalbookedval + " hours. Your current entry will be adjusted to bring the total to 24 hours.", "alert-danger");
                                    //End Of Added By Usha Pandit On 16.04.2020 for correct alert for 24 hrs validation
                                    showAlert("You can book only 24 hours in a day.", "alert-danger");
                                     //End of Commented & Added By Dipali V On 15th May 2020 For Issue ID 24384
                                    //objHoursComplete.value = ObjOldValue;
                                    ////Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                                    objHoursComplete.value = ObjOldValue.replace(".", ":");
                                    //End of Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                                    Isvalid = 1;
                                    return false;
                                }
                            }
                            //alert(startIndex);
                            //alert(cntTaskWeekLoop);
                            //alert($(this).attr("id").substr(pos + 1));
                            //alert(arrHours[cntTaskWeekLoop - 1]);
                            if (objTextBox.id.toString().indexOf($(this).attr("id").substr(0, pos + 1)) != -1 && Isvalid == 0) {
                               
                                
                                var RequestParameters = {
                                    WorkHrs: encodeURI($(this).val()),
                                    Flag: encodeURI(2),
                                }
                                var param = JSON.stringify(RequestParameters);
                                ObjNewvalue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                                
                                totalEnteredHours = parseFloat(totalEnteredHours) + parseFloat(ObjNewvalue);
                                //debugger;
                                if (totalActualPreviousWeekHoursWeekly == 0) {
                                    var firstpos = getPosition($(this).attr("id"), '_', 1);
                                    var thirdpos = getPosition($(this).attr("id"), '_', 3);
                                    var secondpos = getPosition($(this).attr("id"), '_', 2);
                                    var cursubstr = $(this).attr("id").substr(secondpos + 1);
                                    var cursubstrproj = $(this).attr("id").substr(firstpos + 1);
                                    var cursubstrsubtask = $(this).attr("id").substr(thirdpos + 1);
                                    var curProjectId = $(this).attr("id").substr(firstpos + 1, cursubstrproj.indexOf("_"));
                                    var curTaskId = $(this).attr("id").substr(secondpos + 1, cursubstr.indexOf("_"));
                                    var curSubTaskTypeID = $(this).attr("id").substr(thirdpos + 1, cursubstrsubtask.indexOf("_"));
                                    //alert($(this).attr("id").substr(secondpos + 1, cursubstr.indexOf("_")));
                                    var value = $("#pro_Calculate_count_" + curTaskId).text();

                                    //curTaskId = TaskID;

                                    var RequestParameters = {
                                        WorkHrs: encodeURI($("#TotalActualDynamicDurationhidden" + curProjectId + "_" + curTaskId + "_" + curSubTaskTypeID).val()),
                                        Flag: encodeURI(2),
                                    }

                                    var param4 = JSON.stringify(RequestParameters);
                                    var DynamicDurationhiddenval = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param4, false);
                                    ////alert(DynamicDurationhiddenval);
                                    var RequestParameters = {
                                        WorkHrs: encodeURI(value),
                                        Flag: encodeURI(2),
                                    }

                                    var param5 = JSON.stringify(RequestParameters);
                                    var Dynamicpro_Calculate_count = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param5, false);

                                    ////alert(Dynamicpro_Calculate_count);
                                    totalActualPreviousWeekHoursWeekly = DynamicDurationhiddenval - Dynamicpro_Calculate_count;

                                    TotalAllocationDurationhidden = document.getElementById('TotalAllocationDurationhidden' + curProjectId + '_' + curTaskId + '_' + curSubTaskTypeID);
                                    
                                    var RequestParameters = {
                                        WorkHrs: encodeURI(TotalAllocationDurationhidden.value),
                                        Flag: encodeURI(2),
                                    }
                                    var param2 = JSON.stringify(RequestParameters);
                                    TotalAllocationDecimalWeekly = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param2, false);
                                    //alert(totalActualPreviousWeekHoursWeekly);
                                    
                                    //alert(TotalAllocationDecimalWeekly);
                                }
                            }
                            cntTaskWeekLoop = cntTaskWeekLoop + 1;
                        }
                        else {
                            if ($(this).attr("id").substr(pos + 1) == "") {
                                if (arrHours[cntTaskWeekLoop - 1] == undefined) {
                                    arrHours[cntTaskWeekLoop - 1] = parseFloat(AjaxResult);
                                }
                                else {
                                    arrHours[cntTaskWeekLoop - 1] = parseFloat(arrHours[cntTaskWeekLoop - 1]) + parseFloat(AjaxResult);
                                }

                                if (arrHours[cntTaskWeekLoop - 1] > 24) {
                                    
                                   
                                    
                                    showAlert("You can not enter more than 24.00 hours a day.", "alert-danger");
                                    
                                    Isvalid = 1;
                                    return false;
                                }
                            }
                            //18.03.2021
                            if ((isWeeklyView != 1) && $(this).attr("id").substr(pos + 1) != "") {
                                if ($(this).attr("id").substr(0, pos + 1).indexOf(objTextBox.id) != -1 && Isvalid == 0) {
                                    var curEntryDateId = objTextBox.id.toString().replace("Duration", "Entry");
                                    var curLoopEntryDateId = $(this).attr("id").toString().replace("Duration", "Entry");
                                    var curLoopDuration = $(this).val();
                                    if ($("#" + curEntryDateId).val() == $("#" + curLoopEntryDateId).val()) {
                                        curLoopDuration = objTextBox.value;
                                    }

                                    var RequestParameters = {
                                        WorkHrs: encodeURI(curLoopDuration),
                                        Flag: encodeURI(2),
                                    }

                                    var param = JSON.stringify(RequestParameters);
                                    ObjNewvalue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);

                                    totalEnteredHours = parseFloat(totalEnteredHours) + parseFloat(ObjNewvalue);
                                    //parseFloat(timeToDecimal($(this).val())
                                    //debugger;
                                    if (totalActualPreviousWeekHoursWeekly == 0) {
                                        var firstpos = getPosition($(this).attr("id"), '_', 1);
                                        var thirdpos = getPosition($(this).attr("id"), '_', 3);
                                        var secondpos = getPosition($(this).attr("id"), '_', 2);
                                        var cursubstr = $(this).attr("id").substr(secondpos + 1);
                                        var cursubstrproj = $(this).attr("id").substr(firstpos + 1);
                                        var cursubstrsubtask = $(this).attr("id").substr(thirdpos + 1);
                                        var curProjectId = $(this).attr("id").substr(firstpos + 1, cursubstrproj.indexOf("_"));
                                        var curTaskId = $(this).attr("id").substr(secondpos + 1, cursubstr.indexOf("_"));
                                        var curSubTaskTypeID = $(this).attr("id").substr(thirdpos + 1, cursubstrsubtask.indexOf("_"));
                                        //alert($(this).attr("id").substr(secondpos + 1, cursubstr.indexOf("_")));
                                        var value = $("#pro_Calculate_count_" + curTaskId).text();

                                        //curTaskId = TaskID;

                                        var RequestParameters = {
                                            WorkHrs: encodeURI($("#TotalActualDynamicDurationhidden" + curProjectId + "_" + curTaskId + "_" + curSubTaskTypeID).val()),
                                            Flag: encodeURI(2),
                                        }

                                        var param4 = JSON.stringify(RequestParameters);
                                        var DynamicDurationhiddenval = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param4, false);
                                        ////alert(DynamicDurationhiddenval);
                                        var RequestParameters = {
                                            WorkHrs: encodeURI(value),
                                            Flag: encodeURI(2),
                                        }

                                        var param5 = JSON.stringify(RequestParameters);
                                        var Dynamicpro_Calculate_count = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param5, false);

                                        ////alert(Dynamicpro_Calculate_count);
                                        totalActualPreviousWeekHoursWeekly = DynamicDurationhiddenval - Dynamicpro_Calculate_count;

                                        TotalAllocationDurationhidden = document.getElementById('TotalAllocationDurationhidden' + curProjectId + '_' + curTaskId + '_' + curSubTaskTypeID);

                                        var RequestParameters = {
                                            WorkHrs: encodeURI(TotalAllocationDurationhidden.value),
                                            Flag: encodeURI(2),
                                        }
                                        var param2 = JSON.stringify(RequestParameters);
                                        TotalAllocationDecimalWeekly = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param2, false);
                                        
                                    }
                                }
                            }
                            //18.03.2021
                        }
                    });
                }
                catch (ex) {
                    //alert(ex.message);
                }
                   //End Of Added By Usha Pandit On 30.07.2019 for DA fill 24 hours per day validation     
                 
                if (isWeeklyView != 1) {
                    if (Isvalid == 0) {
                        var actualtotalEnteredHoursDaily = 0;
                        actualtotalEnteredHoursDaily = totalEnteredHours;
                        var RequestParameters = {
                            WorkHrs: encodeURI(totalEnteredHours),
                            Flag: encodeURI(1),
                        }
                        
                        var param = JSON.stringify(RequestParameters);
                        totalEnteredHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                        if (parseFloat(actualtotalEnteredHoursDaily) + parseFloat(totalActualPreviousWeekHoursWeekly) <= parseFloat(TotalAllocationDecimalWeekly)) {
                        }
                        else {
                            var totalbookedhours = (parseFloat(actualtotalEnteredHoursDaily) + parseFloat(totalActualPreviousWeekHoursWeekly))
                            //alert(totalbookedhours);
                            var RequestParameters = {
                                WorkHrs: encodeURI(totalbookedhours),
                                Flag: encodeURI(1),
                            }

                            var param = JSON.stringify(RequestParameters);
                            totalbookedhours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);

                            totalEnteredHours = totalbookedhours;
                        }
                        totalEnteredHours = totalEnteredHours.toString().replace(':', '.');

                        

                        
                    }
                }
                if (isWeeklyView == 1) {
                    if (Isvalid == 0) {
                        var actualtotalEnteredHours = 0;
                        actualtotalEnteredHours = totalEnteredHours;
                        var RequestParameters = {
                            WorkHrs: encodeURI(totalEnteredHours),
                            Flag: encodeURI(1),
                        }
                        var param = JSON.stringify(RequestParameters);
                        totalEnteredHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);

                        if (parseFloat(actualtotalEnteredHours) + parseFloat(totalActualPreviousWeekHoursWeekly) <= parseFloat(TotalAllocationDecimalWeekly)) {
                        }
                        else {
                            var totalbookedhours = (parseFloat(actualtotalEnteredHours) + parseFloat(totalActualPreviousWeekHoursWeekly))
                            //alert(totalbookedhours);
                            var RequestParameters = {
                                WorkHrs: encodeURI(totalbookedhours),
                                Flag: encodeURI(1),
                            }

                            var param = JSON.stringify(RequestParameters);
                            totalbookedhours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);

                            totalEnteredHours = totalbookedhours;
                            //var RequestParameters = {
                            //    WorkHrs: encodeURI(totalbookedhours),
                            //    Flag: encodeURI(1),
                            //}
                            //var param7 = JSON.stringify(RequestParameters);
                            //totalbookedhours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param7, false);

                            //setTimeout(function () {
                            //    showAlert('You were allocated ' + TotalAllocationDurationhidden.value + ' hour(s) to complete this task. With this entry, the total hours that will be booked against this task is ' + (totalbookedhours) + ' hour(s).', 'alert-danger');
                            //}, 3000);
                            ////alert('You were allocated ' + TotalAllocationDecimalWeekly + ' hour(s) to complete this task. With this entry, the total hours that will be booked against this task is ' + (parseFloat(totalEnteredHours) + parseFloat(totalActualPreviousWeekHoursWeekly)) + ' hour(s).');
                            //Isvalid = 0;
                        }
                        totalEnteredHours = totalEnteredHours.toString().replace(':', '.');
                    }
                }
                
                //debugger;
                if (Isvalid == 0) {
                    
                    //Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                    //totalEnteredHours = parseFloat(totalEnteredHours) + parseFloat(ObjNewvalue);
                   //End of Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                    if (ObjOldValue != ObjNewvalue && ObjNewvalue != "00.00") {
                        var taskParameters = {
                            intEmployeeID: EmployeeID,
                            dtFromDate: objEntryDate.value,
                            ProjectID: ProjectID,
                            TaskID: TaskID,
                            SubTaskTypeID: SubTaskTypeID,
                            //Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                            Duration: objHoursComplete.value,
                            TotalDuration: totalEnteredHours,
                            //End of Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                            IsTaskComplete: IsTaskCompleteCheck,
                            Flag:"",
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
                                totalEnteredHours = 0;
                                if (data != "") {
                                    if (data.indexOf('$$') >= 0) {
                                        var oldValue = objHoursComplete.value;
                                        var arrValue = data.split('$$');
                                        showAlert(arrValue[1], 'alert-danger');
                                       // setTimeout(function () {
                                            //showAlert(arrValue[1], 'alert-danger');
                                       // }, 2000);
                                        

                                        //objHoursComplete.value = arrValue[0];
                                        if (arrValue[0] < 0) {
                                            objHoursComplete.value = '00.00';
                                        }
                                        if (((oldValue - 0) - (arrValue[0] - 0)) <= 0)
                                            objHoursComplete.value = '00.00';
                                        Isvalid = 1;
                                        //return false;
                                    }
                                    else if (data.indexOf('@@') >= 0) {
                                        objHoursComplete.value = "";
                                        var arrValue = data.split('@@');
                                        showAlert(arrValue[1], 'alert-danger');
                                        //setTimeout(function () {
                                            //showAlert(arrValue[1], 'alert-danger');
                                        //}, 2000);
                                        if (arrValue[0] == 3 || arrValue[0] == 6 || arrValue[0] == 7) {
                                            if (objIsTaskComplete != null) {
                                                objIsTaskComplete.checked = false;
                                            }
                                        }
                                        Isvalid = 1;
                                        //return false;
                                    }
                                    else if (data.indexOf('##') >= 0) {
                                        var arrValue = data.split('##');
                                        if (arrValue[0] == 1) {
                                            //alert(arrValue[1]);
                                            showAlert(arrValue[1], 'alert-danger');
                                           // setTimeout(function () {
                                                //showAlert(arrValue[1], 'alert-danger');
                                            //}, 2000);
                                            //Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                                            //totalEnteredHours = parseFloat(totalEnteredHours) - parseFloat(objHoursComplete.value);
                                            //End of Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                                            objHoursComplete.value =  objHoursComplete.defaultValue.replace(/:/g, ".");
                                            Isvalid = 1;
                                            // return false;
                                        }
                                        else if (arrValue[0] == 0) {
                                            if (fn_argument == 1) {
                                                //alert(arrValue[1]);
                                                if (document.getElementById(objDuChRow).value == 0) {
                                                    if (Isvalid == 0) {
                                                        $("#ConfirmMessagemodalinfo").modal('show');
                                                        $("#ConfirmationMsg").html(arrValue[1]);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    //Added by Usha Pandit On 08.08.2019 For wrong Alert showing please fill the activity when DA filled for previous weeks
                                    else if (data.indexOf('**') >= 0) {

                                    }
                                    //End Of Added by Usha Pandit On 08.08.2019 For wrong Alert showing please fill the activity when DA filled for previous weeks
                                    else {
                                        //
                                        if (ObjOldValue == ObjNewvalue) { }
                                        else {
                                            if (objHoursComplete.value != "00.00" && objHoursComplete.value != "00:00") {
                                                showAlert(data, 'alert-danger');
                                                // setTimeout(function () {
                                                //showAlert(data, 'alert-danger');
                                                //}, 2000);
                                                //Commented & Added By Dipali V On 25th Feb 2021  For Blocking days hours should same
                                                //objHoursComplete.value = "00:00";
                                                objHoursComplete.value = ObjOldValue;
                                                //End of Commented & Added By Dipali V On 25th Feb 2021  For Blocking days hours should same
                                                //Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                                                totalEnteredHours = 0;
                                                //End of Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                                                Isvalid = 1;
                                            }
                                            else {
                                                showAlert(data, 'alert-danger');                                                
                                                objHoursComplete.value = ObjOldValue;                                                
                                                totalEnteredHours = 0;                                                
                                                Isvalid = 1;
                                            }
                                        }
                                        //return false;
                                    }
                                }
                            },
                            error: function (err) {
                                console.log(err);
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                }
                //objHoursComplete.value = objHoursComplete.value.replace(":",/./g );
                if (Isvalid == 1) {
                    //  
                    objHoursComplete.value = objHoursComplete.value.replace(".", ":");
                    return false;
                }
                else {
                    objHoursComplete.value = objHoursComplete.value.replace(".", ":");
                    return true
                }
            }


        }
        function SendConfirmationResponse(response) {
            var objDATextbox = document.getElementById(DATextbox);
            if (response == 0) {
                if (objDATextbox.defaultValue != "" || objDATextbox.defaultValue != "00:00") {
                    objDATextbox.value = objDATextbox.defaultValue;
                }
                else {
                    objDATextbox.value = "";
                }
            }
            else {
                document.getElementById(objDuChRow).value = 1;
            }
        }

        function CloseConfirmationResponse(response) {
            var objDATextbox = document.getElementById(DATextbox);
            objDATextbox.focus();
        }



        function SaveDescription_OnClick(ProjectID, TaskID, SubTaskTypeID, k) {
            //
            var isValid = 0;
          

            

            if (isWeeklyView == 1) {
                // 
                //Added By Nikhil Adkar for DA Type Saving
                if (PageFlag == 1 || PageFlag == '') {
                    var DAType = '';
                    var DATypeOC = document.getElementById('DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + k);
                    var DATypeN = document.getElementById('DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + k);
                    var DATypeOT = document.getElementById('DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + k);
                    var DATypeCB = document.getElementById('DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + k);
                    if (DATypeOC.checked) {
                        DAType = 'S';
                    }
                    if (DATypeN.checked) {
                        DAType = 'N';
                    }
                    if (DATypeOT.checked) {
                        DAType = 'T';
                    }
                    if (DATypeCB.checked) {
                        DAType = 'B';
                    }
                }
                

            //End of Added By Nikhil Adkar



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
                    if (Hours_OnChange(objDuration, 1) == false) { isValid = 1; };
                    objWorkCompleted = document.getElementById('WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                    var workComp = 0;
                    if (objWorkCompleted != null) {
                        if (objWorkCompleted.value == "" || objWorkCompleted.value == "%") {
                            objWorkCompleted.value = "0%";
                        }
                        workComp = objWorkCompleted.value;
                        if (workComp.indexOf('%') == -1) {
                            workComp = objWorkCompleted.value + "%";
                        }
                    }
                    if (objWorkCompleted != null) {
                        if (workComp.indexOf('%') > 0) {
                            var workCompNew = workComp.split("%")
                            workComp = workCompNew[0]
                            //Added by Sagar N on 27-Dec-2018 Purpose: Work Complete % not more than 100 ; ISSUE ID-16623
                            if (workCompNew[0] != 0) {
                                if (workCompNew[0] > 100 || workCompNew[0] < 0) {
                                    //alert("Not greater" + workComp)
                                    showAlert('Work Complete % should not be greater than 100', 'alert-danger');
                                    return false;
                                    isValid = 1;
                                }
                            }
                        }
                    }

                    objResourceLevelTaskCompletion = document.getElementById('ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                    objStoryPoint = document.getElementById('StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + k);

                    var storypoint = 0;
                    if (objStoryPoint != null) {

                        if (StoryPoint_OnChange(objStoryPoint, 1) == false) { isValid = 1; };
                        storypoint = objStoryPoint.value;
                        if (storypoint != 0) {
                            if (objDuration.value == "00:00") {
                                showAlert('Please Enter Daily Activity', 'alert-danger');
                                isValid = 1;
                                objDuration.focus();
                            }
                        }
                    }
                    //alert(escape(objDescription.value));
                    // alert(unescape(objDescription.value));
                    //if (objDuration.value != 0) {
                    if (PageFlag == 1 || PageFlag == '') {
                        daParams.push({
                            DailyActivityEntryID: objDAID.value,
                            TaskID: TaskID,
                            ProjectID: ProjectID,
                            EmployeeID: EmployeeID,
                            EntryDate: objEntryDate.value,
                            Duration: objDuration.value.replace(":", "."),
                            Description: objDescription.value.replace(/'/g, "''"),
                            SubTasktypeID: SubTaskTypeID,
                            IsDurationChange: txtDuChRow.value,
                            IsTaskComplete: IsTaskCompleteCheck,
                            ActualPercentComplete: workComp,
                            bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                            StoryPoint: storypoint,
                            //Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                            dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                            dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                            //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                            //Added By Nikhik Adkar for Pushig the DA type
                            charDAType: DAType,
                            //End Of Added By Nikhik Adkar for Pushig the DA type
                        });
                    }
                    else {
                        daParams.push({
                            DailyActivityEntryID: objDAID.value,
                            TaskID: TaskID,
                            ProjectID: ProjectID,
                            EmployeeID: EmployeeID,
                            EntryDate: objEntryDate.value,
                            Duration: objDuration.value.replace(":", "."),
                            Description: objDescription.value.replace(/'/g, "''"),
                            SubTasktypeID: SubTaskTypeID,
                            IsDurationChange: txtDuChRow.value,
                            IsTaskComplete: IsTaskCompleteCheck,
                            ActualPercentComplete: workComp,
                            bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                            StoryPoint: storypoint,
                            //Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                            dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                            dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                            //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                           
                        });
                    }
                    //}
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
                                  //Add By Dipali V On 23th For Remove Tooltip
                                   // $('#txtQuickEntry').on("blur");
                                $("#txtQuickEntry").blur();
                                   //End of Add By Dipali V On 23th For Remove Tooltip
                                ReloadData(EmployeeID);
                            }
                        },
                        error: function (err) {
                            console.log(err);
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
            }
            else {
                //Added By Nikhil Adkar for DA Type Saving
                if (PageFlag == 1 || PageFlag == '') {
                    var DAType = '';
                    var DATypeOC = document.getElementById('DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                    var DATypeN = document.getElementById('DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                    var DATypeOT = document.getElementById('DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                    var DATypeCB = document.getElementById('DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                    if (DATypeOC.checked) {
                        DAType = 'S';
                    }
                    if (DATypeN.checked) {
                        DAType = 'N';
                    }
                    if (DATypeOT.checked) {
                        DAType = 'T';
                    }
                    if (DATypeCB.checked) {
                        DAType = 'B';
                    }
                }

            //End of Added By Nikhil Adkar
                var daParams = [];
                objEntryDate = document.getElementById('Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objDAID = document.getElementById('DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objDescription = document.getElementById('Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                txtDuChRow = document.getElementById('txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objIsTaskComplete = document.getElementById('dailyIsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                var IsTaskCompleteCheck = 0;
                if (objIsTaskComplete != null)
                    IsTaskCompleteCheck = objIsTaskComplete.checked;
                if (Hours_OnChange(objDuration, 1) == false) { isValid = 1; };
                objWorkCompleted = document.getElementById('dailyWorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                var workComp = 0;
                if (objWorkCompleted != null) {
                    if (objWorkCompleted.value == "" || objWorkCompleted.value == "%") {
                        objWorkCompleted.value = "0%";
                    }
                    workComp = objWorkCompleted.value;
                    if (workComp.indexOf('%') == -1) {
                        workComp = objWorkCompleted.value + "%";
                    }
                }
                if (objWorkCompleted != null) {
                    if (workComp.indexOf('%') > 0) {
                        var workCompNew = workComp.split("%")
                        workComp = workCompNew[0]
                        //Added by Sagar N on 27-Dec-2018 Purpose: Work Complete % not more than 100 ; ISSUE ID-16623
                        if (workCompNew[0] != 0) {
                            if (workCompNew[0] > 100 || workCompNew[0] < 0) {
                                //alert("Not greater" + workComp)
                                showAlert('Work Complete % should not be greater than 100', 'alert-danger');
                                return false;
                                isValid = 1;
                            }
                        }
                    }
                }

                objResourceLevelTaskCompletion = document.getElementById('ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objStoryPoint = document.getElementById('StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);

                var storypoint = 0;
                if (objStoryPoint != null) {
                    if (StoryPoint_OnChange(objStoryPoint, 1) == false) { isValid = 1; };
                    storypoint = objStoryPoint.value;
                    if (storypoint != 0) {
                        if (objDuration.value == "00:00") {
                            showAlert('Please Enter Daily Activity', 'alert-danger');

                            isValid = 1;
                            //ReloadData(EmployeeID);
                            objDuration.focus();
                        }
                    }
                }


                if (objDuration.value != 0) {
                    if (PageFlag == 1 || PageFlag == '') {
                        daParams.push({
                            DailyActivityEntryID: objDAID.value,
                            TaskID: TaskID,
                            ProjectID: ProjectID,
                            EmployeeID: EmployeeID,
                            EntryDate: objEntryDate.value,
                            Duration: objDuration.value.replace(":", "."),
                            Description: objDescription.value.replace(/'/g, "''"),
                            SubTasktypeID: SubTaskTypeID,
                            IsDurationChange: txtDuChRow.value,
                            IsTaskComplete: IsTaskCompleteCheck,
                            ActualPercentComplete: workComp,
                            bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                            StoryPoint: storypoint,
                            //Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                            dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                            dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                            //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                            //Addded By Nikhil Adkar on 16-Sept-2024 for Saving the DA Type in Daily View
                            charDAType: DAType,
                            //End of Added By Nikhil Adkar
                        });
                    }
                    else {
                        daParams.push({
                            DailyActivityEntryID: objDAID.value,
                            TaskID: TaskID,
                            ProjectID: ProjectID,
                            EmployeeID: EmployeeID,
                            EntryDate: objEntryDate.value,
                            Duration: objDuration.value.replace(":", "."),
                            Description: objDescription.value.replace(/'/g, "''"),
                            SubTasktypeID: SubTaskTypeID,
                            IsDurationChange: txtDuChRow.value,
                            IsTaskComplete: IsTaskCompleteCheck,
                            ActualPercentComplete: workComp,
                            bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                            StoryPoint: storypoint,
                            //Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                            dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                            dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                            //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                            
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
                                  //Add By Dipali V On 23th For Remove Tooltip
                                   // $('#txtQuickEntry').on("blur");
                                $("#txtQuickEntry").blur();
                                   //End of Add By Dipali V On 23th For Remove Tooltip
                                plotDailyTaskList(EmployeeID);
                            }
                        },
                        error: function (err) {
                            console.log(err);
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
            }


        }
        var arrayWeekDays = [];
        function Save_OnClick() {
           //debugger;
            isNotAllowQuickEntry = false;
            var IsCheckboxSelected = 0;
            var isValid = 0;
           
            //Added By Usha Pandit On 03.03.2021 For zero hours check
            //var isNonZero = false;
            //$('#timesheetBody .timenoinput').each(function () {
            //    //alert($(this).attr("id"));
            //    var curhour = $(this).attr("id");
            //    if ($("#" + curhour).val() != "00:00") {
            //        isNonZero = true;
            //    }
            //});
            //Added By Usha Pandit On 03.03.2021 For zero hours check
            //Added by Usha Pandit On 08.08.2019 For wrong Alert showing please fill the activity when DA filled for previous weeks
             
            //2021
            var arrHours = [];
            var cntTaskWeekLoop = 1;
            var startIndex = 0;            
            var arrPosHours = [];
            var cntPosHoursLoop = 1;
            var startIndexPos = 0;
            
            totalEnteredHours = 0;
            try {
                $('*[id*=Duration_]').each(function () {
                    var pos = getPosition($(this).attr("id"), '_', 4);

                    if ((isWeeklyView == 1) && $(this).attr("id").substr(pos + 1) != "") {
                        if (cntTaskWeekLoop == 1) {
                            startIndex = $(this).attr("id").substr(pos + 1);
                        }
                        else {
                            if ($(this).attr("id").substr(pos + 1) == startIndex) {

                                cntTaskWeekLoop = 1;
                                totalEnteredHours = 0;
                            }
                        }
                        if (cntTaskWeekLoop == $(this).attr("id").substr(pos + 1)) {

                        }

                        totalEnteredHours = parseFloat(totalEnteredHours) + parseFloat($(this).val());
                        cntTaskWeekLoop = cntTaskWeekLoop + 1;
                    }
                    else {
                        if ($(this).attr("id").substr(pos + 1) == "") {


                        }
                    }
                    
                });
            }
            catch (ex) {
                //alert(ex.message);
            }
           
            //2021
            var blnDANotFilled = false;
                    $('*[id*=WorkComplete_]').each(function () {
                       
                        var posWorkPercentageId = $(this).attr("id");
                        var posWorkPercentageVal = $("#" + posWorkPercentageId).val();

                        var posWorkCompleteId = posWorkPercentageId.toString().replace("WorkComplete_", "IsTaskComplete_");
                        var flgIsTaskComplete = '';

                        if ($("#"+posWorkCompleteId).prop("checked") == undefined) {
                            flgIsTaskComplete = false;
                        }
                        else {
                            flgIsTaskComplete = $("#"+posWorkCompleteId).prop("checked");
                        }
                        //alert(flgIsTaskComplete);
                        if (posWorkPercentageVal != "%" && posWorkPercentageVal != "") {
                            var arrAllTaskValues = $(this).attr("id").toString().split("_");

                            var posProjId = arrAllTaskValues[1];

                            var posTaskId = arrAllTaskValues[2];

                            var posSubTaskTypeId = arrAllTaskValues[3];


                            //alert(posProjId + "_" + posTaskId + "_" + posSubTaskTypeId);
                            //alert($(this).attr("id").val() + "_" + posProjId + "_" + posTaskId + "_" + posSubTaskTypeId);
                            //alert($("#IsTaskComplete_" + posProjId + "_" + posTaskId + "_" + posSubTaskTypeId).prop("checked"));
                                                        
                            //if (flgIsTaskComplete == true || posWorkPercentageVal != "0%") {

                                var taskParameters = {
                                    intEmployeeID: EmployeeID,
                                    dtFromDate: '',
                                    ProjectID: posProjId,
                                    TaskID: posTaskId,
                                    SubTaskTypeID: posSubTaskTypeId,
                                    Duration: 0,
                                    TotalDuration: totalEnteredHours, //Added By Chetan M on 16 March 2021
                                    IsTaskComplete: flgIsTaskComplete,
                                    Flag:"",
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
                                            var arrValue = data.split('**');
                                            if (arrValue[0] == 1) {
                                                blnDANotFilled = true;
                                                return false;
                                            }
                                            //Commented By Dipali V On 18th March 2021 For Restirct Work Hours
                                            //arrValue = data.split('##');
                                            //if (arrValue[0] == 1) {
                                            //   // isNotAllowQuickEntry = true;
                                            //    return false;
                                            //}                                            
                                            //End of Commented By Dipali V On 18th March 2021 For Restirct Work Hours
                                        }
                                    }
                                }); 
                            //}
                        }
                    });
            
                    //End Of Added by Usha Pandit On 08.08.2019 For wrong Alert showing please fill the activity when DA filled for previous weeks
           
            if ($('#CloseableAlert').css('display') == 'none') {
                if (isWeeklyView == 1) {
                    var daParams = [];
                    var hdnTaskData = document.getElementsByName("hdnTaskData");
                    StoryPointCount = 0;
                    for (var i = 0; i < hdnTaskData.length; i++) {
                        //StoryPointCount = 0;
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
                        var ParentWorkComplete;

                        var IsWorkHourFilled = 0;
                        var IsTaskCompleteFilled = 0;
                        var IsAllZero = 0;
                       
                        //Added By Usha Pandit On 28.10.2020 For checking if any DA is filled
                        var isAnyDAFilled = false;
                        //End Of Added By Usha Pandit On 28.10.2020 For checking if any DA is filled
                        arrayWeekDays = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];
                        for (var k = 0; k < arrayWeekDays.length; k++) {
                            // 
                            //debugger;

                            //Added By Nikhil Adkar for DA Type Saving
                            if (PageFlag == 1 || PageFlag == '') {
                                var DAType = 'N';
                                var DATypeOC = document.getElementById('DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                var DATypeN = document.getElementById('DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                var DATypeOT = document.getElementById('DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                var DATypeCB = document.getElementById('DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                if (DATypeOC.checked) {
                                    DAType = 'S';
                                }
                                if (DATypeN.checked) {
                                    DAType = 'N';
                                }
                                if (DATypeOT.checked) {
                                    DAType = 'T';
                                }
                                if (DATypeCB.checked) {
                                    DAType = 'B';
                                }
                            }
                            

            //End of Added By Nikhil Adkar

                            objEntryDate = document.getElementById('Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                            if (objEntryDate != null) {
                                objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                // if (k == 0) {
                                //    alert(k + " " + objDuration.value);
                                //}
                                objDAID = document.getElementById('DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                objDescription = document.getElementById('Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                txtDuChRow = document.getElementById('txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                objIsTaskComplete = document.getElementById('IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                                //alert('IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                                var IsTaskCompleteCheck = 0;
                                if (objIsTaskComplete != null)
                                    IsTaskCompleteCheck = objIsTaskComplete.checked;
                                //
                                //if (objDuration.value != objDuration.defaultValue) {

                                //Commented by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                                //if (Hours_OnChange(objDuration, 1) == false) { isValid = 1; };
                                 //End of Commented by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                                //}
                                //WorkComplete_109_24401_0
                                objWorkCompleted = document.getElementById('WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                                objResourceLevelTaskCompletion = document.getElementById('ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                                objStoryPoint = document.getElementById('StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                                var workComp = 0;
                                //
                                if (objWorkCompleted != null) {
                                    if (objWorkCompleted.value == "" || objWorkCompleted.value == "%") {
                                        objWorkCompleted.value = "0%";
                                    }
                                    workComp = objWorkCompleted.value;
                                    if (workComp.indexOf('%') == -1) {
                                        workComp = objWorkCompleted.value + "%";
                                    }
                                   

                                }
                                //  
                               
                                if (objWorkCompleted != null) {
                                    if (workComp.indexOf('%') > 0) {
                                        var workCompNew = workComp.split("%")
                                        workComp = workCompNew[0]
                                        //Added by Sagar N on 27-Dec-2018 Purpose: Work Complete % not more than 100 ; ISSUE ID-16623
                                        if (workCompNew[0] != 0) {
                                            if (checkNumber(workCompNew[0]) == false) {
                                                showAlert('Please enter numeric values.', 'alert-danger');
                                                Isvalid = 1;
                                                return false;
                                            }
                                            if (workCompNew[0] > 100 || workCompNew[0] < 0) {
                                                //alert("Not greater" + workComp)
                                                showAlert('Work Complete % should not be greater than 100', 'alert-danger');
                                                return false;
                                                isValid = 1;
                                            }
                                        }
                                    }
                                }



                                var storypoint = 0;
                                if (objStoryPoint != null) {

                                    if (StoryPoint_OnChange(objStoryPoint, 1) == false) { isValid = 1; };
                                    storypoint = objStoryPoint.value;
                                    if (storypoint != 0) {
                                        if (objDuration.value == "00:00") {
                                            showAlert('Please Enter Daily Activity', 'alert-danger');
                                            objDuration.focus();
                                            isValid = 1;
                                        }
                                    }
                                }
                                
                                if (objDuration.value != "00:00") {
                                    IsAllZero == 1;
                                    if (SubTaskTypeID == 0) {
                                        if (objWorkCompleted != null) {

                                            if (objWorkCompleted.value != objWorkCompleted.defaultValue) {
                                                IsWorkHourFilled = 1;
                                            }

                                        }
                                        if (objIsTaskComplete != null) {
                                            if (objIsTaskComplete.hasAttribute('disabled')) {
                                            }
                                            else {
                                                if (objIsTaskComplete.checked) {
                                                     IsTaskCompleteFilled = 1;
                                                }
                                               
                                            }
                                        }
                                    }
                                }
                                
                              
                                var Default = objDuration.defaultValue;
                               
                                //.replace(/:/g, ".");
                                //     if (objDuration.value != (objDuration.defaultValue - 0).toFixed(2)) {
                                //if (objDuration.value != 0.00) {

                                //Commented by Usha Pandit On 08.08.2019 For wrong Alert showing please fill the activity when DA filled for previous weeks
                                //if (objDuration.value != Default || (objStoryPoint != null ? objStoryPoint.value != objStoryPoint.defaultValue : false)
                                //    || IsWorkHourFilled == 1 || IsTaskCompleteFilled == 1) {     
                                //End Of Commented by Usha Pandit On 08.08.2019 For wrong Alert showing please fill the activity when DA filled for previous weeks

                                //Added by Usha Pandit On 08.08.2019 For wrong Alert showing please fill the activity when DA filled for previous weeks
                                 var DefaultPercent ='';
                                if (objWorkCompleted != null) {
                                    DefaultPercent = objWorkCompleted.defaultValue;
                                }
                                
                                var chkobjWorkCompleted = objWorkCompleted;
                                var valobjWorkCompleted = '';
                                var chkobjIsTaskComplete = '';
                                var valobjIsTaskComplete = 0;
                                var blnActiveDAFilled = false;
                                var blnZeroDurationFilled = false;
                                var blnOnlyPercentOrCheck = false;

                                if (chkobjWorkCompleted != null && chkobjWorkCompleted != undefined) {
                                    valobjWorkCompleted = objWorkCompleted.value;
                                }
                                else {
                                    valobjWorkCompleted = '0%';
                                }
                                if (objIsTaskComplete != null && objIsTaskComplete != undefined) {
                                    chkobjIsTaskComplete = objIsTaskComplete.checked;
                                }
                                else {
                                    chkobjIsTaskComplete = false;
                                }
                                if (chkobjIsTaskComplete == true) {
                                    valobjIsTaskComplete = 1;
                                }
                                else {
                                    valobjIsTaskComplete = 0;
                                }                                
                               
                                //if ((objDuration.value != Default || objWorkCompleted.value != DefaultPercent) && (valobjIsTaskComplete == 1 || valobjWorkCompleted != '0%')) {
                                //    blnDANotFilled = false;
                                //    blnActiveDAFilled = true;
                                //}
                                
                                if (isAnyDAFilled == false) { //Added By Usha Pandit On 28.10.2020 For checking if any DA is filled
                                    if (objDuration.value != "00:00" && blnDANotFilled == true) {
                                        blnDANotFilled = false;
                                        isAnyDAFilled = true; //Added By Usha Pandit On 28.10.2020 For checking if any DA is filled
                                    }

                                    if (objDuration.value == "00:00" && valobjIsTaskComplete == 1) {//Added By Dipali V On 12th June 2020 If Task completed without DA then Saving alert come but nothing happened
                                        // Added By Dipali V On 3rd March 2021 if Is Task complete access then will allow to complete
                                        if ($("#IdAllTotal").text() != "00:00" && valobjIsTaskComplete == 1) {
                                            blnDANotFilled = false;
                                        } else {
                                            blnDANotFilled = true;
                                        }
                                        //End of Added By Dipali V On 3rd March 2021 if Is Task complete access then will allow to complete
                                       
                                    }
                                }
                                //alert(objDuration.value + " " + valobjWorkCompleted + " " + valobjIsTaskComplete);
                                
                                //if (objDuration.value == "00:00" && (valobjWorkCompleted != "0%" || valobjIsTaskComplete == 1)) {
                                //    blnOnlyPercentOrCheck = true;
                                //}
                                //if (objDuration.value == "00:00" && (valobjWorkCompleted == "0%" && valobjIsTaskComplete == 0)) {
                                //    blnZeroDurationFilled = true;
                                //}
                                //if (k == 0) {
                                //    alert(blnZeroDurationFilled);
                                //    alert(k + " " + objDuration.value);
                                //}
                                //alert(objDuration.value);
                                //if (( (blnOnlyPercentOrCheck == false)  && (blnDANotFilled == false && (valobjIsTaskComplete == 1 || valobjWorkCompleted != '0%' || blnActiveDAFilled == true || blnZeroDurationFilled == true) )) || (objStoryPoint != null ? objStoryPoint.value != objStoryPoint.defaultValue : false)
                                //    || IsWorkHourFilled == 1 || IsTaskCompleteFilled == 1 ) {
                                //Commented And Added By Usha Pandit On 12.04.2021 For not showing alert if no changes made in DA
                                //if (objDuration.value != Default || (blnDANotFilled == false && ( valobjIsTaskComplete == 1 || valobjWorkCompleted != '0%')) || (objStoryPoint != null ? objStoryPoint.value != objStoryPoint.defaultValue : false)
                                //    || IsWorkHourFilled == 1 || IsTaskCompleteFilled == 1 && objDuration.value != 0) {     
                                if (objDuration.value != Default || (blnDANotFilled == false && (valobjIsTaskComplete == 1 || valobjWorkCompleted != '0%') && objDuration.value != Default) || (objStoryPoint != null ? objStoryPoint.value != objStoryPoint.defaultValue : false)
                                    || IsWorkHourFilled == 1 || IsTaskCompleteFilled == 1 && objDuration.value != 0) {     
                                    //End Of Added By Usha Pandit On 12.04.2021 For not showing alert if no changes made in DA
                                    //End Of Added by Usha Pandit On 08.08.2019 For wrong Alert showing please fill the activity when DA filled for previous weeks
                                    //Commented By Usha Pandit ON 01.08.2019 As not getting any notification
                                    //if ((IsWorkHourFilled == 1 || IsTaskCompleteFilled == 1)) {
                                    //    if (IsAllZero == 0) {return;}
                                    //}
                                    //End Of Commented By Usha Pandit ON 01.08.2019 As not getting any notification
                                    //alert(objDuration.value);
                                     if (IsTaskCompleteCheck == 1) {
                                         IsCheckboxSelected = 1;
                                    }
                                    //Modified By Nikhil Adkar on 18-Sept-2024 for not Sending DAtype from View Timesheet and My Timesheet Page
                                    if (PageFlag == 1 || PageFlag == '') {
                                        daParams.push({
                                            DailyActivityEntryID: objDAID.value,
                                            TaskID: TaskID,
                                            ProjectID: ProjectID,
                                            EmployeeID: EmployeeID,
                                            EntryDate: objEntryDate.value,
                                            Duration: objDuration.value.replace(":", "."),
                                            Description: objDescription.value.replace(/'/g, "''"),
                                            SubTasktypeID: SubTaskTypeID,
                                            IsDurationChange: txtDuChRow.value,
                                            IsTaskComplete: IsTaskCompleteCheck,
                                            ActualPercentComplete: (objWorkCompleted == null ? ParentWorkComplete : workCompNew[0]),
                                            bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                                            StoryPoint: storypoint,
                                            charDAType: DAType,
                                            //Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                                            dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                                            dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                                            //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                                        });
                                    }
                                    else {
                                        daParams.push({
                                            DailyActivityEntryID: objDAID.value,
                                            TaskID: TaskID,
                                            ProjectID: ProjectID,
                                            EmployeeID: EmployeeID,
                                            EntryDate: objEntryDate.value,
                                            Duration: objDuration.value.replace(":", "."),
                                            Description: objDescription.value.replace(/'/g, "''"),
                                            SubTasktypeID: SubTaskTypeID,
                                            IsDurationChange: txtDuChRow.value,
                                            IsTaskComplete: IsTaskCompleteCheck,
                                            ActualPercentComplete: (objWorkCompleted == null ? ParentWorkComplete : workCompNew[0]),
                                            bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                                            StoryPoint: storypoint,
                                            //Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                                            dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                                            dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                                            //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                                        });
                                    }
                                    //End of Added By Nikhil Adkar
                                }
                                //}
                                if (isValid == 1) {
                                    objDuration.value = objDuration.value.replace(".", ":");
                                }
                                if (objWorkCompleted != null) {
                                    ParentWorkComplete = workCompNew[0];
                                }
                            }
                            //Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                            if (k == arrayWeekDays.length - 1) {                                
                                    totalEnteredHours = 0;                                    
                            }
                            //End of Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs

                        }
                    }
                   
                    console.log(daParams);
                 //   debugger;
                    //Commented And Added by Usha Pandit On 08.08.2019 For wrong Alert showing please fill the activity when DA filled for previous weeks
                    //alert(blnDANotFilled);
                    //alert(daParams.length + " " + blnDANotFilled);
                    //if (daParams.length == 0) {
                    //Added By Usha Pandit On 03.03.2021 For zero hours check
                    //if (isNonZero == false && $("#DivTVStatusSection .Status").text() == "Rejected") {                        
                    //    showAlert('Please fill atleast one non-zero entry', 'alert-danger');
                    //    isValid = 1;                        
                    //}
                    var blnZeroForWeeklyExists = true;
                    
                    $.each(daParams, function (i, feature) {                       
                        if (feature.Duration != "00.00") {
                            blnZeroForWeeklyExists = false;
                        }
                    });
                    //Added By Usha Pandit On 03.03.2021 For zero hours check
                    if (blnZeroForWeeklyExists == false) {
                        blnDANotFilled = false;
                    }
                    //Commented By Dipali V On 18th March 2021 For Restirct Work Hours
                    //if (isNotAllowQuickEntry == true) {
                    //    showAlert('Some of the days are not allowed to fill DA for task.', 'alert-danger');
                    //    isValid = 1;
                    //}
                    //End of Commented By Dipali V On 18th March 2021 For Restirct Work Hours
                    
                    var IsDAFilledHrs = $("#IdAllTotal").text();
                    //if ($('#WhichTask_' + TaskID).val() != 'D') {
                        if (daParams.length == 0 || blnDANotFilled == true) {
                            //End Of Added by Usha Pandit On 08.08.2019 For wrong Alert showing please fill the activity when DA filled for previous weeks   
                            //Commented And Added By Usha Pandit On 17.05.2021 For correct validation if no changes made in DA
                            //if (IsDAFilledHrs == "00:00") {
                            if (IsDAFilledHrs == "00:00" || (daParams.length == 0 && blnZeroForWeeklyExists == true)) {
                                //End Of Added By Usha Pandit On 17.05.2021 For correct validation if no changes made in DA
                                showAlert('Please fill daily activity', 'alert-danger');
                            }
                            //objDuration.focus();
                            isValid = 1;
                        }
                    //}
                    //else {
                    //    isValid = 0;
                    //}

                    if (isValid == 0) {
                        // alert(daParams);
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
                                    if (IsCheckboxSelected == 1) {
                                        showAlert('Daily Activity entered and Task Completed successfully.', 'alert-success', 'btnSave');
                                    }
                                    else {
                                        showAlert('Daily Activity entered successfully.', 'alert-success', 'btnSave');
                                    }
                                    //Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                                    totalEnteredHours = 0;
                                    totalEnteredNewHours = 0;
                                    totalEnteredDynamicHours = 0;
                                    DynamicDurationhiddenId = '';
                                    totalEnteredDynamicWeekHours = 0;
                                    totalActualPreviousWeekHours = 0;
                                    totalActualPreviousWeekHoursWeekly = 0;
                                    TotalAllocationDurationhidden = 0;



                                    //End of Added by Chetan M on 16 March 2021 for give alert if task entered hours are greater than task hrs
                                    SubTaskTypeList = "";
                                    TaskIDList = "";
                                    IsDefault = 0;
                                    ReloadData(EmployeeID);
                                }
                                //Added By Usha Pandit On 18.07.2019 For reloading page if 0 hours entered and user tries to complete task
                                if (data == 2) {
                                    if (blnZeroForWeeklyExists == false) {
                                        if (IsCheckboxSelected == 1) {
                                            showAlert('Daily Activity entered and Task Completed successfully.', 'alert-success', 'btnSave');
                                        }
                                        else {
                                            showAlert('Daily Activity entered successfully.', 'alert-success', 'btnSave');
                                        }
                                    }
                                    totalEnteredHours = 0;
                                    totalEnteredNewHours = 0;
                                    totalEnteredDynamicHours = 0;
                                    DynamicDurationhiddenId = '';
                                    totalEnteredDynamicWeekHours = 0;
                                    totalActualPreviousWeekHours = 0;
                                    totalActualPreviousWeekHoursWeekly = 0;
                                    TotalAllocationDurationhidden = 0;

                                    SubTaskTypeList = "";
                                    TaskIDList = "";
                                    IsDefault = 0;
                                    ReloadData(EmployeeID);
                                     //Add By Dipali V On 23th For Remove Tooltip
                                   // $('#txtQuickEntry').on("blur");
                                     $("#txtQuickEntry").blur();
                                     //End of Add By Dipali V On 23th For Remove Tooltip
                                }
                                  //Add By Dipali V On 23th For Remove Tooltip
                                   // $('#txtQuickEntry').on("blur");
                                    $("#txtQuickEntry").blur();
                                   //End of Add By Dipali V On 23th For Remove Tooltip
                                //End Of Added By Usha Pandit On 18.07.2019 For reloading page if 0 hours entered and user tries to complete task
                            },
                            error: function (err) {
                                StopAjaxLoader("#bodyTSEntry");
                                console.log(err);
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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

                        var IsWorkHourFilled = 0;
                        var IsTaskCompleteFilled = 0;

                        //Added By Nikhil Adkar for DA Type Saving
                        var DAType = 'N';
                        if (PageFlag == 1 || PageFlag == '') {
                            var DATypeOC = document.getElementById('DATypeOC_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            var DATypeN = document.getElementById('DATypeN_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            var DATypeOT = document.getElementById('DATypeOT_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            var DATypeCB = document.getElementById('DATypeCB_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            if (DATypeOC.checked) {
                                DAType = 'S';
                            }
                            if (DATypeN.checked) {
                                DAType = 'N';
                            }
                            if (DATypeOT.checked) {
                                DAType = 'T';
                            }
                            if (DATypeCB.checked) {
                                DAType = 'B';
                            }

                        }
                        

            //End of Added By Nikhil Adkar



                        objEntryDate = document.getElementById('Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                        if (objEntryDate != null) {
                            objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            objDAID = document.getElementById('DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            objDescription = document.getElementById('Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            txtDuChRow = document.getElementById('txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            objIsTaskComplete = document.getElementById('dailyIsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            var IsTaskCompleteCheck = 0;
                            if (objIsTaskComplete != null)
                                IsTaskCompleteCheck = objIsTaskComplete.checked;
                            if (Hours_OnChange(objDuration, 1) == false) { isValid = 1; };
                            //Added By Usha Pandit On 06.03.2021 for correct task completion check
                            if (objIsTaskComplete != null)
                                IsTaskCompleteCheck = objIsTaskComplete.checked;
                            //End Of Added By Usha Pandit On 06.03.2021 for correct task completion check
                            objWorkCompleted = document.getElementById('dailyWorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            var workComp = 0;
                            if (objWorkCompleted != null) {
                                if (objWorkCompleted.value == "" || objWorkCompleted.value == "%") {
                                    objWorkCompleted.value = "0%";
                                }
                                workComp = objWorkCompleted.value;
                                if (workComp.indexOf('%') == -1) {
                                    workComp = objWorkCompleted.value + "%";
                                }
                            }

                            if (objWorkCompleted != null) {

                                if (workComp.indexOf('%') > 0) {
                                    var workCompNew = workComp.split("%")
                                    workComp = workCompNew[0]
                                    //Added by Sagar N on 27-Dec-2018 Purpose: Work Complete % not more than 100 ; ISSUE ID-16623
                                    if (workCompNew[0] != 0) {
                                        if (checkNumber(workCompNew[0]) == false) {
                                            showAlert('Please enter numeric values.', 'alert-danger');
                                            Isvalid = 1;
                                            return false;
                                        }
                                        if (workCompNew[0] > 100 || workCompNew[0] < 0) {
                                            //alert("Not greater" + workComp)
                                            showAlert('Work Complete % should not be greater than 100', 'alert-danger');
                                            return false;
                                            isValid = 1;
                                        }
                                    }
                                }
                            }
                            objResourceLevelTaskCompletion = document.getElementById('ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            objStoryPoint = document.getElementById('StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);

                            var storypoint = 0;
                            if (objStoryPoint != null) {
                                if (StoryPoint_OnChange(objStoryPoint, 1) == false) { isValid = 1; };
                                storypoint = objStoryPoint.value;
                                if (storypoint != 0) {
                                    if (objDuration.value == "00:00") {
                                        showAlert('Please Enter Daily Activity', 'alert-danger');
                                        //ReloadData(EmployeeID);
                                        objDuration.focus();
                                        isValid = 1;
                                    }
                                }
                            }
                            // 

                             
                                if (objDuration.value != "00:00") {
                                   
                                    if (objWorkCompleted != null) {
                                       
                                        if (objWorkCompleted.value != objWorkCompleted.defaultValue) {
                                            IsWorkHourFilled = 1;
                                        }
                                       
                                    }
                                    if (objIsTaskComplete != null) {
                                        if (objIsTaskComplete.hasAttribute('disabled'))
                                        {
                                        }
                                        else {
                                            //IsTaskCompleteFilled = 1;
                                            if (objIsTaskComplete.checked) {
                                                IsTaskCompleteFilled = 1;
                                            }
                                        }
                                    }
                                  
                                }
                            var Default = objDuration.defaultValue

                            //.replace(/:/g, ".");
                            //
                            //if (objDuration.value != objDuration.defaultValue) {
                            //Added & commented By dipali V On 3rd April 2019 for Task completation Alert
                            // if (objDuration.value != "0.00") {
                            //if (objDuration.value != "00:00") {
                                //End of Added & commented By dipali V On 3rd April 2019 for Task completation Alert
                            //Commented and added by Chetan M on 13th Aug 2020 for IssueId 24361
                            //if (objDuration.value != Default || IsWorkHourFilled == 1 || IsTaskCompleteFilled == 1 && objDuration.value != 0)
                            //Commented And Added By Usha Pandit On 17.05.2021 For not showing alert if no changes made in DA
                            //if (objDuration.value != Default || IsWorkHourFilled == 1 || IsTaskCompleteCheck == 1 || IsTaskCompleteFilled == 1 && objDuration.value != 0)                            
                        if (objDuration.value != Default || IsWorkHourFilled == 1 || (IsTaskCompleteCheck == 1 && objDuration.value != Default) || IsTaskCompleteFilled == 1 && objDuration.value != 0)                            
                            //End Of Added By Usha Pandit On 17.05.2021 For not showing alert if no changes made in DA
                            //if (objDuration.value == Default  || objDuration.value != Default || IsWorkHourFilled == 1 || IsTaskCompleteFilled == 1  && objDuration.value != 0)
                            //End of Commented and added by Chetan M on 13th Aug 2020 for IssueId 24361
                            {
                                    if (IsTaskCompleteCheck == 1) { IsCheckboxSelected = 1; }

                            //Added By Nikhil Adkar on 18-Sep-2024 for not saving DA type for View time sheet and My Timesheet
                            if (PageFlag == 1 || PageFlag == '') {

                                daParams.push({
                                    DailyActivityEntryID: objDAID.value,
                                    TaskID: TaskID,
                                    ProjectID: ProjectID,
                                    EmployeeID: EmployeeID,
                                    EntryDate: objEntryDate.value,
                                    Duration: objDuration.value.replace(":", "."),
                                    Description: objDescription.value.replace(/'/g, "''"),
                                    SubTasktypeID: SubTaskTypeID,
                                    IsDurationChange: txtDuChRow.value,
                                    IsTaskComplete: IsTaskCompleteCheck,
                                    ActualPercentComplete: (objWorkCompleted == null ? 0 : workCompNew[0]),
                                    bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                                    StoryPoint: storypoint,
                                    //Addded By Nikhil Adkar on 16-Sept-2024 for Saving the DA Type in Daily View
                                    charDAType: DAType,
                                    //End of Added By Nikhil Adkar
                                    //Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                                    dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                                    dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                                    //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue

                                });
                            }
                            else {
                                daParams.push({
                                    DailyActivityEntryID: objDAID.value,
                                    TaskID: TaskID,
                                    ProjectID: ProjectID,
                                    EmployeeID: EmployeeID,
                                    EntryDate: objEntryDate.value,
                                    Duration: objDuration.value.replace(":", "."),
                                    Description: objDescription.value.replace(/'/g, "''"),
                                    SubTasktypeID: SubTaskTypeID,
                                    IsDurationChange: txtDuChRow.value,
                                    IsTaskComplete: IsTaskCompleteCheck,
                                    ActualPercentComplete: (objWorkCompleted == null ? 0 : workCompNew[0]),
                                    bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                                    StoryPoint: storypoint,
                                    //Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                                    dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                                    dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                                    //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue

                                });
                                //End of Added By Nikhil Adkar

                            }
                                    
                                }
                           // }
                            if (isValid == 1) {
                                objDuration.value = objDuration.value.replace(".", ":");
                            }
                        }
                    }
                    console.log(daParams);
                    //Commented And Added By Usha Pandit On 26.10.2020 For not allowing to complete the task
                    //if (daParams.length == 0) {                       
                    //    showAlert('Please fill daily activity', 'alert-danger');
                    //    //objDuration.focus();
                    //    isValid = 1;
                    //}
                    var IsDAFilledHrs = $("#IdAllTotal_Daily").text();
                    //Commented And Added By Usha Pandit On 05.03.2021 for save functionality with valid alert
                    //if (daParams.length == 0 && IsTaskCompleteCheck == false) {
                    //    if (IsDAFilledHrs == "00:00") {
                    //        showAlert('Please fill daily activity', 'alert-danger');
                    //        }
                    //    //objDuration.focus();
                    //    isValid = 1;
                    //}
                    
                    var blnZeroExists = true;
                    
                    $.each(daParams, function (i, feature) {
                        
                        if (feature.Duration != "00.00") {
                            blnZeroExists = false;
                        }
                    });
                    //Commented And Added By Usha Pandit On 17.05.2021 For correct validation if no changes made in DA
                    //if (daParams.length == 0 && IsTaskCompleteCheck == false) {
                    if (daParams.length == 0) {
                         //End Of Added By Usha Pandit On 17.05.2021 For correct validation if no changes made in DA
                        //Commented And Added By Usha Pandit On 17.05.2021 For correct validation if no changes made in DA
                        //if (IsDAFilledHrs == "00:00") {
                        if (IsDAFilledHrs == "00:00" || (daParams.length == 0 && blnZeroExists == true)) {
                        //End Of Added By Usha Pandit On 17.05.2021 For correct validation if no changes made in DA
                            showAlert('Please fill daily activity', 'alert-danger');
                        }
                        //objDuration.focus();
                        isValid = 1;
                    }
                    else if(daParams.length >= 1 && IsDAFilledHrs == "00:00" && blnZeroExists == true) {
                        showAlert('Please fill daily activity', 'alert-danger');  
                        isValid = 1;
                    }
                    //Commented By Usha Pandit On 17.05.2021 For correct validation if no changes made in DA
                    //if(IsDAFilledHrs != "00:00" && blnZeroExists == true) {
                    //    plotDailyTaskList(EmployeeID);                    
                    //}
                    //if(daParams.length >= 1 && IsDAFilledHrs != "00:00" && blnZeroExists == true) {
                    //    plotDailyTaskList(EmployeeID);
                    //    $.each(daParams, function (i, feature) {
                    //        feature.IsTaskComplete = false;
                    //    });
                    //}
                    //End Of Commented By Usha Pandit On 17.05.2021 For correct validation if no changes made in DA
                    //End Of Added By Usha Pandit On 05.03.2021 for save functionality with valid alert
                    //End Of Added By Usha Pandit On 26.10.2020 For not allowing to complete the task

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
                                    if (IsCheckboxSelected == 1) {
                                        showAlert('Daily Activity entered and Task Completed successfully.', 'alert-success', 'btnSave');
                                    }
                                    else {
                                        showAlert('Daily Activity entered successfully.', 'alert-success', 'btnSave');
                                    }
                                    SubTaskTypeList = "";
                                    strTaskIDList = "";
                                    SubTaskTypeList = "";
                                    TaskIDList = "";
                                    IsDefault = 0;
                                    ReloadData(EmployeeID);
                                    plotDailyTaskList(EmployeeID);
                                    //ReloadData(EmployeeID);
                                }
                                //Added By Usha Pandit On 18.07.2019 For reloading page if 0 hours entered and user tries to complete task
                                if (data == 2) {
                                    //Added By Usha Pandit On 06.03.2021 for alert on save task
                                    if (blnZeroExists == false) {
                                        if (IsCheckboxSelected == 1) {
                                            showAlert('Daily Activity entered and Task Completed successfully.', 'alert-success', 'btnSave');
                                        }
                                        else {
                                            showAlert('Daily Activity entered successfully.', 'alert-success', 'btnSave');
                                        }
                                    }
                                     //Add By Dipali V On 23th For Remove Tooltip
                                   // $('#txtQuickEntry').on("blur");
                                    $("#txtQuickEntry").blur();
                                   //End of Add By Dipali V On 23th For Remove Tooltip
                                    //End Of Added By Usha Pandit On 06.03.2021 for alert on save task
                                    SubTaskTypeList = "";
                                    strTaskIDList = "";
                                    SubTaskTypeList = "";
                                    TaskIDList = "";
                                    IsDefault = 0;
                                    ReloadData(EmployeeID);
                                    plotDailyTaskList(EmployeeID);
                                }
                                  //Add By Dipali V On 23th For Remove Tooltip
                                   // $('#txtQuickEntry').on("blur");
                                    $("#txtQuickEntry").blur();
                                   //End of Add By Dipali V On 23th For Remove Tooltip
                                //End Of Added By Usha Pandit On 18.07.2019 For reloading page if 0 hours entered and user tries to complete task
                            },
                            error: function (err) {
                                StopAjaxLoader("#bodyTSEntry");
                                console.log(err);
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                }
            }
            
        }
        var ValidateLeave = 0;

        function ConfirmLeaveForCreateTask(flag) {

            if (flag == 1) {

                SaveCreateTask(CreateTaskFlag);
            }


        }
        function ValidateLeaveFn() {
            //
            //$("#btnCreateTask").css('pointer-events', 'none');
            var objcboProject = document.getElementById("cboProject");
            var objCTselectdate = document.getElementById("CTselectdate");
            var objtxtWorkHrs = document.getElementById("txtWorkHrs");
            // 
            var taskParameters = {
                dtFromDate: objCTselectdate.value,
                ProjectID: objcboProject.value,
                intEmployeeID: EmployeeID,
                Duration: objtxtWorkHrs.value
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/ValidateCreateTask',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    //$("#btnCreateTask").css('pointer-events', 'unset');
                    if (data != "") {
                        if (data == "Confirm" || data == 'OULESS') {

                            //PopupDisplay = data;
                            chkISVALID = 1;
                            CTinvalidData = data;
                            //alert(chkISVALID)
                        }
                        else {
                            showAlert(data, 'alert-danger');

                        }
                        return false;

                    }
                    else {
                        chkISVALID = 0;
                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

            //  
            //alert(chkISVALID);
            //if (chkISVALID == 1)
            //{
            //    return false;
            //}
        }
        //Added By Usha Pandit On 19.03.2021 For restrict special characters
        function disallowSpecialCharacters(obj) {
            if (obj == null) { return false; }
            if (isBlank(getInputValue(obj))) { return false; }
            var msg = (arguments.length > 1) ? arguments[1] : "";
            msg = replaceSubstring(msg, "&#39;", "'");
            var dofocus = (arguments.length > 2) ? arguments[2] : true;
            //Commented and added by Chetan M on 5th Aug 2020 for All E Tech Issue ID = 25755
            //var spChars=(arguments.length>3)?arguments[3]:"[/:*?+\"><|,\\\\]";
            var spChars = (arguments.length > 3) ? arguments[3] : "['/:*?+\"><|,\\\\]";
            //End of Commented and added by Chetan M on 5th Aug 2020 for All E Tech Issue ID = 25755
            if (hasSpecialCharacters(getInputValue(obj), spChars)) {
                if (!isBlank(msg))
                { //alert(msg);
                }
                if (dofocus) {
                    setFocus(obj);
                }
                return true;
            }
            return false;
        }
        //End Of Added By Usha Pandit On 19.03.2021 For restrict special characters
        function ValidateCreateTask() {

            var objcboProject = document.getElementById("cboProject");
            var objtxtTaskName = document.getElementById("txtTaskName");
            var objcboTaskType = document.getElementById("cboTaskType");
            var objcboPriority = document.getElementById("cboPriority");
            var objtxtWorkHrs = document.getElementById("txtWorkHrs");
            var objtxtActualComplete = document.getElementById("txtActualComplete");
            var objtxtDescription = document.getElementById("txtDescription");
            var objCTselectdate = document.getElementById("CTselectdate");
            var isValidCreateTask = 0;
            var intSubTaskTypeID = "";
            var taskParameters = {
                dtFromDate: objCTselectdate.value,
                ProjectID: objcboProject.value,
                intEmployeeID: EmployeeID
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/ValidateCreateTask',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    //  
                    if (data != "") {
                        if (data == "Confirm") {
                            //PopupDisplay = data;
                            //$("#ConfirmMessageModalLeave").modal('show');
                            //  $("#ConfirmMessageModalLeaveDate").html("Selected date is employee leave or holiday.Do you wish to continue");

                        }
                        else {
                            showAlert(data, 'alert-danger');
                            isValidCreateTask = 1;
                        }
                        // isValid = 1;
                      //  $("#btnCreateTask").css('pointer-events', 'unset');
                        return false;
                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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
                    //Added By Dipali V On 3rd April 2019 For Focus After alter
                    objcboProject.focus();
                    //End of Added By Dipali V On 3rd April 2019 For Focus After alter
                    $('.bootstrap-select > .dropdown-toggle.bs-placeholder').focus(
                        function () {
                            $("#cboProject").parent('.bootstrap-select').find('.dropdown-toggle.bs-placeholder').css('border', '1px solid gray');
                        });

                    $("#cboProject").parent('.bootstrap-select').find('.dropdown-toggle.bs-placeholder').css('border', '1px solid #3c8dbc');
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
                //Added By Usha Pandit On 19.03.2021 For restrict special characters
                if (disallowSpecialCharacters(objtxtTaskName,"Special characters " + '[@/:*?+\';\"<|{}^#&%[,\]'  + " are not allowed in &#39;Task Name&#39; ",true,'[@/:*?+\';\"<|{}^#&%[,\\\\]')) {
                    showAlert('Please enter valid Task Name, special characters are not allowed', 'alert-danger');
                    objtxtTaskName.focus();
                    return false;
                }
                //End Of Added By Usha Pandit On 19.03.2021 For restrict special characters
                if ((objtxtTaskName).length > 255) {
                    showAlert('Max length for Task Name is 255.', 'alert-danger');
                    objtxtTaskName.focus();
                    return false;
                }
            }


            //TaskType Validation
            if (objcboTaskType != null) {
                if (objcboTaskType.value == "") {
                    showAlert('Please select Task Type.', 'alert-danger');
                    //Added By Dipali V On 3rd April 2019 For Focus After alter
                    objcboTaskType.focus();
                    //End of Added By Dipali V On 3rd April 2019 For Focus After alter
                    //objcboTaskType.focus();
                    $('.bootstrap-select > .dropdown-toggle.bs-placeholder').focus(
                        function () {
                            $("#cboTaskType").parent('.bootstrap-select').find('.dropdown-toggle.bs-placeholder').css('border', '1px solid gray');
                        });

                    $("#cboTaskType").parent('.bootstrap-select').find('.dropdown-toggle.bs-placeholder').css('border', '1px solid #3c8dbc');

                    return false;
                }
            }

            //Priority Validation
            if (objcboPriority != null) {
                if (objcboPriority.value == "" || objcboPriority.value == "0") {
                    showAlert('Please select Priority.', 'alert-danger');
                    //Added By Dipali V On 3rd April 2019 For Focus After alter
                    objcboPriority.focus();
                    //End of Added By Dipali V On 3rd April 2019 For Focus After alter
                    $('.bootstrap-select > .dropdown-toggle.bs-placeholder').focus(
                        function () {
                            $("#cboPriority").parent('.bootstrap-select').find('.dropdown-toggle').css('border', '1px solid gray');
                        });

                    $("#cboPriority").parent('.bootstrap-select').find('.dropdown-toggle').css('border', '1px solid #3c8dbc');
                    return false;
                }
            }

            //For Actual Time
            if (objtxtWorkHrs != null) {
                if (objtxtWorkHrs.value == "") {
                    showAlert('Please Enter Actual Time.', 'alert-danger');
                    objtxtWorkHrs.focus();
                    objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                    return false;
                }
            }



            // //For Description
            //  if (objtxtDescription != null) {
            //    if (objtxtDescription.value == "") {
            //        showAlert('Please Enter Task Description.', 'alert-danger');
            //        objtxtDescription.focus();
            //        return false;
            //    }
            //}
            //For Description
            if (objtxtDescription != null) {
                if ((objtxtDescription).length > 2000) {
                    showAlert('Max length for Task Description is 2000.', 'alert-danger');
                    objtxtDescription.focus();
                    return false;
                }
            }
            //return;
            // 
            // var objtxtWorkHrs = document.getElementById(objtxtWorkHrs.id);
            objtxtWorkHrs.value = objtxtWorkHrs.value.replace(/:/g, ".");
            var precision = objtxtWorkHrs.value.split(".")[1];
            if (precision > 60) {
                // showAlert('Please enter minutes less than 60.', 'alert-danger');
                showAlert('Please enter minutes in two decimal and less than 60.', 'alert-danger');
                objtxtWorkHrs.focus();
                Isvalid = 1;
                objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                return false;
            }
            if (precision == 60) {
                objtxtWorkHrs.value = (objtxtWorkHrs.value.split(".")[0] - 0) + 1;
            }
            if (objtxtWorkHrs != null) {
                if ((objtxtWorkHrs.value - 0) == 0) {
                    showAlert('Please Enter Actual Time greater than 0.', 'alert-danger');
                    objtxtWorkHrs.focus();
                    objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                    return false;
                }
            }

            //Added By Rutuja D. on 16 April 2020 For IssueID = 23577
            if (objtxtActualComplete != null) {
                if (RestrictNonNumeric(objtxtActualComplete) == true) {
                    showAlert('Please enter only positive numeric value!!!', 'alert-danger');
                    objtxtActualComplete.focus();
                    return false;
                }
                if ((objtxtActualComplete.value - 0) >= 0 && (objtxtActualComplete.value - 0) <= 100) {
                } else {
                    //Commented & Added By Dipali V On 21th May 2020 for issue id 23557
                    //showAlert('Actual Percent complete should be in a range (0 - 100) Hours.', 'alert-danger');
                    //showAlert('Actual Percent complete should be in a range (0 - 100) Hours.', 'alert-danger');
                     showAlert('Actual Percent complete should be in a range (0 - 100) percentage.', 'alert-danger');
                    //End of Commented & Added By Dipali V On 21th May 2020 for issue id 23557
                    objtxtActualComplete.focus();
                    return false;
                }
            }
            //End Added By Rutuja D. on 16 April 2020 For IssueID = 23577


            if (objtxtWorkHrs != null) {
                if (RestrictNonNumeric(objtxtWorkHrs) == true) {
                    showAlert('Please enter only positive numeric value!!!', 'alert-danger');
                    objtxtWorkHrs.focus();
                    //isValidCreateTask = 1;
                    objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                    return false;
                }
                if ((objtxtWorkHrs.value - 0) >= 0 && (objtxtWorkHrs.value - 0) <= 24) {
                } else {
                     
                                   
                                   
                    //Commented & Added By Dipali V On 4th Jan 2019 For Alter Issue
                    //showAlert('Work should be in a range (0 - 24) Hours.', 'alert-danger');
                    // You can not enter more than 24 hours a day
                    
                    showAlert('You can not enter more than 24.00 hours a day.', 'alert-danger');
                   
                    objtxtWorkHrs.focus();
                    //Commented & Added By Dipali V On 4th Jan 2019 For Alter Issue
                    //isValidCreateTask = 1;
                    objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                    return false;
                }
                // 
                if (GlobalRestrictByMinHours != null) {
                    if (GlobalRestrictByMinHours == 1) {
                        if (GlobalHoursFlag == 1) {
                            var minutes = objtxtWorkHrs.value.split('.');
                            var p = minutes[0];
                            var dec = minutes[1];
                            if (dec == undefined) { dec = 0; }
                            d = (dec - 0) / 60 + (p - 0);
                        }
                        else {
                            var d = objtxtWorkHrs.value;
                        }
                        if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                            showAlert('Please specify the work (hours) in multiples of ' + MinDAENtryDisplay + ' hours.\nThis is necessary because the user can only fill a minimum of ' + MinDAENtryDisplay + ' hours in the timesheet.', 'alert-danger');
                            objtxtWorkHrs.focus();
                            objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                            return false;
                        }
                    }
                }
                //
                var taskParameters = {
                    ProjectID: objcboProject.value,
                    intEmployeeID: EmployeeID,
                    Duration: objtxtWorkHrs.value,
                    //TaskName: objtxtTaskName.value,
                    TaskName: objtxtTaskName.value.replace(/'/g, "''"),
                    CTselectdate: objCTselectdate.value,
                    intSubTaskTypeID: $("#cboSubTaskType").val()

                }

                // alert(intSubTaskTypeID);
                $.ajax({
                    url: strUrl + '/api/Timesheet/ValidateCreateTask_Work',
                    type: "POST",
                    data: JSON.stringify(taskParameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (data) {
                        //
                        if (data != "") {
                            if (data.indexOf('$$') >= 0) {
                                var arrValue = data.split('$$');
                                if (arrValue[0] == "1") {
                                    $("#ConfirmMessageModalCreateTask").modal('show');
                                    $("#ConfirmationMsgCreateTask").html(arrValue[1]);
                                    isValidCreateTask = 1;
                                }
                            }
                            else {
                                showAlert(data, 'alert-danger');
                                isValidCreateTask = 1;
                                return false;
                            }
                        }
                    },
                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
                if (isValidCreateTask == 1) {
                    objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                    return false;
                }
                else {
                    objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                }
            }

            //Commented By Rutuja D. on 16 April 2020 For IssueID = 23577

            //if (objtxtActualComplete != null) {
            //    if (RestrictNonNumeric(objtxtActualComplete) == true) {
            //        showAlert('Please enter only positive numeric value!!!', 'alert-danger');
            //        objtxtActualComplete.focus();
            //        return false;
            //    }
            //    if ((objtxtActualComplete.value - 0) >= 0 && (objtxtActualComplete.value - 0) <= 100) {
            //    } else {
            //        showAlert('Actual Percent complete should be in a range (0 - 100) Hours.', 'alert-danger');
            //        objtxtActualComplete.focus();
            //        return false;
            //    }
            //}
            //End Commented By Rutuja D. on 16 April 2020 For IssueID = 23577 (OU working Hours Per Day Message Model Popup shows first so in that way we are creating new task )

            objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
            //if (PopupDisplay != "") {

            //}

        }
        var CreateTaskFlag;
        var MenuTags;
        function CreateTask_Save_OnClick(flag) {
           // 
           
          //  $("#btnCreateTask").css('pointer-events', 'none');
            var chkFlag;
            chkFlag = ValidateCreateTask();

            if (chkFlag != false) {
                //   
                // var valFlag = ValidateLeaveFn();

                CreateTaskFlag = flag;
                ValidateLeaveFn();
                //
                if (chkISVALID == 1) {
                    $("#ConfirmMessageModalLeave").modal('show');
                    if (CTinvalidData == 'Confirm') {
                        $("#ConfirmMessageModalLeaveDate").html("Selected date is employee leave or holiday.Do you wish to continue?");
                    }
                    else if (CTinvalidData == 'OULESS') {
                        $("#ConfirmMessageModalLeaveDate").html("Entered Hours are greater than OU Hours.Do you want to continue?");
                    }

                }
                else if (chkISVALID == 0) {
                    $('#btnCreateTask').css("display","none");
                    $("#btnSaveCreateTask").css("display","none");
                    
                   // $("#btnCreateTask").css('pointer-events', 'none');
                    SaveCreateTask(CreateTaskFlag);
                    // $("#btnCreateTask").css('pointer-events', 'unset');
                }

            }
            //
           // $("#btnCreateTask").css('pointer-events', 'unset');
        }
        function SaveCreateTask(flag) {
            //
            var objcboProject = document.getElementById("cboProject");
            var objtxtTaskName = document.getElementById("txtTaskName");
            var objcboTaskType = document.getElementById("cboTaskType");
            var objcboSubTaskType = document.getElementById('cboSubTaskType');
            var objcboPriority = document.getElementById("cboPriority");
            var objtxtWorkHrs = document.getElementById("txtWorkHrs");
            var objtxtActualComplete = document.getElementById("txtActualComplete");
            var objtxtDescription = document.getElementById("txtDescription");
            var objCTselectdate = document.getElementById("CTselectdate");

            //  if (valFlag != false) {{
            var taskParameters = {
                intEmployeeID: EmployeeID,
                ProjectID: objcboProject.value,
                //TaskName: objtxtTaskName.value,
                TaskName: objtxtTaskName.value.replace(/'/g, "''"),

                Duration: objtxtWorkHrs.value.replace(/:/g, "."),
                FilterTaskTypeID: objcboTaskType.value,
                SubTasktypeID: objcboSubTaskType.value,
                CreatedBy: UserName,
                dtFromDate: objCTselectdate.value,
                PriorityID: objcboPriority.value,
                ActualPercentComplete: objtxtActualComplete.value,
                Description: objtxtDescription.value.replace(/'/g, "''"),
                bitFlag: flag
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/SaveCreateTask',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    //
                    //  $("#btnCreateTask").attr("disabled", "disabled");
                    if (data != '') {
                        if (flag == 1) {
                            showAlert('Task created and actual filled successfully.', 'alert-success');
                          //  $("#btnCreateTask").css('pointer-events', 'unset');
                            //TaskIDList = data;
                            //IsDefault = 1;
                            if (isWeeklyView == 1)
                                ReloadData(EmployeeID);
                            else
                                plotDailyTaskList(EmployeeID);
                            $("#createtaskmodal").modal('hide');
                        }
                        else if (flag == 2) {
                            showAlert('Task created and actual filled successfully.', 'alert-success');
                            //$("#btnCreateTask").css('pointer-events', 'unset');
                            TaskIDList = data;
                            IsDefault = 1;
                            if (isWeeklyView == 1)
                                ReloadData(EmployeeID);
                            else
                                plotDailyTaskList(EmployeeID);

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
                            clearCreateTaskData();
                        }
                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            // $("#btnCreateTask").css('pointer-events', 'unset');
        }
        function SendConfirmationResponseForCreateTask(response) {
            var objCreateTaskWorkHrs = document.getElementById('txtWorkHrs');
            if (response == 0) {
                objCreateTaskWorkHrs.value = "";
            }
        }

        //Added By Reshma Chavan on 12th Nov 2021
        function Hours_QuickEntry(objHoursComplete,IsWeeklyView) {
            
                objHoursComplete.value = ConvertToDecimal(objHoursComplete.value);               
                objHoursComplete.value = objHoursComplete.value.replace(/:/g, ".");

            var precision = objHoursComplete.value.split(".")[1]; 
            if (precision > 60)
            {
                showAlert('Please enter minutes in two decimal and less than 60.', 'alert-danger');
                return 1;
                
            }
            if (precision == 60)
            {
                objHoursComplete.value = (objHoursComplete.value.split(".")[0] - 0) + 1;
                if (IsWeeklyView == 1) {
                    $("#txtQuickEntry").val((objHoursComplete.value.replace(".", ":")) + ":00");
                }
                else {
                    $("#txtQuickEntryDaily").val((objHoursComplete.value.replace(".", ":")) + ":00");
                }
            }           
            
        }
        //end of Added By Reshma Chavan on 12th Nov 2021
        var isNotAllowQuickEntry = false;
        function QuickEntry_Click() {
           
            isNotAllowQuickEntry = false;
            var objtxtQuickEntry;
            var objEntryDate;
            var quickflag = 0;
            var errorFlag = 0;
            var TotalAllocationDuration = 0; 
            var TotalActualDurationhidden = 0;

            //Added By Reshma Chavan on 12th Nov 2021 for crash on Quick Entry
            if (isWeeklyView == 1) {
                var QuickEntry = Hours_QuickEntry(document.getElementById("txtQuickEntry"),1);
            }
            else {
                var QuickEntry = Hours_QuickEntry(document.getElementById("txtQuickEntryDaily"),0);
            }

            if (QuickEntry == 1)
            {
                return false;
            }
            //End of Added By Reshma Chavan on 12th Nov 2021 for crash on Quick Entry
          
            if (isWeeklyView == 1) {
                objtxtQuickEntry = document.getElementById("txtQuickEntry");
            }
            else {
                objtxtQuickEntry = document.getElementById("txtQuickEntryDaily");
            }
            //objtxtQuickEntry.value = objtxtQuickEntry.value.replace(/:/g, ".");
            
            if (objtxtQuickEntry != null) {
                if (objtxtQuickEntry.value == "") {
                    showAlert('Please enter numeric value !', 'alert-danger');
                    objtxtQuickEntry.value = "";
                    objtxtQuickEntry.focus();
                    return false;
                }

                //Added By Reshma for issue on 25th Dec 2018 
                if (objtxtQuickEntry.value == 0 || objtxtQuickEntry.value == '00:00') {
                    showAlert('Please Enter More Than 0 Hours  !', 'alert-danger');
                    objtxtQuickEntry.value = "";
                    objtxtQuickEntry.focus();
                    return false;
                }
                //End By Reshma for issue on 25th Dec 2018 

                /* Added by Sagar N on 27-Dec-2018 for QuickEntry input length shoulde not be more than 5 IssueID : 16602 */
                if (objtxtQuickEntry.value.length > 5) {
                    showAlert('Please enter efforts in HH:mm format only !', 'alert-danger');
                    objtxtQuickEntry.value = "";
                    objtxtQuickEntry.focus();
                    return false;
                }
                /* End of adding by Sagar N on 27-Dec-2018 for QuickEntry input length shoulde not be more than 5 IssueID : 16602 */

                //if (RestrictNonNumeric(objtxtQuickEntry) == true) {
                //    showAlert('Please enter only positive numeric value!!!', 'alert-danger');
                //    objtxtQuickEntry.value = "";
                //    objtxtQuickEntry.focus();
                //    return false;
                //}
                if (objtxtQuickEntry.value < 0) {
                    showAlert('Please enter only positive numeric value !', 'alert-danger');
                    objtxtQuickEntry.value = "";
                    objtxtQuickEntry.focus();
                    return false;
                }

                if (GlobalRestrictByMinHours == 1) {
                    if (GlobalHoursFlag == 1) {
                        var minutes = objtxtQuickEntry.value.split('.');
                        var p = minutes[0];
                        var dec = minutes[1];
                        if (dec == undefined) { dec = 0; }
                        d = (dec - 0) / 60 + (p - 0);
                    }
                    else {
                        var d = objtxtQuickEntry.value;
                    }
                    if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                        showAlert("Please enter hours complete in multiples of " + MinDAENtryDisplay, "alert-danger");
                        objtxtQuickEntry.value = "";
                        objtxtQuickEntry.focus();
                        return false;
                    }
                }
                if ((objtxtQuickEntry.value - 0) > 24 || (objtxtQuickEntry.value - 0) < 0) {
                    //showAlert("The Range of Actual Working Hours is [0.00 to 24.00]", "alert-danger");
                    
                    //Added & Commented By Dipali V On 3rd Apr 2019 For alert Should be consist on Add Task & Entry Page
                    // showAlert("The Range of Actual Working Hours is [1.00 to 24.00]", "alert-danger");
                   
                    showAlert("You can not enter more than 24.00 hours a day", "alert-danger");
                    
                    //End of Added & Commented By Dipali V On 3rd Apr 2019 For alert Should be consist on Add Task & Entry Page
                    objtxtQuickEntry.value = "";
                    objtxtQuickEntry.focus();
                    return false;
                }

                var objQuickEntryDecimal = objtxtQuickEntry.value;
                //Commented By Usha Pandit On 07.05.2021 For getting correct quick entry hours
                //if (objQuickEntryDecimal.toString().indexOf(":") != -1) {
                //    var RequestParameters = {
                //        WorkHrs: encodeURI(objQuickEntryDecimal),
                //        Flag: encodeURI(2),
                //    }

                //    var param = JSON.stringify(RequestParameters);
                //    objQuickEntryDecimal = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                //}                
                //End Of Commented By Usha Pandit On 07.05.2021 For getting correct quick entry hours
                totalEnteredHours = 0; 
                totalEnteredDynamicHours = 0;
                totalActualPreviousWeekHours = 0;
                if (isWeeklyView == 1) {
                    var strTimesheetIDs;
                    strTimesheetIDs = $('input[name=chkQuickEntry]:checked').map(function () {
                        return this.id;
                    }).get().join(',');

                    if (strTimesheetIDs == "") {
                        showAlert('Please select atleast one task.', 'alert-danger');
                         //Add By Dipali V On 23th For Remove Tooltip
                        $("#txtQuickEntry").blur();
                //End of Add By Dipali V On 23th For Remove Tooltip
                        return false;
                    }
                    var arrQuickCheck = strTimesheetIDs.split(",")
                    
                    //2021                    
                    totalEnteredHours = 0; 
                    totalEnteredDynamicHours = 0;
                    totalActualPreviousWeekHours = 0;
                    //debugger;
                    //var curTaskId = 0;
                    //debugger;
                    for (var i = 0; i < arrQuickCheck.length; i++) {
                        var arrTaskData = arrQuickCheck[i].split("_");
                        var ProjectID = arrTaskData[1];
                        var TaskID = arrTaskData[2];
                        var SubTaskTypeID = arrTaskData[3];
                        arrayWeekDays = ["mon", "tue", "wed", "thu", "fri"];
                        for (var k = 0; k < arrayWeekDays.length; k++) {
                            objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                            var RequestParameters = {
                                WorkHrs: encodeURI(objDuration.value),
                                Flag: encodeURI(2),
                            }

                            var param1 = JSON.stringify(RequestParameters);
                            var objDurationDynamicVal = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param1, false);

                            totalEnteredDynamicHours = parseFloat(totalEnteredDynamicHours) + parseFloat(objDurationDynamicVal);

                            //if ($("#chkQuickEntry_" + ProjectID + "_" + TaskID + "_" + SubTaskTypeID).is(":checked")) {
                            //    //var value = $("#Duration_" + ProjectID + "_" + TaskID + "_" + SubTaskTypeID + "_" + k + 1).val();
                            //    var value = $("#pro_Calculate_count_" + TaskID).text();
                            //    //pro_Calculate_count_
                            //    alert(value);
                            //}
                            if ($("#chkQuickEntry_" + ProjectID + "_" + TaskID + "_" + SubTaskTypeID).is(":checked")) {
                                //if (curTaskId == 0 || curTaskId != TaskID) {
                                    //debugger;
                                    var value = $("#pro_Calculate_count_" + TaskID).text();
                                    
                                    //curTaskId = TaskID;
                                    
                                    var RequestParameters = {
                                        WorkHrs: encodeURI($("#TotalActualDynamicDurationhidden" + ProjectID + "_" + TaskID + "_" + SubTaskTypeID).val()),
                                        Flag: encodeURI(2),
                                    }
                                    
                                    var param4 = JSON.stringify(RequestParameters);
                                    var DynamicDurationhiddenval = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param4, false);
                                    //alert(DynamicDurationhiddenval);
                                     var RequestParameters = {
                                        WorkHrs: encodeURI(value),
                                        Flag: encodeURI(2),
                                    }
                                    
                                    var param5 = JSON.stringify(RequestParameters);
                                    var Dynamicpro_Calculate_count = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param5, false);

                                    //alert(Dynamicpro_Calculate_count);
                                    totalActualPreviousWeekHours = DynamicDurationhiddenval - Dynamicpro_Calculate_count;
                                    
                                //}
                                  
                            }
                        }
                    }
                   // alert(totalEnteredDynamicHours);
                    //2021
                    
                    for (var i = 0; i < arrQuickCheck.length; i++) {
                        var arrTaskData = arrQuickCheck[i].split("_");
                        var ProjectID = arrTaskData[1];
                        var TaskID = arrTaskData[2];
                        var SubTaskTypeID = arrTaskData[3];

                        arrayWeekDays = ["mon", "tue", "wed", "thu", "fri"];
                        for (var k = 0; k < arrayWeekDays.length; k++) {

                            //  
                            objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                            //2021
                            TotalAllocationDuration = document.getElementById('TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID); 
                            TotalActualDurationhidden = document.getElementById('TotalActualDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID); 
                            //Added By Dipali V on 22nd March 2021 For Allow Save Plan Work Hours
                            if (objDuration.value == "00:00" || objDuration.value == "00.00") {
                                totalEnteredHours = parseFloat(totalEnteredHours) + parseFloat(objQuickEntryDecimal);

                                var RequestParameters = {
                                    WorkHrs: encodeURI(totalEnteredHours),
                                    Flag: encodeURI(1),
                                }
                                var param = JSON.stringify(RequestParameters);
                                totalEnteredHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                                totalEnteredHours = totalEnteredHours.replace(':', '.');
                                //2021     
                            }
                             //Commented And Added By Usha Pandit On 07.05.2021 For getting correct quick entry hours
                             //var RequestParameters = {
                             //       WorkHrs: encodeURI(objtxtQuickEntry.value),
                             //       Flag: encodeURI(2),
                             //   }
                             //   var param = JSON.stringify(RequestParameters);
                             //   objNewtxtQuickEntry = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                             //   objNewtxtQuickEntry = objNewtxtQuickEntry.replace(':', '.');

                            objNewtxtQuickEntry = objQuickEntryDecimal.toString().replace(':', '.');
                            //End Of Added By Usha Pandit On 07.05.2021 For getting correct quick entry hours

                            
                                //objtxtQuickEntry.value = objNewtxtQuickEntry;
                            //
                            //alert(objtxtQuickEntry.value);
                            
                            //End of Added By Dipali V on 22nd March 2021 For Allow Save Plan Work Hours
                            // if (objEntryDate != undefined){
                            objEntryDate = document.getElementById('Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                            // }
                            // alert(objEntryDate);
                            if (objDuration.value == "00:00" || objDuration.value == "00.00") {
                                //totalEnteredNewHours = parseFloat(totalEnteredNewHours) + parseFloat(objtxtQuickEntry.value);
                                totalEnteredNewHours = parseFloat(totalEnteredNewHours) + parseFloat(objQuickEntryDecimal);
                                var taskParameters = {
                                    intEmployeeID: EmployeeID,
                                    dtFromDate: objEntryDate.value,
                                    ProjectID: ProjectID,
                                    TaskID: TaskID,
                                    SubTaskTypeID: SubTaskTypeID,
                                    // Duration: objDuration.value,
                                    //Duration: objtxtQuickEntry.value,
                                      Duration: objNewtxtQuickEntry,
                                    TotalDuration: totalEnteredHours, //Added By Chetan M on 16 March 2021
                                    IsTaskComplete: 0,
                                    Flag:"",
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
                                        //totalEnteredHours = 0;
                                        //
                                        //debugger;
                                        if (data == "") {
                                            var RequestParameters = {
                                                WorkHrs: encodeURI(TotalAllocationDuration.value),
                                                Flag: encodeURI(2),
                                            }
                                            var param2 = JSON.stringify(RequestParameters);
                                            var TotalAllocationDecimal = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param2, false);
                                           
                                          
                                           
                                            //debugger;
                                            if ($('#WhichTask_' + TaskID).val() != 'D') {
                                                if (parseFloat(totalEnteredDynamicHours) + parseFloat(totalActualPreviousWeekHours) + parseFloat(totalEnteredNewHours) <= parseFloat(TotalAllocationDecimal)) {
                                                    //objDuration.value = objtxtQuickEntry.value;
                                                    objDuration.value = objtxtQuickEntry.value.replace('.', ':');
                                                    if (quickflag == 0) {
                                                        quickflag = 1;
                                                    }
                                                }
                                                else {
                                                    errorFlag = 1;
                                                    objDuration.value = "00:00";
                                                }
                                            }
                                            else {
                                                quickflag = 1;
                                                errorFlag = 0;
                                                  objDuration.value =objtxtQuickEntry.value.replace('.', ':');
                                            }
                                        }
                                        else {
                                            errorFlag = 1;
                                            objDuration.value = "00:00"; 
                                        }
                                    },
                                    error: function (err) {
                                        console.log(err);
                                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                    }
                                });
                            }
                            else {
                                //errorFlag = 1;
                               /// objDuration.value = "00:00"; 
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
                         //Add By Dipali V On 23th For Remove Tooltip
                    $("#txtQuickEntry").blur();
                //End of Add By Dipali V On 23th For Remove Tooltip
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
                            //Commented And Added By Usha Pandit On 18.05.2021 For correct DA duration selection
                            //objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                            objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            //End Of Added By Usha Pandit On 18.05.2021 For correct DA duration selection
                            var RequestParameters = {
                                WorkHrs: encodeURI(objDuration.value),
                                Flag: encodeURI(2),
                            }

                            var param1 = JSON.stringify(RequestParameters);
                            var objDurationDynamicVal = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param1, false);

                            totalEnteredDynamicHours = parseFloat(totalEnteredDynamicHours) + parseFloat(objDurationDynamicVal);
                                                        
                            if ($("#chkQuickEntryDaily_" + ProjectID + "_" + TaskID + "_" + SubTaskTypeID).is(":checked")) {
                                //if (curTaskId == 0 || curTaskId != TaskID) {
                                //debugger;
                                var value = $("#pro_Calculate_count_" + TaskID).text();
                                //Added By Usha Pandit On 18.05.2021 For correct DA duration selection
                                if (value == "") {
                                    value = "00:00";
                                }
                                //End Of Added By Usha Pandit On 18.05.2021 For correct DA duration selection
                                //curTaskId = TaskID;
                                //Added By Usha Pandit On 18.05.2021 For correct DA duration selection
                                var objTotalActualDynamicDurationhidden = $("#TotalActualDynamicDurationhidden" + ProjectID + "_" + TaskID + "_" + SubTaskTypeID);
                                if (objTotalActualDynamicDurationhidden.val() != undefined && objTotalActualDynamicDurationhidden.val() != null) {
                                //End Of Added By Usha Pandit On 18.05.2021 For correct DA duration selection
                                    var RequestParameters = {
                                        WorkHrs: encodeURI($("#TotalActualDynamicDurationhidden" + ProjectID + "_" + TaskID + "_" + SubTaskTypeID).val()),
                                        Flag: encodeURI(2),
                                    }

                                    var param4 = JSON.stringify(RequestParameters);
                                    var DynamicDurationhiddenval = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param4, false);

                                    var RequestParameters = {
                                        WorkHrs: encodeURI(value),
                                        Flag: encodeURI(2),
                                    }

                                    var param5 = JSON.stringify(RequestParameters);
                                    var Dynamicpro_Calculate_count = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param5, false);

                                    totalActualPreviousWeekHours = DynamicDurationhiddenval - Dynamicpro_Calculate_count;
                                    //alert(totalActualPreviousWeekHours);
                                //}

                                }
                            }
                        }
                    }
                    for (var i = 0; i < arrQuickCheck.length; i++) {
                        var arrTaskData = arrQuickCheck[i].split("_");
                        var ProjectID = arrTaskData[1];
                        var TaskID = arrTaskData[2];
                        var SubTaskTypeID = arrTaskData[3];

                        objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                        objEntryDate = document.getElementById('Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                        TotalAllocationDuration = document.getElementById('TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID); 
                        //arrayWeekDays = ["mon", "tue", "wed", "thu", "fri"];
                        //for (var k = 0; k < arrayWeekDays.length; k++) {

                        //    objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                        //    if (objEntryDate != undefined) {
                        //        objEntryDate = document.getElementById('Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                        //    }
                        //}
                        if (objDuration.value == "00:00") {
                            totalEnteredNewHours = parseFloat(totalEnteredNewHours) + parseFloat(objQuickEntryDecimal);
                            var taskParameters = {
                                intEmployeeID: EmployeeID,
                                dtFromDate: objEntryDate.value,
                                ProjectID: ProjectID,
                                TaskID: TaskID,
                                SubTaskTypeID: SubTaskTypeID,
                                // Duration: objDuration.value,
                                Duration: objtxtQuickEntry.value,
                                TotalDuration: totalEnteredHours, //Added by Chetan M on 16 March 2021
                                IsTaskComplete: 0,
                                Flag:""
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
                                    //alert(data);
                                    if (data == "") {
                                        //objDuration.value = objtxtQuickEntry.value;
                                        //if (quickflag == 0)
                                        //    quickflag = 1;
                                        var RequestParameters = "";
                                        if (TotalAllocationDuration == null || TotalAllocationDuration == undefined) {
                                            RequestParameters = {
                                                WorkHrs: encodeURI("00:00"),
                                                Flag: encodeURI(2),
                                            }
                                        }
                                        else {
                                            RequestParameters = {
                                                WorkHrs: encodeURI(TotalAllocationDuration.value),
                                                Flag: encodeURI(2),
                                            }
                                        }
                                       
                                        var param2 = JSON.stringify(RequestParameters);
                                        var TotalAllocationDecimal = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param2, false);

                                        //debugger;
                                        
                                        if (parseFloat(totalEnteredDynamicHours) + parseFloat(totalActualPreviousWeekHours) + parseFloat(totalEnteredNewHours) <= parseFloat(TotalAllocationDecimal)) {
                                            //objDuration.value = objtxtQuickEntry.value;
                                            objDuration.value = objtxtQuickEntry.value.replace('.', ':');
                                            if (quickflag == 0) {
                                                quickflag = 1;
                                            }
                                        }
                                        else {
                                            errorFlag = 1;
                                            objDuration.value = "00:00";
                                        }
                                    }
                                    else {
                                        errorFlag = 1;
                                        //objDuration.value = "00:00"; 
                                    }
                                },
                                error: function (err) {
                                    console.log(err);
                                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                }
                            });
                        }
                        else {
                            showAlert(' Timesheet  entry is already filled and hours are  not going to override.', 'alert-danger');
                            $("#txtQuickEntry").blur();
                        }
                    }
                }
               // debugger;
                if (errorFlag == 1) {
                    totalEnteredNewHours = 0;
                    //	Issue ID 31814
                    setTimeout(function () {
                        showAlert('Some of the days are not allowed to fill DA for task.', 'alert-danger');
                    }, 2000);
                    //End of Issue ID 31814
                 //Add By Dipali V On 23th For Remove Tooltip
                    $("#txtQuickEntry").blur();
                //End of Add By Dipali V On 23th For Remove Tooltip
                }
                
                if (quickflag == 1) {
                    Save_OnClick();
                    //totalEnteredNewHours = 0;
                }

            }
        }
        var SubTaskTypeList = "";
        function SelectSubTask_OnClick() {
            //
            SubTaskTypeList = "";
            if (document.getElementById("hdnTaskForSubTask") != null) {
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
                    plotDailyTaskList(EmployeeID);

                $("#selectsubtask").modal('hide');
            }
        }
        function clearSubtask() {
            //
            $("[type=checkbox]").removeAttr("checked");
        }
        function ApprovePopup(btn, TaskID, TaskName) {
            // 
            $('#btnApproveTimesheet').css('pointer-events', 'none');
            $("#approvetaskbtnmodal").modal('show');
            //$("#txtApprovalComment").val("");
            $("#txtApprovalComment").val("Approved");
            $("#divTaskBlock").css("display", "block");
            $("#divTaskName").text(unescape(TaskName));
            var TaskCompleteChecked = 0;
            $('#btnApproveTimesheet').removeAttr('style');
            //Commented By Dipali V On 28th Jan 2021 For Reject time not able to edit
            if (JQuery(btn).closest('tr').find('[type=checkbox]').is(":checked")) {
            //if ($(btn).closest('tr').find('[type=checkbox]').is(":checked")) {
                //End of Commented By Dipali V On 28th Jan 2021 For Reject time not able to edit
                TaskCompleteChecked = 1;
            };
            document.getElementById("btnApproveTimesheet").setAttribute("onClick", "ApproveRejectTask(" + TaskID + ",'V'," + TaskCompleteChecked + ");");
            
            //ApproveRejectTask(TaskID,'V')
        }

        var selectedProjectID = "";
        function RejectPopup(btn, TaskID, TaskName, ProjectID) {
            //debugger;
            selectedProjectID = ProjectID;
            //var imgs = $('input:checkbox[name=images]:checked').map(function () { return this.value; }).get();
            //Added By Dipali V On 9th Apr 2019 For if All Completed task checkbox check then not allow to edit rejected timesheet
             //Commented & Added By Dipali V On 24th Feb 2021 For Clear CheckBox
           // $("#rejecttaskmodalcheckbox").removeAttr("checked");
            $("#rejecttaskmodalcheckbox").prop('checked', false);
             //End of Commented & Added By Dipali V On 24th Feb 2021 For Clear CheckBox
       
            var AllCheck = 0;
            $('input:checkbox[name=IsTaskComplete]').each(function () {
              
                if ($(this).prop("checked") == false) {
                   
                }
                else {
                    AllCheck = 1;
                    return;
                }
            });
             var AllowToResubmitCheck = getCorporateAllowToResubmitCheck();
             //debugger;
            //Added By Dipali V On 23rd March 2021 For Note checking back Days
            if (AllowToResubmitCheck != "") {
                globalAllowToResubmitCheck = AllowToResubmitCheck[0];
                globalProjectLevelBackWardDays = AllowToResubmitCheck[2];
                globalProjectLevelForWardDays = AllowToResubmitCheck[4];

                if (globalAllowToResubmitCheck == 0) {
                    globalAllowToResubmitCheck = false;
                }
                else {
                    globalAllowToResubmitCheck = true;
                }

                 if (globalProjectLevelBackWardDays == 0) {
                    globalProjectLevelBackWardDays = false;
                }
                else {
                    globalProjectLevelBackWardDays = true;
                }

                 if (globalProjectLevelForWardDays == 0) {
                    globalProjectLevelForWardDays = false;
                }
                else {
                    globalProjectLevelForWardDays = true;
                }
                //End of Added By Dipali V On 23rd March 2021 For Note checking back Days
            }
            //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
            setTSOverrideNote();
            //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
            //End of Added By Dipali V On 9th Apr 2019 For if All Completed task checkbox check then not allow to edit rejected timesheet
            //$('#btnRejectTimesheet').css('pointer-events', 'none');
             $("#rejecttaskmodalcheckbox").removeAttr("disabled", "");
                $("label[for='rejecttaskmodalcheckbox']").css("cursor", "pointer");
            $("#rejecttaskmodal").modal('show');
            //$("#txtRejectionComment").val("");
            $("#txtRejectionComment").val("Rejected");
            $("#lblEmployeeName").css('display', 'none');
            $("#lblRejectTaskEmployeeName").css('display', 'block');
            var TaskCompleteChecked = 0;
            //Commented By Dipali V On 28th Jan 2021 For Reject time not able to edit
            if (jQuery(btn).closest('tr').find('[type=checkbox]').is(":checked")) {
            //if ($(btn).closest('tr').find('[type=checkbox]').is(":checked")) {
                //End of Commented By Dipali V On 28th Jan 2021 For Reject time not able to edit
                
                TaskCompleteChecked = 1;
                $("#rejecttaskmodalcheckbox").attr("disabled", "disabled");
                $("label[for='rejecttaskmodalcheckbox']").css("cursor", "no-drop");
                //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
                globalAllowToResubmitCheck = false;
                //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
            };
            document.getElementById("btnRejectTimesheet").setAttribute("onClick", "ApproveRejectTask(" + TaskID + ",'J'," + TaskCompleteChecked + ");");
            //Added By Dipali V On 9th Apr 2019 For if All Completed task checkbox check then not allow to edit rejected timesheet

            //if (AllCheck == 1) {
            //    $("#rejecttaskmodalcheckbox").attr("disabled", "disabled");
            //    $("label[for='rejecttaskmodalcheckbox']").css("cursor", "no-drop");
            //    // $("#rejecttaskmodalcheckbox").closest("label"s).css("cursor", "no-drop");
            //}
            //else {
            //    $("#rejecttaskmodalcheckbox").removeAttr("disabled", "");
            //    $("label[for='rejecttaskmodalcheckbox']").css("cursor", "pointer");

            //}
        //    $('#btnRejectTimesheet').css('pointer-events', 'unset');
            //End of Added By Dipali V On 9th Apr 2019 For if All Completed task checkbox check then not allow to edit rejected timesheet
        }
        function ApproveTimesheet() {
            $('#btnApproveTimesheet').css("display","inline-block");
            //$('#btnApproveTimesheet').css('pointer-events', 'none');
            $("#approvetaskbtnmodal").modal('show');
            $("#txtApprovalComment").val("Approved");
            $("#divTaskBlock").css("display", "none");
            document.getElementById("btnApproveTimesheet").setAttribute("onClick", "ApproveAllTimesheet();");
            $('#btnApproveTimesheet').css('pointer-events', 'unset');

        }

        function CancelReject() {
             //Commented & Added By Dipali V On 24th Feb 2021 For Clear CheckBox
            // $("#rejecttaskmodalcheckbox").removeAttr("checked");
            $("#rejecttaskmodalcheckbox").prop('checked', false);
          //End of Commented & Added By Dipali V On 24th Feb 2021 For Clear CheckBox
            
        }
        
        //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
        var globalOverrideTSCheck = false;
        var globalAllowToResubmitCheck = false;
        //Added By Dipali V On 23rd March 2021 For Note checking back Days
        var globalProjectLevelBackWardDays = false;
        var globalProjectLevelForWardDays = false;
        //End of Added By Dipali V On 23rd March 2021 For Note checking back Days
        var globalBackdatingNoDays = 0;
        function getCorporateOverrideTSCheck() {            
            var OverrideTSCheck = false;           
                        
            $.ajax({
                url: strUrl + '/api/Timesheet/GetCorporateOverrideTSCheck',
                type: "POST",
                data: {},
                dataType: "json",
                async:false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (strResult) {                    
                    if (strResult != undefined && strResult != null) {
                        OverrideTSCheck = strResult;
                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });           
            
            return OverrideTSCheck;
        }
        function getCorporateAllowToResubmitCheck() {            
            var AllowToResubmitCheck = false;
            var taskParameters = {
                strTimesheetIDs: '<%= Request.QueryString("intTimesheetId")%>',
                intApproverID: '<%=Session("intUserID")%>',
                FromWhere: 'Reject',
                ProjectID:selectedProjectID
            }
            
            //var param = JSON.stringify(intTimesheetID = '<%= Request.QueryString("intTimesheetId")%>');         
            $.ajax({
                url: strUrl + '/api/Timesheet/GetCorporateAllowToResubmitCheck',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                async:false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (strResult) {                    
                    if (strResult != undefined && strResult != null) {
                        AllowToResubmitCheck = strResult;
                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });           
            
            return AllowToResubmitCheck;
        }
        function getBackdatingNoDays() {            
            var BackdatingNoDays = 0;           
                        
            $.ajax({
                url: strUrl + '/api/Timesheet/GetBackdatingNoDays',
                type: "POST",
                data: {},
                dataType: "json",
                async:false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (strResult) {                    
                    if (strResult != undefined && strResult != null) {
                        BackdatingNoDays = strResult;
                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });           
            
            return BackdatingNoDays;
        }
        function setTSOverrideNote() {
            //debugger;
           // alert(globalProjectLevelBackWardDays);

            $("#allowoverridenote").html("");
            if (globalOverrideTSCheck == true && globalAllowToResubmitCheck == false) {
                if (globalBackdatingNoDays != "00") {
                    $("#allowoverridenote").html("<li class='clsLI'>Over-riding Backward Re-entry and Submission Corporate Settings of upto " + globalBackdatingNoDays + " days is Enabled for Correction and Resubmission by User after Rejection of this Timesheet.</li>")
                        .append("<li class='clsLI'>" + "The tasks marked as ‘Not Complete’ can be edited by user and resubmitted.</li>")
                        .append("<li class='clsLI'>" + "The User will not be able to edit tasks marked as complete. The Project Manager will be required to reopen the completed tasks to enable the user to edit those.</li>")
                        .append("<li class='clsLI'>" + "If this is Rejected now, you will be able to approve only after the user corrects and re-submit it.</li>")
                        .append("<li class='clsLI'>" + "Click Reject Button to Continue.</li>");
                }
            }
            else if (globalOverrideTSCheck == false) {
                //Commented And Added By Usha Pandit On 25.03.2021 For not showing note if project level backdating is allowed
                //if (globalProjectLevelBackWardDays == false) {
                if (globalProjectLevelBackWardDays == false && globalAllowToResubmitCheck == false) {                    
                    //End Of Added By Usha Pandit On 25.03.2021 For not showing note if project level backdating is allowed
                    if (globalBackdatingNoDays != "00") {
                        $("#allowoverridenote").html("<li class='clsLI'>Backward Re-entry and Submission Corporate Settings (of Maximum " + globalBackdatingNoDays + " Days) Will Not Permit Correction by the User after Your Rejection of this Timesheet.</li>")
                            .append("<li class='clsLI'>" + "The user can only resubmit the same timesheet without any edit or correction.</li>")
                            .append("<li class='clsLI'>" + "Consequently, the data submitted earlier timesheet will be taken for any computations, such as resource utilization or cost calculation (billable and non-billable tasks) or profitability calculation (for billable tasks)</li>")
                            .append("<li class='clsLI'>" + "Do you still want to continue with action to Reject this timesheet?</li>")
                            .append("<span>" + "Click Reject Button to Continue.</span>");
                    }
                } else {

                    globalAllowToResubmitCheck = true;
                }

            }
            


            //if (globalOverrideTSCheck == false && globalAllowToResubmitCheck == false) {
            //    if (globalBackdatingNoDays != "00") {
            //        $("#allowoverridenote").html("<li class='clsLI'>Backward Re-entry and Submission Corporate Settings (of Maximum " + globalBackdatingNoDays + " Days) Will Not Permit Correction by the User after Your Rejection of this Timesheet.</li>")
            //            .append("<li class='clsLI'>" + "The user can only resubmit the same timesheet without any edit or correction.</li>")
            //            .append("<li class='clsLI'>" + "Consequently, the data submitted earlier timesheet will be taken for any computations, such as resource utilization or cost calculation (billable and non-billable tasks) or profitability calculation (for billable tasks)</li>")
            //            .append("<li class='clsLI'>" + "Do you still want to continue with action to Reject this timesheet?</li>")
            //            .append("<span>" + "Click Reject Button to Continue.</span>");
            //    }
            //}
        }
        //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings

        function RejectTimesheet() {
            
            //Commented & Added By Dipali V On 24th Feb 2021 For Clear CheckBox
           // $("#rejecttaskmodalcheckbox").removeAttr("checked");
            $("#rejecttaskmodalcheckbox").prop('checked', false);
             //End of Commented & Added By Dipali V On 24th Feb 2021 For Clear CheckBox
            $('#btnRejectTimesheet').css("display", "inline-block");
            var AllCheck = 1;
            //Added By Dipali V On 9th Apr 2019 For if All Completed task checkbox check then not allow to edit rejected timesheet
            if ($('input:checkbox[name=IsTaskComplete]').length > 0) {

                $('input:checkbox[name=IsTaskComplete]').each(function () {  //
                    if ($(this).prop("checked") == false) {
                        AllCheck = 0;
                        return;
                    }
                    //else {
                    //    AllCheck = 0;
                    //    return;
                    //}
                });
            }
            else {
                 AllCheck = 0;
                        //return;
            }
            //End of Added By Dipali V On 9th Apr 2019 For if All Completed task checkbox check then not allow to edit rejected timesheet
           // $('#btnRejectTimesheet').css('pointer-events', 'none');
            //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
            selectedProjectID = "";
            var AllowToResubmitCheck = getCorporateAllowToResubmitCheck();
             //debugger;
            //Added By Dipali V On 23rd March 2021 For Note checking back Days
            if (AllowToResubmitCheck != "") {
                globalAllowToResubmitCheck = AllowToResubmitCheck[0];
                globalProjectLevelBackWardDays = AllowToResubmitCheck[2];
                globalProjectLevelForWardDays = AllowToResubmitCheck[4];

                if (globalAllowToResubmitCheck == 0) {
                    globalAllowToResubmitCheck = false;
                }
                else {
                    globalAllowToResubmitCheck = true;
                }

                 if (globalProjectLevelBackWardDays == 0) {
                    globalProjectLevelBackWardDays = false;
                }
                else {
                    globalProjectLevelBackWardDays = true;
                }

                 if (globalProjectLevelForWardDays == 0) {
                    globalProjectLevelForWardDays = false;
                }
                else {
                    globalProjectLevelForWardDays = true;
                }
                //End of Added By Dipali V On 23rd March 2021 For Note checking back Days
            }
            setTSOverrideNote();
            //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
            $("#rejecttaskmodal").modal('show');
            $("#txtRejectionComment").val("");
            $("#lblEmployeeName").css('display', 'block');
            $("#lblRejectTaskEmployeeName").css('display', 'none');
            document.getElementById("btnRejectTimesheet").setAttribute("onClick", "RejectAllTimesheet();");
            //Added By Dipali V On 9th Apr 2019 For if All Completed task checkbox check then not allow to edit rejected timesheet
            if (AllCheck == 1) {
                $("#rejecttaskmodalcheckbox").attr("disabled", "disabled");
                $("label[for='rejecttaskmodalcheckbox']").css("cursor", "no-drop");
                //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
                globalAllowToResubmitCheck = false;
                //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
                // $("#rejecttaskmodalcheckbox").closest("label").css("cursor", "no-drop");
            }
            else {
                $("#rejecttaskmodalcheckbox").removeAttr("disabled", "");
                $("label[for='rejecttaskmodalcheckbox']").css("cursor", "pointer");


            }
            //$('#btnRejectTimesheet').css('pointer-events', 'unset');
            //End of Added By Dipali V On 9th Apr 2019 For if All Completed task checkbox check then not allow to edit rejected timesheet
        }
        function ApproveRejectTask(TaskID, strStatus, TaskCompleteChecked) {
            //debugger;
            var strComment = "";
            var bitAllowToResubmit = 0;
            var Isvalid = 0;
            if (strStatus == "V") {
                strComment = $("#txtApprovalComment").val();
                //Added By Dipali V 9th Jan 2019 For Comment as Approved For Approved the timesheet
                if (strComment == "") {

                    //strComment = $("#txtApprovalComment").val("Approved");
                    strComment = "Approved";
                } else {
                    strComment = strComment;

                }
                //End of Added By Dipali V 9th Jan 2019 For Comment as Approved For Approved the timesheet
            }
            else if (strStatus == "J") {
                strComment = $("#txtRejectionComment").val();
                bitAllowToResubmit = ($("#rejecttaskmodalcheckbox").is(':checked') ? 1 : 0);
                 //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
                if (globalAllowToResubmitCheck == true) {
                    bitAllowToResubmit = 1;
                }
                else {
                    if (globalOverrideTSCheck == true) {
                        bitAllowToResubmit = 1;
                    }
                    else {
                        bitAllowToResubmit = 0;
                    }
                }
                if (globalBackdatingNoDays == "00") {
                    bitAllowToResubmit = 1;
                }
                //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
                if (bitAllowToResubmit == 1) { TaskCompleteChecked = 0; }
                if (strComment == "") {
                    showAlert("Enter Reason for rejection", "alert-danger");
                    $("#txtRejectionComment").focus();
                    Isvalid = 1;
                }
            }
            if (Isvalid == 0) {
                var taskParameters = {
                    intTimesheetID: '<%= Request.QueryString("intTimesheetId")%>',
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
                        selectedProjectID = "";
                    },
                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
                })
            }
        }

        function ApproveAllTimesheet() {

              $('#btnApproveTimesheet').css("display","none");
            var strComment = "";
            strComment = $("#txtApprovalComment").val();
            //strComment = $("#txtApprovalComment").val();
            //Added By Dipali V 9th Jan 2019 For Comment as Approved For Approved the timesheet
            if (strComment == "") {

                //strComment = $("#txtApprovalComment").val("Approved");
                strComment = "Approved";
	       $("#txtApprovalComment").val("Approved");
            } else {
                strComment = $("#txtApprovalComment").val();

            }
            //End of Added By Dipali V 9th Jan 2019 For Comment as Approved For Approved the timesheet
            var taskParameters = {
                intTimesheetID:  '<%= Request.QueryString("intTimesheetId")%>',
                Status: 'V',
                intEmployeeID: EmployeeID,
                strComment: strComment,
                intResourceID: '<%= Request.QueryString("intEmployeeID")%>',
                //2021
                FromWhere: ''
                //2021
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
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            })
        }
        function UpdateCompleteTasks() {
            // 
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
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }


        }
        function RejectAllTimesheet() {
            //
           //debugger;
            //Commented By Dipali V On 27th Jan 2020 For avoiding button hide
            //$('#btnRejectTimesheet').css("display","none");
            //End of Commented By Dipali V On 27th Jan 2020 For avoiding button hide
            var strComment = "";
            var Isvalid = 0;
            strComment = $("#txtRejectionComment").val();
            if (strComment == "") {
                showAlert("Enter Reason for rejection", "alert-danger");
                $("#txtRejectionComment").focus();
                Isvalid = 1;
            }
            if (Isvalid == 0) {
                 //Commented By Dipali V On 27th Jan 2020 For avoiding button hide
                $('#btnRejectTimesheet').css("display","none");
                //End of Commented By Dipali V On 27th Jan 2020 For avoiding button hide
                var bitAllowToResubmit = ($("#rejecttaskmodalcheckbox").is(':checked') ? 1 : 0);
                //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
                if (globalAllowToResubmitCheck == true) {
                    bitAllowToResubmit = 1;
                }
                else {
                    if (globalOverrideTSCheck == true) {
                        bitAllowToResubmit = 1;
                    }
                    else {
                        bitAllowToResubmit = 0;
                    }                    
                }
                if (globalBackdatingNoDays == "00") {
                    bitAllowToResubmit = 1;
                }
                //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
                var taskParameters = {
                    intTimesheetID: '<%= Request.QueryString("intTimesheetId")%>',
                    Status: 'J',
                    intEmployeeID: EmployeeID,
                    strComment: strComment,
                    intAllowToResubmit: bitAllowToResubmit,
                    intResourceID: '<%= Request.QueryString("intEmployeeID")%>',
                    //2021
                    FromWhere: ''
                    //2021
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
                        selectedProjectID = "";
                    },
                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }
            //$("#btnRejectTimesheet").prop("disabled", false);
        }

        function Export_PDFClick(ReportFormat) {
            //
            var TimesheetID = '<%= Request.QueryString("TimesheetID")%>';            
            
            if (PageFlag == 3) {
                var parameters = {
                    ReportFormat: ReportFormat,
                    intTimesheetID: '<%= Request.QueryString("intTimesheetId")%>',
                    //Commented And Added By Usha Pandit On 04.08.2020 For passing correct employee details to report
                    //intEmployeeID: EmployeeID,
                    intEmployeeID: '<%= Request.QueryString("intEmployeeID")%>',
                    //End Of Added By Usha Pandit On 04.08.2020 For passing correct employee details to report
                    dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                    dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                }
            }
            if (PageFlag == 2) {
                if (EditMode == 0 && TimesheetID != 0) {
                    var parameters = {
                        ReportFormat: ReportFormat,
                        intTimesheetID: TimesheetID,
                        intEmployeeID: EmployeeID,
                        dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                        dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                    }
                }
                else {
                    var parameters = {
                        ReportFormat: ReportFormat,
                        intEmployeeID: EmployeeID,
                        dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                        dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                    }
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
                    if (data == 0) {
                        showAlert('No Records found', 'alert-danger');

                    }
                    else {
                        window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + data, "_report", "");

                    }

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
        function ValidateSubmitTS() {
            // 
            var Flag = 0;
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
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    console.log(data);
                    // 
                    if (data == "") {
                    }
                    else {
                        showAlert(data, 'alert-danger');
                        Flag = 1;

                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
            return Flag;
        }
        var taskparameters;
        function SubmitTS_OnClick() {
            var IsDAFilledHrs = $("#IdAllTotal").text();
            if (IsDAFilledHrs == "00:00")
            {
                showAlert('Please fill/save timesheet entry.', 'alert-danger');
                return false;
            }
            //alert(IsDAFilledHrs);

            
            //
            if (ValidateSubmitTS() == 1) {
                return false;
            }
            $('#btnSubmit').css('pointer-events', 'none');
            var FilteredEmpID = $("#cboProxyResource option:selected").val();
            var taskparameters;
            if (FilteredEmpID != 0) {
                taskparameters = {

                    intProxyUserID: '<%= Session("intUserID") %>',
                    employeeID: FilteredEmpID,
                    dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                    dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                    intTimesheetID: 0,
                    StatusCode: "R",
                }
            }
            else {
                taskparameters = {
                    intProxyUserID: 0,
                    employeeID: '<%= Session("intUserID") %>',
                    dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                    dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                    intTimesheetID: 0,
                    StatusCode: "R",
                }
            }


            //alert(intTimesheetID);
            $.ajax({
                // url: strUrl + '/api/MyTimesheet/GenerateTimesheet',
                url: strUrl + '/api/MyTimesheet/GenerateTimesheet',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    //
                    var arrData = data.split('$');
                    if (arrData[0] == 1) {
                        window.open('../Email/SendEmail.aspx?MessageID=434&TimesheetID=' + arrData[1] + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    }
                    ReloadTApprovalData(EmployeeID);
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
            $('#btnSubmit').css('pointer-events', 'unset');
        }


        function isNumberSP(evt, val, obj) {
            // 
            var legth = val.length;
            var objVal = obj.value;

            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }

            return true;
        }
        function limitText(limitField, limitNum) {
            //
            //alert(limitField.value.length);

            var length;
            if (limitField.value.length == limitNum) {

                showAlert('You Can Enter Only ' + limitNum + ' Characters', 'alert-danger');
                var desc = $("textarea[id*='Description_']").text();
                $.trim(desc)
            } else {

                limitField.value = limitField.value.substring(0, limitNum);

            }

        }
        //Added By Usha Pandit On 30.07.2019 for DA fill 24 hours per day validation 
        function timeToDecimal(t) {
            var arr = t.split(':');
            var dec = parseInt((arr[1] / 6) * 10, 10);

            return parseFloat(parseInt(arr[0], 10) + '.' + (dec < 10 ? '0' : '') + dec);
        }
        //End Of Added By Usha Pandit On 30.07.2019 for DA fill 24 hours per day validation 

        function ConvertToDecimal(intVal) {
            // 
            //debugger;    
            // var cntof = intVal.split(":").legth;

            var objVal = '' + intVal + '';
           
            //alert(Mon.length);
            if (objVal.length == 1) {
                var fmtMon = '0' + objVal + ':00';
                objVal = fmtMon;
            }
            if (objVal.length == 2) {
                var fmtMon = objVal + ':00';
                objVal = fmtMon;
            }
            if (objVal.length == 3) {
                var fmtMon = objVal.replace('.', ':');
            
              

                fmtMonx = fmtMon.indexOf(':');
                if (fmtMonx == 1) {
                    objVal = '0' + fmtMon + '0';
                }
                if (fmtMonx == -1) {
                    objVal = objVal + ':00';
                }
                if (fmtMonx == 2) {
                    objVal = objVal + '00';
                }
            }
            if (objVal.length == 4) {
                var fmtMon = objVal.replace('.', ':');
                fmtMonx = fmtMon.indexOf(':');
                if (fmtMonx == 2)
                    objVal = '' + fmtMon + '0';
                if (fmtMonx == 1)
                    objVal = '0' + fmtMon + '';
            }
            if (objVal.length >= 5) {

                var fmtMon = objVal.replace('.', ':');
                fmtMonx = fmtMon.indexOf(':');
                //Commented & Added By Dipali V on 16th Nov 2021 For Crash Issue if More Work hours length
                var fmtMon_New = fmtMon.split(":");
                //End of Commented & Added By Dipali V on 16th Nov 2021 For Crash Issue if More Work hours length
                if (fmtMonx == 1)
                    objVal = '0' + fmtMon + '';
                if (fmtMonx == 2)
                    objVal = '' + fmtMon + '';
                if (fmtMonx == 3) {
                    objVal = fmtMon + '0';
                }
                if (fmtMonx == 4 && fmtMon.length > 5) {
                    //Commented & Added By Dipali V on 16th Nov 2021 For Crash Issue if More Work hours length
                    // objVal = fmtMon + '0';
                    if (fmtMon_New[1] != "") {
                        if (fmtMon_New[1].length == 1) {
                            objVal = '0' + fmtMon
                        } else {
                            objVal = fmtMon;

                        }
                    } 
                    //End of Commented & Added By Dipali V on 16th Nov 2021 For Crash Issue if More Work hours length
                }
                else {
                    objVal = fmtMon;
                }
            }
            return objVal;
        }

        //Added By Dipali V On 10th Jan 2019 For Checkbox Clear after Task Type Pop_Up Closed
        $(".modalheadtaskfilter").click(function () {
            //$("#FilterTaskCategories [type=checkbox]").removeAttr("checked");


        });

        function isNumber(evt, val, obj) {
            // 
            var legth = val.length;
            var objVal = obj.value;

            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            if (legth == 2) {
                obj.value = objVal + ":";
                //$("#textboxId").val(val +":");
            }
            return true;
        }

        function ClearallData() {
            //Added By Usha Pandit On 03.03.2021 For filter issue
            if (modalDismiss == true) {
                return;
            }
            //Added By Usha Pandit On 03.03.2021 For filter issue
            $("#txtSearchBoxTaskTypes").val(""); 
			$("#txtSearchBoxProjectNames").val("");
            $("[type=checkbox]").removeAttr("checked");
            //Added by Yasmin S on 18 feb 2019 for clearing the task type
            $("#TaskTypeFilterList").html("");
            
           //added By dipali V On 22nd May 2019 for Clear Flilter
            $("#TaskCategoriesSearch").val("");
            // $("#divTaskCategories").hide("");
            
            //End of added By dipali V On 22nd May 2019 for Clear Flilter
            //Commented By Dipali V On 25th May 2020 After clear close modal pop up caption removing
            //$(".fplist").css("display",'none')
            FilterProjectData();
            //$("#TaskPhaseFilterList,#lblTaskPhaseFilterList,#lblTaskMilestoneFilterList,#TaskMilestoneFilterList,#lblTaskDeliverableFilterList,#TaskDeliverableFilterList,#lblTaskSubProjectFilterList,#TaskSubProjectFilterList,#lblTaskModuleFilterList,#TaskModuleFilterList").html("");
            //End of Commented By Dipali V On 25th May 2020 After clear close modal pop up caption removing
             //Added By Usha Pandit On 03.03.2021 For filter issue
            if (modalDismiss == true) {
                return;
            }
            //Added By Usha Pandit On 03.03.2021 For filter issue
        }


        //$("#Tapprovalall").click(function()
        //{


        //    alert();


        //});
          //End of Added By Dipali V On 10th Jan 2019 For Checkbox Clear after Task Type Pop_Up Closed
    </script>
    <script src="../../../Whizible2.0/dist/js/jquery.freezeheader.js"></script>

    <script type="text/javascript">

</script>

    <script type="text/javascript">
        //$('#tableheadfixer').tableHeadFixer();
    </script>

</body>

</html>
