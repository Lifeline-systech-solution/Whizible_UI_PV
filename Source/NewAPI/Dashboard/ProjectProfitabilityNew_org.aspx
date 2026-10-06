<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectProfitabilityNew_org.aspx.vb" Inherits="PbNIT.ProjectProfitabilityNew_org" %>

<!DOCTYPE html>
<html>
           <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("Resource")%>
<head>
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
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
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/animate.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/dataTables.bootstrap.min.css?v=0">

    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/whiz20_theme.css?v=3">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/adavanced_filter.css?v=0.1">
<%--    <link href="../../../Whizible2.0/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    
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
ul.statustext.hidden-xs {
    padding: 0;
}
.tblheadingrow td{ text-align:left!important; font-weight:500;}
tr.totalrow {
    background: #ccc;
    font-weight: 500;
}
.PPBGOUTbllist tr td:nth-child(2) {
    text-align: left;
}
     
        .lightgraybg {background: #f5f5f5;}

        /*Information table start here*/
        .informationtbl { margin-bottom:15px;}
        .informationtbl tr th {text-align: right;font-weight: 500;}
        body .informationtbl tr td {text-align: left;}
        .informationtbl th, .informationtbl td {padding: 2px 4px;}
        body .informationtbl tr td.pr-3 {padding-right: 3em;}       
        table.informationtbl {width: 100%;}
        td.Agpm {color: #eb1c24;}
        .togglerup .collapseup {display: block;}
        .togglerup .collapsedown{ display:none;}
        
        .togglerdown .collapsedown{ display:block;}
        .togglerdown .collapseup {display: none;}
        .infoToggler {margin: 5px 0 0;}
        .hideprofitabilityinfo{ position:absolute; right:10px;}
        .profitabilityinfopanel .panel.panel-default{padding:0px 0px 0 0; position:relative;}
.profitabilityinfopanel .panel-default > .panel-heading { padding-right:35px;background: #e7edf0;}
        .profitabilityinfopanel .panel-default > .panel-heading a:hover, .profitabilityinfopanel .panel-default > .panel-heading a:focus{ color:#464a4c;}
        .profitabilityinfopanel .panel-default > .panel-heading a span img {opacity:0.5;}
        .profitabilityinfopanel .panel-default > .panel-heading a span img:hover{opacity:1;}
        /*Information table End here*/
        .informationtbl td, .informationtbl th {
            vertical-align: top !important;
            font-size: 14px;
            line-height: normal;
        }
         /*GPM_tbl*/
        .GPMtbl tr td[align="right"] {text-align: right;}
        .GPMtbl tr td[align="left"] {text-align: left;}
        .GPMtbl tr td:nth-child(2){width:150px;}
        .table .grouprow th {background: #e7edf0;}
        .grossprofitinfo {padding: 15px;border-radius: 4px;font-weight: 500;}
        .grossprofitinfo p {margin: 0 0 5px;font-weight: bold;}
        body .informationtbl tr td.colan {
    padding: 8px 2px;
}
        tr.ttlrow {
    font-weight: bold;
}
        /*GPM_tbl*/

/*Menu style End here*/
.borderbox{ border:1px solid #ddd; margin:15px;background:#f7f7f7;}
.statustext{ padding-bottom:0;}

/*Added css by pradip on 21-01-2020*/
.accordion-toggle .collapsedown{display:block}
.accordion-toggle .collapseup{display:none}
.accordion-toggle.in .collapsedown{display:none}
.accordion-toggle.in .collapseup{display:block}
.accordion-toggle td{ font-weight:bold;}
.accordion-toggle { background:#e7edf0;}
.rowdivider td{ background:#fff;}

.positiveGPMrow td{ color:#9dd824;}
.negativeGPMrow td{ color:#eb1c24;}
.legend ul {
    display: inline-block;
    padding: 0;
    margin: 0;
    vertical-align: top;
}
.legend li:first-child {
    margin-left: 0;
}
.legend li {
    float: left;
    list-style-type: none;
}
.legend span {
    display: inline-block;
    width: 12px;
    height: 12px;
    margin-right: 6px;
    border: 1px solid #ddd;
}
.LdsPositiveGPM{ background:limegreen;}
.LdsNegativeGPM{ background:#eb1c24;}
.legend {
    display: inline-block;
}
.col-sm-3 .dropdown.filedownload {
    display: inline-block;
}
.nostylebtn {
    background: none;
    border: none;
}
.filedownload .dropdown-menu {
    left: auto;
    right: 0;
    min-width: 94px;
    max-width: 100px;
}
.filedownload .dropdown-menu li a img {
    margin-right: 10px;
}
.filedownload .dropdown-menu li a {
    text-decoration: none;
    padding: 5px 10px;
    margin: 0;
}

.Tblbox table{ margin-bottom:0;}
.custVal1.Tblbox{display:block;}


.gpmpositivelbl .fa-flag{ color:#9dd824;}
.gpmnegativelbl .fa-flag{ color:#eb1c24;}
.gpmalllbl .fa-flag{ color:#fbb03b;}
.GPMfiltr.mr-1{display:inline-block;float:right;background:transparent;padding:5px 10px;border:1px solid transparent;border-radius:5px}
.GPMfiltr:hover{background:#fff;padding:5px 10px;border:1px solid #ddd;border-radius:5px}
.GPMfiltr label{margin-bottom:0}
.custom_radio input[type="radio"]{display:none}
.custom_radio input[type="radio"] + label span{display:inline-block;width:15px;height:15px;background:transparent;vertical-align:middle;border:1px solid #464a4c;border-radius:50%;padding:2px;margin:0 3px}
.custom_radio input[type="radio"]:checked + label span{width:15px;height:15px;background:#464a4c;background-clip:content-box} 

/*added new style*/
.PPBGOUTbllist tr th {min-width: 80px;}
.Tblbox {overflow: auto;height: 54vh;}
.PPBGOUTbllist tr th:nth-child(2) { min-width: 140px;}
.PPBGOUTbllist tr th, .PPBGOUTbllist tr td {vertical-align: middle!important;}
.PPBGOUTbllist tr th:nth-child(9), .PPBGOUTbllist tr td:nth-child(9) { width: 60px; word-break: break-all;min-width: 60px;}
    </style> 

<body class="hold-transition skin-blue-light sidebar-mini fixed">

    <div class="bgwhite">

        <div class="col-sm-12 pt-1 pb-1 mb-1 text-right graybg">
            <h5 class="pgtitle pull-left">Project Profitability</h5>
            <!--<a href="javascript:;" class="clearalllink" style="" onclick="clearAll" id="PMProjectReviewClearAllFilter" data-toggle="tooltip" data-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline pull-right">
                <button data-toggle="collapse" data-target="#filterpanel" data-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div>-->
            <div class="clearfix"></div>
        </div>

      
            
            <div class="innerpgiframe">
                <!--filter panel-->
                <div id="filterpanel" class="filterpanel collapse">
                    <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                        <div class="cust_tabpanel">
                            <ul class="nav nav-tabs">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="false">My Filters  <span class="caret"></span></a>
                                    <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                        <li>
                                            <label class="customradio">
                                                <input class="myfilter_selectprocheckbox" data-toggle="tooltip" data-placement="bottom" id="project2" type="checkbox" name="project2" onchange="cbChange(this)" data-original-title="" title=""> <span data-toggle="tooltip" data-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                            </label>
                                            <label class="">
                                                <span for="project2" class="radiotextsty filtername">Project 2 and 3</span>
                                            </label>

                                            <div class="issfilter_actiondropdown">
                                                <div class="custom_chckbox_markblue">
                                                    <input id="IssueselproOne" type="checkbox" name="">
                                                    <label data-toggle="tooltip" data-container="body" data-placement="bottom" title="" for="IssueselproOne" data-original-title="Apply filter"></label>
                                                </div> <span class="edit_filter"><img src="../../../Whizible2.0/../../../Whizible2.0/dist/img/edit.svg" width="16px" data-toggle="tooltip" data-container="body" data-placement="bottom" title="" data-original-title="Edit filter"></span>
                                                <span><i data-toggle="tooltip" data-container="body" data-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                            </div>
                                        </li>
                                        <li>
                                            <label class="customradio">
                                                <input class="myfilter_selectprocheckbox" data-toggle="tooltip" data-placement="bottom" id="task" type="checkbox" name="task" onchange="cbChange(this)" data-original-title="" title=""> <span data-toggle="tooltip" data-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                            </label>
                                            <label class="">
                                                <span for="task" class="radiotextsty">Task and milestones</span>
                                            </label>

                                            <div class="issfilter_actiondropdown">
                                                <div class="custom_chckbox_markblue">
                                                    <input id="IssueselproTwo" type="checkbox" name="">
                                                    <label data-toggle="tooltip" data-container="body" data-placement="bottom" title="" for="IssueselproTwo" data-original-title="Apply filter"></label>
                                                </div> <span class="edit_filter"><img src="../../../Whizible2.0/../../../Whizible2.0/dist/img/edit.svg" width="16px" data-toggle="tooltip" data-container="body" data-placement="bottom" title="" data-original-title="Edit filter"></span>
                                                <span><i data-toggle="tooltip" data-container="body" data-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                            </div>
                                        </li>
                                        <li>
                                            <label class="customradio">
                                                <input class="myfilter_selectprocheckbox" data-toggle="tooltip" data-placement="bottom" id="groupcompany" type="checkbox" name="groupcompany" onchange="cbChange(this)" data-original-title="" title=""> <span data-toggle="tooltip" data-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                            </label>
                                            <label class="">
                                                <span for="groupcompany" class="radiotextsty">For group company</span>
                                            </label>

                                            <div class="issfilter_actiondropdown">
                                                <div class="custom_chckbox_markblue">
                                                    <input id="IssueselproThree" type="checkbox" name="">
                                                    <label data-container="body" data-toggle="tooltip" data-placement="bottom" title="" for="IssueselproThree" data-original-title="Apply filter"></label>
                                                </div> <span class="edit_filter"><img src="../../../Whizible2.0/../../../Whizible2.0/dist/img/edit.svg" width="16px" data-toggle="tooltip" data-container="body" data-placement="bottom" title="" data-original-title="Edit filter"></span>
                                                <span><i data-toggle="tooltip" data-container="body" data-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                                <li class="">
                                    <a href="#basicfilters" data-toggle="tab" aria-expanded="true">Basic Filters</a>
                                </li>


                            </ul>
                        </div>

                        <div class="Fwrapper">
                            <div class="tab-content">
                                <div id="basicfilters" class="tab-pane">
                                    <div class="filterpanelbody">
                                        <div class="text-center hidden-xs centerbtn">
                                            <button class="btn btnyellow" id="svfilterbtn" data-toggle="modal" data-target="#Issuesavefilter" data-dismiss="modal">Save and Apply</button>
                                            <button class="btn btnyellow">Apply</button>
                                        </div>
                                        <br />

                                        <div class="row">
                                            <div class="col-sm-4 form-group">
                                                <label>Parameter Group</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm">
                                                            <option>=</option>
                                                            <option><></option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>&nbsp;</option>
                                                            <option>Work Profile</option>
                                                        </select>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-sm-4 form-group">
                                                <label>Parameter Value</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm">
                                                            <option>Contains</option>
                                                            <option>End With</option>
                                                            <option>Exact Word</option>
                                                            <option>Not Contains</option>
                                                            <option>Start With</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <input class="form-control input-sm" type="text" id="Fparavalue" />
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-sm-4 form-group">
                                                <label>Order Number</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm">
                                                            <option>=</option>
                                                            <option><=</option>
                                                            <option><></option>
                                                            <option>></option>
                                                            <option>>=</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <input id="FOrdrNo" type="text" class="form-control" />
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="col-sm-4 form-group">
                                                <label>Description</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm">
                                                            <option>Contains</option>
                                                            <option>End With</option>
                                                            <option>Exact Word</option>
                                                            <option>Not Contains</option>
                                                            <option>Start With</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <textarea class="form-control">&nbsp;</textarea>
                                                    </div>

                                                </div>
                                            </div>

                                        </div>

                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
                <!--end filter panel-->
               
                <div class="clearfix"></div>
                <div class=" container-fluid pt-1 pb-1 borderbox">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="proprofitabilityFltr">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label for="email" class="pr-0">Project Group : </label>
                                        
                                             <% CommonFunctions.HTMLControls.DrawComboBox("CboProjectgroup", "Select 1 ",,, "class='form-control'  onChange='CboProjectgroup_OnChange(this.value)' ",, False,, )%> 
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="email" class="pr-0">Project : </label>
                                           <%-- <select id="" class="form-control input-sm">
                                                <option>Select Project</option>
                                                <option>Timesheet</option>
                                                <option>Whizible</option>
                                                <option>Helpdesk</option>
                                                <option>Agile</option>
                                                <option>Knowladge</option>
                                            </select>--%>
                                             <% CommonFunctions.HTMLControls.DrawComboBox("CboProject", "Select 1 ",,, "class='form-control' onChange='CboProject_OnChange(this.value)'", False,, )%> 

                                        </div>
                                        <div class="col-sm-3">
                                            <label for="email" class="">Business Group : </label>
                                           <%-- <select id="" class="form-control input-sm">
                                                <option>Select Business Group</option>
                                                <option>Business Group 01</option>
                                                <option>Business Group 02</option>
                                                <option>Business Group 03</option>
                                            </select>--%>
                                             <% CommonFunctions.HTMLControls.DrawComboBox("CboBG", "Select 1 ",,, "class='form-control' onChange='CboBG_OnChange(this.value)'", False,, )%> 
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="email" class="control-label">Organization Unit : </label>
                                           <%-- <select id="" class="form-control input-sm">
                                                <option>Select Organization Unit</option>
                                                <option>Organization Unit 01</option>
                                                <option>Organization Unit 02</option>
                                                <option>Organization Unit 03</option>
                                            </select>--%>
                                             <% CommonFunctions.HTMLControls.DrawComboBox("CboOU", "Select 1 ",,, "class='form-control' onChange='CboOU_OnChange(this.value)'", False,, )%> 
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label for="email" class="pr-0">Currency : </label>
                                            <%--<select id="" class="form-control input-sm">
                                                <option>Select Currency</option>
                                                <option>INR</option>
                                                <option>Eur</option>
                                                <option>AUD 3</option>
                                                <option>GBP</option>
                                            </select>--%>
                                            
                                             <% CommonFunctions.HTMLControls.DrawComboBox("CboCurrency", "Select 1 ",,, "class='form-control' onChange='CboCurrency_OnChange(this.value)'", False,, )%> 
                                           
                                        </div>
                                        <div class="col-sm-3 text-left">
                                            &nbsp;
                                        </div>
                                        <div class="col-sm-1 text-left">
                                        &nbsp;
                                    </div>

                                        <div class="col-sm-5 text-right">
                                            <label>&nbsp;</label><div class="clearfix"></div>
                                            <div class="dropdown filedownload pull-right" style="margin-top:5px;">
                                              <button class="nostylebtn dropdown-toggle" data-toggle="dropdown">
                                                  <i data-toggle="tooltip" data-placement="bottom" title="Click here to download" class="fas fa-download"></i></button>
                                                <ul class="dropdown-menu" id="fas-download">
                                                     <li><a href="#" onclick="DownloadReport('PDF')">
                                                         <img src="../../../Whizible2.0/dist/img/pdf.svg"  width="18px">Pdf</a></li>
                                                      <li><a href="#" onclick="DownloadReport('EXCEL')">
                                                          <img src="../../../Whizible2.0/dist/img/xls.svg" width="18px">Xlsx</a></li>
                                                    <li><a href="#" onclick="DownloadReport('XML')">
                                                         <img src="../../../Whizible2.0/dist/img/xml.svg" width="18px">Xml</a></li>
                                                       <li><a href="#" onclick="DownloadReport('TEXT')">
                                                          <img src="../../../Whizible2.0/dist/img/doc.svg" width="18px">Doc</a></li>

                                                  </ul>
                                            </div>
                                            
                                            <div class="GPMfiltr mr-1">
                                                <div class="d-inline-block">
                                                    <div class="custom_radio d-inline-block gpmpositivelbl" data-toggle="tooltip" data-title="Positive GPM" data-container="body">
                                                        <input id="GPMpositive" name="Rgroup1" value="GPM1" type="radio" onclick="handleClick(this)" >
                                                        <label for="GPMpositive"><span></span> <i class="far fa-flag"></i></label>
                                                    </div>
                                                </div>
                                                <div class="d-inline-block  ml-1">
                                                    <div class="custom_radio d-inline-block gpmnegativelbl" data-toggle="tooltip" data-title="Negative GPM" data-container="body">
                                                        <input id="GPMNegative" name="Rgroup1" value="GPM2" type="radio" onclick="handleClick(this)">
                                                        <label for="GPMNegative"><span></span> <i class="far fa-flag"></i></label>
                                                    </div>
                                                </div>
                                                <div class="d-inline-block  ml-1">
                                                    <div class="custom_radio d-inline-block gpmalllbl" data-toggle="tooltip" data-title="All GPM" data-container="body">
                                                        <input id="GPMAll" name="Rgroup1" value="GPM3" type="radio" onclick="handleClick(this)" checked="checked" >
                                                        <label for="GPMAll"><span></span> <i class="far fa-flag"></i></label>
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
                    <div>
                        <strong></strong> <span id="spancurr" class="text-right pull-right"><small>( All Figures In : Rs )</small></span>

                    </div>
                </div>
                
                <div class="content pt-0">
                    
                    <div class="custVal1 Tblbox">
                      
                        <table id="PPBGOUTbl" class="table table-bordered PPBGOUTbllist" style="width:100%;">
                            <thead>
                                <tr>
                                    <th>Business Group</th>
                                    <th>Project Name</th>
                                    <th class="">Customer</th>
                                    <th>Organization Unit</th>
                                    <th>As On Date</th>
                                    <th>Accrued Revenue</th>
                                    <th>Accrued Cost</th>
                                    <th>Accrued GPM</th>
                                    <th>Accrued GPM %</th>
                                    <th>Invoice Revenue</th>
                                </tr>
                            </thead>
                            <tbody id="tblbodyAT">
                                <%--<tr data-toggle="collapse" data-target=".STrow1" class="accordion-toggle in">
                                    <td>Grand Total</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>0.00</td>
                                    <td>2,200.00</td>
                                    <td>-2,200.00</td>
                                    <td>0.00</td>
                                    <td>0.00</td>
                                </tr>
                                <tr data-toggle="collapse" data-target=".STrow1" class="accordion-toggle in">
                                    <td class="bg-tbl-head text-left">
                                        ASIA PACIFIC <a href="javascript:;" class="nostyle collapsicon hidden-xs pull-right" data-toggle="collapse" data-target=".projecthide1">
                                            <img data-toggle="tooltip" data-placement="top" title="" src="../../../Whizible2.0/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                            <img class="collapseup" data-toggle="tooltip" data-placement="top" title="" src="../../../Whizible2.0/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                        </a>
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>0.00</td>
                                    <td>2,200.00</td>
                                    <td>-2,200.00</td>
                                    <td>0.00</td>
                                    <td>0.00</td>
                                </tr>
                                <tr class="STrow1 hiddenRow collapse in positiveGPMrow">
                                    <td></td>
                                    <td><a href="javascript:;" data-toggle="modal" data-target="#PPCGrossProfittmodal">Agile-Suntec</a></td>
                                    <td>British Telecommunication</td>
                                    <td>USA</td>
                                    <td>30 Jun 2021</td>
                                    <td>0.00</td>
                                    <td>2,200.00</td>
                                    <td>-2,200.00</td>
                                    <td>0.00</td>
                                    <td>0.00</td>
                                </tr>
                                <tr class="STrow1 hiddenRow collapse in negativeGPMrow">
                                    <td></td>
                                    <td><a href="javascript:;" data-toggle="modal" data-target="#PPCGrossProfittmodal">Whiz Project</a></td>
                                    <td>ABC Network ltd</td>
                                    <td>INDIA</td>
                                    <td>30 Jun 2021</td>
                                    <td>0.00</td>
                                    <td>2,200.00</td>
                                    <td>-2,200.00</td>
                                    <td>0.00</td>
                                    <td>0.00</td>
                                </tr>
                                <tr class="STrow1 hiddenRow collapse in negativeGPMrow">
                                    <td></td>
                                    <td><a href="javascript:;" data-toggle="modal" data-target="#PPCGrossProfittmodal">Timesheet</a></td>
                                    <td>web technologies</td>
                                    <td>Australia</td>
                                    <td>30 Jun 2021</td>
                                    <td>0.00</td>
                                    <td>2,200.00</td>
                                    <td>-2,200.00</td>
                                    <td>0.00</td>
                                    <td>0.00</td>
                                </tr>
                                <tr class="STrow1 hiddenRow collapse in positiveGPMrow">
                                    <td></td>
                                    <td><a href="javascript:;" data-toggle="modal" data-target="#PPCGrossProfittmodal">Agile-Suntec</a></td>
                                    <td>British Telecommunication</td>
                                    <td>INDIA</td>
                                    <td>30 Jun 2021</td>
                                    <td>0.00</td>
                                    <td>2,200.00</td>
                                    <td>-2,200.00</td>
                                    <td>0.00</td>
                                    <td>0.00</td>
                                </tr>--%>

                                <!--<tr class="totalrow">
        <td>Total</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>0.00</td>
        <td>2,200.00</td>
        <td>-2,200.00</td>
        <td>0.00</td>
        <td>0.00</td>
    </tr>-->
                                <tr class="rowdivider">
                                    <td colspan="10"></td>
                                </tr>

                                <tr data-toggle="collapse" data-target=".STrow2" class="accordion-toggle">
                                    <td class="bg-tbl-head text-left">
                                        Domestic Business <a href="javascript:;" class="nostyle collapsicon hidden-xs pull-right" data-toggle="collapse" data-target=".projecthide1">
                                            <img data-toggle="tooltip" data-placement="top" title="" src="../../../Whizible2.0/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                            <img class="collapseup" data-toggle="tooltip" data-placement="top" title="" src="../../../Whizible2.0/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                        </a>
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>0.00</td>
                                    <td>2,200.00</td>
                                    <td>-2,200.00</td>
                                    <td>0.00</td>
                                    <td>0.00</td>
                                </tr>
                                <tr class="STrow2 hiddenRow collapse">
                                    <td></td>
                                    <td><a href="javascript:;" data-toggle="modal" data-target="#PPCGrossProfittmodal">Agile-Suntec</a></td>
                                    <td>British Telecommunication</td>
                                    <td>INDIA</td>
                                    <td>30 Jun 2021</td>
                                    <td>0.00</td>
                                    <td>2,200.00</td>
                                    <td>-2,200.00</td>
                                    <td>0.00</td>
                                    <td>0.00</td>
                                </tr>
                                <tr class="STrow2 hiddenRow collapse">
                                    <td></td>
                                    <td><a href="javascript:;" data-toggle="modal" data-target="#PPCGrossProfittmodal">Agile-Suntec</a></td>
                                    <td>British Telecommunication</td>
                                    <td>INDIA</td>
                                    <td>30 Jun 2021</td>
                                    <td>0.00</td>
                                    <td>2,200.00</td>
                                    <td>-2,200.00</td>
                                    <td>0.00</td>
                                    <td>0.00</td>
                                </tr>
                                <!--<tr class="totalrow">
        <td>Total</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>0.00</td>
        <td>2,200.00</td>
        <td>-2,200.00</td>
        <td>0.00</td>
        <td>0.00</td>
    </tr>-->
                            </tbody>
                        </table>
                        <div class="clearfix"></div>

                    </div>


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
        <!-- Project people cost Modal start here-->
        <div class="modal custmodal fade" id="PPCGrossProfittmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-dismiss="modal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Gross Profit Margin</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">

                        <div id="TabGrossProfit" class="tab-pane">
                            <!--Information table start here-->
                            <div class="panel-group profitabilityinfopanel" id="accordion" role="tablist" aria-multiselectable="true">
                                <div class="panel panel-default panel-horizontal lightgraybg">
                                    <div class="panel-heading" role="tab" id="headingThree">
                                        <h4 class="panel-title">
                                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
                                                <span class="hideprofitabilityinfo pull-right ml-1">
                                                    <img class="" data-toggle="tooltip" data-placement="top" title="" src="dist/img/close-black.svg" alt="" width="12px" data-original-title="Close Details">
                                                </span>
                                                <span class="infoToggler togglerdown pull-right">
                                                    <img data-toggle="tooltip" data-placement="top" title="" src="dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                                    <img class="collapseup" data-toggle="tooltip" data-placement="top" title="" src="dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                                </span>
                                                Gross Profit Margin
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseThree"  role="tabpanel" aria-labelledby="headingThree">
                                        <%--class="panel-collapse collapse"--%>
                                        <div class="panel-body">
                                            <table id="tblprjdtl" class="informationtbl mb-0">
                                                <tbody>
                                                    <tr>
                                                        <th>Project Name</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3"><span class="lmtname">2013-14 - WhizibleSEM 13 Product Enhancement</span></td>


                                                        <th>Project Value</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3">Rs. 1.00</td>
                                                        
                                                    </tr>
                                                    <tr>

                                                        <th>Start Date</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3"> 29 Jul 2013</td>

                                                        <th>End Date</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3">31 Oct 2013</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Commercial Type</th>
                                                        <td class="colan">:</td>
                                                        <td>&M by Resource</td>

                                                        <th>Cost Method</th>
                                                        <td class="colan">:</td>
                                                        <td>Standard Resource Cost</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Actual Start Date</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3"> 28 Jun 2014</td>

                                                        <th>Actual End Date</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3">31 Jun 2014</td>
                                                    </tr>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--Information table End here-->

                            <div class="table-responsive">
                                <table ID="tbldtl" class="table table-bordered GPMtbl">

                                    <tr class="grouprow">
                                        <th align="left">Accrued Revenue</th>
                                        <th>Project Currency(Rs)</th>
                                        <th class="text-right">Corporate Base Currency(Rs)</th>

                                    </tr>
                                    <tr>
                                        <td align="left">People Revenue</td>
                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                    </tr>
                                    <tr>
                                        <td align="left">Accured Billable Expenses</td>
                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                    </tr>
                                    <tr class="ttlrow">
                                        <td align="left">Total Revenue</td>
                                        <td align="right">Rs. 0.00</td>
                                        <td align="right">0.00</td>
                                    </tr>
                                    <tr class="grouprow">
                                        <th align="left">Accrued Cost</th>
                                        <th>&nbsp;</th>
                                        <th>&nbsp;</th>
                                    </tr>
                                    <tr>
                                        <td align="left">People Cost</td>
                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                    </tr>
                                    <tr class="ttlrow">
                                        <td align="left">Total Cost</td>
                                        <td align="right">Rs. 0.00</td>
                                        <td align="right">0.00</td>
                                    </tr>

                                </table>
                            </div>

                           <%-- <div class="grossprofitinfo graybg">
                                <p>Gross Profit Margin (as on : 08/31/2013 ) = Total Revenue - Total Cost</p>
                                <!--<p>Gross Profit Margin = Rs. 0.00 - Rs. 28,000.00 = <font color="red">(Rs. -28,000.00)</font></p>
                                <p>Gross Profit Margin % = 0</p>-->
                            </div>--%>


                        </div>

                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    <!-- Project people cost Modal End here-->




    <div class="clearfix"></div>
    </div>

           <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->

    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
<%--    <script src="../../../Whizible2.0/plugins/jQuery/jQuery-2.1.4.min.js"></script>

    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0/plugins/jQueryUI/jquery-ui.min.js"></script>--%>
   
<%--    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap.min.js"></script>
     <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap-select.js"></script>

    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/dist/js/jquery.dataTables.min.js"></script>--%>
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
            $(".dropdown-toggle").dropdown();
        });





        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });


        $('.hiddenRow').on('show.bs.collapse', function () {
            $(this).prev(".accordion-toggle").toggleClass("in");
        });
        $('.hiddenRow').on('hidden.bs.collapse', function () {
            $(this).prev(".accordion-toggle").removeClass("in");
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


        //Graph script start Frome Here




    </script>


    <%--//added by Anwar--%>
    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 3.5.1 -->
    <script src="../../../Whizible2.0/plugins/jQuery/jquery-3.5.1.min.js"></script>
           <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap-select.js"></script>
           <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap.min.js"></script>
           <!--start script only for project pulse chart section-->
    <!-- ChartJS 1.0.1 -->
    <script src="../../../Whizible2.0/plugins/chartjs/Chart.min.js"></script>

    <script src="../../../Whizible2.0/dist/js/jquery.dataTables.min.js"></script>

   <%-- <script src="../../../Whizible2.0/plugins/chartjs/chartjs-plugin-datalabels.js"></script>--%>


     <script src="../../General/CommonValidations.js"></script>

    <script src="../../General/CommonFunctions.js"></script>


    <script src="../../../Whizible2.0/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0/dist/js/custom.js"></script>
       
      <!--For Simple Pagination-->
    <script src="../../../Whizible2.0/dist/js/jquery.simplePagination.js"></script>
       
    <!-- Alertify added by Vidhi-->
    <script src = "../../../Whizible2.0/plugins/alertify/alertify.min.js" ></script>
                      
    


    <script type = "text/javascript" >


        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Dashboard").ToString%>';
        $("[data-toggle='tooltip']").tooltip();
        $(".progress span, .progress div").hover(function () {
            $(this).parent().tooltip("disable");
        }, function () {
            $(this).parent().tooltip("enable");
        });

        //close widget
        $(".dashclosewidget").click(function () {
            $(".widget_category_panel").removeClass("in");
        });


        $(document).ready(function ()
        {
            var s = '';
            
            $("#CboProjectgroup").html('');
           
            /*alert("in ready");*/
            var Parameter =
            {
                UserId: '<%= Session("intUserID") %>'
                
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/Dashboard/FillProjectGroup",param, false);
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.projectgroupid + '">' + ObjRateCard.projectgroupname + '</option>';
               
            }
            $("#CboProjectgroup").html(s);
            

            FillData(0);
        });

        function FillData(projectgroupid)
        {
            var s = '';
            //alert("in filldata");
            $("#CboProject").html('');
         var Parameter =
            {
                UserId: '<%= Session("intUserID") %>',
                projectgroupid: projectgroupid,
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/Dashboard/FillProject", param, false);
            var strProject = '';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.ProjectId + '">' + ObjRateCard.ProjectName + '</option>';
                
                strProject = strProject + ObjRateCard.ProjectId +','
            }
            $("#CboProject").html(s);
            //alert(strProject);
            var ProjectID = $("#CboProject").val();
            var Parameter =
            {
                ProjectID: ProjectID,
               
            }
            var param = JSON.stringify(Parameter);
            //Fill BG
            var BGID = $("#CboBG").text();
           
            if (BGID =='1') {
                $("#CboBG").html('');
                var Result = AJAXCallWithResult("/api/Dashboard/FillBG", param, false);
                s = '';
                for (var i = 0; i < Result.length; i++) {
                    var ObjRateCard = Result[i];
                    s += '<option value="' + ObjRateCard.BusinessGroupID + '">' + ObjRateCard.BusinessGroup + '</option>';
                }
                $("#CboBG").html(s);
            }

            var OUID = $("#CboOU").text();
            if (OUID == '1') {
                $("#CboOU").html('');
                var Result = AJAXCallWithResult("/api/Dashboard/FillOU", param, false);
                s = '';
                for (var i = 0; i < Result.length; i++) {
                    var ObjRateCard = Result[i];
                    s += '<option value="' + ObjRateCard.LocationID + '">' + ObjRateCard.Location + '</option>';
                }
                $("#CboOU").html(s);
            }
            ////Fill Currency
            $("#CboCurrency").html('');
            var Result = AJAXCallWithResult("/api/Dashboard/FillCurrency", '', false);
            s = '';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.CurrencyID + '">' + ObjRateCard.CurrencyCode + '</option>';
            }
            $("#CboCurrency").html(s);
            var GPM = 0;
            if (document.getElementById('GPMpositive').checked) {
                GPM = 1
            }
            else if (document.getElementById('GPMNegative').checked) {
                GPM = -1
            }
            else if (document.getElementById('GPMAll').checked) {
                GPM = 0
            }
            FillDataTable(strProject,GPM);
           
        }

        function FillBGData(BGID,BGOU) {
            var s = '';
            //alert("in filldata");
            $("#CboProject").html('');
            
            if (BGOU == 'BG') {
               
                var Parameter =
                {
                    UserId: '<%= Session("intUserID") %>',
                    BusinessGroupID: BGID,
                    Flag: 1
                }
            }
            else {
                var Parameter =
                {
                    UserId: '<%= Session("intUserID") %>',
                    LocationID: BGID,
                    Flag: 0
                }
            }
           var param = JSON.stringify(Parameter);
           var Result = AJAXCallWithResult("/api/Dashboard/FillBGProject", param, false);
           var strProject = '';
           for (var i = 0; i < Result.length; i++) {
               var ObjRateCard = Result[i];
               s += '<option value="' + ObjRateCard.ProjectId + '">' + ObjRateCard.ProjectName + '</option>';

               strProject = strProject + ObjRateCard.ProjectId + ','
           }
           $("#CboProject").html(s);
           //alert(strProject);
            var ProjectID = $("#CboProject").val();
            
            var Parameter =
            {
                UserId: '<%= Session("intUserID") %>',
                ProjectID: ProjectID,
                BusinessGroupID: BGID
             }

            if (BGOU == 'BG') {
                var Parameter =
                    {
                        UserId: '<%= Session("intUserID") %>',
                         ProjectID: ProjectID,
                         BusinessGroupID: BGID
                     }
                
                $("#CboOU").html('');
                var Result = AJAXCallWithResult("/api/Dashboard/FillBGOU", param, false);
                s = '';
                for (var i = 0; i < Result.length; i++) {
                    var ObjRateCard = Result[i];
                    s += '<option value="' + ObjRateCard.LocationID + '">' + ObjRateCard.Location + '</option>';
                }
                $("#CboOU").html(s);
            }
           ////Fill Currency
           $("#CboCurrency").html('');
           var Result = AJAXCallWithResult("/api/Dashboard/FillCurrency", '', false);
           s = '';
           for (var i = 0; i < Result.length; i++) {
               var ObjRateCard = Result[i];
               s += '<option value="' + ObjRateCard.CurrencyID + '">' + ObjRateCard.CurrencyCode + '</option>';
           }
           $("#CboCurrency").html(s);
           var GPM = 0;
           if (document.getElementById('GPMpositive').checked) {
               GPM = 1
           }
           else if (document.getElementById('GPMNegative').checked) {
               GPM = -1
           }
           else if (document.getElementById('GPMAll').checked) {
               GPM = 0
            }
           
           FillDataTable(strProject, GPM);

       }
        function CboProjectgroup_OnChange() {
            var ProjectGroupID = $("#CboProjectgroup").val();
            
            FillData(ProjectGroupID);

            return;


           
        }
        function  CboBG_OnChange() {
            var BGID = $("#CboBG").val();
            
            FillBGData(BGID,'BG');

            return;
        }
        function CboOU_OnChange() {
            var OUID = $("#CboOU").val();

            FillBGData(OUID,'OU');

            return;
        }
        function CboProject_OnChange() {
            var ProjectID = $("#CboProject").val();
            
            //Fill BG
         
            var Parameter =
            {
                ProjectID: ProjectID,

            }
            var param = JSON.stringify(Parameter);
            //Fill ProjectGroup
            //$("#CboProjectgroup").html('');
            //var Result = AJAXCallWithResult("/api/Dashboard/FillProjectGroup_for_Project", param, false);
            //s = '';
            //for (var i = 0; i < Result.length; i++) {
            //    var ObjRateCard = Result[i];
            //    s += '<option value="' + ObjRateCard.projectgroupid + '">' + ObjRateCard.projectgroupname + '</option>';
            //}
            //$("#CboProjectgroup").html(s);

            $("#CboBG").html('');
            var Result = AJAXCallWithResult("/api/Dashboard/FillBG", param, false);
            s = '';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.BusinessGroupID + '">' + ObjRateCard.BusinessGroup + '</option>';
            }
            $("#CboBG").html(s);


            //Fill OU
            $("#CboOU").html('');
            var Result = AJAXCallWithResult("/api/Dashboard/FillOU",param , false);
            s = '';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.LocationID + '">' + ObjRateCard.Location + '</option>';
            }
            $("#CboOU").html(s);
            var GPM = 0;
            if (document.getElementById('GPMpositive').checked) {
                GPM = 1
            }
            else if (document.getElementById('GPMNegative').checked) {
                GPM = -1
            }
            else if (document.getElementById('GPMAll').checked) {
                GPM = 0
            }
           
            FillDataTable(ProjectID,GPM);

        }
        function CboCurrency_OnChange() {
            var ProjectID = $("#CboProject").val();
            var projectgroupid = $("#CboProjectgroup").val();
            var strProject = '';
            if (ProjectID == 0) {
                var Parameter =
                {
                    UserId: '<%= Session("intUserID") %>',
                    projectgroupid: projectgroupid,
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/Dashboard/FillProject", param, false);
                var strProject = '';
                for (var i = 0; i < Result.length; i++) {
                    var ObjRateCard = Result[i];
                  
                    strProject = strProject + ObjRateCard.ProjectId + ','
                }
            }
            else { strProject = ProjectID + ','; }
            var GPM = 0;
            if (document.getElementById('GPMpositive').checked) {
                GPM = 1
            }
            else if (document.getElementById('GPMNegative').checked) {
                GPM = -1
            }
            else if (document.getElementById('GPMAll').checked) {
                GPM = 0
            }
           
            FillDataTable(strProject,GPM);
        }

        function handleClick() {
            var ProjectID = $("#CboProject").val();
            var CustomerID = $("#CboCustomer").val();
            var GPM = 0;
            if (document.getElementById('GPMpositive').checked) {
                GPM = 1
            }
            else if (document.getElementById('GPMNegative').checked) {
                GPM = -1
            }
            else if (document.getElementById('GPMAll').checked) {
                GPM = 0
            }
            var ProjectID = $("#CboProject").val();
            var projectgroupid = $("#CboProjectgroup").val();
            var strProject = '';
            if (ProjectID == 0) {
                var Parameter =
                {
                    UserId: '<%= Session("intUserID") %>',
                    projectgroupid: projectgroupid,
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/Dashboard/FillProject", param, false);
                var strProject = '';
                for (var i = 0; i < Result.length; i++) {
                    var ObjRateCard = Result[i];

                    strProject = strProject + ObjRateCard.ProjectId + ','
                }
            }
            else { strProject = ProjectID + ','; }
            FillDataTable(strProject,GPM);

        }

        function FillDataTable(strproject,GPM) {
            var BGID = $("#CboBG").val();
            var OUID = $("#CboOU").val();
          
            var PGID =$("#CboProjectgroup").val();
            var ProjectID = $("#CboProject").val();
            var CurrencyID = $("#CboCurrency").val();
          /*  alert(strproject);*/
            if (strproject == '' ||  strproject==0) {
                if (PGID == 0 && ProjectID == 0 && BGID == 0 && OUID == 0) {
                    //alert('nothing is selected');
                    ////alert("both Project Group and Project are not selected");
                    var Parameter =
                    {
                        UserId: '<%= Session("intUserID") %>',
                        projectgroupid: PGID,
                    }
                    var param = JSON.stringify(Parameter);
                    var Result = AJAXCallWithResult("/api/Dashboard/FillProject", param, false);
                    var strproject = '';
                    for (var i = 0; i < Result.length; i++) {
                        var ObjRateCard = Result[i];

                        strproject = strproject + ObjRateCard.ProjectId + ','
                    }
                    //alert(strproject)
                    var Parameter =
                    {
                        BusinessGroupID: 0,
                        LocationID: 0,
                        strproject: strproject,
                        ProjectID: null,
                        ProjectGroupID: null,
                        CurrencyID: null,
                        GPM: GPM

                    }
                }
                else {
                  /*  alert('something is selected');*/
                    var Parameter =
                    {
                        UserId: '<%= Session("intUserID") %>',
                        projectgroupid: PGID,
                        BusinessGroupID: BGID,
                        LocationID: OUID,
                        strproject: strproject,
                        ProjectID: null,
                        GPM: GPM
                    }
                    var param = JSON.stringify(Parameter);
                    var Result = AJAXCallWithResult("/api/Dashboard/FillProject", param, false);
                    var strproject = '';
                    for (var i = 0; i < Result.length; i++) {
                        var ObjRateCard = Result[i];

                        strproject = strproject + ObjRateCard.ProjectId + ','
                    }
                    var Parameter =
                    {
                        UserId: '<%= Session("intUserID") %>',
                        BusinessGroupID: BGID,
                        LocationID: OUID,
                        strproject: strproject,
                        ProjectID: ProjectID,
                        ProjectGroupID: PGID,
                        CurrencyID: CurrencyID,
                        GPM: GPM
                    }
                    //alert(strproject);
                }
            }
        else
            {
                //alert('something is selected')
                //alert(strproject);
                var Parameter =
                {
                    BusinessGroupID: BGID,
                    LocationID: OUID,
                    strproject: strproject,
                    ProjectID: ProjectID,
                    ProjectGroupID: PGID,
                    CurrencyID: CurrencyID,
                    GPM: GPM
                }
            }
            
            var param = JSON.stringify(Parameter);
            var strHTML = "";
            var accruedRev = 0;
            var accruedCost = 0;
            var accruedGPM = 0;
            var invoiceRev = 0;
            var bgaccruedRev = 0;
            var bgaccruedCost = 0;
            var bgaccruedGPM = 0;
            var bginvoiceRev = 0;
            $("#tblbodyAT").html('');
            // $('#PPBGOUTbl').dataTable().fnDestroy();

            //alert("fill table data2");
            var Result = AJAXCallWithResult("/api/Dashboard/FillCorpCurrencyDetail", false, false);
           
            var CorpCurrencySymbol = Result[0].CorpCurrencySymbol;
            $("#spancurr").html('');
            var note = '</strong> <span class="text-right pull-right"><small>( All Figures In : ' + CorpCurrencySymbol + ')</small>'
            $("#spancurr").append(note)
            var Result = AJAXCallWithResult("/api/Dashboard/FillProfitListTbl", param, false);
            var s = '';
            var BG = ''
           
            
            if (CurrencyID > 0) {
               

                if (Result[0].Conversionavailable == 0) {

                    //alert('Conversion Rate to selected Currency not available. Showing data in BaseCurrency')
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Conversion Rate to selected Currency not available. Showing data in BaseCurrency');
                    $("#CboCurrency").html('');
                    var Curr = AJAXCallWithResult("/api/Dashboard/FillCurrency", '', false);
                    s = '';
                    for (var i = 0; i < Curr.length; i++) {
                        var ObjRateCard = Curr[i];
                        s += '<option value="' + ObjRateCard.CurrencyID + '">' + ObjRateCard.CurrencyCode + '</option>';
                    }
                    $("#CboCurrency").html(s);
                }
            }
            //alert("fill table data");
            for (var i = 0; i < Result.length; i++) {
                
                if (Result[i].BusinessGroup == BG) { }
                else {

                    if (i > 0) {
                        strHTML += '<tr class="tblheadingrow graybg">'
                        strHTML += '<td colspan="5"> Total </td>'

                        strHTML += '<td> ' + bgaccruedRev.toLocaleString()  + '</td>'
                        strHTML += '<td> ' + bgaccruedCost.toLocaleString()  + '</td>'
                        strHTML += '<td> ' + bgaccruedGPM.toLocaleString()  + '</td><td></td>'
                        strHTML += '<td> ' + bginvoiceRev.toLocaleString()  + '</td>'

                        strHTML += '</tr>'
                       
                    }
                   
                    BG = Result[i].BusinessGroup
                    strHTML += '<tr class="tblheadingrow graybg">'
                    strHTML += '<td colspan="10">' + Result[i].BusinessGroup + '</td> </tr>'

                    strHTML += '<tr> '
                    bgaccruedRev = 0;
                    bgaccruedCost = 0;
                    bgaccruedGPM = 0;
                    bginvoiceRev = 0;
                   
                }

                strHTML += '< td> </td > '
                strHTML += '<td></td><td><a href="javascript:;" onclick=filldetails(' + Result[i].ProjectID +') data-toggle="modal" data-target="#PPCGrossProfittmodal">' + Result[i].ProjectName + '</a></td>'
                strHTML += '<td>' + Result[i].CustomerName + '</td>'
                strHTML += '<td>' + Result[i].Location + '</td>'
                strHTML += '<td>' + Result[i].ToDate + '</td>'
                strHTML += '<td>' + Result[i].AccruedRevenue.toLocaleString()  + '</td>'
                strHTML += '<td>' + Result[i].AccruedCost.toLocaleString()  + '</td>'
                strHTML += '<td>' + Result[i].AccruedGPM.toLocaleString()  + '</td>'
                strHTML += '<td>' + Result[i].AccruedGPMPercent  + '</td>'
                strHTML += '<td>' + Result[i].InvoiceRevenue.toLocaleString()  + '</td>'
                strHTML += '</tr>'
                accruedRev += Result[i].AccruedRevenue;
                accruedCost += Result[i].AccruedCost;
                accruedGPM += Result[i].AccruedGPM;
                invoiceRev += Result[i].InvoiceRevenue;
                bgaccruedRev += Result[i].AccruedRevenue;
                bgaccruedCost += Result[i].AccruedCost;
                bgaccruedGPM += Result[i].AccruedGPM;
                bginvoiceRev += Result[i].InvoiceRevenue;
            }
            //alert(accruedRev);
            strHTML += '<tr class="tblheadingrow graybg">'
            strHTML += '<td colspan="5"> Total </td>'

            strHTML += '<td> ' + bgaccruedRev.toLocaleString()  + '</td>'
            strHTML += '<td> ' + bgaccruedCost.toLocaleString()  + '</td>'
            strHTML += '<td> ' + bgaccruedGPM.toLocaleString()  + '</td><td></td>'
            strHTML += '<td> ' + bginvoiceRev.toLocaleString()  + '</td>'

            strHTML += '</tr>'
            strHTML += '<tr class="tblheadingrow graybg">'
            strHTML += '<td colspan="5"> Grand Total </td>'
           
            strHTML += '<td> ' + accruedRev.toLocaleString() + '</td>'
            strHTML += '<td> ' + accruedCost.toLocaleString()  + '</td>'
            strHTML += '<td> ' + accruedGPM.toLocaleString()  + '</td><td></td>'
            strHTML += '<td> ' + invoiceRev.toLocaleString()  + '</td>'

            strHTML +='</tr>'
            $("#tblbodyAT").html('');
            $("#tblbodyAT").append(strHTML);
            $(".table").resize();
            $("#PPBGOUTbl").dataTable({
                scrollY: true,
                scrollX: true,
                paging: true,
                pageLength: 5,
                bLengthChange: false,
                bFilter: false,
                ordering: false,
                responsive: true,
                destroy: false,
                retrieve: true,
                bFilter: false,
                ordering: false,
                info: true,
            });
            $(".table").resize();
            $("#CboOUInSideMPopUP").html(s);
        }
        function filldetails(Projectid) {
           // alert("Hi");
            var Parameter =
            {
                ProjectID: Projectid,
               
            }
       

        var param = JSON.stringify(Parameter);
            var strHTML = "";
            $("#tblprjdtl").html('');
            $("#tbldtl").html('');
            var ProjectcurrencySymbol=''
            var Result = AJAXCallWithResult("/api/Dashboard/FillCorpCostMethod", false, false);
            for (var i = 0; i < Result.length; i++) {
                var costmethod = Result[i].CostMethod
            }
          
            var Result = AJAXCallWithResult("/api/Dashboard/FillCorpCurrencyDetail", false, false);
          /*  var CorpCurrency = Result[0].CorpCurrency;*/
            var CorpCurrencySymbol = Result[0].CorpCurrencySymbol;
            var Result = AJAXCallWithResult("/api/Dashboard/FillProfitProjectHeader", param, false);
            for (var i = 0; i < Result.length; i++) {
             
                ProjectcurrencySymbol=Result[i].CurrencySymbol
                strHTML = '<tr><th>Project Name</th><td class="colan">:</td><td class="pr-3"><span class="lmtname">' + Result[i].ProjectName +'</span></td>'


                strHTML += '<th>Project Value</th><td class="colan">:</td><td class="pr-3">' + Result[i].ContractValue +'</td> </tr>'
                strHTML += '  <tr>  <th>Start Date</th><td class="colan">:</td> <td class="pr-3">' + Result[i].ExpectedStartDate +'</td>'

                strHTML += '<th>End Date</th><td class="colan">:</td><td class="pr-3">' + Result[i].ExpectedEndDate + '</td> </tr>'
                strHTML += '<tr> <th>Commercial Type</th><td class="colan">:</td><td>' + Result[i].NodeLabel +'</td>'

                strHTML += '<th>Cost Method</th><td class="colan">:</td><td>' + costmethod + '</td>'
                
                if (Result[i].ActualStartDate =='01-Jan-1900')
                    strHTML += '</tr> <tr><th>Actual Start Date</th><td class="colan">:</td><td class="pr-3"> Yet to start </td>'
                else
                    strHTML += '</tr> <tr><th>Actual Start Date</th><td class="colan">:</td><td class="pr-3">' + Result[i].ActualStartDate + '</td>'
                if (Result[i].ActualEndDate == '1900-01-01T00:00:00')
                    strHTML += '<th>Actual End Date</th><td class="colan">:</td><td class="pr-3">Yet to end </td></tr>'
                else 
                     strHTML +='<th>Actual End Date</th><td class="colan">:</td><td class="pr-3">'+ Result[i].ActualEndDate +'</td></tr>'
              
            }
            $("#tblprjdtl").append(strHTML)
            

            var Result = AJAXCallWithResult("/api/Dashboard/FillProfitProjectDetails", param, false);
            var strHTML = "";
            
            for (var i = 0; i < Result.length; i++) {
                strHTML+=' <tr class="grouprow">'
                strHTML += '<th align="left">Accrued Revenue</th>'
                strHTML += ' <th>Project Currency (' + ProjectcurrencySymbol +')</th>'
                strHTML += '  <th class="text-right">Corporate Base Currency(' + CorpCurrencySymbol +')</th>'
                strHTML += ' </tr>'
                strHTML += ' <tr>'
                strHTML += ' <td align="left">People Revenue</td>'
                strHTML += ' <td align="right">' + Result[i].PeopleRevenue.toLocaleString()  +'</td>'
                strHTML += ' <td align="right">' + Result[i].BasePeopleRevenue.toLocaleString()  +'</td>'
                strHTML += ' </tr>'
                strHTML += ' <tr>'
                strHTML += ' <td align="left">Accured Billable Expenses</td>'
                strHTML += ' <td align="right">' + Result[i].AccuredBillableExpenses.toLocaleString() +'</td>'
                strHTML += ' <td align="right">' + Result[i].BaseAccuredBillableExpenses.toLocaleString()  +'</td>'
                strHTML += '  </tr>'
                strHTML += '  <tr class="ttlrow">'
                strHTML += '  <td align="left">Total Revenue</td>'
                strHTML += ' <td align="right">' + Result[i].Total.toLocaleString()  +'</td>'
                strHTML += '  <td align="right">' + Result[i].BaseTotal.toLocaleString()  +'</td>'
                strHTML += ' </tr>'
                strHTML += ' <tr class="grouprow">'
                strHTML += '   <th align="left">Accrued Cost</th>'
                strHTML += ' <th>&nbsp;</th>'
                strHTML += '  <th>&nbsp;</th>'
                strHTML += '  </tr>'
                if (i == Result.length - 1) {
                    var profit = Result[i].Total - Result[i].TotalCost;
                    var snapshotdate = Result[i].ToDate
                    var BasePeoplecost = Result[i].BasePeopleCost
                    var Peoplecost = Result[i].PeopleCost
                    var MainTotalCost = Result[i].TotalCost
                    var mainBaseTotalCost=Result[i].BaseTotalCost
                    
                    }
                }
           
                var Costhead = AJAXCallWithResult("/api/Dashboard/FillCostHead", param, false);
            var TotalCost = 0
            var BaseTotalCost=0
            
                if (Costhead.length > 0 || Costhead.length) {
                    for (var j = 0; j < Costhead.length; j++) {
                        strHTML += '  <tr>'
                        strHTML += ' <td align="left">' + Costhead[j].CostHead + '</td>'
                        strHTML += ' <td align="right">' + Costhead[j].CostHeadCost.toLocaleString()   + '</td>'
                        strHTML += '  <td align="right">' + Costhead[j].CumulativeBaseCurrencyCost.toLocaleString() + '</td>'
                        strHTML += '  </tr>'
                        BaseTotalCost = Costhead[j].CumulativeBaseCurrencyCost
                        TotalCost += Costhead[j].CostHeadCost
                    }
                    strHTML += '  <tr>'
                    strHTML += ' <td align="left">People Cost</td>'
                    strHTML += ' <td align="right">' + Peoplecost.toLocaleString() + '</td>'
                    strHTML += '  <td align="right">' + BasePeoplecost.toLocaleString() + '</td>'
                    strHTML += '  </tr>'
                    strHTML += '  <tr class="ttlrow">'
                    strHTML += ' <td align="left">Total Cost</td>'
                    strHTML += '  <td align="right">' + TotalCost.toLocaleString() + '</td>'
                    strHTML += '  <td align="right">' + BaseTotalCost.toLocaleString() + '</td>'
                    strHTML += '   </tr>'
                }
                else {
                   
                        strHTML += '  <tr>'
                        strHTML += ' <td align="left">People Cost</td>'
                    strHTML += ' <td align="right">' + Peoplecost.toLocaleString() + '</td>'
                    strHTML += '  <td align="right">' + BasePeoplecost.toLocaleString() + '</td>'
                    strHTML += '  </tr>'
                    strHTML += '  <tr class="ttlrow">'
                    strHTML += ' <td align="left">Total Cost</td>'
                    strHTML += '  <td align="right">' + MainTotalCost.toLocaleString() + '</td>'
                    strHTML += '  <td align="right">' + mainBaseTotalCost.toLocaleString() + '</td>'
                    strHTML += '   </tr>'
                    }
               
               
               
           
            strHTML += ' <tr class="ttlrow"><td> &nbsp; </td></tr>'
            strHTML += ' <tr class="ttlrow">'
            strHTML += '<td> Gross Profit Margin(as on :' + snapshotdate + ') = Total Revenue - Total Cost </td> <td align="right">' + profit.toLocaleString() + '</td></tr>'
            
            $("#tbldtl").append(strHTML);
        }
        strHTML = "";
        var ajaxResult = '';
        function AJAXCallWithResult(url, param, async) {
            //alert("in ajax function");
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
        function DownloadReport(ReportFormat) {

            var BGID = $("#CboBG").val();
            var OUID = $("#CboOU").val();

            var PGID = $("#CboProjectgroup").val();
            var ProjectID = $("#CboProject").val();
            var CurrencyID = $("#CboCurrency").val();
            var GPM = 0;
            if (document.getElementById('GPMpositive').checked) {
                GPM = 1
            }
            else if (document.getElementById('GPMNegative').checked) {
                GPM = -1
            }
            else if (document.getElementById('GPMAll').checked) {
                GPM = 0
            }
            var strproject = '';
            /*  alert(strproject);*/
            if (strproject == '' || strproject == 0) {
               
                if (PGID == 0 && ProjectID == 0 && BGID == 0 && OUID == 0) {
                    
                    var Parameter =
                    {
                        UserId: '<%= Session("intUserID") %>',
                        projectgroupid: PGID,
                    }
                    var param = JSON.stringify(Parameter);
                    var Result = AJAXCallWithResult("/api/Dashboard/FillProject", param, false);
                    var strproject = '';
                    for (var i = 0; i < Result.length; i++) {
                        var ObjRateCard = Result[i];

                        strproject = strproject + ObjRateCard.ProjectId + ','
                    }
                  
                    var Parameter =
                    {
                        BusinessGroupID: 0,
                        LocationID: 0,
                        strproject: strproject,
                        ProjectID: null,
                        ProjectGroupID: null,
                        CurrencyID: null,
                        GPM: GPM,
                        ReportFormat: ReportFormat

                    }
                    
                }
                else {
                    /*  alert('something is selected');*/
                    var Parameter =
                    {
                        UserId: '<%= Session("intUserID") %>',
                        projectgroupid: PGID,
                        BusinessGroupID: BGID,
                        LocationID: OUID,
                        strproject: strproject,
                        ProjectID: null,
                        GPM: GPM,
                        ReportFormat: ReportFormat
                    }
                    var param = JSON.stringify(Parameter);
                    var Result = AJAXCallWithResult("/api/Dashboard/FillProject", param, false);
                    var strproject = '';
                    for (var i = 0; i < Result.length; i++) {
                        var ObjRateCard = Result[i];

                        strproject = strproject + ObjRateCard.ProjectId + ','
                    }
                    var Parameter =
                    {
                        UserId: '<%= Session("intUserID") %>',
                        BusinessGroupID: BGID,
                        LocationID: OUID,
                        strproject: strproject,
                        ProjectID: ProjectID,
                        ProjectGroupID: PGID,
                        CurrencyID: CurrencyID,
                        GPM: GPM,
                        ReportFormat: ReportFormat
                    }
                   
                }
            }
            else {
               
                var Parameter =
                {
                    BusinessGroupID: BGID,
                    LocationID: OUID,
                    strproject: strproject,
                    ProjectID: ProjectID,
                    ProjectGroupID: PGID,
                    CurrencyID: CurrencyID,
                    GPM: GPM,
                    ReportFormat: ReportFormat
                }
            }
           
           $.ajax({
                    url: encodeURI(strUrl) + '/api/Dashboard/ExportDocument',
                    type: "POST",
                    data: JSON.stringify(Parameter),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
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




</body>

</html>
