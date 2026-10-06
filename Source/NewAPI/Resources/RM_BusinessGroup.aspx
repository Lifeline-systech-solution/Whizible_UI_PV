<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_BusinessGroup.aspx.vb" Inherits="PbNIT.RM_BusinessGroup" %>

<!DOCTYPE html> 
<html> 
     <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%>
<head runat="server"> 
  <%--  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
 <%--   <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>


    
   

</head>
 <style type="text/css">
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


        #BGtblmain_wrapper .dataTables_paginate {
            margin-top: 20px;
        }

        body#bodyBusiness-group {
            padding-right: 0 !important;
        }

        #BGtblmain_wrapper table {
            width: 100% !important;
        }

        .tooltip-inner {
            word-wrap: break-word;
            white-space: pre-line;
        }

        /*   .alertify-notifier li {
            word-break: normal !important;
            white-space: normal !important;
            background-color: red !important;
        }

       .alertifySuccess li {
            word-break: normal !important;
            white-space: normal !important;
            background-color: darkseagreen !important;
        }

        .alertify-notifier .ajs-message {
            width: 500px !important;
            height: 60px;
            word-break: break-word;
            background-color: red !important;
        }*/

        /*.alertify-notifier ajs-top ajs-right {
            background-color: red !important;
        }*/

        /*.alertify-notifier .ajs-message {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            word-break: break-all;
        }*/
        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            /*word-break: break-all;*/
        }

        /*.alertify-notifier {
            font-family: "Open Sans",sans-serif !important;
            font-size: 14px !important;
            display: inline-block;
            word-break: normal;
            white-space: pre-wrap;
            background-color: red !important;
        }*/

        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }

        .filter.pull-right {
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
            min-height:60vh;
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

        /*Resume Style*/
        /*.content-wrapper{background:#eee!important}*/
        #ResumeModal .modal-body {
            padding: 0;
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

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .dblock {
            display: block;
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

        .tooltip-inner {
            word-wrap: break-word;
            white-space: pre-line;
        }

        .alertify-notifier li {
            word-break: normal !important;
            white-space: normal !important;
        }

        .alertify-notifier .ajs-message {
            width: 400px;
            word-break: break-word;
        }

        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            word-break: break-all;
        }

        .alertify-notifier {
            font-family: "Open Sans",sans-serif !important;
            font-size: 14px !important;
            display: inline-block;
            word-break: normal;
            white-space: pre-wrap;
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

        .searchDate {
            top: 8px;
            position: relative;
            float: left;
            right: 25px;
            z-index: 5;
        }

        .filterADate {
            top: -22px;
            position: relative;
            float: left;
            right: -210px;
            z-index: 5;
        }

        .filterBDate {
            top: 41px;
            position: absolute;
            float: right;
            right: 16px;
            z-index: 4;
            left: auto;
            padding: 4px 8px;
            background: #ddd;
            line-height: 20px;
            height: 28px;
            cursor: pointer;
            border-radius: 0 4px 4px 0px;
        }

        .issuefilter_container .filterpanelbody {
            background: #ffffff;
        }

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

        #BGtblmain_wrapper .dataTables_paginate {
            margin-top: 20px;
        }

        body#tblBusinessGroups {
            padding-right: 0 !important;
        }

        #BGtblmain_wrapper table {
            width: 100% !important;
        }

        #resize_wrapper {
            position: absolute;
            top: 0em;
            left: 0em;
            right: 0em;
            bottom: 1em;
        }


        .table-outer-main {
            position: relative;
        }


        /*added by pradip on 15-11-2019*/
        .GRPtbl tr th:last-child, .issuelisttable tr th:nth-last-child(2), .issuelisttable tr th:nth-last-child(3), .issuelisttable tr th:nth-last-child(4), .issuelisttable tr th:nth-last-child(5) {
            min-width: 34px;
        }

        /*start vishal mahajan 04-12-2019*/
        .filter button[aria-expanded="true"] {
            background: NONE;
            color: #4263c1;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }

        .GRPtbl tr th {
            vertical-align: middle !important;
        }

        .fplist_title.collapsed {
            display: block;
        }
        /*Commented and Added By Nikhil A on 28-May-2020 for Integrating UX changes*/
        button#btnDelete {
            padding: 4px 12px;
            border: 1px solid;
        }

        #btnSearchByIcon {
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
        }
        /*Commented and Added By Nikhil A on 28-May-2020 for Integrating UX changes*/
        /*Added By Dipali V On 16th May 2020 For Loader Issues*/
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

        .clsShowHide {
            display: none !important;
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
        /*Added by pradip on 6-7-2021*/
        .rsrsouter{ max-height:55vh;}
        .rsrsouter thead th{ position:sticky; top:0;}/*End Added by pradip on 6-7-2021*/
		
ul.pagination {margin-bottom: 0!important;}		
.graphcontainerinner canvas{ width:30%;}/*Added by pradip on 31-3-2023*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodyBusiness-group">
    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-0 text-right graybg" style="display:table">
            <h5 class="pgtitle pull-left">Business Group</h5>
            <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%> 
            <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-placement="bottom" title="Back to Resource Configuration">Back</a>--%>
            <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <a href="javascript:;" class="mainclearalllink" onclick="closeFilterPanel()" style="" data-bs-toggle="tooltip" data-placement="bottom" title=""><strong>Clear All</strong></a>
			
            <div class="filter inline pull-right" data-toggle="tooltip" data-placement="bottom" title="Filter">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" id="AdvanceFilterIcon" autocomplete="off"><i class="fas fa-filter"></i></button>
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

                                <%--<li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-placement="bottom" id="project2" type="checkbox" name="project2" onchange="" data-bs-original-title="" title="">
                                        <span data-bs-toggle="tooltip" data-placement="right" title="" class="checkmark" data-bs-original-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="project2" class="radiotextsty filtername">Project 2 and 3</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproOne" type="checkbox" name="">
                                            <label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" for="IssueselproOne" data-bs-original-title="Apply filter"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" data-bs-original-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" class="far fa-trash-alt" data-bs-original-title="Delete filter"></i></span>
                                    </div>
                                </li>
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-placement="bottom" id="task" type="checkbox" name="task" onchange="" data-bs-original-title="" title="">
                                        <span data-bs-toggle="tooltip" data-placement="right" title="" class="checkmark" data-bs-original-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="task" class="radiotextsty">Task and milestones</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproTwo" type="checkbox" name="">
                                            <label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" for="IssueselproTwo" data-bs-original-title="Apply filter"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" data-bs-original-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" class="far fa-trash-alt" data-bs-original-title="Delete filter"></i></span>
                                    </div>
                                </li>
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-placement="bottom" id="groupcompany" type="checkbox" name="groupcompany" onchange="" data-bs-original-title="" title="">
                                        <span data-bs-toggle="tooltip" data-placement="right" title="" class="checkmark" data-bs-original-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="groupcompany" class="radiotextsty">For group company</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproThree" type="checkbox" name="">
                                            <label data-container="body" data-bs-toggle="tooltip" data-placement="bottom" title="" for="IssueselproThree" data-bs-original-title="Apply filter"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" data-bs-original-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="" class="far fa-trash-alt" data-bs-original-title="Delete filter"></i></span>
                                    </div>
                                </li>--%>
                            </ul>
                        </li>
                        <li class="" id="tabpresetfilter">
                            <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                        </li>


                    </ul>
                </div>

                <div class="Fwrapper ">
                    <div class="tab-content">
                        <div id="basicfilters" class="tab-pane stackbasicfilter">
                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" onclick="checkFiltervalidationForBG();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFlter()">Apply</button>
                                </div>
                                <br />

                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Business Group Code</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboBGFilterBusinessGroupCode">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">End With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Start With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtBGFilterBusinessGroupCode", "txtBGFilterBusinessGroupCode", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Business Group Name</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboBGFilterBusinessGroup">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">End With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Start With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtBGFilterBusinessGroup", "txtBGFilterBusinessGroup", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>&nbsp;</label>
                                 <%--Commented & Added By Rutuja D. on 7 July 2021--%>
                                       <%-- <div class="row">
                                            <div class="col-xs-12">
                                                <div class="custom_chckbox">
                                                    <%CommonFunctions.HTMLControls.DrawCheckBox("chkBgFilterIsActive", "chkBgFilterIsActive", "custom_chckbox clsCheckBox", False, , , "style='width: 30px;height:15px;'", , , , , , )%>
                                                    <label for="chkBgFilterIsActive">IsActive</label>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                            </div>

                                        </div>--%>
                                        <label>IsActive</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboBGFilterActive">
                                                    <option value="=">=</option>
                                                    <option value="<>"><></option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                 <% CommonFunctions.HTMLControls.DrawComboBox("txtBGFilterActive", "usp_Whizible2_IsComfirmed",,, "class='form-control' ",,,, ,) %>                                               
                                            </div>
                                    <%--End of Commented & Added By Rutuja D.--%>

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

        <div class="content pt-1">
            <table class="table table-bordered GRPtbl" style="width: 100%;" id="BGtblmain">
                <thead>
                    <tr>
                        <th class="text-left" width="200">Business Group Code</th>
                        <th class="text-left">Business Group Name</th>
                        <th class="text-center" width="100">Is Active</th>
                    </tr>
                </thead>
                <tbody id="tblBusinessGroups" class="GRPtbl"></tbody>
            </table>
        </div>


        <div class="Resourcedetailpanel">
            <!--mahesh:Added for fruther process -API call use-->
            <input type="hidden" id="hdnBG_BusinessGroupIDTab" name="hdnBG_BusinessGroupIDTab">
            <input type="hidden" id="hdnBG_BusinessGroupCode" name="hdnBG_BusinessGroupCode">
            <input type="hidden" id="hdnBG_BusinessGroupIsActive" name="hdnBG_BusinessGroupIsActive">
            <input type="hidden" id="hdnBGM_UniqueIDTab" name="hdnBGM_UniqueIDTab">
            <input type="hidden" id="hdnBGM_MangerIDTab" name="hdnBGM_MangerIDTab" value="0">

            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li><a href="#RBGdetails" class="active" data-bs-toggle="tab" id="BgDetailsTab" onclick="ShowBGDetails()">Details</a><div></div>
                    </li>
                    <li class=""><a href="#RBGOU" data-bs-toggle="tab" id="BgOUTab" onclick="ShowBGOrganizationUnit()">Organization Unit</a><div></div>
                    </li>
                    <li class=""><a href="#RBGMangers" data-bs-toggle="tab" id="BgManagerTab" onclick="ShowBGManager()">Business Group Managers</a><div></div>
                    </li>
                    <li class=""><a href="#RBGResources" data-bs-toggle="tab" id="BgResourceTab" onclick="ShowBGResource()">Resources</a><div></div>
                    </li>
                    <li class=""><a href="#RBGGraph" data-bs-toggle="tab" id="" onclick="ShowGraph()">By Role</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">

                    <div id="RBGdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="">Cancel</button>
                        </div>

                        <div class="row">
                            <div class="col-sm-4">
                                <label class="required">Business Group Code</label>
                                <input type="text" class="form-control" value="GRP" id="BgDtl_BgCode" disabled />
                            </div>
                            <div class="col-sm-4">
                                <%--Added by imran on 23-02-2022 for required not display--%>
                                <%--<label>Business Group Name</label>--%>
                                <label class="required">Business Group Name</label>
                                <%--End Comment by imran on 23-02-2022 for required not display--%>
                                <input type="text" class="form-control" value="BG Code" id="BgDtl_BgName" disabled />
                            </div>
                            <div class="col-sm-4">
                                <label class="dblock">&nbsp</label>
                                <strong>Is Active :
                                    <label class="clBgDtl_BgActive  text-bold" id="BgDtl_BgActive"></label>
                                </strong>
                            </div>
                        </div>

                    </div>
                    <div id="RBGOU" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="">Cancel</button>
                        </div>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th class="text-left">Organization Unit</th>
                                    <th width="250">Organization Unit Code</th>
                                </tr>
                            </thead>
                            <tbody id="tblBgOrganizationUnit"></tbody>
                        </table>
                    </div>
                    <div id="RBGMangers" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button type="submit" class="btn borderbtn mr-5" id="btnBGAdd" data-bs-toggle="modal" data-bs-target="#AddBGMModal" onclick="BGEnableManagerlist()"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                            <button class="btn borderbtn mr-5" id="btnBGDelete" onclick="DeleteBGManager()">Delete</button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="">Cancel</button>
                        </div>
                        <table class="table table-bordered" id="RBGMangersMain">
                            <thead>
                                <tr>
                                    <th width="250" class="text-center">Manager</th>
                                    <th width="200" class="text-center">Is Primary Responsible</th>
                                    <th class="text-left">Responsibilities</th>
                                    <th width="50">
                                        <div class="custom_chckbox">
                                            <input id="chkBgManager" class="chckHead" type="checkbox">
                                            <label for="chkBgManager"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tblBgManagers"></tbody>
                        </table>
                    </div>
                    <div id="RBGResources" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="">Cancel</button>
                        </div>
                        <div class="pt-1 pb-1 form-inline">
                            <div class="form-group" style="width: 800px">
                                <label for="email">Role Description : </label>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboBGResource", "Select  RoleID,RoleDescription From tbl_PM_Role Where IsUserGroup=0 Order By RoleDescription ",,, "class='form-control issueselectprojects' onChange='javascript:CboBGResource_OnChange(this.value);'",,,) %>--%>
                                <% CommonFunctions.HTMLControls.DrawComboBox("CboBGResource", "usp_Whizible2_Sel_tbl_PM_Role_Roles",,, "class='form-control issueselectprojects' onChange='javascript:CboBGResource_OnChange(this.value);'",,,) %>
                            </div>
                        </div>
                        
                        <%--<table class="table table-bordered">--%>
                        <div class="table-responsive rsrsouter"><!--Added class by pradip-->
                        <table class="table table-bordered" id="tblResources">
                          
                            <thead>
                                <tr>
                                    <th class="text-center">Employee Name</th>
                                    <th class="text-center">Role Description</th>
                                    <th class="text-center">Location</th>
                                    <th class="text-center">Department</th>
                                    <th class="text-center">Email ID</th>
                                    <th class="text-center">Resume</th>
                                </tr>
                            </thead>
                            <tbody id="tblBGResources">
                                <tr>
                                    <td colspan="6">Please select Role Description</td>
                                </tr>
                            </tbody>
                        </table>
                            </div>
                    </div>
                    <div id="RBGGraph" class="tab-pane">
                        <p class="pull-left">Resources by Role</p>
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="">Cancel</button>
                        </div>
                        <div class="graphcontainer">
                            <div class="graphcontainerinner">
                                <canvas id="RBGChart" width="200" height="200"></canvas>
                            </div>                            
                        </div>
                    </div>

                </div>
            </div>
        </div>


        <div class="clearfix"></div>
    </div>


    <!--add modal start here-->
    <div class="modal custmodal fade" id="AddBGMModal">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Business Group Managers</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="required">Manager</label>
                        <%-- <% CommonFunctions.HTMLControls.DrawComboBox("CboBgManager", "usp_Whizible2_Sel_tbl_PM_Employee_Medium",,, "class='form-control' ", True,,) %>--%>
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboBgManager", "Select 0,'' ",,, "class='form-control'",,, True) %>
                    </div>
                    <div class="form-group">
                        <div class="custom_chckbox">
                            <input id="ChkAddGBPMCheckManager" name="ChkAddGBPMCheckManager" class="clChkAddGBPMCheckManager" type="checkbox" checked="checked">
                            <label for="ChkAddGBPMCheckManager">Is Primary Responsible</label>
                        </div>
                    </div>
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        <button class="btn btnyellow" onclick="SaveBGManager(0)">Save</button>
                        <button class="btn btnyellow" id="btnSaveBGManager" onclick="SaveBGManager(1)">Save And Add</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Add modal end here-->
    <!--resume modal start here-->

    <%-- filter model for save--%>
    <div class="modal custmodal BgSavefilter_filter fade" id="BgSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Save Filter As</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply();">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="BgSavefilterfilterbox" class="box-panel">

                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-right required">Filter Name :</label>
                                        <div class="col-md-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtBGFilterName", "txtBGFilterName", "form-control",, maxLength:=100) %>
                                            <div class="btnrow">
                                                <button class="btn btnyellow pull-left savefilter" id="btnSaveFilter" onclick="SaveBGFilterDetails()">Save</button>
                                                <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right" onclick="cancelsaveapply()">Cancel</button>
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

    <%--Delete confirmation model--%>
    <div class="modal custmodal fade" id="DeleteConfirmBGMModal" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="notebox">
                        <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>
                    <div class="notebox">
                        Are you sure, you want to delete the selected records?
                    </div>

                    <div class="text-right">
                        <button class="btn btnyellow" onclick=" DeleteBgManagerAfterConfirm()">Yes</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal">No</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

     <%--Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021--%>     
    <div id="deleteConfirmAlert" class="modal fade custmodal" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
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
                                    <button class="btn borderbtn pull-left uncheckbtn" data-bs-dismiss="modal">No</button>
                                    <button class="btn btnyellow" data-bs-toggle="modal" data-bs-original-title="" data-bs-dismiss="modal" title="" onclick="confirmDelete()">Yes</button>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>    
     <%--End of Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021--%>
    

  <%--  <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
 <%--   <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>
    <%--<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script type="text/javascript">
        

        //Added By Riddhesh Patil on 10-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil
        var CurrentTabObject = { Details: 'false', OrgUnit: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };
        var noOfRowsPerPage = 10;
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        //Initialize bootstrap tooltips
        //var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"));
        //var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        //    return new bootstrap.Tooltip(tooltipTriggerEl, {
        //        trigger: 'hover'
        //    });
        //});
       
       

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

       // $("body").children().first().before($(".modal"));
        

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").hover(function () {
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip('update');
        }); //added by pradip on 24-3-2023


        function editBG() {
            $(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'fast');
            //used for disable grid
            $(".dataTables_scrollBody, .backbtn, .filter, .paginate_button, .dataTable").addClass("DisableContent").parent().css("cursor", "no-drop");
        }
        $('#tblBusinessGroups').on('click', '.BGdetalilink', function () {

            var $row = $(this).closest("tr");
            $tds = $row.find("td");
            $.each($tds, function (index, obj) {
                var hiddenField = $(this).find("input[type='hidden']").val();
                if (hiddenField != 'undefined' && hiddenField != null) {
                    $("#hdnBG_BusinessGroupIDTab").val(hiddenField);
                }
                if (index == 0) {
                    $('#BgDtl_BgCode').val($(this).text());
                    //$("#hdnBG_BusinessGroupCode").val();
                }
                if (index == 1) {
                    $('#BgDtl_BgName').val($(this).text());
                    //$("#hdnBG_BusinessGroupIsActive").val($(this).text());
                }
                if (index == 2) {
                    $('.clBgDtl_BgActive').html($(this).text());
                    if ($(this).text() == 'No') {
                        $("#btnBGAdd").addClass("clsShowHide");
                    } else {
                        if (blnAddAccess == "True" && $(this).text() == "Yes") {
                            $("#btnBGAdd").removeClass("clsShowHide");
                        }
                    }
                    // $("#hdnBG_BusinessGroupIsActive").val($(this).text());
                }
            });
            $(this).closest('tr').addClass('rowhiglight');
            $('#BgOUTab').click()

        });

        /// $('#tblBgManagers .clBGEditManager').click(function () {
        $('#tblBgManagers').on('click', '.clBGEditManager', function () {

            CurrentTabObject = { Details: 'false', OrgUnit: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };
            var $row = $(this).closest("tr");
            $tds = $row.find("td");
            //  $.each($tds, function (index, obj) {
            var hiddenBGMManagerID = $row.find("#hdnBGM_ManagerId").val();
            FillBGManager(hiddenBGMManagerID);
            $('#hdnBGM_MangerIDTab').val(hiddenBGMManagerID);
            var hiddenBGMUniqueID = $row.find("#hdnBGM_UniqueID").val();
            var isResposible = $row.find('#hdn_BGYesNo').val();
            if (hiddenBGMManagerID != 'undefined' && hiddenBGMManagerID != null) {
                $("#CboBgManager").val(hiddenBGMManagerID);
                // $('#CboBgManager').attr("disabled", true);
                //$('#btnSaveBGManager').attr("disabled", true);
            }
            if (hiddenBGMUniqueID != 'undefined' && hiddenBGMUniqueID != null) {
                $("#hdnBGM_UniqueIDTab").val(hiddenBGMUniqueID);

            }
            ///if (index == 1) {
            ///isCheckOrNOt = $("#hdnBG_BusinessGroupIsActive").val($(this).text());
            /// $("#ChkAddGBPMCheckManager").prop("checked", true);
            if (isResposible == "Yes") {
                $('#ChkAddGBPMCheckManager').prop('checked', true);
            }
            else {
                $("#ChkAddGBPMCheckManager").prop("checked", false);
            }
            ///}
            $("#CboBgManager").val(hiddenBGMManagerID);
            $('#AddBGMModal').modal('show');
        });



        //});

        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $(".dataTables_scrollBody, .backbtn, .filter, .paginate_button, .dataTable").removeClass("DisableContent").parent().css("cursor", "auto");
            CurrentTabObject = { Details: 'false', OrgUnit: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };

        });

        function BGEnableManagerlist() {
            $('#CboBgManager').attr("disabled", false);
            $("#hdnBGM_UniqueIDTab").val(0)
            $('#CboBgManager').val("");
            $('#ChkAddGBPMCheckManager').prop('checked', false);
            $('#btnSaveBGManager').attr("disabled", false);
            FillBGManager(0);

        }

        function LoadPagination(tblId, data) {
            //var businessGroupTable;
            //---tblId  BGtblmain
            $.fn.DataTable.ext.pager.numbers_length = 10;
            $(tblId).dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": '100',
                "scrollResize": true,
                "scrollcollapse": true,
                //Added by imran on 19-08-2022
                pageLength: 10,
                //End of comment by imran on 19-08-2022
                //"scrollY": 'auto',
                // "autoWidth": false,
                // "bSort":true,
                //   "bPaginate": true,
                //"pageLength": 15,
                //"bInfo": false, //hide paging info
                //"pagingType": "full_info",   //full_numbers
                "iDisplayLength": noOfRowsPerPage,
                "lengthChange": false,
                "searching": false,
                "destroy": true,
                //"language": {
                //    "emptyTable": "No data available in table",
                //    "zeroRecords":    "No matching records found",
                //    "paginate": {
                //        //"first": "<<",
                //        //"previous": "<",
                //        //"next": ">",
                //        //"last": ">>",
                //        "info": "_START_ - _END_ of _TOTAL_",
                //        "infoEmpty":"0 - 0 of 0",                    
                //    },
                //    "bInfo": true,
                //    "infoEmpty": "0 - 0 of 0",
                //  },
                //  "dom": '<"pull-right top"p >rt<"clear">',
            });

        }


        //setTimeout(function () {
        //    $.fn.dataTable.tables({ visible: true, api: false }).columns.adjust();
        //}, 0);

        function resizeSection() {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 180, "overflow-y": "auto" });

            //var tblheight = $(window).height();
            //$('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 0);
        });




        //$("#filterpanel").on("show.bs.collapse", function () {
        //    $(".clearalllink").css("display", "inline-block");
        //});
        //$("#filterpanel").on("hide.bs.collapse", function () {
        //    $(".clearalllink").hide();
        //});

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

        function checkUncheck() {

            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
            }
        }


        //Resource by Rolls chart
        var BgChart;
        function PlotRoleGraph(LabelList, ColorList, DataList) {

            var Bgctx = document.getElementById("RBGChart").getContext('2d');
            // if (BgChart) BgChart.destroy();// windowBgChart.reset();  //windowBgChart.clear()// /// windowBgChart.destroy();
            BgChart = new Chart(Bgctx, {
                type: 'pie',
                data: {
                    labels: LabelList,
                    datasets: [{
                        backgroundColor: ColorList,
                        data: DataList
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'left',
                            align: "start",
                        }
                    }, //Added by pradip on 31-3-2023
                    
                }
            });

        }


 <%--   <script type="text/javascript">--%>
        var strUrl = '';
        var NoDataFound = "No data found.";
        var DeleteRecord = "Please select at least one record to delete.";
        var DeleteConfirm = "Are you sure, you want to delete the selected records?";
        strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';

        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var tableRisk = '';
        var tableHistoryRisk = '';
        var tablePlanRisk = '';
        var tableEarlyWarningRisk = '';
        var tableDocumentRisk = '';
        var tableMatrixRisk = '';
        var blnCreateContingencyTask = false;
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var TagID = '<%= m_TagId%>';

        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';

        

        

        $(document).ready(function () {
            //Remove tooltip
            $('.btn, div').tooltip({ trigger: 'hover' });

                   
            //Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
            BindPlaceholder("txtBGFilterActive", "IsActive");
            //End of Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
            
            CurrentTabObject = { Details: 'false', OrgUnit: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };
            if (blnAddAccess == "False") {
                $("#btnBGAdd").addClass("clsShowHide");
                $('#btnSaveBGManager').attr("disabled", true);

            }
            else {
                $("#btnBGAdd").removeClass("clsShowHide");
                //$("#btnSaveBGManager").removeClass("clsShowHide");
                $('#btnSaveBGManager').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#btnBGDelete").addClass("clsShowHide");
            }
            else {
                $("#btnBGDelete").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {
                GetMaximumItemsToShowInList();
                GetMyBGFilter(0);
                if (currentDefaultFilterID > 0) {
                    //GetMyBGFilter(1);
                    ApplySavedFilter(currentDefaultFilterID, 2);

                } else {
                    FilterNotApplied();
                    var GetBGWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                    GetBGDetails(GetBGWitManager);
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";
            }

            //}



        });
        function ShowBGOrganizationUnit() {
            if (CurrentTabObject != null && CurrentTabObject.OrgUnit == "false") {
                var bgOrgID = $("#hdnBG_BusinessGroupIDTab").val();
                GetBusinessGroupsOrgUnit(bgOrgID);
                CurrentTabObject.OrgUnit = 'true';
            }

        }

        function ShowBGManager() {
            if (CurrentTabObject != null && CurrentTabObject.Manager == "false") {
                var bgOrgID = $("#hdnBG_BusinessGroupIDTab").val();
                GetBgManager(bgOrgID);
                CurrentTabObject.Manager = 'true';
            }
        }

        function ShowBGResource() {
            if (CurrentTabObject != null && CurrentTabObject.Resource == "false") {
                $('#CboBGResource').val('0'); //Added by Chetan M on 6 Jun 2021 for Issue Fixing
                var RoleID = $('#CboBGResource').val();
                CboBGResource_OnChange(RoleID);
                CurrentTabObject.Resource = 'true';

            }
        }

        function ShowGraph() {
            if (CurrentTabObject != null && CurrentTabObject.RoleGraph == "false") {
                var bgOrgID = $("#hdnBG_BusinessGroupIDTab").val();

                if (BgChart) BgChart.destroy();
                GetBGResourceRoleGraph(bgOrgID);
                CurrentTabObject.RoleGraph = 'true';
            }
        }

        function ShowBGDetails() {

        }

        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtBGFilterName').val("");
            }
        }

        function GetBusinessGroups(BgFilterParms) {
            //Added by imran on 19-08-2022
            if (BgFilterParms == null || BgFilterParms == "null" || BgFilterParms == "") {
                var BgFilterParms =
                {
                    BGWhereClause: ""
                }
            }
            //End of comment by imran on 19-08-2022

            var strHTML = "";
            StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_BusinessGroup/GetBusinessGroups',
                type: "POST",
                data: JSON.stringify(BgFilterParms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (BgFilterParms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(BgFilterParms) ? BgFilterParms : JSON.stringify(BgFilterParms)));
                    }
                },
                success: function (data) {
                    var BusinessGroups = data;
                    $.each(BusinessGroups, function (index, obj) {
                        var strActive = '';
                        if (obj.Active === true) {
                            strActive = 'Yes'
                        } else {
                            strActive = 'No'
                        }
                        strHTML += '<tr><td class="text-left"><input type="hidden" name="hdnBG_BusinessGroupId" id="hdnBG_BusinessGroupId" value= ' + obj.BusinessGroupID + '> ' + obj.BusinessGroupCode + ' </td> <td class="text-left"><a href="javascript:;" class="BGdetalilink" onclick="editBG(this)"</a>' + obj.BusinessGroup + ' </td> <td class="text-center">' + strActive + '</td> </tr>';
                        ///$(".clsBusinessGroups").append(row);
                    });
                    $('#BGtblmain').dataTable().fnDestroy();
                    $("#tblBusinessGroups").html(strHTML);
                    LoadPagination('#BGtblmain', data);
                    StopAjaxLoader("#bodyBusiness-group");
                    ///loadDataTable();

                },
                //  Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue    
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyBusiness-group");
                //}

                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyBusiness-group");
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue    
            })

        }


        function GetBusinessGroupsOrgUnit(BusinessGroupID) {
            CurrentTabObject.OrgUnit = 'true';
            var strHTML = "";
            var BGOuParsms = { BusinessGroupID: BusinessGroupID };
            StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_BusinessGroup/GetBGOrganizationUnit',
                type: "POST",
                data: JSON.stringify(BGOuParsms),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (BGOuParsms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(BGOuParsms) ? BGOuParsms : JSON.stringify(BGOuParsms)));
                    }
                },
                success: function (data) {
                    var MyBGOrganizationUnit = data;
                    if (MyBGOrganizationUnit.length > 0) {
                        $.each(MyBGOrganizationUnit, function (index, obj) {
                            strHTML += '<tr><td class="text-left">' + obj.Location + ' </td><td class="text-center">' + obj.LocationCode + '</td> </tr>';
                        });
                    } else {
                        strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    }
                    $("#tblBgOrganizationUnit").html(strHTML);
                    StopAjaxLoader("#bodyBusiness-group");
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue    

                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify(xhr.responseJSON.Message);                        
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue    
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(thrownError);
                    }
                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    StopAjaxLoader("#bodyBusiness-group");
                }
            })
        }

        function GetBgManager(BusinessGroupID) {
            $("#hdnBGM_UniqueIDTab").val(0);
            $("#hdnBGM_UniqueID").value = 0;
            /// $("#hdnBGM_UniqueID").val('');
            $("#hdnBGM_UniqueIDTab").value = 0;
            ///var hiddenBGMUniqueID = $(this).find("#hdnBGM_UniqueID").val();
            var BGManagerParsms = { BusinessGroupID: BusinessGroupID };
            var strHTML = "";
            StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_BusinessGroup/GetBGManagers',
                type: "POST",
                data: JSON.stringify(BGManagerParsms),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (BGManagerParsms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(BGManagerParsms) ? BGManagerParsms : JSON.stringify(BGManagerParsms)));
                    }
                },
                success: function (data) {
                    var BGManagers = data;
                    if (BGManagers.length > 0) {
                        $.each(BGManagers, function (index, obj) {
                            var strIsPrimaryResponsible = '';
                            if (obj.IsPrimaryResponsible === true) {
                                strIsPrimaryResponsible = 'Yes'
                            } else {
                                strIsPrimaryResponsible = 'No'
                            }
                            if (blnEditAccess == "True") {
                                strHTML += '<tr><td class="text-center"><a href="javascript:;"  class="clBGEditManager"</a> <input type="hidden" name="hdnBGM_ManagerId" id="hdnBGM_ManagerId" value= ' + obj.ManagerID + '><input type="hidden" name="hdnBGM_UniqueID" id="hdnBGM_UniqueID" value= ' + obj.UniqueID + '>' + obj.Manager + ' </td> <td class="text-center"> <input type="hidden" name="hdn_BGYesNo" id="hdn_BGYesNo" value= ' + strIsPrimaryResponsible + '>' + strIsPrimaryResponsible + ' </td> <td class="text-left">' + obj.Responsibilities + '</td> <td><input onclick="checkUncheck()" class="chcktbl chkBGManager custom_chckbox" type="checkbox" style="width:18px; height:18px"></td ></tr>';
                            } else {
                                strHTML += '<tr><td class="text-center"><input type="hidden" name="hdnBGM_ManagerId" id="hdnBGM_ManagerId" value= ' + obj.ManagerID + '><input type="hidden" name="hdnBGM_UniqueID" id="hdnBGM_UniqueID" value= ' + obj.UniqueID + '>' + obj.Manager + ' </td> <td class="text-center"> <input type="hidden" name="hdn_BGYesNo" id="hdn_BGYesNo" value= ' + strIsPrimaryResponsible + '>' + strIsPrimaryResponsible + ' </td> <td class="text-left">' + obj.Responsibilities + '</td> <td><input onclick="checkUncheck()" class="chcktbl chkBGManager custom_chckbox" type="checkbox" style="width:18px; height:18px"></td ></tr>';
                            }

                        });

                    }
                    else {
                        strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    }

                    $("#tblBgManagers").html(strHTML);
                    ///LoadPagination('#RBGMangersMain',BGManagers);
                    StopAjaxLoader("#bodyBusiness-group");

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    }
                    StopAjaxLoader("#bodyBusiness-group");
                }
            })
        }

        function SaveBGManager(isFromSaveAndclick) {
            var managerID = $("#hdnBGM_MangerIDTab").val();
            var newManagerID = $("#CboBgManager").val();
            if (newManagerID > 0) {
                var uniqueID = $("#hdnBGM_UniqueIDTab").val();
                //var hiddenBGMUniqueID = $(this).find("#hdnBGM_UniqueID").val();

                var isPrimaryResponsible = $("#ChkAddGBPMCheckManager").is(":checked");


                if (isPrimaryResponsible == false) {
                    isPrimaryResponsible=0
                }
                //var isChecked = $("#ChkAddGBPMCheckManager").is(":checked");
                var bgOrgID = $("#hdnBG_BusinessGroupIDTab").val();
                var bgManagerParmas = {
                    UniqueID: uniqueID > 0 ? uniqueID : 0,
                    BusinessGroupID: bgOrgID,
                    ManagerID: uniqueID > 0 ? managerID : newManagerID,
                    NewManagerID: newManagerID,
                    IsPrimaryResponsible: isPrimaryResponsible
                }
                $.ajax({
                    url: strUrl + '/api/RM_BusinessGroup/SaveBGManager',
                    type: "POST",
                    data: JSON.stringify(bgManagerParmas),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (bgManagerParmas) {
                            xhr.setRequestHeader("Params", encryptString(isJson(bgManagerParmas) ? bgManagerParmas : JSON.stringify(bgManagerParmas)));
                        }
                    },
                    success: function (data) {
                        CurrentTabObject.Manager = 'false';
                        ShowBGManager();
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.success(data);
                        CurrentTabObject.Manager = 'true';
                        if (isFromSaveAndclick == 0) {
                            if (data == "Manager already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                // $('#CboBgManager').val("");
                                $('#AddBGMModal').modal('show');
                            } else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                $('#AddBGMModal').modal('hide');
                                $('.modal').removeClass("show");
                                $('.modal').hide();
                                $('.modal-backdrop').hide();
                                $('body').removeClass("modal-open");
                                $('body').removeAttr("data-bs-overflow");
                                $('body').css({ 'overflow': 'auto', 'padding-right': '0px' });
                                $('.modal-backdrop').removeClass('show');
                                $('.BgSavefilter_filter').removeClass('show').css('display', 'none');


                            }

                        }
                        else {
                            if (data == "Manager already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);

                            }
                            else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                $('#CboBgManager').val("");
                                $('#ChkAddGBPMCheckManager').prop('checked', false);
                            }

                            //if (isFromSaveAndclick == 1) {
                            //    $('#CboBgManager').val("");
                            //     $('#ChkAddGBPMCheckManager').prop('checked', false);
                            //}
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue     
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.notify(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue     
                        }
                        else if (xhr.statusText == "Created") {
                            // alertify.set('notifier', 'position', 'top-right');
                            //alertify.notify(xhr.statusText + "/ updated");
                            CurrentTabObject.Manager = 'false';
                            ShowBGManager();
                            CurrentTabObject.Manager = 'true';
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        StopAjaxLoader("#bodyBusiness-group");
                        if (isFromSaveAndclick == 0) {
                            $('#AddBGMModal').modal('hide');
                        }
                    }

                })

            } else {
                //$('#AddBGMModal').modal('show');
                $("#CboBgManager").focus();
                alertify.set('notifier', 'position', 'top-right');
                //alertify.warning("Please Select Manager");
                alertify.error("Please Select Manager");
            }
        }


        //resources(get resources using role ID)

        function GetBusinessGroupsResources(BGID, RoleID) {

            CurrentTabObject.Resource = 'true';
            var strHTML = "";
            var BGRsourceParams = { BusinessGroupID: BGID, RoleID: RoleID };
            $.ajax({
                url: strUrl + '/api/RM_BusinessGroup/GetBGResources',
                type: "POST",
                data: JSON.stringify(BGRsourceParams),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    StartLoader("#bodyBusiness-group");
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (BGRsourceParams) {
                        xhr.setRequestHeader("Params", encryptString(isJson(BGRsourceParams) ? BGRsourceParams : JSON.stringify(BGRsourceParams)));
                    }
                },
                success: function (data) {

                    var BusinessGroupsResources = data;
                    if (BusinessGroupsResources.length > 0) {
                        $.each(BusinessGroupsResources, function (index, obj) {
                            strHTML += '<tr><td class="text-center"><input type="hidden" name="hdnBGR_EmpID" id="hdnBGR_EmpID" value= ' + obj.EmployeeID + '> <input type="hidden" name="hdnBGR_OUPoolID" id="hdnBGR_OUPoolID" value= ' + obj.OUPoolID + '> ' + obj.EmployeeName + ' </td> <td class="text-center">' + obj.RoleDescription + '</td><td class="text-center">' + obj.Location + '</td> <td class="text-center">' + obj.Department + '</td> <td class="text-center">' + obj.EmailID + '</td> <td class="text-center"> <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResumeModal" onclick="GetResourceResume(' + obj.EmployeeID + ')"</a>' + 'Resume' + ' </td></tr>';
                        });
                    } else {
                        strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    }

                    $("#tblBGResources").html(strHTML);

                    StopAjaxLoader("#bodyBusiness-group");
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    console.log(err);
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyBusiness-group");
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })
        }



        ///Resourses call
        function CboBGResource_OnChange(RoleID) {
            
            var bgID = $("#hdnBG_BusinessGroupIDTab").val();
            if (RoleID.length > 0) {
                GetBusinessGroupsResources(bgID, RoleID)
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Please select Role Description");
            }

        }


        function DeleteBGManager() {
            
            var isSelectedResource = GetSelectedBGResources()
            if (isSelectedResource.length > 0) {
                $('#DeleteConfirmBGMModal').modal('show');

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }
        function DeleteBgManagerAfterConfirm() {
            

            var isSelectedResource = GetSelectedBGResources();
            $.ajax({
                url: strUrl + '/api/RM_BusinessGroup/DeleteBGManager',
                type: "POST",
                data: JSON.stringify(isSelectedResource),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    StartLoader("#bodyBusiness-group");
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (isSelectedResource) {
                        xhr.setRequestHeader("Params", encryptString(isJson(isSelectedResource) ? isSelectedResource : JSON.stringify(isSelectedResource)));
                    }
                },
                success: function (data) {
                    if (data != "") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(data);
                    }

                    StopAjaxLoader("#bodyBusiness-group");
                    CurrentTabObject.Manager = 'false';
                    ShowBGManager();
                    CurrentTabObject.Manager = 'true';
                    $('#DeleteConfirmBGMModal').modal('hide');
                    $('.modal').removeClass("show");
                    $('.modal').hide();
                    $('.modal-backdrop').hide();
                    $('body').removeClass("modal-open");
                    $('body').removeAttr("data-bs-overflow");
                    $('body').css({ 'overflow': 'auto', 'padding-right': '0px' });
                    $('.modal-backdrop').removeClass('show');
                    $('.BgSavefilter_filter').removeClass('show').css('display', 'none');
                    //Added By Reshma chavan on 26th Nov 2021 For IssueID-31626
                        $(".chckHead").prop("checked", false);
                    //End of Added By Reshma chavan on 26th Nov 2021 For IssueID-31626
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue           
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue           
                    }
                    else if (xhr.statusText == "OK") {  //200
                        CurrentTabObject.Manager = 'false';
                        ShowBGManager();
                        CurrentTabObject.Manager = 'true';
                        $('#DeleteConfirmBGMModal').modal('hide');
                        $('.modal').removeClass("show");
                        $('.modal').hide();
                        $('.modal-backdrop').hide();
                        $('body').removeClass("modal-open");
                        $('body').removeAttr("data-bs-overflow");
                        $('body').css({ 'overflow': 'auto', 'padding-right': '0px' });
                        $('.modal-backdrop').removeClass('show');
                        $('.BgSavefilter_filter').removeClass('show').css('display', 'none');
                        //alertify.set('notifier', 'position', 'top-right');
                        // alertify.notify("Deleted");
                    }
                    //else {
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.notify(thrownError);
                    //    StopAjaxLoader("#bodyBusiness-group");
                    //}

                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    StopAjaxLoader("#bodyBusiness-group");
                    $('#DeleteConfirmBGMModal').modal('hide');
                    $('.modal').removeClass("show");
                    $('.modal').hide();
                    $('.modal-backdrop').hide();
                    $('body').removeClass("modal-open");
                    $('body').removeAttr("data-bs-overflow");
                    $('body').css({ 'overflow': 'auto', 'padding-right': '0px' });
                    $('.modal-backdrop').removeClass('show');
                    $('.BgSavefilter_filter').removeClass('show').css('display', 'none');
                    
                }
            })
        }
        if (CurrentTabObject.RoleGraph == 'false') {

            function GetBGResourceRoleGraph(BGroupID) {
                CurrentTabObject.RoleGraph = 'true';
                var strHTML = "";
                StartLoader("#bodyBusiness-group");
                var BGRGRaphParams = { BusinessGroupID: BGroupID, RoleID: "" };
                $.ajax({
                    url: strUrl + '/api/RM_BusinessGroup/GetBGResourceRoleGraph',
                    type: "POST",
                    data: JSON.stringify(BGRGRaphParams),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (BGRGRaphParams) {
                            xhr.setRequestHeader("Params", encryptString(isJson(BGRGRaphParams) ? BGRGRaphParams : JSON.stringify(BGRGRaphParams)));
                        }
                    },
                    success: function (data) {
                        var BGResourcesGraph = data;
                        if (BGResourcesGraph.length > 0 && BGResourcesGraph[0]['LstData'].length > 0) {
                            StopAjaxLoader("#bodyBusiness-group");
                            PlotRoleGraph(BGResourcesGraph[0]['LstLabel'], BGResourcesGraph[0]['LstColor'], BGResourcesGraph[0]['LstData'])

                        } else {
                            PlotRoleGraph(0, 0, 0);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("There is no details available.");
                            StopAjaxLoader("#bodyBusiness-group");
                        }
                    },
                    //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    StopAjaxLoader("#bodyBusiness-group");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        StopAjaxLoader("#bodyBusiness-group");

                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

                });
            }
        }


        ///get checked values
        function GetSelectedBGResources() {
            var selectedBGUniqueId = '';
            $('#tblBgManagers').find('tr').each(function () {
                var row = $(this);
                if (row.find('input[type="checkbox"]').is(':checked')) {
                    selectedBGUniqueId += row.find('#hdnBGM_UniqueID').val() + ',';
                }
            });
            if (selectedBGUniqueId.length > 0) {
                selectedBGUniqueId = selectedBGUniqueId.substring(0, selectedBGUniqueId.length - 1);
            }
            return selectedBGUniqueId;
        }


        //Used from Organization UNIT
        function GetResourceResume(EmployeeID) {
            window.open('../Resources/Resume.aspx?EmployeeID=' + EmployeeID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100, width=800, height=600');
        }


        ///form BG pool
        function GetMaximumItemsToShowInList() {
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
                        //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(thrownError);
                    }

                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    StopAjaxLoader("#bodyGlobal-Resource");
                }
            })

        }

        //Fil bg manager on add and edit (with level changed mang)
        function FillBGManager(EmpID) {
            var strHTML = "";
            var objManagerID = { ManagerID: EmpID }
            $.ajax({
                url: strUrl + '/api/RM_BusinessGroup/GetToFillBGManagers',
                type: "POST",
                data: JSON.stringify(objManagerID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objManagerID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objManagerID) ? objManagerID : JSON.stringify(objManagerID)));
                    }
                },
                success: function (data) {
                    //$("#cboOPRFilterLocationID").empty();

                    //Comment And Added by imran on 23-02-2022 For placeholder display blank
                    //strHTML += "<option value='0'></option>";
                    strHTML += "<option value='0'> Select Manager</option>";
                    $.each(data, function (index, obj) {
                        strHTML += ('<option value=' + obj.EmployeeID + ' >' + obj.UserName + '</option>');
                    })
                    //End by imran on 23-02-2022 For placeholder display blank

                    //for (var i = 0; i < data.length; i++) {
                    //    var listComponent = data[i];
                    //    strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    //}

                    $("#CboBgManager").html(strHTML);
                    $("#CboBgManager").val(EmpID);

                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue  
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue  
            })
        }

        ///Start Filter coding

        //var filterWhereClause = "";



        function ApplyFlter() {
            currentFilterID = 0;
            //if ($('#txtBGFilterBusinessGroupCode').val() == "" && $('#txtBGFilterBusinessGroup').val() == "") {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Enter at least one filter value');
            //} else {
            var filter = "";
            //if (filterwhereclause != 'undefined' && filterwhereclause != null) {
                <%--Commented & Added By Rutuja D.--%>
            //var AllBgFilter = ["BusinessGroupCode", "BusinessGroup"];
           // var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
            var AllBgFilter = ["BusinessGroupCode", "BusinessGroup", "Active"];
                <%--End of Commented & Added By Rutuja D.--%>
            var filterWhereClause2 = GenerateBGBasicFilterQuery("BG", AllBgFilter);
            <%--Commented & Added By Rutuja D.--%>
            if (filterWhereClause2 == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
            } else {
             <%--End of Commented & Added By Rutuja D.--%>
                if (filterWhereClause2 != '' && filterWhereClause2 != null && filterWhereClause2 != 'undefined') {
                    // filterWhereClause2 += "AND Active=" + ' "' + isActiveFilter + '"';
                    filterWhereClause2 += "AND ManagerID=" + ' "' + SessionEmployeeId + '"';
                }
                else {
                    // filterWhereClause2 += "Active=" + ' "' + isActiveFilter + '"';
                    filterWhereClause2 += "AND ManagerID=" + ' "' + SessionEmployeeId + '"';
                }
               // var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
                filterWhereClause = filterWhereClause2.replace(/"/g, "\'");

                //Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                //filter = { UniqueID: '0', IsActive: 'false', BGWhereClause: encodeURI(filterWhereClause) }
                filter = { UniqueID: '0', IsActive: 'false', BGWhereClause: encodeURIComponent(filterWhereClause) }
                //End of Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                FilterApplied();
                //}

                //SaveBGFilterDetails();
                GetBusinessGroups(filter);
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");

                //Added by pradip on 23-3-2023
                $('.modal-backdrop').hide();
                $('.modal-backdrop').removeClass('show');
                $('.BgSavefilter_filter').removeClass('show').css('display','none');
                //End Added by pradip on 23-2023
                
                
                $('#BgSavefilter').modal('hide');

                // }
            }
        }


        function GetBGDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                // var whereClauseFormated = whereClause.replace(/'/g, "\''");
                //Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                //filter = { UniqueID: '0', IsActive: 'true', BGWhereClause: encodeURI(whereClause) };
                filter = { UniqueID: '0', IsActive: 'true', BGWhereClause: encodeURIComponent(whereClause) };
                //End of Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
            }
            GetBusinessGroups(filter);
            GetMyBGFilter(0);

        }
        function checkFiltervalidationForBG() {
            var bgCode = $("#txtBGFilterBusinessGroupCode ").val() == "" ? null : $("#txtBGFilterBusinessGroupCode ").val();
            var bgRole = $("#txtBGFilterBusinessGroup ").val() == "" ? null : $("#txtBGFilterBusinessGroup ").val();
            <%--Commented & Added By Rutuja D.--%>
            //var isActive = $('#chkBgFilterIsActive').is(":checked");
            var isActive = $("#txtBGFilterActive ").val() == "" ? null : $("#txtBGFilterActive ").val();
            <%--End of Commented & Added By Rutuja D.--%>
            //alert("AA" +isActive);
            //console.log("roleId :", bgCode);
            <%--Commented & Added By Rutuja D.--%>
           // if ((bgCode == null || bgCode == 'undefined') && (bgRole == null || bgRole == 'undefined') && (isActive == false)) {
            if ((bgCode == null || bgCode == 'undefined') && (bgRole == null || bgRole == 'undefined') && (isActive == null || isActive == 'undefined')) {
            <%--End of Commented & Added By Rutuja D.--%>
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
                $('#BgSavefilter').modal('hide');
            }
            else {
                $('#BgSavefilter').modal('show');
            }
        }

        //Added By Riddhesh Patil on 12-NOV-2022 
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

        var savedFilterName = "";
        function SaveBGFilterDetails() {
            var fltFilterName = $("#txtBGFilterName").val();
            //$('#BgSavefilter').modal('show');
            // $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            if (fltFilterName == "") {
                //$('#BgSavefilter').modal('show');
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                //Comment And Added by imran on 23-02-2022 Error backgound color not display
                //alertify.notify('Please enter filtername');
                alertify.error('Please Enter Filter Name');
                //End by imran on 23-02-2022 Error backgound color not display
                //$('#BgSavefilter').modal('show')
                $("#txtBGFilterName").focus();

                //return false
            }
            //Added By Riddhesh Patil on 12-NOV-2022 
            else if (checkSpecialCharacter(fltFilterName.trim(), WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtGRPFilterName").focus();

            }
			//End of Comment Added By Riddhesh Patil
            else {
                var filterExists = 0;
                //if (savedFilterName == "") {
                //    filterExists = ExistBGFilter(fltFilterName);
                //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                //    $('#BgSavefilter').modal('show');
                //}

                //if (filterExists == 0) {
                //    $("#btnSaveFilter").attr("data-bs-dismiss", "modal");
                <%--Commented & Added By Rutuja D. on 7 July 2021--%>
                // var AllBgFilter = ["BusinessGroupCode", "BusinessGroup"];
                var AllBgFilter = ["BusinessGroupCode", "BusinessGroup", "Active"];
                <%--End of Commented & Added By Rutuja D. on 7 July 2021--%>
                // var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GenerateBGBasicFilterQuery("BG", AllBgFilter);

                //var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
                if (filterWhereClause2 != "" && filterWhereClause2 != null && filterWhereClause2 != 'undefined') {
                    //filterWhereClause2 += "AND Active=" + ' "' + isActiveFilter + '"';
                    filterWhereClause2 += "AND ManagerID=" + ' "' + SessionEmployeeId + '"';
                } else {
                    // filterWhereClause2 += "Active=" + ' "' + isActiveFilter + '"';
                    filterWhereClause2 += "AND ManagerID=" + ' "' + SessionEmployeeId + '"';
                }
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
                            $('#BgSavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            GetMyBGFilter(0);
                            ApplyFlter();
                            FilterApplied();

                            savedFilterName = fltFilterName;
                            $("#txtBGFilterName").val('');
                            //clearTooltip();
                            // ClearFilterDetails("");
                        }


                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue  
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
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue  
                });
                // }
            }
        }

        function GetMyBGFilter(flag) {
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

                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='radio' name='project2' onclick='SetDefaultFilter(this.id,&quot;default&quot;)' checked='checked'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-placement='right' title='Remove Default filter' class='checkmark'></span>";
                                strHTML += "</label>";

                            }
                            else {
                                strHTML += "<label class='customradio'>";
                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='radio' name='project2' onclick='SetDefaultFilter(this.id,&quot;&quot;)'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-placement='right' title='Set Default filter' class='checkmark'></span>";
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
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                    }
                                    else {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                    }
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }

                                strHTML += "</div>";
                            }
                            else {
                                strHTML += "<div class='custom_chckbox_markblue'>";
                                if (blnApply == true) {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }
                            }

                            strHTML += "<span onclick='OpenBasicFilter()' class='edit_filter'>";

                            strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Edit filter' id='" + ObjMyFilter.FilterId + "' class='fas fa-pencil-alt' onclick='EditFilter(this.id);'></i>";

                            strHTML += "</span>";

                            strHTML += "<span>";
                            if (blnApply == true) {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id,3);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3)></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021
                            }
                            else {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;)></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021
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
                //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue  
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
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue  
            });
            clearTooltip();
        }


        function ExistBGFilter(filtername) {

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
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue  
            });
            return isFilterExists;
        }

        //Delete filter
            //Commented & Added By Rutuja D. For Filter Issue on 7 July 2021
       // function DeleteFilter(FilterID, IsApplyed) {
        function DeleteFilter(FilterID, FilterName, IsApplyed) {
            //End of Commented & Added By Rutuja D. For Filter Issue on 7 July 2021
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
                        //Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on 7 July 2021
                        //  alertify.success('Filter deleted successfully');
                        if (FilterName.indexOf("'") > -1) {
                            FilterName = FilterName.replace(/''/g, "'");
                        }
                        alertify.success("'" + FilterName + "'" + ' Filter deleted successfully');
                        //End of Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on 7 July 2021                        

                        if (IsApplyed == 3) {
                            var GetBGWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                            GetBGDetails(GetBGWitManager);
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyBGFilter(0);
                        currentappliedfilter = 0;
                    }
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue           
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue           
            });
        }

        function EditFilter(FilterID) {
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
                        $("#txtBGFilterName").val(currentFilterName);
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
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue           
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue           
            });
        }

        //Apply saved filter   
        function ApplySavedFilter(FilterID, isDefault,isFromDefault) {
            //Changed  by mahesh on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {
                var GetBGWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                GetBGDetails(GetBGWitManager);
                GetMyBGFilter(isDefault);
                FilterNotApplied();
                ClearFilterDetails(""); // Added By Reshma Chavan on 31st Jan 2022 for clearing filter
                $('#AdvanceFilterIcon').attr("aria-expanded", false);
                //added by mahesh on 21 july 2021
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

                        var Querytext = result;
                        if (Querytext != null) {
                            currentappliedfilterclause = Querytext;
                            GetBGDetails(Querytext);
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
                            GetMyBGFilter(0);
                        }
                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

                });
                if (isDefault == undefined) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Filter applied successfully.");
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
                        ApplySavedFilter(FilterID, 2, true); //changed by mahesh on 21 july 2021
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        //alertify.success('Default');
                        //FilterNotApplied();
                        ApplySavedFilter(FilterID, 3, true);//changed by mahesh on 21 july 2021
                        alertify.success('Default Filter Is Successfully Removed!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        currentappliedfilter = 0;
                        FilterNotApplied();
                    }
                    GetMyBGFilter(0);
                },
                //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            });
        }

        function GenerateBGBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    //cboBGFilterBgCode
                    //cboBGFilterBgName
                    //var name = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    // var strOp = $('#cbo' + module + 'Filter' + filterField[i] + ' option:selected').val();
                    //alert($("#txt" + module + "Filter" + filterField[i]));
                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();
                    // strvalue = $("#txtBGFilterBgGroupName").val();
                     //Added By Chetan M on 28 July 2021 For IssueID = 29339
                    strvalue = strvalue.replace(/"/g, '""');
                    //End of Added By Chetan M on 28 July 2021 For IssueID = 29339
                    <%--Commented & Added By Rutuja D.--%>
                    // if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                    if (strvalue != "" && strvalue != undefined) {
                        <%--End of Commented & Added By Rutuja D.--%>

                        if (strqtext != "") strqtext += " AND ";
                        if (strOp == "Contains") {

                            strqtext += filterField[i] + " LIKE ";
                            //strqtext += " ''%" + strvalue + "%''";
                            //Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                // strqtext += ' "%`' + strvalue + 
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "%' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "%' + strvalue + '%"';
                            }
                            //End of Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Ends With") {
                            strqtext += filterField[i] + " LIKE ";
                            // strqtext += " ''%" + strvalue + "''";
                            //Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                //strqtext += ' "%`' + strvalue + '"';
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
                                strqtext += strOp + " ''" + strvalue + "''";
                            }
                            else {
                                //strqtext += strOp + " " + strvalue + "";
                                strqtext += strOp + ' "' + strvalue + '"';
                            }
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
            if (arrFields[0] == "BusinessGroupCode") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboBGFilterBusinessGroupCode", "txtBGFilterBusinessGroupCode");
            }
            if (arrFields[0] == "BusinessGroup") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboBGFilterBusinessGroup", "txtBGFilterBusinessGroup");
            }
            //Added By Rutuja D. on 7 July 2021
            if (arrFields[0] == "Active") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboBGFilterActive", "txtBGFilterActive");
                if (arrFields[1] == "=") {
                    setFilterComboValue("cboBGFilterActive", "=");
                }
                if (arrFields[1] == "<>") {
                    setFilterComboValue("cboBGFilterActive", "<>");
                }
            }
            //End of Added By Rutuja D. on 7 July 2021
            if (arrFields[0] == "Active=") {
                //if (arrFields[1] == "'true'" && currWhereClause.indexOf("'") != -1 && currWhereClause.indexOf("'") != -1)
                if (arrFields[1] == "'true'") {
                    $('#chkBgFilterIsActive').prop('checked', true);

                } else {
                    $('#chkBgFilterIsActive').prop('checked', false);
                }
                //if (arrFields[1].toString() === 'true') {
                //    alert();
                //    $('#chkBgFilterIsActive').prop('checked', true);

                //} else {
                //    $('#chkBgFilterIsActive').prop('checked', false);
                //}
                //setFilterOpComboFieldValue(currWhereClause, arrFields, "cboBGFilterBusinessGroup", "txtBGFilterBusinessGroup");
            }

            //if (arrFields[0] == "RiskCategoryID") {
            //    var currOpRiskCategory = arrFields[1].toString().trim();
            //    var currValue = arrFields[2].toString().trim();

            //    setFilterComboValue("cboPMFilterRiskCategoryID", currOpRiskCategory);
            //    setFilterComboValue("txtPMFilterRiskCategoryID", currValue);
            //}
            //if (arrFields[0] == "RiskSourceId") {
            //    var currOpRiskSource = arrFields[1].toString().trim();
            //    var currValue = arrFields[2].toString().trim();
            //    if (currValue.substring(currValue.length - 1) == "'") {
            //        currValue = currValue.substring(0, currValue.length - 1);
            //    }

            //    if (currValue.substring(0, 1) == "'") {
            //        currValue = currValue.substring(1);
            //    }

            //    setFilterComboValue("cboPMFilterRiskSourceId", currOpRiskSource);
            //    setFilterComboValue("txtPMFilterRiskSourceId", currValue);
            //}

            //if (arrFields[0] == "Status") {
            //    var currOpRiskStatus = arrFields[1].toString().trim();
            //    var currValue = arrFields[2].toString().trim();
            //    if (currValue.substring(currValue.length - 1) == "'") {
            //        currValue = currValue.substring(0, currValue.length - 1);
            //    }

            //    if (currValue.substring(0, 1) == "'") {
            //        currValue = currValue.substring(1);
            //    }

            //    setFilterComboValue("cboPMFilterStatus", currOpRiskStatus);

            //    $("#txtPMFilterStatus > option").each(function () {

            //        if (this.text == currValue) {
            //            setFilterComboValue("txtPMFilterStatus", this.value);
            //        }
            //    });
            //}
            //if (arrFields[0] == "PersonResponsible") {
            //    var currOpPersonResponsible = arrFields[1].toString().trim();
            //    var currValue = arrFields[2].toString().trim();
            //    if (currValue.substring(currValue.length - 1) == "'") {
            //        currValue = currValue.substring(0, currValue.length - 1);
            //    }

            //    if (currValue.substring(0, 1) == "'") {
            //        currValue = currValue.substring(1);
            //    }

            //    setFilterComboValue("cboPMFilterPersonResponsible", currOpPersonResponsible);

            //    //$("#txtPMFilterPersonResponsible > option").each(function () {

            //    //    if (this.text == currValue) {
            //    //        //alert(this.text + ' ' + this.value);
            //    //        setFilterComboValue("txtPMFilterPersonResponsible", this.value);
            //    //    }
            //    //});
            //}

            //if (arrFields[0] == "DateIdentified") {
            //    var currOpDateIdentified = arrFields[1].toString().trim();
            //    var currValue = arrFields[2].toString().trim();
            //    if (currValue.substring(currValue.length - 1) == "'") {
            //        currValue = currValue.substring(0, currValue.length - 1);
            //    }

            //    if (currValue.substring(0, 1) == "'") {
            //        currValue = currValue.substring(1);
            //    }

            //    setFilterComboValue("cboPMFilterDateIdentified", currOpDateIdentified);

            //    $('#txtPMFilterDateIdentifiedDisp').datepicker("setDate", new Date(currValue));
            //    $('#txtPMFilterDateIdentified').datepicker("setDate", new Date(currValue));

            //}

            //try {
            //    if (arrFields[0] == "Probability") {
            //        setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPMFilterProbability", "txtPMFilterProbability");
            //    }
            //    if (arrFields[0] == "Weight") {
            //        setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPMFilterWeight", "txtPMFilterWeight");
            //    }
            //    if (arrFields[0] == "Severity") {
            //        setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPMFilterSeverity", "txtPMFilterSeverity");
            //    }
            //    if (arrFields[0] == "OriginalPriority") {
            //        var currOpOriginalPriority = arrFields[1].toString().trim();
            //        var currValue = arrFields[2].toString().trim();
            //        if (currValue.substring(currValue.length - 1) == "'") {
            //            currValue = currValue.substring(0, currValue.length - 1);
            //        }
            //        if (currValue.substring(0, 1) == "'") {
            //            currValue = currValue.substring(1);
            //        }
            //        setFilterComboValue("cboPMFilterOriginalPriority", currOpOriginalPriority);
            //        setFilterComboValue("txtPMFilterOriginalPriority", currValue);
            //    }
            //    if (arrFields[0] == "ChangePriority") {
            //        var currOpChangePriority = arrFields[1].toString().trim();
            //        var currValue = arrFields[2].toString().trim();
            //        if (currValue.substring(currValue.length - 1) == "'") {
            //            currValue = currValue.substring(0, currValue.length - 1);
            //        }
            //        if (currValue.substring(0, 1) == "'") {
            //            currValue = currValue.substring(1);
            //        }
            //        setFilterComboValue("cboPMFilterChangePriority", currOpChangePriority);
            //        setFilterComboValue("txtPMFilterChangePriority", currValue);
            //    }
            //}
            //catch (ex) {
            //    //alert(ex.message);
            //}
            //if (arrFields[0] == "Notes") {
            //    setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPMFilterNotes", "txtPMFilterNotes");
            //}
            //if (arrFields[0] == "ProjectRiskID") {
            //    var currOpProjectRiskID = arrFields[1].toString().trim();
            //    var currValue = arrFields[2].toString().trim();

            //    setFilterComboValue("cboPMFilterProjectRiskID", currOpProjectRiskID);
            //    setFilterComboValue("txtPMFilterProjectRiskID", currValue);
            //}
            //if (arrFields[0] == "Description") {
            //    setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPMFilterDescription", "txtPMFilterDescription");
            //}
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
            if ($("#cboBGFilterBusinessGroupCode").val() != "Contains") {
                setFilterComboValue("cboBGFilterBusinessGroupCode", "Contains");
            }
            if ($("#txtBGFilterBusinessGroupCode").val() != "") {
                $("#txtBGFilterBusinessGroupCode").val("");
            }
            if ($("#txtBGFilterBusinessGroup").val() != "") {
                $("#txtBGFilterBusinessGroup").val("");
            }
            if ($("#cboBGFilterBusinessGroup").val() != "Contains") {
                setFilterComboValue("cboBGFilterBusinessGroup", "Contains");
            }
            $('#txtBGFilterName').val('');
            savedFilterName = "";

            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {

                    $(this).removeAttr("checked");
                });
            }
            //Added By Rutuja D, on 7 July 2021
            $('#cboBGFilterActive').val('=');
            $('#txtBGFilterActive').val('');
            //End of Added By Rutuja D, on 7 July 2021

            //if (flag == "") {
            //    if ($("#tabpresetfilter").hasclass("active")) {
            //        $("#tabpresetfilter").removeclass("active");
            //    }
            //    if ($("#presetfilter").hasclass("active")) {
            //        $("#presetfilter").removeclass("active");
            //    }
            //    $(".filter").removeclass("active");
            //    if ($('.filterpanel').hasclass("in")) {
            //        $('.filterpanel').removeclass("in");
            //    }
            //}
        }

        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
        }

       

        
        //const container = document.getElementById("BgSavefilter");
        //const modal = new bootstrap.Modal(container);

        function FilterApplied() {
      
            $(".mainclearalllink").removeClass("clsShowHide");
            $(".filter >  button").addClass("clsFilterHighlight");

            //document.getElementById("btnSaveFilter").addEventListener("click", function () {
            //    modal.hide();
            //});
         
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
            if ($('.filterpanel').hasClass("show")) {
                $('.filterpanel').removeClass("show");
            }
            $(".clsHideTooltip").each(function () {
                $(this).attr("data-bs-original-title", "Apply filter");
            });
            $('[data-bs-toggle="tooltip"]').tooltip();
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
            fltPersonResponsible = "";
            currentappliedfilter = 0;
            currentFilterID = 0;
            currentappliedfilterclause = "";
            ClearFilterDetails("");
            var GetBGWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
            GetBGDetails(GetBGWitManager);
            GetMyBGFilter(0); //Added By Mahesh on 21 July 2021
        });

        ///END Filter coding

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

        //Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }
        //End of Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021

        //function closeFilterPanel() {
        //    $("#filterpanel").removeClass('show');
        //    $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        //}

        $("body").children().first().before($(".modal"));
        $(document).on('click', 'button[data-bs-dismiss="modal"]', function () {          
           $('.modal').removeClass("show");
            $('.modal').hide();
            $('.modal-backdrop').hide();
            $('body').removeClass("modal-open");
            $('body').removeAttr("data-bs-overflow");
            $('body').css({'overflow': 'auto', 'padding-right':'0px'});
            $('.modal-backdrop').removeClass('show');
            $('.BgSavefilter_filter').removeClass('show').css('display', 'none');
        });
        
    </script>
</body>
</html>
