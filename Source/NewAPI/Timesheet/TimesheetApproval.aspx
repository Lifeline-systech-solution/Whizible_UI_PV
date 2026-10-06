<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TimesheetApproval.aspx.vb" Inherits="Whizible.TimesheetApproval" %>


<!DOCTYPE html>
<html>
     <%--   Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("My Timesheet")%> 
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Timesheet Approval</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
   <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">  
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
 

    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">    --%>
 <%--   <link href='../../../Whizible2.0-new/dist/css/table-fixed-header.css' rel='stylesheet'> --%>   
    <link href="../../../Whizible2.0-new/dist/css/style_custom.css?v=1.2" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=1">
    <link href="../../General/loaderStylesheet.css" rel="stylesheet" />

    <style type="text/css">
        .btn {
            font-size: 11.5px!important; /* Modified By Madhuri.K On 26-03-2026 */
        }
.form-control{
    font-size: 13px!important; /* Modified By Madhuri.K On 26-03-2026 */
}
        .weekcolumnred {
          color: red !important;
        }
        .tbl-content {
            height: auto;
        }
          /*Added by Yasmin for Approve reject comment content 21-05-19*/
          .tooltip >.tooltip-inner{
            word-wrap: break-word;
            max-width: 300px; /* Adjust the width as needed */
            width: auto;
            white-space: normal;
        }
        table .header-fixed {
            top: 0px !important;
        }

        #hdhistoryfixtbl {
            /*top: 40px !important;*/
            background: #fff;
            z-index: 9;
        }



        table .header-fixed {
            top: 0px !important;
        }

        #alertMsg {
            float: left !important;
        }

        #hdhistoryfixtbl {
            /*top: 40px !important;*/
            background: #fff;
            z-index: 9;
        }

        #hdScrollhistoryfixtbl {
            height: 372px !important;
            overflow-y: auto !important;
            overflow-x: hidden !important;
            width: 100%;
            padding-left: 15px;
            padding-right: 15px;
            position: relative;
        }



            #hdScrollhistoryfixtbl table tr thead {
                z-index: 9 !important;
            }

        #historyfixtbl tbody td:nth-child(1) {
            width: 78px !important;
        }

        #historyfixtbl tbody td:nth-child(2) {
           width: 133px !important;
        }

        #historyfixtbl tbody td:nth-child(3) {
                width: 144px !important;
        }

        #historyfixtbl tbody td:nth-child(4) {
                width: 133px !important;
        }

        #historyfixtbl tbody td:nth-child(5) {
            width: 168px !important;
        }

        #historyfixtbl tbody td:nth-child(6) {
            width: 116px !important;
        }
        /*Added By Dipali V On 4th March 2021 for Note CSS*/
        .clsnotereject {
            color:red!important;
            font-size:10px!important;
        }

        .mtdateperiod span {
            margin: 0px 1px !important;
        }
        .clsLI {
            list-style-type: inherit;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .RecordRejected {
            cursor:no-drop!important;
        }

 #allowoverridenote {
            font-weight:400!important;
        }
         #allowoverridenote span {
            font-weight:400!important;
            font-size:11.5px!important; /* Modified By Madhuri.K On 26-03-2026 */
               
        }
          /*End Added By Dipali V On 4th March 2021 for Note CSS*/

/*css version change default style*/
.pb-1 {padding-bottom: 10px!important;}
.pt-1 {padding-top: 10px!important;}
.table-fixed-header thead tr th, .table thead tr th{ padding:8px;}
body{ font-size:11.5px;} /* Modified By Madhuri.K On 26-03-2026 */
.table {border-spacing:0 0px;}
table.dataTable thead .sorting:after{ top:8px;}
.custmodal .modal-content .modal-header .close{background: transparent; top:8px;}

 .customelinks li a{
    padding: 6px 15px;
    display: block;
    background: #fafafa;
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
/*Added by imran on 02-08-2022 */

.alert.autoclosablemsg .close{
font-size: 14px;
    float: right;
    line-height: normal;
}
.autoclosablemsg p {
    margin-bottom: 0;
}
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
.btnlistinline {
    margin: 6px 0 0;
    padding: 0;
}
.btn-success {
    color: #fff;
}
#allowoverridenote li.clsLI {margin: 10px 0px 0px 20px;}
.statusfiltertble td:nth-child(6n) button.btn-info { pointer-events:none;color: #fff;text-shadow: none;padding: 3px 10px!important; font-size: 14px; border:none;}
.table{ color:#464a4c;}
.autoclosablemsg{ display:none;}

/* Styles Added By Durgesh On 29-01-25*/
.stickytopbar {
    position: sticky;
    top: -17px;
    z-index: 10;
    background-color: #fff;
}
.stickyTSHeaderRes {
      position: sticky;
    top: 76px;
    z-index: 10;
    background-color: #fff;
}
.stickyTSHeaderRow {
    position: sticky;
    top: 165px;
    z-index: 10;
    background-color: #fff;
}
.tbl-projecttitleres {
    display: flex;
    align-items: center;
    padding-left: 26px;
}
.project-iconres {
    margin-right: 10px;
}
.apprejbtn-end {
    margin-left: 100px;
}
.myTimesheetTbl {
     padding: 0px;
    margin: 0px;
    background-color: #fff;
    border-collapse: separate;
}
.offcanvas-85 {
    --bs-offcanvas-width: 85%;
}
.small-font {
    font-size:/* 0.875rem;*/ 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
}   
#approvalButtonsContainer {
    min-height: 25px; /* Adjust the height value as needed */
}
.table-outer {
    padding: 0 0px;
}
.btn-close{
    background: transparent url("../../../Whizible2.0-new/dist/img/close-black.svg") center/1em auto no-repeat;
}
/*End of styles added by Durgesh Dalvi*/

    </style>

</head>
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="bodyTSApproval">
         <%--Added by imran on 02-08-2022--%>
    <div id="bodyTSApproval1"> </div>
    <%--End by imran on 02-08-2022--%>
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
                                <button data-bs-toggle="tooltip" data-bs-placement="bottom" title="Previous Week" id="prev"><i class="fas fa-caret-left"></i></button>
                                <div class="input-group-box">
                                    <div class="input-group" id="DateDemo">
                                        <input data-bs-toggle="tooltip" data-bs-placement="bottom" title="Select week date" class="form-control" type="text" id="weekPicker2" />
                                    </div>
                                </div>
                                <button id="next" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Next Week" class=""><i class="fas fa-caret-right"></i></button>
                                <!-- /.input group -->
                            </div>
                        </div>
                        <div class="col-sm-4"></div>
                    </div>
                </div>

            </div>
        </div>

        <div class="weeklytimesheetwrap">
            <div class="timesheetrow container-fluid pt-1 pb-1 bgwhite ts_headerbot">
                <div class="row">
                    <div class="col-md-6 col-sm-12 col-xs-12 float-start" id="tabs">
                        <ul class="nav customelinks navstatuslink">
                            <li class="overdue"><a id="all" data-bs-target="all" class="active" href="javascript:;">All <span id="spanAll"></span></a></li>
                            <li class="pending"><a id="Approved" data-bs-target="statusapproved" href="javascript:;">Approved <span id="spanApproved"></span></a></li>
                            <li class="pending"><a id='Rejected' data-bs-target="statusrejected" href="javascript:;">Rejected <span id="spanRejected"></span></a></li>
                            <li id="liSubmitted" class="active"><a id="Submitted"  data-bs-target="statussubmitted" href="javascript:;">Submitted <span id="spanSubmitted"></span></a></li>
                        </ul>
                    </div>
                    <div class="col-md-6 col-sm-12 col-xs-12 float-end">
                        <div class="approval_crossandcheckbtn float-end pt-1 hides">
                            <div class="input-group">
                                <button data-bs-toggle="modal" id="btnApproveAllTimesheet" onclick="ShowApprovetaskbtnmodal(0,0,'','')" class="btn btn-outline-secondary btn-success" type="button" data-bs-placement="bottom" data-bs-container='body' title="Approve"><i class="fas fa-check" style="display: block"></i></button>
                                <button data-bs-toggle="modal" id="btnRejectAllTimesheet" onclick="ShowRejecttaskmodal(0,0)" class="btn btn-outline-secondary btn-red" type="button" data-bs-toggle="tooltip" data-bs-container="body" title="Reject"><i class="fas fa-times" style="display: block"></i></button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="clearfix"></div>
                </div>
            </div>
            <!--bootstrap_Alertify-->
            <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg">
                <button type="button" class="close nostylebtn" onclick="CloseShowAlert()"><i class="fas fa-times"></i></button>
                <p id="alertMsg"></p>
            </div>
            <!--bootstrap_Alertify-->



            <div class="table-outer" id="Divtableheadfixer">
                <div class="tbl-content" id="table-container">
                    <table id="tableheadfixer" class="table table-bordered tbl_custm tsapprovaltbl statusfiltertble table-fixed-header">
                        <thead class='header'>
                            <tr>

                                <th width="3%" class="text-center">
                                    <div class="custom_chckbox" >
                                        <input type="checkbox" id="Tapprovalall" class="checkbox checkAll">
                                        <label for="Tapprovalall" class="checkTapprovalall"></label>
                                    </div>
                                </th>
                                <th width="20%" class="text-center sort"><i class="fas fa-sort" id="EmployeeHeader"></i>Employee Name <i class="fas fa-filter" id="EmployeeNameFilter" data-bs-toggle="collapse" data-bs-target="#TAfiltername" aria-expanded="false" aria-controls="navbar"></i>


                                    <div id="TAfiltername" class="selectpicker autocompletepicker collapse tblfiltering" data-clear="true" data-live="true">
                                        <div class="dropdown-menu" style="display: block;">
                                            <div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true" >
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
                                                        <li class="optgroup" id="AllEmployeeCheckGroup">
                                                            <span class="optgroup-header"></span>
                                                            <%--<input id="EmployeecheckAll" class="checkbox checkAll" type="checkbox">All <span class="subtext"></span></span>--%>
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
                                                    <%-- <div class="no-search-results">
                                                        <div class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>No entry for <strong>'<span></span>'</strong> was found.</div>
                                                    </div>--%>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="Filterproject" value="">
                                        <div class="clarfix"></div>
                                    </div>


                                </th>
                                <th width="20%" class="text-center" ><i class="fas fa-sort" id="PeriodHeader" ></i>Period</th>
                                <th width="12%" class="text-center">Actual Hours</th>
                                <th width="12%" class="text-center">Expected Hours</th>
                                <th width="15%" class="text-center">Status <i class="fas fa-filter" id="FontStatusFilter" data-bs-toggle="collapse" data-bs-target="#TAfilterstatus" aria-expanded="false" aria-controls="navbar"></i>

                                    <div id="TAfilterstatus" class="selectpicker  collapse tblfiltering" data-clear="true" data-live="true">
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
                                                        <li class="optgroup" id="StatusFilter">
                                                            <span class="optgroup-header"></span>
                                                            <%-- <input id="StatuscheckAll" class="checkbox checkAll" type="checkbox">All <span class="subtext"></span></span>--%>
                                                            <ul class="list-unstyled" id="StatusFilterList">
                                                                <li class="filter-item items" data-bs-target="statussubmitted" data-filter="Submitted" data-value="2">
                                                                    <input type="checkbox">
                                                                    Submitted</li>
                                                                <li class="filter-item items" data-bs-target="statusapproved" data-filter="Approved" data-value="3">
                                                                    <input type="checkbox">
                                                                    Approved</li>
                                                                <li class="filter-item items" data-filter="Rejected" data-bs-target="statusrejected" data-value="4">
                                                                    <input type="checkbox">
                                                                    Rejected</li>
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
        <div class="modal-dialog modalsmall ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
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

                                        <div class="custom_chckbox" id="custom_chckbox">
                                            <input type="checkbox" id="rejecttaskmodalcheckbox">
                                            <label for="rejecttaskmodalcheckbox">Allow resource to change timesheet and resubmit</label>
                                           <%-- added by dipali v on 10th March 2021 for display note--%>
                                             </div>
                                         <ul id ="allowoverridenote" style="font-weight:700;"></ul>
                                      
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
                                <button class="btn btnyellow ml-1 float-end" id="btnRejectTimesheet" onclick="RejectAllTimesheet()">Reject</button>
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
        <div class="modal-dialog modalsmall ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
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
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" id="btnApproveTimesheet" onclick="ApproveAllTimesheet()">Approve</button>
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
        <div class="modal-dialog modal-lg">
            <!-- Modal content-->
            <div class="modal-content col-xs-12" style="padding-left: 0px; padding-right: 0px;">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Timesheet Approval History</h4>
                </div>
                <div class="modal-body">
                    <div class="fixedtable_container col-xs-12">
                        <table id="historyfixtbl" class="table table-stripped cust_fixed_tbl col-xs-12">
                            <thead>

                                <tr>
                                    <th style="width: 78px!important;">Status</th>
                                    <th style="width: 128px!important;">Generation Date</th>
                                    <th style="width: 130px!important;">Updated Date</th>
                                    <th style="width: 120px!important;">Action Taken By</th>
                                    <th style="width: 160px!important;">Action Taken</th>
                                    <th style="width: 116px!important;">Approver Name</th>
                                </tr>
                            </thead>

                            <tbody id="tbodyHistory" style="height: 285px; overflow-y: auto; position: absolute; width: 96%;">
                            </tbody>

                        </table>
                    </div>

                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!--modalEnd-->


 <!-- Created By Durgesh - Resource Timesheet Tab Offcanvas Section Start Here -->
 <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="MyTimesheetOffcanvas">
     <div class="offcanvas-body">
         <div class="container-fluid stickytopbar p-1">

            <div class="graybg container-fluid py-1 ">
             <div class="row">
                 <div class="col-sm-6">
                     <h5 class="pgtitle mb-0">Timesheet Details</h5>
                 </div>
                 <div class="col-sm-6 text-end">
                     <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close" id="btnCloseMyTimesheet"></button>
                 </div>
             </div>
         </div>

         <div class="row small-font">
             <div class="col-sm-4">
				<b>Week Period -</b> <span id="weekPeriod"></span>               
             </div>
             <div class="col-sm-8 d-flex justify-content-end align-items-center gap-2">
                <col><b>Week Total | Expected Hours -</b> <span id="expectedHours"></span> </col>
                 &nbsp;&nbsp;
                <col><b>Timesheet Status -</b> <span id="timesheetStatus"></span> </col>
             </div>
         </div>

         <div class="row ">
            <div class="col-md-6 col-sm-12 col-xs-12 float-start" id="tabs"></div>
            <div class="col-md-6 col-sm-12 col-xs-12 float-end">
            <div class="approval_crossandcheckbtn float-end pt-1 hides" style="display: block;">
            <div class="input-group" id="approvalButtonsContainer">
                <!-- Buttons will be dynamically appended here -->
            </div>
            </div>
    </div>
    <div class="clearfix"></div>
</div>
         </div>

       


         <table id="MyTimesheetInfoTbl" class="table table-bordered table-striped p-0 m-0 myTimesheetTbl " style="width:100%;">
             <thead class="stickyTSHeaderRes">
                 <tr class="headerGrey" id="tableHeaderRow">
                     <th width="25%" class="text-center">Projects/Tasks/Sub-Tasks</th>
                    
                 </tr>
                 <tr id="tableHeaderRow2">

                </tr>
             </thead>
             <tbody id="MyTimesheetInfoTbl_Body">
               
             </tbody>
         </table>
         
     </div>
 </div>
<!-- End Of Resource Timesheet Tab Offcanvas Section -->




    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->


<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
<%--<script src="../../../Whizible2.0-new/dist/UpdatedJs/moment-2.29.4.min.js"></script>--%>
<%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
<!-- custome js -->
<script src="../../../Whizible2.0-new/dist/js/custom.js?v=4"></script>--%>
 <script src="../../General/CommonValidations.js"></script>
<script>
        var isWeeklyView = 1;
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

        var EmployeeID;
        var startingDayOfWeek;
        var FinancialYearStart;
        var TodaysDate;

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
                    TodaysDate = d.TodaysDate;
                }
            },
            error: function (err) {
                console.log(err);
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        });

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
    </script>
    <%--  <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/weekPicker.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/weekPicker.js"></script>
    <script src="../../General/CommonFunctions.js"></script>
    <%-- <script src="../../../Whizible2.0-new/dist_new/js/weekPicker.js"></script>--%>
    <script type="text/javascript">
       

        $(function () {


            $(".tsapprovaltbl .custom_chckbox input[type='checkbox']").click(function () {
                if ($("#tableheadfixer td").closest("tr:visible").length == 0) { $(this).prop("checked", false); }
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
            $('#tableheadfixer').on('change', 'tbody td:nth-child(1) :checkbox', function () {
                var checked = $(this).is(':checked');
                if (checked == true) { SelectedRecords = 1; }
                else { $("#Tapprovalall").prop("checked", false); NoSelectedRecords = 1; }
                //$(".ts_headerbot .approval_crossandcheckbtn").toggle(!!$('.chktbl:checkbox:checked').length)
                if ($('.chktbl:checkbox:checked').length == 0) {
                    $(".ts_headerbot .approval_crossandcheckbtn").hide();
                }
                else {
                    $(".ts_headerbot .approval_crossandcheckbtn").show();
                }

                var a = $("input[type='checkbox'].chktbl");
                //Commented And Added By Usha Pandit On 31.07.2020 For selectall checkbox functionality
                //if (a.length == a.filter(":checked").length) {
                //    $("#Tapprovalall").prop("checked", true)
                //}
                var aVisibleCheckedLen = 0;
                a.each(function () {
                    var curId = $(this).attr("id");
                    var parentId = $("#" + curId).parent().parent().parent().attr("id");
                    if ($("#" + parentId).css("display") != "none") {
                        aVisibleCheckedLen = aVisibleCheckedLen + 1;
                    }
                });
                if (aVisibleCheckedLen == a.filter(":checked").length) {
                    $("#Tapprovalall").prop("checked", true)
                }
                //End Of Added By Usha Pandit On 31.07.2020 For selectall checkbox functionality
            });

            $("#fixedtbl2").freezeHeader({
                'height': '300px'
            });
            //freez table headerand scrollblein modal poup
            $("#historyfixtbl").freezeHeader({
                'height': '300px'
            })



        });

        $('.navstatuslink a').on('click', function () {
            $(".navstatuslink li a").removeClass("active");
            $(this).addClass("active");
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
            $('.tooltip').removeClass('show');
            setWeekCalendar($('#weekPicker2'), 'next', 1, startingDayOfWeek, FinancialYearStart, '', new Date(TodaysDate));
            ReloadData(EmployeeID);


        });

        $('#prev').click(function () {
            $('.tooltip').removeClass('show');
            setWeekCalendar($('#weekPicker2'), 'prev', 1, startingDayOfWeek, FinancialYearStart, '', new Date(TodaysDate));
            ReloadData(EmployeeID);



        });
        var globalOverrideTSCheck = false;
        var globalAllowToResubmitCheck = false;
           //Added By Dipali V On 23rd March 2021 For Note checking back Days
        var globalProjectLevelBackWardDays = false;
        var globalProjectLevelForWardDays = false;
        //End of Added By Dipali V On 23rd March 2021 For Note checking back Days
        var globalBackdatingNoDays = "0";
        jQuery(document).ready(function () {
            $(".btn_lightred").tooltip();

             //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
            //globalOverrideTSCheck = getCorporateOverrideTSCheck();
            //globalAllowToResubmitCheck = getCorporateAllowToResubmitCheck();
            //globalBackdatingNoDays = getBackdatingNoDays();
            //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings

            //alert();
            //Added by Dipali V On 26th March 2019 for Selected Tab should be display after redirction
            $('.navstatuslink a').each(function () {

                 //alert($(this).attr('id'));
                if ("<%= Request.QueryString("StatusSelected")%>" != "") {
                    if ($(this).attr('id') == "<%= Request.QueryString("StatusSelected")%>") {

                        $(this).removeClass("active");
                        $(this).addClass("active");

                    }
                    else {
                        $(this).removeClass("active");
                    }

                }
            })
            //End of Added by Dipali V On 26th March 2019 for Selected Tab should be display after redirction




            //$('#tableheadfixer').DataTable({
            //    "ordering": false,

            //    'paging': false,
            //    'lengthChange': false,
            //    'searching': false,
            //    'ordering': true,
            //    'info': false,
            //    'autoWidth': false
            //});
            //  $("#EmployeeNameFilter").css("color", "rgb(19, 89, 166)");
            //   $("#FontStatusFilter").css("color", "rgb(19, 89, 166)");
           
         


            PageFlag = '<%= Request.QueryString("Flag")%>';
            if (PageFlag == 3) {

                setWeekCalendar($('#weekPicker2'), 'Selected', 1, startingDayOfWeek, FinancialYearStart, new Date('<%= Request.QueryString("StartDate")%>'), new Date(TodaysDate));
                $("#" + '<%= Request.QueryString("SelectedStatus")%>' + "").trigger("click");

            }
            else {
                setWeekCalendar($('#weekPicker2'), 'yes', 1, startingDayOfWeek, FinancialYearStart, '', new Date(TodaysDate));
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
           
            // alert(EmployeeID);
            StartLoader("#bodyTSApproval1");
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
                    //  PlotDateTimeSection(TimesheetApproval.GetWeekCount)
                    PlotStatusSection(TimesheetApproval.TimesheetStatusLists)
                    PlotEmployeeSection(TimesheetApproval.TimesheetEmployeeList)
                    PlotTimesheetApprovalSection(TimesheetApproval.TimesheetApprovalLists)
                    $("#" + getSelectedStatus + "").trigger("click");
                    AfterPlot();
                    StopAjaxLoader("#bodyTSApproval1");
                  
                 
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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
            strHTML += '<li><input id="StatuscheckAll" class="checkbox checkAll" type="checkbox" onclick="selectallStatus()">All <span class="subtext"></span></li>'
            for (var i = 0; i < TimesheetStatusLists.length; i++) {
                var StatusObject = TimesheetStatusLists[i];
                var StatusCode = StatusObject.StatusCode;
                var StatusDescription = StatusObject.StatusDescription;
                if (StatusDescription != 'Not ready for approval') {

                    strHTML += "<li class='filter-item items' data-filter='Saved' data-value='" + StatusCode + "'>";
                    strHTML += "<input type='checkbox' class='clsFilterStatus' name='filterStatus' value='" + StatusCode + "'>";
                    if (StatusDescription == 'Ready for approval') { strHTML += " Submitted</li>"; }
                    else { strHTML += " " + StatusDescription + "</li>"; }

                }
            }
            $("#StatusFilterList").html(strHTML);
        }


        $('.navstatuslink li a').on('click', function () {
            // debugger;
            //var $target = $(this).data('target');
          
            var $target = $(this).attr('data-bs-target');
            $("#all").removeClass('active');
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


        $(".customelinks li.statusapproved a, .customelinks li.statussubmitted a").on('click', function () {
            // alert();
            $(".btnlistinline").hide();
        });


        $(".customelinks li.statusrejected a, .customelinks li.statusallactive a").on('click', function () {
            $(".btnlistinline").show();
        });
        function PlotEmployeeSection(TimesheetEmployeeList) {
            $("#EmployeeFilter").html('');
            var strHTML = "";
            strHTML += '<li><input id="EmployeecheckAll" class="checkbox checkAll" type="checkbox" onclick="SelectAllEmployeeName()">All <span class="subtext"></span></li>'
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
            //$('.modal-content .close').click(function () {

            //    $("#hdScrollhistoryfixtbl").css("height","auto");
            //     });



           
            $("#tbodyTimesheetApproval").html('');
            var ARowCount = 0;
            var RRowCount = 0;
            var SRowCount = 0;
            var AllCount = 0;
            var strHTML = "";
            var isdata = 0;
            for (var i = 0; i < TimesheetApprovalLists.length; i++) {

                
                isdata = 1;
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

                // alert(taskParameters.dtFromDate);
                if (StatusDescription == 'Not ready for approval') {
                    strHTML += " <tr data-status='statussaved' id='tr_" + TimeSheetID + "' class='" + EmployeeID + "'>";
                }
                else if (
                    StatusDescription == 'Ready for approval') {
                    strHTML += " <tr data-status='statussubmitted' id='tr_" + TimeSheetID + "' class='" + EmployeeID + "'>";
                }
                else if (StatusDescription == 'Approved') {
                    strHTML += " <tr data-status='statusapproved' id='tr_" + TimeSheetID + "' class='" + EmployeeID + "'>";
                }
                else if (StatusDescription == 'Rejected') {
                    strHTML += " <tr data-status='statusrejected' id='tr_" + TimeSheetID + "' class='" + EmployeeID + "'>";
                }

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
                    //Added and commented by Vishal Mane on 17/01/2025 to remove hyperlink for Practus Timesheet customization
                    //"<td class='mtdateperiod' id='" + FromDate + "_TO_" + ToDate + "' ><a href='javascript:;'  Class='Record" + StatusDescription +"' onclick=OpenTimesheetApprovalDetail(" + TimeSheetID + "," + EmployeeID + ",'" + FromDate + "','" + ToDate + "') >" + Period + "</a><br/><span class='clsnote"+StatusDescription+"'></span></td>" +

                    "<td class='mtdateperiod' id='" + FromDate + "_TO_" + ToDate + "'>" +
                    "<a href='javascript:;' id='MyTimesheetTab' data-bs-toggle='offcanvas' data-bs-target='#MyTimesheetOffcanvas' " +
                    "onclick='OpenTimesheetApprovalDetail(" + TimeSheetID + ", " + EmployeeID + ", \"" + FromDate + "\", \"" + ToDate + "\");'>" +
                    Period + "</a><br/><span class='clsnote" + StatusDescription + "'></span></td>"+


                    //"<td class='mtdateperiod' id='" + FromDate + "_TO_" + ToDate + "' >" + Period + "<br/><span class='clsnote" + StatusDescription + "'></span></td>" +
                    //End of Added and commented by Vishal Mane on 17/01/2025 to remove hyperlink for Practus Timesheet customization
                    "<td>" + AllTotal + "</td>" +
                    "<td class=''>" + ExpectedHours + "</td>" +
                    "<td class='clsStatus'>" +

                    "   <div class='btn-group btn-display'>";
                if (StatusDescription == 'Not ready for approval') { strHTML += "<button type='button' id='" + StatusCode + "' class='btn btn_lightred btnStatus'>Saved</button>"; }
                else if (StatusDescription == 'Ready for approval') { strHTML += " <button type='button' id='" + StatusCode + "' class='btn btn-info btnStatus'>Submitted</button>"; SRowCount += 1; }
                else if (StatusDescription == 'Approved') { strHTML += " <button type='button' id='" + StatusCode + "' class='btn btn-success btnStatus'>Approved</button>"; ARowCount += 1; }
                else if (StatusDescription == 'Rejected') { strHTML += "<button type='button' id='" + StatusCode + "' class='btn btn-red  btnStatus'>Rejected</button>"; RRowCount += 1; }

                strHTML += "<button data-bs-toggle='modal' data-bs-target='#historymodal' type='button' onclick='ShowHistory(" + TimeSheetID + ")' class='btn btn_lightred' > " +
                    "           <img class='float-end'  src='../../../Whizible2.0-new/dist/img/history-icon.svg' width='13px' alt=''  data-bs-toggle='tooltip' title='History' data-bs-placement='top' data-bs-container='body'>" +
                    "       </button>" +
                    "   </div>" +
                    "</td>" +
                    "<td class='text-left comment'><span class='comment'  title='" + Comment.replace("'", "\"") + "'  data-bs-toggle='tooltip' data-bs-placement='left' data-bs-container='body'>" + Comment + "</span></td>";
                if (StatusDescription != 'Rejected') {
                    strHTML += "<div class='approval_crossandcheckbtn float-end hides'>" +
                        " <div class='input-group'>";
                    if (StatusDescription == 'Ready for approval') {
                        strHTML += '     <button data-bs-toggle="modal" onclick=ShowApprovetaskbtnmodal(' + TimeSheetID + ',' + EmployeeID + ',"' + FromDate + '","' + ToDate + '") class="btn btn-outline-secondary btn-success" type="button" data-bs-placement="bottom" data-bs-container="body" title="Approve"><i class="fas fa-check"></i></button>';
                    }
                    if (StatusDescription == 'Approved') {
                        strHTML += "      <button data-bs-toggle='modal' onclick=ShowRejecttaskmodal(" + TimeSheetID + "," + EmployeeID + ",'" + FromDate + "','" + ToDate + "') class='btn btn-outline-secondary btn-red' type='button' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body' title='Reject'  style='border-radius:3px'><i class='fas fa-times'></i></button>";
                    }
                    else {
                        strHTML += "      <button data-bs-toggle='modal' onclick=ShowRejecttaskmodal(" + TimeSheetID + "," + EmployeeID + ",'" + FromDate + "','" + ToDate + "') class='btn btn-outline-secondary btn-red' type='button' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body' title='Reject'><i class='fas fa-times'></i></button>";
                    }
                    strHTML += "   </div>" +
                        "</div>";
                }
                strHTML += "</td></tr>";
                //alert(isdata);
                //if (isdata != 1) {
                //    $("#EmployeeNameFilter").hide();
                //    $("#FontStatusFilter").hide();
                //}

                $("#tbodyTimesheetApproval").html(strHTML);

               

                //alert(TimeSheetID);
                //if ($("#tr_" + TimeSheetID).length != 0)
                //if($("#tbodyTimesheetApproval #tr_" + TimeSheetID).is(":visible"))
                ///* if ($("#tbodyTimesheetApproval tr:visible").length != 0) */
                //{
                //    $("#EmployeeNameFilter").css("display", "contents");
                //    $("#FontStatusFilter").css("display", "contents");
                //} else {
                //    $("#EmployeeNameFilter").css("display", "none");
                //    $("#FontStatusFilter").css("display", "none");

                //}
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
            StopAjaxLoader("#bodyTSApproval1");
        }
        //function OpenTimesheetApprovalDetail(TimeSheetID, EmployeeID, FromDate, ToDate) {
        //  //  debugger;
        //    var arrTimesheetApprovalList = [];
        //    arrTimesheetApprovalList = GetTimesheetApprovalArrayList();
        //    sessionStorage.arrTimesheetApprovalList = JSON.stringify(arrTimesheetApprovalList);
        //    sessionStorage.arrNextCount = 0;

        //    for (var i = 1; i < arrTimesheetApprovalList.length; i++) {
        //        if (arrTimesheetApprovalList[i].arrTimesheetID == TimeSheetID) {
        //            sessionStorage.arrNextCount = i;
        //        }
        //    }


        //    var date = new Date($("#weekPicker2").attr("StartDate"));
        //    var dd = "";
        //    dd = date.getDate().toString();
        //    var mm = (date.getMonth() + 1).toString();
        //    if (dd.length == 1) dd = '0' + dd;
        //    if (mm.length == 1) mm = '0' + mm;

        //    var NewStartDate = mm + '/' + dd + '/' + date.getFullYear();
           
        //    window.location.href = "TimesheetEntry.aspx?intTimesheetId=" + TimeSheetID + "&Flag=3&intEmployeeID=" + EmployeeID + "&FromDate=" + FromDate + "&ToDate=" + ToDate + "&StartDate=" + NewStartDate + "&SelectedStatus=" + getSelectedStatus + "";
        //    //  window.location.href = "TimesheetEntry.aspx?intTimesheetId=" + TimeSheetID + "&Flag=3&intEmployeeID=" + EmployeeID + "&FromDate=" + FromDate + "&ToDate=" + ToDate + "&StartDate=" + $("#weekPicker2").attr("StartDate") + "&SelectedStatus=" + getSelectedStatus + "";
        //}

        //Added By Durgesh Dalvi For Resource Timesheet Offcanvas Data Appendentation On  24-01-25
        function OpenTimesheetApprovalDetail(TimeSheetID, EmpID, FromDate, ToDate) {
            var taskParameters = {
                intTimesheetID: TimeSheetID,
                intEmployeeID: EmpID,
                dtFromDate: FromDate,
                dtToDate: ToDate,
                //Added by Vishal Mane on 31/01/2025 to fix issue if Timesheet has 2 Approvers
                intApproverID: EmployeeID,
                //End of Added by Vishal Mane on 31/01/2025 to fix issue if Timesheet has 2 Approvers
            };
            //$('[data-bs-toggle="tooltip"]').tooltip();
            console.log('para:' + JSON.stringify(taskParameters));

            $.ajax({
                url: strUrl + '/api/TimesheetApproval/GetResourceTimesheetData',
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
                    console.log('xd: ' + JSON.stringify(data));

                    document.getElementById('weekPeriod').textContent = data.ResourceTimeSheet[0].StartDate + " to " + data.ResourceTimeSheet[0].EndDate;
                    document.getElementById('expectedHours').textContent = data.ResourceTimeSheet[0].TotalActual + ' | ' + data.ResourceTimeSheet[0].ExpectedHours;
                    document.getElementById('timesheetStatus').textContent = data.ResourceTimeSheet[0].TimesheetStatus;

                    /*$('#MyTimesheetInfoTbl').DataTable().destroy();*/

                    var headerRow = document.getElementById('tableHeaderRow');
                    //Commented and added by Vishal Mane on 11/07/2025 to display Holidays in Red color
                    //headerRow.innerHTML = `
                    //       <th width="25%" class="text-center align-middle">Projects/Tasks</th>
                    //        <th width="8.33%" class="text-center align-middle">${data.ResourceTimeSheet[0].DayoneName} <br> ${data.ResourceTimeSheet[0].Dayone}</th>
                    //        <th width="8.33%" class="text-center align-middle">${data.ResourceTimeSheet[0].DaytwoName} <br> ${data.ResourceTimeSheet[0].Daytwo}</th>
                    //        <th width="8.33%" class="text-center align-middle">${data.ResourceTimeSheet[0].DaythreeName} <br> ${data.ResourceTimeSheet[0].Daythree}</th>
                    //        <th width="8.33%" class="text-center align-middle">${data.ResourceTimeSheet[0].DayfourName} <br> ${data.ResourceTimeSheet[0].Dayfour}</th>
                    //        <th width="8.33%" class="text-center align-middle">${data.ResourceTimeSheet[0].DayfiveName} <br> ${data.ResourceTimeSheet[0].Dayfive}</th>
                    //        <th width="8.33%" class="text-center align-middle">${data.ResourceTimeSheet[0].DaysixName}  <br> ${data.ResourceTimeSheet[0].Daysix}</th>
                    //        <th width="8.33%" class="text-center align-middle">${data.ResourceTimeSheet[0].DaysevenName} <br> ${data.ResourceTimeSheet[0].Dayseven}</th>
                    //        <th width="8.33%" class="text-center align-middle">Actual Efforts</th>
                    //    `;
                    var TimeSheetWeekHeader = data.ResourceTimeSheet3;
                    var strHTMLHeader = '';                    
                    headerRow.innerHTML = `<th width="25%" class="text-center align-middle">Projects/Tasks</th>`;
                    for (var i = 0; i < TimeSheetWeekHeader.length; i++) {
                        var day = TimeSheetWeekHeader[i];
                        var cellClass = "text-center align-middle";
                        if (day.IsWorking % 2 !== 0) {
                            cellClass += " weekcolumnred";
                        }
                        strHTMLHeader += `
                        <th class="${cellClass}">
                            ${day.EntryDate}, 
                            <span class="d-block">${day.DayName}</span>
                        </th>`;
                    }
                    headerRow.innerHTML += strHTMLHeader;
                    headerRow.innerHTML += `<th width="8.33%" class="text-center align-middle">Actual Efforts</th>`;
                    //End of Commented and added by Vishal Mane on 11/07/2025 to display Holidays in Red color

                    var tbody = document.getElementById('MyTimesheetInfoTbl_Body');
                    tbody.innerHTML = '';
                    var headerRow2 = document.getElementById('tableHeaderRow2');
                    headerRow2.innerHTML = `
                        <tr class="stickyTSHeaderRow">
                            <td class="text-center">Total Work for a Day</td>
                            <td class="text-center">${data.ResourceTimeSheet[0].TotalMON}</td>
                            <td class="text-center">${data.ResourceTimeSheet[0].TotalTUE}</td>
                            <td class="text-center">${data.ResourceTimeSheet[0].TotalWED}</td>
                            <td class="text-center">${data.ResourceTimeSheet[0].TotalTHU}</td>
                            <td class="text-center">${data.ResourceTimeSheet[0].TotalFRI}</td>
                            <td class="text-center">${data.ResourceTimeSheet[0].TotalSAT}</td>
                            <td class="text-center">${data.ResourceTimeSheet[0].TotalSUN}</td>
                            <td class="text-center">${data.ResourceTimeSheet[0].TotalActual}</td>
                        </tr>
                        `;

                    var filteredProjects = data.ResourceTimeSheet1.filter(project =>
                        data.ResourceTimeSheet2.some(task => task.ProjectID === project.ProjectID)
                    );

                    filteredProjects.forEach(project => {
                        tbody.innerHTML += `
                    <tr>
                        <td colSpan=10>
                        <div class="tbl-projecttitleres" style="display: flex; align-items: center;">
                            <img class="project-iconres" src="../../../Whizible2.0-new/dist/img/Projects_icon_blue.svg" width: 22px; style="margin-right: 10px;"> ${project.ProjectName}
                        </div>
                        </td>
                    </tr>
                    `;

                //Added & commented by Dipali V on 20th Aug 2026 for Timesheet Description Display on approval page
                //data.ResourceTimeSheet2.filter(task => task.ProjectID === project.ProjectID).forEach(task => {
                //    tbody.innerHTML += `
                //    <tr>
                //        <td class="text-center">${task.TaskName}</td>
                //        <td class="text-center">${formatTime(task.MON) || '00:00'}</td>
                //        <td class="text-center">${formatTime(task.TUE) || '00:00'}</td>
                //        <td class="text-center">${formatTime(task.WED) || '00:00'}</td>
                //        <td class="text-center">${formatTime(task.THU) || '00:00'}</td>
                //        <td class="text-center">${formatTime(task.FRI) || '00:00'}</td>
                //        <td class="text-center">${formatTime(task.SAT) || '00:00'}</td>
                //        <td class="text-center">${formatTime(task.SUN) || '00:00'}</td>
                //        <td class="text-center">${formatTime(task.ActualHour) || '00:00'}</td>
                //    </tr>
                //    `;
                //        });
                //    });

                data.ResourceTimeSheet2.filter(task => task.ProjectID === project.ProjectID).forEach(task => {
                    tbody.innerHTML += `
                    <tr>
                        <td class="text-center">${task.TaskName}</td>
                        <td class="text-center">${getCellWithDescDropdown(formatTime(task.MON), task.MonDesc)}</td>
                        <td class="text-center">${getCellWithDescDropdown(formatTime(task.TUE), task.TueDesc)}</td>
                        <td class="text-center">${getCellWithDescDropdown(formatTime(task.WED), task.WedDesc)}</td>
                        <td class="text-center">${getCellWithDescDropdown(formatTime(task.THU), task.ThuDesc)}</td>
                        <td class="text-center">${getCellWithDescDropdown(formatTime(task.FRI), task.FriDesc)}</td>
                        <td class="text-center">${getCellWithDescDropdown(formatTime(task.SAT), task.SatDesc)}</td>
                        <td class="text-center">${getCellWithDescDropdown(formatTime(task.SUN), task.SunDesc)}</td>
                        <td class="text-center">${formatTime(task.ActualHour) || '00:00'}</td>
                    </tr>
                    `;
                        });
                    });
                //End of Added & commented by Dipali V on 20th Aug 2026 for Timesheet Description Display on approval page

                    var approvalButtons;
                    if (data.ResourceTimeSheet[0].TimesheetStatus.toLowerCase() === 'approved') {
                        //Added By Dipali V On 19th Feb 2025 For Mail ToID Issue
                        approvalButtons = `
                        <div class="input-group">
                        <button data-bs-toggle="modal" id="btnRejectAllTimesheet" onclick="ShowRejecttaskmodal(${TimeSheetID},${EmpID},'${FromDate}','${ToDate}',1)" class="btn btn-outline-secondary btn-red" type="button" data-bs-toggle="tooltip" data-container="body" title="Reject"><i class="fas fa-times" style="display: block"></i></button>
                        </div>
                        `;
                        //End of Added By Dipali V On 19th Feb 2025 For Mail ToID Issue
                    } else if (data.ResourceTimeSheet[0].TimesheetStatus.toLowerCase() === 'rejected') {
                        approvalButtons = ``;
                    } else {
                        approvalButtons = `
                        <div class="input-group">
                        <button data-bs-toggle="modal" id="btnApproveAllTimesheet" onclick="ShowApprovetaskbtnmodal(${TimeSheetID},${EmpID},'${FromDate}','${ToDate}')" class="btn btn-outline-secondary btn-success" type="button" data-bs-toggle="tooltip" data-container="body" title="Approve" style=""><i class="fas fa-check" style="display: block"></i></button>
                        <button data-bs-toggle="modal" id="btnRejectAllTimesheet" onclick="ShowRejecttaskmodal(${TimeSheetID},${EmpID},'${FromDate}','${ToDate}',1)" class="btn btn-outline-secondary btn-red" type="button" data-bs-toggle="tooltip" data-container="body" title="Reject"><i class="fas fa-times" style="display: block"></i></button>
                        </div>
                        `;
                    }

                    var container = document.getElementById("approvalButtonsContainer");
                    container.innerHTML = approvalButtons;
                    $('.btn').tooltip();

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            //$('[data-bs-toggle="tooltip"]').tooltip();
        }
        //End of Added by Durgesh Dalvi

        //Added by Dipali V on 20th Aug 2026 for Timesheet Description Display on approval page
        function getCellWithDescDropdown(time, desc) {
            if (!time) time = '00:00';

            const safeDesc = (desc || '')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');

            if (!desc || desc.trim() === '') {
                return `<span>${time}</span>`;
            }

            return `
          <div style="display:flex; justify-content:center; align-items:center; gap:6px;">
  
              <span>${time}</span>

              <div class="dropdown">
                  <i class="fas fa-ellipsis-v ps-1"
                     data-bs-toggle="dropdown"
                     data-bs-auto-close="outside"
                     style="cursor:pointer;">
                  </i>

                  <ul class="dropdown-menu p-2 TaskDescDropdown" style="min-width:280px; text-align:left;">
                      <div>
                          <textarea class="form-control InputDescription"
                              rows="4"
                              style="resize: both; min-height:80px; text-align:left;">${safeDesc}</textarea>
                      </div>
                  </ul>
              </div>

          </div>`;
        }
        //End of Added by Dipali V on 20th Aug 2026 for Timesheet Description Display on approval page

        function formatTime(value) {
            //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature      
            //if (!value) return '00:00'; // Handle empty or null values
            if (!value) return '-'; // Handle empty or null values
            //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
            value = value.toString().replace('.', ':'); // Convert to string and replace decimal point with colon
            let parts = value.split(':');
            if (parts.length === 1) parts.push('00'); // Add minutes if missing
            let hours = parts[0].padStart(2, '0'); // Ensure hours are 2 digits
            let minutes = parts[1].padEnd(2, '0').slice(0, 2); // Ensure minutes are 2 digits
            return `${hours}:${minutes}`;
        }

        function formatTotalTime(value) {
            if (value == null || value === "00:00") {
                return "-";
            }
            return value;
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                    }
                },
                success: function (data) {

                    PlotHistorySection(data.TimesheetHistoryLists);
                   

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
        function PlotHistorySection(TimesheetHistoryLists) {
            //alert("dsfd");
            //debugger;
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
           // debugger;
            //Added By Dipali V On 9th Jan 2019 For By Default Comment while approve the timesheet
            $("#txtApprovalComment").val("Approved");
            //End of Added By Dipali V On 9th Jan 2019 For By Default Comment while approve the timesheet
            $("#approvetaskbtnmodal").modal('show');

            document.getElementById("btnApproveTimesheet").setAttribute("onClick", "ApproveAllTimesheet(" + Tid + "," + ResourseID + ",'" + FromDate + "','" + ToDate + "');");
        }
        function ShowRejecttaskmodal(Tid, ResourseID, FromDate, ToDate, flag) {
            //debugger;
            $("#txtRejectionComment").val("");
            $("#rejecttaskmodal").modal('show');
            $('#custom_chckbox').css("display", "none");
            var curCheckId = '';
            $("#tableheadfixer .chktbl:checked").each(function () {
                if (curCheckId == "") {
                    curCheckId = $(this).attr("id");
                }
                else {
                    curCheckId += "," + $(this).attr("id");
                }
                curCheckId = curCheckId.toString().replace("TSubmitted", "");
                curCheckId = curCheckId.toString().replace("Tapproved", "");                
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
            globalBackdatingNoDays = getBackdatingNoDays();

            setTSOverrideNote();
            document.getElementById("btnRejectTimesheet").setAttribute("onClick", "RejectAllTimesheet(" + Tid + "," + ResourseID + ",'" + FromDate + "','" + ToDate + "'," + flag + ");");
            $("#rejecttaskmodal").modal('hide');
            //$("#MyTimesheetOffcanvas").offcanvas('hide');
            /*$("#Rejected").click();*/
            //Commented by Vishal Mane on 31/01/2025 to fix Reject button issue
            //if ($("#Rejected").hasClass("active")) {
            //    $("#Rejected").click();
            //} else if ($("#Approved").hasClass("active")) {
            //    $("#Approved").click();
            //} else if ($("#Submitted").hasClass("active")) {
            //    $("#Submitted").click();
            //} else {
            //    $("#All").click();
            //}
            //End of Commented by Vishal Mane on 31/01/2025 to fix Reject button issue
        }
        function ApproveAllTimesheet(Tid, ResourseID, FromDate, ToDate) {
           // debugger;
            // alert(Tid);
            // if (confirm("Do you want to Approve the selected Timesheets?")) {
            var strComment = "";
            //Added By Dipali V 9th Jan 2019 For Comment as Approved For Approved the timesheet
            strComment = $("#txtApprovalComment").val();
            if (strComment == "") {
                //Commented by dipali V on 31st March  2020 For Crash Issue while approve 
                //strComment = $("#txtApprovalComment").val("Approved");
                strComment = "Approved";
                 //End of Commented by dipali V on 31st March  2020 For Crash Issue while approve 
            } else {
                strComment = strComment;

            }
            //End of Added By Dipali V 9th Jan 2019 For Comment as Approved For Approved the timesheet
            
            // alert(strComment);
            //return;
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
            $("#MyTimesheetOffcanvas").offcanvas('hide');
            /* $("#Approved").click();*/
            if ($("#Rejected").hasClass("active")) {
                $("#Rejected").click();
            } else if ($("#Approved").hasClass("active")) {
                $("#Approved").click();
            } else if ($("#Submitted").hasClass("active")) {
                $("#Submitted").click();
            } else {
                $("#All").click();
            }

          
        }
        //Added by Vishal Mane on 14/10/2025 to have saperate MyTimesheet api end points in TimesheetEntry Controller
        var strUrlTimesheet = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Timesheet").ToString%>';
        //End of Added by Vishal Mane on 14/10/2025 to have saperate MyTimesheet api end points in TimesheetEntry Controller
        function ApproveTimesheetAjaxCall(Tid, strStatus, strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit) {
            //alert(ResourseID);
            taskParameters = {
                intTimesheetID: Tid,
                Status: strStatus,
                intEmployeeID: EmployeeID,
                strComment: strComment,
                intAllowToResubmit: bitAllowToResubmit,
                intResourceID: ResourseID,
                //2021
                FromWhere: 'RejectAll'
                //2021
            }
            StartLoader("#bodyTSApproval1");
            $.ajax({
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
                    //End of Added by Vishal Mane on 14/10/2025 to have saperate MyTimesheet api end points in TimesheetEntry Controller
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    if (taskParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                    }
                },
                success: function (data) {
                    //alert(data);
                  
                    if (data == 1) {
                        if (strStatus == 'V') {
                            window.open('../Email/SendEmail.aspx?MessageID=435&VerifiedBy=' + EmployeeID + '&ResourceID=' + ResourseID + '&FromDate=' + FromDate + '&ToDate=' + ToDate + '&TimesheetID=' + Tid + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=580');

                            //sendEmailAjaxCall();
                        }
                        else if (strStatus == 'J') {
                            window.open('../Email/SendEmail.aspx?MessageID=436&VerifiedBy=' + EmployeeID + '&ResourceID=' + ResourseID + '&FromDate=' + FromDate + '&ToDate=' + ToDate + '&TimesheetID=' + Tid + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=580');
                        }
                    }
                    ReloadData(EmployeeID);

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    StopAjaxLoader("#bodyTSApproval1");
                }
            })
        }

        //Added By Dipali V On 10th Feb 2021 For As per setting note will display
        function setTSOverrideNote() {
            $("#allowoverridenote").html("");
            if (globalOverrideTSCheck == true && globalAllowToResubmitCheck == false) {
                if (globalBackdatingNoDays != "00") {
                    $("#allowoverridenote").html("<li class='clsLI'>Over-riding Backward Re-entry and Submission Corporate Settings of upto " + globalBackdatingNoDays + " days is Enabled for Correction and Resubmission by User after Rejection of this Timesheet.</li>")
                        .append("<li class='clsLI'>" + "The tasks marked as ?Not Complete? can be edited by user and resubmitted.</li>")
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
            var BackdatingNoDays = "0";           
                        
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

        //End of Added By Dipali V On 10th Feb 2021 For As per setting note will display

        function RejectAllTimesheet(Tid, ResourseID, FromDate, ToDate, flag) {
             ///alert(ResourseID);
            //debugger;
             //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
           // setTSOverrideNote();
            //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
           
            //  if (confirm("Do you want to Reject the selected Timesheets?")) {
            var strComment = "";
            //Added By Dipali V On 4th Jan 2018 For Reject Comment Mandatory
            var Isvalid = 0;
            strComment = $("#txtRejectionComment").val();
            if (strComment == "") {

                showAlert("Enter Reason for rejection", "alert-danger");
                $("#txtRejectionComment").focus();
                Isvalid = 1;

            }
            //End of Added By Dipali V On 4th Jan 2018 For Reject Comment Mandatory

            var bitAllowToResubmit = ($("#rejecttaskmodalcheckbox").is(':checked') ? 1 : 0);
            //alert(bitAllowToResubmit);
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
            // Condition Added By Durgesh Dalvi On 24-01-25//
            //if (flag === 1) {
            //    getSelectedStatus = "NotAvailable";
            //}
            //END OF CONDITION

            if (Isvalid == 0) {
                if (getSelectedStatus === "Approved") {
                    //Added by Vishal Mane on 31/01/2025 To Reject/Approve timesheet when try to Reject/Approve from offcanvas section
                    if (flag == 1) {
                        ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit);
                    }
                    else {
                        $.each($("input[name='Tapproved']:checked"), function () {
                            var Tid = this.id.split('Tapproved')[1];
                            //Added By Dipali V On 3rd April 2020 For Reject Timesheet Mail Details Get Wrong
                            var trid = $(this).closest('tr').attr('id');
                            var FromDate = $("#" + trid + " td:nth-child(3)").attr('id').split("_TO_")[0];
                            var ToDate = $("#" + trid + " td:nth-child(3)").attr('id').split("_TO_")[1];
                            var ResourseID = $("#" + trid + " td:nth-child(2)").attr('id');
                            //End of Added By Dipali V On 3rd April 2020 For Reject Timesheet Mail Details Get Wrong                            
                            ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit);
                            //CheckedTimesheetIDs.push(Tid);
                        });
                    }
                    //End of Added by Vishal Mane on 31/01/2025 To Reject/Approve timesheet when try to Reject/Approve from offcanvas section
                    $("#rejecttaskmodal").modal('hide');
                }
                else if (getSelectedStatus === "Submitted") {
                    //Added by Vishal Mane on 31/01/2025 To Reject/Approve timesheet when try to Reject/Approve from offcanvas section
                    if (flag == 1) {
                        ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit);
                    } else {
                        $.each($("input[name='TSubmitted']:checked"), function () {
                            var Tid = this.id.split('TSubmitted')[1];
                            //Added By Dipali V On 3rd April 2020 For Reject Timesheet Mail Details Get Wrong
                            var trid = $(this).closest('tr').attr('id');
                            var FromDate = $("#" + trid + " td:nth-child(3)").attr('id').split("_TO_")[0];
                            var ToDate = $("#" + trid + " td:nth-child(3)").attr('id').split("_TO_")[1];
                            var ResourseID = $("#" + trid + " td:nth-child(2)").attr('id');
                            //End of Added By Dipali V On 3rd April 2020 For Reject Timesheet Mail Details Get Wrong
                            // return;
                            ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit);
                            //CheckedTimesheetIDs.push(Tid);
                        });
                    }
                    //End of Added by Vishal Mane on 31/01/2025 To Reject/Approve timesheet when try to Reject/Approve from offcanvas section
                    $("#rejecttaskmodal").modal('hide');
                }
                //Commented by Vishal Mane on 31/01/2025 To Reject/Approve timesheet when try to Reject/Approve from offcanvas section
                //else if (getSelectedStatus === "NotAvailable") { 
                //    ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit);
                //    $("#rejecttaskmodal").modal('hide');
                //}
                //End of Commented by Vishal Mane on 31/01/2025 To Reject/Approve timesheet when try to Reject/Approve from offcanvas section
                // Added By Durgesh Dalvi On 24-01-25//
                else {
                    //return
                    //ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit);
                    //Added by Vishal Mane on 31/01/2025 To Reject/Approve timesheet when try to Reject/Approve from offcanvas section
                    if (flag == 1) {
                        ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit);
                    } else {
                        $.each($("input[name='TSubmitted']:checked"), function () {
                            //debugger;
                            var Tid = this.id.split('TSubmitted')[1];
                             //Added By Dipali V On 3rd April 2020 For Reject Timesheet Mail Details Get Wrong
                            var trid = $(this).closest('tr').attr('id');
                            var FromDate = $("#" + trid + " td:nth-child(3)").attr('id').split("_TO_")[0];
                            var ToDate = $("#" + trid + " td:nth-child(3)").attr('id').split("_TO_")[1];
                            var ResourseID = $("#" + trid + " td:nth-child(2)").attr('id');
                             //End of Added By Dipali V On 3rd April 2020 For Reject Timesheet Mail Details Get Wrong
                                // return;
                                ApproveTimesheetAjaxCall(Tid, 'J', strComment, ResourseID, FromDate, ToDate, bitAllowToResubmit);
                                //CheckedTimesheetIDs.push(Tid);
                        });
                    }
                    //End of Added by Vishal Mane on 31/01/2025 To Reject/Approve timesheet when try to Reject/Approve from offcanvas section
                    //ReloadData(EmployeeID);
                    $("#rejecttaskmodal").modal('hide');
                }
                $("#MyTimesheetOffcanvas").offcanvas('hide');
                // End Of Added By Durgesh Dalvi//
            }
        }
        $("#Tapprovalall").change(function () {

            var checked = $(this).is(':checked');
            // $(".chktbl").prop("checked", checked);
            $("#tableheadfixer tbody tr:visible").find("td .chktbl").prop("checked", checked);
            //var rowCount = $("#tableheadfixer td").closest("tr:visible").length;
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
                $("#EmployeeNameFilter").css("color", "#364a4c");
            }
            $("input[type='checkbox'].filterEmployee").click(function () {
                //debugger
                var a = $("input[type='checkbox'].filterEmployee");
                if (a.length == a.filter(":checked").length) {

                    $("#EmployeecheckAll").prop('checked', true);

                }
            });
            $("input[type='checkbox'].filterEmployee").each(function () {
                var a = $("input[type='checkbox'].filterEmployee");
                if (a.length == a.filter(":checked").length) {

                    $("#EmployeecheckAll").prop('checked', true);

                }
            });
            filterEmployeeColumn();
        });
        //Added By Dipali V On 10th Jan 2019 For Checkbox Filter Issue

        $("#AllEmployeeCheckGroup").on('click', '[type=checkbox]', function () {
            var checkboxValues = [];
            $('#AllEmployeeCheckGroup input[type="checkbox"]:checked').each(function (index, elem) {
                checkboxValues.push($(elem).val());
            });
           
            var Totalcheckbox = $('#AllEmployeeCheckGroup input[type="checkbox"]').length;
            if (checkboxValues.length > 0) {
                $("#EmployeeNameFilter").css("color", "rgb(19, 89, 166)");
            } else {
                $("#EmployeeNameFilter").css("color", "#364a4c");
            }

            if (Totalcheckbox == checkboxValues.length) {
                $("#EmployeeNameFilter").css("color", "#364a4c");
            }
            $("input[type='checkbox'].filterEmployee").click(function () {


                var a = $("input[type='checkbox'].filterEmployee");
                if (a.length == a.filter(":checked").length) {

                    $("#EmployeecheckAll").prop('checked', true);

                }
            });


        });

        function SelectAllEmployeeName() {
            if ($('#EmployeecheckAll').prop('checked')) {
                $("#EmployeeFilter input[type='checkbox']").prop('checked', true);
            }
            else {
                $("#EmployeeFilter input[type='checkbox']").prop('checked', false);
                //Added By Dipali V On 3rd Apr 2019 For Filter Issue
                $("#" + getSelectedStatus + "").trigger("click");
                //End of Added By Dipali V On 3rd Apr 2019 For Filter Issue
            }

        }

        function selectallStatus() {
           
            if ($('#StatuscheckAll').prop('checked')) {
                $("#StatusFilter input[type='checkbox']").prop('checked', true);
            }
            else {
                $("#StatusFilter input[type='checkbox']").prop('checked', false);
                //Added By Dipali V On 3rd Apr 2019 For Filter Issue
                $("#" + getSelectedStatus + "").trigger("click");
                //End of Added By Dipali V On 3rd Apr 2019 For Filter Issue
            }


        }
        //End of Added By Dipali V On 10th Jan 2019 For Checkbox Filter Issue

        function filterEmployeeColumn() {
            //debugger
            var classes = [];
            var StatusID;
            var StatusClasses = [];
            $("input[name='filterEmp']").each(function () {
                if ($(this).is(":checked")) { classes.push('.' + $(this).val()); }
                else {
                }
            });

            $("input[name='filterStatus']").each(function () {
                if ($(this).is(":checked")) {
                    StatusClasses.push($(this).parent().text());
                }
                else {

                    //   
                }
            });

            $("#tableheadfixer tbody tr").each(function () {
                var show = false;
                var row = $(this);
                var rowStatus = $(this).find(".clsStatus").find(".btnStatus").text();
                if (classes == "") { // if no filters selected, show all items
                    if (SelNavStatus != 'all' && StatusClasses != "") {
                        if (row.find('td .btn').html() == "" + SelNavStatus + "") {
                            row.show();
                        }
                        else {
                            row.hide();
                        }
                    }
                    else {
                        StatusClasses.forEach(function (statusclassName) {                            
                            if (" " + rowStatus == "" + statusclassName + "" && (rowStatus == getSelectedStatus || getSelectedStatus == "all"))
                            {
                                show = true;
                            }
                            else
                            {

                            }
                        });
                            
                        if (show) {
                        row.show();
                        }
                        else {
                            row.hide();
                        }
                    }

                }
                else { // otherwise, hide everything...

                    show = false;
                    classes.forEach(function (className) {

                        if (StatusClasses.length != 0) {
                            StatusClasses.forEach(function (statusclassName) {
                                if ('.' + row.attr('class') == "" + className + "" && " " + rowStatus == "" + statusclassName + "" && (rowStatus == getSelectedStatus || getSelectedStatus == "all"))
                                {
                                    show = true;
                                }
                                else {
                                }
                             });
                            }
                        else {
                            //Commented and added by Vishal Mane on 29/01/2025 to fix filter issue for rejected records  
                            //if ('.' + row.attr('class') == "" + className + "" && (rowStatus == getSelectedStatus || getSelectedStatus == "all"))
                            //{
                            //    show = true;
                            //}
                            //else
                            //{

                            //}
                            if ((( '.' + row.attr('class') == "" + className + "" ) || ('.' + row.attr('class') == "" + className + "" + ' active'))
                                && (rowStatus == getSelectedStatus || getSelectedStatus == "all"))
                            {
                                show = true;
                            }
                            else
                            {

                            }
                            //End of Commented and added by Vishal Mane on 29/01/2025 to fix filter issue for rejected records 
                        }

                        });

                    if (show) {
                        row.show();
                    }
                    else {
                        row.hide();
                    }
                }

            });
            $("input[type='checkbox'].filterEmployee").click(function () {
                var a = $("input[type='checkbox'].filterEmployee");
                if (a.length == a.filter(":checked").length) {
                    $("#EmployeecheckAll").prop('checked', true);
                }
                if (a.filter(":checked").length == 0) {
                     //Added By Dipali V On 30rd March 2020 For Filter Issue
                    $("#" + getSelectedStatus + "").trigger("click");
                     //End of Added By Dipali V On 30rd March 2020 For Filter Issue
                }
            });
        }

        $("#StatusFilterList").on('click', '[type=checkbox]', function () {
            if ($(this).is(":checked") == false) {
                $("#StatuscheckAll").removeAttr('checked');
                $("#FontStatusFilter").css("color", "#364a4c");
            }

            filterStatusColumn();
        });

        //Added By Dipali V On 10th Jan 2019 For Checkbox Filter Issue
        $("#StatusFilter").on('click', '[type=checkbox]', function () {
            var checkboxStatusFilterValues = [];
            $('#StatusFilter input[type="checkbox"]:checked').each(function (index, elem) {
                checkboxStatusFilterValues.push($(elem).val());
            });
            var Totalcheckbox = $('#StatusFilter input[type="checkbox"]').length;
            if (checkboxStatusFilterValues.length > 0) {
                $("#FontStatusFilter").css("color", "rgb(19, 89, 166)");
            }
            else {
                $("#FontStatusFilter").css("color", "#364a4c");
            }
          
            if (Totalcheckbox == checkboxStatusFilterValues.length) {
                $("#FontStatusFilter").css("color", "#364a4c!important");
                // $("#FontStatusFilter").removeAttr("color");
            }

            $("input[type='checkbox'].clsFilterStatus").click(function () {


                var a = $("input[type='checkbox'].clsFilterStatus");
                if (a.length == a.filter(":checked").length) {

                    $("#StatuscheckAll").prop('checked', true);

                }
                if (a.filter(":checked").length == 0) {
                     //Added By Dipali V On 30rd March 2020 For Filter Issue
                $("#" + getSelectedStatus + "").trigger("click");
                 //End of Added By Dipali V On 30rd March 2020 For Filter Issue
                }

            });

        });

        //End of Added By Dipali V On 10th Jan 2019 For Checkbox Filter Issue
        function filterStatusColumn() {
           
            var classes = [];
            var data = [];
            var uniqueEmployees = [];
            $("input[name='filterStatus']").each(function () {
                
                if ($(this).is(":checked")) { classes.push('.' + $(this).val()); }
                else {
                    
                    $("#StatuscheckAll").removeAttr('checked');
                }
            });

            var Employees = [];
            $("input[name='filterEmp']").each(function () {
                if ($(this).is(":checked")) { Employees.push($(this).val()); }
                else {
                }
            });

            // $("#tableheadfixer tbody tr").hide();

            $("#tableheadfixer tbody tr").each(function () {
                
                var show = false;
                var row = $(this);
                if (classes == "") { // if no filters selected, show all items
                    var EmpId = (row.find('.clsEmployee')).attr('id')
                    var EmpName = row.find('.clsEmployee').html();
                    if (Employees.indexOf(EmpId) >= 0) {
                        data.push({
                            EmployeeID: EmpId,
                            EmployeeName: EmpName,
                        })
                        show = true;
                    }
                    if (show) { row.show(); }
                }
                else { // otherwise, hide everything...
                    classes.forEach(function (className) {
                      
                        if ('.' + (row.find('.clsStatus .btn')).attr('id') == "" + className + "") {
                            var EmpId = (row.find('.clsEmployee')).attr('id')
                            var EmpName = row.find('.clsEmployee').html();
                            if (Employees.indexOf(EmpId) >= 0) {
                                data.push({
                                    EmployeeID: EmpId,
                                    EmployeeName: EmpName,
                                })

                            }
                            show = true;
                        }
                    });
                    if (show) { row.show(); }
                    else { row.hide(); }
                }

            });

            $.each(data, function (index, entry) {
                if (!data[entry.EmployeeID]) {
                    data[entry.EmployeeID] = true;
                    uniqueEmployees.push(entry);
                }
            });
            // PlotEmployeeSection(uniqueEmployees);
        }

        $('.navstatuslink a').on('click', function () {
           
            //debugger;
            var Status = $(this).attr('id');

            getSelectedStatus = Status;
            $("#Tapprovalall").prop("checked", false);
            $("#tableheadfixer tbody tr:visible").find("td .chktbl").prop("checked", false);                
            if (Status == 'all') {

                $("#FontStatusFilter").show(); uncheckAllItems();
               //Added By Dipali V On 15th April 2023 For Reject timesheet status should not allow if we check through all tab
                $("#tbodyTimesheetApproval tr").each(function () {
                    //data-status="statusrejected"
                    /*Added By Dipali V On 4th March 2021 for Note CSS*/
                    if ($(this).attr("data-status") == "statusrejected") {
                        $(".RecordRejected").attr('style', 'color: black !important');
                        $(".RecordRejected").removeAttr('onclick');
                        $(".clsnoteRejected").html('<span class="clsnotereject">Note :- User Yet to Resubmit</span>');
                        $(".navstatuslink li a").removeClass("active");
                        $(this).addClass("active");
                    }
                    /*End of Added By Dipali V On 4th March 2021 for Note CSS*/
                });
                  //End of Added By Dipali V On 15th April 2023 For Reject timesheet status should not allow if we check through all tab
                $("#Tapprovalall").attr('disabled', true);
                $(".chktbl").attr('disabled', true);
                $(".checkTapprovalall").attr('style', 'cursor: not-allowed !important');
                $(".chktbl").attr('style', 'cursor: not-allowed !important');
                $(".navstatuslink li a").removeClass("active");
                $(this).addClass("active");
            }
            else {
                $("#FontStatusFilter").hide(); uncheckAllItems();
                if (Status == 'Rejected') {
                      /*Added By Dipali V On 4th March 2021 for Note CSS*/
                    $("#tbodyTimesheetApproval tr").each(function () {
                        //data-status="statusrejected"
                          /*Added By Dipali V On 4th March 2021 for Note CSS*/
                        if ($(this).attr("data-status") == "statusrejected")
                        {
                            $(".RecordRejected").attr('style', 'color: black !important');
                            $(".RecordRejected").removeAttr('onclick');
                            $(".clsnoteRejected").html('<span class="clsnotereject">Note :- User Yet to Resubmit</span>');
                            $(".navstatuslink li a").removeClass("active");
                            $(this).addClass("active");
                        }
                          /*End of Added By Dipali V On 4th March 2021 for Note CSS*/
                    });
                      /*End of Added By Dipali V On 4th March 2021 for Note CSS*/
                   $("#Tapprovalall").attr('disabled', true); $(".chktbl").attr('disabled', true);
                    $(".checkTapprovalall").attr('style', 'cursor: not-allowed !important');
                    $(".chktbl").attr('style', 'cursor: not-allowed !important');
                    $(".navstatuslink li a").removeClass("active");
                    $(this).addClass("active");
                }

                else {
                    $("#Tapprovalall").attr('disabled', false); $(".chktbl").attr('disabled', false);
                    $(".checkTapprovalall").attr('style', 'cursor: pointer !important');
                    $(".chktbl").attr('style', 'cursor: pointer !important');
                    if (Status == 'Approved') {
                        $("#btnApproveAllTimesheet").hide();
                        $(".navstatuslink li a").removeClass("active");
                        $(this).addClass("active");
                    }
                    else { $("#btnApproveAllTimesheet").show(); }
                }


            }


            SelNavStatus = Status;

            var data = [];
            var uniqueEmployees = [];
            
            $("#tableheadfixer tbody tr").each(function () {
               

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

            var Isdata = 0
            $.each(data, function (index, entry) {
                if (!data[entry.EmployeeID]) {
                    data[entry.EmployeeID] = true;
                    uniqueEmployees.push(entry);
                    Isdata = 1;
                }

            });

            //Added By Dipali V On 25th Jan 2019 For Filter Not display If no data
            if (Isdata != 1) {
                $("#EmployeeNameFilter").css("display", "none");
                if (Status == 'all') {
                    $("#FontStatusFilter").css("display", "contents");
                }
                else {
                    $("#FontStatusFilter").css("display", "none");
                }
                $(".fa-filter").css("display", "none");
            } else {
                $("#EmployeeNameFilter").css("display", "contents");
                if (Status == 'all') {
                    $("#FontStatusFilter").css("display", "contents");
                    $(".fa-filter").css("display", "inline-block");
                }
                else {
                    $("#FontStatusFilter").css("display", "none");

                }

                // $("#FontStatusFilter").css("display", "contents");

            }
            //End of Added By Dipali V On 25th Jan 2019 For Filter Not display If no data
            PlotEmployeeSection(uniqueEmployees);


        });
        function GetTimesheetApprovalArrayList() {
           
            var TimesheetApprovalList = [];
            $("#tableheadfixer tbody tr:visible").each(function () {
                // debugger;
                var rowTimesheetID = this.id.split('_')[1];
                var rowEmployeeID = $(this).find(".clsEmployee").attr('id');
                var rowFromDate = $(this).find(".mtdateperiod").attr('id').split("_TO_")[0];
                var rowToDate = $(this).find(".mtdateperiod").attr('id').split("_TO_")[1];

                TimesheetApprovalList.push({
                    arrTimesheetID: rowTimesheetID,
                    arrEmployeeID: rowEmployeeID,
                    arrFromDate: rowFromDate,
                    arrToDate: rowToDate,
                })
            })
            //alert(TimesheetApprovalList.arrTimesheetID);
            return TimesheetApprovalList;
        }
        function uncheckAllItems() {
            $('input:checkbox').removeAttr('checked');
            $(".ts_headerbot .approval_crossandcheckbtn").hide();
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {

                    ajaxResult = result;
                    //alert("success");
                },
                error: function (xhr) {
                    console.log(xhr);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + ""
                }
            })
           
            return ajaxResult;
        }
        function LimitText(txt) {
          
            var maxlength = $(txt).attr("maxlength");
            var currentLength = $(txt).val().length;

            if (currentLength >= maxlength) {
                showAlert("You can enter only 1000 characters.", "alert-danger");
            } else {
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

        function CloseShowAlert() {
            $('.ClosaeblealertMsg').hide();
        }

        function ParseDate(input) {
            
            theDate = new Date(parseInt(input.substring(6, 19)));

            return theDate.toLocaleDateString().replace(/[^A-Za-z 0-9 \.,\?""!@#\$%\^&\*\(\)-_=\+;:<>\/\\\|\}\{\[\]`~]*/g, '');
            //return theDate.toString('MM-dd-YYYY');
        }
    </script>

    <!--freezetbl_header_in_modalpopupbox-->
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/jquery.freezeheader.js"></script>

    <script>
        /*For Employee Sorting*/
        $('#EmployeeHeader').click(function () {
            
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparerstr($(this).parent('th').index()))
            this.asc = !this.asc
            if (!this.asc) { rows = rows.reverse() }
            for (var i = 0; i < rows.length; i++) { table.append(rows[i]) }
        })
        function comparerstr(index) {
            return function (a, b) {
              
                var valA = getCellValuestr(a, index), valB = getCellValuestr(b, index)
                
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.toString().localeCompare(valB)
            }
        }
        function getCellValuestr(row, index) { return $(row).children('td').eq(index).text() }
        /*End For Employee Sorting*/

        /*For Period sorting*/
          $('#PeriodHeader').click(function () {
            
              var table = $(this).parents('table').eq(0);
            
              var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).parent('th').index()));
              this.asc = !this.asc;
              if (!this.asc) { rows = rows.reverse(); }
              for (var i = 0; i < rows.length; i++) { table.append(rows[i]); }
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
        /*End For Period sorting*/

        /*Added By Durgesh Dalvi On 28-01-25*/
        document.addEventListener('DOMContentLoaded', function () {
            var filterCollapse = document.getElementById('TAfiltername');
            var searchInput = document.getElementById('txtSearchEmployee');

            filterCollapse.addEventListener('hidden.bs.collapse', function () {
                searchInput.value = ''; // Clear the input field
                EmployeeSearchFuntion(searchInput); // Re-trigger the search function to reset the results
            });

            filterCollapse.addEventListener('shown.bs.collapse', function () {
                EmployeeSearchFuntion(searchInput); // Ensure checkboxes are correctly displayed when reopening
            });
        });
        /*End of Added By*/



    </script>
</body>
</html>
