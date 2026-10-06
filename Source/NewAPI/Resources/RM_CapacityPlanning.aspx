<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_CapacityPlanning.aspx.vb" Inherits="PbNIT.RM_CapacityPlanning" %>

<!DOCTYPE html> 
 
<html>
      <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head runat="server">
   <%-- <meta charset="utf-8" />  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css" --%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1" />
<%--    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

   
</head>
     <style type="text/css">
        a:focus {
            outline: none;
        }

        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        .dataTables_scrollBody.DisableContent {
            height: auto !important
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

            table tr td:last-child .custom_chckbox label:before,
            table tr th:last-child .custom_chckbox label:before {
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

        .statustext {
            margin: 0 0;
            padding: 0;
        }

            .statustext li.bluestatuslbl a span.statustextno {
                background: #41aae0;
            }

            .statustext li span.statustextno {
                width: auto;
                padding: 0 4px;
            }

        .YearNdQuarterdiv .col-sm-6 {
            padding: 0 5px;
        }
        /*conversation panel css start*/

        .newpro_convotablist {
            overflow: hidden;
        }
        /*conversation panel css End*/

        .PRrolename .UpDowncollapseArrow {
            float: right;
            width: 15px;
            margin-right: 5px;
        }

        .UpDowncollapseArrow .downarrow {
            display: inline-block;
            width: 15px;
        }

        tr.collapsiblerow td {
            background: #f1f5f8 !important;
        }

        .JStableOuter {
            margin: 0 0 0px;
        }

            .JStableOuter > table {
                margin-bottom: 0;
            }

                .JStableOuter > table > thead > tr > th {
                    background: #e7edf0;
                    vertical-align: middle !important;
                    padding: 8px;
                }

                .JStableOuter > table > tbody > tr > td {
                    min-width: 86px;
                }

                    .JStableOuter > table > tbody > tr > td:nth-child(1) {
                        min-width: 280px;
                    }


        .JStableOuter2 {
            margin: 0 0 0px;
        }

            .JStableOuter2 > table {
                margin-bottom: 0;
            }

                .JStableOuter2 > table > thead > tr > th {
                    background: #e7edf0;
                    vertical-align: middle !important;
                    padding: 8px;
                }

                .JStableOuter2 > table > tbody > tr > td {
                    min-width: 86px;
                }

                    .JStableOuter2 > table > tbody > tr > td:nth-child(1) {
                        min-width: 280px;
                    }


        .toggleswitch button:focus, .toggleswitch button.active {
            border: 1px solid #ddd;
            outline: none !important;
            background: #1359ac !important; color:#fff;
        }

        .toggleswitch button {
            background: #fff;
        }

        /*popover*/
        /*.popover {
            max-width: 640px;
            min-width: 640px;
        }*/ /*Commented by pradip on 4-8-2021*/

        #popover-content-CPpopover > * {
            background-color: #ff0000 !important;
        }
        /*tble in popover*/
        .skrresourcename {
            margin: 0 0 5px;
        }

        ul.numberlegendsbox {
            margin: 0;
            padding: 0;
            float: right;
        }

        .popoverboxhead p {
            font-size: 12px;
        }

        .numberlegendsbox li {
            display: inline-block;
        }

        .numberlegendsbox button {
            font-size: 12px;
            padding: 2px 14px 2px 8px;
            display: block;
            margin-bottom: 3px; /*Added by pradip on 4-8-2021*/
        }

        .popover-content .table {
            font-size: 12px;
        }

        .numberlegendsbox button {
            background: #e7edf0;
        }
            /*.numberlegendsbox button.btn-default span{ background:#868686;}*/
            .numberlegendsbox button.btn-default span {
                background: none;
                border-left: 1px solid #ddd;
                border-radius: 0;
                top: 0;
                height: 28px;
                margin: -5px -16px -4px 5px;/*modified by pradip on 4-8-2021*/
                line-height: 23px;
                color: #464a4c;
                font-weight: bold;
            }

            .numberlegendsbox button:focus, .numberlegendsbox button:hover {
                border: 1px solid #ddd !important;
                background: #e7edf0;
            }

        /*.numberlegendsbox li span{ border-right:1px solid #ddd;}*/
        .fltrlistbox ul {
            margin: 0;
            padding: 0;
            max-height: 126px;
            overflow: auto;
        }

        .fltrlistbox .fplist_title {
            background: none;
            margin: 0 0 10px;
            padding: 0;
            font-weight: bold;
            font-size: 12px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .fltrlistbox .srchfltr {
            margin: 0 0 10px;
        }

        .JStableOuter > table > thead > tr > th.text-center {
            text-align: center;
        }

        .toggleswitch .btn {
            border-radius: 14px;
        }

        .tab-slider--body {
            margin-bottom: 0;
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 12px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .popover-content .table-responsive {
            max-height: 250px;
            max-width: 400px;
            max-width: 400px;
            overflow: scroll; /*Added by praidp on 4-8-2021*/
        }
        .popover {max-width: auto!important; 
        }
        .popover-content {
            padding: 9px 14px !important;
            width: 100% !important; /*Added by praidp on 4-8-2021*/
        }
            .popover-content .table {
                width: 600px !important;
            }
            .popover-content .table th { white-space:normal; min-width:100px;}
            .popover-content .table th:first-child, .popover-content .table th:nth-child(2){ min-width:200px;}
        .loader {
            border: 16px solid #f3f3f3;
            border-radius: 50%;
            border-top: 16px solid #3498db;
            width: 120px;
            height: 120px;
            -webkit-animation: spin 2s linear infinite; /* Safari */
            animation: spin 2s linear infinite;
        }

        /*#tblBench_wrapper .dataTables_paginate {
            margin-top: 20px;
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
        }*/

        .clsShowHide {
            display: none !important;
        }

        .clsFilterHighlight {
            background: #1359a6 !important;
            color: #ffffff !important;
        }

        .filter button[aria-expanded="true"] {
            background: none;
            color: #1359a6;
            border: none;
            outline: none;
            padding: 0;
            margin: 0;
            width: 28px;
            height: 28px;
            line-height: 28px;
            border-radius: 4px;
        }
.popover-content .table thead th {
    position: sticky;
    top: -1px;
}/*Added by pradip on 28-7-2021*/
 .filedownload .dropdown-toggle::after{ display:none;}

/*.JStableOuter > table > tbody > tr > td { width:auto;}*/
.collapse.show {display: table-row;}
.toggleswitch button {background: #fff;color: #464a4c;}
.popover-body .table-responsive {max-height: 260px;}

    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodyCapacityPalning-group">

    <div class="bgwhite">
        <div class="graybg container-fluid pt-1 pb-1 statckmainheader">
            <div class="row">
                <div class="col-sm-3">
                    <!--<select class="form-control selectpicker">
        <option>Whizible</option>
        <option>Timesheet</option>
        <option>HelpDesk</option>
    </select>-->
                    <h5 class="pgtitle float-start">Capacity Planning</h5>
                </div>
                <div class="col-sm-9 form-inline text-end">
                    <div class="dropdown filedownload float-end">
                        <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" style="margin-top: 4px;"><i data-bs-toggle="tooltip" data-bs-placement="bottom" title="Click here to download" class="fas fa-download"></i></button>
                        <ul class="dropdown-menu">
                            <li><a href="#" onclick="ExportORDemandInfo('PDF')">
                                <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                            <li><a href="#" onclick="ExportORDemandInfo('EXCEL')">
                                <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                            <li><a href="#" onclick="ExportORDemandInfo('XML')">
                                <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                            <li><a href="#" onclick="ExportORDemandInfo('RTF')">
                                <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">RTF</a></li>

                        </ul>

                    </div>
                    <div class="filter inline float-end">
                        <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" id="AdvanceFilterIcon" autocomplete="off"><span data-bs-toggle="tooltip" title="Filter"><i class="fas fa-filter"></i></span></button>
                    </div>
                    <a href="javascript:;" class="clearalllink float-end" style="" onclick="ClearFilter()" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
                    <div class="tab-slider--nav float-end">
                        <ul class="tab-slider--tabs" id="ulMonthqView">
                            <li class="tab-slider--trigger" id="liRCPmonthview" rel="RCPmonthview" data-bs-toggle="tooltip" data-bs-placement="bottom"  title="Month"><span onclick="MonthWiseClick()">Month</span> </li>
                            <li data-bs-toggle="tooltip" id="liRCPQuarterview" data-bs-placement="bottom"  class="tab-slider--trigger" rel="RCPQuarterview" title="Quarter" onclick=" WeekWiseClick();">Quarter</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!--filter panel-->
        <div id="filterpanel" class="filterpanel collapse">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                <div class="Fwrapper">
                    <div class="filterpanelbody row">
                        <div class="col-sm-3">
                            <div class="fltrlistbox fplistbocBG">
                                <div class="fplist_title">Business Group</div>
                                <input type="text" placeholder="Search.." id="myInputBG" class="form-control input-sm srchfltr" onkeyup="filterFunctionBG()" />
                                <span id="spanMyfilterlistBG" style="display: none">No matching record found.</span>

                                <div class="custom_chckbox" id="divCPOUChck0">
                                    <input id="CPBGChck0" class="chckHead" type="checkbox" />
                                    <label for="CPBGChck0">Select All</label>
                                </div>
                                <ul id="myfilterlistBG">
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="fltrlistbox fplistbocOU">
                                <div class="fplist_title">Organization Unit</div>
                                <input type="text" placeholder="Search.." id="myInputOU" class="form-control  input-sm srchfltr" onkeyup="filterFunctionOU()" />
                                <span id="spanMyfilterlistOu" style="display: none">No matching record found.</span>
                                <div class="custom_chckbox" id="SelectAlDUs">
                                    <input id="CPOUChck0" class="chckHead" type="checkbox" />
                                    <label for="CPOUChck0">Select All</label>
                                </div>

                                <ul id="lstBGOU">
                                    <li id="myfilterlistOU"></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="fltrlistbox fplistbocskill">
                                <div class="fplist_title">Skills</div>
                                <input type="text" placeholder="Search.." id="myInputSkill" class="form-control  input-sm srchfltr" onkeyup="filterFunctionSkill()" />
                                <span id="spanMyfilterlistSkill" style="display: none">No matching record found.</span>
                                <div class="custom_chckbox" id="SelectAllSkill">
                                    <input id="CPSkillChck0" class="chckHeadSkill" type="checkbox" />
                                    <label for="CPSkillChck0">Select All</label>
                                </div>
                                <ul id="myfilterlistSkill">
                                </ul>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="fp_button text-center hidden-xs">
                            <a href="javascript:;" class="btn borderbtn" data-bs-toggle="collapse" data-bs-target="#filterpanel" title="" aria-expanded="true">Cancel</a>
                            <a href="javascript:;" class="btn btnyellow" title="" onclick="ApplyFilter()">Apply</a>
                        </div>


                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--end filter panel-->
        <div class="container-fluid pt-1 pb-1">
            <ul class="statustext hidden-xs pt-0">
                <%-- Commented and Modified By RehanC for missing tooltip issue on 27th Mar 2023 --%>
<%--                <li data-bs-toggle="tooltip" data-bs-placement="bottom" title="" class="criticle active" data-original-title="Total Strength"><a href="javascript:;"><span class="statustextno" id="txtTotalStrength"></span>Total Strength</a> </li>
                <li data-bs-toggle="tooltip" data-bs-placement="bottom" title="" class="greenstatuslbl" data-original-title="Allocated"><a href="javascript:;"><span class="statustextno" id="txtAllocated"></span>Allocated</a> </li>
                <li data-bs-toggle="tooltip" data-bs-placement="bottom" title="" class="graystatuslbl" data-original-title="Bench"><a href="javascript:;"><span class="statustextno" id="txtBench"></span>Bench</a> </li>
                <li data-bs-toggle="tooltip" data-bs-placement="bottom" title="" class="overdue" data-original-title="Project Request"><a href="javascript:;"><span class="statustextno" id="txtProjectRequest"></span>Project Request</a> </li>--%>
                <li data-bs-toggle="tooltip" data-bs-placement="bottom"  class="criticle active" title="Total Strength"><a href="javascript:;"><span class="statustextno" id="txtTotalStrength"></span>Total Strength</a> </li>
                <li data-bs-toggle="tooltip" data-bs-placement="bottom"  class="greenstatuslbl" title="Allocated"><a href="javascript:;"><span class="statustextno" id="txtAllocated"></span>Allocated</a> </li>
                <li data-bs-toggle="tooltip" data-bs-placement="bottom"  class="graystatuslbl" title="Bench"><a href="javascript:;"><span class="statustextno" id="txtBench"></span>Bench</a> </li>
                <li data-bs-toggle="tooltip" data-bs-placement="bottom"  class="overdue" title="Project Request"><a href="javascript:;"><span class="statustextno" id="txtProjectRequest"></span>Project Request</a> </li>
                <%-- End of Comment By RehanC for missing tooltip issue on 27th Mar 2023 --%>
              <%-- //Commented By Dipali V On 21st Oct 2021 For Hide Summary Cost--%>
                <%--<li data-bs-toggle="tooltip" data-bs-placement="bottom" title="" class="criticle" data-original-title="Summary Cost"><a href="javascript:;"><span class="statustextno" id="txtSummaryCost">2000</span>Summary Cost</a> </li>--%>
                
                <%--<li data-bs-toggle="tooltip" data-bs-placement="bottom" title="" class="pending" data-original-title="Forecast Revenue"><a href="javascript:;"><span class="statustextno" id="txtForecastRevenue"></span>Forecast Revenue</a> </li>--%>
                 <%--//Commented By Dipali V On 21st Oct 2021 For Hide Summary Cost--%>
                <!--<li data-bs-toggle="tooltip" data-bs-placement="top" title="" class="bluestatuslbl" data-original-title="Help-Desk Tasks"><a href="javascript:;"><span class="statustextno">08</span>Help-Desk Tasks</a></li>-->
            </ul>
        </div>
        <div class="content pt-0">

            <!--Start Ressource Capacity Month View-->
            <div id="RCPmonthview" class="tab-slider--body">
                <div class="JStableOuter">
                    <table class="table table-bordered" style="width: 100%;">
                        <thead id="CP_RoleWiseWeekTh">
                            <tr id="CP_RoleWiseWeekThQuarterYear">
                                <th class="text-center">
                                    <div class="btn-group btn-toggle toggleswitch">
                                        <button class="btn btn-xs active btn-primary" onclick="RoleWiseClick()" id="btnMonthRole">Role</button>
                                        <button class="btn btn-xs btn-default" onclick="SkillWiseClick()" id="btnMonthSkill">Skill</button>
                                    </div>
                                </th>
                                <th colspan="4" id="lblCpMonthFirst"></th>
                                <th colspan="4" id="lblCpMonthSecond"></th>
                                <th colspan="4" id="lblCpMonthThird"></th>
                            </tr>
                            <tr id="lstWeeks">
                            </tr>
                        </thead>
                        <tbody id="CP_RolewiseWeekTbodySummary">
                        </tbody>
                        <tbody id="CP_RolewiseWeekTbody">
                        </tbody>
                    </table>
                </div>
            </div>
            <!--End Ressource Capacity Month View-->
            <div id="popover-content-CPpopover1" class="hide resourceinfopopover">
                <div class="popoverboxhead clearfix">
                    <div class="float-start">
                        <h5 class="skrresourcename" id="lblRoleAllocatedToProject"><strong></strong></h5>
                        <p>Allocated Resources</p>
                    </div>
                    <ul class="numberlegendsbox">
                        <li>
                            <button class="btn btn-default">Cost/Hr <span class="badge" id="lblCostPerHr"></span></button>
                            <button class="btn btn-default">Rate/Hr <span class="badge" id="lblRatePerHr"></span></button>
                        </li>
                    </ul>
                </div>
                <div class="clearfix"></div>
                <div class="table-responsive">
                    <table class="table table-stripped table-bordered" style="width: 100%">
                        <thead>
                            <tr>
                                <th>Resource Name</th>
                                <th>Project Name</th>
                                <th>Project Role</th>
                                <th>Cost/Hr</th>
                                <th>Rate/Hr</th>
                            </tr>
                        </thead>
                        <tbody id="tblAllocatedToProject">
                        </tbody>
                    </table>
                </div>
                <small>No.of Resource allocated on active projects</small>

            </div>
            <div id="popover-content-CPpopover2" class="hide resourceinfopopover">
                <div class="popoverboxhead">
                    <div class="float-start" style="width: 160px;">
                        <h5 class="skrresourcename" id="lblRoleName"><strong></strong></h5>
                        <p>Project Request</p>
                    </div>
                    <ul class="numberlegendsbox">
                        <li>
                            <button type="button" class="btn btn-default">No. of Resources <span class="badge" id="lblNoOfResources"></span></button>
                            <button type="button" class="btn btn-default">Project Cost <span class="badge" id="lblTotalProjectCost"></span></button>
                        </li>
                    </ul>
                </div>
                <div class="clearfix"></div>
                <div class="table-responsive">
                    <table class="table table-stripped table-bordered " style="width: 100%" id="tblProjectRequestLoader">

                        <thead>
                            <tr>
                                <th>Project Name</th>
                                <th>No of Resources</th>
                                <th>Projected Cost</th>
                            </tr>
                        </thead>
                        <tbody id="tblProjectRequest">
                        </tbody>
                    </table>
                </div>
                <small>No.of Resource requested for projects(approved FTE).</small>
            </div>
            <div id="popover-content-CPpopover3" class="hide resourceinfopopover">
                <div class="popoverboxhead">
                    <div class="float-start" style="width: 160px;">
                        <h5 class="skrresourcename" id="lblRoleOpportunityRequest"><strong></strong></h5>
                        <p>Opportunity Requests</p>
                    </div>
                    <ul class="numberlegendsbox">
                        <li>
                            <button type="button" class="btn btn-default">Opportunity Cost <span class="badge" id="lblOpportunityCost"></span></button>
                            <button type="button" class="btn btn-default">Opportunity Value <span class="badge" id="lblOpportunityValue"></span></button>
                        </li>
                    </ul>
                </div>
                <div class="clearfix"></div>
                <div class="table-responsive">
                    <table class="table table-stripped table-bordered" style="width: 100%">
                        <thead>
                            <tr>
                                <th>Opportunity Name</th>
                                <th>No of Resources</th>
                                <th>Opportunity Cost</th>
                                <th>Opportunity Value</th>
                            </tr>
                        </thead>
                        <tbody id="tblOpportunityRequest">
                        </tbody>
                    </table>
                </div>
                <small>No. of Resources requested from approved demands
                </small>
            </div>
            <div id="popover-content-CPpopover4" class="hide resourceinfopopover">

                <div class="popoverboxhead">
                    <div class="float-start">
                        <h5 class="skrresourcename" id="lblRoleBench"><strong></strong></h5>
                        <p>Bench</p>
                    </div>
                    <ul class="numberlegendsbox">
                        <li>
                            <button type="button" class="btn btn-default">Bench Cost <span class="badge" id="lblBenchCost"></span></button>
                        </li>
                    </ul>
                </div>
                <div class="clearfix"></div>
                <div class="table-responsive">
                    <table class="table table-stripped table-bordered" style="width: 100%">
                        <thead>
                            <tr>
                                <th>Resource Name</th>
                                <th>Skill/Role</th>
                                <th>Bench Cost</th>
                            </tr>
                        </thead>
                        <tbody id="tblBenchList">
                        </tbody>
                    </table>
                </div>
                <small>No. of Resources in the organization deployable and not allocated to any billable project.</small>
            </div>
            <div id="popover-content-CPpopover5" class="hide resourceinfopopover">
                <div class="popoverboxhead">
                    <div class="float-start">
                        <h5 class="skrresourcename" id="lblRoleAnticipatedExits"><strong></strong></h5>
                        <p>Anticipated Exists</p>
                    </div>
                    <ul class="numberlegendsbox">
                        <li>
                            <button type="button" class="btn btn-default">No. of Resources <span class="badge" id="lblAENoOfResources"></span></button>
                        </li>
                    </ul>
                </div>
                <div class="clearfix"></div>
                <div class="table-responsive">
                    <table class="table table-stripped table-bordered" style="width: 100%">
                        <thead>
                            <tr>
                                <th>Resource Name</th>
                                <th>Date of Leaving</th>
                                <th>Skill/Role</th>
                            </tr>
                        </thead>
                        <tbody id="tblAnticipatedExitsList">
                        </tbody>
                    </table>
                </div>
                <small>No. of Resources in the organization with a Tentative Leaving date.</small>
            </div>
            <div id="popover-content-CPpopover6" class="hide resourceinfopopover">
                <div class="popoverboxhead">
                    <div class="float-start">
                        <h5 class="skrresourcename" id="lblRoleJoiningPool"><strong></strong></h5>
                        <p>Joining Pool</p>
                    </div>
                    <ul class="numberlegendsbox">
                        <li>
                            <button type="button" class="btn btn-default">Expected Cost <span class="badge" id="lblTotalExpectedCost"></span></button>
                        </li>
                    </ul>
                </div>
                <div class="clearfix"></div>
                <div class="table-responsive">
                    <table class="table table-stripped table-bordered" style="width: 100%">
                        <thead>
                            <tr>
                                <th>Skill/Role</th>
                                <th>No of Resources</th>
                                <th>Expected Cost</th>
                            </tr>
                        </thead>
                        <tbody id="tblJoiningPoolList">
                        </tbody>
                    </table>
                </div>
                <small>No. of Resources Added in the Joining Pool</small>
            </div>



            <!--Ressource Capacity Quarter View-->
            <div id="RCPQuarterview" class="tab-slider--body">
                <div class="JStableOuter">
                    <table class="table table-bordered" style="width: 100%;">
                        <thead id="CP_RoleWiseMonthThThead">
                            <tr id="CP_RoleWiseMonthThQuarterYear">
                                <th class="text-center">
                                    <div class="btn-group btn-toggle toggleswitch">
                                        <%-- <button class="btn btn-xs active btn-primry" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Roll" onclick="RoleWiseClick()" >Role</button>
                                        <button class="btn btn-xs btn-default" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Skill" onclick="SkillWiseClick()" >Skill</button>--%>
                                        <button class="btn btn-xs active btn-primary" onclick="RoleWiseClick()" id="btnQtrRole">Role</button>
                                        <button class="btn btn-xs btn-default" onclick="SkillWiseClick()" id="btnQtrSkill">Skill</button>
                                    </div>
                                </th>
                                <th></th>
                                <th>
                                    <label id="lblCpQuarterFirst"></label>
                                </th>
                                <th></th>
                                <th></th>
                                <th>
                                    <label id="lblCpQuarterSecond"></label>
                                </th>
                                <th></th>
                                <th></th>
                                <th>
                                    <label id="lblCpQuarterThird"></label>
                                </th>
                                <th></th>
                                <th></th>
                                <th>
                                    <label id="lblCpQuarterFourth"></label>
                                </th>
                                <th></th>
                            </tr>
                            <tr id="CP_RoleWiseMonthTh">
                            </tr>
                        </thead>

                        <tbody id="CP_RolewiseMonthTbodySummary">
                        </tbody>

                        <tbody id="CP_RolewiseMonthTbody">
                        </tbody>
                    </table>
                </div>
                <!--Ressource Capacity Quarterly View End-->
            </div>
            <!--Ressource Capacity Quarter View-->



            <div class="clearfix"></div>

            <div class="clearfix"></div>
        </div>
    </div>


    <!-- REQUIRED JS SCRIPTS -->
    
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
 --%>  <%-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>
        var NoDataFound = "No data found.";
        $("[data-bs-toggle='dropdown'], [data-bs-toggle='collapse']").tooltip();
        $("[data-bs-toggle='tooltip']").tooltip();

        $('.JStableOuter .btn-toggle').click(function () {
            $(this).find('.btn').toggleClass('active');
            if ($(this).find('.btn-primary').size() > 0) {
                $(this).find('.btn').toggleClass('btn-primary');
            }

        });



        //jquery for weekly and daily view calendar
        //weeekly and daily tab
        $(".tab-slider--body").hide();
        $(".tab-slider--body:first").show();
        //$("#dailyviewcal").show();
        $(".tab-slider--nav li").click(function () {
            $(".tab-slider--body").hide();
            var activeTab = $(this).attr("rel");
            $("#" + activeTab).fadeIn();
            if ($(this).attr("rel") == "RCPQuarterview") {
                $('.tab-slider--tabs').addClass('slide');
            } else {
                $('.tab-slider--tabs').removeClass('slide');
            }
            $(".tab-slider--nav li").removeClass("active");
            $(this).addClass("active");
        });

        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var strUrl = '';
        var TagID = '<%= m_TagId%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var IsMonthWise = true;
        var IsSkillWise = false;
        var IsRoleWise = true;
        var IsWeekWise = false;


        $(document).ready(function () {
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';

            if (blnViewAccess == "True") {
                FilterNotApplied();
                GetCapacityPlanningRoleMonthList();
                // GetCapacityPlanningSkillMonthList();
                GetCapacityPlanningHeader();
            }
            else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";
            }

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

            GetCapacityPlanBGFilterList();
            GetCapacityPlanOUFilterList();
            GetCapacityPlanSkillFilterList();




        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({
                'height': tblheight - 280,
                "overflow-y": "auto"
            });
            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({
                'height': tblheight - 80
            });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
            setTimeout(function () {
                $.fn.dataTable.tables({
                    visible: true,
                    api: true
                }).columns.adjust();
            }, 0);
        });
        $("#filterpanel").on("show.bs.collapse", function () {

            //$(".filter >  button").removeClass("clsFilterHighlight");
            //FilterNotApplied();
            //$(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            // $(".clearalllink").hide();
            //$(".filter >  button").removeClass("clsFilterHighlight");

        });
        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        //$(".chckHead").change(function () {
        //    var checked = $(this).is(':checked');
        //    if (checked) {
        //        $(".chcktbl").each(function () {
        //            $(this).prop("checked", true);
        //        });
        //    } else {
        //        $(".chcktbl").each(function () {
        //            $(this).prop("checked", false);
        //        });
        //    }
        //});
        //// Changing state of CheckAll checkbox
        //$(".chcktbl").click(function () {
        //    if ($(".chcktbl").length == $(".chcktbl:checked").length) {
        //        $(".chckHead").prop("checked", true);
        //    } else {
        //        $(".chckHead").removeAttr("checked");
        //    }
        //});



        //dynamically set height
        function resizeSection(tag) {
            var JStableOuter = $(window).height();


            $('.JStableOuter > table, .PRweekdaytbl td::after').css({ 'height': JStableOuter - 122, "overflow-y": "auto" });

            $(".PRweekdaytbl td::after").css({ 'height': JStableOuter });

        }

        function resizeSection2(tag) {
            var JStableOuter2 = $(window).height();

            $('.JStableOuter2 > table, .PRweekdaytbl td::after').css({ 'height': JStableOuter - 122, "overflow-y": "auto" });

            $(".PRweekdaytbl td::after").css({ 'height': JStableOuter2 });

        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
            ///resizeSection2(this);
        });

        //freez table
        $('.JStableOuter > table').scroll(function (e) {

                $('.JStableOuter > table > thead').css("left", -$(".JStableOuter > tbody").scrollLeft());
                $('.JStableOuter > table > thead > tr > th:nth-child(1)').css("left", $(".JStableOuter > table").scrollLeft() - 0);
                $('.JStableOuter > table > tbody > tr > td:nth-child(1)').css("left", $(".JStableOuter > table").scrollLeft());


                $('.JStableOuter > table > thead').css("top", -$(".JStableOuter > tbody").scrollTop());
                $('.JStableOuter > table > thead > tr > th').css("top", $(".JStableOuter > table").scrollTop());

            });

        $('.JStableOuter2 > table').scroll(function (e) {

            $('.JStableOuter2 > table > thead').css("left", -$(".JStableOuter2 > tbody").scrollLeft());
            $('.JStableOuter2 > table > thead > tr > th:nth-child(1)').css("left", $(".JStableOuter2 > table").scrollLeft() - 0);
            $('.JStableOuter2 > table > tbody > tr > td:nth-child(1)').css("left", $(".JStableOuter2 > table").scrollLeft());

            $('.JStableOuter2 > table > thead > tr > th:nth-child(2)').css("left", $(".JStableOuter2 > table").scrollLeft() - 0);
            $('.JStableOuter2 > table > tbody > tr > td:nth-child(2)').css("left", $(".JStableOuter2 > table").scrollLeft());

            //alert($(".JStableOuter > table").scrollTop());
            $('.JStableOuter2 > table > thead').css("top", -$(".JStableOuter2 > tbody").scrollTop());
            $('.JStableOuter2 > table > thead > tr > th').css("top", $(".JStableOuter2 > table").scrollTop());

        });



        //colappse row
        //$(".UpDowncollapseArrow").click(function () {
        //    $(this).toggleClass("in");
        //    $(this).closest("tr").toggleClass("activerow");

        //});

        $(document).on("click", ".UpDowncollapseArrow", function () {
            $(this).toggleClass("in");
            $(this).closest("tr").toggleClass("activerow");
        })


        //script for pophover        
        //$("[data-bs-toggle=popover]").each(function (i, obj) {
        //    console.log("this");
        //    console.log(this);
        //    $(this).popover({
        //        html: true,
        //        "trigger": "click",
        //        content: function () {
        //            var id = $(this).attr('id')
        //            alert(id);
        //            return $('#popover-content-' + id).html();
        //        }
        //    });
        //});

        function OpenToolTip(id, id1) {


            $("[id=" + id1 + "]").popover({
                html: true,
                sanitize: false,
                "trigger": "manual",
                content:
                    function () {

                        return $('#popover-content-' + id).html();
                    }
            }).popover('show');

            $(".JStableOuter > table").on('scroll', function () {
                $('.popover').hide();
            });//Added script by pradip on 28-7-2021
        }

        $('body').on('click', function (e) {
            $('.popover').hide()
            //$('[data-bs-toggle="popover"]').each(function () {
            //    console.log('e.target');
            //    console.log(e.target);
            //    if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
            //        $(this).popover('hide');
            //    }
            //});
        });

        //end script for popover

        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        //$(".fplistbocBG .chckHead").change(function () {
        //    var checked = $(this).is(':checked');
        //    if (checked) {
        //        $(".chcktbl").each(function () {
        //            $(this).prop("checked", true);
        //        });
        //    } else {
        //        $(".chcktbl").each(function () {
        //            $(this).prop("checked", false);
        //        });
        //    }
        //});
        //$(".fplistbocOU .chckHead").change(function () {
        //    var checked = $(this).is(':checked');
        //    if (checked) {
        //        $(".chcktbl").each(function () {
        //            $(this).prop("checked", true);
        //        });
        //    } else {
        //        $(".chcktbl").each(function () {
        //            $(this).prop("checked", false);
        //        });
        //    }
        //});
        $(".chckHead").change(function () {

            var checked = $(this).is(':checked');
            if (checked) {
                $(this).closest(".fltrlistbox").find(".chcktbl").each(function () {
                    $(this).prop("checked", true);
                });
                SelectAllBGs();


            } else {
                $(this).closest(".fltrlistbox").find(".chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
                //alert('mmm');
                $('#SelectAlDUs').show();
                lstBGOUs = [];
                $("#myfilterlistOU").append("");
                $("#lstBGOU").html("");

                GetCapacityPlanOUFilterList();


            }
        });

        $(".chckHeadSkill").change(function () {

            var checked = $(this).is(':checked');
            if (checked) {
                $(this).closest(".fltrlistbox").find(".chcktbl").each(function () {
                    $(this).prop("checked", true);
                });

            } else {
                $(this).closest(".fltrlistbox").find(".chcktbl").each(function () {
                    $(this).prop("checked", false);
                });

            }
        });


        //Changing state of CheckAll checkbox
        $(".chcktbl").click(function () {

            if ($(this).closest(".fltrlistbox").find(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(this).closest(".fltrlistbox").find(".chckHead").removeAttr("checked");
                $(this).closest(".fltrlistbox").find(".chckHead").prop("checked", false);
            }

        });

        //Filter list
        function filterFunctionBG() {
            $("#divCPOUChck0").hide();
            var input, filter, ul, li, a, i;
            input = document.getElementById("myInputBG");
            filter = input.value.toUpperCase();
            div = document.getElementById("myfilterlistBG");
            a = div.getElementsByTagName("li");
            var isRecordExistBg = [];
            $("#spanMyfilterlistBG").hide();
            for (i = 0; i < a.length; i++) {
                txtValue = a[i].textContent || a[i].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                    isRecordExistBg.push(i);
                } else {
                    a[i].style.display = "none";
                }
            }
            if (input.value.toUpperCase() == '' || input.value.toUpperCase() == 'undefined') {
                $("#divCPOUChck0").show();
            }
            if (isRecordExistBg.length < 1 && isRecordExistBg != null) {
                $("#spanMyfilterlistBG").show();
            }
        }
        function filterFunctionOU() {
            var input, filter, ul, li, a, i;
            input = document.getElementById("myInputOU");
            $("#SelectAlDUs").hide()
            filter = input.value.toUpperCase();
            div = document.getElementById("lstBGOU");
            a = div.getElementsByTagName("li");
            var isRecordExistOu = [];
            $("#spanMyfilterlistOu").hide();
            for (i = 0; i < a.length; i++) {
                txtValue = a[i].textContent || a[i].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                    isRecordExistOu.push(i);
                } else {
                    a[i].style.display = "none";
                }
            }
            if (input.value.toUpperCase() == '' || input.value.toUpperCase() == 'undefined') {
                $("#SelectAlDUs").show();
            }
            if (isRecordExistOu.length < 1 && isRecordExistOu != null) {
                $("#spanMyfilterlistOu").show();
            }

        }
        function filterFunctionSkill() {
            var input, filter, ul, li, a, i;
            input = document.getElementById("myInputSkill");
            filter = input.value.toUpperCase();
            div = document.getElementById("myfilterlistSkill");
            a = div.getElementsByTagName("li");
            var isRecordExistSkill = [];
            $("#spanMyfilterlistSkill").hide();
            for (i = 0; i < a.length; i++) {
                txtValue = a[i].textContent || a[i].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                    isRecordExistSkill.push(i)
                } else {
                    a[i].style.display = "none";
                }
            }
            if (isRecordExistSkill.length < 1 && isRecordExistSkill != null) {
                $("#spanMyfilterlistSkill").show();
                $("#SelectAllSkill").hide()
            } else {
                $("#SelectAllSkill").show()
            }
        }


        function MonthWiseClick()
        {          
            if ($('#btnMonthRole').hasClass('active')) {
                //Added by imran 15-12-2021 for toggle button color change 
                document.getElementById("btnMonthRole").disabled = true;
                document.getElementById("btnMonthSkill").disabled = false;
                //End by imran 15-12-2021 for toggle button color change
            }
            else {
                //Added by imran 15-12-2021 for toggle button color change 
                document.getElementById("btnMonthRole").disabled = false;
                document.getElementById("btnMonthSkill").disabled = true;
                //End by imran 15-12-2021 for toggle button color change
            }

            //RoleWiseClick();
            ClearOnSwitchRolenSkillWise();
            IsMonthWise = true;
            IsWeekWise = false;
            if (IsRoleWise === true || IsRoleWise == 'true') {

                //if ((filterParams.SkillList != null && filterParams.SkillList.length > 0) || (filterParams.BGOUFilter != null && filterParams.BGOUFilter.length > 0)) {
                //    ApplyFilter();
                //}
                //else {
                // btnMonthSkill
                if ($('#btnMonthRole').hasClass('active')) {
                    GetCapacityPlanningRoleMonthList();
                } else {
                    GetCapacityPlanningSkillMonthList();
                }
                //}
                IsWeekWise = false;
            }
            else {
                //if ((filterParams.SkillList != null && filterParams.SkillList.length > 0) || (filterParams.BGOUFilter != null && filterParams.BGOUFilter.length > 0)) {
                //    ApplyFilter();
                //}
                //else {
                if ($('#btnMonthRole').hasClass('active')) {
                    GetCapacityPlanningRoleMonthList();
                } else {
                    GetCapacityPlanningSkillMonthList();
                }

                // }
                IsRoleWise = false;
            }
        }

        function WeekWiseClick()
        {
            //Added by imran 15-12-2021 for toggle button color change            
            document.getElementById("btnQtrRole").disabled = true; 
            document.getElementById("btnQtrSkill").disabled = false; 
            //End by imran 15-12-2021 for toggle button color change

            //var ReportsTab = $('#liRCPQuarterview').hasClass('active');
            ///ClearFilter();
            ClearOnSwitchRolenSkillWise();
            IsWeekWise = true;
            IsMonthWise = false;

            if (IsRoleWise === true || IsRoleWise == 'true') {
                //if ((filterParams.SkillList != null && filterParams.SkillList.length > 0) || (filterParams.BGOUFilter != null && filterParams.BGOUFilter.length > 0)) {
                //    ApplyFilter();
                //}
                //else {

                if ($('#btnQtrRole').hasClass('active')) {
                    GetCapacityPlanningList();
                } else {
                    GetCapacityQtrSkillWisePlanList();
                }

                //}

                IsSkillWise = false;

            }
            else {
                //if ((filterParams.SkillList != null && filterParams.SkillList.length > 0) || (filterParams.BGOUFilter != null && filterParams.BGOUFilter.length > 0)) {
                //    ApplyFilter();
                //}
                //else {
                if ($('#btnQtrRole').hasClass('active')) {
                    GetCapacityPlanningList();
                } else {
                    GetCapacityQtrSkillWisePlanList();
                }


                // }

                IsRoleWise = false;
            }
        }

        function RoleWiseClick()
        {
            //Added by imran 15-12-2021 for toggle button color change
            document.getElementById("btnMonthRole").disabled = true;
            document.getElementById("btnQtrRole").disabled = true;
            document.getElementById("btnQtrSkill").disabled = false;
            document.getElementById("btnMonthSkill").disabled = false;
            //End by imran 15-12-2021 for toggle button color change

            //var sunTabb = $('#btnMonthRole').hasClass('active');
            IsRoleWise = true;
            IsSkillWise = false;
            //ClearFilter();
            ClearOnSwitchRolenSkillWise();

            if (IsWeekWise === true || IsWeekWise == 'true') {
                //if ((filterParams.SkillList != null && filterParams.SkillList.length > 0) || (filterParams.BGOUFilter != null && filterParams.BGOUFilter.length > 0)) {
                //    ApplyFilter();
                //}
                //else {
                //    //alert('GetCapacityPlanningList');
                GetCapacityPlanningList();
                //}
                IsMonthWise = false;

            }
            else {
                //// alert('GetCapacityPlanningRoleMonthList');
                //if ((filterParams.SkillList != null && filterParams.SkillList.length > 0) || (filterParams.BGOUFilter != null && filterParams.BGOUFilter.length > 0)) {
                //    ApplyFilter();
                //}
                //else {
                GetCapacityPlanningRoleMonthList();
                //}

                IsWeekWise = false;

            }
        }

        function SkillWiseClick()
        {
            //Added by imran 15-12-2021 for toggle button color change
            document.getElementById("btnMonthRole").disabled = false;
            document.getElementById("btnQtrRole").disabled = false;
            document.getElementById("btnQtrSkill").disabled = true;
            document.getElementById("btnMonthSkill").disabled = true;
            //End by imran 15-12-2021 for toggle button color change

            //var sunTabb = $('#btnMonthRole').hasClass('active');
            IsRoleWise = false;
            IsSkillWise = true;
            //ClearFilter();
            ClearOnSwitchRolenSkillWise();
            if (IsWeekWise === true || IsWeekWise == 'true' || IsWeekWise == true) {
                //if ((filterParams.SkillList != null && filterParams.SkillList.length > 0) || (filterParams.BGOUFilter != null && filterParams.BGOUFilter.length > 0)) {
                //    ApplyFilter();
                //}
                //else {

                GetCapacityQtrSkillWisePlanList();
                // }
                IsMonthWise = false;

            }
            else {
                //if ((filterParams.SkillList != null && filterParams.SkillList.length > 0) || (filterParams.BGOUFilter != null && filterParams.BGOUFilter.length > 0)) {
                //    ApplyFilter();

                //}
                //else {

                GetCapacityPlanningSkillMonthList();
                //}
                IsWeekWise = false;

            }

        }

        function GetCapacityPlanningHeader() {
            var strHTML = "";
            //var objCP = { CompanyInfoID: '1' }
            StartLoader("#bodyCapacityPalning-group");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityPlanHeaderCounts',
                type: "POST",
                data: JSON.stringify(SessionEmployeeId),
                contentType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (SessionEmployeeId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(SessionEmployeeId) ? SessionEmployeeId : JSON.stringify(SessionEmployeeId)));
                    }
                },
                success: function (data) {

                    $("#txtTotalStrength").text(data.TotalStrength);
                    $("#txtAllocated").text(data.Allocated);
                    $("#txtBench").text(data.Bench);
                    $("#txtProjectRequest").text(data.ProjectRequests);
                     //Commented By Dipali V On 21st Oct 2021 For Hide Summary Cost
                   // $("#txtSummaryCost").text(data.Currency + ' ' + data.SummaryCost);
                     
                    //$("#txtForecastRevenue").text(data.Currency + ' ' + data.ForecastRevenue);
                    //End of Commented By Dipali V On 21st Oct 2021 For Hide Summary Cost
                    StopAjaxLoader("#bodyCapacityPalning-group");
                    ///loadDataTable();
                    GetCapacityPlanningList();

                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    //alert("1"+err);
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyCapacityPalning-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyCapacityPalning-group");
                }
                //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

        }

        function GetCapacityPlanningList(filterParams) {

            //$("#CP_RolewiseMonthTbody").html('');
            var strHTMLHeader = "";
            var strHTML = "";
            var strHTMLSummary = "";
            if (filterParams == null || filterParams == "undefined") {
                filterParams =
                {
                    BGOUType: "",
                    BGOUFilter: "",
                    SkillList: ""
                }
            }

            StartLoader("#bodyCapacityPalning-group");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityRolePlanList',
                method: 'POST',
                data: JSON.stringify(filterParams),
                dataType: 'json',
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (filterParams) {
                        xhr.setRequestHeader("Params", encryptString(isJson(filterParams) ? filterParams : JSON.stringify(filterParams)));
                    }
                },
                success: function (data) {

                    if (data != null || data != 'undefined' || data != '') {

                        ///Bind Header of month
                        var CpList_MonthHeader = data["CpMonthsListHeader"];
                        var CpList_List = data["CpMonthsList"];
                        strHTMLHeader += '<th> </th>';
                        if (CpList_MonthHeader != null && CpList_MonthHeader != 'undefined' && CpList_MonthHeader.length > 0) {
                            $.each(CpList_MonthHeader, function (indexMonthHeader, objMonthHeader) {
                                strHTMLHeader += '<th> ' + objMonthHeader.Name + '</th>';
                            });
                        } else {
                            strHTMLHeader += '<tr><th><td class="text-center" colspan="6">' + NoDataFound + '</td></th></tr>';
                        }
                        //Set Header
                        if (CpList_MonthHeader != null && CpList_MonthHeader != 'undefined' && CpList_MonthHeader.length > 0) {
                            $("#lblCpQuarterFirst").text(CpList_MonthHeader[0].Quarter + " " + CpList_MonthHeader[0].Year);
                            $("#lblCpQuarterSecond").text(CpList_MonthHeader[4].Quarter + " " + CpList_MonthHeader[4].Year)
                            $("#lblCpQuarterThird").text(CpList_MonthHeader[7].Quarter + " " + CpList_MonthHeader[7].Year)
                            $("#lblCpQuarterFourth").text(CpList_MonthHeader[10].Quarter + " " + CpList_MonthHeader[10].Year)

                        }

                        $("#CP_RoleWiseMonthTh").html(strHTMLHeader);

                        var CpListSummary = data["Cp_MonthListSummary"];
                        var CpList_SurplusDeficit = data["CpSurplusdeficit"];
                        if (CpListSummary != "" && CpListSummary != null && CpListSummary.length > 0) {
                            $('[data-bs-toggle="tooltip"]').tooltip(); //Added by pradip on 30-7-2021
                            //modified toopltip by pradip on 30-7-2021
                            strHTMLSummary += "<tr class='collapsiblerow'> <td class='PRrolename'>Surplus/Deficit<a class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' data-bs-target='.CPhiderow_11" + "' title=''>" +
                                " <img class='uparrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' title='Hide Task'>" +
                                "<img class='downarrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/down.svg' alt='View Task' width='15px' title='View Task'> </a></td>";//end modification



                            strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_1 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_2 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_3 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_4 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_5 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_6 + "</td>";
                            strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_7 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_8 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_9 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_10 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_11 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_12 + "</td>";

                            strHTMLSummary += "</tr>";

                            $.each(CpListSummary, function (indexMonths, objMonthsSummary) {

                                strHTMLSummary += "<tr class='CPhiderow_11 collapse'><td>" + objMonthsSummary.Name + "</td><td>" + objMonthsSummary.Month_1Sum + "</td> <td>" + objMonthsSummary.Month_2Sum + "</td> <td>" + objMonthsSummary.Month_3Sum + "</td><td>" + objMonthsSummary.Month_4Sum + "</td> <td>" + objMonthsSummary.Month_5Sum + "</td> " +
                                    "<td>" + objMonthsSummary.Month_6Sum + "</td><td>" + objMonthsSummary.Month_7Sum + "</td><td>" + objMonthsSummary.Month_8Sum + "</td><td>" + objMonthsSummary.Month_9Sum + "</td><td>" + objMonthsSummary.Month_10Sum + "</td>  <td>" + objMonthsSummary.Month_11Sum + "</td><td>" + objMonthsSummary.Month_12Sum + "</td></tr>";
                            });
                            $("#CP_RolewiseMonthTbodySummary").html(strHTMLSummary)

                        } else {
                            //strHTMLSummary = "<tr class='CPhiderow_11 collapse'><td>0</td><td>0</td> <td>0</td> <td>0</td><td>0</td> <td>0</td> " +
                            //      "<td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>  <td>0</td><td>0</td></tr>";
                            $("#CP_RolewiseMonthTbodySummary").html(strHTMLSummary)
                        }
                        strHTML = '';
                        if (CpList_List != null && CpList_List != 'undefined' && CpList_List.length > 0) {
                            $.each(CpList_List, function (index, objRole) {
                                strHTML += "<tr class='collapsiblerow'> <td class='PRrolename'> " + objRole.RoleDescription + " <a  class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' data-bs-target='.CPhiderow_" + index + "' title='View Task' >" +
                                    " <img class='uparrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' title='Hide Task'>" +
                                    "<img class='downarrow' data-bs-toggle='tooltip' data-bs-placement='top'  src='../../../Whizible2.0-new/dist/img/down.svg' alt='View Task' width='15px' title='View Task'> </a></td><td></td><td></td><td></td><td></td><td></td>" +
                                    "<td></td><td></td><td></td> <td></td><td></td> <td></td><td></td></tr>";

                                $.each(objRole["Cp_list"], function (indexMonths, objMonths) {

                                    strHTML += "<tr class='CPhiderow_" + index + " collapse'><td>" + objMonths.Name + "</td><td><a href='javascript:;' class='openPopover' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover1" + indexMonths + objMonths.RoleID + "'onclick=\"(ToolTipClick('" + objMonths.Name + "','" + objMonths.RoleID + "','" + CpList_MonthHeader[0].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 1 + "," + 1 + ",'CPpopover1" + indexMonths + objMonths.RoleID + "',"+objMonths.Month_1+"))\" '>" + objMonths.Month_1 + "</a></td> <td><a href='javascript:;' class='openPopover' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover2" + indexMonths + objMonths.RoleID + "' onclick=\"(ToolTipClick('" + objMonths.Name + "','" + objMonths.RoleID + "','" + CpList_MonthHeader[1].MonthDate + "','" + CpList_MonthHeader[1].MonthDate + "'," + 1 + "," + 1 + ",'CPpopover2" + indexMonths + objMonths.RoleID + "',"+objMonths.Month_2+"))\" '>" + objMonths.Month_2 + "</a></td> <td><a href='javascript:;' class='openPopover' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover3" + indexMonths + objMonths.RoleID + "' onclick=\"(ToolTipClick('" + objMonths.Name + "','" + objMonths.RoleID + "','" + CpList_MonthHeader[2].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 1 + "," + 1 + ",'CPpopover3" + indexMonths + objMonths.RoleID + "',"+objMonths.Month_3+"))\"'>" + objMonths.Month_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover4" + indexMonths + objMonths.RoleID + "' onclick=\"(ToolTipClick('" + objMonths.Name + "','" + objMonths.RoleID + "','" + CpList_MonthHeader[3].MonthDate + "','" + CpList_MonthHeader[3].MonthDate + "'," + 1 + "," + 1 + ",'CPpopover4" + indexMonths + objMonths.RoleID + "',"+objMonths.Month_4+"))\"'>" + objMonths.Month_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover5" + indexMonths + objMonths.RoleID + "' onclick=\"(ToolTipClick('" + objMonths.Name + "','" + objMonths.RoleID + "','" + CpList_MonthHeader[4].MonthDate + "','" + CpList_MonthHeader[4].MonthDate + "'," + 1 + "," + 1 + ",'CPpopover5" + indexMonths + objMonths.RoleID + "',"+objMonths.Month_5+"))\"'>" + objMonths.Month_5 + "</a></td> " +
                                        "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover6" + indexMonths + objMonths.RoleID + "' onclick=\"(ToolTipClick('" + objMonths.Name + "','" + objMonths.RoleID + "','" + CpList_MonthHeader[5].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 1 + "," + 1 + ",'CPpopover6" + indexMonths + objMonths.RoleID + "',"+objMonths.Month_6+"))\"'>" + objMonths.Month_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover7" + indexMonths + objMonths.RoleID + "' onclick=\"(ToolTipClick('" + objMonths.Name + "','" + objMonths.RoleID + "','" + CpList_MonthHeader[6].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 1 + "," + 1 + ",'CPpopover7" + indexMonths + objMonths.RoleID + "',"+objMonths.Month_7+"))\"'>" + objMonths.Month_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover8" + indexMonths + objMonths.RoleID + "' onclick=\"(ToolTipClick('" + objMonths.Name + "','" + objMonths.RoleID + "','" + CpList_MonthHeader[7].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 1 + "," + 1 + ",'CPpopover8" + indexMonths + objMonths.RoleID + "',"+objMonths.Month_8+"))\"'>" + objMonths.Month_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover9" + indexMonths + objMonths.RoleID + "' onclick=\"(ToolTipClick('" + objMonths.Name + "','" + objMonths.RoleID + "','" + CpList_MonthHeader[8].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 1 + "," + 1 + ",'CPpopover9" + indexMonths + objMonths.RoleID + "',"+objMonths.Month_9+"))\"'>" + objMonths.Month_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover10" + indexMonths + objMonths.RoleID + "' onclick=\"(ToolTipClick('" + objMonths.Name + "','" + objMonths.RoleID + "','" + CpList_MonthHeader[9].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 1 + "," + 1 + ",'CPpopover10" + indexMonths + objMonths.RoleID + "',"+objMonths.Month_10+"))\"'>" + objMonths.Month_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover11" + indexMonths + objMonths.RoleID + "' onclick=\"(ToolTipClick('" + objMonths.Name + "','" + objMonths.RoleID + "','" + CpList_MonthHeader[10].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 1 + "," + 1 + ",'CPpopover11" + indexMonths + objMonths.RoleID + "',"+objMonths.Month_11+"))\"'>" + objMonths.Month_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover12" + indexMonths + objMonths.RoleID + "' onclick=\"(ToolTipClick('" + objMonths.Name + "','" + objMonths.RoleID + "','" + CpList_MonthHeader[11].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 1 + "," + 1 + ",'CPpopover12" + indexMonths + objMonths.RoleID + "',"+objMonths.Month_12+"))\"'>" + objMonths.Month_12 + "</a></td></tr>";


                                });
                            });

                        }
                        else {

                            StopAjaxLoader("#bodyCapacityPalning-group");
                            strHTML += '<tr> <td style="width:25%"></td> <td colspan="13"  style="text-align: center">' + NoDataFound + '</td></tr>';
                        }

                        ///Bind the Role and Chiled tr

                        $("#CP_RolewiseMonthTbody").html(strHTML);

                        StopAjaxLoader("#bodyCapacityPalning-group");

                    }
                    else {
                        //alert("No Data Found");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("No Data Found");
                        StopAjaxLoader("#bodyCapacityPalning-group");
                    }


                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    // alert(err);
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyCapacityPalning-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyCapacityPalning-group");
                }
                //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

        }

        ///Skil wise 
        function GetCapacityQtrSkillWisePlanList(filterParams) {
            var strHTMLHeader = "";
            var strHTML = "";
            var strHTMLSummarySkill = "";
            if (filterParams == null || filterParams == "undefined") {
                filterParams =
                {
                    BGOUType: "",
                    BGOUFilter: "",
                    SkillList: ""
                }
            }

            StartLoader("#bodyCapacityPalning-group");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityQtrSkillWisePlanList',
                method: 'POST',
                data: JSON.stringify(filterParams),
                dataType: 'json',
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (filterParams) {
                        xhr.setRequestHeader("Params", encryptString(isJson(filterParams) ? filterParams : JSON.stringify(filterParams)));
                    }
                },
                success: function (data) {
                    if (data != null && data != 'undefined' && data != '') {
                        ///Bind Header of month
                        var CpList_MonthHeader = data["CpMonthsListHeader"];
                        //strHTMLHeader += '<th> </th>';
                        //if (CpList_MonthHeader.length > 0) {
                        //    $.each(CpList_MonthHeader, function (indexMonthHeader, objMonthHeader) {
                        //        strHTMLHeader += '<th> ' + objMonthHeader.Name + '</th>';
                        //    });
                        //} else {
                        //    strHTMLHeader += '<tr><th><td class="text-center" colspan="6">' + NoDataFound + '</td></th></tr>';
                        //}
                        ////Set Header
                        //if (CpList_MonthHeader.length > 0) {
                        //    $("#lblCpQuarterFirst").text(CpList_MonthHeader[0].Quarter + " " + CpList_MonthHeader[0].Year);
                        //    $("#lblCpQuarterSecond").text(CpList_MonthHeader[4].Quarter + " " + CpList_MonthHeader[4].Year)
                        //    $("#lblCpQuarterThird").text(CpList_MonthHeader[7].Quarter + " " + CpList_MonthHeader[7].Year)
                        //    $("#lblCpQuarterFourth").text(CpList_MonthHeader[10].Quarter +" "+CpList_MonthHeader[10].Year)

                        //}

                        ////$("#tblCpMonthView").find("thead").find("#CP_MonthTh").html(strHTMLHeader)
                        // $("#CP_RoleWiseMonthTh").html(strHTMLHeader);
                        //$("#CP_RoleWiseMonthThThead").html(strHTMLHeader);

                        var CpListSkillSummary = data["Cp_MonthListSummary"];
                        var CpList_SurplusDeficit = data["CpSurplusdeficit"];
                        var CpList_List = data["CpMonthsList"];
                        if ((CpListSkillSummary != null && CpListSkillSummary != 'undefined' && CpListSkillSummary.length > 0) && (CpList_List != null && CpList_List.length > 0)) {

                            strHTMLSummarySkill += "<tr class='collapsiblerow'> <td class='PRrolename'>Surplus/Deficit<a class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' data-bs-target='.CPhiderow_11" + "' title='View Task' >" +
                                " <img class='uparrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' title='Hide Task'>" +
                                "<img class='downarrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/down.svg' alt='View Task' width='15px' title='View Task'> </a></td>";

                            strHTMLSummarySkill += " <td>" + CpList_SurplusDeficit.SurplusDeficit_1 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_2 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_3 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_4 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_5 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_6 + "</td>";
                            strHTMLSummarySkill += " <td>" + CpList_SurplusDeficit.SurplusDeficit_7 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_8 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_9 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_10 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_11 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_12 + "</td>";

                            strHTMLSummarySkill += "</tr>";

                            $.each(CpListSkillSummary, function (indexMonths, objSkillMonthsSummary) {
                                strHTMLSummarySkill += "<tr class='CPhiderow_11 collapse'><td>" + objSkillMonthsSummary.Name + "</td><td>" + objSkillMonthsSummary.Month_1Sum + "</td> <td>" + objSkillMonthsSummary.Month_2Sum + "</td> <td>" + objSkillMonthsSummary.Month_3Sum + "</td><td>" + objSkillMonthsSummary.Month_4Sum + "</td> <td>" + objSkillMonthsSummary.Month_5Sum + "</td> " +
                                    "<td>" + objSkillMonthsSummary.Month_6Sum + "</td><td>" + objSkillMonthsSummary.Month_7Sum + "</td><td>" + objSkillMonthsSummary.Month_8Sum + "</td><td>" + objSkillMonthsSummary.Month_9Sum + "</td><td>" + objSkillMonthsSummary.Month_10Sum + "</td>  <td>" + objSkillMonthsSummary.Month_11Sum + "</td><td>" + objSkillMonthsSummary.Month_12Sum + "</td></tr>";
                            });
                            $("#CP_RolewiseMonthTbodySummary").html(strHTMLSummarySkill)

                        } else {
                            $("#CP_RolewiseMonthTbodySummary").html(strHTMLSummarySkill)
                        }

                        if (CpList_List != null && CpList_List != 'undefined' && CpList_List.length > 0) {
                            $.each(CpList_List, function (index, objSkill) {
                                strHTML += "<tr class='collapsiblerow'> <td class='PRrolename'> " + objSkill.Description + " <a  class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' data-bs-target='.CPhiderow_" + index + "' title='View Task' >" +
                                    " <img class='uparrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' title='Hide Task'>" +
                                    "<img class='downarrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/down.svg' alt='View Task' width='15px' title='View Task'> </a></td><td></td><td></td><td></td><td></td><td></td>" +
                                    "<td></td><td></td><td></td> <td></td><td></td> <td></td><td></td></tr>";

                                $.each(objSkill["Cp_Skilllist"], function (indexMonths, objSkillMonths) {

                                    strHTML += "<tr class='CPhiderow_" + index + " collapse'><td>" + objSkillMonths.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover1" + indexMonths + objSkillMonths.ToolID + "' onclick=\"(ToolTipClick('" + objSkillMonths.Name + "','" + objSkillMonths.ToolID + "','" + CpList_MonthHeader[0].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 0 + "," + 1 + ",'CPpopover1" + indexMonths + objSkillMonths.ToolID + "',"+objSkillMonths.Month_1+"))\"'>" + objSkillMonths.Month_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover2" + indexMonths + objSkillMonths.ToolID + "' onclick=\"(ToolTipClick('" + objSkillMonths.Name + "','" + objSkillMonths.ToolID + "','" + CpList_MonthHeader[1].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 0 + "," + 1 + ",'CPpopover2" + indexMonths + objSkillMonths.ToolID + "',"+objSkillMonths.Month_2+"))\"'>" + objSkillMonths.Month_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover3" + indexMonths + objSkillMonths.ToolID + "' onclick=\"(ToolTipClick('" + objSkillMonths.Name + "','" + objSkillMonths.ToolID + "','" + CpList_MonthHeader[2].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 0 + "," + 1 + ",'CPpopover3" + indexMonths + objSkillMonths.ToolID + "',"+objSkillMonths.Month_3+"))\"'>" + objSkillMonths.Month_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover4" + indexMonths + objSkillMonths.ToolID + "' onclick=\"(ToolTipClick('" + objSkillMonths.Name + "','" + objSkillMonths.ToolID + "','" + CpList_MonthHeader[3].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 0 + "," + 1 + ",'CPpopover4" + indexMonths + objSkillMonths.ToolID + "',"+objSkillMonths.Month_4+"))\"'>" + objSkillMonths.Month_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover5" + indexMonths + objSkillMonths.ToolID + "' onclick=\"(ToolTipClick('" + objSkillMonths.Name + "','" + objSkillMonths.ToolID + "','" + CpList_MonthHeader[4].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 0 + "," + 1 + ",'CPpopover5" + indexMonths + objSkillMonths.ToolID + "',"+objSkillMonths.Month_5+"))\"'>" + objSkillMonths.Month_5 + "</a></td> " +
                                        "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover6" + indexMonths + objSkillMonths.ToolID + "' onclick=\"(ToolTipClick('" + objSkillMonths.Name + "','" + objSkillMonths.ToolID + "','" + CpList_MonthHeader[5].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 0 + "," + 1 + ",'CPpopover6" + indexMonths + objSkillMonths.ToolID + "',"+objSkillMonths.Month_6+"))\"'>" + objSkillMonths.Month_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover7" + indexMonths + objSkillMonths.ToolID + "' onclick=\"(ToolTipClick('" + objSkillMonths.Name + "','" + objSkillMonths.ToolID + "','" + CpList_MonthHeader[6].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 0 + "," + 1 + ",'CPpopover7" + indexMonths + objSkillMonths.ToolID + "',"+objSkillMonths.Month_7+"))\"'>" + objSkillMonths.Month_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover8" + indexMonths + objSkillMonths.ToolID + "' onclick=\"(ToolTipClick('" + objSkillMonths.Name + "','" + objSkillMonths.ToolID + "','" + CpList_MonthHeader[7].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 0 + "," + 1 + ",'CPpopover8" + indexMonths + objSkillMonths.ToolID + "',"+objSkillMonths.Month_8+"))\"'>" + objSkillMonths.Month_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover9" + indexMonths + objSkillMonths.ToolID + "' onclick=\"(ToolTipClick('" + objSkillMonths.Name + "','" + objSkillMonths.ToolID + "','" + CpList_MonthHeader[8].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 0 + "," + 1 + ",'CPpopover9" + indexMonths + objSkillMonths.ToolID + "',"+objSkillMonths.Month_9+"))\"'>" + objSkillMonths.Month_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover10" + indexMonths + objSkillMonths.ToolID + "' onclick=\"(ToolTipClick('" + objSkillMonths.Name + "','" + objSkillMonths.ToolID + "','" + CpList_MonthHeader[9].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 0 + "," + 1 + ",'CPpopover10" + indexMonths + objSkillMonths.ToolID + "',"+objSkillMonths.Month_10+"))\"'>" + objSkillMonths.Month_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover11" + indexMonths + objSkillMonths.ToolID + "' onclick=\"(ToolTipClick('" + objSkillMonths.Name + "','" + objSkillMonths.ToolID + "','" + CpList_MonthHeader[10].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 0 + "," + 1 + ",'CPpopover11" + indexMonths + objSkillMonths.ToolID + "',"+objSkillMonths.Month_11+"))\"'>" + objSkillMonths.Month_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover12" + indexMonths + objSkillMonths.ToolID + "' onclick=\"(ToolTipClick('" + objSkillMonths.Name + "','" + objSkillMonths.ToolID + "','" + CpList_MonthHeader[11].MonthDate + "','" + CpList_MonthHeader[0].MonthDate + "'," + 0 + "," + 1 + ",'CPpopover12" + indexMonths + objSkillMonths.ToolID + "',"+objSkillMonths.Month_12+"))\"'>" + objSkillMonths.Month_12 + "</a></td></tr>";
                                });
                            });
                        }
                        else {
                            StopAjaxLoader("#bodyCapacityPalning-group");
                            strHTML += '<tr><td style="width:25%"></td><td class="text-center" colspan="13">' + NoDataFound + '</td></tr>';
                        }

                        $("#CP_RolewiseMonthTbody").html(strHTML);

                        StopAjaxLoader("#bodyCapacityPalning-group");
                        ///loadDataTable();
                    }
                    else {
                        // alert("No Data Found");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("No Data Found");
                        StopAjaxLoader("#bodyCapacityPalning-group");
                    }


                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    //alert(err);
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyCapacityPalning-group");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyCapacityPalning-group");
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

        }


        function ToolTipClick(name, roleId, startDate, endDate, IsRole, IsMonth, id, value) {
           
            if (value!= 'undefined' && value>0) {
                 if (name == "Project Requests") {
                GetProjectRequestToolTip(roleId, startDate, endDate, IsRole, IsMonth, id,value);
            }
            else if (name == "Opportunity Requests") {

                GetOpportunityRequestToolTip(roleId, startDate, endDate, IsRole, IsMonth, id);
            }
            else if (name == "Allocated to Projects") {
                GetAllocatedToProjectToolTip(roleId, startDate, endDate, IsRole, IsMonth, id);
            }
            else if (name == "Current Bench") {
                GetBenchToolTip(roleId, startDate, endDate, IsRole, IsMonth, id);

            }
            else if (name == "Anticipated Exits") {

                GetAnticipatedExitsToolTip(roleId, startDate, endDate, IsRole, IsMonth, id);
            }
            else if (name == "Joining Pool") {

                GetJoiningPoolToolTip(roleId, startDate, endDate, IsRole, IsMonth, id);
            }

            } else {
                OpenToolTip("CPpopover2", id);
            }
           
        }

        function GetProjectRequestToolTip(roleId, startDate, endDate, IsRole, IsMonth, id, value) {

            var strHTML;

            if (IsMonth) {
                if (IsRole == 1) {
                    var param = {
                        RoleID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        WeekOrMonth: 1,
                        RoleOrSkill: 1,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
                else {
                    var param = {
                        SkillID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        WeekOrMonth: 1,
                        RoleOrSkill: 0,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
            }
            else {
                if (IsRole == 1) {
                    var param = {
                        RoleID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        WeekOrMonth: 0,
                        RoleOrSkill: 1,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
                else {
                    var param = {
                        SkillID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        WeekOrMonth: 0,
                        RoleOrSkill: 0,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
            }
            if (value != 'undefined' && value > 0) {
                StartLoader("#tblProjectRequestLoader");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityPlanProjectRequestsToolTip',
                type: "POST",
                data: JSON.stringify(param),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ProjectRequestList = data.ProjectRequestToolTipList;
                    var RoleName;
                    if (ProjectRequestList.length > 0) {
                        $.each(ProjectRequestList, function (index, obj) {

                            strHTML += '<tr><td>' + obj.ProjectName + '</td><td>' + obj.NoOfResources + '</td><td>' + obj.ProjectCost + '</td></tr>';
                            RoleName = obj.RoleDescription;
                        });
                    }
                    else {
                        strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    }


                    $("#tblProjectRequest").html(strHTML);
                    $("#lblRoleName").html(data.RoleDescription + ' (' + ProjectRequestList.length + ')');
                    $("#lblNoOfResources").html(data.TotalNoOfResources);
                    $("#lblTotalProjectCost").html(data.TotalProjectCost);


                    OpenToolTip("CPpopover2", id);
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
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

            } else {
                alert('no data found');
            }
            

        }

        function GetAllocatedToProjectToolTip(roleId, startDate, endDate, IsRole, IsMonth, id) {
            var strHTML;
            if (IsMonth == 1) {
                if (IsRole == 1) {
                    var param = {

                        RoleID: roleId,
                        UserID: SessionEmployeeId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 1,
                        WeekOrMonth: 1,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
                else {
                    var param = {

                        SkillID: roleId,
                        UserID: SessionEmployeeId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 0,
                        WeekOrMonth: 1,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
            } else {
                if (IsRole == 1) {
                    var param = {

                        RoleID: roleId,
                        UserID: SessionEmployeeId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 1,
                        WeekOrMonth: 0,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
                else {
                    var param = {

                        SkillID: roleId,
                        UserID: SessionEmployeeId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 0,
                        WeekOrMonth: 0,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
            }

            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityPlanAllocatedToProjectToolTip',
                type: "POST",
                data: JSON.stringify(param),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {

                    var AllocatedToProjectList = data.AllocatedToProjectToolTipList;

                    if (AllocatedToProjectList.length > 0) {
                        $.each(AllocatedToProjectList, function (index, obj) {

                            strHTML += '<tr><td>' + obj.ResourceName + '</td><td>' + obj.ProjectName + '</td><td>' + obj.ProjectRole + '</td><td>' + obj.CostPerHour + '</td> <td>' + obj.RatePerHour + '</td></tr>';

                        });
                    }
                    else {
                        strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    }


                    $("#tblAllocatedToProject").html(strHTML);
                    $("#lblCostPerHr").html(data.TotalCostPerHour);
                    $("#lblRatePerHr").html(data.TotalRatePerHour);
                    $("#lblRoleAllocatedToProject").html(data.RoleDescription + ' (' + AllocatedToProjectList.length + ')');
                   
                    OpenToolTip("CPpopover1", id);
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
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

        function GetOpportunityRequestToolTip(roleId, startDate, endDate, IsRole, IsMonth, id) {
            var strHTML;

            if (IsMonth == 1) {
                if (IsRole == 1) {

                    var param = {

                        RoleID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        UserID: SessionEmployeeId,
                        RoleOrSkill: 1,
                        WeekOrMonth: 1,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
                else {
                    var param = {

                        SkillID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        UserID: SessionEmployeeId,
                        RoleOrSkill: 0,
                        WeekOrMonth: 1,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
            }
            else {
                if (IsRole == 1) {

                    var param = {

                        RoleID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        UserID: SessionEmployeeId,
                        RoleOrSkill: 1,
                        WeekOrMonth: 0,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
                else {
                    var param = {

                        SkillID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        UserID: SessionEmployeeId,
                        RoleOrSkill: 0,
                        WeekOrMonth: 0,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
            }



            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityPlanOpportunityRequestToolTip',
                type: "POST",
                data: JSON.stringify(param),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    var OpportunityRequestList = data.OpportunityRequestToolTipList;

                    if (OpportunityRequestList.length > 0) {
                        $.each(OpportunityRequestList, function (index, obj) {

                            strHTML += '<tr><td>' + obj.OpportunityName + '</td><td>' + obj.NoOfResources + '</td><td>' + obj.OpportunityCost + '</td><td>' + obj.OpportunityRate + '</td></tr>';

                        });
                    }
                    else {
                        strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    }


                    $("#tblOpportunityRequest").html(strHTML);
                    $("#lblOpportunityCost").html(data.TotalOpportunityCost);
                    $("#lblOpportunityValue").html(data.TotalOpportunityRate);
                    $("#lblRoleOpportunityRequest").html(data.RoleDescription + ' (' + OpportunityRequestList.length + ')');
                    //  LoadPagination('#tblOUResorces', data);
                    // StopAjaxLoader("#bodyBusiness-group");

                    OpenToolTip("CPpopover3", id);
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
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

        function GetBenchToolTip(roleId, startDate, endDate, IsRole, IsMonth, id) {
          
            var strHTML = " ";
            //$("#tblBenchList").html('');
            if (IsMonth == 1) {
                if (IsRole == 1) {

                    var param = {
                        RoleID: roleId,
                        SkillID: 0,
                        UserID: SessionEmployeeId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 1,
                        WeekOrMonth: 1,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList

                    }
                }
                else {
                    var param = {
                        RoleID: 0,
                        SkillID: roleId,
                        UserID: SessionEmployeeId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 0,
                        WeekOrMonth: 1,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList

                    }
                }
            }
            else {
                if (IsRole == 1) {

                    var param = {
                        RoleID: roleId,
                        SkillID: 0,
                        UserID: SessionEmployeeId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 1,
                        WeekOrMonth: 0,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList

                    }
                }
                else {
                    var param = {
                        RoleID: 0,
                        SkillID: roleId,
                        UserID: SessionEmployeeId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 0,
                        WeekOrMonth: 0,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList

                    }
                }
            }



            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityPlanBenchToolTip',
                type: "POST",
                data: JSON.stringify(param),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    var BenchList = data.BenchToolTipList;

                    if (BenchList.length > 0) {
                        $.each(BenchList, function (index, obj) {

                            strHTML += ' <tr><td>' + obj.ResourceName + '</td><td>' + obj.SkillOrRole + '</td><td>' + obj.BenchCost + '</td> </tr>';

                        });
                    }
                    else {
                        strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    }

                    // $('#tblBench').dataTable().fnDestroy();
                    $("#tblBenchList").html(strHTML);
                    $("#lblBenchCost").html(data.TotalBenchCost);
                    $("#lblRoleBench").html(data.RoleDescription + ' (' + BenchList.length + ')');

                    //  LoadPagination('#tblBench', BenchList);
                    // StopAjaxLoader("#bodyBusiness-group");
                    
                    OpenToolTip("CPpopover4", id);
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
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

        function GetAnticipatedExitsToolTip(roleId, startDate, endDate, IsRole, IsMonth, id) {
            var strHTML;
            if (IsMonth == 1) {
                if (IsRole == 1) {
                    var param = {
                        RoleID: roleId,
                        RoleOrSkill: 1,
                        WeekOrMonth: 1,
                        StartDate: startDate,
                        EndDate: endDate,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
                else {
                    var param = {
                        SkillID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 0,
                        WeekOrMonth: 1,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
            }
            else {
                if (IsRole == 1) {
                    var param = {
                        RoleID: roleId,
                        RoleOrSkill: 1,
                        WeekOrMonth: 0,
                        StartDate: startDate,
                        EndDate: endDate,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
                else {
                    var param = {
                        SkillID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 0,
                        WeekOrMonth: 0,
                        BGOUType: filterParams.BGOUType,
                        BGOUFilter: filterParams.BGOUFilter,
                        SkillList: filterParams.SkillList
                    }
                }
            }


            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityPlanAnticipatedExitsToolTip',
                type: "POST",
                data: JSON.stringify(param),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    var AnticipatedExitsList = data.AnticipatedExitsToolTipList;

                    if (AnticipatedExitsList.length > 0) {
                        $.each(AnticipatedExitsList, function (index, obj) {

                            strHTML += '<tr><td>' + obj.ResourceName + '</td><td>' + obj.DateOfLeaving + '</td><td>' + obj.RoleOrSkill + '</td></tr>';

                        });
                    }
                    else {
                        strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    }

                    $("#tblAnticipatedExitsList").html(strHTML);
                    $("#lblAENoOfResources").html(data.NoOfResources);
                    $("#lblRoleAnticipatedExits").html(data.RoleDescription + ' (' + AnticipatedExitsList.length + ')');

                    //  LoadPagination('#tblOUResorces', data);
                    // StopAjaxLoader("#bodyBusiness-group");
                    OpenToolTip("CPpopover5", id);
                },
                // Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
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

        function GetJoiningPoolToolTip(roleId, startDate, endDate, IsRole, IsMonth, id) {
            var strHTML;
            if (IsMonth == 1) {
                if (IsRole == 1) {
                    var param = {
                        RoleID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 1,
                        WeekOrMonth: 1,
                    }
                }
                else {
                    var param = {
                        SkillID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 0,
                        WeekOrMonth: 1,
                    }
                }
            }
            else {
                if (IsRole == 1) {
                    var param = {
                        RoleID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 1,
                        WeekOrMonth: 0,
                    }
                }
                else {
                    var param = {
                        SkillID: roleId,
                        StartDate: startDate,
                        EndDate: endDate,
                        RoleOrSkill: 0,
                        WeekOrMonth: 0,
                    }
                }
            }


            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityPlanJoiningPoolToolTip',
                type: "POST",
                data: JSON.stringify(param),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    var JoiningPoolList = data.JoiningPoolToolTipList;

                    if (JoiningPoolList.length > 0) {
                        $.each(JoiningPoolList, function (index, obj) {

                            strHTML += '<tr><td>' + obj.RoleOrSkill + '</td><td>' + obj.NoOfResources + '</td><td>' + obj.ExpectedCost + '</td></tr>';

                        });
                    }
                    else {
                        strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    }


                    $("#tblJoiningPoolList").html(strHTML);
                    $("#lblTotalExpectedCost").html(data.TotalExpectedCost);
                    $("#lblRoleJoiningPool").html(data.RoleDescription + ' (' + JoiningPoolList.length + ')');

                    //  LoadPagination('#tblOUResorces', data);
                    // StopAjaxLoader("#bodyBusiness-group");

                    OpenToolTip("CPpopover6", id);
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
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

        var FilterBGList = [];
        function GetCapacityPlanBGFilterList() {
            var strHTML = '';
            var param = {
                UserID: SessionEmployeeId
            }
            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityPlanBGFilterList',
                type: "POST",
                data: JSON.stringify(param),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    var FilterListBG = data;
                    FilterBGList = data;
                    $.each(FilterListBG, function (index, obj) {
                        index = index + 1;
                        strHTML += "<li><div class='custom_chckbox'> <input  id='CPBGChck" + index + "' class='chcktbl' value='" + obj.BusinessGroupID + "' type='checkbox' onclick=\"(FillFilterOUForFilter('CPBGChck" + index + "'," + obj.BusinessGroupID + ", '" + obj.BusinessGroup + "'," + index + "))\"' ><label for='CPBGChck" + index + "'>" + obj.BusinessGroup + "</label></div></li>";

                    });
                    // $('#tblOUResorces#tblOUResorces').dataTable().fnDestroy();
                    $("#myfilterlistBG").append(strHTML);

                    //  LoadPagination('#tblOUResorces', data);
                    // StopAjaxLoader("#bodyBusiness-group");
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
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

        var ListOUFilter = [];

        function GetCapacityPlanOUFilterList() {

            var strHTML = '';
            var param = {
                UserID: SessionEmployeeId
            }
            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityPlanOUFilterList',
                type: "POST",
                data: JSON.stringify(param),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {

                    var FilterListOU = data;
                    ListOUFilter = data;
                    $.each(FilterListOU, function (index, obj) {
                        index = index + 1;
                        strHTML += '<li><div class="custom_chckbox"> <input value=' + obj.LocationID + ' id="CPOUChck' + index + '" class="chcktbl" type="checkbox" onclick="OUfiltrchktbl()"><label for="CPOUChck' + index + '">' + obj.Location + '</label></div></li>';
                        //added onclick funcntion by pradip on 22-7-2021
                    });

                    // $('#tblOUResorces#tblOUResorces').dataTable().fnDestroy();
                    $("#lstBGOU").html(strHTML);
                    //  LoadPagination('#tblOUResorces', data);
                    // StopAjaxLoader("#bodyBusiness-group");
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
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

        function GetCapacityPlanSkillFilterList() {
            var strHTML = '';
            var param = {
                UserID: SessionEmployeeId
            }
            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityPlanSkillFilterList',
                type: "POST",
                data: JSON.stringify(param),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    var FilterListSkill = data;

                    $.each(FilterListSkill, function (index, obj) {
                        index = index + 1;
                        strHTML += '<li><div class="custom_chckbox"> <input value=' + obj.ToolID + ' id="CPSkillChck' + index + '" class="chcktbl" type="checkbox" onclick="Skillsfiltrchktbl()"><label for="CPSkillChck' + index + '">' + obj.Description + '</label></div></li>';
                        //added onclick funcntion by pradip on 22-7-2021
                    });


                    $("#myfilterlistSkill").append(strHTML);

                    //  LoadPagination('#tblOUResorces', data);
                    // StopAjaxLoader("#bodyBusiness-group");
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#bodyBusiness-group");
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

        var lstSelectedOUs = [];
        var lstBGOUs = [];
        var selectedBGs = [];
        function FillFilterOUForFilter(ChkID, BgID, BgName, index) {
            var strHTML = "";
            $("#myfilterlistOU").html(strHTML);
            var checked = $("#" + ChkID).is(":checked");

            if (checked) {
                $("#SelectAlDUs").hide();
                var objBGCODE = { BusinessGroupID: BgID }

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

                        var FilterListOU = data;
                        $.each(FilterListOU, function (index, obj) {
                            lstSelectedOUs.push(obj);
                        });

                        var ObjOU = {
                            BgID: BgID,
                            Bg_Name: BgName,
                            OU_lst: FilterListOU
                        };

                        lstBGOUs.push(ObjOU);

                        $.each(lstBGOUs, function (index, obj) {

                            strHTML += '<li>' + obj.Bg_Name + '</li>';
                            strHTML += '<ul id=' + obj.BgID + '>';
                            $.each(obj.OU_lst, function (index, obj1) {

                                //index = index + 1;
                                // strHTML += '<li><div class="custom_chckbox"> <input value="'+ obj.OUPoolID +'" id="CPOUChck' + index + obj.OUPoolID + '" class="chcktbl" type="checkbox" checked><label for="CPOUChck' + index + obj.OUPoolID + '">' + obj.Location + '</label></div></li>';
                                strHTML += "<li><div class='custom_chckbox'> <input value='" + obj1.OUPoolID + "' id='CPOUChck" + index + obj1.OUPoolID + "' class='chcktbl' type='checkbox' checked onclick=\"(SelectOU('CPBGChck" + index + "'," + obj.BgID + ", '" + obj1.Location + "'," + index + "))\"'><label for='CPOUChck" + index + obj1.OUPoolID + "'>" + obj1.Location + "</label></div></li>";


                            });
                            strHTML += '</ul>';
                            $("#myfilterlistOU").append(strHTML);
                        });

                        $("#lstBGOU").html(strHTML);

                        $("#cboOPRFilterLocationID").html(strHTML);


                    },
                    //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
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
                    }
                     //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                })

            }
            else {
                $("#SelectAlDUs").hide();
                var myindex = lstBGOUs.findIndex(x => x.Bg_Name == BgName);

                lstBGOUs.splice(myindex, 1);


                if (lstBGOUs.length <= 0) {

                    lstBGOUs = [];
                    $("#myfilterlistOU").append("");
                    $("#lstBGOU").html("");
                    GetCapacityPlanOUFilterList();
                }
                else {
                    $.each(lstBGOUs, function (index, obj) {

                        strHTML += '<li>' + obj.Bg_Name + '</li>';
                        strHTML += '<ul id=' + obj.BgID + '>';
                        $.each(obj.OU_lst, function (index, obj1) {

                            index = index + 1;
                            //strHTML += '<li><div class="custom_chckbox"> <input id="CPOUChck' + index + '" class="chcktbl" type="checkbox"><label for="CPOUChck' + index + '">' + obj.Location + '</label></div></li>';
                            strHTML += "<li><div class='custom_chckbox'> <input value='" + obj1.OUPoolID + "' id='CPOUChck" + index + obj1.OUPoolID + "' class='chcktbl' type='checkbox' checked onclick=\"(SelectOU('CPBGChck" + index + "'," + obj.BgID + ", '" + obj1.Location + "'," + index + "))\"'><label for='CPOUChck" + index + obj1.OUPoolID + "'>" + obj1.Location + "</label></div></li>";
                        });
                        strHTML += '</ul>';
                        $("#myfilterlistOU").append(strHTML);
                    });

                    $("#lstBGOU").html(strHTML);
                }

            }

 //Added script by pradip on 22-7-2021
            if ($(".fplistbocBG .chcktbl").length == $(".fplistbocBG .chcktbl:checked").length) {
                $(".fplistbocBG .chckHead").prop("checked", true);
            } else {
                $(".fplistbocBG .chckHead").removeAttr("checked");
                $(".fplistbocBG .chckHead").prop("checked", false);
            }
            //End script Added by pradip

        }

        function GetSelectedBGs() {
            var checkboxValues = [];
            $("#myfilterlistBG input[type=checkbox]:checked").each(function (index, elem) {
                checkboxValues.push($(elem).val());
            });

        }

        function GetSelectedOU() {
            const ul = document.getElementById('lstBGOU');
            const listItems = ul.getElementsByTagName('ul');
            var bgList = [];
            for (let i = 0; i <= listItems.length - 1; i++) {
                var bg = {
                    bgId: listItems[i].id,
                    oulist: []
                };


                $("#" + listItems[i].id + " input[type=checkbox]:checked").each(function (index, elem) {
                    bg.oulist.push($(elem).val());

                });
                bgList.push(bg);

            }

            return bgList;

        }

//Added script by pradip on 22-7-2021
        function OUfiltrchktbl() {
            if ($(".fplistbocOU .chcktbl").length == $(".fplistbocOU .chcktbl:checked").length) {
                $(".fplistbocOU .chckHead").prop("checked", true);
            } else {
                $(".fplistbocOU .chckHead").removeAttr("checked");
                $(".fplistbocOU .chckHead").prop("checked", false);
            }
        }
        function Skillsfiltrchktbl() {
            if ($(".fplistbocskill .chcktbl").length == $(".fplistbocskill .chcktbl:checked").length) {
                $(".fplistbocskill .chckHeadSkill").prop("checked", true);
            } else {
                $(".fplistbocskill .chckHeadSkill").removeAttr("checked");
                $(".fplistbocskill .chckHeadSkill").prop("checked", false);
            }
        } //End Added by pradip
        function SelectOU(ChkID, BgID, OuName, index) {

            var checkboxValues = [];
            $("#" + BgID + " input[type=checkbox]:checked").each(function (index, elem) {
                checkboxValues.push($(elem).val());
            });

            if (checkboxValues.length <= 0)
            {         
                //Added by imran on 17-12-2021 when we uncheck OU that time BG Selected Check bos still remain checked
                $("#CPBGChck0").prop("checked", false);
                //end By imran on 17-12-2021

                var myindex = FilterBGList.findIndex(x => x.BusinessGroupID == BgID);
                myindex = myindex + 1;
                $("#CPBGChck" + myindex).prop("checked", false);

                var myindex2 = lstBGOUs.findIndex(x => x.BgID == BgID);
                var strHTML = "";
                lstBGOUs.splice(myindex2, 1);

                $.each(lstBGOUs, function (index, obj) {

                    strHTML += '<li>' + obj.Bg_Name + '</li>';
                    strHTML += '<ul id=' + obj.BgID + '>';
                    $.each(obj.OU_lst, function (index, obj1) {

                        // index = index + 1;
                        //strHTML += '<li><div class="custom_chckbox"> <input id="CPOUChck' + index + '" class="chcktbl" type="checkbox" checked><label for="CPOUChck' + index + '">' + obj.Location + '</label></div></li>';
                        strHTML += "<li><div class='custom_chckbox'> <input value='" + obj1.OUPoolID + "' id='CPOUChck" + index + obj1.OUPoolID + "' class='chcktbl' type='checkbox' checked onclick=\"(SelectOU('CPBGChck" + index + "'," + obj.BgID + ", '" + obj1.Location + "'," + index + "))\"'><label for='CPOUChck" + index + obj1.OUPoolID + "'>" + obj1.Location + "</label></div></li>";
                    });
                    strHTML += '</ul>';
                    $("#myfilterlistOU").append(strHTML);
                });

                $("#lstBGOU").html(strHTML);

            }

            var BgcheckboxValues = [];
            $("#myfilterlistBG input[type=checkbox]:checked").each(function (index, elem) {
                BgcheckboxValues.push($(elem).val());
            });
            if (BgcheckboxValues.length <= 0) {
                lstBGOUs = [];
                $("#myfilterlistOU").append("");
                $("#lstBGOU").html("");
                GetCapacityPlanOUFilterList();
            }

        }
        var filterParams =
        {
            BGOUType: "",
            BGOUFilter: "",
            SkillList: ""
        }
        function ClearOnSwitchRolenSkillWise() {

            FilterNotApplied();
            lstBGOUs = [];
            GetCapacityPlanOUFilterList();
            $(".clearalllink").hide();
            ///$(".mainclearalllink").removss("clsShowHide");
            //$(".filter >  button").removeClass("clsFilterHighlight");
            filterParams.BGOUFilter = "";
            filterParams.BGOUType = "";
            filterParams.SkillList = "";
            $("#myfilterlistSkill input[type=checkbox]").each(function (index, elem) {
                $(elem).prop("checked", false);
            });
            $("#CPSkillChck0").prop("checked", false);

            $("#lstBGOU input[type=checkbox]").each(function (index, elem) {
                $(elem).prop("checked", false);
            });
            $("#myfilterlistBG input[type=checkbox]").each(function (index, elem) {
                $(elem).prop("checked", false);
            });

            $("#CPBGChck0").prop("checked", false);
            $("#CPOUChck0").prop("checked", false);
        }
        function ClearFilter() {
            FilterNotApplied();
            lstBGOUs = [];
            GetCapacityPlanOUFilterList();
            $(".clearalllink").hide();
            ///$(".mainclearalllink").removss("clsShowHide");
            //$(".filter >  button").removeClass("clsFilterHighlight");
            filterParams.BGOUFilter = "";
            filterParams.BGOUType = "";
            filterParams.SkillList = "";
            document.getElementById("myInputBG").value = '';
            document.getElementById("myInputOU").value = '';
            document.getElementById("myInputSkill").value = '';

            var liRCPQuarterviewIsActive = $('#liRCPQuarterview').hasClass('active');

            if ($('#btnMonthRole').hasClass('active') && liRCPQuarterviewIsActive == false) {
                GetCapacityPlanningRoleMonthList();
            } else if ($('#btnMonthSkill').hasClass('active') && liRCPQuarterviewIsActive == false) {
                GetCapacityPlanningSkillMonthList()
            }
            else if ($('#btnQtrRole').hasClass('active') && liRCPQuarterviewIsActive == true) {
                GetCapacityPlanningList();
            } else if ($('#btnQtrSkill').hasClass('active') && liRCPQuarterviewIsActive == true) {
                GetCapacityQtrSkillWisePlanList();
            }
            else {
                GetCapacityPlanningList();
            }


            //GetCapacityPlanBGFilterList();
            //GetCapacityPlanOUFilterList();
            //GetCapacityPlanSkillFilterList();

            $("#myfilterlistSkill input[type=checkbox]").each(function (index, elem) {
                $(elem).prop("checked", false);
            });
            $("#CPSkillChck0").prop("checked", false);

            $("#lstBGOU input[type=checkbox]").each(function (index, elem) {
                $(elem).prop("checked", false);
            });
            $("#myfilterlistBG input[type=checkbox]").each(function (index, elem) {
                $(elem).prop("checked", false);
            });

            $("#CPBGChck0").prop("checked", false);
            $("#CPOUChck0").prop("checked", false);
        }

        function ApplyFilter() {
            FilterApplied()
            var whereClause = "";
            var BgOulst = GetSelectedOU();


            var BgcheckboxValues = [];
            var OucheckboxValues = [];
            var SkillcheckboxValues = [];
            filterParams.SkillList = '';
            filterParams.BGOUFilter = ''; 

            $("#myfilterlistSkill input[type=checkbox]:checked").each(function (index, elem) {
                SkillcheckboxValues.push($(elem).val());
            });

            $("#myfilterlistBG input[type=checkbox]:checked").each(function (index, elem) {
                BgcheckboxValues.push($(elem).val());
            });

            if (SkillcheckboxValues.length > 0) {
                SkillcheckboxValues = SkillcheckboxValues.join(" , ");
                var SkillList = "SKM.Toolid in (" + SkillcheckboxValues + ")";
                filterParams.SkillList = '(' + SkillList + ')';


            }

            if (BgcheckboxValues != null || BgcheckboxValues != "undefined") {
                if (BgcheckboxValues.length <= 0) {

                    $("#lstBGOU input[type=checkbox]:checked").each(function (index, elem) {
                        OucheckboxValues.push($(elem).val());
                    });

                    if (OucheckboxValues.length > 0) {
                        OucheckboxValues = OucheckboxValues.join(" , ");

                        whereClause = "EMP.LocationID in (" + OucheckboxValues + ")";


                        filterParams.BGOUType = "O";
                        filterParams.BGOUFilter = '(' + whereClause + ')';

                    }

                }
                else {
                    if (BgOulst.length > 0) {
                        var tcount = 0;
                        var whereClause = "";
                        $.each(BgOulst, function (index, obj) {
                            var BusinessGroupID = obj.bgId;

                            for (i = 0; i < obj.oulist.length; i++) {
                                tcount++;
                                whereClause += " (EMP.BusinessGroupID = " + BusinessGroupID + " and EMP.LocationID = " + obj.oulist[i] + ") or";
                            }

                        });
                        var lastIndex = whereClause.lastIndexOf(" "); 
                        whereClause = whereClause.substring(0, lastIndex); 
                        filterParams.BGOUType = "BO";
                        if (tcount > 0) {
                            filterParams.BGOUFilter = '(' + whereClause + ')';
                        }

                    }

                }

            }
            if ((filterParams.SkillList != null && filterParams.SkillList.length > 0) || (filterParams.BGOUFilter != null && filterParams.BGOUFilter.length > 0)) {
                if (IsMonthWise == true && IsRoleWise == true) {
                    GetCapacityPlanningRoleMonthList(filterParams);
                }
                else if (IsMonthWise == true && IsSkillWise == true) {
                    GetCapacityPlanningSkillMonthList(filterParams);
                }
                else if (IsWeekWise == true && IsRoleWise == true) {
                    GetCapacityPlanningList(filterParams);
                }
                else if (IsWeekWise == true && IsSkillWise == true) {
                    GetCapacityQtrSkillWisePlanList(filterParams);
                }

                var msg = "Filter applied successfully.";
                alertify.set('notifier', 'position', 'top-right');
                alertify.success(msg);
                $(".clearalllink").show();
            }
            else {
                var err = "Apply Filter on at least one field";
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(err);

            }

        }

        function SelectAllBGs() {

            //$("#myfilterlistOU").html(strHTML);
            var checked = $("#CPBGChck0").is(":checked");
            /// var Uncheckedchecked = $("#CPBGChck0").is(":unchecked");
            // alert(Uncheckedchecked);

            var BgcheckboxValues = [];
            var Bglables = [];
            $("#myfilterlistBG input[type=checkbox]:checked").each(function (index, elem) {
                BgcheckboxValues.push($(elem).val());
            });

            $("#myfilterlistBG label").each(function (index, elem) {
                Bglables.push($(elem).text());
            });
            if (BgcheckboxValues.length > 0 && Bglables.length > 0) {
                for (var i = 0; i < BgcheckboxValues.length; i++) {
                    FillFilterOUForFilter("CPBGChck" + (i + 1), BgcheckboxValues[i], Bglables[i]);
                }
            }



        }

        function GetCapacityPlanningRoleMonthList(filterParams) {

            IsRoleMonth = true;
            var strHTMLHeader = "";
            var strHTMLWeek = "";
            var strHTMLSummary = "";
            $("#CP_RolewiseWeekTbody").html(strHTMLWeek);
            if (filterParams == null || filterParams == "undefined") {
                filterParams =
                {
                    BGOUType: "",
                    BGOUFilter: "",
                    SkillList: ""
                }
            }
            
            StartLoader("#bodyCapacityPalning-group");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityRolePlanListRoleMonthWise',
                method: 'POST',
                data: JSON.stringify(filterParams),
                dataType: 'json',
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (filterParams) {
                        xhr.setRequestHeader("Params", encryptString(isJson(filterParams) ? filterParams : JSON.stringify(filterParams)));
                    }
                },
                success: function (data) {

                    if (data != null && data != 'undefined' && data != '') {
                        var strWeeksHeaderHTML = "";

                        ///Bind Header of month
                        var CpList_WeekHeaderNames = data["CpWeeksListHeader"];

                        //Set Header
                        if (CpList_WeekHeaderNames != null && CpList_WeekHeaderNames != 'undefined' && CpList_WeekHeaderNames.length > 0) {
                            $("#lblCpMonthFirst").text(CpList_WeekHeaderNames[0].WkMonthName + " " + CpList_WeekHeaderNames[0].WkYear);
                            $("#lblCpMonthSecond").text(CpList_WeekHeaderNames[6].WkMonthName + " " + CpList_WeekHeaderNames[6].WkYear);
                            $("#lblCpMonthThird").text(CpList_WeekHeaderNames[12].WkMonthName + " " + CpList_WeekHeaderNames[12].WkYear);

                            var filter1 = CpList_WeekHeaderNames.filter(function (x) { return x.WkMonthName.includes(CpList_WeekHeaderNames[0].WkMonthName) });
                            if (filter1.length > 4) {
                                $("#lblCpMonthFirst").attr("colspan", "5");
                            }
                            var filter2 = CpList_WeekHeaderNames.filter(function (x) { return x.WkMonthName.includes(CpList_WeekHeaderNames[6].WkMonthName) });
                            if (filter2.length > 4) {
                                $("#lblCpMonthSecond").attr("colspan", "5");
                            }
                            var filter3 = CpList_WeekHeaderNames.filter(function (x) { return x.WkMonthName.includes(CpList_WeekHeaderNames[12].WkMonthName) });
                            if (filter3.length > 4) {
                                $("#lblCpMonthThird").attr("colspan", "5");
                            }
                            if (filter3.length > 5) {
                                $("#lblCpMonthThird").attr("colspan", "6");
                            }
                        }

                        strWeeksHeaderHTML += '<th> </th>';
                        if (CpList_WeekHeaderNames != null && CpList_WeekHeaderNames != 'undefined' && CpList_WeekHeaderNames.length > 0) {
                            $.each(CpList_WeekHeaderNames, function (indexMonthHeader, objWeekHeader) {
                                strWeeksHeaderHTML += '<th>Week ' + objWeekHeader.WkMonth + '</th>';
                            });


                        } else {
                            strWeeksHeaderHTML += '<tr><th><td class="text-center" colspan="6">' + NoDataFound + '</td></th></tr>';
                        }
                        $("#lstWeeks").html(strWeeksHeaderHTML);

                        var CpListSummary = data["Cp_WeeklistSummary"];
                        var CpList_SurplusDeficit = data["CpSurplusdeficit"];
                        if (CpListSummary != 'undefined' && CpListSummary != null && CpListSummary.length > 0) {

                            strHTMLSummary += "<tr class='collapsiblerow'> <td class='PRrolename'>Surplus/Deficit<a class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' data-bs-target='.CPhiderow_11" + "'title='View Task'>" +
                                " <img class='uparrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' title='Hide Task'>" +
                                "<img class='downarrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/down.svg' alt='View Task' width='15px' title='View Task'> </a></td>";


                            if (CpList_WeekHeaderNames.length == 12) {
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_1 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_2 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_3 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_4 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_5 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_6 + "</td>";
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_7 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_8 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_9 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_10 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_11 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_12 + "</td>";

                            }
                            else if (CpList_WeekHeaderNames.length == 13) {

                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_1 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_2 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_3 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_4 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_5 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_6 + "</td>";
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_7 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_8 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_9 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_10 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_11 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_12 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_13 + "</td>";

                            }
                            else if (CpList_WeekHeaderNames.length == 14) {
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_1 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_2 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_3 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_4 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_5 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_6 + "</td>";
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_7 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_8 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_9 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_10 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_11 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_12 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_13 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_14 + "</td>";

                            }
                            else if (CpList_WeekHeaderNames.length == 15) {
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_1 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_2 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_3 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_4 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_5 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_6 + "</td>";
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_7 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_8 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_9 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_10 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_11 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_12 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_13 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_14 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_15 + "</td>";

                            }

                            strHTMLSummary += "</tr>";

                            $.each(CpListSummary, function (indexMonths, objWeeksSummary) {

                                if (CpList_WeekHeaderNames.length == 12) {
                                    strHTMLSummary += "<tr class='CPhiderow_11 collapse'><td>" + objWeeksSummary.Name + "</td><td>" + objWeeksSummary.Week_1Sum + "</td> <td>" + objWeeksSummary.Week_2Sum + "</td> <td>" + objWeeksSummary.Week_3Sum + "</td><td>" + objWeeksSummary.Week_4Sum + "</td> <td>" + objWeeksSummary.Week_5Sum + "</td> " +
                                        "<td>" + objWeeksSummary.Week_6Sum + "</td><td>" + objWeeksSummary.Week_7Sum + "</td><td>" + objWeeksSummary.Week_8Sum + "</td><td>" + objWeeksSummary.Week_9Sum + "</td><td>" + objWeeksSummary.Week_10Sum + "</td>  <td>" + objWeeksSummary.Week_11Sum + "</td><td>" + objWeeksSummary.Week_12Sum + "</td></tr>";
                                }
                                else if (CpList_WeekHeaderNames.length == 13) {
                                    strHTMLSummary += "<tr class='CPhiderow_11 collapse'><td>" + objWeeksSummary.Name + "</td><td>" + objWeeksSummary.Week_1Sum + "</td> <td>" + objWeeksSummary.Week_2Sum + "</td> <td>" + objWeeksSummary.Week_3Sum + "</td><td>" + objWeeksSummary.Week_4Sum + "</td> <td>" + objWeeksSummary.Week_5Sum + "</td> " +
                                        "<td>" + objWeeksSummary.Week_6Sum + "</td><td>" + objWeeksSummary.Week_7Sum + "</td><td>" + objWeeksSummary.Week_8Sum + "</td><td>" + objWeeksSummary.Week_9Sum + "</td><td>" + objWeeksSummary.Week_10Sum + "</td>  <td>" + objWeeksSummary.Week_11Sum + "</td><td>" + objWeeksSummary.Week_12Sum + "</td><td>" + objWeeksSummary.Week_13Sum + "</td></tr>";
                                }
                                else if (CpList_WeekHeaderNames.length == 14) {
                                    strHTMLSummary += "<tr class='CPhiderow_11 collapse'><td>" + objWeeksSummary.Name + "</td><td>" + objWeeksSummary.Week_1Sum + "</td> <td>" + objWeeksSummary.Week_2Sum + "</td> <td>" + objWeeksSummary.Week_3Sum + "</td><td>" + objWeeksSummary.Week_4Sum + "</td> <td>" + objWeeksSummary.Week_5Sum + "</td> " +
                                        "<td>" + objWeeksSummary.Week_6Sum + "</td><td>" + objWeeksSummary.Week_7Sum + "</td><td>" + objWeeksSummary.Week_8Sum + "</td><td>" + objWeeksSummary.Week_9Sum + "</td><td>" + objWeeksSummary.Week_10Sum + "</td>  <td>" + objWeeksSummary.Week_11Sum + "</td><td>" + objWeeksSummary.Week_12Sum + "</td><td>" + objWeeksSummary.Week_13Sum + "</td><td>" + objWeeksSummary.Week_14Sum + "</td></tr>";

                                }
                                else if (CpList_WeekHeaderNames.length == 15) {
                                    strHTMLSummary += "<tr class='CPhiderow_11 collapse'><td>" + objWeeksSummary.Name + "</td><td>" + objWeeksSummary.Week_1Sum + "</td> <td>" + objWeeksSummary.Week_2Sum + "</td> <td>" + objWeeksSummary.Week_3Sum + "</td><td>" + objWeeksSummary.Week_4Sum + "</td> <td>" + objWeeksSummary.Week_5Sum + "</td> " +
                                        "<td>" + objWeeksSummary.Week_6Sum + "</td><td>" + objWeeksSummary.Week_7Sum + "</td><td>" + objWeeksSummary.Week_8Sum + "</td><td>" + objWeeksSummary.Week_9Sum + "</td><td>" + objWeeksSummary.Week_10Sum + "</td>  <td>" + objWeeksSummary.Week_11Sum + "</td><td>" + objWeeksSummary.Week_12Sum + "</td><td>" + objWeeksSummary.Week_13Sum + "</td><td>" + objWeeksSummary.Week_14Sum + "</td><td>" + objWeeksSummary.Week_15Sum + "</td></tr>";

                                }
                            });
                            $("#CP_RolewiseWeekTbodySummary").html(strHTMLSummary)

                        } else {
                            $("#CP_RolewiseWeekTbodySummary").html('')
                        }

                        var CpList_List = data["CpWeeksList"];

                        if (CpList_List != "" && CpList_List != "undefined" && CpList_List.length > 0) {
                            
                            $.each(CpList_List, function (index, objRole) {
                                if (objRole.RoleDescription == null) {
                                    objRole.RoleDescription = "";
                                }
                                strHTMLWeek += "<tr class='collapsiblerow w'> <td class='PRrolename'> " + objRole.RoleDescription + " <a  class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' data-bs-target='.CPhiderow_" + index + "' title='View Task' >" +
                                    " <img class='uparrow' data-bs-toggle='tooltip' data-bs-placement='top'  src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' title='Hide Task'>" +
                                    "<img class='downarrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/down.svg' alt='View Task' width='15px' title='View Task'> </a></td>";

                                $.each(CpList_WeekHeaderNames, function (indexMonths, objWeeks) {

                                    strHTMLWeek += "<td></td>";
                                });
                                strHTMLWeek += "</tr>";
                                $.each(objRole["Cp_list_Weeks"], function (indexMonths, objWeeks) {
                                    //Changed by mahesh on 20 sept 2021

                                    if (CpList_WeekHeaderNames.length == 12) {
                                        strHTMLWeek += "<tr class='CPhiderow_" + index + "  collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover1w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover1w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_1+"))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover2w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover2w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_2+"))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover3w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover3w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_3+"))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover4w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover4w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_4+"))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover5w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover5w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_5+"))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                            "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover6w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover6w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_6+"))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover7w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover7w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_7+"))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover8w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover8w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_8+"))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover9w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover9w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_9+"))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover10w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover10w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_10+"))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover11w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover11w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_11+"))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover12w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover12w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_12+"))\"'>" + objWeeks.Week_12 + "</a></td></tr>";
                                    }
                                    else if (CpList_WeekHeaderNames.length == 13) {
                                       strHTMLWeek += "<tr class='CPhiderow_" + index + "  collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover1w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover1w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_1+"))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover2w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover2w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_2+"))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover3w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover3w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_3+"))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover4w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover4w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_4+"))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover5w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover5w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_5+"))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                            "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover6w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover6w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_6+"))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover7w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover7w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_7+"))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover8w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover8w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_8+"))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover9w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover9w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_9+"))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover10w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover10w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_10+"))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover11w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover11w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_11+"))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover12w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover12w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_12+"))\"'>" + objWeeks.Week_12 + "</a></td><td> <a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover13w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[12].WkStartDate + "','" + CpList_WeekHeaderNames[12].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover13w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_13+"))\"'>" + objWeeks.Week_13 + "</a></td>  </tr>";
                                        //strHTMLWeek += "<tr class='CPhiderow_" + index + "  collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover1w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover1w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover2w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover2w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover3w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover3w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover4w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover4w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover5w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover5w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_5+"))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                        //    "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover6w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover6w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover7w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover7w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover8w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover8w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover9w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover9w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover10w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover10w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover11w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover11w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover12w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover12w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_12 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover13w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[12].WkStartDate + "','" + CpList_WeekHeaderNames[12].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover13w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_13 + "</a></td></tr>";
                                    }
                                    else if (CpList_WeekHeaderNames.length == 14) {
                                         strHTMLWeek += "<tr class='CPhiderow_" + index + "  collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover1w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover1w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_1+"))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover2w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover2w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_2+"))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover3w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover3w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_3+"))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover4w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover4w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_4+"))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover5w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover5w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_5+"))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                         "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover6w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover6w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_6+"))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover7w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover7w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_7+"))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover8w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover8w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_8+"))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover9w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover9w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_9+"))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover10w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover10w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_10+"))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover11w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover11w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_11+"))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover12w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover12w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_12+"))\"'>" + objWeeks.Week_12 + "</a></td><td> <a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover13w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[12].WkStartDate + "','" + CpList_WeekHeaderNames[12].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover13w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_13+"))\"'>" + objWeeks.Week_13 + "</a></td> <td> <a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover13w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[13].WkStartDate + "','" + CpList_WeekHeaderNames[13].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover14w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_14+"))\"'>" + objWeeks.Week_14 + "</a></td>  </tr>";
                                        //strHTMLWeek += "<tr class='CPhiderow_" + index + "  collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover1w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover1w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover2w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover2w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover3w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover3w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover4w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover4w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover5w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover5w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_5+"))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                        //    "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover6w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover6w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover7w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover7w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover8w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover8w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover9w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover9w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover10w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover10w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover11w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover11w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover12w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover12w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_12 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover13w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[12].WkStartDate + "','" + CpList_WeekHeaderNames[12].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover13w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_13 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover14w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[13].WkStartDate + "','" + CpList_WeekHeaderNames[13].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover14w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_14 + "</a></td></tr>";
                                    }
                                    else if (CpList_WeekHeaderNames.length == 15) {
                                        strHTMLWeek += "<tr class='CPhiderow_" + index + "  collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover1w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover1w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_1+"))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover2w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover2w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_2+"))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover3w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover3w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_3+"))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover4w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover4w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_4+"))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover5w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover5w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_5+"))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                         "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover6w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover6w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_6+"))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover7w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover7w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_7+"))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover8w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover8w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_8+"))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover9w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover9w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_9+"))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover10w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover10w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_10+"))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover11w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover11w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_11+"))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover12w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover12w" + indexMonths + objWeeks.RoleID + "',"+ objWeeks.Week_12+"))\"'>" + objWeeks.Week_12 + "</a></td><td> <a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover13w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[12].WkStartDate + "','" + CpList_WeekHeaderNames[12].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover13w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_13+"))\"'>" + objWeeks.Week_13 + "</a></td> <td> <a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover13w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[13].WkStartDate + "','" + CpList_WeekHeaderNames[13].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover14w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_14+"))\"'>" + objWeeks.Week_14 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover14w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[14].WkStartDate + "','" + CpList_WeekHeaderNames[14].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover15w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_15+"))\"'>" + objWeeks.Week_15 + "</a></td> </tr>";
                                        //strHTMLWeek += "<tr class='CPhiderow_" + index + "  collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover1w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover1w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover2w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover2w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover3w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover3w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover4w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover4w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopover5w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover5w" + indexMonths + objWeeks.RoleID + "',"+objWeeks.Week_5+"))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                        //    "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover6w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover6w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover7w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover7w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover8w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover8w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover9w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover9w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover10w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover10w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover11w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover11w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover12w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover12w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_12 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover13w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[12].WkStartDate + "','" + CpList_WeekHeaderNames[12].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover13w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_13 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover14w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[13].WkStartDate + "','" + CpList_WeekHeaderNames[13].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover14w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_14 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover15w" + indexMonths + objWeeks.RoleID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.RoleID + "','" + CpList_WeekHeaderNames[14].WkStartDate + "','" + CpList_WeekHeaderNames[14].WkEndDate + "'," + 1 + "," + 0 + ",'CPpopover15w" + indexMonths + objWeeks.RoleID + "'))\"'>" + objWeeks.Week_15 + "</a></td></tr>";
                                    }
                                    //END Changed by mahesh on 20 sept 2021

                                });
                            });
                        } else {

                            StopAjaxLoader("#bodyCapacityPalning-group");

                            strHTMLWeek += '<tr>  <td style="width:25%"></td><td colspan="13" class="text-center">' + NoDataFound + '</td></tr>';
                        }

                        ///Bind the Role and Chiled tr

                        $("#CP_RolewiseWeekTbody").html(strHTMLWeek);

                        StopAjaxLoader("#bodyCapacityPalning-group");
                        ///loadDataTable();
                    }
                    else {
                        //alert("No Data Found");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("No Data Found");
                    }



                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    //alert(err);
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyCapacityPalning-group");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyCapacityPalning-group");
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

        }

        function GetCapacityPlanningSkillMonthList(filterParams) {
            var strHTMLHeader = "";
            var strHTML = "";
            var strHTMLSummary = "";
            if (filterParams == null || filterParams == "undefined") {
                filterParams =
                {
                    BGOUType: "",
                    BGOUFilter: "",
                    SkillList: ""
                }
            }

            StartLoader("#bodyCapacityPalning-group");
            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/GetCapacityRolePlanListSkillMonthWise',
                method: 'POST',
                data: JSON.stringify(filterParams),
                dataType: 'json',
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (filterParams) {
                        xhr.setRequestHeader("Params", encryptString(isJson(filterParams) ? filterParams : JSON.stringify(filterParams)));
                    }
                },
                success: function (data) {
                    if (data != null && data != 'undefined') {
                        var strWeeksHeaderHTML = "";
                        var CpList_WeekHeaderNames = data["CpMonthsListHeader"];
                        ///Bind Header of month

                        //Set Header
                        if (CpList_WeekHeaderNames.length > 0) {
                            $("#lblCpMonthFirst").text(CpList_WeekHeaderNames[0].WkMonthName + " " + CpList_WeekHeaderNames[0].WkYear);
                            $("#lblCpMonthSecond").text(CpList_WeekHeaderNames[6].WkMonthName + " " + CpList_WeekHeaderNames[6].WkYear);
                            $("#lblCpMonthThird").text(CpList_WeekHeaderNames[12].WkMonthName + " " + CpList_WeekHeaderNames[12].WkYear);


                            var filter1 = CpList_WeekHeaderNames.filter(function (x) { return x.WkMonthName.includes(CpList_WeekHeaderNames[0].WkMonthName) });
                            if (filter1.length > 4) {
                                $("#lblCpMonthFirst").attr("colspan", "5");
                            }
                            var filter2 = CpList_WeekHeaderNames.filter(function (x) { return x.WkMonthName.includes(CpList_WeekHeaderNames[6].WkMonthName) });
                            if (filter2.length > 4) {
                                $("#lblCpMonthSecond").attr("colspan", "5");
                            }
                            var filter3 = CpList_WeekHeaderNames.filter(function (x) { return x.WkMonthName.includes(CpList_WeekHeaderNames[12].WkMonthName) });
                            if (filter3.length > 4) {
                                $("#lblCpMonthThird").attr("colspan", "5");
                            }
                            if (filter3.length > 5) {
                                $("#lblCpMonthThird").attr("colspan", "6");
                            }

                        }


                        strWeeksHeaderHTML += '<th> </th>';
                        if (CpList_WeekHeaderNames.length > 0) {
                            $.each(CpList_WeekHeaderNames, function (indexMonthHeader, objWeekHeader) {
                                strWeeksHeaderHTML += '<th> Week ' + objWeekHeader.WkMonth + '</th>';
                            });


                        } else {
                            StopAjaxLoader("#bodyCapacityPalning-group");
                            strWeeksHeaderHTML += '<tr><th><td class="text-center" colspan="6">' + NoDataFound + '</td></th></tr>';
                        }


                        $("#lstWeeks").html(strWeeksHeaderHTML);


                        var CpListSummary = data["Cp_WeeklistSummary"];
                        var CpList_SurplusDeficit = data["CpSurplusdeficit"];
                        var CpList_List = data["CpWeeksList"];
                        if ((CpListSummary != null && CpListSummary.length > 0) && (CpList_List != null && CpList_List.length > 0)) {

                            strHTMLSummary += "<tr class='collapsiblerow'> <td class='PRrolename'>Surplus/Deficit<a class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' data-bs-target='.CPhiderow_11" + "' title='View Task'>" +
                                " <img class='uparrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' title='Hide Task'>" +
                                "<img class='downarrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/down.svg' alt='View Task' width='15px' title='View Task'> </a></td>";



                            if (CpList_WeekHeaderNames.length == 12) {
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_1 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_2 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_3 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_4 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_5 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_6 + "</td>";
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_7 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_8 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_9 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_10 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_11 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_12 + "</td>";

                            }
                            else if (CpList_WeekHeaderNames.length == 13) {
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_1 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_2 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_3 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_4 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_5 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_6 + "</td>";
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_7 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_8 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_9 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_10 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_11 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_12 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_13 + "</td>";

                            }
                            else if (CpList_WeekHeaderNames.length == 14) {
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_1 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_2 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_3 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_4 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_5 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_6 + "</td>";
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_7 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_8 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_9 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_10 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_11 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_12 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_13 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_14 + "</td>";

                            }
                            else if (CpList_WeekHeaderNames.length == 15) {
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_1 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_2 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_3 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_4 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_5 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_6 + "</td>";
                                strHTMLSummary += " <td>" + CpList_SurplusDeficit.SurplusDeficit_7 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_8 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_9 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_10 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_11 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_12 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_13 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_14 + "</td><td>" + CpList_SurplusDeficit.SurplusDeficit_15 + "</td>";

                            }
                            strHTMLSummary += "</tr>";
                            $.each(CpListSummary, function (indexMonths, objWeeksSummary) {
                                if (CpList_WeekHeaderNames.length == 12) {
                                    strHTMLSummary += "<tr class='CPhiderow_11 collapse'><td>" + objWeeksSummary.Name + "</td><td>" + objWeeksSummary.Week_1Sum + "</td> <td>" + objWeeksSummary.Week_2Sum + "</td> <td>" + objWeeksSummary.Week_3Sum + "</td><td>" + objWeeksSummary.Week_4Sum + "</td> <td>" + objWeeksSummary.Week_5Sum + "</td> " +
                                        "<td>" + objWeeksSummary.Week_6Sum + "</td><td>" + objWeeksSummary.Week_7Sum + "</td><td>" + objWeeksSummary.Week_8Sum + "</td><td>" + objWeeksSummary.Week_9Sum + "</td><td>" + objWeeksSummary.Week_10Sum + "</td>  <td>" + objWeeksSummary.Week_11Sum + "</td><td>" + objWeeksSummary.Week_12Sum + "</td></tr>";
                                }
                                else if (CpList_WeekHeaderNames.length == 13) {
                                    strHTMLSummary += "<tr class='CPhiderow_11 collapse'><td>" + objWeeksSummary.Name + "</td><td>" + objWeeksSummary.Week_1Sum + "</td> <td>" + objWeeksSummary.Week_2Sum + "</td> <td>" + objWeeksSummary.Week_3Sum + "</td><td>" + objWeeksSummary.Week_4Sum + "</td> <td>" + objWeeksSummary.Week_5Sum + "</td> " +
                                        "<td>" + objWeeksSummary.Week_6Sum + "</td><td>" + objWeeksSummary.Week_7Sum + "</td><td>" + objWeeksSummary.Week_8Sum + "</td><td>" + objWeeksSummary.Week_9Sum + "</td><td>" + objWeeksSummary.Week_10Sum + "</td>  <td>" + objWeeksSummary.Week_11Sum + "</td><td>" + objWeeksSummary.Week_12Sum + "</td><td>" + objWeeksSummary.Week_13Sum + "</td></tr>";
                                }
                                else if (CpList_WeekHeaderNames.length == 14) {
                                    strHTMLSummary += "<tr class='CPhiderow_11 collapse'><td>" + objWeeksSummary.Name + "</td><td>" + objWeeksSummary.Week_1Sum + "</td> <td>" + objWeeksSummary.Week_2Sum + "</td> <td>" + objWeeksSummary.Week_3Sum + "</td><td>" + objWeeksSummary.Week_4Sum + "</td> <td>" + objWeeksSummary.Week_5Sum + "</td> " +
                                        "<td>" + objWeeksSummary.Week_6Sum + "</td><td>" + objWeeksSummary.Week_7Sum + "</td><td>" + objWeeksSummary.Week_8Sum + "</td><td>" + objWeeksSummary.Week_9Sum + "</td><td>" + objWeeksSummary.Week_10Sum + "</td>  <td>" + objWeeksSummary.Week_11Sum + "</td><td>" + objWeeksSummary.Week_12Sum + "</td><td>" + objWeeksSummary.Week_13Sum + "</td><td>" + objWeeksSummary.Week_14Sum + "</td></tr>";

                                }
                                else if (CpList_WeekHeaderNames.length == 15) {
                                    trHTMLSummary += "<tr class='CPhiderow_11 collapse'><td>" + objWeeksSummary.Name + "</td><td>" + objWeeksSummary.Week_1Sum + "</td> <td>" + objWeeksSummary.Week_2Sum + "</td> <td>" + objWeeksSummary.Week_3Sum + "</td><td>" + objWeeksSummary.Week_4Sum + "</td> <td>" + objWeeksSummary.Week_5Sum + "</td> " +
                                        "<td>" + objWeeksSummary.Week_6Sum + "</td><td>" + objWeeksSummary.Week_7Sum + "</td><td>" + objWeeksSummary.Week_8Sum + "</td><td>" + objWeeksSummary.Week_9Sum + "</td><td>" + objWeeksSummary.Week_10Sum + "</td>  <td>" + objWeeksSummary.Week_11Sum + "</td><td>" + objWeeksSummary.Week_12Sum + "</td><td>" + objWeeksSummary.Week_13Sum + "</td><td>" + objWeeksSummary.Week_14Sum + "</td><td>" + objWeeksSummary.Week_15Sum + "</td></tr>";

                                }
                            });
                            $("#CP_RolewiseWeekTbodySummary").html(strHTMLSummary)

                        } else {
                            $("#CP_RolewiseWeekTbodySummary").html(strHTMLSummary)
                        }
                        if (CpList_List.length > 0) {
                            $.each(CpList_List, function (index, objRole) {

                                strHTML += "<tr class='collapsiblerow'> <td class='PRrolename'> " + objRole.Description + " <a  class='nostyle hidden-xs UpDowncollapseArrow' data-bs-toggle='collapse' data-bs-target='.CPhiderow_" + index + "'title='View Task'>" +
                                    " <img class='uparrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/up.svg' alt='' width='15px' title='Hide Task'>" +
                                    "<img class='downarrow' data-bs-toggle='tooltip' data-bs-placement='top' src='../../../Whizible2.0-new/dist/img/down.svg' alt='View Task' width='15px' title='View Task'> </a></td>";


                                $.each(CpList_WeekHeaderNames, function (indexMonths, objWeeks) {

                                    strHTML += "<td></td>";
                                });
                                strHTML += "</tr>";

                                $.each(objRole["Cp_list_Skill_Weeks"], function (indexMonths, objWeeks) {
                                    //Changed by mahesh on 20 sept 2021
                                    if (CpList_WeekHeaderNames.length == 12) {
                                        strHTML += "<tr class='CPhiderow_" + index + " collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw1" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw1" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_1+"))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw2" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw2" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_2+"))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw3" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw3" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_3+"))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw4" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw4" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_4+"))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw5" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw5" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_5+"))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                            "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw6" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw6" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_6+"))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw7" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw7" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_7+"))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw8" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw8" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_8+"))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw9" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw9" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_9+"))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw10" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw10" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_10+"))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw11" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw11" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_11+"))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw12" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw12" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_12+"))\"'>" + objWeeks.Week_12 + "</a></td></tr>"
                                    }
                                    else if (CpList_WeekHeaderNames.length == 13) {
                                         strHTML += "<tr class='CPhiderow_" + index + " collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw1" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw1" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_1+"))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw2" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw2" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_2+"))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw3" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw3" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_3+"))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw4" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw4" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_4+"))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw5" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw5" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_5+"))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                            "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw6" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw6" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_6+"))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw7" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw7" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_7+"))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw8" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw8" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_8+"))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw9" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw9" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_9+"))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw10" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw10" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_10+"))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw11" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw11" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_11+"))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw12" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw12" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_12+"))\"'>" + objWeeks.Week_12 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw13" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[12].WkStartDate + "','" + CpList_WeekHeaderNames[12].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw13" + indexMonths + objWeeks.ToolID + "',"+objWeeks.Week_13+"))\"'>" + objWeeks.Week_13 + "</a></td></tr>"
                                        //strHTML += "<tr class='CPhiderow_" + index + " collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw1" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw1" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw2" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw2" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw3" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw3" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw4" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw4" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw5" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw5" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                        //    "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw6" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw6" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw7" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw7" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw8" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw8" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw9" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw9" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw10" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw10" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw11" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw11" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw12" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw12" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_12 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw13" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[12].WkStartDate + "','" + CpList_WeekHeaderNames[12].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw13" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_13 + "</a></td></tr>"

                                    }
                                    else if (CpList_WeekHeaderNames.length == 14) {
                                        strHTML += "<tr class='CPhiderow_" + index + " collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw1" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw1" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_1+"))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw2" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw2" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_2+"))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw3" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw3" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_3+"))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw4" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw4" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_4+"))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw5" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw5" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_5+"))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                            "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw6" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw6" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_6+"))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw7" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw7" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_7+"))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw8" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw8" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_8+"))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw9" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw9" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_9+"))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw10" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw10" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_10+"))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw11" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw11" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_11+"))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw12" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw12" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_12+"))\"'>" + objWeeks.Week_12 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw13" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[12].WkStartDate + "','" + CpList_WeekHeaderNames[12].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw13" + indexMonths + objWeeks.ToolID + "',"+objWeeks.Week_13+"))\"'>" + objWeeks.Week_13 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw14" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[13].WkStartDate + "','" + CpList_WeekHeaderNames[13].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw14" + indexMonths + objWeeks.ToolID + "',"+objWeeks.Week_14+"))\"'>" + objWeeks.Week_14 + "</a></td></tr>"
                                        //strHTML += "<tr class='CPhiderow_" + index + " collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw1" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw1" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw2" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw2" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw3" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw3" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw4" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw4" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw5" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw5" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                        //    "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw6" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw6" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw7" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw7" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw8" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw8" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw9" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw9" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw10" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw10" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw11" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw11" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw12" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw12" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_12 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw13" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[12].WkStartDate + "','" + CpList_WeekHeaderNames[12].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw13" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_13 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw14" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[13].WkStartDate + "','" + CpList_WeekHeaderNames[13].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw14" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_14 + "</a></td></tr>"

                                    }
                                    else if (CpList_WeekHeaderNames.length == 15) {

                                        strHTML += "<tr class='CPhiderow_" + index + " collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw1" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw1" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_1+"))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw2" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw2" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_2+"))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw3" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw3" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_3+"))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw4" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw4" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_4+"))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw5" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw5" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_5+"))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                            "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw6" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw6" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_6+"))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw7" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw7" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_7+"))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw8" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw8" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_8+"))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw9" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw9" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_9+"))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw10" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw10" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_10+"))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw11" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw11" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_11+"))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw12" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw12" + indexMonths + objWeeks.ToolID + "',"+ objWeeks.Week_12+"))\"'>" + objWeeks.Week_12 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw13" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[12].WkStartDate + "','" + CpList_WeekHeaderNames[12].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw13" + indexMonths + objWeeks.ToolID + "',"+objWeeks.Week_13+"))\"'>" + objWeeks.Week_13 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw14" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[13].WkStartDate + "','" + CpList_WeekHeaderNames[13].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw14" + indexMonths + objWeeks.ToolID + "',"+objWeeks.Week_14+"))\"'>" + objWeeks.Week_14 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw15" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[14].WkStartDate + "','" + CpList_WeekHeaderNames[14].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw15" + indexMonths + objWeeks.ToolID + "',"+objWeeks.Week_15+"))\"'>" + objWeeks.Week_15 + "</a></td></tr>"
                                        //strHTML += "<tr class='CPhiderow_" + index + " collapse'><td>" + objWeeks.Name + "</td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw1" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[0].WkStartDate + "','" + CpList_WeekHeaderNames[0].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw1" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_1 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw2" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[1].WkStartDate + "','" + CpList_WeekHeaderNames[1].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw2" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_2 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw3" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[2].WkStartDate + "','" + CpList_WeekHeaderNames[2].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw3" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_3 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw4" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[3].WkStartDate + "','" + CpList_WeekHeaderNames[3].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw4" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_4 + "</a></td> <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='right' type='button' data-html='true' id='CPpopoverw5" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[4].WkStartDate + "','" + CpList_WeekHeaderNames[4].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw5" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_5 + "</a></td> " +
                                        //    "<td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw6" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[5].WkStartDate + "','" + CpList_WeekHeaderNames[5].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw6" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_6 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover7" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[6].WkStartDate + "','" + CpList_WeekHeaderNames[6].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw7" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_7 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw8" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[7].WkStartDate + "','" + CpList_WeekHeaderNames[7].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw8" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_8 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw9" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[8].WkStartDate + "','" + CpList_WeekHeaderNames[8].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw9" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_9 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw10" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[9].WkStartDate + "','" + CpList_WeekHeaderNames[9].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw10" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_10 + "</a></td>  <td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopover11" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[10].WkStartDate + "','" + CpList_WeekHeaderNames[10].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw11" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_11 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw12" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[11].WkStartDate + "','" + CpList_WeekHeaderNames[11].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw12" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_12 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw13" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[12].WkStartDate + "','" + CpList_WeekHeaderNames[12].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw13" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_13 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw14" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[13].WkStartDate + "','" + CpList_WeekHeaderNames[13].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw14" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_14 + "</a></td><td><a href='javascript:;' data-bs-toggle='popover' data-bs-container='body' data-bs-placement='left' type='button' data-html='true' id='CPpopoverw15" + indexMonths + objWeeks.ToolID + "' onclick=\"(ToolTipClick('" + objWeeks.Name + "','" + objWeeks.ToolID + "','" + CpList_WeekHeaderNames[14].WkStartDate + "','" + CpList_WeekHeaderNames[14].WkEndDate + "'," + 0 + "," + 0 + ",'CPpopoverw15" + indexMonths + objWeeks.ToolID + "'))\"'>" + objWeeks.Week_15 + "</a></td></tr>"

                                    }
                                    //End Changed by mahesh on 20 sept 2021

                                });
                            });
                        } else {
                            StopAjaxLoader("#bodyCapacityPalning-group");

                            strHTML += '<tr>  <td style="width:25%"></td><td colspan="13" class="text-center">' + NoDataFound + '</td></tr>';
                        }

                        ///Bind the Role and Chiled tr

                        $("#CP_RolewiseWeekTbody").html(strHTML);

                        StopAjaxLoader("#bodyCapacityPalning-group");
                        ///loadDataTable();
                    }
                    else {
                        StopAjaxLoader("#bodyCapacityPalning-group");
                        //  alert("No Data Found");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("No Data Found");
                    }

                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    // alert(err);
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyCapacityPalning-group");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyCapacityPalning-group");
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

        }

        function ExportORDemandInfo(filterParams) {
            var filterParams1 =
            {
                BGOUType: "",
                BGOUFilter: "",
                SkillList: "",
                ReportFormat: "",
                ReportTab: "MonthWiseRole"
            }
            if (filterParams == null || filterParams == "undefined") {
                filterParams1.BGOUType = "",
                    filterParams1.BGOUFilter = "",
                    filterParams1.SkillList = "",
                    filterParams1.ReportFormat = ""

            }
            else {
                var BgOulst = GetSelectedOU();
                var BgcheckboxValues = [];
                var OucheckboxValues = [];
                var SkillcheckboxValues = [];

                $("#myfilterlistSkill input[type=checkbox]:checked").each(function (index, elem) {
                    SkillcheckboxValues.push($(elem).val());
                });

                $("#myfilterlistBG input[type=checkbox]:checked").each(function (index, elem) {
                    BgcheckboxValues.push($(elem).val());
                });

                if (SkillcheckboxValues.length > 0) {
                    SkillcheckboxValues = SkillcheckboxValues.join(" , ");
                    var SkillList = "SKM.Toolid in (" + SkillcheckboxValues + ")";
                    filterParams1.SkillList = SkillList;
                }

                if (BgcheckboxValues != null || BgcheckboxValues != "undefined") {
                    if (BgcheckboxValues.length <= 0) {

                        $("#lstBGOU input[type=checkbox]:checked").each(function (index, elem) {
                            OucheckboxValues.push($(elem).val());
                        });

                        if (OucheckboxValues.length > 0) {
                            OucheckboxValues = OucheckboxValues.join(" , ");

                            whereClause = "EMP.LocationID in (" + OucheckboxValues + ")";


                            filterParams1.BGOUType = "O";
                            filterParams1.BGOUFilter = whereClause;

                        }

                    }
                    else {
                        if (BgOulst.length > 0) {
                            var whereClause = "";
                            $.each(BgOulst, function (index, obj) {
                                var BusinessGroupID = obj.bgId;

                                for (i = 0; i < obj.oulist.length; i++) {
                                    whereClause += " (EMP.BusinessGroupID = " + BusinessGroupID + " and EMP.LocationID = " + obj.oulist[i] + ") or";
                                }

                            });
                            var lastIndex = whereClause.lastIndexOf(" ");

                            whereClause = whereClause.substring(0, lastIndex);


                            filterParams1.BGOUType = "BO";
                            filterParams1.BGOUFilter = whereClause;

                        }

                    }

                }
                if ((filterParams1.SkillList != null && filterParams1.SkillList.length > 0) || (filterParams1.BGOUFilter != null && filterParams1.BGOUFilter.length > 0)) {
                    if (IsMonthWise == true && IsRoleWise == true) {
                        GetCapacityPlanningRoleMonthList(filterParams1);
                    }
                    else if (IsMonthWise == true && IsSkillWise == true) {
                        GetCapacityPlanningSkillMonthList(filterParams1);
                    }
                    else if (IsWeekWise == true && IsRoleWise == true) {
                        GetCapacityPlanningList(filterParams1);
                    }
                    else if (IsWeekWise == true && IsSkillWise == true) {
                        GetCapacityQtrSkillWisePlanList(filterParams1);
                    } else {

                    }
                }
                var ReportsTab = $('#liRCPQuarterview').hasClass('active');
                if ($('#btnMonthRole').hasClass('active') && ReportsTab == false) {
                    ReportsTab = "MonthWiseRole";
                    filterParams1.ReportTab = ReportsTab;
                } else if ($('#btnMonthSkill').hasClass('active') && ReportsTab == false) {
                    ReportsTab = "MonthWiseSkill";
                    filterParams1.ReportTab = ReportsTab;
                }
                else if ($('#btnQtrRole').hasClass('active') && ReportsTab == true) {
                    ReportsTab = "QtrWiseRole";
                    filterParams1.ReportTab = ReportsTab;
                } else if ($('#btnQtrSkill').hasClass('active') && ReportsTab == true) {
                    ReportsTab = "QtrWiseSkill";
                    filterParams1.ReportTab = ReportsTab;
                }
                else {
                    ReportsTab = "MonthWiseRole";
                    filterParams1.ReportTab = ReportsTab;
                }
                filterParams1.ReportFormat = filterParams;
            }

            //var taskparameters = { intProxyUserID: '<%= Session("intUserID") %>', employeeID: '<%= Session("intUserID") %>', ReportFormat: ".pdf" }
            //var taskparameters = { employeeID: '<%= Session("intUserID") %>', ReportFormat: ReportFormat, OpportunityID: opportunityId }

            $.ajax({
                url: strUrl + '/api/RM_CapacityPlanning/ExportDocument',
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
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
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
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })
        }

        function FilterApplied() {
            // $(".mainclearalllink").removeClass("clsShowHide");
            $(".filter >  button").addClass("clsFilterHighlight");
        }

        function FilterNotApplied() {
            // $(".mainclearalllink").addClass("clsShowHide");
            $(".filter >  button").removeClass("clsFilterHighlight");
            $('#AdvanceFilterIcon').attr("aria-expanded", false);
        }

        // function LoadPagination(tblId, data) {
        //    //var businessGroupTable;
        //    //---tblId  BGtblmain
        //    $.fn.DataTable.ext.pager.numbers_length = 10;
        //    $(tblId).dataTable({
        //        "dtat": data,
        //        "bFilter": false,
        //        "retrieve": true,
        //        "fixedHeader": true,
        //        "scrollX": true,
        //        "scrollY": '100',
        //        "scrollResize": true,
        //        "scrollcollapse": true,

        //        //"scrollY": 'auto',
        //        // "autoWidth": false,
        //        // "bSort":true,
        //        //   "bPaginate": true,
        //        //"pageLength": 15,
        //        //"bInfo": false, //hide paging info
        //        //"pagingType": "full_info",   //full_numbers
        //        "iDisplayLength": 1,
        //        "lengthChange": false,
        //        "searching": false,
        //        "destroy": true,
        //        //"language": {
        //        //    "emptyTable": "No data available in table",
        //        //    "zeroRecords":    "No matching records found",
        //        //    "paginate": {
        //        //        //"first": "<<",
        //        //        //"previous": "<",
        //        //        //"next": ">",
        //        //        //"last": ">>",
        //        //        "info": "_START_ - _END_ of _TOTAL_",
        //        //        "infoEmpty":"0 - 0 of 0",                    
        //        //    },
        //        //    "bInfo": true,
        //        //    "infoEmpty": "0 - 0 of 0",
        //        //  },
        //        //  "dom": '<"float-end top"p >rt<"clear">',
        //    });

        //}
    </script>
</body>
</html>
