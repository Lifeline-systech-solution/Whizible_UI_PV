<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_InfraGroup.aspx.vb" Inherits="PbNIT.RM_InfraGroup" %>

<!DOCTYPE html>
<html> 
          <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head runat="server">
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
	<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
 --%>   <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
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

        #basicfilters label {
            line-height: 18px;
            text-align: right;
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

        .filterpanelbody .form-group{display:flex}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="">
    <%--  /*Added & Commented By Madhuri.K On 21-Aug-2024 For Loader Issues*/--%>
     <div class=""  id="bodyInfraGroup"></div>
    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-0 text-end graybg" style="display:table">
            <h5 class="pgtitle float-start">Infrastructure Group</h5>
            <a href="javascript:;" class="mainclearalllink" onclick="closeFilterPanel()" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
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
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="checkFiltervalidationForIG();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFilter()">Apply</button>
                                </div>
                                <br />

                                <div class="row">
                                    <div class="col-sm-6 form-group">
                                        <label class="col-sm-4">Infrastructure Group Name</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboIGFilterInfraGroupName">
                                                        <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtIGFilterInfraGroupName", "txtIGFilterInfraGroupName", "form-control", widthInPixel:=0, maxLength:=50) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6 form-group">
                                        <%-- Commented And Added By Reshma Chavan on 8th Dec 2021 For issueid-31733--%>
                                        <%--<label class="col-sm-4">Status</label>--%>
                                        <label class="col-sm-4">Active</label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboIGFilterStatus">
                                                        <option value="=">=</option>
                                                        <option value="<>"><></option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <select class="form-control input-sm" id="txtIGFilterStatus">
                                                        <%-- Commented And Added By Reshma Chavan on 8th Dec 2021 For issueid-31733--%>
                                                        <%--<option value="">Select Status</option>
                                                        <option value="1">Active</option>
                                                        <option value="0">Inactive</option>--%>
                                                        <option value="">Select Active</option>
                                                        <option value="1">Yes</option>
                                                        <option value="0">No</option>
                                                    </select>
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


            </div>
        </div>
        <!--end filter panel-->

        <div class="container-fluid pt-1 pb-1 text-end">
            <button class="btn borderbtn mr-5 addbtn" id="btnAddIG" onclick="addQGdetail()"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
            <button class="btn borderbtn deletebtn" id="btnDeleteIG" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete" onclick="DeleteInfraGroupsDetailsAfterConfirm()">Delete</button>
        </div>

        <div class="content pt-0">
            <div class="IGtblouter">
                <table id="InfraTypeListTbl" class="table table-bordered" style="width: 100%;">
                    <thead>
                        <tr>
                            <th class="text-start">Infrastructure Group Name</th>
                            <%--<th>Status</th>--%>
                            <th>Active</th>
                            <th width="50">
                                <div class="custom_chckbox">
                                    <input id="QGListCheck0" class="chckHead" type="checkbox">
                                    <label for="QGListCheck0" style="margin-left: 0px;"></label>
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="tblInfraGroup">
                    </tbody>
                </table>
            </div>
        </div>


        <div class="Resourcedetailpanel">
            <input type="hidden" id="hdnIG_UniqueID" name="hdnIG_UniqueID">

            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li><a href="#RBGdetails" class="active" data-bs-toggle="tab" id="">Details</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">

                    <div id="RBGdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn btnyellow mr-5" id="" onclick="SaveInfraGroups(0);">Save</button>
                            <button class="btn btnyellow mr-5" id="btnSaveIGDetails" onclick="SaveInfraGroups(1);">Save And Add</button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                        <div class="row">
                            <div class="col-sm-4 form-group">
                                <label class="required">Infrastructure Group Name</label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtInfraGroupName", "txtInfraGroupName", cssClass:="form-control", widthInPixel:=0, maxLength:=50) %>
                            </div>
                            <div class="col-sm-4 form-group">
                                <label class="">&nbsp;</label>
                                <div class="custom_chckbox">
                                    <input id="stsCheck" class="chcktbl" type="checkbox" checked>
                                    <label for="stsCheck">Active</label>
                                </div>
                            </div>

                        </div>

                    </div>

                </div>
            </div>
        </div>

        <!-- Save filter Modal start here-->
        <div class="modal custmodal Igsavefilter_filter fade" id="Igsavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modalsmall ui-draggable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="Igsavefilterfilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end required">Filter Name :</label>
                                            <span class="col-md-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtIGFilterName", "txtIGFilterName", "form-control",, maxLength:=100, ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                                                <br />
                                                <div class="btnrow">
                                                    <button class="btn btnyellow float-start savefilter" id="btnSaveFilter" onclick="SaveIGFilterDetails()">Save</button>
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
   	<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
   <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
   --%> <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
   <%-- <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>
<%--     <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

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
                    <div class="notebox">
                        <%--<strong>Note:</strong> Infra Group which is in use can not be deleted.<br />--%>
                        <strong>Note:</strong> Infrastructure Group which is in use can not be deleted.<br />
                        <p id="showdeleterow"></p>
                    </div>

                    <div class="text-end">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script>
        //Added By Rehan C To check validation for Special characters  on 07th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        function addQGdetail() {
            $('#hdnIG_UniqueID').val(0);
            $('#txtInfraGroupName').val("");
            $('#stsCheck').prop('checked', true);
            //Added By Reshma Chavan on 8th Dec 2021 issueID-31732
            $('#stsCheck').prop('disabled', true);
            $(".custom_chckbox label").css("pointer-events", "none");
            $(".custom_chckbox").css("cursor", "no-drop");
            //End of Added By Reshma Chavan on 8th Dec 2021
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $(".IGtblouter .dataTables_scrollBody, .backbtn,.addbtn, .paginate_button, .deletebtn, .filter, .mainclearalllink, #InfraTypeListTbl").addClass("DisableContent").parent().css("cursor", "no-drop");
            $(".table").resize();
        }

        function editQG() {
            $('#tblInfraGroup').on('click', '.BGdetalilink', function () {
                //Added By Reshma Chavan on 5th jan 2021 For IssueID-31732
                 $('#stsCheck').prop('disabled', false);
                 $(".custom_chckbox label").css("pointer-events", "auto");
                 $(".custom_chckbox").css("cursor", "auto");
                //End of Added By Reshma Chavan on 5th jan 2021 For IssueID-31732
                var $row = $(this).closest("tr");
                $tds = $row.find("td");
                var hdnIGroupId = $row.find('#hdn_InfraGroupId').val();
                $('#hdnIG_UniqueID').val(hdnIGroupId);
                $.each($tds, function (index, obj) {
                    var hiddenField = $(this).find("input[type='hidden']").val();
                    if (hiddenField != 'undefined' && hiddenField != null) {
                        var eventId = hiddenField;
                        // $('#hdn_ParameterID').html(eventId);

                    }

                    if (index == 0) {
                        $('#txtInfraGroupName').val($(this).text().trim());

                    }
                    if (index == 1) {
                        $('#stsCheck').html($(this).text());
                        //if ($(this).text() == 'Active') {
                        if ($(this).text() == 'Yes') {
                            $('#stsCheck').prop('checked', true);
                        }
                        else {
                            $('#stsCheck').prop('checked', false);
                        }

                    }

                    //$(".dataTables_scrollBody").css("height", "auto!important");
                    $(".Resourcedetailpanel").show();
                    $('html,body').animate({
                        scrollTop: $(".Resourcedetailpanel").offset().top - 60
                    }, 'slow');
                    //used for disable grid
                    $(".IGtblouter .dataTables_scrollBody, .paginate_button, .backbtn, .addbtn, .deletebtn, .filter, .mainclearalllink, #InfraTypeListTbl").addClass("DisableContent").parent().css("cursor", "no-drop");
                    //$(".table").resize();
                });
            });
        }
        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $(".IGtblouter,.dataTables_scrollBody, .paginate_button, .backbtn, .addbtn, .deletebtn, .filter, .mainclearalllink, #InfraTypeListTbl").removeClass("DisableContent").parent().css("cursor", "auto");
            //$(".table").resize();

        });
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

        var noOfRowsPerPage = 10;
        var DeleteRecord = "Please select at least one record to delete.";
        var DeleteConfirm = "Are you sure, you want to delete the selected records?";
        var NoDataFound = "No data found.";
        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';
        var strUrl = "";

        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var InfraGrouptable;
        $(document).ready(function () {

            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            GetMaximumItemsToShowInList();
            if (blnAddAccess == "False") {
                DisableEnableBtn(1)
            }
            else {
                DisableEnableBtn(0)
            }
            if (blnDeleteAccess == "False") {
                $("#btnDeleteIG").addClass("clsShowHide");

            }
            else {
                $("#btnDeleteIG").removeClass("clsShowHide");
            }

            if (blnViewAccess == "True") {
                GetMyIGFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);

                } else {
                    GetInfraGroups(null);
                    FilterNotApplied();
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
        });
        function DisableEnableBtn(isTrue) {

            if (isTrue == '1') {
                $("#btnAddIG").addClass("clsShowHide");
                $('#btnSaveIGDetails').attr("disabled", true);
            } else {

                $("#btnAddIG").removeClass("clsShowHide");
                $('#btnSaveIGDetails').attr("disabled", false);
            }

        }
        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);
        $('#InfraTypeListTbl').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('.IGtblouter .dataTables_scrollBody').css({ 'height': tblheight - 240, "overflow-y": "fixed" });

            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
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
            var allPages = InfraGrouptable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#InfraTypeListTbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedEmpID.push(parseInt($(rows[i]).find("#hdn_InfraGroupId").val()));
                    }

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedEmpID = [];
                }
            }
        });
        var SelectedEmpID = [];
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
                $(".chckHead").prop("checked", false);
            }
        }
        function onClose() {
            $('#hdnIG_UniqueID').val(0);
            $('#txtInfraGroupName').val("");
        }

        //Added By Rehan C To check validation for Special characters  on 07th Nov 2022
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
            InfraGrouptable = $('#InfraTypeListTbl').dataTable({
                "dtat": data,
                "sscrolly": (0.6 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                "lengthChange": false,
                "searching": false,
                //Added by imran on 19-08-2022
                pageLength: 10,
                //End of comment by imran on 19-08-2022
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [2] }]// Added By Pradip on 20 July 2021
            });

        }
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
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (xhr, ajaxOptions, thrownError) {
                //    if (ajaxOptions == "error") {
                //        console.log(thrownError);
                //        alertify.set('notifier', 'position', 'top-right');
                //        alertify.error(xhr.responseJSON.Message);
                //    }
                //    else {
                //        alertify.set('notifier', 'position', 'top-right');
                //        alertify.error(thrownError);
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
        //Get InfraGroups
        function GetInfraGroups(IGFilterParms) {
            //console.log("IGFilterParms", IGFilterParms);
            //Added by imran on 19-08-2022
            if (IGFilterParms == null || IGFilterParms == "null" || IGFilterParms == "") {
                var IGFilterParms =
                {
                    IGWhereClause: ""
                }
            }
            //End of comment by imran on 19-08-2022
            SelectedEmpID = [];
            var strHTML = "";
            StartLoader("#bodyInfraGroup");
            $.ajax({
                url: strUrl + '/api/RM_InfraGroup/GetInfraGroups',
                type: "POST",
                data: JSON.stringify(IGFilterParms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (IGFilterParms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(IGFilterParms) ? IGFilterParms : JSON.stringify(IGFilterParms)));
                    }
                },
                success: function (data) {
                    var IGList = data;
                    if (IGList.length > 0) {
                        $.each(IGList, function (index, obj) {
                            var strActive = '';
                            if (obj.Status === true) {
                                //strActive = 'Active'
                                strActive = 'Yes'
                            } else {
                                //strActive = 'Inactive'
                                strActive = 'No'
                            }
                            if (blnEditAccess == "True") {
                                strHTML += '<tr><td class="text-start"> <a href="javascript:;" class="BGdetalilink" onclick="editQG()"</a><input type="hidden" name="hdn_InfraGroupId" id="hdn_InfraGroupId" value= ' + obj.InfraGroupId + '>' + obj.InfraGroupName + '</td><td class="text-center">' + strActive + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedInfraGroup(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                            }
                            else {
                                strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_InfraGroupId" id="hdn_InfraGroupId" value= ' + obj.InfraGroupId + '>' + obj.InfraGroupName + '</td><td class="text-center">' + strActive + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedInfraGroup(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                            }
                        });
                    }
                    $('#InfraTypeListTbl').dataTable().fnDestroy();
                    $("#tblInfraGroup").html(strHTML);
                    LoadPagination(data);
                    StopAjaxLoader("#bodyInfraGroup");
                    $(".chckHead").prop("checked", false);
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyInfraGroup");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyInfraGroup");
                }
                 //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })

        }
        function checkValidation() {
            var InfraGroupName = $("#txtInfraGroupName").val();
           /* debugger*/
            if ($("#txtInfraGroupName").val().trim() == undefined || $("#txtInfraGroupName").val().trim() == "" || $("#txtInfraGroupName").val().trim() == null) {
                $("#txtInfraGroupName").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Infrastructure Group Name' should not left blank.");
                return false;
            }
            //Added By Rehan C To check validation for Special characters  on 07th Nov 2022
            if (checkSpecialCharacter(InfraGroupName, WebConfigSpecialCharacters) == true) {
               // checkval = 1;
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Infrastructure Group Name Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtInfraGroupName").focus();
                return false;
            }
            //else if ($("#txtInfraGroupName").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtInfraGroupName").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Infrastructure Group Name can not contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
            else {
                validateflag = true;
                return true;
            }
        }

        var validateflag
        function SaveInfraGroups(isFromSaveAndclick) {
            
            checkValidation();
            if (validateflag == true) {
                $("#InfraTypeListTbl").removeClass("DisableContent"); //Added By Rehan C Page Load Issue on 16th Feb 2023
                var infraGroupID = $("#hdnIG_UniqueID").val();
                var infraGroup = $("#txtInfraGroupName").val().replace(/'/g, "''");
                var status = $("#stsCheck").is(":checked");
                if (status == true) {
                    status = 1;
                }
                else {
                    status = 0;
                }
                var Details = {
                    InfraGroupId: infraGroupID > 0 ? infraGroupID : 0,
                    InfraGroupName: infraGroup,
                    Status: status,
                    CreatedBy: encodeURI(UserName)

                };
                //console.log("Details", Details);
                $.ajax({
                    url: strUrl + '/api/RM_InfraGroup/SaveInfraGroupDetails',
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
                      
                        if (isFromSaveAndclick == 0) {
                            //if (data == "Infra Group already exist.") {                          
                            if (data == "Infrastructure Group already exist.") {                          
                                $(".IGtblouter,.backbtn, .addbtn, .deletebtn, .filter,.mainclearalllink").addClass("DisableContent");

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                
                            }
                            else {
                                $(".IGtblouter,.backbtn, .addbtn, .deletebtn, .filter,.mainclearalllink").removeClass("DisableContent");

                                $(".Resourcedetailpanel").hide();
                                $('#Resourcedetailpanel').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);                               
                                //Added By Reshma Chavan on 8th Dec 2021
                                $('#stsCheck').prop('disabled', false);
                                $(".custom_chckbox label").css("pointer-events", "auto");
                                $(".custom_chckbox").css("cursor", "auto");
                                //End of Added By Reshma Chavan on 8th Dec 2021 
                                GetInfraGroups();
                            }
                        }
                        else {
                            //if (data == "Infra Group already exist.") {
                            if (data == "Infrastructure Group already exist.") {
                                $(".IGtblouter,.backbtn, .addbtn, .deletebtn, .filter,.mainclearalllink").addClass("DisableContent");

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                
                                $('#txtInfraGroupName').focus();
                            }
                            else {
                                onClose();
                                $(".IGtblouter,.backbtn, .addbtn, .deletebtn, .filter,.mainclearalllink").addClass("DisableContent");

                                $('#Resourcedetailpanel').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);                               
                                //Added By Reshma Chavan on 8th Dec 2021
                                $('#stsCheck').prop('disabled', false);
                                $(".custom_chckbox label").css("pointer-events", "auto");
                                $(".custom_chckbox").css("cursor", "auto");
                                //End of Added By Reshma Chavan on 8th Dec 2021
                                GetInfraGroups();
                                addQGdetail();
                                $('#txtInfraGroupName').focus();
                            }
                        }
                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (xhr, ajaxOptions, thrownError) {
                    //    if (ajaxOptions == "error") {
                    //        console.log(thrownError);
                    //        alertify.set('notifier', 'position', 'top-right');
                    //        alertify.error(xhr.responseJSON.Message);
                    //    }
                    //    else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                    //        GetInfraGroups();
                    //        StopAjaxLoader("#bodyInfraGroup");
                    //    }
                    //    else {
                    //        alertify.set('notifier', 'position', 'top-right');
                    //        alertify.error(thrownError);

                    //    }
                    //    StopAjaxLoader("#bodyInfraGroup");

                    //}
                     error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyInfraGroup");
                    }
                     //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                })


            } else {
                return false;
            }

        }
        function DeleteInfraGroupsDetailsAfterConfirm() {
            var strHTML = "";
            var selectedInfraGroupID = SelectedEmpID.toString();
            if (selectedInfraGroupID.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_InfraGroup/DeleteInfraGroupDetails',
                    type: "POST",
                    data: JSON.stringify(selectedInfraGroupID),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#bodyInfraGroup");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedInfraGroupID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedInfraGroupID) ? selectedInfraGroupID : JSON.stringify(selectedInfraGroupID)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //}

                        StopAjaxLoader("#bodyInfraGroup");
                        GetInfraGroups();
                        //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        //strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                        //End of Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterow').html(strHTML);
                        $('#DeleteConfirmMModal').modal('show');
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                          if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                        else if (xhr.statusText == "OK") {  //200
                            GetInfraGroups();
                            $('#DeleteConfirmMModal').modal('hide');
                            //alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify("Deleted");
                        }

                        StopAjaxLoader("#bodyInfraGroup");
                        $('#DeleteConfirmMModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedEmpID = [];
            selectedInfraGroupID = "";
        }

        ///Start Filter coding
        function ApplyFilter() {
            var filterFlag = true;
            var grpName = $("#txtIGFilterInfraGroupName").val() == "" ? null : $("#txtIGFilterInfraGroupName").val();
            var status = $("#txtIGFilterStatus").val() == "" ? null : $("#txtIGFilterStatus").val();
            if ((grpName == null || grpName == 'undefined' || grpName == ' ') && (status == null || status == 'undefined' || status == ' ')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                filterFlag = false;
                return false;
            }
            if (filterFlag == true) {
                currentFilterID = 0;
                var filter = "";
                var AllIGFilter = ["InfraGroupName", "Status"];
                //var isActiveFilter = $('#chkDTFilterActive').is(":checked");
                var filterWhereClause2 = GenerateIGBasicFilterQuery("IG", AllIGFilter);
                console.log("filterWhereClause2", filterWhereClause2);
                filterWhereClause = filterWhereClause2.replace(/"/g, "\'");
                filter = { UniqueID: '0', IGWhereClause: encodeURIComponent(filterWhereClause) }
                console.log("filter", filter);
                FilterApplied();

                GetInfraGroups(filter);
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
            for (var i = 0; i < arr.length; i++) {
                //alert(arr[i]);
            }

            var arrFields = currWhereClause.split(" ");
            arrFields = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);
            if (arrFields[0] == "InfraGroupName") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboIGFilterInfraGroupName", "txtIGFilterInfraGroupName");
            }
            if (arrFields[0] == "Status") {
                var currOpToolCategory = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                setFilterComboValue("cboIGFilterStatus", currOpToolCategory);
                setFilterComboValue("txtIGFilterStatus", currValue);
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
                setFilterComboValue(OpComboName, "Exact Word");
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
            //  $("#" + ValueComboName).val(currValue);
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }
        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtIGFilterName').val("");
            }
        }
        function ClearFilterDetails(flag) {
            if ($("#txtIGFilterInfraGroupName").val() != "") {
                $("#txtIGFilterInfraGroupName").val("");
            }
            if ($("#cboIGFilterInfraGroupName").val() != "Contains") {
                setFilterComboValue("cboIGFilterInfraGroupName", "Contains");
            }
            if ($("#cboIGFilterStatus").val() != "=") {
                setFilterComboValue("cboIGFilterStatus", "=");
            }
            if ($("#txtIGFilterStatus").val() != "") {
                $("#txtIGFilterStatus").val("");
            }
            $('#txtIGFilterName').val('');
            //$("#txtIGFilterStatus").val("");
            // $("#chkDTFilterActive").prop('checked', false);

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
                $(this).attr("data-original-title", "Apply filter");
            });
            $('[data-bs-toggle="tooltip"]').tooltip();

            fltPersonResponsible = "";
            currentappliedfilter = 0;
            currentFilterID = 0;
            currentappliedfilterclause = "";
            ClearFilterDetails("");
            //changed by mahesh on 21 july 2021
            GetMyIGFilter(0);
            //End changed by mahesh on 21 july 2021
            GetIGDetails(null);
        });

        function GetIGDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                //   var whereClauseFormated = whereClause.replace(/'/g, "\''");
                filter = { UniqueID: '0', IGWhereClause: encodeURIComponent(whereClause) };
            }
            GetInfraGroups(filter);
        }
        //FILTER VALIDATION
        function checkFiltervalidationForIG() {
            var grpName = $("#txtIGFilterInfraGroupName").val() == "" ? null : $("#txtIGFilterInfraGroupName").val();
            var status = $("#txtIGFilterStatus").val() == "" ? null : $("#txtIGFilterStatus").val();
            if ((grpName == null || grpName == 'undefined' || grpName == ' ') && (status == null || status == 'undefined' || status == 0)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                $('#Igsavefilter').modal('hide');
            }
            else {
                $('#Igsavefilter').modal('show');
            }
        }
        function AvoidSpace(input) {
            if (/^\s/.test(input.value))
                input.value = '';
        }
        function SaveIGFilterDetails() {
            var fltFilterName = $("#txtIGFilterName").val();
            if (fltFilterName == "" || fltFilterName == " ") {
                //$('#BgSavefilter').modal('show');
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name');
                //$('#BgSavefilter').modal('show')

                $("#txtIGFilterName").focus();

                //return false
            }
            //Added By Rehan C To check validation for Special characters  on 07th Nov 2022
            else if (checkSpecialCharacter(fltFilterName, WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtIGFilterName").focus();
              
                
            }
            //else if (fltFilterName.trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Filter name can not contain any of these /\:*?<>|,"+- characters.');
            //    $("#txtIGFilterName").focus();
            //}
            else {
                var filterExists = 0;
                var AllIgFilter = ["InfraGroupName", "Status"];
                var filterWhereClause;
                var filterWhereClause2 = GenerateIGBasicFilterQuery("IG", AllIgFilter);
                filterWhereClause = filterWhereClause2.replace(/"/g, "\'");
                var paramFilterID = 0;
                paramFilterID = currentFilterID;

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
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            $('#Igsavefilter').modal('hide');
                            FilterApplied();
                            GetMyIGFilter(0);
                            ApplyFilter();
                            savedFilterName = fltFilterName;
                            $("#txtIGFilterName").val('');
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
                    },
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                });
                //}
            }
        }
        function GetMyIGFilter(flag) {
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

        function ExistIGFilter(filtername) {

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
                            //var GetBGWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                            GetIGDetails();
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyIGFilter(0);
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
                        $("#txtIGFilterName").val(currentFilterName);
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
                    //StopAjaxLoader("#bodyBusiness-group");
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
        }

        //Apply saved filter
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';
        function ApplySavedFilter(FilterID, isDefault, isFromDefault){
            //Changed  by imran by Filter Issue on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null)
            {
                isFromDefault = false;
            }

            if (isDefault == 3)
            {
                // var GetBGWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                GetIGDetails();
                GetMyIGFilter(isDefault);
                FilterNotApplied();
                ClearFilterDetails(""); // Added By Reshma Chavan on 31st Jan 2022 for clearing filter
                $('#AdvanceFilterIcon').attr("aria-expanded", false);
                //added by imran on 21 july 2021
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
                            GetIGDetails(Querytext);
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
                        //GetBGDetails(Querytext);
                        // call business group getRiskDetails(currentselectedProjectID, 0, "", "defaultfilterapply", Querytext);
                        FilterApplied();
                        if (currentDefaultFilterID > 0) {
                            FilterApplied();
                        }
                        if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                            GetMyIGFilter(0);
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
                        //ApplySavedFilter(FilterID, 2);
                        ApplySavedFilter(FilterID, 2,true);
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        //alertify.success('Default');
                        //FilterNotApplied();

                        ApplySavedFilter(FilterID, 3,true);
                        alertify.success('Default Filter Is Successfully Removed!');
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        FilterNotApplied();
                    }
                    GetMyIGFilter(0);
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
        function GenerateIGBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();

                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();
                    if ($('#txtIGFilterInfraGroupName').val() == "" || $('#txtIGFilterInfraGroupName').val() == undefined) {
                        var strDesc = null;
                    }
                    //Added By Rutuja D. on 28 July 2021 For Filter issue
                    strvalue = strvalue.replace(/"/g, '""');
                    //Added By Rutuja D. on 28 July 2021 For Filter issue

                    if (strvalue != "" && strvalue != undefined) {

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
                            //Commented & Added By Rutuja D. on 27 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '"';
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
                        else if (strOp == "Exact Word") {
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
                            //strqtext += ' "' + strvalue + '%"'; //Commented By Reshma chavan on 6th Dec 2021 For IssueID-31715
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
                        else if (strOp == "=" && strvalue == "true") {
                            // alert(strqtext);
                            if (strvalue == "" || strvalue == undefined) {
                                // alert("if");
                                if (strDesc == null && strDesc == undefined && strqtext == "") {
                                    //  alert("strdes");
                                    strqtext += filterField[i] + strOp + '"' + strvalue + '"';
                                }
                                else {
                                    // alert("sddf");
                                    strqtext += " AND " + filterField[i] + " ";
                                    strqtext += strOp + '"' + strvalue + '"';
                                }

                            }
                            else {
                                //  alert("lastelse");
                                strqtext += filterField[i] + strOp + '"' + strvalue + '"';
                            }
                        }
                        else if (strOp == "=" && strvalue == "false") {
                            // alert(strqtext);
                            if (strvalue == "" || strvalue == undefined) {
                                // alert("if");
                                if (strDesc == null && strDesc == undefined && strqtext == "") {
                                    //  alert("strdes");
                                    strqtext += filterField[i] + strOp + '"' + strvalue + '"';
                                }
                                else {
                                    // alert("sddf");
                                    strqtext += " AND " + filterField[i] + " ";
                                    strqtext += strOp + '"' + strvalue + '"';
                                }

                            }
                            else {
                                //  alert("lastelse");
                                strqtext += filterField[i] + strOp + '"' + strvalue + '"';
                            }
                        }
                        else if (strOp == "<>" && strvalue == "true") {
                            //   alert(strqtext);
                            if (strvalue == "" || strvalue == undefined) {
                                // alert("if");
                                if (strDesc == null && strDesc == undefined && strqtext == "") {
                                    // alert("strdes");
                                    strqtext += filterField[i] + strOp + '"' + strvalue + '"';
                                }
                                else {
                                    //  alert("sddf");
                                    strqtext += " AND " + filterField[i] + " ";
                                    strqtext += strOp + '"' + strvalue + '"';
                                }

                            }
                            else {
                                // alert("lastelse");
                                strqtext += filterField[i] + strOp + '"' + strvalue + '"';
                            }
                        }
                        else if (strOp == "<>" && strvalue == "false") {
                            //   alert(strqtext);
                            if (strvalue == "" || strvalue == undefined) {
                                // alert("if");
                                if (strDesc == null && strDesc == undefined && strqtext == "") {
                                    // alert("strdes");
                                    strqtext += filterField[i] + strOp + '"' + strvalue + '"';
                                }
                                else {
                                    //  alert("sddf");
                                    strqtext += " AND " + filterField[i] + " ";
                                    strqtext += strOp + '"' + strvalue + '"';
                                }

                            }
                            else {
                                // alert("lastelse");
                                strqtext += filterField[i] + strOp + '"' + strvalue + '"';
                            }
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

        function closeFilterPanel() {
            $("#filterpanel").removeClass('show');
        }
    </script>

</body>

</html>
