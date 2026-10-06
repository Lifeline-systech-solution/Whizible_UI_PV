<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_Qualification.aspx.vb" Inherits="PbNIT.RM_Qualification" %>

<!DOCTYPE html>
<html> 
        <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head runat="server">
  <%--  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link href="../../../Whizible2.0-new/dist/css/BS5_migration.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
<%--    <link href="../../../Whizible2.0-new/Plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    



</head>
        <style type="text/css">
            #QListTbl_wrapper .dataTables_scrollHeadInner, #QListTbl_wrapper table{width:100%!important}
            body {
             background: #fff; 
             }
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        /*a.mainclearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }*/

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

        
        /*Added by pradip on 23-7-2021*/
        .pb-0{ padding-bottom:0px!important;}
        /*.table thead tr th:last-child .custom_chckbox{ margin-left:-8px;}*/
/*.dataTables_scrollHeadInner {width: 100% !important;}
.dataTables_scrollHeadInner table {width: 100% !important;} */
/*End Added by Pradip*/
.pagination{ margin-bottom:0!important;}
.QTbllist th:first-child::before, .LTtbllist th:first-child::after {
    display: none!important;
}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" >
    <%--  /*Added & Commented By Madhuri.K On 21-Aug-2024 For Loader Issues*/--%>
    <div class="" id="body-Qualifications"></div>
        <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-1 text-end graybg">
            <h5 class="pgtitle float-start">Qualification</h5>
            <a href="javascript:;" class="mainclearalllink" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" id="AdvanceFilterIcon" title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div>
            <div class="clearfix"></div>
        </div>

        <!--filter panel-->
        <div id="filterpanel" class="filterpanel collapse">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                <div class="cust_tabpanel">
                    <ul class="nav nav-tabs">
                        <li class="dropdown">
                            <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">My Filters </a>
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
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="checkFiltervalidationForQ();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFilter()">Apply</button>
                                </div>
                                <br />

                                <div class="row">
                                    <div class="col-sm-4 mb-3">
                                        <label>Qualification Name</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboQualificationFilterQualificationName">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">Ends With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Starts With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtQualificationFilterQualificationName", "txtQualificationFilterQualificationName", "form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:=" onkeypress='return OnDoublePress(event)'") %>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-4 mb-3">
                                        <label>Qualification Group</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboQualificationFilterQualificationGroupID">
                                                    <option value="=">=</option>
                                                    <option value="<>"><></option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                <%CommonFunctions.HTMLControls.DrawComboBox("txtQualificationFilterQualificationGroupID", "usp_Whizible2_Sel_tbl_PM_AllQualificationMaster",,, "class='form-select'",,,) %>
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

        <div class="container-fluid pt-1 pb-1 text-end">
            <button class="btn borderbtn mr-5 addbtn" data-bs-placement="bottom" title="Add Qualification" id="btnAddQ" onclick="addQualificationdetails()"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
            <button class="btn borderbtn deletebtn" id="DeleteQ" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete" onclick="DeleteQDetailsAfterConfirm()">Delete</button>
            <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Back to Resource Plan">Back</a>--%>
            <%--End of Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
        </div>

        <div class="content pt-0">
            <div class="Qtblouter">
                <table id="QListTbl" class="table table-bordered QTbllist" style="width: 100%;">
                    <thead>
                        <tr>
                            <th class="text-start">Qualification Name</th>
                            <th width="80">
                                <div class="custom_chckbox">
                                    <input id="RQListCheck0" class="chckHead" type="checkbox">
                                    <label for="RQListCheck0"></label>
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="tblQualificationsMain">
                    </tbody>
                </table>
            </div>
        </div>


        <div class="Resourcedetailpanel">
            <input type="hidden" id="hdnQ_UniqueIDTab" name="hdnQ_UniqueIDTab" value="">

            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li class="nav-item"><a href="#RQdetails" class="nav-link active" data-bs-toggle="tab" id="">Details</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">

                    <div id="RQGdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn btnyellow mr-5" id="" onclick="SaveQualificationDetails(0)">Save</button>
                            <button class="btn btnyellow mr-5" id="btnSaveQDetails" onclick="SaveQualificationDetails(1)">Save And Add</button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>

                        <div class="form-group mb-3">
                            <div class="row">
                            <div class="col-sm-4">
                                <label class="required">Qualification Name</label>
                                <%--<input type="text" class="form-control" value="QG name" />--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtQualificationName", "txtQualificationName", cssClass:="form-control", widthInPixel:=0, maxLength:=50) %>
                            </div>
                            <div class="col-sm-4">
                                <label class="required">Qualification Group</label>
                                <%CommonFunctions.HTMLControls.DrawComboBox("cboQG", "usp_Whizible2_Sel_tbl_PM_AllQualificationMaster",,, "class='form-select'", True,,) %>
                            </div>
                            </div>
                        </div>
                        

                    </div>

                </div>
            </div>
        </div>

        <!-- Save filter Modal start here-->
        <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="Issuesavrefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end required">Filter Name :</label>
                                            <span class="col-md-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtQFilterName", "txtQFilterName", "form-control",, maxLength:=50) %><%--changed maxlength 100 to 50--%>
                                                <div class="btnrow">
                                                    <button class="btn btnyellow float-start" id="btnSaveFilter" onclick="SaveQFilterDetails()">Save</button>
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

        <div class="modal custmodal fade" id="DeleteConfirmMModal" aria-hidden="true" data-bs-dismiss="modal">
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
                            <strong>Note:</strong> Qualification  which is in use cannot be deleted.<br />
                            <p id="showdeleterow"></p>
                        </div>

                        <div class="text-end">
                            <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
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
                                    <button class="btn btnyellow" data-bs-toggle="modal" data-original-title="" data-bs-dismiss="modal" title="" onclick="confirmDelete()">Yes</button>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
    
   <%--End of Added by Rutuja D on 6th July 2021--%>

    <!-- REQUIRED JS SCRIPTS -->
 <%--   <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
     <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
  <%--  <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/Plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>
        //Added By Madhuri.K On 21-Aug-2024 for Remove tooltip 
        $('body').on('click', function () {
            $('.tooltip').remove();
        });
        //Added By Riddhesh Patil on 07-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of  Added By Riddhesh Patil

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });


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

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").hover(function () {
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip('update');
        }); //added by pradip on 24-3-2023


        function addQualificationdetails() {
            $('#hdnQ_UniqueIDTab').val(0);
            $('#txtQualificationName').val("");
            $('#cboQG').val("");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $(".Qtblouter,.dataTables_scrollBody, .paginate_button, .custom_chckbox label, .addbtn, .backbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
        }



        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $(".Qtblouter,.dataTables_scrollBody, .custom_chckbox label, .addbtn, .paginate_button, .backbtn, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

        });


        var strUrl = '';
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

        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';

        var noOfRowsPerPage = 10;
        var DeleteRecord = "Please select at least one record to delete.";
        var DeleteConfirm = "Are you sure, you want to delete the selected records?";
        var NoDataFound = "No data found.";
        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';
        var qualificationsTable;
        $(document).ready(function () {
            $('.btn').tooltip({ trigger: 'hover' });
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';

            if (blnAddAccess == "False") {
                $("#btnAddQ").addClass("clsShowHide");
                $('#btnSaveQDetails').attr("disabled", true);

            }
            else {
                $("#btnAddQ").removeClass("clsShowHide");
                $('#btnSaveQDetails').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#DeleteQ").addClass("clsShowHide");
            }
            else {
                $("#DeleteQ").removeClass("clsShowHide");
            }

            GetMaximumItemsToShowInList();
            // GetQualifications(null);
            if (blnViewAccess == "True") {
                GetMaximumItemsToShowInList();
                GetMyQFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);
                    FilterApplied();

                } else {
                    GetQualifications(null);
                    FilterNotApplied();
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
            //Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
            BindPlaceholder("txtQualificationFilterQualificationGroupID", "Qualification Group");
            //End of Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
        });
        $(document).ready(function () {
            $('#example').DataTable({
                fixedHeader: {
                    header: true,
                    footer: true
                },
                paging: false,
                scrollY: 300,
                scrollX: true,
                scroller: true,
                bInfo: false,
                searching: false
            });
        });
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            qualificationsTable = $('#QListTbl').dataTable({
                "dtat": data,
               // "sScrollY": (0.5 * $(window).height()),
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": false, // modified by pradip on 23-3-2023
                "scrollResize": true,
                "scrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "lengthChange": false,
                "searching": false,
                "destroy": true,
                "bScrollCollapse": true,
                "bAutoWidth": true,
                "sScrollX": "100%",
                "sScrollXInner": "100%",
                //Added by imran on 19-08-2022
                pageLength: 10,
                //End of comment by imran on 19-08-2022
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1] }]// Added By Pradip on 20 July 2021
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
                    //alert(noOfRowsPerPage);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.error(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
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
        //datatable
        //$('#QListTbl').dataTable({
        //    //"ajax": '/api/data',
        //    "scrollY": true,
        //    "scrollX": true,
        //    //"scroller": true,
        //    "pageLength": 10,
        //    //"paging": false,
        //    "lengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "responsive": true
        //    //"scrollable":true,
        //    //"scrollCollapse": true
        //});

        //setTimeout(function () {
        //    $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        //}, 0);
        //$('#QListTbl').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        //function resizeSection() {
        //    var tblheight = $(window).height();
        //    commented by pradip on 23-3-23
        //    $('#QListTbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 220, "overflow-y": "auto" });
        //    $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        //}
        function resizeSection() {
            var tblheight = $(window).height();
            $('#QListTbl_wrapper .dataTables_scroll').css({ 'height': tblheight - 205, "overflow-y": "auto" });
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });
        $("#filterpanel").on("show.bs.collapse", function () {
            $(".mainclearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".mainclearalllink").hide();
        });

        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var allPages = qualificationsTable.fnGetNodes();
            var checked = $(this).is(':checked');
            if (checked) {
                $('input[type="checkbox"]', allPages).prop('checked', true);
                var rows = $("#QListTbl").dataTable().fnGetNodes();
                for (var i = 0; i < rows.length; i++) {
                    SelectedQID.push(parseInt($(rows[i]).find("#hdn_QualificationID").val()));
                }

            } else {
                $('input[type="checkbox"]', allPages).prop('checked', false);
                SelectedQID = [];
            }
        });

        // Changing state of CheckAll checkbox
        //$(".chcktbl").click(function () {

        //    if ($(".chcktbl").length == $(".chcktbl:checked").length) {
        //        $(".chckHead").prop("checked", true);
        //    } else {
        //        $(".chckHead").removeAttr("checked");
        //    }

        //});

        function editQualification() {
            $('#tblQualificationsMain').on('click', '.BGdetalilink', function () {

                var $row = $(this).closest("tr");
                $tds = $row.find("td");
                var hdnQId = $row.find('#hdn_QualificationID').val();
                var hdnQGID = $row.find('#hdn_QGID').val();
                // alert(hdnQGID);
                $('#hdnQ_UniqueIDTab').val(hdnQId);
                $.each($tds, function (index, obj) {
                    var hiddenField = $(this).find("input[type='hidden']").val();
                    if (hiddenField != 'undefined' && hiddenField != null) {
                        var eventId = hiddenField;
                        // $('#hdn_ParameterID').html(eventId);

                    }

                    if (index == 0) {
                        $('#txtQualificationName').val($(this).text().trim());

                    }
                    if (index == 1) {
                        $('#cboQG').val(hdnQGID);

                    }
                    //$(".dataTables_scrollBody").css("height", "auto!important");
                    $(".Resourcedetailpanel").show();
                    $('html,body').animate({
                        scrollTop: $(".Resourcedetailpanel").offset().top - 60
                    }, 'slow');
                    //used for disable grid
                    $(".Qtblouter, .dataTables_scrollBody,.custom_chckbox label, .paginate_button, .addbtn, .backbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
                });
            });
        }
        //$(".BGdetalilink").click(function () {
        //    $(this).closest('tr').addClass('rowhiglight');
        //});

        var SelectedQID = [];
        function GetSelectedQualifications(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedQID.push(parseInt(row.find('#hdn_QualificationID').val()));
            }
            else {
                if (SelectedQID != 'undefined' && SelectedQID.length > 0) {
                    var removeQualification = row.find('#hdn_QualificationID').val();
                    SelectedQID.remove(parseInt(removeQualification));
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

        function DeleteQDetailsAfterConfirm() {
            var strHTML = "";
            var selectedQQualificationID = SelectedQID.toString();
            if (selectedQQualificationID.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_Qualification/DeleteQualifications',
                    type: "POST",
                    data: JSON.stringify(selectedQQualificationID),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#body-QualificationGroup");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedQQualificationID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedQQualificationID) ? selectedQQualificationID : JSON.stringify(selectedQQualificationID)));
                        }
                    },
                    success: function (data) {
                        StopAjaxLoader("#body-Qualifications");
                        GetQualifications();
                        //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        //strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
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
                            if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "OK") {  //200
                            GetQualificationGroup();
                            $('#DeleteConfirmMModal').modal('hide');
                        }

                        StopAjaxLoader("#body-Qualifications");
                        $('#DeleteConfirmMModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedQGroupID = [];
            selectedQQualificationID = "";
        }
        function checkUncheck() {
            if (qualificationsTable.$('input:checked').length == qualificationsTable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
            }
        }
        function GetQualifications(QFilterParms) {
            //Added by imran on 19-08-2022
            if (QFilterParms == null || QFilterParms == "null" || QFilterParms == "") {
                var QFilterParms =
                {
                    QWhereClause: ""
                }
            }
            //End of comment by imran on 19-08-2022
            SelectedQID = [];
            var strHTML = "";
            StartLoader("#body-Qualifications");
            $.ajax({
                url: strUrl + '/api/RM_Qualification/GetQualifications',
                type: "POST",
                data: JSON.stringify(QFilterParms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (QFilterParms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(QFilterParms) ? QFilterParms : JSON.stringify(QFilterParms)));
                    }
                },
                success: function (data) {
                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            if (blnEditAccess == "True") {
                                strHTML += '<tr><td class="text-start"><a href="javascript:;" class="BGdetalilink" onclick="editQualification()"</a> <input type="hidden" name="hdn_QualificationID" id="hdn_QualificationID" value= ' + obj.QualificationID + '>' + obj.QualificationName + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedQualifications(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div><input type="hidden" name="hdn_QGID" id="hdn_QGID" value=' + obj.QualificationGroupID + '></td></tr>';
                            }
                            else {
                                strHTML += '<tr><td class="text-start"> <input type="hidden" name="hdn_QualificationID" id="hdn_QualificationID" value= ' + obj.QualificationID + '>' + obj.QualificationName + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedQualifications(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div><input type="hidden" name="hdn_QGID" id="hdn_QGID" value=' + obj.QualificationGroupID + '></td></tr>';
                            }

                        });
                    }

                    $('#QListTbl').dataTable().fnDestroy();
                    $("#tblQualificationsMain").html(strHTML);
                    LoadPagination(data);
                    StopAjaxLoader("#body-Qualifications");
                    //$(".chckHead").prop("checked", false);
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-Qualifications");
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
        //Added By Riddhesh Patil on 07-NOV-2022 
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
		//End of  Added By Riddhesh Patil

        function checkValidation() {
            if ($("#txtQualificationName").val().trim() == undefined || $("#txtQualificationName").val().trim() == "" || $("#txtQualificationName").val().trim() == null) {
                $("#txtQualificationName").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Qualification Name should not be left blank");
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 07-NOV-2022 

            //else if ($("#txtQualificationName").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtQualificationName").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Qualification  Name cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
            
            else if (checkSpecialCharacter($("#txtQualificationName").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Qualification Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtQualificationName").focus();

                //Added by Aditya J. on 19-11-2024
                validateflag = false;
                //End of Added by Aditya J. on 19-11-2024

                chkval = 1;
                return chkval;
            }
			//End of Commnet Added By Riddhesh Patil
            else if ($("#cboQG").val() == undefined || $("#cboQG").val() == "" || $("#cboQG").val() == null || $("#cboQG").val() == 0) {
                $("#cboQG").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Qualification Group  should not be left blank");
                return false;
            }

            else {
                validateflag = true;
                return true;
            }
        }

        function onClose() {
            $('#hdnQG_UniqueIDTab').val(0);
            $('#txtQualificationName').val("");
            $("#cboQG").val("");
        }
        var validateflag
        function SaveQualificationDetails(isFromSaveAndclick) {
            checkValidation();
            if (validateflag == true) {
                var QualificationID = $("#hdnQ_UniqueIDTab").val();
                var QualificationName = $("#txtQualificationName").val().replace(/'/g, "''");
                var QualificationGroupID = $("#cboQG").val();

                var Details = {
                    QualificationID: QualificationID,
                    QualificationGroupID: QualificationGroupID > 0 ? QualificationGroupID : 0,
                    QualificationName: QualificationName,
                    CreatedBy: encodeURI(UserName)

                };
                $.ajax({
                    url: strUrl + '/api/RM_Qualification/SaveQualification',
                    method: 'POST',
                    data: JSON.stringify(Details),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Details) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Details) ? Details : JSON.stringify(Details)));
                        }
                    },
                    success: function (data) {
                        GetQualifications();
                        if (isFromSaveAndclick == 0) {
                            if (data == "Qualification already exist.") {
                                $(".Qtblouter,.backbtn,.addbtn,.deletebtn,.filter,.mainclearalllink,.custom_chckbox label").addClass("DisableContent");

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                //onClose();
                                $(".Qtblouter,.backbtn,.addbtn,.deletebtn,.filter,.mainclearalllink,.custom_chckbox label").removeClass("DisableContent");

                                $(".Resourcedetailpanel").hide();
                                $('#Resourcedetailpanel').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                            }
                        }
                        else {
                            if (data == "Qualification already exist.") {
                                $(".Qtblouter,.backbtn,.addbtn,.deletebtn,.filter,.mainclearalllink,.custom_chckbox label").addClass("DisableContent");
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                onClose();
                                $(".Qtblouter,.backbtn,.addbtn,.deletebtn,.filter,.mainclearalllink,.custom_chckbox label").addClass("DisableContent");
                                //$(".Resourcedetailpanel").hide();
                                $("#txtQualificationName").focus();
                                $("#hdnQ_UniqueIDTab").val(0);
                                $('#Resourcedetailpanel').modal('hide');
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
                            if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                            //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            //CurrentGRPTabObject.GrpManager = 'false';
                            GetQualifications();
                            // CurrentGRPTabObject.GrpManager = 'true';
                            StopAjaxLoader("#body-Qualifications");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        StopAjaxLoader("#body-Qualifications");
                        //if (isFromSaveAndclick == 0) {
                        //    $('#Resourcedetailpanel').modal('hide');
                        //}
                    }
                })
            } else {
                return false;
            }
        }
        function OnDoublePress(e) {
            var keyCode = e.which ? e.which : e.keyCode
            var flag = true;
            if (keyCode == 34 || keyCode == 44) {
                flag = false;
            }
            return flag;
        }

        //filter
        function GenerateQGBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();

                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();

                    if (strvalue != "" && strvalue != undefined) {
                        //Added By Rutuja D. on 28 July 2021
                        strvalue = strvalue.replace(/"/g, '""');
                        //End of Added By Rutuja D. on 28 July 2021

                        if (strqtext != "") strqtext += " AND ";
                        if (strOp == "Contains") {

                            strqtext += filterField[i] + " LIKE ";
                            //strqtext += " ''%" + strvalue + "%''";
                            //Commented & Added By Rutuja D. on 28 July for Filter issue
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
                            //Commented & Added By Rutuja D. on 28 July for Filter issue
                            //strqtext += ' "%' + strvalue + '"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "%' + strvalue + '"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "%' + strvalue + '"';
                            }
                            //End of Commented & Added By Rutuja D. on 28 July for Filter issue
                        }
                        else if (strOp == "Exact Word") {
                            strqtext += filterField[i] + " = ";
                            //strqtext += " ''" + strvalue + "''";
                            strqtext += ' "' + strvalue + '"';
                        }
                        else if (strOp == "Not Contains") {
                            strqtext += filterField[i] + " ";
                            //strqtext += " NOT LIKE ''%" + strvalue + "%''";
                            //Commented & Added By Rutuja D. on 28 July for Filter issue
                            //strqtext += ' NOT LIKE "%' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' NOT LIKE "%' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                            strqtext += ' NOT LIKE "%' + strvalue + '%"';
                            }                               
                            //End of Commented & Added By Rutuja D. on 28 July for Filter issue
                        }
                        else if (strOp == "Starts With") {
                            strqtext += filterField[i] + " LIKE ";
                            // strqtext += " ''" + strvalue + "%''";
                            //Commented & Added By Rutuja D. on 28 July for Filter issue
                            //strqtext += ' "' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "' + strvalue + '%"';
                            }
                            //End of Commented & Added By Rutuja D. on 28 July for Filter issue
                        }
                        else {

                            strqtext += filterField[i] + " ";
                            if ($.isNumeric(strvalue) == false) {
                                strqtext += strOp + " ''" + strvalue + "''";
                            }
                            else {
                                strqtext += strOp + " " + strvalue + "";
                                // strqtext += strOp + ' "' + strvalue + '"';
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

            for (var i = 0; i < arr.length; i++) {
                //alert(arr[i]);
            }

            var arrFields = currWhereClause.split(" ");
            arrFields = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);
            if (arrFields[0] == "QualificationName") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboQualificationFilterQualificationName", "txtQualificationFilterQualificationName");
            }
            if (arrFields[0] == "QualificationGroupID") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboQualificationFilterQualificationGroupID", "txtQualificationFilterQualificationGroupID");
            }
        }
        function setFilterComboValue(fieldName, fieldValue, flag) {
            //if (flag == undefined) {
            //    $("#" + fieldName).removeClass("selectpicker");
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
                if (OpComboName == "txtQualificationFilterQualificationGroupID") {
                    setFilterComboValue(OpComboName, "=");
                }
                if (OpComboName == "txtQualificationFilterQualificationName") {
                    setFilterComboValue(OpComboName, "Exact Word");
                }
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
            //  $("#" + ValueComboName).val(currValue);
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }
        function ClearFilterDetails(flag) {
            if ($("#cboQualificationFilterQualificationName").val() != "Contains") {
                setFilterComboValue("cboQualificationFilterQualificationName", "Contains");
            }
            if ($("#txtQualificationFilterQualificationName").val() != "") {
                $("#txtQualificationFilterQualificationName").val("");
            }
            if ($("#cboQualificationFilterQualificationGroupID").val() != "=") {
                setFilterComboValue("cboQualificationFilterQualificationGroupID", "=");
            }
            if ($("#txtQualificationFilterQualificationGroupID").val() != "") {
                $("#txtQualificationFilterQualificationGroupID").val("");
            }
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
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
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
        function OpenBasicFilter() {
            //Start Script for edit basic filter           
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
            //End Script for edit basic filter
        }
        function ApplyFilter() {
            var filterFlag = true;

            if ($('#txtQualificationFilterQualificationName').val() == "" && ($('#txtQualificationFilterQualificationGroupID').val() == "" || $('#txtQualificationFilterQualificationGroupID').val() == 0)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Enter at least one filter value');
                filterFlag = false;
                return false;
            }
            if (filterFlag == true) {
                currentFilterID = 0;
                var filter = "";
                //if (filterwhereclause != 'undefined' && filterwhereclause != null) {
                var AllQGFilter = ["QualificationName", "QualificationGroupID"];
                var filterWhereClause2 = GenerateQGBasicFilterQuery("Qualification", AllQGFilter);
                // var filterWhereClause = (filterWhereClause2.replace(/'/g, "''")).replace(/"/g, "\''");
                var filterWhereClause = (filterWhereClause2).replace(/"/g, "\'");
                //filterWhereClause = (filterWhereClause2.replace(/'/g, "''")).replace(/"/g, "\''");
                //Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                //filter = { UniqueID: '0', QWhereClause: encodeURI(filterWhereClause) }
                filter = { UniqueID: '0', QWhereClause: encodeURIComponent(filterWhereClause) }
                //End of Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                FilterApplied();
                //}

                //SaveBGFilterDetails();
                GetQualifications(filter);
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");

            }

        }
        function GetQualificationDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                // var whereClauseFormated = whereClause.replace(/'/g, "\''");
                //Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                //filter = { UniqueID: '0', QWhereClause: encodeURI(whereClause) };
                filter = { UniqueID: '0', QWhereClause: encodeURIComponent(whereClause) };
                //End of Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
            }
            GetQualifications(filter);
        }
        //FILTER VALIDATION
        function checkFiltervalidationForQ() {
            var QGname = $("#txtQualificationFilterQualificationName").val() == "" ? null : $("#txtQualificationFilterQualificationName").val();
            var QGId = $("#txtQualificationFilterQualificationGroupID").val() == "" ? null : $("#txtQualificationFilterQualificationGroupID").val();
            //alert(CRTname);
            if ((QGname == null || QGname == 'undefined') && (QGId == null || QGId == 'undefined' || QGId == 0)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select filter');
                $('#Issuesavefilter').modal('hide');
            }
            else {
                $('#Issuesavefilter').modal('show');
            }
        }

        var savedFilterName = "";
        function SaveQFilterDetails() {
            var fltFilterName = $("#txtQFilterName").val();
            if (fltFilterName == "") {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name.');

                $("#txtQFilterName").focus();
            }
               //Commented and Added By Riddhesh Patil on 12-NOV-2022 
            //else if (fltFilterName.trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Filtername cannot contain any of these /\:*?<>|,"+- characters.');

            //    $("#txtQFilterName").focus();
            //}
            else if (checkSpecialCharacter(fltFilterName.trim(), WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtQFilterName").focus();

            }
			//End of Comment and Added By Riddhesh Patil
            else {
                var filterExists = 0;
                var AllQGFilter = ["QualificationName", "QualificationGroupID"];
                //var isActiveFilter = 'True';/// $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GenerateQGBasicFilterQuery("Qualification", AllQGFilter);
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
                            $('#Issuesavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            GetMyQFilter(0);
                            ApplyFilter();
                            FilterApplied();

                            savedFilterName = fltFilterName;
                            $("#txtQFilterName").val('');
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

        function GetMyQFilter(flag) {
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

        function ExistQFilter(filtername) {

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
                            GetQualifications(null);
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyQFilter(0);
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
                        $("#txtQFilterName").val(currentFilterName);
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

        function ApplySavedFilter(FilterID, isDefault,isFromDefault) {
            //Changed  by mahesh on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {

                GetQualificationDetails(null);
                GetMyQFilter(isDefault);
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
                            GetQualificationDetails(Querytext);
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
                        if (currentDefaultFilterID > 0) {
                            FilterApplied();
                        }

                        if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                            GetMyQFilter(0);
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
                        ApplySavedFilter(FilterID, 2, true);//changed by mahesh on 21 july 2021
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        // alertify.success('Default');
                        // FilterNotApplied();
                        ApplySavedFilter(FilterID, 3, true);//changed by mahesh on 21 july 2021
                        alertify.success('Default Filter Is Successfully Removed!');
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        FilterNotApplied();
                    }

                    GetMyQFilter(0);
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
        $(".mainclearalllink").click(function () {
            $(".filter").removeClass("active");
            //$('.filterpanel').collapse('toggle');                

            FilterNotApplied();
            $(".filter").removeClass("active");
            if ($('.filterpanel').hasClass("in")) {
                $('.filterpanel').removeClass("in");
            }
            $(".clsHideTooltip").each(function () {
                $(this).attr("data-original-title", "Apply filter");
            });
            $('[data-bs-toggle="tooltip"]').tooltip();

            fltPersonResponsible = "";
            currentappliedfilter = 0;
            currentFilterID = 0;
            currentappliedfilterclause = "";
            ClearFilterDetails("");
            GetQualificationDetails(null);
        });
        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtQFilterName').val("");
            }
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
    </script>

</body>

</html>
