<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyTimesheet.aspx.vb" Inherits="PbNIT.MyTimesheet" %>

<!DOCTYPE html>
<html>
<%--          <-- Commented by Param for JQuery and Bootstrap version upgrade -->--%>
        <%CommonFunctions.General.PlotPageHeadTag("My Timesheet")%> 
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>My Timesheet</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=6">



</head>
    <style type="text/css">
     /* Added by Madhuri.K For datatable Header Start here */
 #historyfixtbl_wrapper .dataTables_scrollHeadInner, #historyfixtbl_wrapper table{width:100%!important}
        .table-outer {
            padding: 0 9px 0px 0px;
        }
 /* Added by Madhuri.K For datatable Header End here */
 #hdhistoryfixtbl{background:#fff;z-index:9}
.tooltip >.tooltip-inner{word-wrap:break-word}
table .header-fixed{top:0!important}
#alertMsg{float:left!important}
#hdhistoryfixtbl{background:#fff;z-index:9}
     /*CSS Commented by Madhuri.K For datatable Header Start here */
/*#hdScrollhistoryfixtbl{overflow-y:auto!important;height:372px!important;overflow-y:auto!important;overflow-x:hidden!important;width:100%;position:relative}
#hdScrollhistoryfixtbl table tr thead{z-index:9!important}*/
/*#historyfixtbl tbody td:nth-child(1){width:78px!important}

#historyfixtbl tbody td:nth-child(2){width:133px!important}
#historyfixtbl tbody td:nth-child(3){width:144px!important}
#historyfixtbl tbody td:nth-child(4){width:133px!important}
#historyfixtbl tbody td:nth-child(5){width:168px!important}
#historyfixtbl tbody td:nth-child(6){width:116px!important}*/

/*CSS Commented by Madhuri.K For datatable Header End here */
table .header-fixed{top:0!important}

/*css version change default style*/
.pb-1 {padding-bottom: 10px!important;}
.pt-1 {padding-top: 10px!important;}
.table-fixed-header thead tr th, .table thead tr th{ padding:8px;}
body{ font-size:0.875rem;}
.table {border-spacing:0 0px;}
table.dataTable thead .sorting:after{ top:8px;}
.custmodal .modal-content .modal-header .close{background: transparent; top:8px;}


 .customelinks li a{
    padding: 6px 15px;
    display: block;
    background: #f5f5f5;
    margin-right: 5px;
    border-radius: 4px;
    border: 1px solid #eee;
 }
 .btn img[title='History'],  .btn img[data-bs-original-title='History']{ width:20px;}
 button[data-bs-target='#historymodal']{ background:none; border:none;}
  button[data-bs-target='#historymodal']:hover, button[data-bs-target='#historymodal']:focus{ background:none;}
.statusbtn button:first-child{ pointer-events:none;color: #fff;text-shadow: none;padding: 3px 10px!important; font-size: 14px; border:none;}
.custmodal .modal-content .modal-body {padding: 30px;}
.btnlistinline {
    margin: 0px 0 0;
    padding: 0;
}
.autoclosablemsg{ display:none;}
.alert.autoclosablemsg .close{
font-size: 16px;
    float: right;
    line-height: normal;
}
.autoclosablemsg p {
    margin-bottom: 0;
}

/*Added by imran on 02-08-2022 */
    .preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;            
            border-radius: 15px;
            background: #ddd; 
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }
    .clsShowHide {
            display: none !important;
        }


/*fixed header css*/
table .header-fixed {position: fixed;top: 40px;z-index: 1020;border-bottom: 1px solid #d5d5d5;-webkit-border-radius: 0; -moz-border-radius: 0;border-radius: 0;}
thead {background-color: #eaeaea;}
tbody {background-color: #fcfcfc;}
/*fixed header css end*/
.table{ color:#464a4c;}
#ProxyResource .bootstrap-select {
    border-radius: 4px;
    border: 1px solid #ddd;
    padding: 6px 8px;
    width: 280px;
}
.filedownload .dropdown-toggle::after{ display:none;}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="bodyMyTimesheet">
     <%--Added by imran on 02-08-2022--%>
    <div id="bodyMyTimesheet1"> </div>
    <%--End by imran on 02-08-2022--%>
    <div class="responsivewarningmsg">
        <h2>Please check on 1280px and high Resolution</h2>
    </div>

    <!-- Main content -->
    <section class="content mytimesheet">

        <div class="graybg container-fluid pt-1 pb-1 mytimesheethdtop">
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-12">
                    <div class="row">
                        <div class="col-md-5 col-sm-6" id="ProxyTimesheet">
                            <label class="control-label">Timesheet of Onsite Resource</label>
                        </div>
                        <%--//Commented & Added By Dipali V On 5th April 2023 For Tooltip Issue--%>
                         <%--<div class="col-sm-6" title="select resource" id="ProxyResource">--%>
                        <div class="col-sm-6" title="Select resource" id="ProxyResource" data-bs-toggle="tooltip" data-bs-animation='false' data-bs-placement="bottom" >
                         <%--//End of Commented & Added By Dipali V On 5th April 2023 For Tooltip Issue--%>
                            <% CommonFunctions.HTMLControls.DrawComboBox("CboResource", "usp_Whizible2_Sel_tbl_CNF_ProxyUser_Mapping_Detail " & Session("intUserID"),,, "class='bootstrap-select' onChange='javascript:CboResource_OnChange(this.value);'",,, ) %>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-sm-6 col-xs-12">
                    <div class="mts_sction_right text-end">
                        <%-- <a href="#">Clear All</a>--%>

                        <div class="float-end">
                            <div class="dropdown filedownload">
                                <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" data-placement="bottom" title="Click here to download" class="fas fa-download"></i></button>

                                <ul class="dropdown-menu" id="fas-download">
                                    <li><a href="#" onclick="DownloadReport('PDF')">
                                        <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                    <li><a href="#" onclick="DownloadReport('EXCEL')">
                                        <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                                    <li><a href="#" onclick="DownloadReport('XML')">
                                        <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                                    <li><a href="#" onclick="DownloadReport('TEXT')">
                                        <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Text</a></li>

                                </ul>


                            </div>

                        </div>
                        <!--bootstrap_Alertify-->
                        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg">
                            <button type="button" onclick="CloseShowAlert()" class="close nostylebtn"><i class="fas fa-times"></i></button>
                            <p id="alertMsg"></p>
                        </div>
                        <!--bootstrap_Alertify-->
                    </div>
                </div>
            </div>
        </div>

        <div class="weeklytimesheetwrap">
            <div class="timesheetrow container-fluid pt-1 pb-1 bgwhite ts_headerbot">
                <div class="row">                    
                    <div id="tabs" class="col-md-6 col-sm-8 col-xs-12 float-start">
                        <ul class="nav customelinks navstatuslink">
                            <li class="statusallactive"><a id="All" class="active" data-bs-target="all" href="javascript:;">All</a></li>
                            <li class="statusapproved"><a id="Approved" class="" data-bs-target="statusapproved" href="javascript:;">Approved</a></li>
                            <li class="statusrejected"><a id="Rejected" class="srejected " data-bs-target="statusrejected" href="javascript:;">Rejected</a></li>
                            <li class="statussubmitted"><a id="Submitted" class="" data-bs-target="statussubmitted" href="javascript:;">Submitted</a></li>
                        </ul>
                    </div>
                    <div class="col-md-6 col-sm-4 col-xs-12 float-end">
                        <ul class="float-end btnlistinline">
                            <li>
                                  <%--//Commented & Added By Dipali V On 8th Jan 2024 For Delete modal pop display--%>
                                <%--<button id="deletebtn" class="btn borderbtnred ml-1" data-bs-toggle="" data-bs-target="">Delete</button>--%>
                                <button id="deletebtn" class="btn borderbtnred ml-1" >Delete</button>
                                  <%--//End of Commented & Added By Dipali V On 8th Jan 2024 For Delete modal pop display--%>
                                <%--<button id="deletebtn" class="btn borderbtnred ml-1" data-bs-toggle="modal" data-bs-target="#deleteinfomodal">Delete</button>--%>
                            </li>
                            <li>
                                <%--<button id="submitbtn" class="btn btnyellow ml-1" onclick="ValidateData()" data-bs-toggle="" data-bs-target="">Submit</button>--%>
                                <button id="submitbtn" class="btn btnyellow ml-1" data-bs-toggle="" data-bs-target="">Submit</button>
                                <%--<button id="submitbtn"  data-bs-toggle="modal" data-bs-target="#submitinfomodal" class="btn btnyellow ml-1">Submit</button>--%>
                            </li>
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
                                <th width="20%" class="text-center">Submitted Date</th>
                                <th width="20%" class="text-center"><i class="fas fa-sort" id="PeriodHeader"></i>Period</th>
                                <th width="12%" class="text-center">Actual Hours</th>
                                <th width="15%" class="text-center">Status</th>
                                <th width="28%" class="text-center">Approve/Reject Comment</th>

                            </tr>
                        </thead>

                        <tbody id="mytimesheettable">
                          
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
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Schedul time entry</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <div class="entryform scheduleform">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-end">Start date:</div>
                                        <div class="col-xs-6 col-sm-7">
                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <input type="text" class="form-control" name="">
                                                </div>
                                                <div class="col-xs-2">
                                                    <span class="startdateicon">
                                                        <img class="weeklycalender_icon" src="../../../Whizible2.0-new/dist/img/calendar.svg" alt="" width="20px"></span>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-end">Post tiII date</div>
                                        <div class="col-xs-6 col-sm-7">
                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <input type="text" class="form-control" name="">
                                                </div>
                                                <div class="col-xs-2">
                                                    <span class="startdateicon">
                                                        <img class="weeklycalender_icon" src="../../../Whizible2.0-new/dist/img/calendar.svg" alt="" width="20px"></span>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-end">Project:</div>
                                        <div class="col-xs-6 col-sm-7">Vizible 2.0</div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-end">Task:</div>
                                        <div class="col-xs-6 col-sm-76">Define roles & responsibilities</div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-end">Sub task:</div>
                                        <div class="col-xs-6 col-sm-7">Sub task name</div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-end">Hours to post:</div>
                                        <div class="col-xs-6 col-sm-76">00.00</div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-5 text-end">Close task after end date:</div>
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
                                        <div class="col-xs-6 col-sm-6 text-start">
                                            <button class="btn borderbtn ml-1">Cancle</button>
                                        </div>
                                        <div class="col-xs-6 col-sm-6 text-end">
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
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
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
        <div class="modal-dialog modal-lg">
            <!-- Modal content-->
            <div class="modal-content modal-lg" style="padding-left: 0px; padding-right: 0px;">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">My Timesheet History</h4>
                </div>
                <div class="modal-body">
                    <div class="fixedtable_container">
                        <table id="historyfixtbl" class="table table-bordered cust_fixed_tbl">
                            <thead>
                                <tr>
                                   <%-- <th style="width: 78px!important;">Status</th>
                                    <th style="width: 128px!important;">Generation Date</th>
                                    <th style="width: 130px!important;">Updated Date</th>
                                    <th style="width: 120px!important;">Action Taken By</th>
                                    <th style="width: 160px!important;">Action Taken</th>
                                    <th style="width: 116px!important;">Approver Name</th>--%>
                                    <th>Status</th>
                                    <th>Generation Date</th>
                                    <th>Updated Date</th>
                                    <th>Action Taken By</th>
                                    <th>Action Taken</th>
                                    <th>Approver Name</th>
                                </tr>
                            </thead>

                            <tbody id="tbodyHistory" style="width: 100%;">                                
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
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
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

    <!-- Project timesheet info Timesheet -->
    <div id="projecttimeinfomodal" class="modal fade custmodal" role="dialog">
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

    <!--deletmodal-->
    <div id="deleteinfomodal" class="modal fade custmodal" role="dialog">
        <div class="modal-dialog modalsmall">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Delete</h4>
                </div>

                <div class="modal-body">
                    <p align="center">You are about to delete Timesheet?Do you want to Continue...</p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                  <%--//Commented & Added By Dipali V On 8th Jan 2024 For Delete modal pop display--%>
                                <%--<button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>--%>
                                <button class="btn borderbtn ml-1" onclick="DeleteData(0)">No</button>
                                <%--<button class="btn borderbtn ml-1" onclick="DeleteData()">No</button>--%>
                                  <%--//End of Commented & Added By Dipali V On 8th Jan 2024 For Delete modal pop display--%>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <%--//Commented & Added By Dipali V On 8th Jan 2024 For Delete modal pop display--%>
                                <%--<button class="btn btnyellow ml-1 float-end" onclick="DeleteData()">Yes</button>--%>
                                <button class="btn btnyellow ml-1 float-end" onclick="DeleteData(1)">Yes</button>
                                <%--//End of Commented & Added By Dipali V On 8th Jan 2024 For Delete modal pop display--%>
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
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Submit</h4>
                </div>

                <div class="modal-body">
                    <p align="center">Are you sure you want to submit entry?</p>
                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" onclick="SubmitData()">Yes</button>
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
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
 <%--   <script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script>--%>
<%--     <script src="../../../Whizible2.0-new/dist/js/custom.js?v=1.6"></script>--%>
  <%--  <script src="../../General/CommonValidations.js"></script>--%>

    <script type="text/javascript">

        //Added By Madhuri.K On 18-Sep-2024 for Remove tooltip 
        $('body').on('click', function () {
            $('.tooltip').remove();
        });
        $('#ProxyResource button').hover(function (e) {
            $(this).attr('title', '');
        });

        //select all checkboxes

        $("#Tapprovalall").change(function () {
            //debugger;
            var Checked = $(this).is(':checked');
            $("input[name=checkDelete]").prop('checked', Checked);

        });

          ////this use for if uncheck one of the Checkbox then remove check of Select all  
        $('#MTstatusfiltertble').on('change', 'tbody td:nth-child(1) :checkbox', function () {

            //Commented and Added By Reshma Chavan on 22nd oct 20202 For select all issue on Rejected tab
            //var checked = $(this).is(':checked');
            //if (checked == true) {
                
            //    SelectedRecords = 1;
            //}
            //else {
            //    $("#Tapprovalall").prop("checked", false);
            //    NoSelectedRecords = 1;
            //}
             if($('input[name=checkDelete]:checked').length == $('input[name=checkDelete]').length){
                    $('#Tapprovalall').prop('checked',true);
             }
             else {
                    $('#Tapprovalall').prop('checked',false);
            }
            //End of Commented and Added By Reshma Chavan on 22nd oct 20202 For select all issue on Rejected tab
        });

             
      

        var getselectedStatus = "Submitted";
        var selected = "R";
        $('.navstatuslink a').on('click', function () {
         
          //  debugger;
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

        //Added by Dipali V On 24th Jan 2023 For Get Tab Details
        $('.navstatuslink li a').on('click', function () {
            // debugger;
            //var $target = $(this).data('target');
            var $target = $(this).attr('data-bs-target');
            if ($target != 'all') {

                $('.table.statusfiltertble tbody  tr').css('display', 'none');
                $('.table.statusfiltertble tbody tr[data-status="' + $target + '"]').fadeIn('slow');
            } else {
                $('.table.statusfiltertble tbody tr').css('display', 'none').fadeIn('slow');
            }
        });

        $(".ui-datepicker").click(function () {
            $('.tooltip').removeClass('show');
        });

        //status tab desktop
        $(".customelinks li.statusapproved a, .customelinks li.statussubmitted a").on('click', function () {
            $(".btnlistinline").hide();
        });
        $(".customelinks li.statusrejected a, .customelinks li.statusallactive a").on('click', function () {
            $(".btnlistinline").show();
        });
        //End of Added by Dipali V On 24th Jan 2023 For Get Tab Details

        var isWeeklyView = 1;
        var taskParameters;
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

        var EmployeeID;
        var currentEmployeeID;
        var currentEmpID;
        EmployeeID = <%= Session("intUserID") %>  
            currentEmpID = EmployeeID;

        function CboResource_OnChange(employeeID) {

           if (employeeID == 0) {
                //  currentEmployeeID = employeeID;
                ReloadData(EmployeeID);
            }
            else {
                currentEmployeeID = employeeID;
                ReloadData(currentEmpID, currentEmployeeID);
            }
            /*Added By Yasmin on 10-5-19*/
            $('div#ProxyResource .bootstrap-select .dropdown-toggle').hover(function (e) {
                $(this).attr('title', '');
            });
        }

        $(document).ready(function () {
            if ('<%= Request.QueryString("PageFlag")%>' == 4) {
                $("#CboResource option[value='" + '<%= Request.QueryString("EmployeeID")%>' + "']").attr("selected", "selected");
            }

            $('[data-bs-toggle="tooltip"]').tooltip();
            $(".nostylebtn").tooltip();

            $('#ProxyResource button').hover(function (e) {
                $(this).attr('title', '');
            });
            if ('<%= Request.QueryString("PageFlag")%>' == 4) {
                getselectedStatus = '<%= Request.QueryString("StatusSelected")%>'

                //$("#" + + "").trigger("click");
                $("#CboResource option[value='" + '<%= Request.QueryString("EmployeeID")%>' + "']").attr("selected", "selected");
                CboResource_OnChange(<%= Request.QueryString("EmployeeID")%>);
                $("div#ProxyResource .bootstrap-select .dropdown-toggle").attr("title", "");
                //ReloadData(currentEmpID);
                if ($('#CboResource option').length <= 1) {
                    //$(".selectpicker").selectpicker('refresh');
                    $('#ProxyResource .bootstrap-select').css("display", "none");
                    $('#ProxyTimesheet').css("display", "none");

                    //ReloadData(currentEmpID);
                }
                else {
                    //ReloadData(currentEmpID);

                    //$("#fixedtbl1").freezeHeader({
                    //    'height': '300px'
                    //});
                    //$("#fixedtbl2").freezeHeader({
                    //    'height': '300px'
                    //});
                }
            }
            else {
                if ($('#CboResource option').length <= 1) {
                    //$(".selectpicker").selectpicker('refresh');
                    $('#ProxyResource .bootstrap-select').css("display", "none");
                    $('#ProxyTimesheet').css("display", "none");
                    ReloadData(currentEmpID);
                    //   $("#fixedtbl1").freezeHeader({
                    //    'height': '300px'
                    //});
                    //$("#fixedtbl2").freezeHeader({
                    //    'height': '300px'
                    //});
                }
                else {
                    ReloadData(currentEmpID);

                    //$("#fixedtbl1").freezeHeader({
                    //    'height': '300px'
                    //});
                    //$("#fixedtbl2").freezeHeader({
                    //    'height': '300px'
                    //});
                }
                //ReloadData(currentEmpID);
            }
            //Added By Riddhesh Patil on 9 May 2023 for dropdown not closing Issue
            $("body").on("click", "[data-bs-toggle='dropdown']", function () {
                $(".nav-tabs [data-bs-toggle='dropdown']").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
                $(this).closest(".dropdown']").find(".dropdown-menu, .dropdown-toggle").addClass("show");

            });

            $('body').on('click', function (e) {
                $('[data-bs-toggle="dropdown"]').each(function (e) {
                    // hide any open popovers when the anywhere else in the body is clicked
                    if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.dropdown .dropdown-menu').has(e.target).length === 0) {
                        $(".dropdown-menu").removeClass('show');
                    }
                });
            });
            //End of Added By Riddhesh Patil on 9 May 2023 for dropdown not closing Issue
        });
        /*function Commented by Madhuri.K For datatable Header Start here */
        //$(function () {  //freez table headerand scrollblein modal poup
        //    $("#historyfixtbl").freezeHeader({
        //        'height': '300px'
        //    })
        //});
        /*function Commented by Madhuri.K For datatable Header End here */
        function ReloadData(ProxyResourceID, ResourceID) {
         //  debugger;
            //try {
            
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
                    StatusCode: " ",
                }
            }

                
            AjaxCall();
            //}
            //catch (ex) {
            //    alert(ex.message);
            //}
        }

        function AjaxCall() {
         //   debugger;
            StartLoader("#bodyMyTimesheet1");
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
                    var MyTimesheet = data;
                    plotMyTimesheetList(MyTimesheet.MyTimesheetLists);                  
                 //   debugger;
                    //Commented By Riddhesh Patil on 3rd April 2023
                   // AfterPlot();
                    //End of Commented By Riddhesh Patil on 3rd April 2023
                    StopAjaxLoader("#bodyMyTimesheet1");
                    $("#" + getselectedStatus + "").trigger("click");
                     
                },
                error: function (err) {                    
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    StopAjaxLoader("#bodyMyTimesheet1");
                }
                 
            })

        }
        //Added by Usha on 27.12.2018 for disable field on view 
        function goToURL(TimeSheetID, StartDate, currentEmpID   ) {

            

            //window.location.href = "TimesheetEntry.aspx?Flag=2&TimesheetID=" + TimeSheetID + "&StartDate=" + StartDate + "&EmployeeID=" + currentEmpID + "&FromPage=MyTimesheet&IsView=1";
            var Filtered = $("#CboResource option:selected").val();
            if (Filtered == 0) {
                //alert(currentEmpID);
                ////href='TimesheetEntry.aspx?Flag=2&TimesheetID=" + TimeSheetID + "&StartDate=" + StartDate + 
                window.location.href = "TimesheetEntry.aspx?Flag=2&TimesheetID=" + TimeSheetID + "&StartDate=" + StartDate + "&EmployeeID=" + currentEmpID + "&FromPage=MyTimesheet&IsView=1&selectedStatus=" + getselectedStatus + "";
                //"&EmployeeID="+ currentEmpID +"&FromPage=MyTimesheet'
            }
            else {
                //alert(Filtered);
                window.location.href = "TimesheetEntry.aspx?Flag=2&TimesheetID=" + TimeSheetID + "&StartDate=" + StartDate + "&EmployeeID=" + Filtered + "&FromPage=MyTimesheet&IsView=1&selectedStatus=" + getselectedStatus + "";
            }
        }
        //End of Added by Usha on 27.12.2018 for disable field on view 

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

                var AllTotal = '' + ActualHours + '';
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

                    //Commented and Added by Usha on 27.12.2018 for disable field on view

                    //"<a href='TimesheetEntry.aspx?Flag=2&TimesheetID=" + TimeSheetID + "&StartDate=" + StartDate + "&EmployeeID="+ currentEmployeeID +"&FromPage=MyTimesheet'>" + Period + "</a></td>" +
                     "<a onclick='goToURL(&quot;" + TimeSheetID + "&quot;, &quot;" + FromDate + "&quot;, &quot;" + currentEmpID + "&quot;)' href='javascript:void(0)'>" + Period + "</a></td>" +

                    //End of Added by Usha on 27.12.2018 for disable field on view 
                    "<td>" + ActualHours + "</td>" +
                    "<td> " +
                    "<div class='btn-group btn-display statusbtn'>";
                if (StatusDescription == 'Not ready for approval') { strHTML += "<button type='button'  class='btn btn_lightred'>Saved</button>"; }
                else if (StatusDescription == 'Ready for approval') { strHTML += " <button type='button'  class='btn btn-info '>Submitted</button>"; }
                else if (StatusDescription == 'Approved') { strHTML += " <button type='button' class='btn btn-success '>Approved</button>"; }
                else if (StatusDescription == 'Rejected') { strHTML += "<button type='button' class='btn btn-red'>Rejected</button>"; }

                //Added By Dipali V On 13th May 2020 for Issue ID 24366
                //strHTML += "<button data-bs-toggle='modal' data-bs-target='#historymodal' type='button' onclick='ShowHistory(" + TimeSheetID + ")' class='btn btn_lightred' title='History' data-placement='top'>" +
                strHTML += "<button data-bs-toggle='modal' data-bs-target='#historymodal' type='button' onclick='ShowHistory(" + TimeSheetID + ")' class='btn btn_lightred' data-placement='top'>" +
                                    //End of Added By Dipali V On 13th May 2020 for Issue ID 24366
                    "<img class='float-end' data-bs-toggle='tooltip' title='History' data-placement='top' src='../../../Whizible2.0-new/dist/img/history-icon.svg' width='13px' alt=''>" +
                    "</button>" +
                    "</div>" +
                    "</td>" +
                    "<td class='text-start comment'><span class='comment'  title='" + Comment.replace("'", "\"") + "'  data-bs-toggle='tooltip' data-placement='left' data-container='body'>" + Comment + "</span></td>" +
                    "</tr>";

                $("#mytimesheettable").html(strHTML);
                //AfterPlot();
                StopAjaxLoader("#bodyMyTimesheet1");
                
            }
            $('[data-bs-toggle="tooltip"]').tooltip();
        }

        $('.navstatuslink a').on('click', function () {
          //   debugger;

            var Status = $(this).attr('id');
            if (Status == 'All') {
                $(".tblchk").attr('style', 'cursor: poniter !important');
                $(".tblchk").attr('disabled', false);
                $(".navstatuslink li a").removeClass("active");
                $(this).addClass("active");
            }

            else if (Status == 'Approved') {
                $(".tblchk").attr('style', 'cursor: not-allowed !important');
                $(".tblchk").attr('disabled', true);
                $(".navstatuslink li a").removeClass("active");
                $(this).addClass("active");
            }
            else if (Status == 'Rejected') {
                $(".tblchk").attr('style', 'cursor: pointer !important');
                $(".tblchk").attr('disabled', false);
                $(".navstatuslink li a").removeClass("active");
                $(this).addClass("active");
            }
            else if (Status == 'Submitted') {
                $(".tblchk").attr('style', 'cursor: not-allowed !important');
                $(".tblchk").attr('disabled', true);
                $(".navstatuslink li a").removeClass("active");
                $(this).addClass("active");
            }

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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                    }
                },
                success: function (data) {
                    PlotHistorySection(data.MyTimesheetHistoryLists);

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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

        function CloseShowAlert() {
            $('.ClosaeblealertMsg').hide();
        }

        //On Yes button 

        function DeleteData(Flag) {
            if (Flag == 1) {
                $('input[name=checkDelete]:checked').each(function () {

                    DeleteAjaxCall(this.id.split('Tapprovalall_')[1]);
                });
            } else {
                //Commented & Added By Dipali V On 8th Jan 2024 For Delete modal pop display
                //$("#deletebtn").attr('data-bs-toggle', '');
                //$("#deletebtn").attr('data-bs-target', '');
                $("#deleteinfomodal").modal('hide');
                  //End of Commented & Added By Dipali V On 8th Jan 2024 For Delete modal pop display
            }
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
                  //Commented & Added By Dipali V On 8th Jan 2024 For Delete modal pop display
                //$("#deletebtn").attr('data-bs-toggle', 'modal');
                //$("#deletebtn").attr('data-bs-target', '#deleteinfomodal');
                $("#deleteinfomodal").modal('show');
                  //End of Commented & Added By Dipali V On 8th Jan 2024 For Delete modal pop display
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? taskparameters : JSON.stringify(taskparameters)));
                    }
                },
                success: function (data) {
                    console.log(data);

                    showAlert('Timesheet deleted successfully.', 'alert-success');
                    if (currentEmployeeID != undefined) {
                        ReloadData(currentEmployeeID);
                    }
                    else {
                        ReloadData(EmployeeID);
                    }
                    $("#deleteinfomodal").modal('hide');
                    //Commented And Added By Usha Pandit On 13.10.2020 For javascript error on Reject Timesheet deletion
                    //$("#.navstatuslink a").trigger('click');
                    //$("#.navstatuslink a").focus();

                    $(".navstatuslink a").trigger('click');
                    $(".navstatuslink a").focus();
                    //End Of Added By Usha Pandit On 13.10.2020 For javascript error on Reject Timesheet deletion
                    $("#" + getselectedStatus + "").trigger("click");
                    //added By Dipali On 13th May 2019 For Redirect issue
                    $("#Rejected").trigger("click");
                    // end of added By Dipali On 13th May 2019 For Redirect issue
                },
                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

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
                $("#submitinfomodal").modal('hide');
                return false;
            }
            else {
                //Commented and Added By Riddhesh Patil on 26 Sep 2024 for Pop Showing after double click on btn issue
                //$("#submitbtn").attr('data-bs-toggle', 'modal');
                //$("#submitbtn").attr('data-bs-target', '#submitinfomodal');
                $("#submitinfomodal").modal('show');
                //End of Commented and Added By Riddhesh Patil on 26 Sep 2024 for Pop Showing after double click on btn issue
            }
        });

        function SubmitData() {
            $('input[name=checkDelete]:checked').each(function () {

                SubmitAjaxCall(this.id.split('Tapprovalall_')[1]);
            });

        }

        //function ValidateData() {
        //    $('input[name=checkDelete]:checked').each(function () {

        //        ValidateAjaxCall(this.id.split('Tapprovalall_')[1]);

        //    });

        //}

        //function ValidateAjaxCall(IDs) {
        //    //debugger;
        //    //alert("IN ValidateAjaxCall");
        //    var Fromdate1 = document.getElementById("FrmId_" + IDs).value;
        //    var dateAr = Fromdate1.split('-');
        //    var Fromdate = dateAr[2] + '-' + dateAr[1] + '-' + dateAr[0];
        //    //alert(Fromdate);
        //    var Todate1 = document.getElementById("ToId_" + IDs).value;
        //    var dateArr = Todate1.split('-');
        //    var Todate = dateArr[2] + '-' + dateArr[1] + '-' + dateArr[0];
        //    //alert(Todate);
        //    var taskparameters = {
        //        intTimesheetID: IDs,
        //        employeeID: currentEmployeeID,
        //        dtFromDate: Fromdate,
        //        dtToDate: Todate,


        //    }
        //    //alert(currentEmployeeID);


        //    $.ajax({
        //        url: strUrl + '/api/MyTimesheet/ValidateMyTimesheet',
        //        type: "POST",
        //        data: JSON.stringify(taskparameters),
        //        dataType: "json",
        //        contentType: "application/json;charset-utf=8",
        //        beforeSend: function (xhr) {
        //            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
        //        },
        //        success: function (data) {
        //            console.log(data);
        //            //alert(currentEmployeeID);                                 
        //            if (data == "") {
        //                //$("#submitbtn").attr('data-bs-toggle', 'modal');
        //                //$("#submitbtn").attr('data-bs-target', '#submitinfomodal');

        //            }
        //            else {
        //                showAlert(data, 'alert-danger');

        //            }

        //            //ReloadData(currentEmployeeID);                                       
        //            $("#.navstatuslink a").trigger('click');
        //            $("#.navstatuslink a").focus();

        //        },
        //        error: function (err) {
        //            //alert("in error");
        //            console.log(err);

        //        }
        //    })

        //}

        function ValidateSubmitTS(EmployeeID, FromDate, ToDate) {
            var Flag = 0;
            var taskparameters = {
                employeeID: EmployeeID,
                dtFromDate: FromDate,
                dtToDate: ToDate,
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

        function SubmitAjaxCall(IDs) {
            //debugger;
            //alert("IN submit AJAX");

            var Fromdate1 = document.getElementById("FrmId_" + IDs).value;
            var dateAr = Fromdate1.split('-');
            //var Fromdate = dateAr[2] + '-' + dateAr[1] + '-' + dateAr[0];
            var Fromdate = Fromdate1;
            //alert(Fromdate);
            var Todate1 = document.getElementById("ToId_" + IDs).value;
            var dateArr = Todate1.split('-');
            //var Todate = dateArr[2] + '-' + dateArr[1] + '-' + dateArr[0];
            var Todate = Todate1;
            //alert(Todate);
            //var taskparameters = {
            //    employeeID: currentEmployeeID,
            //    dtFromDate: Fromdate,
            //    dtToDate: Todate,
            //    intTimesheetID: IDs,
            //    StatusCode: "R",
            //}
            var FilteredEmpID = $("#CboResource option:selected").val();
            if (FilteredEmpID == undefined) {
                FilteredEmpID = 0;
            }

            if (FilteredEmpID != 0) {
                if (ValidateSubmitTS(FilteredEmpID, Fromdate, Todate) == 1) {
                    return false;
                }
            }
            else {
                if (ValidateSubmitTS('<%= Session("intUserID") %>', Fromdate, Todate) == 1) {
                    return false;
                }
            }

            if (FilteredEmpID != 0) {
                taskparameters = {

                    intProxyUserID: '<%= Session("intUserID") %>',
                    employeeID: FilteredEmpID,
                    dtFromDate: Fromdate,
                    dtToDate: Todate,
                    intTimesheetID: IDs,
                    StatusCode: "R",
                }
            }
            else {
                taskparameters = {
                    intProxyUserID: 0,
                    employeeID: '<%= Session("intUserID") %>',
                    dtFromDate: Fromdate,
                    dtToDate: Todate,
                    intTimesheetID: IDs,
                    StatusCode: "R",
                }
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
                    //alert(currentEmployeeID);
                    //showAlert('Timesheet Submitted Successfully.', 'alert-success');
                    if (data == 1) {
                        window.open('../Email/SendEmail.aspx?MessageID=434&TimesheetID=' + IDs + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    }
                    ReloadData(currentEmpID);
                    $("#submitinfomodal").modal('hide');

                    $(".navstatuslink a").trigger('click');
                    $(".navstatuslink a").focus();

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""

                }
            })

        }

        function DownloadReport(ReportFormat) {

            //debugger;
            //alert("IN DW");           
            //var taskparameters = {
            //    employeeID: currentEmployeeID,
            //    StatusCode: selected,
            //    ReportFormat: ReportFormat,

            //}
            var FilteredEmpID = $("#CboResource option:selected").val();
            if (FilteredEmpID == undefined) {
                FilteredEmpID = 0;
            }
            if (FilteredEmpID != 0) {
                taskparameters = {

                    intProxyUserID: '<%= Session("intUserID") %>',
                    employeeID: FilteredEmpID,
                    StatusCode: selected,
                    ReportFormat: ReportFormat,

                }
            }
            else {
                taskparameters = {
                    intProxyUserID: 0,
                    employeeID: '<%= Session("intUserID") %>',
                    StatusCode: selected,
                    ReportFormat: ReportFormat,
                }
            }
            //alert(currentEmployeeID);
            //alert(selected);
            $.ajax({
                url: strUrl + '/api/MyTimesheet/ExportDocument',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? param : JSON.stringify(taskparameters)));
                    }
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
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }











    </script>

    <!--freezetbl_header_in_modalpopupbox-->
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/jquery.freezeheader.js"></script>


    <script>


$('#PeriodHeader').click(function () {
            var table = $(this).parents('table').eq(0);
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).parent('th').index()));
            this.asc = !this.asc
            if (!this.asc) { rows = rows.reverse() }
            for (var i = 0; i < rows.length; i++) { table.append(rows[i]) }
        })
        function comparer(index) {
            return function (a, b) {
               
                var valA = getCellValue(a, index), valB = getCellValue(b, index)
                
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : /*valA.toString().localeCompare(valB*/ CompairDates(valA,valB)
            }
        }
        function getCellValue(row, index) {
            var rtext = $(row).children('td').eq(index).text();
            var newdt = rtext.split('to')[0].trim();
            var customDateDdMmmYyyy = getDateFormat(newdt); 
           // var rDate = new Date(newdt);
            return customDateDdMmmYyyy;
        }
        function getDateFormat(newdt) {
           
             var dateParts = newdt.split('-');
                return new Date((dateParts[2] * 1), ($.inArray(dateParts[1].toUpperCase(), ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]) * 1), dateParts[0] * 1);
        }
        function CompairDates(dateA, dateB) {
          //  alert(dateA);
            if (dateA > dateB) return 1
            else return -1
        }

        var f_sl = 1;
        var f_nm = 1;
        $("#sl").click(function () {
            f_sl *= -1;
            var n = $(this).prevAll().length;
            sortTable(f_sl, n);
        });

    </script>
    
    </body>

    </html>









