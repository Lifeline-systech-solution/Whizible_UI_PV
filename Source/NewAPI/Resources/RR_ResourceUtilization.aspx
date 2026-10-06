<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RR_ResourceUtilization.aspx.vb" Inherits="PbNIT.RR_ResourceUntilization" %>

<!DOCTYPE html>
     <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<html>
<head runat="server"> 
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>


</head>
    <style type="text/css">
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important
        }

        a.clearalllink {
            font-weight: 700;
            margin: 7px 0 0 8px;
            display: none
        }

        .filter.pull-right {
            margin: 2px 0 0 8px
        }

        table tr th {
            vertical-align: middle !important
        }

        /*New css start here*/
        .classname {
            padding: 0;
            margin: 0;
            position: absolute;
            top: 65px;
            left: 80px
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px
        }

        .JStableOuter > table {
            overflow: initial
        }

            .JStableOuter > table.RsrsReportTbl > tbody > tr > td:first-child {
                min-width: 280px
            }

        .PRrolename .smallsubtext {
            margin-bottom: 0
        }

        .JStableOuter > table.RsrsReportTbl > tbody > tr > td {
            min-width: auto;
            min-width: 140px
        }

        .PRrolename .UpDowncollapseArrow {
            position: absolute;
            top: 10px;
            right: 10px;
            margin: 0
        }

        p.RsrsDesignation {
            color: #999;
            font-style: italic;
            font-weight: 400;
            margin: 0
        }

        .graybg td {
               /* Changed By Madhuri.K on 09-03-2026 */
    background: #F8FAFC;
        }

        .m-0 {
            margin: 0
        }

        .clsgraybglight td {
            background: #e6e6e6 !important
        }

        .PRrolename .media-left img {
            border: 1px solid #eee;
            border-radius: 2px;
            background: #ccc
        }

        .media.AssignRsrsProject {
            margin-left: 20px
        }

        /*.RsrsReportTblbox {
            display: none
        }*/

        .JStableOuter > table > thead > tr > th {
            background: #e7edf0;
            padding: 8px;
            position: sticky;
            top: 0;
        }

        .JStableOuter > table > tbody > tr:first-child > td {
            background: #e7edf0;
            padding: 8px;
            position: sticky;
            top: 38px;
            z-index: 9;
        }

        .JStableOuter > table > thead > tr > th:nth-child(1) {
            background: #e7edf0;
            padding: 8px;
            position: sticky;
            top: 0;
        }

        .JStableOuter > table > tbody > tr > td:nth-child(1) {
            position: sticky;
            left: 0;
        }
        /*Added by pradip on 30-7-2021*/
        .JStableOuter > table > tbody > tr:first-child > td:first-child {
            z-index: 99;
        }

        .JStableOuter > table > thead > tr > th:nth-child(1) {
            position: sticky;
            left: 0;
        }

        .cutoffvalue {
            display: inline-block
        }

        .cuttoffTxt {
            display: none
        }

        span.RsrsHr {
            display: block;
            color: #999;
            font-size: 12px
        }

        div#ui-datepicker-div {
            z-index: 9 !important
        }

        /*.JStableOuter.RRweektbl, .JStableOuter.RRmonthtbl, .JStableOuter.RRhalfyeartbl, .JStableOuter.RRquartertbl, .JStableOuter.RRyeartbl {
            display: none
        }*/

        .RsrsReportTbl th span {
            display: block
        }

        td.PRpercentage .RsrsAndPer {
            display: inline-block;
        }

        td.PRpercentage > div:first-child {
            border-right: 1px solid #ddd;
            padding-right: 0px;
            margin-right: 0px;
        }

        td.PRpercentage .RsrsAndPer span.RsrsPercentg {
            border-bottom: 1px solid #ddd;
            padding-bottom: 3px;
            margin-bottom: 3px;
        }

        td.PRpercentage .RsrsAndPer span.RsrsHr {
            margin-top: 5px;
        }

        td.PRpercentage .RsrsAndPer span {
            padding: 0 5px 0px 5px;
            margin-right: 5px;
        }

        .form-inline .form-group {
            margin-right: 15px;
        }

        .form-inline .form-control {
            margin-right: 0;
        }

        /*simple pagination style*/
        .simple-pagination {
            display: inline-block;
            padding-left: 0;
            margin-top: 1rem;
            margin-bottom: 1rem;
            border-radius: .25rem
        }

            .simple-pagination li {
                display: inline
            }

            .simple-pagination .page-link, .simple-pagination .ellipse, .simple-pagination .current {
                display: inline-block;
                position: relative;
                float: left;
                padding: .5rem .75rem;
                margin-left: -1px;
                color: #0275d8;
                text-decoration: none;
                background-color: #fff;
                border: 1px solid #ddd
            }

            .simple-pagination li:first-child .page-link {
                margin-left: 0;
                border-bottom-left-radius: .25rem;
                border-top-left-radius: .25rem
            }

            .simple-pagination li:last-child .page-link {
                border-bottom-right-radius: .2rem;
                border-top-right-radius: .2rem
            }

            .simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
                z-index: 2;
                color: #fff;
                cursor: default;
                background-color: #0275d8;
                border-color: #0275d8
            }

                .simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
                    background: #1359ac;
                }
        /*End of pagination style*/
        tr.clsgraybglightrow td {
            background: #e6e6e6 !important;
        }

        td.PRpercentage .RsrsAndPer.PH_utilization span {
            margin-right: 0px;
        }

        .RPTbl2.RsrsReportTblbox .JStableOuter {
            display: block;
        }

        .form-inline .form-group label {
            display: block;
        }

        .form-inline .form-group .form-control {
            width: 220px;
        }

        .form-inline .form-group .input-group .form-control {
            width: 175px;
        }

        .form-inline .form-group .cutoffvalue {
            width: 220px !important;
        }

        .JStableOuter > table > tbody > tr > td:nth-child(1), .JStableOuter > table > tbody > tr > td {
            box-shadow: none !important;
        }

        .JStableOuter > table > tbody {
            border-top: none !important;
            background: #fff;
        }

            .JStableOuter > table > tbody > tr > td {
                background: #fff;
                border-bottom: none;
            }

            .JStableOuter > table > tbody > tr > td {
                border-bottom: none !important;
                height: 54px;
            }

        .JStableOuter {
            border: none;
        }

            .JStableOuter > table > tbody > tr td {
                border-top: none;
            }

            .JStableOuter > table > tbody > tr {
                border-bottom: 1px solid #ddd;
                min-height: 20px !important
            }

        label.required:after {
            content: " *";
            color: red;
        }

        .clsShowHide {
            display: none !important;
        }
        
        .media:first-child{margin-top:0}
.media, .media-body{overflow:hidden;zoom:1}
.media-object.img-thumbnail{max-width:none}
.media-right, .media>.pull-right{padding-left:10px}
.media-left, .media>.pull-left{padding-right:10px}
.media-body, .media-left, .media-right{display:table-cell;vertical-align:top}
.media-middle{vertical-align:middle}
.media-bottom{vertical-align:bottom}
.media-heading{margin-top:0;margin-bottom:5px}
.media-list{padding-left:0;list-style:none}

tr.collapse.in {
    display: table-row!important;
}
.show{display:revert!important}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="body-ResourceUtilization">

    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-1 text-right graybg" style="display:table">
            <h5 class="pgtitle pull-left">Resource Utilization (By Project / Resource)</h5>
            <div class="dropdown filedownload pull-right" style="margin-top: 5px;">
                <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" data-placement="bottom" title="Click here to download" class="fas fa-download"></i></button>
                <ul class="dropdown-menu">
                    <li><a href="#" onclick="ExportResourceUtilizationReport('PDF');">
                        <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                    <li><a href="#" onclick="ExportResourceUtilizationReport('EXCEL');">
                        <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                    <li><a href="#" onclick="ExportResourceUtilizationReport('XML');">
                        <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                    <li><a href="#" onclick="ExportResourceUtilizationReport('RTF');">
                        <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Rtf</a></li>
                </ul>

            </div>
        </div>

        <div class="content pt-0">
            <div class="row pt-1 pb-1" style="display:block">
                <div class="col-sm-12 pb-1">
                    <div class="form-inline" action="">
                        <div class="form-group">
                            <label for="email" class="control-label required">Organize By:</label>
                            <select id="onchangeOrgBy" class="form-control">
                                <%--onchange="OnClickProjectAndResource();--%>
                                <option value="0">Select Organize By</option>
                                <option value="RPTbl1">Resources</option>
                                <option value="RPTbl2">Project</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="control-label required">Year:</label>
                            <% CommonFunctions.HTMLControls.DrawComboBox("cboYear", "usp_Whizible2_Sel_tbl_Pm_Companyinfo_ReportYear",,, "class='form-control' ",,,, ,) %>
                        </div>
                        <div class="form-group">
                            <label class="control-label required">Timeline:</label>
                            <select id="chngeRDtimelineday" name="" class="form-control">
                                <%--onchange="ChngRDTimelineFunction(event)"--%>
                                <option value="0">Select Timeline</option>
                                <option value="week">Week</option>
                                <option value="month">Month</option>
                                <option value="quarter">Quarter</option>
                                <option value="halfyear">Half Year</option>
                                <option value="year">Year</option>
                            </select>

                        </div>
                        <div class="form-group">
                            <label for="" class="required">Report In:</label>
                            <select class="form-control" id="cboReportIn">
                                <option value="0">Select</option>
                                <option value="RprtInPercentage" selected>Percentage</option>
                                <option value="RprtInHrs">Hours</option>
                            </select>
                        </div>
                        <div class="clearfix pt-1"></div>
                        <div class="form-group">
                            <label for="email">Business Group:</label>
                            <% CommonFunctions.HTMLControls.DrawComboBox("txtRUFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-control"" onChange=""FillOURSFilter(this.value)""",,,, ,) %>
                        </div>
                        <div class="form-group">
                            <label for="email">Organization Unit:</label>
                            <% CommonFunctions.HTMLControls.DrawComboBox("txtRUFilterLocationID", "Select '' ",,, "class=""form-control"" onChange=""FillDURSFilter(this.value)""",,,, , ) %>
                        </div>
                        <div class="form-group cutoffdiv" style="display: none">
                            <label for="">Delivery Unit:</label>
                            <% CommonFunctions.HTMLControls.DrawComboBox("txtRUFilterResourcePoolID", "Select '' ",,, "class=""form-control"" onChange=""FillDTRSFilter(this.value)""",,,, ,) %>
                        </div>
                        <div class="form-group cutoffdiv" style="display: none">
                            <label for="">Delivery Team:</label>
                            <% CommonFunctions.HTMLControls.DrawComboBox("txtRUFilterGroupID", "usp_sel_tbl_PM_GroupMaster_GroupID",,, "class='form-control'",,,, , ) %>
                        </div>
                        <div class="form-group cutoffdiv" style="display: none">
                            <label for="">Resource:</label>
                            <% CommonFunctions.HTMLControls.DrawComboBox("txtRUFilterEmployeeName", "usp_Whizible2_Sel_tbl_PM_Employee",,, "class='form-control'",,,, , ) %>
                        </div>
                    </div>
                    <div class="">
                        <div class="text-center hidden-sm centerbtn">
                            <br />
                            <%--<button class="btn btnyellow" onclick="ApplyUtilizationFilter()">Apply</button>--%>
                            <button class="btn btnyellow" onclick="Show()">Apply</button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>

            </div>

            <div class="RPTbl1 RsrsReportTblbox">
                <div class="form-inline">
                </div>
                <br />
                <div class="clearfix"></div>

                <div class="JStableOuter RRweektbl" id="RRweektblid">
                    <table id="tablewk" class="PRtable RPTbl1 RsrsReportTbl">
                        <thead id="WeeklyViewThHead">
                            <tr>
                                <th class="headerName">Resources</th>
                                <th>Week 1</th>
                                <th>Week 2</th>
                                <th>Week 3</th>
                                <th>Week 4</th>
                                <th>Week 5</th>
                                <th>Week 6</th>
                                <th>Week 7</th>
                                <th>Week 8</th>
                                <th>Week 9</th>
                                <th>Week 10</th>
                                <th>Week 11</th>
                                <th>Week 12</th>
                                <th>Week 13</th>
                                <th>Week 14</th>
                                <th>Week 15</th>
                                <th>Week 16</th>
                                <th>Week 17</th>
                                <th>Week 18</th>
                                <th>Week 19</th>
                                <th>Week 20</th>
                                <th>Week 21</th>
                                <th>Week 22</th>
                                <th>Week 23</th>
                                <th>Week 24</th>
                                <th>Week 25</th>
                                <th>Week 26</th>
                                <th>Week 27</th>
                                <th>Week 28</th>
                                <th>Week 29</th>
                                <th>Week 30</th>
                                <th>Week 31</th>
                                <th>Week 32</th>
                                <th>Week 33</th>
                                <th>Week 34</th>
                                <th>Week 35</th>
                                <th>Week 36</th>
                                <th>Week 37</th>
                                <th>Week 38</th>
                                <th>Week 39</th>
                                <th>Week 40</th>
                                <th>Week 41</th>
                                <th>Week 42</th>
                                <th>Week 43</th>
                                <th>Week 44</th>
                                <th>Week 45</th>
                                <th>Week 46</th>
                                <th>Week 47</th>
                                <th>Week 48</th>
                                <th>Week 49</th>
                                <th>Week 50</th>
                                <th>Week 51</th>
                                <th>Week 52</th>
                                <th>Week 53</th>
                            </tr>
                        </thead>
                        <tbody id="WeeklyViewTable">
                        </tbody>
                    </table>
                    <div id="pagination" class="pull-right"></div>
                </div>
                <div class="JStableOuter RRmonthtbl" id="RRmonthtblid">
                    <table id="tablemth" class="PRtable RPTbl1 RsrsReportTbl">
                        <thead id="MonthlyViewThHead">
                        </thead>
                        <tbody id="MonthlyViewTable">
                            <%--Commented by imran 12-10-2021for pagination--%>
                            <%-- <tr>
                                <td colspan="14">Please select filter and click on apply</td>
                            </tr>--%>
                        </tbody>
                    </table>
                </div>

                <div class="JStableOuter RRquartertbl" id="RRquartertblid">
                    <table id="tablequr" class="PRtable RPTbl1 RsrsReportTbl">
                        <thead id="QuarterlyViewThHead">
                            <tr>
                                <th class="headerName">Resources</th>
                                <th>Quarter 1</th>
                                <th>Quarter 2</th>
                                <th>Quarter 3</th>
                                <th>Quarter 4</th>
                            </tr>
                        </thead>
                        <tbody id="QuarterlyViewTable">
                        </tbody>
                    </table>
                </div>
                <div class="JStableOuter RRhalfyeartbl" id="RRhalfyeartblid">
                    <table id="tableyr" class="PRtable RPTbl1 RsrsReportTbl">
                        <thead id="HalfYearlyViewThHead">
                            <tr>
                            </tr>
                        </thead>
                        <tbody id="HalfYearlyViewTable">
                        </tbody>
                    </table>
                </div>

            </div>
            <%-- //Added By imran mujawar 11-10-2021 on 28th Sep 2020 for Pagination Change--%>
            <div class="row" style="margin-top: 5px" id="DivPagination">
                <div class='buttons col-sm-11' style="width: 90%; margin-top: 24px;">
                    <span id="" class="spntotal">Total Records : </span>
                    <span class="spntotal" id="TotalRecords"></span>
                </div>
                <div class='buttons col-sm-1' style="width: 10%" id="Pagination">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-end">
                            <li class="page-item" id="btnprevious">
                                <a class="page-link" aria-label="Previous" onclick='PrevList()' title="Previous" id="LinkPrevious">
                                    <i class="fas fa-angle-double-left"></i>
                                </a>
                            </li>
                            <li class="page-item" id="btnnext">
                                <a class="page-link" aria-label="Next" onclick='NextList()' title="Next" id="LinkNext">
                                    <i class="fas fa-angle-double-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>

                </div>
            </div>
            <%--End of  //Added By imran mujawar 11-10-2021 For Pagination Change--%>
        </div>
        </div>
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
                                            <span class="col-md-8">
                                                <input type="text" class="form-control" name=""><br />
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>
                                                    <button data-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right">Cancel</button>
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
        <!-- REQUIRED JS SCRIPTS -->
        <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
        <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
      <%--  <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>
        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
        <script src="../../General/CommonValidations.js?v=4"></script>--%>


        <script>

            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

            //let tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"))
            //var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            //    return new bootstrap.Tooltip(tooltipTriggerEl, {
            //        container: 'body',
            //        trigger: 'hover'
            //    });
            //});

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


            $("#CutofftxtdayDatepicker").datepicker({
                defaultDate: 15,
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd M yy',
                defaultDate: new Date()
            });
            $("#CutofftxtdayDatepicker").datepicker('setDate', new Date());


            //colappse row
            //Commented and Modified By RehanC on 30th Mar 2023
            //$(".UpDowncollapseArrow").click(function () {
            //    alert('in')
            //    $(".collapse").addClass("in");
            //    $(this).toggleClass("in");

            //});
            $(document).on("click", ".UpDowncollapseArrow", function () {
                $(this).toggleClass("in");
                $(this).closest("tr").toggleClass("activerow");
            });
            //End of Comment By RehanC on 30th Mar 2023


            //dynamically set height
            function resizeSection(tag) {
                var JStableOuter = $(window).height();
                $('.JStableOuter > table').css({ 'height': JStableOuter - 260, "overflow-y": "auto" });


            }
            $(window).on("load resize scroll", function (e) {
                resizeSection(this);
            });

            function OnClickProjectAndResource() {
                Project = true;
                Resource = false;
                var GroupBy = $('#onchangeOrgBy').find(":selected").text();
                console.log("GroupBy : ", GroupBy)
                if (GroupBy == "Project") {
                    //GetResourceAllocationByProject(null);
                    $(".RPTbl1").hide();
                    $(".RPTbl2").show();
                    $("#txtRUFilterEmployeeName").hide();

                    Project = true;
                }
                else if (GroupBy == "Resources") {
                    // GetResourceAllocationByResource(null);
                    $(".RPTbl2").hide();
                    $(".RPTbl1").show();
                    $("#txtRUFilterEmployeeName").show();
                    Resource = true;
                }
                else {

                }


            }

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
            var AvailableHr = 'Availability';
            var UtilizationHr = 'Utilization';
            var AvUtiHrs = AvailableHr + ' | ' + UtilizationHr + 'Hrs'
            //var AvailablePerc = 'Availability';
            // var UtilizationPerc = 'Utilization';
            var GlobalResourceCount = 0;
            var intPageNo = 1;

            var AvUtiPerc = AvailableHr + ' | ' + UtilizationHr + '%'
            $(document).ready(function () {
                strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
                //Added by imran 12-10-2021
                $("#DivPagination").hide();
                //End by imran 12-10-2021

                BindPlaceholder("cboYear", "Year");
                BindPlaceholder("txtRUFilterBusinessGroupID", "Business Group");
                BindPlaceholder("txtRUFilterEmployeeName", "Resource");
                if (blnViewAccess == "True") {
                    FillDTRSFilter(0);
                    FillDURSFilter(0);
                    FillOURSFilter(0);
                } else {
                    window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

                }
                $(".cutoffdiv").css('display', 'inline-block')

                AddClassNone();

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

            function Reprtformat(e) {
                $("select option:selected").each(function () {
                    if ($(this).attr("value") == "RprtInPercentage") {
                        //$(".cuttoffTxt").hide();
                        //$(".day").show();
                        $(".RsrsPercentg").css({ 'font-size': '14px', 'font-weight': 'bold', 'color': '#464a4c' });
                        $(".RsrsHr").css({ 'font-size': '12px', 'font-weight': 'normal', 'color': '#999999' });
                        //$(".RsrsHr").insertAfter(".RsrsPercentg");

                    }
                    if ($(this).attr("value") == "RprtInHrs") {
                        //$(".cuttoffTxt").hide();
                        //$(".day").show();
                        $(".RsrsHr").css({ 'font-size': '14px', 'font-weight': 'bold', 'color': '#464a4c' });
                        $(".RsrsPercentg").css({ 'font-size': '12px', 'font-weight': 'normal', 'color': '#999999' });
                        //$(".RsrsPercentg").insertAfter(".RsrsHr");
                    }

                    if ($(this).attr("value") == "blankselect") {
                        $(".RsrsPercentg, .RsrsHr").css({ 'font-size': '14px', 'font-weight': '400', 'color': '#464a4c' });

                    }

                });
            }

            $('#chngeRDtimelineday option').each(function () {
                if (this.selected)
                    $('.cutoffdiv').css('display', 'inline-block');
                $('#CutofftxtWeek').css('display', 'block');


            });

            //freez table
            //            $('.JStableOuter table').scroll(function (e) {
            ////modified script by pradip on 30 jul 2021
            //                $('.JStableOuter > table > thead').css("left", -$(".JStableOuter > tbody").scrollLeft());
            //                $('.JStableOuter > table > thead > tr > th:nth-child(1)').css("left", $(".JStableOuter > table").scrollLeft() - 0);
            //                $('.JStableOuter > table > tbody > tr > td:nth-child(1)').css("left", $(".JStableOuter > table").scrollLeft() - 0);


            //                $('.JStableOuter > table > thead').css("top", -$(".JStableOuter > tbody").scrollTop());
            //                $('.JStableOuter > table > thead > tr > th').css("top", $(".JStableOuter > table").scrollTop());
            //            });
            function FillOURSFilter(value) {
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
                        strHTML += "<option value='0'>Select Organization Unit</option>";
                        for (var i = 0; i < data.length; i++) {
                            var listComponent = data[i];
                            strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                        }
                        $("#txtRUFilterLocationID").html(strHTML);

                    },
                    //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
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
                    //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                })

            }
            function FillDURSFilter(value, param) {
                var strHTML = "";
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
                        strHTML += "<option value='0'>Select Delivery Unit</option>";
                        for (var i = 0; i < data.length; i++) {
                            var listComponent = data[i];
                            strHTML += ('<option value=' + listComponent.ResourcePoolID + ' >' + listComponent.ResourcePoolName + '</option>');
                        }
                        $("#txtRUFilterResourcePoolID").html(strHTML);
                        if (param != null && param > 0 && param != undefined) {
                        }

                    },
                    //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
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
                    //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                })

            }
            function FillDTRSFilter(value, param) {
                var strHTML = "";
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
                        strHTML += "<option value='0'>Select Delivery Team</option>";
                        for (var i = 0; i < data.length; i++) {
                            var listComponent = data[i];

                            strHTML += ('<option value=' + listComponent.GroupID + ' >' + listComponent.GroupName + '</option>');
                        }
                        $("#txtRUFilterGroupID").html(strHTML);
                        if (param != null && param > 0 && param != undefined) {
                            //$("#cboDT").val(param);
                        }

                    },
                    //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
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
                    //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                })

            }
            function GenerateBasicFilterQuery(module, filterField) {
                try {
                    var strqtext = "";
                    var txtBoxvalue = 0;
                    for (var i = 0; i < filterField.length; i++) {
                        var strvalue = '';
                        //var strOp = $('#Cbo' + module + 'Filter' + filterField[i]).val();
                        var strTXT = $('#txt' + module + 'Filter' + filterField[i]).val();
                        if (strTXT != null && strTXT != 'undefined' && strTXT != "") {
                            strvalue = strTXT
                        }

                        if (filterField[i] == "BusinessGroupID" && strTXT != "") {
                            var asd = "e.BusinessGroupID";

                            if (strqtext != "") strqtext += " AND ";
                            strqtext += asd + " = ";
                            strqtext += ' "' + strvalue + '"';
                        }
                        if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                            if (filterField[i] == "LocationID" && strTXT != "") {
                                var asd = "e.LocationID";

                                if (strqtext != "") strqtext += " AND ";
                                strqtext += asd + " = ";
                                strqtext += ' "' + strvalue + '"';
                            }
                        }
                        if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                            if (filterField[i] == "ResourcePoolID" && strTXT != "") {
                                var asd = "e.ResourcePoolID";

                                if (strqtext != "") strqtext += " AND ";
                                strqtext += asd + " = ";
                                strqtext += ' "' + strvalue + '"';
                            }
                        }
                        if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                            if (filterField[i] == "GroupID" && strTXT != "") {
                                var asd = "e.GroupID";

                                if (strqtext != "") strqtext += " AND ";
                                strqtext += asd + " = ";
                                strqtext += ' "' + strvalue + '"';
                            }
                        }
                        if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                            if (filterField[i] == "EmployeeName" && strTXT != "") {
                                var asd = "e.EmployeeName";
                                if (strqtext != "") strqtext += " AND ";
                                strqtext += asd + " = ";
                                //Added by imran 18-10-2021 SP Crash
                                if (strvalue == "") {
                                    strqtext += '"' + strvalue + '"';
                                }
                                else {
                                    strqtext += "'" + strvalue + "'";
                                }
                                //End by imran  18-10-2021
                            }
                        }

                    }

                    strqtext = strqtext.replace('Over', '[Over]')
                    strqtext = strqtext.replace(/'/g, "''");
                    //strqtext = strqtext.replace(/"/g, "''");
                    // console.log("strqtext", strqtext);
                    return strqtext;
                }
                catch (ex) {
                    //alert(ex.message);
                }
            }

            var validateflag = false;
            function ValidateUtilizationFilter() {
                var Year = $('#cboYear').val();
                var TimeLine = $('#chngeRDtimelineday').val();
                var ReportIn = $('#cboReportIn').val();
                var OrganizBy = $('#onchangeOrgBy').val();
                if (OrganizBy == '' || OrganizBy == 'undefined' || OrganizBy == '0') {
                    $('#onchangeOrgBy').focus();
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.error("Please Organize By.");
                    alertify.error("Please Select Organize By.");//Added By Rutuja D. For Rephrese Alert
                    validateflag = false;
                }
                else if (Year == '' || Year == 'undefined') {
                    $('#cboYear').focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please select Year.");
                    validateflag = false;
                }
                else if (TimeLine == 0) {
                    $('#chngeRDtimelineday').focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please select Time line.");
                    validateflag = false;
                }
                else if (ReportIn == 0) {
                    $('#cboReportIn').focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please select Report In.");
                    validateflag = false;
                }
                else {
                    validateflag = true;
                }
                return validateflag

            }

            //Added by imran 12-10-2021
            var gflag = 0;
            function Show() {
                gflag = 0;
                ApplyUtilizationFilter();
            }
            //End by imran 12-10-2021

            function ApplyUtilizationFilter() {
                //var ReportIn = $("#cboReportIn option:selected").val()
                //alert(ReportIn);
                //if (ReportIn == 'RprtInPercentage') {
                //    $('.clpnValues').html="mahesh"
                //} else {
                //    $('.clpnValues').html = "mahesh12432"
                //}
                //alert($('.clpnValues').innerHTML);
                //document.getElementById("spnValues").innerHTML = 'mahesahvvv';
                var Year = $('#cboYear option:selected').text();
                var TimeLine = $('#chngeRDtimelineday').val();
                var ReportIn = $('#cboReportIn  option:selected').text();


                var strHTML = '';
                var IsValid = ValidateUtilizationFilter();
                if (IsValid === true) {
                    // Added by imran on 11-10-2021 for pagination
                    if (gflag == 0) {
                        intPageNo = 1;
                        var n = GetFilterObjectForAllRecord();
                        var result = AJAXCallWithResult('/api/RR_ResourceUtilization/GetProjectWiseMonthView', JSON.stringify(n), false);
                        GlobalResourceCount = result.RrMonthsList.length;
                    }
                    //Added by imran on 11-10-2021 for pagination

                    var FilterObject = GetFilterObject();
                    //Commented and added by Chetan M on 19 Aug 2021 for report header
                    var BusinessGroupID = $('#txtRUFilterBusinessGroupID').val();
                    var OrganizationUnitID = $('#txtRUFilterLocationID').val();
                    var DeliveryUnitID = $('#txtRUFilterResourcePoolID').val();
                    var DeliveryTeamID = $('#txtRUFilterGroupID').val();
                    var ResourceName = $('#txtRUFilterEmployeeName').val();
                    FilterObject.Year = Year;
                    FilterObject.TimeLine = TimeLine;
                    FilterObject.ReportInStr = ReportIn;
                    //Added by imran on 22-08-2022
                    if (BusinessGroupID == "") {
                        FilterObject.BusinessGroupID = 0;
                    }
                    else {
                        FilterObject.BusinessGroupID = BusinessGroupID;
                    }
                    if (OrganizationUnitID == "") {
                        FilterObject.OrganizationUnitID = 0;
                    }
                    else {
                        FilterObject.OrganizationUnitID = OrganizationUnitID;
                    }
                    if (DeliveryUnitID == "") {
                        FilterObject.DeliveryUnitID = 0;
                    }
                    else {
                        FilterObject.DeliveryUnitID = DeliveryUnitID;
                    }
                    if (DeliveryTeamID == "") {
                        FilterObject.DeliveryTeamID = 0;
                    }
                    else {
                        FilterObject.DeliveryTeamID = DeliveryTeamID;
                    }
                    //End of by imran on 22-08-2022
                    FilterObject.ResourceName = ResourceName;
                    //Added by imran 18-10-2021 SP Crash
                    //if (ResourceName == "") {
                    //    FilterObject.ResourceName = ResourceName;
                    //}
                    //else {
                    //    FilterObject.ResourceName = "'" + ResourceName + "'";
                    //}
                    //End of Commented and added by Chetan M on 19 Aug 2021 for report header
                    //End by imran 18-10-2021 SP Crash
                    
                    StartLoader("#body-ResourceUtilization");
                    $.ajax({
                        url: strUrl + '/api/RR_ResourceUtilization/GetProjectWiseMonthView',
                        type: "POST",
                        data: JSON.stringify(FilterObject),
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                            if (FilterObject) {
                                xhr.setRequestHeader("Params", encryptString(isJson(FilterObject) ? FilterObject : JSON.stringify(FilterObject)));
                            }
                        },
                        success: function (data) {
                            if (data != "" && data != null) {
                                //Added by imran 12-10-2021
                                $("#DivPagination").show();
                                //End by imran 12-10-2021

                                var RrReportName = data["RrReportName"];
                                if (RrReportName == "ProjectMonthYear" || RrReportName == "ResourceMonthYear") {
                                    var UtilzMonthHeader = data["RrMonthsHeader"];
                                    var strHTMLHeader = '<tr> <th class="headerName">Resource </th>';
                                    if (UtilzMonthHeader != null && UtilzMonthHeader != 'undefined' && UtilzMonthHeader.length > 0) {
                                        $.each(UtilzMonthHeader, function (indexMonthHeader, objMonthHeader) {
                                            strHTMLHeader += '<th> ' + objMonthHeader + '</th>';
                                        });
                                    }
                                    strHTMLHeader += '</tr>'

                                    $("#MonthlyViewThHead").html(strHTMLHeader);
                                    var MonthlyViewTotalSum = data["TotalMontSum"]
                                    if (ReportIn == 'Percentage') {
                                        strHTML = '<tr class="clsgraybglightrow"> ' +
                                            ' <td class="text-left sortbyrole clsgraybglight" > <div class="col-sm-10">Total</div> </td > ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_1 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah1 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_2 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah2 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_3 + '</span></div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah3 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_4 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah2 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_5 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah5 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_6 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah6 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_7 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah7 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_8 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah8 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_9 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah9 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_10 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah10 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_11 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah11 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer PH_utilization"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_12 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah12 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' </tr > '
                                    } else {
                                        strHTML = '<tr class="clsgraybglightrow"> ' +
                                            ' <td class="text-left sortbyrole clsgraybglight" > <div class="col-sm-10">Total</div> </td > ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_1 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah1 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_2 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah2 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_3 + '</span></div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah3 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_4 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah2 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_5 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah5 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_6 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah6 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_7 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah7 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_8 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah8 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_9 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah9 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_10 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah10 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_11 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah11 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' <td class="PRpercentage"> <div class="RsrsAndPer PH_utilization"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_12 + '</span> </div> ' +
                                            ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah12 + '</span></div> ' +
                                            ' </td>  ' +
                                            ' </tr > '
                                    }
                                    var MonthlyViewList = data["RrMonthsList"];
                                    if (MonthlyViewList != "" && MonthlyViewList != null && MonthlyViewList.length > 0) {
                                        $.each(MonthlyViewList, function (indexMonths, objMonthlyViewList) {
                                            var objProjectMonth = objMonthlyViewList.ProjectMonth;
                                            if (RrReportName == "ProjectMonthYear") {
                                                objProjectMonth = objMonthlyViewList.ProjectMonth;
                                                strHTML += ' <tr> ' +
                                                    '<td class="text-left dropdown PRrolename"> ' +
                                                    ' <div class="media"> ' +
                                                    '  <div class="media-body"> <h5 class="media-heading">' + objProjectMonth.ProjectName + '</h5> <p class="RsrsDesignation"></p></div>  </div> ' +
                                                    ' <a href="#" class="nostyle hidden-sm UpDowncollapseArrow" data-bs-toggle="collapse" data-bs-target=".rphiderow' + indexMonths + '" data-original-title="" title=""> ' +
                                                    '<img class="uparrow" data-bs-toggle="tooltip" data-container="body" data-placement="top" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="" width="15px" title="Hide Details">' +
                                                    '<img class="downarrow" data-bs-toggle="tooltip" data-container="body" data-placement="top"  src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="" width="15px" title="Show Details"> </a>' +
                                                    ' </td> ';
                                            }
                                            else {
                                                objProjectMonth = objMonthlyViewList.ResourceMonth;
                                                strHTML += ' <tr> ' +
                                                    '<td class="text-left dropdown PRrolename"> ' +
                                                    ' <div class="media"> <div class="media-left"> ' +
                                                    ' <img src=' + objProjectMonth.ProfilePicURL + ' class="media-object" style="width: 36px; max-width: none;"> ' +
                                                    ' </div> <div class="media-body"> <h5 class="media-heading">' + objProjectMonth.ResourceName + '</h5> <p class="RsrsDesignation">' + objProjectMonth.Designation + '</p></div>  </div> ' +
                                                    ' <a href="#" class="nostyle hidden-sm UpDowncollapseArrow" data-bs-toggle="collapse" data-bs-target=".rphiderow' + indexMonths + '" data-original-title="" title=""> ' +
                                                    '<img class="uparrow" data-bs-toggle="tooltip" data-container="body" data-placement="top" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="" width="15px" title="Hide Details">' +
                                                    '<img class="downarrow" data-bs-toggle="tooltip" data-container="body" data-placement="top"  src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="" width="15px" title="Show Details"> </a>' +
                                                    ' </td> ';
                                            }

                                            if (ReportIn == 'Percentage') {
                                                strHTML +=
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg PH_utilization" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_1 + ' </span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah1 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_2 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah2 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_3 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah3 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_4 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah4 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_5 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah5 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_6 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah6 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_7 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah7 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_8 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah8 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_9 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah9 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_10 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah10 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_11 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah11 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_12 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah12 + '</span> </div> </td> ' +
                                                    '</tr> ';
                                            } else {
                                                strHTML +=
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg PH_utilization" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_1 + ' </span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah1 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_2 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah2 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_3 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah3 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_4 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah4 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_5 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah5 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_6 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah6 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_7 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah7 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_8 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah8 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_9 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah9 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_10 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah10 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_11 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah11 + '</span> </div> </td> ' +
                                                    ' <td class="PRpercentage">' +
                                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_12 + '</span> </div> ' +
                                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah12 + '</span> </div> </td> ' +
                                                    '</tr> ';
                                            }
                                            var MonthlyResourceViewList = objProjectMonth["RrResourceList"];
                                            if (RrReportName == "ProjectMonthYear") {
                                                MonthlyResourceViewList = objProjectMonth["RrResourceList"];
                                            }
                                            else {
                                                MonthlyResourceViewList = objProjectMonth["RrRList"];
                                            }
                                            if (MonthlyResourceViewList != "" && MonthlyResourceViewList != null && MonthlyResourceViewList.length > 0) {
                                                $.each(MonthlyResourceViewList, function (indexResourceMonths, objMonthlyResourceViewList) {
                                                    if (RrReportName == "ProjectMonthYear") {
                                                        strHTML += ' <tr class="rphiderow' + indexMonths + ' collapse"> ' +
                                                            '<td class="text-left dropdown PRrolename"> ' +
                                                            ' <div class="media"> <div class="media-left"> ' +
                                                            ' <img src=' + objMonthlyResourceViewList.ProfilePicURL + '  class="media-object" style="width: 36px; max-width: none;"> ' +
                                                            ' </div> <div class="media-body"> <h5 class="media-heading">' + objMonthlyResourceViewList.ResourceName + '</h5> <p class="RsrsDesignation">' + objMonthlyResourceViewList.Designation + '	</p></div> </div> ' + ' </td> ';
                                                    }
                                                    else {
                                                        strHTML += ' <tr class="rphiderow' + indexMonths + ' collapse"> ' +
                                                            '<td class="text-left dropdown PRrolename"> ' +
                                                            ' <div class="media"> ' +
                                                            ' <div class="media-body"> <h5 class="media-heading">' + objMonthlyResourceViewList.ProjectName + '</h5> <p class="RsrsDesignation"></p></div> </div> ' + ' </td> ';
                                                    }

                                                    strHTML +=
                                                        ' <td class="PRpercentage">' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_1 + '</span> </div> ' +
                                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah1 + '</span> </div> </td> ' +
                                                        ' <td class="PRpercentage">' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_2 + '</span> </div> ' +
                                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah2 + '</span> </div> </td> ' +
                                                        ' <td class="PRpercentage">' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_3 + '</span> </div> ' +
                                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah3 + '</span> </div> </td> ' +
                                                        ' <td class="PRpercentage">' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_4 + '</span> </div> ' +
                                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah4 + '</span> </div> </td> ' +
                                                        ' <td class="PRpercentage">' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_5 + '</span> </div> ' +
                                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah5 + '</span> </div> </td> ' +
                                                        ' <td class="PRpercentage">' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_6 + '</span> </div> ' +
                                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah6 + '</span> </div> </td> ' +
                                                        ' <td class="PRpercentage">' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_7 + '</span> </div> ' +
                                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah7 + '</span> </div> </td> ' +
                                                        ' <td class="PRpercentage">' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_8 + '</span> </div> ' +
                                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah8 + '</span> </div> </td> ' +
                                                        ' <td class="PRpercentage">' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_9 + '</span> </div> ' +
                                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah9 + '</span> </div> </td> ' +
                                                        ' <td class="PRpercentage">' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_10 + '</span> </div> ' +
                                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah10 + '</span> </div> </td> ' +
                                                        ' <td class="PRpercentage">' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_11 + '</span> </div> ' +
                                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah11 + '</span> </div> </td> ' +
                                                        ' <td class="PRpercentage">' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_12 + '</span> </div> ' +
                                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah12 + '</span> </div> </td> ' +
                                                        ' </tr> ';
                                                });
                                            }
                                            else {
                                                strHTML = '<tr><td></td><td colspan="12" class="text-center">No data found.</td></tr>'
                                                //Added by imran 12-10-2021
                                                $("#DivPagination").hide();
                                                //End by imran 12-10-2021
                                            }

                                        });
                                    }
                                    else {
                                        //Commented & Added By Pradip P. on 9 Feb 2022
                                        //strHTML = '<tr><td colspan="13">No data found.</td></tr>'
                                        strHTML = '<tr><td></td><td colspan="12" class="text-center">No data found.</td></tr>'
                                        //End of Commented & Added By Pradip P. on 9 Feb 2022
                                        //Added by imran 12-10-2021
                                        $("#DivPagination").hide();
                                        //End by imran 12-10-2021
                                    }

                                    $("#MonthlyViewTable").html(strHTML);
                                    AddClassNone();
                                    $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip(); //Added by Chetan M on 13 Aug 2021 for tooltip issue
                                    $("#RRmonthtblid").removeClass("clsShowHide");
                                }
                                if (RrReportName == "ProjectHalfYear" || RrReportName == "ResourceHalfYear") {
                                    GetHalfYearReport(data);
                                }
                                if (RrReportName == "ResourceQuarter" || RrReportName == "ProjectQuarter") {
                                    GetQuarterReport(data);
                                }
                                if (RrReportName == "ResourceWeek" || RrReportName == "ProjectWeek") {
                                    GetWeekReport(data);
                                }

                                var ReportInValue = $("#cboReportIn option:selected").text() == "Percentage" ? " ( % ) " : "( Hrs )";
                                var inpercenthr = $("#cboReportIn option:selected").val() == '0' ? '' : ReportInValue;
                                var SelectedReportId = $("#cboReportIn option:selected").text();
                                var name = $("#onchangeOrgBy option:selected").text() + ' Availability|Utilization ' + inpercenthr;
                                $(".headerName").html(name);

                                //Added by imran 12-10-2021 For Pagination
                                Pagination();
                                //End by imran12-10-2021
                            }
                            else {
                                //Added by imran 12-10-2021
                                $("#DivPagination").hide();
                                //End by imran 12-10-2021

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error("No data.");
                            }
                            StopAjaxLoader("#body-ResourceUtilization");
                            //Added By RehanC For not getting alert after Applying filter on 21st Mar 2023
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success("Filter Applied Successfully");
                           //End of Comment Added By RehanC For not getting alert after Applying filter on 21st Mar 2023
                        },
                        //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                        //error: function (err) {
                        //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        //    StopAjaxLoader("#body-ResourceUtilization");
                        //}
                        error: function (xhr, ajaxOptions, thrownError) {
                            if (ajaxOptions == "error") {
                                if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                    window.open("../../../Default.aspx", "_top");
                                } else {
                                    window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                }
                            }
                            StopAjaxLoader("#body-ResourceUtilization");
                        }
                        //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    })
                }
            }

            // Added by imran M 11-10-2021 For Pageno=0 and Pagesize=0 For total Count
            function GetFilterObjectForAllRecord() {
                var Year = $('#cboYear').val();
                var TimeLine = $('#chngeRDtimelineday').val();
                var ReportIn = $('#cboReportIn').val();
                var filterParams =
                {
                    RUWhereClause: "",
                    ReportFormat: "",
                    ReportTab: "Resources"
                }
                var AllRUFilter = ["Year", "Timeline", "ReportIn", "BusinessGroupID", "LocationID", "ResourcePoolID", "GroupID", "EmployeeName"];
                var filterWhereClause2 = GenerateBasicFilterQuery("RU", AllRUFilter);
                if (filterWhereClause2 != null && filterWhereClause2 != 'undefined') {
                    filterParams.RUWhereClause = filterWhereClause2;
                }
                var ReportsTab = $('#onchangeOrgBy').find(":selected").text();
                filterParams.TimeLine = TimeLine

                if (ReportIn == 'RprtInPercentage') {
                    filterParams.ReportIn = 0
                } else {
                    filterParams.ReportIn = 1;
                }

                filterParams.YearPrevNext = Year;

                if (ReportsTab == "Project") {
                    ReportsTab = "Project";
                    filterParams.ReportTab = ReportsTab;
                }
                else if (ReportsTab == "Resources") {
                    ReportsTab = "Resources";
                    filterParams.ReportTab = ReportsTab;
                }
                else {
                    ReportsTab = "Resources";
                    filterParams.ReportTab = ReportsTab;
                }
                filterParams.ReportFormat = 'Filter';
                filterParams.ReportTab = ReportsTab;
                filterParams.PageSize = 0;
                filterParams.PageNo = 0;
                return filterParams;
            }
            //End by imran 11-10-2021

            // Added by imran 11-10-2021
            function Pagination() {
                TotalRecords = GlobalResourceCount;
                var currentRecord = (intPageNo * 20);
                if (parseInt(intPageNo) == 1) {
                    $("#btnprevious").addClass("fa-disabled");
                    $("#btnnext").removeClass("fa-disabled");
                    $("#LinkPrevious").removeAttr("Onclick");
                    $("#LinkNext").attr("Onclick", "NextList()");
                }
                if (parseInt(currentRecord) > parseInt(TotalRecords) && intPageNo == 1) {
                    $("#btnprevious").addClass("fa-disabled");
                    $("#btnnext").addClass("fa-disabled");

                    $("#LinkPrevious").removeAttr("Onclick");
                    $("#LinkNext").removeAttr("Onclick");
                }
                else if (parseInt(currentRecord) >= parseInt(TotalRecords)) {
                    $("#btnprevious").removeClass("fa-disabled");
                    $("#btnnext").addClass("fa-disabled");
                    $("#LinkPrevious").attr("Onclick", "PrevList()");
                    $("#LinkNext").removeAttr("Onclick");
                }

                else if (parseInt(intPageNo) > 1 && parseInt(currentRecord) < parseInt(TotalRecords)) {
                    $("#btnprevious").removeClass("fa-disabled");
                    $("#btnnext").removeClass("fa-disabled");
                    $("#LinkPrevious").attr("Onclick", "PrevList()");
                    $("#LinkNext").attr("Onclick", "NextList()");
                }
                //if (parseInt(SearchRecords) == "1" && parseInt(currentRecord) >= parseInt(TotalRecords)) {

                //    $("#btnprevious").addClass("fa-disabled");
                //    $("#btnnext").addClass("fa-disabled");
                //    $("#LinkPrevious").removeAttr("Onclick");
                //    $("#LinkNext").removeAttr("Onclick");
                //}


                if (isIE() == "IE") {
                    if ($("#btnprevious").hasClass("fa-disabled")) {
                        $("#btnprevious").addClass("clsPaginationEnableDisable");
                    }
                    else {
                        $("#btnprevious").removeClass("clsPaginationEnableDisable");
                    }
                    if ($("#btnnext").hasClass("fa-disabled")) {
                        $("#btnnext").addClass("clsPaginationEnableDisable");
                    }
                    else {
                        $("#btnnext").removeClass("clsPaginationEnableDisable");
                    }
                }
                $("#TotalRecords").html("");
                $("#TotalRecords").html(TotalRecords);
            }
            // End by imran 11-10-2021

            // Added by imran 11-10-2021
            function isIE() {
                var brwser = '';
                var ua = navigator.userAgent, tem,
                    M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
                if (/trident/i.test(M[1])) {
                    tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                    //return 'IE '+(tem[1] || '');
                    return 'IE';
                }
                if (M[1] === 'Chrome') {
                    tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                    if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                    brwser = 'CR';
                }
                else if (M[1] === 'Firefox') {
                    tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                    if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                    brwser = 'FF';
                }
                M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
                if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
                //return M.join(' ');
                return brwser;

            }
            // End by imran 11-10-2021

            // Added by imran 11-10-2021
            function PrevList() {
                StartLoader("#ResourceBody");
                gflag = 1;
                if (intPageNo <= 1) {
                    intPageNo = 1;
                }
                else {
                    intPageNo -= 1;
                }
                //ApplyUtilizationFilterNextPrevious();
                ApplyUtilizationFilter();
                StopAjaxLoader("#ResourceBody");
            }
            // End by imran 11-10-2021

            // Added by imran 11-10-2021
            function NextList() {
                StartLoader("#ResourceBody");
                gflag = 1;
                intPageNo += 1;
                //ApplyUtilizationFilterNextPrevious();
                ApplyUtilizationFilter();
                StopAjaxLoader("#ResourceBody");
            }
            // End by imran 11-10-2021

            var ajaxResult = '';
            function AJAXCallWithResult(url, param, async) {
                $.ajax({
                    url: encodeURI(strUrl) + url,
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
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
                return ajaxResult;
            }

            function AddClassNone() {
                $("#RRhalfyeartblid").addClass("clsShowHide");
                $("#RRquartertblid").addClass("clsShowHide");
                $("#RRweektblid").addClass("clsShowHide");
                $("#RRmonthtblid").addClass("clsShowHide");
            }
            function GetHalfYearReport(data) {
                $("#RRhalfyeartblid").addClass("clsShowHide");
                var UtilzMonthHeader = data["RrMonthsHeader"];
                var RrReportName = data["RrReportName"];
                var strHTMLHeader = '<tr> <th class="headerName">Resources </th>';
                if (UtilzMonthHeader != null && UtilzMonthHeader != 'undefined' && UtilzMonthHeader.length > 0) {
                    $.each(UtilzMonthHeader, function (indexMonthHeader, objMonthHeader) {
                        strHTMLHeader += '<th> ' + objMonthHeader + '</th>';
                    });
                }
                strHTMLHeader += '</tr>'

                $("#HalfYearlyViewThHead").html(strHTMLHeader);
                var MonthlyViewTotalSum = data["TotalMontSum"]
                var ReportIn = $('#cboReportIn  option:selected').text();

                if (ReportIn == 'Percentage') {

                    strHTML = '<tr class="clsgraybglightrow"> ' +
                        ' <td class="text-left sortbyrole clsgraybglight"> <div class="col-sm-10">Total</div> </td > ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_1 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah1 + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_2 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah2 + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body"></span' + MonthlyViewTotalSum.Month_3 + '> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah3 + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body"></span' + MonthlyViewTotalSum.Month_4 + ' </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah2 + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_5 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah5 + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_6 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah6 + '</span></div> ' +
                        ' </td>  ' +
                        ' </tr > '
                } else {
                    strHTML = '<tr class="clsgraybglightrow"> ' +
                        ' <td class="text-left sortbyrole clsgraybglight"> <div class="col-sm-10">Total</div> </td > ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_1 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah1 + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_2 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah2 + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body"></span' + MonthlyViewTotalSum.Month_3 + '> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah3 + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body"></span' + MonthlyViewTotalSum.Month_4 + ' </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah2 + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_5 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah5 + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_6 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Month_Ah6 + '</span></div> ' +
                        ' </td>  ' +
                        ' </tr > '
                }
                var MonthlyViewList = data["RrMonthsList"];

                if (MonthlyViewList != "" && MonthlyViewList != null && MonthlyViewList.length > 0) {
                    $.each(MonthlyViewList, function (indexMonths, objMonthlyViewList) {
                        var objProjectMonth = objMonthlyViewList.ProjectHalfYear;

                        if (RrReportName == "ProjectHalfYear") {
                            objProjectMonth = objMonthlyViewList.ProjectHalfYear;
                            strHTML +=
                                ' <tr> ' +
                                '<td class="text-left dropdown PRrolename"> ' +
                                ' <div class="media">  ' +
                                '  <div class="media-body"> <h5 class="media-heading">' + objProjectMonth.ProjectName + '</h5> <p class="RsrsDesignation"></p></div>  </div> ' +
                                ' <a href="#" class="nostyle hidden-sm UpDowncollapseArrow" data-bs-toggle="collapse" data-bs-target=".rphiderow' + indexMonths + '" data-original-title="" title=""> ' +
                                '<img class="uparrow" data-bs-toggle="tooltip" data-placement="top" data-container="body"  src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="" width="15px" title="Hide Details">' +
                                '<img class="downarrow" data-bs-toggle="tooltip" data-placement="top" data-container="body"  src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="" width="15px" title="Show Details"> </a>' +
                                ' </td> ';

                        }
                        else {
                            objProjectMonth = objMonthlyViewList.ResourceHalfYear;
                            strHTML +=
                                ' <tr> ' +
                                '<td class="text-left dropdown PRrolename"> ' +
                                ' <div class="media"> <div class="media-left"> ' +
                                ' <img src=' + objProjectMonth.ProfilePicURL + ' class="media-object" style="width: 36px; max-width: none;"> ' +
                                ' </div> <div class="media-body"> <h5 class="media-heading">' + objProjectMonth.ResourceName + '</h5> <p class="RsrsDesignation">' + objProjectMonth.Designation + '</p></div>  </div> ' +
                                ' <a href="#" class="nostyle hidden-sm UpDowncollapseArrow" data-bs-toggle="collapse" data-bs-target=".rphiderow' + indexMonths + '" data-original-title="" title=""> ' +
                                '<img class="uparrow" data-bs-toggle="tooltip" data-placement="top" data-container="body" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="" width="15px" title="Hide Details">' +
                                '<img class="downarrow" data-bs-toggle="tooltip" data-placement="top" data-container="body" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="" width="15px" title="Show Details"> </a>' +
                                ' </td> ';

                        }

                        if (ReportIn == 'Percentage') {

                            strHTML +=

                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg PH_utilization" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_1 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah1 + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_2 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah2 + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_3 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah3 + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_4 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah4 + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_5 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah5 + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_6 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah6 + '</span> </div> </td> ' +
                                //' <td class="PRpercentage">' +
                                '</tr> ';
                        } else {
                            strHTML +=

                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg PH_utilization" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_1 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah1 + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_2 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah2 + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_3 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah3 + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_4 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah4 + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_5 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah5 + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_6 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Month_Ah6 + '</span> </div> </td> ' +
                                '</tr> ';
                        }
                        var MonthlyResourceViewList = objProjectMonth["RrResourceList"];
                        if (RrReportName == "ProjectHalfYear") {
                            MonthlyResourceViewList = objProjectMonth["RrResourceList"];
                        }
                        else {
                            MonthlyResourceViewList = objProjectMonth["RrProjectList"];
                        }
                        console.log(MonthlyResourceViewList.length);
                        if (MonthlyResourceViewList != "" && MonthlyResourceViewList != null && MonthlyResourceViewList.length > 0) {
                            $.each(MonthlyResourceViewList, function (indexResourceMonths, objMonthlyResourceViewList) {

                                if (RrReportName == "ProjectHalfYear") {

                                    strHTML += ' <tr class="rphiderow' + indexMonths + ' collapse"> ' +
                                        '<td class="text-left dropdown PRrolename"> ' +
                                        ' <div class="media"> <div class="media-left"> ' +
                                        ' <img src=' + objMonthlyResourceViewList.ProfilePicURL + ' class="media-object" style="width: 36px; max-width: none;"> ' +
                                        ' </div> <div class="media-body"> <h5 class="media-heading">' + objMonthlyResourceViewList.ResourceName + '</h5> <p class="RsrsDesignation">' + objMonthlyResourceViewList.Designation + '</p></div> </div> ' + ' </td> ';
                                }
                                else {

                                    strHTML += ' <tr class="rphiderow' + indexMonths + ' collapse"> ' +
                                        '<td class="text-left dropdown PRrolename"> ' +
                                        ' <div class="media"> ' +
                                        '  <div class="media-body"> <h5 class="media-heading">' + objMonthlyResourceViewList.ProjectName + '</h5> <p class="RsrsDesignation"></p></div> </div> ' + ' </td> ';

                                }

                                if (ReportIn == 'Percentage') {
                                    strHTML +=
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_1 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah1 + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_2 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah2 + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_3 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah3 + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_4 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah4 + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_5 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah5 + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_6 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah6 + '</span> </div> </td> ' +
                                        ' </tr> ';
                                } else {
                                    strHTML +=
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_1 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah1 + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_2 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah2 + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_3 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah3 + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_4 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah4 + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_5 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah5 + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_6 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Month_Ah6 + '</span> </div> </td> ' +
                                        ' </tr> ';
                                }
                                //  $("#tableyr").removeClass("clsShowHide");
                            });
                        } else {
                            strHTML += '<tr><td></td><td colspan="6" class="text-center">No data found.</td></tr>'
                            //Added by imran 12-10-2021
                            $("#DivPagination").hide();
                            //End by imran 12-10-2021
                        }

                    });
                } else {
                    strHTML = '<tr><td></td><td colspan="6">No data found.</td></tr>'
                    //Added by imran 12-10-2021
                    $("#DivPagination").hide();
                    //End by imran 12-10-2021
                }
                $("#HalfYearlyViewTable").html(strHTML);
                AddClassNone();
                $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip(); //Added by Chetan M on 13 Aug 2021 for tooltip issue
                $("#RRhalfyeartblid").removeClass("clsShowHide");
            }

            function GetQuarterReport(data) {
                $("#RRquartertblid").addClass("clsShowHide");
                var UtilzMonthHeader = data["RrMonthsHeader"];
                var RrReportName = data["RrReportName"];
                //var strHTMLHeader = '<tr> <th>Resources </th>';
                //if (UtilzMonthHeader != null && UtilzMonthHeader != 'undefined' && UtilzMonthHeader.length > 0) {
                //    $.each(UtilzMonthHeader, function (indexMonthHeader, objMonthHeader) {
                //        strHTMLHeader += '<th> ' + objMonthHeader + '</th>';
                //    });
                //}
                //strHTMLHeader += '</tr>'
                //  $("#QuarterlyViewThHead").html(strHTMLHeader);

                var MonthlyViewTotalSum = data["TotalMontSum"]
                var ReportIn = $('#cboReportIn  option:selected').text();
                if (ReportIn == 'Percentage') {
                    strHTML = '<tr class="clsgraybglightrow"> ' +
                        ' <td class="text-left sortbyrole clsgraybglight"> <div class="col-sm-10">Total</div> </td > ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q1 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q1_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q2 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q2_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q3 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q3_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q4 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q4_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' </tr > '
                } else {
                    strHTML = '<tr class="clsgraybglightrow"> ' +
                        ' <td class="text-left sortbyrole clsgraybglight"> <div class="col-sm-10">Total</div> </td > ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q1 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q1_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q2 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q2_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q3 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q3_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q4 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.Q4_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' </tr > '
                }
                var MonthlyViewList = data["RrMonthsList"];

                if (MonthlyViewList != "" && MonthlyViewList != null && MonthlyViewList.length > 0) {
                    $.each(MonthlyViewList, function (indexMonths, objMonthlyViewList) {
                        var objProjectMonth = objMonthlyViewList.ProjectQuarter;

                        if (RrReportName == "ProjectQuarter") {
                            objProjectMonth = objMonthlyViewList.ProjectQuarter;
                            strHTML +=
                                ' <tr> ' +
                                '<td class="text-left dropdown PRrolename"> ' +
                                ' <div class="media">  ' +
                                //'<div class="media-left"> <img src="../../../Whizible2.0-new/dist/img/user2-160x160.jpg" class="media-object" style="width: 36px; max-width: none;"> </div>' +
                                '  <div class="media-body"> <h5 class="media-heading">' + objProjectMonth.ProjectName + '</h5> <p class="RsrsDesignation"></p></div>  </div> ' +
                                ' <a href="#" class="nostyle hidden-sm UpDowncollapseArrow" data-bs-toggle="collapse" data-bs-target=".rphiderow' + indexMonths + '" data-original-title="" title=""> ' +
                                '<img class="uparrow" data-bs-toggle="tooltip" data-placement="top" data-container="body" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="" width="15px" title="Hide Details">' +
                                '<img class="downarrow" data-bs-toggle="tooltip" data-placement="top" data-container="body" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="" width="15px" title="Show Details"> </a>' +
                                ' </td> ';

                        }
                        else {
                            objProjectMonth = objMonthlyViewList.ResourceQuarter;
                            strHTML +=
                                ' <tr> ' +
                                '<td class="text-left dropdown PRrolename"> ' +
                                ' <div class="media"> <div class="media-left"> ' +
                                ' <img src=' + objProjectMonth.ProfilePicURL + ' class="media-object" style="width: 36px; max-width: none;"> ' +
                                ' </div> <div class="media-body"> <h5 class="media-heading">' + objProjectMonth.ResourceName + '</h5> <p class="RsrsDesignation">' + objProjectMonth.Designation + '</p></div>  </div> ' +
                                ' <a href="#" class="nostyle hidden-sm UpDowncollapseArrow" data-bs-toggle="collapse" data-bs-target=".rphiderow' + indexMonths + '" data-original-title="" title=""> ' +
                                '<img class="uparrow" data-bs-toggle="tooltip" data-placement="top" data-container="body" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="" width="15px" title="Hide Details">' +
                                '<img class="downarrow" data-bs-toggle="tooltip" data-placement="top" data-container="body" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="" width="15px" title="Show Details"> </a>' +
                                ' </td> ';

                        }

                        if (ReportIn == 'Percentage') {

                            strHTML +=

                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg PH_utilization" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Q1 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Q1_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Q2 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Q2_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Q3 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Q3_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Q4 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.Q4_Ah + '</span> </div> </td> ' +
                                '</tr> ';
                        } else {
                            strHTML +=

                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg PH_utilization" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Q1 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Q1_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Q2 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Q2_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Q3 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Q3_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Q4 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.Q4_Ah + '</span> </div> </td> ' +
                                '</tr> ';
                        }
                        var MonthlyResourceViewList = objProjectMonth["RrResourceList"];
                        if (RrReportName == "ProjectQuarter") {
                            MonthlyResourceViewList = objProjectMonth["RrResourceList"];
                        }
                        else {
                            MonthlyResourceViewList = objProjectMonth["RrProjectList"];
                        }
                        console.log(MonthlyResourceViewList.length);
                        if (MonthlyResourceViewList != "" && MonthlyResourceViewList != null && MonthlyResourceViewList.length > 0) {
                            $.each(MonthlyResourceViewList, function (indexResourceMonths, objMonthlyResourceViewList) {

                                if (RrReportName == "ProjectQuarter") {

                                    strHTML += ' <tr class="rphiderow' + indexMonths + ' collapse"> ' +
                                        '<td class="text-left dropdown PRrolename"> ' +
                                        ' <div class="media"> <div class="media-left"> ' +
                                        ' <img src=' + objMonthlyResourceViewList.ProfilePicURL + '  class="media-object" style="width: 36px; max-width: none;"> ' +
                                        ' </div> <div class="media-body"> <h5 class="media-heading">' + objMonthlyResourceViewList.ResourceName + '</h5> <p class="RsrsDesignation">' + objMonthlyResourceViewList.Designation + '</p></div> </div> ' + ' </td> ';
                                }
                                else {

                                    strHTML += ' <tr class="rphiderow' + indexMonths + ' collapse"> ' +
                                        '<td class="text-left dropdown PRrolename"> ' +
                                        ' <div class="media">  ' +
                                        '  <div class="media-body"> <h5 class="media-heading">' + objMonthlyResourceViewList.ProjectName + '</h5> <p class="RsrsDesignation"></p></div> </div> ' + ' </td> ';

                                }
                                strHTML +=
                                    ' <td class="PRpercentage">' +
                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Q1 + '</span> </div> ' +
                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Q1_Ah + '</span> </div> </td> ' +
                                    ' <td class="PRpercentage">' +
                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Q2 + '</span> </div> ' +
                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Q2_Ah + '</span> </div> </td> ' +
                                    ' <td class="PRpercentage">' +
                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Q3 + '</span> </div> ' +
                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Q3_Ah + '</span> </div> </td> ' +
                                    ' <td class="PRpercentage">' +
                                    ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Q4 + '</span> </div> ' +
                                    '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.Q4_Ah + '</span> </div> </td> ' +
                                    ' </tr> ';
                            });
                        } else {
                            strHTML += '<tr><td></td><td colspan="4">No data found.</td></tr>'
                            //Added by imran 12-10-2021
                            $("#DivPagination").hide();
                            //End by imran 12-10-2021
                        }

                    });
                } else {
                    strHTML += '<tr><td></td><td colspan="4">No data found.</td></tr>'
                    //Added by imran 12-10-2021
                    $("#DivPagination").hide();
                    //End by imran 12-10-2021
                }
                $("#QuarterlyViewTable").html(strHTML);
                AddClassNone();
                $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip(); //Added by Chetan M on 13 Aug 2021 for tooltip issue
                $("#RRquartertblid").removeClass("clsShowHide");
            }
            function GetWeekReport(data) {
                $("#RRweektblid").addClass("clsShowHide");
                var UtilzMonthHeader = data["RrMonthsHeader"];
                var RrReportName = data["RrReportName"];
                //var strHTMLHeader = '<tr> <th>Resources </th>';
                //if (UtilzMonthHeader != null && UtilzMonthHeader != 'undefined' && UtilzMonthHeader.length > 0) {
                //    $.each(UtilzMonthHeader, function (indexMonthHeader, objMonthHeader) {
                //        strHTMLHeader += '<th> ' + objMonthHeader + '</th>';
                //    });
                //}
                //strHTMLHeader += '</tr>'

                //$("#WeeklyViewThHead").html(strHTMLHeader);
                var MonthlyViewTotalSum = data["TotalMontSum"]
                var ReportIn = $('#cboReportIn  option:selected').text();
                if (ReportIn == 'Percentage') {

                    strHTML = '<tr class="clsgraybglightrow"> ' +
                        ' <td class="text-left sortbyrole clsgraybglight"> <div class="col-sm-10">Total</div> </td > ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W1 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W1_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W2 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W2_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W3 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W3_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W4 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W4_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W5 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W5_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W6 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W6_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W7 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W7_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W8 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W8_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W9 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W9_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W10 + ' </span</div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W10_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W11 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W11_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W12 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W12_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W13 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W13_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W14 + ' </span</div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W14_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W15 + '</span </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W15_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W16 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W16_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W17 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W17_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W18 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W18_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W19 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W19_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W20 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W20_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W21 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W21_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W22 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W22_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W23 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W23_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W24 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W24_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W25 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W25_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W26 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W26_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W27 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W27_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W28 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W28_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W29 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W29_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W30 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W30_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W31 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W31_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W32 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W32_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W33 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W33_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W34 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W34_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W35 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W35_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W36 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W36_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W37 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W37_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W38 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W38_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W39 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W39_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W40 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W40_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W41 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W41_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W42 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W42_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W43 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W43_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W44 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W44_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W45 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W45_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W46 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W46_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W47 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W47_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W48 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W48_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W49 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W49_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W50 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W50_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W51 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W51_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W52 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W52_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W53 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Percentage" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W53_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' </tr > '
                }
                else {

                    strHTML = '<tr class="clsgraybglightrow"> ' +
                        ' <td class="text-left sortbyrole clsgraybglight"> <div class="col-sm-10">Total</div> </td > ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W1 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W1_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W2 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W2_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W3 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W3_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W4 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W4_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W5 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W5_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W6 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W6_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W7 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W7_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W8 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W8_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W9 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W9_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W10 + ' </span</div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W10_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W11 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W11_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W12 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W12_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W13 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W13_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W14 + ' </span</div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W14_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W15 + '</span </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W15_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W16 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W16_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W17 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W17_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W18 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W18_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W19 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W19_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W20 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W20_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W21 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W21_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W22 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W22_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W23 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W23_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W24 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W24_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W25 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W25_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W26 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W26_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W27 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W27_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W28 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W28_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W29 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W29_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W30 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W30_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W31 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W31_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W32 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W32_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W33 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W33_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W34 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W34_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W35 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W35_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W36 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W36_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W37 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W37_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W38 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W38_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W39 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W39_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W40 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W40_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W41 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W41_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W42 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W42_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W43 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W43_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W44 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W44_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W45 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W45_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W46 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W46_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W47 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W47_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W48 + '</span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W48_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W49 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W49_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W50 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W50_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W51 + '</span> </div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W51_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W52 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W52_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' <td class="PRpercentage"> <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Availability Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W53 + ' </span></div> ' +
                        ' <div class="RsrsAndPer PH_utilization" > <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Total Utilization Hours" data-placement="bottom" data-container="body">' + MonthlyViewTotalSum.W53_Ah + '</span></div> ' +
                        ' </td>  ' +
                        ' </tr > '

                }
                var MonthlyViewList = data["RrMonthsList"];

                if (MonthlyViewList != "" && MonthlyViewList != null && MonthlyViewList.length > 0) {
                    $.each(MonthlyViewList, function (indexMonths, objMonthlyViewList) {
                        var objProjectMonth = objMonthlyViewList.ProjectWeek;

                        if (RrReportName == "ProjectWeek") {
                            objProjectMonth = objMonthlyViewList.ProjectWeek;
                            strHTML +=
                                ' <tr> ' +
                                '<td class="text-left dropdown PRrolename"> ' +
                                ' <div class="media">  ' +
                                '  <div class="media-body"> <h5 class="media-heading">' + objProjectMonth.ProjectName + '</h5> <p class="RsrsDesignation"></p></div>  </div> ' +
                                ' <a href="#" class="nostyle hidden-sm UpDowncollapseArrow" data-bs-toggle="collapse" data-bs-target=".rphiderow' + indexMonths + '" data-original-title="" title=""> ' +
                                '<img class="uparrow" data-bs-toggle="tooltip" data-placement="top" data-container="body" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="" width="15px" title="Hide Details">' +
                                '<img class="downarrow" data-bs-toggle="tooltip" data-placement="top" data-container="body" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="" width="15px" title="Show Details"> </a>' +
                                ' </td> ';

                        }
                        else {
                            objProjectMonth = objMonthlyViewList.ResourceWeek;
                            strHTML +=
                                ' <tr> ' +
                                '<td class="text-left dropdown PRrolename"> ' +
                                ' <div class="media"> <div class="media-left"> ' +
                                ' <img src=' + objProjectMonth.ProfilePicURL + ' class="media-object" style="width: 36px; max-width: none;"> ' +
                                ' </div> <div class="media-body"> <h5 class="media-heading">' + objProjectMonth.ResourceName + '</h5> <p class="RsrsDesignation">' + objProjectMonth.Designation + '</p></div>  </div> ' +
                                ' <a href="#" class="nostyle hidden-sm UpDowncollapseArrow" data-bs-toggle="collapse" data-bs-target=".rphiderow' + indexMonths + '" data-original-title="" title=""> ' +
                                '<img class="uparrow" data-bs-toggle="tooltip" data-placement="top" data-container="body" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="" width="15px" title="Hide Details">' +
                                '<img class="downarrow" data-bs-toggle="tooltip" data-placement="top" data-container="body" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="" width="15px" title="Show Details"> </a>' +
                                ' </td> ';

                        }
                        if (ReportIn == 'Percentage') {
                            strHTML +=

                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg PH_utilization" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W1 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W1_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W2 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W2_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W3 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W3_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W4 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W4_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W5 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W5_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W6 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W6_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W7 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W7_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W8 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W8_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W9 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W9_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W10 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W10_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W11 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W11_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W12 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W12_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W13 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W13_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W14 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W14_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W15 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W15_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W16 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W16_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W17 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W17_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W18 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W18_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W19 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W19_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W20 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W20_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W21 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W21_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W22 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W22_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W23 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W23_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W24 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W24_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W25 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W25_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W26 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W26_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W27 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W27_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W28 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W28_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W29 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W29_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W30 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W30_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W31 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W31_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W32 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W32_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W33 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W33_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W34 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W34_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W35 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W35_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W36 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W36_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W37 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W37_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W38 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W38_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W39 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W39_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W40 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W40_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W41 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W41_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W42 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W42_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W43 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W43_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W44 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W44_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W45 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W45_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W46 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W46_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W47 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W47_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W48 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W48_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W49 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W49_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W50 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W50_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W51 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W51_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W52 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W52_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W53 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objProjectMonth.W53_Ah + '</span> </div> </td> ' +

                                '</tr> ';
                        }
                        else {
                            strHTML +=

                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg PH_utilization" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W1 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W1_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W2 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W2_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W3 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W3_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W4 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W4_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W5 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W5_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W6 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W6_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W7 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W7_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W8 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W8_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W9 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W9_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W10 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W10_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W11 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W11_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W12 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W12_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W13 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W13_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W14 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W14_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W15 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W15_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W16 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W16_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W17 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W17_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W18 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W18_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W19 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W19_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W20 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W20_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W21 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W21_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W22 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W22_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W23 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W23_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W24 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W24_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W25 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W25_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W26 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W26_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W27 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W27_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W28 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W28_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W29 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W29_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W30 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W30_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W31 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W31_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W32 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W32_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W33 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W33_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W34 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W34_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W35 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W35_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W36 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W36_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W37 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W37_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W38 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W38_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W39 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W39_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W40 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W40_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W41 + ' </span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W41_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W42 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W42_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W43 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W43_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W44 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W44_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W45 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W45_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W46 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W46_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W47 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W47_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W48 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W48_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W49 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W49_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W50 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W50_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W51 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W51_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W52 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W52_Ah + '</span> </div> </td> ' +
                                ' <td class="PRpercentage">' +
                                ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W53 + '</span> </div> ' +
                                '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objProjectMonth.W53_Ah + '</span> </div> </td> ' +

                                '</tr> ';

                        }


                        var MonthlyResourceViewList = objProjectMonth["RrResourceList"];
                        if (RrReportName == "ProjectWeek") {
                            MonthlyResourceViewList = objProjectMonth["RrResourceList"];
                        }
                        else {
                            MonthlyResourceViewList = objProjectMonth["RrProjectList"];
                        }
                        console.log(MonthlyResourceViewList.length);
                        if (MonthlyResourceViewList != "" && MonthlyResourceViewList != null && MonthlyResourceViewList.length > 0) {
                            $.each(MonthlyResourceViewList, function (indexResourceMonths, objMonthlyResourceViewList) {

                                if (RrReportName == "ProjectWeek") {

                                    strHTML += ' <tr class="rphiderow' + indexMonths + ' collapse"> ' +
                                        '<td class="text-left dropdown PRrolename"> ' +
                                        ' <div class="media"> <div class="media-left"> ' +
                                        ' <img src=' + objMonthlyResourceViewList.ProfilePicURL + ' class="media-object" style="width: 36px; max-width: none;"> ' +
                                        ' </div> <div class="media-body"> <h5 class="media-heading">' + objMonthlyResourceViewList.ResourceName + '</h5> <p class="RsrsDesignation">' + objMonthlyResourceViewList.Designation + '</p></div> </div> ' + ' </td> ';
                                }
                                else {

                                    strHTML += ' <tr class="rphiderow' + indexMonths + ' collapse"> ' +
                                        '<td class="text-left dropdown PRrolename"> ' +
                                        ' <div class="media">  ' +
                                        '  <div class="media-body"> <h5 class="media-heading">' + objMonthlyResourceViewList.ProjectName + '</h5> <p class="RsrsDesignation"></p></div> </div> ' + ' </td> ';

                                }
                                if (ReportIn == 'Percentage') {
                                    strHTML +=
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W1 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W1_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W2 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W2_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W3 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W3_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W4 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W4_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W5 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W5_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W6 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W6_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W7 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W7_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W8 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W8_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W9 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W9_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W10 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W10_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W11 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W11_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W12 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W12_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W13 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W13_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W14 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W14_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W15 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W15_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W16 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W16_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W17 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W17_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W18 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W18_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W19 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W19_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W20 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W20_Ah + '</span> </div> </td> ' +

                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W21 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W21_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W22 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W22_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W23 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W23_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W24 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W24_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W25 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W25_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W26 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W26_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W27 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W27_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W28 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W28_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W29 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W29_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W30 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W30_Ah + '</span> </div> </td> ' +

                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W31 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W31_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W32 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W32_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W33 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W33_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W34 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W34_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W35 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W35_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W36 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W36_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W37 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W37_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W38 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W38_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W39 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W39_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W40 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W40_Ah + '</span> </div> </td> ' +

                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W41 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W41_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W42 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W42_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W43 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W43_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W44 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W44_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W45 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W45_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W46 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W46_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W47 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W47_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W48 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W48_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W49 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W49_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W50 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W50_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W51 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W51_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W52 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W52_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W53 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Percentage" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W53_Ah + '</span> </div> </td> ' +

                                        ' </tr> ';
                                } else {

                                    strHTML +=
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W1 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W1_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W2 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W2_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W3 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W3_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W4 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W4_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W5 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W5_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W6 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W6_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W7 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W7_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W8 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W8_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W9 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W9_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W10 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W10_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W11 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W11_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W12 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W12_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W13 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W13_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W14 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W14_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W15 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W15_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W16 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W16_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W17 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W17_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W18 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W18_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W19 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W19_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W20 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W20_Ah + '</span> </div> </td> ' +

                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W21 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W21_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W22 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W22_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W23 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W23_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W24 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W24_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W25 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W25_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W26 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W26_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W27 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W27_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W28 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W28_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W29 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W29_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W30 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W30_Ah + '</span> </div> </td> ' +

                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W31 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W31_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W32 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W32_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W33 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W33_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W34 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W34_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W35 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W35_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W36 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W36_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W37 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W37_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W38 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W38_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W39 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W39_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W40 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W40_Ah + '</span> </div> </td> ' +

                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W41 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W41_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W42 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W42_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W43 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W43_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W44 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W44_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W45 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W45_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W46 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W46_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W47 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W47_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W48 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W48_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W49 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W49_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W50 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W50_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W51 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W51_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W52 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W52_Ah + '</span> </div> </td> ' +
                                        ' <td class="PRpercentage">' +
                                        ' <div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Availability Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W53 + '</span> </div> ' +
                                        '<div class="RsrsAndPer"> <span class="RsrsPercentg" data-bs-toggle="tooltip" title="Utilization Hours" data-placement="bottom" data-container="body">' + objMonthlyResourceViewList.W53_Ah + '</span> </div> </td> ' +

                                        ' </tr> ';

                                }
                            });
                        } else {
                            strHTML += '<tr><td></td><td colspan="53" class="text-center">No data found.</td></tr>'
                            //Added by imran 12-10-2021
                            $("#DivPagination").hide();
                            //End by imran 12-10-2021
                        }

                    });
                } else {
                    strHTML = '<tr><td></td><td colspan="53" class="text-center">No data found.</td></tr>'
                    //Added by imran 12-10-2021
                    $("#DivPagination").hide();
                    //End by imran 12-10-2021
                }
                $("#WeeklyViewTable").html(strHTML);
                AddClassNone();
                $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip(); //Added by Chetan M on 13 Aug 2021 for tooltip issue
                $("#RRweektblid").removeClass("clsShowHide");
            }
            function GetFilterObject() {
                var Year = $('#cboYear').val();
                var TimeLine = $('#chngeRDtimelineday').val();
                var ReportIn = $('#cboReportIn').val();
                var filterParams =
                {
                    RUWhereClause: "",
                    ReportFormat: "",
                    ReportTab: "Resources"
                }

                var AllRUFilter = ["Year", "Timeline", "ReportIn", "BusinessGroupID", "LocationID", "ResourcePoolID", "GroupID", "EmployeeName"];
                var filterWhereClause2 = GenerateBasicFilterQuery("RU", AllRUFilter);
                if (filterWhereClause2 != null && filterWhereClause2 != 'undefined') {
                    filterParams.RUWhereClause = filterWhereClause2;

                }
                var ReportsTab = $('#onchangeOrgBy').find(":selected").text();
                filterParams.TimeLine = TimeLine

                if (ReportIn == 'RprtInPercentage') {
                    filterParams.ReportIn = 0
                } else {
                    filterParams.ReportIn = 1;
                }

                filterParams.YearPrevNext = Year;

                if (ReportsTab == "Project") {
                    ReportsTab = "Project";
                    filterParams.ReportTab = ReportsTab;
                }
                else if (ReportsTab == "Resources") {
                    ReportsTab = "Resources";
                    filterParams.ReportTab = ReportsTab;
                }
                else {
                    ReportsTab = "Resources";
                    filterParams.ReportTab = ReportsTab;
                }
                filterParams.ReportFormat = 'Filter';
                filterParams.ReportTab = ReportsTab;
                /* Added by imran 11-10-2021*/
                if (gexport == 1) {
                    filterParams.PageSize = 0;
                    filterParams.PageNo = 0;
                }
                else {
                    filterParams.PageSize = 20;
                    filterParams.PageNo = intPageNo;
                }
                /*End by imran 11-10-2021*/
                return filterParams;
            }

            //Added by imran 12-10-2021
            var gexport = 0;
            //End by imran 12-10-2021
            function ExportResourceUtilizationReport(filterParams) {
                //Added by imran 12-10-2021 To export All Selected Data
                gexport = 1;
                //End by imran 12-10-2021
                var Year = $('#cboYear option:selected').text();
                var TimeLine = $('#chngeRDtimelineday').val();
                var ReportIn = $('#cboReportIn  option:selected').text();

                var IsValid = ValidateUtilizationFilter();
                if (IsValid === true) {
                    var FilterObjectReport = GetFilterObject();
                    FilterObjectReport.ReportFormat = filterParams;
                    //Commented and added by Chetan M on 19 Aug 2021 for report header
                    var BusinessGroupID = $('#txtRUFilterBusinessGroupID').val();
                    var OrganizationUnitID = $('#txtRUFilterLocationID').val();
                    var DeliveryUnitID = $('#txtRUFilterResourcePoolID').val();
                    var DeliveryTeamID = $('#txtRUFilterGroupID').val();
                    var ResourceName = $('#txtRUFilterEmployeeName').val();
                    FilterObjectReport.Year = Year;
                    FilterObjectReport.TimeLine = TimeLine;
                    FilterObjectReport.ReportInStr = ReportIn;
                    FilterObjectReport.BusinessGroupID = BusinessGroupID;
                    FilterObjectReport.OrganizationUnitID = OrganizationUnitID;
                    FilterObjectReport.DeliveryUnitID = DeliveryUnitID;
                    FilterObjectReport.DeliveryTeamID = DeliveryTeamID;
                    //Commented by imran 20-10-2021 SP Crash
                    //if (ResourceName == "")
                    //{
                    //    FilterObjectReport.ResourceName = ResourceName;
                    //}
                    //else
                    //{
                    //    FilterObjectReport.ResourceName = "'" + ResourceName +"'";
                    //}  
                    //End Comment by imran 20-10-2021 

                    //End of Commented and added by Chetan M on 19 Aug 2021 for report header
                    //console.log('FilterObjectReport')
                    //console.log(FilterObjectReport)


                    StartLoader("#body-ResourceUtilization");
                    $.ajax({
                        url: strUrl + '/api/RR_ResourceUtilization/ExportDocument',
                        type: "POST",
                        data: JSON.stringify(FilterObjectReport),
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                           xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                            if (FilterObjectReport) {
                                xhr.setRequestHeader("Params", encryptString(isJson(FilterObjectReport) ? FilterObjectReport : JSON.stringify(FilterObjectReport)));
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
                            StopAjaxLoader("#body-ResourceUtilization");
                        },
                        //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                        //error: function (err) {
                        //    console.log(err);
                        //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        //    StopAjaxLoader("#body-ResourceUtilization");
                        //}
                        error: function (xhr, ajaxOptions, thrownError) {
                            if (ajaxOptions == "error") {
                                if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                    window.open("../../../Default.aspx", "_top");
                                } else {
                                    window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                }
                            }
                            StopAjaxLoader("#body-ResourceUtilization");
                        }
                        //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    })
                }
            }
            ///List binding
            //1.Monthview binding

            //End 1.Monthview binding
            ///End List binding 

            //Added By Rutuja D. For Bind Filter Placeholder on 15 July 2021
            function BindPlaceholder(ID, Caption) {
                var textval = "Select " + Caption;
                if (document.getElementById(ID) != null) {
                    document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                    $("#" + ID + " option[value='']").prop('selected', true);
                }
            }
        //End of Added By Rutuja D. For Bind Filter Placeholder on 15 July 2021
        </script>
</body>
</html>
