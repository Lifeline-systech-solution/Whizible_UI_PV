<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="~/Source/NewAPI/Issues/IB_Dashboard.aspx.vb" Inherits="PbNIT.IB_Dashboard" %>

<!DOCTYPE html>
<html>

    <%CommonFunctions.General.PlotPageHeadTag("Issues")%>
<head>
    
     <!-- Commented by Gauri on 09/08/24 for JQuery and Bootstrap version upgrade -->
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Issues</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_issues.css?v=2.3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
</head>

    <style type="text/css">
        .content-wrapper, .right-side, .main-footer {
            margin-left: 0;
        }

        .fixed .content-wrapper, .fixed .right-side {
            padding-top: 0;
        }

        #chart-area {
            width: 90%;
        }

        #chart-area2 {
            width: 90%;
        }


        .dashpanel > .row-eq-height > div {
            margin-bottom: 20px;
        }

            .dashpanel > .row-eq-height > div > .box {
                margin-bottom: 0;
                height: 100%;
            }


        .SIStable {
            border: 1px solid #ddd;
            min-height: 357px;
            max-height: 357px;
            overflow-y: auto
        }

        .box.box-solid.box-panel .SIStable table tr th:first-child, .box.box-solid.box-panel .SIStable table tr td:first-child {
            /*text-align: left*/
            text-align: center
        }

        .SIStable table tbody tr:nth-child(even), .SIStable table tbody tr:nth-child(even) td {
            background: #f7fcff !important
        }

        .box.box-solid.box-panel .SIStable table {
            border: none
        }



        #cbochangedFromStatus, #cbochangedToStatus, #ddlChangedFromStatus {
            height: 32px;
            /*width: 10px*/
        }

        #cboviewToApply {
            height: 32px;
            /*width: 310px*/
        }

        .bluecolor {
            background-color: dodgerblue;
        }

        #IdBackbtn {
            float: right;
            margin-top: 9px;
        }

        /*Newcss_added_by_pradip_on_05-10-2019*/
        iframe#frmNewVersion {
            min-height: 94vh!important;
        }
        /*Added by Dipali V On 2nd April 2020 For Apply scroll when column was more in view */
        #idview {
            overflow:auto!important
        }
        /*End of Added by Dipali V On 2nd April 2020 For Apply scroll when column was more in view */

       
       /*.fade:not(.show) {opacity: 1;}*/  /*commented by pradip content 27-1-2023*/

        .customformpanel .col-md-6, .customformpanel .col-sm-6{display:inline-flex}
        .col-sm-offset-3 {margin-left: 25%;}
        tbody, td, tfoot, th, thead, tr{border-style: none;}
        .nav-tabs > li > a.active{background:#1359ac;color:#fff!important}
    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="idDashboardBody">

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper IssueDashboard_main" id="maindiv">
            <!-- Content Header (Page header) -->
            <!-- Main content -->
            <section class="content">
                <div class="col-md-12 pt-1">
                    <ul class="nav nav-tabs headernavlist maintabs">
                        <li><a href="#chartview" class="active" data-bs-toggle="tab"><%= MyBase.GetResourceString("C_Dashboart_chart") %></a>
                        </li>
                        <li><a href="#" id="viewReport"><%= MyBase.GetResourceString("C_View_Report") %></a>
                        </li>
                        <%--  added by dipali V on 20th Aug 2019 for redirect to main page--%>
                        <li id="IdBackbtn" style="position:absolute;right:31px">
                            <button type="button" class="btn borderbtn ml-1" id="btnBack">Back</button>
                        </li>
                        <%--  end of added by dipali V on 20th Aug 2019 for redirect to main page--%>
                    </ul>
                </div>
                <div class="tab-content">
                    <div class="tab-pane in active" id="chartview">
                        <div class="Issuemodulewrap_main">
                            <div class="headerspacing">&nbsp;</div>
                            <div class="col-md-12 dashpanel">
                                <div class="row row-eq-height ">
                                    <div class="col-md-6">
                                        <div class="box box-panel box-solid chartbox">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3><%= MyBase.GetResourceString("C_System_Issue_Status_report") %></h3>
                                            </div>
                                            <div class="box chartboxheader  " style="display:inline-flex;align-items:center">
                                                <label class="mr-1"><%= MyBase.GetResourceString("C_Overall_Open_Requests") %></label>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("overall", " usp_Whizible2_sel_graphfiltertype_Dashboard_IssueStatus 'Overall' ", 135, , " class='form-control' onchange=javascript:GetByTypeGraph() ", False, False)%>&nbsp;
                                                <%CommonFunctions.HTMLControls.DrawComboBox("duration", "Usp_Whizible2_Sel_GraphFilterTime_Dashboard_IssueStatus ''", 135, , " class='form-control' onchange=javascript:GetDurationGraph() ", False, False)%>

                                                <div class="chartboxaction dropdown pull-right">
                                                </div>
                                            </div>
                                            <!-- /.box-header -->
                                            <div class="box-body">
                                                <div id="canvas-holder" style="width: 100%">
                                                    <canvas id="chart-area" width="300" height="200"></canvas>
                                                </div>
                                            </div>
                                            <!-- /.box-body -->
                                            <!-- /.box -->
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="box box-panel box-solid chartbox">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3><%= MyBase.GetResourceString("C_System_Issue_Status_report") %></h3>
                                            </div>
                                            <div class="box chartboxheader" style="display:inline-flex;align-items:center">


                                                <label class="mr-1">Assigned to me</label>

                                                <%CommonFunctions.HTMLControls.DrawComboBox("overall1", " usp_Whizible2_sel_graphfiltertype_Dashboard_IssueStatus 'AssignedToMe' ", 135, , " class='form-control'  onchange=javascript:GetByAssignedTypeGraph() ", False, False)%>&nbsp;
                                                <%CommonFunctions.HTMLControls.DrawComboBox("duration1", "Usp_Whizible2_Sel_GraphFilterTime_Dashboard_IssueStatus ''", 135, , " class='form-control' onchange=javascript:GetAssignedDurationGraph() ", False, False)%>


                                                <div class="chartboxaction dropdown pull-right">
                                                </div>
                                            </div>
                                            <!-- /.box-header -->
                                            <div class="box-body">
                                                <div id="canvas-holder2" style="width: 100%">
                                                    <canvas id="chart-area2" width="200" height="134"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.box-body -->
                                        <!-- /.box -->
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="row">
                                    <!--In and out rate chart-->
                                    <div class="col-sm-12">
                                        <div class="box box-panel box-solid chartbox">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3><%= MyBase.GetResourceString("C_Issues_In_Rate_Out_rate") %></h3>
                                            </div>
                                            <div class="box chartboxheader form-inline">
                                                <label class="mr-1"><strong>Issue</strong> In Rate and Out Rate</label>


                                                <%CommonFunctions.HTMLControls.DrawComboBox("inoutrate1", "usp_Whizible2_sel_graphyear_inrateoutrate_Dashboard_IssueStatus", 85, , " onchange=javascript:GetYearInOutRategraph1()   class='form-control' ", False, False)%>&nbsp;
                                                 

                                               <%CommonFunctions.HTMLControls.DrawComboBox("qtrinoutrate", "usp_Whizible2_sel_Dashboard_IB_issue_for_Quarter ", 135, , "   onchange=javascript:getquarter1data()  class=' form-control ' ", False, False)%>&nbsp;
        <%CommonFunctions.HTMLControls.DrawComboBox("monthid", "select 'Select Month'", 135, , "onchange=javascript:getdependentmonthdata() class=' form-control ' ", False, False)%>&nbsp;
                                                <div class="chartboxaction dropdown pull-right">
                                                </div>
                                            </div>
                                            <!-- /.box-header -->
                                            <div class="box-body" id="canvas-holder3">
                                                <canvas id="chart-0" height="100"></canvas>
                                            </div>
                                            <!-- /.box-body -->
                                            <!-- /.box -->
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <!--End In and out rate chart-->
                                    <!--pareto analysis chart-->
                                    <div class="col-sm-12">
                                        <div class="box box-panel box-solid chartbox">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3><%= MyBase.GetResourceString("C_Pareto_Analysis") %></h3>
                                            </div>
                                            <div class="box chartboxheader" style="display:inline-flex;align-items:center">
                                                <label class="mr-1"><strong><%= MyBase.GetResourceString("C_Issue") %></strong> <%= MyBase.GetResourceString("C_analysis_Pareto") %></label>

                                                <%CommonFunctions.HTMLControls.DrawComboBox("pareto", " usp_Whizible2_sel_graphfiltertype_Dashboard_IssueStatus 'ParetoAnalysis' ", 135, , "class='form-control' onchange=javascript:Getparetograph() ", False, False)%>
                                                <div class="chartboxaction dropdown pull-right">
                                                </div>
                                            </div>
                                            <!-- /.box-header -->
                                            <div class="box-body" id="canvas-holder4">
                                                <canvas id="mixedChart" height="370" width="1054"></canvas>
                                            </div>
                                            <!-- /.box-body -->
                                            <!-- /.box -->
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <!--End pareto analysis chart-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane " id="viewreport">
                        <div class="clearfix"></div>
                        <!--status-report-->
                        <div id="dashstatusreport">
                            <div class="col-md-12 pt-1">
                                <h4><%= MyBase.GetResourceString("C_Status_Report") %></h4>
                            </div>
                            <div class="clearfix"></div>
                            <div class="container-fluid pt-1 pb-1 headertopp">
                                <%-- graybg--%>
                                <ul class="headernavlist pull-right">
                                    <li><a href="javascript:;" id="SISReportlink"><%= MyBase.GetResourceString("C_System_Issue_Status_report") %></a>
                                    </li>
                                    <li><a href="javascript:;" id="dashviewreportlink"><%= MyBase.GetResourceString("C_View_Report") %></a>
                                    </li>
                                    <li><a href="javascript:;" id="reportTabclose"><%= MyBase.GetResourceString("C_Close") %></a>
                                    </li>
                                    <%-- <li><a href="">?</a>
                                    </li>--%>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="bgwhite container-fluid pt-1 pb-1 text-right">
                                <strong><%= MyBase.GetResourceString("C_Manditory") %></strong>
                            </div>
                            <p class="container-fluid pt-1 pb-1 text-right">
                                <%--graybg--%>
                                <span class="pull-left"><strong><%= MyBase.GetResourceString("C_Status_and_Duration_Based_Report") %></strong></span>
                                <span class="pull-right"><strong><%= MyBase.GetResourceString("C_Project") %> : <span data-toggle="tooltip" data-placement="top" title="Selected Project" id="sessionProjectName"></span><%--Product Tech Support (BST)-2016-17--%></strong></span>
                            </p>
                            <div class="col-md-12">
                                <div class="box box-panel box-solid">
                                    <div class="box-body customformpanel">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label class="control-label col-sm-4"><%= MyBase.GetResourceString("C_Changed_From_Status") %>  <span id="MandatoryChangeStatus" style="color: red;">*</span> </label>
                                                    <div class="col-sm-8">
                                                        <%--Commented And Added By Usha Pandit On 18.03.2020 For showing placeholder--%>
                                                        <%'CommonFunctions.HTMLControls.DrawComboBox("cbochangedFromStatus", "EXEC usp_Whizible2_Sel_tbl_IB_Project_Type_Status_Status ",,, "class='form-control selectpicker'", 310) %>
                                                        <%CommonFunctions.HTMLControls.DrawComboBox("cbochangedFromStatus", "EXEC usp_Whizible2_Sel_tbl_IB_Project_Type_Status_Status ",,, "class='form-control'", False) %>
                                                        <%--End Of Added By Usha Pandit On 18.03.2020 For showing placeholder--%>
                                                        
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="control-label col-sm-4"><%= MyBase.GetResourceString("C_Changed_To_Status") %>  <span id="MandatoryChangestatusTo" style="color: red;">*</span> </label>
                                                    <div class="col-sm-8">
                                                        <%--Commented And Added By Usha Pandit On 18.03.2020 For showing placeholder--%>
                                                        <%'CommonFunctions.HTMLControls.DrawComboBox("cbochangedToStatus", "EXEC usp_Whizible2_Sel_tbl_IB_Project_Type_Status_Status ",,, "class='form-control selectpicker'", 310) %>
                                                        <%CommonFunctions.HTMLControls.DrawComboBox("cbochangedToStatus", "EXEC usp_Whizible2_Sel_tbl_IB_Project_Type_Status_Status ",,, "class='form-control'", False) %>
                                                        <%--End Of Added By Usha Pandit On 18.03.2020 For showing placeholder--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label class="control-label col-sm-4"><%= MyBase.GetResourceString("C_From_Date") %>  <span id="MandatoryFromDate" style="color: red;">*</span> </label>
                                                    <div class="col-sm-8">
                                                        <div class="input-group datefielddiv">
                                                            <%--   added & Commented By Dipali V On 20th Aug 2019 For Change Textbox--%>
                                                            <%--<input id="datepicker" type="text" class="form-control" autocomplete="off">--%>
                                                            <%--Commented And Added By Usha Pandit On 09.06.2020 for restricting alphabates for Start Date--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("datepicker", "datepicker", "form-control", ,,,,, ,,,, "autocomplete=off",,, True,,,, True) %>--%>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("datepicker", "datepicker", "form-control", ,,,,, ,,,, "onkeypress='return Date_OnKeyPress(event)' autocomplete=off",,, True,,,, True) %>
                                                        <%--End Of Added By Usha Pandit On 09.06.2020 for restricting alphabates for Start Date--%>
                                                            <%--   End of added & Commented By Dipali V On 20th Aug 2019 For Change Textbox--%>
                                                            <span class="input-group-btn">
                                                                <button class="btn btncalendar" type="button" style="height:30px"><i class="fas fa-calendar-alt"></i></button>
                                                            </span>
                                                        </div>

                                                    </div>
                                                </div>

                                                <div class="col-sm-6">
                                                    <label class="control-label col-sm-4"><%= MyBase.GetResourceString("C_To_Date") %>  <span id="MandatorytoDate" style="color: red;">*</span> </label>
                                                    <div class="col-sm-8">
                                                        <div class="input-group datefielddiv">
                                                            <%--   added & Commented By Dipali V On 20th Aug 2019 For Change Textbox--%>
                                                            <%-- <input id="datepicker1" type="text" class="form-control" autocomplete="off">--%>
                                                            <%--Commented And Added By Usha Pandit On 09.06.2020 for restricting alphabates for Start Date--%>
                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("datepicker1", "datepicker1", "form-control", ,,,,, ,,,, "autocomplete=off",,, True,,,, True) %>--%>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("datepicker1", "datepicker1", "form-control", ,,,,, ,,,, "onkeypress='return Date_OnKeyPress(event)' autocomplete=off",,, True,,,, True) %>
                                                        <%--End Of Added By Usha Pandit On 09.06.2020 for restricting alphabates for Start Date--%>
                                                            <%--   End of added & Commented By Dipali V On 20th Aug 2019 For Change Textbox--%>
                                                            <span class="input-group-btn">
                                                                <button class="btn btncalendar" type="button" style="height:30px"><i class="fas fa-calendar-alt"></i></button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label class="control-label col-sm-4"><%= MyBase.GetResourceString("C_View_To_Apply") %> <span id="MandatoryView" style="color: red;">*</span> </label>
                                                    <div class="col-sm-8">

                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboviewToApply", "Select 0,'Corporate View'",,, "class='form-control'", 310) %>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="control-label col-sm-4">&nbsp;</label>
                                                    <div class="col-sm-8">&nbsp;</div>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <br />
                                        <p>
                                            <strong><%= MyBase.GetResourceString("C_IMPORTANT_NOTE") %></strong>
                                            : <%= MyBase.GetResourceString("C_IMPORTANT_NOTE_VALUE") %>
                                        </p>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!--Endstatus-report-->
                        <div class="clearfix"></div>
                        <div id="dashviewreport" style="display: none;">
                            <div class="container-fluid pt-1 pb-1 headertopp">
                                <ul class="headernavlist pull-right">
                                    <li><a href="javascript:;" id="closeviewreport" onclick="closeviewreport1()"><%= MyBase.GetResourceString("C_Close") %></a>
                                    </li>
                                    <%--<li><a href="">?</a>--%>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="bgwhite container-fluid pt-1 pb-1 text-left">
                                <strong><%= MyBase.GetResourceString("C_Prefix_indiactes_Custom_Field") %></strong>
                            </div>
                            <p class="container-fluid pt-1 pb-1#issueviewdetails">&nbsp;</p>
                            <div class="col-md-12">
                                <div class="box box-panel box-solid">
                                    <div class="box-body customformpanel">
                                        <div class="viewreport form-horizontal">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-6 row">
                                                        <label class="control-label col-md-3 p-0"><%= MyBase.GetResourceString("C_Project") %> Name :</label>
                                                        <span id="ProjectName" class="col-md-9"><%--Corporate View--%></span>
                                                    </div>
                                                    <div class="col-md-6 row">&nbsp;</div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-6 row">
                                                        <label class="control-label col-md-3 p-0"><%= MyBase.GetResourceString("C_View_Applied") %> :</label>
                                                        <span id="viewApplied" class="col-md-9"><%--Corporate View--%></span>
                                                    </div>
                                                    <div class="col-md-6 row">&nbsp;</div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-6 row">
                                                        <label class="control-label col-md-3 p-0"><%= MyBase.GetResourceString("C_From_Status") %> :</label>
                                                        <span id="fromStatusSelected" class="col-md-9"><%--Submitted--%></span>
                                                    </div>
                                                    <div class="col-md-6 row">
                                                        <label class="control-label col-md-3 p-0"><%= MyBase.GetResourceString("C_To_Status") %> :</label>
                                                        <span id="toStatusSelected" class="col-md-9"><%--In Progress--%></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-6 row">
                                                        <label class="control-label col-md-3 p-0"><%= MyBase.GetResourceString("C_From_Date") %> :</label>
                                                        <span id="selectedFromDate" class="col-md-9"><%--Jan01, 2016--%></span>
                                                    </div>
                                                    <div class="col-md-6 row">
                                                        <label class="control-label col-md-3 p-0"><%= MyBase.GetResourceString("C_To_Date") %> :</label>
                                                        <span id="selectedToDate" class="col-md-9"><%--Dec 31, 2016--%></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                                <div class="table-outer" id="idview">
                                    <%--<table id=" " class="table table-bordered table-fixed-header issuelisttable " style='height: 360px; display: block; overflow: scroll; width: 100%'>--%>
                                    <table id="ViewDataTable" class="table table-bordered table-fixed-header issuelisttable datatables" <%--style="display:block;overflow:auto;height:360px;"--%>>
                                        <thead>

                                            <tr>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%--<tr>
                                                <%-- <td colspan="8">There are no items to show in this view</td>--%>
                                            <%-- </tr>--%>
                                        </tbody>
                                    </table>
                                </div>
                                <br />
                                <br />
                                <p><strong><%= MyBase.GetResourceString("C_IMPORTANT_NOTE") %></strong> :<%= MyBase.GetResourceString("C_IMPORTANT_NOTE_VALUE") %> </p>
                            </div>


                            <br />
                            <br />
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>


                        <!--SISReport-->
                        <div id="SISReport" style="display: none;">
                            <div class="col-md-12 pt-1">
                                <h4><%= MyBase.GetResourceString("C_System_Issue_Status_report") %></h4>
                            </div>
                            <div class="clearfix"></div>
                            <div class="container-fluid pt-1 pb-1 headertopp">
                                <%--graybg--%>
                                <ul class="headernavlist pull-right">
                                    <li><a href="javascript:;" class="closeviewreport" onclick="closeviewreport()"><%= MyBase.GetResourceString("C_Close") %></a>
                                    </li>
                                    <%--  <li><a href="">?</a>--%>
                                    </li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>

                            <div class="col-md-12">
                                <div class="box box-panel box-solid">
                                    <div class="box-body customformpanel">
                                        <div class="col-md-6 col-sm-offset-3">
                                            <label class="control-label col-sm-5 pt-Onehalf" style="width:36%"><%= MyBase.GetResourceString("C_Changed_From_Status") %></label>
                                            <div class="col-sm-6 pl-0">
                                                <%--Commented And Added By Usha Pandit On 18.03.2020 For showing placeholder--%>
                                                <%--<%CommonFunctions.HTMLControls.DrawComboBox("ddlChangedFromStatus", "EXEC usp_Whizible2_sel_tbl_IB_Status_For_Status_StatusOfStatus ",,, "class='form-control selectpicker'", 200) %>--%>
                                               <%--Commented And Added Rutuja D. On 18 Jan 2021 For showing placeholder IssueID=29006--%>
                                                <%--<%CommonFunctions.HTMLControls.DrawComboBox("ddlChangedFromStatus", "EXEC usp_Whizible2_sel_tbl_IB_Status_For_Status_StatusOfStatus ",,, "class='form-control selectpicker'", False) %>--%>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("ddlChangedFromStatus", "EXEC usp_Whizible2_sel_tbl_IB_Status_For_Status_StatusOfStatus ",,, "class='form-control'", False) %>
                                                <%--End Of Commented And Added By Rutuja D. On 18 Jan 2021 For showing placeholder IssueID=29006--%>
                                                <%--End Of Added By Usha Pandit On 18.03.2020 For showing placeholder--%>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                        <br />
                                        <br />
                                        <br />
                                        <br />

                                        <div class="row">
                                            <div class="col-sm-8">
                                                <div class="box box-panel box-solid chartbox">
                                                    <div class="box-header boxheaderblue with-border">
                                                        <h3><%= MyBase.GetResourceString("C_System_Issue_Status_report") %></h3>
                                                    </div>
                                                    <div id="canvasId" class="box-body">
                                                        <canvas id="SISreportchart" width="200" height="80"></canvas>
                                                    </div>

                                                </div>

                                            </div>

                                            <div class="col-sm-4">
                                                <div class="SIStable">
                                                    <table id="tblStsCount" class="table table-stripped">
                                                        <thead>
                                                            <tr>
                                                                <th><%= MyBase.GetResourceString("C_Status") %></th>
                                                                <th><%= MyBase.GetResourceString("C_Count") %></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="datatbody">
                                                        </tbody>
                                                    </table>
                                                </div>

                                            </div>

                                        </div>


                                    </div>
                                </div>
                            </div>



                        </div>
                        <!--SISReport_end-->




                    </div>
                    <div class="clearfix"></div>
                </div>
            </section>
            <!-- /.content -->
            <!-- Modal -->



            <!--modalendhere-->
        </div>



    <!-- ./wrapper -->
    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>--%>
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/multiselect.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.bundle.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/utils.js"></script>
   <%-- <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js" type="text/javascript"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js" type="text/javascript"></script>
    <%--<script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>

    <script type="text/javascript">
        var viewApplied;


      

        //change date format
        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };


        $(function () {
            $("#datepicker, #datepicker1").datepicker({
                autoclose: true,
                changeMonth: true,
                dateFormat: 'dd M yy',
                onSelect: function (date, datepicker) {
                    $('.tooltip').removeClass('show');
                }//Added by pradip on 27-1-2023
            });
           
            $("th span, .ui-corner-all").hover(function () {              
                $('th span, .ui-corner-all').tooltip('update');
            });
        });

        $(document).ready(function () {

            var selected;
            StartLoader("#idDashboardBody");

            //Added By Dipali V On 16th April 2020 For hide tooltip
            $('body').tooltip({
                selector: '[data-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
           //End of Added By Dipali V On 16th April 2020 For hide tooltip


            viewApplied = '<%=ViewApplied%>';
            windowWidth = $(window).width();
           // windowheight = $(window).height();
            //    alert(windowWidth);
            //   alert(windowheight);

            //$("#maindiv").css("height", windowheight);
            ////$("#maindiv").css("width", windowWidth);
            //$("#maindiv").css("overflow", "auto");

              //to make scrollbar resizable
        //$(window).on('load resize scroll', function () {
        //    if ($(this).width() != windowWidth && $(this).height() != windowheight) {
        //        windowWidth = $(this).width();
        //        windowheight = $(this).height();
               
        //        $('#maindiv').css({'height': windowheight - 178,"overflow-y":"auto"}); 

        //    }
        //});

            
//dynamically set height
function resizeSection() {
    var windowheight =$(window).height();
$('#frmNewVersion').css({'height': windowheight - 178,"overflow-y":"auto"}); 
}

 $(window).on("load resize scroll",function(e){
    resizeSection(this);
    });




            var strUrl = '<% = System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

            var selectedProject = getUrlVars()["ProjectID"];
            //alert(selectedProject);
            var logintype = '<%=Session("LoginType") %>';

            var userID = '<%=Session("intUserID") %>';

            var SessionProjId = '<%=Session("IssueProject") %>';
            //  alert(SessionProjId);
            var SelectedProjectName;

            var ProjectID = "";;

            if (selectedProject == 0) {
                ProjectID = unescape(SessionProjId);
            }
            else {
                ProjectID = unescape(SessionProjId);
            }
            // debugger;
            //Call the function to get the session project name.
            //alert(selectedProject);
            GetSessionProjectName(ProjectID);

           <%-- var pkToken = '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>';
            alert(pkToken);--%>

            //Function for getting the tooltip on mouseenter on the Project Title
            $(" #sessionProjectName ").mouseenter(function () {
                var word = SelectedProjectName;
                $(" #sessionProjectName").attr('title', word);
            });


            //Call the function to get the Name of views related to the Project
            GetViewNames();

            //Function for to get the Selected Project Name from IB_IssueList.aspx page using query string
            function getUrlVars() {
                var vars = [], hash;
                var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < hashes.length; i++) {
                    hash = hashes[i].split('=');
                    vars.push(hash[0]);
                    vars[hash[0]] = hash[1];
                }
                return vars;
            }


            // Function to get the Name of the session project
            function GetSessionProjectName(ProjectID) {

                $.ajax({

                    url: strUrl + '/api/IB_Dashboard/GetSessionProjectName',
                    method: 'Post',
                    data: JSON.stringify(ProjectID),
                    dataType: 'json',
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                         xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                        }
                    },
                    success: function (ProjectName) {
                        // alert(ProjectName);
                        SelectedProjectName = ProjectName;
                        $("#sessionProjectName").empty();
                        $("#sessionProjectName").text(ProjectName);
                    },
                    error: function (error) {

                    }
                });
            }


            //Function for to get the view names to selected project 
            function GetViewNames() {

                var UserData = new Array();
                UserData.ProjectID = ProjectID;
                UserData.LoginType = logintype;
                UserData.UserId = userID;
                //Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
                //var ProjectData = [UserData.ProjectID, UserData.LoginType, UserData.UserId];
                var ProjectData = {
                    ProjectID: UserData.ProjectID,
                    LoginType: UserData.LoginType,
                    UserId: UserData.UserId
                };
                 //End of Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
                //alert(ProjectData);
                $.ajax({
                    url: strUrl + '/api/IB_Dashboard/GetViews',
                    method: "POST",
                    dataType: 'json',
                    data: JSON.stringify(ProjectData),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                         xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectData) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectData) ? ProjectData : JSON.stringify(ProjectData)));
                        }
                    },
                    success: function (ViewData) {
                        // debugger
                        for (var i = 0; i < ViewData.length; i++) {
                            var listViews = ViewData[i];
                            var s = ('<option value=' + listViews.ProjectViewID + ' >' + listViews.ViewName + '</option>');
                            $("#cboviewToApply").append(s);

                        }
                    }
                });
            }

              //added by dipali V on 3rd oct 2019 for validation
            function validation() {
                //debugger
                selectedchangedFromSts = $('#cbochangedFromStatus option:selected').text();
                selectedchangedToSts = $('#cbochangedToStatus option:selected').text();

                var selectedView = $("#cboviewToApply option:selected").text();

                selectedFromDate = $('#datepicker').val();
                selectedToDate = $('#datepicker1').val();
                //$("#fromStatusSelected").append(selectedchangedFromSts);

                //$("#toStatusSelected").append(selectedchangedToSts);


                //$("#viewApplied").append(selectedView);

                //$("#selectedFromDate").append(selectedFromDate);

                //$("#selectedToDate").append(selectedToDate);
                $("#ProjectName").text(SelectedProjectName);
                //Validation part for the controls
                var checkval = 0;
                if (selectedchangedFromSts == "Select Changed From Status") {



                    alertify.error('<%= MyBase.GetResourceString("C_Please_Select_The_Changed_From_Status") %>');
                    alertify.set('notifier', 'position', 'top-right');
                    //Added by Dipali V On 20th Aug 2019
                    $("#cbochangedFromStatus").focus();
                    checkval = 1;
                    return checkval
                    //$("#dashviewreport").fade('slow');

                }
                if (selectedchangedToSts == "Select Changed To Status") {

                    alertify.error('<%= MyBase.GetResourceString("C_Please_Select_The_Changed_To_Status") %>');
                    alertify.set('notifier', 'position', 'top-right');
                    //Added by Dipali V On 20th Aug 2019
                    $("#cbochangedToStatus").focus();
                    //$("#dashviewreport").fade('slow');
                    checkval = 1;
                    return checkval
                }
                if (selectedchangedFromSts == selectedchangedToSts) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%= MyBase.GetResourceString("C_From_Status_And_To_Status_Cannot_Be_Same") %>');
                    //Added by Dipali V On 20th Aug 2019
                    $("#cbochangedToStatus").focus();
                    //$("#dashviewreport").fade('slow');
                    checkval = 1;
                    return checkval
                }
                if (selectedFromDate == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%= MyBase.GetResourceString("C_Please_Enter_From_Date") %>');
                    //Added by Dipali V On 20th Aug 2019
                    $("#datepicker").focus();
                    checkval = 1;
                    return checkval
                    //  $("#dashviewreport").fade('slow');
                }
                if (selectedToDate == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%= MyBase.GetResourceString("C_Please_Enter_To_Date") %>');
                    //Added by Dipali V On 20th Aug 2019
                    $("#datepicker1").focus();
                    //$("#dashviewreport").fade('slow');
                    checkval = 1;
                    return checkval
                }
                if (selectedView == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%= MyBase.GetResourceString("C_Please_Select_View_To_Apply") %>');
                    $("#cboviewToApply").focus();
                    //$("#dashviewreport").fade('slow');
                    checkval = 1;
                    return checkval

                }
                //if (selectedFromDate == selectedToDate) {
                //    alertify.error("From Date and To Date can not be same!");
                //    //Added by Dipali V On 20th Aug 2019
                //    $("#datepicker1").focus();
                //    // $("#dashviewreport").fade('slow');
                //    checkval = 1;
                //    return checkval
                //}
                var dtFrom = new Date(selectedFromDate);
                var dtTo = new Date(selectedToDate);
                if (dtFrom > dtTo) {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("From Date can not be greater than To Date!");
                    //Added by Dipali V On 20th Aug 2019
                    $("#datepicker").focus();
                    //$("#dashviewreport").fade('slow');
                    checkval = 1;
                    return checkval
                }
                return checkval;

            }
             //End of added by dipali V on 3rd oct 2019 for validation

            //To view the status based report
            var selectedchangedFromSts, selectedchangedToSts, selectedFromDate, selectedToDate;
            $("#dashviewreportlink").click(function () {
                //debugger;
                $("#viewApplied").empty();
                $("#fromStatusSelected").empty();
                $("#toStatusSelected").empty();
                $("#selectedFromDate").empty();
                $("#selectedToDate").empty();

                selectedchangedFromSts = $('#cbochangedFromStatus option:selected').text();
                selectedchangedToSts = $('#cbochangedToStatus option:selected').text();

                var selectedView = $("#cboviewToApply option:selected").text();

                selectedFromDate = $('#datepicker').val();
                selectedToDate = $('#datepicker1').val();
                $("#fromStatusSelected").text(selectedchangedFromSts);

                $("#toStatusSelected").text(selectedchangedToSts);


                $("#viewApplied").text(selectedView);

                $("#selectedFromDate").text(selectedFromDate);

                $("#selectedToDate").text(selectedToDate);
                $("#ProjectName").text(SelectedProjectName);
                //Validation part for the controls
                <%--var checkval = 0;
                if (selectedchangedFromSts == "")
                {



                    alertify.error('<%= MyBase.GetResourceString("C_Please_Select_The_Changed_From_Status") %>');
                    alertify.set('notifier', 'position', 'top-right');
                    //Added by Dipali V On 20th Aug 2019
                    $("#cbochangedFromStatus").focus();
                    checkval = 1;
                    //$("#dashviewreport").fade('slow');

                }
                 if (selectedchangedToSts == "") {

                    alertify.error('<%= MyBase.GetResourceString("C_Please_Select_The_Changed_To_Status") %>');
                    alertify.set('notifier', 'position', 'top-right');
                    //Added by Dipali V On 20th Aug 2019
                    $("#cbochangedToStatus").focus();
                    //$("#dashviewreport").fade('slow');
                       checkval = 1;
                }
                 if (selectedchangedFromSts == selectedchangedToSts) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%= MyBase.GetResourceString("C_From_Status_And_To_Status_Cannot_Be_Same") %>');
                    //Added by Dipali V On 20th Aug 2019
                    $("#cbochangedToStatus").focus();
                    //$("#dashviewreport").fade('slow');
                       checkval = 1;
                }
                 if (selectedFromDate == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%= MyBase.GetResourceString("C_Please_Enter_From_Date") %>');
                    //Added by Dipali V On 20th Aug 2019
                    $("#datepicker").focus();
                       checkval = 1;
                  //  $("#dashviewreport").fade('slow');
                }
                 if (selectedToDate == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%= MyBase.GetResourceString("C_Please_Enter_To_Date") %>');
                    //Added by Dipali V On 20th Aug 2019
                    $("#datepicker1").focus();
                    //$("#dashviewreport").fade('slow');
                       checkval = 1;
                }
                 if (selectedView == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%= MyBase.GetResourceString("C_Please_Select_View_To_Apply") %>');
                    $("#cboviewToApply").focus();
                    //$("#dashviewreport").fade('slow');
                       checkval = 1;

                }
                 if (selectedFromDate == selectedToDate) {
                    alertify.error("From Date and To Date can not be same!");
                    //Added by Dipali V On 20th Aug 2019
                    $("#datepicker1").focus();
                   // $("#dashviewreport").fade('slow');
                       checkval = 1;
                }
                 if (selectedFromDate > selectedToDate) {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("From Date can not be greater than To Date!");
                    //Added by Dipali V On 20th Aug 2019
                    $("#datepicker").focus();
                    //$("#dashviewreport").fade('slow');
                       checkval = 1;
                }--%>
                 //added by dipali V on 3rd oct 2019 for validation
                if (validation() == 0) {
                    var viewID = $("#cboviewToApply option:selected").val();
                    StartLoader("#idDashboardBody");
                    //Call the function to get the Column headers
                    //debugger;
                    //alert(checkval);
                     GetTableHeader(viewID);
                    // $("#SISReportlink").click(function () {
                    $("#dashviewreport").show('slow');
                    $("#dashstatusreport").hide('slow');
                    //$("#SISReport").fadeIn('slow');
                  //  $("#dashstatusreport").hide('slow');
                  //  $("#SISReport").hide('slow');
                  //  $("#dashviewreport").fadeIn('slow');
                    //Call the funtion to get the pie chart based on the status.
                    //GetStatusReport();
                    //});
                     //End of added by dipali V on 3rd oct 2019 for validation
                    StopAjaxLoader("#idDashboardBody");
                }
            });

            //Function for get the Dynamic table headers for the table
            function GetTableHeader(viewID) {

                //Function for to insert the blank space between attached Coloumn Name such as IssueID as Issue ID
                var insert = function insert(main_string, ins_string, pos) {

                    if (typeof (pos) == "undefined") {
                        pos = 0;
                    }
                    if (typeof (ins_string) == "undefined") {
                        ins_string = '';
                    }
                    return main_string.slice(0, pos) + ins_string + main_string.slice(pos);
                }

                $.ajax({
                    url: strUrl + '/api/IB_Dashboard/GetDataByView',
                    method: "POST",
                    dataType: 'json',
                    data: JSON.stringify(viewID),
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                         xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (viewID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(viewID) ? viewID : JSON.stringify(viewID)));
                        }
                    },
                    success: function (strFieldNames) {
                        var arr = [];
                        $.each(strFieldNames, function (index, val) {
                            // debugger;
                            delimeter = val.split(',');

                            $('#ViewDataTable thead tr').empty();


                            for (var i = 0; i < delimeter.length; i++) {
                                var str = delimeter[i];
                                 //debugger;

                                if (str.indexOf("ChangeRequestName") == 0 || str.indexOf("CodedByName") == 0 || str.indexOf("Duedate") == 0 || str.indexOf("FoundInPhase") == 0 || str.indexOf("ShowToCustomer") == 0 || str.indexOf("CorrectedInVersion") == 0 || str.indexOf("CustomerIssueID") == 0 || str.indexOf("FixedInPhase") == 0 || str.indexOf("AssignToName") == 0 || str.indexOf("ShowToCustomer") == 0 || str.indexOf("ReportedInVersion") == 0) {
                                    ColoumnName = str;

                                } else {
                                    // ColoumnName = str;
                                    var count = 0, len = str.length;
                                    var cnt = 0;
                                    for (var j = 0; j < len; j++) {
                                        if (/[A-Z]/.test(str.charAt(j))) {
                                            count = str.indexOf(str.charAt(j));
                                            cnt += 1;
                                            if (count > 0 || cnt == 2) {
                                                ColoumnName = insert(str, " ", j);
                                                break;
                                            } else {
                                                ColoumnName = str;
                                            }
                                        }
                                    }
                                }
                                if (ColoumnName.indexOf("Iteration")>-1) {
                                    ColoumnName = ColoumnName.replace("Iteration", "Sprint");
                                }
                                //Added by Dipali V On 1st April 2020 For Caption issue
                                 else if (ColoumnName.indexOf("Duedate")>-1) {
                                    ColoumnName = ColoumnName.replace("Duedate", "Due Date");
                                }
                                 else if (ColoumnName.indexOf("FoundInPhase")>-1) {
                                    ColoumnName = ColoumnName.replace("FoundInPhase", "Found In Phase");
                                }else if (ColoumnName.indexOf("CorrectedInVersion")>-1) {
                                    ColoumnName = ColoumnName.replace("CorrectedInVersion", "Corrected In Version");
                                }
                                else if (ColoumnName.indexOf("CustomerIssueID")>-1) {
                                    ColoumnName = ColoumnName.replace("CustomerIssueID", "Customer Issue ID");
                                }

                                 else if (ColoumnName.indexOf("ReportedInVersion")>-1) {
                                    ColoumnName = ColoumnName.replace("ReportedInVersion", "Reported In Version");
                                }
                                      else if (ColoumnName.indexOf("FixedInPhase")>-1) {
                                    ColoumnName = ColoumnName.replace("FixedInPhase", "Fixed In Phase");
                                }
                                 else if (ColoumnName.indexOf("ShowToCustomer")>-1) {
                                    ColoumnName = ColoumnName.replace("ShowToCustomer", "Show To Customer");
                                }
                                 else if (ColoumnName.indexOf("AssignToName")>-1) {
                                    ColoumnName = ColoumnName.replace("AssignToName", "Assign To Name");
                                }
                                else if (ColoumnName.indexOf("CodedByName")>-1) {
                                    ColoumnName = ColoumnName.replace("CodedByName", "Coded By Name");
                                }
                                else if (ColoumnName.indexOf("ChangeRequestName")>-1) {
                                    ColoumnName = ColoumnName.replace("ChangeRequestName", "Change Request Name");
                                }
                                 //End of Added by Dipali V On 1st April 2020 For Caption issue
                                //Assign ToName
                                //FixedInPhase
                                //CorrectedInVersion, CustomerIssueID, FixedInPhase, FoundInPhase, ImportID, IssueID, ReportedInVersion, ShowToCustomer
                                //Added By Dipali V On 30th Sep 2019 For Customfiled should display with $ symbol
                                if (ColoumnName.indexOf("AS") > -1) {

                                    ColoumnName = ColoumnName.split("AS");
                                    str = ColoumnName[0];
                                    ColoumnName = ColoumnName[1];
                                    ColoumnName = ColoumnName.replace(/['"]+/g, '')
                                    ColoumnName = "$" + ColoumnName;
                                }
                                //End of Added By Dipali V On 30th Sep 2019 For Customfiled should display with $ symbol
                                $('#ViewDataTable thead tr').append('<th>' + ColoumnName + '</th>');


                                //arr.push(delimeter[i]);
                                arr.push(str);
                            }


                            //for (var i = 0; i < delimeter.length; i++) {

                            //    $('#ViewDataTable thead tr').append('<th>' + delimeter[i] + '</th>');


                            //    arr.push(delimeter[i]);
                            //}

                            var data1 = new Array();

                            data1.ProjectID = ProjectID;

                            data1.FromDate = selectedFromDate;
                            data1.ToDate = selectedToDate;
                            data1.FromStatus = selectedchangedFromSts;
                            data1.ToStatus = selectedchangedToSts;
                            data1.view = viewID;
                            data1.LoginType = logintype;
                            //Commented & Added by Dipali V On 6th April 2023 For Dashboard data should display
                            //data1.coloumNames = arr;
                            data1.coloumNames = arr.toString();
                            //End of Commented & Added by Dipali V On 6th April 2023 For Dashboard data should display
                            //Commented & Added By Dipali V On 3rd April 2023 
                           // var updatei = [data1.FromStatus, data1.ToStatus, data1.FromDate, data1.ToDate, data1.view, data1.ProjectID, data1.LoginType, data1.coloumNames];

                            var Update = {
                                FromStatus: data1.FromStatus,
                                ToStatus: data1.ToStatus,
                                FromDate: data1.FromDate,
                                ToDate: data1.ToDate,
                                view: data1.view,
                                ProjectID: data1.ProjectID,
                                LoginType: data1.LoginType,
                                coloumNames: data1.coloumNames,
                            };
                             //End of Commented & Added By Dipali V On 3rd April 2023 
                            //debugger;
                            //Call the function to get the data from the database
                            Getdata(Update);
                        });
                    },
                    error: function (error) {

                    }
                });

            }
            //Function for the get the data from database and bind it to the Dynamic coloumns.
            function Getdata(updatei) {
                StartLoader("#idDashboardBody");
                $.ajax({
                    url: strUrl + '/api/IB_Dashboard/GetIssues',
                    method: "POST",
                    dataType: 'json',
                    async: false,
                    data: JSON.stringify(updatei),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                         xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (updatei) {
                            xhr.setRequestHeader("Params", encryptString(isJson(updatei) ? updatei : JSON.stringify(updatei)));
                        }
                    },
                    success: function (issueList1) {

                        if (issueList1.length == 0) {
                            //Added by Dipali as per column colspan should be come
                            var tdlength = $('#ViewDataTable thead tr th').length;
                              //End of Added by Dipali as per column colspan should be come
                            $('#ViewDataTable tbody tr').empty();
                            $('#ViewDataTable ').append('<tr><td colspan="'+ tdlength +'">' + 'There are no items to show in this view' + '</td></tr>');

                        }
                        else {

                            $('#ViewDataTable tbody tr').empty();

                            $.each(issueList1, function (index, val) {

                                var listIssue = val;
                                var RowData = "";
                               
                                $.map(listIssue, function (value, key) {
                                   // debugger;
                                     if (value == "" || value == "null" || value==null) {
                                       value = 'Not Specified';
                                    }

                                    //var values = value.split("-")
                                    //var newD = values [1] + "/" + values [0] + "/" + values[2]
                                    //var d = new Date(newD);
                                    //var Isdate = moment
                                    //var myDate = new Date('12/12/1955 12:00:00 AM');
                                    RowData += '<td>' + value + '</td>';

                                });
                                StopAjaxLoader("#idDashboardBody");
                                $('#ViewDataTable tbody').append("<tr>" + RowData + "</tr>");

                            });
                        }
                        //   Pagination();
                    },

                    error: function (error) {

                    }
                });
                StopAjaxLoader("#idDashboardBody");
            }



            //On the change of the status it shows the Pie Chart.
            $('#ddlChangedFromStatus').change(function () {
                $('#SISreportchart').html(' ');
                GetStatusReport();
            });

            //On click of System Issue Status report button It shows the pie chart 
            $("#SISReportlink").click(function () {
                //added by dipali V on 3rd oct 2019 for Issue fixing
                $("#SISReport").show('slow');
                $("#dashviewreport").hide('slow');
                $("#dashstatusreport").hide('slow');
                  //End of added by dipali V on 3rd oct 2019 for Issue fixing
                GetStatusReport();
            });
            $("#reportTabclose").click(function(){	
	            $('a[href="#chartview"]').tab('show');
	        });	
            //$("#viewreport").click(function () {

            //    alert();

            //});
            //Function to get the Status details and Draw the Pie chart.
            function GetStatusReport() {
                $('#datatbody').empty();

                var SelectedChangedFromStatus = $('#ddlChangedFromStatus option:selected').text();
                //alert(SelectedChangedFromStatus);
                //var StatusData = [ProjectID, SelectedChangedFromStatus, logintype];
                //Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
                //var ProjectData = [UserData.ProjectID, UserData.LoginType, UserData.UserId];
                var StatusData = {
                    ProjectID: ProjectID,
                    LoginType: logintype ,
                    SelectedChangedFromStatus: SelectedChangedFromStatus
                };
                 //End of Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
                var Status = [];
                var NoOfIssues = [];

                $.ajax({
                    url: strUrl + '/api/IB_Dashboard/GetStatusBasedReport',
                    method: "POST",
                    dataType: 'json',
                    data: JSON.stringify(StatusData),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                         xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (StatusData) {
                            xhr.setRequestHeader("Params", encryptString(isJson(StatusData) ? StatusData : JSON.stringify(StatusData)));
                        }
                    },
                    success: function (Data) {


                        for (var i = 0; i < Data.length; i++) {

                            var d = Data[i];

                            var sts = d.Status;
                            var issues = d.NoOfIssues;
                            Status.push(sts);
                            NoOfIssues.push(issues);

                            var row1 = ('<tr><td>' + sts + '</td><td>' + issues + '</td></tr>');
                            $('#datatbody').append(row1);
                        }

                        if (Status.length == 0) {
                            $('#datatbody').append('<tr><td colspan="2">' + 'There is no items in this view.' + '</td></tr>');
                        }

                        var data = {
                            labels:
                                Status,
                            datasets: [{
                                labels:
                                    [Status],
                                data: NoOfIssues,
                                //fill: false,
                                backgroundColor: [
                                    "#7DCEA0",
                                    "#F39C12",
                                    "#BA4A00",
                                    "#7D6608",
                                    "#A04000",
                                    "#ff9124",
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],

                                borderColor: [
                                    "#FFFFFF"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };


                        $('#canvasId').empty();
                        $('#canvasId').html(' <canvas id="SISreportchart" width="200" height="80"></canvas>'); // then load chart.
                        var ctx = $("#SISreportchart");

                        var myChart = new Chart(ctx, {
                            type: 'pie',
                            data: data
                        });
                    },

                    error: function (err) {
                        //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    }
                });
            }


            //Pagination Function Defination
            function Pagination() {
                $('#ViewDataTable').dataTable().fnDestroy();

                $('#ViewDataTable').dataTable({
                    "pageLength": 5,
                    "lengthChange": false,
                    "bFilter": false,
                    "bRetrieve": true

                });
            }




            var selected;

            var strUrl = '<% = System.Configuration.ConfigurationManager.AppSettings("WebApiUrl").ToString%>';
            StopAjaxLoader("#idDashboardBody");
        });


        //to make scrollbar resizable
        $(window).on('load resize scroll', function () {
            if ($(this).width() != windowWidth && $(this).height() != windowheight) {
                windowWidth = $(this).width();
                windowheight = $(this).height();
                //$("#maindiv").css("height", windowheight);
                //// $("#maindiv").css("width", windowWidth);
                //$("#maindiv").css("overflow", "auto");
                $('#maindiv').css({'height': windowheight - 178,"overflow-y":"auto"}); 

            }
        });

//Added By Usha Pandit On 09.06.2020 for restricting alphabates for Start Date and End Date
        function Date_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = (e.keyCode == 8 || e.keyCode == 46)
            {
                if (e.keyCode == 8 || e.keyCode == 46) {

                }
            }
            return ret;
        }
        //End Of Added By Usha Pandit On 09.06.2020 for restricting alphabates for Reported Date and time
    </script>




    <script>

        //Manjiri Code strarts here
        //nEW BAR CHART START HERE
        //nEW BAR CHART END HERE

        window.onload = function () {

            // debugger;
            getstatusdata();
            getAssinedtoStatusData();
            GetInRateOutRateGraphData();
            OnloadGetparetograph();
        }

        var myChart1;
        function getstatusdata() {
            //alert("hI");
            var arrY_AXIS = [];
            var arrX_AXIS = [];


            var cust_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];


            // debugger;
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

            // debugger;

            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (data) {
                    // debugger;

                    //alert("in success");
                    ////Added By Usha Pandit On 02.04.2020 For getting status names
                    //var arrNewX_AXIS = [];
                    //var arrNewLabelX_AXIS = [];
                    //var arrNewActualX_AXIS = [];
                    //var arrNewY_AXIS = [];
                    //var cntX_AXIS = 0;
                    ////End Of Added By Usha Pandit On 02.04.2020 For getting status names
                                       
                    for (var i = 0; i < data.length; i++) {

                        var d = data[i];

                        ////Added By Usha Pandit On 02.04.2020 For getting status names
                        //if (arrNewX_AXIS.length == 0) {
                        //    arrNewX_AXIS[cntX_AXIS] = d.X_AXIS;
                        //    arrNewLabelX_AXIS[cntX_AXIS] = d.X_AXIS;
                        //    arrNewActualX_AXIS[cntX_AXIS] = d.Name;
                        //    arrNewY_AXIS[cntX_AXIS] = d.Y_AXIS;
                        //    cntX_AXIS = cntX_AXIS + 1;
                        //}
                        //else {
                        //    var recExists = false;
                        //    for (var j = 0; j < arrNewX_AXIS.length; j++) {
                        //        if (arrNewX_AXIS[j] == d.X_AXIS) {
                        //            arrNewY_AXIS[j] = arrNewY_AXIS[j] + d.Y_AXIS;
                        //            arrNewActualX_AXIS[j] += "," + d.Name;
                        //            recExists = true;
                        //        }
                        //    }
                        //    if (recExists == false) {
                        //        arrNewX_AXIS[cntX_AXIS] = d.X_AXIS;
                        //        arrNewLabelX_AXIS[cntX_AXIS] = d.X_AXIS;
                        //        arrNewY_AXIS[cntX_AXIS] = d.Y_AXIS;
                        //        arrNewActualX_AXIS[cntX_AXIS] = d.Name;
                        //        cntX_AXIS = cntX_AXIS + 1;
                        //    }
                        //}
                        ////End Of Added By Usha Pandit On 02.04.2020 For getting status names


                        var X_AXIS = d.X_AXIS;

                        var Y_AXIS = d.Y_AXIS;
                        arrX_AXIS.push(X_AXIS);
                        arrY_AXIS.push(Y_AXIS);

                        var C_AXIS = d.Name;
                        var ope = d.op;
                        //   var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;



                        cust_arr.push(C_AXIS);
                        op_arr.push(ope);
                        // Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);


                    }

                    ////alert(arrY_AXIS.length)
                    ////  alert(arrY_AXIS);
                    ////Added By Usha Pandit On 02.04.2020 For getting status names
                    //for (var j = 0; j < arrNewX_AXIS.length; j++) {

                    //    if (arrNewActualX_AXIS[j] != "") {
                    //        arrNewX_AXIS[j] = arrNewActualX_AXIS[j] + "\n" + arrNewX_AXIS[j];
                    //    }                        
                    //}
                    ////End Of Added By Usha Pandit On 02.04.2020 For getting status names

                    if (intViewBy != 0) {

                        $('#canvas-holder').empty();
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart
                        var ctx = document.getElementById("chart-area").getContext('2d');
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: cust_arr,
                                datasets:
                                    [
                                        {
                                            label: 'Open',
                                            backgroundColor: "#caf270",
                                           // borderColor: "#caf270",
                                            data: op_arr,

                                        },
                                        {
                                            label: 'Response',
                                            backgroundColor: "#008d93",
                                            //borderColor: "#008d93",
                                            data: res_arr,
                                        },
                                        {
                                            label: 'On-Hold',
                                            backgroundColor: "#2e5468",
                                            data: onhold_arr,
                                        },
                                        {
                                            label: 'Resolved',
                                            data: resl_arr,
                                            backgroundColor: '#f4429b',
                                           // borderColor: "#f4429b",

                                        },

                                        {
                                            label: 'Acknowldegement',
                                            data: ack_arr,
                                            backgroundColor: '#FFCA28'
                                        }

                                    ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }

                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });
                    }
                    else {
                        var data = {
                            //labels:
                            //    arrNewX_AXIS,
                            //datasets: [{
                            //    labels:
                            //        [arrNewX_AXIS],
                            //    data: arrNewY_AXIS,
                             labels:
                                arrX_AXIS,
                            datasets: [{
                                labels:
                                    [arrX_AXIS],
                                data: arrY_AXIS,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],
                                borderColor: [
                                    //Commented & added By dipali  V on 7th Oct 2019 For Border -color issue
                                    //"#577DD0",
                                    //"#F98843",
                                    //"#5D8CDD",
                                    //"#FBC722",
                                    //"#5D8CDD"
                                     '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                  //End of Commented & added By dipali  V on 7th Oct 2019 For Border -color issue
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };

                        $('#canvas-holder').empty();

                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.

                        var ctx = $("#chart-area");
                        myChart1 = new Chart(ctx, {
                            type: 'doughnut',
                            data: data

                        });

                    }

                    //alert(arrY_AXIS.length);
                    //if (arrNewY_AXIS.length == 0) {
                     if (arrY_AXIS.length == 0) {
                        // debugger;
                        //alert("No data");
                        //  $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>');
                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }

                },

                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }


            });

        }

        //onload function to get AssigntoMe Status

        function getAssinedtoStatusData() {

            var arrY_AXIS = [];
            var arrX_AXIS = [];

            var cust_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];

            //
            //   debugger;
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

            //  debugger;

            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (data) {
                    ////Added By Usha Pandit On 02.04.2020 For getting status names
                    //var arrNewX_AXIS = [];
                    //var arrNewLabelX_AXIS = [];
                    //var arrNewActualX_AXIS = [];
                    //var arrNewY_AXIS = [];
                    //var cntX_AXIS = 0;
                    ////End Of Added By Usha Pandit On 02.04.2020 For getting status names
                    
                    for (var i = 0; i < data.length; i++) {

                        var d = data[i];
                        ////Added By Usha Pandit On 02.04.2020 For getting status names
                        //if (arrNewX_AXIS.length == 0) {
                        //    arrNewX_AXIS[cntX_AXIS] = d.X_AXIS;
                        //    arrNewLabelX_AXIS[cntX_AXIS] = d.X_AXIS;
                        //    arrNewActualX_AXIS[cntX_AXIS] = d.Name;
                        //    arrNewY_AXIS[cntX_AXIS] = d.Y_AXIS;
                        //    cntX_AXIS = cntX_AXIS + 1;
                        //}
                        //else {
                        //    var recExists = false;
                        //    for (var j = 0; j < arrNewX_AXIS.length; j++) {
                        //        if (arrNewX_AXIS[j] == d.X_AXIS) {
                        //            arrNewY_AXIS[j] = arrNewY_AXIS[j] + d.Y_AXIS;
                        //            arrNewActualX_AXIS[j] += "," + d.Name;
                        //            recExists = true;
                        //        }
                        //    }
                        //    if (recExists == false) {
                        //        arrNewX_AXIS[cntX_AXIS] = d.X_AXIS;
                        //        arrNewLabelX_AXIS[cntX_AXIS] = d.X_AXIS;
                        //        arrNewY_AXIS[cntX_AXIS] = d.Y_AXIS;
                        //        arrNewActualX_AXIS[cntX_AXIS] = d.Name;
                        //        cntX_AXIS = cntX_AXIS + 1;
                        //    }
                        //}
                        ////End Of Added By Usha Pandit On 02.04.2020 For getting status names

                       // var X_AXIS = d.Name + " ";
                        //var X_AXIS += " " + d.X_AXIS;
                        var X_AXIS =  d.X_AXIS;

                        var Y_AXIS = d.Y_AXIS;
                        //arrX_AXIS.push(X_AXIS);
                        //arrY_AXIS.push(Y_AXIS);
                        arrX_AXIS.push(X_AXIS);
                        arrY_AXIS.push(Y_AXIS);

                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;



                        cust_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);



                    }
                    ////Added By Usha Pandit On 02.04.2020 For getting status names
                    //for (var j = 0; j < arrNewX_AXIS.length; j++) {

                    //    if (arrNewActualX_AXIS[j] != "") {
                    //        arrNewX_AXIS[j] = arrNewActualX_AXIS[j] + "\n" + arrNewX_AXIS[j];
                    //    }                        
                    //}
                    ////End Of Added By Usha Pandit On 02.04.2020 For getting status names

                    if (intViewBy != 0) {

                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.    
                        var ctx = document.getElementById("chart-area2").getContext('2d');

                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: cust_arr,
                                datasets:

                                    [

                                        {
                                            label: 'Open',
                                            backgroundColor: "#caf270",
                                            data: op_arr,

                                        },

                                        {

                                            label: 'Close',
                                            backgroundColor: "#45c490",
                                            data: Cl_arr,
                                        },
                                        {
                                            label: 'Response',
                                            backgroundColor: "#008d93",
                                            data: res_arr,
                                        },
                                        {
                                            label: 'On-Hold',
                                            backgroundColor: "#2e5468",
                                            data: onhold_arr,
                                        },
                                        {
                                            label: 'Resolved',
                                            data: resl_arr,
                                            backgroundColor: '#f4429b'

                                        },

                                        {
                                            label: 'Acknowldegement',
                                            data: ack_arr,
                                            backgroundColor: '#FFCA28'
                                        }

                                    ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }

                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });

                    }
                    else {
                        var data = {
                            //labels:
                            //    arrNewX_AXIS,

                            //datasets: [{
                            //    labels:
                            //        [arrNewX_AXIS],
                            //    data:

                            //        arrNewY_AXIS,
                              labels:
                                arrX_AXIS,
                            datasets: [{
                                labels:
                                    [arrX_AXIS],
                                data: arrY_AXIS,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],

                                borderColor: [
                                    //"#577DD0",
                                    //"#F98843",
                                    //"#5D8CDD",
                                    //"#FBC722",
                                    //"#5D8CDD"
                                      '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>');

                        var ctx = $("#chart-area2");
                        myChart1 = new Chart(ctx, {
                            type: 'doughnut',
                            data: data
                        });


                    }
                    // alert(arrY_AXIS.length);
                    //if (arrNewY_AXIS.length == 0) {
                     if (arrY_AXIS.length == 0) {
                        // debugger;
                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }

                },

                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

        }


        function GetInRateOutRateGraphData() {
            var duration_arr = [];
            var InRate_arr = [];
            var OutRate_arr = [];
            var OutStanding_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

            //var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#inoutrate").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                //intViewBy: intViewBy,
                intDuration: intDuration,
                  //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetInRateandOutRateGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }

                },
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {

                        var d = data[i];
                        var duration = d.Duration;
                        var Inrate = d.InRate;
                        var outrate = d.OutRate;
                        var outstanding = d.OutStanding;

                        duration_arr.push(duration);
                        InRate_arr.push(Inrate);
                        OutRate_arr.push(outrate);
                        OutStanding_arr.push(outstanding);

                    }
                    var lineChartData1 = {}
                    lineChartData1 = {
                        labels: duration_arr,
                        datasets: [{
                            label: "In Rate [ Created ]",
                            borderColor: window.chartColors.orange,
                            backgroundColor: window.chartColors.orange,
                            fill: false,
                            data: InRate_arr,
                            //yAxisID: "y-axis-1",
                        }, {
                            label: "Out Rate [ Closed ]",
                            borderColor: window.chartColors.green,
                            backgroundColor: window.chartColors.green,
                            fill: false,
                            data: OutRate_arr,
                            //yAxisID: "y-axis-2"
                        }, {
                            label: "Outstanding [Not Closed]",
                            borderColor: window.chartColors.red,
                            backgroundColor: window.chartColors.red,
                            fill: false,
                            data: OutStanding_arr,
                            //yAxisID: "y-axis-3"
                        }]
                    }

                    //alert(lineChartData1);
                    $('#canvas-holder3').empty();
                    $('#canvas-holder3').html('<canvas id="chart-0" height="100"></canvas>'); // then load chart.

                    var ctx8 = document.getElementById("chart-0").getContext("2d");
                    var InOutRateChart = new Chart(ctx8, {
                        type: 'line',
                        data: lineChartData1,
                        options: options,
                        //{
                        responsive: true,
                        scales: {
                            yAxes: [{
                                display: true,
                                position: "left",
                            }],
                        },

                        //}
                    })

                    var options = {
                        maintainAspectRatio: false,
                        spanGaps: false,
                        elements: {
                            line: {
                                tension: 0.000001
                            }
                        },
                        scales: {
                            yAxes: [{
                                stacked: true
                            }]
                        },
                        plugins: {
                            filler: {
                                propagate: false
                            },
                        }
                    };
                },

                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes

                }
            });

        }




        function OnloadGetparetograph() {
            var mychart1;
            //alert("Hii");
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            var html = "";
            var intViewBy = $("#pareto").find(':selected').val();

            var statusparameter =
            {
                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          

            };
            var entity_arr = [];
            var entity_count_arr = [];
            var percent_arr = [];

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetParetoAnalysisGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));

                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        var entity = d.Entity;
                        var entitycount = d.EntityCount;
                        var percent = d.PercentCount;

                        entity_arr.push(entity);
                        entity_count_arr.push(entitycount);
                        percent_arr.push(percent);
                        //OutStanding_arr.push(outstanding);

                    }

                    var config1 = {
                        type: 'bar',
                        data: {
                            labels: entity_arr,
                            datasets: [{
                                type: 'line',
                                label: 'Cumulative Percentage',
                                borderColor: '#80ff80',
                                borderWidth: 2,
                                fill: false,
                                data: percent_arr,
                                yAxisID: "y-axis-2",
                            }, {

                                type: 'bar',
                                label: $("#pareto").find(':selected').text(),
                                backgroundColor: '#005ce6',
                                data: entity_count_arr,
                                borderColor: 'white',
                                borderWidth: 2,
                                yAxisID: "y-axis-1",
                            }]
                        },
                        options: {
                            responsive: true,
                            scales: {
                                xAxes: [{
                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90
                                    }
                                }],
                                yAxes: [{
                                    type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                    display: true,
                                    position: "left",
                                    id: "y-axis-1",
                                    scaleLabel: {
                                        display: true,
                                        labelString: 'Issue Count'
                                    }
                                }, {
                                    type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                    display: true,
                                    position: "right",
                                    id: "y-axis-2",
                                    scaleLabel: {
                                        display: true,
                                        labelString: 'cumulative % (0-100%)'
                                    }
                                }],
                            }
                        }
                    };

                    //alert(config1);

                    $('#canvas-holder4').empty();
                    $('#canvas-holder4').html('<canvas id="mixedChart" height="100"></canvas>'); // then load chart.

                    var ctx = document.getElementById("mixedChart").getContext("2d");
                    var temp = jQuery.extend(true, {}, config1);

                    temp.type = 'bar';
                    mychart1 = new Chart(ctx, temp);
                    // alert(mychart1);


                },

                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });
        }

        function GetYearInOutRategraph() {
            var mylist = document.getElementById("inoutrate");
            var entity = mylist.options[mylist.selectedIndex].value;

            //alert(entity);         
            var duration_arr = [];
            var InRate_arr = [];
            var OutRate_arr = [];
            var OutStanding_arr = [];
            // debugger;
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

            // debugger;

            //var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#inoutrate").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                //intViewBy: intViewBy,
                intDuration: intDuration,
                  //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };
            //alert(intDuration);

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetInRateandOutRateGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (data) {

                    for (var i = 0; i < data.length; i++) {

                        var d = data[i];
                        var duration = d.Duration;
                        var Inrate = d.InRate;
                        var outrate = d.OutRate;
                        var outstanding = d.OutStanding;

                        duration_arr.push(duration);
                        InRate_arr.push(Inrate);
                        OutRate_arr.push(outrate);
                        OutStanding_arr.push(outstanding);

                    }
                    var lineChartData1 = {}
                    lineChartData1 = {
                        labels: duration_arr,
                        datasets: [{
                            label: "In Rate [ Created ]",
                            borderColor: window.chartColors.orange,
                            backgroundColor: window.chartColors.orange,
                            fill: false,
                            data: InRate_arr,
                            //yAxisID: "y-axis-1",
                        }, {
                            label: "Out Rate [ Closed ]",
                            borderColor: window.chartColors.green,
                            backgroundColor: window.chartColors.green,
                            fill: false,
                            data: OutRate_arr,
                            //yAxisID: "y-axis-2"
                        }, {
                            label: "Outstanding [Not Closed]",
                            borderColor: window.chartColors.red,
                            backgroundColor: window.chartColors.red,
                            fill: false,
                            data: OutStanding_arr,
                            //yAxisID: "y-axis-3"
                        }]
                    }

                    //alert(lineChartData1);
                    $('#canvas-holder3').empty();
                    $('#canvas-holder3').html('<canvas id="chart-0" height="100"></canvas>'); // then load chart.

                    var ctx8 = document.getElementById("chart-0").getContext("2d");

                    var InOutRateChart = new Chart(ctx8, {
                        type: 'line',
                        data: lineChartData1,
                        options: options,
                        //{
                        responsive: true,
                        scales: {
                            yAxes: [{
                                display: true,
                                position: "left",
                            }],
                        },

                        //}
                    })
                    var options = {
                        maintainAspectRatio: false,
                        spanGaps: false,
                        elements: {
                            line: {
                                tension: 0.000001
                            }
                        },
                        scales: {
                            yAxes: [{
                                stacked: true
                            }]
                        },
                        plugins: {
                            filler: {
                                propagate: false
                            },
                        }
                    };

                },


                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }

            });

        }


        function GetYearInOutRategraph1() {
            StartLoader("#idDashboardBody");
            $('#qtrinoutrate').val(0);
            // forgettingQuarters();
            $('#monthid').val(0);

            var duration_arr = [];
            var InRate_arr = [];
            var OutRate_arr = [];
            var OutStanding_arr = [];
            //  debugger;
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            var intDuration = $("#inoutrate1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                //intViewBy: intViewBy,
                intDuration: intDuration,
                   //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
                
            };
            //alert(intDuration);
            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetInRateandOutRateGraph1',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }

                },
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];


                        var duration = d.Duration;
                        var Inrate = d.InRate;
                        var outrate = d.OutRate;
                        var outstanding = d.OutStanding;

                        duration_arr.push(duration);
                        InRate_arr.push(Inrate);
                        OutRate_arr.push(outrate);
                        OutStanding_arr.push(outstanding);

                    }
                    var lineChartData1 = {}
                    lineChartData1 = {
                        labels: duration_arr,
                        datasets: [{
                            label: "In Rate [ Created ]",
                            borderColor: window.chartColors.orange,
                            backgroundColor: window.chartColors.orange,
                            fill: false,
                            data: InRate_arr,
                            //yAxisID: "y-axis-1",
                        }, {
                            label: "Out Rate [ Closed ]",
                            borderColor: window.chartColors.green,
                            backgroundColor: window.chartColors.green,
                            fill: false,
                            data: OutRate_arr,
                            //yAxisID: "y-axis-2"
                        }, {
                            label: "Outstanding [Not Closed]",
                            borderColor: window.chartColors.red,
                            backgroundColor: window.chartColors.red,
                            fill: false,
                            data: OutStanding_arr,
                            //yAxisID: "y-axis-3"
                        }]
                    }


                    //alert(lineChartData1);
                    $('#canvas-holder3').empty();
                    $('#canvas-holder3').html('<canvas id="chart-0" height="100"></canvas>'); // then load chart.
                    var ctx8 = document.getElementById("chart-0").getContext("2d");
                    //Commented & Added By Dipali V On 6th July 2023 For month Placeholder issue
                    //$("#monthid").val("0");
                    $("#monthid").val("Select Month");
                     //End of Commented & Added By Dipali V On 6th July 2023 For month Placeholder issue
                    var InOutRateChart = new Chart(ctx8,
                        {
                            type: 'line',
                            data: lineChartData1,
                            options: options,
                            //{
                            responsive: true,
                            scales: {
                                yAxes: [{
                                    display: true,
                                    position: "left",
                                }],
                            },

                            //}
                        })
                    var options = {
                        maintainAspectRatio: false,
                        spanGaps: false,
                        elements: {
                            line: {
                                tension: 0.000001
                            }
                        },
                        scales: {
                            yAxes: [{
                                stacked: true
                            }]
                        },
                        plugins: {
                            filler: {
                                propagate: false
                            },
                        }
                    };

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

            StopAjaxLoader("#idDashboardBody");
        }

        function getqtrrefreshed() {

            //debugger;
        }

        function GetYearInOutRategraph2() {
            StartLoader("#idDashboardBody");
            var mylist = document.getElementById("months");
            var entity = mylist.options[mylist.selectedIndex].value;
            var duration_arr = [];
            var InRate_arr = [];
            var OutRate_arr = [];
            var OutStanding_arr = [];
            //debugger;
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            var intDuration = $("#months").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                //intViewBy: intViewBy,
                intDuration: intDuration,
                  //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };
            //alert(intDuration);

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetInRateandOutRateGraph2',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {

                        var d = data[i];

                        var duration = d.Duration;
                        var Inrate = d.InRate;
                        var outrate = d.OutRate;
                        var outstanding = d.OutStanding;

                        duration_arr.push(duration);
                        InRate_arr.push(Inrate);
                        OutRate_arr.push(outrate);
                        OutStanding_arr.push(outstanding);

                    }
                    var lineChartData1 = {}
                    lineChartData1 = {
                        labels: duration_arr,
                        datasets: [{
                            label: "In Rate [ Created ]",
                            borderColor: window.chartColors.orange,
                            backgroundColor: window.chartColors.orange,
                            fill: false,
                            data: InRate_arr,
                            //yAxisID: "y-axis-1",
                        }, {
                            label: "Out Rate [ Closed ]",
                            borderColor: window.chartColors.green,
                            backgroundColor: window.chartColors.green,
                            fill: false,
                            data: OutRate_arr,
                            //yAxisID: "y-axis-2"
                        }, {
                            label: "Outstanding [Not Closed]",
                            borderColor: window.chartColors.red,
                            backgroundColor: window.chartColors.red,
                            fill: false,
                            data: OutStanding_arr,
                            //yAxisID: "y-axis-3"
                        }]
                    }
                    //alert(lineChartData1);
                    $('#canvas-holder3').empty();
                    $('#canvas-holder3').html('<canvas id="chart-0" height="100"></canvas>'); // then load chart.

                    var ctx8 = document.getElementById("chart-0").getContext("2d");

                    var InOutRateChart = new Chart(ctx8, {
                        type: 'line',
                        data: lineChartData1,
                        options: options,
                        //{
                        responsive: true,
                        scales: {
                            yAxes: [{
                                display: true,
                                position: "left",
                            }],
                        },

                    })
                    var options = {
                        maintainAspectRatio: false,
                        spanGaps: false,
                        elements: {
                            line: {
                                tension: 0.000001
                            }
                        },
                        scales: {
                            yAxes: [{
                                stacked: true
                            }]
                        },
                        plugins: {
                            filler: {
                                propagate: false
                            },
                        }
                    };

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes

                }
            });
            StopAjaxLoader("#idDashboardBody");
        }


        function getquarter1data()
        {
            StartLoader("#idDashboardBody");
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            var html = "";
            var Intyear = $("#inoutrate1").find(':selected').text();
            var intqtrduration = $("#qtrinoutrate").find(':selected').val();
            if (intqtrduration != 0) {
                GetYearInOutRategraph3();

                var statusparameter =
                {
                    intUserID: '<%= Session("intUserID") %>',
                    Intyear: Intyear,
                    intqtrduration: intqtrduration,
                      //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
                };
                var duration_arr = [];
                var InRate_arr = [];
                var OutRate_arr = [];
                var OutStanding_arr = [];

                $.ajax({
                    url: strUrl + '/api/IB_Dashboard/GetInRateandOutRateGraph3',
                    type: "POST",
                    data: JSON.stringify(statusparameter),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    // async:false,
                    beforeSend: function (xhr) {
                         xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (statusparameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                        }
                    },
                    success: function (data) {
                        for (var i = 0; i < data.length; i++) {
                            var d = data[i];
                            var duration = d.Duration;
                            var Inrate = d.InRate;
                            var outrate = d.OutRate;
                            var outstanding = d.OutStanding;

                            duration_arr.push(duration);
                            InRate_arr.push(Inrate);
                            OutRate_arr.push(outrate);
                            OutStanding_arr.push(outstanding);

                        }

                        var lineChartData1 = {}
                        lineChartData1 = {
                            labels: duration_arr,
                            datasets: [{
                                label: "In Rate [ Created ]",
                                borderColor: window.chartColors.orange,
                                backgroundColor: window.chartColors.orange,
                                fill: false,
                                data: InRate_arr,
                                //yAxisID: "y-axis-1",
                            }, {
                                label: "Out Rate [ Closed ]",
                                borderColor: window.chartColors.green,
                                backgroundColor: window.chartColors.green,
                                fill: false,
                                data: OutRate_arr,
                                //yAxisID: "y-axis-2"
                            }, {
                                label: "Outstanding [Not Closed]",
                                borderColor: window.chartColors.red,
                                backgroundColor: window.chartColors.red,
                                fill: false,
                                data: OutStanding_arr,
                                //yAxisID: "y-axis-3"
                            }]
                        }

                        //alert(lineChartData1);
                        $('#canvas-holder3').empty();
                        $('#canvas-holder3').html('<canvas id="chart-0" height="100"></canvas>'); // then load chart.

                        var ctx8 = document.getElementById("chart-0").getContext("2d");

                        var InOutRateChart = new Chart(ctx8, {
                            type: 'line',
                            data: lineChartData1,
                            options: options,
                            //{
                            responsive: true,
                            scales: {
                                yAxes: [{
                                    display: true,
                                    position: "left",
                                }],
                            },

                            //}
                        })
                        var options = {
                            maintainAspectRatio: false,
                            spanGaps: false,
                            elements: {
                                line: {
                                    tension: 0.000001
                                }
                            },
                            scales: {
                                yAxes: [{
                                    stacked: true
                                }]
                            },
                            plugins: {
                                filler: {
                                    propagate: false
                                },
                            }
                        };

                    },


                    error: function (err) {
                        //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes

                    }



                });
                StopAjaxLoader("#idDashboardBody");
            }
            else {
                $("#monthid").html('');
                $('#monthid').append('<option value="0">Select Month</option>');
                GetYearInOutRategraph1();
                //$("#monthid").val(0);
                  StopAjaxLoader("#idDashboardBody");
            }
        }

        function GetYearInOutRategraph3() {
            StartLoader("#idDashboardBody");
            var duration_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            var html = "";

            var Intyear = $("#inoutrate1").find(':selected').text();
            var intqtrduration = $("#qtrinoutrate").find(':selected').val();
            var statusparameter =
            {

                Intyear: Intyear,
                intqtrduration: intqtrduration,
            };
            // debugger;
            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetInRateandOutRateGraph4',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (data) {

                    for (var i = 0; i < data.length; i++) {
                        var selHTML = "";
                        var d = data[i];
                        var duration = d.Duration;
                        duration_arr.push(duration);
                        selHTML += '<option value="0">' + duration_arr[0] + '</option>';
                        selHTML += '<option value="1">' + duration_arr[1] + '</option>';
                        selHTML += '<option value="2">' + duration_arr[2] + '</option>';
                        selHTML += '<option value="3">' + duration_arr[3] + '</option>';
                    }
                    $("#monthid").html(selHTML);

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes

                }

            });

            StopAjaxLoader("#idDashboardBody");
        }
        //onchane of dependent month of Quarter

        function getdependentmonthdata() {
            StartLoader("#idDashboardBody");
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            var html = "";
            // debugger;
            var years = $("#inoutrate1").find(':selected').text();
            var intqtrduration = $("#qtrinoutrate").find(':selected').val();
            var intmonth = $("#monthid").find(':selected').val();

            if (intmonth != 0) {
                var statusparameter =
                {
                    intUserID: '<%= Session("intUserID") %>',
                    years: years,
                    intqtrduration: intqtrduration,
                    intmonth: intmonth,
                      //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
                };


                var duration_arr = [];
                var InRate_arr = [];
                var OutRate_arr = [];
                var OutStanding_arr = [];

                $.ajax({
                    url: strUrl + '/api/IB_Dashboard/GetInRateandOutRateGraph5',
                    type: "POST",
                    data: JSON.stringify(statusparameter),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    // async:false,
                    beforeSend: function (xhr) {
                         xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (statusparameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                        }
                    },
                    success: function (data) {
                        for (var i = 0; i < data.length; i++) {
                            var d = data[i];
                            var duration = d.Duration;
                            var Inrate = d.InRate;
                            var outrate = d.OutRate;
                            var outstanding = d.OutStanding;

                            duration_arr.push(duration);
                            InRate_arr.push(Inrate);
                            OutRate_arr.push(outrate);
                            OutStanding_arr.push(outstanding);

                        }

                        var lineChartData1 = {}
                        lineChartData1 = {
                            labels: duration_arr,
                            datasets: [{
                                label: "In Rate [ Created ]",
                                borderColor: window.chartColors.orange,
                                backgroundColor: window.chartColors.orange,
                                fill: false,
                                data: InRate_arr,
                                //yAxisID: "y-axis-1",
                            }, {
                                label: "Out Rate [ Closed ]",
                                borderColor: window.chartColors.green,
                                backgroundColor: window.chartColors.green,
                                fill: false,
                                data: OutRate_arr,
                                //yAxisID: "y-axis-2"
                            }, {
                                label: "Outstanding [Not Closed]",
                                borderColor: window.chartColors.red,
                                backgroundColor: window.chartColors.red,
                                fill: false,
                                data: OutStanding_arr,
                                //yAxisID: "y-axis-3"
                            }]
                        }

                        //alert(lineChartData1);
                        $('#canvas-holder3').empty();
                        $('#canvas-holder3').html('<canvas id="chart-0" height="370"></canvas>'); // then load chart.

                        var ctx8 = document.getElementById("chart-0").getContext("2d");
                        var options = {
                            maintainAspectRatio: false,
                            spanGaps: false,
                            stacked: false,
                            responsive: true,
                            scales: {
                                xAxes: [{
                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90
                                    }
                                }]
                            }

                        };

                        var chart = new Chart(ctx8, {
                            type: 'line',
                            data: lineChartData1,
                            options: options
                        })


                    },
                    error: function (err) {
                        //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    }

                });
            }
            else {
                getquarter1data();
            }
            StopAjaxLoader("#idDashboardBody");
        }

        //for getting Quarters

        function forgettingQuarters() {
            StartLoader("#idDashboardBody");
            var duration_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            var html = "";
            //   debugger;
            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetInRateandOutRateGraph6',
                type: "POST",
                data: JSON.stringify(),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));

                },
                success: function (data) {

                    for (var i = 0; i < data.length; i++) {
                        var selHTML = "";
                        var d = data[i];
                        var duration = d.Duration;
                        duration_arr.push(duration);
                        selHTML += '<option value="0">' + duration_arr[0] + '</option>';
                        selHTML += '<option value="1">' + duration_arr[1] + '</option>';
                        selHTML += '<option value="2">' + duration_arr[2] + '</option>';
                        selHTML += '<option value="3">' + duration_arr[3] + '</option>';
                    }
                    $("#qtrinoutrate").html(selHTML);

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes

                }
            });
            StopAjaxLoader("#idDashboardBody");
        }


        function Getparetograph() {
            StartLoader("#idDashboardBody");
            var mychart1;
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            var html = "";
            var intViewBy = $("#pareto").find(':selected').val();

            var statusparameter =
            {
                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          

            };

            var entity_arr = [];
            var entity_count_arr = [];
            var percent_arr = [];

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetParetoAnalysisGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {

                        var d = data[i];
                        var entity = d.Entity;
                        var entitycount = d.EntityCount;
                        var percent = d.PercentCount;

                        entity_arr.push(entity);
                        entity_count_arr.push(entitycount);
                        percent_arr.push(percent);

                    }

                    var config1 = {
                        type: 'bar',
                        data: {
                            labels: entity_arr,
                            datasets: [{
                                type: 'line',
                                label: 'Cumulative Percentage',
                                borderColor: '#80ff80',
                                borderWidth: 2,
                                fill: false,
                                data: percent_arr,
                                yAxisID: "y-axis-2",
                            }, {

                                type: 'bar',
                                label: $("#pareto").find(':selected').text(),
                                backgroundColor: '#005ce6',
                                data: entity_count_arr,
                                borderColor: 'white',
                                borderWidth: 2,
                                yAxisID: "y-axis-1",
                            }]
                        },
                        options: {
                            responsive: true,
                            scales: {
                                xAxes: [{
                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90
                                    }
                                }],
                                yAxes: [{
                                    type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                    display: true,
                                    position: "left",
                                    id: "y-axis-1",
                                    scaleLabel: {
                                        display: true,
                                        labelString: 'Issue Count'
                                    }
                                }, {
                                    type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                    display: true,
                                    position: "right",
                                    id: "y-axis-2",
                                    scaleLabel: {
                                        display: true,
                                        labelString: 'cumulative % (0-100%)'
                                    }
                                }],
                            }
                        }
                    };

                    //alert(config1);

                    $('#canvas-holder4').empty();
                    $('#canvas-holder4').html('<canvas id="mixedChart" height="100"></canvas>'); // then load chart.


                    var ctx = document.getElementById("mixedChart").getContext("2d");
                    var temp = jQuery.extend(true, {}, config1);
                    temp.type = 'bar';
                    mychart1 = new Chart(ctx, temp);
                },


                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes

                }
            });
            StopAjaxLoader("#idDashboardBody");
        }



        //Onchange function on Duration Combobox Click

        function GetDurationGraph() {
            //  $("#canvas-holder").destroy();
            StartLoader("#idDashboardBody");
            var mylist = document.getElementById("duration");
            var entity = mylist.options[mylist.selectedIndex].value;
            //   $("#chart-area").destroy();
            $("#chart-area").html(' ');
            // $("#chart-area").destroy();
            switch (entity) {
                case '0': getstatusdata()
                    break;
                case '1': GetTodaysStatusData()
                    break;
                case '2': GetCurrentWeekStatusdata()
                    break;
                case '3': GetPreviousWeekStatusData()
                    break;
                case '4': GetCurrentMonthStatusdata()
                    break;
                case '5': GetPreviousMonthStatusData()
                    break;
                case '6': GetCurrentYearStatusData()
                    break;
                case '7': GetPreviousYearStatusData()
                    break;

            }
            StopAjaxLoader("#idDashboardBody");
        }
        //for Showing Statuses of Todays Date

        function GetTodaysStatusData() {
            var arrxaxis = [];
            var arryaxis = [];
            var Name_arr = [];
            var op_arr = [];
            //  var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');
            // alert("hi");
            var html = "";
            // debugger;
            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result1) {
                    //    debugger;

                    for (var i = 0; i < result1.length; i++) {
                        var d = result1[i];
                        var X_AXIS = d.X_AXIS;
                        var Y_AXIS = d.Y_AXIS;
                        arrxaxis.push(X_AXIS);
                        arryaxis.push(Y_AXIS);

                        var C_AXIS = d.Name;
                        var ope = d.op;
                        // var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;


                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        //Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);

                    }

                    if (intViewBy != 0) {

                        //  alert("In todays bar graph");
                        $('#canvas-holder').empty();
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.


                        var ctx = document.getElementById("chart-area").getContext('2d');

                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets:

                                    [

                                        {
                                            label: 'Open',
                                            backgroundColor: "#caf270",
                                            data: op_arr,
                                        },
                                        //{

                                        //    label:'Close',
                                        //    backgroundColor: "#45c490",
                                        //    data: Cl_arr,
                                        //},
                                        {
                                            label: 'Response',
                                            backgroundColor: "#008d93",
                                            data: res_arr,
                                        },
                                        {
                                            label: 'On Hold',
                                            backgroundColor: "#2e5468",
                                            data: onhold_arr,
                                        },
                                        {
                                            label: 'Resolved',
                                            data: resl_arr,
                                            backgroundColor: '#f4429b'

                                        },

                                        {
                                            label: 'Acknowledegement',
                                            data: ack_arr,
                                            backgroundColor: '#FFCA28'
                                        }

                                    ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }

                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });

                    }
                    else {
                        var result1 = {
                            labels:
                                arrxaxis,
                            datasets: [{
                                labels:
                                    [arrxaxis],
                                data: arryaxis,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                borderColor: [
                                    //"#577DD0",
                                    //"#F98843",
                                    //"#5D8CDD",
                                    //"#FBC722",
                                    //"#5D8CDD"
                                      '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder').empty();
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area");
                        var myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result1
                        });

                    }

                    if (arryaxis.length == 0) {
                        // debugger;
                        // alert("No data");
                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes

                }
            });
        }

        //for Showing CurrentWeek Statuses of Current Month
        var myChart3;
        function GetCurrentWeekStatusdata() {
            var arrxax = [];
            var arryax = [];

            var Name_arr = [];
            var op_arr = [];
            // var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');
            // debugger;
            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result) {
                    for (var i = 0; i < result.length; i++) {

                        //if (result.length != "") {
                        var d = result[i];
                        var X_AXIS = d.X_AXIS;
                        var Y_AXIS = d.Y_AXIS;
                        arrxax.push(X_AXIS);
                        arryax.push(Y_AXIS);
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        //  var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;
                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        // Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);

                    }

                    if (intViewBy != 0) {
                        $('#canvas-holder').empty();
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = document.getElementById("chart-area").getContext('2d');
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets: [{
                                    label: 'Open',
                                    backgroundColor: "#caf270",
                                    data: op_arr,
                                },
                                //{

                                //    label:'Close',
                                //    backgroundColor: "#45c490",
                                //    data: Cl_arr,
                                //},
                                {
                                    label: 'Response',
                                    backgroundColor: "#008d93",
                                    data: res_arr,
                                },
                                {
                                    label: 'On Hold',
                                    backgroundColor: "#2e5468",
                                    data: onhold_arr,
                                },
                                {
                                    label: 'Resolved',
                                    data: resl_arr,
                                    backgroundColor: '#f4429b'

                                }, {
                                    label: 'Acknowledegement',
                                    data: ack_arr,
                                    backgroundColor: '#FFCA28'
                                }

                                ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }

                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });



                    }
                    else {
                        var result1 = {
                            labels:
                                arrxax,
                            datasets: [{
                                labels:
                                    [arrxax],
                                data: arryax,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],

                                borderColor: [
                                    //"#577DD0",
                                    //"#F98843",
                                    //"#5D8CDD",
                                    //"#FBC722",
                                    //"#5D8CDD"
                                      '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder').empty();
                        // alert("empty");
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area");
                        myChart3 = new Chart(ctx, {
                            type: 'doughnut',
                            data: result1
                        });

                    }

                    if (arryax.length == 0) {
                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }


                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });
        }

        //for Showing Statuses of Previous week

        function GetPreviousWeekStatusData() {
            var arrxaxi = [];
            var arryaxi = [];

            var Name_arr = [];
            var op_arr = [];
            //  var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');
            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {
                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result) {
                    for (var i = 0; i < result.length; i++) {
                        var d = result[i];
                        var X_AXIS = d.X_AXIS;
                        //  alert(X_AXIS);
                        var Y_AXIS = d.Y_AXIS;
                        arrxaxi.push(X_AXIS);
                        arryaxi.push(Y_AXIS);
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        // var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;
                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        // Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);

                    }

                    if (intViewBy != 0) {

                        // alert("In Previous week bar graph");
                        $('#canvas-holder').empty();
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.

                        var ctx = document.getElementById("chart-area").getContext('2d');

                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets:
                                    [{
                                        label: 'Open',
                                        backgroundColor: "#caf270",
                                        data: op_arr,
                                    },
                                    //{

                                    //    label:'Close',
                                    //    backgroundColor: "#45c490",
                                    //    data: Cl_arr,
                                    //},
                                    {
                                        label: 'Response',
                                        backgroundColor: "#008d93",
                                        data: res_arr,
                                    },
                                    {
                                        label: 'On Hold',
                                        backgroundColor: "#2e5468",
                                        data: onhold_arr,
                                    },
                                    {
                                        label: 'Resolved',
                                        data: resl_arr,
                                        backgroundColor: '#f4429b'

                                    },

                                    {
                                        label: 'Acknowledegement',
                                        data: ack_arr,
                                        backgroundColor: '#FFCA28'
                                    }

                                    ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },

                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }
                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });
                    }
                    else {
                        var result = {
                            labels:
                                arrxaxi,
                            datasets: [{
                                labels:
                                    [arrxaxi],
                                data: arryaxi,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],

                                borderColor: [
                                    //"#577DD0",
                                    //"#F98843",
                                    //"#5D8CDD",
                                    //"#FBC722",
                                    //"#5D8CDD"
                                      '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder').empty();
                        // alert("empty");
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area");
                        var myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result
                        });

                    }
                    if (arryaxi.length == 0) {
                        //  debugger;
                        // alert("No data");
                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }


                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

        }

        //For Showing Statuses of Current Month

        function GetCurrentMonthStatusdata() {
            var arrx = [];
            var arry = [];

            var Name_arr = [];
            var op_arr = [];
            //var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');
            // alert("hi");
            // debugger;
            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result) {
                    // debugger;
                    //alert("In Current Month");
                    for (var i = 0; i < result.length; i++) {
                        //if (result.length != "") {
                        var d = result[i];
                        var X_AXIS = d.X_AXIS;
                        var Y_AXIS = d.Y_AXIS;
                        arrx.push(X_AXIS);
                        arry.push(Y_AXIS);
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        // var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;
                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        // Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);
                    }
                    if (intViewBy != 0) {

                        //alert("In Current month bar graph");
                        $('#canvas-holder').empty();
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = document.getElementById("chart-area").getContext('2d');
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets:

                                    [

                                        {
                                            label: 'Open',
                                            backgroundColor: "#caf270",
                                            data: op_arr,
                                        },
                                        //{

                                        //    label:'Close',
                                        //    backgroundColor: "#45c490",
                                        //    data: Cl_arr,
                                        //},
                                        {
                                            label: 'Response',
                                            backgroundColor: "#008d93",
                                            data: res_arr,
                                        },
                                        {
                                            label: 'On Hold',
                                            backgroundColor: "#2e5468",
                                            data: onhold_arr,
                                        },
                                        {
                                            label: 'Resolved',
                                            data: resl_arr,
                                            backgroundColor: '#f4429b'

                                        },

                                        {
                                            label: 'Acknowledegement',
                                            data: ack_arr,
                                            backgroundColor: '#FFCA28'
                                        }

                                    ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }
                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });

                    }
                    else {
                        var result = {
                            labels:
                                arrx,
                            datasets: [{
                                labels:
                                    [arrx],
                                data: arry,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],

                                borderColor: [
                                    //"#577DD0",
                                    //"#F98843",
                                    //"#5D8CDD",
                                    //"#FBC722",
                                    //"#5D8CDD"
                                      '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder').empty();
                        // alert("empty");
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area");
                        var myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result
                        });

                    }
                    if (arry.length == 0) {
                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });
        }

        //For Showing Statuses of Previous Month

        function GetPreviousMonthStatusData() {
            var arr_x = [];
            var arr_y = [];
            var Name_arr = [];
            var op_arr = [];
            // var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');
            // alert("hi");
            //  debugger;
            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result) {
                    for (var i = 0; i < result.length; i++) {
                        var d = result[i];
                        var X_AXIS = d.X_AXIS;
                        var Y_AXIS = d.Y_AXIS;
                        arr_x.push(X_AXIS);
                        arr_y.push(Y_AXIS);
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        //  var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;

                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        //Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);
                    }
                    if (intViewBy != 0) {

                        //alert("In Previous Month bar graph");
                        $('#canvas-holder').empty();
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = document.getElementById("chart-area").getContext('2d');
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets: [{
                                    label: 'Open',
                                    backgroundColor: "#caf270",
                                    data: op_arr,
                                },
                                //{

                                //    label:'Close',
                                //    backgroundColor: "#45c490",
                                //    data: Cl_arr,
                                //},
                                {
                                    label: 'Response',
                                    backgroundColor: "#008d93",
                                    data: res_arr,
                                },
                                {
                                    label: 'On Hold',
                                    backgroundColor: "#2e5468",
                                    data: onhold_arr,
                                },
                                {
                                    label: 'Resolved',
                                    data: resl_arr,
                                    backgroundColor: '#f4429b'

                                },

                                {
                                    label: 'Acknowledegement',
                                    data: ack_arr,
                                    backgroundColor: '#FFCA28'
                                }

                                ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }

                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });
                    }
                    else {

                        var result = {
                            labels:
                                arr_x,
                            datasets: [{
                                labels:
                                    [arr_x],
                                data: arr_y,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],

                                borderColor: [
                                    //"#577DD0",
                                    //"#F98843",
                                    //"#5D8CDD",
                                    //"#FBC722",
                                    //"#5D8CDD"
                                      '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder').empty();
                        // alert("empty");
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area");
                        var myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result
                        });

                    }

                    if (arr_y.length == 0) {
                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }

                },


                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });
        }


        //For Showing Statuses of Current Year
        var myChart;
        function GetCurrentYearStatusData() {
            var arr_xax = [];
            var arr_yax = [];
            var Name_arr = [];
            var op_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');
            //   //  alert("hi");
            //    debugger;
            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };


            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result) {
                    for (var i = 0; i < result.length; i++) {
                        var d = result[i];
                        var X_AXIS = d.X_AXIS;
                        //  alert(X_AXIS);
                        var Y_AXIS = d.Y_AXIS;
                        arr_xax.push(X_AXIS);
                        arr_yax.push(Y_AXIS);

                        var C_AXIS = d.Name;
                        var ope = d.op;
                        //  var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;

                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        // Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);
                    }
                    if (intViewBy != 0) {
                        // alert("In Current year bar graph");
                        $('#canvas-holder').empty();
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = document.getElementById("chart-area").getContext('2d');
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets: [{
                                    label: 'Open',
                                    backgroundColor: "#caf270",
                                    data: op_arr,
                                },
                                //{

                                //    label:'Close',
                                //    backgroundColor: "#45c490",
                                //    data: Cl_arr,
                                //},
                                {
                                    label: 'Response',
                                    backgroundColor: "#008d93",
                                    data: res_arr,
                                },
                                {
                                    label: 'On Hold',
                                    backgroundColor: "#2e5468",
                                    data: onhold_arr,
                                },
                                {
                                    label: 'Resolved',
                                    data: resl_arr,
                                    backgroundColor: '#f4429b'

                                },

                                {
                                    label: 'Acknowledegement',
                                    data: ack_arr,
                                    backgroundColor: '#FFCA28'
                                }

                                ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }
                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });

                    }
                    else {
                        var result = {
                            labels:
                                arr_xax,
                            datasets: [{
                                labels:
                                    [arr_xax],
                                data: arr_yax,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],

                                borderColor: [
                                    //"#577DD0",
                                    //"#F98843",
                                    //"#5D8CDD",
                                    //"#FBC722",
                                    //"#5D8CDD"
                                      '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        if (myChart) {
                            myChart.destroy();
                        }
                        $('#canvas-holder').empty();
                        // alert("empty");
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area");
                        myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result
                        });

                    }
                    if (arr_yax.length == 0) {
                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }
                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });
        }
        //For Showing Statuses of Previous Year

        function GetPreviousYearStatusData() {
            var arr_xa = [];
            var arr_ya = [];
            var Name_arr = [];
            var op_arr = [];
            //   var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');
            //alert("hi");
            //  debugger;
            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result) {
                    for (var i = 0; i < result.length; i++) {
                        var d = result[i];
                        var X_AXIS = d.X_AXIS;
                        var Y_AXIS = d.Y_AXIS;
                        arr_xa.push(X_AXIS);
                        arr_ya.push(Y_AXIS);
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        //  var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;
                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        //   Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);
                    }
                    if (intViewBy != 0) {

                        // alert("In Previous year bar graph");
                        $('#canvas-holder').empty();
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = document.getElementById("chart-area").getContext('2d');
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets: [{
                                    label: 'Open',
                                    backgroundColor: "#caf270",
                                    data: op_arr,
                                },
                                //{

                                //    label:'Close',
                                //    backgroundColor: "#45c490",
                                //    data: Cl_arr,
                                //},
                                {
                                    label: 'Response',
                                    backgroundColor: "#008d93",
                                    data: res_arr,
                                },
                                {
                                    label: 'On Hold',
                                    backgroundColor: "#2e5468",
                                    data: onhold_arr,
                                },
                                {
                                    label: 'Resolved',
                                    data: resl_arr,
                                    backgroundColor: '#f4429b'

                                },

                                {
                                    label: 'Acknowledegement',
                                    data: ack_arr,
                                    backgroundColor: '#FFCA28'
                                }

                                ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },

                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }
                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });

                    }
                    else {
                        var result1 = {
                            labels:
                                arr_xa,
                            datasets: [{
                                labels:
                                    [arr_xa],
                                data: arr_ya,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],

                                borderColor: [
                                    //"#577DD0",
                                    //"#F98843",
                                    //"#5D8CDD",
                                    //"#FBC722",
                                    //"#5D8CDD"
                                      '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder').empty();
                        // alert("empty");
                        $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area");
                        var myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result1
                        });

                    }
                    if (arr_ya.length == 0) {
                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });
        }

        function GetByTypeGraph() {
            StartLoader("#idDashboardBody");
            var mylist = document.getElementById("overall");

            var entity = mylist.options[mylist.selectedIndex].value;
            //   $("#chart-area").destroy();
            $("#chart-area").html(' ');
            switch (entity) {
                case '0': getstatusdata()
                    break;
                case '1': GetCustomerGraphData()
                    break;
                case '2': GetTypeData()
                    break;
                case '3': GetSubTypeData()
                    break;
                case '4': GetEmployeeGraphData()
                    break;
                case '5': GetPriorityData()
                    break;
            }
            StopAjaxLoader("#idDashboardBody");
        }
        var myChart;
        function GetCustomerGraphData() {
            StartLoader("#idDashboardBody");
            var Name_arr = [];
            var op_arr = [];
            // var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');
            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result10) {
                    for (var i = 0; i < result10.length; i++) {
                        var d = result10[i];
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        // var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;


                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        //Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);

                    }
                    $('#canvas-holder').empty();
                    $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                    var ctx = document.getElementById("chart-area").getContext('2d');

                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: Name_arr,
                            datasets: [{
                                label: 'Open',
                                backgroundColor: "#caf270",
                                data: op_arr,
                            },
                            //{

                            //    label:'Close',
                            //    backgroundColor: "#45c490",
                            //    data: Cl_arr,
                            //},
                            {
                                label: 'Response',
                                backgroundColor: "#008d93",
                                data: res_arr,
                            },
                            {
                                label: 'On Hold',
                                backgroundColor: "#2e5468",
                                data: onhold_arr,
                            },
                            {
                                label: 'Resolved',
                                data: resl_arr,
                                backgroundColor: '#f4429b'

                            },

                            {
                                label: 'Acknowledegement',
                                data: ack_arr,
                                backgroundColor: '#FFCA28'
                            }

                            ],
                        },
                        options: {
                            tooltips: {
                                displayColors: true,
                                callbacks: {
                                    mode: 'x',
                                },
                            },
                            scales: {
                                xAxes: [{
                                    stacked: true,
                                    gridLines: {
                                        display: false,
                                    },

                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90,
                                        beginAtZero: true,
                                        suggestedMin: 0
                                    }
                                }],
                                yAxes: [{
                                    stacked: true,
                                    ticks: {
                                        beginAtZero: true,
                                    },
                                    type: 'linear',
                                }]
                            },
                            responsive: true,
                            maintainAspectRatio: false,
                            legend: { position: 'bottom' },
                        }

                    });
                    if (cust_arr.length == 0) {
                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }
                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

            StopAjaxLoader("#idDashboardBody");
        }

        function GetTypeData() {
            StartLoader("#idDashboardBody");
            var type_arr = [];
            var op_arr = [];
            //var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');
            // alert("hi");
            //debugger;
            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result10) {
                    for (var i = 0; i < result10.length; i++) {
                        var d = result10[i];
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        //   var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;
                        type_arr.push(C_AXIS);
                        op_arr.push(ope);
                        //Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);

                    }
                    $('#canvas-holder').empty();
                    $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                    var ctx = document.getElementById("chart-area").getContext('2d');

                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: type_arr,
                            datasets: [{
                                label: 'Open',
                                backgroundColor: "#caf270",
                                data: op_arr,
                            },
                            //{

                            //    label:'Close',
                            //    backgroundColor: "#45c490",
                            //    data: Cl_arr,
                            //},
                            {
                                label: 'Response',
                                backgroundColor: "#008d93",
                                data: res_arr,
                            },
                            {
                                label: 'On-Hold',
                                backgroundColor: "#2e5468",
                                data: onhold_arr,
                            },
                            {
                                label: 'Resolved',
                                data: resl_arr,
                                backgroundColor: '#f4429b'

                            },

                            {
                                label: 'Acknowldegement',
                                data: ack_arr,
                                backgroundColor: '#FFCA28'
                            }

                            ],
                        },
                        options: {
                            tooltips: {
                                displayColors: true,
                                callbacks: {
                                    mode: 'x',
                                },
                            },
                            scales: {
                                xAxes: [{
                                    stacked: true,
                                    gridLines: {

                                        display: false,
                                    },

                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90,
                                        beginAtZero: true,
                                        suggestedMin: 0
                                    }
                                }],
                                yAxes: [{
                                    stacked: true,
                                    ticks: {
                                        beginAtZero: true,
                                    },
                                    type: 'linear',
                                }]
                            },
                            responsive: true,
                            maintainAspectRatio: false,
                            legend: { position: 'bottom' },
                        }


                    });
                    if (type_arr.length == 0) {
                        //   debugger;

                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }
                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });
            StopAjaxLoader("#idDashboardBody");

        }


        function GetSubTypeData() {
            StartLoader("#idDashboardBody");
            var c1;
            var subtype_arr = [];
            var op_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');
            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {
                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result10) {
                    for (var i = 0; i < result10.length; i++) {
                        var d = result10[i];
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        // var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;

                        subtype_arr.push(C_AXIS);
                        op_arr.push(ope);
                        // Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);

                    }
                    $('#canvas-holder').empty();
                    $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                    var ctx = document.getElementById("chart-area").getContext('2d');

                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: subtype_arr,
                            datasets: [{
                                label: 'Open',
                                backgroundColor: "#caf270",
                                data: op_arr,
                            },
                            //{

                            //    label:'Close',
                            //    backgroundColor: "#45c490",
                            //    data: Cl_arr,
                            //},
                            {
                                label: 'Response',
                                backgroundColor: "#008d93",
                                data: res_arr,
                            },
                            {
                                label: 'On-Hold',
                                backgroundColor: "#2e5468",
                                data: onhold_arr,
                            },
                            {
                                label: 'Resolved',
                                data: resl_arr,
                                backgroundColor: '#f4429b'

                            },

                            {
                                label: 'Acknowldegement',
                                data: ack_arr,
                                backgroundColor: '#FFCA28'
                            }

                            ],
                        },
                        options: {
                            tooltips: {
                                displayColors: true,
                                callbacks: {
                                    mode: 'x',
                                },
                            },
                            scales: {
                                xAxes: [{
                                    stacked: true,
                                    gridLines: {
                                        display: false,
                                    },
                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90,
                                        beginAtZero: true,
                                        suggestedMin: 0
                                    }

                                }],
                                yAxes: [{
                                    stacked: true,
                                    ticks: {
                                        beginAtZero: true,
                                    },
                                    type: 'linear',
                                }]
                            },
                            responsive: true,
                            maintainAspectRatio: false,
                            legend: { position: 'bottom' },
                        }


                    });
                    if (subtype_arr.length == 0) {

                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });
            StopAjaxLoader("#idDashboardBody");
        }

        function GetEmployeeGraphData() {
            StartLoader("#idDashboardBody");
            var employee_arr = [];
            var employee_arr = [];
            var op_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');

            // debugger;
            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result10) {
                    for (var i = 0; i < result10.length; i++) {
                        var d = result10[i];
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        //  var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;
                        employee_arr.push(C_AXIS);
                        op_arr.push(ope);
                        //Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);

                    }
                    $('#canvas-holder').empty();
                    $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                    var ctx = document.getElementById("chart-area").getContext('2d');

                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: employee_arr,
                            datasets: [{
                                label: 'Open',
                                backgroundColor: "#caf270",
                                data: op_arr,
                            },
                            {
                                label: 'Response',
                                backgroundColor: "#008d93",
                                data: res_arr,
                            },
                            {
                                label: 'On-Hold',
                                backgroundColor: "#2e5468",
                                data: onhold_arr,
                            },
                            {
                                label: 'Resolved',
                                data: resl_arr,
                                backgroundColor: '#f4429b'

                            },

                            {
                                label: 'Acknowldegement',
                                data: ack_arr,
                                backgroundColor: '#FFCA28'
                            }

                            ],
                        },
                        options: {
                            tooltips: {
                                displayColors: true,
                                callbacks: {
                                    mode: 'x',
                                },
                            },
                            scales: {
                                xAxes: [{
                                    stacked: true,
                                    gridLines: {
                                        display: false,
                                    },
                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90,
                                        beginAtZero: true,
                                        suggestedMin: 0
                                    }

                                }],
                                yAxes: [{
                                    stacked: true,
                                    ticks: {
                                        beginAtZero: true,
                                    },
                                    type: 'linear',
                                }]
                            },
                            responsive: true,
                            maintainAspectRatio: false,
                            legend: { position: 'bottom' },
                        }
                    });
                    if (employee_arr.length == 0) {
                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }
                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });
            StopAjaxLoader("#idDashboardBody");
        }

        function GetPriorityData() {
            StartLoader("#idDashboardBody");
            var priority_arr = [];
            var op_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');
            var intViewBy = $("#overall").find(':selected').val();
            var intDuration = $("#duration").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result10) {
                    for (var i = 0; i < result10.length; i++) {

                        var d = result10[i];
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        // var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;
                        priority_arr.push(C_AXIS);
                        op_arr.push(ope);
                        //  Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);

                    }
                    $('#canvas-holder').empty();
                    $('#canvas-holder').html('<canvas id="chart-area" height="200" width="300"></canvas>'); // then load chart.
                    var ctx = document.getElementById("chart-area").getContext('2d');
                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: priority_arr,
                            datasets: [{
                                label: 'Open',
                                backgroundColor: "#caf270",
                                data: op_arr,
                            },
                            //{

                            //    label:'Close',
                            //    backgroundColor: "#45c490",
                            //    data: Cl_arr,
                            //},
                            {
                                label: 'Response',
                                backgroundColor: "#008d93",
                                data: res_arr,
                            },
                            {
                                label: 'On-Hold',
                                backgroundColor: "#2e5468",
                                data: onhold_arr,
                            },
                            {
                                label: 'Resolved',
                                data: resl_arr,
                                backgroundColor: '#f4429b'

                            },

                            {
                                label: 'Acknowldegement',
                                data: ack_arr,
                                backgroundColor: '#FFCA28'
                            }

                            ],
                        },
                        options: {
                            tooltips: {
                                displayColors: true,
                                callbacks: {
                                    mode: 'x',
                                },
                            },
                            scales: {
                                xAxes: [{
                                    stacked: true,
                                    gridLines: {
                                        display: false,
                                    },

                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90,
                                        beginAtZero: true,
                                        suggestedMin: 0
                                    }
                                }],
                                yAxes: [{
                                    stacked: true,
                                    ticks: {
                                        beginAtZero: true,
                                    },
                                    type: 'linear',
                                }]
                            },
                            responsive: true,
                            maintainAspectRatio: false,
                            legend: { position: 'bottom' },
                        }
                    });
                    if (priority_arr.length == 0) {
                        $("#canvas-holder").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder").css("text-align", "Center");
                    }
                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

            StopAjaxLoader("#idDashboardBody");
        }

        //.....................................................................................................................

        //Onchange of Customer,staus,proiority,customer

        function GetByAssignedTypeGraph() {
            StartLoader("#idDashboardBody");
            var mylist = document.getElementById("overall1");
            var entity = mylist.options[mylist.selectedIndex].value;
            $("#chart-area2").html(' ');
            switch (entity) {
                case '0': getAssinedtoStatusData()
                    break;
                case '1': GetAssignedCustomerGraphData()
                    break;
                case '2': GetAssignedTypeData()
                    break;
                case '3': GetAssignedSubTypeData()
                    break;
                case '4': GetAssignedEmployeeGraphData()
                    break;
                case '5': GetAssignedPriorityData()
                    break;

            }
            StopAjaxLoader("#idDashboardBody");
        }

        //On Customer Click in Assigned to me
        function GetAssignedCustomerGraphData() {
            var Name_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area2").html(' ');
            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result10) {
                    for (var i = 0; i < result10.length; i++) {
                        var d = result10[i];
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;


                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);
                    }
                    $('#canvas-holder2').empty();
                    $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                    var ctx = document.getElementById("chart-area2").getContext('2d');

                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: Name_arr,
                            datasets:

                                [

                                    {
                                        label: 'Open',
                                        backgroundColor: "#caf270",
                                        data: op_arr,
                                    },
                                    {

                                        label: 'Close',
                                        backgroundColor: "#45c490",
                                        data: Cl_arr,
                                    },
                                    {
                                        label: 'Response',
                                        backgroundColor: "#008d93",
                                        data: res_arr,
                                    },
                                    {
                                        label: 'On Hold',
                                        backgroundColor: "#2e5468",
                                        data: onhold_arr,
                                    },
                                    {
                                        label: 'Resolved',
                                        data: resl_arr,
                                        backgroundColor: '#f4429b'

                                    },

                                    {
                                        label: 'Acknowledegement',
                                        data: ack_arr,
                                        backgroundColor: '#FFCA28'
                                    }

                                ],
                        },
                        options: {
                            tooltips: {
                                displayColors: true,
                                callbacks: {
                                    mode: 'x',
                                },
                            },
                            scales: {
                                xAxes: [{
                                    stacked: true,
                                    gridLines: {
                                        display: false,
                                    },

                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90,
                                        beginAtZero: true,
                                        suggestedMin: 0
                                    }
                                }],
                                yAxes: [{
                                    stacked: true,
                                    ticks: {
                                        beginAtZero: true,
                                    },
                                    type: 'linear',
                                }]
                            },
                            responsive: true,
                            maintainAspectRatio: false,
                            legend: { position: 'bottom' },
                        }

                    });
                    if (Name_arr.length == 0) {

                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });
        }



        //on click of type

        function GetAssignedTypeData() {
            var c1;
            var x_axix_arr = [];
            var y_axix_arr = [];
            var Name_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area2").html(' ');
            //  alert("hi");
            //    debugger;
            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result10) {
                    for (var i = 0; i < result10.length; i++) {
                        var d = result10[i];
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;
                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);
                    }

                    $('#canvas-holder2').empty();
                    $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.

                    var ctx = document.getElementById("chart-area2").getContext('2d');

                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: Name_arr,
                            datasets:

                                [

                                    {
                                        label: 'Open',
                                        backgroundColor: "#caf270",
                                        data: op_arr,
                                    },
                                    {

                                        label: 'Close',
                                        backgroundColor: "#45c490",
                                        data: Cl_arr,
                                    },
                                    {
                                        label: 'Response',
                                        backgroundColor: "#008d93",
                                        data: res_arr,
                                    },
                                    {
                                        label: 'On Hold',
                                        backgroundColor: "#2e5468",
                                        data: onhold_arr,
                                    },
                                    {
                                        label: 'Resolved',
                                        data: resl_arr,
                                        backgroundColor: '#f4429b'

                                    },

                                    {
                                        label: 'Acknowledegement',
                                        data: ack_arr,
                                        backgroundColor: '#FFCA28'
                                    }

                                ],
                        },
                        options: {
                            tooltips: {
                                displayColors: true,
                                callbacks: {
                                    mode: 'x',
                                },
                            },
                            scales: {
                                xAxes: [{
                                    stacked: true,
                                    gridLines: {
                                        display: false,
                                    },

                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90,
                                        beginAtZero: true,
                                        suggestedMin: 0
                                    }
                                }],
                                yAxes: [{
                                    stacked: true,
                                    ticks: {
                                        beginAtZero: true,
                                    },
                                    type: 'linear',
                                }]
                            },
                            responsive: true,
                            maintainAspectRatio: false,
                            legend: { position: 'bottom' },
                        }

                    });

                    if (Name_arr.length == 0) {
                        ///  debugger;
                        //alert("No data");
                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });


        }

        function GetAssignedSubTypeData() {
            var c1;
            var Name_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area2").html(' ');
            //  alert("hi");
            //  debugger;
            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result10) {
                    for (var i = 0; i < result10.length; i++) {
                        var d = result10[i];
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;


                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);
                    }
                    $('#canvas-holder2').empty();
                    $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.

                    var ctx = document.getElementById("chart-area2").getContext('2d');
                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: Name_arr,
                            datasets: [{
                                label: 'Open',
                                backgroundColor: "#caf270",
                                data: op_arr,
                            },
                            {

                                label: 'Close',
                                backgroundColor: "#45c490",
                                data: Cl_arr,
                            },
                            {
                                label: 'Response',
                                backgroundColor: "#008d93",
                                data: res_arr,
                            },
                            {
                                label: 'On Hold',
                                backgroundColor: "#2e5468",
                                data: onhold_arr,
                            },
                            {
                                label: 'Resolved',
                                data: resl_arr,
                                backgroundColor: '#f4429b'

                            },

                            {
                                label: 'Acknowledegement',
                                data: ack_arr,
                                backgroundColor: '#FFCA28'
                            }

                            ],
                        },
                        options: {
                            tooltips: {
                                displayColors: true,
                                callbacks: {
                                    mode: 'x',
                                },
                            },
                            scales: {
                                xAxes: [{
                                    stacked: true,
                                    gridLines: {
                                        display: false,
                                    },

                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90,
                                        beginAtZero: true,
                                        suggestedMin: 0
                                    }
                                }],
                                yAxes: [{
                                    stacked: true,
                                    ticks: {
                                        beginAtZero: true,
                                    },
                                    type: 'linear',
                                }]
                            },
                            responsive: true,
                            maintainAspectRatio: false,
                            legend: { position: 'bottom' },
                        }

                    });
                    if (Name_arr.length == 0) {
                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }
                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });
        }

        function GetAssignedEmployeeGraphData() {
            var Name_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area2").html(' ');
            //  alert("hi");
            //   debugger;
            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result10) {
                    for (var i = 0; i < result10.length; i++) {
                        var d = result10[i];
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;


                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);
                    }

                    $('#canvas-holder2').empty();
                    $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.

                    var ctx = document.getElementById("chart-area2").getContext('2d');

                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: Name_arr,
                            datasets:

                                [

                                    {
                                        label: 'Open',
                                        backgroundColor: "#caf270",
                                        data: op_arr,
                                    },
                                    {

                                        label: 'Close',
                                        backgroundColor: "#45c490",
                                        data: Cl_arr,
                                    },
                                    {
                                        label: 'Response',
                                        backgroundColor: "#008d93",
                                        data: res_arr,
                                    },
                                    {
                                        label: 'On Hold',
                                        backgroundColor: "#2e5468",
                                        data: onhold_arr,
                                    },
                                    {
                                        label: 'Resolved',
                                        data: resl_arr,
                                        backgroundColor: '#f4429b'

                                    },

                                    {
                                        label: 'Acknowledegement',
                                        data: ack_arr,
                                        backgroundColor: '#FFCA28'
                                    }

                                ],
                        },
                        options: {
                            tooltips: {
                                displayColors: true,
                                callbacks: {
                                    mode: 'x',
                                },
                            },
                            scales: {
                                xAxes: [{
                                    stacked: true,
                                    gridLines: {
                                        display: false,
                                    },

                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90,
                                        beginAtZero: true,
                                        suggestedMin: 0
                                    }
                                }],
                                yAxes: [{
                                    stacked: true,
                                    ticks: {
                                        beginAtZero: true,
                                    },
                                    type: 'linear',
                                }]
                            },
                            responsive: true,
                            maintainAspectRatio: false,
                            legend: { position: 'bottom' },
                        }

                    });
                    if (Name_arr.length == 0) {
                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }
                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

        }

        function GetAssignedPriorityData() {
            var Name_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area").html(' ');
            //  alert("hi");
            //   debugger;
            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result10) {
                    for (var i = 0; i < result10.length; i++) {
                        var d = result10[i];
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;
                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);
                    }
                    $('#canvas-holder2').empty();
                    $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                    var ctx = document.getElementById("chart-area2").getContext('2d');
                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: Name_arr,
                            datasets:

                                [

                                    {
                                        label: 'Open',
                                        backgroundColor: "#caf270",
                                        data: op_arr,
                                    },
                                    {

                                        label: 'Close',
                                        backgroundColor: "#45c490",
                                        data: Cl_arr,
                                    },
                                    {
                                        label: 'Response',
                                        backgroundColor: "#008d93",
                                        data: res_arr,
                                    },
                                    {
                                        label: 'On Hold',
                                        backgroundColor: "#2e5468",
                                        data: onhold_arr,
                                    },
                                    {
                                        label: 'Resolved',
                                        data: resl_arr,
                                        backgroundColor: '#f4429b'

                                    },

                                    {
                                        label: 'Acknowledegement',
                                        data: ack_arr,
                                        backgroundColor: '#FFCA28'
                                    }

                                ],
                        },
                        options: {
                            tooltips: {
                                displayColors: true,
                                callbacks: {
                                    mode: 'x',
                                },
                            },
                            scales: {
                                xAxes: [{
                                    stacked: true,
                                    gridLines: {
                                        display: false,
                                    },

                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 90,
                                        minRotation: 90,
                                        beginAtZero: true,
                                        suggestedMin: 0
                                    }
                                }],
                                yAxes: [{
                                    stacked: true,
                                    ticks: {
                                        beginAtZero: true,
                                    },
                                    type: 'linear',
                                }]
                            },
                            responsive: true,
                            maintainAspectRatio: false,
                            legend: { position: 'bottom' },
                        }

                    });
                    if (Name_arr.length == 0) {
                        //  debugger;
                        //  alert("No data");
                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }
                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

        }
        //on Change of Duration on AssignedtoMe graph Plotting

        function GetAssignedDurationGraph() {
            StartLoader("#idDashboardBody");
            var mylist = document.getElementById("duration1");
            var entity = mylist.options[mylist.selectedIndex].value;
            $("#chart-area2").html(' ');

            switch (entity) {
                case '0': getAssinedtoStatusData()
                    break;
                case '1': GetTodaysAssignedStatusData()
                    break;
                case '2': GetCurrentWeekAssignedStatusdata()
                    break;
                case '3': GetPreviousWeekAssignedStatusData()
                    break;
                case '4': GetCurrentMonthAssignedStatusdata()
                    break;
                case '5': GetPreviousMonthAssignedStatusData()
                    break;
                case '6': GetCurrentYearAssignedStatusData()
                    break;
                case '7': GetPreviousYearAssignedStatusData()
                    break;

            }
            StopAjaxLoader("#idDashboardBody");
        }

        function GetTodaysAssignedStatusData() {
            var arrxaxis = [];
            var arryaxis = [];
            var Name_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area2").html(' ');
            //  alert("hi");
            var html = "";
            //debugger;
            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result1) {
                    for (var i = 0; i < result1.length; i++) {
                        var d = result1[i];
                        var X_AXIS = d.X_AXIS;
                        var Y_AXIS = d.Y_AXIS;
                        arrxaxis.push(X_AXIS);
                        arryaxis.push(Y_AXIS);
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;
                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);
                    }


                    if (intViewBy != 0) {

                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = document.getElementById("chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets:

                                    [

                                        {
                                            label: 'Open',
                                            backgroundColor: "#caf270",
                                            data: op_arr,
                                        },
                                        {

                                            label: 'Close',
                                            backgroundColor: "#45c490",
                                            data: Cl_arr,
                                        },
                                        {
                                            label: 'Response',
                                            backgroundColor: "#008d93",
                                            data: res_arr,
                                        },
                                        {
                                            label: 'On Hold',
                                            backgroundColor: "#2e5468",
                                            data: onhold_arr,
                                        },
                                        {
                                            label: 'Resolved',
                                            data: resl_arr,
                                            backgroundColor: '#f4429b'

                                        },

                                        {
                                            label: 'Acknowledegement',
                                            data: ack_arr,
                                            backgroundColor: '#FFCA28'
                                        }

                                    ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },

                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }
                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });
                    }
                    else {
                        var result1 = {
                            labels:
                                arrxaxis,
                            datasets: [{
                                labels:
                                    [arrxaxis],
                                data: arryaxis,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],

                                borderColor: [
                                    "#577DD0",
                                    "#F98843",
                                    "#5D8CDD",
                                    "#FBC722",
                                    "#5D8CDD"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result1
                        });

                    }
                    if (arryaxis.length == 0) {
                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }
                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

        }


        function GetCurrentWeekAssignedStatusdata() {
            var arrxaxis = [];
            var arryaxis = [];
            var Name_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area2").html(' ');
            //  alert("hi");
            var html = "";
            //debugger;
            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result1) {
                    for (var i = 0; i < result1.length; i++) {

                        var d = result1[i];
                        var X_AXIS = d.X_AXIS;
                        var Y_AXIS = d.Y_AXIS;
                        arrxaxis.push(X_AXIS);
                        arryaxis.push(Y_AXIS);

                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;


                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);
                    }


                    if (intViewBy != 0) {

                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = document.getElementById("chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets:

                                    [

                                        {
                                            label: 'Open',
                                            backgroundColor: "#caf270",
                                            data: op_arr,
                                        },
                                        {

                                            label: 'Close',
                                            backgroundColor: "#45c490",
                                            data: Cl_arr,
                                        },
                                        {
                                            label: 'Response',
                                            backgroundColor: "#008d93",
                                            data: res_arr,
                                        },
                                        {
                                            label: 'On Hold',
                                            backgroundColor: "#2e5468",
                                            data: onhold_arr,
                                        },
                                        {
                                            label: 'Resolved',
                                            data: resl_arr,
                                            backgroundColor: '#f4429b'

                                        },

                                        {
                                            label: 'Acknowledegement',
                                            data: ack_arr,
                                            backgroundColor: '#FFCA28'
                                        }

                                    ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },

                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }
                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });

                    }
                    else {
                        var result1 = {
                            labels:
                                arrxaxis,
                            datasets: [{
                                labels:
                                    [arrxaxis],
                                data: arryaxis,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],

                                borderColor: [
                                    "#577DD0",
                                    "#F98843",
                                    "#5D8CDD",
                                    "#FBC722",
                                    "#5D8CDD"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result1
                        });

                    }
                    if (arryaxis.length == 0) {
                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }
                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });


        }

        function GetPreviousWeekAssignedStatusData() {
            //  alert("In assigned PreviousWeek");
            var arrxaxis = [];
            var arryaxis = [];

            var Name_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area2").html(' ');
            // alert("hi");
            var html = "";
            //    debugger;
            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result1) {

                    for (var i = 0; i < result1.length; i++) {
                        var d = result1[i];
                        var X_AXIS = d.X_AXIS;
                        var Y_AXIS = d.Y_AXIS;
                        arrxaxis.push(X_AXIS);
                        arryaxis.push(Y_AXIS);

                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;


                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);


                    }

                    if (intViewBy != 0) {

                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = document.getElementById("chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets:

                                    [

                                        {
                                            label: 'Open',
                                            backgroundColor: "#caf270",
                                            data: op_arr,
                                        },
                                        {

                                            label: 'Close',
                                            backgroundColor: "#45c490",
                                            data: Cl_arr,
                                        },
                                        {
                                            label: 'Response',
                                            backgroundColor: "#008d93",
                                            data: res_arr,
                                        },
                                        {
                                            label: 'On Hold',
                                            backgroundColor: "#2e5468",
                                            data: onhold_arr,
                                        },
                                        {
                                            label: 'Resolved',
                                            data: resl_arr,
                                            backgroundColor: '#f4429b'

                                        },

                                        {
                                            label: 'Acknowledegement',
                                            data: ack_arr,
                                            backgroundColor: '#FFCA28'
                                        }

                                    ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },

                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }
                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });


                    }
                    else {
                        var result1 = {
                            labels:
                                arrxaxis,
                            datasets: [{
                                labels:
                                    [arrxaxis],
                                data: arryaxis,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],

                                borderColor: [
                                    "#577DD0",
                                    "#F98843",
                                    "#5D8CDD",
                                    "#FBC722",
                                    "#5D8CDD"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result1
                        });

                    }

                    if (arryaxis.length == 0) {
                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

        }

        function GetCurrentMonthAssignedStatusdata() {

            var arrxaxis = [];
            var arryaxis = [];
            var Name_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area2").html(' ');
            // alert("hi");
            var html = "";
            //    debugger;
            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result1) {
                    for (var i = 0; i < result1.length; i++) {
                        var d = result1[i];
                        var X_AXIS = d.X_AXIS;
                        var Y_AXIS = d.Y_AXIS;
                        arrxaxis.push(X_AXIS);
                        arryaxis.push(Y_AXIS);
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;


                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);


                    }
                    if (intViewBy != 0) {

                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = document.getElementById("chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets:

                                    [

                                        {
                                            label: 'Open',
                                            backgroundColor: "#caf270",
                                            data: op_arr,
                                        },
                                        {

                                            label: 'Close',
                                            backgroundColor: "#45c490",
                                            data: Cl_arr,
                                        },
                                        {
                                            label: 'Response',
                                            backgroundColor: "#008d93",
                                            data: res_arr,
                                        },
                                        {
                                            label: 'On Hold',
                                            backgroundColor: "#2e5468",
                                            data: onhold_arr,
                                        },
                                        {
                                            label: 'Resolved',
                                            data: resl_arr,
                                            backgroundColor: '#f4429b'

                                        },

                                        {
                                            label: 'Acknowledegement',
                                            data: ack_arr,
                                            backgroundColor: '#FFCA28'
                                        }

                                    ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },

                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }
                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });


                    }
                    else {
                        var result1 = {
                            labels:
                                arrxaxis,
                            datasets: [{
                                labels:
                                    [arrxaxis],
                                data: arryaxis,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],

                                borderColor: [
                                    "#577DD0",
                                    "#F98843",
                                    "#5D8CDD",
                                    "#FBC722",
                                    "#5D8CDD"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result1
                        });

                    }

                    if (arryaxis.length == 0) {
                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }

                },


                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

        }


        function GetPreviousMonthAssignedStatusData() {
            // alert("In assigned PreviousMonth");
            var arrxaxis = [];
            var arryaxis = [];

            var Name_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];


            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area2").html(' ');
            // alert("hi");
            var html = "";
            // debugger;
            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result1) {
                    for (var i = 0; i < result1.length; i++) {
                        var d = result1[i];
                        var X_AXIS = d.X_AXIS;

                        //  alert(X_AXIS);
                        var Y_AXIS = d.Y_AXIS;
                        arrxaxis.push(X_AXIS);
                        arryaxis.push(Y_AXIS);


                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;


                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);
                    }

                    if (intViewBy != 0) {

                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = document.getElementById("chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets:

                                    [

                                        {
                                            label: 'Open',
                                            backgroundColor: "#caf270",
                                            data: op_arr,
                                        },
                                        {

                                            label: 'Close',
                                            backgroundColor: "#45c490",
                                            data: Cl_arr,
                                        },
                                        {
                                            label: 'Response',
                                            backgroundColor: "#008d93",
                                            data: res_arr,
                                        },
                                        {
                                            label: 'On Hold',
                                            backgroundColor: "#2e5468",
                                            data: onhold_arr,
                                        },
                                        {
                                            label: 'Resolved',
                                            data: resl_arr,
                                            backgroundColor: '#f4429b'

                                        },

                                        {
                                            label: 'Acknowledegement',
                                            data: ack_arr,
                                            backgroundColor: '#FFCA28'
                                        }

                                    ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },

                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }
                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });


                    }
                    else {
                        var result1 = {
                            labels:
                                arrxaxis,
                            datasets: [{
                                labels:
                                    [arrxaxis],
                                data: arryaxis,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],
                                //hoverBackgroundColor: [
                                //    "#FF6384",
                                //    "#36A2EB"
                                //],

                                borderColor: [
                                    "#577DD0",
                                    "#F98843",
                                    "#5D8CDD",
                                    "#FBC722",
                                    "#5D8CDD"

                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result1
                        });

                    }

                    if (arryaxis.length == 0) {
                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }

                },


                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

        }

        function GetCurrentYearAssignedStatusData() {
            var arrxaxis = [];
            var arryaxis = [];

            var Name_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area2").html(' ');
            //alert("hi");
            var html = "";
            //  debugger;
            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result1) {
                    for (var i = 0; i < result1.length; i++) {
                        var d = result1[i];
                        var X_AXIS = d.X_AXIS;
                        var Y_AXIS = d.Y_AXIS;
                        arrxaxis.push(X_AXIS);
                        arryaxis.push(Y_AXIS);
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;


                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);


                    }
                    if (intViewBy != 0) {

                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = document.getElementById("chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets:

                                    [

                                        {
                                            label: 'Open',
                                            backgroundColor: "#caf270",
                                            data: op_arr,
                                        },
                                        {

                                            label: 'Close',
                                            backgroundColor: "#45c490",
                                            data: Cl_arr,
                                        },
                                        {
                                            label: 'Response',
                                            backgroundColor: "#008d93",
                                            data: res_arr,
                                        },
                                        {
                                            label: 'On Hold',
                                            backgroundColor: "#2e5468",
                                            data: onhold_arr,
                                        },
                                        {
                                            label: 'Resolved',
                                            data: resl_arr,
                                            backgroundColor: '#f4429b'

                                        },

                                        {
                                            label: 'Acknowledegement',
                                            data: ack_arr,
                                            backgroundColor: '#FFCA28'
                                        }

                                    ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },

                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }
                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });

                    }
                    else {
                        var result1 = {
                            labels:
                                arrxaxis,
                            datasets: [{
                                labels:
                                    [arrxaxis],
                                data: arryaxis,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],

                                borderColor: [
                                    "#577DD0",
                                    "#F98843",
                                    "#5D8CDD",
                                    "#FBC722",
                                    "#5D8CDD"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result1
                        });

                    }

                    if (arryaxis.length == 0) {
                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

        }


        function GetPreviousYearAssignedStatusData() {
            var arrxaxis = [];
            var arryaxis = [];
            var Name_arr = [];
            var op_arr = [];
            var Cl_arr = [];
            var res_arr = [];
            var onhold_arr = [];
            var resl_arr = [];
            var ack_arr = [];

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $("#chart-area2").html(' ');
            // alert("hi");
            var html = "";
            //   debugger;
            var intViewBy = $("#overall1").find(':selected').val();
            var intDuration = $("#duration1").find(':selected').val();
            var statusparameter =
            {

                intUserID: '<%= Session("intUserID") %>',
                intViewBy: intViewBy,
                intDuration: intDuration,
                 //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
                StrLoginType: '<%= Session("LoginType").ToString() %>',
                 //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
          
            };

            $.ajax({
                url: strUrl + '/api/IB_Dashboard/GetAssignedCorporateStatusGraph',
                type: "POST",
                data: JSON.stringify(statusparameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                // async:false,
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (statusparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(statusparameter) ? statusparameter : JSON.stringify(statusparameter)));
                    }
                },
                success: function (result1) {
                    for (var i = 0; i < result1.length; i++) {
                        var d = result1[i];
                        var X_AXIS = d.X_AXIS;


                        var Y_AXIS = d.Y_AXIS;
                        arrxaxis.push(X_AXIS);
                        arryaxis.push(Y_AXIS);
                        var C_AXIS = d.Name;
                        var ope = d.op;
                        var clos = d.Cl;
                        var resp = d.res;
                        var onho = d.onhold;
                        var resol = d.resol;
                        var ackn = d.ack;


                        Name_arr.push(C_AXIS);
                        op_arr.push(ope);
                        Cl_arr.push(clos);
                        res_arr.push(resp);
                        onhold_arr.push(onho);
                        resl_arr.push(resol);
                        ack_arr.push(ackn);

                    }

                    if (intViewBy != 0) {

                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = document.getElementById("chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: Name_arr,
                                datasets:

                                    [

                                        {
                                            label: 'Open',
                                            backgroundColor: "#caf270",
                                            data: op_arr,
                                        },
                                        {

                                            label: 'Close',
                                            backgroundColor: "#45c490",
                                            data: Cl_arr,
                                        },
                                        {
                                            label: 'Response',
                                            backgroundColor: "#008d93",
                                            data: res_arr,
                                        },
                                        {
                                            label: 'On Hold',
                                            backgroundColor: "#2e5468",
                                            data: onhold_arr,
                                        },
                                        {
                                            label: 'Resolved',
                                            data: resl_arr,
                                            backgroundColor: '#f4429b'

                                        },

                                        {
                                            label: 'Acknowledegement',
                                            data: ack_arr,
                                            backgroundColor: '#FFCA28'
                                        }

                                    ],
                            },
                            options: {
                                tooltips: {
                                    displayColors: true,
                                    callbacks: {
                                        mode: 'x',
                                    },
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: {
                                            display: false,
                                        },

                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90,
                                            beginAtZero: true,
                                            suggestedMin: 0
                                        }
                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            beginAtZero: true,
                                        },
                                        type: 'linear',
                                    }]
                                },
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { position: 'bottom' },
                            }

                        });
                    }
                    else {
                        var result1 = {
                            labels:
                                arrxaxis,
                            datasets: [{
                                labels:
                                    [arrxaxis],
                                data: arryaxis,
                                //fill: false,
                                backgroundColor: [
                                    '#32c6c6',
                                    '#fe4c72',
                                    '#ffc02b',
                                    '#32c6c6',
                                    '#935dff',
                                    '#ff9124',
                                    "#FF6384",
                                    "#36A2EB",
                                    "#577DD0",
                                    "#F98843"
                                ],

                                borderColor: [
                                    "#577DD0",
                                    "#F98843",
                                    "#5D8CDD",
                                    "#FBC722",
                                    "#5D8CDD"
                                ],
                                borderWidth: [1, 1, 1]
                            }]
                        };
                        $('#canvas-holder2').empty();
                        $('#canvas-holder2').html('<canvas id="chart-area2" height="200" width="300"></canvas>'); // then load chart.
                        var ctx = $("#chart-area2");
                        var myChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: result1
                        });

                    }

                    if (arryaxis.length == 0) {
                        //  debugger;
                        // alert("No data");
                        $("#canvas-holder2").html("<h4<center>No Data To Display</center></h4>");
                        $("#canvas-holder2").css("text-align", "Center");
                    }

                },
                error: function (err) {
                    //Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Added By Dipali V On 12th Aug 2019 For Redirect to error page when crash/Exc Comes
                }
            });

        }
    </script>
    <script>
        function change(newDType) {
            var ctx1 = document.getElementById("chart-area").getContext("2d");

            // Remove the old chart and all its event handles
            if (myDChart1) {
                myDChart1.destroy();
            }

            // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
            var temp = jQuery.extend(true, {}, data1);
            temp.type = newDType;
            myDChart1 = new Chart(ctx1, temp);

        };

    </script>
    <!--chartjs_endhere_added_by_pradip-->
    <script>
		<!--start pareto analysis chart-->	
        //Added by Chetan M on 5th Aug 2020 for Alle E tech Issue ID  = 25783
        $('.chartboxheader').mouseover(function () {
                $(this).find('button').removeAttr('title');
                $(this).find('select').removeAttr('title');
                $(this).find('.selectpicker').removeAttr('title');
            });
        //End of Added by Chetan M on 5th Aug 2020 for Alle E tech Issue ID  = 25783
    //project hour and cost chart start
    $(document).ready(function () {
        change('bar');
        <%--Added By Usha Pandit On 18.03.2020 For showing placeholder--%>
        if ($("#cbochangedFromStatus option:first").val() != "Select Changed From Status") {
            $('#cbochangedFromStatus').prepend('<option value="Select Changed From Status" selected="selected">Select Changed From Status</option>');
            $("#cbochangedFromStatus").val($("#cbochangedFromStatus option:first").val());
        }
        if ($("#cbochangedToStatus option:first").val() != "Select Changed To Status") {
            $('#cbochangedToStatus').prepend('<option value="Select Changed To Status" selected="selected">Select Changed To Status</option>');
            $("#cbochangedToStatus").val($("#cbochangedToStatus option:first").val());
        }  
        if ($("#ddlChangedFromStatus option:first").val() != "Select Changed From Status") {
            $('#ddlChangedFromStatus').prepend('<option value="Select Changed From Status" selected="selected">Select Changed From Status</option>');
            $("#ddlChangedFromStatus").val($("#ddlChangedFromStatus option:first").val());
        } 
        <%--End Of Added By Usha Pandit On 18.03.2020 For showing placeholder--%>
             
    });

    var config = {

        type: 'bar',
        data: {
            labels: ["January\n2017", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep"],
            datasets: [{
                lineTension: "0",
                radius: "5",
                label: "Invoice",
                type: "line",
                borderColor: "#71b23e",
                data: [408, 547, 675, 734, 862, 600, 1118, 600, 1374],
                fill: false
            }, {
                lineTension: "0",
                label: "Utilization",
                type: "line",
                borderColor: "#a7a9ad",
                data: [133, 221, 783, 1000, 862, 600, 1118, 600, 1374],
                fill: false
            }, {
                label: "Available",
                type: "bar",
                backgroundColor: "#fbb03b",
                backgroundColorHover: "#fbb03b",
                data: [133, 221, 783, 1000, 862, 600, 1118, 600, 1374],
                bezierCurve: false
            }]
        },
        options: {
            bezierCurve: false,
            scales: {
                yAxes: [{
                    gridLines: {
                        display: false
                    },
                    //id: 'A',
                    categorySpacing: 0,
                    type: 'linear',
                    position: 'left',

                }, {
                    //id: 'B',
                    type: 'linear',
                    position: 'right',
                    categorySpacing: 0,
                    gridLines: {
                        display: true
                    },
                    ticks: {
                        max: 100,
                        min: 60
                    }
                }]
            }
        },
        plugins: [{
            beforeInit: function (myChart) {
                myChart.data.labels.forEach(function (e, i, a) {
                    if (/\n/.test(e)) {
                        a[i] = e.split(/\n/);
                    }
                });
            }
        }]
    };

    var myChart;

    $("#line").click(function () {
        //window.myChart = new Chart(ctxChart).Line(newdata, options);
        change('line');
        myChart.data.datasets[2].type = "line";
        myChart.data.datasets[2].fill = "false";
        myChart.data.datasets[2].borderColor = "#fbb03b";
        myChart.options.bezierCurve = "false";

        myChart.update();
    });

    $("#bar").click(function () {
        change('bar');
        myChart.data.datasets[0].type = "bar";
        myChart.data.datasets[0].backgroundColor = "#71b23e";
        myChart.data.datasets[1].type = "bar";
        myChart.data.datasets[1].backgroundColor = "#b9b7b7";
        myChart.update();
    });

    $("#barandline").click(function () {
        change('bar');
    });

    $("#redograph").click(function () {
        change('bar');
    });



    function change(newType) {
        var ctx = document.getElementById("mixedChart").getContext("2d");
        // Remove the old chart and all its event handles
        if (myChart) {
            myChart.destroy();
        }

        // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
        var temp = jQuery.extend(true, {}, config);
        temp.type = newType;
        myChart = new Chart(ctx, temp);
    };

    //<!--End pareto analysis chart-->	


    var presets = window.chartColors;
    var utils = Samples.utils;
    var inputs = {
        min: 20,
        max: 300,
        count: 12,
        decimals: 2,
        continuity: 1
    };

    function generateData() {
        return utils.numbers(inputs);
    }

    function generateLabels() {
        return utils.months({
            count: inputs.count
        });
    }

    utils.srand(42);

    var data = {
        labels: generateLabels(),
        datasets: [{
            backgroundColor: utils.transparentize(presets.blue),
            borderColor: presets.blue,
            data: generateData(),
            hidden: false,
            label: 'D7',
            fill: false
        }, {
            backgroundColor: utils.transparentize(presets.orange),
            borderColor: presets.orange,
            data: generateData(),
            hidden: false,
            label: 'D8',
            fill: false
        },
        {
            backgroundColor: utils.transparentize(presets.green),
            borderColor: presets.green,
            data: generateData(),
            hidden: false,
            label: 'D9',
            fill: false
        }]
    };

    var options = {
        maintainAspectRatio: false,
        spanGaps: false,
        elements: {
            line: {
                tension: 0.000001
            }
        },
        scales: {
            yAxes: [{
                stacked: true
            }]
        },
        plugins: {
            filler: {
                propagate: false
            },
            //'samples-filler-analyser': {
            //target: 'chart-analyser'
            //	}
        }
    };

    var chart = new Chart('chart-0', {
        type: 'line',
        data: data,
        options: options
    });

    // eslint-disable-next-line no-unused-vars
    function togglePropagate(btn) {
        var value = btn.classList.toggle('btn-on');
        chart.options.plugins.filler.propagate = value;
        chart.update();
    }

    // eslint-disable-next-line no-unused-vars
    function toggleSmooth(btn) {
        var value = btn.classList.toggle('btn-on');
        chart.options.elements.line.tension = value ? 0.4 : 0.000001;
        chart.update();
    }

    // eslint-disable-next-line no-unused-vars
    function randomize() {
        chart.data.datasets.forEach(function (dataset) {
            dataset.data = generateData();
        });
        chart.update();
    }


    //<!--end In and out rate line chart-->

    //SIS report chart  
    //var ctx5 = document.getElementById("SISreportchart").getContext('2d');
    //var myChart5 = new Chart(ctx5, {
    //    type: 'pie',
    //    data: {
    //        labels: ["Assigned", "Closed", "In Progress", "Open", "Submitted"],
    //        datasets: [{
    //            backgroundColor: [
    //                "#ff8000",
    //                "#b8860b",
    //                "#c04000",
    //                "#6b8e23",
    //                "#ff8000"
    //            ],
    //            data: [12, 19, 3, 17, 28]
    //        }]
    //    }
    //});
		//SIS report chart end


    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            //multiselect
            $('#multiselect1').multiselect();
            $('#multiselect2').multiselect();

            ////viewreportpanel
            //$("#dashviewreportlink").click(function () {

            //    $("#dashstatusreport").hide('slow');
            //    $("#SISReport").hide('slow');
            //    $("#dashviewreport").fadeIn('slow');
            //});

        });

        function closeviewreport() {
            // StartLoader("#idDashboardBody");
            $("#dashviewreport").hide('slow');
            $("#SISReport").hide('slow');
            $("#dashstatusreport").fadeIn('slow');
            // $('#ViewDataTable').dataTable().fnDestroy();

            $('#ViewDataTable tbody').empty();
            //StopAjaxLoader("#idDashboardBody");

        }
        function closeviewreport1() {
            // StartLoader("#idDashboardBody");
            $("#dashviewreport").hide('slow');
            $("#SISReport").hide('slow');
            $("#dashstatusreport").fadeIn('slow');
            // $('#ViewDataTable').dataTable().fnDestroy();

            $('#ViewDataTable tbody').empty();
            //StopAjaxLoader("#idDashboardBody");

        }

        $("#btnBack").click(function () {
            StartLoader("#idDashboardBody");
            var A = $(parent.document.getElementById('mainHeadingTop'));
            A.text("");
            A.text("Issues >  Issues");
            //Added by Swapnagandha K. for Session Project Issue On 18-Oct-2019
            window.location.href = "IssueList.aspx?FromWhere=Issue&View=" + viewApplied +"&ViewType="+ '<%= Request.QueryString("ViewType")%>' +"";
            //EndAdded by Swapnagandha K. for Session Project Issue On 18-Oct-2019
        });


        $("#viewReport").click(function () {
           // debugger;
           var selectedProject = getUrlVars()["ProjectID"];
          
            var ProjectID = unescape(selectedProject);
           
            if (ProjectID.trim() != "0") {

                $("#viewReport").attr("data-bs-toggle", "tab");
                $("#viewReport").attr("href", "#viewreport");
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select Project');
                return false;

            }
           // alert(ProjectID);
            //Added By Dipali V On 16th April 2020 For hide tooltip
            $('body').tooltip({
                selector: '[data-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
           //End of Added By Dipali V On 16th April 2020 For hide tooltip


          
        });

        function getUrlVars() {
                var vars = [], hash;
                var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < hashes.length; i++) {
                    hash = hashes[i].split('=');
                    vars.push(hash[0]);
                    vars[hash[0]] = hash[1];
                }
                return vars;
       }



        //Script added by Pradip p on 2-9-2020
        function resizeSection() {

            var tblheight = $(window).height();
            $('.content').css({ 'height': tblheight - 30, "overflow-y": "auto" });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });

        $(".ui-datepicker").click(function () {
            $('.tooltip').removeClass('show');
        });
        $(".ui-datepicker").hover(function () {
            $('.tooltip').removeClass('show');
        });

    </script>
</body>
</html>