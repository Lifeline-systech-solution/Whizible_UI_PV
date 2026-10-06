<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TimesheetDetail_Mobile.aspx.vb" Inherits="PbNIT.TimesheetDetail_Mobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
        	<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("Weekly Timesheet")%> 
<head runat="server">
   <%-- <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Weekly Timesheet</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
 <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />

    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">--%>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/skins/_all-skins.min.css?v=2">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=2">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2.7">

    <style type="text/css">
        /*body{ overflow: hidden; }*/
        /*Added by Vishal Mane on 08/04/2026 for compact date controls in submitTSModal_Mobile*/
        #submitTSModal_TD #txtTSModalStartDate_TD,
        #submitTSModal_TD #txtTSModalEndDate_TD {
            font-size: 11px;
            line-height: 1.35;
        }
        #submitTSModal_TD .input-group-text {
            padding: 4px 10px;
        }
        /*End of Added by Vishal Mane on 08/04/2026*/

        .statusNotSubmitted-text {
            color: #7f05c2;
        }
        .mobview_weektablehead tr th.activeday {
            background: #2e52a3;
            color: #fff;
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
            width: 33%;
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

        .col-xs-1 {
            width: 8.33333333%;
        }
        .col-xs-10 {
            width: 83.33333333%;
        }

         @media screen and (max-width: 767px) {
            .tbl-header.mobview_weektablehead table {
                margin-bottom: 0;
                border-bottom: hidden;
            }
        }
      .autoclosablemsg{ display:none;}
       .popover-body {
            width:260px;
        }

        #alertMsg {
            font-size: 13px;
            width: 295px;
        }
       
         /*End of Added By Dipali V On 18th May 2023 For UI Issues */
        /*Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo*/
        #ui-datepicker-div {
            z-index: 11000 !important;
        }
        /*End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo*/
    </style>

</head>
<body class="skin-blue-light sidebar-mini dashmain fixed" id="bodyTSEntryMobile">
    <%--<form id="form1" runat="server">
        <div>
        </div>
    </form>--%>

    <div class="wrapper">
        <!-- Main Header -->
        <header class="main-header">

            <!-- Header Navbar -->
            <nav class="navbar navbar-static-top" role="navigation">

                <div class="mainheadingtop">
                    <a onclick="Back_Onclick()" class="backbtn MVbackbtn tab" id=""><i class="fas fa-chevron-left"></i></a>
                    &nbsp&nbsp <span id="spanHeaderName">Timesheet > Entry </span>
                </div>

                <div class="mainheaderrighticons pull-right" id="divHeader">
                    <button class="editviewaction" id="btnEdit" onclick="Edit_Onclick()"><i class="fas fa-pencil-alt"></i></button>
                    <button style="display: none;" class="saveviewaction" id="btnSave" onclick="Save_OnClick()"><i class="fas fa-save"></i></button>
                    <%--Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
                    <button style="display: none;" class="" id="btnSubmit" onclick="SubmitTS_OnClick_Confirmation_TD();"><i class="fas fa-check"></i></button>
                    <%--End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
                </div>
            </nav>
        </header>
        <!--bootstrap_Alertify-->
        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg"><%--  hidden="hidden"--%>
            <%--<button type="button" class="close" onclick="CloseShowAlert()">×</button>--%>
            <button type="button" class="close" onclick="CloseShowAlert()" aria-label="Close">&times;</button>
            <p id="alertMsg"></p>
        </div>
        <!--bootstrap_Alertify-->
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <!-- Main content -->
            <section class="content">
               
                <!--mobile view filter anel end-->
                <div class="Mv_weekdates hidden-desktop" id="DivHeaderTview" style="display: none">
                    <!--Weeklydate-->
                    <div class="tbl-header mobview_weektablehead">
                        <div class="row" id="divWeekRow">
                            <div class="col-xs-1"><i class="fas fa-caret-left left"></i></div>
                            <div class="col-xs-10 weektable-wrapper">
                                <table class="table table table-stripped" id="tblWeek">
                                    <tbody id="tbodyWeek">
                                        <tr>
                                            <th class="activeday datepicker">M<span id="selecteddate">18</span></th>
                                            <th class="datepicker">T<span>19</span></th>
                                            <th class="datepicker">W<span>20</span></th>
                                            <th class="datepicker">T<span>21</span></th>
                                            <th class="datepicker">F<span>22</span></th>
                                            <th class="datepicker">S<span>23</span></th>
                                            <th class="datepicker">S<span>24</span></th>
                                            
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-xs-1"><i class="fas fa-caret-right right"></i></div>
                        </div>
                    </div>
                </div>

                <div class="timesheetrow container-fluid pt-1 pb-1 graybg mv_tadetailtop" style="display: none" id="DivHeaderTApproval">
                    <table width="100%">
                        <tr>
                            <td id="tdEmployeeName"></td>
                            <td class="text-center" id="tdPeriod">
                                <br />
                            </td>
                            <td class="text-right" id="tdStatus">
                                <br />
                               
                            </td>
                        </tr>
                    </table>
                    <div class="clearfix"></div>
                </div>
                <!--Weeklydateend-->

                <div class="timesheetrow container-fluid bgwhite ts_headerbot">
                    <div class="row">
                        <%--Added by Vishal Mane on 07/04/2026: Flexible timesheet status toggle (same pattern as TimesheetEntry_Mobile.aspx), above Actual/Expected hours.--%>
                        <div class="col-xs-12" style="padding:6px 12px 0;font-size:11px;">
                            <div class="d-flex justify-content-between align-items-center" style="cursor:pointer;" data-bs-toggle="collapse" data-bs-target="#mvTsStatusCollapse_TD" aria-expanded="false">
                                <span class="fw-bold">Timesheet status</span><i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="collapse" id="mvTsStatusCollapse_TD"><div id="txtStatus_TD" class="pt-1"></div></div>
                        </div>
                        <%--End of Added by Vishal Mane on 07/04/2026--%>
                          <div class="col-md-6 col-sm-6 col-xs-7" id="IdActualHours">
                            <div class="Mv_actualwork_hrs hidden-desktop">Actual Hours : <span id="fltActualHours"></span>Hr</div>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-5 pull-right" id="IdExpectedHours">
                            <div class="Mv_actualwork_hrs hidden-desktop">Expected : <span id="ExpectedHours"></span>Hr</div>
                        </div>
                      
                        <div class="clearfix"></div>
                    </div>
                </div>

                <!--timesheet table-->
                <div class="timesheettable Mvtimesheettable">
                    <div class="container" id="DivMvTimesheet">
                    </div>
                </div>
                <!--timesheet table-->

                <!--projecttask modal for mobileview only-->

                <!--End projecttask modal for mobileview only-->

                <!--modalstart-->
                <!--rejectmodal-->
                <div id="rejecttaskmodal" class="modal fade custmodal rejecttaskmodal" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header ui-draggable-handle">
                                <button type="button" class="close" data-bs-dismiss="modal">×</button>
                                <h4 id="lblEmployeeName" class="modal-title" style="display: none;"></h4>
                                <h4 id="lblRejectTaskEmployeeName" class="modal-title" style="display: none;"></h4>
                                <center><small id="lblFromDateToDate"></small></center>
                            </div>
                            <div class="modal-body">
                                <div class="form-group" id="divTaskBlock">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-4 text-right clsTaskName" style="width: 35%;">Task Name:</div>
                                        <div class="col-xs-12 col-sm-8" style="width: 65%;">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-12 divTaskName" id="divTaskName">
                                                </div>
                                                <div class="col-xs-2 col-sm-4"></div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                      <%--  Added & Commented Dipali V On 28th May 2019--%>
                                          <%--  <div class="col-xs-12 col-sm-4 text-right">Reason for rejection:</div>--%>
                                          <div class="col-xs-12 col-sm-4 text-left">Reason for rejection:</div>
                                          <%--End of   Added & Commented Dipali V On 28th May 2019--%>
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
                                        <div class="col-xs-12 col-sm-8">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-12">

                                                    <div class="custom_chckbox">
                                                        <%--Commented And Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings--%>
                                                        <%--<input type="checkbox" id="rejecttaskmodalcheckbox">
                                                        <label for="rejecttaskmodalcheckbox">Allow resource to change timesheet and resubmit</label>--%>
                                                        <input type="checkbox" id="rejecttaskmodalcheckbox" class ="clsHide">
                                                        <label class ="clsHide" for="rejecttaskmodalcheckbox">Allow resource to change timesheet and resubmit</label>
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
                                        <div class="col-xs-6 col-sm-6 text-left" style="width:62%">
                                            <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                        </div>
                                        <div class="col-xs-6 col-sm-6" style="width:32%">
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
                                <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Approve Timesheet</h4>
                            </div>

                            <div class="modal-body">

                                <div class="form-group" id="divTaskBlock">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-4 text-right clsTaskName" style="width:35%">Task Name:</div>
                                        <div class="col-xs-12 col-sm-8" style="width:65%">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-12 divTaskName" id="divTaskName1">
                                                    
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
                                        <div class="col-xs-6 col-sm-6 text-left" style="width: 60%;">
                                            <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                        </div>
                                        <div class="col-xs-6 col-sm-6" style="width:40%;float:right">
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
                <!--modalEnd-->
                <!--Confirmation message Modal-->
                <div id="ConfirmMessagemodalinfo" class="modal fade custmodal" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" onclick="SendConfirmationResponse(0)" data-bs-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Message</h4>
                            </div>
                            <div class="modal-body">
                                <p id="ConfirmationMsg"></p>
                            </div>
                            <div class="modal-footer">
                                <button class="btn borderbtn pull-left uncheckbtn" data-bs-dismiss="modal" onclick="SendConfirmationResponse(0)">No</button>
                                <button class="btn btnyellow" data-bs-toggle="modal" data-original-title="" data-bs-dismiss="modal" title="" onclick="SendConfirmationResponse(1)">Yes</button>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <!--Confirmation message Modal modalEnd-->

                <!--Added by Vishal Mane on 18/11/2025 for 4 and 8 Hrs Timesheet Alert Validation for Expleo Customization-->
                <div id="fourandEightHoursValidation" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" id="btnFourandEightHoursValidation" data-bs-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Validation Message</h4>
                            </div>
                            <div class="modal-body">
                                <span class="sm_txt" id="txtLeaveValidationMessage"></span>
                            </div>
                            <div class="modal-footer">
                                <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal" id="btnLeaveClose">Close</button>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
               <!--End of Added by Vishal Mane on 18/11/2025 for 4 and 8 Hrs Timesheet Alert Validation for Expleo Customization-->
                <%--Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
                <div id="submitTSModal_TD" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-bs-focus="false">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Submit timesheet</h4>
                            </div>
                            <div class="modal-body">
                                <div id="txtStatus_TSModal_TD" class="mb-2" style="font-size:11px;max-height:120px;overflow:auto;"></div>
                                <div class="mt-2 text-muted" style="font-size:11px; line-height:1.35;">Select the date range for your timesheet submission. Dates are restricted to the current week.</div>
                        <div class="mt-2 text-muted" style="font-size: 11px;"><strong>Week Range: </strong><span id="lblWeekRange"></span></div>
                                <%--<div class="row g-2">
                                    <div class="col-12">
                                        <label class="form-label">From date</label>
                                        <input type="text" id="txtTSModalStartDate_TD" class="form-control" autocomplete="off" />
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">To date</label>
                                        <input type="text" id="txtTSModalEndDate_TD" class="form-control" autocomplete="off" />
                                    </div>
                                </div>--%>

                                  <div class="row mb-2 mt-2 align-items-center">
                            <div class="col-4">
                                <label class="form-label mb-0" style="font-size:11px; line-height:1.35;">From Date</label>
                            </div>
                            <div class="col-8">
                                <div class="input-group">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtTSModalStartDate_TD", "txtTSModalStartDate_TD", "form-control", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                                    <span class="input-group-text">
                                        <i class="fas fa-calendar-alt"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3 align-items-center">
                            <div class="col-4">
                                <label class="form-label mb-0" style="font-size:11px; line-height:1.35;">To Date</label>
                            </div>
                            <div class="col-8">
                                <div class="input-group">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtTSModalEndDate_TD", "txtTSModalEndDate_TD", "form-control", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                                    <span class="input-group-text">
                                        <i class="fas fa-calendar-alt"></i>
                                    </span>
                                </div>
                            </div>
                        </div>

                                <%--<div class="mt-2 text-muted" style="font-size:11px;">Selected Range: <span id="lblSelectedRange_TD"></span></div>--%>
                                <div class="mt-2 text-muted" style="font-size: 11px;"><strong>Selected Range: </strong><span id="lblSelectedRange_TD"></span></div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" id="btnSubmitTimesheet_TD" class="btn btnyellow" onclick="SubmitTS_OnClick_FlexibleTD();">Submit</button>
                                <button type="button" class="btn borderbtn" data-bs-dismiss="modal">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%--End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>

                <!--End entry screen mobile view-->
            </section>
        </div>

        <!-- /.content -->
    </div>

<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>


    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../General/CommonValidations.js"></script>
    <script src="../../../Whizible2.0/dist/js/custom_mobile.js"></script>

    <script type="text/javascript">
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
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
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
            return ajaxResultMobile;
        }

        var EmployeeID;
        var UserName;
        EmployeeID = '<%= Session("intUserID") %>';
        UserName = '<%= Session("strUserName") %>';
        //debugger;
        var StartDate = '<%= Request.QueryString("dtFromDate")%>';
        var EndDate = '<%= Request.QueryString("dtToDate")%>';
        var displayDate = "";
        var SelectedDate = '<%= Request.QueryString("dtEntryDate")%>';
        var TotalActual = '<%= Request.QueryString("TotalActual")%>';
        var IsDefault = 0;
        var intMaxEntry = 24;
        var TodayDate = GetTodayDate();
        var PageFlag = 0;
        var TimesheetStatus = "";
        var TimesheetID = 0;
        //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo (TD Datepicker support)
        var Global_oldStartDate_TD = "";
        var Global_oldEndDate_TD = "";
        var TSSubmissionDetails_TD = [];
        var HeaderResult_TD = null;
        //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo

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
        }
        else {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = MinDAEntry
        }

        $(document).ready(function () {
            //BindProjectFilterFropDown();
            //debugger;
            PageFlag = '<%= Request.QueryString("PageFlag")%>'
            if (PageFlag == 1) { $("#spanHeaderName").html("Timesheet > View") }
            if (PageFlag == 2) { $("#spanHeaderName").html("Timesheet > View") }
            if (PageFlag == 3) { $("#spanHeaderName").html("Timesheet > Approval"); $("#divHeader").css('display', 'none'); }

            if (PageFlag == 2 || PageFlag == 1) {
                //debugger;
                TimesheetStatus ='<%= Request.QueryString("TimesheetStatus")%>'
                $("#DivHeaderTview").css("display", "block");
                if (TimesheetStatus == "Submitted" || TimesheetStatus == "Approved") {
                    //$('.timenoinput').css('pointer-events', 'none');
                    //$('.SPCls').css('pointer-events', 'none');
                    $('#btnEdit').css('display', 'none');
                    $('#btnSubmit').css('display', 'none');
                }
            }
            else if (PageFlag == 3) {
                $("#DivHeaderTApproval").css("display", "block");
                $('#btnEdit').css('display', 'none');
                $('#btnSubmit').css('display', 'none');
                TimesheetID = '<%= Request.QueryString("TimesheetID")%>';
            }
            if (PageFlag != 3) {
                ReloadData(EmployeeID);
            }            
            GetExpectedActualHours();
            GetTimesheetStatus(EmployeeID);
            if (PageFlag == 3) {
                //debugger;
                $("#tdPeriod").html('<%= Request.QueryString("Period")%>');
                plotDailyTaskList();
            }
            $('.timenoinput').css('pointer-events', 'none');
            $('.SPCls').css('pointer-events', 'none');
            //Added By Dipali V On 6th Jan 2020 For Filter Issues
            //AfterResponsivePlot();
            //End of Added By Dipali V On 6th Jan 2020 For Filter Issues
            //Commented BY Yasmin on 13-3-19
            //$('.DescCls').css('pointer-events', 'none');
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

        //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo (TD - From/To datepicker open fix)
        document.addEventListener('focusin', function (e) {
            if (e.target && e.target.closest && e.target.closest('#ui-datepicker-div')) {
                e.stopImmediatePropagation();
            }
        }, true);

        function getFlexibleBounds_TD() {
            //debugger
            var start = normalizeDate_TD(new Date(StartDate));
            var end = normalizeDate_TD(new Date(EndDate));
            var selected = normalizeDate_TD(new Date(SelectedDate || StartDate));
            //Commented and added by Vishal Mane on 13/04/2026 to fix Calender date selection issue
            return { from: start, to: end };
            //var isCrossMonth = start.getMonth() !== end.getMonth() || start.getFullYear() !== end.getFullYear();
            //if (!isCrossMonth) {
            //    return { from: start, to: end };
            //}            
            //if (selected.getMonth() === start.getMonth() && selected.getFullYear() === start.getFullYear()) {
            //    return { from: start, to: new Date(start.getFullYear(), start.getMonth() + 1, 0) };
            //}
            //return { from: new Date(end.getFullYear(), end.getMonth(), 1), to: end };
            //End of Commented and added by Vishal Mane on 13/04/2026 to fix Calender date selection issue
        }

        function initFlexibleSubmitModalDatepickers_TD() {
            if (!$.fn.datepicker) return;
            var bounds = getFlexibleBounds_TD();
            var opts = {
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd M yy',
                minDate: bounds.from,
                maxDate: bounds.to,
                beforeShow: function () {
                    setTimeout(function () {
                        $('#ui-datepicker-div').css('z-index', 11000);
                    }, 0);
                },
                onSelect: function () {
                    // Trigger "change" so label text updates.
                    $(this).trigger('change');
                }
            };

            $('#txtTSModalStartDate_TD, #txtTSModalEndDate_TD').each(function () {
                try {
                    if ($(this).hasClass('hasDatepicker')) {
                        $(this).datepicker('destroy');
                    }
                } catch (ex) { }
            });

            $('#txtTSModalStartDate_TD, #txtTSModalEndDate_TD').datepicker(opts);
        }

        // Build datepicker once so touch devices can open immediately on input focus.
        initFlexibleSubmitModalDatepickers_TD();

        $('#submitTSModal_TD').on('shown.bs.modal', function () {
            initFlexibleSubmitModalDatepickers_TD();
            // Ensure picker opens reliably on first tap after modal animation.
            setTimeout(function () {
                try { $('#txtTSModalStartDate_TD').datepicker('show'); } catch (ex) { }
            }, 80);
        });

        $(document).on('focus click touchstart', '#txtTSModalStartDate_TD, #txtTSModalEndDate_TD', function () {
            try {
                if (!$(this).hasClass('hasDatepicker')) {
                    initFlexibleSubmitModalDatepickers_TD();
                }
                $(this).datepicker('show');
            } catch (ex) { }
        });

        $("#txtTSModalStartDate_TD").on("change", function () {
            var previous = Global_oldStartDate_TD;
            if (validateFlexibleTS_TD()) {
                Global_oldStartDate_TD = $("#txtTSModalStartDate_TD").val();
                Global_oldEndDate_TD = $("#txtTSModalEndDate_TD").val();
                $("#lblSelectedRange_TD").text(Global_oldStartDate_TD + " - " + Global_oldEndDate_TD);
            } else {
                $("#txtTSModalStartDate_TD").val(previous);
            }
        });

        $("#txtTSModalEndDate_TD").on("change", function () {
            var previous = Global_oldEndDate_TD;
            if (validateFlexibleTS_TD()) {
                Global_oldStartDate_TD = $("#txtTSModalStartDate_TD").val();
                Global_oldEndDate_TD = $("#txtTSModalEndDate_TD").val();
                $("#lblSelectedRange_TD").text(Global_oldStartDate_TD + " - " + Global_oldEndDate_TD);
            } else {
                $("#txtTSModalEndDate_TD").val(previous);
            }
        });
        //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo

        var ProjectIDList = "";
        var TaskTypeIDList = "";
        var TaskCategoryList = "";
        var TaskStatusList = "";
        var TaskPriorityList = "";
        var TaskIDList = ""
        function PreviousWeek() {
            //Added by Vishal Mane on 09/04/2026 to fix the enable disable issue
            projectRejectedRangeLock = new Set();
            projectRejectedRangeEnable = new Set();
            //End of Added by Vishal Mane on 09/04/2026 to fix the enable disable issue
            var startDate = new Date(StartDate);
            var endDate = new Date(StartDate);
            startDate.setDate(startDate.getDate() - 7);
            endDate.setDate(endDate.getDate() - 1)
            var sd = startDate.getDate();
            var sm = startDate.getMonth() + 1;
            var sy = startDate.getFullYear();

            var ed = endDate.getDate();
            var em = endDate.getMonth() + 1;
            var ey = endDate.getFullYear();

            var sdate = "" + sm + "/" + sd + "/" + sy + "";
            var edate = "" + em + "/" + ed + "/" + ey + "";
            StartDate = sdate;
            EndDate = edate;

            SelectedDate = StartDate;
            ReloadData(EmployeeID)
            if (PageFlag == 2 || PageFlag == 1) {
                GetExpectedActualHours();
                GetTimesheetStatus(EmployeeID);
            }
        }
        function NextWeek() {
            // debugger;
            //Added by Vishal Mane on 09/04/2026 to fix the enable disable issue
            projectRejectedRangeLock = new Set();
            projectRejectedRangeEnable = new Set();
            //End of Added by Vishal Mane on 09/04/2026 to fix the enable disable issue
            var startDate = new Date(EndDate);
            var endDate = new Date(EndDate);
            startDate.setDate(startDate.getDate() + 1);
            endDate.setDate(endDate.getDate() + 7)
            var sd = startDate.getDate();
            var sm = startDate.getMonth() + 1;
            var sy = startDate.getFullYear();

            var ed = endDate.getDate();
            var em = endDate.getMonth() + 1;
            var ey = endDate.getFullYear();

            var sdate = "" + sm + "/" + sd + "/" + sy + "";
            var edate = "" + em + "/" + ed + "/" + ey + "";
            StartDate = sdate;
            EndDate = edate;

            SelectedDate = StartDate;
            ReloadData(EmployeeID)
            if (PageFlag == 2 || PageFlag == 1) {
                GetExpectedActualHours();
                GetTimesheetStatus(EmployeeID);
            }
        }


        function StoryPoint_OnChange(objTextBox) {
            //debugger;
            var Isvalid = 0;
            if (isNaN(objTextBox.value)) {
                showAlert('Please enter numeric value', 'alert-danger');
                objTextBox.value = "0";
                Isvalid = 1;
                return false;
            }
            if (objTextBox.value != "") {
                //if (RestrictNonNumeric(objTextBox) == true) {
                //    showAlert('Please Enter positive numeric value for Story Point', 'alert-danger');
                //    objTextBox.value = "";
                //    return false;
                //}
                if (objTextBox.value < "0") {
                    showAlert('Please Enter only positive numeric value greater than 0 For Story Point', 'alert-danger');
                    objTextBox.value = "0";
                    Isvalid = 1;
                    return false;
                }
                var EntryID = (objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'Entry');
                var arrData = EntryID.split('_');
                var TaskID = arrData[2];
                var objEntryDate = document.getElementById(EntryID);
                //var TaskID = getNewTaskID(id);
                var taskParameters = {
                    TaskID: TaskID,
                    StoryPoint: objTextBox.value,
                    dtFromDate: objEntryDate.value
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
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (taskParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                        }
                    },
                    success: function (data) {
                        if (data != "") {
                            showAlert(data, 'alert-danger');
                            //objTextBox.value = "0";
                            Isvalid = 1;
                            //return false;
                        }
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });

            }
            if (Isvalid == 1) { return false; }
            else { return true; }
        }

        var DATextbox;
        var objDuChRow;
        var totalEnteredHours = 0;
        var hoursChangeValidation = false;
        function Hours_OnChange(objTextBox) {
            // debugger;
            var Isvalid = 0;
            var fn_argument = arguments.length;
            if (objTextBox.Value != "") {
                var dblColSum;
                dblColSum = 0;
                var objHoursComplete = document.getElementById(objTextBox.id);
                objHoursComplete.value = objHoursComplete.value.replace(/:/g, ".");
                var precision = objHoursComplete.value.split(".")[1];
                //if (precision.length == 1) {
                //    precision = '0' + precision;
                //}
                if (precision > 60) {
                    showAlert('Please enter minutes in two decimal and less than 60.', 'alert-danger');
                    Isvalid = 1;
                    //return false;

                }

                if (precision == 60) {
                    objHoursComplete.value = (objHoursComplete.value.split(".")[0] - 0) + 1;
                }
                DATextbox = objTextBox.id;

                //debugger;

                if ((objHoursComplete.value - 0) >= 0 && (objHoursComplete.value - 0) <= intMaxEntry) {
                } else {
                    showAlert('The Range of Actual Working Hours is [0.00 to ' + intMaxEntry.toFixed(2) + ']', 'alert-danger');
                    Isvalid = 1;
                    // return false;

                }
                objHoursComplete.value = (objHoursComplete.value - 0).toFixed(2);
                var ObjNewvalue = objHoursComplete.value;
                var onjNewIndex = objHoursComplete.value.split(".")[0];
                if (onjNewIndex.length == 1) {
                    ObjNewvalue = '0' + ObjNewvalue;
                }
                objHoursComplete.value = ObjNewvalue;
                var ObjOldValue = objHoursComplete.defaultValue.replace(/:/g, ".")

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
                    IsTaskCompleteCheck = objIsTaskComplete.value;

                objDuChRow = (objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'txtDuChRow');
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
                        if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                            showAlert('Please enter hours complete in multiples of ' + MinDAENtryDisplay, 'alert-danger');
                            Isvalid = 1;
                            //return false;
                        }
                        <%--if ((((objTextBox.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) - 0).toFixed(0) != ((objTextBox.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)) {
                            showAlert('Please enter hours complete in multiples of ' + <%=CommonFunctions.Application.MinHoursForDAEntry%>, 'alert-danger');
                            Isvalid = 1;
                            //return false;
                           
                        }--%>
                    }
                }
                totalEnteredHours = objHoursComplete.value;
                // debugger;
                if (ObjOldValue != ObjNewvalue) {
                    var taskParameters = {
                        intEmployeeID: EmployeeID,
                        dtFromDate: objEntryDate.value,
                        ProjectID: ProjectID,
                        TaskID: TaskID,
                        SubTaskTypeID: SubTaskTypeID,
                        Duration: objHoursComplete.value,
                        //Added By Dipali V On 22nd March 2021 For Get Total of Task
                        TotalDuration: totalEnteredHours,
                        //End of Added By Dipali V On 22nd March 2021 For Get Total of Task
                        IsTaskComplete: IsTaskCompleteCheck
                        , Flag: "Responsive"
                    }
                    $.ajax({
                        url: strUrl + '/api/Timesheet/ValidateDA',
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
                            if (data != "") {
                                if (data.indexOf('$$') >= 0) {
                                    var oldValue = objHoursComplete.value;
                                    var arrValue = data.split('$$');
                                    showAlert(arrValue[1], 'alert-danger');
                                    hoursChangeValidation = true;
                                    // objHoursComplete.value = oldValue - arrValue[0];
                                    if (((oldValue - 0) - (arrValue[0] - 0)) < 0)
                                        objHoursComplete.value = '0.00';
                                    Isvalid = 1;
                                    //return false;

                                }
                                else if (data.indexOf('@@') >= 0) {
                                    objHoursComplete.value = "";
                                    var arrValue = data.split('@@');
                                    hoursChangeValidation = true;
                                    showAlert(arrValue[1], 'alert-danger');
                                    if (arrValue[0] == 3 || arrValue[0] == 6 || arrValue[0] == 7) {
                                        if (objIsTaskComplete != null) {
                                            objIsTaskComplete.value = 0;
                                        }
                                    }
                                    Isvalid = 1;
                                    // return false;

                                }
                                else if (data.indexOf('##') >= 0) {
                                    var arrValue = data.split('##');
                                    if (arrValue[0] == 1) {
                                        showAlert(arrValue[1], 'alert-danger');
                                        Isvalid = 1;
                                        //Added & Commented By Dipali V On 15th march 2021 For Refresh Issue
                                        //objHoursComplete.value = "00.00";
                                        objHoursComplete.value = ObjOldValue;
                                        //End of Added & Commented By Dipali V On 15th march 2021 For Refresh Issue
                                        hoursChangeValidation = true;
                                        //alert("1 " + hoursChangeValidation);
                                        // return false;

                                    }
                                    else if (arrValue[0] == 0) {
                                        if (fn_argument == 1) {
                                            if (Isvalid == 0 && document.getElementById(objDuChRow).value == 0) {

                                                $("#ConfirmMessagemodalinfo").modal('show');
                                                $("#ConfirmationMsg").html(arrValue[1]);
                                            }
                                        }
                                    }
                                }
                                else {
                                    // debugger;
                                    if (ObjOldValue == ObjNewvalue) { }
                                    else {
                                        showAlert(data, 'alert-danger');
                                        hoursChangeValidation = true;
                                        // objHoursComplete.value = "00.00";
                                        //Added & Commented By Dipali V On 15th march 2021 For Refresh Issue
                                        //objHoursComplete.value = "00.00";
                                        objHoursComplete.value = ObjOldValue;
                                        //End of Added & Commented By Dipali V On 15th march 2021 For Refresh Issue

                                        Isvalid = 1;

                                        //return 0;
                                    }
                                }
                            }
                            else {
                                hoursChangeValidation = false;
                            }

                            //Added By Dipali V On 22nd March 2021 For Getting Alert if Exceed Work 
                            //if (hoursChangeValidation == true ) {
                            //    hoursChangeValidation = false;
                            //}
                            //End of Added By Dipali V On 22nd March 2021 For Getting Alert if Exceed Work 
                        },
                        error: function (err) {
                            //alert("");
                            console.log(err);
                        }
                    });
                }
                else {
                    //alert(hoursChangeValidation);
                    //hoursChangeValidation = false;
                }
                //alert(" Isvalid 2" + Isvalid);
                //alert("2 " + hoursChangeValidation);
                if (Isvalid == 1) {
                    //  debugger;
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

        function ReloadData(ProxyResourceID) {
            //debugger;
            if (ProxyResourceID == 0)
                ProxyResourceID = EmployeeID;
            else
                EmployeeID = ProxyResourceID;
            var taskParameters = {
                intEmployeeID: ProxyResourceID,
                dtFromDate: StartDate,
                dtToDate: EndDate,
                dtSelectedDate: (SelectedDate != "" ? SelectedDate : null),
            }
            StartLoader("#bodyTSEntryMobile");
            $.ajax({
                url: strUrl + '/api/Timesheet/GetMobileHeaderList',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                    }
                },
                success: function (data) {
                    // debugger;
                    var Timesheet = data;
                    SelectedDay(SelectedDate);
                    plotHeaderSection(Timesheet);



                    StopAjaxLoader("#bodyTSEntryMobile");
                    //alert(TimesheetID);
                },
                error: function (err) {
                    console.log(err);
                }
            })
        }
        function GetTimesheetStatus(ProxyResourceID) {
            //debugger;
            if (TimesheetID == 0) {
                var taskParameters = {
                    dtFromDate: StartDate,
                    dtToDate: EndDate,
                    intEmployeeID: EmployeeID,
                }
            }
            else {
                if (PageFlag == 2 || PageFlag == 1) {
                    var taskParameters = {
                        dtFromDate: StartDate,
                        dtToDate: EndDate,
                        intEmployeeID: EmployeeID,
                        intTimesheetID: TimesheetID,
                        PageFlag: PageFlag,
                    }
                }
                else {
                    var taskParameters = {
                        dtFromDate: StartDate,
                        dtToDate: EndDate,
                        intApproverID: EmployeeID,
                        intTimesheetID: TimesheetID,
                        PageFlag: PageFlag,
                        intEmployeeID:'<%= Request.QueryString("intEmployeeID")%>'
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
                    TimesheetID = data[0].TimesheetID;
                    if (data[0].Status == "Approved" || data[0].Status == "Ready for approval") {
                        $("#btnEdit").css('display', 'none');
                        $("#btnSubmit").css('display', 'none');
                        //$('.timenoinput').css('pointer-events', 'none');
                        //$('.SPCls').css('pointer-events', 'none');
                    }
                    else {
                        if (PageFlag == 1 || PageFlag == 2) {
                            $("#btnEdit").css('display', 'inline-block');
                            $("#btnSave").css('display', 'none');
                            $("#btnSubmit").css('display', 'inline-block');
                            if ($("#fltActualHours").html() == "00:00") {
                                $("#btnSubmit").css('display', 'none');
                                $("#btnEdit").css('display', 'none');
                            }
                        }
                        //$('.timenoinput').css('pointer-events', 'unset');
                        //$('.SPCls').css('pointer-events', 'unset');
                    }
                    if (PageFlag == 3) {
                        // debugger;
                        var strHTML = "";
                        TimesheetStatus = data[0].Status;
                        EmployeeName = data[0].EmployeeName;
                        $("#tdEmployeeName").html(EmployeeName);
                        $("#lblRejectTaskEmployeeName").text("Reject Task - " + EmployeeName);
                        $("#lblEmployeeName").text("Reject Timesheet - " + EmployeeName);
                        $("#lblFromDateToDate").text("" +  '<%= Request.QueryString("dtFromDate")%>' + " To " + '<%= Request.QueryString("dtToDate")%>' + "");
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
                              strHTML += '<button data-bs-toggle="modal" data-bs-target="#approvetaskmodal" id="btnApproveT" onclick="ApproveTimesheet()" class="btn btn-outline-secondary btn-success" type="button" data-original-title="" title=""><i class="fas fa-check"></i></button>';
                          }
                          strHTML += '<button data-bs-toggle="modal" data-bs-target="#rejectmodal" id="btnRejectT" onclick="RejectTimesheet()" class="btn btn-outline-secondary btn-red" type="button" data-original-title="" title=""><i class="fas fa-times"></i></button>';

                          strHTML += '</div>';
                          strHTML += '</div>';
                      }
                      $("#tdStatus").html(strHTML);
                      //Added By Dipali V On 20th Feb 2021 For Actual Hr Missing
                      //if (TotalActual != "") {
                      //    $("#fltActualHours").html(TotalActual);
                      //} else {
                      //     $("#fltActualHours").html("00:00");
                      //}
                      //End of Added By Dipali V On 20th Feb 2021 For Actual Hr Missing
                      //Added by Chetan M on 12 March 2021 for conversion of work hour 7.60 to 8 
                      var Total = data[0].ActualHours;
                      var precision = Total.split(".")[1];
                      if (precision == 60) {
                          Total = (Total.split(".")[0] - 0) + 1;
                      }
                      //End of Added by Chetan M on 12 March 2021 for conversion of work hour 7.60 to 8
                      //$("#fltActualHours").html(ConvertToDecimal(data[0].ActualHours));
                      $("#fltActualHours").html(ConvertToDecimal(Total));
                      $("#ExpectedHours").html(ConvertToDecimal(data[0].ExpectedHours));
                      if ($("#fltActualHours").html() == "0.00") {
                          $('#btnEdit').css('display', 'none');
                          $('#btnSubmit').css('display', 'none');
                      }
                      else {
                          $('#btnEdit').css('display', 'inline-block');
                          $('#btnSubmit').css('display', 'inline-block');
                      }
                  }


              },
              error: function (err) {
                  console.log(err);
              }
          });
        }
        function FilterTaskFromList() {
            //debugger;
            TaskIDList = "";

            $("#cboTasks").find("option:selected").each(function () {

                if ($(this).val() != 0) {
                    if (TaskIDList == "") {
                        TaskIDList += $(this).val().toString();
                    }
                    else {
                        TaskIDList += "," + $(this).val().toString();
                    }
                }
            });
            if (TaskIDList == "0" || TaskIDList == "") {
                showAlert("Please select atleast one task.", "alert-danger");
                return false;
            }
            IsDefault = 1;
            plotDailyTaskList();
            $("#Mv_createproject").modal('hide');
        }



        function plotHeaderSection(headerList) {
            //debugger;
            $("#divWeekRow").html("");
            var strHTML = "";
            var Flag = 0;
            strHTML += '<div class="col-xs-1" id="prev" onclick="PreviousWeek()"><i class="fas fa-caret-left left"></i></div>';
            strHTML += '<div class="col-xs-10 weektable-wrapper">';
            strHTML += '<table class="table table table-stripped">';
            strHTML += '<tbody id="tbodyWeek">';

            strHTML += "<tr>";
            for (var i = 0; i < headerList.length; i++) {
                //debugger;
                var header = headerList[i];
                var EntryDate = header.EntryDate;
                var DayName = header.DayName;
                var IsWorking = header.IsWorking;
                var Day = header.Day;
                var MonthName = header.MonthName;
                var Year = header.Year;
                var DayNameFirst = header.DayNameFirst;
                var CurrentDate = header.CurrentDate;
                //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                //var IsTodayDate = header.IsTodayDate;
                var IsTodayDate;
                if (SelectedDate === undefined) {
                    IsTodayDate = header.IsTodayDate;
                } else {
                    IsTodayDate = (CurrentDate === SelectedDate) ? 1 : 0;
                }
                //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                if (i == 0) { StartDate = CurrentDate };
                if (i == headerList.length - 1) { EndDate = CurrentDate };
                if (CurrentDate == TodayDate) {
                    displayDate = CurrentDate;
                    Flag = 1;
                }
                if (IsTodayDate == 1) {
                    if (IsWorking == 1 || IsWorking == 3) {
                        strHTML += '<th style="color: red;" id="th_' + CurrentDate + '" class="activeday datepicker" data-bs-toggle="tooltip" title="' + Day + " " + MonthName + " " + Year + '" onclick=SelectedDay("' + CurrentDate + '",this)>' + DayNameFirst + '<span>' + Day + '</span></th>';
                    }
                    else {
                        strHTML += '<th id="th_' + CurrentDate + '" class="activeday datepicker" data-bs-toggle="tooltip" title="' + Day + " " + MonthName + " " + Year + '" onclick=SelectedDay("' + CurrentDate + '",this)>' + DayNameFirst + '<span>' + Day + '</span></th>';
                    }

                }
                else {
                    if (IsWorking == 1 || IsWorking == 3) {
                        strHTML += '<th style="color: red;" id="th_' + CurrentDate + '" class="datepicker" data-bs-toggle="tooltip" title="' + Day + " " + MonthName + " " + Year + '" onclick=SelectedDay("' + CurrentDate + '",this)>' + DayNameFirst + '<span>' + Day + '</span></th>';
                    }
                    else {
                        strHTML += '<th id="th_' + CurrentDate + '" class="datepicker" data-bs-toggle="tooltip" title="' + Day + " " + MonthName + " " + Year + '" onclick=SelectedDay("' + CurrentDate + '",this)>' + DayNameFirst + '<span>' + Day + '</span></th>';
                    }
                }
            }
            if (Flag == 0) {
                displayDate = StartDate;
            }
            strHTML += '</tr>';
            strHTML += '</tbody>';
            strHTML += '</table>';
            strHTML += '</div>';
            strHTML += '<div class="col-xs-1" id="next" onclick="NextWeek()"><i class="fas fa-caret-right right"></i></div>';
            $("#divWeekRow").html(strHTML);

        }

        //  $('#tblWeek tbody tr th.datepicker').click(function() {
        //    debugger;
        //    //$('#menu li a.current').removeClass('current');
        //    //$(this).addClass('current');
        //});

        function SelectedDay(CurrentDate, element) {
            //debugger;
            if (element != undefined) {
                $(".mobview_weektablehead tr th").each(function () {
                    // debugger;
                    $(this).removeClass("activeday");
                })
                //element.addClass("activeday");
                element.classList.add("activeday");
            }
            SelectedDate = CurrentDate;
            if (PageFlag == 2 || PageFlag == 1) {
                GetExpectedActualHours();
                GetTimesheetStatus(EmployeeID);
                GetTimeSheetWeekHeaderDetails_TD();
                handleTimesheetButtons_TD();
            }
            plotDailyTaskList();
            //$("#btnEdit").css('display', 'inline-block');
            //$("#btnSave").css('display', 'none');
        }

        function GetExpectedActualHours() {
            //debugger;  
            var taskParameters = {
                dtFromDate: StartDate,
                dtToDate: EndDate,
                intEmployeeID: EmployeeID,
            }
            $.ajax({
                //Added and Modified by Vishal Mane on 20/11/2025to fix crash on edit mode.
                //url: strUrl + '/api/Timesheet/BindWeekDays',
                url: encodeURI(strUrlMobile) + '/api/TimesheetEntryNew/BindWeekDays',
                //End of Added and Modified by Vishal Mane on 20/11/2025to fix crash on edit mode.
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    //Added and Modified by Vishal Mane on 20/11/2025to fix crash on edit mode.
                    //xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    //End of Added and Modified by Vishal Mane on 20/11/2025to fix crash on edit mode.
                    if (taskParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                    }
                },
                success: function (data) {
                    //debugger;
                    //PlotWeekDays(data);
                    for (var i = 0; i < data.length; i++) {
                        var weekDays = data[i];
                        //Added by Chetan M on 12 March 2021 for conversion of work hour 7.60 to 8
                        var AllTotal = weekDays.AllTotal;
                        var precision = AllTotal.split(".")[1];
                        if (precision == 60) {
                            AllTotal = (AllTotal.split(".")[0] - 0) + 1;
                        }
                        //var AllTotal = ConvertToDecimal(weekDays.AllTotal);
                        AllTotal = ConvertToDecimal(AllTotal);
                        //End of Commented and Added by Chetan M on 12 March 2021 for conversion of work hour 7.60 to 8
                        var ExpectedHours = weekDays.ExpectedHours;
                        //Added By Dipali V On 8th March 2021 For Actual Hr not get refresh
                        if (AllTotal == "0.00") {
                            TotalActual = "00:00";
                        } else {
                            TotalActual = AllTotal;
                        }
                        //End of Added By Dipali V On 8th March 2021 For Actual Hr not get refresh

                        //Added By Dipali V On 20th Feb 2021 For Actual Hr Missing
                        if (TotalActual != "") {
                            $("#fltActualHours").html(TotalActual);
                        } else {
                            $("#fltActualHours").html("00:00");
                        }
                        //End of Added By Dipali V On 20th Feb 2021 For Actual Hr Missing
                        //$("#fltActualHours").html(ConvertToDecimal(AllTotal));
                        $("#ExpectedHours").html(ConvertToDecimal(ExpectedHours));
                        // debugger;
                        if ($("#fltActualHours").html() == "00:00") {
                            $('#btnEdit').css('display', 'none');
                            $('#btnSubmit').css('display', 'none');
                        }
                        else {
                            $('#btnEdit').css('display', 'inline-block');
                            $('#btnSubmit').css('display', 'inline-block');
                        }
                    }

                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function plotDailyTaskList() {
            //debugger;
            if (PageFlag == 3) {
                var taskParameters = {
                    intMobileView: 1,
                    intEmployeeID: '<%= Request.QueryString("intEmployeeID")%>',
                    dtFromDate: SelectedDate,
                    dtToDate: "",
                    intIsDefault: IsDefault,
                    strWhichTask: "",
                    strTaskIDList: TaskIDList,
                    strFilterProjectList: ProjectIDList,
                    strFilterTaskTypeList: TaskTypeIDList,
                    strFilterTaskCategories: TaskCategoryList,
                    strFilterBillable: "",
                    strFilterPriorityList: TaskPriorityList,
                    strFilterPhaseList: "",
                    strFilterMilestoneList: "",
                    strFilterSubProjectList: "",
                    strFilterModuleList: "",
                    strFilterDeliverableList: "",
                    strFilterTaskStatus: TaskStatusList,
                    SubTaskTypeList: "",
                    intTimesheetID:'<%= Request.QueryString("TimesheetID")%>',
                    intApproverID: EmployeeID
                }
            }
            else {
                var taskParameters = {
                    intMobileView: 1,
                    intEmployeeID: EmployeeID,
                    dtFromDate: SelectedDate,
                    dtToDate: "",
                    intIsDefault: IsDefault,
                    strWhichTask: "",
                    strTaskIDList: TaskIDList,
                    strFilterProjectList: ProjectIDList,
                    strFilterTaskTypeList: TaskTypeIDList,
                    strFilterTaskCategories: TaskCategoryList,
                    strFilterBillable: "",
                    strFilterPriorityList: TaskPriorityList,
                    strFilterPhaseList: "",
                    strFilterMilestoneList: "",
                    strFilterSubProjectList: "",
                    strFilterModuleList: "",
                    strFilterDeliverableList: "",
                    strFilterTaskStatus: TaskStatusList,
                    SubTaskTypeList: "",

                }
            }

            StartLoader("#bodyTSEntryMobile");
            $.ajax({
                url: strUrl + '/api/Timesheet/GetTaskListDayView',
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
                    var timesheetLists = data.timesheetLists;
                    PlotList(timesheetLists);
                    if ($("#btnSave").is(":visible") && (PageFlag == 1 || PageFlag == 2)) {
                        $('.timenoinput').css('pointer-events', 'auto');
                        $('.SPCls').css('pointer-events', 'auto');
                        $('.DescCls').css('pointer-events', 'auto');
                    }
                    if (typeof EnableDisbaleDATextbox_TD === 'function') { EnableDisbaleDATextbox_TD(); }
                    //debugger;
                    //if (IsTaskList == 1) {
                    //    $("#btnSave").css("display", "inline-block");
                    //}
                    //else {
                    //    $("#btnSave").css("display", "none");
                    //}
                    $("[data-bs-toggle=popover]").click(function (i, obj) {

                        $(this).popover({
                            html: true,
                            content: function () {
                                var id = $(this).attr('id')
                                return $('#popover-content-' + id).html();

                            }
                        });
                    });

                    $(document).on('click', '.close', function () {
                        //alert(this.id);
                        //debugger
                        //var id = this.id.split("close_")[1];
                        //$('#popover-content-' + id).parent().hide();
                        $(".popover").hide();
                        //$(this).parent().hide();
                    });
                    StopAjaxLoader("#bodyTSEntryMobile");
                },
                error: function (err) {
                    console.log(err);

                }
            })
        }
        var IsTaskList = 0;
        function PlotList(TaskList) {
            //debugger;
            $("#DivMvTimesheet").html("");

            var strHTML = "";
            var ActualDurationDayWise = 0.0;
            if (TaskList.length == 0) {
                IsTaskList = 0;

            }
            else {
                for (var i = 0; i < TaskList.length; i++) {
                    var task = TaskList[i];
                    var TaskID = task.TaskID;
                    var TaskName = task.TaskName;
                    var SubTaskType = task.SubTaskType;
                    var ProjectID = task.ProjectID;
                    var ProjectName = task.ProjectName;
                    var Description = task.Description;
                    var Duration = ConvertToDecimal(task.Duration);
                    var DayName = task.DayName;
                    var ActualWork = ConvertToDecimal(task.ActualWork);
                    var TaskActualWork = ConvertToDecimal(task.TaskActualWork);
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
                    var Work = ConvertToDecimal(task.Work);
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
                    var allowResubmitAttr = ' data-allowtoresubmit-id="' + (AllowToResubmit !== undefined && AllowToResubmit !== null ? AllowToResubmit : '') + '" ';
                    var RestrictByMinHours = task.RestrictByMinHours;
                    var IsApprover = task.IsApprover;
                    var TaskStatusFlag = task.TaskStatusFlag;

                    //debugger;
                    //TaskActualWork
                    if (task.Duration != 0) {
                        IsTaskList = 1;
                    }
                    //Added/commented by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                    else {
                        IsTaskList = 1;
                    } 
                    //if (task.Duration != 0) {
                    //End of Added/commented by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                        TimesheetID = task.TimesheetID;
                        if (Percentage > 100) {
                            strHTML += '<div class="timesheetentrycard"><table class="table progressred">';
                        }
                        else if (Percentage > 0 && Percentage <= 100) {
                            strHTML += '<div class="timesheetentrycard"><table class="table progressgreen">';
                        }
                        else {
                            strHTML += '<div class="timesheetentrycard"><table class="table">';
                        }

                        ActualDurationDayWise = ActualDurationDayWise + parseFloat(Duration)

                        //alert(ActualDurationDayWise);
                        strHTML += '<tbody>';
                        strHTML += '<tr>';
                        strHTML += '<td class="tbl-projecttitletd">';
                        strHTML += ' <div class="tbl-projecttitle">' + ProjectName + '</div>';
                        strHTML += '</td>';
                        strHTML += '<td>';
                        if (Description != "") {
                            strHTML += '<span class="mvnotelisticon"><i data-bs-toggle="collapse" data-bs-target="#mventryrdescriptionbox_' + TaskID + '" aria-expanded="false" class="far fa-list-alt"></i></span>';
                        }


                        strHTML += '<div class="dropdown pull-right ml-1">';
                        strHTML += '<img  src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px" alt="" data-bs-toggle="popover" data-container="body" data-placement="bottom"  data-html="true" id="' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '">';
                        strHTML += '<div id="popover-content-' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="dropdown-menu timeinfopopup" role="menu" aria-labelledby="menu1">';
                        //strHTML += '<div class="arrow-left"></div>';
                        strHTML += '<div class="projecttaskinfo_tooltipbox">';
                        strHTML += '<button type="button" class="close" data-bs-toggle="collapse" aria-expanded="false"  >';
                        strHTML += '<img width="20px" src="../../../Whizible2.0-new/dist/img/close-gray.svg" id="close-' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></button>';
                        strHTML += '<div class="PTItooltipbox_hading">';
                        strHTML += '' + ProjectName + '';
                        strHTML += '<br />';
                        //if (SubTaskType != "") {
                        //    strHTML += '<p>' + TaskName + '/' + SubTaskType + '</p>';
                        //}
                        //else {
                        strHTML += '<p>' + TaskName + '</p>';
                        //}
                        if (SubTaskType != "") {
                            strHTML += '<p>' + SubTaskType + '</p>';
                        }
                        strHTML += '</div>';
                        strHTML += '<p>' + Tasknotes + '</p>';
                        strHTML += '<div class="projecttaskinfo_tooltipbox_schedule">';
                        if (StartDate != "") {
                            strHTML += '<div class="row">';
                            strHTML += '<div class="col-xs-5">Start Date:</div>';
                            strHTML += '<div class="col-xs-7">' + StartDate + '</div>';
                            strHTML += '</div>';
                        }

                        if (EndDate != "") {
                            strHTML += '<div class="row">';
                            strHTML += '<div class="col-xs-5">End Date:</div>';
                            strHTML += '<div class="col-xs-7">' + EndDate + '</div>';
                            strHTML += '</div>';
                        }

                        strHTML += '<div class="row">';
                        strHTML += '<div class="col-xs-5">Allocated Work:</div>';
                        strHTML += '<div class="col-xs-7">' + Work + '</div>';
                        strHTML += '</div>';
                        strHTML += '<div class="row">';
                        strHTML += '<div class="col-xs-5">Actual Work:</div>';
                        strHTML += '<div class="col-xs-7">' + TaskActualWork + '</div>';
                        strHTML += '</div>';
                        strHTML += '</div>';
                        strHTML += '<hr />';
                        strHTML += '<div class="projecttaskinfo_tooltipbox_schedule">';

                        if (Phase != "") {
                            strHTML += '<div class="row">';
                            strHTML += '<div class="col-xs-5">Phase:</div>';
                            strHTML += '<div class="col-xs-7">' + Phase + '</div>';
                            strHTML += '</div>';
                        }
                        if (MileStone != "") {
                            strHTML += '<div class="row">';
                            strHTML += '<div class="col-xs-5">Milestone:</div>';
                            strHTML += '<div class="col-xs-7">' + MileStone + '</div>';
                            strHTML += '</div>';
                        }
                        if (SubProjectName != "") {
                            strHTML += '<div class="row">';
                            strHTML += '<div class="col-xs-5">Sub Project:</div>';
                            strHTML += '<div class="col-xs-7">' + SubProjectName + '</div>';
                            strHTML += '</div>';
                        }
                        if (ModuleName != "") {
                            strHTML += '<div class="row">';
                            strHTML += '<div class="col-xs-5">Module:</div>';
                            strHTML += '<div class="col-xs-7">' + ModuleName + '</div>';
                            strHTML += '</div>';
                        }
                        if (DeliverableName != "") {
                            strHTML += '<div class="row">';
                            strHTML += '<div class="col-xs-5">Deliverable:</div>';
                            strHTML += '<div class="col-xs-7">' + DeliverableName + '</div>';
                            strHTML += '</div>';
                        }
                        if (Issue != "") {
                            strHTML += '<div class="row">';
                            strHTML += '<div class="col-xs-5">Issue:</div>';
                            strHTML += '<div class="col-xs-7">' + Issue + '</div>';
                            strHTML += '</div>';
                        }
                        strHTML += '</div>';
                        strHTML += '</div>';
                        strHTML += '</div>';
                        strHTML += '</div>';
                        strHTML += '</td>';
                        strHTML += '</tr>';
                        strHTML += '<tr>';
                        strHTML += '<td>';
                        strHTML += '<div class="subtasklistcolumn">';
                        strHTML += '<div class="subtasklist">';
                        if (StatusFlag == 'J') {

                            strHTML += '<span style="color: red;" class="more">' + TaskName + '</span>';
                        }
                        else {

                            strHTML += '<span  class="more">' + TaskName + '</span>';
                        }

                        if (SubTaskType != "") {
                            strHTML += ' <div class="subtasklist">';
                            if (StatusFlag == 'J') {
                                strHTML += '<span style="color: red;"  class="more">' + SubTaskType + '<span>';
                            }
                            else {
                                strHTML += '<span  class="more">' + SubTaskType + '<span>';
                            }
                            strHTML += '</div>';
                        }

                        strHTML += '</div>';
                        strHTML += '</div>';
                        strHTML += '</td>';
                        strHTML += '<td>';
                        strHTML += '<div class="Mv_timeentryfield">';
                        strHTML += '<span class="timeno">';
                        strHTML += '<div class="timenodropdown">';
                        strHTML += '<input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + SelectedDate + '" name="">';
                        strHTML += '<input id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + IsTaskComplete + '" name="IsTaskComplete">';
                        strHTML += '<input id="WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="timenoinput" type="hidden" value="' + ActualPercentComplete + '" placeholder="' + ActualPercentComplete + '%" name="">'
                        strHTML += '<input id="RestrictByMinHours_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + RestrictByMinHours + '" name="">';
                        if (PageFlag == 3) {
                            strHTML += '<label class="timenoinput">' + Duration + ' <small>Hr</small></label>'
                        }
                        else {
                            //Commented And Added By Usha Pandit On 09.03.2021 For not allowing to edit DA if task is complete
                            //if (StatusFlag == 'R' || StatusFlag == 'V') {
                            //    strHTML += '<input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" style="pointer-events:none;"  maxlength="5" class="timenoinput collapsed" type="text" value="' + Duration + '" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name=""  data-bs-toggle="collapse" data-target="#" aria-expanded="false" autocomplete="off" readonly>';
                            //}
                            //else {
                            //    strHTML += '<input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" style="pointer-events:none;" OnBlur=Hours_OnChange(this);  maxlength="5" class="timenoinput collapsed" type="text" value="' + Duration + '" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name=""  data-bs-toggle="collapse" data-target="#mventryrdescriptionbox_' + TaskID + '" autocomplete="off" aria-expanded="false">';
                            //}
                            if (IsTaskComplete == 0) {
                                if (StatusFlag == 'R' || StatusFlag == 'V') {
                                    //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                                    //strHTML += '<input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" style="pointer-events:none;"  maxlength="5" class="timenoinput collapsed" type="text" value="' + Duration + '" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name=""  data-bs-toggle="collapse" data-bs-target="#" aria-expanded="false" autocomplete="off" readonly>';
                                    strHTML += '<input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" style="pointer-events:none;" OnBlur=Hours_OnChange(this);  maxlength="5" class="timenoinput taskTxt collapsed" type="text" value="' + Duration + '" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name="" data-entrydate-id="' + SelectedDate + '" data-statusflag-id="' + StatusFlag + '" data-projectid-id="' + ProjectID + '" ' + allowResubmitAttr + ' data-bs-toggle="collapse" data-bs-target="#' + TaskID + '" autocomplete="off" aria-expanded="false" readonly>';
                                    //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                                }
                                else {
                                    strHTML += '<input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" style="pointer-events:none;" OnBlur=Hours_OnChange(this);  maxlength="5" class="timenoinput taskTxt collapsed" type="text" value="' + Duration + '" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name="" data-entrydate-id="' + SelectedDate + '" data-statusflag-id="' + StatusFlag + '" data-projectid-id="' + ProjectID + '" ' + allowResubmitAttr + ' data-bs-toggle="collapse" data-bs-target="#mventryrdescriptionbox_' + TaskID + '" autocomplete="off" aria-expanded="false">';
                                }
                            }
                            else {
                                //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                                //strHTML += '<input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" style="pointer-events:none;"  maxlength="5" class="timenoinput collapsed" type="text" value="' + Duration + '" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name=""  data-bs-toggle="collapse" data-bs-target="#" aria-expanded="false" autocomplete="off" readonly>';
                                strHTML += '<input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" style="pointer-events:none;" maxlength="5" class="timenoinput taskTxt collapsed" type="text" value="' + Duration + '" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name="" data-entrydate-id="' + SelectedDate + '" data-statusflag-id="' + StatusFlag + '" data-projectid-id="' + ProjectID + '" ' + allowResubmitAttr + ' data-bs-toggle="collapse" data-bs-target="#" autocomplete="off" aria-expanded="false">';
                                //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo

                            }
                            //End Of Added By Usha Pandit On 09.03.2021 For not allowing to edit DA if task is complete
                        }
                        strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="0" name="">';
                        strHTML += '<input type="hidden" name="hdnTaskDataDaily" id="hdnTaskDataDaily" value="' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" />';
                        strHTML += '<input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + DAID + '" name="">';
                        strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';

                        strHTML += '<span class="selecttimeno">';
                        if (IsAgileProject == 1) {
                            if (PageFlag == 3) {
                                strHTML += '<label class="timenoinput">' + StoryPoint + ' <small>Pt</small></label>';
                            }
                            else {
                                if (IsTaskComplete == 1) {
                                    //Added/Modified by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                                    //strHTML += '<input type="text" value="' + StoryPoint + '" style="pointer-events:none;" placeholder="Story Points" id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" name=""  data-bs-toggle="collapse" onkeypress="return isNumberSP(event,this.value,this)" data-bs-target="#" aria-expanded="false" readonly>';
                                    strHTML += '<input type="text" value="' + StoryPoint + '" style="pointer-events:none;" placeholder="Story Points" id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" name=""  data-bs-toggle="collapse" onkeypress="return isNumberSP(event,this.value,this)" data-bs-target="#" aria-expanded="false">';
                                    //End of Added/Modified by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                                }
                                else {
                                    if (StatusFlag == 'R' || StatusFlag == 'V') {
                                        //Added/Modified by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                                        //strHTML += '<input type="text" class="SPCls" value="' + StoryPoint + '" style="pointer-events:none;" placeholder="Story Points" id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" name=""  data-bs-toggle="collapse" onkeypress="return isNumberSP(event,this.value,this)" data-bs-target="#" aria-expanded="false" readonly>';
                                        strHTML += '<input type="text" class="SPCls" value="' + StoryPoint + '" style="pointer-events:none;" placeholder="Story Points" id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" name=""  data-bs-toggle="collapse" onkeypress="return isNumberSP(event,this.value,this)" data-bs-target="#" aria-expanded="false" readonly>';
                                        //End of Added/Modified by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                                    }
                                    else {
                                        strHTML += '<input type="text" class="SPCls" value="' + StoryPoint + '" style="pointer-events:none;" placeholder="Story Points" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" name=""  data-bs-toggle="collapse" onkeypress="return isNumberSP(event,this.value,this)" data-bs-target="#mventryrdescriptionbox_' + TaskID + '" aria-expanded="false">';
                                    }
                                }
                            }
                        }
                        strHTML += '</span ></span > ';
                        //debugger;
                        if (PageFlag == 3) {
                            strHTML += '<div class="clearfix"></div>';
                            if (IsApprover == 1) {
                                strHTML += '<div class="approval_crossandcheckbtn mvapproval_crossandcheckbtn pull-right" style="float:right">';
                                strHTML += '<div class="input-group">';
                                //Commented And Added By Usha Pandit On 12.03.2021 For responsive approve/reject plotting issue
                                //if (StatusFlag == "J" || TimesheetStatus == "Rejected") { /*$("#btnApproveT").css("display", "none");*/ }
                                if (StatusFlag == "J" && TimesheetStatus == "Rejected") { /*$("#btnApproveT").css("display", "none");*/ }
                                //End Of Added By Usha Pandit On 12.03.2021 For responsive approve/reject plotting issue
                                else if (StatusFlag == "V") {
                                    strHTML += '<button data-bs-toggle="modal" id="btnRejectTask" onclick=RejectPopup(this,' + TaskID + ',"' + escape(TaskName) + '",' + ProjectID + ') class="btn btn-outline-secondary btn-red" type="button" data-original-title="" title=""><i class="fas fa-times"></i></button>';
                                }
                                else {
                                    strHTML += '<button data-bs-toggle="modal" id="btnApproveTask"  onclick=ApprovePopup(this,' + TaskID + ',"' + escape(TaskName) + '") class="btn btn-outline-secondary btn-success" type="button" data-original-title="" title=""><i class="fas fa-check"></i></button>';
                                    strHTML += '<button data-bs-toggle="modal" id="btnRejectTask" onclick=RejectPopup(this,' + TaskID + ',"' + escape(TaskName) + '",' + ProjectID + ') class="btn btn-outline-secondary btn-red" type="button" data-original-title="" title=""><i class="fas fa-times"></i></button>';
                                }

                                strHTML += ' </div >';
                                strHTML += '</div>';

                            }
                        }
                        strHTML += '</div>';
                        strHTML += '<div class="clearfix"></div>';
                        strHTML += '</div>';
                        strHTML += '</td>';
                        strHTML += '</tr>';
                        strHTML += '<tr>';
                        strHTML += '<td colspan="2">';
                        strHTML += '<div id="mventryrdescriptionbox_' + TaskID + '" class="notepopupbox collapse">';
                        strHTML += '<p>';
                        strHTML += 'Task Description';
                        strHTML += '<span class="pull-right"><i data-bs-toggle="collapse" data-bs-target="#mventryrdescriptionbox_' + TaskID + '" aria-expanded="false" class="fas fa-times ml-1"></i></span>';
                        strHTML += '</p>';
                        if (StatusFlag == 'R' || StatusFlag == 'V') {
                            strHTML += '<textarea class="form-control DescCls" maxlength="2000" style="" id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" onkeypress=limitText(this,2000) readonly>' + Description + '</textarea>';
                        }
                        else {
                            strHTML += '<textarea class="form-control DescCls" maxlength="2000" style="" id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" onkeypress=limitText(this,2000)>' + Description + '</textarea>';
                        }

                        strHTML += '</div>';
                        strHTML += '</td>';
                        strHTML += '</tr>';
                        strHTML += '</tbody>';
                        strHTML += '</table>';
                        strHTML += '</div>';
                }
                //Added/commented by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                //}
                //End of Added/commented by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                $("#DivMvTimesheet").html(strHTML);
            }
            //$("#fltActualHours").html(ActualDurationDayWise.toFixed(2) + " Hr");
        }
        function Save_OnClick() {
            //debugger;
            var isValid = 0;
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
                // debugger;
                if (objIsTaskComplete != null)
                    IsTaskCompleteCheck = objIsTaskComplete.value;

                if (Hours_OnChange(objDuration, 1) == false) {
                    isValid = 1;

                };
                objWorkCompleted = document.getElementById('WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objResourceLevelTaskCompletion = document.getElementById('ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objStoryPoint = document.getElementById('StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);

                var storypoint = 0;
                if (objStoryPoint != null) {
                    if (StoryPoint_OnChange(objStoryPoint, 1) == false) { isValid = 1; };
                    storypoint = objStoryPoint.value;
                    if (storypoint != 0) {
                        if (objDuration.value == 0) {
                            showAlert('Please Enter Daily Activity', 'alert-danger');
                            //ReloadData(EmployeeID);
                            //objDuration.focus();
                            isValid = 1;
                        }
                    }
                }
                var FlagDuration = false, FlagDescription = false, FlagStoryPoint = false;
                //var Default = objDuration.defaultValue.replace(/:/g, ".");
                var FlagDuration = (objDuration.value != objDuration.defaultValue ? true : false);
                if (objDescription != null && objDuration.value != "00:00") {
                    FlagDescription = (objDescription.value != objDescription.defaultValue ? true : false);
                }
                if (objStoryPoint != null) {
                    if (objDuration.value != "00:00") {
                        FlagStoryPoint = (objStoryPoint.value != objStoryPoint.defaultValue ? true : false);
                    }

                }
                //var Default = objDuration.defaultValue.replace(/:/g, ".");
                //if (objDuration.value != objDuration.defaultValue.replace(/:/g, ".") ) {
                if (FlagDuration == true || FlagDescription == true || FlagStoryPoint == true) {
                    daParams.push({
                        DailyActivityEntryID: objDAID.value,
                        TaskID: TaskID,
                        ProjectID: ProjectID,
                        EmployeeID: EmployeeID,
                        EntryDate: objEntryDate.value,
                        Duration: objDuration.value.replace(/:/g, "."),
                        Description: objDescription.value.replace(/'/g, "''"),
                        SubTasktypeID: SubTaskTypeID,
                        IsDurationChange: txtDuChRow.value,
                        IsTaskComplete: IsTaskCompleteCheck,
                        ActualPercentComplete: objWorkCompleted.value,
                        bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                        StoryPoint: storypoint,
                        //Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                        dtFromDate: '<%= Request.QueryString("dtFromDate")%>',
                        dtToDate: '<%= Request.QueryString("dtToDate")%>',
                        //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                    });
                }
            }

            console.log(daParams);

            var IsAnyDAfilled = $("#fltActualHours").text();
            if (daParams.length == 0 && hoursChangeValidation == false) {
                if (IsAnyDAfilled == "00:00 Hr" && $('#DivMvTimesheet .timenoinput').is('[readonly]') == false) {
                    showAlert('Please fill daily activity', 'alert-danger');
                    //objDuration.focus();
                }
                isValid = 1;
            }
            if (hoursChangeValidation == true) {
                isValid = 1;
            }
           // var Parameter = { '': daParams }
            if (isValid == 0) {
                StartLoader("#bodyTSEntryMobile");
                $.ajax({
                    url: strUrl + '/api/Timesheet/SaveDailyActivity',
                    type: "POST",
                    //Commented and Added By Riddhesh Patil on 3rd April 2023
                   // data: JSON.stringify(Parameter),
                    data: { '': daParams },
                    //End of Commented and Added By Riddhesh Patil on 3rd April 2023
                    dataType: "json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        //if (Parameter) {
                        //    xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                        //}
                    },
                    success: function (data) {
                        //if (data == 1) {
                        //debugger;
                        showAlert('Daily Activity entered successfully.', 'alert-success', 'btnSave');
                        hoursChangeValidation = false;
                        totalEnteredHours = 0;
                        plotDailyTaskList();
                        //Added By Dipali V On 8th March 2021 For Actual Hr not get refresh
                        TotalActual = "";
                        //End of Added By Dipali V On 8th March 2021 For Actual Hr not get refresh
                        if (PageFlag == 2 || PageFlag == 1) {
                            GetExpectedActualHours();
                            GetTimesheetStatus(EmployeeID);
                            //debugger;
                            //Added By Dipali V On 8th March 2021 For Actual Hrs Zero then should not Submite TS
                            if (TotalActual == "00:00") {
                                $("#divHeader").css("display", "none");

                            }
                            //End of Added By Dipali V On 8th March 2021 For Actual Hrs Zero then should not Submite TS

                            //ReloadData(EmployeeID);
                        }

                    },
                    error: function (err) {
                        StopAjaxLoader("#bodyTSEntryMobile");
                        console.log(err);
                    }
                });
            }

        }
        function ViewTimesheet() {
            //Commented And Added By Usha Pandit On 16.03.2021 For Resubmit Note display issue
            //window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&intTimesheetID=" + TimesheetID + "&PageFlag=2";
            window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&intTimesheetID=" + TimesheetID + "&PageFlag=2" + "&EmployeeID=" + "<%= Session("intUserID") %>";
            //End Of Added By Usha Pandit On 16.03.2021 For Resubmit Note display issue
        }



        function GetTodayDate() {
            //debugger;
            var tdate = new Date();
            var dd = tdate.getDate(); //yields day
            var MM = tdate.getMonth() + 1; //yields month
            var yyyy = tdate.getFullYear(); //yields year
            var currentDate = "" + MM + "/" + dd + "/" + yyyy + "";

            return currentDate;
        }
        function getSelectedValues() {

            var selectedVal = $("#multiselect").val();
            for (var i = 0; i < selectedVal.length; i++) {
                function innerFunc(i) {
                    setTimeout(function () {
                        location.href = selectedVal[i];
                    }, i * 2000);
                }
                innerFunc(i);
            }
        }

        $('#Mvfilterpanel .selectpicker').each(function () {
            $(this).find('option:first').prop('selected', 'selected');
        });

        //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
        function normalizeDate_TD(d) { return new Date(d.getFullYear(), d.getMonth(), d.getDate()); }
        function formatDDMMMYYYY_TD(date) {
            var d = new Date(date);
            return d.getDate() + " " + d.toLocaleString("en-US", { month: "short" }) + " " + d.getFullYear();
        }
        //Commented and added by Vishal Mane on 12/05/2026 to fix Timezone issue
        //function convertToAPIDate_TD(dateStr) {
        //    var parts = (dateStr || "").split(" ");
        //    if (parts.length < 3) return dateStr;
        //    var dateObj = new Date(parts[0] + " " + parts[1] + " " + parts[2]);
        //    return dateObj.toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });
        //}
        function convertToAPIDate_TD(dateStr) {
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
        //End of Commented and added by Vishal Mane on 12/05/2026 to fix Timezone issue
        function getStatusForDate_TD(date) {
            if (!TSSubmissionDetails_TD.length) return null;
            for (var i = 0; i < TSSubmissionDetails_TD.length; i++) {
                var item = TSSubmissionDetails_TD[i];
                var from = normalizeDate_TD(new Date(item.FromDate));
                var to = normalizeDate_TD(new Date(item.ToDate));
                if (date >= from && date <= to) return item;
            }
            return null;
        }
        function handleTimesheetButtons_TD() {
            if (!(PageFlag == 1 || PageFlag == 2)) return;
            var day = normalizeDate_TD(new Date(SelectedDate || StartDate));
            var statusObj = getStatusForDate_TD(day);
            if (!statusObj) return;
            var status = (statusObj.Status || "").toLowerCase();
            if (status === "approved" || status === "submitted" || status === "ready for approval") {
                $("#btnEdit").css("display", "none");
                $("#btnSubmit").css("display", "none");
                return;
            }
            if (status === "not submitted" || status === "rejected") {
                $("#btnEdit").css("display", "inline-block");
                if (($("#fltActualHours").text() || "").trim() === "00:00") {
                    $("#btnSubmit").css("display", "none");
                } else {
                    $("#btnSubmit").css("display", "inline-block");
                }
            }
        }
        function validateRejectedExactMatch_TD(startDate, endDate) {
            for (var i = 0; i < TSSubmissionDetails_TD.length; i++) {
                var item = TSSubmissionDetails_TD[i];
                if ((item.Status || "").toLowerCase() !== "rejected") continue;
                var from = normalizeDate_TD(new Date(item.FromDate));
                var to = normalizeDate_TD(new Date(item.ToDate));
                if (startDate.getTime() === from.getTime() && endDate.getTime() === to.getTime()) return true;
            }
            return false;
        }
        function parseAllowToResubmit_TD(input) {
            var v = input.attr("data-allowtoresubmit-id");
            if (v === undefined || v === null || v === "") return null;
            var s = ("" + v).toLowerCase();
            if (s === "0" || s === "false" || s === "no") return false;
            if (s === "1" || s === "true" || s === "yes") return true;
            return null;
        }
        function syncMobileDARowFromTaskInput_TD(input, locked) {
            var id = input.attr("id");
            if (!id || id.indexOf("Duration_") !== 0) return;
            var suffix = id.substring("Duration_".length);
            var desc = $("#Description_" + suffix);
            var sp = $("#StoryPoint_" + suffix);
            var sf = (input.attr("data-statusflag-id") || "").toUpperCase();
            var entryDateStr = input.attr("data-entrydate-id");
            var st = "";
            if (entryDateStr) {
                var stObj = getStatusForDate_TD(normalizeDate_TD(new Date(entryDateStr)));
                st = stObj ? (stObj.Status || "").toLowerCase() : "";
            }
            if (locked) {
                desc.prop("readonly", true).css("pointer-events", "none");
                if (sp.length) sp.prop("readonly", true).css("pointer-events", "none");
                return;
            }
            if (st === "rejected") {
                desc.prop("readonly", false).css("pointer-events", "auto");
                if (sp.length) sp.prop("readonly", false).css("pointer-events", "auto");
                return;
            }
            if (sf === "R" || sf === "V") {
                desc.prop("readonly", true).css("pointer-events", "none");
                if (sp.length) sp.prop("readonly", true).css("pointer-events", "none");
            } else {
                desc.prop("readonly", false).css("pointer-events", "auto");
                if (sp.length) sp.prop("readonly", false).css("pointer-events", "auto");
            }
        }

        var projectRejectedRangeLock = new Set();
        var projectRejectedRangeEnable = new Set();
        function EnableDisbaleDATextbox_TD() {
            if (PageFlag != 1 && PageFlag != 2) return;
            if (!$("#btnSave").is(":visible")) return;
            if (!HeaderResult_TD || HeaderResult_TD.length === 0) return;
            var entryStatusMap = {};
            HeaderResult_TD.forEach(function (r) {
                var d = new Date(r.EntryDate);
                var key = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
                entryStatusMap[key] = r.Status;
            });
            $('.taskTxt').prop("readonly", false).removeClass("bg-light");
            //var projectRejectedRangeLock = new Set();
            //var projectRejectedRangeEnable = new Set();
            $('.taskTxt').each(function () {
                var input = $(this);
                var entryDateStr = input.attr('data-entrydate-id');
                if (!entryDateStr) return;
                var d = new Date(entryDateStr);
                var statusObj = getStatusForDate_TD(normalizeDate_TD(d));
                var key = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
                var status = statusObj ? (statusObj.Status || "") : (entryStatusMap[key] || "");
                if (!status) return;
                var statusFlag = (input.attr('data-statusflag-id') || "").toUpperCase();
                var projectId = (input.attr('data-projectid-id') || "").toString().trim();
                if (!projectId) return;
                if (status.toLowerCase() === "rejected") {
                    var fromKey = statusObj && statusObj.FromDate ? normalizeDate_TD(new Date(statusObj.FromDate)).toISOString().substring(0, 10) : key;
                    var toKey = statusObj && statusObj.ToDate ? normalizeDate_TD(new Date(statusObj.ToDate)).toISOString().substring(0, 10) : key;
                    var rangeKey = projectId + "|" + fromKey + "|" + toKey;
                    var atrScan = parseAllowToResubmit_TD(input);
                    //if (statusFlag === "R") {
                    if (statusFlag === "R" || statusFlag === "V") {
                        projectRejectedRangeLock.add(rangeKey);
                    }
                    if (atrScan === true || statusFlag === "J") {
                        projectRejectedRangeEnable.add(rangeKey);
                    }
                }
            });

            $('.taskTxt').each(function () {
                var input = $(this);
                var entryDateStr = input.attr('data-entrydate-id');
                if (!entryDateStr) return;
                var d = new Date(entryDateStr);
                var statusObj = getStatusForDate_TD(normalizeDate_TD(d));
                var key = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
                var status = statusObj ? (statusObj.Status || "") : (entryStatusMap[key] || "");
                if (!status) return;
                var statusLower = status.toLowerCase();
                var statusFlag = (input.attr('data-statusflag-id') || "").toUpperCase();
                var projectId = (input.attr('data-projectid-id') || "").toString().trim();
                var locked = false;

                if (statusLower === "ready for approval" || statusLower === "approved" || statusLower === "submitted") {
                    locked = true;
                } else if (statusLower === "rejected") {
                    var fromKey = statusObj && statusObj.FromDate ? normalizeDate_TD(new Date(statusObj.FromDate)).toISOString().substring(0, 10) : key;
                    var toKey = statusObj && statusObj.ToDate ? normalizeDate_TD(new Date(statusObj.ToDate)).toISOString().substring(0, 10) : key;
                    var rangeKey = projectId + "|" + fromKey + "|" + toKey;
                    //Added by Vishal Mane on 09/04/2026 to disable Approved Timesheet
                    if (statusFlag === 'V') {
                        locked = true;
                    }
                    else
                    //End of Added by Vishal Mane on 09/04/2026 to disable Approved Timesheet
                    if (projectRejectedRangeLock.has(rangeKey)) {
                        locked = true;
                    } else if (projectRejectedRangeEnable.has(rangeKey)) {
                        locked = false;
                    } else {
                        var atr = parseAllowToResubmit_TD(input);
                        if (atr === true) {
                            locked = false;
                        } else if (atr === false) {
                            //locked = true;
                            if (duration == "00:00") {
                                locked = false;
                            } else {
                                locked = true;
                            }
                        } else {
                            locked = (statusFlag !== "J");
                        }
                    }
                } else {
                    if (statusFlag === 'R' || statusFlag === 'V') {
                        locked = true;
                    } else {
                        locked = false;
                    }
                }

                if (locked) {
                    input.prop("readonly", true).addClass("bg-light").css("pointer-events", "none");
                } else {
                    input.prop("readonly", false).removeClass("bg-light").css("pointer-events", "auto");
                }
                syncMobileDARowFromTaskInput_TD(input, locked);
            });
        }
        function GetTimeSheetWeekHeaderDetails_TD() {
            var taskParameters = {
                intEmployeeID: EmployeeID,
                //Commented and added by Vishal Mane on 12/05/2026 to fix Timezone issue                
                //dtFromDate: new Date(StartDate).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),
                dtFromDate: new Date(StartDate).toLocaleDateString("en-US"),
                //dtToDate: new Date(EndDate).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })
                dtToDate: new Date(EndDate).toLocaleDateString("en-US")
                //End of Commented and added by Vishal Mane on 12/05/2026 to fix Timezone issue
            };
            var Result = AJAXCallWithResultMobile("/api/TimesheetEntryNew/GetTimeSheetWeekHeaderDetails", JSON.stringify(taskParameters), false);
            var TotalDaywiseEntry = Result ? Result["TimeSheetWeekHeader1"] : null;
            HeaderResult_TD = TotalDaywiseEntry;
            if (!HeaderResult_TD) HeaderResult_TD = [];
            if (!$.isArray(HeaderResult_TD)) HeaderResult_TD = [HeaderResult_TD];
            TSSubmissionDetails_TD = (Result && Result["TimeSheetWeekHeader2"]) ? Result["TimeSheetWeekHeader2"] : [];
            if (!$.isArray(TSSubmissionDetails_TD)) TSSubmissionDetails_TD = [];
            if (TSSubmissionDetails_TD.length > 0) {
                var allRej = TSSubmissionDetails_TD.some(function (x) { return (x.Status || "").toLowerCase() === "rejected"; });
                var allSub = !TSSubmissionDetails_TD.some(function (x) { return (x.Status || "").toLowerCase() === "not submitted"; });
                if (allRej && allSub) $("#btnSubmitTimesheet_TD").text("Re-Submit");
                else $("#btnSubmitTimesheet_TD").text("Submit");
            } else {
                $("#btnSubmitTimesheet_TD").text("Submit");
            }
            handleTimesheetButtons_TD();
            bindStatusDiv_TD();
        }
        function bindStatusDiv_TD() {
            var container = $("#txtStatus_TD");
            container.html("");
            var html = '<div class="ts-status-wrapper"><div class="row fw-bold border-bottom pb-1 mb-1"><div class="col-4 text-center">Status</div><div class="col-4 text-center">From</div><div class="col-4 text-center">To</div></div>';
            if (TSSubmissionDetails_TD && TSSubmissionDetails_TD.length > 0) {
                TSSubmissionDetails_TD.forEach(function (item) {
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
        function bindStatusDiv_TSModal_TD() {
            var html = '<div class="col-12 text-center"><strong>Timesheet Status Details</strong></div>' +
                '<div class="row fw-bold border-bottom pb-1 mb-1"></div>' +
                '<div class="ts-status-wrapper"><div class="row fw-bold border-bottom pb-1 mb-1">' +
                '<div class="col-4 text-center">Status</div><div class="col-4 text-center">From Date</div><div class="col-4 text-center">To Date</div></div>';
            //if (TSSubmissionDetails_TD.length) {
            //    TSSubmissionDetails_TD.forEach(function (item) {
            //        html += '<div class="row mb-1"><div class="col-4 text-center">' + (item.Status || "") + '</div><div class="col-4 text-center">' + (item.FromDate || "") + '</div><div class="col-4 text-center">' + (item.ToDate || "") + '</div></div>';
            //    });
            //}
            if (TSSubmissionDetails_TD && TSSubmissionDetails_TD.length > 0) {
                TSSubmissionDetails_TD.forEach(item => {
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
            $("#txtStatus_TSModal_TD").html(html);
        }
        function formatDDMMMYYYY_Mobile(date) {
            var d = new Date(date);
            var day = d.getDate();
            var month = d.toLocaleString("en-US", { month: "short" });
            var year = d.getFullYear();
            return day + " " + month + " " + year;
        }
        function validateFlexibleTS_TD() {
            var startInput = $("#txtTSModalStartDate_TD").val();
            var endInput = $("#txtTSModalEndDate_TD").val();
            var bounds = getFlexibleBounds_TD();
            var dtFromDate = normalizeDate_TD(bounds.from);
            var dtToDate = normalizeDate_TD(bounds.to);
            var startDate = normalizeDate_TD(new Date(startInput));
            var endDate = normalizeDate_TD(new Date(endInput));
            //if (!startInput) { showAlert("Please select From Date.", 'alert-danger'); return false; }
            //if (!endInput) { showAlert("Please select To Date.", 'alert-danger'); return false; }
            //if (startDate < dtFromDate || startDate > dtToDate) { showAlert("From Date must fall within the visible week.", 'alert-danger'); return false; }
            //if (endDate < dtFromDate || endDate > dtToDate) { showAlert("To Date must fall within the visible week.", 'alert-danger'); return false; }
            //if (startDate > endDate) { showAlert("From Date must be before To Date.", 'alert-danger'); return false; }

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
        function validateTimesheetSubmission_TD() {
            var startInput = $("#txtTSModalStartDate_TD").val();
            var endInput = $("#txtTSModalEndDate_TD").val();
            if (!startInput || !endInput) {
                showAlert("Please select valid date range.", 'alert-danger');
                return false;
            }
            var startDate = normalizeDate_TD(new Date(startInput));
            var endDate = normalizeDate_TD(new Date(endInput));
            //Added by Vishal Mane on 13/04/2026 to fix Calender date selection issue
            // Restrict timesheet submission to a single month.
            // If selected date range spans across months (e.g., 30 Mar – 05 Apr),
            // block submission and enforce end date within the start date's month.
            let isCrossMonth =
                startDate.getMonth() !== endDate.getMonth() ||
                startDate.getFullYear() !== endDate.getFullYear();
            if (isCrossMonth) {
                let monthEnd = new Date(
                    startDate.getFullYear(),
                    startDate.getMonth() + 1,
                    0
                );
                showAlert("To Date should be less than or equal to " +
                    formatDDMMMYYYY_Mobile(monthEnd), 'alert-danger');
                //alertify.error(
                //    "To Date should be less than or equal to " +
                //    formatDDMMMYYYY(monthEnd)
                //);
                return false;
            }
            //End of Added by Vishal Mane on 13/04/2026 to fix Calender date selection issue
            for (var d = new Date(startDate); d <= endDate; d.setDate(d.getDate() + 1)) {
                var currentDay = normalizeDate_TD(new Date(d));
                var statusObj = getStatusForDate_TD(currentDay);
                if (!statusObj) continue;
                var status = (statusObj.Status || "").toLowerCase();
                if (status === "approved") {
                    //showAlert("The timesheet is already approved for " + statusObj.FromDate + " to " + statusObj.ToDate + ". Adjust the range.", 'alert-danger');
                    showAlert("The timesheet is already approved for the period " + statusObj.FromDate + " to " + statusObj.ToDate + ". Please adjust the selected date range to exclude approved dates and try again.", 'alert-danger');
                    return false;
                }
                if (status === "submitted" || status === "pending") {
                    showAlert("Timesheet is already submitted for the period " + statusObj.FromDate + " to " + statusObj.ToDate + ". Please adjust the selected date range to exclude submitted dates and try again.", 'alert-danger');
                    return false;
                }
                var rejectedPeriods = TSSubmissionDetails_TD.filter(function (x) { return (x.Status || "").toLowerCase() === "rejected"; });
                for (var j = 0; j < rejectedPeriods.length; j++) {
                    var item = rejectedPeriods[j];
                    var from = normalizeDate_TD(new Date(item.FromDate));
                    var to = normalizeDate_TD(new Date(item.ToDate));
                    if (startDate.getTime() === from.getTime() && endDate.getTime() === to.getTime()) break;
                    if (startDate <= to && endDate >= from) {
                        showAlert("Timesheet Re-Submission is allowed only for the exact rejected period (" + item.FromDate + " to " + item.ToDate + "). Please select the complete rejected range and try again.", 'alert-danger');
                        return false;
                    }
                }
            }
            var hasRejectedInRange = false;
            for (var k = 0; k < TSSubmissionDetails_TD.length; k++) {
                var it = TSSubmissionDetails_TD[k];
                if ((it.Status || "").toLowerCase() === "rejected") {
                    var f = normalizeDate_TD(new Date(it.FromDate));
                    var t = normalizeDate_TD(new Date(it.ToDate));
                    if (startDate >= f && endDate <= t) hasRejectedInRange = true;
                }
            }
            if (hasRejectedInRange && !validateRejectedExactMatch_TD(startDate, endDate)) {
                showAlert("Resubmission is allowed only for the exact rejected period.", 'alert-danger');
                return false;
            }
            return true;
        }
        function SubmitTS_OnClick_Confirmation_TD() {
            $("#submitTSModal_TD").modal('show');
            GetTimeSheetWeekHeaderDetails_TD();
            bindStatusDiv_TSModal_TD();
            initFlexibleSubmitModalDatepickers_TD();
            var bounds = getFlexibleBounds_TD();
            var fromFormatted = formatDDMMMYYYY_TD(bounds.from);
            var toFormatted = formatDDMMMYYYY_TD(bounds.to);
            $("#txtTSModalStartDate_TD").val(fromFormatted);
            $("#txtTSModalEndDate_TD").val(toFormatted);
            $("#lblSelectedRange_TD").text(fromFormatted + " - " + toFormatted);
            $("#lblWeekRange").text(fromFormatted + " - " + toFormatted);
            Global_oldStartDate_TD = fromFormatted;
            Global_oldEndDate_TD = toFormatted;
        }
        function ValidateSubmitTS_FlexibleTD() {
            var taskparameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: convertToAPIDate_TD(Global_oldStartDate_TD),
                dtToDate: convertToAPIDate_TD(Global_oldEndDate_TD)
            };
            var data = AJAXCallWithResultMobile("/api/TimesheetEntryNew/ValidateTimesheet", JSON.stringify(taskparameters), false);
            if (data !== "") { showAlert('' + data + '', 'alert-danger'); return 1; }
            return 0;
        }
        function ValidateHolidayLeaveTS_TD() {
            var taskparameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: convertToAPIDate_TD(Global_oldStartDate_TD),
                dtToDate: convertToAPIDate_TD(Global_oldEndDate_TD)
            };
            var data = AJAXCallWithResultMobile("/api/TimesheetEntryNew/ValidateHolidayLeaveTS", JSON.stringify(taskparameters), false);
            if (data !== "") { showAlert('' + data + '', 'alert-danger'); return 1; }
            return 0;
        }
        function SubmitTS_OnClick_FlexibleTD() {
            var ah = ($("#fltActualHours").text() || "").trim();
            if (ah === "00:00" || ah === "" || ah === "0" || ah === "0.00") {
                showAlert('Please fill timesheet before submit.', 'alert-danger');
                return false;
            }
            if (validateFlexibleTS_TD() === false) return false;
            if (validateTimesheetSubmission_TD() === false) return false;
            /*if (ValidateTimesheetEntryAlert(1, convertToAPIDate_TD(Global_oldStartDate_TD), convertToAPIDate_TD(Global_oldEndDate_TD)) === false) return false;*/
            if (ValidateSubmitTS_FlexibleTD() === 1) return false;
            //if (ValidateHolidayLeaveTS_TD() === 1) return false;
            $('#btnSubmitTimesheet_TD').css('pointer-events', 'none');
            var taskparameters = {
                intProxyUserID: 0,
                employeeID: EmployeeID,
                dtFromDate: convertToAPIDate_TD(Global_oldStartDate_TD),
                dtToDate: convertToAPIDate_TD(Global_oldEndDate_TD),
                intTimesheetID: 0,
                StatusCode: "R",
                intMobileView: 1
            };
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
                    showAlert('Timesheet Submitted successfully.', 'alert-success', 'btnSave');
                    $("#submitTSModal_TD").modal('hide');
                    GetTimesheetStatus(EmployeeID);
                    GetExpectedActualHours();
                    $("#btnSubmit").css('display', 'none');
                    $("#btnEdit").css('display', 'none');
                    $('#btnSubmitTimesheet_TD').css('pointer-events', '');
                },
                error: function (err) {
                    $('#btnSubmitTimesheet_TD').css('pointer-events', '');
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }
        //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo

         //Added By Dipali V On 22nd May 2023 For Valiate timesheet approver

        function ValidateSubmitTS() {
            // 
            var Flag = 0;
            var taskparameters = {
                //employeeID: EmployeeID,
                //dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                //dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),

                employeeID: EmployeeID,
                dtFromDate: StartDate,
                dtToDate: EndDate
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
            //debugger;
             //Added By Dipali V On 22nd May 2023 For Valiate timesheet approver
            if (ValidateSubmitTS() == 1) {
                return false;
            }

         //End of Added By Dipali V On 22nd May 2023 For Valiate timesheet approver
            $('#btnSubmit').css('pointer-events', 'none');
            
            taskparameters = {
                intProxyUserID: 0,
                employeeID: EmployeeID,
                dtFromDate: StartDate,
                dtToDate: EndDate,
                intTimesheetID: 0,
                StatusCode: "R",
            }


            //alert(intTimesheetID);
            $.ajax({
                //Added and Modified by Vishal Mane on 20/11/2025to fix crash on edit mode.
                //url: strUrl + '/api/MyTimesheet/GenerateTimesheet',
                url: encodeURI(strUrlMobile) + '/api/TimesheetEntryNew/GenerateTimesheet',
                //End of Added and Modified by Vishal Mane on 20/11/2025to fix crash on edit mode.
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
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
                    var arrData = data.split('$');
                    //setTimeout(function () {
                    //    showAlert('Timesheet Submitted successfully.', 'alert-success', 'btnSave');
                    //}, 2000);
                    window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtEndDate=" + EndDate + "";
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
        function Edit_Onclick() {
            //  debugger;
            $("#btnEdit").css("display", "none");
            $("#btnSave").css("display", "inline-block");

            if ($("#DivMvTimesheet .timesheetentrycard").length === 0) {
                IsDefault = 1;
                TaskIDList = "";
                plotDailyTaskList();
            }

            $('.timenoinput').css('pointer-events', 'auto');


            $('.SPCls').css('pointer-events', 'auto');
            $('.DescCls').css('pointer-events', 'auto');
            //Commented By Dipali V On 5th March 2021 For Approved Task Should not able to edit
            //Added By Dipali V on 25th March 2019 For Filed disbaled Issue
            //$('.timenoinput').removeAttr("readonly");
            //End of Commented By Dipali V On 5th March 2021 For Approved Task Should not able to edit

            // $('.timenoinput').focus();
            //  $('.SPCls').focus();

            $('.SPCls').removeAttr("readonly");
            //End of Added By Dipali V on 25th March 2019 For Filed disbaled Issue
            if (typeof EnableDisbaleDATextbox_TD === 'function') { EnableDisbaleDATextbox_TD(); }
        }

        function isNumber(evt, val, obj) {
            // debugger;
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
        function isNumberSP(evt, val, obj) {
            // debugger;
            var legth = val.length;
            var objVal = obj.value;

            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }

            return true;
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
        var SelectProjectID = "";
        function RejectPopup(btn, TaskID, TaskName, ProjectID) {
            //debugger;
            SelectProjectID = ProjectID;
            $("#rejecttaskmodal").modal('show');
            $("#txtRejectionComment").val("");
            $("#lblEmployeeName").css('display', 'none');
            //Commented & Added By Dipali V On 5th March 2021 For Task Name Should display Correct
            //$(#divTaskName").text(unescape(TaskName));
            $(".divTaskName").text(unescape(TaskName));
            //End By Dipali
            $("#lblRejectTaskEmployeeName").css('display', 'block');
            var TaskCompleteChecked = 0;
            if (jQuery(btn).closest('tr').find('[type=checkbox]').is(":checked")) { TaskCompleteChecked = 1; };
            document.getElementById("btnRejectTimesheet").setAttribute("onClick", "ApproveRejectTask(" + TaskID + ",'J'," + TaskCompleteChecked + ");");
            $(".clsTaskName").css('display', 'block');
            $("#divTaskName").css('display', 'block');
            //Added By Usha Pandit On 03.03.2021 For checked flag uncheck on popup click
            $("#rejecttaskmodalcheckbox").prop('checked', false);
            //End Of Added By Usha Pandit On 03.03.2021 For checked flag uncheck on popup click
            //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
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
            setTSOverrideNote();
            //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
        }
        function ApprovePopup(btn, TaskID, TaskName) {
            //debugger;
            $("#approvetaskbtnmodal").modal('show');
            $("#txtApprovalComment").val("");
            $("#divTaskBlock").css("display", "block");
            //Commented & Added By Dipali V On 5th March 2021 For Task Name Should display Correct
            //$(#divTaskName").text(unescape(TaskName));
            $(".divTaskName").text(unescape(TaskName));
            //End By Dipali
            var TaskCompleteChecked = 0;
            if (jQuery(btn).closest('tr').find('[type=checkbox]').is(":checked")) { TaskCompleteChecked = 1; };
            document.getElementById("btnApproveTimesheet").setAttribute("onClick", "ApproveRejectTask(" + TaskID + ",'V'," + TaskCompleteChecked + ");");
            $(".clsTaskName").css('display', 'block');
            $("#divTaskName1").css('display', 'block');
            //ApproveRejectTask(TaskID,'V')
        }
        function ApproveTimesheet() {
            //debugger;
            $("#approvetaskbtnmodal").modal('show');
            $("#txtApprovalComment").val("Approved");
            $("#divTaskBlock").css("display", "none");
            document.getElementById("btnApproveTimesheet").setAttribute("onClick", "ApproveAllTimesheet();");
            $(".clsTaskName").css('display', 'none');
            $("#divTaskName1").css('display', 'none');
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
                async: false,
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
                strTimesheetIDs: '<%= Request.QueryString("TimesheetId")%>',
                intApproverID: '<%=Session("intUserID")%>',
                FromWhere: 'Reject',
                ProjectID: SelectProjectID
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
            //debugger;
            SelectProjectID = "";
            $("#rejecttaskmodal").modal('show');
            $("#txtRejectionComment").val("");
            $("#lblEmployeeName").css('display', 'block');
            $("#lblRejectTaskEmployeeName").css('display', 'none');
            document.getElementById("btnRejectTimesheet").setAttribute("onClick", "RejectAllTimesheet();");
            $(".clsTaskName").css('display', 'none');
            $("#divTaskName").css('display', 'none');
            //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
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
            setTSOverrideNote();
            //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
            
        }
        function ApproveRejectTask(TaskID, strStatus, TaskCompleteChecked) {
            //debugger;            
            var strComment = "";
            var bitAllowToResubmit = 0;
            var IsValid = 0;
            if (strStatus == "V") {
                strComment = $("#txtApprovalComment").val();
                //Added By Dipali V 9th Jan 2019 For Comment as Approved For Approved the timesheet
                if (strComment == "") {

                    strComment = $("#txtApprovalComment").val("");
                    IsValid = 1;

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
                    IsValid = 1;
                }
            }
            
            if (IsValid == 0) {
                var taskParameters = {
                    intTimesheetID: '<%= Request.QueryString("TimesheetID")%>',
                    Status: strStatus,
                    intEmployeeID: EmployeeID,
                    strComment: strComment,
                    intTaskID: TaskID,
                    intAllowToResubmit: bitAllowToResubmit,
                    TaskCompleteChecked: TaskCompleteChecked,
                    //2021
                    FromWhere: ''
                    //2021
                }
                $.ajax({
                    url: strUrl + '/api/TimesheetApprovalDetail/SaveApproveRejectTask',
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
                        //alert("Success")

                        if (strStatus == "V") {
                            $("#approvetaskbtnmodal").modal('hide');
                            showAlert('Task Approved successfully.', 'alert-success', 'btnSave');
                        }
                        else {
                            $("#rejecttaskmodal").modal('hide');
                            showAlert('Task Rejected successfully.', 'alert-success', 'btnSave');
                        }
                        //ReloadData(EmployeeID);
                        TimesheetID = '<%= Request.QueryString("TimesheetID")%>';
                        GetExpectedActualHours();
                        GetTimesheetStatus(EmployeeID);
                        plotDailyTaskList();
                    },
                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
                })
            }
            else {
                showAlert("Please Enter Comment.", "alert-danger");
            }
        }
        function ApproveAllTimesheet() {
            //debugger;
            var strComment = "";
            strComment = $("#txtApprovalComment").val();
            //strComment = $("#txtApprovalComment").val();
            //Added By Dipali V 9th Jan 2019 For Comment as Approved For Approved the timesheet
            var IsValid = 0;
            if (strComment == "") {

                strComment = $("#txtApprovalComment").val("Approved");
                IsValid = 1;
            } else {
                strComment = $("#txtApprovalComment").val();

            }
            //End of Added By Dipali V 9th Jan 2019 For Comment as Approved For Approved the timesheet
            if (IsValid == 0) {
                var taskParameters = {
                    intTimesheetID: '<%= Request.QueryString("TimesheetID")%>',
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
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (taskParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                        }
                    },
                    success: function (data) {
                        //debugger;
                        //UpdateCompleteTasks();
                        if (data == 1) {
                             //window.open('../Email/SendEmail.aspx?MessageID=435&VerifiedBy=' + EmployeeID + '&ResourceID=' + '<%= Request.QueryString("intEmployeeID")%>' + '&FromDate=' + '<%= Request.QueryString("FromDate")%>' + '&ToDate=' + '<%= Request.QueryString("ToDate")%>' + '&TimesheetID=' + '<%= Request.QueryString("intTimesheetId")%>' + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=580');
                         }
                         showAlert('Timesheet Approved successfully.', 'alert-success', 'btnSave');
                         $("#approvetaskbtnmodal").modal('hide');
                         //ReloadData(EmployeeID);
                         TimesheetID = '<%= Request.QueryString("TimesheetID")%>';
                        GetExpectedActualHours();
                        GetTimesheetStatus(EmployeeID);
                        plotDailyTaskList();
                    },
                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
                })
            }
            else {
                showAlert("Please Enter Comment.", "alert-danger");
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
                    intTimesheetID: '<%= Request.QueryString("TimesheetID")%>',
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
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (taskParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                        }
                    },
                    success: function (data) {
                        //debugger;
                        if (bitAllowToResubmit == 0) { /*UpdateCompleteTasks();*/ }
                      <%--   if (data == 1) {
                             //window.open('../Email/SendEmail.aspx?MessageID=436&VerifiedBy=' + EmployeeID + '&ResourceID=' + '<%= Request.QueryString("intEmployeeID")%>' + '&FromDate=' + '<%= Request.QueryString("FromDate")%>' + '&ToDate=' + '<%= Request.QueryString("ToDate")%>' + '&TimesheetID=' + '<%= Request.QueryString("intTimesheetId")%>' + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=580');

                         }--%>
                         showAlert('Timesheet Rejected successfully.', 'alert-success', 'btnSave');
                         $("#rejecttaskmodal").modal('hide');
                         //ReloadData(EmployeeID);
                         TimesheetID = '<%= Request.QueryString("TimesheetID")%>';
                        GetExpectedActualHours();
                        GetTimesheetStatus(EmployeeID);
                        plotDailyTaskList();
                    },
                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }
        }

        function limitText(limitField, limitNum) {
            // debugger;
            //alert(limitField.value.length);
            var length;
            if (limitField.value.length == limitNum) {
                showAlert('You Can Enter Only 2000 Characters', 'alert-danger');
            } else {

                limitField.value = limitField.value.substring(0, limitNum);

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
        function Back_Onclick() { 
            //Commented And Added By Usha Pandit On 15.03.2021 For Resubmit Note display issue
            <%--if (PageFlag == 3) {
                window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&intTimesheetID=" + '<%= Request.QueryString("TimesheetID")%>' + "&PageFlag=3&intEmployeeID=" + '<%= Request.QueryString("intEmployeeID")%>' + "";
            }
            else if (PageFlag == 2) {
                window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtEndDate=" + EndDate + "&MyTimesheetStatus=" + "<%= Request.QueryString("MyTimesheetStatus")%>" + "";
            }
            else {
                window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtEndDate=" + EndDate + "";
            }--%>
            if (PageFlag == 3) {
                window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&intTimesheetID=" + '<%= Request.QueryString("TimesheetID")%>' + "&PageFlag=3&intEmployeeID=" + '<%= Request.QueryString("intEmployeeID")%>' + "&ActualHours=" + "<%= Request.QueryString("ActualHours")%>"+ "&EmployeeID=" + "<%= Session("intUserID") %>";
            }
            else if (PageFlag == 2) {
                window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtEndDate=" + EndDate + "&MyTimesheetStatus=" + "<%= Request.QueryString("MyTimesheetStatus")%>" + "&ActualHours=" + "<%= Request.QueryString("ActualHours")%>"+ "&EmployeeID=" + "<%= Session("intUserID") %>";
            }
            else {
                window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?&PageFlag=" + PageFlag + "&dtFromDate=" + StartDate + "&dtEndDate=" + EndDate + "&ActualHours=" + "<%= Request.QueryString("ActualHours")%>"+ "&EmployeeID=" + "<%= Session("intUserID") %>";
            }
            //End Of Added By Usha Pandit On 15.03.2021 For Resubmit Note display issue
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

        //Added by Vishal Mane on 18/11/2025 for 4 and 8 Hrs Timesheet Alert Validation for Expleo Customization
        function ValidateTimesheetEntryAlert(flag, StartDate, EndDate) {
            //debugger
            var Data = {
                intEmployeeID: EmployeeID,
                dtFromDate: StartDate,
                dtToDate: EndDate
            }
            var param = JSON.stringify(Data)
            var Result = AJAXCallWithResultMobile("/api/TimesheetEntryNew/GetValidateTimesheetEntryAlert", param, false);
            var msg = '';
            if (Result.length) {
                for (i = 0; i < Result.length; i++) {
                    msg = msg + Result[i].EntryDate + ' (' + Result[i].LeaveHours + ' hours)' + ' '
                }
                if (flag == 1) {
                    showAlert('You have filled less than the required working hours for ' + msg + ',if you were on leave, then please submit the leave.', 'alert-danger');
                    return false;
                }
                if (flag == 0) {
                    $("#txtLeaveValidationMessage").text('You have filled less than the required working hours for ' + msg + ',if you were on leave, then please submit the leave.');
                    $("#fourandEightHoursValidation").modal('show');
                }
            }
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

        function ValidateNumericValue(inputElement) {
            //debugger
            var inputValue = inputElement.value;
            var numericValue = inputValue.replace(/[^0-9.]/g, '');
            numericValue = numericValue.replace(/\.(?=.*\.)/g, '');

            if (numericValue !== '' && !isNaN(numericValue) && parseFloat(numericValue) >= 0) {
                inputElement.value = numericValue;
            } else {
                inputElement.value = '';
            }
        }
        //Added by  Vishal Mane on 18/11/2025 for 4 and 8 Hrs Timesheet Alert Validation for Expleo Customization

    </script>

</body>
</html>
