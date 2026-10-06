<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectResourceUtilization.aspx.vb" Inherits="PbNIT.ProjectResourceUtilization" %>

<!DOCTYPE html>
<html>
     <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("Project")%>
<head>
  <%--  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/jquery-ui.css?v=2">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap.min.css?v=1">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap-select.css?v=2">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0/fontawesome/css/all.css?v=2">--%>
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/AdminLTE.min.css?v=2">
    <!-- animate css -->
<%--    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/animate.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/dataTables.bootstrap.min.css?v=0">--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom_project.css?v=3.1">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/adavanced_filter.css?v=0.1">



</head>
        <style type="text/css">
.dataTables_scrollBody thead tr[role="row"] {visibility: collapse !important;}
a.clearalllink {font-weight: bold;margin: 7px 0px 0 8px;display: none;}
.filter.pull-right { margin: 2px 0 0 8px;}
table tr th{ vertical-align:middle!important;}
table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before{ margin-right:0;}
  .notebox {padding: 10px;margin-bottom: 10px;border-radius: 4px;}

.dropdown-submenu .dropdown-submenu > a:after {border-color: transparent transparent transparent #fff;    border-style: solid;border-width: 5px 0 5px 5px;content: " ";display: block;float: right;height: 0;    margin-right: 10px;margin-top: 5px;width: 0;}
.dropdown-submenu>.dropdown-submenu:hover a:after{border-color: transparent transparent transparent #464a4c;}

/*Detailpanel*/
.Resourcedetailpanel{ margin:40px 15px 0; display:none; border:1px solid #ddd; border-radius:4px;}
.pgdetailinner{ padding:10px;}
.Resourcedetailpanel .tab-pane {padding: 20px 0;}
tr.rowhiglight{ background:#c3dbff;}

.DisableContent{ pointer-events:none; opacity:0.5;}
.DisableContent:hover{ cursor:no-drop;}
.dataTables_scrollBody.DisableContent{ height:auto!important}
ul.nav.nav-tabs.detailsubtabs {background: #f5f5f5;margin: -11px -11px;padding: 10px 10px 0;border: 1px solid #ddd;border-radius: 4px 4px 0 0;}
.nav.detailsubtabs>li>a:hover, .nav.nav.detailsubtabs>li>a:active, .nav.nav.detailsubtabs>li>a:focus{ background:#fff; color:#1359ac;}

h5.pgtitle {
    margin: 6px 0 0;
    font-weight: 700;
    color: #4263c1;
    font-size: 16px;
}
.dblock{ display:block;}



/*New css end here*/
    
        .lightgraybg {background: #f5f5f5;}

        /*Information table start here*/
.informationtbl{margin-bottom:15px}
.informationtbl tr th{text-align:right;font-weight:500}
body .informationtbl tr td{text-align:left}
.informationtbl th,.informationtbl td{padding:2px 4px}
body .informationtbl tr td.pr-3{padding-right:3em}
table.informationtbl{width:100%}
td.Agpm{color:#eb1c24}
.togglerup .collapseup{display:block}
.togglerup .collapsedown{display:none}
.togglerdown .collapsedown{display:block}
.togglerdown .collapseup{display:none}
.infoToggler{margin:5px 0 0}
.hideprofitabilityinfo{position:absolute;right:10px}
.profitabilityinfopanel .panel.panel-default{padding:0;position:relative}
.profitabilityinfopanel .panel-default > .panel-heading{padding-right:35px;background:#e7edf0}
.profitabilityinfopanel .panel-default > .panel-heading a:hover,.profitabilityinfopanel .panel-default > .panel-heading a:focus{color:#464a4c}
.profitabilityinfopanel .panel-default > .panel-heading a span img{opacity:.5}
.profitabilityinfopanel .panel-default > .panel-heading a span img:hover{opacity:1}
        /*Information table End here*/
        .informationtbl td,.informationtbl th{vertical-align:top!important;font-size:14px;line-height:normal}
.informationtbl tr th{min-width:120px}
tr.totalrow{background:#ccc}

.innerpgsection{clear:both;display:flex}
.innerpagemenu{width:55px;height:100vh;min-height:100%;background:#f7f7f7;position:relative;z-index:9}
.innersecRight{width:96%;height:100vh}

/* ScrolBar  */
.scrollbar{height:90%;width:100%;overflow-y:hidden;overflow-x:hidden}
.scrollbar:hover{height:90%;width:100%;overflow-y:scroll;overflow-x:hidden}

/* Scrollbar Style */

#style-1::-webkit-scrollbar-track{border-radius:2px}
#style-1::-webkit-scrollbar{width:5px;background-color:#F7F7F7}
#style-1::-webkit-scrollbar-thumb{border-radius:10px;-webkit-box-shadow:inset 0 0 6px rgba(0,0,0,.3);background-color:#BFBFBF}
/* Scrollbar End */

.main-menu .fa-lg{font-size:1em}
.main-menu .fa{position:relative;display:table-cell;width:55px;height:36px;text-align:center;top:12px;font-size:20px}
.main-menu:hover,nav.main-menu.expanded{width:260px;overflow:hidden;opacity:1}
.main-menu{background:#F7F7F7;position:absolute;top:0;bottom:0;height:100%;left:0;width:55px;overflow:hidden;border-right:1px solid #eee;opacity:1}
.main-menu > ul{margin:7px 0;padding:0}
.main-menu ul{padding:0}
.main-menu li{position:relative;display:block;width:250px}
.main-menu li > a{position:relative; height: 4em;width:255px;display:table;border-collapse:collapse;border-spacing:0;color:#8a8a8a;font-size:13px;text-decoration:none;-webkit-transform:translateZ(0) scale(1,1);-webkit-transition:all .14s linear;transition:all .14s linear;font-family:'Strait',sans-serif;border-top:1px solid #f2f2f2}
.main-menu .nav-icon{position:relative;display:table-cell;width:55px;height:36px;text-align:center;vertical-align:middle;font-size:18px}
.main-menu .nav-text{position:relative;display:table-cell;vertical-align:middle;width:190px}
.no-touch .scrollable.hover{overflow-y:hidden}
.no-touch .scrollable.hover:hover{overflow-y:auto;overflow:visible}
.main-menu li > a img {
    position: absolute;
    top: 12px;
    margin: auto;
    left: 10px;
    bottom: auto;
}
.main-menu li > a:hover img, .main-menu li.active > a img{ filter:invert(1);}

/*Hover Property */
.main-menu li:hover > a,nav.main-menu li.active > a,.dropdown-menu > li > a:hover,.dropdown-menu > li > a:focus,.dropdown-menu > .active > a,.dropdown-menu > .active > a:hover,.dropdown-menu > .active > a:focus,.no-touch .dashboard-page nav.dashboard-menu ul li:hover a,.dashboard-page nav.dashboard-menu ul li.active a{color:#fff;background-color:#4263c1}
.main-menu li a.active{background:#4263c1;color:#fff}
.area{float:left;background:#e2e2e2;width:100%;height:100%}
table.calviewTbl thead tr th.holiday, table.calviewTbl tbody tr td.holiday {
    background: #eeeeee;
}
/*legends*/
.legend { 
  background: #fff;
  background: rgba(255, 255, 255, 0.8); 
  padding:5px 0 0;
  border:none;
  /*border-top:1px solid #ddd;
  border-bottom:1px solid #ddd;*/
}
.legend ul {
  list-style-type: none;
  margin: 0;
  padding: 0; overflow:hidden;
}
.legend li {float:left; margin-left:10px; }
.legend li:first-child{ margin-left:0;}
.legend span {
  display: inline-block;
  width: 12px;
  height: 12px;
  margin-right: 6px;
}
.bgred{ background:#eb1c24;}
.bgyellow{ background:#f4cd0f;}
.bgblue{ background:#135a9c;}
.bggreen{ background:#9dd824;}
.bgpurple{ background:purple;}
.bgorange{ background:#fbb03b;}
.bggray{ background:#ccc;}
/*end legends*/
.dropdown-menu>li>a:hover {
    background-color: #e1e3e9;
    color: #333;
}
.table-fixed-header thead tr th, .table thead tr th{ padding-top:6px; padding-bottom:6px;}
.calviewTbl tr th:first-child{ min-width:200px;}
.modal-body{ padding:30px!important;}
.mb-1{ margin-bottom:10px;}
ul.dropdownlinks li:hover a, ul.dropdownlinks li a {padding: 5px 10px;}
span.checkmark {color: #9dd824;}

/*newcss*/
.pt-1.pb-1.borderbox {
    border: 1px solid #ddd;
    border-radius: 4px;
}
.RUReportGraph {
    background: #f7f7f7;
    border: 1px solid #ddd;
    padding: 10px;
}
.filterpanelbody > .row > div:nth-child(5n), .filterpanelbody > .row > div:nth-child(6n), .filterpanelbody > .row > div:nth-child(7n){ width:50%;}
.blnktd{ border:none!important;}
.notebox{ border:1px solid #ddd; border-radius:4px; padding:10px;}    
.notebox ul{ margin:0; padding:0;}
.notebox ul li {list-style-type: square;margin-left: 20px;font-size: 12px;}
.Divsubpages{ margin-bottom:0;}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed">

    <div class="bgwhite">

        <div class="col-sm-12 pt-1 pb-1 mb-1 text-right graybg">
            <h5 class="pgtitle text-left pull-left">Resource Utilization</h5>
            <a href="javascript:;" class="clearalllink" style="display:none;" onclick="clearAll" id="PMProjectReviewClearAllFilter" data-toggle="tooltip" data-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline pull-right">
                <button data-toggle="collapse" data-target="#filterpanel" data-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter" autocomplete="off"><i class="fas fa-filter" style="font-size:15px;"></i></button>
            </div>
        </div>

       
            
            <div class="innerpgiframe">
                <!--filter panel-->
                <div id="filterpanel" class="filterpanel collapse">
                    <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                        <div class="cust_tabpanel">
                            <ul class="nav nav-tabs">                                
                                <li class="">
                                    <a href="#basicfilters" data-toggle="tab" aria-expanded="true">Basic Filters</a>
                                </li>
                            </ul>
                        </div>
                        <div class="Fwrapper">
                            <div class="tab-content">
                                <div id="basicfilters" class="tab-pane">
                                    <div class="filterpanelbody">                                       
                                        <br />
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Business Group</label>
                                                <div class="col-sm-8">
                                                    <div class="row">                                                       
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboBG", "Select 1 ",,, "class='form-control'  onChange='cboBG_OnChange(this.value)' ", False,, )%> 
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Organization Unit</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                             <% CommonFunctions.HTMLControls.DrawComboBox("cboOU", "Select 1 ",,, "class='form-control'  onChange='cboOU_OnChange(this.value)' ", False,, )%> 
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Delivery Unit</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                             <% CommonFunctions.HTMLControls.DrawComboBox("cboDU", "Select 1 ",,, "class='form-control'  onChange='cboDU_OnChange(this.value)' ", False,, )%> 
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Resource</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                              <% CommonFunctions.HTMLControls.DrawComboBox("cboEmp", "Select 1 ",,, "class='form-control'  onChange='cboEmp_OnChange(this.value)' ", False,, )%> 
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Period</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                              <% CommonFunctions.HTMLControls.DrawComboBox("cboPeriod", "Select 1 ",,, "class='form-control'  onChange='cboPeriod_OnChange(this.value)' ", False,, )%> 
                                                        
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Department</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                              <% CommonFunctions.HTMLControls.DrawComboBox("cboDept", "Select 1 ",,, "class='form-control'  onChange='cboDept_OnChange(this.value)' ", False,, )%> 
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Deployable</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                             <% CommonFunctions.HTMLControls.DrawComboBox("cboDeployable", "Select 0 As 'Order', 'Select' As 'Option' Union Select 1 As 'Order', 'Yes' as 'Option' Union Select 2 as 'Order' ,'No' as 'Option'",,, "class='form-control'  onChange='cboDeployable_OnChange(this.value)' ", False,, )%> 
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Resource Pool</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                             <% CommonFunctions.HTMLControls.DrawComboBox("cboResourcePool", "Select 1 ",,, "class='form-control' ", False,, )%> 
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                        <div class="text-center mt-1">
                                                                                       
                                            <button id="btnReport"  onclick="OnclickReport();">Generate Report</button>
                                            <br />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--end filter panel-->
                <div class="clearfix"></div>
                <div class=" container-fluid pt-1 pb-1">
                    <div class="row">
                        <div class="col-sm-4 form-inline">
                            <p>Resource Utilization Report (By Resource)</p>
                        </div>

                        <div class="col-sm-8 text-right">
                            <a href="javascript:;" class="btn borderbtn" data-toggle="modal" data-target="#ProRsrsDisplaySummurymodal" OnClick="Test();">Display Summary</a>
                            <a href="javascript:;" class="btn borderbtn" data-toggle="modal" data-target="#ProRsrsDisplayDetailsmodal">Display Details</a>
                            <a href="#" class="btn borderbtn">Show Deployable</a>
                        </div>


                    </div>
                </div>

                <div class="content pt-0">
                    <hr style="margin:10px 0;" />
                    <div class="row">
                        <div class="col-sm-8">
                            <div class="RUReportGraph">
                                <canvas id="ResUtilizationChart" width="700" height="300"></canvas>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <table id="tblSel"class="table table-stripped table-bordered utlizationtbl">
                                <tbody>
                                    <tr>
                                        <th>Business Groups</th>
                                        <td>Business Group 01</td>
                                    </tr>
                                    <tr>
                                        <th>Organization Unit</th>
                                        <td>Organization Unit 01</td>
                                    </tr>
                                    <tr>
                                        <th>Delivery Unit</th>
                                        <td>Delivery Unit 01</td>
                                    </tr>
                                    <tr>
                                        <th>Resource</th>
                                        <td>John C</td>
                                    </tr>
                                    <tr>
                                        <th>Period</th>
                                        <td>Current Financial Year</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <br/>
                    <div class="notebox graybg">
                        <p><strong>Note : </strong></p>
                        <ul>
                            <li><strong>Available Hrs -</strong> These are max hours for which resources can work (excluding holiday and leave hours)</li>
                            <li><strong>Planned Hrs -</strong> These are the hours for which resources are allocated to tasks on the projects</li>
                            <li><strong>Actual Hrs -</strong> These are the actual hours for which resources have filled daily activity for the tasks on the projects</li>
                            <li><strong>Billable Hrs -</strong> These are the actual hours for which resources have filled daily activity for the tasks which are billable on the projects</li>
                            <li><strong>Bench Hrs -</strong> These are hours for which resources are not assigned to any project</li>
                        </ul>
                    </div>

                    <div class="clearfix"></div>



                </div>

            </div>
            <div class="clearfix"></div>
    

        <!-- Save filter Modal start here-->
        <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-dismiss="modal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="Issuesavrefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-right">Filter Name :</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name=""><br />
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>
                                                    <button data-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right">Cancel</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Save filter Modal End here-->
        <!-- Display Summury Modal start here-->
        <div class="modal custmodal fade" id="ProRsrsDisplaySummurymodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-dismiss="modal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Resource Utilization Report (By Resource)</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">
                        <div class="text-right">
                            <a href="javascript:;" class="btn borderbtn" data-toggle="tooltip" data-original-title="show deployable resource only">Show Deployable</a>
                            <!--<a href="javascript:;" class="btn borderbtn">Print</a>-->
                            <div class="dropdown filedownload pull-right ml-1" style="margin-top:5px;">
                                <button class="nostylebtn dropdown-toggle" data-toggle="dropdown"><i data-toggle="tooltip" data-title="Click here to Print" class="fas fa-download"></i></button>
                                <ul class="dropdown-menu">
                                    <li><a href="#"><img src="../../../Whizible2.0/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                </ul>
                            </div>
                        </div>
                        <table id="tblSummary" class="table table-bordered utlizationtbl" style="border:none;">
                            <tbody>
                                <tr>
                                    <th class="text-right">Business Groups</th>
                                    <td class="text-left">Business Group 01</td>
                                    <td class="blnktd">&nbsp;</td>
                                    <th class="text-right">Organization Unit</th>
                                    <td class="text-left">Organization Unit 01</td>
                                    <td class="blnktd">&nbsp;</td>
                                    <th class="text-right">Delivery Unit</th>
                                    <td class="text-left">Delivery Unit 01</td>
                                </tr>
                                <tr>
                                    <th class="text-right">Resource</th>
                                    <td class="text-left">John C</td>
                                    <td class="blnktd">&nbsp;</td>
                                    <th class="text-right">Period</th>
                                    <td class="text-left">Current Financial Year</td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="table-responsive">
                            <table class="table table-stripped table-bordered mb-0">
                                <thead>
                                    <tr>
                                        <th>Month</th>
                                        <th>Hrs</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                    </tr>
                                    <tr>
                                        <th>&nbsp;</th>
                                        <th>Install Capacity</th>
                                        <th colspan="2">Available</th>
                                        <th colspan="2">Planned</th>
                                        <th colspan="2">Actual</th>
                                        <th colspan="2">Billable</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                    </tr>
                                    <tr class="totalrow">
                                        <td>&nbsp;</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!--<div class="text-center"><a href="javascript:;" class="btn borderbtn">Print</a></div>-->

                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Display Summury Modal End here-->

        <!-- Display Details Modal start here-->
        <div class="modal custmodal fade" id="ProRsrsDisplayDetailsmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-dismiss="modal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5>Resource Utilization Report (By Resource)</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">
                        <div class="text-right">
                            <a href="javascript:;" class="btn borderbtn" data-toggle="tooltip" data-original-title="show deployable resource only">Show Deployable</a>
                            <div class="dropdown filedownload pull-right ml-1" style="margin-top:5px;">
                                <button class="nostylebtn dropdown-toggle" data-toggle="dropdown"><i data-toggle="tooltip" data-title="Click here to Print" class="fas fa-download"></i></button>
                                <ul class="dropdown-menu">
                                    <li><a href="#"><img src="../../../Whizible2.0/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                </ul>
                            </div>
                        </div>
                        <table class="table table-bordered utlizationtbl" style="border:none;">
                            <tbody>
                                <tr>
                                    <th class="text-right">Business Groups</th>
                                    <td class="text-left">Business Group 01</td>
                                    <td class="blnktd">&nbsp;</td>
                                    <th class="text-right">Organization Unit</th>
                                    <td class="text-left">Organization Unit 01</td>
                                    <td class="blnktd">&nbsp;</td>
                                    <th class="text-right">Delivery Unit</th>
                                    <td class="text-left">Delivery Unit 01</td>
                                </tr>
                                <tr>
                                    <th class="text-right">Resource</th>
                                    <td class="text-left">John C</td>
                                    <td class="blnktd">&nbsp;</td>
                                    <th class="text-right">Period</th>
                                    <td class="text-left">Current Financial Year</td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="table-responsive">
                            <table class="table table-stripped table-bordered mb-0">
                                <thead>
                                    <tr>
                                        <th>Month</th>
                                        <th>Resource</th>
                                        <th>Hrs</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                    </tr>
                                    <tr>
                                        <th>Apr</th>
                                        <th>&nbsp;</th>
                                        <th>Install Capacity</th>
                                        <th colspan="2">Available</th>
                                        <th colspan="2">Planned</th>
                                        <th colspan="2">Actual</th>
                                        <th colspan="2">Billable</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <th>John C</th>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <th>John C</th>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <th>John C</th>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <th>Sam D</th>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                    </tr>
                                    <tr class="totalrow">
                                        <td colspan="2">Total Work(hrs) for April</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!--<div class="text-center"><a href="javascript:;" class="btn borderbtn">Print</a></div>-->

                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Display Details Modal End here-->
        

        <div class="clearfix"></div>
    </div>

               <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
<%--    <script src="../../../Whizible2.0/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0/plugins/jQueryUI/jquery-ui.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap-select.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap.min.js"></script>

    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/dist/js/jquery.dataTables.min.js"></script>--%>

    <!--chart js-->
    <script src="../../../Whizible2.0/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0/plugins/chartjs/chartjs-plugin-datalabels.js"></script>
     <script src="../../General/CommonValidations.js?v=4"></script>
    <script>

        $("[data-toggle='tooltip'], [data-toggle='collapse'], [data-toggle='dropdown']").tooltip();

        function editPHSDetail() {
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 20
            }, 'slow');
            //used for disable grid
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
        }
        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

        });


        $(document).ready(function () {

            $(".generateBtn").hide();

        });


        //datatable
        $('#dashBillingTbl').dataTable({
            "scrollY": true,
            "scrollX": true,
            "pageLength": 10,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,

        });

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);
        $('#healthshetprojectList').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('#healthshetprojectList_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 450, "overflow-y": "auto" });

            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });




        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
            $(".generateBtn").show();
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

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


 
        $(document).ready(function () {

        });

 //End chart for Net Profitability

    </script>
     <script type = "text/javascript" >


         var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Dashboard").ToString%>';
         $(document).ready(function () {
             var s = '';
             $("#cboBG").html('');

            
             var Parameter =
             {
                 ProjectID: null
             }
             var param = JSON.stringify(Parameter);
             //alert("1");
              var Result = AJAXCallWithResult("/api/Dashboard/FillBG", param, false);
             //alert("2");
              for (var i = 0; i < Result.length; i++) {
                  var ObjRateCard = Result[i];
                  s += '<option value="' + ObjRateCard.BusinessGroupID + '">' + ObjRateCard.BusinessGroup + '</option>';
                 
              }
             $("#cboBG").html(s);


             FillData(0);
             PlotGraph();
         });
         function FillData(BGID) {
             var s = '';
           //  alert("in filldata");
             //Fill OU
             $("#cboOU").html('');
             var Parameter =
             {
                 BGID: BGID,
                 ProjectID:null
             }
             var param = JSON.stringify(Parameter);
            
            
             var Result = AJAXCallWithResult("/api/Dashboard/FillOU", param, false);
             s = '';
            // alert("Hi");
             for (var i = 0; i < Result.length; i++) {
                 var ObjRateCard = Result[i];
                 s += '<option value="' + ObjRateCard.LocationId + '">' + ObjRateCard.Location + '</option>';
             }
             $("#cboOU").html(s);
           
             //Fill DU
             var Parameter =
             {
                 LocationId: null
             }
             var param = JSON.stringify(Parameter);
             $("#cboDU").html('');
             var Result = AJAXCallWithResult("/api/Dashboard/FillDU", param, false);
             s = '';
             for (var i = 0; i < Result.length; i++) {
                 var ObjRateCard = Result[i];
                 s += '<option value="' + ObjRateCard.ResourcePoolID + '">' + ObjRateCard.ResourcePoolName + '</option>';
             }
             $("#cboDU").html(s);

             //Fill Emp
             
            
             $("#cboEmp").html('');
             var Result = AJAXCallWithResult("/api/Dashboard/FillEMP", param, false);
             s = '';
             for (var i = 0; i < Result.length; i++) {
                 var ObjRateCard = Result[i];
                 s += '<option value="' + ObjRateCard.EmployeeID + '">' + ObjRateCard.EmployeeName + '</option>';
             }
             $("#cboEmp").html(s);
             //Fill Period


             $("#cboPeriod").html('');
             var Result = AJAXCallWithResult("/api/Dashboard/FillPeriod", param, false);
             s = '';
             for (var i = 0; i < Result.length; i++) {
                 var ObjRateCard = Result[i];
                 s += '<option value="' + ObjRateCard.UniqueID + '">' + ObjRateCard.Description + '</option>';
                  
             }
             $("#cboPeriod").html(s);
             $("#cboResourcePool").html('');
             var Result = AJAXCallWithResult("/api/Dashboard/FillResourcePool", '', false);
             s = '';
             for (var i = 0; i < Result.length; i++) {
                 var ObjRateCard = Result[i];
                 s += '<option value="' + ObjRateCard.ResourcePoolID + '">' + ObjRateCard.ResourcePoolName + '</option>';

             }
             $("#cboResourcePool").html(s);
           
         }
         function cboBG_OnChange() {
             var BGID = $("#cboBG").val();
             //alert(ProjectGroupID);
             FillData(BGID);

             return;



         }
         var ajaxResult = '';
         function AJAXCallWithResult(url, param, async) {
            // alert("in Ajax");
             $.ajax({
                 url: encodeURI(strUrl) + url,
                 type: "POST",
                 data: param,
                 async: async,
                 dataType: "json",
                 contentType: "application/json;charset-utf=8",

                 beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                     if (param) {
                         xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                     }
                 },
                 success: function (data) {
                     // StopAjaxLoader("#SMMainbody");

                     ajaxResult = data;

                 },
                 error: function (err) {
                     alert(err.responseText);
                     console.log(err);
                     window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                 }
             });
             return ajaxResult;
         }
        function OnclickReport(){
             PlotGraph();
         }
         function PlotGraph() {
           //  alert("Plot the graph");
             var BGID = $("#cboBG").val();
             var OUID = $("#CboOU").val();
             var DUID = $("#cboDU").val();
             var EmpID = $("#cboEmp").val();
             var PeriodID = $("#CboPeriod").val();
             var Deployable = $("#cboDeployable").val();
             var ResourcePoolID = $("#cboResourcePool").val();
           
             var Parameter =
             {
                 BusinessGroupID: BGID,
                 LocationID: OUID,
                 strproject: null,
                 EmployeeID: EmpID,
                 DUID: DUID,
                 PeriodID: PeriodID,
                 Deployable: Deployable,
                 ResourcePoolID: ResourcePoolID,
                 UserId: '<%= Session("intUserID") %>',
             }

             $("#tblSel").html('');
             var strHTML = '<tr><th>Business Groups</th>'
             strHTML = strHTML + '<td>' + $("#cboBG option:selected").text() + '</td></tr>';

             strHTML = strHTML + ' <tr><th>Organization Unit</th>';

             strHTML = strHTML + '<td>' + $("#CboOU option:selected").text() + '</td> </tr>'

             strHTML = strHTML + ' <tr><th>Delivery Unit</th>'
             strHTML = strHTML + ' <td>' + $("#CboDU option:selected").text() + '</td></tr>'

             strHTML = strHTML + ' <tr> <th>Resource</th>'
             strHTML = strHTML + '<td>' + $("#cboEmp option:selected").text()+ '</td> </tr>'

             strHTML = strHTML + '<tr> <th>Period</th>'
             strHTML = strHTML + ' <td>' + $("#CboPeriod option:selected").text() + '</td> </tr>'
             $("#tblSel").append(strHTML);
             var myChart
             var arrMonth = [];
             var arrAvailable = [];
             var arrPlanned = [];
             var arrActual = [];
             var arrBillable = [];
             var arrBench = [];
             var arrAvailabletoBillable = [];
             var arrAvailabletoPlanned = [];
             var arrAllocationtoBillable = [];
             var param = JSON.stringify(Parameter);
             var strHTML = "";


            // alert("fill table data2");
             var Result = AJAXCallWithResult("/api/Dashboard/FillResourceUtilization", param, false);
             
            // alert("fill table data3");
             for (var i = 0; i < Result.length; i++) {
                 var ObjRateCard = Result[i];
                 var strMonth = ObjRateCard.Month;
                 var Available = ObjRateCard.AvailableHrs;
                 var Planned = ObjRateCard.PlannedHrs;
                 var Actual = ObjRateCard.ActualHrs;
                 var Billable = ObjRateCard.BillableHrs;
                 var Bench = ObjRateCard.BenchHrs;
                 var AvailabletoPlanned = ObjRateCard.AvailableToPlannedRatio ;
                 var AvailabletoBillable = ObjRateCard.AvailableToBillableRatio;
                 var AllocationtoBillable = ObjRateCard.AllocationToBillableRatio;

                
                
                 arrMonth.push(strMonth);
                 arrAvailable.push(Available.toFixed(2));
                 arrPlanned.push(Planned.toFixed(2));
                 arrBillable.push(Billable.toFixed(2));
                 arrActual.push(Actual.toFixed(2));
                 arrBench.push(Bench.toFixed(2));
                 arrAvailabletoPlanned.push(AvailabletoPlanned.toFixed(2));
                 arrAvailabletoBillable.push(AvailabletoBillable.toFixed(2));
                 arrAllocationtoBillable.push(AllocationtoBillable.toFixed(2));
             }
            // alert("Array filled")
             var config = {
                 type: "bar",
                 data: {
                     labels: arrMonth,
                     datasets: [
                         {
                             borderDash: [],
                             borderDashOffset: 0.0,
                             lineTension: 0.1,
                             label: "Available To Billable Ratio",
                             type: "line",
                             borderColor: "rgba(75,192,192,0.8)",
                             data: arrAvailabletoBillable,
                             fill: false
                         },
                         {
                             borderDash: [],
                             borderDashOffset: 0.0,
                             lineTension: 0.1,
                             label: "Available To Planned Ratio",
                             type: "line",
                             borderColor: "rgb(77,77,255,0.6)",
                             data: arrAvailabletoPlanned,
                             fill: false
                         },
                         {
                             borderDash: [],
                             borderDashOffset: 0.0,
                             lineTension: 0.1,
                             label: "Allocation To Billable Ratio",
                             type: "line",
                             borderColor: "rgb(204,204,204,0.8)",
                             data: arrAllocationtoBillable,
                             fill: false
                         },



                         {
                         label: "Availabel Hrs",
                         type: "bar",
                         backgroundColor: "#70ad45",
                         backgroundColorHover: "#87cb57",
                         data: arrAvailable,
                     }, {
                         label: "Planned Hrs",
                         type: "bar",
                         backgroundColor: "#fec200",
                         backgroundColorHover: "#fbb03b",
                         data: arrPlanned,
                     }, {
                         label: "Actual Hrs",
                         type: "bar",
                         backgroundColor: "#5a9bd3",
                         backgroundColorHover: "#A7A9AD",
                         data: arrActual,
                     }, {
                         label: "Billable Hrs",
                         type: "bar",
                         backgroundColor: "#284476",
                         backgroundColorHover: "#A7A9AD",
                         data: arrBillable,
                         },
                         {
                             label: "Bench Hrs",
                             type: "bar",
                             backgroundColor: "#ec7e31",
                             backgroundColorHover: "#A7A9AD",
                             data: arrBillable,
                         },
                         ]
                 },
                 options: {
                     bezierCurve: false,
                     legend: {
                         labels: {
                             usePointStyle: true,
                             boxWidth: 8
                         }
                     },
                     scales: {
                         xAxes: [{
                             maxBarThickness: 50,
                             barPercentage: 0.6,
                         }],
                         yAxes: [{
                             barPercentage: 0.2,
                             maxBarThickness: 20,
                             gridLines: { display: true },
                             id: 'A',
                             type: 'linear',
                             position: 'left',
                         }, {
                             barPercentage: 0.2,
                             maxBarThickness: 20,
                             id: 'B',
                             type: 'linear',
                             position: 'right',
                             gridLines: { display: true },
                             ticks: {
                                 max: 100,
                                 min: 0
                             }
                         }]
                     }


                 }
             }
             var ctx = document.getElementById("ResUtilizationChart").getContext("2d");
           //  alert("Chart");
             // Remove the old chart and all its event handles
            
             // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
             var temp = jQuery.extend(true, {}, config);
             temp.type = "bar";
             ResUtilizationChart = new Chart(ctx, temp);
         }
         function Test() {
          //   alert("in Display Summary");
             $("#tblSummary").html('');
             var strHTML = '<tbody>'
             strHTML = strHTML + '  <tr>'
             $("#tblSummary").append(strHTML);
         }
     </script>
</body>

</html>