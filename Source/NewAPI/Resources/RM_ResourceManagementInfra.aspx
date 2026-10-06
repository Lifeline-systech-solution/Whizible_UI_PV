<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_ResourceManagementInfra.aspx.vb" Inherits="PbNIT.RM_ResourceManagementInfra" %>

<!DOCTYPE html>

<html> 
    <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head>
  <%--  <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css" />--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1" />
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

   

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

        .mr-5 {
            margin-right: 5px;
        }

        /*New style*/
        .detailsubtabs li a {
            padding: 6px 9.9px;
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

        /*new css*/
        #MEdetails .control-label, #basicfilters label {
            line-height: 18px;
            text-align: right;
        }

        .MEdetailimg {
            margin-bottom: 30px;
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
            height: 30px;
            border: 1px solid #ddd;
            padding: 6px 12px;
        }

        .IRcalendar {
            margin-bottom: 0;
        }

            .IRcalendar tr td span {
                display: block;
            }

            .IRcalendar tr td {
                padding: 5px !important;
                font-size: 12px;
            }


        .JStableOuter > table {
            overflow: initial;
        }

        #exceluploadsteps .tab-pane .form-group {
            overflow: visible;
        }

        .IRlbl {
            color: #fff;
        }

        .LabelBooked {
            background: #eb1c24;
        }

        .LabelHoliday {
            background: #f4cd0f;
        }

        .LabelPartialBooked {
            background: #868686;
        }

        .PRrolename .UpDowncollapseArrow {
            margin: 0 0;
        }

        .tab-pane .statustext {
            padding: 5px 10px 0;
            margin-top: 4px;
        }

        .JStableOuter > table > tbody > tr > td {
            padding: 8px;
        }

        .IRcalendar {
            padding: 0px;
        }

            .IRcalendar tr td {
                padding: 0 !important;
                min-width: 30px;
                width: 100%;
                height: 38px;
            }

                .IRcalendar tr td span.IRlbl {
                    height: 38px;
                }



        #jrange .input-group-btn button.btn.btncalendar {
            background: none;
        }

        .date-range-selected > .ui-state-active, .date-range-selected > .ui-state-default {
            background: none;
            background-color: lightsteelblue;
        }

        .jrangeUiDatepicker {
            position: absolute;
            top: 20px;
            left: 5px;
            z-index: 9999;
            margin-top: -20px;
        }

        .ui-datepicker {
            z-index: 9 !important;
        }
        /*Added by Pradip p. on 24/1/2022 */
        .month_year_datepicker table.ui-datepicker-calendar { display:none!important;
        }
        .month_year_datepicker .ui-datepicker-buttonpane {display:block!important;
        }
        
        .custmodal .modal-content .modal-body {
            padding: 30px;
        }

        #exceluploadsteps .tab-pane .form-group {
            overflow: visible;
        }

        #exluploadTbl_wrapper tr th {
            white-space: nowrap;
            min-width: 200px;
        }

        #exluploadTbl_wrapper tr th {
            min-width: 80px;
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
        /*Hide Calender*/
        /*.AsignmentMonthpic .ui-datepicker-calendar {
            display: none;
        }*/

        div#ui-datepicker-div {
            z-index: 9999 !important;
            min-width: 195px; /*Added By pradip P on 8th Dec 2021*/
        }

        /*.AssignmentGridTble tbody {
            display: none;
        }*/
        /*.AssignmentGridTble tbody.AstmntGrid1{ display:block;}*/
        div#AssignmentGridTble_wrapper {
            margin-bottom: 20px;
        }

        #filterpanel .cust_tabpanel .nav-tabs > li > a:focus {
            color: #fff;
        }
        /*TO REMOVE SORTING AND FOR FILTER*/
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

        .filter button[aria-expanded="true"] {
            background: NONE;
            color: #4263c1;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
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
            display: none !important;
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

        .clsFilterHighlight {
            background: #1359a6 !important;
            color: #ffffff !important;
        }

        .pointerDisable {
            pointer-events: none;
        }
        .actioncolumn{
            width:6% !important;
        }
        .pagination{ margin-bottom:0!important;}
        .filterpanelbody .form-group {display:flex}
        .tab-content .form-group{display:flex}
        .RTForm .form-group{display:flex}
        .tab-content .form-group {flex-wrap:wrap; }
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" >
    <%--  /*Added & Commented By Madhuri.K On 21-Aug-2024 For Loader Issues*/--%>
    <div class="" id="body-ResRequest"></div>
        <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-0 text-end graybg">
            <div class="row">
                <div class="col-sm-7">
                    <h5 class="pgtitle float-start"> Infrastructure Resource Management</h5>                    
                </div>

                

                <div class="col-sm-5 float-end" style="margin-top: 5px;">
                    <div class="dropdown filedownload float-end">

                        <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" style="margin-top: 4px;"><i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Click here to download" class="fas fa-download"></i></button>
                        <ul class="dropdown-menu">
                            <li><a href="#" onclick="ExportInfraDemandInfo('PDF')">
                                <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                            <li><a href="#" onclick="ExportInfraDemandInfo('EXCEL')">
                                <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                            <li><a href="#" onclick="ExportInfraDemandInfo('XML')">
                                <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                            <li><a href="#" onclick="ExportInfraDemandInfo('RTF')">
                                <img src="../../../Whizible2.0-new/dist/img/rtf.svg" width="18px">Rtf</a></li>
                        </ul>

                    </div>

                    <div class="filter inline float-end">
                        <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-bs-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
                    </div>
                    <%--<a href="javascript:;" class="clearalllink float-end" style="" onclick="clearAll" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>--%>
                    <a href="javascript:;" class="mainclearalllink float-end" onclick="closeFilterPanel()" style="" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
                     <%--Added by imran Query String for back page on 15-12-2021--%>
                    <a href="RM_IrRequestApproval.aspx?Flag=True&PageName=RM_ResourceManagementInfra.aspx" class="btn borderbtn addbtn mr-5 float-end" id="">Approve / Reject Request</a>
                    <%--End Commented by imran 15-12-2021--%>
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
                        <div id="basicfilters" class="tab-pane stackbasicfilter">
                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="checkFiltervalidationForInfraRes();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFilter();">Apply</button>
                                </div>
                                <br />

                                <div class="row">

                                    <div class="col-sm-6 form-group">
                                       <%-- Commented And Added By reshma Chavan for changing Caption IssueID-31737--%>
                                        <%--<label class="col-sm-4">Infra Name</label>--%>
                                        <label class="col-sm-4">Infrastructure Name</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboResourceFilterInfraName">
                                                        <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtResourceFilterInfraName", "txtResourceFilterInfraName", "form-control", widthInPixel:=0, maxLength:=50) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <label class="col-sm-4">Retired On</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboResourceFilterRetiredOn">
                                                        <option value="=">=</option>
                                                        <option value="<>"><></option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0" style="display:flex">
                                                    <div class="input-group">
                                                        <%--<input id="FltrRetiredOnDatefield" type="text" class="form-control input-sm">--%>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtResourceFilterRetiredOn", "txtResourceFilterRetiredOn", "form-control",,,,,, , True, "White",, "autocomplete='off'",, ,,,,, True) %>
                                                        <span class="input-group-btn" style="margin-top: 8px; margin-left: 1px;">
                                                            <button class="btn btncalendar" type="button" style="height:35px"><i class="fas fa-calendar-alt"></i></button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <%-- Commented And Added By reshma Chavan for changing Caption IssueID-31737--%>
                                        <%--<label class="col-sm-4">Infra Type</label>--%>
                                        <label class="col-sm-4">Infrastructure Type</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboResourceFilterInfraTypeId">
                                                        <option value="=">=</option>
                                                        <option value="<>"><></option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtResourceFilterInfraTypeId", "usp_Whizible2_Sel_tbl_RM_InfraTypeMaster",,, "class='form-control' ",,,, ,) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <%-- Commented And Added By reshma Chavan for changing Caption IssueID-31737
                                        <%--<label class="col-sm-4">Infra Group</label>--%>
                                        <label class="col-sm-4">Infrastructure Group</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboResourceFilterInfraGroupId">
                                                        <option value="=">=</option>
                                                        <option value="<>"><></option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtResourceFilterInfraGroupId", "usp_Whizible2_Sel_tbl_RM_InfraGroupMaster",,, "class='form-control' ",,,, ,) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <label class="col-sm-4">Business Group</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboResourceFilterBusinessGroupID">
                                                        <option value="=">=</option>
                                                        <option value="<>"><></option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtResourceFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-control"" onChange=""FillFilterOUForFilter(this.value)""",,,, ,)%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <label class="col-sm-4">Organization Unit</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboResourceFilterLocationID">
                                                        <option value="=">=</option>
                                                        <option value="<>"><></option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtResourceFilterLocationID", "Select '' ",,, "class='form-control'",,, ) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 form-group">
                                          <%-- Commented And Added By reshma Chavan for changing Caption IssueID-31737
                                        <%--<label class="col-sm-4">Status</label>--%>
                                        <label class="col-sm-4">Infrastructure Status</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboResourceFilterInfraStatusId">
                                                        <option value="=">=</option>
                                                        <option value="<>"><></option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtResourceFilterInfraStatusId", "usp_Whizible2_Sel_tbl_RM_InfraStatusMaster",,, "class='form-control' ",,,, ,) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <br />
                                </div>

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
                        <input id="srchMIlist" type="text" class="search-query form-control" placeholder="Search" onkeyup="mysearchFunction()">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" style="height: 35px;">
                                <span class=" glyphicon glyphicon-search" onclick="mysearchFunction()"></span>
                            </button>
                        </span>
                    </div>
                </div>
                <div class="col-sm-9 text-end">
                    <a href="javascript:;" class="btn borderbtn mr-5" id="btnDownloadTemplate" data-bs-toggle="modal" onclick="Download_Template()">Download Template</a>
                    <a href="#" class="btn borderbtn mr-5 uploadExlbtn" id="btnUpload" data-bs-toggle="modal" onclick="irmOpenExceluploadsteps()">Upload</a>
                    <button class="btn borderbtn addbtn mr-5" id="btnAddRes" onclick="addIMResources()"><i class="fa fa-plus" aria-hidden="true"></i>Add Resources</button>

                </div>
            </div>
        </div>

        <div class="content pt-0">
            <div class="MInfratblouter">
                <table id="MInfraListTbl" class="table table-bordered MITablelist" style="width: 100%;">
                    <thead>
                        <tr>
                            <%--Commented And Added By reshma Chavan for changing Caption IssueID-31737--%>
                            <%--<th class="text-center">Type</th>
                            <th>Infra Group</th>
                            <th>Infra Name</th>--%>
                            <th width="150" class="text-center">Infrastructure Type</th>
                            <th width="150">Infrastructure Group</th>
                            <th width="160">Infrastructure Name</th>
                            <th width="130">Business Group</th>
                            <th width="130">Available From</th>
                            <th width="130">Available Till</th>
                            <%--<th>Status</th>--%>
                            <th width="160">Infrastructure Status</th>
                             <%--End of Commented And Added By reshma Chavan for changing Caption IssueID-31737--%>
                            <th width="90">&nbsp</th>
                        </tr>
                    </thead>
                    <tbody id="MInfraList">
                    </tbody>
                </table>
            </div>
        </div>


        <div class="Resourcedetailpanel">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li><a href="#MIdetails" class="active" data-bs-toggle="tab" id="tabDetails">Details</a></li>
                    <li class=""><a href="#IDRenewalTransaction" data-bs-toggle="tab" id="tabRenewalTransactions" onclick="openRenewalTransactions();">Renewal Transactions</a></li>
                    <li class=""><a href="#MICalendarviewTab" data-bs-toggle="tab" id="tabAssignments" onclick="openAssignments();">Assignments</a></li>
                    <!--<li class=""><a href="#MICalendarviewTab" data-bs-toggle="tab" id="">Calendar</a></li>-->

                </ul>
                <div class="clearfix"></div>
                <div class="tab-content" id="body-LoaderHistory">
                    <div id="MIdetails" class="tab-pane active">
                        <input type="hidden" id="hdnResourceId" name="hdnResourceId">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <%--<a href="javascript:;" data-bs-toggle="modal" data-bs-target="#infraHistoryModal" onclick="infraHistory();" class="btn borderbtn mr-5" id="btnHistory">History</a>--%>
                            <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#infraHistoryModal" onclick="infraHistory();" data-bs-placement="bottom" title="" data-bs-original-title="History" class="btn borderbtn mr-5" id="btnHistory">History</a>
                            <%-- Commented and added by Chetan M on 20 Jul 2021 for ToolTip Issue--%>
                            <%--<button class="btn btnyellow mr-5" id="btnSave" onclick="saveResource(0)">Save</button>--%>                            
                            <button class="btn btnyellow mr-5" data-bs-placement="bottom" title="" id="btnSave" data-bs-original-title="Save" onclick="saveResource(0)">Save</button>
                            <%--<button class="btn btnyellow mr-5" id="btnSaveAdd" onclick="saveResource(1)">Save And Add</button>--%>
                                <button class="btn btnyellow mr-5" data-bs-placement="bottom" title="" id="btnSaveAdd" data-bs-original-title="Save And Add" onclick="saveResource(1)">Save And Add</button>
                            <%--<button class="btn borderbtn canceldetailpanel mr-5" id="btnCancel" onclick="cancledetailpanelMain()">Cancel</button>--%>
                            <button class="btn borderbtn canceldetailpanel mr-5" data-bs-placement="bottom" title=""  id="btnCancel" data-bs-original-title="Cancel"  onclick="cancledetailpanelMain()">Cancel</button>
                        </div>



                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <%--Commented And Added By reshma Chavan for changing Caption IssueID-31737--%>
                                        <%--<label for="" class="col-sm-4 control-label required">Infra Name</label>--%>
                                        <label for="" class="col-sm-4 control-label required">Infrastructure Name</label>
                                        <div class="col-sm-8 pl-0">
                                            <%--Commented & Added By Rutuja D, on 23 July 2021 For IssueID=29356 (Restrict Operators)--%>
                                            <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtInfraName", "txtInfraName", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>--%>
                                            <%--Commented & Added By Reshma chavan on 7th Dec 2021 For IssueID=31727 not able add space between two words(Restrict Operators)--%>
                                           <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtInfraName", "txtInfraName", "form-control", 0, 50,,,,,,,,"onkeypress='return /[0-9a-zA-Z]/i.test(event.key)'")%>--%>                                       
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtInfraName", "txtInfraName", "form-control", 0, 50,,,,,,,, "onkeypress='return restrictSpecialChars(event)' onPaste='return false'")%>
                                            <%--End of Commented & Added By Rutuja D, on 23 July 2021 For IssueID=31727 (Restrict Operators)--%>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label">Description</label>
                                        <div class="col-sm-8 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Enter Description (Maxlength 200 Chars)", "form-control", ,,,, , , 200,,,,,,,, "autocomplete='Off' maxlength='200'",, False,,,,,,,,) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label">Active</label>
                                        <div class="col-sm-8 pl-0">
                                            <div class="custom_chckbox">
                                                <input type="checkbox" id="IsActive" class="chcktbl" checked>
                                                <label for="IsActive"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <%--Commented And Added By reshma Chavan for changing Caption IssueID-31737--%>
                                        <%--<label for="" class="col-sm-4 control-label required">Type</label>--%>
                                        <label for="" class="col-sm-4 control-label required">Infrastructure Type</label>
                                        <div class="col-sm-8 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboInfraType", "Select 0,'' ",,, "class='form-control'",,,) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <%--<label for="" class="col-sm-4 control-label required">Infra Group</label>--%>
                                        <label for="" class="col-sm-4 control-label required">Infrastructure Group</label>
                                        <div class="col-sm-8 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboInfraGroup", "Select 0,'' ",,, "class='form-control'",,, True) %>
                                        </div>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">

                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label required">Business Group</label>
                                        <div class="col-sm-8 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboBG", "Select 0,''",,, "class=""form-control"" onChange=""FillOU(this.value,undefined,2)""",,,, ,)%>
                                        </div>

                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label required">Organization Unit</label>
                                        <div class="col-sm-8 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboOU", "Select 0,'' ",,, "class=""form-control""",,,, ,)%>
                                        </div>

                                    </div>
                                </div>

                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label required">Max Allocation Per Day (Hrs)</label>
                                        <div class="col-sm-8 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtMaxAllocation", "txtMaxAllocation", cssClass:="form-control", widthInPixel:=0, maxLength:=2)%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <%--Commented And Added By reshma Chavan for changing Caption IssueID-31737--%>
                                        <%--<label for="" class="col-sm-4 control-label">Infra Status</label>--%>
                                        <label for="" class="col-sm-4 control-label">Infrastructure Status</label>
                                        <div class="col-sm-8 pl-0">
                                            <div class="custom_chckbox">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboInfraStatus", "Select 0,'' ",,, "class=""form-control""",,,, ,) %>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                            </div>


                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label required">Cost Per Hr</label>
                                        <div class="col-sm-8 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtCostPerhr", "txtCostPerhr", cssClass:="form-control", widthInPixel:=0, maxLength:=6)%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label required">Rate Per Hr</label>
                                        <div class="col-sm-8 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtRatePerhr", "txtRatePerhr", cssClass:="form-control", widthInPixel:=0, maxLength:=6)%>
                                        </div>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label">Total Cost of Acquisition</label>
                                        <div class="col-sm-8 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtTotalCostofAcquisition", "txtTotalCostofAcquisition", cssClass:="form-control", widthInPixel:=0, maxLength:=12)%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label">Depreciation Rate</label>
                                        <div class="col-sm-8 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtDepreciationRate", "txtDepreciationRate", cssClass:="form-control", widthInPixel:=0, maxLength:=4)%>
                                        </div>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label required">Available From</label>
                                        <div class="col-sm-8 pl-0">
                                            <div class="input-group">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtAvailableFrom", "txtAvailableFrom", "form-control clsDateColor",,,,,, False, True, "White", False, "autocomplete = 'off'",,, ,,,,) %> <%--Added By Rutuja on 20 Aug 2021 ReadOnly true--%>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label">Available Till</label>
                                        <div class="col-sm-8 pl-0">
                                            <div class="input-group" id="DivtxtAvailableTill">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtAvailableTill", "txtAvailableTill", "form-control clsDateColor",,,,,, False, True, "White", False, "autocomplete = 'off'",,, ,,,,) %><%--Added By Rutuja on 20 Aug 2021 ReadOnly true--%>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label">Retired on</label>
                                        <div class="col-sm-8 pl-0">
                                            <div class="input-group">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRetiredOn", "txtRetiredOn", "form-control clsDateColor",,,,,, False, True, "White", False, "autocomplete = 'off'",,, ,,,,) %>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%-- <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-4 control-label">Shared Resource</label>
                                        <div class="col-sm-8 pl-0">
                                            <select class="form-control" id="cboSharedResource">
                                                <option></option>
                                                <option value="Yes">Yes</option>
                                                <option value="No">No</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="form-group" style="display:contents">
                                    <div class="col-sm-6">
                                        <div class="row">
                                            <label for="" class="col-sm-4 control-label required">Total Quantity / No. of Licenses</label>
                                            <div class="col-sm-8 pl-0">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtNoOfLicenses", "txtNoOfLicenses", cssClass:="form-control", widthInPixel:=0, maxLength:=10)%>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="clearfix"></div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                        </div>

                    </div>

                    <div id="IDRenewalTransaction" class="tab-pane" id="body-Renewal">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <!--<a href="javascript:;" data-bs-toggle="modal" data-bs-target="#infraHistoryModal" class="btn borderbtn mr-5" id="">History</a>-->
                            <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#addRenewalModal" class="btn borderbtn mr-5" id="addRenewalTrans" onclick="clearRenewals();"><i class="fa fa-plus" aria-hidden="true"></i>Add Renewal Transaction</a>
                            <!--<button class="btn btnyellow mr-5" id="">Save</button>-->
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>

                        <div class="clearfix">

                            <table id="RTsubtabShowHistoryTbl" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th>Type Of Subscription</th>
                                        <th>Billing Period</th>
                                        <th>Date Of Renewal</th>
                                        <th>Next Billing Date</th>
                                        <th>Amount</th>
                                        <th>Total Quantity/No. of Licence</th>
                                        <th>Currency</th><%--Added By Rutuja D. For IssueID = 29420--%>
                                    </tr>
                                </thead>
                                <tbody id="RTsubtabShowHistoryTblMain">
                                </tbody>
                            </table>


                        </div>

                    </div>

                    <div id="MICalendarviewTab" class="tab-pane">

                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>
                        <div class="graybg pt-1 pb-1 row">
                            <div class="col-sm-5">
                                &nbsp;
                            </div>
                            <div class="col-sm-3">
                                <!--<div id="" class="dates input-group">
                                <input id="js-date" class="form-control">
                                <span class="input-group-btn">
                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                </span>
                            </div>-->
                                <label for="startDate">Date :</label>
                                <input name="startDate" id="AsignmentMonthpic" class="date-picker" readonly/>



                                <!--<div id="jrange" class="dates input-group">
                                <input class="jrangeinput form-control" />
                                <div class="jrangeUiDatepicker"></div>
                                <span class="input-group-btn">
                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                </span>
                            </div>-->
                            </div>
                            <div class="col-sm-4">&nbsp;</div>

                            <div class="clearfix"></div>
                        </div>

                        <div class="IRRsrsCalendarTbl">
                            <div class="JStableOuter">
                                <table id="table" class="table table-bordered">
                                    <tbody>
                                        <tr>
                                            <td class="text-start PRrolename" style="min-width: 240px; max-width: 240px;">Infrastructure Resource Name
                                                <a href="javascript:;" class="nostyle hidden-xs UpDowncollapseArrow in" data-bs-toggle="collapse" data-bs-target=".PRhiderow2" data-bs-original-title="" title="">
                                                    <img class="uparrow" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="" width="15px" data-bs-original-title="Hide Task" data-bs-container="body">
                                                    <img class="downarrow" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="" width="15px" data-bs-original-title="Show Task" data-bs-container="body">
                                                </a>

                                            </td>
                                            <%-- <td colspan="30"><strong>Aug 2019</strong></td>--%>
                                            <td colspan="30"></td>
                                        </tr>
                                        <tr>
                                            <td class="text-start" style="min-width: 240px; max-width: 240px;">
                                                <label id="lblResourcename"></label>
                                            </td>
                                            <td style="padding: 0;">

                                                <table class="IRcalendar table-bordered" width="100%">
                                                    <tbody id="tblassignments">
                                                    </tbody>

                                                </table>

                                            </td>

                                        </tr>

                                        <%-- <tr class="PRhiderow2 collapse show">--%>
                                        <%--<td class="text-start" style="min-width: 240px; max-width: 240px;">Air Flow Lab</td>--%>
                                        <%--<td style="padding: 0;">--%>

                                        <%--<table class="IRcalendar table-bordered" width="100%">--%>
                                        <tbody id="tblAssignColor">
                                        </tbody>

                                        <%-- </table>--%>

                                        <%--</td>--%>

                                        <%--   </tr>--%>
                                    </tbody>
                                </table>
                            </div>

                            <table id="AssignmentGridTble" class="table table-bordered AssignmentGridTble" style="width: 100%; display: table;">
                                <thead>
                                    <tr>
                                        <th>Project</th>
                                        <th>Allocated Qty/License</th>
                                        <th>From Date</th>
                                        <th>To Date</th>
                                        <th>Rate/Hr Corporate Currency</th>
                                        <th>Cost/Hr Corporate Currency</th>
                                    </tr>
                                </thead>
                                <tbody id="AstmntGrid1">
                                    <%--   <tbody id="assprojects">
                                    
                                </tbody>--%>
                                </tbody>
                            </table>

                        </div>
                    </div>


                </div>
            </div>
        </div>

        <!-- Save filter Modal start here-->
        <div class="modal custmodal InfraRessavefiltersave_filter fade" id="InfraRessavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="InfraRessavefiltersavrefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end required">Filter Name :</label>
                                            <span class="col-md-8">
                                                <%--chnaged by mahesh on 29 july 2021--%>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control",, maxLength:=50) %><br />
                                                <%--End chnaged by mahesh on 29 july 2021--%>
                                                <div class="btnrow">
                                                    <button class="btn btnyellow float-start" id="btnSaveFilter" onclick="SaveInfraResFilterDetails()">Save</button>
                                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end">Cancel</button>
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
                                        <p><span id="plabelName"></span><span id="dvShowFileName"></span></p>
                                        <button type="submit">Upload</button>
                                    </form>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="clearfix"></div>
                                <br />
                                <br />
                                <div class="list-inline text-center">
                                    <button type="button" class="btn btnyellow nextwizardbtn ml-1 " onclick="IrmUploadxlsfile()">Next</button>
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
                                    <%--  <div class="col-sm-6">
                                        <label class="">ExcelColumn-R</label>
                                       <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_R", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>--%>
                                    <div class="clearfix"></div>
                                </div>

                                <br />
                                <br />
                                <ul class="list-inline text-center">
                                    <li>
                                        <button id="btnPrevious" type="button" class="btn borderbtn btnPrevious" onclick="IrmBackStep_2()">Back</button>
                                        <button type="button" class="btn btnyellow nextwizardbtn ml-1 " onclick="IrmNextStep_2()">Next</button></li>
                                </ul>

                            </div>
                            <div class="tab-pane" id="PBEUstep3">

                                <p class="float-start">
                                    <a href="#">Uploaded Data : <span id="dvShowFileNameStep3"></span>
                                        <div class="form-group float-end">
                                            <div class="input-group searchsetting" id="searchsetting">
                                                <input id="txtSearchXlsxInfraName" type="text" class="form-control" placeholder="Search Infrastructure name">
                                                <span class="input-group-addon">
                                                    <button type="submit">
                                                        <span class="glyphicon glyphicon-search"></span>
                                                    </button>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="clearfix"></div>
                                        <div class="dataTables_scrollBody" style="position: relative; overflow: auto; width: 100%; height: 350px;">

                                            <table id="exluploadTbl" class="table bgwhite table-bordered" style="width: 100%; margin-left: 0px;">
                                                <thead>
                                                    <tr>
                                                        <th>Is Valid</th>
                                                        <%--<th>Infra Name</th>--%>
                                                        <th>Infrastructure Name</th>
                                                        <th>Description</th>
                                                        <th>Active</th>
                                                        <%--<th>Type</th>--%>
                                                        <th>Infrastructure Type</th>
                                                        <%--<th>Infra Group</th>--%>
                                                        <th>Infrastructure Group</th>
                                                        <th>Business Group</th>
                                                        <th>Organization Unit</th>
                                                        <th>Max Allocation Per Day (Hrs)</th>
                                                        <%--<th>Infra Status</th>--%>
                                                        <th>Infrastructure Status</th>
                                                        <th>Cost Per Hr</th>
                                                        <th>Rate Per Hr</th>
                                                        <th>Total Cost of Acquisition</th>
                                                        <th>Depreciation Rate</th>
                                                        <th>Available From</th>
                                                        <th>Available Till</th>
                                                        <th>Retired On</th>
                                                        <th>Total Quantity / No. of Licenses</th>
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
                                                <button id="btnPrevious" type="button" class="btn borderbtn btnPrevious" onclick="IrmBackStep_3()">Back</button>
                                                <button type="button" class="btn btnyellow nextwizardbtn ml-1 uploadbtn" onclick="IrmSaveXlsxData()">Upload</button>
                                            </li>
                                        </ul>
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
        <!-- Add Certification Modal start here-->
        <div class="modal custmodal fade" id="AddCertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                    <label>Certification Name</label>
                                    <input type="text" class="form-control" />
                                </div>

                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <label>Certification Date</label>
                                    <div class="input-group datefielddiv">
                                        <input id="MECertDate" type="text" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label>Valid Upto Date</label>
                                    <div class="input-group datefielddiv">
                                        <input id="MEValidDate" type="text" class="form-control">
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
                                    <input id="" type="text" class="form-control" />
                                </div>
                                <div class="col-sm-6">
                                    <label>Out of</label>
                                    <input id="" type="text" class="form-control" />
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <br />
                            <div class="text-center">
                                <button class="btn btnyellow" data-bs-dismiss="modal">Save</button>
                                <button class="btn btnyellow" data-bs-dismiss="modal">Save And Add</button>
                                <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Add Certification Modal End here-->
        <!-- Infra History Modal start here-->
        <div class="modal custmodal fade" id="infraHistoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">History</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <%--<div class="clearfix">--%>
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
                        <br />
                        <div class="text-center">
                            <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>

                    <%--<div class="clearfix"></div>--%>
                </div>
            </div>
        </div>
    </div>
    <!-- Infra History Modal End here-->

    <!-- Renewal Transaction History Modal start here-->
    <div class="modal custmodal fade" id="addRenewalModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Add Renewal Transactions</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="clearRenewals();">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" >
                    <div class="RTForm">
                        <div class="form-group">
                            <div class="col-sm-6">
                                <label for="" class="control-label required">Type of Subscription</label>
                                <select class="form-control" id="cboTypeSubscription">
                                    <%-- Commented and added by Chetan M on 20 Jul 2021 for adding placeholder--%>
                                    <%--<option></option>--%>
                                    <option value="">Select Type of Subscription</option>
                                    <%--//End of Commented and added by Chetan M on 20 Jul 2021 for adding placeholder--%>
                                    <option value="New">New</option>
                                    <option value="Renewal">Renewal</option>
                                    <option value="Reduction">Reduction</option>
                                </select>

                            </div>

                            <div class="col-sm-6">
                                <label for="" class="control-label required">Billing Period</label>
                                <select class="form-control" id="cboBillingPeriod">
                                    <%--Commented and added by Chetan M on 20 Jul 2021 for adding placeholder--%>
                                    <%--<option></option>--%>
                                    <option value="">Select Billing Period</option>
                                    <%--//End of Commented and added by Chetan M on 20 Jul 2021 for adding placeholder--%>
                                    <option value="Monthly">Monthly</option>
                                    <option value="Quarterly">Quarterly</option>
                                    <option value="Semi">Semi Annual</option>
                                    <option value="Annual">Annual</option>
                                    <option value="One Time">One Time</option>
                                </select>


                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-6">

                                <label for="" class="control-label required">Date of Renewal</label>

                                <div class="input-group">
                                    <%CommonFunctions.HTMLControls.DrawTextBox("txtDateOfRenewal", "txtDateOfRenewal", cssClass:="form-control", widthInPixel:=0, maxLength:=50, IsReadonly:=True, readonlyBackgroundColor:="White")%>
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>

                                </div>
                            </div>

                            <div class="col-sm-6">
                                <label for="" class="control-label required">Total Quantity / No. of Licenses</label>
                                <%CommonFunctions.HTMLControls.DrawTextBox("txtTotalQuantity", "txtTotalQuantity", "form-control", widthInPixel:=0, maxLength:=3, ToBeInserted:="Autocomplete='off'")%>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-6">
                                <label for="" class="control-label required">Currency</label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboCurrency", "usp_Whizible2_sel_tbl_PM_CurrencyMaster",,, "class='form-control'",,,) %>
                            </div>

                            <div class="col-sm-6">
                                <label for="" class="control-label required">Amount</label>
                                <%CommonFunctions.HTMLControls.DrawTextBox("txtAmount", "txtAmount", "form-control", widthInPixel:=0, maxLength:=14, ToBeInserted:="Autocomplete='off'")%>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">

                            <div class="col-sm-6">

                                <label for="" class="control-label">Next Billing Date</label>
                                <div class="input-group">
                                    <%CommonFunctions.HTMLControls.DrawTextBox("txtNextBillingDate", "txtNextBillingDate", cssClass:="form-control", widthInPixel:=0, maxLength:=50, IsReadonly:=True, readonlyBackgroundColor:="White")%>
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>

                            </div>
                            <div class="col-sm-6">
                                &nbsp;
                            </div>
                            <div class="clearfix"></div>
                        </div>



                        <br />
                        <div class="text-center">
                            <button class="btn btnyellow" onclick="saveRenewalTransaction()">Save</button>
                            <button class="btn borderbtn" data-bs-dismiss="modal" onclick="clearRenewals();">Close</button>
                        </div>
                    </div>

                    <%--<div class="clearfix"></div>--%>
                </div>
            </div>
        </div>
    </div>
    <!-- Renewal Transaction History Modal End here-->
    <%--<div class="clearfix"></div>--%>
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
                                    <p id="deleteConfirmMsg"><center  style="color:black">Are you sure to delete the selected filter?</center></p>
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
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script> 
      <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>
        //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        var UserName = '<%= Session("strUserName") %>';
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var TagID = '<%= m_TagId%>';

        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';
        var noOfRowsPerPage = 10;
        var NoDataFound = "No data found.";
        document.getElementById('plabelName').innerHTML = "Attach file or drop here :-";
        alertify.set('notifier', 'position', 'top-right');
        $(document).ready(function ()
        {   //Added By Rehan C for Special Character Validation on 17th Jan 2023
            $('#txtMaxAllocation,#txtRatePerhr,#txtCostPerhr,#txtTotalCostofAcquisition,#txtDepreciationRate,#txtNoOfLicenses').bind("cut copy paste", function (e) {
                e.preventDefault();
            });
            //End Of Comment By Rehan C
            $('.btn, a').tooltip({ trigger: 'hover' });
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });

            $(document).on("click", function () {
                $(".tooltip").removeClass('show');
            });


            //Added By Rutuja D. For Bind Filter Placeholder on 15 July 2021
            AllBindPlaceHolderFun();
            //End of Added By Rutuja D. For Bind Filter Placeholder on 15 July 2021
            //Search List Filter
            $(".table").resize();
            FillBG(0);
            FillFilterOUForFilter(0);
            GetResourceRequest(null);
            if (blnAddAccess == "False") {
                $("#btnAddRes").addClass("clsShowHide");
                $('#btnSaveAdd').attr("disabled", true);
                $("#btnUpload").addClass("clsShowHide");
                $("#addRenewalTrans").addClass("clsShowHide");
            }
            else {
                $("#btnAddRes").removeClass("clsShowHide");
                $('#btnSaveAdd').attr("disabled", false);
                $("#btnUpload").removeClass("clsShowHide");
                $("#addRenewalTrans").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {
                GetMyInfraResFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);

                } else {
                    GetInfraResDetails(null);
                    FilterNotApplied();
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
            //Commented and added by Chetan M on 20 Jul 2021 for adding placeholder
            BindPlaceholder("cboOU", "Organization Unit");
            //Commented By Reshma Chavan on 7th Dec 2021 for duplicate placeholder change
            //BindPlaceholder("cboCurrency", "Currency");
            //End of Commented By Reshma Chavan on 7th Dec 2021 for duplicate placeholder change
           
            //End of Commented and added by Chetan M on 20 Jul 2021 for adding placeholder
             //Added By Reshma Chavan on 18th Jan 2022 for adding Tooltip IssueID-31767
            BindTextBoxToolTip('txtAvailableTill');
             //End of Added By Reshma Chavan on 18th Jan 2022 for adding Tooltip IssueID-31767
        });

        /*Added By Dipali V On 31st Jan 2023 for hide tooltip*/
        $(".ui-datepicker").click(function () {
            $('.tooltip').removeClass('show');
        });

        $("#txtResourceFilterRetiredOn,#txtDateOfRenewal,#txtNextBillingDate").on("change", function () {
            $('.btn').tooltip({ trigger: 'hover' });
            $('span').tooltip({ trigger: 'hover' });
            $('.ui-datepicker-calendar th span').tooltip('hide');
            $('.tooltip-inner').tooltip('hide');
            $(".tooltip").removeClass('show');
        });
        /*End of Added By Dipali V On 31st Jan 2023 for hide tooltip*/

        //Added By Reshma Chavan on 18th Jan 2022 for adding Tooltip IssueID-31767
        function BindTextBoxToolTip(ID) {
            var Selectedtext = "'Availability Till' become Mandatory.While Searching Availability at the Project level.";
            if (Selectedtext != "") {
                $("#Div" + ID).attr("data-bs-toggle", "tooltip");
                $("#Div" + ID).attr("data-bs-original-title", Selectedtext);
            }
            $('#' + ID).hover(function () {
                $('data-bs-toggle= tooltip ').tooltip();
            });
        }
        //End of Added By Reshma Chavan on 18th Jan 2022 for adding Tooltip IssueID-31767

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
        $('#txtRetiredOn, #txtAvailableFrom,#txtAvailableTill, #txtDateOfRenewal, #txtNextBillingDate, #txtResourceFilterRetiredOn').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd M yy'
        });

        function addIMResources() {
            $("#hdnResourceId").val(0);
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $("#MInfraListTbl_wrapper .dataTables_scrollBody,.MInfratblouter, .srchrequest, .weekly_calender, .backbtn, .addbtn, #MInfraListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter,.mainclearalllink").addClass("DisableContent").parent().css("cursor", "no-drop");
            //$(".table").resize();
            $('#tabDetails').click()
            $('#tabRenewalTransactions').addClass("DisableContent");
            $('#tabAssignments').addClass("DisableContent");
            FillInfraType(0);
            FillInfraGroup(0);
            FillInfraStatus(0);
        }



        function editIM(infraResourceID) {
            $("#hdnResourceId").val(infraResourceID);
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $("#MInfraListTbl_wrapper .dataTables_scrollBody,.MInfratblouter, .srchrequest, .weekly_calender, .backbtn, .addbtn, #MInfraListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter,.mainclearalllink").addClass("DisableContent").parent().css("cursor", "no-drop");

            $(".table").resize();
            InfraResourceGetByID(infraResourceID);
            $('#tabDetails').click()
            $('#tabRenewalTransactions').removeClass("DisableContent");
            $('#tabAssignments').removeClass("DisableContent");
        }
        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });

        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#MInfraListTbl_wrapper .dataTables_scrollBody,.MInfratblouter, .srchrequest, .weekly_calender, .backbtn, .addbtn, #MInfraListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter,.mainclearalllink").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();            
            cancledetailpanelMain();  //Added by RehanC for AddResource refresh issue on 30th Mar 2023
        });


        //Shital//
        var infraResourceRequest = {
            InfraResourceId: "", InfraName: "", Description: "", InfraTypeId: "", InfraGroupId: "",
            BusinessGroupID: "", LocationID: "", MaxAllocationPerDay: "", TotalQuantity: "", CostPerHour: "", RatePerHour: "",
            TotalCostOfAcquisition: "", DepreciationRate: "", AvaliableFrom: "", AvaliableTill: "", RetiredOn: "", InfraStatusId: "", Shared: "", CreatedBy: "", IsActive: ""
        };
        var d = new Date();
        var n = d.toLocaleString('en-us', { month: 'long' }) + " " + d.getFullYear();
        $('#AsignmentMonthpic').val(n);
        function openAssignments() {
            var selectedDate = '';
            var strHTML = "";
            $('#lblResourcename').html($("#txtInfraName").val());
            if ($('#AsignmentMonthpic').val() != null && $('#AsignmentMonthpic').val() != "") {
                selectedDate = new Date($('#AsignmentMonthpic').val());
                selectedDate = ((selectedDate.getMonth() > 8) ? (selectedDate.getMonth() + 1) : ('0' + (selectedDate.getMonth() + 1))) + '/' + ((selectedDate.getDate() > 9) ? selectedDate.getDate() : ('0' + selectedDate.getDate())) + '/' + selectedDate.getFullYear();
            }
            objselectAssign = { "InfraResourceId": $("#hdnResourceId").val(), "AssignDate": selectedDate }
            $.ajax({
                url: strUrl + '/api/RM_InfraResources/GetAssignments',
                type: "POST",
                data: JSON.stringify(objselectAssign),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));

                    if (objselectAssign) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objselectAssign) ? objselectAssign : JSON.stringify(objselectAssign)));
                    }
                },
                success: function (data) {
                    var List = data;
                    // console.log("AList", List);
                    if (List.length > 0) {
                        strHTML += "<tr>";
                        $.each(List, function (index, obj) {
                            strHTML += "<td  class='table-bordered'>" + obj.Date + " <span>" + obj.Day + "</span></td>";

                        });
                        strHTML += "</tr>";
                        strHTML += "<tr>";
                        $.each(List, function (index, obj) {
                            if (obj.Day == "Sat" || obj.Day == "Sun") {
                                strHTML += "<td style='background-color: #f4cd0f;' class='table-bordered' onclick=\"(openAssigmentsAvailablity('" + obj.ActualDate + "'))\"></td>";
                            }
                            else if (obj.Count > 0) {
                                strHTML += "<td  style='background-color: red;' class='table-bordered' onclick=\"(openAssigmentsAvailablity('" + obj.ActualDate + "'))\"></td>";
                            }
                            else {
                                strHTML += "<td class='table-bordered' onclick=\"(openAssigmentsAvailablity('" + obj.ActualDate + "'))\"></td>";
                            }
                        });
                        strHTML += "</tr>";
                    }
                    // $("#tblAssignColor").html(strHTML1);
                    // $('#MInfraListTbl').dataTable().fnDestroy();
                    $("#tblassignments").html(strHTML);
                    openAssigmentsAvailablity(null);
                    //LoadPagination(data);
                    //StopAjaxLoader("#body-ResRequest");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-ResRequest");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-ResRequest");
                }
                 //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }

        function openAssigmentsAvailablity(actualDate) {
            var date = new Date(actualDate);
            date = ((date.getMonth() > 8) ? (date.getMonth() + 1) : ('0' + (date.getMonth() + 1))) + '/' + ((date.getDate() > 9) ? date.getDate() : ('0' + date.getDate())) + '/' + date.getFullYear();
            var strHTML = "";
            // tdDate = "12/06/2020";
            objAssign = { "InfraResourceId": $("#hdnResourceId").val(), "ActualDate": date }
            // objAssign = { "InfraResourceId": 1, "ActualDate": tdDate }
            $.ajax({
                url: strUrl + '/api/RM_InfraResources/GetProjectsAssignments',
                type: "POST",
                data: JSON.stringify(objAssign),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objAssign) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objAssign) ? objAssign : JSON.stringify(objAssign)));
                    }
                },
                success: function (data) {
                    var List = data;
                    // console.log("assgList", List);
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            strHTML += "<tr><td>" + obj.ProjectName + " </td><td>" + obj.AllocatedQuantity + " </td><td>" + obj.StartDate + "</td><td>" + obj.EndDate + "</td><td>" + obj.CostPerHour + "</td><td>" + obj.RatePerHour + "</td></tr>";

                        });
                        strHTML += "</tr>";
                    }
                    $('#AssignmentGridTble').dataTable().fnDestroy();
                    $("#AstmntGrid1").html(strHTML);
                    LoadAssPagination(data);
                    //StopAjaxLoader("#body-ResRequest");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-ResRequest");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-ResRequest");
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
        function cancledetailpanelMain() {
            infraResourceRequest = {};
            //$("#hdnOROpportunityId").val(0);
            document.getElementById('txtInfraName').value = "";
            document.getElementById('txtDescription').value = "";
            document.getElementById('txtDescription').value = "";
            document.getElementById('txtMaxAllocation').value = "";
            document.getElementById('txtAvailableFrom').value = "";
            document.getElementById('txtAvailableTill').value = "";
            document.getElementById('txtRetiredOn').value = "";
            document.getElementById('txtCostPerhr').value = "";
            document.getElementById('txtRatePerhr').value = "";
            document.getElementById('txtTotalCostofAcquisition').value = "";
            document.getElementById('txtDepreciationRate').value = "";
            document.getElementById('txtNoOfLicenses').value = "";

            $("#cboBG").val("");
            $("#cboOU").val("");
            $("#cboInfraType").val("");
            $("#cboInfraStatus").val("");
            $("#cboInfraGroup").val("");
            //$("#cboSharedResource").val("");
            FillBG(0);
            FillOU(0);
        }
        
        function checkValidation() {
            var currentDate = new Date();
            var availableFrom = new Date($("#txtAvailableFrom").val());
            var availableTill = new Date($("#txtAvailableTill").val());
            var retiredOn = new Date($("#txtRetiredOn").val());
            var depRate = parseFloat($("#txtDepreciationRate").val());
            var ratePerHr = parseFloat($("#txtRatePerhr").val());
            var costPerHr = parseFloat($("#txtCostPerhr").val());
            var totalcofacq = parseFloat($("#txtTotalCostofAcquisition").val());
            var totalquan = parseFloat($("#txtNoOfLicenses").val());

            ///Added By Reshma Chavan on 1st Feb 2022 for Restrict Total Quantity
            var resourceID = $("#hdnResourceId").val();
            var Description = $("#txtDescription").val();
            var MaxAvailableLicences = 0;
            if (resourceID != "0") {
                MaxAvailableLicences = GetMaxAvailableLicences(resourceID);
            }
            //End of Added By Reshma Chavan on 1st Feb 2022 for Restrict Total Quantity
            if ($("#txtInfraName").val() == undefined || $("#txtInfraName").val() == "") {
                $("#txtInfraName").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("'Infra Name' should not left blank.");
                alertify.error("'Infrastructure Name' should not left blank.");
                return false;
            }
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
            else if (checkSpecialCharacter(Description, WebConfigSpecialCharacters) == true) {
                checkval = 1;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $(ControlValidationFieldID[i]).focus()
                $("#txtDescription").focus();
                return false
            }


            else if ($("#cboInfraType").val() == undefined || $("#cboInfraType").val() == "" || $("#cboInfraType").val() == 0) {
                $("#cboInfraType").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("'Infra Type' should not left blank.");
                alertify.error("'Infrastructure Type' should not left blank.");
                return false;
            }
            else if ($("#cboInfraGroup").val() == undefined || $("#cboInfraGroup").val() == "" || $("#cboInfraGroup").val() == 0) {
                $("#cboInfraGroup").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("'Infra Group' should not left blank.");
                alertify.error("'Infrastructure Group' should not left blank.");
                return false;
            }
            else if ($("#cboBG").val() == undefined || $("#cboBG").val() == "" || $("#cboBG").val() == 0) {
                $("#cboBG").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Business Group' should not left blank.");
                return false;
            }
            else if ($("#cboOU").val() == undefined || $("#cboOU").val() == "" || $("#cboOU").val() == 0) {
                $("#cboOU").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Organization Unit' should not left blank.");
                return false;
            }
            else if ($("#txtMaxAllocation").val() == undefined || $("#txtMaxAllocation").val() == "") {
                $("#txtMaxAllocation").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Max. Allocation Per Day' should not left blank.");
                return false;
            }
            else if ($("#txtMaxAllocation").val() > 24) {
                $("#txtMaxAllocation").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Max. Allocation Per Day' should not greater than 24 hrs.");
                return false;
            }
            else if ($("#cboInfraStatus").val() == undefined || $("#cboInfraStatus").val() == "") {
                $("#cboInfraStatus").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("'Infra Status' should not left blank.");
                alertify.error("'Infrastructure Status' should not left blank.");
                return false;
            }
            else if ($("#txtCostPerhr").val() == undefined || $("#txtCostPerhr").val() == "") {
                $("#txtCostPerhr").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Cost Per Hr.' should not left blank.");
                return false;
            }
            else if ($("#txtRatePerhr").val() == undefined || $("#txtRatePerhr").val() == "") {
                $("#txtRatePerhr").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Rate Per Hr.' should not left blank.");
                return false;
            }
            else if (ratePerHr < costPerHr) {
                $("#txtCostPerhr").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Cost Per Hr.' Should Not be greater than 'Rate Per Hr'.");
                return false;
            }
            else if (costPerHr != null && costPerHr > 999.99) {
                $("#txtCostPerhr").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Cost per hrs should not greater than 999.99");
                return false;
            }
            else if (ratePerHr != null && ratePerHr > 999.99) {
                $("#txtRatePerhr").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Rate per hrs should not greater than 999.99");
                return false;
            }
            else if (totalcofacq != '' && totalcofacq < costPerHr) {
                //alert(totalcofacq);
                $("#txtTotalCostofAcquisition").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Total Cost of Acquisition' Should be greater than 'Cost Per Hr'.");
                return false;
            }
            else if (totalcofacq != null && totalcofacq > 999999999.99) {
                $("#txtTotalCostofAcquisition").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Total Cost of Acquisition should not greater than 999999999.99");
                return false;
            }
            else if ($("#txtDepreciationRate").val() > 100) {
                $("#txtDepreciationRate").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                ///changed by mahesh on 29 july 2021
                alertify.error("'Depreciation Rate' Should not be more than 100%.");
                ///changed by mahesh on 29 july 2021
                return false;
            }
            ///commented by mahesh on 28 july 2021
            //else if (depRate != null && depRate > 99.9) {
            //    $("#txtDepreciationRate").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("Depreciation Rate should not greater than 99.9");
            //    return false;
            //}

            //else if ($("#txtAvailableTill").val() == undefined || $("#txtAvailableTill").val() == "") {
            //    $("#txtAvailableTill").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("'Available Till' should not left blank. ");
            //    return false;
            //}
            else if ($("#txtAvailableFrom").val() == undefined || $("#txtAvailableFrom").val() == "") {
                $("#txtAvailableFrom").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Available From' should not left blank. ");
                return false;
            }
            else if (availableFrom > availableTill) {
                $("#txtAvailableFrom").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Available From' Should not be greater than 'Available Till'.");
                return false;
            }
            else if (availableTill < availableFrom) {
                $("#txtAvailableTill").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Available Till' Should not be less than 'Available from'.");
                return false;
            }
            else if (retiredOn > availableTill) {
                $("#txtRetiredOn").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Retired On' Should not be greater than 'Available Till'.");
                return false;
            }
            else if ($("#txtNoOfLicenses").val() == undefined || $("#txtNoOfLicenses").val() == "") {
                $("#txtNoOfLicenses").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Total Quantity/No. of Licenses' should not left blank.");
                return false;
            }
            //else if (totalquan != null && totalquan.match(/^(-?\d*)((\.(\d{0,2})?)?)$/i) == null) {
            //    $("#txtNoOfLicenses").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("Please enter numbers only in the field Total Quantity/No. of Licenses");
            //    return false;
            //}
                //Added By Rutuja D. For Validation Missing on 20 Oct 2021
            else if ($("#txtMaxAllocation").val() == 0 || $("#txtMaxAllocation").val() < 0) {                
                    $("#txtMaxAllocation").focus();
                    validateflag = false;
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Max Allocation Per Day must be greater than 0");
                    return false;
                
            }
            else if ($("#txtNoOfLicenses").val() == 0 || $("#txtNoOfLicenses").val() < 0) {                
                    $("#txtNoOfLicenses").focus();
                    validateflag = false;
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Total Quantity must be greater than 0");
                    return false;
                
            }
                //End of Added By Rutuja D. For Validation Missing on 20 Oct 2021
                //Added By Reshma Chavan on 13th Dec 2021 For Validation Missing decimal value
            else if ($("#txtNoOfLicenses").val().indexOf(".") > -1) {                
                    $("#txtNoOfLicenses").focus();
                    validateflag = false;
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Total Quantity must be Positive Integer value");
                    return false;
                
            }
                //End of Added By Reshma Chavan on 13th Dec 2021 For Validation Missing decimal value
            //Added By Reshma Chavan on 1st Feb 2022 for Restrict Total Quantity
            else if (parseFloat(MaxAvailableLicences) > parseFloat($("#txtNoOfLicenses").val())) {
                    $("#txtNoOfLicenses").focus();
                    validateflag = false;
                    alertify.set('notifier', 'position', 'top-right');
                    //Commented And Added By Reshma chavan on 11 feb 2022 to add count in alert itself
                    //alertify.error("Total Quantity must be Greater than Max Requested Quantity.");
                    alertify.error("Total Quantity must be Greater than Max Requested Quantity " + parseFloat(MaxAvailableLicences) + ".");
                    return false;
            }  
            //End of Added By Reshma Chavan on 1st Feb 2022 for Restrict Total Quantity
            else {
                validateflag = true;
                return true;
            }
        }

        //Added By Reshma Chavan on 1st Feb 2022 For getting validation
        function GetMaxAvailableLicences(infraResourceID) {
            var param = JSON.stringify(infraResourceID);
            var MaxAvailableLicences = AJAXCallWithResult("/api/RM_InfraResources/GetMaxAvailableLicences", param, false);
            return MaxAvailableLicences;
           
        }

        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {

            $.ajax({
                url: encodeURI(strUrl + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;
                   
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }

        //End of Added By Reshma Chavan on 1st Feb 2022 For getting validation
        var validateflag
        function saveResource(isFromSaveClick) {
            var resourceID = $("#hdnResourceId").val();
            checkValidation();
            if (validateflag == true) {
                infraResourceRequest.InfraName = $("#txtInfraName").val().replace(/'/g, "''");
                infraResourceRequest.Description = $("#txtDescription").val().replace(/'/g, "''");
                if ($("#IsActive").is(':checked')) {
                    infraResourceRequest.IsActive = 1;
                } else {
                    infraResourceRequest.IsActive = 0;
                }
                infraResourceRequest.InfraTypeId = $("#cboInfraType").val();
                infraResourceRequest.InfraGroupId = $("#cboInfraGroup").val();
                infraResourceRequest.BusinessGroupID = $("#cboBG").val();
                infraResourceRequest.LocationID = $("#cboOU").val();
                var maxallocaton = $("#txtMaxAllocation").val();
                infraResourceRequest.MaxAllocationPerDay = parseFloat(maxallocaton);
                infraResourceRequest.InfraStatusId = $("#cboInfraStatus").val();
                infraResourceRequest.TotalQuantity = $("#txtNoOfLicenses").val();
                var costperhr = $("#txtCostPerhr").val();
                infraResourceRequest.CostPerHour = parseFloat(costperhr);
                var rateperhr = $("#txtRatePerhr").val();
                infraResourceRequest.RatePerHour = parseFloat(rateperhr);
                var costofAcq = $("#txtTotalCostofAcquisition").val();
                
                if ($("#txtTotalCostofAcquisition").val() == "") {
                    infraResourceRequest.TotalCostOfAcquisition = 0;
                }
                else {
                    infraResourceRequest.TotalCostOfAcquisition = parseFloat(costofAcq);
                }
                if ($("#txtDepreciationRate").val() == "" || $("#txtDepreciationRate").val() == null) {
                    var depreciationrate = 0;
                }
                else {
                    var depreciationrate = $("#txtDepreciationRate").val();
                }                
                infraResourceRequest.DepreciationRate = parseFloat(depreciationrate);
                // infraResourceRequest.DepreciationRate = $("#txtDepreciationRate").val();
                infraResourceRequest.AvaliableFrom = $("#txtAvailableFrom").val();
                infraResourceRequest.AvaliableTill = $("#txtAvailableTill").val();
                infraResourceRequest.RetiredOn = $("#txtRetiredOn").val();
                //infraResourceRequest.Shared = $("#cboSharedResource").val();
                infraResourceRequest.CreatedBy = UserName;

                if (resourceID > 0 && resourceID != undefined) {
                    infraResourceRequest.InfraResourceId = resourceID;
                }
                else {
                    infraResourceRequest.InfraResourceId = 0;
                }
                $.ajax({
                    url: strUrl + '/api/RM_InfraResources/AddOrUpdate',
                    type: "POST",
                    data: JSON.stringify(infraResourceRequest),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (infraResourceRequest) {
                            xhr.setRequestHeader("Params", encryptString(isJson(infraResourceRequest) ? infraResourceRequest : JSON.stringify(infraResourceRequest)));
                        }
                    },
                    success: function (data) {
                        //console.log(data);
                        if (data.Status == "Active") {
                            if (isFromSaveClick == 0) {
                                $("#hdnResourceId").val(data.InfraResourceId);
                                GetResourceRequest();
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data.Message);
                                $('#tabRenewalTransactions').removeClass("DisableContent");
                                $('#tabAssignments').removeClass("DisableContent");
                                $("#MInfraListTbl_wrapper .dataTables_scrollBody,.MInfratblouter,.srchrequest, .weekly_calender, .backbtn, .addbtn, #MInfraListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter,.mainclearalllink").addClass("DisableContent").parent().css("cursor", "no-drop");

                            }
                            if (isFromSaveClick == 1) {
                                cancledetailpanelMain();
                                $("#hdnResourceId").val(0);
                                $('#tabRenewalTransactions').addClass("DisableContent");
                                $('#tabAssignments').addClass("DisableContent");
                                GetResourceRequest();
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data.Message);
                                // $("#ORListTbl_wrapper .dataTables_scrollBody,.OPRtblouter,.backbtn, .paginate_button, .deletebtn, .filter,.addlistbtn,.search-query, .graybg .filter, .graybg .filedownload").addClass("DisableContent").parent().css("cursor", "no-drop");
                                $("#MInfraListTbl_wrapper .dataTables_scrollBody,.MInfratblouter, .srchrequest, .weekly_calender, .backbtn, .addbtn, #MInfraListTbl_wrapper .paginate_button, .uploadExlbtn, .deletebtn, .filedownload, .filter,.mainclearalllink").addClass("DisableContent").parent().css("cursor", "no-drop");

                            }
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data.Status);
                        }

                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (xhr, ajaxOptions, thrownError) {
                    //    if (ajaxOptions == "error") {
                    //        console.log(thrownError);
                    //        alertify.set('notifier', 'position', 'top-right');
                    //        alertify.notify(xhr.responseJSON.Message);
                    //    }
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
                     //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                })
            }
            else {
                return false;
            }
        }
        var InfraResourceRequests = [];
        function GetResourceRequest(FilterParms) {
            var strHTML = "";
            
            InfraResourceRequests = [];
             //Commented & Added By Chetan M on 20 July 2021 For IssueID=27067
            if (FilterParms == null) {
                FilterParms = "";
            }
            //var varResReq = { WhereClause: FilterParms }
            var varResReq = { WhereClause: encodeURIComponent(FilterParms) }
            //End of Commented & Added By Chetan M on 20 July 2021 For IssueID=27067
            StartLoader("#body-ResRequest");
            $.ajax({
                url: strUrl + '/api/RM_InfraResources/GetAll',
                type: "POST",
                data: JSON.stringify(varResReq),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (varResReq) {
                        xhr.setRequestHeader("Params", encryptString(isJson(varResReq) ? varResReq : JSON.stringify(varResReq)));
                    }
                },
                success: function (data) {
                    //   console.log(data);
                    if (data != null) {
                        InfraResourceRequests = data;
                        if (InfraResourceRequests.length > 0) {
                            ReloadTableSearchForInfraResources(InfraResourceRequests);
                            $("#MInfraListTbl_wrapper .dataTables_scrollBody, .weekly_calender").removeClass("DisableContent").parent().css("cursor", "no-drop");

                        } else {
                            ReloadTableSearchForInfraResources();
                            $("#MInfraListTbl_wrapper .dataTables_scrollBody, .weekly_calender").removeClass("DisableContent").parent().css("cursor", "no-drop");

                        }
                    }
                    StopAjaxLoader("#body-ResRequest");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-ResRequest");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-ResRequest");
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })

        }

        function InfraResourceGetByID(resourceId) {
            //alert(resourceId);
            //StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_InfraResources/GetById',
                type: "POST",
                data: JSON.stringify(resourceId),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (resourceId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(resourceId) ? resourceId : JSON.stringify(resourceId)));
                    }
                },
                success: function (data) {
                    var infraData = data;
                    //  console.log("infraData", infraData);
                    $("#txtInfraName").val(infraData.InfraName);
                    $("#txtDescription").val(infraData.Description);
                    if (infraData.IsActive == true) {
                        $('[id="IsActive"]').prop("checked", true);
                    }
                    else {
                        $('[id="IsActive"]').prop("checked", false);
                    }
                    $("#cboInfraType").val(infraData.InfraTypeId);
                    $("#cboInfraGroup").val(infraData.InfraGroupId);
                    $("#cboBG").val(infraData.BusinessGroupID);
                    $("#cboOU").val(infraData.LocationID);
                    $("#txtValidTillDate").val(infraData.CoolingOf);
                    $("#txtMaxAllocation").val(infraData.MaxAllocationPerDay);
                    $("#cboInfraStatus").val(infraData.InfraStatusId);
                    $("#txtNoOfLicenses").val(infraData.TotalQuantity);
                    $("#txtCostPerhr").val(infraData.CostPerHour);
                    $("#txtRatePerhr").val(infraData.RatePerHour);
                    $("#txtTotalCostofAcquisition").val(infraData.TotalCostOfAcquisition);
                    $("#txtDepreciationRate").val(infraData.DepreciationRate);
                    $("#txtAvailableFrom").val(infraData.AvaliableFrom);
                    if (infraData.AvaliableTill == "01 January 1900") {
                        infraData.AvaliableTill = " ";
                    }
                    else {
                        $("#txtAvailableTill").val(infraData.AvaliableTill);
                    }
                    if (infraData.RetiredOn == "01 January 1900") {
                        infraData.RetiredOn = " ";
                    }
                    else {
                        $("#txtRetiredOn").val(infraData.RetiredOn);
                    }
                    // $("#cboSharedResource").val(infraData.Shared);
                    FillBG(0, infraData.BusinessGroupID);
                    FillOU(infraData.BusinessGroupID, infraData.LocationID);
                    FillInfraType(infraData.InfraTypeId);
                    FillInfraGroup(infraData.InfraGroupId);
                    FillInfraStatus(infraData.InfraStatusId);
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
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
                 //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });

        }
        function DeleteResourceRequest(resourceID) {
            $.ajax({
                url: strUrl + '/api/RM_InfraResources/DeleteInfraRequest',
                type: "POST",
                data: JSON.stringify(resourceID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    // StartLoader("#bodyBusiness-group");
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (resourceID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(resourceID) ? resourceID : JSON.stringify(resourceID)));
                    }
                },
                success: function (data) {
                    if (data != "") {
                        if (data.includes("deleted successfully")) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                            $("#MInfraListTbl_wrapper .dataTables_scrollBody, .weekly_calender,  #MInfraListTbl_wrapper .paginate_button").addClass("DisableContent").parent().css("cursor", "no-drop");

                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $("#MInfraListTbl_wrapper .dataTables_scrollBody, .weekly_calender, .backbtn, .addbtn, #MInfraListTbl_wrapper .paginate_button,").addClass("DisableContent").parent().css("cursor", "no-drop");

                        }

                        // alert(data);
                    }
                    GetResourceRequest();
                    //StopAjaxLoader("#bodyBusiness-group");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (xhr, ajaxOptions, thrownError) {
                //    if (ajaxOptions == "error") {
                //        console.log(thrownError);
                //        alertify.set('notifier', 'position', 'top-right');
                //        alertify.error(xhr.responseJSON.Message);
                //    }
                //    else if (xhr.statusText == "OK") {  //200
                //        //CurrentTabObject.Manager = 'false';

                //    }
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
                 //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
        function convert(str) {
            var date = new Date(str),
                mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                day = ("0" + date.getDate()).slice(-2);
            return [date.getFullYear(), mnth, day].join("-");
        }
        function infraHistory() {
            var strHTML = "";
            StartLoader("#body-LoaderHistory");
            var resourceID = $("#hdnResourceId").val();
            $.ajax({
                url: strUrl + '/api/RM_InfraResources/GetHistory',
                type: "POST",
                data: JSON.stringify(resourceID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (resourceID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(resourceID) ? resourceID : JSON.stringify(resourceID)));
                    }
                },
                success: function (data) {
                    var List = data;
                    //  console.log("hList", List);
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            var old = "";
                            var new1 = "";
                            console.log(obj.OldValue);
                            if (obj.OldValue == "Jan  1 1900 12:00AM" || obj.OldValue === null) {
                                old = "";
                            }
                            else {
                                old = obj.OldValue;
                            }
                            if (obj.NewValue == "Jan  1 1900 12:00AM" || obj.NewValue === null) {
                                new1 = "";
                            }
                            else {
                                new1 = obj.NewValue;
                            }
                            if (obj.FieldName == "IsActive") {
                                if (obj.OldValue == 1) {
                                    old = "Yes";
                                }
                                else {
                                    old = "No";
                                }
                                if (obj.NewValue == 1) {
                                    new1 = "Yes";
                                }
                                else {
                                    new1 = "No";
                                }
                            }
                            // Commented & Added BY Rutuja D. on 14 Dec 2021 For Change the Date Format
                            //strHTML += "<tr><td>" + obj.FieldName + " </td><td>" + old + " </td><td>" + new1 + "</td><td>" + formatDateWithTime(new Date(obj.CreatedDate)) + "</td><td>" + obj.CreatedBy + "</td></tr>";
                            strHTML += "<tr><td>" + obj.FieldName + " </td><td>" + old + " </td><td>" + new1 + "</td><td>" + obj.CreatedDate + "</td><td>" + obj.CreatedBy + "</td></tr>";
                            //End Commented & Added BY Rutuja D. on 14 Dec 2021 For Change the Date Format

                        });
                    }

                    $('#emsubtabShowHistoryTbl').dataTable().fnDestroy();
                    $("#emsubtabShowHistoryTblMain").html(strHTML);
                    LoadHistoryPagination(data);
                    StopAjaxLoader("#body-LoaderHistory");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-LoaderHistory");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-LoaderHistory");
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
        function FillFilterOUForFilter(params) {
            var strHTML = "";
            var BgID = $('#txtResourceFilterBusinessGroupID').val();
            if (BgID == "") {
                BgID = 0;
            }
            var objBGCODE = { BusinessGroupID: BgID }
            //if (BgID != "" && BgID > 0) {
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/GetOrgUnitForFilter',
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
                    //$("#cboOPRFilterLocationID").empty();
                    strHTML += "<option value='0'>Select Organization Unit</option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    }
                    if (params != null && params > 0 && params != undefined)
                        $("#txtResourceFilterLocationID").val(params);

                    $("#txtResourceFilterLocationID").html(strHTML);

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
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyBusiness-group");
                }
                 //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })

            //}
        }
        function FillBG(value, param) {
            var strHTML = "";
            FillOU(0);
            
            //if (value > 0) {
            if ($("#hdnResourceId").val() == "") {
                var objOU = { BusinessGroupID: value, ResourceID: 0 }
            }
            else {
                var objOU = { BusinessGroupID: value, ResourceID: $("#hdnResourceId").val() }
            }
            
            $.ajax({
                url: strUrl + '/api/RM_InfraResources/GetBusinessGroups',
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
                    //Commented and added by Chetan M on 20 Jul 2021 for adding placeholder
                    //strHTML += "<option value='0'></option>";
                    strHTML += "<option value='0'>Select Business Group</option>";
                    //End of Commented and added by Chetan M on 20 Jul 2021 for adding placeholder
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.BusinessGroupID + ' >' + listComponent.BusinessGroup + '</option>');
                    }
                    $("#cboBG").html(strHTML);
                    if (param != null && param > 0 && param != undefined) {
                        $("#cboBG").val(param);
                    }
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
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyBusiness-group");
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }

        function FillOU(value, param, isChange) {
            var strHTML = "";
            //FillDU(0);
            // FillDT(0);
            if (value > 0) {
                if (isChange == 2) {
                    var objOU = { BusinessGroupID: value }
                }
                else {
                    var objOU = { BusinessGroupID: value, ResourceID: $("#hdnResourceId").val() }
                }

                $.ajax({
                    url: strUrl + '/api/RM_InfraResources/GetBusinessGroupsLocation',
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
                        //Commented and added by Chetan M on 20 Jul 2021 for adding placeholder
                        //strHTML += "<option value='0'></option>";
                        strHTML += "<option value='0'>Select Organization Unit</option>";
                        //End of Commented and added by Chetan M on 20 Jul 2021 for adding placeholder
                        for (var i = 0; i < data.length; i++) {
                            var listComponent = data[i];
                            strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');
                        }
                        $("#cboOU").html(strHTML);
                        if (param != null && param > 0 && param != undefined) {
                            $("#cboOU").val(param);
                        }


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
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyBusiness-group");
                    }
                     //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                })
            }
            else {
                //Added by Reshma on 04-01-2022
                strHTML += "<option value='0'>Select Organization Unit</option>";
                //End comment on 04-01-2022
                $("#cboOU").html(strHTML);
            }


        }
        //Add Renewal
        var infraRenewal = {
            InfraRenewalId: "", InfraResourceId: "", TotalQuantity: "", TypeOfSubscription: "", BillingPeriod: "",
            DateOfRenewal: "", CurrencyId: "", Amount: "", NextBillingDate: "", CreatedBy: ""
        };

        function openRenewalTransactions() {
            GetRenewals();
        }

        //2 decimal places
        $('#txtDepreciationRate').keypress(function (event) {
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
        $('#txtNoOfLicenses').keypress(function (event) {
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

        $('#txtRatePerhr').keypress(function (event) {
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
        $('#txtCostPerhr').keypress(function (event) {
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
        $('#txtAmount').keypress(function (event) {
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
        $('#txtTotalCostofAcquisition').keypress(function (event) {
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
        $('#txtMaxAllocation').keypress(function (e) {
            var keyCode = e.which ? e.which : e.keyCode
            if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {           
                e.preventDefault();
            }
        });

        var validateflagRenew
        function saveRenewalTransaction() {
            var resourceID = $("#hdnResourceId").val();

            if (resourceID == "") {
                resourceID = 0;
            }
            checkValidationRenew();
            if (validateflagRenew == true) {
               // debugger;
                infraRenewal.InfraResourceId = resourceID;
                infraRenewal.InfraRenewalId = 0;
                infraRenewal.TypeOfSubscription = $("#cboTypeSubscription").val();
                infraRenewal.BillingPeriod = $("#cboBillingPeriod").val();
                infraRenewal.DateOfRenewal = $("#txtDateOfRenewal").val();
                infraRenewal.TotalQuantity = $("#txtTotalQuantity").val();
                infraRenewal.CurrencyId = $("#cboCurrency").val();
                infraRenewal.Amount = parseFloat($("#txtAmount").val());
                infraRenewal.NextBillingDate = $("#txtNextBillingDate").val();
                infraRenewal.CreatedBy = UserName;
                 console.log("infraRenewal", infraRenewal);
                $.ajax({
                    url: strUrl + '/api/RM_InfraResources/AddRenewal',
                    type: "POST",
                    data: JSON.stringify(infraRenewal),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (infraRenewal) {
                            xhr.setRequestHeader("Params", encryptString(isJson(infraRenewal) ? infraRenewal : JSON.stringify(infraRenewal)));
                        }
                    },
                    success: function (data) {
                        console.log(data);
                        $('#addRenewalModal').modal('hide');
                        GetRenewals();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("Renewal Transaction Added Succesfully.");
                        clearRenewals();
                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (xhr, ajaxOptions, thrownError) {
                    //    if (ajaxOptions == "error") {
                    //        console.log(thrownError);
                    //        alertify.set('notifier', 'position', 'top-right');
                    //        alertify.notify(xhr.responseJSON.Message);
                    //    }
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
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                })
            }
            else {
                return false;
            }
        }

        function clearRenewals() {
            document.getElementById('txtDateOfRenewal').value = "";
            document.getElementById('txtTotalQuantity').value = "";
            document.getElementById('txtAmount').value = "";
            document.getElementById('txtNextBillingDate').value = "";
            $("#cboTypeSubscription").val("");
            $("#cboBillingPeriod").val("");
            //Commented and Added By Reshma Chavan on 7th Dec 2021 for duplicate placeholder change
            //$("#cboCurrency").val("");
            $("#cboCurrency").val(0);
            //End of Commented and Added By Reshma Chavan on 7th Dec 2021 for duplicate placeholder change
        }
        function checkValidationRenew() {
            var currentDate = new Date();
            var fromDate = new Date($("#txtAvailableFrom").val())
            var availableFrom = new Date($("#txtDateOfRenewal").val());
            var availableTill = new Date($("#txtAvailableTill").val());
            var retiredOn = new Date($("#txtRetiredOn").val());
            var quantity = $("#txtTotalQuantity").val();
            var amt = parseFloat($("#txtAmount").val());

            if ($("#cboTypeSubscription").val() == undefined || $("#cboTypeSubscription").val() == "") {
                $("#cboTypeSubscription").focus();
                validateflagRenew = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Type of Subscription' should not left blank.");
                return false;
            }

            else if ($("#cboBillingPeriod").val() == undefined || $("#cboBillingPeriod").val() == "" || $("#cboBillingPeriod").val() == 0) {
                $("#cboBillingPeriod").focus();
                validateflagRenew = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Billing Period' should not left blank.");
                return false;
            }
            else if ($("#txtDateOfRenewal").val() == undefined || $("#txtDateOfRenewal").val() == "") {
                $("#txtDateOfRenewal").focus();
                validateflagRenew = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Date of Renewal' should not left blank.");
                return false;
            }
            else if (availableFrom <= fromDate) {
                $("#txtDateOfRenewal").focus();
                validateflagRenew = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Date of Renewal' should be greater than Available From Date.");
                return false;
            }
            else if ($("#txtTotalQuantity").val() == undefined || $("#txtTotalQuantity").val() == "") {
                $("#txtTotalQuantity").focus();
                validateflagRenew = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Total Quantity/No. of Licenses' should not left blank.");
                return false;
            }
            else if (quantity != null && quantity.match(/^(-?\d*)((\.(\d{0,2})?)?)$/i) == null) {
                $("#txtTotalQuantity").focus();
                validateflagRenew = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter numbers only in the field 'Total Quantity/No. of Licenses'.");
                return false;
            }
            else if ($("#cboCurrency").val() == undefined || $("#cboCurrency").val() == "" || $("#cboCurrency").val() == 0) {
                $("#cboCurrency").focus();
                validateflagRenew = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Currency' should not left blank.");
                return false;
            }
            else if ($("#txtAmount").val() == undefined || $("#txtAmount").val() == "") {
                $("#txtAmount").focus();
                validateflagRenew = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Amount' should not left blank.");
                return false;
            }
            else if ($("#txtAmount").val() != null && $("#txtAmount").val() > 99999999999.99) {
                $("#txtAmount").focus();
                validateflagRenew = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Amount' should not be greater than 99999999999.99");
                return false;
            }
            //Added By Rutuja D. on 13 Oct 2021 For Validation Missing
            else if (Date.parse($('#txtDateOfRenewal').val()) > Date.parse($('#txtNextBillingDate').val())) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Next Billing Date' should not be less than 'Date of Renewal' ");
                $("#txtNextBillingDate").focus();
                validateflagRenew = false;
                return false;
            }

            else if ($("#txtTotalQuantity").val() == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Total Quantity / No. of Licenses' must be grater than 0.");
                $("#txtTotalQuantity").focus();
                validateflagRenew = false;
                return false;
            }
             else if ($("#txtAmount").val() == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Amount' must be grater than 0.");
                $("#txtAmount").focus();
                validateflagRenew = false;
                return false;
            }
                //End of Added By Rutuja D. on 13 Oct 2021 For Validation Missing

            else {
                validateflagRenew = true;
                return true;
            }
        }
        function GetRenewals() {
            var resourceID = $("#hdnResourceId").val();
            var strHTML = "";
            StartLoader("#body-Renewal");
            //var where = {ProWhereClause:PROFilterParms.ProWhereClause}
            $.ajax({
                url: strUrl + '/api/RM_InfraResources/GetRenewals',
                type: "POST",
                data: JSON.stringify(resourceID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (resourceID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(resourceID) ? resourceID : JSON.stringify(resourceID)));
                    }
                },
                success: function (data) {
                    var List = data;
                    // console.log("RList", List);
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            var billingDate;
                            if (obj.NextBillingDate == "01 January 1900") {
                                billingDate = "";
                            } else {
                                billingDate = obj.NextBillingDate;
                            }
                            strHTML += "<tr><td>" + obj.TypeOfSubscription + " </td><td>" + obj.BillingPeriod + " </td><td>" + obj.DateOfRenewal + "</td><td>" + billingDate + "</td><td>" + obj.Amount + "</td><td>" + obj.TotalQuantity + "</td><td>" + obj.CurrencyName + "</td></tr>";//Changed By Rutuja D. For IssueID = 29420

                        });
                    }

                    $('#RTsubtabShowHistoryTbl').dataTable().fnDestroy();
                    $("#RTsubtabShowHistoryTblMain").html(strHTML);
                    LoadRenewalPagination(data);
                    $(".table").resize();//Added By Rutuja D. on 23 July 2021 For Alignment disturb
                    StopAjaxLoader("#body-Renewal");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-Renewal");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-Renewal");
                }
                 //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })

        }
        //datatable
        function LoadAssPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            resourceTable = $('#AssignmentGridTble').dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": true,
                "scrollResize": true,
                "scrollcollapse": true,
                "iDisplayLength": 10,
                "lengthChange": false,
                "searching": false,
                "destroy": true,
                //Added by imran on 19-08-2022
                pageLength: 10,
                //End of comment by imran on 19-08-2022
            });

        }
         //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
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
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            resourceTable = $('#MInfraListTbl').dataTable({
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
        function LoadHistoryPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            resourceTable = $('#emsubtabShowHistoryTbl').dataTable({
                "dtat": data,
                 "sscrolly": (0.6 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": 5,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                "lengthChange": false,
                "searching": false,
                "ordering": false,//Added By Rutuja D. on 14 Feb 2021 For History Table Ordering False
            });

        }

        function LoadRenewalPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            resourceTable = $('#RTsubtabShowHistoryTbl').dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": true,
                "scrollResize": true,
                "scrollcollapse": true,
                "iDisplayLength": 5,
                "lengthChange": false,
                "searching": false,
                "destroy": true,
            });

        }

        function LoadXlsxPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            resourceTable = $('#exluploadTbl').dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": true,
                "scrollResize": true,
                "scrollcollapse": true,
                "iDisplayLength": 10,
                "lengthChange": false,
                "searching": false,
                "destroy": true,
            });

        }

        function validateDecimal(value) {
            //alert(value);
            var RE = "^\d*\.?\d{ 0, 2 } $";
            if (RE.test(value)) {
                return true;
            } else {
                return false;
            }
        }
        // FilterDetails
        function ApplyFilter() {
            var filterFlag = true;
            var InfraName = $("#txtResourceFilterInfraName").val() == "" ? null : $("#txtResourceFilterInfraName").val();
            var RtrdOn = $("#txtResourceFilterRetiredOn").val() == "" ? null : $("#txtResourceFilterRetiredOn").val();
            var typeId = $("#txtResourceFilterInfraTypeId").val() == "" ? null : $("#txtResourceFilterInfraTypeId").val();
            var grpID = $("#txtResourceFilterInfraGroupId").val() == "" ? null : $("#txtResourceFilterInfraGroupId").val();
            var bgID = $("#txtResourceFilterBusinessGroupID").val() == "" ? null : $("#txtResourceFilterBusinessGroupID").val();
            var locationID = $("#txtResourceFilterLocationID").val() == "" ? null : $("#txtResourceFilterLocationID").val();
            var statusID = $("#txtResourceFilterInfraStatusId").val() == "" ? null : $("#txtResourceFilterInfraStatusId").val();

            if ((InfraName == null || InfraName == 'undefined' || InfraName == ' ') && (RtrdOn == null || RtrdOn == 'undefined' || RtrdOn == ' ') && (typeId == null || typeId == 'undefined' || typeId == 0 || typeId == ' ') && (grpID == null || grpID == 'undefined' || grpID == 0 || grpID == ' ') && (bgID == null || bgID == 'undefined' || bgID == 0 || bgID == ' ') && (locationID == null || locationID == 'undefined' || locationID == 0 || locationID == ' ') && (statusID == null || statusID == 'undefined' || statusID == 0 || statusID == ' ')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                filterFlag = false;
                return false;
            }
            if (filterFlag == true) {
                currentFilterID = 0;
                var filter = "";
                var AllInfraResFilter = ["InfraName", "RetiredOn", "InfraTypeId", "InfraGroupId", "BusinessGroupID", "LocationID", "InfraStatusId"];
                var filterWhereClause2 = GenerateInfraResourceBasicFilterQuery("Resource", AllInfraResFilter);
                var filterWhereClause = (filterWhereClause2).replace(/"/g, "\'");
               
                //filter = { UniqueID: '0', WhereClause: encodeURIComponent(filterWhereClause) }
                FilterApplied();
                GetResourceRequest(filterWhereClause);
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");

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
            if (arrFields[0] == "InfraName") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboResourceFilterInfraName", "txtResourceFilterInfraName");
            }
            if (arrFields[0] == "RetiredOn") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboResourceFilterRetiredOn", "txtResourceFilterRetiredOn");
            }
            if (arrFields[0] == "InfraTypeId") {
                var currOpToolCategory = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                setFilterComboValue("cboResourceFilterInfraTypeId", currOpToolCategory);
                setFilterComboValue("txtResourceFilterInfraTypeId", currValue);
            }
            if (arrFields[0] == "InfraGroupId") {
                var currOpToolCategory = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                setFilterComboValue("cboResourceFilterInfraGroupId", currOpToolCategory);
                setFilterComboValue("txtResourceFilterInfraGroupId", currValue);
            }
            if (arrFields[0] == "BusinessGroupID") {
                var currOpToolCategory = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                setFilterComboValue("cboResourceFilterBusinessGroupID", currOpToolCategory);
                setFilterComboValue("txtResourceFilterBusinessGroupID", currValue);
            }
            if (arrFields[0] == "LocationID") {
                //var currOpToolCategory = arrFields[1].toString().trim();
                //var currValue = arrFields[2].toString().trim();
                //if (currValue.substring(currValue.length - 1) == "'") {
                //    currValue = currValue.substring(0, currValue.length - 1);
                //}
                //if (currValue.substring(0, 1) == "'") {
                //    currValue = currValue.substring(1);
                //}
                //FillFilterOU(currValue);
                ////$("#cboResourceFilterLocationID").val(currValue);
                //setFilterComboValue("cboResourceFilterLocationID", currOpToolCategory);
                //setFilterComboValue("txtResourceFilterLocationID", currValue);
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboResourceFilterLocationID", "txtResourceFilterLocationID");

            }
            if (arrFields[0] == "InfraStatusId") {
                var currOpToolCategory = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                setFilterComboValue("cboResourceFilterInfraStatusId", currOpToolCategory);
                setFilterComboValue("txtResourceFilterInfraStatusId", currValue);
            }
        }
        function setFilterComboValue(fieldName, fieldValue, flag) {
            $("#" + fieldName).val(fieldValue);
        }
        function setFilterOpComboFieldValue(currWhereClause, arrFields, OpComboName, ValueComboName) {
            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") != -1 && currWhereClause.indexOf("'%") != -1) {
                setFilterComboValue(OpComboName, "Contains");

            }
            if (arrFields[1] == "notlike") {
                setFilterComboValue(OpComboName, "Not Contains");
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

            //Commented & added by mahesh on  27 july 2021
            //$("#" + ValueComboName).val(currValue);
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }

        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtFilterName').val("");
            }
        }
        function ClearFilterDetails(flag) {
            if ($("#cboResourceFilterInfraName").val() != "Contains") {
                setFilterComboValue("cboResourceFilterInfraName", "Contains");
            }
            if ($("#txtResourceFilterInfraName").val() != "") {
                $("#txtResourceFilterInfraName").val("");
            }
            if ($("#cboResourceFilterRetiredOn").val() != "=") {
                setFilterComboValue("cboResourceFilterRetiredOn", "=");
            }
            if ($("#txtResourceFilterRetiredOn").val() != "") {
                $("#txtResourceFilterRetiredOn").val("");
            }
            if ($("#cboResourceFilterInfraTypeId").val() != "=") {
                setFilterComboValue("cboResourceFilterInfraTypeId", "=");
            }
            if ($("#txtResourceFilterInfraTypeId").val() != "") {
                $("#txtResourceFilterInfraTypeId").val("");
            }
            if ($("#cboResourceFilterInfraGroupId").val() != "=") {
                setFilterComboValue("cboResourceFilterInfraGroupId", "=");
            }
            if ($("#txtResourceFilterInfraGroupId").val() != "") {
                $("#txtResourceFilterInfraGroupId").val("");
            }
            if ($("#cboResourceFilterBusinessGroupID").val() != "=") {
                setFilterComboValue("cboResourceFilterBusinessGroupID", "=");
            }
            if ($("#txtResourceFilterBusinessGroupID").val() != "") {
                $("#txtResourceFilterBusinessGroupID").val("");
            }
            if ($("#cboResourceFilterLocationID").val() != "=") {
                setFilterComboValue("cboResourceFilterLocationID", "=");
            }
            if ($("#txtResourceFilterLocationID").val() != "") {
                $("#txtResourceFilterLocationID").val("");
            }
            if ($("#cboResourceFilterInfraStatusId").val() != "=") {
                setFilterComboValue("cboResourceFilterInfraStatusId", "=");
            }
            if ($("#txtResourceFilterInfraStatusId").val() != "") {
                $("#txtResourceFilterInfraStatusId").val("");
            }
            // $("#cboResourceFilterRetiredOn").val("");
            //$("#txtResourceFilterRetiredOn").val("");
            //$("#cboResourceFilterInfraTypeId").val("");
            //$("#txtResourceFilterInfraTypeId").val("");
            // $("#cboResourceFilterInfraGroupId").val("");
            //$("#txtResourceFilterInfraGroupId").val("");
            //$("#cboResourceFilterBusinessGroupID").val("");
            //$("#txtResourceFilterBusinessGroupID").val("");
            //$("#cboResourceFilterLocationID").val("");
            //$("#txtResourceFilterLocationID").val("");
            //$("#cboResourceFilterInfraStatusId").val("");
            //$("#txtResourceFilterInfraStatusId").val("");


            savedFilterName = "";

            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {

                    $(this).removeAttr("checked");
                });
            }

        }
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
            if ($('.filterpanel').hasClass("in")) {
                $('.filterpanel').removeClass("in");
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
            GetInfraResDetails(null);
            //changed by mahesh on 21 july 2021
            GetMyInfraResFilter(0);
            //End changed by mahesh on 21 july 2021
            FillFilterOUForFilter(0);
        });

        function GetInfraResDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                //var whereClauseFormated = whereClause.replace(/'/g, "\''");
                var filter = whereClause.replace(/"/g, "\'");
                /*{ UniqueID: '0', WhereClause: encodeURIComponent(whereClause) };*/
            }
            GetResourceRequest(filter);
        }
        //filter validation
        function checkFiltervalidationForInfraRes() {
            var InfraName = $("#txtResourceFilterInfraName").val() == "" ? null : $("#txtResourceFilterInfraName").val();
            var RtrdOn = $("#txtResourceFilterRetiredOn").val() == "" ? null : $("#txtResourceFilterRetiredOn").val();
            var typeId = $("#txtResourceFilterInfraTypeId").val() == "" ? null : $("#txtResourceFilterInfraTypeId").val();
            var grpID = $("#txtResourceFilterInfraGroupId").val() == "" ? null : $("#txtResourceFilterInfraGroupId").val();
            var bgID = $("#txtResourceFilterBusinessGroupID").val() == "" ? null : $("#txtResourceFilterBusinessGroupID").val();
            var locationID = $("#txtResourceFilterLocationID").val() == "" ? null : $("#txtResourceFilterLocationID").val();
            var statusID = $("#txtResourceFilterInfraStatusId").val() == "" ? null : $("#txtResourceFilterInfraStatusId").val();

            if ((InfraName == null || InfraName == 'undefined' || InfraName == ' ') && (RtrdOn == null || RtrdOn == 'undefined' || RtrdOn == ' ') && (typeId == null || typeId == 'undefined' || typeId == 0 || typeId == ' ') && (grpID == null || grpID == 'undefined' || grpID == 0 || grpID == ' ') && (bgID == null || bgID == 'undefined' || bgID == 0 || bgID == ' ') && (locationID == null || locationID == 'undefined' || locationID == 0 || locationID == ' ') && (statusID == null || statusID == 'undefined' || statusID == 0 || statusID == ' ')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                $('#InfraRessavefilter').modal('hide');
            }
            else {
                $('#InfraRessavefilter').modal('show');
            }
        }
        function AvoidSpace(input) {
            if (/^\s/.test(input.value))
                input.value = '';
        }
        function SaveInfraResFilterDetails() {
            var fltFilterName = $("#txtFilterName").val();
            if (fltFilterName == "" || fltFilterName == " ") {
                //$('#BgSavefilter').modal('show');
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name');
                //$('#BgSavefilter').modal('show')

                $("#txtFilterName").focus();

                //return false
            }

            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
            else if (checkSpecialCharacter(fltFilterName, WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $(ControlValidationFieldID[i]).focus()
                $("#txtFilterName").focus();
            }
            //else if ($("#txtFilterName").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtFilterName").focus();
            //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Filter Name can not contain any of these /\:*?<>|,"+- characters.');
            //}
            else {
                var filterExists = 0;
                var AllInfraResFilter = ["InfraName", "RetiredOn", "InfraTypeId", "InfraGroupId", "BusinessGroupID", "LocationID", "InfraStatusId"];
                //var isActiveFilter = 'True';/// $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GenerateInfraResourceBasicFilterQuery("Resource", AllInfraResFilter);
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
                            $('#InfraRessavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            ApplyFilter();
                            FilterApplied();
                            GetMyInfraResFilter(0);
                            savedFilterName = fltFilterName;
                            $("#txtFilterName").val("");
                            //clearTooltip();
                            // ClearFilterDetails("");
                        }


                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (xhr, errorThrown) {
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    //},
                     error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }                    
                    }
                     //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                });
                //}
            }
        }
        function GetMyInfraResFilter(flag) {
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
                        //Added by imran on 27-01-2023
                        $("#MyFiltersdropdown").removeClass("show");
                        //End of comment by imran on 27-01-2023
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
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }                    
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
            clearTooltip();
        }


        function ExistInfraResFilter(filtername) {

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
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }                    
                }
                 //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
            return isFilterExists;
        }

        //Delete filter
       //Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on 6 July 2021
       // function DeleteFilter(FilterID, IsApplyed) {
        function DeleteFilter(FilterID,FilterName,IsApplyed) {
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
                            GetResourceRequest();
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyInfraResFilter(0);
                        currentappliedfilter = 0;
                    }
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
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
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
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
                        $("#txtFilterName").val(currentFilterName);
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
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                 //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
        }

        //Apply saved filter
        //var currentappliedfilter = 0;
        //var currentappliedfilterclause = '';
        function ApplySavedFilter(FilterID, isDefault,isFromDefault) {
            //Changed  by imran by Filter Issue on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }

            if (isDefault == 3) {
                GetResourceRequest();
                GetMyInfraResFilter(isDefault);
                FilterNotApplied();
                 ClearFilterDetails(""); // Added By Reshma Chavan on 31st Jan 2022 for clearing filter
                $('#AdvanceFilterIcon').attr("aria-expanded", false);
                //added by mahesh on 21 july 2021
                if ((isFromDefault === false || isFromDefault == 'false') && (isDefault == 3))
                {
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
                            GetInfraResDetails(Querytext);
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
                            GetMyInfraResFilter(0);
                        }
                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
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
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
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
                        // ApplySavedFilter(FilterID, 2);
                        ApplySavedFilter(FilterID, 2,true);
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        //alertify.success('Default');
                        // FilterNotApplied();  
                        ApplySavedFilter(FilterID, 3,true);
                        alertify.success('Default Filter Is Successfully Removed!');
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        FilterNotApplied();
                    }
                    GetMyInfraResFilter(0);
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
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
                 //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
        }
        function GenerateInfraResourceBasicFilterQuery(module, filterField) 
        {
           
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();
                    
                    if (strvalue != "" && strvalue != undefined && strvalue != 0)
                    {
                        //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        strvalue = strvalue.replace(/"/g, '""');
                        //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        //Added By Reshma Chavan on 13th Dec 2021 For Not apply Retiredon Filter correctly
                        strvalue = strvalue.replace(/'/g, "''");
                       //End of Added By Reshma Chavan on 13th Dec 2021 For Not apply Retiredon Filter correctly
                       
                        if (strqtext != "") strqtext += " AND ";
                        if (strOp == "Contains") {
                            strqtext += filterField[i] + " LIKE ";
                            //strqtext += " ''%" + strvalue + "%''";
                            //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "%' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "%' + strvalue + '%"';
                            }
                            //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Ends With") {
                            strqtext += filterField[i] + " LIKE ";
                            // strqtext += " ''%" + strvalue + "''";
                            // Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "%' + strvalue + '"';
                                strqtext += ' escape "`"';
                            } else {
                                //Addded By Riddhesh on 9 May 2023
                               // strqtext += ' "' + strvalue + '%"';
                                strqtext += ' "%' + strvalue + '"';
                                 //End of Addded By Riddhesh on 9 May 2023
                            }
                            //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        }
                        // comment and added by imran on 14-12-2021
                        //else if (strOp == "Exact Word" ) {
                        else if (strOp == "Exact Word" || strOp == "=") {
                            //End Comment 14-12-2021
                            strqtext += filterField[i] + " = ";
                            //strqtext += " ''" + strvalue + "''";
                            strqtext += ' "' + strvalue + '"';                          
                        }
                        else if (strOp == "Not Contains") {
                            strqtext += filterField[i] + " ";
                            //strqtext += " NOT LIKE ''%" + strvalue + "%''";
                            //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' NOT LIKE "%' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' NOT LIKE "%' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' NOT LIKE "%' + strvalue + '%"';
                            }
                            //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Starts With") {
                            strqtext += filterField[i] + " LIKE ";
                            // strqtext += " ''" + strvalue + "%''";
                            //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' "' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                //strqtext += ' "%' + strvalue + '"';
                                strqtext += ' "' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            }
                            else {
                                //Addded By Riddhesh on 9 May 2023
                               // strqtext += ' "%' + strvalue + '"';
                                strqtext += ' "' + strvalue + '%"';
                                //End of Addded By Riddhesh on 9 May 2023
                            }
                            //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        }

                        else {

                            strqtext += filterField[i] + " ";
                            if ($.isNumeric(strvalue) == false) {
                                // strqtext += strOp + " ''" + strvalue + "''";
                                //strqtext += strOp + " ''" + strvalue + "''";

                                strqtext += strOp + " '" + strvalue + "'";
                            }
                            else {

                                //strqtext += strOp + " " + strvalue + "";
                                strqtext += strOp + ' "' + strvalue + '"';
                            }
                        }
                    }
                }

                strqtext = strqtext.replace('Over', '[Over]')
                //Commented By Reshma Chavan on 13th Dec 2021 For Not apply Retiredon Filter correctly
                //strqtext = strqtext.replace(/'/g, "''");
                 //End of Commented By Reshma Chavan on 13th Dec 2021 For Not apply Retiredon Filter correctly
                //strqtext = strqtext.replace(/"/g, "''");
                return strqtext;
            }
            catch (ex) {
                //alert(ex.message);
            }

        }
        function FillInfraType(typeID) {
            var strHTML = "";
            var objID = { InfraTypeId: typeID }
            $.ajax({
                url: strUrl + '/api/RM_InfraResources/GetToFillInfraType',
                type: "POST",
                data: JSON.stringify(objID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objID) ? objID : JSON.stringify(objID)));
                    }
                },
                success: function (data) {
                    //$("#cboOPRFilterLocationID").empty();
                    //Commented and added by Chetan M on 20 Jul 2021 for adding placeholder
                    //strHTML += "<option value='0'></option>";
                    strHTML += "<option value='0'>Select Infrastructure Type</option>";
                    //End of Commented and added by Chetan M on 20 Jul 2021 for adding placeholder
                    $.each(data, function (index, obj) {
                        strHTML += ('<option value=' + obj.InfraTypeId + ' >' + obj.InfraTypeName + '</option>');
                    })
                    //for (var i = 0; i < data.length; i++) {
                    //    var listComponent = data[i];
                    //    strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    //}

                    $("#cboInfraType").html(strHTML);
                    $("#cboInfraType").val(typeID);

                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
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
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }

        function FillInfraGroup(grpID) {
            var strHTML = "";
            var objID = { InfraGroupId: grpID }
            $.ajax({
                url: strUrl + '/api/RM_InfraResources/GetToFillInfraGroup',
                type: "POST",
                data: JSON.stringify(objID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objID) ? objID : JSON.stringify(objID)));
                    }
                },
                success: function (data) {
                    //$("#cboOPRFilterLocationID").empty();
                    //Commented and added by Chetan M on 20 Jul 2021 for adding placeholder
                    //strHTML += "<option value='0'></option>";
                    strHTML += "<option value='0'>Select Infrastructure Group</option>";
                    //End of Commented and added by Chetan M on 20 Jul 2021 for adding placeholder
                    $.each(data, function (index, obj) {
                        strHTML += ('<option value=' + obj.InfraGroupId + ' >' + obj.InfraGroupName + '</option>');
                    })
                    //for (var i = 0; i < data.length; i++) {
                    //    var listComponent = data[i];
                    //    strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    //}

                    $("#cboInfraGroup").html(strHTML);
                    $("#cboInfraGroup").val(grpID);

                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
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
                 //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
        function FillInfraStatus(stsID) {
            var strHTML = "";
            var objID = { InfraStatusId: stsID }
            $.ajax({
                url: strUrl + '/api/RM_InfraResources/GetToFillInfraStatus',
                type: "POST",
                data: JSON.stringify(objID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objID) ? objID : JSON.stringify(objID)));
                    }
                },
                success: function (data) {
                    //$("#cboOPRFilterLocationID").empty();
                    //Commented and added by Chetan M on 20 Jul 2021 for adding placeholder
                    //strHTML += "<option value='0'></option>";
                    strHTML += "<option value='0'>Select Infrastructure Status</option>";
                    //End of Commented and added by Chetan M on 20 Jul 2021 for adding placeholder
                    $.each(data, function (index, obj) {
                        strHTML += ('<option value=' + obj.InfraStatusId + ' >' + obj.InfraStatus + '</option>');
                    })
                    //for (var i = 0; i < data.length; i++) {
                    //    var listComponent = data[i];
                    //    strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    //}

                    $("#cboInfraStatus").html(strHTML);
                    $("#cboInfraStatus").val(stsID);

                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
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
                 //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
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



        function showName() {

            var name = document.getElementById('txtFileUpload');
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
        var IrmXslxList = ''
        function IrmUploadxlsfile() {
            
            Fillstep_2DropDowUsingColumnName();
            var SelectedFile = txtFileUpload.files;
            var SelectedFileName = document.getElementById('dvShowFileName').innerHTML;
            //console.log(SelectedFileName);
            if (SelectedFile != 'undeifned' && SelectedFile.length > 0 && SelectedFileName != "") {
                var isFileValid = fileValidation()
                if (isFileValid === true) {
                    var data = new FormData();
                    data.append("file", SelectedFile[0]);
                    $.ajax({
                        url: strUrl + '/api/RM_InfraResources/UploadXlsxFile',
                        type: "POST",
                        data: data,
                        contentType: false,
                        processData: false,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        },
                        success: function (data) {
                            var check = 0;

                            if (data.length > 0) {
                                    IrmXslxList = data;
                                    // RelodXslxData(data);
                                    if (data.length > 0) {
                                        var ChkValidationBlank = BlankExcelColumnCheck(data);
                                        ChkValidationBlank = ChkValidationBlank.split('~');
                                    }

                                    if (ChkValidationBlank[0] == 0) {
                                        RelodXslxData(data);
                                        //Commented and Added By RehanC for next button click issue on 28th Mar 2023
                                        //$("#btnaStep2").click()
                                        $("#exceluploadsteps .pointerDisable").removeClass('active');
                                        $("#exceluploadsteps ul.nav-wizard li:nth-child(2)").addClass('active');
                                        $("#exceluploadsteps .tab-pane").removeClass('active');
                                        $("#PBEUstep2").addClass('active');
                                        //End of Comment By RehanC for next button click issue on 28th Mar 2023
                                    }
                                    else {

                                        alertify.set('notifier', 'position', 'top-right');
                                        //alertify.error(ChkValidationBlank[1].replace(':{0}', '<br>')); 
                                        alertify.error(ChkValidationBlank[1])
                                    }
                                    //$("#btnaStep2").click();
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
        }

        //Added by imran 23-08-2021
        function BlankExcelColumnCheck(objXlsx)
        {
            var XlsxObj = objXlsx;
            var TBlankCheck = 0;
            var tColumnvalue = '';
            $.each(XlsxObj, function (index, objXlsx)
            {                   
                if (objXlsx.ColumnError != null)
                {
                    

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
                    else {                        
                        tColumnvalue += objXlsx.ColumnError.append('<BR>');
                    }
                }
            });
            tColumnvalue = tColumnvalue.replace('<br>', '');
            tColumnvalue = tColumnvalue.replace('<BR>', '');
            return TBlankCheck + '~' + tColumnvalue.replaceAll(':','<br>');
        }
        //End by imran 23-08-2021

        function fileValidation() {
            var fileInput = document.getElementById('txtFileUpload');
            var filePath = fileInput.value;
            // Allowing file type 
            //Commented & Added By Rutuja D. on 13 Aug 2021 For Allow xls File format
            //var allowedExtensions = /(\.xlsx)$/i;
            var allowedExtensions = /(\.(xlsx|xls))$/i;
            //End of Commented & Added By Rutuja D. on 13 Aug 2021 For Allow xls File format
            if (!allowedExtensions.exec(filePath)) {
                alertify.set('notifier', 'position', 'top-right');
               // alertify.error("Only xlsx file format is allowed.");
                alertify.error("Only xlsx and xls file format is allowed.");
                // fileInput.value = ''; 
                return false;
            }
            //else if (SelectedFile == 'undeifned' || SelectedFile.length = 0 || SelectedFileName ==""){
            //    alertify.set('notifier', 'position', 'top-right');
            //  alertify.error("Please select file.");
            //}
            else { return true; }
        }
        function IrmNextStep_2() {
            //Added by Rutuja D. on 16 Aug 2021 For missing Validation Code
            if ($("#CboIrmExcelColumn_A").val() == 0 || $("#CboIrmExcelColumn_A").val() == "" || $("#CboIrmExcelColumn_A").val() != "1") {
                //alertify.error("Please select Infra Name");
                alertify.error("Please select Infrastructure Name");
                $("#CboIrmExcelColumn_A").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_B").val() == 0 || $("#CboIrmExcelColumn_B").val() == "" || $("#CboIrmExcelColumn_B").val() != "2") {
                alertify.error("Please select Description");
                $("#CboIrmExcelColumn_B").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_C").val() == 0 || $("#CboIrmExcelColumn_C").val() == "" || $("#CboIrmExcelColumn_C").val() != "3") {
                alertify.error("Please select Active");
                $("#CboIrmExcelColumn_C").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_D").val() == 0 || $("#CboIrmExcelColumn_D").val() == "" || $("#CboIrmExcelColumn_D").val() != "4") {
                //alertify.error("Please select Type");
                alertify.error("Please select Infrastructure Type");
                $("#CboIrmExcelColumn_D").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_E").val() == 0 || $("#CboIrmExcelColumn_E").val() == "" || $("#CboIrmExcelColumn_E").val() != "5") {
                //alertify.error("Please select Infra Group");
                alertify.error("Please select Infrastructure Group");
                $("#CboIrmExcelColumn_E").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_F").val() == 0 || $("#CboIrmExcelColumn_F").val() == "" || $("#CboIrmExcelColumn_F").val() != "6") {
                alertify.error("Please select Business Group");
                $("#CboIrmExcelColumn_F").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_G").val() == 0 || $("#CboIrmExcelColumn_G").val() == "" || $("#CboIrmExcelColumn_G").val() != "7") {
                alertify.error("Please select Organization Unit");
                $("#CboIrmExcelColumn_G").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_H").val() == 0 || $("#CboIrmExcelColumn_H").val() == "" || $("#CboIrmExcelColumn_H").val() != "8") {
                alertify.error("Please select Max Allocation Per Day(Hrs)");
                $("#CboIrmExcelColumn_H").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_I").val() == 0 || $("#CboIrmExcelColumn_I").val() == "" || $("#CboIrmExcelColumn_I").val() != "9") {
                //alertify.error("Please select Infra Status");
                alertify.error("Please select Infrastructure Status");
                $("#CboIrmExcelColumn_I").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_J").val() == 0 || $("#CboIrmExcelColumn_J").val() == "" || $("#CboIrmExcelColumn_J").val() != "10") {
                alertify.error("Please select Cost Per Hr");
                $("#CboIrmExcelColumn_J").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_K").val() == 0 || $("#CboIrmExcelColumn_K").val() == "" || $("#CboIrmExcelColumn_K").val() != "11") {
                alertify.error("Please select Rate Per Hr");
                $("#CboIrmExcelColumn_K").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_L").val() == 0 || $("#CboIrmExcelColumn_L").val() == "" || $("#CboIrmExcelColumn_L").val() != "12") {
                alertify.error("Please select Total Cost of Acquisition");
                $("#CboIrmExcelColumn_L").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_M").val() == 0 || $("#CboIrmExcelColumn_M").val() == "" || $("#CboIrmExcelColumn_M").val() != "13") {
                alertify.error("Please select Depreciation Rate");
                $("#CboIrmExcelColumn_M").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_N").val() == 0 || $("#CboIrmExcelColumn_N").val() == "" || $("#CboIrmExcelColumn_N").val() != "14") {
                alertify.error("Please select Available From");
                $("#CboIrmExcelColumn_N").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_O").val() == 0 || $("#CboIrmExcelColumn_O").val() == "" || $("#CboIrmExcelColumn_O").val() != "15") {
                alertify.error("Please select Available Till");
                $("#CboIrmExcelColumn_O").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_P").val() == 0 || $("#CboIrmExcelColumn_P").val() == "" || $("#CboIrmExcelColumn_P").val() != "16") {
                alertify.error("Please select Retired on");
                $("#CboIrmExcelColumn_P").focus();
                return false;
            }
            else if ($("#CboIrmExcelColumn_Q").val() == 0 || $("#CboIrmExcelColumn_Q").val() == "" || $("#CboIrmExcelColumn_Q").val() != "17") {
                alertify.error("Please select Total Quantity / No.of Licenses");
                $("#CboIrmExcelColumn_Q").focus();
                return false;
            }
            //End of Added by Rutuja D. on 16 Aug 2021 For missing Validation Code
            else {
                //Commented and Added By RehanC for next button click issue on 28th Mar 2023
                //$("#btnaStep3").click();
                $("#exceluploadsteps .pointerDisable").removeClass('active');
                $("#exceluploadsteps ul.nav-wizard li:nth-child(3)").addClass('active');
                $("#exceluploadsteps .tab-pane").removeClass('active');
                $("#PBEUstep3").addClass('active');
                 //End of Comment By RehanC for next button click issue on 28th Mar 2023
            }
        }
        function IrmBackStep_2() {
             //Commented and Added By RehanC for next button click issue on 28th Mar 2023
            //$("#btnaStep1").click();
            $("#exceluploadsteps .pointerDisable").removeClass('active');
            $("#exceluploadsteps ul.nav-wizard li:nth-child(1)").addClass('active');
            $("#exceluploadsteps .tab-pane").removeClass('active');
            $("#PBEUstep1").addClass('active');
             //End of Comment By RehanC for next button click issue on 28th Mar 2023
        }
        function IrmBackStep_3() {
            //Commented and Added By RehanC for next button click issue on 28th Mar 2023
            //$("#btnaStep2").click();
            $("#exceluploadsteps .pointerDisable").removeClass('active');
            $("#exceluploadsteps ul.nav-wizard li:nth-child(2)").addClass('active');
            $("#exceluploadsteps .tab-pane").removeClass('active');
            $("#PBEUstep2").addClass('active');
            //End of Comment By RehanC for next button click issue on 28th Mar 2023
        }

        function irmOpenExceluploadsteps() {
            //Commented and Added By RehanC for next button click issue on 28th Mar 2023
            //$("#btnaStep1").click();
            $("#exceluploadsteps .pointerDisable").removeClass('active');
            $("#exceluploadsteps ul.nav-wizard li:nth-child(1)").addClass('active');
            $("#exceluploadsteps .tab-pane").removeClass('active');
            $("#PBEUstep1").addClass('active');
           //End of Comment By RehanC for next button click issue on 28th Mar 2023
            var $el = $('#frmFileUpload');
            $el.wrap('<form>').closest('form').get(0).reset();
            $el.unwrap();
            document.getElementById('plabelName').innerHTML = "Attach file or drop here :-";
            document.getElementById('dvShowFileName').innerHTML = ''
            $('#exceluploadsteps').modal('show');
            RelodXslxData("");
            $('#exceluploadsteps').modal('show');
            //clearFileInput("txtFileUpload");


        }

        function clearFileInput(id) {
            var oldInput = document.getElementById(id);

            var newInput = document.createElement("input");

            newInput.type = "file";
            newInput.id = oldInput.id;
            newInput.name = oldInput.name;
            newInput.className = oldInput.className;
            newInput.style.cssText = oldInput.style.cssText;
            // TODO: copy any other relevant attributes 

            oldInput.parentNode.replaceChild(newInput, oldInput);
        }

        $('#txtSearchXlsxInfraName').keyup(function () {

            var SearchedXslxInfraNameText = $("#txtSearchXlsxInfraName").val();
            var FilterxslxList = IrmXslxList.filter(function (x) { return x.InfraName.toLowerCase().indexOf(SearchedXslxInfraNameText.toLowerCase()) !== -1 });
            RelodXslxData(FilterxslxList);


        });

        function RelodXslxData(XlsxList) {
            var strHTML = "";
            if (XlsxList.length > 0) {
                $.each(XlsxList, function (index, objXlsx) {
                    if (objXlsx.ColumnError == null) {
                        objXlsx.ColumnError = "";
                    }
                    if (objXlsx.ColumnError == null || objXlsx.ColumnError == "" || objXlsx.ColumnError == 'undefined') {
                        // strHTML += '<tr style="color:red;"><td><div class="custom_chckbox" <input type="hidden" name="hdn_InfraGroupId" id="hdn_InfraGroupId" value= ' + objXlsx.InfraName + '><input id="' + index + '"  onclick="checkUncheck();GetSelectedInfraGroup(this);" class="chcktblXlsx" type="checkbox" disabled="disabled"><label for="' + index + '"></label></div></td> ';
                        // strHTML += ' <td> ' + objXlsx.InfraName + ' </td> <td> ' + objXlsx.Description + '</td> <td> ' + objXlsx.IsActive + '</td> <td>' + objXlsx.Type + '</td><td>' + objXlsx.InfraGroup + '</td>  <td>' + objXlsx.BusinessGroup + '</td>  <td>' + objXlsx.OrganizationUnit + '</td>  <td>' + objXlsx.MaxAllocationPerDay + '</td>  <td>' + objXlsx.InfraStatus + '</td><td>' + objXlsx.CostPerHour + '</td>  <td>' + objXlsx.RatePerHour + '</td> ';
                        // strHTML += ' <td>' + objXlsx.TotalCostOfAcquisition + '</td><td> ' + objXlsx.DepreciationRate + '</td><td>' + objXlsx.AvaliableFrom + '</td>  <td>' + objXlsx.AvaliableTill + '</td>  <td>' + objXlsx.RetiredOn + '</td>  <td>' + objXlsx.TotalQuantity + '</td>  <td>' + objXlsx.ColumnError + '</td>  ';
                        // strHTML += ' </tr > ';
                        strHTML += '<tr><td><div class="custom_chckbox" <input type="hidden" name="hdn_InfraGroupId" id="hdn_InfraGroupId" value= ' + objXlsx.InfraName + '><input id="' + index + '"  onclick="checkUncheck();GetSelectedInfraGroup(this);" class="chcktblXlsx" type="checkbox" checked="true"><label for="' + index + '"></label></div></td> ';
                        strHTML += ' <td> ' + objXlsx.InfraName + ' </td> <td> ' + objXlsx.Description + '</td> <td> ' + objXlsx.IsActive + '</td> <td>' + objXlsx.Type + '</td><td>' + objXlsx.InfraGroup + '</td>  <td>' + objXlsx.BusinessGroup + '</td>  <td>' + objXlsx.OrganizationUnit + '</td>  <td>' + objXlsx.MaxAllocationPerDay + '</td>  <td>' + objXlsx.InfraStatus + '</td><td>' + objXlsx.CostPerHour + '</td>  <td>' + objXlsx.RatePerHour + '</td> ';
                        strHTML += ' <td>' + objXlsx.TotalCostOfAcquisition + '</td><td> ' + objXlsx.DepreciationRate + '</td><td>' + objXlsx.AvaliableFrom + '</td>  <td>' + objXlsx.AvaliableTill + '</td>  <td>' + objXlsx.RetiredOn + '</td>  <td>' + objXlsx.TotalQuantity + '</td>  <td>' + objXlsx.ColumnError + '</td>  ';
                        strHTML += ' </tr > ';
                    }
                    else {
                        strHTML += '<tr style="color:red;"><td><div class="custom_chckbox" <input type="hidden" name="hdn_InfraGroupId" id="hdn_InfraGroupId" value= ' + objXlsx.InfraName + '><input id="' + index + '"  onclick="checkUncheck();GetSelectedInfraGroup(this);" class="chcktblXlsx" type="checkbox" disabled="disabled"><label for="' + index + '"></label></div></td> ';
                        strHTML += ' <td> ' + objXlsx.InfraName + ' </td> <td> ' + objXlsx.Description + '</td> <td> ' + objXlsx.IsActive + '</td> <td>' + objXlsx.Type + '</td><td>' + objXlsx.InfraGroup + '</td>  <td>' + objXlsx.BusinessGroup + '</td>  <td>' + objXlsx.OrganizationUnit + '</td>  <td>' + objXlsx.MaxAllocationPerDay + '</td>  <td>' + objXlsx.InfraStatus + '</td><td>' + objXlsx.CostPerHour + '</td>  <td>' + objXlsx.RatePerHour + '</td> ';
                        strHTML += ' <td>' + objXlsx.TotalCostOfAcquisition + '</td><td> ' + objXlsx.DepreciationRate + '</td><td>' + objXlsx.AvaliableFrom + '</td>  <td>' + objXlsx.AvaliableTill + '</td>  <td>' + objXlsx.RetiredOn + '</td>  <td>' + objXlsx.TotalQuantity + '</td>  <td>' + objXlsx.ColumnError + '</td>  ';
                        strHTML += ' </tr > ';


                    }

                });
            } else {

            }
            // $('#exluploadTbl').dataTable().fnDestroy();
            $("#exluploadTblTbody").html(strHTML);
            //LoadXlsxPagination(data);
        }


        function IrmSaveXlsxData() {
            var xlsxSelectedList = []
            var message = '';
            $("#exluploadTbl input[type=checkbox]:checked").each(function () {
                var objxlsxSelectedList = {}
                var row = $(this).closest("tr")[0];
                objxlsxSelectedList.InfraResourceId = 0
                var InfraNameRowValue = row.cells[1].innerHTML.toString();
                objxlsxSelectedList.InfraName = InfraNameRowValue.toString();
                objxlsxSelectedList.Description = row.cells[2].innerHTML;
                objxlsxSelectedList.IsActive = row.cells[3].innerHTML;
                objxlsxSelectedList.type = row.cells[4].innerHTML;

                objxlsxSelectedList.InfraGroup = row.cells[5].innerHTML;
                objxlsxSelectedList.BusinessGroup = row.cells[6].innerHTML;
                objxlsxSelectedList.OrganizationUnit = row.cells[7].innerHTML;
                objxlsxSelectedList.MaxAllocationPerDay = row.cells[8].innerHTML;
                objxlsxSelectedList.InfraStatus = row.cells[9].innerHTML;

                objxlsxSelectedList.CostPerHour = row.cells[10].innerHTML;
                //Commented And Added by Reshma Chavan for rate per hour in edit mode display 0 always 
                //objxlsxSelectedList.RatePerHr = row.cells[11].innerHTML;
                objxlsxSelectedList.RatePerHour = row.cells[11].innerHTML;
                //Commented And Added by Reshma Chavan for rate per hour in edit mode display 0 always 
                objxlsxSelectedList.TotalCostOfAcquisition = row.cells[12].innerHTML;
                objxlsxSelectedList.DepreciationRate = row.cells[13].innerHTML;
                objxlsxSelectedList.AvaliableFrom = row.cells[14].innerHTML;

                objxlsxSelectedList.AvaliableTill = row.cells[15].innerHTML;
                objxlsxSelectedList.RetiredOn = row.cells[16].innerHTML;
                objxlsxSelectedList.TotalQuantity = row.cells[17].innerHTML;
                
                xlsxSelectedList.push(objxlsxSelectedList);
            });
            if (xlsxSelectedList != null && xlsxSelectedList.length > 0) {
                IrmSaveXlsxDataSelectedData(xlsxSelectedList)
            } else {
                $('#exceluploadsteps').modal('show');
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("At least one valid record required to upload.");
            }


        }

        function IrmSaveXlsxDataSelectedData(xlsxSelectedList) {
            var strHTML = "";
            $.ajax({
                url: strUrl + '/api/RM_InfraResources/UploadXlsxRecord',
                type: "POST",
                data: JSON.stringify(xlsxSelectedList),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                success: function (data) {
                    $('#exceluploadsteps').modal('hide');
                    GetResourceRequest();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("File uploaded successfully.");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
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
                 //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }

        function Fillstep_2DropDowUsingColumnName() {
            var Step2DrpList = [
                //{ Name: 'Infra Name', Value: 1 },
                { Name: 'Infrastructure Name', Value: 1 },
                { Name: 'Description', Value: 2 },
                { Name: 'Active', Value: 3 },
                //{ Name: 'Type', Value: 4 },
                { Name: 'Infrastructure Type', Value: 4 },
                //{ Name: 'Infra Group', Value: 5 },
                { Name: 'Infrastructure Group', Value: 5 },
                { Name: 'Business Group', Value: 6 },
                { Name: 'Organization Unit', Value: 7 },
                { Name: 'Max Allocation Per Day(Hrs)', Value: 8 },
                //{ Name: 'Infra Status', Value: 9 },
                { Name: 'Infrastructure Status', Value: 9 },
                { Name: 'Cost Per Hr', Value: 10 },
                { Name: 'Rate Per Hr', Value: 11 },
                { Name: 'Total Cost of Acquisition', Value: 12 },
                { Name: 'Depreciation Rate', Value: 13 },
                { Name: 'Available From', Value: 14 },
                { Name: 'Available Till', Value: 15 },
                { Name: 'Retired on', Value: 16 },
                { Name: 'Total Quantity / No. of Licenses', Value: 17 },

            ];
            var arrExcelFields = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q"];
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
                $(CboID).prop("disabled", true); //aDDED bY rUTUJA d.For Disabled Excel Upload Column Step 2
                $(CboID).val(i + 1);
            }


        }

        function ResetExcelFiledDropdown() {

            var arrExcelFields = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "P", "Q", "R"];
            var LengthOfExcelField = arrExcelFields.length;

            for (var i = 0; i < LengthOfExcelField; i++) {
                var CboID = "#CboIrmExcelColumn_" + arrExcelFields[i];
                $(CboID).val(0);
            }
        }

        var SelectedEmpID = [];
        var InfraGrouptable;
        function GetSelectedInfraGroup(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedEmpID.push(parseInt(row.find('#hdn_InfraGroupId').val()));
            }
            else {
                if (SelectedEmpID != 'undefined' && SelectedEmpID.length > 0) {
                    var removeEmp = row.find('#hdn_InfraGroupId').val();
                    SelectedEmpID.remove(parseInt(removeEmp));
                }
            }

        }
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

        function checkUncheck() {

            if (InfraGrouptable.$('input:checked').length == InfraGrouptable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
            }
        }

        // $('#MInfraListTbl').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        $('.modal').on('show.bs.modal', function () {
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('#MInfraListTbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 220, "overflow-y": "auto" });

            //var tblheight = $(window).height();
            //$('.Resourcedetailpanel').css({ 'height': tblheight - 80 });

            var JStableOuter = $(window).height();
            $('.JStableOuter > table, .PRweekdaytbl td::after').css({ 'height': JStableOuter - 415, "overflow-y": "auto" });

            var JStabledividerHeight = $(window).height();
            $('.PRweekdaytbl td::after').css({ 'height': JStabledividerHeight - 215, "overflow-y": "auto" });


        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });




        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
            $(".table").resize();
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
            $(".table").resize();
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

        //Search List Filter
        function mysearchFunction() {
            var SearchText = $("#srchMIlist").val();
            var strHTML = "";
            //Commented and Added by imran on 14-12-2021
            //var FilterTitle = InfraResourceRequests.filter(function (x) { return x.InfraName.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 });
            var FilterTitle = InfraResourceRequests.filter(function (x) { return (x.InfraTypeName.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 || x.InfraName.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 || x.InfraGroupName.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 || x.BusinessGroup.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 || x.AvaliableFrom.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 || x.InfraStatus.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 || x.AvaliableTill.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1) });
            //End comment by imran on 14-12-2021

            ReloadTableSearchForInfraResources(FilterTitle);
        }

        function ReloadTableSearchForInfraResources(List) {
            var strHTML = "";
            $("#MInfraList").html('');
            if (List != null && List.length > 0) {
                //$.each(List, function (index, obj) {
                //    strHTML += "<tr><td><input type='hidden' name='hdn_InfraResourceID' id='hdn_InfraResourceID' value= " + obj.InfraResourceId + ">" + obj.InfraTypeName + " </td><td>" + obj.InfraGroupName + " </td><td>" + obj.InfraName + "</td><td>" + obj.BusinessGroup + "</td><td>" + obj.AvaliableFrom + "</td><td>" + obj.AvaliableTill + "</td><td>" + obj.InfraStatus + "</td><td class='actioncolumn'><a class='nostylebtn edit' href='#' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-bs-original-title='Edit' onclick=\"(editIM('" + obj.InfraResourceId + "'))\"><i class='fas fa-pencil-alt' style='font-size:16px;color: #464a4c'></i></a><a  onclick='DeleteResourceRequest(" + obj.InfraResourceId + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-bs-original-title='Delete'></i></a></td></tr>";

                //});
                $.each(List, function (index, obj) {
                    var tilldate;
                    if (obj.AvaliableTill == "01 January 1900") {
                        tilldate = "";
                    } else {
                        tilldate = obj.AvaliableTill;
                    }
                    if (blnEditAccess == "True" && blnDeleteAccess == "True") {
                        strHTML += "<tr><td><input type='hidden' name='hdn_InfraResourceID' id='hdn_InfraResourceID' value= " + obj.InfraResourceId + ">" + obj.InfraTypeName + " </td><td>" + obj.InfraGroupName + " </td><td>" + obj.InfraName + "</td><td>" + obj.BusinessGroup + "</td><td>" + obj.AvaliableFrom + "</td><td>" + tilldate + "</td><td>" + obj.InfraStatus + "</td><td class='actioncolumn'><span style='display:flex'><a class='nostylebtn edit' href='#' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-bs-original-title='Edit' onclick=\"(editIM('" + obj.InfraResourceId + "'))\"><i class='fas fa-pencil-alt' style='font-size:16px;color: #464a4c'></i></a><a  onclick='DeleteResourceRequest(" + obj.InfraResourceId + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-bs-original-title='Delete'></i></a></span></td></tr>";
                    }
                    else if (blnEditAccess == "True" && blnDeleteAccess == "False") {
                        strHTML += "<tr><td><input type='hidden' name='hdn_InfraResourceID' id='hdn_InfraResourceID' value= " + obj.InfraResourceId + ">" + obj.InfraTypeName + " </td><td>" + obj.InfraGroupName + " </td><td>" + obj.InfraName + "</td><td>" + obj.BusinessGroup + "</td><td>" + obj.AvaliableFrom + "</td><td>" + tilldate + "</td><td>" + obj.InfraStatus + "</td><td class='actioncolumn'><a class='nostylebtn edit' href='#' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-bs-original-title='Edit' onclick=\"(editIM('" + obj.InfraResourceId + "'))\"><i class='fas fa-pencil-alt' style='font-size:16px;color: #464a4c'></i></a></td></tr>";

                    }
                    else if (blnEditAccess == "False" && blnDeleteAccess == "True") {
                        strHTML += "<tr><td><input type='hidden' name='hdn_InfraResourceID' id='hdn_InfraResourceID' value= " + obj.InfraResourceId + ">" + obj.InfraTypeName + " </td><td>" + obj.InfraGroupName + " </td><td>" + obj.InfraName + "</td><td>" + obj.BusinessGroup + "</td><td>" + obj.AvaliableFrom + "</td><td>" + tilldate + "</td><td>" + obj.InfraStatus + "</td><td class='actioncolumn'><a  onclick='DeleteResourceRequest(" + obj.InfraResourceId + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-bs-original-title='Delete'></i></a></td></tr>";

                    }
                    else if (blnEditAccess == "False" && blnDeleteAccess == "False") {
                        strHTML += "<tr><td><input type='hidden' name='hdn_InfraResourceID' id='hdn_InfraResourceID' value= " + obj.InfraResourceId + ">" + obj.InfraTypeName + " </td><td>" + obj.InfraGroupName + " </td><td>" + obj.InfraName + "</td><td>" + obj.BusinessGroup + "</td><td>" + obj.AvaliableFrom + "</td><td>" + tilldate + "</td><td>" + obj.InfraStatus + "</td><td class='actioncolumn'></td></tr>";

                    } else {
                        strHTML += "<tr><td><input type='hidden' name='hdn_InfraResourceID' id='hdn_InfraResourceID' value= " + obj.InfraResourceId + ">" + obj.InfraTypeName + " </td><td>" + obj.InfraGroupName + " </td><td>" + obj.InfraName + "</td><td>" + obj.BusinessGroup + "</td><td>" + obj.AvaliableFrom + "</td><td>" + tilldate + "</td><td>" + obj.InfraStatus + "</td><td class='actioncolumn'><a class='nostylebtn edit' href='#' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-bs-original-title='Edit' onclick=\"(editIM('" + obj.InfraResourceId + "'))\"><i class='fas fa-pencil-alt' style='font-size:16px;color: #464a4c'></i></a><a  onclick='DeleteResourceRequest(" + obj.InfraResourceId + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-bs-original-title='Delete'></i></a></td></tr>";

                    }
                });
                $('#MInfraListTbl').dataTable().fnDestroy();
                $("#MInfraList").html(strHTML);
                LoadPagination(List);
                StopAjaxLoader("#body-ResRequest");
            } else {
                strHTML += '<tr><td class="text-center"colspan="8">' + NoDataFound + ' </td></tr>';
                $('#MInfraListTbl').dataTable().fnDestroy();
                $("#MInfraList").html(strHTML);

                // $(".chckHeadForSoftBooking").prop("checked", false);
            }
        }


        //var $rows2 = $('#exluploadTbl tr');
        //$('#searchpracsetting').keyup(function () {
        //    var val2 = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();

        //    $rows2.show().filter(function () {
        //        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
        //        return !~text.indexOf(val2);
        //    }).hide();
        //    $(".table").resize();
        //});

        //var $rows = $('#MInfraListTbl tr');
        //$('#srchMIlist').keyup(function () {
        //    var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();

        //    $rows.show().filter(function () {
        //        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
        //        return !~text.indexOf(val);
        //    }).hide();
        //    $(".table").resize();
        //});


        //freez table
        $('.JStableOuter > table').scroll(function (e) {


            $('.JStableOuter > table > tbody > tr > td:nth-child(1), .JStableOuter > table > tbody > tr > td:nth-child(2)').css("left", $(".JStableOuter > table").scrollLeft());


            $('.JStableOuter > table > thead').css("top", -$(".JStableOuter > tbody").scrollTop());
            $('.JStableOuter > table > thead > tr > th').css("top", $(".JStableOuter > table").scrollTop());

        });

        //colappse row
        $(".UpDowncollapseArrow").click(function () {
            $(this).toggleClass("in");

        });
    </script>

    <script>

        $('#js-date').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            timePicker: false,
            dateFormat: 'dd MM yyyy',
            onChangeMonthYear: function (year, month) {
                var selectedMonth = month;
                var selectedYear = year;
                $(this).datepicker("setDate", month + "/01/" + year);
            },

            onSelect: function (year, month) {
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


                var date = new Date();
                var firstDay = new Date(date.getFullYear(), date.getMonth() + 0, 1);
                var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                //alert(firstDay + "===" + lastDay);
                $('#js-date').val(firstDay + "-" + lastDay);




            }

        });

        //$('#AsignmentMonthpic').datepicker({
        //    beforeShow: function (input, inst) {
        //        $('#ui-datepicker-div').removeClass(function () {
        //            return $('input').get(0).id;
        //        });
        //        $('#ui-datepicker-div').addClass(this.id);
        //    }
        //});


        $('#AsignmentMonthpic').datepicker({
            changeMonth: true,
            changeYear: true,
            //showButtonPanel: true,
            dateFormat: 'MM yy',
            onClose: function (dateText, inst) {
                $(this).datepicker('setDate', new Date(inst.selectedYear, inst.selectedMonth, 1));
                //   console.log(inst);
                // date=((date.getMonth() > 8) ? (date.getMonth() + 1) : ('0' + (date.getMonth() + 1))) + '/' + ((date.getDate() > 9) ? date.getDate() : ('0' + date.getDate())) + '/' + date.getFullYear();
                openAssignments(new Date(inst.selectedDay, inst.selectedYear, inst.selectedMonth, 1));
                //Added By Pradip P on 21 Jan 2022
                inst.dpDiv.removeClass('month_year_datepicker');
                 //End of Added By Pradip P on 21 Jan 2022
            },


            //Commented & Added By Pradip P. on 24/1/2022
            //beforeShow: function (input, inst) {
            //    $('#ui-datepicker-div').removeClass(function () {
            //        return $('input').get(0).id;
            //    });
            //    $('#ui-datepicker-div').addClass(this.id);
            //}

            beforeShow: function (input, inst) {
                inst.dpDiv.addClass('month_year_datepicker');
                if ((selDate = $(this).val()).length > 0) {
                    iYear = selDate.substring(selDate.length - 4, selDate.length);
                    iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5),
                        $(this).datepicker('option', 'monthNames'));
                    $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
                    $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
                }
            }
            //End of Commented & Added By Pradip P. on 24/1/2022

        });

        $(document).on("mouseout", 'th span, .ui-corner-all', function () {
            $(".tooltip").remove();
        });

        //$("#js-date").datepicker("option", "dateFormat", "DD, d MM, yy");

        //Chnaged Assignment table data- used for static data
        //document.getElementById('Asmnt1').addEventListener("click", function () {          
        //    showTable('AstmntGrid1');
        //});

        //document.getElementById('Asmnt2').addEventListener("click", function () {
        //    showTable('AstmntGrid2');
        //});

        $('#Asmnt1, #Asmnt3, #Asmnt5, #Asmnt7, #Asmnt9, #Asmnt11, #Asmnt13, #Asmnt15, #Asmnt17, #Asmnt19, #Asmnt21, #Asmnt23, #Asmnt25, #Asmnt27, #Asmnt29, #Asmnt31').click(function () {
            showTable('AstmntGrid1');
        });
        $('#Asmnt2, #Asmnt4, #Asmnt6, #Asmnt8, #Asmnt12, #Asmnt14, #Asmnt16, #Asmnt18, #Asmnt20, #Asmnt22, #Asmnt24, #Asmnt26, #Asmnt28, #Asmnt30').click(function () {
            showTable('AstmntGrid2');
        });



        function showTable(tbody) {
            var tables = ['AstmntGrid1', 'AstmntGrid2'];
            for (var i = 0; i < 2; i++) {
                document.getElementById(tables[i]).style.display = "none";
            }

            $(".AssignmentGridTble").css("display", "table")
            document.getElementById(tbody).style.display = "table-row-group";
            $(".table").resize();

        }
        function ExportInfraDemandInfo(ReportFormat)
        {
            debugger;
            //Added by imran on 14-12-2021
            var AllInfraResFilter = ["InfraName", "RetiredOn", "InfraTypeId", "InfraGroupId", "BusinessGroupID", "LocationID", "InfraStatusId"];
            var filterWhereClause2 = GenerateInfraResourceBasicFilterQueryDownload("Resource", AllInfraResFilter);
            var filterWhereClause = (filterWhereClause2).replace(/"/g, "\''");
            filterWhereClause = "'" + filterWhereClause + "'";
            //End by imran on 14-12-2021
           
            var infraResId = $("#hdnResourceId").val();
            //var taskparameters = { intProxyUserID: '<%= Session("intUserID") %>', employeeID: '<%= Session("intUserID") %>', ReportFormat: ".pdf" }
            var taskparameters = { filterWhereClause:filterWhereClause,employeeID: '<%= Session("intUserID") %>', ReportFormat: ReportFormat, InfraResourceId: infraResId }

            $.ajax({
                url: strUrl + '/api/RM_InfraResources/ExportDocument',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (taskparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? taskparameters : JSON.stringify(taskparameters)));
                    }
                },
                success: function (data) {
                    //alert("Success");
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


                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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

        //Added By Rutuja D. For Bind Filter Placeholder on 15 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }
        function AllBindPlaceHolderFun() {
            BindPlaceholder("txtResourceFilterInfraTypeId", "Infrastructure Type");
            BindPlaceholder("txtResourceFilterBusinessGroupID", "Business Group");
            BindPlaceholder("txtResourceFilterInfraStatusId", "Infrastructure Status");
            BindPlaceholder("txtResourceFilterInfraGroupId", "Infrastructure Group");
            
        }
        //End of Added By Rutuja D. For Bind Filter Placeholder on 15 July 2021

        //Added by Rutuja D. on 22 July 2021 For Total Quantity accept -ve value
        $('#txtTotalQuantity').keypress(function (event) {
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
        //End of Added by Rutuja D. on 22 July 2021 For Total Quantity accept -ve value

       
        function ConvertDate(curdate) {
            //debugger;
            var curdate = curdate.replace(" 00:00:00", "").split('-');
            var cursubmitDate = '';
            var Cdate = curdate[1] + '-' + curdate[0] + '-' + curdate[2];
            var curdate1 = new Date(Cdate);
            var month = curdate1.toLocaleString('en-us', { month: 'short' });
            var date = curdate1.getDate();
            var year = curdate1.getFullYear();
            cursubmitDate = date + ' ' + month + ' ' + year;
            return cursubmitDate;
        }

        //Added By Reshma chavan on 7th Dec 2021
        //Restrict Special Charaters onkeypress
            function restrictSpecialChars(e) {
	            var k;
	            document.all ? k = e.keyCode : k = e.which;
	            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57));
            }


        //Added by imran to download report as per Criteria 14-12-2021
         function GenerateInfraResourceBasicFilterQueryDownload(module, filterField) 
         {
             
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();
                    
                    if (strvalue != "" && strvalue != undefined && strvalue != 0)
                    {
                        //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        strvalue = strvalue.replace(/"/g, '""');
                        //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        //Added By Reshma Chavan on 13th Dec 2021 For Not apply Retiredon Filter correctly
                        strvalue = strvalue.replace(/'/g, "''");
                       //End of Added By Reshma Chavan on 13th Dec 2021 For Not apply Retiredon Filter correctly
                       
                        if (strqtext != "") strqtext += " AND ";
                        if (strOp == "Contains")
                        {
                            //strqtext +='IR.'+ filterField[i] + " LIKE ";
                            strqtext +='a.'+ filterField[i] + " LIKE ";
                            //strqtext += " ''%" + strvalue + "%''";
                            //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "%' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "%' + strvalue + '%"';
                            }
                            //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Ends With") {
                           // strqtext +='IR.'+ filterField[i] + " LIKE ";
                            strqtext +='a.'+ filterField[i] + " LIKE ";
                            // strqtext += " ''%" + strvalue + "''";
                            // Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "' + strvalue + '%"';
                            }
                            //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        }
                        // comment and added by imran on 14-12-2021
                        //else if (strOp == "Exact Word" ) {
                        else if (strOp == "Exact Word" || strOp == "=") {
                            //End Comment 14-12-2021
                           // strqtext += 'IR.'+ filterField[i] + " = ";
                            strqtext += 'a.'+ filterField[i] + " = ";
                            //strqtext += " ''" + strvalue + "''";
                            strqtext += ' "' + strvalue + '"';                          
                        }
                        else if (strOp == "Not Contains") {
                           // strqtext += 'IR.'+ filterField[i] + " ";
                            strqtext += 'a.'+ filterField[i] + " ";
                            //strqtext += " NOT LIKE ''%" + strvalue + "%''";
                            //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' NOT LIKE "%' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' NOT LIKE "%' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' NOT LIKE "%' + strvalue + '%"';
                            }
                            //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Starts With") {
                            //strqtext +='IR.'+ filterField[i] + " LIKE ";
                            strqtext +='a.'+ filterField[i] + " LIKE ";
                            // strqtext += " ''" + strvalue + "%''";
                            //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' "' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "%' + strvalue + '"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "%' + strvalue + '"';
                            }
                            //End of Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                        }

                        else {

                           // strqtext +='IR.'+ filterField[i] + " ";
                            strqtext +='a.'+ filterField[i] + " ";
                            if ($.isNumeric(strvalue) == false) {
                                // strqtext += strOp + " ''" + strvalue + "''";
                                //strqtext += strOp + " ''" + strvalue + "''";

                                strqtext += strOp + " '" + strvalue + "'";
                            }
                            else {

                                //strqtext += strOp + " " + strvalue + "";
                                strqtext += strOp + ' "' + strvalue + '"';
                            }
                        }
                    }
                }

                strqtext = strqtext.replace('Over', '[Over]')
                //Commented By Reshma Chavan on 13th Dec 2021 For Not apply Retiredon Filter correctly
                //strqtext = strqtext.replace(/'/g, "''");
                 //End of Commented By Reshma Chavan on 13th Dec 2021 For Not apply Retiredon Filter correctly
                //strqtext = strqtext.replace(/"/g, "''");
                return strqtext;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        // End by imran 14-12-2021

        //Added By Rutuja D. on 21 Jan 2022
        function Download_Template() {
            window.open ("../../General/ViewAttachment.aspx?FromWhere=Infra_Management&FileName=InfrastructureResourceManagement.xlsx", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
        }
        //End of Added By Rutuja D. on 21 Jan 2022

        function closeFilterPanel() {
            $("#filterpanel").removeClass('show');
        }
    </script>


</body>
</html>
