<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SM_BulkExtensionStatus.aspx.vb" Inherits="Whizible.SM_BulkExtensionStatus" %>

<!DOCTYPE html>
<html>  
    <head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%=MyBase.GetResourceString("C_BulkExtensionStatus")%></title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />
    <link href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.2" rel="stylesheet" />

    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">--%>

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
        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }
        .dblock {
            display: block;
        }
        body#bodyGlobal-Resource {
            padding-right: 0 !important;
        }
        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .Resourcedetailpanel:hover {
            cursor: auto;
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
        body#bodyVisa-Type {
            padding-right: 0 !important;
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
            border-radius: 15px;
            background: #ddd;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
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
        .offcanvas-50{
            --bs-offcanvas-width: 50%;
        }

        select.form-select {
        -webkit-appearance: none;
        }

        /* Added or Modified by Vishal Mane on 24/03/2026 to align Total Records and pagination controls */
        #StatusTable_wrapper .row:last-child {
            display: flex;
            justify-content: flex-end !important;
            align-items: center;
            gap: 8px;
        }

        #StatusTable_wrapper .row:last-child > div {
            width: auto !important;
            max-width: none !important;
            flex: 0 0 auto !important;
            padding-left: 0 !important;
            padding-right: 0 !important;
        }

        #StatusTable_wrapper .dataTables_info,
        #StatusTable_wrapper .dataTables_paginate {
            float: none !important;
            margin: 0 !important;
            padding: 0 !important;
            width: auto !important;
            white-space: nowrap !important;
        }

        #StatusTable_wrapper .dataTables_paginate .paginate_button {
            min-width: 28px;
            height: 24px;
            line-height: 14px;
            padding: 4px 8px;
            margin-left: 0;
            cursor: default !important;
        }

        #StatusTable_wrapper .dataTables_paginate {
            display: inline-flex !important;
            align-items: center;
            gap: 0;
        }

        #StatusTable_wrapper .dataTables_paginate .paginate_button.previous {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }

        #StatusTable_wrapper .dataTables_paginate .paginate_button.next {
            border-left: 0;
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }

        #StatusTable_wrapper .dataTables_paginate .paginate_button.disabled {
            cursor: default !important;
        }

        /*Added by Vishal Mane on 20/03/2026 to fix newly added changes from Phase I issue list*/
        .offcanvas-close-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            padding: 0;
            background: transparent;
            border: none;
            border-radius: 4px;
            color: #374151;
            font-size: 18px;
            line-height: 1;
            cursor: pointer;
            opacity: 0.6;
            transition: opacity 0.15s ease, background 0.15s ease;
            flex-shrink: 0;
        }

        .offcanvas-close-btn:hover {
            opacity: 1;
            background: rgba(0, 0, 0, 0.08);
        }

        .offcanvas-close-btn:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(19, 89, 166, 0.25);
        }

        .page-header {
           /* background-color: #e7edf0;*/
            padding: 12px 14px;
            margin-bottom: 0;
            display: flex;
            align-items: flex-start;
            border-bottom: 1px solid #e9ecef;
            margin: 0px;
        }

        .header-icon {
            width: 26px;
            height: 26px;
            background-color: #1e40af;
            border-radius: 6px;
            margin-top: -5px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: white;
            font-size: 18px;
            flex-shrink: 0;
        }

        .header-content {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .page-title {
            color: #1e40af;
            font-size: 18px;
            font-weight: 600;
            margin: 0;
            line-height: 1.2;
        }

        .page-subtitle {
            color: #6B7280;
            font-size: 14px;
            font-weight: 400;
            margin: 0;
            line-height: 1.4;
            margin-top: 4px;
            margin-left: -42px;
        }

        .highlight-box {
            display: inline-block;
            background-color: #fff3cd;   /* light yellow */
            color: #856404;
            padding: 4px 10px;
            border-radius: 6px;
            border: 1px solid #ffeeba;
            font-weight: 500;
        }
         /* Added by Vishal Mane on 11/03/2026 for UI changes */
    </style>

</head>

<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodyVisa-Type">
    <div class="bgwhite">

        <%--<div class="container-fluid pt-1 pb-1 mb-1 text-end graybg">
            <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("C_BulkExtensionStatus")%></h5>
            <div class="clearfix"></div>
        </div> --%>
        <div class="graybg page-header">
            <div class="header-icon">
                <i class="fas fa-tags"></i>
            </div>
            <div class="header-content">
                <h5 class="page-title"><%=MyBase.GetResourceString("C_BulkExtensionStatus") %></h5>
                <p class="page-subtitle">Define and manage statuses used across workflows to control lifecycle and processing stages.</p>
            </div>
        </div>
        <div class="clearfix"></div>

        <div class="row align-items-center pt-1 pb-1 px-3">
            <!-- Search Box -->
            <div class="col-sm-3">
                <div class="input-group">
                    <input id="searchStatusInput" type="text" placeholder="Search Status Name" onkeyup="searchStatus()" class="form-control input-sm">
                    <button class="btn btn-default srchBtn" type="submit"><i class="fas fa-search"></i></button>
                </div>
            </div>
            <div class="col-sm-5"></div>
            <div class="col-sm-4 d-flex justify-content-end gap-2">
                <a href="javascript:;" class="btn borderbtn backbtn"
                    id="AddStatus" data-bs-toggle="offcanvas" data-bs-target="#statusOffcvsScreen" 
                    title="Add" onclick="AddStatus()">
                    <i class="fa fa-plus"></i><%=MyBase.GetResourceString("C_Add")%>
                </a>

                <button class="btn borderbtn" id="DeleteStatus"
                    onclick="DeleteStatusConfirmation();" data-bs-toggle="tooltip" title="Delete">
                    <%=MyBase.GetResourceString("C_Delete")%>
                </button>
            </div>
        </div>
        <div class="content pt-1">
            <table class="table table-bordered GRPtbl" style="width: 100%;" id="StatusTable">
                <thead>
                    <tr>
                        <th class="text-start"><%=MyBase.GetResourceString("C_StatusName")%></th>
                        <th class="text-center"><%=MyBase.GetResourceString("C_SystemStatus")%></th>
                        <th width="50" class="text-center pe-2">
                            <div class="custom_chckbox">
                                <input id="Statuscheck0" class="chckHead" type="checkbox">
                                <label for="Statuscheck0"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="tblStatus_Body">
                </tbody>
            </table>
        </div>

        <div class="clearfix"></div>
    </div>
    
    <div class="modal custmodal fade" id="DeleteConfirmMModal" aria-hidden="true" data-bs-dismiss="modal">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_DeleteStatus")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="notebox">
                        <strong><%=MyBase.GetResourceString("C_Note")%> </strong> <%=MyBase.GetResourceString("C_StatusIsInUse")%><br />
                        <p id="showdeleterow"></p>
                    </div>
                    <div class="text-end">
                        <button class="btn borderbtn" data-bs-dismiss="modal" data-bs-toggle="tooltip" title="Ok"><%=MyBase.GetResourceString("C_Ok")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete Status modal start here-->
    <div id="deleteStatusModal" class="modal fade custmodal" role="dialog" aria-hidden="false" data-bs-backdrop="static">
        <div class="modal-dialog modalsmall ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%=MyBase.GetResourceString("C_DeleteConfirmation")%></h4>
                </div>
                <div class="modal-body">
                    <p class="text-center"><%=MyBase.GetResourceString("C_DeleteYesNo")%></p>
                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal" data-bs-toggle="tooltip" title="No"><%=MyBase.GetResourceString("C_No")%></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" data-bs-dismiss="modal" onclick="DeleteStatusAfterConfirm()" data-bs-toggle="tooltip" title="Yes"><%=MyBase.GetResourceString("C_Yes")%></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- Delete Status modal end here--> 

    <!-- More Details Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-50" data-bs-scroll="true" tabindex="-1"
            id="statusOffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <input type="hidden" id="hdnStatus_UniqueIDTab" name="hdnStatus_UniqueIDTab">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex align-items-center justify-content-between font-weight-600">
                                <!-- Modified By Madhuri.K On 03-04-2026 -->
                                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_StatusDetails")%></h5>
                                <button type="button" class="offcanvas-close-btn"
                                    data-bs-dismiss="offcanvas" aria-label="Close" title="Close">
                                    &#x2715;
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="statusEdtTab" class="statusInfo">
                    <div class="row">
                        <div class="col-sm-4">&nbsp;</div>
                        <div class="col-sm-8">
                            <div class="nextBtnDiv d-flex justify-content-end gap-2">                                
                                <button class="btn btnyellow" id="saveStatusBtn" data-bs-toggle="tooltip" title="Save" onclick="SaveStatusDetails(0);"><%=MyBase.GetResourceString("C_Save")%></button>
                                <button class="btn btnyellow" id="btnSaveStatusDetails" data-bs-toggle="tooltip" title="Save And Add" onclick="SaveStatusDetails(1);"><%=MyBase.GetResourceString("C_SaveAndAdd")%></button>
                                <%--<button class="btn borderbtn" type="button" id="closeStatuBtn" data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip" title="Close"><%=MyBase.GetResourceString("C_Close")%></button>--%>
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-sm-12 text-end">
                            <label class="form-label ">(<font color="red">*</font>
                                <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                        </div>
                    </div>
                    <div class="CityEdtInfo">
                        <div class="addCGContent">
                            <div class="row form-group mt-3">
                                <div class="col-sm-8 mb-3">
                                    <div class="row mb-1">
                                        <div class="col-sm-4 text-end">
                                            <label class="required"><%=MyBase.GetResourceString("C_StatusName")%></label>
                                        </div>
                                        <div class="col-sm-8 text-start">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtStatusName", "idtxtStatusName", cssClass:="form-control", widthInPixel:=0, maxLength:=100)%>
                                        </div>
                                    </div>
                                </div>
                                <%--<div class="col-sm-6 mb-3">
                                </div>--%>
                            </div>
                             <div class="row form-group mt-3">
                                <div class="col-sm-8 mb-3">
                                    <div class="row mb-1">
                                        <div class="col-sm-4 text-end">
                                            <label class="required"><%=MyBase.GetResourceString("C_SystemStatus")%></label>
                                        </div>
                                        <div class="col-sm-8 text-start">
                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboSystemStatus", "usp_Whizible2_Sel_SystemStatusMaster",,, "class='form-select'",,,) %>   
                                            <%--<select id="cboSystemStatus" data-dropup-auto="false"> </select>--%>
                                        </div>
                                    </div>
                                </div>
                                <%--<div class="col-sm-6 mb-3">
                                </div>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- More Details Offcanvas Section ends -->    
    <!-- REQUIRED JS SCRIPTS -->
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>

    <script>
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Configuration").ToString%>';
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();
        $(function () {
            $("[rel='tooltip']").tooltip();
        });
        $("[data-toggle=tooltip").tooltip();
        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';      
        var UserName = '<%= Session("strUserName") %>';
        var noOfRowsPerPage = 10;
        var DeleteRecord = '<%=MyBase.GetResourceString("A_AtLeastRecord")%>';        
        var NoDataFound = '<%=MyBase.GetResourceString("NoDataFound")%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var StatusTable;
        $(document).ready(function () {
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
            if (blnAddAccess == "False") {
                $("#AddStatus").addClass("clsShowHide");
                $('#btnSaveStatusDetails').attr("disabled", true);
            }
            else {
                $("#AddStatus").removeClass("clsShowHide");
                $('#btnSaveStatusDetails').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#DeleteStatus").addClass("clsShowHide");
            }
            else {
                $("#DeleteStatus").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {
                GetStatusMasterDetails();
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";
            }
        });
        
        function AddStatus() {
            $('#idtxtStatusName').attr("disabled", false);
            $('#btnSaveStatusDetails').attr("disabled", false);
            $("#hdnStatus_UniqueIDTab").val(0);
            $('#idtxtStatusName').val("");
            $("#cboSystemStatus").val(0);
        }
        $('#tblStatus_Body').on('click', '.clEditVisalink', function () {
            var isCheckOrNOt = "No";
            var $row = $(this).closest("tr");
            $tds = $row.find("td");
            $.each($tds, function (index, obj) {
                var hiddenField = $(this).find("#hdn_StatusId").val();
                var hiddenSystemStatus = $(this).find("#hdn_SystemStatus").val();
                if (hiddenField != 'undefined' && hiddenField != null) {
                    var eventId = hiddenField;
                    $('#hdnStatus_UniqueIDTab').val(eventId);
                    $('#idtxtStatusName').val($(this).text());
                    $('#cboSystemStatus').val(hiddenSystemStatus);
                }
            });
        });

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        function resizeSection() {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 230, "overflow-y": "auto" });

            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }
        
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 0);
        });

        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        $(".chckHead").change(function () {
            var allPages = StatusTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#StatusTable").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedStatusID.push(parseInt($(rows[i]).find("#hdn_StatusId").val()));
                    }

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedStatusID = [];
                }
            }
        });

        function checkUncheck() {
            if (StatusTable.$('input:checked').length == StatusTable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").prop("checked", false);
            }
        }
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            StatusTable = $('#StatusTable').dataTable({
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
                pageLength: 10,
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1] }],
                pagingType: "simple",
                language: {
                    info: "Total Records: _TOTAL_",
                    infoEmpty: "Total Records: 0",
                    paginate: {
                        previous: "<<",
                        next: ">>"
                    }
                }
            });
        }

        function GetStatusMasterDetails() {
            SelectedStatusID = [];
            var strHTML = "";
            StartLoader("#bodyVisa-Type");
            var Result = AJAXCallWithResult("/api/SM_BulkExtensionStatus/GetStatusMasterDetails",'',false);
            var visaList = Result;
            statusList = Result
            if (visaList.length > 0) {
                $.each(visaList, function (index, obj) {
                    if (blnEditAccess == "True") {
                        strHTML += '<tr><td class="text-start"><a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#statusOffcvsScreen" class="clEditVisalink"</a><input type="hidden" name="hdn_SystemStatus" id="hdn_SystemStatus" value= ' + obj.SystemStatusValue + '><input type="hidden" name="hdn_StatusName" id="hdn_StatusName" value= ' + obj.StatusName + '>' + obj.StatusName + '<input type="hidden" name="hdn_StatusId" id="hdn_StatusId" value= ' + obj.StatusID + ' ></td><td class="text-center">' + obj.SystemStatus + '</td><td class="text-center"><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedStatusDetails(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                    }
                    else {
                        strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_StatusName" id="hdn_StatusName" value= ' + obj.StatusName + '>' + obj.StatusName + '<input type="hidden" name="hdn_StatusId" id="hdn_StatusId" value= ' + obj.StatusID + '></td><td class="text-center">' + obj.SystemStatusValue + '</td><td class="text-center"><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedStatusDetails(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                    }
                });
            }
            $('#StatusTable').dataTable().fnDestroy();
            $("#tblStatus_Body").html(strHTML);
            LoadPagination(Result);
            StopAjaxLoader("#bodyVisa-Type");
            $(".chckHead").prop("checked", false);
        }

        function ReloadTableSearchForItem(Result) {
            var strHTML = "";
            $('#StatusTable').dataTable().fnDestroy();
            $("#tblStatus_Body").html("");
            var visaList = Result;
            if (visaList.length > 0) {
                $.each(visaList, function (index, obj) {
                    if (blnEditAccess == "True") {
                        strHTML += '<tr><td class="text-start"><a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#statusOffcvsScreen" class="clEditVisalink"</a><input type="hidden" name="hdn_SystemStatus" id="hdn_SystemStatus" value= ' + obj.SystemStatusValue + '><input type="hidden" name="hdn_StatusName" id="hdn_StatusName" value= ' + obj.StatusName + '>' + obj.StatusName + '<input type="hidden" name="hdn_StatusId" id="hdn_StatusId" value= ' + obj.StatusID + ' ></td><td class="text-center">' + obj.SystemStatus + '</td><td class="text-center"><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedStatusDetails(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                    }
                    else {
                        strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_StatusName" id="hdn_StatusName" value= ' + obj.StatusName + '>' + obj.StatusName + '<input type="hidden" name="hdn_StatusId" id="hdn_StatusId" value= ' + obj.StatusID + '></td><td class="text-center">' + obj.SystemStatusValue + '</td><td class="text-center"><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedStatusDetails(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                    }
                });
            }
            $('#StatusTable').dataTable().fnDestroy();
            $("#tblStatus_Body").html(strHTML);
            LoadPagination(Result);
            $(".chckHead").prop("checked", false);
        }

        var statusList = '';
        function searchStatus() {
            var SearchText = $("#searchStatusInput").val().trim().replace(/'/g, "''");
            if (SearchText == "") {
                GetStatusMasterDetails();
            }
            else {
                var statusListData = statusList.filter(function (x) { return x.StatusName.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1}); 
                if (statusListData.length == 0) {
                    var strHTML = "";
                    $('#StatusTable').dataTable().fnDestroy();
                    $("#tblStatus_Body").html(strHTML);
                    LoadPagination(Result);
                    $(".chckHead").prop("checked", false);
                }
                else {
                    ReloadTableSearchForItem(statusListData);
                }
            }
        }

        function clearVTDetail() {
            $("#hdnStatus_UniqueIDTab").val(0);
            $("#idtxtStatusName").val("");
            $("#cboSystemStatus").val(0);
            Details = {};
        }
        //disabled copy and paste
        //$('#idtxtStatusName').bind('copy paste', function (e) {
        //    e.preventDefault();
        //});

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
        function SaveStatusDetails(isFromSaveAndclick) {
            //debugger
            //var StatusName = $("#idtxtStatusName").val().replace(/'/g, "''");
            var StatusName = $("#idtxtStatusName").val()
                .replace(/'/g, "''")      // escape single quote
                .replace(/\s+/g, ' ')     // remove extra spaces
                .trim();
            var SystemStatus = $("#cboSystemStatus").val();
            if (StatusName.length > 0) {
                if (checkSpecialCharacter($("#idtxtStatusName").val().trim(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Status should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#idtxtStatusName").focus();
                } else if (SystemStatus == 0 || SystemStatus == undefined) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_MandatorySystemStatus")%>');
                    $("#cboSystemStatus").focus();
                    return;
                }
                else {
                    var StatusID = $("#hdnStatus_UniqueIDTab").val();
                    var Parameters = {
                        StatusID: StatusID > 0 ? StatusID : 0,
                        Status: StatusName,
                        //SystemStatus: $("#cboSystemStatus option:selected").text(),
                        SystemStatus: SystemStatus,
                        CreatedBy: encodeURI(UserName)
                    };
                    var Param = JSON.stringify(Parameters);
                    var data = AJAXCallWithResult("/api/SM_BulkExtensionStatus/SaveStatusDetails", Param, false);
                    if (isFromSaveAndclick == 0) {
                        if (data == "Status already exist.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                        }
                        //Added by Vishal Mane on 02/02/2026 to restrict System Status
                        else if (typeof data === "string" && data.toLowerCase().includes("system status already exist")) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                        }
                        //End of Added by Vishal Mane on 02/02/2026 to restrict System Status
                        else {
                            //$('#AddStatusModal').modal('hide');
                            //$('#closeStatuBtn').click();
                            var offcanvasEl = document.getElementById('statusOffcvsScreen');
                            var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                            if (offcanvas) {
                                offcanvas.hide();
                            }
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                            GetStatusMasterDetails();
                        }
                    }
                    else {
                        if (data == "Status already exist.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                        }
                        //Added by Vishal Mane on 02/02/2026 to restrict System Status
                        else if (typeof data === "string" && data.toLowerCase().includes("system status already exist")) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                        }
                        //End of Added by Vishal Mane on 02/02/2026 to restrict System Status
                        else {
                            clearVTDetail();
                            //$('#AddStatusModal').modal('show');
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                            GetStatusMasterDetails();
                        }
                    }
                }
            }
            else {
                $("#idtxtStatusName").focus();
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("Status is mandatory");
                alertify.error('<%=MyBase.GetResourceString("A_MandatoryStatus")%>');
            }
        }
        var SelectedStatusID = [];
        function GetSelectedStatusDetails(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedStatusID.push(parseInt(row.find('#hdn_StatusId').val()));
            }
            else {
                if (SelectedStatusID != 'undefined' && SelectedStatusID.length > 0) {
                    var removeEmp = row.find('#hdn_StatusId').val();
                    SelectedStatusID.remove(parseInt(removeEmp));
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

        function DeleteStatusConfirmation() {
            var selectedStatusUniqueId = SelectedStatusID.toString();
            if (selectedStatusUniqueId.length > 0) {
                $('#deleteStatusModal').modal('show');
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }

        function DeleteStatusAfterConfirm() {
            var strHTML = "";
            var selectedStatusUniqueId = SelectedStatusID.toString();
            if (selectedStatusUniqueId.length > 0) {
                var Param = JSON.stringify(selectedStatusUniqueId);
                var data = AJAXCallWithResult("/api/SM_BulkExtensionStatus/DeleteStatusDetails", Param, false);
                StopAjaxLoader("#bodyVisa-Type");
                GetStatusMasterDetails();
                strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                $('#showdeleterow').html(strHTML);
                $('#DeleteConfirmMModal').modal('show');
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedStatusID = [];
            selectedStatusUniqueId = "";
        }

        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
        }
        var ajaxResult = "";
        function AJAXCallWithResult(url, param, async) {
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Configuration"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    console.log(err);
                    /*window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""*/
                }
            });
            return ajaxResult;
        }

    </script>

</body>

</html>

