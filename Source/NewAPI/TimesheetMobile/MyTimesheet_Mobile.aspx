<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyTimesheet_Mobile.aspx.vb" Inherits="PbNIT.MyTimesheet_Mobile" %>

<!DOCTYPE html>
<html>
    	<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("Weekly Timesheet")%> 
<head>
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Weekly Timesheet</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />

     <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/daterangepicker-bs3.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/skins/_all-skins.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery.mCustomScrollbar.css?v=2">

    <link rel="stylesheet" type="text/css" href="../../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.css?v=2">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=2.2">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2.5">

   

</head>
     <style type="text/css">
        /**Added By Dipali V On 18th May 2023 For Version Updated UI Changes*/
        .customelinks li a {
            padding: 10px;
            display: block;
        }

        .navstatuslink {
            text-align: center;
            margin-left: 46px;
        }
       #CloseableAlert .close {
            float: right;
            border: none;
        }

          a {
            color: #337ab7;
            text-decoration: none!important;
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
        .col-xs-3 {
            width:25%;
        }
         #alertMsg {
            font-size: 13px;
            width: 295px;
        }

         .autoclosablemsg{ display:none;}

       
    </style>
<body id="bodyMyTimesheet" class="skin-blue-light sidebar-mini dashmain fixed">
    <div class="responsivewarningmsg">
        <h2>Please check on 1280px and high Resolution</h2>
    </div>

    <div class="wrapper">
        <!-- Main Header -->
        <header class="main-header">

            <!-- Header Navbar -->
            <nav class="navbar navbar-static-top" role="navigation">

                <div class="mainheadingtop">My Timesheet</div>

                <%--<div class="filter pull-right">
                    <button data-placement="bottom" title="filter" data-bs-toggle="collapse" data-target="#Mvfilterpanel" class="collapsed" aria-expanded="false"><i class="fas fa-filter"></i></button>


                </div>--%>
            </nav>
        </header>
        <!--bootstrap_Alertify-->
        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg"> <%-- hidden="hidden"--%>
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
                    <%-- <div id="Mvfilterpanel" class="Mv_filterpanel collapse hidden-desktop" aria-expanded="true" style="">
                        <div class="container">
                            <div class="form-group">
                                 <% CommonFunctions.HTMLControls.DrawComboBox("CboResource", "usp_Whizible2_Sel_tbl_CNF_ProxyUser_Mapping_Detail " & Session("intUserID"),,, "class='form-control selectpicker' onChange='javascript:CboResource_OnChange(this.value);'",,, ) %>
                                <select class="form-control selectpicker">
                                    <option>Employee Name</option>
                                    <option>Jones Doe</option>
                                    <option>Mark Nelson</option>
                                    <option>Abhishek Jain</option>
                                    <option>Abhishek Jain</Option>s
                                </select>
                            </div>
                            <div class="form-group">
                                <select class="form-control selectpicker">
                                    <option>Status</option>
                                    <option>Saved</option>
                                    <option>Approved</option>
                                    <option>Submitted</option>
                                    <option>Rejected</option>
                                </select>
                            </div>

                            <div class="clearfix"></div>

                            <div class="fp_button text-center">
                                <a href="#" class="btn borderbtn cancelbtn" data-bs-toggle="collapse" data-target="#Mvfilterpanel">cancel</a>
                                <a href="#" class="btn borderbtn active">Apply</a>
                            </div>

                        </div>
                    </div>--%>
                    <!--mobile view filter anel end-->




                    <div class="tab-content" id="divMytimesheetmob">
                        <div class="container">

                            <!--startnextdiv-->
                            <div class="row graybg" data-spy="affix" data-offset-top="100">
                                <div class="col-xs-12">

                                    <ul class="nav customelinks navstatuslink">
                                        <li class="statusall "><a id="all" data-target="statusall" href="javascript:;">All</a></li>
                                        <li class="statusapproved"><a id="Approved" data-target="statusapproved" href="javascript:;">Approved</a></li>
                                        <li class="statusrejected"><a id="Rejected" data-target="statusrejected" href="javascript:;">Rejected</a></li>
                                        <li class="statussubmitted active"><a  id="Submitted" data-target="statussubmitted" href="javascript:;">Submitted</a></li>
                                    </ul>

                                </div>

                            </div>
                        </div>

                        <!--timesheet table-->

                        <div class="mobcusttble Mv_timesheetabpproval_tbl mt-2 Mv_statusfiltertble">
                            <div class="container">
                                <div class="pb-2 Mvstatustabhide">
                                    <button class="btn borderbtnred ml0" id="deletebtn" data-bs-toggle="modal" data-bs-target="#viewtimesheet">Delete</button>
                                    <button id="submitbtn" class="btn btnyellow ml-1">Submit</button>

                                    <div class="custom_chckbox pull-right Mvtimesheetapprovalcheckbox pb-1" style="display:block;float:right">
                                        <input type="checkbox" id="selectAll">
                                        <label for="selectAll" style="font-weight:600">Select All</label>
                                    </div>
                                </div>
                                <div id="DivMyTimesheet">
                                    <%--  <div data-status="statussaved" class="tabstatusdiv selected">

                                        <table class="table">
                                            <tbody>
                                                <tr>
                                                    <td class="text-left">
                                                        <div class="Mv_timesheetapprovalinfo">
                                                            <div class="Mv_sumbmiteddate">18-06-2018</div>
                                                            <p class="TA_tbl_approvaldate"><a id="TAviewdatepanel" class="tab">June, 18-June,23 2018</a></p>
                                                            <div class="Mv_actualandapprovaltime">
                                                                <p>
                                                                    <lanel>Actual:</lanel>
                                                                    35:15
                                                                </p>
                                                                <p>
                                                                    <lanel>Expected:</lanel>
                                                                    40:00
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-right">


                                                        <p class="text-right">Saved</p>

                                                        <div class="custom_chckbox">
                                                            <input type="checkbox" id="approved1">
                                                            <label for="approved1"></label>
                                                        </div>

                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div data-status="statussubmitted" class="tabstatusdiv">

                                        <table class="table">
                                            <tbody>
                                                <tr>
                                                    <td class="text-left">
                                                        <div class="Mv_timesheetapprovalinfo">
                                                            <div class="Mv_sumbmiteddate">19-06-2018</div>
                                                            <p>June, 18-June,23 2018</p>
                                                            <div class="Mv_actualandapprovaltime">
                                                                <p>
                                                                    <lanel>Actual : </lanel>
                                                                    35:15
                                                                </p>
                                                                <p>
                                                                    <lanel>Expected : </lanel>
                                                                    40:00
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-right">

                                                        <p class="text-right">Submitted</p>

                                                        <div class="custom_chckbox">
                                                            <input type="checkbox" id="approved2">
                                                            <label for="approved2"></label>
                                                        </div>

                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div data-status="statusapproved" class="tabstatusdiv">

                                        <table class="table">
                                            <tbody>
                                                <tr>
                                                    <td class="text-left">
                                                        <div class="Mv_timesheetapprovalinfo">
                                                            <div class="Mv_sumbmiteddate">19-06-2018</div>
                                                            <p>June, 18-June,23 2018</p>
                                                            <div class="Mv_actualandapprovaltime">
                                                                <p>
                                                                    <lanel>Actual : </lanel>
                                                                    35:15
                                                                </p>
                                                                <p>
                                                                    <lanel>Expected : </lanel>
                                                                    40:00
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-right">

                                                        <p class="text-right">Approved</p>

                                                        <div class="custom_chckbox">
                                                            <input type="checkbox" id="approved3">
                                                            <label for="approved3"></label>
                                                        </div>

                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div data-status="statusrejected" class="tabstatusdiv">

                                        <table class="table">
                                            <tbody>
                                                <tr>
                                                    <td class="text-left">
                                                        <div class="Mv_timesheetapprovalinfo">
                                                            <div class="Mv_sumbmiteddate">24-06-2018</div>
                                                            <p>June, 18-June,23 2018</p>
                                                            <div class="Mv_actualandapprovaltime">
                                                                <p>
                                                                    <lanel>Actual : </lanel>
                                                                    35:15
                                                                </p>
                                                                <p>
                                                                    <lanel>Expected : </lanel>
                                                                    40:00
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-right">

                                                        <p class="text-right">Rejected</p>

                                                        <div class="custom_chckbox">
                                                            <input type="checkbox" id="approved4">
                                                            <label for="approved4"></label>
                                                        </div>

                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div data-status="statussaved" class="tabstatusdiv">

                                        <table class="table">
                                            <tbody>
                                                <tr>
                                                    <td class="text-left">
                                                        <div class="Mv_timesheetapprovalinfo">
                                                            <div class="Mv_sumbmiteddate">18-06-2018</div>
                                                            <p>June, 18-June,23 2018</p>
                                                            <div class="Mv_actualandapprovaltime">
                                                                <p>
                                                                    <lanel>Actual : </lanel>
                                                                    35:15
                                                                </p>
                                                                <p>
                                                                    <lanel>Expected : </lanel>
                                                                    40:00
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-right">

                                                        <p class="text-right">Saved</p>

                                                        <div class="custom_chckbox">
                                                            <input type="checkbox" id="approved5">
                                                            <label for="approved5"></label>
                                                        </div>

                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>--%>
                                </div>
                            </div>

                        </div>

                        <!--timesheet table-->

                    </div>
                    <!--nextdivend-->



                </div>
            </section>
            <!-- /.content -->
        </div>


        <!--all modal start here-->

        <!--rejectmodal-->
        <div id="rejecttaskmodal" class="modal fade custmodal" role="dialog">
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
                            <div class="row">
                             <%--  <div class="col-xs-12 col-sm-4 text-right">Reason for rejection:</div>--%>
                                          <div class="col-xs-12 col-sm-4 text-left">Reason for rejection:</div>
                                          <%--End of   Added & Commented Dipali V On 28th May 2019--%>
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
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">cancel</button>
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
                                <div class="col-xs-12 col-sm-4 text-right">Task Name:</div>
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

        <!--deletmodal-->
        <div id="deleteinfomodal" class="modal fade custmodal" role="dialog">
            <div class="modal-dialog modal-sm">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Delete</h4>
                    </div>

                    <div class="modal-body">
                        <p align="center">You are about to delete Timesheet.Do you want to Continue?</p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-left" style="width: 70%;">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6" style="width: 30%;">
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

        <!--submitmodal-->
        <div id="submitinfomodal" class="modal fade custmodal" role="dialog">
            <div class="modal-dialog modal-sm">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Submit</h4>
                    </div>

                    <div class="modal-body">
                        <p align="center">Are you sure you want to submit entry?</p>
                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-left"  style="width: 70%;">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6" style="width:30%!important">
                                    <button class="btn btnyellow ml-1 pull-right" onclick="SubmitData()">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--deletmodalend-->


        <!--all modal end here-->





        <!-- /.content-wrapper -->
        <!-- Control Sidebar -->


        <!-- /.control-sidebar -->

    </div>

  
   <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>

    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js?v=1"></script>
    <!-- custome_mobile_only js -->
    
    <script src="../../../Whizible2.0-new/dist/js/custom_mobile.js?v=1"></script>
    <!--weekpicker-->
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/weekPicker.js"></script>
    <script src="../../General/CommonValidations.js"></script>

    <script type="text/javascript">
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

        var EmployeeID;
        var currentEmployeeID;
        var currentEmpID;
        EmployeeID = <%= Session("intUserID") %>
            currentEmpID = EmployeeID;


        var getSelectedStatus = "Submitted";
        jQuery(document).ready(function () {
            //debugger;
            var PageFlag = 0;
            PageFlag = "<%= Request.QueryString("PageFlag")%>";
            if (PageFlag == 2) {
                getSelectedStatus = "<%= Request.QueryString("TimesheetStatus")%>";
            }
            ReloadData(EmployeeID);
            //Added By Dipali V On 6th Jan 2020 For Filter Issues
            AfterResponsivePlot();
            //End of Added By Dipali V On 6th Jan 2020 For Filter Issues
        });
        function ReloadData(ProxyResourceID, ResourceID) {
            // debugger;
            try {
                if (ProxyResourceID == 0) {
                    ProxyResourceID = currentEmpID;
                }

                if (ResourceID != undefined) {
                    taskParameters = {
                        intProxyUserID: ProxyResourceID,
                        employeeID: ResourceID,
                        StatusCode: " ",
                    }
                }
                else {
                    taskParameters = {
                        intProxyUserID: ProxyResourceID,
                        StatusCode: "",
                    }
                }

                //debugger;          
                AjaxCall();
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        function AjaxCall() {
            StartLoader("#bodyMyTimesheet");
            $.ajax({
                url: strUrl + '/api/MyTimesheet/GetData',
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
                    var MyTimesheet = data;
                    plotMyTimesheetList(MyTimesheet.MyTimesheetLists);
                    StopAjaxLoader("#bodyMyTimesheet");
                    $("#" + getSelectedStatus + "").trigger("click");
                    AfterPlot();
                    $('#selectAll').change(function () {
                        $('input[name=checkDelete]').prop("checked", this.checked);

                    });


                    $('.reject').click(function () {
                     // debugger;
                        if ($('input:checkbox:checked.reject').length === $("input:checkbox.reject").length) {
                            $('#selectAll').prop("checked", true);
                        }
                        else {
                            $('#selectAll').prop("checked", false);
                        }

                    });

                },
                error: function (err) {
                    //alert("error");
                    console.log(err);
                }
            })

        }

        $('#selectAll').change(function () {
            $('input[name=checkDelete]').prop("checked", this.checked);

        });


       
        /*Commented & Added By Dipali V On 19th May 2023 For Checkbox issue*/
        //$('.reject').change(function () {
        //    if ($('input:checkbox:checked.reject').length === $("input:checkbox.reject").length) {
        //        $('#selectAll').prop("checked", true);
        //    }
        //    else {
        //        $('#selectAll').prop("checked", false);
        //    }

        //});

        $('#DivMyTimesheet').on('change', 'tbody td:nth-child(2) :checkbox.reject', function () {

            //if ($('input:checkbox:checked.reject').length === $("input:checkbox.reject").length) {
            if ($('input[type=checkbox].reject:checked').length == $('input[type=checkbox].reject').length) {
                $('#selectAll').prop("checked", true);
            }
            else {
                $('#selectAll').prop("checked", false);
            }
        });
        /*End of Commented & Added By Dipali V On 19th May 2023 For Checkbox issue*/

        function plotMyTimesheetList(MyTimesheetLists) {
            $("#DivMyTimesheet").html('');
            var strHTML = "";
            for (var i = 0; i < MyTimesheetLists.length; i++) {
                var MyTimesheetObject = MyTimesheetLists[i];
                var TimeSheetID = MyTimesheetObject.TimeSheetID;
                var CreatedDate = MyTimesheetObject.CreatedDate;
                var Period = MyTimesheetObject.Period;
                var FromDate = MyTimesheetObject.FromDate;
                var ToDate = MyTimesheetObject.ToDate;
                var ActualHours = MyTimesheetObject.ActualHours;
                var StatusDescription = MyTimesheetObject.StatusDescription;
                var Comment = MyTimesheetObject.Comment;
                var ExpectedHours = MyTimesheetObject.ExpectedHours;
                //alert(ToDate);
                if (StatusDescription != '') {
                    if (StatusDescription == 'Not ready for approval') { strHTML += '<div data-status="statussaved" class="tabstatusdiv " id="statusall">'; }
                    else if (StatusDescription == 'Ready for approval') { strHTML += '<div data-status="statussubmitted" class="tabstatusdiv " id="statussubmitted">'; }
                    else if (StatusDescription == 'Approved') { strHTML += '<div data-status="statusapproved" class="tabstatusdiv " id="statusapproved">'; }
                    else if (StatusDescription == 'Rejected') { strHTML += '<div data-status="statusrejected" class="tabstatusdiv " id="statusrejected">'; }
                strHTML += '<table class="table">';
                strHTML += '<tbody>';
                strHTML += '<tr>';
                strHTML += '<td class="text-left">';
                    strHTML += '<div class="Mv_timesheetapprovalinfo">';
                    //Commented And Added By Usha Pandit On 11.03.2021 For Note regarding efforts change
                //strHTML += '<div class="Mv_sumbmiteddate" style="cursor:pointer;" onclick=OpenViewTimesheet("' + FromDate + '","' + ToDate + '",' + TimeSheetID + ')>' + Period + '</div>';
                    strHTML += '<div class="Mv_sumbmiteddate" style="cursor:pointer;" onclick=OpenViewTimesheet("' + FromDate + '","' + ToDate + '",' + TimeSheetID + ',"' + ConvertToDecimal(ActualHours) + '")>' + Period + '</div>';
                    //End Of Added By Usha Pandit On 11.03.2021 For Note regarding efforts change                
                strHTML += '<p class="TA_tbl_approvaldate"><a id="TAviewdatepanel" class="tab">' + CreatedDate + '</a></p>';
                strHTML += "<input  id='FrmId_" + TimeSheetID + "'CboResource_OnChange type='hidden' value='" + FromDate + "'/>";
                strHTML += "<input  id='ToId_" + TimeSheetID + "' type='hidden'  value='" + ToDate + "'>";
                strHTML += '<div class="Mv_actualandapprovaltime">';
                strHTML += '<p>';
                strHTML += '<lanel>Actual:</lanel>';
                strHTML += '' + ConvertToDecimal(ActualHours) + '';
                strHTML += '</p>';
                strHTML += '<p>';
                strHTML += '<lanel>Expected:</lanel>';
                strHTML += '' + ConvertToDecimal(ExpectedHours) + '';
                strHTML += '</p>';
                strHTML += '</div>';
                strHTML += ' </div>';
                strHTML += '</td>';
                strHTML += '<td class="text-right">';
                if (StatusDescription == 'Not ready for approval') { strHTML += ' <p class="text-right">Saved</p>'; }
                else if (StatusDescription == 'Ready for approval') { strHTML += ' <p class="text-right">Submitted</p>'; }
                else { strHTML += ' <p class="text-right">' + StatusDescription + '</p>'; }

                strHTML += ' <div class="custom_chckbox">';
                if (StatusDescription == 'Not ready for approval') {
                    //$(".tblchk").attr('style', 'cursor: not-allowed !important');
                    strHTML += "<input type='checkbox'  id='Tapprovalall_" + TimeSheetID + "' disabled  style='cursor:not-allowed'>";
                    strHTML += "<label for='Tapprovalall_" + TimeSheetID + "' style='cursor:not-allowed'></label>";
                }
                else if (StatusDescription == 'Ready for approval') {
                    //$(".tblchk").attr('style', 'cursor: not-allowed !important');
                    strHTML += "<input type='checkbox' id='Tapprovalall_" + TimeSheetID + "' disabled  style='cursor:not-allowed'>"
                    strHTML += "<label for='Tapprovalall_" + TimeSheetID + "'  style='cursor:not-allowed'></label>";
                }
                else if (StatusDescription == 'Approved') {
                    // $(".tblchk").attr('style', 'cursor: not-allowed !important');
                    strHTML += "<input type='checkbox' id='Tapprovalall_" + TimeSheetID + "' disabled  style='cursor:not-allowed'>"
                    strHTML += "<label for='Tapprovalall_" + TimeSheetID + "'  style='cursor:not-allowed'></label>";
                }
                else if (StatusDescription == 'Rejected') {
                    strHTML += "<input type='checkbox' class='chktbl reject' name='checkDelete' id='Tapprovalall_" + TimeSheetID + "'>"
                    strHTML += "<label for='Tapprovalall_" + TimeSheetID + "'></label>";
                }
                strHTML += '</div>';
                strHTML += '</td>';
                strHTML += ' </tr>';
                strHTML += ' </tbody>';
                strHTML += ' </table>';
                strHTML += '<div class="clearfix"></div>';
                    strHTML += '</div>';
                    }
            }
            $("#DivMyTimesheet").html(strHTML);
        }

        $("#deletebtn").click(function () {
            //debugger; 
            var strTimesheetIDs;
            strTimesheetIDs = $('input[name=checkDelete]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (strTimesheetIDs.length <= 0) {
                showAlert('Please select at least one Record to delete.', 'alert-danger');
                return false;
            }
            else {
                $("#deletebtn").attr('data-bs-toggle', 'modal');
                $("#deletebtn").attr('data-bs-target', '#deleteinfomodal');
            }
        });

        $("#submitbtn").click(function () {
            //debugger; 
            var strTimesheetIDs = 0;
            strTimesheetIDs = $('input[name=checkDelete]:checked').map(function () {
                return this.value;
            }).get().join(',');
            // alert(strTimesheetIDs);
            if (strTimesheetIDs.length <= 0) {
                showAlert('Please select at least one Record to Submit.', 'alert-danger');
                return false;
            }
            else {
                $("#submitbtn").attr('data-bs-toggle', 'modal');
                $("#submitbtn").attr('data-bs-target', '#submitinfomodal');
            }
        });

        //$("#selectAll").change(function () {
        //    // debugger;
        //    var checked = $(this).is(':checked');
        //    $("#DivMyTimesheet tbody tr:visible").find("td .chktbl").prop("checked", checked);
        //});
       
        $('.navstatuslink a').on('click', function () {
            // debugger;
            //Commented & Added By Dipali V On 19th May 2023 For Check box
            // $('input:checkbox').removeAttr('checked');
            $('input:checkbox').prop('checked', false);
            //End of Commented & Added By Dipali V On 19th May 2023 For Check box
            var Status = $(this).attr('id');
            getSelectedStatus = Status;

        });

        $('.navstatuslink a').on('click', function () {
            $(".navstatuslink li a").removeClass("active");
            $(this).addClass("active");
        });


        $('.navstatuslink li a').click(function () {
            StartLoader("#bodyMyTimesheet");
            //debugger;
            //var $target = $(this).data('target');
            var $target = $(this).attr('data-target');
            var $target = "#" + $target
            $("#statusall").removeClass('active');
            if ($target != '#statusall') {
                $('#DivMyTimesheet .tabstatusdiv').css('display', 'none');
                $('#DivMyTimesheet ' + $target + '').css('display', 'block');
            }
            else {
                $('#DivMyTimesheet .tabstatusdiv').css('display', 'block');
            }
            StopAjaxLoader("#bodyMyTimesheet");
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
            })
         //End of Added by Dipali V On 26th March 2019 for Selected Tab should be display after redirction
        //Commented And Added By Usha Pandit On 11.03.2021 For Note regarding efforts change               
        //function OpenViewTimesheet(StartDate, EndDate, TimesheetID) {
        //    window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&intTimesheetID=" + TimesheetID + "&PageFlag=2&MyTimesheetStatus="+ getSelectedStatus +"";
        //}
        function OpenViewTimesheet(StartDate, EndDate, TimesheetID, ActualHours) {
            window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&intTimesheetID=" + TimesheetID + "&PageFlag=2&MyTimesheetStatus=" + getSelectedStatus + "&ActualHours=" + ActualHours + "&EmployeeID=" + "<%= Session("intUserID") %>";
        }
        //End Of Added By Usha Pandit On 11.03.2021 For Note regarding efforts change    
        function DeleteData() {

            $('input[name=checkDelete]:checked').each(function () {

                DeleteAjaxCall(this.id.split('Tapprovalall_')[1]);
            });

        }

        function SubmitData() {
            $('input[name=checkDelete]:checked').each(function () {

                SubmitAjaxCall(this.id.split('Tapprovalall_')[1]);
            });

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

        function SubmitAjaxCall(IDs) {
            //   debugger;
            //alert("IN submit AJAX");

            var Fromdate1 = document.getElementById("FrmId_" + IDs).value;
            var dateAr = Fromdate1.split('-');
            var Fromdate = Fromdate1;
            //alert(Fromdate);
            var Todate1 = document.getElementById("ToId_" + IDs).value;
            var dateArr = Todate1.split('-');
            var Todate = Todate1
            //alert(Todate);
            var taskparameters = {
                intProxyUserID: 0,
                employeeID: EmployeeID,
                dtFromDate: Fromdate,
                dtToDate: Todate,
                intTimesheetID: IDs,
                StatusCode: "R",

            }


            $.ajax({
                url: strUrl + '/api/MyTimesheet/GenerateMyTimesheet',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? taskparameters : JSON.stringify(taskparameters)));
                    }
                },
                success: function (data) {
                    console.log(data);
                    // debugger;
                    //if (data == 1) {
                    //    showAlert('Timesheet Generated successfully.', 'alert-success', 'btnSave');
                    //    window.open('../Email/SendEmail.aspx?MessageID=434&TimesheetID=' + IDs + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    //}
                    showAlert('Timesheet Generated successfully.', 'alert-success', 'btnSave');
                    ReloadData(EmployeeID);
                    $("#submitinfomodal").modal('hide');


                },
                error: function (err) {
                    //alert("in error");
                    console.log(err);

                }
            })

        }

        function DeleteAjaxCall(ids) {
            //  debugger;
            var taskparameters = {
                intTimesheetID: ids,

            }
            //alert(taskparameters)

            $.ajax({
                url: strUrl + '/api/MyTimesheet/DeleteMyTimesheet',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? taskparameters : JSON.stringify(taskparameters)));
                    }
                },
                success: function (data) {
                    console.log(data);

                    showAlert('Timesheet deleted successfully.', 'alert-success');

                    ReloadData(EmployeeID);
                    $("#deleteinfomodal").modal('hide');


                },
                error: function (err) {

                    console.log(err);

                }
            })

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
