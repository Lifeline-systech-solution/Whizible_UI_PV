<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyTimesheet.aspx.vb" Inherits="PbNIT.MyTimesheet" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>My Timesheet</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap.min.css">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap-select.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0/fontawesome/css/all.css">

    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/skins/_all-skins.min.css">

    <!-- sticky table -->
    <link href='../../../Whizible2.0/dist/css/table-fixed-header.css' rel='stylesheet'>

    <!-- animate css -->
    <link rel="stylesheet" href="../../Whizible2.0/dist/css/animate.css">

    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom.css?v=1">
    <!-- <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700" rel="stylesheet"> -->
    <style type="text/css">
        #hdhistoryfixtbl {
            top: 40px !important;
            background: #fff;
            z-index: 9;
        }

        #hdScrollhistoryfixtbl {
            overflow-y: auto !important;
        }

        table .header-fixed {
            top: 0px !important;
        }
    </style>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="bodyMyTimesheet">
    <div class="responsivewarningmsg">
        <h2>Please check on 1280px and high Resolution</h2>
    </div>

    <!-- Main content -->
    <section class="content mytimesheet">

        <div class="graybg container-fluid pt-1 pb-1 mytimesheethdtop">
            <div class="row">
                <div class="col-md-4 col-sm-4 col-xs-12">
                    <div class="row">
                        <div class="col-xs-4" id="ProxyTimesheet">
                            <label class="control-label">Timesheet of</label>
                        </div>
                        <div class="col-xs-8" title="select resource" id="ProxyResource">

                            <% CommonFunctions.HTMLControls.DrawComboBox("CboResource", "usp_Whizible2_Sel_tbl_CNF_ProxyUser_Mapping_Detail " & Session("intUserID"),,, "class='form-control selectpicker' onChange='javascript:CboResource_OnChange(this.value);'",,, ) %>
                        </div>
                    </div>
                </div>

                <div class="col-md-8 col-sm-8 col-xs-12">
                    <div class="mts_sction_right text-right">
                        <%-- <a href="#">Clear All</a>--%>

                        <div class="pull-right">
                            <div class="dropdown filedownload">
                                <button class="nostylebtn dropdown-toggle" data-toggle="dropdown"><i data-toggle="tooltip" data-placement="bottom" title="Click here to download" class="fas fa-download"></i></button>

                                <ul class="dropdown-menu" id="fas-download">
                                    <li><a href="#" onclick="DownloadReport('PDF')">
                                        <img src="../../../Whizible2.0/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                    <li><a href="#" onclick="DownloadReport('EXCEL')">
                                        <img src="../../../Whizible2.0/dist/img/xls.svg" width="18px">Xlsx</a></li>
                                    <li><a href="#" onclick="DownloadReport('XML')">
                                        <img src="../../../Whizible2.0/dist/img/xml.svg" width="18px">Xml</a></li>
                                    <li><a href="#" onclick="DownloadReport('TEXT')">
                                        <img src="../../../Whizible2.0/dist/img/doc.svg" width="18px">Doc</a></li>

                                </ul>


                            </div>

                        </div>
                        <!--bootstrap_Alertify-->
                        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" hidden="hidden">
                            <button type="button" class="close">×</button>
                            <p id="alertMsg"></p>
                        </div>
                        <!--bootstrap_Alertify-->
                    </div>
                </div>
            </div>
        </div>

        <div class="weeklytimesheetwrap">
            <div class="timesheetrow container-fluid bgwhite ts_headerbot">
                <div class="row">
                    <div class="col-md-6 col-sm-4 col-xs-12 pull-right">
                        <ul class="pull-right btnlistinline">
                            <li>

                                <button id="deletebtn" class="btn borderbtnred ml-1" data-toggle="" data-target="">Delete</button>
                                <%--<button id="deletebtn" class="btn borderbtnred ml-1" data-toggle="modal" data-target="#deleteinfomodal">Delete</button>--%>
                            </li>
                            <li>
                                <button id="submitbtn" class="btn btnyellow ml-1" onclick="ValidateData()" data-toggle="" data-target="">Submit</button>
                                <%--<button id="submitbtn"  data-toggle="modal" data-target="#submitinfomodal" class="btn btnyellow ml-1">Submit</button>--%>
                            </li>
                        </ul>
                    </div>
                    <div id="tabs" class="col-md-6 col-sm-8 col-xs-12">
                        <ul class="nav navbar-nav customelinks navstatuslink">
                            <li class="statusallactive"><a id="All" data-target="all" href="javascript:;">All</a></li>
                            <li class="statusapproved"><a id="Approved" data-target="statusapproved" href="javascript:;" onclick="myFunction()">Approved</a></li>
                            <li class="statusrejected"><a id="Rejected" class="srejected" data-target="statusrejected" href="javascript:;">Rejected</a></li>
                            <li class="statussubmitted"><a id="Submitted"  data-target="statussubmitted" href="javascript:;" >Submitted</a></li>
                        </ul>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>



            <div class="table-outer">

                <div class="tbl-content">



                    <table id="MTstatusfiltertble" class="table table-bordered tbl_custm statusfiltertble table-fixed-header sticky-header">
                        <thead class="header">
                            <tr id="myRow">
                                <th width="5%" class="text-center">
                                    <div class="custom_chckbox">
                                        <input type="checkbox" id="Tapprovalall" class="tblchk">
                                        <label for="Tapprovalall" class="tblchk"></label>
                                    </div>
                                </th>
                                <th class="text-center">Submit Date</th>
                                <th class="text-center">Period</th>
                                <th width="12%" class="text-center">Actual Hours</th>
                                <th width="14%" class="text-center">Status</th>
                                <th width="28%" class="text-center">Approve/Reject Comment</th>

                            </tr>
                        </thead>

                        <tbody id="mytimesheettable">
                            <%--<tr data-status="statussaved" class="selected">

                                <td>18-06-2018</td>
                                <td class="mtdateperiod"><a href="view_timesheet.html">18-06-2018 <span>to</span> 23-6-2018</a></td>
                                <td>35:15</td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn_lightred">Saved</button>
                                        <button data-toggle="modal" data-target="#historymodal" type="button" class="btn btn_lightred" data-original-title="" title="">
                                            <img class="pull-right" src="../../../Whizible2.0/dist/img/exclaim.svg" width="13px" alt="">
                                        </button>
                                    </div>
                                </td>
                                <td class="text-left">&nbsp;</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input type="checkbox" id="Tapprovalall">
                                        <label for="Tapprovalall"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr data-status="statussubmitted">

                                <td>19-06-2018</td>
                                <td class="mtdateperiod"><a href="view_timesheet.html">19-06-2018 <span>to</span> 21-6-2018</a></td>
                                <td>13:10</td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-info">Submitted</button>
                                        <button data-toggle="modal" data-target="#historymodal" type="button" class="btn btn_lightred" data-original-title="" title="">
                                            <img class="pull-right" src="../../../Whizible2.0/dist/img/exclaim.svg" width="13px" alt="">
                                        </button>
                                    </div>
                                </td>
                                <td class="text-left">&nbsp;</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input type="checkbox" id="Tapprovalall">
                                        <label for="Tapprovalall"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr data-status="statusapproved">

                                <td>19-06-2018</td>
                                <td class="mtdateperiod"><a href="view_timesheet.html">19-06-2018 <span>to</span> 21-6-2018</a></td>
                                <td>20:25</td>
                                <td>

                                    <div class="btn-group">
                                        <button type="button" class="btn btn-success">Approved</button>
                                        <button data-toggle="modal" data-target="#historymodal" type="button" class="btn btn_lightred" data-original-title="" title="">
                                            <img class="pull-right" src="../../../Whizible2.0/dist/img/exclaim.svg" width="13px" alt="">
                                        </button>
                                    </div>
                                </td>
                                <td class="text-left">Lorem Ipsum doller sit amet, consectetur dummy text.</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input type="checkbox" id="Tapprovalall">
                                        <label for="Tapprovalall"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr data-status="statusrejected">

                                <td>24-06-2018</td>
                                <td class="mtdateperiod"><a href="view_timesheet.html">24-06-2018 <span>to</span> 30-6-2018</a></td>
                                <td>30:20</td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-red">Rejected</button>
                                        <button data-toggle="modal" data-target="#historymodal" type="button" class="btn btn_lightred" data-original-title="" title="">
                                            <img class="pull-right" src="../../../Whizible2.0/dist/img/exclaim.svg" width="13px" alt="">
                                        </button>
                                    </div>

                                </td>
                                <td class="text-left">&nbsp;</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input type="checkbox" id="Tapprovalall">
                                        <label for="Tapprovalall"></label>
                                    </div>
                                </td>
                            </tr>--%>
                        </tbody>
                    </table>
                </div>

            </div>

            <!--table end here-->
            <div class="clearfix"></div>
        </div>

    </section>
    <!-- /.content -->

    <!-- Modal -->
    <div id="Schedule" class="modal fade custmodal" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Schedul time entry</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <div class="entryform scheduleform">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-right">Start date:</div>
                                        <div class="col-xs-6 col-sm-7">
                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <input type="text" class="form-control" name="">
                                                </div>
                                                <div class="col-xs-2">
                                                    <span class="startdateicon">
                                                        <img class="weeklycalender_icon" src="../../../Whizible2.0/dist/img/calendar.svg" alt="" width="20px"></span>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-right">Post tiII date</div>
                                        <div class="col-xs-6 col-sm-7">
                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <input type="text" class="form-control" name="">
                                                </div>
                                                <div class="col-xs-2">
                                                    <span class="startdateicon">
                                                        <img class="weeklycalender_icon" src="../../../Whizible2.0/dist/img/calendar.svg" alt="" width="20px"></span>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-right">Project:</div>
                                        <div class="col-xs-6 col-sm-7">Vizible 2.0</div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-right">Task:</div>
                                        <div class="col-xs-6 col-sm-76">Define roles & responsibilities</div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-right">Sub task:</div>
                                        <div class="col-xs-6 col-sm-7">Sub task name</div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-right">Hours to post:</div>
                                        <div class="col-xs-6 col-sm-76">00.00</div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-right">Close task after end date:</div>
                                        <div class="col-xs-6 col-sm-7">
                                            <div class="custom_chckbox">
                                                <input id="closetask" type="checkbox">
                                                <label for="closetask"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group mt-4">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-6 text-left">
                                            <button class="btn borderbtn ml-1">Cancle</button>
                                        </div>
                                        <div class="col-xs-6 col-sm-6 text-right">
                                            <button class="btn savebtn btnyellow ml-1">Schedule</button>
                                        </div>
                                    </div>
                                </div>
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

    <!-- Modal -->
    <div id="morepts" class="modal fade custmodal" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">More Projects</h4>
                </div>
                <div class="modal-body">
                    Coming Soon

                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!--modalEnd-->





    <!-- Modal -->
    <div id="historymodal" class="modal fade custmodal" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">My Timesheet History</h4>
                </div>
                <div class="modal-body">
                    <div class="fixedtable_container">
                        <table id="historyfixtbl" class="table cust_fixed_tbl">
                            <thead>
                                <tr>
                                    <th>Status</th>
                                    <th>Generation Date</th>
                                    <th>Updated Date</th>
                                    <th>Action Taken By</th>
                                    <th>Action Taken</th>
                                    <th>Approver Name</th>
                                </tr>
                            </thead>

                            <tbody id="tbodyHistory">
                                <td>13 Sep 2018  8:22pm</td>
                                <td>Sukanya.vaidya</td>
                                <td>Organisation Unit</td>
                                <td>Old Value</td>
                                <td>New Value</td>
                                <td>Comments</td>
                            </tbody>

                        </table>
                    </div>

                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!--modalEnd-->


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

    <!-- View Timesheet -->
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
                    <p align="center">You are about to delete Timesheet?Do you want to Continue...</p>

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

    <!--submitmodal-->
    <div id="submitinfomodal" class="modal fade custmodal" role="dialog">
        <div class="modal-dialog modalsmall">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Submit</h4>
                </div>

                <div class="modal-body">
                    <p align="center">Are you sure you want to submit entry?</p>
                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-left">
                                <button class="btn borderbtn ml-1" data-dismiss="modal">No</button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
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
    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
    <script src="../../../Whizible2.0/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->

    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0/plugins/jQueryUI/jquery-ui.min.js"></script>

    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap.min.js"></script>

    <!--daterangepicker-->
    <script src="../../../Whizible2.0/dist/js/moment.min.js"></script>


    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap-select.js"></script>

    <!-- AdminLTE App -->
    <!--<script src="../../../Whizible2.0/dist/js/app.min.js"></script>-->
    <!-- SlimScroll 1.3.0 -->
    <!--<script src="../../../Whizible2.0/plugins/slimScroll/jquery.slimscroll.min.js"></script>-->

    <!-- stickytable js -->
    <script src="../../../Whizible2.0/dist/js/stickytable/jquery.stickytable.js"></script>

    <script src="../../../Whizible2.0/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/loadingoverlay_progress.js"></script>
    <!-- custome js -->
    <script src="../../../Whizible2.0/dist/js/custom.js"></script>

    <script type="text/javascript">



        //select all checkboxes

        $("#Tapprovalall").change(function () {
            //debugger;
            var Checked = $(this).is(':checked');
            $("input[name=checkDelete]").prop('checked', Checked);

        });

        $('#MTstatusfiltertble').on('change', 'tbody td:nth-child(1) :checkbox', function () {

            var checked = $(this).is(':checked');
            if (checked == true) { SelectedRecords = 1; }
            else { $("#Tapprovalall").prop("checked", false); NoSelectedRecords = 1; }
        });

        var getselectedStatus = "Submitted";
        var selected = "R";
        $('.navstatuslink a').on('click', function () {
            //debugger;
            var Status = $(this).attr('id');
            getselectedStatus = Status;
            //alert(getselected);
            if (getselectedStatus == "Rejected") {
                selected = "J";
            }
            else if (getselectedStatus == "Approved") {
                selected = "V";
            }
            else if (getselectedStatus == "Submitted") {
                selected = "R";
            }
            else if (getselectedStatus == "All") {
                selected = "Null";
            }
         
            //$('input:checkbox').removeAttr('checked');
            $('input[type=checkbox]').prop('checked', false);


        });
        var isWeeklyView = 1;
        var taskParameters;
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

        var EmployeeID;
        var currentEmployeeID;
        EmployeeID = <%= Session("intUserID") %>  
            currentEmployeeID = EmployeeID;

        function CboResource_OnChange(employeeID) {

            currentEmployeeID = employeeID;
            ReloadData(currentEmployeeID);


        }

        $(document).ready(function () {
            if ('<%= Request.QueryString("PageFlag")%>' == 4) {
                  $("#CboResource option[value='" + '<%= Request.QueryString("EmployeeID")%>' + "']").attr("selected", "selected");
            }
           
            $('[data-toggle="tooltip"]').tooltip();
            $(".btn_lightred").tooltip();
            if ($('#CboResource option').length <= 1) {
                $(".selectpicker").selectpicker('refresh');
                $('#ProxyResource .bootstrap-select').css("display", "none");
                $('#ProxyTimesheet').css("display", "none");
                ReloadData(currentEmployeeID);
            }
            else {
                ReloadData(currentEmployeeID);

                $("#fixedtbl1").freezeHeader({
                    'height': '300px'
                });
                $("#fixedtbl2").freezeHeader({
                    'height': '300px'
                });
            }
        })
        $(function () {  //freez table headerand scrollblein modal poup
            $("#historyfixtbl").freezeHeader({
                'height': '300px'
            })
        });

        function ReloadData(ProxyResourceID) {
           // debugger;

            try {
                if (ProxyResourceID == 0)
                    ProxyResourceID = currentEmployeeID;
                taskParameters = {
                    employeeID: ProxyResourceID,
                    StatusCode: " ",
                }
                //debugger;          
                AjaxCall();
            }
            catch (ex) {
                alert(ex.message);
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                  
                    var MyTimesheet = data;
                    plotMyTimesheetList(MyTimesheet.MyTimesheetLists);                  
                  
                    AfterPlot();
                    StopAjaxLoader("#bodyMyTimesheet");
                    $("#" + getselectedStatus + "").trigger("click");
                     
                },
                error: function (err) {
                    alert("error");
                    console.log(err);
                }
            })

        }

        function plotMyTimesheetList(MyTimesheetLists) {
            
            $("#mytimesheettable").html('');
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
                //alert(ToDate);


                if (StatusDescription == 'Not ready for approval') { strHTML += " <tr data-status='statussaved' class='stsaved'>"; }
                else if (StatusDescription == 'Ready for approval') { strHTML += " <tr data-status='statussubmitted'  class='stsubmitted'>"; }
                else if (StatusDescription == 'Approved') { strHTML += " <tr data-status='statusapproved' class='stapproved' >"; }
                else if (StatusDescription == 'Rejected') { strHTML += " <tr data-status='statusrejected' class='strejected'>"; }

                strHTML += "<td>" +

                    "<div class='custom_chckbox'>";

                if (StatusDescription == 'Not ready for approval') {
                      //$(".tblchk").attr('style', 'cursor: not-allowed !important');
                    strHTML += "<input type='checkbox'  id='Tapprovalall_" + TimeSheetID + "' disabled  style='cursor:not-allowed'>";
                    strHTML += "<label for='Tapprovalall_" + TimeSheetID + "' style='cursor:not-allowed'></label>";
                }
                else if (StatusDescription == 'Ready for approval') {
                     //$(".tblchk").attr('style', 'cursor: not-allowed !important');
                    strHTML += "<input type='checkbox'  id='Tapprovalall_" + TimeSheetID + "'disabled  style='cursor:not-allowed'>"
                    strHTML += "<label for='Tapprovalall_" + TimeSheetID + "'  style='cursor:not-allowed'></label>";
                }
                else if (StatusDescription == 'Approved') {
                    // $(".tblchk").attr('style', 'cursor: not-allowed !important');
                    strHTML += "<input type='checkbox'  id='Tapprovalall_" + TimeSheetID + "'disabled  style='cursor:not-allowed'>"
                    strHTML += "<label for='Tapprovalall_" + TimeSheetID + "'  style='cursor:not-allowed'></label>";
                }
                else if (StatusDescription == 'Rejected') {
                    strHTML += "<input type='checkbox' name='checkDelete' id='Tapprovalall_" + TimeSheetID + "'>"
                    strHTML += "<label for='Tapprovalall_" + TimeSheetID + "'></label>";
                }
                var dateAr = FromDate.split('-');
                var StartDate = dateAr[2] + '-' + dateAr[1] + '-' + dateAr[0];
                strHTML += "</div>" +
                    "</td>" +
                    "<td>" + CreatedDate + "</td>" +
                    "<td class='mtdateperiod'> " +
                    "<input  id='FrmId_" + TimeSheetID + "'CboResource_OnChange type='hidden' value='" + FromDate + "'/>" +
                    "<input  id='ToId_" + TimeSheetID + "' type='hidden'  value='" + ToDate + "'>" +
                    "<a href='TimesheetEntry.aspx?Flag=2&TimesheetID=" + TimeSheetID + "&StartDate=" + StartDate + "&EmployeeID="+ currentEmployeeID +"&FromPage=MyTimesheet'>" + Period + "</a></td>" +
                    "<td>" + ActualHours + "</td>" +
                    "<td> " +
                    "<div class='btn-group btn-display'>";
                if (StatusDescription == 'Not ready for approval') { strHTML += "<button type='button'  class='btn btn_lightred'>Saved</button>"; }
                else if (StatusDescription == 'Ready for approval') { strHTML += " <button type='button'  class='btn btn-info '>Submitted</button>"; }
                else if (StatusDescription == 'Approved') { strHTML += " <button type='button' class='btn btn-success '>Approved</button>"; }
                else if (StatusDescription == 'Rejected') { strHTML += "<button type='button' class='btn btn-red'>Rejected</button>"; }

                strHTML += "<button data-toggle='modal' data-target='#historymodal' type='button' onclick='ShowHistory(" + TimeSheetID + ")' class='btn btn_lightred' title='History' data-placement='top'>" +
                    "<img class='pull-right' src='../../../Whizible2.0/dist/img/history-icon.svg' width='13px' alt=''>" +
                    "</button>" +
                    "</div>" +
                    "</td>" +
                    "<td class='text-left comment'  title='"+Comment.replace("'", "\"")+"'  data-toggle='tooltip' data-placement='left' data-container='body'><span class='comment'>" + Comment + "</span></td>" +
                    "</tr>";

                $("#mytimesheettable").html(strHTML);
                AfterPlot();
            }
        }

        $('.navstatuslink a').on('click', function () {
            //  debugger;

            var Status = $(this).attr('id');
            if (Status == 'All') {
                $(".tblchk").attr('style', 'cursor: poniter !important');
            $(".tblchk").attr('disabled', false);}
            else if (Status == 'Approved') {
                $(".tblchk").attr('style', 'cursor: not-allowed !important');
                 $(".tblchk").attr('disabled', true);
            }
            else if (Status == 'Rejected') {
                $(".tblchk").attr('style', 'cursor: pointer !important');
                 $(".tblchk").attr('disabled', false);  
            }
            else if (Status == 'Submitted') {
                $(".tblchk").attr('style', 'cursor: not-allowed !important');
             $(".tblchk").attr('disabled', true);}
        });

        function ShowHistory(TimeSheetID) {

            taskParameters = {
                intTimesheetID: TimeSheetID,
            }
            //alert(taskParameters);
            $.ajax({
                url: strUrl + '/api/MyTimesheet/GetMyTimesheetHistoryData',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    PlotHistorySection(data.MyTimesheetHistoryLists);

                },
                error: function (err) {
                    console.log(err);
                }
            })

        }
        function PlotHistorySection(TimesheetHistoryLists) {

            $("#tbodyHistory").html('');
            var strHTML = "";
            for (var i = 0; i < TimesheetHistoryLists.length; i++) {
                var HistoryObject = TimesheetHistoryLists[i];
                var DateAndTime = HistoryObject.DateAndTime;
                var ModifiedBy = HistoryObject.ModifiedBy;
                var Field = HistoryObject.Field;
                var OldValue = HistoryObject.OldValue;
                var NewValue = HistoryObject.NewValue;
                var Status = HistoryObject.Status;
                var CreatedDate = HistoryObject.CreatedDate;
                var UpdatedDate = HistoryObject.UpdatedDate;
                var ActionTakenBy = HistoryObject.ActionTakenBy;
                var ActionTaken = HistoryObject.ActionTaken;
                var ApproverName = HistoryObject.ApproverName;


                strHTML += "<tr>" +
                    "<td>" + Status + "</td>" +
                    "<td>" + CreatedDate + "</td>" +
                    "<td>" + UpdatedDate + "</td>" +
                    "<td>" + ActionTakenBy + "</td>" +
                    "<td>" + ActionTaken + "</td>" +
                    "<td>" + ApproverName + "</td>" +
                    "</tr>";

            }
            $("#tbodyHistory").html(strHTML);
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

        //On Yes button 

        function DeleteData() {

            $('input[name=checkDelete]:checked').each(function () {

                DeleteAjaxCall(this.id.split('Tapprovalall_')[1]);
            });

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
                $("#deletebtn").attr('data-toggle', 'modal');
                $("#deletebtn").attr('data-target', '#deleteinfomodal');
            }
        });



        function DeleteAjaxCall(ids) {
            //alert("IN DEL AJAX")
            //alert(ids);
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    console.log(data);

                    showAlert('Timesheet deleted successfully.', 'alert-success');

                    ReloadData(currentEmployeeID);
                    $("#deleteinfomodal").modal('hide');
                    $("#.navstatuslink a").trigger('click');
                    $("#.navstatuslink a").focus();

                },
                error: function (err) {

                    console.log(err);

                }
            })

        }


        //on submit button

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
                $("#submitbtn").attr('data-toggle', 'modal');
                $("#submitbtn").attr('data-target', '#submitinfomodal');
            }
        });

        function SubmitData() {
            $('input[name=checkDelete]:checked').each(function () {

                SubmitAjaxCall(this.id.split('Tapprovalall_')[1]);
            });

        }

        function ValidateData() {
            $('input[name=checkDelete]:checked').each(function () {

                ValidateAjaxCall(this.id.split('Tapprovalall_')[1]);

            });

        }

        function ValidateAjaxCall(IDs) {
            //debugger;
            //alert("IN ValidateAjaxCall");
            var Fromdate1 = document.getElementById("FrmId_" + IDs).value;
            var dateAr = Fromdate1.split('-');
            var Fromdate = dateAr[2] + '-' + dateAr[1] + '-' + dateAr[0];
            //alert(Fromdate);
            var Todate1 = document.getElementById("ToId_" + IDs).value;
            var dateArr = Todate1.split('-');
            var Todate = dateArr[2] + '-' + dateArr[1] + '-' + dateArr[0];
            //alert(Todate);
            var taskparameters = {
                intTimesheetID: IDs,
                employeeID: currentEmployeeID,
                dtFromDate: Fromdate,
                dtToDate: Todate,


            }
            //alert(currentEmployeeID);


            $.ajax({
                url: strUrl + '/api/MyTimesheet/ValidateMyTimesheet',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    console.log(data);
                    //alert(currentEmployeeID);                                 
                    if (data == "") {
                        //$("#submitbtn").attr('data-toggle', 'modal');
                        //$("#submitbtn").attr('data-target', '#submitinfomodal');

                    }
                    else {
                        showAlert(data, 'alert-danger');

                    }

                    //ReloadData(currentEmployeeID);                                       
                    $("#.navstatuslink a").trigger('click');
                    $("#.navstatuslink a").focus();

                },
                error: function (err) {
                    //alert("in error");
                    console.log(err);

                }
            })

        }


        function SubmitAjaxCall(IDs) {
            //debugger;
            //alert("IN submit AJAX");

            var Fromdate1 = document.getElementById("FrmId_" + IDs).value;
            var dateAr = Fromdate1.split('-');
            var Fromdate = dateAr[2] + '-' + dateAr[1] + '-' + dateAr[0];
            //alert(Fromdate);
            var Todate1 = document.getElementById("ToId_" + IDs).value;
            var dateArr = Todate1.split('-');
            var Todate = dateArr[2] + '-' + dateArr[1] + '-' + dateArr[0];
            //alert(Todate);
            var taskparameters = {
                employeeID: currentEmployeeID,
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    console.log(data);
                    //alert(currentEmployeeID);
                    //showAlert('Timesheet Submitted Successfully.', 'alert-success');
                    if (data == 1) {
                        window.open('../Email/SendEmail.aspx?MessageID=434&TimesheetID=' + IDs + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    }
                    ReloadData(currentEmployeeID);
                    $("#submitinfomodal").modal('hide');

                    $("#.navstatuslink a").trigger('click');
                    $("#.navstatuslink a").focus();

                },
                error: function (err) {
                    //alert("in error");
                    console.log(err);

                }
            })

        }

        function DownloadReport(ReportFormat) {

            //debugger;
            //alert("IN DW");           
            var parameters = {
                employeeID: currentEmployeeID,
                StatusCode: selected,
                ReportFormat: ReportFormat,

            }
            //alert(currentEmployeeID);
            //alert(selected);
            $.ajax({
                url: strUrl + '/api/MyTimesheet/ExportDocument',
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
                    if (data == "") {
                        showAlert('Records not available to download Report.', 'alert-danger');
                        // alert("NOT");
                    }
                    else {
                        window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + data, "_report", "");
                    }


                },
                error: function (err) {
                    console.log(err);
                    //alert("Error");
                }
            })
        }











    </script>

   

    <!-- stickytable js -->
    <!--<script src="../../../Whizible2.0/dist/js/table-fixed-header.js"></script>-->

    <!--freezetbl_header_in_modalpopupbox-->
    <script type="text/javascript" src="../../../Whizible2.0/dist/js/jquery.freezeheader.js"></script>


    <script>
        // @preserve jQuery.floatThead 1.2.9 - http://mkoryak.github.io/floatThead/ - Copyright (c) 2012 - 2014 Misha Koryak
// @license MIT
//!function(a){function b(a,b,c){if(8==g){var d=j.width(),e=f.debounce(function(){var a=j.width();d!=a&&(d=a,c())},a);j.on(b,e)}else j.on(b,f.debounce(c,a))}function c(a){window.console&&window.console&&window.console.log&&window.console.log(a)}function d(){var b=a('<div style="width:50px;height:50px;overflow-y:scroll;position:absolute;top:-200px;left:-200px;"><div style="height:100px;width:100%"></div>');a("body").append(b);var c=b.innerWidth(),d=a("div",b).innerWidth();return b.remove(),c-d}function e(a){if(a.dataTableSettings)for(var b=0;b<a.dataTableSettings.length;b++){var c=a.dataTableSettings[b].nTable;if(a[0]==c)return!0}return!1}a.floatThead=a.floatThead||{},a.floatThead.defaults={cellTag:null,headerCellSelector:"tr:first>th:visible",zIndex:1001,debounceResizeMs:10,useAbsolutePositioning:!0,scrollingTop:0,scrollingBottom:0,scrollContainer:function(){return a([])},getSizingRow:function(a){return a.find("tbody tr:visible:first>*")},floatTableClass:"floatThead-table",floatWrapperClass:"floatThead-wrapper",floatContainerClass:"floatThead-container",copyTableClass:!0,debug:!1};var f=window._,g=function(){for(var a=3,b=document.createElement("b"),c=b.all||[];a=1+a,b.innerHTML="<!--[if gt IE "+a+"]><i><![endif]-->",c[0];);return a>4?a:document.documentMode}(),h=null,i=function(){if(g)return!1;var b=a("<table><colgroup><col></colgroup><tbody><tr><td style='width:10px'></td></tbody></table>");a("body").append(b);var c=b.find("col").width();return b.remove(),0==c},j=a(window),k=0;a.fn.floatThead=function(l){if(l=l||{},!f&&(f=window._||a.floatThead._,!f))throw new Error("jquery.floatThead-slim.js requires underscore. You should use the non-lite version since you do not have underscore.");if(8>g)return this;if(null==h&&(h=i(),h&&(document.createElement("fthtr"),document.createElement("fthtd"),document.createElement("fthfoot"))),f.isString(l)){var m=l,n=this;return this.filter("table").each(function(){var b=a(this).data("floatThead-attached");if(b&&f.isFunction(b[m])){var c=b[m]();"undefined"!=typeof c&&(n=c)}}),n}var o=a.extend({},a.floatThead.defaults||{},l);return a.each(l,function(b){b in a.floatThead.defaults||!o.debug||c("jQuery.floatThead: used ["+b+"] key to init plugin, but that param is not an option for the plugin. Valid options are: "+f.keys(a.floatThead.defaults).join(", "))}),this.filter(":not(."+o.floatTableClass+")").each(function(){function c(a){return a+".fth-"+y+".floatTHead"}function i(){var b=0;A.find("tr:visible").each(function(){b+=a(this).outerHeight(!0)}),Z.outerHeight(b),$.outerHeight(b)}function l(){var a=z.outerWidth(),b=I.width()||a;if(X.width(b-F.vertical),O){var c=100*a/(b-F.vertical);S.css("width",c+"%")}else S.outerWidth(a)}function m(){C=(f.isFunction(o.scrollingTop)?o.scrollingTop(z):o.scrollingTop)||0,D=(f.isFunction(o.scrollingBottom)?o.scrollingBottom(z):o.scrollingBottom)||0}function n(){var b,c;if(V)b=U.find("col").length;else{var d;d=null==o.cellTag&&o.headerCellSelector?o.headerCellSelector:"tr:first>"+o.cellTag,c=A.find(d),b=0,c.each(function(){b+=parseInt(a(this).attr("colspan")||1,10)})}if(b!=H){H=b;for(var e=[],f=[],g=[],i=0;b>i;i++)e.push('<th class="floatThead-col"/>'),f.push("<col/>"),g.push("<fthtd style='display:table-cell;height:0;width:auto;'/>");f=f.join(""),e=e.join(""),h&&(g=g.join(""),W.html(g),bb=W.find("fthtd")),Z.html(e),$=Z.find("th"),V||U.html(f),_=U.find("col"),T.html(f),ab=T.find("col")}return b}function p(){if(!E){if(E=!0,J){var a=z.width(),b=Q.width();a>b&&z.css("minWidth",a)}z.css(db),S.css(db),S.append(A),B.before(Y),i()}}function q(){E&&(E=!1,J&&z.width(fb),Y.detach(),z.prepend(A),z.css(eb),S.css(eb))}function r(a){J!=a&&(J=a,X.css({position:J?"absolute":"fixed"}))}function s(a,b,c,d){return h?c:d?o.getSizingRow(a,b,c):b}function t(){var a,b=n();return function(){var c=s(z,_,bb,g);if(c.length==b&&b>0){if(!V)for(a=0;b>a;a++)_.eq(a).css("width","");q();var d=[];for(a=0;b>a;a++)d[a]=c.get(a).offsetWidth;for(a=0;b>a;a++)ab.eq(a).width(d[a]),_.eq(a).width(d[a]);p()}else S.append(A),z.css(eb),S.css(eb),i()}}function u(a){var b=I.css("border-"+a+"-width"),c=0;return b&&~b.indexOf("px")&&(c=parseInt(b,10)),c}function v(){var a,b=I.scrollTop(),c=0,d=L?K.outerHeight(!0):0,e=M?d:-d,f=X.height(),g=z.offset(),i=0;if(O){var k=I.offset();c=g.top-k.top+b,L&&M&&(c+=d),c-=u("top"),i=u("left")}else a=g.top-C-f+D+F.horizontal;var l=j.scrollTop(),m=j.scrollLeft(),n=I.scrollLeft();return b=I.scrollTop(),function(k){if("windowScroll"==k?(l=j.scrollTop(),m=j.scrollLeft()):"containerScroll"==k?(b=I.scrollTop(),n=I.scrollLeft()):"init"!=k&&(l=j.scrollTop(),m=j.scrollLeft(),b=I.scrollTop(),n=I.scrollLeft()),!h||!(0>l||0>m)){if(R)r("windowScrollDone"==k?!0:!1);else if("windowScrollDone"==k)return null;g=z.offset(),L&&M&&(g.top+=d);var o,s,t=z.outerHeight();if(O&&J){if(c>=b){var u=c-b;o=u>0?u:0}else o=P?0:b;s=i}else!O&&J?(l>a+t+e?o=t-f+e:g.top>l+C?(o=0,q()):(o=C+l-g.top+c+(M?d:0),p()),s=0):O&&!J?(c>b||b-c>t?(o=g.top-l,q()):(o=g.top+b-l-c,p()),s=g.left+n-m):O||J||(l>a+t+e?o=t+C-l+a+e:g.top>l+C?(o=g.top-l,p()):o=C,s=g.left-m);return{top:o,left:s}}}}function w(){var a=null,b=null,c=null;return function(d,e,f){null==d||a==d.top&&b==d.left||(X.css({top:d.top,left:d.left}),a=d.top,b=d.left),e&&l(),f&&i();var g=I.scrollLeft();J&&c==g||(X.scrollLeft(g),c=g)}}function x(){if(I.length){var a=I.width(),b=I.height(),c=z.height(),d=z.width(),e=d>a?G:0,f=c>b?G:0;F.horizontal=d>a-f?G:0,F.vertical=c>b-e?G:0}}var y=k,z=a(this);if(z.data("floatThead-attached"))return!0;if(!z.is("table"))throw new Error('jQuery.floatThead must be run on a table element. ex: $("table").floatThead();');var A=z.find("thead:first"),B=z.find("tbody:first");if(0==A.length)throw new Error("jQuery.floatThead must be run on a table that contains a <thead> element");var C,D,E=!1,F={vertical:0,horizontal:0},G=d(),H=0,I=o.scrollContainer(z)||a([]),J=o.useAbsolutePositioning;null==J&&(J=o.scrollContainer(z).length);var K=z.find("caption"),L=1==K.length;if(L)var M="top"===(K.css("caption-side")||K.attr("align")||"top");var N=a('<fthfoot style="display:table-footer-group;"/>'),O=I.length>0,P=!1,Q=a([]),R=9>=g&&!O&&J,S=a("<table/>"),T=a("<colgroup/>"),U=z.find("colgroup:first"),V=!0;0==U.length&&(U=a("<colgroup/>"),V=!1);var W=a('<fthrow style="display:table-row;height:0;"/>'),X=a('<div style="overflow: hidden;"></div>'),Y=a("<thead/>"),Z=a('<tr class="size-row"/>'),$=a([]),_=a([]),ab=a([]),bb=a([]);if(Y.append(Z),z.prepend(U),h&&(N.append(W),z.append(N)),S.append(T),X.append(S),o.copyTableClass&&S.attr("class",z.attr("class")),S.attr({cellpadding:z.attr("cellpadding"),cellspacing:z.attr("cellspacing"),border:z.attr("border")}),S.css({borderCollapse:z.css("borderCollapse"),border:z.css("border")}),S.addClass(o.floatTableClass).css("margin",0),J){var cb=function(a,b){var c=a.css("position"),d="relative"==c||"absolute"==c;if(!d||b){var e={paddingLeft:a.css("paddingLeft"),paddingRight:a.css("paddingRight")};X.css(e),a=a.wrap("<div class='"+o.floatWrapperClass+"' style='position: relative; clear:both;'></div>").parent(),P=!0}return a};O?(Q=cb(I,!0),Q.append(X)):(Q=cb(z),z.after(X))}else z.after(X);X.css({position:J?"absolute":"fixed",marginTop:0,top:J?0:"auto",zIndex:o.zIndex}),X.addClass(o.floatContainerClass),m();var db={"table-layout":"fixed"},eb={"table-layout":z.css("tableLayout")||"auto"},fb=z[0].style.width||"";x();var gb,hb=function(){(gb=t())()};hb();var ib=v(),jb=w();jb(ib("init"),!0);var kb=f.debounce(function(){jb(ib("windowScrollDone"),!1)},300),lb=function(){jb(ib("windowScroll"),!1),kb()},mb=function(){jb(ib("containerScroll"),!1)},nb=function(){m(),x(),hb(),ib=v(),(jb=w())(ib("resize"),!0,!0)},ob=f.debounce(function(){x(),m(),hb(),ib=v(),jb(ib("reflow"),!0)},1);O?J?I.on(c("scroll"),mb):(I.on(c("scroll"),mb),j.on(c("scroll"),lb)):j.on(c("scroll"),lb),j.on(c("load"),ob),b(o.debounceResizeMs,c("resize"),nb),z.on("reflow",ob),e(z)&&z.on("filter",ob).on("sort",ob).on("page",ob),z.data("floatThead-attached",{destroy:function(){var a=".fth-"+y;q(),z.css(eb),U.remove(),h&&N.remove(),Y.parent().length&&Y.replaceWith(A),z.off("reflow"),I.off(a),P&&(I.length?I.unwrap():z.unwrap()),J&&z.css("minWidth",""),X.remove(),z.data("floatThead-attached",!1),j.off(a)},reflow:function(){ob()},setHeaderHeight:function(){i()},getFloatContainer:function(){return X},getRowGroups:function(){return E?X.find("thead").add(z.find("tbody,tfoot")):z.find("thead,tbody,tfoot")}}),k++}),this}}(jQuery),function(a){a.floatThead=a.floatThead||{},a.floatThead._=window._||function(){var b={},c=Object.prototype.hasOwnProperty,d=["Arguments","Function","String","Number","Date","RegExp"];return b.has=function(a,b){return c.call(a,b)},b.keys=function(a){if(a!==Object(a))throw new TypeError("Invalid object");var c=[];for(var d in a)b.has(a,d)&&c.push(d);return c},a.each(d,function(){var a=this;b["is"+a]=function(b){return Object.prototype.toString.call(b)=="[object "+a+"]"}}),b.debounce=function(a,b,c){var d,e,f,g,h;return function(){f=this,e=arguments,g=new Date;var i=function(){var j=new Date-g;b>j?d=setTimeout(i,b-j):(d=null,c||(h=a.apply(f,e)))},j=c&&!d;return d||(d=setTimeout(i,b)),j&&(h=a.apply(f,e)),h}},b}()}(jQuery);



//$(document).ready(function(){

//$(".sticky-header").floatThead({scrollingTop:50});

//});




    </script>

    </body>

    </html>









