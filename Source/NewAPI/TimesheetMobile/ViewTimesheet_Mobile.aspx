<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewTimesheet_Mobile.aspx.vb" Inherits="PbNIT.ViewTimesheet_Mobile" %>

<!DOCTYPE html>
<html>

<head>
<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("Weekly Timesheet")%> 
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Weekly Timesheet</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
 <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />--%>

    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/skins/_all-skins.min.css">


    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css">

    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=1.11">
 
    <style type="text/css">
        /*body{ overflow: hidden; }*/
        .statusNotSubmitted-text {
            color: #7f05c2;
        }
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
           /*End Of Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings*/

           /*Added By Dipali V On 18th May 2023 For UI Issues */
        #tdStatus {
            float:right!important;
        }

        #IdExpectedHours {
         
            width: 34%;
            margin-left: 16px;
        }

        #IdActualHours {
            width: 62%;
        }

        .tv_palnneddate {
            font-size: 16px;
            font-weight: 600!important;
        }

        .MvTv_hrs, .Mvmytimesheetviewtbl tr td:last-child {
            font-size: 16px;
            font-weight: 600!important;
        }
        .MvTv_hrs {
            float:right;
        }

        .col-xs-9 {
            width: 75%;
        }
        .col-xs-2 {
            width: 16.66666667%;
        }
         #CloseableAlert .close {
            float: right;
            border: none;
        }
         .col-xs-3 {
            width:25%;
        }

        .col-xs-1 {
            width: 8.33333333%;
        }
        .col-xs-10 {
            width: 83.33333333%;
        }
          .autoclosablemsg{ display:none;}
         
           #alertMsg {
            font-size: 13px;
            width: 295px;
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
         /*End of Added By Dipali V On 18th May 2023 For UI Issues */
        
    </style>

</head>

<body class="skin-blue-light sidebar-mini dashmain fixed" id="VTBody">
    <div class="responsivewarningmsg">
        <h2>Please check on 1280px and high Resolution</h2>
    </div>

    <div class="wrapper">
        <!-- Main Header -->
        <header class="main-header">

            <!-- Header Navbar -->
            <nav class="navbar navbar-static-top" role="navigation">

                <div class="mainheadingtop pull-center">
                    <a onclick="Back_Onclick()" class="backbtn MVbackbtn tab" id=""><i class="fas fa-chevron-left"></i></a>
                    &nbsp&nbsp Timesheet &gt; View
                </div>
                <%-- <a onclick="Back_Onclick()" class="backbtn MVbackbtn tab" id=""><i class="fas fa-chevron-left"></i></a>--%>
                <div class="mainheaderrighticons pull-right" id="divHeader" style="display: none;">
                    <button class="editviewaction" id="btnEdit" onclick="Edit_Onclick()"><i class="fas fa-pencil-alt"></i></button>
                    <button class="saveviewaction hidebtn"><i class="fas fa-save"></i></button>
                    <%--Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
                    <button class="" id="btnSubmit" style="display: none;" onclick="SubmitTS_OnClick_Confirmation_VT()"><i class="fas fa-check"></i></button>
                    <%--End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
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

                <div id="weeklytimeshhettemp" class="weeklytimesheetwrap hidden-desktop">
                    <div class="tab-content viewtimesheet_list">

                        <div class="container" style="display: none" id="DivHeaderTEntry">
                            <div class="row pt-1 pb-1 graybg">
                                <div class="col-xs-9 col-sm-8">
                                    <div class="weekly_calender" id="weeklyviewcal">
                                        <button title="Previous Week" id="prev"><i class="fas fa-caret-left"></i></button>
                                        <div class="input-group-box">
                                            <div class="input-group" id="DateDemo">
                                                <input title="Select Week date" class="form-control" type="text" id="weekPicker2" autocomplete="off" />
                                            </div>
                                        </div>
                                        <button id="next" title="Next Week"><i class="fas fa-caret-right"></i></button>

                                    </div>
                                </div>
                                <div class="col-xs-3 col-sm-4 text-right xs-pl-0">
                                    <label class="pt-1 nosubmittedlabel" id="lblStatus"></label>
                                </div>
                            </div>
                            <%--Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo (Timesheet status details toggle; same pattern as TimesheetEntry_Mobile.aspx)--%>
                            <div class="row pb-1 graybg">
                                <div class="col-xs-12" style="padding:6px 12px 0;font-size:11px;">
                                    <div class="d-flex justify-content-between align-items-center" style="cursor:pointer;" data-bs-toggle="collapse" data-bs-target="#vtTsStatusCollapse" aria-expanded="false">
                                        <span class="fw-bold">Timesheet status</span><i class="fas fa-chevron-down"></i>
                                    </div>
                                    <div class="collapse" id="vtTsStatusCollapse"><div id="txtStatus_VT" class="pt-1"></div></div>
                                </div>
                            </div>
                            <%--End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
                        </div>
                        <div class="timesheetrow container-fluid pt-1 pb-1 graybg mv_tadetailtop" style="display: none" id="DivHeaderTApproval">
                            <table width="100%">
                                <tr>
                                    <td id="tdEmployeeName"></td>
                                    <td class="text-center" id="tdPeriod">
                                        <br />
                                    </td>
                                  <%--  <td class="text-right" id="tdStatus">--%>
                                      <td class="text-right" id="tdStatus">
                                        <br />
                                        <%--  <div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn pull-right mt-onehalf">
                                            <div class="input-group">
                                                <button data-toggle="modal" data-target="#approvetaskmodal" class="btn btn-outline-secondary btn-success" type="button" data-original-title="" title=""><i class="fas fa-check"></i></button>
                                                <button data-toggle="modal" data-target="#rejectmodal" class="btn btn-outline-secondary btn-red" type="button" data-original-title="" title=""><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>--%>
                                    </td>
                                </tr>
                            </table>
                            <div class="clearfix"></div>
                        </div>
                        <div class="timesheetrow container-fluid pt-1">
                            <div class="row">
                                 <div class="col-md-6 col-sm-6 col-xs-7" id="IdActualHours">
                                    <div class="Mv_actualwork_hrs hidden-desktop">Actual Hours : <span id="ActualHours"></span>Hr</div>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-5 pull-right pl-0" id="IdExpectedHours">
                                    <div class="Mv_actualwork_hrs hidden-desktop">Expected : <span id="ExpectedHours"></span>Hr</div>
                                </div>
                               
                                <div class="clearfix"></div>
                            </div>
                        </div>

                        <!--timesheet table-->
                        <div class="container">
                            <div class="mobcusttble">

                                <div class="tbl-content" id="divWeekDays">
                                </div>
                            </div>

                            <!--timesheet table-->
                        </div>
                    </div>


                    <!--tabend-->

                </div>
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
        <!-- Control Sidebar -->

        <%--<div class="Mv_mobmenu hidden-desktop">

            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <li class="dropdown user user-menu">
                        <!-- Menu Toggle Button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <!-- hidden-xs hides the username on small devices so only the image appears. -->
                            <span class="hidden-xs">John Smith</span>
                            <!-- The user image in the navbar-->
                            <img src="dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
                        </a>
                        <ul class="dropdown-menu">
                            <!-- The user image in the menu -->
                            <li class="user-header">
                                <img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                                <p>
                                    John Smith - Web Developer
                                </p>
                            </li>
                            <!-- Menu Body -->
                            <!-- Menu Footer-->
                            <li class="user-footer">
                                <div class="text-center">
                                    <a href="#" class="btn btn-default btn-block">Profile</a>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <!-- search Menu -->
                    <li class="dropdown search-menu">
                        <!-- Menu toggle button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <img class="weeklycalender_icon" src="dist/img/Search-white.svg" alt="" width="20px">
                        </a>
                        <ul class="dropdown-menu">
                            <li class="header">Please search here</li>
                            <li>
                                <div class="input-group">
                                    <input type="text" class="form-control">
                                    <span class="input-group-btn">
                              <button class="btn btnyellow btn-flat" type="button">Search</button>
                              </span>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <!-- setting Menu -->
                    <li class="dropdown setting-menu">
                        <!-- Menu toggle button -->
                        <a href="#" data-toggle="control-sidebar" class="dropdown-toggle" data-toggle="dropdown">
                            <img class="weeklycalender_icon" src="dist/img/Setting-white.svg" alt="" width="20px">
                        </a>
                    </li>
                    <!-- Notifications Menu -->
                    <li class="dropdown notifications-menu">
                        <!-- Menu toggle button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="far"><img class="weeklycalender_icon" src="dist/img/bell-white.svg" alt="" width="20px"></i>
                            <span class="label label-warning">10</span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="header">You have 10 notifications</li>
                            <li>
                                <!-- Inner Menu: contains the notifications -->
                                <ul class="menu">
                                    <li>
                                        <!-- start notification -->
                                        <a href="#">
                                            <i class="fa fa-users text-aqua"></i> 5 new members joined today
                                        </a>
                                    </li>
                                    <!-- end notification -->
                                </ul>
                            </li>
                            <li class="footer"><a href="#">View all</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#"><img class="weeklycalender_icon" src="dist/img/logout-white.svg" alt="" width="20px"></a>
                    </li>
                </ul>
            </div>

            <div class="clearfix"></div>
            <ul class="sidebar-menu">
                <!-- Optionally, you can add icons to the links -->
                <li><a href="#"><i class="fa"><img src="dist/img/Home.svg" alt="" width="44px"></i> <span>Dashboard</span></a></li>
                <li><a href="#"><i class="fa"><img src="dist/img/Projects.svg" alt="" width="44px"></i> <span>Projects</span></a></li>
                <li class="active"><a href="#"><i class="fa"><img src="dist/img/Timesheet.svg" alt="" width="44px"></i><span>Timesheet</span></a></li>
                <li><a href="#"><i class="fa"><img src="dist/img/issues.svg" alt="" width="44px"></i> <span>Issues</span></a></li>
                <li><a href="#"><i class="fa"><img src="dist/img/MIS.svg" alt="" width="44px"></i> <span>MIS</span></a></li>
                <li><a href="#"><i class="fa"><img src="dist/img/Help-desk.svg" alt="" width="44px"></i> <span>Help desk</span></a></li>
                <li class="Mmenulogo"><a href="#"><i class="fa">&nbsp;</i> <span><img src="dist/img/mobmenu/whisible.svg" alt="" width="60px"></span></a></li>
            </ul>
        </div>--%>



        <!-- /.control-sidebar -->

    </div>


    <!-- Modal -->
    <div id="viewtimesheet_infomodal" class="modal fade custmodal" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
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

    <!--rejectmodal-->
    <div id="rejectmodal" class="modal fade custmodal rejectmodal" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Reject Timesheet</h4>

                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                              <%--  <div class="col-xs-12 col-sm-4 text-right">Reason for rejection:</div>--%>
                                          <div class="col-xs-12 col-sm-4 text-left">Reason for rejection:</div>
                                          <%--End of   Added & Commented Dipali V On 28th May 2019--%>
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

                                        <div class="custom_chckbox">
                                            <%--Commented And Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings--%>  
                                            <%--<input type="checkbox" id="rejectmodalcheckbox">
                                            <label for="rejectmodalcheckbox">Allow resource to change timesheet and resubmit</label>--%>
                                            <input type="checkbox" id="rejectmodalcheckbox" class ="clsHide">
                                            <label class ="clsHide" for="rejectmodalcheckbox">Allow resource to change timesheet and resubmit</label>
                                            <span id ="allowoverridenote" style="font-weight:700;"></span>
                                            <%--End Of Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings--%>  
                                        </div>

                                    </div>
                                    <div class="col-xs-2 col-sm-4"></div>
                                </div>

                            </div>
                        </div>
                    </div>


                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-left" style="width:62%!important">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                            </div>
                            <div class="col-xs-6 col-sm-6" style="width:32%!important">
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
    <%--Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
    <div id="submitTSModal_VT" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-bs-focus="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Submit timesheet</h4>
                </div>
                <div class="modal-body">
                    <div id="txtStatus_TSModal_VT" class="mb-2" style="font-size:11px;max-height:120px;overflow:auto;"></div> 
                    <div class="row mb-2 align-items-center">
                        <div class="col-4">
                            <label class="form-label mb-0">From Date</label>
                        </div>
                        <div class="col-8">
                            <div class="input-group">
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtTSModalStartDate_VT", "txtTSModalStartDate_VT", "form-control", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                                <span class="input-group-text">
                                    <i class="fas fa-calendar-alt"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <div class="col-4">
                            <label class="form-label mb-0">To Date</label>
                        </div>
                        <div class="col-8">
                            <div class="input-group">
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtTSModalEndDate_VT", "txtTSModalEndDate_VT", "form-control", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                                <span class="input-group-text">
                                    <i class="fas fa-calendar-alt"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="mt-2 text-muted" style="font-size: 11px;">Selected Range: <span id="lblSelectedRange_VT"></span></div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="btnSubmitTimesheet_VT" class="btn btnyellow" onclick="SubmitTS_OnClick_FlexibleVT();">Submit</button>
                    <button type="button" class="btn borderbtn" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <%--End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>

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
                           <%-- Added By Dipali V On 28th May 2019--%>
                          <%--  <div class="col-xs-12 col-sm-4 text-right">Comment:</div>--%>
                            <div class="col-xs-12 col-sm-4 text-left">Comment:</div>
                            <%-- End of Added By Dipali V On 28th May 2019--%>
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
                            <div class="col-xs-6 col-sm-6 text-left"  style="width:62%!important">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                            </div>
                            <div class="col-xs-6 col-sm-6"  style="width:32%!important">
                                <button class="btn btnyellow ml-1 pull-right" onclick="ApproveAllTimesheet()">Approve</button>
                            </div>
                        </div>
                    </div>


                </div>


            </div>
        </div>
        <div class="clearfix"></div>
    </div>
  
      <%-- <script src="../../../Whizible2.0/plugins/jQuery/jquery-migrate-3.3.2.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
    <script src="../../General/CommonValidations.js"></script>
    <!-- Commented and Added by Vishal Mane on 30/12/2025 for version upgrade of moment.js for W26 --> 
    <%--<script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/moment-2.30.1.js"></script>
    <!-- End of Commented and Added by Vishal Mane on 30/12/2025 for version upgrade of moment.js for W26 -->
     <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>

    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
   
   
    <script src="../../../Whizible2.0-new/dist/js/custom_mobile.js"></script>
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
                    //alert(startingDayOfWeek);
                }
            },
            error: function (err) {
                console.log(err);
            }
        });
        var isWeeklyView = 1;
    </script>
     <!--weekpicker-->
    <%--Added and commented by Vishal Mane on 13/05/2026 to fix timezone issue--%>
    <%--<script type="text/javascript" src="../../../Whizible2.0-new/dist/js/weekPicker.js?v=1.7"></script>--%>
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/weekPickerNew.js?date=<%=DateTime.Now %>"></script>
    <%--End of Added and commented by Vishal Mane on 13/05/2026 to fix timezone issue--%>
    <script type="text/javascript">
        //Mobile Menu
        /*  $('#Mmenu_togglebtn').click(function () {
        $('.Mv_mobmenu').toggleClass('Mv_mobmenu_open animated fadeInUp');

         });
        */

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var EmployeeID;
        var UserName;
        EmployeeID = '<%= Session("intUserID") %>';
        //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
        var TSSubmissionDetails_VT = [];
        var Global_oldStartDate_VT = "";
        var Global_oldEndDate_VT = "";
        //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo

        $('#next').click(function () {
            //debugger;
            // startingDayOfWeek = 4;
            //Added and commented by Vishal Mane on 13/05/2026 to fix timezone issue
            //setWeekCalendar($('#weekPicker2'), 'next', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("dtFromDate")%>'));

            var dt = GlobalFromDate;
            dt.setDate(dt.getDate() + 7);
            GlobalFromDate = dt;

            setWeekCalendarMobile($('#weekPicker2'), 'next', 1, startingDayOfWeek, dt);
            //End of Added and commented by Vishal Mane on 13/05/2026 to fix timezone issue

            TimesheetID = 0;
            GetTimesheetStatus(EmployeeID);
            ReloadData(EmployeeID);

        });
        $('#prev').click(function () {
            //Added and commented by Vishal Mane on 13/05/2026 to fix timezone issue
            //setWeekCalendar($('#weekPicker2'), 'prev', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("dtFromDate")%>'));

            var dt = GlobalFromDate;
            dt.setDate(dt.getDate() - 7);
            GlobalFromDate = dt;
            setWeekCalendarMobile($('#weekPicker2'), 'prev', 1, startingDayOfWeek, dt);
            //End of Added and commented by Vishal Mane on 13/05/2026 to fix timezone issue



            TimesheetID = 0;
            GetTimesheetStatus(EmployeeID);
            ReloadData(EmployeeID);
            //alert(TimesheetID);
        });
        var PageFlag = 0;
        var TimesheetID = 0;
        var ViewTimesheetPageLoad = 0;
        //Added By Usha Pandit On 11.03.2021 For Note regarding efforts change
        var actualHoursSum = 0.0;
        var updatedAllTotal = 0.0;
        var curStatus = '';
        //Added and commented by Vishal Mane on 13/05/2026 to fix timezone issue
        var GlobalFromDate;
        //End of Added and commented by Vishal Mane on 13/05/2026 to fix timezone issue
        //End Of Added By Usha Pandit On 11.03.2021 For Note regarding efforts change
        $(document).ready(function () {
            //debugger;
         <%--   alert('<%= Request.QueryString("dtFromDate")%>');--%>
            PageFlag = ('<%= Request.QueryString("PageFlag")%>' - 0);
            ViewTimesheetPageLoad = ('<%= Request.QueryString("ViewTimesheetPageLoad")%>' - 0);
            TimesheetID = ('<%= Request.QueryString("intTimesheetID")%>' - 0);
           
            //Added By Usha Pandit On 11.03.2021 For Note regarding efforts change
            <%--actualHoursSum = ('<%= Request.QueryString("ActualHours")%>');
            
            if (actualHoursSum != "") {
                var RequestParameters = {
                    WorkHrs: encodeURI(actualHoursSum),
                    Flag: encodeURI(2),
                }
                var param = JSON.stringify(RequestParameters);
                actualHoursSum = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
            }--%>
            //End Of Added By Usha Pandit On 11.03.2021 For Note regarding efforts change

            //Added and commented by Vishal Mane on 13/05/2026 to fix timezone issue
            var qsFrom = '<%= Request.QueryString("dtFromDate")%>'.trim();
            var dt = parseDateAsLocalCalendar(qsFrom) || parseDateAsLocalCalendar(new Date());
            //setWeekCalendar($('#weekPicker2'), 'Selected', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("dtFromDate")%>'));
            setWeekCalendarMobile($('#weekPicker2'), 'Selected', 1, startingDayOfWeek, dt);
            GlobalFromDate = dt;
            //End of Added and commented by Vishal Mane on 13/05/2026 to fix timezone issue
            if (PageFlag == 2 || PageFlag == 1) {

                $("#DivHeaderTEntry").css("display", "block");
                $("#divHeader").css("display", "block");
            }
            else if (PageFlag == 3) {

                $("#DivHeaderTApproval").css("display", "block");
            }

            GetTimesheetStatus(EmployeeID);
            ReloadData(EmployeeID);
              //Added By Dipali V On 6th Jan 2020 For Filter Issues
            AfterResponsivePlot();
            //End of Added By Dipali V On 6th Jan 2020 For Filter Issues
            //Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
            globalOverrideTSCheck = getCorporateOverrideTSCheck();
            var AllowToResubmitCheck = getCorporateAllowToResubmitCheck(); 
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
            //End Of Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
        });
        $("#weekPicker2").change(function () {
            TimesheetID = 0;
            GetTimesheetStatus(EmployeeID);
            ReloadData(EmployeeID);
        });
        //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
        
        $('#txtTSModalStartDate_VT, #txtTSModalEndDate_VT').datepicker({
            autoclose: true,
            changeMonth: true,
            dateFormat: 'dd M yy'
        });

        $("#txtTSModalStartDate_VT").on("change", function () {
            var previous = Global_oldStartDate_VT;
            if (validateFlexibleTS_VT()) {
                Global_oldStartDate_VT = $("#txtTSModalStartDate_VT").val();
                Global_oldEndDate_VT = $("#txtTSModalEndDate_VT").val();
                $("#lblSelectedRange_VT").text(Global_oldStartDate_VT + " - " + Global_oldEndDate_VT);
            } else {
                $("#txtTSModalStartDate_VT").val(previous);
            }
        });
        $("#txtTSModalEndDate_VT").on("change", function () {
            var previous = Global_oldEndDate_VT;
            if (validateFlexibleTS_VT()) {
                Global_oldStartDate_VT = $("#txtTSModalStartDate_VT").val();
                Global_oldEndDate_VT = $("#txtTSModalEndDate_VT").val();
                $("#lblSelectedRange_VT").text(Global_oldStartDate_VT + " - " + Global_oldEndDate_VT);
            } else {
                $("#txtTSModalEndDate_VT").val(previous);
            }
        });
        //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
        var EmployeeName = "";
        //Added By Usha Pandit On 11.03.2021 For Note regarding efforts change
        function AJAXCallWithResult(url, param, async) {

            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
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
        //Added By Usha Pandit On 11.03.2021 For Note regarding efforts change
        function GetTimesheetStatus(ProxyResourceID) {
            //debugger;
            if (TimesheetID == 0) {
                var taskParameters = {
                    dtFromDate: weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                    dtToDate: weekPickerAttrToLocalDate($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                    intEmployeeID: EmployeeID,
                }
            }
            else {
                if (PageFlag == 2 || PageFlag == 1) {
                    var taskParameters = {
                        dtFromDate: weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                        dtToDate: weekPickerAttrToLocalDate($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                        intEmployeeID: EmployeeID,
                        intTimesheetID: TimesheetID,
                        PageFlag: PageFlag,
                    }
                }
                else {
                    var taskParameters = {
                        dtFromDate: '<%= Request.QueryString("dtFromDate")%>',
                        dtToDate: '<%= Request.QueryString("dtToDate")%>',
                        intEmployeeID: '<%= Request.QueryString("intEmployeeID")%>',
                        intTimesheetID: TimesheetID,
                        PageFlag: PageFlag,
                        intApproverID: EmployeeID
                    }
                }
            }
            $.ajax({
                url: strUrl + '/api/TimesheetApprovalDetail/GetTimesheetStatus_MV',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                    }
                },
                success: function (data) {
                    //debugger;
                    if (data.length == 0) {
                        //$("#lblStatus").html("Not Submitted");
                        $("#btnSubmit").css('display', 'inline-block');
                        $("#btnEdit").css('display', 'inline-block');
                    }
                    else {
                        if (data[0].Status == "Ready for approval") {
                            //$("#lblStatus").html("Submitted");
                        }
                        else {
                            //$("#lblStatus").html(data[0].Status);
                        }
                        //Added By Usha Pandit On 11.03.2021 For Note regarding efforts change   
                        curStatus = data[0].Status;
                        actualHoursSum = data[0].ActualHours;
                        ///Added By Dipali v On 18th March 2021 For Crash Issue
                        if (actualHoursSum != "" && actualHoursSum.indexOf(':') != -1) {
                            ///End of Added By Dipali v On 18th March 2021 For Crash Issue
                            if (actualHoursSum != "") {
                                var RequestParameters = {
                                    WorkHrs: encodeURI(actualHoursSum),
                                    Flag: encodeURI(2),
                                }
                                var param = JSON.stringify(RequestParameters);
                                actualHoursSum = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                            }
                        }
                        //End Of Added By Usha Pandit On 11.03.2021 For Note regarding efforts change   
                        //if (data[0].Status == "Rejected" || $("#lblStatus").html() == "Not Submitted") {
                        if (data[0].Status == "Rejected") {
                            $("#btnSubmit").css('display', 'inline-block');
                            $("#btnEdit").css('display', 'inline-block');
                        }
                        else {
                            $("#btnSubmit").css('display', 'none');
                            $("#btnEdit").css('display', 'none');
                        }
                        if (PageFlag == 3) {
                            var strHTML = "";

                            EmployeeName = data[0].EmployeeName;
                            $("#tdEmployeeName").html(EmployeeName);
                            //debugger;
                            if (data[0].Status == "Ready for approval") {
                                strHTML += "Submitted <br />";
                            }
                            else {
                                strHTML += "" + data[0].Status + "<br />";
                            }

                            if (data[0].Status != "Rejected") {
                                strHTML += '<div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn pull-right mt-onehalf">';
                                strHTML += '<div class="input-group">';
                                if (data[0].Status != "Approved") {
                                    strHTML += '<button data-bs-toggle="modal" data-bs-target="#approvetaskmodal" onclick="ApproveTimesheet()" class="btn btn-outline-secondary btn-success" type="button" data-original-title="" title=""><i class="fas fa-check"></i></button>';
                                }
                                strHTML += '<button data-bs-toggle="modal" data-bs-target="#rejectmodal" onclick="RejectTimesheet()" class="btn btn-outline-secondary btn-red" type="button" data-original-title="" title=""><i class="fas fa-times"></i></button>';

                                strHTML += '</div>';
                                strHTML += '</div>';
                            }
                            $("#tdStatus").html(strHTML);

                        }
                    }
                    //PlotWeekDays(data);
                    //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                    if (PageFlag != 3 && $("#weekPicker2").length && $("#weekPicker2").attr("StartDate")) {
                        GetTimeSheetWeekHeaderDetailsViewMobile();
                    }
                    //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        var strUrlMobile = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Timesheet").ToString%>';
        function ReloadData(ProxyResourceID) {
            //debugger;
            if (ProxyResourceID == 0)
                ProxyResourceID = EmployeeID;
            else
                EmployeeID = ProxyResourceID;
            if (PageFlag == 3) {
                if (TimesheetID != 0) {
                    var taskParameters = {
                        dtFromDate: '<%= Request.QueryString("dtFromDate")%>',
                        dtToDate:'<%= Request.QueryString("dtToDate")%>',
                        intEmployeeID: '<%= Request.QueryString("intEmployeeID")%>',
                        intTimesheetID: TimesheetID
                    }
                }
                else {
                    var taskParameters = {
                        dtFromDate:'<%= Request.QueryString("dtFromDate")%>',
                        dtToDate: '<%= Request.QueryString("dtToDate")%>',
                        intEmployeeID: '<%= Request.QueryString("intEmployeeID")%>',
                    }
                }
            }
            else {
                var taskParameters = {
                    dtFromDate: weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                    dtToDate: weekPickerAttrToLocalDate($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                    intEmployeeID: EmployeeID,
                    intTimesheetID: TimesheetID,
                    ViewTimesheetPageLoad: ViewTimesheetPageLoad//Added By DipalI V on 22 may 2023
                   
                }
            }
            StartLoader("#VTBody");
            $.ajax({
                //Added by Vishal Mane on 18/11/2025 to display site holiday in red color for Expleo Customization
                //url: strUrl + '/api/Timesheet/BindWeekDays',
                url: strUrlMobile + '/api/TimesheetEntryNew/BindWeekDays',
                //End of Added by Vishal Mane on 18/11/2025 to display site holiday in red color for Expleo Customization
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    //Added by Vishal Mane on 18/11/2025 to display site holiday in red color for Expleo Customization
                    //xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    //End of Added by Vishal Mane on 18/11/2025 to display site holiday in red color for Expleo Customization
                    if (taskParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                    }
                },
                success: function (data) {
                    //debugger;
                    PlotWeekDays(data);

                    //Added By Usha Pandit On 15.03.2021 For Resubmit Note display issue
                    if (curStatus == "") {
                        curStatus = $("#lblStatus").html();
                    }                    
                    
                    <%--if ('<%= Request.QueryString("ActualHours")%>' == "") {
                        
                        if (actualHoursSum != "") {
                            var RequestParameters = {
                                WorkHrs: encodeURI(actualHoursSum),
                                Flag: encodeURI(2),
                            }
                            var param = JSON.stringify(RequestParameters);
                            actualHoursSum = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);                            
                        }
                    }--%>
                    
                    if (updatedAllTotal != actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("EmployeeID")%>' != "") {
                        //Commented And Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                        //$("#lblStatus").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b>Actual hours are changed,Please re-submit the Timesheet.<span>");
                        $("#lblStatus").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b>For any changes in Timesheet details, Timesheet should be Re-Submitted.<span>");
                        //End Of Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                    }
                    else if (updatedAllTotal == actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("EmployeeID")%>' != "") {
                        //Commented And Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                        //$("#lblStatus").html(curStatus);
                        $("#lblStatus").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b>For any changes in Timesheet details, Timesheet should be Re-Submitted.<span>");
                        //End Of Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                    }
                    if (updatedAllTotal != actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("intEmployeeID")%>' != "") {
                        //Commented By Usha Pandit On 17.05.2021 For generic note given for rejected timesheet
                        //$("#lblStatus").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b> User has modified this timesheet effort<span>");
                        //Commented By Usha Pandit On 17.05.2021 For generic note given for rejected timesheet
                    }
                    else if (updatedAllTotal == actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("intEmployeeID")%>' != "") {
                        $("#lblStatus").html(curStatus);
                    }
                    //End Of Added By Usha Pandit On 15.03.2021 For Resubmit Note display issue                   
                
                    StopAjaxLoader("#VTBody");
                },
                error: function (err) {
                    console.log(err);
                    StopAjaxLoader("#VTBody");
                }
            });
        }
        function PlotWeekDays(WeekDaysList) {
            //debugger;
            var strHTML = "";
            var Period = "";
            var strMonthName = "";
            var strYear = "";
            $("#divWeekDays").html(strHTML);
            for (var i = 0; i < WeekDaysList.length; i++) {
                var weekDays = WeekDaysList[i];
                var Total = weekDays.Total;
                var EntryDate = weekDays.EntryDate;
                var Day = weekDays.Day;
                var DayName = weekDays.DayName;
                var Year = weekDays.Year;
                var MonthName = weekDays.MonthName;
                var AllTotal = weekDays.AllTotal;
                var ExpectedHours = weekDays.ExpectedHours;
                var CurrentDate = weekDays.CurrentDate;
                var displayPeriod = weekDays.Period;
                //Added by Chetan M on 12 March 2021 for conversion of work hour 7.60 to 8
                var precision = Total.split(".")[1];
                if (precision == 60) {
                    Total = (Total.split(".")[0] - 0) + 1;
                }
                //End of Added by Chetan M on 12 March 2021 for conversion of work hour 7.60 to 8
                strHTML += '<div class="timesheetentrycard">';
                strHTML += '<table class="table">';
                strHTML += '<tbody>';
                strHTML += '<tr>';
                strHTML += '<td class="col-xs-9">';
                strHTML += '<div class="tv_palnneddate">' + DayName + ', ' + Day + '<span>' + MonthName + ' ' + Year + '</span></div>';
                strHTML += '</td>';
                strHTML += '<td class="col-xs-2 text-right">';
                strHTML += '<div class="MvTv_hrs">';
                strHTML += '' + ConvertToDecimal(Total) + '';
                strHTML += '<br/>Hr';
                strHTML += '</div>';
                strHTML += '</td>';
                 //Added By Dipali V On 20th Feb 2021 For Actual Hr Missing
               // strHTML += '<td class="col-xs-1"><i id="mvViewtimesheetdetail" onclick=OpenTDetailPage("' + CurrentDate + '") class="fas fa-angle-right tab"></i></td>';
             strHTML += '<td class="col-xs-1"><i id="mvViewtimesheetdetail" onclick=OpenTDetailPage("' + CurrentDate + '","' + ConvertToDecimal(AllTotal) +'") class="fas fa-angle-right tab"></i></td>';
                //End of Added By Dipali V On 20th Feb 2021 For Actual Hr Missing
                strHTML += '</tr>';
                strHTML += '</tbody>';
                strHTML += '</table>';
                strHTML += '</div>';
                //debugger;
                if (i == 0) {
                    Period += "" + Day + " - ";
                }
                if (i == 6) {
                    Period += "" + Day + "";
                }
                strMonthName = MonthName;
                strYear = Year;
                $("#ExpectedHours").html("" + ConvertToDecimal(ExpectedHours) + "");
                //Added by Chetan M on 12 March 2021 for conversion of work hour 7.60 to 8                
                var precision = AllTotal.split(".")[1];
                if (precision == 60) {
                    AllTotal = (AllTotal.split(".")[0] - 0) + 1;
                }
                //End of Added by Chetan M on 12 March 2021 for conversion of work hour 7.60 to 8
                $("#ActualHours").html("" + ConvertToDecimal(AllTotal) + "");
                //Added By Usha Pandit On 11.03.2021 For Note regarding efforts change                                
                updatedAllTotal = ConvertToDecimal(AllTotal);
                var RequestParameters = {
                    WorkHrs: encodeURI(updatedAllTotal),
                    Flag: encodeURI(2),
                }
                var param = JSON.stringify(RequestParameters);
                updatedAllTotal = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                <%--if ('<%= Request.QueryString("ActualHours")%>' != "") {--%>
                if (updatedAllTotal != actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("EmployeeID")%>' != "") {
                    //Commented And Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                    //$("#lblStatus").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b>Actual hours are changed,Please re-submit the Timesheet.<span>");
                    $("#lblStatus").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b>For any changes in Timesheet details, Timesheet should be Re-Submitted.<span>");
                    //End Of Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                }
                else if (updatedAllTotal == actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("EmployeeID")%>' != "") {
                    //Commented And Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                    //$("#lblStatus").html(curStatus);
                    $("#lblStatus").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b>For any changes in Timesheet details, Timesheet should be Re-Submitted.<span>");
                    //End Of Added By Usha Pandit On 12.05.2021 For generic note given for rejected timesheet
                }
                if (updatedAllTotal != actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("intEmployeeID")%>' != "") {
                        //Commented By Usha Pandit On 17.05.2021 For generic note given for rejected timesheet
                        //$("#lblStatus").html(curStatus + "<span style='color: red !important;'><br><b> Note:</b> User has modified this timesheet effort<span>");
                        //Commented By Usha Pandit On 17.05.2021 For generic note given for rejected timesheet
                    }
                    else if (updatedAllTotal == actualHoursSum && curStatus == "Rejected" && '<%= Request.QueryString("intEmployeeID")%>' != "") {
                        $("#lblStatus").html(curStatus);
                    }
                //}
                //End Of Added By Usha Pandit On 11.03.2021 For Note regarding efforts change

                if ($("#ActualHours").html() == "00:00") {
                    $("#btnSubmit").css('display', 'none');
                    $("#btnEdit").css('display', 'none');
                }
            }

            $("#divWeekDays").html(strHTML);
            if (PageFlag == 3) {
                $("#tdPeriod").html(displayPeriod);

            }
        }

        //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
        function formatTime_VT(value) {
            if (!value) return '00:00';
            value = value.toString().replace('.', ':');
            var parts = value.split(':');
            if (parts.length === 1) parts.push('00');
            return parts[0].padStart(2, '0') + ':' + parts[1].padEnd(2, '0').slice(0, 2);
        }
        function normalizeDate_VT(d) { return new Date(d.getFullYear(), d.getMonth(), d.getDate()); }
        function formatDDMMMYYYY_VT(date) {
            var d = new Date(date);
            return d.getDate() + " " + d.toLocaleString("en-US", { month: "short" }) + " " + d.getFullYear();
        }

        //Commented and added by Vishal Mane on 12/05/2026 to fix Timezone issue
        //function convertToAPIDate_VT(dateStr) {
        //    var parts = dateStr.split(" ");
        //    if (parts.length < 3) return dateStr;
        //    var dateObj = new Date(parts[0] + " " + parts[1] + " " + parts[2]);
        //    return dateObj.toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });
        //}

        function convertToAPIDate_VT(dateStr) {
            var parts = dateStr.split(" "); // ["16", "Mar", "2026"]
            var day = parseInt(parts[0]);
            var monthStr = parts[1];
            var year = parseInt(parts[2]);
            var monthMap = {
                Jan: 0, Feb: 1, Mar: 2, Apr: 3,
                May: 4, Jun: 5, Jul: 6, Aug: 7,
                Sep: 8, Oct: 9, Nov: 10, Dec: 11
            };
            var month = monthMap[monthStr];
            // Create LOCAL date (no timezone shift)
            var dateObj = new Date(year, month, day);
            return dateObj.toLocaleDateString("en-US");
        }

        //Commented and added by Vishal Mane on 12/05/2026 to fix Timezone issue

        function GetTimeSheetWeekHeaderDetailsViewMobile() {
            if (!$("#weekPicker2").length || !$("#weekPicker2").attr("StartDate")) {
                TSSubmissionDetails_VT = [];
                bindStatusDiv_VT();
                return;
            }
            //Commented and added by Vishal Mane on 12/05/2026 to fix Timezone issue
            //var dtFrom = weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });
            var dtFrom = weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US");
            //var dtTo = weekPickerAttrToLocalDate($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });
            var dtTo = weekPickerAttrToLocalDate($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US");
            //End of Commented and added by Vishal Mane on 12/05/2026 to fix Timezone issue
            var taskParameters = { intEmployeeID: EmployeeID, dtFromDate: dtFrom, dtToDate: dtTo };
            var Result = AJAXCallWithResultMobile("/api/TimesheetEntryNew/GetTimeSheetWeekHeaderDetails", JSON.stringify(taskParameters), false);
            if (!Result) {
                TSSubmissionDetails_VT = [];
                bindStatusDiv_VT();
                return;
            }
            TSSubmissionDetails_VT = Result["TimeSheetWeekHeader2"] || [];
            if (!$.isArray(TSSubmissionDetails_VT)) TSSubmissionDetails_VT = [];
            var te = Result["TimeSheetWeekHeader1"];
            if (te && te.length > 0) {
                var allRej = TSSubmissionDetails_VT.some(function (x) { return (x.Status || "").toLowerCase() === "rejected"; });
                var allSub = !TSSubmissionDetails_VT.some(function (x) { return (x.Status || "").toLowerCase() === "not submitted"; });
                if (allRej && te[0].Status === "Rejected") $("#btnSubmitTimesheet_VT").text("Re-Submit");
                else $("#btnSubmitTimesheet_VT").text("Submit");
            }
            bindStatusDiv_VT();
        }
        //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo (inline status table; pairs with collapse #vtTsStatusCollapse, same behaviour as TimesheetEntry_Mobile bindStatusDivMobile)
        function bindStatusDiv_VT() {
            //debugger
            var container = $("#txtStatus_VT");
            if (!container.length) return;
            container.html("");
            var html = '<div class="ts-status-wrapper"><div class="row fw-bold border-bottom pb-1 mb-1"><div class="col-4 text-center">Status</div><div class="col-4 text-center">From</div><div class="col-4 text-center">To</div></div>';
            if (TSSubmissionDetails_VT && TSSubmissionDetails_VT.length > 0) {
                TSSubmissionDetails_VT.forEach(function (item) {
                    var st = (item.Status || "").toLowerCase();
                    //var cls = st === "approved" ? "text-success" : (st === "rejected" ? "text-danger" : (st === "submitted" ? "text-primary" : ""));
                    var cls = st === "not submitted" ? "statusNotSubmitted-text" : st === "approved" ? "text-success" : (st === "rejected" ? "text-danger" : (st === "submitted" ? "text-primary" : ""));
                    html += '<div class="row mb-1"><div class="col-4 text-center ' + cls + '">' + (item.Status || "") + '</div><div class="col-4 text-center">' + (item.FromDate || "") + '</div><div class="col-4 text-center">' + (item.ToDate || "") + '</div></div>';
                });
            } else {
                html += '<div class="text-muted">No status periods for this week.</div>';
            }
            html += '</div>';
            container.html(html);
        }
        //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
        function getStatusForDate_VT(date) {
            if (!TSSubmissionDetails_VT.length) return null;
            for (var i = 0; i < TSSubmissionDetails_VT.length; i++) {
                var item = TSSubmissionDetails_VT[i];
                var from = normalizeDate_VT(new Date(item.FromDate));
                var to = normalizeDate_VT(new Date(item.ToDate));
                if (date >= from && date <= to) return item;
            }
            return null;
        }
        function validateRejectedExactMatch_VT(startDate, endDate) {
            for (var i = 0; i < TSSubmissionDetails_VT.length; i++) {
                var item = TSSubmissionDetails_VT[i];
                if ((item.Status || "").toLowerCase() !== "rejected") continue;
                var from = normalizeDate_VT(new Date(item.FromDate));
                var to = normalizeDate_VT(new Date(item.ToDate));
                if (startDate.getTime() === from.getTime() && endDate.getTime() === to.getTime()) return true;
            }
            return false;
        }
        function validateTimesheetSubmission_VT() {
            var startInput = $("#txtTSModalStartDate_VT").val();
            var endInput = $("#txtTSModalEndDate_VT").val();
            if (!startInput || !endInput) {
                showAlert("Please select valid date range.", 'alert-danger');
                return false;
            }
            var startDate = normalizeDate_VT(new Date(startInput));
            var endDate = normalizeDate_VT(new Date(endInput));
            for (var d = new Date(startDate); d <= endDate; d.setDate(d.getDate() + 1)) {
                var currentDay = normalizeDate_VT(new Date(d));
                var statusObj = getStatusForDate_VT(currentDay);
                if (!statusObj) continue;
                var status = (statusObj.Status || "").toLowerCase();
                if (status === "approved") {
                    //showAlert("The timesheet is already approved for " + statusObj.FromDate + " to " + statusObj.ToDate + ". Adjust the range.", 'alert-danger');
                    showAlert("The timesheet is already approved for the period " + statusObj.FromDate + " to " + statusObj.ToDate + ". Please adjust the selected date range to exclude approved dates and try again.", 'alert-danger');
                    return false;
                }
                if (status === "submitted" || status === "pending") {
                    //showAlert("Timesheet already submitted for " + statusObj.FromDate + " to " + statusObj.ToDate + ".", 'alert-danger');
                    showAlert("Timesheet is already submitted for the period " + statusObj.FromDate + " to " + statusObj.ToDate + ". Please adjust the selected date range to exclude submitted dates and try again.", 'alert-danger');
                    return false;
                }
                var rejectedPeriods = TSSubmissionDetails_VT.filter(function (x) { return (x.Status || "").toLowerCase() === "rejected"; });
                for (var j = 0; j < rejectedPeriods.length; j++) {
                    var item = rejectedPeriods[j];
                    var from = normalizeDate_VT(new Date(item.FromDate));
                    var to = normalizeDate_VT(new Date(item.ToDate));
                    if (startDate.getTime() === from.getTime() && endDate.getTime() === to.getTime()) break;
                    if (startDate <= to && endDate >= from) {
                        //showAlert("Re-Submission allowed only for exact rejected period (" + item.FromDate + " to " + item.ToDate + ").", 'alert-danger');
                        showAlert("Timesheet Re-Submission is allowed only for the exact rejected period (" + item.FromDate + " to " + item.ToDate + "). Please select the complete rejected range and try again.", 'alert-danger');
                        return false;
                    }
                }
            }
            var hasRejectedInRange = false;
            for (var k = 0; k < TSSubmissionDetails_VT.length; k++) {
                var it = TSSubmissionDetails_VT[k];
                if ((it.Status || "").toLowerCase() === "rejected") {
                    var f = normalizeDate_VT(new Date(it.FromDate));
                    var t = normalizeDate_VT(new Date(it.ToDate));
                    if (startDate >= f && endDate <= t) hasRejectedInRange = true;
                }
            }
            if (hasRejectedInRange && !validateRejectedExactMatch_VT(startDate, endDate)) {
                showAlert("Resubmission is allowed only for the exact rejected period.", 'alert-danger');
                return false;
            }
            return true;
        }

        function formatDDMMMYYYY_Mobile(date) {
            var d = new Date(date);
            var day = d.getDate();
            var month = d.toLocaleString("en-US", { month: "short" });
            var year = d.getFullYear();
            return day + " " + month + " " + year;
        }

        function validateFlexibleTS_VT() {
            var startInput = $("#txtTSModalStartDate_VT").val();
            var endInput = $("#txtTSModalEndDate_VT").val();
            var start = normalizeDate_VT(weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate")));
            var end = normalizeDate_VT(weekPickerAttrToLocalDate($("#weekPicker2").attr("EndDate")));
            var selectedDate = parseDateAsLocalCalendar($("#weekPicker2").attr("SelectedDate")) || weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate"));
            selectedDate = normalizeDate_VT(selectedDate);
            var isCrossMonth = start.getMonth() !== end.getMonth() || start.getFullYear() !== end.getFullYear();
            var finalStart, finalEnd;
            if (!isCrossMonth) { finalStart = start; finalEnd = end; }
            else if (selectedDate.getMonth() === start.getMonth() && selectedDate.getFullYear() === start.getFullYear()) {
                finalStart = start; finalEnd = new Date(start.getFullYear(), start.getMonth() + 1, 0);
            } else {
                finalStart = new Date(end.getFullYear(), end.getMonth(), 1); finalEnd = end;
            }
            var dtFromDate = normalizeDate_VT(finalStart);
            var dtToDate = normalizeDate_VT(finalEnd);
            var startDate = normalizeDate_VT(new Date(startInput));
            var endDate = normalizeDate_VT(new Date(endInput));
            //if (!startInput) { showAlert("Please select Start Date.", 'alert-danger'); return false; }
            //if (!endInput) { showAlert("Please select End Date.", 'alert-danger'); return false; }
            //if (startDate < dtFromDate || startDate > dtToDate) { showAlert("From Date must fall within the visible week.", 'alert-danger'); return false; }
            //if (endDate < dtFromDate || endDate > dtToDate) { showAlert("To Date must fall within the visible week.", 'alert-danger'); return false; }
            //if (startDate > endDate) { showAlert("From Date must be before End Date.", 'alert-danger'); return false; }

            if (!startInput) {
                showAlert("Please select Start Date.", 'alert-danger');
                return false;
            }
            if (!endInput) {
                showAlert("Please select End Date.", 'alert-danger');
                return false;
            }
            if (startDate < dtFromDate) {
                showAlert("From Date must be greater than or equal to " + formatDDMMMYYYY_Mobile(dtFromDate), 'alert-danger');
                return false;
            }
            if (startDate > dtToDate) {
                showAlert("From Date must be less than or equal to " + formatDDMMMYYYY_Mobile(dtToDate), 'alert-danger');
                return false;
            }
            if (endDate < dtFromDate) {
                showAlert("End Date must be greater than or equal to " + formatDDMMMYYYY_Mobile(dtFromDate), 'alert-danger');
                return false;
            }
            if (endDate > dtToDate) {
                showAlert("End Date must be less than or equal to " + formatDDMMMYYYY_Mobile(dtToDate), 'alert-danger');
                return false;
            }
            if (startDate > endDate) {
                showAlert("From Date must be before End Date.", 'alert-danger');
                return false;
            }

            return true;
        }
        function bindStatusDiv_TSModal_VT() {
            //var html = '<div class="ts-status-wrapper"><div class="row fw-bold border-bottom pb-1 mb-1"><div class="col-4 text-center">Status</div><div class="col-4 text-center">From</div><div class="col-4 text-center">To</div></div>';
            let html = `<div class="col-12 text-center"><strong>Timesheet Status Details</strong></div>
                        <div class="row fw-bold border-bottom pb-1 mb-1"></div>
                        <div class="ts-status-wrapper">
                            <div class="row fw-bold border-bottom pb-1 mb-1">
                                <div class="col-4 text-center">Status</div>
                                <div class="col-4 text-center">From Date</div>
                                <div class="col-4 text-center">To Date</div>
                            </div>
                `;
            //if (TSSubmissionDetails_VT.length) {
            //    TSSubmissionDetails_VT.forEach(function (item) {
            //        html += '<div class="row mb-1"><div class="col-4 text-center">' + (item.Status || "") + '</div><div class="col-4 text-center">' + (item.FromDate || "") + '</div><div class="col-4 text-center">' + (item.ToDate || "") + '</div></div>';
            //    });
            //}

            if (TSSubmissionDetails && TSSubmissionDetails.length > 0) {
                TSSubmissionDetails.forEach(item => {
                    let colorClass = "";
                    switch ((item.Status || "").toLowerCase()) {
                        case "approved":
                            colorClass = "text-success";
                            break;
                        case "submitted":
                            colorClass = "text-primary";
                            break;
                        case "rejected":
                            colorClass = "text-danger";
                            break;
                        case "not submitted":
                            colorClass = "statusNotSubmitted-text";
                            break;
                        default:
                            colorClass = "";
                    }

                    html += `
                        <div class="row mb-1">
                            <div class="col-4 ${colorClass} text-center">${item.Status || ""}</div>
                            <div class="col-4 ${colorClass} text-center">${(item.FromDate)}</div>
                            <div class="col-4 ${colorClass} text-center">${(item.ToDate)}</div>
                        </div>
                    `;
                });
            }

            html += '</div>';
            $("#txtStatus_TSModal_VT").html(html);
        }
        function SubmitTS_OnClick_Confirmation_VT() {
            $("#submitTSModal_VT").modal('show');
            bindStatusDiv_TSModal_VT();
            GetTimeSheetWeekHeaderDetailsViewMobile();
            bindStatusDiv_TSModal_VT();
            var selectedDate = parseDateAsLocalCalendar($("#weekPicker2").attr("SelectedDate")) || weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate"));
            var start = weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate"));
            var end = weekPickerAttrToLocalDate($("#weekPicker2").attr("EndDate"));
            var isCrossMonth = start.getMonth() !== end.getMonth() || start.getFullYear() !== end.getFullYear();
            var finalStart, finalEnd;
            if (!isCrossMonth) { finalStart = start; finalEnd = end; }
            else if (selectedDate.getMonth() === start.getMonth() && selectedDate.getFullYear() === start.getFullYear()) {
                finalStart = start; finalEnd = new Date(start.getFullYear(), start.getMonth() + 1, 0);
            } else {
                finalStart = new Date(end.getFullYear(), end.getMonth(), 1); finalEnd = end;
            }
            var fromFormatted = formatDDMMMYYYY_VT(finalStart);
            var toFormatted = formatDDMMMYYYY_VT(finalEnd);
            $("#txtTSModalStartDate_VT").val(fromFormatted);
            $("#txtTSModalEndDate_VT").val(toFormatted);
            $("#lblSelectedRange_VT").text(fromFormatted + " - " + toFormatted);
            Global_oldStartDate_VT = fromFormatted;
            Global_oldEndDate_VT = toFormatted;
        }
        function ValidateTimesheetEntryAlert_FlexibleVT(flag) {
            var Data = {
                intEmployeeID: EmployeeID,
                dtFromDate: convertToAPIDate_VT(Global_oldStartDate_VT),
                dtToDate: convertToAPIDate_VT(Global_oldEndDate_VT)
            };
            var Result = AJAXCallWithResultMobile("/api/TimesheetEntryNew/GetValidateTimesheetEntryAlert", JSON.stringify(Data), false);
            var msg = '';
            if (Result && Result.length) {
                for (var i = 0; i < Result.length; i++) {
                    msg += Result[i].EntryDate + ' (' + Result[i].LeaveHours + ' hours) ';
                }
                if (flag === 1) {
                    showAlert('You have filled less than the required working hours for ' + msg + ',if you were on leave, then please submit the leave.', 'alert-danger');
                    return false;
                }
            }
        }
        function ValidateSubmitTS_FlexibleVT() {
            var Flag = 0;
            var taskparameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: convertToAPIDate_VT(Global_oldStartDate_VT),
                dtToDate: convertToAPIDate_VT(Global_oldEndDate_VT)
            };
            var data = AJAXCallWithResultMobile("/api/TimesheetEntryNew/ValidateTimesheet", JSON.stringify(taskparameters), false);
            if (data !== "") { showAlert('' + data + '', 'alert-danger'); Flag = 1; }
            return Flag;
        }
        function ValidateHolidayLeaveTS_VT() {
            var Flag = 0;
            var taskparameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: convertToAPIDate_VT(Global_oldStartDate_VT),
                dtToDate: convertToAPIDate_VT(Global_oldEndDate_VT)
            };
            var data = AJAXCallWithResultMobile("/api/TimesheetEntryNew/ValidateHolidayLeaveTS", JSON.stringify(taskparameters), false);
            if (data !== "") { showAlert('' + data + '', 'alert-danger'); Flag = 1; }
            return Flag;
        }
        function SubmitTS_OnClick_FlexibleVT() {
            var ah = ($("#ActualHours").text() || "").trim();
            if (ah === "00:00" || ah === "" || ah === "0" || ah === "0.00") {
                showAlert('Please fill timesheet before submit.', 'alert-danger');
                return false;
            }
            if (validateTimesheetSubmission_VT() === false) return false;
            /*if (ValidateTimesheetEntryAlert_FlexibleVT(1) === false) return false;*/
            if (ValidateSubmitTS_FlexibleVT() === 1) return false;
            //if (ValidateHolidayLeaveTS_VT() === 1) return false;
            $('#btnSubmit').css('pointer-events', 'none');
            var taskparameters = {
                intProxyUserID: 0,
                employeeID: EmployeeID,
                dtFromDate: convertToAPIDate_VT(Global_oldStartDate_VT),
                dtToDate: convertToAPIDate_VT(Global_oldEndDate_VT),
                intTimesheetID: 0,
                StatusCode: "R",
                intMobileView: 1
            };
            StartLoader("#VTBody");
            $.ajax({
                url: encodeURI(strUrlMobile) + '/api/TimesheetEntryNew/GenerateTimesheet',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    if (taskparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? taskparameters : JSON.stringify(taskparameters)));
                    }
                },
                success: function () {
                    StopAjaxLoader("#VTBody");
                    showAlert('Timesheet Submitted successfully.', 'alert-success', 'btnSave');
                    $("#submitTSModal_VT").modal('hide');
                    GetTimesheetStatus(EmployeeID);
                    $("#btnSubmit").css('display', 'none');
                    $("#btnEdit").css('display', 'none');
                    $('#btnSubmit').css('pointer-events', '');
                },
                error: function (err) {
                    StopAjaxLoader("#VTBody");
                    $('#btnSubmit').css('pointer-events', '');
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }

        var strUrlMobile = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Timesheet").ToString%>';
        var ajaxResultMobile;
        function AJAXCallWithResultMobile(url, param, async) {
            $.ajax({
                url: encodeURI(strUrlMobile) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResultMobile = data;
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResultMobile;
        }
        //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo

         //Added By Dipali V On 22nd May 2023 For Valiate timesheet approver
        function ValidateSubmitTS() {
            // 
            var Flag = 0;
            var taskparameters = {
                employeeID: EmployeeID,
                dtFromDate: weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: weekPickerAttrToLocalDate($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US")
            }
            $.ajax({
                url: strUrl + '/api/MyTimesheet/ValidateTimesheet',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? taskparameters : JSON.stringify(taskparameters)));
                    }
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

         //End of Added By Dipali V On 22nd May 2023 For Valiate timesheet approver
        function SubmitTS_OnClick() {
            //Added By Dipali V On 22nd May 2023 For Valiate timesheet approver
            if (ValidateSubmitTS() == 1) {
                return false;
            }
             //End of Added By Dipali V On 22nd May 2023 For Valiate timesheet approver

            $('#btnSubmit').css('pointer-events', 'none');
            //debugger;
            //ValidateSubmitTS();
            taskparameters = {
                intProxyUserID: 0,
                employeeID: EmployeeID,
                dtFromDate: weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: weekPickerAttrToLocalDate($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                intTimesheetID: 0,
                StatusCode: "R",
                intMobileView: 1,
            }


            //alert(intTimesheetID);
            StartLoader("#VTBody");
            $.ajax({                
                //Added and Modified by Vishal Mane on 20/11/2025to fix crash on edit mode.
                //url: strUrl + '/api/MyTimesheet/GenerateTimesheet',
                url: encodeURI(strUrlMobile)  + '/api/TimesheetEntryNew/GenerateTimesheet',
                //End of Added and Modified by Vishal Mane on 20/11/2025to fix crash on edit mode.
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    //Added and Modified by Vishal Mane on 20/11/2025to fix crash on edit mode.
                    //xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    //End of Added and Modified by Vishal Mane on 20/11/2025to fix crash on edit mode.
                    if (taskparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? taskparameters : JSON.stringify(taskparameters)));
                    }
                },
                success: function (data) {
                    //debugger;
                    //var arrData = data.split('$');
                    //if (arrData[0] == 1) {

                    //    window.open('../Email/SendEmail.aspx?MessageID=434&TimesheetID=' + arrData[1] + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    //}
                    StopAjaxLoader("#VTBody");
                    showAlert('Timesheet Submitted successfully.', 'alert-success', 'btnSave');
                    GetTimesheetStatus(EmployeeID);
                    //$("#lblStatus").html("Submitted");
                    //ReloadTApprovalData(EmployeeID);
                    $("#btnSubmit").css('display', 'none');
                    $("#btnEdit").css('display', 'none');

                },
                error: function (err) {
                    StopAjaxLoader("#VTBody");
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function ApproveTimesheet() {
            $("#txtApprovalComment").val("Approved");
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
        function getCorporateAllowToResubmitCheck() {            
            var AllowToResubmitCheck = false;
            var taskParameters = {
                strTimesheetIDs: '<%= Request.QueryString("intTimesheetId")%>',
                intApproverID: '<%=Session("intUserID")%>',
                FromWhere: 'Reject',
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

        
        function RejectTimesheet() {
            //$("#rejecttaskmodal").modal('show');
            $("#txtRejectionComment").val("");
            $("#lblEmployeeName").css('display', 'block');
            $("#lblRejectTaskEmployeeName").css('display', 'none');
            document.getElementById("btnRejectTimesheet").setAttribute("onClick", "RejectAllTimesheet();");            
            //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
            setTSOverrideNote();
            //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
        }

        function ApproveAllTimesheet() {
            //debugger;
            var strComment = "";
            strComment = $("#txtApprovalComment").val();
            var IsValid = 0;
            if (strComment == "") {
                showAlert("Please Enter Comment.", "alert-danger");
            }
            else {
                //End of Added By Dipali V 9th Jan 2019 For Comment as Approved For Approved the timesheet
                var taskParameters = {
                    intTimesheetID: TimesheetID,
                    Status: 'V',
                    intEmployeeID: EmployeeID,
                    strComment: strComment,
                    intResourceID: '<%= Request.QueryString("intEmployeeID")%>',
                    intMobileView: 1,
                    //2021
                    FromWhere: ''
                    //2021
                }
                //StartLoader("#VTBody");
                $.ajax({
                    url: strUrl + '/api/TimesheetApproval/PostTimesheetData',
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
                        // alert("success")
                        //debugger;
                        //UpdateCompleteTasks();
                        $("#approvetaskmodal").modal('hide');
                        if (data == 1) {
                      <%--  window.open('../Email/SendEmail.aspx?MessageID=435&VerifiedBy=' + EmployeeID + '&ResourceID=' + '<%= Request.QueryString("intEmployeeID")%>' + '&FromDate=' + '<%= Request.QueryString("dtFromDate")%>' + '&ToDate=' + '<%= Request.QueryString("dtToDate")%>' + '&TimesheetID=' + TimesheetID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=580');--%>
                        }
                        //StopAjaxLoader("#VTBody");
                        showAlert('Timesheet Approved successfully.', 'alert-success', 'btnSave');

                        GetTimesheetStatus(EmployeeID);
                        ReloadData(EmployeeID);
                    },
                    error: function (err) {
                        StopAjaxLoader("#VTBody");
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
                })
            }
        }

        function RejectAllTimesheet() {
            //debugger;
            var strComment = "";
            var Isvalid = 0;
            strComment = $("#txtRejectionComment").val();
            if (strComment == "") {
                showAlert("Enter Reason for rejection", "alert-danger");
                Isvalid = 1;
            }
            if (Isvalid == 0) {
                var bitAllowToResubmit = ($("#rejecttaskmodalcheckbox").is(':checked') ? 1 : 0);
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
                var taskParameters = {
                    intTimesheetID: TimesheetID,
                    Status: 'J',
                    intEmployeeID: EmployeeID,
                    strComment: strComment,
                    intAllowToResubmit: bitAllowToResubmit,
                    intResourceID: '<%= Request.QueryString("intEmployeeID")%>',
                    intMobileView: 1,
                    //2021
                    FromWhere: ''
                    //2021
                }
                //StartLoader("#VTBody");
                $.ajax({
                    url: strUrl + '/api/TimesheetApproval/PostTimesheetData',
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
                        if (bitAllowToResubmit == 0) { /*UpdateCompleteTasks();*/ }
                        $("#rejectmodal").modal('hide');
                        if (data == 1) {
                            <%--window.open('../Email/SendEmail.aspx?MessageID=436&VerifiedBy=' + EmployeeID + '&ResourceID=' + '<%= Request.QueryString("intEmployeeID")%>' + '&FromDate=' + '<%= Request.QueryString("dtFromDate")%>' + '&ToDate=' + '<%= Request.QueryString("dtToDate")%>' + '&TimesheetID=' + TimesheetID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=580');--%>

                        }
                        //StopAjaxLoader("#VTBody");
                        showAlert('Timesheet Rejected successfully.', 'alert-success', 'btnSave');

                        GetTimesheetStatus(EmployeeID);
                        ReloadData(EmployeeID);
                    },
                    error: function (err) {
                        StopAjaxLoader("#VTBody");
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }
        }


        function OpenTDetailPage(EntryDate,TotalActual) {
            //debugger;
            //alert($("#tdPeriod").html());
            var StartDate = weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US");
            var EndDate = weekPickerAttrToLocalDate($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US");
            //Commented And Added By Usha Pandit On 15.03.2021 For Resubmit Note display issue
            <%--if (PageFlag == 1 ) {
                window.location.href = "../TimesheetMobile/TimesheetDetail_Mobile.aspx?TotalActual="+ TotalActual + "&dtEntryDate=" + EntryDate + "&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&TimesheetStatus=" + $("#lblStatus").html() + "";
            }
            if (PageFlag == 2) {
                window.location.href = "../TimesheetMobile/TimesheetDetail_Mobile.aspx?TotalActual="+ TotalActual + "&dtEntryDate=" + EntryDate + "&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&TimesheetStatus=" + $("#lblStatus").html() + "&MyTimesheetStatus=" + "<%= Request.QueryString("MyTimesheetStatus")%>" + "";
            }
            if (PageFlag == 3) {
                var intEmpID = '<%= Request.QueryString("intEmployeeID")%>';
                //debugger;
                window.location.href = "../TimesheetMobile/TimesheetDetail_Mobile.aspx?TotalActual="+ TotalActual + "&dtEntryDate=" + EntryDate + "&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&TimesheetID=" + TimesheetID + "&intEmployeeID=" + intEmpID + "&Period=" + $("#tdPeriod").html() + "";
            }--%>
            
            if (PageFlag == 1 ) {
                window.location.href = "../TimesheetMobile/TimesheetDetail_Mobile.aspx?TotalActual="+ TotalActual + "&dtEntryDate=" + EntryDate + "&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&TimesheetStatus=" + $("#lblStatus").html() + "&ActualHours=" + "<%= Request.QueryString("ActualHours")%>";
            }
            if (PageFlag == 2) {
                window.location.href = "../TimesheetMobile/TimesheetDetail_Mobile.aspx?TotalActual="+ TotalActual + "&dtEntryDate=" + EntryDate + "&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&TimesheetStatus=" + $("#lblStatus").html() + "&MyTimesheetStatus=" + "<%= Request.QueryString("MyTimesheetStatus")%>" + "&ActualHours=" + "<%= Request.QueryString("ActualHours")%>";
            }
            if (PageFlag == 3) {
                var intEmpID = '<%= Request.QueryString("intEmployeeID")%>';
                //debugger;
                window.location.href = "../TimesheetMobile/TimesheetDetail_Mobile.aspx?TotalActual="+ TotalActual + "&dtEntryDate=" + EntryDate + "&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&TimesheetID=" + TimesheetID + "&intEmployeeID=" + intEmpID + "&Period=" + $("#tdPeriod").html() + "&ActualHours=" + "<%= Request.QueryString("ActualHours")%>";
            }
            //End Of Added By Usha Pandit On 15.03.2021 For Resubmit Note display issue
            //Timesheetstatus
        }
        function Back_Onclick() {
            // alert(PageFlag);
            // alert();
            var StartDate = weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US");
            var EndDate = weekPickerAttrToLocalDate($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US");
            if (PageFlag == 1) {
                window.location.href = "../TimesheetMobile/TimesheetEntry_Mobile.aspx?PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "";
            }
            else if (PageFlag == 2) {
                
                   //Added & commented by Dipali V On 26th March 2019 for Selected Tab should be display after redirction
               // window.location.href = "../TimesheetMobile/MyTimesheet_Mobile.aspx?PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "";
                  window.location.href = "../TimesheetMobile/MyTimesheet_Mobile.aspx?PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&TimesheetStatus=" +"<%= Request.QueryString("MyTimesheetStatus")%>"+ "";
                  //end of Added & commented by Dipali V On 26th March 2019 for Selected Tab should be display after redirction
            }
            else if (PageFlag == 3) {
                //Added & commented by Dipali V On 26th March 2019 for Selected Tab should be display after redirction
                // window.location.href = "../TimesheetMobile/TimesheetApproval_Mobile.aspx?PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "";
                
                window.location.href = "../TimesheetMobile/TimesheetApproval_Mobile.aspx?PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&TimesheetStatus=" + $("#lblStatus").html() + "";
                //Added & commented by Dipali V On 26th March 2019 for Selected Tab should be display after redirction
            }
        }
        function Edit_Onclick() {
            //debugger;
            var StartDate = weekPickerAttrToLocalDate($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US");
            var EndDate = weekPickerAttrToLocalDate($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US");
            $("#btnSubmit").attr('style', 'display:inline-block !important');
            //Commented And Added By Usha Pandit On 15.03.2021 For Resubmit Note display issue
            //window.location.href = "../TimesheetMobile/TimesheetDetail_Mobile.aspx?dtEntryDate=" + StartDate + "&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&TimesheetStatus=" + $("#lblStatus").html() + "";
            window.location.href = "../TimesheetMobile/TimesheetDetail_Mobile.aspx?dtEntryDate=" + StartDate + "&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&TimesheetStatus=" + $("#lblStatus").html() + "&ActualHours=" + "<%= Request.QueryString("ActualHours")%>";
            //End Of Added By Usha Pandit On 15.03.2021 For Resubmit Note display issue
        }

        function ConvertToDecimal(intVal) {

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
                if (fmtMonx == 1)
                    objVal = '0' + fmtMon + '';
                if (fmtMonx == 2)
                    objVal = '' + fmtMon + '';
                if (fmtMonx == 3) {
                    objVal = fmtMon + '0';
                }
                if (fmtMonx == 4 && fmtMon.length > 5) {
                    objVal = fmtMon + '0';
                }
                else {
                    objVal = fmtMon;
                }
            }
            return objVal;
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
