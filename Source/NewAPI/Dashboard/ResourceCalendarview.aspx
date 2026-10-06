<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ResourceCalendarview.aspx.vb" Inherits="PbNIT.ResourceCalendarview" %>


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
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
     <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
     <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">--%>
    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />


</head>
    
    <style type="text/css">
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }

        .filter.float-end {
            margin: 2px 0 0 8px;
        }

        table tr th {
            vertical-align: middle !important;
        }

            table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
                margin-right: 0;
            }

        .notebox {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }

        .dropdown-submenu .dropdown-submenu > a:after {
            border-color: transparent transparent transparent #fff;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            content: " ";
            display: block;
            float: right;
            height: 0;
            margin-right: 10px;
            margin-top: 5px;
            width: 0;
        }

        .dropdown-submenu > .dropdown-submenu:hover a:after {
            border-color: transparent transparent transparent #464a4c;
        }

        /*Detailpanel*/
        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .pgdetailinner {
            padding: 10px;
        }

        .Resourcedetailpanel .tab-pane {
            padding: 20px 0;
        }

        tr.rowhiglight {
            background: #c3dbff;
        }

        .DisableContent {
            pointer-events: none;
            opacity: 0.5;
        }

            .DisableContent:hover {
                cursor: no-drop;
            }

        .dataTables_scrollBody.DisableContent {
            height: auto !important
        }

        ul.nav.nav-tabs.detailsubtabs {
            background: #f5f5f5;
            margin: -11px -11px;
            padding: 10px 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0;
        }

        .nav.detailsubtabs > li > a:hover, .nav.nav.detailsubtabs > li > a:active, .nav.nav.detailsubtabs > li > a:focus {
            background: #fff;
            color: #1359ac;
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .dblock {
            display: block;
        }
        
        /*New css end here*/

        .lightgraybg {
            background: #f5f5f5;
        }

        /*Information table start here*/
        .informationtbl {
            margin-bottom: 15px
        }

            .informationtbl tr th {
                text-align: right;
                font-weight: 500
            }

        body .informationtbl tr td {
            text-align: left
        }

        .informationtbl th, .informationtbl td {
            padding: 2px 4px
        }

        body .informationtbl tr td.pr-3 {
            padding-right: 3em
        }

        table.informationtbl {
            width: 100%
        }

        td.Agpm {
            color: #eb1c24
        }

        .togglerup .collapseup {
            display: block
        }

        .togglerup .collapsedown {
            display: none
        }

        .togglerdown .collapsedown {
            display: block
        }

        .togglerdown .collapseup {
            display: none
        }

        .infoToggler {
            margin: 5px 0 0
        }

        .hideprofitabilityinfo {
            position: absolute;
            right: 10px
        }

        .profitabilityinfopanel .panel.panel-default {
            padding: 0;
            position: relative
        }

        .profitabilityinfopanel .panel-default > .panel-heading {
            padding-right: 35px;
            background: #e7edf0
        }

            .profitabilityinfopanel .panel-default > .panel-heading a:hover, .profitabilityinfopanel .panel-default > .panel-heading a:focus {
                color: #464a4c
            }

            .profitabilityinfopanel .panel-default > .panel-heading a span img {
                opacity: .5
            }

                .profitabilityinfopanel .panel-default > .panel-heading a span img:hover {
                    opacity: 1
                }
        /*Information table End here*/
        .informationtbl td, .informationtbl th {
            vertical-align: top !important;
            font-size: 14px;
            line-height: normal
        }

        .informationtbl tr th {
            min-width: 120px
        }

        tr.totalrow {
            background: #ccc
        }

        .innerpgsection {
            clear: both;
            display: flex
        }
        
        /*table.calviewTbl thead tr th.holiday, table.calviewTbl tbody tr td.holiday {
            background: #eeeeee;
        }*/
        /*legends*/
        .legend {
            background: #fff;
            background: rgba(255,255,255,0.8);
            padding: 5px 0 0;
            border: none
        }

            .legend ul {
                list-style-type: none;
                margin: 0;
                padding: 0;
                overflow: hidden
            }

            .legend li {
                float: left;
                margin-left: 5px
            }

                .legend li:first-child {
                    margin-left: 0
                }

            .legend span {
                display: inline-block;
                width: 22px;
                height: 15px;
                margin-right: 0;
                border: 1px solid #ddd;
            
            }

/*simple pagination style*/
.simple-pagination{display:inline-block;padding-left:0;margin-top:1rem;margin-bottom:1rem;border-radius:.25rem}
.simple-pagination li{display:inline}
.simple-pagination .page-link,.simple-pagination .ellipse,.simple-pagination .current{display:inline-block;position:relative;float:left;padding:.5rem .75rem;margin-left:-1px;color:#0275d8;text-decoration:none;background-color:#fff;border:1px solid #ddd}
.simple-pagination li:first-child .page-link{margin-left:0;border-bottom-left-radius:.25rem;border-top-left-radius:.25rem}
.simple-pagination li:last-child .page-link{border-bottom-right-radius:.2rem;border-top-right-radius:.2rem}
.simple-pagination li.active .page-link,.simple-pagination li.active .page-link:focus,.simple-pagination li.active .page-link:hover,.simple-pagination li.active .current,.simple-pagination li.active .current:focus,.simple-pagination li.active .current:hover{z-index:2;color:#fff;cursor:default;background-color:#0275d8;border-color:#0275d8}
.simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
        background:#1359ac;}
/*End of pagination style*/

.tdlgdHoliday{background: #f5f5f5;/*border-left: 2px solid #eb1c24 !important;*/ position:relative; }
td.tdlgdHoliday::before {background: red ;}
.tdlgdWFH{background: #eee;}
td.tdlgdWFH::before {background: #81cf09;}
.tdlgdLeave{ background:#eee;}
td.tdlgdLeave::before {background: fuchsia;}
.tdlgdHalfday{background:#eee;}
td.tdlgdHalfday::before {background: mediumpurple;}
.tdlgdPD {background-image: repeating-linear-gradient(45deg, #ffffff, #dfecff 1px, #fff 3px, #fff 4px);background-size: 50px 50px;}
td.tdlgdPD::before {background: none;}

.tdlgdPH{ background-image: repeating-linear-gradient(45deg, #ffffff, #dfecff 1px, #fff 3px, #fff 4px);background-size: 50px 50px;}
td.tdlgdPH::before {background: #eb1c24 ;}
.tdlgdPWFM{background-image: repeating-linear-gradient(45deg, #ffffff, #dfecff 1px, #fff 3px, #fff 4px);background-size: 50px 50px;}
td.tdlgdPWFM::before {background: #81cf09;}
.tdlgdPL{background-image: repeating-linear-gradient(45deg, #ffffff, #dfecff 1px, #fff 3px, #fff 4px);background-size: 50px 50px;}
td.tdlgdPL::before {background: fuchsia;}
.tdlgdPHD{background-image: repeating-linear-gradient(45deg, #ffffff, #dfecff 1px, #fff 3px, #fff 4px);background-size: 50px 50px;}
td.tdlgdPHD::before {background: mediumpurple;}

        td.tdlgdHoliday, td.tdlgdWFH, td.tdlgdLeave, td.tdlgdHalfday, td.tdlgdPlannedday, td.tdlgdPH, td.tdlgdPWFM, td.tdlgdPL, td.tdlgdPHD{ position:relative;
        }
td.tdlgdHoliday::before, td.tdlgdWFH::before, td.tdlgdLeave::before, td.tdlgdHalfday::before, td.tdlgdPlannedday::before, td.tdlgdPH::before, td.tdlgdPWFM::before, td.tdlgdPL::before, td.tdlgdPHD::before{
     position: absolute;
            width: 2px;/*
            background: red;*/
            height: 96%;
            top: 1px;
            content: "";
            left: 0;

}

        /*end legends*/
        .dropdown-menu > li > a:hover {
            background-color: #e1e3e9;
            color: #333;
        }

        .table-fixed-header thead tr th, .table thead tr th {
            padding-top: 6px;
            padding-bottom: 6px;
        }

        .calviewTbl tr th:first-child {
            min-width: 200px;
        }

        .modal-body {
            padding: 30px !important;
        }

        .mb-1 {
            margin-bottom: 10px;
        }

        ul.dropdownlinks li:hover a, ul.dropdownlinks li a {
            padding: 5px 10px;
        }

        span.checkmark {
            color: #9dd824;
        }

        .filterpanelbody > .row > div:nth-child(5n), .filterpanelbody > .row > div:nth-child(6n), .filterpanelbody > .row > div:nth-child(7n) {
            width: 50%;
        }

.lgdHoliday{background: #eee;border-left: 1px solid red !important;}
.lgdWFH{background: #eee;border-left: 2px solid #81cf09 !important;}
.lgdLeave{ background:#eee; border-left:2px solid fuchsia !important;}
.lgdHalfday{background:#eee; border-left:2px solid mediumpurple !important;}
.lgdPlannedday {background-image: repeating-linear-gradient(45deg, #ffffff, #dfecff 1px, #fff 3px, #fff 4px);background-size: 50px 50px;}
.lgdPH{ border-left: 2px solid red!important; background-image: repeating-linear-gradient(45deg, #ffffff, #dfecff 1px, #fff 3px, #fff 4px);background-size: 50px 50px;}
.lgdPWFM{ border-left:2px solid #81cf09!important; background-image: repeating-linear-gradient(45deg, #ffffff, #dfecff 1px, #fff 3px, #fff 4px);background-size: 50px 50px;}
.lgdPL{ border-left:2px solid fuchsia!important; background-image: repeating-linear-gradient(45deg, #ffffff, #dfecff 1px, #fff 3px, #fff 4px);background-size: 50px 50px;}
.lgdPHD{ border-left:2px solid mediumpurple!important; background-image: repeating-linear-gradient(45deg, #ffffff, #dfecff 1px, #fff 3px, #fff 4px);background-size: 50px 50px;}

td.resrsmain.text-start {background: #e7edf0;font-weight: bold;}

/*#tableCalVeiw{ border-collapse:inherit;}*/
#tableCalVeiw thead {
    position: sticky;
    top: 0;
    z-index: 9;
    background: #e7edf0;
}
.modal .dataTables_scrollHeadInner{ width:100% !important;}
        #RUtbl_wrapper table, #proallmodalTbl_wrapper table, #leaveDtlmodalTbl_wrapper table, #skillDtlmodalTbl_wrapper table {
            width: 100% !important;
        }
#inprogressgridTbl_wrapper .dataTables_scrollBody {overflow-x: hidden!important;}
#RC_proallocationTbl_wrapper tr th:first-child{ min-width:100px;}
.PRrolename a.projectCRmenu{background:none}
ul.dropdownlinks li:hover a, ul.dropdownlinks li a{color: #1359a6!important;}
.filterpanelbody .form-group{display:inline-flex}
.form-group{display:inline-flex}
#Issuesavrefilterbox .form-group{display:block}
.modal-header{display:block}
</style>
<body class="hold-transition skin-blue-light sidebar-mini fixed">

    <div class="bgwhite">

        <div class="col-sm-12 pt-1 pb-1 text-end graybg" style="display:table">
            <h5 class="pgtitle float-start text-start">Resource Calendar View</h5>
            <a href="javascript:;" class="clearalllink" style="display:none;" onclick="clearAll" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter" autocomplete="off"><i class="fas fa-filter" style="font-size:15px;"></i></button>
            </div>
        </div>


        <div class="innerpgiframe">
            <!--filter panel-->
            <div class="clearfix"></div>
            <div id="filterpanel" class="filterpanel collapse">
                <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                    <div class="cust_tabpanel">
                        <ul class="nav nav-tabs">
                            <li class="">
                                <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                            </li>
                        </ul>
                    </div>
                    <div class="Fwrapper">
                        <div class="tab-content">
                            <div id="basicfilters" class="tab-pane">
                                <p class="pt-1"><small><strong>Note :</strong> Resource View considers Corporate starting day of week and number working days.</small></p>
                                <div class="filterpanelbody">
                                    <div class="text-center hidden-xs centerbtn">
                                        <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-target="#Issuesavefilter" data-bs-dismiss="modal">Save and Apply</button>
                                        <button class="btn btnyellow">Apply</button>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">Resource</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <input type="text" class="form-control input-sm" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">Role</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>Select Role</option>
                                                            <option>Administrator</option>
                                                            <option>BA</option>
                                                            <option>CEO</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">Designation</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>Select Designation</option>
                                                            <option>CEO</option>
                                                            <option>Delivery Manager</option>
                                                            <option>Presidant</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">Skill</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>Select Skill</option>
                                                            <option>HTML</option>
                                                            <option>CSS</option>
                                                            <option>Javascript</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">Business Group</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>Select Business Group</option>
                                                            <option>Business Group 02</option>
                                                            <option>Business Group 03</option>
                                                            <option>Business Group 04</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">Organization Unit</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>Select Organization Unit</option>
                                                            <option>Organization Unit 02</option>
                                                            <option>Organization Unit 03</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">Delivery Unit</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>Select Delivery Unit</option>
                                                            <option>Delivery Unit 02</option>
                                                            <option>Delivery Unit 03</option>
                                                            <option>Delivery Unit 04</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">Delivery Team</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>Select Delivery Team</option>
                                                            <option>Delivery Team 02</option>
                                                            <option>Delivery Team 03</option>
                                                            <option>Delivery Team 04</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">Employee Type</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>Select Employee Type</option>
                                                            <option>Confirmed</option>
                                                            <option>Contract</option>
                                                            <option>Contractual</option>
                                                            <option>Hourly</option>
                                                            <option>Probation</option>
                                                            <option>Salary</option>
                                                            <option>Trainee</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">Department</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>Select Department</option>
                                                            <option>Delivery And Oprations</option>
                                                            <option>Finance</option>
                                                            <option>HRMS</option>
                                                            <option>Management</option>
                                                            <option>Support</option>
                                                            <option>Technical Support</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">Deployable</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>Select Option</option>
                                                            <option>Yes</option>
                                                            <option>No</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">Resource Pool</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>Select Resource Pool</option>
                                                            <option>John</option>
                                                            <option>Abhi</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 form-group">
                                            <label class="col-sm-4">My Team</label>
                                            <div class="col-sm-8">
                                                <div class="row">
                                                    <div class="col-xs-8 col-sm-8 pl-0">
                                                        <select class="form-control input-sm">
                                                            <option>Select Team</option>
                                                            <option>Team One</option>
                                                            <option>Team Two</option>
                                                            <option>Team Three</option>
                                                        </select>
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
                </div>
            </div>
            <!--end filter panel-->
            <div class="clearfix"></div>
            <div class=" container-fluid pt-1 pb-1">
                <div class="row">
                    <div class="col-sm-4 form-inline">
                        <div class="form-group">
                            <span>Month <input type="text" class="form-control input-sm" style="width:40px;" /></span>
                            <span>Year <input type="text" class="form-control input-sm" style="width:40px;" /></span>
                            <span class="pl-1"><button class="btn btnyellow">Show</button></span>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="legend">
                            <ul class="">
                                <li><label>Legends : </label></li>
                                <li><span class="lgdHoliday" data-toggle="tooltip" data-bs-original-title="Holiday" data-bs-container="body"></span></li>
                                <li><span class="lgdWFH" data-bs-toggle="tooltip" data-bs-original-title="Work From Home" data-bs-container="body"></span></li>
                                <li><span class="lgdLeave" data-bs-toggle="tooltip" data-bs-original-title="Leave" data-bs-container="body"></span></li>
                                <li><span class="lgdHalfday" data-bs-toggle="tooltip" data-bs-original-title="Half Day" data-bs-container="body"></span></li>
                                <li><span class="lgdPlannedday" data-bs-toggle="tooltip" data-bs-original-title="Planned Day" data-bs-container="body"></span></li>

                                <li><span class="lgdPH" data-bs-toggle="tooltip" data-bs-original-title="Planned and Holiday" data-bs-container="body"></span></li>
                                <li><span class="lgdPWFM" data-bs-toggle="tooltip" data-bs-original-title="Planned And Work From Home" data-bs-container="body"></span></li>
                                <li><span class="lgdPL" data-bs-toggle="tooltip" data-bs-original-title="Planned And Leave" data-bs-container="body"></span></li>
                                <li><span class="lgdPHD" data-bs-toggle="tooltip" data-bs-original-title="Planned And Half Day" data-bs-container="body"></span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-4 text-end">
                        <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#ProRsrsAllocationmodal">Project Allocation</a>
                    </div>


                </div>

            </div>

            <div class="content pt-0">
                <div class="tablewrapper">
                    <table id="tableCalVeiw" class="table table-bordered calviewTbl paginated">
                        <thead>
                            <tr>
                                <th class="">
                                    &nbsp;
                                </th>
                                <th colspan="31">
                                    <div class="monthheading">
                                        <a class="montharrow prvMonth" href="javascript:;"><i class="fas fa-chevron-left" data-bs-toggle="tooltip" data-bs-original-title="Previous Month" data-bs-container="body"></i></a>
                                        <div class="tblmnthname">January 2022</div>
                                        <a class="montharrow nextMonth" href="javascript:;"><i class="fas fa-chevron-right" data-bs-toggle="tooltip" data-bs-original-title="Next Month" data-bs-container="body"></i></a>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <th class="">
                                    &nbsp;
                                </th>
                                <th class="thHoliday">S</th>
                                <th class="thHoliday">S</th>
                                <th>M</th>
                                <th>T</th>
                                <th>W</th>
                                <th>T</th>
                                <th>F</th>
                                <th class="thHoliday">S</th>
                                <th class="thHoliday">S</th>
                                <th>M</th>
                                <th>T</th>
                                <th>W</th>
                                <th>T</th>
                                <th>F</th>
                                <th class="thHoliday">S</th>
                                <th class="thHoliday">S</th>
                                <th>M</th>
                                <th>T</th>
                                <th>W</th>
                                <th>T</th>
                                <th>F</th>
                                <th class="thHoliday">S</th>
                                <th class="thHoliday">S</th>
                                <th>M</th>
                                <th>T</th>
                                <th>W</th>
                                <th>T</th>
                                <th>F</th>
                                <th class="thHoliday">S</th>
                                <th class="thHoliday">S</th>
                                <th>M</th>
                            </tr>
                            <tr>
                                <th class="text-start sortbyrole">
                                    <div class="rsrsname">Resource Name</div>
                                </th>
                                <th class="thHoliday">01</th>
                                <th class="thHoliday">02</th>
                                <th>03</th>
                                <th>04</th>
                                <th>05</th>
                                <th>06</th>
                                <th>07</th>
                                <th class="thHoliday">08</th>
                                <th class="thHoliday">09</th>
                                <th>10</th>
                                <th>11</th>
                                <th>12</th>
                                <th>13</th>
                                <th>14</th>
                                <th class="thHoliday">15</th>
                                <th class="thHoliday">16</th>
                                <th>17</th>
                                <th>18</th>
                                <th>19</th>
                                <th>20</th>
                                <th>21</th>
                                <th class="thHoliday">22</th>
                                <th class="thHoliday">23</th>
                                <th>24</th>
                                <th>25</th>
                                <th>26</th>
                                <th>27</th>
                                <th>28</th>
                                <th class="thHoliday">29</th>
                                <th class="thHoliday">30</th>
                                <th>31</th>
                            </tr>
                        </thead>
                        <tbody id="pginatebody">
                            <tr>
                                <td class="resrsmain text-start" colspan="32">
                                    <strong>[John D]</strong>
                                </td>
                            </tr>


                            <tr>
                                <td class="text-start dropdown PRrolename">
                                    Sam D

                                    <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                    <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                        </li>
                                    </ul>
                                </td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdWFH">&nbsp;</td>
                                <td class="tdlgdLeave">&nbsp;</td>
                                <td class="tdlgdHalfday">&nbsp;</td>
                                <td class="tdlgdPH">&nbsp;</td>
                                <td class="tdlgdPWFM">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPL">&nbsp;</td>
                                <td class="tdlgdPHD">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="text-start dropdown PRrolename">
                                    Imran M

                                    <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                    <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                        </li>
                                    </ul>
                                </td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="text-start dropdown PRrolename">
                                    Lawrel H
                                    <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                    <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                        </li>
                                    </ul>
                                </td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="text-start dropdown PRrolename">
                                    Abhijeet T
                                    <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                    <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                        </li>
                                    </ul>
                                </td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="resrsmain text-start" colspan="32">
                                    <strong>Sam H</strong>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-start dropdown PRrolename">
                                    Pradip P
                                    <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                    <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                        </li>
                                    </ul>
                                </td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="text-start dropdown PRrolename">
                                    Lawrel H
                                    <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                    <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                        </li>
                                    </ul>
                                </td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdWFH">&nbsp;</td>
                                <td class="tdlgdLeave">&nbsp;</td>
                                <td class="tdlgdHalfday">&nbsp;</td>
                                <td class="tdlgdPH">&nbsp;</td>
                                <td class="tdlgdPWFM">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPL">&nbsp;</td>
                                <td class="tdlgdPHD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="text-start dropdown PRrolename">
                                    Abhijeet T
                                    <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                    <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                        </li>
                                    </ul>
                                </td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdPD">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="text-start dropdown PRrolename">
                                    Pradip P
                                    <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                    <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                        </li>
                                    </ul>
                                </td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td class="tdlgdHoliday">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>

                        </tbody>
                    </table>

                </div>
                <div id="pagination2" class="float-end"></div>
                <div class="clearfix"></div>



            </div>

        </div>
        <div class="clearfix"></div>


        <!-- Save filter Modal start here-->
        <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="Issuesavrefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end">Filter Name :</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name=""><br />
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow float-start">Save</button>
                                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end">Cancel</button>
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
        <!-- Show all details Modal start here-->
        <div class="modal custmodal fade" id="showalltaskmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4>In Progress Tasks</h4>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">

                        <div class="form-inline mb-1">
                            <div class="form-group">
                                <label>Project Name</label>
                                <input type="text" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label>Task Type</label>
                                <select class="form-control">
                                    <option>Select Task Type</option>
                                    <option>Assigned Task</option>
                                    <option>General Task</option>
                                    <option>Help-Desk Task</option>
                                    <option>Issue Task</option>
                                    <option>MPP Task</option>
                                    <option>Review Task</option>
                                </select>
                            </div>
                        </div>
                        <div class="pt-1 pb-1">
                            <div class="float-start"><strong>Tasks Details For :</strong> Adams</div>
                            <div class="float-end">From Date : 01 Jan 2022 To : 31 Jan 2022</div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="table-responsive">
                            <table id="inprogressgridTbl" class="table table-stripped table-bordered">
                                <thead>
                                    <tr>
                                        <th>Project Name</th>
                                        <th>Task Name</th>
                                        <th>Planned Start Date</th>
                                        <th>Planned End Date</th>
                                        <th>Actual Start Date</th>
                                        <th>Actual End Date</th>
                                        <th>Work</th>
                                        <th>Actual Hrs</th>
                                        <th>Actual Till Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Internal Project Support 2022-23</td>
                                        <td>DSM May 2022</td>
                                        <td>01 May 2022</td>
                                        <td>31 May 2022</td>
                                        <td>5 May 2022</td>
                                        <td>31 Jun 2022</td>
                                        <td>22</td>
                                        <td>5.00</td>
                                        <td>20.00</td>
                                    </tr>
                                    <tr>
                                        <td>Client 2022-23</td>
                                        <td>AHM May 2022</td>
                                        <td>01 Apr 2022</td>
                                        <td>31 Apr 2022</td>
                                        <td>4 May 2022</td>
                                        <td>31 Jun 2022</td>
                                        <td>20</td>
                                        <td>4.00</td>
                                        <td>10.00</td>
                                    </tr>
                                    <tr>
                                        <td>HTML Project 2021-22</td>
                                        <td>Design 2021</td>
                                        <td>01 Apr 2021</td>
                                        <td>31 Apr 2021</td>
                                        <td>1 Jun 2021</td>
                                        <td>31 Jun 2021</td>
                                        <td>22</td>
                                        <td>6.00</td>
                                        <td>22.00</td>
                                    </tr>
                                    <tr>
                                        <td>Internal Project Support 2022-23</td>
                                        <td>DSM May 2022</td>
                                        <td>01 May 2022</td>
                                        <td>31 May 2022</td>
                                        <td>5 May 2022</td>
                                        <td>31 Jun 2022</td>
                                        <td>22</td>
                                        <td>5.00</td>
                                        <td>20.00</td>
                                    </tr>
                                    <tr>
                                        <td>Project Whiz</td>
                                        <td>Help Request - Employee Interface exception</td>
                                        <td>14 Feb 2021</td>
                                        <td>31 Feb 2021</td>
                                        <td>5 Apr 2021</td>
                                        <td>31 Apr 2021</td>
                                        <td>22</td>
                                        <td>5.00</td>
                                        <td>20.00</td>
                                    </tr>
                                    <tr>
                                        <td>HTML Project 2021-22</td>
                                        <td>Design 2021</td>
                                        <td>01 Apr 2021</td>
                                        <td>31 Apr 2021</td>
                                        <td>1 Jun 2021</td>
                                        <td>31 Jun 2021</td>
                                        <td>22</td>
                                        <td>6.00</td>
                                        <td>22.00</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>


                        <p>Activities marked as <font color="red">RED</font> are Void and <font color="blue">BLUE</font> are OnHold</p>
                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Show all details Modal End here-->
        <!-- Resource Utilization details Modal start here-->
        <div class="modal custmodal fade" id="ProRsrsUtilizationmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Resource Utilization</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">

                        <div class="form-inline pb-1">
                            <div class="float-start"><strong>Period :</strong> This Month</div>
                            <div class="float-end">
                                <div class="form-group">
                                    <label>Period</label>
                                    <select class="form-control">
                                        <option>Select Period</option>
                                        <option>This Month</option>
                                        <option>Previous Month</option>
                                        <option>This Quarter</option>
                                        <option>Previous Quarter</option>
                                        <option>Previous Financial Year</option>
                                        <option>Current Financial Year</option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="table-responsive">
                            <table id="RUtbl" class="table table-stripped table-bordered">
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
                                        <th>&nbsp;</th>
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
                                        <td>Resource 01</td>
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
                                        <td>Resource 01</td>
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
                                        <td>Resource 01</td>
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
                                        <td>Resource 01</td>
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
                                        <td>Grand Total</td>
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
                        <div class="text-center"><a href="javascript:;" class="btn borderbtn">Print</a></div>
                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Resource Utilization details Modal End here-->
        <!-- Project Allocation details Modal start here-->
        <div class="modal custmodal fade" id="Proallocationmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Project Allocation</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">

                        <div class="form-horizontal pb-1 row">
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label class="col-sm-4 text-end">Project Name : </label>
                                        <div class="col-sm-8"><input type="text" class="form-control input-sm" /></div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label class="col-sm-4 text-end">Reporting To : </label>
                                        <div class="col-sm-8"><input type="text" class="form-control input-sm" /></div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label class="col-sm-4 text-end">Billable : </label>
                                        <div class="col-sm-8">
                                            <select class="form-control input-sm">
                                                <option></option>
                                                <option>Yes</option>
                                                <option>No</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label class="col-sm-4 text-end">Active : </label>
                                        <div class="col-sm-8">
                                            <select class="form-control input-sm">
                                                <option></option>
                                                <option>Yes</option>
                                                <option>No</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <p class="mb-0"><strong>Resource :</strong> Aditya - Aditya[Team Lead]</p>
                        <div class="table-responsive">
                            <table id="proallmodalTbl" class="table table-stripped table-bordered">
                                <thead>
                                    <tr>
                                        <th>Project Name</th>
                                        <th>Role</th>
                                        <th>Planned Start Date</th>
                                        <th>Planned End Date</th>
                                        <th>Reporting To</th>
                                        <th>Billable</th>
                                    </tr>

                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Global Project Telecomm</td>
                                        <td>Team Lead</td>
                                        <td>01 Jan 2021</td>
                                        <td>31 Dec 2022</td>
                                        <td>John D</td>
                                        <td>No</td>
                                    </tr>
                                    <tr>
                                        <td>Project Commercial Dashboard2021</td>
                                        <td>Team Lead</td>
                                        <td>29 Jan 2021</td>
                                        <td>31 Dec 2021</td>
                                        <td>Sam S</td>
                                        <td>No</td>
                                    </tr>
                                    <tr>
                                        <td>Global Project Telecomm</td>
                                        <td>Team Lead</td>
                                        <td>01 Jan 2021</td>
                                        <td>31 Dec 2022</td>
                                        <td>John D</td>
                                        <td>No</td>
                                    </tr>
                                    <tr>
                                        <td>Project Commercial Dashboard2021</td>
                                        <td>Team Lead</td>
                                        <td>29 Jan 2021</td>
                                        <td>31 Dec 2021</td>
                                        <td>Sam S</td>
                                        <td>No</td>
                                    </tr>
                                    <tr>
                                        <td>Global Project Telecomm</td>
                                        <td>Team Lead</td>
                                        <td>01 Jan 2021</td>
                                        <td>31 Dec 2022</td>
                                        <td>John D</td>
                                        <td>No</td>
                                    </tr>
                                    <tr>
                                        <td>Project Commercial Dashboard2021</td>
                                        <td>Team Lead</td>
                                        <td>29 Jan 2021</td>
                                        <td>31 Dec 2021</td>
                                        <td>Sam S</td>
                                        <td>No</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Project Allocation details Modal End here-->
        <!-- Skill details Modal start here-->
        <div class="modal custmodal fade" id="Skilldetailmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Skill Details</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">
                        <div class="mb-1 form-inline">
                            <div class="form-group">
                                <label class="control-label">Skill Category</label>
                                <select class="form-control" style="width:200px;">
                                    <option>Select Category</option>
                                    <option>Business Awarness</option>
                                    <option>Configuration</option>
                                    <option>Testing</option>
                                    <option>Coading</option>
                                    <option>Auditing</option>
                                    <option>Documentations</option>
                                </select>
                            </div>

                        </div>
                        <div class="pb-1 form-inline">
                            <div class="float-start">
                                <p><strong>Skill Details</strong></p>
                            </div>
                            <div class="float-end text-end"><p class="mb-0"><strong>Resource :</strong> Aditya - Aditya[Team Lead]</p></div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                        <table id="skillDtlmodalTbl" class="table table-stripped table-bordered">
                            <thead>
                                <tr>
                                    <th class="text-start">Skill Category</th>
                                    <th>Skill</th>
                                    <th>Proficiency</th>
                                    <th>Experience</th>
                                </tr>

                            </thead>
                            <tbody>
                                <tr class="graybg tblhdrow">
                                    <td colspan="4" class="text-start">Coding</td>
                                    <td style="display:none;"></td>
                                    <td style="display:none;"></td>
                                    <td style="display:none;"></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>Web Developer</td>
                                    <td>Primary Skill</td>
                                    <td>1 year</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>Web Developer</td>
                                    <td>Primary Skill</td>
                                    <td>1 year</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>Presentation and Training</td>
                                    <td>Primary Skill</td>
                                    <td>1 month</td>
                                </tr>
                                <tr class="graybg tblhdrow">
                                    <td colspan="4" class="text-start">Configuration</td>
                                    <td style="display:none;"></td>
                                    <td style="display:none;"></td>
                                    <td style="display:none;"></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>Project Management</td>
                                    <td>Primary Skill</td>
                                    <td>1 month</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>Web Developer</td>
                                    <td>Primary Skill</td>
                                    <td>1 year</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>Web Developer</td>
                                    <td>Requirement Analysis</td>
                                    <td>1 year</td>
                                </tr>

                            </tbody>
                        </table>
                        <div class="clearfix"></div>
                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Skill details Modal End here-->
        <!-- Leave balance Modal start here-->
        <div class="modal custmodal fade" id="Leavbalmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Leave Detail</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">
                        <div class="pb-1 form-inline">
                            <div class="float-start">
                                <div class="form-group">
                                    <label>Skill Category </label>
                                    <select class="form-control input-sm">
                                        <option>Select Category</option>
                                        <option>Developement</option>
                                        <option>Database</option>
                                        <option>Web Developement</option>
                                        <option>Networking Administration</option>
                                        <option>Salesforce</option>
                                        <option>Implementation</option>
                                        <option>Support</option>
                                    </select>
                                </div>
                            </div>
                            <div class="float-end text-end"><p class="mb-0"><strong>Resource :</strong> Aditya - Aditya[Team Lead]</p></div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="table-responsive">
                            <table id="leaveDtlmodalTbl" class="table table-stripped table-bordered">
                                <thead>
                                    <tr>
                                        <th>Leave Type</th>
                                        <th>Leaves Taken In Financial year</th>
                                        <th>Leave Entitlement</th>
                                        <th>Leave Balance</th>
                                    </tr>

                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Casual Leave</td>
                                        <td>0</td>
                                        <td>9.00</td>
                                        <td>9.00</td>
                                    </tr>
                                    <tr>
                                        <td>Earned Leave-Privilege Leav</td>
                                        <td>0</td>
                                        <td>9.00</td>
                                        <td>9.00</td>
                                    </tr>
                                    <tr>
                                        <td>Half Pay Leave</td>
                                        <td>0</td>
                                        <td>12.00</td>
                                        <td>12.00</td>
                                    </tr>
                                    <tr>
                                        <td>Maternity</td>
                                        <td>0</td>
                                        <td>5.00</td>
                                        <td>5.00</td>
                                    </tr>
                                    <tr>
                                        <td>Personal</td>
                                        <td>0</td>
                                        <td>5.00</td>
                                        <td>5.00</td>
                                    </tr>
                                    <tr>
                                        <td>Quarantine Leave</td>
                                        <td>0</td>
                                        <td>7.00</td>
                                        <td>7.00</td>
                                    </tr>
                                    <tr>
                                        <td>Second Half</td>
                                        <td>0</td>
                                        <td>1.00</td>
                                        <td>1.00</td>
                                    </tr>
                                    <tr>
                                        <td>Casual Leave</td>
                                        <td>0</td>
                                        <td>9.00</td>
                                        <td>9.00</td>
                                    </tr>
                                    <tr>
                                        <td>Sick or Medical Leave</td>
                                        <td>0</td>
                                        <td>12.00</td>
                                        <td>12.00</td>
                                    </tr>
                                    <tr>
                                        <td>Study or Sabbatical Leave</td>
                                        <td>0</td>
                                        <td>6.00</td>
                                        <td>6.00</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="leavcount">
                            <h5>Monthly Leave Count</h5>
                            <table id="leavecountTbl" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Apr</th>
                                        <th>May</th>
                                        <th>Jun</th>
                                        <th>Jul</th>
                                        <th>Aug</th>
                                        <th>Sep</th>
                                        <th>Oct</th>
                                        <th>Nov</th>
                                        <th>Dec</th>
                                        <th>Jan</th>
                                        <th>Feb</th>
                                        <th>Mar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
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

                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Leave balance Modal End here-->
        <!-- Project Resource Allocation Modal start here-->
        <div class="modal custmodal fade" id="ProRsrsAllocationmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Project Resource Allocation</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">

                        <div class="clearfix"></div>
                        <div class="notebox graybg"><small><strong>Note :</strong> Closed,OnHold and Global Projects are not considered.</small></div>
                        <div class="table-responsive">
                            <table id="RC_proallocationTbl" class="table table-stripped table-bordered" style="width:100%;">
                                <thead>
                                    <tr>
                                        <th>Resource Name</th>
                                        <th>AMC</th>
                                        <th>Dashboard Testing</th>
                                        <th>Project Commercial Dashboard 2021</th>
                                        <th>Project RU</th>
                                        <th>WBS Management</th>
                                        <th>Project 005</th>
                                        <th>Project 006</th>
                                        <th>Project 007</th>
                                        <th>Project 008</th>
                                        <th>Project 009</th>
                                        <th>Project 010</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="text-start dropdown PRrolename">
                                            Sam D
                                            <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                            <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                                </li>
                                            </ul>
                                        </td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="text-start dropdown PRrolename">
                                            Sam D
                                            <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                            <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                                </li>
                                            </ul>
                                        </td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="text-start dropdown PRrolename">
                                            John D
                                            <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                            <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                                </li>
                                            </ul>
                                        </td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="text-start dropdown PRrolename">
                                            Jagdish D
                                            <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                            <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                                </li>
                                            </ul>
                                        </td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>

                                    </tr>
                                    <tr>
                                        <td class="text-start dropdown PRrolename">
                                            Narendra D
                                            <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                            <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                                </li>
                                            </ul>
                                        </td>
                                        <td>&nbsp;</td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="text-start dropdown PRrolename">
                                            Imran M
                                            <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                            <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                                </li>
                                            </ul>
                                        </td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="text-start dropdown PRrolename">
                                            Pradip P
                                            <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                            <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                                </li>
                                            </ul>
                                        </td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="text-start dropdown PRrolename">
                                            Sam D
                                            <a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>
                                            <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#showalltaskmodal">Show All Tasks</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#ProRsrsUtilizationmodal">Resource Utilization</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Proallocationmodal">Project Allocation</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Skilldetailmodal">Skill Details</a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" data-bs-target="#Leavbalmodal">Leave Details</a>
                                                </li>
                                            </ul>
                                        </td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td><span class="checkmark"><i class="fas fa-check"></i></span></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>


                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Resource Allocation Modal End here-->

        <div class="clearfix"></div>
    </div>

         <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
<script src="../../../Whizible2.0-new/dist/js/jquery.simplePagination.js"></script>


    <script>

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();


        //pagination script start here
        $(function ($) {
            var items = $("#tableCalVeiw tbody tr");

            var numItems = items.length;
            var perPage = 8;

            // Only show the first 2 (or first `per_page`) items initially.
            items.slice(perPage).hide();

            // Now setup the pagination using the `#pagination` div.
            $("#pagination2").pagination({
                items: numItems,
                itemsOnPage: perPage,
                cssStyle: "light-theme",

                // This is the actual page changing functionality.
                onPageClick: function (pageNumber) {
                    // We need to show and hide `tr`s appropriately.
                    var showFrom = perPage * (pageNumber - 1);
                    var showTo = showFrom + perPage;

                    // We'll first hide everything...
                    items.hide()
                        // ... and then only show the appropriate rows.
                        .slice(showFrom, showTo).show();
                }
            });
        });



        $(document).ready(function () {



        });



        //pagination script end here

        //datatable
        $('#RUtbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });
        $('#proallmodalTbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });

        $('#leaveDtlmodalTbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });

        $('#inprogressgridTbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 3,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });
        $('#skillDtlmodalTbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });
        $('#RC_proallocationTbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });
        



        $(".modal").on('show.bs.modal', function () {
            $("table").resize();
        });

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        // $('#healthshetprojectList').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('.tablewrapper').css({ 'height': tblheight - 165, "overflow-y": "auto" });

            //var tblheight = $(window).height();
            //$('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });




        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
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


            //freez table
            //$('.JStableOuter > table').scroll(function (e) {

            //    $('.JStableOuter > table > thead').css("left", -$(".JStableOuter > tbody").scrollLeft());

            //    $('.JStableOuter > table > thead > tr > th:nth-child(1)').css("left", $(".JStableOuter > table").scrollLeft() - 0);

            //    $('.JStableOuter > table > tbody > tr > td:nth-child(1), .JStableOuter > table > tbody > tr > td:nth-child(2)').css("left", $(".JStableOuter > table").scrollLeft());

            //    $('.JStableOuter > table > thead > tr > th:nth-child(2)').css("left", $(".JStableOuter > table").scrollLeft() - 0);
            //    $('.JStableOuter > table > tbody > tr > td:nth-child(2)').css("left", $(".JStableOuter > table").scrollLeft());


            //    $('.JStableOuter > table > thead').css("top", -$(".JStableOuter > tbody").scrollTop());
            //    $('.JStableOuter > table > thead > tr > th').css("top", $(".JStableOuter > table").scrollTop());

            //});



    </script>

</body>

</html>