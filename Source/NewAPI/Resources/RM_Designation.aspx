<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_Designation.aspx.vb" Inherits="PbNIT.RM_Designation" %>

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
/*        .dataTables_scrollHeadInner {
    width: 100% !important;
}*/
     /* Added by Madhuri.K For datatable Header Start here */
#leaveMasterMainTbl_wrapper .dataTables_scrollHeadInner, #leaveMasterMainTbl_wrapper table{width:100%!important}
           /* Added by Madhuri.K For datatable Header End here */
.dataTables_info {
            margin-top: 1px;
        }
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
           /* background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;*/
             background: url(../../../Whizible2.0-new/dist/img/loading.gif) rgba( 255, 255, 255, .8 ) 100% 100% no-repeat; 
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 100002;
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
            word-break: break-all;
            white-space: normal;
        }
.table thead tr th:last-child{ padding-right:8px!important;}/*Added by pradip on 9-7-21*/
         #DesignnationListTbl_wrapper .pagination {margin-bottom:0px!important;}/*Added by pradip on 19-7-2021*/
         #leaveMasterMainTbl_wrapper .pagination {margin-bottom:10px!important;}/*Added by pradip on 19-7-2021*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" >

       <div class="" id="body-Designation"></div>
        <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-0 text-right graybg" style="display:table">
            <h5 class="pgtitle float-start">Designation</h5>
            <a href="javascript:;" class="mainclearalllink" onclick="closeFilterPanel()" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline pull-right" data-toggle="tooltip" title="Filter" data-bs-placement="bottom">
                <button data-bs-toggle="collapse" id="AdvanceFilterIcon" data-bs-target="#filterpanel" autocomplete="off"><i class="fas fa-filter"></i></button>
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
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" onclick="checkFiltervalidationForDSG();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFilter()">Apply</button>
                                </div>
                                <br />

                                <div class="row">
                                    <div class="col-sm-4 form-group">
                                        &nbsp;
                                    </div>
                                    <div class="col-sm-4 form-group">
                                        <label>Designation</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboDesignationFilterDesignationName">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">Ends With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Starts With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtDesignationFilterDesignationName", "txtDesignationFilterDesignationName", "form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:=" onkeypress='return OnDoublePress(event),AvoidSpace(this)'") %>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="col-sm-4 form-group">
                                        &nbsp;
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

        <div class="container-fluid pt-1 pb-1 text-right">
            <button class="btn borderbtn mr-5 addbtn" id="btnAddDesignation" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Add Designation" onclick="addDesignnationDetails()"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
            <button class="btn borderbtn deletebtn" id="DeleteDesignation" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete" onclick="DeleteDesignationDetailsAfterConfirm()">Delete</button>
            <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Back to Resource Configuration">Back</a>--%>
            <%--End of Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>

        </div>

        <div class="content pt-0">
            <div class="DSGtblouter">
                <table id="DesignnationListTbl" class="table table-bordered Dsgllist" style="width: 100%;">
                    <thead>
                        <tr>
                            <th class="text-left">Designation</th>
                            <th width="60">
                                <div class="custom_chckbox">
                                    <input id="DesignationListCheck0" class="chckHead" type="checkbox">
                                    <label for="DesignationListCheck0"></label>
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="tblDesignationMain">
                    </tbody>
                </table>
            </div>
        </div>


        <div class="Resourcedetailpanel">
            <input type="hidden" id="hdnDesignation_UniqueIDTab" name="hdnDesignation_UniqueIDTab" value="">

            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li><a href="#Desgdetails" class="active" data-bs-toggle="tab" id="DsgDetailsTab" onclick="showDsgDetails();">Details</a><div></div>
                    </li>
                    <li class=""><a href="#DesgLeaves" data-bs-toggle="tab" id="DsgLevesTab" onclick="OpenLeaves();">Leaves</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">

                    <div id="Desgdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button class="btn btnyellow mr-5" id="" onclick="SaveDesignationDetails(0)">Save</button>
                            <button class="btn btnyellow mr-5" id="btnSaveDsgDetails" onclick="SaveDesignationDetails(1)">Save And Add</button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>
                        <p class="text-right"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                        <div class="row">
                            <div class="col-sm-4 form-group">
                                <label class="required">Designation</label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtDesignation", "txtDesignation", cssClass:="form-control", widthInPixel:=0, maxLength:=50) %>
                            </div>

                        </div>
                    </div>
                    <div id="DesgLeaves" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button class="btn borderbtn mr-5" id="AddLeaves" data-bs-toggle="modal" data-bs-target="#addDesignationModal" data-toggle="tooltip" data-bs-placement="bottom" title="Add Leave" onclick="addLeavesPopup()"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                            <button class="btn borderbtn mr-5" id="DeleteLeaves" data-toggle="tooltip" data-bs-placement="bottom" title="Delete" onclick="DeleteLeavesDetailsAfterConfirm()">Delete</button>

                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>
                        <div class="content pt-0">
                            <div class="RPMtblouter">
                                <table class="table table-bordered" id="leaveMasterMainTbl" style="width: 100% !important">
                                    <thead>
                                        <tr>
                                            <th class="col-sm-3 text-center">Leave Type</th>
                                            <th class="col-sm-3 text-center">Leave Entitlement</th>
                                            <th class="col-sm-2 text-center">Pro Rata</th>
                                            <th class="col-sm-1 text-center">
                                                <div class="custom_chckbox">
                                                    <input id="LeaveCheckList0" class="chckHead1" type="checkbox">
                                                    <label for="LeaveCheckList0"></label>
                                                </div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="leaveMasterTbl">
                                    </tbody>
                                </table>
                                 <div class="clearfix"></div>
                            </div>
                        </div>
                         <div class="clearfix"></div>
                    </div>
                     <div class="clearfix"></div>


                </div>
                 <div class="clearfix"></div>
            </div>
        </div>
             <div class="clearfix"></div>
        <!-- Save filter Modal start here-->
        <div class="modal custmodal DesignationSavefilter_filter fade" id="DesignationSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply();">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="DesignationSavefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-right required">Filter Name :</label>
                                            <span class="col-md-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtDesignationFilterName", "txtDesignationFilterName", "form-control",, maxLength:=100, ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>

                                                <%--                                                <input type="text" class="form-control" name=""><br />--%>
                                                <div class="btnrow">
                                                    <button class="btn btnyellow float-start savefilter" id="btnSaveFilter" onclick="SaveDSGFilterDetails()">Save</button>
                                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right" onclick="cancelsaveapply()">Cancel</button>
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
             <div class="clearfix"></div>

        <!--Add DesignationmodAL-->
        <div class="modal custmodal fade" id="addDesignationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <input type="hidden" name="hdnLeaveId" id="hdnLeaveId" />
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Add Leave</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="required">Leave Type</label>
                            <% CommonFunctions.HTMLControls.DrawComboBox("txtLeaveTypeID", "usp_Whizible2_Sel_tbl_PM_LeaveTypemaster ",,, "class='form-control'", True, ) %>
                        </div>
                        <div class="form-group">
                            <label class="required">Leave Entitlement</label>
                            <% CommonFunctions.HTMLControls.DrawTextBox("txtLeaveEntitlement", "txtLeaveEntitlement", cssClass:="form-control", widthInPixel:=0, maxLength:=12, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)'")%>
                        </div>
                        <div class="form-group">
                            <label class="">Pro-Rata</label>
                            <% CommonFunctions.HTMLControls.DrawTextBox("txtLeaveProRata", "txtLeaveProRata", cssClass:="form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onkeypress='return Field_OnKeyPressPro(event)'")%>
                        </div>
                        <br />
                        <div class="text-center">
                            <button data-bs-dismiss="modal" class="btn borderbtn mr-5" onclick="onCloseLeaves();">Close</button>
                            <button id="" class="btn btnyellow mr-5" onclick="saveLeaves(0);">Save</button>
                            <button id="btnSaveLeave" class="btn btnyellow" onclick="saveLeaves(1);">Save And Add</button>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--Add DesignationmodAL-END-->
             <div class="clearfix"></div>
    <%--Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021--%>     
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
     <%--End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021--%>
    

        <div class="clearfix"></div>
    </div>
 
    <!-- REQUIRED JS SCRIPTS -->
 <%--  <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/datatables/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
  <%--  <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>
     <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

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
                        <strong>Note:</strong> Designation which is in use cannot be deleted.<br />
                        <p id="showdeleterow"></p>
                    </div>

                    <div class="text-right">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="modal custmodal fade" id="DeleteConfirmLeaveModal" aria-hidden="true" data-bs-dismiss="modal">
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
                        <strong>Note:</strong> Leave which is in use cannot be deleted.<br />
                        <p id="showdeleterowforleave"></p>
                    </div>

                    <div class="text-right">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script>

        //Added By Madhuri.K for Remove tooltip 
        $('body').on('click', function () {
            $('.tooltip').remove();
        });

        //Added By Riddhesh Patil on 07-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of  Added By Riddhesh Patil

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        function addDesignnationDetails() {
            $("#hdnDesignation_UniqueIDTab").val(0);
            $('#txtDesignation').val("");
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $(".DSGtblouter .dataTables_scrollBody, .paginate_button, .backbtn, .addbtn, .deletebtn, .filter,.mainclearalllink, #DesignnationListTbl_wrapper .dataTables_scrollHead").addClass("DisableContent").parent().css("cursor", "no-drop");
            //$(".table").resize();      
            $('#DsgDetailsTab').click()
            $('#DsgLevesTab').addClass("DisableContent");
        }


        function editDesignnationDetails() {
            $('#tblDesignationMain').on('click', '.BGdetalilink', function () {
                var $row = $(this).closest("tr");
                $tds = $row.find("td");
                var hdnDesignationId = $row.find('#hdn_DesignationID').val();
                $('#hdnDesignation_UniqueIDTab').val(hdnDesignationId);
                $.each($tds, function (index, obj) {
                    var hiddenField = $(this).find("input[type='hidden']").val();
                    if (hiddenField != 'undefined' && hiddenField != null) {
                        var eventId = hiddenField;
                        // $('#hdn_ParameterID').html(eventId);

                    }

                    if (index == 0) {
                        $('#txtDesignation').val($(this).text().trim());

                    }
                    $(".Resourcedetailpanel").show();
                    $('html,body').animate({
                        scrollTop: $(".Resourcedetailpanel").offset().top - 60
                    }, 'slow');
                    //used for disable grid
                    $(".DSGtblouter .dataTables_scrollBody, .paginate_button, .backbtn, .addbtn, .deletebtn, .filter,.mainclearalllink, #DesignnationListTbl_wrapper .dataTables_scrollHead").addClass("DisableContent").parent().css("cursor", "no-drop");
                    //$(".table").resize();
                });
                // $(this).closest('tr').addClass('rowhiglight');
                $('#DsgDetailsTab').click()
                $('#DsgLevesTab').removeClass("DisableContent");
            });
        }
        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });

        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $(".DSGtblouter,.dataTables_scrollBody, .paginate_button, .backbtn, .addbtn, .deletebtn, .filter,.mainclearalllink, #DesignnationListTbl_wrapper .dataTables_scrollHead").removeClass("DisableContent").parent().css("cursor", "auto");
            CurrentTabObject = { Details: 'false', Leaves: 'false' }

setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0); //Added by pradip on 19-7-2021
            //$(".table").resize();
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
        var designationTable;
        var leaveTable;
        var CurrentTabObject = { Details: 'false', Leaves: 'false' };

        $(document).ready(function () {
            $('.btn').tooltip({ trigger: 'hover' });
            //$('body').on('click', function () {
            //    $('.tooltip').remove();
            //});

            CurrentTabObject = { Details: 'false', Leaves: 'false' };
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (blnAddAccess == "False") {
                DisableEnableBtn(1)
            }
            else {
                DisableEnableBtn(0)
            }
            if (blnDeleteAccess == "False") {
                $("#DeleteDesignation").addClass("clsShowHide");
                $("#DeleteLeaves").addClass("clsShowHide");

            }
            else {
                $("#DeleteDesignation").removeClass("clsShowHide");
                $("#DeleteLeaves").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {
                GetMaximumItemsToShowInList();
                GetMyDSGFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);

                } else {
                    GetDesignation(null);
                    FilterNotApplied();
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
        });

        function OnDoublePress(e) {
            var keyCode = e.which ? e.which : e.keyCode
            var flag = true;
            if (keyCode == 34 || keyCode == 44) {
                flag = false;
            }
            return flag;
        }
        //datatable
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            designationTable = $('#DesignnationListTbl').dataTable({

                "dtat": data,
                "bFilter": false,
                //"retrieve": true,
                "fixedHeader": true,
                "lengthChange": false,
                "searching": false,
                "destroy": true,
                "sScrollY": (0.6 * $(window).height()),
                "iDisplayLength": noOfRowsPerPage,
                "bPaginate": true,
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
                        // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue              
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.error(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue              
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(thrownError);
                    }


                }
            })

        }


        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);
   /*     $('#leaveMasterMainTbl').DataTable().columns.adjust().draw();*/
     /*   $('#leaveMasterMainTbl_wrapper').DataTable().columns.adjust().draw();*/

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
            $('.tooltip').remove();
        });
        $(".collapse").on('shown.bs.collapse', function (e) {
           
            $('.tooltip').removeClass("show");
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });
//Added by pradip on 19-7-2021
         $(".modal").on('hide.bs.modal', function () {
         $(".table").resize();
         });
            $(".modal").on('hidden.bs.modal', function () {
               $(".table").resize();
            });

        function resizeSection() {
            var tblheight = $(window).height();
            $('.DSGtblouter .dataTables_scrollBody').css({ 'height': tblheight - 211, "overflow-y": "auto" }); //modified by pradip on 19-7-2021

            //var tblheight = $(window).height();
            //$('.Resourcedetailpanel').css({ 'height': tblheight - 60 });
        }

        function resizeSection() {
            var tblheight = $(window).height();
            $('#DesignnationListTbl_wrapper').css({ 'height': tblheight - 120, "overflow-y": "auto" });//modified by pradip on 19-7-2021

            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 10 });
        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });




        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        });

        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var allPages = designationTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#DesignnationListTbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedEmpID.push(parseInt($(rows[i]).find("#hdn_DesignationID").val()));
                    }

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedEmpID = [];
                }
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
        var SelectedEmpID = [];
        function GetSelectedDesignation(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedEmpID.push(parseInt(row.find('#hdn_DesignationID').val()));
            }
            else {
                if (SelectedEmpID != 'undefined' && SelectedEmpID.length > 0) {
                    var removeEmp = row.find('#hdn_DesignationID').val();
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

            if (designationTable.$('input:checked').length == designationTable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
            }
        }
        function onClose() {
            $('#hdnDesignation_UniqueIDTab').val(0);
            $('#txtDesignation').val("");
        }
        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtDesignationFilterName').val("");
            }
        }
        function GetDesignation(DsgFilterParms) {
            //Added by imran on 19-08-2022
            if (DsgFilterParms == null || DsgFilterParms == "null" || DsgFilterParms == "") {
                var DsgFilterParms =
                {
                    DsgWhereClause: ""
                }
            }
            //End of comment by imran on 19-08-2022
            SelectedEmpID = [];
            var strHTML = "";
            StartLoader("#body-Designation");
            //var where = {ProWhereClause:PROFilterParms.ProWhereClause}
            $.ajax({
                url: strUrl + '/api/RM_Designation/GetDesignation',
                type: "POST",
                data: JSON.stringify(DsgFilterParms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (DsgFilterParms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DsgFilterParms) ? DsgFilterParms : JSON.stringify(DsgFilterParms)));
                    }
                },
                success: function (data) {
                    var List = data;
                    console.log("List", List);
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            if (blnEditAccess == "True") {
                                strHTML += '<tr><td class="text-left"><a href="javascript:;" class="BGdetalilink" onclick="editDesignnationDetails()"</a> <input type="hidden" name="hdn_DesignationID" id="hdn_DesignationID" value= ' + obj.DesignationID + '>' + obj.DesignationName + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedDesignation(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                            }
                            else {
                                strHTML += '<tr><td class="text-left"> <input type="hidden" name="hdn_DesignationID" id="hdn_DesignationID" value= ' + obj.DesignationID + '>' + obj.DesignationName + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedDesignation(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                            }

                        });
                    }

                    $('#DesignnationListTbl').dataTable().fnDestroy();
                    $("#tblDesignationMain").html(strHTML);
                    LoadPagination(data);
                    StopAjaxLoader("#body-Designation");
                    $(".chckHead").prop("checked", false);
                    $(".table").resize();
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-GradeMaster");
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
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                

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
            if ($("#txtDesignation").val().trim() == undefined || $("#txtDesignation").val().trim() == "" || $("#txtDesignation").val().trim() == null) {
                $("#txtDesignation").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Designation' should not left blank.");
                return false;
            }
             //Commnet and Added By Riddhesh Patil on 07-NOV-2022 

            //else if ($("#txtDesignation").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtDesignation").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Designation cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
           
            else if (checkSpecialCharacter($("#txtDesignation").val().trim(), WebConfigSpecialCharacters) == true) {

                //Added by Aditya J. on 08-11-2024
                validateflag = false;
                //End of Added by Aditya J. on 08-11-2024

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Designation should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtDesignation").focus();
                return false;
            }
			//End of Commnet Added By Riddhesh Patil
            else {
                validateflag = true;
                return true;
            }
        }

        var validateflag
        function SaveDesignationDetails(isFromSaveAndclick) {
            checkValidation();
            if (validateflag == true) {
                var desigId = $("#hdnDesignation_UniqueIDTab").val();
                var desigName = $("#txtDesignation ").val().replace(/'/g, "''");

                var Details = {
                    DesignationID: desigId > 0 ? desigId : 0,
                    DesignationName: desigName,
                    CreatedBy: encodeURI(UserName)

                };
                console.log("Details", Details);
                $.ajax({
                    url: strUrl + '/api/RM_Designation/SaveDesignationDetails',
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
                        GetDesignation();

                        if (isFromSaveAndclick == 0) {
                            // alert(data);
                            if (data == "Designation already exist.") {
                                $(".DSGtblouter,.backbtn, .addbtn, .deletebtn, .filter,.mainclearalllink").addClass("DisableContent");


                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                $(".DSGtblouter,.backbtn, .addbtn, .deletebtn, .filter,.mainclearalllink").removeClass("DisableContent");

                                $(".Resourcedetailpanel").hide();
                                $('#Resourcedetailpanel').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                            }
                        }
                        else {
                            if (data == "Designation already exist.") {

                                $(".DSGtblouter,.backbtn, .addbtn, .deletebtn, .filter,.mainclearalllink").addClass("DisableContent");

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                //$(".DSGtblouter,.paginate_button").addClass("DisableContent").parent().css("cursor", "no-drop");
                                onClose();
                                $(".DSGtblouter,.backbtn, .addbtn, .deletebtn, .filter,.mainclearalllink").addClass("DisableContent");

                                $('#Resourcedetailpanel').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                            }
                            $('#DsgLevesTab').addClass("DisableContent");
                        }

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            //CurrentGRPTabObject.GrpManager = 'false';
                            GetDesignation();
                            // CurrentGRPTabObject.GrpManager = 'true';
                            StopAjaxLoader("#body-Designation");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        StopAjaxLoader("#body-Designation");
                        //if (isFromSaveAndclick == 0) {
                        //    $('#Resourcedetailpanel').modal('hide');
                        //}
                    }
                })
            } else {
                return false;
            }
        }

        function DeleteDesignationDetailsAfterConfirm() {
            var strHTML = "";
            var selectedDesignationID = SelectedEmpID.toString();
            if (selectedDesignationID.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_Designation/DeleteDesignationDetails',
                    type: "POST",
                    data: JSON.stringify(selectedDesignationID),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#body-Designation");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //}

                        StopAjaxLoader("#body-Designation");
                        GetDesignation();
                         //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        //strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                         //End of Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterow').html(strHTML);
                        $('#DeleteConfirmMModal').modal('show');
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue    
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue    
                        }
                        else if (xhr.statusText == "OK") {  //200
                            GetDesignation();
                            $('#DeleteConfirmMModal').modal('hide');
                            //alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify("Deleted");
                        }

                        StopAjaxLoader("#body-Designation");
                        $('#DeleteConfirmMModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedEmpID = [];
            selectedDesignationID = "";
        }

        //fILTER
        function GenerateDesignationBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();

                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();

                     //Added By Chetan M on 28 July 2021 For IssueID = 29339
                    strvalue = strvalue.replace(/"/g, '""');
                    //End of Added By Chetan M on 28 July 2021 For IssueID = 29339
                    if (strvalue != "" && strvalue != undefined && strvalue != "0") {

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
            if (arrFields[0] == "DesignationName") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboDesignationFilterDesignationName", "txtDesignationFilterDesignationName");
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
            


            //Commented & added by mahesh on  27 july 2021
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }

        function ClearFilterDetails(flag) {
            if ($("#cboDesignationFilterDesignationName").val() != "Contains") {
                setFilterComboValue("cboDesignationFilterDesignationName", "Contains");
            }
            if ($("#txtDesignationFilterDesignationName").val() != "") {
                $("#txtDesignationFilterDesignationName").val("");
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
            GetMyDSGFilter(0);
            //End changed by mahesh on 21 july 2021
            GetDesignationDetails(null);
        });

        function ApplyFilter() {
            var filterFlag = true;

            if ($('#txtDesignationFilterDesignationName').val() == "" || $('#txtDesignationFilterDesignationName').val() == " ") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                filterFlag = false;
                return false;
            }
            if (filterFlag == true) {
                currentFilterID = 0;
                var filter = "";
                //if (filterwhereclause != 'undefined' && filterwhereclause != null) {
                var AllDSGFilter = ["DesignationName"];
                var filterWhereClause2 = GenerateDesignationBasicFilterQuery("Designation", AllDSGFilter);
                // var filterWhereClause = (filterWhereClause2.replace(/'/g, "''")).replace(/"/g, "\''");
                var filterWhereClause = (filterWhereClause2).replace(/"/g, "\'");
                //filterWhereClause = (filterWhereClause2.replace(/'/g, "''")).replace(/"/g, "\''");
                filter = { UniqueID: '0', DsgWhereClause: encodeURIComponent(filterWhereClause) }
                FilterApplied();
                //}

                //SaveBGFilterDetails();
                GetDesignation(filter);
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");

            }

        }

        function GetDesignationDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                // var whereClauseFormated = whereClause.replace(/'/g, "\''");
                filter = { UniqueID: '0', DsgWhereClause: encodeURIComponent(whereClause) };
            }
            GetDesignation(filter);
        }
        //FILTER VALIDATION
        function checkFiltervalidationForDSG() {
            var DSGname = $("#txtDesignationFilterDesignationName").val() == "" ? null : $("#txtDesignationFilterDesignationName").val();
            //alert(CRTname);
            if ((DSGname == null || DSGname == 'undefined' || DSGname == " ")) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                $('#DesignationSavefilter').modal('hide');
            }
            else {
                $('#DesignationSavefilter').modal('show');
            }
        }
        function AvoidSpace(input) {
            if (/^\s/.test(input.value))
                input.value = '';
        }
        var savedFilterName = "";
        function SaveDSGFilterDetails() {
            var fltFilterName = $("#txtDesignationFilterName").val();
            if (fltFilterName == "" || fltFilterName == " ") {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name');

                $("#txtDesignationFilterName").focus();
            }
            //Commnet and Added By Riddhesh Patil on 12-NOV-2022 
            //else if (fltFilterName.trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Filter name cannot contain any of these /\:*?<>|,"+- characters.');

            //    $("#txtDesignationFilterName").focus();
            //}
            else if (checkSpecialCharacter(fltFilterName.trim(), WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtDesignationFilterName").focus();

            }
			//End of Comment Added By Riddhesh Patil
            else {
                var filterExists = 0;
                var AllDSGFilter = ["DesignationName"];
                //var isActiveFilter = 'True';/// $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GenerateDesignationBasicFilterQuery("Designation", AllDSGFilter);
                // var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
                //filterWhereClause2 += "AND Active=" + ' "' + isActiveFilter + '"';
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
                            $('#DesignationSavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            GetMyDSGFilter(0);
                            ApplyFilter();
                            FilterApplied();

                            savedFilterName = fltFilterName;
                            $("#txtDesignationFilterName").val('');
                            //clearTooltip();
                            // ClearFilterDetails("");
                        }



                    },
                    //Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue  //error: function (xhr, errorThrown) {
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
                    // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue  
                });
                //}
            }
        }
        function GetMyDSGFilter(flag) {
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
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3)></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                            }
                            else {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;)></i>";
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
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue 
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
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue 
            });
            clearTooltip();
        }

        function ExistDSGFilter(filtername) {

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
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
                //error: function (xhr, errorThrown) {
                //    isFilterExists = 1;
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                //},
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        isFilterExists = 1;
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                },
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
            });
            return isFilterExists;
        }

        //Delete filter
            //Commented & Added By Rutuja D. For Filter Issue on 7 July 2021
        //function DeleteFilter(FilterID, IsApplyed) {
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
                            GetDesignation(null);
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyDSGFilter(0);
                        currentappliedfilter = 0;

                    }
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
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
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
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
                        $("#txtDesignationFilterName").val(currentFilterName);
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
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
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
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
            });
        }

        //Apply saved filter
        //var currentappliedfilter = 0;
        //var currentappliedfilterclause = '';
        function ApplySavedFilter(FilterID, isDefault,isFromDefault) {
            //Changed  by mahesh on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {

                GetDesignationDetails(null);
                GetMyDSGFilter(isDefault);
                FilterNotApplied();
                ClearFilterDetails(""); // Added By Reshma Chavan on 28th Jan 2022 for clearing filter
                $('#AdvanceFilterIcon').attr("aria-expanded", false);
                //added by mahesh on 21 july 2021
                if ((isFromDefault === false|| isFromDefault == 'false') && (isDefault == 3)) {
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
                            GetDesignationDetails(Querytext);
                        }
                        //Added By Reshma Chavan on 31st Jan 2022 for displalying data after apply filter
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
                       
                        //End of Added By Reshma Chavan on 31st jan 2022 for displalying data after apply filter
                        FilterApplied();
                        if (currentDefaultFilterID > 0) {
                            FilterApplied();
                        }

                        if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                            GetMyDSGFilter(0);
                        }
                    },
                    // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
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
                    // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
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
                    if (removeDefault == 0) {
                        //changed by mahesh on 21 july 2021
                        ApplySavedFilter(FilterID, 2, true);
                         //End changed by mahesh on 21 july 2021
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        //changed by mahesh on 21 july 2021
                        ApplySavedFilter(FilterID, 3, true);
                         //End changed by mahesh on 21 july 2021
                        alertify.success('Default Filter Is Successfully Removed!');
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        FilterNotApplied();
                    }

                    GetMyDSGFilter(0);
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
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
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
            });
        }

        //Leaves
        var SelectedLeaveID = [];
        function GetSelectedLeaves(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedLeaveID.push(parseInt(row.find('#hdn_LeaveUnquieID').val()));
            }
            else {
                if (SelectedLeaveID != 'undefined' && SelectedLeaveID.length > 0) {
                    var removeEmp = row.find('#hdn_LeaveUnquieID').val();
                    SelectedLeaveID.remove(parseInt(removeEmp));
                }
            }

        }
        function checkUncheckLeaves() {

            if (leaveTable.$('input:checked').length == leaveTable.fnGetNodes().length) {
                $(".chckHead1").prop("checked", true);
            } else {
                $(".chckHead1").removeAttr("checked");
                $(".chckHead1").prop("checked", false);
            }
        }
        $(".chckHead1").change(function () {
            var allPages = leaveTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#leaveMasterMainTbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedLeaveID.push(parseInt($(rows[i]).find("#hdn_LeaveUnquieID").val()));
                    }

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedLeaveID = [];
                }
            }
        });
        function showDsgDetails() {

        }
        function OpenLeaves() {
            if (CurrentTabObject != null && CurrentTabObject.Leaves == "false") {
                var designationID = $("#hdnDesignation_UniqueIDTab").val();
                GetDesignationLeaves(designationID);
                CurrentTabObject.Leaves = 'true';
            }
        }

        function GetDesignationLeaves(designationID) {
            CurrentTabObject.Leaves = 'true';
            SelectedLeaveID = [];
            var strHTML = "";
            StartLoader("#body-Designation");
            var leaveParams = { DesignationID: designationID }
            $.ajax({
                url: strUrl + '/api/RM_Designation/GetDesignationLeaves',
                type: "POST",
                data: JSON.stringify(leaveParams),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (leaveParams) {
                        xhr.setRequestHeader("Params", encryptString(isJson(leaveParams) ? leaveParams : JSON.stringify(leaveParams)));
                    }
                },
                success: function (data) {
                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            //if (blnEditAccess == "True") {
                            strHTML += '<tr><td class="text-center"><a href="javascript:;" class="Leavesdetalilink" onclick="editLeaves()"</a> <input type="hidden" name="hdn_LeaveUnquieID" id="hdn_LeaveUnquieID" value= ' + obj.UniqueID + '>' + obj.LeaveType + '</td><td class="text-center"> ' + obj.NoOfLeaves + ' </td><td class="text-center"> ' + obj.ProRata + ' </td><td><input type="hidden" id="hdn_LeaveTypeID" name="hdn_LeaveTypeID" value= ' + obj.LeaveTypeID + '><div class="custom_chckbox"><input id=chl_' + index + ' onclick="checkUncheckLeaves();GetSelectedLeaves(this);" class="chcktbl" type="checkbox"><label for=chl_' + index + '></label></div></td></tr>';


                        });
                    }

                    $('#leaveMasterMainTbl').dataTable().fnDestroy();
                    $("#leaveMasterTbl").html(strHTML);
                    LoadPaginationLeaves(data);
                    StopAjaxLoader("#body-Designation");
                    $(".chckHead1").prop("checked", false);
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#DesgLeaves");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-Designation");
                },
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
            })

        }
        function DisableEnableBtn(isTrue) {

            if (isTrue == '1') {
                $("#btnAddDesignation").addClass("clsShowHide");
                $('#btnSaveDsgDetails').attr("disabled", true);
                $('#AddLeaves').addClass("clsShowHide");
                $('#btnSaveLeave').attr("disabled", true);


            } else {

                $("#btnAddDesignation").removeClass("clsShowHide");
                $('#btnSaveDsgDetails').attr("disabled", false);
                $('#AddLeaves').removeClass("clsShowHide");
                $('#btnSaveLeave').attr("disabled", false);
            }

        }

        function LoadPaginationLeaves(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            leaveTable = $('#leaveMasterMainTbl').dataTable({
                "dtat": data,
                "bFilter": false,
                //"retrieve": true,
                "fixedHeader": true,
                "lengthChange": false,
                "searching": false,
                "destroy": true,
                "sScrollY": (0.6 * $(window).height()),
                "iDisplayLength": noOfRowsPerPage,
                "bPaginate": true,
                "bAutoWidth": false,
                "bAutoWidth": true,
               /* "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1] }],*/

                //"bJQueryUI": true,
                //"bScrollCollapse": true,
                //"bAutoWidth": true,
                //"sScrollX": "100%",
                //"sScrollXInner": "100%"
            });
      /*      $('#leaveMasterMainTbl').wrap('<div class="dataTables_scroll" />');*/



        }
        $('#txtLeaveEntitlement').bind('copy paste', function (e) {
            e.preventDefault();
        });
        $('#txtLeaveProRata').bind('copy paste', function (e) {
            e.preventDefault();
        });
        function addLeavesPopup() {
            $("#hdnLeaveId").val(0);
            $('#txtLeaveEntitlement').val("");
            $('#txtLeaveProRata').val("");
            $('#txtLeaveTypeID').val(0);
            $('#btnSaveLeave').attr("disabled", false);
        }
        function onCloseLeaves() {
            $('#txtLeaveEntitlement').val("");
            $('#txtLeaveProRata').val("");
            $('#txtLeaveTypeID').val(0);
        }
        function editLeaves() {
            $('#leaveMasterTbl').on('click', '.Leavesdetalilink', function () {
                CurrentTabObject = { Details: 'false', Leaves: 'false' }
                var $row = $(this).closest("tr");
                $tds = $row.find("td");
                var hdnLeaveId = $row.find('#hdn_LeaveUnquieID').val();
                var hdnLeaveTypeId = $row.find('#hdn_LeaveTypeID').val();
                //alert(hdnLeaveId);
                //  var txtOT = $row.find('#hdnOT').val();
                $.each($tds, function (index, obj) {
                    if (hdnLeaveTypeId != 'undefined' && hdnLeaveTypeId != null) {
                        $("#txtLeaveTypeID").val(hdnLeaveTypeId);
                    }
                    //if (index == 0) {
                    //    $('#txtEditCode').val($(this).text().trim());
                    //}
                    if (index == 1) {
                        var A1 = $(this).text();
                        var A = A1.toString().split(".")[0];
                        var B = A1.toString().split(".")[1];
                        if (B > 0) {
                            $('#txtLeaveEntitlement').val(A1);
                        } else {
                            ($('#txtLeaveEntitlement').val(A));
                        }
                        //$('#txtLeaveEntitlement').val($(this).text().trim());
                    }
                    if (index == 2) {
                        var A1 = $(this).text();
                        var A = A1.toString().split(".")[0];
                        var B = A1.toString().split(".")[1];
                        if (B > 0) {
                            $('#txtLeaveProRata').val(A1);
                        } else {
                            ($('#txtLeaveProRata').val(A));
                        }
                        // $('#txtLeaveProRata').val($(this).text());
                    }
                });
                $('#hdnLeaveId').val(hdnLeaveId);
                $('#addDesignationModal').modal('show');
            });
        }
        function checkValidationLeaves() {
            if ($("#txtLeaveTypeID").val() == undefined || $("#txtLeaveTypeID").val() == "" || $("#txtLeaveTypeID").val() == null) {
                $("#txtLeaveTypeID").focus();
                validateflagLeaves = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Leave Type' should not left blank.");
                return false;
            }
            else if ($("#txtLeaveEntitlement").val().trim() == undefined || $("#txtLeaveEntitlement").val().trim() == "" || $("#txtLeaveEntitlement").val().trim() == null) {
                $("#txtLeaveEntitlement").focus();
                validateflagLeaves = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Leave Entitlement' should not left blank.");
                return false;
            }
            //else if ($("#txtLeaveProRata").val().trim() == undefined || $("#txtLeaveProRata").val().trim() == "" || $("#txtLeaveProRata").val().trim() == null) {
            //    $("#txtLeaveProRata").focus();
            //    validateflagLeaves = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("'Pro-Rata' should not left blank.");
            //    return false;
            //}
            //else if ($("#txtLeaveProRata").val().trim() != null) {
            //    debugger;
            //    var ProRata = $("#txtLeaveProRata").val().trim();
            //    if (ProRata % 0.25 != 0) {
            //        alert('dd');
            //        $("#txtLeaveProRata").focus();
            //        validateflagLeaves = false;
            //        alertify.set('notifier', 'position', 'top-right');
            //        alertify.error("'Pro-Rata' .");
            //        return false;
            //    }
            //    else {
            //        return true;
            //    }
            //}

            else {
                validateflagLeaves = true;
                return true;
            }
        }
        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function Field_OnKeyPressPro(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    $("#txtLeaveProRata").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please enter only numeric values.");
                }
            }
            return ret;
        }

        function Field_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    $("#txtLeaveEntitlement").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please enter only numeric values.");
                }
            }
            return ret;
        }
        var validateflagLeaves
        function saveLeaves(isFromSaveAndclick) {
            checkValidationLeaves();
            if (validateflagLeaves == true) {
                // var UniqueID = $("#hdn_LeaveUnquieID").val();
                var UniqueID = $("#hdnLeaveId").val();
                var Role = $("#hdnDesignation_UniqueIDTab").val();
                var ProRata = $("#txtLeaveProRata").val().replace(/'/g, "''");
                var NoOfLeaves = $("#txtLeaveEntitlement").val().replace(/'/g, "''");
                var LeaveTypeID = $("#txtLeaveTypeID").val();
                // alert("UniqueID " + UniqueID);
                var Details = {
                    UniqueID: UniqueID > 0 ? UniqueID : 0,
                    Role: Role,
                    ProRata: ProRata,
                    NoOfLeaves: NoOfLeaves,
                    LeaveTypeID: LeaveTypeID,
                    CreatedBy: encodeURI(UserName)

                };
                $.ajax({
                    url: strUrl + '/api/RM_Designation/SaveLeaves',
                    method: 'Post',
                    data: JSON.stringify(Details),
                    dataType: 'json',
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Details) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Details) ? Details : JSON.stringify(Details)));
                        }
                    },
                    success: function (data) {
                        if (isFromSaveAndclick == 0) {
                            if (data == "Leave Type already exist.") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                $('#addDesignationModal').modal('hide');
                                onCloseLeaves();
                                GetDesignationLeaves($("#hdnDesignation_UniqueIDTab").val());
                            }


                        }
                        if (isFromSaveAndclick == 1) {
                            if (data == "Leave Type already exist.") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                $('#addDesignationModal').modal('show');
                                $("#hdnLeaveId").val(0);
                                onCloseLeaves();
                                GetDesignationLeaves($("#hdnDesignation_UniqueIDTab").val());
                            }

                        }

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            CurrentTabObject.Leaves = 'false';
                            GetDesignationLeaves($("#hdnDesignation_UniqueIDTab").val());
                            CurrentTabObject.Leaves = 'true';
                            //StopAjaxLoader("#bodyGlobal-Resource");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        StopAjaxLoader("#body-Designation");
                        //if (isFromSaveAndclick == 0) {
                        //    $('#AddVTModal').modal('hide');
                        //}
                    }
                })
            }
            else {
                return false;
            }
        }

        function DeleteLeavesDetailsAfterConfirm() {
            var strHTML = "";
            var selectedLeavesID = SelectedLeaveID.toString();
            if (selectedLeavesID.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_Designation/DeleteLeaveDetails',
                    type: "POST",
                    data: JSON.stringify(selectedLeavesID),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#body-Designation");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedLeavesID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedLeavesID) ? selectedLeavesID : JSON.stringify(selectedLeavesID)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //}

                        StopAjaxLoader("#body-Designation");
                        CurrentTabObject.Leaves = 'false';
                        GetDesignationLeaves($("#hdnDesignation_UniqueIDTab").val());
                        CurrentTabObject.Leaves = 'true';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        $('#showdeleterowforleave').html(strHTML);
                        $('#DeleteConfirmLeaveModal').modal('show');
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
                        }
                        else if (xhr.statusText == "OK") {  //200
                            CurrentTabObject.Leaves = 'false';
                            GetDesignationLeaves($("#hdnDesignation_UniqueIDTab").val());
                            CurrentTabObject.Leaves = 'true';
                            $('#DeleteConfirmLeaveModal').modal('hide');
                            //alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify("Deleted");
                        }

                        StopAjaxLoader("#body-Designation");
                        $('#DeleteConfirmLeaveModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedLeaveID = [];
            selectedLeavesID = "";
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
