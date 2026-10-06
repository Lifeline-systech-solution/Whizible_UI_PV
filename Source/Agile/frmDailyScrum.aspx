<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmDailyScrum.aspx.vb" Inherits="Whizible.frmDailyScrum" %>

<!DOCTYPE html>

<html>
         <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">
   <%-- <title></title>
    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link href="../../Whizible2.0-new/fontawesome/css/all.css" rel="stylesheet" />
    <link href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <link href="../../Whizible2.0-new/dist/css/editor.css" rel="stylesheet" />
 <%--   <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>
    <link href="css/DailyScrum.css?v=1.13" rel="stylesheet" />
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/updated_versions.css" />

 <%--   <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <script src="js/autosize.js"></script>
<%--    <script src="../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>
    <script src="js/CommonJS.js"></script> 
    <%--<script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
    <script src="../../Whizible2.0-new/dist/js/editor.js"></script>
<%--    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../Whizible2.0-new/dist/js/timepicker.min.js"></script>
<%--    <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>


</head>
        <style>
       /* Modified By Madhuri.K On 03-04-2026 */
       body, .btn{font-size:11.5px}
        .fa.fa-search{height:33px}
             /* Modified By Madhuri.K On 03-04-2026 */
        #filterDropdown{font-size:11.5px!important}
        #tblweekdates th{text-align:center}
        a{text-decoration:none}
        #UlFilter{overflow:auto}
        .selecteddate {background-color: #428bca!important;}

        .modal-content {
            height:500px!important;
            overflow:auto;
        }
        
        #divDSbody,#divImpedimentbody{
            
            overflow:auto!important;
        }

        #emplistUL {
            float: right;
            width: 29px;
            left: 0px !important;
            height: 200px;
            overflow: auto;
        }
        /* Added By Gauri On 03rd Sep 2024 For Alignment Issue */
        #tblweekdates tbody tr td a{
            font-weight: 600;
            font-size: 11.5px;
            /* Modified By Madhuri.K On 26-03-2026 */
        }
        @media only screen and (min-width: 992px) and (max-width: 1240px){
            #txtSearchDailyScrum{
                margin-top: 0;
            }
        }
        /* End of Added By Gauri On 03rd Sep 2024 For Alignment Issue */

        body{
            background-color: #fff;
        }
        .close {
                  /* Modified By Madhuri.K On 03-04-2026 */
            font-size: 18px;
        }

        /* Added By Gauri On 09th Sep 2024 For Datepicker Alignment Issue */
        .ui-datepicker .ui-datepicker-prev, .ui-datepicker .ui-datepicker-next,
        .ui-datepicker .ui-datepicker-prev:hover, .ui-datepicker .ui-datepicker-next:hover {
            top: unset;
            bottom: 5px;
        }
        .ui-datepicker table {
            border-collapse: separate;
        }
        .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover, html .ui-button.ui-state-disabled:active {
            border: 1px solid rgb(197, 197, 197) !important;
            background: rgb(246, 246, 246);
            font-weight: normal;
            color: rgb(69, 69, 69);
        }
        .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
            border: 1px solid rgb(0, 62, 255);
            background: rgb(0, 127, 255) !important;
            color: rgb(255, 255, 255);
        }
        .ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight {
            border: 1px solid #dad55e !important;
            background: #fffa90 !important;
            color: #777620 !important;
        }
        /* End of Added By Gauri On 09th Sep 2024 For Datepicker Alignment Issue */
    </style>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="divMain">

                <% WritePage()%>
            </div>

        </div>
        <%-- Modal Daily Scrum --%>
        <div class="modal fade" id="divAddDS" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="DSmodalcontent">
                    <div class="modal-header" id="SectionHeader">
                        <div class="col-sm-11">
                                  <!-- /* Modified By Madhuri.K On 03-04-2026 */ -->
                            <h5 class="modal-title" style="font-size: 14px; font-weight: 500; color: grey; margin-left: 7px;" id="headerUS">Daily Scrum</h5>
                        </div>
                        <div class="col-sm-1">

                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" data-toggle='tooltip' data-bs-placement="bottom" title='Close' style="margin-top: 4px!important; outline: none;">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                    </div>
                    <div class="modal-body" id="divDSbody" style="overflow: hidden;">
                    </div>
                    <div class="modal-footer">
                        <% If m_objAccess.Add Then%>
                        <button type="button" class="btn btn-info" onclick="SaveNew_DailyScrum(0)" id="SaveDS">Save</button>
                        <button type="button" class="btn btn-info" onclick="SaveNew_DailyScrum(1)" id="SaveAndAddDS">Save & Add</button>
                        <% End If%>
                        <% If m_objAccess.Edit Then%>
                        <button type="button" class="btn btn-info" style='display: none' onclick="SaveNew_DailyScrum(0)" id="UpdateDS">Update</button>
                        <% End If%>
                        <button type="button" class="btn btn-info" data-bs-dismiss="modal" id="btnClose" data-toggle='tooltip' data-bs-placement="bottom" title='Close'>Close</button>

                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade bd-example-modal-lg" id="divAddImpediment" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="col-sm-11">
                            <!-- /* Modified By Madhuri.K On 03-04-2026 */ -->
                            <h5 class="modal-title" id="exampleModalLabel" style="font-size: 14px; font-weight: 500; color: grey; margin-left: 7px;">Impediment</h5>
                        </div>
                        <div class="col-sm-1">
                            <button type="button" class="close" data-bs-dismiss="modal" data-toggle='tooltip' data-bs-placement="bottom" title='Close' aria-label="Close" style="margin-top: 4px!important; outline: none;">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </div>
                    <div class="modal-body" id="divImpedimentbody" style="overflow: hidden;">
                    </div>
                    <div class="modal-footer">
                        <% If m_objAccessImpediment.Add Then%>
                        <%--                        <button type="button" class="btn btn-info" style="width: 12%;" onclick="Save_Impediment()">Save</button>--%>
                        <button type="button" class="btn btn-info" style="width: 12%;" onclick="Save_Impediment(0)" id="btnSaveImpediment">Save</button>
                        <button type="button" class="btn btn-info" style="width: 12%;" onclick="Save_Impediment(1)" id="btnSaveAndAddImpediment">Save & Add</button>
                        <% End If%>
                        <button type="button" class="btn btn-info" style="background-color: #428bca; border-color: #428bca; outline: none;" data-bs-dismiss="modal" aria-label="Close">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- Show History Pop up --%>
        <div class="modal fade" id="DivShowhistory" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="col-sm-4">
                            <h5 class="modal-title" style="color: maroon;" id="">Show History</h5>
                        </div>
                        <div class="col-sm-7">
                            <%--<input type='text' name='table_search' id='txtSearchHistory' class='txtBox form-control float-end' placeholder='Search' />--%><%--<i class="fa fa-search Release" aria-hidden="true"></i>--%>
                            <%-- <div class='input-group input-group-sm' style='width: 50%;margin-left: 56%;'>  
                                <div class='input-group-btn'>
                                    <button type='button' class='btn btn-default' onclick='PerformSearchForPTI()'><i class='fa fa-search'></i></button>
                                </div>
                                
                                <input type='search' name='table_search' id='txtSearchHistory' class='txtBox form-control float-end searchboxHeight' value='' onkeyup='PerformSearchForPTI()' placeholder='Search' />
                            </div>--%>


                            <div class='input-group input-Group -sm ' style='width: 50%; margin-left: 50%;'>
                                <div class='input-group-btn'>
                                    <input type='search' name='table_search' id='txtSearchHistory' class='txtBox form-control float-end searchboxHeight' value='' onclick="PerformSearchForPTI('Event')" placeholder='Search' style='border-top: none!important; border-left: none!important; border-right: none!important; width: 140px; /* width: 72%!important; */' />
                                </div>
                                <i class='fa fa-search' style='border-bottom-color: none; margin-left: 10px; /* z-index: 99; */margin-top: 10px;'></i>
                            </div>

                        </div>
                        <div class="col-sm-1">
                            <button type="button" class="close" data-toggle='tooltip' data-bs-placement="bottom" data-bs-dismiss="modal" aria-label="Close" title="Close " style="outline: none;">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </div>
                    <div class="modal-body" id="GetShowhistory" style="margin-top: -2%">
                    </div>

                </div>
            </div>
        </div>
        <%-- End of show History pop up --%>
    </form>
    <script>
        var divGridHeight;
        var dtHeight;
        var dtDataTableHeight;

        var today = new Date();
        date = today.getDate();
        month = today.getMonth();
        year = today.getFullYear();
        month = month + 1;
        var GlobalMeetingID = "";
        var strGlobaFilterField = "";
        var strGlobalFilterValue = "";

        $(function () {


            var dateToday = new Date();
            //$('#DSTargetDate').datepicker();
            //$('#dtPlannedIssueDate').datepicker(
            //    {
            //        startDate: new Date()
            //    });
            //$('#dtRaisedDate').datepicker();
            //$('#dtActualIssueDate').datepicker();


            $('#DSTargetDate').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                   // yearRange: '2000:2030'
                }

            );
            $('#dtPlannedIssueDate').datepicker(
                {
                    startDate: new Date(),
                    changeMonth: true,
                    changeYear: true,
                   // yearRange: '2000:2030'


                });
            $('#dtRaisedDate').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //yearRange: '2000:2030'
                }

            );
            $('#dtActualIssueDate').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                   // yearRange: '2000:2030'
                }

            );
            $('#DSTargetDate,#dtPlannedIssueDate,#dtRaisedDate,#dtActualIssueDate').prop('readonly', true);
        });

        $("#Prev").click(function () {

            var strUserResult = ajaxCall("frmDailyScrum.aspx/GetWeekDates", "POST", "application/json", "json", JSON.stringify({ strFlag: 'Prev' }));
            if (strUserResult.d != "") {

                $("#weekdates").html("");
                $("#weekdates").html(strUserResult.d);
            }
        });


        $("#Next").click(function () {
            var strCurrentDate;

            var strUserResult = ajaxCall("frmDailyScrum.aspx/GetWeekDates", "POST", "application/json", "json", JSON.stringify({ strFlag: 'Next' }));

            if (strUserResult.d != "") {
                //var strResult = strUserResult.d.Split("$$");
                $("#weekdates").html("");
                $("#weekdates").html(strUserResult.d);
            }
        });

        //Added by Usha Pandit on 19 April 2018 for clicking Prev - Next Button on keyboard up down click
        $(document.documentElement).keyup(function (e) {
            if (e.keyCode == 38) {
                var strUserResult = ajaxCall("frmDailyScrum.aspx/GetWeekDates", "POST", "application/json", "json", JSON.stringify({ strFlag: 'Prev' }));
                if (strUserResult.d != "") {

                    $("#weekdates").html("");
                    $("#weekdates").html(strUserResult.d);

                }
            }

            if (e.keyCode == 40) {
                var strUserResult = ajaxCall("frmDailyScrum.aspx/GetWeekDates", "POST", "application/json", "json", JSON.stringify({ strFlag: 'Next' }));

                if (strUserResult.d != "") {
                    //var strResult = strUserResult.d.Split("$$");
                    $("#weekdates").html("");
                    $("#weekdates").html(strUserResult.d);

                }
            }
        });
        //End of Added by Usha Pandit on 19 April 2018 for clicking Prev - Next Button on keyboard up down click

        function GetSelectedSprint() {

        }

        //Added by Usha Pandit on 21 April 2018 for Export Functionality
        var curWhereFlag = '';
        var curWhereValue = '';
        var curWhereDate = '';
        function Excel_OnClick(format) {

            var objform;
            //var format = 'EXCEL';

            format = format.toUpperCase();
            var strExportResult = ajaxCall("frmDailyScrum.aspx/ExportToExcel", "POST", "application/json", "json", JSON.stringify({ ReportFormat: format, WhereFlag: curWhereFlag, WhereValue: curWhereValue, WhereDate: curWhereDate }));

            if (strExportResult.d != "") {
                //alert(strExportResult.d);
            }

            //Added By Bharat Tekade on 7th-Jun-2016 for show data in excel from grid 
            var objStatus, objHRM;
            //var strHiringMgr, strStatus, intCustomer, intSkill, intBG, strStaffingStatus, strURL;

            window.open("../CRW/CRW_ReportOutput.aspx?filename=" + strExportResult.d, "_report", "");
            //End of Commented and Added By Bharat Tekade on 28th-Sep-2016for show data in excel from grid 
        }
        //End of Added by Usha Pandit on 21 April 2018 for Export Functionality

        function SetWidthHeight() {
            var dtTopHeightPadding;
            var dtHeaderFreezeHeight;

            dtHeaderFreezeHeight = $(".HeaderFreeze").innerHeight();
            if (isIE() == "IE") {
                $("#divMain").css("height", (window.innerHeight - 20) + 'px');
                $("#divrow").css("height", (window.innerHeight - dtHeaderFreezeHeight - 20) + 'px');
                dtHeight = (window.innerHeight - dtHeaderFreezeHeight - 20);
                dtDataTableHeight = (window.innerHeight - dtHeaderFreezeHeight - 110);
            }
            else {
                $("#divMain").css("height", (window.innerHeight - 20) + 'px');
                $("#divrow").css("height", (window.innerHeight - 20 - dtHeaderFreezeHeight) + 'px');
                dtHeight = (window.innerHeight - dtHeaderFreezeHeight - 20);
                dtDataTableHeight = (window.innerHeight - dtHeaderFreezeHeight - 100);
            }


            dtTopHeightPadding = dtHeight / 4;

            $("#divweekdates").css("height", dtHeight);
            $("#tblweekdates").css("height", dtHeight / 2);
            $("#divweekdates").css("padding-top", dtTopHeightPadding - dtHeaderFreezeHeight);

        }
        $(window).resize(function () {
            SetWidthHeight()
        })
        $(document).ready(function () {
            // Added By Gauri On 09th Sep 2024 For Tooltip Issue
            const filTooltip = document.getElementById('filterDropdown')
            const tooltip = bootstrap.Tooltip.getOrCreateInstance(filTooltip)
            tooltip.hide();
            // End of Added By Gauri On 09th Sep 2024 For Tooltip Issue

            //$('[data-toggle="tooltip"]').tooltip();
            //Added By Dipali V On 24th March 2023 For Datatable Issue
            if ($("#FilterDailyScurmList").val() > 0) {
               // datatables('DivDailyScurmList', 'txtSearchDailyScrum', '');
                datatables('DivDailyScurmList', 'txtSearchDailyScrum', '');
            }
            //End of Added By Dipali V On 24th March 2023 For Datatable Issue
            $('.my-dropdown').dropdown();
            $('.my-dropdown').tooltip();

            $('.dropdown-menu').on('click', function (e) {
                e.stopPropagation();
            });

            $(".scrum_date").click(function () {

                $(".scrum_date").removeClass("selecteddate")

                $(this).addClass("selecteddate")
                $("#filterDropdown").tooltip();

            })
            $("#txtAssignedTo").focus(function () {
                $("#emplistUL").css("display", "block");
            })

            $('#txtSearchDailyScrum').keypress('click', function (e) {


                if (e.keyCode == 13) {
                    return false;
                }



            });


            // $("#ExcelFilter").css("display", "");
        });

        //$("#filterExport").click(function () {
        //    $(".dropdown-menu").css("display", "block");
        //});
        function datatables(divID, txtBoxID, height) {

            var pageLength = 10;

            if (divID == "DivGridShowHistory") {
                pageLength = 3;
            }

            dtDataTableHeight = window.innerHeight - 200;


            SetWidthHeight();

            var ordering = false;

            if (divID == "DivDailyScurmList") {
                if ($('#' + divID + ' tbody > tr > td').text() == "No item is created for this day.") {
                    ordering = false;
                }
                else {
                    ordering = true;
                }
            }
            else if (divID == "DivGridShowHistory") {
                if ($('#' + divID + ' tbody > tr > td').text() == "There are no items to show in this view.") {
                    ordering = false;
                }
                else {
                    ordering = true;
                }
            }

            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' table').addClass("table table-bordered table-stripped");

            if (divID == "DivGridShowHistory") {
                var table = $('#' + divID + ' > table').DataTable({
                    responsive: true,
                    "pageLength": pageLength,
                    scrollY: '275px',
                    pagingType: "numbers",
                    sorting: true,
                    scrollX: true,
                    //Tooltip:true,
                    "drawCallback": function (settings) {
                        if (divID == "DivGridShowHistory") {
                            $('.tt_large').tooltip({
                                template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
                            });


                            $('[data-toggle="tooltip"]').tooltip();
                        }
                        if (divID == "DivDailyScurmList") {
                            $('.mydetaildropdown').dropdown();
                            $('.mydetaildropdown').tooltip();

                            $('.tt_large').tooltip({
                                template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
                            });
                            $('[data-toggle="tooltip"]').tooltip();
                        }

                    },

                });
            }
            else {
                var table = $('#' + divID + ' > table').DataTable({
                    responsive: true,
                    "pageLength": 7,
                    //scrollY: divGridHeight+'px',
                    pagingType: "numbers",
                    sorting: true,
                    scrollX: true,
                    //Tooltip:true,
                    scrollY: dtDataTableHeight + 'px',
                    "drawCallback": function (settings) {

                        if (divID == "DivDailyScurmList") {
                            $('.mydetaildropdown').dropdown();
                            $('.mydetaildropdown').tooltip();

                            $('.tt_large').tooltip({
                                template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
                            });
                            $('[data-toggle="tooltip"]').tooltip();
                        }

                    },

                });
            }


            if (txtBoxID != "") {
                $('#' + txtBoxID).on('keyup change', function (e) {

                    table.search($(this).val()).draw();
                });
            }

            if (ordering == false) {
                $("#" + divID).find(".dataTables_info").html("Showing 0 to 0 of 0 entries ");
            }

            if (divID == "DivDailyScurmList") {
                $('.mydetaildropdown').dropdown();
                $('.mydetaildropdown').tooltip();
            }
            $('.tt_large').tooltip({
                template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
            });

        }

        function checkDelayStatus() {
            var d1 = new Date($("#DSTargetDate").val());
            var oldDate = new Date();
            var d2 = new Date(oldDate.toDateString());


            if (d1 < d2 || $("#DSTargetDate").val() == "") {
                if ($('#IsConvertedToImpediment').is(":checked") && $('#IsConvertedToImpediment').is(':disabled') == false) {
                    alertify.dismissAll();
                    alertify.set('notifier', 'position', 'top-right');
                    var errorMsg = "<li>" + '- DSM can not be converted to impediment. Please change target date' + "</li></br>";
                    alertify.notify("<ul>" + errorMsg + "</ul>", 'error', 10);
                    $('#IsConvertedToImpediment').prop('checked', false);
                }
            }

            //if (curStatus == "Delayed") {
            //    if ($('#IsConvertedToImpediment').is(":checked")) {
            //        alertify.dismissAll();
            //        alertify.set('notifier', 'position', 'top-right');
            //        alertify.notify('DSM can not be converted to impediment. Please change target date', 'error', 10);
            //        $('#IsConvertedToImpediment').prop('checked', false);
            //    }
            //}
        }
        //function AutoResizeTextArea() {
        //    jQuery.each(jQuery('textarea[data-autoresize]'), function () {
        //        var offset = this.offsetHeight - this.clientHeight;

        //        var resizeTextarea = function (el) {
        //            jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
        //        };
        //        jQuery(this).on('keyup input', function () {

        //            if ($(this).attr("id") == "txtImpedimentDescription") {
        //                Maxlength(this, "ImpedimentDescription", 500);
        //            }

        //            if ($(this).attr("id") == "txtActionItems") {
        //                Maxlength(this, "ActionItems", 1000);
        //            }

        //            if ($(this).attr("id") == "txtRemark") {
        //                Maxlength(this, "DSRemark", 1000);
        //            }

        //            if ($(this).attr("id") == "txtCorrectiveAction") {
        //                Maxlength(this, "CorrectiveAction", 1000);
        //            }
        //            if ($(this).attr("id") == "txtPreventiveAction") {
        //                Maxlength(this, "PreventiveAction", 1000);
        //            }

        //            resizeTextarea(this);
        //        }).removeAttr('data-autoresize');
        //    });
        //}
        var isdelayedstatus = '';
        var ismeetingidexists = '';
        function checkBlankTargetDate(DSTargetDate) {
            try {
                if (DSTargetDate == "") {
                    $('#DSStatus').find('option').remove().end();
                    var objCbo = document.getElementById("DSStatus");
                    var objOption = document.createElement("OPTION");
                    objCbo.options.add(objOption);
                    objOption.text = "Info";
                    objOption.value = "Info";

                    $("#DSStatus").prop('disabled', true);
                    $("#DSStatus").addClass("clsDisableColor");
                }
                else {
                    $('#DSStatus').find('option').remove().end();
                    var objCbo = document.getElementById("DSStatus");

                    if (isdelayedstatus == "Delayed") {
                        var objOption1 = document.createElement("OPTION");
                        objCbo.options.add(objOption1);
                        //objOption1.text = "Delayed";
                        //objOption1.value = "Delayed";
                        objOption1.text = "Open";
                        objOption1.value = "Open";
                        var objOption2 = document.createElement("OPTION");
                        objCbo.options.add(objOption2);
                        objOption2.text = "Differed";
                        objOption2.value = "Differed";

                        var objOption3 = document.createElement("OPTION");
                        objCbo.options.add(objOption3);
                        objOption3.text = "Rejected";
                        objOption3.value = "Rejected";

                        var objOption4 = document.createElement("OPTION");
                        objCbo.options.add(objOption4);
                        objOption4.text = "Closed";
                        objOption4.value = "Closed";
                    }
                    else {
                        var objOption1 = document.createElement("OPTION");
                        objCbo.options.add(objOption1);
                        objOption1.text = "Open";
                        objOption1.value = "Open";

                        //Commented by Usha Pandit on 05 Jun 2018 for showing differed and rejected status only in edit mode
                        //var objOption2 = document.createElement("OPTION");
                        //objCbo.options.add(objOption2);
                        //objOption2.text = "Differed";
                        //objOption2.value = "Differed";

                        //var objOption3 = document.createElement("OPTION");
                        //objCbo.options.add(objOption3);
                        //objOption3.text = "Rejected";
                        //objOption3.value = "Rejected";
                        //End of Commented by Usha Pandit on 05 Jun 2018 for showing differed and rejected status only in edit mode

                        if (ismeetingidexists != "") {


                            //Added by Usha Pandit on 05 Jun 2018 for showing differed and rejected status only in edit mode
                            var objOption2 = document.createElement("OPTION");
                            objCbo.options.add(objOption2);
                            objOption2.text = "Differed";
                            objOption2.value = "Differed";

                            var objOption3 = document.createElement("OPTION");
                            objCbo.options.add(objOption3);
                            objOption3.text = "Rejected";
                            objOption3.value = "Rejected";
                            //End of Added by Usha Pandit on 05 Jun 2018 for showing differed and rejected status only in edit mode

                            var objOption4 = document.createElement("OPTION");
                            objCbo.options.add(objOption4);
                            objOption4.text = "Closed";
                            objOption4.value = "Closed";
                        }
                    }
                    $("#DSStatus").prop('disabled', false);
                    $("#DSStatus").removeClass("clsDisableColor");
                }

                if (ismeetingidexists != "") {
                    checkDelayStatus();
                }
            }
            catch (ex) {
                alert(ex.message);
            }
        }
        function ShowModal_DS(id, obj, MeetingNo, impedstatus) {
        
            if (id == 'divAddImpediment') {
                $("#divDSbody").html('');


                var strUserResult = ajaxCall("frmDailyScrum.aspx/AddImpedimentModal", "POST", "application/json", "json", JSON.stringify({}));

                $("#divImpedimentbody").html(strUserResult.d);
                //AutoResizeTextArea();
                //autosize(document.querySelectorAll('textarea'));
                $("#impedimentStatus").prop("disabled", true);
                $("#impedimentStatus").prop("disabled", true);      //Added by Usha Pandit on 21 Apr 2018 for keeping Open status default
                $("#impedimentStatus").addClass("clsDisableColor");
                $("#divAddImpediment").modal('show');
                getcols();
                RemoveTextArea();
                AutoResizeTextArea();
                $('#dtPlannedIssueDate').datepicker(
                    {
                        changeMonth: true,
                        changeYear: true,
                       // yearRange: '2000:2030'
                    }
                );
                $('#dtPlannedIssueDate').prop('readonly', true);
                //AutoResizeTextArea();
                //removeWhitespaces();
                //getRows();
                //RemoveTextArea();
                //autosize(document.querySelectorAll('textarea'));
            }
            else if (id == 'divAddDS') {

                try {
                    $("#divImpedimentbody").html('');
                    GlobalMeetingID = MeetingNo;
                    var strUserResult = ajaxCall("frmDailyScrum.aspx/AddDailyScrumModal", "POST", "application/json", "json", JSON.stringify({ MeetingNo: MeetingNo }));
                    $("#divDSbody").html(strUserResult.d);
                    AutoResizeTextArea();
                    //autosize(document.querySelectorAll('textarea'));
                    if (MeetingNo != "") {
                        ismeetingidexists = MeetingNo
                    }
                    else {
                        ismeetingidexists = ""
                    }
                    var DSTargetDate = $("#DSTargetDate").val();
                    checkBlankTargetDate(DSTargetDate);

                    if (impedstatus == "Delayed") {
                        isdelayedstatus = "Delayed";
                        $('#DSStatus').find('option').remove().end();
                        var objCbo = document.getElementById("DSStatus");
                        var objOption1 = document.createElement("OPTION");
                        objCbo.options.add(objOption1);
                        //objOption1.text = "Delayed";
                        //objOption1.value = "Delayed";
                        objOption1.text = "Open";
                        objOption1.value = "Open";
                        var objOption2 = document.createElement("OPTION");
                        objCbo.options.add(objOption2);
                        objOption2.text = "Differed";
                        objOption2.value = "Differed";

                        var objOption3 = document.createElement("OPTION");
                        objCbo.options.add(objOption3);
                        objOption3.text = "Closed";
                        objOption3.value = "Closed";

                        var objOption4 = document.createElement("OPTION");
                        objCbo.options.add(objOption4);
                        objOption4.text = "Rejected";
                        objOption4.value = "Rejected";


                    }
                    else {
                        isdelayedstatus = "";
                    }


                    if (MeetingNo != "") {
                        $("#DSStatus").val(impedstatus);
                    }

                    if (impedstatus == "Delayed") {
                        $("#DSStatus").val("Open");
                    }
                    if (impedstatus == "Differed") {
                        $("#DSStatus").val("Differed");
                    }
                    if (impedstatus == "Rejected") {
                        $("#DSStatus").val("Rejected");
                    }
                    if (impedstatus == "Open") {
                        $("#DSStatus").val("Open");
                    }

                    $("#divAddDS").modal('show');
                    getRows();
                    AutoResizeTextArea();
                    RemoveTextArea();
                    //AutoResizeTextArea();
                    //removeWhitespaces();
                    if (MeetingNo != "") {
                        $('#SaveAndAddDS').css("display", "none");
                        $('#SaveDS').css("display", "none");

                        if ($("#DSStatus").val() != null) {
                            if ($("#DSStatus").val().toUpperCase() == "CLOSED") {
                                $('#UpdateDS').css("display", "none");
                            }
                            else {
                                $('#UpdateDS').css("display", "inline-block");
                            }
                        }

                    }
                    else {
                        $('#SaveAndAddDS').css("display", "inline-block");
                        $('#SaveDS').css("display", "inline-block");

                        $('#UpdateDS').css("display", "none");
                    }
                    //$("#txtAssignedTo").focus(function () {
                    //    //$("#emplistUL").css("display", "block");
                    //    //alert();
                    //    $(this).trigger("click");
                    //});
                    //$("#txtAssignedTo").focusout(function () {
                    //    $("#emplistUL").css("display", "none");
                    //});

                    //$(this).trigger("click");
                }
                catch (ex) {
                    alert(ex.message);
                }

                $('#DSTargetDate,#DSActualStartDateDate').datepicker(
                    {
                        changeMonth: true,
                        changeYear: true,
                       // yearRange: '2000:2030'
                    }
                );
            }

        }
        function ajaxCall(url, type, contentType, dataType, data) {
            var ajaxResult;
            $.ajax({
                url: url,
                type: type,
                contentType: contentType,
                dataType: dataType,
                data: data,
                async: false,
                success: function (result) {
                    ajaxResult = result;
                },
                error: function (xhr) {
                    console.log(xhr);
                }
            })

            return ajaxResult;
        }
        function AssignToListClick(object) {
            $("#txtAssignedTo").val(object.name);
            $("#hdnAssignToId").val(object.id);
            $("#emplistUL").css("display", "none");
        }
        function myFunction() {
            var input, filter, ul, li, a, i;
            $("#emplistUL").css("display", "block");
            input = document.getElementById("txtAssignedTo");
            filter = input.value.toUpperCase();
            ul = document.getElementById("emplistUL");
            li = document.getElementsByClassName("clsAssignedListItem");
            for (i = 0; i < li.length; i++) {
                a = li[i].innerText;
                if (a.toUpperCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                } else {
                    li[i].style.display = "none";

                }
            }
        }

        function getSprintDates() {
        }

        //Added by Usha Pandit on 29 Apr 2019 for windowWidth undefined javascript
        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function validatedatatype(e, fieldname) {

            var keyCode = e.which ? e.which : e.keyCode
            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    alertify.dismissAll();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- Please enter only positive numeric value for ' + fieldname + ' .', 'error');
                }
            }

            return ret;
        }
         //End of Added by Usha Pandit on 29 Apr 2019 for windowWidth undefined javascript

        function SaveNew_DailyScrum(flagMode) {

            var objActionItems;
            var objSprint;
            var objTargetdate;
            var objAssignedTo;
            var objStatus;
            var objActualdate;
            var objRemark;
            var objIsConvertedToImpediment;
            var IsConvertedToImpediment;

            var Flag = 0;
            var checkvalue = 0;
            var strmsg = "";
            var errorMsg = "";
            var isValidAssinedTo = 0;

            objActionItems = document.getElementById("txtActionItems");
            objTargetdate = document.getElementById("DSTargetDate");
            objSprint = document.getElementById("DSSprint");
            objAssignedTo = document.getElementById("hdnAssignToId");
            objStatus = document.getElementById("DSStatus");
            objActualdate = document.getElementById("DSActualStartDateDate");
            objRemark = document.getElementById("txtRemark");
            //objIsConvertedToImpediment = document.getElementById("IsConvertedToImpediment");
            objtxtAssignedTo = document.getElementById("txtAssignedTo");

            if (objActionItems.value == "") {

                strmsg = '- Action items can not be left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                //alertify.notify('', 'error');
                checkvalue = 1;

            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            else if (checkSpecialCharacter(objActionItems.value, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Action items should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtActionItems").focus();
                checkvalue = 1;
            }
            //End of Added By Riddhesh Patil
            else if (objActionItems.value.length > 1000) {
                strmsg = '- You can not enter more than 1000 characters for Action item.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                //alertify.notify('', 'error');
                checkvalue = 1;
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            else if (objRemark.value != "") {
                if (checkSpecialCharacter(objRemark.value, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Action items should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtRemark").focus();
                    checkvalue = 1;
                }
            }
			//End of Added By Riddhesh Patil
            if (objSprint.value == "") {
                strmsg = '- Sprint can not be left blank. ';
                errorMsg += "<li>" + strmsg + "</li></br>";
                //alertify.notify('', 'error');
                checkvalue = 1;
            }
            var arrSprintDates = "";
            var sprintResult = ajaxCall("frmDailyScrum.aspx/CurrentSprintDates", "POST", "application/json", "json", JSON.stringify({ SprintID: objSprint.value }));
            if (sprintResult != undefined) {
                if (sprintResult.d != "") {
                    arrSprintDates = sprintResult.d.split("##");
                }
            }

            //if (objTargetdate.value != "")
            //{
            var result = ajaxCall("frmDailyScrum.aspx/CurrenDateValidation", "POST", "application/json", "json", JSON.stringify({ strDate: objTargetdate.value, SprintID: objSprint.value }));


            var d1 = new Date($("#DSTargetDate").val());


            var d2 = new Date(arrSprintDates[1]);


            var oldDate = new Date();
            var d3 = new Date(oldDate.toDateString());


            if (result.d == "0") {
                if (d2 < d3) {
                    strmsg = '- Sprint is delayed.Please extend the sprint end date';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    checkvalue = 1;
                }
            }
            if (result.d == "1") {
                strmsg = '- Target Date should not be less than current date. ';
                errorMsg += "<li>" + strmsg + "</li></br>";
                //alertify.notify('', 'error');
                checkvalue = 1;
            }


            else if (result.d == "2") {
                if (d2 < d3) {
                    strmsg = '- Sprint is delayed.Please extend the sprint end date';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;
                }
                else {
                    strmsg = '- Target date should be in between sprint start date ' + arrSprintDates[0] + ' and end date ' + arrSprintDates[1];
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;
                }
            }
            else if (result.d == "3") {
                if (d2 < d3) {

                    strmsg = '- Sprint is delayed.Please extend the sprint end date';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;
                }
                else {
                    strmsg = '- Target date should be in between sprint start date ' + arrSprintDates[0] + ' and end date ' + arrSprintDates[1];
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;
                }
            }
            //}
            if (objtxtAssignedTo.value != "") {

                var objAssinedToList = document.getElementsByClassName("clsAssignedListItem");
                //alert(document.getElementsByClassName("clsAssignedListItem")[i].innerText);
                for (i = 0; i < objAssinedToList.length; i++) {
                    if (objAssinedToList[i].textContent.trim() == objtxtAssignedTo.value.trim()) {
                        isValidAssinedTo = 1;
                        break;
                    }
                }
                if (isValidAssinedTo == 0) {
                    strmsg = '- Selected Employee is not assigned on project. ';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;
                }
            }
            else if (objtxtAssignedTo.value == "") {
                document.getElementById("hdnAssignToId").value = "";
            }
            if (objStatus.value.toUpperCase() == "CLOSED") {
                if (objRemark.value == "") {
                    strmsg = '- Remark can not be left blank. ';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;
                }

            }
            if (checkvalue == 0) {

                if ($('#IsConvertedToImpediment').is(':checked')) {
                    IsConvertedToImpediment = 1;
                }
                else {
                    IsConvertedToImpediment = 0;
                }
                var data = JSON.stringify({ MeetingID: GlobalMeetingID, ActionItems: objActionItems.value, Sprint: objSprint.value, TargetDate: objTargetdate.value, AssignedTo: objAssignedTo.value, Status: objStatus.value, Remark: objRemark.value, IsConvertedToImpediment: IsConvertedToImpediment });
                var result = ajaxCall("frmDailyScrum.aspx/SaveDailyScrum", "POST", "application/json", "json", data);
                if (result.d == "2") {
                    strmsg = '- Impediment is not closed so can not closed the action item. ';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;
                }
                else if (result.d != "" || result.d != "0") {
                    alertify.set('notifier', 'position', 'top-right');
                    if (GlobalMeetingID != "")
                        alertify.notify('Data Updated Successfully', 'success', 15);
                    else
                        alertify.notify('Data Saved Successfully', 'success', 15);

                    document.getElementById("hdnAssignToId").value = "";
                }
            }
            if (checkvalue == 1) {
                if (strmsg != "") {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("<ul>" + errorMsg + "</ul>", 'error', 10);
                    return;

                }
            }
            if (flagMode == 1) {

                //$("#divAddDS .close").click();
                ShowFilter(strGlobalFilterValue, strGlobaFilterField);
                ShowModal("divAddDS", "", "");



            }
            else if (flagMode == 0) {
                //ShowModal("divAddDS", "", "")

                $("#divAddDS .close").click()
                ShowFilter(strGlobalFilterValue, strGlobaFilterField);
            }
        }
        function ShowLength(limitField, limitCountField, limitNum) {
            //var objSp = GetObjectReference("", "ActionItems");
            //var objDes = GetObjectReference("", "txtActionItems");
            //objSp.innerHTML = objDes.value.length;
            var length;
            if (limitField.value.length > limitNum) {
                limitField.value = limitField.value.substring(0, limitNum);
            } else {
                document.getElementById(limitCountField).innerHTML = +(limitNum - limitField.value.length);
            }

            if (limitNum - limitField.value.length == 0) {

                document.getElementById(limitCountField).style.color = 'red' //when Char 0 length  then Color red               



            }
            else {

                document.getElementById(limitCountField).style.color = 'black'
                // $('#spanBusinessValue').text("");


            }
            if (limitField.clientHeight < limitField.scrollHeight) {
                limitField.style.height = limitField.scrollHeight + "px";
                if (limitField.clientHeight < limitField.scrollHeight) {
                    limitField.style.height =
                        (limitField.scrollHeight * 2 - limitField.clientHeight) + "px";
                }
            }
        }
        //function Maxlength(limitField, limitCountField, limitNum) {
        //    var length;
        //    if (limitField.value.length > limitNum) {
        //        limitField.value = limitField.value.substring(0, limitNum);
        //    } else {
        //        document.getElementById(limitCountField).innerHTML = +(limitNum - limitField.value.length);
        //    }

        //    if (limitNum - limitField.value.length == 0) {

        //        document.getElementById(limitCountField).style.color = 'red' //when Char 0 length  then Color red               



        //    }
        //    else {

        //        document.getElementById(limitCountField).style.color = 'black'
        //        // $('#spanBusinessValue').text("");


        //    }
        //    if (limitField.clientHeight < limitField.scrollHeight) {
        //        limitField.style.height = limitField.scrollHeight + "px";
        //        if (limitField.clientHeight < limitField.scrollHeight) {
        //            limitField.style.height =
        //              (limitField.scrollHeight * 2 - limitField.clientHeight) + "px";
        //        }
        //    }
        //}

        function WeekDate_onclick(strDate, obj) {
            curWhereDate = strDate;
            var strUserResult = ajaxCall("frmDailyScrum.aspx/DrawGrid", "POST", "application/json", "json", JSON.stringify({ Flag: 'WEEKDATE', Value: strDate }));
            strGlobaFilterField = "WEEKDATE";
            strGlobalFilterValue = strDate;
            if (strUserResult.d != null || strUserResult.d != undefined) {

                $("#DivList").html("");
                $("#DivList").html(strUserResult.d);
                //$('[data-toggle="tooltip"]').tooltip();
                //Added By Dipali V On 24th March 2023 For Datatable Issue
                if ($("#FilterDailyScurmList").val() > 0) {
                    datatables('DivDailyScurmList', 'txtSearchDailyScrum', '');
                    //eND OF Added By Dipali V On 24th March 2023 For Datatable Issue
                    $(".scrum_date").click(function () {

                        $(".scrum_date").removeClass("selecteddate")

                        $(this).addClass("selecteddate")


                    })
                }

            }
        }
        var blnStatus = false;
        var blnSprints = false;
        var blnImpediment = false;
        function ShowStatus(obj, divID) {
            var blnminuseactive = false;
            if ($(obj).hasClass("fa-plus-circle")) {
                $(obj).removeClass("fa-plus-circle");
                $(obj).addClass("fa-minus-circle");
                //Added By Usha Pandit On 25.04.2020 For highlight child on hover and remove hover for parent
                $(obj).parent().addClass("no-hover");
                //End Of Added By Usha Pandit On 25.04.2020 For highlight child on hover and remove hover for parent
                $("#" + divID).css("display", "block");
                blnminuseactive = true;
            }
            else if ($(obj).hasClass("fa-minus-circle")) {
                $(obj).removeClass("fa-minus-circle");
                $(obj).addClass("fa-plus-circle");
                //Added By Usha Pandit On 25.04.2020 For highlight parent on hover and remove hover for child
                $(obj).parent().removeClass("no-hover");
                //End Of Added By Usha Pandit On 25.04.2020 For highlight parent on hover and remove hover for child
                $("#" + divID).css("display", "none");
            }

            if (divID == "divStatus") {
                if (blnminuseactive == true) {
                    blnStatus = true;
                }
                else {
                    blnStatus = false;
                }
            }
            if (divID == "divSprints") {
                if (blnminuseactive == true) {
                    blnSprints = true;
                } else {
                    blnSprints = false;
                }
            }
            if (divID == "divImpediment") {
                if (blnminuseactive == true) {
                    blnImpediment = true;
                } else {
                    blnImpediment = false;
                }
            }
            if (blnStatus == true && blnSprints == false && blnImpediment == false) {
                $("#UlFilter").css("cssText", "height: 350px!important;");
            }
            if (blnStatus == false && blnSprints == true && blnImpediment == false) {
                $("#UlFilter").css("cssText", "height: 220px!important;");
            }
            if (blnStatus == false && blnSprints == false && blnImpediment == true) {
                $("#UlFilter").css("cssText", "height: 200px!important;");
            }
            if (blnStatus == false && blnSprints == false && blnImpediment == false) {
                $("#UlFilter").css("cssText", "height: 150px!important;");
            }
            if (blnStatus == true && blnSprints == true && blnImpediment == true) {
                $("#UlFilter").css("cssText", "height: 470px!important;");
            }
            if (blnStatus == false && blnSprints == true && blnImpediment == true) {
                $("#UlFilter").css("cssText", "height: 300px!important;");
            }
            if (blnStatus == false && blnSprints == true && blnImpediment == true) {
                $("#UlFilter").css("cssText", "height: 300px!important;");
            }
            if (blnStatus == true && blnSprints == true && blnImpediment == false) {
                $("#UlFilter").css("cssText", "height: 400px!important;");
            }
            if (blnStatus == true && blnSprints == false && blnImpediment == true) {
                $("#UlFilter").css("cssText", "height: 400px!important;");
            }

        }
            function ShowFilter(Value, flag) {

                if (flag == "Sprints") {
                    Value = document.getElementById("DSFilterSprint").value;
                }

                if (flag == "CurrentSprint") {
                    Value = 0;
                }
                strGlobaFilterField = flag;
                strGlobalFilterValue = Value;
                curWhereFlag = flag;
                curWhereValue = Value;

                //Added by Usha Pandit on 07 Jun 2018 for show filter data properly
                if (flag == "Sprints" && Value == "" || flag == "" && Value == "") {
                    flag = 'WEEKDATE'
                    Value = curWhereDate;
                }
                //End of Added by Usha Pandit on 07 Jun 2018 for show filter data properly

                var strUserResult = ajaxCall("frmDailyScrum.aspx/DrawGrid", "POST", "application/json", "json", JSON.stringify({ Flag: flag, Value: Value }));
                if (strUserResult.d != null || strUserResult.d != undefined) {
                    $("#DivDailyScurmList .dataTables_scrollBody table tbody tr:first td:first").html("")
                    $("#DivList").html("");
                    $("#DivList").html(strUserResult.d);
                    //$('[data-toggle="tooltip"]').tooltip();
                    // datatables('DivDailyScurmList', 'txtSearchDailyScrum', '')
                    //Added By Dipali V On 24th March 2023 For Datatable Issue
                    if ($("#FilterDailyScurmList").val() > 0) {
                        datatables('DivDailyScurmList', 'txtSearchDailyScrum', '')
                        //End of Added By Dipali V On 24th March 2023 For Datatable Issue
                    }
                    if (strGlobaFilterField != "" && strGlobaFilterField != "WEEKDATE") {
                        $("#filterClear").css("visibility", "visible");
                    }
                    else {
                        $("#filterClear").css("visibility", "hidden");
                    }



                    //Added By Usha Pandit on 08 June 2018 for clearing filter if sprint not selected 
                    //if (flag == "WEEKDATE" && Value == "" || flag == "" && Value == "") {

                    //    $("#filterClear").css("visibility", "hidden");
                    //}
                    //End of Added By Usha Pandit on 08 June 2018 for clearing filter if sprint not selected 

                    if (flag == "Sprints") {
                    }
                    else {
                        document.getElementById("DSFilterSprint").value = "";
                    }

                }
            }

        

        function Save_Impediment(flagMode) {
            var Flag = 0;
            var checkvalue = 0;
            var strmsg = "";
            var errorMsg = ""

            var objtxtImpedimentDescription;
            var objimpedimentSeverity;
            var objimpedimentPriority;
            var objtxtCorrectiveAction;
            var objtxtPreventiveAction;
            var objdtPlannedIssueDate;
            var objimpedimentStatus;
            var objtxtConvertedTo;

            objtxtImpedimentDescription = document.getElementById("txtImpedimentDescription");
            objimpedimentSeverity = document.getElementById("impedimentSeverity");
            objimpedimentPriority = document.getElementById("impedimentPriority");
            objtxtCorrectiveAction = document.getElementById("txtCorrectiveAction");
            objtxtPreventiveAction = document.getElementById("txtPreventiveAction");
            objdtPlannedIssueDate = document.getElementById("dtPlannedIssueDate");
            objimpedimentStatus = document.getElementById("impedimentStatus");
            objtxtConvertedTo = $("#impedimentConvertTo :selected").text();

            //Added by Usha Pandit on 24 May 2018 for saving sprint for current impediment
            if ($("#cboSprint :selected").text() == "") {
                strmsg = '- Please select sprint.';
                errorMsg += "<li>" + strmsg + "</li><BR/>";
                //alertify.notify('', 'error');
                $("#cboSprint").focus();
                checkvalue = 1;
            }
            //End of Added by Usha Pandit on 24 May 2018 for sprint validation for current impediment

            if (objtxtImpedimentDescription.value == "") {
                strmsg = '- Description can not be left blank.';
                errorMsg += "<li>" + strmsg + "</li><BR/>";
                //alertify.notify('', 'error');
                if ($('#cboSprint').is(':focus') == true) {
                }
                else {
                    $("#txtImpedimentDescription").focus();
                }
                checkvalue = 1;
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            else if (objtxtImpedimentDescription.value != "") {
                if (checkSpecialCharacter(objtxtImpedimentDescription.value, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Action items/Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtImpedimentDescription").focus();
                    checkvalue = 1;
                }
            }
			//End of Added By Riddhesh Patil

            if ($("#impedimentConvertTo :selected").text() == "Issue") {
                var blnDefaultIssue = false;
                var strUserResult = ajaxCall("frmDailyScrum.aspx/DefaultIssueExist", "POST", "application/json", "json", JSON.stringify({}));
                if (strUserResult != undefined) {
                    if (strUserResult.d == "") {
                        blnDefaultIssue = true;
                    }
                    else {
                        blnDefaultIssue = false;
                        errorMsg += "<li> - " + strUserResult.d + "</li><BR/>";
                        checkvalue = 1;
                    }
                }
                if (blnDefaultIssue == true) {

                    if (objimpedimentPriority.value == "") {
                        if (objimpedimentSeverity.value != "") {
                            errorMsg += "<li> - As Issue is selected, Priority and Severity are mandatory</li><BR/>";
                        }
                        strmsg = '- Priority can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;

                        //var hasFocus = $('#txtImpedimentDescription').is(':focus');
                        if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus')) {

                        }
                        else {
                            $("#impedimentPriority").focus();
                        }
                    }

                    if (objimpedimentSeverity.value == "") {
                        errorMsg += "<li> - As Issue is selected, Priority and Severity are mandatory</li><BR/>";
                        strmsg = '- Severity can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";

                        if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus') == true || $('#impedimentPriority').is(':focus') == true) {

                        }
                        else {
                            $("#impedimentSeverity").focus();
                        }
                        checkvalue = 1;
                    }


                    objtxtResponsiblePerson = $("#ResponsiblePerson :selected").text();

                    if (objtxtResponsiblePerson == "") {
                        strmsg = '- Responsible Person can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;

                        if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus') == true || $('#impedimentPriority').is(':focus') == true || $('#impedimentSeverity').is(':focus') == true) {

                        }
                        else {
                            $("#ResponsiblePerson").focus();
                        }
                    }
                }
            }

            if (objtxtConvertedTo == "Risk") {
                objtxtProbability = document.getElementById("Probability");
                objtxtImpact = document.getElementById("Impact");
                objoptRiskCategory = $("#RiskCategory :selected").val();

                if (objoptRiskCategory == "") {
                    strmsg = '- Risk Category can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;
                    //var hasFocus = $('#txtImpedimentDescription').is(':focus');
                    if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus')) {

                    }
                    else {
                        $("#RiskCategory").focus();
                    }
                }

                if (objtxtImpact.value == "") {
                    strmsg = '- Impact can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;

                    if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true) {

                    }
                    else {
                        $("#Impact").focus();
                    }
                }
                else if (objtxtImpact.value != "") {
                    if ($("#Impact").val() <= 0 || $("#Impact").val() > 10) {
                        strmsg = "- Enter Imapct value between 1-10.";
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;
                        if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true) {

                        }
                        else {
                            $("#Impact").focus();
                        }
                    }
                }
                if (objtxtProbability.value == "") {
                    strmsg = '- Probability can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;

                    if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#Impact').is(':focus') == true) {

                    }
                    else {
                        $("#Probability").focus();
                    }
                }
                else if (objtxtProbability.value != "") {
                    if ($("#Probability").val() < 0 || $("#Probability").val() > 1) {
                        strmsg = "- Enter probability between 0-1.";
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;
                        if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#Impact').is(':focus') == true) {

                        }
                        else {
                            $("#Probability").focus();
                        }
                    }
                }
            }


            if (checkvalue == 0) {

                var data = JSON.stringify({ ImpedimentID: '', ImpedimentDescription: objtxtImpedimentDescription.value, ImpedimentSeverity: objimpedimentSeverity.value, ImpedimentPriority: objimpedimentPriority.value, CorrectiveAction: objtxtCorrectiveAction.value, PreventiveAction: objtxtPreventiveAction.value, PlannedIssueDate: objdtPlannedIssueDate.value, impedimentStatus: objimpedimentStatus.value, ConvertedTo: objtxtConvertedTo, IterationID: $("#cboSprint :selected").val() });
                var result = ajaxCall("frmDailyScrum.aspx/SaveImpediment", "POST", "application/json", "json", data);
                if (result != undefined) {

                    if (result.d != "") {

                        var ImpedimentID = result.d;
                        if (objtxtConvertedTo == "Risk") {

                            objtxtProbability = document.getElementById("Probability");
                            objtxtImpact = document.getElementById("Impact");
                            objoptRiskCategory = $("#RiskCategory :selected").val();

                            //Save Risk Details
                            var data = JSON.stringify({ Probability: objtxtProbability.value, Impact: objtxtImpact.value, Description: objtxtImpedimentDescription.value, RiskCategoryId: objoptRiskCategory, ImpedimentID: ImpedimentID, ImpactDescription: '', RiskStatus: '', DateIdentified: '' });
                            var result = ajaxCall("frmDailyScrum.aspx/SaveImpedimentRisk", "POST", "application/json", "json", data);
                            if (result != undefined) {

                            }
                        }

                        if (objtxtConvertedTo == "Issue") {

                            //Save Issue Details
                            var data = JSON.stringify({ Description: objtxtImpedimentDescription.value, ImpedimentID: ImpedimentID, AssignTo: $("#ResponsiblePerson :selected").val(), Type: '', SubType: '', Status: '', ReportedBy: '', Summary: '', Priority: $("#impedimentPriority :selected").text(), Severity: $("#impedimentSeverity :selected").text() });
                            var result = ajaxCall("frmDailyScrum.aspx/SaveImpedimentIssue", "POST", "application/json", "json", data);
                            if (result != undefined) {

                            }
                        }

                        alertify.dismissAll();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Impediment Saved Successfully', 'success', 10);

                        if (flagMode == 1) {

                            ShowFilter(strGlobalFilterValue, strGlobaFilterField);
                            ShowModal("divAddImpediment", "", "");
                        }
                        else if (flagMode == 0) {
                            $("#divAddImpediment .close").click();
                            ShowFilter(strGlobalFilterValue, strGlobaFilterField);
                        }
                        //RefreshGrid();
                    }
                }
            }
            else if (checkvalue == 1) {
                if (errorMsg != "") {
                    alertify.dismissAll();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("<ul>" + errorMsg + "</ul>", 'error', 10);
                }
            }
        }
        function GetSelectedConvertTo(selectItem, itemval, selectstatus) {
            if (selectItem == "") {
                $("#divResponsePerson").addClass("clsShow");
                $("#divRiskFields").addClass("clsShow");
                $("#divRiskCategory").addClass("clsShow");
                $(".clsIsMandetory").each(function () {
                    var $element = $(this)
                    try {
                        var tempval = $element.text();
                        tempval = tempval.replace("*", "");
                        $element.text(tempval);
                    }
                    catch (ex) {
                    }
                });
                alertify.dismissAll();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Impediment is ' + selectstatus + ' can not be converted as ' + itemval, 'error', 15);
            }
            else if (selectItem.value == "") {

                $("#divResponsePerson").addClass("clsShow");
                $("#divRiskFields").addClass("clsShow");
                $("#divRiskCategory").addClass("clsShow");
                $(".clsIsMandetory").each(function () {
                    var $element = $(this)
                    try {
                        var tempval = $element.text();
                        tempval = tempval.replace("*", "");
                        $element.text(tempval);
                    }
                    catch (ex) {
                    }
                });
            }
            else
                if (selectItem.value == "Issue") {
                    if ($("#DSStatus :selected").text() == selectstatus || $("#impedimentStatus :selected").text() == selectstatus) {
                        $("#impedimentConvertTo").val("");
                        alertify.dismissAll();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('- Impediment is ' + selectstatus + ' can not be converted as issue', 'error', 15);
                    }
                    else {
                        $("#divResponsePerson").removeClass("clsShow");
                        $("#divRiskFields").addClass("clsShow");
                        $("#divRiskCategory").addClass("clsShow");

                        $(".clsIsMandetory").each(function () {
                            var $element = $(this)
                            try {
                                var tempval = $element.text();
                                if (tempval.indexOf("*") == -1) {
                                    tempval = tempval.replace(tempval, tempval + "*");
                                    $element.text(tempval);
                                }
                            }
                            catch (ex) {

                            }
                        });
                    }
                }
                else if (selectItem.value == "Risk") {
                    if ($("#DSStatus :selected").text() == selectstatus || $("#impedimentStatus :selected").text() == selectstatus) {
                        $("#impedimentConvertTo").val("");
                        alertify.dismissAll();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('- Impediment is ' + selectstatus + ' can not be converted as risk', 'error', 15);
                    }
                    else {
                        $("#divRiskFields").removeClass("clsShow");
                        $("#divRiskCategory").removeClass("clsShow");
                        $("#divResponsePerson").addClass("clsShow");
                        $(".clsIsMandetory").each(function () {
                            var $element = $(this)
                            try {
                                var tempval = $element.text();
                                tempval = tempval.replace("*", "");
                                $element.text(tempval);
                            }
                            catch (ex) {

                            }
                        });
                    }
                }
        }
        function checkProjectEndDate(plannedclosedate) {
            //alert(plannedclosedate.value);

            var strProjectResult = ajaxCall("frmDailyScrum.aspx/GetProjectEndDate", "POST", "application/json", "json", JSON.stringify({}));
            //alert(strProjectResult.d);

            //var onlyplannedclosedate1 = new Date(plannedclosedate.value);
            //var onlyProjectResultdate2 = new Date(strProjectResult.d);

            //var d1 = new Date(onlyplannedclosedate1.toDateString());
            //var d2 = new Date(onlyProjectResultdate2.toDateString());
            if (plannedclosedate.value != "") {
                var d1 = new Date(plannedclosedate.value);
                var d2 = new Date(strProjectResult.d);


                if (d1.toString().indexOf("Invalid Date") == -1 && plannedclosedate != undefined) {
                    if (d1 < d2) {

                        //alert("lesser");
                    }
                    else if (d1 > d2) {
                        //alert("greater");
                        alertify.dismissAll();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('- change the project end date or select planned closure date less than project end date', 'error', 15);
                        $("#dtPlannedIssueDate").val("");
                        $("#dtPlannedIssueDate").focus();
                    }
                }
            }
            //alert(d1);
            //alert(d2);
        }
        //End of Added by Usha Pandit on 13 Apr 2018 for Impediment Popup

        function ConvertToImpediment(obj, MeetingID, MeetingStatus) {
            var data = JSON.stringify({ MeetingID: MeetingID, MeetingStatus: MeetingStatus });
            var result = ajaxCall("frmDailyScrum.aspx/UpdateImpediment", "POST", "application/json", "json", data);
            if (result.d == "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Converted to Impediment Successfully', 'success', 15);
                ShowFilter(strGlobalFilterValue, strGlobaFilterField);

            }
        }

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
        function ClearFilter(obj) {
            curWhereFlag = '';
            curWhereValue = '';
            strGlobaFilterField = "";
            strGlobalFilterValue = "";
            ShowFilter(strGlobalFilterValue, strGlobaFilterField);
            $(obj).css("visibility", "hidden");
        }
        function ShowHistory(MeetingID) {
            $("#txtSearchHistory").val("");
            var data = JSON.stringify({ MeetingID: MeetingID });
            var result = ajaxCall("frmDailyScrum.aspx/ShowHistoryDetails", "POST", "application/json", "json", data);

            //alert(strResult.d);
            if (result.d != "") {

                $("#DivShowhistory #GetShowhistory").html(result.d);

                $('#DivGridShowHistory table > tbody > tr ').each(function (index) {
                    if ($(this).children('td').length == 0) {
                        $(this).remove();
                    }
                });

               
                 //Added By Dipali V On 24th March 2023 For Datatable Issue
                if ($("#FilterGridShowHistory").val() > 0) {
                    datatables('DivGridShowHistory', 'txtSearchHistory', '');
                }
                //datatables('DivGridShowHistory', 'txtSearchHistory', '');
                //End of Added By Dipali V On 24th March 2023 For Datatable Issue
                //datatable("#DivGridShowHistory");
                //datatables("DivGridShowHistory", '', "");
                $("#DivShowhistory").modal('show');
                $("#Idheader").html("Show History");
                //$('[data-toggle="tooltip"]').tooltip();
                //$('#DivGridShowHistory').DataTable();
            }


        }
        function AutoResizeTextArea() {
            jQuery.each(jQuery('textarea[data-autoresize]'), function () {
                //var offset = this.offsetHeight - this.clientHeight;

                var resizeTextarea = function (el) {
                    //jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
                };
                jQuery(this).on('keyup input', function () {
                    if ($(this).attr("id") == "txtActionItems") {
                        Maxlength(this, "ActionItems", 1000);
                    }

                    if ($(this).attr("id") == "txtRemark") {
                        Maxlength(this, "DSRemark", 1000);
                    }

                    if ($(this).attr("id") == "txtImpedimentDescription") {
                        Maxlength(this, "ImpedimentDescription", 500);
                    }


                    if ($(this).attr("id") == "txtCorrectiveAction") {
                        Maxlength(this, "CorrectiveAction", 1000);
                    }
                    if ($(this).attr("id") == "txtPreventiveAction") {
                        Maxlength(this, "PreventiveAction", 1000);
                    }
                    resizeTextarea(this);
                }).removeAttr('data-autoresize');


            });
        }
        function RemoveTextArea() {
            $('textarea').keydown(function (e) {
                var $this = $(this),
                    rows = parseInt($this.attr('rows')),
                    lines;
                //alert(rows);
                //// on enter
                //if (e.which === 13) {
                //    $this.attr('rows', rows + 1);
                //}

                // on backspace -- THIS IS THE PROBLEM
                if (e.which === 8 && rows !== 2) {
                    lines = $(this).val().split('\n')
                    console.log(lines);
                    if (!lines[lines.length - 1]) {
                        $this.attr('rows', rows - 1);

                    }

                }
            });
        }
        function getRows() {
            //debugger;
            if ($("#txtActionItems").val() != undefined) {
                //debugger;

                var numberOfColumns = 70;
                var numberOfLines = 1;
                //numberOfColumns = document.getElementById("txtActionItems").cols;
                var eachLine = $("#txtActionItems").val().split('\n');
                var lineheight = $("#txtActionItems").val();
                numberOfLineBreaks = (lineheight.match(/\n/g) || []).length;
                characterCount = lineheight.length + numberOfLineBreaks;

                if (characterCount > numberOfColumns) {
                    numberOfLines = parseInt(characterCount / numberOfColumns);
                    var height = document.getElementById("txtActionItems").rows = numberOfLines + 2;
                    $("#txtActionItems").attr("style", "height: auto !important");
                }

            }
            if ($("#txtRemark").val() != undefined) {
                var numberOfColumns1 = 70;
                var numberOfLines1 = 1;
                var characterCount1;
                //numberOfColumns = document.getElementById("txtActionItems").cols;
                var eachLine1s = $("#txtRemark").val().split('\n');
                var lineheight1 = $("#txtRemark").val();
                numberOfLineBreaks1 = (lineheight1.match(/\n/g) || []).length;
                characterCount1 = lineheight1.length + numberOfLineBreaks1;

                if (characterCount1 > numberOfColumns1) {
                    numberOfLines1 = parseInt(characterCount1 / numberOfColumns1);
                    var height1 = document.getElementById("txtRemark").rows = numberOfLines1 + 2;
                    $("#txtRemark").attr("style", "height: auto !important");
                }


            }

        }
        function getcols() {
            if ($("#txtImpedimentDescription").val() != undefined) {
                //debugger;

                var numberOfColumns = 70;
                var numberOfLines = 1;
                //numberOfColumns = document.getElementById("txtActionItems").cols;
                var eachLine = $("#txtImpedimentDescription").val().split('\n');
                var lineheight = $("#txtImpedimentDescription").val();
                numberOfLineBreaks = (lineheight.match(/\n/g) || []).length;
                characterCount = lineheight.length + numberOfLineBreaks;

                if (characterCount > numberOfColumns) {
                    numberOfLines = parseInt(characterCount / numberOfColumns);
                    var height = document.getElementById("txtImpedimentDescription").rows = numberOfLines + 2;
                    $("#txtImpedimentDescription").attr("style", "height: auto !important");
                }

            }
            if ($("#txtCorrectiveAction").val() != undefined) {
                var numberOfColumns1 = 70;
                var numberOfLines1 = 1;
                var characterCount1;
                //numberOfColumns = document.getElementById("txtActionItems").cols;
                var eachLine = $("#txtCorrectiveAction").val().split('\n');
                var lineheight1 = $("#txtCorrectiveAction").val();
                numberOfLineBreaks1 = (lineheight.match(/\n/g) || []).length;
                characterCount1 = lineheight1.length + numberOfLineBreaks1;

                if (characterCount1 > numberOfColumns1) {
                    numberOfLines1 = parseInt(characterCount1 / numberOfColumns1);
                    var height1 = document.getElementById("txtCorrectiveAction").rows = numberOfLines1 + 2;
                    $("#txtCorrectiveAction").attr("style", "height: auto !important");
                }

            }

        }


        function PerformSearchForPTI(e) {

        }
        //Added By Riddhesh Patil on 22/12/2022
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        //End of Added By Riddhesh Patil on 22/12/2022


        //Added By Riddhesh Patil on 22/12/2022
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
		//End of Added By Riddhesh Patil on 22/12/2022
    </script>

</body>
</html>

