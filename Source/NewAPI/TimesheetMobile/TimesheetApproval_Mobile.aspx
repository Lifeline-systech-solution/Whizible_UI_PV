<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TimesheetApproval_Mobile.aspx.vb" Inherits="PbNIT.TimesheetApproval_Mobile" %>

<!DOCTYPE html>
<html>
<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("Weekly Timesheet")%> 
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Weekly Timesheet</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
   <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
 <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">--%>
    <!--<link rel="stylesheet" href="../../../Whizible2.0/dist/css/bootstrap-datepicker.css">-->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/daterangepicker-bs3.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/skins/_all-skins.min.css">
    <!-- custom scrollbar -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery.mCustomScrollbar.css">

    <link rel="stylesheet" type="text/css" href="../../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.css">
    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css">

    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=1.7">

    <!-- <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700" rel="stylesheet"> -->
    <style type="text/css">
        /*body{ overflow: hidden; }*/
        /*Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings*/
        .clsHide {
            display: none !important;
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
        .clsrejected {
            cursor:no-drop!important;
            color:black!important;
        }
        .clsnote {
           color:red!important;
           font-size:10px!important;
        }

        .customelinks li a {
            padding: 10px;
            display: block;
        }

        .navstatuslink {
            text-align: center;
            margin-left: 46px;
        }
        /*Added By Dipali V On 18th May 2023 For UI Issues*/
        a {
            color: #337ab7;
            text-decoration: none!important;
        }

          #CloseableAlert .close {
            float: right;
            border: none;
        }

        .custmodal .modal-content .modal-header .close {
            color: #fff;
            box-shadow: none;
            border: none;
            font-size: 24px;
            text-shadow: none;
            opacity: 1;
            position: absolute;
            top: 5px!important;
            right: 20px;
            background: transparent!important;
        }
         #alertMsg {
            font-size: 13px;
            width: 295px;
        }
         .autoclosablemsg{ display:none;}

           .form-select option {
            font-size: 12px;
            padding: 5px;
            width:100px;
        }
           /*End Of Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings*/
    </style>


 
  



</head>

<body class="skin-blue-light sidebar-mini dashmain fixed" >
    <div class="" id="bodyTimesheetApproval_mv"></div>
        <div class="responsivewarningmsg">
        <h2>Please check on 1280px and high Resolution</h2>
    </div>

    <div class="wrapper">
        <!-- Main Header -->
        <header class="main-header">

            <!-- Header Navbar -->
            <nav class="navbar navbar-static-top" role="navigation">

                <div class="mainheadingtop">Timesheet &gt; Approval</div>

                <div class="filter pull-right">
                    <button data-bs-toggle="collapse" data-bs-target="#Mvfilterpanel" class="collapsed" aria-expanded="false"><i class="fas fa-filter"></i></button>


                </div>
            </nav>
        </header>
        <!--bootstrap_Alertify-->
        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" > <%--hidden="hidden"--%>
            <button type="button" class="close" onclick="CloseShowAlert()">×</button>
            <p id="alertMsg"></p>
        </div>
        <!--bootstrap_Alertify-->
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <!-- Main content -->
            <section class="content">

                <div class="weeklytimesheetwrap hidden-desktop">


                    <!--mobileview filter panel-->
                    <div id="Mvfilterpanel" class="Mv_filterpanel collapse hidden-desktop" aria-expanded="true" style="">
                        <div class="container">
                            <div class="form-group">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboResource", "Select ''",,, "class='form-select'",,, ) %>

                            </div>


                            <div class="clearfix"></div>

                            <div class="fp_button text-center">
                                <a href="#" class="btn borderbtn cancelbtn" data-bs-toggle="collapse" data-bs-target="#Mvfilterpanel">Cancel</a>
                                <a href="#" class="btn borderbtn active" onclick="ApplyFilter()">Apply</a>
                            </div>

                        </div>
                    </div>
                    <!--mobile view filter anel end-->

                    <div class="tab-content" id="divTimesheetApproval">

                        <div class="container" data-spy="affix" data-offset-top="100">

                            <!--startnextdiv-->
                            <div class="row graybg">
                                <div class="col-xs-12">

                                    <ul class="nav customelinks navstatuslink">
                                        <li class="statusall"><a id="all" data-target="statusall" href="javascript:;">All</a></li>
                                        <li class="statusapproved"><a id="Approved"  data-target="statusapproved" href="javascript:;">Approved</a></li>
                                        <li class="statusrejected"><a id='Rejected' data-target="statusrejected" href="javascript:;">Rejected</a></li>
                                        <li class="statussubmitted active"><a id="Submitted"   data-target="statussubmitted" href="javascript:;">Submitted</a></li>

                                        <%--<li class="statusallactive active"><a id="all" data-target="all" href="javascript:;">All</a></li>
                                        <li class="statusapproved"><a id="Approved" data-target="statusapproved" href="javascript:;">Approved</a></li>
                                        <li class="statusrejected"><a id='Rejected' data-target="statusrejected" href="javascript:;">Rejected</a></li>
                                        <li class="statussubmitted"><a id="Submitted" class="active" data-target="statussubmitted" href="javascript:;">Submitted</a></li>--%>
                                    </ul>

                                </div>

                            </div>

                            <!--startnextdiv-->
                            <div class="row pt-1 pb-1 bggraylight">
                                <div class="col-xs-9">
                                </div>
                                <%--<div class="col-xs-3 text-right xs-pl-0">--%>
                                <div class="col-xs-3 text-right xs-pl-0" >
                                   <%-- <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn pull-right mt-onehalf">--%>
                                    <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn pull-right mt-onehalf" style="float:right;margin-right: 12px;padding-bottom: 10px;">
                                        <div class="input-group">
                                            <button data-bs-toggle="modal" id="btnApprove" onclick="ShowApproveModal()" class="btn btn-outline-secondary btn-success" type="button"><i class="fas fa-check"></i></button>
                                            <button data-bs-toggle="modal" id="btnReject" onclick="ShowRejectModal()" style="border-radius: 3px" class="btn btn-outline-secondary btn-red" type="button"><i class="fas fa-times"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!--timesheet table-->

                        <div class="mobcusttble Mv_timesheetabpproval_tbl mt-2 Mv_statusfiltertble ">
                            <div class="container">
                                <div id="chkSelectAll" class="custom_chckbox pull-right Mvtimesheetapprovalcheckbox pb-1" style="margin-left: 244px;margin-top: 3px;display: block;margin-bottom: 10px;">

                                    <input type="checkbox" id="ApproveAll" class="ApproveAll" >
                                    <label for="ApproveAll">Select All</label>
                                 
                                    
                                </div>
                                <div id="DivMainBody">
                                </div>
                            </div>

                        </div>

                        <!--timesheet table-->

                    </div>
                    <!--nextdivend-->



                    <div class="tab-content" id="TAviewdatepanelshow">
                        <div class="timesheetrow container-fluid pt-1 pb-1 graybg mv_tadetailtop">
                            <table width="100%">
                                <tr>
                                    <td>Employee Name</td>
                                    <td class="text-center">18-23<br />
                                        June 2018</td>
                                    <td class="text-right">No Submitted<br />
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn pull-right mt-onehalf">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal"  data-bs-target="#approvetaskmodal" class="btn btn-outline-secondary btn-success" type="button" data-original-title="" title=""><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal"  data-bs-target="#rejectmodal" class="btn btn-outline-secondary btn-red" type="button" data-original-title="" title=""><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <div class="clearfix"></div>
                        </div>

                        <div class="container">

                            <div class="timesheetrow container-fluid pt-1 pb-1">
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-xs-5 pull-right">
                                        <div class="Mv_actualwork_hrs hidden-desktop text-right">Planned : <strong><big>70</big>Hr</strong></div>
                                    </div>
                                    <div class="col-md-6 col-sm-6 col-xs-7">
                                        <div class="Mv_actualwork_hrs hidden-desktop">Actual work : <strong><big>72</big>Hr</strong></div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>


                            <!--timesheet-table-->

                            <!--timesheet table-->

                            <div class="mobcusttble">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="col-xs-9">
                                                <div class="tv_palnneddate">Monday, 18<span>June 2018</span></div>
                                            </td>
                                            <td class="col-xs-2 text-right">
                                                <div class="MvTv_hrs">
                                                    10<br />
                                                    Hr
                                                </div>
                                            </td>
                                            <td class="col-xs-1"><i id="TAviewdatepaneldetail" class="fas fa-angle-right tab"></i></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="col-xs-9">
                                                <div class="tv_palnneddate">Tuesday, 19<span>June 2018</span></div>
                                            </td>
                                            <td class="col-xs-2 text-right">
                                                <div class="MvTv_hrs">
                                                    10<br />
                                                    Hr
                                                </div>
                                            </td>
                                            <td><i class="fas fa-angle-right"></i></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="col-xs-9">
                                                <div class="tv_palnneddate">Wednesday, 20<span>June 2018</span></div>
                                            </td>
                                            <td class="col-xs-2 text-right">
                                                <div class="MvTv_hrs">
                                                    10<br />
                                                    Hr
                                                </div>
                                            </td>
                                            <td class="col-xs-1"><i class="fas fa-angle-right"></i></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="col-xs-9">
                                                <div class="tv_palnneddate">Thursday, 21<span>June 2018</span></div>
                                            </td>
                                            <td class="col-xs-2 text-right">
                                                <div class="MvTv_hrs">
                                                    10<br />
                                                    Hr
                                                </div>
                                            </td>
                                            <td class="col-xs-1"><i class="fas fa-angle-right"></i></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="col-xs-9">
                                                <div class="tv_palnneddate">Friday, 22<span>June 2018</span></div>
                                            </td>
                                            <td class="col-xs-2 text-right">
                                                <div class="MvTv_hrs">
                                                    10<br />
                                                    Hr
                                                </div>
                                            </td>
                                            <td class="col-xs-1"><i class="fas fa-angle-right"></i></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="col-xs-9">
                                                <div class="tv_palnneddate">Saturday, 23<span>June 2018</span></div>
                                            </td>
                                            <td class="col-xs-2 text-right">
                                                <div class="MvTv_hrs">
                                                    10<br />
                                                    Hr
                                                </div>
                                            </td>
                                            <td class="col-xs-1"><i class="fas fa-angle-right"></i></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="col-xs-9">
                                                <div class="tv_palnneddate">Sunday, 24<span>June 2018</span></div>
                                            </td>
                                            <td class="col-xs-2 text-right">
                                                <div class="MvTv_hrs">
                                                    10<br />
                                                    Hr
                                                </div>
                                            </td>
                                            <td class="col-xs-1"><i class="fas fa-angle-right"></i></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="col-xs-9">
                                                <div class="tv_palnneddate">Monday, 18<span>June 2018</span></div>
                                            </td>
                                            <td class="col-xs-2 text-right">
                                                <div class="MvTv_hrs">
                                                    10<br />
                                                    Hr
                                                </div>
                                            </td>
                                            <td class="col-xs-1"><i class="fas fa-angle-right"></i></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="col-xs-9">
                                                <div class="tv_palnneddate">Monday, 18<span>June 2018</span></div>
                                            </td>
                                            <td class="col-xs-2 text-right">
                                                <div class="MvTv_hrs">
                                                    10<br />
                                                    Hr
                                                </div>
                                            </td>
                                            <td class="col-xs-1"><i class="fas fa-angle-right"></i></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="col-xs-9">
                                                <div class="tv_palnneddate">Monday, 18<span>June 2018</span></div>
                                            </td>
                                            <td class="col-xs-2 text-right">
                                                <div class="MvTv_hrs">
                                                    10<br />
                                                    Hr
                                                </div>
                                            </td>
                                            <td class="col-xs-1"><i class="fas fa-angle-right"></i></td>
                                        </tr>
                                    </tbody>
                                </table>

                            </div>


                            <!--timesheet-table-end-->



                        </div>

                    </div>
                    <!--tabend-->




                    <!--tab3start-->

                    <div class="tab-content" id="TAviewdatepaneldetailshow">
                        <div class="timesheetrow container-fluid pt-1 pb-1 graybg mv_tadetailtop">
                            <table width="100%">
                                <tr>
                                    <td>Employee Name</td>
                                    <td class="text-center">18-23<br />
                                        June 2018</td>
                                    <td class="text-right">No Submitted<br />
                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn pull-right mt-onehalf">
                                            <div class="input-group">
                                                <button data-bs-toggle="modal"  data-bs-target="#approvetaskmodal" class="btn btn-outline-secondary btn-success" type="button" data-original-title="" title=""><i class="fas fa-check"></i></button>
                                                <button data-bs-toggle="modal"  data-bs-target="#rejectmodal" class="btn btn-outline-secondary btn-red" type="button" data-original-title="" title=""><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <div class="clearfix"></div>
                        </div>

                        <div class="container">

                            <div class="timesheetrow container-fluid pt-1 pb-1">
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-xs-5 pull-right">
                                        <div class="Mv_actualwork_hrs hidden-desktop">Planned : <strong><big>70</big>Hr</strong></div>
                                    </div>
                                    <div class="col-md-6 col-sm-6 col-xs-7">
                                        <div class="Mv_actualwork_hrs hidden-desktop">Actual work : <strong><big>72</big>Hr</strong></div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>



                            <!--timesheet table-->

                            <div class="mobcusttble">



                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="tbl-projecttitletd">
                                                <div class="tbl-projecttitle">Whisible 1.0 </div>
                                            </td>
                                            <td class="text-right">
                                                <div class="dropdown">
                                                    <img class="dropdown-toggle" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="" data-bs-toggle="dropdown" aria-expanded="true">

                                                    <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">
                                                        <div class="arrow-left"></div>
                                                        <div class="projecttaskinfo_tooltipbox">
                                                            <%--<button type="button" class="close" data-bs-dismiss="modal">--%>
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

                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <div class="subtasklistcolumn">
                                                    <div class="subtasklist">
                                                        Task 1 : Define roles & respon...
                                                        <img class="hidden-xs" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                                    </div>
                                                    <div class="subtasklist">
                                                        Sub-Task 2 : Define roles &amp; respon...
                                                    </div>
                                                </div>

                                            </td>

                                            <td class="text-right">
                                                <!--mobileview time entry textfield and story points-->
                                                <div class="Mv_timeentryfield hidden-desktop">

                                                    <div class="timenodropdown">
                                                        <label class="timenoinput">02:00 <small>Hr</small></label>
                                                    </div>

                                                    <label class="selecttimeno">01 <small>Pt</small></label>

                                                    <div class="clearfix"></div>

                                                    <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn pull-right">
                                                        <div class="input-group">
                                                            <button data-bs-toggle="modal"  data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button"><i class="fas fa-check"></i></button>
                                                            <button data-bs-toggle="modal"  data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button"><i class="fas fa-times"></i></button>
                                                        </div>
                                                    </div>


                                                </div>

                                                <!--mobileview time entry textfield and story points end-->

                                            </td>
                                        </tr>

                                    </tbody>
                                </table>


                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="tbl-projecttitletd">
                                                <div class="tbl-projecttitle">Whisible 1.0 </div>
                                            </td>
                                            <td class="text-right">
                                                <div class="dropdown">
                                                    <img class="dropdown-toggle" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="" data-bs-toggle="dropdown" aria-expanded="true">

                                                    <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">
                                                        <div class="arrow-left"></div>
                                                        <div class="projecttaskinfo_tooltipbox">
                                                            <%--<button type="button" class="close" data-bs-dismiss="modal">--%>
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

                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <div class="subtasklistcolumn">
                                                    <div class="subtasklist">
                                                        Task 1 : Define roles & respon...
                                                        <img class="hidden-xs" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                                    </div>
                                                    <div class="subtasklist">
                                                        Sub-Task 2 : Define roles &amp; respon...
                                                    </div>
                                                </div>

                                            </td>

                                            <td class="text-right">
                                                <!--mobileview time entry textfield and story points-->
                                                <div class="Mv_timeentryfield hidden-desktop">

                                                    <div class="timenodropdown">
                                                        <label class="timenoinput">02:00 <small>Hr</small></label>
                                                    </div>

                                                    <label class="selecttimeno">01 <small>Pt</small></label>

                                                    <div class="clearfix"></div>

                                                    <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn pull-right">
                                                        <div class="input-group">
                                                            <button data-bs-toggle="modal"  data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button"><i class="fas fa-check"></i></button>
                                                            <button data-bs-toggle="modal"  data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button"><i class="fas fa-times"></i></button>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!--mobileview time entry textfield and story points end-->

                                            </td>
                                        </tr>

                                    </tbody>
                                </table>

                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="tbl-projecttitletd">
                                                <div class="tbl-projecttitle">Whisible 1.0 </div>
                                            </td>
                                            <td class="text-right">
                                                <div class="dropdown">
                                                    <img class="dropdown-toggle" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="" data-bs-toggle="dropdown" aria-expanded="true">

                                                    <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">
                                                        <div class="arrow-left"></div>
                                                        <div class="projecttaskinfo_tooltipbox">
                                                            <%--<button type="button" class="close" data-bs-dismiss="modal">--%>
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

                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <div class="subtasklistcolumn">
                                                    <div class="subtasklist">
                                                        Task 1 : Define roles & respon...
                                                        <img class="hidden-xs" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                                    </div>
                                                    <div class="subtasklist">
                                                        Sub-Task 2 : Define roles &amp; respon...
                                                    </div>
                                                </div>

                                            </td>

                                            <td class="text-right" width="35%">
                                                <!--mobileview time entry textfield and story points-->
                                                <div class="Mv_timeentryfield hidden-desktop">
                                                    <span class="timeno">
                                                        <div class="timenodropdown">
                                                            <label class="timenoinput">02:00 <small>Hr</small></label>
                                                        </div>

                                                        <label class="selecttimeno">01 <small>Pt</small></label>

                                                        <div class="clearfix"></div>
                                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn pull-right">
                                                            <div class="input-group">
                                                                <button data-bs-toggle="modal"  data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button"><i class="fas fa-check"></i></button>
                                                                <button data-bs-toggle="modal"  data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button"><i class="fas fa-times"></i></button>
                                                            </div>
                                                        </div>
                                                </div>

                                                <!--mobileview time entry textfield and story points end-->

                                            </td>
                                        </tr>

                                    </tbody>
                                </table>

                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="tbl-projecttitletd">
                                                <div class="tbl-projecttitle">Whisible 1.0 </div>
                                            </td>
                                            <td class="text-right" width="35%">
                                                <div class="dropdown">
                                                    <img class="dropdown-toggle" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="" data-bs-toggle="dropdown" aria-expanded="true">

                                                    <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">
                                                        <div class="arrow-left"></div>
                                                        <div class="projecttaskinfo_tooltipbox">
                                                            <%--<button type="button" class="close" data-bs-dismiss="modal">--%>
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

                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <div class="subtasklistcolumn">
                                                    <div class="subtasklist">
                                                        Task 1 : Define roles & respon...
                                                        <img class="hidden-xs" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                                    </div>
                                                    <div class="subtasklist">
                                                        Sub-Task 2 : Define roles &amp; respon...
                                                    </div>
                                                </div>

                                            </td>

                                            <td class="text-right" width="35%">
                                                <!--mobileview time entry textfield and story points-->
                                                <div class="Mv_timeentryfield hidden-desktop">
                                                    <span class="timeno">
                                                        <div class="timenodropdown">
                                                            <label class="timenoinput">02:00 <small>Hr</small></label>
                                                        </div>

                                                        <label class="selecttimeno">01 <small>Pt</small></label>

                                                        <div class="clearfix"></div>
                                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn pull-right">
                                                            <div class="input-group">
                                                                <button data-bs-toggle="modal"  data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button"><i class="fas fa-check"></i></button>
                                                                <button data-bs-toggle="modal"  data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button"><i class="fas fa-times"></i></button>
                                                            </div>
                                                        </div>
                                                </div>

                                                <!--mobileview time entry textfield and story points end-->

                                            </td>
                                        </tr>

                                    </tbody>
                                </table>

                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="tbl-projecttitletd">
                                                <div class="tbl-projecttitle">Whisible 1.0 </div>
                                            </td>
                                            <td class="text-right" width="35%">
                                                <div class="dropdown">
                                                    <img class="dropdown-toggle" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="" data-bs-toggle="dropdown" aria-expanded="true">

                                                    <div class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">
                                                        <div class="arrow-left"></div>
                                                        <div class="projecttaskinfo_tooltipbox">
                                                            <%--<button type="button" class="close" data-bs-dismiss="modal">--%>
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

                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <div class="subtasklistcolumn">
                                                    <div class="subtasklist">
                                                        Task 1 : Define roles & respon...
                                                        <img class="hidden-xs" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="">
                                                    </div>
                                                    <div class="subtasklist">
                                                        Sub-Task 2 : Define roles &amp; respon...
                                                    </div>
                                                </div>

                                            </td>

                                            <td class="text-right" width="35%">
                                                <!--mobileview time entry textfield and story points-->
                                                <div class="Mv_timeentryfield hidden-desktop">
                                                    <span class="timeno">
                                                        <div class="timenodropdown">
                                                            <label class="timenoinput">02:00 <small>Hr</small></label>
                                                        </div>

                                                        <label class="selecttimeno">01 <small>Pt</small></label>

                                                        <div class="clearfix"></div>
                                                        <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn pull-right">
                                                            <div class="input-group">
                                                                <button data-bs-toggle="modal"  data-bs-target="#approvetaskbtnmodal" class="btn btn-outline-secondary btn-success" type="button"><i class="fas fa-check"></i></button>
                                                                <button data-bs-toggle="modal"  data-bs-target="#rejecttaskmodal" class="btn btn-outline-secondary btn-red" type="button"><i class="fas fa-times"></i></button>
                                                            </div>
                                                        </div>
                                                </div>

                                                <!--mobileview time entry textfield and story points end-->

                                            </td>
                                        </tr>

                                    </tbody>
                                </table>







                            </div>


                            <!--timesheet-table-end-->



                        </div>

                    </div>
                    <!--tabend-->






                </div>
            </section>
            <!-- /.content -->
        </div>


        <!--all modal start here-->



        <!--rejectmodal-->
        <div id="rejectmodal" class="modal fade custmodal rejectmodal" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <%--<button type="button" class="close" data-bs-dismiss="modal">&times;</button>--%>
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Reject Timesheet</h4>

                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-12 col-sm-4 text-left">Reason for rejection:</div>
                                <div class="col-xs-12 col-sm-8">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12">
                                            <textarea class="form-control" maxlength="200" id="txtRejectionComment"></textarea>
                                        </div>
                                        <div class="col-xs-2 col-sm-4"></div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-12 col-sm-8">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12">

                                            <div class="custom_chckbox" id="custom_chckbox">
                                                <%--Commented And Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings--%>  
                                                <%--<input type="checkbox" id="rejectmodalcheckbox">
                                                <label for="rejectmodalcheckbox">Allow resource to change timesheet and resubmit</label>--%>
                                                <input type="checkbox" id="rejectmodalcheckbox" class ="clsHide">
                                                <label class ="clsHide" for="rejectmodalcheckbox">Allow resource to change timesheet and resubmit</label>                                                
                                                <%--End Of Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings--%>    
                                            </div>
                                            <span id ="allowoverridenote" style="font-weight:700;"></span>
                                        </div>
                                        <div class="col-xs-2 col-sm-4"></div>
                                    </div>

                                </div>
                            </div>
                        </div>


                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-left" style="width:62%!important">
                                    <%--<button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>--%>
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                </div>
                                <div class="col-xs-6 col-sm-6" style="width:32%!important">
                                    <button class="btn btnyellow ml-1 pull-right" onclick="RejectAllTimesheet()">Reject</button>
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
        <div id="rejecttaskmodal" class="modal fade custmodal" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <%--<button type="button" class="close" data-bs-dismiss="modal">&times;</button>--%>
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title"></h4>
                        <%--<center><small>28-05-2018 &nbsp;To &nbsp; 03-06-2018</small></center>--%>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-12 col-sm-4 text-left">Reason for rejection:</div>
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
                                <div class="col-xs-12 col-sm-8">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12">

                                            <div class="custom_chckbox">
                                                <%--Commented And Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings--%>    
                                                <%--<input type="checkbox" id="rejecttaskmodalcheckbox">
                                                <label for="rejecttaskmodalcheckbox">Allow resource to change timesheet and resubmit</label>--%>
                                                <input type="checkbox" id="rejecttaskmodalcheckbox" class ="clsHide">
                                                <label class ="clsHide" for="rejecttaskmodalcheckbox">Allow resource to change timesheet and resubmit</label>                                                
                                                <%--End Of Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings--%>    
                                            </div>
                                            <span id ="allowoverridenote" style="font-weight:700;"></span>
                                        </div>
                                        <div class="col-xs-2 col-sm-4"></div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-left">
                                    <%--<button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>--%>
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 pull-right">Reject</button>
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
                        <%--<button type="button" class="close" data-bs-dismiss="modal">&times;</button>--%>
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Approve Timesheet</h4>
                    </div>

                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-12 col-sm-4 text-left">Comment:</div>
                                <div class="col-xs-12 col-sm-8">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12">
                                            <textarea class="form-control" maxlength="200" id="txtApprovalComment"></textarea>
                                        </div>
                                        <div class="col-xs-2 col-sm-4"></div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-left" style="width:62%!important">
                                    <%--<button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>--%>
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                </div>
                                <div class="col-xs-6 col-sm-6" style="width:32%!important">
                                    <button class="btn btnyellow ml-1 pull-right" onclick="ApproveAllTimesheet()">Approve</button>
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
                        <%--<button type="button" class="close" data-bs-dismiss="modal">&times;</button>--%>
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Approve Task</h4>
                    </div>

                    <div class="modal-body">

                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-12 col-sm-4 text-right"></div>
                                <div class="col-xs-12 col-sm-8">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12">
                                          <%--  Lorem Ipsum dummy task--%>
                                        </div>
                                        <div class="col-xs-2 col-sm-4"></div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                 <%-- Added By Dipali V On 28th May 2019--%>
                          <%--  <div class="col-xs-12 col-sm-4 text-right">Comment:</div>--%>
                            <div class="col-xs-12 col-sm-4 text-left">Comment:</div>
                            <%-- End of Added By Dipali V On 28th May 2019--%>
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
                                <div class="col-xs-6 col-sm-6 text-left">
                                    <%--<button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>--%>
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 pull-right">Approve</button>
                                </div>
                            </div>
                        </div>


                    </div>


                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--modalEnd-->

        <!--submitmodal-->
        <div id="submitinfomodal" class="modal fade custmodal" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <%--<button type="button" class="close" data-bs-dismiss="modal">&times;</button>--%>
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title"></h4>
                    </div>

                    <div class="modal-body">
                        <p align="center">You select Approved Timesheet!! Do you want to continue??</p>
                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-left">
                                    <%--<button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>--%>
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 pull-right" onclick="ConfirmYes()">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!--all modal end here-->





        <!-- /.content-wrapper -->
        <!-- Control Sidebar -->

        <!-- /.control-sidebar -->

    </div>

  
<%--       <script src="../../../Whizible2.0/plugins/jQuery/jquery-migrate-3.3.2.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
    <script src="../../General/CommonValidations.js"></script>

    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <!-- custome_mobile_only js -->
    <script src="../../../Whizible2.0-new/dist/js/custom_mobile.js?v=1"></script>
    <!--weekpicker-->
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/weekPicker.js?v=1.7"></script>

    <script type="text/javascript">
        //Mobile Menu
        /*  $('#Mmenu_togglebtn').click(function () {
        $('.Mv_mobmenu').toggleClass('Mv_mobmenu_open animated fadeInUp');

         });
        */
    </script>
    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var EmployeeID;
        EmployeeID = <%= Session("intUserID") %>;
        var getSelectedStatus = "Submitted";
        //jQuery(document).ready(function () {
        $(document).ready(function () {
            StartLoader("#bodyTimesheetApproval_mv");
            BindEmployeeFilterDropDown();
            ReloadData(EmployeeID);
              //Added By Dipali V On 6th Jan 2020 For Filter Issues
            AfterResponsivePlot();
            StopAjaxLoader("#bodyTimesheetApproval_mv");
            //End of Added By Dipali V On 6th Jan 2020 For Filter Issues            
            //Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
            //globalOverrideTSCheck = getCorporateOverrideTSCheck();
            //globalAllowToResubmitCheck = getCorporateAllowToResubmitCheck();            
            //globalBackdatingNoDays = getBackdatingNoDays();
            //End Of Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
        
        });

        function ReloadData(ProxyResourceID, FilteredEmpID) {

            if (ProxyResourceID == 0)
                ProxyResourceID = EmployeeID;

            if (FilteredEmpID != undefined) {
                taskParameters = {
                    intEmployeeID: ProxyResourceID,
                    intResourceID: FilteredEmpID,
                }
            }
            else {
                taskParameters = {
                    intEmployeeID: ProxyResourceID,
                }
            }


            AjaxCall(taskParameters);

        }
        function AjaxCall(taskParameters) {

            StartLoader("#bodyTimesheetApproval_mv");

            $.ajax({
                url: strUrl + '/api/TimesheetApproval/GetTimesheetData',
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
                    var TimesheetApproval = data;
                    PlotTimesheetApprovalSection(TimesheetApproval.TimesheetApprovalLists)
                    $("#" + getSelectedStatus + "").trigger("click");
                    StopAjaxLoader("#bodyTimesheetApproval_mv");
                    AfterPlot();
                    //if (StatusDescription == 'Ready for approval') {
                    //    alert("1")
                    //    $('#ApproveAll').hide();
                    //     $('#RejectAll').show();
                    //}
                    //else {
                    //    $('#RejectAll').hide();
                    //    $('#ApproveAll').show();
                    //}
                    $('#ApproveAll').change(function () {
                        $('.approvechktbl').prop("checked", this.checked);
                        $('.rejectchktbl').prop("checked", this.checked);

                    });
                  
                    $(".approvechktbl").change(function () {
                        //debugger;
                        if ($('input:checkbox:checked.approvechktbl').length === $("input:checkbox.approvechktbl").length) {
                            $('#ApproveAll').prop("checked", true);
                        }
                        else {
                            $('#ApproveAll').prop("checked", false);
                        }

                    });
                     $(".rejectchktbl").change(function () {
                        //debugger;
                        if ($('input:checkbox:checked.rejectchktbl').length === $("input:checkbox.rejectchktbl").length) {
                            $('#ApproveAll').prop("checked", true);
                        }
                        else {
                            $('#ApproveAll').prop("checked", false);
                        }

                    });

                },
                error: function (err) {
                    StopAjaxLoader("#bodyTimesheetApproval_mv");
                    console.log(err);

                }
            })
        }

        //Commented & Added By Dipali V On 19th May 2023 For Checkbox selection issues
        //$(".approvechktbl").change(function () {
        $('#DivMainBody').on('change', 'tbody td:nth-child(2) :checkbox.approvechktbl', function () {
            //if ($('input:checkbox:checked.approvechktbl').length === $("input:checkbox.approvechktbl").length) {
            if ($('input[type=checkbox].approvechktbl:checked').length == $('input[type=checkbox].approvechktbl').length) {
                $('#ApproveAll').prop("checked", true);
            }
            else {
                $('#ApproveAll').prop("checked", false);
            }
        });

        // $(".rejectchktbl").change(function () {
        $('#DivMainBody').on('change', 'tbody td:nth-child(2) :checkbox.rejectchktbl', function () {
           // if ($('input:checkbox:checked.rejectchktbl').length === $("input:checkbox.rejectchktbl").length) {
            if ($('input[type=checkbox].rejectchktbl:checked').length == $('input[type=checkbox].rejectchktbl').length) {
                $('#ApproveAll').prop("checked", true);
            }
            else {
                $('#ApproveAll').prop("checked", false);
            }
        });

       //End of Commented & Added By Dipali V On 19th May 2023 For Checkbox selection issues


        function BindEmployeeFilterDropDown() {
            //debugger;
            var taskParameters = {
                intEmployeeID: EmployeeID,
                //strFilterProjectList: ""
            }
            $.ajax({
                url: strUrl + '/api/TimesheetApproval/GetEmployeeDropdownValuesForFilter',
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
                    //debugger;
                    var selHTML = "";
                    selHTML += "<option value='0' selected>Select Employee</option>";
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        if (d.EmployeeID != 0) {
                            var EmployeeID = d.EmployeeID;
                            var EmployeeName = d.EmployeeName;
                            selHTML += "<option value='" + EmployeeID + "'>" + EmployeeName + "</option>";
                        }
                    }
                    $("#cboResource").html(selHTML);
                   // debugger;
                    // $(".selectpicker").selectpicker('refresh');
                   //Added By Dipali V On 26th March 2019 For ToolTip Should not display
                    $("#Mvfilterpanel .dropdown-toggle").hover(function () {
                      if ($("#Mvfilterpanel .dropdown-toggle").attr("data-id") == "cboResource") {
                        $("#Mvfilterpanel .dropdown-toggle").removeAttr("data-original-title", "");
                    }
                  })
                  //End of Added By Dipali V On 26th March 2019 For ToolTip Should not display
                },
                error: function (err) {
                    console.log(err);
                }
            });

        }

        $("#cboResource").on("click", function () {
            $(this).find(".dropdown-menu, .dropdown-toggle").addClass("show");
        });

        function PlotTimesheetApprovalSection(TimesheetApprovalLists) {
            $("#DivMainBody").html('');
            console.log(TimesheetApprovalLists);
            var strHTML = "";
            for (var i = 0; i < TimesheetApprovalLists.length; i++) {

                var TimesheetApprovalObject = TimesheetApprovalLists[i];
                var TimeSheetID = TimesheetApprovalObject.TimeSheetID;
                var EmployeeID = TimesheetApprovalObject.EmployeeID;
                var EmployeeName = TimesheetApprovalObject.EmployeeName;
                var FromDate = TimesheetApprovalObject.FromDate;
                var ToDate = TimesheetApprovalObject.ToDate;
                var Period = TimesheetApprovalObject.Period;
                var ActualHours = TimesheetApprovalObject.ActualHours;
                var ExpectedHours = TimesheetApprovalObject.ExpectedHours;
                var StatusCode = TimesheetApprovalObject.StatusCode;
                var StatusDescription = TimesheetApprovalObject.StatusDescription;
                var Comment = TimesheetApprovalObject.Comment;
                if (StatusDescription == 'Not ready for approval') { strHTML += '<div data-status="statusall" class="tabstatusdiv " id="statusall">'; }
                else if (StatusDescription == 'Ready for approval') { strHTML += '<div data-status="statussubmitted" class="tabstatusdiv " id="statussubmitted">'; }
                else if (StatusDescription == 'Approved') { strHTML += '<div data-status="statusapproved" class="tabstatusdiv " id="statusapproved">'; }
                else if (StatusDescription == 'Rejected') { strHTML += '<div data-status="statusrejected" class="tabstatusdiv " id="statusrejected">'; }

                strHTML += '<table class="table" >';
                strHTML += '<tbody>';
                strHTML += '<tr>';
                strHTML += '<td class="text-left">';
                strHTML += '<div class="Mv_timesheetapprovalinfo">';
                strHTML += '<div id="' + EmployeeID + '" class="Mv_timesheetapprovalname clsEmployee">' + EmployeeName + '</div>';
                if (StatusDescription == "Rejected") {
                    strHTML += '<p class="TA_tbl_approvaldate clsrejected" id="' + FromDate + '_TO_' + ToDate + '">' + Period + '</p>';
                } else {
                    strHTML += '<p><a style="cursor:pointer;" onclick=OpenDetailTab(' + TimeSheetID + ',' + EmployeeID + ',"' + FromDate + '","' + ToDate + '") class="TA_tbl_approvaldate" id="' + FromDate + '_TO_' + ToDate + '">' + Period + '</a></p>';
               
                }
                    strHTML += '<div class="Mv_actualandapprovaltime">';
                strHTML += '<p>';
                strHTML += '<lanel>Actual:</lanel>';
                strHTML += '' + ActualHours + '';
                strHTML += '</p >';
                strHTML += '<p>';
                strHTML += '<lanel>Expected:</lanel>';
                strHTML += '' + ExpectedHours + '';
                strHTML += '</p >';
                if (StatusDescription == "Rejected") {
                    strHTML += '<p class="clsnote">';
                    strHTML += 'Note :- User Yet to Resubmit ';
                    strHTML += '</p >';
                }
                strHTML += '</div >';
                strHTML += '</div>';
                strHTML += '</td>';
                strHTML += '<td class="text-right">';
                strHTML += '<div class="custom_chckbox">';
                if (StatusDescription == 'Ready for approval') {
                    strHTML += '<p class="text-right clsStatus submitted">Submitted</p>';
                     strHTML += '<input type="checkbox" name="chktbl" class="chktbl rejectchktbl" id="chktbl' + TimeSheetID + '">';
                    strHTML += '<label for="chktbl' + TimeSheetID + '"></label>';
                }
                else if (StatusDescription == 'Approved') {
                    strHTML += '<p class="text-right clsStatus">' + StatusDescription + '</p>';
                    strHTML += '<input type="checkbox" name="chktbl" class="chktbl approvechktbl" id="chktbl' + TimeSheetID + '">';
                    strHTML += '<label for="chktbl' + TimeSheetID + '"></label>';
                }

                
                if (StatusDescription == 'Rejected') {
                    strHTML += '<p class="text-right clsStatus">' + StatusDescription + '</p>';
                    strHTML += '<input type="checkbox" class="chktbl" id="chktbl' + TimeSheetID + ' disabled  style="cursor:not-allowed"">';
                    strHTML += '<label for="chktbl' + TimeSheetID + ' style="cursor:not-allowed""></label>';
                }
                else {
                    //strHTML += '<input type="checkbox" name="chktbl" class="chktbl approvechktbl" id="chktbl' + TimeSheetID + '">';
                    //strHTML += '<label for="chktbl' + TimeSheetID + '"></label>';
                }


                strHTML += '</div>';
                strHTML += '</td>';
                strHTML += '</tr>';
                strHTML += '</tbody>';
                strHTML += '</table>';
                strHTML += '<div class="clearfix"></div>';
                strHTML += '</div>';
            }
            $("#DivMainBody").html(strHTML);
        }

        /*Added By Dipali V On 17th May 2023 For Active Tab*/
        $('.navstatuslink a').on('click', function () {
            $(".navstatuslink li a").removeClass("active");
            $(this).addClass("active");
        });

       

        /*End of Added By Dipali V On 17th May 2023 For Active Tab*/

        $('.navstatuslink a').on('click', function () {
           // debugger;
            //Commented & Added By Dipali V On 19th May 2023 For Check box
           // $('input:checkbox').removeAttr('checked');
            $('input:checkbox').prop('checked', false);
            //End of Commented & Added By Dipali V On 19th May 2023 For Check box
            var Status = $(this).attr('id');
            getSelectedStatus = Status;
            if (Status == 'all' || Status == 'Rejected') {
                $("#chkSelectAll").css('display', 'none');
            }
            else { $("#chkSelectAll").css('display', 'block'); }
            if (Status == 'Approved')
            {
                $("#btnApprove").css('display', 'none');
            }
            else {
                $("#btnApprove").css('display', 'inline-block');
            }
            if (Status == 'Rejected') {
                $(".approval_crossandcheckbtn").hide()
            } else {
                $(".approval_crossandcheckbtn").show()
            }

            
        });

        //Added by Dipali V On 26th March 2019 for Selected Tab should be display after redirction
        $('.navstatuslink a').each(function () {
            //debugger;

            if ("<%= Request.QueryString("TimesheetStatus")%>" != "") {
                if ($(this).attr('id') == "<%= Request.QueryString("TimesheetStatus")%>") {

                    $(this).removeClass("active");
                    $(this).addClass("active");

                }
                else {
                    $(this).removeClass("active");
                }

            }
        });

        $('.navstatuslink li a').click(function () {
            StartLoader("#bodyTimesheetApproval_mv");
            //var $target = $(this).data('target');
            var $target = $(this).attr('data-target');
            var $target = "#" + $target
            $("#statusall").removeClass('active');
            if ($target != '#statusall') {
                $('#DivMainBody .tabstatusdiv').css('display','none');
                $('#DivMainBody ' + $target + '').css('display','block');
            }
            else {
                $('#DivMainBody .tabstatusdiv').css('display','block');
            }
            StopAjaxLoader("#bodyTimesheetApproval_mv");
        });
         //End of Added by Dipali V On 26th March 2019 for Selected Tab should be display after redirction
        


        function ApplyFilter() {

            var FilteredEmpID = $("#cboResource option:selected").val();
            if (FilteredEmpID == 0) {
                showAlert("Please Select Employee.", "alert-danger");
                return false;
            }
            ReloadData(EmployeeID, FilteredEmpID);
        }
        function OpenDetailTab(TimesheetID, intEmployeeID, StartDate, EndDate) {
            //debugger;
            window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&intTimesheetID=" + TimesheetID + "&PageFlag=3&intEmployeeID=" + intEmployeeID + "";
            //$("#TAviewdatepanelshow").css('display', 'block');
            //$("#divTimesheetApproval").css('display', 'none');
        }
        function ShowApproveModal() {
            //debugger;
            var TempStatus = "";
            var Flag = 0;
            var NoSelectedRecord = 0;
            $("#DivMainBody tbody tr:visible").each(function () {
                //debugger;
                var CurrentStatus = $(this).find("td .clsStatus").html();
                if (TempStatus == "") {
                    TempStatus = CurrentStatus;
                }
                if ($(this).find("td .chktbl").is(':checked') == true) {
                    if (TempStatus != CurrentStatus) {

                        Flag = 0;
                        NoSelectedRecord = 1;
                    }
                    else {
                        NoSelectedRecord = 1;
                        Flag = 0;
                    }
                }

            });
            if (NoSelectedRecord == 0) { showAlert("Please Select atleast one record.", "alert-danger"); }
            else {
                if (Flag == 0) { $("#txtApprovalComment").val(""); $("#approvetaskmodal").modal("show"); }
                else if (Flag == 1) {
                    // debugger;
                    $("#submitinfomodal").modal("show");

                }
            }

        }
        function ConfirmYes() {
            $("#submitinfomodal").modal("hide");
            $("#txtApprovalComment").val("");
            $("#approvetaskmodal").modal("show");
        }
        function ShowRejectModal() {
            //debugger;
            var NoSelectedRecord = 0;
            $("#DivMainBody tbody tr:visible").each(function () {
                if ($(this).find("td .chktbl").is(':checked') == true) {
                    NoSelectedRecord = 1;
                }
            });
            if (NoSelectedRecord == 0) { showAlert("Please Select atleast one record.", "alert-danger"); }
            else {
                $("#txtRejectionComment").val("");
                $("#rejectmodalcheckbox").prop('checked', false);
                $("#rejectmodal").modal("show")
                //Added By Dipali V On 20th Feb 2021 For Hide Resubmit Checkbox
                $("#custom_chckbox").css("display", "none");
                //End of Added By Dipali V On 20th Feb 2021 For Hide Resubmit Checkbox                
                //Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
                var curCheckId = '';
                $(".tabstatusdiv .chktbl:checked").each(function () {
                    if (curCheckId == "") {
                        curCheckId = $(this).attr("id");
                    }
                    else {
                        curCheckId += "," + $(this).attr("id");
                    }
                    curCheckId = curCheckId.toString().replace("chktbl","");
                });
                globalOverrideTSCheck = getCorporateOverrideTSCheck();                       
                globalBackdatingNoDays = getBackdatingNoDays();
                var AllowToResubmitCheck = getCorporateAllowToResubmitCheck(curCheckId, "RejectAll");          
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
                //End Of Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
            }
        }
        
        //Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
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
        function getCorporateAllowToResubmitCheck(TimesheetIds, Flag) {            
            var AllowToResubmitCheck = false;
            var taskParameters = {
                strTimesheetIDs: TimesheetIds,
                intApproverID: '<%=Session("intUserID")%>',
                FromWhere: Flag,
                ProjectID:''
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                    }
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
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
        //End Of Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings

        
        function RejectAllTimesheet() {
            //debugger;
            var strComment = $("#txtRejectionComment").val();
            var bitAllowToResubmit = ($("#rejectmodalcheckbox").is(':checked') ? 1 : 0);
            //Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
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
            //End Of Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
            $("#DivMainBody tbody tr:visible").each(function () {
                var row = $(this);
                if (row.find("td .chktbl").is(':checked') == true) {
                    var TDID = (row.find("td .chktbl")).attr("id");
                    var Period = (row.find("td .TA_tbl_approvaldate")).attr("id");

                    var Tid = TDID.split('chktbl')[1];
                    var ResourseID = (row.find('.clsEmployee')).attr('id')
                    var FromDate = Period.split('_TO_')[0]
                    var ToDate = Period.split('_TO_')[1]
                    //Commented And Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
                    //ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, 0, FromDate, ToDate);
                    ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, bitAllowToResubmit, FromDate, ToDate);
                    //End Of Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
                }
            });
        }

        function ApproveAllTimesheet() {
            //debugger;

            var strComment = $("#txtApprovalComment").val();
            $("#DivMainBody tbody tr:visible").each(function () {
                var row = $(this);
                if (row.find("td .chktbl").is(':checked') == true) {
                    var TDID = (row.find("td .chktbl")).attr("id");
                    var Period = (row.find("td .TA_tbl_approvaldate")).attr("id");

                    var Tid = TDID.split('chktbl')[1];
                    var FromDate = Period.split('_TO_')[0]
                    var ToDate = Period.split('_TO_')[1]
                    var ResourseID = (row.find('.clsEmployee')).attr('id')
                    ApproveTimesheetAjaxCall(Tid, 'V', strComment, ResourseID, 0, FromDate, ToDate);
                }
            });

        }
        function ApproveOrReject() {

        }

        //Added by Vishal Mane on 14/10/2025 to have saperate MyTimesheet api end points in TimesheetEntry Controller
        var strUrlTimesheet = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Timesheet").ToString%>';
        //End of Added by Vishal Mane on 14/10/2025 to have saperate MyTimesheet api end points in TimesheetEntry Controller
        function ApproveTimesheetAjaxCall(Tid, strStatus, strComment, ResourseID, bitAllowToResubmit, FromDate, ToDate) {
            if (strComment == "") {
                showAlert("Please Enter Comment", "alert-danger");
            }
            else {
                taskParameters = {
                    intTimesheetID: Tid,
                    Status: strStatus,
                    intEmployeeID: EmployeeID,
                    strComment: strComment,
                    intAllowToResubmit: bitAllowToResubmit,
                    intResourceID: ResourseID,
                    intMobileView: 1,
                    //2021
                    FromWhere: 'RejectAll'
                    //2021
                }
                //  StartLoader("#bodyTSApproval");
                $.ajax({
                    //url: strUrl + '/api/TimesheetApproval/PostTimesheetData',
                    //Added by Vishal Mane on 14/10/2025 to have saperate MyTimesheet api end points in TimesheetEntry Controller
                    //url: strUrl + '/api/TimesheetApproval/PostTimesheetData',                
                    url: strUrlTimesheet + '/api/TimesheetEntryNew/PostTimesheetData',
                    //End of Added by Vishal Mane on 14/10/2025 to have saperate MyTimesheet api end points in TimesheetEntry Controller
                    type: "POST",
                    data: JSON.stringify(taskParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        //Added by Vishal Mane on 14/10/2025 to have saperate MyTimesheet api end points in TimesheetEntry Controller
                        //xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                        //End of Added by Vishal Mane on 14/10/2025 to have saperate MyTimesheet api end points in TimesheetEntry Controller
                        if (taskParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                        }
                    },
                    success: function (data) {

                        //   debugger;

                        if (data == 1) {
                            if (strStatus == 'V') {
                                //    window.open('../Email/SendEmail.aspx?MessageID=435&VerifiedBy=' + EmployeeID + '&ResourceID=' + ResourseID + '&FromDate=' + FromDate + '&ToDate=' + ToDate + '&TimesheetID=' + Tid + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=580');
                                //$("#approvetaskmodal").modal("hide");

                                showAlert('Timesheet Approved successfully.', 'alert-success', 'btnSave');
                                $("#approvetaskmodal").modal('hide');
                                //sendEmailAjaxCall();
                            }
                            else if (strStatus == 'J') {

                                //$("#approvetaskmodal").modal("hide");

                                showAlert('Timesheet Rejected successfully.', 'alert-success', 'btnSave');
                                $("#rejectmodal").modal('hide');
                                //  window.open('../Email/SendEmail.aspx?MessageID=436&VerifiedBy=' + EmployeeID + '&ResourceID=' + ResourseID + '&FromDate=' + FromDate + '&ToDate=' + ToDate + '&TimesheetID=' + Tid + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=580');
                            }
                        }

                        //$("#approvetaskmodal").modal("hide");
                        ReloadData(EmployeeID);

                    },
                    error: function (err) {
                        console.log(err);
                        // StopAjaxLoader("#bodyTSApproval");
                    }
                })
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
            $('.ClosaeblealertMsg').delay(5000).fadeOut("fast", function () {
                if (id != undefined) {
                    $('#' + id).prop("disabled", false);
                }
            });
        }
        function CloseShowAlert() {
            $('.ClosaeblealertMsg').hide();
        }

        /*Added By Dipali V On 18th May 2023 For Loader Missing after version updated*/
        function StartLoader(bodyID) {

            var progress2 = new LoadingOverlayProgress({
                bar: {
                    "background": "#ddd",
                    "top": "50px",
                    "height": "30px",
                    "border-radius": "15px",
                    "background": " url('../../../Whizible2.0-new/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"
                },

            });
            $(bodyID).LoadingOverlay("show", {
                custom: progress2.Init()
            });
        }


        function StopAjaxLoader(bodyID) {
            // This gets executed when the content is loaded
            $(bodyID).LoadingOverlay("hide", {

            });

        }
        /*End of Added By Dipali V On 18th May 2023 For Loader Missing after version updated*/
    </script>
</body>

</html>
