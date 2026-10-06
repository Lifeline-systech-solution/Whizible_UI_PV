<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TimesheetApproval.aspx.vb" Inherits="PbNIT.TimesheetApproval" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Timesheet Approval</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/jquery-ui.css">

    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap.min.css?v=1">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap-select.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0/fontawesome/css/all.css">
    <!--<link rel="stylesheet" href="../../../Whizible2.0/dist/css/bootstrap-datepicker.css">-->
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
    <%-- <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom.css?v=2">--%>
    <link href="../../../Whizible2.0/dist/css/style_custom.css" rel="stylesheet" />

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/media_queries.css?v=1">

    <link href="../../General/loaderStylesheet.css" rel="stylesheet" />

    <style type="text/css">
        .tbl-content {
            height: auto;
        }

        table .header-fixed {
            top: 0px !important;
        }

        #hdhistoryfixtbl {
            top: 40px !important;
            background: #fff;
            z-index: 9;
        }

        #hdScrollhistoryfixtbl {
            overflow-y: auto !important;
        }
    </style>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="bodyTSApproval">
    <div class="responsivewarningmsg">
        <h2>Please check on 1280px and high Resolution</h2>
    </div>

    <section class="content mytimesheet">
        <div class="graybg container-fluid pt-1 pb-1 mytimesheethdtop">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">

                    <div class="row">
                        <div class="col-sm-3"></div>
                        <div class="col-sm-5">

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
                        <div class="col-sm-4"></div>

                    </div>

                </div>


            </div>
        </div>


        <div class="weeklytimesheetwrap">
            <div class="timesheetrow container-fluid bgwhite ts_headerbot">
                <div class="row">
                    <div class="col-md-6 col-sm-12 col-xs-12 pull-right">
                        <div class="approval_crossandcheckbtn pull-right pt-1 hides">
                            <div class="input-group">
                                <button data-toggle="modal" id="btnApproveAllTimesheet" onclick="ShowApprovetaskbtnmodal(0,0,'','')" class="btn btn-outline-secondary btn-success" type="button" data-placement="left" title="Approve"><i class="fas fa-check" style="display: block"></i></button>
                                <button data-toggle="modal" id="btnRejectAllTimesheet" onclick="ShowRejecttaskmodal(0,0)" class="btn btn-outline-secondary btn-red" type="button" data-toggle="tooltip" data-placement="left" title="Reject"><i class="fas fa-times" style="display: block"></i></button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-12 col-xs-12" id="tabs">
                        <ul class="nav navbar-nav customelinks navstatuslink">
                            <li class="overdue"><a id="all" data-target="all" href="javascript:;">All <span id="spanAll"></span></a></li>
                            <li class="pending"><a id="Approved" data-target="statusapproved" href="javascript:;">Approved <span id="spanApproved"></span></a></li>
                            <li class="pending"><a id='Rejected' data-target="statusrejected" href="javascript:;">Rejected <span id="spanRejected"></span></a></li>
                            <li id="liSubmitted" class="active"><a id="Submitted" class="active" data-target="statussubmitted" href="javascript:;">Submitted <span id="spanSubmitted"></span></a></li>
                        </ul>
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



            <div class="table-outer">
                <div class="tbl-content">
                    <table id="table-1" class="table table-bordered tbl_custm tsapprovaltbl statusfiltertble table-fixed-header">
                        <thead class='header'>
                            <tr>

                                <th width="3%" class="text-center">
                                    <div class="custom_chckbox">
                                        <input type="checkbox" id="Tapprovalall" class="checkbox checkAll">
                                        <label for="Tapprovalall" class="checkTapprovalall"></label>
                                    </div>
                                </th>
                                <th class="text-center">Employee Name <i class="fas fa-filter" data-toggle="collapse" data-target="#TAfiltername" aria-expanded="false" aria-controls="navbar"></i>


                                    <div id="TAfiltername" class="selectpicker autocompletepicker collapse tblfiltering" data-clear="true" data-live="true">
                                        <div class="dropdown-menu" style="display: block;">
                                            <div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true">
                                                <label class="sr-only" for="txtSearchEmployee">Search...</label>
                                                <div class="search-box">
                                                    <div class="input-group">
                                                        <span class="input-group-addon" id="search-icon5">
                                                            <span class="fa fa-search"></span>
                                                            <a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Clear filter</span></a>
                                                        </span>
                                                        <input type="text" placeholder="Search..." id="txtSearchEmployee" class="form-control live-search" onkeyup="EmployeeSearchFuntion(this)" aria-describedby="search-icon5" tabindex="1" />
                                                    </div>
                                                </div>
                                                <div class="list-to-filter">
                                                    <ul class="list-unstyled">
                                                        <li class="optgroup">
                                                            <span class="optgroup-header">
                                                                <input id="EmployeecheckAll" class="checkbox checkAll" type="checkbox">All <span class="subtext"></span></span>
                                                            <ul class="list-unstyled" id="EmployeeFilter">
                                                                <%--<li class="filter-item items" data-filter="Jones Doe" data-value="1">
                                                                    <input type="checkbox" name="filterEmp" value="a" data-bind="checked: checked">
                                                                    Jones Doe</li>
                                                                <li class="filter-item items"  data-filter="Mark Nelson" data-value="2">
                                                                    <input type="checkbox" name="filterEmp" value="b">
                                                                    Mark Nelson</li>
                                                                <li class="filter-item items" data-filter="Abhishek Jain" data-value="3">
                                                                    <input type="checkbox" name="filterEmp" value="c">
                                                                    Abhishek Jain</li>
                                                                <li class="filter-item items" data-filter="Sagar Dev" data-value="4">
                                                                    <input type="checkbox" name="filterEmp" value="d">
                                                                    Sagar Dev</li>--%>
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                    <%--<div class="no-search-results">
                                                        <div class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>No entry for <strong>'<span></span>'</strong> was found.</div>
                                                    </div>--%>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="Filterproject" value="">
                                        <div class="clarfix"></div>
                                    </div>


                                </th>
                                <th class="text-center">Period</th>
                                <th width="6%" class="text-center">Actual Hours</th>
                                <th width="8%" class="text-center">Expected Hours</th>
                                <th width="10%" class="text-center">Status <i class="fas fa-filter" id="FontStatusFilter" data-toggle="collapse" data-target="#TAfilterstatus" aria-expanded="false" aria-controls="navbar"></i>

                                    <div id="TAfilterstatus" class="selectpicker autocompletepicker collapse tblfiltering" data-clear="true" data-live="true">
                                        <div class="dropdown-menu" style="display: block;">
                                            <div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true">
                                                <label class="sr-only" for="input-bts-ex-6">Search...</label>
                                                <div class="search-box">
                                                    <div class="input-group">
                                                        <span class="input-group-addon" id="search-icon6">
                                                            <span class="fa fa-search"></span>
                                                            <a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Clear filter</span></a>
                                                        </span>
                                                        <input type="text" placeholder="Search..." id="txtSearchStatus" onkeyup="StatusSearchFunction(this)" class="form-control live-search" aria-describedby="search-icon6" tabindex="1" />
                                                    </div>
                                                </div>
                                                <div class="list-to-filter">
                                                    <ul class="list-unstyled">
                                                        <li class="optgroup">
                                                            <span class="optgroup-header">
                                                                <input id="StatuscheckAll" class="checkbox checkAll" type="checkbox">All <span class="subtext"></span></span>
                                                            <ul class="list-unstyled" id="StatusFilterList">
                                                                <li class="filter-item items" data-target="statussubmitted" data-filter="Submitted" data-value="2">
                                                                    <input type="checkbox">
                                                                    Submitted</li>
                                                                <li class="filter-item items" data-target="statusapproved" data-filter="Approved" data-value="3">
                                                                    <input type="checkbox">
                                                                    Approved</li>
                                                                <li class="filter-item items" data-filter="Rejected" data-target="statusrejected" data-value="4">
                                                                    <input type="checkbox">
                                                                    Rejected</li>
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

                                </th>
                                <th width="28%" class="text-center">Approve/Reject Comment</th>

                            </tr>
                        </thead>

                        <tbody id="tbodyTimesheetApproval">
                        </tbody>

                    </table>

                </div>

            </div>



            <!--table end here-->
            <%-- <div class="clearfix"></div>--%>
        </div>

    </section>
    <!-- /.content -->




    <!--rejectmodal-->
    <div id="rejecttaskmodal" class="modal fade custmodal rejecttaskmodal" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Reject Timesheet</h4>
                    <%-- <center><small>28-05-2018 &nbsp;To &nbsp; 03-06-2018</small></center>--%>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 text-right">Reason for rejection:</div>
                            <div class="col-xs-12 col-sm-8">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12">
                                        <textarea class="form-control" id="txtRejectionComment" maxlength="1000" onkeyup="LimitText(this)">
                                                                      
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

                    <%--<div class="form-group">
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
                    </div>--%>

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

    <!-- Modal -->
    <div id="historymodal" class="modal fade custmodal" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Timesheet Approval History</h4>
                </div>
                <div class="modal-body">

                    <table id="historyfixtbl" class="table cust_fixed_tbl">
                        <thead>
                            <%-- <tr>
                                <th>Date and Time</th>
                                <th>Modified By</th>
                                <th>Field</th>
                                <th>Old Value</th>
                                <th>New Value</th>
                                <th>Comments</th>
                            </tr>--%>
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
                            <%--<tr>
                                <td>13 Sep 2018  8:22pm</td>
                                <td>Sukanya.vaidya</td>
                                <td>Organisation Unit</td>
                                <td>Old Value</td>
                                <td>New Value</td>
                                <td>Comments</td>
                            </tr>--%>
                        </tbody>

                    </table>

                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!--modalEnd-->







    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
    <script src="../../../Whizible2.0/plugins/jQuery/jQuery-2.1.4.min.js"></script>

    <!-- jqueryUI js -->

    <script src="../../../Whizible2.0/plugins/jQueryUI/jquery-ui.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap-select.js"></script>

    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap.min.js"></script>

    <!--daterangepicker-->
    <script src="../../../Whizible2.0/dist/js/moment.min.js"></script>
    <!--bootstrapdatepicker-->
    <%--  <script src="../../../Whizible2.0/dist/js/bootstrap-datepicker.min.js"></script> --%>

    <!--autofilter-->
    <script src="../../../Whizible2.0/dist/js/autocomplete/tabcomplete.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/autocomplete/livefilter.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/autocomplete/bootstrap-select-autocomplete.js"></script>

    <script src="../../../Whizible2.0/plugins/alertify/alertify.min.js"></script>
    <link href="../../../Whizible2.0/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
     <script src="../../../Whizible2.0/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/loadingoverlay_progress.js"></script>
    <!-- custome js -->
    <script src="../../../Whizible2.0/dist/js/custom.js"></script>

    <!--weekpicker-->
    <script>
        var isWeeklyView = 1;
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

        var EmployeeID;
        var startingDayOfWeek;
        var FinancialYearStart;

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
    </script>
    <%--  <script type="text/javascript" src="../../../Whizible2.0/dist/js/weekPicker.js"></script>--%>
    <script src="../../../Whizible2.0/dist/js/weekPicker.js"></script>
    <script src="../../General/CommonFunctions.js"></script>
    <%-- <script src="../../../Whizible2.0/dist_new/js/weekPicker.js"></script>--%>
    <script type="text/javascript">

        $(function () {

            $(".tsapprovaltbl .custom_chckbox input[type='checkbox']").click(function () {
                if ($("#table-1 td").closest("tr:visible").length == 0) { $(this).prop("checked", false); }
                if ($(this).is(":checked")) {

                    if (getSelectedStatus == 'Submitted' || getSelectedStatus == 'Approved') {
                        $(".ts_headerbot .approval_crossandcheckbtn").show();
                        if (getSelectedStatus == 'Approved') {
                            $("#btnApproveAllTimesheet").hide();
                        }
                        else {
                            $("#btnApproveAllTimesheet").show();
                        }
                    }
                } else {
                    $(".ts_headerbot .approval_crossandcheckbtn").hide();

                }
            });
            var NoSelectedRecords = 0;
            var SelectedRecords = 0;
            $('#table-1').on('change', 'tbody td:nth-child(1) :checkbox', function () {

                var checked = $(this).is(':checked');
                if (checked == true) { SelectedRecords = 1; }
                else { $("#Tapprovalall").prop("checked", false); NoSelectedRecords = 1; }
                $(".ts_headerbot .approval_crossandcheckbtn").toggle(!!$('.chktbl:checkbox:checked').length)
            });

            $("#fixedtbl2").freezeHeader({
                'height': '300px'
            });
            //freez table headerand scrollblein modal poup
            $("#historyfixtbl").freezeHeader({
                'height': '300px'
            })
        });



        $(".tsapprovaltbl .custom_chckbox input[type='checkbox']").change(function () {
            $(this).closest('tr').toggleClass('activerow');
        });
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var taskParameters;
        var getSelectedStatus = "Submitted";
        EmployeeID = <%= Session("intUserID") %>;
        var PageFlag = 0;
        // EmployeeID = 468;
        $('#next').click(function () {
            //debugger;
            setWeekCalendar($('#weekPicker2'), 'next', 1, startingDayOfWeek, FinancialYearStart);
            ReloadData(EmployeeID);


        });

        $('#prev').click(function () {
            //debugger;
            setWeekCalendar($('#weekPicker2'), 'prev', 1, startingDayOfWeek, FinancialYearStart);
            ReloadData(EmployeeID);



        });
        jQuery(document).ready(function () {
            $(".btn_lightred").tooltip();
            //  debugger;


            PageFlag = '<%= Request.QueryString("Flag")%>';
            if (PageFlag == 3) {

                setWeekCalendar($('#weekPicker2'), 'Selected', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("StartDate")%>'));
                $("#" + '<%= Request.QueryString("SelectedStatus")%>' + "").trigger("click");
            }
            else {
                setWeekCalendar($('#weekPicker2'), 'yes', 1, startingDayOfWeek, FinancialYearStart);
            }
            ReloadData(EmployeeID);

        })
        $("#weekPicker2").change(function () {

            ReloadData(EmployeeID);

        })

        function FilterSelectedStatus() {

            $("#" + getSelectedStatus + "").trigger("click");
            //$("#" + getSelectedStatus + "").focus();
        }
        function ReloadData(ProxyResourceID) {
            //  debugger;
            if (ProxyResourceID == 0)
                ProxyResourceID = EmployeeID;
            taskParameters = {
                intEmployeeID: ProxyResourceID,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),

            }

            AjaxCall(taskParameters);

        }
        function AjaxCall(taskParameters) {
            // debugger;
            // alert(EmployeeID);
             StartLoader("#bodyTSApproval");
            $.ajax({
                url: strUrl + '/api/TimesheetApproval/GetTimesheetData',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    console.log(data);

                    var TimesheetApproval = data;
                    //  PlotDateTimeSection(TimesheetApproval.GetWeekCount)
                    PlotStatusSection(TimesheetApproval.TimesheetStatusLists)
                    PlotEmployeeSection(TimesheetApproval.TimesheetEmployeeList)
                    PlotTimesheetApprovalSection(TimesheetApproval.TimesheetApprovalLists)
                    //debugger;
                    AfterPlot();
                    StopAjaxLoader("#bodyTSApproval");
                    $("#" + getSelectedStatus + "").trigger("click");
                },
                error: function (err) {
                    console.log(err);
                    //alert(data)
                }
            })
        }

        function PlotDateTimeSection(GetWeekCount) {

            var WeekNumber = GetWeekCount.WeekNumber;
            var year = GetWeekCount.Year;

        }
        function PlotStatusSection(TimesheetStatusLists) {
            $("#StatusFilterList").html('');
            var strHTML = "";
            for (var i = 0; i < TimesheetStatusLists.length; i++) {
                var StatusObject = TimesheetStatusLists[i];
                var StatusCode = StatusObject.StatusCode;
                var StatusDescription = StatusObject.StatusDescription;
                if (StatusDescription != 'Not ready for approval') {

                    strHTML += "<li class='filter-item items' data-filter='Saved' data-value='" + StatusCode + "'>";
                    strHTML += "<input type='checkbox' name='filterStatus' value='" + StatusCode + "'>";
                    if (StatusDescription == 'Ready for approval') { strHTML += " Submitted</li>"; }
                    else { strHTML += " " + StatusDescription + "</li>"; }

                }
            }
            $("#StatusFilterList").html(strHTML);
        }
        function PlotEmployeeSection(TimesheetEmployeeList) {
            $("#EmployeeFilter").html('');
            var strHTML = "";
            for (var i = 0; i < TimesheetEmployeeList.length; i++) {
                var EmployeeObject = TimesheetEmployeeList[i];
                var EmployeeID = EmployeeObject.EmployeeID;
                var EmployeeName = EmployeeObject.EmployeeName;

                strHTML += "<li class='filter-item items' data-filter='" + EmployeeName + "' data-value='" + EmployeeID + "'>";
                strHTML += "<input type='checkbox' name='filterEmp' class='filterEmployee' value='" + EmployeeID + "'>";

                strHTML += " " + EmployeeName + "</li>";
            }
            $("#EmployeeFilter").html(strHTML);
        }
        var TimesheetApprovalData = [];

        function PlotTimesheetApprovalSection(TimesheetApprovalLists) {
            // debugger;
            $("#tbodyTimesheetApproval").html('');
            var ARowCount = 0;
            var RRowCount = 0;
            var SRowCount = 0;
            var AllCount = 0;
            var strHTML = "";
            for (var i = 0; i < TimesheetApprovalLists.length; i++) {

                //debugger;
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
                // alert(taskParameters.dtFromDate);
                if (StatusDescription == 'Not ready for approval') { strHTML += " <tr data-status='statussaved' id='tr_" + TimeSheetID + "' class='" + EmployeeID + "'>"; }
                else if (StatusDescription == 'Ready for approval') { strHTML += " <tr data-status='statussubmitted' id='tr_" + TimeSheetID + "' class='" + EmployeeID + "'>"; }
                else if (StatusDescription == 'Approved') { strHTML += " <tr data-status='statusapproved' id='tr_" + TimeSheetID + "' class='" + EmployeeID + "'>"; }
                else if (StatusDescription == 'Rejected') { strHTML += " <tr data-status='statusrejected' id='tr_" + TimeSheetID + "' class='" + EmployeeID + "'>"; }

                strHTML += "<td><div class='custom_chckbox'>";

                if (StatusDescription == 'Approved') {
                    strHTML += "  <input type='checkbox' id='Tapproved" + TimeSheetID + "' name='Tapproved' class='chktbl'>";
                    strHTML += "   <label for='Tapproved" + TimeSheetID + "' class='chktbl'></label>";

                }
                else if (StatusDescription == 'Ready for approval') {
                    strHTML += "  <input type='checkbox' id='TSubmitted" + TimeSheetID + "' name='TSubmitted' class='chktbl'>";
                    strHTML += "   <label for='TSubmitted" + TimeSheetID + "' class='chktbl'></label>";
                }
                else {
                    strHTML += "  <input type='checkbox' id='Tall" + TimeSheetID + "' name='Tall' class='chktbl' onclick='return false;'>";
                    strHTML += "   <label for='Tall" + TimeSheetID + "' class='chktbl'></label>";
                }

                strHTML += "     </div>" +
                    " </td>" +
                    "<td id='" + EmployeeID + "' class='clsEmployee " + EmployeeID + "'>" + EmployeeName + "</td>" +
                    "<td class='mtdateperiod' id='" + FromDate + "_TO_" + ToDate + "'><a href='javascript:;' onclick=OpenTimesheetApprovalDetail(" + TimeSheetID + "," + EmployeeID + ",'" + FromDate + "','" + ToDate + "') >" + Period + "</a></td>" +
                    "<td>" + ActualHours + "</td>" +
                    "<td class=''>" + ExpectedHours + "</td>" +
                    "<td class='clsStatus'>" +

                    "   <div class='btn-group btn-display'>";
                if (StatusDescription == 'Not ready for approval') { strHTML += "<button type='button' id='" + StatusCode + "' class='btn btn_lightred'>Saved</button>"; }
                else if (StatusDescription == 'Ready for approval') { strHTML += " <button type='button' id='" + StatusCode + "' class='btn btn-info '>Submitted</button>"; SRowCount += 1; }
                else if (StatusDescription == 'Approved') { strHTML += " <button type='button' id='" + StatusCode + "' class='btn btn-success '>Approved</button>"; ARowCount += 1; }
                else if (StatusDescription == 'Rejected') { strHTML += "<button type='button' id='" + StatusCode + "' class='btn btn-red'>Rejected</button>"; RRowCount += 1; }

                strHTML += "<button data-toggle='modal' data-target='#historymodal' type='button' onclick='ShowHistory(" + TimeSheetID + ")' class='btn btn_lightred' title='History'  data=placement='top'> " +
                    "           <img class='pull-right' src='../../../Whizible2.0/dist/img/history-icon.svg' width='13px' alt=''>" +
                    "       </button>" +
                    "   </div>" +
                    "</td>" +
                    "<td class='text-left comment'  title='"+Comment.replace("'", "\"")+"'  data-toggle='tooltip' data-placement='left' data-container='body'><span class='comment'>" + Comment + "</span>";
                if (StatusDescription != 'Rejected') {
                    strHTML += "<div class='approval_crossandcheckbtn pull-right hides'>" +
                        " <div class='input-group'>";
                    if (StatusDescription == 'Ready for approval') {
                        strHTML += '     <button data-toggle="modal" onclick=ShowApprovetaskbtnmodal(' + TimeSheetID + ',' + EmployeeID + ',"' + FromDate + '","' + ToDate + '") class="btn btn-outline-secondary btn-success" type="button" data-placement="left" title="Approve"><i class="fas fa-check"></i></button>';
                    }
                    if (StatusDescription == 'Approved') {
                        strHTML += "      <button data-toggle='modal' onclick=ShowRejecttaskmodal(" + TimeSheetID + "," + EmployeeID + ",'" + FromDate + "','" + ToDate + "') class='btn btn-outline-secondary btn-red' type='button' data-toggle='tooltip' data-placement='left' title='Reject'  style='border-radius:3px'><i class='fas fa-times'></i></button>";
                        }
                    else {
                        strHTML += "      <button data-toggle='modal' onclick=ShowRejecttaskmodal(" + TimeSheetID + "," + EmployeeID + ",'" + FromDate + "','" + ToDate + "') class='btn btn-outline-secondary btn-red' type='button' data-toggle='tooltip' data-placement='left' title='Reject'><i class='fas fa-times'></i></button>";
                    }
                        strHTML += "   </div>" +
                        "</div>";
                }
                strHTML += "</td></tr>";
                //alert(strHTML);
                $("#tbodyTimesheetApproval").html(strHTML);
                TimesheetApprovalData.push({
                    TimeSheetID: TimeSheetID,
                    EmployeeID: EmployeeID,
                    EmployeeName: EmployeeName,
                    StatusCode: StatusCode,
                    StatusDescription: StatusDescription
                })
            }
            AllCount = ARowCount + RRowCount + SRowCount;

            //$("#spanAll").html(AllCount);
            //alert(AllCount);

        }
        function OpenTimesheetApprovalDetail(TimeSheetID, EmployeeID, FromDate, ToDate) {
            //debugger;
            //alert(getSelectedStatus);
            window.location.href = "TimesheetEntry.aspx?intTimesheetId=" + TimeSheetID + "&Flag=3&intEmployeeID=" + EmployeeID + "&FromDate=" + FromDate + "&ToDate=" + ToDate + "&StartDate=" + taskParameters.dtFromDate + "&SelectedStatus=" + getSelectedStatus + "";
        }
        function ShowHistory(TimeSheetID) {

            taskParameters = {
                intTimesheetID: TimeSheetID,
            }
            //alert(taskParameters);
            $.ajax({
                url: strUrl + '/api/TimesheetApproval/GetTimesheetHistoryData',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {

                    PlotHistorySection(data.TimesheetHistoryLists)

                },
                error: function (err) {
                    console.log(err);
                    //alert("error")
                }
            })
        }
        function PlotHistorySection(TimesheetHistoryLists) {
            //alert("dsfd");
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
                strHTML += " <tr>" +
                    " <td>" + Status + "</td>" +
                    " <td>" + CreatedDate + "</td>" +
                    "  <td>" + UpdatedDate + "</td>" +
                    "   <td>" + ActionTakenBy + "</td>" +
                    "    <td>" + ActionTaken + "</td>" +
                    "     <td>" + ApproverName + "</td>" +
                    "</tr>";
            }
            $("#tbodyHistory").html(strHTML);
        }
        function ShowApprovetaskbtnmodal(Tid, ResourseID, FromDate, ToDate) {

            $("#txtApprovalComment").val("");
            $("#approvetaskbtnmodal").modal('show');

            document.getElementById("btnApproveTimesheet").setAttribute("onClick", "ApproveAllTimesheet(" + Tid + "," + ResourseID + ",'" + FromDate + "','" + ToDate + "');");

        }
        function ShowRejecttaskmodal(Tid, ResourseID, FromDate, ToDate) {

            $("#txtRejectionComment").val("");
            $("#rejecttaskmodal").modal('show');

            document.getElementById("btnRejectTimesheet").setAttribute("onClick", "RejectAllTimesheet(" + Tid + "," + ResourseID + ",'" + FromDate + "','" + ToDate + "');");
        }
        function ApproveAllTimesheet(Tid, ResourseID, FromDate, ToDate) {
            // alert(Tid);
            // if (confirm("Do you want to Approve the selected Timesheets?")) {
            var strComment = "";
            strComment = $("#txtApprovalComment").val();

            //  debugger;
            if (Tid == 0) {
                var CheckedTimesheetIDs = [];
                $.each($("input[name='TSubmitted']:checked"), function () {
                    var Tid = this.id.split('TSubmitted')[1];
                    var trid = $(this).closest('tr').attr('id');
                    var FDate = $("#" + trid + " td:nth-child(3)").attr('id').split("_TO_")[0];
                    var TDate = $("#" + trid + " td:nth-child(3)").attr('id').split("_TO_")[1];
                    var RID = $("#" + trid + " td:nth-child(2)").attr('id');
                    //  alert(TDate);

                    ApproveTimesheetAjaxCall(Tid, 'V', strComment, RID, FDate, TDate);
                });

            }
            else {
                ApproveTimesheetAjaxCall(Tid, 'V', strComment, ResourseID, FromDate, ToDate);

            }

            $("#approvetaskbtnmodal").modal('hide');
            // }
        }
        function ApproveTimesheetAjaxCall(Tid, strStatus, strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit = 0) {
            taskParameters = {
                intTimesheetID: Tid,
                Status: strStatus,
                intEmployeeID: EmployeeID,
                strComment: strComment,
                intAllowToResubmit: bitAllowToResubmit,
                intResourceID : ResourseID,
            }
             StartLoader("#bodyTSApproval");
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
                    //alert(data);
                    //debugger;
                    if (data == 1) {
                        if (strStatus == 'V') {
                            window.open('../Email/SendEmail.aspx?MessageID=435&VerifiedBy=' + EmployeeID + '&ResourceID=' + ResourseID + '&FromDate=' + FromDate + '&ToDate=' + ToDate + '&TimesheetID='+ Tid +'', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=580');

                            //sendEmailAjaxCall();
                        }
                        else if (strStatus == 'J') {
                            window.open('../Email/SendEmail.aspx?MessageID=436&VerifiedBy=' + EmployeeID + '&ResourceID=' + ResourseID + '&FromDate=' + FromDate + '&ToDate=' + ToDate + '&TimesheetID='+ Tid +'', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=580');
                        }
                    }
                    ReloadData(EmployeeID);

                },
                error: function (err) {
                    console.log(err);
                     StopAjaxLoader("#bodyTSApproval");
                }
            })
        }

        function RejectAllTimesheet(Tid, ResourseID, FromDate, ToDate) {
            // alert(ResourseID);
            // debugger;
            //  if (confirm("Do you want to Reject the selected Timesheets?")) {
            var strComment = "";
            strComment = $("#txtRejectionComment").val();

            var bitAllowToResubmit = ($("#rejecttaskmodalcheckbox").is(':checked') ? 1 : 0);
            //alert(bitAllowToResubmit);
            if (Tid == 0) {
                var CheckedTimesheetIDs = [];
                if (getSelectedStatus == "Approved") {
                    $.each($("input[name='Tapproved']:checked"), function () {
                        var Tid = this.id.split('Tapproved')[1];
                        ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit);
                        //CheckedTimesheetIDs.push(Tid);
                    });
                    //ReloadData(EmployeeID);
                    $("#rejecttaskmodal").modal('hide');

                }
                else if (getSelectedStatus == "Submitted") {
                    $.each($("input[name='TSubmitted']:checked"), function () {
                        var Tid = this.id.split('TSubmitted')[1];
                        ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit);
                        //CheckedTimesheetIDs.push(Tid);
                    });
                    //ReloadData(EmployeeID);
                    $("#rejecttaskmodal").modal('hide');
                    //FilterSelectedStatus();
                }
            }
            else {
                ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit);
                //ReloadData(EmployeeID);
                $("#rejecttaskmodal").modal('hide');
            }

        }



        $("#Tapprovalall").change(function () {

            var checked = $(this).is(':checked');
            // $(".chktbl").prop("checked", checked);
            $("#table-1 tbody tr:visible").find("td .chktbl").prop("checked", checked);
            //var rowCount = $("#table-1 td").closest("tr:visible").length;
            // alert(rowCount);
        });
        //$(".chktbl").change(function () {
        //    alert("sd");
        //    //var checked = $(this).is(':checked');
        //    //if (checked == false) {$("#Tapprovalall").prop("checked", false);}

        //});



        var SelNavStatus = 'all';
        $("#EmployeecheckAll").change(function () {
            filterEmployeeColumn();
        });
        $("#StatuscheckAll").change(function () {
            filterStatusColumn();
        });
        //$(".filterEmployee").change(function () {
        //    alert("sd");
        //});
        // $(".filterEmployee").on('change', '[type=checkbox]', function () {
        //     alert("sd");
        //});
        //$("#Tapproved").change(function () {
        //    alert("sd")
        //    //if ($(this).is(":checked")) {
        //    //    $("#btnApproveAllTimesheet").hide();
        //    //}
        //   // if (Status == 'Approved') { $("#btnApproveAllTimesheet").hide();}
        //})

        $("#EmployeeFilter").on('click', '[type=checkbox]', function () {
            if ($(this).is(":checked") == false) {
                $("#EmployeecheckAll").removeAttr('checked');
            }
            filterEmployeeColumn();
        });
        function filterEmployeeColumn() {
           // debugger;
            var classes = [];
           // $("#filterEmp").prop("checked", true);
            $("input[name='filterEmp']").each(function () {
               // debugger;
                if ($(this).is(":checked")) { classes.push('.' + $(this).val()); }
                else {
                   
                  //   
                }
            });
            $("#table-1 tbody tr").hide();

            $("#table-1 tbody tr").each(function () {
                var show = false;
                var row = $(this);
                if (classes == "") { // if no filters selected, show all items
                    if (SelNavStatus != 'all') {
                        if (row.find('td .btn').html() == "" + SelNavStatus + "") { row.show(); }
                        else { row.hide(); }
                    }
                    else {
                        $("#table-1 tbody tr").show();
                    }

                }
                else { // otherwise, hide everything...
                    classes.forEach(function (className) {
                        //alert(className);
                        if ('.' + row.attr('class') == "" + className + "") { show = true; } else { }
                    });
                    if (show) { row.show(); }
                }

            });

        }

        $("#StatusFilterList").on('click', '[type=checkbox]', function () {

            filterStatusColumn();
        });
        function filterStatusColumn() {
            // debugger;
            var classes = [];
            var data = [];
            var uniqueEmployees = [];
            $("input[name='filterStatus']").each(function () {
                if ($(this).is(":checked")) { classes.push('.' + $(this).val()); }
                else {
                    //debugger;
                    $("#StatuscheckAll").removeAttr('checked');
                }
            });
            $("#table-1 tbody tr").hide();

            $("#table-1 tbody tr").each(function () {
                var show = false;
                var row = $(this);
                if (classes == "") { // if no filters selected, show all items
                    var EmpId = (row.find('.clsEmployee')).attr('id')
                    var EmpName = row.find('.clsEmployee').html()
                    data.push({
                        EmployeeID: EmpId,
                        EmployeeName: EmpName,
                    })
                    $("#table-1 tbody tr").show();
                }
                else { // otherwise, hide everything...
                    classes.forEach(function (className) {
                        //alert((row.find('.clsStatus .btn')).attr('id'));
                        if ('.' + (row.find('.clsStatus .btn')).attr('id') == "" + className + "") {
                            var EmpId = (row.find('.clsEmployee')).attr('id')
                            var EmpName = row.find('.clsEmployee').html()
                            data.push({
                                EmployeeID: EmpId,
                                EmployeeName: EmpName,
                            })
                            show = true;
                        }
                    });
                    if (show) { row.show(); }
                }

            });
            $.each(data, function (index, entry) {
                if (!data[entry.EmployeeID]) {
                    data[entry.EmployeeID] = true;
                    uniqueEmployees.push(entry);
                }
            });
            PlotEmployeeSection(uniqueEmployees);
        }

        $('.navstatuslink a').on('click', function () {
           //  debugger;

            var Status = $(this).attr('id');

            getSelectedStatus = Status;

            if (Status == 'all') {
               
                $("#FontStatusFilter").show(); uncheckAllItems();
                $("#Tapprovalall").attr('disabled', true);
                $(".chktbl").attr('disabled', true);
                $(".checkTapprovalall").attr('style', 'cursor: not-allowed !important');
                 $(".chktbl").attr('style', 'cursor: not-allowed !important');
            }
            else {
                $("#FontStatusFilter").hide(); uncheckAllItems();
                if (Status == 'Rejected') {
                    $("#Tapprovalall").attr('disabled', true); $(".chktbl").attr('disabled', true);
                    $(".checkTapprovalall").attr('style', 'cursor: not-allowed !important');
                     $(".chktbl").attr('style', 'cursor: not-allowed !important');
                }

                else {
                    $("#Tapprovalall").attr('disabled', false); $(".chktbl").attr('disabled', false);
                    $(".checkTapprovalall").attr('style', 'cursor: pointer !important');
                 $(".chktbl").attr('style', 'cursor: pointer !important');
                    if (Status == 'Approved') { $("#btnApproveAllTimesheet").hide(); }
                    else { $("#btnApproveAllTimesheet").show(); }
                }


            }


            SelNavStatus = Status;

            var data = [];
            var uniqueEmployees = [];
            $("#table-1 tbody tr").each(function () {
                var show = false;
                var row = $(this);
                if (Status != 'all') {
                    if (row.find('td .btn').html() == "" + Status + "") {
                        var EmpId = (row.find('.clsEmployee')).attr('id')
                        var EmpName = row.find('.clsEmployee').html()
                        data.push({
                            EmployeeID: EmpId,
                            EmployeeName: EmpName,
                        })

                    }
                }
                else {

                    var EmpId = (row.find('.clsEmployee')).attr('id')
                    var EmpName = row.find('.clsEmployee').html()
                    data.push({
                        EmployeeID: EmpId,
                        EmployeeName: EmpName,
                    })
                }
            });

            $.each(data, function (index, entry) {
                if (!data[entry.EmployeeID]) {
                    data[entry.EmployeeID] = true;
                    uniqueEmployees.push(entry);
                }
            });

            PlotEmployeeSection(uniqueEmployees);
        });
        function uncheckAllItems() {
            $('input:checkbox').removeAttr('checked');
            $(".ts_headerbot .approval_crossandcheckbtn").hide();
        }
        function EmployeeSearchFuntion(element) {

            var value = $(element).val().toLowerCase();
            $("#EmployeeFilter > li").each(function () {
                if ($(this).text().toLowerCase().indexOf(value) > -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        function StatusSearchFunction(element) {

            var value = $(element).val().toLowerCase();
            $("#StatusFilterList > li").each(function () {
                if ($(this).text().toLowerCase().indexOf(value) > -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        function ajaxCallTimesheet(url, type, contentType, dataType, data) {
            var ajaxResult
            $.ajax({
                url: url,
                type: type,
                contentType: contentType,
                dataType: dataType,
                data: data,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (result) {

                    ajaxResult = result;
                    //alert("success");
                },
                error: function (xhr) {
                    console.log(xhr);
                }
            })
            //debugger;
            return ajaxResult;
        }
        function LimitText(txt) {
            //debugger;
            var maxlength = $(txt).attr("maxlength");
            var currentLength =$(txt).val().length;

            if( currentLength >= maxlength ){
                 showAlert("You can enter only 1000 characters.","alert-danger");
             }else{
                 // alert(maxlength - currentLength + " chars left");
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
        function ParseDate(input) {
            //debugger;
            theDate = new Date(parseInt(input.substring(6, 19)));

            return theDate.toLocaleDateString().replace(/[^A-Za-z 0-9 \.,\?""!@#\$%\^&\*\(\)-_=\+;:<>\/\\\|\}\{\[\]`~]*/g, '');
            //return theDate.toString('MM-dd-YYYY');
        }
    </script>
    <!-- stickytable js -->
    <%--<script src="../../../Whizible2.0/dist/js/table-fixed-header.js"></script>--%>
    <!--freezetbl_header_in_modalpopupbox-->
    <script type="text/javascript" src="../../../Whizible2.0/dist/js/jquery.freezeheader.js"></script>




</body>
</html>
