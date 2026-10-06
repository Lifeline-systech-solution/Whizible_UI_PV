<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Helpdesk_Dashboard.aspx.vb" Inherits="PbNIT.Helpdesk_Dashboard" %>

    <!DOCTYPE html>

    <html lang="en">

    <%CommonFunctions.General.PlotPageHeadTag("Dashboard")%>

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard</title>       

        <!-- Bootstrap core CSS -->
         <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
         <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
         <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
         <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" /> -->
         <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/editor.css" />
         <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dashboard_style.css" />
         <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/reqdetail.css" />
         <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/setting.css" />
         <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />
         <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/timepicker.min.css" />
         <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dash.css" />
          <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" /> 
         <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
         
         
         
        <link href="../../General/loaderStylesheet.css" rel="stylesheet" />
        <script>
            function setFrameLoader() {
                RemoveFrameLoader()
                $("HTML").append("<div id='fillDiv' style='top:" + $("html").scrollTop() + "px'><div id='preloader'></div></div>");
            }

            function RemoveFrameLoader() {
                jQuery("#preloader").remove();
                jQuery("#fillDiv").remove();
                jQuery("#preloader").fadeOut("slow");
                jQuery("#fillDiv").fadeOut("slow");
                jQuery("#preloader").remove();
                jQuery("#fillDiv").remove();
            }
        </script>
    </head>

    <style>
        @media only screen and (min-width:992px) and (max-width:1200px) {
            .slc {
                width: 100px !important;
            }
        }

        @media only screen and (max-width:1024px) {
            .slc {
                width: 86px !important;
                margin-left: 3px;
            }
        }

        #divCustomer canvas {
            width: 100% !important;
        }

        .content-wrapper {
            margin-left: 0px;
        }

        #id17 .form-group.cutom-view-list {
            height: 220px;
            overflow-y: auto;
            border: none;
        }

        .select-all-view {
            background: rgba(0, 0, 0, .05);
        }

        .view {
            margin-top: -230px;
            text-align: right;
        }

        .view1 {
            margin-top: -252px;
            width: 100%;
            height: 30px;
        }

        .btnx {
            margin-top: 2px;
        }

        .table > thead > tr > th {
            vertical-align: text-top;
        }

        .content-wrapper {
            padding-left: 0px;
        }

        @media only screen and (max-width:768px) {
            .col-xs-6 {
                width: 100% !important;
            }
        }
        .fas.fa-sync-alt{display:block}
    </style>

    <body class="" id="page-top">

        <div class="content-wrapper" style="background:#f2f4f4;">

            <div class="container-fluid" style="overflow:hidden;">

                <div class="dashbr-section">
                    <div class="row" style="display:none">
                        <div class="white-section">
                            <div class="top-dash">
                                <ul class="dash-comman-icon">
                                    <li>
                                        <a href="#"><img src="../../../Whizible2.0-new/dist/img/reload.png" alt="#" />Reset</a>
                                    </li>
                                    <li>
                                        <a href="#"><img src="../../../Whizible2.0-new/dist/img/right-icon.png" alt="#" />Make This as Default</a>
                                    </li>
                                </ul>
                                <div class="dropdown" style="padding-top: 0px;">
                                    <button class="btn btn-primary dropdown-toggle btn-c-new" type="button" data-bs-toggle="dropdown">Choose Widgets
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu new">
                                        <div id="id17">

                                            <form class="modal-content" action="/action_page.php">
                                                <div class="imgcontainer">
                                                    <span class="appro-title">Choose Widgets</span>
                                                </div>
                                                <div class="search-bar-id17" style="width:100%;">
                                                    <div id="custom-search-input" style="width:100%;">
                                                        <div class="input-group col-md-12">
                                                            <input type="text" class="form-control input-lg" placeholder="Search" />
                                                            <span class="input-group-btn">
                        <button class="btn btn-info btn-lg" type="button">
                            <i class="glyphicon glyphicon-search"></i>
                        </button>
                    </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="container">

                                                    <div class="form-group cutom-view-list" style="margin-top:15px;">

                                                        <div class="select-all-view">

                                                            <div class="col-sm-2">
                                                                <input type="checkbox" class="checkthis">
                                                            </div>
                                                            <label class="control-label col-sm-10" for="request type">Counter Graphs</label>

                                                        </div>

                                                        <div class="col-sm-2">
                                                            <input type="checkbox" class="checkthis">
                                                        </div>
                                                        <label class="control-label col-sm-10" for="request type">Priority</label>

                                                        <div class="col-sm-2">
                                                            <input type="checkbox" class="checkthis">
                                                        </div>
                                                        <label class="control-label col-sm-10" for="request type">Requester</label>

                                                        <div class="col-sm-2">
                                                            <input type="checkbox" class="checkthis">
                                                        </div>
                                                        <label class="control-label col-sm-10" for="request type">Requester satisfaction</label>

                                                        <div class="select-all-view">

                                                            <div class="col-sm-2">
                                                                <input type="checkbox" class="checkthis">
                                                            </div>
                                                            <label class="control-label col-sm-10" for="request type">In Rate Out Rate Graph</label>

                                                        </div>

                                                        <div class="col-sm-2">
                                                            <input type="checkbox" class="checkthis">
                                                        </div>
                                                        <label class="control-label col-sm-10" for="request type">Department</label>

                                                        <div class="col-sm-2">
                                                            <input type="checkbox" class="checkthis">
                                                        </div>
                                                        <label class="control-label col-sm-10" for="request type">Priority</label>

                                                        <div class="col-sm-2">
                                                            <input type="checkbox" class="checkthis">
                                                        </div>
                                                        <label class="control-label col-sm-10" for="request type">Assigned To</label>

                                                        <div class="col-sm-2">
                                                            <input type="checkbox" class="checkthis">
                                                        </div>
                                                        <label class="control-label col-sm-10" for="request type">Subcategory</label>

                                                        <div class="col-sm-2">
                                                            <input type="checkbox" class="checkthis">
                                                        </div>
                                                        <label class="control-label col-sm-10" for="request type">Requester</label>

                                                        <div class="col-sm-2">
                                                            <input type="checkbox" class="checkthis">
                                                        </div>
                                                        <label class="control-label col-sm-10" for="request type">Requester</label>

                                                        <div class="col-sm-2">
                                                            <input type="checkbox" class="checkthis">
                                                        </div>
                                                        <label class="control-label col-sm-10" for="request type">Requester</label>

                                                        <div class="col-sm-2">
                                                            <input type="checkbox" class="checkthis">
                                                        </div>
                                                        <label class="control-label col-sm-10" for="request type">Requester</label>

                                                    </div>
                                                    <div class="form-group" style="border-top:solid #ccc 1px;border-bottom:none;margin-bottom:0;">
                                                        <div class="right" style="margin-top: 12px;">
                                                            <button type="button" class="btn btn-default">Save</button>
                                                            <button type="button" class="btn btn-default">Cancel</button>
                                                        </div>
                                                    </div>

                                                </div>
                                            </form>
                                        </div>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="progress-meter-section">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12" style="display:inline-flex">
                                <div class="col-md-6 col-sm-6 col-xs-6" id="divAll">
                                    <div class="inner-bx" style="height:370px;">
                                        <!--tpstart-->
                                        <div class="tp">
                                            <div class="pull-left hd" style="text-transform: capitalize;">
                                                Overall Open Requests
                                            </div>
                                            <%--/*Added By Yasmin on 18th july 2018*/--%>
                                            <%CommonFunctions.HTMLControls.DrawComboBox("overall", "Usp_NG2_Sel_GraphFilterType 'Overall'," & Session("LoginType"), 135, , "title='Open Request' data-toggle='tooltip' data-placement='bottom' class='slc' onchange=javascript:FilterType_OnChange('Overall')", False, False)%>
                                            <%CommonFunctions.HTMLControls.DrawComboBox("duration", "Usp_NG2_Sel_GraphFilterTime ''", 135, , "title='View By' data-toggle='tooltip' data-placement='bottom'  class='slc' onchange=javascript:Time_OnChange('Overall')", False, False)%>

                                        <%--    <select class="slc" id='overall' name='overall'>
                                                <option value='0'>All</option>
                                                <option value='1'>By Department</option>
                                                <option value='2'>By Customer</option>
                                                <option value='3'>By Type</option>
                                                <option value='4'>By Sub Type</option>
                                                <option value='5'>By Severity</option>
                                                <option value='6'>By Employee</option>

                                            </select>
                                            <select name='duration' id='duration' class="slc">
                                                <option value='0'>Duration</option>
                                                <option value='3'>Current Month</option>
                                                <option value='2'>Today</option>
                                                 <option value='1'>Current Week</option>
                                            </select>--%>



                                            <!--<div class="dropdown pull-right">
  <button class="btn  btn-xs dropdown-toggle" type="button" data-bs-toggle="dropdown" style="background-color:#fff; border:solid #ddd 1px;border-radius: 4px; color:#000000">By Requestor
  <span class="caret"></span></button>
  <ul class="dropdown-menu"> 
    <li><a href="#">HTML</a></li>
    <li><a href="#">CSS</a></li>
    <li><a href="#">JavaScript</a></li>
  </ul>
</div>-->
<%--/*Added By Yasmin on 18th july 2018*/--%>

                                            <span>
	<span class="pull-right" style="padding-top:8px;margin-right: 10PX;">
<button class="btn  btn-xs " type="button" title="Reload Metadata" data-toggle="tooltip" data-placement="bottom"  style="background-color:rgba(255, 255, 255, 0); border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;" onclick="FilterType_OnChange('Overall')">
    <i class="fas fa-sync-alt" aria-hidden="true" ></i>
</button>

	</span>
                                            <div id="socialShare" style="display:none" class="btn-group share-group">

                                                <button href="#" data-bs-toggle="dropdown" class="btn  dropdown-toggle share" style="background-color: #fff; color: #fe4c72;display:none;">
                                                    <i class="fa fa-share-alt fa-inverse"></i>
                                                </button>
                                                <ul class="dropdown-menu">
<%--                                                    <li>
                                                        <a data-original-title="Twitter" rel="tooltip" href="#" class="btn btn-twitter" data-placement="left">
                                                            <i class="fa fa-twitter"></i>
                                                        </a>
                                                    </li>--%>
                                                    <li>
                                                        <a data-original-title="Facebook" title="Under Development" data-toggle="tooltip" rel="tooltip" href="#" class="btn btn-facebook" data-placement="left">
                                                            <i class="fa fa-facebook"></i>
                                                        </a>
                                                    </li>
                                                   <%-- <li>
                                                        <a data-original-title="Google+" rel="tooltip" href="#" class="btn btn-google" data-placement="left">
                                                            <i class="fa fa-google-plus"></i>
                                                        </a>
                                                    </li>--%>
                                                    <li>
                                                        <a data-original-title="LinkedIn" title="Under Development" data-toggle="tooltip" rel="tooltip" href="#" class="btn btn-linkedin" data-placement="left">
                                                            <i class="fa fa-linkedin"></i>
                                                        </a>
                                                    </li>
                                                    <%--<li>
                                                        <a data-original-title="Pinterest" rel="tooltip" class="btn btn-pinterest" data-placement="left">
                                                            <i class="fa fa-pinterest"></i>
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a data-original-title="Email" rel="tooltip" class="btn btn-mail" data-placement="left">
                                                            <i class="fa fa-envelope"></i>
                                                        </a>
                                                    </li>--%>
                                                </ul>
                                            </div>




                                                <%--/*Added By Yasmin on 18th july 2018*/--%>
                                            <div class="dropdown pull-right" style="margin-right: 10px;">
                                                <button class="btn  btn-xs dropdown-toggle chart" type="button" title = "Select Graph Type"  data-placement="bottom" data-bs-toggle="dropdown" style="background-color:rgba(255, 255, 255, 0); border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;padding-top:2px"><i class="far fa-chart-bar" aria-hidden="true"></i>
                                                    <span class="caret"></span>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><a id="bar" onclick="GraphType_Change('Overall','bar');">Bar Chart</a></li>
                                                    <li><a id="doughnut" onclick="GraphType_Change('Overall','doughnut');">Donut Chart</a></li>
                                                </ul>
                                            </div> 
                                            </span>
                                        </div>


                                        <!--tpend-->
                                        <div style="width:300px;margin:auto">
                                            <canvas id="myChart"></canvas>
                                        </div>
                                    </div>
                                </div>





                                <div class="col-md-6 col-sm-6 col-xs-6" id="divOnlyEmployee">
                                    <div class="inner-bx" style="height:370px;">
                                        <div class="tp">
                                            <div class="pull-left hd" style="text-transform: capitalize;">
                                                Assigned To Me
                                            </div>
                                            <%--/*Added By Yasmin on 18th july 2018*/--%>
                                              <%CommonFunctions.HTMLControls.DrawComboBox("overall1", "Usp_NG2_Sel_GraphFilterType 'AssignedToMe'," & Session("LoginType"), 150, , "title='By Request' data-toggle='tooltip' data-placement='bottom' class='slc' onchange=javascript:FilterType_OnChange('AssignedToMe')", False, False)%>
                                            <%CommonFunctions.HTMLControls.DrawComboBox("duration1", "Usp_NG2_Sel_GraphFilterTime ''", 150, , "title='View By' data-toggle='tooltip' data-placement='bottom' class='slc' onchange=javascript:Time_OnChange('AssignedToMe')", False, False)%>

                                          <%--  <select class="slc" id='overall' name='overall'>
                                                <option value='0'>All</option>
                                                <option value='1'>By Department</option>
                                                <option value='2'>By Customer</option>
                                                <option value='3'>By Type</option>
                                                <option value='4'>By Sub Type</option>
                                                <option value='5'>By Severity</option>
                                               
                                            </select>
                                            <select name='duration' id='duration' class="slc">
                                                <option value='0'>Duration</option>
                                                <option value='2'>Current Month</option>
                                                <option value='3'>Today</option>
                                                 <option value='1'>Current Week</option>
                                            </select>--%>



                                            <!--<div class="dropdown pull-right">
  <button class="btn  btn-xs dropdown-toggle" type="button" data-bs-toggle="dropdown" style="background-color:#fff; border:solid #ddd 1px;border-radius: 4px; color:#000000">By Requestor
  <span class="caret"></span></button>
  <ul class="dropdown-menu"> 
    <li><a href="#">HTML</a></li>
    <li><a href="#">CSS</a></li>
    <li><a href="#">JavaScript</a></li>
  </ul>
</div>-->

<%--/*Added By Yasmin on 18th july 2018*/--%>
                                            <span>
	<span class="pull-right" style="padding-top:8px;margin-right: 10PX;">
<button class="btn  btn-xs " type="button" title="Reload Metadata" data-toggle="tooltip" data-placement="bottom" style="background-color:rgba(255, 255, 255, 0); border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;"><i class="fas fa-sync-alt" aria-hidden="true" onclick="FilterType_OnChange('AssignedToMe')"></i></button></span>
                                            <div id="socialShare" class="btn-group share-group">

                                                <button href="#" data-bs-toggle="dropdown" class="btn  dropdown-toggle share" style="background-color: #fff; color: #fe4c72;display:none;">
                                                    <i class="fa fa-share-alt fa-inverse"></i>
                                                </button>
                                                <ul class="dropdown-menu">
                                                   <%-- <li>
                                                        <a data-original-title="Twitter" rel="tooltip" href="#" class="btn btn-twitter" data-placement="left">
                                                            <i class="fa fa-twitter"></i>
                                                        </a>
                                                    </li>--%>
                                                    <li>
                                                        <a data-original-title="Facebook" title="Under Development" data-toggle="tooltip" rel="tooltip" href="#" class="btn btn-facebook" data-placement="left">
                                                            <i class="fa fa-facebook"></i>
                                                        </a>
                                                    </li>
                                                   <%-- <li>
                                                        <a data-original-title="Google+" rel="tooltip" href="#" class="btn btn-google" data-placement="left">
                                                            <i class="fa fa-google-plus"></i>
                                                        </a>
                                                    </li>--%>
                                                    <li>
                                                        <a data-original-title="LinkedIn" title="Under Development" data-toggle="tooltip" rel="tooltip" href="#" class="btn btn-linkedin" data-placement="left">
                                                            <i class="fa fa-linkedin"></i>
                                                        </a>
                                                    </li>
                                                    <%--<li>
                                                        <a data-original-title="Pinterest" rel="tooltip" class="btn btn-pinterest" data-placement="left">
                                                            <i class="fa fa-pinterest"></i>
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a data-original-title="Email" rel="tooltip" class="btn btn-mail" data-placement="left">
                                                            <i class="fa fa-envelope"></i>
                                                        </a>
                                                    </li>--%>
                                                </ul>
                                            </div>



                                                <%--/*Added By Yasmin on 18th july 2018*/--%>
                                            <div class="dropdown pull-right" style="padding-right:4px;">
                                                <button class="btn  btn-xs dropdown-toggle chart" type="button" title = "Select Graph Type" data-placement="bottom" data-bs-toggle="dropdown" style="background-color:rgba(255, 255, 255, 0);; border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;padding-top:2px"><i class="far fa-chart-bar" aria-hidden="true"></i>
                                                    <span class="caret"></span>
                                                </button>
                                                <ul class="dropdown-menu">                                     
                                                     <li><a id="bar1" onclick="GraphType_Change('AssignedToMe','bar');">Bar Chart</a></li>
                                                    <li><a id="doughnut1" onclick="GraphType_Change('AssignedToMe','doughnut');">Donut Chart</a></li>
                                                </ul>
                                            </div>

                                           <%-- <div class="dropdown pull-right">
                                                <button class="btn  btn-xs dropdown-toggle" type="button" data-bs-toggle="dropdown" style="background-color:rgba(255, 255, 255, 0);; border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;"><i class="fa fa-download" aria-hidden="true"></i><span class="caret"></span>
                                                    <span class="caret"></span>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><a>PDF</a>
                                                    </li>
                                                    <li><a>HTML</a>
                                                    </li>
                                                    <li><a>RTF</a>
                                                    </li>
                                                    <li><a>Xlsx</a>
                                                    </li>
                                                    <li><a>Xlsx</a>
                                                    </li>
                                                </ul>
                                            </div>--%>
                                            </span>
                                        </div>

                                        <!--tpend-->



                                        <div style="width:300px;margin:auto">
                                            <canvas id="myChart2"></canvas>
                                        </div>




                                    </div>


                                </div>
                                <%If Session("LoginType") = "C" Then%>
                                <div class="col-md-6 col-sm-6 col-xs-6 " id="divCustomer">
                                    <div class="panel panel-default inner-bx" style="height: 370px;">
                                        <div class="graf-select">
                                            <div class="pull-left hd" style="text-transform: capitalize;">Request In Rate and Out Rate</div>
                                            <%--/*Added By Yasmin on 18th july 2018*/--%>
                                            <%--<%CommonFunctions.HTMLControls.DrawComboBox("InRateOutRate", "Usp_NG2_Sel_GraphFilterType 'InRateOutRate'," & Session("LoginType"), 150, , "title='By Request' class='slc' onchange=javascript:GetInRateOutRateGraph(this.value,'Type')", False, False)%>--%>
                                            <%CommonFunctions.HTMLControls.DrawComboBox("DurationInRateOutRate", "Usp_NG2_Sel_GraphFilterTime 'InRateOutRate'," & Session("LoginType"), 150, , "title='View By' data-toggle='tooltip' data-placement='bottom' class='slc' onchange=javascript:GetInRateOutRateGraph(this.value,'Duration')", False, False)%>

                           <%-- <select name="duration" id="duration" class="slc" style="margin-left: 20px;">
                                <option>Request By Department</option>
                                <option>Request By Agent</option>
                                <option>Request By Type</option>
                                <option>Request By SubType</option>
                                <option>Request By Severity</option>


                            </select>
                            <select name="duration" id="duration" class="slc" style="margin-left: 0px;">
                                <option>Duration</option>
                                <option>Current Month</option>
                                <option>Today</option>
                            </select>--%>


                           <%-- <div class="dropdown pull-right" style="padding-right:4px;">
                                <button class="btn  btn-xs dropdown-toggle" type="button" data-bs-toggle="dropdown" style="background-color:rgba(255, 255, 255, 0);; border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;" aria-expanded="false"><i class="far fa-chart-bar" aria-hidden="true"></i>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a id="bar5">Column Chart</a>
                                    </li>
                                    <li><a id="line5">Donut Chart</a>
                                    </li>

                                </ul>
                            </div>--%>


                        </div>
<%--                        <div class="table-dash">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th style="padding-left:18px;">Department</th>
                                        <th>Customer</th>

                                        <th>Request Type</th>
                                        <th>Sub Request Type</th>
                                        <th>Priority</th>
                                        <th>Severity</th>


                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td style="padding-left:18px;">Administrator</td>
                                        <td>Hexaware</td>

                                        <td>Type1</td>
                                        <td>Sub Request Type1</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                    <tr>
                                        <td style="padding-left:18px;">Sales</td>
                                        <td>Hexaware</td>

                                        <td>Type2</td>
                                        <td>Sub Request Type2</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                    <tr>
                                        <td style="padding-left:18px;">Market</td>
                                        <td>Direction</td>
                                        <td>Unit3</td>

                                        <td>Sub Request Type3</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                    <tr>
                                        <td style="padding-left:18px;">Support</td>
                                        <td>Hexaware</td>

                                        <td>Type4</td>
                                        <td>Sub Request Type4</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                    <tr>
                                        <td style="padding-left:18px;">Alliance</td>
                                        <td>Hexaware</td>

                                        <td>Type5</td>
                                        <td>Sub Request Type5</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                    <tr>
                                        <td style="padding-left:18px;">Development</td>
                                        <td>Direction</td>

                                        <td>Type6</td>
                                        <td>Sub Request Type6</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                    <tr>
                                        <td style="padding-left:18px;">Human Resource</td>
                                        <td>NSDL</td>

                                        <td>Type7</td>
                                        <td>Sub Request Type7</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>--%>
                        <div class="head-top" style="width:100%;float:none">
                            <div  style="padding: 0px; position: relative;" id="divMainChart">

                                <canvas id="main-chart"></canvas>
                            </div>
                        </div>
                    </div>
                                    </div>
                                <%End If%>
                            </div>


                        </div>
                    </div>
                </div>


                <div class="col-md-12 col-xs-12" style="padding-top: 30px;display:none">
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <div class="inner-bx" style="height:370px;">
                                <!--tpstart-->
                                <div class="tp">
                                    <div class="pull-left hd" style="text-transform: capitalize;">
                                        SLA Adherence
                                    </div>


                                    <select class="slc" id='overall' name='overall'>
                                        <option value='0'>All</option>
                                        <option value='1'>By Department</option>
                                        <option value='2'>By Customer</option>
                                        <option value='3'>By Type</option>
                                        <option value='4'>By Sub Type</option>
                                        <option value='5'>By Severity</option>
                                    </select>
                                    <select name='duration' id='duration' class="slc">
                                        <option  value='1'>Duration</option>
                                        <option  value='1'>Current Month</option>
                                        <option  value='1'>Today</option>                                        
                                    </select>



                  <%--/*Added By Yasmin on 18th july 2018*/--%>
                                                      <span>
	<span class="pull-right" style="padding-top:8px;margin-right: 10PX;">
<button class="btn  btn-xs reload" type="button" title="Reload Metadata" data-bs-toggle="dropdown" style="background-color:rgba(255, 255, 255, 0); border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;"><i class="fas fa-sync-alt" aria-hidden="true"></i></button></span>
                                    <div id="socialShare" class="btn-group share-group">

                                        <button href="#" data-bs-toggle="dropdown" class="btn  dropdown-toggle share" style="background-color: #fff; color: #fe4c72;display:none;">
                                            <i class="fa fa-share-alt fa-inverse"></i>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <%--<li>
                                                <a data-original-title="Twitter" rel="tooltip" href="#" class="btn btn-twitter" data-placement="left">
                                                    <i class="fa fa-twitter"></i>
                                                </a>
                                            </li>--%>
                                            <li>
                                                <a data-original-title="Facebook" title="Under Development" data-toggle="tooltip" rel="tooltip" href="#" class="btn btn-facebook" data-placement="left">
                                                    <i class="fa fa-facebook"></i>
                                                </a>
                                            </li>
                                            <%--<li>
                                                <a data-original-title="Google+" rel="tooltip" href="#" class="btn btn-google" data-placement="left">
                                                    <i class="fa fa-google-plus"></i>
                                                </a>
                                            </li>--%>
                                            <li>
                                                <a data-original-title="LinkedIn" title="Under Development" data-toggle="tooltip" rel="tooltip" href="#" class="btn btn-linkedin" data-placement="left">
                                                    <i class="fa fa-linkedin"></i>
                                                </a>
                                            </li>
                                            <%--<li>
                                                <a data-original-title="Pinterest" rel="tooltip" class="btn btn-pinterest" data-placement="left">
                                                    <i class="fa fa-pinterest"></i>
                                                </a>
                                            </li>
                                            <li>
                                                <a data-original-title="Email" rel="tooltip" class="btn btn-mail" data-placement="left">
                                                    <i class="fa fa-envelope"></i>
                                                </a>
                                            </li>--%>
                                        </ul>
                                    </div>




                                       <%--/*Added By Yasmin on 18th july 2018*/--%>         
                                    <div class="dropdown pull-right" style="margin-right: 4px;">
                                        <button class="btn  btn-xs dropdown-toggle chart" type="button" title = "Select Graph Type" data-placement="bottom"  data-bs-toggle="dropdown" style="background-color:rgba(255, 255, 255, 0);; border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;padding-top:2px"><i class="far fa-chart-bar" aria-hidden="true"></i>
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a id="bar2">Column Chart</a>
                                            </li>
                                            <li><a id="line2">Donut Chart</a>
                                            </li>

                                        </ul>
                                    </div>
                                    </span>
                                </div>
                                <!--tpend-->
                                <canvas id="myChart3"></canvas>





                            </div>
                        </div>

                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <div class="inner-bx" style="height:370px;">
                                <!--tpstart-->
                                <div class="tp">
                                    <div class="pull-left hd" style="text-transform: capitalize;">
                                        SLA Adherence
                                    </div>


                                    <select class="slc" id='overall' name='overall'>
                                        <option value='dept'>All</option>
                                        <option value='dept'>By Department</option>
                                        <option value='ct'>By Customer</option>
                                        <option value='tp'>By Type</option>
                                        <option value='stp'>By Sub Type</option>
                                        <option value='sv'>By Severity</option>


                                    </select>
                                    <select name='duration' id='duration' class="slc">
                                        <option>Duration</option>
                                        <option>Current Month</option>
                                        <option>Today</option>
                                    </select>



                                    <!--<div class="dropdown pull-right">
  <button class="btn  btn-xs dropdown-toggle" type="button" data-bs-toggle="dropdown" style="background-color:#fff; border:solid #ddd 1px;border-radius: 4px; color:#000000">By Requestor
  <span class="caret"></span></button>
  <ul class="dropdown-menu"> 
    <li><a href="#">HTML</a></li>
    <li><a href="#">CSS</a></li>
    <li><a href="#">JavaScript</a></li>
  </ul>
</div>-->

<%--/*Added By Yasmin on 18th july 2018*/--%>
                                    <span>
	<span class="pull-right" style="padding-top:8px;margin-right: 10PX;">
<button class="btn  btn-xs " type="button" title="Reload Metadata" data-bs-toggle="dropdown" style="background-color:rgba(255, 255, 255, 0); border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;"><i class="fas fa-sync-alt" aria-hidden="true"></i></button></span>
                                    <div id="socialShare" class="btn-group share-group">

                                        <button href="#" data-bs-toggle="dropdown" class="btn  dropdown-toggle share" style="background-color: #fff; color: #fe4c72;display:none;">
                                            <i class="fa fa-share-alt fa-inverse"></i>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <%--<li>
                                                <a data-original-title="Twitter" rel="tooltip" href="#" class="btn btn-twitter" data-placement="left">
                                                    <i class="fa fa-twitter"></i>
                                                </a>
                                            </li>--%>
                                            <li>
                                                <a data-original-title="Facebook" title="Under Development" data-toggle="tooltip" rel="tooltip" href="#" class="btn btn-facebook" data-placement="left">
                                                    <i class="fa fa-facebook"></i>
                                                </a>
                                            </li>
                                           <%-- <li>
                                                <a data-original-title="Google+" rel="tooltip" href="#" class="btn btn-google" data-placement="left">
                                                    <i class="fa fa-google-plus"></i>
                                                </a>
                                            </li>--%>
                                            <li>
                                                <a data-original-title="LinkedIn" title="Under Development" data-toggle="tooltip" rel="tooltip" href="#" class="btn btn-linkedin" data-placement="left">
                                                    <i class="fa fa-linkedin"></i>
                                                </a>
                                            </li>
                                           <%-- <li>
                                                <a data-original-title="Pinterest" rel="tooltip" class="btn btn-pinterest" data-placement="left">
                                                    <i class="fa fa-pinterest"></i>
                                                </a>
                                            </li>
                                            <li>
                                                <a data-original-title="Email" rel="tooltip" class="btn btn-mail" data-placement="left">
                                                    <i class="fa fa-envelope"></i>
                                                </a>
                                            </li>--%>
                                        </ul>
                                    </div>




                                        <%--/*Added By Yasmin on 18th july 2018*/--%>
                                    <div class="dropdown pull-right" style="padding-right:4px;">
                                        <button class="btn  btn-xs dropdown-toggle chart" type="button" title = "Select Graph Type" data-placement="bottom"  data-bs-toggle="dropdown" style="background-color:rgba(255, 255, 255, 0);; border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;padding-top:2px"><i class="far fa-chart-bar" aria-hidden="true"></i>
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a id="bar4">Column Chart</a>
                                            </li>
                                            <li><a id="line4">Donut Chart</a>
                                            </li>

                                        </ul>
                                    </div>

                                    <%--<div class="dropdown pull-right">
                                        <button class="btn  btn-xs dropdown-toggle" type="button" data-bs-toggle="dropdown" style="background-color:rgba(255, 255, 255, 0);; border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;"><i class="fa fa-download" aria-hidden="true"></i><span class="caret"></span>
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a>PDF</a>
                                            </li>
                                            <li><a>HTML</a>
                                            </li>
                                            <li><a>RTF</a>
                                            </li>
                                            <li><a>Xlsx</a>
                                            </li>
                                            <li><a>Xlsx</a>
                                            </li>
                                        </ul>
                                    </div>--%>
                                    </span>
                                </div>
                                <!--tpend-->
                                <canvas id="myChart4"></canvas>


                            </div>
                        </div>


                    </div>
                </div>

                <%If Session("LoginType") <> "C" Then%>
                <div class="col-md-12 col-xs-12" style="background-color: #f8f9fa;">

                    <div class="col-md-12 col-xs-12 inner-bx" style="padding-top: 30px">
                        <div class="panel panel-default">
                            <div class="graf-select">
                                <div class="pull-left hd" style="text-transform: capitalize;">Request In Rate and Out Rate</div>
                                <%--/*Added By Yasmin on 18th july 2018*/--%>
                                <%--<%CommonFunctions.HTMLControls.DrawComboBox("InRateOutRate", "Usp_NG2_Sel_GraphFilterType 'InRateOutRate'," & Session("LoginType"), 150, , "title='By Request' class='slc' onchange=javascript:GetInRateOutRateGraph(this.value,'Type')", False, False)%>--%>
                                <%CommonFunctions.HTMLControls.DrawComboBox("DurationInRateOutRate", "Usp_NG2_Sel_GraphFilterTime 'InRateOutRate'," & Session("LoginType"), 150, , "title='View By' data-toggle='tooltip' data-placement='bottom'  class='slc' onchange=javascript:GetInRateOutRateGraph(this.value,'Duration')", False, False)%>
                           <%-- <select name="duration" id="duration" class="slc" style="margin-left: 20px;">
                                <option>Request By Department</option>
                                <option>Request By Agent</option>
                                <option>Request By Type</option>
                                <option>Request By SubType</option>
                                <option>Request By Severity</option>


                            </select>
                            <select name="duration" id="duration" class="slc" style="margin-left: 0px;">
                                <option>Duration</option>
                                <option>Current Month</option>
                                <option>Today</option>
                            </select>--%>


                           <%-- <div class="dropdown pull-right" style="padding-right:4px;">
                                <button class="btn  btn-xs dropdown-toggle" type="button" data-bs-toggle="dropdown" style="background-color:rgba(255, 255, 255, 0);; border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;" aria-expanded="false"><i class="far fa-chart-bar" aria-hidden="true"></i>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a id="bar5">Column Chart</a>
                                    </li>
                                    <li><a id="line5">Donut Chart</a>
                                    </li>

                                </ul>
                            </div>--%>


                        </div>
<%--                        <div class="table-dash">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th style="padding-left:18px;">Department</th>
                                        <th>Customer</th>

                                        <th>Request Type</th>
                                        <th>Sub Request Type</th>
                                        <th>Priority</th>
                                        <th>Severity</th>


                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td style="padding-left:18px;">Administrator</td>
                                        <td>Hexaware</td>

                                        <td>Type1</td>
                                        <td>Sub Request Type1</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                    <tr>
                                        <td style="padding-left:18px;">Sales</td>
                                        <td>Hexaware</td>

                                        <td>Type2</td>
                                        <td>Sub Request Type2</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                    <tr>
                                        <td style="padding-left:18px;">Market</td>
                                        <td>Direction</td>
                                        <td>Unit3</td>

                                        <td>Sub Request Type3</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                    <tr>
                                        <td style="padding-left:18px;">Support</td>
                                        <td>Hexaware</td>

                                        <td>Type4</td>
                                        <td>Sub Request Type4</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                    <tr>
                                        <td style="padding-left:18px;">Alliance</td>
                                        <td>Hexaware</td>

                                        <td>Type5</td>
                                        <td>Sub Request Type5</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                    <tr>
                                        <td style="padding-left:18px;">Development</td>
                                        <td>Direction</td>

                                        <td>Type6</td>
                                        <td>Sub Request Type6</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                    <tr>
                                        <td style="padding-left:18px;">Human Resource</td>
                                        <td>NSDL</td>

                                        <td>Type7</td>
                                        <td>Sub Request Type7</td>
                                        <td>Low</td>
                                        <td>High</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>--%>
                        <div class="head-top" style="width:100%;float:none">
                            <div  style="height: 370px;padding: 0px; position: relative;" id="divMainChart">

                                <canvas id="main-chart" style="height: 370px;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                </div>
            <%End If%>

                <div class="col-md-12 col-xs-12" style="background-color: #f8f9fa;">
                    <div class="col-md-12 col-xs-12 inner-bx" style="padding-top: 30px">
                        <div class="panel panel-default">
                            <div class="tp">
                                <div class="pull-left hd" style="text-transform: capitalize;">
                                    <i class="fa fa-question-circle-o fa-lg" data-toggle="tooltip" title="Pareto Chart is a special form of bar chart. It is used to identify the vital few sources
that are responsible for causing the biggest effect, so we know where to focus our efforts to achieve the greatest improvements.
The categories are shown on the horizontal axis, category values are represented by vertical bars in descending order (longest to shortest from left to right), and the cumulative total as percentage is represented by the line." style="color:grey;cursor:pointer;"></i>
                                    Request Analysis (Pareto)
                                </div>
                                <%--/*Added By Yasmin on 18th july 2018*/--%>
                                <%CommonFunctions.HTMLControls.DrawComboBox("overallPare", "Usp_NG2_Sel_GraphFilterType 'Pareto'," & Session("LoginType"), 150, , "title='By Request' data-toggle='tooltip' data-placement='bottom' class='slc' onchange=javascript:DrawPareToAnalysis(this.value)", False, False)%>
                            </div>
                            <%--Added by Ashwini M on 29-3-2023--%> 
                            <div style="max-height:370px; padding: 0px; position: relative;">
                                <canvas id="combo-chart" style="max-height: 370px;"></canvas>
                            </div>
                            <%--End of added by Ashwini M on 29-3-2023--%>
                        </div>
                    </div>
                </div>

                <div class="col-md-12 col-xs-12" style="background-color: #f8f9fa;">
                    <div class="col-md-12 col-xs-12 inner-bx" style="padding-top: 30px">
                        <div class="panel panel-default">
                            <div class="tp">
                                <div class="pull-left hd" style="text-transform: capitalize;">
                                    Time Scale - In Rate and Out Rate
                                </div>

                                <%--<%CommonFunctions.HTMLControls.DrawComboBox("overallTimeScale", "Usp_NG2_Sel_GraphFilterType 'TimeScale'," & Session("LoginType"), 150, , "title='By Request' class='slc' onchange=javascript:DrawTimeScale(this.value)", False, False)%>--%>
                            </div>
                            <div style="padding: 0px; position: relative;">
                                <canvas id="Area-chart" style="height: 370px;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <%If CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_AllowToSeeHelpdeskSLAGraph " & Session("intLoginID") & "," & Session("LoginType"), True), "") = "1" Then%>
                <div class="col-md-12 col-xs-12" style="background-color: #f8f9fa;">
                    <div class="col-md-12 col-xs-12 inner-bx" style="padding-top: 30px">
                        <div class="panel panel-default">
                            <div class="tp">
                                <div class="pull-left hd" style="text-transform: capitalize;">
                                    SLA Adherence
                                    
                                </div>
                                <%--/*Added By Yasmin on 18th july 2018*/--%>
                                <%--Modified by yogesh Jalamkar on 03-Jan-2017 Purpose:Issue fixing issue id= 10045--%>
                                <% If Session("LoginType") = "E" Then%> 
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboAdhere", "Usp_NG2_Sel_GraphFilterType 'SLAType'", 150, , "class='slc' title = 'Request Posted' data-toggle='tooltip' data-placement='bottom' onchange=javascript:DrawSLAAdhere(this.value,document.getElementById('cboAdhereDuration').value,SLAType)", False, False)%>
                                <%CommonFunctions.HTMLControls.DrawComboBox("cboAdhereDuration", "Usp_NG2_Sel_GraphFilterTime 'SLADuration'", 150, , "class='slc' title = 'View By'  data-toggle='tooltip' data-placement='bottom' onchange=javascript:DrawSLAAdhere(document.getElementById('cboAdhere').value,this.value,SLAType)", False, False)%>
                                <div class="dropdown pull-right" style="margin-right: 10px;">
                                    <button class="btn  btn-xs dropdown-toggle chart" type="button" title = "Select Graph Type" data-placement="bottom"  data-bs-toggle="dropdown" style="background-color:rgba(255, 255, 255, 0); border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;padding-top:2px"><i class="far fa-chart-bar" aria-hidden="true"></i>
                                    <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                    <li><a id="doughnut" onclick="DrawSLAAdhere(document.getElementById('cboAdhere').value, document.getElementById('cboAdhereDuration').value,'doughnut');">Donut Chart</a></li>
                                    <li><a id="pie" onclick="DrawSLAAdhere(document.getElementById('cboAdhere').value, document.getElementById('cboAdhereDuration').value,'pie');">Pie Chart</a></li>
                                    </ul>
                                </div>
                                <% Else%>
                                <%--/*Added By Yasmin on 18th july 2018*/--%>
                                  <%CommonFunctions.HTMLControls.DrawComboBox("cboAdhereDuration", "Usp_NG2_Sel_GraphFilterTime 'SLADuration'", 150, , "class='slc' title = 'View By' data-toggle='tooltip' data-placement='bottom' onchange=javascript:DrawSLAAdhere(1,this.value,SLAType)", False, False)%>
                                <div class="dropdown pull-right" style="margin-right: 10px;">
                                    <button class="btn  btn-xs dropdown-toggle chart" type="button" title = "Select Graph Type" data-placement="bottom"  data-bs-toggle="dropdown"  style="background-color:rgba(255, 255, 255, 0);; border:solid #ddd 1px;border-radius: 2px; color:#000000; margin-top:0px;height: 25px;"><i class="far fa-chart-bar" aria-hidden="true"></i>
                                    <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                    <li><a id="doughnut" onclick="DrawSLAAdhere(1, document.getElementById('cboAdhereDuration').value,'doughnut');">Donut Chart</a></li>
                                    <li><a id="pie" onclick="DrawSLAAdhere(1, document.getElementById('cboAdhereDuration').value,'pie');">Pie Chart</a></li>
                                    </ul>
                                </div>
                              <%End If%>
                                <%--End of modification by Yogesh Jalamkar--%>
                            </div>
                            <div style="padding: 0px;position: relative;height: 680px;"> <%--//Added By Dipali V On 9th May 2023 For Overall Grpah Height issue--%>
                                <table style="width:100%">
                                    <tr>
                                        <td style="width:30%;vertical-align: top;">
                                            <table>
                                                <tr>
                                                    <td id="tdData">

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="border-top:1px solid #ddd;">
                                                        <div class="col-sm-12">
                                                            <div class="pull-left hd" style="text-transform: capitalize;">
                                                                Overall
                                                            </div>
                                                            <div id="divOverAll" style="height:300px;height:300px">
                                                             <canvas id="chartOverAll" style="height: 200px;"></canvas>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td  style="width:70%;vertical-align: top;border-left:1px solid #ddd;">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="pull-left hd" style="text-transform: capitalize;">
                                                        Acknowledgement
                                                    </div>
                                                    <div id="divAcknowledgement">
                                                     <canvas id="chartAcknowledgement" style="height: 200px;"></canvas>
                                                        </div>
                                                </div>
                                                <div class="col-sm-6">
                                                     <div class="pull-left hd" style="text-transform: capitalize;">
                                                        Response
                                                    </div>
                                                     <div id="divResponse">
                                                     <canvas id="chartResponse" style="height: 200px;"></canvas>
                                                         </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                     <div class="pull-left hd" style="text-transform: capitalize;">
                                                        Resolution
                                                    </div>
                                                    <div id="divResolution">
                                                     <canvas id="chartResolution" style="height: 200px;"></canvas>
                                                     </div>
                                                </div>
                                                <div class="col-sm-6">
                                                     <div class="pull-left hd" style="text-transform: capitalize;">
                                                        Closure
                                                    </div>
                                                    <div id="divClosure">
                                                     <canvas id="chartClosure" style="height: 200px;"></canvas>
                                                        </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
               <%End If%>
        </div>
     </div>

                <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
                <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script> -->
                <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
                <script src="../../../Whizible2.0-new/plugins/chartjs/utils.js"></script>
                <script src="../../../Whizible2.0-new/dist/js/popper.min.js"></script>
                <script src="../../../Whizible2.0-new/dist/js/New_CommonFunctions.js"></script>
                <script src="../../../Whizible2.0-new/dist/js/dash-graph.js"></script>
                <script type="text/javascript">
                   <%--/*Added By Yasmin on 18th july 2018*/--%>
                    $('[data-toggle="tooltip"]').tooltip();
                    $(".reload").tooltip();
                    $(".chart").tooltip();
                    $('[data-toggle="tooltip"]').click(function () {
                        $('.tooltip').fadeOut('fast', function () {
                            $('.tooltip').remove();
                        });
                    });
                    $('.btn').hover(function () {
                        $('.tooltip').fadeIn('fast', function () {
                            $('.tooltip').add();
                        });
                    });
                    $(".chart").click(function () {
                        $('.tooltip').fadeOut('fast', function () {
                            $('.tooltip').remove();
                        });
                    });
                    $(".chart").hover(function () {
                        $('.tooltip').fadeIn('fast', function () {
                            $('.tooltip').add();
                        });
                    });
                    var SLAType = 'doughnut'

                    var strPageName = 'Helpdesk_Dashboard.aspx';
                    /*
                                    
                                    window.onload = function change(newType) {
                                      var ctx = document.getElementById("myChart").getContext("2d");
                                    
                                    
                                      myChart = new Chart(ctx, config);
                                    };
                                    
                                    
                                    */

                    window.onload = function () {
                        var myChart;
                        var myChart1;
                        var myChart2;
                        var myChart3;
                        var myChart4;
                           <%If Session("LoginType") = "C" Then%>
                        document.getElementById("divOnlyEmployee").style.display = "none";
                        //document.getElementById("overallTimeScale").style.display = "none";

                        //document.getElementById("divAll").style.width = "100%";
                        //document.getElementById("divAll").style.maxWidth = "100%";
                    <%End If%>
                        change("doughnut", "0", "0");
                        change1("doughnut", "0", "0");
                        change2("doughnut");
                        change3("doughnut");
                        DrawPareToAnalysis(document.getElementById("overallPare").value)
                        GetInRateOutRateGraph(document.getElementById("DurationInRateOutRate").value, 'Duration')
                        DrawTimeScale("1")
                        ChangeTooltip()
                        try {
                            if (document.getElementById("cboAdhere") != null) {
                                DrawSLAAdhere(document.getElementById("cboAdhere").value, document.getElementById("cboAdhereDuration").value, SLAType);
                            }
                            else {
                                DrawSLAAdhere(1, document.getElementById("cboAdhereDuration").value, SLAType);
                            }
                        }
                        catch (e) {
                            DrawSLAAdhere(1, 1, SLAType);
                        }
                    }





                    var myChart;

                    //$("#line").click(function() {
                    //    change('doughnut', "0", "0");
                    //});

                    //$("#bar").click(function() {
                    //    change('bar', "0", "0");
                    //});                   


                    //default view


                    function change(newType, strFilter, strTime) {
                        ChangeTooltip()
                        var strResult, data;
                        var GraphParamters = {};

                        GraphParamters.FilterType = strFilter;
                        GraphParamters.Time = strTime;

                        data = JSON.stringify({ GraphParamters: GraphParamters });

                        strResult = AJAXCallWithResult(strPageName + '/GetOverallGraphData', data, false);
                        var strStatus = [];
                        var StatusCount = [];
                        var arrBackColor = [];
                        var r = 0;
                        var g = 0;
                        var b = 0;
                        if (strResult.d != "") {

                            $.each(JSON.parse(strResult.d), function (id, object) {
                                strStatus.push(object["X_AXIS"]);
                                StatusCount.push(object["Y_AXIS"]);
                                //arrBackColor.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                                arrBackColor.push("hsl(" + r + ", 100%, 70%)");
                                r += 30;
                            });

                        }

                        
                        var options = {}
                        if (newType == "bar") {
                            options = {
                                responsive: true,
                                legend: {
                                    display: false,
                                    position: 'right',
                                },
                                scales: {
                                    xAxes: [{
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 25,
                                            minRotation: 25,
                                            beginAtZero: true,
                                            suggestedMin:0
                                        }
                                    }]
                                }
                            }
                        }
                        else {
                            options = {
                                responsive: true,
                                legend: {
                                    position: 'right',
                                },
                            }
                        }
                        var ctx = document.getElementById("myChart").getContext("2d");
                        var config = {
                            type: newType,
                            data: {
                                labels: strStatus,
                                datasets: [{
                                    label: "",
                                    data: StatusCount,
                                    fill: false,
                                    backgroundColor: arrBackColor,
                                }, ]
                            },
                            options: options,

                        };



                        // Remove the old chart and all its event handles
                        if (myChart) {
                            myChart.destroy();
                        }

                        // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
                        var temp = jQuery.extend(true, {}, config);
                        temp.type = newType;
                        myChart = new Chart(ctx, temp);
                    };
                    //second



                    var myChart2;
                    $("#line2").click(function () {
                        var objFilterType, objFilterTime;

                        objFilterType = $("#overall1");
                        objFilterTime = $("#duration1");

                        change1('doughnut', objFilterType.val(), objFilterTime.val());
                    });

                    $("#bar2").click(function () {
                        var objFilterType, objFilterTime;

                        objFilterType = $("#overall1");
                        objFilterTime = $("#duration1");

                        change1('bar', objFilterType.val(), objFilterTime.val());
                    });

                    Chart.plugins.register({
                        afterDraw: function (chart) {
                            var isPlot = 0;
                            for (var i = 0; i < chart.config.data.datasets["0"].data.length; i++) {
                                if (chart.config.data.datasets["0"].data[i] > 0) {
                                    isPlot = 1;
                                }

                            }

                            if (chart.data.labels.length === 0 || isPlot == 0) {
                                // No data is present
                                var ctx = chart.chart.ctx;
                                var width = chart.chart.width;
                                var height = chart.chart.height
                                chart.clear();
                                if (ctx.canvas.id=="chartAcknowledgement"||ctx.canvas.id=="chartResponse"||ctx.canvas.id=="chartResolution"||ctx.canvas.id=="chartOverAll"||ctx.canvas.id=="chartClosure"){
                                    $("#" + ctx.canvas.id).parent().html("<div style='float:left;text-align:center;padding-top:25%;width:" + ctx.canvas.style.width + ";height:" + ctx.canvas.style.height + ";font-size:12px;font-family:Helvetica;'>No data to display</div>")
                                }
                                else{
                                    ctx.save();
                                    ctx.textAlign = 'center';
                                    ctx.textBaseline = 'middle';
                                    ctx.font = "16px normal 'Helvetica Nueue'";
                                    ctx.fillStyle = "black";
                                    ctx.fillText('No data to display', width / 2, height / 2);
                                    ctx.restore();
                                }
                            }
                        }
                    });

                    function change1(newType, strFilter, strTime) {
                        ChangeTooltip()
                        var strResult, data;
                        var GraphParamters = {};

                        GraphParamters.FilterType = strFilter;
                        GraphParamters.Time = strTime;

                        data = JSON.stringify({ GraphParamters: GraphParamters });

                        strResult = AJAXCallWithResult(strPageName + '/GetAssignedToMeGraphData', data, false);
                        var strStatus = [];
                        var StatusCount = [];
                        var arrBackColor = [];
                        var r = 0;
                        var g = 80;
                        var b = 80;

                        if (strResult.d != "") {

                            $.each(JSON.parse(strResult.d), function (id, object) {
                                strStatus.push(object["Xaxis"]);
                                StatusCount.push(object["Yaxis"]);
                                //arrBackColor.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                                arrBackColor.push("hsl(" + r + ", 100%, 70%)");
                                r += 30;
                            });

                        }

                        var options = {}
                        if (newType == "bar") {
                            options = {
                                responsive: true,
                                legend: {
                                    display: false,
                                    position: 'right',
                                },
                                scales: {
                                    xAxes: [{
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90
                                        }
                                    }]
                                }
                            }
                        }
                        else {
                            options = {
                                responsive: true,
                                legend: {
                                    position: 'right',
                                },
                            }
                        }

                        var config1 = {
                            type: newType,
                            data: {
                                labels: strStatus,
                                datasets: [{
                                    label: "Assigned To Me",
                                    data: StatusCount,
                                    fill: false,
                                    backgroundColor: arrBackColor,
                                }, ]
                            },
                            options: options,
                        };


                        var ctx2 = document.getElementById("myChart2").getContext("2d");

                        // Remove the old chart and all its event handles
                        if (myChart2) {
                            myChart2.destroy();
                        }

                        // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
                        var temp = jQuery.extend(true, {}, config1);
                        temp.type = newType;
                        myChart2 = new Chart(ctx2, temp);
                    };

                    //SECOND



                    var myChart3;
                    //$("#line1").click(function() {
                    //    var objFilterType, objFilterTime;

                    //    objFilterType = $("#overall1");
                    //    objFilterTime = $("#duration1");

                    //    change1('doughnut', objFilterType.val(), objFilterTime.val());
                    //});

                    //$("#bar1").click(function() {
                    //    var objFilterType, objFilterTime;

                    //    objFilterType = $("#overall1");
                    //    objFilterTime = $("#duration1");

                    //    change1('bar', objFilterType.val(), objFilterTime.val());
                    //});




                    function change2(newType) {
                        var ctx3 = document.getElementById("myChart3").getContext("2d");

                        // Remove the old chart and all its event handles
                        if (myChart3) {
                            myChart3.destroy();
                        }

                        var config = {
                            type: 'doughnut',
                            data: {
                                labels: ["New", "Assigned", "In Progress", "Awaiting Response", "Resolved"],
                                datasets: [{
                                    label: "SLA",
                                    data: [1, 2, 3, 4, 5],
                                    fill: false,
                                    backgroundColor: [
                                        '#32c6c6',
                                        '#fe4c72',
                                        '#ffc02b',
                                        '#32c6c6',
                                        '#935dff',
                                        '#ff9124'
                                    ],
                                    borderColor: [
                                        'rgba(2, 153, 255,1)',
                                        'rgba(254, 76, 114, 1)',
                                        'rgba(255, 206, 86, 1)',
                                        'rgba(75, 192, 192, 1)',
                                        'rgba(153, 102, 255, 1)',
                                        'rgba(255, 159, 64, 1)'
                                    ]
                                }, ]
                            },
                            options: {
                                responsive: true,
                            }
                        };

                        // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
                        var temp = jQuery.extend(true, {}, config);
                        temp.type = newType;
                        myChart3 = new Chart(ctx3, temp);
                    };



                    //FOURTH

                    var myChart4;
                    $("#line4").click(function () {
                        change3('doughnut');
                    });

                    $("#bar4").click(function () {
                        change3('bar');
                    });

                    function change3(newType) {
                        var ctx7 = document.getElementById("myChart4").getContext("2d");

                        var config3 = {
                            type: 'doughnut',
                            data: {
                                labels: ["Met", "Not Met", "No Action"],
                                datasets: [{
                                    label: "SLA",
                                    data: [1, 2, 3, 4, 5],
                                    fill: false,
                                    backgroundColor: [
                                        '#32c6c6',
                                        '#fe4c72',
                                        '#ffc02b',
                                        '#32c6c6',
                                        '#935dff',
                                        '#ff9124'
                                    ],
                                    borderColor: [
                                        'rgba(2, 153, 255,1)',
                                        'rgba(254, 76, 114, 1)',
                                        'rgba(255, 206, 86, 1)',
                                        'rgba(75, 192, 192, 1)',
                                        'rgba(153, 102, 255, 1)',
                                        'rgba(255, 159, 64, 1)'
                                    ]
                                }, ]
                            },
                            options: {
                                responsive: true,
                            }
                        };


                        // Remove the old chart and all its event handles
                        if (myChart4) {
                            myChart4.destroy();
                        }
                        var temp = jQuery.extend(true, {}, config3);
                        temp.type = newType;
                        myChart4 = new Chart(ctx7, temp);
                    };

                    // Chart.js modifies the object you pass in. Pass a copy of the

                    function FilterType_OnChange(strWhichGraph) {
                        var objFilterType, objFilterTime;

                        if (strWhichGraph == 'Overall') {
                            objFilterType = $("#overall");
                            objFilterTime = $("#duration");

                            if (objFilterType.val() == 0) {
                                change('doughnut', objFilterType.val(), objFilterTime.val());
                            }
                            else {
                                change('bar', objFilterType.val(), objFilterTime.val());
                            }



                        }
                        else if (strWhichGraph == 'AssignedToMe') {
                            objFilterType = $("#overall1");
                            objFilterTime = $("#duration1");

                            change1('doughnut', objFilterType.val(), objFilterTime.val());
                        }

                    }

                    function Time_OnChange(strWhichGraph) {
                        var objFilterType, objFilterTime;

                        if (strWhichGraph == 'Overall') {
                            objFilterType = $("#overall");
                            objFilterTime = $("#duration");

                            change('doughnut', objFilterType.val(), objFilterTime.val());

                        }
                        else if (strWhichGraph == 'AssignedToMe') {
                            objFilterType = $("#overall1");
                            objFilterTime = $("#duration1");

                            change1('doughnut', objFilterType.val(), objFilterTime.val());
                        }

                    }

                    function GraphType_Change(GraphFlag, GraphType) {
                        switch (GraphFlag) {
                            case "Overall":
                                var objFilterType, objFilterTime;

                                objFilterType = $("#overall");
                                objFilterTime = $("#duration");

                                change(GraphType, objFilterType.val(), objFilterTime.val());
                                break;
                            case "AssignedToMe":
                                var objFilterType, objFilterTime;

                                objFilterType = $("#overall1");
                                objFilterTime = $("#duration1");

                                change1(GraphType, objFilterType.val(), objFilterTime.val());
                                break;
                        }
                    }


                    var pareChart;
                    function DrawPareToAnalysis(filterBy) {
                        var ctx6 = document.getElementById("combo-chart").getContext("2d");

                        var strResult, data;
                        //var GraphParamters = {};

                        //GraphParamters.FilterType = strFilter;
                        //GraphParamters.Time = strTime;

                        data = JSON.stringify({ strGraphFilter: filterBy });

                        console.log(data)
                        strResult = AJAXCallWithResult(strPageName + '/GetParetoAnalysisGraphData', data, false);
                        var strEntityCount = [];
                        var PercentCount = [];
                        var arrBackColor = [];
                        var strLabels = [];
                        if (strResult.d != "") {

                            $.each(JSON.parse(strResult.d), function (id, object) {
                                strLabels.push(object["Entity"]);
                                strEntityCount.push(object["EntityCount"]);
                                PercentCount.push(object["PercentCount"]);
                                arrBackColor.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                            });

                        }

                        var config1 = {
                            type: 'bar',
                            data: {
                                labels: strLabels,
                                datasets: [{
                                    type: 'line',
                                    label: 'Cumulative Percentage',
                                    borderColor: '#80ff80',
                                    borderWidth: 2,
                                    fill: false,
                                    data: PercentCount,
                                    yAxisID: "y-axis-2",
                                }, {

                                    type: 'bar',
                                    label: $("#overallPare option:selected").text(),
                                    backgroundColor: '#005ce6',
                                    data: strEntityCount,
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
                                            labelString: 'Request Count'
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

                        // Remove the old chart and all its event handles
                        if (pareChart) {
                            pareChart.destroy();
                        }

                        // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
                        var temp = jQuery.extend(true, {}, config1);
                        temp.type = 'bar';
                        pareChart = new Chart(ctx6, temp);
                    };


                    var InOutRateChart;
                    function GetInRateOutRateGraph(filterBy, filterType) {
                         <%If Session("LoginType") <> "C" Then%>
                        document.getElementById("divMainChart").innerHTML = '<canvas id="main-chart" style="height: 370px;"></canvas>';
                        document.getElementById("divMainChart").style.width = window.innerWidth - 135 + 'px';
                        document.getElementById("main-chart").style.marginLeft = "5px";
                        document.getElementById("main-chart").style.width = window.innerWidth + 'px';
                        <%Else%>
                        document.getElementById("divMainChart").innerHTML = '<canvas id="main-chart"></canvas>';
                        <%End If%>
                        var ctx8 = document.getElementById("main-chart").getContext("2d");
                        var strResult, data;
                        //var GraphParamters = {};

                        //GraphParamters.FilterType = strFilter;
                        //GraphParamters.Time = strTime;
                        var Type;
                        var Duration;
                        if (filterType == 'Type') {
                            Type = "1";
                            Duration = $("#DurationInRateOutRate").val();
                        }
                        else if (filterType == 'Duration') {
                            Duration = filterBy;
                            Type = "1";
                        }


                        data = JSON.stringify({ strGraphFilter: Type, strDuration: Duration });


                        strResult = AJAXCallWithResult(strPageName + '/GetInOutRateGraphData', data, false);

                        var strInRate1 = [];
                        var strOutRate1 = [];
                        var strOutStanding1 = [];
                        var arrBackColor1 = [];
                        var strLabels1 = [];
                        if (strResult.d != "") {

                            $.each(JSON.parse(strResult.d), function (id, object) {
                                strLabels1.push(object["Duration"]);
                                strInRate1.push(object["InRate"]);
                                strOutRate1.push(object["Outrate"]);
                                strOutStanding1.push(object["OutStanding"]);

                                arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                            });

                        }
                        var lineChartData1 = {}
                        lineChartData1 = {
                            labels: strLabels1,
                            datasets: [{
                                label: "In Rate [ Submitted ]",
                                borderColor: window.chartColors.orange,
                                backgroundColor: window.chartColors.orange,
                                fill: false,
                                data: strInRate1,
                                //yAxisID: "y-axis-1",
                            }, {
                                label: "Out Rate [ Closed ]",
                                borderColor: window.chartColors.green,
                                backgroundColor: window.chartColors.green,
                                fill: false,
                                data: strOutRate1,
                                //yAxisID: "y-axis-2"
                            }, {
                                label: "Outstanding [Not Closed]",
                                borderColor: window.chartColors.red,
                                backgroundColor: window.chartColors.red,
                                fill: false,
                                data: strOutStanding1,
                                //yAxisID: "y-axis-3"
                            }]
                        }



                        // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
                        //var temp = jQuery.extend(true, {}, lineChartData1);
                        //temp.type = 'line';
                        //InOutRateChart = new Chart(ctx4, temp);
                        //InOutRateChart = Chart.Line(ctx4, {
                        //    data: lineChartData,
                        //    options: {
                        //        responsive: true,
                        //        hoverMode: 'index',
                        //        stacked: false,
                        //        scales: {
                        //            yAxes: [{
                        //                type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                        //                display: true,
                        //                position: "left",
                        //                id: "y-axis-1",
                        //            }, {
                        //                type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                        //                display: true,
                        //                position: "right",
                        //                id: "y-axis-2",
                        //                gridLines: {
                        //                    drawOnChartArea: false, // only want the grid lines for one axis to show up
                        //                },
                        //                // grid line settings

                        //            }, {
                        //                type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                        //                display: false,
                        //                position: "right",
                        //                id: "y-axis-3",
                        //                gridLines: {
                        //                    drawOnChartArea: false, // only want the grid lines for one axis to show up
                        //                },
                        //            }],
                        //        }
                        //    }
                        //});
                        //ctx4.clearRect();
                        //if (InOutRateChart != undefined || InOutRateChart != null) {
                        //    InOutRateChart.destroy();
                        //    //InOutRateChart = null;
                        //}

                        InOutRateChart = new Chart(ctx8, {
                            type: 'line',
                            data: lineChartData1,
                            options: {
                                responsive: true,
                                scales: {
                                    yAxes: [{
                                        display: true,
                                        position: "left",
                                    }],
                                },
                                //hoverMode: 'index',
                                //stacked: false,
                                //scales: {
                                //    yAxes: [{
                                //        //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                //        display: true,
                                //        position: "left",
                                //        //id: "y-axis-1",
                                //        //}, {
                                //        //    type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                //        //    display: true,
                                //        //    position: "left",
                                //        //    id: "y-axis-2",
                                //        //    gridLines: {
                                //        //        drawOnChartArea: false, // only want the grid lines for one axis to show up
                                //        //    },
                                //        //    // grid line settings

                                //        //}, {
                                //        //    type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                //        //    display: true,
                                //        //    position: "left",
                                //        //    id: "y-axis-3",
                                //        //    gridLines: {
                                //        //        drawOnChartArea: false, // only want the grid lines for one axis to show up
                                //        //    },
                                //    }],
                                //}
                            }
                        })

                        <%If Session("LoginType") <> "C" Then%>
                        document.getElementById("main-chart").height = "370";
                        document.getElementById("main-chart").style.height = "370px";
                        <%End If%>
                        document.getElementById("main-chart").style.width = document.getElementById("main-chart").width + 'px';
                    }


                    function DrawTimeScale(filterBy) {

                        var ctx5 = document.getElementById("Area-chart").getContext("2d");

                        var strResult, data;
                        //var GraphParamters = {};

                        //GraphParamters.FilterType = strFilter;
                        //GraphParamters.Time = strTime;

                        data = JSON.stringify({ strGraphFilter: filterBy });


                        strResult = AJAXCallWithResult(strPageName + '/GetTimeScaleGraphData', data, false);

                        var strInRate = [];
                        var strOutRate = [];
                        var strOutStanding = [];
                        var arrBackColor = [];
                        var strLabels = [];
                        if (strResult.d != "") {

                            $.each(JSON.parse(strResult.d), function (id, object) {
                                strLabels.push(object["Duration"]);
                                strInRate.push(object["InRate"]);
                                strOutRate.push(object["Outrate"]);
                                strOutStanding.push(object["OutStanding"]);

                                arrBackColor.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                            });

                        }

                        var data = {
                            labels: strLabels,
                            datasets: [{
                                backgroundColor: window.chartColors.orange,
                                borderColor: window.chartColors.orange,
                                data: strInRate,
                                label: "In Rate [ Submitted ]",
                                fill: false
                            }, {
                                backgroundColor: window.chartColors.green,
                                borderColor: window.chartColors.green,
                                data: strOutRate,
                                label: "Out Rate [ Closed ]",
                                fill: false
                            }, {
                                backgroundColor: window.chartColors.red,
                                borderColor: window.chartColors.red,
                                data: strOutStanding,
                                label: 'Outstanding [Not Closed]',
                                fill: false
                            }]
                        };

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
                            //elements: {
                            //    line: {
                            //        tension: 0.000001
                            //    }
                            //},
                            //scales: {
                            //    yAxes: [{
                            //        stacked: false
                            //    }]
                            //},
                            //plugins: {
                            //    filler: {
                            //        propagate: false
                            //    },
                            //    samples_filler_analyser: {
                            //        target: 'chart-analyser'
                            //    }
                            //}
                        };

                        var chart = new Chart(ctx5, {
                            type: 'line',
                            data: data,
                            options: options
                        })
                    }

                    function ChangeTooltip() {
                        //document.getElementById("overall1").title = "Assigned Request " + $("#overall1 option:selected").text()
                        //document.getElementById("overall").title = "Open Request " + $("#overall option:selected").text()
                    }


                    function DrawSLAAdhere(value, duration, newType) {
                        try {


                            SLAType = newType;
                            var width70 = (window.innerWidth / 10) * 7
                            var windowWidth = (width70 / 2) - 40

                            document.getElementById("divAcknowledgement").innerHTML = "<canvas id='chartAcknowledgement' style='height:200px'></canvas>";
                            document.getElementById("divResponse").innerHTML = "<canvas id='chartResponse' style='height:200px'></canvas>";
                            document.getElementById("divResolution").innerHTML = "<canvas id='chartResolution' style='height:200px'></canvas>";
                            document.getElementById("divOverAll").innerHTML = "<canvas id='chartOverAll' style='height:200px'></canvas>";
                            document.getElementById("divClosure").innerHTML = "<canvas id='chartClosure' style='height:200px'></canvas>";

                            var ctx1 = document.getElementById("chartOverAll").getContext("2d");
                            var ctx2 = document.getElementById("chartAcknowledgement").getContext("2d");
                            var ctx3 = document.getElementById("chartResponse").getContext("2d");
                            var ctx4 = document.getElementById("chartResolution").getContext("2d");
                            var ctx5 = document.getElementById("chartClosure").getContext("2d");
                            document.getElementById("chartAcknowledgement").style.width = windowWidth + 'px'
                            document.getElementById("chartResponse").style.width = windowWidth + 'px'
                            document.getElementById("chartResolution").style.width = windowWidth + 'px'
                            document.getElementById("chartClosure").style.width = windowWidth + 'px'
                            data = JSON.stringify({ IsExternal: value, strDuration: duration });

                            strResult = AJAXCallWithResult(strPageName + '/GetSLAData', data, false);
                            var strStatus = ["Met(%)", "Not Met(%)", "Not Acknowledge(%)", "Not Occured(%)"];
                            var StatusCount = [];
                            var arrBackColor = [];
                            var arrResult = String(strResult.d).split("|||");
                            var r = 0;

                            if (arrResult[0] != "") {
                                document.getElementById("tdData").innerHTML = arrResult[0];
                            }
                            if (arrResult[1] != "") {

                                $.each(JSON.parse(arrResult[1]), function (id, object) {
                                    StatusCount.push([object["Met"], object["NotMet"], object["NotAcknowledge"], object["NotOccured"]]);
                                    //arrBackColor.push("hsl(" + r + ", 100%, 70%)");
                                    r += 30;
                                });

                            }
                            arrBackColor = ["#A1FF42", "#FF4242", "#FFA142", "#FFFF42"];
                            if (StatusCount.length > 4) {
                                PlotChart(ctx1, strStatus, StatusCount[4], arrBackColor, newType, 1)
                                PlotChart(ctx2, strStatus, StatusCount[0], arrBackColor, newType)
                                PlotChart(ctx3, strStatus, StatusCount[1], arrBackColor, newType)
                                PlotChart(ctx4, strStatus, StatusCount[2], arrBackColor, newType)
                                PlotChart(ctx5, strStatus, StatusCount[3], arrBackColor, newType)
                            }
                            else {
                                NoData(ctx1);
                                NoData(ctx2);
                                NoData(ctx3);
                                NoData(ctx4);
                                NoData(ctx5);
                            }
                        }
                        catch (e) {
                            console.log(e);
                        }
                    }
                    $(document).ajaxStop(function () {
                        RemoveFrameLoader();
                    })
                    function PlotChart(ctx, strStatus, StatusCount, arrBackColor, newType, Default) {
                        var options = {}
                        if (Default == 1) {
                            options = {
                                responsive: true,
                                legend: {
                                    position: 'right',
                                },
                            }
                        }
                        else {
                            options = {
                                responsive: true,
                                legend: {
                                    position: 'right',
                                    display: false,
                                },
                            }
                        }
                        var config = {
                            type: "doughnut",
                            data: {
                                labels: strStatus,
                                datasets: [{
                                    label: "",
                                    data: StatusCount,
                                    fill: false,
                                    backgroundColor: arrBackColor,
                                }, ]
                            },
                            options: options,

                        };


                        var myChart1;
                        if (myChart1) {
                            myChart1.destroy();
                        }
                        var temp = jQuery.extend(true, {}, config);
                        temp.type = newType;
                        myChart1 = new Chart(ctx, temp);
                    }
                    function NoData(ctx) {
                       
                        $("#" + ctx.canvas.id).parent().html("<div style='float:left;text-align:center;padding-top:25%;width:" + ctx.canvas.style.width + ";height:" + ctx.canvas.style.height + ";font-size:12px;font-family:Helvetica;'>No data to display</div>")
                        //ctx.save();
                        //ctx.textAlign = 'center';
                        //ctx.textBaseline = 'middle';
                        //ctx.font = "16px normal 'Helvetica Nueue'";
                        //ctx.fillStyle = "black";
                        //ctx.fillText('No data to display', width / 2, height / 2);
                        //ctx.restore();
                    }
                </script>

                <!--selction opens new selection starts-->

                <!--selction opens new selection Ends-->
    </body>

    </html>