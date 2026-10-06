<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RR_ResourceAllocationReport.aspx.vb" Inherits="PbNIT.RR_ResourceAllocationReport" %>

<!DOCTYPE html>
  
<html> 
    <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 

<head runat="server">
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
 --%>   <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">--%>
   <%-- <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
   --%> <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

   

</head>
     <style type="text/css">
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

        .filter.pull-right {
            margin: 2px 0 0 8px;
        }

        table tr th {
            vertical-align: middle !important;
        }

            table tr td:last-child .custom_chckbox label:before,
            table tr th:last-child .custom_chckbox label:before {
                margin-right: 0;
            }


        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        #MEdetails .control-label, #basicfilters label {
            line-height: 18px;
            text-align: right;
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

        th {
            position: sticky;
            top: 0;
        }

        /*End of pagination style*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" >
    <%--  /*Added & Commented By Madhuri.K On 21-Aug-2024 For Loader Issues*/--%>
    <div class="" id="body-ResourceAllocation"></div>
        <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-1 text-right graybg" style="display:table">
            <h5 class="pgtitle pull-left">Resource Allocation (By Project/By Resource)</h5>

            <div class="dropdown filedownload pull-right" style="margin-top: 5px;">
                <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><span data-bs-toggle="tooltip" data-bs-placement="bottom" title="Click here to download"><i class="fas fa-download"></i></span></button>
                <ul class="dropdown-menu">
                    <li><a href="#" onclick="ExportResourceAllocationReport('PDF');">
                        <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                    <li><a href="#" onclick="ExportResourceAllocationReport('EXCEL');">
                        <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                    <li><a href="#" onclick="ExportResourceAllocationReport('XML');">
                        <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                    <li><a href="#" onclick="ExportResourceAllocationReport('RTF');">
                        <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Rtf</a></li>
                </ul>

            </div>
        </div>


        <div class="col-sm-12 pt-1 pb-1">
            <!--Grid filter start from here-->
            <div class="form-horizontal">
                <div class="form-row mb-1">
                    <div class="col-sm-4">
                        <label class="control-label required">Group By</label>
                        <select id="RAonchangeBy" class="form-control">
                            <option value="0">Select Group by</option>
                            <option value="Project">Project</option>
                            <option value="Resource">Resource</option>
                        </select>
                    </div>
                    <div class="col-sm-4">
                        <label class="control-label required">From Date</label>
                        <div class="input-group">
                            <% CommonFunctions.HTMLControls.DrawTextBox("txtRAFilterFrom", "txtRAFilterFrom", "form-control clsDateColor",,,,,, False, False,, False, "autocomplete = 'off'",,, ,,,,) %>
                            <span class="input-group-btn">
                                <button class="btn btncalendar" type="button" style="height: 35px;"><i class="fas fa-calendar-alt"></i></button>
                            </span>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <label class="control-label required">To Date</label>
                        <div class="input-group">
                            <% CommonFunctions.HTMLControls.DrawTextBox("txtRAFilterTo", "txtRAFilterTo", "form-control clsDateColor",,,,,, False, False,, False, "autocomplete = 'off'",,, ,,,,) %>

                            <span class="input-group-btn">
                                <button class="btn btncalendar" type="button" style="height: 35px;"><i class="fas fa-calendar-alt"></i></button>
                            </span>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <div class="form-row">
                    <div class="col-sm-4">
                        <label class="control-label">Business Group</label>
                        <% CommonFunctions.HTMLControls.DrawComboBox("txtRAFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-control"" onChange=""FillFilterOUForFilter(this.value)""",,,, ,)%>
                    </div>
                    <div class="col-sm-4">
                        <label class="control-label">Organization Unit</label>
                        <% CommonFunctions.HTMLControls.DrawComboBox("txtRAFilterLocationID", "Select 0,'' ",,, "class='form-control'",,, ) %>
                    </div>

                    <div class="col-sm-4">
                        <label class="control-label">Practice</label>
                        <% CommonFunctions.HTMLControls.DrawComboBox("txtRAFilterProjectTypeID", "Select TypeId,ProjectType from tbl_PRS_ProjectTypes",,, "class=""form-control""",,,, ,)%>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="">
                    <div class="text-center hidden-xs centerbtn">
                        <br />
                        <button class="btn btnyellow" onclick="ApplyFilter();">Apply</button>
                    </div>
                </div>
            </div>
            <!--Grid filter end here-->
        </div>
        <div class="clearfix"></div>
        <div class="content pt-0">
            <div class="reportwrapper rsrsAllocationReprt">
                <div class="allocationRsrsRprtbyPro RsrsReportTblbox">
                    <table id="IDRsrsAllocationReprtTbl" class="table table-bordered RsrsAllocationReprtTbl" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>Project Name</th>
                                <th>Resource Name</th>
                                <th>Resource Role</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Rate Per Hour</th>
                                <th>Cost Per Hour</th>
                            </tr>
                        </thead>
                        <tbody id="tblResourceAllocationMain">
                            <tr>
                                <td colspan="7">Please select filter and click on apply</td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="clearfix"></div>
                </div>

                <div class="allocationRsrsRprtbyRsrs RsrsReportTblbox">
                    <table id="RsrsAllocationReprtTbl2" class="table table-bordered RsrsAllocationReprtTbl" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>Resource Name</th>
                                <th>Project Name</th>
                                <th>Resource Role</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Rate Per Hour</th>
                                <th>Cost Per Hour</th>
                            </tr>
                        </thead>
                        <tbody id="tblResourceAllocationByProject">
                        </tbody>
                    </table>

                    <div class="clearfix"></div>
                </div>
            </div>
        </div>



        <div class="clearfix"></div>
    </div>

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
                                        <label class="control-label col-md-4 p-0 text-right">Filter Name :</label>
                                        <span class="col-md-8">
                                            <input type="text" class="form-control" name=""><br />
                                            <div class="btnrow">
                                                <button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>
                                                <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right">Cancel</button>
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
  <%--  <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
   --%> <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>

<%--    <<%--script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>--%>

    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>
<%--   <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>


    <script>

        var NoDataFound = "No data found.";

        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var TagID = '<%= m_TagId%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var ResourceAllocationTable;
        var ResourceAllocationTableByRes;
        var noOfRowsPerPage = 10;
        var strUrl = '';
        var IsProject = true;
        var IsResource = false;
        
        //$('body').on('click', function (e) {
        //    alert();
        //    $('[data-bs-toggle="dropdown"]').each(function (e) {
        //        // hide any open popovers when the anywhere else in the body is clicked
        //        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.dropdown-menu').has(e.target).length === 0) {
        //            $(".dropdown-menu").removeClass('show');
        //        }
        //        else {
        //            $(".dropdown-menu").addClass('show');
        //        }
        //    });
        //});
      
        $(document).ready(function () {
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (blnViewAccess == "True") {
                FillFilterOUForFilter(0);
                GetMaximumItemsToShowInList();
                // GetResourceAllocationByProject(null);
                $(".allocationRsrsRprtbyRsrs").hide();
                $(".allocationRsrsRprtbyPro").show();
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }

            //Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
            BindPlaceholder("txtRAFilterBusinessGroupID", "Business Group");         
            BindPlaceholder("txtRAFilterProjectTypeID", "Practice");         
            //End of Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
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
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        function OnClickProjectAndResource() {
            IsProject = true;
            IsResource = false;
            var GroupBy = $('#RAonchangeBy').find(":selected").text();
            if (GroupBy == "Project") {
                GetResourceAllocationByProject(null);
                $(".allocationRsrsRprtbyRsrs").hide();
                $(".allocationRsrsRprtbyPro").show();
                IsProject = true;
            }
            else if (GroupBy == "Resource") {
                GetResourceAllocationByResource(null);
                $(".allocationRsrsRprtbyPro").hide();
                $(".allocationRsrsRprtbyRsrs").show();
                IsResource = true;
            }
            else {
                GetResourceAllocationByProject(null);
            }


        }

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
        $('#txtRAFilterFrom, #txtRAFilterTo, #RABasicFltrFrmDatefield, #RABasicFltrToDatefield').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd M yy'
        });
        function convert(str) {
            var date = new Date(str),
                mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                day = ("0" + date.getDate()).slice(-2);
            return [date.getFullYear(), mnth, day].join("-");
        }

        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        //Change table as per organized by
        //$("#RAonchangeBy").change(function () {
        //    $(this).find("option:selected").each(function () {
        //        var optionValue = $(this).attr("value");
        //        if (optionValue) {
        //            $(".RsrsReportTblbox").not("." + optionValue).hide();
        //            $("." + optionValue).show();
        //           // var conceptName = $('#RAonchangeBy').find(":selected").text();

        //          //  GetResourceAllocationByProject(null);

        //        } else {
        //            $(".RsrsReportTblbox").hide();
        //            //GetResourceAllocationByResource(null);
        //        }
        //    });
        //    $("table").resize();

        //}).change();
        var validateflag;
        function checkValidationForExport() {
            var from = $("#txtRAFilterFrom").val() == "" ? null : new Date($("#txtRAFilterFrom").val());
            var to = $("#txtRAFilterTo").val() == "" ? null : new Date($("#txtRAFilterTo").val());
            var GroupBy = $("#RAonchangeBy").val();
            if (GroupBy == '0' || GroupBy == null || GroupBy == 'undefined' || GroupBy == "Invalid Date") {
                $("#RAonchangeBy").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select Group by.");
                return false;
            }
            else if (from == null || from == 'undefined' || from == "Invalid Date") {
                $("#txtRAFilterFrom").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select From Date.");
                return false;
            }
            else if (to == null || to == 'undefined' || to == "Invalid Date") {
                $("#txtRAFilterTo").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select To Date.");
                return false;
            }
            else if (from > to) {
                $("#txtRAFilterTo").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("To date should be greater than From Date.");
                return false;
            }
            else {
                validateflag = true;
                return true;
            }
        }


        //START FILTER
        function ApplyFilter() {
            checkValidationForExport();
            if (validateflag == true) {
                var filterWhereClause2;
                var filter = "";
                currentFilterID = 0;
                var AllRAFilter = ["From", "To", "BusinessGroupID", "LocationID", "ProjectTypeID"];
                //var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
                filterWhereClause2 = GenerateBasicFilterQuery("RA", AllRAFilter);
                var GroupBy = $('#RAonchangeBy').find(":selected").text();
                if (GroupBy == "Project") {
                    GetResourceAllocationByProject(filterWhereClause2);
                    $(".allocationRsrsRprtbyRsrs").hide();
                    $(".allocationRsrsRprtbyPro").show();
                }
                else {
                    GetResourceAllocationByResource(filterWhereClause2);
                    $(".allocationRsrsRprtbyPro").hide();
                    $(".allocationRsrsRprtbyRsrs").show();
                }

                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");
            } else {
                return false;
            }
        }

        function GenerateBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                var txtBoxvalue = 0;
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    // var strOp = $('#Cbo' + module + 'Filter' + filterField[i]).val();
                    var strTXT = $('#txt' + module + 'Filter' + filterField[i]).val();
                    if (strTXT != null && strTXT != 'undefined' && strTXT != "") {
                        strvalue = strTXT
                    }
                    if (filterField[i] == "From" && strTXT != "") {
                        var asd = "(tbl_PM_ProjectEmployeeRole.ActualStartDate";
                        var afc = "tbl_PM_ProjectEmployeeRole.ExpectedStartDate";

                        if (strqtext != "") strqtext += " AND ";
                        strqtext += asd + " >= ";
                        strqtext += ' "' + strvalue + '"';
                        strqtext += " OR " + afc + " >= ";
                        strqtext += ' "' + strvalue + '" )';
                        console.log("strqtext", strqtext);
                    }
                    if (filterField[i] == "To" && strTXT != "") {
                        var asd = "(tbl_PM_ProjectEmployeeRole.ActualEndDate";
                        var afc = "tbl_PM_ProjectEmployeeRole.ExpectedEndDate";

                        if (strqtext != "") strqtext += " AND ";
                        strqtext += asd + " <= ";
                        strqtext += ' "' + strvalue + '"';
                        strqtext += " OR " + afc + " <= ";
                        strqtext += ' "' + strvalue + '" )';
                        console.log("strqtext", strqtext);
                    }
                    if (filterField[i] == "BusinessGroupID" && strTXT != "" && strvalue != "0") {
                        var asd = "tbl_PM_Employee.BusinessGroupID";

                        if (strqtext != "") strqtext += " AND ";
                        strqtext += asd + " = ";
                        strqtext += ' "' + strvalue + '"';
                    }
                    if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                        if (filterField[i] == "LocationID" && strTXT != "") {
                            var asd = "tbl_PM_Employee.LocationID";

                            if (strqtext != "") strqtext += " AND ";
                            strqtext += asd + " = ";
                            strqtext += ' "' + strvalue + '"';
                        }
                    }
                    //Added By Rutuja D. on 18 Aug 2021
                    if (filterField[i] == "ProjectTypeID" && strTXT != "" && strvalue != "0") {
                        var asd = "tbl_PRS_ProjectTypes.TypeID";

                        if (strqtext != "") strqtext += " AND ";
                        strqtext += asd + " = ";
                        strqtext += ' "' + strvalue + '"';
                    }
                    //End of Added By Rutuja D. on 18 Aug 2021
                    //if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                    //    if (strqtext != "") strqtext += " AND ";
                    //    if (strTXT != "0") {

                    //        strqtext += filterField[i] + " = ";
                    //        //strqtext += " ''%" + strvalue + "%''";
                    //        strqtext += ' "' + strvalue + '"';
                    //    }

                    //    else {

                    //        strqtext += filterField[i] + " ";
                    //        if ($.isNumeric(strvalue) == false) {
                    //            strqtext += strTXT + " ''" + strvalue + "''";
                    //        }
                    //        else {
                    //            //strqtext += strOp + " " + strvalue + "";
                    //            strqtext += strTXT + ' "' + strvalue + '"';
                    //        }
                    //    }
                    //}
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

        //datatable
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            ResourceAllocationTable = $('#IDRsrsAllocationReprtTbl').dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": true,
                "scrollResize": true,
                "scrollcollapse": true,

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
        function LoadPaginationByResource(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            ResourceAllocationTableByRes = $('#RsrsAllocationReprtTbl2').dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": true,
                "scrollResize": true,
                "scrollcollapse": true,

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

        //dynamically set height
        function resizeSection(tag) {
            var JStableOuter = $(window).height();
            $('.reportwrapper').css({ 'height': JStableOuter - 240, "overflow-y": "auto" });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });
        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        $('#PRTblList').on('show.bs.modal', function () {
            $(".table").resize();
        });
        $('#EPReleasemodal').on('show.bs.modal', function () {
            $(".table").resize();

        });
        function FillFilterOUForFilter(params) {
            var strHTML = "";
            var BgID = $('#txtRAFilterBusinessGroupID').val();
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
                   // strHTML += "<option value='0'></option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    }
                    if (params != null && params > 0 && params != undefined)
                        $("#txtRAFilterLocationID").val(params);

                    $("#txtRAFilterLocationID").html(strHTML);
                    //Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
            BindPlaceholder("txtRAFilterLocationID", "Organization Unit");
            //End of Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
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

            //}
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
                    //alert(noOfRowsPerPage);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.error(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(thrownError);
                    }


                }
            })

        }
        function GetResourceAllocationByProject(filterParams) {
            var strHTML = "";
            //StartLoader("#body-ResourceAllocation");
            var params = { RAWhereClause: filterParams };
            $.ajax({
                url: strUrl + '/api/RR_ResourceAllocationReport/GetResourceAllocationByProject',
                type: "POST",
                data: JSON.stringify(params),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (params) {
                        xhr.setRequestHeader("Params", encryptString(isJson(params) ? params : JSON.stringify(params)));
                    }
                },
                success: function (data) {
                    var List = data;
                    console.log("List", List);
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            strHTML += '<tr class="graybglight pgrow"><td colspan="7" class="text-left">' + obj.ProjectName + '</td></tr>'
                            $.each(obj.lstRAProjectReport, function (index, objrep) {
                                strHTML += '<tr class="pgrow"><td class="text-left">&nbsp;</td><td class="text-center">' + objrep.EmployeeName + '</td><td class="text-center">' + objrep.Role + '</td><td class="text-center">' + convert(objrep.From) + '</td><td class="text-center">' + convert(objrep.To) + '</td><td class="text-center">' + objrep.Rate + '</td><td class="text-center">' + objrep.Cost + '</td></tr>';
                            });
                        });
                    } else {
                        strHTML += '<tr class="pgrow"><td class="text-center" colspan="7">' + NoDataFound + '</td>/tr>';
                    }

                    // $('#IDRsrsAllocationReprtTbl').dataTable().fnDestroy();
                    $("#tblResourceAllocationMain").html(strHTML);
                    //LoadPagination(data);
                    //StopAjaxLoader("#body-ResourceAllocation");

                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-ResourceAllocation");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-ResourceAllocation");
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

        }
        function GetResourceAllocationByResource(filterParams) {
            var strHTML = "";
            var params = { RAWhereClause: filterParams };
            // StartLoader("#body-ResourceAllocation");
            $.ajax({
                url: strUrl + '/api/RR_ResourceAllocationReport/GetResourceAllocationByResource',
                type: "POST",
                data: JSON.stringify(params),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (params) {
                        xhr.setRequestHeader("Params", encryptString(isJson(params) ? params : JSON.stringify(params)));
                    }
                },
                success: function (data) {
                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            strHTML += '<tr class="graybglight pgrow"><td colspan="7" class="text-left">' + obj.EmployeeName + '</td></tr>'
                            $.each(obj.lstRAProjectReport, function (index, objrep) {
                                strHTML += '<tr class="pgrow"><td class="text-left">&nbsp;</td><td class="text-center">' + objrep.ProjectName + '</td><td class="text-center">' + objrep.Role + '</td><td class="text-center">' + convert(objrep.From) + '</td><td class="text-center">' + convert(objrep.To) + '</td><td class="text-center">' + objrep.Rate + '</td><td class="text-center">' + objrep.Cost + '</td></tr>';
                            });
                        });
                    } else {
                        strHTML += '<tr class="pgrow"><td class="text-center" colspan="7">' + NoDataFound + '</td>/tr>';
                    }

                    // $('#RsrsAllocationReprtTbl2').dataTable().fnDestroy();
                    $("#tblResourceAllocationByProject").html(strHTML);
                    //LoadPaginationByResource(data);
                    //StopAjaxLoader("#body-ResourceAllocation");

                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-ResourceAllocation");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-ResourceAllocation");
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

        }

        function ExportResourceAllocationReport(filterParams) {
            checkValidationForExport();
            if (validateflag == true) {
                var filterParams1 =
                    {
                        RAWhereClause: "",
                        ReportFormat: "",
                        ReportTab: "Project"
                    }

                var AllRAFilter = ["From", "To", "BusinessGroupID", "LocationID", "ProjectTypeID"];
                var filterWhereClause2 = GenerateBasicFilterQuery("RA", AllRAFilter);
                console.log("repo", filterWhereClause2);
                if (filterWhereClause2 != null && filterWhereClause2 != 'undefined') {
                    console.log("repo1", filterWhereClause2);
                    filterParams1.RAWhereClause = filterWhereClause2;


                }
                var ReportsTab = $('#RAonchangeBy').find(":selected").text();
                //alert(ReportsTab);
                //if (ReportsTab == "Project") {
                //    ReportsTab = "Project";
                //    filterParams1.ReportTab = ReportsTab;
                //}
                //else if (ReportsTab == "Resource") {
                //    ReportsTab = "Resource";
                //    filterParams1.ReportTab = ReportsTab;
                //}
                //else {
                //    ReportsTab = "Project";
                //    filterParams1.ReportTab = ReportsTab;
                //}
                filterParams1.ReportFormat = filterParams;
                filterParams1.ReportTab = ReportsTab;
            //}

            //var taskparameters = { intProxyUserID: '<%= Session("intUserID") %>', employeeID: '<%= Session("intUserID") %>', ReportFormat: ".pdf" }
            //var taskparameters = { employeeID: '<%= Session("intUserID") %>', ReportFormat: ReportFormat, OpportunityID: opportunityId }
                StartLoader("#body-ResourceAllocation");
                $.ajax({
                    url: strUrl + '/api/RR_ResourceAllocationReport/ExportDocument',
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
                        StopAjaxLoader("#body-ResourceAllocation");
                    },
                    //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    StopAjaxLoader("#body-ResourceAllocation");
                    //}
                     error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-ResourceAllocation");
                    }
                     //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                })
            } else {
                return false;
            }
        }

        //Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, 0), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value=0]").prop('selected', true);
            }
        }
        //End of Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
    </script>

</body>

</html>
