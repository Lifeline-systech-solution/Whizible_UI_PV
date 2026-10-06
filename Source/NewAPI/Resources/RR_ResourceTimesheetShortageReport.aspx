<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RR_ResourceTimesheetShortageReport.aspx.vb" Inherits="PbNIT.RR_ResourceTimesheetShortageReport" %>

<!DOCTYPE html>
 
<html> 
      <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head>
  <%--  <meta charset="utf-8">
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
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    

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

        .filter.pull-right {
            margin: 2px 0 0 8px;
        }

        table tr th {
            vertical-align: middle !important;
        }


        /*New css start here*/
        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .rsrslistRprtTbl tr td {
            text-align: left;
        }

        .rsrslistRprtTbl tr th {
            min-width: 100px;
            text-align: left;
        }

            .rsrslistRprtTbl tr th:nth-child(3n), .rsrslistRprtTbl tr th:nth-child(8n) {
                min-width: 140px;
            }

            .rsrslistRprtTbl tr th:nth-child(9n) {
                min-width: 200px;
            }
            /*.rsrslistRprtTbl tr th{min-width: 90px;}*/
            .rsrslistRprtTbl tr th:first-child {
                min-width: 200px;
            }

        .rsrslistRprtTbl tr th {
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

        th {
            position: sticky;
            top: 0;
        }
        /*End of pagination style*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed">

    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-1 text-right graybg" style="display:table">
            <h5 class="pgtitle pull-left">Resource Timesheet Shortage Report</h5>
            <!--<a href="javascript:;" class="clearalllink" style="" onclick="clearAll" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline pull-right">
                <button data-bs-toggle="tooltip" data-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-bs-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div>-->

            <div class="dropdown filedownload pull-right" style="margin-top: 5px;">
                <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" data-bs-placement="bottom" title="Click here to download" class="fas fa-download"></i></button>
                <ul class="dropdown-menu">
                    <li><a href="#" onclick="ExportResourceTimeSheetReport('PDF')">
                        <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                    <li><a href="#" onclick="ExportResourceTimeSheetReport('EXCEL')">
                        <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                    <li><a href="#" onclick="ExportResourceTimeSheetReport('XML')">
                        <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                    <li><a href="#" onclick="ExportResourceTimeSheetReport('RTF')">
                        <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Rtf</a></li>
                </ul>

            </div>

        </div>


        <div class="col-sm-12 pt-1 pb-1">
            <div class="form-inline">
                <div class="form-group">
                    <label>Organization Unit:</label>
                    <% CommonFunctions.HTMLControls.DrawComboBox("txtRTFilterLocationID", "SELECT LocationID, Location FROM tbl_PM_Location",,, "class=""form-control""",,,, ,)%>
                </div>
                <div class="form-group">
                    <label typeof="text" class="required">From Date:</label>
                    <div class="input-group" style="display:contents">
                        <% CommonFunctions.HTMLControls.DrawTextBox("txtRTFilterFrom", "txtRTFilterFrom", "form-control clsDateColor",,,,,, False, False,, False, "autocomplete = 'off'",,, ,,,,) %>
                        <span class="input-group-btn">
                            <button class="btn btncalendar" type="button" style="height: 35px; margin-top: -7px;margin-left:-13px"><i class="fas fa-calendar-alt"></i></button>
                        </span>
                    </div>
                </div>
                <div class="form-group">
                    <label typeof="text" class="required ml-1">To Date:</label>
                    <div class="input-group" style="display:contents">
                        <% CommonFunctions.HTMLControls.DrawTextBox("txtRTFilterTo", "txtRTFilterTo", "form-control clsDateColor",,,,,, False, False,, False, "autocomplete = 'off'",,, ,,,,) %>
                        <span class="input-group-btn">
                            <button class="btn btncalendar" type="button" style="height: 35px; margin-top: -7px;margin-left:-13px"><i class="fas fa-calendar-alt"></i></button>
                        </span>
                    </div>
                </div>
                <div class="form-group">
                    <div class="text-center" style="margin-left: 20px;">
                        <button class="btn btnyellow" onclick="GetResourceTimeSheet();">Apply</button>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>

        <div class="clearfix"></div>
        <div class="content pt-0">
            <div class="resourcelist-wrapper">
                <table id="IDrsrsRTSRRprtTbl" class="table table-bordered rsrslistRprtTbl" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>Organization Unit</th>
                            <th>Employee Name</th>
                            <th>Reporting To</th>
                            <th>Max Work (Availability)</th>
                            <th>Recorded Hours</th>
                            <th>Unrecorded Hours</th>
                        </tr>
                    </thead>
                    <tbody id="tblResourceTS">
                        <%--<tr>
                            <td colspan="6">Please select filter and click on apply</td>
                        </tr>--%>
                    </tbody>
                </table>
                <div class="clearfix"></div>
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
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" name=""><br />
                                            <div class="btnrow">
                                                <button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>
                                                <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right">Cancel</button>
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
    <!-- REQUIRED JS SCRIPTS -->
  <%--  <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>


    <script>        
        var NoDataFound = "No data found.";
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var TagID = '<%= m_TagId%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var strUrl = '';
        var ResourceTSTable;
        var noOfRowsPerPage = 10;
        $(document).ready(function () {
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (blnViewAccess == "True") {

            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
            GetMaximumItemsToShowInList();
            //Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
                    BindPlaceholder("txtRTFilterLocationID", "Organization Unit");     
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

        //let tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"))
        //var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        //    return new bootstrap.Tooltip(tooltipTriggerEl, {
        //        container: 'body',
        //        trigger: 'hover'
        //    });
        //});//commented by pradip on 10-4-2023

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
        $('#txtRTFilterFrom, #txtRTFilterTo').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd M yy'
        });

        //datatable
        $('#IDrsrsRTSRRprtTbl').dataTable({
            "sScrollY": "400px",
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
        $('.modal').on('show.bs.modal', function () {
            $(".table").resize();

        });
        var validateflag;
        function checkValidationForExport() {
            var from = $("#txtRTFilterFrom").val() == "" ? null : new Date($("#txtRTFilterFrom").val());
            var to = $("#txtRTFilterTo").val() == "" ? null : new Date($("#txtRTFilterTo").val());

            if (from == null || from == 'undefined' || from == "Invalid Date") {
                $("#txtRTFilterFrom").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select From Date.");//Added Rutuja on 3 July 2021 Space In Bertween FromDate
                return false;
            }
            else if (to == null || to == 'undefined' || to == "Invalid Date") {
                $("#txtRTFilterTo").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select To Date.");//Added Rutuja on 3 July 2021 Space In Bertween ToDate
                return false;
            }
            else if (from > to) {
                $("#txtRTFilterFrom").focus();
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
        function ExportResourceTimeSheetReport(filterParams) {
            checkValidationForExport();
            if (validateflag == true) {
                var filterParams1 =
                    {
                        LocationID: "",
                        StartDate: "",
                        EndDate: "",
                        intUserID: "",
                        ReportFormat: ""
                    }

                var OUid = $('#txtRTFilterLocationID').val();
                var from = $('#txtRTFilterFrom').val();
                var to = $('#txtRTFilterTo').val();
                var ReportsTab = $('#RLonchangeBy').val();

                filterParams1.ReportFormat = filterParams;
                filterParams1.ReportTab = ReportsTab;
                filterParams1.intUserID = SessionEmployeeId;
                filterParams1.StartDate = from;
                filterParams1.EndDate = to;
                //Added by imran on 22-08-2022
                if (OUid == "") {
                    filterParams1.LocationID = 0;
                }
                else {
                    filterParams1.LocationID = OUid;
                }
                //End of comment by imran on 22-08-2022

                //StartLoader("#body-ResourceList");
                $.ajax({
                    url: strUrl + '/api/RR_TimeSheetStorage/ExportDocument',
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
                        // StopAjaxLoader("#body-ResourceList");
                    },
                    //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    // StopAjaxLoader("#body-ResourceList");
                    //}
                     error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyInfraStatus");
                    }
                     //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                })
            } else {
                return false;
            }
        }

        function GetResourceTimeSheet()
        {
            var strHTML = "";
            checkValidationForExport();
            if (validateflag == true) {
                var filterParams1 =
                    {
                        LocationID: "",
                        StartDate: "",
                        EndDate: "",
                        intUserID: ""
                    }

                var OUid = $('#txtRTFilterLocationID').val();
                var from = $('#txtRTFilterFrom').val();
                var to = $('#txtRTFilterTo').val();
                var ReportsTab = $('#RLonchangeBy').val();

                // filterParams1.ReportFormat = filterParams;
                filterParams1.ReportTab = ReportsTab;
                filterParams1.intUserID = SessionEmployeeId;
                filterParams1.StartDate = from;
                filterParams1.EndDate = to;
                //Added by imran on 22-08-2022
                if (OUid == "") {
                    filterParams1.LocationID = 0;
                }
                else {
                    filterParams1.LocationID = OUid;
                }
                //End of comment by imran on 22-08-2022
                
                $.ajax({
                    url: strUrl + '/api/RR_TimeSheetStorage/GetByTimeSheetStorage',
                    type: "POST",
                    data: JSON.stringify(filterParams1),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (filterParams1) {
                            xhr.setRequestHeader("Params", encryptString(isJson(filterParams1) ? filterParams1 : JSON.stringify(filterParams1)));
                        }
                    },
                    success: function (data)
                    {
                        //Added by imran on 08-10-2021 to Addd Datatable Paggination
                        $("#IDrsrsRTSRRprtTbl").dataTable().fnDestroy();
                        $("#tblResourceTS").html("");
                        //End By imran 08-10-2021

                        var List = data;
                        if (List.length > 0)
                        {
                            $.each(List, function (index, obj)
                            {
                                //strHTML += '<tr class="graybglight pgrow"><td colspan="6" class="text-left">' + obj.OrganizationUnit + '</td></tr>'
                                strHTML += '<tr class="graybglight pgrow">';
                                strHTML += '<td>' + obj.OrganizationUnit + '</td>';
                                strHTML += '<td></td>';
                                strHTML += '<td></td>';
                                strHTML += '<td></td>';
                                strHTML += '<td></td>';
                                strHTML += '<td></td>';
                                strHTML += '</tr>';
                                $.each(obj.lstTSReport, function (index, objrep)
                                {
                                    //commented and added by imran on 29-12-2021 to show only 2 decimal values
                                    if (objrep.ReportingTo == null || objrep.ReportingTo == "") {
                                        objrep.ReportingTo = '';
                                    }
                                    strHTML += '<tr class="pgrow"><td class="text-left">&nbsp;</td><td class="text-center">' + objrep.EmployeeName + '</td><td class="text-center">' + objrep.ReportingTo + '</td><td class="text-center">' + objrep.MaxWorkAvailability + '</td><td class="text-center"> ' + objrep.RecordedHours + '</td><td class="text-center">' + objrep.UnrecordedHours + '</td></tr>';
                                    //strHTML += '<tr class="pgrow"><td class="text-left">&nbsp;</td><td class="text-center">' + objrep.EmployeeName + '</td><td class="text-center">' + objrep.ReportingTo + '</td><td class="text-center">' + objrep.MaxWorkAvailability + '</td><td class="text-center">' + ParseFloat(objrep.RecordedHours, 2) + '</td><td class="text-center">' + ParseFloat(objrep.UnrecordedHours, 2) + '</td></tr>';
                                    //End comment by imran on 29-12-2021
                                });
                            });
                        }
                        else {
                            //Comment by imran 08-10-2021
                            //strHTML = '<tr><td class="text-center"colspan="6">' + NoDataFound + ' </td></tr>';
                            //End by imran 08-10-2021
                        }

                        //Commented by imran 08-10-2021
                            //$('#IDrsrsRTSRRprtTbl').dataTable().fnDestroy();
                            //$("#tblResourceTS").html(strHTML);
                            //LoadPagination(data);
                        //End Comment 08-10-2021

                        //Added by imran 08-10-2021
                         $("#tblResourceTS").html("");
                         $("#tblResourceTS").append(strHTML);                    
                         $('#IDrsrsRTSRRprtTbl').dataTable({  
                           "sScrollY": "400px",
                           "scrollX": true,
                           "paging": true,
                           "pageLength":10,
                           "bLengthChange": false,
                           "bFilter": false,
                           "ordering": false,
                           "responsive": true,
                           "destroy": false,
                           "retrieve": true,
                           "bFilter": false,
                           "ordering": false,
                           "info": false,
                            "autowidth": false 
                        });     
                        //End by imran 08-10-2021
                       
                        //StopAjaxLoader("#body-ResourceAllocation");

                    },
                    //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    //StopAjaxLoader("#body-ResourceAllocation");
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
                return false;
            }

        }
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            ResourceTSTable = $('#IDrsrsRTSRRprtTbl').dataTable({
                //"dtat": data,
                "data": data,
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
        ////dynamically set height
        function resizeSection(tag) {
            var JStableOuter = $(window).height();
            $('.resourcelist-wrapper').css({ 'height': JStableOuter - 160, "overflow-y": "auto" });


        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        //Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }
        //End of Added By Chetan M. For Bind Filter Placeholder on 15 July 2021

        //Added by imran on 29-12-2021
        function ParseFloat(str, val) {
            str = str.toString();
            str = str.slice(0, (str.indexOf(".")) + val + 1);
            return Number(str);
        }
        //End Of Comment by imran on 29-12-2021
    </script>

</body>

</html>
