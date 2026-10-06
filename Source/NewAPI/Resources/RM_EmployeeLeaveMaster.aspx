<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_EmployeeLeaveMaster.aspx.vb" Inherits="Whizible.RM_EmployeeLeaveMaster" %>

<!DOCTYPE html>
<html>  
      <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%>
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
   <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

    

</head>
<style type="text/css">
    .graybglight{
            background: rgb(230, 230, 230)!important;
    }
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

        .UpDowncollapseArrow {
            float: right;
            width: 15px;
            margin-right: 5px;
        }

            .UpDowncollapseArrow .downarrow {
                display: inline-block;
                width: 15px;
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

        .mr-5 {
            margin-right: 5px;
        }
        /**/
        .proratadetailTbl tr th:first-child {
            width: 300px;
        }

        .proratadetailTbl tr th {
            min-width: 132px;
        }

            .proratadetailTbl tr th:last-child {
                min-width: unset;
            }

        .borderbox {
            padding: 15px 10px 10px;
            border: 1px solid #ddd;
            min-height: 91px;
            margin: 0 0 10px;
            border-radius: 4px;
            background: #f5f5f5;
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

        table.dataTable,
        table.dataTable th,
        table.dataTable td {
            -webkit-box-sizing: content-box !important;
            -moz-box-sizing: content-box !important;
            box-sizing: content-box !important;
        }

        .tooltip {
            z-index: 9999 !important;
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

        .pointerDisable {
            pointer-events: none;
        }

        .actioncolumn {
            width: 6% !important;
        }

        th {
            position: sticky;
            top: 0;
        }

        /*Added by Chetan M on 9 Aug 2021 */
        a.mainclearalllink {
    position: absolute;
    right: 20px;
    top: 43px;
}
        /*End of Added by Chetan M on 9 Aug 2021 */

        #PBEUstep2 .form-group{display:flex}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed">

    <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 mb-0 text-right graybg" style="display:table">
            <h5 class="pgtitle float-start">Employee Leave Master</h5>

            <%--  <a href="javascript:;" class="clearalllink" style="" onclick="clearAll" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div>--%>
        </div>
        <div class="container-fluid pt-1 text-right">
            <a href="javascript:;" class="btn borderbtn mr-5" id="btnDownloadTemplate" data-bs-toggle="modal" onclick="Download_Template()">Download Template</a>
            <a href="javascript:;" class="btn borderbtn mr-5 uploadExlbtn" id="btnUpload" data-bs-toggle="modal" onclick="EmpOpenExceluploadsteps()">Excel Upload</a>
            <%--            <a href="javascript:;" class="btn borderbtn uploadExlbtn" data-bs-toggle="modal" data-bs-target="#exceluploadsteps">Excel Upload</a>--%>
            <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#LeavAprovalModal" onclick="openLeavesApprovers();">Leave Approvers</a>
            <%-- <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#ProrataDetailModal">Show ProRata</a>--%>
        </div>
        <br />


        <div class="content pt-0">
            <div class="borderbox" style="position:relative">
                <div class="row">
                    <div class="col-md-2">
                        <label>Business Group</label>
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboEMPFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-control"" onChange=""FillFilterOUForFilter(this.value),CboRPMResource_OnChange(this.value)""",,,, ,)%>
                        <%--  <% CommonFunctions.HTMLControls.DrawComboBox("cboBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-control"" onChange=""FillFilterOUForFilter(this.value)""", True,,, ,)%>--%>
                    </div>
                    <div class="col-md-2">
                        <label>Organization Unit</label>
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboEMPFilterLocationID", "Select 0,'' ",,, "class=""form-control"" onChange=""CboRPMResource_OnChange(this.value)""",,,, , ) %>
                    </div>
                    <div class="col-md-3">
                        <label>Designation</label>
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboEMPFilterDesignationID", "usp_Whizible2_sel_tbl_PM_DesignationMaster_DesignationName",,, "class=""form-control"" onChange=""CboRPMResource_OnChange(this.value)""",,,, ,)%>
                    </div>
                    <div class="col-md-3">
                        <label>Employee Name</label>
                        <input type="text" class="form-control" id="txtEMPFilterEmployeeName" />
                    </div>
                    <div class="col-md-2">
                        <button class="btn btnyellow" onclick="ApplyEmpFilter()" style="margin-top: 24px;">Apply</button>
                        <%-- Added by Chetan M on 9 August 2021 for clear filter  --%>
                        <a href="javascript:;" class="mainclearalllink" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
                        <%-- End of Added by Chetan M on 9 August 2021 for clear filter  --%>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="Qtblouter">
                <table id="ELMTblP" class="table table-bordered ELMTbl" style="width: 100%;">
                    <thead>
                        <tr>
                            <th width="300">Employee name</th>
                            <th width="300">Email ID</th>
                            <th>Phone</th>
                            <th>Total Leaves</th>
                            <th>Balance Leaves</th>
                        </tr>
                    </thead>

                    <tbody id="ELMTblMain">
                    </tbody>
                </table>
            </div>
        </div>


        <div class="Resourcedetailpanel">

            <input type="hidden" id="hdnEmp_UniqueID" name="hdnEmp_UniqueID" value="">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <!--<li class="active"><a href="#Desgdetails" data-bs-toggle="tab" id="">Details</a><div></div></li>-->
                    <li><a href="#DesgLeaves" class="active" data-bs-toggle="tab" id="">Employee Leave Details</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">
                    <div id="" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <%--<button class="btn borderbtn mr-5" id="addBtn" data-bs-toggle="modal" data-bs-target="#addDesignationModal"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>--%>
                            <button class="btn borderbtn mr-5" id="addBtn" onclick="AddLeave()"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                            <button class="btn borderbtn deletebtn" id="deleteBtn" onclick="DeleteLeavesAfterConfirm()">Delete</button>
                           <%-- <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>--%>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>

                        <div class="RPMtblouter" style="height: 691px;">
                            <table class="table table-bordered" id="leaveMastertbl" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>Leave Type</th>
                                        <th>Leave Entitlement</th>
                                        <th>Balance Leaves</th>
                                        <th>
                                            <div class="custom_chckbox">
                                                <input id="LeaveCheckList0" class="chckHead1" type="checkbox">
                                                <label for="LeaveCheckList0"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="leaveMastertblMain">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="clearfix"></div>
    </div>
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
                        <strong>Note:</strong> Leave Type(s) which is in use cannot be deleted.<br />
                        <p id="showdeleterow"></p>
                    </div>

                    <div class="text-right">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Add DesignationmodAL-->
    <div class="modal custmodal fade" id="addDesignationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <input type="hidden" name="hdnLeaveId" id="hdnLeaveId" />
        <div class="modal-dialog modalsmall ui-draggable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Employee Leave Details</h5>
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
                        <% CommonFunctions.HTMLControls.DrawTextBox("txtLeaveEntitlement", "txtLeaveEntitlement", cssClass:="form-control", widthInPixel:=0, maxLength:=8, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)'")%>
                    </div>
                    <div class="form-group">
                        <label class="required">Balance Leaves</label>
                        <% CommonFunctions.HTMLControls.DrawTextBox("txtBalanceLeaves", "txtBalanceLeaves", cssClass:="form-control", widthInPixel:=0, maxLength:=8, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)'")%>
                    </div>
                    <%-- <div class="form-group">
                        <label class="">Pro-Rata</label>
                        <% CommonFunctions.HTMLControls.DrawTextBox("txtLeaveProRata", "txtLeaveProRata", cssClass:="form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onkeypress='return Field_OnKeyPressPro(event)'")%>
                    </div>--%>
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
    <!--add modal start here-->
    <div class="modal custmodal fade" id="AddCertModal" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Certification</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <label class="required">Certification Name</label>
                        <input type="text" class="form-control" />
                    </div>
                    <br />
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        <button class="btn btnyellow" data-bs-dismiss="modal">Save</button>
                        <button class="btn btnyellow" data-bs-dismiss="modal">Save And Add</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Add modal end here-->
    <!--Leave approvars modal start here-->
    <div class="modal custmodal fade" id="LeavAprovalModal" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Leave Approvers</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="table-responsive" style="max-height: 300px;">
                        <table class="table table-bordered" id="approverTbl">
                            <thead>
                                <tr>
                                    <th class="text-start">Approvers</th>
                                    <th class="text-start">Employee Name</th>
                                </tr>
                            </thead>
                            <tbody id="approverTblMain">
                            </tbody>
                        </table>
                    </div>
                    <br />
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>

                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Leave approvers modal end-->
    <!--pro rata modal start here-->

    <!--pro rata modal end-->
    <!--Excel Upload Modal start here-->

    <div id="exceluploadsteps" class="modal fade custmodal">
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
                                    <p><span id="plabelName">Attach file or drop here :-</span><span id="dvShowFileName"></span></p>
                                    <button type="submit">Upload</button>
                                </form>
                                <div class="clearfix"></div>
                            </div>

                            <div class="clearfix"></div>
                            <br />
                            <br />
                            <div class="list-inline text-center">
                                <button type="button" class="btn btnyellow nextwizardbtn ml-1 " onclick="EmpUploadxlsfile()">Next</button>
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

                            <%--                            <br />
                            <br />--%>
                            <ul class="list-inline text-center">
                                <li>
                                    <button id="btnPrevious" type="button" class="btn borderbtn btnPrevious" onclick="IrmBackStep_2()">Back</button>
                                    <button type="button" class="btn btnyellow nextwizardbtn ml-1 " onclick="IrmNextStep_2()">Next</button></li>
                            </ul>

                        </div>
                        <div class="tab-pane" id="PBEUstep3">
                            <div class="float-start" style="width: 100%">
                                <a href="#">Uploaded Data : <span id="dvShowFileNameStep3"></span></a>
                                <div class="form-group float-end">
                                    <div class="input-group searchsetting" id="searchsetting">
                                        <input id="txtSearchXlsxEmpName" type="text" class="form-control searchempname" placeholder="Search Employee name" onkeyup="SearchEmplistByName()">
                                        <span class="input-group-addon">
                                            <button type="submit" onclick="SearchEmplistByName()">
                                                <span class="glyphicon glyphicon-search"></span>
                                            </button>
                                        </span>
                                    </div>
                                </div>

                                <%--<div class="clearfix"></div>--%>
                                <div class="dataTables_scrollBody" style="position: relative; overflow: auto; width: 100%; height: auto;">
                                    <table id="exluploadTbl" class="table bgwhite table-bordered" style="width: 100%;">
                                        <thead>
                                            <tr>
                                                <th>Is Valid</th>
                                                <th>Employee Code</th>
                                                <th>Employee Name</th>
                                                <th>Request Type</th>
                                                <th>Leave Type</th>
                                                <th>From Date</th>
                                                <th>To Date</th>
                                                <th>Half Day</th>
                                                <th>Reason</th>
                                                <th>Status</th>
                                                <th>Applied Date</th>
                                                <th>Approved Date</th>
                                                <th>Number Of Days</th>
                                                <th>Error</th>
                                            </tr>
                                        </thead>

                                        <tbody id="exluploadTblTbody">
                                        </tbody>

                                    </table>
                                </div>
                                <br />
                                <br />
                                <ul class="list-inline text-center">
                                    <li>
                                        <button id="btnPrevious" type="button" class="btn borderbtn btnPrevious" onclick="IrmBackStep_3()">Back</button>
                                        <button type="button" class="btn btnyellow nextwizardbtn ml-1 uploadbtn" onclick="IrmSaveXlsxData()">Upload</button>
                                    </li>
                                </ul>
                            </div>
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
    <!-- REQUIRED JS SCRIPTS -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
 --%>   <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script> 
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
     <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js?v=1.5"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js?v=1.5"></script>--%>
    <script>

        //Added By Riddhesh Patil on 11-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil
        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").hover(function () {
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip('update');
        }); //added by pradip on 24-3-2023

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
        var employeeTable;
        var leaveTable;
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
        document.getElementById('plabelName').innerHTML = "Attach file or drop here :-";
        
        $(document).ready(function () {
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();

            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            FillFilterOUForFilter(0);
            if (blnAddAccess == "False") {
                $("#addBtn").addClass("clsShowHide");
                $("#btnUpload").addClass("clsShowHide");
                $("#btnDownloadTemplate").addClass("clsShowHide");
                $('#btnSaveLeave').attr("disabled", true);

            }
            else {
                $("#addBtn").removeClass("clsShowHide");
                $("#btnUpload").removeClass("clsShowHide");
                $("#btnDownloadTemplate").removeClass("clsShowHide");
                $('#btnSaveLeave').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#deleteBtn").addClass("clsShowHide");
            }
            else {
                $("#deleteBtn").removeClass("clsShowHide");
            }

            if (blnViewAccess == "True") {
                GetMaximumItemsToShowInList();
                //GetMyQFilter(0);
                //if (currentDefaultFilterID > 0) {
                //    ApplySavedFilter(currentDefaultFilterID, 2);
                //    FilterApplied();

                //} else {
                GetEmployees(null);
                 $(".mainclearalllink").addClass("clsShowHide"); //Addded by Chetan M on 9 Aug 2021 for clear filter
                // FilterNotApplied();
                //}
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
             //Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
            BindPlaceholder("cboEMPFilterBusinessGroupID", "Business Group");            
            BindPlaceholder("cboEMPFilterDesignationID", "Designation");
            //End of Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
        });

        var isValidTypeExeCheck;
        var isValidTypeExeCheckFlag=false;
        async function fileValidation() {
            var fileInput = document.getElementById('txtFileUpload');
            var filePath = fileInput.value;
            // Allowing file type 
            //Commented & Added By Rutuja D. on 13 Aug 2021 For Allow xls File format
            //var allowedExtensions = /(\.xlsx)$/i;
            var allowedExtensions = /(\.(xlsx|xls))$/i;
            //End of Commented & Added By Rutuja D. on 13 Aug 2021 For Allow xls File format
            
            if (!allowedExtensions.exec(filePath)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Only xlsx and xls file format is allowed.");
                isValidTypeExeCheckFlag = false;
                return false;
            }
                //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
            else if (fileInput.value!="") {
                var fileName = fileInput.value;
                var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

                var objFileName = fileInput;
                isValidTypeExeCheck = false;
                //Commented and Added by Aditya J. on 25-11-2024
                //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
                var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
                //End of comment Added by Aditya J. on 25-11-2024
                isValidTypeExeCheck = ValidExtsExe.includes(extension);

                if (isValidTypeExeCheck) {
                    const file = objFileName.files[0];
                    //const error = await validateDocFileForExe(file);
                    //console.log(error);
                    //await checkFileForExe(file);
                     await validateDocFileForExe(file)
                        .then(() => {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success("File is valid and ready to upload.");
                            isValidTypeExeCheckFlag=true
                        })
                         .catch(error => {

                             //Added by Ajit L on 21/11/2024
                             document.getElementById('plabelName').innerHTML = "Attach file or drop here :-";
                             document.getElementById('dvShowFileName').innerHTML = ''
                           //End of Added by Ajit L on 21/11/2024

                            console.log(error);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                            isValidTypeExeCheck = false;
                             isValidTypeExeCheckFlag = false;

                             $(file).val("");

                            /*$(objFileName).attr("placeholder", "Upload File");*/
                            //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                            return;
                        });



                    if (!isValidTypeExeCheck) {
                        return;
                    }
                }

            //$(objtxtFileName).val("");

            //Ended by Parth Godshelwar
            }
                //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
            //else if (SelectedFile == 'undeifned' || SelectedFile.length = 0 || SelectedFileName ==""){
            //    alertify.set('notifier', 'position', 'top-right');
            //  alertify.error("Please select file.");
            //}
            else { return true; }
            return isValidTypeExeCheckFlag;

        }

        //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
        //function validateDocFileForExe(file) {

        //    return new Promise((resolve, reject) => {
        //        //debugger;

        //        const reader = new FileReader();

        //        reader.onload = function (e) {
        //            const arrayBuffer = e.target.result;
        //            const uint8 = new Uint8Array(arrayBuffer);

        //            // Function to search for a specific byte sequence
        //            const containsSignature = (signature) => {
        //                for (let i = 0; i < uint8.length - signature.length + 1; i++) {
        //                    let found = true;
        //                    for (let j = 0; j < signature.length; j++) {
        //                        if (uint8[i + j] !== signature[j]) {
        //                            found = false;
        //                            break;
        //                        }
        //                    }
        //                    if (found) return true;
        //                }
        //                return false;
        //            };

        //            // Check for 'MZ' signature (common for Windows EXE files)
        //            const mzSignature = [0x4D, 0x5A]; // 'M' 'Z'
        //            if (containsSignature(mzSignature)) {
        //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // Additional checks can be added here (e.g., searching for .exe strings)
        //            // Example: Check for ".exe" string in ASCII
        //            const exeString = [0x2E, 0x65, 0x78, 0x65]; // '.' 'e' 'x' 'e'
        //            if (containsSignature(exeString)) {
        //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // If no signatures are found, the file is considered safe
        //            resolve();
        //        };

        //        reader.onerror = function () {
        //            reject("Error reading the file. Please try again.");
        //        };

        //        // Read the file as an ArrayBuffer
        //        reader.readAsArrayBuffer(file);
        //    });
        //}

        //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not

        //Added By Riddhesh Patil on 11-NOV-2022 
        var specialKeys = new Array();
        specialKeys.push(8);
        function Field_OnKeyPress(e, fieldId) {
            // debugger;
            // console.log(fieldId);
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    // $("#txtResourceDemand").focus();
                    // $("#txtProbabilityCurrent").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please enter only numeric values.");
                }
            }
            return ret;
        }
        //End of Added By Riddhesh Patil on 11-NOV-2022 

        function IrmNextStep_2() {
            //Added by Chetan M on 16 Aug 2021 for manditory validation alert
            alertify.set('notifier', 'position', 'top-right');
            if ($("#CboIrmExcelColumn_A").val() == "" || $("#CboIrmExcelColumn_A").val() == 0 || $("#CboIrmExcelColumn_A").val() != "1") {
                alertify.error("Please select Employee Code.");
                $("#CboIrmExcelColumn_A").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_B").val() == "" || $("#CboIrmExcelColumn_B").val() == 0 || $("#CboIrmExcelColumn_B").val() != "2") {
                alertify.error("Please select Employee Name.");
                $("#CboIrmExcelColumn_B").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_C").val() == "" || $("#CboIrmExcelColumn_C").val() == 0 || $("#CboIrmExcelColumn_C").val() != "3") {
                alertify.error("Please select Request Type.");
                $("#CboIrmExcelColumn_C").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_D").val() == "" || $("#CboIrmExcelColumn_D").val() == 0 || $("#CboIrmExcelColumn_D").val() != "4") {
                alertify.error("Please select Leave Type.");
                $("#CboIrmExcelColumn_D").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_E").val() == "" || $("#CboIrmExcelColumn_E").val() == 0 || $("#CboIrmExcelColumn_E").val() != "5") {
                alertify.error("Please select From Date.");
                $("#CboIrmExcelColumn_E").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_F").val() == "" || $("#CboIrmExcelColumn_F").val() == 0 || $("#CboIrmExcelColumn_F").val() != "6") {
                alertify.error("Please select To Date.");
                $("#CboIrmExcelColumn_F").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_G").val() == "" || $("#CboIrmExcelColumn_G").val() == 0 || $("#CboIrmExcelColumn_G").val() != "7") {
                alertify.error("Please select Half Day.");
                $("#CboIrmExcelColumn_G").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_H").val() == "" || $("#CboIrmExcelColumn_H").val() == 0 || $("#CboIrmExcelColumn_H").val() != "8") {
                alertify.error("Please select Reason.");
                $("#CboIrmExcelColumn_H").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_I").val() == "" || $("#CboIrmExcelColumn_I").val() == 0 || $("#CboIrmExcelColumn_I").val() != "9") {
                alertify.error("Please select Status.");
                $("#CboIrmExcelColumn_I").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_J").val() == "" || $("#CboIrmExcelColumn_J").val() == 0 || $("#CboIrmExcelColumn_J").val() != "10") {
                alertify.error("Please select Applied Date.");
                $("#CboIrmExcelColumn_J").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_K").val() == "" || $("#CboIrmExcelColumn_K").val() == 0 || $("#CboIrmExcelColumn_K").val() != "11") {
                alertify.error("Please select Approved Date.");
                $("#CboIrmExcelColumn_K").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_L").val() == "" || $("#CboIrmExcelColumn_L").val() == 0 || $("#CboIrmExcelColumn_L").val() != "12") {
                alertify.error("Please select Number Of Days.");
                $("#CboIrmExcelColumn_L").focus();
                return false;
            }
            else {
                //End of Added by Chetan M on 16 Aug 2021 for manditory validation alert
                //Comment And Added By Riddhesh Patil on 13 April 2023 
                //$("#btnaStep3").click();
                $("#exceluploadsteps .pointerDisable").removeClass('active');
                $("#exceluploadsteps ul.nav-wizard li:nth-child(3)").addClass('active');
                $("#exceluploadsteps .tab-pane").removeClass('active');
                $("#PBEUstep3").addClass('active');
                //End of Comment And Added By Riddhesh Patil on 13 April 2023
            }
            
        }
        function IrmBackStep_2() {
            //Comment And Added By Riddhesh Patil on 13 April 2023 
            // $("#btnaStep1").click();
            $("#exceluploadsteps .pointerDisable").removeClass('active');
            $("#exceluploadsteps ul.nav-wizard li:nth-child(1)").addClass('active');
            $("#exceluploadsteps .tab-pane").removeClass('active');
            $("#PBEUstep1").addClass('active');
            //End of Comment And Added By Riddhesh Patil on 13 April 2023
        }
        function IrmBackStep_3() {
            //Comment And Added By Riddhesh Patil on 13 April 2023 
            //$("#btnaStep2").click();
            $("#exceluploadsteps .pointerDisable").removeClass('active');
            $("#exceluploadsteps ul.nav-wizard li:nth-child(2)").addClass('active');
            $("#exceluploadsteps .tab-pane").removeClass('active');
            $("#PBEUstep2").addClass('active');
            //End of Comment And Added By Riddhesh Patil on 13 April 2023
        }
        function showName() {

            var name = document.getElementById('txtFileUpload');
            //If Condition Added By Rutuja D. on 17 Sep 2021 For Javascript coming REading FileName
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
        function Fillstep_2DropDowUsingColumnName() {
            var Step2DrpList = [
                { Name: 'Employee Code', Value: 1 },
                { Name: 'Employee Name', Value: 2 },
                { Name: 'Request Type', Value: 3 },
                { Name: 'Leave Type', Value: 4 },
                { Name: 'From Date', Value: 5 },
                { Name: 'To Date', Value: 6 },
                { Name: 'Half Day', Value: 7 },
                { Name: 'Reason', Value: 8 },
                { Name: 'Status', Value: 9 },
                { Name: 'Applied Date', Value: 10 },
                { Name: 'Approved Date', Value: 11 },
                { Name: 'Number Of Days', Value: 12 },


            ];
            var arrExcelFields = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"];
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
                $(CboID).prop("disabled", true);
                $(CboID).val(i + 1);
            }
        }

        function ResetExcelFiledDropdown() {
            var arrExcelFields = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"];;
            var LengthOfExcelField = arrExcelFields.length;

            for (var i = 0; i < LengthOfExcelField; i++) {
                var CboID = "#CboIrmExcelColumn_" + arrExcelFields[i];
                $(CboID).val(0);
            }
        }
        function convert(str) {
            var date = new Date(str),
                mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                day = ("0" + date.getDate()).slice(-2);
            return [date.getFullYear(), mnth, day].join("-");
        }
        async function EmpUploadxlsfile() {
            Fillstep_2DropDowUsingColumnName();
            var SelectedFile = txtFileUpload.files;
            var SelectedFileName = document.getElementById('dvShowFileName').innerHTML;
            if (SelectedFile != 'undeifned' && SelectedFile.length > 0 && SelectedFileName != "") {
                var isFileValid =await fileValidation()
                
                if (isFileValid === true) {
                    var data = new FormData();
                    data.append("file", SelectedFile[0]);
                    $.ajax({
                        url: strUrl + '/api/RM_EmployeeLeaves/UploadEmpXlsxFile',
                        type: "POST",
                        data: data,
                        contentType: false,
                        processData: false,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        },
                        success: function (data) {
                            EmpXslxList = data;
                            ReloadEmpXslxData(EmpXslxList);
                            //Added By Imran                           
                            if (EmpXslxList.length > 0)
                            {
                                var ChkValidationBlank = BlankExcelColumnCheck(EmpXslxList);
                                ChkValidationBlank=ChkValidationBlank.split('~');                               
                            }

                            if (ChkValidationBlank[0] == 0)
                            {
                                ReloadEmpXslxData(EmpXslxList);

                                //Comment And Added By Riddhesh Patil on 13 April 2023
                                //  $("#btnaStep2").click();

                                $("#exceluploadsteps .pointerDisable").removeClass('active');
                                $("#exceluploadsteps ul.nav-wizard li:nth-child(2)").addClass('active');
                                $("#exceluploadsteps .tab-pane").removeClass('active');
                                $("#PBEUstep2").addClass('active');
                               //End of Comment And Added By Riddhesh Patil on 13 April 2023
                            }
                            else
                            {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ChkValidationBlank[1])
                            }                             
                            //End of Added By Imran                           
                            //StopAjaxLoader("#bodyInfraGroup");
                            //$(".chckHead").prop("checked", false);
                        },
                        //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                        //error: function (err) {
                        //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        //    //StopAjaxLoader("#bodyBusiness-group");
                        //}
                         error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                        }
                         //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
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
            console.log(objXlsx);

            $.each(XlsxObj, function (index, objXlsx)
            {
                if (objXlsx.ColumnError != null) {
                    TBlankCheck += 1;
                    if (objXlsx.ColumnError.indexOf(':{0}') > -1) {
                        tColumnvalue = objXlsx.ColumnError.replaceAll(':{0}', '<br>');
                        tColumnvalue = tColumnvalue.replaceAll(':{1}', '<br>');
                        tColumnvalue = tColumnvalue.replaceAll(':', '<br>');
                    }
                    else if (objXlsx.ColumnError.indexOf(':{1}') > -1) {
                        tColumnvalue += objXlsx.ColumnError.replaceAll(':{1}', '<br>');
                    }
                    else if (objXlsx.ColumnError.indexOf(':') > -1) {
                        tColumnvalue += objXlsx.ColumnError.replaceAll(':', '<br>');
                    }
                    else { }
                }
            });
            tColumnvalue = tColumnvalue.replace('<br>', '');
            return TBlankCheck + '~' + tColumnvalue.replaceAll(':','<br>');
        }
        //End by imran 23-08-2021

        $('#txtSearchXlsxEmpName').keyup(function () {
            SearchEmplistByName();
        });
        function SearchEmplistByName() {
            var SearchedXslxEmpNameText = $("#txtSearchXlsxEmpName").val();
            var FilterxslxList = EmpXslxList.filter(function (x) { return x.EmployeeName.toLowerCase().indexOf(SearchedXslxEmpNameText.toLowerCase()) !== -1 });
            ReloadEmpXslxData(FilterxslxList);
        }
        function ReloadEmpXslxData(XlsxList) {
            var strHTML = "";
            if (XlsxList.length > 0) {
                $.each(XlsxList, function (index, objXlsx) {
                    //Added By Rutuja D. on 4 Feb 2022 For Get the Request Type 
                    if (objXlsx.RequestType == 'L' || objXlsx.RequestType == 'l') {
                        objXlsx.RequestType = 'Leave';
                    }
                    else if (objXlsx.RequestType == 'W' || objXlsx.RequestType == 'w') {
                        objXlsx.RequestType = 'Work From Home';
                    }
                    //End of Added By Rutuja D. on 4 Feb 2022 For Get the Request Type 

                    if (objXlsx.ColumnError == null || objXlsx.ColumnError == "" || objXlsx.ColumnError == 'undefined') {
                        strHTML += '<tr><td><div class="custom_chckbox" '
                        strHTML += ' <input type = "hidden" name = "hdn_EmpRoleId2"  id ="hdn_EmpRoleId2" value =' + objXlsx.RoleID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpRoleId"  id ="hdn_EmpRoleId" value =' + objXlsx.RoleID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpID"  id ="hdn_EmpID" value =' + objXlsx.EmployeeID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpLeaveID" id = "hdn_EmpLeaveID" value = ' + objXlsx.LeaveTypeID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpStatusID" id = "hdn_EmpStatusID" value = ' + objXlsx.LeaveStatusID + ' >';
                        strHTML += ' <input id="' + index + '"   class="chcktblXlsx" type="checkbox" checked="true"><label for="' + index + '"></label></div> </td>';
                        strHTML += ' <td> ' + objXlsx.EmployeeCode + ' </td> <td> ' + objXlsx.EmployeeName + '</td> <td>' + objXlsx.RequestType + '</td><td>' + objXlsx.LeaveType + '</td>  <td>' + objXlsx.FromDate + '</td>  <td>' + objXlsx.ToDate + '</td>  <td>' + objXlsx.HalfDay + '</td>  <td>' + objXlsx.Reason + '</td><td>' + objXlsx.Status + '</td>  <td>' + objXlsx.AppliedDate + '</td> ';
                        strHTML += ' <td>' + objXlsx.ApprovedDate + '</td><td> ' + objXlsx.NumberOfDays + '</td><td> </td>';
                        strHTML += ' </tr > ';

                    }
                    else {
                        strHTML += '<tr  style="color:red;"><td><div class="custom_chckbox" '
                        strHTML += ' <input type = "hidden" name = "hdn_EmpRoleId2"  id ="hdn_EmpRoleId2" value =' + objXlsx.RoleID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpRoleId"  id ="hdn_EmpRoleId" value =' + objXlsx.RoleID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpID"  id ="hdn_EmpID" value =' + objXlsx.EmployeeID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpLeaveID" id = "hdn_EmpLeaveID" value = ' + objXlsx.LeaveTypeID + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpStatusID" id = "hdn_EmpStatusID" value = ' + objXlsx.LeaveStatusID + ' >';
                        strHTML += ' <input id="' + index + '"   class="chcktblXlsx" type="checkbox" disabled="disabled"><label for="' + index + '"></label></div> </td>';
                        strHTML += ' <td> ' + objXlsx.EmployeeCode + ' </td> <td> ' + objXlsx.EmployeeName + '</td> <td>' + objXlsx.RequestType + '</td><td>' + objXlsx.LeaveType + '</td>  <td>' + objXlsx.FromDate + '</td>  <td>' + objXlsx.ToDate + '</td>  <td>' + objXlsx.HalfDay + '</td>  <td>' + objXlsx.Reason + '</td><td>' + objXlsx.Status + '</td>  <td>' + objXlsx.AppliedDate + '</td> ';
                        strHTML += ' <td>' + objXlsx.ApprovedDate + '</td><td> ' + objXlsx.NumberOfDays + '</td><td> ' + objXlsx.ColumnError + '</td>';
                        strHTML += ' </tr > '
                    }

                });
            } else {
                strHTML = '<tr><td colspan="21">' + NoDataFound + ' </td></tr>'
            }
            $("#exluploadTblTbody").html(strHTML);
        }
        function IrmSaveXlsxData() {
            var xlsxSelectedList = []
            var message = '';

            $("#exluploadTbl input[type=checkbox]:checked").each(function ()
            {               
                var objxlsxSelectedList = {}
                var row = $(this).closest("tr")[0];
                //var hdnField = $(this).closest("tr").find;
                var FirstTd = $(this).parent().parent("td");//.find("#hdn_EmpBusinessGroupID").val()
                //console.log($('tr td', '#exluploadTbl').eq(0).find('#hdn_EmpLocationID').val());
                var hdn_EmpID = FirstTd.find('#hdn_EmpID').val();
                var hdn_EmpLeaveID = FirstTd.find('#hdn_EmpLeaveID').val();
                var hdn_EmpStatusID = FirstTd.find('#hdn_EmpStatusID').val();

                objxlsxSelectedList.EmployeeCode = row.cells[1].innerHTML;
                objxlsxSelectedList.EmployeeName = row.cells[2].innerHTML;
                //objxlsxSelectedList.RequestType = row.cells[3].innerHTML;
                if (row.cells[3].innerHTML == 'Leave') {
                    objxlsxSelectedList.RequestType = 'L';
                }
                else if (row.cells[3].innerHTML == 'Work From Home') {
                    objxlsxSelectedList.RequestType = 'W';
                }
                objxlsxSelectedList.LeaveType = row.cells[4].innerHTML;                
                objxlsxSelectedList.FromDate = row.cells[5].innerHTML; 
                objxlsxSelectedList.ToDate = row.cells[6].innerHTML;
                objxlsxSelectedList.HalfDay = row.cells[7].innerHTML;
                objxlsxSelectedList.Reason = row.cells[8].innerHTML;
                objxlsxSelectedList.AppliedDate = row.cells[10].innerHTML;
                objxlsxSelectedList.ApprovedDate = row.cells[11].innerHTML;
                objxlsxSelectedList.NumberOfDays = row.cells[12].innerHTML;

                //  var IsDeployed = row.cells[18].innerHTML;
                //   objxlsxSelectedList.Deployable = IsDeployed == 'Yes' || IsDeployed == 'yes' ? 'D' : 'N'

                ///value field
                objxlsxSelectedList.EmployeeID = hdn_EmpID;
                objxlsxSelectedList.LeaveTypeID = hdn_EmpLeaveID;
                objxlsxSelectedList.LeaveStatusID = hdn_EmpStatusID;
                objxlsxSelectedList.UploadedBy = UserName;
                xlsxSelectedList.push(objxlsxSelectedList);

            });

            EmpSaveXlsxDataSelectedData(xlsxSelectedList)
        }

        //Added by imran 23-08-2021
        function ConvertDate(dateStr)
        {
            //debugger;
            var parts = dateStr.replace(' 00:00:00', '');
            parts = dateStr.split("-");
            return (parts[2].replace(' 00:00:00','') +'-'+ parts[1]+'-'+ parts[0]);
        }
        //end by imran 23-08-2021

        function EmpSaveXlsxDataSelectedData(xlsxSelectedList)
        {
            if (xlsxSelectedList != null && xlsxSelectedList.length > 0) 
            {
                var strHTML = "";
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeLeaves/SaveLeavesDetails',
                    type: "POST",
                    data: JSON.stringify(xlsxSelectedList),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (xlsxSelectedList) {
                            xhr.setRequestHeader("Params", encryptString(isJson(xlsxSelectedList) ? xlsxSelectedList : JSON.stringify(xlsxSelectedList)));
                        }
                    },
                    success: function (data) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("File uploaded successfully.");
                        $('#exceluploadsteps').modal('hide');
                    },
                    //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    //StopAjaxLoader("#bodyBusiness-group");
                    //}
                     error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                    //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("There is no valid record to upload .");
            }
        }
        function EmpOpenExceluploadsteps() {
            //Comment And Added By Riddhesh Patil on 13 April 2023 
            //$("#btnaStep1").click();
            $("#exceluploadsteps .pointerDisable").removeClass('active');
            $("#exceluploadsteps ul.nav-wizard li:nth-child(1)").addClass('active');
            $("#exceluploadsteps .tab-pane").removeClass('active');
            $("#PBEUstep1").addClass('active');
            //End of Comment And Added By Riddhesh Patil on 13 April 2023
            ReloadEmpXslxData("");
            var $el = $('#frmFileUpload');
            $el.wrap('<form>').closest('form').get(0).reset(); $el.unwrap();
            document.getElementById('plabelName').innerHTML = "Attach file or drop here :-";
            document.getElementById('dvShowFileName').innerHTML = ''

            $('#exceluploadsteps').modal('show');
        }
        function GetMaximumItemsToShowInList() 
        {
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
                            window.location.href = "../../General/default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
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


        function FillFilterOUForFilter(params) {
            var strHTML = "";
            var BusinessGroupID = $('#cboEMPFilterBusinessGroupID').val();
           // alert($('#cboEMPFilterBusinessGroupID').val());
            
            var objBGCODE = { BusinessGroupID: BusinessGroupID }
            //console.log(objBGCODE)
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
                    //$("#cboOPRFilterLocationID").empty();  //Commented By Chetan M. For Bind Filter Placeholder on 14 July 2021
                    //strHTML += "<option value='0'></option>"; 
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    }
                    if (params != null && params > 0 && params != undefined)
                        $("#cboEMPFilterLocationID").val(params);

                    $("#cboEMPFilterLocationID").html(strHTML);
                     //Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
                    BindPlaceholder("cboEMPFilterLocationID", "Organization Unit"); 
                     //End of Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
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
                            //console.log(thrownError);
                            window.location.href = "../../General/default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

            //}
        }

        function GenerateBasicFilterQueryRes(module, filterField) {
            try {
                var strqtext = "";
                var txtBoxvalue = 0;
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    var strTXT = $('#txt' + module + 'Filter' + filterField[i]).val();
                    if (strOp != null && strOp != 'undefined' && strOp != "") {
                        strvalue = strOp
                    }
                    if (filterField[i] == "EmployeeName" && strTXT != "") {

                        if (strqtext != "") strqtext += " AND ";
                        strqtext += filterField[i] + " LIKE ";
                        strqtext += ' "%' + strTXT + '%"';
                        // strqtext +=  "' + strvalue + '"';
                    }

                    if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                        if (strqtext != "") strqtext += " AND ";
                        if (strOp != "0") {

                            strqtext += filterField[i] + " = ";
                            //strqtext += " ''%" + strvalue + "%''";
                            strqtext += ' "' + strvalue + '"';
                        }

                        else {

                            strqtext += filterField[i] + " ";
                            if ($.isNumeric(strvalue) == false) {
                                strqtext += strOp + " ''" + strvalue + "''";
                            }
                            else {
                                //strqtext += strOp + " " + strvalue + "";
                                strqtext += strOp + ' "' + strvalue + '"';
                            }
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
        function ApplyEmpFilter() {
            var filterWhereClause;
            var AllResFilter = ["BusinessGroupID", "LocationID", "DesignationID", "EmployeeName"];
            var filterWhereClause2 = GenerateBasicFilterQueryRes("EMP", AllResFilter);
            // filterWhereClause = filterWhereClause2.replace(/"/g, "\''");
            GetEmployees(encodeURIComponent(filterWhereClause2));
            $(".mainclearalllink").removeClass("clsShowHide"); //Added by Chetan M on 9 Aug 2021 for clear all
        }

        function CboRPMResource_OnChange(bgId) {
            //if (bgId == undefined || bgId == null || bgId == "") {
            //    FillOU(0);
            //    //ApplyResFilter();
            //}
            //ApplyEmpFilter();
        }
        function GetEmployees(filterWhereClause) {
            SelectedQID = [];

            //Added by imran on 19-08-2022
            if (filterWhereClause =="") {
                filterWhereClause = "";
            }
            //End of comment by imran on 19-08-2022

            var strHTML = "";
            var FilterParms = {
                EmpWhereClause: filterWhereClause,
                   EmployeeID : SessionEmployeeId
            };
            //  StartLoader("#body-Employee");
            $.ajax({
                url: strUrl + '/api/RM_EmployeeLeaves/GetApprovedEmployees',
                type: "POST",
                data: JSON.stringify(FilterParms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (FilterParms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterParms) ? FilterParms : JSON.stringify(FilterParms)));
                    }
                },
                success: function (data) {
                    var List = data;

                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            if (blnEditAccess == "True") {
                                //strHTML += '<tr><td class="text-start"><a href="javascript:;" class="BGdetalilink" onclick="editMEMDetails()"</a> <input type="hidden" name="hdn_EmployeeID" id="hdn_EmployeeID" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + '</td><td>' + obj.EmailID + '</td><td> ' + obj.Phone + '</td><td>' + obj.NoOfLeaves + '</td><td>' + obj.LeaveBalance + '</td></tr>';
                                strHTML += '<tr><td class="text-start"><a href="javascript:;" class="BGdetalilink" </a> <input type="hidden" name="hdn_EmployeeID" id="hdn_EmployeeID" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + '</td><td>' + obj.EmailID + '</td><td> ' + obj.Phone + '</td><td>' + obj.NoOfLeaves + '</td><td>' + obj.LeaveBalance + '</td></tr>';
                            }
                            else {
                                strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_EmployeeID" id="hdn_EmployeeID" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + '</td><td>' + obj.EmailID + '</td><td> ' + obj.Phone + '</td><td>' + obj.NoOfLeaves + '</td><td>' + obj.LeaveBalance + '</td></tr>';
                            }

                        });
                    }

                    $('#ELMTblP').dataTable().fnDestroy();
                    $("#ELMTblMain").html(strHTML);
                    LoadPagination(data);
                    //  StopAjaxLoader("#body-Employee");
                    $(".chckHead").prop("checked", false);
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#body-Employee");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

        }
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            employeeTable = $('#ELMTblP').dataTable({
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
                //Added by imran on 19-08-2022
                pageLength: 10,
                //End of comment by imran on 19-08-2022
            });

        }

        function LoadPaginationLeaves(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            leaveTable = $('#leaveMastertbl').dataTable({
                "sscrolly": (0.5 * $(window).height()),
                "bpaginate": false,
                "bjqueryui": true,
                "bscrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "bautowidth": true,
                "sscrollx": "100%",
                "sscrollxinner": "100%",
                "lengthChange": false,
                "searching": false,
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [3] }]// Added By Pradip on 20 July 2021
            });

        }

        ///function editMEMDetails() {
        //$(".dataTables_scrollBody").css("height", "auto!important");
        $('#ELMTblMain').on('click', '.BGdetalilink', function () {
            var $row = $(this).closest("tr");
            $tds = $row.find("td");
            var hdnEmpId = $row.find('#hdn_EmployeeID').val();
            $('#hdnEmp_UniqueID').val(hdnEmpId);
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            GetEmpLeaves(hdnEmpId);
            //used for disable grid
            $("#DesignnationListTbl_wrapper .dataTables_scrollBody, .paginate_button, .backbtn, .addbtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            $(".table").resize();
        });
        // }
        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
            $(".table").resize();
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#DesignnationListTbl_wrapper .dataTables_scrollBody, .paginate_button, .backbtn, .addbtn, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();
            GetEmployees(null);
        });


        function onCloseLeaves() {
            $('#txtLeaveEntitlement').val("");
            // $('#txtLeaveProRata').val("");
            $('#txtBalanceLeaves').val("");
            $('#txtLeaveTypeID').val(0);
            $('#hdn_UniqueID').val(0);
            

        }

        function AddLeave() {
            $('#addDesignationModal').modal('show');
            $('#hdn_UniqueID').val(0);
            $("#hdnLeaveId").val(0);
             $("#txtLeaveTypeID").removeAttr("disabled");
        }

        function editLeavesDetails() {
            $('#leaveMastertblMain').on('click', '.Leavesdetalilink', function () {
                var $row = $(this).closest("tr");
                $tds = $row.find("td");
                var hdnLeaveId = $row.find('#hdn_UniqueID').val();
                var hdnLeaveTypeId = $row.find('#hdn_LeaveTypeID').val();
                //alert(hdnLeaveId);
                //  var txtOT = $row.find('#hdnOT').val();
                $.each($tds, function (index, obj) {
                    //if (hdnLeaveTypeId != 'undefined' && hdnLeaveTypeId != null) {
                    //    $("#txtLeaveTypeID").val(hdnLeaveTypeId);
                    //}
                    //if (index == 0) {
                    //    $('#txtLeaveTypeID').val($(this).text());
                    //}
                    if (index == 1) {
                        $('#txtLeaveEntitlement').val(parseInt($(this).text()));
                    }
                    if (index == 2) {
                        $('#txtBalanceLeaves').val(parseInt($(this).text()));
                    }
                    //if (index == 3) {
                    //    $('#txtLeaveProRata').val($(this).text());
                    //}
                    $('#txtLeaveTypeID').val(hdnLeaveTypeId);

                });
                $('#hdnLeaveId').val(hdnLeaveId);
                $('#addDesignationModal').modal('show');
               $("#txtLeaveTypeID").attr("disabled", "disabled");
            });
        }

        //Added By Riddhesh Patil on 11-NOV-2022 
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
		//End of Added By Riddhesh Patil

        function checkValidationLeaves() {
            var txtLeaveEntitlement = $('#txtLeaveEntitlement').val();
            var txtBalanceLeaves = $('#txtBalanceLeaves').val();
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
          //Added By Dipali V On 2nd Dec 2021 For Leave Should not consider 0 Or negative
            else if ($("#txtLeaveEntitlement").val().trim()!= null && $("#txtLeaveEntitlement").val().trim() < 0 ) {
                $("#txtLeaveEntitlement").focus();
                validateflagLeaves = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Leave Entitlement' should be Positve Number");
                return false;
            }
            else if ($("#txtLeaveEntitlement").val().trim() != null && parseInt($("#txtLeaveEntitlement").val().trim()) == 0) {
                $("#txtLeaveEntitlement").focus();
                validateflagLeaves = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Leave Entitlement' should be greater than 0");
                return false;
            }
           //End of Added By Dipali V On 2nd Dec 2021 For Leave Should not consider 0 Or negative
           // else if (txtLeaveEntitlement != null && txtLeaveEntitlement.match(/^(-?\d*)((\.(\d{0,2})?)?)$/i) == null) {

            //Commnet and Added By Riddhesh Patil on 11-NOV-2022
            //else if (txtLeaveEntitlement != null && checkSpecialCharacter(txtLeaveEntitlement) == true) {
            //    $('#txtLeaveEntitlement').focus();
            //    validateflagLeaves = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("Please enter only numb ers in the field Leave Entitlement.");
            //    return false;
            //}
            
            else if (checkSpecialCharacter(txtLeaveEntitlement, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Leave Entitlement should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtLeaveEntitlement").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil
            else if ($("#txtBalanceLeaves").val().trim() == undefined || $("#txtBalanceLeaves").val().trim() == "" || $("#txtBalanceLeaves").val().trim() == null) {
                $("#txtBalanceLeaves").focus();
                validateflagLeaves = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Balance Leaves' should not left blank.");
                return false;
            }
            //else if (txtBalanceLeaves != null && txtBalanceLeaves.match(/^(-?\d*)((\.(\d{0,2})?)?)$/i) == null) {

            //Commnet and Added By Riddhesh Patil on 11-NOV-2022

            //else if (txtBalanceLeaves != null && checkSpecialCharacter(txtBalanceLeaves) == true) {
            //    $('#txtBalanceLeaves').focus();
            //    validateflagLeaves = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("Please enter only numbers in the field Balance Leaves.");
            //    return false;
            //}
                //End of Comment By Riddhesh Patil

            //Added By Dipali V On 5TH JAN 2022 For Leave Should not consider 0 Or negative

            else if (checkSpecialCharacter(txtBalanceLeaves, WebConfigSpecialCharacters) == true && txtBalanceLeaves != null ) {
                validateflagLeaves = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Balance Leaves should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtBalanceLeaves").focus();
                return false;
            }
			//End of Added By Riddhesh Patil
            else if ($("#txtBalanceLeaves").val().trim()!= null && $("#txtBalanceLeaves").val().trim() < 0 ) {
                $("#txtBalanceLeaves").focus();
                validateflagLeaves = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Balance Leaves' should be Positve Number");
                return false;
            }
           
           //End of Added By Dipali V On  5TH JAN 2022 For Leave Should not consider 0 Or negative


            else {
                validateflagLeaves = true;
                return true;
            }
        }

        function checkSpecialCharacter(value) {
            var regularExpression = '{}|`~[]<>\!"@#$%^&*()_+-=/';
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


        var validateflagLeaves
        function saveLeaves(isFromSaveAndclick) {
            checkValidationLeaves();
            if (validateflagLeaves == true) {

                var UniqueID = $("#hdnLeaveId").val();
                var EmployeeID = $("#hdnEmp_UniqueID").val();
                //var ProRata = $("#txtLeaveProRata").val().replace(/'/g, "''");
                var LeaveBalance = $("#txtBalanceLeaves").val().replace(/'/g, "''");
                var NoOfLeaves = $("#txtLeaveEntitlement").val().replace(/'/g, "''");
                var LeaveTypeID = $("#txtLeaveTypeID").val();
                // alert("UniqueID " + UniqueID);
                var Details = {
                    UniqueID: UniqueID > 0 ? UniqueID : 0,
                    EmployeeID: EmployeeID,
                    // ProRata: ProRata,
                    LeaveBalance: LeaveBalance,
                    NoOfLeaves: NoOfLeaves,
                    LeaveTypeID: LeaveTypeID,
                    CreatedBy: encodeURI(UserName)

                };
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeLeaves/SaveLeaves',
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
                            else
                            {
                                alertify.set('notifier', 'position', 'top-right');
                                //Added by imran on 29-08-2022 
                                if (data == "Leave Type already exist.") {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(data);
                                }
                                else {
                                    alertify.success(data);
                                }
                                //End of comment by imran on 29-08-2022
                            $('#addDesignationModal').modal('hide');
                            onCloseLeaves();
                            GetEmpLeaves($("#hdnEmp_UniqueID").val());
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
                            $("#txtLeaveTypeID").removeAttr("disabled");
                            onCloseLeaves();
                            GetEmpLeaves($("#hdnEmp_UniqueID").val());
                             }

                        }

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
                            window.location.href = "../../General/default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            //    CurrentTabObject.Leaves = 'false';
                            GetEmpLeaves($("#hdnEmp_UniqueID").val());
                            // CurrentTabObject.Leaves = 'true';
                            //StopAjaxLoader("#bodyGlobal-Resource");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        StopAjaxLoader("#DesgLeaves");
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
        function GetEmpLeaves(employeeID) {
            //  CurrentTabObject.Leaves = 'true';
            // SelectedLeaveID = [];
            var strHTML = "";
            //  StartLoader("#DesgLeaves");
            //  var leaveParams = { EmployeeID: employeeID }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeLeaves/GetEmployeeLeaveTypes',
                type: "POST",
                data: JSON.stringify(employeeID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (employeeID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(employeeID) ? employeeID : JSON.stringify(employeeID)));
                    }
                },
                success: function (data) {
                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            //if (blnEditAccess == "True") {
                            strHTML += '<tr><td class="text-center"><a href="javascript:;" class="Leavesdetalilink" onclick="editLeavesDetails()"</a> <input type="hidden" name="hdn_UniqueID" id="hdn_UniqueID" value= ' + obj.UniqueID + '><input type="hidden" name="hdn_LeaveTypeID" id="hdn_LeaveTypeID" value= ' + obj.LeaveTypeID + '>' + obj.LeaveType + '</td><td class="text-center"> ' + obj.NoOfLeaves + ' </td><td class="text-center"> ' + obj.LeaveBalance + ' </td><td><div class="custom_chckbox"><input id=chl_' + index + ' onclick="checkUncheckLeaves();GetSelectedLeaves(this);" class="chcktbl" type="checkbox"><label for=chl_' + index + '></label></div></td></tr>';
                        });
                    }
                    $('#leaveMastertbl').dataTable().fnDestroy();
                    $("#leaveMastertblMain").html(strHTML);
                    LoadPaginationLeaves(data);
                    // StopAjaxLoader("#DesgLeaves");
                    $(".chckHead1").prop("checked", false);
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#DesgLeaves");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

        }


        var SelectedLeaveID = [];
        function GetSelectedLeaves(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedLeaveID.push(parseInt(row.find('#hdn_UniqueID').val()));
            }
            else {
                if (SelectedLeaveID != 'undefined' && SelectedLeaveID.length > 0) {
                    var removeEmp = row.find('#hdn_UniqueID').val();
                    SelectedLeaveID.remove(parseInt(removeEmp));
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
        function checkUncheckLeaves() {
            //alert(leaveTable.fnGetNodes().length);
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
                    var rows = $("#leaveMastertbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedLeaveID.push(parseInt($(rows[i]).find("#hdn_UniqueID").val()));
                    }

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedLeaveID = [];
                }
            }
        });

        <%-- Added by Chetan M on 9 August 2021 for clear filter  --%>
        $(".mainclearalllink").click(function () {
            $("#txtEMPFilterEmployeeName").val("");
            $("#cboEMPFilterDesignationID").val("0");
            $("#cboEMPFilterLocationID").val("0");
            $("#cboEMPFilterBusinessGroupID").val("0");
            $(".mainclearalllink").addClass("clsShowHide");
            GetEmployees(null);
        });
        <%-- End of Added by Chetan M on 9 August 2021 for clear filter  --%>

        function DeleteLeavesAfterConfirm() {
           
            var strHTML = "";
            var selectedDesignationID = SelectedLeaveID.toString();
            if (selectedDesignationID.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_EmployeeLeaves/DeleteEmployeeLeaves',
                    type: "POST",
                    data: JSON.stringify(selectedDesignationID),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#body-Designation");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedDesignationID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedDesignationID) ? selectedDesignationID : JSON.stringify(selectedDesignationID)));
                        }
                    },
                    success: function (data) {

                        StopAjaxLoader("#body-Designation");
                        GetEmpLeaves($("#hdnEmp_UniqueID").val());
                         //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        //strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                         //End of Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterow').html(strHTML);
                        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
                        $('#DeleteConfirmMModal').modal('show');
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
                            window.location.href = "../../General/default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                            //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                        }
                        else if (xhr.statusText == "OK") {  //200
                            GetEmpLeaves($("#hdnEmp_UniqueID").val());
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
            SelectedLeaveID = [];
            selectedDesignationID = "";
        }
        function openLeavesApprovers() {
            var strHTML = "";
            //  StartLoader("#DesgLeaves");
            //  var leaveParams = { EmployeeID: employeeID }
            $.ajax({
                url: strUrl + '/api/RM_EmployeeLeaves/GetLeaveApprovers',
                type: "POST",
                //data: JSON.stringify(employeeID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                success: function (data) {
                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            //if (blnEditAccess == "True") {
                            strHTML += '<tr class="aprroversnamerow"><td class="text-start graybglight"><strong>' + obj.Approver + '</strong></td><td class="text-start graybglight">&nbsp;</td></tr>';
                            $.each(obj.lstEmployeeName, function (index, objEmp) {
                                //if (blnEditAccess == "True") {
                                strHTML += '<tr class="empname"><td class="text-start">&nbsp;</td> <td class="text-start">' + objEmp.EmployeeName + '</td> </tr>';

                            });
                        });
                    }
                    $('#approverTbl').dataTable().fnDestroy();
                    $("#approverTblMain").html(strHTML);
                    // StopAjaxLoader("#DesgLeaves");
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#DesgLeaves");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })
        }
        //datatable

        ////datatable
        //$('#exluploadTbl').dataTable({
        //    //"ajax": '/api/data',
        //    "scrollY": '160px',
        //    "scrollX": true,
        //    "pageLength": 5,
        //    "lengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "responsive": true,
        //    "bFilter": false,
        //    "ordering": false,

        //});



        //setTimeout(function () {
        //    $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        //}, 0);

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        //function resizeSection() {
        //    var tblheight = $(window).height();
        //    $('#ELMTbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 300, "overflow-y": "auto" });

        //    //var tblheight = $(window).height();
        //    //$('.Resourcedetailpanel').css({ 'height': tblheight - 80 });

        //}
        //$(window).on("load resize scroll", function (e) {
        //    resizeSection(this);
        //    $(".table").resize();

        //});





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

        // Changing state of CheckAll checkbox
        //$(".chcktbl").click(function () {

        //    if ($(".chcktbl").length == $(".chcktbl:checked").length) {
        //        $(".chckHead").prop("checked", true);
        //    } else {
        //        $(".chckHead").removeAttr("checked");
        //    }

        //});

        var $rows = $('#exluploadTbl tr');
        $('#searchpracsetting').keyup(function () {
            var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();

            $rows.show().filter(function () {
                var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                return !~text.indexOf(val);
            }).hide();
        });

        //colappse row
        $(".UpDowncollapseArrow").click(function () {
            $(this).toggleClass("in");
            $(this).closest("tr").toggleClass("activerow");

        });

        //Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, 0), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value=0]").prop('selected', true);
            }
        }
        //End of Added By Chetan M. For Bind Filter Placeholder on 14 July 2021

         function Download_Template() {
            window.open ("../../General/ViewAttachment.aspx?FromWhere=DXU&FileName=EmployeeLeaves.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
        }

    </script>

</body>

</html>
