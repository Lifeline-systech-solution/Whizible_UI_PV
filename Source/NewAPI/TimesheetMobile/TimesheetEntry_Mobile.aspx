<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TimesheetEntry_Mobile.aspx.vb" Inherits="PbNIT.TimesheetEntry_Mobile" %>

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
<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />

    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">--%>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/skins/_all-skins.min.css?v=2">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=2.5">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2.24">


   
</head>
     <style type="text/css">
        /*body{ overflow: hidden; }*/
        .statusNotSubmitted-text {
            color: #7f05c2;
        }
        .mobview_weektablehead tr th.activeday {
            background: #2e52a3;
            color: #fff;
            position: relative;
            overflow: hidden;
            padding-left: 20px;
            padding-right: 20px;
        }

        .mobview_weektablehead tr th span.YM_label {
            display: none;
        }

        .mobview_weektablehead tr th.activeday span.YM_label {
            z-index: 9;
            display: block;
        }


        .weektable-wrapper table tr th {
            position: relative;
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

         .mobcustmodal .modal-content .modal-header .close {
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

          
  
         #CloseableAlert .close {
            float: right;
            border: none;
        }

          a {
            color: #337ab7;
            text-decoration: none!important;
        }

        @media screen and (max-width: 480px) {
            .Mv_actualwork_hrs.hidden-desktop {
                font-size: 11.6px;
            }
        }
        @media screen and (max-width: 767px) {
            .Mv_actualwork_hrs.hidden-desktop {
                /* font-size: 16px; */
                padding-top: 13px;
            }
        }

        .mobview_weektablehead .col-xs-10 {
            padding: 0;
        }

        .tbl-header .table {
            border-left: none;
            border-right: none;
            border-bottom: hidden!important;
        }

        @media screen and (max-width: 767px) {
            .tbl-header.mobview_weektablehead table {
                margin-bottom: 0;
                border-bottom: hidden;
            }
        }

        #Mmenu_togglebtn {
            height: 100%;
            position: relative;
            -webkit-transform: rotate(0deg);
            -moz-transform: rotate(0deg);
            -o-transform: rotate(0deg);
            transform: rotate(0deg);
            -webkit-transition: .5s ease-in-out;
            -moz-transition: .5s ease-in-out;
            -o-transition: .5s ease-in-out;
            transition: .5s ease-in-out;
            cursor: pointer;
            top: 5px;
        }

        .nav .navbar-nav {
            display: inline-block!important;
            height: 200px;
            float: left;
            margin-left: 9px;
        }

        @media screen and (max-width: 767px) {
            .Mv_mobmenu .navbar-custom-menu > .navbar-nav > li:nth-child(1) {
                display: inline-block;
                vertical-align: middle;
                margin-right: 16px;
              
                margin-top: 3px;
            }
        }

        #Mvfilterpanel .form-group {
            margin-top: 5px;
        }

         .autoclosablemsg{ display:none;}

        .popover-body {
            width:260px;
        }
         #alertMsg {
            font-size: 13px;
            width: 295px;
        }

        .form-select {
            border-radius: .375rem;
        }
        #FilterResultMsg {
           
    font-size: 13px;
        }

         .form-select option {
            font-size: 12px;
            padding: 5px;
            width:100px;
        }
        .ts_headerbot .btnlistinline {
            display: flex;
            flex-wrap: nowrap;
            justify-content: flex-end;
            gap: 2px;
            margin: 0;
            padding: 0;
        }
        .ts_headerbot .btnlistinline li {
            list-style: none;
            display: inline-flex;
        }
        /*Added by Vishal Mane on 08/04/2026 for compact date controls in submitTSModal_Mobile*/
        #submitTSModal_Mobile #txtTSModalStartDate_MV,
        #submitTSModal_Mobile #txtTSModalEndDate_MV {
            font-size: 11px;
            line-height: 1.35;
        }
        #submitTSModal_Mobile .input-group-text {
            padding: 4px 10px;
        }
        /*End of Added by Vishal Mane on 08/04/2026*/
    </style>
</head>

<body class="skin-blue-light sidebar-mini dashmain fixed" id="bodyTSEntryMobile">


    <div class="wrapper">
        <!-- Main Header -->
        <header class="main-header">

            <!-- Header Navbar -->
            <nav class="navbar navbar-static-top" role="navigation">

                <div class="mainheadingtop">Timesheet > Entry</div>

                <div class="filter pull-right">
                    <button data-bs-toggle="collapse" data-bs-target="#Mvfilterpanel" class="collapsed Mvfilterpanel" aria-expanded="false"><i class="fas fa-filter"></i></button>


                </div>
            </nav>
        </header>
        <!--bootstrap_Alertify-->
        <%--Commented & added By Dipali V On 18th May 2023 For UI Changes Issue--%>
       <%-- <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" hidden="hidden">--%>
         <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg">
            <button type="button" class="close" onclick="CloseShowAlert()" aria-label="Close">&times;</button>
            <p id="alertMsg"></p>
        </div>
      <%--  End of Commented & added By Dipali V On 18th May 2023 For UI Changes Issue--%>
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
                                 <Span><P style="color:red">Note : Project selection is mandatory.</P></span>
                                 </div>
                            <div class="form-group">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee " & Session("intUserID"),,, "class='form-control form-select' placeholder='Select Project' onChange='javascript:FilterProjectOnChange(this.value)'",,, ) %>
                            </div>
                            <div class="form-group">
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboTaskCategory", "usp_Whizible2_sel_TaskTypes 1",,, "class='form-control form-select selectpicker' onchange='' multiple='multiple' placeholder='Select Task Category'",,, ) %>--%>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboTaskCategory", "usp_Whizible2_sel_TaskTypes 1",,, "class='form-control form-select' onchange='' placeholder='Select Task Category'",,, ) %>
                            </div>
                            <div class="form-group">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboTaskTypes", "Select 0,'Select Task Type'",,, "class='form-control form-select' placeholder='Select Task Type'",,, ) %>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboTaskTypes", "Select 0,'Select Task Type'",,, "class='form-control form-select selectpicker' multiple='multiple' placeholder='Select Task Type'",,, ) %>--%>
                            </div>
                            <div class="form-group">
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboTaskStatus", "usp_Whizible2_Sel_TaskStatus 1",,, "class='form-control form-select selectpicker' multiple='multiple' placeholder='Select Status'",,, ) %>--%>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboTaskStatus", "usp_Whizible2_Sel_TaskStatus 1",,, "class='form-control form-select' placeholder='Select Status'",,, ) %>
                            </div>
                            <div class="form-group">
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboTaskPriority", "usp_Whizible2_Sel_tbl_IB_Priorities 1",,, "class='form-control form-select selectpicker' multiple='multiple' placeholder='Select Priority'",,, ) %>--%>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboTaskPriority", "usp_Whizible2_Sel_tbl_IB_Priorities 1",,, "class='form-control form-select'  placeholder='Select Priority'",,, ) %>
                            </div>
                            <div class="clearfix"></div>

                            <div class="fp_button text-center">
                                <a href="#" class="btn borderbtn cancelbtn" id="btnCloseFilterPopup" data-bs-toggle="collapse" data-bs-target="#Mvfilterpanel">Cancel</a>
                                <a class="btn borderbtn active" onclick="GetFilterResultCount()" data-bs-toggle="modal">Apply</a>
                            </div>

                        </div>
                    </div>
                    <!--mobile view filter anel end-->
                    <div class="Mv_weekdates hidden-desktop">
                        <!--Weeklydate-->
                        <div class="tbl-header mobview_weektablehead">
                            <div class="row" id="divWeekRow">
                                <div class="col-xs-1"><i class="fas fa-caret-left left"></i></div>
                                <div class="col-xs-10 weektable-wrapper">
                                    <table class="table table table-stripped" id="tblWeek">
                                        <tbody id="tbodyWeek">
                                            <tr>
                                               
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-xs-1"><i class="fas fa-caret-right right"></i></div>
                            </div>
                        </div>
                    </div>
                    <!--Weeklydateend-->

                    <div class="timesheetrow container-fluid bgwhite ts_headerbot">
                        <div class="row">
                          
                            <div class="col-md-4 col-sm-6 col-xs-7" style="width: 65%;">
                                <div class="Mv_actualwork_hrs hidden-desktop">Actual work : <span id="fltActualHours">00:00</span></div>
                            </div>

                              <div class="col-md-8 col-sm-6 col-xs-5 pull-right" style="float: right;width: 35%;">
                                <ul class="pull-right btnlistinline">
                                    <li><a onclick="PlotFilterTaskList();" id="txtFilterTaskList" class="btn ml-1 nobtnstyle-xs" data-bs-toggle="modal" data-placement="top" title="Add Project" data-bs-target="#Mv_createproject"><i class="fas fa-plus"></i></a></li>
                                    <li><a onclick="ViewTimesheet()" id="ViewTimesheet" class="btn ml-1 nobtnstyle-xs"><i class="fas fa-eye"></i></a></li>
                                    <li><a class="btn savebtn ml-1 nobtnstyle-xs" id="btnSave" onclick="Save_OnClick()"><i class="fas fa-save"></i></a></li>
                                    <%--Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
                                    <li><a class="btn ml-1 nobtnstyle-xs" id="btnSubmitTSMobile" onclick="SubmitTS_OnClick_Confirmation_Mobile();" title="Submit timesheet"><i class="fas fa-check"></i></a></li>
                                    <%--End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
                                </ul>
                            </div>
                            <%--Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
                            <div class="col-xs-12" style="padding:6px 12px 0;font-size:11px;">
                                <div class="d-flex justify-content-between align-items-center" style="cursor:pointer;" data-bs-toggle="collapse" data-bs-target="#mvTsStatusCollapse" aria-expanded="false">
                                    <span class="fw-bold">Timesheet status</span><i class="fas fa-chevron-down"></i>
                                </div>
                                <div class="collapse" id="mvTsStatusCollapse"><div id="txtStatus_MV" class="pt-1"></div></div>
                            </div>
                            <%--End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
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
                    <div id="Mv_createproject" class="modal fade mobcustmodal" role="dialog">
                        <div class="modal-dialog">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                                    <h4 class="modal-title" style="margin-left: 52px;">Select Project / Task / Sub-Task</h4>
                                </div>

                                <div class="modal-body">

                                    <!--select project Task-->

                                    <div class="Mvcreateproject">

                                        <div class="Mv_formbody">
                                            <div class="form-group">
                                                <label class="cobtrol-label">Project:</label>
                                               
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboFilteredProject", "Select 'Select Project' ",,, "class='form-control form-select' onChange='javascript:ProjectFilterDrop_OnChange(this.value);'",,, ) %>
                                            </div>

                                            <div class="form-group">
                                                <label class="cobtrol-label">Task:</label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboTasks", "Select 'Select Task'",,, "class='form-control form-select' onChange='javascript:SubTasksFilterDrop_OnChange();' placeholder='Select Task '",,, ) %>
                                            
                                            </div>
                                            <div class="form-group">
                                                <label class="cobtrol-label">Sub Task:</label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboSubTasks", "Select 'Select Sub-Task Type'",,, "class='form-control form-select' placeholder='Select Sub-Task '",,, ) %>
                                            </div>
                                           


                                            <br>

                                            <div class="text-center">
                                                <button class="btn borderbtn cancelbtn" data-bs-dismiss="modal">Cancel</button>
                                                <button class="btn btnbluefill" onclick="FilterTaskFromList()">Select</button>
                                                <div class="clearfix"></div>
                                            </div>

                                        </div>
                                        <div class="clearfix"></div>
                                    </div>

                                    <!--Select project task-->
                                    <div class="clearfix"></div>
                                </div>
                            </div>

                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <!--End projecttask modal for mobileview only-->

                    <!--modalstart-->
                    <div id="entryfiltermodalinfo" class="modal fade custmodal" role="dialog">
                        <div class="modal-dialog modal-lg">
                            <!-- Modal content-->
                            <div class="modal-content" style="width:380px;">
                                <div class="modal-header">
                                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Advance Filter Result</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="FilterResultMsg"></p>

                                </div>
                                <div class="modal-footer">
                                    <button class="btn borderbtn pull-left" id="AdvanFilterNo" data-bs-dismiss="modal" style="    margin-right: 204px;">No</button>
                                    <button class="btn btnyellow" id="AdvanFilterYes" data-bs-toggle="modal" onclick="ProjectFilterDrop_OnChange(0)" data-bs-target="#Mv_createproject" data-original-title="" data-bs-dismiss="modal" title="">Yes</button>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
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
                    <!--End entry screen mobile view-->
                </div>
            </section>
            <!-- /.content -->
        </div>

         <%--Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
        <div id="submitTSModal_Mobile" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-bs-focus="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Submit timesheet</h4>
                    </div>
                    <div class="modal-body">
                        <div id="txtStatus_TSModal_MV" class="mb-2" style="font-size: 11px; max-height: 120px; overflow: auto;"></div>
                        <div class="mt-2 text-muted" style="font-size:11px; line-height:1.35;">Select the date range for your timesheet submission. Dates are restricted to the current week.</div>
                        <div class="mt-2 text-muted" style="font-size: 11px;"><strong>Week Range: </strong><span id="lblWeekRange"></span></div>
                        <div class="row mb-2 mt-2 align-items-center">
                            <div class="col-4">
                                <label class="form-label mb-0" style="font-size:11px; line-height:1.35;">From Date</label>
                            </div>
                            <div class="col-8">
                                <div class="input-group">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtTSModalStartDate_MV", "txtTSModalStartDate_MV", "form-control", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
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
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtTSModalEndDate_MV", "txtTSModalEndDate_MV", "form-control", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                                    <span class="input-group-text">
                                        <i class="fas fa-calendar-alt"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="mt-2 text-muted" style="font-size: 11px;"><strong>Selected Range: </strong><span id="lblSelectedRange_MV"></span></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="btnSubmitTimesheet_MV" class="btn btnyellow" onclick="SubmitTS_OnClick_FlexibleTS_Mobile();">Submit</button>
                        <button type="button" class="btn borderbtn" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
        <%--End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo--%>
    </div>
  
<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>


    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js?v=1"></script>
    <script src="../../General/CommonValidations.js"></script>
    <!-- custome_mobile_only js -->
    <script src="../../../Whizible2.0-new/dist/js/custom_mobile.js?v=1"></script>

    <script type="text/javascript">
        //$(".Mvfilterpanel").click(function () {
        $(".Mvfilterpanel").on("click", function () {
            $('html, body').animate({
                scrollTop: $("#Mvfilterpanel").offset()
            });

        });
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var EmployeeID;
        var UserName;
        EmployeeID = '<%= Session("intUserID") %>';
        UserName = '<%= Session("strUserName") %>';
        var StartDate = "";
        var EndDate = "";
        var displayDate = "";
        var SelectedDate = "";
        var IsDefault = 0;
        var intMaxEntry = 24;
        var TodayDate = GetTodayDate();
        var PageFlag = 0;
        $(document).ready(function () {
            //debugger;
            //alert();
            PageFlag = '<%= Request.QueryString("PageFlag")%>';

            if (PageFlag == 1) {
                StartDate = '<%= Request.QueryString("dtFromDate")%>';
                EndDate ='<%= Request.QueryString("dtToDate")%>'
            }
            BindProjectFilterFropDown();
            ReloadData(EmployeeID);
           //Added By Dipali V On 6th Jan 2020 For Filter Issues
            AfterPlot();
           //End of Added By Dipali V On 6th Jan 2020 For Filter Issues
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip('update');            
        });

        //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
        $('#txtTSModalStartDate_MV, #txtTSModalEndDate_MV').datepicker({
            autoclose: true,
            changeMonth: true,
            dateFormat: 'dd M yy'
        });

        $("#txtTSModalStartDate_MV").on("change", function () {
            var previous = Global_oldStartDate_MV;
            if (validateFlexibleTS_Mobile()) {
                Global_oldStartDate_MV = $("#txtTSModalStartDate_MV").val();
                Global_oldEndDate_MV = $("#txtTSModalEndDate_MV").val();
                $("#lblSelectedRange_MV").text(Global_oldStartDate_MV + " - " + Global_oldEndDate_MV);
            } else {
                $("#txtTSModalStartDate_MV").val(previous);
            }
        });

        $("#txtTSModalEndDate_MV").on("change", function () {
            var previous = Global_oldEndDate_MV;
            if (validateFlexibleTS_Mobile()) {
                Global_oldStartDate_MV = $("#txtTSModalStartDate_MV").val();
                Global_oldEndDate_MV = $("#txtTSModalEndDate_MV").val();
                $("#lblSelectedRange_MV").text(Global_oldStartDate_MV + " - " + Global_oldEndDate_MV);
            } else {
                $("#txtTSModalEndDate_MV").val(previous);
            }
        });
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

        var ProjectIDList = "";
        var TaskTypeIDList = "";
        var TaskCategoryList = "";
        var TaskStatusList = "";
        var TaskPriorityList = "";
        var TaskIDList = ""
        var SubtaskTypeList = "";
        //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
        var TSSubmissionDetails = [];
        var HeaderResult = null;
        var Global_oldStartDate_MV = "";
        var Global_oldEndDate_MV = "";
        var MobileWeekTotalFormatted = "00:00";
        var TimesheetStatus = "";
        //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
        //Added By Dipali V On 20th March 2019 For Display Date
        var SelectedMonthName = "";
        var SelectedYearName = "";
        var AllmonthNames = "";
        //End of Added By Dipali V On 20th March 2019 For Display Date
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

            AllmonthNames = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"
            ];
            //Added By Dipali V On 20th March 2019 For Display Date
            SelectedMonthName = AllmonthNames[startDate.getMonth()];
            SelectedYearName = startDate.getFullYear();
            //End of Added By Dipali V On 20th March 2019 For Display Date


            ReloadData(EmployeeID)
        }
        function NextWeek() {
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
            // const d = new Date();

            var sdate = "" + sm + "/" + sd + "/" + sy + "";
            var edate = "" + em + "/" + ed + "/" + ey + "";
            StartDate = sdate;
            EndDate = edate;


            AllmonthNames = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"
            ];
            //Added By Dipali V On 20th March 2019 For Display Date
            SelectedMonthName = AllmonthNames[startDate.getMonth()];
            SelectedYearName = startDate.getFullYear();
            //End of Added By Dipali V On 20th March 2019 For Display Date
            ReloadData(EmployeeID)
        }
        //$('#Mvfilterpanel .selectpicker').each(function () {
        //    if ($(".dropdown-menu").find("li")) {
        //        $(this).find('option:first').remove();
        //    }
        //});
        $('.selectpicker').change(function () {

           
            var str = $('.filter-option').text().replace(/Select Task Type:/g, '');

            //alert($(this).html());
            $('option[value=0]').removeClass('selected');
            //$('.selectpicker').find('option:selected').prop('disabled', true);

            if ($(".dropdown-menu").find("li")) {
                //$(".dropdown-menu li:first").remove();
                $(".dropdown-menu").find("li:first").removeClass("selected");
                //$('.selectpicker').find('option:selected').prop('disabled', true);
                //    }
            }
            //if ($('option[value=0]').is(':selected')) {multiselect
            //   $('ul.dropdown-menu > li[rel=0]').removeClass('selected');
            //}


        });
        //$("#cboTaskTypes").change(function () {
       
        //    var task = $(".bootstrap-select button").attr("data-id");
        //    alert(task);
        //    var str = $('.filter-option').text().replace(/Select Task Category:/g, '');
        //      $('.filter-option').text(str);
        //    $(".dropdown-menu li:first").remove();
        //});
        function BindProjectFilterFropDown() {
            var taskParameters = {
                intEmployeeID: EmployeeID,
                strFilterProjectList: ""
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/GetProjectDropdownValuesForFilter',
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
                   
                    var selHTML = "";
                     //Commented By Dipali V On 8th Jan 2021 for Avoid Multiple Placeholder
                    //selHTML += "<option title='Select Project' value='0' selected>Select Project</option>";
                     //End of Commented By Dipali V On 8th Jan 2021 for Avoid Multiple Placeholder
                    
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
                }
            });

        }
        function FilterProjectOnChange(obj) {
            
            var taskParameters = {
                FilterProjectID: obj,
                intEmployeeID: EmployeeID
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/GetTaskTypeFromProject_MV',
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
                   
                    var selHTML = "";
                    selHTML += "<option title='Select Task Type' value='0' selected>Select Task Type</option>";
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        var TaskTypeID = d.TaskTypeID;
                        var TaskType = d.TaskType;
                        selHTML += "<option title='" + TaskType + "' value='" + TaskTypeID + "'>" + TaskType + "</option>";
                    }
                    $("#cboTaskTypes").html(selHTML);

                    $(".selectpicker").selectpicker('refresh');
                },
                error: function (err) {
                    console.log(err);
                }
            });
            var taskParameters = {
                intEmployeeID: EmployeeID,
                strFilterProjectList: obj,
            }

            $.ajax({
                url: strUrl + '/api/Timesheet/GetProjectDropdownValuesForFilter',
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
                   
                    var selHTML = "";
                    //Commented By Dipali V On 29th Jan 2021 For Duplicated Placeholder
                    //selHTML += "<option title='Select Project' value='0' selected>Select Project</option>";
                   //End of Commented By Dipali V On 29th Jan 2021 For Duplicated Placeholder
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        var ProjectID = d.ProjectID;
                        var ProjectName = d.ProjectName;
                        selHTML += "<option title='" + ProjectName + "' value='" + ProjectID + "'>" + ProjectName + "</option>";
                    }
                    $("#cboFilteredProject").html(selHTML);
                    $("#cboFilteredProject").val($("#cboProject").val());
                    document.getElementById('cboFilteredProject').disabled = true;

                    $(".selectpicker").selectpicker('refresh');

                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        function ProjectFilterDrop_OnChange(ProjectID) {
            
            if (ProjectID == 0) {
                ProjectID = $("#cboFilteredProject").val();
            }
            var taskParameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: StartDate,
                dtToDate: EndDate,
                intIsDefault: 0,
                strWhichTask: "",
                strTaskIDList: "",
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
                FilterProjectID: ProjectID,
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/GetTaskListFromAdvanceSearch',
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
                   // debugger;
                    var selHTML = "";
                    selHTML += "<option title='Select Task' value='0' selected>Select Task</option>";
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        var TaskID = d.TaskID;
                        var TaskName = d.TaskName;
                        selHTML += "<option title='" + TaskName + "' value='" + TaskID + "'>" + TaskName + "</option>";

                    }
                    $("#cboTasks").html(selHTML);

                    //$(".selectpicker").selectpicker('refresh');

                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        function PlotFilterTaskList() {
            $("#cboTasks").val("");
            $("#cboSubTasks").val("");
            var taskParameters = {
                intEmployeeID: EmployeeID,
                strFilterProjectList: ProjectIDList,
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/GetProjectDropdownValuesForFilter',
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
                    
                    var selHTML = "";
                     //Commented By Dipali V On 29th Jan 2021 For Duplicated Placeholder
                    //selHTML += "<option title='Select Project' value='0' selected>Select Project</option>";
                   //End of Commented By Dipali V On 29th Jan 2021 For Duplicated Placeholder
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        var ProjectID = d.ProjectID;
                        var ProjectName = d.ProjectName;
                        selHTML += "<option title='" + ProjectName + "' value='" + ProjectID + "'>" + ProjectName + "</option>";
                    }
                    $("#cboFilteredProject").html(selHTML);
                    ProjectFilterDrop_OnChange($("#cboFilteredProject").val());
                    SubTasksFilterDrop_OnChange();
                    $(".selectpicker").selectpicker('refresh');

                },
                error: function (err) {
                    console.log(err);
                }
            });

        }
        function StoryPoint_OnChange(objTextBox) {
            
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
                           // objTextBox.value = "0";
                            Isvalid = 1;
                          //  return;
                             return false;
                        }
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });

            }
            if (Isvalid == 1) {
                return false;
            } else {
                return true;
            }
        }

        var DATextbox;
        var objDuChRow;
        var totalEnteredHours = 0;
         var hoursChangeValidation = false;
        function Hours_OnChange(objTextBox) {           
            var Isvalid = 0;
            var versement_each = 0;
            var fn_argument = arguments.length;            
            if (objTextBox.Value != "") {
                //debugger;
                var ctrlid = objTextBox.id;
                ctrlid = ctrlid.replace("Duration_", "").split("_");                
                $("#DivMvTimesheet.HdnTaskwisetotal_" + ctrlid[1]).each(function () {
                    var total= $(this).attr('value');
                });
                //$("#DivMvTimesheet table .HdnTaskwisetotalDeciaml").each(function () {
                //   //debugger;
                //    versement_each += parseFloat(this.value) || 0;

                //});
                var dblColSum;
                dblColSum = 0;
                var objHoursComplete = document.getElementById(objTextBox.id);
                objHoursComplete.value = ConvertToDecimal(objHoursComplete.value);
                objHoursComplete.value = objHoursComplete.value.replace(/:/g, ".");
                var precision = objHoursComplete.value.split(".")[1];
                //if (precision.length == 1) {
                //    precision = '0' + precision;
                //}
                 var ObjOldValue = objHoursComplete.defaultValue.replace(/:/g, ".")
                if (precision > 60) {
                    showAlert('Please enter minutes in two decimal and less than 60.', 'alert-danger','btnSave');
                    Isvalid = 1;
                    //return false;

                }

                if (precision == 60) {
                    objHoursComplete.value = (objHoursComplete.value.split(".")[0] - 0) + 1;
                    Hours_OnChange(objTextBox);
                    return false;
                }

               
               
                DATextbox = objTextBox.id;

                if (objHoursComplete.value.indexOf(".") == -1) {
                    showAlert('Please enter duration in hh:mm format.', 'alert-danger');
                    Isvalid = 1;
                    objHoursComplete.value = objHoursComplete.value.replace(".", ":");
                    return false;
                }

               // debugger;
                if ((objHoursComplete.value - 0) >= 0 && (objHoursComplete.value - 0) <= intMaxEntry) {

                } else {
                    //showAlert('The Range of Actual Working Hours is [0.00 to ' + intMaxEntry.toFixed(2) + ']', 'alert-danger');
                     showAlert('You can not enter more than ' + intMaxEntry.toFixed(2) + ' hours a day.', 'alert-danger');
                    Isvalid = 1;
                    //Added By Chetan M on 17 March 2021 to clear the value after alert
                    objTextBox.value = ObjOldValue;
                    //End of Added By Chetan M on 17 March 2021 to clear the value after alert
                    objTextBox.value = objHoursComplete.value.replace(".", ":");
                    objTextBox.focus();
                    return false;

                }


                //if (versement_each <= intMaxEntry) {

                //} else {
                //    //showAlert('The Range of Actual Working Hours is [0.00 to ' + intMaxEntry.toFixed(2) + ']', 'alert-danger');
                //    showAlert('You can not enter more than ' + intMaxEntry.toFixed(2) + ' hours a day.', 'alert-danger');
                //    Isvalid = 1;
                //    //Added By Chetan M on 17 March 2021 to clear the value after alert
                //    objTextBox.value = ObjOldValue;
                //    //End of Added By Chetan M on 17 March 2021 to clear the value after alert
                //    objTextBox.value = objHoursComplete.value.replace(".", ":");
                //    //objTextBox.focus();
                //    return false;

                //}

                objHoursComplete.value = (objHoursComplete.value - 0).toFixed(2);
                var ObjNewvalue = objHoursComplete.value;
                var onjNewIndex = objHoursComplete.value.split(".")[0];
                if (onjNewIndex.length == 1) {
                    ObjNewvalue = '0' + ObjNewvalue;
                }
                objHoursComplete.value = ObjNewvalue;
               

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
                     <%--   if ((((objTextBox.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) - 0).toFixed(0) != ((objTextBox.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)) {
                            showAlert('Please enter hours complete in multiples of ' + <%=CommonFunctions.Application.MinHoursForDAEntry%>, 'alert-danger');
                            Isvalid = 1;
                            //return false;
                           
                        }--%>
                    }
                }
               totalEnteredHours = objHoursComplete.value;
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
                        IsTaskComplete: IsTaskCompleteCheck,
                         Flag:"Responsive"
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
                            totalEnteredHours = 0;
                            hoursChangeValidation = false;;
                            if (data != "") {
                                if (data.indexOf('$$') >= 0) {
                                    var oldValue = objHoursComplete.value;
                                    var arrValue = data.split('$$');
                                    showAlert(arrValue[1], 'alert-danger');
                                     //Added By Dipali V On 22nd March 2021 For Getting Alert if Exceed Work 
                          
                                    hoursChangeValidation = true;
                                    //End of Added By Dipali V On 22nd March 2021 For Getting Alert if Exceed Work 
                          
                                    // objHoursComplete.value = oldValue - arrValue[0];
                                    if (arrValue[0] < 0) {
                                        objHoursComplete.value = '0.00';
                                    }
                                    if (((oldValue - 0) - (arrValue[0] - 0)) <= 0)
                                        objHoursComplete.value = '0.00';
                                    Isvalid = 1;
                                    //return false;

                                }
                                else if (data.indexOf('@@') >= 0) {
                                    objHoursComplete.value = "";
                                    var arrValue = data.split('@@');
                                    showAlert(arrValue[1], 'alert-danger');
                                     //Added By Dipali V On 22nd March 2021 For Getting Alert if Exceed Work 
                          
                                    hoursChangeValidation = true;
                                     //End of Added By Dipali V On 22nd March 2021 For Getting Alert if Exceed Work 
                          
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
                                         //Added By Dipali V On 22nd March 2021 For Getting Alert if Exceed Work 
                                        hoursChangeValidation = true;
                                         //End of Added By Dipali V On 22nd March 2021 For Getting Alert if Exceed Work 
                          
                                        //End of Added & Commented By Dipali V On 15th march 2021 For Refresh Issue

                                        // return false;

                                    }
                                    else if (arrValue[0] == 0) {
                                        if (fn_argument == 1) {
                                            if (document.getElementById(objDuChRow).value == 0) {
                                                if (Isvalid == 0 && objHoursComplete.value != "00.00") {
                                                    $("#ConfirmMessagemodalinfo").modal('show');
                                                    $("#ConfirmationMsg").html(arrValue[1]);
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                   
                                    if (ObjOldValue == ObjNewvalue) { }
                                    else {
                                        showAlert(data, 'alert-danger','btnSave');
                                        //Added & Commented By Dipali V On 15th march 2021 For Refresh Issue
                                        //objHoursComplete.value = "00.00";
                                        objHoursComplete.value = ObjOldValue;
                                         //Added By Dipali V On 22nd March 2021 For Getting Alert if Exceed Work 
                                        hoursChangeValidation = true;
                                       //End of Added By Dipali V On 22nd March 2021 For Getting Alert if Exceed Work 
                          
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
                if (Isvalid == 1) {
                   
                    objHoursComplete.value = objHoursComplete.value.replace(".", ":");
                  
                    return false;
                }
                else {
                    objHoursComplete.value = objHoursComplete.value.replace(".", ":");
                 
                    return true
                }
            }
        }

        function SubTasksFilterDrop_OnChange() {
            var ProjectID = $("#cboFilteredProject option:selected").val();
            var TaskID = $("#cboTasks option:selected").val();
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                    }
                },
                success: function (data) {
                    var selHTML = "";
                     //Commented & Added By Dipali V On 19th Dec 2021 For Duplicate Placeholder
                    selHTML += "<option title='Select Sub-Task Type' value='0' selected>Select Sub-Task Type</option>";
                   //End of Commented & Added By Dipali V On 19th Dec 2021 For Duplicate Placeholder
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        var SubTaskTypeID = d.SubTaskTypeID;
                        var SubTaskType = d.SubTaskType;
                        selHTML += "<option title='" + SubTaskType + "' value='" + SubTaskTypeID + "'>" + SubTaskType + "</option>";
                    }
                    $("#cboSubTasks").html(selHTML);
                    // $(".selectpicker").selectpicker('refresh');

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
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
            
            if (ProxyResourceID == 0)
                ProxyResourceID = EmployeeID;
            else
                EmployeeID = ProxyResourceID;
            var taskParameters = {
                intEmployeeID: ProxyResourceID,
                dtFromDate: StartDate,
                dtToDate: EndDate,

            }
            StartLoader("#bodyTSEntryMobile");
            $.ajax({
                url: strUrl + '/api/Timesheet/GetMobileHeaderList',
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
                    
                    var Timesheet = data;

                    plotHeaderSection(Timesheet);
                    SelectedDay(displayDate);
                    // name.substring(0, 3);
                    //Added By Dipali V On 20th March 2019 For Display Date
                    $(".YM_label").text(SelectedMonthName.substring(0, 3) + "-" + SelectedYearName)
                    //End of Added By Dipali V On 20th March 2019 For Display Date
                    StopAjaxLoader("#bodyTSEntryMobile");
                },
                error: function (err) {
                    console.log(err);
                }
            })
        }
        function GetFilterResultCount() {
            
            ProjectIDList = "";
            ProjectIDList = $("#cboProject option:selected").val();

            if (ProjectIDList == "0") {
                $('#entryfiltermodalinfo').modal('hide');
                showAlert("Please select atleast one Project.", "alert-danger");

                return false;
            }
            else {
                $('#entryfiltermodalinfo').modal('show');
            }

            TaskCategoryList = "";
            $("#cboTaskCategory").find("option:selected").each(function () {
                
                if ($(this).val() != 0) {
                    if (TaskCategoryList == "") {
                        TaskCategoryList += $(this).val().toString();
                    }
                    else {
                        TaskCategoryList += "," + $(this).val().toString();
                    }

                }

            });

            TaskTypeIDList = "";
            $("#cboTaskTypes").find("option:selected").each(function () {

                if ($(this).val() != 0) {
                    if (TaskTypeIDList == "") {
                        TaskTypeIDList += $(this).val().toString();
                    }
                    else {
                        TaskTypeIDList += "," + $(this).val().toString();
                    }
                }
            });

            TaskStatusList = "";
            $("#cboTaskStatus").find("option:selected").each(function () {

                if ($(this).val() != 0) {
                    if (TaskStatusList == "") {
                        TaskStatusList += $(this).val().toString();
                    }
                    else {
                        TaskStatusList += "," + $(this).val().toString();
                    }
                }
            });

            TaskPriorityList = "";
            $("#cboTaskPriority").find("option:selected").each(function () {
                

                if ($(this).val() != 0) {
                    if (TaskPriorityList == "") {
                        TaskPriorityList += $(this).val().toString();
                    }
                    else {
                        TaskPriorityList += "," + $(this).val().toString();
                    }
                }


            });

            var taskParameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: StartDate,
                dtToDate: EndDate,
                intIsDefault: IsDefault,
                strWhichTask: "",
                strTaskIDList: "",
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
            }
            $.ajax({
                url: strUrl + '/api/Timesheet/GetFilterResultCount',
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
                    $("#FilterResultMsg").html("Your filter result returned " + data + " records. Do you want to view them?");
                    if (data == 0) {
                        $("#AdvanFilterNo").attr("disabled", "disabled");
                        $("#AdvanFilterYes").attr("disabled", "disabled")
                    } else {
                        $("#AdvanFilterNo").removeAttr("disabled", "");
                        $("#AdvanFilterYes").removeAttr("disabled", "")
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });


        }
        //Added by Vishal Mane on 09/04/2026 to enable/ disable textbox 
        var selectedProjectList = [];
        //End of Added by Vishal Mane on 09/04/2026 to enable/ disable textbox
        function FilterTaskFromList() {
            //Added by Vishal Mane on 09/04/2026 to enable/ disable textbox 
            selectedProjectList = [];
            //End of Added by Vishal Mane on 09/04/2026 to enable/ disable textbox
            TaskIDList = "";
            SubtaskTypeList = "";
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
            //Added by Vishal Mane on 09/04/2026 to enable/ disable textbox 
            $("#cboFilteredProject").find("option:selected").each(function () {
                if ($(this).val() != 0) {
                    selectedProjectList.push($(this).val());
                }
            });
            //End of Added by Vishal Mane on 09/04/2026 to enable/ disable textbox

            //var SubtaskTypeList = $("#SubtaskTypeList option:selected").val();
            $("#cboSubTasks").find("option:selected").each(function () {

                if ($(this).val() != 0) {
                    if (SubtaskTypeList == "") {
                        SubtaskTypeList += $(this).val().toString();
                    }
                    else {
                        SubtaskTypeList += "," + $(this).val().toString();
                    }
                }
            });

            if (TaskIDList == "0" || TaskIDList == "") {
                showAlert("Please select atleast one task.", "alert-danger");
                return false;
            }
            // if (SubtaskTypeList == "0" || SubtaskTypeList =="") {
            //    showAlert("Please select atleast one task.", "alert-danger");
            //    return false;
            //}

            IsDefault = 1;
            plotDailyTaskList();
            $("#Mv_createproject").modal('hide');
            $("#Mvfilterpanel").removeClass("in");
            $(".filter button").attr('aria-expanded', 'false');


        }

        function plotHeaderSection(headerList) {
            
            $("#divWeekRow").html("");
            var strHTML = "";
            var Flag = 0;
            strHTML += '<div class="col-xs-1" id="prev" onclick="PreviousWeek()"><i class="fas fa-caret-left left"></i></div>';
            strHTML += '<div class="col-xs-10 weektable-wrapper">';
            strHTML += '<table class="table table table-stripped">';
            strHTML += '<tbody id="tbodyWeek">';

            strHTML += "<tr>";
            for (var i = 0; i < headerList.length; i++) {
               
                var header = headerList[i];
                var EntryDate = header.EntryDate;
                var DayName = header.DayName;
                var IsWorking = header.IsWorking;
                var Day = header.Day;
                var MonthName = header.MonthName;
                var Year = header.Year;
                var DayNameFirst = header.DayNameFirst;
                var CurrentDate = header.CurrentDate;
                var IsTodayDate = header.IsTodayDate;
                if (i == 0) { StartDate = CurrentDate };
                if (i == headerList.length - 1) { EndDate = CurrentDate };
                if (IsTodayDate == 1) {
                    displayDate = CurrentDate;
                }
               
                if (IsTodayDate == 1) {
                    if (IsWorking == 1 || IsWorking == 3 || IsWorking == 5) {
                        strHTML += '<th style="color: red;" id="th_' + CurrentDate + '" class="activeday datepicker" data-bs-toggle="tooltip" title="' + Day + " " + MonthName + " " + Year + '" onclick=SelectedDay("' + CurrentDate + '",this,"'+ MonthName +'")>' + DayNameFirst + '<span class="YM_label"  id="Selected_' + CurrentDate + '"></span><span>' + Day + '</span></th>';
                    }
                    else {
                        strHTML += '<th id="th_' + CurrentDate + '" class="activeday datepicker" data-bs-toggle="tooltip" title="' + Day + " " + MonthName + " " + Year + '" onclick=SelectedDay("' + CurrentDate + '",this,"'+ MonthName +'")>' + DayNameFirst + '<span class="YM_label" id="Selected_' + CurrentDate + '"></span><span>' + Day + '</span></th>';
                    }

                }
                else {
                    if (IsWorking == 1 || IsWorking == 3 || IsWorking == 5) {
                        strHTML += '<th style="color: red;" id="th_' + CurrentDate + '" class="datepicker" data-bs-toggle="tooltip" title="' + Day + " " + MonthName + " " + Year + '" onclick=SelectedDay("' + CurrentDate + '",this,"'+ MonthName +'")>' + DayNameFirst + '<span class="YM_label" id="Selected_' + CurrentDate + '"></span><span>' + Day + '</span></th>';
                    }
                    else {
                        strHTML += '<th id="th_' + CurrentDate + '" class="datepicker" data-bs-toggle="tooltip" title="' + Day + " " + MonthName + " " + Year + '" onclick=SelectedDay("' + CurrentDate + '",this,"'+ MonthName +'")>' + DayNameFirst + '<span class="YM_label" id="Selected_' + CurrentDate + '"></span><span>' + Day + '</span></th>';
                    }
                }
            }
            //if (Flag == 0) {
            //    displayDate = StartDate;
            //}
            strHTML += '</tr>';
            strHTML += '</tbody>';
            strHTML += '</table>';
            strHTML += '</div>';
            strHTML += '<div class="col-xs-1" id="next" onclick="NextWeek()"><i class="fas fa-caret-right right"></i></div>';
            $("#divWeekRow").html(strHTML);
            //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
            GetTimeSheetWeekHeaderDetailsMobile();
            //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
        }


        function SelectedDay(CurrentDate, element,MonthName) {

            if (element != undefined) {
                $(".mobview_weektablehead tr th").each(function () {
                    
                    $(this).removeClass("activeday");
                })
                //element.addClass("activeday");
                element.classList.add("activeday");
            }
            
            SelectedDate = CurrentDate;
            //Added By Dipali V On 20th March 2019 For Display Date
            var SelectednewDate = new Date(CurrentDate);
            //var sd = SelectedDate.getDate();
            //var sm = SelectedDate.getMonth() + 1;
            //var sy = SelectedDate.getFullYear();
            AllmonthNames = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"
            ];
            SelectedMonthName = AllmonthNames[SelectednewDate.getMonth()];
            SelectedYearName = SelectednewDate.getFullYear();
            /// Added By reshma Chavan on 25 June 2021 For Showing Correct month name label
            if (MonthName != undefined) {
                SelectedMonthName = MonthName;              
                $(".YM_label").text(SelectedMonthName.substring(0, 3) + "-" + SelectedYearName)
            } else {
                $(".YM_label").text(SelectedMonthName.substring(0, 3) + "-" + SelectedYearName);
            }
            ///End of  Added By reshma Chavan on 25 June 2021 For Showing Correct month name label
           // $("#Selected_07/01/2021").text(SelectedMonthName + "-" + SelectedYearName)
            //End of Added By Dipali V On 20th March 2019 For Display Date
            IsDefault = 0;
            SubtaskTypeList = "";
            TaskIDList = "";
            plotDailyTaskList();
            GetExpectedActualHours();
            //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
            handleTimesheetButtonsMobile(CurrentDate);
            //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
        }

        function GetExpectedActualHours() {
            //debugger
            //alert(1);
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
                   
                    //PlotWeekDays(data);
                    for (var i = 0; i < data.length; i++) {
                        var weekDays = data[i];
                        var AllTotal = weekDays.AllTotal;
                        var ExpectedHours = weekDays.ExpectedHours;
                        var CurrentDate = weekDays.CurrentDate;
                        var Total = weekDays.Total;
                        if (AllTotal != '0.00') {
                            IsTaskList = 1;
                        }
                        else {
                            IsTaskList = 0;
                        }
                        if (SelectedDate == CurrentDate) {
                            //Added by Chetan M on 12 March 2021 for conversion of work hour 7.60 to 8
                            var precision = Total.split(".")[1];
                            if (precision == 60) {
                                Total = (Total.split(".")[0] - 0) + 1;
                            }
                            //End of Added by Chetan M on 12 March 2021 for conversion of work hour 7.60 to 8
                            $("#fltActualHours").html(ConvertToDecimal(Total) + " Hr");
                        }
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function plotDailyTaskList() {
           
            var taskParameters = {
                intMobileView: 1,
                intEmployeeID: EmployeeID,
                dtFromDate: SelectedDate,
                dtToDate: "",
                intIsDefault: IsDefault,
                strWhichTask: "",
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
                SubTaskTypeList: SubtaskTypeList
            }
            StartLoader("#bodyTSEntryMobile");
            $.ajax({
                url: strUrl + '/api/Timesheet/GetTaskListDayView',
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
                    var timesheetLists = data.timesheetLists;
                    PlotList(timesheetLists)
                    //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                    if (typeof EnableDisbaleDATextbox === 'function') { EnableDisbaleDATextbox(); }
                    //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                    StopAjaxLoader("#bodyTSEntryMobile");
                    $("[data-bs-toggle=popover]").click(function (i, obj) {

                        $(this).popover({
                            html: true,
                            content: function () {
                                var id = $(this).attr('id')
                                return $('#popover-content-' + id).html();

                            }
                        });
                    });

                    //alert(this.id);
                  

                    $(document).on('click', '.close', function () {
                     
                        var clickedId = $(this).attr('id');
                        //alert(clickedId);
                        // $('.face').hide();
                        $('.popover').removeClass("in");
                        $('.popover').hide();
                        //  var id = this.id.split("close-")[1];
                        ////$('#popover-content-' + id).parent().hide();
                        // $("#popover-content-" + id).hide();
                    })

                    //$(this).parent().hide();

                },
                error: function (err) {
                    console.log(err);

                }
            })
        }
        var TimesheetID = 0;
        var IsTaskList = 0;
        function PlotList(TaskList) {
            
            $("#DivMvTimesheet").html("");
            //IsTaskList = 0;
            var strHTML = "";
            var ActualDurationDayWise = 0.0;
            if (TaskList.length == 0) {
                IsTaskList = 0;

            }
            else {
                //IsTaskList = 1;
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
                    var RestrictByMinHours = task.RestrictByMinHours;
                    var allowResubmitAttr = ' data-allowtoresubmit-id="' + (AllowToResubmit !== undefined && AllowToResubmit !== null ? AllowToResubmit : '') + '" ';
                    //Added By Dipali V on 6th Sep 2024
                    var ResourceAllocationPercentage = task.ResourceAllocationPercentage;
                    var IsGlobalProject = task.IsGlobalProject;
                        //Added By Dipali V On 6th Sep 2021
                    //TaskActualWork
                    //alert(RestrictByMinHours);
                    //
                    //alert(task.Duration);
                    if (task.ActualWork != 0) {
                        IsTaskList = 1;
                    }


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
                        strHTML += '<span class="mvnotelisticon"><i data-bs-toggle="collapse" data-bs-target="#mventryrdescriptionbox_' + TaskID + '_' + SubTaskTypeID + '" aria-expanded="false" class="far fa-list-alt"></i></span>';
                    }


                    strHTML += '<div class="dropdown pull-right ml-1">';
                    strHTML += '<img class="pull-right infopopup" src="../../../Whizible2.0-new/dist/img/exclaim.svg" width="13px"  data-bs-toggle="popover" data-container="body" data-placement="bottom" type="button" data-html="true"  id="' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"> ';
                    strHTML += '<div id="popover-content-' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" class="dropdown-menu timeinfopopup" >';
                    //strHTML += '<div class="arrow-left"></div>';
                    strHTML += '<div class="projecttaskinfo_tooltipbox">';
                    strHTML += '<button type="button" class="close" data-bs-toggle="collapse" aria-expanded="false" >';
                    strHTML += '<img width="20px" src="../../../Whizible2.0-new/dist/img/close-gray.svg" class="close" id="close-' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></button>';
                    strHTML += '<div class="PTItooltipbox_hading">';
                    strHTML += '' + ProjectName + '';
                    strHTML += '<br />';
                    //if (SubTaskType != "") {
                    //    strHTML += '<span class="taskname">' + TaskName + '/' + SubTaskType + '</span>';
                    //}
                    //else {
                       strHTML += '<span class="taskname">' + TaskName + '</span>';
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

                        strHTML += '<span class="more">' + TaskName + '</span>';
                    }
                    strHTML += '</div>';
                    if (SubTaskType != "") {
                        strHTML += ' <div class="subtasklist">';
                        if (StatusFlag == 'J') {
                            strHTML += '<span style="color: red;" class="more">' + SubTaskType + '<span>';
                        }
                        else {
                            strHTML += '<span class="more">' + SubTaskType + '<span>';
                        }
                        strHTML += '</div>';
                    }

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
                   // debugger;
                    //Added By Dipali V On 10th March 2021 For Checking if task Complete then should not allow to fill DA
                    if (IsTaskComplete == "1") {
                        //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                        //strHTML += '<input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  maxlength="5" class="timenoinput taskTxt collapsed" type="text" value="' + Duration + '" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name="" data-entrydate-id="' + SelectedDate + '" data-statusflag-id="' + StatusFlag + '" data-projectid-id="' + ProjectID + '"  data-bs-toggle="collapse" data-bs-target="#' + TaskID + '" aria-expanded="false" autocomplete="off" readonly>';
                        strHTML += '<input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  maxlength="5" class="timenoinput taskTxt collapsed" type="text" value="' + Duration + '" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name="" data-entrydate-id="' + SelectedDate + '" data-statusflag-id="' + StatusFlag + '" data-projectid-id="' + ProjectID + '" ' + allowResubmitAttr + ' data-bs-toggle="collapse" data-bs-target="#mventryrdescriptionbox_' + TaskID + '" aria-expanded="false" autocomplete="off">';
                        //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                    } else {
                        if (StatusFlag == 'R' || StatusFlag == 'V') {
                            //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                            //strHTML += '<input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  maxlength="5" class="timenoinput taskTxt collapsed" type="text" value="' + Duration + '" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name="" data-entrydate-id="' + SelectedDate + '" data-statusflag-id="' + StatusFlag + '" data-projectid-id="' + ProjectID + '"  data-bs-toggle="collapse" data-bs-target="#' + TaskID + '" aria-expanded="false" autocomplete="off" readonly>';
                            strHTML += '<input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"  maxlength="5" class="timenoinput taskTxt collapsed" type="text" value="' + Duration + '" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name="" data-entrydate-id="' + SelectedDate + '" data-statusflag-id="' + StatusFlag + '" data-projectid-id="' + ProjectID + '" ' + allowResubmitAttr + ' data-bs-toggle="collapse" data-bs-target="#mventryrdescriptionbox_' + TaskID + '" aria-expanded="false" autocomplete="off">';
                            //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                        }
                        else {
                            //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                            strHTML += '<input id="Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" OnBlur=Hours_OnChange(this);  maxlength="5" class="timenoinput taskTxt collapsed" type="text" value="' + Duration + '" onkeypress="return isNumber(event,this.value,this)" placeholder="00:00" name="" data-entrydate-id="' + SelectedDate + '" data-statusflag-id="' + StatusFlag + '" data-projectid-id="' + ProjectID + '" ' + allowResubmitAttr + ' data-bs-toggle="collapse" data-bs-target="#mventryrdescriptionbox_' + TaskID + '_' + SubTaskTypeID + '" autocomplete="off" aria-expanded="false">';
                            //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                        }
                    }
                    

                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="0" name="">';
                    strHTML += '<input type="hidden" name="hdnTaskDataDaily" id="hdnTaskDataDaily" value="' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" />';
                    strHTML += '<input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + DAID + '" name="">';
                    strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                     strHTML += '<input class="HdnTaskwisetotal_' + TaskID + '" type="hidden" value="' + Duration + '" name="">';
                    strHTML += '<input class="HdnTaskwisetotalDeciaml" type="hidden" value="' + converttodeciamlfromhrs(Duration) + '" name="" id="DurationNew_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '">';

                    strHTML += '</div>';
                    strHTML += '<span class="selecttimeno">';
                    if (IsAgileProject == 1) {
                        if (IsTaskComplete == "1") {
                            //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                            //strHTML += '<input type="text" value="' + StoryPoint + '" placeholder="Story Points" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" name=""  data-bs-toggle="collapse" onkeypress="return isNumberSP(event,this.value,this)" data-bs-target="#" aria-expanded="false" readonly>';
                            strHTML += '<input type="text" value="' + StoryPoint + '" placeholder="Story Points" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" name=""  data-bs-toggle="collapse" onkeypress="return isNumberSP(event,this.value,this)" data-bs-target="#mventryrdescriptionbox_' + TaskID + '" aria-expanded="false">';
                            //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                        }
                        else {
                            if (StatusFlag == 'R' || StatusFlag == 'V') {
                                //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                                //strHTML += '<input type="text" value="' + StoryPoint + '" placeholder="Story Points" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" name=""  data-bs-toggle="collapse" onkeypress="return isNumberSP(event,this.value,this)" data-bs-target="#" aria-expanded="false" readonly>';
                                strHTML += '<input type="text" value="' + StoryPoint + '" placeholder="Story Points" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" name=""  data-bs-toggle="collapse" onkeypress="return isNumberSP(event,this.value,this)" data-bs-target="#mventryrdescriptionbox_' + TaskID + '" aria-expanded="false">';
                                //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                            }
                            else {
                                strHTML += '<input type="text" value="' + StoryPoint + '" placeholder="Story Points" OnBlur=StoryPoint_OnChange(this); id="StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" name=""  data-bs-toggle="collapse" onkeypress="return isNumberSP(event,this.value,this)" data-bs-target="#mventryrdescriptionbox_' + TaskID + '_' + SubTaskTypeID + '" aria-expanded="false" autocomplete="off">';
                            }
                        }
                    }

                    strHTML += '</span ></span > ';
                    strHTML += '<div class="clearfix"></div>';
                    strHTML += '</div>';
                    strHTML += '</td>';
                    strHTML += '</tr>';
                    strHTML += '<tr>';
                    strHTML += '<td colspan="2">';
                    strHTML += '<div id="mventryrdescriptionbox_' + TaskID + '_' + SubTaskTypeID + '" class="notepopupbox collapse">';
                    strHTML += '<p>';
                    strHTML += 'Task Description';
                    strHTML += '<span class="pull-right"><i data-bs-toggle="collapse" data-bs-target="#mventryrdescriptionbox_' + TaskID + '_' + SubTaskTypeID + '" aria-expanded="false" class="fas fa-times ml-1"></i></span>';
                    strHTML += '</p>';
                    if (StatusFlag == 'R' || StatusFlag == 'V') {
                        strHTML += '<textarea class="form-control" maxlength="2000" id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" onkeypress=limitText(this,2000) readonly>' + Description + '</textarea>';
                    }
                    else {
                        strHTML += '<textarea class="form-control" maxlength="2000" id="Description_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" onkeypress=limitText(this,2000)>' + Description + '</textarea>';
                    }

                    strHTML += '</div>';
                    strHTML += '</td>';
                    strHTML += '</tr>';
                    strHTML += '</tbody>';
                    strHTML += '</table>';
                    strHTML += '</div>';

                    $("#DivMvTimesheet").html(strHTML);

                    var showChar = 30;  // How many characters are shown by default
                    var ellipsestext = "...";
                    var moretext = "Show more >";
                    var lesstext = "< Show less";


                    $('.more').each(function () {
                        var content = $(this).html();

                        if (content.length > showChar) {

                            var c = content.substr(0, showChar);
                            var h = content.substr(showChar, content.length - showChar);

                            var html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="#" class="morelink">' + moretext + '</a></span>';

                            $(this).html(html);
                        }

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
                }
                //$("#fltActualHours").html(ActualDurationDayWise.toFixed(2) + " Hr");
            }
        }

        $('body').on('click', function (e) {
            $('[data-toggle="dropdown"]').each(function (e) {
                // hide any open popovers when the anywhere else in the body is clicked
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.dropdown .dropdown-menu').has(e.target).length === 0) {
                    $(".dropdown-menu").removeClass('show');
                }
            });
        });
        function Save_OnClick() {
            //debugger
            var isValid = 0;
            var versement_each = 0;
            var intMaxEntry = 24;
            var daParams = [];
            totalEnteredHours = 0;
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
                
                if (objIsTaskComplete != null)
                    IsTaskCompleteCheck = objIsTaskComplete.value;

                if (Hours_OnChange(objDuration, 1) == false) {
                    isValid = 1;

                };
                objWorkCompleted = document.getElementById('WorkComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objResourceLevelTaskCompletion = document.getElementById('ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                objStoryPoint = document.getElementById('StoryPoint_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                //debugger;
                var storypoint = 0;
                if (objStoryPoint != null) {
                    if (StoryPoint_OnChange(objStoryPoint, 1) == false) { isValid = 1;};
                    storypoint = objStoryPoint.value;
                    if (storypoint != 0) {
                        if (objDuration.value == "00:00" && $('#DivMvTimesheet .timenoinput').is('[readonly]') == false) {
                            showAlert('Please Enter Daily Activity', 'alert-danger');
                            //ReloadData(EmployeeID);
                            //objDuration.focus();
                             //Added By Dipali V On 22nd March 2021 For Getting Alert if Exceed Work 
  
                            hoursChangeValidation = false;
                               //End of Added By Dipali V On 22nd March 2021 For Getting Alert if Exceed Work 
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
                //var Flag2 =
                //if (objDuration.value != objDuration.defaultValue.replace(/:/g, ".")
                //    || (objDescription != null ? objDescription.value != objDescription.defaultValue : true)
                //    || (objStoryPoint != null ? objStoryPoint.value != objStoryPoint.defaultValue : false)
                //)
                if (FlagDuration == true || FlagDescription == true || FlagStoryPoint == true) {
                    //Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                    var curStartDate = '';
                    var curEndDate = '';
                    if ('<%= Request.QueryString("dtFromDate")%>' == "") {
                        curStartDate = StartDate;
                    }
                    else {
                        curStartDate = '<%= Request.QueryString("dtFromDate")%>';
                    }
                    if ('<%= Request.QueryString("dtToDate")%>' == "") {
                        curEndDate = EndDate;
                    }
                    else {
                        curEndDate = '<%= Request.QueryString("dtToDate")%>';
                    }
                    //debugger
                    //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
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
                        dtFromDate: curStartDate,
                        dtToDate: curEndDate,
                        //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                    });
                }
            }
            console.log(daParams);
            //Added By Dipali V On 20th Feb 2021 For Check Is Any DA Filled 
            var IsAnyDAfilled = $("#fltActualHours").text();
            //End of Added By Dipali V On 20th Feb 2021 For Check Is Any DA Filled
             //Added by Dipali V On 22nd May 2023 
            $("#DivMvTimesheet table .HdnTaskwisetotalDeciaml").each(function () {
                ControlID = this.id;
                ControlID = ControlID.replace('DurationNew', 'Duration');
                versement_each += parseFloat($("#" + ControlID).val()) || 0;
                //versement_each += parseFloat(this.value) || 0;
            });


            if (versement_each <= intMaxEntry) {

            } else {
                //showAlert('The Range of Actual Working Hours is [0.00 to ' + intMaxEntry.toFixed(2) + ']', 'alert-danger');
                setTimeout(function () {
                    showAlert('You can not enter more than ' + intMaxEntry.toFixed(2) + ' hours a day.', 'alert-danger');
                }, 1000);
                Isvalid = 1;
                hoursChangeValidation = true;

            }
             //End of Added by Dipali V On 22nd May 2023 

            if (daParams.length == 0) {
                //Added By Dipali V On 20th Feb 2021 For Check Is Any DA Filled
                if (IsAnyDAfilled == "00:00 Hr" && $('#DivMvTimesheet .timenoinput').is('[readonly]') == false) {
                    if (hoursChangeValidation == false) {
                        //End of Added By Dipali V On 20th Feb 2021 For Check Is Any DA Filled
                        showAlert('Please fill daily activity', 'alert-danger');
                         //hoursChangeValidation = false;
                    }
                    //objDuration.focus();
                }
                isValid = 1;
            }
            if (hoursChangeValidation == true) {
                isValid = 1;
            }
            hoursChangeValidation = false;
           // var Parameter = { '': daParams }
            if (isValid == 0) {
                StartLoader("#bodyTSEntryMobile");
                $.ajax({
                    url: strUrl + '/api/Timesheet/SaveDailyActivity',
                    type: "POST",
                    //Commented and Added By Riddhesh Patil on 3rd April 2023
                    //data: JSON.stringify(Parameter),
                    data: { '': daParams },
                    //End of Commented and Added By Riddhesh Patil on 3rd April 2023
                    dataType: "json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        //Commented By Riddhesh Patil on 3rd April 2023
                        //if (Parameter) {
                        //    xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                        //}
                        //Commented By Riddhesh Patil on 3rd April 2023
                    },
                    success: function (data) {
                      
                        //if (data == 1) {
                        showAlert('Daily Activity entered successfully.', 'alert-success', 'btnSave');
                        totalEnteredHours = 0;
                        IsDefault = 0;
                        ///SubtaskTypeList = "";
                        TaskIDList = "";
                        plotDailyTaskList();
                        GetExpectedActualHours();
                         hoursChangeValidation = false;
                        //}
                        //StopAjaxLoader("#bodyTSEntryMobile");
                        //Added by Vishal Mane on 18/11/2025 for 4 and 8 Hrs Timesheet Alert Validation for Expleo Customization
                        //ValidateTimesheetEntryAlert(0, StartDate, EndDate);
                        GetTimeSheetWeekHeaderDetailsMobile();
                        //End of Added by Vishal Mane on 18/11/2025 for 4 and 8 Hrs Timesheet Alert Validation for Expleo Customization
                    },
                    error: function (err) {
                        StopAjaxLoader("#bodyTSEntryMobile");
                        console.log(err);
                    }
                });
            }

        }
        function ViewTimesheet() {
         
            if (IsTaskList == 1) {
                //Commented And Added By Usha Pandit On 16.03.2021 For Resubmit Note display issue
                //window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&intTimesheetID=" + TimesheetID + "&PageFlag=1";
                window.location.href = "../TimesheetMobile/ViewTimesheet_Mobile.aspx?dtFromDate=" + StartDate + "&dtToDate=" + EndDate + "&intTimesheetID=" + TimesheetID + "&ViewTimesheetPageLoad=1&PageFlag=1" + "&EmployeeID=" + "<%= Session("intUserID") %>";
                //End Of Added By Usha Pandit On 16.03.2021 For Resubmit Note display issue
            }
            else {
                showAlert('Please Fill Daily Activity', 'alert-danger');
                 hoursChangeValidation = false;
            }
        }
        function GetTodayDate() {
            
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
        $('#Mvfilterpanel .selectpicker').change(function () {
            //
            //$(this).find('option:first').prop('selected', '');
            //if (!($(this).find('option:not(:first-child)')).hasClass("selected")) {
            //    $(this).find('option:first').prop('selected', '');
            //}
            //else {
            //     $(this).find('option:first').prop('selected', 'selected');
            //}

            

            if (($(".dropdown-menu").find("li:not(:first)")).hasClass("selected")) {
                $(".dropdown-menu").find("li:first").removeClass("selected");
                $(this).find('option:first').prop('selected', '');

            }
            else {
                $(this).find('option:first').prop('selected', 'selected');
            }


            $("#cboTaskCategory").selectpicker({
                noneSelectedText: 'Select Task Category' // by this default 'Nothing selected' -->will change to Select Task Category
            });
            $("#cboTaskTypes").selectpicker({
                noneSelectedText: 'Select Task Type' // by this default 'Nothing selected' -->will change to Select Task Type
            });
            $("#cboTaskStatus").selectpicker({
                noneSelectedText: 'Select Status' // by this default 'Nothing selected' -->will change to Select Status
            });
            $("#cboTaskPriority").selectpicker({
                noneSelectedText: 'Select Priority' // by this default 'Nothing selected' -->will change to Select Priority
            });





        });



        function isNumber(evt, val, obj) {
          
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
         //Added by Dipali V On 22nd May 2023 
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

        //Added by Dipali V On 22nd May 2023 
        function converttodeciamlfromhrs(Efforts) {
            
            if (Efforts != "") {
                var RequestParameters = {
                    WorkHrs: encodeURI(Efforts),
                    Flag: encodeURI(2),
                }
                var param = JSON.stringify(RequestParameters);
                var Efforts = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);

            }
            return Efforts
        }
         //End of Added by Dipali V On 22nd May 2023 
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

        function limitText(limitField, limitNum) {
            
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
       

        //$("[data-toggle='dropdown']").on('click', function () {
        //    alert();
        //    //$("[data-toggle='dropdown']").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
        //    $(".dropdown-menu").addClass('show');
        //});

        //$(".form-group").each(function () {
        //    debugger;
        //    $("[data-toggle='dropdown']").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
        //    $(this).id;
        //});

        //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
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

        function formatTime_Mobile(value) {
            if (!value) return '00:00';
            value = value.toString().replace('.', ':');
            var parts = value.split(':');
            if (parts.length === 1) parts.push('00');
            var hours = parts[0].padStart(2, '0');
            var minutes = parts[1].padEnd(2, '0').slice(0, 2);
            return hours + ':' + minutes;
        }
        function normalizeDate_Mobile(d) {
            return new Date(d.getFullYear(), d.getMonth(), d.getDate());
        }
        function formatDDMMMYYYY_Mobile(date) {
            var d = new Date(date);
            var day = d.getDate();
            var month = d.toLocaleString("en-US", { month: "short" });
            var year = d.getFullYear();
            return day + " " + month + " " + year;
        }
        //Commented and added by Vishal Mane on 12/05/2026 to fix Timezone issue
        //function convertToAPIDate_Mobile(dateStr) {
        //    var parts = dateStr.split(" ");
        //    if (parts.length < 3) return dateStr;
        //    var day = parts[0];
        //    var month = parts[1];
        //    var year = parts[2];
        //    var dateObj = new Date(day + " " + month + " " + year);
        //    return dateObj.toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });
        //}

        function convertToAPIDate_Mobile(dateStr) {
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

        function GetTimeSheetWeekHeaderDetailsMobile() {
            //debugger
            if (!StartDate || !EndDate) return;
            //Commented and added by Vishal Mane on 12/05/2026 to fix Timezone issue
            //var dtFrom = new Date(StartDate).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });
            var dtFrom = new Date(StartDate).toLocaleDateString("en-US");
            //var dtTo = new Date(EndDate).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });
            var dtTo = new Date(EndDate).toLocaleDateString("en-US");
            //Commented and added by Vishal Mane on 12/05/2026 to fix Timezone issue
            var taskParameters = { intEmployeeID: EmployeeID, dtFromDate: dtFrom, dtToDate: dtTo };
            var Result = AJAXCallWithResultMobile("/api/TimesheetEntryNew/GetTimeSheetWeekHeaderDetails", JSON.stringify(taskParameters), false);
            if (!Result) return;
            var TotalDaywiseEntry = Result["TimeSheetWeekHeader1"];
            TSSubmissionDetails = Result["TimeSheetWeekHeader2"] || [];
            if (!$.isArray(TSSubmissionDetails)) TSSubmissionDetails = [];
            HeaderResult = TotalDaywiseEntry;
            if (TotalDaywiseEntry && TotalDaywiseEntry.length > 0) {
                TimesheetStatus = TotalDaywiseEntry[0].Status;
                MobileWeekTotalFormatted = formatTime_Mobile(TotalDaywiseEntry[0].WeekTotal);
            } else {
                MobileWeekTotalFormatted = "00:00";
            }
            handleTimesheetButtonsMobile(dtFrom, dtTo);
            bindStatusDivMobile();
        }
        function bindStatusDivMobile() {
            var container = $("#txtStatus_MV");
            container.html("");
            var html = '<div class="ts-status-wrapper"><div class="row fw-bold border-bottom pb-1 mb-1"><div class="col-4 text-center">Status</div><div class="col-4 text-center">From</div><div class="col-4 text-center">To</div></div>';
            if (TSSubmissionDetails && TSSubmissionDetails.length > 0) {
                TSSubmissionDetails.forEach(function (item) {
                    var st = (item.Status || "").toLowerCase();
                    var cls = st === "not submitted" ? "statusNotSubmitted-text" : st === "approved" ? "text-success" : (st === "rejected" ? "text-danger" : (st === "submitted" ? "text-primary" : ""));
                    html += '<div class="row mb-1"><div class="col-4 text-center ' + cls + '">' + (item.Status || "") + '</div><div class="col-4 text-center">' + (item.FromDate || "") + '</div><div class="col-4 text-center">' + (item.ToDate || "") + '</div></div>';
                });
            } else {
                html += '<div class="text-muted">No status periods for this week.</div>';
            }
            html += '</div>';
            container.html(html);
        }
        function bindStatusDiv_TSModal_Mobile() {
            var container = $("#txtStatus_TSModal_MV");
            container.html("");
            //var html = '<div class="col-12 text-center"><strong>Timesheet Status Details</strong></div><div class="row fw-bold border-bottom pb-1 mb-1"></div><div class="ts-status-wrapper"><div class="row fw-bold border-bottom pb-1 mb-1"><div class="col-4 text-center">Status</div><div class="col-4 text-center">From</div><div class="col-4 text-center">To</div></div>';
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
            //if (TSSubmissionDetails && TSSubmissionDetails.length > 0) {
            //    TSSubmissionDetails.forEach(function (item) {
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
            container.html(html);
        }
        function getStatusForDate_Mobile(date) {
            if (!TSSubmissionDetails || !TSSubmissionDetails.length) return null;
            for (var i = 0; i < TSSubmissionDetails.length; i++) {
                var item = TSSubmissionDetails[i];
                var from = normalizeDate_Mobile(new Date(item.FromDate));
                var to = normalizeDate_Mobile(new Date(item.ToDate));
                if (date >= from && date <= to) return item;
            }
            return null;
        }
        function validateRejectedExactMatch_Mobile(startDate, endDate) {
            for (var i = 0; i < TSSubmissionDetails.length; i++) {
                var item = TSSubmissionDetails[i];
                if ((item.Status || "").toLowerCase() !== "rejected") continue;
                var from = normalizeDate_Mobile(new Date(item.FromDate));
                var to = normalizeDate_Mobile(new Date(item.ToDate));
                if (startDate.getTime() === from.getTime() && endDate.getTime() === to.getTime()) return true;
            }
            return false;
        }
        function validateTimesheetSubmissionMobile() {
            var startInput = $("#txtTSModalStartDate_MV").val();
            var endInput = $("#txtTSModalEndDate_MV").val();
            if (!startInput || !endInput) {
                showAlert("Please select valid date range.", 'alert-danger');
                return false;
            }
            var startDate = normalizeDate_Mobile(new Date(startInput));
            var endDate = normalizeDate_Mobile(new Date(endInput));

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
                var currentDay = normalizeDate_Mobile(new Date(d));
                var statusObj = getStatusForDate_Mobile(currentDay);
                if (!statusObj) continue;
                var status = (statusObj.Status || "").toLowerCase();
                var FromDate = statusObj.FromDate;
                var ToDate = statusObj.ToDate;
                if (status === "approved") {
                    //showAlert("The timesheet is already approved for the period " + FromDate + " to " + ToDate + ". Adjust the selected range.", 'alert-danger');
                    showAlert("The timesheet is already approved for the period " + FromDate + " to " + ToDate + ". Please adjust the selected date range to exclude approved dates and try again.", 'alert-danger');
                    return false;
                }
                if (status === "submitted" || status === "pending") {
                    //showAlert("Timesheet is already submitted for the period " + FromDate + " to " + ToDate + ". Adjust the selected range.", 'alert-danger');
                    showAlert("Timesheet is already submitted for the period " + FromDate + " to " + ToDate + ". Please adjust the selected date range to exclude submitted dates and try again.", 'alert-danger');
                    return false;
                }
                var rejectedPeriods = TSSubmissionDetails.filter(function (x) { return (x.Status || "").toLowerCase() === "rejected"; });
                if (rejectedPeriods.length > 0) {
                    for (var j = 0; j < rejectedPeriods.length; j++) {
                        var item = rejectedPeriods[j];
                        var from = normalizeDate_Mobile(new Date(item.FromDate));
                        var to = normalizeDate_Mobile(new Date(item.ToDate));
                        if (startDate.getTime() === from.getTime() && endDate.getTime() === to.getTime()) break;
                        if (startDate <= to && endDate >= from) {
                            //showAlert("Re-Submission is allowed only for the exact rejected period (" + item.FromDate + " to " + item.ToDate + ").", 'alert-danger');
                            showAlert("Timesheet Re-Submission is allowed only for the exact rejected period (" + item.FromDate + " to " + item.ToDate + "). Please select the complete rejected range and try again.", 'alert-danger');
                            return false;
                        }
                    }
                }
            }
            var hasRejectedInRange = false;
            for (var k = 0; k < TSSubmissionDetails.length; k++) {
                var it = TSSubmissionDetails[k];
                if ((it.Status || "").toLowerCase() === "rejected") {
                    var f = normalizeDate_Mobile(new Date(it.FromDate));
                    var t = normalizeDate_Mobile(new Date(it.ToDate));
                    if (startDate >= f && endDate <= t) hasRejectedInRange = true;
                }
            }
            if (hasRejectedInRange && !validateRejectedExactMatch_Mobile(startDate, endDate)) {
                showAlert("Resubmission is allowed only for the exact rejected period.", 'alert-danger');
                return false;
            }
            return true;
        }
        function handleTimesheetButtonsMobile(dtFromDate, dtToDate) {
            //debugger
            var start = normalizeDate_Mobile(new Date(dtFromDate));
            var end = normalizeDate_Mobile(new Date(dtToDate));
            var hasNotSubmitted = false, hasRejected = false, hasApprovedOrSubmitted = false;
            if (dtToDate == undefined) {
                for (var d = new Date(start); d <= start; d.setDate(d.getDate() + 1)) {
                    var statusObj = getStatusForDate_Mobile(normalizeDate_Mobile(new Date(d)));
                    if (!statusObj) continue;
                    var status = (statusObj.Status || "").toLowerCase();
                    if (status === "not submitted") hasNotSubmitted = true;
                    if (status === "rejected") hasRejected = true;
                    if (status === "approved" || status === "submitted") hasApprovedOrSubmitted = true;
                }
            } else { 
                for (var d = new Date(start); d <= end; d.setDate(d.getDate() + 1)) {
                    var statusObj = getStatusForDate_Mobile(normalizeDate_Mobile(new Date(d)));
                    if (!statusObj) continue;
                    var status = (statusObj.Status || "").toLowerCase();
                    if (status === "not submitted") hasNotSubmitted = true;
                    if (status === "rejected") hasRejected = true;
                    if (status === "approved" || status === "submitted") hasApprovedOrSubmitted = true;
                }
            }
            //debugger
            var allSubmittedApproved = !hasNotSubmitted && !hasRejected && hasApprovedOrSubmitted;
            var allRejected = hasRejected;
            var saveBtn = $("#btnSave");
            var submitBtn = $("#btnSubmitTSMobile");
            var addBtn = $('a[data-bs-target="#Mv_createproject"]');
            var filterTaskBtn = $("#txtFilterTaskList");
            // Enable/disable add-project button based on selected day's status.
            var selectedStatusObj = getStatusForDate_Mobile(normalizeDate_Mobile(new Date(SelectedDate || dtFromDate)));
            var selectedStatus = selectedStatusObj ? (selectedStatusObj.Status || "").toLowerCase() : "";
            if (selectedStatus === "approved" || selectedStatus === "submitted") {
                filterTaskBtn.css("pointer-events", "none").css("opacity", "0.4");
                saveBtn.css("pointer-events", "none").css("opacity", "0.4");
                // submitBtn.css("pointer-events", "none").css("opacity", "0.4");
            } else if (selectedStatus === "not submitted" || selectedStatus === "rejected") {
                filterTaskBtn.css("pointer-events", "").css("opacity", "");
                saveBtn.css("pointer-events", "").css("opacity", "");
                //submitBtn.css("pointer-events", "").css("opacity", "");
            }
            if (allSubmittedApproved) {
                saveBtn.prop("disabled", true);
                //submitBtn.prop("disabled", true);
                addBtn.css("pointer-events", "none").css("opacity", "0.4");
                $("#btnSubmitTimesheet_MV").text("Submit");
                return;
            }
            if (allRejected) {
                saveBtn.prop("disabled", false);
                submitBtn.prop("disabled", false);
                addBtn.css("pointer-events", "").css("opacity", "");
                $("#btnSubmitTimesheet_MV").text("Re-Submit");
                return;
            }
            saveBtn.prop("disabled", false);
            submitBtn.prop("disabled", false);
            addBtn.css("pointer-events", "").css("opacity", "");
            $("#btnSubmitTimesheet_MV").text("Submit");
        }
        function parseAllowToResubmit_Mobile(input) {
            var v = input.attr("data-allowtoresubmit-id");
            if (v === undefined || v === null || v === "") return null;
            var s = ("" + v).toLowerCase();
            if (s === "0" || s === "false" || s === "no") return false;
            if (s === "1" || s === "true" || s === "yes") return true;
            return null;
        }
        function syncMobileDARowFromTaskInput(input, locked) {
            var id = input.attr("id");
            if (!id || id.indexOf("Duration_") !== 0) return;
            var suffix = id.substring("Duration_".length);
            var desc = $("#Description_" + suffix);
            var sp = $("#StoryPoint_" + suffix);
            var sf = (input.attr("data-statusflag-id") || "").toUpperCase();
            var entryDateStr = input.attr("data-entrydate-id");
            var st = "";
            if (entryDateStr) {
                var stObj = getStatusForDate_Mobile(normalizeDate_Mobile(new Date(entryDateStr)));
                st = stObj ? (stObj.Status || "").toLowerCase() : "";
            }
            if (locked) {
                desc.prop("readonly", true);
                if (sp.length) sp.prop("readonly", true);
                return;
            }
            if (st === "rejected") {
                desc.prop("readonly", false);
                if (sp.length) sp.prop("readonly", false);
                return;
            }
            if (sf === "R" || sf === "V") {
                desc.prop("readonly", true);
                if (sp.length) sp.prop("readonly", true);
            } else {
                desc.prop("readonly", false);
                if (sp.length) sp.prop("readonly", false);
            }
        }
        // Added by Vishal Mane on 09/04/2026: Per-project/day behaviour in a Rejected TSSubmissionDetails window —
        // use API AllowToResubmit + StatusFlag J (rejected line) so approved-portion projects stay locked at 00:00,
        // aligned with TimesheetEntry_New.aspx (projectRejectedRangeLock + period status).
        var projectRejectedRangeLock = new Set();
        var projectRejectedRangeEnable = new Set();
        function EnableDisbaleDATextbox() {
            if (!HeaderResult || HeaderResult.length === 0) return;
            var entryStatusMap = {};
            HeaderResult.forEach(function (r) {
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
                var statusObj = getStatusForDate_Mobile(normalizeDate_Mobile(d));
                var key = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
                var status = statusObj ? (statusObj.Status || "") : (entryStatusMap[key] || "");
                if (!status) return;
                var statusFlag = (input.attr('data-statusflag-id') || "").toUpperCase();
                var projectId = (input.attr('data-projectid-id') || "").toString().trim();
                if (!projectId) return;
                if (status.toLowerCase() === "rejected") {
                    var fromKey = statusObj && statusObj.FromDate ? normalizeDate_Mobile(new Date(statusObj.FromDate)).toISOString().substring(0, 10) : key;
                    var toKey = statusObj && statusObj.ToDate ? normalizeDate_Mobile(new Date(statusObj.ToDate)).toISOString().substring(0, 10) : key;
                    var rangeKey = projectId + "|" + fromKey + "|" + toKey;
                    var atrScan = parseAllowToResubmit_Mobile(input);
                    // If any day in rejected range has hard lock flag R, keep full project locked for that range.
                    if (statusFlag === "R" || statusFlag === "V") {
                        projectRejectedRangeLock.add(rangeKey);
                    }
                    // If any day in rejected range is resubmittable/J (or newly added row with no status yet),
                    // enable whole project range for editing.
                    if (atrScan === true || statusFlag === "J" || (atrScan === null && !statusFlag)) {
                        projectRejectedRangeEnable.add(rangeKey);
                    }
                }
            });

            $('.taskTxt').each(function () {
                var input = $(this);
                var duration = input.val();
                var entryDateStr = input.attr('data-entrydate-id');
                if (!entryDateStr) return;
                var d = new Date(entryDateStr);
                var statusObj = getStatusForDate_Mobile(normalizeDate_Mobile(d));
                var key = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
                var status = statusObj ? (statusObj.Status || "") : (entryStatusMap[key] || "");
                if (!status) return;
                var statusLower = status.toLowerCase();
                var statusFlag = (input.attr('data-statusflag-id') || "").toUpperCase();
                var projectId = (input.attr('data-projectid-id') || "").toString().trim();
                var locked = false;
                var isSelectedAddedProject = false;
                if (selectedProjectList && selectedProjectList.length > 0) {
                    for (var sp = 0; sp < selectedProjectList.length; sp++) {
                        if ((selectedProjectList[sp] + "") === projectId) {
                            isSelectedAddedProject = true;
                            break;
                        }
                    }
                }

                // Added by Vishal Mane on 09/04/2026:
                // For projects selected in FilterTaskFromList(), keep all their tasks editable in
                // Rejected/Not Submitted statuses so newly added project-task rows can be filled.
                if (isSelectedAddedProject && (statusLower === "rejected" || statusLower === "not submitted")) {
                    locked = false;
                }
                else if (statusLower === "ready for approval" || statusLower === "approved" || statusLower === "submitted") {
                    locked = true;
                }
                else if (statusLower === "rejected") {
                    var fromKey = statusObj && statusObj.FromDate ? normalizeDate_Mobile(new Date(statusObj.FromDate)).toISOString().substring(0, 10) : key;
                    var toKey = statusObj && statusObj.ToDate ? normalizeDate_Mobile(new Date(statusObj.ToDate)).toISOString().substring(0, 10) : key;
                    var rangeKey = projectId + "|" + fromKey + "|" + toKey;
                    //Added by Vishal Mane on 09/04/2026 to disable Approved Timesheet
                    if (statusFlag === 'V') {
                        locked = true;
                    }
                    else
                    //End of Added by Vishal Mane on 09/04/2026 to disable Approved Timesheet                   
                    if (projectRejectedRangeLock.has(rangeKey)) {
                        locked = true;
                    }
                    else if (projectRejectedRangeEnable.has(rangeKey)) {
                        locked = false;
                    }
                    else {
                        var atr = parseAllowToResubmit_Mobile(input);
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
                            // Newly added rows from FilterTaskFromList generally have blank status metadata.
                            // In rejected windows they must remain editable.
                            if (!statusFlag) locked = false;
                            else locked = (statusFlag !== "J");
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
                    input.prop("readonly", true).addClass("bg-light");
                } else {
                    input.prop("readonly", false).removeClass("bg-light");
                }
                syncMobileDARowFromTaskInput(input, locked);
            });
        }
        function validateFlexibleTS_Mobile() {
            var startInput = $("#txtTSModalStartDate_MV").val();
            var endInput = $("#txtTSModalEndDate_MV").val();
            var start = normalizeDate_Mobile(new Date(StartDate));
            var end = normalizeDate_Mobile(new Date(EndDate));
            var selectedDate = SelectedDate ? normalizeDate_Mobile(new Date(SelectedDate)) : start;
            var isCrossMonth = start.getMonth() !== end.getMonth() || start.getFullYear() !== end.getFullYear();
            var finalStart, finalEnd;
            if (!isCrossMonth) {
                finalStart = start;
                finalEnd = end;
            }
            //Commented and added by Vishal Mane on 13/04/2026 to fix Calender date selection issue
            else {
                finalStart = start;
                finalEnd = end;
            }
            //else {
            //    if (selectedDate.getMonth() === start.getMonth() && selectedDate.getFullYear() === start.getFullYear()) {
            //        finalStart = start;
            //        finalEnd = new Date(start.getFullYear(), start.getMonth() + 1, 0);
            //    } else {
            //        finalStart = new Date(end.getFullYear(), end.getMonth(), 1);
            //        finalEnd = end;
            //    }
            //}
            //End of Commented and added by Vishal Mane on 13/04/2026 to fix Calender date selection issue
            var dtFromDate = normalizeDate_Mobile(finalStart);
            var dtToDate = normalizeDate_Mobile(finalEnd);
            var startDate = normalizeDate_Mobile(new Date(startInput));
            var endDate = normalizeDate_Mobile(new Date(endInput));
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
        function SubmitTS_OnClick_Confirmation_Mobile() {
            $("#submitTSModal_Mobile").modal('show');
            bindStatusDiv_TSModal_Mobile();
            var sel = SelectedDate ? new Date(SelectedDate) : new Date(StartDate);
            var start = new Date(StartDate);
            var end = new Date(EndDate);
            //Commented and added by Vishal Mane on 13/04/2026 to fix Calender date selection issue
            //var finalStart, finalEnd;
            //var isCrossMonth = start.getMonth() !== end.getMonth() || start.getFullYear() !== end.getFullYear();
            //if (!isCrossMonth) {
            //    finalStart = start;
            //    finalEnd = end;
            //} else {
            //    if (sel.getMonth() === start.getMonth() && sel.getFullYear() === start.getFullYear()) {
            //        finalStart = start;
            //        finalEnd = new Date(start.getFullYear(), start.getMonth() + 1, 0);
            //    } else {
            //        finalStart = new Date(end.getFullYear(), end.getMonth(), 1);
            //        finalEnd = end;
            //    }
            //}
            let finalStart = start;
            let finalEnd = end;
            //End of Commented and added by Vishal Mane on 13/04/2026 to fix Calender date selection issue

            var fromFormatted = formatDDMMMYYYY_Mobile(finalStart);
            var toFormatted = formatDDMMMYYYY_Mobile(finalEnd);
            $("#txtTSModalStartDate_MV").val(fromFormatted);
            $("#txtTSModalEndDate_MV").val(toFormatted);
            $("#lblSelectedRange_MV").text(fromFormatted + " - " + toFormatted);
            $("#lblWeekRange").text(fromFormatted + " - " + toFormatted);
            Global_oldStartDate_MV = fromFormatted;
            Global_oldEndDate_MV = toFormatted;
        }
        function ValidateTimesheetEntryAlert_FlexibleTS_Mobile(flag) {
            var Data = {
                intEmployeeID: EmployeeID,
                dtFromDate: convertToAPIDate_Mobile(Global_oldStartDate_MV),
                dtToDate: convertToAPIDate_Mobile(Global_oldEndDate_MV)
            };
            var param = JSON.stringify(Data);
            var Result = AJAXCallWithResultMobile("/api/TimesheetEntryNew/GetValidateTimesheetEntryAlert", param, false);
            var msg = '';
            if (Result && Result.length) {
                for (var i = 0; i < Result.length; i++) {
                    msg = msg + Result[i].EntryDate + ' (' + Result[i].LeaveHours + ' hours)' + ' ';
                }
                if (flag === 0) {
                    $("#txtLeaveValidationMessage").text('You have filled less than the required working hours for ' + msg + ',if you were on leave, then please submit the leave.');
                    $("#fourandEightHoursValidation").modal('show');
                } else {
                    showAlert('You have filled less than the required working hours for ' + msg + ',if you were on leave, then please submit the leave.', 'alert-danger');
                    return false;
                }
            }
        }
        function ValidateSubmitTS_FlexibleTS_Mobile() {
            var Flag = 0;
            var taskparameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: convertToAPIDate_Mobile(Global_oldStartDate_MV),
                dtToDate: convertToAPIDate_Mobile(Global_oldEndDate_MV)
            };
            var data = AJAXCallWithResultMobile("/api/TimesheetEntryNew/ValidateTimesheet", JSON.stringify(taskparameters), false);
            if (data !== "") {
                showAlert('' + data + '', 'alert-danger');
                Flag = 1;
            }
            return Flag;
        }
        function ValidateHolidayLeaveTS_Mobile() {
            var Flag = 0;
            var taskparameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: convertToAPIDate_Mobile(Global_oldStartDate_MV),
                dtToDate: convertToAPIDate_Mobile(Global_oldEndDate_MV)
            };
            var data = AJAXCallWithResultMobile("/api/TimesheetEntryNew/ValidateHolidayLeaveTS", JSON.stringify(taskparameters), false);
            if (data !== "") {
                showAlert('' + data + '', 'alert-danger');
                Flag = 1;
            }
            return Flag;
        }
        function SubmitTS_OnClick_FlexibleTS_Mobile() {
            var timeParts = MobileWeekTotalFormatted.split(':');
            var hours = parseInt(timeParts[0], 10) || 0;
            var minutes = parseInt(timeParts[1], 10) || 0;
            var totalMinutes = (hours * 60) + minutes;
            if (validateTimesheetSubmissionMobile() === false) return false;
            /*if (ValidateTimesheetEntryAlert_FlexibleTS_Mobile(1) === false) return false;*/
            if (totalMinutes === 0) {
                showAlert('Please fill daily activity.', 'alert-danger');
                return false;
            }
            if (ValidateSubmitTS_FlexibleTS_Mobile() === 1) return false;
            //if (ValidateHolidayLeaveTS_Mobile() === 1) return false;
            var taskparameters = {
                intProxyUserID: 0,
                employeeID: EmployeeID,
                dtFromDate: convertToAPIDate_Mobile(Global_oldStartDate_MV),
                dtToDate: convertToAPIDate_Mobile(Global_oldEndDate_MV),
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
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    if (taskparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? taskparameters : JSON.stringify(taskparameters)));
                    }
                },
                success: function () {
                    showAlert('Timesheet submitted successfully.', 'alert-success');
                    $("#submitTSModal_Mobile").modal('hide');
                    //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                    GetTimeSheetWeekHeaderDetailsMobile();
                    plotDailyTaskList();
                    GetExpectedActualHours();
                    if (typeof EnableDisbaleDATextbox === 'function') { EnableDisbaleDATextbox(); }
                    //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }

        //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
        //Added by Vishal Mane on 18/11/2025 for 4 and 8 Hrs Timesheet Alert Validation for Expleo Customization
        function ValidateTimesheetEntryAlert(flag, StartDate, EndDate) {
            var Data = {
                intEmployeeID: EmployeeID,
                dtFromDate: StartDate,
                dtToDate: EndDate
            };
            var param = JSON.stringify(Data);
            var Result = AJAXCallWithResultMobile("/api/TimesheetEntryNew/GetValidateTimesheetEntryAlert", param, false);
            var msg = '';
            if (Result && Result.length) {
                for (var i = 0; i < Result.length; i++) {
                    msg = msg + Result[i].EntryDate + ' (' + Result[i].LeaveHours + ' hours)' + ' ';
                }
                if (flag == 0) {
                    $("#txtLeaveValidationMessage").text('You have filled less than the required working hours for ' + msg + ',if you were on leave, then please submit the leave.');
                    $("#fourandEightHoursValidation").modal('show');
                //Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
                } else {
                    showAlert('You have filled less than the required working hours for ' + msg + ',if you were on leave, then please submit the leave.', 'alert-danger');
                    return false;
                }
                //End of Added by Vishal Mane on 02/04/2026 for Flexible Timehseet Submission on Mobile View for Expleo
            }
        }
        function ValidateNumericValue(inputElement) {
            var inputValue = inputElement.value;
            var numericValue = inputValue.replace(/[^0-9.]/g, '');
            numericValue = numericValue.replace(/\.(?=.*\.)/g, '');
            if (numericValue !== '' && !isNaN(numericValue) && parseFloat(numericValue) >= 0) {
                inputElement.value = numericValue;
            } else {
                inputElement.value = '';
            }
        }
        //Added by Vishal Mane on 18/11/2025 for 4 and 8 Hrs Timesheet Alert Validation for Expleo Customization
    </script>

</body>

</html>
