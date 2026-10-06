<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RR_ResourceForecasting.aspx.vb" Inherits="PbNIT.RR_ResourceForecasting" %>

<!DOCTYPE html>
<html>
      <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head> 
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

   
</head>
 <style type="text/css">
        a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }

        .filter.pull-right {
            margin: 2px 0 0 8px;
        }

        .JStableOuter > table {
            overflow: initial;
        }

        .SRtopfilter ul.tab-slider--tabs {
            background: #f5f5f5;
            color: #464a4c;
        }

            .SRtopfilter ul.tab-slider--tabs li {
                color: #464a4c;
            }

        .SRtopfilter .tab-slider--tabs:after, .SRtopfilter .tab-slider--trigger.active {
            color: #fff;
        }

        .SRtopfilter .tab-slider--tabs {
            margin-top: 5px;
            height: 28px;
        }

        .SRtopfilter .tab-slider--trigger {
            padding: 8px 20px 8px 15px;
        }

        .PRweekdaytbl td span {
            display: block;
        }

        .multiselect-container {
            max-width: 260px;
        }



        .multiselect-filter .input-group .multiselect-clear-filter {
            padding: 6px 12px;
        }


        .projectallocationpanel .custom_chckbox label:before {
            margin-right: 0;
        }

        /*.JStableOuter > table > tbody > tr > td:nth-child(2) {
            position: relative;
            z-index: 1;            
            height: 40px;
            background-color: #fff;
            box-shadow: 0 0px 1px 0px #ddd;
            text-align: left;
        }*/

        .JStableOuter > table > tbody > tr > td td.PRstatusLightblue {
            background: #bcd0e8;
        }

        span.PRhrs.PRhrsSkyblue {
            background: #1359a6;
            display: block;
            color: #fff;
            margin: 0 -5px;
            text-align: center;
            padding: 0 5px;
        }



        /**/
        .ui-widget.ui-widget-content {
            z-index: 9999 !important;
        }

        .sortbyrole div.col-sm-4 {
            padding-left: 0px;
            font-size: 13px;
        }

        .SRtopfilter ul.tab-slider--tabs {
            margin-top: 0px;
        }

        .SRtopfilter ul.tab-slider--tabs {
            margin: 0 auto;
            float: none;
        }

        .SRtopfilter .tab-slider--trigger {
            min-width: 160px;
        }

        .weeklyanddaily.availNDallocate.text-center {
            width: 330px;
            margin: 0 auto;
        }

        #filterpanel .cust_tabpanel .nav-tabs > li > a:focus {
            color: #fff;
        }

        /*.projectallocationpanel .JStableOuter > table > tbody > tr > td:nth-child(1), projectallocationpanel .JStableOuter > table > thead > tr > th:nth-child(1) {
            min-width: 280px;
            z-index: 9;
            border-right: 2px solid #ddd;
        }*/

        #MEdetails .control-label, #basicfilters label {
            line-height: 18px;
            text-align: right;
        }

        #CRTableWeekly .dinline {
            display: flex;
        }

        #CRTableWeekly .custom_chckbox {
            margin: 6px 10px 0 0;
        }

        #CRTableMonthly .dinline {
            display: flex;
        }

        #CRTableMonthly .custom_chckbox {
            margin: 6px 10px 0 0;
        }

        .weekly_calender {
            text-align: left;
        }

        .pr-0 {
            padding-right: 0px;
        }

        .d-inline-block {
            display: inline-block !important;
        }

        .custom_radio input[type="radio"] + label span {
            margin: 0 5px;
        }

        .bootstrap-select.input-sm button {
            height: 30px;
        }

        /*.JStableOuter > table > tbody > tr > td:nth-child(1) {
            height: 20px;
        }*/

        .PRsubinfotbl td {
            height: auto;
            position: relative;
            padding: 0 5px;
        }

        td.PRpercentage.PRstatusBlue {
            background: #1359a6;
            color: #fff;
        }

        td.PRpercentage.PRstatusRed {
            background: #eb1c24;
            color: #fff;
        }

        table.PRsubinfotbl {
            margin: -8px 0px;
            min-height: 44px;
        }

        /*.JStableOuter > table > tbody > tr > td {
            min-width: auto;
        }*/

        .PRweekdaytbl td::after {
            z-index: 1;
        }

        /*.JStableOuter > table.PRtable > tbody > tr > td:nth-child(2), .JStableOuter > table.PRtable > thead > tr > th:nth-child(2) {
            padding: 0px;
        }*/

        .PRweekdaytbl td::after {
            top: -1px;
        }

        .circle-bgyellow {
            background: #f4cd0f;
        }

        .circle-bggblue {
            background: #1359a6;
        }

        .circle-bgorange {
            background: #fbb03b;
        }

        .circle-bggray {
            background: #cccccc;
        }

        .resourcenamediv {
            position: relative;
            padding-left: 40px;
        }

        span.usernameshort.usernamecirclesmall {
            width: 26px;
            height: 26px;
            font-size: 11px;
            line-height: 26px;
            margin: 0;
        }

        .resourcenamediv span.usernameshort {
            position: absolute;
            top: -6px;
            left: 0px;
        }

        .RFtblMain thead th {
            background: #ffffff !important;
            border-top: 1px solid #ddd;
            padding: 0px !important;
        }

        .RFtblMain thead th {
            padding: 0 5px
        }

        table.PRweekdaytbl {
            min-height: 34px;
        }

        .tblmnthname {
            min-height: 34px;
            line-height: 34px;
            text-align: center;
        }

        .JStableOuter > table.RFtblMain {
            display: none;
        }

        .JStableOuter {
            OVERFLOW: AUTO;
        }

        /*.JStableOuter > table#Monthly > thead > tr > th {
                min-width: 75px;
            }*/
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        .dataTable > thead > tr > th[class*="sort"]:after {
            content: "" !important;
        }

        table.dataTable thead > tr > th.sorting_asc,
        table.dataTable thead > tr > th.sorting_desc,
        table.dataTable thead > tr > th.sorting,
        table.dataTable thead > tr > td.sorting_asc,
        table.dataTable thead > tr > td.sorting_desc,
        table.dataTable thead > tr > td.sorting {
            padding-right: inherit;
        }



        .JStableOuter > table > tbody > tr > td {
            background-color: #fff;
            min-width: 70px !important;
            border: 1px solid #ddd;
            padding: 16px 8px;
            width: 100%;
            font-size: 13px;
            text-align: center;
            vertical-align: middle !important;
            /* box-shadow: 0 1px 0px 1px #999; */
        }

        .JStableOuter > table > thead > tr > th:nth-child(1) {
            position: relative;
            display: block;
            /* background-color: #fff; */
            z-index: 99;
            border-right: 1px solid #ddd;
            box-shadow: 0 1px 1px 1px #ddd;
            min-width: 320px;
            text-align: left;
        }

        .PRweekdaytbl td {
            text-align: center;
            min-width: 60px !important;
            /* border: 1px solid; */
            position: relative;
        }

        .JStableOuter > table > tbody > tr > td.TdMOnthWidth {
            min-width: 100px !important
        }

        .JStableOuter > table > tbody > tr {
            min-height: 10px !important
        }


        .JStableOuter #Weekly > thead > tr > th {
            background-color: #b7c4da;
            text-align: center;
            height: 42px;
            padding: 12px 15px 0;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            vertical-align: middle;
            position: relative;
            z-index: 9;
            box-shadow: 0 1px 0px 1px #ddd;
            color: #000;
            position: sticky;
            top: 0;
        }
        /*th {
  position: sticky;
  top: 0;
  z-index: 2;
  background: blue;
  text-align: left;
}

.JStableOuter > table > thead >tr:nth-child(2) th {
  top: 0px;
}*/
        .JStableOuter #Monthly > thead > tr:first-child th {
            background-color: #b7c4da;
            text-align: center;
            height: 42px;
            padding: 12px 15px 0;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            vertical-align: middle;
            position: relative;
            z-index: 9;
            box-shadow: 0 1px 0px 1px #ddd;
            color: #000;
            position: sticky;
            top: 0;
        }

        .graybg {
            /* background: #e7edf0; */
            /* Changed By Madhuri.K on 09-03-2026 */
            background: #F8FAFC;
            padding-top: 10px;
            padding-bottom: 8px;
        }

button.nostylebtn.dropdown-toggle {
    background: none;
    border: none;
}
/*Added by pradip on 30-3-2023*/
 .JStableOuter > table > thead > tr > th:nth-child(1) div {
    text-align: center;
}/*End Added by pradip on 30-3-2023*/       
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="body-tblForecasting">
    <div class="wrapper">
        <!-- Main Header -->
        <%--<header class="main-header">
            <!-- Logo -->
            <a href="#" class="logo hidden-xs">
                <!-- mini logo for sidebar mini 50x50 pixels -->
                <!--<span class="logo-mini"><b>A</b>LT</span>--> <span class="logo-mini"><img src="../../../Whizible2.0-new/dist/img/Whizible-app-logo.png" alt="" width="60px"></span>
                <!-- logo for regular state and mobile devices -->
                <!--<span class="logo-lg"><b>Your</b>LOGO</span>-->
            </a>
            <!-- Header Navbar -->
            <nav class="navbar navbar-static-top" role="navigation">
                <div class="mainheadingtop">Resource Forecasting</div>
                <!-- Navbar Right Menu -->
                <div class="navbar-custom-menu hidden-xs">
                    <ul class="nav navbar-nav">
                        <li class="dropdown user user-menu">
                            <!-- Menu Toggle Button -->
                            <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown">
                                <!-- hidden-xs hides the username on small devices so only the image appears. --> <span class="hidden-xs">John Smith</span>
                                <!-- The user image in the navbar-->
                                <img src="../../../Whizible2.0-new/dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
                            </a>
                            <ul class="dropdown-menu">
                                <!-- The user image in the menu -->
                                <li class="user-header">
                                    <img src="../../../Whizible2.0-new/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                                    <p>John Smith - Web Developer</p>
                                </li>
                                <!-- Menu Body -->
                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <div class="text-center">
                                        <a href="#" class="btn btn-default btn-block">Profile</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <!-- search Menu -->
                        <li class="dropdown search-menu">
                            <!-- Menu toggle button -->
                            <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown">
                                <img class="weeklycalender_icon" src="../../../Whizible2.0-new/dist/img/Search.svg" alt="" width="20px">
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">Please search here</li>
                                <li>
                                    <div class="input-group">
                                        <input type="text" class="form-control"> <span class="input-group-btn">
                                            <button class="btn btnyellow btn-flat" type="button">Search</button>
                                        </span>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <!-- setting Menu -->
                        <li class="dropdown setting-menu">
                            <!-- Menu toggle button -->
                            <a href="#" data-bs-toggle="control-sidebar" class="dropdown-toggle" data-bs-toggle="dropdown">
                                <img class="weeklycalender_icon" src="../../../Whizible2.0-new/dist/img/Setting.svg" alt="" width="20px">
                            </a>
                        </li>
                        <!-- Notifications Menu -->
                        <li class="dropdown notifications-menu">
                            <!-- Menu toggle button -->
                            <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="far fa-bell"></i>
                                <span class="label label-warning">10</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">You have 10 notifications</li>
                                <li>
                                    <!-- Inner Menu: contains the notifications -->
                                    <ul class="menu">
                                        <li>
                                            <!-- start notification -->
                                            <a href="#"> <i class="fa fa-users text-aqua"></i> 5 new members joined today</a>
                                        </li>
                                        <!-- end notification -->
                                    </ul>
                                </li>
                                <li class="footer">
                                    <a href="#">View all</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">
                                <img class="weeklycalender_icon" src="../../../Whizible2.0-new/dist/img/logout.svg" alt="" width="20px">
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>--%>
        <!-- Left side column. contains the logo and sidebar -->
        <%--<aside class="main-sidebar">
            <!-- sidebar: style can be found in sidebar.less -->
            <section class="sidebar">
                <!-- Sidebar Menu -->
                <ul class="sidebar-menu">
                    <!-- Optionally, you can add icons to the links -->
                    <li>
                        <a href="#"><i class="fa"><img src="../../../Whizible2.0-new/dist/img/Home.svg" alt="" width="44px"></i> <span>Dashboard</span></a>
                    </li>
                    <li class="active dropdown-submenu">
                        <a href="#"><i class="fa"><img src="../../../Whizible2.0-new/dist/img/Projects.svg" alt="" width="44px"></i> <span>Projects</span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li>
                                <a href="project-dashboard.html">Dashboard</a>
                            </li>
                            <li>
                                <a href="newproject.html">Create Project</a>
                            </li>
                            <li>
                                <a href="#">Manage</a>
                            </li>
                            <li>
                                <a href="#">Plan</a>
                            </li>
                            <li>
                                <a href="#">Budget</a>
                            </li>
                            <li>
                                <a href="resource.html">Resources</a>
                            </li>
                            <li>
                                <a href="#">Stakeholders</a>
                            </li>
                            <li>
                                <a href="#">Risk Management</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#"><i class="fa"><img src="../../../Whizible2.0-new/dist/img/Timesheet.svg" alt="" width="44px"></i> <span>Timesheet</span></a>
                    </li>
                    <li class="">
                        <a href="#"><i class="fa"><img src="../../../Whizible2.0-new/dist/img/issues.svg" alt="" width="44px"></i> <span>Issues</span></a>
                    </li>
                    <li>
                        <a href="#"><i class="fa"><img src="../../../Whizible2.0-new/dist/img/MIS.svg" alt="" width="44px"></i> <span>MIS</span></a>
                    </li>
                    <li>
                        <a href="#"><i class="fa"><img src="../../../Whizible2.0-new/dist/img/Help-desk.svg" alt="" width="44px"></i> <span>Help desk</span></a>
                    </li>
                </ul>
                <!-- /.sidebar-menu -->
            </section>
            <!-- /.sidebar -->
        </aside>--%>
        <!-- Content Wrapper. Contains page content -->
        <div class="bgwhite resource_allocation">
            <!-- Content Header (Page header) -->
            <div class="graybg container-fluid pt-1 pb-1 resourcepanelheader">
                <div class="row">
                    <div class="col-sm-1" style="margin-right: -30px;">
                        Select Role
                    </div>
                    <div class="col-sm-3">
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboRoleId", "usp_Whizible2_Sel_tbl_RM_Role",,, "class=""form-control"" onChange=""forOnchange()""",,,, ,)%>
                    </div>

                    <div class="col-sm-7 pt-1">
                        <div class="d-inline-block">
                            <div class="custom_radio d-inline-block">
                                <input id="RFGrid1" name="RFgroup1" value="Weekly" type="radio" checked="checked">
                                <label for="RFGrid1"><span></span></label>
                            </div>
                            <label>Weekly</label>
                        </div>
                        <div class="d-inline-block  ml-1">
                            <div class="custom_radio d-inline-block">
                                <input id="RFGrid2" name="RFgroup1" value="Monthly" type="radio">
                                <label for="RFGrid2"><span></span></label>
                            </div>
                            <label>Monthly</label>
                        </div>

                    </div>
                    <div class="col-sm-1 pr-0">
                    <div class="dropdown filedownload pull-right" style="margin-top: 5px;">
                        <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" data-bs-placement="bottom" title="Click here to download" class="fas fa-download"></i></button>
                        <ul class="dropdown-menu">
                            <li><a href="#" onclick="ExportResourceForecasting('PDF')">
                                <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                            <li><a href="#" onclick="ExportResourceForecasting('EXCEL')">
                                <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                            <li><a href="#" onclick="ExportResourceForecasting('XML')">
                                <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                            <li><a href="#" onclick="ExportResourceForecasting('RTF')">
                                <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Rtf</a></li>
                        </ul>

                    </div>
                        </div>
                </div>
            </div>



            <!-- Main content -->
            <section class="content">
                <div class="clearfix"></div>
                <div id="wbsallocate" class="tab-slider--body">
                    <div class="bhwhite">
                        <div class="projectallocationpanel">
                            <div class="JStableOuter">
                                <table id="Weekly" class="PRtable table-bordered RFtblMain RFtblMain" style="width: 100%;">
                                    <thead id="lstWeeks" class="clweek">
                                        <tr>
                                            <th class="text-left sortbyrole" style="padding: 5px 5px!important;">
                                                <div class="col-sm-12 pr-0 pl-0">

                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboRoleId", "usp_Whizible2_Sel_tbl_RM_Role",,, "class=""form-control"" onChange=""GetForeCastingWeekly("",this.value)""", True,,, , ) %>--%>
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboRoleId", "usp_Whizible2_Sel_tbl_RM_Role",,, "class=""form-control"" onChange=""GetForeCastingWeekly('Weekly',this.value)""", True,,, ,)%>
                                                </div>

                                            </th>
                                            <th>W1</th>
                                            <th>W2</th>
                                            <th>W3</th>
                                            <th>W4</th>
                                            <th>W5</th>
                                            <th>W6</th>
                                            <th>W7</th>
                                            <th>W8</th>
                                            <th>W9</th>
                                            <th>W10</th>
                                            <th>W11</th>
                                            <th>W12</th>
                                            <th>W13</th>
                                            <th>W14</th>
                                            <th>W15</th>
                                            <th>W16</th>
                                            <th>W17</th>
                                            <th>W18</th>
                                            <th>W19</th>
                                            <th>W20</th>
                                            <th>W21</th>
                                            <th>W22</th>
                                            <th>W23</th>
                                            <th>W24</th>
                                            <th>W25</th>
                                            <th>W26</th>
                                            <th>W27</th>
                                            <th>W28</th>
                                            <th>W29</th>
                                            <th>W30</th>
                                            <th>W31</th>
                                            <th>W32</th>
                                            <th>W33</th>
                                            <th>W34</th>
                                            <th>W35</th>
                                            <th>W36</th>
                                            <th>W37</th>
                                            <th>W38</th>
                                            <th>W39</th>
                                            <th>W40</th>
                                            <th>W41</th>
                                            <th>W42</th>
                                            <th>W43</th>
                                            <th>W44</th>
                                            <th>W45</th>
                                            <th>W46</th>
                                            <th>W47</th>
                                            <th>W48</th>
                                            <th>W49</th>
                                            <th>W50</th>
                                            <th>W51</th>
                                            <th>W52</th>
                                            <th>W53</th>
                                        </tr>

                                    </thead>
                                    <tbody id="CRTableWeekly">
                                        <%--<tr>
                                            <td colspan="53">Please select filter and click on apply</td>
                                        </tr>--%>
                                    </tbody>
                                </table>

                                <table id="Monthly" class="PRtable RFtblMain" style="width: 100%">
                                    <thead id="lstMonths" class="clmonth">
                                    </thead>
                                    <tbody id="CRTableMonthly">
                                    </tbody>
                                </table>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <!--Allocation tab content End here-->


            </section>
            <div class="modal custmodal  fade" id="bulkallocation" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Allocation details</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Resources</label>
                                    <div class="col-sm-8">
                                        <div class="inputtags">
                                            <!--<input id="RAtaglist" type="text" class="form-control" rows="3" value="Test1,Test2, test3, test4, ThisIsABigVeryBigTest" />-->
                                            <input id="" type="text" class="form-control" rows="3" value="" />
                                        </div>

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Project (pre-populated)</label>
                                    <div class="col-sm-8">
                                        <select class="form-control selectpicker">
                                            <option data-bs-toggle="tooltip" title="test" data-bs-container="body" data-bs-placement="bottom">Select Project</option>
                                            <option>Timesheet</option>
                                            <option>Help desk</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Plan Start Date</label>
                                    <div class="col-sm-8">
                                        <div class="input-group">
                                            <input id="ADPlanStartDate" type="text" class="form-control" value="June 08 2018">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Plan End Date</label>
                                    <div class="col-sm-8">
                                        <div class="input-group">
                                            <input id="ADPlanEndDate" type="text" class="form-control" value="June 21 2018">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Resource Status</label>
                                    <div class="col-sm-8">
                                        <select class="form-control selectpicker">
                                            <option>Retrive</option>
                                            <option>Buffor</option>
                                            <option>Shadow</option>
                                        </select>
                                    </div>
                                </div>

                                <br>
                                <div class="form-group">&nbsp;</div>
                                <div class="form-group text-center">
                                    <button class="btn borderbtn borderbtnfill" data-bs-dismiss="modal">Allocate</button>
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>



        </div>
        <!-- /.content-wrapper -->
    </div>
    <!-- ./wrapper -->
    <!--Changeallocation status-->
    <div class="modal custmodal  fade" id="IMchngAllocationModal" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Change Allocation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">

                        <div class="form-group">
                            <label class="col-sm-4 text-right">From Date</label>
                            <div class="col-sm-8">

                                <div class="input-group datefielddiv">
                                    <input id="IMFrmdate" type="text" class="form-control" value="">
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 text-right">To Date</label>
                            <div class="col-sm-8">
                                <div class="input-group datefielddiv">
                                    <input id="IMEndDate" type="text" class="form-control" value="">
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>

                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-4 text-right">Quantity/no. of licences</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" />
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 text-right">Commentes</label>
                            <div class="col-sm-8">
                                <textarea class="form-control">
                                
                                </textarea>

                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group">&nbsp;</div>
                        <div class="form-group text-center">
                            <button class="btn borderbtn borderbtnfill" data-bs-dismiss="modal">Save</button>
                            <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!--end modal popup-->




    <!-- REQUIRED JS SCRIPTS -->
   <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
	<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip(); //Added by pradip on 26-7-2021
        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });


        $("body").on("click", ".nav-tabs [data-bs-toggle='dropdown']", function () {
            $(".nav-tabs [data-bs-toggle='dropdown']").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
            $(this).closest(".nav-tabs']").find(".dropdown-menu, .dropdown-toggle").addClass("show");

        });

        $('body').on('click', function (e) {
            $('.nav-tabs [data-bs-toggle="dropdown"]').each(function (e) {
                // hide any open popovers when the anywhere else in the body is clicked
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.nav-tabs .dropdown-menu').has(e.target).length === 0) {
                    $(".nav-tabs .dropdown-menu").removeClass('show');
                }
            });
        });

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").hover(function () {
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip('update');
        }); //added by pradip on 24-3-2023

        var NoDataFound = "No data found.";
        var DeleteRecord = "Please select at least one record to delete.";
        var DeleteConfirm = "Are you sure, you want to delete the selected records?";
        var tables = $('.RFtblMain');
        $('input[name="RFgroup1"]').on('change', function () {
            tables.hide();
            $('#' + $(this).val()).show();
        });
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var TagID = '<%= m_TagId%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var strUrl = '';
        var noOfRowsPerPage = 10;
        var ForecastMonthlyTable;
        var ActualHr = 'Actual Hrs';
        var PlannedHr = 'Planned Hrs';
        var ActPlnHrs = 'Values: '+ ActualHr + ' / ' + PlannedHr
        $(document).ready(function () {
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (blnViewAccess == "True") {
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";
            }
           
            GetMaximumItemsToShowInList();
            var checked = $('input[name="RFgroup1"]').is(':checked');
            var ReportsTab = $("input[type='radio'][name='RFgroup1']:checked");
            var selected = ReportsTab.val();
            if (selected == "Weekly") {
                $("#Weekly").show();
                $("#Monthly").hide();
                $("#Monthly_wrapper").hide();

                GetForeCastingWeekly(selected, null);

            }
            $("input[type='radio'][name='RFgroup1']").change(function () {
                var RoleId = $('#cboRoleId').val() == '0' || $('#cboRoleId').val() == '' ? null : $('#cboRoleId').val();

                if (this.value == 'Weekly') {
                    $("#Weekly").show();
                    $("#Monthly").hide();
                    $("#Monthly_wrapper").hide();

                    GetForeCastingWeekly(this.value, RoleId);
                    //$('#cboRoleId').val(0);
                }
                else if (this.value == 'Monthly') {
                    $("#Monthly").show();
                    $("#Weekly").hide();
                    $("#Weekly_wrapper").hide();
                    //$('#cboRoleId').val(0);
                    GetForeCastingMonthly(this.value, RoleId);
                }
            });
            //Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
            BindPlaceholder("cboRoleId", "Role");         
            //End of Added By Chetan M. For Bind Filter Placeholder on 15 July 2021

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
        function forOnchange() {
            var ReportsTab = $("input[type='radio'][name='RFgroup1']:checked");
            var selected = ReportsTab.val();
            var RoleId = $('#cboRoleId').val();
            if (selected == "Weekly") {
                GetForeCastingWeekly(selected, RoleId);

            } else {
                GetForeCastingMonthly(selected, RoleId);
            }
        }
        $('#123').on('shown.bs.select', function () {
            var test = $('selectpicker').selectpicker.current.elements.text();
            $($(this).data('selectpicker').selectpicker.current.elements).attr('title', test).tooltip();
        });

        //change date format
        var months = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };


        //datepicker
        $('#IRREnddate, #IRRStartdate, #ADPlanStartDate, #ADPlanEndDate, #IMFrmdate, #IMEndDate, #PIRFltrFromDatefield, #PIRFltrToDatefield').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd MM yy'
        });


        //start script for display dropdown hide behind div
        (function () {
            // hold onto the drop down menu
            var dropdownMenu;

            // and when you show it, move it to the body
            $(window).on('show.bs.dropdown', function (e) {

                // grab the menu
                dropdownMenu = $(e.target).find('.multiselect-container.dropdown-menu');

                // detach it and append it to the body
                $('body').append(dropdownMenu.detach());

                // grab the new offset position
                var eOffset = $(e.target).offset();

                // make sure to place it where it would normally go (this could be improved)
                dropdownMenu.css({
                    'display': 'block',
                    'top': eOffset.top + $(e.target).outerHeight(),
                    'left': eOffset.left
                });
            });

            // and when you hide it, reattach the drop down, and hide it normally
            $(window).on('hide.bs.dropdown', function (e) {
                $(e.target).append(dropdownMenu.detach());
                dropdownMenu.hide();
            });
        })();
        //End script for display dropdown hide behind div


        $(document).on('click.bs.dropdown.data-api', '.dropdown.keep-inside-clicks-open', function (e) {
            e.stopPropagation();
        });

        $('[data-bs-toggle="tooltip"]').tooltip();

        $(function () {
            $('#rskillfilter, #roufilter, #rbgfilter').multiselect({
                includeSelectAllOption: true,
                enableCaseInsensitiveFiltering: true,
                enableFiltering: true,
                maxHeight: 200
            });
        });


        $('.multiselect-container').click(function (e) {
            var containerHeight = $(this).find("ul").outerHeight();
            $(this).find(".ms-drop").css({
                'position': 'fixed',
                'left': $(this).offset().left,
                'top': $(this).offset().top,
                'height': containerHeight,
            })
        });

        //dynamically set height
        function resizeSection(tag) {
            var JStableOuter = $(window).height();
            //$('.JStableOuter > table, .PRweekdaytbl td::after').css({ 'height': JStableOuter - 215, "overflow-y": "auto" });

            var JStabledividerHeight = $(window).height();
            //$('.PRweekdaytbl td::after').css({ 'height': JStabledividerHeight - 215, "overflow-y": "auto" });
            $('.projectallocationpanel .JStableOuter').css({ 'height': JStableOuter - 80, "overflow-y": "auto" });
            //$(".PRweekdaytbl td::after").css({'height':JStableOuter});

        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        $('.sortbyrole .selectpicker').selectpicker({
            container: 'body'
        });

        //freez table
        $('.JStableOuter > table').scroll(function (e) {

            $('.JStableOuter > table > thead').css("left", -$(".JStableOuter > tbody").scrollLeft());

            $('.JStableOuter > table > thead > tr > th:nth-child(1)').css("left", $(".JStableOuter > table").scrollLeft() - 0);

            $('.JStableOuter > table > tbody > tr > td:nth-child(1), .JStableOuter > table > tbody > tr > td:nth-child(2)').css("left", $(".JStableOuter > table").scrollLeft());


            $('.JStableOuter > table > thead').css("top", -$(".JStableOuter > tbody").scrollTop());
            $('.JStableOuter > table > thead > tr > th').css("top", $(".JStableOuter > table").scrollTop());

        });


        //colappse row
        $(".UpDowncollapseArrow").click(function () {
            $(this).toggleClass("in");

        });


    </script>
    <script type="text/javascript">
        //this is for file attache and drop script

        $('form input').change(function () {
            $('form p').text(this.files.length + " file(s) selected");
        });


        //jquery for weekly and daily view calendar
        //$(".tab-slider--nav li").click(function () {

        //    if ($("#wbsallocate").is(":visible")) {
        //        $("#dailyviewcal").hide();
        //        $("#weeklyviewcal").show();
        //    } else {
        //        $("#weeklyviewcal").hide();
        //        $("#dailyviewcal").show();
        //    }

        //});

        //weeekly and daily tab

        //$(".tab-slider--body").hide();
        //$(".tab-slider--body:first").show();
        //$("#dailyviewcal").show();



        //$(".tab-slider--nav li").click(function () {
        //    $(".tab-slider--body").hide();
        //    var activeTab = $(this).attr("rel");
        //    $("#" + activeTab).fadeIn();
        //    if ($(this).attr("rel") == "wbsavailbility") {
        //        $('.tab-slider--tabs').addClass('slide');
        //    } else {
        //        $('.tab-slider--tabs').removeClass('slide');
        //    }
        //    $(".tab-slider--nav li").removeClass("active");
        //    $(this).addClass("active");
        //});


    </script>
    <script>
        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".chcktbl").click(function () {

            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
            }

        });





        //auto search for corporate roles
        $("#searchCR").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#CRTable tr").not(':first').filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });

        function ExportResourceForecasting(filterParams) {

            var filterParams1 =
                {
                    intUserID: "",
                    ReportFormat: "",
                    ByWeekOrMonth: "Weekly",
                    RoleID: ""
                }

            var ReportsTab = $("input[type='radio'][name='RFgroup1']:checked");
            var selected = ReportsTab.val();
            filterParams1.ReportFormat = filterParams;
            filterParams1.ByWeekOrMonth = selected;
            filterParams1.intUserID = SessionEmployeeId;
            filterParams1.RoleID = $("#cboRoleId").val();

            console.log("filterParams1export", filterParams1);
            StartLoader("#body-tblForecasting");
            $.ajax({
                url: strUrl + '/api/RR_ForeCasting/ExportDocument',
                type: "POST",
                data: JSON.stringify(filterParams1),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (filterParams1) {
                        xhr.setRequestHeader("Params", encryptString(isJson(filterParams1) ? filterParams1 : JSON.stringify(filterParams1)));
                    }
                },
                success: function (data) {
                    if (data == "") {
                        // showAlert('Records not available to download Report.', 'alert-danger');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Records not available to download Report.");
                        // alert("NOT");
                    }
                    else {
                        //C:\Applications\Whizible_2\Source\CRW
                        window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + data, "_report", "");
                    }
                    StopAjaxLoader("#body-tblForecasting");
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-tblForecasting");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-tblForecasting");
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

        }

        var ResourceDetails = "";
        function GetForeCastingMonthly(monthly, RoleId) {
            var strHTML = "";
            var RoleID = RoleId;

            //   var strMonthsHeaderHTML = "";
            var filterParams1 =
                {
                    intUserID: "",
                    ByWeekOrMonth: "",
                    RoleID: ""
                }
            filterParams1.ByWeekOrMonth = monthly;
            filterParams1.intUserID = SessionEmployeeId;
            filterParams1.RoleID = RoleID;
            //console.log("filterParams1", filterParams1);
            StartLoader("#body-tblForecasting");

            $.ajax({
                url: strUrl + '/api/RR_ForeCasting/GetForeCastingByMonthly',
                type: "POST",
                data: JSON.stringify(filterParams1),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (filterParams1) {
                        xhr.setRequestHeader("Params", encryptString(isJson(filterParams1) ? filterParams1 : JSON.stringify(filterParams1)));
                    }
                },
                success: function (data) {
                    ResourceDetails = data.listReport;
                    var strMonthsHeaderHTML = '  <tr> <th class=""> <div class="dinline" style="margin: 6px 5px;"> <input id="SeachMonthFR" type="text" class="search-query form-control input-sm" placeholder="Search by resource name " onkeyup="mysearchFunction()"> </div> </th>';

                    if (data.MonthColumn != null && data.MonthColumn != 'undefined' && data.MonthColumn.length > 0) {
                        $.each(data.MonthColumn, function (indexMonthHeader, objWeekHeader) {
                            strMonthsHeaderHTML += '<th>' + objWeekHeader + '</th>';
                        });
                        strMonthsHeaderHTML += '</tr>';
                        strMonthsHeaderHTML += '<tr> <th class="text-left sortbyrole" style="padding: 5px 5px!important;"> <div class="col-sm-12 pr-0 pl-0">'+ActPlnHrs+' </div></th><th class="p-0">&nbsp; </th><th>&nbsp; </th> <th>&nbsp; </th><th>&nbsp; </th> <th>&nbsp;</th> <th>&nbsp; </th><th>&nbsp; </th>  <th>&nbsp; </th> <th>&nbsp; </th> <th>&nbsp; </th><th>&nbsp; </th> <th>&nbsp; </th> </tr>';
                        $("#lstMonths").html(strMonthsHeaderHTML);
                    }
                    ReloadTableSearchFormonthly(ResourceDetails);

                    StopAjaxLoader("#body-tblForecasting");

                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#body-ResourceAllocation");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })
        }
        function GetMaximumItemsToShowInList() {
            // StartLoader("#bodyGlobal-Resource");
            $.ajax({
                url: strUrl + '/api/RM_GlobalResourcePool/GetMaximumItemsToShowInList',
                type: "POST",
                data: JSON.stringify(),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                success: function (data) {
                    noOfRowsPerPage = data;
                    //alert(noOfRowsPerPage);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.error(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(thrownError);
                    }


                }
            })

        }
        function LoadPagination(tblId, data) {
            $.fn.DataTable.ext.pager.numbers_length = 10;
            $(tblId).dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": true,
                "scrollResize": true,
                "scrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "lengthChange": false,
                "searching": false,
                "destroy": true,

            });

        }

        function mysearchFunction() {
            var SearchText = $("#SeachMonthFR").val();
            var strHTML = "";

            var FilterTitle = ResourceDetails.filter(function (x) { return x.ResourceName.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 });
            ReloadTableSearchFormonthly(FilterTitle);
        }
        function ReloadTableSearchFormonthly(List) {
            console.log("Reload");
            var strHTML = "";
            $("#CRTableMonthly").html('');
            if (List.length > 0) {
                $.each(List, function (index, obj)
                {
                    //commented and added by imran on 03-01-2022 for tooltipshow
                    //strHTML += '<tr class="pgrow"><td class="text-center">' + obj.ResourceName + '</td>' +
                    //    '<td class="text-center TdMOnthWidth"> ' + obj.Month_1 + ' / ' + obj.Month_Ph1 +
                    //    '</td><td class="text-center TdMOnthWidth">' + obj.Month_2 + '/' + obj.Month_Ph2 +
                    //    '</td><td class="text-center TdMOnthWidth">' + obj.Month_3 + '/' + obj.Month_Ph3 +
                    //    '</td><td class="text-center TdMOnthWidth">' + obj.Month_4 + '/' + obj.Month_Ph4 +
                    //    '</td><td class="text-center TdMOnthWidth">' + obj.Month_5 + '/' + obj.Month_Ph5 +
                    //    '</td><td class="text-center TdMOnthWidth">' + obj.Month_6 + '/' + obj.Month_Ph6 +
                    //    '</td><td class="text-center TdMOnthWidth ">' + obj.Month_7 + '/' + obj.Month_Ph7 +
                    //    '</td><td class="text-center TdMOnthWidth">' + obj.Month_8 + '/' + obj.Month_Ph8 +
                    //    '</td><td class="text-center TdMOnthWidth">' + obj.Month_9 + '/' + obj.Month_Ph9 +
                    //    '</td><td class="text-center TdMOnthWidth">' + obj.Month_10 + '/' + obj.Month_Ph10 +
                    //    '</td><td class="text-center TdMOnthWidth">' + obj.Month_11 + '/' + obj.Month_Ph11 +
                    //    '</td><td class="text-center TdMOnthWidth">' + obj.Month_12 + '/' + obj.Month_Ph12 +
                    //    '</td></tr>';

                    strHTML += '<tr class="pgrow"><td class="text-center">' + obj.ResourceName + '</td>' +
                        '<td class="text-center TdMOnthWidth"> <span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.Month_1 + '</span> / <span data-bs-toggle="tooltip" title="Planned Hours">' + obj.Month_Ph1 + '</span>' +
                        '</td><td class="text-center TdMOnthWidth"> <span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.Month_2 + '</span> / <span data-bs-toggle="tooltip" title="Planned Hours">' + obj.Month_Ph2 + '</span>' +
                        '</td><td class="text-center TdMOnthWidth"> <span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.Month_3 + '</span> / <span data-bs-toggle="tooltip" title="Planned Hours">' + obj.Month_Ph3 + '</span>' +
                        '</td><td class="text-center TdMOnthWidth"> <span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.Month_4 + '</span> / <span data-bs-toggle="tooltip" title="Planned Hours">' + obj.Month_Ph4 + '</span>' +
                        '</td><td class="text-center TdMOnthWidth"> <span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.Month_5 + '</span> / <span data-bs-toggle="tooltip" title="Planned Hours">' + obj.Month_Ph5 + '</span>' +
                        '</td><td class="text-center TdMOnthWidth"> <span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.Month_6 + '</span> / <span data-bs-toggle="tooltip" title="Planned Hours">' + obj.Month_Ph6 + '</span>' +
                        '</td><td class="text-center TdMOnthWidth"> <span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.Month_7 + '</span> / <span data-bs-toggle="tooltip" title="Planned Hours">' + obj.Month_Ph7 + '</span>' +
                        '</td><td class="text-center TdMOnthWidth"> <span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.Month_8 + '</span> / <span data-bs-toggle="tooltip" title="Planned Hours">' + obj.Month_Ph8 + '</span>' +
                        '</td><td class="text-center TdMOnthWidth"> <span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.Month_9 + '</span> / <span data-bs-toggle="tooltip" title="Planned Hours">' + obj.Month_Ph9 + '</span>' +
                        '</td><td class="text-center TdMOnthWidth"> <span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.Month_10 + '</span> / <span data-bs-toggle="tooltip" title="Planned Hours">' + obj.Month_Ph10 + '</span>' +
                        '</td><td class="text-center TdMOnthWidth"> <span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.Month_11 + '</span> / <span data-bs-toggle="tooltip" title="Planned Hours">' + obj.Month_Ph11 + '</span>' +
                        '</td><td class="text-center TdMOnthWidth"> <span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.Month_12 + '</span> / <span data-bs-toggle="tooltip" title="Planned Hours">' + obj.Month_Ph12 + '</span>' +
                        '</td></tr>';
                    //End Comment by imran on 03-01-2022
                });
                //// $('#Monthly').dataTable().fnDestroy();
                $("#CRTableMonthly").html(strHTML);
                //// LoadPagination('#Monthly',data);
                 $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip(); //Added by imran on 03-01-2022
                StopAjaxLoader("#body-ResourceAllocation");
            }
            else {
                strHTML += '<tr><td  style="text-align: center;" class="text-center" colspan="13">' + NoDataFound + ' </td></tr>';
                $('#Monthly').dataTable().fnDestroy();
                $("#CRTableMonthly").html(strHTML);
                // $(".chckHeadForSoftBooking").prop("checked", false);
            }
        }
        var WeeklyResourceDetails = "";
        var cboWeekly = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboRoleId", "usp_Whizible2_Sel_tbl_RM_Role", , , "class=""form-control clsPlanWidth clCboOrSkils clsAsterLink""", True, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
        function GetForeCastingWeekly(weekly, RoleId) {
            var strHTML = "";
            var strMonthsHeaderHTML = "";
            var RoleID = RoleId;
            if (RoleID == null || RoleID == "") {
                RoleID = 0;
            }
            var filterParams1 =
                {
                    intUserID: "",
                    ByWeekOrMonth: "",
                    RoleID: ""
                }
            filterParams1.ByWeekOrMonth = weekly;
            filterParams1.intUserID = SessionEmployeeId;
            filterParams1.RoleID = RoleID;
            //console.log("filterParams1", filterParams1);
            StartLoader("#body-tblForecasting");
            $.ajax({
                url: strUrl + '/api/RR_ForeCasting/GetForeCastingByWeekly',
                type: "POST",
                data: JSON.stringify(filterParams1),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (filterParams1) {
                        xhr.setRequestHeader("Params", encryptString(isJson(filterParams1) ? filterParams1 : JSON.stringify(filterParams1)));
                    }
                },
                success: function (data) {
                    WeeklyResourceDetails = data.listReport;

                    var strMonthsHeaderHTML = ' <tr> <th class=""> <div class="dinline" style="margin: 6px 5px;"> <input id="SeachWeekFR" type="text" class="search-query form-control input-sm" placeholder="Search by resource name" onkeyup="myWeeklysearchFunction()"> </div>  </th>';

                    //  //console.log("List", List);j
                    if (data.MonthColumn != null && data.MonthColumn != 'undefined' && data.MonthColumn.length > 0) {
                        $.each(data.MonthColumn, function (indexMonthHeader, objWeekHeader) {
                            if (indexMonthHeader > 1 && indexMonthHeader < 7) {
                                strMonthsHeaderHTML += '<th colspan="5">' + objWeekHeader + '</th>';
                            } else {
                                strMonthsHeaderHTML += '<th colspan="4">' + objWeekHeader + '</th>';
                            }
                        });
                        strMonthsHeaderHTML += '</tr>';
                        strMonthsHeaderHTML += '<tr> <th class="text-left sortbyrole" style="padding: 5px 5px!important;"> <div class="col-sm-12 pr-0 pl-0">'+ActPlnHrs+'</div></th>' +
                            ' <th>W1</th>' +
                            ' <th>W2</th>' +
                            ' <th>W3</th>' +
                            ' <th>W4</th>' +
                            ' <th>W5</th>' +
                            ' <th>W6</th>' +
                            ' <th>W7</th>' +
                            ' <th>W8</th>' +
                            ' <th>W9</th>' +
                            ' <th>W10</th>' +
                            ' <th>W11</th>' +
                            ' <th>W12</th>' +
                            ' <th>W13</th>' +
                            ' <th>W14</th>' +
                            ' <th>W15</th>' +
                            ' <th>W16</th>' +
                            ' <th>W17</th>' +
                            ' <th>W18</th>' +
                            ' <th>W19</th>' +
                            ' <th>W20</th>' +
                            ' <th>W21</th>' +
                            ' <th>W22</th>' +
                            ' <th>W23</th>' +
                            ' <th>W24</th>' +
                            ' <th>W25</th>' +
                            ' <th>W26</th>' +
                            ' <th>W27</th>' +
                            ' <th>W28</th>' +
                            ' <th>W29</th>' +
                            ' <th>W30</th>' +
                            ' <th>W31</th>' +
                            ' <th>W32</th>' +
                            ' <th>W33</th>' +
                            ' <th>W34</th>' +
                            ' <th>W35</th>' +
                            ' <th>W36</th>' +
                            ' <th>W37</th>' +
                            ' <th>W38</th>' +
                            ' <th>W39</th>' +
                            ' <th>W40</th>' +
                            ' <th>W41</th>' +
                            ' <th>W42</th>' +
                            ' <th>W43</th>' +
                            ' <th>W44</th>' +
                            ' <th>W45</th>' +
                            ' <th>W46</th>' +
                            ' <th>W47</th>' +
                            ' <th>W48</th>' +
                            ' <th>W49</th>' +
                            ' <th>W50</th>' +
                            ' <th>W51</th>' +
                            ' <th>W52</th>' +
                            ' <th>W53</th></tr>';
                        $("#lstWeeks").html(strMonthsHeaderHTML);
                    }
                    ReloadTableSearchForWeekly(WeeklyResourceDetails);

                    StopAjaxLoader("#body-tblForecasting");

                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-tblForecasting");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-tblForecasting");
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })
        }
        function myWeeklysearchFunction() {
            var SearchText = $("#SeachWeekFR").val();
            var strHTML = "";

            var FilterTitle = WeeklyResourceDetails.filter(function (x) { return x.ResourceName.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 });
            ReloadTableSearchForWeekly(FilterTitle);
        }
        function ReloadTableSearchForWeekly(List) {
            var strHTML = "";

            $("#CRTableWeekly").html('');
            if (List.length > 0) {
                $.each(List, function (index, obj) {
                    strHTML += '<tr class="pgrow"><td class="text-center">' + obj.ResourceName +    
                        //Commented and Added by pradip on 26-7-2021
                        //'</td><td class="text-center">' + obj.W1 + '/' + obj.W1_Ah +
                        //'</td><td class="text-center">' + obj.W2 + '/' + obj.W2_Ah +
                        //'</td><td class="text-center">' + obj.W3 + '/' + obj.W3_Ah +
                        //'</td><td class="text-center">' + obj.W4 + '/' + obj.W4_Ah +
                        //'</td><td class="text-center">' + obj.W5 + '/' + obj.W5_Ah +
                        //'</td><td class="text-center">' + obj.W6 + '/' + obj.W6_Ah +
                        //'</td><td class="text-center">' + obj.W7 + '/' + obj.W7_Ah +
                        //'</td><td class="text-center">' + obj.W8 + '/' + obj.W8_Ah +
                        //'</td><td class="text-center">' + obj.W9 + '/' + obj.W9_Ah +
                        //'</td><td class="text-center">' + obj.W10 + '/' + obj.W10_Ah +
                        //'</td><td class="text-center">' + obj.W11 + '/' + obj.W11_Ah +
                        //'</td><td class="text-center">' + obj.W12 + '/' + obj.W12_Ah +
                        //'</td><td class="text-center">' + obj.W13 + '/' + obj.W13_Ah +
                        //'</td><td class="text-center">' + obj.W14 + '/' + obj.W14_Ah +
                        //'</td><td class="text-center">' + obj.W15 + '/' + obj.W15_Ah +
                        //'</td><td class="text-center">' + obj.W16 + '/' + obj.W16_Ah +
                        //'</td><td class="text-center">' + obj.W17 + '/' + obj.W17_Ah +
                        //'</td><td class="text-center">' + obj.W18 + '/' + obj.W18_Ah +
                        //'</td><td class="text-center">' + obj.W19 + '/' + obj.W19_Ah +
                        //'</td><td class="text-center">' + obj.W20 + '/' + obj.W20_Ah +
                        //'</td><td class="text-center">' + obj.W21 + '/' + obj.W21_Ah +
                        //'</td><td class="text-center">' + obj.W22 + '/' + obj.W22_Ah +
                        //'</td><td class="text-center">' + obj.W23 + '/' + obj.W23_Ah +
                        //'</td><td class="text-center">' + obj.W24 + '/' + obj.W24_Ah +
                        //'</td><td class="text-center">' + obj.W25 + '/' + obj.W25_Ah +
                        //'</td><td class="text-center">' + obj.W26 + '/' + obj.W26_Ah +
                        //'</td><td class="text-center">' + obj.W27 + '/' + obj.W27_Ah +
                        //'</td><td class="text-center">' + obj.W28 + '/' + obj.W28_Ah +
                        //'</td><td class="text-center">' + obj.W29 + '/' + obj.W29_Ah +
                        //'</td><td class="text-center">' + obj.W30 + '/' + obj.W30_Ah +
                        //'</td><td class="text-center">' + obj.W31 + '/' + obj.W31_Ah +
                        //'</td><td class="text-center">' + obj.W32 + '/' + obj.W32_Ah +
                        //'</td><td class="text-center">' + obj.W33 + '/' + obj.W33_Ah +
                        //'</td><td class="text-center">' + obj.W34 + '/' + obj.W34_Ah +
                        //'</td><td class="text-center">' + obj.W35 + '/' + obj.W35_Ah +
                        //'</td><td class="text-center">' + obj.W36 + '/' + obj.W36_Ah +
                        //'</td><td class="text-center">' + obj.W37 + '/' + obj.W37_Ah +
                        //'</td><td class="text-center">' + obj.W38 + '/' + obj.W38_Ah +
                        //'</td><td class="text-center">' + obj.W39 + '/' + obj.W39_Ah +
                        //'</td><td class="text-center">' + obj.W40 + '/' + obj.W40_Ah +
                        //'</td><td class="text-center">' + obj.W41 + '/' + obj.W41_Ah +
                        //'</td><td class="text-center">' + obj.W42 + '/' + obj.W42_Ah +
                        //'</td><td class="text-center">' + obj.W43 + '/' + obj.W43_Ah +
                        //'</td><td class="text-center">' + obj.W44 + '/' + obj.W44_Ah +
                        //'</td><td class="text-center">' + obj.W45 + '/' + obj.W45_Ah +
                        //'</td><td class="text-center">' + obj.W46 + '/' + obj.W46_Ah +
                        //'</td><td class="text-center">' + obj.W47 + '/' + obj.W47_Ah +
                        //'</td><td class="text-center">' + obj.W48 + '/' + obj.W48_Ah +
                        //'</td><td class="text-center">' + obj.W49 + '/' + obj.W49_Ah +
                        //'</td><td class="text-center">' + obj.W50 + '/' + obj.W50_Ah +
                        //'</td><td class="text-center">' + obj.W51 + '/' + obj.W51_Ah +
                        //'</td><td class="text-center">' + obj.W52 + '/' + obj.W52_Ah +
                        //'</td><td class="text-center">' + obj.W53 + '/' + obj.W53_Ah +

                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W1 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W1_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W2 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W2_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W3 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W3_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W4 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W4_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W5 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W5_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W6 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W6_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W7 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W7_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W8 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W8_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W9 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W9_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W10 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W10_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W11 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W11_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W12 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W12_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W13 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W13_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W14 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W14_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W15 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W15_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W16 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W16_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W17 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W17_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W18 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W18_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W19 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W19_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W20 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W20_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W21 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W21_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W22 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W22_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W23 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W23_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W24 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W24_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W25 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W25_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W26 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W26_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W27 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W27_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W28 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W28_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W29 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W29_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W30 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W30_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W31 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W31_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W32 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W32_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W33 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W33_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W34 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W34_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W35 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W35_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W36 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W36_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W37 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W37_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W38 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W38_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W39 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W39_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W40 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W40_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W41 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W41_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W42 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W42_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W43 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W43_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W44 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W44_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W45 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W45_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W46 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W46_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W47 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W47_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W48 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W48_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W49 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W49_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W50 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W50_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W51 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W51_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W52 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W52_Ah + '</span>' +
                        '</td><td class="text-center"><span data-bs-toggle="tooltip" title="Actual Hours" data-bs-toggle-title="Actual Hours">' + obj.W53 + '</span>/<span data-bs-toggle="tooltip" title="Planned Hours">' + obj.W53_Ah + '</span>' +
                        //End of Commented and Added by pradip on 26-7-2021
                        '</td></tr>';
                });
                // $('#Weekly').dataTable().fnDestroy();
                $("#CRTableWeekly").html(strHTML);
                // LoadPagination('#Weekly',data);
                 $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip(); //Added by pradip on 26-7-2021
                StopAjaxLoader("#body-tblForecasting");
            }

            else {
                strHTML = '<tr><td style="text-align: center;" colspan="54">' + NoDataFound + ' </td></tr>';
                // $('#Monthly').dataTable().fnDestroy();
                $("#CRTableWeekly").html(strHTML);

                // $(".chckHeadForSoftBooking").prop("checked", false);
            }
        }

        //Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }
        //End of Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
    </script>
</body>

</html>
