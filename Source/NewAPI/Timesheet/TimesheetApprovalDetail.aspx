<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TimesheetApprovalDetail.aspx.vb" Inherits="PbNIT.TimesheetApprovalDetail" %>

<!DOCTYPE html>
<html>
<%--     !-- Commented by Param for JQuery and Bootstrap version upgrade -->--%>
        <%CommonFunctions.General.PlotPageHeadTag("My Timesheet")%> 
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Weekly Timesheet</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
    <!-- animate css -->
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css">--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=1">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=1">



</head>
<style type="text/css">
body{ color:#464a4c;}
.timesheettable tr td{ color:#464a4c;}
/*fixed header css*/
table .header-fixed {position: fixed;top: 40px;z-index: 1020;border-bottom: 1px solid #d5d5d5;-webkit-border-radius: 0; -moz-border-radius: 0;border-radius: 0;}
thead {background-color: #eaeaea;}
tbody {background-color: #fcfcfc;}
.collapse.show{ display:table-row;}
.table-hover>tbody>tr:hover>* {
    background: #fff;
    --bs-table-accent-bg: #fff;
}
.pr-0 {
    padding-right: 0;
}
/*fixed header css end*/
.btn-success{ color:#fff;}
.filedownload button::after, .notelisticon::after {display: none;}
.projecttaskinfo_tooltipbox button.close { width:34px; float:right; background: none; border: none; position: absolute; right: 20px; top: 15px;}
.projecttaskinfo_tooltipbox p{ margin-bottom:0; padding:0;}
.projecttaskinfo_tooltipbox{ font-weight:500;}
.PTItooltipbox_hading{ font-size:14px;}
.subtasktitle .dropdown-menu.timeinfopopup{margin-left: 30px!important; margin-top: -45px!important;}

</style>
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div class="responsivewarningmsg">
        <h2>Please check on 1280px and high Resolution</h2>
    </div>

    <!-- Main content -->
    <section class="content">

        <!--Start html code for Desktop view only-->
        <div class="weeklytimesheetwrap hidden-xs viewtimesheetwrap_desk">
            <div class="timesheetrow graybg container-fluid pt-1 pb-1 headertopp">
                <div class="row">
                    <div class="col-md-3 col-sm-6 col-xs-6">
                        <label class="resourcelabel pt-1">John Deo</label>
                    </div>
                    <div class="col-md-5 col-sm-6 col-xs-6">

                        <div class="weekly_calender">

                            <button title="Previous Week" id="prev"><i class="fas fa-caret-left"></i></button>
                            <div class="input-group-box">
                                <div class="input-group" id="DateDemo">
                                    <input title="Select Week date" class="form-control" type="text" id="weekPicker2" value="" />

                                </div>

                            </div>
                            <button id="next" title="Next Week"><i class="fas fa-caret-right"></i></button>
                        </div>

                    </div>
                    <div class="col-md-4 col-sm-12 col-xs-12 pt-1">

                        <strong>Status:</strong> <span class="Status">Not Submitted</span>

                        <div class="float-end">
                            <div class="dropdown filedownload">
                                <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" data-title="Click here to download" class="fas fa-download"></i></button>
                                <ul class="dropdown-menu">
                                    <li><a href="#" onclick="Export_PDFClick('PDF')">
                                        <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                    <li><a href="#" onclick="Export_PDFClick('EXCEL')">
                                        <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                                    <li><a href="#" onclick="Export_PDFClick('XML')">
                                        <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                                    <li><a href="#" onclick="Export_PDFClick('TEXT')">
                                        <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Doc</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div class="timesheetrow bgwhite ts_headerbot container-fluid">

                <div class="row">                    
                    <div class="col-md-6 col-sm-6 col-xs-7">
                        <div class="input-group_btnbox workbtndiv pt-1 pb-1">

                            <div class="btn-group">
                                <button type="button" class="btn btn-default ">
                                    <span class="ActualHours">70</span>
                                </button>
                                <button type="button" class="btn btn-default workbtn">Actual Hours</button>
                            </div>
                            &nbsp;&nbsp;
                <div class="btn-group">
                    <button type="button" class="btn btn-default">
                        <span class="ExpectedHours">70</span>
                    </button>
                    <button type="button" class="btn btn-default workbtn">Expected Hours</button>
                </div>

                 </div>

                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-5 float-end">
                        <ul class="float-end btnlistinline mt-2">
                            <li>
                                <a href="TimesheetApproval.aspx" onclick="goBack()" id="" class="btn backbtn btnyellow ml-1 nobtnstyle-xs hidebtn" style="display: inline;">Back</a>
                            </li>
                            <li>
                                <button id="modalapendbtn" class="btn borderbtn ml-1 nobtnstyle-xs" data-bs-toggle="modal" data-bs-target="#rejectmodal">Reject</button>
                            </li>
                            <li>
                                <button data-bs-toggle="modal" data-bs-target="#approvetaskmodal" class="btn savebtn btnyellow ml-1 nobtnstyle-xs">Approve</button>
                            </li>
                        </ul>
                    </div>
                    <div class="clearfix"></div>
                </div>

            </div>

            <div class="table-outer bgwhite">
                <div class="timesheettable">
                    <div id="content-1" class="tbl-content">
                        <table class="table table-hover table-bordered approvaldetailtble table-fixed-header">
                            <thead class="header" id="timesheetHeader">
                                <tr>
                                    <th>Projects / Tasks / Sub-Tak
                                    </th>
                                    <th>June 18,<span>Mon</span></th>
                                    <th>June 19,<span>Tue</span></th>
                                    <th>June 20,<span>Wed</span></th>
                                    <th>June 21,<span>Thu</span></th>
                                    <th>June 22,<span>Fri</span></th>
                                    <th class="exapnd_and_collaps_column weekdayscol">June 23,<span>Sat</span><i title="" class="click-me fas fa-caret-left"></i></th>
                                    <th class="toggleDisplay">June 24,<span>Sun</span></th>
                                    <th class="exapnd_and_collaps_column">Weekly<span>total</span><i title="" class="click-me fas fa-caret-right"></i></th>
                                    <th>% Work Complete</th>
                                    <th>Task Complete</th>
                                    <th>Action</th>
                                </tr>

                                <tr class="table_row_divider">
                                    <td colspan="11">&nbsp;</td>
                                    <td class="toggleDisplay">&nbsp;</td>
                                </tr>
                                <tr class="task totalworkcountrow">
                                    <td class="totalworkcountrow">Total work for a week</td>
                                    <td>
                                        <label class="pro_Calculate_count">07:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">07:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">07:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">07:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">07:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">07:00</label>
                                    </td>
                                    <td class="toggleDisplay">
                                        <label class="pro_Calculate_count">07:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">49:00</label>
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>

                                </tr>
                            </thead>


                            <tbody id="TimesheetDetailTbody">
                                <tr class="table_row_divider">
                                    <td colspan="11">&nbsp;</td>
                                    <td class="toggleDisplay">&nbsp;</td>
                                </tr>

                                <tr class="task">
                                    <td>
                                        <div class="tbl-projecttitle">
                                            Project: Whisible 1.0
                                                        <div class="dropdown projecttitle_actions">
                                                            <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">
                                                                <div class="arrow-left"></div>
                                                                <div class="projecttaskinfo_tooltipbox">
                                                                    <button type="button" class="close" data-bs-dismiss="modal">
                                                                        <img width="20px" src="../../../Whizible2.0-new/dist/img/close-gray.svg"></button>
                                                                    <div class="PTItooltipbox_hading">
                                                                        Project Name
                                                                        <br />
                                                                        Task / Sub-task
                                                                    </div>
                                                                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
                                                                    <div class="projecttaskinfo_tooltipbox_schedule">
                                                                        <div class="row">
                                                                            <div class="col-xs-5">Start Date:</div>
                                                                            <div class="col-xs-7">May 29, 2018</div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-xs-5">Start Date:</div>
                                                                            <div class="col-xs-7">May 29, 2018</div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-xs-5">End Date:</div>
                                                                            <div class="col-xs-7">Aug 10, 2018</div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-xs-5">Alloted Work:</div>
                                                                            <div class="col-xs-7">54 Hrs</div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-xs-5">Actual Work:</div>
                                                                            <div class="col-xs-7">30 Hrs</div>
                                                                        </div>
                                                                    </div>
                                                                    <hr />
                                                                    <div class="projecttaskinfo_tooltipbox_schedule">
                                                                        <div class="row">
                                                                            <div class="col-xs-5">Phase:</div>
                                                                            <div class="col-xs-7">Stage 1</div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-xs-5">Milestone:</div>
                                                                            <div class="col-xs-7">Milestone 1</div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-xs-5">Sub Project:</div>
                                                                            <div class="col-xs-7">Lorem Ipsum dolor sit amet</div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-xs-5">Issue:</div>
                                                                            <div class="col-xs-7">Lorem Ipsum dolor sit amet</div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <a href="javascript:;" class="nostyle hidden-xs" data-bs-toggle="collapse" data-bs-target=".projecthide1">
                                                                <img data-bs-toggle="tooltip" data-placement="top" title="Hide Task" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="mCS_img_loaded" width="15px"></a>

                                                        </div>
                                        </div>

                                    </td>

                                    <td>
                                        <label class="pro_Calculate_count">01:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">02:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">02:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">02:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">02:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">02:00</label>
                                    </td>
                                    <td class="toggleDisplay">
                                        <label class="pro_Calculate_count">02:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">02:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">&nbsp;</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">&nbsp;</label>
                                    </td>
                                    <td class="text-center crossandcheckactions">
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="task projecthide1 collapse in" aria-expanded="true">
                                    <td>

                                        <div class="subtasklist hidden-xs">

                                            <div class="dropdown subtasktitle">
                                                Task 1 : Define roles & respon...
                                                            <div class="float-end" data-bs-toggle="tooltip" data-placement="top" title="Project Info">
                                                                <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">
                                                                    <div class="arrow-left"></div>
                                                                    <div class="projecttaskinfo_tooltipbox">
                                                                        <button type="button" class="close" data-bs-dismiss="modal">
                                                                            <img width="20px" src="../../../Whizible2.0-new/dist/img/close-gray.svg"></button>
                                                                        <div class="PTItooltipbox_hading">
                                                                            Project Name
                                                                        <br />
                                                                            Task / Sub-task
                                                                        </div>
                                                                        <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
                                                                        <div class="projecttaskinfo_tooltipbox_schedule">
                                                                            <div class="row">
                                                                                <div class="col-xs-5">Start Date:</div>
                                                                                <div class="col-xs-7">May 29, 2018</div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-xs-5">Start Date:</div>
                                                                                <div class="col-xs-7">May 29, 2018</div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-xs-5">End Date:</div>
                                                                                <div class="col-xs-7">Aug 10, 2018</div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-xs-5">Alloted Work:</div>
                                                                                <div class="col-xs-7">54 Hrs</div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-xs-5">Actual Work:</div>
                                                                                <div class="col-xs-7">30 Hrs</div>
                                                                            </div>

                                                                        </div>

                                                                        <hr />
                                                                        <div class="projecttaskinfo_tooltipbox_schedule">
                                                                            <div class="row">
                                                                                <div class="col-xs-5">Phase:</div>
                                                                                <div class="col-xs-7">Stage 1</div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-xs-5">Milestone:</div>
                                                                                <div class="col-xs-7">Milestone 1</div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-xs-5">Sub Project:</div>
                                                                                <div class="col-xs-7">Lorem Ipsum dolor sit amet</div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-xs-5">Issue:</div>
                                                                                <div class="col-xs-7">Lorem Ipsum dolor sit amet</div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <img class="dropdown-toggle float-end" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="" data-bs-toggle="dropdown" aria-expanded="true">
                                                            </div>


                                            </div>

                                            <div class="progress progress-xs">
                                                <div class="progress-bar" style="width: 70%"></div>
                                            </div>
                                        </div>

                                        <div class="clearfix"></div>

                                    </td>


                                    <td class="pr">
                                        <div class="dropdown">
                                            <span class="notelisticon dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="far fa-list-alt"></i></span>
                                            <input id="ProOne-TOne-WdOne" class="timenoinput dropdown-toggle" type="text" value="" placeholder="01:00" name="" id="menu1" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">

                                            <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">
                                                <textarea class="form-control">Please enter description here...</textarea>
                                                <button class="btn borderbtn mt-onehalf">Save</button>

                                            </div>

                                        </div>
                                        <span class="timeno">
                                            <span class="selecttimeno">
                                                <input
                                                    data-bs-toggle="tooltip" data-placement="bottom" title="Story Point" type="text" value="" placeholder="00" name=""></span></span>


                                    </td>
                                    <td><span class="timeno">
                                        <input id="ProOne-TOne-WdTwo" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProOne-TOne-WdThree" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProOne-TOne-WdFour" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProOne-TOne-WdFive" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProOne-TOne-WdSix" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td class="toggleDisplay"><span class="timeno">
                                        <input id="ProOne-TOne-WdSeven" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProOne-TOne-WTotle" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="workcomplted">
                                        <input id="ProOne-TOne-Wcomplete" type="text" value="" placeholder="30%" name=""></span></td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="task1">
                                            <label for="task1"></label>
                                        </div>
                                    </td>
                                    <td class="text-center crossandcheckactions">
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>



                                <tr class="table_row_divider">
                                    <td colspan="11">&nbsp;</td>
                                    <td class="toggleDisplay">&nbsp;</td>
                                </tr>

                                <tr class="task">
                                    <td>
                                        <div class="tbl-projecttitle">
                                            Project: Whisible 2.0
                                                        <div class="projecttitle_actions">
                                                            <a href="javascript:;" class="nostyle hidden-xs" data-bs-toggle="collapse" data-bs-target=".projecthide2">
                                                                <img data-bs-toggle="tooltip" data-placement="top" title="Hide Task" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="mCS_img_loaded" width="15px"></a>
                                                        </div>
                                        </div>

                                    </td>

                                    <td>
                                        <label class="pro_Calculate_count">02:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td class="toggleDisplay">
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">&nbsp;</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">&nbsp;</label>
                                    </td>
                                    <td class="text-center crossandcheckactions">
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--project task start here-->
                                <tr class="task projecthide2 collapse in">
                                    <td>

                                        <div class="subtasklist hidden-xs">
                                            Task 2 : Define roles & respon...
                                                        <div class="float-end" data-bs-toggle="tooltip" data-placement="top" title="Project Info">
                                                            <img class="hidden-xs  float-end" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                            </div>
                                            <div class="progress progress-xs">
                                                <div class="progress-bar" style="width: 70%"></div>
                                            </div>



                                        </div>

                                        <div class="clearfix"></div>
                                    </td>

                                    <td><span class="timeno">
                                        <input id="ProTwo-TOne-WdOne" class="timenoinput" type="text" value="" placeholder="01:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProTwo-TOne-WdTwo" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProTwo-TOne-WdThree" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProTwo-TOne-WdFour" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProTwo-TOne-WdFive" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProTwo-TOne-WdSix" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td class="toggleDisplay"><span class="timeno">
                                        <input id="ProTwo-TOne-WdSSeven" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProTwo-TOne-WTotle" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="workcomplted">
                                        <input id="ProTwo-TOne-Wcomplete" class="timenoinput" type="text" value="" placeholder="30%" name=""></span></td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="task6">
                                            <label for="task6"></label>
                                        </div>
                                    </td>
                                    <td class="text-center crossandcheckactions">
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-bs-toggle="tooltip" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--project task end here-->
                                <!--project task start here-->
                                <tr class="task projecthide2 collapse in hidden-xs">
                                    <td>
                                        <div class="subtasklist subtasklistsmall hidden-xs">
                                            Sub-Task 1 : Define roles & respon...
                                                        <div class="float-end" data-bs-toggle="tooltip" data-placement="top" title="Project Info">
                                                            <img class="hidden-xs  float-end" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                            </div>
                                            <div class="progress progress-xs">
                                                <div class="progress-bar" style="width: 70%"></div>
                                            </div>

                                        </div>
                                    </td>

                                    <td><span class="timeno">
                                        <input id="ProTwo-TTwo-WdOne" class="timenoinput" type="text" value="" placeholder="01:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProTwo-TTwo-WdTwo" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProTwo-TTwo-WdThree" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProTwo-TTwo-WdFour" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProTwo-TTwo-WdFive" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProTwo-TTwo-WdSix" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td class="toggleDisplay"><span class="timeno">
                                        <input id="ProTwo-TTwo-WdSeven" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProTwo-TTwo-WTotle" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="workcomplted">
                                        <input id="ProTwo-TTwo-Wcomplete" type="text" value="" placeholder="30%" name=""></span></td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="task7">
                                            <label for="task7"></label>
                                        </div>
                                    </td>
                                    <td class="text-center crossandcheckactions">
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--project task end here-->

                                <tr class="table_row_divider">
                                    <td colspan="11">&nbsp;</td>
                                    <td class="toggleDisplay">&nbsp;</td>
                                </tr>
                                <!--project task start here-->
                                <tr class="task">
                                    <td>
                                        <div class="tbl-projecttitle">
                                            Project: Whisible 3.0
                                                        <div class="projecttitle_actions">

                                                            <a href="javascript:;" class="nostyle hidden-xs" data-bs-toggle="collapse" data-bs-target=".projecthide3">
                                                                <img data-bs-toggle="tooltip" data-placement="top" title="Hide Task" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="mCS_img_loaded" width="15px"></a>
                                                        </div>
                                        </div>
                                    </td>

                                    <td>
                                        <label class="pro_Calculate_count">02:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td class="toggleDisplay">
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">&nbsp;</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">&nbsp;</label>
                                    </td>
                                    <td class="text-center crossandcheckactions">
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--project task end here-->
                                <!--project task start here-->
                                <tr class="task projecthide3 collapse in">
                                    <td>

                                        <div class="subtasklist hidden-xs">
                                            Task 1 : Define roles & respon...
                                                        <div class="float-end" data-bs-toggle="tooltip" data-placement="top" title="Project Info">
                                                            <img class="hidden-xs  float-end" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                            </div>
                                            <div class="progress progress-xs">
                                                <div class="progress-bar" style="width: 70%"></div>
                                            </div>


                                        </div>
                                    </td>

                                    <td><span class="timeno">
                                        <input id="ProThree-TOne-WdOne" class="timenoinput" type="text" value="" placeholder="01:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProThree-TOne-WdTwo" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProThree-TOne-WdThree" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProThree-TOne-WdFour" class="timenoinput" id="" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProThree-TOne-WdFive" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProThree-TOne-WdSix" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td class="toggleDisplay"><span class="timeno">
                                        <input id="ProThree-TOne-WdSeven" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProThree-TOne-WTotle" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="workcomplted">
                                        <input id="ProThree-TOne-Wcomplete" type="text" value="" placeholder="30%" name=""></span></td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="task2">
                                            <label for="task2"></label>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--project task end here-->
                                <!--project task start here-->
                                <tr class="task projecthide3 collapse in hidden-xs">
                                    <td>

                                        <div class="subtasklist subtasklistsmall hidden-xs">
                                            Sub-Task 1 : Define roles & respon...
                                            <img class="hidden-xs  float-end" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                            <div class="progress progress-xs">
                                                <div class="progress-bar" style="width: 70%"></div>
                                            </div>


                                        </div>
                                    </td>

                                    <td><span class="timeno">
                                        <input id="ProThree-TTwo-WdOne" class="timenoinput" type="text" value="" placeholder="01:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProThree-TTwo-WdTwo" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProThree-TTwo-WdThree" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProThree-TTwo-WdFour" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProThree-TTwo-WdFive" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProThree-TTwo-WdSix" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td class="toggleDisplay"><span class="timeno">
                                        <input id="ProThree-TTwo-WdSeven" type="text" placeholder="00:00" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProThree-TTwo-WTotle" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="workcomplted">
                                        <input id="ProThree-TTwo-Wcomplete" class="timenoinput" type="text" value="" placeholder="30%" name=""></span></td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="task3">
                                            <label for="task3"></label>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--project task end here-->


                                <tr class="table_row_divider">
                                    <td colspan="11">&nbsp;</td>
                                    <td class="toggleDisplay">&nbsp;</td>
                                </tr>

                                <!--project task start here-->
                                <tr class="task">
                                    <td>
                                        <div class="tbl-projecttitle">
                                            Project: Whisible 4.0
                                                        <div class="projecttitle_actions">

                                                            <a href="javascript:;" class="nostyle hidden-xs" data-bs-toggle="collapse" data-bs-target=".projecthide4">
                                                                <img data-bs-toggle="tooltip" data-placement="top" title="Hide Task" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="mCS_img_loaded" width="15px"></a>
                                                        </div>
                                        </div>

                                    </td>

                                    <td>
                                        <label class="pro_Calculate_count">02:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td class="toggleDisplay">
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">&nbsp;</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">&nbsp;</label>
                                    </td>
                                    <td>
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--project task end here-->
                                <!--project task start here-->
                                <tr class="task projecthide4 collapse in">
                                    <td>

                                        <div class="subtasklist hidden-xs">
                                            Task 1 : Define roles & respon...
                                                        <div class="float-end" data-bs-toggle="tooltip" data-placement="top" title="Project Info">
                                                            <img class="hidden-xs float-end" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                            </div>
                                            <div class="progress progress-xs">
                                                <div class="progress-bar" style="width: 70%"></div>
                                            </div>


                                        </div>
                                    </td>

                                    <td><span class="timeno">
                                        <input id="ProFour-Tone-WdOne" class="timenoinput" type="text" value="" placeholder="01:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProFour-Tone-WdTwo" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProFour-Tone-WdThree" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-Tone-WdFour" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-Tone-WdFive" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-Tone-WdSix" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td class="toggleDisplay"><span class="timeno">
                                        <input id="ProFour-Tone-WdSeven" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-Tone-WTotle" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="workcomplted">
                                        <input id="ProFour-Tone-Wcomplete" class="timenoinput" type="text" value="" placeholder="30%" name=""></span></td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="task4">
                                            <label for="task4"></label>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--project task end here-->
                                <!--project task start here-->
                                <tr class="task projecthide4 collapse in hidden-xs">
                                    <td>
                                        <div class="subtasklist subtasklistsmall hidden-xs">
                                            Sub-Task 1 : Define roles & respon...
                                                        <div class="float-end" data-bs-toggle="tooltip" data-placement="top" title="Project Info">
                                                            <img class="hidden-xs float-end" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                            </div>
                                            <div class="progress progress-xs">
                                                <div class="progress-bar" style="width: 70%"></div>
                                            </div>


                                        </div>
                                    </td>

                                    <td><span class="timeno">
                                        <input id="ProFour-TTwo-WdOne" class="timenoinput" type="text" value="" placeholder="01:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProFour-TTwo-WdTwo" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProFour-TTwo-WdThree" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-TTwo-WdFour" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-TTwo-WdFive" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-TTwo-WdSix" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td class="toggleDisplay"><span class="timeno">
                                        <input id="ProFour-TTwo-WdSeven" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-TTwo-WTotle" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="workcomplted">
                                        <input id="ProFour-TTwo-Wcomplete" class="timenoinput" type="text" value="" placeholder="30%" name=""></span></td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="task5">
                                            <label for="task5"></label>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--project task end here-->




                                <tr class="table_row_divider">
                                    <td colspan="11">&nbsp;</td>
                                    <td class="toggleDisplay">&nbsp;</td>
                                </tr>

                                <!--project task start here-->
                                <tr class="task">
                                    <td>
                                        <div class="tbl-projecttitle">
                                            Project: Whisible 4.0
                                                        <div class="projecttitle_actions">

                                                            <a href="javascript:;" class="nostyle hidden-xs" data-bs-toggle="collapse" data-bs-target=".projecthide4">
                                                                <img data-bs-toggle="tooltip" data-placement="top" title="Hide Task" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="mCS_img_loaded" width="15px"></a>
                                                        </div>
                                        </div>

                                    </td>

                                    <td>
                                        <label class="pro_Calculate_count">02:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td class="toggleDisplay">
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">04:00</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">&nbsp;</label>
                                    </td>
                                    <td>
                                        <label class="pro_Calculate_count">&nbsp;</label>
                                    </td>
                                    <td>
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--project task end here-->
                                <!--project task start here-->
                                <tr class="task projecthide4 collapse in">
                                    <td>

                                        <div class="subtasklist hidden-xs">
                                            Task 1 : Define roles & respon...
                                                        <div class="float-end" data-bs-toggle="tooltip" data-placement="top" title="Project Info">
                                                            <img class="hidden-xs float-end" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                            </div>
                                            <div class="progress progress-xs">
                                                <div class="progress-bar" style="width: 70%"></div>
                                            </div>


                                        </div>
                                    </td>

                                    <td><span class="timeno">
                                        <input id="ProFour-Tone-WdOne" class="timenoinput" type="text" value="" placeholder="01:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProFour-Tone-WdTwo" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProFour-Tone-WdThree" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-Tone-WdFour" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-Tone-WdFive" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-Tone-WdSix" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td class="toggleDisplay"><span class="timeno">
                                        <input id="ProFour-Tone-WdSeven" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-Tone-WTotle" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="workcomplted">
                                        <input id="ProFour-Tone-Wcomplete" class="timenoinput" type="text" value="" placeholder="30%" name=""></span></td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="task4">
                                            <label for="task4"></label>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--project task end here-->
                                <!--project task start here-->
                                <tr class="task projecthide4 collapse in hidden-xs">
                                    <td>
                                        <div class="subtasklist subtasklistsmall hidden-xs">
                                            Sub-Task 1 : Define roles & respon...
                                                        <div class="float-end" data-bs-toggle="tooltip" data-placement="top" title="Project Info">
                                                            <img class="hidden-xs float-end" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                            </div>
                                            <div class="progress progress-xs">
                                                <div class="progress-bar" style="width: 70%"></div>
                                            </div>


                                        </div>
                                    </td>

                                    <td><span class="timeno">
                                        <input id="ProFour-TTwo-WdOne" class="timenoinput" type="text" value="" placeholder="01:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProFour-TTwo-WdTwo" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno">
                                        <input id="ProFour-TTwo-WdThree" class="timenoinput" type="text" value="" placeholder="02:00" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-TTwo-WdFour" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-TTwo-WdFive" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-TTwo-WdSix" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td class="toggleDisplay"><span class="timeno">
                                        <input id="ProFour-TTwo-WdSeven" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="timeno timenodisabled">
                                        <input id="ProFour-TTwo-WTotle" class="timenoinput" type="text" placeholder="02:00" value="" name=""></span></td>
                                    <td><span class="workcomplted">
                                        <input id="ProFour-TTwo-Wcomplete" class="timenoinput" type="text" value="" placeholder="30%" name=""></span></td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="task5">
                                            <label for="task5"></label>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--project task end here-->
                            </tbody>
                        </table>
                        <!--project end here-->

                    </div>
                    <div class="clearfix"></div>
                </div>

            </div>

            <!--all modal start here-->

            <!--rejectmodal-->
            <div id="rejectmodal" class="modal fade custmodal rejectmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Reject Timesheet - Employee Name 1</h4>
                            <center><small>28-05-2018 &nbsp;To &nbsp; 03-06-2018</small></center>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="row mb-3">
                                    <div class="col-xs-12 col-sm-4 pr-0 text-end">Reason for rejection:</div>
                                    <div class="col-xs-12 col-sm-8">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-12">
                                                <textarea class="form-control">
                                                                      
                                                                    </textarea>
                                            </div>
                                            <div class="col-xs-2 col-sm-4"></div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4 text-end">&nbsp;</div>
                                    <div class="col-xs-12 col-sm-8">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-12">

                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="rejectmodalcheckbox">
                                                    <label for="rejectmodalcheckbox">Allow resource to change timesheet and resubmit</label>
                                                </div>

                                            </div>
                                            <div class="col-xs-2 col-sm-4"></div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-start">
                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 float-end">Reject</button>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--modalEnd-->

            <!--rejectmodal-->
            <div id="rejecttaskmodal" class="modal fade custmodal rejecttaskmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Reject Task - Employee Name 1</h4>
                            <center><small>28-05-2018 &nbsp;To &nbsp; 03-06-2018</small></center>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="row mb-3">
                                    <div class="col-xs-12 col-sm-4 pr-0 text-end">Reason for rejection:</div>
                                    <div class="col-xs-12 col-sm-8">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-12">
                                                <textarea class="form-control">
                                                                      
                                                                    </textarea>
                                            </div>
                                            <div class="col-xs-2 col-sm-4"></div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4 text-end">&nbsp;</div>
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
                                    <div class="col-xs-6 col-sm-6 text-start">
                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 float-end">Reject</button>
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
            <div id="approvetaskmodal" class="modal fade custmodal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Approve Timesheet</h4>
                        </div>

                        <div class="modal-body">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4 text-end">Comment:</div>
                                    <div class="col-xs-12 col-sm-8">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-12">
                                                <textarea class="form-control">
                                                                      
                                                                    </textarea>
                                            </div>
                                            <div class="col-xs-2 col-sm-4"></div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-start">
                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 float-end">Approve</button>
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
                            <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Approve Task</h4>
                        </div>

                        <div class="modal-body">

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4 text-end">Task Name:</div>
                                    <div class="col-xs-12 col-sm-8">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-12">
                                                Lorem Ipsum dummy task
                                            </div>
                                            <div class="col-xs-2 col-sm-4"></div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4 text-end">Comment:</div>
                                    <div class="col-xs-12 col-sm-8">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-12">
                                                <textarea class="form-control"></textarea>
                                            </div>
                                            <div class="col-xs-2 col-sm-4"></div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-start">
                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 float-end">Approve</button>
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
    <!-- /.content -->


    <!-- Add the sidebar's background. This div must be placed
            immediately after the control sidebar -->
    <div class="control-sidebar-bg"></div>



    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->

  <%--  <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>   
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
 <%--   <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <!--daterangepicker-->
<%--    <script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script>   
    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>--%>
     <script src="../../General/CommonValidations.js"></script>
<%--       <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <!--weekpicker-->
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/weekPicker.js?v=1.8"></script>

    <script>
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
                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
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
    
    <script type="text/javascript">
       
        function Export_PDFClick(ReportFormat) {
            var parameters = {
                ReportFormat: ReportFormat,
            }
           
           // debugger;
             $.ajax({
                url: strUrl + '/api/TimesheetApprovalDetail/ExportDocument',
                type: "POST",
                data: JSON.stringify(parameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(parameters) ? parameters : JSON.stringify(parameters)));
                    }
                },
                success: function (data) {
                    console.log(data);
                    alert("Success");
                   window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + data, "_report", "");
                },
                error: function (err) {
                    console.log(err);
                    alert("Error");
                }
            })
        }



        function ajaxCall(url, type, contentType, dataType, data) {
        var ajaxResult;
        $.ajax({
            url: url,
            type: type,
            contentType: contentType,
            dataType: dataType,
            data: data,
            async: false,
            success: function (result) {
                ajaxResult = result;
            },
            error: function (xhr) {
                console.log(xhr);
            }
        })

        return ajaxResult;
    }

        var taskParameters;
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

        var EmployeeID;

        EmployeeID = <%= Session("intUserID") %>;
       
        jQuery(document).ready(function () {
              <%--var intTimesheetId =<%= Request.QueryString("intTimesheetId")%>--%>
            //alert(intTimesheetId);
            ReloadData(EmployeeID);

            alert();


        })




        function ReloadData(ProxyResourceID) {
            //alert(EmployeeID);
            if (ProxyResourceID == 0)
                ProxyResourceID = EmployeeID;
            taskParameters = {
                intEmployeeID: ProxyResourceID,
                dtFromDate: "",
                dtToDate: "",
                intTimesheetID: 0,
            }
              $.ajax({
                url: strUrl + '/api/TimesheetApprovalDetail/GetTimesheetApprovalData',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                    }
                },
                success: function (data) {
                    console.log(data);
                    //alert("Success");
                    var TimesheetApprovalDetail = data;
                    PlotHeaderSection(TimesheetApprovalDetail.GetActualExpectedHours);
                    PlotTableHeaderSection(TimesheetApprovalDetail.headerColumns);
                    plotWeekTotal(TimesheetApprovalDetail.WeekTotalLists);
                     plotTaskList(TimesheetApprovalDetail.timesheetLists);
                },
                error: function (err) {
                    console.log(err);
                    alert("Error");
                }
            })

        }


        

        function AjaxCall(taskParameters) {

          

        }
        function PlotHeaderSection(GetActualExpectedHours) {
            var ActualHours = GetActualExpectedHours.ActualHours;
            var ExpectedHours = GetActualExpectedHours.ExpectedHours;
            var Status = GetActualExpectedHours.Status;
            var EmployeeName = GetActualExpectedHours.EmployeeName;
            $(".ActualHours").html(ActualHours);
            $(".ExpectedHours").html(ExpectedHours);
            $(".Status").html(Status);
            $(".resourcelabel").html(EmployeeName);

        }
        function PlotTableHeaderSection(headerList) {
            //debugger;
            $("#timesheetHeader").html("");
            var htmlString = "";
            htmlString += '<tr>' +
                '<th>Projects / Tasks / Sub-Tak' +
                '<button class="btn borderbtn ml-1 mt-onehalf" data-bs-toggle="modal" data-bs-target="#selectprojecttask"><span class="" data-bs-toggle="tooltip" data-placement="bottom" title="Select More Projects" onclick="PlotFilterTaskList()">More Projects +</span></button>' +
                '</span>' +
                '</th>';
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
                else {
                    htmlString += "<th>";
                }
                htmlString += '' + EntryDate + ',<span>' + DayName + '</span>'
                if (IsWorking == 2) {
                    htmlString += '<i title="" class="click-me fas fa-caret-left"></i>'
                }
                htmlString += "</th>";
            }
            htmlString += '<th class="exapnd_and_collaps_column">Weekly<span>total</span><i title="" class="click-me fas fa-caret-right"></i></th>' +
                '<th>% Work Complete</th>' +
                '<th>Task Complete</th>' +
                '<th>Action</th>' +
                '</tr>';
            htmlString += '<tr class="table_row_divider">' +
                '<td colspan="11">&nbsp;</td>' +
                '<td class="toggleDisplay">&nbsp;</td>' +
                '</tr>';
            htmlString += '<tr class="task totalworkcountrow" id="WeekTotal">';
            htmlString += '</tr>';

            $("#timesheetHeader").html(htmlString);
            $(".click-me").click(function () {
                $(".table .toggleDisplay").toggleClass("in");
                $(".exapnd_and_collaps_column").toggleClass("extraweekdaycolshow");
            });
            $('.table-fixed-header').fixedHeader();
        }
        function plotWeekTotal(WeekTotalLists) {

            $("#WeekTotal").html('');
            var strHTML = "";
            strHTML += "<td class='totalworkcountrow'>Total work for a week</td>";
            //strHTML += "<td><label class='pro_Calculate_count'>&nbsp;</label></td>";
            var AllTotal;
            for (var i = 0; i <= WeekTotalLists.length - 1; i++) {
                var WeekTotalObject = WeekTotalLists[i];
                var Total = WeekTotalObject.Total;
                var EntryDate = WeekTotalObject.EntryDate;
                AllTotal = WeekTotalObject.AllTotal;
                var WeekDays = WeekTotalObject.WeekDays;
                //alert(Total);
                if (i >= WeekDays) {
                    strHTML += "<td class='toggleDisplay weekcolumnred'><label class='pro_Calculate_count'>" + Total + "</label></td>";
                }
                else {
                    strHTML += "<td><label class='pro_Calculate_count'>" + Total + "</label></td>";
                }
            }
            strHTML += "<td><label class='pro_Calculate_count'>" + AllTotal + "</label></td>";
            strHTML += "<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>";

            $("#WeekTotal").html(strHTML);
        }
        function plotTaskList(taskList) {
            var taskHTML = "";
            var taskCounter = 0;
            var subTaskCounter = 0;
            // $("#TimesheetDetailTbody").html(taskHTML);
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
                //alert(TaskID);
                //if (IsProject == 1) {}
                taskHTML += ' <tr class="table_row_divider">' +
                    '<td colspan="11">&nbsp;</td>' +
                    '<td class="toggleDisplay">&nbsp;</td>' +
                    '</tr>';
                taskHTML += ' <tr class="task">' +
                    '<td>' +
                    ' <div class="tbl-projecttitle">' +
                    ' Project: '+ ProjectName +'' +
                    '               <div class="dropdown projecttitle_actions">' +
                    '                <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">' +
                    '                   <div class="arrow-left"></div>' +
                    '                    <div class="projecttaskinfo_tooltipbox">' +
                    '                       <button type="button" class="close" data-bs-dismiss="modal">' +
                    '                          <img width="20px" src="../../../Whizible2.0-new/dist/img/close-gray.svg"></button>' +
                    '                     <div class="PTItooltipbox_hading">' +
                    '                        Project Name' +
                    '                       <br />' +
                    '                      Task / Sub-task' +
                    '                 </div>' +
                    '                <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>' +
                    '               <div class="projecttaskinfo_tooltipbox_schedule">' +
                    '                  <div class="row">' +
                    '                     <div class="col-xs-5">Start Date:</div>' +
                    '                    <div class="col-xs-7">May 29, 2018</div>' +
                    '               </div>' +
                    '              <div class="row">' +
                    '                  <div class="col-xs-5">Start Date:</div>' +
                    '                 <div class="col-xs-7">May 29, 2018</div>' +
                    '             </div>' +
                    '            <div class="row">' +
                    '                <div class="col-xs-5">End Date:</div>' +
                    '                <div class="col-xs-7">Aug 10, 2018</div>' +
                    '            </div>' +
                    '            <div class="row">' +
                    '                <div class="col-xs-5">Alloted Work:</div>' +
                    '               <div class="col-xs-7">54 Hrs</div>' +
                    '          </div>' +
                    '          <div class="row">' +
                    '              <div class="col-xs-5">Actual Work:</div>' +
                    '              <div class="col-xs-7">30 Hrs</div>' +
                    '          </div>' +
                    '      </div>' +
                    '      <hr />' +
                    '      <div class="projecttaskinfo_tooltipbox_schedule">' +
                    '          <div class="row">' +
                    '              <div class="col-xs-5">Phase:</div>' +
                    '              <div class="col-xs-7">Stage 1</div>' +
                    '          </div>' +
                    '         <div class="row">' +
                    '            <div class="col-xs-5">Milestone:</div>' +
                    '           <div class="col-xs-7">Milestone 1</div>' +
                    '      </div>' +
                    '     <div class="row">' +
                    '        <div class="col-xs-5">Sub Project:</div>' +
                    '       <div class="col-xs-7">Lorem Ipsum dolor sit amet</div>' +
                    '  </div>' +
                    ' <div class="row">' +
                    '     <div class="col-xs-5">Issue:</div>' +
                    '    <div class="col-xs-7">Lorem Ipsum dolor sit amet</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +


                    '<a href="javascript:;" class="nostyle hidden-xs" data-bs-toggle="collapse" data-bs-target=".projecthide1">' +
                    '    <img data-bs-toggle="tooltip" data-placement="top" title="Hide Task" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="mCS_img_loaded" width="15px"></a>' +

                    '</div>' +
                    ' </div>' +

                    '</td>' +

                    '<td>' +
                    '   <label class="pro_Calculate_count">01:00</label>' +
                    '</td>' +
                    '<td>' +
                    '   <label class="pro_Calculate_count">02:00</label>' +
                    '</td>' +
                    '<td>' +
                    '   <label class="pro_Calculate_count">02:00</label>' +
                    '</td>' +
                    '<td>' +
                    '   <label class="pro_Calculate_count">02:00</label>' +
                    '</td>' +
                    '<td>' +
                    '   <label class="pro_Calculate_count">02:00</label>' +
                    '</td>' +
                    '<td>' +
                    '   <label class="pro_Calculate_count">02:00</label>' +
                    '</td>' +
                    '<td class="toggleDisplay">' +
                    '   <label class="pro_Calculate_count">02:00</label>' +
                    '</td>' +
                    '<td>' +
                    '   <label class="pro_Calculate_count">02:00</label>' +
                    '</td>' +
                    '<td>' +
                    '   <label class="pro_Calculate_count">&nbsp;</label>' +
                    '</td>' +
                    '<td>' +
                    '   <label class="pro_Calculate_count">&nbsp;</label>' +
                    '</td>' +
                    '<td class="text-center crossandcheckactions">' +
                    '   <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn">' +
                    '      <div class="input-group">' +
                    '         <button data-bs-toggle="modal" data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button" data-placement="top" title="Approve"><i class="fas fa-check"></i></button>' +
                    '        <button data-bs-toggle="modal" data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button" data-bs-toggle="tooltip" data-placement="top" title="Reject"><i class="fas fa-times"></i></button>' +
                    '   </div>' +
                    '</div>' +
                    '</td>' +
                    '</tr>';

            }
            $("#TimesheetDetailTbody").html(taskHTML);

            

        }

       



    </script>
    <!-- stickytable js -->
   <%-- <script src="../../../Whizible2.0-new/dist/js/table-fixed-header.js"></script>--%>
    <!--freezetbl_header_in_modalpopupbox-->
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/jquery.freezeheader.js"></script>

</body>

</html>
