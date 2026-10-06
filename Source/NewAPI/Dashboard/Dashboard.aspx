<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Dashboard.aspx.vb" Inherits="PbNIT.Dashboard" %>

<!DOCTYPE html>
<html>
        <%CommonFunctions.General.PlotPageHeadTag("Dashboard")%>
<head>

<!-- Commented by Madhuri.k On 14-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Dashboard</title> 
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_dashboard.css?v=2.5">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css">
  <%--  <%CommonFunctions.General.PlotPageHeadTag("Dashboard.aspx")%>--%>



    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
        <style type="text/css">
        @media only screen and (min-width:768px) {
            .box-body{ margin-top:-30px; }

.CboSelect {
            margin-right: 3px !important;
        
        }

       .chartboxheader select.form-control {
                width: 20% !important;
        }
        /*#CboCustomer{
            width: 25% !important;
        }*/
        #CboSkill {
            width: 25% !important;
        }

        /*#CboSurSkill {
            width: 25% !important;
        }*/

        #CboRevProject {
            width: 25% !important;
        }

        }

        @media screen and (min-width: 768px){.hidden-desktop {display: none;}}
        a {color: #3c8dbc!important;}
        a:hover, a:active, a:focus {outline: none;text-decoration: none;color: #72afd2!important;}
        .tab-content > .active {display: inline-flex;}
        .headernavlist li:hover a, .headernavlist li:focus a, .headernavlist li a.active, .headernavlist li a.active {background: #1359a6!important;color: #fff!important;}
        .headernavlisttab li a {padding: 6px 20px;border-radius: 4px 4px 4px 4px;cursor: pointer;}
        .modal-header{display:block}
        .close {background: transparent;opacity: 2;}
        .close:focus, .close:hover {color: #000;text-decoration: none;cursor: pointer;opacity: .5;}    
        .modal-title {font-family: 'Source Sans Pro',sans-serif;}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">

    <!--Added header for mobileview only-->
    <header class="main-header hidden-desktop">
            <!-- Header Navbar -->
            <nav class="navbar navbar-static-top" role="navigation">
                <div class="mainheadingtop"> Dashboard &gt; Organizational Overview</div>
                
            </nav>
        </header>
    <!--End header for mobileview only-->

    <div class="graybg container-fluid pt-1 pb-1 headertopp" style="display:inline-block">

        <ul class="nav nav-tabs headernavlist headernavlisttab">

            <li><a id="Weektab" class="active" data-bs-toggle="tab" onclick="Weekly_Onclick()">Weekly</a></li>
            <li><a id="monthtab" data-bs-toggle="tab" onclick="Monthly_Onclick()">Monthly</a></li>
     
        </ul>

        <span class="chartinfotext"><a data-bs-toggle="modal" data-bs-target="#myModal"><i class="far fa-lightbulb" ></i> Data as per snapshot date high level dashboard that displays statistics of important heads...</a></span>

    </div>


    <!--<div class="weeklyanddaily">
			<div class="tab-slider--nav">
                   <ul class="tab-slider--tabs">
                    <li class="tab-slider--trigger active" rel="Weeklytab" data-toggle="tooltip" data-placement="bottom" title="Weekly Dashboard View"><span>Weekly</span></li>
                        <li data-toggle="tooltip" data-placement="bottom" title="Daily Dashboard View" class="tab-slider--trigger" rel="Dailytab">Monthly</li>
                         </ul>
                    </div>
				</div>						
		  <button data-toggle="tooltip" data-placement="bottom" title="Widget" class="btn borderbtn float-end">Widget</button>
		  </div>-->





    <!-- Content Header (Page header) -->
    <!-- Main content -->
    <section class="content">


        <div class="tab-content">
            <div id="Weeklytab" class="tab-pane active">
                <div class="Dashboardmodule_main">

                    <div class="col-md-12 dashpanel mt-2">
                        <div class="row">

                            <div class="col-sm-12">
                                <div class="box box-panel box-solid chartbox">
                                    <div class="box-header boxheaderblue with-border">
                                        <h3>Resource Utilization(Customer)</h3>
                                    </div>
                                    <div class="box chartboxheader">
                                        <%--Commented & Added By Dipali V On 10th May 2023 For UI Issue--%>
                                       <%-- <label class="mr-1"></label>--%>
                                       <%--End of Commented & Added By Dipali V On 10th May 2023 For UI Issue--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboYear", "usp_sel_tbl_PM_ResourceUtilizationDetails_Weekly_Customer_Year_Month_Week 'Year' ",,, "class='form-control CboSelect' onChange='javascript:CboCustomerYear_OnChange(this.value);'",,, ) %>

                                        <%-- <select class="form-control">
                                                        <option>Months</option>
                                                         <option>Jan</option>
                                                         <option>Feb</option>
                                                         <option>Mar</option>
                                                         <option>Apr</option>
                                                         <option>May</option>
                                                         <option>Jun</option>
                                                         <option>Jul</option>
                                                         <option>Aug</option>
                                                         <option>Sep</option>
                                                         <option>Oct</option>
                                                         <option>Nov</option>
                                                         <option>Dec</option>
                                                    </select>--%>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboMonth", "Select 0,'--Select Month--' ",,, "class='form-control CboSelect' onChange='javascript:CboCustomerMonth_OnChange(this.value);'",,, ) %>

                                        <%--  <select class="form-control">
                                                    <option>Week</option>
                                                    <option>Mon</option>
                                                    <option>Tue</option>
                                                    <option>Wed</option>
                                                    <option>Thu</option>
                                                    <option>Fri</option>
                                                    <option>Sat</option>
                                                    <option>Sun</option>
                                                </select>--%>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboWeek", "Select 0,'--Select Week--'",,, "class='form-control CboSelect' onChange='javascript:CboCustomer_OnChange(this.value);'",,, ) %>

                                        <%-- <select class="form-control">
                                                    <option>Customer</option>
                                                    <option>C xyz01</option>
                                                    <option>C xyz02</option>
                                                    <option>C xyz03</option>
                                                    <option>C xyz04</option>
                                                </select>--%>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboCustomer", "usp_sel_tbl_PM_ResourceUtilizationDetails_Weekly_Customer_Year_Month_Week 'Customer' ",,, "class='form-control CboSelect' onChange='javascript:CboCustomer_OnChange(this.value);'",,, ) %>


                                        <div class="chartboxaction dropdown float-end">
                                            <button type="button" class="btn borderbtngray dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Select Graph Type">
                                                <i class="far fa-chart-bar"></i><span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a id="bar">Bar Chart</a></li>
                                                <li><a id="line">Line Chart</a></li>
                                                <li><a id="barandline">Bar &amp; Line Chart</a></li>
                                            </ul>
                                            <%--   <button type="button" id="redograph" class="btn borderbtngray" data-widget="remove" data-toggle="tooltip" data-placement="bottom" title="Reload Metadata"><i class="fas fa-redo"></i></button>--%>
                                        </div>
                                    </div>
                                    <!-- /.box-header -->
                                        <label id="lblmixedChart" style="margin-left: 40%;"></label>
                                    <div class="box-body">
                                        
                                        <canvas id="mixedChart" height="140"></canvas>


                                    </div>
                                    <!-- /.box-body -->

                                    <!-- /.box -->
                                </div>

                                <div class="clearfix"></div>
                            </div>

                            <!--resource utilization-->
                            <div class="col-sm-6">
                                <div class="box box-panel box-solid chartbox">
                                    <div class="box-header boxheaderblue with-border">
                                        <h3>Staffing Plan - By Skill</h3>
                                    </div>
                                    <div class="box chartboxheader">
                                      <%--Commented & Added By Dipali V On 10th May 2023 For UI Issue--%>
                                      <%--  <label class="mr-1"></label>--%>
                                      <%--End of Commented & Added By Dipali V On 10th May 2023 For UI Issue--%>
                                        <%-- <select class="form-control">
                                                    <option>Skill</option>
                                                    <option>Skill 1</option>
                                                    <option>Skill 2</option>
                                                    <option>Skill 3</option>

                                                </select>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboSYear", "usp_sel_tbl_PM_ResourceSkillDetails_Weekly_Skill_Year_Month_Week 'Year' ",,, "class='form-control CboSelect' onChange='javascript:CboSkillYear_OnChange(this.value);'",,, ) %>

                                        <%--<select class="form-control">
                                                    <option>Month</option>
                                                    <option>Jan</option>
                                                    <option>Feb</option>
                                                    <option>Mar</option>
                                                    <option>Apr</option>
                                                    <option>May</option>
                                                    <option>Jun</option>
                                                    <option>Jul</option>
                                                    <option>Aug</option>
                                                    <option>Sep</option>
                                                    <option>Oct</option>
                                                    <option>Nov</option>
                                                    <option>Dec</option>
                                                </select>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboSMonth", "Select 0,'--Select Month--' ",,, "class='form-control CboSelect' onChange='javascript:CboSkillMonth_OnChange(this.value);'",,, ) %>

                                        <%--<select class="form-control">
                                                    <option>Month-Year</option>
                                                    <option>1-Jan</option>
                                                    <option>2-Feb</option>
                                                    <option>3-Mar</option>
                                                    <option>4-Apr</option>
                                                    <option>5-May</option>
                                                </select>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboSWeek", "Select 0,'--Select week--'",,, "class='form-control CboSelect' onChange='javascript:CboSkillWeek_OnChange(this.value);'",,, ) %>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboSkill", "usp_sel_tbl_PM_ResourceSkillDetails_Weekly_Skill_Year_Month_Week 'Skill' ",,, "class='form-control CboSelect' onChange='javascript:CboSkillWeek_OnChange(this.value);'",,, ) %>

                                        <div class="chartboxaction dropdown float-end">
                                            <button type="button" class="btn borderbtngray dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Select Graph Type">
                                                <i class="far fa-chart-bar"></i><span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a id="barskill">Bar Chart</a></li>
                                                <li><a id="lineskill">Line Chart</a></li>
                                            </ul>
                                            <%--<button type="button" id="btnrefresh" class="btn borderbtngray" data-widget="remove" data-toggle="tooltip" data-placement="bottom" title="Reload Metadata"><i class="fas fa-redo"></i></button>--%>
                                        </div>
                                    </div>
                                    <!-- /.box-header -->
                                    <label id="lblstaffingplan" style="margin-left: 33%;"></label>
                                    <div class="box-body" id="divstaffplan">

                                        <canvas id="staffingplan" height="175"></canvas>

                                    </div>
                                    <!-- /.box-body -->

                                    <!-- /.box -->
                                </div>

                                <div class="clearfix"></div>
                            </div>
                            <!--resource utilization end-->

                            <!--Revenue realization-->
                            <div class="col-sm-6">
                                <div class="box box-panel box-solid chartbox">
                                    <div class="box-header boxheaderblue with-border">
                                        <h3>Revenue Recognition and Realization (Milestone) </h3>
                                    </div>
                                    <div class="box chartboxheader">
                                          <%-- Commented & Added By Dipali V On 10th May 2023 For UI Issue--%>
                                       <%-- <label class="mr-1"></label>--%>
                                          <%--End if Commented & Added By Dipali V On 10th May 2023 For UI Issue--%>
                                        <%--<select class="form-control">
                                                    <option>Years</option>
                                                    <option>2000</option>
                                                    <option>2001</option>
                                                    <option>2002</option>
                                                    <option>2003</option>
                                                    <option>2004</option>
                                                    <option>2005</option>
                                                    <option>2006</option>
                                                    <option>2007</option>
                                                    <option>2008</option>
                                                    <option>2009</option>
                                                    <option>2010</option>


                                                </select>

                                                <select class="form-control">
                                                    <option>Quarters</option>
                                                    <option></option>
                                                    <option></option>
                                                    <option></option>
                                                    <option></option>
                                                </select>

                                                <select class="form-control">
                                                    <option>Rev Recognation</option>
                                                    <option></option>
                                                    <option></option>
                                                    <option></option>
                                                    <option></option>
                                                </select>
                                                <select class="form-control">
                                                    <option>Project</option>
                                                    <option>1</option>
                                                    <option>2</option>
                                                    <option>3</option>
                                                    <option>4</option>
                                                </select>--%>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboRevYear", "usp_Sel_ProjectRevenue_Recognition_Realization_Year_Quarter_Project 'Year' ",,, "class='form-control CboSelect' onChange='javascript:CboRevYear_OnChange(this.value);'",,, ) %>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboRevMonth", "Select 0,'--Select Month--' ",,, "class='form-control CboSelect' onChange='javascript:CboRevMonth_OnChange(this.value);'",,, ) %>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboRevWeek", "Select 0,'--Select Week--'",,, "class='form-control CboSelect' onChange='javascript:CboRevRecogReal_OnChange(this.value);'",,, ) %>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboRevProject", "usp_Sel_ProjectRevenue_Recognition_Realization_Year_Quarter_Project 'Project' ",,, "class='form-control CboSelect' onChange='javascript:CboRevRecogReal_OnChange(this.value);'",,, ) %>

                                        <div class="chartboxaction dropdown float-end">
                                            <button type="button" class="btn borderbtngray dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Select Graph Type">
                                                <i class="far fa-chart-bar"></i><span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a id="barrev">Bar Chart</a></li>
                                                <li><a id="linerev">Line Chart</a></li>

                                            </ul>
                                            <%--<button type="button" id="revrefresh" class="btn borderbtngray" data-widget="remove" data-toggle="tooltip" data-placement="bottom" title="Reload Metadata"><i class="fas fa-redo"></i></button>--%>
                                        </div>
                                    </div>
                                    <!-- /.box-header -->
                                      <label id="lblRevRecognition" style="margin-left: 33%;"></label>
                                    <div class="box-body">

                                        <canvas id="RevRecognition" height="175"></canvas>

                                    </div>
                                    <!-- /.box-body -->

                                    <!-- /.box -->
                                </div>

                                <div class="clearfix"></div>
                            </div>
                            <!--Revenue realization end-->

                            <!--resource staffing nubers-->
                            <div class="col-sm-12">
                                <div class="box box-panel box-solid chartbox">
                                    <div class="box-header boxheaderblue with-border">
                                        <h3>Staffing - Short /Surplus (Cost Billability) </h3>
                                    </div>
                                    <div class="box chartboxheader">
                                          <%--Commented & Added By Dipali V On 10th May 2023 For UI Issue--%>
                                        <%--<label class="mr-1"></label>--%>
                                          <%--End of Commented & Added By Dipali V On 10th May 2023 For UI Issue--%>
                                        <%-- <select class="form-control">
                                                    <option>Skill</option>
                                                    <option>Skill 1</option>
                                                    <option>Skill 2</option>
                                                    <option>Skill 3</option>
                                                </select>--%>
                                        <%-- <select class="form-control">
                                                    <option>Months</option>
                                                    <option>Jan</option>
                                                    <option>Feb</option>
                                                    <option>Mar</option>
                                                    <option>Apr</option>
                                                    <option>May</option>
                                                    <option>Jun</option>
                                                    <option>Jul</option>
                                                    <option>Aug</option>
                                                    <option>Sep</option>
                                                    <option>Oct</option>
                                                    <option>Nov</option>
                                                    <option>Dec</option>

                                                </select>--%>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboSurYear", "usp_sel_tbl_PM_ResourceSkillDetails_Weekly_Skill_Year_Month_Week 'Year' ",,, "class='form-control CboSelect' onChange='javascript:CboSurYear_OnChange(this.value);'",,, ) %>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboSurMonth", "usp_sel_tbl_PM_ResourceSkillDetails_Weekly_Skill_Year_Month_Week 'Month'",,, "class='form-control CboSelect' onChange='javascript:CboSurMonth_OnChange(this.value);'",,, ) %>


                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboSurWeek", "Select 0,'--Select Week--' ",,, "class='form-control CboSelect' onChange='javascript:CboSurSkillWeek_OnChange(this.value);'",,, ) %>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboSurSkill", "usp_sel_tbl_PM_ResourceSkillDetails_Weekly_Skill_Year_Month_Week 'Skill' ",,, "class='form-control CboSelect' onChange='javascript:CboSurSkillWeek_OnChange(this.value);'",,, ) %>

                                        <div class="chartboxaction dropdown float-end">
                                            <button type="button" class="btn borderbtngray dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Select Graph Type">
                                                <i class="far fa-chart-bar"></i><span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a id="barsur">Bar Chart</a></li>
                                                <li><a id="linesur">Line Chart</a></li>
                                            </ul>
                                            <%--<button type="button" id="surefresh" class="btn borderbtngray" data-widget="remove" data-toggle="tooltip" data-placement="bottom" title="Reload Metadata"><i class="fas fa-redo"></i></button>--%>
                                        </div>
                                    </div>
                                    <!-- /.box-header -->
                                     <label id="lblbillability" style="margin-left: 40%;"></label>
                                    <div class="box-body" id="divbillability">

                                        <canvas id="billability" height="140"></canvas>

                                    </div>
                                    <!-- /.box-body -->

                                    <!-- /.box -->
                                </div>

                                <div class="clearfix"></div>
                            </div>
                            <!--resource staffing nubers end-->

                            <!--resource surplus-->
                            <div class="col-sm-12">
                                <div class="box box-panel box-solid chartbox">
                                    <div class="box-header boxheaderblue with-border">
                                        <h3>Project Revenue Projection</h3>
                                    </div>
                                    <div class="box chartboxheader">
                                          <%--Commented & Added By Dipali V On 10th May 2023 For UI Issue--%>
                                        <%--<label class="mr-1"></label>--%>
                                          <%--End of Commented & Added By Dipali V On 10th May 2023 For UI Issue--%>
                                        <%-- <select class="form-control">
                                                    <option>Years</option>
                                                    <option>2001</option>
                                                    <option>2002</option>
                                                    <option>2003</option>
                                                    <option>2004</option>
                                                    <option>2005</option>
                                                    <option>2006</option>
                                                    <option>2007</option>
                                                    <option>2008</option>
                                                    <option>2009</option>
                                                    <option>2010</option>
                                                    <option>2011</option>
                                                    <option>2012</option>

                                                </select>

                                                <select class="form-control">
                                                    <option>Quarters</option>
                                                    <option>Quarters 1</option>
                                                    <option>Quarters 2</option>
                                                    <option>Quarters 3</option>
                                                </select>

                                                <select class="form-control">
                                                    <option>Month Year Due</option>
                                                    <option>Jan</option>
                                                    <option>Feb</option>
                                                    <option>Mar</option>
                                                    <option>Apr</option>
                                                    <option>May</option>
                                                    <option>Jun</option>
                                                    <option>Jul</option>
                                                    <option>Aug</option>
                                                    <option>Sep</option>
                                                    <option>Oct</option>
                                                    <option>Nov</option>
                                                    <option>Dec</option>
                                                </select>--%>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboMileYear", "usp_Sel_ProjectRevenue_Projection_Year_Quarter_Month 'Year' ",,, "class='form-control CboSelect' onChange='javascript:CboMileYear_OnChange(this.value);'",,, ) %>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboMileQuarter", "usp_Sel_ProjectRevenue_Projection_Year_Quarter_Month 'Quarter' ",,, "class='form-control CboSelect' onChange='javascript:CboMileQuarter_OnChange(this.value);'",,, ) %>
                                        <%--Added by Swapnagandha K. on 6/18/2019--%>
                                       <%-- <% CommonFunctions.HTMLControls.DrawComboBox("CboMileMonth", "usp_Sel_ProjectRevenue_Projection_Year_Quarter_Month 'Month' ",,, "class='form-control CboSelect' onChange='javascript:CboMileMonth_OnChange(this.value);'",,,, ) %>--%>
                                         <% CommonFunctions.HTMLControls.DrawComboBox("CboMileMonth", "select 0,'--Select Month--' ",,, "class='form-control CboSelect' onChange='javascript:CboMileMonth_OnChange(this.value);'",,,, ) %>
                                      <%--  <% CommonFunctions.HTMLControls.DrawComboBox("CboMileWeek", "usp_Sel_ProjectRevenue_Projection_Year_Quarter_Month 'Week' ",,, "class='form-control CboSelect' onChange='javascript:CboMilestone_OnChange(this.value);'",,, ) %>--%>
                                         <% CommonFunctions.HTMLControls.DrawComboBox("CboMileWeek", "Select 0,'--Select Week--'",,, "class='form-control CboSelect' onChange='javascript:CboMilestone_OnChange(this.value);'",,, ) %>
                                        <%--End Added by Swapnagandha K. on 6/18/2019--%>
                                        <div class="chartboxaction dropdown float-end">
                                            <button type="button" class="btn borderbtngray dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Select Graph Type">
                                                <i class="far fa-chart-bar"></i><span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a id="barmile">Bar Chart</a></li>
                                                <li><a id="linemile">Line Chart</a></li>
                                                <li><a id="barlinemile">Bar &amp; Line Chart</a></li>
                                            </ul>
                                            <%--<button type="button" id="milerefresh" class="btn borderbtngray" data-widget="remove" data-toggle="tooltip" data-placement="bottom" title="Reload Metadata"><i class="fas fa-redo"></i></button>--%>
                                        </div>
                                    </div>
                                    <!-- /.box-header -->
                                    <label id="lblrevenuemilestonechart" style="margin-left: 40%;"></label>
                                    <div class="box-body" id="divmilestone">

                                        <!--<canvas id="milestonerevenue" width="400" height="120"></canvas>-->
                                        <canvas id="revenuemilestonechart" width="400" height="120"></canvas>

                                    </div>
                                    <!-- /.box-body -->

                                    <!-- /.box -->
                                </div>

                                <div class="clearfix"></div>
                            </div>
                            <!--resource surplus end-->

                            <!--milestone revenue projection-->
                            <div class="col-sm-12">
                                <div class="box box-panel box-solid chartbox">
                                    <div class="box-header boxheaderblue with-border">
                                        <h3>Project Completion and Payment % </h3>
                                    </div>
                                    <div class="box chartboxheader">
                                          <%--Commented & Added By Dipali V On 10th May 2023 For UI Issue--%>
                                      <%--  <label class="mr-1"></label>--%>
                                          <%--End of Commented & Added By Dipali V On 10th May 2023 For UI Issue--%>
                                        <%--  <select class="form-control">
                                                    <option>Years</option>
                                                    <option>2001</option>
                                                    <option>2002</option>
                                                    <option>2003</option>
                                                    <option>2004</option>
                                                    <option>2005</option>
                                                    <option>2006</option>
                                                    <option>2007</option>
                                                    <option>2008</option>
                                                    <option>2009</option>
                                                    <option>2010</option>
                                                    <option>2011</option>
                                                    <option>2012</option>

                                                </select>

                                                <select class="form-control">
                                                    <option>Month Year Due</option>
                                                    <option>Jan</option>
                                                    <option>Feb</option>
                                                    <option>Mar</option>
                                                    <option>Apr</option>
                                                    <option>May</option>
                                                    <option>Jun</option>
                                                    <option>Jul</option>
                                                    <option>Aug</option>
                                                    <option>Sep</option>
                                                    <option>Oct</option>
                                                    <option>Nov</option>
                                                    <option>Dec</option>
                                                </select>

                                                <select class="form-control">
                                                    <option>Project</option>
                                                    <option>ABC CORP-TURNKY 2017</option>
                                                    <option>SF CORP-TURNKY 2017</option>
                                                    <option>ABC CORP-TURNKY 2017</option>
                                                    <option>SF CORP-TURNKY 2017</option>
                                                </select>--%>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboComplYear", "usp_Sel_ProjectCompletion_Payment_Year_Month_Project 'Year' ",,, "class='form-control CboSelect' onChange='javascript:CboComplYear_OnChange(this.value);'",,, ) %>

                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboComplMonth", "usp_Sel_ProjectCompletion_Payment_Year_Month_Project 'Month' ",,, "class='form-control CboSelect' onChange='javascript:CboComplMonth_OnChange(this.value);'",,, ) %>
                                       
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboComplWeek", "Select 0,'--Select Week--'",,, "class='form-control CboSelect' onChange='javascript:CboCompl_Pay_OnChange(this.value);'",,, ) %>
                                      
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboComplProject", "usp_Sel_ProjectCompletion_Payment_Year_Month_Project 'Project' ",,, "class='form-control CboSelect' onChange='javascript:CboCompl_Pay_OnChange(this.value);'",,, ) %>
                                        <div class="chartboxaction dropdown float-end">
                                            <button type="button" class="btn borderbtngray dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Select Graph Type">
                                                <i class="far fa-chart-bar"></i><span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a id="barcompl">Bar Chart</a></li>
                                                <li><a id="linecompl">Line Chart</a></li>
                                                 <li><a id="barlinecompl">Bar & Line Chart</a></li>
                                            </ul>
                                            <%--<button type="button" id="Complrefresh" class="btn borderbtngray" data-widget="remove" data-toggle="tooltip" data-placement="bottom" title="Reload Metadata"><i class="fas fa-redo"></i></button>--%>
                                        </div>
                                    </div>
                                    <!-- /.box-header -->
                                    <label id="lblprojectcompletion" style="margin-left:40%;"></label>
                                    <div class="box-body" id="divprojectcompletion">

                                        <canvas id="projectcompletion" height="140"></canvas>

                                    </div>
                                    <!-- /.box-body -->

                                    <!-- /.box -->
                                </div>

                                <div class="clearfix"></div>
                            </div>
                            <!--milestone revenue projection end-->

                        </div>
                    </div>


                </div>


            </div>


            <div id="Dailytab" class="tab-pane" style="display: none;">
                <div class="container-fluid">
                    <div class="box defayltbox" style="min-height: 700px; background: #fff;">
                        <div class="box-header with-border">
                            <h3 class="box-title">Title</h3>

                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            Comming Soon
			  			  
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
            </div>
            <!-- /Daily End -->

            <div class="clearfix"></div>
        </div>
    </section>

    <div class="clearfix"></div>


    <!-- /.content -->



     <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header" style="background-color:#4263c1;">
          <button type="button" class="close" data-bs-dismiss="modal"><img src="../../../Whizible2.0/dist/img/closeicon-white1.svg" width="20" alt="" /></button>
          <h2 class="modal-title" style="color: #fff">E-DashBoard</h2>
        </div>
        <div class="modal-body">
          <p>This is a high level dashboard that displays statistics of important heads. This displays graphs of Resource utilization, Staffing Plan and other important graphs of finance.</p>
           <h4> 1.Resource Utilization</h4>
            <P>This graph displays customer wise Resource availability in hours, utilization hours and Invoiced hours.</P>
            <p>There will be filters of Year, Month, Week and Customer.</p>

            <h4> 2.Resource Staffing Numbers</h4>
            <P>This graph displays Count of resources Capacity, Allocated, Bench, Required ,Released and the count of resources short or surplus, skill wise.</P>
            <p>There will be filters of Year, Month, Week and Skill.</p>

            <h4> 3.Staffing -Short /Surplus (Cost Billability)</h4>
            <P>This graph displays cost of resources short or surplus , skill wise.</P>
            <p>There will be filters of Year, Month, Week and Skill .</p>

            <h4> 4.Project Revenue Projection</h4>
            <P> Here the project revenue of four quarters will be displayed along with the  number of milestones in each month.</P>
            <p>This graph will have filter of Year ,Quarter, Month and  Week</p>

            <h4> 5.Project Completion and Payment % </h4>
            <P>This graph displays Project Completion and Payment %  display along with sum of payment % and sum of completion % and Number of Milestone.</P>
            <p>There will be filters of Year, Month, Week and Project.</p>

            <h4> 6.Revenue Recognition and Realization </h4>
            <P>This graph displays Revenue Recognition and Realization Chart with Recognition Amount and Realization Invoice Payment.</P>
            <p>There will be filters of Year, Month, Week and Project.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

    <!-- ./wrapper -->

    <!-- REQUIRED JS SCRIPTS -->
        <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/custom_mobile.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.bundle.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/utils.js"></script>
    <script type="text/javascript" src="../../responsive/responsive.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>

    <script type='text/javascript'>

        //project hour and cost chart start

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var flag;
        var Year, Month, CustomerID;
        $(document).ready(function () {
            //debugger;
            flag = "week";
            Year = document.getElementById("CboYear").value;
            Month = document.getElementById("CboMonth").value;
            CustomerID = document.getElementById("CboCustomer").value;
            //alert(document.getElementById("CboMileWeek").value)
            ResourceUtilizedCustomer('bar', 'line', Year,Month, document.getElementById("CboWeek").value,CustomerID, flag);
            //GetSelectValueWeek(Year, Month);
            ResourceUtilizedSkill('bar', '', '', '', '', flag);
            ResourceUtilizedSkill_SurPlus('bar', '', '', '', '', flag);
            ProjectRevenueMilestone('bar', 'line', 0, 0, 0, document.getElementById("CboMileWeek").value, flag);
            var WeekNumber = $('select#CboRevWeek option:selected').val();
            ProjectRevenueRecognition('line', '', '', 0, WeekNumber, flag);
            ProjectCompletionPayment('bar', 'line', '', '', '', '', flag);

            //Added by Swapnagandha K. 15-Apr-2019
            CboCustomerYear_OnChange(document.getElementById("CboYear").value);
            CboSkillYear_OnChange(document.getElementById("CboSYear").value);
            CboRevYear_OnChange(document.getElementById("CboRevYear").value);
          //  CboSurYear_OnChange(document.getElementById("CboSurYear").value);


            CboCustomerMonth_OnChange(document.getElementById("CboMonth").value);
           // debugger;
            CboSkillMonth_OnChange(document.getElementById("CboSMonth").value);
            CboRevMonth_OnChange(document.getElementById("CboRevMonth").value);
            CboSurMonth_OnChange(document.getElementById("CboSurMonth").value);
            CboComplMonth_OnChange(document.getElementById("CboComplMonth").value);
             //debugger;
            //Added By Dipali V On 13rd May 2019 For Dashboard Blank Issue
            $("select#CboCustomer").change();
           //End of Added By Dipali V On 13rd May 2019 For Dashboard Blank Issue
            //CboCustomer_OnChange()
           
            
            
            
            //Added by Swapnagandha K. 18-Jun-2019
           // CboMileYear_OnChange();
            //CboMileQuarter_OnChange();   

        });


        function Weekly_Onclick() {
            //debugger;
            flag = "week";
            Year = document.getElementById("CboYear").value;
            Month = document.getElementById("CboMonth").value;
            CustomerID = document.getElementById("CboCustomer").value;

            ResourceUtilizedCustomer('bar', 'line',Year,Month, document.getElementById("CboWeek").value,CustomerID, flag);
            ResourceUtilizedSkill('bar', '', '', '', '', flag);
            ResourceUtilizedSkill_SurPlus('bar', '', '', '', '', flag);
            ProjectRevenueMilestone('bar', 'line', 0, 0, 0, document.getElementById("CboMileWeek").value, flag);
            //debugger;
            var WeekNumber = $('select#CboRevWeek option:selected').val();
            ProjectRevenueRecognition('line', '', '', 0, WeekNumber, flag);
            ProjectCompletionPayment('bar', 'line', '', '', '', '', flag);

        }
        function Monthly_Onclick() {
            //debugger;
            flag = "month";
             Year = document.getElementById("CboYear").value;
            Month = document.getElementById("CboMonth").value;
            CustomerID = document.getElementById("CboCustomer").value;

            ResourceUtilizedCustomer('bar', 'line', Year, Month,document.getElementById("CboWeek").value,CustomerID, flag);
            ResourceUtilizedSkill('bar', '', '', '', '', flag);
            ResourceUtilizedSkill_SurPlus('bar', '', '', '', '', flag);
            ProjectRevenueMilestone('bar', 'line', 0, 0, 0, 0, flag);
            ProjectRevenueRecognition('line', '', '', 0, $('select#CboRevWeek option:selected').val(), flag);
            ProjectCompletionPayment('bar', 'line', '', '', '', '', flag);

        }
        var mixedChart;
        var newType;
        var lineType;
        var myChart;
        //var Year = 0;
        var CommercialValue = 0;
        //var Week = 0;
        //var CustomerID = 0;

        var arrCustomer = [];
        var arrAvailable = [];
        var arrUtilization = [];
        var arrInvoiced = [];

        //function CboOnChange(objval) {

        //    var DashBoardParameter = {
        //        cboType: 'Week',
        //        intYear: document.getElementById("CboYear").value,
        //        intMonth: document.getElementById("CboMonth").value,
        //    }

        //    var selHTML = "";
        //    selHTML = AjaxCallCboChange(DashBoardParameter);

        //    $("#CboWeek").html(selHTML);
        //    $(".selectpicker").selectpicker('refresh');
        //}
        //function AjaxCallCboChange(DashBoardParameter) {
        //    //debugger;

        //    var selHTML = "";
        //    $.ajax({
        //        url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBox',
        //        type: "POST",
        //        data: JSON.stringify(DashBoardParameter),
        //        dataType: "json",
        //        contentType: "application/json;charset-utf=8",
        //        async: false,
        //        beforeSend: function (xhr) {
        //            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
        //        },
        //        success: function (data) {

        //            //selHTML += "<option  selected value=''>Select Task Type</option>"
        //            for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
        //                var d = data.objDependent_ComboBox[i];
        //                var CboID = d.CboID;
        //                var CboName = d.CboName;
        //                selHTML += "<option title='" + CboName + "' value='" + CboID + "'>" + CboName + "</option>";

        //            }

        //        },
        //        error: function (err) {
        //            console.log(err);
        //            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
        //        }
        //    });
        //    return selHTML;
        //}

        function ResourceUtilizedCustomer(newType, lineType, Year, Month, Week, CustomerID, flag) {
            //debugger;
            //if (Year == '') {
            //    Year = document.getElementById("CboYear").value;
            //    Month = document.getElementById("CboMonth").value;
            //    //Week = document.getElementById("CboWeek").value;
            //    CustomerID = document.getElementById("CboCustomer").value;
            //    arrCustomer = [];
            //    arrAvailable = [];
            //    arrUtilization = [];
            //    arrInvoiced = [];
            //}
            //else {
                Year = Year;
                Month = Month;
                Week = Week;
                CustomerID = CustomerID;
                arrCustomer = [];
                arrAvailable = [];
                arrUtilization = [];
                arrInvoiced = [];
            //}
            var DashBoardParameter = {
                intYear: Year,
                intMonth: Month,
                intWeek: Week,
                intCustomerID: CustomerID,
                Flag: flag
            }

            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetResourceUtilization',
                type: "POST",
                data: JSON.stringify(DashBoardParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                //async:false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (DashBoardParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DashBoardParameter) ? DashBoardParameter : JSON.stringify(DashBoardParameter)));
                    }
                },
                success: function (response) {
                    //debugger;
                    // alert(response.DashboardCustLists);
                    if (response.DashboardCustLists != '') {
                        for (var i = 0; i < response.DashboardCustLists.length; i++) {
                            //debugger;
                            var ObjDashBoard = response.DashboardCustLists[i];
                            var CustomerName = ObjDashBoard.CustomerName;
                            var Available = ObjDashBoard.Available;
                            var Utilization = ObjDashBoard.Utilization;
                            var Invoiced = ObjDashBoard.Invoiced;
                            if (flag == "week") {
                                var Week = ObjDashBoard.WeekNumber;
                                var strcustomerWeek = CustomerName + "\n" + "week-" + Week;
                            }
                            else {
                                var Monthname = ObjDashBoard.Monthname;
                                var strcustomerWeek = CustomerName + "\n" + Monthname;

                            }
                            arrCustomer.push(strcustomerWeek);
                            arrAvailable.push(Available.toFixed(2));
                            arrUtilization.push(Utilization.toFixed(2));
                            arrInvoiced.push(Invoiced.toFixed(2));
                        }
                        var config = {
                            type: newType,
                            data: {
                                labels: arrCustomer,
                                datasets: [{
                                    type: lineType,
                                    label: 'Invoice Hrs',
                                    borderColor: '#71b23e',
                                    borderWidth: 2,
                                    fill: false,
                                    data: arrInvoiced,
                                    yAxisID: "y-axis-1",
                                }, {
                                    type: lineType,
                                    label: 'Utilization Hrs',
                                    borderColor: '#a7a9ad',
                                    borderWidth: 2,
                                    fill: false,
                                    data: arrUtilization,
                                    yAxisID: "y-axis-1",
                                }, {

                                    type: newType,
                                    label: "Available Hrs",
                                    backgroundColor: '#fbb03b',
                                    data: arrAvailable,
                                    //borderColor: 'white',
                                    borderColor: '#fbb03b',
                                    borderWidth: 2,
                                    fill: false,
                                    yAxisID: "y-axis-2",
                                }]
                            },
                            options: {
                                responsive: true,
                                 legend: {
                                    position: 'top',
                                },
                                title: {
                                    display: true,
                                    text: 'Resource Utilization(Customer)'
                                },
                                scales: {
                                    xAxes: [{
                                        ticks: {
                                            autoSkip: false,
                                            //maxRotation: 90,
                                            //minRotation: 90,
                                            labelAngle: 30
                                        },
                                        barPercentage: 0.2
                                    }],
                                    yAxes: [{
                                        type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                        display: true,
                                        position: "left",
                                        id: "y-axis-1",
                                        scaleLabel: {
                                            display: true,
                                            labelString: 'Invoice Hrs / Utilization Hrs'
                                        },
                                        ticks: {
                                           suggestedMin: 0
                                        }
                                    }, {
                                        type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                        display: true,
                                        position: "right",
                                        id: "y-axis-2",
                                        scaleLabel: {
                                            display: true,
                                            labelString: 'Available Hrs'
                                            },
                                        ticks: {
                                           suggestedMin: 0
                                        }
                                    }],
                                }
                            },
                            plugins: [{
                                beforeInit: function (myBarChart2) {
                                    myBarChart2.data.labels.forEach(function (e, i, a) {
                                        if (/\n/.test(e)) {
                                            a[i] = e.split(/\n/);
                                        }
                                    });
                                }
                            }]
                        };

                          $("#lblmixedChart").text("");
                        var ctx = document.getElementById("mixedChart").getContext("2d");

                        // Remove the old chart and all its event handles
                        if (myChart) {
                            myChart.destroy();
                        }

                        // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
                        var temp = jQuery.extend(true, {}, config);
                        temp.type = newType;
                        myChart = new Chart(ctx, temp);
                    }
                    else {
                        //var canvas = document.getElementById("mixedChart");
                        //var ctx = canvas.getContext("2d");
                       // debugger;
                        //var ctx = document.getElementById("mixedChart").getContext("2d");
                        //ctx.font = "16px Arial";
                        //ctx.fillText("Snapshot data not available", 10, 16);
                       $("#lblmixedChart").text("Snapshot data not available");
                         if (myChart) {
                            myChart.destroy();
                        }
                    }
                },
                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }

            })

        }

        $("#line").click(function () {
            //window.myChart = new Chart(ctxChart).Line(newdata, options);
            var Year = $('select#CboYear option:selected').val();
            var Month = $('select#CboMonth option:selected').val();
            var Week = $('select#CboWeek option:selected').val();
            var CustomerID = $('select#CboCustomer option:selected').val();
            ResourceUtilizedCustomer('line', 'line', Year, Month, Week, CustomerID, flag);
            if (myChart != undefined) {
            myChart.data.datasets[2].type = "line";
            myChart.data.datasets[2].fill = "false";
            myChart.data.datasets[2].borderColor = "#fbb03b";
            myChart.options.bezierCurve = "false";

            myChart.update();
            }
          
        });

        $("#bar").click(function () {
            //debugger;
            var Year = $('select#CboYear option:selected').val();
            var Month = $('select#CboMonth option:selected').val();
            var Week = $('select#CboWeek option:selected').val();
            var CustomerID = $('select#CboCustomer option:selected').val();
            ResourceUtilizedCustomer('bar', 'bar', Year, Month, Week, CustomerID, flag);
            if (myChart != undefined) {
                myChart.data.datasets[0].type = "bar";
                myChart.data.datasets[0].backgroundColor = "#71b23e";
                myChart.data.datasets[1].type = "bar";
                myChart.data.datasets[1].backgroundColor = "#b9b7b7";
                myChart.update();
            }
        });

        $("#barandline").click(function () {
             var Year = $('select#CboYear option:selected').val();
            var Month = $('select#CboMonth option:selected').val();
            var Week = $('select#CboWeek option:selected').val();
            var CustomerID = $('select#CboCustomer option:selected').val();
            ResourceUtilizedCustomer('bar', 'line',Year,Month, Week,CustomerID, flag);
        });

        //$("#redograph").click(function() {
        //ResourceUtilizedCustomer('bar','line','','',document.getElementById("CboWeek").value,'',flag);
        //});

        function CboCustomer_OnChange() {
            //debugger;
            var Year = $('select#CboYear option:selected').val();
            var Month = $('select#CboMonth option:selected').val();
            var Week = $('select#CboWeek option:selected').val();
            var CustomerID = $('select#CboCustomer option:selected').val();
            ResourceUtilizedCustomer('bar', 'line', Year, Month, Week, CustomerID, flag);
        }

        function CboCustomerYear_OnChange() {

            //debugger;
            var Year = $('select#CboYear option:selected').val();
             GetSelectValueMonth(Year);
        }

        function GetSelectValueMonth(Year) {
            //debugger;
            dashboardParameters = {
                cboType: 'Month',
                intYear: Year
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBox',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("CboMonth");
                    $("#CboMonth option").remove();
                     $("#CboWeek option").remove();
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                       // debugger;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjDashBoard.CboName;
                        objOption.value = ObjDashBoard.CboID;
                    }
           // ResourceUtilizedCustomer('bar', 'line', Year,Month, $('select#CboWeek option:selected').val(),CustomerID, flag);
                    GetSelectValueWeek(Year, $('select#CboMonth option:selected').val())
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function CboCustomerMonth_OnChange()
        {
            //debugger;
            var Year = $('select#CboYear option:selected').val();
            var Month = $('select#CboMonth option:selected').val();
            GetSelectValueWeek(Year, Month);
        }
        function GetSelectValueWeek(Year, Month) {
            //debugger;
            var CustomerID = $('select#CboCustomer option:selected').val();

            dashboardParameters = {
                cboType: 'Week',
                intYear: Year,
                intMonth: Month
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBox',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("CboWeek");
                    $("#CboWeek option").remove();
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                       // debugger;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjDashBoard.CboName;
                        objOption.value = ObjDashBoard.CboID;
                    }
            ResourceUtilizedCustomer('bar', 'line', Year,Month, $('select#CboWeek option:selected').val(),CustomerID, flag);

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }


        //project hour and cost chart end here	


        //staffing plan start

        var SkillID = 0;
        var myBarChart1;
        var arrSkill = [];
        var arrResourceCapacity = [];
        var arrResourceAllocated = [];
        var arrOpportunityReq = [];
        var arrResourceBench = [];
        var arrResourceRelease = [];
        var arrResourceShort_Surplus = [];

        function ResourceUtilizedSkill(newType, Year, Month, Week, SkillID, flag) {
            //debugger;
            if (Year == '') {
                Year = document.getElementById("CboSYear").value;
                Month = document.getElementById("CboSMonth").value;
                Week = document.getElementById("CboSWeek").value;
                SkillID = document.getElementById("CboSkill").value;
                arrSkill = [];
                arrResourceCapacity = [];
                arrResourceAllocated = [];
                arrOpportunityReq = [];
                arrResourceBench = [];
                arrResourceRelease = [];
                arrResourceShort_Surplus = [];
            }
            else {
                Year = Year;
                Month = Month;
                Week = Week;
                SkillID = SkillID;
                arrSkill = [];
                arrResourceCapacity = [];
                arrResourceAllocated = [];
                arrOpportunityReq = [];
                arrResourceBench = [];
                arrResourceRelease = [];
                arrResourceShort_Surplus = [];
            }
            var DashBoardParameter = {
                intYear: Year,
                intMonth: Month,
                intWeek: Week,
                intSkillID: SkillID,
                Flag: flag
            }

            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetResourceUtilizationSkill',
                type: "POST",
                data: JSON.stringify(DashBoardParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (DashBoardParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DashBoardParameter) ? DashBoardParameter : JSON.stringify(DashBoardParameter)));
                    }
                },

                success: function (response) {
                    //debugger;
                    //alert(response);
                    if (response.DashboardSkillLists != '') {
                        for (var i = 0; i < response.DashboardSkillLists.length; i++) {
                            //debugger;
                            var ObjDashBoard = response.DashboardSkillLists[i];
                            var SkillName = ObjDashBoard.SkillName;
                            var ResourceCapacity = ObjDashBoard.ResourceCapacity;
                            var ResourceAllocated = ObjDashBoard.ResourceAllocated;
                            var OpportunityReq = ObjDashBoard.OpportunityReq;
                            var ResourceBench = ObjDashBoard.ResourceBench
                            var ResourceRelease = ObjDashBoard.ResourceRelease
                            var ResourceShort_Surplus = ObjDashBoard.ResourceShort_Surplus
                            if (flag == "week") {
                                var Week = ObjDashBoard.WeekNumber;
                                var Uniq = SkillName + "\n" + "Week-" + Week;
                            }
                            else {
                                var Monthname = ObjDashBoard.MonthName;
                                var Uniq = SkillName + "\n" + Monthname;
                            }
                            arrSkill.push(Uniq);
                            arrResourceCapacity.push(ResourceCapacity.toFixed(2));
                            arrResourceAllocated.push(ResourceAllocated.toFixed(2));
                            arrOpportunityReq.push(OpportunityReq.toFixed(2));
                            arrResourceBench.push(ResourceBench.toFixed(2));
                            arrResourceRelease.push(ResourceRelease.toFixed(2));
                            arrResourceShort_Surplus.push(ResourceShort_Surplus.toFixed(2));
                        }
                        //alert(arrSkill);

                        var myBarChart = {
                            type: newType,
                            data: {
                                labels: arrSkill,
                                datasets: [{
                                    label: "Resource Capacity",
                                    backgroundColor: "#98cef3",
                                    borderColor: "#98cef3",
                                    fill: false,
                                    data: arrResourceCapacity
                                }, {
                                    label: "Resource Allocated",
                                    backgroundColor: "#F98843",
                                    borderColor: "#F98843",
                                    fill: false,
                                    data: arrResourceAllocated
                                }, {
                                    label: "Opportunity Req",
                                    backgroundColor: "#A7A9AD",
                                    borderColor: "#A7A9AD",
                                    fill: false,
                                    data: arrOpportunityReq
                                }, {
                                    label: "Resource Bench",
                                    backgroundColor: "#FBC722",
                                    borderColor: "#FBC722",
                                    fill: false,
                                    data: arrResourceBench
                                }, {
                                    label: "Resource Release ",
                                    backgroundColor: "#5D8CDD",
                                    borderColor: "#5D8CDD",
                                    fill: false,
                                    data: arrResourceRelease
                                }, {
                                    label: "Resource Short Surplus",
                                    backgroundColor: "#71B23E",
                                    borderColor: "#71B23E",
                                    fill: false,
                                    data: arrResourceShort_Surplus
                                }]
                            },                    
                            options: {
                                responsive: true,
                                 legend: {
                                    position: 'top',
                                },
                                title: {
                                    display: true,
                                    text: 'Staffing Plan - By Skill'
                                },
                                scales: {
                                    xAxes: [{
                                    //    ticks: {
                                    //        autoSkip: false,
                                    //        maxRotation: 90,
                                    //        minRotation: 90
                                    //    }
                                        barPercentage: 0.2
                                   }],
                                    yAxes: [{
                                        type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                        display: true,
                                        position: "left",
                                        id: "y-axis-1",
                                        scaleLabel: {
                                            display: true,
                                            labelString: 'Count'
                                        }
                                    }],
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


                        var ctx1 = document.getElementById("staffingplan").getContext("2d");

                        // Remove the old chart and all its event handles
                        if (myBarChart1) {
                            myBarChart1.destroy();
                        }

                        //// Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
                        var temp = jQuery.extend(true, {}, myBarChart);
                        temp.type = newType;
                        myBarChart1 = new Chart(ctx1, temp);
                         $("#lblstaffingplan").text("");

                    }
                    else {
                        //document.getElementById("mixedChart").value="Snapshot data not available"
                        //var canvas = document.getElementById("staffingplan");
                        //var ctx = canvas.getContext("2d");
                        //ctx.font = "16px Arial";
                        //ctx.fillText("Snapshot data not available", 10, 16);

                        $("#lblstaffingplan").text("Snapshot data not available");
                         if (myBarChart1) {
                            myBarChart1.destroy();
                        }
                    }
                },
                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }

            })

        }

        function CboSkillWeek_OnChange() {
            //debugger;
            var Year = $('select#CboSYear option:selected').val();
            var Month = $('select#CboSMonth option:selected').val();
            var Week = $('select#CboSWeek option:selected').val();
            var SkillID = $('select#CboSkill option:selected').val();
            ResourceUtilizedSkill('bar', Year, Month, Week, SkillID, flag);

        }

        $("#lineskill").click(function () {
            var Year = $('select#CboSYear option:selected').val();
            var Month = $('select#CboSMonth option:selected').val();
            var Week = $('select#CboSWeek option:selected').val();
            var SkillID = $('select#CboSkill option:selected').val();
            ResourceUtilizedSkill('line', Year, Month, Week, SkillID, flag);
           // $('html, body').animate({ scrollTop: $("#divstaffplan").offset().top }, 100);
    

        });

        $("#barskill").click(function () {
            var Year = $('select#CboSYear option:selected').val();
            var Month = $('select#CboSMonth option:selected').val();
            var Week = $('select#CboSWeek option:selected').val();
            var SkillID = $('select#CboSkill option:selected').val();
            ResourceUtilizedSkill('bar', Year,Month, Week, SkillID, flag);
           // $('html, body').animate({ scrollTop: $("#divstaffplan").offset().top }, 50);

        });

         function CboSkillYear_OnChange() {

            //debugger;
            var Year = $('select#CboSYear option:selected').val();
             GetSelectValueSkillMonth(Year);
        }

        function GetSelectValueSkillMonth(Year) {
            //debugger;
            dashboardParameters = {
                cboType: 'Month',
                intYear: Year
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBoxSkill',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("CboSMonth");
                    $("#CboSMonth option").remove();
                     $("#CboSWeek option").remove();
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                       // debugger;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjDashBoard.CboName;
                        objOption.value = ObjDashBoard.CboID;
                    }
           // ResourceUtilizedCustomer('bar', 'line', Year,Month, $('select#CboWeek option:selected').val(),CustomerID, flag);
                    GetSelectValueSkillWeek(Year, $('select#CboSMonth option:selected').val())
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function CboSkillMonth_OnChange()
        {
            //debugger;
            var Year = $('select#CboSYear option:selected').val();
            var Month = $('select#CboSMonth option:selected').val();
            GetSelectValueSkillWeek(Year, Month);
        }
        function GetSelectValueSkillWeek(Year, Month) {
            //debugger;
            var SkillID = $('select#CboSkill option:selected').val();

            dashboardParameters = {
                cboType: 'Week',
                intYear: Year,
                intMonth: Month
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBoxSkill',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("CboSWeek");
                    $("#CboSWeek option").remove();
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                       // debugger;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjDashBoard.CboName;
                        objOption.value = ObjDashBoard.CboID;
                    }
                    ResourceUtilizedSkill('bar', Year, Month, $('select#CboSWeek option:selected').val(), SkillID, flag);
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }



        //staffing plan chart end


        //project completion start

        var myBarChart5;
        var month = "";
        var ProjectID = "";
        var arrMonthName = [];
        var  arrWeek = [];
        var arrProjectName = [];
        var arrCountMileStone = [];
        var arrSumPaymentPercentage = [];
        var arrSumCompletionPercentage = [];

        function ProjectCompletionPayment(newType, lineType, Year, month, ProjectID, WeekNumber, flag) {
            //debugger;
            if (Year == '') {
                Year = document.getElementById("CboComplYear").value;
                month = document.getElementById("CboComplMonth").value;
                if (month == '--Select Month--') {
                    month = 0;
                }
                ProjectID = document.getElementById("CboComplProject").value;
                if (ProjectID == '--Select Project--') {
                    ProjectID = 0;
                }
                arrMonthName = [];
                arrProjectName = [];
                arrWeek = [];
                arrCountMileStone = [];
                arrSumPaymentPercentage = [];
                arrSumCompletionPercentage = [];

            }
            else {
                Year = Year;
                if (month == '--Select Month--') {
                    month = 0;
                }
                month = month;
                if (ProjectID == '--Select Project--') {
                    ProjectID = 0;
                }
                ProjectID = ProjectID;
                arrMonthName = [];
                arrProjectName = [];
                arrWeek = [];
                arrProject = [];
                arrCountMileStone = [];
                arrSumPaymentPercentage = [];
                arrSumCompletionPercentage = [];
            }
            var DashBoardParameter = {
                intYear: Year,
                intMonth: month,
                intProjectID: ProjectID,
                intWeek: document.getElementById("CboComplWeek").value,
                Flag: flag,
            }

            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetProjectCompletion_Payment',
                type: "POST",
                data: JSON.stringify(DashBoardParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (DashBoardParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DashBoardParameter) ? DashBoardParameter : JSON.stringify(DashBoardParameter)));
                    }
                },

                success: function (response) {
                    //debugger;
                 // alert(response);
                    if (response.DashboardProjectCompl_PayLists != '') {
                        for (var i = 0; i < response.DashboardProjectCompl_PayLists.length; i++) {
                           //debugger;
                            var ObjDashBoard = response.DashboardProjectCompl_PayLists[i];
                            var MonthName = ObjDashBoard.MonthName;
                            var ProjectName=ObjDashBoard.ProjectName;
                            var CountMonthMileStone = ObjDashBoard.CountMileStone;
                            var PaymentPercentage = ObjDashBoard.Sum_PaymentPercentage;
                            var CompletionPercentage = ObjDashBoard.Sum_CompletionPercentage;

                            
                           // arrMonthName.push(MonthName);
                            arrWeek.push("Week - " + ObjDashBoard.WeekNumber);

                             if (flag == "week") {
                                //var labels= ;
                               // var Week = arrWeek;
                                var strProjectWeek = ObjDashBoard.ProjectName + " ( " +  "Week - " + ObjDashBoard.WeekNumber + " ) ";
                            }
                            else {
                                //var Monthname = arrMonthName;
                                var strProjectWeek = ObjDashBoard.ProjectName + " ( " +  ObjDashBoard.MonthName + " ) "; 

                            }

                            arrProjectName.push(strProjectWeek);
                            arrCountMileStone.push(CountMonthMileStone);
                            arrSumPaymentPercentage.push(PaymentPercentage.toFixed(2));
                            arrSumCompletionPercentage.push(CompletionPercentage.toFixed(2));
                        }
                        //alert(arrProject);
                        

                        //alert(strProjectWeek);
                        //debugger;
                        
                         var ComplPaymentChartData = {
                            type: newType,
                            data: {
                                labels: arrProjectName,
                                datasets: [{
                                    type: lineType,
                                    label: 'Sum of Payment %',
                                    borderColor: '#A7A9AD',
                                    borderWidth: 2,
                                    fill: false,
                                    data: arrSumPaymentPercentage,
                                    yAxisID: "y-axis-1",
                                },
                                {
                                    type: lineType,
                                    label: 'Sum of Completion %',
                                    borderColor: '#fbb03b',
                                    borderWidth: 2,
                                    fill: false,
                                    data: arrSumCompletionPercentage,
                                    yAxisID: "y-axis-1",
                                }, {

                                    type: newType,
                                    label: "No. of Milestone",
                                    backgroundColor: '#577DD0',
                                    data: arrCountMileStone,
                                    //borderColor: 'white',
                                    borderColor: '#577DD0',
                                    borderWidth: 2,
                                    fill: false,
                                    yAxisID: "y-axis-2",
                                }]
                            },
                            options: {
                                responsive: true,
                                legend: {
                                    position: 'top',
                                },
                                title: {
                                    display: true,
                                    text: 'Project Completion and Payment % '
                                },
                                scales: {
                                    xAxes: [{
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 30,
                                            minRotation: 30
                                        },
                                        barPercentage: 0.2
                                    }],
                                    yAxes: [{
                                        type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                        display: true,
                                        position: "left",
                                        id: "y-axis-1",
                                        scaleLabel: {
                                            display: true,
                                            labelString: 'Sum of Payment % / Sum of Completion %'
                                        }
                                    }, {
                                        type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                        display: true,
                                        position: "right",
                                        id: "y-axis-2",
                                        scaleLabel: {
                                            display: true,
                                            labelString: 'No of Milestone'
                                        }
                                    }],
                                }
                            }
                        };

                        var ctx5 = document.getElementById('projectcompletion').getContext('2d');

                        // Remove the old chart and all its event handles
                        if (myBarChart5) {
                            myBarChart5.destroy();
                        }

                        //// Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
                        var temp = jQuery.extend(true, {}, ComplPaymentChartData);
                        temp.type = newType;
                        myBarChart5 = new Chart(ctx5, temp);
                         $("#lblprojectcompletion").text("");

                    } else {
                        //document.getElementById("mixedChart").value="Snapshot data not available"
                        //var canvas = document.getElementById("projectcompletion");
                        //var ctx = canvas.getContext("2d");
                        //ctx.font = "16px Arial";
                        //ctx.fillText("Snapshot data not available", 10, 16);
                         $("#lblprojectcompletion").text("Snapshot data not available");
                            if (myBarChart5) {
                            myBarChart5.destroy();
                        }

  
                    }

                },
                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }

            })

        }

        function CboCompl_Pay_OnChange() {
            var Year = $('select#CboComplYear option:selected').val();
            var month = $('select#CboComplMonth option:selected').val();
            var ProjectID = $('select#CboComplProject option:selected').val();
            var WeekNumber = $('select#CboComplWeek option:selected').val();
            ProjectCompletionPayment('bar', 'line', Year, month, ProjectID, WeekNumber, flag)
        }

        $("#linecompl").click(function () {
            //debugger;
            var Year = $('select#CboComplYear option:selected').val();
            var month = $('select#CboComplMonth option:selected').val();
            var ProjectID = $('select#CboComplProject option:selected').val();
            var WeekNumber = $('select#CboComplWeek option:selected').val();
            ProjectCompletionPayment('line', 'line', Year, month, ProjectID, WeekNumber, flag)
           // $('html, body').animate({ scrollTop: $("#divprojectcompletion").offset().top }, 100);

        });

        $("#barcompl").click(function () {
            var Year = $('select#CboComplYear option:selected').val();
            var month = $('select#CboComplMonth option:selected').val();
            var ProjectID = $('select#CboComplProject option:selected').val();
            var WeekNumber = $('select#CboComplWeek option:selected').val();
            ProjectCompletionPayment('bar', 'bar', Year, month, ProjectID, WeekNumber, flag)
          // $('html, body').animate({ scrollTop: $("#divprojectcompletion").offset().top }, 100);
        });

        
         $("#barlinecompl").click(function () {
            var Year = $('select#CboComplYear option:selected').val();
            var month = $('select#CboComplMonth option:selected').val();
            var ProjectID = $('select#CboComplProject option:selected').val();
            var WeekNumber = $('select#CboComplWeek option:selected').val();
            ProjectCompletionPayment('bar', 'line', Year, month, ProjectID, WeekNumber, flag)
         //  $('html, body').animate({ scrollTop: $("#divprojectcompletion").offset().top }, 100);
        });

        function CboComplYear_OnChange() {

            //debugger;
            var Year = $('select#CboComplYear option:selected').val();
             GetSelectValueComplMonth(Year);
        }

        function GetSelectValueComplMonth(Year) {
            //debugger;
            dashboardParameters = {
                cboType: 'Month',
                intYear: Year
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBoxCompl',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("CboComplMonth");
                    $("#CboComplMonth option").remove();
                     $("#CboComplWeek option").remove();
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                       // debugger;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjDashBoard.CboName;
                        objOption.value = ObjDashBoard.CboID;
                    }
           // ResourceUtilizedCustomer('bar', 'line', Year,Month, $('select#CboWeek option:selected').val(),CustomerID, flag);
                    GetSelectValueComplWeek(Year, $('select#CboComplMonth option:selected').val())
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function CboComplMonth_OnChange()
        {
            //debugger;
            var Year = $('select#CboComplYear option:selected').val();
            var Month = $('select#CboComplMonth option:selected').val();
            GetSelectValueComplWeek(Year, Month);
        }
        function GetSelectValueComplWeek(Year, Month) {
            //debugger;
            var ISdata = 0;
            var ProjectID = $('select#CboComplProject option:selected').val();

            dashboardParameters = {
                cboType: 'Week',
                intYear: Year,
                intMonth: Month
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBoxCompl',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    //alert(data.objDependent_ComboBox.length);
                    var objCbo1 = document.getElementById("CboComplWeek");
                    $("#CboComplWeek option").remove();
                    //debugger;
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                        //Added By Dipali V On 11th April 2019 For Placeholder should come when Values is not Selected
                        ISdata = 1;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objOption.text = "";
                        objOption.value = "";
                        //End of Added By Dipali V On 11th April 2019 For Placeholder should come when Values is not Selected
                        if (data.objDependent_ComboBox.length != 0) {
                            objCbo1.options.add(objOption);
                            objOption.text = ObjDashBoard.CboName;
                            objOption.value = ObjDashBoard.CboID;
                        }

                    }

                    ProjectCompletionPayment('bar', 'line', Year, month, ProjectID, $('select#CboComplWeek option:selected').val(), flag)
                    //Added By Dipali V On 11th April 2019 For Placeholder should come when Values is not Selected
                    if (ISdata == 0) {
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = "--Select Week--";
                        objOption.value = "0";
                    }
                    //End of Added By Dipali V On 11th April 2019 For Placeholder should come when Values is not Selected
                },

                //  var ObjDashBoard = data.objDependent_ComboBox[i];

                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }



        //new Chart(document.getElementById("projectcompletion"), {

        //    type: 'bar',
        //    data: {
        //        labels: ["AB CORP-TURNKY 2017", "SF CORP-TURNKY 2018", "AB CORP-TURNKY 2017", "SF CORP-TURNKY 2018", "AB CORP-TURNKY 2017", "SF CORP-TURNKY 2018", "AB CORP-TURNKY 2017", "SF CORP-TURNKY 2018", "AB CORP-TURNKY 2017", "SF CORP-TURNKY 2018", "AB CORP-TURNKY 2017", "SF CORP-TURNKY 2018"],
        //        datasets: [{
        //            lineTension: "0",
        //            radius: "5",
        //            label: "Sum Of Payment %",
        //            type: "line",
        //            borderColor: "#A7A9AD",
        //            data: [0.1, 0.3, 0.01, 0.1, 0.001, 0.2, 0.1, 0.2, 0.1, 0.2, 0.4, 0.1],
        //            fill: false
        //        }, {
        //            label: "No. Of Milestone",
        //            type: "bar",
        //            backgroundColor: "#577DD0",
        //            data: [100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100],
        //        }
        //        ]
        //    },
        //    options: {
        //        responsive: true,
        //        title: {
        //            display: true,
        //            responsive: true,
        //            text: 'Project Completion and Payment %'
        //        },
        //        legend: { display: true },
        //        scales: {
        //            yAxes: [{
        //                responsive: true,
        //                maxBarThickness: 30,
        //                bezierCurve: 'false',
        //                id: 'A',
        //                //type: 'linear',
        //                position: 'left',
        //                ticks: {
        //                    max: 1.2,
        //                    min: 0
        //                }
        //            }, {

        //                id: 'B',
        //                type: 'linear',
        //                position: 'right',
        //                ticks: {
        //                    max: 100,
        //                    min: 0
        //                }
        //            }]
        //        }
        //    }
        //});

        //project completion end here	


        //Revenue Realisation

        var ProjectID = 0;
        var MonthID = 0;
        var myBarChart4;
        var arrRecogProject = [];
        var arrRecogQuarter = [];
        var arrRecogMonth = [];
        var arrRecogAmount = [];
        var arrRecogTotalAmount = [];

        var arrRealProject = [];
        var arrRealQuarter = [];
        var arrRealMonth = [];
        var arrRealTotalInvoicePayment = [];
        var ResultReal = [];
        var ResultRecog = [];
        function ProjectRevenueRecognition(newType, Year, MonthID, ProjectID, WeekNumber, flag) {
            //debugger;
            if (Year == '') {
                Year = document.getElementById("CboRevYear").value;
                MonthID = document.getElementById("CboRevMonth").value;
                //if (Quarter == '--Select Quarter--') {
                //    Quarter = 0;
                //}
                ProjectID = document.getElementById("CboRevProject").value;
                arrRecogProject = [];
                arrRecogQuarter = [];
                arrRecogMonth = [];
                arrRecogAmount = [];
                arrRecogTotalAmount = [];
            }
            else {
                Year = Year;
                MonthID = MonthID;
                ProjectID = ProjectID;
                arrRecogProject = [];
                arrRecogQuarter = [];
                arrRecogMonth = [];
                arrRecogAmount = [];
                arrRecogTotalAmount = [];

                arrRealProject = [];
                arrRealQuarter = [];
                arrRealMonth = [];
                arrRealTotalInvoicePayment = [];
            }
            var DashBoardParameter = {
                intYear: Year,
                intMonth: MonthID,
                intProjectID: ProjectID,
                intWeek: WeekNumber,
                Flag: flag
            }

            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetProjectRevenue_Recognition',
                type: "POST",
                data: JSON.stringify(DashBoardParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (DashBoardParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DashBoardParameter) ? DashBoardParameter : JSON.stringify(DashBoardParameter)));
                    }
                },

                success: function (response) {
                    //debugger;
                    //alert(response);
                    ResultRecog = response.DashboardProjectRevenueRecogLists;
                    for (var i = 0; i < ResultRecog.length; i++) {
                        // debugger;
                        var ObjDashBoard = ResultRecog[i];
                        var Month = ObjDashBoard.MonthName;
                        var Quarter = ObjDashBoard.Quarter;
                        var ProjectName = ObjDashBoard.ProjectName;
                        var Amount = ObjDashBoard.Amount;
                        var TotalAmount = ObjDashBoard.TotalAmount;
                        var Uniquevalue = Quarter;
                        //ProjectName + "\n" + Month + "-" + Quarter
                        //alert(ProjectName.substring(0,20));
                        arrRecogMonth.push(Uniquevalue);
                        arrRecogQuarter.push(Quarter);
                        arrRecogProject.push(ProjectName);
                        arrRecogAmount.push(Amount.toFixed(2));
                        arrRecogTotalAmount.push(TotalAmount.toFixed(2));
                    }

                },

                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }

            });

            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetProjectRevenue_Realization',
                type: "POST",
                data: JSON.stringify(DashBoardParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (DashBoardParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DashBoardParameter) ? DashBoardParameter : JSON.stringify(DashBoardParameter)));
                    }
                },

                success: function (response) {
                    //debugger;
                    //alert(response);
                    ResultReal = response.DashboardProjectRevenueRealLists;
                    for (var i = 0; i < ResultReal.length; i++) {
                        // debugger;
                        var ObjDashBoardReal = ResultReal[i];
                        var Month = ObjDashBoardReal.MonthName;
                        var Quarter = ObjDashBoardReal.Quarter;
                        var InvoicePayment = ObjDashBoardReal.InvoicePayment;
                        //alert(ProjectName.substring(0,20));
                        arrRealMonth.push(Quarter);
                        arrRealQuarter.push(Quarter);
                        //arrRealProject.push(ProjectName);
                        arrRealTotalInvoicePayment.push(InvoicePayment.toFixed(2));
                    }

                },

                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }

            });

            //alert(arrRealTotalInvoicePayment);
            //debugger;
            if (ResultRecog != '' || ResultReal != '') {
                var color = Chart.helpers.color;
                var RevChartData = {
                    type: newType,
                    data: {
                        labels: arrRecogMonth,
                        datasets: [{
                            label: 'Amount',
                            backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
                            borderColor: window.chartColors.blue,
                            borderWidth: 1,
                            fill: false,
                            data: arrRecogAmount
                        }, {
                            label: 'Invoice Payment',
                            backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
                            borderColor: window.chartColors.orange,
                            borderWidth: 1,
                            fill: false,
                            data: arrRealTotalInvoicePayment
                        }]
                    },
                    options: {
                        scales: {
                            xAxes: [{
                                ticks: {
                                    autoSkip: false,
                                    maxRotation: 90,
                                    minRotation: 90
                                },
                                barPercentage: 0.2
                            }],

                            yAxes: [{
                                type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                display: true,
                                position: "left",
                                id: "y-axis-1",
                                scaleLabel: {
                                    display: true,
                                    labelString: 'Amount /Invoice Payment'
                                }
                            }],
                        },
                        responsive: true,
                        legend: {
                                    position: 'top',
                                },
                                title: {
                                    display: true,
                                    text: 'Revenue Recognition and Realization '
                                }
                    },
                    plugins: [{
                        beforeInit: function (myBarChart4) {
                            myBarChart4.data.labels.forEach(function (e, i, a) {
                                if (/\n/.test(e)) {
                                    a[i] = e.split(/\n/);
                                }
                            });
                        }
                    }]
                };


                var ctx4 = document.getElementById('RevRecognition').getContext('2d');

                // Remove the old chart and all its event handles
                if (myBarChart4) {
                    myBarChart4.destroy();
                }

                //// Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
                var temp = jQuery.extend(true, {}, RevChartData);
                temp.type = newType;
                myBarChart4 = new Chart(ctx4, temp);
                 $("#lblRevRecognition").text("");
            }
            else {
                //alert();
                //document.getElementById("mixedChart").value="Snapshot data not available"
                //var canvas = document.getElementById("RevRecognition");
                //var ctx4 = canvas.getContext("2d");
                //ctx4.font = "16px Arial";
                //ctx4.fillText("Snapshot data not available", 10, 16);
                $("#lblRevRecognition").text("Snapshot data not available");
                  if (myBarChart4) {
                    myBarChart4.destroy();
                }

            }

        }

        function CboRevRecogReal_OnChange() {
            //debugger;
            var Year = $('select#CboRevYear option:selected').val();
            var Month = $('select#CboRevMonth option:selected').val();
            var ProjectID = $('select#CboRevProject option:selected').val();
            var WeekNumber = $('select#CboRevWeek option:selected').val();
            ProjectRevenueRecognition('line', Year, Month, ProjectID, WeekNumber, flag)

        }

        $("#linerev").click(function () {
            //debugger;
            var Year = $('select#CboRevYear option:selected').val();
            var Month = $('select#CboRevMonth option:selected').val();
            var ProjectID = $('select#CboRevProject option:selected').val();
            var WeekNumber = $('select#CboRevWeek option:selected').val();
            ProjectRevenueRecognition('line', Year, Month, ProjectID, WeekNumber, flag)
            //$('html, body').animate({ scrollTop: $("#RevRecognition").offset().top }, 100);
        });

        $("#barrev").click(function () {
            var Year = $('select#CboRevYear option:selected').val();
            var Month = $('select#CboRevMonth option:selected').val();
            var ProjectID = $('select#CboRevProject option:selected').val();
            var WeekNumber = $('select#CboRevWeek option:selected').val();
            ProjectRevenueRecognition('bar', Year, Month, ProjectID, WeekNumber, flag)
            //$('html, body').animate({ scrollTop: $("#RevRecognition").offset().top }, 100);
        });

       function CboRevYear_OnChange() {

           // debugger;
            var Year = $('select#CboRevYear option:selected').val();
             GetSelectValueRevMonth(Year);
        }

        function GetSelectValueRevMonth(Year) {
            //debugger;
            dashboardParameters = {
                cboType: 'Month',
                intYear: Year
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBoxRev',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("CboRevMonth");
                    $("#CboRevMonth option").remove();
                     $("#CboRevWeek option").remove();
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                        //debugger;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjDashBoard.CboName;
                        objOption.value = ObjDashBoard.CboID;
                    }
           // ResourceUtilizedCustomer('bar', 'line', Year,Month, $('select#CboWeek option:selected').val(),CustomerID, flag);
                    GetSelectValueRevWeek(Year, $('select#CboRevMonth option:selected').val())
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function CboRevMonth_OnChange()
        {
            //debugger;
            var Year = $('select#CboRevYear option:selected').val();
            var Month = $('select#CboRevMonth option:selected').val();
            GetSelectValueRevWeek(Year, Month);
        }
        function GetSelectValueRevWeek(Year, Month) {
            //debugger;
            var ProjectID = $('select#CboRevProject option:selected').val();

            dashboardParameters = {
                cboType: 'Week',
                intYear: Year,
                intMonth: Month
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBoxRev',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("CboRevWeek");
                    $("#CboRevWeek option").remove();
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                       // debugger;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjDashBoard.CboName;
                        objOption.value = ObjDashBoard.CboID;
                    }
                    ProjectRevenueRecognition('line', Year, Month, ProjectID, $('select#CboRevWeek option:selected').val(), flag);
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }



	//Revenue Realisation end



    </script>

    <script>
        //Billability start
        var SkillID = 0;
        var myBarChart2;
        var arrSkill = [];
        var arrWeek = [];
        var arrMonth = [];
        var arrCost = [];
        var arrLostBillability = [];
        function ResourceUtilizedSkill_SurPlus(newType, Year, Month, Week, SkillID, flag) {
            //debugger;
            if (Year == '') {
                Year = document.getElementById("CboSYear").value;
                Month = document.getElementById("CboSMonth").value;
                Week = document.getElementById("CboSWeek").value;
                SkillID = document.getElementById("CboSkill").value;
                arrSkill = [];
                arrWeek = [];
                arrMonth = [];
                arrCost = [];
                arrLostBillability = [];
            }
            else {
                Year = Year;
                Month = Month;
                Week = Week;
                SkillID = SkillID;
                arrSkill = [];
                arrWeek = [];
                arrMonth = [];
                arrCost = [];
                arrLostBillability = [];
            }
            var DashBoardParameter = {
                intYear: Year,
                intMonth: Month,
                intWeek: Week,
                intSkillID: SkillID,
                Flag: flag
            }

            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetResourceUtilizationSkill_Short_Surplus',
                type: "POST",
                data: JSON.stringify(DashBoardParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (DashBoardParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DashBoardParameter) ? DashBoardParameter : JSON.stringify(DashBoardParameter)));
                    }
                },

                success: function (response) {
                    //debugger;
                    //alert(response);
                    if (response.DashboardSurplusLists != '') {                       
                        for (var i = 0; i < response.DashboardSurplusLists.length; i++) {
                            // debugger;
                            var ObjDashBoard = response.DashboardSurplusLists[i];
                            var SkillName = ObjDashBoard.SkillName;
                            if (flag == "week") {
                                var Week = ObjDashBoard.WeekNumber;
                                var WeekSkillName = SkillName + "\n" + "Week-" + Week;
                            }
                            else {
                                var Monthname = ObjDashBoard.MonthName;
                                var WeekSkillName = SkillName + "\n" + Monthname;

                            }
                            var SumCost = ObjDashBoard.SumofCost;
                            var LostBillability = ObjDashBoard.SumofLostBillability

                            arrSkill.push(SkillName);
                            arrWeek.push(WeekSkillName);
                            arrMonth.push(Month);
                            arrCost.push(SumCost.toFixed(2));
                            arrLostBillability.push(LostBillability.toFixed(2));
                        }

                       
                        //alert(arrSkill);

                        var color = Chart.helpers.color;
                        var barChartData = {
                            type: newType,
                            data: {
                                labels: arrWeek,
                                datasets: [{
                                    label: 'Sum of Cost',
                                    backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
                                    borderColor: window.chartColors.red,
                                    borderWidth: 1,
                                    fill: false,
                                    data: arrCost
                                }, {
                                    label: 'Sum of Lost Billability',
                                    backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
                                    borderColor: window.chartColors.blue,
                                    borderWidth: 1,
                                    fill: false,
                                    data: arrLostBillability
                                }]
                            },
                            options: {
                                scales: {
                                    xAxes: [{
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90
                                        },
                                        barPercentage: 0.2
                                    }],
                                    yAxes: [{
                                        type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                        display: true,
                                        position: "left",
                                        id: "y-axis-1",
                                        scaleLabel: {
                                            display: true,
                                            labelString: 'Sum of Cost /Sum of Lost Billability'
                                        }
                                        //Added By Usha Pandit On 25.07.2019 For now showing negative values on Y-axis
                                        //,
                                        //ticks: {
                                        //    beginAtZero: true
                                        //}
                                        //End Of Added By Usha Pandit On 25.07.2019 For now showing negative values on Y-axis
                                    }],
                                },
                                responsive: true,
                                legend: {
                                    position: 'top',
                                },
                                title: {
                                    display: true,
                                    text: 'Staffing -Short /Surplus (Cost Billability) '
                                }
                            },
                            plugins: [{
                                beforeInit: function (myBarChart2) {
                                    myBarChart2.data.labels.forEach(function (e, i, a) {
                                        if (/\n/.test(e)) {
                                            a[i] = e.split(/\n/);
                                        }
                                    });
                                }
                            }]
                        };

                        var ctx2 = document.getElementById('billability').getContext('2d');

                        // Remove the old chart and all its event handles
                        if (myBarChart2) {
                            myBarChart2.destroy();
                        }

                        //// Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
                        var temp = jQuery.extend(true, {}, barChartData);
                        temp.type = newType;
                        myBarChart2 = new Chart(ctx2, temp);
                         $("#lblbillability").text("");
                    }
                    else {
                        //document.getElementById("mixedChart").value="Snapshot data not available"

                        //var canvas = document.getElementById("billability");
                        //var ctx = canvas.getContext("2d");
                        //ctx.font = "16px Arial";
                        //ctx.fillText("Snapshot data not available", 10, 16);

                        $("#lblbillability").text("Snapshot data not available");
                        if (myBarChart2) {
                            myBarChart2.destroy();
                        }

                    }


                },
                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }

            })

        }

        function CboSurSkillWeek_OnChange() {
            // debugger;
            var Year = $('select#CboSurYear option:selected').val();
            var Month = $('select#CboSurMonth option:selected').val();
            var Week = $('select#CboSurWeek option:selected').val();
            var SkillID = $('select#CboSurSkill option:selected').val();
            ResourceUtilizedSkill_SurPlus('bar', Year, Month, Week, SkillID, flag);
        }

        $("#linesur").click(function () {
            var Year = $('select#CboSurYear option:selected').val();
            var Month = $('select#CboSurMonth option:selected').val();
            var Week = $('select#CboSurWeek option:selected').val();
            var SkillID = $('select#CboSurSkill option:selected').val();
            ResourceUtilizedSkill_SurPlus('line', Year, Month, Week, SkillID, flag);
            //$('html, body').animate({ scrollTop: $("#divbillability").offset().top }, 10);

        });

        $("#barsur").click(function () {
            var Year = $('select#CboSurYear option:selected').val();
            var Month = $('select#CboSurMonth option:selected').val();
            var Week = $('select#CboSurWeek option:selected').val();
            var SkillID = $('select#CboSurSkill option:selected').val();
            ResourceUtilizedSkill_SurPlus('bar', Year, Month, Week, SkillID, flag);
            //$('html, body').animate({ scrollTop: $("#divbillability").offset().top }, 10);

        });

        function CboSurYear_OnChange() {

           // debugger;
            var Year = $('select#CboSurYear option:selected').val();
             GetSelectValueSurMonth(Year);
        }

        function GetSelectValueSurMonth(Year) {
            //debugger;
            dashboardParameters = {
                cboType: 'Month',
                intYear: Year
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBoxSkill',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("CboSurMonth");
                    $("#CboSurMonth option").remove();
                     $("#CboSurWeek option").remove();
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                        //debugger;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjDashBoard.CboName;
                        objOption.value = ObjDashBoard.CboID;
                    }
           // ResourceUtilizedCustomer('bar', 'line', Year,Month, $('select#CboWeek option:selected').val(),CustomerID, flag);
                    GetSelectValueSurWeek(Year, $('select#CboRevMonth option:selected').val())
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function CboSurMonth_OnChange()
        {
            //debugger;
            var Year = $('select#CboSurYear option:selected').val();
            var Month = $('select#CboSurMonth option:selected').val();
            GetSelectValueSurWeek(Year, Month);
        }
        function GetSelectValueSurWeek(Year, Month) {
            //debugger;
            var SkillID = $('select#CboSurSkill option:selected').val();

            dashboardParameters = {
                cboType: 'Week',
                intYear: Year,
                intMonth: Month
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBoxSkill',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("CboSurWeek");
                    $("#CboSurWeek option").remove();
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                       // debugger;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjDashBoard.CboName;
                        objOption.value = ObjDashBoard.CboID;
                    }
                    
             ResourceUtilizedSkill_SurPlus('bar', Year, Month, $('select#CboSurWeek option:selected').val(), SkillID, flag);

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }


//Billability end

    </script>

    <script>	
        //Milestone_revenue_forcast

        var myBarChart3;
        var strMonth = "";
        var Quarter = "";
        var Week = "";
        var arrMonthName = [];
        var arrMonthMileStone = [];
        var arrCommercialValue = [];

        function ProjectRevenueMilestone(newType, lineType, Year, Quarter, strMonth, Week, flag) {
           // debugger;
            if (Year == '') {
                Year = document.getElementById("CboMileYear").value;
                Quarter = document.getElementById("CboMileQuarter").value;
                if (Quarter == '--Select Quarter--') {
                    Quarter = 0;
                }
                strMonth = document.getElementById("CboMileMonth").value;
                if (strMonth == '--Select Month--') {
                    strMonth = 0;
                }
                //added By Dipali V On 7th May 2019 For Easi Upgrade
                else if (strMonth == "") {
                    strMonth = 0;
                }
                //End of added By Dipali V On 7th May 2019 For Easi Upgrade
                arrMonthName = [];
                arrMonthMileStone = [];
                arrCommercialValue = [];

            }
            else {
                Year = Year;
                if (Quarter == '--Select Quarter--') {
                    Quarter = 0;
                }
                Quarter = Quarter;
                if (strMonth == '--Select Month--') {
                    strMonth = 0;
                }
               //added By Dipali V On 7th May 2019 For Easi Upgrade
                else if (strMonth == "") {
                    strMonth = 0;
                }
                //End of added By Dipali V On 7th May 2019 For Easi Upgrade
                strMonth = strMonth;
                Week = Week;
                arrMonthName = [];
                arrMonthMileStone = [];
                arrCommercialValue = [];
            }

            //Week = document.getElementById("CboMileWeek").value;

            var DashBoardParameter = {
                intYear: Year,
                Quarter: Quarter,
                strMonth: strMonth,
                intWeek: Week,
                Flag: flag
            }

            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetProjectRevenue_Projection',
                type: "POST",
                data: JSON.stringify(DashBoardParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (DashBoardParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DashBoardParameter) ? DashBoardParameter : JSON.stringify(DashBoardParameter)));
                    }
                },

                success: function (response) {
                    //debugger;
                    //alert(response);
                    if (response.DashboardProjectRevenueLists != '') {
                        for (var i = 0; i < response.DashboardProjectRevenueLists.length; i++) {
                           // debugger;
                            var ObjDashBoard = response.DashboardProjectRevenueLists[i];
                            
                            if (flag == 'week') {
                                var CountMilestone = ObjDashBoard.CountQuarterMilestone;
                                var CommercialValue = ObjDashBoard.Commercial_Value;
                                var Quarter = ObjDashBoard.Quarter;
                                 arrMonthName.push(Quarter);

                            }
                            else {
                                var CountMilestone = ObjDashBoard.CountMonthMileStone;
                                var CommercialValue = ObjDashBoard.Commercial_Value;
                                var MonthName = ObjDashBoard.MonthName;
                                arrMonthName.push(MonthName);
                            }
                            var Week = ObjDashBoard.WeekNumber;
                            //+ "\n" + "Week-" + Week

                            
                            arrMonthMileStone.push(CountMilestone);
                            arrCommercialValue.push(CommercialValue);
                        }
                        //alert(arrMonthMileStone);

                        var MilestoneChartData = {
                            type: newType,
                            data: {
                                labels: arrMonthName,
                                datasets: [{
                                    type: lineType,
                                    label: 'Sum of Commercial Value',
                                    borderColor: 'rgba(175,208,55,1)',
                                    borderWidth: 2,
                                    fill: false,
                                    data: arrCommercialValue,
                                    yAxisID: "y-axis-1",
                                }, {

                                    type: newType,
                                    label: "No. of Milestone",
                                    backgroundColor: '#fbb03b',
                                    data: arrMonthMileStone,
                                    //borderColor: 'white',
                                    borderColor: '#fbb03b',
                                    borderWidth: 2,
                                    fill: false,
                                    yAxisID: "y-axis-2",
                                }]
                            },
                            options: {
                                responsive: true,
                                legend: {
                                    position: 'top',
                                },
                                title: {
                                    display: true,
                                    text: 'Project Revenue Projection'
                                },
                                scales: {
                                    xAxes: [{
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 90,
                                            minRotation: 90
                                        },
                                        barPercentage: 0.2
                                    }],
                                    yAxes: [{
                                        type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                        display: true,
                                        position: "left",
                                        id: "y-axis-1",
                                        scaleLabel: {
                                            display: true,
                                            labelString: 'Commercial Value'
                                        }
                                    }, {
                                        type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                                        display: true,
                                        position: "right",
                                        id: "y-axis-2",
                                        scaleLabel: {
                                            display: true,
                                            labelString: 'No of Milestone'
                                        }
                                    }],
                                }
                            },
                            plugins: [{
                                beforeInit: function (myBarChart2) {
                                    myBarChart2.data.labels.forEach(function (e, i, a) {
                                        if (/\n/.test(e)) {
                                            a[i] = e.split(/\n/);
                                        }
                                    });
                                }
                            }]
                        };

                        var ctx3 = document.getElementById('revenuemilestonechart').getContext('2d');

                        // Remove the old chart and all its event handles
                        if (myBarChart3) {
                            myBarChart3.destroy();
                        }

                        //// Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
                        var temp = jQuery.extend(true, {}, MilestoneChartData);
                        temp.type = newType;
                        myBarChart3 = new Chart(ctx3, temp);

                        $("#lblrevenuemilestonechart").text("");
                    }
                    else {
                        //var canvas = document.getElementById("revenuemilestonechart");
                        //var ctx = canvas.getContext("2d");
                        //ctx.font = "16px Arial";
                        //ctx.fillText("Snapshot data not available", 10, 16);
                       //  $("#lblrevenuemilestonechart").text("Snapshot data not available");
                        if (myBarChart2) {
                            myBarChart2.destroy();
                        }

                        
                    }
                },
                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }

            })

        }

        function CboMilestone_OnChange() {
            //debugger;
            var Year = $('select#CboMileYear option:selected').val();
            var Quarter = $('select#CboMileQuarter option:selected').val();
            var Month = $('select#CboMileMonth option:selected').val();
            var Week = $('select#CboMileWeek option:selected').val();
            ProjectRevenueMilestone('bar', 'line', Year, Quarter, Month, Week, flag);

        }

        $("#linemile").click(function () {
            //debugger;
            var Year = $('select#CboMileYear option:selected').val();
            var Quarter = $('select#CboMileQuarter option:selected').val();
            var Month = $('select#CboMileMonth option:selected').val();
            var Week = $('select#CboMileWeek option:selected').val();

            ProjectRevenueMilestone('line', 'line', Year, Quarter, Month, Week, flag);
           // $('html, body').animate({ scrollTop: $("#divmilestone").offset().top }, 100);
        });

        $("#barmile").click(function () {
            var Year = $('select#CboMileYear option:selected').val();
            var Quarter = $('select#CboMileQuarter option:selected').val();
            var Month = $('select#CboMileMonth option:selected').val();
            var Week = $('select#CboMileWeek option:selected').val();

            ProjectRevenueMilestone('bar', 'bar', Year, Quarter, Month, Week, flag);
           // $('html, body').animate({ scrollTop: $("#divmilestone").offset().top }, 100);
        });

        $("#barlinemile").click(function () {
            var Year = $('select#CboMileYear option:selected').val();
            var Quarter = $('select#CboMileQuarter option:selected').val();
            var Month = $('select#CboMileMonth option:selected').val();
            var Week = $('select#CboMileWeek option:selected').val();

            ProjectRevenueMilestone('bar', 'line', Year, Quarter, Month, Week, flag);
            //$('html, body').animate({ scrollTop: $("#divmilestone").offset().top }, 100);

        });


          function CboMileYear_OnChange() {

           // debugger;
            var Year = $('select#CboMileYear option:selected').val();
             GetSelectValueMileQuarter(Year);
        }

        function GetSelectValueMileQuarter(Year) {
            //debugger;
            dashboardParameters = {
                cboType: 'Quarter',
                intYear: Year
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBoxMile',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("CboMileQuarter");
                    $("#CboMileQuarter option").remove();
                    $("#CboMileMonth option").remove();            
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                        //debugger;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjDashBoard.CboName;
                        objOption.value = ObjDashBoard.CboID;
                    }
           // ResourceUtilizedCustomer('bar', 'line', Year,Month, $('select#CboWeek option:selected').val(),CustomerID, flag);
                    GetSelectValueMileMonth(Year, $('select#CboMileQuarter option:selected').val())
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function CboMileQuarter_OnChange()
        {
            //debugger;
            var Year = $('select#CboMileYear option:selected').val();
            var Quarter = $('select#CboMileQuarter option:selected').val();
            GetSelectValueMileMonth(Year, Quarter);
        }
        function GetSelectValueMileMonth(Year,Quarter) {
           // debugger;
  
            dashboardParameters = {
                cboType: 'Month',
                intYear: Year,
                Quarter: Quarter
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBoxMile',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("CboMileMonth");
                    $("#CboMileMonth option").remove();
                    $("#CboMileWeek option").remove();
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                       // debugger;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjDashBoard.CboName;
                        objOption.value = ObjDashBoard.CboID;
                    } 
                    GetSelectValueMileWeek(Year, Quarter, $('select#CboMileMonth option:selected').val());
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function CboMileMonth_OnChange() {
          // debugger;
            var Year = $('select#CboMileYear option:selected').val();
            var Quarter = $('select#CboMileQuarter option:selected').val();
            var  Month = $('select#CboMileMonth option:selected').val();
            GetSelectValueMileWeek(Year, Quarter,Month);
        }
         function GetSelectValueMileWeek(Year,Quarter,Month) {
           //debugger;
            dashboardParameters = {
                cboType: 'Week',
                intYear: Year,
                Quarter: Quarter,
                intMonth:Month
            }
            $.ajax({
                url: strUrl + '/api/DashBoardInfo/GetDependent_ComboBoxMile',
                type: "POST",
                data: JSON.stringify(dashboardParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (dashboardParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(dashboardParameters) ? dashboardParameters : JSON.stringify(dashboardParameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("CboMileWeek");
                    $("#CboMileWeek option").remove();
                    for (var i = 0; i < data.objDependent_ComboBox.length; i++) {
                    //debugger;
                        var ObjDashBoard = data.objDependent_ComboBox[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjDashBoard.CboName;
                        objOption.value = ObjDashBoard.CboID;
                    } 
                    ProjectRevenueMilestone('bar', 'line', $('select#CboMileYear option:selected').val(), $('select#CboMileQuarter option:selected').val(), $('select#CboMileMonth option:selected').val(), $('select#CboMileWeek option:selected').val(), flag);
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

//Milestone revenue forcast end			
    </script>

    <!--chart js-->
    <!-- ChartJS 1.0.1 -->

</body>

</html>
