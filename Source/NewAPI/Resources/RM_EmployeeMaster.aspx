<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_EmployeeMaster.aspx.vb" Inherits="PbNIT.RM_EmployeeMaster" %>

<!DOCTYPE html>
<html>
     
    <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
     
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">   
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <<%--link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
<%--<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>



</head>
    <style type="text/css">
         /* CSS Added by Mahduri.K on 08-04-2026 */
        .panel.panel-default {
    padding: 0px 0px 0px 0px !important;
}
.panel-heading {
    padding: 0px !important;
    }

       /* CSS Added by Madhuri.K content 06-Sep-2024 comment start here*/
        .dataTables_info {
            margin-top: 1px;
        }
        /* CSS Added by Madhuri.K content 06-Sep-2024 comment End here*/
        master
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
            min-height: 92vh;
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
            margin: 0;
            padding: 10px 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0;
            display: flex;
            white-space: nowrap;
            overflow: hidden; /*Added by Pradip on 23-7-2021*/
        }

            ul.nav.nav-tabs.detailsubtabs:hover {
                overflow-x: auto;
                overflow-y: hidden;
            }
        /*Added by Pradip on 23-7-2021*/

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

        .mr-5 {
            margin-right: 5px;
        }

        /*New style*/
        .detailsubtabs li a {
            padding: 6px 9.9px;
        }

        .notavailimg {
            width: 125px;
            line-height: 120px;
            height: 120px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background: #eee;
            position: relative;
        }
        /*added later*/
        .profile-pic {
            width: 125px;
            line-height: 120px;
            height: 120px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background: #eee;
            position: relative;
        }
        /*till here*/
        a.MEcreateviewLink {
            display: inline-block;
            margin-top: 8px;
        }

        .notavailimg .file-upload {
            display: none;
        }

        .uploadexcelfilegrp {
            border: 1px solid #eee;
            padding: 4px;
            background: #fafafa;
        }

        .custmodal .custom_chckbox label:before {
            border-color: #464a4c;
        }

        .newfilterpanelbody {
            padding: 15px;
            max-height: 50vh;
            overflow: auto;
        }
        /*Resume Style*/
        /*.content-wrapper{background:#eee!important}*/
        #fResumeModal .modal-body {
            padding: 0;
        }

        .content-wrapper, .right-side, .main-footer {
            margin-left: 0 !important;
        }

        .fixed .content-wrapper, .fixed .right-side {
            padding-top: 0 !important;
        }

        .resumecontainer {
            max-width: 100%;
            margin: 0px auto;
            border: 1px solid #ddd;
            box-shadow: 0 1px 4px rgba(0,0,0,0.1);
            background: #fff;
            border-radius: 4px
        }

        .resumeHeader {
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

            .resumeHeader figure {
                margin: 0 0 0 35px;
                border: 1px solid #ddd;
                height: 160px;
                width: 160px;
                line-height: 160px;
                background: #f5f5f5;
                border-radius: 100%;
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

        .table-bordered tbody th {
            background: #e7edf0
        }

        .bankrow td {
            padding: 0 !important;
            height: 5px !important;
            border: none !important;
            line-height: 5px !important
        }

        .candidateContctinfo p {
            margin-bottom: 0;
            line-height: 18px;
            text-align: right
        }

            .candidateContctinfo p label {
                width: 100px
            }


        /*new css*/
        #MEdetails .control-label, #basicfilters label {
            line-height: 18px;
            text-align: right;
        }

        .MEdetailimg {
            margin-bottom: 15px;
        }

        a.uploadphotobtn {
            width: 24px;
            height: 24px;
            line-height: 26px;
            display: block;
            position: absolute;
            right: -10px;
            bottom: -10px;
            background: #fff;
            text-align: center;
            border-radius: 4px;
            box-shadow: 0 0 3px 2px #ccc;
            color: #464a4c;
        }

            a.uploadphotobtn:hover {
                color: #333;
            }

        .Resourcedetailpanel .form-group .control-label {
            text-align: right;
        }

        .detailsubtabsbtn {
            margin-bottom: 15px;
        }

        .input-sm {
            padding: 5px 6px;
        }

        #basicfilters .input-group-btn button.btn.btncalendar {
            margin: 0 0 0 -1px;
            border: 1px solid #ddd;
            padding: 6px 12px;
        }

        #exceluploadsteps .tab-pane .form-group {
            overflow: visible;
        }

        .custmodal .modal-content .modal-body {
            padding: 30px;
        }

        #exluploadTbl_wrapper tr th {
            white-space: nowrap;
            min-width: 200px;
        }

        #exluploadTbl_wrapper tr th {
            min-width: 80px;
        }

        .noteboxpanel {
            padding: 15px;
            border-radius: 4px;
            margin: 0 0 20px;
            font-style: italic;
            font-size: 13px;
            position: relative
        }

            .noteboxpanel ul {
                padding: 0;
                margin: 0;
                counter-reset: item
            }

                .noteboxpanel ul li {
                    margin: 0 0 8px;
                    padding: 0 0 0 1.5em;
                    text-indent: -1.8em;
                    list-style-type: none;
                    counter-increment: item;
                    font-size: 12px !important;
                    line-height: normal
                }

        .mt-0 {
            margin-top: 0
        }

        .noteboxpanel ul > li:before {
            display: inline-block;
            width: 1.5em;
            padding-right: .3em;
            font-weight: 700;
            text-align: right;
            content: counter(item) "."
        }

        #EPRTblList_wrapper tr th {
            min-width: 200px;
        }

            #EPRTblList_wrapper tr th:first-child {
                min-width: 50px;
            }

        #EPRTblList_wrapper .custom_chckbox label:before {
            margin-right: 0;
        }

        div#ui-datepicker-div {
            z-index: 9999 !important;
        }

        .dropup .caret, .navbar-fixed-bottom .dropdown .caret {
            border-width: 6px;
        }

        #PBEUstep2 .dropdown-menu {
            max-height: 180px !important;
        }

        .tooltip {
            z-index: 9999;
        }

        #filterpanel .cust_tabpanel .nav-tabs > li > a:focus {
            color: #fff;
        }
        /*added stop check*/
        /*#MEListTbl_wrapper .dataTables_paginate {
            margin-top: 20px;
        }

        #MEListTbl_wrapper table {
            width: 100% !important;
        }*/
        /*till here*/
        .GRPtbl tr td a {
            position: relative;
        }

            .GRPtbl tr td a span.badge {
                position: absolute;
                right: -10px;
                top: -6px;
                padding: 1px 3px;
                background: none;
                color: #fff;
                background: #999;
                border: none;
                min-width: 6px;
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

        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999 !important;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            /*word-break: break-all;*/
        }

        .clsShowHide {
            display: none!important;
        }

        .filterpanel .issfilter_actiondropdown {
            float: right;
        }

        .issfilter_actiondropdown {
            float: right;
        }

        .filterpanel .MyFiltersdropdown li span i {
            font-size: 14px;
            cursor: pointer;
            padding: 9px;
        }

        .unsavedHeading {
            color: red;
            font-style: italic;
            font-weight: 900;
        }

        .unsavedText {
            color: red;
            font-style: italic;
        }

        .editFilter {
            color: #1359a6;
            border: 1px;
            border-style: dotted;
            background: aliceblue;
        }

        .issuefilter_container .filterpanelbody {
            background: #ffffff;
        }

        .preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;
            /* border: 3px solid #ababab; */
            /* box-shadow: 1px 1px 10px #ababab; */
            border-radius: 15px;
            background: #ddd;
            /* background-color: white; */
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
            /* background: url(../../../Whizible2.0-new/dist/img/loading.gif) rgba( 255, 255, 255, .8 ) 100% 100% no-repeat; */
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }

        .clTextCenter {
            text-align: center;
        }

        .clTextLeft {
            text-align: left;
        }

        .clTextRight {
            text-align: right;
        }

        .clsFilterHighlight {
            background: #1359a6 !important;
            color: #ffffff !important;
        }

        .btnrow {
            margin-top: 20px;
        }

        .filter button[aria-expanded="true"] {
            background: NONE;
            color: #4263c1;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }

        .wrapword {
            white-space: pre-wrap; /* CSS3 */
            word-wrap: break-word; /* Internet Explorer 5.5+ */
            /*word-break: break-all;*/
            white-space: normal;
        }

        .pointerDisable {
            pointer-events: none;
        }

        .actioncolumn {
            width: 6% !important;
        }
		
		.dataTables_scrollHeadInner table tr th:last-child .custom_chckbox label:before {
    margin-right: 7px!important;
}/*Added by pradip on 12-10-2021*/
		

 /*#emsubtabGroupTbl_wrapper thead .sorting_desc, #emsubtabGroupTbl_wrapper thead .sorting_asc, thead #emsubtabGroupTbl_wrapper thead .sorting{display:none;}*/

 .fscroll .form-group{display:flex}
 #PBEUstep2 .form-group{display:flex}

 .pgdetailinner .form-group{display:flex}

 #ReleaseSetProjDateDiv .input-group input, .dateFormt .input-group input{margin-right:0}
 .modal-body .form-group{display:flex}
 .nav{flex-wrap:inherit}
 .input-group-addon{padding-top:6px}
 .form-inline .form-control{width:150px}
#MEListTbl th:last-child {min-width: 60px;}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" >
     <%--  /*Added & Commented By Madhuri.K On 22-Aug-2024 For Loader Issues*/--%>
    <div class="" id="body-tblEmplyee"></div>
        <div class="wrapper">
        <!-- Main Header -->

        <div class="content-wrapper bgwhite">
            <div class="container-fluid pt-1 pb-1 mb-0 text-end graybg">
                <div class="row">
                    <div class="col-sm-5">
                        <h5 class="pgtitle float-start">Employee</h5>
                    </div>

                    <div class="col-sm-7 float-end">
                        <%--Added by imran 14-10-2021 as per discussion with nikhi sir--%>
                        <%--<div class="dropdown filedownload float-end">
                            <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" style="margin-top: 4px;"><i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Click here to download" class="fas fa-download"></i></button>
                            <ul class="dropdown-menu">
                                <li><a href="#">
                                    <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                <li><a href="#">
                                    <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                                <li><a href="#">
                                    <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                                <li><a href="#">
                                    <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Doc</a></li>
                            </ul>
                        </div>--%>
                         <%--Enb by imran as per discussion with nikhi sir--%>

                        <%--<div class="filter inline float-end">
                            <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-bs-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
                        </div>
                        <a href="javascript:;" class="clearalllink float-end" style="" onclick="clearAll" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>--%>
                        <a href="javascript:;" class="mainclearalllink" onclick="closeFilterPanel()" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-bs-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div>
                    </div>

                </div>
            </div>

            <!--filter panel-->
            <div id="filterpanel" class="filterpanel collapse">
                <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                    <div class="cust_tabpanel">
             <ul class="nav nav-tabs">
                        <li class="dropdown">
                            <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">My Filters  <span class="caret"></span></a>
                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
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
                                <div class="newfilterpanelbody">
                                    <div class="text-center hidden-xs centerbtn">
                                        <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal"  data-bs-dismiss="modal" onclick="checkFiltervalidationForEMP()">Save and Apply</button>
                                        <button class="btn btnyellow" onclick="ApplyFlter()">Apply</button>
                                    </div>
                                    <br />
                                    <div class="fscroll">
                                        <div class="row">

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Employee Name</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterEmployeeName">
                                                                 <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                           <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterEmployeeName", "txtEmpFilterEmployeeName", "form-control") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Employee Code</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterEmployeeCode">
                                                                <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                             <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterEmployeeCode", "txtEmpFilterEmployeeCode", "form-control") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">User Name</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterUserName">
                                                                 <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterUserName", "txtEmpFilterUserName", "form-control") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Enable LDAP Authentication</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterIsLDAPAuthentication">
                                                               <option value="=">=</option>
                                                    <option value="<>"><></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <div class="custom_chckbox">
                                                               <%CommonFunctions.HTMLControls.DrawCheckBox("chkEmpFilterIsLDAPAuthentication", "chkEmpFilterIsLDAPAuthentication", "custom_chckbox clsCheckBox", False, , , "style='width: 30px;height:15px;'", , , , , , )%>
                                                                <label for="chkEmpFilterIsLDAPAuthentication"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Birth Date</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterBirthDate">
                                                                <option value="<"><</option>
                                                                <option  value="<="><=</option>
                                                                <option  value="<>"><></option>
                                                                <option  value="=">=</option>
                                                                <option  value=">">></option>
                                                                <option  value=">=">>=</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <div class="input-group datefielddiv">
                                                                <%--<input id="MEFltrBirthdateinput" type="text" class="form-control input-sm">--%>
                                                                <%-- Commented and added by Chetan M on 27 Jul 2021 for making control Readonly --%>
                                                                 <% 'CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterBirthDate", "txtEmpFilterBirthDate", "form-control") %>
                                                               <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterBirthDate", "txtEmpFilterBirthDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <%-- End of Commented and added by Chetan M on 27 Jul 2021 for making control Readonly --%>
                                                                <span class="input-group-btn">
                                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Gender</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterGender">
                                                            <option value="=">=</option>
                                                                <option value="<>"><></option>     

                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                              <%--<% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterGender", "EXEC usp_Sel_tbl_PM_Gender",,, "class='form-control'", True,,) %>--%>
                                                            <select id="txtEmpFilterGender" name="Gender" class="form-control input-sm">
                                                                <option title="Female" value="Female">Female</option>
                                                                    <option title="Male" value="Male">Male</option>

                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Email ID</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterEmailID">
                                                                  <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                             <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterEmailID", "txtEmpFilterEmailID", "form-control") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Blood Group</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterBloodGroup">
                                                               <option value="=">=</option>
                                                                <option value="<>"><></option>     
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                           
                                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterBloodGroup", "EXEC usp_Sel_BloodGroup",,, "class='form-control'", True,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Address</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm"  id="cboEmpFilterAddress">
                                                                 <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterAddress", "txtEmpFilterAddress", "form-control") %>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Current Address</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm"  id="cboEmpFilterCurrentAddress">
                                                        <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterCurrentAddress", "txtEmpFilterCurrentAddress", "form-control") %>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">City</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterCity">
                                                               <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterCity", "txtEmpFilterCity", "form-control") %>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Current City</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterCurrentCity">
                                                                <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                             <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterCurrentCity", "txtEmpFilterCurrentCity", "form-control") %>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">State</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterState">
                                                                  <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                             <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterState", "txtEmpFilterState", "form-control") %>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Current State</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterCurrentState">
                                                                 <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                           <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterCurrentState", "txtEmpFilterCurrentState", "form-control") %>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Pin Code</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterPinCode">
                                                               <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterPinCode", "txtEmpFilterPinCode", "form-control",,,,,,,,,, "onkeypress='return restrictAlphabets(event)'") %>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Current Pin Code</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterCurrentPinCode">
                                                               <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterCurrentPinCode", "txtEmpFilterCurrentPinCode", "form-control",,,,,,,,,, "onkeypress='return restrictAlphabets(event)'") %>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Phone</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterPhone">
                                                               <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterPhone", "txtEmpFilterPhone", "form-control",,,,,,,,,, "onkeypress='return restrictAlphabets(event)'") %>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Current Phone</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterCurrentPhone">
                                                                 <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterCurrentPhone", "txtEmpFilterCurrentPhone", "form-control",,,,,,,,,, "onkeypress='return restrictAlphabets(event)'") %>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Role</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterPostID">
                                                                <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <%--Commented And Added By Reshma Chavan on 6th Dec 2021 To Remove blanck space in dropdown--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterPostID", "usp_Whizible2_Sel_tbl_PM_Role",,, "class='form-control'", True,,, ,) %>--%>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterPostID", "usp_Whizible2_Sel_tbl_PM_Role",,, "class='form-control'",,,, ,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Designation</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterDesignationID">
                                                                 <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                           <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterDesignationID", "usp_Whizible2_sel_tbl_PM_DesignationMaster_DesignationName",,, "class='form-control'", True,,, ,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Department/Unit</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterDepartmentID">
                                                               <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterDepartmentID", "usp_Whizible2_sel_Department_tbl_pm_Departmentmaster",,, "class='form-control'", True,,, ,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Vendor</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterVendorID">
                                                               <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% 'Added by Dipali V on 6th May 2026 for vendor management - Vendor filter in Employee List %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterVendorID", "usp_Whizible2_Sel_tbl_Whizible2_VendorMasterAll_Active",,, "class='form-control'",,,, ,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Employee Type</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterEmployeeType">
                                                               <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <%--Commented And Added By Reshma Chavan on 6th Dec 2021 To Remove blanck space in dropdown--%>
                                                             <%--<% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterEmployeeType", "usp_Sel_tbl_RTS_ProjectSpecificControlData 'EmployeeType'",,, "class='form-control'", True,,, ,) %>--%>
                                                             <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterEmployeeType", "usp_Sel_tbl_RTS_ProjectSpecificControlData 'EmployeeType'",,, "class='form-control'",,,, ,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Reporting To</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterReportingTo">
                                                                <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <%--Commented And Added By Reshma Chavan on 6th Dec 2021 To Remove blanck space in dropdown--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterReportingTo", "usp_Whizible2_sel_tbl_ReportingTo",,, "class='form-control'", True,,, ,) %>--%>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterReportingTo", "usp_Whizible2_sel_tbl_ReportingTo",,, "class='form-control'",,,, ,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Joining Date</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterJoiningDate">
                                                                 <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">

                                                            <div class="input-group datefielddiv">
                                                               <%-- <input id="MEFltrJoinDateInput" type="text" class="form-control input-sm">--%>
                                                                <%-- Commented and added by Chetan M on 27 Jul 2021 for making control Readonly --%>
                                                                 <% 'CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterJoiningDate", "txtEmpFilterJoiningDate", "form-control") %>
                                                                 <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterJoiningDate", "txtEmpFilterJoiningDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <%-- End of Commented and added by Chetan M on 27 Jul 2021 for making control Readonly --%>
                                                                <span class="input-group-btn">
                                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Rate per hour</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterRatePerHour">
                                                                <option value="<"><</option>
                                                                <option  value="<="><=</option>
                                                                <option  value="<>"><></option>
                                                                <option  value="=">=</option>
                                                                <option  value=">">></option>
                                                                <option  value=">=">>=</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterRatePerHour", "txtEmpFilterRatePerHour", "form-control") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Cost per hour</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterCostPerHour">
                                                             <option value="<"><</option>
                                                                <option  value="<="><=</option>
                                                                <option  value="<>"><></option>
                                                                <option  value="=">=</option>
                                                                <option  value=">">></option>
                                                                <option  value=">=">>=</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterCostPerHour", "txtEmpFilterCostPerHour", "form-control") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Cost To Company</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterCostToCompany">
                                                                 <option value="<"><</option>
                                                                <option  value="<="><=</option>
                                                                <option  value="<>"><></option>
                                                                <option  value="=">=</option>
                                                                <option  value=">">></option>
                                                                <option  value=">=">>=</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterCostToCompany", "txtEmpFilterCostToCompany", "form-control") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Currency</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterCurrencyID">
                                                                <option value="<"><</option>
                                                                <option  value="<="><=</option>
                                                                <option  value="<>"><></option>
                                                                <option  value="=">=</option>
                                                                <option  value=">">></option>
                                                                <option  value=">=">>=</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <%--Commented And Added By Reshma Chavan on 6th Dec 2021 To Remove blanck space in dropdown--%>
                                                          <%--<% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterCurrencyID", "usp_Whizible2_sel_tbl_PM_CurrencyMaster",,, "class='form-control'", True,,) %>--%>
                                                          <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterCurrencyID", "usp_Whizible2_sel_tbl_PM_CurrencyMaster",,, "class='form-control'",,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Deployable</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterDeployable">
                                                                <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <select class="form-control input-sm" id="txtEmpFilterDeployable">
                                                                <option value="">Select Deployable</option>
                                                                <option>Yes</option>
                                                                <option>No</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Business Group</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterBusinessGroupID">
                                                                <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-control"" onChange=""FillOURSFilter(this.value)""", True,,, ,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Organization Unit</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterLocationID">
                                                               <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                             <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterLocationID", "Select 0,'' ",,, "class=""form-control"" onChange=""FillDURSFilter(this.value)""",,,, , ) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Delivery Unit</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterResourcePoolID">
                                                                 <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                           <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterResourcePoolID", "Select 0,'' ",,, "class=""form-control"" onChange=""FillDTRSFilter(this.value)""",,,, ,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Delivery Team</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterGroupID">
                                                                 <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterGroupID", "usp_sel_tbl_PM_GroupMaster_GroupID",,, "class='form-control'", True,,, , ) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Facility</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm"  id="cboEmpFilterFacilityID">
                                                                <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <%--Commented And Added By Reshma Chavan on 6th Dec 2021 To Remove blanck space in dropdown--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterFacilityID", "usp_Whizible2_Sel_tbl_PM_Facility",,, "class=""form-control clsPlanWidth"" ,""", True,,, ,)%>--%>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterFacilityID", "usp_Whizible2_Sel_tbl_PM_Facility",,, "class=""form-control clsPlanWidth"" ,""",,,, ,)%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Extension Number</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterExtensionNo">
                                                                <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterExtensionNo", "txtEmpFilterExtensionNo", "form-control") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Mobile Number (s)</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterMobileNumber">
                                                                <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                             <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterMobileNumber", "txtEmpFilterMobileNumber", "form-control") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Grade</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterGradeID">
                                                                  <option value="=">=</option>
                                                                <option value="<>">< ></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <%--Commented And Added By Reshma Chavan on 6th Dec 2021 To Remove blanck space in dropdown--%>
                                                           <%--<% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterGradeID", "usp_Whizible2_sel_tbl_PM_GradeMaster_GradeID",,, "class='form-control'", True,,, ,) %>--%>
                                                           <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterGradeID", "usp_Whizible2_sel_tbl_PM_GradeMaster_GradeID",,, "class='form-control'",,,, ,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Instant Messenger Ids</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterCommunicationID">
                                                                <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtEmpFilterCommunicationID", "usp_Whizible2_sel_tbl_PM_GradeMaster_GradeID",,, "class='form-control'", True,,, ,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <hr style="border-color: #ddd; width: 100%; border-style: dashed; margin: 20px 5px;">

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Passport Number</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterPassportNumber">
                                                               <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterPassportNumber", "txtEmpFilterPassportNumber", "form-control") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Place of Issue</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterPP_PlaceOfIssue">
                                                                <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterPP_PlaceOfIssue", "txtEmpFilterPP_PlaceOfIssue", "form-control") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Date of Issue</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterPP_DateOfIssue">
                                                             <option value="<"><</option>
                                                                <option  value="<="><=</option>
                                                                <option  value="<>"><></option>
                                                                <option  value="=">=</option>
                                                                <option  value=">">></option>
                                                                <option  value=">=">>=</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                              <div class="input-group datefielddiv">
                                                            <%--<input id="FdateofIssue" type="text" class="form-control input-sm" />--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterPP_DateOfIssue", "txtEmpFilterPP_DateOfIssue", "form-control") %>
                                                             <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterPP_DateOfIssue", "txtEmpFilterPP_DateOfIssue", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                                  <span class="input-group-btn">
                                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                                </span>
                                                                  </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Expiry Date</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterPP_ExpiryDate">
                                                               <option value="<"><</option>
                                                                <option  value="<="><=</option>
                                                                <option  value="<>"><></option>
                                                                <option  value="=">=</option>
                                                                <option  value=">">></option>
                                                                <option  value=">=">>=</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                            <div class="input-group datefielddiv">
                                                                <%--<input id="FExpiryDate" type="text" class="form-control input-sm">--%>
                                                                <%--<% 'CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterPP_ExpiryDate", "txtEmpFilterPP_ExpiryDate", "form-control") %>--%>
                                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterPP_ExpiryDate", "txtEmpFilterPP_ExpiryDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                                <span class="input-group-btn">
                                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Full name (as in Passport)</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterPP_FullName">
                                                                 <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                             <%--Commented & Added By Reshma chavan on 23 Feb 2022 For IssueID=32125 TO ALLOW Space--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterPP_FullName", "txtEmpFilterPP_FullName", "form-control") %>--%>
                                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterPP_FullName", "txtEmpFilterPP_FullName", "form-control", 0, 50,,,,,,,, "onkeypress='return restrictSpecialChars(event)'")%>
                                                            <%--End of Commented & Added By Reshma chavan on 23 Feb 2022 For IssueID=32125 TO ALLOW Space--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Son of/Wife of/Daughter of</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="cboEmpFilterPP_RelativeName">
                                                                 <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-sm-8 pl-0">
                                                             <% CommonFunctions.HTMLControls.DrawTextBox("txtEmpFilterPP_RelativeName", "txtEmpFilterPP_RelativeName", "form-control") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                           
                                        </div>
                                    </div>
                                   <%-- <br />
                                    <div class="text-center hidden-xs centerbtn">
                                        <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-target="#Issuesavefilter" data-bs-dismiss="modal">Save and Apply</button>
                                        <button class="btn btnyellow">Apply</button>
                                    </div>--%>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
            <!--end filter panel-->

            <div class="container-fluid pt-1 pb-1 text-end">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="input-group srchrequest">
                            <input id="srchMElist" type="text" class="search-query form-control input-sm" placeholder="Search" onkeyup="mysearchFunction()">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button" style="height: 30px;" onclick="mysearchFunction()">
                                    <span class=" glyphicon glyphicon-search"></span>
                                </button>
                            </span>
                        </div>
                    </div>
                    <div class="col-sm-9 text-end">
                         <% If m_blnAddAccess = True Then %>
                        <a href="javascript:;" class="btn borderbtn mr-5" id="btnDownloadTemplate" data-bs-toggle="modal" onclick="Download_Template()">Download Template</a>
                        <a href="javascript:;" class="btn borderbtn mr-5 uploadExlbtn" id="btnUpload" data-bs-toggle="modal" onclick="EmpOpenExceluploadsteps()">Excel Upload</a>
                        <button class="btn borderbtn addbtn mr-5" id="btnAddEmployee" onclick="addEmployee()"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                        <!--<a href="resource-plan-index.html" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Back to Resource Configuration">Back</a>-->
                        <% End If %>
                        <%-- GDPR Configuration Button - Added for Item 54 GDPR Compliance --%>

                        <%--<button class="btn borderbtn mr-5" id="btnGDPRConfig" onclick="openGDPRConfig()" data-bs-toggle="tooltip" data-bs-placement="bottom" title="GDPR Field Visibility Settings"><i class="fa fa-shield-alt" aria-hidden="true"></i> GDPR Settings</button>--%>

                    </div>
                </div>
            </div>

            <div class="content pt-0">
                <table id="MEListTbl" class="table table-bordered LTtbllist" style="width: 100%;">
                    <thead>
                        <tr>
                            <th class="text-start">Employee Name</th>
                            <th>User Name</th>
                            <th>Role</th>
                            <th>Organization Unit</th>
                            <th>Department</th>
                            <%-- GDPR Item 54: Email ID column - configurable --%>
                            <th id="thEmailID" class="gdpr-email-col">Email ID</th>
                            <th width="50">Resume</th>
                            <th width="50">&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody id="tblBusinessGroups" class="GRPtbl"></tbody>

                </table>
            </div>


            <div class="Resourcedetailpanel">
                <input type="hidden" id="hdnEmployee_UniqueIDTab" name="hdnEmployee_UniqueIDTab" value="">
                <%--Added By Rutuja D. on 5 Aug 2021--%>
                <input type="hidden" id="hdnEmployeeCostID" name="hdnEmployeeCostID" value="">
                <input type="hidden" id="hdnEmployeeHistoryID" name="hdnEmployeeHistoryID" value="">
                <input type="hidden" id="hdnEmployeeHistoryProjectID" name="hdnEmployeeHistoryProjectID" value="">
                <input type="hidden" id="hdnEmployeeQualificationID" name="hdnEmployeeQualificationID" value="">
				 <input type="hidden" id="hdnEmployeeCertificationID" name="hdnEmployeeCertificationID" value="">
                <input type="hidden" id="hdnEmployeeGroupID" name="hdnEmployeeGroupID" value="">
                <%--End of Added By Rutuja D. on 5 Aug 2021--%>
                <ul id="HscrollTab" class="nav nav-tabs detailsubtabs">
                    <li><a href="#MEdetails" class="active" data-bs-toggle="tab" id="EmpDetailsTab">Details</a></li>
                    <!-- Chnaged By Mahduri.K on 08-04-2026 -->
                    <li class=""><a href="#TabAdvanceInfo" data-bs-toggle="tab" id="EmpAdvTab" onclick="GetVisaDetails();">Additional Info</a></li>
                    <li class=""><a href="#TabPersonalInfo" data-bs-toggle="tab" id="EmpPersonalInfoTab" onclick="OpenCertificationDetails(); OpenQualificationTab(); GetSkillDetails();">Personal Info</a></li>

                    <%--Added by Aditya J. on 04-05-2026 for moving the assignmnets tabs beside Personal Info tab--%>
                    <li class=""><a href="#TabAssignments" data-bs-toggle="tab" id="EmpAssignmentsTab" onclick="GetPreWorkExpDetails(); GetPreAssignmentDetails(); GetCurrentAssignmentDetails();">Assignments</a></li>
                    <%--End of Added by Aditya J. on 04-05-2026 for moving the assignmnets tabs beside Personal Info tab--%>

                    <%-- Old tab links commented as per request
                    <li class=""><a href="#TabQualification" data-bs-toggle="tab" id="EmpQualiTab" onclick="OpenQualificationTab()">Qualifications</a></li>
                    <li class=""><a href="#TabSkill" data-bs-toggle="tab" onclick="GetSkillDetails();" id="EmpSkillsTab">Skills</a></li>
                    --%>
                    <!--<li class=""><a href="#TabPhotoUpload" data-bs-toggle="tab" id="">Photo Upload</a></li>-->
                    <li class=""><a href="#TabCost" data-bs-toggle="tab" onclick="GetCostDetails();" id="EmpCostTab">Cost</a></li>
                    <%-- //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                    <%--
                    <li class=""><a href="#TabVisaDetails" onclick="GetVisaDetails();" data-bs-toggle="tab" id="EmpVisaTab">Visa Details</a></li>
                    --%>
                    <%-- //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                    <li class=""><a href="#TabGroup" data-bs-toggle="tab" id="EmpGroupTab" onclick="OpenGroupTab();">Group</a></li>
                    <%-- //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                    <%--
                    <li class=""><a href="#TabPreWorkExp" data-bs-toggle="tab" onclick="GetPreWorkExpDetails();" id="EmpPrevExpTab">Prev.Work Exp.</a></li>
                    <li class=""><a href="#TabPreAssignment" data-bs-toggle="tab" onclick="GetPreAssignmentDetails();" id="EmpPrevAssgnTab">Pre. Assignments</a></li>
                    <li class=""><a href="#TabCurrentAssignmnt" data-bs-toggle="tab" id="EmpCurrentAsssTab" onclick="GetCurrentAssignmentDetails();">Current Assignment</a></li>
                    --%>
                    <%-- //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                    <%-- //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>

                    <%--commneted by Aditya J. on 04-05-2026 for moving the assignmnets tabs beside Personal Info tab--%>
                    <%--<li class=""><a href="#TabAssignments" data-bs-toggle="tab" id="EmpAssignmentsTab" onclick="GetPreWorkExpDetails(); GetPreAssignmentDetails(); GetCurrentAssignmentDetails();">Assignments</a></li>--%>
                    <%--End of commneted by Aditya J. on 04-05-2026 for moving the assignmnets tabs beside Personal Info tab--%>

                    <%-- //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                    <li class=""><a href="#Tabshowhistory" data-bs-toggle="tab" id="EmpHistoryTab" onclick="OpenHistoryTab();">Show History</a></li>
                </ul>
                <div class="clearfix"></div>
                <div class="pgdetailinner">
                    <div class="tab-content">
                        <div id="MEdetails" class="tab-pane active">
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <button class="btn btnyellow mr-5" onclick="SaveEmployeeDetails(0);" id="btnSaveEmp">Save</button>
                                <button class="btn btnyellow mr-5" onclick="SaveEmployeeDetails(1)" id="btnSaveAddEmp">Save And Add</button>
                                <a href="javascript:;" data-bs-toggle="modal" class="btn borderbtn mr-5" id="btnaReleasePopup" onclick="OpenReleasesePopup()">Release</a>
                                <%--Added By Reshma chavan on 28 jan 2022 for Reassign resource Functionality--%>
                                <a href="javascript:;" data-bs-toggle="modal" class="btn borderbtn mr-5" id="btnReassign" onclick="OpenReassignPopup()">Reassign</a>
                                <%--End of Added By Reshma chavan on 28 jan 2022 for Reassign resource Functionality--%>
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                            </div>

                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="row form-group">
                                        <label for="" class="col-sm-5 control-label">&nbsp;</label>
                                        <div class="MEdetailimg col-sm-7 pl-0">
                                            <div class="notavailimg">
                                                <img class="profile-pic" src="../../../Whizible2.0-new/dist/img/blankprofile.png" alt="" title="" />
                                                <a class="uploadphotobtn" href="javascript:;" data-toggle="tooltip" data-bs-title="Upload Photo" data-bs-placement="bottom" ><input  class="file-upload" type="file" accept=".png, .jpg, .jpeg"  /><i class="fas fa-camera openupload"> </i> </a> <%--accept="image/*"--%>
                                                <input type="hidden" id="hiddenProfilePath">
                                            </div>
                                        </div>
                                    </div>
                                    <%-- GDPR Item 54: Birth Date - configurable visibility --%>
                                    <div id="DivBirthDateField" class="row form-group gdpr-configurable">
                                        <label for="" class="col-sm-5 control-label required">Birth Date</label>
                                        <div class="col-sm-7 pl-0">
                                            <div class="input-group datefielddiv">
                                                <%--<input id="MEBirthdateinput1" type="text" class="form-control">--%>
                                                <%-- Commented and added by Chetan M on 27 Jul 2021 for making control Readonly --%>
                                                <%'CommonFunctions.HTMLControls.DrawTextBox("txtBirthDate", "txtBirthDate", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtBirthDate", "txtBirthDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <%-- End of Commented and added by Chetan M on 27 Jul 2021 for making control Readonly --%>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- GDPR Item 54: Email ID - configurable visibility --%>
                                    <div id="DivEmailField" class="row form-group gdpr-configurable">
                                        <label for="" class="col-sm-5 control-label required">Email ID</label>
                                        <div class="col-sm-7 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtEmail", "txtEmail", "form-control", widthInPixel:=0, maxLength:=50)%>
                                        </div>
                                    </div>

                                </div>
                                <div class="col-sm-4">
                                    <div class="row form-group">
                                        <label for="" class="col-sm-5 control-label required">Employee Name</label>
                                        <div class="col-sm-7 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtEmployeeName", "txtEmployeeName", "form-control", widthInPixel:=0, maxLength:=50)%>
                                        </div>
                                    </div>

                                    <div class="row form-group">
                                        <label for="" class="col-sm-5 control-label required">Deployable </label>
                                        <div class="col-sm-7 pl-0" id="DivcboDeployable"><%--Div ID given by Rutuja For Tooltip Issue--%>
                                             <%--Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29674--%>
                                          <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboDeployable", "EXEC usp_Whizible2_Sel_Employee_Deployable",,, "class='form-control'", True,,) %>--%>
                                          <% CommonFunctions.HTMLControls.DrawComboBox("cboDeployable", "EXEC usp_Whizible2_Sel_Employee_Deployable",,, "class='form-control'",,,) %>

                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <label for="" class="col-sm-5 control-label required">User Name</label>
                                        <div class="col-sm-7 pl-0">
                                            <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtUserName", "txtUserName", "form-control", widthInPixel:=0, maxLength:=10)%>--%>
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtUserName", "txtUserName", "form-control", widthInPixel:=0, maxLength:=30)%><%--Maxlength changed by Rutuja For Iwork Issue--%>
                                        </div>
                                    </div>
                                    <%-- GDPR Item 54: Gender - configurable visibility --%>
                                    <div id="DivGenderField" class="row form-group gdpr-configurable">
                                        <label for="" class="col-sm-5 control-label required">Gender</label>
                                        <div class="col-sm-7 pl-0" id="DivcboGender"><%--Div ID given by Rutuja For Tooltip Issue--%>
                                             <%--Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29677--%>
                                           <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboGender", "EXEC usp_Sel_tbl_PM_Gender",,, "class='form-control'", True,,) %>--%>
                                           <% CommonFunctions.HTMLControls.DrawComboBox("cboGender", "EXEC usp_Sel_tbl_PM_Gender",,, "class='form-control'",,,) %>
                                           
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <label for="" class="col-sm-5 control-label required">Joining Date</label>
                                        <div class="col-sm-7 pl-0">
                                            <div class="input-group datefielddiv">
                                                <%-- Commented and added by Chetan M on 27 Jul 2021 for making control Readonly --%>
                                                <%'CommonFunctions.HTMLControls.DrawTextBox("txtJoiningDate", "txtJoiningDate", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtJoiningDate", "txtJoiningDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <%-- End of Commented and added by Chetan M on 27 Jul 2021 for making control Readonly --%>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="row form-group">
                                        <label for="" class="col-sm-5 control-label">Employee Status</label>
                                        <div class="col-sm-7 pl-0">
                                            
                                            <span><strong class="newStatus"></strong></span>
                                        </div>
                                        <input type="hidden" id="Empstatus">
                                    </div>
                                    <div class="row form-group">
                                        <label for="" class="col-sm-5 control-label">Enable LDAP Authentication</label>
                                        <div class="col-sm-7 pl-0">
                                            <div class="custom_chckbox">
                                                <input id="LDAPAuthnticationCheckbox" class="chcktbl" type="checkbox">
                                                <label for="LDAPAuthnticationCheckbox"></label>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row form-group">
                                        <label for="" class="col-sm-5 control-label required">Employee Code</label>
                                        <div class="col-sm-7 pl-0">
                                            <%-- <input id="MEBirthdateinput2" type="text" class="form-control">--%>
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtEmployeeCode", "txtEmployeeCode", cssClass:="form-control", widthInPixel:=0, maxLength:=10)%>
                                        </div>
                                    </div>
                                    <%-- GDPR Item 54: Blood Group permanently hidden --%>
                                    <div id="DivBloodGroupField" class="row form-group gdpr-permanent-hide" style="display:none;">
                                        <label for="" class="col-sm-5 control-label">Blood Group</label>
                                        <div class="col-sm-7 pl-0" id="DivcboBloodGroup"><%--Div ID given by Rutuja For Tooltip Issue--%>
                                             <%--Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29680--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboBloodGroup", "EXEC usp_Sel_BloodGroup",,, "class='form-control'", True,,) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboBloodGroup", "EXEC usp_Sel_BloodGroup",,, "class='form-control'",,,) %>
                                        </div>
                                    </div>

                                </div>

                            </div>

                            <hr style="border-color: #333; border-style: dashed; margin: 20px 5px;" />

                            <div class="row">
                                <div class="form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label required">Department/Unit</label>
                                            <div class="col-sm-7 pl-0" id="DivcboDepartmentUnit"> <%--Div ID given by Rutuja For Tooltip Issue--%>
                                                <%--Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29689--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboDepartmentUnit", "usp_Whizible2_sel_Department_tbl_pm_Departmentmaster",,, "class='form-control'", True,,, ,) %>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboDepartmentUnit", "usp_Whizible2_sel_Department_tbl_pm_Departmentmaster",,, "class='form-control'",,,, ,) %>
                                                <%--End of Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29689--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label required">Role</label>
                                            <div class="col-sm-7 pl-0" id="DivcboRole">  <%--Div ID given by Rutuja For Tooltip Issue--%>
                                                <%--Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29691--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_Whizible2_Sel_tbl_PM_Role",,, "class='form-control'", True,,, ,) %>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_Whizible2_Sel_tbl_PM_Role",,, "class='form-control'",,,, ,) %>
                                                <%--End of Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29691--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label required">Designation</label>
                                            <%--Commented And Added By Reshma Chavan on 12th oct 2021 For Tooltip change--%>
                                            <%--<div class="col-sm-7 pl-0">--%>
                                            <div class="col-sm-7 pl-0 " id="DivcboDesignation"> 
                                                <%--Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29657--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", "usp_Whizible2_sel_tbl_PM_DesignationMaster_DesignationName",,, "class='form-control'", True,,, ,) %>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", "usp_Whizible2_sel_tbl_PM_DesignationMaster_DesignationName",,, "class='form-control'",,,, ,) %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <%-- GDPR Item 54: Employee Type - configurable visibility --%>
                                    <div id="DivEmployeeTypeField" class="col-sm-4 gdpr-configurable">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label required">Employee type</label>
                                             <%--Commented And Added By Reshma Chavan on 12th oct 2021 For Tooltip change--%>
                                            <%--<div class="col-sm-7 pl-0">--%>
                                            <div class="col-sm-7 pl-0 " id="DivcboEmployeeType">
                                                  <%--Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29659--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboEmployeeType", "usp_Sel_tbl_RTS_ProjectSpecificControlData 'EmployeeType'",,, "class='form-control'", True,,, ,) %>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboEmployeeType", "usp_Sel_tbl_RTS_ProjectSpecificControlData 'EmployeeType'",,, "class='form-control'",,,, ,) %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label required">Reporting To</label>
                                            <div class="col-sm-7 pl-0" id="DivcboReportingTo"> <!--Added By Reshma Chavan for Tooltip change-->
                                                 <%--Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29661--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboReportingTo", "usp_Whizible2_sel_tbl_ReportingTo",,, "class='form-control'", True,,, ,) %>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboReportingTo", "usp_Whizible2_sel_tbl_ReportingTo",,, "class='form-control'",,,, ,) %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <%--Added and commented by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag--%>
                                            <%--<label for="" class="col-sm-5 control-label required">Vendor</label>--%>
                                            <label for="" id="lblVendor" class="col-sm-5 control-label required">Vendor</label>
                                            <div class="col-sm-7 pl-0" id="DivcboVendor">
                                                <% 'Added by Dipali V on 6th May 2026 for vendor management - mandatory vendor mapping in Employee Master %>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboVendor", "usp_Whizible2_Sel_tbl_Whizible2_VendorMaster_Active",,, "class='form-control'",,,, ,) %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Grade</label>
                                            <div class="col-sm-7 pl-0" id="DivcboGrade"><!--Added By Reshma Chanvan for Tooltip change-->
                                                <%--Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29859--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboGrade", "usp_Whizible2_sel_tbl_PM_GradeMaster_GradeID",,, "class='form-control'", True,,, ,) %>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboGrade", "usp_Whizible2_sel_tbl_PM_GradeMaster_GradeID",,, "class='form-control'",,,, ,) %>
                                            </div>
                                        </div>
                                    </div>
                               <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label required">Business Group</label>
                                            <%--<div class="col-sm-7 pl-0">--%>
                                            <div class="col-sm-7 pl-0" id="DivcboBG">
                                                 <%--Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29663--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboBG", "Select 0,''",,, "class=""form-control"" onChange=""FillOU(this.value,undefined,2)""", True,,, ,)%>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboBG", "Select 0,''",,, "class=""form-control"" onChange=""FillOU(this.value,undefined,2)""",,,, ,)%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label required">Organization Unit</label>
                                             <%--Commented And Added By Reshma Chavan on 12th oct 2021 For Tooltip change--%>
                                            <%--<div class="col-sm-7 pl-0">--%>
                                            <div class="col-sm-7 pl-0" id="DivcboOU">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboOU", "Select 0,'' ",,, "class=""form-control"" onChange=""FillDU(this.value,undefined,2)""",,,, , ) %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Facility</label>
                                             <%--Commented And Added By Reshma Chavan on 12th oct 2021 For Tooltip change--%>
                                            <%--<div class="col-sm-7 pl-0">--%>
                                            <div class="col-sm-7 pl-0" id="DivcboFacility">
                                                 <%--Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29666--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboFacility", "usp_Whizible2_Sel_tbl_PM_Facility",,, "class=""form-control clsPlanWidth"" ,""", True,,, ,)%>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboFacility", "usp_Whizible2_Sel_tbl_PM_Facility",,, "class=""form-control clsPlanWidth"" ,""",,,, ,)%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Delivery Unit</label>
                                             <%--Commented And Added By Reshma Chavan on 12th oct 2021 For Tooltip change--%>
                                            <%--<div class="col-sm-7 pl-0">--%>
                                            <div class="col-sm-7 pl-0" id="DivcboDU"> 
                                                
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboDU", "Select 0,'' ",,, "class=""form-control"" onChange=""FillDT(this.value,undefined,2)""",,,, ,)%>
                                                
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Delivery Team</label>
                                            <div class="col-sm-7 pl-0" id="DivcboDT"><%--Div ID given by Rutuja For Tooltip Issue--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboDT", "Select 0,'' ",,, "class=""form-control""",,,, ,)%>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- GDPR Item 54: Extension No - configurable visibility --%>
                                    <div id="DivExtensionNoField" class="col-sm-4 gdpr-configurable">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Extension No.</label>
                                            <div class="col-sm-7 pl-0" id="DivtxtExtensionNo"><%--Div ID given by Rutuja For Tooltip Issue--%>
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtExtensionNo", "txtExtensionNo", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label required">Rate / Hour</label>
                                            <div class="col-sm-7 pl-0" id="DivtxtRatePerHr"><%--Div ID given by Rutuja For Tooltip Issue--%>
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtRatePerHr", "txtRatePerHr", cssClass:="form-control", widthInPixel:=0, maxLength:=8)%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label required">Cost / Hour</label>
                                            <div class="col-sm-7 pl-0" id="DivtxtCostPerHr">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtCostPerHr", "txtCostPerHr", cssClass:="form-control", widthInPixel:=0, maxLength:=8)%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label required">Cost To Company</label>
                                            <div class="col-sm-7 pl-0" id="DivtxtCostToCompany"><!--Added By Reshma Chavan for Tooltip-->
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtCostToCompany", "txtCostToCompany", cssClass:="form-control", widthInPixel:=0, maxLength:=12)%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label required">Currency</label>
                                            <div class="col-sm-7 pl-0" id="DivcboCurrency"> <!--Addedd By Reshma Chavan on 18th Oct 2021 For tooltip-->
                                                <!--<input type="text" class="form-control" />-->
                                                 <%--Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29686--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboCurrency", "usp_Whizible2_sel_tbl_PM_CurrencyMaster",,, "class='form-control'", True,,) %>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboCurrency", "usp_Whizible2_sel_tbl_PM_CurrencyMaster",,, "class='form-control'",,,) %>
                                                <%--End of Commented And Added By Reshma Chavan on 7th Oct 2021 to get Placeholder -IssueId-29686--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row hideTLeave">
                                            <label for="" class="col-sm-5 control-label">Tentative Leaving Date</label>
                                            <div class="col-sm-7 pl-0">
                                                <div class="input-group datefielddiv">
                                                    <%--<input id="TLdate" type="text" class="form-control">--%>
                                                    <%-- Commented and added by Chetan M on 29 Jul 2021 for making control Readonly --%>
                                                    <%'CommonFunctions.HTMLControls.DrawTextBox("txtTLeavingDate", "txtTLeavingDate", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                                     <% CommonFunctions.HTMLControls.DrawTextBox("txtTLeavingDate", "txtTLeavingDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <%-- End of Commented and added by Chetan M on 29 Jul 2021txtTLeavingDate for making control Readonly --%>
                                                    <span class="input-group-btn">
                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row hideLeave">
                                            <label for="" class="col-sm-5 control-label">Leaving Date</label>
                                            <div class="col-sm-7 pl-0">
                                                <div class="input-group datefielddiv">
                                                    <%--   <input id="Ldate" type="text" class="form-control">--%>
                                                    <%-- Commented and added by Chetan M on 29 Jul 2021 for making control Readonly --%>
                                                    <%'CommonFunctions.HTMLControls.DrawTextBox("txtLeavingDate", "txtLeavingDate", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                                     <% CommonFunctions.HTMLControls.DrawTextBox("txtLeavingDate", "txtLeavingDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <%-- End of Commented and added by Chetan M on 29 Jul 2021 for making control Readonly --%>
                                                    <span class="input-group-btn">
                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <hr style="border-color: #333; border-style: dashed; margin: 20px 5px;" />
                                <%-- GDPR Item 54: Messenger ID - configurable visibility --%>
                                <div id="DivMessangerIDField" class="form-group gdpr-configurable">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Messanger ID</label>
                                            <div class="col-sm-7 pl-0">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtMessangerID", "txtMessangerID", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        &nbsp;
                                    </div>
                                    <div class="col-sm-4">
                                        &nbsp;
                                    </div>
                                    <div class="clearfix"></div>
                                </div>


                            </div>

                        </div>

                        <div id="TabAdvanceInfo" class="tab-pane">
                            <%-- //commented Added by Aditya J. on 24-04-2026 for subtabs reshufflement --%>
                            <% If False Then %>
                            <div class="row">
                                <%-- GDPR Item 54: Address fields - configurable visibility --%>
                                <div id="DivAddressField" class="gdpr-configurable" style="width:100%;">
                                <div class="form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">&nbsp;</label>
                                            <div class="col-sm-7 pl-0">
                                                <label class=""> Current Address</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-8" style="padding-left: 148px;">
                                        <div class="row">
                                            <div class="custom_chckbox">
                                                <input id="MECurrentAddressCheck" class="" type="checkbox">
                                                <label for="MECurrentAddressCheck">Permanant Address (If permanant &amp; current address are same)</label>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Address</label>
                                            <div class="col-sm-7 pl-0">
                                                <textarea id="txtCurrentAddress" class="form-control" maxlength="200"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Address</label>
                                            <div class="col-sm-7 pl-0">
                                                <textarea id="txtAddresss" class="form-control" maxlength="200"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        &nbsp;
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">City</label>
                                            <div class="col-sm-7 pl-0">                                                
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtCurrentCity", "txtCurrentCity", cssClass:="form-control", widthInPixel:=0, maxLength:=30)%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">City</label>
                                            <div class="col-sm-7 pl-0">                                              

                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtCity", "txtCity", cssClass:="form-control", widthInPixel:=0, maxLength:=30)%>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-sm-4">
                                        &nbsp;
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">State</label>
                                            <div class="col-sm-7 pl-0" id="DivtxtCurrentState">   <%--Div ID given by Rutuja For Tooltip Issue--%>
                                                <%--Commented And Added By Reshma chavan on 7th oct 2021 to get Placeholder IssueID-29693--%>
                                                <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtCurrentState", "txtCurrentState", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>--%>
                                                 <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrentState", "txtCurrentState", "form-control", 0,,,,,,,,, "placeholder='Enter State (Maxlength 50 Char)' autocomplete='Off' maxlength='50'",,, True,,,, True) %>
                                            
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">State</label>
                                            <div class="col-sm-7 pl-0">
                                                 <%--Commented And Added By Reshma chavan on 7th oct 2021 to get Placeholder IssueID-29693--%>
                                                <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtState", "txtState", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>--%>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtState", "txtState", "form-control", 0,,,,,,,,, "placeholder='Enter State (Maxlength 50 Char)' autocomplete='Off' maxlength='50'",,, True,,,, True) %>
                                            
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        &nbsp;
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Pin Code</label>
                                            <div class="col-sm-7 pl-0">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtCurrentPinCode", "txtCurrentPinCode", cssClass:="form-control", widthInPixel:=0, maxLength:=12, ToBeInserted:="onkeypress='return restrictAlphabets(event)'")%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Pin Code</label>
                                            <div class="col-sm-7 pl-0">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPinCode", "txtPinCode", cssClass:="form-control", widthInPixel:=0, maxLength:=12,ToBeInserted:="onkeypress='return restrictAlphabets(event)'")%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        &nbsp;
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Phone</label>
                                            <div class="col-sm-7 pl-0">
                                                <%--<input id="txtCurrentPhone" type="text" class="form-control" />--%>
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtCurrentPhone", "txtCurrentPhone", cssClass:="form-control", widthInPixel:=0, maxLength:=13, ToBeInserted:="onkeypress='return restrictAlphabets(event)'")%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Phone</label>
                                            <div class="col-sm-7 pl-0">
                                                <%--<input id="txtPhone" type="text" class="form-control" />--%>
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPhone", "txtPhone", cssClass:="form-control", widthInPixel:=0, maxLength:=13, ToBeInserted:="onkeypress='return restrictAlphabets(event)'")%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        &nbsp;
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <hr style="border-color: #333; border-style: dashed; margin: 20px 5px;" />
                                <%-- GDPR Item 54: Passport Details permanently hidden --%>
                                <div id="DivPassportDetailsSection" class="gdpr-permanent-hide" style="display:none;">
                                    <h4 style="margin: 0 15px 15px;">Passport Details</h4>
                                <div class="form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Passport No.</label>
                                            <div class="col-sm-7 pl-0">

                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPassportNumber", "txtPassportNumber", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Place of issue</label>
                                            <div class="col-sm-7 pl-0">

                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPlaceOfIssue", "txtPlaceOfIssue", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        &nbsp;
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Issue Date</label>
                                            <div class="col-sm-7 pl-0">
                                                <div class="input-group datefielddiv">
                                                    <%-- Commented and added by Chetan M on 29 Jul 2021 for making control Readonly --%>
                                                    <%--<input id="Issuedate" type="text" class="form-control">--%>
                                                     <% CommonFunctions.HTMLControls.DrawTextBox("Issuedate", "Issuedate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <%-- End of Commented and added by Chetan M on 29 Jul 2021 for making control Readonly --%>
                                                    <span class="input-group-btn">
                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Expiary Date</label>
                                            <div class="col-sm-7 pl-0">
                                                <div class="input-group datefielddiv">
                                                    <%-- Commented and added by Chetan M on 29 Jul 2021 for making control Readonly --%>
                                                    <%--<input id="Expirydate" type="text" class="form-control">--%>
                                                     <% CommonFunctions.HTMLControls.DrawTextBox("Expirydate", "Expirydate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <%-- End of Commented and added by Chetan M on 29 Jul 2021 for making control Readonly --%>
                                                    <span class="input-group-btn">
                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        &nbsp;
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Full Name</label>
                                            <div class="col-sm-7 pl-0">
                                                <%--Commented & Added By Rutuja D, on 23 July 2021 For IssueID=29356 (Restrict Operators)--%>
                                                <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtPPFullName", "txtPPFullName", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>--%>
                                                <%--Commented & Added By Reshma chavan on 23 Feb 2022 For IssueID=32125 TO ALLOW Space--%>
                                                <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtPPFullName", "txtPPFullName", "form-control", 0, 50,,,,,,,, "onkeypress='return /[0-9a-zA-Z]/i.test(event.key)'")%>--%>
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPPFullName", "txtPPFullName", "form-control", 0, 50,,,,,,,, "onkeypress='return restrictSpecialChars(event)'")%>
                                                <%--End of Commented & Added By Reshma chavan on 23 Feb 2022 For IssueID=32125 TO ALLOW Space--%>
                                                <%--End of Commented & Added By Rutuja D, on 23 July 2021 For IssueID=29356 (Restrict Operators)--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <label for="" class="col-sm-5 control-label">Son/Wife/Daughter of</label>
                                            <div class="col-sm-7 pl-0">

                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPPRelativeName", "txtPPRelativeName", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-4" style="display:flex;">
                                        <label for="" class="col-sm-5 control-label">No. of Pages Left</label>
                                        <div class="col-sm-7 pl-0 pr-0">

                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtNoofPagesLeft", "txtNoofPagesLeft", cssClass:="form-control", widthInPixel:=0, maxLength:=3)%>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        &nbsp;
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                </div><%-- End GDPR Passport Details hidden div --%>
                            </div>
                            <% End If %>
                            <%-- //End of commented Added by Aditya J. on 24-04-2026 for subtabs reshufflement --%>

                            <%-- //Added by Aditya J. on 24-04-2026 for subtabs reshufflement --%>
                            <div class="panel-group">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title" style="margin:0;">
                                            <button type="button" class="btn w-100 text-start d-flex justify-content-between align-items-center personal-info-accordion-toggle collapsed" data-bs-toggle="collapse" data-bs-target="#CollapseAddressInAdvance" aria-expanded="false" aria-controls="CollapseAddressInAdvance" style="padding:12px 15px;">
                                                <span>Address Details</span>
                                                <i class="fas fa-chevron-down personal-info-accordion-icon"></i>
                                            </button>
                                        </h4>
                                    </div>
                                    <div id="CollapseAddressInAdvance" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <div class="detailsubtabsbtn pb-1 text-end">
                                                <button class="btn btnyellow mr-5" onclick="saveAdvanceInfo();" id="btnSaveAdvanceInfo">Save</button>
                                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                                            </div>
                                            <div class="row">
                                                <%-- GDPR Item 54: Address fields - configurable visibility --%>
                                                <div id="DivAddressField" class="gdpr-configurable" style="width:100%;">
                                                <div class="form-group">
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">&nbsp;</label>
                                                            <div class="col-sm-7 pl-0">
                                                                <label class=""> Current Address</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-8" style="padding-left: 148px;">
                                                        <div class="row">
                                                            <div class="custom_chckbox">
                                                                <input id="MECurrentAddressCheck" class="" type="checkbox">
                                                                <label for="MECurrentAddressCheck">Permanant Address (If permanant &amp; current address are same)</label>
                                                            </div>

                                                        </div>
                                                    </div>

                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="form-group">
                                                    
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">Address</label>
                                                            <div class="col-sm-7 pl-0">
                                                                <textarea id="txtCurrentAddress" class="form-control" maxlength="200"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">Address</label>
                                                            <div class="col-sm-7 pl-0">
                                                                <textarea id="txtAddresss" class="form-control" maxlength="200"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        &nbsp;
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">City</label>
                                                            <div class="col-sm-7 pl-0">                                                
                                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtCurrentCity", "txtCurrentCity", cssClass:="form-control", widthInPixel:=0, maxLength:=30)%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">City</label>
                                                            <div class="col-sm-7 pl-0">                                              

                                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtCity", "txtCity", cssClass:="form-control", widthInPixel:=0, maxLength:=30)%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-sm-4">
                                                        &nbsp;
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="form-group">
                                                    
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">State</label>
                                                            <div class="col-sm-7 pl-0" id="DivtxtCurrentState">   <%--Div ID given by Rutuja For Tooltip Issue--%>
                                                                <%--Commented And Added By Reshma chavan on 7th oct 2021 to get Placeholder IssueID-29693--%>
                                                                <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtCurrentState", "txtCurrentState", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>--%>
                                                                 <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrentState", "txtCurrentState", "form-control", 0,,,,,,,,, "placeholder='Enter State (Maxlength 50 Char)' autocomplete='Off' maxlength='50'",,, True,,,, True) %>
                                                            
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">State</label>
                                                            <div class="col-sm-7 pl-0">
                                                                 <%--Commented And Added By Reshma chavan on 7th oct 2021 to get Placeholder IssueID-29693--%>
                                                                <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtState", "txtState", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>--%>
                                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtState", "txtState", "form-control", 0,,,,,,,,, "placeholder='Enter State (Maxlength 50 Char)' autocomplete='Off' maxlength='50'",,, True,,,, True) %>
                                                            
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        &nbsp;
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="form-group">
                                                    
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">Pin Code</label>
                                                            <div class="col-sm-7 pl-0">
                                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtCurrentPinCode", "txtCurrentPinCode", cssClass:="form-control", widthInPixel:=0, maxLength:=12, ToBeInserted:="onkeypress='return restrictAlphabets(event)'")%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">Pin Code</label>
                                                            <div class="col-sm-7 pl-0">
                                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPinCode", "txtPinCode", cssClass:="form-control", widthInPixel:=0, maxLength:=12,ToBeInserted:="onkeypress='return restrictAlphabets(event)'")%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        &nbsp;
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="form-group">
                                                    
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">Phone</label>
                                                            <div class="col-sm-7 pl-0">
                                                                <%--<input id="txtCurrentPhone" type="text" class="form-control" />--%>
                                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtCurrentPhone", "txtCurrentPhone", cssClass:="form-control", widthInPixel:=0, maxLength:=13, ToBeInserted:="onkeypress='return restrictAlphabets(event)'")%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">Phone</label>
                                                            <div class="col-sm-7 pl-0">
                                                                <%--<input id="txtPhone" type="text" class="form-control" />--%>
                                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPhone", "txtPhone", cssClass:="form-control", widthInPixel:=0, maxLength:=13, ToBeInserted:="onkeypress='return restrictAlphabets(event)'")%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        &nbsp;
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>

                                                <hr style="border-color: #333; border-style: dashed; margin: 20px 5px;" />
                                                <%-- GDPR Item 54: Passport Details permanently hidden --%>
                                                <div id="DivPassportDetailsSection" class="gdpr-permanent-hide" style="display:none;">
                                                    <h4 style="margin: 0 15px 15px;">Passport Details</h4>
                                                <div class="form-group">
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">Passport No.</label>
                                                            <div class="col-sm-7 pl-0">

                                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPassportNumber", "txtPassportNumber", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">Place of issue</label>
                                                            <div class="col-sm-7 pl-0">

                                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPlaceOfIssue", "txtPlaceOfIssue", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        &nbsp;
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">Issue Date</label>
                                                            <div class="col-sm-7 pl-0">
                                                                <div class="input-group datefielddiv">
                                                                    <%-- Commented and added by Chetan M on 29 Jul 2021 for making control Readonly --%>
                                                                    <%--<input id="Issuedate" type="text" class="form-control">--%>
                                                                     <% CommonFunctions.HTMLControls.DrawTextBox("Issuedate", "Issuedate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                                <%-- End of Commented and added by Chetan M on 29 Jul 2021 for making control Readonly --%>
                                                                    <span class="input-group-btn">
                                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">Expiary Date</label>
                                                            <div class="col-sm-7 pl-0">
                                                                <div class="input-group datefielddiv">
                                                                    <%-- Commented and added by Chetan M on 29 Jul 2021 for making control Readonly --%>
                                                                    <%--<input id="Expirydate" type="text" class="form-control">--%>
                                                                     <% CommonFunctions.HTMLControls.DrawTextBox("Expirydate", "Expirydate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                                <%-- End of Commented and added by Chetan M on 29 Jul 2021 for making control Readonly --%>
                                                                    <span class="input-group-btn">
                                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        &nbsp;
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">Full Name</label>
                                                            <div class="col-sm-7 pl-0">
                                                                <%--Commented & Added By Rutuja D, on 23 July 2021 For IssueID=29356 (Restrict Operators)--%>
                                                                <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtPPFullName", "txtPPFullName", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>--%>
                                                                <%--Commented & Added By Reshma chavan on 23 Feb 2022 For IssueID=32125 TO ALLOW Space--%>
                                                                <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtPPFullName", "txtPPFullName", "form-control", 0, 50,,,,,,,, "onkeypress='return /[0-9a-zA-Z]/i.test(event.key)'")%>--%>
                                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPPFullName", "txtPPFullName", "form-control", 0, 50,,,,,,,, "onkeypress='return restrictSpecialChars(event)'")%>
                                                                <%--End of Commented & Added By Reshma chavan on 23 Feb 2022 For IssueID=32125 TO ALLOW Space--%>
                                                                <%--End of Commented & Added By Rutuja D, on 23 July 2021 For IssueID=29356 (Restrict Operators)--%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <label for="" class="col-sm-5 control-label">Son/Wife/Daughter of</label>
                                                            <div class="col-sm-7 pl-0">

                                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtPPRelativeName", "txtPPRelativeName", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-4" style="display:flex;">
                                                        <label for="" class="col-sm-5 control-label">No. of Pages Left</label>
                                                        <div class="col-sm-7 pl-0 pr-0">

                                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtNoofPagesLeft", "txtNoofPagesLeft", cssClass:="form-control", widthInPixel:=0, maxLength:=3)%>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        &nbsp;
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                </div><%-- End GDPR Passport Details hidden div --%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- //End of Added by Aditya J. on 24-04-2026 for subtabs reshufflement --%>
                            <%-- //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                            <div class="panel-group" id="AdvanceInfoAccordion">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title" style="margin:0;">
                                            <button type="button" class="btn w-100 text-start d-flex justify-content-between align-items-center personal-info-accordion-toggle collapsed" data-bs-toggle="collapse" data-bs-target="#CollapseVisaInAdvance" aria-expanded="false" aria-controls="CollapseVisaInAdvance" style="padding:12px 15px;" onclick="GetVisaDetails();">
                                                <span>Visa Details</span>
                                                <i class="fas fa-chevron-down personal-info-accordion-icon"></i>
                                            </button>
                                        </h4>
                                    </div>
                                    <div id="CollapseVisaInAdvance" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <div id="TabVisaDetails">
                                                <div class="detailsubtabsbtn pb-1 text-end">
                                                    <a href="javascript:;" class="btn borderbtn mr-5" id="AddVisaModal" data-bs-toggle="modal" onclick="clearVisaDetails();" data-bs-target="#MEaddVisaDetailmodal"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
                                                    <% If m_blnDeleteAccess Then %>
                                                    <button class="btn borderbtn mr-5" onclick="DeleteVisaDetails();" id="">Delete</button>
                                                    <% End If %>
                                                    <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                                                </div>
                                                <table id="emsubtabVisaTbl" class="table table-bordered" style="width: 100%;">
                                                    <thead>
                                                        <tr>
                                                            <th>Country</th>
                                                            <th>Visa Type</th>
                                                            <th>Valid From</th>
                                                            <th>Valid To</th>
                                                            <th>
                                                                <div class="custom_chckbox">
                                                                    <input id="MEVisaCheck" class="chckVisa" type="checkbox">
                                                                    <label for="MEVisaCheck"></label>
                                                                </div>
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="emtblVisaType">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                        </div>

                        <div id="TabPersonalInfo" class="tab-pane">
                            <div class="panel-group" id="PersonalInfoAccordion">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title" style="margin:0;">
                                            <button type="button" class="btn w-100 text-start d-flex justify-content-between align-items-center personal-info-accordion-toggle" data-bs-toggle="collapse" data-bs-target="#CollapseCertification" aria-expanded="true" aria-controls="CollapseCertification" style="padding:12px 15px;">
                                                <span>Certifications</span>
                                                <i class="fas fa-chevron-up personal-info-accordion-icon"></i>
                                            </button>
                                        </h4>
                                    </div>
                                    <div id="CollapseCertification" class="panel-collapse collapse show">
                                        <div class="panel-body">
                                            <div id="TabCertification">
                                                <div class="pb-1 form-inline">
                                                    <div class="form-group" style="display:contents">
                                                        <%--Commeneted And Added By Reshma Chavan on 7th oct 2021 to change caption and get Placeholder IssueID-29728--%>
                                                        <%--<label for="email">Certification : </label>                                       
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtFILTERCertificationID", "usp_Whizible2_sel_tbl_PM_Certifications ",,, "class=""form-control"" onChange=""GetCertifications(this.value)""", True,,, ,) %>--%>
                                                        <label for="email">Certification Name : </label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtFILTERCertificationID", "usp_Whizible2_sel_tbl_PM_Certifications ", 210,, "class=""form-control"" onChange=""GetCertifications(this.value)""",,,, ,) %>
                                                        <%--End of Commeneted And Added By Reshma Chavan on 7th oct 2021 to change caption and get Placeholder IssueID-29728--%>
                                                    </div>
                                                    <div class="detailsubtabsbtn pb-1 float-end">
                                                        <a href="javascript:;" class="btn borderbtn mr-5" id="AddCert" data-bs-toggle="modal" data-bs-target="#AddCertModal" onclick="addCertPopup();"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
                                                        <% If m_blnDeleteAccess Then %>
                                                        <button class="btn borderbtn mr-5" id="DeleteCertModal" onclick="DeleteEmpCertificationDetails();">Delete</button>
                                                        <% End If %>
                                                        <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <table id="MECrtTbl" class="table table-bordered MECrtificationTbl" style="width: 100%;">
                                                    <thead>
                                                        <tr>
                                                            <th>Certification Name</th>
                                                            <th>Certification Date</th>
                                                            <th>Score</th>
                                                            <th>
                                                                <div class="custom_chckbox">
                                                                    <input id="CrtCheck0" class="chckHeadCERT" type="checkbox">
                                                                    <label for="CrtCheck0"></label>
                                                                </div>
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tblCertification">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title" style="margin:0;">
                                            <button type="button" class="btn w-100 text-start d-flex justify-content-between align-items-center personal-info-accordion-toggle collapsed" data-bs-toggle="collapse" data-bs-target="#CollapseQualification" aria-expanded="false" aria-controls="CollapseQualification" style="padding:12px 15px;">
                                                <span>Qualifications</span>
                                                <i class="fas fa-chevron-down personal-info-accordion-icon"></i>
                                            </button>
                                        </h4>
                                    </div>
                                    <div id="CollapseQualification" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <div id="TabQualification">
                                                <div class="detailsubtabsbtn pb-1 text-end">
                                                    <button class="btn borderbtn mr-5" id="addQualiModal" data-bs-toggle="modal" data-bs-target="#MEaddQualificationModal" onclick="addQualiPopup();"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                                                    <% If m_blnDeleteAccess Then %>
                                                    <button class="btn borderbtn mr-5" id="DeleteQualiModal" onclick="DeleteEmpQualificationDetails();">Delete</button>
                                                    <% End If %>
                                                    <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                                                </div>
                                                <table id="emsubtabQualTbl" class="table table-bordered" style="width: 100%;">
                                                    <thead>
                                                        <tr>
                                                            <th>Qualification</th>
                                                            <th>University Name</th>
                                                            <th>Paassout Year</th>
                                                            <th>Class/Grade</th>
                                                            <th>Percentage/points</th>
                                                            <th>
                                                                <div class="custom_chckbox">
                                                                    <input id="MEQualficationCheck" class="chckHead2" type="checkbox">
                                                                    <label for="MEQualficationCheck"></label>
                                                                </div>
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tblEmpQualification">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title" style="margin:0;">
                                            <button type="button" class="btn w-100 text-start d-flex justify-content-between align-items-center personal-info-accordion-toggle collapsed" data-bs-toggle="collapse" data-bs-target="#CollapseSkill" aria-expanded="false" aria-controls="CollapseSkill" style="padding:12px 15px;">
                                                <span>Skills</span>
                                                <i class="fas fa-chevron-down personal-info-accordion-icon"></i>
                                            </button>
                                        </h4>
                                    </div>
                                    <div id="CollapseSkill" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <div id="TabSkill">
                                                <div class="detailsubtabsbtn pb-1 text-end">
                                                    <button class="btn borderbtn mr-5" id="AddSkillModal" data-bs-toggle="modal" onclick="clearSkillDetails();" data-bs-target="#MESkillModal"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                                                    <% If m_blnDeleteAccess Then %>
                                                    <button class="btn borderbtn mr-5" onclick="DeleteSkill();" id="DeleteSkillModal">Delete</button>
                                                    <% End If %>
                                                    <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                                                </div>
                                                <input type="hidden" id="hiddenskillId" />
                                                <table id="emsubtabSkillTbl" class="table table-bordered" style="width: 100%;">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-start">Skill</th>
                                                            <th>Experience<span>(Years)</span></th>
                                                            <th>Experience<span>(Months)</span></th>
                                                            <th>Proficiency</th>
                                                            <th>Core Competency</th>
                                                            <th>
                                                                <div class="custom_chckbox">
                                                                    <input id="MEskill0" class="chckskill" type="checkbox">
                                                                    <label for="MEskill0"></label>
                                                                </div>
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="empSkilltbl"></tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                        <div id="TabAssignments" class="tab-pane">
                            <div class="panel-group" id="AssignmentsAccordion">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title" style="margin:0;">
                                            <button type="button" class="btn w-100 text-start d-flex justify-content-between align-items-center personal-info-accordion-toggle" data-bs-toggle="collapse" data-bs-target="#CollapseAssignmentPrevWorkExp" aria-expanded="true" aria-controls="CollapseAssignmentPrevWorkExp" style="padding:12px 15px;" onclick="GetPreWorkExpDetails();">
                                                <span>Previous Work Experience</span>
                                                <i class="fas fa-chevron-up personal-info-accordion-icon"></i>
                                            </button>
                                        </h4>
                                    </div>
                                    <div id="CollapseAssignmentPrevWorkExp" class="panel-collapse collapse show">
                                        <div class="panel-body">
                                            <div id="TabPreWorkExp">
                                                <div class="detailsubtabsbtn pb-1 text-end">
                                                    <button class="btn borderbtn mr-5" id="AddWorkExpModal" data-bs-toggle="modal" onclick="clearPreWorkExpDetails();" data-bs-target="#MEPWExpmodal"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                                                    <% If m_blnDeleteAccess Then %>
                                                    <button class="btn borderbtn mr-5" onclick="DeletePreWorkExperience();" id="DeleteWorkExpModal">Delete</button>
                                                    <% End If %>
                                                    <%--COMMENTED By Reshma Chavan on 23 Feb 2022 does not require save button on list page--%>
                                                    <%--<button class="btn btnyellow mr-5" id="">Save</button>--%>
                                                    <%--End of COMMENTED By Reshma Chavan on 23 Feb 2022 does not require save button on list page--%>
                                                    <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                                                </div>
                                                <table id="emsubtabprewrkTbl" class="table table-bordered" style="width: 100%;">
                                                    <thead>
                                                        <tr>
                                                            <th>Organization Name</th>
                                                            <th>Position Held</th>
                                                            <th>From Date</th>
                                                            <th>Till Date</th>
                                                            <th>Work Profile</th>
                                                            <th>
                                                                <div class="custom_chckbox">
                                                                    <input id="MEPWEcheck0" class="chckPerwork" type="checkbox">
                                                                    <label for="MEPWEcheck0"></label>
                                                                </div>
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="emprewrk"></tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title" style="margin:0;">
                                            <button type="button" class="btn w-100 text-start d-flex justify-content-between align-items-center personal-info-accordion-toggle collapsed" data-bs-toggle="collapse" data-bs-target="#CollapseAssignmentPrevAssignment" aria-expanded="false" aria-controls="CollapseAssignmentPrevAssignment" style="padding:12px 15px;" onclick="GetPreAssignmentDetails();">
                                                <span>Previous Assignments</span>
                                                <i class="fas fa-chevron-down personal-info-accordion-icon"></i>
                                            </button>
                                        </h4>
                                    </div>
                                    <div id="CollapseAssignmentPrevAssignment" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <div id="TabPreAssignment">
                                                <div class="detailsubtabsbtn pb-1 text-end">
                                                    <button class="btn borderbtn mr-5" id="AddPrevAssModal" data-bs-toggle="modal" onclick="clearPreAssignmentDetails();" data-bs-target="#MEPrevAsignmentModal"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                                                    <% If m_blnDeleteAccess Then %>
                                                    <button class="btn borderbtn mr-5" onclick="DeletePreAssignment();" id="DeletePrevAssModal">Delete</button>
                                                    <% End If %>
                                                    <%--COMMENTED By Reshma Chavan on 23 Feb 2022 does not require save button on list page--%>
                                                    <%--<button class="btn btnyellow mr-5" id="">Save</button>--%>
                                                    <%--End of COMMENTED By Reshma Chavan on 23 Feb 2022 does not require save button on list page--%>
                                                    <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                                                </div>
                                                <table id="emtabpreAssign" class="table table-bordered" style="width: 100%;">
                                                    <thead>
                                                        <tr>
                                                            <th>Assignment Name</th>
                                                            <th>Duration(Years)</th>
                                                            <th>Team Size</th>
                                                            <th>Functional Role</th>
                                                            <th>
                                                                <div class="custom_chckbox">
                                                                    <input id="MEPAsignmentscheck0" class="chckHeadPreAssgn" type="checkbox">
                                                                    <label for="MEPAsignmentscheck0"></label>
                                                                </div>
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="empreAssign">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title" style="margin:0;">
                                            <button type="button" class="btn w-100 text-start d-flex justify-content-between align-items-center personal-info-accordion-toggle collapsed" data-bs-toggle="collapse" data-bs-target="#CollapseAssignmentCurrentAssignment" aria-expanded="false" aria-controls="CollapseAssignmentCurrentAssignment" style="padding:12px 15px;" onclick="GetCurrentAssignmentDetails();">
                                                <span>Current Assignment</span>
                                                <i class="fas fa-chevron-down personal-info-accordion-icon"></i>
                                            </button>
                                        </h4>
                                    </div>
                                    <div id="CollapseAssignmentCurrentAssignment" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <div id="TabCurrentAssignmnt">
                                                <div class="detailsubtabsbtn pb-1 text-end">
                                                    <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                                                </div>

                                                <div class="pt-1 pb-1 row">
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <div class="col-sm-5 text-end">
                                                                <label for="currAssignProjectAsscee">Project Access</label>
                                                            </div>
                                                            <div class="col-sm-7 pe-0 ps-0">
                                                                <select id="currAssignProjectAsscee" class="form-control" onchange="GetCurrentAssignmentList();">
                                                                    <option value="0">Accessible</option>
                                                                    <option value="1">Allocated</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <div class="col-sm-5 text-end">
                                                                <label for="currAssignProjectOver">Is Project Over?</label>
                                                            </div>
                                                            <div class="col-sm-7 pe-0 ps-0">
                                                                <select id="currAssignProjectOver" class="form-control" onchange="GetCurrentAssignmentList();">
                                                                    <option value="">&nbsp;</option>
                                                                    <option value="0">No</option>
                                                                    <option value="1">Yes</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row">
                                                            <div class="col-sm-5 text-end pe-0 ps-0">
                                                                <label for="currAssignProjectStatus">Is Resource Active?</label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select id="currAssignProjectStatus" class="form-control" onchange="GetCurrentAssignmentList();">
                                                                    <option value="">&nbsp;</option>
                                                                    <option value="1">No</option>
                                                                    <option value="0">Yes</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <table id="emsubtabCurrentAsignmentTbl" class="table table-bordered" style="width: 100%;">
                                                    <thead>
                                                        <tr>
                                                            <th>Project Name</th>
                                                            <th>Role</th>
                                                            <th>Start Date</th>
                                                            <th>End Date</th>
                                                            <th>Actual Start Date</th>
                                                            <th>Actual End Date</th>
                                                            <th>Planned Efforts(hrs)</th>
                                                            <th>Actual Efforts(hrs)</th>
                                                            <th>Is Resource Active</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="empCurrentAssignmenttbl"></tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                        <%-- Old standalone tab code commented as per request
                        <div id="TabQualification" class="tab-pane">
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <button class="btn borderbtn mr-5" id="addQualiModal" data-bs-toggle="modal" data-bs-target="#MEaddQualificationModal" onclick="addQualiPopup();"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                                  <% If m_blnDeleteAccess Then %>
                                 <button class="btn borderbtn mr-5" id="DeleteQualiModal" onclick="DeleteEmpQualificationDetails();">Delete</button>
                                <% End If %>
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                            </div>
                            <table id="emsubtabQualTbl" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th>Qualification</th>
                                        <th>University Name</th>
                                        <th>Paassout Year</th>
                                        <th>Class/Grade</th>
                                        <th>Percentage/points</th>
                                        <th>
                                            <div class="custom_chckbox">
                                                <input id="MEQualficationCheck" class="chckHead2" type="checkbox">
                                                <label for="MEQualficationCheck"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="tblEmpQualification">
                                </tbody>
                            </table>
                        </div>
                        <div id="TabSkill" class="tab-pane">
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <button class="btn borderbtn mr-5" id="AddSkillModal" data-bs-toggle="modal" onclick="clearSkillDetails();" data-bs-target="#MESkillModal"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                                  <% If m_blnDeleteAccess Then %>
                                <button class="btn borderbtn mr-5" onclick="DeleteSkill();" id="DeleteSkillModal">Delete</button>
                                <% End If %>
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                            </div>
                            <input type="hidden" id="hiddenskillId" />
                            <table id="emsubtabSkillTbl" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th class="text-start">Skill</th>
                                        <th>Experience<span>(Years)</span></th>
                                        <th>Experience<span>(Months)</span></th>
                                        <th>Proficiency</th>
                                        <th>Core Competency</th>
                                        <th>
                                            <div class="custom_chckbox">
                                                <input id="MEskill0" class="chckskill" type="checkbox">
                                                <label for="MEskill0"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="empSkilltbl"></tbody>
                            </table>
                        </div>
                        --%>
                        
                        <div id="TabCost" class="tab-pane">
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <a class="btn borderbtn mr-5" id="AddCostModal" data-bs-toggle="modal" onclick="clearCostDetails();GetCurrencySymbolCost();" data-bs-target="#MEaddcostmodal"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
                                <!--<button class="btn btnyellow mr-5" id="">Save</button>
                           <button class="btn btnyellow mr-5" id="">Save And Add</button>-->
                                  <% If m_blnDeleteAccess Then %>
                                <button class="btn borderbtn mr-5" onclick="DeleteCost();" id="DeleteCostModal">Delete</button>
                                <% End If %>
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                            </div>

                            <table id="empsubtabCosttbl" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th>Effective From Date</th>
                                        <th>Cost Per Hour</th>
                                        <th>
                                            <div class="custom_chckbox">
                                                <input id="MEphotoUploadCheck" class="chkCost" type="checkbox">
                                                <label for="MEphotoUploadCheck"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="empCosttbl">

                                </tbody>
                                
                            </table>

                        </div>
                        <%-- //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                        <% If False Then %>
                        <div id="TabVisaDetails" class="tab-pane">
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <a href="javascript:;" class="btn borderbtn mr-5" id="AddVisaModal" data-bs-toggle="modal" onclick="clearVisaDetails();" data-bs-target="#MEaddVisaDetailmodal"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
                                  <% If m_blnDeleteAccess Then %>
                                <button class="btn borderbtn mr-5" onclick="DeleteVisaDetails();" id="">Delete</button>
                                <% End If %>
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                            </div>
                            <table id="emsubtabVisaTbl" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th>Country</th>
                                        <th>Visa Type</th>
                                        <th>Valid From</th>
                                        <th>Valid To</th>
                                        <th>
                                            <div class="custom_chckbox">
                                                <input id="MEVisaCheck" class="chckVisa" type="checkbox">
                                                <label for="MEVisaCheck"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="emtblVisaType">
                                </tbody>
                               
                            </table>
                        </div>
                        <% End If %>
                        <%-- //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                        <div id="TabGroup" class="tab-pane">
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <button class="btn borderbtn mr-5" id="AddGroupModal" data-bs-toggle="modal" data-bs-target="#MEaddGroup" onclick="addGroupPopup();"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                               <%-- <button class="btn btnyellow mr-5" id="">Save</button>--%>
                                  <% If m_blnDeleteAccess Then %>
                               <button class="btn borderbtn mr-5" id="DeleteGroupModal" onclick="DeleteEmpGroups();">Delete</button>
                                <% End If %>

                                <!--<button class="btn btnyellow mr-5" id="">Save And Add</button>-->
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                            </div>
                            <table id="emsubtabGroupTbl" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th class="text-start">Group Name</th>
                                        <th width="80px">
                                            <div class="custom_chckbox">
                                                <input id="MEgroupCheck0" class="chckHead3" type="checkbox">
                                                <label for="MEgroupCheck0"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="tblEmpGroups">
                                    
                                </tbody>
                            </table>
                        </div>
                        <%-- //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                        <% If False Then %>
                        <div id="TabPreWorkExp" class="tab-pane">
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <button class="btn borderbtn mr-5" id="AddWorkExpModal" data-bs-toggle="modal" onclick="clearPreWorkExpDetails();" data-bs-target="#MEPWExpmodal"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                                  <% If m_blnDeleteAccess Then %>
                                <button class="btn borderbtn mr-5" onclick="DeletePreWorkExperience();" id="DeleteWorkExpModal">Delete</button>
                                <% End If %>
                                <%--COMMENTED By Reshma Chavan on 23 Feb 2022 does not require save button on list page--%>
                                <%--<button class="btn btnyellow mr-5" id="">Save</button>--%>
                                <%--End of COMMENTED By Reshma Chavan on 23 Feb 2022 does not require save button on list page--%>
                                <!--<button class="btn btnyellow mr-5" id="">Save And Add</button>-->
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                            </div>
                            <table id="emsubtabprewrkTbl" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th>Organization Name</th>
                                        <th>Position Held</th>
                                        <th>From Date</th>
                                        <th>Till Date</th>
                                        <th>Work Profile</th>
                                        <th>
                                            <div class="custom_chckbox">
                                                <input id="MEPWEcheck0" class="chckPerwork" type="checkbox">
                                                <label for="MEPWEcheck0"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="emprewrk"></tbody>
                                
                            </table>


                        </div>
                        <% End If %>
                        <%-- //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                        <%-- //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                        <% If False Then %>
                        <div id="TabPreAssignment" class="tab-pane">
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <button class="btn borderbtn mr-5" id="AddPrevAssModal" data-bs-toggle="modal" onclick="clearPreAssignmentDetails();" data-bs-target="#MEPrevAsignmentModal"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                                  <% If m_blnDeleteAccess Then %>
                                <button class="btn borderbtn mr-5" onclick="DeletePreAssignment();" id="DeletePrevAssModal">Delete</button>
                                <% End If %>
                                <%--COMMENTED By Reshma Chavan on 23 Feb 2022 does not require save button on list page--%>
                                <%--<button class="btn btnyellow mr-5" id="">Save</button>--%>
                                <%--End of COMMENTED By Reshma Chavan on 23 Feb 2022 does not require save button on list page--%>
                                <!--<button class="btn btnyellow mr-5" id="">Save And Add</button>-->
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                            </div>
                            <table id="emtabpreAssign" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th>Assignment Name</th>
                                        <th>Duration(Years)</th>
                                        <th>Team Size</th>
                                        <th>Functional Role</th>
                                        <th>
                                            <div class="custom_chckbox">
                                                <input id="MEPAsignmentscheck0" class="chckHeadPreAssgn" type="checkbox">
                                                <label for="MEPAsignmentscheck0"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="empreAssign">
                                </tbody>
                                
                            </table>
                        </div>
                        <% End If %>
                        <%-- //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                        <%-- //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>
                        <% If False Then %>
                        <div id="TabCurrentAssignmnt" class="tab-pane">
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <!--<button class="btn borderbtn mr-5" id=""><i class="fa fa-plus" aria-hidden="true"></i> Add</button>
                                <button class="btn btnyellow mr-5" id="">Save</button>-->
                                <!--<button class="btn btnyellow mr-5" id="">Save And Add</button>-->
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                            </div>

                            <div class="pt-1 pb-1 row">
                                <div class="col-sm-4">
                                    <div class="row">
                                    <div class="col-sm-5 text-end">
                                    <label for="currAssignProjectAsscee">Project Access</label>
                                        </div>
                                    <div class="col-sm-7 pe-0 ps-0">
                                    <select id="currAssignProjectAsscee" class="form-control"  onchange="GetCurrentAssignmentList();")>
                                        <%--Commented By Reshma chavan on 6th Oct 2021 For Remove Blank row--%>
                                        <%--<option value="">&nbsp;</option>--%>
                                        <%--End of Commented By Reshma chavan on 6th Oct 2021 For Remove Blank row--%>
                                        <option value="0">Accessible</option>
                                        <option value="1">Allocated</option>
                                    </select>
                                </div>

                                    </div>
                               </div>
                               <div class="col-sm-4">
                                    <div class="row">
                                    <div class="col-sm-5 text-end">
                                    <label for="currAssignProjectOver">Is Project Over?</label>
                                        </div>
                                        <div class="col-sm-7 pe-0 ps-0">
                                    <select id="currAssignProjectOver" class="form-control" onchange="GetCurrentAssignmentList();">
                                        <option value="">&nbsp;</option>
                                        <option value="0">No</option>
                                        <option value="1">Yes</option>
                                    </select>
                                </div> 
                                    </div>

                               </div>
                                <div class="col-sm-4">
                                    <div class="row">
                                    <div class="col-sm-5 text-end pe-0 ps-0">
                                    <label for="currAssignProjectStatus">Is Resource Active?</label>
                                        </div>
                                        <div class="col-sm-7">
                                    <select id="currAssignProjectStatus" class="form-control" onchange="GetCurrentAssignmentList();">
                                        <option value="">&nbsp;</option>
                                        <option value="1">No</option>
                                        <option value="0">Yes</option>
                                    </select>
                                </div>

                                    </div>

                                </div>
                            </div>

                            <table id="emsubtabCurrentAsignmentTbl" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th>Project Name</th>
                                        <th>Role</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Actual Start Date</th>
                                        <th>Actual End Date</th>
                                        <th>Planned Efforts(hrs)</th>
                                        <th>Actual Efforts(hrs)</th>
                                        <th>Is Resource Active</th>
                                    </tr>
                                </thead>
                                <tbody id="empCurrentAssignmenttbl"></tbody>
                                
                            </table>

                        </div>
                        <% End If %>
                        <%-- //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement --%>

                        <div id="Tabshowhistory" class="tab-pane">
                            <div class="detailsubtabsbtn pb-1 text-end">
                                <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleEmpDetails();">Cancel</button>
                            </div>
                            <table id="emsubtabShowHistoryTbl" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th>Field Name</th>
                                        <th>Old Value</th>
                                        <th>New Value</th>
                                        <th>Date And Time</th>
                                        <th>Updated By</th>
                                    </tr>
                                </thead>
                                <tbody id="emsubtabShowHistoryTblMain">
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Save filter Modal start here-->
            <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modalsmall ui-draggable" role="document">
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
                                    <div class="form-group mb-0" style="display:block">
                                        <div class="row">
                                            <div class="col-md-12 row">
                                                <label class="control-label col-md-4 p-0 text-end required">Filter Name :</label>
                                                <span class="col-md-8">
                                                   <% CommonFunctions.HTMLControls.DrawTextBox("txtVTFilterName", "txtVTFilterName", "form-control",, maxLength:=100, ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                                                    <div class="btnrow">
                                                        <button class="btn btnyellow float-start" id="btnSaveFilter" onclick="SaveVTFilterDetails()">Save</button>
                                                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end" onclick="cancelsaveapply()">Cancel</button>
                                                    </div>
                                                </span>
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
            <!-- Add Certification Modal start here-->
            <div class="modal custmodal fade" id="AddCertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <input type="hidden" name="hdnCertificationId" id="hdnCertificationId" />
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Add Certification</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label class="required">Certification Name</label>
                                        <%--Commented And Added by reshma chavan on 7th Oct 2021 get placeholder-IssueID-29728--%>
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("txtCertificationID", "usp_Whizible2_sel_tbl_PM_Certifications ",,, "class='form-control'", True, ) %>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtCertificationID", "usp_Whizible2_sel_tbl_PM_Certifications ",,, "class='form-control'",, ) %>
                                    </div>

                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="required">Certification Date</label>
                                        <div class="input-group datefielddiv">
                                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtCertificationDate", "txtCertificationDate", "form-control",,,) %>--%>
                                             <% CommonFunctions.HTMLControls.DrawTextBox("txtCertificationDate", "txtCertificationDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <%-- End of Commented and added by Chetan M on 29 Jul 2021 for making control Readonly --%>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Valid Upto Date</label>
                                        <div class="input-group datefielddiv">
                                            <% 'CommonFunctions.HTMLControls.DrawTextBox("txtValidUpto", "txtValidUpto", "form-control",,,) %>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtValidUpto", "txtValidUpto", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label>Actual Score</label>
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtActualScore", "txtActualScore", cssClass:="form-control", widthInPixel:=0, maxLength:=12, ToBeInserted:=" onkeypress='return Field_OnKeyPressPro(event)'")%>
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Out of</label>
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtTotalScore", "txtTotalScore", cssClass:="form-control", widthInPixel:=0, maxLength:=12, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)'")%>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <br />
                                <div class="text-center">
                                     <%--Added By Chetan M. on 10 Aug 2021--%>
                                    <button class="btn btnyellow" onclick="UpdateCertification();" id="btnUpdateCertification" Style="display: none;">Update</button>
                                    <%--End of Added By Chetan M. on 10 Aug 2021--%>
                                    <button class="btn btnyellow" id="btnSaveCertifaction" onclick="saveCertification(0);">Save</button>
                                    <button class="btn btnyellow" id="btnSaveCert" onclick="saveCertification(1);">Save And Add</button>
                                    <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Add Certification Modal End here-->
            <!--Add Cost Modal start here-->
            <div class="modal custmodal fade" id="MEaddcostmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Add Cost</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                            <div class="row">

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="required">Effective From Date</label>
                                        <div class="input-group datefielddiv">
                                            <% 'CommonFunctions.HTMLControls.DrawTextBox("MECostEffectiveDate", "MECostEffectiveDate", "form-control",,,) %>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("MECostEffectiveDate", "MECostEffectiveDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="required">Cost Per Hour</label>
                                        <div class="row">
                                            <div class="col-sm-11">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtMECostPerHour", "txtMECostPerHour", "form-control", widthInPixel:=0, maxLength:=50)%>
                                            </div>
                                            <div class="col-sm-1 pl-0 currencysymbol">Rs.</div>
                                        </div>
                                    </div>


                                    <div class="clearfix"></div>
                                </div>

                                <br />
                                <div class="text-center">
                                    <%--Added By Rutuja D. on 5 Aug 2021--%>
                                    <button class="btn btnyellow" onclick="UpdateCurrencyCost();" id="btnUpdateCost" Style="display: none;">Update</button>
                                    <%--End of Added By Rutuja D. on 5 Aug 2021--%>
                                    <button class="btn btnyellow" onclick="SaveCostDetails(0);" id="btnsave">Save</button>
                                    <button class="btn btnyellow" id="btnSaveCost"  onclick="SaveCostDetails(1);">Save And Add</button>
                                    <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Add Cost Modal End here-->
            <!--Add Visa details Modal start here-->
            <div class="modal custmodal fade" id="MEaddVisaDetailmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
                <input type="hidden" name="hdnEmployeeVisaID" id="hdnEmployeeVisaID" />
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Visa Detail</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                            <div class="row">

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        
                                        <label class="required">Country</label>
                                        <div>
                                             <%-- Commented And Added By Reshma Chavan on 6th Oct 2021 To get Placeholder IssueID-29754--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboCountry", "usp_Whizible2_sel_tbl_PM_CountryMaster",,, "class='form-control'", True,,) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboCountry", "usp_Whizible2_sel_tbl_PM_CountryMaster",,, "class='form-control'",,,) %>
                                           <%-- End of Commented And Added By Reshma Chavan on 6th Oct 2021 To get Placeholder IssueID-29754--%>
                                            </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="required">Visa Type</label>
                                        <div>
                                           <%-- Commented And Added By Reshma Chavan on 6th Oct 2021 To get Placeholder IssueID-29755--%>
                                           <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboVisaType", "usp_Whizible2_sel_tbl_PM_VisaTypeMaster",,, "class='form-control'", True,,) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboVisaType", "usp_Whizible2_sel_tbl_PM_VisaTypeMaster",,, "class='form-control'",,,) %>
                                        <%-- End of Commented And Added By Reshma Chavan on 6th Oct 2021 To get Placeholder IssueID-29755--%>
                                            </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="required">Valid From</label>
                                        <div class="input-group datefielddiv">
                                            <%'CommonFunctions.HTMLControls.DrawTextBox("MEvalidFromDate", "MEvalidFromDate", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("MEvalidFromDate", "MEvalidFromDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="required">Valid To</label>
                                        <div class="input-group datefielddiv">
                                            <%'CommonFunctions.HTMLControls.DrawTextBox("MEvalidToDate", "MEvalidToDate", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("MEvalidToDate", "MEvalidToDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label>Remarks</label>
                                        <% CommonFunctions.HTMLControls.DrawTextArea("description", "txtDescription", "Enter Description (Maxlength 100 Chars)", "form-control", ,,,, , , 100,,,,,,,, "Placeholder='Enter Description (Maxlength 100 Char)' autocomplete='Off' maxlength='100'",, False,,,,,,,,) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <br />
                                <div class="text-center">
                                    <%--Added By Rutuja D. on 5 Aug 2021--%>
                                    <button class="btn btnyellow" onclick="UpdateVisaDetails();" id="btnUpdateVisa" Style="display: none;">Update</button>
                                    <%--End of Added By Rutuja D. on 5 Aug 2021--%>
                                    <button class="btn btnyellow" ID="BtnSaveVisaDetails" onclick="SaveVisaDetails(0);">Save</button>
                                    <button class="btn btnyellow" id="btnSaveVisaModal" onclick="SaveVisaDetails(1)">Save And Add</button>
                                    <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Add Cost Modal End here-->
            <!--Add Qualification details Modal start here-->
            <div class="modal custmodal fade" id="MEaddQualificationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <input type="hidden" name="hdnQualificationId" id="hdnQualificationId" />

                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Add Qualification</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                            <div class="row">

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="required">Qualification</label>
                                         <%--Commented And Added By Reshma Chavan on 6th Oct 2021 For Getting Placeholder-IssueID-29760 --%>
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboQualificationID", "usp_Whizible2_sel_tbl_PM_Qualifications",,, "class='form-control'", True, ) %>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboQualificationID", "usp_Whizible2_sel_tbl_PM_Qualifications",,, "class='form-control'",,, ) %>
                                    <%--Commented And Added By Reshma Chavan on 6th Oct 2021 For Getting Placeholder-IssueID-29760 --%>
                                        </div>
                                    <div class="col-sm-6">
                                        <label class="required">University Name</label>
                                        <%--<input type="text" class="form-control" />--%>
                                         <%--Commented And Added By Reshma Chavan on 6th Oct 2021 For Getting Placeholder-IssueID-29761 --%>
                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtUniversityName", "txtUniversityName", cssClass:="form-control", widthInPixel:=0, maxLength:=100) %>--%>
                                         <% CommonFunctions.HTMLControls.DrawTextArea("txtUniversityName", "txtUniversityName", "Enter University Name (Maxlength 100 Char)", "form-control",,,,, , , 100,,,,,,,, "placeholder='Enter University Name (Maxlength 100 Char)' autocomplete='Off' maxlength='100'",,,,,,,,,,) %>
                                     <%--End of Commented And Added By Reshma Chavan on 6th Oct 2021 For Getting Placeholder-IssueID-29761 --%>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="required">Passout Year</label>
                                        <%--Commented And Added By Reshma Chavan on 6th Oct 2021 For Getting Placeholder-IssueID-29763 --%>
                                   <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboPassoutYear", "usp_Sel_GetYears 1950",,, "class='form-control'", True, ) %>--%>
                                  <% CommonFunctions.HTMLControls.DrawComboBox("cboPassoutYear", "usp_Sel_GetYears 1950",,, "class='form-control'",,, ) %>
                                        
                                        <%--End of Commented And Added By Reshma Chavan on 6th Oct 2021 For Getting Placeholder-IssueID-29763--%> 
                                        
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="required">Class / Grade</label>
                                        <%-- <input type="text" class="form-control" />--%>
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtClass", "txtClass", cssClass:="form-control", widthInPixel:=0, maxLength:=50) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="">Percentage / Points</label>
                                        <%--Commented & Added By Rutuja D. on 10 Aug 2021 For Restrict Character--%> 
                                        <% 'CommonFunctions.HTMLControls.DrawTextBox("txtPercentage", "txtPercentage", cssClass:="form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:="onkeypress=Return isNumberKey(this, event);") %>
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtPercentage", "txtPercentage", "form-control", 0, 50,,,,,,,, "onkeypress = 'return isNumberKey(this, event);'") %>
                                        <%--End of Commented & Added By Rutuja D. on 10 Aug 2021 For Restrict Character--%> 
                                    </div>
                                    <div class="col-sm-6">
                                        &nbsp;
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <br />
                                <div class="text-center">
                                     <%--Added By Rutuja D. on 5 Aug 2021--%>
                                    <button class="btn btnyellow" onclick="UpdateQualification();" id="btnUpdateQua" Style="display: none;">Update</button>
                                    <%--End of Added By Rutuja D. on 5 Aug 2021--%>
                                    <button class="btn btnyellow" id="btnQuaSave" onclick="saveQualification(0)">Save</button>
                                    <button class="btn btnyellow" id="btnSaveQualification" onclick="saveQualification(1)">Save And Add</button>
                                    <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Add Qualification Modal End here-->
            <!--Add Group Modal start here-->
            <div class="modal custmodal fade" id="MEaddGroup" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
               <input type="hidden" name="hdnGroupId" id="hdnGroupId" />

                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Add Group</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                            <div class="row">

                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label class="required">Group Name</label>
                                        <%--Commented And Added By Reshma Chavan on 6th Oct 2021 for get Placeholder--%>
                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboGroup", "Select 0,''",,, "class=""form-control""", True,,, ,)%>--%>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboGroup", "Select 0",,, "class='form-control'",,,, ,)%>
                                    <%--End of Commented And Added By Reshma Chavan on 6th Oct 2021 for get Placeholder--%>
                                        </div>

                                    <div class="clearfix"></div>
                                </div>


                                <br />
                                <div class="text-center">
                                     <%--Added By Chetan M. on 13 Aug 2021--%>
                                    <button class="btn btnyellow" onclick="UpdateEmpGroups();" id="btnUpdateEmpGroups" Style="display: none;">Update</button>
                                    <%--End of Added By Chetan M. on 13 Aug 2021--%>
                                    <button class="btn btnyellow" id="btnAddEmpGroup" onclick="saveEmpGroups(0);">Save</button>
                                    <button class="btn btnyellow" id="btnsaveEmpGroup" onclick="saveEmpGroups(1);">Save And Add</button>
                                    <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Add Group Modal End here-->
            <!--Prev Work Experience Modal start here-->
            <div class="modal custmodal fade" id="MEPWExpmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Previous Work Experience</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                            <div class="row">

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="required">Organization Name</label>
                                        <div>
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtPreWorkExpOrganisation", "txtPreWorkExpOrganisation", "form-control", widthInPixel:=0, maxLength:=50)%>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="required">Position Held</label>                                        <div>
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtPreWorkExpPositionHeld", "txtPreWorkExpPositionHeld", "form-control", widthInPixel:=0, maxLength:=50)%>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="required">From Date</label>
                                        <div class="input-group datefielddiv">
                                            <%'CommonFunctions.HTMLControls.DrawTextBox("MEPWEFromDate", "MEPWEFromDate", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("MEPWEFromDate", "MEPWEFromDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="required">Till Date</label>
                                        <div class="input-group datefielddiv">
                                            <%'CommonFunctions.HTMLControls.DrawTextBox("MEPWEtillDate", "MEPWEtillDate", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("MEPWEtillDate", "MEPWEtillDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label>Work Profile</label>
                                        <div>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPreWorkExpWorkProfile", "usp_Whizible2_sel_v_h_tbl_HR_Parameters ",,, "class='form-control'", True,,) %>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                    <%--    Commented & Added By Dipali V on 3rd Dec 2021 For Correct Spelling--%>
                                      <%--  <label>Summury</label>--%>
                                          <label>Summary</label>
                                        <%--    End of Commented & Added By Dipali V on 3rd Dec 2021 For Correct Spelling--%>
                                        <div>
                                            <% CommonFunctions.HTMLControls.DrawTextArea("txtPreWorkExpSummary", "txtPreWorkExpSummary", "Enter Description (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Description (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <br />
                                <div class="text-center">
                                     <%--Added By Chetan M. on 10 Aug 2021--%>
                                    <button class="btn btnyellow" onclick="UpdatePreviousExperience();" id="btnUpdateExperience" Style="display: none;">Update</button>
                                    <%--End of Added By Chetan M. on 10 Aug 2021--%>
                                    <button class="btn btnyellow" id="btnSavePreWorkExpDetails" onclick="SavePreWorkExpDetails(0);">Save</button>
                                    <button class="btn btnyellow" id="btnSavePreWork"  onclick="SavePreWorkExpDetails(1);">Save And Add</button>
                                    <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Prev Work Experience Modal End here-->
            <!--Prev Assignment Modal start here-->
            <div class="modal custmodal fade" id="MEPrevAsignmentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Previous Assignment</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                            <div class="row">
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="required">Assignment Name</label>
                                        <div>
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtPreAssProjectName", "txtPreAssProjectName", "form-control", widthInPixel:=0, maxLength:=50)%>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="required">Functional Role</label>
                                        <div>
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtPreAssRole", "txtPreAssRole", "form-control", widthInPixel:=0, maxLength:=50)%>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="required">Duration (Years)</label>
                                        <div>
                                            <%-- Commented and added by Chetan M on 10 Aug 2021 for Issue fixing --%>
                                            <%'CommonFunctions.HTMLControls.DrawTextBox("txtPreAssDuration", "txtPreAssDuration", "form-control", widthInPixel:=0, maxLength:=2)%>
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtPreAssDuration", "txtPreAssDuration", "form-control", widthInPixel:=0, maxLength:=4)%>
                                            <%-- End of Commented and added by Chetan M on 10 Aug 2021 for Issue fixing --%>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="required">Team Size</label>
                                        <div>
                                            <%--        <%CommonFunctions.HTMLControls.DrawTextBox("txtTeamSize", "txtTeamSize", "form-control", widthInPixel:=0, maxLength:=50)%>--%>
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtTeamSize", "txtTeamSize", cssClass:="form-control", widthInPixel:=0, maxLength:=3, ToBeInserted:=" onkeypress='return Field_OnKeyPressnumeric(event,txtTeamSize);'")%>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label>Environment</label>
                                        <div>
                                            <% CommonFunctions.HTMLControls.DrawTextArea("txtEnvironment", "txtEnvironment", "Enter Environment (Maxlength 200 Chars)", "form-control", ,,,, , , 200,,,,,,,, "Placeholder='Enter Environment (Maxlength 200 Char)' autocomplete='Off' maxlength='200'",, False,,,,,,,,) %>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label>Skills</label>
                                        <div>
                                            <% CommonFunctions.HTMLControls.DrawTextArea("txtSkills", "txtSkills", "Enter Skills (Maxlength 200 Chars)", "form-control", ,,,, , , 200,,,,,,,, "Placeholder='Enter Skills (Maxlength 200 Char)' autocomplete='Off' maxlength='200'",, False,,,,,,,,) %>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label>Description</label>
                                        <div>
                                            <% CommonFunctions.HTMLControls.DrawTextArea("txtPreAssDescription", "txtPreAssDescription", "Enter Description (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Description (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>


                                <br />
                                <div class="text-center">
                                     <%--Added By Chetan M. on 10 Aug 2021--%>
                                    <button class="btn btnyellow" onclick="UpdatePreviousAssignment();" id="btnUpdatePreviousAssignment" Style="display: none;">Update</button>
                                    <%--End of Added By Chetan M. on 10 Aug 2021--%>
                                    <button class="btn btnyellow" id="btnSavePreAssignmentDetails" onclick="SavePreAssignmentDetails(0);">Save</button>
                                    <button class="btn btnyellow" id="btnSavePreAssignment" onclick="SavePreAssignmentDetails(1);">Save And Add</button>
                                    <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Prev Assignment Modal End here-->
            <!--Skill Modal start here-->
            <div class="modal custmodal fade" id="MESkillModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Skill</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                            <div class="row">

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="required">Skill</label>
                                        <div>
                                            <%-- Commented and added by Chetan M 4 Aug 2021 --%>
                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("cboempskill", "usp_Whizible2_sel_tbl_PM_ToolSkill ",,, "class='form-control'", True,,) %>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboempskill", "Select 0,'  Select Column ' ",,, " class='form-control'' ",,, True) %>
                                            <%-- End of Commented and added by Chetan M 4 Aug 2021 --%>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="">Experience Years / Months</label>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div>
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboskillyear", "usp_sel_GetYears 0, 50  ",,, "class='form-control'", True,,) %>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div>
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboskillmonth", "usp_sel_GetYears 0, 11  ",,, "class='form-control'", True,,) %>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="">Proficiency</label>
                                        <div>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboskillProficiency", "usp_Whizible2_sel_tbl_HR_Parameters_phaseII ",,, "class='form-control'", True,,) %>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="">&nbsp;</label>
                                        <div class="custom_chckbox">
                                            <input id="MEcoreCompetencyCheck" class="chcktbl" type="checkbox">
                                            <label for="MEcoreCompetencyCheck">Core Competency</label>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label>Notes</label>
                                        <% CommonFunctions.HTMLControls.DrawTextArea("txtSkillNotes", "txtSkillNotes", "Enter Description (Maxlength 4000 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='' autocomplete='Off' maxlength='1000'",, False,,,,,,,,) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>


                                <br />
                                <div class="text-center">
                                    <button class="btn btnyellow" onclick="SaveSkillDetails(0);">Save</button>
                                    <button class="btn btnyellow" id="btnSaveSkill"  onclick="SaveSkillDetails(1);">Save And Add</button>
                                    <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Skill Modal End here-->
            <!--Excel Upload Modal start here-->
            <div id="exceluploadsteps" class="modal fade custmodal" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog modal-lg" style="width: 80%">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Excel Upload</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!--step_wizard-->
                        <ul class="nav nav-wizard">
                            <li class="active pointerDisable">
                                <a href="#PBEUstep1" data-bs-toggle="tab" id="btnaStep1">Step 1</a>
                            </li>
                            <li class="disabled pointerDisable">
                                <a href="#PBEUstep2" data-bs-toggle="tab" id="btnaStep2">Step 2</a>
                            </li>
                            <li class="disabled pointerDisable">
                                <a href="#PBEUstep3" data-bs-toggle="tab" id="btnaStep3">Step 3</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="PBEUstep1">
                                <div class="file_attach">
                                    <form id="frmFileUpload">
                                        <input type="file" multiple id="txtFileUpload" onchange="showName()" accept=".xlsx">
                                        <p><span id="plabelName"></span> <span id="dvShowFileName"></span></p>
                                        <button type="submit">Upload</button>
                                    </form>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="clearfix"></div>
                                <br />
                                <br />
                                <div class="list-inline text-center">
                                    <button type="button" class="btn btnyellow nextwizardbtn ml-1 " onclick="EmpUploadxlsfile()">Next</button>
                                </div>

                            </div>

                            <div class="tab-pane" id="PBEUstep2">
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-A</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_A", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-B</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_B", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-C</label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_C", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-D</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_D", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-E</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_E", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-F</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_F", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-G</label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_G", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-H</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_H", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-I</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_I", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-J</label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_J", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-K</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_K", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-L</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_L", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-M</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_M", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-N</label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_N", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-O</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_O", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-P</label>
                                      <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_P", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-Q</label>
                                      <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_Q", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                   <%-- Added By Dipali V On 3rd Sep 2021--%>
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-R</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_R", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                 <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class="">Excel Column-S</label>
                                      <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_S", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                   
                                   <div class="clearfix"></div> 
                                </div>
                                <%-- End of Added By Dipali V On 3rd Sep 2021 --%>



                                <br />
                                <br />
                                <ul class="text-center">
                                    <li>
                                        <button id="btnPrevious" type="button" class="btn borderbtn btnPrevious" onclick="IrmBackStep_2()">Back</button>
                                        <button type="button" class="btn btnyellow nextwizardbtn ml-1 " onclick="IrmNextStep_2()">Next</button></li>
                                </ul>

                            </div>
                            <div class="tab-pane" id="PBEUstep3">
                                 <div class="float-start" style="width:100%">
                                    <a href="#">Uploaded Data : <span id="dvShowFileNameStep3"></span></a>
                                        <div class="form-group float-end">
                                            <div class="input-group searchsetting" id="searchsetting">
                                                <input id="txtSearchXlsxEmpName" type="text" class="form-control searchempname"  placeholder="Search Employee name">
                                                <span class="input-group-addon">
                                                    <button type="submit" onclick="SearchEmplistByName()">
                                                        <span class="glyphicon glyphicon-search"></span>
                                                    </button>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="clearfix"></div>
                                        <div class="dataTables_scrollBody" style="position: relative; overflow: auto; width: 100%; height: auto;">

                                            <table id="exluploadTbl" class="table bgwhite table-bordered" style="width: 100%; margin-left: 0px;">
                                                <thead>
                                                    <tr>
                                                <th>Is Valid</th>
                                                <th>Employee Name</th>
                                                <th>User</th>
                                                <th>Employee Code</th>
                                                <th>Gender</th>
                                                <th>Email</th>
                                                <th>Birth Date</th>
                                                <th>Role</th>
                                                <th>Reporting To</th>
                                                <th>Joining Date</th>
                                                <th>Business Group</th>
                                                <th>Organization Unit</th>
                                                <th>Designation</th>
                                                <th>Department</th>
                                                <th>Employee Type</th>
                                                <th>Cost To Company</th>
                                                <th>Rate Per Hour</th>
                                                <th>Cost Per Hour</th>
                                                <th>Deployable</th>
                                                <th>Currency</th>
                                                <th>Error</th>                          
                                                </tr>
                                                </thead>

                                                <tbody id="exluploadTblTbody">
                                                </tbody>

                                            </table>
                                        </div>
                                        <br />
                                        <br />
                                        <ul class="list-inline text-center" style="margin-bottom: -20px;">
                                            <li>
                                                <button id="btnPrevious" type="button" class="btn borderbtn btnPrevious" onclick="IrmBackStep_3()" >Back</button>
                                                <button type="button" id="btnEmpXlsxSave" class="btn btnyellow nextwizardbtn ml-1 uploadbtn"  onclick="IrmSaveXlsxData()">Upload</button>
                                            </li>
                                        </ul>
                                    </div>
                            </div>
                            
                            <div class="clearfix"></div>
                        </div>
                       
                        <!--End_step_wizard-->

                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- Excel Upload Modal End here-->
            <!--resume modal start here-->
            
            <!--resume modal end here-->
            <!--show history modal start here-->
            <div class="modal custmodal fade" id="showhistoryModal" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">History</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Filed Name</th>
                                        <th>Old Value</th>
                                        <th>New Value</th>
                                        <th>Date And Time</th>
                                        <th>Updated By</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Duration</td>
                                        <td>2</td>
                                        <td>5</td>
                                        <td>15 Dec 2017 9:31AM</td>
                                        <td>ABC</td>
                                    </tr>
                                    <tr>
                                        <td>Duration</td>
                                        <td>2</td>
                                        <td>5</td>
                                        <td>15 Dec 2017 9:31AM</td>
                                        <td>ABC</td>
                                    </tr>
                                    <tr>
                                        <td>Duration</td>
                                        <td>2</td>
                                        <td>5</td>
                                        <td>15 Dec 2017 9:31AM</td>
                                        <td>ABC</td>
                                    </tr>
                                    <tr>
                                        <td>Duration</td>
                                        <td>2</td>
                                        <td>5</td>
                                        <td>15 Dec 2017 9:31AM</td>
                                        <td>ABC</td>
                                    </tr>
                                    <tr>
                                        <td>Duration</td>
                                        <td>2</td>
                                        <td>5</td>
                                        <td>15 Dec 2017 9:31AM</td>
                                        <td>ABC</td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>

                    </div>
                </div>
            </div>
            <!--show history end here-->
            <!--Employee release modal start here-->
            <div class="modal custmodal fade" id="EPReleasemodal" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Release</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <input type="hidden" name="hdn_EmpReleaseWithoutProject" id="hdn_EmpReleaseWithoutProject" value=0 />
                             <input type="hidden" name="hdn_EmpReleaseWithoutReportingTo" id="hdn_EmpReleaseWithoutReportingTo" value=0 />
                        </div>
                        <div class="modal-body">
                            <h5 class="mt-0 noteboxpanel_h5">Set New Approver</h5>
                            <div class="noteboxpanel graybg" id="ReleaseNoteDiv">
                                <h5 class="mt-0"><strong>Note</strong></h5>
                                <ul>
                                    <li><strong>Transfer Project Responsibilities To</strong> dropdown lists all employees who can be set as Responsible person for Timesheet blocking, Responsible person for issue and MSP File Owner, default Timesheet/Expense Approver and Responsible person for deliverable.</li>
                                    <li><strong>Transfer Approval Responsibilities To</strong> dropdown lists all employees who can be set as Timesheet Approvers, Expense Approvers and Project Timesheet Approvers.</li>
                                    <li><strong>Transfer Invoice Generator Responsibilities To</strong> dropdown lists all employees who can be set as Invoice generators.</li>
                                    <li><strong>Transfer IR/PIR Approvers Responsibilities To</strong> dropdown lists all employees who can be set as IR/PIR approvers.</li>
                                    <li><strong>Transfer Workflow Approval Responsibilities To</strong> dropdown lists all employees who can be set as Workflow approvers.</li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="form-inline" id="ReleaseSetProjDateDiv" style="display:inline">
                                <div class="form-group">
                                    <label class="required">Set Project Release Date</label>
                                    <div class="input-group" style="display:block">
                                        <%--<input id="TxtProReleaseDate" type="text" class="form-control input-sm" />--%>
                                        <% CommonFunctions.HTMLControls.DrawTextBox("TxtProReleaseDate", "TxtProReleaseDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button" style="height: 35px;margin-top:-7px;margin-left:-2px"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                            
                            <br />

                            <table id="EPRTblList" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th>&nbsp;&nbsp;</th>
                                        <th class="text-start">Project Name</th>
                                        <th>Project Manager</th>
                                        <th>Transfer Project Responsibilities To</th>
                                        <th>Transfer Approval Responsibilities To</th>
                                        <th>Transfer Invoice Generation Responsibilities To</th>
                                        <th>Transfer IR/PIR Approval Responsibilities To</th>
                                        <th>Transfer Workflow Approval Responsibilities To</th>

                                    </tr>
                                </thead>
                                <tbody id="ReleaseTblTbody">
                                   
                                </tbody>
                            </table>
                            </div>
                            <div class="form-inline">
                                <div class="form-group dateFormt">
                                    <label class="required">Set Leaving Date</label>
                                    <div class="input-group" style="display:block">
                                        <%--<input id="TxtReleaseLeavingDate" type="text" class="form-control input-sm" />--%>
                                        <% CommonFunctions.HTMLControls.DrawTextBox("TxtReleaseLeavingDate", "TxtReleaseLeavingDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button" style="height: 35px;margin-top:-7px;margin-left:-2px"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <hr />
                            <div id="ReleaseReportingToDiv">
                            <p><strong>Note:</strong>  The resource is 'Reporting To' for the following Resources</p>
                            <div class="form-inline pb-1">
                                <div class="form-group">
                                    <label class="required">Select New Reporting To</label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboEmpRelaseReportingTo", "usp_Whizible2_sel_tbl_ReportingTo",,, "class='form-control'", True,,, ,) %>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered table-stripped" style="width: 100%;" id="ReleaseReportingToTable">
                                    <thead>
                                        <tr>
                                            <th class="text-start">Employee</th>
                                            <%--<th width="50px">&nbsp;</th>--%>
                                        </tr>
                                    </thead>
                                    <tbody id="ReleaseReportingToBody" >
                                    </tbody>
                                </table>
                            </div>
                            </div>
                            <div class="text-center">
                                <button class="btn btnyellow" onclick="ReleaseResource()">Save</button>
                                <button class="btn borderbtn" aria-hidden="true" data-bs-dismiss="modal">Cancel</button>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
            <!--Employee release modal end here-->



            <div class="clearfix"></div>
        </div>
    </div>
    <div class="modal custmodal fade" id="DeleteConfirmMModalForGroup" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                <h5 class="modal-title" id="">Delete Status</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%-- <div class="form-group row">
                       <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <div class="notebox">
                        <strong>Note:</strong>  Group which is in use cannot be deleted.<br />
                        <p id="showdeleterowGroup"></p>
                    </div>

                    <div class="text-end">
                      <%--  <button class="btn btnyellow" onclick=" DeleteCertificationDetailsAfterConfirm()">Yes</button>--%>
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="modal custmodal fade" id="DeleteConfirmMModalForQuali" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Status</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%-- <div class="form-group row">
                       <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <div class="notebox">
                        <strong>Note:</strong>  Qualification which is in use cannot be deleted.<br />
                        <p id="showdeleterowQuali"></p>
                    </div>

                    <div class="text-end">
                        <%--  <button class="btn btnyellow" onclick=" DeleteCertificationDetailsAfterConfirm()">Yes</button>--%>
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="modal custmodal fade" id="DeleteConfirmMModal" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Status</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%-- <div class="form-group row">
                       <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <div class="notebox">
                        <strong>Note:</strong>  Certification which is in use cannot be deleted.<br />
                        <p id="showdeleterow"></p>
                    </div>

                    <div class="text-end">
                        <%--  <button class="btn btnyellow" onclick=" DeleteCertificationDetailsAfterConfirm()">Yes</button>--%>
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <%--Delete confirmation modelfor pre assignment--%>
    <div class="modal custmodal fade" id="DeleteConfirmPreAssignmentModal" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%--  <div class="form-group row">
                        <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <div class="form-group row">
                        Are you sure, you want to delete the selected records?
                    </div>

                    <div class="text-end">
                        <button class="btn btnyellow" onclick=" DeletePreAssignmentAfterConfirm()">Yes</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal">No</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <%--Delete confirmation model for preworkexperience--%>
    <div class="modal custmodal fade" id="DeleteConfirmPreWorkExpModal" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%--  <div class="form-group row">
                        <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <div class="form-group row">
                        Are you sure, you want to delete the selected records?
                    </div>

                    <div class="text-end">
                        <button class="btn btnyellow" onclick=" DeletePreWorkExpAfterConfirm()">Yes</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal">No</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <%--Delete confirmation model for cost--%>
    <div class="modal custmodal fade" id="DeleteConfirmCostModal" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%--  <div class="form-group row">
                        <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <div class="form-group row">
                        Are you sure, you want to delete the selected records?
                    </div>

                    <div class="text-end">
                        <button class="btn btnyellow" onclick=" DeleteCostAfterConfirm()">Yes</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal">No</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <%--Delete confirmation model for skill--%>
   
    <div class="modal custmodal fade" id="DeleteConfirmSkillModal" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Status</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="notebox">
                        <strong>Note:</strong>  Skill which is in use cannot be deleted.<br />
                        <p id="showdeleterowSkill"></p>
                    </div>

                    <div class="text-end">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <%--Delete confirmation model for visa--%>
    <div class="modal custmodal fade" id="DeleteVisaModal" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%--  <div class="form-group row">
                        <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <div class="form-group row">
                        Are you sure, you want to delete the selected records?
                    </div>

                    <div class="text-end">
                        <button class="btn btnyellow" onclick="DeleteVisaAfterConfirm();">Yes</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal">No</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
   

       <%--Delete confirmation model for Employee main list--%>
    <div class="modal custmodal fade" id="DeleteConfirmEmployeeModal" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%--  <div class="form-group row">
                        <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <div class="form-group row">
                        Are you sure, you want to delete the selected records?
                    </div>
                    <input type="hidden" id="deleteemployeeid" />
                    <div class="text-end">
                        <button class="btn btnyellow" onclick="DeleteEmployeeAfterConfirm();">Yes</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal" onclick="CancelEmployeeDelete();">No</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <%--Added by Rutuja D on 6th July 2021--%>
     <div id="deleteConfirmAlert" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modalsmall ui-draggable">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header ui-draggable-handle">
                                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                                    <h4 class="modal-title">Delete Confirmation</h4>
                                </div>
                                <div class="modal-body">
                                    <input type="text" id="DFilterID" hidden="hidden" />
                                    <input type="text" id="DFilterName" hidden="hidden" />
                                    <input type="text" id="DIsApplyed" hidden="hidden" />
                                    <p id="deleteConfirmMsg"><center>Are you sure to delete the selected filter?</center></p>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal">No</button>
                                    <button class="btn btnyellow" data-bs-toggle="modal" data-bs-original-title="" data-bs-dismiss="modal" title="" onclick="confirmDelete()">Yes</button>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
    
   <%--End of Added by Rutuja D on 6th July 2021--%>

    <!-- REQUIRED JS SCRIPTS -->
  
  <%--  <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
   <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
   --%> <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
 <%--   <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>--%>
   <%-- <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<%--    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/common_filters.js?date=<%=DateTime.Now %>"></script>
    <script>
        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']"))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").hover(function () {
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip('update');
        }); //added by pradip on 24-3-2023

        //Added By Riddhesh Patil on 10-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        //End of  Added By Riddhesh Patil

        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var TagID = '<%= m_TagId%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var strUrl = '';
        var NoDataFound = "No data found.";
        var DeleteRecord = "Please select at least one record to delete.";
        var DeleteConfirm = "Are you sure, you want to delete the selected records?";
        strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        blnViewAccess = 'True'
        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';
        var noOfRowsPerPage = 10;
        var certificationTable;
        var qualificationTable;
        var groupTable;
        var visaTable;
        var costTable;
        var preworkTable;
        var preassignmentTable;
        var skillTable;
        var currentAssignmentTable;

        //costheadercount
        var costCount = 0;

        // Check or Uncheck for cost
        var selectedCostId = [];

        var TransferProjectCombo = new Array();
        var TransferApprovalCombo = new Array();
        var TransferInvoiceGenerationCombo = new Array();
        var TransferIRPIRApprovalCombo = new Array();
        var TransferWorkflowApprovalCombo = new Array();
        var GblReassignFlag = "0";  //Added By Reshma Chavan on 11Feb 2022

        $(".chkCost").change(function () {
            var allPages = costTable.fnGetNodes();
            var checked = $(this).is(':checked');
            if (checked) {
                $('input[type="checkbox"]', allPages).prop('checked', true);
                var rows = $("#empsubtabCosttbl").dataTable().fnGetNodes();
                for (var i = 0; i < rows.length; i++) {
                    selectedCostId.push(parseInt($(rows[i]).find("#hdnrm_EmployeeCostID").val()));
                }

            } else {
                $('input[type="checkbox"]', allPages).prop('checked', false);
                selectedCostId = [];
            }
        });
        function checkUncheckforCost() {
            if (costTable.$('input:checked').length == costTable.fnGetNodes().length) {
                $(".chkCost").prop("checked", true);
            } else {
                $(".chkCost").removeAttr("checked");
                $(".chkCost").prop("checked", false);
            }
        }

        $('#txtMECostPerHour').keypress(function (event) {
            if ((event.which != 46 || $(this).val().indexOf('.') != -1) &&
                ((event.which < 48 || event.which > 57) &&
                    (event.which != 0 && event.which != 8))) {
                event.preventDefault();
            }

            var text = $(this).val();

            if ((text.indexOf('.') != -1) &&
                (text.substring(text.indexOf('.')).length > 2) &&
                (event.which != 0 && event.which != 8) &&
                ($(this)[0].selectionStart >= text.length - 2)) {
                event.preventDefault();
            }
        });

        // Check or Uncheck for visa details

        var selectedVisaId = [];
        $(".chckVisa").change(function () {
            var allPages = visaTable.fnGetNodes();
            var checked = $(this).is(':checked');
            if (checked) {
                $('input[type="checkbox"]', allPages).prop('checked', true);
                var rows = $("#emsubtabVisaTbl").dataTable().fnGetNodes();
                for (var i = 0; i < rows.length; i++) {
                    selectedVisaId.push(parseInt($(rows[i]).find("#hdnrm_EmployeeVisaID").val()));
                }

            } else {
                $('input[type="checkbox"]', allPages).prop('checked', false);
                selectedVisaId = [];
            }
        });
        function checkUncheckforVisa() {
            // alert(1);
            if (visaTable.$('input:checked').length == visaTable.fnGetNodes().length) {
                $(".chckVisa").prop("checked", true);
            } else {
                $(".chckVisa").removeAttr("checked");
                $(".chckVisa").prop("checked", false);
            }
        }

        // Check or Uncheck for prework

        var selectedPreworkId = [];
        $(".chckPerwork").change(function () {
            var allPages = preworkTable.fnGetNodes();
            var checked = $(this).is(':checked');
            if (checked) {
                $('input[type="checkbox"]', allPages).prop('checked', true);
                var rows = $("#emsubtabprewrkTbl").dataTable().fnGetNodes();
                for (var i = 0; i < rows.length; i++) {
                    selectedPreworkId.push(parseInt($(rows[i]).find("#hdnrm_EmployeeHistoryID").val()));
                }

            } else {
                $('input[type="checkbox"]', allPages).prop('checked', false);
                selectedPreworkId = [];
            }
        });
        function checkUncheckforPrework() {
            if (preworkTable.$('input:checked').length == preworkTable.fnGetNodes().length) {
                $(".chckPerwork").prop("checked", true);
            } else {
                $(".chckPerwork").removeAttr("checked");
                $(".chckPerwork").prop("checked", false);
            }
        }

        // Check or Uncheck for pressignment

        var selectedPreassignmentId = [];
        $(".chckHeadPreAssgn").change(function () {
            var allPages = preassignmentTable.fnGetNodes();
            var checked = $(this).is(':checked');
            if (checked) {
                $('input[type="checkbox"]', allPages).prop('checked', true);
                var rows = $("#emtabpreAssign").dataTable().fnGetNodes();
                for (var i = 0; i < rows.length; i++) {
                    selectedPreassignmentId.push(parseInt($(rows[i]).find("#hdnrm_EmployeeHistoryProjectID").val()));
                }

            } else {
                $('input[type="checkbox"]', allPages).prop('checked', false);
                selectedPreassignmentId = [];
            }
        });
        function checkUncheckforPreassignment() {
            if (preassignmentTable.$('input:checked').length == preassignmentTable.fnGetNodes().length) {
                $(".chckHeadPreAssgn").prop("checked", true);
            } else {
                $(".chckHeadPreAssgn").removeAttr("checked");
                $(".chckHeadPreAssgn").prop("checked", false);
            }
        }
        $('#txtPreAssDuration').keypress(function (event) {
            if ((event.which != 46 || $(this).val().indexOf('.') != -1) &&
                ((event.which < 48 || event.which > 57) &&
                    (event.which != 0 && event.which != 8))) {
                event.preventDefault();
            }

            var text = $(this).val();

            if ((text.indexOf('.') != -1) &&
                (text.substring(text.indexOf('.')).length > 2) &&
                (event.which != 0 && event.which != 8) &&
                ($(this)[0].selectionStart >= text.length - 2)) {
                event.preventDefault();
            }
        });


        var selectedSkillId = [];
        $(".chckskill").change(function () {
            var allPages = skillTable.fnGetNodes();
            var checked = $(this).is(':checked');
            if (checked) {
                $('input[type="checkbox"]', allPages).prop('checked', true);
                var rows = $("#emsubtabSkillTbl").dataTable().fnGetNodes();
                for (var i = 0; i < rows.length; i++) {
                    selectedSkillId.push(parseInt($(rows[i]).find("#hdnrm_EmployeeSkillID").val()));
                }

            } else {
                $('input[type="checkbox"]', allPages).prop('checked', false);
                selectedSkillId = [];
            }
        });
        function checkUncheckforSkill() {
            if (skillTable.$('input:checked').length == skillTable.fnGetNodes().length) {
                $(".chckskill").prop("checked", true);
            } else {
                $(".chckskill").removeAttr("checked");
                $(".chckskill").prop("checked", false);
            }
        }
        $(".openupload").on('click', function () {
            $(".file-upload").click();
        });

        $(".file-upload").on('change', function () {
            //$(".profile-pic").attr("src", "../../../Whizible2.0-new/dist/img/blankprofile.png");
            var input = this;
            var src = $("#hiddenProfilePath").val();
            if (input.files && input.files[0]) {
                var extension = $(".file-upload").val().split('.').pop().toUpperCase();
                if (Math.round(input.files[0].size / (1024 * 1024)) > 1) { // make it in MB so divide by 1024*1024
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Image should not be greater than 1 mb");
                    $('.file-upload').val(null);
                    if (src != "" || src != undefined)
                        $(".profile-pic").attr("src", src);
                    else
                        $(".profile-pic").attr("src", "../../../Whizible2.0-new/dist/img/blankprofile.png");

                    return false;
                } else if (extension != "PNG" && extension != "JPG" && extension != "JPEG") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Image can be .PNG/.JPG/.JPEG");
                    $('.file-upload').val(null);
                    if (src != "" || src != undefined)
                        $(".profile-pic").attr("src", src);
                    else
                        $(".profile-pic").attr("src", "../../../Whizible2.0-new/dist/img/blankprofile.png");

                }
                else {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('.profile-pic').attr('src', e.target.result);
                    }

                    reader.readAsDataURL(input.files[0]);
                }
            }
        });
        document.getElementById('plabelName').innerHTML = "Attach file or drop here :-";
        var CurrentTabObject = { Details: 'false', Certification: 'false', PreviousAssignment: 'false', PreviousWorkExperience: 'false', VisaDetails: 'false', Cost: 'false', History: 'false', Qualification: 'false', Skill: 'false', Groups: 'false', CurrentAssignment: 'false' };
        //Added By Rutuja D. on 29 July 2021
        var GlobalHasCoreCompetency = "";
        var GlobalCoreToolId = "";
        //End of Added By Rutuja D. on 29 July 2021


        $(document).ready(function () {

            //Added By Rehan C for Special Character Validation on 17th Jan 2023
            $('#txtRatePerHr,#txtCostPerHr,#txtCostToCompany,#txtActualScore,#txtTotalScore,#txtMECostPerHour,#txtPercentage,#txtPreAssDuration,#txtTeamSize').bind("cut copy paste", function (e) {
                e.preventDefault();
            });
            //End Of Comment By Rehan C           
            CurrentTabObject = { Details: 'false', Certification: 'false', PreviousAssignment: 'false', PreviousWorkExperience: 'false', VisaDetails: 'false', Cost: 'false', History: 'false', Qualification: 'false', Skill: 'false', Groups: 'false', CurrentAssignment: 'false' };
            FillBG(0);
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            Array.prototype.remove = function () {
                var what, a = arguments, L = a.length, ax;
                while (L && this.length) {
                    what = a[--L];
                    while ((ax = this.indexOf(what)) !== -1) {
                        this.splice(ax, 1);
                    }
                }
                return this;
            };


            //if (blnAddAccess == "False") {
            //     DisableEnableBtn(1)                
            //}
            //else {
            //     DisableEnableBtn(0)
            //}
            //if (blnDeleteAccess == "False") {
            //    $("#DeleteCertModal").addClass("clsShowHide");
            //    $("#DeleteCostModal").addClass("clsShowHide");
            //    $("#DeleteVisaModal").addClass("clsShowHide");
            //    $("#DeleteQualiModal").addClass("clsShowHide");
            //    $("#DeleteGroupModal").addClass("clsShowHide");
            //    $("#DeleteWorkExpModal").addClass("clsShowHide");
            //    $("#DeletePrevAssModal").addClass("clsShowHide");
            //    $("#DeleteSkillModal").addClass("clsShowHide");

            //}
            //else {
            //    $("#DeleteCertModal").removeClass("clsShowHide");
            //    $("#DeleteCostModal").removeClass("clsShowHide");
            //    $("#DeleteVisaModal").removeClass("clsShowHide");
            //    $("#DeleteQualiModal").removeClass("clsShowHide");
            //    $("#DeleteGroupModal").removeClass("clsShowHide");
            //    $("#DeleteWorkExpModal").removeClass("clsShowHide");
            //    $("#DeletePrevAssModal").removeClass("clsShowHide");
            //    $("#DeleteSkillModal").removeClass("clsShowHide");
            //}
            FillOURSFilter(0);
            FillDURSFilter(0);
            FillDTRSFilter(0);
            // Added by Dipali V on 6th May 2026 for vendor management - load active vendors for new employee by default
            FillVendorDropdown(0, 0);

            if (blnViewAccess == "True") {
                GetMaximumItemsToShowInList();
                GetMyVTFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);
                } else {
                    GetAllEmployeeList(null);
                    FilterNotApplied();
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
            //Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
            BindPlaceholder("txtEmpFilterGender", "Gender");
            BindPlaceholder("txtEmpFilterBloodGroup", "Blood Group");
            BindPlaceholder("txtEmpFilterPostID", "Role");
            BindPlaceholder("txtEmpFilterDesignationID", "Designation");
            BindPlaceholder("txtEmpFilterDepartmentID", "Department/Unit");
            // Added by Dipali V on 6th May 2026 for vendor management - Vendor filter placeholder
            BindPlaceholder("txtEmpFilterVendorID", "Vendor");
            BindPlaceholder("txtEmpFilterEmployeeType", "Employee Type");
            BindPlaceholder("txtEmpFilterReportingTo", "Reporting To");
            BindPlaceholder("txtEmpFilterCurrencyID", "Currency");
            BindPlaceholder("txtEmpFilterBusinessGroupID", "Business Group");
            BindPlaceholder("txtEmpFilterFacilityID", "Facility");
            BindPlaceholder("txtEmpFilterGradeID", "Grade");
            BindPlaceholder("txtEmpFilterCommunicationID", "Instant Messenger Ids");
            //End of Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
            //Added By Reshma Chavan on 7th Oct 2021 For sub tabs placehoder
            BindPlaceholder("cboVisaType", "Visa Type");
            BindPlaceholder("cboQualificationID", "Qualification");
            BindPlaceholder("cboPassoutYear", "Passout Year");
            BindPlaceholder("cboCountry", "Country");
            BindPlaceholder("currAssignProjectAsscee", "Project Access");
            BindPlaceholder("cboRole", "Role");
            BindPlaceholder("cboDepartmentUnit", "Department/Unit");
            //BindPlaceholder("cboCurrency", "Currency");//Commented By Reshma Chavan on 6th Dec 2021
            BindPlaceholder("cboBloodGroup", "Blood Group");
            BindPlaceholder("cboGender", "Gender");
            BindPlaceholder("cboDeployable", "Deployable");
            BindPlaceholder("cboFacility", "Facility");
            BindPlaceholder("cboReportingTo", "Reporting To");
            // Added by Dipali V on 6th May 2026 for vendor management - Vendor field placeholder
            BindPlaceholder("cboVendor", "Vendor");
            BindPlaceholder("cboEmployeeType", "Employee Type");
            BindPlaceholder("cboDesignation", "Designation");
            BindPlaceholder("cboGrade", "Grade");
            BindPlaceholder("txtCertificationID", "Certification Name");
            BindPlaceholder("txtFILTERCertificationID", "Certification Name");




            //End of Added By Reshma Chavan on 7th Oct 2021 For sub tabs placehoder





        });

        //Added By Dipali V On 2nd Dec 2021 For Restirct alphabeticals
        //To Restrict Alphabets   
        function restrictAlphabets(e) {
            //debugger;

            var x = e.which || e.keycode;

            if ((x >= 48 && x <= 57) || x == 8 ||
                (x >= 35 && x <= 40) || x == 46)
                return true;
            else
                return false;
        }
        //End of Added By Dipali V On 2nd Dec 2021 For Restirct alphabeticals

        function DisableEnableBtn(isTrue) {

            if (isTrue == '1') {
                $("#AddCert").addClass("clsShowHide");
                $('#btnSaveCert').attr("disabled", true);
                $('#AddCostModal').addClass("clsShowHide");
                $('#btnSaveCost').attr("disabled", true);
                $("#AddVisaModal").addClass("clsShowHide");
                $('#btnSaveVisaModal').attr("disabled", true);
                $('#addQualiModal').addClass("clsShowHide");
                $('#btnSaveQualification').attr("disabled", true);
                $("#AddGroupModal").addClass("clsShowHide");
                $('#btnsaveEmpGroup').attr("disabled", true);
                $('#AddWorkExpModal').addClass("clsShowHide");
                $('#btnSavePreWork').attr("disabled", true);
                $("#AddPrevAssModal").addClass("clsShowHide");
                $('#btnSavePreAssignment').attr("disabled", true);
                $('#AddSkillModal').addClass("clsShowHide");
                $('#btnSaveSkill').attr("disabled", true);
                $('#btnAddEmployee').addClass("clsShowHide");
                $('#btnSaveAddEmp').addClass("clsShowHide");

            } else {

                $("#AddCert").removeClass("clsShowHide");
                $('#btnSaveCert').attr("disabled", false);
                $('#AddCostModal').removeClass("clsShowHide");
                $('#btnSaveCost').attr("disabled", false);
                $("#AddVisaModal").removeClass("clsShowHide");
                $('#btnSaveVisaModal').attr("disabled", false);
                $('#addQualiModal').removeClass("clsShowHide");
                $('#btnSaveQualification').attr("disabled", false);
                $("#AddGroupModal").removeClass("clsShowHide");
                $('#btnsaveEmpGroup').attr("disabled", false);
                $('#AddWorkExpModal').removeClass("clsShowHide");
                $('#btnSavePreWork').attr("disabled", false);
                $("#AddPrevAssModal").removeClass("clsShowHide");
                $('#btnSavePreAssignment').attr("disabled", false);
                $('#AddSkillModal').removeClass("clsShowHide");
                $('#btnSaveSkill').attr("disabled", false);
                $('#btnAddEmployee').removeClass("clsShowHide");
                $('#btnSaveAddEmp').removeClass("clsShowHide");
            }

        }
        function AvoidSpace(input) {
            if (/^\s/.test(input.value))
                input.value = '';
        }
        function FillOURSFilter(value) {
            //Added by imran on 24-08-2022
            if (value == "") {
                value = 0;
            }
            //End of comment by imran on 24-08-2022
            var objBGCODE = { BusinessGroupID: value }
            var strHTML = "";
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetOrgUnitForFilter',
                type: "POST",
                data: JSON.stringify(objBGCODE),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objBGCODE) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objBGCODE) ? objBGCODE : JSON.stringify(objBGCODE)));
                    }
                },
                success: function (data) {
                    //strHTML += "<option value='0'></option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    }
                    $("#txtEmpFilterLocationID").html(strHTML);
                    BindPlaceholder("txtEmpFilterLocationID", "Organization Unit");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })

        }
        function FillDURSFilter(value, param) {
            var strHTML = "";
            //added by imran on 24-08-2022
            if (value == "") {
                value = 0;
            }
            //End of comment by imran on 24-08-2022
            var objLocationID = { LocationID: value }
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetResourcePoolForLocation',
                type: "POST",
                data: JSON.stringify(objLocationID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objLocationID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objLocationID) ? objLocationID : JSON.stringify(objLocationID)));
                    }
                },
                success: function (data) {
                    //strHTML += "<option value='0'></option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.ResourcePoolID + ' >' + listComponent.ResourcePoolName + '</option>');
                    }
                    $("#txtEmpFilterResourcePoolID").html(strHTML);
                    BindPlaceholder("txtEmpFilterResourcePoolID", "Delivery Unit");
                    if (param != null && param > 0 && param != undefined) {
                    }


                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })

        }
        function FillDTRSFilter(value, param) {
            var strHTML = "";
            //added by imran on 24-08-2022
            if (value == "") {
                value = 0;
            }
            //End of comment by imran on 24-08-2022
            var objDTLocationID = { LocationID: value }
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetDeliveryTeam',
                type: "POST",
                data: JSON.stringify(objDTLocationID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objDTLocationID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objDTLocationID) ? objDTLocationID : JSON.stringify(objDTLocationID)));
                    }
                },
                success: function (data) {
                    //strHTML += "<option value='0'></option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];

                        strHTML += ('<option value=' + listComponent.GroupID + ' >' + listComponent.GroupName + '</option>');
                    }
                    $("#txtEmpFilterGroupID").html(strHTML);
                    BindPlaceholder("txtEmpFilterGroupID", "Delivery Team");
                    if (param != null && param > 0 && param != undefined) {
                        //$("#cboDT").val(param);
                    }

                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })

        }
        function GenerateEmpBasicFilterQuery(module, filterField) {
            try {

                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    var strCHK = $('#chk' + module + 'Filter' + filterField[i]).is(":checked");
                    //alert($("#txt" + module + "Filter" + filterField[i]));
                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();
                    if (filterField[i] == "Deployable") {
                        if (strvalue != "") {
                        strvalue = strvalue == 'Yes' || strvalue == 'yes' ? 'D' : 'N'
                        }
                    }
                    // strvalue = $("#txtBGFilterBgGroupName").val();

                    if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                        //Added By Chetan M on 28 July 2021 For IssueID = 29339
                    strvalue = strvalue.replace(/"/g, '""');
                    //End of Added By Chetan M on 28 July 2021 For IssueID = 29339
                        if (strqtext != "") strqtext += " AND ";
                        if (strOp == "Contains") {

                            strqtext += filterField[i] + " LIKE ";
                            //strqtext += " ''%" + strvalue + "%''";
                            //Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "%' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "%' + strvalue + '%"';
                            }
                            //End of Commented & Added By Rutuja D. on 28 July for Filter issue
                        }
                        else if (strOp == "Ends With") {
                            strqtext += filterField[i] + " LIKE ";
                            // strqtext += " ''%" + strvalue + "''";
                             //Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "%' + strvalue + '"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "%' + strvalue + '"';
                            }
                            //End of Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Exact Word") {
                            strqtext += filterField[i] + " = ";
                            //strqtext += " ''" + strvalue + "''";
                            strqtext += ' "' + strvalue + '"';
                        }
                        else if (strOp == "Not Contains") {
                            strqtext += filterField[i] + " ";
                            //strqtext += " NOT LIKE ''%" + strvalue + "%''";
                            //Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                            //strqtext += ' NOT LIKE "%' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' NOT LIKE "%' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' NOT LIKE "%' + strvalue + '%"';
                            }
                            //End of Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Starts With") {
                            strqtext += filterField[i] + " LIKE ";
                            // strqtext += " ''" + strvalue + "%''";
                             //Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                            //strqtext += ' "' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "' + strvalue + '%"';
                            }
                            //End of Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                        }
                        else {

                            strqtext += filterField[i] + " ";
                            if ($.isNumeric(strvalue) == false) {
                                //  strqtext += strOp + " '" + strvalue + "'";
                                strqtext += strOp + '"' + strvalue + '"';
                            }
                            else {
                                //strqtext += strOp + " " + strvalue + "";
                                strqtext += strOp + ' "' + strvalue + '"';
                            }
                        }
                    }
                    if (strOp == "=" && strCHK == true) {

                        //Added By Rutuja D. on 8 July 2021
                        //Commented And Added By reshma Chavan on 6th Dec 2021 getting page crash
                        //if (strqtext != '' || strqtext != null || strqtext != undefined) {                        
                        //    strqtext += ' AND '
                        //}
                        if (strqtext == "") {

                        }
                        else {
                            strqtext += ' AND '
                        }
                        //End of Commented And Added By reshma Chavan on 6th Dec 2021 getting page crash
                        //End of Added By Rutuja D. on 8 July 2021
                        if (strvalue == "" || strvalue == undefined) {
                            // alert("if");
                            //if (strDesc == null && strDesc == undefined && strqtext == "") {
                            //    //  alert("strdes");
                            strqtext += filterField[i] + " = " + '"' + strCHK + '"';
                            // }
                            //else {
                            //    // alert("sddf");
                            //    strqtext += " AND " + filterField[i] + " ";
                            //    strqtext += " = " + '"' + strCHK + '"';
                            //}

                        }
                        else {
                            //  alert("lastelse");
                            strqtext += filterField[i] + "=" + '"' + strCHK + '"';
                        }
                    }
                    if (strOp == "<>" && strCHK == true) {

                        // debugger;
                        //   alert(strqtext);
                        //Added By Rutuja D. on 8 July 2021
                        if (strqtext != '' || strqtext != null || strqtext != undefined) {
                            strqtext += ' AND '
                        }
                        //End of Added By Rutuja D. on 8 July 2021
                        if (strvalue == "" || strvalue == undefined) {
                            // alert("if");
                            //if (strDesc == null && strDesc == undefined && strqtext == "") {
                            //    // alert("strdes");
                            strqtext += filterField[i] + " <> " + '"' + strCHK + '"';
                            //}
                            //else {
                            //    //  alert("sddf");
                            //    strqtext += " AND " + filterField[i] + " ";
                            //    strqtext += " <> " + '"' + strCHK + '"';
                            //}

                        }
                        else {
                            // alert("lastelse");
                            strqtext += filterField[i] + "<>" + '"' + strCHK + '"';
                        }
                    }
                }

                strqtext = strqtext.replace('Over', '[Over]')
                strqtext = strqtext.replace(/'/g, "''");
                //strqtext = strqtext.replace(/"/g, "''");
                return strqtext;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        function checkFiltervalidationForEMP() {
            var EName = $("#txtEmpFilterEmployeeName").val() == "" ? null : $("#txtEmpFilterEmployeeName").val();
            var ECode = $("#txtEmpFilterEmployeeCode").val() == "" ? null : $("#txtEmpFilterEmployeeCode").val();
            var EUName = $("#txtEmpFilterUserName").val() == "" ? null : $("#txtEmpFilterUserName").val();
            var BDate = $("#txtEmpFilterBirthDate").val() == "" ? null : $("#txtEmpFilterBirthDate").val();
            var Gender = $("#txtEmpFilterGender").val() == "" ? null : $("#txtEmpFilterGender").val();
            var EmailID = $("#txtEmpFilterEmailID").val() == "" ? null : $("#txtEmpFilterEmailID").val();
            var BloodG = $("#txtEmpFilterBloodGroup").val() == "" ? null : $("#txtEmpFilterBloodGroup").val();
            var Address = $("#txtEmpFilterAddress").val() == "" ? null : $("#txtEmpFilterAddress").val();
            var CAddress = $("#txtEmpFilterCurrentAddress").val() == "" ? null : $("#txtEmpFilterCurrentAddress").val();
            var State = $("#txtEmpFilterState").val() == "" ? null : $("#txtEmpFilterState").val();
            var CState = $("#txtEmpFilterCurrentState").val() == "" ? null : $("#txtEmpFilterCurrentState").val();
            var City = $("#txtEmpFilterCity").val() == "" ? null : $("#txtEmpFilterCity").val();
            var CCity = $("#txtEmpFilterCurrentCity").val() == "" ? null : $("#txtEmpFilterCurrentCity").val();
            var CPinCode = $("#txtEmpFilterCurrentPinCode").val() == "" ? null : $("#txtEmpFilterCurrentPinCode").val();
            var CPhone = $("#txtEmpFilterCurrentPhone").val() == "" ? null : $("#txtEmpFilterCurrentPhone").val();
            var Desig = $("#txtEmpFilterDesignationID").val() == "" ? null : $("#txtEmpFilterDesignationID").val();
            var Role = $("#txtEmpFilterPostID").val() == "" ? null : $("#txtEmpFilterPostID").val();
            var Depart = $("#txtEmpFilterDepartmentID").val() == "" ? null : $("#txtEmpFilterDepartmentID").val();
            var JDate = $("#txtEmpFilterJoiningDate").val() == "" ? null : $("#txtEmpFilterJoiningDate").val();
            var BGID = $("#txtEmpFilterBusinessGroupID").val() == "" ? null : $("#txtEmpFilterBusinessGroupID").val();
            var LocID = $("#txtEmpFilterLocationID").val() == "" ? null : $("#txtEmpFilterLocationID").val();
            var DUID = $("#txtEmpFilterResourcePoolID").val() == "" ? null : $("#txtEmpFilterResourcePoolID").val();
            var DTID = $("#txtEmpFilterGroupID").val() == "" ? null : $("#txtEmpFilterGroupID").val();
            // Added by Dipali V on 6th May 2026 for vendor management - Vendor filter validation variable
            var VendorID = $("#txtEmpFilterVendorID").val() == "" ? null : $("#txtEmpFilterVendorID").val();
            var IsLDAPAuth = $("#chkEmpFilterIsLDAPAuthentication").is(":checked");
            var JDate = $("#txtEmpFilterJoiningDate").val() == "" ? null : $("#txtEmpFilterJoiningDate").val();
            var PPNo = $("#txtEmpFilterPassportNumber").val() == "" ? null : $("#txtEmpFilterPassportNumber").val();
            var EType = $("#txtEmpFilterEmployeeType").val() == "" ? null : $("#txtEmpFilterEmployeeType").val(); //Added by Chetan M on 14 July 2021
            var RepoTo = $("#txtEmpFilterReportingTo").val() == "" ? null : $("#txtEmpFilterReportingTo").val(); //Added by Chetan M on 14 July 2021
            var Curr = $("#txtEmpFilterCurrencyID").val() == "" ? null : $("#txtEmpFilterCurrencyID").val(); //Added by Chetan M on 14 July 2021
            var Deploy = $("#txtEmpFilterDeployable").val() == "" ? null : $("#txtEmpFilterDeployable").val(); //Added by Chetan M on 14 July 2021
            var Facility = $("#txtEmpFilterFacilityID").val() == "" ? null : $("#txtEmpFilterFacilityID").val(); //Added by Chetan M on 14 July 2021
            var Grade = $("#txtEmpFilterGradeID").val() == "" ? null : $("#txtEmpFilterGradeID").val(); //Added by Chetan M on 14 July 2021
            var IMId = $("#txtEmpFilterCommunicationID").val() == "" ? null : $("#txtEmpFilterCommunicationID").val(); //Added by Chetan M on 14 July 2021
            var Phone = $("#txtEmpFilterPhone").val() == "" ? null : $("#txtEmpFilterPhone").val(); //Added by Reshma chavan on 6th Dec 2021
            var RatePerHour = $("#txtEmpFilterRatePerHour").val() == "" ? null : $("#txtEmpFilterRatePerHour").val(); //Added by Reshma chavan on 6th Dec 2021
            var CostPerHour = $("#txtEmpFilterCostPerHour").val() == "" ? null : $("#txtEmpFilterCostPerHour").val(); //Added by Reshma chavan on 6th Dec 2021
            var CostToCompany = $("#txtEmpFilterCostToCompany").val() == "" ? null : $("#txtEmpFilterCostToCompany").val(); //Added by Reshma chavan on 6th Dec 2021
            var ExtensionNo = $("#txtEmpFilterExtensionNo").val() == "" ? null : $("#txtEmpFilterExtensionNo").val(); //Added by Reshma chavan on 6th Dec 2021
            var DateOfIssue = $("#txtEmpFilterPP_DateOfIssue").val() == "" ? null : $("#txtEmpFilterPP_DateOfIssue").val(); //Added by Reshma chavan on 6th Dec 2021
            var FullName = $("#txtEmpFilterPP_FullName").val() == "" ? null : $("#txtEmpFilterPP_FullName").val(); //Added by Reshma chavan on 6th Dec 2021
            var MobileNumber = $("#txtEmpFilterMobileNumber").val() == "" ? null : $("#txtEmpFilterMobileNumber").val(); //Added by Reshma chavan on 6th Dec 2021
            var PlaceOfIssue = $("#txtEmpFilterPP_PlaceOfIssue").val() == "" ? null : $("#txtEmpFilterPP_PlaceOfIssue").val(); //Added by Reshma chavan on 6th Dec 2021
            var ExpiryDate = $("#txtEmpFilterPP_ExpiryDate").val() == "" ? null : $("#txtEmpFilterPP_ExpiryDate").val(); //Added by Reshma chavan on 6th Dec 2021
            var RelativeName = $("#txtEmpFilterPP_RelativeName").val() == "" ? null : $("#txtEmpFilterPP_RelativeName").val(); //Added by Reshma chavan on 6th Dec 2021


            if ((EName == null || EName == 'undefined' || EName == " ") && (ECode == null || ECode == 'undefined' || ECode == " ") && (BDate == null || BDate == 'undefined' || BDate == " ") && (EUName == null || EUName == 'undefined' || EUName == " ") && (Gender == null || Gender == 'undefined' || Gender == " " || Gender == 0) && (EmailID == null || EmailID == 'undefined' || EmailID == " ") && (BloodG == null || BloodG == 'undefined' || BloodG == " " || BloodG == 0)
                && (City == null || City == 'undefined' || City == " ") && (CPinCode == null || CPinCode == 'undefined' || CPinCode == " ") && (CPhone == null || CPhone == 'undefined' || CPhone == " ")
                && (JDate == null || JDate == 'undefined' || JDate == " ") && (Desig == null || Desig == 'undefined' || Desig == " " || Desig == 0) && (Role == null || Role == 'undefined' || Role == " " || Role == 0)
                && (Depart == null || Depart == 'undefined' || Depart == " " || Depart == 0) && (VendorID == null || VendorID == 'undefined' || VendorID == " " || VendorID == 0) && (BGID == null || BGID == 'undefined' || BGID == " " || BGID == 0) && (LocID == null || LocID == 'undefined' || LocID == " " || LocID == 0) && (DUID == null || DUID == 'undefined' || DUID == " " || DUID == 0) && (DTID == null || DTID == 'undefined' || DTID == " " || DTID == 0)
                && (Address == null || Address == 'undefined' || Address == " ") && (CAddress == null || CAddress == 'undefined' || CAddress == " ") && (State == null || State == 'undefined' || State == " ") && (CState == null || CState == 'undefined' || CState == " ") && (CCity == null || CCity == 'undefined' || CCity == " ")
                && (IsLDAPAuth == false) && (JDate == null || JDate == 'undefined' || JDate == " ") && (PPNo == null || PPNo == 'undefined' || PPNo == " ")
                //Added by Chetan M on 14 July 2021
                && (EType == null || EType == 'undefined' || RepoTo == " ") && (RepoTo == null || RepoTo == 'undefined' || RepoTo == " ") && (Curr == null || Curr == 'undefined' || Curr == " ") && (Deploy == null || Deploy == 'undefined' || Deploy == " ") && (Facility == null || Facility == 'undefined' || Facility == " ")
                && (Grade == null || Grade == 'undefined' || Grade == " ")
                && (IMId == null || IMId == 'undefined' || IMId == " ")
                //Added by Reshma chavan on 6th Dec 2021
                && (Phone == null || Phone == 'undefined' || Phone == " ")
                && (RatePerHour == null || RatePerHour == 'undefined' || RatePerHour == " ")
                && (CostPerHour == null || CostPerHour == 'undefined' || CostPerHour == " ")
                && (CostToCompany == null || CostToCompany == 'undefined' || CostToCompany == " ")
                && (ExtensionNo == null || ExtensionNo == 'undefined' || ExtensionNo == " ")
                && (DateOfIssue == null || DateOfIssue == 'undefined' || DateOfIssue == " ")
                && (FullName == null || FullName == 'undefined' || FullName == " ")
                && (MobileNumber == null || MobileNumber == 'undefined' || MobileNumber == " ")
                && (PlaceOfIssue == null || PlaceOfIssue == 'undefined' || PlaceOfIssue == " ")
                && (ExpiryDate == null || ExpiryDate == 'undefined' || ExpiryDate == " ")
                && (RelativeName == null || RelativeName == 'undefined' || RelativeName == " ")
                //End of Added by Reshma chavan on 6th Dec 2021
            ) {
                //End of Added by Chetan M on 14 July 2021
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
                $('#Issuesavefilter').modal('hide');
            }
            else {
                $('#Issuesavefilter').modal('show');
            }
        }
        function ApplyFlter() {
            var filterFlag = true;
            var EName = $("#txtEmpFilterEmployeeName").val() == "" ? null : $("#txtEmpFilterEmployeeName").val();
            var ECode = $("#txtEmpFilterEmployeeCode").val() == "" ? null : $("#txtEmpFilterEmployeeCode").val();
            var EUName = $("#txtEmpFilterUserName").val() == "" ? null : $("#txtEmpFilterUserName").val();
            var BDate = $("#txtEmpFilterBirthDate").val() == "" ? null : $("#txtEmpFilterBirthDate").val();
            var Gender = $("#txtEmpFilterGender").val() == "" ? null : $("#txtEmpFilterGender").val();
            var EmailID = $("#txtEmpFilterEmailID").val() == "" ? null : $("#txtEmpFilterEmailID").val();
            var BloodG = $("#txtEmpFilterBloodGroup").val() == "" ? null : $("#txtEmpFilterBloodGroup").val();
            var Address = $("#txtEmpFilterAddress").val() == "" ? null : $("#txtEmpFilterAddress").val();
            var CAddress = $("#txtEmpFilterCurrentAddress").val() == "" ? null : $("#txtEmpFilterCurrentAddress").val();
            var State = $("#txtEmpFilterState").val() == "" ? null : $("#txtEmpFilterState").val();
            var CState = $("#txtEmpFilterCurrentState").val() == "" ? null : $("#txtEmpFilterCurrentState").val();
            var City = $("#txtEmpFilterCity").val() == "" ? null : $("#txtEmpFilterCity").val();
            var CCity = $("#txtEmpFilterCurrentCity").val() == "" ? null : $("#txtEmpFilterCurrentCity").val();
            var CPinCode = $("#txtEmpFilterCurrentPinCode").val() == "" ? null : $("#txtEmpFilterCurrentPinCode").val();
            var CPhone = $("#txtEmpFilterCurrentPhone").val() == "" ? null : $("#txtEmpFilterCurrentPhone").val();
            var Desig = $("#txtEmpFilterDesignationID").val() == "" ? null : $("#txtEmpFilterDesignationID").val();
            var Role = $("#txtEmpFilterPostID").val() == "" ? null : $("#txtEmpFilterPostID").val();
            var Depart = $("#txtEmpFilterDepartmentID").val() == "" ? null : $("#txtEmpFilterDepartmentID").val();
            var JDate = $("#txtEmpFilterJoiningDate").val() == "" ? null : $("#txtEmpFilterJoiningDate").val();
            var BGID = $("#txtEmpFilterBusinessGroupID").val() == "" ? null : $("#txtEmpFilterBusinessGroupID").val();
            var LocID = $("#txtEmpFilterLocationID").val() == "" ? null : $("#txtEmpFilterLocationID").val();
            var DUID = $("#txtEmpFilterResourcePoolID").val() == "" ? null : $("#txtEmpFilterResourcePoolID").val();
            var DTID = $("#txtEmpFilterGroupID").val() == "" ? null : $("#txtEmpFilterGroupID").val();
            // Added by Dipali V on 6th May 2026 for vendor management - Vendor filter apply variable
            var VendorID = $("#txtEmpFilterVendorID").val() == "" ? null : $("#txtEmpFilterVendorID").val();
            var IsLDAPAuth = $("#chkEmpFilterIsLDAPAuthentication").is(":checked");
            var JDate = $("#txtEmpFilterJoiningDate").val() == "" ? null : $("#txtEmpFilterJoiningDate").val();
            var PPNo = $("#txtEmpFilterPassportNumber").val() == "" ? null : $("#txtEmpFilterPassportNumber").val();
            var EType = $("#txtEmpFilterEmployeeType").val() == "" ? null : $("#txtEmpFilterEmployeeType").val(); //Added by Chetan M on 14 July 2021
            var RepoTo = $("#txtEmpFilterReportingTo").val() == "" ? null : $("#txtEmpFilterReportingTo").val(); //Added by Chetan M on 14 July 2021
            var Curr = $("#txtEmpFilterCurrencyID").val() == "" ? null : $("#txtEmpFilterCurrencyID").val(); //Added by Chetan M on 14 July 2021
            var Deploy = $("#txtEmpFilterDeployable").val() == "" ? null : $("#txtEmpFilterDeployable").val(); //Added by Chetan M on 14 July 2021
            var Facility = $("#txtEmpFilterFacilityID").val() == "" ? null : $("#txtEmpFilterFacilityID").val(); //Added by Chetan M on 14 July 2021
            var Grade = $("#txtEmpFilterGradeID").val() == "" ? null : $("#txtEmpFilterGradeID").val(); //Added by Chetan M on 14 July 2021
            var IMId = $("#txtEmpFilterCommunicationID").val() == "" ? null : $("#txtEmpFilterCommunicationID").val(); //Added by Chetan M on 14 July 2021
            var Phone = $("#txtEmpFilterPhone").val() == "" ? null : $("#txtEmpFilterPhone").val(); //Added by Reshma chavan on 6th Dec 2021
            var RatePerHour = $("#txtEmpFilterRatePerHour").val() == "" ? null : $("#txtEmpFilterRatePerHour").val(); //Added by Reshma chavan on 6th Dec 2021
            var CostPerHour = $("#txtEmpFilterCostPerHour").val() == "" ? null : $("#txtEmpFilterCostPerHour").val(); //Added by Reshma chavan on 6th Dec 2021
            var CostToCompany = $("#txtEmpFilterCostToCompany").val() == "" ? null : $("#txtEmpFilterCostToCompany").val(); //Added by Reshma chavan on 6th Dec 2021
            var ExtensionNo = $("#txtEmpFilterExtensionNo").val() == "" ? null : $("#txtEmpFilterExtensionNo").val(); //Added by Reshma chavan on 6th Dec 2021
            var DateOfIssue = $("#txtEmpFilterPP_DateOfIssue").val() == "" ? null : $("#txtEmpFilterPP_DateOfIssue").val(); //Added by Reshma chavan on 6th Dec 2021
            var FullName = $("#txtEmpFilterPP_FullName").val() == "" ? null : $("#txtEmpFilterPP_FullName").val(); //Added by Reshma chavan on 6th Dec 2021
            var MobileNumber = $("#txtEmpFilterMobileNumber").val() == "" ? null : $("#txtEmpFilterMobileNumber").val(); //Added by Reshma chavan on 6th Dec 2021
            var PlaceOfIssue = $("#txtEmpFilterPP_PlaceOfIssue").val() == "" ? null : $("#txtEmpFilterPP_PlaceOfIssue").val(); //Added by Reshma chavan on 6th Dec 2021
            var ExpiryDate = $("#txtEmpFilterPP_ExpiryDate").val() == "" ? null : $("#txtEmpFilterPP_ExpiryDate").val(); //Added by Reshma chavan on 6th Dec 2021
            var RelativeName = $("#txtEmpFilterPP_RelativeName").val() == "" ? null : $("#txtEmpFilterPP_RelativeName").val(); //Added by Reshma chavan on 6th Dec 2021

            if ((EName == null || EName == 'undefined' || EName == " ") && (ECode == null || ECode == 'undefined' || ECode == " ") && (BDate == null || BDate == 'undefined' || BDate == " ") && (EUName == null || EUName == 'undefined' || EUName == " ") && (Gender == null || Gender == 'undefined' || Gender == " " || Gender == 0) && (EmailID == null || EmailID == 'undefined' || EmailID == " ") && (BloodG == null || BloodG == 'undefined' || BloodG == " " || BloodG == 0)
                && (City == null || City == 'undefined' || City == " ") && (CPinCode == null || CPinCode == 'undefined' || CPinCode == " ") && (CPhone == null || CPhone == 'undefined' || CPhone == " ")
                && (JDate == null || JDate == 'undefined' || JDate == " ") && (Desig == null || Desig == 'undefined' || Desig == " " || Desig == 0) && (Role == null || Role == 'undefined' || Role == " " || Role == 0)
                && (Depart == null || Depart == 'undefined' || Depart == " " || Depart == 0) && (VendorID == null || VendorID == 'undefined' || VendorID == " " || VendorID == 0) && (BGID == null || BGID == 'undefined' || BGID == " " || BGID == 0) && (LocID == null || LocID == 'undefined' || LocID == " " || LocID == 0) && (DUID == null || DUID == 'undefined' || DUID == " " || DUID == 0) && (DTID == null || DTID == 'undefined' || DTID == " " || DTID == 0)
                && (Address == null || Address == 'undefined' || Address == " ") && (CAddress == null || CAddress == 'undefined' || CAddress == " ") && (State == null || State == 'undefined' || State == " ") && (CState == null || CState == 'undefined' || CState == " ") && (CCity == null || CCity == 'undefined' || CCity == " ")
                && (IsLDAPAuth == false) && (JDate == null || JDate == 'undefined' || JDate == " ") && (PPNo == null || PPNo == 'undefined' || PPNo == " ")
                //Added by Chetan M on 14 July 2021
                && (EType == null || EType == 'undefined' || RepoTo == " ") && (RepoTo == null || RepoTo == 'undefined' || RepoTo == " ") && (Curr == null || Curr == 'undefined' || Curr == " ") && (Deploy == null || Deploy == 'undefined' || Deploy == " ") && (Facility == null || Facility == 'undefined' || Facility == " ")
                && (Grade == null || Grade == 'undefined' || Grade == " ")
                && (IMId == null || IMId == 'undefined' || IMId == " ")
                //Added by Reshma chavan on 6th Dec 2021
                && (Phone == null || Phone == 'undefined' || Phone == " ")
                && (RatePerHour == null || RatePerHour == 'undefined' || RatePerHour == " ")
                && (CostPerHour == null || CostPerHour == 'undefined' || CostPerHour == " ")
                && (CostToCompany == null || CostToCompany == 'undefined' || CostToCompany == " ")
                && (ExtensionNo == null || ExtensionNo == 'undefined' || ExtensionNo == " ")
                && (DateOfIssue == null || DateOfIssue == 'undefined' || DateOfIssue == " ")
                && (FullName == null || FullName == 'undefined' || FullName == " ")
                && (MobileNumber == null || MobileNumber == 'undefined' || MobileNumber == " ")
                && (PlaceOfIssue == null || PlaceOfIssue == 'undefined' || PlaceOfIssue == " ")
                && (ExpiryDate == null || ExpiryDate == 'undefined' || ExpiryDate == " ")
                && (RelativeName == null || RelativeName == 'undefined' || RelativeName == " ")
                //End of Added by Reshma chavan on 6th Dec 2021
            ) {
                //End of Added by Chetan M on 14 July 2021
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                filterFlag = false;
                return false;
            }
            if (filterFlag == true) {
                currentFilterID = 0;
                var filter = "";
                // Added by Dipali V on 6th May 2026 for vendor management - include VendorID in Employee list filter query
                var AllEmpFilter = ["EmployeeName", "EmployeeCode", "UserName", "BirthDate", "Gender", "EmailID", "BloodGroup", "Address", "CurrentAddress", "City", "CurrentCity", "State", "CurrentState", "PinCode", "CurrentPinCode", "Phone", "CurrentPhone", "PostID", "DesignationID", "DepartmentID", "VendorID", "EmployeeType", "ReportingTo", "JoiningDate", "RatePerHour", "CostPerHour", "CostToCompany", "CurrencyID", "FacilityID", "ExtensionNo", "MobileNumber", "CommunicationID", "GradeID", "PassportNumber", "PP_DateOfIssue", "PP_PlaceOfIssue", "PP_ExpiryDate", "PP_RelativeName", "BusinessGroupID", "LocationID", "ResourcePoolID", "GroupID", "IsLDAPAuthentication", "Deployable"];
                var filterWhereClause2 = GenerateEmpBasicFilterQuery("Emp", AllEmpFilter);
                var filterWhereClause = (filterWhereClause2).replace(/"/g, "\'");
                filter = { EmpWhereClause: encodeURIComponent(filterWhereClause) }
                FilterApplied();
                GetAllEmployeeList(filter);
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");
                //Added by imran on 24-08-2022
                $(".filter").removeClass("active");
                //Commented and Modified By RehanC for filter section not getting hide on 7th April 2023
                //if ($('.filterpanel').hasClass("in")) {
                //    $('.filterpanel').removeClass("in");
                //}
                if ($('.filterpanel').hasClass("show")) {
                    $('.filterpanel').removeClass("show");
                }
                //End of Modification By RehanC on 7th April 2023
                //End of comment y imran on 24-08-2022
            }
        }

        function GetEmpDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                // var whereClauseFormated = whereClause.replace(/'/g, "\''");
                filter = { EmpWhereClause: encodeURIComponent(whereClause) };
            }
            GetAllEmployeeList(filter);
        }
        var savedFilterName = "";
        function SaveVTFilterDetails() {
            //alert("HJHJDF");
            var fltFilterName = $("#txtVTFilterName").val();
            //debugger;
            //$('#BgSavefilter').modal('show');
            // $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            if (fltFilterName == "" || fltFilterName == " ") {
                //$('#BgSavefilter').modal('show');
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name');
                //$('#BgSavefilter').modal('show')

                $("#txtVTFilterName").focus();

                //return false
            }
            //Commented and Added By Riddhesh Patil on 12-NOV-2022 
            //else if ($("#txtVTFilterName").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtVTFilterName").focus();
            //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Filtername cannot contain any of these /\:*?<>|,"+- characters.');
            //}
            else if (checkSpecialCharacter(fltFilterName.trim(), WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtVTFilterName").focus();

            }
			//End of Comment and Added By Riddhesh Patil
            else {
                var filterExists = 0;
                //if (savedFilterName == "") {
                //    filterExists = ExistVTFilter(fltFilterName);
                //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                //    $('#VisaTpeSavefilter').modal('show');
                //}

                //if (filterExists == 0) {
                //    $("#btnSaveFilter").attr("data-bs-dismiss", "modal");
                // Added by Dipali V on 6th May 2026 for vendor management - persist VendorID in saved Employee filter
                var AllEmpFilter = ["EmployeeName", "EmployeeCode", "UserName", "BirthDate", "Gender", "EmailID", "BloodGroup", "Address", "CurrentAddress", "City", "CurrentCity", "State", "CurrentState", "PinCode", "CurrentPinCode", "Phone", "CurrentPhone", "PostID", "DesignationID", "DepartmentID", "VendorID", "EmployeeType", "ReportingTo", "JoiningDate", "RatePerHour", "CostPerHour", "CostToCompany", "CurrencyID", "FacilityID", "ExtensionNo", "MobileNumber", "CommunicationID", "GradeID", "PassportNumber", "PP_DateOfIssue", "PP_PlaceOfIssue", "PP_ExpiryDate", "PP_RelativeName", "BusinessGroupID", "LocationID", "ResourcePoolID", "GroupID", "IsLDAPAuthentication","Deployable"];
                //var isActiveFilter = 'True';/// $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GenerateEmpBasicFilterQuery("Emp", AllEmpFilter);
                // var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
                //filterWhereClause2 += "AND Active=" + ' "' + isActiveFilter + '"';
                filterWhereClause = filterWhereClause2.replace(/"/g, "\'");

                var paramFilterID = 0;
                paramFilterID = currentFilterID;

                //if (currentFilterID != 0) {
                //    if (fltFilterName != savedFilterName) {
                //        paramFilterID = 0;
                //    }
                //}

                var paramFlag = 0;
                if (paramFilterID == 0) {
                    paramFlag = 0;
                }
                else {
                    paramFlag = 1;
                }

                var Parameters = {
                    TagID: encodeURI(TagID),
                    ProjectID: 0,
                    EmployeeID: encodeURI(SessionEmployeeId),
                    FilterName: encodeURI(fltFilterName),
                    LoginType: encodeURI(SessionLoginType),
                    CreatedBy: encodeURI(UserName),
                    WhereClause: encodeURIComponent(filterWhereClause),
                    Flag: encodeURI(paramFlag),
                    FilterID: encodeURI(paramFilterID)
                }

                $.ajax({
                    url: encodeURI(strUrl) + '/api/RM_MyFilter/SaveMyFilter',

                    method: 'Post',
                    data: JSON.stringify(Parameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json",  /*;charset-utf=8*/
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    success: function (data) {

                        if (data == "Filter name already exist") {
                            // alert(1);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                            // $('#OuSavefilter').modal('show');
                            // currentFilterID = 0;
                        }
                        else {
                            if (data != undefined && data != "") {
                                currentFilterID = data;
                                currentappliedfilter = currentFilterID;
                            }
                            $('#VisaTpeSavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            $('#Issuesavefilter').modal('hide');    //Added By RehanC for filter popup hide issue on 4th April 2023
                            GetMyVTFilter(0);
                            ApplyFlter();
                            FilterApplied();

                            savedFilterName = fltFilterName;
                            $("#txtVTFilterName").val('');
                            //clearTooltip();
                            // ClearFilterDetails("");
                            <%--Added by imran on 18-08-2022--%>
                            $('#OuSavefilter').modal('hide');
                            $(".filter").removeClass("active");
                            //Commented and Modified By RehanC for filter section not getting hide on 7th April 2023
                            //if ($('.filterpanel').hasClass("in")) {
                            //    $('.filterpanel').removeClass("in");
                            //}
                            //End of Modification By RehanC on 7th April 2023
                            if ($('.filterpanel').hasClass("show")) {
                                $('.filterpanel').removeClass("show");
                            }
                            <%--End of Comment by imran on 18-08-2022--%>
                        }


                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (xhr, errorThrown) {
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    //},
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                });
                // }
            }
        }

        function GetMyVTFilter(flag) {
            var Parameters = {
                ProjectID: 0,
                TagID: encodeURI(TagID),
                LoginType: encodeURI(SessionLoginType),
                EmployeeID: encodeURI(SessionEmployeeId)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/RM_MyFilter/GetMyFilters',
                method: 'POST',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {
                    var strHTML = "";
                    var defaultFilterId = 0;
                    $("#MyFiltersdropdown").empty();
                    if ($("#MyFiltersdropdown").hasClass("dropdown-menu")) {

                    }
                    else {
                        $("#MyFiltersdropdown").addClass("dropdown-menu");
                    }

                    if (data.length != 0) {

                        for (var i = 0; i < data.length; i++) {
                            var ObjMyFilter = data[i];
                            strHTML += "<li>";
                            if (ObjMyFilter.SetDefault === true) {
                                defaultFilterId = ObjMyFilter.FilterId;
                                currentDefaultFilterID = defaultFilterId;

                                strHTML += "<label class='customradio'>";

                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-bs-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='radio' name='project2' onclick='SetDefaultFilter(this.id,&quot;default&quot;)' checked='checked'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-bs-placement='right' title='Remove Default filter' class='checkmark'></span>";
                                strHTML += "</label>";

                            }
                            else {
                                strHTML += "<label class='customradio'>";
                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-bs-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='radio' name='project2' onclick='SetDefaultFilter(this.id,&quot;&quot;)'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-bs-placement='right' title='Set Default filter' class='checkmark'></span>";
                                strHTML += "</label>";
                            }

                            strHTML += "<label class=''>";
                            strHTML += "<span for='project2' class='radiotextsty filtername'>" + ObjMyFilter.FilterName + "</span>";
                            strHTML += "</label>";

                            strHTML += "<div class='custom_chckbox_markblue'>";

                            var blnApply = false;
                            if (currentappliedfilter != 0 && flag != 3) {
                                if (currentappliedfilter == ObjMyFilter.FilterId) {
                                    blnApply = true;
                                }
                            }

                            if (ObjMyFilter.SetDefault == "True") {
                                strHTML += "<div class='custom_chckbox_markblue'>";

                                if (currentappliedfilter != 0 && flag != 3) {
                                    if (blnApply == true) {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                    }
                                    else {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                    }
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }

                                strHTML += "</div>";
                            }
                            else {
                                strHTML += "<div class='custom_chckbox_markblue'>";
                                if (blnApply == true) {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }
                            }

                            strHTML += "<span onclick='OpenBasicFilter()' class='edit_filter'>";

                            strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Edit filter' id='" + ObjMyFilter.FilterId + "' class='fas fa-pencil-alt' onclick='EditFilter(this.id);'></i>";

                            strHTML += "</span>";

                            strHTML += "<span>";
                            if (blnApply == true) {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id,3);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3);'></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                            }
                            else {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;);></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                            }

                            strHTML += "</span>";

                            strHTML += "</div>";

                            strHTML += "</li>";

                        }

                        $("#MyFiltersdropdown").html(strHTML);
                        if (strHTML != "" && defaultFilterId != 0 && flag != 0 && flag != 3) {
                            ApplySavedFilter(defaultFilterId, 1);
                        }
                        //else {
                        //    GetBusinessGroups(null);
                        //}

                        $("#MyFiltersdropdown").removeClass("clsShowHide");
                    }
                    else {
                        $("#MyFiltersdropdown").addClass("clsShowHide");
                        $("#MyFiltersdropdown").removeClass("dropdown-menu");
                    }
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (xhr, errorThrown) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                //},
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                },
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
            clearTooltip();
        }

        function ExistVTFilter(filtername) {

            var isFilterExists = 0;
            var Parameters = {
                FilterName: encodeURI(filtername),
                TagID: encodeURI(TagID),
                ProjectID: 0,
                EmployeeID: encodeURI(SessionEmployeeId),
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/RM_MyFilter/ExistMyFilter',
                method: 'POST',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {

                    if (data == 0) {
                        isFilterExists = 0;
                    }
                    else if (data == 1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Filter already exit");
                        isFilterExists = 1;
                    }
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (xhr, errorThrown) {
                //    isFilterExists = 1;
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                //},
                error: function (xhr, ajaxOptions, thrownError) {
                    isFilterExists = 1;
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                },
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
            return isFilterExists;
        }

        //Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on 6 July 2021
        // function DeleteFilter(FilterID, IsApplyed) {
        function DeleteFilter(FilterID, FilterName, IsApplyed) {
            //End of Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on on 6 July 2021
            $.ajax({
                url: strUrl + '/api/RM_MyFilter/DeleteMyFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {
                    if (result == null) {
                        alertify.set('notifier', 'position', 'top-right');
                        //Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on 6 July 2021
                        //alertify.success('Filter deleted successfully');
                        if (FilterName.indexOf("'") > -1) {
                            FilterName = FilterName.replace(/''/g, "'");
                        }
                        alertify.success("'" + FilterName + "'" + ' Filter deleted successfully');
                        //End of Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on 6 July 2021
                        if (IsApplyed == 3) {
                            //var GetBGWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                            GetEmpDetails();
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyVTFilter(0);
                        currentappliedfilter = 0;
                    }
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
        }
        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtVTFilterName').val("");
            }

        }
        function EditFilter(FilterID) {
            //Added by imran on 25-08-2022
            $('#basicfilters').addClass('active');
            //End of comment by imran on 25-08-2022

            savedFilterName = "";
            ClearFilterDetails("edit");
            $.ajax({
                url: strUrl + '/api/RM_MyFilter/EditMyFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {

                    for (var i = 0; i < result.length; i++) {
                        var ObjFilterDtls = result[i];

                        var currentFilterName = ObjFilterDtls.FilterName;
                        currentFilterID = ObjFilterDtls.FilterId;
                        $("#txtVTFilterName").val(currentFilterName);
                        savedFilterName = currentFilterName;
                        if (ObjFilterDtls.QueryText.toString().indexOf("AND") != -1) {

                            var arrFields = ObjFilterDtls.QueryText.split("AND");
                            try {
                                for (var i = 0; i < arrFields.length; i++) {
                                    setfiltervalues(arrFields[i]);
                                }
                            }
                            catch (ex) {
                                //alert(ex.message);
                            }
                        }
                        else {
                            var currWhereClause = ObjFilterDtls.QueryText.toString();
                            setfiltervalues(currWhereClause);
                        }//else                        
                    }
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
        }
        function ApplySavedFilter(FilterID, isDefault, isFromDefault) {
            //Changed  by imran by Filter Issue on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }

            if (isDefault == 3) {
                //var GetBGWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                GetEmpDetails();
                GetMyVTFilter(isDefault);
                FilterNotApplied();
                ClearFilterDetails(""); // Added By Reshma Chavan on 31st Jan 2022 for clearing filter
                $('#AdvanceFilterIcon').attr("aria-expanded", false);
                //added by imran on 21 july 2021
                if ((isFromDefault === false || isFromDefault == 'false') && (isDefault == 3)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Filter removed successfully.");
                }
            }
            if (isDefault == undefined || isDefault == 2) {
                currentappliedfilter = FilterID;
                $.ajax({
                    url: strUrl + '/api/RM_MyFilter/GetMyWhereClauseOfFilter',
                    method: 'POST',
                    data: JSON.stringify(FilterID),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (FilterID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                        }
                    },
                    success: function (result) {
                        $(".filter").removeClass("active");
                        //Commented and Modified By RehanC for filter section not getting hide on 7th April 2023
                        //if ($('.filterpanel').hasClass("in")) {
                        //    $('.filterpanel').removeClass("in");
                        //}
                        //End of Modification By RehanC on 7th April 2023
                        if ($('.filterpanel').hasClass("show")) {
                            $('.filterpanel').removeClass("show");
                        }
                        var Querytext = result;
                        if (Querytext != null) {
                            currentappliedfilterclause = Querytext;
                            GetEmpDetails(Querytext);
                        }
                        //Added By Reshma Chavan on 31st Jan 2022 for NOT displalying data after apply filter
                        if (Querytext.toString().indexOf("AND") != -1) {
                            var arrFields = Querytext.split("AND");
                            try {
                                for (var i = 0; i < arrFields.length; i++) {
                                    setfiltervalues(arrFields[i]);
                                }
                            }
                            catch (ex) {
                                //alert(ex.message);
                            }
                        }
                        else {
                            var currWhereClause = Querytext.toString();
                            setfiltervalues(currWhereClause);
                        }
                        //End of Added By Reshma Chavan on 31st jan 2022 for NOT displalying data after apply filter
                        FilterApplied();
                        //GetBGDetails(Querytext);
                        // call business group getRiskDetails(currentselectedProjectID, 0, "", "defaultfilterapply", Querytext);
                        if (currentDefaultFilterID > 0) {
                            FilterApplied();
                        }
                        if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                            GetMyVTFilter(0);
                        }
                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                });
                if (isDefault == undefined) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Filter applied successfully.");
                    //Commented and Modified By RehanC for filter section not getting hide on 7th April 2023
                    //$(".filter").removeClass("active");
                    //if ($('.filterpanel').hasClass("in")) {
                    //    $('.filterpanel').removeClass("in");
                    //}
                    $(".filter").removeClass("active");
                    if ($('.filterpanel').hasClass("show")) {
                    $('.filterpanel').removeClass("show");
                    }
                    //End of Modification By RehanC on 7th April 2023
                }
            }
        }

        //To set the default filter.
        function SetDefaultFilter(FilterID, flag) {
            var removeDefault = 0;
            if (flag == "default") {
                removeDefault = 1;
            }
            var Parameters = {
                ProjectID: 0,
                LoginType: encodeURI(SessionLoginType),
                EmployeeID: encodeURI(SessionEmployeeId),
                TagID: encodeURI(TagID),
                FilterID: FilterID,
                Flag: removeDefault
            }

            $.ajax({
                url: strUrl + '/api/RM_MyFilter/SetMyDefaultFilter',
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (result) {
                    alertify.set('notifier', 'position', 'top-right');
                    //alert(removeDefault);
                    if (removeDefault == 0) {
                        //alertify.success('Success');
                        //ApplySavedFilter(FilterID, 2);
                        ApplySavedFilter(FilterID, 2, true);
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        //alertify.success('Default');
                        //FilterNotApplied();
                        ApplySavedFilter(FilterID, 3, true);
                        alertify.success('Default Filter Is Successfully Removed!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        currentappliedfilter = 0;
                        FilterNotApplied();
                    }
                    GetMyVTFilter(0);
                    $(".filter").removeClass("active");
                    if ($('.filterpanel').hasClass("show")) {
                        $('.filterpanel').removeClass("show");
                    }
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
        }

        function OpenBasicFilter() {
            //Start Script for edit basic filter           
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
            //End Script for edit basic filter
        }
        $(".mainclearalllink").click(function () {
            $(".filter").removeClass("active");
            //$('.filterpanel').collapse('toggle');                

            FilterNotApplied();
            $(".filter").removeClass("active");
            //Commented and Modified By RehanC for filter section not getting hide on 7th April 2023
            //if ($('.filterpanel').hasClass("in")) {
            //    $('.filterpanel').removeClass("in");
            //}
            //End of Comment By RehanC on 7th April 2023
            if ($('.filterpanel').hasClass("show")) {
                $('.filterpanel').removeClass("show");
            }
            $(".clsHideTooltip").each(function () {
                $(this).attr("data-bs-original-title", "Apply filter");
            });
            $('[data-bs-toggle="tooltip"]').tooltip();

            fltPersonResponsible = "";
            currentappliedfilter = 0;
            currentFilterID = 0;
            currentappliedfilterclause = "";
            ClearFilterDetails("");
            //Added by imran
            GetMyVTFilter(0);
            //End by imran

            GetEmpDetails(null);
        });
        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
               // $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
        }

        function FilterApplied() {
            $(".mainclearalllink").removeClass("clsShowHide");
            $(".filter >  button").addClass("clsFilterHighlight");
        }

        function FilterNotApplied() {
            $(".mainclearalllink").addClass("clsShowHide");
            $(".filter >  button").removeClass("clsFilterHighlight");
            $('#AdvanceFilterIcon').attr("aria-expanded", false);
        }

        function BindBasicFilters(qtext, module) {
            ClearBasicFilter(module);
            var isAnd = qtext.indexOf(' AND ');
            if (isAnd > 0) {
                var rowsAnd = qtext.split(' AND ');
                for (i = 0; i < rowsAnd.length; i++) {
                    BindBasicFilterValues(rowsAnd[i], module);
                }
            }
            else {
                BindBasicFilterValues(qtext, module);
            }
        }

        function BindBasicFilterValues(qtext, module) {
            //debugger
            var field = qtext.substr(0, qtext.indexOf(' '));
            var op = orgop = "";
            var val = valstr = "";

            var opstr = qtext.substr(qtext.indexOf(' '), qtext.length).trim();
            var opchar = opstr.substr(0, 1);
            if (opchar == "N" || opchar == "L") {
                if (opchar == "N") {
                    op = "Not Contains";
                    orgop = "NOT LIKE";
                    valstr = opstr.substr(orgop.length, opstr.length).trim();
                    val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
                }
                if (opchar == "L") {
                    orgop = "LIKE";
                    valstr = opstr.substr(orgop.length, opstr.length).trim();
                    if (valstr.indexOf('%') == 1) {
                        if (valstr.substr(2, valstr.length).indexOf('%') > 0) {
                            op = "Contains";
                            val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
                        }
                        else {
                            op = "Ends With";
                            val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 3);
                        }
                    }
                    else {
                        op = "Starts With";
                        val = valstr.substr(1, valstr.length - 3);
                    }
                }
            }
            else {
                op = opstr.substr(0, opstr.indexOf(' '));
                valstr = opstr.substr(op.length, opstr.length).trim();
                val = valstr.substr(1, valstr.length - 2);
            }
            if (op == '=') {
                var cbo = "cbo" + module + "Filter" + field;
                if ($("#" + cbo + " option[value='" + op + "']").length == 0) {
                    op = "Exact Word"
                }
            }
            $('#cbo' + module + 'Filter' + field).val(op).change();
            $('#txt' + module + 'Filter' + field).val(val).change();
        }

        function setfiltervalues(QueryText) {

            var currWhereClause = QueryText.toString().trim();

            currValue = currWhereClause.toString().trim();
            if (currValue.substring(currValue.length - 1) == ")") {
                currValue = currValue.substring(0, currValue.length - 1);
            }
            if (currValue.substring(0, 1) == "(") {
                currValue = currValue.substring(1);
            }
            currWhereClause = currValue;

            if (currWhereClause.indexOf("NOT LIKE") != -1) {
                currWhereClause = currWhereClause.replace("NOT LIKE", "notlike");
            }

            var str = currWhereClause;

            var regex = /'[^"]+'|[^\s]+/g;
            result = str.match(regex);

            var str = result.toString();
            var arr = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);
            //var arr = str.match(/(\([^\)]+\)|\S+|\s+)/);
            //var arr = str.match(/('.*?'|[^',\s]+[^(.*?),\s]+)(?=\s*,|\s*$)/g);
            for (var i = 0; i < arr.length; i++) {
                //alert(arr[i]);
            }

            var arrFields = currWhereClause.split(" ");
            arrFields = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);
            if (arrFields[0] == "EmployeeName") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterEmployeeName", "txtEmpFilterEmployeeName");
            }
            if (arrFields[0] == "EmployeeCode") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterEmployeeCode", "txtEmpFilterEmployeeCode");
            }
            if (arrFields[0] == "UserName") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterUserName", "txtEmpFilterUserName");
            }
            if (arrFields[0] == "BirthDate") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterBirthDate", "txtEmpFilterBirthDate");
            }
            if (arrFields[0] == "Gender") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterGender", "txtEmpFilterGender");
            }
            if (arrFields[0] == "EmailID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "txtEmpFilterEmailID", "txtEmpFilterEmailID");
            }
            if (arrFields[0] == "BloodGroup") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterBloodGroup", "txtEmpFilterBloodGroup");
            }
            if (arrFields[0] == "Address") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterAddress", "txtEmpFilterAddress");
            }
            if (arrFields[0] == "CurrentAddress") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterCurrentAddress", "txtEmpFilterCurrentAddress");
            }
            if (arrFields[0] == "City") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterCity", "txtEmpFilterCity");
            }
            if (arrFields[0] == "CurrentCity") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterCurrentCity", "txtEmpFilterCurrentCity");
            }
            if (arrFields[0] == "State") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterState", "txtEmpFilterState");
            }
            if (arrFields[0] == "CurrentState") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterCurrentState", "txtEmpFilterCurrentState");
            }
            if (arrFields[0] == "PinCode") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterPinCode", "txtEmpFilterPinCode");
            }
            if (arrFields[0] == "CurrentPinCode") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterCurrentPinCode", "cboEmpFilterCurrentPinCode");
            }
            if (arrFields[0] == "Phone") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterPhone", "txtEmpFilterPhone");
            }
            if (arrFields[0] == "CurrentPhone") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterCurrentPhone", "txtEmpFilterCurrentPhone");
            }
            if (arrFields[0] == "PostID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterPostID", "txtEmpFilterPostID");
            }
            if (arrFields[0] == "DesignationID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterDesignationID", "txtEmpFilterDesignationID");
            }
            if (arrFields[0] == "DepartmentID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterDepartmentID", "txtEmpFilterDepartmentID");
            }
            if (arrFields[0] == "EmployeeType") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterEmployeeType", "txtEmpFilterEmployeeType");
            }
            if (arrFields[0] == "ReportingTo") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterReportingTo", "txtEmpFilterReportingTo");
            }
            if (arrFields[0] == "RatePerHour") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterRatePerHour", "txtEmpFilterRatePerHour");
            }
            if (arrFields[0] == "CostPerHour") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterCostPerHour", "txtEmpFilterCostPerHour");
            }
            if (arrFields[0] == "CostToCompany") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterCostToCompany", "txtEmpFilterCostToCompany");
            }
            if (arrFields[0] == "CurrencyID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterCurrencyID", "txtEmpFilterCurrencyID");
            }
            if (arrFields[0] == "FacilityID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterFacilityID", "txtEmpFilterFacilityID");
            }
            if (arrFields[0] == "ExtensionNo") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterExtensionNo", "txtEmpFilterExtensionNo");
            }
            if (arrFields[0] == "MobileNumber") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterMobileNumber", "txtEmpFilterMobileNumber");
            }
            if (arrFields[0] == "CommunicationID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterCommunicationID", "txtEmpFilterCommunicationID");
            }
            if (arrFields[0] == "GradeID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterGradeID", "txtEmpFilterGradeID");
            }
            if (arrFields[0] == "PassportNumber") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterPassportNumber", "txtEmpFilterPassportNumber");
            }
            if (arrFields[0] == "PP_DateOfIssue") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterPP_DateOfIssue", "txtEmpFilterPP_DateOfIssue");
            }
            if (arrFields[0] == "PP_PlaceOfIssue") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterPP_PlaceOfIssue", "txtEmpFilterPP_PlaceOfIssue");
            }
            if (arrFields[0] == "PP_ExpiryDate") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterPP_ExpiryDate", "txtEmpFilterPP_ExpiryDate");
            }
            if (arrFields[0] == "PP_RelativeName") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterPP_RelativeName", "txtEmpFilterPP_RelativeName");
            }
            if (arrFields[0] == "BusinessGroupID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterBusinessGroupID", "txtEmpFilterBusinessGroupID");
            }
            if (arrFields[0] == "LocationID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterLocationID", "txtEmpFilterLocationID");
            }
            if (arrFields[0] == "ResourcePoolID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterResourcePoolID", "txtEmpFilterResourcePoolID");
            }
            if (arrFields[0] == "GroupID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboEmpFilterGroupID", "txtEmpFilterGroupID");
            }
            if (arrFields[0] == "IsLDAPAuthentication") {
                var currOpReq = arrFields[1].toString().trim();
                var currValue1 = arrFields[2].toString().trim();
                setFilterComboValue("cboEmpFilterIsLDAPAuthentication", currOpReq)
                if (currValue1 == "'true'") {
                    $('#chkEmpFilterIsLDAPAuthentication').prop("checked", true);
                }
                else {
                    $('#chkEmpFilterIsLDAPAuthentication').prop("checked", false);
                }
            }
        }
        function setFilterComboValue(fieldName, fieldValue, flag) {
            //if (flag == undefined) {
            //    $("#" + fieldName).removeClass("selectpicker");
            $("#" + fieldName).val(fieldValue);
            //    $("#" + fieldName).addClass("selectpicker");
            //    $('.selectpicker').selectpicker('refresh');
            //}
            //if (flag == "class") {
            //    $("." + fieldName).removeClass("selectpicker");
            //    $("." + fieldName).val(fieldValue);
            //    $("." + fieldName).addClass("selectpicker");
            //    $('.selectpicker').selectpicker('refresh');
            //}
        }
        function setFilterOpComboFieldValue(currWhereClause, arrFields, OpComboName, ValueComboName) {
            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") != -1 && currWhereClause.indexOf("'%") != -1) {
                setFilterComboValue(OpComboName, "Contains");

            }
            if (arrFields[1] == "notlike") {
                setFilterComboValue(OpComboName, "Not Contains");
            }

            if (arrFields[1] == "=") {
                setFilterComboValue(OpComboName, "Exact Word");
            }

            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") != -1 && currWhereClause.indexOf("'%") == -1) {
                setFilterComboValue(OpComboName, "Starts With");
            }

            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") == -1 && currWhereClause.indexOf("'%") != -1) {
                setFilterComboValue(OpComboName, "Ends With");
            }

            if (arrFields[1] == "=") {
                setFilterComboValue(OpComboName, "=");
            }
            if (arrFields[1] == "<>") {
                setFilterComboValue(OpComboName, "<>");
            }
            if (arrFields[1] == "<=") {
                setFilterComboValue(OpComboName, "<=");
            }
            if (arrFields[1] == "<") {
                setFilterComboValue(OpComboName, "<");
            }
            if (arrFields[1] == ">") {
                setFilterComboValue(OpComboName, ">");
            }
            if (arrFields[1] == ">=") {
                setFilterComboValue(OpComboName, ">=");
            }
            var currValue = arrFields[2].replace("'%", "");
            currValue = currValue.replace("%'", "");
            currValue = currValue.toString().trim();
            if (currValue.substring(currValue.length - 1) == "'") {
                currValue = currValue.substring(0, currValue.length - 1);
            }
            if (currValue.substring(0, 1) == "'") {
                currValue = currValue.substring(1);
            }

            //$("#" + ValueComboName).val(currValue);
            //Commented & added by mahesh on  27 july 2021
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }

        function ClearFilterDetails(flag) {
            if ($("#cboEmpFilterEmployeeName").val() != "Contains") {
                setFilterComboValue("cboEmpFilterEmployeeName", "Contains");
            }
            if ($("#txtEmpFilterEmployeeName").val() != "") {
                $("#txtEmpFilterEmployeeName").val("");
            }
            if ($("#cboEmpFilterEmployeeCode").val() != "Contains") {
                setFilterComboValue("cboEmpFilterEmployeeCode", "Contains");
            }
            if ($("#txtEmpFilterEmployeeCode").val() != "") {
                $("#txtEmpFilterEmployeeCode").val("");
            }
            if ($("#cboEmpFilterUserName").val() != "Contains") {
                setFilterComboValue("cboEmpFilterUserName", "Contains");
            }
            if ($("#txtEmpFilterUserName").val() != "") {
                $("#txtEmpFilterUserName").val("");
            }
            //Added by Chetan M on 14 July 2021
            if ($("#txtEmpFilterGender").val() != "") {
                $("#txtEmpFilterGender").val("");
            }
            if ($("#txtEmpFilterBloodGroup").val() != "") {
                $("#txtEmpFilterBloodGroup").val("");
            }
            if ($("#txtEmpFilterPostID").val() != "") {
                $("#txtEmpFilterPostID").val("");
            }
            if ($("#txtEmpFilterDesignationID").val() != "") {
                $("#txtEmpFilterDesignationID").val("");
            }
            if ($("#txtEmpFilterDepartmentID").val() != "") {
                $("#txtEmpFilterDepartmentID").val("");
            }
            // Added by Dipali V on 6th May 2026 for vendor management - clear Vendor filter on clear all
            if ($("#txtEmpFilterVendorID").val() != "") {
                $("#txtEmpFilterVendorID").val("");
            }
            if ($("#txtEmpFilterEmployeeType").val() != "") {
                $("#txtEmpFilterEmployeeType").val("");
            }
            if ($("#txtEmpFilterReportingTo").val() != "") {
                $("#txtEmpFilterReportingTo").val("");
            }
            if ($("#txtEmpFilterCurrencyID").val() != "") {
                $("#txtEmpFilterCurrencyID").val("");
            }
            if ($("#txtEmpFilterDeployable").val() != "") {
                $("#txtEmpFilterDeployable").val("");
            }
            if ($("#txtEmpFilterBusinessGroupID").val() != "") {
                $("#txtEmpFilterBusinessGroupID").val("");
            }
            if ($("#txtEmpFilterLocationID").val() != "") {
                $("#txtEmpFilterLocationID").val("");
            }
            if ($("#txtEmpFilterResourcePoolID").val() != "") {
                $("#txtEmpFilterResourcePoolID").val("");
            }
            if ($("#txtEmpFilterGroupID").val() != "") {
                $("#txtEmpFilterGroupID").val("");
            }
            if ($("#txtEmpFilterFacilityID").val() != "") {
                $("#txtEmpFilterFacilityID").val("");
            }
            if ($("#txtEmpFilterGradeID").val() != "") {
                $("#txtEmpFilterGradeID").val("");
            }
            if ($("#txtEmpFilterCommunicationID").val() != "") {
                $("#txtEmpFilterCommunicationID").val("");
            }
            //End of Added by Chetan M on 14 July 2021
            //Added By Reshma Chavan on 6th Dec 2021 for clear data on clear all click            
            ClearBasicFilter("Emp");
            $("#chkEmpFilterIsLDAPAuthentication").prop("checked", false);
            //End of Added By Reshma Chavan on 6th Dec 2021 for clear data on clear all click

            $('#txtVTFilterName').val('');
            savedFilterName = "";

            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {

                    $(this).removeAttr("checked");
                });
            }

        }
        var EmployeeDetails;
        function GetAllEmployeeList(filterParams) {
            //Added by imran on 24-08-2022
            if (filterParams == null || filterParams == "") {
                filterParams = { EmpWhereClause: "" }
            }
            //End of comment by imran on 24-08-2022
            var strHTML = "";
            StartLoader("#body-tblEmplyee");
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetAllEmployee',
                type: "POST",
                data: JSON.stringify(filterParams),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (filterParams) {
                        xhr.setRequestHeader("Params", encryptString(isJson(filterParams) ? filterParams : JSON.stringify(filterParams)));
                    }
                },
                success: function (data) {
                    EmployeeDetails = data;
                    $.each(EmployeeDetails, function (index, obj) {
                        //var stractive = '';
                        //if (obj.active === true) {
                        //    stractive = 'yes'
                        //} else {
                        //    stractive = 'no'
                        //}
                        strHTML += '<tr>' +
                            //'<tr><td class="text-start"><input type="hidden" name="hdnrm_employeeid" id="hdnrm_employeeid" value= ' + obj.EmployeeID + '> ' +
                            '<td width="120" class="text-start"><input type="hidden" name="hdnrm_employeeid" id="hdnrm_employeeid" value= ' + obj.EmployeeID + '> <a href="javascript:;" class="BGdetalilink" onclick="editME()"> ' + obj.EmployeeName + '</a></td>' +
                            '<td width="120"> ' + obj.UserName + '</td>' +
                            '<td > ' + obj.RoleName + '</td>' +
                            '<td> ' + obj.Location + '</td>' +
                            '<td> ' + obj.Department + '</td>' +
                            '<td> ' + obj.EmailID + '</td>' +
                            //Added by Nikhil Mane on 3rd July 2026 for Download Resume and Download PDF functionality in Employee Master
                            '<td width="80"> <a href="javascript:;" title="Resume" onclick="GetResourceResume(' + obj.EmployeeID + ')"><i class="far fa-file"></i> </a>&nbsp;<a href="javascript:;" title="Download PDF" onclick="DownloadResumePDF(' + obj.EmployeeID + ')"><i class="fas fa-file-pdf" style="color:#e74c3c;"></i> </a></td>' +
                            //End of Added by Nikhil Mane on 3rd July 2026 for Download Resume and Download PDF functionality in Employee Master
                            '<td class="actioncolumn"><a id="" class="BGdetalilink" href="javascript:;" title="" onclick="editME()">' +
                            '<img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-bs-original-title="Edit"></a>' +
                            //'<button  class="nostylebtn" title="Delete" data-bs-container="body" data-bs-toggle="modal" data-bs-target="#deleteinfomodal"><i class="far fa-trash-alt"></i></button> </td></tr>'
                            '<button id ="btnEmployeedelete" class="nostylebtn" data-bs-toggle="tooltip" data-bs-original-title="Delete" onclick=DeleteEmployeeDetails(' + obj.EmployeeID + ') ><i class="far fa-trash-alt"></i></button> </td></tr>'
                    });
                    $('#MEListTbl').dataTable().fnDestroy();
                    $("#tblBusinessGroups").html(strHTML);
                    LoadPagination('#MEListTbl', data);
                    StopAjaxLoader("#body-tblEmplyee");
                    //var table = $('#MEListTbl').DataTable();
                    //table.columns.adjust().draw();
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
        //history Tab
        function OpenHistoryTab() {
            //if (CurrentTabObject != null && CurrentTabObject.History == "false") {
            var EmpID = $("#hdnEmployee_UniqueIDTab").val();
            GetHistory(EmpID);
            CurrentTabObject.History = 'true';
            /// }
        }
        function GetHistory(empID) {
            CurrentTabObject.History = 'true';
            var strHTML = "";
            // StartLoader("#body-LoaderHistory");
            // var Params = { EmployeeID: empID }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetHistory',
                type: "POST",
                data: JSON.stringify(empID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (empID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(empID) ? empID : JSON.stringify(empID)));
                    }
                },
                success: function (data) {
                    //Commented And Added by Reshma Chavan on 23 feb 2022 for history 
                    //var List = data;

                    //if (List.length > 0) {
                    //    $.each(List, function (index, obj) {
                    //        debugger;
                    //        var old = "";
                    //        var new1 = "";

                    //        if (obj.OldValue == "Jan  1 1900 12:00AM") {
                    //            old = "";
                    //        }
                    //        else {
                    //            old = obj.OldValue.replace('12:00AM',"");
                    //        }
                    //        if (obj.NewValue == "Jan  1 1900 12:00AM") {
                    //            new1 = "";
                    //        }
                    //        else {
                    //            new1 = obj.NewValue.replace('12:00AM',"");
                    //        }
                    //        if (obj.FieldName == "IsActive") {
                    //            if (obj.OldValue == 1) {
                    //                old = "Yes";
                    //            }
                    //            else {
                    //                old = "No";
                    //            }
                    //            if (obj.NewValue == 1) {
                    //                new1 = "Yes";
                    //            }
                    //            else {
                    //                new1 = "No";
                    //            }
                    //        }
                    //        //strHTML += "<tr><td>" + obj.FieldName + " </td><td>" + old + " </td><td>" + new1 + "</td><td>" + convert(obj.CreatedDate) + "</td><td>" + obj.CreatedBy + "</td></tr>";
                    //        strHTML += "<tr><td>" + obj.FieldName + " </td><td>" + old + " </td><td>" + new1 + "</td><td>" + obj.CreatedDate + "</td><td>" + obj.CreatedBy + "</td></tr>";

                    //    });
                    //}

                    var strHTML = "";
                    if (data.length > 0) {

                        for (var i = 0; i < data.length; i++) {
                            var ModifiedField = data[i]["FieldName"];
                            var ModifiedDate = data[i]["CreatedDate"];
                            var OldValue = data[i]["OldValue"];
                            var NewValue = data[i]["NewValue"];
                            var ModifiedBy = data[i]["CreatedBy"];
                            if (OldValue == null) { OldValue = ""; }
                            if (NewValue == null) { NewValue = ""; }

                            if (OldValue == "Jan  1 1900 12:00AM") {
                                OldValue = "";
                            }
                            else {
                                OldValue = OldValue;
                            }
                            if (NewValue == "Jan  1 1900 12:00AM") {
                                NewValue = "";
                            }
                            else {
                                NewValue = NewValue;
                            }
                            if (ModifiedField == "IsActive") {
                                if (OldValue == 1) {
                                    OldValue = "Yes";
                                }
                                else {
                                    OldValue = "No";
                                }
                                if (NewValue == 1) {
                                    NewValue = "Yes";
                                }
                                else {
                                    NewValue = "No";
                                }
                            }
                            strHTML += '<tr>'
                            strHTML += '<td>' + ModifiedField
                            strHTML += '</td>'
                            strHTML += '<td>' + OldValue
                            strHTML += '</td>'
                            strHTML += '<td>' + NewValue
                            strHTML += '</td>'
                            strHTML += '<td>' + ModifiedDate
                            strHTML += '</td>'
                            strHTML += '<td>' + ModifiedBy
                            strHTML += '</td>'
                            strHTML += '</tr>'

                        }

                    }
                    else {

                    }

                    $('#emsubtabShowHistoryTbl').dataTable().fnDestroy();
                    $("#emsubtabShowHistoryTblMain").html(strHTML);
                    //LoadPagination('#emsubtabShowHistoryTbl', data);
                    //LoadPaginationForHistory('#emsubtabShowHistoryTbl', data);
                    //Added by imran on 24-08-2022
                    $('#emsubtabShowHistoryTbl').dataTable({
                        "sscrolly": (0.5 * $(window).height()),
                        "bpaginate": false,
                        "bjqueryui": true,
                        "bscrollcollapse": true,
                        "iDisplayLength": noOfRowsPerPage,
                        "bautowidth": true,
                        "sscrollx": "100%",
                        "sscrollxinner": "100%",
                        "lengthChange": false,
                        "searching": false,
                        pageLength: 10,
                        "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1] }]// Added By Pradip on 20 July 2021
                    });
                    //End of comment by imran on 24-08-2022

                    //End of Commented And Added by Reshma Chavan on 23 feb 2022 for history 
                    //StopAjaxLoader("#body-LoaderHistory");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#body-LoaderHistory");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
        //group Tab
        function FillGroups(value, param) {
            var strHTML = "";
            //if (value > 0) {
            var objOU = { UserID: value, LoginType: param }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetGroups',
                type: "POST",
                data: JSON.stringify(objOU),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objOU) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objOU) ? objOU : JSON.stringify(objOU)));
                    }
                },
                success: function (data) {
                    //Commented By reshma Chavan on 6th Oct 2021 For Getting PlaceHolder -IssueID-29767
                    //strHTML += "<option value='0'></option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.RoleID + ' >' + listComponent.RoleDescription + '</option>');
                    }
                    $("#cboGroup").html(strHTML);
                    BindPlaceholder("cboGroup", "Group Name");
                    //if (value != null && value > 0 && value != undefined) {
                    //    $("#cboGroup").val(value);
                    //}
                    //End of Commented By reshma Chavan on 6th Oct 2021 For Getting PlaceHolder
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }

        //Added by Chetan M on 4 Aug 2021 for Bind skill
        //Commented And Added By Reshma Chavan for getting Skill in Edit Mode
        //function FillSkills(EmployeeID)
        function FillSkills(EmployeeID, EmployeeSkillID) {
            var strHTML = "";

            //if (value > 0) {
            //var objOU = { UserID: EmployeeID}
            var objOU = { UserID: EmployeeID, EmployeeSkillID: EmployeeSkillID }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetSkills',
                type: "POST",
                data: JSON.stringify(objOU),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objOU) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objOU) ? objOU : JSON.stringify(objOU)));
                    }
                },
                success: function (data) {
                    strHTML += "<option value='0' selected></option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.ToolID + ' >' + listComponent.Description + '</option>');
                    }
                    $("#cboempskill").html(strHTML);
                    //if (value != null && value > 0 && value != undefined) {
                    //    $("#cboempskill").val(value);
                    //}
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
        //End of Added by Chetan M on 4 Aug 2021 for Bind skill

        function OpenGroupTab() {
            if (CurrentTabObject != null && CurrentTabObject.Groups == "false") {
                var EmpID = $("#hdnEmployee_UniqueIDTab").val();
                GetEmpGroup(EmpID);
                CurrentTabObject.Groups = 'true';
            }
        }
        function addGroupPopup() {

            FillGroups($("#hdnEmployee_UniqueIDTab").val(), SessionLoginType);
            $("#hdnGroupId").val(0);
            $('#cboGroup').val("");
            $('#btnAddEmpGroup').show();
            $('#btnsaveEmpGroup').show();
            $('#btnUpdateEmpGroups').hide();

            // $('#btnSaveLeave').attr("disabled", false);
            //Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
            $('table').resize();// added by pradip on 20-7-2021
            $($.fn.dataTable.tables(true)).css('width', '100%');
            $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            //End of Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
        }
        function GetEmpGroup(empID) {

            CurrentTabObject.Groups = 'true';
            SelectedEmpGroupID = [];
            var strHTML = "";
            //StartLoader("#DesgLeaves");
            //var QualiParams = { EmployeeID: empID }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetGroupsDetails',
                type: "POST",
                data: JSON.stringify(empID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (empID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(empID) ? empID : JSON.stringify(empID)));
                    }
                },
                success: function (data) {
                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            //if (blnEditAccess == "True") {
                            //Commented and added by Chetan M on 13 Aug 2021 for edit functionality
                            //strHTML += '<tr><td class="text-start">' + obj.GroupName + '</td><td><input type="hidden" id="hdn_EmpGroupID" name="hdn_EmpGroupID" value= ' + obj.UniqueID + '><div class="custom_chckbox"><input id=chlG_' + index + ' onclick="checkUncheckforGroup();GetSelectedGroups(this);" class="chcktbl" type="checkbox"><label for=chlG_' + index + '></label></div></td></tr>';
                            strHTML += '<tr><td class="text-start"> <a href="javascript:;" class="Grouplink" onclick="GetEmployeeGroupForEdit(' + obj.UniqueID + ')"  data-bs-toggle="modal"  data-bs-target="#MEaddGroup"</a>' + obj.GroupName + '</td><td><input type="hidden" id="hdn_EmpGroupID" name="hdn_EmpGroupID" value= ' + obj.UniqueID + '><div class="custom_chckbox"><input id=chlG_' + index + ' onclick="checkUncheckforGroup();GetSelectedGroups(this);" class="chcktbl" type="checkbox"><label for=chlG_' + index + '></label></div></td></tr>';
                            //ENd of Commented and added by Chetan M on 13 Aug 2021 for edit functionality

                        });
                    }

                    $('#emsubtabGroupTbl').dataTable().fnDestroy();
                    $("#tblEmpGroups").html(strHTML);
                    LoadPaginationForGroups(data);
                    //StopAjaxLoader("#DesgLeaves");
                    $(".chckHead3").prop("checked", false);

                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#DesgLeaves");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })

        }
        function checkValidationforGroup() {
            if ($("#cboGroup").val() == 'undefined' || $("#cboGroup").val() == "" || $("#cboGroup").val() == null || $("#cboGroup").val() == 0) {
                $("#cboGroup").focus();
                Gvalidateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Group should not be left blank");
                return false;
            }
            else {
                Gvalidateflag = true;
                return true;
            }
        }
        var Gvalidateflag;
        function saveEmpGroups(isFromSaveAndclick) {
            checkValidationforGroup();
            if (Gvalidateflag == true) {
                // var UniqueID = $("#hdn_LeaveUnquieID").val();
                var EmpGID = $("#hdnGroupId").val();
                var EmployeeID = $("#hdnEmployee_UniqueIDTab").val();
                var grp = $("#cboGroup").val();
                var Details = {
                    UniqueID: EmpGID > 0 ? EmpGID : 0,
                    UserID: EmployeeID,
                    GroupID: grp,
                    LoginType: SessionLoginType
                    //CreatedBy: encodeURI(UserName)

                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/SaveGroups',
                    method: 'Post',
                    data: JSON.stringify(Details),
                    dataType: 'json',
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Details) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Details) ? Details : JSON.stringify(Details)));
                        }
                    },
                    success: function (data) {
                        if (isFromSaveAndclick == 0) {
                            if (data == "Group Name already exist.") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                $('#MEaddGroup').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);

                                GetEmpGroup($("#hdnEmployee_UniqueIDTab").val());

                                //Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
                                var table = $('#emsubtabGroupTbl').DataTable();

                                $('#container').css('display', 'block');
                                table.columns.adjust().draw();
                                //End of Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable

                            }
                        }
                        else {
                            if (data == "Group Name already exist.") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                clearGroupDetail();
                                $('#MEaddGroup').modal('show');
                                //$("#hdnCertificationId").val(0);
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);

                                GetEmpGroup($("#hdnEmployee_UniqueIDTab").val());
                                //Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
                                var table = $('#emsubtabGroupTbl').DataTable();
                                $('#container').css('display', 'block');
                                table.columns.adjust().draw();
                                //End of Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable

                                //  //Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
                                //$('table').columns.adjust();// added by pradip on 20-7-2021
                                //   $($.fn.dataTable.tables(true)).css('width', '100%');
                                //   $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
                                //   $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
                                // //End of Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable

                            }
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);

                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }

                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            CurrentTabObject.Groups = 'false';
                            GetEmpGroup($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.Groups = 'true';
                            //StopAjaxLoader("#bodyGlobal-Resource");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }

                    }
                })
            } else {
                return false;
            }
        }
        function DeleteEmpGroups() {
            var strHTML = "";
            var selectedUniqueId = SelectedEmpGroupID.toString();
            if (selectedUniqueId.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/DeleteGroup',
                    type: "POST",
                    data: JSON.stringify(selectedUniqueId),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        // StartLoader("#bodyCertification-Details");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedUniqueId) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedUniqueId) ? selectedUniqueId : JSON.stringify(selectedUniqueId)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //}

                        //StopAjaxLoader("#bodyCertification-Details");
                        CurrentTabObject.Groups = 'false';
                        GetEmpGroup($("#hdnEmployee_UniqueIDTab").val());
                        CurrentTabObject.Groups = 'true';
                        //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        //strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                        //End of Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterowGroup').html(strHTML);
                        $('#DeleteConfirmMModalForGroup').modal('show');
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);

                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "OK") {  //200
                            CurrentTabObject.Groups = 'false';
                            GetEmpGroup($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.Groups = 'true';
                            $('#DeleteConfirmMModalForGroup').modal('hide');
                            //alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify("Deleted");

                        }

                        // StopAjaxLoader("#bodyCertification-Details");
                        $('#DeleteConfirmMModalForGroup').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedEmpGroupID = [];
            selectedUniqueId = "";
        }
        function LoadPaginationForGroups(data) {

            //$.fn.DataTable.ext.pager.numbers_length = 5;
            //groupTable = $('#emsubtabGroupTbl').dataTable({
            //    "sscrolly": (0.5 * $(window).height()),
            //    //"dtat": data,
            //    "bFilter": false,
            //    "retrieve": true,
            //    "fixedHeader": true,
            //    "scrollX": true,
            //    "scrollY": true,
            //    "scrollResize": true,
            //    "bscrollcollapse": true,
            //    "iDisplayLength": noOfRowsPerPage,
            //    "lengthChange": false,
            //    "searching": false,
            //    "destroy": true,
            //     "bautowidth": true,
            //    "sscrollx": "100%",
            //    "sscrollxinner": "100%",
            //    "bjqueryui": true,

            //     "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1] }]// Added By Pradip on 20 July 2021


            //});

            $.fn.DataTable.ext.pager.numbers_length = 5;
            groupTable = $('#emsubtabGroupTbl').dataTable({
                "sscrolly": (0.5 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                "lengthChange": false,
                "searching": false,
                //Added by imran on 24-08-2022
                pageLength: 10,
                //End of comment by imran on 24-08-2022
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1] }]// Added By Pradip on 20 July 2021
            });

            //// $('#btnSaveLeave').attr("disabled", false);
            //      //Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
            //    $('table').resize();// added by pradip on 20-7-2021
            //    $($.fn.dataTable.tables(true)).css('width', '100%');
            //    $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
            //    $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            //   //End of Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable



        }
        $(".chckHead3").change(function () {
            var allPages = groupTable.fnGetNodes();
            var checked = $(this).is(':checked');
            if (checked) {
                $('input[type="checkbox"]', allPages).prop('checked', true);
                var rows = $("#emsubtabGroupTbl").dataTable().fnGetNodes();
                for (var i = 0; i < rows.length; i++) {
                    SelectedEmpGroupID.push(parseInt($(rows[i]).find("#hdn_EmpGroupID").val()));
                }

            } else {
                $('input[type="checkbox"]', allPages).prop('checked', false);
                SelectedEmpGroupID = [];
            }
        });
        function checkUncheckforGroup() {
            // alert(1);
            if (groupTable.$('input:checked').length == groupTable.fnGetNodes().length) {
                $(".chckHead3").prop("checked", true);
            } else {
                $(".chckHead3").removeAttr("checked");
                $(".chckHead3").prop("checked", false);
            }
        }
        var SelectedEmpGroupID = [];
        function GetSelectedGroups(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedEmpGroupID.push(parseInt(row.find('#hdn_EmpGroupID').val()));
            }
            else {
                if (SelectedEmpGroupID != 'undefined' && SelectedEmpGroupID.length > 0) {
                    var removeGrp = row.find('#hdn_EmpGroupID').val();
                    SelectedEmpGroupID.remove(parseInt(removeGrp));
                }
            }

        }
        function clearGroupDetail() {
            // $("#hdnEmployee_UniqueIDTab").val(0);
            $("#cboGroup").val("");

        }
        //Qualifications Tab
        function OpenQualificationTab() {
            if (CurrentTabObject != null && CurrentTabObject.Qualification == "false") {
                var EmpID = $("#hdnEmployee_UniqueIDTab").val();
                //alert(EmpID);
                GetEmpQualification(EmpID);
                CurrentTabObject.Qualification = 'true';
            }
        }
        function addQualiPopup() {
            $('#btnSaveQualification').show();
            $('#btnQuaSave').show();
            $('#btnUpdateQua').hide();
            $("#hdnQualificationId").val(0);
            $('#cboQualificationID').val("");
            $('#txtUniversityName').val("");
            $('#cboPassoutYear').val("");
            $('#txtPercentage').val("");
            $('#txtClass').val("");
            $('#btnSaveLeave').attr("disabled", false);
        }
        function GetEmpQualification(empID) {
            CurrentTabObject.Qualification = 'true';
            SelectedEmpQualiID = [];
            var strHTML = "";
            //StartLoader("#DesgLeaves");
            //var QualiParams = { EmployeeID: empID }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetQualificationDetails',
                type: "POST",
                data: JSON.stringify(empID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (empID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(empID) ? empID : JSON.stringify(empID)));
                    }
                },
                success: function (data) {
                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            //if (blnEditAccess == "True") {
                            //strHTML += '<tr><td class="text-center">' + obj.QualificationName + '</td><td class="text-center"> ' + obj.University + ' </td><td class="text-center"> ' + obj.PassoutYear + ' </td><td class="text-center"> ' + obj.Class + ' </td><td class="text-center"> ' + obj.PercentageDetails + ' </td><td><input type="hidden" id="hdn_EmpQualificationID" name="hdn_EmpQualificationID" value= ' + obj.EmployeeQualificationID + '><div class="custom_chckbox"><input id=chlQ_' + index + ' onclick="checkUncheckforQualification();GetSelectedQualifications(this);" class="chcktbl" type="checkbox"><label for=chlQ_' + index + '></label></div></td></tr>';
                            strHTML += '<tr><td class="text-center"><a href="javascript:;" onclick="GetQualificationForEdit(' + obj.EmployeeQualificationID + ')"  data-bs-toggle="modal"  data-bs-target="#MEaddQualificationModal"</a>' + obj.QualificationName + '</td><td class="text-center"> ' + obj.University + ' </td><td class="text-center"> ' + obj.PassoutYear + ' </td><td class="text-center"> ' + obj.Class + ' </td><td class="text-center"> ' + obj.PercentageDetails + ' </td><td><input type="hidden" id="hdn_EmpQualificationID" name="hdn_EmpQualificationID" value= ' + obj.EmployeeQualificationID + '><div class="custom_chckbox"><input id=chlQ_' + index + ' onclick="checkUncheckforQualification();GetSelectedQualifications(this);" class="chcktbl" type="checkbox"><label for=chlQ_' + index + '></label></div></td></tr>';

                        });
                    }

                    $('#emsubtabQualTbl').dataTable().fnDestroy();
                    $("#tblEmpQualification").html(strHTML);
                    LoadPaginationForQualification(data);
                    //StopAjaxLoader("#DesgLeaves");
                    $(".chckHead2").prop("checked", false);
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#DesgLeaves");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })

        }
        function LoadPaginationForQualification(data) {

            $.fn.DataTable.ext.pager.numbers_length = 5;
            qualificationTable = $('#emsubtabQualTbl').dataTable({
                "sscrolly": (0.5 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                "lengthChange": false,
                "searching": false,
                //Added by imran on 24-08-2022
                pageLength: 10,
                //End of comment by imran on 24-08-2022
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [5] }]// Added By Pradip on 20 July 2021
            });

        }
        $(".chckHead2").change(function () {
            var allPages = qualificationTable.fnGetNodes();
            var checked = $(this).is(':checked');
            if (checked) {
                $('input[type="checkbox"]', allPages).prop('checked', true);
                var rows = $("#emsubtabQualTbl").dataTable().fnGetNodes();
                for (var i = 0; i < rows.length; i++) {
                    SelectedEmpQualiID.push(parseInt($(rows[i]).find("#hdn_EmpQualificationID").val()));
                }

            } else {
                $('input[type="checkbox"]', allPages).prop('checked', false);
                SelectedEmpQualiID = [];
            }
        });
        function checkUncheckforQualification() {
            // alert(1);
            if (qualificationTable.$('input:checked').length == qualificationTable.fnGetNodes().length) {
                $(".chckHead2").prop("checked", true);
            } else {
                $(".chckHead2").removeAttr("checked");
                $(".chckHead2").prop("checked", false);
            }
        }
        var SelectedEmpQualiID = [];
        function GetSelectedQualifications(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedEmpQualiID.push(parseInt(row.find('#hdn_EmpQualificationID').val()));
            }
            else {
                if (SelectedEmpQualiID != 'undefined' && SelectedEmpQualiID.length > 0) {
                    var removeQualification = row.find('#hdn_EmpQualificationID').val();
                    SelectedEmpQualiID.remove(parseInt(removeQualification));
                }
            }

        }
        function checkValidationforQuali() {
            var passYear = $("#cboPassoutYear").val();
            var birthyear = new Date($("#txtBirthDate").val());
            var dt = birthyear.getFullYear();
            // alert(dt);
            if ($("#cboQualificationID").val().trim() == 'undefined' || $("#cboQualificationID").val().trim() == "" || $("#cboQualificationID").val().trim() == null) {
                $("#cboQualificationID").focus();
                Qvalidateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Qualification should not be left blank");
                return false;
            }
            else if ($("#txtUniversityName").val().trim() == 'undefined' || $("#txtUniversityName").val().trim() == "" || $("#txtUniversityName").val().trim() == null) {
                $("#txtUniversityName").focus();
                Qvalidateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("University Name should not be left blank");
                return false;
            }
            //Added By Riddhesh Patil on 10-NOV-2022 
            else if (checkSpecialCharacter($("#txtUniversityName").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('University Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtUniversityName").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil
            else if ($("#cboPassoutYear").val().trim() == 'undefined' || $("#cboPassoutYear").val().trim() == "" || $("#cboPassoutYear").val().trim() == null) {
                $("#cboPassoutYear").focus();
                Qvalidateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Passout Year should not be left blank");
                return false;
            }
            else if (passYear < dt) {
                $("#cboPassoutYear").focus();
                Qvalidateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Passout Year should greater than Birth Year.");
                return false;
            }
            else if ($("#txtClass").val() == undefined || $("#txtClass").val() == "" || $("#txtClass").val() == null) {
                $("#txtClass").focus();
                Qvalidateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Class should not be left blank");
                return false;
            }
            //Added By Riddhesh Patil on 10-NOV-2022 
            else if (checkSpecialCharacter($("#txtClass").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Class should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtClass").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil
            else {
                Qvalidateflag = true;
                return true;
            }
        }
        var Qvalidateflag;
        function saveQualification(isFromSaveAndclick) {
            checkValidationforQuali();
            if (Qvalidateflag == true) {
                // var UniqueID = $("#hdn_LeaveUnquieID").val();
                var EmpQID = $("#hdnQualificationId").val();
                var EmployeeID = $("#hdnEmployee_UniqueIDTab").val();
                var qualiId = $("#cboQualificationID").val();
                var university = $("#txtUniversityName").val();
                var year = $("#cboPassoutYear").val();
                var classname = $("#txtClass").val();

                //Added by imran on 24-08-2022
                if ($("#txtPercentage").val() == "") {
                    var perc = 0;
                }
                else {
                    var perc = $("#txtPercentage").val();
                }
                //End of comment by imran on 24-08-2022

                var Details = {
                    EmployeeQualificationID: EmpQID > 0 ? EmpQID : 0,
                    EmployeeID: EmployeeID,
                    QualificationID: qualiId,
                    University: university,
                    PassoutYear: year,
                    Class: classname,
                    Percentage: perc
                    //CreatedBy: encodeURI(UserName)

                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/SaveQualificationDetails',
                    method: 'Post',
                    data: JSON.stringify(Details),
                    dataType: 'json',
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Details) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Details) ? Details : JSON.stringify(Details)));
                        }
                    },
                    success: function (data) {
                        if (isFromSaveAndclick == 0) {
                            //Added by Chetan M on 9 Aug 2021 for check Duplicate
                            if (data == 'Qualification already exists.') {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $("#cboQualificationID").focus();
                            }
                            else {
                                //End of Added by Chetan M on 9 Aug 2021 for check Duplicate
                                $('#MEaddQualificationModal').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                GetEmpQualification($("#hdnEmployee_UniqueIDTab").val());
                            }

                        }
                        else {
                            //Added by Chetan M on 9 Aug 2021 for check Duplicate
                            if (data == 'Qualification already exists.') {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $("#cboQualificationID").focus();
                            }
                            else {
                                //End of Added by Chetan M on 9 Aug 2021 for check Duplicate
                                clearQualifDetail();
                                $('#MEaddQualificationModal').modal('show');
                                //$("#hdnCertificationId").val(0);
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                GetEmpQualification($("#hdnEmployee_UniqueIDTab").val());
                            }
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            CurrentTabObject.Qualification = 'false';
                            GetEmpQualification($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.Qualification = 'true';
                            //StopAjaxLoader("#bodyGlobal-Resource");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }

                    }
                })
            } else {
                return false;
            }
        }
        function DeleteEmpQualificationDetails() {
            var strHTML = "";
            var selectedUniqueId = SelectedEmpQualiID.toString();
            if (selectedUniqueId.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/DeleteQualificationDetails',
                    type: "POST",
                    data: JSON.stringify(selectedUniqueId),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        // StartLoader("#bodyCertification-Details");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedUniqueId) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedUniqueId) ? selectedUniqueId : JSON.stringify(selectedUniqueId)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //}

                        //StopAjaxLoader("#bodyCertification-Details");
                        CurrentTabObject.Qualification = 'false';
                        GetEmpQualification($("#hdnEmployee_UniqueIDTab").val());
                        CurrentTabObject.Qualification = 'true';
                        //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        //strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                        //End of Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterowQuali').html(strHTML);
                        $('#DeleteConfirmMModalForQuali').modal('show');
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "OK") {  //200
                            CurrentTabObject.Qualification = 'false';
                            GetEmpQualification($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.Qualification = 'true';
                            $('#DeleteConfirmMModalForQuali').modal('hide');
                            //alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify("Deleted");
                        }

                        // StopAjaxLoader("#bodyCertification-Details");
                        $('#DeleteConfirmMModalForQuali').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedEmpQualiID = [];
            selectedUniqueId = "";
        }
        function clearQualifDetail() {
            // $("#hdnEmployee_UniqueIDTab").val(0);
            $("#cboQualificationID ").val("");
            $("#txtUniversityName ").val("");
            $("#txtClass").val("");
            $("#txtPercentage").val("");
            $("#cboPassoutYear").val("");
        }

        //CERTIFICATION
        $(".chckHeadCERT").change(function () {
            //alert(11);
            var allPages = certificationTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#MECrtTbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedEmpCertID.push(parseInt($(rows[i]).find("#hdn_EmpCertificationID").val()));
                    }

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedEmpCertID = [];
                }
            }
        });

        function LoadPaginationForCertification(data) {

            $.fn.DataTable.ext.pager.numbers_length = 5;
            certificationTable = $('#MECrtTbl').dataTable({
                "dtat": data,
                "sscrolly": (0.5 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                "lengthChange": false,
                "searching": false,
                //Added by imran on 24-08-2022
                pageLength: 10,
                //End of comment by imran on 24-08-2022
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [3] }]// Added By Pradip on 20 July 2021
            });

        }

        function checkUncheckCert() {
            if (certificationTable.$('input:checked').length == certificationTable.fnGetNodes().length) {
                $(".chckHeadCERT").prop("checked", true);
            } else {
                $(".chckHeadCERT").removeAttr("checked");
                $(".chckHeadCERT").prop("checked", false);
            }
        }
        function clearCertificationDetail() {
            // $("#hdnEmployee_UniqueIDTab").val(0);
            $("#txtCertificationID ").val("");
            $("#txtCertificationDate ").val("");
            $("#txtCertificationDate").val("");
            $("#txtValidUpto").val("");
            $("#txtTotalScore").val("");
            $("#txtActualScore").val("");

        }

        function OpenCertificationDetails() {
            if (CurrentTabObject != null && CurrentTabObject.Certification == "false") {
                //var EmpID = $("#hdnEmployee_UniqueIDTab").val();
                //alert(EmpID);
                GetCertifications();
                CurrentTabObject.Certification = 'true';
            }
        }
        function addCertPopup() {
            $('#btnSaveCertifaction').show();
            $('#btnSaveCert').show();
            $('#btnUpdateCertification').hide();
            $("#hdnCertificationId").val(0);
            $('#txtCertificationID').val("");
            $('#txtCertificationDate').val("");
            $('#txtValidUpto').val("");
            $('#txtActualScore').val("");
            $('#txtTotalScore').val("");
            // $('#btnSaveLeave').attr("disabled", false);
        }
        function GetCertifications() {
            CurrentTabObject.Certification = 'true';
            SelectedEmpCertID = [];
            var strHTML = "";
            var EmpID = $("#hdnEmployee_UniqueIDTab").val();
            if ($("#txtFILTERCertificationID").val() == "") {
                var certID = 0;
            }
            else {
                var certID = $("#txtFILTERCertificationID").val();
            }

            //StartLoader("#DesgLeaves");
            var CertParams = { EmployeeID: EmpID, CertificationID: certID }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetCertifications',
                type: "POST",
                data: JSON.stringify(CertParams),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (CertParams) {
                        xhr.setRequestHeader("Params", encryptString(isJson(CertParams) ? CertParams : JSON.stringify(CertParams)));
                    }
                },
                success: function (data) {
                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            //if (blnEditAccess == "True") {
                            //alert(obj.CertificationDate);
                            var cdate;
                            if (obj.CertificationDate == '1900-01-01T00:00:00') {
                                cdate = "";
                            } else {
                                cdate = convert(obj.CertificationDate);
                            }

                            //End of Commented and added by Chetan M on 13 Aug 2021 for edit functionality
                            //strHTML += '<tr><td class="text-center">' + obj.CertificationName + '</td><td class="text-center"> ' + cdate + ' </td><td class="text-center"> ' + obj.TotalScore + ' </td><td><input type="hidden" id="hdn_EmpCertificationID" name="hdn_EmpCertificationID" value= ' + obj.EmployeeCertificationID + '><div class="custom_chckbox"><input id=chlCert_' + index + ' onclick="checkUncheckCert();GetSelectedCertification(this);" class="chcktbl" type="checkbox"><label for=chlCert_' + index + '></label></div></td></tr>';
                            //strHTML += '<tr><td class="text-center"><a href="javascript:;" class="Certificationeditlink" onclick="GetCeritficationForEdit(' + obj.EmployeeCertificationID + ')"  data-bs-toggle="modal"  data-bs-target="#AddCertModal"</a> ' + obj.CertificationName + '</td><td class="text-center"> ' + cdate + ' </td><td class="text-center"> ' + obj.TotalScore + ' </td><td><input type="hidden" id="hdn_EmpCertificationID" name="hdn_EmpCertificationID" value= ' + obj.EmployeeCertificationID + '><div class="custom_chckbox"><input id=chlCert_' + index + ' onclick="checkUncheckCert();GetSelectedCertification(this);" class="chcktbl" type="checkbox"><label for=chlCert_' + index + '></label></div></td></tr>';
                            strHTML += '<tr><td class="text-center"><a href="javascript:;" class="Certificationeditlink" onclick="GetCeritficationForEdit(' + obj.EmployeeCertificationID + ')"  data-bs-toggle="modal"  data-bs-target="#AddCertModal"</a> ' + obj.CertificationName + '</td><td class="text-center"> ' + cdate + ' </td><td class="text-center"> ' + obj.ActualScore + ' </td><td><input type="hidden" id="hdn_EmpCertificationID" name="hdn_EmpCertificationID" value= ' + obj.EmployeeCertificationID + '><div class="custom_chckbox"><input id=chlCert_' + index + ' onclick="checkUncheckCert();GetSelectedCertification(this);" class="chcktbl" type="checkbox"><label for=chlCert_' + index + '></label></div></td></tr>';
                            //Commented and added by Chetan M on 13 Aug 2021 for edit functionality
                        });
                    }

                    $('#MECrtTbl').dataTable().fnDestroy();
                    $("#tblCertification").html(strHTML);
                    LoadPaginationForCertification(data);
                    //StopAjaxLoader("#DesgLeaves");
                    $(".chckHeadCERT").prop("checked", false);
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#DesgLeaves");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })

        }
        function checkValidationforCert() {
            var txtCertificationDateComp = new Date($("#txtCertificationDate").val())
            var txtValidUptoComp = new Date($("#txtValidUpto").val())
            var birthyearComp = new Date($("#txtBirthDate").val());
            var txtActualScore = parseInt($('#txtActualScore').val());
            var txtTotalScore = parseInt($('#txtTotalScore').val());
            //Added By Dipali V On 2nd Dec 2021 For Certificate date should not be future date
            var CurrentDate = new Date();
            //End of Added By Dipali V On 2nd Dec 2021 For Certificate date should not be future date

            if ($("#txtCertificationID").val().trim() == 'undefined' || $("#txtCertificationID").val().trim() == "" || $("#txtCertificationID").val().trim() == null) {
                $("#txtCertificationID").focus();
                Cvalidateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Certification Name should not be left blank");
                return false;
            }
            else if ($("#txtCertificationDate").val().trim() == 'undefined' || $("#txtCertificationDate").val().trim() == "" || $("#txtCertificationDate").val().trim() == null) {
                $("#txtCertificationDate").focus();
                Cvalidateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Certification Date should not be left blank");
                return false;
            }
            //Added By Dipali V On 2nd Dec 2021 For Certificate date should not be future date
            else if (txtCertificationDateComp > CurrentDate) {
                $("#txtCertificationDate").focus();
                Cvalidateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Certification Date' should be past date");
                return false;
            }
            //End of Added By Dipali V On 2nd Dec 2021 For Certificate date should not be future date

            else if (txtCertificationDateComp > txtValidUptoComp) {
                $("#txtValidUpto").focus();
                Cvalidateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("The 'Valid Up to Date' should not be less than 'Certification Date'");
                return false;
            }
            else if (birthyearComp > txtCertificationDateComp) {
                $("#txtCertificationDate").focus();
                Cvalidateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("The 'Certification Date' should be greater than 'Birth Date'");
                return false;
            }
            else if (txtActualScore > txtTotalScore) {
                $("#txtActualScore").focus();
                Cvalidateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Actual score' can not be greater than 'out of Score'");
                return false;
            }
            else {
                Cvalidateflag = true;
                return true;
            }
        }
        var Cvalidateflag;
        function saveCertification(isFromSaveAndclick) {
            checkValidationforCert();
            if (Cvalidateflag == true) {
                // var UniqueID = $("#hdn_LeaveUnquieID").val();
                var EmpCertID = $("#hdnCertificationId").val();
                var EmployeeID = $("#hdnEmployee_UniqueIDTab").val();
                if ($("#txtCertificationID").val() == "") {
                    var certId = 0;
                }
                else {
                    var certId = $("#txtCertificationID").val();
                }

                var CertDate = $("#txtCertificationDate").val();
                var ValidUpto = $("#txtValidUpto").val();
                if ($("#txtActualScore").val() == "") {
                    var AScore = 0;
                }
                else {
                    var AScore = $("#txtActualScore").val();
                }


                if ($("#txtActualScore").val() == "") {
                    var TScore = 0;
                }
                else {
                    var TScore = $("#txtTotalScore").val();
                }

                //alert("EmployeeID " + EmployeeID);
                var Details = {
                    EmployeeCertificationID: EmpCertID > 0 ? EmpCertID : 0,
                    EmployeeID: EmployeeID,
                    CertificationID: certId,
                    CertificationDate: CertDate,
                    ValidUpto: ValidUpto,
                    ActualScore: AScore,
                    TotalScore: TScore
                    //CreatedBy: encodeURI(UserName)

                };
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/SaveCertifications',
                    method: 'Post',
                    data: JSON.stringify(Details),
                    dataType: 'json',
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Details) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Details) ? Details : JSON.stringify(Details)));
                        }
                    },
                    success: function (data) {
                        if (isFromSaveAndclick == 0) {
                            if (data == "Certification already exist.") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                $('#AddCertModal').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                //onCloseLeaves();
                                GetCertifications($("#hdnEmployee_UniqueIDTab").val());
                            }
                        }


                        if (isFromSaveAndclick == 1) {
                            if (data == "Certification already exist.") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                $('#AddCertModal').modal('show');
                                clearCertificationDetail();
                                $("#hdnCertificationId").val(0);
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                GetCertifications($("#hdnEmployee_UniqueIDTab").val());
                            }
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            CurrentTabObject.Certification = 'false';
                            GetCertifications($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.Certification = 'true';
                            //StopAjaxLoader("#bodyGlobal-Resource");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        // StopAjaxLoader("#DesgLeaves");
                        //if (isFromSaveAndclick == 0) {
                        //    $('#AddVTModal').modal('hide');
                        //}
                    }
                })
            } else {
                return false;
            }
        }
        var SelectedEmpCertID = [];
        //var selectedCertificationUniqueId = '';
        function GetSelectedCertification(currentObject) {
            // debugger;
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedEmpCertID.push(parseInt(row.find('#hdn_EmpCertificationID').val()));
            }
            else {
                if (SelectedEmpCertID != 'undefined' && SelectedEmpCertID.length > 0) {
                    var removeEmp = row.find('#hdn_EmpCertificationID').val();
                    SelectedEmpCertID.remove(parseInt(removeEmp));
                    //SelectedEmpCertID.remove(removeEmp);
                }
            }
        }
        function DeleteEmpCertificationDetails() {
            var strHTML = "";
            var selectedCertificationUniqueId = SelectedEmpCertID.toString();
            if (selectedCertificationUniqueId.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/DeleteCertificationDetails',
                    type: "POST",
                    data: JSON.stringify(selectedCertificationUniqueId),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#bodyCertification-Details");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedCertificationUniqueId) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedCertificationUniqueId) ? selectedCertificationUniqueId : JSON.stringify(selectedCertificationUniqueId)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //}

                        //StopAjaxLoader("#bodyCertification-Details");
                        CurrentTabObject.Certification = 'false';
                        GetCertifications($("#hdnEmployee_UniqueIDTab").val());
                        CurrentTabObject.Certification = 'true';
                        //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        // strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                        //End of Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterow').html(strHTML);
                        $('#DeleteConfirmMModal').modal('show');
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "OK") {  //200
                            CurrentTabObject.Certification = 'false';
                            GetCertifications($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.Certification = 'true';
                            $('#DeleteConfirmMModal').modal('hide');
                            //alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify("Deleted");
                        }

                        // StopAjaxLoader("#bodyCertification-Details");
                        $('#DeleteConfirmMModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedEmpCertID = [];
            selectedCertificationUniqueId = "";
        }
        //Used from Organization UNIT
        function GetResourceResume(EmployeeID) {
            window.open('../Resources/Resume.aspx?EmployeeID=' + EmployeeID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=850,height=500');
        }
//Added By Nikhil Mane on 3rd July for Download Resume PDF
        var strUrl26 = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        var uiWebRootPath = '<%= Server.MapPath("~").TrimEnd("\"c).Replace("\", "\\") %>';
// Check if it ends with a slash, and slice it off if it does
if (strUrl26.endsWith('/')) {
    strUrl26 = strUrl26.slice(0, -1);
}
function DownloadResumePDF(EmployeeID) {
    alertify.set('notifier', 'position', 'top-right');

    var OuOuParameter = {
        EmployeeID: EmployeeID,
        WebRootPath: uiWebRootPath   // UI app physical path for profile images
    };

    $.ajax({
        url: strUrl26 + '/api/RM_ResourceResume/DownloadResumePDF',
        type: "POST",
        data: JSON.stringify(OuOuParameter),
        contentType: "application/json;charset=utf-8",
        xhrFields: {
            responseType: 'blob'
        },
        beforeSend: function (xhr) {
            xhr.setRequestHeader(
                'Authorization',
                'bearer ' + sessionStorage.getItem("access_token_W26API")
            );
            if (OuOuParameter) {
                xhr.setRequestHeader(
                    "Params",
                    encryptString(isJson(OuOuParameter)
                        ? OuOuParameter
                        : JSON.stringify(OuOuParameter))
                );
            }
        },
        success: function (data) {
            var blob = new Blob([data], { type: 'application/pdf' });
            var url = window.URL.createObjectURL(blob);
            var a = document.createElement('a');
            a.href = url;
            a.download = 'Resume_' + EmployeeID + '.pdf';
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            window.URL.revokeObjectURL(url);

            alertify.success('PDF downloaded successfully.');
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alertify.error('Failed to generate PDF.');
        }
    });
}
//End of Added By Nikhil Mane on 3rd July for Download Resume PDF

        function LoadPagination(tblId, data) {

            $.fn.DataTable.ext.pager.numbers_length = 10;
            $(tblId).dataTable({
                "lengthChange": false,
                "searching": false,
                "sscrolly": (0.5 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                //Added by imran on 18-08-2022
                pageLength: 10,
                //End of comment by imran on 18-08-2022
            });

        }

        //Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
        var isVendorMandatory = true;
        function setVendorMandatoryConfiguration(isMandatory) {
            isVendorMandatory = isMandatory === true || isMandatory === 1 || isMandatory === "1" || String(isMandatory).toLowerCase() === "true";
            if (isVendorMandatory) {
                $("#lblVendor").addClass("required");
            }
            else {
                $("#lblVendor").removeClass("required");
            }
        }
        //End of Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag

        function editEmployee(EmployeeID) {
            var status = '';
            var strHTML = "";
            StartLoader("#body-tblEmplyee");
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetEmployeeDetails',
                type: "POST",
                data: JSON.stringify(EmployeeID),//JSON.stringify(EmployeeParams),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (EmployeeID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(EmployeeID) ? EmployeeID : JSON.stringify(EmployeeID)));
                    }
                },
                success: function (data) {

                    var MEData = data;
                    $("#txtEmployeeName").val(MEData.EmployeeName);
                    //   document.getElementById("deployable").value = MEData.Deployable;
                    $("#txtBirthDate").val(MEData.BirthDate);
                    $("#txtEmail").val(MEData.Email);
                    $("#txtUserName").val(MEData.UserName);
                    $("#cboGender").val(MEData.Gender);//check
                    $("#txtJoiningDate").val(MEData.JoiningDate);
                    if (MEData.IsLDAPAuthntication == true) {

                        $("#LDAPAuthnticationCheckbox").prop("checked", true);
                        //$("#LDAPAuthnticationCheckbox").val(MEData.IsLDAPAuthentication);//check
                    }
                    else { $("#LDAPAuthnticationCheckbox").prop("checked", false); }

                    $("#txtEmployeeCode").val(MEData.EmployeeCode);
                    $("#cboBloodGroup").val(MEData.BloodGroup);//check
                    $("#cboDepartmentUnit").val(MEData.DepartmentID);
                    $("#cboRole").val(MEData.RoleID);
                    $("#cboDesignation").val(MEData.DesignationID);
                    $("#cboEmployeeType").val(MEData.EmployeeType); //change this
                    //Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
                    setVendorMandatoryConfiguration(MEData.IsVendorMandatory);
                    //End of Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
                    // Added by Dipali V on 6th May 2026 for vendor management - API/SP returns active vendors plus mapped inactive vendor for edit mode
                    FillVendorDropdown(MEData.VendorID, MEData.VendorID);


                    $("#cboReportingTo").val(MEData.ReportingTo);
                    //Commented And Added By Reshma Chavan on 6th Dec 2021 for getting Placeholder
                    if (MEData.GradeID == 0) {
                        MEData.GradeID = '';
                    }
                    $("#cboGrade").val(MEData.GradeID);
                    //if (MEData.GradeID == 0) {
                    //    BindPlaceholder("cboGrade", "Grade");
                    //}
                    //else {
                    //    $("#cboGrade").val(MEData.GradeID);
                    //}
                    //End of Commented And Added By Reshma Chavan on 12th oct 2021 for getting Placeholder
                    // $("#cboBG").val(MEData.BusinessGroupID);

                    $("#cboOU").val(MEData.LocationID);//$("#cboOU").val(MEData.ResourcePoolID);

                    //Commented And Added By Reshma Chavan on 6th Dec 2021 for getting Placeholder
                    if (MEData.FacilityID == 0) {
                        MEData.FacilityID = '';
                    }
                    $("#cboFacility").val(MEData.FacilityID);
                    //if (MEData.FacilityID == 0) {
                    //    BindPlaceholder("cboFacility", "Facility");
                    //}
                    //else {
                    //    $("#cboFacility").val(MEData.FacilityID);
                    //}
                    //End of Commented And Added By Reshma Chavan on 14th oct 2021 for getting Placeholder

                    $("#cboDU").val(MEData.GroupID);//$("#cboDU").val(MEData.DeliveryUnitId); //delivery unit
                    $("#cboDT").val(MEData.ResourcePoolID);// $("#cboDT").val(MEData.DeliveryTeamId); //delivery team
                    $("#txtExtensionNo").val(MEData.ExtensionNo);
                    $("#txtRatePerHr").val(MEData.RatePerHr);
                    $("#txtCostPerHr").val(MEData.CostPerHr);
                    $("#txtCostToCompany").val(MEData.CostToCompany);
                    $("#cboCurrency").val(MEData.CurrencyID);
                    //$("#txtTLeavingDate").val(MEData.TentativeLeavingDate);
                    if (MEData.TentativeLeavingDate == "01 January 1900") {
                        MEData.TentativeLeavingDate = " ";
                    }
                    else {
                        $("#txtTLeavingDate").val(MEData.TentativeLeavingDate);
                    }
                    if (MEData.LeavingDate == '' || MEData.LeavingDate == null || MEData.LeavingDate == '01 January 1900') {
                        MEData.LeavingDate = " ";
                        // $('#btnaReleasePopup').removeClass("clsShowHide"); 
                        $("#btnaReleasePopup").show();
                        //Added By Reshma Chavan on 28 jan 2022 for hide Reassign button if resource is active
                        if (MEData.Status == "0") {
                            $('#btnReassign').hide();
                        }
                        //End of Added By Reshma Chavan on 28 jan 2022 for hide Reassign button if resource is active
                    }
                    else {
                        $("#txtLeavingDate").val(MEData.LeavingDate);
                        $("#btnaReleasePopup").hide();
                        //Added By Reshma Chavan on 28 jan 2022 for Show Reassign button if resource is inactive
                        if (MEData.Status == "1") {
                            $('#btnReassign').show();
                        }
                        //End of Added By Reshma Chavan on 28 jan 2022 for Show Reassign button if resource is inactive
                        //$('#btnaReleasePopup').addClass("clsShowHide"); 
                    }

                    $("#txtLeavingDate").attr("disabled", true);
                    $("#txtUserName").attr("disabled", true);
                    $('#btnaReleasePopup').removeClass("clsShowHide");
                    $(".hideLeave").removeClass("clsShowHide");
                    $(".hideTLeave").removeClass("clsShowHide");
                    $("#txtMessangerID").val(MEData.MessangerID); //check
                    FillBG(0, MEData.BusinessGroupID);
                    FillOU(MEData.BusinessGroupID, MEData.LocationID);
                    FillDU(MEData.LocationID, MEData.ResourcePoolID);
                    FillDT(MEData.ResourcePoolID, MEData.GroupID);


                    $("#cboDeployable").val(MEData.Deployable);
                    if (MEData.ProfilePicURL == "") {
                        $(".profile-pic").attr("src", "../../../Whizible2.0-new/dist/img/blankprofile.png");
                    }
                    else {
                        $(".profile-pic").attr("src", MEData.ProfilePicURL);
                        $("#hiddenProfilePath").val(MEData.ProfilePicURL);
                    }
                    $("#Empstatus").val(MEData.Status);
                    $(".newStatus").text(MEData.StatusNew);

                    //tb2
                    $("#txtCurrentAddress").val(MEData.CurrentAddress);
                    $("#txtCurrentPinCode").val(MEData.CurrentPinCode);
                    $("#txtCurrentPhone").val(MEData.CurrentPhone);
                    $("#txtCurrentCity").val(MEData.CurrentCity);
                    $("#txtCurrentState").val(MEData.CurrentState);

                    $("#txtAddresss").val(MEData.Address);
                    $("#txtPinCode").val(MEData.PinCode);
                    $("#txtPhone").val(MEData.Phone);
                    $("#txtCity").val(MEData.City);
                    $("#txtState").val(MEData.State);

                    $("#txtPassportNumber").val(MEData.PassportNumber);
                    $("#txtPlaceOfIssue").val(MEData.PP_PlaceOfIssue);
                    //Added By Rutuja D. on 10 Aug 2021 For Remove Default Display date 01 January 1900
                    if (MEData.PP_DateOfIssue == "01 January 1900") {
                        MEData.PP_DateOfIssue = " ";
                    }
                    if (MEData.PP_ExpiryDate == "01 January 1900") {
                        MEData.PP_ExpiryDate = " ";
                    }
                    if (MEData.NoofPagesLeft == 0) {
                        MEData.NoofPagesLeft = "";
                    }
                    //End of Added By Rutuja D. on 10 Aug 2021 For Remove Default Display date 01 January 1900
                    $("#Issuedate").val(MEData.PP_DateOfIssue);
                    $("#Expirydate").val(MEData.PP_ExpiryDate);
                    $("#txtPPFullName").val(MEData.PP_FullName);
                    $("#txtPPRelativeName").val(MEData.PP_RelativeName);
                    $("#txtNoofPagesLeft").val(MEData.NoofPagesLeft);
                    checkPermanantAddressSame();
                    FillGroups($("#hdnEmployee_UniqueIDTab").val(), SessionLoginType);
                    GetCostList($("#hdnEmployee_UniqueIDTab").val());
                    //Added By Rutuja D.on 12th oct 2021 For Tooltip Issue
                    OnHoverBindTooltipValue(1);
                    //End of Added By Rutuja D.on 12th oct 2021 For Tooltip Issue

                    StopAjaxLoader("#body-tblEmplyee");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
            FillSkills(EmployeeID, 0); //Added by Chetan M on 4 Aug 2021
        }

        // Added by Dipali V on 6th May 2026 for vendor management - fill vendor dropdown through API/SP, include mapped inactive vendor only for edit mode
        function FillVendorDropdown(includeVendorID, selectedVendorID) {
            var vendorParams = { IncludeVendorID: includeVendorID || 0 };
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetVendorDropdown',
                type: "POST",
                data: JSON.stringify(vendorParams),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (vendorParams) {
                        xhr.setRequestHeader("Params", encryptString(isJson(vendorParams) ? vendorParams : JSON.stringify(vendorParams)));
                    }
                },
                success: function (data) {
                    var options = "";
                    for (var i = 0; i < data.length; i++) {
                        options += "<option value='" + data[i].VendorID + "'>" + data[i].VendorName + "</option>";
                    }
                    $("#cboVendor").html(options);
                    BindPlaceholder("cboVendor", "Vendor");
                    if (selectedVendorID && parseInt(selectedVendorID, 10) > 0) {
                        $("#cboVendor").val(selectedVendorID);
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
            });
        }

        //Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
        function GetVendorMandatoryFlag() {            
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetVendorMandatoryConfig',
                type: "POST",
                data: '',
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    //if (vendorMandatoryConfigParams) {
                        //xhr.setRequestHeader("Params", encryptString(isJson(vendorMandatoryConfigParams) ? vendorMandatoryConfigParams : JSON.stringify(vendorMandatoryConfigParams)));
                    //}
                },
                success: function (data) {
                    setVendorMandatoryConfiguration(data);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
            });
        }
        //End of Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag

        function checkPermanantAddressSame() {
            //Commented and added by Chetan M on 9 Aug 2021
            //if (($("#txtCurrentAddress").val() == $("#txtAddresss").val() && $("#txtCurrentAddress").val() != '' && $("#txtAddresss").val() != '')
            //    && ($("#txtCurrentPinCode").val() == $("#txtPinCode").val() && $("#txtCurrentPinCode").val() != '' && $("#txtPinCode").val() != '')
            //    && ($("#txtCurrentPhone").val() == $("#txtPhone").val() && $("#txtCurrentPhone").val() != '' && $("#txtPhone").val() != '')
            //    && $("#txtCurrentCity").val() == $("#txtCity").val() && $("#txtCurrentCity").val() != '' && $("#txtCity").val() != ''
            //    && $("#txtCurrentState").val() == $("#txtState").val() && $("#txtCurrentState").val() != '' && $("#txtState").val() != '') {
            if (($("#txtCurrentAddress").val() == $("#txtAddresss").val() && $("#txtCurrentAddress").val() != '' && $("#txtAddresss").val() != '')
                && ($("#txtCurrentPinCode").val() == $("#txtPinCode").val())
                && ($("#txtCurrentPhone").val() == $("#txtPhone").val())
                && $("#txtCurrentCity").val() == $("#txtCity").val()
                && $("#txtCurrentState").val() == $("#txtState").val()) {
                //End of Commented and added by Chetan M on 9 Aug 2021
                $("#MECurrentAddressCheck").prop("checked", true);
            }
            else {
                $("#MECurrentAddressCheck").prop("checked", false);
            }
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
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.error(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(thrownError);
                    }
                }
            })

        }

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();

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
        function convert(str) {
            var date = new Date(str),
                mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                day = ("0" + date.getDate()).slice(-2);
            return [date.getFullYear(), mnth, day].join("-"); txt
        }
        //datepicker
        $('#MEdetailCurrencydate, #txtJoiningDate, #txtBirthDate,#txtCertificationDate,#txtValidUpto, MEBirthdateinput2,#txtLeavingDate,#TxtReleaseLeavingDate, #txtTLeavingDate, #Issuedate, #Expirydate, #MECertDate, #MECostEffectiveDate, #MEValidDate, #MEvalidFromDate, #MEvalidToDate, #MEPWEFromDate, #MEPWEtillDate, #txtEmpFilterBirthDate, #txtEmpFilterJoiningDate, #txtEmpFilterPP_ExpiryDate, #TxtProReleaseDate, #TxtLeavingDate,#txtEmpFilterPP_DateOfIssue').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            yearRange: '-115:+10',
            dateFormat: 'dd M yy',
            
        });

        //Added by Aditya J. on 28-07-2026 for employee master datepicker issue
        var $empReleaseModal = $('#EPReleasemodal');
        var $empReleaseDpFields = $('#TxtProReleaseDate, #TxtReleaseLeavingDate');
        var empReleaseModalElement = $empReleaseModal.get(0);

        $empReleaseModal.attr('data-focus', 'false');
        $empReleaseModal.attr('data-bs-focus', 'false');

        $empReleaseDpFields.each(function () {
            if ($(this).hasClass('hasDatepicker')) {
                $(this).datepicker('destroy');
            }
        });

        function positionEmpReleaseDatepickerToInput($input) {
            var $dp = $('#ui-datepicker-div');
            if (!$input || !$input.length || !$dp.length) return;
            $dp.css({ zIndex: 10050 });
            $dp.position({
                my: 'left top',
                at: 'left bottom',
                of: $input,
                collision: 'fit flip'
            });
        }

        $empReleaseDpFields.datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: '-115:+10',
            dateFormat: 'dd M yy',
            showOn: 'none',
            beforeShow: function (input, inst) {
                setTimeout(function () {
                    inst.dpDiv.css({ 'z-index': 10050 });
                    positionEmpReleaseDatepickerToInput($(input));
                }, 0);
            },
            onChangeMonthYear: function () {
                var $input = $(this);
                setTimeout(function () {
                    positionEmpReleaseDatepickerToInput($input);
                }, 0);
            }
        });

        function openEmpReleaseDatepicker($input) {
            if (!$input || !$input.length) return;
            hideEmpReleaseDatepickers();
            $input.datepicker('show');
            setTimeout(function () {
                positionEmpReleaseDatepickerToInput($input);
            }, 0);
        }

        $empReleaseDpFields.off('click.empReleaseDp').on('click.empReleaseDp', function () {
            openEmpReleaseDatepicker($(this));
        });

        $empReleaseModal.off('click.empReleaseDp', '.btncalendar').on('click.empReleaseDp', '.btncalendar', function (e) {
            e.preventDefault();
            e.stopPropagation();
            var $input = $(this).closest('.form-group').find('#TxtProReleaseDate, #TxtReleaseLeavingDate').first();
            if ($input.length) {
                openEmpReleaseDatepicker($input);
            }
        });

        function hideEmpReleaseDatepickers() {
            $empReleaseDpFields.each(function () {
                if ($(this).hasClass('hasDatepicker')) {
                    $(this).datepicker('hide');
                }
            });
        }

        $empReleaseModal.on('show.bs.modal shown.bs.modal', function () {
            var modalInstance = $empReleaseModal.data('bs.modal');
            if (modalInstance && modalInstance._config) {
                modalInstance._config.focus = false;
            }
            if (window.bootstrap && bootstrap.Modal) {
                var bs5ModalInstance = bootstrap.Modal.getInstance(this);
                if (bs5ModalInstance && bs5ModalInstance._config) {
                    bs5ModalInstance._config.focus = false;
                }
            }
        });

        $empReleaseModal.find('.modal-body').off('scroll.empReleaseDp').on('scroll.empReleaseDp', function () {
            hideEmpReleaseDatepickers();
        });

        $(window).off('scroll.empReleaseDp').on('scroll.empReleaseDp', function () {
            hideEmpReleaseDatepickers();
        });

        $(window).off('wheel.empReleaseDp mousewheel.empReleaseDp DOMMouseScroll.empReleaseDp touchmove.empReleaseDp')
            .on('wheel.empReleaseDp mousewheel.empReleaseDp DOMMouseScroll.empReleaseDp touchmove.empReleaseDp', function () {
                hideEmpReleaseDatepickers();
            });

        $(document).off('mousedown.empReleaseDp').on('mousedown.empReleaseDp', function (e) {
            var $target = $(e.target);
            if (!$target.closest('#TxtProReleaseDate, #TxtReleaseLeavingDate, #ui-datepicker-div, .ui-datepicker, .btncalendar').length) {
                hideEmpReleaseDatepickers();
            }
        });

        if (empReleaseModalElement) {
            if (empReleaseModalElement._empReleaseScrollHandler) {
                empReleaseModalElement.removeEventListener('scroll', empReleaseModalElement._empReleaseScrollHandler, true);
            }
            empReleaseModalElement._empReleaseScrollHandler = function () {
                hideEmpReleaseDatepickers();
            };
            empReleaseModalElement.addEventListener('scroll', empReleaseModalElement._empReleaseScrollHandler, true);
        }
        //End of Added by Aditya J. on 28-07-2026 for employee master datepicker issue

        //$(document).on("mouseout", 'th span, .ui-corner-all', function () {            
        //    $(".tooltip").remove();
        //});

        //$("th span, .ui-corner-all").hover(function () {
        //    $("th span, .ui-corner-all").tooltip('update');
        //}); //added by pradip on 24-3-2023

        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function Field_OnKeyPressPro(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    $("#txtActualScore").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please enter only numeric values.");
                }
            }
            return ret;
        }

        function Field_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    $("#txtTotalScore").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please enter only numeric values.");
                }
            }
            return ret;
        }
        function FillBG(value, param) {
            
            var strHTML = "";
            FillOU(0);
            FillDU(0);
            FillDT(0);
            //if (value > 0) {
            //Added by irman on 23-08-2022
            if ($("#hdnEmployee_UniqueIDTab").val() == "") {
                var objOU = { BusinessGroupID: value, OprID: 0 }
            }
            else {
                var objOU = { BusinessGroupID: value, OprID: $("#hdnEmployee_UniqueIDTab").val() }
            }
            //End of comment by irman on 23-08-2022

            // var objOU = { BusinessGroupID: value }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetBusinessGroups',
                // url: strUrl + '/api/RM_OpportunityRequest/GetOU',                
                type: "POST",
                data: JSON.stringify(objOU),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objOU) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objOU) ? objOU : JSON.stringify(objOU)));
                    }
                },
                success: function (data) {
                    //strHTML += "<option value='0'></option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.BusinessGroupID + ' >' + listComponent.BusinessGroup + '</option>');
                    }
                    $("#cboBG").html(strHTML);
                    //Added By Reshma chavan on 12th Oct 2021 For Placeholder and Tooltip issue
                    BindPlaceholder("cboBG", "Business Group");

                    if (param != null && param > 0 && param != undefined) {
                        $("#cboBG").val(param);
                        BindToolTip("cboBG");
                    }
                    //End of Added By Reshma chavan on 12th Oct 2021 For Placeholder and Tooltip issue

                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
            //}
            //else {
            //    $("#cboBG").html(strHTML);
            //}



        }
        function FillOU(value, param, isChange) {

            var strHTML = "";
            FillDU(0);
            FillDT(0);
            if (value > 0) {
                //Added by imran on 23-08-2022
                if (value == "") {
                    value = "";
                }
                //end of comment by imran on 23-08-2022
                if (isChange == 2) {
                    var objOU = { BusinessGroupID: value }
                }
                else {
                    if ($("#hdnEmployee_UniqueIDTab").val() == "") {
                        var objOU = { BusinessGroupID: value, OprID: 0 }
                    }
                    else {
                        var objOU = { BusinessGroupID: value, OprID: $("#hdnEmployee_UniqueIDTab").val() }
                    }
                }
                //var objOU = { BusinessGroupID: value }
                $.ajax({
                    url: strUrl + '/api/RM_OpportunityRequest/GetBusinessGroupsLocation',
                    // url: strUrl + '/api/RM_OpportunityRequest/GetOU',                
                    type: "POST",
                    data: JSON.stringify(objOU),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (objOU) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objOU) ? objOU : JSON.stringify(objOU)));
                        }
                    },
                    success: function (data) {
                        //strHTML += "<option value='0'></option>";
                        $("#cboOU").html("");
                        for (var i = 0; i < data.length; i++) {
                            var listComponent = data[i];
                            strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');
                        }
                        $("#cboOU").html(strHTML);
                        //Added By Reshma chavan on 12th Oct 2021 For Placeholder and Tooltip issue
                        //Commented By Reshma Chavan on 6th Dec 2021
                        //BindPlaceholder("cboOU", "Organization Unit");                        
                        if (param != null && param > 0 && param != undefined) {
                            $("#cboOU").val(param);
                            BindToolTip("cboOU");
                        }
                        //End of Added By Reshma chavan on 12th Oct 2021 For Placeholder and Tooltip issue
                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    //alertify.notify(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    //StopAjaxLoader("#bodyBusiness-group");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                })
            }
            else {
                $("#cboOU").html(strHTML);
                BindPlaceholder("cboOU", "Organization Unit");

            }



        }

        function FillDU(value, param, isChange) {
            FillDT(0);
            // alert($("#hdnOproppId").val());
            var strHTML = "";
            if (value > 0) {
                if (isChange == 2) {
                    var objDU = { LocationID: value }
                }
                else {
                    if ($("#hdnEmployee_UniqueIDTab").val() == "") {
                        var objDU = { LocationID: value, OprID: 0 }
                    }
                    else {
                        var objDU = { LocationID: value, OprID: $("#hdnEmployee_UniqueIDTab").val() }
                    }
                }
                // var objDU = { LocationID: value }
                $.ajax({
                    url: strUrl + '/api/RM_OpportunityRequest/GetResourcePoolForLocation',
                    type: "POST",
                    data: JSON.stringify(objDU),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (objDU) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objDU) ? objDU : JSON.stringify(objDU)));
                        }
                    },
                    success: function (data) {
                        //strHTML += "<option value='0'></option>";
                        $("#cboDU").html("");
                        for (var i = 0; i < data.length; i++) {
                            var listComponent = data[i];

                            strHTML += ('<option value=' + listComponent.ResourcePoolID + ' >' + listComponent.ResourcePoolName + '</option>');
                        }
                        $("#cboDU").html(strHTML);
                        //Added By Reshma chavan on 12th Oct 2021 For Placeholder and Tooltip issue
                        BindPlaceholder("cboDU", "Delivery Unit");

                        if (param != null && param > 0 && param != undefined) {
                            $("#cboDU").val(param);
                            BindToolTip("cboDU");
                        }
                        //End of Added By Reshma chavan on 12th Oct 2021 For Placeholder and Tooltip issue

                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    //alertify.notify(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    //StopAjaxLoader("#bodyBusiness-group");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                })
            }
            else {
                $("#cboDU").html(strHTML);
                BindPlaceholder("cboDU", "Delivery Unit");
            }


        }

        function FillDT(value, param, isChange) {
            var strHTML = "";
            if (value > 0) {
                if (isChange == 2) {
                    var objDT = { LocationID: value }
                }
                else {
                    if ($("#hdnEmployee_UniqueIDTab").val() == "") {
                        var objDT = { LocationID: value, OprID: 0 }
                    }
                    else {
                        var objDT = { LocationID: value, OprID: $("#hdnEmployee_UniqueIDTab").val() }
                    }
                }
                //var objDT = { LocationID: value }
                $.ajax({
                    url: strUrl + '/api/RM_OpportunityRequest/GetDeliveryTeam',
                    type: "POST",
                    data: JSON.stringify(objDT),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (objDT) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objDT) ? objDT : JSON.stringify(objDT)));
                        }
                    },
                    success: function (data) {
                        // $("#cboDT").empty();
                        //strHTML += "<option value='0'></option>";
                        $("#cboDT").html("");
                        for (var i = 0; i < data.length; i++) {
                            var listComponent = data[i];

                            strHTML += ('<option value=' + listComponent.GroupID + ' >' + listComponent.GroupName + '</option>');

                            //  $("#cboSubType").css({ "class": "form-control selectpicker" });
                        }
                        $("#cboDT").html(strHTML);
                        //Added By Reshma chavan on 12th Oct 2021 For Placeholder and Tooltip issue
                        BindPlaceholder("cboDT", "Delivery Team");
                        if (param != null && param > 0 && param != undefined) {
                            $("#cboDT").val(param);
                            BindToolTip("cboDT");
                        }
                        //End of Added By Reshma chavan on 12th Oct 2021 For Placeholder and Tooltip issue
                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    //alertify.notify(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    //StopAjaxLoader("#bodyBusiness-group");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                })
            }
            else {
                $("#cboDT").html(strHTML);
                BindPlaceholder("cboDT", "Delivery Team");
            }


        }

        $('#txtRatePerHr').keypress(function (event) {
            if ((event.which != 46 || $(this).val().indexOf('.') != -1) &&
                ((event.which < 48 || event.which > 57) &&
                    (event.which != 0 && event.which != 8))) {
                event.preventDefault();
            }

            var text = $(this).val();

            if ((text.indexOf('.') != -1) &&
                (text.substring(text.indexOf('.')).length > 2) &&
                (event.which != 0 && event.which != 8) &&
                ($(this)[0].selectionStart >= text.length - 2)) {
                event.preventDefault();
            }
        });
        $('#txtCostPerHr').keypress(function (event) {
            if ((event.which != 46 || $(this).val().indexOf('.') != -1) &&
                ((event.which < 48 || event.which > 57) &&
                    (event.which != 0 && event.which != 8))) {
                event.preventDefault();
            }

            var text = $(this).val();

            if ((text.indexOf('.') != -1) &&
                (text.substring(text.indexOf('.')).length > 2) &&
                (event.which != 0 && event.which != 8) &&
                ($(this)[0].selectionStart >= text.length - 2)) {
                event.preventDefault();
            }
        });
        $('#txtCostToCompany').keypress(function (event) {
            if ((event.which != 46 || $(this).val().indexOf('.') != -1) &&
                ((event.which < 48 || event.which > 57) &&
                    (event.which != 0 && event.which != 8))) {
                event.preventDefault();
            }

            var text = $(this).val();

            if ((text.indexOf('.') != -1) &&
                (text.substring(text.indexOf('.')).length > 2) &&
                (event.which != 0 && event.which != 8) &&
                ($(this)[0].selectionStart >= text.length - 2)) {
                event.preventDefault();
            }
        });

        //Added By Riddhesh Patil on 10-NOV-2022 
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
        //End of Added By Riddhesh Patil

        var validateflag = false;
        var Chkvalidate = false;
        function checkValidation() {
            var IsFromEdit = $("#hdnEmployee_UniqueIDTab").val();
            var costperhr = $("#txtCostPerHr").val();
            var rateperhr = $("#txtRatePerHr").val();
            var costToCmpny = $("#txtCostToCompany").val();
            var emailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            var today = new Date();
            var T = convert(today);
            var BD = convert($("#txtBirthDate").val());
            var JD = convert($("#txtJoiningDate").val());
            //Added By reshma Chavan on 28th jan 2022
            if ($("#txtLeavingDate").val() != "") {
                var LD = convert($("#txtLeavingDate").val());
            }
            else {
                var LD = "";
            }
            //End of Added By reshma Chavan on 28th jan 2022
            var optimizedBirthday = BD.replace(/-/g, "/");

            var RgxAlaphNumeric = /[/\:*?<>|,"+-]/
            var RgxInvalidMsg = 'ReplaceText cannot contain any of these /\:*?<>|,"+- characters.';
            var iChars = "!`@#$%^&*()+=-[]\\\';,./{}|\":<>?~_";
            var CurrentDate = new Date();
            var TentativeLeavingDate = new Date($("#txtTLeavingDate").val());

            //set date based on birthday at 01:00:00 hours GMT+0100 (CET)
            var myBirthday = new Date(optimizedBirthday);
            // set current day on 01:00:00 hours GMT+0100 (CET)
            var currentDate = new Date().toJSON().slice(0, 10) + ' 01:00:00';
            // calculate age comparing current date and borthday
            var myAge = ~~((Date.now(currentDate) - myBirthday) / (31557600000));

            //Added by Aditya J. on 05-03-2026 for GDPR Field Visibility Settings
            // GDPR: skip mandatory validation for Birth Date, Email, Gender, Employee Type when field is hidden
            var gdpr = typeof gdprCurrentConfig !== 'undefined' ? gdprCurrentConfig : {};
            var birthDateVisible = (gdpr['BirthDate'] !== false && gdpr['BirthDate'] !== 0);
            var emailVisible = (gdpr['Email'] !== false && gdpr['Email'] !== 0);
            var genderVisible = (gdpr['Gender'] !== false && gdpr['Gender'] !== 0);
            var employeeTypeVisible = (gdpr['EmployeeType'] !== false && gdpr['EmployeeType'] !== 0);
            //End of Added by Aditya J. on 05-03-2026 for GDPR Field Visibility Settings

            if (birthDateVisible && ($("#txtBirthDate").val() == undefined || $("#txtBirthDate").val() == "")) {
                $("#txtBirthDate").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'BirthDate' should not left blank.");
                return false;
            }
            else if (birthDateVisible && BD > T) {
                $("#txtBirthDate").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'BirthDate' should not greater than Today's date.");
                return false;
            }
            else if (birthDateVisible && myAge < 18) {
                $("#txtBirthDate").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Employee age should be greater than or equal to 18 years.");
                return false;
            }
            else if (emailVisible && ($("#txtEmail").val() == undefined || $("#txtEmail").val() == "")) {
                $("#txtEmail").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Email' should not left blank.");
                return false;
            }
            else if (emailVisible && ($("#txtEmail").val() == undefined || !($("#txtEmail").val().match(emailformat)))) {
                //alert(emailformat);
                $("#txtEmail").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Please enter a valid email address.'");
                return false;
            }
            else if ($("#txtEmployeeName").val() == undefined || $("#txtEmployeeName").val() == "") {
                $("#txtEmployeeName").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Employee Name' should not left blank.");
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 10-NOV-2022

            //else if ($("#txtEmployeeName").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtEmployeeName").focus();
            //    validateflag = false;
            //    Chkvalidate = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Employee Name cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}

            else if (checkSpecialCharacter($("#txtEmployeeName").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Employee Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtEmployeeName").focus();
                return false;
            }
            //End of Commnet Added By Riddhesh Patil
            else if (($("#cboDeployable").val() == undefined || $("#cboDeployable").val() == "" || $("#cboDeployable").val() == 0)) {
                // $("#cboProject").focus();
                $("#cboDeployable").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Deployable' should not left blank.");
                return false;
            }
            else if ($("#txtUserName").val() == undefined || $("#txtUserName").val() == "") {
                $("#txtUserName").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'User Name' should not left blank.");
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 10-NOV-2022 
            //else if ($("#txtUserName").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtUserName").focus();
            //    validateflag = false;
            //    Chkvalidate = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('User Name cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtUserName").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('User Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtUserName").focus();
                return false;
            }
            //End of Commnet Added By Riddhesh Patil
            else if (genderVisible && ($("#cboGender").val() == undefined || $("#cboGender").val() == "" || $("#cboGender").val() == 0)) {
                $("#cboGender").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Gender' should not left blank.");
                return false;
            }
            else if ($("#txtJoiningDate").val() == undefined || $("#txtJoiningDate").val() == "") {
                $("#txtJoiningDate").focus();
                Chkvalidate = false;
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Joining Date' should not left blank.");
                return false;
            }
            //Added By Reshma Chavan on 28th jan 2022 validation for leaving date while reassign resource
            else if ((LD != undefined && LD != "") && (JD < LD)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Enter Joining Date greater than Leaving Date");
                $("#txtJoiningDate").focus();
                Chkvalidate = false;
                validateflag = false;
                return false;
            }
            //End of Added By Reshma Chavan on 28th jan 2022 validation for leaving date while reassign resource
            else if (JD > T) {

                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Joining Date' should not greater than Today's date.");
                $("#txtJoiningDate").focus();
                validateflag = false;
                Chkvalidate = false;
                return false;
            }
            else if (birthDateVisible && BD > JD) {

                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Birth Date' should not greater than 'Joining Date'.");
                $("#txtJoiningDate").focus();
                validateflag = false;
                Chkvalidate = false;
                return false;
            }

            else if ($("#txtEmployeeCode").val() == undefined || $("#txtEmployeeCode").val() == "") {

                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Employee Code' should not left blank.");
                $("#txtEmployeeCode").focus();
                validateflag = false;
                Chkvalidate = false;
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 10-NOV-2022 
            else if (checkSpecialCharacter($("#txtEmployeeCode").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Employee Code should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtEmployeeCode").focus();
                return false;
            }
            //End of Comment Added By Riddhesh Patil

            else if (($("#cboDepartmentUnit").val() == undefined || $("#cboDepartmentUnit").val() == "" || $("#cboDepartmentUnit").val() == 0)) {

                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Department Unit' should not left blank.");
                $("#cboDepartmentUnit").focus();
                validateflag = false;
                Chkvalidate = false;
                return false;
            }
            else if (($("#cboRole").val() == undefined || $("#cboRole").val() == "" || $("#cboRole").val() == 0)) {
                $("#cboRole").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Role' should not left blank.");
                return false;
            }

            else if (($("#cboDesignation").val() == undefined || $("#cboDesignation").val() == "" || $("#cboDesignation").val() == 0)) {
                $("#cboDesignation").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Designation' should not left blank.");
                return false;
            }
            //Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
            else if (isVendorMandatory && ($("#cboVendor").val() == undefined || $("#cboVendor").val() == "" || $("#cboVendor").val() == 0)) {
                $("#cboVendor").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Vendor' should not left blank.");
                return false;
            }
            //End of Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag

            else if (employeeTypeVisible && ($("#cboEmployeeType").val() == undefined || $("#cboEmployeeType").val() == "" || $("#cboEmployeeType").val() == 0)) {
                $("#cboEmployeeType").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Employee Type' should not left blank.");
                return false;
            }
            else if (($("#cboReportingTo").val() == undefined || $("#cboReportingTo").val() == "" || $("#cboReportingTo").val() == 0)) {
                $("#cboReportingTo").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Reporting To' should not left blank.");
                return false;
            }

            else if ($("#cboBG").val() == undefined || $("#cboBG").val() == "" || $("#cboBG").val() == 0) {
                $("#cboBG").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Business Group' should not left blank.");
                return false;
            }
            else if ($("#cboOU").val() == undefined || $("#cboOU").val() == "" || $("#cboOU").val() == 0) {
                $("#cboOU").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Organization Unit' should not left blank.");
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 10-NOV-2022 
            else if (checkSpecialCharacter($("#txtExtensionNo").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Extension No should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtExtensionNo").focus();
                return false;
            }
            //End of Comment Added By Riddhesh Patil  txtMessangerID

            else if ($("#txtRatePerHr").val() == undefined || $("#txtRatePerHr").val() == "") {
                $("#txtRatePerHr").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Rate Per Hr' should not left blank. ");
                return false;
            }
            else if (rateperhr != null && rateperhr > 99999.99) {
                $("#txtRatePerHr").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Rate per hrs should not greater than 99999.99");
                return false;
            }
            else if ($("#txtCostPerHr").val() == undefined || $("#txtCostPerHr").val() == "") {
                $("#txtCostPerHr").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Cost Per Hr' should not left blank. ");
                return false;
            }
            else if (costperhr != null && costperhr > 99999.99) {
                $("#txtCostPerHr").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Cost per hrs should not greater than 99999.99");
                return false;
            }
            else if ($("#txtCostToCompany").val() == undefined || $("#txtCostToCompany").val() == "") {
                $("#txtCostToCompany").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Cost To Company' should not left blank. ");
                return false;
            }
            else if (costToCmpny != null && costToCmpny > 999999999.99) {
                $("#txtCostToCompany").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Cost To Company' should not greater than 999999999.99");
                return false;
            }

            else if ($("#cboCurrency").val() == undefined || $("#cboCurrency").val() == "" || $("#cboCurrency").val() == 0) {
                $("#cboCurrency").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Currency' should not left blank. ");
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 10-NOV-2022 
            else if (checkSpecialCharacter($("#txtMessangerID").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Messanger ID should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtMessangerID").focus();
                return false;
            }
            //End of Comment Added By Riddhesh Patil  
            else if ((TentativeLeavingDate === undefined && TentativeLeavingDate != "") && (TentativeLeavingDate < CurrentDate)) {
                $("#txtTLeavingDate").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Tentative Leaving Date should be greater than current date. .');
                return false;
            }
            //Added by Chetan M on 2 August 2021 for validation
            else if (TentativeLeavingDate < CurrentDate) {
                $("#txtTLeavingDate").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Tentative Leaving Date should be greater than current date. .');
                return false;
            }
            //End of Added by Chetan M on 2 August 2021 for validation
            else if ($("#txtMessangerID").val().trim().match(RgxAlaphNumeric)) {
                $("#txtMessangerID").focus();
                validateflag = false;
                Chkvalidate = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Messanger ID cannot contain any of these /\:*?<>|,"+- characters.');
                return false;
            }
            else {
                validateflag = true;
                Chkvalidate = true;
                return true;
            }
        }
        function saveimage(EmployeeId, Oldfilename, CreatedBy, FromSave) {
            var data = new FormData();
            var files = $(".file-upload").get(0).files;
            if (files.length > 0) {
                data.append(".file-upload", files[0]);
                data.append("EmployeeId", EmployeeId);
                data.append("OldFileName", Oldfilename);
                data.append("CreatedBy", CreatedBy);
                data.append("FromSave", FromSave);
            }
            $.ajax({
                //url: resolveUrl("~/Admin/HelpSection/AddTextEditorImage/"),
                url: strUrl + '/api/RM_EmployeeMaster/ProfileUpload',
                type: "POST",
                processData: false,
                contentType: false,
                data: data,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                success: function (response) {
                    //code after success
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (er) {
                //    // alert(er);
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire

            });
        }
        var employeeMaster = {
            EmplpoyeeID: "", BirthDate: "", Email: "", EmployeeName: "", Deployable: "",
            UserName: "", Gender: "", JoiningDate: "", IsLDAPAuthntication: "", EmployeeCode: "", BloodGroup: "",
            // Added by Dipali V on 6th May 2026 for vendor management - include VendorID in employee payload
            DepartmentID: "", RoleID: "", DesignationID: "", EmployeeType: "", ReportingTo: "", VendorID: "", GradeID: "",
            CreatedBy: "", ModifiedBy: "", BusinessGroupID: "", LocationID: "", ResourcePoolID: "", GroupID: "", FacilityID: "",
            ExtensionNo: "", CostPerHr: "", RatePerHr: "", CostToCompany: "", CurrencyID: "", TentativeLeavingDate: "", LeavingDate: "", MessangerID: "",
            Address: "", City: "", State: "", PinCode: "", Phone: "", CurrentAddress: "", CurrentCity: "", CurrentState: "", CurrentPinCode: "", CurrentPhone: "",
            PassportNumber: "", PP_PlaceOfIssue: "", PP_DateOfIssue: "", PP_ExpiryDate: "", PP_FullName: "", PP_RelativeName: "", NoofPagesLeft: "", CreatedBy: "", StatusNew: "", Status: ""
        };

        function closeEmployeeOffcanvasIfOpen() {
            // Added to ensure edit panel closes cleanly when used inside Bootstrap offcanvas.
            var $openOffcanvas = $(".Resourcedetailpanel").closest(".offcanvas.show");
            if ($openOffcanvas.length > 0 && typeof bootstrap !== "undefined" && bootstrap.Offcanvas) {
                var offcanvasInstance = bootstrap.Offcanvas.getInstance($openOffcanvas[0]) || new bootstrap.Offcanvas($openOffcanvas[0]);
                offcanvasInstance.hide();
            }
        }

        function cancleEmpDetails() {
            employeeMaster = {};
            //Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
            setVendorMandatoryConfiguration(false);
            //End of Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
            $("#hdnEmployee_UniqueIDTab").val(0);
            $("#txtBirthDate").val("");
            $("#txtEmail").val("");
            $("#txtEmployeeName").val("");
            $("#cboDeployable").val("");
            $("#txtUserName").val("");
            $("#cboGender").val("");
            $("#txtJoiningDate").val("");
            $("#txtEmployeeCode").val("");
            $("#cboBloodGroup").val("");
            $("#cboDepartmentUnit").val("");
            $("#cboRole").val("");
            $("#cboDesignation").val("");
            $("#cboEmployeeType").val("");
            // Added by Dipali V on 6th May 2026 for vendor management - reset Vendor on cancel
            $("#cboVendor").val("");
            FillVendorDropdown(0, 0);
            $("#cboGrade").val("");
            $("#cboBG").val("");
            $("#cboOU").val("");
            $("#cboDU").val("");
            $("#cboDT").val("");
            $("#txtExtensionNo").val("");
            $("#txtRatePerHr").val(0);
            $("#txtCostPerHr").val(0);
            $("#txtCostToCompany").val(0);
            $("#cboCurrency").val("");
            $("#txtTLeavingDate").val("");
            $("#txtLeavingDate").val("");
            $("#txtMessangerID").val("");
            $("#cboReportingTo").val("");
            $("#cboFacility").val("");
            $("#txtAddresss").val("");
            $("#txtCity").val("");
            $("#txtState").val("");
            $("#txtPinCode").val("");
            $("#txtPhone").val("");
            $("#txtCurrentAddress").val("");
            $("#txtCurrentCity").val("");
            $("#txtCurrentState").val("");
            $("#txtCurrentPinCode").val("");
            $("#txtCurrentPhone").val("");
            $("#txtPassportNumber").val("");
            $("#txtPlaceOfIssue").val("");
            $("#Issuedate").val("");
            $("#Expirydate").val("");
            $("#txtPPFullName").val("");
            $("#txtPPRelativeName").val("");
            $("#txtNoofPagesLeft").val("");
            $("#LDAPAuthnticationCheckbox").prop("checked", false);
            $("#txtLeavingDate").attr("disabled", true);
            $("#txtUserName").attr("disabled", false);
            $(".hideLeave").addClass("clsShowHide");
            $(".hideTLeave").addClass("clsShowHide");
            $(".profile-pic").attr("src", "../../../Whizible2.0-new/dist/img/blankprofile.png");
            $('#EmpDetailsTab').click()
            $('#EmpAdvTab').addClass("DisableContent");
            $('#EmpPersonalInfoTab').addClass("DisableContent");
            $('#EmpCostTab').addClass("DisableContent");
            $('#EmpVisaTab').addClass("DisableContent");
            $('#EmpGroupTab').addClass("DisableContent");
            $('#EmpPrevExpTab').addClass("DisableContent");
            $('#EmpPrevAssgnTab').addClass("DisableContent");
            $('#EmpCurrentAsssTab').addClass("DisableContent");
            //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
            $('#EmpAssignmentsTab').addClass("DisableContent");
            //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
            $('#EmpHistoryTab').addClass("DisableContent");
            $('#btnaReleasePopup').addClass("clsShowHide");
            FillBG(0);
            FillOU(0);
            FillDU(0);
            FillDT(0);
            closeEmployeeOffcanvasIfOpen();

        }
        function SaveEmployeeDetails(isFromSaveClick) {


            
            checkValidation();
            if (validateflag == true) {
                // employeeMaster.EmplpoyeeID = $("#hdnEmployee_UniqueIDTab").val();
                employeeMaster.BirthDate = $("#txtBirthDate").val();
                employeeMaster.Email = $("#txtEmail").val().replace(/'/g, "\''");;
                employeeMaster.EmployeeName = $("#txtEmployeeName").val().replace(/'/g, "''");
                employeeMaster.Deployable = $("#cboDeployable").val();
                employeeMaster.UserName = $("#txtUserName").val().replace(/'/g, "\''");
                employeeMaster.Gender = $("#cboGender").val();
                employeeMaster.JoiningDate = $("#txtJoiningDate").val();
                if ($("#LDAPAuthnticationCheckbox").is(':checked')) {
                    employeeMaster.IsLDAPAuthntication = 1;
                } else {
                    employeeMaster.IsLDAPAuthntication = 0;
                }
                employeeMaster.EmployeeCode = $("#txtEmployeeCode").val().replace(/'/g, "\''");
                employeeMaster.BloodGroup = $("#cboBloodGroup").val();
                employeeMaster.DepartmentID = $("#cboDepartmentUnit").val();
                employeeMaster.RoleID = $("#cboRole").val();
                employeeMaster.DesignationID = $("#cboDesignation").val();
                employeeMaster.EmployeeType = $("#cboEmployeeType").val();
                // Added by Dipali V on 6th May 2026 for vendor management - pass VendorID to API
                if ($("#cboVendor").val() == "") {
                    employeeMaster.VendorID = 0;
                }
                else {
                    employeeMaster.VendorID = $("#cboVendor").val();
                }
                


                //Commented and added by imran on 24-08-2022
                //  employeeMaster.GradeID = $("#cboGrade").val();
                if ($("#cboGrade").val() == "") {
                    employeeMaster.GradeID = 0;
                }
                else {
                    employeeMaster.GradeID = $("#cboGrade").val();
                }
                //End of Comment by imran on 24-08-2022

                employeeMaster.BusinessGroupID = $("#cboBG").val();
                employeeMaster.LocationID = $("#cboOU").val();
                //Commented and added by imran on 24-08-2022
                //employeeMaster.ResourcePoolID = $("#cboDU").val();
                if ($("#cboDU").val() == "") {
                    employeeMaster.ResourcePoolID = 0;
                }
                else {
                    employeeMaster.ResourcePoolID = $("#cboDU").val();
                }
                //End of Comment by imran on 24-08-2022

                //Commented and added by imran on 24-08-2022
                //  employeeMaster.GroupID = $("#cboDT").val();
                if ($("#cboDT").val() == "") {
                    employeeMaster.GroupID = 0;
                }
                else {
                    employeeMaster.GroupID = $("#cboDT").val();
                }
                //End of Comment by imran on 24-08-2022


                //Commented and added by imran on 24-08-2022
                //  employeeMaster.FacilityID = $("#cboFacility").val();
                if ($("#cboFacility").val() == "") {
                    employeeMaster.FacilityID = 0;
                }
                else {
                    employeeMaster.FacilityID = $("#cboFacility").val();
                }
                //End of Comment by imran on 24-08-2022

                employeeMaster.ExtensionNo = $("#txtExtensionNo").val().replace(/'/g, "\''");
                employeeMaster.CostPerHr = $("#txtCostPerHr").val();
                employeeMaster.RatePerHr = $("#txtRatePerHr").val();
                employeeMaster.CostToCompany = $("#txtCostToCompany").val();
                employeeMaster.CurrencyID = $("#cboCurrency").val();
                employeeMaster.TentativeLeavingDate = $("#txtTLeavingDate").val();
                employeeMaster.LeavingDate = $("#txtLeavingDate").val();
                employeeMaster.MessangerID = $("#txtMessangerID").val().replace(/'/g, "\''");;
                employeeMaster.ReportingTo = $("#cboReportingTo").val(); //added later
                employeeMaster.CreatedBy = '<%= Session("strUserName") %>';

                //Commented and added by imran on 24-08-2022
                // employeeMaster.Status = $("#Empstatus").val();
                if ($("#Empstatus").val() == "") {
                    employeeMaster.Status = 0;
                }
                else {
                    employeeMaster.Status = $("#Empstatus").val();
                }
                //End of Comment by imran on 24-08-2022

                var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
                if (EmployeeId > 0 && EmployeeId != undefined) {
                    employeeMaster.EmplpoyeeID = EmployeeId
                    //Save Ajax Call
                    $.ajax({
                        url: strUrl + '/api/RM_EmployeeMaster/UpdateEmployee',
                        type: "POST",
                        data: JSON.stringify(employeeMaster),
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                            if (employeeMaster) {
                                xhr.setRequestHeader("Params", encryptString(isJson(employeeMaster) ? employeeMaster : JSON.stringify(employeeMaster)));
                            }
                        },
                        success: function (data) {
                            if (data == "Email ID already exist.") {
                                $("#txtEmail").focus();

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);

                            } else if (data == "Employee Code already exist.") {
                                $("#txtEmployeeCode").focus();

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                if (isFromSaveClick == 0) {
                                    $("#hdnEmployee_UniqueIDTab").val(EmployeeId);

                                    saveimage(EmployeeId, $("#hiddenProfilePath").val(), '<%= Session("strUserName") %>', "0");
                                    GetAllEmployeeList();
                                    $("#srchMElist").val('')
                                    alertify.set('notifier', 'position', 'top-right');
                                    //Added By Reshma Chavan on 11 feb 2022 for save details on Reassign                                   
                                    if (GblReassignFlag == "1") {
                                        ReassignResource();
                                    }
                                    else {
                                        alertify.success(data);
                                    }
                                    GblReassignFlag = "0";
                                    //End of Added By Reshma Chavan on 11 feb 2022 for save details on Reassign 
                                    //$('#EmpDetailsTab').click()
                                    $("#MEListTbl_wrapper .dataTables_scrollBody, #MEListTbl_wrapper, .srchrequest, .backbtn, .addbtn, #MEListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");

                                    $('#EmpAdvTab').removeClass("DisableContent");
                                    $('#EmpPersonalInfoTab').removeClass("DisableContent");
                                    $('#EmpCostTab').removeClass("DisableContent");
                                    $('#EmpVisaTab').removeClass("DisableContent");
                                    $('#EmpGroupTab').removeClass("DisableContent");
                                    $('#EmpPrevExpTab').removeClass("DisableContent");
                                    $('#EmpPrevAssgnTab').removeClass("DisableContent");
                                    $('#EmpCurrentAsssTab').removeClass("DisableContent");
                                    //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
                                    $('#EmpAssignmentsTab').removeClass("DisableContent");
                                    //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
                                    $('#EmpHistoryTab').removeClass("DisableContent");
                                }
                                if (isFromSaveClick == 1) {
                                    cancleEmpDetails();
                                    $("#hdnEmployee_UniqueIDTab").val(0);

                                    saveimage(EmployeeId, $("#hiddenProfilePath").val(), '<%= Session("strUserName") %>', "0");
                                    $("#MEListTbl_wrapper .dataTables_scrollBody, #MEListTbl_wrapper, .srchrequest, .backbtn, .addbtn, #MEListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");

                                    GetAllEmployeeList();
                                    $("#srchMElist").val('')
                                }
                            }

                        },

                        error: function (xhr, ajaxOptions, thrownError) {
                            if (ajaxOptions == "error") {
                                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                                //console.log(thrownError);
                                //alertify.set('notifier', 'position', 'top-right');
                                //alertify.error(xhr.responseJSON.Message);
                                if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                    window.open("../../../Default.aspx", "_top");
                                } else {
                                    window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                }
                                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            }
                            else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                                //CurrentGRPTabObject.GrpManager = 'false';
                                GetAllEmployeeList();
                                $("#srchMElist").val('')
                                // CurrentGRPTabObject.GrpManager = 'true';
                                StopAjaxLoader("#body-GradeMaster");
                            }
                            else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(thrownError);

                            }
                            ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            StopAjaxLoader("#body-GradeMaster");
                            //if (isFromSaveAndclick == 0) {
                            //    $('#Resourcedetailpanel').modal('hide');
                            //}
                        }

                    });
                }
                else {
                    
                    $.ajax({
                        url: strUrl + '/api/RM_EmployeeMaster/SaveEmployee',
                        type: "POST",
                        data: JSON.stringify(employeeMaster),
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                            if (employeeMaster) {
                                xhr.setRequestHeader("Params", encryptString(isJson(employeeMaster) ? employeeMaster : JSON.stringify(employeeMaster)));
                            }
                        },
                        success: function (data) {
                            // Added by Vyankat Bhure on 20-02-2025 - Added null check and error handling for SaveEmployee response
                            try {
                                if (!data) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error("No response received from server.");
                                    StopAjaxLoader("#body-GradeMaster");
                                    return;
                                }

                                // Previous code - commented by Vyankat Bhure on 20-02-2025
                                // Handle response - check if data is wrapped or direct
                                //var employeeId = data.EmployeeID || (data.Id ? parseInt(data.Id) : 0);
                                //var message = data.Message || "";
                                // End of Previous code - commented by Vyankat Bhure on 20-02-2025

                                // Added by Vyankat Bhure on 20-02-2025 - Handle DataSet response with multiple tables
                                var employeeId = 0;
                                var message = "";
                                
                                // Check if response is DataSet format (has Table1, Table2, Table3)
                                // DataTable is serialized as an array in JSON
                                //if (data.Table3 && Array.isArray(data.Table3) && data.Table3.length > 0) {
                                //    // Extract EmployeeID and Message from first row of Table3
                                //    var firstRow = data.Table3[0];
                                //    employeeId = firstRow.Id ? parseInt(firstRow.Id) : (firstRow.EmployeeID ? parseInt(firstRow.EmployeeID) : 0);
                                //    message = firstRow.Message || "";
                                //} else if (data.EmployeeID || data.Id) {
                                //    // Fallback: Handle old response format if SP returns direct object
                                //    employeeId = data.EmployeeID || (data.Id ? parseInt(data.Id) : 0);
                                //    message = data.Message || "";
                                //}

                                var firstRow = null;

                                // Check Table3
                                if (Array.isArray(data.Table3) && data.Table3.length > 0) {
                                    firstRow = data.Table3[0];
                                }
                                // Check Table2
                                else if (Array.isArray(data.Table2) && data.Table2.length > 0) {
                                    firstRow = data.Table2[0];
                                }
                                // Check Table1
                                else if (Array.isArray(data.Table1) && data.Table1.length > 0) {
                                    firstRow = data.Table1[0];
                                }

                                // If row found in any table
                                if (firstRow) {
                                    employeeId = firstRow.Id
                                        ? parseInt(firstRow.Id)
                                        : (firstRow.EmployeeID ? parseInt(firstRow.EmployeeID) : 0);

                                    message = firstRow.Message || "";
                                }
                                // Fallback: old response format
                                else if (data.EmployeeID || data.Id) {
                                    employeeId = data.EmployeeID
                                        ? parseInt(data.EmployeeID)
                                        : (data.Id ? parseInt(data.Id) : 0);

                                    message = data.Message || "";
                                }
                                // End of Added by Vyankat Bhure on 20-02-2025

                                // Previous code - commented by Vyankat Bhure on 20-02-2025
                                //if (data.EmployeeID > 0) {

                                if (employeeId > 0) {
                                if (isFromSaveClick == 0) {
                                    // Previous code - commented by Vyankat Bhure on 20-02-2025
                                    //$("#hdnEmployee_UniqueIDTab").val(data.EmployeeID);
                                    $("#hdnEmployee_UniqueIDTab").val(employeeId);
                                    saveimage(employeeId, "", '<%= Session("strUserName") %>', "1");//  saveimage();
                                    GetAllEmployeeList();
                                    alertify.set('notifier', 'position', 'top-right');
                                    // Previous code - commented by Vyankat Bhure on 20-02-2025
                                    //alertify.success(data.Message);
                                    alertify.success(message);
                                    //$('#EmpDetailsTab').click()
                                    $("#MEListTbl_wrapper .dataTables_scrollBody, #MEListTbl_wrapper, .srchrequest, .backbtn, .addbtn, #MEListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");

                                    $('#EmpAdvTab').removeClass("DisableContent");
                                    $('#EmpPersonalInfoTab').removeClass("DisableContent");
                                    $('#EmpCostTab').removeClass("DisableContent");
                                    $('#EmpVisaTab').removeClass("DisableContent");
                                    $('#EmpGroupTab').removeClass("DisableContent");
                                    $('#EmpPrevExpTab').removeClass("DisableContent");
                                    $('#EmpPrevAssgnTab').removeClass("DisableContent");
                                    $('#EmpCurrentAsssTab').removeClass("DisableContent");
                                    //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
                                    $('#EmpAssignmentsTab').removeClass("DisableContent");
                                    //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
                                    $('#EmpHistoryTab').removeClass("DisableContent");

                                }
                                if (isFromSaveClick == 1) {
                                    cancleEmpDetails();
                                    $("#hdnEmployee_UniqueIDTab").val(0);
                                    // Previous code - commented by Vyankat Bhure on 20-02-2025
                                    //saveimage(data.EmployeeID, "", '<%= Session("strUserName") %>', "1");//  saveimage();
                                    saveimage(employeeId, "", '<%= Session("strUserName") %>', "1");//  saveimage();
                                    $("#MEListTbl_wrapper .dataTables_scrollBody, #MEListTbl_wrapper, .srchrequest, .backbtn, .addbtn, #MEListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");

                                    GetAllEmployeeList();

                                }
                                } else {
                                    // Previous code - commented by Vyankat Bhure on 20-02-2025
                                    //if (data.Message == "Email ID already exist.") {
                                    if (message == "Email ID already exist.") {
                                        $("#txtEmail").focus();
                                    }
                                    // Previous code - commented by Vyankat Bhure on 20-02-2025
                                    //if (data.Message == "User Name already exist.") {
                                    if (message == "User Name already exist.") {
                                        $("#txtUserName").focus();
                                    }
                                    // Previous code - commented by Vyankat Bhure on 20-02-2025
                                    //if (data.Message == "Employee Code already exist.") {
                                    if (message == "Employee Code already exist.") {
                                        $("#txtEmployeeCode").focus();
                                    }
                                    alertify.set('notifier', 'position', 'top-right');
                                    // Previous code - commented by Vyankat Bhure on 20-02-2025
                                    //alertify.error(data.Message);
                                    alertify.error(message || "An error occurred while saving employee.");
                                }
                            } catch (ex) {
                                // Added by Vyankat Bhure on 20-02-2025 - Catch any errors in success handler
                                console.error("Error in SaveEmployee success handler:", ex);
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error("An error occurred while processing the response: " + ex.message);
                                StopAjaxLoader("#body-GradeMaster");
                            }
                            // End of Added by Vyankat Bhure on 20-02-2025
                        },

                        error: function (xhr, ajaxOptions, thrownError) {
                            // Added by Vyankat Bhure on 20-02-2025 - Added null check for responseJSON to prevent errors
                            if (ajaxOptions == "error") {
                                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                                //console.log(thrownError);
                                //alertify.set('notifier', 'position', 'top-right');
                                //alertify.error(xhr.responseJSON.Message);
                                // Previous code - commented by Vyankat Bhure on 20-02-2025
                                //if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                //    window.open("../../../Default.aspx", "_top");
                                //} else {
                                //    window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                //}
                                var errorMessage = (xhr.responseJSON && xhr.responseJSON.Message) ? xhr.responseJSON.Message : (thrownError || "An error occurred");
                                if (errorMessage == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                    window.open("../../../Default.aspx", "_top");
                                } else {
                                    window.location.href = "../../General/default.aspx?Mode=AJAXError&Error=" + encodeURIComponent(errorMessage) + ""
                                }
                                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            }
                            // End of Added by Vyankat Bhure on 20-02-2025
                            else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                                //CurrentGRPTabObject.GrpManager = 'false';
                                GetAllEmployeeList();
                                // CurrentGRPTabObject.GrpManager = 'true';
                                StopAjaxLoader("#body-GradeMaster");
                            }
                            else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(thrownError || "An error occurred");

                            }
                            ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            StopAjaxLoader("#body-GradeMaster");
                            //if (isFromSaveAndclick == 0) {
                            //    $('#Resourcedetailpanel').modal('hide');
                            //}
                        }

                    });
                }
            }
            else {
                return false;
            }
            //Added By Reshma Chavan on 12th oct 2021 For binding tooltip
            OnHoverBindTooltipValue(1);
            //End of Added By Reshma Chavan on 12th oct 2021 For binding tooltip
        }

        $("#MECurrentAddressCheck").on("click", function () {
            if (this.checked) {
                $("#txtAddresss").val($("#txtCurrentAddress").val());
                $("#txtCity").val($("#txtCurrentCity").val());
                $("#txtState").val($("#txtCurrentState").val());
                $("#txtPinCode").val($("#txtCurrentPinCode").val());
                $("#txtPhone").val($("#txtCurrentPhone").val());
            } else {
                $("#txtAddresss").val("");
                $("#txtCity").val("");
                $("#txtState").val("");
                $("#txtPinCode").val("");
                $("#txtPhone").val("");
            }

        });
        $('#txtNoofPagesLeft').keypress(function (event) {
            if (event.which < 48 || event.which > 57) {
                event.preventDefault();
            }
        });

        function saveAdvanceInfo() {

            //var RgxAlaphNumeric = /[/\:*?<>|,"+-=]/
            var RgxAddress = /[\\*?<>|"+=#~!&;{}@%]/
            var AddressMsg = "\\*?<>|+=#~!&;{}@%"
            //var MsgString = ''+-`!@#$%^&*()_+={}[]\|:";'<>?,./~'';
            var iChars = "!`@#$%^&*()+=-[]\\\';,./{}|\":<>?~_";
            var RgxInvalidMsg = 'No of Pages Left cannot contain any of these ' + iChars + ' characters.';
            var RgxAlaphNumeric = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
            // var RgxAlaphNumeric = /^[!@#\$%\^\&*\)\(+=._-]+$/g;
            ////[ `!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/
            //Phone can not contain any of these +-`!@#$%^&*()_+={}[]\|:";'<>?,./~ characters.

            //Comment and Added By Riddhesh Patil on 10-NOV-2022 
            //if ($("#txtCurrentAddress").val().trim().match(RgxAddress)) {
            //     $("#txtCurrentAddress").focus();
            //     alertify.set('notifier', 'position', 'top-right');
            //     alertify.error("Current Address cannot contain any of these " + AddressMsg);
            //     return false;
            // }

            if (checkSpecialCharacter($("#txtCurrentAddress").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Current Address should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtCurrentAddress").focus();
                return false;
            }
            //End of Comment Added By Riddhesh Patil

            //Comment and Added By Riddhesh Patil on 10-NOV-2022 

            //else if ($("#txtAddresss").val().trim().match(RgxAddress)) {
            //    $("#txtAddresss").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    //Commented And Added By Reshma Chavan on 8th Oct 2021 For IssueID-29736
            //    //alertify.error(RgxInvalidMsg.replace("Addresss cannot contain any of these" +AddressMsg));
            //    alertify.error("Addresss cannot contain any of these " + AddressMsg);
            //    //End of Commented And Added By Reshma Chavan on 8th Oct 2021 For IssueID-29736
            //    return false;
            //}

            else if (checkSpecialCharacter($("#txtAddresss").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Address should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtAddresss").focus();
                return false;
            }
            //End of Comment Added By Riddhesh Patil

            //Comment and Added By Riddhesh Patil on 10-NOV-2022 

            //else if ($("#txtCurrentCity").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtCurrentCity").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error(RgxInvalidMsg.replace(/No of Pages Left/g, "Current City"));
            //    return false;
            //}


            else if (checkSpecialCharacter($("#txtCurrentCity").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Current City should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtCurrentCity").focus();
                return false;
            }
            //End of Comment Added By Riddhesh Patil

            //Comment and Added By Riddhesh Patil on 10-NOV-2022 

            //else if ($("#txtCity").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtCity").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error(RgxInvalidMsg.replace(/No of Pages Left/g, "City"));
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtCity").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('City should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtCity").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil

                 //Comment and Added By Riddhesh Patil on 10-NOV-2022 

            //else if ($("#txtCurrentState").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtCurrentState").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error(RgxInvalidMsg.replace(/No of Pages Left/g, "Sate"));
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtCurrentState").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Current State should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtCurrentState").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil

                 //Comment and Added By Riddhesh Patil on 10-NOV-2022

            //else if ($("#txtState").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtState").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error(RgxInvalidMsg.replace(/No of Pages Left/g, "Sate"));
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtState").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('State should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtState").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil

                  //Comment and Added By Riddhesh Patil on 10-NOV-2022

            //else if ($("#txtCurrentPhone").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtCurrentPhone").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error(RgxInvalidMsg.replace(/No of Pages Left/g, "Current Phone"));
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtCurrentPhone").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Current Phone should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtCurrentPhone").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil

                  //Comment and Added By Riddhesh Patil on 10-NOV-2022

            //else if ($("#txtPhone").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtPhone").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error(RgxInvalidMsg.replace(/No of Pages Left/g, "Phone"));
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtPhone").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Phone should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPhone").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil

                 //Comment and Added By Riddhesh Patil on 10-NOV-2022

            //else if ($("#txtPassportNumber").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtPassportNumber").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    //Commented and added by Chetan M on 29 Jul 2021 for wrong alert issue
            //    //alertify.error(RgxInvalidMsg.replace(/ No of Pages Left/g, "Sate"));
            //    alertify.error('Passport No. cannot contain any of these ' + iChars + ' characters.');
            //    //End of Commented and added by Chetan M on 29 Jul 2021 for wrong alert issue
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtPassportNumber").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Passport No. should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPassportNumber").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil

            //else if ($("#txtPPFullName").val() == undefined || $("#txtPPFullName").val() == "") {
            //     $("#txtPPFullName").focus();
            //     alertify.set('notifier', 'position', 'top-right');
            //     alertify.error('Full Name should not left blank.');
            //     return false;
            // }

                 //Comment and Added By Riddhesh Patil on 10-NOV-2022

            //else if ($("#txtPPFullName").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtPPFullName").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error(RgxInvalidMsg.replace(/No of Pages Left/g, "Full Name"));
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtPPFullName").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Full Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPPFullName").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil

                 //Comment and Added By Riddhesh Patil on 10-NOV-2022

            //else if ($("#txtPPRelativeName").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtPPRelativeName").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error(RgxInvalidMsg.replace(/No of Pages Left/g, "Son/Wife/Daughter of"));
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtPPRelativeName").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Son/Wife/Daughter of should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPPRelativeName").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil

                 //Comment and Added By Riddhesh Patil on 10-NOV-2022

            //else if ($("#txtPlaceOfIssue").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtPlaceOfIssue").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error(RgxInvalidMsg.replace(/No of Pages Left/g, "Place Of Issue"));
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtPlaceOfIssue").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Place Of Issue should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPlaceOfIssue").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil
            //else if ($("#txtNoofPagesLeft").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtNoofPagesLeft").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('No of Pages Left cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
            //Added By Rutuja D. For Restrict Single quotes


                 //Comment and Added By Riddhesh Patil on 10-NOV-2022

            //else if ($("#txtCurrentPinCode").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtCurrentPinCode").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error(RgxInvalidMsg.replace(/No of Pages Left/g, "Current Pin Code"));
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtCurrentPinCode").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Current Pin Code should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtCurrentPinCode").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil

                //Comment and Added By Riddhesh Patil on 10-NOV-2022

            //else if ($("#txtPinCode").val().trim().match(RgxAlaphNumeric)) {
            //    $("#txtPinCode").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error(RgxInvalidMsg.replace(/No of Pages Left/g, "Permanant Pin Code"));
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtPinCode").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Pin Code should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPinCode").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil
            //End of Added By Rutuja D. For Restrict Single quotes
            //Added By Rutuja D. on 12 Oct 2021 For Validation Missing
            else if (Date.parse($('#Issuedate').val()) > Date.parse($('#Expirydate').val())) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Expiary Date' should not be less than 'Issue Date' ");
                $("#Expirydate").focus();
                return false;
            }
            //End of Added By Rutuja D. on 12 Oct 2021 For Validation Missing

            else {
                //Added by imran on 24-08-2022 because when save without below info it will give validate header error
                employeeMaster.BirthDate = $("#txtBirthDate").val();
                employeeMaster.Email = $("#txtEmail").val().replace(/'/g, "\''");;
                employeeMaster.EmployeeName = $("#txtEmployeeName").val().replace(/'/g, "''");
                employeeMaster.Deployable = $("#cboDeployable").val();
                employeeMaster.UserName = $("#txtUserName").val().replace(/'/g, "\''");
                employeeMaster.Gender = $("#cboGender").val();
                employeeMaster.JoiningDate = $("#txtJoiningDate").val();
                if ($("#LDAPAuthnticationCheckbox").is(':checked')) {
                    employeeMaster.IsLDAPAuthntication = 1;
                } else {
                    employeeMaster.IsLDAPAuthntication = 0;
                }
                employeeMaster.EmployeeCode = $("#txtEmployeeCode").val().replace(/'/g, "\''");
                employeeMaster.BloodGroup = $("#cboBloodGroup").val();
                employeeMaster.DepartmentID = $("#cboDepartmentUnit").val();
                employeeMaster.RoleID = $("#cboRole").val();
                employeeMaster.DesignationID = $("#cboDesignation").val();
                employeeMaster.EmployeeType = $("#cboEmployeeType").val();
                // Added by Dipali V on 6th May 2026 for vendor management - pass VendorID to API
                
                if ($("#cboVendor").val() == "") {
                    employeeMaster.VendorID = 0;
                }
                else {
                    employeeMaster.VendorID = $("#cboVendor").val();
                }

                if ($("#cboGrade").val() == "") {
                    employeeMaster.GradeID = 0;
                }
                else {
                    employeeMaster.GradeID = $("#cboGrade").val();
                }
                employeeMaster.BusinessGroupID = $("#cboBG").val();
                employeeMaster.LocationID = $("#cboOU").val();
                if ($("#cboDU").val() == "") {
                    employeeMaster.ResourcePoolID = 0;
                }
                else {
                    employeeMaster.ResourcePoolID = $("#cboDU").val();
                }
                if ($("#cboDT").val() == "") {
                    employeeMaster.GroupID = 0;
                }
                else {
                    employeeMaster.GroupID = $("#cboDT").val();
                }
                if ($("#cboFacility").val() == "") {
                    employeeMaster.FacilityID = 0;
                }
                else {
                    employeeMaster.FacilityID = $("#cboFacility").val();
                }
                employeeMaster.ExtensionNo = $("#txtExtensionNo").val().replace(/'/g, "\''");
                employeeMaster.CostPerHr = $("#txtCostPerHr").val();
                employeeMaster.RatePerHr = $("#txtRatePerHr").val();
                employeeMaster.CostToCompany = $("#txtCostToCompany").val();
                employeeMaster.CurrencyID = $("#cboCurrency").val();
                employeeMaster.TentativeLeavingDate = $("#txtTLeavingDate").val();
                employeeMaster.LeavingDate = $("#txtLeavingDate").val();
                employeeMaster.MessangerID = $("#txtMessangerID").val().replace(/'/g, "\''");;
                employeeMaster.ReportingTo = $("#cboReportingTo").val(); //added later
                employeeMaster.CreatedBy = '<%= Session("strUserName") %>';
                if ($("#Empstatus").val() == "") {
                    employeeMaster.Status = 0;
                }
                else {
                    employeeMaster.Status = $("#Empstatus").val();
                }
                //End of comment by imran on 24-08-2022


                employeeMaster.EmplpoyeeID = $("#hdnEmployee_UniqueIDTab").val();
                employeeMaster.Address = $("#txtAddresss").val().replace(/'/g, "\''");
                employeeMaster.City = $("#txtCity").val();
                employeeMaster.State = $("#txtState").val();
                employeeMaster.PinCode = $("#txtPinCode").val();
                employeeMaster.Phone = $("#txtPhone").val();
                employeeMaster.CurrentAddress = $("#txtCurrentAddress").val().replace(/'/g, "\''");
                employeeMaster.CurrentCity = $("#txtCurrentCity").val();
                employeeMaster.CurrentState = $("#txtCurrentState").val();
                employeeMaster.CurrentPinCode = $("#txtCurrentPinCode").val();
                employeeMaster.CurrentPhone = $("#txtCurrentPhone").val();
                employeeMaster.PassportNumber = $("#txtPassportNumber").val();
                employeeMaster.PP_PlaceOfIssue = $("#txtPlaceOfIssue").val().replace(/'/g, "\''");
                employeeMaster.PP_DateOfIssue = $("#Issuedate").val();
                employeeMaster.PP_ExpiryDate = $("#Expirydate").val();
                employeeMaster.PP_FullName = $("#txtPPFullName").val();
                employeeMaster.PP_RelativeName = $("#txtPPRelativeName").val();
                employeeMaster.NoofPagesLeft = $("#txtNoofPagesLeft").val();

                //Save Ajax Call
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/SaveAdvanceInfo',
                    type: "POST",
                    data: JSON.stringify(employeeMaster),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (employeeMaster) {
                            xhr.setRequestHeader("Params", encryptString(isJson(employeeMaster) ? employeeMaster : JSON.stringify(employeeMaster)));
                        }
                    },
                    success: function (data) {
                        // $("#MECurrentAddressCheck").prop("checked", false)
                        checkPermanantAddressSame();
                        GetAllEmployeeList(null);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(data);

                    },

                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            //CurrentGRPTabObject.GrpManager = 'false';
                            GetAllEmployeeList(null);
                            // CurrentGRPTabObject.GrpManager = 'true';
                            StopAjaxLoader("#body-GradeMaster");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        StopAjaxLoader("#body-GradeMaster");
                        //if (isFromSaveAndclick == 0) {
                        //    $('#Resourcedetailpanel').modal('hide');
                        //}
                    }

                })
                // }
                // else {
                //     return false;
                // }
                //Added By Rutuja D. on 12th Oct 2021 For Tooltip issue
                OnHoverBindTooltipValue(1);
            }
        }

        function addEmployee() {
            //Added By reshma chavan on 14th Oct 2021 For tooltip change
            OnHoverBindTooltipValue(0);
            //End of Added By reshma chavan on 14th Oct 2021 For tooltip change
            $("#hdnEmployee_UniqueIDTab").val(0);
            $(".newStatus").text("Active");
            cancleEmpDetails();
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $("#MEListTbl_wrapper .dataTables_scrollBody, #MEListTbl_wrapper, .srchrequest, .backbtn, .addbtn, #MEListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            $('#EmpDetailsTab').click()
            //Added By Reshma Chavan on 6th Dec 2021 for duplicate placeholder change
            $("#cboCurrency").val(0);
            //Added By Dipali V On 7th Feb 2022 while adding resource reasign button should not display
            $("#btnReassign").hide();
            //End of Added By Reshma Chavan on 6th Dec 2021 for duplicate placeholder change
            //Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
            GetVendorMandatoryFlag();
            //End of Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag

        }
        function editME() { }
        //function editME() {

        //$(".dataTables_scrollBody").css("height", "auto!important");            
        $("#tblBusinessGroups").on('click', '.BGdetalilink', function () {
            var $row = $(this).closest("tr");
            $tds = $row.find("td");
            var hdnEmpID = $row.find('#hdnrm_employeeid').val();
            $('#hdnEmployee_UniqueIDTab').val(hdnEmpID);

            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $("#MEListTbl_wrapper .dataTables_scrollBody, #MEListTbl_wrapper, .srchrequest, .backbtn, .addbtn, #MEListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");

            //$.each($tds, function (index, obj) {
            //    var hiddenField = $(this).find("input[type='hidden']").val();
            //    if (hiddenField != 'undefined' && hiddenField != null) {
            //        var eventId = hiddenField;
            //    }
            //    $(".Resourcedetailpanel").show();
            //    $('html,body').animate({
            //        scrollTop: $(".Resourcedetailpanel").offset().top - 60
            //    }, 'slow');
            //    //used for disable grid
            //    $("#MEListTbl_wrapper .dataTables_scrollBody, #MEListTbl_wrapper, .srchrequest, .backbtn, .addbtn, #MEListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            //    //setTimeout(function () {
            //    //    $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            //    //}, 0);

            //    // editEmployee(hdnEmpID);
            //});
            editEmployee(hdnEmpID);
            $('#EmpDetailsTab').click()
            $('#EmpAdvTab').removeClass("DisableContent");
            $('#EmpPersonalInfoTab').removeClass("DisableContent");
            $('#EmpCostTab').removeClass("DisableContent");
            $('#EmpVisaTab').removeClass("DisableContent");
            $('#EmpGroupTab').removeClass("DisableContent");
            $('#EmpPrevExpTab').removeClass("DisableContent");
            $('#EmpPrevAssgnTab').removeClass("DisableContent");
            $('#EmpCurrentAsssTab').removeClass("DisableContent");
            //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
            $('#EmpAssignmentsTab').removeClass("DisableContent");
            //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
            $('#EmpHistoryTab').removeClass("DisableContent");
        });
        ///}

        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#MEListTbl_wrapper .dataTables_scrollBody, #MEListTbl_wrapper, .srchrequest, .backbtn, .addbtn, #MEListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            CurrentTabObject = { Details: 'false', Certification: 'false', PreviousAssignment: 'false', PreviousWorkExperience: 'false', VisaDetails: 'false', Cost: 'false', History: 'false', Qualification: 'false', Skill: 'false', Groups: 'false', CurrentAssignment: 'false' }
        });

        $('#MECrtTbl, #photouploadtbl, #empsubtabCosttbl, emsubtabVisaTbl, #emsubtabVisaTbl, #emsubtabQualTbl, #emsubtabQualTbl, #emsubtabGroupTbl, #emsubtabprewrkTbl, #emtabpreAssign, #emsubtabSkillTbl, #emsubtabCurrentAsignmentTbl, #emsubtabShowHistoryTbl').dataTable({
            //"ajax": '/api/data',
            "scrollY": '220px',
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
            "bFilter": false,
            "ordering": false,
        });



        $('#EPRTblList').dataTable({
            //"ajax": '/api/data',
            "scrollY": '200px',
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
            "bFilter": false,
            "ordering": false,
            "scrollCollapse": true

        });


        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        $('#MEListTbl').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".panel-collapse").on('shown.bs.collapse', function () {
            var targetId = $(this).attr('id');
            var $toggle = $('.personal-info-accordion-toggle[data-bs-target="#' + targetId + '"]');
            $toggle.attr('aria-expanded', 'true');
            $toggle.find('.personal-info-accordion-icon').removeClass('fa-chevron-down').addClass('fa-chevron-up');
        });
        $(".panel-collapse").on('hidden.bs.collapse', function () {
            var targetId = $(this).attr('id');
            var $toggle = $('.personal-info-accordion-toggle[data-bs-target="#' + targetId + '"]');
            $toggle.attr('aria-expanded', 'false');
            $toggle.find('.personal-info-accordion-icon').removeClass('fa-chevron-up').addClass('fa-chevron-down');
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            //$(".table").resize();

            //$.fn.dataTable.tables({ visible: true, api: true })
            //    .columns.adjust()
            //    .fixedColumns().relayout()
            //    .responsive.recalc();
        });

        $('#PRTblList').on('show.bs.modal', function () {
            $(".table").resize();
        });
        $('#EPReleasemodal').on('show.bs.modal', function () {
            $("#EPRTblList_wrapper table").resize();

        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('#MEListTbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 240, "overflow-y": "auto" });

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

        function mysearchFunction() {
            var SearchText = $("#srchMElist").val();
            var strHTML = "";

            var FilterTitle = EmployeeDetails.filter(function (x) { return x.EmployeeName.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 });
            ReloadTableSearchForEMP(FilterTitle);
        }
        function ReloadTableSearchForEMP(List) {
            var strHTML = "";
            $("#tblBusinessGroups").html('');
            if (List != null && List.length > 0) {
                $.each(List, function (index, obj) {
                    strHTML += '<tr>' +
                        //'<tr><td class="text-start"><input type="hidden" name="hdnrm_employeeid" id="hdnrm_employeeid" value= ' + obj.EmployeeID + '> ' +
                        '<td width="120" class="text-start"><input type="hidden" name="hdnrm_employeeid" id="hdnrm_employeeid" value= ' + obj.EmployeeID + '> <a href="javascript:;" class="BGdetalilink" onclick="editME()"> ' + obj.EmployeeName + '</a></td>' +
                        '<td width="120"> ' + obj.UserName + '</td>' +
                        '<td > ' + obj.RoleName + '</td>' +
                        '<td> ' + obj.Location + '</td>' +
                        '<td> ' + obj.Department + '</td>' +
                        '<td> ' + obj.EmailID + '</td>' +
                        //Added by Nikhil Mane on 3rd July for Download Resume and View Resume functionality in Employee Master
                        '<td width="80" class="text-center">' +
'<a href="javascript:;" ' +
'data-bs-toggle="tooltip" ' +
'data-bs-placement="bottom" ' +
'data-bs-container="body" ' +
'data-bs-original-title="View Resume" ' +
'onclick="GetResourceResume(' + obj.EmployeeID + ')">' +
'<i class="far fa-file"></i>' +
'</a>' +
'&nbsp;' +
'<a href="javascript:;" ' +
'data-bs-toggle="tooltip" ' +
'data-bs-placement="bottom" ' +
'data-bs-container="body" ' +
'data-bs-original-title="Download PDF" ' +
'onclick="DownloadResumePDF(' + obj.EmployeeID + ')">' +
'<i class="fas fa-file-pdf" style="color:#e74c3c;"></i>' +
'</a>' +
'</td>' +
//End of Added by Nikhil Mane on 3rd July for Download Resume and View Resume functionality in Employee Master
                        '<td width="50" class=""><a id="" class="BGdetalilink" href="javascript:;" title="" onclick="editME()">' +
                        '<img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-bs-original-title="Edit"></a>' +
                        //'<button  class="nostylebtn" title="Delete" data-bs-container="body" data-bs-toggle="modal" data-bs-target="#deleteinfomodal"><i class="far fa-trash-alt"></i></button> </td></tr>'
                        '<button id ="btnEmployeedelete" class="nostylebtn" data-bs-toggle="tooltip" data-bs-original-title="Delete" onclick=DeleteEmployeeDetails(' + obj.EmployeeID + ') ><i class="far fa-trash-alt"></i></button> </td></tr>'
                });
                $('#MEListTbl').dataTable().fnDestroy();
                $("#tblBusinessGroups").html(strHTML);
                LoadPagination('#MEListTbl', List);
                StopAjaxLoader("#body-tblEmplyee");

            }
            else {
                strHTML = '<tr><td class="text-center"colspan="8">' + NoDataFound + ' </td></tr>';
                $('#MEListTbl').dataTable().fnDestroy();
                $("#tblBusinessGroups").html(strHTML);

                // $(".chckHeadForSoftBooking").prop("checked", false);
            }
        }
        //$('#HscrollTab').slimScroll({
        //    height: '45px',
        //    width: '100%',
        //    axis: 'x'
        //});


        //visadetails
        function GetVisaDetails() {
            if (CurrentTabObject != null && CurrentTabObject.VisaDetails == "false") {
                var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
                GetEmployeeVisaDetailsList(EmployeeId);
                CurrentTabObject.VisaDetails = 'true';
            }
            //            var EmployeeId = 755;
            //          GetEmployeeVisaDetailsList(EmployeeId);
        }
        function GetEmployeeVisaDetailsList(EmployeeID) {
            CurrentTabObject.VisaDetails = 'true';
            var strHTML = "";
            //StartLoader("#bodyBusiness-group");
            EmployeeID = parseInt(EmployeeID);           
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetEmployeeVisaDetails',
                type: "POST",
                data: JSON.stringify(EmployeeID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (EmployeeID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(EmployeeID) ? EmployeeID : JSON.stringify(EmployeeID)));
                    }
                },
                success: function (data) {
                    var EmployeeVisaDetails = data;
                    var i = 0;
                    $.each(EmployeeVisaDetails, function (index, obj) {
                        i = i + 1;
                        strHTML += '<tr>' +

                            //'<td><input type="hidden" name="hdnrm_visa_employeeid" id="hdnrm_EmployeeVisaID" value= ' + obj.EmployeeVisaID + '> ' + obj.CountryName + '</td>' +
                            '<td><a href="javascript:;" class="skilleditlink" onclick="GetVisaDetailsForEdit(' + obj.EmployeeVisaID + ')"  data-bs-toggle="modal"  data-bs-target="#MEaddVisaDetailmodal"</a><input type="hidden" name="hdnrm_visa_employeeid" id="hdnrm_EmployeeVisaID" value= ' + obj.EmployeeVisaID + '> ' + obj.CountryName + '</td>' +
                            '<td> ' + obj.VisaType + '</td>' +
                            '<td > ' + convert(obj.ValidFrom) + '</td>' +
                            '<td> ' + convert(obj.ValidUpto) + '</td>' +

                            '<td>  <div class="custom_chckbox"><input id="MEVisaCheck' + i + '" class="chckVisatbl" type="checkbox" onclick="checkUncheckforVisa();GetSelectedVisa(this);">' +
                            '<label for="MEVisaCheck' + i + '"></label>';
                    });
                    $('#emsubtabVisaTbl').dataTable().fnDestroy();
                    $("#emtblVisaType").html(strHTML);
                    LoadPaginationForVisa(data);
                    //StopAjaxLoader("#bodyBusiness-group");
                    $(".chckVisa").prop("checked", false);
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
        function LoadPaginationForVisa(data) {

            //var businessGroupTable;
            $.fn.DataTable.ext.pager.numbers_length = 5;
            visaTable = $('#emsubtabVisaTbl').dataTable({
                "sscrolly": (0.5 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                "lengthChange": false,
                "searching": false,
                //Added by imran on 24-08-2022
                pageLength: 10,
                //End of comment by imran on 24-08-2022
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [4] }]// Added By Pradip on 20 July 2021
            });

        }
        var validateVisaflag = false;
        function checkVisaValidation() {
            if (($("#cboCountry").val() == undefined || $("#cboCountry").val() == "" || $("#cboCountry").val() == 0)) {
                $("#cboCountry").focus();
                validateVisaflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Country' should not left blank.");
                return false;
            }
            else if (($("#cboVisaType").val() == undefined || $("#cboVisaType").val() == "" || $("#cboVisaType").val() == 0)) {
                $("#cboVisaType").focus();
                validateVisaflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'VisaType' should not left blank.");
                return false;
            }
            else if ($("#MEvalidFromDate").val() == undefined || $("#MEvalidFromDate").val() == "") {
                $("#MEvalidFromDate").focus();
                validateVisaflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Valid From' should not left blank.");
                return false;
            }
            else if ($("#MEvalidToDate").val() == undefined || $("#MEvalidToDate").val() == "") {
                $("#MEvalidToDate").focus();
                validateVisaflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Valid To' should not left blank.");
                return false;
            }
            else if (Date.parse($("#MEvalidFromDate").val()) > Date.parse($("#MEvalidToDate").val())) {
                $("#MEvalidToDate").focus();
                validateVisaflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Valid To' must be greater than 'Valid From'.");
                return false;
            }
            //Added By Riddhesh Patil on 10-NOV-2022 
            else if (checkSpecialCharacter($("#txtDescription").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Remarks should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtDescription").focus();
               
                return false;
            }
			//End of Added By Riddhesh Patil

            else {
                validateVisaflag = true;
                return true;
            }
        }

        function SaveVisaDetails(isSavenAdd) {
            
            var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
            checkVisaValidation();
            if (validateVisaflag == true) {
                var CountryId = $("#cboCountry").val();
                var VisaTypeId = $("#cboVisaType").val();
                var ValidFrom = $("#MEvalidFromDate").val();
                var ValidTo = $("#MEvalidToDate").val();
                var remark = $("#txtDescription").val();
                var UserName = '<%= Session("strUserName") %>';

                var employeeVisa = {
                    EmployeeId: EmployeeId,
                    CountryId: CountryId,
                    VisaTypeId: VisaTypeId,
                    dtValidFrom: ValidFrom,
                    dtValidUpto: ValidTo,
                    remark: remark,
                    CreatedBy: UserName
                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/SaveMEVisaDetails',
                    method: 'Post',
                    data: JSON.stringify(employeeVisa),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (employeeVisa) {
                            xhr.setRequestHeader("Params", encryptString(isJson(employeeVisa) ? employeeVisa : JSON.stringify(employeeVisa)));
                        }
                    },
                    success: function (data) {
                        CurrentTabObject.VisaDetails = 'false';
                        GetVisaDetails();
                        CurrentTabObject.VisaDetails = 'true';

                        //if (data == "Visa details already exist") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //    $('#MEaddVisaDetailmodal').modal('show');
                        //} else {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.success(data);
                        //    clearVisaDetails();
                        //    $('#MEaddVisaDetailmodal').modal('hide');
                        //}
                        if (isSavenAdd == 0) {
                            if (data == "Visa details already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $('#MEaddVisaDetailmodal').modal('show');
                            } else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                clearVisaDetails();
                                $('#MEaddVisaDetailmodal').modal('hide');
                            }

                        }
                        else {
                            if (data == "Visa details already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $('#MEaddVisaDetailmodal').modal('show');
                            } else {
                                clearVisaDetails();
                                $('#MEaddVisaDetailmodal').modal('show');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);

                            }

                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            CurrentTabObject.VisaDetails = 'false';
                            GetVisaDetails();
                            CurrentTabObject.VisaDetails = 'true';

                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);
                        }
                        if (isSavenAdd == 0) {
                            $('#MEaddVisaDetailmodal').modal('hide');
                        }
                        //StopAjaxLoader("#bodyGlobal-Resource");
                    }
                })
            } else {
                return false;
            }

        }
        function clearVisaDetails() {
            $("#cboCountry").val("");
            $("#cboVisaType").val("");
            //var myDate1 = new Date(new Date().getTime() + (24 * 60 * 60 * 1000));
            //$('#txtStartApproxDate').datepicker().datepicker('setDate', myDate1);
            $('#MEvalidFromDate').val("");
            $('#MEvalidToDate').val("");
            //$('#MEvalidFromDate').datepicker().datepicker('setDate', new Date());
            //$('#MEvalidToDate').datepicker().datepicker('setDate', new Date());
            $("#txtDescription").val("");
            //Added By Rutuja D. on 13 Aug 2021
            $('#btnSaveVisaModal').show();
            $('#BtnSaveVisaDetails').show();
            $('#btnUpdateVisa').hide();
            //End of Added By Rutuja D. on 13 Aug 2021

        }
        function cancleVisaDetails() {
            clearVisaDetails();
        }
        //visa details end



        //Pre. Assignments

        function GetPreAssignmentDetails() {
            if (CurrentTabObject != null && CurrentTabObject.PreviousAssignment == "false") {
                var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
                GetPreAssignmentDetailsList(EmployeeId);

                CurrentTabObject.PreviousAssignment = 'true';
            }
        }
        function GetPreAssignmentDetailsList(EmployeeID) {
            CurrentTabObject.PreviousAssignment = 'true';
            var strHTML = "";
            //StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetMEPreAssignmentDetails',
                type: "POST",
                data: JSON.stringify(EmployeeID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (EmployeeID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(EmployeeID) ? EmployeeID : JSON.stringify(EmployeeID)));
                    }
                },
                success: function (data) {
                    var EmployeePreAssignmentDetails = data;
                    var i = 0;
                    $.each(EmployeePreAssignmentDetails, function (index, obj) {
                        i = i + 1;
                        strHTML += '<tr>' +
                            //'<tr><td class="text-start"><input type="hidden" name="hdnrm_employeeid" id="hdnrm_employeeid" value= ' + obj.EmployeeID + '> ' +
                            //Commented and added by Chetan M on 10 Aug 2021 for Edit functionality
                            //'<td class="text-start"><input type="hidden" name="hdnrm_EmployeeHistoryProjectID" id="hdnrm_EmployeeHistoryProjectID" value= ' + obj.EmployeeHistoryProjectID + '> ' + obj.ProjectName + '</td>' +
                            '<td class="text-start"><input type="hidden" name="hdnrm_EmployeeHistoryProjectID" id="hdnrm_EmployeeHistoryProjectID" value= ' + obj.EmployeeHistoryProjectID + '><a href="javascript:;" class="skilleditlink" onclick="GetPreAssigmentForEdit(' + obj.EmployeeHistoryProjectID + ')"  data-bs-toggle="modal"  data-bs-target="#MEPrevAsignmentModal"</a> ' + obj.ProjectName + '</td>' +
                            //Commented and added by Chetan M on 10 Aug 2021 for Edit functionality
                            '<td> ' + obj.Duration + '</td>' +
                            '<td > ' + obj.TeamSize + '</td>' +
                            '<td> ' + obj.Role + '</td>' +

                            '<td>  <div class="custom_chckbox"><input id="MEPAsignmentscheck' + i + '" class="chcktblPreAssgn" type="checkbox" onclick="checkUncheckforPreassignment();GetSelectedPreAssignments(this);">' +
                            '<label for="MEPAsignmentscheck' + i + '"></label>';
                    });
                    $('#emtabpreAssign').dataTable().fnDestroy();
                    $("#empreAssign").html(strHTML);
                    LoadPaginationPreAssignment(data);
                    //StopAjaxLoader("#bodyBusiness-group");
                    $(".chckHeadPreAssgn").prop("checked", false);
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
                //    $(".chckHeadPreAssgn").prop("checked", false);
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    $(".chckHeadPreAssgn").prop("checked", false);
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
        function LoadPaginationPreAssignment(data) {
            //var businessGroupTable;
            $.fn.DataTable.ext.pager.numbers_length = 5;
            preassignmentTable = $('#emtabpreAssign').dataTable({
                "sscrolly": (0.5 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                "lengthChange": false,
                "searching": false,
                //Added by imran on 24-08-2022
                pageLength: 10,
                //End of comment by imran on 24-08-2022
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [4] }]// Added By Pradip on 20 July 2021
            });

        }
        function SavePreAssignmentDetails(isSavenAdd) {
            var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
            checkPreassignmentValidation();
            if (validatePreassignmentflag == true) {
                var ProjectName = $("#txtPreAssProjectName").val();
                var Duration = $("#txtPreAssDuration").val();
                var TeamSize = $("#txtTeamSize").val();
                var Role = $("#txtPreAssRole").val();
                var Environment = $("#txtEnvironment").val();
                var SkillSet = $("#txtSkills").val();
                var Description = $("#txtPreAssDescription").val();
                var UserName = '<%= Session("strUserName") %>';

                var employeePreAssignmentParameters = {
                    EmployeeId: EmployeeId,
                    ProjectName: ProjectName,
                    Duration: Duration,
                    TeamSize: TeamSize,
                    Role: Role,
                    Environment: Environment,
                    SkillSet: SkillSet,
                    Description: Description,
                    CreatedBy: UserName

                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/SaveMEPreAssignmentDetails',
                    method: 'Post',
                    data: JSON.stringify(employeePreAssignmentParameters),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (employeePreAssignmentParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(employeePreAssignmentParameters) ? employeePreAssignmentParameters : JSON.stringify(employeePreAssignmentParameters)));
                        }
                    },
                    success: function (data) {
                        // CurrentGRPTabObject.GrpManager = 'false';
                        //ShowGRPManager();     
                        GetPreAssignmentDetailsList($('#hdnEmployee_UniqueIDTab').val());
                        //  CurrentGRPTabObject.GrpManager = 'true';

                        //if (data == "Assignment details already exist") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //    $('#MEPrevAsignmentModal').modal('show');
                        //} else {
                        //     alertify.set('notifier', 'position', 'top-right');
                        //    alertify.success(data);
                        //     clearPreAssignmentDetails();
                        //     $('#MEPrevAsignmentModal').modal('hide');
                        //}
                        if (isSavenAdd == 0) {
                            //Comment and added by imran on 29-08-2022 
                            //if (data == "Assignment details already exist")
                            if (data == "Pre Assignment already exist")
                            //Comment and added by imran on 29-08-2022
                            {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $('#MEPrevAsignmentModal').modal('show');
                            } else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                clearPreAssignmentDetails();
                                $('#MEPrevAsignmentModal').modal('hide');
                            }

                        }
                        else {
                            //Comment and added by imran on 29-08-2022
                            //if (data == "Assignment details already exist")
                            if (data == "Pre Assignment already exist")
                            //Comment and added by imran on 29-08-2022
                            {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $('#MEPrevAsignmentModal').modal('show');
                            } else {
                                clearPreAssignmentDetails();
                                $('#MEPrevAsignmentModal').modal('show');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);

                            }

                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }

                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);
                        }

                        //StopAjaxLoader("#bodyGlobal-Resource");
                        if (isSavenAdd == 0) {
                            $('#MEPrevAsignmentModal').modal('hide');
                        }
                    }
                })
            } else {
                return false;
            }

        }

        var validatePreassignmentflag = false;
        function checkPreassignmentValidation() {
            if (($("#txtPreAssProjectName").val() == undefined || $("#txtPreAssProjectName").val() == "")) {
                $("#txtPreAssProjectName").focus();
                validatePreassignmentflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Assignment name' should not left blank.");
                return false;
            }

            //Commnet and Added By Riddhesh Patil on 10-NOV-2022 

            //else if ($("#txtPreAssProjectName").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtPreAssProjectName").focus();
            //    validatePreassignmentflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Assignment Name cannot contain any of these /\:*?<>|,"+- characters.');
            //}
            
            else if (checkSpecialCharacter($("#txtPreAssProjectName").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Assignment Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPreAssProjectName").focus();
              
                return false;
            }
			//End of Comment Added By Riddhesh Patil

            else if (($("#txtPreAssRole").val() == undefined || $("#txtPreAssRole").val() == "")) {
                $("#txtPreAssRole").focus();
                validatePreassignmentflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Functional Role' should not left blank.");
                return false;
            }

            //Commnet and Added By Riddhesh Patil on 10-NOV-2022

            //else if ($("#txtPreAssRole").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtPreAssRole").focus();
            //    validatePreassignmentflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Functional Role cannot contain any of these /\:*?<>|,"+- characters.');
            //}
            else if (checkSpecialCharacter($("#txtPreAssRole").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Functional Role should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPreAssRole").focus();

                return false;
            }
			//End of Comment Added By Riddhesh Patil
            else if ($("#txtPreAssDuration").val() == undefined || $("#txtPreAssDuration").val() == "") {
                $("#txtPreAssDuration").focus();
                validatePreassignmentflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Duration' should not left blank.");
                return false;
            }
            else if ($("#txtTeamSize").val() == undefined || $("#txtTeamSize").val() == "") {
                $("#txtTeamSize").focus();
                validatePreassignmentflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Team Size' should not left blank.");
                return false;
            }
                //Added By Riddhesh Patil on 10-NOV-2022 
            else if (checkSpecialCharacter($("#txtEnvironment").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Environment should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtEnvironment").focus();

                return false;
            }
			//End of Added By Riddhesh Patil

            //Added By Riddhesh Patil on 10-NOV-2022 
            else if (checkSpecialCharacter($("#txtSkills").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Skills should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtSkills").focus();

                return false;
            }
			//End of Added By Riddhesh Patil

            //Added By Riddhesh Patil on 10-NOV-2022 
            else if (checkSpecialCharacter($("#txtPreAssDescription").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPreAssDescription").focus();

                return false;
            }
			//End of Added By Riddhesh Patil

            else {
                validatePreassignmentflag = true;
                return true;
            }
        }
        function clearPreAssignmentDetails() {
            $("#txtPreAssProjectName").val("");
            $("#txtPreAssRole").val("");
            $('#txtPreAssDuration').val("");
            $('#txtTeamSize').val("");
            $('#txtEnvironment').val("");
            $('#txtSkills').val("");
            $("#txtPreAssDescription").val("");
            $('#btnSavePreAssignment').show();
            $('#btnSavePreAssignmentDetails').show();
            $('#btnUpdatePreviousAssignment').hide();
        }
        function canclePreAssignmentDetails() {
            clearPreAssignmentDetails();
        }

        ///get checked values
        //function GetSelectedPreAssignments() {
        //    var selectedPreAssignmentUniqueId = '';
        //    $('#empreAssign').find('tr').each(function () {
        //        var row = $(this);
        //        if (row.find('input[type="checkbox"]').is(':checked')) {
        //            selectedPreAssignmentUniqueId += row.find('#hdnrm_EmployeeHistoryProjectID').val() + ',';
        //        }
        //    });
        //    if (selectedPreAssignmentUniqueId.length > 0) {
        //        selectedPreAssignmentUniqueId = selectedPreAssignmentUniqueId.substring(0, selectedPreAssignmentUniqueId.length - 1);
        //    }
        //    return selectedPreAssignmentUniqueId;
        //}
        function GetSelectedPreAssignments(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                selectedPreassignmentId.push(parseInt(row.find('#hdnrm_EmployeeHistoryProjectID').val()));
            }
            else {
                if (selectedPreassignmentId != 'undefined' && selectedPreassignmentId.length > 0) {
                    var removeGrp = row.find('#hdnrm_EmployeeHistoryProjectID').val();
                    selectedPreassignmentId.remove(parseInt(removeGrp));
                }
            }
        }
        function DeletePreAssignment() {
            var isSelectedpreassignment = selectedPreassignmentId;
            if (isSelectedpreassignment.length > 0) {
                $('#DeleteConfirmPreAssignmentModal').modal('show');

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }
        function DeletePreAssignmentAfterConfirm() {
            var isSelectedResource = selectedPreassignmentId.toString();
            if (isSelectedResource.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/DeleteMEPreAssignment',
                    type: "POST",
                    data: JSON.stringify(isSelectedResource),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (isSelectedResource) {
                            xhr.setRequestHeader("Params", encryptString(isJson(isSelectedResource) ? isSelectedResource : JSON.stringify(isSelectedResource)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.success("Deleted Successfully");
                        //}
                        if (data != "") {
                            alertify.set('notifier', 'position', 'top-right');
                            if (data.notDeletedCount > 0)
                                alertify.success(data.deletedCount + ' records deleted Successfully.' + data.notDeletedCount + ' records not deleted.');
                            else
                                alertify.success(data.deletedCount + ' records deleted Successfully.');
                        }
                        CurrentTabObject.PreviousAssignment = 'false';
                        GetPreAssignmentDetailsList($('#hdnEmployee_UniqueIDTab').val());//  ShowDUManager();
                        CurrentTabObject.PreviousAssignment = 'true';
                        $('#DeleteConfirmPreAssignmentModal').modal('hide');
                    },
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    $('#DeleteConfirmPreAssignmentModal').modal('hide');
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "OK") {  //200
                            CurrentTabObject.PreviousAssignment = 'false';
                            GetPreAssignmentDetailsList($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.PreviousAssignment = 'true';
                            $('#DeleteConfirmPreAssignmentModal').modal('hide');

                        }

                        // StopAjaxLoader("#bodyCertification-Details");
                        $('#DeleteConfirmPreAssignmentModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            selectedPreassignmentId = [];
            isSelectedResource = "";
        }


        //end pre assignment
        function Field_OnKeyPressnumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    $("#txtTotalScore").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please enter only numeric values.");
                }
            }
            return ret;
        }

        // previous work experience

        function GetPreWorkExpDetails() {

            if (CurrentTabObject != null && CurrentTabObject.PreviousWorkExperience == "false") {
                var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
                GetPreWorkExpDetailsList(EmployeeId);
                CurrentTabObject.PreviousWorkExperience = 'true';
            }
        }
        function GetPreWorkExpDetailsList(EmployeeID) {
            
            CurrentTabObject.PreviousWorkExperience = 'true';
            var strHTML = "";
            //StartLoader("#bodyBusiness-group");
            
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetMEPreWorkExperienceDetails',
                type: "POST",
                data: JSON.stringify(EmployeeID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (EmployeeID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(EmployeeID) ? EmployeeID : JSON.stringify(EmployeeID)));
                    }
                },
                success: function (data) {
                    var EmployeePreAssignmentDetails = data;
                    var i = 0;
                    $.each(EmployeePreAssignmentDetails, function (index, obj) {
                        i = i + 1;
                        strHTML += '<tr>' +
                            //Commented and added by Chetan M on 10 Aug 2021 for Edit Functionality
                            //'<td class="text-start"><input type="hidden" name="hdnrm_EmployeeHistoryID" id="hdnrm_EmployeeHistoryID" value= ' + obj.EmployeeHistoryID + '> ' + obj.OrganizationName + '</td>' +
                            '<td class="text-start"><input type="hidden" name="hdnrm_EmployeeHistoryID" id="hdnrm_EmployeeHistoryID" value= ' + obj.EmployeeHistoryID + '><a href="javascript:;" class="skilleditlink" onclick="GetPreWorkExpForEdit(' + obj.EmployeeHistoryID + ')"  data-bs-toggle="modal"  data-bs-target="#MEPWExpmodal"</a> ' + obj.OrganizationName + '</td>' +
                            //End of Commented and added by Chetan M on 10 Aug 2021 for Edit Functionality
                            '<td> ' + obj.PositionHeld + '</td>' +
                            '<td > ' + convert(obj.WorkedFrom) + '</td>' +
                            '<td> ' + convert(obj.WorkedTill) + '</td>' +
                            '<td> ' + obj.WorkProfileNatureText + '</td>' +
                            '<td>  <div class="custom_chckbox"><input id="MEPWEcheck' + i + '" class="chkPreworktbl" type="checkbox" onclick="checkUncheckforPrework();GetSelectedPreWorkexp(this);">' +
                            '<label for="MEPWEcheck' + i + '"></label>';
                    });
                    $('#emsubtabprewrkTbl').dataTable().fnDestroy();
                    $("#emprewrk").html(strHTML);
                    LoadPaginationForPrework(data);
                    //StopAjaxLoader("#bodyBusiness-group");
                    $(".chckPerwork").prop("checked", false);
                },
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }

        function LoadPaginationForPrework(data) {
            //var businessGroupTable;
            $.fn.DataTable.ext.pager.numbers_length = 5;
            preworkTable = $('#emsubtabprewrkTbl').dataTable({
                "sscrolly": (0.5 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                "lengthChange": false,
                "searching": false,
                //Added by imran on 24-08-2022
                pageLength: 10,
                //End of comment by imran on 24-08-2022
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [5] }]// Added By Pradip on 20 July 2021
            });

        }

        function SavePreWorkExpDetails(isSavenAdd) {

            var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
            checkPreWorkExpValidation();
            if (validatePreworkExpflag == true) {
                var OrganizationName = $("#txtPreWorkExpOrganisation").val();
                var WorkedFrom = $("#MEPWEFromDate").val();
                var WorkedTill = $("#MEPWEtillDate").val();
                //Added by imran on 24-08-2022
                if ($("#cboPreWorkExpWorkProfile").val() == "") {
                    var WorkProfileNature = 0;
                }
                else {
                    var WorkProfileNature = $("#cboPreWorkExpWorkProfile").val();
                }
                //End of comment by imran on 24-08-2022

                var PositionHeld = $("#txtPreWorkExpPositionHeld").val();
                var Summary = $("#txtPreWorkExpSummary").val();

                var employeePreWorkExpParameters = {
                    EmployeeId: EmployeeId,
                    OrganizationName: OrganizationName,
                    WorkedFrom: WorkedFrom,
                    WorkedTill: WorkedTill,
                    WorkProfileNature: WorkProfileNature,
                    PositionHeld: PositionHeld,
                    Summary: Summary

                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/SaveMEPreWorkExperienceDetails',
                    method: 'Post',
                    data: JSON.stringify(employeePreWorkExpParameters),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (employeePreWorkExpParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(employeePreWorkExpParameters) ? employeePreWorkExpParameters : JSON.stringify(employeePreWorkExpParameters)));
                        }
                    },
                    success: function (data) {
                        // CurrentGRPTabObject.GrpManager = 'false';
                        //ShowGRPManager();     
                        GetPreWorkExpDetailsList($('#hdnEmployee_UniqueIDTab').val());

                        if (isSavenAdd == 0) {
                            if (data == "Pre Work Experience already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $('#MEPWExpmodal').modal('show');
                            } else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                clearPreWorkExpDetails();
                                $('#MEPWExpmodal').modal('hide');
                            }

                        }
                        else {
                            if (data == "Pre Work Experience already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $('#MEPWExpmodal').modal('show');
                            } else {
                                clearPreWorkExpDetails();
                                $('#MEPWExpmodal').modal('show');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);

                            }

                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }

                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);
                        }

                        //StopAjaxLoader("#bodyGlobal-Resource");
                        if (isSavenAdd == 0) {
                            $('#MEPWExpmodal').modal('hide');
                        }
                    }
                })
            } else {
                return false;
            }

        }

        var validatePreworkExpflag = false;
        function checkPreWorkExpValidation() {
            var MEPWEFromDate = new Date($("#MEPWEFromDate").val());
            var MEPWEtillDate = new Date($("#MEPWEtillDate").val());
            if (($("#txtPreWorkExpOrganisation").val() == undefined || $("#txtPreWorkExpOrganisation").val() == "")) {
                $("#txtPreWorkExpOrganisation").focus();
                validatePreworkExpflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Organisation name' should not left blank.");
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 10-NOV-2022 
            //else if ($("#txtPreWorkExpOrganisation").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtPreWorkExpOrganisation").focus();
            //    validatePreworkExpflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Organisation Name cannot contain any of these /\:*?<>|,"+- characters.');
            //}
            
            else if (checkSpecialCharacter($("#txtPreWorkExpOrganisation").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Organization Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPreWorkExpOrganisation").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil
            else if (($("#txtPreWorkExpPositionHeld").val() == undefined || $("#txtPreWorkExpPositionHeld").val() == "")) {
                $("#txtPreWorkExpPositionHeld").focus();
                validatePreworkExpflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Position held' should not left blank.");
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 10-NOV-2022 
            //else if ($("#txtPreWorkExpPositionHeld").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtPreWorkExpPositionHeld").focus();
            //    validatePreworkExpflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Position Held cannot contain any of these /\:*?<>|,"+- characters.');
            //}
            else if (checkSpecialCharacter($("#txtPreWorkExpPositionHeld").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Position Held should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPreWorkExpPositionHeld").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil
            else if ($("#MEPWEFromDate").val() == undefined || $("#MEPWEFromDate").val() == "") {
                $("#MEPWEFromDate").focus();
                validatePreworkExpflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'FromDate' should not left blank.");
                return false;
            }
            else if ($("#MEPWEtillDate").val() == undefined || $("#MEPWEtillDate").val() == "") {
                $("#MEPWEtillDate").focus();
                validatePreworkExpflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Till Date' should not left blank.");
                return false;
            }
            else if (MEPWEtillDate == 'Invalid Date') {
                $("#MEPWEtillDate").focus();
                validatePreworkExpflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Till Date' invalid");
                return false;
            }
            else if (MEPWEFromDate == 'Invalid Date') {
                $("#MEPWEFromDate").focus();
                validatePreworkExpflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'From Date' invalid");
                return false;
            }
            else if (Date.parse($("#MEPWEFromDate").val()) > Date.parse($("#MEPWEtillDate").val())) {
                $("#MEPWEtillDate").focus();
                validatePreworkExpflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Till Date' should be grater than 'From date'.");
                return false;
            }
            //Added by Chetan M on 9 Aug 2021 for till date should not be greater that joining date
            else if (Date.parse($("#MEPWEtillDate").val()) > Date.parse($("#txtJoiningDate").val())) {
                $("#MEPWEtillDate").focus();
                validatePreworkExpflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Till Date' should not be greater than  Joining Date ( " + $("#txtJoiningDate").val() + " )");
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 10-NOV-2022 
            else if (checkSpecialCharacter($("#txtPreWorkExpSummary").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Summary should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPreWorkExpSummary").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil

            //End of Added by Chetan M on 9 Aug 2021 for till date should not be greater that joining date

            else {
                validatePreworkExpflag = true;
                return true;
            }
        }
        function clearPreWorkExpDetails() {
            $('#btnSavePreWorkExpDetails').show();
            $('#btnSavePreWork').show();
            $('#btnUpdateExperience').hide();
            $("#txtPreWorkExpOrganisation").val("");
            $("#txtPreWorkExpPositionHeld").val("");
            $('#MEPWEFromDate').val("");
            $('#MEPWEtillDate').val("");
            $('#cboPreWorkExpWorkProfile').val("");
            $('#txtPreWorkExpSummary').val("");
        }
        function canclePreWorkExpDetails() {
            clearPreWorkExpDetails();
        }

        ///get checked values

        function GetSelectedPreWorkexp(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                selectedPreworkId.push(parseInt(row.find('#hdnrm_EmployeeHistoryID').val()));
            }
            else {
                if (selectedPreworkId != 'undefined' && selectedPreworkId.length > 0) {
                    var removeGrp = row.find('#hdnrm_EmployeeHistoryID').val();
                    selectedPreworkId.remove(parseInt(removeGrp));
                }
            }
        }
        function DeletePreWorkExperience() {
            var isSelectedpreworkExp = selectedPreworkId;
            if (isSelectedpreworkExp.length > 0) {
                $('#DeleteConfirmPreWorkExpModal').modal('show');

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }
        function DeletePreWorkExpAfterConfirm() {
            var isSelectedResource = selectedPreworkId.toString();
           // var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (isSelectedResource.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/DeleteMEPreWorkExperience',
                    type: "POST",
                    data: JSON.stringify(isSelectedResource),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (isSelectedResource) {
                            xhr.setRequestHeader("Params", encryptString(isJson(isSelectedResource) ? isSelectedResource : JSON.stringify(isSelectedResource)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.success('Deleted Successfully');
                        //}
                        if (data != "") {
                            alertify.set('notifier', 'position', 'top-right');
                            if (data.notDeletedCount > 0)
                                alertify.success(data.deletedCount + ' records deleted Successfully.' + data.notDeletedCount + ' records not deleted.');
                            else
                                alertify.success(data.deletedCount + ' records deleted Successfully.');
                        }
                        CurrentTabObject.PreviousWorkExperience = 'false';
                        GetPreWorkExpDetailsList($('#hdnEmployee_UniqueIDTab').val());//  ShowDUManager();
                        CurrentTabObject.PreviousWorkExperience = 'true';
                        $('#DeleteConfirmPreWorkExpModal').modal('hide');
                    },

                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "OK") {  //200
                            CurrentTabObject.PreviousWorkExperience = 'false';
                            GetPreAssignmentDetailsList($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.PreviousWorkExperience = 'true';
                            $('#DeleteConfirmPreWorkExpModal').modal('hide');

                        }

                        // StopAjaxLoader("#bodyCertification-Details");
                        $('#DeleteConfirmPreWorkExpModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            selectedPreworkId = [];
            isSelectedResource = "";
        }
        //end previous experience

        //Cost

        function GetCostDetails() {

            if (CurrentTabObject != null && CurrentTabObject.Cost == "false") {
                var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
                GetCostList(EmployeeId);

                CurrentTabObject.Cost = 'true';
            }
        }
        function GetCostList(EmployeeID) {
            CurrentTabObject.Cost = 'true';
            var strHTML = "";
            //StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetCostDetails',
                type: "POST",
                data: JSON.stringify(EmployeeID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (EmployeeID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(EmployeeID) ? EmployeeID : JSON.stringify(EmployeeID)));
                    }
                },
                success: function (data) {
                    var EmployeeCostDetails = data;
                    var i = 0;
                    $.each(EmployeeCostDetails, function (index, obj) {
                        i = i + 1;
                        strHTML += '<tr>' +
                            //'<td><input type="hidden" name="hdnrm_EmployeeHistoryID" id="hdnrm_EmployeeCostID" value= ' + obj.EmployeeCostID + '> ' + convert(obj.StartDate) + '</td>' +
                            '<td><a href="javascript:;" class="skilleditlink" onclick="GetCurrencyCostForEdit(' + obj.EmployeeCostID + ')"  data-bs-toggle="modal"  data-bs-target="#MEaddcostmodal"</a><input type="hidden" name="hdnrm_EmployeeHistoryID" id="hdnrm_EmployeeCostID" value= ' + obj.EmployeeCostID + '> ' + convert(obj.StartDate) + '</td>' +
                            '<td> ' + obj.CostPerHour + '</td>' +
                            '<td>  <div class="custom_chckbox"><input id="MEphotoUploadCheck' + i + '" class="chkCosttbl" type="checkbox" onclick="checkUncheckforCost();GetSelectedCost(this);" >' +
                            '<label for="MEphotoUploadCheck' + i + '"></label>';
                    });
                    $('#empsubtabCosttbl').dataTable().fnDestroy();
                    $("#empCosttbl").html(strHTML);
                    $("#EmpCostTab").text("Cost (" + i + ")");
                    LoadPaginationForCost(data);
                    //StopAjaxLoader("#bodyBusiness-group");
                    $(".chkCost").prop("checked", false);
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }

        function LoadPaginationForCost(data) {
            //var businessGroupTable;
            $.fn.DataTable.ext.pager.numbers_length = 5;
            costTable = $('#empsubtabCosttbl').dataTable({
                "sscrolly": (0.5 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                "lengthChange": false,
                "searching": false,
                //Added by imran on 24-08-2022
                pageLength: 10,
                //End of comment by imran on 24-08-2022
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [2] }]// Added By Pradip on 20 July 2021
            });

        }

        function SaveCostDetails(isSavenAdd) {

            var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
            checkCostValidation();
            if (validateCostflag == true) {
                var StartDate = $("#MECostEffectiveDate").val();
                var CostPerHour = $("#txtMECostPerHour").val();
                var CreatedBy = '<%= Session("strUserName") %>';

                var Op_Patameters = {
                    EmployeeId: EmployeeId,
                    StartDate: StartDate,
                    CostPerHour: CostPerHour,
                    CreatedBy: CreatedBy

                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/SaveCostDetails',
                    method: 'Post',
                    data: JSON.stringify(Op_Patameters),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Op_Patameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Op_Patameters) ? Op_Patameters : JSON.stringify(Op_Patameters)));
                        }
                    },
                    success: function (data) {
                        // CurrentGRPTabObject.GrpManager = 'false';
                        //ShowGRPManager();     
                        GetCostList($('#hdnEmployee_UniqueIDTab').val());

                        //  CurrentGRPTabObject.GrpManager = 'true';
                        if (isSavenAdd == 0) {
                            if (data == "Cost added successfully.") {

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                clearCostDetails();
                                $('#MEaddcostmodal').modal('hide');
                            } else {

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $('#MEaddcostmodal').modal('show');
                            }

                        }
                        else {
                            if (data == "Cost added successfully.") {
                                clearCostDetails();
                                $('#MEaddcostmodal').modal('show');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                            } else {

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $('#MEaddcostmodal').modal('show');
                            }

                        }
                        // GetAllEmployeeList();
                        editEmployee($('#hdnEmployee_UniqueIDTab').val());

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }

                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);
                        }

                        //StopAjaxLoader("#bodyGlobal-Resource");
                        if (isSavenAdd == 0) {
                            $('#MEaddcostmodal').modal('hide');
                        }
                    }
                })
            } else {
                return false;
            }

        }

        var validateCostflag = false;
        function checkCostValidation() {
            var dateVariable = new Date($("#MECostEffectiveDate").val());
            if (($("#MECostEffectiveDate").val() == undefined || $("#MECostEffectiveDate").val() == "")) {
                $("#MECostEffectiveDate").focus();
                validateCostflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Effective from date' should not left blank.");
                return false;
            }
            else if (($("#txtMECostPerHour").val() == undefined || $("#txtMECostPerHour").val() == "")) {
                $("#txtMECostPerHour").focus();
                validateCostflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Cost per hour' should not left blank.");
                return false;
            }
            else if (dateVariable == 'Invalid Date') {
                $("#MECostEffectiveDate").focus();
                validateCostflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Effective from date' invalid.");
                return false;
            }
            else {
                validateCostflag = true;
                return true;
            }
        }
        function clearCostDetails() {
            $("#MECostEffectiveDate").val("");
            $("#txtMECostPerHour").val("");
        }
        function cancleCostDetails() {
            clearCostDetails();
        }

        function GetSelectedCost(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                selectedCostId.push(parseInt(row.find('#hdnrm_EmployeeCostID').val()));
            }
            else {
                if (selectedCostId != 'undefined' && selectedCostId.length > 0) {
                    var removeGrp = row.find('#hdnrm_EmployeeCostID').val();
                    selectedCostId.remove(parseInt(removeGrp));
                }
            }
        }

        function DeleteCost() {
            var isSelectedCost = selectedCostId;
            if (isSelectedCost.length > 0) {
                $('#DeleteConfirmCostModal').modal('show');

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }

        function DeleteCostAfterConfirm() {
            var isSelectedResource = selectedCostId.toString();//GetSelectedCost();
           // var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (isSelectedResource.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/DeleteSaveCostDetails',
                    type: "POST",
                    data: JSON.stringify(isSelectedResource),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (isSelectedResource) {
                            xhr.setRequestHeader("Params", encryptString(isJson(isSelectedResource) ? isSelectedResource : JSON.stringify(isSelectedResource)));
                        }
                    },
                    success: function (data) {
                        if (data != "") {
                            alertify.set('notifier', 'position', 'top-right');
                            if (data.notDeletedCount > 0)
                                alertify.success(data.deletedCount + ' records deleted Successfully.' + data.notDeletedCount + ' records not deleted.');
                            else
                                alertify.success(data.deletedCount + ' records deleted Successfully.');
                        }
                        CurrentTabObject.Cost = 'false';
                        GetCostList($('#hdnEmployee_UniqueIDTab').val());//  ShowDUManager();
                        CurrentTabObject.Cost = 'true';
                        $('#DeleteConfirmCostModal').modal('hide');
                        $(".Resourcedetailpanel").show();
                        $('html,body').animate({
                            scrollTop: $(".Resourcedetailpanel").offset().top - 60
                        }, 'slow');
                    },
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    $('#DeleteConfirmPreWorkExpModal').modal('hide');
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "OK") {  //200
                            CurrentTabObject.Cost = 'false';
                            GetCostList($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.Cost = 'true';
                            $('#DeleteConfirmCostModal').modal('hide');

                        }

                        // StopAjaxLoader("#bodyCertification-Details");
                        $('#DeleteConfirmCostModal').modal('hide');
                        $(".Resourcedetailpanel").show();
                        $('html,body').animate({
                            scrollTop: $(".Resourcedetailpanel").offset().top - 60
                        }, 'slow');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            selectedCostId = [];
            isSelectedResource = "";
        }

        function GetCurrencySymbolCost() {
            //Added By Rutuja D. on 5 Aug 2021 For Edit Currency Cost
            $('#btnSaveCost').show();
            $('#btnsave').show();
            $('#btnUpdateCost').hide();
            //End of Added By Rutuja D. on 5 Aug 2021 For Edit Currency Cost
            var EmployeeID = $('#hdnEmployee_UniqueIDTab').val();
            //StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetCurrencySymbol',
                type: "POST",
                data: JSON.stringify(EmployeeID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (EmployeeID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(EmployeeID) ? EmployeeID : JSON.stringify(EmployeeID)));
                    }
                },
                success: function (data) {
                    var symbol = data;
                    $.each(symbol, function (index, obj) {
                        $(".currencysymbol").html(obj.CurrencySymbol);
                    });

                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
        //end Cost

        //Skill start

        function GetSkillDetails() {

            if (CurrentTabObject != null && CurrentTabObject.Skill == "false") {

                var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
                GetSkillList(EmployeeId);

                CurrentTabObject.Skill = 'true';
            }
        }
        function GetSkillList(EmployeeID) {
            GlobalHasCoreCompetency = ""; GlobalCoreToolId = ""; //Added By Rutuja D. on 29 July 2021
            CurrentTabObject.Skill = 'true';
            var strHTML = "";
            //StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetSkillsDetails',
                type: "POST",
                data: JSON.stringify(EmployeeID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (EmployeeID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(EmployeeID) ? EmployeeID : JSON.stringify(EmployeeID)));
                    }
                },
                success: function (data) {
                    var EmployeeSkillDetails = data;
                    var i = 0;
                    $.each(EmployeeSkillDetails, function (index, obj) {
                        i = i + 1;
                        var corecompetancy = "";
                        if (obj.HasCoreCompetency == false) { corecompetancy = 'No'; }
                        else {
                            corecompetancy = 'Yes';
                            GlobalHasCoreCompetency = 1; GlobalCoreToolId = obj.ToolID; //Added By Rutuja D. on 29 July 2021
                        }
                        var ParameterValue = "";
                        var Mexp = "";
                        var Yexp = "";
                        if (obj.ParameterValue == null) { ParameterValue = ""; } else { ParameterValue = obj.ParameterValue }
                        if (obj.MonthsOfExperience == 0) {
                            Mexp = "";
                        }
                        else {
                            Mexp = obj.MonthsOfExperience;
                        }
                        if (obj.YearsOfExperience == 0) {
                            Yexp = "";
                        }
                        else {
                            Yexp = obj.YearsOfExperience;
                        }
                        strHTML += '<tr>' +
                            //Commented And Added By Reshma Chavan for getting Skill in Edit Mode
                            //'<td class="text-start"><a href="javascript:;" class="skilleditlink" onclick="editSkill()"</a><input type="hidden" name="hdnrm_EmployeeSkillID" id="hdnrm_EmployeeSkillID" value= ' + obj.EmployeeSkillID + '> ' + obj.Description + '</td>' +
                            '<td class="text-start"><a href="javascript:;" class="skilleditlink" onclick="editSkill(' + EmployeeID + ')"</a><input type="hidden" name="hdnrm_EmployeeSkillID" id="hdnrm_EmployeeSkillID" value= ' + obj.EmployeeSkillID + '> ' + obj.Description + '</td>' +
                            //End of Commented And Added By Reshma Chavan for getting Skill in Edit Mode
                            '<td> ' + Yexp + '</td>' +
                            '<td> ' + Mexp + '</td>' +
                            '<td> ' + ParameterValue + '</td>' +
                            '<td> ' + corecompetancy + '</td>' +
                            '<td>  <div class="custom_chckbox"><input id="MEskill' + i + '" class="chckskilltbl" type="checkbox" onclick="checkUncheckforSkill();GetSelectedSkill(this);">' +
                            '<label for="MEskill' + i + '"></label>';
                    });
                    $('#emsubtabSkillTbl').dataTable().fnDestroy();
                    $("#empSkilltbl").html(strHTML);
                    LoadPaginationForSkill(data);
                    //StopAjaxLoader("#bodyBusiness-group");
                    $(".chckskill").prop("checked", false);
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }

        function LoadPaginationForSkill(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            skillTable = $('#emsubtabSkillTbl').dataTable({
                "sscrolly": (0.5 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                "lengthChange": false,
                "searching": false,
                //Added by imran on 24-08-2022
                pageLength: 10,
                //End of comment by imran on 24-08-2022
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [5] }]// Added By Pradip on 20 July 2021
            });

        }


        function SaveSkillDetails(isSavenAdd) {

            var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
            checkSkillValidation();
            if (validateSkillflag == true) {
                var ToolID = $("#cboempskill").val();
                if ($("#cboskillyear").val() == "") {
                    var YearsOfExperience = 0;
                }
                else {
                    var YearsOfExperience = $("#cboskillyear").val();
                }

                if ($("#cboskillyear").val() == "") {
                    var MonthsOfExperience = 0;
                }
                else {
                    var MonthsOfExperience = $("#cboskillmonth").val();
                }

                if ($("#cboskillProficiency").val() == "") {
                    var Proficiency = 0;
                }
                else {
                    var Proficiency = $("#cboskillProficiency").val();
                }

                var HasCoreCompetency = 0;
                if ($("#MEcoreCompetencyCheck").is(':checked')) {
                    HasCoreCompetency = 1;
                } else {
                    HasCoreCompetency = 0;
                }
                // var HasCoreCompetency = $("#MEcoreCompetencyCheck").val();
                var Notes = $("#txtSkillNotes").val();
                var CreatedBy = '<%= Session("strUserName") %>';
                var EmployeeSkillID = $("#hiddenskillId").val();
                var Op_Patameters = {
                    EmployeeId: EmployeeId,
                    ToolID: ToolID,
                    YearsOfExperience: YearsOfExperience,
                    MonthsOfExperience: MonthsOfExperience,
                    Proficiency: Proficiency,
                    HasCoreCompetency: HasCoreCompetency,
                    Notes: Notes,
                    CreatedBy: CreatedBy,
                    EmployeeSkillID: EmployeeSkillID

                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/SaveSkillsDetails',
                    method: 'Post',
                    data: JSON.stringify(Op_Patameters),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Op_Patameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Op_Patameters) ? Op_Patameters : JSON.stringify(Op_Patameters)));
                        }
                    },
                    success: function (data) {
                        // CurrentGRPTabObject.GrpManager = 'false';
                        //ShowGRPManager();     

                        GetSkillList($('#hdnEmployee_UniqueIDTab').val());

                        //  CurrentGRPTabObject.GrpManager = 'true';
                        if (isSavenAdd == 0) {
                            if (data == "Skill already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $('#MESkillModal').modal('show');

                            } else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                clearSkillDetails();
                                FillSkills(EmployeeId, 0); //Added by Chetan M on 4 Aug 2021                              
                                $('#MESkillModal').modal('hide');

                            }

                        }
                        else {
                            if (data == "Skill already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $('#MESkillModal').modal('show');
                            } else {
                                clearSkillDetails();
                                FillSkills(EmployeeId, 0); //Added by Chetan M on 4 Aug 2021                               
                                $('#MESkillModal').modal('show');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);

                            }

                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            // Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }

                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);
                        }

                        //StopAjaxLoader("#bodyGlobal-Resource");
                        if (isSavenAdd == 0) {
                            $('#MESkillModal').modal('hide');
                        }
                    }
                })
            } else {
                return false;
            }

        }

        var validateSkillflag = false;
        function checkSkillValidation() {
            if (($("#cboempskill").val() == undefined || $("#cboempskill").val() == "" || $("#cboempskill").val() == 0)) {
                $("#cboempskill").focus();
                validateSkillflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Skill' should not left blank.");
                return false;
            }
            //Commented By RehanC for enabling multiple Core Competency on 4th April 2023
            //Added By Rutuja D. on 29 July 2021 For Core Competency Alert Missing
            //else if (GlobalHasCoreCompetency == 1) {
            //    if ($("#MEcoreCompetencyCheck").is(':checked')) {
            //        //Commented By Reshma Chavan on 23 Feb 2002 
            //        //if ($("#cboempskill").val() == GlobalCoreToolId) {
            //        validateSkillflag = false;
            //        alertify.set('notifier', 'position', 'top-right');
            //        alertify.error("'Core Competency' is  already selected for other Skill");
            //        return false;
            //        //}
            //        //else {
            //        //    validateSkillflag = true;
            //        //    return true;
            //        //}
            //        //End of Commented By Reshma Chavan on 23 Feb 2002
            //    } else {
            //        validateSkillflag = true;
            //        return true;
            //    }
            //}
            //End of Added By Rutuja D. on 29 July 2021 For Core Competency Alert Missing

                //Added By Riddhesh Patil on 10-NOV-2022        
            else if (checkSpecialCharacter($("#txtSkillNotes").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Notes should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtSkillNotes").focus();
                return false;
            }
			//End of Added By Riddhesh Patil

            else {
                validateSkillflag = true;
                return true;
            }
        }
        function clearSkillDetails() {
            $("#cboempskill").val("");
            $("#cboskillyear").val("");
            $("#cboskillmonth").val("");
            $("#cboskillProficiency").val("");
            //$("#MEcoreCompetencyCheck").val("");
            $('#MEcoreCompetencyCheck').prop('checked', false);
            $("#txtSkillNotes").val("");
            $("#hiddenskillId").val(0);
            // $('#hdnEmployee_UniqueIDTab').val('');
        }
        function cancleSkillDetails() {
            clearSkillDetails();
        }

        ///get checked values

        function GetSelectedSkill(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                selectedSkillId.push(parseInt(row.find('#hdnrm_EmployeeSkillID').val()));
            }
            else {
                if (selectedSkillId != 'undefined' && selectedSkillId.length > 0) {
                    var removeGrp = row.find('#hdnrm_EmployeeSkillID').val();
                    selectedSkillId.remove(parseInt(removeGrp));
                }
            }
        }

        function DeleteSkill() {
            var strHTML = "";
            var selectedUniqueId = selectedSkillId.toString();
            if (selectedUniqueId.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/DeleteSkillDetails',
                    type: "POST",
                    data: JSON.stringify(selectedUniqueId),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        // StartLoader("#bodyCertification-Details");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedUniqueId) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedUniqueId) ? selectedUniqueId : JSON.stringify(selectedUniqueId)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //}
                        var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
                        FillSkills(EmployeeId, 0); //Added by Chetan M on 4 Aug 2021
                        //StopAjaxLoader("#bodyCertification-Details");
                        CurrentTabObject.Skill = 'false';
                        GetSkillList($("#hdnEmployee_UniqueIDTab").val());
                        CurrentTabObject.Skill = 'true';
                        //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        //strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                        //End of Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterowSkill').html(strHTML);
                        $('#DeleteConfirmSkillModal').modal('show');
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "OK") {  //200
                            CurrentTabObject.Skill = 'false';
                            GetSkillList($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.Skill = 'true';
                            $('#DeleteConfirmSkillModal').modal('hide');
                            //alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify("Deleted");
                        }

                        // StopAjaxLoader("#bodyCertification-Details");
                        $('#DeleteConfirmSkillModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            selectedSkillId = [];
            isSelectedResource = "";
        }

        //Commented And Added By Reshma Chavan for getting Skill in Edit Mode
        // function editSkill() {
        //Commented and Added by imran 13-10-2021
        //function editSkill(EmployeeID) {
        function editSkill(EmployeeID, SkillID) {
            $('#empSkilltbl').on('click', '.skilleditlink', function () {
                var $row = $(this).closest("tr");
                $tds = $row.find("td");
                var hdnSkillId = $row.find('#hdnrm_EmployeeSkillID').val();
                //Added By Reshma Chavan for getting Skill in Edit Mode
                FillSkills(EmployeeID, hdnSkillId);
                //End of Added By Reshma Chavan for getting Skill in Edit Mode
                GetSkillDetailsOnEdit(hdnSkillId);
                //$(".Resourcedetailpanel").show();
                //$('html,body').animate({
                //    scrollTop: $(".Resourcedetailpanel").offset().top - 60
                //}, 'slow');
                ////used for disable grid
                //$(".DSGtblouter .dataTables_scrollBody, .paginate_button, .backbtn, .addbtn, .deletebtn, .filter,.mainclearalllink").addClass("DisableContent").parent().css("cursor", "no-drop");
                ////$(".table").resize();
                // $(this).closest('tr').addClass('rowhiglight');
            });
            //$('#DsgLevesTab').removeClass("DisableContent");

        }

        //End by imran 18-10-2021
        function GetSkillDetailsOnEdit(EmployeeSkillID) {
            CurrentTabObject.Skill = 'true';
            var strHTML = "";
            //StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetSkillsDetailsById',
                type: "POST",
                data: JSON.stringify(EmployeeSkillID),
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (EmployeeSkillID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(EmployeeSkillID) ? EmployeeSkillID : JSON.stringify(EmployeeSkillID)));
                    }
                },
                success: function (data) {
                    var EmployeeSkillDetails = data;
                    var i = 0;
                    $.each(EmployeeSkillDetails, function (index, obj) {
                        var corecompetancy = "";
                        $("#cboempskill").val(obj.ToolID);
                        $("#cboskillyear").val(obj.YearsOfExperience);
                        $("#cboskillmonth").val(obj.MonthsOfExperience);
                        $("#cboskillProficiency").val(obj.Proficiency);
                        $("#txtSkillNotes").val(obj.Notes);
                        if (obj.HasCoreCompetency == false) {
                            $('#MEcoreCompetencyCheck').prop('checked', false);
                        } else {
                            $('#MEcoreCompetencyCheck').prop('checked', true);
                        }
                        $("#hiddenskillId").val(obj.EmployeeSkillID);
                    });
                    $('#MESkillModal').modal('show');

                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
        //end Skill

        //Start current assignment


        function GetCurrentAssignmentDetails() {
            if (CurrentTabObject != null && CurrentTabObject.CurrentAssignment == "false") {
                var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
                GetCurrentAssignmentList();

                CurrentTabObject.CurrentAssignment = 'true';
                clearCurrentAssignmentfilter();
            }
        }

        function clearCurrentAssignmentfilter() {
            $("#currAssignProjectAsscee").val('');
            $("#currAssignProjectOver").val('');
            $("#currAssignProjectStatus").val('');
        }

        function GetCurrentAssignmentList() {
            var EmployeeID = $('#hdnEmployee_UniqueIDTab').val();
            CurrentTabObject.CurrentAssignment = 'true';
            var Accessible = $("#currAssignProjectAsscee").val();
            var Status = $("#currAssignProjectOver").val();
            var IsActive = $("#currAssignProjectStatus").val();
            var Op_Patameters = {
                EmployeeID: EmployeeID,
                Accessible: Accessible,
                Status: Status,
                IsActive: IsActive,
            };
            var strHTML = "";
            StartLoader("#body-tblEmplyee");
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetCurrentAssignment',
                type: "POST",
                data: JSON.stringify(Op_Patameters),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Op_Patameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Op_Patameters) ? Op_Patameters : JSON.stringify(Op_Patameters)));
                    }
                },
                success: function (data) {
                    var EmployeeCurrentAssDetails = data;
                    var i = 0;
                    $.each(EmployeeCurrentAssDetails, function (index, obj) {
                        i = i + 1;
                        var ExpectedStartDate;
                        var ExpectedEndDate;
                        var ActualStartDate;
                        var ActualEndDate;

                        //Commented And Added By Reshma Chavan on 23 Feb 2022 for showing NAN for Accessible filter
                        //if (obj.ExpectedStartDate == null) { ExpectedStartDate = ""; } else { ExpectedStartDate = convert(obj.ExpectedStartDate); }
                        //if (obj.ExpectedEndDate == null) { ExpectedEndDate = ""; } else { ExpectedEndDate = convert(obj.ExpectedEndDate); }
                        //if (obj.ActualStartDate == null) { ActualStartDate = ""; } else { ActualStartDate = convert(obj.ActualStartDate); }
                        //if (obj.ActualEndDate == null) { ActualEndDate = ""; } else { ActualEndDate = convert(obj.ActualEndDate); }
                        if (obj.ExpectedStartDate == null || obj.ExpectedStartDate == 'N/A') { ExpectedStartDate = ""; } else { ExpectedStartDate = convert(obj.ExpectedStartDate); }
                        if (obj.ExpectedEndDate == null || obj.ExpectedEndDate == 'N/A') { ExpectedEndDate = ""; } else { ExpectedEndDate = convert(obj.ExpectedEndDate); }
                        if (obj.ActualStartDate == null || obj.ActualStartDate == 'N/A') { ActualStartDate = ""; } else { ActualStartDate = convert(obj.ActualStartDate); }
                        if (obj.ActualEndDate == null || obj.ActualEndDate == 'N/A') { ActualEndDate = ""; } else { ActualEndDate = convert(obj.ActualEndDate); }
                        //End of Commented And Added By Reshma Chavan on 23 Feb 2022 for showing NAN for Accessible filter

                        strHTML += '<tr>' +
                            '<td class="text-start">' + obj.ProjectName + '</td>' +
                            '<td> ' + obj.RoleDescription + '</td>' +
                            '<td> ' + ExpectedStartDate + '</td>' +
                            '<td> ' + ExpectedEndDate + '</td>' +
                            '<td> ' + ActualStartDate + '</td>' +
                            '<td> ' + ActualEndDate + '</td>' +
                            '<td> ' + obj.PlannedEffort + '</td>' +
                            '<td> ' + obj.ActualEffort + '</td>' +
                            '<td> ' + obj.IsActive + '</td>';

                    });
                    $('#emsubtabCurrentAsignmentTbl').dataTable().fnDestroy();
                    $("#empCurrentAssignmenttbl").html(strHTML);
                    LoadPaginationForCurrentAssignment(data);
                    StopAjaxLoader("#body-tblEmplyee");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }

        function LoadPaginationForCurrentAssignment(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            currentAssignmentTable = $('#emsubtabCurrentAsignmentTbl').dataTable({
                "sscrolly": (0.5 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                "lengthChange": false,
                "searching": false,
                //Added by imran on 24-08-2022
                pageLength: 10,
                //End of comment by imran on 24-08-2022
            });

        }
        //end current assignment


        //Employee details delete

        function DeleteEmployeeDetails(EmployeeID) {
            if (EmployeeID > 0) {

                // $('#DeleteConfirmEmployeeModal').modal('show');
                $("#deleteemployeeid").val(EmployeeID);
                DeleteEmployeeAfterConfirm();
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }
        function DeleteEmployeeAfterConfirm() {
            var EmployeeId = $("#deleteemployeeid").val();
            if (EmployeeId > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/DeleteEmployeeDetails',
                    type: "POST",
                    data: JSON.stringify(EmployeeId),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (EmployeeId) {
                            xhr.setRequestHeader("Params", encryptString(isJson(EmployeeId) ? EmployeeId : JSON.stringify(EmployeeId)));
                        }
                    },
                    success: function (data) {
                        if (data.indexOf("deleted successfully.") >= 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                        }
                        //   CurrentTabObject.VisaDetails = 'false';
                        GetAllEmployeeList(null);
                        $("#srchMElist").val('');
                        //  CurrentTabObject.VisaDetails = 'true';
                        //$('#DeleteConfirmEmployeeModal').modal('hide');
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "OK") {  //200
                            // CurrentTabObject.Skill = 'false';
                            // GetEmployeeVisaDetailsList($("#hdnEmployee_UniqueIDTab").val());
                            //   CurrentTabObject.Skill = 'true';
                            $('#DeleteConfirmEmployeeModal').modal('hide');

                        }

                        // StopAjaxLoader("#bodyCertification-Details");
                        $('#DeleteConfirmEmployeeModal').modal('hide');
                    }
                })
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }

        function CancelEmployeeDelete() {
            $("#deleteemployeeid").val('0');
        }
        //Employee details delete end

        //visa details delete

        function GetSelectedVisa(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                selectedVisaId.push(parseInt(row.find('#hdnrm_EmployeeVisaID').val()));
            }
            else {
                if (selectedVisaId != 'undefined' && selectedVisaId.length > 0) {
                    var removeGrp = row.find('#hdnrm_EmployeeVisaID').val();
                    selectedVisaId.remove(parseInt(removeGrp));
                }
            }
        }
        function DeleteVisaDetails() {
            var isSelectedVisa = selectedVisaId;
            if (isSelectedVisa.length > 0) {
                $('#DeleteVisaModal').modal('show');

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }
        function DeleteVisaAfterConfirm() {
            var isSelectedResource = selectedVisaId.toString();
            if (isSelectedResource.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/DeleteVisaDetails',
                    type: "POST",
                    data: JSON.stringify(isSelectedResource),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (isSelectedResource) {
                            xhr.setRequestHeader("Params", encryptString(isJson(isSelectedResource) ? isSelectedResource : JSON.stringify(isSelectedResource)));
                        }
                    },
                    success: function (data) {
                        if (data != "") {
                            alertify.set('notifier', 'position', 'top-right');
                            if (data.notDeletedCount > 0)
                                alertify.success(data.deletedCount + ' records deleted Successfully.' + data.notDeletedCount + ' records not deleted.');
                            else
                                alertify.success(data.deletedCount + ' records deleted Successfully.');
                        }
                        CurrentTabObject.VisaDetails = 'false';
                        GetEmployeeVisaDetailsList($('#hdnEmployee_UniqueIDTab').val());//  ShowDUManager();
                        CurrentTabObject.VisaDetails = 'true';
                        $('#DeleteVisaModal').modal('hide');
                    },
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    $('#DeleteConfirmPreWorkExpModal').modal('hide');
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "OK") {  //200
                            CurrentTabObject.VisaDetails = 'false';
                            GetEmployeeVisaDetailsList($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.VisaDetails = 'true';
                            $('#DeleteVisaModal').modal('hide');

                        }

                        // StopAjaxLoader("#bodyCertification-Details");
                        $('#DeleteVisaModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            selectedVisaId = [];
            isSelectedResource = "";
        }
        //visa details delete end



        //upload xslx
        var EmpXslxList = ''
        async function EmpUploadxlsfile() {
      
            StartLoader("#body-tblEmplyee");
            Fillstep_2DropDowUsingColumnName();
            var SelectedFile = txtFileUpload.files;
            var SelectedFileName = document.getElementById('dvShowFileName').innerHTML;
          if (SelectedFile != 'undeifned' && SelectedFile.length > 0 && SelectedFileName != "") {
              var isFileValid = await fileValidation();
                if (isFileValid === true) {
                    var data = new FormData();
                    data.append("file", SelectedFile[0]);
                    $.ajax({
                        url: strUrl + '/api/RM_EmployeeMaster/UploadEmpXlsxFile',
                        type: "POST",
                        data: data,
                        contentType: false,
                        processData: false,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        },
                        success: function (data) {
                            //EmpXslxList = data;
                            //ReloadEmpXslxData(EmpXslxList);
                            //$("#btnaStep2").click();

                            EmpXslxList = data;
                            // ReloadEmpXslxData(EmpXslxList);

                            if (EmpXslxList.length > 0) {
                                var ChkValidationBlank = BlankExcelColumnCheck(EmpXslxList);
                                ChkValidationBlank = ChkValidationBlank.split('~');
                            }

                            if (ChkValidationBlank[0] == 0) {
                                ReloadEmpXslxData(EmpXslxList);
                              //Comment And Added By Riddhesh Patil on 13 April 2023
                              //  $("#btnaStep2").click();

                                $("#exceluploadsteps .pointerDisable").removeClass('active');
                                $("#exceluploadsteps ul.nav-wizard li:nth-child(2)").addClass('active');
                                $("#exceluploadsteps .tab-pane").removeClass('active');
                                $("#PBEUstep2").addClass('active');
                               //End of Comment And Added By Riddhesh Patil on 13 April 2023 
                            }
                            else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ChkValidationBlank[1])

                            }
                            //StopAjaxLoader("#bodyInfraGroup");
                            //$(".chckHead").prop("checked", false);
                        },
                        //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        //error: function (err) {
                        //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        //    //StopAjaxLoader("#bodyBusiness-group");
                        //}
                        error: function (xhr, ajaxOptions, thrownError) {
                            if (ajaxOptions == "error") {
                                if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                    window.open("../../../Default.aspx", "_top");
                                } else {
                                    window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                }
                            }
                        }
                        //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    });
                }
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select/Drop the file.");
            }
            StopAjaxLoader("#body-tblEmplyee");
        }

        //Added by imran 23-08-2021
        function BlankExcelColumnCheck(objXlsx) {
            var XlsxObj = objXlsx;
            var TBlankCheck = 0;
            var tColumnvalue = '';

            $.each(XlsxObj, function (index, objXlsx) {
                console.log(objXlsx.ColumnError);
                if (objXlsx.ColumnError != null) {
                    TBlankCheck += 1;
                    if (objXlsx.ColumnError.indexOf(':{0}') > -1) {
                        tColumnvalue = objXlsx.ColumnError.replaceAll(':{0}', '<br>');
                        tColumnvalue = tColumnvalue.replaceAll(':{1}', '<br>');
                        tColumnvalue = tColumnvalue.replaceAll(':', '<BR>');
                    } else if (objXlsx.ColumnError.indexOf(':{1}') > -1) {
                        tColumnvalue += objXlsx.ColumnError.replaceAll(':{1}', '<BR>');
                    }
                    else if (objXlsx.ColumnError.indexOf(':') > -1) {
                        tColumnvalue += objXlsx.ColumnError.replaceAll(':', '<BR>');
                    }
                    else { }
                }
            });
            tColumnvalue = tColumnvalue.replace('<br>', '');
            return TBlankCheck + '~' + tColumnvalue.replaceAll(':', '<br>');
        }

        //End by imran 23-08-2021
       
        async function fileValidation() {
            //debugger;
            var fileInput = document.getElementById('txtFileUpload');
            var filePath = fileInput.value;
            // Allowing file type 
            //Commented & Added By Rutuja D. on 13 Aug 2021 For Allow xls File format
            //var allowedExtensions = /(\.xlsx)$/i;
            var allowedExtensions = /(\.(xlsx|xls))$/i;
            //End of Commented & Added By Rutuja D. on 13 Aug 2021 For Allow xls File format

            if (!allowedExtensions.exec(filePath)) {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("Only xlsx file format is allowed.");
                alertify.error("Only xlsx and xls file format is allowed.");
                // fileInput.value = ''; 
                return false;
            }
            //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
            else if (fileInput.value != "") {
                var fileName = fileInput.value;
                var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

                var objFileName = fileInput;
                isValidTypeExeCheck = false;
                //Commented and Added by Aditya J. on 25-11-2024
                //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
                var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
                //End of comment Added by Aditya J. on 25-11-2024
                isValidTypeExeCheck = ValidExtsExe.includes(extension);

                if (isValidTypeExeCheck) {
                    const file = objFileName.files[0];
                    //const error = await validateDocFileForExe(file);
                    //console.log(error);
                    //await checkFileForExe(file);
                    await validateDocFileForExe(file)
                        .then(() => {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success("File is valid and ready to upload.");
                            isValidTypeExeCheckFlag = true
                        })
                        .catch(error => {

                            //Added by Aditya J. on 22-11-2024
                            document.getElementById('dvShowFileName').innerHTML = "";
                            document.getElementById('plabelName').innerHTML = "Attach file or drop here :-";
                            //End of Added by Aditya J. on 22-11-2024
                           
                            console.log(error);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                            isValidTypeExeCheck = false;
                            isValidTypeExeCheckFlag = false;
                            $(objtxtFileName).val("");
                           
                            /*$(objFileName).attr("placeholder", "Upload File");*/
                            //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                            return;
                        });



                    if (!isValidTypeExeCheck) {
                        return;
                    }
                }

                //$(objtxtFileName).val("");

                //Ended by Parth Godshelwar
            }
                //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
            //else if (SelectedFile == 'undeifned' || SelectedFile.length = 0 || SelectedFileName ==""){
            //    alertify.set('notifier', 'position', 'top-right');
            //  alertify.error("Please select file.");
            //}
            else { return true; }
            return isValidTypeExeCheckFlag;
        }

        //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
        //function validateDocFileForExe(file) {

        //    return new Promise((resolve, reject) => {
        //        //debugger;

        //        const reader = new FileReader();

        //        reader.onload = function (e) {
        //            const arrayBuffer = e.target.result;
        //            const uint8 = new Uint8Array(arrayBuffer);

        //            // Function to search for a specific byte sequence
        //            const containsSignature = (signature) => {
        //                for (let i = 0; i < uint8.length - signature.length + 1; i++) {
        //                    let found = true;
        //                    for (let j = 0; j < signature.length; j++) {
        //                        if (uint8[i + j] !== signature[j]) {
        //                            found = false;
        //                            break;
        //                        }
        //                    }
        //                    if (found) return true;
        //                }
        //                return false;
        //            };

        //            // Check for 'MZ' signature (common for Windows EXE files)
        //            const mzSignature = [0x4D, 0x5A]; // 'M' 'Z'
        //            if (containsSignature(mzSignature)) {
        //                reject("Upload restricted: This file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // Additional checks can be added here (e.g., searching for .exe strings)
        //            // Example: Check for ".exe" string in ASCII
        //            const exeString = [0x2E, 0x65, 0x78, 0x65]; // '.' 'e' 'x' 'e'
        //            if (containsSignature(exeString)) {
        //                reject("Upload restricted: This file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // If no signatures are found, the file is considered safe
        //            resolve();
        //        };

        //        reader.onerror = function () {
        //            reject("Error reading the file. Please try again.");
        //        };

        //        // Read the file as an ArrayBuffer
        //        reader.readAsArrayBuffer(file);
        //    });
        //}

        //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not

        function IrmNextStep_2() {
            //Added by Chetan M on 16 Aug 2021 for manditory validation alert
            alertify.set('notifier', 'position', 'top-right');
            if ($("#CboIrmExcelColumn_A").val() == "" || $("#CboIrmExcelColumn_A").val() == 0 || $("#CboIrmExcelColumn_A").val() != "1") {
                alertify.error("Please select Employee Name.");
                $("#CboIrmExcelColumn_A").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_B").val() == "" || $("#CboIrmExcelColumn_B").val() == 0 || $("#CboIrmExcelColumn_B").val() != "2") {
                alertify.error("Please select User.");
                $("#CboIrmExcelColumn_B").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_C").val() == "" || $("#CboIrmExcelColumn_C").val() == 0 || $("#CboIrmExcelColumn_C").val() != "3") {
                alertify.error("Please select Employee Code.");
                $("#CboIrmExcelColumn_C").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_D").val() == "" || $("#CboIrmExcelColumn_D").val() == 0 || $("#CboIrmExcelColumn_D").val() != "4") {
                alertify.error("Please select Gender.");
                $("#CboIrmExcelColumn_D").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_E").val() == "" || $("#CboIrmExcelColumn_E").val() == 0 || $("#CboIrmExcelColumn_E").val() != "5") {
                alertify.error("Please select Email.");
                $("#CboIrmExcelColumn_E").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_F").val() == "" || $("#CboIrmExcelColumn_F").val() == 0 || $("#CboIrmExcelColumn_F").val() != "6") {
                alertify.error("Please select To Birth Date.");
                $("#CboIrmExcelColumn_F").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_G").val() == "" || $("#CboIrmExcelColumn_G").val() == 0 || $("#CboIrmExcelColumn_G").val() != "7") {
                alertify.error("Please select Role.");
                $("#CboIrmExcelColumn_G").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_H").val() == "" || $("#CboIrmExcelColumn_H").val() == 0 || $("#CboIrmExcelColumn_H").val() != "8") {
                alertify.error("Please select Reporting To.");
                $("#CboIrmExcelColumn_H").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_I").val() == "" || $("#CboIrmExcelColumn_I").val() == 0 || $("#CboIrmExcelColumn_I").val() != "9") {
                alertify.error("Please select Joining Date.");
                $("#CboIrmExcelColumn_I").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_J").val() == "" || $("#CboIrmExcelColumn_J").val() == 0 || $("#CboIrmExcelColumn_J").val() != "10") {
                alertify.error("Please select Business Group.");
                $("#CboIrmExcelColumn_J").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_K").val() == "" || $("#CboIrmExcelColumn_K").val() == 0 || $("#CboIrmExcelColumn_K").val() != "11") {
                alertify.error("Please select Organization Unit.");
                $("#CboIrmExcelColumn_K").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_L").val() == "" || $("#CboIrmExcelColumn_L").val() == 0 || $("#CboIrmExcelColumn_L").val() != "12") {
                alertify.error("Please select Designation.");
                $("#CboIrmExcelColumn_L").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_M").val() == "" || $("#CboIrmExcelColumn_M").val() == 0 || $("#CboIrmExcelColumn_M").val() != "13") {
                alertify.error("Please select Department.");
                $("#CboIrmExcelColumn_M").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_N").val() == "" || $("#CboIrmExcelColumn_N").val() == 0 || $("#CboIrmExcelColumn_N").val() != "14") {
                alertify.error("Please select Cost To Company.");
                $("#CboIrmExcelColumn_N").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_O").val() == "" || $("#CboIrmExcelColumn_O").val() == 0 || $("#CboIrmExcelColumn_O").val() != "15") {
                alertify.error("Please select Cost Per Hour.");
                $("#CboIrmExcelColumn_O").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_P").val() == "" || $("#CboIrmExcelColumn_P").val() == 0 || $("#CboIrmExcelColumn_P").val() != "16") {
                alertify.error("Please select Deployable.");
                $("#CboIrmExcelColumn_P").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_Q").val() == "" || $("#CboIrmExcelColumn_Q").val() == 0 || $("#CboIrmExcelColumn_Q").val() != "17") {
                alertify.error("Please select Currency.");
                $("#CboIrmExcelColumn_Q").focus();
                return false;
            }
            //Added By Dipali V on  3rd Sep 2021 
            if ($("#CboIrmExcelColumn_R").val() == "" || $("#CboIrmExcelColumn_R").val() == 0 || $("#CboIrmExcelColumn_R").val() != "18") {
                alertify.error("Please select Employee Type.");
                $("#CboIrmExcelColumn_R").focus();
                return false;
            }


            if ($("#CboIrmExcelColumn_S").val() == "" || $("#CboIrmExcelColumn_S").val() == 0 || $("#CboIrmExcelColumn_S").val() != "19") {
                alertify.error("Please select Rate.");
                $("#CboIrmExcelColumn_S").focus();
                return false;
            }
            //End of Added By Dipali V on  3rd Sep 2021 

            else {
                //End of Added by Chetan M on 16 Aug 2021 for manditory validation alert
                //Comment And Added By Riddhesh Patil on 13 April 2023 
                //$("#btnaStep3").click();
                $("#exceluploadsteps .pointerDisable").removeClass('active');
                $("#exceluploadsteps ul.nav-wizard li:nth-child(3)").addClass('active');
                $("#exceluploadsteps .tab-pane").removeClass('active');
                $("#PBEUstep3").addClass('active');
                //End of Comment And Added By Riddhesh Patil on 13 April 2023 
            }

        }
        function IrmBackStep_2() {
            //Comment And Added By Riddhesh Patil on 13 April 2023 
           // $("#btnaStep1").click();
            $("#exceluploadsteps .pointerDisable").removeClass('active');
            $("#exceluploadsteps ul.nav-wizard li:nth-child(1)").addClass('active');
            $("#exceluploadsteps .tab-pane").removeClass('active');
            $("#PBEUstep1").addClass('active');
            //End of Comment And Added By Riddhesh Patil on 13 April 2023 
        }
        function IrmBackStep_3() {
            //Comment And Added By Riddhesh Patil on 13 April 2023 
            //$("#btnaStep2").click();
            $("#exceluploadsteps .pointerDisable").removeClass('active');
            $("#exceluploadsteps ul.nav-wizard li:nth-child(2)").addClass('active');
            $("#exceluploadsteps .tab-pane").removeClass('active');
            $("#PBEUstep2").addClass('active');
            //End of Comment And Added By Riddhesh Patil on 13 April 2023 
        }
        function showName() {
            var name = document.getElementById('txtFileUpload');
            //If Condition Added By Rutuja D. on 17 Sep 2021 For Javascript coming REading FileName
            if (name.value.length == 0) {
                document.getElementById('dvShowFileName').innerHTML = "";
                document.getElementById('plabelName').innerHTML = "";
                document.getElementById('dvShowFileNameStep3').innerHTML = "";
                document.getElementById('plabelName').innerHTML = "Attach file or drop here :-";
            } else {
                var fileName = name.files.item(0).name;
                document.getElementById('dvShowFileName').innerHTML = fileName;
                document.getElementById('plabelName').innerHTML = "";
                var currentDate = new Date();
                document.getElementById('dvShowFileNameStep3').innerHTML = fileName + "( " + formatDateWithTime(currentDate) + " )";
            }
        };
        function formatDateWithTime(date) {
            var hours = date.getHours();
            var minutes = date.getMinutes();
            var ampm = hours >= 12 ? 'pm' : 'am';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'
            minutes = minutes < 10 ? '0' + minutes : minutes;
            var strTime = hours + ':' + minutes + ' ' + ampm;
            return (date.getMonth() + 1) + "-" + date.getDate() + "-" + date.getFullYear() + "  " + strTime;
        }

        function Fillstep_2DropDowUsingColumnName() {
            var Step2DrpList = [
                { Name: 'Employee Name', Value: 1 },
                { Name: 'User', Value: 2 },
                { Name: 'Employee Code', Value: 3 },
                { Name: 'Gender', Value: 4 },
                { Name: 'Email', Value: 5 },
                { Name: 'Birth Date', Value: 6 },
                { Name: 'Role', Value: 7 },
                { Name: 'Reporting To', Value: 8 },
                { Name: 'Joining Date', Value: 9 },
                { Name: 'Business Group', Value: 10 },
                { Name: 'Organization Unit', Value: 11 },
                { Name: 'Designation', Value: 12 },
                { Name: 'Department', Value: 13 },
                { Name: 'Cost To Company', Value: 14 },
                { Name: 'Cost Per Hour', Value: 15 },
                { Name: 'Deployable', Value: 16 },
                { Name: 'Currency', Value: 17 },
                { Name: 'Employee Type', Value: 18 },
                { Name: 'Rate Per Hour', Value: 19 },

            ];
            var arrExcelFields = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S"];
            var CboIrmExcelColumnHTML = ''
            CboIrmExcelColumnHTML += "<option value='0'>Select Column </option>";
            for (var i = 0; i < Step2DrpList.length; i++) {
                var listComponent = Step2DrpList[i];
                CboIrmExcelColumnHTML += ('<option value=' + listComponent.Value + ' >' + listComponent.Name + '</option>');

            }
            var LengthOfExcelField = arrExcelFields.length;

            for (var i = 0; i < LengthOfExcelField; i++) {
                var CboID = "#CboIrmExcelColumn_" + arrExcelFields[i];
                $(CboID).html(CboIrmExcelColumnHTML)
                $(CboID).prop("disabled", true);
                $(CboID).val(i + 1);
            }
        }

        function ResetExcelFiledDropdown() {
            var arrExcelFields = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "P", "Q", "R", "S"];
            var LengthOfExcelField = arrExcelFields.length;

            for (var i = 0; i < LengthOfExcelField; i++) {
                var CboID = "#CboIrmExcelColumn_" + arrExcelFields[i];
                $(CboID).val(0);
            }
        }
        $('#txtSearchXlsxEmpName').keyup(function () {
            SearchEmplistByName();
        });
        function SearchEmplistByName() {
            var SearchedXslxEmpNameText = $("#txtSearchXlsxEmpName").val();
            var FilterxslxList = EmpXslxList.filter(function (x) { return x.EmployeeName.toLowerCase().indexOf(SearchedXslxEmpNameText.toLowerCase()) !== -1 });
            ReloadEmpXslxData(FilterxslxList);
        }

        function ReloadEmpXslxData(XlsxList) {
            var strHTML = "";
            if (XlsxList.length > 0) {
                $.each(XlsxList, function (index, objXlsx) {
                    if (objXlsx.ColumnError == null || objXlsx.ColumnError == "" || objXlsx.ColumnError == 'undefined') {
                        strHTML += '<tr><td><div class="custom_chckbox" '
                        strHTML += ' <input type = "hidden" name = "hdn_EmpRoleId2"  id ="hdn_EmpRoleId2" value =' + objXlsx.RoleID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpRoleId"  id ="hdn_EmpRoleId" value =' + objXlsx.RoleID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpBusinessGroupID"  id ="hdn_EmpBusinessGroupID" value =' + objXlsx.BusinessGroupID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpLocationID" id = "hdn_EmpLocationID" value = ' + objXlsx.LocationID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpDesignationID" id = "hdn_EmpDesignationID" value = ' + objXlsx.DesignationID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpDepartmentID" id = "hdn_EmpDepartmentID" value = ' + objXlsx.DepartmentID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpCurrencyID" id = "hdn_EmpCurrencyID" value = ' + objXlsx.CurrencyID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpReportingToId" id = "hdn_EmpReportingToId" value = ' + objXlsx.ReportingToId + ' >';
                        strHTML += ' <input id="' + index + '"   class="chcktblXlsx" type="checkbox" checked="true"><label for="' + index + '"></label></div> </td>';
                        strHTML += ' <td> ' + objXlsx.EmployeeName + ' </td> <td> ' + objXlsx.UserName + '</td> <td> ' + objXlsx.EmployeeCode + '</td> <td>' + objXlsx.Gender + '</td><td>' + objXlsx.Email + '</td>  <td>' + objXlsx.BirthDate + '</td>  <td>' + objXlsx.RoleName + '</td>  <td>' + objXlsx.ReportingTo + '</td>  <td>' + objXlsx.JoiningDate + '</td><td>' + objXlsx.BusinessGroup + '</td>  <td>' + objXlsx.OrganizationUnit + '</td> ';
                        strHTML += ' <td>' + objXlsx.Designation + '</td><td> ' + objXlsx.Department + '</td><td>' + objXlsx.EmployeeType + '</td>  <td>' + objXlsx.CostToCompany + '</td>  <td>' + objXlsx.RatePerHr + '</td>  <td>' + objXlsx.CostPerHr + '</td>  <td>' + objXlsx.Deployable + '</td>  ';
                        strHTML += ' <td>' + objXlsx.Currency + '</td><td></td><td>';
                        strHTML += ' </tr > ';

                    }
                    else {
                        strHTML += '<tr style="color:red;"><td><div class="custom_chckbox" '
                        strHTML += ' <input type = "hidden" name = "hdn_EmpRoleId2"  id ="hdn_EmpRoleId2" value =' + objXlsx.RoleID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpRoleId"  id ="hdn_EmpRoleId" value =' + objXlsx.RoleID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpBusinessGroupID"  id ="hdn_EmpBusinessGroupID" value =' + objXlsx.BusinessGroupID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpLocationID" id = "hdn_EmpLocationID" value = ' + objXlsx.LocationID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpDesignationID" id = "hdn_EmpDesignationID" value = ' + objXlsx.DesignationID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpDepartmentID" id = "hdn_EmpDepartmentID" value = ' + objXlsx.DepartmentID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpCurrencyID" id = "hdn_EmpCurrencyID" value = ' + objXlsx.CurrencyID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpReportingToId" id = "hdn_EmpReportingToId" value = ' + objXlsx.ReportingToId + ' >';
                        strHTML += ' <input id="' + index + '"   class="chcktblXlsx" type="checkbox" disabled="disabled"><label for="' + index + '"></label></div> </td>';
                        strHTML += ' <td> ' + objXlsx.EmployeeName + ' </td> <td> ' + objXlsx.UserName + '</td> <td> ' + objXlsx.EmployeeCode + '</td> <td>' + objXlsx.Gender + '</td><td>' + objXlsx.Email + '</td>  <td>' + objXlsx.BirthDate + '</td>  <td>' + objXlsx.RoleName + '</td>  <td>' + objXlsx.ReportingTo + '</td>  <td>' + objXlsx.JoiningDate + '</td><td>' + objXlsx.BusinessGroup + '</td>  <td>' + objXlsx.OrganizationUnit + '</td> ';
                        strHTML += ' <td>' + objXlsx.Designation + '</td><td> ' + objXlsx.Department + '</td><td>' + objXlsx.EmployeeType + '</td>  <td>' + objXlsx.CostToCompany + '</td>  <td>' + objXlsx.RatePerHr + '</td>  <td>' + objXlsx.CostPerHr + '</td>  <td>' + objXlsx.Deployable + '</td>  ';
                        strHTML += ' <td>' + objXlsx.Currency + '</td><td> ' + objXlsx.ColumnError + '</td>';
                        strHTML += ' </tr > ';
                        // strHTML += '<tr style="color:red;"><td><div class="custom_chckbox" ;
                        ////strHTML += ' <input id="' + index + '" class="chcktblXlsx" type="checkbox" checked="true"><label for="' + index + '"></label></div></td > ';
                        //strHTML += ' </tr > ';
                    }


                });
            } else {
                strHTML = '<tr><td colspan="21">No data found. <td></tr>'
            }
            $("#exluploadTblTbody").html(strHTML);
        }

        function IrmSaveXlsxData() {
            var xlsxSelectedList = []
            var message = '';

            $("#exluploadTbl input[type=checkbox]:checked").each(function () {

                var objxlsxSelectedList = {}
                var row = $(this).closest("tr")[0];
                //var hdnField = $(this).closest("tr").find;
                var FirstTd = $(this).parent().parent("td");//.find("#hdn_EmpBusinessGroupID").val()
                //console.log($('tr td', '#exluploadTbl').eq(0).find('#hdn_EmpLocationID').val());
                var hdn_EmpBusinessGroupID = FirstTd.find('#hdn_EmpBusinessGroupID').val();
                var hdn_EmpLocationID = FirstTd.find('#hdn_EmpLocationID').val();
                var hdn_EmpDesignationID = FirstTd.find('#hdn_EmpDesignationID').val();
                var hdn_EmpDepartmentID = FirstTd.find('#hdn_EmpDepartmentID').val();
                var hdn_EmpCurrencyID = FirstTd.find('#hdn_EmpCurrencyID').val();
                var hdn_EmpReportingToId = FirstTd.find('#hdn_EmpReportingToId').val();
                var hdn_EmpRoleID = FirstTd.find('#hdn_EmpRoleId').val();
                // objxlsxSelectedList.EmployeeId = 0

                var InfraNameRowValue = row.cells[1].innerHTML.toString();
                objxlsxSelectedList.EmployeeName = InfraNameRowValue.toString();
                objxlsxSelectedList.UserName = row.cells[2].innerHTML;
                objxlsxSelectedList.EmployeeCode = row.cells[3].innerHTML;
                objxlsxSelectedList.Gender = row.cells[4].innerHTML;
                objxlsxSelectedList.Email = row.cells[5].innerHTML;
                objxlsxSelectedList.BirthDate = row.cells[6].innerHTML;
                objxlsxSelectedList.BirthDate = objxlsxSelectedList.BirthDate;

                objxlsxSelectedList.RoleName = row.cells[7].innerHTML;
                objxlsxSelectedList.ReportingTo = row.cells[8].innerHTML;
                objxlsxSelectedList.JoiningDate = row.cells[9].innerHTML;
                objxlsxSelectedList.JoiningDate = objxlsxSelectedList.JoiningDate;

                objxlsxSelectedList.BusinessGroup = row.cells[10].innerHTML;
                objxlsxSelectedList.OrganizationUnit = row.cells[11].innerHTML;
                objxlsxSelectedList.Designation = row.cells[12].innerHTML;
                objxlsxSelectedList.Department = row.cells[13].innerHTML;
                objxlsxSelectedList.EmployeeType = row.cells[14].innerHTML;
                objxlsxSelectedList.CostToCompany = row.cells[15].innerHTML;
                objxlsxSelectedList.RatePerHr = row.cells[16].innerHTML;
                objxlsxSelectedList.CostPerHr = row.cells[17].innerHTML;
                var IsDeployed = row.cells[18].innerHTML;
                //Commented and added by reshma chavan on 10 march 2022
                //objxlsxSelectedList.Deployable = IsDeployed == 'Yes' || IsDeployed == 'yes' ? 'D' : 'N'
                objxlsxSelectedList.Deployable = IsDeployed == '1' ? 'D' : 'N'
                //End of Commented and added by reshma chavan on 10 march 2022
                objxlsxSelectedList.Currency = row.cells[19].innerHTML;

                ///value field
                objxlsxSelectedList.ReportingToId = hdn_EmpReportingToId;
                objxlsxSelectedList.BusinessGroupId = hdn_EmpBusinessGroupID;
                objxlsxSelectedList.LocationID = hdn_EmpLocationID;
                objxlsxSelectedList.DesignationId = hdn_EmpDesignationID;
                objxlsxSelectedList.DepartmentId = hdn_EmpDepartmentID;
                objxlsxSelectedList.CurrencyId = hdn_EmpCurrencyID;
                objxlsxSelectedList.RoleID = hdn_EmpRoleID;
                objxlsxSelectedList.UploadedBy = UserName;

                xlsxSelectedList.push(objxlsxSelectedList);

            });

            EmpSaveXlsxDataSelectedData(xlsxSelectedList)

        }

        //Added by imran 23-08-2021
        function ConvertDate(dateStr) {
            var parts = dateStr.replace(' 00:00:00', '');
            parts = parts.split("-");
            return (parts[2] + '-' + parts[1] + '-' + parts[0]);
        }

        //end by imran 23-08-2021
        function EmpSaveXlsxDataSelectedData(xlsxSelectedList) {
            var n = 0; var tempUserName = ''; var tempEmployeeCode = '';
            for (i = 0; i < xlsxSelectedList.length; i++) {
                tempUserName = xlsxSelectedList[i].UserName;
                tempEmployeeCode = xlsxSelectedList[i].EmployeeCode;
                for (j = i + 1; j < xlsxSelectedList.length; j++) {
                    if (tempEmployeeCode == xlsxSelectedList[j].EmployeeCode) {
                        n += 1;
                    }
                    else if (tempUserName == xlsxSelectedList[j].UserName) {
                        n += 1;
                    }
                }
            }


            if (n > 0) {
                alertify.error("You are trying to add same User/Employee Code in excel.")
                return false;
            } else {
                if (xlsxSelectedList != null && xlsxSelectedList.length > 0) {
                    var strHTML = "";
                    $.ajax({
                        url: strUrl + '/api/RM_EmployeeMaster/UploadXlsxRecord',
                        type: "POST",
                        data: JSON.stringify(xlsxSelectedList),
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        },
                        success: function (data) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success("File uploaded successfully.");
                            $('#exceluploadsteps').modal('hide');
                            GetAllEmployeeList(null);
                        },
                        //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        //error: function (err) {
                        //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        //    //StopAjaxLoader("#bodyBusiness-group");
                        //}
                        error: function (xhr, ajaxOptions, thrownError) {
                            if (ajaxOptions == "error") {
                                if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                    window.open("../../../Default.aspx", "_top");
                                } else {
                                    window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                }
                            }
                        }
                        //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    })

                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("There is no valid record to upload .");
                }
            }
        }
        function EmpOpenExceluploadsteps() {
            //Comment And Added By Riddhesh Patil on 13 April 2023 
            //$("#btnaStep1").click();
            $("#exceluploadsteps .pointerDisable").removeClass('active');
            $("#exceluploadsteps ul.nav-wizard li:nth-child(1)").addClass('active');
            $("#exceluploadsteps .tab-pane").removeClass('active');
            $("#PBEUstep1").addClass('active');
            //End of Comment And Added By Riddhesh Patil on 13 April 2023 
            ReloadEmpXslxData("");
            var $el = $('#frmFileUpload');
            $el.wrap('<form>').closest('form').get(0).reset();
            $el.unwrap();
            document.getElementById('plabelName').innerHTML = "Attach file or drop here :-";
            document.getElementById('dvShowFileName').innerHTML = "";
            $('#exceluploadsteps').modal('show');
        }

        ////Release Resource
        function OpenReleasesePopup() {
            GetRelease()
            $('#EPReleasemodal').modal('show');
            //Added By Reshma chavan on 12th Oct for clear leaving date after alert
            $('#TxtReleaseLeavingDate').datepicker('setDate', null);
            //End of Added By Reshma chavan on 12th Oct for clear leaving date after alert
        }

        function GetRelease() {
            var EmpIdEdit = $('#hdnEmployee_UniqueIDTab').val();
            var currentDateProjectRel = new Date();
            //Added by Aditya J. on 28-07-2026 for employee master datepicker issue
            if ($('#TxtProReleaseDate').hasClass('hasDatepicker')) {
                $('#TxtProReleaseDate').datepicker('setDate', currentDateProjectRel);
            } else {
                $("#TxtProReleaseDate").val(convert(currentDateProjectRel));
            }
            //End of Added by Aditya J. on 28-07-2026 for employee master datepicker issue
            var strHTML = '';
            var cboProject = '<span style="display: inline-block;color:red;">*</span><% CommonFunctions.HTMLControls.DrawComboBox("CboBgManagers", "Select 0,'' ",,, "class='form-control'",, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
            //Comment by imran 18-10-2021
            var CboProjectToRes = '<select class="form-control cldisable" id="CboTrnsferProjectResTo" disabled></select> <span style="display: inline-block;color:red;" id="CboTrnsferProjectResToCompulsary">*</span> <span style="display: none;color:black;" id="CboTrnsferProjectResToCompulsarydash"> - </span>'
            var cboTrnsferApprovalResTo = '<select class="form-control cldisable" id="CboTransferApprovalResTo" disabled></select> <span style="display: inline-block;color:red;" id="CboTransferApprovalResToCompulsary">*</span>  <span style="display: none;color:black;" id="CboTransferApprovalResToCompulsarydash"> - </span></td> ';
            var CboTransferInvoice = '<select class="form-control cldisable" id="CboTransferInvoice" disabled></select> <span style="display: inline-block;color:red;" id="CboTransferInvoiceCompulsary">*</span>  <span style="display: none;color:black;" id="CboTransferInvoiceCompulsarydash"> - </span>'
            var CboPIRApproval = '<select class="form-control cldisable" id="CboPIRApproval" disabled></select> <span style="display: inline-block;color:red;" id="CboPIRApprovalCompulsary">*</span>  <span style="display: none;color:black;" id="CboPIRApprovalCompulsarydash"> - </span>'
            var CboWorkFlowApproval = '<select class="form-control cldisable" id="CboWorkFlowApproval" disabled></select> <span style="display: inline-block;color:red;" id="CboWorkFlowApprovalCompulsary">*</span>  <span style="display: none;color:black;" id="CboWorkFlowApprovalCompulsarydash"> - </span>'
            //End Added by imran 18-10-2021

            //var cboProject = '<% CommonFunctions.HTMLControls.DrawComboBox("CboBgManagers", "Select 0,'' ",,, "class='form-control'",, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>'
            /// var cboRole = '<span style="display: inline-block;color:red;">*</span><%=CommonFunctions.HTMLControls.DrawComboBox("cboResourceRole", "usp_Whizible2_Sel_tbl_PM_SoftBookRole", , , "class=""form-control clsPlanWidth clCboOrRole clsAsterLink""", True, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';

            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetRelease',
                type: "POST",
                data: JSON.stringify(EmpIdEdit),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (EmpIdEdit) {
                        xhr.setRequestHeader("Params", encryptString(isJson(EmpIdEdit) ? EmpIdEdit : JSON.stringify(EmpIdEdit)));
                    }
                },
                success: function (data) {
                    //Added by imran 21-10-2021 For pagination
                    $("#EPRTblList").dataTable().fnDestroy();
                    $("#ReleaseTblTbody").html("");
                    //End By imran 21-10-2021

                    if (data.length > 0) {
                        var EmpReleaseList = data;
                        var projManager = "";
                        if (EmpReleaseList.PM == null) {
                            projManager = "";
                        }
                        else {
                            projManager = EmpReleaseList.PM;
                        }
                        $.each(data, function (indexEmpRelease, objEmpReleaseList) {
                            strHTML += '<tr><td><div class="custom_chckbox" ';
                            strHTML += ' <input type="hidden" name="hdn_EmpReleaseProjectId" id="hdn_EmpReleaseProjectId" value=' + objEmpReleaseList.ProjectID + ' >';
                            strHTML += ' <input type="hidden" name="hdn_EmpReleaseProjectId2" id="hdn_EmpReleaseProjectId2" value=' + objEmpReleaseList.ProjectID + ' >';
                            strHTML += ' <input type="hidden" name="hdn_EmpIsProjectRes" id="hdn_EmpIsProjectRes" value=' + objEmpReleaseList.IsProjectRes + ' >';
                            strHTML += ' <input type="hidden" name="hdn_EmpIsApprovalRes" id="hdn_EmpIsApprovalRes" value=' + objEmpReleaseList.IsApprovalRes + ' >';
                            strHTML += ' <input type="hidden" name="hdn_EmpIsInvoiceGenRes" id="hdn_EmpIsInvoiceGenRes" value=' + objEmpReleaseList.IsInvoiceGenRes + ' >';
                            strHTML += ' <input type="hidden" name="hdn_EmpIsWorkflowApprovalRes" id="hdn_EmpIsWorkflowApprovalRes" value=' + objEmpReleaseList.IsWorkflowApprovalRes + ' >';
                            strHTML += ' <input type="hidden" name="hdn_EmpIsIR_PIRAppRes" id="hdn_EmpIsIR_PIRAppRes" value=' + objEmpReleaseList.IsIR_PIRAppRes + ' >';
                            strHTML += ' <input type="hidden" name="hdn_EmpHaveResponsibility" id="hdn_EmpIsHaveResponsibility" value=' + objEmpReleaseList.HaveResponsibility + ' >';
                            strHTML += ' <input id="ERPListCheck' + indexEmpRelease + '"  class="chkbox" type="checkbox" onclick="GetEnableCboOnchecked(this);"><label for="ERPListCheck' + indexEmpRelease + '"></label></div></td> ';

                            //Comment And added by imran 19-10-2021
                            //strHTML += ' <td class="text-start">' + objEmpReleaseList.ProjectName + '</td><td>' + projManager + ' </td> ';
                            strHTML += ' <td class="text-start">' + objEmpReleaseList.ProjectName + '</td>';
                            if (objEmpReleaseList.PM != null) {
                                strHTML += ' <td>' + objEmpReleaseList.PM + ' </td> ';
                            }
                            else {
                                strHTML += ' <td> </td> ';
                            }
                            //end comment 19-10-2021

                            //Added by imran 18-10-2021
                            strHTML += ' <input type="hidden" name="hdn_RowID" id="hdn_RowID" value=' + indexEmpRelease + ' >';
                            //End by imran 18-10-2021

                            //strHTML += '<td> ' + CboProjectToRes + ' </td>  ';
                            strHTML += '<td>  <select class="form-control cldisable" id="CboTrnsferProjectResTo' + objEmpReleaseList.ProjectID + '" disabled></select> <span style="display: inline-block;color:red;" id="CboTrnsferProjectResToCompulsary">*</span> <span style="display: none;color:black;" id="CboTrnsferProjectResToCompulsarydash"> - </span> </td>  ';
                            //strHTML += ' <td> ' + cboTrnsferApprovalResTo + '</td> ';
                            strHTML += ' <td> <select class="form-control cldisable" id="CboTransferApprovalResTo' + objEmpReleaseList.ProjectID + '" disabled></select> <span style="display: inline-block;color:red;" id="CboTransferApprovalResToCompulsary">*</span>  <span style="display: none;color:black;" id="CboTransferApprovalResToCompulsarydash"> - </span></td> </td> ';

                            //if (objEmpReleaseList.IsProjectRes == 'true' && objEmpReleaseList.HaveResponsibility != '0') {
                            //    strHTML += '<td> '+CboProjectToRes+' </td>  ';
                            //} else {
                            //    strHTML += '<td> '-' </td>  ';
                            //}
                            //if (objEmpReleaseList.IsInvoiceGenRes == 'true' && objEmpReleaseList.HaveResponsibility != '0') {
                            //   strHTML += ' <td> ' + cboTrnsferApprovalResTo + '</td> ';
                            //} else {
                            //    strHTML += '<td> '-' </td>  ';
                            //}


                            //Comment And Added by imran 18-10-2021
                            //strHTML += '<td>' + CboTransferInvoice + '</td>';
                            strHTML += '<td> <select class="form-control cldisable" id="CboTransferInvoice' + objEmpReleaseList.ProjectID + '" disabled></select> <span style="display: inline-block;color:red;" id="CboTransferInvoiceCompulsary">*</span>  <span style="display: none;color:black;" id="CboTransferInvoiceCompulsarydash"> - </span></td>';

                            //strHTML += '<td>' + CboPIRApproval + '</td> ';
                            strHTML += '<td><select class="form-control cldisable" id="CboPIRApproval' + objEmpReleaseList.ProjectID + '" disabled></select> <span style="display: inline-block;color:red;" id="CboPIRApprovalCompulsary">*</span>  <span style="display: none;color:black;" id="CboPIRApprovalCompulsarydash"> - </span></td> ';

                            //strHTML += ' <td>' + CboWorkFlowApproval + '</td> ';
                            strHTML += ' <td><select class="form-control cldisable" id="CboWorkFlowApproval' + objEmpReleaseList.ProjectID + '" disabled></select> <span style="display: inline-block;color:red;" id="CboWorkFlowApprovalCompulsary">*</span>  <span style="display: none;color:black;" id="CboWorkFlowApprovalCompulsarydash"> - </span></td> ';
                            //End Added by imran 18-10-2021
                            strHTML += ' </tr>'
                        })
                        $("#ReleaseSetProjDateDiv").removeClass("clsShowHide");
                        $(".noteboxpanel").removeClass("clsShowHide");
                        $("noteboxpanel_h5").removeClass("clsShowHide");
                        $('#hdn_EmpReleaseWithoutProject').val(0);
                        $(".Resourcedetailpanel").show();
                        $('html,body').animate({
                            scrollTop: $(".Resourcedetailpanel").offset().top - 60
                        }, 'slow');
                    }
                    else {
                        ///$("#EPRTblList").addClass("clsShowHide");
                        $("#ReleaseSetProjDateDiv").addClass("clsShowHide");
                        //class="noteboxpanel graybg" id="ReleaseNoteDiv"
                        $(".noteboxpanel").addClass("clsShowHide");
                        $(".noteboxpanel_h5").addClass("clsShowHide");

                        $('#hdn_EmpReleaseWithoutProject').val(1);
                        //strHTML = '<tr>No data found. </tr>'
                        $(".Resourcedetailpanel").show();
                        $('html,body').animate({
                            scrollTop: $(".Resourcedetailpanel").offset().top - 60
                        }, 'slow');
                    }
                    $("#ReleaseTblTbody").html(strHTML);
                    //Added by imran 21-10-2021 For pagination
                    $('#EPRTblList').dataTable({
                        "sScrollY": true,
                        "scrollX": true,
                        "pageLength": 10,
                        "lengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": false,
                        "retrieve": true,
                        "responsive": true,
                        "bFilter": false,
                        "ordering": false,
                    });
                    //End By imran 21-10-2021
                    GetEmpListForUser();
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }


        function GetEnableCboOnchecked(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                var RowID = row.find('#hdn_RowID').val();
                var ProjectId = row.find('#hdn_EmpReleaseProjectId2').val();
                var IsProjRes = row.find('#hdn_EmpIsProjectRes').val();
                var IsApprovalRes = row.find('#hdn_EmpIsApprovalRes').val();
                var IsInvoiceGenRes = row.find('#hdn_EmpIsInvoiceGenRes').val()
                var IsWorkflowApprovalRes = row.find('#hdn_EmpIsWorkflowApprovalRes').val()
                var IsIR_PIRAppRes = row.find('#hdn_EmpIsIR_PIRAppRes').val()
                var EmpIdEdit = $('#hdnEmployee_UniqueIDTab').val();
                var objTrnsferProjectResTo = { ProjectID: ProjectId, ApproverID: EmpIdEdit, IsProjLevel: true }
                var strHTMLCbo = '';
                var strHTMLCboProjectResTo = '';
                var strHTMLCboApprovalRes = '';
                var strHTMLCboPIRApproval = '';
                var strHTMLCboTransferInvoice = '';
                var strHTMLCboWorkFlowResTo = '';
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/GetReleaseProjectTo',
                    type: "POST",
                    data: JSON.stringify(objTrnsferProjectResTo),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (objTrnsferProjectResTo) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objTrnsferProjectResTo) ? objTrnsferProjectResTo : JSON.stringify(objTrnsferProjectResTo)));
                        }
                    },
                    success: function (data) {
                        var EmpProjectRespToLst = data["EmpProjectRespToLst"];
                        var EmpApprovalRespToLst = data["EmpApprovalRespToLst"]
                        var EmpInvoiceGenToLst = data["EmpInvoiceGenToLst"]
                        var EmpPirApprovalResToLst = data["EmpPirApprovalResToLst"]

                        if (IsProjRes == 'true') {
                            strHTMLCbo += "<option value='0'></option>";  //Added by Chetan M on 6 Aug 2021 for Issue fixing
                            for (var i = 0; i < EmpProjectRespToLst.length; i++) {
                                var listComponent1 = EmpProjectRespToLst[i];
                                //Commented And Added By Imran M. on 11 Feb 2022
                                //strHTMLCbo += ('<option value=' + listComponent1.EmployeeID + ' >' + listComponent1.UserName + '</option>');
                                strHTMLCbo += ('<option value=' + listComponent1.EmployeeID + ' >' + listComponent1.EmployeeName + '</option>');
                                //End of Commented And Added By Imran M. on 11 Feb 2022
                            }
                            //Comment And Added by imran 18-10-2021
                            //row.find('#CboTrnsferProjectResTo').html(strHTMLCbo);
                            row.find('#CboTrnsferProjectResTo' + ProjectId).html(strHTMLCbo);
                            row.find('#CboTrnsferProjectResToCompulsarydash').hide();
                            var k = "CboTrnsferProjectResTo" + ProjectId;
                            TransferProjectCombo.push(k);
                            //End Comment by imran 18-10-2021
                        }
                        //Added by imran 18-10-2021
                        else {
                            row.find('#CboTrnsferProjectResTo' + ProjectId).hide();
                            row.find('#CboTrnsferProjectResToCompulsary').hide();
                            row.find('#CboTrnsferProjectResToCompulsarydash').show();
                            var k = "-";
                            TransferProjectCombo.push(k);
                        }
                        //Comment And Added by imran 18-10-2021

                        if (IsApprovalRes == 'true') {
                            strHTMLCboApprovalRes += "<option value='0'></option>";  //Added by Chetan M on 6 Aug 2021 for Issue fixing
                            for (var i = 0; i < EmpApprovalRespToLst.length; i++) {
                                var listComponent2 = EmpApprovalRespToLst[i];
                                //Commented And Added By Imran M. on 11 Feb 2022
                                //strHTMLCboApprovalRes += ('<option value=' + listComponent2.EmployeeID + ' >' + listComponent2.UserName + '</option>');
                                strHTMLCboApprovalRes += ('<option value=' + listComponent2.EmployeeID + ' >' + listComponent2.EmployeeName + '</option>');
                                //End of Commented And Added By Imran M. on 11 Feb 2022
                            }
                            //Comment And Added by imran 18-10-2021
                            row.find('#CboTransferApprovalResTo').html(strHTMLCboApprovalRes);
                            row.find('#CboTransferApprovalResTo' + ProjectId).html(strHTMLCboApprovalRes);
                            row.find('#CboTransferApprovalResToCompulsarydash').hide();
                            var k = "CboTransferApprovalResTo" + ProjectId;
                            TransferApprovalCombo.push(k);
                            //End imran 18-10-2021
                        }
                        //Added by imran 18-10-2021
                        else {
                            row.find('#CboTransferApprovalResTo' + ProjectId).hide();
                            row.find('#CboTransferApprovalResToCompulsary').hide();
                            row.find('#CboTransferApprovalResToCompulsarydash').show();
                            var k = "-";
                            TransferApprovalCombo.push(k);
                        }
                        //Comment And Added by imran 18-10-2021

                        if (IsInvoiceGenRes == 'true') {
                            strHTMLCboTransferInvoice += "<option value='0'></option>";  //Added by Chetan M on 6 Aug 2021 for Issue fixing
                            for (var i = 0; i < EmpInvoiceGenToLst.length; i++) {
                                var listComponent3 = EmpInvoiceGenToLst[i];
                                //Comment And Added by imran 21-10-2021
                                //strHTMLCboTransferInvoice += ('<option value=' + listComponent3.EmployeeID + ' >' + listComponent3.UserName + '</option>');
                                strHTMLCboTransferInvoice += ('<option value=' + listComponent3.EMPLOYEEID + ' >' + listComponent3.USERNAME + '</option>');
                                //End by imran 21-10-2021							
                            }
                            //Comment And Added by imran 18-10-2021
                            //row.find('#CboTransferInvoice').html(strHTMLCboTransferInvoice);
                            row.find('#CboTransferInvoice' + ProjectId).html(strHTMLCboTransferInvoice);
                            row.find('#CboTransferInvoiceCompulsarydash').hide();
                            var k = "CboTransferInvoice" + ProjectId;
                            TransferInvoiceGenerationCombo.push(k);
                            //End by imran 18-10-2021
                        }
                        //Added by imran 18-10-2021
                        else {
                            row.find('#CboTransferInvoice' + ProjectId).hide();
                            row.find('#CboTransferInvoiceCompulsary').hide();
                            row.find('#CboTransferInvoiceCompulsarydash').show();
                            var k = "-";
                            TransferInvoiceGenerationCombo.push(k);
                        }
                        //Comment And Added by imran 18-10-2021

                        if (IsIR_PIRAppRes == 'true') {
                            strHTMLCboPIRApproval += "<option value='0'></option>";  //Added by Chetan M on 6 Aug 2021 for Issue fixing
                            for (var i = 0; i < EmpPirApprovalResToLst.length; i++) {
                                var listComponent = EmpPirApprovalResToLst[i];
                                strHTMLCboPIRApproval += ('<option value=' + listComponent.EmployeeID + ' >' + listComponent.UserName + '</option>');
                            }
                            //Comment And Added by imran 18-10-2021
                            //row.find('#CboPIRApproval').html(strHTMLCboPIRApproval);
                            row.find('#CboPIRApproval' + ProjectId).html(strHTMLCboPIRApproval);
                            row.find('#CboPIRApprovalCompulsarydash').hide();
                            var k = "CboPIRApproval" + ProjectId;
                            TransferIRPIRApprovalCombo.push(k);
                            //End Added by imran 18-10-2021
                        }
                        //Added by imran 18-10-2021
                        else {
                            row.find('#CboPIRApproval' + ProjectId).hide();
                            row.find('#CboPIRApprovalCompulsary').hide();
                            row.find('#CboPIRApprovalCompulsarydash').show();
                            var k = "-";
                            TransferIRPIRApprovalCombo.push(k);
                        }
                        //Comment And Added by imran 18-10-2021

                        if (IsWorkflowApprovalRes == 'true') {
                            strHTMLCboWorkFlowResTo += "<option value='0'></option>"; //Added by Chetan M on 6 Aug 2021 for Issue fixing
                            for (var i = 0; i < EmpApprovalRespToLst.length; i++) {
                                var listComponentWf = EmpApprovalRespToLst[i];
                                //strHTMLCboWorkFlowResTo += ('<option value=' + listComponentWf.EmployeeID + ' >' + listComponentWf.UserName + '</option>');
                                strHTMLCboWorkFlowResTo += ('<option value=' + listComponentWf.EmployeeID + ' >' + listComponentWf.EmployeeName + '</option>');
                            }
                            //Comment And Added by imran 18-10-2021
                            //row.find('#CboWorkFlowApproval').html(strHTMLCboWorkFlowResTo);
                            row.find('#CboWorkFlowApproval' + ProjectId).html(strHTMLCboWorkFlowResTo);
                            row.find('#CboWorkFlowApprovalCompulsarydash').hide();
                            var k = "CboWorkFlowApproval" + ProjectId;
                            TransferWorkflowApprovalCombo.push(k);
                            //End Added by imran 18-10-2021
                        }
                        //Added by imran 18-10-2021
                        else {
                            row.find('#CboWorkFlowApproval' + ProjectId).hide();
                            row.find('#CboWorkFlowApprovalCompulsary').hide();
                            row.find('#CboWorkFlowApprovalCompulsarydash').show();
                            var k = "-";
                            TransferWorkflowApprovalCombo.push(k);
                        }
                        //End Added by imran 18-10-2021
                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    //StopAjaxLoader("#bodyBusiness-group");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                })
                row.find(".cldisable").attr("disabled", false);
            }
            else {
                //Added by imran 21-10-2021 show dropdown disabled mode
                var ProjectId = row.find('#hdn_EmpReleaseProjectId2').val();
                //End By imran 21-10-2021 

                row.find(".cldisable").attr("disabled", true);

                row.find('#CboTrnsferProjectResTo' + ProjectId).show();
                row.find('#CboTrnsferProjectResToCompulsary').show();
                row.find('#CboTrnsferProjectResToCompulsarydash').hide();

                row.find('#CboTransferApprovalResTo' + ProjectId).show();
                row.find('#CboTransferApprovalResToCompulsary').show();
                row.find('#CboTransferApprovalResToCompulsarydash').hide();

                row.find('#CboTransferInvoice' + ProjectId).show();
                row.find('#CboTransferInvoiceCompulsary').show();
                row.find('#CboTransferInvoiceCompulsarydash').hide();

                row.find('#CboPIRApproval' + ProjectId).show();
                row.find('#CboPIRApprovalCompulsary').show();
                row.find('#CboPIRApprovalCompulsarydash').hide();

                row.find('#CboWorkFlowApproval' + ProjectId).show();
                row.find('#CboWorkFlowApprovalCompulsary').show();
                row.find('#CboWorkFlowApprovalCompulsarydash').hide();
            }
        }

        var ReleaseEmpList = [];
        function ReleaseResource() {
           
            ReleaseEmpList = [];
            var IsValidinput = false;
            var IsEmpReleaseWithWithoutProj = $('#hdn_EmpReleaseWithoutProject').val();
            var IsEmpReleaseWithWithoutRpotingTo = $('#hdn_EmpReleaseWithoutReportingTo').val();
            if (IsEmpReleaseWithWithoutProj == 1 && IsEmpReleaseWithWithoutRpotingTo == 1) {
                IsValidinput = ValidteForLeavingDate();
            }
            if (IsEmpReleaseWithWithoutProj == 0 && IsEmpReleaseWithWithoutRpotingTo == 1) {
                IsValidinput = ValidateForProjReleaseDate()
            }
            if (IsEmpReleaseWithWithoutProj == 0 && IsEmpReleaseWithWithoutRpotingTo == 0) {
                var IsValidProjRelDate = ValidateForProjReleaseDate()
                if (IsValidProjRelDate) {
                    var IsValidLeavingDate = ValidteForLeavingDate()
                    if (IsValidLeavingDate) {
                        IsValidinput = ValidateForReportingTo();
                    }
                }
            }
            if (IsEmpReleaseWithWithoutProj == 1 && IsEmpReleaseWithWithoutRpotingTo == 0) {
                var IsValidLeavingDate = ValidteForLeavingDate()
                if (IsValidLeavingDate) {
                    IsValidinput = ValidateForReportingTo();
                }
            }
            ///if valid input 
            if (IsValidinput) {
                if (IsEmpReleaseWithWithoutProj == 0) {
                    $('#EPRTblList [type="checkbox"]').each(function (i, chk) {
                        if (chk.checked) {
                            var objReleaseEmp = {}
                            var row = $(this).closest("tr");
                            var ProjectId = row.find('#hdn_EmpReleaseProjectId2').val();
                            var CboTrnsferProjectResTo = row.find("#CboTrnsferProjectResTo").val()
                            var CboTransferApprovalResTo = row.find("#CboTransferApprovalResTo").val()
                            var CboTransferInvoice = row.find("#CboTransferInvoice").val()
                            var CboPIRApproval = row.find("#CboPIRApproval").val()
                            var CboWorkFlowApproval = row.find("#CboWorkFlowApproval").val()
                            var TxtProReleaseDate = $("#TxtProReleaseDate").val();
                            var TxtLeavingDate = $("#TxtReleaseLeavingDate").val();


                            if (ProjectId == undefined) {
                                ProjectId = 0;
                            }
                            if (CboTrnsferProjectResTo == undefined) {
                                CboTrnsferProjectResTo = 0;
                            }
                            if (CboTransferApprovalResTo == undefined) {
                                CboTransferApprovalResTo = 0;
                            }
                            if (CboTransferInvoice == undefined) {
                                CboTransferInvoice = 0;
                            }
                            if (CboPIRApproval == undefined) {
                                CboPIRApproval = 0;
                            }
                            if (CboWorkFlowApproval == undefined) {
                                CboWorkFlowApproval = 0;
                            }
                            objReleaseEmp.EmployeeID = parseInt($('#hdnEmployee_UniqueIDTab').val());
                            objReleaseEmp.ProjectID = parseInt(ProjectId);
                            objReleaseEmp.ProjectRes = parseInt(CboTrnsferProjectResTo);
                            objReleaseEmp.ApprovalRes = parseInt(CboTransferApprovalResTo);
                            objReleaseEmp.IRGenerator = parseInt(CboTransferInvoice);
                            objReleaseEmp.IRApprover = parseInt(CboPIRApproval);
                          
                            objReleaseEmp.ActualEndDate = TxtProReleaseDate;
                            objReleaseEmp.UserName = UserName;
                            objReleaseEmp.WorkflowApprover = parseInt(CboWorkFlowApproval);

                            //if (objReleaseEmp.ProjectID == 'undefined' || objReleaseEmp.ProjectID == undefined) {
                            //    objReleaseEmp.ProjectID = 0;
                            //}
                            //else {
                            //    objReleaseEmp.ProjectID = ProjectId;
                            //}
                            ////objReleaseEmp.ProjectID = ProjectId;
                            //if (objReleaseEmp.ProjectRes == 'undefined' || objReleaseEmp.ProjectRes == undefined) {
                            //    objReleaseEmp.ProjectRes = 0;
                            //}
                            //else {
                            //    objReleaseEmp.ProjectRes = CboTrnsferProjectResTo;
                            //}
                            ////objReleaseEmp.ProjectRes = CboTrnsferProjectResTo;
                            //if (objReleaseEmp.ApprovalRes == 'undefined' || objReleaseEmp.ApprovalRes == undefined) {
                            //    objReleaseEmp.ApprovalRes = 0;
                            //}
                            //else {
                            //    objReleaseEmp.ApprovalRes = CboTransferApprovalResTo;
                            //}
                            ////objReleaseEmp.ApprovalRes = CboTransferApprovalResTo;
                            //if (objReleaseEmp.IRGenerator == 'undefined' || objReleaseEmp.IRGenerator == undefined) {
                            //    objReleaseEmp.IRGenerator = 0;
                            //}
                            //else {
                            //    objReleaseEmp.IRGenerator = CboTransferInvoice;
                            //}
                            //// objReleaseEmp.IRGenerator = CboTransferInvoice;
                            //if (objReleaseEmp.IRApprover == 'undefined' || objReleaseEmp.IRApprover==undefined) {
                            //    objReleaseEmp.IRApprover = 0;
                            //}
                            //else {
                            //    objReleaseEmp.IRApprover = CboPIRApproval;
                            //}
                            ////objReleaseEmp.IRApprover = CboPIRApproval;
                            //if ($('#hdnEmployee_UniqueIDTab').val() == 'undefined' || objReleaseEmp.EmployeeID == undefined) {
                            //    objReleaseEmp.EmployeeID = 0;
                            //}
                            //else {
                                
                            //    objReleaseEmp.EmployeeID = $('#hdnEmployee_UniqueIDTab').val();
                            //}
                            ////objReleaseEmp.EmployeeID = $('#hdnEmployee_UniqueIDTab').val();
                            //if (objReleaseEmp.ActualEndDate == 'undefined' || objReleaseEmp.ActualEndDate == undefined) {

                            //    objReleaseEmp.ActualEndDate = "";
                            //}
                            //else {
                            //    objReleaseEmp.ActualEndDate = TxtProReleaseDate;
                            //}
                            ////objReleaseEmp.ActualEndDate = TxtProReleaseDate;
                            //if (objReleaseEmp.UserName == 'undefined' || objReleaseEmp.UserName == undefined) {
                            //    objReleaseEmp.UserName = "";
                            //}
                            //else {
                            //    objReleaseEmp.UserName = UserName;
                            //}
                            ////objReleaseEmp.UserName = UserName;
                            //if (objReleaseEmp.WorkflowApprover == 'undefined' || objReleaseEmp.WorkflowApprover == undefined) {
                            //    objReleaseEmp.WorkflowApprover = 0;
                            //}
                            //else {
                            //    objReleaseEmp.WorkflowApprover = CboWorkFlowApproval;
                            //}

                            //objReleaseEmp.ReportingTo = $("#cboEmpRelaseReportingTo").val();
                            ///objReleaseEmp.LeavingDate=TxtLeavingDate;
                            ReleaseEmpList.push(objReleaseEmp);
                        }
                    });
                    ///release emp
                    if (ReleaseEmpList != null && ReleaseEmpList.length > 0) {
                        //Added by imran 18-10-2021 To check validation
                        var validation = CheckValidationForRelease();
                        if (validation == 0) {
                            var TabletotatalRows = $('#EPRTblList tbody tr').length;
                            // $('#EPRTblList').children('tr').length;
                            var TableCheckedRows = ReleaseEmpList.length;
                            //release if all project selected 
                            if (TabletotatalRows > 0 && TableCheckedRows > 0) {
                                if (TabletotatalRows == TableCheckedRows) {
                                    //Comment And Added by imran 19-10-2021
                                    //ReleaseProjResource(ReleaseEmpList);
                                    //UpdateReleaseResource();
                                    if ($("#TxtReleaseLeavingDate").val() == '') {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.error("Leaving Date Should Not Left Blank");
                                        $("#TxtReleaseLeavingDate").focus();
                                    }
                                    else {
                                        ReleaseProjResource(ReleaseEmpList);
                                        UpdateReleaseResource();
                                    }
                                    //End By imran 19-10-2021
                                }
                                else {
                                    alertify.set('notifier', 'position', 'top-right');
                                    //Comment And added by imran 18-10-2021
                                    // alertify.success(" Resource released successfully!");
                                    alertify.error("Please Select All Project.");
                                    //Added By Rutuja D. For Spelining Mistek Issue on 9 Aug 2021
                                    //End Comment 18-10-2021

                                    // $("#Empstatus").val(MEData.Status);

                                    //Comment added by Reshma Chavan on 30-12-2021 popup closed restrict
                                    //$(".newStatus").text("Inactive");
                                    //$('#EPReleasemodal').modal('hide');
                                    //$(".Resourcedetailpanel").show();
                                    //$('html,body').animate({
                                    //    scrollTop: $(".Resourcedetailpanel").offset().top - 60
                                    //}, 'slow');
                                    //End added by Reshma Chavan on 30-12-2021 popup closed restrict
                                }
                            }
                        }
                        else {
                            //alert("Invalid");
                        }
                        //End By imran 18-10-2021  
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        //alertify.error("Please select at least one project .");
                        alertify.error("Please Select All Project.");
                        $(".Resourcedetailpanel").show();
                        $('html,body').animate({
                            scrollTop: $(".Resourcedetailpanel").offset().top - 60
                        }, 'slow');
                    }
                }
                else {
                    //comment And Added by imran 19-10-2021
                    // UpdateReleaseResource();
                    $('#EPRTblList [type="checkbox"]').each(function (i, chk) {
                        if (chk.checked) {
                            var objReleaseEmp = {}
                            var row = $(this).closest("tr");
                            var ProjectId = row.find('#hdn_EmpReleaseProjectId2').val();
                            var CboTrnsferProjectResTo = row.find("#CboTrnsferProjectResTo").val()
                            var CboTransferApprovalResTo = row.find("#CboTransferApprovalResTo").val()
                            var CboTransferInvoice = row.find("#CboTransferInvoice").val()
                            var CboPIRApproval = row.find("#CboPIRApproval").val()
                            var CboWorkFlowApproval = row.find("#CboWorkFlowApproval").val()
                            var TxtProReleaseDate = $("#TxtProReleaseDate").val();
                            var TxtLeavingDate = $("#TxtReleaseLeavingDate").val();


                            if (ProjectId == undefined) {
                                ProjectId = 0;
                            }
                            if (CboTrnsferProjectResTo == undefined) {
                                CboTrnsferProjectResTo = 0;
                            }
                            if (CboTransferApprovalResTo == undefined) {
                                CboTransferApprovalResTo = 0;
                            }
                            if (CboTransferInvoice == undefined) {
                                CboTransferInvoice = 0;
                            }
                            if (CboPIRApproval == undefined) {
                                CboPIRApproval = 0;
                            }
                            if (CboWorkFlowApproval == undefined) {
                                CboWorkFlowApproval = 0;
                            }
                            objReleaseEmp.EmployeeID = parseInt($('#hdnEmployee_UniqueIDTab').val());
                            objReleaseEmp.ProjectID = parseInt(ProjectId);
                            
                            objReleaseEmp.ProjectRes = parseInt(CboTrnsferProjectResTo);
                           
                            objReleaseEmp.ApprovalRes = parseInt(CboTransferApprovalResTo);
                           
                            objReleaseEmp.IRGenerator = parseInt(CboTransferInvoice);
                           
                            objReleaseEmp.IRApprover = parseInt(CboPIRApproval);
                            
                           
                           
                            objReleaseEmp.ActualEndDate = TxtProReleaseDate;
                            
                            objReleaseEmp.UserName = UserName;
                            
                            objReleaseEmp.WorkflowApprover = parseInt(CboWorkFlowApproval);
                            objReleaseEmp.ReportingTo = parseInt($("#cboEmpRelaseReportingTo").val());
                            objReleaseEmp.LeavingDate=TxtLeavingDate;
                            ReleaseEmpList.push(objReleaseEmp);
                        }
                    });

                    if (ReleaseEmpList != null && ReleaseEmpList.length > 0) {
                        var validation = CheckValidationForRelease();
                        if (validation == 0) {
                            var TabletotatalRows = $('#EPRTblList tbody tr').length;
                            var TableCheckedRows = ReleaseEmpList.length;
                            if (TabletotatalRows > 0 && TableCheckedRows > 0) {
                                if (TabletotatalRows == TableCheckedRows) {
                                    if ($("#TxtReleaseLeavingDate").val() == '') {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.error("Leaving Date Should Not Left Blank");
                                        $("#TxtReleaseLeavingDate").focus();
                                    }
                                    else {
                                        UpdateReleaseResource();
                                    }
                                }
                                else {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error("Please Select All Project.");
                                    $(".newStatus").text("Inactive");
                                    $('#EPReleasemodal').modal('hide');
                                    $(".Resourcedetailpanel").show();
                                    $('html,body').animate({
                                        scrollTop: $(".Resourcedetailpanel").offset().top - 60
                                    }, 'slow');
                                }
                            }
                        }
                        else { }

                    }
                    else {
                        UpdateReleaseResource();
                    }
                    //End By imran 19-10-2021  
                }
            }

            var IsValidProjRelease = false;
            function ObjValidateReleaseProj(objReleaseEmp, row, isForLeavingOnly) {
                var currentDate = new Date();
                var LeavingDate = objReleaseEmp.LeavingDate;
                var ProjLeavingDate = objReleaseEmp.ActualEndDate
                if (isForLeavingOnly === false) {

                    // if (objReleaseEmp.ActualEndDate==null || objReleaseEmp.ActualEndDate=="" || objReleaseEmp.ActualEndDate=='undefined') {
                    //     alertify.set('notifier', 'position', 'top-right');
                    //     alertify.error("Project release date should not be left blank");
                    //     IsValidProjRelease= false;
                    //     return false;
                    // }
                    //else if (LeavingDate> currentDate) {
                    //     //row.find("#txtIdentifiedDate").focus();
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.error("LeavingDate Date should not be future date.");
                    //    IsValidProjRelease= false;
                    //    return false;
                    // }  
                    //else if (LeavingDate==null || LeavingDate=="" || LeavingDate=='undefined') {
                    //     alertify.set('notifier', 'position', 'top-right');
                    //     alertify.error("Project release date should not be left blank");
                    //     IsValidProjRelease= false;
                    //     return false;
                    // }

                    // else if (LeavingDate > ProjLeavingDate) {
                    // IsVliadReleaseResource= false;
                    // alertify.set('notifier', 'position', 'top-right');
                    // alertify.error("LeavingDate date must be greater than Project ");
                    // IsValidProjRelease= false;
                    // return false;
                    //}
                    //if (objReleaseEmp.ActualEndDate==null || objReleaseEmp.ActualEndDate=="" || objReleaseEmp.ActualEndDate=='undefined') {
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.error("Project release date should not be left blank");
                    //    IsValidProjRelease= false;
                    //    return false;
                    //}

                    if (objReleaseEmp.ReportingTo == 0 || objReleaseEmp.ReportingTo == null || objReleaseEmp.ReportingTo == "" || objReleaseEmp.ReportingTo == 'undefined') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Reporting To should not be left blank");
                        IsValidProjRelease = false;
                        return false;
                    }
                    else if (objReleaseEmp.ApprovalRes == 'undefined' || objReleaseEmp.ApprovalRes == "" || objReleaseEmp.ApprovalRes == null || objReleaseEmp.ApprovalRes == 0) {
                        row.find("#CboTransferApprovalResTo").focus();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Approval should not be left blank");
                        IsValidProjRelease = false;
                        return false;
                    }
                    if (objReleaseEmp.IRGenerator == 'undefined' || objReleaseEmp.IRGenerator == null || objReleaseEmp.IRGenerator == 0) {
                        row.find("#CboTransferInvoice").focus();
                        IsValidProjRelease = false;
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("CboTransferInvoice should not be left blank");
                        return false;
                    }
                    else {
                        IsVliadReleaseResource = true
                    }
                } else {

                }

            }
            var IsvalidateResourceRelease = false;
            function validateProjectReleaseDate(ReleaseCase) {
                var currentDate = new Date();
                var LeavingDate = $("#TxtReleaseLeavingDate").val();
                var ProjLeavingDate = $("#TxtProReleaseDate").val();
                if (ProjLeavingDate == null || ProjLeavingDate == "" || ProjLeavingDate == 'undefined') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Project release date should not be left blank");
                    IsvalidateResourceRelease = false;
                    return false;
                }
                else if (LeavingDate > currentDate) {
                    $("#TxtReleaseLeavingDate").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("LeavingDate Date should not be future date.");
                    IsvalidateResourceRelease = false;
                    return false;
                }
                else if (LeavingDate == null || LeavingDate == "" || LeavingDate == 'undefined') {
                    $("#TxtReleaseLeavingDate").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Project release date should not be left blank");
                    IsvalidateResourceRelease = false;
                    return false;
                }
                else if (LeavingDate > ProjLeavingDate) {
                    $("#TxtReleaseLeavingDate").val();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("LeavingDate date must be greater than Project ");
                    IsvalidateResourceRelease = false;
                    return false;
                }
                else {
                    IsvalidateResourceRelease = true;
                    return true;
                }

            }
            ///funtion to validate
            var IsvalidateResourceRelease = false;
            function ValidteForLeavingDate() {
                var currentDate = new Date();
                var LeavingDate = new Date($("#TxtReleaseLeavingDate").val());
                var JoiningDate = new Date($("#txtJoiningDate").val());
                if (LeavingDate > currentDate) {
                    $("#TxtReleaseLeavingDate").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Leaving Date Date should not be future date.");
                    IsvalidateResourceRelease = false;
                    return false;
                }
                else if (LeavingDate == null || LeavingDate == "" || LeavingDate == 'undefined' || LeavingDate == "Invalid Date") {
                    $("#TxtReleaseLeavingDate").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Leaving date should not be left blank");
                    IsvalidateResourceRelease = false;
                    return false;
                }
                else if (JoiningDate > LeavingDate) {
                    $("#TxtReleaseLeavingDate").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Leaving date should be greater than  Joining Date ( " + $("#txtJoiningDate").val() + " )");
                    IsvalidateResourceRelease = false;
                    return false;

                } else {
                    IsvalidateResourceRelease = true;
                    return true;
                }
            }
            function ValidateForProjReleaseDate() {
                var currentDate = new Date();
                var ProjLeavingDate = new Date($("#TxtProReleaseDate").val());
                if (ProjLeavingDate == null || ProjLeavingDate == "" || ProjLeavingDate == 'undefined' || ProjLeavingDate == "Invalid Date") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Project release date should not be left blank");
                    IsvalidateResourceRelease = false;
                    $("#TxtProReleaseDate").focus();
                    return false;
                }
                else if (ProjLeavingDate > currentDate) {
                    $("#TxtProReleaseDate").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Project Release Date should not be future date.");
                    IsvalidateResourceRelease = false;
                    return false;
                } else {
                    IsvalidateResourceRelease = true;
                    return true;
                }
            }
            function ValidateForReportingTo() {
                var ReportingTo = $("#cboEmpRelaseReportingTo").val();
                if (ReportingTo == null || ReportingTo == "" || ReportingTo == 'undefined' || ReportingTo == '0') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Project Reporting to should not be left blank");
                    IsvalidateResourceRelease = false;
                    $("#cboEmpRelaseReportingTo").focus();
                    return false;
                } else {
                    IsvalidateResourceRelease = true;
                    return true;
                }
            }

            function ReleaseProjResource(objReleaseEmp) {

                var Op_Parameters = JSON.stringify({ 'Op_Parameters': objReleaseEmp });
               
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/SaveRelease',
                    type: "POST",
                    //data: JSON.stringify(objReleaseEmp),
                    data: Op_Parameters,
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        //if (objReleaseEmp) {
                        //    xhr.setRequestHeader("Params", encryptString(isJson(objReleaseEmp) ? objReleaseEmp : JSON.stringify(objReleaseEmp)));
                        //}
                        if (Op_Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Op_Parameters) ? Op_Parameters : JSON.stringify(Op_Parameters)));
                        }
                    },
                    success: function (data) {

                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    //alertify.notify(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    //StopAjaxLoader("#bodyBusiness-group");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                })
            }
        }

        //Added by imran 18-10-2021
        function CheckValidationForRelease() {
            var tcount = 0;
            alertify.set('notifier', 'position', 'top-right');

            for (i = 0; i < ReleaseEmpList.length; i++) {
                tcount = 0;
                //Transfer Project Responsibilities To
                if (TransferProjectCombo[i] == "-") { }
                else {
                    var ID = TransferProjectCombo[i];
                    var TP = $("#" + ID).val();
                    if (TP == "" || TP == 0) {
                        tcount = 1;
                        alertify.error("Transfer Project Responsibilities To Should Not Be Left Blank");
                        $("#" + ID).focus();
                        return tcount;
                    }
                    else { tcount = 0; }
                }

                //Transfer Approval Responsibilities To
                if (TransferApprovalCombo[i] == "-") { }
                else {
                    var ID = TransferApprovalCombo[i];
                    var TA = $("#" + ID).val();
                    if (TA == "" || TA == 0) {
                        tcount = 1;
                        alertify.error("Transfer Approval Responsibilities To Should Not Be Left Blank");
                        $("#" + ID).focus();
                        return tcount;
                    }
                    else { tcount = 0; }
                }

                //Transfer Invoice Generation Responsibilities To
                if (TransferInvoiceGenerationCombo[i] == "-") { }
                else {
                    var ID = TransferInvoiceGenerationCombo[i];
                    var TIG = $("#" + ID).val();
                    if (TIG == "" || TIG == 0) {
                        tcount = 1;
                        alertify.error("Transfer Invoice Generation Responsibilities To Should Not Be Left Blank");
                        $("#" + ID).focus();
                        return tcount;
                    }
                    else { tcount = 0; }
                }

                //Transfer IR/PIR Approval Responsibilities To
                if (TransferIRPIRApprovalCombo[i] == "-") { }
                else {
                    var ID = TransferIRPIRApprovalCombo[i];
                    var TIRPIR = $("#" + ID).val();
                    if (TIRPIR == "" || TIRPIR == 0) {
                        tcount = 1;
                        alertify.error("Transfer IR/PIR Approval Responsibilities To Should Not Be Left Blank");
                        $("#" + ID).focus();
                        return tcount;
                    }
                    else { tcount = 0; }
                }

                //Transfer Workflow Approval Responsibilities To
                if (TransferWorkflowApprovalCombo[i] == "-") { }
                else {
                    var ID = TransferWorkflowApprovalCombo[i];
                    var TIRPIR = $("#" + ID).val();
                    if (TIRPIR == "" || TIRPIR == 0) {
                        tcount = 1;
                        alertify.error("Transfer Workflow Approval Responsibilities To Should Not Be Left Blank");
                        $("#" + ID).focus();
                        return tcount;
                    }
                    else { tcount = 0; }
                }
            }
            return tcount;
        }
        //End By imran 18-10-2021

        function UpdateReleaseResource() {
            var EmpID = $('#hdnEmployee_UniqueIDTab').val();
            var ReportingId = $("#cboEmpRelaseReportingTo").val();
            var LeavingDate = convert($("#TxtReleaseLeavingDate").val());

            //Added By Reshma Chavan on 3 march 2022
            var CreatedBy = '<%= Session("strUserName") %>';

            //commented and added by imran on 12-01-2022 Crash comming Because of NLeavingDate and model name is LeavingDate
            //var objRelease = { EmployeeId: EmpID, ReportingToId: ReportingId, NLeavingDate: LeavingDate };
            var objRelease = { EmployeeId: EmpID, ReportingToId: ReportingId, LeavingDate: LeavingDate, CreatedBy: CreatedBy };
            //End Of Comment by imran on 12-01-2022
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/SaveReleaseResource',
                type: "POST",
                data: JSON.stringify(objRelease),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objRelease) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objRelease) ? objRelease : JSON.stringify(objRelease)));
                    }
                },
                success: function (data) {
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.success(" Resource released successfuly!");
                    alertify.success(" Resource released successfully!");
                    //Added By Rutuja D. For Spelining Mistek Issue on 9 Aug 2021
                    $("#txtLeavingDate").val(LeavingDate);
                    $('#EPReleasemodal').modal('hide');
                    $('#btnaReleasePopup').addClass("clsShowHide");
                    $('#btnReassign').show(); //Added By Reshma Chavan on 28 jan 2022 for Showing Reassign button
                    $(".Resourcedetailpanel").show();
                    $('html,body').animate({
                        scrollTop: $(".Resourcedetailpanel").offset().top - 60
                    }, 'slow');
                    $(".newStatus").text("Inactive");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }


        ///Get list of emp using userid (emp which reporting to logged user)
        function GetEmpListForUser() {
            var strHTML = '';
            var EmpIdEdit = $('#hdnEmployee_UniqueIDTab').val();
            var objTrnsferProjectResTo = { ApproverID: EmpIdEdit }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetReleaseReportingToList',
                type: "POST",
                data: JSON.stringify(objTrnsferProjectResTo),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objTrnsferProjectResTo) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objTrnsferProjectResTo) ? objTrnsferProjectResTo : JSON.stringify(objTrnsferProjectResTo)));
                    }
                },
                success: function (data) {
                    if (data != null && data.length > 0) {
                        $.each(data, function (indexRelease, objRelease) {
                            strHTML += '<tr><td class="text-start">' + objRelease.EmployeeName + ' </td></tr>';
                        })
                        $('#hdn_EmpReleaseWithoutReportingTo').val(0)
                        $("#ReleaseReportingToDiv").removeClass("clsShowHide");
                    }
                    else {
                        // strHTML = '<tr>No data found. </tr>'
                        $('#hdn_EmpReleaseWithoutReportingTo').val(1)
                        $("#ReleaseReportingToDiv").addClass("clsShowHide");
                    }
                    $("#ReleaseReportingToBody").html(strHTML)
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }

        //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
        function btnDeleteFilter(FilterID, FilterName, Flag) {
            FilterName = unescape(FilterName).trim();
            $('#DFilterID').val(FilterID);
            $('#DFilterName').val(FilterName);
            $('#DIsApplyed').val(Flag);
            $('#deleteConfirmAlert').modal('show');
        }

        function confirmDelete() {
            var FilterID = $('#DFilterID').val();
            var FilterName = $('#DFilterName').val();
            var FilterIsApplyed = $('#DIsApplyed').val();
            if (FilterIsApplyed == 3) {
                DeleteFilter(FilterID, FilterName, 3);
            } else {
                DeleteFilter(FilterID, FilterName);
            }
        }
        //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021

        //Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }
        //End of Added By Chetan M. For Bind Filter Placeholder on 14 July 2021


        //Added By Rutuja D. on 5 Aug 2021 For Edit Cost
        function GetCurrencyCostForEdit(EmployeeCostID) {
            $('#btnSaveCost').hide();
            $('#btnsave').hide();
            $('#btnUpdateCost').show();
            $('#hdnEmployeeCostID').val(EmployeeCostID);
            var Parameter = {
                EmployeeCostID: EmployeeCostID,
                EmployeeID: $('#hdnEmployee_UniqueIDTab').val(),
            }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetCurrencyCostForEdit',
                type: "POST",
                data: JSON.stringify(Parameter),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                    }
                },
                success: function (data) {
                    var symbol = data;
                    $.each(symbol, function (index, obj) {
                        $("#MECostEffectiveDate").val(obj.StartDate);
                        $("#txtMECostPerHour").val(obj.CostPerHour);
                    });

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
            })

        }

        function UpdateCurrencyCost() {
            var EmployeeID = $('#hdnEmployee_UniqueIDTab').val();
            var EmployeeCostID = $('#hdnEmployeeCostID').val();
            checkCostValidation();
            if (validateCostflag == true) {
                var StartDate = $("#MECostEffectiveDate").val();
                var CostPerHour = $("#txtMECostPerHour").val();
                var CreatedBy = '<%= Session("strUserName") %>';

                var Op_Patameters = {
                    EmployeeId: EmployeeID,
                    StartDate: StartDate,
                    CostPerHour: CostPerHour,
                    CreatedBy: CreatedBy,
                    EmployeeCostID: EmployeeCostID
                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/UpdateCostDetails',
                    method: 'Post',
                    data: JSON.stringify(Op_Patameters),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Op_Patameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Op_Patameters) ? Op_Patameters : JSON.stringify(Op_Patameters)));
                        }
                    },
                    success: function (data) {

                        if (data == "Cost updated successfully.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                            $('#hdnEmployeeCostID').val();
                            $('#MEaddcostmodal').modal('hide');
                            GetCostList($('#hdnEmployee_UniqueIDTab').val());
                            clearCostDetails();
                            editEmployee(EmployeeID);
                        } else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $('#MEaddcostmodal').modal('show');
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);
                        }

                    }
                })
            } else {
                return false;
            }

        }
        //End of Added By Rutuja D. on 5 Aug 2021 For Edit Cost

        //Added By Rutuja D. on 5 Aug 2021 For Edit Qualification
        function GetQualificationForEdit(EmployeeQualificationID) {
            $('#btnSaveQualification').hide();
            $('#btnQuaSave').hide();
            $('#btnUpdateQua').show();
            $('#hdnEmployeeQualificationID').val(EmployeeQualificationID);
            var Parameter = {
                QualificationID: EmployeeQualificationID,
                EmployeeID: $('#hdnEmployee_UniqueIDTab').val(),
            }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetEditQualificationDetails',
                type: "POST",
                data: JSON.stringify(Parameter),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                    }
                },
                success: function (data) {
                    var symbol = data;
                    $.each(symbol, function (index, obj) {
                        $("#cboQualificationID").val(obj.QualificationID);
                        $("#cboPassoutYear").val(obj.PassoutYear);
                        $("#txtUniversityName").val(obj.University);
                        $("#txtClass").val(obj.Class);
                        $("#txtPercentage").val(obj.Percentage);
                    });

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
            })

        }

        function UpdateQualification() {
            var EmployeeID = $("#hdnEmployee_UniqueIDTab").val();
            checkValidationforQuali();
            if (Qvalidateflag == true) {
                var QualificationID = $("#cboQualificationID").val();
                var PassoutYear = $("#cboPassoutYear").val();
                var University = $("#txtUniversityName").val();
                var Class = $("#txtClass").val();
                var PercentageDetails = $("#txtPercentage").val().replace(/%/g, "");
                var EmployeeQualificationID = $('#hdnEmployeeQualificationID').val();
                var Op_Patameters = {
                    QualificationID: QualificationID,
                    PassoutYear: PassoutYear,
                    University: University,
                    CreatedBy: '<%= Session("strUserName") %>',
                    EmployeeQualificationID: EmployeeQualificationID,
                    Class: Class,
                    Percentage: PercentageDetails,
                    EmployeeID: EmployeeID
                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/UpdateQualificationDetails',
                    method: 'Post',
                    data: JSON.stringify(Op_Patameters),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Op_Patameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Op_Patameters) ? Op_Patameters : JSON.stringify(Op_Patameters)));
                        }
                    },
                    success: function (data) {

                        if (data == "Qualification updated successfully.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                            $('#hdnEmployeeQualificationID').val();
                            $('#MEaddQualificationModal').modal('hide');
                            GetEmpQualification(EmployeeID);
                            clearQualifDetail();
                            editEmployee(EmployeeID);
                        } else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $('#MEaddQualificationModal').modal('show');
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);
                        }

                    }
                })
            } else {
                return false;
            }

        }
        //End of Added By Rutuja D. on 5 Aug 2021 For Edit Qualification

        function isNumberKey(txt, evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode == 46) {
                //Check if the text already contains the . character
                if (txt.value.indexOf('.') === -1) {
                    return true;
                } else {
                    return false;
                }
            } else {
                if (charCode > 31 &&
                    (charCode < 48 || charCode > 57))
                    return false;
            }
            return true;
        }

        //Added by Chetan M on 10 Aug 2021 for Edit functionality
        function GetPreWorkExpForEdit(EmployeeHistoryID) {
            $('#btnSavePreWorkExpDetails').hide();
            $('#btnSavePreWork').hide();
            $('#btnUpdateExperience').show();
            $('#hdnEmployeeHistoryID').val(EmployeeHistoryID);
            var Parameter = {
                EmployeeCostID: EmployeeHistoryID,
                EmployeeID: $('#hdnEmployee_UniqueIDTab').val(),
            }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetPreviousWorkExpForEdit',
                type: "POST",
                data: JSON.stringify(Parameter),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                    }
                },
                success: function (data) {
                    var symbol = data;
                    $.each(symbol, function (index, obj) {

                        $("#txtPreWorkExpOrganisation").val(obj.OrganizationName);
                        $("#txtPreWorkExpPositionHeld").val(obj.PositionHeld);
                        $("#MEPWEFromDate").val(obj.WorkedFrom);
                        $("#MEPWEtillDate").val(obj.WorkedTill);
                        $("#cboPreWorkExpWorkProfile").val(obj.WorkProfileNature);
                        $("#txtPreWorkExpSummary").val(obj.Summary);
                    });

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
            })

        }


        function UpdatePreviousExperience() {
            var EmployeeHistoryID = $('#hdnEmployeeHistoryID').val();
            var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
            checkPreWorkExpValidation();
            if (validatePreworkExpflag == true) {
                var OrganizationName = $("#txtPreWorkExpOrganisation").val();
                var WorkedFrom = $("#MEPWEFromDate").val();
                var WorkedTill = $("#MEPWEtillDate").val();
                var WorkProfileNature = $("#cboPreWorkExpWorkProfile").val();
                var PositionHeld = $("#txtPreWorkExpPositionHeld").val();
                var Summary = $("#txtPreWorkExpSummary").val();

                var employeePreWorkExpParameters = {
                    EmployeeId: EmployeeId,
                    OrganizationName: OrganizationName,
                    WorkedFrom: WorkedFrom,
                    WorkedTill: WorkedTill,
                    WorkProfileNature: WorkProfileNature,
                    PositionHeld: PositionHeld,
                    Summary: Summary,
                    EmployeeHistoryID: EmployeeHistoryID

                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/SaveMEPreWorkExperienceDetails',
                    method: 'Post',
                    data: JSON.stringify(employeePreWorkExpParameters),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        //Added by Riddhesh Patil on 24 Sep 2024 for validate headers
                        if (employeePreWorkExpParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(employeePreWorkExpParameters) ? employeePreWorkExpParameters : JSON.stringify(employeePreWorkExpParameters)));
                        }
                        //End of Added by Riddhesh Patil on 24 Sep 2024 for validate headers
                    },
                    success: function (data) {
                        // CurrentGRPTabObject.GrpManager = 'false';
                        //ShowGRPManager();     
                        GetPreWorkExpDetailsList($('#hdnEmployee_UniqueIDTab').val());


                        if (data == "Pre Work Experience already exist") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $('#MEPWExpmodal').modal('show');
                        } else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                            clearPreWorkExpDetails();
                            $('#MEPWExpmodal').modal('hide');
                        }


                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }

                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);
                        }

                        //StopAjaxLoader("#bodyGlobal-Resource");
                        if (isSavenAdd == 0) {
                            $('#MEPWExpmodal').modal('hide');
                        }
                    }
                })
            } else {
                return false;
            }

        }

        function GetPreAssigmentForEdit(EmployeeHistoryProjectID) {
            $('#btnSavePreAssignment').hide();
            $('#btnSavePreAssignmentDetails').hide();
            $('#btnUpdatePreviousAssignment').show();
            $('#hdnEmployeeHistoryProjectID').val(EmployeeHistoryProjectID);
            var Parameter = {
                EmployeeHistoryProjectID: EmployeeHistoryProjectID,
                EmployeeID: $('#hdnEmployee_UniqueIDTab').val(),
            }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetMEPreAssignmentDetailsEdit',
                type: "POST",
                data: JSON.stringify(Parameter),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                    }
                },
                success: function (data) {
                    var symbol = data;
                    $.each(symbol, function (index, obj) {

                        $("#txtPreAssProjectName").val(obj.ProjectName);
                        $("#txtPreAssRole").val(obj.Role);
                        $("#txtPreAssDuration").val(obj.Duration);
                        $("#txtTeamSize").val(obj.TeamSize);
                        $("#txtEnvironment").val(obj.Environment);
                        $("#txtSkills").val(obj.SkillSet);
                        $("#txtPreAssDescription").val(obj.Description);
                    });

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
            })

        }


        function UpdatePreviousAssignment() {
            var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
            var EmployeeHistoryProjectID = $("#hdnEmployeeHistoryProjectID").val();
            checkPreassignmentValidation();
            if (validatePreassignmentflag == true) {
                var ProjectName = $("#txtPreAssProjectName").val();
                var Duration = $("#txtPreAssDuration").val();
                var TeamSize = $("#txtTeamSize").val();
                var Role = $("#txtPreAssRole").val();
                var Environment = $("#txtEnvironment").val();
                var SkillSet = $("#txtSkills").val();
                var Description = $("#txtPreAssDescription").val();
                var UserName = '<%= Session("strUserName") %>';

                var employeePreAssignmentParameters = {
                    EmployeeId: EmployeeId,
                    ProjectName: ProjectName,
                    Duration: Duration,
                    TeamSize: TeamSize,
                    Role: Role,
                    Environment: Environment,
                    SkillSet: SkillSet,
                    Description: Description,
                    CreatedBy: UserName,
                    EmployeeHistoryProjectID: EmployeeHistoryProjectID

                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/SaveMEPreAssignmentDetails',
                    method: 'Post',
                    data: JSON.stringify(employeePreAssignmentParameters),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        //Added by Riddhesh Patil on 24 Sep 2024 for validate headers
                        if (employeePreAssignmentParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(employeePreAssignmentParameters) ? employeePreAssignmentParameters : JSON.stringify(employeePreAssignmentParameters)));
                        }
                        //End of Added by Riddhesh Patil on 24 Sep 2024 for validate headers
                    },
                    success: function (data) {

                        GetPreAssignmentDetailsList($('#hdnEmployee_UniqueIDTab').val());


                        if (data == "Assignment details already exist") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $('#MEPrevAsignmentModal').modal('show');
                        } else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                            clearPreAssignmentDetails();
                            $('#MEPrevAsignmentModal').modal('hide');
                        }


                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }

                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);
                        }

                        //StopAjaxLoader("#bodyGlobal-Resource");
                        if (isSavenAdd == 0) {
                            $('#MEPrevAsignmentModal').modal('hide');
                        }
                    }
                })
            } else {
                return false;
            }
        }



        function GetCeritficationForEdit(EmployeeCertificationID) {
            $('#btnSaveCertifaction').hide();
            $('#btnSaveCert').hide();
            $('#btnUpdateCertification').show();
            $('#hdnEmployeeCertificationID').val(EmployeeCertificationID);
            var EmpID = $("#hdnEmployee_UniqueIDTab").val();

            //var certID = $("#txtFILTERCertificationID").val();
            //StartLoader("#DesgLeaves");
            var CertParams = { EmployeeID: EmpID, EmployeeCertificationID: EmployeeCertificationID }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetCertificationForEdit',
                type: "POST",
                data: JSON.stringify(CertParams),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (CertParams) {
                        xhr.setRequestHeader("Params", encryptString(isJson(CertParams) ? CertParams : JSON.stringify(CertParams)));
                    }
                },
                success: function (data) {

                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            //alert(obj.CertificationDate);
                            var cdate;
                            if (obj.CertificationDate == '1900-01-01T00:00:00') {
                                cdate = "";
                            } else {
                                cdate = obj.CertificationDate;
                            }

                            if (obj.ValidUpto == '01 Jan 1900') {
                                var ValidUpto = "";
                            } else {
                                var ValidUpto = obj.ValidUpto;
                            }
                            if (obj.ActualScore == '0') {
                                obj.ActualScore = "0";
                            } else {
                                obj.ActualScore = obj.ActualScore;
                            }
                            if (obj.TotalScore == '0') {
                                obj.TotalScore = "0";
                            } else {
                                obj.TotalScore = obj.TotalScore;
                            }
                            $("#txtCertificationID").val(obj.CertificationID);
                            $("#txtCertificationDate").val(cdate);
                            $("#txtValidUpto").val(ValidUpto);
                            // debugger;
                            //Added & Commented By Dipali V on 2nd Dec 2021 To Bind Actual Value to resp control
                            //$("#txtActualScore").val(obj.ActualScore);
                            //$("#txtTotalScore").val(obj.TotalScore);
                            $("#txtTotalScore").val(obj.TotalScore);
                            $("#txtActualScore").val(obj.ActualScore);
                            //End of Added & Commented By Dipali V on 2nd Dec 2021 To Bind Actual Value to resp control
                        });
                    }

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
            })

        }

        function UpdateCertification() {
            var EmployeeCertificationID = $("#hdnEmployeeCertificationID").val();
            //alert(EmployeeCertificationID);
            checkValidationforCert();
            if (Cvalidateflag == true) {
                // var UniqueID = $("#hdn_LeaveUnquieID").val();
                var EmpCertID = $("#hdnCertificationId").val();
                var EmployeeID = $("#hdnEmployee_UniqueIDTab").val();
                var certId = $("#txtCertificationID").val();
                var CertDate = $("#txtCertificationDate").val();
                var ValidUpto = $("#txtValidUpto").val();
                var AScore = $("#txtActualScore").val();
                var TScore = $("#txtTotalScore").val();
                //alert("EmployeeID " + EmployeeID);
                var Details = {
                    EmployeeCertificationID: EmpCertID > 0 ? EmpCertID : 0,
                    EmployeeID: EmployeeID,
                    CertificationID: certId,
                    CertificationDate: CertDate,
                    ValidUpto: ValidUpto,
                    ActualScore: AScore,
                    TotalScore: TScore,
                    CreatedBy: encodeURI(UserName),
                    EmployeeCertificationID: EmployeeCertificationID

                };
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/UpdateCertifications',
                    method: 'Post',
                    data: JSON.stringify(Details),
                    dataType: 'json',
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Details) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Details) ? Details : JSON.stringify(Details)));
                        }
                    },
                    success: function (data) {
                        if (data == "Certification already exist.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            //onCloseLeaves();
                            $("#txtCertificationID").focus();
                            GetCertifications($("#hdnEmployee_UniqueIDTab").val());
                        }
                        else {
                            $('#AddCertModal').modal('hide');
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                            GetCertifications($("#hdnEmployee_UniqueIDTab").val());
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            CurrentTabObject.Certification = 'false';
                            GetCertifications($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.Certification = 'true';
                            //StopAjaxLoader("#bodyGlobal-Resource");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        // StopAjaxLoader("#DesgLeaves");
                        //if (isFromSaveAndclick == 0) {
                        //    $('#AddVTModal').modal('hide');
                        //}
                    }
                })
            } else {
                return false;
            }
        }

        function GetEmployeeGroupForEdit(UniqueID) {
            $('#btnAddEmpGroup').hide();
            $('#btnsaveEmpGroup').hide();
            $('#btnUpdateEmpGroups').show();
            $('#hdnEmployeeGroupID').val(UniqueID);
            var EmpID = $("#hdnEmployee_UniqueIDTab").val();

            var Parameter = { UserID: EmpID, UniqueID: UniqueID }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetEmployeeGroupForEdit',
                type: "POST",
                data: JSON.stringify(Parameter),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                    }
                },
                success: function (data) {

                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            $("#cboGroup").val(obj.GroupID);
                        });
                    }

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
            })

        }

        function UpdateEmpGroups(isFromSaveAndclick) {
            checkValidationforGroup();
            if (Gvalidateflag == true) {
                // var UniqueID = $("#hdn_LeaveUnquieID").val();
                var UniqueID = $("#hdnEmployeeGroupID").val();
                var EmployeeID = $("#hdnEmployee_UniqueIDTab").val();
                var grp = $("#cboGroup").val();
                var Details = {
                    UniqueID: UniqueID,
                    UserID: EmployeeID,
                    GroupID: grp,
                    LoginType: SessionLoginType
                    //CreatedBy: encodeURI(UserName)

                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/UpdateGroups',
                    method: 'Post',
                    data: JSON.stringify(Details),
                    dataType: 'json',
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Details) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Details) ? Details : JSON.stringify(Details)));
                        }
                    },
                    success: function (data) {
                        if (data == "Group Name already exist.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $("#cboGroup").focus();
                            GetEmpGroup($("#hdnEmployee_UniqueIDTab").val());
                        }
                        else {
                            $('#MEaddGroup').modal('hide');
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                            GetEmpGroup($("#hdnEmployee_UniqueIDTab").val());
                            //Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
                            $('table').columns.adjust();// added by pradip on 20-7-2021
                            $($.fn.dataTable.tables(true)).css('width', '100%');
                            $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
                            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
                            //End of Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable

                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);

                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }

                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            CurrentTabObject.Groups = 'false';
                            GetEmpGroup($("#hdnEmployee_UniqueIDTab").val());
                            CurrentTabObject.Groups = 'true';
                            //StopAjaxLoader("#bodyGlobal-Resource");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }

                    }
                })
            } else {
                return false;
            }
        }
        //End of Added by Chetan M on 10 Aug 2021 for Edit functionality


        //Added By Rutuja D. on 13 Aug 2021 For Edit Visa Details
        function GetVisaDetailsForEdit(EmployeeVisaID) {
            $('#btnSaveVisaModal').hide();
            $('#BtnSaveVisaDetails').hide();
            $('#btnUpdateVisa').show();
            $('#hdnEmployeeVisaID').val(EmployeeVisaID);
            var Parameter = {
                EmployeeVisaID: EmployeeVisaID,
                EmployeeID: $('#hdnEmployee_UniqueIDTab').val(),
            }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetEditEmployeeVisaDetails',
                type: "POST",
                data: JSON.stringify(Parameter),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                    }
                },
                success: function (data) {
                    var symbol = data;
                    $.each(symbol, function (index, obj) {
                        $("#cboCountry").val(obj.CountryID);
                        $("#cboVisaType").val(obj.VisaTypeID);
                        $("#MEvalidFromDate").val(obj.ValidFrom);
                        $("#MEvalidToDate").val(obj.ValidUpto);
                        $("#description").val(obj.Remarks);
                    });

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
            })

        }

        function UpdateVisaDetails() {
            var EmployeeId = $('#hdnEmployee_UniqueIDTab').val();
            checkVisaValidation();
            if (validateVisaflag == true) {
                var CountryId = $("#cboCountry").val();
                var VisaTypeId = $("#cboVisaType").val();
                var ValidFrom = $("#MEvalidFromDate").val();
                var ValidTo = $("#MEvalidToDate").val();
                var remark = $("#txtDescription").val();
                var UserName = '<%= Session("strUserName") %>';
                //debugger;
                var employeeVisaParameters = {
                    EmployeeVisaID: $('#hdnEmployeeVisaID').val(),
                    CountryId: CountryId,
                    VisaTypeId: VisaTypeId,
                    dtValidFrom: ValidFrom,
                    dtValidUpto: ValidTo,
                    remark: remark,
                    CreatedBy: UserName,
                    EmployeeId: EmployeeId
                };

                $.ajax({
                    url: strUrl + '/api/RM_EmployeeMaster/UpdateVisaDetails',
                    method: 'Post',
                    data: JSON.stringify(employeeVisaParameters),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (employeeVisaParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(employeeVisaParameters) ? employeeVisaParameters : JSON.stringify(employeeVisaParameters)));
                        }
                    },
                    success: function (data) {

                        if (data == "Visa Details updated successfully.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                            $('#hdnEmployeeQualificationID').val();
                            $("#MEaddVisaDetailmodal").modal('hide');
                            GetEmployeeVisaDetailsList(EmployeeId);
                        } else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $('#MEaddVisaDetailmodal').modal('show');
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);
                        }

                    }
                })

            } else {
                return false;
            }

        }
        //End of Added By Rutuja D. on 13 Aug 2021 For Edit Visa Details


        function BindToolTip(ID) {

            var Selectedtext = $("#" + ID + " option:selected").text();
            if (Selectedtext != "") {
                $("#Div" + ID).attr("data-bs-toggle", "tooltip");
                $("#Div" + ID).attr("data-bs-original-title", Selectedtext);
            }
            $('#' + ID).hover(function () {
                $('data-bs-toggle= tooltip ').tooltip();
            });
        }

        function BindTextBoxToolTip(ID) {
            var Selectedtext = $("#" + ID).val();
            if (Selectedtext != "") {
                $("#Div" + ID).attr("data-bs-toggle", "tooltip");
                $("#Div" + ID).attr("data-bs-original-title", Selectedtext);
            }
            $('#' + ID).hover(function () {
                $('data-bs-toggle= tooltip ').tooltip();
            });
        }

        function OnHoverBindTooltipValue(flag) {
            BindToolTip("cboRole");
            BindToolTip("cboDepartmentUnit");
            BindToolTip("cboBloodGroup");
            BindToolTip("cboGender");
            BindToolTip("cboDeployable");
            BindTextBoxToolTip("txtRatePerHr");
            BindTextBoxToolTip("txtCostPerHr");
            BindTextBoxToolTip("txtCurrentState");
            BindTextBoxToolTip("txtCostToCompany");
            BindToolTip("cboDesignation");
            BindToolTip("cboEmployeeType");
            BindToolTip("cboBG");
            BindToolTip("cboOU");
            BindToolTip("cboDU");
            BindToolTip("cboDT");
            BindToolTip("cboFacility");
            BindToolTip("cboReportingTo");
            BindToolTip("cboGrade");
            if (flag == 1) {
                BindTextBoxToolTip("txtExtensionNo");
            }
            else {
                $('#DivtxtExtensionNo').removeAttr("data-bs-original-title");
            }
            BindToolTip("cboCurrency");
            //End of Added By Reshma Chavan on 12th oct 2021
        }
        // $('#DivtxtRatePerHr,#cboDepartmentUnit').hover(function () {
        //    $('data-bs-toggle= tooltip ').tooltip();
        //});

        ////Release resource
        //Added By Reshma Chavan on 7th Dec 2021 For Download Template
        function Download_Template() {
            window.open("../../General/ViewAttachment.aspx?FromWhere=DXU&FileName=EmployeeTemplate.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=850,height=500");
        }
        //End of Added By Reshma Chavan on 7th Dec 2021 For Download Template


        //Added By Reshma Chavan on 28 Jan 2022 Fr Reassign resource Functionality
        function OpenReassignPopup() {
            //checkValidation();            
            //if (validateflag == true) {
            GblReassignFlag = "1";
            SaveEmployeeDetails(0);

            // }
        }
        function ReassignResource() {
            var EmpIdEdit = $('#hdnEmployee_UniqueIDTab').val();
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/ReassignResource',
                type: "POST",
                data: JSON.stringify(EmpIdEdit),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (EmpIdEdit) {
                        xhr.setRequestHeader("Params", encryptString(isJson(EmpIdEdit) ? EmpIdEdit : JSON.stringify(EmpIdEdit)));
                    }
                },
                success: function (data) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Resource Reassigned Successfully");
                    $('#btnReassign').hide();
                    $('#btnaReleasePopup').show();
                    editEmployee(EmpIdEdit);
                    //Added By Dipali V On 7th Feb 2022 For After Reassigned Resource Leaving Date Should get cleared
                    $("#txtLeavingDate").val("");

                    //End of Added By Dipali V On 7th Feb 2022 For After Reassigned Resource Leaving Date Should get cleared

                },

                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }

            })
        }

        //Restrict Special Charaters onkeypress
        function restrictSpecialChars(e) {
            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57));
        }
         //End of Added By Reshma Chavan on 28 Jan 2022 Fr Reassign resource Functionality

        function closeFilterPanel() {
            $("#filterpanel").removeClass('show');
        }
    </script>

    
    <%--Added by Aditya J. on 05-03-2026 for GDPR Field Visiblility settings--%>
    <%-- ====== GDPR Item 54: Field Visibility Configuration Script ====== --%>
    <script>
        // ---------------------------------------------------------------
        // GDPR Field Visibility Configuration
        // Item 54 - GDPR Compliance: Employee Master PII Field Control
        // Settings are persisted in DB via API (tbl_GDPR_EmpMaster_FieldConfig)
        // ---------------------------------------------------------------

        //var strUrl = '<%= Session("strURL") %>';

        // Map: DB FieldName -> { divId, chkId }
        var gdprFieldMap = [
            { key: 'BirthDate',    divId: 'DivBirthDateField',    chkId: 'gdprChkBirthDate'    },
            { key: 'Email',        divId: 'DivEmailField',        chkId: 'gdprChkEmail'        },
            { key: 'Gender',       divId: 'DivGenderField',       chkId: 'gdprChkGender'       },
            { key: 'EmployeeType', divId: 'DivEmployeeTypeField', chkId: 'gdprChkEmployeeType' },
            { key: 'Messanger',    divId: 'DivMessangerIDField',  chkId: 'gdprChkMessanger'    },
            { key: 'ExtensionNo',  divId: 'DivExtensionNoField',  chkId: 'gdprChkExtensionNo'  },
            { key: 'Address',      divId: 'DivAddressField',      chkId: 'gdprChkAddress'      }
        ];

        // In-memory cache of config loaded from DB
        var gdprCurrentConfig = {};

        // Apply a config object { FieldName: IsVisible } to the page
        function gdprApplyConfig(config) {
            $.each(gdprFieldMap, function (i, f) {
                var visible = (config[f.key] !== false && config[f.key] !== 0);
                if (visible) { $('#' + f.divId).show(); } else { $('#' + f.divId).hide(); }
            });
            // Email ID column in list view (column index 5, 0-based)
            var emailColVisible = (config['Email'] !== false && config['Email'] !== 0);
            if (emailColVisible) {
                $('#thEmailID').show();
                $('#MEListTbl tbody tr').each(function () { $(this).find('td:eq(5)').show(); });
            } else {
                $('#thEmailID').hide();
                $('#MEListTbl tbody tr').each(function () { $(this).find('td:eq(5)').hide(); });
            }
        }

        //Added by Aditya J. on 05-03-2026 for GDPR Field Visiblility settings
        // Load config from DB API and apply to page
        function gdprLoadAndApplyConfig(callback) {
            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/GetGDPRFieldConfig',
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));                    
                },
                success: function (data) {
                    // Convert array [{FieldName,IsVisible},...] to flat object
                    var config = {};
                    if (data && data.length > 0) {
                        $.each(data, function (i, item) {
                            config[item.FieldName] = item.IsVisible;
                            // Support API naming variants for "Additional Info" subtab.
                            if (item.FieldName === 'AdditionalInfo' || item.FieldName === 'AdditionlInfo') {
                                config['AdvancedInfo'] = item.IsVisible;
                                config['AdditionalInfo'] = item.IsVisible;
                                config['AdditionlInfo'] = item.IsVisible;
                            }
                        });
                    } else {
                        // Fallback: all visible if DB returns nothing
                        $.each(gdprFieldMap, function (i, f) { config[f.key] = true; });
                    }
                    gdprCurrentConfig = config;
                    gdprApplyConfig(config);

                    //Added by Aditya J. on 04-03-2026 for dynamically hiding/showing GDPR configurable controls based on checkbox selection
                    function toggleGDPRControlsByConfig(currConfig) {
                        function isVisibleFlag(val) {
                            return !(val === false || val === 0 || val === '0' || val === 'false');
                        }

                        var additionalInfoVisible = isVisibleFlag(currConfig['AdvancedInfo']) &&
                            isVisibleFlag(currConfig['AdditionalInfo']) &&
                            isVisibleFlag(currConfig['AdditionlInfo']);
                        var visaDetailsVisible = isVisibleFlag(currConfig['VisaDetails']);

                        // Birth Date
                        if (currConfig['BirthDate'] === false || currConfig['BirthDate'] === 0) {
                            $("#txtBirthDate").hide();
                        } else {
                            $("#txtBirthDate").show();
                        }
                        // Email ID
                        if (currConfig['Email'] === false || currConfig['Email'] === 0) {
                            $("#txtEmail").hide();
                        } else {
                            $("#txtEmail").show();
                        }
                        // Gender
                        if (currConfig['Gender'] === false || currConfig['Gender'] === 0) {
                            $("#cboGender").hide();
                        } else {
                            $("#cboGender").show();
                        }
                        // Employee Type
                        if (currConfig['EmployeeType'] === false || currConfig['EmployeeType'] === 0) {
                            $("#cboEmployeeType").hide();
                        } else {
                            $("#cboEmployeeType").show();
                        }
                        // Messenger ID
                        if (currConfig['Messanger'] === false || currConfig['Messanger'] === 0) {
                            $("#txtMessangerID").hide();
                        } else {
                            $("#txtMessangerID").show();
                        }
                        // Extension No.
                        if (currConfig['ExtensionNo'] === false || currConfig['ExtensionNo'] === 0) {
                            $("#txtExtensionNo").hide();
                        } else {
                            $("#txtExtensionNo").show();
                        }
                        // Current / Permanent Address (both address textareas + main div)
                        if (currConfig['Address'] === false || currConfig['Address'] === 0) {
                            $("#DivAddressField").hide();
                            $("#txtCurrentAddress").hide();
                            $("#txtAddresss").hide();
                        } else {
                            $("#DivAddressField").show();
                            $("#txtCurrentAddress").show();
                            $("#txtAddresss").show();
                        }

                        // ===== Subtabs visibility (Advanced Info, Certifications, Visa, Qualifications, Prev. Work Exp., Prev. Assignment) =====
                        // Additional Info tab: show if AdditionlInfo OR VisaDetails is visible.
                        if (additionalInfoVisible || visaDetailsVisible) {
                            $("#EmpAdvTab").closest('li').show();
                        } else {
                            $("#EmpAdvTab").closest('li').hide();
                        }

                        // Address Details accordion: controlled by AdditionlInfo only.
                        if (additionalInfoVisible) {
                            $("#CollapseAddressInAdvance").closest('.panel').show();
                        } else {
                            $("#CollapseAddressInAdvance").closest('.panel').hide();
                        }
                        // Personal Info - Certifications section visibility
                        if (currConfig['Certifications'] === false || currConfig['Certifications'] === 0) {
                            $("#CollapseCertification").closest('.panel').hide();
                        } else {
                            $("#CollapseCertification").closest('.panel').show();
                        }
                        // Visa Details
                        //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
                        //$("#EmpVisaTab").closest('li').hide();
                        //$("#EmpVisaTab").closest('li').show();
                        if (!visaDetailsVisible) {
                            $("#CollapseVisaInAdvance").closest('.panel').hide();
                        } else {
                            $("#CollapseVisaInAdvance").closest('.panel').show();
                        }
                        //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
                        // Personal Info - Qualifications section visibility
                        if (currConfig['Qualifications'] === false || currConfig['Qualifications'] === 0) {
                            $("#CollapseQualification").closest('.panel').hide();
                        } else {
                            $("#CollapseQualification").closest('.panel').show();
                        }
                        // Prev. Work Exp.
                        //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
                        //$("#EmpPrevExpTab").closest('li').hide();
                        //$("#EmpPrevExpTab").closest('li').show();
                        if (currConfig['PrevWorkExp'] === false || currConfig['PrevWorkExp'] === 0) {
                            $("#CollapseAssignmentPrevWorkExp").closest('.panel').hide();
                        } else {
                            $("#CollapseAssignmentPrevWorkExp").closest('.panel').show();
                        }
                        //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
                        // Prev. Assignment
                        //Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
                        //$("#EmpPrevAssgnTab").closest('li').hide();
                        //$("#EmpPrevAssgnTab").closest('li').show();
                        if (currConfig['PrevAssignment'] === false || currConfig['PrevAssignment'] === 0) {
                            $("#CollapseAssignmentPrevAssignment").closest('.panel').hide();
                        } else {
                            $("#CollapseAssignmentPrevAssignment").closest('.panel').show();
                        }
                        //End of Added by Aditya J. on 23-04-2026 for Emp Master Subtabs reshufflement
                    }

                    // Initial apply based on loaded configuration
                    toggleGDPRControlsByConfig(config);

                    // Wire checkbox change events so that controls respond immediately when user toggles in GDPR popup
                    $.each(gdprFieldMap, function (i, f) {
                        var $chk = $('#' + f.chkId);
                        if ($chk.length > 0) {
                            $chk.off('change.gdprToggle').on('change.gdprToggle', function () {
                                var updatedConfig = $.extend({}, gdprCurrentConfig);
                                updatedConfig[f.key] = $(this).is(':checked');
                                toggleGDPRControlsByConfig(updatedConfig);
                            });
                        }
                    });
                    //End of Added by Aditya J. on 04-03-2026 for dynamically hiding/showing GDPR configurable controls based on checkbox selection

                    if (typeof callback === 'function') { callback(config); }
                },
                error: function () {
                    // On error default all fields visible - fail open
                    var config = {};
                    $.each(gdprFieldMap, function (i, f) { config[f.key] = true; });
                    gdprCurrentConfig = config;
                    gdprApplyConfig(config);
                }
            });
        }
        //End of Added by Aditya J. on 05-03-2026 for GDPR Field Visiblility settings
        // Open GDPR modal and populate checkboxes from DB config
        //function openGDPRConfig() {
            
        //    gdprLoadAndApplyConfig(function (config) {
        //        $.each(gdprFieldMap, function (i, f) {
        //            var isVis = (config[f.key] !== false && config[f.key] !== 0);
        //            $('#' + f.chkId).prop('checked', isVis);
        //        });
        //        var gdprModal = new bootstrap.Modal(document.getElementById('GDPRConfigModal'));
        //        gdprModal.show();
        //    });            
        //}
        
        // Reset modal checkboxes to all-visible
        //function gdprResetDefaults() {
        //    $.each(gdprFieldMap, function (i, f) {
        //        $('#' + f.chkId).prop('checked', true);
        //    });
        //}

        // Save config to DB via API
        <%--function gdprSaveConfig() {
            
            var payload = { ModifiedBy: '<%= Session("strUserName") %>' };
            $.each(gdprFieldMap, function (i, f) {
                payload[f.key] = $('#' + f.chkId).is(':checked');
            });

            $.ajax({
                url: strUrl + '/api/RM_EmployeeMaster/SaveGDPRFieldConfig',
                type: 'POST',
                data: JSON.stringify(payload),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (payload) {
                        xhr.setRequestHeader("Params", encryptString(payload));
                    }
                },
                success: function (result) {
                    // Apply immediately without another round-trip
                    var config = {};
                    $.each(gdprFieldMap, function (i, f) {
                        config[f.key] = $('#' + f.chkId).is(':checked');
                    });
                    gdprCurrentConfig = config;
                    gdprApplyConfig(config);
                    $('#GDPRConfigModal').modal('hide');
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('GDPR field visibility settings saved.');
                },
                error: function () {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Failed to save GDPR settings. Please try again.');
                }
            });
        }--%>

        $(document).ready(function () {

            //Added by Aditya J. on 04-03-2026 for permanantly hiding the blodd group and passport details fields
            $('.gdpr-permanent-hide').hide();
            //End of Added by Aditya J. on 04-03-2026 for permanantly hiding the blodd group and passport details fields

            // 2. Load configurable field visibility from DB and apply
            gdprLoadAndApplyConfig(null);

            // 3. Re-apply Email column hide after DataTable re-draws
            $('#MEListTbl').on('draw.dt', function () {
                var emailVis = (gdprCurrentConfig['Email'] !== false && gdprCurrentConfig['Email'] !== 0);
                if (!emailVis) {
                    $('#thEmailID').hide();
                    $('#MEListTbl tbody tr').each(function () { $(this).find('td:eq(5)').hide(); });
                }
            });
        });
    </script>
    <%-- ====== End GDPR Configuration Script ====== --%>

</body>

</html>
