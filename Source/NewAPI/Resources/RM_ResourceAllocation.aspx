<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_ResourceAllocation.aspx.vb" Inherits="PbNIT.RM_ResourceAllocation" %>

<!DOCTYPE html>

<html>
          <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">--%>
    <!--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">-->
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2">
    <!-- Font Awesome -->
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">--%>


    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
 <%--   <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

    
     
    

</head>
    <style type="text/css">
        .accordion-button {
            position: relative;
            display: flex;
            align-items: center;
        }
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        .ui-widget.ui-widget-content {
            border: 1px solid #c5c5c5;
            z-index: 123123123 !important;
        }

        .borderbox {
            padding: 10px 10px 10px;
            border: 1px solid #ddd;
            min-height: 74px;
            margin: 0 0 10px;
            border-radius: 4px;
            background: #f5f5f5;
        }

        .rsralocationfltrs label {
            text-align: right; margin-bottom:3px;
        }

        .rsralocationfltrs .input-group-btn button.btn.btncalendar {
            height: 30px;
            background: #eee;
            border: 1px solid #ddd;
        }

        .input-group-btn button.btn.btncalendar {
            background: #eee;
            border: 1px solid #e5e5e5;
        }

        .graphcontainer {
            max-width: 86%;
        }

            .graphcontainer canvas#RAChart {
                max-height: 200px;
            }
.skillsetChartcontainer canvas{max-height: 200px!important;}

        table.dataTable thead th, table.dataTable thead td, table.dataTable tfoot th, table.dataTable tfoot td {
            text-align: center;
        }

        table.cls_insideTbl tr th, table.cls_insideTbl tr td, table tr th, table tr td {
            text-align: center;
        }

        .tab-content .content {
            padding-top: 0px !important;
        }

        .nav-tabs.detailsubtabs .nav-link {
            color: #464a4c;
        }

        .informationtbl tr th {
            text-align: right;
            font-weight: 500;
        }

        .informationtbl th, .informationtbl td {
            padding: 2px 4px;
        }

        .clsRAskillTbl tr th:first-child {
            min-width: 260px;
        }

        .clsRAskillTbl tr th, .clsRAskillTbl tr td {
            text-align: center;
        }

            .clsRAskillTbl tr th:first-child, .clsRAskillTbl tr td:first-child {
                text-align: left;
            }

        .skillsetChartcontainer {
            max-width: 100%;
        }

        .skillgraphTbl {
            border: 1px solid #ddd;
        }

        a.rsrsnamelinks {
            /* border-right: 1px solid #ddd; */
            padding-right: 5px;
            display: block;
            text-align: left;
        }

        .ClsprobableinfoTbl tr th:first-child {
            min-width: 160px;
        }

        .rsrsnamephoto {
            font-weight: 500;
            text-align: left;
        }

            .rsrsnamephoto span {
                width: 28px;
                height: 28px;
                background: #eee;
                border-radius: 100%;
                display: inline-block;
                overflow: hidden;
                position: relative;
                vertical-align: middle;
                margin-right: 8px;
            }

                .rsrsnamephoto span img {
                    max-width: 100% !important;
                    width: 30px;
                }

        .RsrsUserlinks {
            line-height: normal;
            margin-top: 10px;
        }

            .RsrsUserlinks a {
                font-size: 0.8rem !important;
            }

        .main_graybgtbs.nav-tabs > li {
            position: relative;
        }

        .newtxtcount {
            position: absolute;
            top: -10px;
            right: 2px;
            cursor: pointer;
            /*animation: blink 1.5s linear infinite;*/ background: #fbb03b;
        }

            .newtxtcount span {
                font-size: 10px;
                color: #000 !important;
                margin-left: 5px;
                animation: blink 1.5s linear infinite;
            }

        .main_graybgtbs.nav-tabs > li > a:hover > span, .main_graybgtbs.nav-tabs > li > a.show > span {
            color: #fff !important;
        }

        .main_graybgtbs.nav-tabs > li > a.show, .main_graybgtbs.nav-tabs .nav-item.show .nav-link, .main_graybgtbs.nav-tabs .nav-link.active {
            background: #1359ac;
            color: #fff;
        }
        /*
@keyframes blink{
0%{opacity: 0;}
50%{opacity: 0.8;}
100%{opacity: 1;}
}
*/
        /*Accordian*/
        button:focus:not(:focus-visible) {
            box-shadow: none;
            background-color: var(--bs-accordion-active-bg);
            box-shadow: inset 0 calc(-1 * var(--bs-accordion-border-width)) 0 var(--bs-accordion-border-color)
        }

        .accordion-button:focus {
            background: #f5f5f5
        }

        .accordion-header button.accordion-button {
            color: #464a4c;
            font-weight: 600;
            padding: .5rem;
            font-size: .9rem
        }

        .accordion-button:hover {
            background: #f5f5f5
        }

        .position-relative {
            position: relative
        }

        span.badge.ml-1.position-relative.rounded-pill.bg-warning.text-dark {
            font-weight: 500;
            background: none !important
        }

        .rsrssSkillGraphTbl {
            width: 100%;
            border: 1px solid #ddd;
            background: #f5f5f5
        }

        .panelHeadingCls {
            border-radius: 0;
            padding: 10px 0
        }

            .panelHeadingCls h6 {
                font-weight: 700;
                margin: 0
            }
        /**/
        /*Resume style*/
        #ResumeModal .modal-body {
            padding: 0
        }

        .resumecontainer {
            max-width: 100%;
            margin: 0 auto;
            border: 1px solid #ddd;
            box-shadow: 0 1px 4px rgba(0,0,0,0.1);
            background: #fff;
            border-radius: 4px
        }

        .resumeHeader {
            padding: 15px 0;
            border-bottom: 1px solid #eee
        }

            .resumeHeader figure {
                margin: 0 0 0 35px;
                border: 1px solid #ddd;
                height: 160px;
                width: 160px;
                line-height: 160px;
                background: #f5f5f5;
                border-radius: 100%
            }

        .resumehdright.graybg {
            padding: 15px
        }

        .resumetblTitle {
            background: #4263c1 !important;
            color: #fff !important;
            font-size: 16px;
            font-weight: 400;
            padding: 4px 8px !important
        }

        .CandidateName h4 {
            color: #1359a6
        }

        .ResumeAsignmentDetails {
            display: block;
            text-align: left
        }

        .RProname strong {
            color: #1359ac !important
        }

        .resumebody {
            padding: 15px
        }

        .accordion-item .table-bordered, .accordion-item .dataTables_scrollHeadInner {
            width: 100% !important;
        }

        .validto {
            font-size: 12px;
        }

        .borderbox {
            padding: 15px 10px 10px;
            border: 1px solid #ddd;
            min-height: 91px;
            margin: 0 0 10px;
            border-radius: 4px;
            background: #f5f5f5
        }

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


        .position-relative {
            position: relative
        }

        span.badge.ml-1.position-relative.rounded-pill.bg-warning.text-dark {
            font-weight: 500;
            background: none !important
        }

        .rsrssSkillGraphTbl {
            width: 100%;
            border: 1px solid #ddd;
            background: #f5f5f5
        }

        .panelHeadingCls {
            border-radius: 0;
            padding: 10px 0
        }

            .panelHeadingCls h6 {
                font-weight: 700;
                margin: 0
            }

        button, input, optgroup, select, textarea, label {
            font-family: 'Roboto',sans-serif
        }

        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 .04rem #210000
        }

        .modal-title {
            font-size: 14px;
            /* Modified By Madhuri.K On 01-04-2026 */
        }

        .btnyellow:hover, .btnyellow:focus {
            background: #e29214 !important;
            color: #fff !important
        }

        .filterpanel .cust_tabpanel .MyFiltersdropdown.show {
            display: block
        }

        .form-control.input-sm {
            height: 30px
        }

        .detailsubtabs li a {
            padding: 6px 14px;
            color: #464a4c;
            font-weight: 700
        }

        h5 {
            font-size: 14px
        }

        #basicfilters label {
            font-weight: 500
        }

        .custmodal .modal-content .modal-header {
            justify-content: center
        }

        label {
            font-weight: 500;
        }

        span.validto {
            color: green;
            margin-left: 5px;
        }

        .clsRAsimilarReqTbl tr th:last-child, .clsRAsimilarReqTbl tr td:last-child {
            text-align: left;
        }

        .accordion-header {
            position: relative;
        }

        .accordion-item .newtxtcount {
            right: 40px;
            top: 8px
        }

        .main_graybgtbs.nav-tabs > li > a {
            padding: 7PX 11PX;
        }

        .filterpanel input::placeholder {
            font-size: 10px !important;
        }

        ::-webkit-input-placeholder {
            font-size: 12px !important;
        }

        :-moz-placeholder { /* Firefox 18- */
            font-size: 12px !important;
        }

        ::-moz-placeholder { /* Firefox 19+ */
            font-size: 12px !important;
        }

        .ui-datepicker td span, .ui-datepicker td a {
            padding: 0.55em;
        }
        .attacment-file {
            width:130px;
        }
        #DivJDattahcment .borderbtn {
            background: #1359a6!important;
            color: #fff!important;
        }
        /* JD attachment button — prevent long filenames from breaking page width */
        .borderbtn .jd-filename {
            display: inline-block;
            max-width: 160px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            vertical-align: middle;
        }

        .ClsprobableinfoTbl tr th {
            min-width: 54px;
        }
        td .input-group-btn button.btn.btncalendar {
            padding: 4px 10px;
        }
        td .input-group{ min-width:124px;}
          
#searchmoreModal .form-group .row .radio {display: inline-block;font-size: 12px;margin-right: 6px;}
#Skillstbl tr td select {height: 30px;}
#Skillstbl tr th:nth-child(2), #Skillstbl tr th:nth-child(3) {width: 40px;max-width: 90px;}
#Skillstbl tr th:last-child {width: 180px;}
#Skillstbl tr th:first-child, #Skillstbl tr td:first-child {text-align: left;}
#searchmoreModal h5 {margin-bottom: 10px;}
#tableR1_wrapper .dataTables_scrollBody {height: auto!important;}
.wrapdatatable{ max-height:62vh;}
.wrapdatatable thead{ position:sticky; top:0;}
th.sorting_disabled::after, th.sorting_disabled::before {display: none!important;}
.input-group .btn.borderbtn:focus, .input-group .btn.borderbtn:hover {color: #fff;background: #135a9c;}
.ajs-message.ajs-error.ajs-visible {color: #fff;}
.Resourcedetailpanel{ margin-left:12px; margin-right:12px;}
.rsralocationfltrs .form-select {height: 30px;font-size: 12px!important;}
.rsralocationfltrs .form-control {font-size: 12px!important;}
.clsRAsimilarReqTbl tr th:first-child {min-width: 100px;}

.cls_insideTbl thead th:nth-child(2), .cls_insideTbl thead th:nth-child(5), .cls_insideTbl thead th:nth-child(6){ min-width:80px;}
.loadingoverlay {
    z-index: 9999;
}
@media screen and (min-width:1366px){
 .main_graybgtbs.nav-tabs > li > a{padding: 4PX 8PX;font-size: 14px!important;}
}
@media only screen and (max-width:1365px){
    .main_graybgtbs.nav-tabs > li > a{padding: 4PX 8PX;font-size: 13px!important;}
}

#tableC_wrapper tr th:last-child{ min-width:40px;}
.TDactioncol a { color: #464a4c;  margin-left: 5px; opacity: .8;}

        .clsnote {
            font-size:11px;
        }

        /*Added By Dipali V On 12th May 2023 For UI Issues*/
        #divProbableResourceSearchMore .form-control.input-sm {
            height: 30px;
            width: 70px;
        }
       #divProbableResource .form-control.input-sm {
            height: 30px;
            width: 70px;
        }
          /*End of Added By Dipali V On 12th May 2023 For UI Issues*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodyAllocation">

    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-1 text-end graybg">
            <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_PAGENAME") %></h5>
            <a href="javascript:;" class="clearalllink mt-0 mx-2" style="" onclick="clearAll" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline float-end" style="display:none">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div>
            <div class="clearfix"></div>
        </div>

        <!--filter panel-->
        <div id="filterpanel" class="filterpanel collapse">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                <div class="cust_tabpanel">
                    <ul class="nav nav-tabs">
                        <li class="dropdown">
                            <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">My Filters  <span class="caret"></span></a>
                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="project2" type="checkbox" name="project2" onchange="cbChange(this)" data-bs-title="" title="">
                                        <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-bs-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="project2" class="radiotextsty filtername">Project 2 and 3</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproOne" type="checkbox" name="">
                                            <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproOne" data-bs-title="Apply filter"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-bs-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-bs-title="Delete filter"></i></span>
                                    </div>
                                </li>
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="task" type="checkbox" name="task" onchange="cbChange(this)" data-bs-title="" title="">
                                        <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-bs-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="task" class="radiotextsty">Task and milestones</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproTwo" type="checkbox" name="">
                                            <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproTwo" data-bs-title="Apply filter"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-bs-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-bs-title="Delete filter"></i></span>
                                    </div>
                                </li>
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="groupcompany" type="checkbox" name="groupcompany" onchange="cbChange(this)" data-bs-title="" title="">
                                        <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-bs-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="groupcompany" class="radiotextsty">For group company</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproThree" type="checkbox" name="">
                                            <label data-bs-container="body" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" for="IssueselproThree" data-bs-title="Apply filter"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-bs-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-bs-title="Delete filter"></i></span>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li class="">
                            <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                        </li>


                    </ul>
                </div>

                <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="basicfilters" class="tab-pane">
                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-target="#Issuesavefilter" data-bs-dismiss="modal">Save and Apply</button>
                                    <button class="btn btnyellow">Apply</button>
                                </div>
                                <br />


                                <div class="form-group mb-3 px-3">
                                    <div class="row">
                                        <div class="col-sm-3 form-group">
                                            <label>Request Type</label>
                                            <select class="form-select">
                                                <option>Select Request Type</option>
                                                <option>Requested</option>
                                                <option>Extend</option>
                                                <option>Prepone</option>
                                                <option>Allocated</option>
                                                <option>Change Allocation</option>
                                                <option>Declined</option>
                                                <option>On Hold/Closed</option>
                                                <option>Closed</option>
                                                <option>Replacement</option>
                                                <option>NBD</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-3 form-group">
                                            <label>Project</label>
                                            <select class="form-select">
                                                <option>Select Project</option>
                                                <option>Whizible</option>
                                                <option>Help Desk</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-3 form-group">
                                            <label>Role</label>
                                            <select class="form-select">
                                                <option>Select Role</option>
                                                <option>Tool Admin</option>
                                                <option>Admin</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-3 form-group">
                                            <label>Requested Resources</label>
                                            <input type="text" class="form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group mb-3 px-3">
                                    <div class="row">
                                        <div class="col-sm-3 form-group">
                                            <label>Business Group</label>
                                            <select class="form-select">
                                                <option>Select Business Group</option>
                                                <option>BG 1</option>
                                                <option>BG 2</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-3 form-group">
                                            <label>Organization Unit</label>
                                            <select class="form-select">
                                                <option>Select Organization Unit</option>
                                                <option>OU 1</option>
                                                <option>OU 2</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-3 form-group">
                                            <label>From Date</label>
                                            <div class="input-group">
                                                <input id="rqstFrmDate2" type="text" class="form-control" />
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-3 form-group">
                                            <label>To Date</label>
                                            <div class="input-group">
                                                <input id="rqstToDate2" type="text" class="form-control" />
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
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


        <div class="container-fluid">
            <ul class="nav nav-tabs main_graybgtbs mt-3 mb-3" id="tabs">
               
            </ul>
        </div>

        <div class="container-fluid">
            <div class="rsralocationfltrs borderbox mt-2">
                <div class="form-group row">
                    <div class="col-md-3">
                        <label class=""><%= MyBase.GetResourceString("C_PROJECT") %></label>
                        <div class="">
                            <% CommonFunctions.HTMLControls.DrawTextBox("TxtProjectName", "TxtProjectName", "form-control input-sm",,,,,, ,,,, "PlaceHolder = 'Enter Project Name (Maxlength 9 Char)' autocomplete='Off' maxlength='9' ",,, True,,,,) %>
                        </div>
                    </div>

                        <div class="col-md-2">
                        <label class="">Nature of Request :</label>
                        <div class="">
                            <div class="input-group">
                                 <% CommonFunctions.HTMLControls.DrawComboBox("cboNatureOfRequest", "usp_Whizible2_GetNatureOfRequest",,, "class='form-select input-sm text-truncate'",,, ) %>
                 
                            </div>
                        </div>
                    </div>

                    <div class="col-md-2">
                        <label class=""><%= MyBase.GetResourceString("C_REQUESTID") %></label>
                        <div class="pl-0">
                            <% CommonFunctions.HTMLControls.DrawTextBox("TxtRequestID", "TxtRequestID", "form-control input-sm",,,,,, ,,,, "PlaceHolder = '(Maxlength 9 Char)' autocomplete='Off' maxlength='9' onkeypress='return restrictAlphabets(event)'",,, True,,,,) %>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <label class=""><%= MyBase.GetResourceString("C_REQUESTFROMDATE") %></label>
                        <div class="">
                            <div class="input-group">
                                <% CommonFunctions.HTMLControls.DrawTextBox("TxtRequestExtendFromDate", "TxtRequestExtendFromDate", "form-control input-sm",,,,,, , True, "White",, " autocomplete='Off'",,, True,,,,) %>
                                <span class="input-group-btn">
                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <label class=""><%= MyBase.GetResourceString("C_REQUESTTODATE") %></label>
                        <div class="">
                            <div class="input-group">
                                <% CommonFunctions.HTMLControls.DrawTextBox("TxtRequestExtendToDate", "TxtRequestExtendToDate", "form-control input-sm",,,,,, , True, "White",, " autocomplete='Off' ",,, True,,,,) %>
                                <span class="input-group-btn">
                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>

                  
                    <div class="col-md-1">
                        <label class="col-sm-12">&nbsp;</label>
                        <button class="btn btnyellow" onclick="ShowDetails()"><%= MyBase.GetResourceString("C_SHOW") %></button>

                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="form-group row" style="margin-bottom: 0">

                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>


        <div class="tab-content">
            <div id="RsrallocateTab_O" class="tab-pane">
                <div class="content pt-1">
                    <!--Accordian Panel Start here-->
                    <div class="accordion" id="accordionExample">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="RTheadingOne">
                                <button class="accordion-button" type="button" onclick="GetRequestDetails('R',1)" data-bs-toggle="collapse" data-bs-target="#RTcollapseOne" aria-expanded="true" aria-controls="RTcollapseOne">
                                    Requested <span class="badge newtxtcount ml-1 text-dark" data-bs-toggle="tooltip" data-bs-origional-title="New" data-bs-placement="top" data-bs-container="body" onclick="clicknewlist"></span>
                                </button>
                            </h2>
                            <div id="RTcollapseOne" class="accordion-collapse collapse show" aria-labelledby="RTheadingOne" data-bs-parent="#accordionExample">
                                <div class="accordion-body" id="divR1">
                                    <table class="table table-bordered table-stripped cls_insideTbl" id="tblExtend">
                                       
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="RTheadingTwo">
                                <button class="accordion-button collapsed" type="button" onclick="GetRequestDetails('E',1)" data-bs-toggle="collapse" data-bs-target="#RTcollapseTwo" aria-expanded="false" aria-controls="RTcollapseTwo">
                                    Extend <span class="badge newtxtcount ml-1 text-dark" data-bs-toggle="tooltip" data-bs-origional-title="New" data-bs-placement="top" data-bs-container="body" onclick="clicknewlist"></span>
                                </button>
                            </h2>
                            <div id="RTcollapseTwo" class="accordion-collapse collapse" aria-labelledby="RTheadingTwo" data-bs-parent="#accordionExample">
                                <div class="accordion-body">
                                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableE1">
                                        <thead>
                                            <tr>
                                                <th><%= MyBase.GetResourceString("C_ID") %></th>
                                                <th><%= MyBase.GetResourceString("C_REQUESTDATE") %></th>
                                                <th><%= MyBase.GetResourceString("C_PROJECTNAME") %></th>
                                                <th><%= MyBase.GetResourceString("C_REQUESTOR") %></th>
                                                <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                                <th><%= MyBase.GetResourceString("C_TODATE") %></th>
                                                <th><%= MyBase.GetResourceString("C_ALLOCATIONTYPE") %></th>
                                                <th><%= MyBase.GetResourceString("C_HOURS") %> / Percentage</th>
                                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                                                <th>&nbsp;</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyE1">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="RTheading3">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" onclick="GetRequestDetails('P',1)" data-bs-target="#RTcollapse3" aria-expanded="false" aria-controls="RTcollapse3">
                                    Prepone <span class="badge newtxtcount ml-1 text-dark" data-bs-toggle="tooltip" data-bs-origional-title="New" data-bs-placement="top" data-bs-container="body" onclick="clicknewlist"></span>
                                </button>
                            </h2>
                            <div id="RTcollapse3" class="accordion-collapse collapse" aria-labelledby="RTheading3" data-bs-parent="#accordionExample">
                                <div class="accordion-body">
                                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableP1">
                                        <thead>
                                            <tr>
                                              <th><%= MyBase.GetResourceString("C_ID") %></th>
                                                <th><%= MyBase.GetResourceString("C_REQUESTDATE") %></th>
                                                <th><%= MyBase.GetResourceString("C_PROJECTNAME") %></th>
                                                <th><%= MyBase.GetResourceString("C_REQUESTOR") %></th>
                                                <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                                <th><%= MyBase.GetResourceString("C_TODATE") %></th>
                                                <th><%= MyBase.GetResourceString("C_ALLOCATIONTYPE") %></th>
                                                <th><%= MyBase.GetResourceString("C_HOURS") %> / Percentage</th>
                                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                                                <th>&nbsp;</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyP1">
                                          
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="RTheading4">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" onclick="GetRequestDetails('A',1)" data-bs-target="#RTcollapse4" aria-expanded="false" aria-controls="RTcollapse4">
                                    Allocated <span class="badge newtxtcount ml-1 text-dark" data-bs-toggle="tooltip" data-bs-origional-title="New" data-bs-placement="top" data-bs-container="body" onclick="clicknewlist"></span>
                                </button>
                            </h2>
                            <div id="RTcollapse4" class="accordion-collapse collapse" aria-labelledby="RTheading4" data-bs-parent="#accordionExample">
                                <div class="accordion-body">
                                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableA1">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Request Date</th>
                                                <th>Project</th>
                                                <th>Requestor</th>
                                                <th>From Date</th>
                                                <th>To Date</th>
                                                <th>Allocation Type</th>
                                                <th>Work Hours / Percentage</th>
                                                <th>Requested</th>
                                                <th>Asigned</th>
                                                <th>&nbsp;</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyA1">
                                           
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="RTheading5">
                                <button class="accordion-button collapsed" type="button" onclick="GetRequestDetails('CHANGE',1)" data-bs-toggle="collapse" data-bs-target="#RTcollapse5" aria-expanded="false" aria-controls="RTcollapse5">
                                    Change Allocation <span class="badge newtxtcount ml-1 text-dark" data-bs-toggle="tooltip" data-bs-origional-title="New" data-bs-placement="top" data-bs-container="body" onclick="clicknewlist"></span>
                                </button>
                            </h2>
                            <div id="RTcollapse5" class="accordion-collapse collapse" aria-labelledby="RTheading5" data-bs-parent="#accordionExample">
                                <div class="accordion-body">
                                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableCHANGE1">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Request Date</th>
                                                <th>Project</th>
                                                <th>Requestor</th>
                                                <th>From Date</th>
                                                <th>To Date</th>
                                                <th>Allocation Type</th>
                                                <th>Asigned</th>
                                                <th>&nbsp;</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyCHANGE1">
                                          
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="RTheading6">
                                <button class="accordion-button collapsed" type="button" onclick="GetRequestDetails('REJECT',1)" data-bs-toggle="collapse" data-bs-target="#RTcollapse6" aria-expanded="false" aria-controls="RTcollapse6">
                                    Declined
                                </button>
                            </h2>
                            <div id="RTcollapse6" class="accordion-collapse collapse" aria-labelledby="RTheading6" data-bs-parent="#accordionExample">
                                <div class="accordion-body">
                                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableREJECT1">
                                        <thead>
                                            <tr>
                                                <th><%= MyBase.GetResourceString("C_ID") %></th>
                                                <th><%= MyBase.GetResourceString("C_REQUESTDATE") %></th>
                                                <th><%= MyBase.GetResourceString("C_PROJECTNAME") %></th>
                                                <th><%= MyBase.GetResourceString("C_REQUESTOR") %></th>
                                                <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                                <th><%= MyBase.GetResourceString("C_TODATE") %></th>
                                                <th><%= MyBase.GetResourceString("C_ALLOCATIONTYPE") %></th>
                                                <th><%= MyBase.GetResourceString("C_HOURS") %> / Percentage</th>
                                                <th><%= MyBase.GetResourceString("C_REQUESTED") %></th>
                                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                                                <th><i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="View Comments" class="far fa-comment-dots"></i></th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyREJECT1">
                                         
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="RTheading7">
                                <button class="accordion-button collapsed" type="button" onclick="GetRequestDetails('D',1)" data-bs-toggle="collapse" data-bs-target="#RTcollapse7" aria-expanded="false" aria-controls="RTcollapse7">
                                   Onhold/Closed Requests
                                </button>
                            </h2>
                            <div id="RTcollapse7" class="accordion-collapse collapse" aria-labelledby="RTheading7" data-bs-parent="#accordionExample">
                                <div class="accordion-body">
                                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableD1">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Request Date</th>
                                                <th>Project</th>
                                                <th>Allocation Type</th>
                                                <th>Requested</th>
                                                <th>Assigned</th>
                                                <th>Request Status</th>
                                                <th>Project Status</th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyD1">
                                           
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="RTheading8">
                                <button class="accordion-button collapsed" onclick="GetRequestDetails('C',1)" type="button" data-bs-toggle="collapse" data-bs-target="#RTcollapse8" aria-expanded="false" aria-controls="RTcollapse8">
                                    Closed
                                </button>
                            </h2>
                            <div id="RTcollapse8" class="accordion-collapse collapse" aria-labelledby="RTheading8" data-bs-parent="#accordionExample">
                                <div class="accordion-body">
                                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableC1">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Request Date</th>
                                                <th>Project</th>
                                                <th>Requestor</th>
                                                <th>From Date</th>
                                                <th>To Date</th>
                                                <th>Allocation Type</th>
                                               <th><%= MyBase.GetResourceString("C_HOURS") %> / Percentage</th>
                                                <th>Requested</th>
                                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                                                <th><i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="View Comments" class="far fa-comment-dots"></i></th>
                                     
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyC1">
                                           
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="RTheading9">
                                <button class="accordion-button collapsed" type="button" onclick="GetRequestDetails('Replace',1)" data-bs-toggle="collapse" data-bs-target="#RTcollapse9" aria-expanded="false" aria-controls="RTcollapse9">
                                    Replacement <span class="badge newtxtcount ml-1 text-dark" data-bs-toggle="tooltip" data-bs-origional-title="New" data-bs-placement="top" data-bs-container="body" onclick="clicknewlist"></span>
                                </button>
                            </h2>
                            <div id="RTcollapse9" class="accordion-collapse collapse" aria-labelledby="RTheading9" data-bs-parent="#accordionExample">
                                <div class="accordion-body" id="divReplace1">
                                    <table class="table table-bordered table-stripped cls_insideTbl">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Request Date</th>
                                                <th>Project</th>
                                                <th>Requestor</th>
                                                <th>From Date</th>
                                                <th>To Date</th>
                                                <th>Allocation Type</th>
                                                <th>Work Hours / Percentage</th>
                                                <th>Requested</th>
                                                <th>Assigned</th>
                                                <th>&nbsp;</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyReplace1">
                                           
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="RTheading10">
                                <button class="accordion-button collapsed" type="button" onclick="GetRequestDetails('NBD',1)" data-bs-toggle="collapse" data-bs-target="#RTcollapse10" aria-expanded="false" aria-controls="RTcollapse10">
                                    NBD <span class="badge newtxtcount ml-1 text-dark" data-bs-toggle="tooltip" data-bs-origional-title="New" data-bs-placement="top" data-bs-container="body" onclick="clicknewlist"></span>
                                </button>
                            </h2>
                            <div id="RTcollapse10" class="accordion-collapse collapse" aria-labelledby="RTheading10" data-bs-parent="#accordionExample">
                                <div class="accordion-body" id="divNBD1">
                                    <table class="table table-bordered table-stripped cls_insideTbl">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Request Date</th>
                                                <th>Project</th>
                                                <th>Requestor</th>
                                                <th>From Date</th>
                                                <th>To Date</th>
                                                <th>Allocation Type</th>
                                                <th>Work Hours / Percentage </th>
                                                <th>Requested</th>
                                                <th>Assigned</th>
                                                <th>&nbsp;</th>
                                            </tr>
                                        </thead>
                                        <tbody id="TbodyNBD1">
                                            
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div id="RsrallocateTab_R" class="tab-pane active">
                <div class="content pt-1" id="divR">
                </div>
            </div>

            <div id="RsrallocateTab_E" class="tab-pane">
                <div class="content pt-1">
                    <table id="tableE" class="table table-bordered table-stripped cls_insideTbl">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("C_ID") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_PROJECTNAME") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTOR") %></th>
                                <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_TODATE") %></th>
                                <th><%= MyBase.GetResourceString("C_ALLOCATIONTYPE") %></th>
                                <th><%= MyBase.GetResourceString("C_HOURS") %> / Percentage</th>
                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyE">
                        </tbody>
                    </table>

                </div>
            </div>

            <div id="RsrallocateTab_P" class="tab-pane">
                <div class="content pt-1">
                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableP">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("C_ID") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_PROJECTNAME") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTOR") %></th>
                                <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_TODATE") %></th>
                                <th><%= MyBase.GetResourceString("C_ALLOCATIONTYPE") %></th>
                                <th><%= MyBase.GetResourceString("C_HOURS") %> / Percentage</th>
                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyP">
                        </tbody>
                    </table>

                </div>

            </div>

            <div id="RsrallocateTab_A" class="tab-pane">
                <div class="content pt-1">
                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableA">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("C_ID") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_PROJECTNAME") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTOR") %></th>
                                <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_TODATE") %></th>
                                <th><%= MyBase.GetResourceString("C_ALLOCATIONTYPE") %></th>
                                <th><%= MyBase.GetResourceString("C_HOURS") %> / Percentage </th>
                                <th><%= MyBase.GetResourceString("C_REQUESTED") %></th>
                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                                <th>&nbsp;</th>

                            </tr>
                        </thead>
                        <tbody id="tbodyA">
                        </tbody>
                    </table>

                </div>
            </div>

            <div id="RsrallocateTab_CHANGE" class="tab-pane">
                <div class="content pt-1">
                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableCHANGE">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("C_ID") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_PROJECTNAME") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTOR") %></th>
                                <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_TODATE") %></th>
                                <th><%= MyBase.GetResourceString("C_ALLOCATIONTYPE") %></th>
                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyCHANGE">
                        </tbody>
                    </table>

                </div>
            </div>

            <div id="RsrallocateTab_REJECT" class="tab-pane">
                <div class="content pt-1">

                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableREJECT">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("C_ID") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_PROJECTNAME") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTOR") %></th>
                                <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_TODATE") %></th>
                                <th><%= MyBase.GetResourceString("C_ALLOCATIONTYPE") %></th>
                                <th><%= MyBase.GetResourceString("C_HOURS") %> / Percentage </th>
                                <th><%= MyBase.GetResourceString("C_REQUESTED") %></th>
                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                                <th><i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="View Comments" class="far fa-comment-dots"></i></th>
                            </tr>
                        </thead>
                        <tbody id="tbodyREJECT">
                        </tbody>
                    </table>


                </div>
            </div>

             <div id="RsrallocateTab_ESCALATE" class="tab-pane">
                <div class="content pt-1">

                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableESCALATE">
                        <thead>
                             <tr>
                                <th><%= MyBase.GetResourceString("C_ID") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_PROJECTNAME") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTOR") %></th>
                                <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_TODATE") %></th>
                                <th><%= MyBase.GetResourceString("C_ALLOCATIONTYPE") %></th>
                                <th><%= MyBase.GetResourceString("C_HOURS") %> / Percentage </th>
                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                               
                            </tr>
                        </thead>
                        <tbody id="tbodyESCALATE">
                        </tbody>
                    </table>


                </div>
            </div>


            <div id="RsrallocateTab_D" class="tab-pane">
                <div class="content pt-1">
                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableD">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("C_ID") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_PROJECTNAME") %></th>
                                <th><%= MyBase.GetResourceString("C_ALLOCATIONTYPE") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTED") %></th>
                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTSTATUS") %></th>
                                <th><%= MyBase.GetResourceString("C_PROJECTSTATUS") %></th>


                            </tr>
                        </thead>
                        <tbody id="tbodyD">
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="RsrallocateTab_C" class="tab-pane">
                <div class="content pt-1">
                    <table class="table table-bordered table-stripped cls_insideTbl" id="tableC">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("C_ID") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_PROJECTNAME") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTOR") %></th>
                                <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_TODATE") %></th>
                                <th><%= MyBase.GetResourceString("C_ALLOCATIONTYPE") %></th>
                                <th><%= MyBase.GetResourceString("C_HOURS") %> / Percentage </th>
                                <th>Requested</th>
                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                                <th><i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="View Comments" class="far fa-comment-dots"></i></th>
                                         

                            </tr>
                        </thead>
                        <tbody id="tbodyC">
                        </tbody>
                    </table>
                </div>
            </div>


            <div id="RsrallocateTab_Replace" class="tab-pane">
                <div class="content pt-1" id="divReplace">
                </div>
            </div>

            <div id="RsrallocateTab_NBD" class="tab-pane">
                <div class="content pt-1" id="divNBD">
                </div>
            </div>


            <div class="clearfix"></div>
        </div>

        <!--Graph Section Start Here-->
        <div class="container-fluid">
            <table class="table table-stripped rsrssSkillGraphTbl">
                <thead>
                    <tr>
                        <th class="text-start">Resource By Skills</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="graphcontainer">
                                <canvas id="RAChart" width="80"></canvas>
                            </div>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
        <input type="hidden" id="hdnprojectid" />
        <input type="hidden" id="hdnProjectStartDate" />
        <input type="hidden" id="hdnProjectEndDate" />
        <input type="hidden" id="hiddentxtPrPerOfDay" />
        <input type="hidden" id="txthidRoleID" />
        <input type="hidden" id="txthidResourcepoolID" />
        <input type="hidden" id="txthidPriority" />

                <%CommonFunctions.HTMLControls.DrawTextBox("txtPrevAllocation", "txtPrevAllocation",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtPrevAllocationPercentage", "txtPrevAllocationPercentage",,,,  , IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtProjEndDate", "txtProjEndDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtStartDate", "txtStartDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtHours", "txtHours",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtToday", "txtToday",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtHiddenRequestType", "txtHiddenRequestType",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txthidEmployeeID", "txthidEmployeeID",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtTotalWorkHours", "txtTotalWorkHours",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtPercentage", "txtPercentage",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrsPerDay", "txtWorkHrsPerDay",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtReqStartDate", "txtReqStartDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtReqEndDate", "txtReqEndDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("hiddentxtPrPerOfDay", "hiddentxtPrPerOfDay",, IsHidden:=True, EnableHTMLEncode:=True) %>


    
        <!--Graph Section End Here-->
        <!--Detail Section Start here-->
        <div class="Resourcedetailpanel Resourcedetailpanel1">
            <div class="pgdetailinner" id="subtabs">
                <ul class="nav nav-tabs d-none d-lg-flex detailsubtabs">
                    <li class="nav-item"><a href="#Stp1RBGdetails" class="nav-link active" data-bs-toggle="tab" id="detail1">Details</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp1RASkill" onclick="GetSkills()" class="nav-link" data-bs-toggle="tab" id="">Skills</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp1RAallocatedRsrs" onclick="GetAllocation()" class="nav-link" data-bs-toggle="tab" id="">Allocated Resources</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp1RAsimilarReq" onclick="GetSimilarRequest()" class="nav-link" data-bs-toggle="tab" id="tbssimilar">Similar Requests</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp1RAProbableRsrs" onclick="GetProbableResources()" class="nav-link" data-bs-toggle="tab" id="tbsprobable">Probable Resources</a><div></div>
                    </li>
                    <!--<li class="nav-item"><a href="#Stp1RAcnfgreDays" class="nav-link" data-bs-toggle="tab" id="">Configure Days</a><div></div></li>-->
                    <li class="nav-item"><a href="#Stp1RAProbableRsrs" onclick="GetExactMatch()" class="nav-link" data-bs-toggle="tab" id="tbsExactmatch">Exact Match</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">

                    <div id="Stp1RBGdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <a href="javascript:;" class="btn borderbtn mr-5" id="btnDecline" data-bs-toggle="modal" data-bs-target="#declineModal"><%= MyBase.GetResourceString("C_DECLINE_REQ") %></a>
                            <a href="javascript:;" class="btn borderbtn mr-5  btnescalteBG_R"    data-bs-toggle="modal" onclick="Esclateion(1,'btnescalteBG')"><%= MyBase.GetResourceString("C_ETOBP") %></a>
                            <a href="javascript:;" class="btn borderbtn mr-5  btnescalteOU_R" style="display:none"  onclick="Esclateion(2,'btnescalteOU')"><%= MyBase.GetResourceString("C_ETOBP") %></a>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> <%= MyBase.GetResourceString("C_MANDATORY") %>)</strong></p>

                        <div class="RAdetailinfo">
                            <table class="informationtbl" style="width: 100%;" id="tblDetails">
                                <tbody>
                                   

                                </tbody>
                            </table>
                        </div>
                        <hr />
                        <div id="DivConfiguration">
                        <div class="text-end">
                            <button class="btn btnyellow mr-5"  type="button" onclick="SaveConfigureDays()" id="btnConfigure_R">Save</button>
                        </div>
                        <h6><strong>Configure Days</strong><span class="validto">(Request Valid to)</span></h6>
                        <p>Number of days after which resources should be made available if not assigned to any project.</p>

                        <div class="form-inline">
                            <div class="form-group">
                                <label class="required">Resource request validity Days</label>
                                <input type="text" class="form-control" value="0" id="txtNoOfDays" style="width: 100px; display: inline-block;" />
                            </div>
                        </div>
                        </div>
                    </div>
                    <div id="Stp1RASkill" class="tab-pane" style="width: 100%;">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <table id="RASkillTable" class="table table-stripped table-bordered clsRAskillTbl" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Skills</th>
                                            <th>Experience(Years)</th>
                                            <th>Experience(Months)</th>
                                            <th>Proficiency</th>
                                            <th>Core Competency</th>
                                        </tr>
                                    </thead>
                                    <tbody id="RASkillTableBody">
                                    </tbody>
                                </table>

                            </div>
                            <div class="col-sm-6">
                                <table class="table skillgraphTbl">
                                    <thead>
                                        <tr>
                                            <th>Requested Skills</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="skillsetChartcontainer">
                                                    <canvas id="SkillChartTab"></canvas>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>


                            </div>
                        </div>


                    </div>
                    <div id="Stp1RAallocatedRsrs" class="tab-pane">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>

                        <table id="RAallocatedRsrsTable" class="table table-stripped table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>Assignment Date</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Work Hours</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody id="RAallocatedRsrsTableBody">
                            </tbody>
                        </table>

                    </div>
                    <div id="Stp1RAsimilarReq" class="tab-pane">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <span class="clsnote"> Note :- List of Request will display with respective of skill not core competency</span>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-sm-10">
                                <table id="RAsimilarReqTable" class="table table-bordered table-stripped clsRAsimilarReqTbl" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Request ID</th>
                                            <th>Project</th>
                                            <th>Request Details</th>
                                        </tr>
                                    </thead>
                                    <tbody id="RAsimilarReqTableBody">
                                    </tbody>
                                </table>
                            </div>
                        </div>



                    </div>
                    <div id="Stp1RAProbableRsrs" class="tab-pane">
                        <div class="pt-1 pb-1">
                            <div class="row float-start" style="column-count: 4;margin-bottom: 10px;">
                                <div class="col">
                                    <label class="required">Map Project Role</label>
                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectRole", "usp_Sel_tbl_PM_Role_PopulateCombo", 170, , , True, False, "form-select") %>
                                </div>
                                <div class="col">
                                    <label class="required">Map Resource Status</label>
                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable", 170, , , True, False, "form-select") %>
                                </div>
                                <div class="col">
                                    <label class="">Search By Employee Name</label>
                                    <input type="text" class="form-control" id="employeeName" style="width: 200px;" />
                                </div>
                                <%-- Added by Dipali V on 15th May 2026 - Purpose:-Vendor filter on Probable Resources tab; options loaded via FillRAVendorDropdown (project active + request-mapped vendors, same as PM_RequestedResources FillRequestVendorDropdown). --%>
                                <div class="col" id="DivVendor">
                                    <label class="">Vendor</label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboVendorProbable", "Select ''", 170, , , True, False, "form-select") %>
                                </div>
                            </div>
                            <div class="detailsubtabsbtn text-end float-end">
                                 <a href="javascript:SearchProbableResources();" class="btn borderbtn">Search</a>
                                <a href="javascript:GetSearchMore();" class="btn borderbtn mr-5" id="searchMoreProbable">Search More</a>
                                <a href="javascript:Allocate_OnClick();" class="btn borderbtn mr-5" id="">Allocate</a>
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div id="divProbableResource">
                        </div>
                    </div>
                  
                </div>
            </div>
        </div>

        <div class="Resourcedetailpanel ResourcedetailpanelExtend">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs d-none d-lg-flex detailsubtabs">
                    <li class="nav-item"><a href="#Stpdetails_E" class="nav-link active" data-bs-toggle="tab" id="detail_E" >Details</a><div></div>
                    </li>

                </ul>
                <div class="tab-content">

                    <div id="Stpdetails_E" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            
                            <a href="javascript:;" class="btn borderbtn mr-5"  id="btnDecline_E" style="display:none" data-bs-toggle="modal" data-bs-target="#declineModal" ><%= MyBase.GetResourceString("C_DECLINE_REQ") %></a>
                            <a href="javascript:;" class="btn borderbtn mr-5"  id="btnAllocat_E" style="display:none" onclick="AllocateRequest('E')">Allocate</a>
                          
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> <%= MyBase.GetResourceString("C_MANDATORY") %>)</strong></p>

                        <div class="RAdetailinfo">
                            <table class="informationtbl" style="width: 100%;">
                                <tbody>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_REQID") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="lmtname" id="lblrequestid"></span></td>


                                        <th><%= MyBase.GetResourceString("C_REQON") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3" style="width:12%"><span class="" id="lblRequestOn"></span></td>

                                        <th><%= MyBase.GetResourceString("C_RBY") %></th>
                                        <td class="colan">:</td>
                                        <td><span class="" id="lblRequestBy"></span></td>
                                    </tr>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_PROJECT1") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3" style="width:26%"><span class="" id="lblProjectName"></span></td>

                                        <th><%= MyBase.GetResourceString("C_ROLE") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="" id="lblRole"></span></td>

                                        <th style="width:14%"><%= MyBase.GetResourceString("C_RR") %></th>
                                        <td class="colan">:</td>
                                        <td><span class="" id="lblReqResource"></span></td>
                                    </tr>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_BG") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="" id="lblBG"></span></td>

                                        <th><%= MyBase.GetResourceString("C_FD") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="" id="lblFromdate"></span></td>

                                        <th><%= MyBase.GetResourceString("C_FT") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="" id="lblFromTo"></span></td>
                                    </tr>

                                     <tr>
                                        <th>Allocation Unit</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span class="" id="lblAllocationUnit"></span>
                                        </td>


                                        <th>Allocation Value</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="" id="lblAllocationValue"></span> % </td>

                                    </tr>

                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_OU") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span class="" id="lblOU"></span>
                                        </td>


                                       <%-- <th><%= MyBase.GetResourceString("C_PD") %></th>--%>
                                        <th class="ClsCaptionWorkhourstypewise">Work Hours</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="" id="lblHoursperday"></span></td>

                                        <th><%= MyBase.GetResourceString("C_SR") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">&nbsp;<span class="" id="lblSpecialRequest"></span></td>
                                    </tr>

                                     <tr>
                                        <th>Type of Requirement</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblchangeTypeOfReq_E"></span>
                                        </td>


                                        <th>Replacement Employee Name</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblReplacementEmployeeName_E"></span></td>

                                        <th>No.of Resource</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblNoOfResource_E"></span></td>
                                    </tr>


                                      <tr>
                                        <th>Department</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblDeparment_E"></span>
                                        </td>


                                        <th>Location</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblLocation_E"></span></td>

                                        <th>Engagement Model</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblEngmodel_E"></span></td>
                                    </tr>

                                       <tr>
                                        <th>Billing Position</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblBillingPosition_E"></span>
                                        </td>


                                        <th>Billing Start Date</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3" style="width:12%"><span  id="lblBilingStartDate_E"></span></td>

                                        <th>SOW Available</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblSOWAvailbale_E"></span></td>
                                    </tr>

                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_AR") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span class="" id="lblAssignedRequest"></span>
                                        </td>
                                    </tr>

                                     <tr>
                                    <td colspan="8">
                                  <div class="attacment-file" style="float:right">
                                        <div class="col-sm-8" style="float:right; padding-left:0" id="DivJDattahcment_E">
                                              <div class="form-group">
                                                    <div class="input-group col-xs-12">
                                                         <span class="input-group-btn">
                                                            <button class="btn borderbtn" id="btndownloadfile_E"  type="button" title="Donwload JD Attachments" data-toggle="tooltip" onclick="DownloadJDAttachement();"><i class="fas fa-download" data-toggle="tooltip" data-placement="top" data-container="body" data-original-title="Download"></i> <span id="FILENAME_E" class="jd-filename" title=""></span></button>
                                                         </span>
                                                       </div>
                                                   </div>
                                     </div>
                                  </div>
                                        </td>
                                  </tr>

                                </tbody>
                            </table>
                        </div>
                        <hr />
                        
                        <div id="TabsExtendDetails">
                             <h5>Extend Request Details</h5>
                        <br />
                        <div class="form-group mb-2">
                            <div class="row row-cols-sm-auto">
                                <div class="col-sm-4">
                                    <label class="required"><%= MyBase.GetResourceString("C_NED") %></label>
                                    <div class="input-group">

                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtENewEndday", "txtExtendNewEndday", "form-control datetimepicker",,,,,, , True,,, "' autocomplete='Off' maxlength='100' disabled",,, True,,,,) %>

                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-8">
                                    <label class="" style="display: block;">&nbsp;</label>
                                    <strong><%= MyBase.GetResourceString("C_PRENOTE") %></strong>
                                </div>

                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="form-group mb-2">
                            <div class="row row-cols-sm-auto">
                                <div class="col-sm-4">
                                    <label><%= MyBase.GetResourceString("C_NA") %> </label>
                                    <div class="row">
                                        <div class="col-sm-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtNewHrsPerDay_E", "txtNewHrsPerDay_E", "form-control",,,,,, ,,, True, "' autocomplete='Off' maxlength='100' disabled",,, True,,,,) %>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtDisplayENewHrsPerDay_E", "txtDisplayENewHrsPerDay_E", "form-control",,,,,, ,,,, "' autocomplete='Off' maxlength='100' disabled",,, True,,,,) %>
                                         
                                            </div>
                                        <div class="col-sm-2"><span class="spntype"></span></div>
                                    </div>
                                </div>


                                <div class="col-sm-4">
                                    <label class="required"><%= MyBase.GetResourceString("C_NNED") %></label>
                                    <div class="input-group">

                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtEEffectivePerday_E", "txtEffectivePerday_E", "form-control datetimepicker",,,,,, , True,,, "'autocomplete='Off' maxlength='100' disabled",,, True,,,,) %>

                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="">&nbsp;</label>
                                    <div>
                                        <label class=""><%= MyBase.GetResourceString("C_NTWH") %> :</label>
                                        <span id="lblNTWH_E" style="display:none"></span>
                                        <span id="lblNTWH1_E"></span>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row row-cols-sm-auto">
                                <div class="col-sm-4">
                                    <label><%= MyBase.GetResourceString("C_SR") %></label>
                                    <% CommonFunctions.HTMLControls.DrawTextArea("txtESecipalReq", "txtESecipalReq", , "form-control", , , , , , , , , , , ,, , , " data-autoresize ", , )%>
                                </div>


                                <div class="col-sm-4">
                                    &nbsp;
                                </div>
                                <div class="clearfix"></div>
                            </div>


                            <div class="clearfix"></div>
                        </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="Resourcedetailpanel ResourcedetailpanelPrepone">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs d-none d-lg-flex detailsubtabs">
                    <li class="nav-item"><a href="#Stpdetails_P" class="nav-link active" data-bs-toggle="tab" id="detail_P">Details</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">

                    <div id="Stpdetails_P" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                             <a href="javascript:;" class="btn borderbtn mr-5"  id="btnDecline_P" data-bs-toggle="modal" data-bs-target="#declineModal" ><%= MyBase.GetResourceString("C_DECLINE_REQ") %></a>
                            <a href="javascript:;" class="btn borderbtn mr-5"  id="btnAllocat_P"  onclick="AllocateRequest('P')">Allocate</a>
<%--                            <a href="javascript:;" class="btn borderbtn mr-5" id="" data-bs-toggle="modal" data-bs-target="#EscalationGRPModal"><%= MyBase.GetResourceString("C_ESCALATETOGRP") %></a>--%>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font><%= MyBase.GetResourceString("C_MANDATORY") %>)</strong></p>

                        <div class="RAdetailinfo">
                            <table class="informationtbl" style="width: 100%;">
                                <tbody>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_EM") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="lmtname" id="lblpreEmployeeName"></span></td>


                                        <th><%= MyBase.GetResourceString("C_ASD") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="" id="lblpreASD"></span></td>

                                        <th><%= MyBase.GetResourceString("C_AED") %></th>
                                        <td class="colan">:</td>
                                        <td><span class="" id="lblpreAED"></span></td>
                                    </tr>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_AT") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="" id="lblpreAT"></span></td>

                                        <th><%= MyBase.GetResourceString("C_AV") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="" id="lblpreAV"></span></td>

                                       <%-- <th><%= MyBase.GetResourceString("C_WH") %></th>--%>
                                         <th >Work Hours on Project</th>
                                        <td class="colan">:</td>
                                        <td><span class="" id="lblpreWH"></span></td>
                                    </tr>

                                    <tr>
                                        <th>Type of Requirement</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblchangeTypeOfReq_P"></span>
                                        </td>


                                        <th>Replacement Employee Name</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblReplacementEmployeeName_P"></span></td>

                                        <th>No.of Resource</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblNoOfResource_P"></span></td>
                                    </tr>


                                      <tr>
                                        <th>Department</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblDeparment_P"></span>
                                        </td>


                                        <th>Location</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblLocation_P"></span></td>

                                        <th>Engagement Model</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblEngmodel_P"></span></td>
                                    </tr>

                                       <tr>
                                        <th>Billing Position</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblBillingPosition_P"></span>
                                        </td>


                                        <th>Billing Start Date</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblBilingStartDate_P"></span></td>

                                        <th>SOW Available</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblSOWAvailbale_P"></span></td>
                                    </tr>


                                    <tr>
                                    <td colspan="8">
                                  <div class="attacment-file" style="float:right">
                                        <div class="col-sm-8" style="float:right; padding-left:0" id="DivJDattahcment_P">
                                              <div class="form-group">
                                                    <div class="input-group col-xs-12">
                                                         <span class="input-group-btn">
                                                            <button class="btn borderbtn" id="btndownloadfile_P"  type="button" title="Donwload JD Attachments" data-toggle="tooltip" onclick="DownloadJDAttachement();"><i class="fas fa-download" data-toggle="tooltip" data-placement="top" data-container="body" data-original-title="Download"></i> <span id="FILENAME_P" class="jd-filename" title=""></span></button>
                                                         </span>
                                                       </div>
                                                   </div>
                                     </div>
                                  </div>
                                        </td>
                                  </tr>


                                </tbody>
                            </table>
                        </div>
                        <br />
                        <hr />
                     
                          <div id="TabPrePoneDetails">
                             <h5>Prepone Request Details</h5>
                        <br />
                        <div class="form-group mb-2">
                            <div class="row row-cols-sm-auto">
                                <div class="col-sm-4">
                                    <label class="required"><%= MyBase.GetResourceString("C_NED") %></label>
                                    <div class="input-group">

                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtNewEndday", "txtNewEndday", "form-control",,,,,, ,,,, "' autocomplete='Off' maxlength='100' disabled",,, True,,,,) %>

                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-8">
                                    <label class="" style="display: block;">&nbsp;</label>
                                    <strong><%= MyBase.GetResourceString("C_PRENOTE") %></strong>
                                </div>

                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="form-group mb-2">
                            <div class="row row-cols-sm-auto">
                                <div class="col-sm-4">
                                    <label><%= MyBase.GetResourceString("C_NA") %> </label>
                                    <div class="row">
                                        <div class="col-sm-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtNewHrsPerDay_P", "txtNewHrsPerDay_P", "form-control",,,,,, ,,, True, "' autocomplete='Off' maxlength='100' disabled",,, True,,,,) %>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtDisplayNewHrsPerDay_P", "txtDisplayNewHrsPerDay_P", "form-control",,,,,, ,,,, "' autocomplete='Off' maxlength='100' disabled",,, True,,,,) %>
                                        </div>
                                        <div class="col-sm-2"><span class="spntype"></span></div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required"><%= MyBase.GetResourceString("C_NNED") %></label>
                                    <div class="input-group">

                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtEffectivePerday_P", "txtEffectivePerday_P", "form-control",,,,,, ,,,, "' autocomplete='Off' maxlength='100' disabled",,, True,,,,) %>

                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="">&nbsp;</label>
                                    <div>
                                        <label class=""><%= MyBase.GetResourceString("C_NTWH") %> :</label>
                                        <span id="lblNTWH_P" style="display:none"></span>
                                        <span id="lblNTWH1_P" ></span>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row row-cols-sm-auto">
                                <div class="col-sm-4">
                                    <label><%= MyBase.GetResourceString("C_SR") %></label>
                                    <% CommonFunctions.HTMLControls.DrawTextArea("txtPSecipalReq", "txtPSecipalReq", , "form-control", , , , , , , , , , , ,, , , " data-autoresize ", , )%>
                                </div>


                                <div class="col-sm-4">
                                    &nbsp;
                                </div>
                                <div class="clearfix"></div>
                            </div>


                            <div class="clearfix"></div>
                        </div>
                              </div>
                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <div class="Resourcedetailpanel ResourcedetailpanelAllocation">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs d-none d-lg-flex detailsubtabs">
                    <li class="nav-item"><a href="#Stpdetails_A" class="nav-link active" data-bs-toggle="tab" id="detail_A"><%= MyBase.GetResourceString("C_DETAILS") %></a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp4RASkill_A" class="nav-link" data-bs-toggle="tab" id=""  onclick="GetSkills()"><%= MyBase.GetResourceString("C_SKILLS") %></a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp4RAallocatedRsrs_A" class="nav-link" data-bs-toggle="tab" id="" onclick="GetAllocation()" ><%= MyBase.GetResourceString("C_ARR") %></a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp4RAsimilarReq_A" class="nav-link" data-bs-toggle="tab" id="" onclick="GetSimilarRequest()"><%= MyBase.GetResourceString("C_SIMILARREQ") %></a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp4RAProbableRsrs_A" class="nav-link" data-bs-toggle="tab" id="" onclick="GetProbableResources()"><%= MyBase.GetResourceString("C_PR") %></a><div></div>
                    </li>
                    <!--<li class="nav-item"><a href="#Stp1RAcnfgreDays" class="nav-link" data-bs-toggle="tab" id="">Configure Days</a><div></div></li>-->
                    <li class="nav-item"><a href="#Stp4RAProbableRsrs_A" class="nav-link" data-bs-toggle="tab" id="" onclick="GetExactMatch()"><%= MyBase.GetResourceString("C_EM1") %></a><div></div>
                    </li>

                </ul>
                <div class="tab-content">

                    <div id="Stpdetails_A" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> <%= MyBase.GetResourceString("C_MANDATORY") %>)</strong></p>

                        <div class="RAdetailinfo">
                            <table class="informationtbl" style="width: 100%;">
                                <tbody>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_REQID") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="lmtname" id="lblchangeRequestID"></span></td>


                                        <th><%= MyBase.GetResourceString("C_REQON") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblchangeRequestOn"></span></td>

                                        <th><%= MyBase.GetResourceString("C_RBY") %></th>
                                        <td class="colan">:</td>
                                        <td><span id="lblchangeRequestBy"></span></td>
                                    </tr>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_PROJECT1") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblchangeProjectName"></span></td>

                                        <th><%= MyBase.GetResourceString("C_ROLE") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblchangeRole"></span></td>

                                        <th><%= MyBase.GetResourceString("C_RR") %></th>
                                        <td class="colan">:</td>
                                        <td><span id="lblchangeRR"></span></td>
                                    </tr>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_BG") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblchangeBG"></span></td>

                                        <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblchangeFromDate"></span></td>

                                        <th><%= MyBase.GetResourceString("C_FT") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblchangeTodate"></span></td>
                                    </tr>

                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_OU") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span id="lblchangeOu"></span>
                                        </td>


                                        <th class="ClsCaptionWorkhourstypewise"><%= MyBase.GetResourceString("C_WP") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblhdnchangeWP" style="display:none"></span><span id="lblchangeWP"></span></td>

                                        <th><%= MyBase.GetResourceString("C_SR") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblchangeSR"></span></td>
                                    </tr>

                                    
                                       <tr>
                                        <th>Type of Requirement</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblchangeTypeOfReq_A"></span>
                                        </td>


                                        <th>Replacement Employee Name</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblReplacementEmployeeName_A"></span></td>

                                        <th>No.of Resource</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblNoOfResource_A"></span></td>
                                    </tr>


                                      <tr>
                                        <th>Department</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblDeparment_A"></span>
                                        </td>


                                        <th>Location</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblLocation_A"></span></td>

                                        <th>Engagement Model</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblEngmodel_A"></span></td>
                                    </tr>

                                       <tr>
                                        <th>Billing Position</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblBillingPosition_A"></span>
                                        </td>


                                        <th>Billing Start Date</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblBilingStartDate_A"></span></td>

                                        <th>SOW Available</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblSOWAvailbale_A"></span></td>
                                    </tr>


                                    <tr>
                                        <th>Nature of Request</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblNatureOfReq_A"></span></td>

                                        <th><%= MyBase.GetResourceString("C_AR") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span id="lblchangeAR"></span>
                                        </td>
                                    </tr>

                                     <tr>
                                    <td colspan="8">
                                  <div class="attacment-file" style="float:right">
                                        <div class="col-sm-8" style="float:right; padding-left:0" id="DivJDattahcment_A">
                                              <div class="form-group">
                                                    <div class="input-group col-xs-12">
                                                         <span class="input-group-btn">
                                                            <button class="btn borderbtn" id="btndownloadfile_A"  type="button" title="Donwload JD Attachments" data-toggle="tooltip" onclick="DownloadJDAttachement();"><i class="fas fa-download" data-toggle="tooltip" data-placement="top" data-container="body" data-original-title="Download"></i> <span id="FILENAME_A" class="jd-filename" title=""></span></button>
                                                         </span>
                                                       </div>
                                                   </div>
                                     </div>
                                  </div>
                                        </td>
                                  </tr>

                                </tbody>
                            </table>
                        </div>
                        <hr />
                        <div class="text-end">
                            <button class="btn btnyellow mr-5" type="button" onclick="SaveConfigureDays()" id="btnConfigure_A"><%= MyBase.GetResourceString("C_Save") %></button>
                        </div>
                        <h6><strong><%= MyBase.GetResourceString("C_CONFIDAYS") %></strong><span class="validto">(<%= MyBase.GetResourceString("C_REQVALIDATETO") %>)</span></h6>
                        <p><%= MyBase.GetResourceString("C_ALLOCATENOTE") %>.</p>

                        <div class="form-inline">
                            <div class="form-group">
                                <label class="required"><%= MyBase.GetResourceString("C_ALLVALIDATEDAYS") %></label>
                                <input type="text" class="form-control" value="0" style="width: 100px; display: inline-block;" />
                            </div>
                        </div>

                    </div>
                    <div id="Stp4RASkill_A" class="tab-pane" style="width: 100%;">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <table id="RASkillTbl_A" class="table table-stripped table-bordered clsRAskillTbl" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Skills</th>
                                            <th>Experience(Years)</th>
                                            <th>Experience(Months)</th>
                                            <th>Proficiency</th>
                                            <th>Core Competency</th>
                                        </tr>
                                    </thead>
                                    <tbody id="RASkillTableBody_A">
                                      
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-sm-6">
                                <table class="table skillgraphTbl">
                                    <thead>
                                        <tr>
                                            <th>Skills</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="skillsetChartcontainer">
                                                     <canvas id="SkillChartTab_A"></canvas>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>


                            </div>
                        </div>


                    </div>
                    <div id="Stp4RAallocatedRsrs_A" class="tab-pane">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>

                        <table id="RAllocatedResource_A" class="table table-stripped table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>Assignment Date</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Work Hours</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyRAllocatedResource_A">
                               
                            </tbody>
                        </table>

                    </div>
                    <div id="Stp4RAsimilarReq_A" class="tab-pane">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <span class="clsnote"> Note :- List of Request will display with respective of skill not core competency</span>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-sm-8">
                                <table id="RAsimilarReqTbl_A" class="table table-bordered table-stripped clsRAsimilarReqTbl" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Request ID</th>
                                            <th>Project</th>
                                            <th>Request Details</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyRAsimilarReqTbl_A">
                                        </tbody>
                                </table>
                            </div>
                        </div>



                    </div>
                    <div id="Stp4RAProbableRsrs_A" class="tab-pane">
                         <div class="pt-1 pb-1" >
                            <div class="row float-start" style="column-count: 4;" id="TopSection_A">
                                <div class="col">
                                    <label class="required">Map Project Role</label>
                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectRole", "usp_Sel_tbl_PM_Role_PopulateCombo", 170, , , True, False, "form-select") %>
                                </div>
                                <div class="col">
                                    <label class="required">Map Resource Status</label>
                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable", 170, , , True, False, "form-select") %>
                                </div>
                                <div class="col">
                                    <label class="">Search By Employee Name</label>
                                    <input type="text" class="form-control" id="employeeName" style="width: 200px;" />
                                </div>
                                <%-- Added by Dipali V on 15th May 2026 - Purpose:-Vendor filter (Close / extended allocation panel probable tab); FillRAVendorDropdown / GetVendorDropdown. --%>
                               <%-- <div class="col">
                                    <label class="">Vendor</label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboVendorProbable_A", "Select ''", 170, , , False, False, "form-select") %>
                                </div>--%>
                              <%--  <div class="col">
                                    <label class="col-sm-12">&nbsp;</label>
                                    <a href="javascript:SearchProbableResources();" class="btn borderbtn">Search</a>
                                </div>--%>
                            </div>
                            <div class="detailsubtabsbtn text-end float-end">
                                 <a href="javascript:SearchProbableResources();" class="btn borderbtn">Search</a>
                                <a href="javascript:GetSearchMore();" class="btn borderbtn mr-5" id="searchMoreProbable_A">Search More</a>
                                <a href="javascript:Allocate_OnClick();" class="btn borderbtn mr-5" id="Allocate_A">Allocate</a>
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                         <div id="divProbableResource_A"></div>
                     
                    </div>
                    
                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <div class="Resourcedetailpanel ResourcedetailpanelChangeAllocation">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs d-none d-lg-flex detailsubtabs">
                    <li class="nav-item"><a href="#Stpdetails_CHANGE" class="nav-link active" data-bs-toggle="tab" id="detail_CHANGE">Details</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp5RASkill_CHANGE" class="nav-link" data-bs-toggle="tab" id="" onclick="GetSkills()" style="display:none">Skills</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp5RAallocatedRsrs_CHANGE" class="nav-link" data-bs-toggle="tab" id="" onclick="GetAllocation()" style="display:none">Allocated Resources</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp5RAsimilarReq_CHANGE" class="nav-link" data-bs-toggle="tab" id="" onclick="GetSimilarRequest()" style="display:none">Similar Requests</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp5RAProbableRsrs_CHANGE" class="nav-link" data-bs-toggle="tab" id="" onclick="GetProbableResources()" style="display:none">Probable Resources</a><div></div>
                    </li>
                    <!--<li class="nav-item"><a href="#Stp1RAcnfgreDays" class="nav-link" data-bs-toggle="tab" id="">Configure Days</a><div></div></li>-->
                    <li class="nav-item"><a href="#Stp5RAProbableRsrs_CHANGE" class="nav-link" data-bs-toggle="tab" id="" onclick="GetExactMatch()" style="display:none">Exact Match</a><div></div>
                    </li>

                </ul>
                <div class="tab-content">

                    <div id="Stpdetails_CHANGE" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <a href="javascript:;" class="btn borderbtn mr-5" id="btnDecline_CHANGE" style="display:none" data-bs-toggle="modal" data-bs-target="#declineModal"><%= MyBase.GetResourceString("C_DECLINE_REQ") %></a>
                            <a href="javascript:;" class="btn borderbtn mr-5" id="btnAllocat_CHANGE" style="display:none" onclick="AllocateRequest('C')">Allocate</a>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> <%= MyBase.GetResourceString("C_MANDATORY") %>)</strong></p>

                        <div class="RAdetailinfo">
                            <table class="informationtbl" style="width: 100%;">
                                <tbody>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_EN") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="lmtname" id="lblCAEmplyeeName"></span></td>


                                        <th><%= MyBase.GetResourceString("C_ASD") %> </th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblCAASD"></span></td>

                                        <th><%= MyBase.GetResourceString("C_AED") %></th>
                                        <td class="colan">:</td>
                                        <td><span id="lblCAAED"></span></td>
                                    </tr>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_AT") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblCAT"></span></td>

                                        <th><%= MyBase.GetResourceString("C_AV") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblCAV"></span></td>

                                        <th ><%= MyBase.GetResourceString("C_WHP") %></th>
                                        <td class="colan">:</td>
                                        <td><span id="lblCWHP"></span></td>
                                    </tr>

                                     <tr>
                                        <th>Type of Requirement</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblchangeTypeOfReq_CHANGE"></span>
                                        </td>


                                        <th>Replacement Employee Name</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblReplacementEmployeeName_CHANGE"></span></td>

                                        <th>No.of Resource</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblNoOfResource_CHANGE"></span></td>
                                    </tr>


                                      <tr>
                                        <th>Department</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblDeparment_CHANGE"></span>
                                        </td>


                                        <th>Location</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblLocation_CHANGE"></span></td>

                                        <th>Engagement Model</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblEngmodel_CHANGE"></span></td>
                                    </tr>

                                       <tr>
                                        <th>Billing Position</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblBillingPosition_CHANGE"></span>
                                        </td>


                                        <th>Billing Start Date</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblBilingStartDate_CHANGE"></span></td>

                                        <th>SOW Available</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblSOWAvailbale_CHANGE"></span></td>
                                    </tr>


                                    <tr>
                                    <td colspan="8">
                                  <div class="attacment-file" style="float:right">
                                        <div class="col-sm-8" style="float:right; padding-left:0" id="DivJDattahcment">
                                              <div class="form-group">
                                                    <div class="input-group col-xs-12">
                                                         <span class="input-group-btn">
                                                            <button class="btn borderbtn" id="btndownloadfile"  type="button" title="Donwload JD Attachments" data-toggle="tooltip" onclick="DownloadJDAttachement();"><i class="fas fa-download" data-toggle="tooltip" data-placement="top" data-container="body" data-original-title="Download"></i> <span id="FILENAME_CHANGE" class="jd-filename" title=""></span></button>
                                                         </span>
                                                       </div>
                                                   </div>
                                     </div>
                                  </div>
                                        </td>
                                  </tr>
                                </tbody>
                            </table>
                        </div>
                        <hr />
                        <div id="TabsChangeDetails">
                        <%--<h5><%= MyBase.GetResourceString("C_PRDETAILS") %></h5>--%>
                        <h5>Change Allocation Details</h5>
                        <div class="form-group mb-2">
                            <div class="row row-cols-sm-auto">
                             <%--   <div class="col-sm-3">
                                    <label class="required">New End Date</label>
                                    <div class="input-group">

                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtInputnewHrsPerdayDate", "txtInputnewHrsPerdayDate", "form-control",,,,,, ,,,, "' autocomplete='Off' maxlength='100' ",,, True,,,,) %>

                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>--%>

                                 <div class="col-sm-3">
                                    <%--<label>New % Of Day</label>--%>
                                     <label id="IDchangeAllocation"></label>
                                    <div class="row">
                                        <div class="col-sm-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtNewHrsPerDay_CHANGE", "txtNewHrsPerDay_CHANGE", "form-control",,,,,, ,,, True, "' autocomplete='Off' maxlength='100' disabled",,, True,,,,) %>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtDisplayNewHrsPerDay_CHANGE", "txtDisplayNewHrsPerDay_CHANGE", "form-control",,,,,, ,,,, "' autocomplete='Off' maxlength='100' disabled",,, True,,,,) %>
                                        </div>
                                        <div class="col-sm-2"><span class="spntype"></span></div>
                                    </div>
                                </div>
                            <%--    <div class="col-sm-8">
                                    <label class="" style="display: block;">&nbsp;</label>
                                    <strong>If you want to change allocation, please enter following details</strong>
                                </div>--%>

                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="form-group mb-2">
                            <div class="row row-cols-sm-auto">
                             <%--   <div class="col-sm-3">
                                    <label>New Allocation</label>
                                    <div class="row">
                                        <div class="col-sm-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtinputNewHrsPerDay", "txtinputNewHrsPerDay", "form-control",,,,,, ,,,, "' autocomplete='Off' maxlength='100' ",,, True,,,,) %>
                                        </div>
                                        <div class="col-sm-2">Hrs/Day</div>
                                    </div>
                                </div>--%>
                                <div class="col-sm-3">
                                    <label class="required">New Effective Date</label>
                                    <div class="input-group">

                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtInputEffectivePerday", "txtInputEffectivePerday", "form-control",,,,,, ,,,, "' autocomplete='Off' maxlength='100' disabled",,, True,,,,) %>

                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <label class="">&nbsp;</label>
                                    <div>
                                        <label class="">New Work Hours :</label>
                                        <span id="lblNewTotalWorkHours" style="display:none"></span>
                                        <span id="lblNewTotalWorkHours1"></span>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label>Special Request</label>
                                    <% CommonFunctions.HTMLControls.DrawTextArea("txtCSecipalReq", "txtCSecipalReq", , "form-control", , , , , , , , , , , ,, , , " data-autoresize ", , )%>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>

                        <hr />
                       <%-- <div class="text-end">
                            <button class="btn btnyellow mr-5" id=""><%= MyBase.GetResourceString("C_Save") %></button>
                        </div>
                        <h6><strong>Configure Days</strong><span class="validto">(Request Valid to)</span></h6>
                        <p>Number of days after which resources should be made available if not assigned to any project.</p>--%>

                     <%--   <div class="form-inline">
                            <div class="form-group">
                                <label class="required">Resource request validity Days</label>
                                <input type="text" class="form-control" value="0" style="width: 100px; display: inline-block;" />
                            </div>
                        </div>--%>
                       </div>
                    </div>
                    <div id="Stp5RASkill_CHANGE" class="tab-pane" style="width: 100%;">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <table id="RASkillTbl_CHANGE" class="table table-stripped table-bordered clsRAskillTbl" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Skills</th>
                                            <th>Experience(Years)</th>
                                            <th>Experience(Months)</th>
                                            <th>Proficiency</th>
                                            <th>Core Competency</th>
                                        </tr>
                                    </thead>
                                    <tbody id="RASkillTableBody_CHANGE">
                                    
                                    </tbody>
                                </table>
                            </div>
                           <div class="col-sm-6">
                                <table class="table skillgraphTbl">
                                    <thead>
                                        <tr>
                                            <th>Skills</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="skillsetChartcontainer">
                                                    <canvas id="SkillChartTab_CHANGE"></canvas>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>


                            </div>
                        </div>


                    </div>
                    <div id="Stp5RAallocatedRsrs_CHANGE" class="tab-pane">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>

                        <table id="RAllocatedResource_CHANGE" class="table table-stripped table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>Assignment Date</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Work Hours</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyRAllocatedResource_CHANGE">
                        
                            </tbody>
                        </table>

                    </div>
                    <div id="Stp5RAsimilarReq_CHANGE" class="tab-pane">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <span class="clsnote"> Note :- List of Request will display with respective of skill not core competency</span>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-sm-8">
                                <table id="RAsimilarReqTbl_CHANGE" class="table table-bordered table-stripped clsRAsimilarReqTbl" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Request ID</th>
                                            <th>Project</th>
                                            <th>Request Details</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyRAsimilarReqTbl_CHANGE">
                                       
                                    </tbody>
                                </table>
                            </div>
                        </div>



                    </div>
                    <div id="Stp5RAProbableRsrs_CHANGE" class="tab-pane">
                        <div class="pt-1 pb-1">
                            <div class="row float-start" style="column-count: 4;">
                                <div class="col">
                                    <label class="required">Map Project Role</label>
                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectRole", "usp_Sel_tbl_PM_Role_PopulateCombo", 170, , , True, False, "form-select") %>
                                </div>
                                <div class="col">
                                    <label class="required">Map Resource Status</label>
                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable", 170, , , True, False, "form-select") %>
                                </div>
                                <div class="col">
                                    <label class="">Search By Employee Name</label>
                                    <input type="text" class="form-control" id="employeeName" style="width: 200px;" />
                                </div>
                                <%-- Added by Dipali V on 15th May 2026 - Purpose:-Vendor filter (Change allocation panel probable tab); FillRAVendorDropdown / GetVendorDropdown. --%>
                                <%--<div class="col">
                                    <label class="">Vendor</label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboVendorProbable_CHANGE", "Select ''", 170, , , False, False, "form-select") %>
                                </div>--%>
                            </div>
                            <div class="detailsubtabsbtn text-end float-end">
                                 <a href="javascript:SearchProbableResources();" class="btn borderbtn">Search</a>
                                <a href="javascript:GetSearchMore();" class="btn borderbtn mr-5" id="searchMoreProbable_CHANGE">Search More</a>
                                <a href="javascript:Allocate_OnClick();" class="btn borderbtn mr-5" id="">Allocate</a>
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div id="divProbableResource_CHANGE"></div>
                     

                    </div>
                   
                </div>
            </div>
        </div>

        <div class="Resourcedetailpanel Resourcedetailpanel9">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs d-none d-lg-flex detailsubtabs">
                    <li class="nav-item"><a href="#Stp9RBGdetails" class="nav-link active" data-bs-toggle="tab" id=""><%= MyBase.GetResourceString("C_ASSIGNED") %></a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp9RASkill" class="nav-link" data-bs-toggle="tab" id="">Skills</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp9RAallocatedRsrs" class="nav-link" data-bs-toggle="tab" id="">Allocated Resources</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp9RAsimilarReq" class="nav-link" data-bs-toggle="tab" id="">Similar Requests</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp9RAProbableRsrs" class="nav-link" data-bs-toggle="tab" id="">Probable Resources</a><div></div>
                    </li>
                    <!--<li class="nav-item"><a href="#Stp1RAcnfgreDays" class="nav-link" data-bs-toggle="tab" id="">Configure Days</a><div></div></li>-->
                    <li class="nav-item"><a href="#Stp9exactmatch" class="nav-link" data-bs-toggle="tab" id="">Exact Match</a><div></div>
                    </li>

                </ul>
                <div class="tab-content">

                    <div id="Stp9RBGdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <a href="javascript:;" class="btn borderbtn mr-5" id="" data-bs-toggle="modal" data-bs-target="#declineModal"><%= MyBase.GetResourceString("C_DECLINE_REQ") %></a>
                            <a href="javascript:;" class="btn borderbtn mr-5 btnescalteBG_Replace" id=""  onclick="Esclateion(1,'btnescalteBG')"><%= MyBase.GetResourceString("C_ETOBP") %></a>
                            <a href="javascript:;" class="btn borderbtn mr-5 btnescalteOU_Replace" style="display:none"  onclick="Esclateion(2,'btnescalteOU')"><%= MyBase.GetResourceString("C_ETOBP") %></a>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> <%= MyBase.GetResourceString("C_MANDATORY") %>)</strong></p>

                        <div class="RAdetailinfo">
                            <table class="informationtbl" style="width: 100%;">
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <hr />
                        <div class="text-end">
                            <button class="btn btnyellow mr-5"  onclick="SaveConfigureDays()" id="btnConfigure_9">Save</button>
                        </div>
                        <h6><strong>Configure Days</strong><span class="validto">(Request Valid to)</span></h6>
                        <p>Number of days after which resources should be made available if not assigned to any project.</p>

                        <div class="form-inline">
                            <div class="form-group">
                                <label class="required">Resource request validity Days</label>
                                <input type="text" class="form-control" value="0" style="width: 100px; display: inline-block;" />
                            </div>
                        </div>

                    </div>
                    <div id="Stp9RASkill" class="tab-pane" style="width: 100%;">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <table id="RASkillTbl" class="table table-stripped table-bordered clsRAskillTbl" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Skills</th>
                                            <th>Experience(Years)</th>
                                            <th>Experience(Months)</th>
                                            <th>Proficiency</th>
                                            <th>IsCoreCompetency</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-sm-6">
                                <table class="table skillgraphTbl">
                                    <thead>
                                        <tr>
                                            <th>Skills</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="skillsetChartcontainer">
                                                    <canvas id="SkillChart"></canvas>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>


                            </div>
                        </div>


                    </div>
                    <div id="Stp9RAallocatedRsrs" class="tab-pane">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>

                        <table id="RAallocatedRsrsTbl" class="table table-stripped table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>Assignment Date</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Work Hours</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                               
                            </tbody>
                        </table>

                    </div>
                    <div id="Stp9RAsimilarReq" class="tab-pane">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <span class="clsnote"> Note :- List of Request will display with respective of skill not core competency</span>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-sm-8">
                                <table id="RAsimilarReqTbl" class="table table-bordered table-stripped clsRAsimilarReqTbl" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Project</th>
                                            <th>Request Details</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>



                    </div>
                    <div id="Stp9RAProbableRsrs" class="tab-pane">
                        <div class="pt-1 pb-1">
                            <div class="row float-start" style="column-count: 3;">
                                <div class="col">
                                    <label class="required">Map Project Role</label>
                                  
                                </div>
                                <div class="col">
                                    <label class="required">Map Resource Status</label>
                                  
                                </div>
                                <div class="col">
                                    <label class="">Search By Employee Name</label>
                                    <input type="text" class="form-control" style="width: 200px;" />
                                </div>
                                <div class="col">
                                    <label class="col-sm-12">&nbsp;</label>
                                    <a href="javascript:;" class="btn borderbtn">Search</a>
                                </div>
                            </div>
                            <div class="detailsubtabsbtn text-end float-end">
                                <a href="javascript:;" class="btn borderbtn mr-5" id="" data-bs-toggle="modal" data-bs-target="#searchmoreModal">Search More</a>
                                <a href="javascript:;" class="btn borderbtn mr-5" id="">Allocate</a>
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <table id="Stp9probableRsrsInfoTbl" class="table table-bordered ClsprobableinfoTbl" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>BG/OU</th>
                                    <th>Role</th>
                                    <th>Total Free Hrs</th>
                                    <th>Free Hrs Day</th>
                                    <th>Free%</th>
                                    <th class='CaptionType'>Max Free%</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Work hrs(%)</th>
                                    <th>Allocate</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                                    
                            </tbody>
                        </table>

                    </div>
                    <div id="Stp9exactmatch" class="tab-pane">
                        <div class="pt-1 pb-1">
                            <div class="row float-start" style="column-count: 3;">
                                <div class="col">
                                    <label class="required">Map Project Role</label>
                                   
                                </div>
                                <div class="col">
                                    <label class="required">Map Resource Status</label>
                                  
                                </div>
                                <div class="col">
                                    <label class="">Search By Employee Name</label>
                                    <input type="text" class="form-control" style="width: 200px;" />
                                </div>
                                <div class="col">
                                    <label class="col-sm-12">&nbsp;</label>
                                    <a href="javascript:;" class="btn borderbtn">Search</a>
                                </div>
                            </div>
                            <div class="detailsubtabsbtn text-end float-end">

                                <a href="javascript:;" class="btn borderbtn mr-5" id="">Allocate</a>
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <table id="Stp9exactmatchInfoTbl" class="table table-bordered ClsprobableinfoTbl" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>BG/OU</th>
                                    <th>Role</th>
                                    <th>Total Free Hrs</th>
                                    <th>Free Hrs Day</th>
                                    <th>Free%</th>
                                    <th class='CaptionType'>Max Free%</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Work hrs(%)</th>
                                    <th>Allocate</th>
                                </tr>
                            </thead>
                            <tbody>
                               
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div>

        <div class="Resourcedetailpanel Resourcedetailpanel10">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs d-none d-lg-flex detailsubtabs">
                    <li class="nav-item"><a href="#Stp10RBGdetails" class="nav-link active" data-bs-toggle="tab" id=""><%= MyBase.GetResourceString("C_ASSIGNED") %></a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp10RASkill" class="nav-link" data-bs-toggle="tab" id="">Skills</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp10RAallocatedRsrs" class="nav-link" data-bs-toggle="tab" id="">Allocated Resources</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp10RAsimilarReq" class="nav-link" data-bs-toggle="tab" id="">Similar Requests</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#Stp10RAProbableRsrs" class="nav-link" data-bs-toggle="tab" id="">Probable Resources</a><div></div>
                    </li>
                    <!--<li class="nav-item"><a href="#Stp1RAcnfgreDays" class="nav-link" data-bs-toggle="tab" id="">Configure Days</a><div></div></li>-->
                    <li class="nav-item"><a href="#Stp10exactmatch" class="nav-link" data-bs-toggle="tab" id="">Exact Match</a><div></div>
                    </li>

                </ul>
                <div class="tab-content">

                    <div id="Stp10RBGdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <a href="javascript:;" class="btn borderbtn mr-5" id="" data-bs-toggle="modal" data-bs-target="#declineModal"><%= MyBase.GetResourceString("C_DECLINE_REQ") %></a>
                            <a href="javascript:;" class="btn borderbtn mr-5 btnescalteBG_NBD" id=""  onclick="Esclateion(1,'btnescalteBG')"><%= MyBase.GetResourceString("C_ETOBP") %></a>
                            <a href="javascript:;" class="btn borderbtn mr-5 btnescalteOU_NBD" style="display:none"  onclick="Esclateion(2,'btnescalteOU')"><%= MyBase.GetResourceString("C_ETOBP") %></a>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> <%= MyBase.GetResourceString("C_MANDATORY") %>)</strong></p>

                        <div class="RAdetailinfo">
                            <table class="informationtbl" style="width: 100%;">
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <hr />
                        <div class="text-end">
                            <button class="btn btnyellow mr-5"  onclick="SaveConfigureDays()" id="btnConfigure_10">Save</button>
                        </div>
                        <h6><strong>Configure Days</strong><span class="validto">(Request Valid to)</span></h6>
                        <p>Number of days after which resources should be made available if not assigned to any project.</p>

                        <div class="form-inline">
                            <div class="form-group">
                                <label class="required">Resource request validity Days</label>
                                <input type="text" class="form-control" value="0" style="width: 100px; display: inline-block;" />
                            </div>
                        </div>

                    </div>
                    <div id="Stp10RASkill" class="tab-pane" style="width: 100%;">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <table id="RASkillTbl" class="table table-stripped table-bordered clsRAskillTbl" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Skills</th>
                                            <th>Experience(Years)</th>
                                            <th>Experience(Months)</th>
                                            <th>Proficiency</th>
                                            <th>IsCoreCompetency</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-sm-6">
                                <table class="table skillgraphTbl">
                                    <thead>
                                        <tr>
                                            <th>Skills</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="skillsetChartcontainer">
                                                    <canvas id="SkillChart"></canvas>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>


                            </div>
                        </div>


                    </div>
                    <div id="Stp10RAallocatedRsrs" class="tab-pane">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>

                        <table id="RAallocatedRsrsTbl" class="table table-stripped table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>Assignment Date</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Work Hours</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                               
                            </tbody>
                        </table>

                    </div>
                    <div id="Stp10RAsimilarReq" class="tab-pane">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <span class="clsnote"> Note :- List of Request will display with respective of skill not core competency</span>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-sm-8">
                                <table id="RAsimilarReqTbl" class="table table-bordered table-stripped clsRAsimilarReqTbl" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Project</th>
                                            <th>Request Details</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>



                    </div>
                    <div id="Stp10RAProbableRsrs" class="tab-pane">
                        <div class="pt-1 pb-1">
                            <div class="row float-start" style="column-count: 3;">
                                <div class="col">
                                    <label class="required">Map Project Role</label>
                                  
                                </div>
                                <div class="col">
                                    <label class="required">Map Resource Status</label>
                                    
                                </div>
                                <div class="col">
                                    <label class="">Search By Employee Name</label>
                                    <input type="text" class="form-control" style="width: 200px;" />
                                </div>
                                <div class="col">
                                    <label class="col-sm-12">&nbsp;</label>
                                    <a href="javascript:;" class="btn borderbtn">Search</a>
                                </div>
                            </div>
                            <div class="detailsubtabsbtn text-end float-end">
                                <a href="javascript:;" class="btn borderbtn mr-5" id="" data-bs-toggle="modal" data-bs-target="#searchmoreModal">Search More</a>
                                <a href="javascript:;" class="btn borderbtn mr-5" id="">Allocate</a>
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <table id="Stp1probableRsrsInfoTbl" class="table table-bordered ClsprobableinfoTbl" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>BG/OU</th>
                                    <th>Role</th>
                                    <th>Total Free Hrs</th>
                                    <th>Free Hrs Day</th>
                                    <th>Free%</th>
                                    <th class='CaptionType'>Max Free%</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Work hrs(%)</th>
                                    <th>Allocate</th>
                                </tr>
                            </thead>
                            <tbody>
                               
                            </tbody>
                        </table>

                    </div>
                    <div id="Stp10exactmatch" class="tab-pane">
                        <div class="pt-1 pb-1">
                            <div class="row float-start" style="column-count: 3;">
                                <div class="col">
                                    <label class="required">Map Project Role</label>
                                   
                                </div>
                                <div class="col">
                                    <label class="required">Map Resource Status</label>
                                   
                                </div>
                                <div class="col">
                                    <label class="">Search By Employee Name</label>
                                    <input type="text" class="form-control" style="width: 200px;" />
                                </div>
                                <div class="col">
                                    <label class="col-sm-12">&nbsp;</label>
                                    <a href="javascript:;" class="btn borderbtn">Search</a>
                                </div>
                            </div>
                            <div class="detailsubtabsbtn text-end float-end">

                                <a href="javascript:;" class="btn borderbtn mr-5" id="">Allocate</a>
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <table id="Stp1exactmatchInfoTbl" class="table table-bordered ClsprobableinfoTbl" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>BG/OU</th>
                                    <th>Role</th>
                                    <th>Total Free Hrs</th>
                                    <th>Free Hrs Day</th>
                                    <th>Free%</th>
                                    <th class='CaptionType'>Max Free%</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Work hrs(%)</th>
                                    <th>Allocate</th>
                                </tr>
                            </thead>
                            <tbody>
                              
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div>
        <!--Detail Section End here-->

      

         <div class="Resourcedetailpanel ResourcedetailpanelClose">
            <div class="pgdetailinner" id="subtabs">
                <ul class="nav nav-tabs d-none d-lg-flex detailsubtabs">
                    <li class="nav-item"><a href="#StpCloseGdetails" class="nav-link active" data-bs-toggle="tab" id="detailClose">Details</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#StpCloseSkill" onclick="GetSkills()" class="nav-link" data-bs-toggle="tab" id="">Skills</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#StpCloseallocatedRsrs" onclick="GetAllocation()" class="nav-link" data-bs-toggle="tab" id="">Allocated Resources</a><div></div>
                    </li>
               </ul>
                 <div class="tab-content">

                    <div id="StpCloseGdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                              <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> <%= MyBase.GetResourceString("C_MANDATORY") %>)</strong></p>

                        <div class="RAdetailinfo">
                            <table class="informationtbl" style="width: 100%;">
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <hr />
                        <div class="text-end">
                            <button class="btn btnyellow mr-5"  onclick="SaveConfigureDays()" id="btnConfigure_10">Save</button>
                        </div>
                        <h6><strong>Configure Days</strong><span class="validto">(Request Valid to)</span></h6>
                        <p>Number of days after which resources should be made available if not assigned to any project.</p>

                        <div class="form-inline">
                            <div class="form-group">
                                <label class="required">Resource request validity Days</label>
                                <input type="text" class="form-control" value="0" style="width: 100px; display: inline-block;" />
                            </div>
                        </div>

                    </div>
                    <div id="StpCloseSkill" class="tab-pane" style="width: 100%;">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <table id="RASkillTbl" class="table table-stripped table-bordered clsRAskillTbl" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Skills</th>
                                            <th>Experience(Years)</th>
                                            <th>Experience(Months)</th>
                                            <th>Proficiency</th>
                                            <th>IsCoreCompetency</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-sm-6">
                                <table class="table skillgraphTbl">
                                    <thead>
                                        <tr>
                                            <th>Skills</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="skillsetChartcontainer">
                                                    <canvas id="SkillChart"></canvas>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>


                            </div>
                        </div>


                    </div>
                    <div id="StpCloseallocatedRsrs" class="tab-pane">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_CANCEL1") %></button>
                        </div>

                        <table id="RAallocatedRsrsTbl" class="table table-stripped table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>Assignment Date</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Work Hours</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                               
                            </tbody>
                        </table>

                    </div>
              
                </div>
            </div>
        </div>






        <!-- Search More Modal start here-->
        <div class="modal custmodal fade" id="searchmoreModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Assign Requested Resources</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                         <div class="pb-3">
                                    <small style="color:red;"><strong><%= MyBase.GetResourceString("C_Note") %></strong></small>
                          </div>
                        <div class="float-end">
                            <%--<button type="button" onclick="GetProbableResourcesSearchMore('R');" class="btn btnyellow mr-5" id="">Search</button>--%>
                             <button type="button" onclick="SearchMore();" class="btn btnyellow mr-5" id="">Search</button>
                            <button type="button" onclick="Allocate_OnClick(1);" class="btn btnyellow mr-5" id="">Allocate</button>
                        </div>
                        <div class="ARRinfo">
                            <div class="row" id="divRequestInfo">
                                <div class="col-sm-6 ">
                                    <p><strong>Project :</strong><span id="searchmoreprojectname"></span></p>
                                    <p><strong>Role :</strong> <span id="searchmoreRole"></span></p>
                                    <p><strong id="labelWorkHours">Total Work Hours :</strong> <span id="searchmoreTotalWorkHours"></span> </p>
                                </div>
                                <div class="col-sm-6 ">
                                    <p><strong>Requested :</strong> <span id="searchmoreRequested"></span></p>
                                    <p><strong>Assigned :</strong> <span id="searchmorepAssigned"></span></p>
                                    
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="ARRActions container-fluid">
                            <div class="row">
                                <div class="form-group mb-3">
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <label class="required">Role :</label>
                                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_Sel_tbl_PM_ProjectRoles_New", , , , True, True, "form-select") %>
                                        </div>
                                        <div class="col-sm-4">
                                            <label class="">From Date :</label>
                                            <div class="input-group">
                                                <input id="txtFromDate" class="form-control input-sm datetimepicker" type="text">
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button" style="height: 30px;"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <label class="">To Date :</label>
                                            <div class="input-group">
                                                <input id="txtToDate" class="form-control input-sm datetimepicker" type="text">
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button" style="height: 30px;"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group mb-3">
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <label class="control-label" style="display: block;">Select Type :</label>
                                            <% If IsConfigureAllocationType = False Then %>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="optType" id="optPerDay" checked value="<%=TYPE_HPD %>">
                                                        Per Day
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="optType" id="optTotalWorkHour" value="<%=TYPE_TH %>">
                                                        Total Hours
                                                    </label>
                                                </div>
                                            <%End If%>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="optType" id="optPercent" value="<%=TYPE_P %>">
                                                    % of Day
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <label class="" id="labelWorkHoursSearch">Work Hours :</label>
                                            <input type="text" class="form-control" id="txtshowHours_1" />
                                             <input type="hidden" class="form-control" id="txtHours_1" />
                                        </div>
                                        <div class="col-sm-4">
                                            <label class="">Vendor :</label>
                                            <%--<% 'Added by Dipali V on 7th May 2026 - Purpose:-Place vendor filter near Work Hours in Search More modal. %>--%>
                                            <%-- Added by Dipali V on 15th May 2026 - Purpose:-Search More vendor filter; options loaded via FillRAVendorDropdown (same as PM_RequestedResources FillRequestVendorDropdown). --%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboVendor_1", "Select ''", , , , False, False, "form-select") %>
                                        </div>
                                    </div>

                                    <div class="clearfix"></div>
                                </div>

                            </div>
                        </div>

                        <div class="panel DivProSkills">
                            <h5>Project Skill : </h5>
                            <div class="table-responsive" id="divSkills">
                            </div>
                        </div>
                        <%-- Added by Dipali V on 7th May 2026 - Purpose:-Keep Search More filters aligned in 2 controls per row with equal widths. --%>
                        <div class="row g-2 align-items-end">
                            <div class="col-md-5">
                                <label class="required">Map Project Role</label>
                                <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectRole_1", "usp_Sel_tbl_PM_Role_PopulateCombo", , , , True, False, "form-select") %>
                            </div>
                            <div class="col-md-5">
                                <label class="required">Map Resource Status</label>
                                <%CommonFunctions.HTMLControls.DrawComboBox("cboStatus_1", "usp_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable", , , , True, False, "form-select") %>
                            </div>
                        </div>
                        <div class="row g-2 align-items-end mt-1">
                            <div class="col-md-5">
                                <label class="">Search By Employee Name</label>
                                <input type="text" class="form-control" id="employeeName_1" />
                            </div>
                            <div class="col-md-2 d-grid">
                                <label class="d-block">&nbsp;</label>
                                <%--<a href="javascript:GetProbableResourcesSearchMore('R');" class="btn borderbtn">Search</a>--%>
                                <a href="javascript:SearchMore();" class="btn borderbtn">Search</a>
                            </div>
                        </div>
                        <div class="panel DivSrchResult mt-3">
                            <h5 class="mb-0">Search Result : </h5>
                            <div class="table-responsive" id="divProbableResourceSearchMore">
                            </div>
                            <div id="pagination">
                            </div>
                        </div>


                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Search More Modal End here-->
        <!-- Declinew request Modal start here-->
        <div class="modal custmodal fade" id="declineModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_DECLINE_REQ") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-0">
                            <div class="row">
                                <div class="col-md-12 row">
                                    <label class="control-label col-md-4 p-0 text-end required"><%= MyBase.GetResourceString("C_COMMENTS") %> :</label>
                                    <span class="col-md-8">
                                        <% CommonFunctions.HTMLControls.DrawTextArea("txtDeclineComments", "txtDeclineComments", , "form-control", , , , , , , , , , , ,, , , " data-autoresize ", , )%>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <br />

                        <div class="form-group mb-0">
                            <div class="row">
                                <div class="col-md-12 row">
                                    <label class="control-label col-md-4 p-0 text-end">&nbsp;</label>
                                    <span class="col-md-8">
                                        <button id="" class="btn btnyellow" onclick="Decline_Request()"><%= MyBase.GetResourceString("C_DECLINE_REQ") %></button>
                                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%= MyBase.GetResourceString("C_CLOSE") %></button>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Declinew request Modal End here-->
        <!-- Resource Request Escalation to GRP Modal start here-->
        <div class="modal custmodal fade" id="EscalationGRPModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Resource Request Escalation to GRP</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-0">
                            <div class="row">
                                <div class="col-md-12 row">
                                    <label class="control-label col-md-4 p-0 text-end">Escalation Comments :</label>
                                    <span class="col-md-8">
                                        <textarea class="form-control"></textarea>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="form-group mb-0">
                            <div class="row">
                                <div class="col-md-12 row">
                                    <label class="control-label col-md-4 p-0 text-end">&nbsp;</label>
                                    <span class="col-md-8">
                                        <button id="" class="btn borderbtn">Send</button>
                                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn">Close</button>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Resource Request Escalation to GRP Modal End here-->
        <!-- Resource Request Escalation to BG Pool Modal start here-->
        <div class="modal custmodal fade" id="EscalationBGPoolModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title clsBGEsclationheader" >Resource Request Escalation to BG Pool</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-0">
                            <div class="row">
                                <div class="col-md-12 row">
                                    <label class="control-label col-md-4 p-0 text-end">Escalation Comments :</label>
                                    <span class="col-md-8">
                                        <textarea class="form-control" aria-autocomplete="none" id="txtEscalationComments"></textarea>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="form-group mb-0">
                            <div class="row">
                                <div class="col-md-12 row">
                                    <label class="control-label col-md-4 p-0 text-end">&nbsp;</label>
                                    <span class="col-md-8">
                                        <button  class="btn borderbtn" onclick="Escalation_Onclick()" id="btnEscalation">Send</button>
                                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn">Close</button>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Resource Request Escalation to GRP Modal End here-->
        
        <!--View Comment modal-->
        <div class="modal custmodal fade" id="commentmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_COMMENTS") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <div class="form-group">
                            <label class="required"><%= MyBase.GetResourceString("C_COMMENTS") %></label>
                            <% CommonFunctions.HTMLControls.DrawTextArea("txtcomments", "txtcomments", , "form-control", , , , , , , , , , , ,, , , " data-autoresize ", , )%>
                        </div>


                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--End View comment modal-->
    <!--confrimation modal start here -->
            <div class="modal custmodal fade" id="confirmationmodal" aria-hidden="true" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="HResourceSite">Confirmation Alert</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>"You can not Prepone release this resource with Extra Hrs requirement as Resource is not free"</p>
                            <br />
                            <br />
                            <p id="AlertMsg"></p>
                            <br />
                            <div class="text-center">
                                <a href="javascript:;" data-bs-dismiss="modal" class="btn btnyellow">OK</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



        <div class="clearfix"></div>
    </div>


    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <%-- <script src="../../../Whizible2.0-new/dist/js/jquery.simplePagination.js"></script>--%>
    <!--chart js-->
    <script src="../../../Whizible2.0-new/plugins/chartjs/chart.min.js"></script>
    <script src="../../General/CommonValidations.js?v=2"></script>
    <!--Added for loader-->
    <!-- custome js -->
  <%--  <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="General/Common.js?v=1"></script>
    <script>
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-resource").ToString%>'
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        /* App virtual root e.g. /W26_NewDev — used to build absolute file hrefs */
        var strAppRoot = '<%=Request.ApplicationPath.TrimEnd("/")%>';
        alertify.set('notifier', 'position', 'top-right');
        var UserID = '<%=Session("intUserID")%>';
        $(document).ready(function () {
            GetYears();
            GetMonths();
            GetRatings();
            $('#txtToday').datepicker('setDate', new Date());
        })
        function editRA1() {
            $(".Resourcedetailpanel").hide();
            $(".Resourcedetailpanel1").show();

            //used for disable grid
            $(".content .dataTables_wrapper .dataTables_scrollBody, .main_graybgtbs, .content .dataTables_wrapper, .rsralocationfltrs, .backbtn, .addbtn, .content .dataTables_wrapper .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel1").offset().top - 60
            }, 'slow');

        }//end function


        function editRA9() {
            $(".Resourcedetailpanel").hide();
            $(".Resourcedetailpanel9").show();
            //used for disable grid
            $(".content .dataTables_wrapper .dataTables_scrollBody, .main_graybgtbs, .content .dataTables_wrapper, .rsralocationfltrs, .backbtn, .addbtn, .content .dataTables_wrapper .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel9").offset().top - 60
            }, 'slow');

        }//end function
        function editRA10() {
            $(".Resourcedetailpanel").hide();
            $(".Resourcedetailpanel10").show();
            //used for disable grid
            $(".content .dataTables_wrapper .dataTables_scrollBody, .main_graybgtbs, .content .dataTables_wrapper, .rsralocationfltrs, .backbtn, .addbtn, .content .dataTables_wrapper .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel10").offset().top - 60
            }, 'slow');

        }//end function


        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
             fromDateGlobal = "";
            toDateGlobal = "";
            BGPoolEscalationComments = "";
            OUPoolEscalationComments = "";
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            clearFieldsSearchMore();
            clearFieldsProbable();
            $(".content .dataTables_wrapper .dataTables_scrollBody, .main_graybgtbs, .content .dataTables_wrapper, .rsralocationfltrs, .backbtn, .addbtn, .content .dataTables_wrapper .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
           // debugger;
            //const context = canvas.getContext('2d');
            //var ctx = document.getElementById("SkillChartTab").getContext('2d');
            //ctx.clearRect(0, 0, canvas.width, canvas.height);
        });

        var GlobalRequeststartDate = "";
        var GlobalRequestEndDate = "";
        $(document).ready(function () {
            $(".resrsAllocationListTbl").resize();
            $("body").tooltip({ selector: '[data-toggle=tooltip]' });
            $("#txtPrevAllocationPercentage").val('<%=ResourceAllocationSettingValue%>');
            Gettabs();
            GetCurrentFinalcialYear();
            GetSkillGraph();
            GetRequestDetails('R');
            // Added by Dipali V on 13th May 2026 - Purpose:-Align "Select Vendor" label on Probable tab vendor combos after page load.
            SetVendorSearchPlaceholder();
        });

        $('.clsRAskillTbl').DataTable({
            "scrollY": '30vh',
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true

        });

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        $('#profiencyListTbl').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".accordion-item .table-bordered").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".accordion-item .table-bordered").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table.ClsprobableinfoTbl").resize();
            $($.fn.dataTable.tables(true)).css('width', '100%');
            $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
            //editRA();
        });
        $('.main_graybgtbs.nav-tabs>li>a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {

            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $(".dataTables_wrapper .dataTables_scrollBody, .dataTables_wrapper, .rsralocationfltrs, .backbtn, .addbtn, .dataTables_wrapper .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('#RsrsSelctionTble_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 380, "overflow-y": "auto" });
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

        function Gettabs() {
            var EmployeeID = "";
            var ResourcesDetails = {
                EmployeeID: '<%= Session("intUserID") %>'
            }
            var param = JSON.stringify(ResourcesDetails);
            var strResult = AJAXCallWithResult("/api/RMResourceAllocation/GettabsDetails", param, false);
            var Strextendhtml = "";
            $("#tabs").html('');
            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {
                    //debugger;
                    var strClass = "";
                    if (strResult[i].RequestID == "R") {
                        strClass = "active";
                    }
                    if (strResult[i].RequestID == "O" || strResult[i].RequestID == "R" || strResult[i].RequestID == "A"
                        || strResult[i].RequestID == "E" || strResult[i].RequestID == "P" || strResult[i].RequestID == "CHANGE" || strResult[i].RequestID == "Replace" || strResult[i].RequestID == "NBD" || strResult[i].RequestID == "ESCALATE") {
                        Strextendhtml += '<li class="nav-item"><a href="#RsrallocateTab_' + strResult[i].RequestID + '" class="nav-link ' + strClass + '" data-bs-toggle="tab" onclick=GetRequestDetails("' + strResult[i].RequestID + '")>' + strResult[i].RequestType + '</a></li>';
                    }
                    else {
                        Strextendhtml += '<li class="nav-item"><a href="#RsrallocateTab_' + strResult[i].RequestID + '" class="nav-link" data-bs-toggle="tab" onclick=GetRequestDetails("' + strResult[i].RequestID + '")>' + strResult[i].RequestType + '</a></li>';

                    }
                }
            }
            $("#tabs").html(Strextendhtml);
        }


        function GetCurrentFinalcialYear() {

            var strResult = AJAXCallWithResult("/api/RMResourceAllocation/GetCurrentFinalcialYear", '', false);
            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {
                   // debugger;
                    $("#TxtRequestExtendFromDate").val(strResult[i].StartDate);
                    $("#TxtRequestExtendToDate").val(strResult[i].EndDate);
                     GlobalRequeststartDate = strResult[i].StartDate;
                    GlobalRequestEndDate = strResult[i].EndDate;

                    //$("#TxtRequestExtendFromDate").val('01 Apr 2022');
                    //$("#TxtRequestExtendToDate").val('31 Mar 2024');
                    //GlobalRequeststartDate = '01 Apr 2022';
                    //GlobalRequestEndDate = '31 Mar 2024';
                   
                    
                }

            }
        }

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

        //datepicker
        $('#rqstFrmDate, #TxtRequestExtendFromDate, #rqstFrmDate3, #rqstFrmDate4, #rqstFrmDate5, #rqstFrmDate6, #rqstFrmDate7, #rqstFrmDate8, #rqstFrmDate9, #rqstToDate, #TxtRequestExtendToDate, #rqstToDate3, #rqstToDate4, #rqstToDate5, #rqstToDate6, #rqstToDate7, #rqstToDate8, #rqstToDate9, #ProbablersrFrmDate, #ProbablersrsToDate, #ARRFrmDate, #ARRToDate, #txtInputnewHrsPerdayDate, #InputEffectivePerday, #txtInputEffectivePerday, #Step6InputEffectivePerday,#txtEEffectivePerday,#txtENewEndday,#txtNewEndday,#txtEffectivePerday_P,#txtToday').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd M yy'
        });

        // Get skill tab
        function GetSkills() {
            
            var param = JSON.stringify(encodeURI(GRequestID))
            var data = AJAXCallWithResult("/api/RMResourceAllocation/GetSkills", param, false);
          //debugger;
            var strHTML = "";
            if (data != null) {

                for (var i = 0; i < data.length; i++) {

                    var descrption = "";
                    var ExpYrs = "";
                    var ExpMonths = "";
                    var ParameterValue = "";

                    var IsCoreCompetency = data[i]["IsCoreCompetency"];
                    
				    if(IsCoreCompetency == true)
				    {
					 	IsCoreCompetency = "Yes";
				    }
				    else
				    {
					 	IsCoreCompetency = "No";
				    }
                    if (data[i]["description"] != null) {
                        descrption = data[i]["description"]
                    }
                    if (data[i]["ExpYrs"] != null) {
                        ExpYrs = data[i]["ExpYrs"]
                    }
                    if (data[i]["ExpMonths"] != null) {
                        ExpMonths = data[i]["ExpMonths"]
                    }
                    if (data[i]["ParameterValue"] != null) {
                        ParameterValue = data[i]["ParameterValue"]
                    }
                    strHTML += '<tr>'
                    strHTML += '<td>' + descrption
                    strHTML += '</td>'
                    strHTML += '<td>' + ExpYrs
                    strHTML += '</td>'
                    strHTML += '<td>' + ExpMonths
                    strHTML += '</td>'
                    strHTML += '<td>' + ParameterValue
                    strHTML += '</td>'
                    strHTML += '<td>' + IsCoreCompetency + ' </td>';
                    strHTML += '</tr>'
                }
                if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD" || FromWhereWhichStatus == "C") {
                    $('#RASkillTable').dataTable().fnDestroy();
                    $("#RASkillTableBody").html("");
                    $("#RASkillTableBody").html(strHTML);
                } else {
                    $("#RASkillTbl_" + FromWhereWhichStatus).dataTable().fnDestroy();
                    $("#RASkillTableBody_" + FromWhereWhichStatus).html("");
                    $("#RASkillTableBody_" + FromWhereWhichStatus).html(strHTML);
                }
           
                //alert(FromWhereWhichStatus);
                if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD" || FromWhereWhichStatus == "C") {
                    $("#RASkillTable").DataTable({
                        "scrollY": false,
                        "scrollX": true,
                        "pageLength": 5,
                        "lengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": true,
                        "retrieve": true,
                        "responsive": true
                    });
                }
                else {
                    $("#RASkillTbl_" + FromWhereWhichStatus).DataTable({
                        "scrollY": false,
                        "scrollX": true,
                        "pageLength": 5,
                        "lengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": true,
                        "retrieve": true,
                        "responsive": true
                    });
                }
                GetSkillGraph1();
            } else {
                

            }

        }

        // Get Allocation tab
        function GetAllocation() {
           // debugger;
            var param = JSON.stringify(encodeURI(GRequestID))
            var data = AJAXCallWithResult("/api/RMResourceAllocation/GetAllocatedResources", param, false);

            var strHTML = "";
            if (data != null) {
                if (data.length != 0) {
                    for (var i = 0; i < data.length; i++) {
                     //   debugger;
                        var resourceName = "";
                        var assignmentDate = "";
                        var fromDate = "";
                        var toDate = "";
                        var workHrs = "";
                        var status = "";
                        if (data[i]["EmployeeName"] != null) {
                            resourceName = data[i]["EmployeeName"]
                        }
                        if (data[i]["AssignmentDate"] != null) {
                            assignmentDate = data[i]["AssignmentDate"];
                        }
                        if (data[i]["FromDate"] != null) {
                            fromDate = data[i]["FromDate"]
                        }
                        if (data[i]["ToDate"] != null) {
                            toDate = data[i]["ToDate"]
                        }
                        if (data[i]["WorkHours"] != null) {
                            workHrs = data[i]["WorkHours"]
                        }
                        if (data[i]["Status"] != null) {
                            status = data[i]["Status"]
                        }
                        if (status.trim() == "A") {
                            status = "Allocated";
                        }
                        if (status.trim() == "L") {
                            status = "Assigned to project";
                        }

                        strHTML += '<tr>'
                        strHTML += '<td>' + resourceName
                        strHTML += '</td>'
                        strHTML += '<td>' + assignmentDate
                        strHTML += '</td>'
                        strHTML += '<td>' + fromDate
                        strHTML += '</td>'
                        strHTML += '<td>' + toDate
                        strHTML += '</td>'
                        strHTML += '<td>' + workHrs
                        strHTML += '</td>'
                        strHTML += '<td>' + status
                        strHTML += '</td>'
                        strHTML += '</tr>'
                    }
                    if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD" || FromWhereWhichStatus == "C") {
                        $("#RAallocatedRsrsTableBody").html("");
                        $("#RAallocatedRsrsTableBody").append(strHTML);
                    } else {
                        $("#tbodyRAllocatedResource_" + FromWhereWhichStatus).html("");
                        $("#tbodyRAllocatedResource_" + FromWhereWhichStatus).append(strHTML);
                    }

                    if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD" || FromWhereWhichStatus == "C") {
                        $("#RAallocatedRsrsTable").DataTable({
                            "scrollY": false,
                            "scrollX": true,
                            "pageLength": 10,
                            "lengthChange": false,
                            "bFilter": false,
                            "ordering": false,
                            "responsive": true,
                            "destroy": true,
                            "retrieve": true,
                            "responsive": true
                        });

                    }
                    else {
                        $("#RAllocatedResource_" + FromWhereWhichStatus).DataTable({
                            "scrollY": false,
                            "scrollX": true,
                            "pageLength": 10,
                            "lengthChange": false,
                            "bFilter": false,
                            "ordering": false,
                            "responsive": true,
                            "destroy": true,
                            "retrieve": true,
                            "responsive": true
                        });
                    }

                } else {
                    strHTML = "";
                    strHTML = "<tr><td colspan='6' style='text-align:center'>No data available in table</tr>";
                    if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD" || FromWhereWhichStatus == "C") {
                        $("#RAallocatedRsrsTableBody").html("");
                        $("#RAallocatedRsrsTableBody").append(strHTML);
                    } else {
                        $("#tbodyRAllocatedResource_" + FromWhereWhichStatus).html("");
                        $("#tbodyRAllocatedResource_" + FromWhereWhichStatus).append(strHTML);
                    }

                }

            }

        }
        var EmployeeIDG = '<%= Session("intUserID") %>';
        // Get SimilarRequest tab
        function GetSimilarRequest() {

            var RequestDetails = {
                RequestID: encodeURI(GRequestID),
                UserId: encodeURI(EmployeeIDG)
            }
            var param = JSON.stringify(RequestDetails);
            var data = AJAXCallWithResult("/api/RMResourceAllocation/GetSimilarRequest", param, false);
            var strHTML = "";
            if (data != null) {
                //debugger;
                if (data.length != 0) {
                    for (var i = 0; i < data.length; i++) {
                        var projectName = "";
                        var requestDetails = "";

                        if (data[i]["Projects"] != null) {
                            projectName = data[i]["Projects"]
                        }
                        if (data[i]["Request Details"] != null) {
                            requestDetails = data[i]["Request Details"]
                        }
                        if (data[i]["RequestID"] != null) {
                            RequestID = data[i]["RequestID"]
                        }

                        strHTML += '<tr>'
                        strHTML += '<td>' + RequestID
                        strHTML += '</td>'
                        strHTML += '<td>' + projectName
                        strHTML += '</td>'
                        strHTML += '<td>' + requestDetails
                        strHTML += '</td>'
                        strHTML += '</tr>'
                    }

                    if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD") {
                        $("#RAsimilarReqTableBody").html("");
                        $("#RAsimilarReqTableBody").append(strHTML);
                    } else {
                        $("#tbodyRAsimilarReqTbl_" + FromWhereWhichStatus).html("");
                        $("#tbodyRAsimilarReqTbl_" + FromWhereWhichStatus).append(strHTML);
                    }

                    if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD") {
                        $("#RAsimilarReqTable").DataTable({
                            "scrollY": false,
                            "scrollX": true,
                            "pageLength": 10,
                            "lengthChange": false,
                            "bFilter": false,
                            "ordering": false,
                            "responsive": true,
                            "destroy": true,
                            "retrieve": true,
                            "responsive": true
                        });
                    } else {
                        $("#RAsimilar_" + FromWhereWhichStatus).DataTable({
                            "scrollY": false,
                            "scrollX": true,
                            "pageLength": 10,
                            "lengthChange": false,
                            "bFilter": false,
                            "ordering": false,
                            "responsive": true,
                            "destroy": true,
                            "retrieve": true,
                            "responsive": true
                        });
                    }
                }
                else {
                    //debugger;
                    strHTML = "";
                    strHTML = "<tr><td colspan='3' style='text-align:center'>No data available in table</tr>";
                    if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD") {
                        $("#RAsimilarReqTableBody").html("");
                        $("#RAsimilarReqTableBody").append(strHTML);
                    } else {
                        $("#tbodyRAsimilarReqTbl_" + FromWhereWhichStatus).html("");
                        $("#tbodyRAsimilarReqTbl_" + FromWhereWhichStatus).append(strHTML);
                    }

                }
            }

        }
        var selectedTab = 0
        // Get Allocation tab
        function GetProbableResources(preserveVendorFilter) {
           // clearFieldsProbable()
            //debugger;
            selectedTab = 0
            // Added by Dipali V on 15th May 2026 - Purpose:-Refresh project-scoped vendor list when opening Probable Resources tab (not on Search — preserve cleared "Select Vendor").
            if (!preserveVendorFilter) {
                var raReqVendor = getRARequestVendorId();
                if (getRAProjectID() > 0) {
                    FillRAVendorDropdown(raReqVendor, resolveRAVendorDropdownSelection(getRAVendorFilterSelection()));
                } else {
                    SetVendorSearchPlaceholder();
                }
            }
            if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD") {
                $("#searchMoreProbable").css("display", "");
                $("#DivVendor").css("display", "");
            } else {
                $("#searchMoreProbable_" + FromWhereWhichStatus).css("display", "");
            }

            if (m_strType != "P") {
                //Added By Dipali V On 11th May 2023 For HH:MM Format
                var RequestParameters = {
                    WorkHrs: encodeURI(m_dblRequestedWorkHours),
                    Flag: encodeURI(1),
                }
                var param = JSON.stringify(RequestParameters);
                var m_dblRequestedWorkHoursConverted = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
            }
            else {
                m_dblRequestedWorkHoursConverted = m_dblRequestedWorkHours;
            }
            //End of Added By Dipali V On 11th May 2023 For HH:MM Format
                var RequestDetails = {
                    RequestID: encodeURI(GRequestID),
                    UserId: encodeURI(EmployeeIDG),
                    EmployeeName: $("#employeeName").val(),
                    EmployeeId: encodeURI(EmployeeID),
                    ProjectId: $("#txthidProjectId").val(),
                    m_strFromDate: $("#txthidRequestFromDate").val(),
                    m_strToDate: $("#txthidRequestToDate").val(),
                    // Added by Dipali V on 13th May 2026 - Purpose:-Vendor filter for Probable Resources (same SP list as cboVendor_1; server filters when VendorID column exists).
                    VendorID: parseInt(getProbableVendorVal(), 10) || 0
                }
                var param = JSON.stringify(RequestDetails)
                var data = AJAXCallWithResult("/api/RMResourceAllocation/GetProbableResources", param, false);

                var strHTML = "";
                //debugger;
                if (data != null) {
                    strHTML += `<table id="Stp0probableRsrsInfoTbl" class="table table-bordered ClsprobableinfoTbl" style="width: 100%;"><thead>
                                    <tr>
                                    <th>Resource Name</th>
                                    <th>BG/OU</th>
                                    <th>Role</th>
                                    <th>Total Free Hrs</th>
                                    <th>Free Hrs Day</th>
                                    <th>Free%</th>
                                    <th id='ProCaptionType'></th>
                                    <th style="min-width:130px;">From Date</th>
                                    <th style="min-width:130px;">To Date</th>
                                  
                                      <th width="50px" id='lblProbabaleWH'></th>
                                    <th>Allocate</th>
                                </tr>
                            </thead>
                            <tbody>`
                        var RequestStartDate = $("#lblchangeFromDate1").text();
                        var RequestEndDate = $("#lblchangeTodate1").text();
                        var fromDateRequestD = new Date(RequestStartDate);
                        fromDateRequest = fromDateRequestD.getDate() + "-" + months[fromDateRequestD.getMonth()] + "-" + String(fromDateRequestD.getFullYear()).slice(-2);
                        var toDateRequestD = new Date(RequestEndDate);
                    toDateRequest = toDateRequestD.getDate() + "-" + months[toDateRequestD.getMonth()] + "-" + String(toDateRequestD.getFullYear()).slice(-2);
                    for (var i = 0; i < data.length; i++) {
                        var EmployeeName = data[i]["EmployeeName"]
                        var EmployeeID = data[i]["EmployeeID"]
                        var Role = data[i]["Role"]
                        var Office = data[i]["Office"]
                        var FreeHours = data[i]["FreeHours"]
                        var WorkHoursPerDay = data[i]["WorkHoursPerDay"]
                        //Added By Dipali v On 11th May 2023 For HH:MM
                        var FreeHoursHH = data[i]["FreeHoursHH"]
                        var WorkHoursPerDayHH = data[i]["WorkHoursPerDayHH"]
                        //End of Added By Dipali v On 11th May 2023 For HH:MM
                        var Department = data[i]["Department"]
                        var BusinessGroup = data[i]["BusinessGroup"]
                        var FreePercentage = data[i]["FreePercentage"]
                        var ResourceAllocation = data[i]["ResourceAllocation"]
                        //var ResourceAllocation = 100;
                        
                        //Commented and Added by imran on 30-12-2022 performance issue
                        var MinAvailablePerDayHrs = data[i]["MinAvailablePerDayHrs"]
                        var MinAvailablePercentage = data[i]["MinAvailablePercentage"]
                        //debugger;
                        var data2 = '';
                        if (m_strType == 'P') {
                            data2 = MinAvailablePercentage;
                        }
                        else {
                            data2 = MinAvailablePerDayHrs;
                        }

                        //var RequestDetails2 = {
                        //    FromDate: $("#txthidRequestFromDate").val(),
                        //    EmployeeId: encodeURI(EmployeeID),
                        //    ProjectId: $("#txthidProjectId").val(),
                        //    ToDate: $("#txthidRequestToDate").val(),
                        //    m_strType: m_strType
                        //}
                        
                        //var param2 = JSON.stringify(RequestDetails2)
                        //var data2 = AJAXCallWithResult("/api/RMResourceAllocation/GetMinAllocation", param2, false);
                        strHTML += `<tr>
                                    <td class="rsrsnamelinksTD text-start">
                                        <div class="rsrsnamephoto"><span>
                                            <img src="../../../Whizible2.0-new/dist/img/blankprofile.png" alt="" /></span> ${EmployeeName}</div>                                            
                                        <div class="RsrsUserlinks">
                                            <a href="javascript:ShowResume(${EmployeeID});" class="rsrsnamelinks" >Resume</a>
                                            <a href="javascript:ShowResourceLoading(${EmployeeID})" class="rsrsnamelinks">Resource Loading</a>
                                            <a href="javascript:ShowResourceAllocation(${EmployeeID},'${fromDateGlobal}','${EmployeeName}')" class="rsrsnamelinks">Resource Allocation</a>
                                        </div>
                                    </td>
                                    <td>${Office}</td>
                                    <td>${Role}</td>
                                    <td>${FreeHoursHH}</td>
                                    <td>${WorkHoursPerDayHH}</td>
                                    <td>${FreePercentage}</td>
                                    <td class='exactmatchfreehours'>${data2}</td>
                                    <td>
                                        <div class="input-group">
                                            <input id="txtFromDate_${EmployeeID}" class="form-control input-sm datetimepicker" type="text" value="${fromDateRequest}">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button" style="height: 30px;"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <input id="txtToDate_${EmployeeID}" class="form-control input-sm datetimepicker" type="text" value="${toDateRequest}">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button" style="height: 30px;"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </td>
                                    <td>
                                      
                                        <input id="txtWorkHours_${EmployeeID}" type="text" class="form-control input-sm" value="${m_dblRequestedWorkHoursConverted}"/>
                                        <input id="txthdnWorkHours_${EmployeeID}" type="hidden" class="form-control input-sm" value="${m_dblRequestedWorkHours}"/>
                                        <input id="txtMinAllocation_${EmployeeID}" type="hidden" class="form-control input-sm" value="${data2}"/>
                                        <input id="txthidEmployeeName_${EmployeeID}" type="hidden" class="form-control input-sm" value="${EmployeeName}"/></td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="ProbablersrsCheck${EmployeeID}" name='chkAssign' value="${EmployeeID}" class="chcktbl" type="checkbox">
                                            <label for="ProbablersrsCheck${EmployeeID}"></label>
                    
                                        </div>
                                    </td>
                                </tr>`
                    }


                    strHTML += ` </tbody></table>`
                    if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD") {
                        $("#divProbableResource").html(strHTML);
                    } else {
                        //$("#divProbableResource_" + FromWhereWhichStatus).html("");
                        $("#divProbableResource_" + FromWhereWhichStatus).html(strHTML);
                    }

                    //Added By Dipali V On 26th April 2023 For Caption Change
                    var LblTypeWise = "Work hrs(%)";
                    var CaptionType = "Max Free%";
                    if (m_strType == "TH") {
                        LblTypeWise = " Total Work Hours";
                        CaptionType = " Max Free Total Hours";
                        $("#ProCaptionType").hide()
                        $(".exactmatchfreehours").hide()
                    }
                    else if (m_strType == "HPD") {
                        LblTypeWise = "Work Hours";
                        CaptionType = "Max Free Hrs/Day";
                        $("#ProCaptionType").show()
                        $(".exactmatchfreehours").show()
                    }


                    
                    $("#lblProbabaleWH").text(LblTypeWise);
                    $("#ProCaptionType").text(CaptionType);
                    //End of Added By Dipali V On 26th April 2023 For Caption Change
                    if (FromWhereWhichStatus == "A" && IsNoAction=="1") {
                        $("#searchMoreProbable_" + FromWhereWhichStatus).css("display", "none");
                        $("#divProbableResource_" + FromWhereWhichStatus).html("<p style='text-align:center'>The number of resources requested have already been allocated</p>");
                    }

                    $("#Stp0probableRsrsInfoTbl").DataTable({
                        "scrollY": false,
                        "scrollX": true,
                        "pageLength": 10,
                        "lengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": true,
                        "retrieve": true,
                        "responsive": true
                    });

                    $('.datetimepicker').datepicker({
                        autoclose: true,
                        changeMonth: true,
                        changeYear: true,
                        dateFormat: 'd-M-y'
                    });
                }

            
        }

        var Fromwhere = "0";
        var strSkillIds = "";
        var strExpYrs = "";
        var strExpMonths = "";
        var strRatings = "";
        // Added by Dipali V on 15th May 2026 - Purpose:-Project-scoped vendor dropdowns (active on project + request-mapped vendor); mirrors PM_RequestedResources FillRequestVendorDropdown.
        function getRAProjectID() {
            return parseInt($("#hdnprojectid").val(), 10) || parseInt($("#txthidProjectId").val(), 10) || 0;
        }
        // Added by Dipali V on 15th May 2026 - Purpose:-Vendor mapped on the open resource request (for filter preselect).
        function getRARequestVendorId() {
            var v = parseInt(m_lngVendorId, 10) || parseInt(m_VendorID, 10) || 0;
            return v > 0 ? v : 0;
        }
        function getRAVendorFilterSelection() {
            return parseInt(getProbableVendorVal(), 10) || 0;
        }
        // When combo is still on "Select Vendor" (0), preselect vendor mapped on the open request.
        function resolveRAVendorDropdownSelection(preferredSelection) {
            var preferred = parseInt(preferredSelection, 10) || 0;
            if (preferred > 0) {
                return preferred;
            }
            return getRARequestVendorId();
        }
        function normalizeRAVendorApiResult(result) {
            if (result == null || result === undefined) {
                return null;
            }
            if (Array.isArray(result)) {
                return result;
            }
            if (result.Table) {
                return result.Table;
            }
            if (result.table) {
                return result.table;
            }
            if (result.$values) {
                return result.$values;
            }
            if (result.d != null && result.d !== undefined) {
                return normalizeRAVendorApiResult(result.d);
            }
            return null;
        }
        // Added by Dipali V on 15th May 2026 - Purpose:-One option per VendorID (request-mapped vendor may already be in project active list).
        function dedupeRAVendorList(vendorResult) {
            if (!vendorResult || !vendorResult.length) {
                return vendorResult;
            }
            var seen = {};
            var out = [];
            for (var i = 0; i < vendorResult.length; i++) {
                var vid = vendorResult[i].VendorID != null ? vendorResult[i].VendorID : vendorResult[i].vendorID;
                var key = String(vid);
                if (!vid || key === "0" || seen[key]) {
                    continue;
                }
                seen[key] = true;
                out.push(vendorResult[i]);
            }
            return out;
        }
        function bindRAVendorSelect($ddl, vendorResult, selectedVendorID) {
            if (!$ddl || !$ddl.length) {
                return;
            }
            vendorResult = dedupeRAVendorList(vendorResult);
            $ddl.empty();
            $ddl.append($("<option/>", { value: "0", text: "Select Vendor" }));
            if (vendorResult != null && vendorResult.length) {
                for (var i = 0; i < vendorResult.length; i++) {
                    var vid = vendorResult[i].VendorID != null ? vendorResult[i].VendorID : vendorResult[i].vendorID;
                    var vname = vendorResult[i].VendorName != null ? vendorResult[i].VendorName : vendorResult[i].vendorName;
                    if (vid != null && vid !== "") {
                        $ddl.append($("<option/>", { value: vid, text: vname || vid }));
                    }
                }
            }
            var sel = String(parseInt(selectedVendorID, 10) || 0);
            $ddl.val(sel);
            if (sel !== "0" && String($ddl.val()) !== sel) {
                $ddl.find("option").each(function () {
                    if (String($(this).val()) === sel) {
                        $ddl.val($(this).val());
                        return false;
                    }
                });
            }
            if (!$ddl.val() || $ddl.val() === "") {
                $ddl.val("0");
            }
        }
        var raVendorSelectSelector = "select#cboVendor_1, select#cboVendorProbable, select#cboVendorProbable_A, select#cboVendorProbable_CHANGE";
        // Added by Dipali V on 15th May 2026 - Purpose:-Load project vendor list and preselect vendor mapped on the opened request (both GetDetails code paths).
        function loadRAVendorFiltersForRequest(row) {
            if (!row) {
                return;
            }
            var projectId = parseInt(row.ProjectID, 10) || 0;
            if (projectId > 0) {
                $("#txthidProjectId").val(projectId);
                $("#hdnprojectid").val(projectId);
            }
            var raReqVendorId = parseInt(row.VendorID, 10) || parseInt(row.vendorID, 10) || 0;
            if (GRequestID) {
                var reqInfo = AJAXCallWithResult("/api/RMResourceAllocation/GetRequestInformation", JSON.stringify(GRequestID), false);
                if (reqInfo) {
                    raReqVendorId = parseInt(reqInfo.m_lngVendorId, 10) || parseInt(reqInfo.m_lngVendorID, 10) || raReqVendorId;
                    var raProj = parseInt(reqInfo.m_lngProjectId, 10) || 0;
                    if (raProj > 0) {
                        $("#hdnprojectid").val(raProj);
                        $("#txthidProjectId").val(raProj);
                    }
                }
            }
            m_lngVendorId = raReqVendorId;
            if (raReqVendorId > 0) {
                m_VendorID = raReqVendorId;
            }
            FillRAVendorDropdown(raReqVendorId, raReqVendorId);
        }
        function FillRAVendorDropdown(includeVendorID, selectedVendorID) {
            var currentProjectID = getRAProjectID();
            if (currentProjectID <= 0) {
                $(raVendorSelectSelector).each(function () {
                    bindRAVendorSelect($(this), null, 0);
                });
                SetVendorSearchPlaceholder();
                return;
            }
            // selectedVendorID may be 0 when user chooses "Select Vendor" — do not override with request-mapped vendor.
            var sel = 0;
            if (selectedVendorID !== null && selectedVendorID !== undefined && selectedVendorID !== "") {
                sel = parseInt(selectedVendorID, 10) || 0;
            } else {
                sel = getRARequestVendorId();
            }
            var mapVendorId = parseInt(includeVendorID, 10) || 0;
            if (mapVendorId <= 0) {
                mapVendorId = getRARequestVendorId();
            }
            function raVendorListHasId(list, vendorId) {
                if (!list || !list.length || vendorId <= 0) {
                    return false;
                }
                var key = String(vendorId);
                for (var vi = 0; vi < list.length; vi++) {
                    var rowVid = list[vi].VendorID != null ? list[vi].VendorID : list[vi].vendorID;
                    if (String(rowVid) === key) {
                        return true;
                    }
                }
                return false;
            }
            // Active project vendors first; add request-mapped vendor only if not already in list (avoids duplicate e.g. V5 twice).
            var requestParameters = { IncludeVendorID: 0, ProjectID: currentProjectID };
            var vendorResult = dedupeRAVendorList(normalizeRAVendorApiResult(AJAXCallWithResult("/api/RMResourceAllocation/GetVendorDropdown", JSON.stringify(requestParameters), false)));
            if (mapVendorId > 0 && !raVendorListHasId(vendorResult, mapVendorId)) {
                requestParameters.IncludeVendorID = mapVendorId;
                var extraVendors = dedupeRAVendorList(normalizeRAVendorApiResult(AJAXCallWithResult("/api/RMResourceAllocation/GetVendorDropdown", JSON.stringify(requestParameters), false)));
                vendorResult = dedupeRAVendorList((vendorResult || []).concat(extraVendors || []));
            }
            $(raVendorSelectSelector).each(function () {
                bindRAVendorSelect($(this), vendorResult, sel);
            });
            SetVendorSearchPlaceholder();
        }
        // Added by Dipali V on 7th May 2026 - Purpose:-Show "Select Vendor" placeholder in Search More vendor dropdown.
        // Added by Dipali V on 13th May 2026 - Purpose:-Apply same placeholder to Probable/Exact tab vendor combos (cboVendorProbable*).
        // Added by Dipali V on 13th May 2026 - Purpose:-Support combos with option value 0, blank first option, or neither (prepend placeholder).
        function SetVendorSearchPlaceholder() {
            $(raVendorSelectSelector).each(function () {
                var $vendor = $(this);
                if (!$vendor.length) {
                    return;
                }
                var keepVal = $vendor.val();
                var $z = $vendor.find("option").filter(function () {
                    return String($(this).val()) === "0";
                }).first();
                if ($z.length) {
                    $z.text("Select Vendor");
                } else {
                    var $first = $vendor.find("option:first");
                    if ($first.length && ($first.val() === "" || $first.val() == null)) {
                        $first.val("0").text("Select Vendor");
                    } else {
                        $vendor.prepend($("<option></option>").attr("value", "0").text("Select Vendor"));
                    }
                }
                if (keepVal && $vendor.find("option").filter(function () { return String($(this).val()) === String(keepVal); }).length) {
                    $vendor.val(keepVal);
                }
                $vendor.attr("title", "Select Vendor");
            });
        }
        // Added by Dipali V on 13th May 2026 - Purpose:-Read vendor from the active Probable Resources tab (multiple detail panels each have their own combo id).
        function getProbableVendorSelect() {
            var $s = $(".tab-pane.active select[id^='cboVendorProbable']").first();
            if ($s.length) return $s;
            $s = $(".Resourcedetailpanel:visible select[id^='cboVendorProbable']").first();
            if ($s.length) return $s;
            return $("#cboVendorProbable");
        }
        function getProbableVendorVal() {
            var v = getProbableVendorSelect().val();
            return v === undefined || v === null || v === "" ? "0" : v;
        }
        function GetSearchMore() {
            strSkillIds = "";
            strExpYrs = "";
            strExpMonths = "";
            strRatings = "";
            $("#divProbableResourceSearchMore").html("");
            $("#searchmoreModal").modal("show");
            SetVendorSearchPlaceholder();
            GetRequestInformation()
            Fromwhere = "1";
        }

        var m_lngRoleId = 0
        var m_lngLocationId = 0
        var m_strFromDate = ""
        var m_strToDate = ""
        var m_dblWorkHours = 0;
        var m_strType = "<%=TYPE_HPD%>";
        var m_intTotalResourcesAssigned = 0;
        var m_intTotalResourcesRequested = 0;
        var m_lngDepartmentId = 0;
        var m_lngVendorId = 0;
        
        function GetRequestInformation() {
            AJAXCallWithResultWithCallback("/api/RMResourceAllocation/GetRequestInformation", JSON.stringify(GRequestID), true, "POST", function (data) {
                clearFieldsSearchMore();
             
                m_lngRoleId = data.m_lngRoleId,
                m_lngLocationId = data.m_lngLocationId
                m_strFromDate = data.m_strFromDate
                m_strToDate = data.m_strToDate
                m_dblWorkHours = data.m_dblWorkHours
                m_strType = data.m_strType
                m_intTotalResourcesAssigned = data.m_intTotalResourcesAssigned
                m_intTotalResourcesRequested = data.m_intTotalResourcesRequested
                m_lngDepartmentId = data.m_lngDepartmentId
                // Added by Dipali V on 8th May 2026 - Purpose:-Bind request vendor to Search More vendor filter from GetRequestInformation data.
                m_lngVendorId = parseInt(data.m_lngVendorId || 0, 10) || 0
                if (m_lngVendorId > 0) {
                    m_VendorID = m_lngVendorId;
                }
                var raProjectFromRequest = parseInt(data.m_lngProjectId || 0, 10) || 0;
                if (raProjectFromRequest > 0) {
                    $("#hdnprojectid").val(raProjectFromRequest);
                    $("#txthidProjectId").val(raProjectFromRequest);
                }
                // Added by Dipali V on 15th May 2026 - Purpose:-Load project vendors and preselect vendor mapped on the request.
                FillRAVendorDropdown(m_lngVendorId, m_lngVendorId);
                //GetProbableResourcesSearchMore('R');
                GetSkillSearchMore();
                var RequestStartDate = m_strFromDate;
                var RequestEndDate = m_strToDate;
                var fromDateRequestD = new Date(RequestStartDate);
                fromDateRequest = fromDateRequestD.getDate() + "-" + months[fromDateRequestD.getMonth()] + "-" + String(fromDateRequestD.getFullYear()).slice(-2);
                var toDateRequestD = new Date(RequestEndDate);
                toDateRequest = toDateRequestD.getDate() + "-" + months[toDateRequestD.getMonth()] + "-" + String(toDateRequestD.getFullYear()).slice(-2);
                $("#cboRole").val(m_lngRoleId)
                $("#txtFromDate").val(fromDateRequest)
                $("#txtToDate").val(toDateRequest)
                if (m_strType != "P") {
                    //Added By Dipali V On 11th May 2023 For HH:MM Format
                    var RequestParameters = {
                        WorkHrs: encodeURI(m_dblRequestedWorkHours),
                        Flag: encodeURI(1),
                    }
                    var param = JSON.stringify(RequestParameters);
                    var m_dblRequestedWorkHoursConverted = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);

                    //End of Added By Dipali V On 11th May 2023 For HH:MM Format
                    //$("#txtHours_1").val(m_dblRequestedWorkHours);
                    $("#txtHours_1").val(m_dblRequestedWorkHours);
                    $("#txtshowHours_1").val(m_dblRequestedWorkHoursConverted);
                } else {
                    $("#txtHours_1").val(m_dblRequestedWorkHours);
                    $("#txtshowHours_1").val(m_dblRequestedWorkHours);
                }
                GetProbableResourcesSearchMore('R');

                $("[name=optType]").each(function (id, val) {
                    if (m_strType == $(this).val()) {
                        $(this).prop("checked", true);
                    }
                    else {
                        $(this).prop("checked", false);
                    }
                });
            });
            //GetProbableResourcesSearchMore('R');
                //GetSkillSearchMore();
        }

        function clearFieldsSearchMore() {
            $("#employeeName_1").val('')
            $("#cboStatus_1").val(null);
            $("#cboProjectRole_1").val(null);
            // Added by Dipali V on 6th May 2026 - Purpose:-Reset vendor filter while reopening Search More popup.
            $("#cboVendor_1").val("0");
        }
        function clearFieldsProbable() {
            $("#employeeName").val('')
            $("#cboStatus").val(null);
            $("#cboProjectRole").val(null);
            // Added by Dipali V on 13th May 2026 - Purpose:-Reset vendor filters on all Probable Resources tab variants when closing detail panel.
            $("#cboVendorProbable, #cboVendorProbable_A, #cboVendorProbable_CHANGE").val("0");
        }
        var intPageNo = 1;
        var intRecordCount = 10;
        var intTotalRecord = 0;
        function SearchMore() {
             intPageNo = 1;
            intRecordCount = 10;
             intTotalRecord = 0;
            GetProbableResourcesSearchMore('R');
        }
        function GetProbableResourcesSearchMoreCount(flag)
        {
            var strHTMLPagination = "";
            AssignSkillsForSearchMore();

            //strRatings = strRatings.substring(0, strRatings.length - 1);
            var RequestDetails = {
                RequestID: encodeURI(GRequestID),
                UserId: encodeURI(EmployeeIDG),
                EmployeeName: $("#employeeName_1").val(),
                m_intSelectEmployeeType:<%=m_intSelectEmployeeType%>,
                m_lngRoleId: $("#cboRole").val(),
                m_lngLocationId: m_lngLocationId,
                m_strFromDate: $("#txtFromDate").val(),
                m_strToDate: $("#txtToDate").val(),
                m_dblWorkHoursForFilter: $("#txtHours_1").val(),
                m_strType: m_strType,
                m_lngDepartmentId: m_lngDepartmentId,
                strSkillIds: strSkillIds,
                strExpYrs: strExpYrs,
                strExpMonths: strExpMonths,
                strRatings: strRatings,
                Fromwhere: Fromwhere,
                flag: flag,
                ProjectId: $("#txthidProjectId").val(),
                // Added by Dipali V on 6th May 2026 - Purpose:-Pass selected vendor to search-more count API.
                VendorID: $("#cboVendor_1").val()
            }
            var param = JSON.stringify(RequestDetails)
            AJAXCallWithResultWithCallback("/api/RMResourceAllocation/GetProbableResourcesSearchMore_Count", param, false, "POST", function (data) {
               
                if (data != null) {
                    intTotalRecord = data
                    strHTMLPagination += `<nav aria-label="Page navigation example" >
                                    <ul class="pagination float-end">
                                    <li>
                                    <span>Total Record : ${intTotalRecord} </span>
                                    </li>
                                    <li class="page-item">
                                    <a class="page-link" href="javascript:ShowPrevious();" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                    </a>
                                    </li>
                                    <li class="page-item">
                                    <a class="page-link" href="javascript:ShowNext();" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                    </a>
                                    </li>
                                    </ul>
                                    </nav>`
                    $("#pagination").html(strHTMLPagination);
                }
            });
        }
        function GetProbableResourcesSearchMore(flag) {
           
            AssignSkillsForSearchMore();
            GetProbableResourcesSearchMoreCount('R');
            if ($("#cboRole").val() =="") {
                alertify.error("<%= MyBase.GetResourceString("A_Role") %>");
                return false;
            }
            if (m_strType != "P") {
                //Added By Dipali V On 11th May 2023 For HH:MM Format
                var RequestParameters = {
                    WorkHrs: encodeURI(m_dblRequestedWorkHours),
                    Flag: encodeURI(1),
                }
                var param = JSON.stringify(RequestParameters);
                var m_dblRequestedWorkHoursConverted = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
            } else {
                m_dblRequestedWorkHoursConverted = m_dblRequestedWorkHours;
            }
            //End of Added By Dipali V On 11th May 2023 For HH:MM Format
            //strRatings = strRatings.substring(0, strRatings.length - 1);
            var RequestDetails = {
                RequestID: encodeURI(GRequestID),
                UserId: encodeURI(EmployeeIDG),
                EmployeeName: $("#employeeName_1").val(),
                m_intSelectEmployeeType:<%=m_intSelectEmployeeType%>,
                m_lngRoleId: $("#cboRole").val(),
                m_lngLocationId: m_lngLocationId,
                m_strFromDate: $("#txtFromDate").val(),
                m_strToDate: $("#txtToDate").val(),
                m_dblWorkHoursForFilter: $("#txtHours_1").val(),
                m_strType: m_strType,
                m_lngDepartmentId: m_lngDepartmentId,
                strSkillIds: strSkillIds,
                strExpYrs: strExpYrs,
                strExpMonths: strExpMonths,
                strRatings: strRatings,
                Fromwhere: Fromwhere,
                flag: flag,
                ProjectId: $("#txthidProjectId").val(),
                PageNo: intPageNo,
                // Added by Dipali V on 6th May 2026 - Purpose:-Pass selected vendor to search-more result API.
                VendorID: $("#cboVendor_1").val()
            }
            var param = JSON.stringify(RequestDetails)
            AJAXCallWithResultWithCallback("/api/RMResourceAllocation/GetProbableResourcesSearchMore", param, false, "POST", function (data) {
                var strHTML = "";
                if (data != null) {
                    strHTML += `<table id="Stp0probableRsrsInfoTbl_1" class="table table-bordered ClsprobableinfoTbl" style="width: 100%;"><thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>BG/OU</th>
                                    <th>Role</th>
                                    <th>Total Free Hrs</th>
                                    <th>Free Hrs Day</th>
                                    <th>Free%</th>
                                    <th id='SearchCaptionType'></th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                   
                                    <th id='lblProbabaleWHMore'>Work hrs(%)</th>
                                    <th>Allocate</th>
                                </tr>
                            </thead>
                            <tbody>`
                    /* <th id='SearchCaptionType'></th>*/
                        var RequestStartDate = $("#lblchangeFromDate1").text();
                        var RequestEndDate = $("#lblchangeTodate1").text();
                        var fromDateRequestD = new Date(RequestStartDate);
                    fromDateRequest = fromDateRequestD.getDate() + "-" + months[fromDateRequestD.getMonth()] + "-" + String(fromDateRequestD.getFullYear()).slice(-2);
                        var toDateRequestD = new Date(RequestEndDate);
                    toDateRequest = toDateRequestD.getDate() + "-" + months[toDateRequestD.getMonth()] + "-" + String(toDateRequestD.getFullYear()).slice(-2);
                    for (var i = 0; i < data.length; i++) {
                        var EmployeeName = data[i]["EmployeeName"]
                        var EmployeeID = data[i]["EmployeeID"]
                        var Role = data[i]["Role"]
                        var Office = data[i]["Office"]
                        var FreeHours = data[i]["FreeHours"]
                        var WorkHoursPerDay = data[i]["WorkHoursPerDay"]
                        //Added By Dipali v On 11th May 2023 For HH:MM
                        var FreeHoursHH = data[i]["FreeHoursHH"]
                        var WorkHoursPerDayHH = data[i]["WorkHoursPerDayHH"]
                        //End of Added By Dipali v On 11th May 2023 For HH:MM
                        var Department = data[i]["Department"]
                        var BusinessGroup = data[i]["BusinessGroup"]
                        var FreePercentage = data[i]["FreePercentage"]
                        var ResourceAllocation = data[i]["ResourceAllocation"]
                       // debugger;
                        //Commented and Added by imran on 30-12-2022 performance issue
                        var MinAvailablePerDayHrs = data[i]["MinAvailablePerDayHrs"]
                        var MinAvailablePercentage = data[i]["MinAvailablePercentage"]
                        var data2 = '';
                        if (m_strType == 'P') {
                            data2 = MinAvailablePercentage;
                        }
                        else {
                            data2 = MinAvailablePerDayHrs;
                        }
                        
                        //var RequestDetails2 = {
                        //    FromDate: $("#txthidRequestFromDate").val(),
                        //    EmployeeId: encodeURI(EmployeeID),
                        //    ProjectId: $("#txthidProjectId").val(),
                        //    ToDate: $("#txthidRequestToDate").val(),
                        //    m_strType: m_strType
                        //}
                        //var param2 = JSON.stringify(RequestDetails2)
                        //var data2 = AJAXCallWithResult("/api/RMResourceAllocation/GetMinAllocation", param2, false);
                        
                        //ResourceAllocation = data2
                        //End of comment by imran on 30-12-2022
                        //debugger;
                        strHTML += `<tr>
                                    <td class="rsrsnamelinksTD text-start">
                                        <div class="rsrsnamephoto"><span>
                                            <img src="../../../Whizible2.0-new/dist/img/blankprofile.png" alt="" /></span> ${EmployeeName}</div>                                            
                                        <div class="RsrsUserlinks">
                                            <a href="javascript:ShowResume(${EmployeeID});" class="rsrsnamelinks" >Resume</a>
                                            <a href="javascript:ShowResourceLoading(${EmployeeID})" class="rsrsnamelinks">Resource Loading</a>
                                            <a href="javascript:ShowResourceAllocation(${EmployeeID},'${fromDateGlobal}','${EmployeeName}')" class="rsrsnamelinks">Resource Allocation</a>
                                        </div>
                                    </td>
                                    <td>${Office}</td>
                                    <td>${Role}</td>
                                    <td>${FreeHoursHH}</td>
                                    <td>${WorkHoursPerDayHH}</td>
                                    <td>${FreePercentage}</td>
                                    <td class='searchmorefreehours'>${data2} </td>
                                    <td>
                                        <div class="input-group">
                                            <input id="txtFromDate_${EmployeeID}_1" class="form-control input-sm datetimepicker_1" type="text" value="${fromDateRequest}">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button" style="height: 30px;"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <input id="txtToDate_${EmployeeID}_1" class="form-control input-sm datetimepicker_1" type="text" value="${toDateRequest}">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button" style="height: 30px;"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </td>
                                    <td>
                                        <input id="txtWorkHours_${EmployeeID}_1" type="text" class="form-control input-sm" value="${m_dblRequestedWorkHoursConverted}" />
                                         <input id="txthdnWorkHours_${EmployeeID}" type="hidden" class="form-control input-sm" value="${m_dblRequestedWorkHours}"/>
                                        <input id="txtMinAllocation_${EmployeeID}_1" type="hidden" class="form-control input-sm" value="${data2}"/>
                                        <input id="txthidEmployeeName_${EmployeeID}_1" type="hidden" class="form-control input-sm" value="${EmployeeName}"/></td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="ProbablersrsCheck${EmployeeID}_1" name='chkAssign' value="${EmployeeID}" class="chcktbl" type="checkbox">
                                            <label for="ProbablersrsCheck${EmployeeID}_1"></label>
                    
                                        </div>
                                    </td>
                                </tr>`
                    }


                    strHTML += ` </tbody></table>`
                    $("#divProbableResourceSearchMore").html("");
                    $("#divProbableResourceSearchMore").html(strHTML);
                    //Added By Dipali V On 26th April 2023 For Caption Change
                    var LblTypeWise = "Work hrs(%)";
                    var CaptionType = "Max Free%";
                    if (m_strType == "TH") {
                        LblTypeWise = " Total Work Hours";
                        CaptionType = " Max Free Total Hours";
                        $("#SearchCaptionType").hide();
                        $(".searchmorefreehours").hide();
                    }
                    else if (m_strType == "HPD") {
                        LblTypeWise = "Work Hours";
                        CaptionType = "Max Free Hrs/Day";
                        $("#SearchCaptionType").show();
                        $(".searchmorefreehours").show();
                    }

                    $("#lblProbabaleWHMore").text(LblTypeWise);
                    $("#SearchCaptionType").text(CaptionType);
                    //End of Added By Dipali V On 26th April 2023 For Caption Change
                    
                    //$("#Stp0probableRsrsInfoTbl_1").DataTable({
                    //    "scrollY": false,
                    //    "scrollX": true,
                    //    "pageLength": 10,
                    //    "lengthChange": false,
                    //    "bFilter": false,
                    //    "ordering": false,
                    //    "responsive": true,
                    //    "destroy": true,
                    //    "retrieve": true,
                    //    "responsive": true
                    //});
                    $('.datetimepicker_1').datepicker({
                        autoclose: true,
                        changeMonth: true,
                        changeYear: true,
                        dateFormat: 'd-M-y'
                    });
                }
            });

            //setTimeout(function () {
            //    StopAjaxLoader("#bodyAllocation");
            //}, 20000);
           
        }
        function ShowPrevious() {
            if (intRecordCount > 10) {
                intPageNo = intPageNo - 1;
                intRecordCount = intRecordCount - 10;
                StartLoader("#bodyAllocation");
                GetProbableResourcesSearchMore('R');
               
            }
            else {
                alertify.error("This is first page.");
                return false;
            }
        }
        function ShowNext() {
            if (intTotalRecord >= intRecordCount) {
                intPageNo = intPageNo + 1;
                intRecordCount = intRecordCount + 10;
                StartLoader("#bodyAllocation");
                GetProbableResourcesSearchMore('R');
                
            }
            else {
                alertify.error("This is last page.");
                return false;
            }
            
        }
        function AssignSkillsForSearchMore() {
            strSkillIds = "";
            strExpYrs = "";
            strExpMonths = "";
            strRatings = "";
            var hidSkills = document.getElementsByName("hidSkills");
            for (var i = 0; i < hidSkills.length; i++) {
                // debugger;
                if (!($("#cboYears_" + hidSkills[i].value).val() == 0 && $("#cboMonths_" + hidSkills[i].value).val() == 0 && $("#cboRating_" + hidSkills[i].value).val() == 0)) {
                    if (strSkillIds == "") {
                        strSkillIds = hidSkills[i].value;
                    }
                    else {
                        strSkillIds += "," + hidSkills[i].value;
                    }
                    if (strExpYrs == "") {
                        strExpYrs = $("#cboYears_" + hidSkills[i].value).val();
                    }
                    else {
                        strExpYrs += "," + $("#cboYears_" + hidSkills[i].value).val();
                    }
                    if (strExpMonths == "") {
                        strExpMonths = $("#cboMonths_" + hidSkills[i].value).val();
                    }
                    else {
                        strExpMonths += "," + $("#cboMonths_" + hidSkills[i].value).val();
                    }
                    if (strRatings == "") {
                        strRatings = $("#cboRating_" + hidSkills[i].value).val();
                    }
                    else {
                        strRatings += "," + $("#cboRating_" + hidSkills[i].value).val();
                    }
                }
            }
        }

        function AJAXCallWithResultWithCallback(url, param, async, type, callback) {
            var ajaxResult;
            StartLoader("#bodyAllocation");
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: type,
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_resource"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                    callback(ajaxResult);
                    StopAjaxLoader("#bodyAllocation");
                },
                error: function (jqXHR) {
                    console.log(jqXHR);
                }
            });
            return ajaxResult;
        }



        function GetSkillSearchMore() {
            var RequestDetails = {
                RequestID: encodeURI(GRequestID),
                ProjectId: document.getElementById("txthidProjectId").value
            }
            var param = JSON.stringify(RequestDetails)
            //var data = AJAXCallWithResult("/api/RMResourceAllocation/GetSkillsSearchMore", param, false);
            AJAXCallWithResultWithCallback("/api/RMResourceAllocation/GetSkillsSearchMore", param, false, "POST", function (data) {
                var strHTML = "";
                var strHTML = `<table id="Skillstbl" class="table table-stripped table-bordered" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Skills</th>
                                            <th>Experience(Years)</th>
                                            <th>Experience(Months)</th>
                                            <th>Proficiency</th>
                                        </tr>
                                    </thead>
                                    <tbody>`


                for (var i = 0; i < data.length; i++) {
                    var ToolID = data[i].ToolID;
                    var Description = data[i].Description;
                    var ExpYrs = data[i].ExpYrs;
                    var ExpMonths = data[i].ExpMonths;
                    var Rating = data[i].Rating;
                    strHTML += '<tr>'
                    strHTML += '<td>' + Description
                    strHTML += "<input type=hidden name=hidSkills value='" + ToolID + "' />";
                    strHTML += '</td>'
                    strHTML += '<td>' + CreateDropdown("cboYears_" + ToolID, Years, 1, ExpYrs);
                    strHTML += '</td>'
                    strHTML += '<td>' + CreateDropdown("cboMonths_" + ToolID, Months, 1, ExpMonths);
                    strHTML += '</td>'
                    strHTML += '<td>' + CreateDropdown("cboRating_" + ToolID, Ratings, 0, Rating);
                    strHTML += '</td>'
                    strHTML += '</tr>'
                }
                strHTML += `     </tbody>
                                </table>`;
                $("#divSkills").html(strHTML);
            });
        }
        var Years;
        var Months;
        var Ratings;
        function GetYears() {
            AJAXCallWithResultWithCallback("/api/RMResourceAllocation/GetYears", {}, true, "POST", function (data) {
                Years = data;
            });
        }

        function GetMonths() {
            AJAXCallWithResultWithCallback("/api/RMResourceAllocation/GetMonths", {}, true, "POST", function (data) {
                Months = data;
            });
        }

        function GetRatings() {
            AJAXCallWithResultWithCallback("/api/RMResourceAllocation/GetRatings", {}, true, "POST", function (data) {
                Ratings = data;
            });
        }

        function CreateDropdown(id, data, flag, value) {
            //debugger;
            var strHTML = `<select id="${id}" class='form-select'>`
            if (flag == 0) {
                //if ($(id).indexOf("cboRating") > -1) {
                //    strHTML += "<option value=0>Select Proficiency</option>";
                //} else {
                   
                //}
                strHTML += "<option value=0></option>";

            }
            if (data) {

                for (var i = 0; i < data.length; i++) {
                    if (flag == 1) {
                        strHTML += `<option value="${data[i].YearID}" ${value == data[i].YearID ? "selected" : ""}>${data[i].Year}</option>`
                    }
                    else {
                        strHTML += `<option value="${data[i].ParameterID}" ${value == data[i].ParameterID ? "selected" : ""}>${data[i].ParameterValue}</option>`
                    }
                }

            }
            strHTML += `</select>`;
            return strHTML;
        }



       

        function SaveConfigureDays() {
            var objConfigureDays;
            var strMsg;

            objConfigureDays = document.getElementById('txtNoOfDays');
            strMsg = "Please enter days.";
            if (disallowBlank(objConfigureDays, strMsg) == false) {
                if (disallowNonInteger(objConfigureDays, strMsg) == false) {
                    if (disallowNegativeInteger(objConfigureDays, strMsg) == false) {
                        var RequestDetails = {
                            RequestID: encodeURI(GRequestID),
                            ConfigureDays: encodeURI(objConfigureDays.value),
                            ProjectId: document.getElementById("txthidProjectId").value
                        }
                        var param = JSON.stringify(RequestDetails)
                        var data = AJAXCallWithResult("/api/RMResourceAllocation/SaveConfigureDays", param, false);
                        alertify.success("Saved Successfully.");
                        GetConfigureDays();
                    }
                }
            }
        }

        var BGPoolEscalationComments = "";
        var OUPoolEscalationComments = "";
        function GetConfigureDays() {
            // debugger;
            var RequestDetails = {
                RequestID: encodeURI(GRequestID),
                ProjectID: document.getElementById("txthidProjectId").value,
                m_strResourceAllocationLevel: "<%=ResourceAllocationLevel%>",
            }
            var param = JSON.stringify(RequestDetails)
            var data = AJAXCallWithResult("/api/RMResourceAllocation/GetConfigureDays", param, false);
            if (data != "") {
                // debugger;
                for (var i = 0; i < data.length; i++) {
                    $('#txtNoOfDays').val(data[i].ConfiguredMaxDays);
                    BGPoolEscalationComments = data[i].BGPoolEscalationComments;
                    OUPoolEscalationComments = data[i].OUPoolEscalationComments;
                
                }
                
                if ("<%=ResourceAllocationLevel%>" == "Corporate") {
                    $(".btnescalteOU").css("display", "none");
                    $(".btnescalteBG").css("display", "none");
                } else {
                    if (BGPoolEscalationComments != "" && OUPoolEscalationComments != "") {
                        if ("<%=ResourceAllocationLevel%>" == "Business Group") {
                            $(".btnescalteBG_" + FromWhereWhichStatus).text("");
                            $(".btnescalteBG_" + FromWhereWhichStatus).text("Escalation Comments (BGM)");
                            $(".clsBGEsclationheader").text("");
                            $(".clsBGEsclationheader").text("Escalation Comments (BGM)");
                            $(".btnescalteBG_" + FromWhereWhichStatus).attr("title", "View Escalation Comments given by BG Pool Manager");
                        }
                        else if ("<%=ResourceAllocationLevel%>" == "ODC") {
                            if (BGPoolEscalationComments != "") {
                                $(".btnescalteBG_" + FromWhereWhichStatus).css("display", "inline-block");
                                $(".btnescalteBG_" + FromWhereWhichStatus).text("");
                                $(".btnescalteBG_" + FromWhereWhichStatus).text("Escalation Comments (BGM)");
                                $(".clsBGEsclationheader").text("Escalation Comments (BGM)");
                                $(".btnescalteBG_" + FromWhereWhichStatus).attr("title", "View Escalation Comments given by BG Pool Manager");
                                $("#txtEscalationComments").text(BGPoolEscalationComments);
                            }
                            if (OUPoolEscalationComments != "") {
                                $(".btnescalteOU_" + FromWhereWhichStatus).text("");
                                $(".btnescalteOU_" + FromWhereWhichStatus).text("Escalation Comments (OUM)");
                                $(".clsBGEsclationheader").text("Escalation Comments (OUM)");
                                $(".btnescalteOU_" + FromWhereWhichStatus).attr("title", "View Escalation Comments given by OU Pool Manager");
                                $(".btnescalteOU_" + FromWhereWhichStatus).css("display", "inline-block");
                                $("#txtEscalationComments").text(OUPoolEscalationComments);
                            }
                            else {
                                $(".btnescalteBG_" + FromWhereWhichStatus).text("");
                                $(".btnescalteBG_" + FromWhereWhichStatus).text("Escalation Comments (BGM)");
                                $(".clsBGEsclationheader").text("Escalation Comments (BGM)");
                                $(".btnescalteBG_" + FromWhereWhichStatus).attr("title", "View Escalation Comments given by BG Pool Manager");
                                $("#txtEscalationComments").text(OUPoolEscalationComments);
                            }
                        }
                    } else {

                        if ("<%=ResourceAllocationLevel%>" == "Business Group") {
                            $(".btnescalteOU_" + FromWhereWhichStatus).css("display", "none");
                            $(".btnescalteBG_" + FromWhereWhichStatus).css("display", "inline-block");
                            $(".btnescalteBG_" + FromWhereWhichStatus).text("");
                            $(".btnescalteBG_" + FromWhereWhichStatus).text("Escalate To GRP");
                            $(".clsBGEsclationheader").text("Escalate To GRP");
                            $(".btnescalteBG_" + FromWhereWhichStatus).attr("title", "Escalate request To Global Resource Pool");
                        } else if ("<%=ResourceAllocationLevel%>" == "ODC") {
                            if (OUPoolEscalationComments == "" && BGPoolEscalationComments == "") {
                                $(".btnescalteOU_" + FromWhereWhichStatus).css("display", "inline-block");
                                $(".btnescalteOU_" + FromWhereWhichStatus).text("");
                                $(".btnescalteOU_" + FromWhereWhichStatus).text("Escalate To BG Pool");
                                $(".btnescalteBG_" + FromWhereWhichStatus).css("display", "none");
                                $(".clsBGEsclationheader").text("Escalate To BG Pool");
                                $(".btnescalteOU_" + FromWhereWhichStatus).attr("title", "Escalate request To OU Resource Pool");
                                $("#txtEscalationComments").text(OUPoolEscalationComments);
                            }
                            else {
                                if (OUPoolEscalationComments != "" && BGPoolEscalationComments == "") {
                                    $(".btnescalteOU_" + FromWhereWhichStatus).text("");
                                    $(".btnescalteOU_" + FromWhereWhichStatus).text("Escalation Comments (OUM)");
                                    //$(".btnescalteBG").css("display", "none");
                                    $(".clsBGEsclationheader").text("Escalation Comments (OUM)");
                                    $(".btnescalteOU_" + FromWhereWhichStatus).attr("title", "View Escalation Comments given by OU Pool Manager");
                                    $(".btnescalteOU_" + FromWhereWhichStatus).css("display", "inline-block");
                                    $("#txtEscalationComments").text(OUPoolEscalationComments);
                                    $(".btnescalteBG_" + FromWhereWhichStatus).css("display", "inline-block");
                                    $(".btnescalteBG_" + FromWhereWhichStatus).text("");
                                    $(".btnescalteBG_" + FromWhereWhichStatus).text("Escalate To GRP");
                                    $(".clsBGEsclationheader").text("Escalate To GRP");
                                    $(".btnescalteBG_" + FromWhereWhichStatus).attr("title", "Escalate request To Global Resource Pool");


                                }
                                else if (OUPoolEscalationComments == "" && BGPoolEscalationComments != "") {

                                    $(".btnescalteOU_" + FromWhereWhichStatus).css("display", "inline-block");
                                    $(".btnescalteBG_" + FromWhereWhichStatus).css("display", "none");
                                    $(".btnescalteOU_" + FromWhereWhichStatus).text("");
                                    $(".btnescalteOU_" + FromWhereWhichStatus).text("Escalate To BG Pool");
                                    $(".clsBGEsclationheader").text("Escalate To BG Pool");
                                    //$("#btnEscalation").css("display", "");
                                    $(".btnescalteOU_" + FromWhereWhichStatus).attr("title", "Escalate request To OU Resource Pool");
                                    $("#txtEscalationComments").text(OUPoolEscalationComments);

                                }

                            }

                        }

                    }
                }
            }
        }


        var m_Manager = "";
        var level = "";
        var BusinessGroup = "";
        function GetApproverForEscalation() {
            //debugger;
            var RequestDetails = {
                RequestID: encodeURI(GRequestID),
                m_strResourceAllocationLevel: '<%=ResourceAllocationLevel%>',
            }
            var param = JSON.stringify(RequestDetails)
            var data = AJAXCallWithResult("/api/RMResourceAllocation/GetApproverForEscalation", param, false);
            if (data != "") {
                for (var i = 0; i < data.length; i++) {
                    m_Manager = data[i].EmployeeName;
                    level = data[i].Level;
                    BusinessGroup = data[i].BusinessGroup;
                    if (m_Manager == null) {
                        m_Manager = "";
                    }
                }
            }

        }
        var selectedcontroltext = "";
        var ESCALATIONMsgID = "";
        function Esclateion(flag,ID) {
         
            selectedcontroltext = "";
            selectedcontroltext = $("." + ID +"_" + FromWhereWhichStatus).text();
            if (selectedcontroltext.includes("Comments")) {
                $("#btnEscalation").css("display", "none");
            } else {
                $("#btnEscalation").css("display", "");
                $("#txtEscalationComments").val("");
                $(".clsBGEsclationheader").text(selectedcontroltext);
                
            }


            if ("<%=ResourceAllocationLevel%>" == "Business Group") {
                if (m_Manager == "") {
                    alertify.error("Please set Global Resource Pool Manager");
                    return false;

                }
            }

            else if ("<%=ResourceAllocationLevel%>" == "ODC") {
                if (m_Manager == "" && level == 'GRP') {
                    alertify.error("Please set Global Resource Pool Manager");
                    return false;

                }
                else if (m_Manager == "") {
                    var strMsg = 'Please set Manager for Business Group <=>'
                    strMsg = replaceSubstring(strMsg, '<=>', "'" + BusinessGroup + "'");
                    alertify.error(strMsg);
                    return false;
                }

            }
            if (flag == 1)
            {
                if (BGPoolEscalationComments != "") {
                    $("#txtEscalationComments").text(BGPoolEscalationComments);
                    $(".clsBGEsclationheader").text("Escalation Comments (BGM)");
                    $(".btnescalteBG_" + FromWhereWhichStatus).attr("title", "View Escalation Comments given by BG Pool Manager");
                }
                else {
                    $("#txtEscalationComments").text(BGPoolEscalationComments);
                }


            } else {
                if (OUPoolEscalationComments != "") {
                    $("#txtEscalationComments").text(OUPoolEscalationComments);
                    $(".clsBGEsclationheader").text("Escalation Comments (OUM)");
                    $(".btnescalteOU_" + FromWhereWhichStatus).attr("title", "View Escalation Comments given by OU Pool Manager");
                } else {
                    $("#txtEscalationComments").text(OUPoolEscalationComments);
                }

            }
            $("#EscalationBGPoolModal").modal('show');
        }

       

        var IsEscalateToGRP = 0;
        function Escalation_Onclick() {
            if ($("#txtEscalationComments").val().trim() != "") {
                if (selectedcontroltext.includes("GRP")) {
                    IsEscalateToGRP = 1;
                    ESCALATIONMsgID = "432";
                } else if (selectedcontroltext.includes("BG Pool")) {
                    ESCALATIONMsgID = "430";
                    IsEscalateToGRP = 0;
                }
                var RequestDetails = {
                    RequestID: encodeURI(GRequestID),
                    Comments: document.getElementById("txtEscalationComments").value,
                    m_strResourceAllocationLevel: "<%=ResourceAllocationLevel%>",
                    IsEscalateToGRP: IsEscalateToGRP
                }
                var param = JSON.stringify(RequestDetails)
                var data = AJAXCallWithResult("/api/RMResourceAllocation/SaveBGEsaclations", param, false);
                if (data != "") {
                    alertify.success("Data Saved Successfully.");
                    $("#EscalationBGPoolModal").modal('hide');
                    //GetConfigureDays();
                    GetDetails(GWhichTab, GRequestID, 1);
                   
                    window.open("../Email/SendEmail.aspx?MessageID=" + ESCALATIONMsgID +"&RequestID=" + GRequestID + "&EmployeeID=" + UserID + "", '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500')

                    //BGPoolEscalationComments = "";
                    //OUPoolEscalationComments = "";
                    //m_Manager = "";
                    //level = "";
                    //BusinessGroup = "";
                    //selectedcontroltext = ""
                    //debugger;
                    GetConfigureDays();
                    GetApproverForEscalation();

                }
            }
            
            else {
                alertify.error("Escalation Comments should not be left blank");
                $("#txtEscalationComments").focus();
                return false;
            }


        }
      

        // Get Allocation tab
        function GetExactMatch(preserveVendorFilter) {
            //debugger;
            //clearFieldsProbable();
            selectedTab = 1
            // Added by Dipali V on 15th May 2026 - Purpose:-Refresh project-scoped vendor list when opening Exact Match tab (not on Search — preserve cleared "Select Vendor").
            if (!preserveVendorFilter) {
                var raReqVendor = getRARequestVendorId();
                if (getRAProjectID() > 0) {
                    FillRAVendorDropdown(raReqVendor, resolveRAVendorDropdownSelection(getRAVendorFilterSelection()));
                } else {
                    SetVendorSearchPlaceholder();
                }
            }
            if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD") {
                $("#searchMoreProbable").css("display", "none");
                $("#DivVendor").css("display", "none");
            } else {
                $("#searchMoreProbable_" + FromWhereWhichStatus).css("display", "none");
            }

            if (m_strType != "P") {
                //Added By Dipali V On 11th May 2023 For HH:MM Format
                var RequestParameters = {
                    WorkHrs: encodeURI(m_dblRequestedWorkHours),
                    Flag: encodeURI(1),
                }
                var param = JSON.stringify(RequestParameters);
                var m_dblRequestedWorkHoursConverted = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
            } else {
                m_dblRequestedWorkHoursConverted = m_dblRequestedWorkHours;
            }
            //End of Added By Dipali V On 11th May 2023 For HH:MM Format

            var RequestDetails = {
                RequestID: encodeURI(GRequestID),
                UserId: encodeURI(EmployeeIDG),
                EmployeeName: $("#employeeName").val(),
                // Added by Dipali V on 13th May 2026 - Purpose:-Vendor filter for Exact Match tab (same combo source as Probable).
                VendorID: parseInt(getProbableVendorVal(), 10) || 0
            }
            var param = JSON.stringify(RequestDetails)
            //var data = AJAXCallWithResult("/api/RMResourceAllocation/GetExactResources", param, false);
            AJAXCallWithResultWithCallback("/api/RMResourceAllocation/GetExactResources", param, false, "POST", function (data) {
                var strHTML = "";
                if (data != null) {
                    strHTML += `<table id="Stp0probableRsrsInfoTbl" class="table table-bordered ClsprobableinfoTbl" style="width: 100%;"><thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>BG/OU</th>
                                    <th>Role</th>
                                    <th>Total Free Hrs</th>
                                    <th>Free Hrs Day</th>
                                    <th>Free%</th>
                                     <th id='ExcCaptionType'></th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th id='lblProbabaleExact'>Work hrs(%)</th>
                                    <th>Allocate</th>
                                </tr>
                            </thead>
                            <tbody>`
                    var RequestStartDate = $("#lblchangeFromDate1").text();
                    var RequestEndDate = $("#lblchangeTodate1").text();
                    var fromDateRequestD = new Date(RequestStartDate);
                    fromDateRequest = fromDateRequestD.getDate() + "-" + months[fromDateRequestD.getMonth()] + "-" + String(fromDateRequestD.getFullYear()).slice(-2);
                    var toDateRequestD = new Date(RequestEndDate);
                    toDateRequest = toDateRequestD.getDate() + "-" + months[toDateRequestD.getMonth()] + "-" + String(toDateRequestD.getFullYear()).slice(-2);
                    for (var i = 0; i < data.length; i++) {
                        var EmployeeName = data[i]["EmployeeName"]
                        var EmployeeID = data[i]["EmployeeID"]
                        var Role = data[i]["Role"]
                        var Office = data[i]["Office"]
                        var FreeHours = data[i]["FreeHours"]
                        var WorkHoursPerDay = data[i]["WorkHoursPerDay"]
                        //Added By Dipali v On 11th May 2023 For HH:MM
                        var FreeHoursHH = data[i]["FreeHoursHH"]
                        var WorkHoursPerDayHH = data[i]["WorkHoursPerDayHH"]
                        //End of Added By Dipali v On 11th May 2023 For HH:MM
                        var Department = data[i]["Department"]
                        var BusinessGroup = data[i]["BusinessGroup"]
                        var FreePercentage = data[i]["FreePercentage"]
                        var ResourceAllocation = data[i]["ResourceAllocation"]
                        //debugger;
                        var RequestDetails2 = {
                            FromDate: $("#txthidRequestFromDate").val(),
                            EmployeeId: encodeURI(EmployeeID),
                            ProjectId: $("#txthidProjectId").val(),
                            ToDate: $("#txthidRequestToDate").val(),
                            m_strType: m_strType
                        }
                        //debugger;
                        var param2 = JSON.stringify(RequestDetails2)
                        var data2 = AJAXCallWithResult("/api/RMResourceAllocation/GetMinAllocation", param2, false);
                      
                        if (m_strType != "P") {
                            //Added By Dipali V On 11th May 2023 For HH:MM Format
                            var RequestParameters = {
                                WorkHrs: encodeURI(data2),
                                Flag: encodeURI(1),
                            }
                            var param = JSON.stringify(RequestParameters);
                            var data2WorkHoursConverted = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
                        } else {
                            data2WorkHoursConverted = data2;
                        }
                        //ResourceAllocation = data2
                        strHTML += `<tr>
                                    <td class="rsrsnamelinksTD text-start">
                                        <div class="rsrsnamephoto"><span>
                                            <img src="../../../Whizible2.0-new/dist/img/blankprofile.png" alt="" /></span> ${EmployeeName}</div>                                            
                                        <div class="RsrsUserlinks">
                                            <a href="javascript:ShowResume(${EmployeeID});" class="rsrsnamelinks" >Resume</a>
                                            <a href="javascript:ShowResourceLoading(${EmployeeID})" class="rsrsnamelinks">Resource Loading</a>
                                            <a href="javascript:ShowResourceAllocation(${EmployeeID},'${fromDateGlobal}','${EmployeeName}')" class="rsrsnamelinks">Resource Allocation</a>
                                        </div>
                                    </td>
                                    <td>${Office}</td>
                                    <td>${Role}</td>
                                    <td>${FreeHoursHH}</td>
                                    <td>${WorkHoursPerDayHH}</td>
                                    <td>${FreePercentage}</td>
                                    <td class='exactFreehours'>${data2WorkHoursConverted}</td>
                                    <td>
                                        <div class="input-group">
                                            <input id="txtFromDate_${EmployeeID}" class="form-control input-sm datetimepicker" type="text" value="${fromDateRequest}">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button" style="height: 30px;"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <input id="txtToDate_${EmployeeID}" class="form-control input-sm datetimepicker" type="text" value="${toDateRequest}">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button" style="height: 30px;"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </td>
                                    <td>
                                        <input id="txtWorkHours_${EmployeeID}" type="text" class="form-control input-sm" value="${m_dblRequestedWorkHoursConverted}"/>
                                        <input id="txthdnWorkHours_${EmployeeID}" type="hidden" class="form-control input-sm" value="${m_dblRequestedWorkHours}"/>
                                        <input id="txtMinAllocation_${EmployeeID}" type="hidden" class="form-control input-sm" value="${data2}"/>
                                        <input id="txthidEmployeeName_${EmployeeID}" type="hidden" class="form-control input-sm" value="${EmployeeName}"/></td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="ProbablersrsCheck${EmployeeID}" name='chkAssign' value="${EmployeeID}" class="chcktbl" type="checkbox">
                                            <label for="ProbablersrsCheck${EmployeeID}"></label>
                    
                                        </div>
                                    </td>
                                </tr>`
                    }


                    strHTML += ` </tbody></table>`

                    if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD") {
                        $("#divProbableResource").html(strHTML);
                    } else {
                        $("#divProbableResource_" + FromWhereWhichStatus).html(strHTML);
                    }

                    //<th id='ExcCaptionType'></th> <td>${data2}</td>
                    //Added By Dipali V On 26th April 2023 For Caption Change
                    var LblTypeWise = "Work hrs(%)";
                    var CaptionType = "Max Free%";
                    if (m_strType == "TH") {
                        LblTypeWise = " Total Work Hours";
                        CaptionType = " Max Free Total Hours";
                        $("#ExcCaptionType").hide();
                        $(".exactFreehours").hide();
                    }
                    else if (m_strType == "HPD") {
                        LblTypeWise = "Work Hours";
                        CaptionType = "Max Free Hrs/Day";
                        $("#ExcCaptionType").show();
                        $(".exactFreehours").show();
                    }


                    $("#lblProbabaleExact").text(LblTypeWise);
                    $("#ExcCaptionType").text(CaptionType);
                    //End of Added By Dipali V On 26th April 2023 For Caption Change

                    if (FromWhereWhichStatus == "A" && IsNoAction == "1") {
                        $("#divProbableResource_" + FromWhereWhichStatus).html("<p style='text-align:center'>The number of resources requested have already been allocated</p>");
                    }

                    $("#Stp0probableRsrsInfoTbl").DataTable({
                        "scrollY": false,
                        "scrollX": true,
                        "pageLength": 10,
                        "lengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": true,
                        "retrieve": true,
                        "responsive": true
                    });
                    $('.datetimepicker').datepicker({
                        autoclose: true,
                        changeMonth: true,
                        changeYear: true,
                        dateFormat: 'd-M-y'
                    });
                }



            });

        }

        function SearchProbableResources() {
          // debugger;
            if (selectedTab == 0) {
                GetProbableResources(true);
            }
            else if (selectedTab == 1) {
                GetExactMatch(true);
               // clearFieldsProbable();
            }
        }

        //------------------------------------Extend Req--------------------------
        function ValidExtendRequest() {
          //  debugger;
            var objReqStartDate = $("#txtEffectivePerday_" + FromWhereWhichStatus).val();
            var objReqEndDate = $("#txtExtendNewEndday").val();
            var objProjEndDate = $("#hdnProjectEndDate").val();
            var objUnit = $("#txtNewHrsPerDay_" + FromWhereWhichStatus).val();
            var objPercentage = $("#txtPercentage").val();
            var ProjectID = $("#hdnprojectid").val();
            var ProjectStartDate= $("#hdnProjectStartDate").val();
            var objEndDate = $("#hdnProjectEndDate").val();


            var RequestParameters = {
                RequestType: encodeURI(m_strType),
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(RequestParameters);
            var strResult1 = AJAXCallWithResult("/api/RMResourceAllocation/GetMaxUnits", param, false);
            var m_strMaxUnits = strResult1;

            if (isBlank(objReqEndDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_NewEndDate") %>");
                $("#txtExtendNewEndday").focus();
                return false;
            }
              if (isBlank(objUnit)) {
                  alertify.error("<%= MyBase.GetResourceString("A_NewAllocation") %>");
                  $("#txtNewHrsPerDay_" + FromWhereWhichStatus).focus();
                  return false;

              }
              if (isBlank(objReqStartDate)) {
                  alertify.error("<%= MyBase.GetResourceString("A_NewEffectiveDate") %>");
                  $("#txtEffectivePerday_" + FromWhereWhichStatus).focus();
                  return false;
              }
             <%-- if (Date.parse(objProjEndDate) < Date.parse(objReqEndDate)) {
                  alertify.error("'New End Date' should not be greater than 'Project End Date' (" + objProjEndDate + ")");
                  $('#txtExtendNewEndday').focus();
                  return false;
              }
              if (Date.parse(objReqEndDate) < Date.parse(objReqStartDate)) {
                  alertify.error("<%= MyBase.GetResourceString("A_NewEndDateGraterThanEffectiveDate") %>");
                  $('#txtExtendNewEndday').focus();
                  return false;
              }--%>

            ////Base Need to check 
            if (m_strType != "P") {
                //if (WorkHoursValidation("#txtNewHrsPerDay_" + FromWhereWhichStatus) == true)
                //{ ////Base Need to check
                //    var NewAllocation = $("#txtNewHrsPerDay_" + FromWhereWhichStatus).val();
                //    if (NewAllocation.indexOf(":") > -1) {
                //        var RequestParameters = {
                //            WorkHrs: encodeURI(NewAllocation),
                //            Flag: encodeURI(2),
                //        }
                //        var param = JSON.stringify(RequestParameters);
                //        var NewAllocationValue = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
                //        var objUnit = $("#hiddentxtPrPerOfDay").val(NewAllocationValue);
                //        objUnit = $("#hiddentxtPrPerOfDay").val();
                //    }
                //}
                //else {
                //    return false;
                //}



            } else {
                var NewAllocationValue = $("#txtNewHrsPerDay_" + FromWhereWhichStatus).val();
                $("#hiddentxtPrPerOfDay").val(NewAllocationValue);
                objUnit = $("#hiddentxtPrPerOfDay").val();
                if (isNumeric(NewAllocationValue) == false) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveNumericValueForNewAllocation") %>");
                    $("#txtNewHrsPerDay_" + FromWhereWhichStatus).focus();
                    return false;
                }
            }

            if (objUnit != '' && objUnit == 0) {
                alertify.error('<%= MyBase.GetResourceString("A_NewAllocationGraterzero") %>');
                $("#txtNewHrsPerDay_" + FromWhereWhichStatus).focus();
                return false;
            }

            if (m_strMaxUnits != 0 && m_strType == "TH") {
                if (objPercentage > m_strMaxUnits) {
                    var NewAllocation = $("#txtNewHrsPerDay_" + FromWhereWhichStatus).val();
                    alertify.error('Calculated percentage for &#39;' + NewAllocation + ' Hrs &#39; should be less than or equal to &#39; ' + m_strMaxUnits + '%&#39;');
                    $("#txtNewHrsPerDay_" + FromWhereWhichStatus).focus();
                    return false;
                }


            }
            if (m_strMaxUnits != 0 && m_strType == "HPD") {
                if (objUnit > m_strMaxUnits) {
                    alertify.error("<%= MyBase.GetResourceString("A_NewAllocationGetMaxUniits") %> " + m_strMaxUnits);
                    $("#txtNewHrsPerDay_" + FromWhereWhichStatus).focus();
                    return false;
                }
            }

            if (m_strMaxUnits != 0 && m_strType == "P") {
                if (objUnit > m_strMaxUnits || objUnit < 1) {
                    alertify.error("<%= MyBase.GetResourceString("A_NewAllocationPercenteage") %>" + m_strMaxUnits);
                    $("#txtNewHrsPerDay_" + FromWhereWhichStatus).focus();
                    return false;
                }
            }

           <%-- if (Date.parse(objReqStartDate) <= Date.parse(objEndDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_EffectiveDateGreterEndDate") %>");
                $('#txtEffectivePerday_' + FromWhereWhichStatus).focus();
                return false;
            }--%>

            if (Trim(objUnit) != '' && objUnit == 0) {
                alertify.error("<%= MyBase.GetResourceString("A_NewAllocationGraterzero") %>");
                ("#txtNewHrsPerDay_" + FromWhereWhichStatus).focus();
                return false;
            }


              if (Trim(objReqStartDate) == '' || Trim(objReqEndDate.value) == '' || Trim(objUnit) == '') {
                  return false;
              }

              return true;
          }



        function WorkHoursValidation(ControlID) {
            console.log(ControlID);

            var objHMEffort = document.getElementById(ControlID);

            var objVal = objHMEffort.value;

            var objOldVal = objHMEffort.value;

            if (objHMEffort.value != "") {

                objHMEffort.value = objHMEffort.value.replace(":", ".");

                var isdigit = jQuery.isNumeric(objHMEffort.value);
                objHMEffort.value = objOldVal;

                if (isdigit == false) {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_PositiveNumericForNewAllocation") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_PositiveNumeric") %>');
                    }

                    setFocus(objHMEffort);
                    return false;
                }

                var mm = objVal.split(":")[1];

                if (mm == "") {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAlloHMFormat") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HMFormat") %>');
                    }

                    setFocus(objHMEffort);
                    return false;
                }

                if (objVal.indexOf(":") == -1) {
                    objHMEffort.value = objVal + ":00";
                    objVal = objHMEffort.value;
                }
                if (objHMEffort.value.indexOf(":") == -1) {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAlloHMFormat") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HMFormat") %>');
                    }

                    setFocus(objHMEffort);
                    return false;
                }

                if (objHMEffort.value.indexOf(":") != -1) {
                    objHMEffort.value = objHMEffort.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objHMEffort, "");

                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAlloHMFormat") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HMFormat") %>');
                    }
                    setFocus(objHMEffort);
                    return false;
                }

                blnResult = disallowNonNumeric(objHMEffort, "");

                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAlloHMFormat") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HMFormat") %>');
                    }

                    setFocus(objHMEffort);
                    return false;
                }

                objHMEffort.value = objHMEffort.value.replace('.', ':');

                var WorkHour = objHMEffort.value;

                WorkHour = WorkHour.trim();
                var idxColon = WorkHour.indexOf(':');

                var hrs = WorkHour.substring(0, idxColon);
                var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                if (mins.length == 1 && mins > 5) {
                    mins = mins + "0";
                }
                if (hrs.indexOf("-") != -1) {

                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_HoursNotZeroForNewAllocation") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HoursNotZero") %>');
                    }

                    setFocus(objHMEffort);
                    return false;
                }
                if (hrs <= 0 && mins <= 0) {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAllocationGraterzero") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HoursNotZero") %>');
                    }

                    setFocus(objHMEffort);
                    return false;
                }

                if (mins.length > 2) {
                    alertify.error('<%= MyBase.GetResourceString("A_MinInTwoDecimal") %>');

                    setFocus(objHMEffort);
                    return false;
                }


                if (mins > 59 || mins < 0) {

                    alertify.error('<%= MyBase.GetResourceString("A_MinInRange") %>');


                    setFocus(objHMEffort);

                    return false;
                }

                //var strResult = AJAXCallWithResult("/api/PM_WBS/GetRestrictByMinHours_MinHoursForDAEntry", false);
                var strResult = AJAXCallWithResult("/api/RMResourceAllocation/GetRestrictByMinHours_MinHoursForDAEntry", false);

                if (strResult != undefined) {
                    RestrictByMinHours = strResult.RestrictByMinHours;
                    MinHoursForDAEntry = strResult.MinHoursForDAEntry;
                }


                var MinDAENtryDisplay = "";
                var objMinWorkHrs = MinHoursForDAEntry;

                var MinDAEntry = objMinWorkHrs;

                var objRestrictByMinHours = RestrictByMinHours;


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
                if (objRestrictByMinHours == true) {
                    if (MinDAEntry == 0.016) {
                    }
                    else {
                        var minutes = WorkHour.split(':');

                        var p = minutes[0];
                        var dec = minutes[1];

                        if (dec.length > 2) {
                            dec = dec.substring(0, 2);
                        }
                        if (dec.length == 1) {
                            dec = dec + "0";
                        }
                        if (dec == undefined) { dec = 0; }
                        d = (dec - 0) / 60 + (p - 0);

                        if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                            if (ControlID == 'txtExtResourceNewAllocation') {
                                alertify.error("Please enter the New Allocation in multiple of (" + MinDAENtryDisplay + ") min");

                            }
                            else {
                                alertify.error("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");

                            }
                            setFocus(objHMEffort);
                            return false;
                        }
                    }
                }
            }
            return true;
        }

        function WorkHoursValidation_Allocate(ControlID) {
          //  console.log(ControlID);
         //   debugger;
            var objHMEffort = ControlID;
            var objVal = objHMEffort.value;
            var objOldVal = objHMEffort.value;
            if (objHMEffort.value != "") {

                objHMEffort.value = objHMEffort.value.replace(":", ".");

                var isdigit = jQuery.isNumeric(objHMEffort.value);
                objHMEffort.value = objOldVal;

                if (isdigit == false) {
                    alertify.error('Please Enter only positive numeric');
                    setFocus(objHMEffort);
                    return false;
                }

                var mm = objVal.split(":")[1];

                if (mm == "") {
                    alertify.error('Please enter Work (hrs) in H:M format.');
                    setFocus(objHMEffort);
                    return false;
                }

                if (objVal.indexOf(":") == -1) {
                    objHMEffort.value = objVal + ":00";
                    objVal = objHMEffort.value;
                }
                if (objHMEffort.value.indexOf(":") == -1) {
                    alertify.error('Please enter Work (hrs) in H:M format.');
                    setFocus(objHMEffort);
                    return false;
                }

                if (objHMEffort.value.indexOf(":") != -1) {
                    objHMEffort.value = objHMEffort.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objHMEffort, "");

                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    alertify.error('Please enter Work (hrs) in H:M format.');
                    setFocus(objHMEffort);
                    return false;
                }

                blnResult = disallowNonNumeric(objHMEffort, "");

                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    alertify.error('Please enter Work (hrs) in H:M format.');
                    setFocus(objHMEffort);
                    return false;
                }

                objHMEffort.value = objHMEffort.value.replace('.', ':');

                var WorkHour = objHMEffort.value;

                WorkHour = WorkHour.trim();
                var idxColon = WorkHour.indexOf(':');

                var hrs = WorkHour.substring(0, idxColon);
                var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                if (mins.length == 1 && mins > 5) {
                    mins = mins + "0";
                }
                if (hrs.indexOf("-") != -1) {
                    alertify.error('Hours should not be less than or equal to zero (0).');
                    setFocus(objHMEffort);
                    return false;
                }
                if (hrs <= 0 && mins <= 0) {
                    alertify.error('Hours should not be less than or equal to zero (0).');
                    setFocus(objHMEffort);
                    return false;
                }

                if (mins.length > 2) {
                    alertify.error('Please enter minutes in two decimal and less than 60.');
                    setFocus(objHMEffort);
                    return false;
                }


                if (mins > 59 || mins < 0) {
                    alertify.error('Please enter minutes between (0-59) range');
                    setFocus(objHMEffort);
                    return false;
                }

                //var strResult = AJAXCallWithResult("/api/PM_WBS/GetRestrictByMinHours_MinHoursForDAEntry", false);
                var strResult = AJAXCallWithResult("/api/RMResourceAllocation/GetRestrictByMinHours_MinHoursForDAEntry", false);

                if (strResult != undefined) {
                    RestrictByMinHours = strResult.RestrictByMinHours;
                    MinHoursForDAEntry = strResult.MinHoursForDAEntry;
                }


                var MinDAENtryDisplay = "";
                var objMinWorkHrs = MinHoursForDAEntry;

                var MinDAEntry = objMinWorkHrs;

                var objRestrictByMinHours = RestrictByMinHours;


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
                if (objRestrictByMinHours == true) {
                    if (MinDAEntry == 0.016) {
                    }
                    else {
                        var minutes = WorkHour.split(':');

                        var p = minutes[0];
                        var dec = minutes[1];

                        if (dec.length > 2) {
                            dec = dec.substring(0, 2);
                        }
                        if (dec.length == 1) {
                            dec = dec + "0";
                        }
                        if (dec == undefined) { dec = 0; }
                        d = (dec - 0) / 60 + (p - 0);

                        if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                            if (ControlID == 'txtExtResourceNewAllocation') {
                                alertify.error("Please enter the New Allocation in multiple of (" + MinDAENtryDisplay + ") min");

                            }
                            else {
                                alertify.error("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");

                            }
                            setFocus(objHMEffort);
                            return false;
                        }
                    }
                }
            }
            return true;
        }

        function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
            if (WebConfigSpecialCharacters != '') {
                var regularExpression = WebConfigSpecialCharacters;
                regularExpression += '"';
                var isSpecialCharacter = 0;
                for (var i = 0; i < regularExpression.length; i++) {
                    if (value.indexOf(regularExpression[i]) != -1) {
                        isSpecialCharacter = 1
                    }
                }
                if (isSpecialCharacter == 1) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                return false;
            }
        }


        function ValidPreponeAllocation() {
           // debugger;
            var Checkval = false;
            if (m_strType != "P") {
                var objNewAllocation = document.getElementById("txtNewHrsPerDay_" + FromWhereWhichStatus);
            }
            else {
                var objNewAllocation = document.getElementById("txtNewHrsPerDay_" + FromWhereWhichStatus);
            }
            var objPrevAllocation = document.getElementById("txtPrevAllocation");
            var objReqEffectiveDate = document.getElementById("txtEffectivePerday_" + FromWhereWhichStatus);
            var objReqEndDate = document.getElementById("txtNewEndday");
            var objEndDate = $("#lblpreAED").text();
            var ProjectID = $("#hdnprojectid").val();
            var AllocationPercentage = $("#txtPrevAllocationPercentage").val();
            var objProjEndDate = document.getElementById("hdnProjectEndDate");
            var objStartDate = document.getElementById("lblpreASD");
            var StrEndDate = $("#lblpreAED").text();
            var strStartDate = $("#lblpreASD").val();

            var objWorkHours = document.getElementById("lblNTWH_" + FromWhereWhichStatus);
            var lngHours = $("#lblpreWH").text();
            var m_strHours = $("#lblNTWH_" + FromWhereWhichStatus).text();
            var ChngEmployeeID = $("#txthidEmployeeID").val();
            var SpclRequest = $("#txtPSecipalReq").val();
            if (SpclRequest == "") {
                SpclRequest = "0";
            }
            Hours = parseFloat(lngHours) - parseFloat(m_strHours);

            if (lngHours == "") {
                lngHours = "0";
            }
            if (lngHours.indexOf(':') > -1) {
                lngHours = lngHours.split(":")
                lngHours = lngHours[0];

            }
            RequestParameters = {
                RequestedStartDate: strStartDate,
                RequestedEndDate: objReqEndDate.value,
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(ChngEmployeeID),
                WorkHour: encodeURI(lngHours),
                StrEndDate: StrEndDate,
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RMResourceAllocation/GetAllWorkHours", param, false);
            for (var i = 0; i < Result.length; i++) {
                var m_PreponeHours = Result[i]["WorkHours"];
                var ActualHours = Result[i]["ActualHours"];
                var WorkingDays = Result[i]["WorkingDays"];

            }

            var strMsg, strmsg1;
            if (objReqEndDate.value == '') {
                alertify.error("<%= MyBase.GetResourceString("A_ReqEndDate") %>");
                document.getElementById("txtNewEndday").focus();
                 return false;
             }

          
             <%--if (objNewAllocation.value != objPrevAllocation.value) {
                 if (disallowBlank(objReqEffectiveDate, '') == true) {
                     alertify.error("<%= MyBase.GetResourceString("A_EffDateBlank") %>");
                     document.getElementById("txtEffectivePerday_" + FromWhereWhichStatus).focus();//added by dipali V On 2nd Jan 2020
                     return false;
                 }

             }--%>
           

             <%--if (Date.parse(objReqEndDate.value) >= Date.parse(objEndDate)) {

                 alertify.error("<%= MyBase.GetResourceString("A_ReqEndDateLessEndDate") %>");
                 document.getElementById("txtNewEndday").focus();//added by dipali V On 2nd Jan 2020
                return false;

                if (Date.parse(objStartDate.text()) < Date.parse(objReqEndDate.value)) {
                    alertify.error("<%= MyBase.GetResourceString("A_ReqEndDateLessStartDate") %>");
                    document.getElementById("txtEffectivePerday_" + FromWhereWhichStatus).focus();//added by dipali V On 2nd Jan 2020
                     return false;
                 }
             }--%>


             if (isBlank(objNewAllocation.value)) {
                 alertify.error("<%= MyBase.GetResourceString("A_EnterNewAllocation") %>");
                 $("#txtPrevAllocation").focus();
                 return false;
             }

             if (objNewAllocation.value < 0) {

                 alertify.error("<%= MyBase.GetResourceString("A_NewAllocationBlank") %>");
                 objNewAllocation.value = '';
                 $("#txtPrevAllocation").focus();
                 return false;
             }
             if (objNewAllocation.value == 0) {
                 alertify.error("<%= MyBase.GetResourceString("A_NewAllocationGraterzero") %>");
                 $("#txtPrevAllocation").focus();
                 return false;
             }
             
             else if (checkSpecialCharacter(SpclRequest, WebConfigSpecialCharacters) == true) {
                 alertify.set('notifier', 'position', 'top-right');
                 alertify.error('Special Request should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                 $("#txtPSecipalReq").focus();
                 return false;
             }

            if (m_strType == 'P') {

                strMsg = "<%= MyBase.GetResourceString("A_NewAllocationPercenteage") %>  " + AllocationPercentage;
                if (disallowValueRangeViolation(objNewAllocation, 1, AllocationPercentage, '')) {
                    alertify.error(strMsg);
                    objNewAllocation.value = '';
                    return false;
                }

            }
            if (m_strType == 'HPD') {
                strMsg = 'New Work Hours per day should be in the range of <%=CommonFunctions.Application.MinHoursForDAEntry%> To 24';
                if (disallowValueRangeViolation(objNewAllocation, '<%=CommonFunctions.Application.MinHoursForDAEntry%>', 24, '')) {
                    alertify.error(strMsg);
                    objNewAllocation.value = '';
                    return false;
                }
            }
            if (validWorkHoursAndPrevAllocation() == true) {
               
                if (objNewAllocation.value == objPrevAllocation.value) {
                    var objEffectiveDate = document.getElementById("txtEffectivePerday_" + FromWhereWhichStatus);
                    var objStartDate = $("lblpreASD").text();
                    if (objEffectiveDate.value != objStartDate) {
                        alertify.error('As Allocation is same resetting the effective date to Allocation Start Date.');
                        objEffectiveDate.value=objStartDate;
                        return false;
                    }
                }
                  
                if (parseFloat(objNewAllocation.value) > parseFloat(objPrevAllocation.value)) {
                    RequestParameters = {
                        RequestedStartDate: encodeURI(objReqEffectiveDate.value),
                        RequestedEndDate: encodeURI(objReqEndDate.value),
                        ProjectID: encodeURI(ProjectID),
                        EmployeeID: encodeURI(ChngEmployeeID),
                    }
                    var param = JSON.stringify(RequestParameters);
                    var Result = AJAXCallWithResult("/api/RMResourceAllocation/GetFreeHours", param, false);

                    for (var i = 0; i < Result.length; i++) {
                        var m_dblFreeHours = Result[i]["FreeHours"];
                        var m_dblFreeMinWorkperday = Result[i]["MinimumPerDay"];
                        var m_dblFreeMinWorkpercentage = Result[i]["MinimumPercentage"];

                    }

                    RequestParameters = {
                        RequestedStartDate: encodeURI(objReqEffectiveDate.value),
                        RequestedEndDate: encodeURI(objReqEndDate.value),
                        ProjectID: encodeURI(ProjectID),
                        EmployeeID: encodeURI(ChngEmployeeID),
                        PrevAllocation: encodeURI(objPrevAllocation.value),
                        NewAllocation: encodeURI(objNewAllocation.value),
                        RequestType: encodeURI(m_strType),
                    }
                    var param = JSON.stringify(RequestParameters);
                    var m_extrahrsRequired = AJAXCallWithResult("/api/RMResourceAllocation/GetExtraHours", param, false);
                    m_extrahrsRequired = parseFloat(m_extrahrsRequired);
                    if (m_strType == 'P') {
                       // debugger;
                        if (m_extrahrsRequired > m_dblFreeHours) {
                            $("#AlertMsg").text("<%= MyBase.GetResourceString("A_ExtraHoursResource") %>");
                            $("#confirmationmodal").modal('show');
                            return false;

                        }
                       
                        if (objNewAllocation.value > m_dblFreeMinWorkpercentage) {
                            var m_strerr = "Resource available percentage ( " + m_dblFreeMinWorkpercentage + "%) is less than the requested.";
                            $("#AlertMsg").text(m_strerr);
                            $("#confirmationmodal").modal('show');
                            return false;
                        }

                    } else if (m_strType == 'HPD') {
                        if (objNewAllocation.value > m_dblFreeMinWorkperday) {
                            var m_strerr = "Resource available free work hours per day (" + m_dblFreeMinWorkperday + ") are less than the requested. "
                            $("#AlertMsg").text(m_strerr);
                            $("#confirmationmodal").modal('show');
                            return false;
                        }
                    }
                }
                 //Commented By Dipali V On 18th March 2025 For Prepone Release Issue

               <%-- if (ActualHours != 0) {
                    if (Hours <= ActualHours) {
                        alertify.error("<%= MyBase.GetResourceString("A_PreHoursGreaterAcualHours") %>");
                        return false;
                    }

                }--%>

                if (WorkingDays == 0) {
                    alertify.error("<%= MyBase.GetResourceString("A_PreReleaseWorkingDay") %>");
                    return false;
                }
                 //End of Commented By Dipali V On 18th March 2025 For Prepone Release Issue


                var RequestEndDate = $("#lblpreAED").text();

                RequestParameters = {
                    RequestedEndDate: encodeURI(RequestEndDate),
                    ProjectID: encodeURI(ProjectID),
                    EmployeeID: encodeURI(ChngEmployeeID),

                }
                var param = JSON.stringify(RequestParameters);
                var IntEmployeeid = AJAXCallWithResult("/api/RMResourceAllocation/GetEmployeeId", param, false);
                if (IntEmployeeid != 0) {
                     alertify.error("<%= MyBase.GetResourceString("A_PreTaskEmployeeID") %>");
                     return false;
                 }

             }
             else {
                 return false;
             }

             return true;
         }



        function validWorkHoursAndPrevAllocation() {

            var checkval = true;
            var objNewAllocation = document.getElementById("txtPrevAllocationPercentage");
            var objPrevAllocation = document.getElementById("txtPrevAllocation");
            //var objReqEffectiveDate = $("#txtEffectivePerday_" + FromWhereWhichStatus);
            var objReqEffectiveDate = $("#txtEffectivePerday_" + FromWhereWhichStatus).val()

            var objReqEndDate = document.getElementById("txtNewEndday");
            var objProjEndDate = document.getElementById("hdnProjectEndDate");
            var ProjectStartDate = $("#hdnProjectStartDate").val();

            var objEndDate = $("#lblpreAED").text();
            var ProjectID = $("#hdnprojectid").val();
    
            var StrEndDate = objEndDate;
            var strStartDate = $("#lblpreASD").text();
            var objStartDate = strStartDate;
            var objWorkHours = document.getElementById("lblNTWH_" + FromWhereWhichStatus);
            var objToday = document.getElementById("txtToday");
            var Today = $("#txtToday").val();
            var ReqEffectiveDate = $("#txtEffectivePerday_" + FromWhereWhichStatus).val();
            objprojEndDate = getDate1(objProjEndDate.value);
            objPrevAllocation.disabled = false;
            objWorkHours.disabled = false;

            if (objReqEndDate.value == '') {
                alertify.error("<%= MyBase.GetResourceString("A_ReqEndDate") %>");
                document.getElementById("txtNewEndday").focus();
                return false;
            }
          

         <%--   else if (disallowNegativeNumeric(objWorkHours, "Please enter positive integer") == false) {
          
                if (objWorkHours.value < 0) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveWorkHours") %>");
                    objWorkHours.disabled = true;
                    document.getElementById("txtHours").focus();
                    return false;

                }--%>
              
                //else if (Date.parse(objStartDate) > Date.parse(objReqEndDate.value)) {
                //    alertify.error("New End Date should  be greater than request start date.");
                //    document.getElementById("txtNewEndday").focus();
                //    return false;
                //}
                //else if (Date.parse(objReqEffectiveDate) > Date.parse(objReqEndDate.value)) {
                //    alertify.error("Effective Date Should be less than Requested End Date");
        
                //    $("#txtEffectivePerday_" + FromWhereWhichStatus).focus();
                   
                //    return false;
                //}
                //else if (Date.parse(objReqEndDate.value) > Date.parse(objEndDate)) {
                //    alertify.error("Effective Date Should be greater than or equal to today");
                //    $("#txtEffectivePerday_" + FromWhereWhichStatus).focus();
                //    return false;
                //}

               
                //if ((Date.parse(objToday.value) <= Date.parse(objStartDate)) == false) {

                //    if (Date.parse(objStartDate) >= Date.parse(objReqEffectiveDate)) {
                //        alertify.error("Effective Date Should be greater than or equal Start Date");
                //        $("#txtEffectivePerday_" + FromWhereWhichStatus).focus();
                //        return false;
                //    }
                //}
              
                //else {
                //    if (Date.parse(objPrevAllocation.value) != Date.parse(objNewAllocation.value)) {
                //        if (Date.parse(objToday.value) > Date.parse(objReqEffectiveDate)) {
                //            alertify.error("Effective Date Should be greater than or equal to today.");
                //            $("#txtEffectivePerday_" + FromWhereWhichStatus).focus();
                //            return false;
                //        }
                //    }
                //}

             // }

            //else if (Date.parse(objReqEndDate.value) > Date.parse(objEndDate)) {
            //    alertify.error("New End Date should be less than Request End Date.");
            //    document.getElementById("txtNewEndday").focus();
            //    return false;
            //}
            //else if (Date.parse(objStartDate) > Date.parse(objReqEndDate.value)) {
            //    alertify.error("New End Date should not be less than  Allocation  Start Date.");
                
            //    $("#txtEffectivePerday_" + FromWhereWhichStatus).focus();
                
            //     return false;
            // }

             return true;
         }

        //----------------------------------------------------------------------------
        function AllocateRequest(Flag) {
           // debugger;
            if (Flag == "E") {
                if (ValidExtendRequest() == true) {
                    //  debugger;
                    var m_strRequestedStartDate = $("#txtEffectivePerday_" + FromWhereWhichStatus).val();
                    var m_strRequestedEndDate = $("#txtExtendNewEndday").val();
                    var SpecialRequest = $("#txtESecipalReq").val();
                    var NewAllocationValue = $("#txtNewHrsPerDay_" + FromWhereWhichStatus).val();
                    var objTotalWorkHours = $("#lblNTWH_" + FromWhereWhichStatus).text();
                    var m_intEmployeeID = $("#txthidEmployeeID").val();
                    var ProjectID = $("#hdnprojectid").val()
                    var UserName = '<%=Session("strUserName")%>';
                    var UserID = '<%=Session("intUserID")%>';
                    var RoleID = $("#txthidRoleID").val();
                    var ResourcePoolID = $("#txthidResourcepoolID").val();
                    var Priority = $("#txthidPriority").val();

                    if (SpecialRequest == "") {
                        SpecialRequest = "0";
                    }
                    if (SelectedProjectRoleID == "") {
                        SelectedProjectRoleID = "0";
                    }

                    if (m_strType != "P") {
                        if (NewAllocationValue.indexOf(":") > -1) {

                            var RequestParameters = {
                                WorkHrs: encodeURI(NewAllocationValue),
                                Flag: encodeURI(2),
                            }
                            var param = JSON.stringify(RequestParameters);
                            var NewAllocationValue = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
                        }
                    }
                    else {
                        NewAllocationValue = $("#txtNewHrsPerDay_" + FromWhereWhichStatus).val();
                    }

                    if (m_strType == "HPD") {
                        var m_dblWorkHrsPerDay = NewAllocationValue;
                        //var m_dblPercentage = $("#txtPercentage").val();
                        var m_dblPercentage = NewAllocationValue;
                        //var m_dblTotalWorkHrs = $("#txtTotalWorkHours").val();
                        var m_dblTotalWorkHrs = $("#lblNTWH_" + FromWhereWhichStatus).text();
                    }
                    else if (m_strType == "TH") {
                        //var m_dblTotalWorkHrs = NewAllocationValue;
                        var m_dblTotalWorkHrs = $("#lblNTWH_" + FromWhereWhichStatus).text();
                        var m_dblPercentage = NewAllocationValue;
                        var m_dblWorkHrsPerDay = $("#txtWorkHrsPerDay").val();
                    }
                    else {
                        var m_dblPercentage = NewAllocationValue;
                        //var m_dblTotalWorkHrs = $("#txtTotalWorkHours").val();
                        //var m_dblWorkHrsPerDay = $("#txtWorkHrsPerDay").val();
                        var m_dblTotalWorkHrs = $("#lblNTWH_" + FromWhereWhichStatus).text();
                        var m_dblWorkHrsPerDay = $("#lblHoursperday").text();
                    }

                    var RequestParameters = {
                        RequestedStartDate: encodeURI(m_strRequestedStartDate),
                        RequestedEndDate: encodeURI(m_strRequestedEndDate),
                        EmployeeID: encodeURI(m_intEmployeeID),
                        ProjectID: encodeURI(ProjectID),
                    }
                    var param = JSON.stringify(RequestParameters);
                    var strResult = AJAXCallWithResult("/api/RMResourceAllocation/GetFreeHoursForExtendedBooking", param, false);

                    for (var i = 0; i < strResult.length; i++) {
                        var m_dblFreeHours = strResult[i]["FreeHours"];
                        var dblMinAvailablePerDayHrs = strResult[i]["MinAvailablePerDayHrs"];
                        var dblMinAvailablePercentage = strResult[i]["MinAvailablePercentage"];

                    }
                    if (m_dblFreeHours == null || m_dblFreeHours == '' || m_dblFreeHours == undefined) {
                        m_dblFreeHours = 0;
                    }
                    if (dblMinAvailablePerDayHrs == null || dblMinAvailablePerDayHrs == '' || dblMinAvailablePerDayHrs == undefined) {
                        dblMinAvailablePerDayHrs = 0;
                    }
                    if (dblMinAvailablePercentage == null || dblMinAvailablePercentage == '' || dblMinAvailablePercentage == undefined) {
                        dblMinAvailablePercentage = 0;
                    }

                    if (m_strType == "HPD") {
                        if (m_dblWorkHrsPerDay > dblMinAvailablePerDayHrs) {
                            Flag = 1;
                            alertify.error("Resource available work hours per day (" + dblMinAvailablePerDayHrs + ") are less than the requested. ");

                        }
                    }
                    else if (m_strType == "P") {

                        if (m_dblPercentage > dblMinAvailablePercentage) {
                            Flag = 1;
                            alertify.error("Resource available percentage ( " + dblMinAvailablePercentage + "%) is less than the requested.");
                        }
                    } else {

                        //  Flag = 0;
                        if (m_dblFreeHours < objTotalWorkHours) {
                            Flag = 1;
                            alertify.error('Resource Free Hrs are less than the hours you are assigning him/her for project');
                        }

                    }


                    if (Flag != 1) {
                      //  debugger;
                        if (GRequestID != 0) {
                            var RequestParameters = {
                                RequestedStartDate: m_strRequestedStartDate,
                                RequestedEndDate: m_strRequestedEndDate,
                                Hours: encodeURI(m_dblTotalWorkHrs),
                                SpecialRequest: encodeURI(SpecialRequest),
                                UserName: encodeURI(UserName),
                                UserID: encodeURI(UserID),
                                ResourcePoolID: encodeURI(ResourcePoolID),
                                RoleID: encodeURI(RoleID),
                                TotalWorkHrs: encodeURI(m_dblTotalWorkHrs),
                                Percentage: encodeURI(m_dblPercentage),
                                RequestType: encodeURI(m_strType),
                                ProjectEmployeeRoleID: encodeURI(SelectedProjectRoleID),
                                RequestID: encodeURI(GRequestID),
                                Priority: encodeURI(Priority),
                                ProjectID: encodeURI(ProjectID),
                                EmployeeID: encodeURI(m_intEmployeeID)
                            }
                            var param = JSON.stringify(RequestParameters);

                            var strResult = AJAXCallWithResult("/api/RMResourceAllocation/UpdateExtendedRequest", param, false);
                            var NewResult = strResult.split("||");
                           // debugger;
                            GRequestID = NewResult[0]
                            if (GRequestID != '' || GRequestID != null || GRequestID != undefined) {
                                alertify.success("Extended Request Updated Successfully.");
                               
                                if (NewResult[1] == "False") {
                                    window.open("../Email/SendEmail.aspx?MessageID=502&RequestID=" + GRequestID + "&EmployeeID=" + UserID + "", '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500')
                                }
                                GetRequestDetails("E");
                                GetDetails("Extend", GRequestID);
                            }
                        }
                    }
                }
            }
            else if (Flag == "P") {
                //debugger;
                if (ValidPreponeAllocation() == true) {
                    var ResourcePoolID = "";
                    var RoleID = "";
                    var ProjectID = $("#hdnprojectid").val();
                    var ChngEmployeeID = $("#txthidEmployeeID").val();
                    var UserName = '<%=Session("strUserName")%>';
                    var UserID = '<%=Session("intUserID")%>';
                    var RoleID = $("#txthidRoleID").val();
                    var EmployeeStartDate = $("#lblpreASD").text();
                    RequestParameters = {
                        ProjectID: encodeURI(ProjectID),
                        EmployeeID: encodeURI(ChngEmployeeID),
                    }

                    var param = JSON.stringify(RequestParameters);
                    Result = AJAXCallWithResult("/api/RMResourceAllocation/GetResourcePoolAndRoleId", param, false);
                    for (var i = 0; i < Result.length; i++) {
                        ResourcePoolID = Result[i]["ResourcePoolID"];
                        RoleID = Result[i]["RoleID"];

                    }

                    var RequestedStartDate = $("#txtEffectivePerday_" + FromWhereWhichStatus).val();
                    var RequestedEndDate = $("#txtNewEndday").val();

                    var WorkHour = $("#lblNTWH_" + FromWhereWhichStatus).text();
                    if (WorkHour.indexOf(":") > -1) {

                        var RequestParameters = {
                            WorkHrs: encodeURI(WorkHour),
                            Flag: encodeURI(2),
                        }
                        var param = JSON.stringify(RequestParameters);
                        var NewAllocationValue = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
                        if (NewAllocationValue.indexOf('.00') > -1) {
                            var WorkHour = NewAllocationValue.replace(".00", "");

                        }
                        else {
                            var WorkHour = NewAllocationValue;
                        }
                    }

                    var SpecialRequest = $("#txtPSecipalReq").val();
                    if (RoleID == "") {
                        RoleID = "0"
                    }
                    if (ResourcePoolID == "") {
                        ResourcePoolID = "0"
                    }

                    if (SpecialRequest == "") {
                        SpecialRequest = "0"
                    }

                    if (SelectedProjectRoleID == "") {
                        SelectedProjectRoleID = "0";
                    }
                    //return;
                    RequestParameters = {
                        RequestID: encodeURI(GRequestID),
                        EmployeeID: encodeURI(ChngEmployeeID),
                        ProjectID: encodeURI(ProjectID),
                        ProjectEmployeeRoleID: encodeURI(SelectedProjectRoleID),
                        UserName: encodeURI(UserName),
                        UserID: encodeURI(UserID),
                        RequestedStartDate: RequestedStartDate,
                        RequestedEndDate: RequestedEndDate,
                        Hours: encodeURI(WorkHour),
                        SpecialRequest: encodeURI(SpecialRequest),
                        ResourcePoolID: encodeURI(ResourcePoolID),
                        RoleID: encodeURI(RoleID),
                        RequestType: encodeURI(m_strType),
                        EmployeeStartDate: encodeURI(EmployeeStartDate),
                        sdate: RequestedStartDate,
                        date: RequestedStartDate,
                    }

                    var param = JSON.stringify(RequestParameters);
                    //alert(param);
                    StrResult = AJAXCallWithResult("/api/RMResourceAllocation/UpdatePreponeRequest", param, false);

                    if (StrResult != '') {
                        alertify.success("Prepone Request Updated Successfully.");
                        GetRequestDetails("P");
                        GetDetails("Prepone", GRequestID);
                        window.open("../Email/SendEmail.aspx?MessageID=499&RequestID=" + GRequestID + "&EmployeeID=" + UserID + "", '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500')


                    }
                }
            }
            else if (Flag == "C") {
              //  debugger;
                if (ChangeAllocationNewPerDay() == true) {
                    if (ValidChangeAllocation() == true) {
                        
                        var ProjectID = $("#hdnprojectid").val();
                        var ChngEmployeeID = $("#txthidEmployeeID").val();
                        var ResourcePoolID = "0";
                        var RoleID = "0";

                        RequestParameters = {
                            ProjectID: encodeURI(ProjectID),
                            EmployeeID: encodeURI(ChngEmployeeID),
                        }

                        var param = JSON.stringify(RequestParameters);
                        Result = AJAXCallWithResult("/api/RMResourceAllocation/GetResourcePoolAndRoleId", param, false);
                        for (var i = 0; i < Result.length; i++) {
                            ResourcePoolID = Result[i]["ResourcePoolID"];
                            RoleID = Result[i]["RoleID"];

                        }
                      //  debugger;

                        var NewAllocation = $("#lblNewTotalWorkHours").text();

                        if (m_strType != "P") {
                            if (NewAllocation.indexOf(":") == -1) {
                                NewAllocation = NewAllocation + ":00";
                            }
                            else {
                                NewAllocation = NewAllocation;
                            }
                            var RequestParameters = {
                                WorkHrs: encodeURI(NewAllocation),
                                Flag: encodeURI(2),
                            }
                            var param = JSON.stringify(RequestParameters);
                            NewAllocationValue = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
                        }
                        else {
                            NewAllocationValue = NewAllocation;
                        }

                        //debugger;
                        var EffectiveFromDate = $("#txtInputEffectivePerday").val();
                        var NewWorkHour = $("#txtChngNewWorkHour").val();
                        var SpecialRequest = $("#txtCSecipalReq").val();
                        var objEndDate = $("#lblCAAED").text();
                        var UserName = '<%=Session("strUserName")%>';
                        var UserID = '<%=Session("intUserID")%>';
                        var RoleID = $("#txthidRoleID").val();
                        var Priority = $("#txthidPriority").val();
                        var objStartDate = $("#lblCAASD").text();

                        if (SpecialRequest == "") {
                            SpecialRequest = "0";
                        }
                        if (SelectedProjectRoleID == "") {
                            SelectedProjectRoleID = "0";
                        }

                        if (RoleID == "") {
                            RoleID = "0";
                        }
                       
                        RequestParameters = {
                            RequestID: encodeURI(GRequestID),
                            ProjectID: encodeURI(ProjectID),
                            EmployeeID: encodeURI(ChngEmployeeID),
                            RequestedStartDate: EffectiveFromDate,
                            RequestedEndDate: objEndDate,       
                            Hours: encodeURI(NewAllocationValue),
                            SpecialRequest: encodeURI(SpecialRequest),
                            Priority: encodeURI(Priority),
                            UserName: encodeURI(UserName),
                            UserID: encodeURI(UserID),
                            RequestType: encodeURI(m_strType),
                            ProjectEmployeeRoleID: encodeURI(SelectedProjectRoleID),
                            ResourcePoolID: encodeURI(ResourcePoolID),
                            RoleID: encodeURI(RoleID),
                            sdate: objStartDate,
                            date: EffectiveFromDate
                        }
                        var param = JSON.stringify(RequestParameters);
                        //alert(param);
                        StrResult = AJAXCallWithResult("/api/RMResourceAllocation/UpdateChangeAllocation", param, false);
                        if (StrResult != '') {
                            alertify.success("Change Allocation Updated Successfully.");
                            GetRequestDetails("CHANGE");
                            GetDetails("ChangeAllocation", GRequestID);
                            window.open("../Email/SendEmail.aspx?MessageID=541&RequestID=" + GRequestID + "&EmployeeID=" + UserID + "", '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500')


                        }

                    }
                }
            }
            $(".content .dataTables_wrapper .dataTables_scrollBody, .main_graybgtbs, .content .dataTables_wrapper, .rsralocationfltrs, .backbtn, .addbtn, .content .dataTables_wrapper .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
        }

        function ValidChangeAllocation() {
            var NewAllocation = $("#txtNewHrsPerDay_CHANGE").val();
            var objNewAllocation = document.getElementById("txtNewHrsPerDay_CHANGE");
            var StdAllocationPercentage = $("#txtPrevAllocationPercentage").val();
            var objEffctiveFrmDate = $("#txtInputEffectivePerday").val();
            var objCurrentDate = $("#txtToday").val();
            var objEndDate = $("#txtChngEndDate").val();
            var objProjEndDate = $("#hdnProjectEndDate").val();
            var objReqEndDate = $("#lblCAAED").text();
            var objStartDate = $("#lblCAASD").text();
            var dblstrHours1 = $("#lblNewTotalWorkHours").text();
       
            var ProjectID = $("#hdnprojectid").val();
            var ChngEmployeeID = $("#txthidEmployeeID").val();
            if (m_strType != 'P') {
                if (NewAllocation.indexOf(":") > -1)
                {
                    var RequestParameters = {
                        WorkHrs: encodeURI(NewAllocation),
                        Flag: encodeURI(2),
                    }
                    var param = JSON.stringify(RequestParameters);
                    var NewAllocationValue = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
                    $("#hiddentxtPrPerOfDay").val(NewAllocationValue);
                    NewAllocation = $("#hiddentxtPrPerOfDay").val();
                }
            }

            RequestParameters = {
                RequestedStartDate: encodeURI(objEffctiveFrmDate),
                RequestedEndDate: encodeURI(objReqEndDate),
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(ChngEmployeeID),
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RMResourceAllocation/GetFreeHoursForChangeAllocation", param, false);

            for (var i = 0; i < Result.length; i++) {
                var c_dblFreeHours = Result[i]["FreeHours"];
                var c_dblFreeMinWorkperday = Result[i]["MinimumPerDay"];
                var c_dblFreeMinWorkpercentage = Result[i]["MinimumPercentage"];

            }
            if (c_dblFreeHours == null) {
                c_dblFreeHours = 0;
            }
            if (c_dblFreeMinWorkperday == null) {
                c_dblFreeMinWorkperday = 0;
            }
            if (c_dblFreeMinWorkpercentage == null) {
                c_dblFreeMinWorkpercentage = 0;
            }
            var m_strerr = "";
            if (isBlank(NewAllocation)) {
                alertify.error("<%= MyBase.GetResourceString("A_NewAllocation") %>");
                $('#txtNewHrsPerDay_CHANGE').focus();
                   return false;
               }
               if (isBlank(objEffctiveFrmDate)) {
                   alertify.error("<%= MyBase.GetResourceString("A_EffectivefromDate") %>");
                   $('#txtInputEffectivePerday').focus();
                   return false;
               }
             <%--  if (Date.parse(objStartDate) > Date.parse(objEffctiveFrmDate)) {
                   alertify.error("<%= MyBase.GetResourceString("A_EffeDateGreStartDate") %>");
                   $('#txtInputEffectivePerday').focus();

                   return false;
               }--%>

             <%--  if (Date.parse(objEffctiveFrmDate) > Date.parse(objReqEndDate)) {
                   alertify.error("<%= MyBase.GetResourceString("A_EffedatenotLessEndDate") %>");
                   $('#txtInputEffectivePerday').focus();

                   return false;
               }
            if (Date.parse(objEffctiveFrmDate) > Date.parse(objReqEndDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_EffectiveDateGreEndDate") %>");
                $('#txtInputEffectivePerday').focus();
                return false;
            }--%>

            if (NewAllocation < 0) {
                alertify.error("<%= MyBase.GetResourceString("A_PositiveValueNewAllo") %>");
                $('#txtNewHrsPerDay_CHANGE').focus();
                return false;
            }

            if (NewAllocation == 0) {
                alertify.error("<%= MyBase.GetResourceString("A_NewAllocationGraterzero") %>");
                $('#txtNewHrsPerDay_CHANGE').focus();
                return false;
            }
          <%--  if (NewAllocation == m_OldAllocation) {
                alertify.error("<%= MyBase.GetResourceString("A_NewAlloDiffCurrentAllo") %>");
                $('#txtNewHrsPerDay_CHANGE').focus();
                return false;
            }--%>

           <%-- if (m_strType == 'P') {
                if (disallowValueRangeViolation(objNewAllocation, 1, StdAllocationPercentage, '')) {
                    alertify.error("<%= MyBase.GetResourceString("A_NewAllocationPercenteage") %>" + StdAllocationPercentage)
                    //objNewAllocation.value = '';
                    return false;
                }
            }--%>
            if (m_strType == 'HPD') {
                if (disallowValueRangeViolation(objNewAllocation, 1, 24, '')) {
                    alertify.error("<%= MyBase.GetResourceString("A_WorkHoursPerDay") %>")
                   // objNewAllocation.value = '';
                    return false;
                }
            }
           <%-- if (Date.parse(objCurrentDate) > Date.parse(objEffctiveFrmDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_EffeDateNotLessCurrentDate") %>");
                $('#txtInputEffectivePerday').focus();
                return false;
            }--%>

            <%--if (Date.parse(objEffctiveFrmDate) > Date.parse(objEndDate)) {
                   alertify.error("<%= MyBase.GetResourceString("A_EffecDateNotGreEndDate") %>");
                $('#txtInputEffectivePerday').focus();
                   return false;
               }
               if (Date.parse(objEffctiveFrmDate) > Date.parse(objProjEndDate)) {
                   alertify.error("Effctive From Date Should Not Be Greater Than Project End Date (" + objProjEndDate + ")");
                   $('#txtInputEffectivePerday').focus();
                   return false;
               }--%>

            if (parseFloat(c_dblFreeHours) < parseFloat(dblstrHours1)) {

                alertify.error("Resource Free Hrs are less than the hours you are requesting.");
                $('#txtNewHrsPerDay_CHANGE').focus();
                return false;
            }
            if (m_strType == "P") {
                if (NewAllocation > c_dblFreeMinWorkpercentage) {
                    alertify.error("Resource available percentage ( " + c_dblFreeMinWorkpercentage + "%) is less than the requested.");
                    $('#txtNewHrsPerDay_CHANGE').focus();
                    return false;
                }
            }
            if (m_strType == "HPD") {
                   if (NewAllocation > c_dblFreeMinWorkperday) {

                       alertify.error("Resource available  work hours per day (" + c_dblFreeMinWorkperday + ") are less than the requested. ");
                       $('#txtNewHrsPerDay_CHANGE').focus();
                       return false;
                   }
               }
               return true;
           }


        function ChangeAllocationNewPerDay() {

            if (m_strType != 'P') {
               // if (WorkHoursValidation("txtChngNewPerDay") == true) {

                    var NewAllocation = $("#txtChngNewPerDay").val();
                    if (m_strType != 'HPD') {
                        $("#txtChngNewWorkHour").val(NewAllocation);
                        $("#txtChngNewWorkHour").prop("disabled", true);
                        $("#txtChngHours").val(NewAllocation);
                    }
                    var ValuetxtPrPerOfDay = $("#txtChngNewPerDay").val()
                    $("#hiddentxtPrPerOfDay").val(ValuetxtPrPerOfDay);
                    var WorkHours = $("#hiddentxtPrPerOfDay").val();
                    if (WorkHours.indexOf(":") > -1) {

                        var RequestParameters = {
                            WorkHrs: encodeURI(WorkHours),
                            Flag: encodeURI(2),
                        }
                        var param = JSON.stringify(RequestParameters);
                        var NewAllocationValue = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
                        var ValuehiddentxtPrPerOfDay = $("#hiddentxtPrPerOfDay").val(NewAllocationValue);
                    }

                    else {
                        return true;
                    }

                //}
                //else {
                //    return false;
                //}
            }
            var NewAllocation = $("#txtChngNewPerDay").val();
            $("#hiddentxtPrPerOfDay").val(NewAllocation);

            return true;
        }



        function Allocate_OnClick(flag) {
           // debugger;
            //if (blnIsSaveClicked != 0) { return; }
            var url = new String();
            var objFromDate, objToDate, objWorkHours, objEmployeeID;
            var objchkAssign, intCnt;
            var lngRequestId = GRequestID;
            var strHtm = '';

            if (ValidateInputs(flag)) {

                objchkAssign = document.getElementsByName('chkAssign');
                var allocateResourceParams = [];
                for (intCnt = 0; intCnt < objchkAssign.length; intCnt++) {
                    if (objchkAssign[intCnt].checked == true) {
                        objEmployeeID = objchkAssign[intCnt].value;
                        objFromDate = document.getElementById('txtFromDate_' + objchkAssign[intCnt].value + (flag == undefined ? "" : "_1")).value;
                        objToDate = document.getElementById('txtToDate_' + objchkAssign[intCnt].value + (flag == undefined ? "" : "_1")).value;
                        objWorkHours = document.getElementById('txtWorkHours_' + objchkAssign[intCnt].value + (flag == undefined ? "" : "_1")).value;
                        //objWorkHours = document.getElementById('txthdnWorkHours_' + objchkAssign[intCnt].value + (flag == undefined ? "" : "_1")).value;
                        if (objWorkHours.indexOf(':') > -1) {
                            var RequestParameters = {
                                WorkHrs: encodeURI(objWorkHours),
                                Flag: encodeURI(2),
                            }
                            var param = JSON.stringify(RequestParameters);
                            var WorkHours = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
                            objWorkHours = WorkHours
                        } else {
                            objWorkHours = objWorkHours;
                        }
                        
                        allocateResourceParams.push({
                            RequestID: GRequestID,
                            EmployeeId: objchkAssign[intCnt].value,
                            FromDate: objFromDate,
                            ToDate: objToDate,
                            WorkHours: objWorkHours,
                            ProjectID: document.getElementById("txthidProjectId").value,
                            ProjectRoleId: $("#cboProjectRole" + (flag == undefined ? "" : "_1")).val(),
                            status: $("#cboStatus" + (flag == undefined ? "" : "_1")).val()
                        })
                    }
                }

                var param = JSON.stringify({ "allocateResourceParams": allocateResourceParams });
                var strResult = AJAXCallWithResult("/api/RMResourceAllocation/AllocateResources", param, false);
                if (strResult) {
                    if (strResult.blnShowPopup) {
                        window.open("../Email/SendEmail.aspx?MessageID=76&RequestID=" + GRequestID + "&EmployeeID=" + strResult.EmployeeIds + "", '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500')
                    }
                    else if (strResult.isError) {
                        alertify.error(strResult.message);
                    }

                    if (selectedTab == 0) {
                        GetProbableResources(true);
                    }
                    else if (selectedTab == 1) {
                        GetExactMatch(true);
                    }
                    $(".content .dataTables_wrapper .dataTables_scrollBody, .main_graybgtbs, .content .dataTables_wrapper, .rsralocationfltrs, .backbtn, .addbtn, .content .dataTables_wrapper .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

                    GetRequestDetails(FromWhereWhichStatus, FromWhereflag);
                    if (flag == 1) {
                        $("#searchmoreModal").modal('hide');
                    }
                    cancledetailpanel();

                }
            }
            $(".content .dataTables_wrapper .dataTables_scrollBody, .main_graybgtbs, .content .dataTables_wrapper, .rsralocationfltrs, .backbtn, .addbtn, .content .dataTables_wrapper .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

        }

        function ShowResume(intEmployeeID) {
            //debugger;
            var LoginEmployeeID = '<%= Session("intUserID") %>';
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: '../Resources/RM_ResourceAllocation.aspx/Resume_OnClick',
                data: JSON.stringify({ EmployeeID: intEmployeeID, LoginEmployeeID: LoginEmployeeID }),
                success: function (Result) {
                    //window.open("../Resources/Resume.aspx?Token=" + Result.d + "&EmployeeID=" + intEmployeeID, "new", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 550) / 2 + ",width=700,height=550");
                    window.open("../Resources/RM_Resume.aspx?PKToken=" + Result.d + "&EmployeeID=" + intEmployeeID + "&TagID=1225", "new", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 550) / 2 + ",width=700,height=550");

                },
                error: function () {
                }
            });
        }

        function ShowResourceLoading(intEmployeeID) {
            var dtToday = new Date();
            var ProjectID= document.getElementById("txthidProjectId").value
            var ProjectName = $("#lblchangeProjectName1").text();
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: '../Resources/RM_ResourceAllocation.aspx/ResourceLoad_OnClick',
                data: JSON.stringify({ EmployeeID: intEmployeeID, ProjectID: ProjectID }),
                success: function (Result) {
                    //window.open("../../PM/PM_ResourceHistory.aspx?Token=" + Result.d + "&EmployeeID=" + intEmployeeID + "&Year=" + dtToday.getFullYear(), "new", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=700,height=500");
                    window.open("../PM/PM_ResourceLoading.aspx?PKToken=" + Result.d + "&ProjectID=" + ProjectID + " &EmployeeID=" + intEmployeeID + " &Link=AR" + "&ProjectName=" + ProjectName + "&MasterTagId=3861", "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 920) / 2 + ",top=" + (window.screen.height - 900) / 2 + ",width=900,height=600");


                },
                error: function () {
                }
            });
        }

        function ShowResourceAllocation(EmployeeID, startdate, EmployeeName) {
            startdate = new Date(startdate).toLocaleDateString();
            //$.ajax({
            //    type: 'POST',
            //    dataType: 'json',
            //    contentType: 'application/json',
            //    url: '../../PM_ResourceAllocationDetails.aspx/ResourceAlloc_OnClick',
            //    data: JSON.stringify({ EmployeeID: EmployeeID, FinancialPeriodCount: "0", SpecificDate: startdate }),
            //    success: function (Result) {
                   // window.open("../../HR/ResourceAllocationDashbaord.aspx?Token=" + Result.d + "&Mode=RESOURCE&EmployeeId=" + EmployeeID + "&FinancialType=D&FinancialPeriodCount=0&SpecificDate=" + startdate, "new", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 330) / 2 + ",width=650,height=330")
                    PopUpWindow("../../NewAPI/Resources/RM_ResourceAllocationView.aspx?RequestID=" + GRequestID + "&Fromdate=" + startdate + "&EmployeeName=" + EmployeeName + "&EmployeeID=" + EmployeeID, 1150, 500);


            //    },
            //    error: function () {
            //    }
            //});
        }

        //function GetResourceAllocationPage() {
        //    var Fromdate = "21-Feb-2021";
        //    var EmployeeName = "Aishwarya Chouksey";
        //    var EmployeeID = 4237;
        //    PopUpWindow("../../NewAPI/Resources/RM_ResourceAllocationView.aspx?RequestID=3&Fromdate=" + Fromdate + "&EmployeeName=" + EmployeeName + "&EmployeeID=" + EmployeeID, 1150, 500);
        //}


        //Resource by Rolls chart
        var SkillName = [];
        var NoOfResource = [];
        function GetSkillGraph() {
            $.ajax({
                url: strUrl + '/api/RMResourceAllocation/GetSkillGraph',
                method: "POST",
                dataType: 'json',
                async: false,
                // data: JSON.stringify(StatusData),
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_resource"));
                    //if (param) {
                    //    xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    //}
                },
                success: function (Data) {
                    for (var i = 0; i < Data.length; i++) {
                        var d = Data[i];
                        var Skill = d.Description;
                        var Resource = d.NoOfResources;
                        SkillName.push(Skill);
                        NoOfResource.push(Resource);
                    }


                    var ctx = document.getElementById("RAChart").getContext('2d');
                    var myChart = new Chart(ctx, {
                        type: 'pie',
                        data: {

                            labels: SkillName,
                            datasets: [{
                                labels:
                                    [SkillName],
                                data: NoOfResource,
                                backgroundColor: [
                                    "#2ecc71",
                                    "#3498db",
                                    "#95a5a6",
                                    "#9b59b6",
                                    "#f1c40f",
                                ],
                            }]
                        },
                        maintainAspectRatio: false,
                        options: {
                            responsive: true,
                            plugins: {
                                legend: {
                                    position: "right",
                                    align: "middle"
                                }
                            }
                        }
                    });
                }
            });
        }

        function reset() {
            canvas = document.getElementById("SkillChartTab");
            context = canvas.getContext("2d");
            context.clearRect(0, 0, canvas.width, canvas.height);
        }

        var myChart;
        function GetSkillGraph1() {
            SkillName = [];
            NoOfResource = [];
            $.ajax({
                url: strUrl + '/api/RMResourceAllocation/GetSkillGraph',
                method: "POST",
                dataType: 'json',
                data:JSON.stringify(GRequestID),
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_resource"));
                    //if (param) {
                    //    xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    //}
                },
                success: function (Data) {
                    for (var i = 0; i < Data.length; i++) {
                       //debugger;
                        var d = Data[i];
                        var Skill = d.Description;
                        var Resource = d.NoOfResources;
                        SkillName.push(Skill);
                        NoOfResource.push(Resource);
                    }

                   // alert(FromWhereWhichStatus);
                    //var myChart = "";
                    //var ctx = "";
                    //reset();
                    if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD" || FromWhereWhichStatus == "C") {
                        ctx = document.getElementById("SkillChartTab").getContext('2d');
                       // $('#SkillChartTab').remove();
                    } else {
                        ctx = document.getElementById("SkillChartTab_" + FromWhereWhichStatus).getContext('2d');
                       // $('#SkillChartTab_' + FromWhereWhichStatus).remove();
                    }

                   //if (myChart != undefined) {
                   //     myChart.destroy();
                   // }

                    if (myChart) {
                        myChart.destroy();
                    }
                     myChart = new Chart(ctx, {
                        type: 'pie',
                        data: {

                            labels: SkillName,
                            datasets: [{
                                labels:
                                    [SkillName],
                                data: NoOfResource,
                                backgroundColor: [
                                    "#2ecc71",
                                    "#3498db",
                                    "#95a5a6",
                                    "#9b59b6",
                                    "#f1c40f",
                                ],
                            }]
                        },
                        maintainAspectRatio: false,
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: "right",
                                    align: "middle"
                                }
                            }
                        }
                    });
                }
            });
        }
        /* '---------------------------------------------------------*/
        //Added By Dipali V On 30th Dce 2019 For Skill Functionality


        var Fromwhereclause = "";
        var FromWhereWhichStatus = "";
        var FromWhereflag = undefined;
        var IsNoAction = 0;
        var m_strType = "";
        function GetRequestDetails(TypeOfStatus, flag) {
           // debugger;
            Fromwhereclause = "";
            if (TypeOfStatus != FromWhereWhichStatus) {
                ClearGridFilter();
                //Fromwhereclause = "";
                IsNoAction = 0;
            }
            /*GetCurrentFinalcialYear();*/
            FromWhereWhichStatus = "";
            FromWhereWhichStatus = TypeOfStatus;
            FromWhereflag = flag;
            var ProjectName = $("#TxtProjectName").val();
            var RequestID = $("#TxtRequestID").val();
            var NatureOfRequest = $("#cboNatureOfRequest").val();
            var FromDate = $("#TxtRequestExtendFromDate").val();
            var ToDate = $("#TxtRequestExtendToDate").val();
            var EmployeeID = '<%= Session("intUserID") %>';
            
           
            if (FromDate == "") {
                FromDate = GlobalRequeststartDate;
            }

            if (ToDate == "") {
                ToDate = GlobalRequestEndDate;
            }
            //debugger;
            if ((FromDate != "" || ToDate != "") && Fromwhereclause != "") {
                Fromwhereclause += " AND";
            }

            if (FromDate != "" || ToDate != "") {
                Fromwhereclause += " RequestDate between ''" + FromDate + "'' AND ''" + ToDate + "'' ";
            }
            else if (FromDate != "") {
                Fromwhereclause += " RequestDate >= ''" + FromDate + "'' ";
            }
            else if (ToDate != "") {
                Fromwhereclause += " RequestDate <= ''" + ToDate + "'' ";
            }

            var ResourcesDetails = {
                ProjectName: encodeURI(ProjectName),
                RequestID: encodeURI(RequestID),
                EmployeeID: encodeURI(EmployeeID),
                NatureOfRequest: encodeURI(NatureOfRequest),
                OrderBy: encodeURI("RequestDate ASC"),
                Fromwhereclause: encodeURI(Fromwhereclause),
                Status: encodeURI(FromWhereWhichStatus),
            }
            var param = JSON.stringify(ResourcesDetails);
            var strResult = AJAXCallWithResult("/api/RMResourceAllocation/GetExtendRequest", param, false);
            //if (FromWhereWhichStatus == 'All') {
            if (FromWhereWhichStatus == 'O') {
                GetRequestDetails('R', 1);
            }
            //debugger;
            if (flag == undefined) {
                $("#table" + FromWhereWhichStatus).dataTable().fnDestroy();
                $("#tbody" + FromWhereWhichStatus).html("");
            }
            else {
                $("#table" + FromWhereWhichStatus + "1").dataTable().fnDestroy();
                $("#tbody" + FromWhereWhichStatus + "1").html("");
            }
            if (strResult.length != 0) {
                var Strextendhtml = "";
                for (var i = 0; i < strResult.length; i++) {

                    var Type = "";
                    var WorkHours = "";
                    var TotalAssignedResources = "";
                    if (strResult[i].Type == "P") {
                        Type = "% Of Day";
                    }
                    else if (strResult[i].Type == "HPD") {
                        Type = "Per Day";
                    }
                    else if (strResult[i].Type == "TH") {
                        Type = "Total Hours";
                    }

                    if (strResult[i].TotalAssignedResources == "0") {
                        TotalAssignedResources = "No";
                    } else {
                        TotalAssignedResources = "Yes";
                    }

                    m_strType = strResult[i].Type;
                    m_VendorID = strResult[i].VendorID;
                    m_lngVendorId = parseInt(strResult[i].VendorID, 10) || parseInt(strResult[i].vendorID, 10) || 0;
                   // debugger;
                    if (strResult[i].ConvertedWorkHours == null) {
                        ConvertedWorkHours = "0";
                    } else {
                        if (strResult[i].Type == "P") {
                            //ConvertedWorkHours = strResult[i].ConvertedWorkHours.toFixed(2);
                            ConvertedWorkHours = strResult[i].ConvertedWorkHours;
                        }
                        else {
                            ConvertedWorkHours = strResult[i].ConvertedWorkHours;
                        }
                    }
                    if (FromWhereWhichStatus == "E") {
                        Strextendhtml += '<tr class="" style="">';
                        Strextendhtml += '<td>' + strResult[i].RequestID + '</td >';
                        Strextendhtml += '<td>' + strResult[i].RequestDate + '</td>';
                        Strextendhtml += '<td>' + strResult[i].Project + '</td>';
                        Strextendhtml += '<td>' + strResult[i].Requestor + '</td>';
                        Strextendhtml += '<td>' + strResult[i].FromDate + '</td>';
                        Strextendhtml += '<td>' + strResult[i].ToDate + '</td>';
                        Strextendhtml += '<td>' + Type + '</td>';
                       // Strextendhtml += '<td>' + WorkHours + '</td>';
                        Strextendhtml += '<td>' + ConvertedWorkHours + '</td>';
                        Strextendhtml += '<td>' + TotalAssignedResources + '</td>';
                        Strextendhtml += '<td class="TDactioncol">';
                        Strextendhtml += '<a href="javascript:;" class="editdetails" onclick=GetDetails("Extend",' + strResult[i].RequestID + ')><i class="fas fa-pencil-alt" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-title="Edit Details"></i></a>';
                        Strextendhtml += '</td>';
                        Strextendhtml += '</tr >';
                    }
                    else if (FromWhereWhichStatus == "P") {
                        Strextendhtml += '<tr class="" style="">';
                        Strextendhtml += '<td>' + strResult[i].RequestID + '</td >';
                        Strextendhtml += '<td>' + strResult[i].RequestDate + '</td>';
                        Strextendhtml += '<td>' + strResult[i].Project + '</td>';
                        Strextendhtml += '<td>' + strResult[i].Requestor + '</td>';
                        Strextendhtml += '<td>' + strResult[i].FromDate + '</td>';
                        Strextendhtml += '<td>' + strResult[i].ToDate + '</td>';
                        Strextendhtml += '<td>' + Type + '</td>';
                       // Strextendhtml += '<td>' + WorkHours + '</td>';
                        Strextendhtml += '<td>' + ConvertedWorkHours + '</td>';
                        Strextendhtml += '<td>' + TotalAssignedResources + '</td>';
                        Strextendhtml += '<td class="TDactioncol">';
                        Strextendhtml += '<a href="javascript:;" class="editdetails" onclick=GetDetails("Prepone",' + strResult[i].RequestID + ')><i class="fas fa-pencil-alt" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-title="Edit Details"></i></a>';
                        Strextendhtml += '</td>';
                        Strextendhtml += '</tr >';
                    }
                    else if (FromWhereWhichStatus == "CHANGE") {
                        Strextendhtml += '<tr class="" style="">';
                        Strextendhtml += '<td>' + strResult[i].RequestID + '</td >';
                        Strextendhtml += '<td>' + strResult[i].RequestDate + '</td>';
                        Strextendhtml += '<td>' + strResult[i].Project + '</td>';
                        Strextendhtml += '<td>' + strResult[i].Requestor + '</td>';
                        Strextendhtml += '<td>' + strResult[i].FromDate + '</td>';
                        Strextendhtml += '<td>' + strResult[i].ToDate + '</td>';
                        Strextendhtml += '<td>' + Type + '</td>';
                        Strextendhtml += '<td>' + TotalAssignedResources + '</td>';
                        Strextendhtml += '<td class="TDactioncol">';
                        Strextendhtml += '<a href="javascript:;" class="editdetails" onclick=GetDetails("ChangeAllocation",' + strResult[i].RequestID + ')><i class="fas fa-pencil-alt" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-title="Edit Details"></i></a>';
                        Strextendhtml += '</td>';
                        Strextendhtml += '</tr >';
                    }
                    else if (FromWhereWhichStatus == "C") {
                        Strextendhtml += '<tr class="" style="">';
                        Strextendhtml += '<td>'+ strResult[i].RequestID + '</td>';
                        Strextendhtml += '<td>' + strResult[i].RequestDate + '</td>';
                        Strextendhtml += '<td>' + strResult[i].Project + '</td>';
                        Strextendhtml += '<td>' + strResult[i].Requestor + '</td>';
                        Strextendhtml += '<td>' + strResult[i].FromDate + '</td>';
                        Strextendhtml += '<td>' + strResult[i].ToDate + '</td>';
                        Strextendhtml += '<td>' + Type + '</td>';
                        //Strextendhtml += '<td>' + WorkHours  + '</td>';
                        Strextendhtml += '<td>' + ConvertedWorkHours  + '</td>';
                        Strextendhtml += '<td>' + strResult[i].NoOfResources + '</td>';
                        Strextendhtml += '<td>' + strResult[i].TotalAssignedResources + "</td>";
                        Strextendhtml += '<td class="TDactioncol"><input type="hidden" id="DelineComment_' + strResult[i].RequestID + '" value="' + strResult[i].CancelComment + '" </input>';
                        Strextendhtml += '<a href="javascript:;" class="editdetails" onclick=GetDetails("Close",' + strResult[i].RequestID + ',1)><i class="fas fa-pencil-alt" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-title="Edit Details"></i></a><a href="javascript:;" class="viewcoments"  onclick=GetComments("CLOSE",' + strResult[i].RequestID + ')><i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="View Comments" class="far fa-comment-dots"></i></a>';
                        Strextendhtml += '</td>';
                        Strextendhtml += '</tr>';

                    }
                    else if ( FromWhereWhichStatus == "ESCALATE") {
                        Strextendhtml += "<tr class='' style=''>";
                        Strextendhtml += "<td> " + strResult[i].RequestID + "</td>";
                        Strextendhtml += "<td> " + strResult[i].RequestDate + "</td>";
                        Strextendhtml += "<td>" + strResult[i].Project + "</td>";
                        Strextendhtml += "<td>" + strResult[i].Requestor + "</td>";
                        Strextendhtml += "<td>" + strResult[i].FromDate + "</td>";
                        Strextendhtml += "<td>" + strResult[i].ToDate + "</td>";
                        Strextendhtml += "<td>" + Type + "</td>";
                        //Strextendhtml += "<td>" + WorkHours + "</td>";
                        Strextendhtml += "<td>" + ConvertedWorkHours + "</td>";
                        Strextendhtml += "<td>" + strResult[i].TotalAssignedResources + "</td>";
                        Strextendhtml += "</tr>";

                    }
                    else if (FromWhereWhichStatus == "D") {
                        Strextendhtml += "<tr class='' style=''>";
                        Strextendhtml += "<td> " + strResult[i].RequestID + "</td>";
                        Strextendhtml += "<td> " + strResult[i].RequestDate + "</td>";
                        Strextendhtml += "<td>" + strResult[i].Project + "</td>";
                        Strextendhtml += "<td>" + Type + "</td>";
                        Strextendhtml += "<td>" + strResult[i].NoOfResources + "</td>";
                        Strextendhtml += "<td>" + strResult[i].TotalAssignedResources + "</td>";
                        Strextendhtml += "<td>" + strResult[i].RequestStatus + "</td>";
                        Strextendhtml += "<td>" + strResult[i].ProjectStatus + "</td>";
                        Strextendhtml += "</tr>";
                    }

                    else if (FromWhereWhichStatus == "REJECT") {
                        Strextendhtml += '<tr class="" style="">';
                        Strextendhtml += '<td>' + strResult[i].RequestID + '</td >';
                        Strextendhtml += '<td>' + strResult[i].RequestDate + '</td>';
                        Strextendhtml += '<td>' + strResult[i].Project + '</td>';
                        Strextendhtml += '<td>' + strResult[i].Requestor + '</td>';
                        Strextendhtml += '<td>' + strResult[i].FromDate + '</td>';
                        Strextendhtml += '<td>' + strResult[i].ToDate + '</td>';
                        Strextendhtml += '<td>' + Type + '</td>';
                        //Strextendhtml += '<td>' + WorkHours+ '</td>';
                        Strextendhtml += '<td>' + ConvertedWorkHours+ '</td>';
                        Strextendhtml += '<td>' + strResult[i].NoOfResources + '</td>';
                        Strextendhtml += '<td>' + strResult[i].TotalAssignedResources + '</td>';
                        Strextendhtml += '<td class="TDactioncol"><input type="hidden" id="DelineComment_' + strResult[i].RequestID + '" value="' + strResult[i].RejectComment + '" </input>';
                        Strextendhtml += '<a href="javascript:;" class="viewcoments"  onclick=GetComments("REJECT",' + strResult[i].RequestID + ')><i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="View Comments" class="far fa-comment-dots"></i></a>';
                        Strextendhtml += '</td>';
                        Strextendhtml += '</tr >';
                    }


                    else if (FromWhereWhichStatus == "A") {
                        Strextendhtml += '<tr class="" style="">';
                        Strextendhtml += '<td>' + strResult[i].RequestID + '</td >';
                        Strextendhtml += '<td>' + strResult[i].RequestDate + '</td>';
                        Strextendhtml += '<td>' + strResult[i].Project + '</td>';
                        Strextendhtml += '<td>' + strResult[i].Requestor + '</td>';
                        Strextendhtml += '<td>' + strResult[i].FromDate + '</td>';
                        Strextendhtml += '<td>' + strResult[i].ToDate + '</td>';
                        Strextendhtml += '<td>' + Type + '</td>';
                        //Strextendhtml += '<td>' + WorkHours + '</td>';
                        Strextendhtml += '<td>' + ConvertedWorkHours + '</td>';
                        Strextendhtml += '<td>' + strResult[i].NoOfResources + '</td>';
                        Strextendhtml += '<td>' + strResult[i].TotalAssignedResources + '</td>';
                        Strextendhtml += '<td class="TDactioncol">';
                        Strextendhtml += '<a href="javascript:;" class="editdetails" onclick=GetDetails("Allocation",' + strResult[i].RequestID + ')><i class="fas fa-pencil-alt" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-title="Edit Details"></i></a>';
                        Strextendhtml += '</td>';
                        Strextendhtml += '</tr >';
                    }

                }



            }
           // debugger;
            if (FromWhereWhichStatus == "R" || FromWhereWhichStatus == "Replace" || FromWhereWhichStatus == "NBD") {

                Strextendhtml = `<table class="table table-bordered table-stripped cls_insideTbl" id="table${FromWhereWhichStatus}${flag == undefined ? "" : "1" }" style="width:100%;">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("C_ID") %></th>
                                <th width="80px"><%= MyBase.GetResourceString("C_REQUESTDATE") %></th>
                                <th width="200px"><%= MyBase.GetResourceString("C_PROJECTNAME") %></th>
                                <th><%= MyBase.GetResourceString("C_REQUESTOR") %></th>
                                <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                <th><%= MyBase.GetResourceString("C_TODATE") %></th>
                                <th><%= MyBase.GetResourceString("C_ALLOCATIONTYPE") %></th>
                                <th><%= MyBase.GetResourceString("C_HOURS") %> / Percentage</th>
                                <th><%= MyBase.GetResourceString("C_REQUESTED") %></th>
                                <th><%= MyBase.GetResourceString("C_ASSIGNED") %></th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>`
                for (var i = 0; i < strResult.length; i++) {
                    console.log(strResult);
                    var Type = "";
                    var TotalAssignedResources = "";
                    var ConvertedWorkHours = "";
                    if (strResult[i].Type == "P") {
                        Type = "% Of Day";
                    }
                    else if (strResult[i].Type == "HPD") {
                        Type = "Per Day";
                    }
                    else if (strResult[i].Type == "TH") {
                        Type = "Total Hours";
                    }

                    if (strResult[i].TotalAssignedResources == "0") {
                        TotalAssignedResources = "No";
                    } else {
                        TotalAssignedResources = "Yes";
                    }

                    if (strResult[i].ConvertedWorkHours == null) {
                        ConvertedWorkHours = "0";
                    } else {
                        if (strResult[i].Type == "P") {
                            //ConvertedWorkHours = strResult[i].ConvertedWorkHours.toFixed(2);
                            ConvertedWorkHours = strResult[i].ConvertedWorkHours;
                        }
                        else {
                            ConvertedWorkHours = strResult[i].ConvertedWorkHours;
                        }
                    }

                    Strextendhtml += ` <tr class="">
                                <td>${strResult[i].RequestID}</td>
                                <td>${strResult[i].RequestDate}</td>
                                <td>${strResult[i].Project}</td>
                                <td>${strResult[i].Requestor}</td>
                                <td>${strResult[i].FromDate}</td>
                                <td>${strResult[i].ToDate}</td>
                                <td>${Type}</td>
                                <td>${ConvertedWorkHours}</td>
                                <td>${strResult[i].NoOfResources}</td>
                                <td>${strResult[i].TotalAssignedResources}</td>
                                <td class="TDactioncol">
                                    <a href="javascript:;" class="editdetails" onclick="GetDetails('${FromWhereWhichStatus}',${strResult[i].RequestID},1)"><i class="fas fa-pencil-alt" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-title="Edit Details"></i></a>
                                </td>
                            </tr>`
                }
                Strextendhtml += `</tbody>
                    </table>`
                if (flag == undefined) {
                    $("#div" + FromWhereWhichStatus).html("");
                    $("#div" + FromWhereWhichStatus).html(Strextendhtml);
                }
                else {
                    $("#div" + FromWhereWhichStatus + "1").html("");
                    $("#div" + FromWhereWhichStatus + "1").html(Strextendhtml);
                }
            }
            else {
                if (flag == undefined) {
                    $("#tbody" + FromWhereWhichStatus).html("");
                    $("#tbody" + FromWhereWhichStatus).html(Strextendhtml);
                }
                else {
                    $("#tbody" + FromWhereWhichStatus + "1").html("");
                    $("#tbody" + FromWhereWhichStatus + "1").html(Strextendhtml);
                }
            }
            if (flag == undefined) {
                $("#table" + FromWhereWhichStatus).DataTable({
                    "scrollY": false,
                    "scrollX": true,
                    "pageLength": 10,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true,
                    "retrieve": true,
                    "responsive": true
                });
            }
            else {
                $("#table" + FromWhereWhichStatus + "1").DataTable({
                    //"scrollY": "50vh",
                    //"scrollX": true,
                    "initComplete": function (settings, json) {
                        $("#table" + FromWhereWhichStatus + "1").wrap("<div class='wrapdatatable' style='overflow:auto; width:100%;position:relative;'></div>");
                    },
                    "pageLength": 10,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true,
                    "retrieve": true,
                    "responsive": true,
                    "scrollCollapse":true,
                });
                setTimeout(function () { $(window).trigger('resize'); }, 500);
               
            }
            setTimeout(function () { $(window).trigger('resize'); }, 500);
            $(".collapse").on('show.bs.collapse', function (e) {
                $(".accordion-item .table-bordered").resize();
            });
            $(".collapse").on('hidden.bs.collapse', function (e) {
                $(".accordion-item .table-bordered").resize();
            });
            $(".table").resize();
            $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                $(".table.ClsprobableinfoTbl").resize();
                $($.fn.dataTable.tables(true)).css('width', '100%');
                $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
                //editRA();
            });

            $(".Resourcedetailpanel").hide();
          //  $(".Resourcedetailpanel" + WhichTab).show();
            $(".Resourcedetailpanel .tab-content .tab-pane:first-child").toggleClass('active');
            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 0);

        }

        function ShowDetails() {
            if (IsValidInput() == true) {
                GetRequestDetails(FromWhereWhichStatus, FromWhereflag);
                Fromwhereclause = "";
            }
        }

        function GetComments(WhichTab, RequestID) {
            var Commentvalue = $("#DelineComment_" + RequestID).val();
            $("#txtcomments").val(unescape(Commentvalue));
            $("#commentmodal").modal('show');
        }


        function ClearGridFilter() {
            $("#TxtProjectName").val("");
            $("#TxtRequestID").val("");
            $("#NatureOfRequest").val("0");
            $("#TxtRequestExtendFromDate").val(GlobalRequeststartDate);
            $("#TxtRequestExtendToDate").val(GlobalRequestEndDate);

        }

        function IsValidInput() {
            var objFromDate, objToDate;

            objFromDate = document.getElementById('TxtRequestExtendFromDate');
            objToDate = document.getElementById('TxtRequestExtendToDate');
            if (CompairDates1(ParseDate(objFromDate.value), ParseDate(objToDate.value)) == 1) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Request To Date should be greater than Request From Date.");
                $("#TxtRequestExtendFromDate").focus();
                return false;
            }

            var objRequestID = $("#TxtRequestID").val();
            if ((isNumeric(objRequestID) == false || parseInt(objRequestID) < 0) && Trim(objRequestID) != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter positive numeric Request ID");
                $("#TxtRequestID").focus();
                return false;
            }
            return true;
        }

        function ParseDate(input) {
            theDate = new Date(parseInt(input.substring(6, 19)));
            return theDate.toLocaleDateString();
            //return theDate.toString('MM-dd-YYYY');
        }

        function CompairDates1(obj1, Obj2) {
            var date1 = obj1;
            var date2 = Obj2;
            if (date1 > date2) {
                return 1;
            }
            else if (date1 < date2) {
                return -1;
            }
            else {
                return 0;
            }
        }

        function RequestIDenter(e) {
            var code;
            //debugger;
            if (e.keyCode) code = e.keyCode;
            else if (e.which) code = e.which;
            if (code == 13) {
                var objRequestID = $("#TxtRequestID").val();
                if (objRequestID) {
                    if ((isNumeric(objRequestID) == false || parseInt(objRequestID) < 0) && Trim(objRequestID) != "") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Please enter positive numeric Request ID");
                        $("#TxtRequestID").focus();
                        return;
                    }
                }
                GetRequestDetails(FromWhereWhichStatus, FromWhereflag);
            }
        }

        var GRequestID = "";
        var fromDateGlobal = "";
        var toDateGlobal = "";
        var SelectedProjectRoleID = "";
        var ReqReplacementEmployeeName = "";
        var m_OldAllocation = "";
        var JDOriginalFileName = "";
        var JDSystemFileName = "";
        var JDAttachmentFileName = "";
        var GWhichTab = "";

        function GetDetails(WhichTab, RequestID, flag) {
          
            if ("<%=ResourceAllocationLevel%>" == "Corporate") {
                //$(".btnescalteOU").css("display", "none");
                //$(".btnescalteBG").css("display", "none");
                $(".btnescalteOU_" + FromWhereWhichStatus).css("display", "none");
                $(".btnescalteBG_" + FromWhereWhichStatus).css("display", "none");
            }
            else {
                $(".btnescalte").css("display", "");
            }

            GWhichTab = WhichTab;
            GRequestID = RequestID;
            var ResourcesDetails = {
                RequestID: encodeURI(RequestID),
                WhichTab: encodeURI(WhichTab)
            }
            var param = JSON.stringify(ResourcesDetails);
            var strResult = AJAXCallWithResult("/api/RMResourceAllocation/GetDetails", param, false);
           
            if (flag == undefined) {
                //debugger;
                if (strResult.length != 0) {
                    for (var i = 0; i < strResult.length; i++) {
                        var ResourcesDetails1 = {
                            RequestID: encodeURI(GRequestID),
                            ProjectId: encodeURI(strResult[i].ProjectID)
                        }
                        var param1 = JSON.stringify(ResourcesDetails1);
                        var strResult1 = AJAXCallWithResult("/api/RMResourceAllocation/GetProjectInformation", param1, false);
                        fromDateGlobal = strResult[i].FromDate;
                        toDateGlobal = strResult[i].ToDate;
                        m_strType = strResult[i].Type;
                        //debugger;
                       
                        //debugger;
                        $('#txtToday').datepicker('setDate', new Date());
                        var currentTime = new Date();
             
                        $("#txthidProjectId").val(strResult[i].ProjectID)
                        $("#txthidPriority").val(strResult[i].Priority)
                        $("#txthidEmployeeID").val(strResult[i].EmployeeID)
                        $("#hdnprojectid").val(strResult[i].ProjectID)
                        loadRAVendorFiltersForRequest(strResult[i]);
                        $("#hdnProjectStartDate").val(strResult1.m_strProjectStartDate)
                        $("#hdnProjectEndDate").val(strResult1.m_strProjectEndDate)
                        if (strResult[i].Type == "P") {
                            Type = "% Of Day";
                        }
                        else if (strResult[i].Type == "HPD") {
                            Type = "Per Day";
                        }
                        else if (strResult[i].Type == "TH") {
                            Type = "Total Hours";
                        }
                        
                        /* ------------------Customzation*/
                        $("#lblchangeTypeOfReq_" + FromWhereWhichStatus).text(strResult[i].ReqTypeofRequirement);
                        $("#lblNoOfResource_" + FromWhereWhichStatus).text(strResult[i].ReqNoOfResources);
                        //debugger;
                        if (strResult[i].ReqReplacementEmployeeName != null) {
                            ReqReplacementEmployeeName = strResult[i].ReqReplacementEmployeeName.replace(/\s/g, '');
                        } else {
                            ReqReplacementEmployeeName = "";
                        }


                        if (ReqReplacementEmployeeName == "0") {
                            $("#lblReplacementEmployeeName_" + FromWhereWhichStatus).text("NA");
                        }
                        else if (ReqReplacementEmployeeName == "") {
                            $("#lblReplacementEmployeeName_" + FromWhereWhichStatus).text("NA");
                        }
                        else if (ReqReplacementEmployeeName == null) {
                            $("#lblReplacementEmployeeName_" + FromWhereWhichStatus).text("NA");
                        }
                        else {
                            $("#lblReplacementEmployeeName_" + FromWhereWhichStatus).text(ReqReplacementEmployeeName);
                        }

                        if (strResult[i].ReqDepartment == null || strResult[i].ReqDepartment ==undefined) {
                            $("#lblDeparment_" + FromWhereWhichStatus).text("NA");
                        }
                        else if (strResult[i].ReqDepartment == "") {
                            $("#lblDeparment_" + FromWhereWhichStatus).text("NA");
                        } else {
                            $("#lblDeparment_" + FromWhereWhichStatus).text(strResult[i].ReqDepartment);
                        }

                        if (strResult[i].Location == null || strResult[i].Location == undefined) {
                            $("#lblLocation_" + FromWhereWhichStatus).text("NA");
                        }
                        else if (strResult[i].Location == "") {
                            $("#lblLocation_" + FromWhereWhichStatus).text("NA");
                        } else {
                            $("#lblLocation_" + FromWhereWhichStatus).text(strResult[i].Location);
                        }

                       
                        $("#lblEngmodel_" + FromWhereWhichStatus).text(strResult[i].ReqEngagementModel);
                        $("#lblNatureOfReq_" + FromWhereWhichStatus).text(strResult[i].ReqNatureofRequest);
                        $("#lblBillingPosition_" + FromWhereWhichStatus).text(strResult[i].ReqBillablePosition);
                        $("#lblBilingStartDate_" + FromWhereWhichStatus).text(strResult[i].ReqBillingStartDate);
                        $("#lblSOWAvailbale_" + FromWhereWhichStatus).text(strResult[i].ReqSOWAvailable);
                        /* ------------------End of Customzation*/

                        JDOriginalFileName = strResult[i].JDOriginalFileName;
                        JDSystemFileName = strResult[i].JDSystemFileName;

                        // New: also read JDAttachmentPath (direct file URL from ASPX project folder)
                        var jdAttachmentPath = strResult[i].JDAttachmentPath || '';

                        if (jdAttachmentPath && jdAttachmentPath.trim() !== '') {
                            // New path: use direct URL — filename shown is last segment of path
                            JDAttachmentFileName = "/" + jdAttachmentPath;
                            var jdDisplayName = jdAttachmentPath.split('/').pop();
                            $("#FILENAME0").text(jdDisplayName).attr('title', jdDisplayName);
                            $("#FILENAME_" + FromWhereWhichStatus).text(jdDisplayName).attr('title', jdDisplayName);
                        } else {
                            // Old path: fall back to JDSystemFileName + display JDOriginalFileName
                            JDAttachmentFileName = JDSystemFileName;
                            if (JDOriginalFileName == null || JDOriginalFileName == "") {
                                JDOriginalFileName = "NA";
                            }
                            $("#FILENAME0").text(JDOriginalFileName).attr('title', JDOriginalFileName);
                            $("#FILENAME_" + FromWhereWhichStatus).text(JDOriginalFileName).attr('title', JDOriginalFileName);
                        }

                        if (WhichTab == "Extend") {
                            //debugger;
                            $("#lblSpecialRequest").text(strResult[i].SpecialRequest);
                            $("#lblAssignedRequest").text(strResult[i].TotalAssignedResources);
                            $("#lblRequestBy").text(strResult[i].Requestor);
                            $("#lblProjectName").text(strResult[i].ProjectName);
                            $("#lblRole").text(strResult[i].RoleDescription);
                            $("#lblReqResource").text(strResult[i].EmployeeName);
                           
                            var AllocationUnit = "";
                            var AllocationValue = "";
                            if (strResult[i].Type == "TH") {
                                AllocationUnit = "Total Hours";
                                AllocationValue = strResult[i].TotalRequestedHrs;
                                //$("#lblHoursperday").text(strResult[i].TotalRequestedHrs);
                                $("#lblHoursperday").text(strResult[i].TotalRequestedHrsHHMM);
                            }
                            else if (strResult[i].Type == "P") {
                                AllocationUnit = "% Of Day";
                                AllocationValue = strResult[i].PercentageAllocation;
                                //$("#lblHoursperday").text(strResult[i].PercentageAllocation);
                               /* $("#lblHoursperday").text(strResult[i].BudgetedHours);*/
                                $("#lblHoursperday").text(strResult[i].BudgetedHoursHHMM);
                            } else {
                                AllocationUnit = "Per Day";
                                AllocationValue = strResult[i].WorkHours;
                                if (AllocationValue == null) {
                                    WorkHours = "0.00";
                                } else {
                                    WorkHours = AllocationValue.toFixed(2);
                                }
                                //$("#lblHoursperday").text(WorkHours); //HPD
                                $("#lblHoursperday").text(strResult[i].WorkHoursHHMM); //HPD
                            }

                            
                            $("#lblAllocationUnit").text(AllocationUnit);
                            
                            $("#lblAllocationValue").text(strResult[i].ResourcePercentage);
                          
                            //$("#lblOU").text(strResult[i].Location);
                            $("#lblOU").text(strResult[i].ProjectLocation);
                            $("#lblBG").text(strResult[i].BG);
                            $("#lblFromdate").text(strResult[i].ExpectedStartDate1);
                            $("#lblFromTo").text(strResult[i].ExpectedEndDate1);
                            $("#lblRequestOn").text(strResult[i].RequestDate_New);
                            $("#lblrequestid").text(strResult[i].RequestID);
                              // debugger;
                            if (strResult[i].TotalAssignedResources > 0) {
                                $("#TabsExtendDetails").css("display", "none");
                                $("#btnDecline_" + FromWhereWhichStatus).css("display", "none");
                                $("#btnAllocat_" + FromWhereWhichStatus).css("display", "none");
                            } else {
                                $("#TabsExtendDetails").css("display", "");
                                $("#btnDecline_" + FromWhereWhichStatus).css("display", "");
                                $("#btnAllocat_" + FromWhereWhichStatus).css("display", "");
                                $("#txtNewHrsPerDay_" + FromWhereWhichStatus).val(strResult[i].WorkHours.toFixed(2));
                                $("#txtESecipalReq").val(strResult[i].SpecialRequest);
                                $("#txtExtendNewEndday").val(strResult[i].ToDate_New);
                                $("#txtEffectivePerday_" + FromWhereWhichStatus).val(strResult[i].FromDate_New);

                                $("#txthidRoleID").val(strResult[i].RoleID)
                                $("#txthidResourcepoolID").val(strResult[i].ResourcePoolID)
                                $("#txthidPriority").val(strResult[i].Priority)

                                SelectedProjectRoleID = strResult[i].ProjectEmployeeRoleID;
                                GetOldAllocationDetails(strResult[i].ProjectEmployeeRoleID, GRequestID, strResult[i].Type)
                                $('.datetimepicker').datepicker({
                                    autoclose: true,
                                    changeMonth: true,
                                    changeYear: true,
                                    dateFormat: 'd M y'
                                });
                                if (Type == "% Of Day") {
                                    Type = "%";
                                }
                                $(".spntype").text(Type);

                            }

                        } else if (WhichTab == "ChangeAllocation") {
                            $("#lblCAEmplyeeName").text(strResult[i].EmployeeName);
                            $("#lblCAASD").text(strResult[i].ExpectedStartDate);
                            $("#lblCAAED").text(strResult[i].ExpectedEndDate);
                            $("#lblCAT").text(Type);
                            if (Type != "P") {
                                $("#lblCAV").text(strResult[i].WorkHoursHHMM);
                            } else {
                                $("#lblCAV").text(strResult[i].WorkHours);
                            }
                           
                            $("#lblCWHP").text(strResult[i].BudgetedHours);
                            $("#txtInputnewHrsPerdayDate").val(strResult[i].ExpectedEndDate);
                            //Commented & Added By Dipali V On 18th March 2025 for Get Effective Date
                           // $("#txtInputEffectivePerday").val(strResult[i].RequestDate);
                            $("#txtInputEffectivePerday").val(strResult[i].FromDate);
                            //End of Commented & Added By Dipali V On 18th March 2025 for Get Effective Date
                            $("#txtinputNewHrsPerDay").val(strResult[i].BudgetedHours);
                            $("#lblNewTotalWorkHours").text(strResult[i].TotalRequestedHrs);
                            $("#lblNewTotalWorkHours1").text(strResult[i].TotalRequestedHrsHHMM);
                            $("#txtCSecipalReq").val("");
                            $("#txtCSecipalReq").val(strResult[i].SpecialRequest);

                            GetOldAllocationDetails(strResult[i].ProjectEmployeeRoleID, GRequestID, strResult[i].Type)
                            if (strResult[i].TotalAssignedResources == 0) {
                                $("#TabsChangeDetails").css("display", "");
                                $("#btnDecline_" + FromWhereWhichStatus).css("display", "");
                                $("#btnAllocat_" + FromWhereWhichStatus).css("display", "");
                            } else {
                                $("#TabsChangeDetails").css("display", "none");
                                $("#btnDecline_" + FromWhereWhichStatus).css("display", "none");
                                $("#btnAllocat_" + FromWhereWhichStatus).css("display", "none");
                            }
                            SelectedProjectRoleID = strResult[i].ProjectEmployeeRoleID;

                        }
                        else if (WhichTab == "Prepone") {

                            $("#lblpreEmployeeName").text(strResult[i].UserName);
                            $("#lblpreASD").text(strResult[i].AExpectedStartDate);
                            $("#lblpreAED").text(strResult[i].AExpectedEndDate);
                            $("#lblpreAT").text(Type);
                            $("#lblpreAV").text(strResult[i].ResourcePercentage);
                            //$("#lblpreWH").text(strResult[i].BudgetedHours);
                            $("#lblpreWH").text(strResult[i].BudgetedHoursHHMM);
                            $("#txtEffectivePerday_" + FromWhereWhichStatus).val(strResult[i].AFromDate);
                            $("#txtNewEndday").val(strResult[i].AToDate);
                            $("#txtNewHrsPerDay").val(strResult[i].WorkHours);


                            $("#lblNTWH_" + FromWhereWhichStatus).text(strResult[i].BudgetedHours);
                            //$("#lblNTWH1_" + FromWhereWhichStatus).text(strResult[i].BudgetedHours);
                            $("#txtPSecipalReq").val(strResult[i].SpecialRequest);
                            if (Type == "% Of Day") {
                                Type = "%";
                            }
                            $(".spntype").text(Type);
                            SelectedProjectRoleID = strResult[i].ProjectEmployeeRoleID;
                        
                            if (strResult[i].TotalAssignedResources == 0) {
                                $("#TabPrePoneDetails").css("display", "");
                                $("#btnDecline_" + FromWhereWhichStatus).css("display", "");
                                $("#btnAllocat_" + FromWhereWhichStatus).css("display", "");
                            } else {
                                $("#TabPrePoneDetails").css("display", "none");
                                $("#btnDecline_" + FromWhereWhichStatus).css("display", "none");
                                $("#btnAllocat_" + FromWhereWhichStatus).css("display", "none");
                            }
                            GetOldAllocationDetails(strResult[i].ProjectEmployeeRoleID, GRequestID, strResult[i].Type)
                        }
                        else if (WhichTab == "Allocation") {

                            $("#lblchangeRequestID").text(strResult[i].RequestID);
                            $("#lblchangeRequestOn").text(strResult[i].ReqRequestDate);
                            $("#lblchangeRequestBy").text(strResult[i].Requestor);
                            $("#lblchangeProjectName").text(strResult[i].Project);
                            //$("#lblchangeWP").text(strResult[i].WorkHours);
                            if (strResult[i].Type == "TH") {
                                $("#lblhdnchangeWP").text(strResult[i].TotalRequestedHrs);
                                $("#lblchangeWP").text(strResult[i].ConvertedWorkHours);
                            }
                            else if (strResult[i].Type == "P") {
                                $("#lblhdnchangeWP").text(strResult[i].PercentageAllocation);
                                $("#lblchangeWP").text(strResult[i].ConvertedWorkHours);
                            } else {
                                $("#lblhdnchangeWP").text(strResult[i].WorkHours); //HPD
                                $("#lblchangeWP").text(strResult[i].ConvertedWorkHours); //HPD
                            }

                            $("#lblchangeAR").text(strResult[i].TotalAssignedResources);
                           // $("#lblchangeOu").text(strResult[i].Office);
                            $("#lblchangeOu").text(strResult[i].ProjectLocation);
                            $("#lblchangeTodate").text(strResult[i].ReqToDate);
                            $("#lblchangeFromDate").text(strResult[i].ReqFromDate);
                            $("#lblchangeBG").text(strResult[i].BusinessGroup);
                            $("#lblchangeRR").text(strResult[i].NoOfResources);
                            $("#lblchangeRole").text(strResult[i].RoleDescription);
                            $("#lblchangeSR").text(strResult[i].SpecialRequest);
                            ReqReplacementEmployeeName = strResult[i].ReqReplacementEmployeeName;
                           

                            // debugger;
                            if (Type == "% Of Day") {
                                Type = "%";
                            }
                            $(".spntype").text(Type);

                            if (strResult[i].TotalAssignedResources == strResult[i].NoOfResources) {
                                $("#btnConfigure_" + FromWhereWhichStatus).css("display", "none");
                                $("#Allocate_" + FromWhereWhichStatus).css("display", "none");
                                $("#TopSection_" + FromWhereWhichStatus).css("display", "none");
                                $("#searchMoreProbable_" + FromWhereWhichStatus).css("display", "none");
                                IsNoAction = 1;
                            } else {
                                $("#btnConfigure_" + FromWhereWhichStatus).css("display", "");
                                $("#Allocate_" + FromWhereWhichStatus).css("display", "");
                                $("#TopSection_" + FromWhereWhichStatus).css("display", "");
                                $("#searchMoreProbable_" + FromWhereWhichStatus).css("display", "");
                                IsNoAction = 0;
                            }
                        }

                    }
                }
                //alert(WhichTab);
                $(".Resourcedetailpanel").hide();
                $(".Resourcedetailpanel" + WhichTab).show();
                $(".Resourcedetailpanel .tab-content .tab-pane:first-child").toggleClass('active');
                //used for disable grid
                $(".content .dataTables_wrapper .dataTables_scrollBody, .main_graybgtbs, .content .dataTables_wrapper, .rsralocationfltrs, .backbtn, .addbtn, .content .dataTables_wrapper .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
                $('html,body').animate({
                    scrollTop: $(".Resourcedetailpanel" + WhichTab).offset()?.top - 60
                }, 'slow');

                //debugger;
                // Stp4RAdetails_A
                $(".detailsubtabs .nav-link").removeClass("active");
                $(".detailsubtabs #detail_" + FromWhereWhichStatus).addClass("active");
                $(".detailsubtabs .tab-pane").removeClass("active");
                $("#Stpdetails_" + FromWhereWhichStatus).addClass("active")
            }
            else {

                if (GWhichTab == "Close") {

                    $("#DivConfiguration").css("display", "none");
                    $("#btnDecline").css("display", "none");
                    $(".btnescalteBG_R").css("display", "none");
                    $(".btnescalteOU_R").css("display", "none");
                    $("#tbsExactmatch").css("display", "none");
                    $("#tbssimilar").css("display", "none");
                    $("#tbsprobable").css("display", "none");
                } else {
                    $("#DivConfiguration").css("display", "inline-block");
                    $("#btnDecline").css("display", "inline-block");
                    $(".btnescalteBG_R").css("display", "inline-block");
                    $(".btnescalteOU_R").css("display", "inline-block");
                    $("#tbsExactmatch").css("display", "inline-block");
                    $("#tbssimilar").css("display", "inline-block");
                    $("#tbsprobable").css("display", "inline-block");
                }
                
                if ("<%=ResourceAllocationLevel%>" == "Corporate") {
                    $(".btnescalteOU_" + FromWhereWhichStatus).css("display", "none");
                    $(".btnescalteBG_" + FromWhereWhichStatus).css("display", "none");
                }
                else {
                    $(".btnescalte").css("display", "");
                }
                $("#subtabs .nav-link").removeClass("active");
                $("#subtabs #detail1").addClass("active");
                $("#subtabs .tab-pane").removeClass("active");
                $("#subtabs #Stp1RBGdetails").addClass("active")
                $(".content .dataTables_wrapper .dataTables_scrollBody, .main_graybgtbs, .content .dataTables_wrapper, .rsralocationfltrs, .backbtn, .addbtn, .content .dataTables_wrapper .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
                $('html,body').animate({
                    scrollTop: $(".Resourcedetailpanel").offset()?.top - 60
                }, 'slow');
                var strHTML = `<tbody>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_REQID") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="lmtname" id="lblchangeRequestID1"></span></td>


                                        <th><%= MyBase.GetResourceString("C_REQON") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblchangeRequestOn1"></span></td>

                                        <th><%= MyBase.GetResourceString("C_RBY") %></th>
                                        <td class="colan">:</td>
                                        <td><span  id="lblchangeRequestBy1"></span></td>
                                    </tr>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_PROJECT1") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblchangeProjectName1"></span></td>

                                        <th><%= MyBase.GetResourceString("C_ROLE") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblchangeRole1"></span></td>

                                        <th><%= MyBase.GetResourceString("C_RR") %></th>
                                        <td class="colan">:</td>
                                        <td><span  id="lblchangeRR1"></span></td>
                                    </tr>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_BG") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"> <span  id="lblchangeBG1"></span></td>

                                        <th><%= MyBase.GetResourceString("C_FROMDATE") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblchangeFromDate1"></span></td>

                                        <th><%= MyBase.GetResourceString("C_FT") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblchangeTodate1"></span></td>
                                    </tr>

                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_OU") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblchangeOu1"></span>
                                        </td>


                                       <%-- <th><%= MyBase.GetResourceString("C_WP") %></th>--%>
                                         <th class='ClsCaptionWorkhourstypewise'><%= MyBase.GetResourceString("C_WP") %></th>
                                        <td class="colan">:</td>
                                       <td class="pr-3"><span  id="lblhidchangeWP1" style='display:none'></span><span  id="lblchangeWP1" ></span></td>

                                        <th><%= MyBase.GetResourceString("C_SR") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblchangeSR1"></span></td>
                                    </tr>

                                       <tr>
                                        <th>Type of Requirement</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblchangeTypeOfReq"></span>
                                        </td>


                                        <th>Replacement Employee Name</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblReplacementEmployeeName"></span></td>

                                        <th>No.of Resource</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblNoOfResource"></span></td>
                                    </tr>


                                      <tr>
                                        <th>Department</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblDeparment"></span>
                                        </td>


                                        <th>Location</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblLocation"></span></td>

                                        <th>Engagement Model</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblEngmodel"></span></td>
                                    </tr>

                                       <tr>
                                        <th>Billing Position</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                            <span  id="lblBillingPosition"></span>
                                        </td>


                                        <th>Billing Start Date</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblBilingStartDate"></span></td>

                                        <th>SOW Available</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">  <span  id="lblSOWAvailbale"></span></td>
                                    </tr>


                                    <tr>
                                        <th>Nature of Request</th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span  id="lblNatureOfReq"></span></td>

                                        <th><%= MyBase.GetResourceString("C_AR") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3">
                                        <span  id="lblchangeAR1"></span></td>
                                        
                                        <td class="pr-3">
                                  <div class="attacment-file" style="float:right">
                                        <div class="col-sm-8" style="float:right; padding-left:0" id="DivJDattahcment">
                                              <div class="form-group">
                                                    <div class="input-group col-xs-12">
                                                         <span class="input-group-btn">
                                                            <button class="btn borderbtn" id="btndownloadfile"  type="button" title="Donwload JD Attachments" data-toggle="tooltip" onclick="DownloadJDAttachement();"><i class="fas fa-download" data-toggle="tooltip" data-placement="top" data-container="body" data-original-title="Download"></i> <span id="FILENAME_0" class="jd-filename" title=""></span></button>
                                                         </span>
                                                       </div>
                                                   </div>
                                     </div>
                                  </div>


                <%=CommonFunctions.HTMLControls.DrawTextBox("txthidProjectFromDate", "txthidProjectFromDate", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True)%>
        <%=CommonFunctions.HTMLControls.DrawTextBox("txthidProjectToDate", "txthidProjectToDate", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True)%>
        <%=CommonFunctions.HTMLControls.DrawTextBox("txthidProjectWorkHours", "txthidProjectWorkHours", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True)%>
        <%=CommonFunctions.HTMLControls.DrawTextBox("txthidRequestFromDate", "txthidRequestFromDate", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True)%>
        <%=CommonFunctions.HTMLControls.DrawTextBox("txthidRequestToDate", "txthidRequestToDate", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True)%>

        <%=CommonFunctions.HTMLControls.DrawTextBox("txthidResourceRequested", "txthidResourceRequested", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True)%>
        <%=CommonFunctions.HTMLControls.DrawTextBox("txthidResourceAssigned", "txthidResourceAssigned", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True)%>
        <%=CommonFunctions.HTMLControls.DrawTextBox("txthidTotalHrs", "txthidTotalHrs", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True)%>
        <%=CommonFunctions.HTMLControls.DrawTextBox("txthidProjectId", "txthidProjectId", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True)%>
<%=CommonFunctions.HTMLControls.DrawComboBox("cboJoiningDate", "usp_tbl_PM_Employee_GetResourceJoiningDate", , , , , , , , , True)%>
                    <input id="txtWorkHourshid" type="hidden" value="" />
                                        </td>
                                    </tr>


                                  


                                </tbody>`
                $("#tblDetails").html(strHTML);
                if (strResult.length != 0) {
                    //debugger;
                    for (var i = 0; i < strResult.length; i++) {
                        var ResourcesDetails1 = {
                            RequestID: encodeURI(GRequestID),
                            ProjectId: encodeURI(strResult[i].ProjectID)
                        }
                        var param1 = JSON.stringify(ResourcesDetails1);
                        var strResult1 = AJAXCallWithResult("/api/RMResourceAllocation/GetProjectInformation", param1, false);
                        fromDateGlobal = strResult[i].FromDate;
                        toDateGlobal = strResult[i].ToDate;
                        m_strType = strResult[i].Type;
                        $("#txthidProjectId").val(strResult[i].ProjectID)
                        $("#hdnprojectid").val(strResult[i].ProjectID)
                        loadRAVendorFiltersForRequest(strResult[i]);
                        var Type = "";
                        if (strResult[i].Type == "P") {
                            Type = "% Of Day";
                            m_dblRequestedWorkHours = strResult[i].PercentageAllocation
                            $("#txtWorkHourshid").val(strResult[i].FreePercentage)
                        }
                        else if (strResult[i].Type == "HPD") {
                            Type = "Per Day";
                            m_dblRequestedWorkHours = strResult[i].WorkHours
                            $("#txtWorkHourshid").val(strResult[i].FreeHours)
                        }
                        else if (strResult[i].Type == "TH") {
                            Type = "Total Hours";
                            m_dblRequestedWorkHours = strResult[i].TotalRequestedHrs
                            $("#txtWorkHourshid").val(strResult[i].WorkHoursPerDay)
                        }
                        // debugger;
                        /*--------------------------Assign search*/
                        $("#searchmoreprojectname").text(strResult[i].Project);
                        $("#searchmorepAssigned").text(strResult[i].TotalAssignedResources);
                        $("#searchmoreRequested").text(strResult[i].NoOfResources);
                        $("#searchmoreRole").text(strResult[i].RoleDescription);
                        $("#cboProjectRole_1").val(strResult[i].RoleID);

                        if (m_strType != "P") {
                            //Added By Dipali V On 11th May 2023 For HH:MM Format
                            var RequestParameters = {
                                WorkHrs: encodeURI(m_dblRequestedWorkHours),
                                Flag: encodeURI(1),
                            }
                            var param = JSON.stringify(RequestParameters);
                            var m_dblRequestedWorkHoursConverted = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
                        }
                        else {
                            m_dblRequestedWorkHoursConverted = m_dblRequestedWorkHours;
                        }
                         //End of Added By Dipali V On 11th May 2023 For HH:MM Format
                       
                        $("#searchmoreTotalWorkHours").html(m_dblRequestedWorkHoursConverted);
                        if (m_strType == '<%=TYPE_P%>') {
                            $("#labelWorkHours").html("Work Hours (%) : ");
                            $("#labelWorkHoursSearch").html("Work Hours (%) : ");
                        }
                        else if (m_strType == '<%=TYPE_TH%>') {
                            $("#labelWorkHours").html("Total Work Hours : ");
                            $("#labelWorkHoursSearch").html("Total Work Hours: ");
                        }
                        else {
                            $("#labelWorkHours").html("Work Hours : ");
                            $("#labelWorkHoursSearch").html("Work Hours : ");
                        }
                        /*--------------------------End of Assign search*/

                       /* ------------------Customzation*/
                        $("#lblchangeTypeOfReq").text(strResult[i].ReqTypeofRequirement);
                        $("#lblNoOfResource").text(strResult[i].ReqNoOfResources);
                    
                       // debugger;
                        if (strResult[i].ReqReplacementEmployeeName != null) {
                            ReqReplacementEmployeeName = strResult[i].ReqReplacementEmployeeName.replace(/\s/g, '');
                        } else {
                            ReqReplacementEmployeeName = "";
                        }

                        
                        if (ReqReplacementEmployeeName == "0") {
                            $("#lblReplacementEmployeeName").text("NA");
                        }
                        else if (ReqReplacementEmployeeName == "") {
                            $("#lblReplacementEmployeeName").text("NA");
                        }
                        else if (ReqReplacementEmployeeName == null) {
                            $("#lblReplacementEmployeeName").text("NA");
                        } else {

                            $("#lblReplacementEmployeeName").text(ReqReplacementEmployeeName);
                        }

                        //debugger;
                        $("#lblDeparment").text(strResult[i].ReqDepartment);
                        $("#lblLocation").text(strResult[i].Location);
                        $("#lblEngmodel").text(strResult[i].ReqEngagementModel);
                        $("#lblNatureOfReq").text(strResult[i].ReqNatureofRequest);
                        $("#lblBillingPosition").text(strResult[i].ReqBillablePosition);
                        $("#lblBilingStartDate").text(strResult[i].ReqBillingStartDate);
                        $("#lblSOWAvailbale").text(strResult[i].ReqSOWAvailable);
                        /* ------------------End of Customzation*/
                        //debugger;
                        JDOriginalFileName = strResult[i].JDOriginalFileName;
                        JDSystemFileName = strResult[i].JDSystemFileName;

                        // New: also read JDAttachmentPath (direct file URL from ASPX project folder)
                        var jdAttachmentPath = strResult[i].JDAttachmentPath || '';

                        if (jdAttachmentPath && jdAttachmentPath.trim() !== '') {
                            // New path: use direct URL — filename shown is last segment of path
                            JDAttachmentFileName = "/" + jdAttachmentPath;
                            var jdDisplayName = jdAttachmentPath.split('/').pop();
                            $("#FILENAME_0").text(jdDisplayName).attr('title', jdDisplayName);
                        } else {
                            // Old path: fall back to JDSystemFileName + display JDOriginalFileName
                            JDAttachmentFileName = JDSystemFileName;
                            if (JDOriginalFileName == null || JDOriginalFileName == "") {
                                JDOriginalFileName = "NA";
                            }
                            $("#FILENAME_0").text(JDOriginalFileName).attr('title', JDOriginalFileName);
                        }

                        $("#lblchangeRequestID1").text(strResult[i].RequestID);
                        $("#lblchangeRequestOn1").text(strResult[i].ReqRequestDate);
                        $("#lblchangeRequestBy1").text(strResult[i].Requestor);
                        $("#lblchangeProjectName1").text(strResult[i].Project);

                        //$("#lblchangeWP1").text(strResult[i].WorkHours);
                        if (strResult[i].Type == "TH") {
                            $("#lblhidchangeWP1").text(strResult[i].TotalRequestedHrs);
                            $("#lblchangeWP1").text(strResult[i].ConvertedWorkHours);
                        }
                        else if (strResult[i].Type == "P") {
                            $("#lblhidchangeWP1").text(strResult[i].PercentageAllocation);
                            $("#lblchangeWP1").text(strResult[i].ConvertedWorkHours);
                        } else {
                            $("#lblhidchangeWP1").text(strResult[i].WorkHours); //HPD
                            $("#lblchangeWP1").text(strResult[i].ConvertedWorkHours); //HPD
                        }

                      
                        $("#lblchangeAR1").text(strResult[i].TotalAssignedResources);

                        //$("#lblchangeOu1").text(strResult[i].Office);
                        $("#lblchangeOu1").text(strResult[i].ProjectLocation);
                        //$("#lblchangeTodate1").text(new Date(strResult[i].ToDate).toLocaleDateString());
                        //$("#lblchangeFromDate1").text(new Date(strResult[i].FromDate).toLocaleDateString());

                        $("#lblchangeTodate1").text(strResult[i].ReqToDate);
                        $("#lblchangeFromDate1").text(strResult[i].ReqFromDate);


                        $("#lblchangeBG1").text(strResult[i].BusinessGroup);
                        $("#lblchangeRR1").text(strResult[i].NoOfResources);
                        $("#lblchangeRole1").text(strResult[i].RoleDescription);
                        $("#lblchangeSR1").text(strResult[i].SpecialRequest);
                        
                        // FILENAME0 already set above via JDAttachmentPath or JDOriginalFileName — no override needed
                        if (!jdAttachmentPath || jdAttachmentPath.trim() === '') {
                            if (JDOriginalFileName == null || JDOriginalFileName == "") {
                                JDOriginalFileName = "NA";
                            }
                            $("#FILENAME0").text(JDOriginalFileName);
                        }

                        //$("#lblNatureOfReq").text(strResult[i].SpecialRequest);

                        $("#txthidProjectFromDate").val(strResult1.m_strProjectStartDate);
                        $("#txthidProjectToDate").val(strResult1.m_strProjectEndDate);
                        $("#txthidProjectWorkHours").val(strResult1.m_dblProjectWorkHours);
                        var fromDateRequest = new Date(strResult[i].FromDate);
                        $("#txthidRequestFromDate").val(fromDateRequest.getDate() + "-" + months[fromDateRequest.getMonth()] + "-" + String(fromDateRequest.getFullYear()).slice(-2));
                        fromDateRequest = new Date(strResult[i].ToDate);
                        $("#txthidRequestToDate").val(fromDateRequest.getDate() + "-" + months[fromDateRequest.getMonth()] + "-" + String(fromDateRequest.getFullYear()).slice(-2));
                        $("#txthidResourceRequested").val(strResult[i].NoOfResources);
                        $("#txthidResourceAssigned").val(strResult[i].TotalAssignedResources);
                        $("#txthidTotalHrs").val(strResult1.TotalHours);
                    }
                }

                $(".Resourcedetailpanel").hide();
                $(".Resourcedetailpanel1").show();

                GetConfigureDays();
                $(".Resourcedetailpanel .tab-content .tab-pane:first-child").toggleClass('active');
                //used for disable grid
                $(".content .dataTables_wrapper .dataTables_scrollBody, .main_graybgtbs, .content .dataTables_wrapper, .rsralocationfltrs, .backbtn, .addbtn, .content .dataTables_wrapper .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
                $('html,body').animate({
                    scrollTop: $(".Resourcedetailpanel1").offset()?.top - 60
                }, 'slow');
                $("#Stp1RBGdetails").addClass("active")
               
            }
           //debugger;
            GetApproverForEscalation();
            //Added By Dipali V On 26th April 2023 For Caption Changes
            if (m_strType == "P") {
                $("#IDchangeAllocation").text("New % Of Day");
               // $(".ClsCaptionWorkhourstypewise").text("Work Hours Percent");
                $(".ClsCaptionWorkhourstypewise").text("Work Hours Percent");
                
            }
            else if (m_strType == "TH") {
                $("#IDchangeAllocation").text("NEW Work Hours");
                $(".ClsCaptionWorkhourstypewise").text("Work Hours");
            }
            else if (m_strType == "HPD") {
                $(".ClsCaptionWorkhourstypewise").text("Work Hours");
            }

            if (WhichTab == "Extend") {
                if (m_strType == "P") {
                    $(".ClsCaptionWorkhourstypewise").text("Work Hours");
                }
            }
            //End of Added By Dipali V On 26th April 2023 For Caption Changes
                
        }

        function DownloadJDAttachement() {
            $(".tooltip").removeClass('show');
            if (JDAttachmentFileName == null || JDAttachmentFileName == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("There is no attachment present to download.", 'error', 25);
                return;
            }
            // New: if JDAttachmentFileName is a root-relative path (/Uploads/JDAttachments/...)
            // open it directly — file lives in ASPX project folder, served by IIS.
            // Old: if it is a system filename (no leading slash), use ViewAttachment.aspx as before.
            if (JDAttachmentFileName.indexOf('/') === 0) {
                window.open(strAppRoot + JDAttachmentFileName, '_blank');
            } else {
                var strTemp = '../../General/ViewAttachment.aspx?FromWhere=JDAttachments&FileName=' + JDAttachmentFileName + '&SystemFileName=' + JDAttachmentFileName;
                window.open(strTemp);
            }
        }

        var m_dblRequestedWorkHours = 0;
        var m_strType = "";
        var m_VendorID = "";
        function Decline_Request() {
            if ($("#txtDeclineComments").val().trim() != "")
            {
                var Comments = $("#txtDeclineComments").val();
                var ResourcesDetails = {
                    RequestID: encodeURI(GRequestID),
                    Comments: encodeURI(Comments)
                }
                var param = JSON.stringify(ResourcesDetails);
                var strResult = AJAXCallWithResult("/api/RMResourceAllocation/DeclineRequest", param, false);
                if (strResult.length != "") {
                    //debugger;
                    $("#txtDeclineComments").val('');
                    $("#declineModal").modal('hide');
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Request Decline Successfully");
                    $('table tr').removeClass('rowhiglight');
                    $(".Resourcedetailpanel").hide();
                    $(".content .dataTables_wrapper .dataTables_scrollBody, .main_graybgtbs, .content .dataTables_wrapper, .rsralocationfltrs, .backbtn, .addbtn, .content .dataTables_wrapper .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
                    if (strResult == "1") {
                        window.open("../Email/SendEmail.aspx?MessageID=539&RequestID=" + GRequestID + "&EmployeeID=" + UserID + "", '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500')
                    }
                    GetRequestDetails(FromWhereWhichStatus);
                  
                }

                // }
            } else
            {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Decline Comments should not be left blank");
                $("#txtDeclineComments").focus();
                return;

            }
        }


        function GetNewAllocationValue(ProjectEmployeeRoleID, ProjectID, Status) {
            var ResourcesDetails = {
                ProjectEmployeeRoleID: encodeURI(ProjectEmployeeRoleID),
                ProjectID: encodeURI(ProjectID)
            }
            var param = JSON.stringify(ResourcesDetails);
            var strResult = AJAXCallWithResult("/api/RMResourceAllocation/GetNewAllocationValue", param, false);
            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {
                    //debugger;
                    var strRequestType = Status;
                    var lngRegHours = "";
                    if (strRequestType == "HPD") {
                        lngRegHours = strResult[i].WorkHours;
                    }
                    else if (strRequestType == "TH") {
                        lngRegHours = strResult[i].TotalRequestedHrs;
                    }
                    else if (strRequestType == "P") {
                        lngRegHours = strResult[i].PercentageAllocation;
                    }

                    $("#txtinputNewHrsPerDay").val(lngRegHours);
                   
                }
            }

        }

        function GetOldAllocationDetails(ProjectEmployeeRoleID, RequestID, Status) {
            var ResourcesDetails = {
                ProjectEmployeeRoleID: encodeURI(ProjectEmployeeRoleID),
                RequestID: encodeURI(RequestID)
            }
            var param = JSON.stringify(ResourcesDetails);
            var strResult = AJAXCallWithResult("/api/RMResourceAllocation/GetOldAllocationDetails", param, false);
            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {
                   // debugger;
                    var lngRegHours = "";
                    var strRequestType = Status;
                    if (strRequestType == "HPD") {
                        lngRegHours = strResult[i].WorkHours;
                        //p_mstrApprovedhrsperday = strResult[i].ApprovedWorkHours;
                        p_mstrApprovedhrsperday = strResult[i].ApprovedWorkHoursHHMM;
                        $("#lblpreAV").text(p_mstrApprovedhrsperday);
                        $("#lblCAV").text(p_mstrApprovedhrsperday);
                        
                    }
                    else if (strRequestType == "TH") {
                        //debugger;
                        lngRegHours = strResult[i].TotalRequestedHrs;
                        //p_mstrApprovedtotal = strResult[i].ApprovedTotalRequestedHrs;
                        p_mstrApprovedtotal = strResult[i].ApprovedTotalRequestedHrsHHMM;
                        $("#lblpreAV").text(p_mstrApprovedtotal);
                        $("#lblCAV").text(p_mstrApprovedtotal);
                    }
                    else if (strRequestType == "P") { // % of Day
                        lngRegHours = strResult[i].PercentageAllocation;
                        p_mstrApprovedPercentageperday = strResult[i].ApprovedPercentageAllocation
                        $("#txtPrevAllocation").val(p_mstrApprovedPercentageperday);
                        $("#lblpreAV").text(p_mstrApprovedPercentageperday.toFixed(2)  + " % ");
                        $("#lblCAV").text(p_mstrApprovedPercentageperday.toFixed(2)  + " % ");
                        m_OldAllocation = p_mstrApprovedPercentageperday;
                        //$("#lblHoursperday").text(strResult[i].PercentageAllocation);
                    }
                  
                    $("#txtNewHrsPerDay_" + FromWhereWhichStatus).val(lngRegHours.toFixed(2));
                   
                    if (strRequestType != "P") {
                        var RequestParameters = {
                            WorkHrs: encodeURI(lngRegHours),
                            Flag: encodeURI(1),
                        }
                        var param = JSON.stringify(RequestParameters);
                        var m_dblRequestedWorkHoursConverted = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
                        $("#txtDisplayNewHrsPerDay_" + FromWhereWhichStatus).val(m_dblRequestedWorkHoursConverted);
                        $("#txtDisplayENewHrsPerDay_" + FromWhereWhichStatus).val(m_dblRequestedWorkHoursConverted);

                    } else {
                        $("#txtDisplayNewHrsPerDay_" + FromWhereWhichStatus).val(lngRegHours);
                        $("#txtDisplayENewHrsPerDay_" + FromWhereWhichStatus).val(lngRegHours);
                    }
                    $("#lblNTWH_" + FromWhereWhichStatus).text(strResult[i].TotalRequestedHrs);
                    $("#lblNTWH1_" + FromWhereWhichStatus).text(strResult[i].TotalRequestedHrsHHMM);
                  
                }
            }

        }

        


       

        function PopUpWindow(url, width, height) {
            var leftPosition, topPosition;
            leftPosition = (window.screen.width / 2) - ((width / 2) + 10);

            topPosition = (window.screen.height / 2) - ((height / 2) + 50);

            window.open(url, "Window2",
                "status=no,height=" + height + ",width=" + width + ",resizable=yes,left="
                + leftPosition + ",top=" + topPosition + ",screenX=" + leftPosition + ",screenY="
                + topPosition + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
        }

        function cancledetailpanel() {

        }


        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
            StartLoader("#bodyAllocation");
            $.ajax({
                url: encodeURI(strUrl + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    // xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token_resource"));
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_resource"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;
                    console.log(err);
                    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodyAllocation");
            return ajaxResult;
        }


        function ValidateInputs(flag) {
            var objProjectFromDate, objProjectToDate, objProjectWorkHours, objhdnWorkHours;
            var objFromDate, objToDate, objWorkHours, objchkAssign, intChecked, objMinAllocation;
            var dblRequestedWorkHours = m_dblRequestedWorkHours, strType = m_strType;
            var lngRequestId = GRequestID, intCnt, strMsg, blnFound;
            var objEmployeeTeamID, objEmployeeName;
            var strEmployeeWithDiffTeam = '', lngRequestTeamID =<%=m_lngRequestTeamID%>, objProjectRole;
            var objRequestFromDate, objRequestToDate;
            intChecked = 0;

            var TotalWorkHours = 0;
            var RequestHours = m_dblRequestedWorkHours;
            var AssignedHours = document.getElementById('txthidTotalHrs');

            objProjectFromDate = document.getElementById('txthidProjectFromDate');
            objProjectToDate = document.getElementById('txthidProjectToDate');
            objProjectWorkHours = document.getElementById('txthidProjectWorkHours');
            objRequestFromDate = document.getElementById('txthidRequestFromDate');
            objRequestToDate = document.getElementById('txthidRequestToDate');
            objResourceRequested = document.getElementById('txthidResourceRequested');
            objResourceAssigned = document.getElementById('txthidResourceAssigned');

            blnFound = false;
            objchkAssign = document.getElementsByName('chkAssign');
            for (intCnt = 0; intCnt < objchkAssign.length; intCnt++) {
                if (objchkAssign[intCnt].checked == true) {
                    blnFound = true;
                    intChecked++;
                }
            }

            if (blnFound == false) {
                alertify.error("Please select atleast one resource.");
                return false;
            }

            if (intChecked > (parseInt(objResourceRequested.value) - parseInt(objResourceAssigned.value))) {
                alertify.error("You have selected more resources than requested.");
                return false;
            }
            for (intCnt = 0; intCnt < objchkAssign.length; intCnt++) {
                if (objchkAssign[intCnt].checked == true) {
                    objFromDate = document.getElementById('txtFromDate_' + objchkAssign[intCnt].value + (flag == undefined ? "" : "_1"));
                    objToDate = document.getElementById('txtToDate_' + objchkAssign[intCnt].value + (flag == undefined ? "" : "_1"));
                    objWorkHours = document.getElementById('txtWorkHours_' + objchkAssign[intCnt].value + (flag == undefined ? "" : "_1"));
                    objhdnWorkHours = document.getElementById('txthdnWorkHours_' + objchkAssign[intCnt].value + (flag == undefined ? "" : "_1"));
                    objResWorkHours = document.getElementById('txtWorkHourshid');
                    objMinAllocation = document.getElementById('txtMinAllocation_' + objchkAssign[intCnt].value + (flag == undefined ? "" : "_1"));

                    TotalWorkHours = parseFloat(TotalWorkHours) + parseFloat(objWorkHours.value);
                    strMsg = "Please select from date.";
                    if (disallowBlank(objFromDate, strMsg, true))
                        return false;

                    strMsg = "Please select to date.";
                    if (disallowBlank(objToDate, strMsg, true))
                        return false;

                    strMsg = "To date should be greater that from date.";
                    if (disallowDate1LessThanDate2(objToDate, objFromDate, strMsg, true))
                        return false;

                    strMsg = "From date should be greater than project start date [<=>]";
                    strMsg = replaceSubstring(strMsg, '<=>', objProjectFromDate.value);
                    if (disallowDate1LessThanDate2(objFromDate, objProjectFromDate, strMsg, true))
                        return false;

                    //strMsg = "To date should not be greater than project end date [<=>]";
                    //strMsg = replaceSubstring(strMsg, '<=>', objProjectToDate.value);
                    //if (disallowDate1GreaterThanDate2(objToDate, objProjectToDate, strMsg, true))
                    //    return false;
                    strMsg = "Resource from date should not be greater than request from date.";
                    strMsg = replaceSubstring(strMsg, "&#39;", "'");
                    if (disallowDate1LessThanDate2(objFromDate, objRequestFromDate, strMsg) == true)
                        return;

                    strMsg = "Resource to date should not be greater than request to date.";
                    strMsg = replaceSubstring(strMsg, "&#39;", "'");
                    if (disallowDate1LessThanDate2(objRequestToDate, objToDate, strMsg) == true)
                        return;

                    strMsg = "Please enter work hours.";
                    if (disallowBlank(objWorkHours, strMsg))
                        return false;

                     //Added By Dipali V On 27th April 2023 For Validate 
                    //strMsg = "Please enter positive work hours.";
                    //if (disallowMinValueViolation(objWorkHours, 0.001, strMsg))
                    //    return false;
                    if (objWorkHours.value <= 0) {
                        alertify.error('Please enter positive numeric value');
                        objWorkHours.focus();
                        return false;
                    }
                     //End of Added By Dipali V On 27th April 2023 For Validate 

                    if (parseFloat(objWorkHours.value) > parseFloat(objResWorkHours.value)) {
                        alertify.error('Available Capacity of Resource is less than requested capacity. So can not allcoate the resource.');
                        return false;
                    }

                    //debugger;
                    if (objWorkHours != "" && strType == "<%=TYPE_PERCENT_WORKHOURS%>") {
                        blnResult = disallowNonNumeric(objWorkHours);
                        if (blnResult == true) {
                            alertify.error('Please enter work hours in numeric format');
                            return false;
                        }
                    }

                    //Added By Dipali V On 27th April 2023 For Validate
                    if (strType != "<%=TYPE_PERCENT_WORKHOURS%>") {
                        if (WorkHoursValidation_Allocate(objWorkHours) == false) {
                            return false;
                        }
                    }
                     //End of Added By Dipali V On 27th April 2023 For Validate

                    if (strType == "<%=TYPE_PER_DAY%>") {
                        //Added By Dipali V On 27th April 2023 For Validate 
                        //if (objWorkHours.value.indexOf(':') > -1) {
                        //    var RequestParameters = {
                        //        WorkHrs: encodeURI(objWorkHours.value),
                        //        Flag: encodeURI(2),
                        //    }
                        //    var param = JSON.stringify(RequestParameters);
                        //    var WorkHours = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
                        //    objhdnWorkHours.value = WorkHours
                        //}


                        strMsg = "Please enter valid work hours.";
                        //if (disallowValueRangeViolation(objWorkHours, 1, 24, strMsg))
                        if (disallowValueRangeViolation(objhdnWorkHours, 1, 24, strMsg))
                            return false;

                        strMsg = "Work hours should not greater than requested.";
                        //if (disallowMaxValueViolation(objWorkHours, dblRequestedWorkHours, strMsg, true))
                        if (disallowMaxValueViolation(objhdnWorkHours, dblRequestedWorkHours, strMsg, true))
                         return false;
                         //End of Added By Dipali V On 27th April 2023 For Validate 

                        strMsg = "Requested Work Hours are more than Maximum Free Hours Per Day. So can not allcoate the resource.";
                        //if (disallowMaxValueViolation(objWorkHours, objMinAllocation.value, strMsg, true))
                        if (disallowMaxValueViolation(objhdnWorkHours, objMinAllocation.value, strMsg, true))
                         return false;
                    }
                    else if (strType == "<%=TYPE_TOTAL_WORKHOURS%>") {
                        //Added By Dipali V On 27th April 2023 For Validate 
                        //if (objWorkHours.value.indexOf(':') > -1) {
                        //    var RequestParameters = {
                        //        WorkHrs: encodeURI(objWorkHours.value),
                        //        Flag: encodeURI(2),
                        //    }
                        //    var param = JSON.stringify(RequestParameters);
                        //    var WorkHours = AJAXCallWithResult("/api/RMResourceAllocation/ConvertDecimalToHourViceVersa", param, false);
                        //    objhdnWorkHours.value = WorkHours
                        //}
                         //End of Added By Dipali V On 27th April 2023 For Validate 
                        strMsg = "Work hours should not greater than requested.";
                        if (disallowMaxValueViolation(objhdnWorkHours, dblRequestedWorkHours, strMsg, true))
                            return false;
                    }
                    else if (strType == "<%=TYPE_PERCENT_WORKHOURS%>") {
                        strMsg = "Allocated Resource Percentage is more than Requested resource percentage";
                        if (disallowMaxValueViolation(objWorkHours, dblRequestedWorkHours, strMsg, true))
                            return false;

                        strMsg = "Requested Work Hours (%) is more than Maximum Free Percentage. So can not allcoate the resource. ";
                        if (disallowMaxValueViolation(objWorkHours, objMinAllocation.value, strMsg, true))

                            return false;
                    }
                    if (JoiningDateValidation(objFromDate, objchkAssign[intCnt].value) == false) {
                        return false;
                    }
 
                    
                }
            }

            objProjectRole = document.getElementById('cboProjectRole' + (flag == undefined ? "" : "_1"));
            var strmsg1
            var objProjectStatus = document.getElementById('cboStatus' + (flag == undefined ? "" : "_1"));

            strMsg = "Please select project role.";
            strmsg1 = "Please select the Resource status on Project"
            if (disallowBlank(objProjectRole, strMsg, true))
                return false;
            if (disallowBlank(objProjectStatus, strmsg1, true))
                return false;


            if (strType == "<%=TYPE_TOTAL_WORKHOURS%>") {
                TotalWorkHours = parseFloat(TotalWorkHours) + parseFloat(AssignedHours.value)
                if (parseFloat(RequestHours) <= parseFloat(TotalWorkHours)) {

                    if (!confirm("You are allocating all work hours")) {
                        return;
                    }
                }
            }
            blnIsSaveClicked = 1;
            return true;
        }
        function GetJoiningDate(intEmployeeID) {
            var objcboJoiningDate;
            var intIndex;
            objcboJoiningDate = document.getElementById('cboJoiningDate');
            if (objcboJoiningDate != null) {
                for (intIndex = 0; intIndex < objcboJoiningDate.length; intIndex++) {
                    if (objcboJoiningDate[intIndex].value == intEmployeeID) {
                        return objcboJoiningDate[intIndex].text;
                    }
                }
            }
        }
        function JoiningDateValidation(objStartDate, intEmployeeID) {
            var strMessage, strJDate;
            var dtJDate, dtSDate;
            var objEmpName = document.getElementById('txthidEmployeeName_' + intEmployeeID);
            strJDate = GetJoiningDate(intEmployeeID);
            dtJDate = getDate(strJDate);
            dtSDate = getDate(objStartDate.value);
            if (dtSDate < dtJDate) {
                strMessage = "Resource [<=>] joining date is [<==>].";
                strMessage = replaceSubstring(strMessage, '<=>', objEmpName.value);
                strMessage = replaceSubstring(strMessage, '<==>', strJDate);
                alertify.error(strMessage);
                return false;
            }
            return true;
        }

        function Type_OnClick() {
            var objTD, objTypePerDay, objTypePercent, objTypeTotalWorkHours;

            objTD = document.getElementById('tdWorkHours');

            objTypePerDay = document.getElementById('optPerDay');
            objTypePercent = document.getElementById('optPercent');
            objTypeTotalWorkHours = document.getElementById('optTotalWorkHour');

            if (objTypePerDay.checked == true) {
                objTD.innerHTML = "<%=MyBase.GetResourceString("WORK_HOURS")%>";
                m_strType = "<%=TYPE_HPD%>"
            }
            else if (objTypePercent.checked == true) {
                objTD.innerHTML = "<%=MyBase.GetResourceString("WORK_HOURS")%>" + ' (%)';
                m_strType = "<%=TYPE_P%>"
            }
            else if (objTypeTotalWorkHours.checked == true) {
                objTD.innerHTML = "<%=MyBase.GetResourceString("TOTAL_WORK_HOURS")%>";
                m_strType = "<%=TYPE_TH%>"
            }
        }


        function restrictAlphabets(e) {
            //
            //debugger;
            //  $("#textNoOfResource").val();
            var x = e.which || e.keycode;
            if ((x >= 48 && x <= 57) || x == 8 ||
                (x >= 35 && x <= 40) || x == 46)
                return true;
            else
                return false;
        }
    </script>

</body>

</html>
