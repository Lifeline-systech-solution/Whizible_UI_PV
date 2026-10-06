<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_GraphAndOtherInformation.aspx.vb" Inherits="PbNIT.PM_GraphAndOtherInformation" %>

<!DOCTYPE html>
<html>

<%CommonFunctions.General.PlotPageHeadTag("WBS")%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>WBS</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <link href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2"> -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3">
     <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css"> 
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    
</head>

<style type="text/css">
    .panel-horizontal label.col-md-4 {
        text-align: right;
        padding-right: 0;
    }

    .lightgraybg {
        background: #f5f5f5;
    }

    h5.pgtitle {
        margin: 6px 0 0;
        font-weight: 700;
        color: #4263c1;
        font-size: 16px;
    }

    .chartbox {
        position: relative;
        border-radius: 4px;
        background: #fff;
        margin-bottom: 20px
    }

        .chartbox .box-body {
            border: 1px solid #d2d6de;
            box-shadow: 0 1px 1px rgba(0,0,0,0.1);
            padding: 15px
        }

        /* Added By Gauri On 21th Aug 2024 For Alignment Issue */
        .chartbox .box-header {
              /* Changed by Madhuri.K on 09-03-2026 */
            background: #F8FAFC !important;
            /* background: #e7edf0 !important; */
            color: #464a4c;
            padding: 10px
        }
        /* End of Added By Gauri On 21th Aug 2024 For Alignment Issue */

            .chartbox .box-header h3 {
                margin: 0;
                color: #464a4c;
                font-size: 16px
            }

    .bluehighlight {
        background: #0d95d3
    }

    .bluelight {
        background: #87c9eb
    }

    span.col-sm-1.colan {
        text-align: center;
        padding: 0 !important;
        width: 5px
    }

    h5.PRITblHeading {
        margin: 0 0 10px;
        font-weight: 700
    }

    .PIInfo .form-group {
        margin-bottom: 8px;
    }
    /*collapse panel style added here*/
    .panel-heading .accordion-toggle:after {
        /* symbol for "opening" panels */
        font-family: 'Glyphicons Halflings'; /* essential for enabling glyphicon */
        content: "\e114"; /* adjust as needed, taken from bootstrap.css */
        float: right; /* adjust as needed */
        color: grey; /* adjust as needed */
    }

    .panel-heading .accordion-toggle.collapsed:after {
        /* symbol for "collapsed" panels */
        content: "\e080"; /* adjust as needed, taken from bootstrap.css */
    }

    .togglerup .collapseup {
        display: block;
    }

    .togglerup .collapsedown {
        display: none;
    }

    .togglerdown .collapsedown {
        display: block;
    }

    .togglerdown .collapseup {
        display: none;
    }

    .infoToggler {
        margin: 5px 0 0;
    }

    .hideaccordianinfopanel {
        position: absolute;
        right: 10px;
    }

    .accordianinfopanel .panel.panel-default {
        padding: 0px 0px 0 0;
        position: relative;
    }

    .accordianinfopanel .panel-default > .panel-heading {
        padding-right: 35px;
          /* Changed by Madhuri.K on 09-03-2026 */
        background: #F8FAFC;
    }

        .accordianinfopanel .panel-default > .panel-heading a:hover, .profitabilityinfopanel .panel-default > .panel-heading a:focus {
            color: #464a4c;
        }

        /* .accordianinfopanel .panel-default > .panel-heading a span img {
            opacity: 0.5;
        } */

            .accordianinfopanel .panel-default > .panel-heading a span img:hover {
                opacity: 1;
            }

        .accordianinfopanel .panel-default > .panel-heading a:focus {
            color: #464a4c;
        }
    /*End Style for collapse*/

    /*Media Queries Start here*/
    @media (max-width:767px) {
        span.col-sm-1.colan {
            display: none;
        }
    }

    @media (max-width: 575.98px) {
        .main_graybgtbs li {
            width: 100%;
            margin-bottom: 5px;
        }
    }
    /*Media Queries End here*/

    .pdtbl th {
        min-width: 100px;
    }

    .RIinfotablewrap th {
        / white-space: nowrap;
        / min-width: 96px;
    }
    /* Added By Gauri On 21th Aug 2024 For Alignment Issue */
    .panel-default > .panel-heading a {
        color: #464a4c;
        display: block;
        /* padding: 10px 15px; */
    }
    /* End of Added By Gauri On 21th Aug 2024 For Alignment Issue */

    /* Added By Gauri On 03rd Sep 2024 For Alignment Issue */
    .panel-default > .panel-heading a span {
        left: unset;
        right: 0;
    }
    /* End of Added By Gauri On 03rd Sep 2024 For Alignment Issue */
</style>

<body class="hold-transition skin-blue-light sidebar-mini fixed">

    <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 mb-1 text-right graybg headingDiv">
            <h5 class="pgtitle pull-left"><%= MyBase.GetResourceString("C_Project_Information") %></h5>
        </div>
        <div class="content">
            <div class="panel-group accordianinfopanel" id="accordion">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <!-- Added By Gauri On 21th Aug 2024 For Alignment Issue -->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#PIcollapseOne" aria-expanded="true" aria-controls="collapseOne">
                                
                                Project Details
                            
                                <span class="infoToggler togglerup float-end">
                                    <img data-bs-toggle="tooltip" data-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                </span>
                            </a>
                        </h4>
                        <!-- End of Added By Gauri On 21th Aug 2024 For Alignment Issue -->
                    </div>
                    <div id="PIcollapseOne" class="panel-collapse collapse in show">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-12 col-sm-12 col-md-6 PIInfo">
                                    <div class="row form-group">
                                        <label class="col-xs-12 col-sm-3"><%= MyBase.GetResourceString("C_Project_Name") %></label>
                                        <span class=" col-sm-1 colan">:</span>
                                        <span class="col-xs-12 col-sm-8" id="idProjectName"></span>
                                    </div>
                                    <div class="row form-group">
                                        <label class="col-xs-12 col-sm-3"><%= MyBase.GetResourceString("C_Practice") %></label>
                                        <span class=" col-sm-1 colan">:</span>
                                        <span class="col-xs-12 col-sm-8" id="idPractice"></span>
                                    </div>

                                    <div class="row form-group">
                                        <label class="col-xs-12 col-sm-3"><%= MyBase.GetResourceString("C_Start_Date") %></label>
                                        <span class=" col-sm-1 colan">:</span>
                                        <span class="col-xs-12 col-sm-8" id="idStartDate"></span>
                                    </div>
                                    <div class="row form-group">
                                        <label class="col-xs-12 col-sm-3"><%= MyBase.GetResourceString("C_EndDate") %></label>
                                        <span class=" col-sm-1 colan">:</span>
                                        <span class=" col-xs-12 col-sm-8" id="idEndDate"></span>
                                    </div>

                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-6">
                                    &nbsp;

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <!-- Added By Gauri On 21th Aug 2024 For Alignment Issue -->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#PIcollapseTwo" aria-expanded="true" aria-controls="collapseOne">
                                <%= MyBase.GetResourceString("C_Graphs") %> 
                                <span class="infoToggler togglerup float-end">
                                    <img data-bs-toggle="tooltip" data-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                </span>
                            </a>
                        </h4>
                        <!-- End of Added By Gauri On 21th Aug 2024 For Alignment Issue -->
                    </div>
                    <div id="PIcollapseTwo" class="panel-collapse collapse in show">
                        <div class="panel-body">
                            <div class="row projectinfoGraph">
                                <div class="col-sm-6 chartbox">
                                    <div class="box box-panel box-solid">
                                        <div class="box-header boxheaderblue with-border">
                                            <h5><%= MyBase.GetResourceString("C_Planned_Task_Vs_Completed_Task") %> </h5>
                                        </div>
                                        <div class="box-body">
                                            <div class="graphcontainer">
                                            <canvas id="charttask1" width="400" height="200"></canvas>
                                                </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-6 chartbox">
                                    <div class="box box-panel box-solid">
                                        <div class="box-header boxheaderblue with-border">
                                            <h5><%= MyBase.GetResourceString("C_Open_Issues_for_Projects") %> </h5>
                                        </div>
                                        <div class="box-body">
                                            <div class="graphcontainer">
                                            <canvas id="charttask2" width="400" height="200"></canvas>
                                                </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="col-sm-12 chartbox">
                                    <div class="box box-panel box-solid">
                                        <div class="box-header boxheaderblue with-border">
                                            <h5><%= MyBase.GetResourceString("C_Task_Status_by_Resources") %> </h5>
                                        </div>
                                        <div class="box-body">
                                            <canvas id="charttask3" height="80"></canvas>
                                        </div>
                                    </div>
                                </div>



                                <div class="col-sm-12 chartbox">
                                    <div class="box box-panel box-solid">
                                        <div class="box-header boxheaderblue with-border">
                                            <h5><%= MyBase.GetResourceString("C_Cumulative_Task_Vs_Completed_Task") %> </h5>
                                        </div>
                                        <div class="box-body">
                                            <canvas id="charttask4" height="80"></canvas>
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <!-- Added By Gauri On 21th Aug 2024 For Alignment Issue -->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#PIcollapseThree" aria-expanded="true" aria-controls="collapseOne">
                                <%= MyBase.GetResourceString("C_Related_Information") %>
                                <span class="infoToggler togglerup float-end">
                                    <img data-bs-toggle="tooltip" data-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                </span>
                            </a>
                        </h4>
                        <!-- End of Added By Gauri On 21th Aug 2024 For Alignment Issue -->
                    </div>
                    <div id="PIcollapseThree" class="panel-collapse collapse in show">
                        <div class="panel-body">

                            <div class="Relatedinfowrap">
                                <div class="RIinfotablewrap">
                                    <h5 class="PRITblHeading"><%= MyBase.GetResourceString("C_Active_Resources") %></h5>
                                    <div class="table-responsive">
                                        <table class="table table-stripped table-bordered" style="width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th><%= MyBase.GetResourceString("C_Resource") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Start_Date") %></th>
                                                    <th><%= MyBase.GetResourceString("C_EndDate") %></th>
                                                    <th><%= MyBase.GetResourceString("C_WorkHrs") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Actual_WorkHrs") %></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbodyresource">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="RIinfotablewrap">
                                    <h5 class="PRITblHeading"><%= MyBase.GetResourceString("C_Phase_Details") %></h5>
                                    <div class="table-responsive">
                                        <table class="table table-stripped table-bordered pdtbl" style="width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th><%= MyBase.GetResourceString("C_Requirement_Analysis") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Start_Date") %></th>
                                                    <th><%= MyBase.GetResourceString("C_EndDate") %></th>
                                                    <th><%= MyBase.GetResourceString("C_WorkHrs") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Actual_WorkHrs") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Work_Ratio") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Planned_Task") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Completed_Tasks") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Task_Ratio") %></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbodyphase">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="RIinfotablewrap">
                                    <h5 class="PRITblHeading"><%= MyBase.GetResourceString("C_Module_Details") %></h5>
                                    <div class="table-responsive">
                                        <table class="table table-stripped table-bordered" style="width: 100%;">
                                            <thead>
                                                <tr>

                                                    <th><%= MyBase.GetResourceString("C_Module") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Start_Date") %></th>
                                                    <th><%= MyBase.GetResourceString("C_EndDate") %></th>
                                                    <th><%= MyBase.GetResourceString("C_WorkHrs") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Actual_WorkHrs") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Work_Ratio") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Planned_Task") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Completed_Tasks") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Task_Ratio") %></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbodymodule">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="RIinfotablewrap">
                                    <h5 class="PRITblHeading"><%= MyBase.GetResourceString("C_Sub_Project_Details") %></h5>
                                    <div class="table-responsive">
                                        <table class="table table-stripped table-bordered" style="width: 100%;">
                                            <thead>
                                                <tr>

                                                    <th><%= MyBase.GetResourceString("C_Sub_Project") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Start_Date") %></th>
                                                    <th><%= MyBase.GetResourceString("C_EndDate") %></th>
                                                    <th><%= MyBase.GetResourceString("C_WorkHrs") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Actual_WorkHrs") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Work_Ratio") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Planned_Task") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Completed_Tasks") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Task_Ratio") %></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbodysubproject">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="RIinfotablewrap">
                                    <h5 class="PRITblHeading"><%= MyBase.GetResourceString("C_Milestone_Details") %></h5>
                                    <div class="table-responsive">
                                        <table class="table table-stripped table-bordered" style="width: 100%;">
                                            <thead>
                                                <tr>

                                                    <th><%= MyBase.GetResourceString("C_Milestone") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Start_Date") %></th>
                                                    <th><%= MyBase.GetResourceString("C_EndDate") %></th>
                                                    <th><%= MyBase.GetResourceString("C_WorkHrs") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Actual_WorkHrs") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Work_Ratio") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Planned_Task") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Completed_Tasks") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Task_Ratio") %></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbodymilestone">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.content-wrapper -->

    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery -->
    <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> -->
    <script src="../../../Whizible2.0-new/plugins/chartjs/chart.min.js"></script>

    <script type="text/javascript">
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';

        //Added by imran on 16-12-2021
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        //end by imran 16-12-2021 

        $(document).ready(function ()
        {
            //Added by imran on 16-12-2021
            if (blnViewAccess == "False") {
                window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
            }
            else
            {
                 //end by imran 16-12-2021 
                Get_Project_Information();
                function beforePrintHandler() {
                    for (var id in Chart.instances) {
                        Chart.instances[id].resize();
                    }
                }
            }
        });
       
        
        function Get_Project_Information()
        {
            try {
                var ListOfProjectParameter = {
                    ProjectID: encodeURI('<%= Session("intProjectID") %>')
                }
                $.ajax({

                    url: encodeURI(strUrl) + '/api/PM_GraphAndOtherInformation/GetProjectInformation',// Path
                    type: "POST", //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter), // Parameters
                    dataType: "json", //Retrun Type
                   contentType: "application/json; charset=utf-8", //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        GetGraphInfocumulativeComplete(result);
                        GetGraphInformationforTaskStatus(result);
                        GetGraphInformationforOpenIssue(result);
                        DisplayPCGraph(result);
                        GetMilestoneDetails(result);
                        GetSubProjectDetails(result);
                        GetModuleDetails(result);
                        GetPhaseDetails(result);
                        GetProjectDetails(result);
                        GetActiveResources(result);
                    },
                    error: function (ER) {
                        //alert(ER);
                        //alert("2" + ER.responseText);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                alert("1" + ex.message);
            }

        }
        function GetProjectDetails(result) {
            if (result != undefined) {

                var Data = result.ProjectInformation;
                for (var i = 0; i < Data.length; i++) {
                    var obj = Data[i];
                    var ProjectName = obj.ProjectName;

                    var Practice = obj.Practice;
                    var StartDate = obj.StartDate;
                    var EndDate = obj.EndDate;

                }


                $("#idProjectName").text(ProjectName);
                $("#idPractice ").text(Practice);
                $("#idStartDate ").text(StartDate);
                $("#idEndDate ").text(EndDate);
            }
        }

        //Function for getting Resources Detail
        function GetActiveResources(result) {
            if (result != undefined) {
                var Data = result.ActiveResources;

                $("#tbodyresource").empty();
                var strHTML = '';

                 //Added by imran on 20-12-2021 if data is availabe crash comming
                if (Data.length > 0)
                {
                //End Comment by imran
                for (var i = 0; i <= Data.length; i++) {
                    var obj = Data[i];
                    var Resource = obj.Resource;
                    var StartDate = obj.StartDate;
                    var EndDate = obj.EndDate;
                    var WorkHrs = obj.WorkHrs;
                    var ActualWorkHrs = obj.ActualWorkHrs;
                    
                    strHTML += '<tr>'
                    strHTML += '<td>' + Resource + '</td>'
                    strHTML += '<td>' + StartDate + '</td>'
                    strHTML += '<td>' + EndDate + '</td>'
                    strHTML += '<td>' + WorkHrs + '</td>'
                    strHTML += '<td>' + ActualWorkHrs + '</td>'
                    strHTML += '</tr>'
                    $("#tbodyresource").append(strHTML);
                    strHTML = ' ';
                    }
                //Added by imran on 20-12-2021 if data is availabe
                }
                //End Comment by imran
            }
        }

        //Function for getting Phase details
        function GetPhaseDetails(result) {

            if (result != undefined) {

                var Data = result.PhaseDetails;

                $("#tbodyphase").empty();
                var strHTML = '';

                for (var i = 0; i < Data.length; i++) {
                    var obj = Data[i];
                    var RequirementAnalysis = obj.RequirementAnalysis;
                    var StartDate = obj.StartDate;
                    var EndDate = obj.EndDate;
                    var WorkHrs = obj.WorkHrs;
                    var ActualWorkHrs = obj.ActualWorkHrs;
                    var WorkRatio = obj.WorkRatio;
                    var PlannedTasks = obj.PlannedTasks;
                    var CompletedTasks = obj.CompletedTasks;
                    var TaskRatio = obj.TaskRatio;



                    strHTML += '<tr>'
                    strHTML += '<td>' + RequirementAnalysis + '</td>'
                    strHTML += '<td>' + StartDate + '</td>'
                    strHTML += '<td>' + EndDate + '</td>'
                    strHTML += '<td>' + WorkHrs + '</td>'
                    strHTML += '<td>' + ActualWorkHrs + '</td>'
                    strHTML += '<td>' + WorkRatio + '</td>'
                    strHTML += '<td>' + PlannedTasks + '</td>'
                    strHTML += '<td>' + CompletedTasks + '</td>'
                    strHTML += '<td>' + TaskRatio + '</td>'
                    strHTML += '</tr>'
                    $("#tbodyphase").append(strHTML);
                    strHTML = ' ';

                }

            }
        }

        //function for getting module details
        function GetModuleDetails(result) {
            if (result != undefined) {

                var Data = result.ModuleDetails;

                $("#tbodymodule").empty();
                var strHTML = '';

                for (var i = 0; i < Data.length; i++) {

                    var obj = Data[i];
                    var Module = obj.Module;
                    var StartDate = obj.StartDate;
                    var EndDate = obj.EndDate;
                    var WorkHrs = obj.WorkHrs;
                    var ActualWorkHrs = obj.ActualWorkHrs;
                    var WorkRatio = obj.WorkRatio;
                    var PlannedTasks = obj.PlannedTasks;
                    var CompletedTasks = obj.CompletedTasks;
                    var TaskRatio = obj.TaskRatio;



                    strHTML += '<tr>'
                    strHTML += '<td>' + Module + '</td>'
                    strHTML += '<td>' + StartDate + '</td>'
                    strHTML += '<td>' + EndDate + '</td>'
                    strHTML += '<td>' + WorkHrs + '</td>'
                    strHTML += '<td>' + ActualWorkHrs + '</td>'
                    strHTML += '<td>' + WorkRatio + '</td>'
                    strHTML += '<td>' + PlannedTasks + '</td>'
                    strHTML += '<td>' + CompletedTasks + '</td>'
                    strHTML += '<td>' + TaskRatio + '</td>'
                    strHTML += '</tr>'
                    $("#tbodymodule").append(strHTML);
                    strHTML = ' ';

                }

            }
        }

        //function for getting SubProject details
        function GetSubProjectDetails(result) {

            if (result != undefined) {

                var Data = result.SubProjectDetails;

                $("#tbodysubproject").empty();
                var strHTML = '';

                for (var i = 0; i < Data.length; i++) {
                    var obj = Data[i];
                    var SubProject = obj.SubProject;
                    var StartDate = obj.StartDate;
                    var EndDate = obj.EndDate;
                    var WorkHrs = obj.WorkHrs;
                    var ActualWorkHrs = obj.ActualWorkHrs;
                    var WorkRatio = obj.WorkRatio;
                    var PlannedTasks = obj.PlannedTasks;
                    var CompletedTasks = obj.CompletedTasks;
                    var TaskRatio = obj.TaskRatio;



                    strHTML += '<tr>'
                    strHTML += '<td>' + SubProject + '</td>'
                    strHTML += '<td>' + StartDate + '</td>'
                    strHTML += '<td>' + EndDate + '</td>'
                    strHTML += '<td>' + WorkHrs + '</td>'
                    strHTML += '<td>' + ActualWorkHrs + '</td>'
                    strHTML += '<td>' + WorkRatio + '</td>'
                    strHTML += '<td>' + PlannedTasks + '</td>'
                    strHTML += '<td>' + CompletedTasks + '</td>'
                    strHTML += '<td>' + TaskRatio + '</td>'
                    strHTML += '</tr>'
                    $("#tbodysubproject").append(strHTML);
                    strHTML = ' ';

                }

            }
        }
        //function for getting Milestone details
        function GetMilestoneDetails(result) {

            if (result != undefined) {

                var Data = result.MilestoneDetails;

                $("#tbodymilestone").empty();
                var strHTML = '';

                for (var i = 0; i < Data.length; i++) {
                    var obj = Data[i];
                    var Milestone = obj.Milestone;
                    var StartDate = obj.StartDate;
                    var EndDate = obj.EndDate;
                    var WorkHrs = obj.WorkHrs;
                    var ActualWorkHrs = obj.ActualWorkHrs;
                    var WorkRatio = obj.WorkRatio;
                    var PlannedTasks = obj.PlannedTasks;
                    var CompletedTasks = obj.CompletedTasks;
                    var TaskRatio = obj.TaskRatio;



                    strHTML += '<tr>'
                    strHTML += '<td>' + Milestone + '</td>'
                    strHTML += '<td>' + StartDate + '</td>'
                    strHTML += '<td>' + EndDate + '</td>'
                    strHTML += '<td>' + WorkHrs + '</td>'
                    strHTML += '<td>' + ActualWorkHrs + '</td>'
                    strHTML += '<td>' + WorkRatio + '</td>'
                    strHTML += '<td>' + PlannedTasks + '</td>'
                    strHTML += '<td>' + CompletedTasks + '</td>'
                    strHTML += '<td>' + TaskRatio + '</td>'
                    strHTML += '</tr>'
                    $("#tbodymilestone").append(strHTML);
                    strHTML = ' ';

                }

            }
        }

        //Function for Displaying  Planned Vs Completed Graph
        function DisplayPCGraph(result) {

            if (result != undefined) {

                var Data = result.PlannedvsCompletedDetail;
                var arr = new Array();
                var arrLabel = new Array();

                for (var i = 0; i < Data.length; i++) {

                    var obj = Data[i];
                    var Total = obj.Total;
                    arr[i] = Total;

                }
                var data = {
                    labels: ["Planned Task", "Completed Task"],
                    datasets: [{
                        label: "Total",
                        borderWidth: 1,
                        backgroundColor: ["#00a65a", "#d2d6de"],
                        hoverBackgroundColor: ["#049a55", "#c6cbd4"],
                        data: arr,
                        // xAxisID: 'x3',
                    }

                    ]
                };
                var option = {
                    responsive: true,
                    showAllTooltips: true,
                    categoryPercentage: 0.3,
                    scales: {
                        yAxes: [{
                            gridLines: {
                                display: true,
                                color: "#dddddd"
                            },
                            barThickness: 30,
                        }],
                        xAxes: [{
                            ticks: {
                                beginAtZero: true,
                                barThickness: 40,
                            }
                        },

                        ]
                    },

                    plugins: {
                        datalabels: {
                            align: 'start',
                            anchor: 'end',
                            //backgroundColor: function (context) {
                            //    return context.dataset.backgroundColor;
                            //},
                            borderRadius: 4,
                            color: 'white',
                            formatter: function (value) {
                                return value + " % ";
                            }
                        }
                    }
                }


                var ctx = document.getElementById("charttask1").getContext('2d');

                var myBarChart = new Chart(ctx, {
                    //Commented And Added By Riddhesh Patil on 6th April 2023
                   // type: 'horizontalBar',
                    type: 'bar',
                    //End of Commented And Added By Riddhesh Patil on 6th April 2023
                    data: data,
                    options: option
                });

            }
        }

        //Function for Displaying Open Issue for project graph
        function GetGraphInformationforOpenIssue(result) {

            if (result != undefined) {

                var Data = result.OpenIssueDetail;
                var arr = new Array();
                var arrLabel = new Array();
                var arrcolor = new Array();
                //If there no change request Default label should display for that 
                //arrLabel.push("Change Request");

                for (var i = 0; i < Data.length; i++) {
                    //debugger;
                    var randomColor = '#' + Math.floor(Math.random() * 16777215).toString(16);

                    var obj = Data[i];
                    var Count = obj.Count;
                    arr[i] = Count;
                    var type = obj.type;
                    arrLabel[i] = type;
                    arrcolor[i] = randomColor;

                }

                var ctx = document.getElementById("charttask2").getContext('2d');
                //ctx.height = 500;
                var myChart = new Chart(ctx, {
                    type: 'pie',
                    data: {
                        //Commented & Added By Dipali V On 13th Dec 2021 For Legend Should get Color
                        //    labels: arrLabel,
                        //    datasets: [{
                        //        backgroundColor: [
                        //            //"#2ecc71",
                        //            //"#f56954",
                        //            arrcolor,

                        //        ],
                        //        data: arr
                        //    }  
                        //    ],


                        labels: arrLabel,
                        datasets: [{
                            label: '# of Tomatoes',
                            data: arr,
                            backgroundColor: arrcolor,
                            borderColor: arrcolor,
                            borderWidth: 1,
                        }]

                    },
                   options: {                       
                        responsive: false,
                       //maintainAspectRatio: false,                       
                       plugins: {
                           legend: {
                               aspectRatio: 1,
                               display: true,
                               position: 'right',
                               maxWidth: '100',
                           },
                       },
                       layout: {
                           padding: {
                               bottom: -20,
                           }
                       },
                       
                    }
                    //End of Commented & Added By Dipali V On 13th Dec 2021 For Legend Should get Color
                });
            }

        }

        //function for displaying Task status by resources graph
        function GetGraphInformationforTaskStatus(result) {

            if (result != undefined) {

                var Data = result.TaskStatusDetail;
                var arrCompleted = new Array();
                var arrInProgress = new Array();
                var arrNotYetStarted = new Array();
                var arrResources = new Array();



                for (var i = 0; i < Data.length; i++) {
                    var obj = Data[i];
                    var ResourceName = obj.ResourceName;
                    arrResources[i] = ResourceName;

                    var TasksCompleted = obj.TasksCompleted;
                    arrCompleted[i] = TasksCompleted;

                    var TasksInProgress = obj.TasksInProgress;
                    arrInProgress[i] = TasksInProgress;

                    var TasksNotYetStarted = obj.TasksNotYetStarted;
                    arrNotYetStarted[i] = TasksNotYetStarted;

                }

                var numberWithCommas = function (x) {
                    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                };

                var dataPack1 = arrCompleted;
                var dataPack2 = arrInProgress;
                var dataPack3 = arrNotYetStarted;
                var dates = arrResources;

                // Chart.defaults.global.elements.rectangle.backgroundColor = '#FF0000';

                var bar_ctx = document.getElementById('charttask3');
                var bar_chart = new Chart(bar_ctx, {
                    type: 'bar',
                    data: {
                        labels: dates,
                        datasets: [

                            {
                                label: 'Task Completed',
                                data: dataPack1,
                                backgroundColor: "#00a65a",
                                hoverBackgroundColor: "#039c56",
                                hoverBorderWidth: 0,
                                
                            },
                            {
                                label: 'Task In Progress',
                                data: dataPack2,
                                backgroundColor: "#f39c12",
                                hoverBackgroundColor: "#ec9913",
                                hoverBorderWidth: 0,
                                
                            },
                            {
                                label: 'Task Not Yet Started',
                                data: dataPack3,
                                backgroundColor: "#007bff",
                                hoverBackgroundColor: "#369ade",
                                hoverBorderWidth: 0,
                                
                            },
                        ]
                    },
                    options: {
                       
                        animation: {
                            duration: 10,
                        },
                        categoryPercentage: 0.1,
                        //barThickness: 25,
                        //barPercentage: 0.8,
                        
                        responsive: true,

                        tooltips: {
                            mode: 'label',
                            callbacks: {
                                label: function (tooltipItem, data) {
                                    return data.datasets[tooltipItem.datasetIndex].label + ": " + numberWithCommas(tooltipItem.yLabel);
                                }
                            }
                        },
                        
                        scales: {
                            x: {
                                stacked: true,
                            },
                            y: {
                                stacked: true
                            },
                            xAxes: [{
                                stacked: true,

                                gridLines: { display: false },
                               // barThickness: 40,
                                
                                
                            }],
                            yAxes: [{
                                stacked: true,
                                ticks: {
                                    callback: function (value) { return numberWithCommas(value); },
                                },
                            }],
                        }, // scales
                        legend: { display: true },
                        plugins: {
                            barPercentage: 2.8,
                            stacked: true,
                        },
                    } // options
                }
                );
                //End Chart

            }
        }

        //Function for displaying Cumulative vs Completed Graph
        function GetGraphInfocumulativeComplete(result) {

            if (result != undefined) {

                var Data = result.CumulativevsCompletedDetail;
                var arrMonths = new Array();
                var arrCumulative = new Array();
                var arrCompleted = new Array();




                for (var i = 0; i < Data.length; i++) {
                    var obj = Data[i];
                    var Months = obj.Months;
                    arrMonths[i] = Months;

                    var Cumulative = obj.Cumulative;
                    arrCumulative[i] = Cumulative;

                    var TasksComplete = obj.TasksComplete;
                    arrCompleted[i] = TasksComplete;

                }

                var options = {
                    type: 'line',
                    data: {
                        labels: arrMonths,
                        datasets: [
                            {
                                label: 'Comulative',
                                data: arrCumulative,
                                fill: false,
                                borderWidth: 2,
                                borderColor: "rgb(249, 136, 67)",
                                backgroundColor: "rgb(249, 136, 67)"
                            },
                            {
                                label: 'Task Complete',
                                data: arrCompleted,
                                fill: false,
                                borderColor: "#00a65a",
                                backgroundColor: "#00a65a",
                                borderWidth: 2
                            },

                        ]
                    },
                    options: {
                        scales: {
                            yAxes: [{
                                ticks: {
                                    reverse: false,
                                    beginAtZero: true
                                }
                            }]
                        }
                    }
                }

                var ctx = document.getElementById('charttask4').getContext('2d');
                new Chart(ctx, options);
            }
        }

        //Organization Priority
        var canvas = document.getElementById('chartOrgPriority');
        //var data = {
        //    labels: ["Completed Task", "Planned Task"],
        //    datasets: [{
        //        label: "Total",                
        //        borderWidth: 1,               
        //        backgroundColor: ["#00a65a", "#d2d6de"],
        //        hoverBackgroundColor: ["#049a55", "#c6cbd4"],
        //        data: [10, 16],
        //        // xAxisID: 'x3',


        //    }

        //    ]
        //};
        //var option = {
        //    responsive: true,
        //    showAllTooltips: true,
        //    scales: {
        //        yAxes: [{
        //            gridLines: {
        //                display: true,
        //                color: "#dddddd"
        //            },
        //            barThickness: 30,
        //        }],
        //        xAxes: [{
        //            ticks: {
        //                beginAtZero: true,
        //                barThickness: 40,
        //            }
        //        },

        //        ]
        //    },

        //    plugins: {
        //        datalabels: {
        //            align: 'start',
        //            anchor: 'end',
        //            //backgroundColor: function (context) {
        //            //    return context.dataset.backgroundColor;
        //            //},
        //            borderRadius: 4,
        //            color: 'white',
        //            formatter: function (value) {
        //                return value + " % ";
        //            }
        //        }
        //    }
        //}

        //var ctx = document.getElementById("charttask1").getContext('2d');

        //var myBarChart = new Chart(ctx, {
        //    type: 'horizontalBar',
        //    data: data,
        //    options: option
        //});


        ////Open Issues for Projects

        //var ctx = document.getElementById("charttask2").getContext('2d');
        //var myChart = new Chart(ctx, {
        //    type: 'pie',
        //    data: {
        //        labels: ["Change Request"],
        //        datasets: [{
        //            backgroundColor: [
        //                //"#2ecc71",
        //                "#f56954",

        //            ],
        //            data: [98]
        //        }  
        //        ],

        //    },


        //});
        ////End Chart for Projects Open Issue

        ////Task Status by Resource chart start here
        //// Return with commas in between
        //var numberWithCommas = function (x) {
        //    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        //};

        //var dataPack1 = [40, 47, 44, 38, 27, 31, 25];
        //var dataPack2 = [10, 12, 7, 5, 4, 6, 8];
        //var dataPack3 = [17, 11, 22, 18, 12, 7, 5];
        //var dates = ["R1", "R2", "R3", "R4", "R5", "R5", "R6"];

        //// Chart.defaults.global.elements.rectangle.backgroundColor = '#FF0000';

        //var bar_ctx = document.getElementById('charttask3');
        //var bar_chart = new Chart(bar_ctx, {
        //    type: 'bar',
        //    data: {
        //        labels: dates,
        //        datasets: [

        //            {
        //                label: 'Task Completed',
        //                data: dataPack1,
        //                backgroundColor: "#00a65a",
        //                hoverBackgroundColor: "#039c56",
        //                hoverBorderWidth: 0
        //            },
        //            {
        //                label: 'Task In Progress',
        //                data: dataPack2,
        //                backgroundColor: "#f39c12",
        //                hoverBackgroundColor: "#ec9913",
        //                hoverBorderWidth: 0
        //            },
        //            {
        //                label: 'Task Not Yet Started',
        //                data: dataPack3,
        //                backgroundColor: "#007bff",
        //                hoverBackgroundColor: "#369ade",
        //                hoverBorderWidth: 0
        //            },
        //        ]
        //    },
        //    options: {
        //        animation: {
        //            duration: 10,
        //        },
        //        responsive: true,

        //        tooltips: {
        //            mode: 'label',
        //            callbacks: {
        //                label: function (tooltipItem, data) {
        //                    return data.datasets[tooltipItem.datasetIndex].label + ": " + numberWithCommas(tooltipItem.yLabel);
        //                }
        //            }
        //        },
        //        scales: {
        //            xAxes: [{
        //                stacked: true,
        //                gridLines: { display: false },
        //                barThickness: 40,
        //            }],
        //            yAxes: [{
        //                stacked: true,
        //                ticks: {
        //                    callback: function (value) { return numberWithCommas(value); },
        //                },
        //            }],
        //        }, // scales
        //        legend: { display: true }
        //    } // options
        //}
        //);
        ////End Chart


        ////Commulative task vs Completed task chart start here
        //var options = {
        //    type: 'line',
        //    data: {
        //        labels: ["Apr 20", "May 20", "Jun 20", "Jul 20"],
        //        datasets: [
        //            {
        //                label: 'Comulative',
        //                data: [12, 9, 9, 13],
        //                fill: false,
        //                borderWidth: 2,
        //                borderColor: "rgb(249, 136, 67)",
        //                backgroundColor: "rgb(249, 136, 67)"
        //            },
        //            {
        //                label: 'Task Complete',
        //                data: [7, 16, 6, 19],
        //                fill: false,
        //                borderColor: "#00a65a",
        //                backgroundColor: "#00a65a",
        //                borderWidth: 2
        //            },

        //        ]
        //    },
        //    options: {
        //        scales: {
        //            yAxes: [{
        //                ticks: {
        //                    reverse: false,
        //                    beginAtZero: true
        //                }
        //            }]
        //        }
        //    }
        //}

        //var ctx = document.getElementById('charttask4').getContext('2d');
        //new Chart(ctx, options);
        ////End Chart


        function toggleIcon(e) {
            $(e.target)
                .prev('.panel-heading')
                .find(".infoToggler")
                .toggleClass('togglerdown togglerup');

        }
        $('.panel-group').on('hidden.bs.collapse', toggleIcon);
        $('.panel-group').on('shown.bs.collapse', toggleIcon);

    </script>  
</body>
</html>