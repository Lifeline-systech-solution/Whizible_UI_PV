<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_OpportunityRequest.aspx.vb" Inherits="PbNIT.RM_OpportunityRequest" %>

<!DOCTYPE html>
<html> 
      <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head runat="server">
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css"--%>
  <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

    



</head>
  <style type="text/css">
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important
        }

        .issfilter_actiondropdown {
            float: right;
        }

        .btnrow {
            margin-top: 20px;
        }

        .filterpanel .MyFiltersdropdown li span i {
            font-size: 14px;
            cursor: pointer;
            padding: 9px;
        }

        .clsShowHide {
            display: none !important;
        }

        a.clearalllink {
            font-weight: 700;
            display: none;
            margin: 7px 0 0 8px
        }

        .filter.pull-right {
            margin: 2px 0 0 8px
        }

        .filter1.pull-right {
            margin: 2px 0 0 8px
        }

        table tr th {
            vertical-align: middle !important
        }

            table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
                margin-right: 0
            }

        .notebox {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px
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
            width: 0
        }

        .dropdown-submenu > .dropdown-submenu:hover a:after {
            border-color: transparent transparent transparent #464a4c
        }

        /*Detailpanel*/
        .Resourcedetailpanel {
            margin: 40px 15px 20px;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .pgdetailinner {
            padding: 10px;
        }

        .Resourcedetailpanel .tab-pane {
            padding: 20px 0;
            min-height: 90vh;
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

        /*Opportunity request*/
        .toggleswitch button:focus, .toggleswitch button.active {
            border: 1px solid #ddd;
            outline: none !important;
            background: #1359ac !important;
            color:#fff
        }

        .toggleswitch button {
            background: #fff;
            color:#444
        }

        .custmodal .custom_chckbox label:before {
            border-color: #464a4c
        }

        .btn-toggle.toggleswitch .btn {
            border: 1px solid #ddd
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px
        }

        .custmodal .modal-content .modal-body {
            padding: 30px
        }

        /*#ResrsShowApprovalModal .dataTables_scrollHeadInner, #ResrsShowApprovalModal .dataTables_scrollHeadInner table {
            width: 100% !important
        }*/

        .modal .filterpanel {
            border: 1px solid #ddd;
            border-radius: 4px;
            margin: 0 0 15px;
            background: #fafafa
        }

        div#softbookingTbl_wrapper .dataTables_scroll {
            margin: 0 0 10px
        }

        div#softbookingTbl_wrapper {
            margin: 0 0 60px
        }

        table.table td .add {
            display: none
        }

        table.table td .cancelrowvalue {
            display: none
        }

        .newaddedrow select, .newaddedrow input, .newaddedrow textarea {
            padding: 4px 2px
        }

        .input-sm button {
            height: 30px !important;
            line-height: 30px
        }

        .ORdetails .control-label {
            padding-top: 0;
            margin-bottom: 0;
            line-height: 16px;
            padding-right: 0;
        }

        .ORdetails {
            margin-top: 20px
        }

        #ResrsDistributionFreqModal th {
            min-width: 80px;
        }

        .OrDisrtibutionTxt {
            width: 70px !important;
        }

        .editFilter {
            color: #1359a6;
            border: 1px;
            border-style: dotted;
            background: aliceblue;
        }

        .clsFilterHighlight {
            background: #1359a6 !important;
            color: #ffffff !important;
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

        .filter button[aria-expanded="true"] {
            background: NONE;
            color: #4263c1;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }

        .filter1 button[aria-expanded="true"] {
            background: NONE;
            color: #4263c1;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }

        .cltblORSoftBooking {
            height: 70% !important;
        }

        .clsAsterLink {
            width: 96%;
            display: inline-block;
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

        .pgdetailinner .form-group{display:flex}

        #ORListTbl_wrapper .dataTables_scrollHead,#RDAEmployeeTbl_wrapper .dataTables_scrollHeadInner, #RDAEmployeeTbl_wrapper table, #ORListTbl_wrapper .dataTables_scrollHeadInner, #ORListTbl_wrapper table{width:100%!important}
        body#bodyOpportunityResource-group {
    height: 100vh;
    /* display: flex; */
    background: #fff;
}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="">
      <%--  /*Added & Commented By Madhuri.K On 21-Aug-2024 For Loader Issues*/--%>
     <div class=""  id="bodyOpportunityResource-group"></div>
    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-0 text-right graybg">
            <div class="row">
                <div class="col-sm-6">
                    <h5 class="pgtitle pull-left">Opportunity Request</h5>
                </div>

                <div class="col-sm-6">

                    <div class="filter inline pull-right">
                        <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-placement="bottom" title="" id="AdvanceFilterIcon" data-bs-original-title="Filter" autocomplete="off" class="collapsed" aria-expanded="false"><i class="fas fa-filter"></i></button>

                    </div>
                    <%-- <a href="javascript:;" class="clearalllink pull-right" style="" onclick="clearAll" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-placement="bottom" title=""><strong>Clear All</strong></a>--%>
                    <a href="javascript:;" class="mainclearalllink" onclick="closeFilterPanel()" style="" data-bs-toggle="tooltip" data-placement="bottom" title=""><strong>Clear All</strong></a>
                    <%-- <div class="dropdown filedownload pull-right"> --commented for 26275 issue for OPR
                        <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" style="margin-top: 4px;"><i data-bs-toggle="tooltip" data-placement="bottom" data-title="Click here to download" class="fas fa-download"></i></button>
                        <ul class="dropdown-menu">
                            <li><a href="#">
                                <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                            <li><a href="#">
                                <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                            <li><a href="#">
                                <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                            <li><a href="#">
                                <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Doc</a></li>
                        </ul>

                    </div>--%>
                </div>
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
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="checkFiltervalidationForOPR();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="applyOPRFilter();">Apply</button>
                                </div>
                                <br />

                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Business Group</label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboOPRFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-control"" onChange=""FillFilterOUForFilter(this.value)""",,,, ,)%>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Organization Unit</label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboOPRFilterLocationID", "Select '' ",,, "class='form-control'",,, ) %>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Approval Status</label>
                                        <select id="cboOPRFilterApprovedStatus" class="form-control">
                                            <option value="">Select Approval Status</option>
                                            <option value="S">Sent For Approval</option>
                                            <option value="D">Pending Approval</option>
                                            <option value="A">Approved</option>
                                            <option value="R">Rejected</option>
                                        </select>
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboOPRFilterStatusID", "usp_Whizible2_sel_tbl_CNF_OpportunityStatus",,, "class='form-control'", True,,) %>--%>
                                    </div>

                                </div>

                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>

        <%-- filter model for save--%>
        <div class="modal custmodal SklSavefilter_filter fade" id="SklSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modalsmall ui-draggable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="SklSavefilterfilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-right required">Filter Name :</label>
                                            <span class="col-md-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtOPRFilterName", "txtOPRFilterName", "form-control",, maxLength:=100, ToBeInserted:="onkeypress='return AvoidSpace(this)'") %>
                                                <div class="btnrow">
                                                    <button class="btn btnyellow pull-left savefilter" id="btnSaveFilter" onclick="SaveOPRFilterDetails()">Save</button>
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
        <!--end save filter-->
        <!--end filter panel-->



        <div class="container-fluid pt-1 pb-1 mb-0 text-right">

            <div class="row">
                <div class="col-sm-3">
                    <div class="input-group srchrequest">
                        <input id="srchORlist" type="text" class="search-query form-control input-sm" placeholder="Search" onkeyup="mysearchFunction()">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" style="height: 30px;">
                                <span class=" glyphicon glyphicon-search"></span>
                            </button>
                        </span>
                    </div>
                </div>
                <div class="col-sm-9 text-right">
                    <a href="javascript:;" onclick="addORlist(0)" class="btn borderbtn mr-5 addlistbtn" id="btnAddORlist" data-bs-toggle="tooltip" data-placement="bottom" title="Add Request"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
                </div>

            </div>
        </div>



        <div class="content pt-0">
            <div class="OPRtblouter">
                <table id="ORListTbl" class="table table-bordered ORListTbl" style="width: 100%;">
                    <thead>
                        <tr>
                            <th width="150">Prospect Customer</th>
                            <th>Title</th>
                            <th width="130">Valid Till</th>
                            <th width="150">Resource <span>Demand Status</span></th>
                            <th width="130">Approval Status</th>
                            <th>Project Name</th>
                            <th>Customer Name</th>
                            <th width="60">&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody id="tblOpportunityRequests">
                    </tbody>
                </table>
            </div>
        </div>


        <div class="Resourcedetailpanel">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li><a href="#RORdetails" class="active" data-bs-toggle="tab" id="tabRORdetails">Details</a><div></div>
                    </li>
                    <li class=""><a href="#RORresrsPlan" data-bs-toggle="tab" id="tabResourcePlan">Resource Plan</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">

                    <div id="RORdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <input type="hidden" id="hdnOproppId" name="hdnOproppId">

                            <button class="btn btnyellow mr-5" onclick="saveOpportunityRequest(0)" id="btnSaveOPR">Save</button>
                            <button class="btn btnyellow mr-5" onclick="saveOpportunityRequest(1)" id="btnSaveAddOPR">Save And Add</button>
                            <a href="#" data-bs-toggle="modal" data-bs-target="#ResrsShowApprovalModal" class="btn borderbtn mr-5" id="btnShowApprovers" onclick="GetApproversList()">Show Approvers</a>
                            <a href="#" data-bs-toggle="modal" class="btn borderbtn mr-5" id="btnSendForApproval" onclick="CheckApproverComment();">Send For Approval</a>
                            <a href="#" data-bs-toggle="modal" data-bs-target="#ResrsApproveModal" class="btn borderbtn mr-5 clsShowHide" id="btnApprove" onclick="CheckSenderComment(0);">Approve</a>
                            <a href="#" data-bs-toggle="modal" data-bs-target="#ResrsApproveModal" class="btn borderbtn mr-5 clsShowHide" id="btnReject" onclick="CheckSenderComment(1);">Reject</a>
                            <a href="#" data-bs-toggle="modal" data-bs-target="#ResrsRevisionModal" class="btn borderbtn mr-5" id="btnRevision" onclick="SendForRevision();">Revision</a>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancleOpportunityRequest()">Cancel</button>
                            <div class="dropdown filedownload pull-right ml-1">
                                <%--Commented and added By RehanC for Tooltip Issue on 24rd Mar 2023--%>
<%--                                <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" style="margin-top: 4px;"><i data-bs-toggle="tooltip" data-placement="bottom" data-title="Demand Information" class="fas fa-download"id="download"></i></button>--%>
                                <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" style="margin-top: 4px;"><i data-bs-toggle="tooltip" data-placement="bottom" title="Demand Information" class="fas fa-download"id="download"></i></button>
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
                        </div>
                        <p class="text-right" style="margin-right: 6px;">
                            <strong>Approval Status :</strong>
                            <label id="ApprovalStatus"></label>
                            <!--<span style="margin-left:40px;">(<font color="red">*</font> Mandatory)</span>-->
                        </p>
                        <input type="hidden" id="HdnCboBGValue" />
                        <div class="ORdetails">
                            <div class="form-group">
                                <div class="col-sm-6 row">
                                    <label for="" class="col-sm-3 control-label required">Prospect/<a href="#" data-bs-toggle="modal" data-bs-target="#ResrsSelectCustomerModal" onclick="GetCustomersList()">Select Customer</a></label>
                                    <div class="col-sm-9">
                                        <%CommonFunctions.HTMLControls.DrawTextBox("prospectCustomer", "txtProspectCustomer", cssClass:="form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:=" placeholder='Enter Prospect/Customer' title='' onkeypress='disabledProject()'")%>
                                    </div>
                                </div>
                                <div class="col-sm-6 row">
                                    <label for="" class="col-sm-3 control-label">&nbsp;</label>
                                    <div class="col-sm-9">
                                        <div class="btn-group btn-toggle toggleswitch">
                                            <button class="btn btn-xs active btn-primary" id="btnProduct" onclick="showHideProductProject('Product')">Product</button>
                                            <button class="btn btn-xs btn-default" id="btnProject" onclick="showHideProductProject('Project')">Project</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6 row">
                                    <label for="" class="col-sm-3 control-label required">Title</label>
                                    <div class="col-sm-9">
                                        <%CommonFunctions.HTMLControls.DrawTextBox("title", "txtTitle", "form-control", widthInPixel:=0, maxLength:=50)%>
                                    </div>
                                </div>
                                <div class="col-sm-6 row">
                                    <label for="" class="col-sm-3 control-label required">Project Name/ Product</label>
                                    <div class="col-sm-9" id="cboSelectProject">
                                        <%--Commented And Added By Reshma Chavan on 7th Dec 2021 To Remove blanck space in dropdown--%>
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboProject", "Select 0,'' ",,, "class='form-control'", True,,) %>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboProject", "Select 0,'' ",,, "class='form-control'",,,) %>
                                    </div>
                                    <div class="col-sm-9" id="cboSelectProduct">
                                        <%--Commented And Added By Reshma Chavan on 7th Dec 2021 To Remove blanck space in dropdown--%>
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_Whizible2_sel_tbl_PRD_Product",,, "class='form-control'", True,,) %>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_Whizible2_sel_tbl_PRD_Product",,, "class='form-control'",,,) %>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6 row">
                                    <label for="" class="col-sm-3 control-label">Description</label>
                                    <div class="col-sm-9">
                                        <% CommonFunctions.HTMLControls.DrawTextArea("description", "txtDescription", "Enter Description (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Description (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                                    </div>
                                </div>
                                <%--   <div class="col-sm-6 row">
                                    <label for="" class="col-sm-3 control-label">Customer Name</label>
                                    <div class="col-sm-9">
                                        <%CommonFunctions.HTMLControls.DrawTextBox("customerName", "txtCustomerName", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                    </div>
                                </div>--%>
                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6 row">
                                    <label for="" class="col-sm-3 control-label">Address</label>
                                    <div class="col-sm-9">
                                        <% CommonFunctions.HTMLControls.DrawTextArea("address", "txtAddress", "Enter Address (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Address (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                                    </div>
                                </div>
                                <div class="col-sm-6 row">
                                    <label for="" class="col-sm-3 control-label">Region</label>
                                    <div class="col-sm-9">
                                        <%--Commented And Added By Reshma Chavan on 7th Dec 2021 To Remove blanck space in dropdown--%>
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboRegion", "usp_Whizible2_sel_tbl_CNF_RegionMaster",,, "class='form-control'", True,,) %>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboRegion", "usp_Whizible2_sel_tbl_CNF_RegionMaster",,, "class='form-control'",,,) %>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6 row">
                                    <label for="" class="col-sm-3 control-label">Country</label>
                                    <div class="col-sm-9">
                                        <%--Commented And Added By Reshma Chavan on 7th Dec 2021 To Remove blanck space in dropdown--%>
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboCountry", "usp_Whizible2_sel_tbl_PM_CountryMaster",,, "class='form-control'", True,,) %>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboCountry", "usp_Whizible2_sel_tbl_PM_CountryMaster",,, "class='form-control'",,,) %>
                                    </div>
                                </div>
                                <div class="col-sm-6 row">
                                    <label for="" class="col-sm-3 control-label">Pin Code</label>
                                    <div class="col-sm-9">
                                        <%CommonFunctions.HTMLControls.DrawTextBox("pinCode", "txtPinCode", cssClass:="form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)'")%>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6 row">
                                    <label for="" class="col-sm-3 control-label">Currency</label>
                                    <div class="col-sm-9">
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboCurrency", "usp_Whizible2_sel_tbl_PM_CurrencyMaster",,, "class='form-control'", True,,) %>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboCurrency", "usp_Whizible2_sel_tbl_PM_CurrencyMaster",,, "class='form-control'",,,) %>
                                    </div>
                                </div>
                                <div class="col-sm-6 row">
                                    <label for="" class="col-sm-3 control-label required">Resource Demand Value</label>
                                    <div class="col-sm-9">
                                        <%CommonFunctions.HTMLControls.DrawTextBox("resourceDemand", "txtResourceDemand", cssClass:="form-control", widthInPixel:=0, maxLength:=12, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event,txtResourceDemand)'")%>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="row">

                                <hr />
                                <div class="form-group">
                                    <div class="col-sm-6 row">
                                        <label for="" class="col-sm-3 control-label required">Approx. Start Date</label>
                                        <div class="col-sm-9">
                                            <div class="input-group datefielddiv">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("startApproxDate", "txtStartApproxDate", cssClass:="form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:="onchange='getValidDate()'")%>

                                                <span class="input-group-btn">
                                                    <button style="pointer-events: none;" class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 row">
                                        <label for="" class="col-sm-3 control-label required">Approx. Duration<small> (In Days)</small></label>
                                        <div class="col-sm-9">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("approxDuration", "txtApproxDuration", cssClass:="form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onblur='getValidDate()', onkeypress='return Field_OnKeyPress(event,txtApproxDuration)'")%>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>


                                <div class="form-group">
                                    <div class="col-sm-6 row">
                                        <label for="" class="col-sm-3 control-label required">Identified By</label>
                                        <div class="col-sm-9">
                                            <%--Commented And Added By Reshma Chavan on 7th Dec 2021 To Remove blanck space in dropdown--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboIdentifiedBy", "usp_Whizible2_sel_tbl_PM_Resource_Selection",,, "class='form-control'", True,,) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboIdentifiedBy", "usp_Whizible2_sel_tbl_PM_Resource_Selection",,, "class='form-control'",,,) %>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 row">
                                        <label for="" class="col-sm-3 control-label required">Identified Date</label>
                                        <div class="col-sm-9">
                                            <div class="input-group datefielddiv">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("identifiedDate", "txtIdentifiedDate", cssClass:="form-control")%>
                                                <span class="input-group-btn">
                                                    <button style="pointer-events: none;" class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>


                                <div class="form-group">
                                    <div class="col-sm-6 row">
                                        <label for="" class="col-sm-3 control-label required">Business Group</label>
                                        <div class="col-sm-9">
                                            <%-- <% CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_Whizible2_sel_BusinessGroupsLocation",,, "class=""form-control"" onChange=""FillOU(this.value)""", True,,, ,)%>--%>
                                            <%--Commented And Added By Reshma Chavan on 7th Dec 2021 To Remove blanck space in dropdown--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboBG", "Select 0,''",,, "class=""form-control"" onChange=""FillOU(this.value,undefined,2)""", True,,, ,)%>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboBG", "Select 0,''",,, "class=""form-control"" onChange=""FillOU(this.value,undefined,2)""",,,, ,)%>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 row">
                                        <label for="" class="col-sm-3 control-label required">Organization Unit</label>
                                        <div class="col-sm-9">

                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboOU", "Select 0,'' ",,, "class=""form-control"" onChange=""FillDU(this.value,undefined,2)""",,,, , ) %>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-6 row">
                                        <label for="" class="col-sm-3 control-label required">Delivery Unit</label>
                                        <div class="col-sm-9">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboDU", "Select 0,'' ",,, "class=""form-control"" onChange=""FillDT(this.value,undefined,2)""",,,, ,)%>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 row">
                                        <label for="" class="col-sm-3 control-label required">Delivery Team</label>
                                        <div class="col-sm-9">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboDT", "Select 0,'' ",,, "class=""form-control""",,,, ,)%>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-6 row">
                                        <label for="" class="col-sm-3 control-label required">Valid Till Date</label>
                                        <div class="col-sm-9">
                                            <div class="input-group datefielddiv">
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtValidTillDate", "txtValidTillDate", cssClass:="form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onChange='GetDays()'")%>
                                                <%--  <% CommonFunctions.HTMLControls.DrawTextBox("txtValidTillDate", "txtValidTillDate", "form-control clsDateColor",,,,,, False, False,, False, "autocomplete = 'off'",,, ,,,,) %>--%>
                                                <span class="input-group-btn">
                                                    <button style="pointer-events: none;" class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 row">
                                        <label for="" class="col-sm-3 control-label required">Status</label>
                                        <div class="col-sm-9" id="statusOpen">
                                            <%--Commented And Added By Reshma Chavan on 6th Dec 2021 To Remove blanck space in dropdown--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Whizible2_sel_tbl_CNF_OpportunityStatus_Initiated",,, "class='form-control'", True,,) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Whizible2_sel_tbl_CNF_OpportunityStatus_Initiated",,, "class='form-control'",,,) %>
                                        </div>
                                        <div class="col-sm-9" id="statusAll">
                                            <%--Commented And Added By Reshma Chavan on 6th Dec 2021 To Remove blanck space in dropdown--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboStatusEdit", "usp_Whizible2_sel_tbl_CNF_OpportunityStatus",,, "class='form-control'", True,,) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboStatusEdit", "usp_Whizible2_sel_tbl_CNF_OpportunityStatus",,, "class='form-control'",,,) %>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>


                                <hr />
                                <div class="form-group" style="display:contents">
                                    <p class="col-sm-12"><strong>Engagement Probability</strong></p>
                                    <div class="col-sm-6 row">
                                        <label for="" class="col-sm-3 control-label required">Engagement Probability</label>
                                        <div class="col-sm-9">

                                            <%CommonFunctions.HTMLControls.DrawTextBox("probabilityCurrent", "txtProbabilityCurrent", cssClass:="form-control", widthInPixel:=0, maxLength:=0, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)'")%>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 row">
                                        <label for="" class="col-sm-3 control-label">Comment</label>
                                        <div class="col-sm-9">
                                            <%--<% CommonFunctions.HTMLControls.DrawTextArea("probabilityComment", "txtProbabilityComment", "", "form-control", ,,,, , , ,,,,,,,,,, False,,,,,,,,) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawTextArea("probabilityComment", "txtProbabilityComment", "Enter Comment (Maxlength 1000 Chars)", "form-control", ,,,, , , 1000,,,,,,,, "Placeholder='Enter Comment (Maxlength 1000 Char)' autocomplete='Off' maxlength='1000'",, False,,,,,,,,) %>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>

                        </div>

                    </div>

                    <div id="RORresrsPlan" class="tab-pane fade">
                        <input type="hidden" id="hdnOROpportunityId" name="hdnOROpportunityId" class="clhdnOROpportunityId" value="" />
                        <input type="hidden" id="hdnORPipelineIDToDelete" name="hdnORPipelineIDToDelete" class="clhdnORPipelineIDToDelete" value="" />
                        <input type="hidden" id="hdnORPipelineIDSoftbooking" name="hdnORPipelineIDSoftbooking" class="clhhdnORPipelineIDSoftbooking" value="0" />
                        <input type="hidden" id="hdnORFTESoftbooking" name="hdnORFTESoftbooking" class="clhdnORFTESoftbooking" value="0" />
                        <div class="detailsubtabsbtn pb-1 text-right">

                            <button class="btn borderbtn canceldetailpanel mr-5" id="btnCancelInResourcePlan" onclick="cancledetailpanel()">Cancel</button>
                            <div class="dropdown filedownload pull-right ml-1">
                                <%--Commented and Added by RehanC for Tooltip Issue on 24th Mar 2023--%>
                                <%--<button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" style="margin-top: 4px;"><i data-bs-toggle="tooltip" data-placement="bottom" data-title="Demand Information" class="fas fa-download"></i></button>--%>
                                    <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" style="margin-top: 4px;"><i data-bs-toggle="tooltip" data-placement="bottom" title="Demand Information" class="fas fa-download"></i></button>

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
                        </div>

                        <div id="tblRORplan" class="table-responsive">
                            <table class="table table-bordered rsrsplantbl">
                                <thead>
                                    <tr>
                                        <th style="width: 150px;">Role</th>
                                        <th style="width: 175px !important">Primary Skill</th>
                                        <th style="width: 100px !important">Total FTE</th>
                                        <th style="width: 150px !important;">Resource In date</th>
                                        <th style="width: 150px !important;">Resource Out Date</th>
                                        <th style="width: 120px !important;">Special Request</th>
                                        <th style="width: 90px !important">Distribution</th>
                                        <th style="width: 92px !important">Soft Booking</th>
                                        <th style="width: 80px !important">&nbsp;</th>

                                    </tr>
                                </thead>
                                <tbody id="tblORResourcePlans">
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td>
                                            <button href="#" class="btn borderbtn mr-5 add-new" id="btnAddResourcePlan" data-bs-toggle="tooltip" data-placement="bottom" data-container="body" data-title="Add Resource Plan"><i class="fa fa-plus" aria-hidden="true"></i>Add Plan</button></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>

                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>


                </div>
            </div>
        </div>


        <div class="clearfix"></div>
    </div>

    <!--Show Apprvals modal start here-->
    <div class="modal custmodal fade" id="ResrsSelectCustomerModal" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Select Customer</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="table-responsive" style="max-height: 265px;">
                        <b>Note</b>:If login is not created for customer select option will be disable.
                        <table id="selectcustomertbl" class="table table-bordered" style="width: 100%!important;">
                            <thead>
                                <tr>
                                    <th class="text-left">Customer Name</th>
                                    <th colspan="4" class="text-left">Email ID</th>
                                    <th class="text-left">Select</th>
                                </tr>
                            </thead>
                            <tbody id="tblOPCustomers">
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix"></div>
                    <div class="text-center" style="margin-top: 15px;">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Cancel</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Show Apprvals modal end here-->
    <!--Demand Info modal start here-->
    <div class="modal custmodal fade" id="ResrsDemandinfoModal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Demand Information</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Cancel</button>
                        <button class="btn btnyellow" data-bs-dismiss="modal">Save</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Demand Info modal end here-->
    <!--Show Apprvals modal start here-->
    <div class="modal custmodal fade" id="ResrsShowApprovalModal" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Resource Demand Approvers</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <table id="RDAEmployeeTbl" class="table table-bordered" style="width: 100%!important;">
                        <thead>
                            <tr>
                                <th class="text-left col-sm-12">Employee Name</th>
                            </tr>
                        </thead>
                        <tbody id="tblOPApprovers">
                        </tbody>
                    </table>
                    <div class="clearfix"></div>
                    <div class="text-center" style="margin-top: 15px;">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Cancel</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Show Apprvals modal end here-->
    <div class="modal custmodal fade" id="ResrsSendApprovalModal" aria-hidden="true"  data-backdrop="static">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Send For Approval</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h5 style="margin: 0 0 10px; color: #4263c1;"><strong>Sender Comments</strong></h5>
                    <div class="form-group">
                        <label class="required">Comment</label>
                        <% CommonFunctions.HTMLControls.DrawTextArea("comment", "txtComment", "Enter Summary (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Comment (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                        <div class="clearfix"></div>
                    </div>
                    <div class="form-group">
                        <label id="lblapproverComments">Approver Comments</label>
                        <% CommonFunctions.HTMLControls.DrawTextArea("approverComments", "txtapproverComments", "Enter Summary (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Approver Comments (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                        <div class="clearfix"></div>
                    </div>


                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Cancel</button>
                        <button class="btn btnyellow" onclick="SendForApproval();">Save</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Send Approval modal end here-->


    <!--Approve modal start here-->
    <div class="modal custmodal fade" id="ResrsApproveModal" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Approver Comments</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h5 style="margin: 0 0 10px; color: #4263c1;"><strong>Approver Comments</strong></h5>
                    <div class="form-group">
                        <label class="required">Comment</label>
                        <% CommonFunctions.HTMLControls.DrawTextArea("comment", "txtapproverejectComment", "Enter Summary (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Comment (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                        <div class="clearfix"></div>
                    </div>
                    <div class="form-group">
                        <label id="lblsenderComments">Sender Comments</label>
                        <% CommonFunctions.HTMLControls.DrawTextArea("senderComments", "txtSenderComments", "Enter Summary (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Approver Comments (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                        <div class="clearfix"></div>
                    </div>


                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Cancel</button>
                        <button class="btn btnyellow" onclick="ApproveOrReject();">Save</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Approve modal end here-->
    <!--FTE Distribution modal start here-->
    <div class="modal custmodal fade" id="ORDistributionFreqModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <%--  usp_Whizible2_Sel_v_tbl_RM_Pipeline_Distribution--%>
                    <h5 class="modal-title" id="">Distribution Frequency</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <strong>Current Total FTE: </strong>
                    <label id="lblDistributionFTE"></label>
                    <%--  <input type="number" onchange="SetFTEDecimal" min="0" max="10" step="0.25" value="0.00" />--%>
                    <!--<div class=" pb-1">
                        <div class="pull-left"><label>Resource In Date :</label> 01 Aug 2019</div>
                        <div class="pull-right"><label>Resource Out Date :</label> 31 Oct 2019</div>
                        <div class="clearfix"></div>
                    </div>-->
                    <div class="table-responsive">
                        <table class="table table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Year</th>
                                    <th>Jan</th>
                                    <th>Feb</th>
                                    <th>Mar</th>
                                    <th>Apr</th>
                                    <th>May</th>
                                    <th>Jun</th>
                                    <th>July</th>
                                    <th>Aug</th>
                                    <th>Sep</th>
                                    <th>Oct</th>
                                    <th>Nov</th>
                                    <th>Dec</th>
                                </tr>
                            </thead>
                            <tbody id="tblORDistributionFrequency">
                            </tbody>
                        </table>
                    </div>
                    <br />
                    <div class="text-center">
                        <button class="btn btnyellow" id="btnORDistributionSave" onclick="UpdateORResourcPlanDist()">Save</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal">Cancel</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--FTE Distribution end here-->
    <!--Soft Booking modal start here-->
    <div class="modal custmodal fade" id="ResrsSoftBookingModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Soft Booking</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row pb-1">
                        <div class="col-sm-4">
                            <div class="input-group srchrequest">
                                <input id="txtORSoftbookingSearch" type="text" class="search-query1 form-control input-sm" placeholder="Search" onkeyup="mysearchOfSoftbooking()">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" style="height: 30px;">
                                        <span class=" glyphicon glyphicon-search" onclick="mysearchOfSoftbooking()"></span>
                                    </button>
                                </span>
                            </div>
                        </div>
                        <div class="col-sm-8">

                            <div class="filter1 modalfilter inline pull-right">
                                <a href="javascript:;" class="mainclearalllinkSB" style="" data-bs-toggle="tooltip" data-placement="bottom" title=""><strong>Clear All</strong></a>
                                <button data-bs-toggle="collapse" data-bs-target="#modalFltrPanel" data-placement="bottom" title="" id="AdvanceFilterIconSB" data-bs-original-title="Filter" autocomplete="off" class="collapsed" aria-expanded="false"><i class="fas fa-filter"></i></button>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <div id="modalFltrPanel" class="filterpanel collapse" aria-expanded="false" style="">

                        <div class="Fwrapper">

                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" onclick="ApplySofbookingFilter()">Apply</button>
                                </div>
                                <br>

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <label>Role</label>
                                            <%--Commented And Added By Reshma Chavan on 7th Dec 2021 To Remove blanck space in dropdown--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboORSBFilterRoleId", "usp_Whizible2_sel_tbl_PM_Role_Roles",,, "class=""form-control clsPlanWidth clcboResourceSoftBookRole"" ,""", True,,, ,)%>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboORSBFilterRoleId", "usp_Whizible2_sel_tbl_PM_Role_Roles",,, "class=""form-control clsPlanWidth clcboResourceSoftBookRole"" ,""",,,, ,)%>
                                        </div>
                                        <div class="col-sm-4">
                                            <label>Business Group</label>
                                            <%-- cboBGFilterBusinessGroupCode--%>
                                            <%--Commented And Added By Reshma Chavan on 7th Dec 2021 To Remove blanck space in dropdown--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboORSBFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-control"" onChange=""FillSoftBookingDU(this.value)""", True,,, ,)%>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboORSBFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-control"" onChange=""FillSoftBookingDU(this.value)""",,,, ,)%>
                                        </div>
                                        <div class="col-sm-4">
                                            <label>Organization Unit</label>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboORSBFilterLocationID", "Select 0,'' ",,, "class='form-control'",,, ) %>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <label>Facility</label>
                                            <%--Commented And Added By Reshma Chavan on 7th Dec 2021 To Remove blanck space in dropdown--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboORSBFilterFacilityID", "usp_Whizible2_Sel_tbl_PM_Facility",,, "class=""form-control clsPlanWidth clcboResourceSoftBookRole"" ,""", True,,, ,)%>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboORSBFilterFacilityID", "usp_Whizible2_Sel_tbl_PM_Facility",,, "class=""form-control clsPlanWidth clcboResourceSoftBookRole"" ,""",,,, ,)%>
                                        </div>
                                        <div class="col-sm-4">
                                            <label>Primary Skills</label>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtORSBFilterPrimaryskills", "txtORSBFilterPrimaryskills", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %>
                                        </div>
                                        <div class="col-sm-4">
                                            <label>Resource Name</label>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtORSBFilterUserName", "txtORSBFilterUserName", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="clearfix"></div>
                            </div>

                        </div>

                    </div>

                    <table id="softbookingTbl" class="table table-bordered" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>Resource Name</th>
                                <th>Business Group</th>
                                <th>Organization Unit</th>
                                <th>Role</th>
                                <th>Primary Skills</th>
                                <th>Total Experience(Yrs)</th>
                                <th>
                                    <div class="custom_chckbox" style="margin-right: 5px;">
                                        <input id="addSelectionCheck" class="chckHeadForSoftBooking" type="checkbox">
                                        <label for="addSelectionCheck"></label>

                                    </div>

                                </th>
                            </tr>
                        </thead>
                        <tbody class="cltblORSoftBooking" id="tblORSoftBooking" style="width: 100%;">
                        </tbody>
                    </table>

                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Cancel</button>
                        <button class="btn btnyellow" id="btnORShowselectedResource" onclick="ShowSelectedSoftBookingResource()">Show Selected Resource</button>
                        <button class="btn btnyellow" onclick="SaveORResourcePlanSoftbooking(0)">Save</button>
                        <%-- Commented and added by Chetan M on 15 July 2021 for restrict Popup closing  --%>
                        <%--<button class="btn btnyellow" data-bs-dismiss="modal" onclick="SaveORResourcePlanSoftbooking(1)">Save And Close</button>--%>
                        <button class="btn btnyellow" onclick="SaveORResourcePlanSoftbooking(1)">Save And Close</button>
                        <%-- End of Commented and added by Chetan M on 15 July 2021 for restrict Popup closing  --%>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <%-- Start delete resource plan model --%>
    <div class="modal custmodal fade" id="DeleteOrResourcePlanMModal" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%--<div class="form-group row">
                        <%--<strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <div class="form-group row">
                        Are you sure, you want to delete the selected record?
                    </div>

                    <div class="text-right">
                        <button class="btn btnyellow" onclick=" DeleteOrResourcePaln(1)">Yes</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal">No</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <%-- End delete resource plan model --%>
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
                                    <button class="btn borderbtn pull-left uncheckbtn" data-bs-dismiss="modal">No</button>
                                    <button class="btn btnyellow" data-bs-toggle="modal" data-bs-original-title="" data-bs-dismiss="modal" title="" onclick="confirmDelete()">Yes</button>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
    
   <%--End of Added by Rutuja D on 6th July 2021--%>
    <!--Soft Booking end here-->
    <!-- REQUIRED JS SCRIPTS -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
 <%--   <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/dist/js/moment.min.js"></script>
     <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script type="text/javascript">
        //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var strUrl = '';
        var NoDataFound = "No data found.";
        var DeleteRecord = "Please select at least one record to delete.";
        var DeleteConfirm = "Are you sure, you want to delete the selected records?";
        strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';



        var blnEditAccess = '<%= m_blnEditAccess%>';
        //  var blnEditAccess ='True';
        //  var blnDeleteAccess='False';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
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
        var UserRoleLevel = '<%= m_RoleLevel%>';
        var TagID = '<%= m_TagId%>';

        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';
        var IsRevision = false;
        var IsSendForApproval = false;
        var OprStatus = "";
        var ApproverList = [];
        var ResoucePlanList = [];
        var softBookingSelectionTable;
        var noOfRowsPerPage = 10;
        $(document).ready(function () {

            BindPlaceholder("cboOPRFilterBusinessGroupID", "Business Group");          
            FillBG(0);
            //Added By Reshma Chavan on 7th Dec 2021 Bind Placeholder for Soft Booking Filter                        
            BindAllPlaceHolderfun();
            //End of Added By Reshma Chavan on 7th Dec 2021 Bind Placeholder for Soft Booking Filter
            var myDate = new Date(new Date().getTime() + (24 * 60 * 60 * 1000));
            $('#txtStartApproxDate').datepicker('setDate', myDate);
            $('#txtIdentifiedDate').datepicker('setDate', new Date());
            FillFilterOUForFilter(0);
            var OrFIlterSoftbookingList = [];
            // $('#softbookingTbl').DataTable();
            var CboBGValue = '';
            var CboOUValue = '';
            var CboDUValue = '';
            var selectProductFlag;
            var selectProjectFlag = '';
            showHideProductProject('Product');
            GetMaximumItemsToShowInList();
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (blnAddAccess == "False") {
                $("#btnAddORlist").addClass("clsShowHide");
                $('#btnSaveAddOPR').attr("disabled", true);
                $("#btnAddResourcePlan").addClass("clsShowHide");
            }
            else {
                $("#btnAddORlist").removeClass("clsShowHide");
                $('#btnSaveAddOPR').attr("disabled", false);
                $("#btnAddResourcePlan").removeClass("clsShowHide");
            }

            if (blnViewAccess == "True") {
                GetMyFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);

                } else {
                    GetSklDetails(null);
                    FilterNotApplied();
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
        });

        //Added By Reshma Chavan on 7th Dec 2021 For Binding Placeholder
        function BindAllPlaceHolderfun() {
            BindPlaceholder("cboProduct", "Project Name/Product"); 
            BindPlaceholder("cboProject", "Project Name/Product"); 
            BindPlaceholder("cboRegion", "Region"); 
            BindPlaceholder("cboCountry", "Country"); 
            BindPlaceholder("cboIdentifiedBy", "Identified By"); 
            BindPlaceholder("cboStatus", "Status"); 
            BindPlaceholder("cboStatusEdit", "Status"); 

            //For Soft Booking Filter
            BindPlaceholder("cboORSBFilterBusinessGroupID", "Business Group"); 
            BindPlaceholder("cboORSBFilterFacilityID", "Facility"); 
            FillSoftBookingDU();
        }
        //End of Added By Reshma Chavan on 7th Dec 2021 For Binding Placeholder

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
                        // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.error(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(thrownError);
                    }
                }
            })

        }

        var opportunityRequest = {
            OpportunityID: "", Prospect: "", Title: "", Description: "", Size: "",
            Address: "", PinCode: "", CountryID: "", CurrencyID: "", RegionID: "", RaisedDate: "",
            BusinessGroupID: "", LocationID: "", ResourcePoolID: "", GroupID: "", StatusID: "", IsApprovedOnce: "",
            CreatedBy: "", ModifiedBy: "", CustomerID: "", ApproxStartDate: "", ApproxDuration: "", ApproxEndDate: "", CoolingOf: "",
            ProductId: "", ProjectId: "", intUserId: "", probabilityCurrent: "", probabilityComment: "", RaisedBy: "", ApprovedStatus: ""
        };

        function selectCustomer(clickValue) {
            opportunityRequest.CustomerID = clickValue;
            var customerName = document.getElementById(clickValue).innerText;
            $("#btnProject").removeAttr('disabled');
            FillProject(opportunityRequest.CustomerID);
            document.getElementById('txtProspectCustomer').value = customerName;
            $('#ResrsSelectCustomerModal').modal('hide');
        }

        function disabledProject() {
            opportunityRequest.CustomerID = "";
            if (opportunityRequest.CustomerID == "") {
                $("#btnProject").attr('disabled', 'disabled');
                showHideProductProject('Product');
                $("#btnProject").removeClass('active btn-primary');
                $("#btnProject").addClass('btn-default');
                $("#btnProduct").addClass('active btn-primary');
                $("#btnProduct").removeClass('btn-default');
            }
            else {
                $("#btnProject").removeAttr('disabled', 'disabled');
            }
        }
        function FillProject(CustomerID, param) {
            var customerID = { CustomerID: parseInt(CustomerID)}
            var strHTML = "";
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/FillProjectByCustomerID',
                type: "POST",
                data: JSON.stringify(customerID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (customerID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(customerID) ? customerID : JSON.stringify(customerID)));
                    }
                },
                success: function (data) {
                    $("#cboProject").empty();
                    // $("#cboOU")[0].selectedIndex = -1;
                    //var s = ('<option value=0></option>');
                    //$("#cboOU").append(s);
                    strHTML += "<option value='0'></option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.ProjectID + ' >' + listComponent.ProjectName + '</option>');
                        $("#cboProject").html(strHTML);
                    }
                    if (param != null && param > 0 && param != undefined) {
                        //  alert("editparam");
                        $("#cboProject").val(param);
                    }


                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

        }
        function getValidDate() {

            var appDuration;
            if ($("#txtStartApproxDate").val() != null && $("#txtStartApproxDate").val() != undefined && $("#txtApproxDuration").val() != null && $("#txtApproxDuration").val() != undefined) {
                var M = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                var tt = document.getElementById('txtStartApproxDate').value;
                if ($("#txtApproxDuration").val().trim().match(/[.]/)) {
                    $("#txtApproxDuration").focus();
                    validateflag = false;
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("'Approx.duration (Days)' can not contain decimal value.");
                    return false;
                }
                if ($("#txtApproxDuration").val() == "") {
                    appDuration = 0;
                }
                else {
                    appDuration = $("#txtApproxDuration").val();
                }
                var date = new Date(tt);
                var dd1 = date.getDate() - 1;    //Changes for 313 opr
                var mm1 = date.getMonth() + 1;
                var y1 = date.getFullYear();
                var someFormattedDate1 = mm1 + '/' + dd1 + '/' + y1;
                var newdate = new Date(someFormattedDate1);
                newdate.setDate(newdate.getDate() + parseInt(appDuration));

                if (newdate != "Invalid Date") {
                    var dd = newdate.getDate();
                    var mm = M[newdate.getMonth()];
                    var y = newdate.getFullYear();

                    var someFormattedDate = dd + " " + mm + " " + y;
                    $("#txtValidTillDate").val(someFormattedDate);
                }
            }
        }
        function GetDays() {
           // debugger;
            var firstDate = new Date($("#txtStartApproxDate").val());
            var secondDate = new Date($("#txtValidTillDate").val());
            var oneDay = 24 * 60 * 60 * 1000; // hours*minutes*seconds*milliseconds
            var diffDays = Math.round(Math.abs((firstDate - secondDate) / oneDay));
          
            diffDays = diffDays + 1;
            // alert(diffDays);
                  $("#txtApproxDuration").val(diffDays);
        }
        function showHideProductProject(selectItem) {
            if (selectItem == 'Project') {
                selectProjectFlag = true;
                selectProductFlag = false;
                document.getElementById('cboSelectProduct').style.display = "none";
                document.getElementById('cboSelectProject').style.display = "block";


            }
            if (selectItem == 'Product') {
                selectProductFlag = true;
                selectProjectFlag = false;
                document.getElementById('cboSelectProject').style.display = "none";
                document.getElementById('cboSelectProduct').style.display = "block";
            }

        }

        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
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
        function FillBG(value, param) {
            var strHTML = "";
            FillOU(0);
            FillDU(0);
            FillDT(0);
            //if (value > 0) {
            //Added by imran on 23-08-2022
            if ($("#hdnOproppId").val() == "") {
                var objOU = { BusinessGroupID: value, OprID: 0 }
            }
            else {
                var objOU = { BusinessGroupID: value, OprID: $("#hdnOproppId").val() }
            }
            //End of comment by imran on 23-08-2022
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/GetBusinessGroups',
                // url: strUrl + '/api/RM_OpportunityRequest/GetOU',                
                type: "POST",
                data: JSON.stringify(objOU),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objOU) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objOU) ? objOU : JSON.stringify(objOU)));
                    }
                },
                success: function (data) {
                    //Commented And Added By Reshma chavan on 7th Dec 2021 For Binding Placeholder
                    //strHTML += "<option value='0'></option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.BusinessGroupID + ' >' + listComponent.BusinessGroup + '</option>');
                    }
                    $("#cboBG").html(strHTML);
                    //Added By Reshma chavan on 7th Dec 2021 For Binding Placeholder
                    BindPlaceholder("cboBG", "Business Group");
                    //End of Added By Reshma chavan on 7th Dec 2021 For Binding Placeholder
                    if (param != null && param > 0 && param != undefined) {
                        $("#cboBG").val(param);
                    }


                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })
            //}
            //else {
            //    $("#cboBG").html(strHTML);
            //}


        }
        function FillOU(value, param, isChange) {
            var strHTML = "";
            FillDU(0);
            FillDT(0);
            if (value > 0) {
                if (isChange == 2) {
                    var objOU = { BusinessGroupID: value }
                }
                else {
                    var objOU = { BusinessGroupID: value, OprID: $("#hdnOproppId").val() }
                }

                $.ajax({
                    url: strUrl + '/api/RM_OpportunityRequest/GetBusinessGroupsLocation',
                    // url: strUrl + '/api/RM_OpportunityRequest/GetOU',                
                    type: "POST",
                    data: JSON.stringify(objOU),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (objOU) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objOU) ? objOU : JSON.stringify(objOU)));
                        }
                    },
                    success: function (data) {
                        //Commented And Added By Reshma chavan on 7th Dec 2021 For Binding Placeholder
                        //strHTML += "<option value='0'></option>";
                        $("#cboOU").html("");
                        //Commented And Added By Reshma chavan on 7th Dec 2021 For Binding Placeholder
                        for (var i = 0; i < data.length; i++) {
                            var listComponent = data[i];
                            strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');
                        }
                        $("#cboOU").html(strHTML);
                        
                        if (param != null && param > 0 && param != undefined) {
                            $("#cboOU").val(param);
                        }


                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    //alertify.notify(err);
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
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                })
            }
            else {
                $("#cboOU").html(strHTML);
                //Added By Reshma chavan on 7th Dec 2021 For Binding Placeholder
                BindPlaceholder("cboOU", "Organization Unit"); 
                //End of Added By Reshma chavan on 7th Dec 2021 For Binding Placeholder
            }


        }

        function FillDU(value, param, isChange) {
            FillDT(0);
            // alert($("#hdnOproppId").val());
            var strHTML = "";
            if (value > 0) {
                if (isChange == 2) {
                    var objDU = { LocationID: value }
                }
                else {
                    var objDU = { LocationID: value, OprID: $("#hdnOproppId").val() }
                }
                $.ajax({
                    url: strUrl + '/api/RM_OpportunityRequest/GetResourcePoolForLocation',
                    type: "POST",
                    data: JSON.stringify(objDU),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (objDU) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objDU) ? objDU : JSON.stringify(objDU)));
                        }
                    },
                    success: function (data) {
                        //Commented By Reshma chavan on 7th Dec 2021 For Placeholder 
                        //strHTML += "<option value='0'></option>";
                        for (var i = 0; i < data.length; i++) {
                            var listComponent = data[i];

                            strHTML += ('<option value=' + listComponent.ResourcePoolID + ' >' + listComponent.ResourcePoolName + '</option>');
                        }
                        $("#cboDU").html(strHTML);
                        //Added By Reshma chavan on 7th Dec 2021 For Placeholder 
                        BindPlaceholder("cboDU", "Delivery Unit");
                        if (param != null && param > 0 && param != undefined) {
                            $("#cboDU").val(param);
                        }

                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    //alertify.notify(err);
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
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                })
            }
            else {
                $("#cboDU").html(strHTML);
                //Added By Reshma chavan on 7th Dec 2021 For Placeholder 
                 BindPlaceholder("cboDU", "Delivery Unit");
            }

        }

        function FillDT(value, param, isChange) {
            var strHTML = "";
            if (value > 0) {
                if (isChange == 2) {
                    var objDT = { LocationID: value }
                }
                else {
                    var objDT = { LocationID: value, OprID: $("#hdnOproppId").val() }
                }

                $.ajax({
                    url: strUrl + '/api/RM_OpportunityRequest/GetDeliveryTeam',
                    type: "POST",
                    data: JSON.stringify(objDT),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (objDT) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objDT) ? objDT : JSON.stringify(objDT)));
                        }
                    },
                    success: function (data) {
                        // $("#cboDT").empty();
                        //strHTML += "<option value='0'></option>";
                        for (var i = 0; i < data.length; i++) {
                            var listComponent = data[i];

                            strHTML += ('<option value=' + listComponent.GroupID + ' >' + listComponent.GroupName + '</option>');

                            //  $("#cboSubType").css({ "class": "form-control selectpicker" });
                        }
                        $("#cboDT").html(strHTML);
                        //Added By Reshma chavan on 7th Dec 2021 For Placeholder 
                        BindPlaceholder("cboDT", "Delivery Team");
                        if (param != null && param > 0 && param != undefined) {
                            $("#cboDT").val(param);
                        }

                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    //alertify.notify(err);
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
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                })
            }
            else {
                $("#cboDT").html(strHTML);
                //Added By Reshma chavan on 7th Dec 2021 For Placeholder
                BindPlaceholder("cboDT", "Delivery Team");
            }


        }

        var validateflag
        function saveOpportunityRequest(isFromSaveClick) {
            checkValidation();
            var opportunityId = $("#hdnOproppId").val();
            if (validateflag == true) {
                opportunityRequest.Prospect = $("#txtProspectCustomer").val().replace(/'/g, "''");
                opportunityRequest.Title = $("#txtTitle").val().replace(/'/g, "''");;
                opportunityRequest.Description = $("#txtDescription").val().replace(/'/g, "''");
                opportunityRequest.CountryID = $("#cboCountry").val();
                opportunityRequest.Address = $("#txtAddress").val().replace(/'/g, "''");
                opportunityRequest.CurrencyID = $("#cboCurrency").val();
                opportunityRequest.RaisedBy = $("#cboIdentifiedBy").val();
                opportunityRequest.BusinessGroupID = $("#cboBG").val();
                if ($("#cboRegion").val() == null || $("#cboRegion").val() == "") {
                    opportunityRequest.RegionID = 0;
                }
                else {
                    opportunityRequest.RegionID = $("#cboRegion").val();
                }
                
                opportunityRequest.PinCode = $("#txtPinCode").val();
                opportunityRequest.Size = $("#txtResourceDemand").val();
                opportunityRequest.ApproxStartDate = $("#txtStartApproxDate").val();
                opportunityRequest.ApproxDuration = $("#txtApproxDuration").val();
                opportunityRequest.CoolingOf = $("#txtValidTillDate").val();
                opportunityRequest.RaisedDate = $("#txtIdentifiedDate").val();
                opportunityRequest.LocationID = $("#cboOU").val();
                opportunityRequest.ResourcePoolID = $("#cboDU").val();
                opportunityRequest.GroupID = $("#cboDT").val();
                opportunityRequest.StatusID = $("#cboStatus").val();
                opportunityRequest.ProbabilityCurrent = $("#txtProbabilityCurrent").val();
                opportunityRequest.ProbabilityComment = $("#txtProbabilityComment").val().replace(/'/g, "''");
                opportunityRequest.IntUserId = SessionEmployeeId;
                opportunityRequest.CreatedBy = UserName;
                opportunityRequest.ModifiedBy = UserName;
                if (selectProjectFlag == true && selectProductFlag == false) {
                    opportunityRequest.ProjectId = $("#cboProject").val();
                }
                if (selectProductFlag == true && selectProjectFlag == false) {
                    opportunityRequest.ProductId = $("#cboProduct").val();
                }
                //EDIT OPR
                if (opportunityId > 0 && opportunityId != undefined) {
                    opportunityRequest.OpportunityID = opportunityId;
                    opportunityRequest.StatusID = $("#cboStatusEdit").val();

                    $.ajax({
                        url: strUrl + '/api/RM_OpportunityRequest/UpdateOpportunityRequest',
                        type: "POST",
                        data: JSON.stringify(opportunityRequest),
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                            if (opportunityRequest) {
                                xhr.setRequestHeader("Params", encryptString(isJson(opportunityRequest) ? opportunityRequest : JSON.stringify(opportunityRequest)));
                            }
                        },
                        success: function (data) {
                            //   console.log("statusch");
                            //  console.log(data);
                            if (data.Status == "Active") {
                                if (isFromSaveClick == 0) {
                                    GetOpportunityRequests();
                                    showHideSave();
                                    $('#tabResourcePlan').removeClass("DisableContent");
                                    $("#cboIdentifiedBy").attr("disabled", false);
                                    //cancleOpportunityRequest();
                                    document.getElementById('statusAll').style.display = "block";
                                    document.getElementById('statusOpen').style.display = "none";
                                    $("#cboStatusEdit").val(opportunityRequest.StatusID);
                                    GetOpportunityRequest(opportunityRequest.OpportunityID);
                                    $("#ORListTbl_wrapper .dataTables_scrollBody,.OPRtblouter,.backbtn, .paginate_button, .deletebtn, .filter,.addlistbtn,.search-query, .graybg .filter, .graybg .filedownload").addClass("DisableContent").parent().css("cursor", "no-drop");

                                }
                                if (isFromSaveClick == 1) {
                                    cancleOpportunityRequest();
                                    $("#hdnOproppId").val(0);
                                    $('#tabResourcePlan').addClass("DisableContent");
                                    $("#cboIdentifiedBy").attr("disabled", false);  //FOR IDENTIFIEDBY

                                    //disabled for Revision satsu after save click
                                    $("#txtProspectCustomer").attr("disabled", false);
                                    $("#cboProduct").attr("disabled", false);
                                    $("#cboProject").attr("disabled", false);
                                    $("#txtTitle").attr("disabled", false);
                                    $("#txtDescription").attr("disabled", false);
                                    $('#cboCurrency').attr("disabled", false);
                                    $("#txtValidTillDate").attr("disabled", false);
                                    $("#txtStartApproxDate").attr("disabled", false);
                                    // $("#cboBG").attr("disabled", true);
                                    $("#txtApproxDuration").attr("disabled", false);
                                    $("#txtIdentifiedDate").attr("disabled", false);
                                    $("#txtProbabilityComment").attr("disabled", false);
                                    $('#btnProduct').attr("disabled", false);
                                    $('#btnProject').attr("disabled", false);
                                    $('#btnProduct').attr("disabled", false);

                                    document.getElementById("ApprovalStatus").innerHTML = "";
                                    GetOpportunityRequests();
                                    $("#btnSendForApproval").addClass("clsShowHide");
                                    document.getElementById('statusAll').style.display = "none";
                                    document.getElementById('statusOpen').style.display = "block";
                                    $("#ORListTbl_wrapper .dataTables_scrollBody,.OPRtblouter,.backbtn, .paginate_button, .deletebtn, .filter,.addlistbtn,.search-query, .graybg .filter, .graybg .filedownload").addClass("DisableContent").parent().css("cursor", "no-drop");
                        
                                }
                            }
                            else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data.Status);
                            }

                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            if (ajaxOptions == "error") {
                                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                                //console.log(thrownError);
                                //alertify.set('notifier', 'position', 'top-right');
                                //alertify.notify(xhr.responseJSON.Message);
                                if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                    window.open("../../../Default.aspx", "_top");
                                } else {
                                    window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                }
                                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                            }
                        }
                    })
                    //Commented and Added By RehanC for Missing Filter Pop-Up ALert on 6th April 2023
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Opportunity Updated saved successfully.");
                    //End of Comment By RehanC on 6th April 2023
                }
                else {
                    // alert("save");
                    var currentDate = new Date();
                    var approxStartDate = new Date($("#txtStartApproxDate").val());
                    if (approxStartDate < currentDate) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Approx. Start date must be greater than current date");
                        return false;
                    } else {
                        $.ajax({
                            url: strUrl + '/api/RM_OpportunityRequest/SaveOpportunityRequest',
                            type: "POST",
                            data: JSON.stringify(opportunityRequest),
                            dataType: "json",
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                                if (opportunityRequest) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(opportunityRequest) ? opportunityRequest : JSON.stringify(opportunityRequest)));
                                }
                            },
                            success: function (data) {
                                if (data.Status == "Active") {
                                    if (isFromSaveClick == 0) {
                                        var hdnID = data.OprID;
                                        $("#hdnOproppId").val(data.OprID);
                                        $("#hdnOROpportunityId").val(data.OprID);
                                        GetOpportunityRequests();
                                        showHideSave();
                                        document.getElementById("ApprovalStatus").innerHTML = "Pending Approval";
                                        $('#tabResourcePlan').removeClass("DisableContent");
                                        //opportunityRequest.StatusID = $("#cboStatusEdit").val();
                                        document.getElementById('statusAll').style.display = "block";
                                        document.getElementById('statusOpen').style.display = "none";
                                        $("#cboStatusEdit").val(opportunityRequest.StatusID);
                                        //GetOpportunityRequest($("#hdnOproppId").val(data.OprID));
                                        GetOpportunityRequest(hdnID);
                                        $("#ORListTbl_wrapper .dataTables_scrollBody,.OPRtblouter,.backbtn, .paginate_button, .deletebtn, .filter,.addlistbtn,.search-query, .graybg .filter, .graybg .filedownload").addClass("DisableContent").parent().css("cursor", "no-drop");

                                    }
                                    if (isFromSaveClick == 1) {
                                        cancleOpportunityRequest();
                                        $("#hdnOproppId").val(0);
                                        $('#tabResourcePlan').addClass("DisableContent");
                                        GetOpportunityRequests();
                                        $("#btnSendForApproval").addClass("clsShowHide"); //SEND FOR APPROVAL 
                                        document.getElementById('statusAll').style.display = "none";
                                        document.getElementById('statusOpen').style.display = "block";
                                        $("#ORListTbl_wrapper .dataTables_scrollBody,.OPRtblouter,.backbtn, .paginate_button, .deletebtn, .filter,.addlistbtn,.search-query, .graybg .filter, .graybg .filedownload").addClass("DisableContent").parent().css("cursor", "no-drop");
                                        
                                    }
                                }

                                else {
                                    //alert(data.Status);
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(data.Status);
                                }
                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                if (ajaxOptions == "error") {
                                    //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                                    //console.log(thrownError);
                                    //alertify.set('notifier', 'position', 'top-right');
                                    //alertify.notify(xhr.responseJSON.Message);
                                    if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                        window.open("../../../Default.aspx", "_top");
                                    } else {
                                        window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                    }
                                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                                }
                            }
                        })
                        //Commented and Added By RehanC for Missing Filter Pop-Up ALert on 6th April 2023
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("Opportunity Request saved successfully.");
                        //End of Comment By RehanC on 6th April 2023
                    }
                }
            } else {
                return false;
            }
        }

        function showHideSave() {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").show();
            $("#ORListTbl_wrapper .dataTables_scrollBody,.OPRtblouter, .backbtn, .paginate_button, .addlistbtn,.search-query, .graybg .filter, .filedownload").removeClass("DisableContent").parent().css("cursor", "auto");

            $('#ORListTbl').DataTable().columns.adjust().draw();
            //cancleOpportunityRequest();
        }
        //disabled copy and paste
        $('#txtProbabilityCurrent').bind('copy paste', function (e) {
            e.preventDefault();
        });
        $('#txtResourceDemand').bind('copy paste', function (e) {
            e.preventDefault();
        });
        $('#txtPinCode').bind('copy paste', function (e) {
            e.preventDefault();
        });
        $('#txtApproxDuration').bind('copy paste', function (e) {
            e.preventDefault();
        });
        //for filter criteria

        function checkValidation() {
            // alert($("#cboProject").val());
            // alert($("#cboProduct").val());
            var currentDate = new Date();
            var ProspectCustomer = $("#txtProspectCustomer").val();
            var Title = $("#txtTitle").val();
            var Description = $("#txtDescription").val();
            var Address = $("#txtAddress").val();
            var Comment = $("#txtProbabilityComment").val();
            var approxStartDate = new Date($("#txtStartApproxDate").val());
            var approxValidTillDate = new Date($("#txtValidTillDate").val());
            var IdentifiedDate = new Date($("#txtIdentifiedDate").val());
            if (selectProjectFlag == true && selectProductFlag == false) {
                // opportunityRequest.ProjectId = $("#cboProject").val();
                $("#cboProduct").val("");
            }
            if (selectProductFlag == true && selectProjectFlag == false) {
                //opportunityRequest.ProductId = $("#cboProduct").val();
                $("#cboProject").val("");
            }
            if ($("#txtProspectCustomer").val() == undefined || $("#txtProspectCustomer").val() == "") {
                $("#txtProspectCustomer").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Customer/Prospect' should not left blank.");
                return false;
            }
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
            if (checkSpecialCharacter(ProspectCustomer, WebConfigSpecialCharacters) == true) {
                checkval = 1;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Customer/Prospect Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                //$(ControlValidationFieldID[i]).focus()
                $("#txtProspectCustomer").focus();
                return false;
            }
            else if ($("#txtTitle").val() == undefined || $("#txtTitle").val() == "") {
                $("#txtTitle").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Title' should not left blank.");
                return false;
            }
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
            if (checkSpecialCharacter(Title, WebConfigSpecialCharacters) == true) {
                checkval = 1;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Title Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                //$(ControlValidationFieldID[i]).focus()
                $("#txtTitle").focus();
                return false;
            }
            else if (($("#cboProject").val() == undefined || $("#cboProject").val() == "" || $("#cboProject").val() == 0) && ($("#cboProduct").val() == undefined || $("#cboProduct").val() == "" || $("#cboProduct").val() == 0)) {
                $("#cboProject").focus();
                $("#cboProduct").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Project/Product' should not left blank.");
                return false;
            }
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
            if (checkSpecialCharacter(Description, WebConfigSpecialCharacters) == true) {
                checkval = 1;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                //$(ControlValidationFieldID[i]).focus()
                $("#txtDescription").focus();
                return false;
            }
           ///Added By Rehan C To add Validator for Special characters on 09th Nov 2022
            if (checkSpecialCharacter(Address, WebConfigSpecialCharacters) == true) {
                checkval = 1;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Address Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                //$(ControlValidationFieldID[i]).focus()
                $("#txtAddress").focus();
                return false;
            }

            else if ($("#txtResourceDemand").val() == undefined || $("#txtResourceDemand").val() == "") {
                $("#txtResourceDemand").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Resource demand' should not left blank.");
                return false;
            }
            else if ($("#txtStartApproxDate").val() == undefined || $("#txtStartApproxDate").val() == "") {
                $("#txtStartApproxDate").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Approx. Start Date' should not left blank.");
                return false;
            }
            else if ($("#cboIdentifiedBy").val() == undefined || $("#cboIdentifiedBy").val() == "") {
                $("#cboIdentifiedBy").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Identified By' should not left blank.");
                return false;
            }
            else if ($("#txtApproxDuration").val() == undefined || $("#txtApproxDuration").val() == "") {
                $("#txtApproxDuration").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Approx Duration (Days)' should not left blank.");
                return false;
            }

            else if ($("#txtIdentifiedDate").val() == undefined || $("#txtIdentifiedDate").val() == "") {
                $("#txtIdentifiedDate").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Identified date' should not left blank.");
                return false;
            }
            else if ($("#txtValidTillDate").val() == undefined || $("#txtValidTillDate").val() == "") {
                $("#txtValidTillDate").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Valid Till Date' should not left blank.");
                return false;
            }
            else if (IdentifiedDate > currentDate) {
                $("#txtIdentifiedDate").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Identified Date should not be future date.");
                return false;
            }
            else if (approxValidTillDate < approxStartDate) {
                //alert("valapp");
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Valid till date must be greater than Approx. start date");
                return false;
            }

            else if ($("#cboBG").val() == undefined || $("#cboBG").val() == "" || $("#cboBG").val() == 0) {
                $("#cboBG").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Business Group' should not left blank.");
                return false;
            }

            else if ($("#cboOU").val() == undefined || $("#cboOU").val() == "" || $("#cboOU").val() == 0) {
                $("#cboOU").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Organization Unit' should not left blank.");
                return false;
            }
            else if ($("#cboDU").val() == undefined || $("#cboDU").val() == "" || $("#cboDU").val() == 0) {
                $("#cboDU").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Delivery Unit' should not left blank.");
                return false;
            }
            else if ($("#cboDT").val() == undefined || $("#cboDT").val() == "" || $("#cboDT").val() == 0) {
                $("#cboDT").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Delivery Team' should not left blank. ");
                return false;
            }


            else if ($("#txtProbabilityCurrent").val() == undefined || $("#txtProbabilityCurrent").val() == "") {
                $("#txtProbabilityCurrent").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Engagement  Probability' should not left blank. ");
                return false;
            }
            else if ($("#txtProbabilityCurrent").val() < 0 || $("#txtProbabilityCurrent").val() > 100) {
                $("#txtProbabilityCurrent").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter values between 0 to 100 for Engagement Probabilty Current field");
                return false;
            }
            else if (($("#cboStatus").val() == undefined || $("#cboStatus").val() == "") && ($("#cboStatusEdit").val() == undefined || $("#cboStatusEdit").val() == "")) {
                $("#cboStatus").focus();
                $("#cboStatusEdit").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Status' should not left blank. ");
                return false;
            }
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
            if (checkSpecialCharacter(Comment, WebConfigSpecialCharacters) == true) {
                checkval = 1;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Comment Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                //$(ControlValidationFieldID[i]).focus()
                $("#txtProbabilityComment").focus();
                return false;
            }
            else {
                validateflag = true;
                return true;
            }
        }
        function cancleOpportunityRequest() {
            opportunityRequest = {};
            $("#hdnOROpportunityId").val(0);
            $("#hdnOproppId").val(0)
            document.getElementById('txtProspectCustomer').value = "";
            document.getElementById('txtTitle').value = "";
            document.getElementById('txtDescription').value = "";
            $("#cboCountry").val("");
            document.getElementById('txtAddress').value = "";
            $("#cboCurrency").val("");
            // $("#cboProject").val("");
            $("#cboProject").empty();
            $("#cboProduct").val("");
            document.getElementById('txtStartApproxDate').value = "";
            $("#cboIdentifiedBy").val("");
            $("#cboBG").val("");
            document.getElementById('txtValidTillDate').value = "";
            $("#cboRegion").val("");
            document.getElementById('txtPinCode').value = "";
            document.getElementById('txtResourceDemand').value = "";
            document.getElementById('txtApproxDuration').value = "";
            document.getElementById('txtIdentifiedDate').value = "";
            document.getElementById('txtProbabilityCurrent').value = "";
            document.getElementById('txtProbabilityComment').value = "";

            $("#cboBG").val("");
            $("#cboDU").val("");
            $("#cboDT").val("");
            $("#cboStatus").val("");
            $("#cboStatusEdit").val("");
            document.getElementById('txtIdentifiedDate').value = "";
            var myDate1 = new Date(new Date().getTime() + (24 * 60 * 60 * 1000));
            $('#txtStartApproxDate').datepicker().datepicker('setDate', myDate1);
            $('#txtIdentifiedDate').datepicker().datepicker('setDate', new Date());
            FillBG(0);
            FillOU(0);
            FillDU(0);
            FillDT(0);
            // GetOpportunityRequests();
            // $("#btnProject").removeAttr('disabled', 'disabled');
        }

        ///ADHIT
        var OpportunityRequests;
        function GetOpportunityRequests(whereCaluse) {
            var OP_Parameter = { WhereClause: whereCaluse, IntUserID: SessionEmployeeId };
            var strHTML = "";
            StartLoader("#bodyOpportunityResource-group");
            $.ajax({

                url: strUrl + '/api/RM_OpportunityRequest/GetOpportunityRequestData',
                type: "POST",
                data: JSON.stringify(OP_Parameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (OP_Parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OP_Parameter) ? OP_Parameter : JSON.stringify(OP_Parameter)));
                    }
                },
                success: function (data) {

                    OpportunityRequests = data;
                    $.each(OpportunityRequests, function (index, obj) {
                        if (blnEditAccess == "True" && blnDeleteAccess == "True") {
                            if (obj.ApprovedStatusFilter == "Pending Approval") {
                                // strHTML += '<tr><td><input type="hidden" name="hdnOPR_IsDemandApprover" id="hdnOPR_IsDemandApprover" value= ' + obj.IsDemandApprover + '>' + obj.Prospect + ' </td><td>' + obj.Title + ' </td><td>' + obj.CoolingOf + '</td><td>' + obj.OpportunityStatus + '</td><td>' + obj.ApprovedStatusFilter + '</td><td>' + obj.ProjectName + '</td><td>' + obj.CustomerName + '</td><td class="actioncolumn"><a class="nostylebtn editOpprtunityReq edit" href="javascript:;" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-bs-original-title="Edit" onclick="editOpprtunityReq(' + obj.OpportunityID + ',' + obj.IntUserId + ',' + 0 +')"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px"></a><a onclick="DeleteOpportunityRequest(' + obj.OpportunityID + ')" class="nostylebtn delete"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-bs-original-title="Delete"></i></a></td></tr>';
                                strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'><a class='nostylebtn editOpprtunityReq edit' href='#' data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Edit' onclick=\"(editOpprtunityReq('" + obj.OpportunityID + "','" + obj.IntUserId + "','" + 0 + "','" + obj.ApprovedStatusFilter + "'))\"><i class='fas fa-pencil-alt' style='font-size:16px;color: #464a4c'></i></a><a  onclick='DeleteOpportunityRequest(" + obj.OpportunityID + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Delete'></i></a></td></tr>";
                            }
                            else {
                                strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'><a class='nostylebtn editOpprtunityReq edit' href='#' data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Edit' onclick=\"(editOpprtunityReq('" + obj.OpportunityID + "','" + obj.IntUserId + "','" + 0 + "','" + obj.ApprovedStatusFilter + "'))\"><i class='fas fa-pencil-alt' style='font-size:16px;color: #464a4c'></i></a><a style='pointer-events: none;color: #d4cccc;' onclick='DeleteOpportunityRequest(" + obj.OpportunityID + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Delete'></i></a></td></tr>";
                            }
                        }
                        else if (blnEditAccess == "True" && blnDeleteAccess == "False") {
                            strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'><a class='nostylebtn editOpprtunityReq edit' href='javascript:;'  data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Edit' onclick=\"(editOpprtunityReq('" + obj.OpportunityID + "','" + obj.IntUserId + "','" + 0 + "','" + obj.ApprovedStatusFilter + "'))\"><i class='fas fa-pencil-alt' style='font-size:16px;color: #464a4c'></i></a></td></tr>";
                        }
                        else if (blnEditAccess == "False" && blnDeleteAccess == "True") {
                            if (obj.ApprovedStatusFilter == "Pending Approval") {
                                strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'><a onclick='DeleteOpportunityRequest(" + obj.OpportunityID + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Delete'></i></a></td></tr>";
                            }
                            else {
                                strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'><a style='pointer-events: none;color: #d4cccc;' onclick='DeleteOpportunityRequest(" + obj.OpportunityID + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Delete'></i></a></td></tr>";
                            }
                        }
                        else if (blnEditAccess == "False" && blnDeleteAccess == "False") {
                            strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'></td></tr>";

                        }
                        else {
                            strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'><a style='pointer-events: none;color: #d4cccc;' onclick='DeleteOpportunityRequest(" + obj.OpportunityID + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Delete'></i></a></td></tr>";
                        }

                    });
                    $('#ORListTbl').dataTable().fnDestroy();
                    $("#tblOpportunityRequests").html(strHTML);
                    LoadPagination('#ORListTbl', data);
                    StopAjaxLoader("#bodyOpportunityResource-group");
                    //loadDataTable();

                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
            })

        }

        function DeleteOpportunityRequest(OP_Parameter) {

            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/DeleteOpportunityRequest',
                type: "POST",
                data: JSON.stringify(OP_Parameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    // StartLoader("#bodyBusiness-group");
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (OP_Parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OP_Parameter) ? OP_Parameter : JSON.stringify(OP_Parameter)));
                    }
                },
                success: function (data) {
                    if (data != "") {
                        if (data.includes("deleted successfully")) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                        }

                        // alert(data);
                    }
                    GetOpportunityRequests();
                    //StopAjaxLoader("#bodyBusiness-group");
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.error(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    }
                    else if (xhr.statusText == "OK") {  //200
                        //CurrentTabObject.Manager = 'false';

                    }
                }
            })
        }

        function GetCustomersList() {
            var strHTML = "";
            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/GetOPCustomers',
                type: "POST",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                success: function (data) {
                    var Customers = data;
                    $.each(Customers, function (index, obj) {

                        //strHTML += '<tr><td class="text-left"><a href="javascript:;"  onclick="selectCustomer(' + obj.Customer + ')" id=' + obj.Customer + '>' + obj.CustomerName + '</a></td><td class="text-left">' + obj.EmailID + '</td></tr>';
                        strHTML += '<tr><td class="text-left"><span id=' + obj.Customer + '>' + obj.CustomerName + '</span></td><td class="text-left" colspan="4">' + obj.EmailID + '</td>';
                        if (obj.IsActiveLogin) {
                            strHTML += '<td><button onclick="selectCustomer(' + obj.Customer + ')" style="padding-left:5px;" class="btn btnyellow mr-5">Select</button></td></tr>';
                        }
                        else {

                            strHTML += '<td><button disabled=disabled style="padding-left:5px;" class="btn btnyellow mr-5">Select</button></td></tr>';
                        }

                    });
                    //  $('#BGtblmain#BGtblmain').dataTable().fnDestroy();
                    $("#tblOPCustomers").html(strHTML);
                    //LoadPagination('#BGtblmain', data);
                    // StopAjaxLoader("#bodyBusiness-group");
                    ///loadDataTable();

                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
            })

        }

        function GetApproversList() {
            var OpportunityID = $('#hdnOROpportunityId').val();;
            var strHTML = "";
            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/GetOpportunityRequestApprovers',
                type: "POST",
                data: JSON.stringify(OpportunityID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (OpportunityID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OpportunityID) ? OpportunityID : JSON.stringify(OpportunityID)));
                    }
                },
                success: function (data) {

                    var Customers = data;
                    if (Customers.length > 0) {
                        $.each(Customers, function (index, obj) {

                            strHTML += '<tr><td class="text-left">' + obj.EmployeeName + '</td></tr>';

                        });
                        $('#RDAEmployeeTbl').dataTable().fnDestroy();
                        $("#tblOPApprovers").html(strHTML);
                        LoadPagination('#RDAEmployeeTbl', data);
                    }
                    else {
                        strHTML += '<tr><td class="text-center">' + "No Demand Approver set" + ' </td></tr>';
                        $('#RDAEmployeeTbl').dataTable().fnDestroy();
                        $("#tblOPApprovers").html(strHTML);
                    }

                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

        }
        //disabled copy and paste
        $('#txtResourceDemand').bind('copy paste', function (e) {
            e.preventDefault();
        });
        //var statusForSent;

        function GetOPRById(OpportunityID, CretedBy, IsDemandApprover) {
            opportunityRequest = {};
            $('#tblRORplan').removeClass("DisableContent");
            //StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/GetOpportunityRequestById',
                type: "POST",
                data: JSON.stringify(OpportunityID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (OpportunityID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OpportunityID) ? OpportunityID : JSON.stringify(OpportunityID)));
                    }
                },
                success: function (data) {
                    var oprData = data;
                    document.getElementById("ApprovalStatus").innerHTML = oprData.ApprovedStatusFilter;
                    // statusForSent = oprData.ApprovedStatus.trim();
                    if (oprData.ApprovedStatusFilter == "Sent for Approval" || oprData.ApprovedStatusFilter == "Approved") {

                        if (IsDemandApprover == "1") {
                            $('#tabResourcePlan').removeClass("DisableContent");
                            $('#tblRORplan').removeClass("DisableContent");
                        }
                        else {

                            $('#tblRORplan').addClass("DisableContent");
                        }

                        $('#btnSaveOPR').addClass("clsShowHide");
                        $('#btnSaveAddOPR').addClass("clsShowHide");
                    }
                    else {
                        $('#tabResourcePlan').removeClass("DisableContent");
                        $('#btnSaveOPR').removeClass("clsShowHide");
                        $('#btnSaveAddOPR').removeClass("clsShowHide");
                    }
                    if (oprData.ApprovedStatusFilter == "Approved") {
                        $('#tabResourcePlan').addClass("DisableContent");
                        $('#cboCurrency').attr("disabled", true);
                        $("#txtValidTillDate").attr("disabled", true);
                        $("#txtStartApproxDate").attr("disabled", true);
                        $("#cboBG").attr("disabled", true);
                        $("#txtApproxDuration").attr("disabled", true);
                        $("#txtProbabilityCurrent").attr("disabled", true);
                        $("#cboOU").attr("disabled", true);
                        $("#txtResourceDemand").attr("disabled", true);
                        $("#txtProspectCustomer").attr("disabled", true);
                        $("#cboProduct").attr("disabled", true);
                        $("#cboProject").attr("disabled", true);
                        $("#txtTitle").attr("disabled", true);
                        $("#txtDescription").attr("disabled", true);
                        $("#cboDU").attr("disabled", true);
                        $("#cboDT").attr("disabled", true);
                        ///chaged/commented  by mahesh on 20 july 2021
                        ///$("#cboStatusEdit").attr("disabled", true);
                        $("#txtIdentifiedDate").attr("disabled", true);
                        $("#txtProbabilityComment").attr("disabled", true);
                        $('#btnProject').attr("disabled", true);
                        $('#btnProduct').attr("disabled", true);
                        $('#txtAddress').attr("disabled", true);
                        $('#cboRegion').attr("disabled", true);
                        $('#cboCountry').attr("disabled", true);
                        $('#txtPinCode').attr("disabled", true);

                    }
                    else if (oprData.ApprovedStatusFilter == "Pending Approval" && oprData.ApprovedStatus == "RE") {
                        $('#cboCurrency').attr("disabled", true);
                        $("#txtValidTillDate").attr("disabled", true);
                        $("#txtStartApproxDate").attr("disabled", true);
                        $("#cboBG").attr("disabled", false);
                        $("#txtApproxDuration").attr("disabled", true);
                        $("#cboOU").attr("disabled", false);
                        $("#txtProspectCustomer").attr("disabled", true);
                        $("#cboProduct").attr("disabled", true);
                        $("#cboProject").attr("disabled", true);
                        $("#txtTitle").attr("disabled", true);
                        $("#txtDescription").attr("disabled", true);
                        $("#cboDU").attr("disabled", false);
                        $("#cboDT").attr("disabled", false);
                        $("#cboStatusEdit").attr("disabled", true);
                        $("#txtIdentifiedDate").attr("disabled", true);
                        $('#btnProject').attr("disabled", true);
                        $('#btnProduct').attr("disabled", true);
                        $('#txtAddress').attr("disabled", false);
                        $('#cboRegion').attr("disabled", false);
                        $('#cboCountry').attr("disabled", false);
                        $('#txtPinCode').attr("disabled", false);
                        $("#txtProbabilityComment").attr("disabled", true);
                        $("#txtResourceDemand").attr("disabled", false);
                        $("#txtProbabilityCurrent").attr("disabled", false);
                    }
                    else {
                        // alert(23);
                        $('#cboCurrency').attr("disabled", false);
                        $("#txtValidTillDate").attr("disabled", false);
                        $("#txtStartApproxDate").attr("disabled", false);
                        $("#cboBG").attr("disabled", false);
                        $("#txtApproxDuration").attr("disabled", false);
                        $("#txtProbabilityCurrent").attr("disabled", false);
                        $("#cboOU").attr("disabled", false);
                        $("#txtResourceDemand").attr("disabled", false);
                        $("#txtProspectCustomer").attr("disabled", false);
                        $("#cboProduct").attr("disabled", false);
                        $("#cboProject").attr("disabled", false);
                        $("#txtTitle").attr("disabled", false);
                        $("#txtDescription").attr("disabled", false);
                        $("#cboDU").attr("disabled", false);
                        $("#cboDT").attr("disabled", false);
                        $("#cboStatusEdit").attr("disabled", false);
                        $("#txtIdentifiedDate").attr("disabled", false);
                        $("#txtProbabilityComment").attr("disabled", false);
                        $('#btnProject').attr("disabled", false);
                        $('#btnProduct').attr("disabled", false);
                        $('#txtAddress').attr("disabled", false);
                        $('#cboRegion').attr("disabled", false);
                        $('#cboCountry').attr("disabled", false);
                        $('#txtPinCode').attr("disabled", false);
                    }
                    //  $("#ApprovalStatus").val(oprData.ApprovedStatusFilter);
                    document.getElementById("txtProspectCustomer").value = oprData.Prospect;
                    document.getElementById("txtTitle").value = oprData.Title;
                    document.getElementById("txtDescription").value = oprData.Description;
                    document.getElementById("txtAddress").value = oprData.Address;
                    //Added By Reshma chavan on 5th Jan 2022 for Placeholder Issue
                    if (oprData.CountryID == "0" || oprData.CountryID == undefined ) {
                        oprData.CountryID = "";
                    }
                    else {
                        oprData.CountryID = oprData.CountryID;
                    }
                    //End of Added By Reshma chavan on 5th Jan 2022 for Placeholder Issue
                    $("#cboCountry").val(oprData.CountryID);                                    
                    $("#cboCurrency").val(oprData.CurrencyID);
                    ($("#txtStartApproxDate").val(oprData.ApproxStartDate));

                    $("#cboDU").val(oprData.ResourcePoolID);
                    $("#txtValidTillDate").val(oprData.CoolingOf);
                    $("#txtProbabilityCurrent").val(oprData.ProbabilityCurrent);
                    $("#txtProbabilityComment").val(oprData.ProbabilityComment);
                    $("#cboRegion").val(oprData.RegionID);
                    document.getElementById("txtPinCode").value = oprData.PinCode;
                    document.getElementById("txtResourceDemand").value = oprData.Size;
                    $("#txtIdentifiedDate").val(oprData.RaisedDate);

                    $("#cboStatusEdit").val(oprData.StatusID);
                    document.getElementById("txtApproxDuration").value = oprData.ApproxDuration;
                    $("#cboIdentifiedBy").val(oprData.RaisedBy);
                    //$("#cboBG").val(oprData.BusinessGroupID);
                    FillBG(0, oprData.BusinessGroupID);
                    FillOU(oprData.BusinessGroupID, oprData.LocationID);
                    FillDU(oprData.LocationID, oprData.ResourcePoolID);
                    FillDT(oprData.ResourcePoolID, oprData.GroupID);

                    if (oprData.ProductID > 0) {
                        //alert("KHU");
                        $("#cboProduct").val(oprData.ProductID);
                        $('#btnProject').attr("disabled", true);
                        $("#btnProject").removeClass('active');
                        $("#btnProject").removeClass('btn-primary');
                        $("#btnProject").addClass('btn-default');
                        $("#btnProduct").addClass('active');
                        $("#btnProduct").addClass('btn-primary');
                        showHideProductProject('Product')

                    }
                    if (oprData.ProjectID > 0) {
                        // alert("APK");
                        $("#cboProject").val(oprData.ProjectID);
                        $("#btnProduct").removeClass('active');
                        $("#btnProduct").removeClass('btn-primary');
                        $("#btnProduct").addClass('btn-default');
                        $("#btnProject").addClass('active');
                        $("#btnProject").addClass('btn-primary');
                        showHideProductProject('Project');
                        // FillProject(data.CustomerID, oprData.ProjectID);
                    }
                    FillProject(data.CustomerID, oprData.ProjectID);
                    opportunityRequest.CustomerID = data.CustomerID;
                    if (UserRoleLevel == 3) {
                        $("#btnApprove").addClass("clsShowHide");
                        $("#btnReject").addClass("clsShowHide");
                    }
                    $("#btnShowApprovers").removeClass("clsShowHide");
                    $.ajax({
                        url: strUrl + '/api/RM_OpportunityRequest/GetOpportunityRequestApprovers',
                        type: "POST",
                        data: JSON.stringify(OpportunityID),
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                            if (OpportunityID) {
                                xhr.setRequestHeader("Params", encryptString(isJson(OpportunityID) ? OpportunityID : JSON.stringify(OpportunityID)));
                            }
                        },
                        success: function (data) {
                            ApproverList = data;
                            //if (data != null && data.length > 0) {
                            //     $("#btnShowApprovers").attr("disabled", false);
                            //}
                            //else {
                            //    $("#btnShowApprovers").attr("disabled", true);
                            //}

                        },
                        error: function (err) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify(err);
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            //StopAjaxLoader("#bodyBusiness-group");
                        }
                    });
                    // CheckForSendApprovalAndRevision();
                    //CheckForApproveAndReject(CretedBy, IsDemandApprover);
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    console.log(err);
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            });
            // debugger;
            CheckForApproveAndReject(CretedBy, IsDemandApprover);

        }

        var IsApproveReject;
        function CheckForApproveAndReject(CreatedBy, IsDemandApprover) {
            if (CreatedBy != SessionEmployeeId && IsDemandApprover == 1) {
                var OppID = $('#hdnOROpportunityId').val();
                var OP_Parameters = { OpportunityID: OppID };
                var strHTML = "";
                // StartLoader("#bodyBusiness-group");
                $.ajax({
                    url: strUrl + '/api/RM_OpportunityRequest/CheckForApproveReject',
                    type: "POST",
                    data: JSON.stringify(OP_Parameters),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (OP_Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(OP_Parameters) ? OP_Parameters : JSON.stringify(OP_Parameters)));
                        }
                    },
                    success: function (data) {
                        //GetOpportunityRequests();
                        if (data.IsSendForApproval == true) {
                            $("#btnRevision").addClass("clsShowHide");
                            $("#btnSendForApproval").addClass("clsShowHide");
                            $("#btnApprove").removeClass("clsShowHide");
                            $("#btnReject").removeClass("clsShowHide");
                        }
                        else {
                            if (data.OprStatus.trim() == "A") {
                                $("#btnRevision").removeClass("clsShowHide");//removeclass for OPR issue as per matrix
                                $("#btnSendForApproval").addClass("clsShowHide");
                            }
                            else {
                                $("#btnRevision").addClass("clsShowHide");
                                $("#btnSendForApproval").removeClass("clsShowHide");
                                $("#btnApprove").addClass("clsShowHide");
                                $("#btnReject").addClass("clsShowHide");
                            }

                        }
                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    //alertify.notify(err);
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
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

                });


            }
            else if (CreatedBy != SessionEmployeeId && IsDemandApprover == 0) {
                $("#btnRevision").addClass("clsShowHide");
                $("#btnSendForApproval").addClass("clsShowHide");
                $("#btnApprove").addClass("clsShowHide");
                $("#btnReject").addClass("clsShowHide");
                CheckForSendApprovalAndRevision(Ischeck, IsDemandApprover);
            }
            else if (CreatedBy == SessionEmployeeId && IsDemandApprover == 1) {
                var OppID = $('#hdnOROpportunityId').val();

                var OP_Parameters = { OpportunityID: OppID };
                $.ajax({
                    url: strUrl + '/api/RM_OpportunityRequest/GetStatusOfOpportunityRequest',
                    type: "POST",
                    data: JSON.stringify(OP_Parameters),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (OP_Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(OP_Parameters) ? OP_Parameters : JSON.stringify(OP_Parameters)));
                        }
                    },
                    success: function (data) {
                        var status = data;
                        //alert(status);
                        if (status == "S") {

                            $("#btnRevision").addClass("clsShowHide");
                            $("#btnSendForApproval").addClass("clsShowHide");
                            $("#btnApprove").removeClass("clsShowHide");
                            $("#btnReject").removeClass("clsShowHide");
                        }
                        //else if (UserRoleLevel == 3)
                        //{
                        //    alert(3);
                        //    $("#btnApprove").addClass("clsShowHide");
                        //    $("#btnReject").addClass("clsShowHide");
                        //     CheckForSendApprovalAndRevision(Ischeck);
                        //}
                        else {
                            // $("#btnSendForApproval").addClass("clsShowHide");
                            $("#btnApprove").addClass("clsShowHide");
                            $("#btnReject").addClass("clsShowHide");
                            CheckForSendApprovalAndRevision(Ischeck);
                        }
                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                });

            }
            else {
                //alert("ff");
                $("#btnApprove").addClass("clsShowHide");
                $("#btnReject").addClass("clsShowHide");
                $("#btnSendForApproval").removeClass("clsShowHide"); //SENT FOR APPROVAL BUTTON NOT COMING
                $("#btnRevision").addClass("clsShowHide");

                CheckForSendApprovalAndRevision(Ischeck, IsDemandApprover); //coomeneted for iisue no 26523 opr
            }

            // CheckForSendApprovalAndRevision(Ischeck, IsDemandApprover);
        }
        var revisionStatus = '';
        function CheckForSendApprovalAndRevision(Ischeck, IsDemandApprover) {
            //debugger;
            var OppID = $('#hdnOROpportunityId').val();
            var OP_Parameters = { OpportunityID: OppID };
            var strHTML = "";
            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/CheckForSendApprovalAndRevision',
                type: "POST",
                data: JSON.stringify(OP_Parameters),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (OP_Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OP_Parameters) ? OP_Parameters : JSON.stringify(OP_Parameters)));
                    }
                },
                success: function (data) {
                    // GetOpportunityRequests();
                    revisionStatus = data.OprStatus.trim();
                    if (data.IsSendForApproval) {
                        $("#btnRevision").addClass("clsShowHide");
                        //alert(Ischeck);
                        if (data.OprStatus == "RE" && Ischeck == true) {
                            // alert("Rf");//26502 OPR
                            $('#cboCurrency').attr("disabled", true);
                            $("#txtValidTillDate").attr("disabled", true);
                            $("#txtStartApproxDate").attr("disabled", true);
                            $("#cboBG").attr("disabled", true);
                            $("#txtApproxDuration").attr("disabled", true);
                            $("#cboOU").attr("disabled", true);
                            $("#txtProspectCustomer").attr("disabled", true);
                            $("#cboProduct").attr("disabled", true);
                            $("#cboProject").attr("disabled", true);
                            $("#txtTitle").attr("disabled", true);
                            $("#txtDescription").attr("disabled", true);
                            $("#cboDU").attr("disabled", true);
                            $("#cboDT").attr("disabled", true);
                            $("#cboStatusEdit").attr("disabled", true);
                            $("#txtIdentifiedDate").attr("disabled", true);
                            $("#txtProbabilityComment").attr("disabled", true);
                            $('#btnProject').attr("disabled", true);
                            $('#btnProduct').attr("disabled", true);
                            GetOpportunityRequest(OppID);
                        }
                        else if (data.OprStatus == "RE") {
                            GetOpportunityRequest(OppID);
                        }
                        else if (data.OprStatus.trim() == "D") {
                            $("#btnSendForApproval").removeClass("clsShowHide");
                        }
                    }
                    else if (data.IsRevision) {
                        //alert(data.IsRevision);
                        if (data.OprStatus.trim() == "R") {
                            $("#btnSendForApproval").removeClass("clsShowHide");
                            GetOpportunityRequest(OppID);
                        }
                        else {
                            $("#btnSendForApproval").addClass("clsShowHide");
                        }
                        $("#btnRevision").addClass("clsShowHide");//OPR sprint02 26363
                        if (data.OprStatus.trim() == "A")//OPR sprint02 26363
                        {
                            $("#btnRevision").removeClass("clsShowHide");
                            $("#btnSendForApproval").addClass("clsShowHide");
                        }
                    }
                    else {

                        $("#btnRevision").addClass("clsShowHide");
                        $("#btnSendForApproval").addClass("clsShowHide");
                    }
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

        }

        function CheckIsSendApproval() {
            var OppID = $('#hdnOROpportunityId').val();
            var OP_Parameters = { OpportunityID: OppID };
            var strHTML = "";
            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/CheckForApproveReject',
                type: "POST",
                data: JSON.stringify(OP_Parameters),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (OP_Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OP_Parameters) ? OP_Parameters : JSON.stringify(OP_Parameters)));
                    }
                },
                success: function (data) {
                    IsApproveReject = data.IsSendForApproval;
                    //LoadPagination('#BGtblmain', data);
                    // StopAjaxLoader("#bodyBusiness-group");
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

        }

        function FillFilterOU(params) {
            var strHTML = "";
            var BgID = $('#cboOPRFilterBusinessGroupID').val();
            var objBGCODE = { BusinessGroupID: BgID }
            //if (BgID != "" && BgID > 0) {
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/GetBusinessGroupsLocation',
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
                    $("#cboOPRFilterLocationID").empty();
                    // $("#cboOU")[0].selectedIndex = -1;
                    //var s = ('<option value=0></option>');
                    //$("#cboOU").append(s);
                    strHTML += "<option value='0'>Select Organization Unit</option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    }
                    $("#cboOPRFilterLocationID").html(strHTML);
                    if (params != null && params > 0 && params != undefined)
                        $("#cboOPRFilterLocationID").val(params);

                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

            //}
        }

        function FillFilterOUForFilter(params) {
            var strHTML = "";
            var BgID = $('#cboOPRFilterBusinessGroupID').val();
            if (BgID == "") {
                BgID = 0;
            }
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
                    strHTML += "<option value='0'>Select Organization Unit</option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    }
                    if (params != null && params > 0 && params != undefined)
                        $("#cboOPRFilterLocationID").val(params);

                    $("#cboOPRFilterLocationID").html(strHTML);

                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

            //}
        }

        function applyOPRFilter() {
            var filterFlag = true;
            var BGId = $("#cboOPRFilterBusinessGroupID").val() == "" ? null : $("#cboOPRFilterBusinessGroupID").val();
            var LocationID = $("#cboOPRFilterLocationID").val() == "" ? null : $("#cboOPRFilterLocationID").val();
            var Status = $("#cboOPRFilterApprovedStatus").val() == "" ? null : $("#cboOPRFilterApprovedStatus").val();
            //alert(BGId+ ","+ LocationID+","+ Status);
            if ((BGId == null || BGId == 'undefined' || BGId == 0) && (LocationID == null || LocationID == 'undefined' || LocationID == 0) && (Status == null || Status == 'undefined' || Status == 0)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                filterFlag = false;
                return false;
            }
            if (filterFlag == true) {
                currentFilterID = 0;
                var filterWhereClause;
                var AllOPRFilter = ["BusinessGroupID", "LocationID", "ApprovedStatus"];
                var filterWhereClause2 = GenerateBasicFilterQueryOPR("OPR", AllOPRFilter);

                filterWhereClause = filterWhereClause2.replace(/"/g, "\''");
                //   filter = { WhereClause: filterWhereClause,IntUserID: SessionEmployeeId }
                // filter = { filterWhereClause };
                GetOpportunityRequests(filterWhereClause);
                FilterApplied();
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");
            }
        }

        function GetSklDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                var whereClauseFormated = whereClause.replace(/'/g, "\''");
            }
            GetOpportunityRequests(whereClauseFormated);
        }

        function GenerateBasicFilterQueryOPR(module, filterField) {
            try {
                var strqtext = "";
                var txtBoxvalue = 0;
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    if (strOp != null && strOp != 'undefined' && strOp != "") {
                        strvalue = strOp
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
                       if (strOp == 'D') {
                            var strqtextRE = '';
                            //Commented and added by Chetan M on 19 July 2021 for filter crash issue
                            //strqtextRE += filterField[i] + " = 'RE'";
                            strqtextRE += filterField[i] + ' = "RE"';
                            //End of Commented and added by Chetan M on 19 July 2021 for filter crash issue
                            strqtext = '(' + strqtext + ' OR ' + strqtextRE + ')';

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
        //Filter Validation
        function checkFiltervalidationForOPR() {
            var BGId = $("#cboOPRFilterBusinessGroupID").val() == "" ? null : $("#cboOPRFilterBusinessGroupID").val();
            var LocationID = $("#cboOPRFilterLocationID").val() == "" ? null : $("#cboOPRFilterLocationID").val();
            var Status = $("#cboOPRFilterApprovedStatus").val() == "" ? null : $("#cboOPRFilterApprovedStatus").val();
            //alert(BGId+ ","+ LocationID+","+ Status);
            if ((BGId == null || BGId == 'undefined' || BGId == 0) && (LocationID == null || LocationID == 'undefined' || LocationID == 0) && (Status == null || Status == 'undefined' || Status == 0)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                $('#SklSavefilter').modal('hide');
            }
            else {
                $('#SklSavefilter').modal('show');
            }
        }
        function AvoidSpace(input) {
            if (/^\s/.test(input.value))
                input.value = '';
        }
        function SaveOPRFilterDetails() {
            var fltFilterName = $("#txtOPRFilterName").val();
            if (fltFilterName == "" || fltFilterName == " ") {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name');
                $("#txtOPRFilterName").focus();
            }
            //Added By Rehan C To add Validator for Special characters on 12th Nov 2022
            else if (checkSpecialCharacter(fltFilterName, WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                // $(ControlValidationFieldID[i]).focus()
                $("#txtOPRFilterName").focus();
            }
            //else if ($("#txtOPRFilterName").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtOPRFilterName").focus();
            //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Filtername cannot contain any of these /\:*?<>|,"+- characters.');
            //}
            else {
                var filterExists = 0;
                //if (savedFilterName == "") {
                //    filterExists = ExistBGFilter(fltFilterName);
                //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                //    $('#SklSavefilter').modal('show');
                //}

                //if (filterExists == 0) {
                //    $("#btnSaveFilter").attr("data-bs-dismiss", "modal");
                var AllOPRFilter = ["BusinessGroupID", "LocationID", "ApprovedStatus"];
                var filterWhereClause;
                var filterWhereClause2 = GenerateBasicFilterQueryOPR("OPR", AllOPRFilter);
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
                            $('#SklSavefilter').modal('hide');
                            FilterApplied();
                            GetMyFilter(0);
                            applyOPRFilter();
                            savedFilterName = fltFilterName;
                            $("#txtOPRFilterName").val('');
                            //clearTooltip();
                            // ClearFilterDetails("");
                        }


                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

                });
                // }
            }
        }

        //Exists Filters
        function ExistBGFilter(filtername) {

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
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (xhr, errorThrown) {
                //    isFilterExists = 1;
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                //},
                error: function (xhr, ajaxOptions, thrownError) {
                    isFilterExists = 1;
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            });
            return isFilterExists;
        }
        //End Exists Filters

        //Delete filter
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
                            GetOpportunityRequests();
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyFilter(0);
                        currentappliedfilter = 0;
                    }
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            });
        }

        //To set the default filter.
        function SetDefaultFilter(FilterID, flag) {
            // alert(flag);
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
                        ///changed by mahesh on 19 july 2021
                        ApplySavedFilter(FilterID, 2, true);
                        ///End changed by mahesh on 19 july 2021
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                    }
                    else {
                        //alertify.success('Default');
                        //FilterNotApplied();
                        //GetMyFilter(0);
                        ///changed by mahesh on 19 july 2021
                        ApplySavedFilter(FilterID, 3, true);
                        ///End changed by mahesh on 19 july 2021
                        alertify.success('Default Filter Is Successfully Removed!');
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                    }
                    GetMyFilter(0);
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            });
        }

        function GetMyFilter(flag) {
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

                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='radio' name='project2' onclick='SetDefaultFilter(this.id,&quot;default&quot;)' checked='checked'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-placement='right' title='Remove Default filter' class='checkmark'></span>";
                                strHTML += "</label>";

                            }
                            else {
                                strHTML += "<label class='customradio'>";
                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='radio' name='project2' onclick='SetDefaultFilter(this.id,&quot;&quot;)'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-placement='right' title='Set Default filter' class='checkmark'></span>";
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
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                    }
                                    else {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                    }
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }

                                strHTML += "</div>";
                            }
                            else {
                                strHTML += "<div class='custom_chckbox_markblue'>";
                                if (blnApply == true) {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }
                            }

                            strHTML += "<span onclick='OpenBasicFilter()' class='edit_filter'>";

                            strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Edit filter' id='" + ObjMyFilter.FilterId + "' class='fas fa-pencil-alt' onclick='EditFilter(this.id);'></i>";

                            strHTML += "</span>";

                            strHTML += "<span>";
                            if (blnApply == true) {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id,3);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3);'></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                            }
                            else {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;);></i>";
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
                        $("#MyFiltersdropdown").removeClass("show");
                    }
                    else {
                        $("#MyFiltersdropdown").addClass("clsShowHide");
                        $("#MyFiltersdropdown").removeClass("dropdown-menu");
                    }
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            });
            clearTooltip();
        }

        //Edit Filter
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
                        $("#txtOPRFilterName").val(currentFilterName);
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
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
            });
        }
        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtOPRFilterName').val("");
            }
        }
        function ClearFilterDetails(flag) {
            $("#cboOPRFilterBusinessGroupID").val("");
            $("#cboOPRFilterLocationID").val("");
            $("#cboOPRFilterLocationID").val("0");
            $("#cboOPRFilterApprovedStatus").val("");
            savedFilterName = "";
            $('#txtOPRFilterName').val("");

            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {

                    $(this).removeAttr("checked");
                });
            }

        }
        //Apply saved filter   
        function ApplySavedFilter(FilterID, isDefault, isFromDefault) {
            //Changed  by mahesh on 19 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {
                GetOpportunityRequests();
                GetMyFilter(isDefault);
                FilterNotApplied();
                ClearFilterDetails(""); // Added By Reshma Chavan on 31st Jan 2022 for clearing filter
                $('#AdvanceFilterIcon').attr("aria-expanded", false);
                if ((isFromDefault === false|| isFromDefault == 'false') && (isDefault == 3)) {
                //added by mahesh on 19 july 2021
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter removed successfully.");
                }  
            }
            //End Changed  by mahesh on 19 july 2021

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
                            GetSklDetails(Querytext);
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
                        //GetBGDetails(Querytext);
                        // call business group getRiskDetails(currentselectedProjectID, 0, "", "defaultfilterapply", Querytext);
                        if (currentDefaultFilterID > 0) {
                            FilterApplied();
                        }
                        //  GetMyFilter(1);
                        // alert(currentDefaultFilterID);
                        // alert(isDefault);
                        if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                            //alert("getf");
                            GetMyFilter(0);
                        }
                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

                });
                if (isDefault == undefined) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Filter applied successfully.");
                }
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
            //var arr = str.match(/(\([^\)]+\)|\S+|\s+)/);
            //var arr = str.match(/('.*?'|[^',\s]+[^(.*?),\s]+)(?=\s*,|\s*$)/g);
            for (var i = 0; i < arr.length; i++) {
                //alert(arr[i]);
            }

            var arrFields = currWhereClause.split(" ");
            arrFields = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);
            //if (arrFields[0] == "Description") {
            //    setFilterOpComboFieldValue(currWhereClause, arrFields, "cboSklFilterDescription", "txtSklFilterDescription");
            //}
            //if (arrFields[0] == "ConfiguredDays") {
            //    setFilterOpComboFieldValue(currWhereClause, arrFields, "cboSklFilterConfiguredDays", "txtSklFilterConfiguredDays");
            //}


            if (arrFields[0] == "BusinessGroupID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboOPRFilterBusinessGroupID").val(currValue);
                //FillFilterOU();
            }
            if (arrFields[0] == "LocationID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }

               /// changed by mahesh on 19 july
                ///FillFilterOU(currValue);
                $("#cboOPRFilterLocationID").val(currValue);
            }
            if (arrFields[0] == "ApprovedStatus") {
                  ///changed by mahesh
                var currValue = arrFields[2].toString().trim();
                if (currValue.includes("OR")) {
                    currValue = currValue.split("OR")[0]
                     if (currValue.includes("D")) {
                      currValue = "D"
                }
                } else {              
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                }
                $("#cboOPRFilterApprovedStatus").val(currValue);
            }

        }

        function setFilterComboValue(fieldName, fieldValue, flag) {
            //if (flag == undefined) {
            //    $("#" + fieldName).removeClass("selectpicker");
            //    $("#" + fieldName).val(fieldValue);
            //    $("#" + fieldName).addClass("selectpicker");
            //    $('.selectpicker').selectpicker('refresh');
            //}
            //if (flag == "class") {
            //  $("." + fieldName).removeClass("selectpicker");
            $("." + fieldName).val(fieldValue);
            //  $("." + fieldName).addClass("selectpicker");
            // $('.selectpicker').selectpicker('refresh');
            // }
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
        function FilterNotAppliedSB() {
            $(".mainclearalllinkSB").addClass("clsShowHide");
            $(".filter1 >  button").removeClass("clsFilterHighlight");
            $('#AdvanceFilterIconSB').attr("aria-expanded", false);
        }
        function FilterAppliedSB() {
            $(".mainclearalllinkSB").removeClass("clsShowHide");
            $(".filter1 >  button").addClass("clsFilterHighlight");
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
                $(this).attr("data-bs-original-title", "Apply filter");
            });
            $('[data-bs-toggle="tooltip"]').tooltip();

            fltPersonResponsible = "";
            currentappliedfilter = 0;
            currentFilterID = 0;
            currentappliedfilterclause = "";
            ClearFilterDetails("");
            GetSklDetails(null);
            //Added by imran for filter
            GetMyFilter(0);
            //end by imran
            FillFilterOUForFilter(0);
        });

        $(".mainclearalllinkSB").click(function () {
            $(".filter1").removeClass("active");
            //$('.filterpanel').collapse('toggle');                

            FilterNotAppliedSB();
            $(".filter1").removeClass("active");
            if ($('.filterpanel').hasClass("in")) {
                $('.filterpanel').removeClass("in");
            }
            $(".clsHideTooltip").each(function () {
                $(this).attr("data-bs-original-title", "Apply filter");
            });
            $('[data-bs-toggle="tooltip"]').tooltip();
            clearSoftbookFilter();

            softBookDetails(null);
        });

        //End Filter
        function editOpprtunityReq(OpportunityID, CretedBy, fromResourcePlan, oPRStatus) {
            if (fromResourcePlan != 1) {
                $('#tabRORdetails').click();
            }
            $("#download").show();//Added By Rehan C on 14th Mar 2023
            $('#cboIdentifiedBy').attr("disabled", true);
            $('#tabResourcePlan').removeClass("DisableContent");///$('#tabResourcePlan').addClass("DisableContent");
            $('#hdnOROpportunityId').val(OpportunityID);
            $(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 40
            }, 'slow');
            //used for disable grid
            $("#ORListTbl_wrapper .dataTables_scrollBody,.OPRtblouter,.backbtn, .paginate_button, .deletebtn, .filter,.addlistbtn,.search-query, .graybg .filter, .graybg .filedownload").addClass("DisableContent").parent().css("cursor", "no-drop");
            ///changed by mahesh on 15 july 2021
           /// $('#ORListTbl').DataTable().columns.adjust().draw();
            GetOpportunityRequest(OpportunityID);
            $('#hdnOproppId').val(OpportunityID);
            var IsDemandApproverFlag = $("#hdnOPR_IsDemandApprover").val();
            Ischeck = false;
            GetOPRById(OpportunityID, CretedBy, IsDemandApproverFlag);
            //if (showvalue == 1) {
            document.getElementById('statusOpen').style.display = "none";
            document.getElementById('statusAll').style.display = "block";
            //Added By Reshma Chavan on 5th Jan 2022 for Refresh IssueID-31791
            CheckForSendApprovalAndRevision(Ischeck);
            //End of Added By Reshma Chavan on 5th Jan 2022 for Refresh IssueID-31791
            //  }
        }
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();

        $('body').tooltip({
            selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
            trigger: 'hover',
            container: 'body'
        }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
            $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
        });

        //change date format
        var months = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };
        var autoDate = new Date();
        //autoDate = setDate(autoDate.getDay() - 1);

        //datepicker
        $('#txtIdentifiedDate').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd MM yy'
        });
        $('#txtValidTillDate').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd MM yy',
            // maxDate: '+30Y',
        });
        $('#txtStartApproxDate').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd MM yy'
        });


        $('.btn-toggle.toggleswitch').click(function () {
            $(this).find('.btn').toggleClass('active');
            if ($(this).find('.btn-primary').size() > 0) {
                $(this).find('.btn').toggleClass('btn-primary');
            }

        });

        function cancledetailpanel() {

            //Added By RehanC for Tab navigation Issue on 27th Mar 2023
            $("#tabRORdetails").tab('show');
            //End of Comment By RehanC for Tab navigation Issue on 27th Mar 2023
        }
        //$('#tabRORdetails').click(function () {
        //    debugger;
        //   // var OppID = $('#hdnOROpportunityId').val();
        //    //editOpprtunityReq(OppID, SessionEmployeeId);
        //   // alert(document.getElementById("ApprovalStatus").innerHTML);
        //    if (ResoucePlanList.length > 0 && ((document.getElementById("ApprovalStatus").innerHTML != "Approved") || (document.getElementById("ApprovalStatus").innerHTML != "Rejected"))) {
        //        if (document.getElementById("ApprovalStatus").innerHTML == "Sent for Approval") {
        //            alert("");
        //            $('#btnSendForApproval').addClass("clsShowHide");
        //        }
        //        else {
        //            alert("wew");
        //            $('#btnSendForApproval').removeClass("clsShowHide");
        //        }
        //    }

        //    else {
        //         $('#btnSendForApproval').addClass("clsShowHide");
        //    }

        //});

        function addORlist(showHideValue) {
            $('#btnSaveOPR').removeClass("clsShowHide");
            $('#btnSaveAddOPR').removeClass("clsShowHide");
            $("#download").hide();//Added By Rehan C on 14th Mar 2023
            document.getElementById("ApprovalStatus").innerHTML = "";
            cancleOpportunityRequest();
            $("#hdnOproppId").val(0);
            $('#tabRORdetails').click();
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 200
            }, 'slow');
            //used for disable grid
            $("#ORListTbl_wrapper .dataTables_scrollBody,.OPRtblouter,.backbtn, .paginate_button, .addlistbtn,.search-query, .graybg .filter, .graybg .filedownload").addClass("DisableContent").parent().css("cursor", "no-drop");

            $('#ORListTbl').DataTable().columns.adjust().draw();
            $(this).closest('tr').addClass('rowhiglight');
            if (showHideValue == 0) {
                document.getElementById('statusAll').style.display = "none";
                document.getElementById('statusOpen').style.display = "block";
            }
            $('#tabResourcePlan').addClass("DisableContent");
            $('#cboIdentifiedBy').attr("disabled", false);
            /// $('#tabResourcePlan').attr("disabled", true);
            $("#btnRevision").addClass("clsShowHide");
            $("#btnSendForApproval").addClass("clsShowHide");
            $("#btnApprove").addClass("clsShowHide");
            $("#btnReject").addClass("clsShowHide");
            $("#btnShowApprovers").removeClass("clsShowHide"); //issue no 135

            $('#cboCurrency').attr("disabled", false);
            $("#txtValidTillDate").attr("disabled", false);
            $("#txtStartApproxDate").attr("disabled", false);
            $("#cboBG").attr("disabled", false);
            $("#txtApproxDuration").attr("disabled", false);
            $("#txtProbabilityCurrent").attr("disabled", false);
            $("#cboOU").attr("disabled", false);
            $("#txtResourceDemand").attr("disabled", false);
            $("#txtApproxDuration").attr("disabled", false);
            $("#txtProspectCustomer").attr("disabled", false);
            $("#cboProduct").attr("disabled", false);
            $("#cboProject").attr("disabled", false);
            $("#txtTitle").attr("disabled", false);
            $("#txtDescription").attr("disabled", false);
            $("#cboDU").attr("disabled", false);
            $("#cboDT").attr("disabled", false);
            $("#cboStatusEdit").attr("disabled", false);
            $("#txtIdentifiedDate").attr("disabled", false);
            $("#txtProbabilityComment").attr("disabled", false);
            $('#btnProject').attr("disabled", false);
            $('#btnProduct').attr("disabled", false);
            $("#cboIdentifiedBy").attr("disabled", false);
            $('#txtAddress').attr("disabled", false);
            $('#cboRegion').attr("disabled", false);
            $('#cboCountry').attr("disabled", false);
            $('#txtPinCode').attr("disabled", false);

            //Added By Reshma Chavan on 7th Dec 2021 For Bind Placeholder
            $("#cboCurrency").val(0);
            //End of Added By Reshma Chavan on 7th Dec 2021 For Bind Placeholder
        }


        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#ORListTbl_wrapper .dataTables_scrollBody,.OPRtblouter, .backbtn, .paginate_button, .addlistbtn,.search-query, .graybg .filter, .filedownload").removeClass("DisableContent").parent().css("cursor", "auto");
            ///changed by mahesh on 15 july 2021
            ///$('#ORListTbl').DataTable().columns.adjust().draw();
        });


        //datatable

        $('#ORListTbl').dataTable({
            //"ajax": '/api/data',
            "scrollY": false,
            "scrollX": true,
            //"scroller": true,
            "pageLength": 5,
            //"paging": false,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true
            //"scrollable":true,
            //"scrollCollapse": true
        });

        $('#RDAEmployeeTbl').dataTable({
            "scrollY": '190px',
            "pageLength": 5,
            //"paging": false,
            "lengthChange": false,
            "bFilter": false,
            "bInfo": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
            "bAutoWidth": false

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
        $('#ResrsSoftBookingModal').on('shown.bs.modal', function () {
            $('#softbookingTbl').DataTable().columns.adjust().draw();
        })

        $('#softbookingTbl').DataTable().columns.adjust().draw();


        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        //function resizeSection() {
        //    var tblheight = $(window).height();
        //    $('#ORListTbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 240, "overflow-y": "auto" });
        //    $('#softbookingTbl_wrapper .dataTables_scrollBody').css({ 'height': 300, "overflow-y": "auto" });


        //}
        //$(window).on("load resize scroll", function (e) {
        //    resizeSection(this);

        //});


        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

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


        //Search List Filter
        function mysearchFunction() {
            //var input, filter, table, tr, td, i, txtValue;
            //input = document.getElementById("srchORlist");
            //filter = input.value.toUpperCase();
            //table = document.getElementById("ORListTbl");
            //tr = table.getElementsByTagName("tr");
            //for (i = 0; i < tr.length; i++) {
            //    td = tr[i].getElementsByTagName("td")[0];
            //    if (td) {
            //        txtValue = td.textContent || td.innerText;
            //        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            //            tr[i].style.display = "";
            //        } else {
            //            tr[i].style.display = "none";
            //        }
            //    }
            //}
            var SearchText = $("#srchORlist").val();
            var strHTML = "";

            var FilterTitle = OpportunityRequests.filter(function (x) { return x.Title.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 });
            ReloadTableSearchForOPR(FilterTitle);


        }

        function ReloadTableSearchForOPR(List) {
            var strHTML = "";
            $("#tblOpportunityRequests").html('');
            if (List != null && List.length > 0) {
                $.each(List, function (index, obj) {
                    if (blnEditAccess == "True" && blnDeleteAccess == "True") {
                        if (obj.ApprovedStatusFilter == "Pending Approval") {
                            // strHTML += '<tr><td><input type="hidden" name="hdnOPR_IsDemandApprover" id="hdnOPR_IsDemandApprover" value= ' + obj.IsDemandApprover + '>' + obj.Prospect + ' </td><td>' + obj.Title + ' </td><td>' + obj.CoolingOf + '</td><td>' + obj.OpportunityStatus + '</td><td>' + obj.ApprovedStatusFilter + '</td><td>' + obj.ProjectName + '</td><td>' + obj.CustomerName + '</td><td class="actioncolumn"><a class="nostylebtn editOpprtunityReq edit" href="javascript:;" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-bs-original-title="Edit" onclick="editOpprtunityReq(' + obj.OpportunityID + ',' + obj.IntUserId + ',' + 0 +')"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px"></a><a onclick="DeleteOpportunityRequest(' + obj.OpportunityID + ')" class="nostylebtn delete"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-bs-original-title="Delete"></i></a></td></tr>';
                            strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'><a class='nostylebtn editOpprtunityReq edit' href='#' data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Edit' onclick=\"(editOpprtunityReq('" + obj.OpportunityID + "','" + obj.IntUserId + "','" + 0 + "','" + obj.ApprovedStatusFilter + "'))\"><i class='fas fa-pencil-alt' style='font-size:16px;color: #464a4c'></i></a><a  onclick='DeleteOpportunityRequest(" + obj.OpportunityID + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Delete'></i></a></td></tr>";
                        }
                        else {
                            strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'><a class='nostylebtn editOpprtunityReq edit' href='#' data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Edit' onclick=\"(editOpprtunityReq('" + obj.OpportunityID + "','" + obj.IntUserId + "','" + 0 + "','" + obj.ApprovedStatusFilter + "'))\"><i class='fas fa-pencil-alt' style='font-size:16px;color: #464a4c'></i></a><a style='pointer-events: none;color: #d4cccc;' onclick='DeleteOpportunityRequest(" + obj.OpportunityID + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Delete'></i></a></td></tr>";
                        }
                    }
                    else if (blnEditAccess == "True" && blnDeleteAccess == "False") {
                        strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'><a class='nostylebtn editOpprtunityReq edit' href='javascript:;'  data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Edit' onclick=\"(editOpprtunityReq('" + obj.OpportunityID + "','" + obj.IntUserId + "','" + 0 + "','" + obj.ApprovedStatusFilter + "'))\"><i class='fas fa-pencil-alt' style='font-size:16px;color: #464a4c'></i></a></td></tr>";
                    }
                    else if (blnEditAccess == "False" && blnDeleteAccess == "True") {
                        if (obj.ApprovedStatusFilter == "Pending Approval") {
                            strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'><a onclick='DeleteOpportunityRequest(" + obj.OpportunityID + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Delete'></i></a></td></tr>";
                        }
                        else {
                            strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'><a style='pointer-events: none;color: #d4cccc;' onclick='DeleteOpportunityRequest(" + obj.OpportunityID + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Delete'></i></a></td></tr>";
                        }
                    }
                    else if (blnEditAccess == "False" && blnDeleteAccess == "False") {
                        strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'></td></tr>";

                    }
                    else {
                        strHTML += "<tr><td><input type='hidden' name='hdnOPR_IsDemandApprover' id='hdnOPR_IsDemandApprover' value= " + obj.IsDemandApprover + ">" + obj.Prospect + " </td><td>" + obj.Title + " </td><td>" + obj.CoolingOf + "</td><td>" + obj.OpportunityStatus + "</td><td>" + obj.ApprovedStatusFilter + "</td><td>" + obj.ProjectName + "</td><td>" + obj.CustomerName + "</td><td class='actioncolumn'><a style='pointer-events: none;color: #d4cccc;' onclick='DeleteOpportunityRequest(" + obj.OpportunityID + ")' class='nostylebtn delete'><i class='far fa-trash-alt'  data-bs-toggle='tooltip' data-placement='top' data-container='body' data-bs-original-title='Delete'></i></a></td></tr>";
                    }

                });
                $('#ORListTbl').dataTable().fnDestroy();
                $("#tblOpportunityRequests").html(strHTML);
                LoadPagination('#ORListTbl');
                StopAjaxLoader("#bodyOpportunityResource-group");
            }
            else {
                strHTML += '<tr><td class="text-center"colspan="8">' + NoDataFound + ' </td></tr>';
                $('#ORListTbl').dataTable().fnDestroy();
                $("#tblOpportunityRequests").html(strHTML);

                // $(".chckHeadForSoftBooking").prop("checked", false);
            }
        }

        //$('.plandatepicker').datepicker();
                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboSkills", "usp_Whizible2_sel_tbl_PM_Tools_Category_CategoryName",,, "class='form-control'", True,,) %>--%>

         //var areabox = '<% CommonFunctions.HTMLControls.DrawTextArea("description2", "txtDescription2", "Enter Summary (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Summary (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>';
        var cboRole = '<span style="display: inline-block;color:red;">*</span><%=CommonFunctions.HTMLControls.DrawComboBox("cboResourceRole", "usp_Whizible2_Sel_tbl_PM_SoftBookRole", , , "class=""form-control clsPlanWidth clCboOrRole clsAsterLink""", True, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
        var cboSkils = '<span style="display:flex;align-items:center"><span style="display: inline-block;color:red;">*</span><%=CommonFunctions.HTMLControls.DrawComboBox("cboResourceSkill", "usp_Whizible2_sel_tbl_PM_Tools_Skills", , , "class=""form-control clsPlanWidth clCboOrSkils clsAsterLink""", True, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%></span>';

            //var textsads = '<% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterProjectRiskID", "txtPMFilterProjectRiskID", "form-control",,,,,, ,,,, " onkeypress='return Field_OnKeyPress(event)' ",, ,,,,, True) %>';
        // Append table with add row form on add new button click
        $(document).on("click", ".rsrsplantbl .add-new", function (id) {
            // var datePickecIn = '<span style="display: inline-block;color:red;">*</span><input  class="ClORResourceInDate" id="ResourceInDateAdd" type="text" style="width:78%;" value="" name=""><span class="input-group-btn"  style="display: inline-block;"> <button style="pointer-events:none;display: inline-block;" class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button></span>';
            var datePickecIn = '<span style=display:flex;align-items:center><span style="display: inline-block;color:red;">*</span><input  class="ClORResourceInDate" id="ResourceInDateAdd" type="text" style="width:78%;" value="" name=""><span class="pull-right btn-xs" style="padding-top: 5px; margin-right: :0px;"><i class="fa fa-calendar" aria-hidden="true"></i></span></span>';

            //  var datePickecOut = '<span style="display: inline-block;color:red;">*</span><input class="ClORResourceOutDate" id="ResourceOutDateAdd" type="text" style="width:78%;" value="" name=""><span class="input-group-btn" style="display: inline-block;"> <button style="pointer-events:none;display: inline-block;" class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button></span>';
            var datePickecOut = '<span style="display:flex;align-items:center"><span style="display: inline-block;color:red;">*</span><input class="ClORResourceOutDate" id="ResourceOutDateAdd" type="text" style="width:78%;" value="" name=""><span class="pull-right btn-xs" style="padding-top: 5px; margin-right: :0px;"> <i class="fas fa-calendar-alt"></i></span></span>';
            var txtaSpecialRequest = '<textarea class="form-control"  maxlength="500" class="cltxtaSpecialRequest" id="txtaSpecialRequest" value=""></textarea>';
            var actions = $(".rsrsplantbl td.actioncolumn").html();
            //if (actions == 'undefined' || actions == null) {
            //    var actions = $(".rsrsplantbl td.actioncolumn").html('<td><a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip" data-container="body"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a><a class="nostylebtn editOpprtunityReq edit" href="javascript:;" title="" data="" -="" toggle="tooltip" placement="top" container="body" original="" data-bs-original-title=""> <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px"></a><a class="nostylebtn delete" style="display: inline;"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-bs-original-title="Delete"></i></a><a class="nostylebtn cancelrowvalue" style="display: none;"><i class="fas fa-times" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-bs-original-title="Cancel"></i></a></td>');

            //}
            $(this).attr("disabled", "disabled");
            var index = $(".rsrsplantbl tbody tr:last-child").index();
            //var row = '<tr class="newaddedrow">' + '<td class="text-left"><select id="RProle" class="form-control" name="RProle"><option>Others</option><option>Role 1</option><option>Role 2</option></select></td>' + '<td class="text-left"><select id="RPSkill" class="form-control" name="RPSkill"><option>Java</option><option>SQL</option></select></td>' + '<td><input type="text" class="form-control plandatepicker" name="RPFTE" placeholder="2" id="RPFTE"></td>' + '<td><input type="text" class="form-control plandatepicker" name="RPInDate" placeholder="" id="RPInDate"></td>' + '<td><input type="text" class="form-control plandatepicker" name="RPOutDate" placeholder="" id="RPOutDate"></td>' + '<td><textarea class="form-control">&nbsp;</textarea></td>' + '<td><a id="RPDistribution" name="RPDistribution" href="javacript:;" data-bs-toggle="modal" data-bs-target="#ResrsDistributionFreqModal" data-bs-original-title="" title="">Distribution</a></td>' + '<td><a id="RPSoftBooking" name="RPSoftBooking" href="javacript:;" data-bs-toggle="modal" data-bs-target="#ResrsSoftBookingModal" data-bs-original-title="" title="">Soft Booking</a></td >' + '<td class="actioncolumn">' + actions + '</td>' + '</tr>';
            //if now row available
            //if (actions == 'undefined' || actions == null) {
            var row = '<tr class="newaddedrow">' + '<td>' + cboRole + '</td>' + '<td style="display:flex;align-items:center">' + cboSkils + '</td>' + '<td><span style="display: inline-block;color:red;">*</span><input style="width:78%;display: inline-block;" type="text" maxlength="6" class="form-control cltxtFTE" name="RPFTE" placeholder="Enter FTE" id="RPFTE"></td>' + '<td class="text-left">' + datePickecIn + '</td>' + '<td class="text-left">' + datePickecOut + '</td>' + '<td>' + txtaSpecialRequest + '</td>' + '<td></td>' + '<td></td >' + '<td class="actioncolumn"><a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip" data-container="body"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a><a class="nostylebtn editOpprtunityReq edit" href="javascript:;" title="" data="" -="" toggle="tooltip" placement="top" container="body" original="" data-bs-original-title=""> <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px"></a><a class="nostylebtn delete" style="display: inline;"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body"></i></a><a class="nostylebtn cancelrowvalueForDelete" style="display: none;"><i class="fas fa-times" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-bs-original-title="Cancel"></i></a></td>' + '</tr>';
            //} else {
            /// var row = '<tr class="newaddedrow">' + '<td class="text-left">' + cboRole + '</td>' + '<td class="text-left">' + cboSkils + '</td>' + '<td><input type="text" maxlength="6" class="form-control cltxtFTE" name="RPFTE" placeholder="2" id="RPFTE"></td>' + '<td>' + datePickecIn + '</td>' + '<td>' + datePickecOut + '</td>' + '<td>' + txtaSpecialRequest + '</td>' + '<td><a id="RPDistribution" name="RPDistribution" href="javacript:;" data-bs-toggle="modal" data-bs-target="#ResrsDistributionFreqModal" data-bs-original-title="" title="">Distribution</a></td>' + '<td><a id="RPSoftBooking" name="RPSoftBooking" href="javacript:;" data-bs-toggle="modal" data-bs-target="#ResrsSoftBookingModal" data-bs-original-title="" title="">Soft Booking</a></td >' + '<td class="actioncolumn">' + actions + '</td>' + '</tr>';
            ///}

            var $row = $(this).closest("tr");
            $tds = $row.find("td");


            $('.rsrsplantbl').on('focus', ".ClORResourceInDate, .ClORResourceOutDate", function () {
                $(this).datepicker({
                    autoclose: true,
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'dd MM yy'
                });
            });

            //  var selectedInDate = $(this).parents("tr").find('.ClORResourceInDate');
            // var dateToday = new Date();
            //selectedInDate.datepicker("setDate", new Date(dateToday));
            //$('#riskplan table').find('.plandatepicker').datepicker();
            $(".rsrsplantbl tbody").append(row);
            $(".rsrsplantbl tbody tr").eq(index + 1).find(".add, .edit").toggle();
            $(".rsrsplantbl tbody tr").eq(index + 1).find(".delete, .cancelrowvalueForDelete").toggle();
            $(".rsrsplantbl .add-new").removeAttr("disabled");
            $(".rsrsplantbl th").css("min-width", "100px");
            $(".rsrsplantbl th:first-child").css("min-width", "200px");
            $(".rsrsplantbl th:last-child").css("min-width", "80px");
            // $(".rsrsplantbl th:nth-child()").css("min-width", "50px");


        });

        // Add row on add button click
        var validateflag = false;
        $(document).on("click", ".rsrsplantbl .add", function (OpportunityID) {
            //$('.rsrsplantbl').on("click", ".add", function () {
            var empty = false;
            var input = $(this).parents("tr").find('input[type="text"]');
            var select = $(this).parents("tr").find('select');
            var OrResourceRow = $(this).parents("tr");
            var isVallid = validateRequestPlanRow(OrResourceRow);
            if (isVallid == true) {

                var RoleID = OrResourceRow.find('.clCboOrRole').val();
                var SkillID = OrResourceRow.find('.clCboOrSkils').val();
                //var selectRole = OrResourceRow.find('.clCboOrRole');
                //var selectedSkills = OrResourceRow.find('.clCboOrSkils');
                var FTE = OrResourceRow.find('.cltxtFTE').val();

                var ResourceInDate = OrResourceRow.find('.ClORResourceInDate').val();
                var ResourceOutDate = OrResourceRow.find('.ClORResourceOutDate').val();
                var SpecialRequest = OrResourceRow.find('#txtaSpecialRequest').val();
                var PipelineID = OrResourceRow.find("#hdnOR_PipelineIDEdit").val();
                var PipelineIdParam = 0;
                if (PipelineID > 0) {
                    PipelineIdParam = PipelineID;
                }

                var OppID = $('#hdnOROpportunityId').val();
                var ORResourcePlanObject = { PipelineID: PipelineIdParam, OpportunityID: OppID, ToolID: SkillID, RoleID: RoleID, TotalFTE: FTE, TentativeStartDate: ResourceInDate, TentativeEndDate: ResourceOutDate, CreatedBy: UserName, Description: SpecialRequest }
                if (ORResourcePlanObject != null) {
                    //Commented and Added By RehanC for saving issue on 23rd Mar 2023
                    // SaveOResourcePlan(ORResourcePlanObject.OpportunityID);
                    SaveOResourcePlan(ORResourcePlanObject);
                    //End of Comment By RehanC on 23rd Mar 2023
                    //OrResourceRow.find("#hdnOR_PipelineIDEdit").val(0);
                }
                //var sdfd = $(this).parents("tr").getElementById('cboResourceIn');
                //alert(sdfd.val);
                //alert(sdfd.text);
                var textarea = $(this).parents("tr").find('textarea');
                //alert(textarea.val());
                //var $row = $(this).closest("tr");
                //$tds = $row.find("td");
                //$.each($tds, function (index, obj) {
                //    //alert($(this).text.val());

                //});
                //console.log(select);
                //    input.each(function(){
                //  if(!$(this).val()){
                //    $(this).addClass("error");
                //    empty = true;
                //  } else{
                //    $(this).removeClass("error");
                // }
                //});
                //$(".rsrsplantbl .add-new").removeAttr("disabled");
                select.each(function () {
                    if (!$(this).parent("td").html($(this).val())) {
                        $(this).addClass("error");
                        empty = true;
                    } else {
                        $(this).removeClass("error");
                    }
                });

                select.each(function () {
                    $(this).parent("td").html($(this).val());
                });

                textarea.each(function () {
                    if (!$(this).parent("td").html($(this).val())) {
                        $(this).addClass("error");
                        empty = true;
                    } else {
                        $(this).removeClass("error");
                    }
                });

                textarea.each(function () {
                    $(this).parent("td").html($(this).val());
                });

                $(this).parents("tr").find(".error").first().focus();
                if (!empty) {
                    input.each(function () {
                        $(this).parent("td").html($(this).val());
                    });
                    select.each(function () {
                        $(this).parent("td").html($(this).val());
                    });
                    textarea.each(function () {
                        $(this).parent("td").html($(this).val());
                    });
                    $(this).parents("tr").find(".add, .edit").toggle();
                    $(this).parents("tr").find(".delete, .cancelrowvalue").toggle();
                    $(".rsrsplantbl .add-new").removeAttr("disabled");

                }

            }
        });


        //Cancel row value
        $('.rsrsplantbl').on("click", ".cancelrowvalue", function () {
            var empty = false;
            $(".rsrsplantbl .add-new").removeAttr("disabled");
            var $row = $(this).closest("tr");
            //var PipelineID = $row.find("#hdnOR_PipelineID").val();
            //var RoleValue = $row.find("#cboResourceRole").val(); // $row.find('#hdnOR_RoleID').val();
            //if(RoleValue==null && (PipelineID ="" || PipelineID===undefined) ) {
            var OppID = $('#hdnOROpportunityId').val();
            GetOpportunityRequest(OppID);
            //}
            var input = $(this).parents("tr").find('input[type="text"]');
            var select = $(this).parents("tr").find('select');
            var textarea = $(this).parents("tr").find('textarea');
            ///var divDate = $(this).parents("tr").find('div');
            $(this).closest('tr').siblings().find('.edit').removeClass("clsShowHide");
            input.each(function () {
                $(this).parent("td").html($(this).val());
                $(this).parent("td").html();
            });
            select.each(function (index, obj) {
                if (index == 0) {
                    $(this).parent("td").html($("#cboResourceRole option:selected").text());
                }
                if (index == 1) {
                    $(this).parent("td").html($("#cboResourceSkill option:selected").text());
                }
                else {
                    $(this).parent("td").html($(this).val());
                }


            });
            textarea.each(function () {
                $(this).parent("td").html($(this).val());
            });
            //divDate.each(function () {
            //    $(this).parent("td").html($(this).val());
            //});
            $(this).parents("tr").find(".add, .edit").toggle();
            $(this).parents("tr").find(".delete, .cancelrowvalue").toggle();

            $(".rsrsplantbl th").css("min-width", "auto");
            $(".rsrsplantbl th:first-child").css("min-width", "auto");
            $(".rsrsplantbl th:last-child").css("min-width", "auto");
            // $(".rsrsplantbl th:nth-child()").css("min-width", "auto");


            $(".add-new").removeAttr("disabled");

        });

        $('.rsrsplantbl').on("click", ".cancelrowvalueForDelete", function () {
            $(this).parents("tr").remove();
            $(".rsrsplantbl .add-new").removeAttr("disabled");
        });


        ///Dynamic rows for add and edit 


        // Edit row on edit button click
        $(document).on("click", ".rsrsplantbl .edit", function () {
             //var cboRole = '<% CommonFunctions.HTMLControls.DrawComboBox("cboResourceIn", "usp_Whizible2_sel_tbl_PM_Role_Roles",,, "class=""form-control clsPlanWidth"" ,""",,,, ,)%>';
            //var cboSkils = '<% CommonFunctions.HTMLControls.DrawComboBox("cboResourceOut", "usp_Whizible2_sel_tbl_PM_Tools_Skills",,, "class=""form-control clsPlanWidth"",""",,,, ,)%>';
           <%-- var datePickecIn = '<input  class="ClORResourceInDate"  type="text" value="" name=""><span class="input-group-btn"> <button style="pointer-events:none;" class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button></span>';
            var cboRole = '<% CommonFunctions.HTMLControls.DrawComboBox("cboResourceIn", "usp_Whizible2_sel_tbl_PM_Role_Roles",,, "class=""form-control clsPlanWidth clCboOrRole"" ,""",,,, ,)%>';
            var cboSkils = '<% CommonFunctions.HTMLControls.DrawComboBox("cboResourceOut", "usp_Whizible2_sel_tbl_PM_Tools_Skills",,, "class=""form-control clsPlanWidth clCboOrSkils"",""",,,, ,)%>';
            //var datePickecIn = '<input  class="ClORResourceInDate"  type="text" value="" name=""><span class="input-group-btn"> <button style="pointer-events:none;" class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button></span>';
            //var datePickecOut = '<input class="ClORResourceOutDate type="text" value="" name=""><span class="input-group-btn"> <button style="pointer-events:none;" class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button></span>';--%>
            var $row = $(this).closest("tr");
            var PipelineID = $row.find("#hdnOR_PipelineID").val();
            // $('.clResourceInDate').each(function () {
            //$(this).removeClass('hasDatepicker').datepicker();
            ///});

            var RoleValue = $row.find('#hdnOR_RoleID').val();
            var SkillValue = $row.find('#hdnOR_SkillID').val();
            var SpeicalRequest = $row.find('#hdnOR_SpecialRequest').val();
            $tds = $row.find("td");
            $row.siblings().find('.edit').addClass("clsShowHide");
            // currentTD.find('').attr("disabled", "disabled");

            $.each($tds, function (index, obj) {

                $('#ResourceInDate, #ResourceOutDate').datepicker({
                    autoclose: true,
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'dd MM yy'
                });
                //$('ResourceOutDate').dateFormat('dd MM yy');
                if (index == 0) {

                    $(this).html(cboRole);
                    $(this).find("#cboResourceRole").val(RoleValue);
                }
                else if (index == 1) {
                    $(this).html(cboSkils);
                    $(this).find("#cboResourceSkill").val(SkillValue);
                }
                else if (index == 2)
                //Commented and Modified By RehanC for edit SoftBooking Crash on 28th Mar 2023
                //{
                //    $(this).html('<input type="hidden" name="hdnOR_PipelineIDEdit" id="hdnOR_PipelineIDEdit" class=".clhdnOR_PipelineIDEdit" value= ' + PipelineID + '><span style="display: inline-block;color:red;">*</span><input style="width:85%;display: inline-block;" type="text" maxlength="6" class="form-control  text-center cltxtFTE" placeholer="Enter FTE"  value="' + $(this).text().trim() + '">');
                //}
                {
                    $(this).html('<input type="hidden" name="hdnOR_PipelineIDEdit" id="hdnOR_PipelineIDEdit" class=".clhdnOR_PipelineIDEdit" value= ' + PipelineID + '><span style="display: inline-block;color:red;">*</span><input style="width:85%;display: inline-block;" type="text" maxlength="6" class="form-control  text-center cltxtFTE" placeholer="Enter FTE"  value="' + $(this).text().trim() + '"><input type="hidden" name="hdnOR_RoleIDEdit" id="hdnOR_RoleIDEdit" class="hdnOR_RoleIDEdit" value= ' + RoleValue + '>');
                }
                //End of Comment By RehanC for edit SoftBooking Crash on 28th Mar 2023
                else if (index == 3) {
                    $(this).html('<span class="pull-left" style="display: inline-block;color:red;margin-top: 10px;">*</span><input style="width:76%;margin-top:5px;" class="ClORResourceInDate pull-left" id="ResourceInDate" type="text" value="' + $(this).text() + '" name="" class="form-control hasDatepicker"><span class="pull-right btn-xs" style="padding-top: 8px; margin-right: :0px;"><i class="fa fa-calendar" aria-hidden="true"></i></span>');
                }
                else if (index == 4) {
                    $(this).html('<span class="pull-left" style="display: inline-block;color:red;margin-top: 10px;">*</span><input style="width:76%;margin-top:5px;" class="ClORResourceOutDate pull-left" id="ResourceOutDate"  type="text" value="' + $(this).text() + '" name="" class="form-control hasDatepicker"><span class="pull-right btn-xs" style="padding-top: 8px; margin-right: :0px;"><i class="fa fa-calendar" aria-hidden="true"></i></span>');
                }
                else if (index == 5) {
                    //$(this).html('');
                    $(this).html('<textarea class="form-control" maxlength="500" class="cltxtaSpecialRequest" id="txtaSpecialRequest" name="txtaSpecialRequest" value="' + SpeicalRequest + '"></textarea>');
                    $("textarea#txtaSpecialRequest").val(SpeicalRequest);

                }

                ////}

            });

            $(this).parents("tr").find(".add, .edit").toggle();
            $(this).parents("tr").find(".delete, .cancelrowvalue").toggle();
            $(".rsrsplantbl .add-new").attr("disabled", "disabled");

            $(".rsrsplantbl th").css("min-width", "100px");
            $(".rsrsplantbl th:first-child").css("min-width", "200px");
            $(".rsrsplantbl th:last-child").css("min-width", "80px");
            // $(".rsrsplantbl th:nth-child()").css("min-width", "50px");

        });

        // Delete row on delete button click
        $(document).on("click", ".rsrsplantbl .delete", function () {
            var $row = $(this).closest("tr");
            var PipelineID = $row.find("#hdnOR_PipelineID").val();
            $('#hdnORPipelineIDToDelete').val(PipelineID);
            $('#DeleteOrResourcePlanMModal').modal('show');
            //$(this).parents("tr").remove(); ('show');
            $(".add-new").removeAttr("disabled");
        });

        ///Mahesh:Resource plan
        function FormatDate(inputDate) {
            //var Month = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"];
            const Month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
            var inDate = new Date(inputDate.trim());//"2020-07-10T00:00:00";//new Date(inputDate); 2020-06-26T00:00:00 
            //var today = inputDate;//"2020-07-10T00:00:00";//new Date(inputDate); 2020-06-26T00:00:00 
            var dd = inDate.getDate();

            // var mm = inDate.getMonth() + 1;
            var mm = inDate.getMonth();
            var yyyy = inDate.getFullYear();
            if (dd < 10) {
                dd = '0' + dd;
            }

            if (mm < 10) {
                mm = '0' + mm;
            }
            //monthNames[mm]
            formatedDate = dd + ' ' + Month[parseInt(mm)] + ' ' + yyyy;
            return formatedDate;

        }

        function NewFormatForCompare(inputDate) {
            var inDate = new Date(inputDate.trim());//"2020-07-10T00:00:00";//new Date(inputDate); 2020-06-26T00:00:00 
            //var today = inputDate;//"2020-07-10T00:00:00";//new Date(inputDate); 2020-06-26T00:00:00 
            var dd = inDate.getDate();

            // var mm = inDate.getMonth() + 1;
            var mm = inDate.getMonth();
            var yyyy = inDate.getFullYear();
            if (dd < 10) {
                dd = '0' + dd;
            }

            if (mm < 10) {
                mm = '0' + mm;
            }
            //monthNames[mm]
            formatedDate = dd + '/' + mm + '/' + yyyy;
            return formatedDate;
        }

        function validateRequestPlanRow(rowObject) {

            var FTE = rowObject.find('.cltxtFTE').val();
          
            var ResourceInDate = rowObject.find('.ClORResourceInDate').val();
            var ResourceOutDate = rowObject.find('.ClORResourceOutDate').val();
            //var SpecialRequest = rowObject.find('#txtaSpecialRequest').val();
            var SkillValue = rowObject.find('#cboResourceSkill').val();
            var RoleValue = rowObject.find('#cboResourceRole').val();
            var currentDate = new Date();
            //var dateStrA = ResourceOutDate.replace( /(\d{2})\/(\d{2})\/(\d{4})/, "$2/$1/$3");
            // var dateStrB = ResourceInDate.replace( /(\d{2})\/(\d{2})\/(\d{4})/, "$2/$1/$3");
            var ResourceOutDateCheck = new Date(ResourceOutDate);// NewFormatForCompare(ResourceOutDate); ///new Date(ResourceOutDate);
            var ResourceInDateCheck = new Date(ResourceInDate);// NewFormatForCompare(ResourceInDate); //new Date(ResourceInDate);
            var ApproxStartDateFormated = $('#txtStartApproxDate').val().trim();
            var ApproxStartDate = new Date(ApproxStartDateFormated);
            var ValidTillFormated = $('#txtValidTillDate').val().trim();
            var ValidTill = new Date(ValidTillFormated);
            var ValidTill = new Date(ValidTillFormated);
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
            var SpecialRew = $("#txtaSpecialRequest").val();
            if (RoleValue == 'undefined' || RoleValue == "" || RoleValue == null) {
                rowObject.find('#cboResourceRole').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Role' should not left blank.");
                return false;
            }
            else if (SkillValue == 'undefined' || SkillValue == "" || SkillValue == null) {
                rowObject.find('#cboResourceSkill').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Primary skill' should not left blank.");
                return false;
            }
            else if (FTE == undefined || FTE == "") {
                rowObject.find('.cltxtFTE').focus();
                validateflag = false;
                //  alert("Please enter Prospect Customer");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Total FTE' should not left blank.");
                return false;
            }
            else if (FTE != null && FTE.match(/^(-?\d*)((\.(\d{0,2})?)?)$/i) == null) {
                rowObject.find('.cltxtFTE').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter numbers only in the field Total FTE");
                return false;
            }
            //Added By Reshma Chavan on 15th Dec 2021 To add Validation For Resource Demand Value

            //Added & Commentd By Dipali V On 17th Jan 2022 For Validate Resource Demand Value 
           // else if (FTE != null && FTE > $("#txtResourceDemand").val()) {               
            else if (FTE != null && parseInt(FTE) > parseInt($("#txtResourceDemand").val())) { 
          //End of Added & Commentd By Dipali V On 17th Jan 2022 For Validate Resource Demand Value 
                    rowObject.find('.cltxtFTE').focus();
                     validateflag = false;
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("'Total FTE' should not be greater than Resource Demand Value.");
                    return false;
                
            }
            //End of Added By Reshma Chavan on 15th Dec 2021 To add Validation For Resource Demand Value
            else if (ResourceInDateCheck == undefined || ResourceInDateCheck == "" || ResourceInDateCheck == "Invalid Date") {
                rowObject.find('.ClORResourceInDate').focus();
                validateflag = false;
                //  alert("Please enter Prospect Customer");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Resource In Date' should not left blank.");
                return false;
            }
            //else if (ResourceInDateCheck == undefined || ResourceInDateCheck == "" || ResourceInDateCheck == "Invalid Date") {
            //    validateflag = false;
            //    //  alert("Please enter Prospect Customer");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("Please enter Resource In date");
            //    return false;
            //}
            else if (ResourceOutDateCheck == undefined || ResourceOutDateCheck == "" || ResourceOutDateCheck == "Invalid Date") {
                rowObject.find('.ClORResourceOutDate').focus();
                validateflag = false;
                //  alert("Please enter Prospect Customer");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Resource Out Date' should not left blank.");
                return false;
            }
            else if (ResourceOutDateCheck < currentDate) {
                rowObject.find('.ClORResourceOutDate').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Resource Out Date' must be greater than current date");
                return false;
            }
            //Issue 286
            else if (ApproxStartDate > ResourceOutDateCheck) {
                rowObject.find('.ClORResourceOutDate').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Resource Out Date' should not be greater than Resource Demand 'Approximate End Date' (" + ApproxStartDateFormated + ")");
                return false;
            }

            else if (ResourceInDateCheck > ResourceOutDateCheck) {
                rowObject.find('.ClORResourceInDate').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Resource In date' must be less than 'Resource Out Date'");
                return false;
            }
            else if (ApproxStartDate > ResourceInDateCheck) {
                rowObject.find('.ClORResourceInDate').focus();
                validateflag = false;
                //  alert("Please enter Prospect Customer");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Resource In Date' should not be less than Resource Demand 'Approximate Start Date' (" + ApproxStartDateFormated + ")");
                // alertify.error("Resorce in date must be greater than approx Start Date(" + ApproxStartDateFormated + ")");
                return false;
            }
            else if (ResourceOutDateCheck > ValidTill) {
                rowObject.find('.ClORResourceOutDate').focus();
                validateflag = false;
                //  alert("Please enter Prospect Customer");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("'Resource Out Date' must be less than 'Valid Till Date'(" + ValidTillFormated + ")");
                return false;
            }
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
            else if (checkSpecialCharacter(SpecialRew, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Special Request should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtProspectxtaSpecialRequesttCustomer").focus();
                return false;
            }
            //End of comment By Rehan C To add Validator for Special characters on 09th Nov 2022
            else {

                validateflag = true;
                return true;
            }
        }
        function SetFTEDecimal(event) {
            this.value = parseFloat(this.value).toFixed(2);
        }
        function GetOpportunityRequest(OpportunityID) {
            var status = '';
            var strHTML = "";
            //alert(revisionStatus);
            $("#tblORResourcePlans").html(strHTML);
            var OpportunityParsms = { OpportunityID: OpportunityID };
            StartLoader("#bodyOpportunityResource-group");
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/GetORResourcePlans',
                type: "POST",
                data: JSON.stringify(OpportunityParsms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (OpportunityParsms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OpportunityParsms) ? OpportunityParsms : JSON.stringify(OpportunityParsms)));
                    }
                },
                success: function (data) {
                    var OpportunityReqests = data;
                    ResoucePlanList = data;
                    $.each(OpportunityReqests, function (index, obj) {
                        if (obj.Status != null) {
                            status = obj.Status.trim();
                        }
                        else {
                            status = "NA";
                        }
                        if (blnDeleteAccess == "True" && revisionStatus == "RE" && status == "NA") {
                            //console.log("NR");
                            //var UploadDate = obj.TentativeStartDate.indexOf('Z') > -1 ? new Date(obj.TentativeStartDate) : new Date(obj.TentativeStartDate + 'Z');
                            strHTML += '<tr ><td class="text-center"><input type="hidden" name="hdnOR_PipelineID" id="hdnOR_PipelineID" class="clhdnOR_PipelineID" value= ' + obj.PipelineID + '> <input type="hidden" name="hdnOR_RoleID" id="hdnOR_RoleID" class="clhdnOR_RoleID" value= ' + obj.RoleID + '> <input type="hidden" name="hdnOR_SkillID" id="hdnOR_SkillID" class="clhdnOR_SkillID" value= ' + obj.ToolID + '> <input type="hidden" name="hdnOR_SpecialRequest" id="hdnOR_SpecialRequest" class="clhdnOR_SpecialRequest" value= ' + obj.Description + '>  <input type="hidden" name="hdnOR_FTEValue" id="hdnOR_FTEValue" class="clhdnOR_FTEValue" value= ' + obj.TotalFTE + '>' + obj.RoleDescription + ' </td > <td class="text-center">' + obj.Skill + ' </td> <td class="text-center">' + obj.TotalFTE + ' </td> <td class="text-center">' + FormatDate(obj.TentativeStartDate) + ' </td> <td class="text-center">' + FormatDate(obj.TentativeEndDate) + ' </td> <td class="text-center">' + obj.Description + ' </td> <td class="text-center"><a href="javascript:;" class="BGdetalilink" onclick="GetORResourcePlanDistribution(this)"</a>' + obj.Distribution + ' </td> <td class="text-center"><a href="javascript:;" class="ORResourcePlandetalilink" onclick="GetORResPlanSoftBook(this)"</a>Soft booking</td>'
                            strHTML += '<td class="actioncolumn"><a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip" data-container="body"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>'
                            strHTML += '<a class="nostylebtn editOpprtunityReq edit" href = "javascript:;" title = "" data-bs-toggle="tooltip" data-placement="top" data - container="body" data -original-title="Edit" > <i class="fas fa-pencil-alt" style="font-size:16px;color: #464a4c"></i></a>'
                            //strHTML += '<a class="nostylebtn editOpprtunityReq edit" href = "javascript:;" title = "" data - toggle="tooltip" data - placement="top" data - container="body" data - original - title="Edit" onclick = "editOpprtunityReq()" > <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px"></a>'
                            strHTML += '<a class="nostylebtn delete" style="display: inline;"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body"></i></a>'
                            strHTML += '<a class="nostylebtn cancelrowvalue" style="display: none;"><i class="fas fa-times" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-bs-original-title="Cancel"></i></a>'
                            strHTML += '</td > </tr > ';
                            //strHTML += '<td><a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a></td ></tr>';
                            ///$(".clsBusinessGroups").append(row);
                        }
                        else if (blnDeleteAccess == "True" && revisionStatus == "RE" && status == "A") {
                            strHTML += '<tr ><td class="text-center"><input type="hidden" name="hdnOR_PipelineID" id="hdnOR_PipelineID" class="clhdnOR_PipelineID" value= ' + obj.PipelineID + '> <input type="hidden" name="hdnOR_RoleID" id="hdnOR_RoleID" class="clhdnOR_RoleID" value= ' + obj.RoleID + '> <input type="hidden" name="hdnOR_SkillID" id="hdnOR_SkillID" class="clhdnOR_SkillID" value= ' + obj.ToolID + '> <input type="hidden" name="hdnOR_SpecialRequest" id="hdnOR_SpecialRequest" class="clhdnOR_SpecialRequest" value= ' + obj.Description + '>  <input type="hidden" name="hdnOR_FTEValue" id="hdnOR_FTEValue" class="clhdnOR_FTEValue" value= ' + obj.TotalFTE + '>' + obj.RoleDescription + ' </td > <td class="text-center">' + obj.Skill + ' </td> <td class="text-center">' + obj.TotalFTE + ' </td> <td class="text-center">' + FormatDate(obj.TentativeStartDate) + ' </td> <td class="text-center">' + FormatDate(obj.TentativeEndDate) + ' </td> <td class="text-center">' + obj.Description + ' </td> <td class="text-center"><a href="javascript:;" class="BGdetalilink" style="pointer-events: none;color: #d4cccc;" onclick="GetORResourcePlanDistribution(this)"</a>' + obj.Distribution + ' </td> <td class="text-center"><a href="javascript:;" style="pointer-events: none;color: #d4cccc;" class="ORResourcePlandetalilink" onclick="GetORResPlanSoftBook(this)"</a>Soft booking</td>'
                            strHTML += '<td class="actioncolumn"><a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip" data-container="body"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>'
                            strHTML += '<a class="nostylebtn editOpprtunityReq edit" style="pointer-events: none;color: #d4cccc;" href = "javascript:;" title = "" data-bs-toggle="tooltip" data-placement="top" data - container="body" data -original-title="Edit" ><i class="fas fa-pencil-alt" style="font-size:16px;"></i> </a>'
                            //strHTML += '<a class="nostylebtn editOpprtunityReq edit" href = "javascript:;" title = "" data - toggle="tooltip" data - placement="top" data - container="body" data - original - title="Edit" onclick = "editOpprtunityReq()" > <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px"></a>'
                            strHTML += '<a class="nostylebtn delete" style="display: inline;pointer-events: none;color: #d4cccc;"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body"></i></a>'
                            strHTML += '<a class="nostylebtn cancelrowvalue" style="display: none;"><i class="fas fa-times" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-bs-original-title="Cancel"></i></a>'
                            strHTML += '</td > </tr > ';
                        }
                        else if (blnDeleteAccess == "True" && revisionStatus == "R" && status == "A") {
                            strHTML += '<tr ><td class="text-center"><input type="hidden" name="hdnOR_PipelineID" id="hdnOR_PipelineID" class="clhdnOR_PipelineID" value= ' + obj.PipelineID + '> <input type="hidden" name="hdnOR_RoleID" id="hdnOR_RoleID" class="clhdnOR_RoleID" value= ' + obj.RoleID + '> <input type="hidden" name="hdnOR_SkillID" id="hdnOR_SkillID" class="clhdnOR_SkillID" value= ' + obj.ToolID + '> <input type="hidden" name="hdnOR_SpecialRequest" id="hdnOR_SpecialRequest" class="clhdnOR_SpecialRequest" value= ' + obj.Description + '>  <input type="hidden" name="hdnOR_FTEValue" id="hdnOR_FTEValue" class="clhdnOR_FTEValue" value= ' + obj.TotalFTE + '>' + obj.RoleDescription + ' </td > <td class="text-center">' + obj.Skill + ' </td> <td class="text-center">' + obj.TotalFTE + ' </td> <td class="text-center">' + FormatDate(obj.TentativeStartDate) + ' </td> <td class="text-center">' + FormatDate(obj.TentativeEndDate) + ' </td> <td class="text-center">' + obj.Description + ' </td> <td class="text-center"><a href="javascript:;" class="BGdetalilink" style="pointer-events: none;color: #d4cccc;" onclick="GetORResourcePlanDistribution(this)"</a>' + obj.Distribution + ' </td> <td class="text-center"><a href="javascript:;" style="pointer-events: none;color: #d4cccc;" class="ORResourcePlandetalilink" onclick="GetORResPlanSoftBook(this)"</a>Soft booking</td>'
                            strHTML += '<td class="actioncolumn"><a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip" data-container="body"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>'
                            strHTML += '<a class="nostylebtn editOpprtunityReq edit" style="pointer-events: none;color: #d4cccc;" href = "javascript:;" title = "" data-bs-toggle="tooltip" data-placement="top" data - container="body" data -original-title="Edit" ><i class="fas fa-pencil-alt" style="font-size:16px;"></i> </a>'
                            //strHTML += '<a class="nostylebtn editOpprtunityReq edit" href = "javascript:;" title = "" data - toggle="tooltip" data - placement="top" data - container="body" data - original - title="Edit" onclick = "editOpprtunityReq()" > <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px"></a>'
                            strHTML += '<a class="nostylebtn delete" style="display: inline;pointer-events: none;color: #d4cccc;"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body"></i></a>'
                            strHTML += '<a class="nostylebtn cancelrowvalue" style="display: none;"><i class="fas fa-times" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-bs-original-title="Cancel"></i></a>'
                            strHTML += '</td > </tr > ';
                        }
                        else if (blnDeleteAccess == "False") {
                            //var UploadDate = obj.TentativeStartDate.indexOf('Z') > -1 ? new Date(obj.TentativeStartDate) : new Date(obj.TentativeStartDate + 'Z');
                            strHTML += '<tr ><td class="text-center"><input type="hidden" name="hdnOR_PipelineID" id="hdnOR_PipelineID" class="clhdnOR_PipelineID" value= ' + obj.PipelineID + '> <input type="hidden" name="hdnOR_RoleID" id="hdnOR_RoleID" class="clhdnOR_RoleID" value= ' + obj.RoleID + '> <input type="hidden" name="hdnOR_SkillID" id="hdnOR_SkillID" class="clhdnOR_SkillID" value= ' + obj.ToolID + '> <input type="hidden" name="hdnOR_SpecialRequest" id="hdnOR_SpecialRequest" class="clhdnOR_SpecialRequest" value= ' + obj.Description + '>  <input type="hidden" name="hdnOR_FTEValue" id="hdnOR_FTEValue" class="clhdnOR_FTEValue" value= ' + obj.TotalFTE + '>' + obj.RoleDescription + ' </td > <td class="text-center">' + obj.Skill + ' </td> <td class="text-center">' + obj.TotalFTE + ' </td> <td class="text-center">' + FormatDate(obj.TentativeStartDate) + ' </td> <td class="text-center">' + FormatDate(obj.TentativeEndDate) + ' </td> <td class="text-center">' + obj.Description + ' </td> <td class="text-center"><a href="javascript:;" class="BGdetalilink" onclick="GetORResourcePlanDistribution(this)"</a>' + obj.Distribution + ' </td> <td class="text-center"><a href="javascript:;" class="ORResourcePlandetalilink" onclick="GetORResPlanSoftBook(this)"</a>Soft booking</td>'
                            strHTML += '<td class="actioncolumn"><a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip" data-container="body"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>'
                            strHTML += '<a class="nostylebtn editOpprtunityReq edit" href = "javascript:;" title = "" data-bs-toggle="tooltip" data-placement="top" data - container="body" data -original-title="Edit" > <i class="fas fa-pencil-alt" style="font-size:16px;color: #464a4c"></i></a>'
                            //strHTML += '<a class="nostylebtn editOpprtunityReq edit" href = "javascript:;" title = "" data - toggle="tooltip" data - placement="top" data - container="body" data - original - title="Edit" onclick = "editOpprtunityReq()" > <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px"></a>'
                            //strHTML += '<a class="nostylebtn delete" style="display: inline;pointer-events: none;color: #d4cccc;"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body"></i></a>'
                            strHTML += '<a class="nostylebtn cancelrowvalue" style="display: none;"><i class="fas fa-times" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-bs-original-title="Cancel"></i></a>'
                            strHTML += '</td > </tr > ';
                            //strHTML += '<td><a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a></td ></tr>';
                            ///$(".clsBusinessGroups").append(row);
                        }
                        else {
                            //var UploadDate = obj.TentativeStartDate.indexOf('Z') > -1 ? new Date(obj.TentativeStartDate) : new Date(obj.TentativeStartDate + 'Z');
                            strHTML += '<tr ><td class="text-center"><input type="hidden" name="hdnOR_PipelineID" id="hdnOR_PipelineID" class="clhdnOR_PipelineID" value= ' + obj.PipelineID + '> <input type="hidden" name="hdnOR_RoleID" id="hdnOR_RoleID" class="clhdnOR_RoleID" value= ' + obj.RoleID + '> <input type="hidden" name="hdnOR_SkillID" id="hdnOR_SkillID" class="clhdnOR_SkillID" value= ' + obj.ToolID + '> <input type="hidden" name="hdnOR_SpecialRequest" id="hdnOR_SpecialRequest" class="clhdnOR_SpecialRequest" value= ' + obj.Description + '>  <input type="hidden" name="hdnOR_FTEValue" id="hdnOR_FTEValue" class="clhdnOR_FTEValue" value= ' + obj.TotalFTE + '>' + obj.RoleDescription + ' </td > <td class="text-center">' + obj.Skill + ' </td> <td class="text-center">' + obj.TotalFTE + ' </td> <td class="text-center">' + FormatDate(obj.TentativeStartDate) + ' </td> <td class="text-center">' + FormatDate(obj.TentativeEndDate) + ' </td> <td class="text-center">' + obj.Description + ' </td> <td class="text-center"><a href="javascript:;" class="BGdetalilink" onclick="GetORResourcePlanDistribution(this)"</a>' + obj.Distribution + ' </td> <td class="text-center"><a href="javascript:;" class="ORResourcePlandetalilink" onclick="GetORResPlanSoftBook(this)"</a>Soft booking</td>'
                            strHTML += '<td class="actioncolumn"><a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip" data-container="body"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>'
                            strHTML += '<a class="nostylebtn editOpprtunityReq edit" href = "javascript:;" title = "" data-bs-toggle="tooltip" data-placement="top" data - container="body" data -original-title="Edit" > <i class="fas fa-pencil-alt" style="font-size:16px;color: #464a4c"></i></a>'
                            //strHTML += '<a class="nostylebtn editOpprtunityReq edit" href = "javascript:;" title = "" data - toggle="tooltip" data - placement="top" data - container="body" data - original - title="Edit" onclick = "editOpprtunityReq()" > <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px"></a>'
                            strHTML += '<a class="nostylebtn delete" style="display: inline;"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body"></i></a>'
                            strHTML += '<a class="nostylebtn cancelrowvalue" style="display: none;"><i class="fas fa-times" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-bs-original-title="Cancel"></i></a>'
                            strHTML += '</td > </tr > ';
                            //strHTML += '<td><a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a></td ></tr>';
                            ///$(".clsBusinessGroups").append(row);
                        }


                    });
                    //$('#BGtblmain#BGtblmain').dataTable().fnDestroy();
                    $("#tblORResourcePlans").html(strHTML);
                    //LoadPagination('#BGtblmain', data);
                    StopAjaxLoader("#bodyOpportunityResource-group");
                    ///loadDataTable();

                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyOpportunityResource-group");
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
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })
        }

        function SaveOResourcePlan(OrResourcePlanObject) {
            //Added By RehanC for parameter mismatch issue on 23rd Mar 2023    
            var orResourcePlanObject = {
                OpportunityID: OrResourcePlanObject.OpportunityID,
                TentativeStartDate: OrResourcePlanObject.TentativeStartDate,
                TentativeEndDate: OrResourcePlanObject.TentativeEndDate,
                PipelineID: OrResourcePlanObject.PipelineID,                
                ToolID: OrResourcePlanObject.ToolID,
                RoleID: OrResourcePlanObject.RoleID,
                TotalFTE: OrResourcePlanObject.TotalFTE,                
                //CreatedBy: OrResourcePlanObject.UserName,
                Description: OrResourcePlanObject.Description
            }
            //End of Comment By RehanC on 23rd Mar 2023
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/SaveORResourcePlan',
                type: "POST",
                data: JSON.stringify(orResourcePlanObject),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    //StartLoader("#bodyOpportunityResource-group");
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (orResourcePlanObject) {
                        xhr.setRequestHeader("Params", encryptString(isJson(orResourcePlanObject) ? orResourcePlanObject : JSON.stringify(orResourcePlanObject)));
                    }
                },
                success: function (data) {
                    var OpportunityReqests = data;
                    //if (OpportunityReqests=="StartDate") {
                    //    alert('Resource start date must be less than Resource out date');
                    //}
                    //else {
                    //Commented and Added By RehanC for Parameter mismatch issue on 23rd Mar 2023
                    //GetOpportunityRequest(OrResourcePlanObject.OpportunityID);
                    GetOpportunityRequest(orResourcePlanObject.OpportunityID);
                    //editOpprtunityReq(OrResourcePlanObject.OpportunityID, SessionEmployeeId, 1)
                    editOpprtunityReq(orResourcePlanObject.OpportunityID, SessionEmployeeId, 1);
                    //End of Comment By RehanC on 23rd Mar 2023
                    //}

                    //StopAjaxLoader("#bodyOpportunityResource-group");

                },
                //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    StopAjaxLoader("#bodyOpportunityResource-group");

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
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })
            // var tooltip = document.getElementsByClassName("tooltip fade top in");
            // tooltip.classList.remove("tooltip fade top in");
        }
        function DeleteOrResourcePaln(DeleteConfirm) {
            if (DeleteConfirm == 1) {
                var PipelineIdToDelete = $('#hdnORPipelineIDToDelete').val();
                if (PipelineIdToDelete > 0) {
                    DeleteORResourcePlan(PipelineIdToDelete);
                    $('#DeleteOrResourcePlanMModal').modal('hide');
                }

            }
        }

        ///Get dist plan
        function GetORResourcePlanDistribution(currentobject) {

            var PipelineID = GetPipeLineIdForDistAndSoftBook(currentobject);
            GetORResourcePlansDistribution(PipelineID);
            $("#btnORDistributionSave").removeClass("DisableContent");
            $('#ORDistributionFreqModal').modal('show');
        }


        function GetORResPlanSoftBook(currentobject) {
            var PipelineID = GetPipeLineIdForDistAndSoftBook(currentobject);
            var OppID = $('#hdnOROpportunityId').val();
            var $row = $(currentobject).closest("tr");
            var CurrentroleID = $row.find("#hdnOR_RoleID").val();
            //Added By RehanC for edit SoftBooking Crash on 28th Mar 2023
            if (CurrentroleID == undefined) {
                var $row = $(currentobject).closest("tr");
                CurrentroleID = $row.find("#hdnOR_RoleIDEdit").val();
            }
            //End Of Comment By RehanC for edit SoftBooking Crash on 28th Mar 2023
            $('#hdnORFTESoftbooking').val($row.find('#hdnOR_FTEValue').val());
            $('#hdnORPipelineIDSoftbooking').val(PipelineID);
            GetORResPlanSoftBookings(PipelineID, 'RoleId=' + CurrentroleID);
            $('#cboORSBFilterRoleId').val(CurrentroleID);
            clearSoftbookFilterOnOpenPopup();
            $('#ResrsSoftBookingModal').modal('show');
            //Commented and Added By RehanC for edit filter Issue on 28th Mar 2023
            //FilterAppliedSB();
            ApplySofbookingFilter();
            //End Of Comment By RehanC for edit filter Issue on 28th Mar 2023
            $('#btnORShowselectedResource').html("Show Selected Resource");

        }

        //Get hdnOR_PipelineID
        function GetPipeLineIdForDistAndSoftBook(currentobject) {

            var $row = $(currentobject).closest("tr");
            var PipelineID = $row.find("#hdnOR_PipelineID").val();
            if (PipelineID === undefined) {
                var $row = $(currentobject).closest("tr");
                PipelineID = $row.find("#hdnOR_PipelineIDEdit").val();
            }
            return PipelineID;
        }



        function DeleteORResourcePlan(PipelineIdToDelete) {

            var OppID = $('#hdnOROpportunityId').val();
            var OrDeleteParsms = { PipelineID: PipelineIdToDelete };
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/DeleteORResourcePlan',
                type: "POST",
                data: JSON.stringify(OrDeleteParsms),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    //StartLoader("#bodyBusiness-group");
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (OrDeleteParsms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OrDeleteParsms) ? OrDeleteParsms : JSON.stringify(OrDeleteParsms)));
                    }
                },
                success: function (data) {
                    if (data != "") {
                        if (data.includes("deleted successfully")) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                        }
                        $('#DeleteOrResourcePlanMModal').modal('hide');
                        $('#hdnORPipelineIDToDelete').val(0);
                        GetOpportunityRequest(OppID);
                        editOpprtunityReq(OppID, SessionEmployeeId, 1);
                    }

                    StopAjaxLoader("#bodyOpportunityResource-group");
                    $('#DeleteOrResourcePlanMModal').modal('hide');
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    }
                    else if (xhr.statusText == "OK") {  //200
                        $('#DeleteOrResourcePlanMModal').modal('hide');
                        //alertify.set('notifier', 'position', 'top-right');
                        // alertify.notify("Deleted");
                    }

                    StopAjaxLoader("#bodyOpportunityResource-group");
                    $('#DeleteOrResourcePlanMModal').modal('hide');
                }
            })
        }

        ///Function : api call
        function GetORResourcePlansDistribution(PipelineID) {
            var strHTML = "";
            $("#tblORDistributionFrequency").html('');
            var ORDistributionParsms = { PipelineID: PipelineID };
            StartLoader("#bodyOpportunityResource-group");
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/GetORResourcePlansDistribution',
                type: "POST",
                data: JSON.stringify(ORDistributionParsms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (ORDistributionParsms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ORDistributionParsms) ? ORDistributionParsms : JSON.stringify(ORDistributionParsms)));
                    }
                },
                success: function (data) {
                    var ORDistrubutionList = data.DistributionLst;

                    if (data != null && ORDistrubutionList != null && ORDistrubutionList.length > 0) {
                        $.each(ORDistrubutionList, function (index, obj) {

                            strHTML += '<tr><td class="text-center"><input type="hidden" name="hdnOR_DistributionID" id="hdnOR_DistributionID" class=".clhdnOR_DistributionID" value= ' + obj.DistributionID + '> <input type="hidden" name="hdnOR_DistributionOprID" id="hdnOR_DistributionOprID" class=".clhdnOR_DistributionOprID" value= ' + obj.OpportunityID + '>' + obj.Year + '</td>'
                            if (obj.Jan >= 0 && obj.Jan != null) {

                               <%-- strHTML += '<td class="text-center"> <%CommonFunctions.HTMLControls.DrawTextBox("txJan", "txJan", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %></td>'--%>
                                //Commnted And Added By Reshma Chavan on 6th Dec 2021 change onkeyup function to Onchange for getting validation of FTE
                                //strHTML += '<td class="text-center"><input id="txtJan" class="OrDisrtibutionTxt" onKeyUp="FTEValidation(this);" maxlength=6  type="number" min="0.25" value=' + obj.Jan + '>'
                                strHTML += '<td class="text-center"><input id="txtJan" class="OrDisrtibutionTxt" onchange="FTEValidation(this);" maxlength=6  type="number" min="0.25" value=' + obj.Jan + '>'
                            } else {
                                strHTML += '</td> :<td class="text-center" ></td>'
                            }
                            if (obj.Feb >= 0 && obj.Feb != null) {
                                strHTML += '<td class="text-center"><input  id="txtFeb" class="OrDisrtibutionTxt" onchange="FTEValidation(this);" maxlength=6  type="number" min="0.25" value=' + obj.Feb + '>'
                            } else {
                                strHTML += '<td class="text-center" ></td>'
                            }
                            if (obj.Mar >= 0 && obj.Mar != null) {
                                strHTML += '<td class="text-center"><input id="txtMar" class="OrDisrtibutionTxt" onchange="FTEValidation(this);" maxlength=6  type="number" min="0.25" value=' + obj.Mar + '>'
                            } else {
                                strHTML += '<td class="text-center" > </td>'
                            }
                            if (obj.Apr >= 0 && obj.Apr != null) {
                                strHTML += '<td class="text-center"><input id="txtApr" class="OrDisrtibutionTxt" onchange="FTEValidation(this);" maxlength=6  type="number" min="0.25" value=' + obj.Apr + '>'

                            } else {
                                strHTML += ' <td class="text-center"> </td>'
                            }
                            if (obj.May >= 0 && obj.May != null) {
                                strHTML += '<td class="text-center"><input id="txtMay" class="OrDisrtibutionTxt" onchange="FTEValidation(this);"  maxlength=6  type="number" min="0.25" value=' + obj.May + '>'
                            } else {
                                strHTML += '<td class="text-center"> </td>'
                            }


                            if (obj.Jun >= 0 && obj.Jun != null) {
                                strHTML += '<td class="text-center"><input id="txtJun" class="OrDisrtibutionTxt" onchange="FTEValidation(this);" maxlength=6 type="number" min="0.25" value=' + obj.Jun + '>'
                            } else {
                                strHTML += '<td class="text-center"></td>'
                            }

                            if (obj.Jul >= 0 && obj.Jul != null) {
                                strHTML += '<td class="text-center"><input id="txtJul" class="OrDisrtibutionTxt" onchange="FTEValidation(this);" maxlength=6  type="number" min="0.25" value=' + obj.Jul + '>'
                            } else {
                                strHTML += '<td class="text-center"> </td>'
                            }

                            if (obj.Aug >= 0 && obj.Aug != null) {
                                strHTML += '<td class="text-center"><input id="txtAug" class="OrDisrtibutionTxt" onchange="FTEValidation(this);" maxlength=6 type="number" min="0.25" value=' + obj.Aug + '>'
                            } else {
                                strHTML += '<td class="text-center"></td>'
                            }

                            if (obj.Sep >= 0 && obj.Sep != null) {
                                strHTML += '<td class="text-center"><input id="txtSep" class="OrDisrtibutionTxt" onchange="FTEValidation(this);" maxlength=6  type="number"  min="0.25" value=' + obj.Sep + '>'
                            } else {
                                strHTML += '<td class="text-center"></td>'
                            }

                            if (obj.Oct >= 0 && obj.Oct != null) {
                                strHTML += '<td class="text-center"><input id="txtOct" class="OrDisrtibutionTxt" onchange="FTEValidation(this);" maxlength=6  type="number" min="0.25" value=' + obj.Oct + '>'
                            } else {
                                strHTML += '<td class="text-center"> </td>'
                            }
                            if (obj.Nov >= 0 && obj.Nov != null) {
                                strHTML += '<td class="text-center"><input id="txtNov" class="OrDisrtibutionTxt" onchange="FTEValidation(this);" maxlength=6  type="number"  min="0.25" value=' + obj.Nov + '>'
                            } else {
                                strHTML += '<td class="text-center"> </td>'
                            }
                            if (obj.Dec >= 0 && obj.Dec != null) {
                                strHTML += '<td class="text-center"><input id="txtDec" class="OrDisrtibutionTxt" onchange="FTEValidation(this);" maxlength=6 type="number"  min="0.25" value=' + obj.Dec + '>'
                            } else {
                                strHTML += '<td class="text-center"> </td>'
                            }

                            strHTML += '</tr> ';
                            $('#btnORDistributionSave').prop("disabled", false);
                        });
                    } else {
                        strHTML += '<tr><td class="text-center"colspan="13">' + NoDataFound + ' </td></tr>';
                        $('#btnORDistributionSave').prop("disabled", true);
                    }
                    //$('#BGtblmain#BGtblmain').dataTable().fnDestroy();
                    $("#tblORDistributionFrequency").html(strHTML)
                    if (data != null && data.TotalFTE != null) {
                        $('#lblDistributionFTE').html(data.TotalFTE);
                    }

                    StopAjaxLoader("#bodyOpportunityResource-group");

                },
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyOpportunityResource-group");
                //}
                //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

        }
        var IsvalidFTE = true;
        var inputFTE = '';
        var CurrentFTEValue = '';
        function FTEValidation(currentval) {
            if (currentval != null) {
                CurrentFTEValue = parseInt($('#lblDistributionFTE').html());
                inputFTE = $(currentval).val();
                if (inputFTE !== undefined && inputFTE > CurrentFTEValue) {
                    IsvalidFTE = false;
                    var messageFTE = 'Entered FTE is ' + CurrentFTEValue + ' and on the distribution, you are giving ' + inputFTE + '.';
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(messageFTE);
                    $("#btnORDistributionSave").addClass("DisableContent");
                }
                else {
                    if (inputFTE == null || inputFTE == "" || inputFTE == undefined) {
                        $("#btnORDistributionSave").addClass("DisableContent");
                    }
                    else {
                        $("#btnORDistributionSave").removeClass("DisableContent");
                    }

                }

            }
        }

        //Added By Reshma Chavan on 15th Dec 2021 To add Blank validation
        function validateDistributionFrequency()
        {
          
            var flag = true;
            $('#tblORDistributionFrequency').find('tr').each(function (index, obj) {
                var JanMonthFTE = $(this).find('#txtJan').val();
                var FebMonthFTE = $(this).find('#txtFeb').val();
                var MarMonthFTE = $(this).find('#txtMar').val();
                var AprMonthFTE = $(this).find('#txtApr').val();
                var MayMonthFTE = $(this).find('#txtMay').val();
                var JunMonthFTE = $(this).find('#txtJun').val();
                var JulMonthFTE = $(this).find('#txtJul').val();
                var AugMonthFTE = $(this).find('#txtAug').val();
                var SepMonthFTE = $(this).find('#txtSep').val();
                var OctMonthFTE = $(this).find('#txtOct').val();
                var NovMonthFTE = $(this).find('#txtNov').val();
                var DecMonthFTE = $(this).find('#txtDec').val();

                 if (JanMonthFTE == "") {                                      
                    $(this).find('#txtJan').focus();
                    flag = false;
                }
                 if (FebMonthFTE == "") {                                      
                    $(this).find('#txtFeb').focus();
                    flag = false;
                }
                 if (MarMonthFTE == "") {                   
                    $(this).find('#txtMar').focus();
                    flag = false;
                }
                 if (AprMonthFTE == "") {                   
                    $(this).find('#txtApr').focus();
                    flag = false;
                }
                 if (MayMonthFTE == "") {                   
                    $(this).find('#txtMay').focus();
                    flag = false;
                }
                 if (JunMonthFTE == "") {                   
                    $(this).find('#txtJun').focus();
                    flag = false;
                }
                 if (JulMonthFTE == "") {                   
                    $(this).find('#txtJul').focus();
                    flag = false;
                }
                 if (AugMonthFTE == "") {                   
                    $(this).find('#txtAug').focus();
                    flag = false;
                }
                 if (SepMonthFTE == "") {                   
                    $(this).find('#txtSep').focus();
                    flag = false;
                }
                 if (OctMonthFTE == "") {                   
                    $(this).find('#txtOct').focus();
                    flag = false;
                }
                 if (NovMonthFTE == "") {                   
                    $(this).find('#txtNov').focus();
                    flag = false;
                }
                 if (DecMonthFTE == "") {                   
                    $(this).find('#txtDec').focus();
                    flag = false;
                }
            });
            return flag;
        }
        //End of Added By Reshma Chavan on 15th Dec 2021 To add Blank validation

        function UpdateORResourcPlanDist() {
            if (validateDistributionFrequency() == true) {
                $('#tblORDistributionFrequency').find('tr').each(function (index, obj) {
                    var inputFTE = '';
                    var ORDistributionID = $(this).find('#hdnOR_DistributionID').val();
                    var ORDistributionOprID = $(this).find('#hdnOR_DistributionOprID').val();
                    var JanMonthFTE = $(this).find('#txtJan').val();
                    var FebMonthFTE = $(this).find('#txtFeb').val();
                    var MarMonthFTE = $(this).find('#txtMar').val();
                    var AprMonthFTE = $(this).find('#txtApr').val();
                    var MayMonthFTE = $(this).find('#txtMay').val();
                    var JunMonthFTE = $(this).find('#txtJun').val();
                    var JulMonthFTE = $(this).find('#txtJul').val();
                    var AugMonthFTE = $(this).find('#txtAug').val();
                    var SepMonthFTE = $(this).find('#txtSep').val();
                    var OctMonthFTE = $(this).find('#txtOct').val();
                    var NovMonthFTE = $(this).find('#txtNov').val();
                    var DecMonthFTE = $(this).find('#txtDec').val();
                    var Year = $(this).find('td').eq(0).text();
                    //lblYear
                    var DistrtibutionObject = {
                        //DistributionID: ORDistributionID, Year: Year,
                        DistributionID: ORDistributionID, Year: parseInt(Year), //Added By RehanC for Params Mismatch Crash on 23rd Mar 2023
                        Jan: JanMonthFTE != 'undefined' || JanMonthFTE > 0 ? JanMonthFTE : null,
                        Feb: FebMonthFTE != 'undefined' || FebMonthFTE > 0 ? FebMonthFTE : null,
                        Mar: MarMonthFTE != 'undefined' || MarMonthFTE > 0 ? MarMonthFTE : null,
                        Apr: AprMonthFTE != 'undefined' || AprMonthFTE > 0 ? AprMonthFTE : null,
                        May: MayMonthFTE != 'undefined' || MayMonthFTE > 0 ? MayMonthFTE : null,
                        Jun: JunMonthFTE != 'undefined' || JunMonthFTE > 0 ? JunMonthFTE : null,
                        Jul: JulMonthFTE != 'undefined' || JulMonthFTE > 0 ? JulMonthFTE : null,
                        Aug: AugMonthFTE != 'undefined' || AugMonthFTE > 0 ? AugMonthFTE : null,
                        Sep: SepMonthFTE != 'undefined' || SepMonthFTE > 0 ? SepMonthFTE : null,
                        Oct: OctMonthFTE != 'undefined' || OctMonthFTE > 0 ? OctMonthFTE : null,
                        Nov: NovMonthFTE != 'undefined' || NovMonthFTE > 0 ? NovMonthFTE : null,
                        dec: DecMonthFTE != 'undefined' || DecMonthFTE > 0 ? DecMonthFTE : null,

                    };

                    UpdateORResourcePlanDistribution(DistrtibutionObject);
                    $('#ORDistributionFreqModal').modal('hide');

                });
                //Added By RehanC For not getting alert after Applying filter on 21st Mar 2023
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Distibution has been Saved");
               //End of Comment Added By RehanC For not getting alert after Applying filter on 21st Mar 2023
            }
            //Added By Reshma Chavan on 15th Dec 2021 To add Blank validation
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("FTE Should not be Left Blank");
            }
            //End of Added By Reshma Chavan on 15th Dec 2021 To add Blank validation
          
        }

        function UpdateORResourcePlanDistribution(ORDistrtibutionObject) {
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/UpdateORResourcePlanDistribution',
                type: "POST",
                data: JSON.stringify(ORDistrtibutionObject),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    //StartLoader("#bodyOpportunityResource-group");
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (ORDistrtibutionObject) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ORDistrtibutionObject) ? ORDistrtibutionObject : JSON.stringify(ORDistrtibutionObject)));
                    }
                },
                success: function (data) {
                    var Distrtibution = data;

                    //StopAjaxLoader("#bodyOpportunityResource-group");

                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    StopAjaxLoader("#bodyOpportunityResource-group");

                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyOpportunityResource-group");
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

        }




        function GetORResPlanSoftBookings(PipelineID, whereCaluse) {
            SelectedEmpID = [];
            var strHTML = "";
            var OppID = $('#hdnOROpportunityId').val();
            //$('#softbookingTbl').html('');
            OrFIlterSoftbookingList = [];
            var ORDistributionParsms = { PipelineID: PipelineID, OpportunityID: OppID, WhereClause: whereCaluse }
            StartLoader("#bodyOpportunityResource-group")
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/GetORResourcePlanSoftbookings',
                type: "POST",
                data: JSON.stringify(ORDistributionParsms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (ORDistributionParsms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ORDistributionParsms) ? ORDistributionParsms : JSON.stringify(ORDistributionParsms)));
                    }
                },
                success: function (data) {
                    //var ORSoftBookingsList = data;
                    if (data != null) {
                        OrFIlterSoftbookingList = data.SoftbookingList;//ORSoftBookingsList;
                        //$('#softbookingTbl').dataTable().fnDestroy();

                        if (OrFIlterSoftbookingList.length > 0) {
                            ReloadTableWithSearchValues(OrFIlterSoftbookingList, data.EmpIds);
                            if (softBookingSelectionTable.$('input:checked').length == softBookingSelectionTable.fnGetNodes().length) {
                                $(".chckHeadForSoftBooking").prop("checked", true);
                            } else {
                                $(".chckHeadForSoftBooking").removeAttr("checked");
                            }
                            // LoadPagination(OrFIlterSoftbookingList);
                        } else {
                            ReloadTableWithSearchValues();
                        }
                    }
                    StopAjaxLoader("#bodyOpportunityResource-group");
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    StopAjaxLoader("#bodyOpportunityResource-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyOpportunityResource-group");
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })
        }


        function FillSoftBookingDU() {
            var strHTML = "";
            var BgID = $('#cboORSBFilterBusinessGroupID').val();
            //$("#cboORSBFilterLocationID").append(s);
            // var ORSoftBookingLocationList = ""; 
            if (BgID != "" && BgID > 0) {
                var objDuSftBook = { BusinessGroupID: BgID };
                $.ajax({
                    url: strUrl + '/api/RM_OpportunityRequest/GetBusinessGroupsLocation',
                    type: "POST",
                    data: JSON.stringify(objDuSftBook),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (objDuSftBook) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objDuSftBook) ? objDuSftBook : JSON.stringify(objDuSftBook)));
                        }
                    },
                    success: function (data) {
                        //if (data.length>0) {
                        //Commented By Reshma Chavan on 7th Dec 2021
                        //strHTML += "<option value='0'></option>";
                        for (var i = 0; i < data.length; i++) {
                            var ORSoftBookingLocationList = data[i];
                            strHTML += '<option value=' + ORSoftBookingLocationList.OUPoolID + ' >' + ORSoftBookingLocationList.Location + '</option>';

                        }
                        //} else {
                        //     $("#cboORSBFilterLocationID").();
                        //}
                        $("#cboORSBFilterLocationID").html(strHTML);
                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    //alertify.notify(err);
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
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

                })
            }
            //Added By Reshma Chavan on 7th Dec 2021 For Binding PlaceHolder
            else {
                 $("#cboORSBFilterLocationID").html(strHTML);
                 BindPlaceholder("cboORSBFilterLocationID", "Organization Unit"); 
            }
              //End of Added By Reshma Chavan on 7th Dec 2021 For Binding PlaceHolder


        }

        //Call function
        function SaveORResourcePlanSoftbooking(IsFromSaveAndColse) {
            var FteValue = $('#hdnORFTESoftbooking').val();
            var empIds = SelectedEmpID;//GetSelectedSoftbookingEmp();
            // var SelectedEmpLength = empIds.length > 0 ? empIds.split(",").length : 0;
            if (empIds.length > 0 && empIds.length > FteValue) {
                var message = 'You can select maximum ' + FteValue + ' Resources.';
                //alertify.set('notifier', 'position', 'top-right');
                //alertify.error('You can select maximum '+FteValue+' Resources');
                // alert('You can select maximum ' + FteValue + ' Resources');
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(message);
            }
            else {

                if (empIds.length > 0) {
                    var OppID = $('#hdnOROpportunityId').val();
                    var PipelineID = $("#hdnORPipelineIDSoftbooking").val();
                    var ORSaveRpsoftBooking = { OpportunityID: OppID, PipelineID: PipelineID, EmployeeIDs: (encodeURI(empIds)).toString(), UserName: UserName };
                    SaveORResourcePlanSoftbookings(ORSaveRpsoftBooking);
                    if (IsFromSaveAndColse == 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success('Soft booking has been saved');
                        //alertify.notify('Soft booking has been saved');
                    }
                    //Added by Chetan M on 15 July 2021 for restrict Popup closing 
                    if (IsFromSaveAndColse == 1) {   
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success('Soft booking has been saved');
                         $('#ResrsSoftBookingModal').modal('toggle');
                    }
                    //End of Added by Chetan M on 15 July 2021 for restrict Popup closing 
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Please select resource ');
                }
            }
        }

        //APICall: save soft booking
        function SaveORResourcePlanSoftbookings(ORSaveRpsoftBooking) {
            //Added By RehanC for parameter mismatch issue on 23rd Mar 2023
            var oRSaveRpsoftBooking = {
                OpportunityID: ORSaveRpsoftBooking.OpportunityID,
                PipelineID: ORSaveRpsoftBooking.PipelineID,
                EmployeeIDs: ORSaveRpsoftBooking.EmployeeIDs,
                UserName: ORSaveRpsoftBooking.UserName
            }
            //End of Comment By RehanC on 23rd Mar 2023
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/SaveORResourcePlanSoftbookings',
                type: "POST",
                data: JSON.stringify(oRSaveRpsoftBooking),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    //StartLoader("#bodyOpportunityResource-group");
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (oRSaveRpsoftBooking) {
                        xhr.setRequestHeader("Params", encryptString(isJson(oRSaveRpsoftBooking) ? oRSaveRpsoftBooking : JSON.stringify(oRSaveRpsoftBooking)));
                    }
                },
                success: function (data) {
                    var OpportunityReqests = data;
                    //Commented and Added By RehanC forparameter mismatch issue on 23rd Mar 2023
                    //GetOpportunityRequest(ORSaveRpsoftBooking.OpportunityID);
                    GetOpportunityRequest(oRSaveRpsoftBooking.OpportunityID);
                    //End of Comment By RehanC on 23rd Mar 2023
                    //StopAjaxLoader("#bodyOpportunityResource-group");
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(err);
                //    StopAjaxLoader("#bodyOpportunityResource-group");

                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyOpportunityResource-group");
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })
        }

        ///get checked values
        function GetSelectedSoftbookingEmp() {
            var selectedSoftbookingUniqueId = '';//this is emp id

            $('#tblORSoftBooking').find('tr').each(function () {
                var row = $(this);
                if (row.find('input[type="checkbox"]').is(':checked')) {
                    selectedSoftbookingUniqueId += row.find('#hdnOR_SoftbookingID').val() + ',';
                }
            });
            if (selectedSoftbookingUniqueId.length > 0) {
                selectedSoftbookingUniqueId = selectedSoftbookingUniqueId.substring(0, selectedSoftbookingUniqueId.length - 1);
            }
            return selectedSoftbookingUniqueId;
        }

        //Soft booking filter:IP
        //cboORSBBusinessGroupID
        function GenerateBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                var txtBoxvalue = 0;
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    if (strOp != null && strOp != 'undefined' && strOp != "") {
                        strvalue = strOp
                    } else {
                        strvalue = $("#txt" + module + "Filter" + filterField[i]).val();
                        txtBoxvalue = 1
                    }

                    if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                        if (strqtext != "") strqtext += " AND ";
                        if (strOp != "0" && txtBoxvalue == 0) {

                            strqtext += filterField[i] + "= ";
                            //strqtext += " ''%" + strvalue + "%''";
                            strqtext += ' "' + strvalue + '"';
                        }
                        else if (txtBoxvalue == "1") {

                            strqtext += filterField[i] + " LIKE ";
                            strqtext += ' "%' + strvalue + '%"';

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
                return strqtext;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        function ApplySofbookingFilter() {
            var filterWhereClause;
            var AllSoftbookingFilter = ["RoleId", "BusinessGroupID", "LocationID", "FacilityID", "Primaryskills", "UserName"];
            var filterWhereClause2 = GenerateBasicFilterQuery("ORSB", AllSoftbookingFilter);
            //Added By reshma Chavan on 7th Dec 2021 for IssueID-31719
            if (filterWhereClause2 == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
                FilterNotAppliedSB();
            } else {
                //End of Added By reshma Chavan on 7th Dec 2021 for IssueID-31719
                var PipelineIdForfilter = $('#hdnORPipelineIDSoftbooking').val();
                filterWhereClause = filterWhereClause2.replace(/"/g, "\''");
                FilterAppliedSB();
                GetORResPlanSoftBookings(PipelineIdForfilter, filterWhereClause);
            }

        }
        function softBookDetails(whereClause) {
            var PipelineIdForfilter = $('#hdnORPipelineIDSoftbooking').val();
            GetORResPlanSoftBookings(PipelineIdForfilter, whereClause);
        }
        //for ref
        function mysearchOfSoftbooking() {
            var SearchText = $("#txtORSoftbookingSearch").val();
            var strHTML = "";

            var FilterEmp = OrFIlterSoftbookingList.filter(function (x) { return x.EmployeeName.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 });
            ReloadTableWithSearchValues(FilterEmp);
            //var SoftBookingListSearch = OrFIlterSoftbookingList.filter(e => e.EmployeeName.toLocaleLowerCase().includes(SearchText.toLocaleLowerCase()));

        }


        function ReloadTableWithSearchValues(SoftbookingList, EmpIds, isFromSelected) {
            var strHTML = "";
            $("#tblORSoftBooking").html('');
            if (SoftbookingList != null && SoftbookingList.length > 0) {
                $.each(SoftbookingList, function (index, obj) {
                   //Added by Chetan M on 9 Jul 2021 for wrong experience Issue
                    if (obj.TotalExp.indexOf('year') > -1) {
                        obj.TotalExp = obj.TotalExp;
                    }
                    else {
                        //Commented And Added By reshma Chavan on 13th Dec 2021 For issueID-31788
                        //obj.TotalExp = "o years(s) " + obj.TotalExp;                        
                        obj.TotalExp = "0 years(s) " + obj.TotalExp; 
                        //End of Commented And Added By reshma Chavan on 13th Dec 2021 For issueID-31788
                    }
                    //End of Added by Chetan M on 9 Jul 2021 for wrong experience Issue
                    //var AlllocatedEmp;
                    var AlllocatedEmp = '<div class="custom_chckbox"><input  id="' + index + '" type="checkbox" class="chckHeadSoftbooking"  style="width:18px; height:18px" onclick="PushSBCheckedEmpIDS(this)"><label for="' + index + '"></label></div>';
                    //var AlllocatedEmpChecked = '<input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)" checkd>';
                    if (EmpIds != null && EmpIds.length > 0) {
                        $.each(EmpIds, function (index, objEmp) {
                            if (obj.EmployeeID == objEmp) {
                                SelectedEmpID.push(objEmp);
                                //$('#btnORShowselectedResource').html("Show All Resources"); //Show Selected Resource
                                AlllocatedEmp = '<div class="custom_chckbox"><input id="' + index + '" type="checkbox" class="chckHeadSoftbooking"  style="width:18px; height:18px" onclick="PushSBCheckedEmpIDS(this)" checked><label for="' + index + '"></label></div>';
                            }
                            else {
                                // alert();
                                // AlllocatedEmp = '<input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)">';
                            }

                        })
                    }
                    if (isFromSelected == 1) {
                        strHTML += '<tr><td class="text-center"><input type="hidden" name="hdnOR_SoftbookingID" id="hdnOR_SoftbookingID" class=".clhdnOR_SoftbookingID" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + '</td>'
                        strHTML += '<td class="text-center"> ' + obj.BusinessGroup + ' </td> <td class="text-center"> ' + obj.Location + ' </td>'
                        strHTML += '<td  class="text-center"> ' + obj.RoleDescription + ' </td> <td class="text-center"> ' + obj.Primaryskills + ' </td>'
                        //Commented and added by Chetan M on 9 Jul 2021 for wrong experience Issue
                        //strHTML += '<td  class="text-center"> ' + parseFloat(obj.TotalExp).toFixed(2) + ' </td><td class="text-center"><div class="custom_chckbox"><input id="' + index + '" type="checkbox" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)" checked><label for="' + index + '"></label></div></td>'
                        strHTML += '<td  class="text-center"> ' + obj.TotalExp + ' </td><td class="text-center"><div class="custom_chckbox"><input id="' + index + '" type="checkbox" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)" checked><label for="' + index + '"></label></div></td>'
                        //End of Commented and added by Chetan M on 9 Jul 2021 for wrong experience Issue
                        strHTML += '</tr> ';

                    } else {
                        strHTML += '<tr><td class="text-center"><input type="hidden" name="hdnOR_SoftbookingID" id="hdnOR_SoftbookingID" class=".clhdnOR_SoftbookingID" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + '</td>'
                        strHTML += '<td class="text-center"> ' + obj.BusinessGroup + ' </td> <td  class="text-center"> ' + obj.Location + ' </td>'
                        strHTML += '<td class="text-center"> ' + obj.RoleDescription + ' </td> <td class="text-center"> ' + obj.Primaryskills + ' </td>'
                        //Commented and added by Chetan M on 9 Jul 2021 for wrong experience Issue
                        //strHTML += '<td class="text-center"> ' + parseFloat(obj.TotalExp).toFixed(2) + ' </td> <td class="text-center">' + AlllocatedEmp + '</td>'
                        strHTML += '<td class="text-center"> ' + obj.TotalExp + ' </td> <td class="text-center">' + AlllocatedEmp + '</td>'
                        //End of Commented and added by Chetan M on 9 Jul 2021 for wrong experience Issue
                        strHTML += '</tr> ';
                    }
                });
                $('#softbookingTbl').dataTable().fnDestroy();
                $("#tblORSoftBooking").html(strHTML)
                LoadAddResourcePagination(SoftbookingList);
                $(".chckHeadForSoftBooking").prop("checked", false);
            }
            else {
                strHTML += '<tr><td class="text-center"colspan="7">' + NoDataFound + ' </td></tr>';
                $('#softbookingTbl').dataTable().fnDestroy();
                $("#tblORSoftBooking").html(strHTML);
                $(".chckHeadForSoftBooking").prop("checked", false);
            }
        }
        //for Softbooking

        function LoadAddResourcePagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            softBookingSelectionTable = $('#softbookingTbl').dataTable({
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
        $(".chckHeadForSoftBooking").change(function () {
            var allPages = softBookingSelectionTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#softbookingTbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedEmpID.push(parseInt($(rows[i]).find("#hdnOR_SoftbookingID").val()));
                    }
                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedEmpID = [];
                }
            }
        });
        var SelectedEmpID = [];
        function PushSBCheckedEmpIDS(currentObject) {

            // var $row = $(currentObject).closest("tr");
            // var IsSelectedResource = CheckFTEAndResorceSelection();
            // if (IsSelectedResource == true) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedEmpID.push(parseInt(row.find('#hdnOR_SoftbookingID').val()));
            } else {
                // console.log("ssdsd", SelectedEmpID);
                if (SelectedEmpID != 'undefined' && SelectedEmpID.length > 0) {
                    var removeEmp = row.find('#hdnOR_SoftbookingID').val();
                    SelectedEmpID.remove(parseInt(removeEmp));

                    // SelectedEmpID.remove(removeEmp);
                    // console.log("SelectedEmpID", SelectedEmpID);
                }
            }
            if (softBookingSelectionTable.$('input:checked').length == softBookingSelectionTable.fnGetNodes().length) {
                $(".chckHeadForSoftBooking").prop("checked", true);
            } else {
                $(".chckHeadForSoftBooking").removeAttr("checked");
                $(".chckHeadForSoftBooking").prop("checked", false);
            }
            //}

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
        function CheckFTEAndResorceSelection() {
            // console.log(SelectedEmpID.length);
            // console.log(FteValue);
            var FteValue = $('#hdnORFTESoftbooking').val();
            if (SelectedEmpID.length > FteValue) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('You can select maximum ' + FteValue + ' Resources.');
                return false;
            } else {
                return true;
            }
        }
        Array.prototype.includes = function (match) {
            return this.indexOf(match) !== -1;
        }
        function ShowSelectedSoftBookingResource() {
            var CurrentBtnText = $('#btnORShowselectedResource').html();
            var FteValue = $('#hdnORFTESoftbooking').val();
            var IsSelectionOk = CheckFTEAndResorceSelection();
            // console.log("SelectedEmpID",SelectedEmpID);
            if (IsSelectionOk == true && SelectedEmpID.length > 0 && CurrentBtnText == "Show Selected Resource") {
                //var selectedRoles = vm.roles.filter(function(x) { return x.id === role.id; });
                var SelectedSoftBookingList = OrFIlterSoftbookingList.filter(function (x) { return SelectedEmpID.includes(x.EmployeeID) });
                //var SelectedSoftBookingList = OrFIlterSoftbookingList.filter(({ EmployeeID }) => SelectedEmpID.includes(EmployeeID));
                ReloadTableWithSearchValues(SelectedSoftBookingList, null, 1);
                $('#btnORShowselectedResource').html("Show All Resources");
                //LoadPagination(SelectedSoftBookingList);
                ///SelectedEmpID = [];
            }
            else if (IsSelectionOk == true && CurrentBtnText == "Show All Resources") {
                $('#btnORShowselectedResource').html("Show Selected Resource");
                ///ReloadTableWithSearchValues(OrFIlterSoftbookingList);
                //clearSoftbookFilter();
                // SelectedEmpID = [];commneted by shital
                //ShowSelectedSoftBookingResource
                //GetORResPlanSoftBookings();commneted by shital
                ReloadTableWithCheckedResorces(OrFIlterSoftbookingList, SelectedEmpID)
            }

            else if (IsSelectionOk == true && SelectedEmpID.length == 0 || SelectedEmpID == '') {

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one record');
            }
            if (softBookingSelectionTable.$('input:checked').length == softBookingSelectionTable.fnGetNodes().length) {
                $(".chckHeadForSoftBooking").prop("checked", true);
            } else {
                $(".chckHeadForSoftBooking").removeAttr("checked");
            }
            //var result = OrFIlterSoftbookingList.filter(({ EmployeeID }) => SelectedEmpID.includes(parseInt(EmployeeID)));

        }

        function ReloadTableWithCheckedResorces(SoftbookingList, EmpIds) {
            var strHTML = "";
            if (SoftbookingList != null && SoftbookingList.length > 0) {

                $.each(SoftbookingList, function (index, obj) {
                    //var AlllocatedEmp;
                    var AlllocatedEmp = '<div class="custom_chckbox"><input id="' + index + '" type="checkbox" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)"><label for="' + index + '"></label></div>';
                    //var AlllocatedEmpChecked = '<input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)" checkd>';
                    if (EmpIds != null && EmpIds.length > 0) {
                        $.each(EmpIds, function (index, objEmp) {
                            if (obj.EmployeeID == objEmp) {
                                // SelectedEmpID.push(objEmp);
                                //$('#btnORShowselectedResource').html("Show All Resources"); //Show Selected Resource
                                AlllocatedEmp = '<div class="custom_chckbox"><input id="' + index + '" type="checkbox" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)" checked><label for="' + index + '"></label></div>';
                            }
                            else {
                                // alert();
                                // AlllocatedEmp = '<input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)">';
                            }


                        })
                    }

                    //if (isFromSelected == 1) {
                    //    strHTML += '<tr><td class="text-center"><input type="hidden" name="hdnOR_SoftbookingID" id="hdnOR_SoftbookingID" class=".clhdnOR_SoftbookingID" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + '</td>'
                    //    strHTML += '<td class="text-center"> ' + obj.BusinessGroup + ' </td> <td class="text-center"> ' + obj.Location + ' </td>'
                    //    strHTML += '<td  class="text-center"> ' + obj.RoleDescription + ' </td> <td class="text-center"> ' + obj.Primaryskills + ' </td>'
                    //    strHTML += '<td  class="text-center"> ' + obj.TotalExp + ' </td> <td td class="text-center"><input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)" checked></td>'
                    //    strHTML += '</tr> ';

                    //} else {


                    strHTML += '<tr><td class="text-center"><input type="hidden" name="hdnOR_SoftbookingID" id="hdnOR_SoftbookingID" class=".clhdnOR_SoftbookingID" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + '</td>'
                    strHTML += '<td class="text-center"> ' + obj.BusinessGroup + ' </td> <td  class="text-center"> ' + obj.Location + ' </td>'
                    strHTML += '<td class="text-center"> ' + obj.RoleDescription + ' </td> <td class="text-center"> ' + obj.Primaryskills + ' </td>'
                    strHTML += '<td class="text-center"> ' + obj.TotalExp + ' </td> <td class="text-center">' + AlllocatedEmp + '</td>'
                    strHTML += '</tr> ';

                    // }

                    //}

                });
                $('#softbookingTbl').dataTable().fnDestroy();
                $("#tblORSoftBooking").html(strHTML)
                LoadAddResourcePagination(SoftbookingList);
                $(".chckHeadForSoftBooking").prop("checked", false);
                //} else {
                //    strHTML += '<tr><td class="text-center"colspan="13">' + NoDataFound + ' </td></tr>';
                //LoadPagination("#softbookingTbl", SoftbookingList);
                //$(".chckHeadSoftbooking").prop("checked", false);

            }

        }

        function clearSoftbookFilter() {
            //Commented And Added By Reshma Chavan on 7th Dec 2021
            //$('#cboORSBFilterRoleId').val("");
            $('#cboORSBFilterRoleId').val(0);
            //End of Commented And Added By Reshma Chavan on 7th Dec 2021
            $('#cboORSBFilterBusinessGroupID').val("");
            $('#cboORSBFilterLocationID').val("");          
            $('#cboORSBFilterFacilityID').val("");
            $('#txtORSBFilterPrimaryskills').val("");
            $('#txtORSBFilterUserName').val("");
            //Added By Reshma Chavan on 7th Dec 2021
            BindPlaceholder("cboORSBFilterLocationID", "Organization Unit"); 
        }
        function clearSoftbookFilterOnOpenPopup() {
            ///$('#cboORSBFilterRoleId').val("");
            $('#cboORSBFilterBusinessGroupID').val("");           
            $('#cboORSBFilterLocationID').val("");                        
            $('#cboORSBFilterFacilityID').val("");
            $('#txtORSBFilterPrimaryskills').val("");
            $('#txtORSBFilterUserName').val("");
        }

        var Ischeck = false;
        function SendForRevision() {
            var OppID = $('#hdnOROpportunityId').val();
            var OP_Parameters = { statusChangedBy: SessionEmployeeId, OpportunityID: OppID };
            var strHTML = "";
            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/OP_SendForRevision',
                type: "POST",
                data: JSON.stringify(OP_Parameters),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (OP_Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OP_Parameters) ? OP_Parameters : JSON.stringify(OP_Parameters)));
                    }
                },
                success: function (data) {
                    GetOpportunityRequests();
                    editOpprtunityReq(OppID, SessionEmployeeId, 0);
                    if (data == "Success") {
                        IsRevivision = false;
                        IsSendForApproval = false;
                        Ischeck = true;
                        document.getElementById("ApprovalStatus").innerHTML = "Pending Approval";
                        $("#btnRevision").addClass("clsShowHide");
                        $("#btnSendForApproval").removeClass("clsShowHide");
                    }
                    //LoadPagination('#BGtblmain', data);
                    // StopAjaxLoader("#bodyBusiness-group");


                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

        }

        function SendForApproval() {
            if ($('#txtComment').val().trim() == "" || $('#txtComment').val().trim() == null || $('#txtComment').val().trim() == undefined) {
                $("#txtComment").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter Comment");
            }
            else {
                var OppID = $('#hdnOROpportunityId').val();
                var Comment = $('#txtComment').val().replace(/'/g, "''");
                var OP_Parameters = { statusChangedBy: SessionEmployeeId, OpportunityID: OppID, Comment: Comment, FromStatus: "D", ToStatus: "S" };
                var strHTML = "";
                //if (ApproverList != null && ApproverList.length > 0) {
                //    $('#ResrsSendApprovalModal').modal('show');
                $.ajax({
                    url: strUrl + '/api/RM_OpportunityRequest/SendForApproval',
                    type: "POST",
                    data: JSON.stringify(OP_Parameters),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (OP_Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(OP_Parameters) ? OP_Parameters : JSON.stringify(OP_Parameters)));
                        }
                    },
                    success: function (data) {
                        $('#ResrsSendApprovalModal').modal('hide');
                        document.getElementById("ApprovalStatus").innerHTML = "Sent For Approval";
                        GetOpportunityRequests();
                        if (data != null || data > 0) {
                            IsRevision = true;
                            IsSendForApproval = true;

                            //$("#btnRevision").removeClass("clsShowHide");//OPR issue no 26192
                            $("#btnRevision").addClass("clsShowHide");//OPR issue no 26192
                            $("#btnSendForApproval").addClass("clsShowHide");
                            window.open('../Email/SendEmail.aspx?MessageID=493&OpportunityID=' + OppID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                            $.ajax({
                                url: strUrl + '/api/RM_OpportunityRequest/GetStatusOfOpportunityRequest',
                                type: "POST",
                                data: JSON.stringify(OP_Parameters),
                                contentType: "application/json;charset-utf=8",
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                                    if (OP_Parameters) {
                                        xhr.setRequestHeader("Params", encryptString(isJson(OP_Parameters) ? OP_Parameters : JSON.stringify(OP_Parameters)));
                                    }
                                },
                                success: function (data) {
                                    if (data != null) {
                                        if (data.trim() == "S") {
                                            $('#tblRORplan').addClass("DisableContent");
                                            $("#btnSaveOPR").addClass("clsShowHide");
                                            $("#btnSaveAddOPR").addClass("clsShowHide");
                                        }
                                    }
                                    ///added by mahesh on 13 july 
                                    var IsDemandApprover = $("#hdnOPR_IsDemandApprover").val();
                                    if (IsDemandApprover=="1") {
                                        GetOPRById(OppID,"Admin",IsDemandApprover)
                                    }
                                  
                                },
                                error: function (err) {
                                    //alertify.set('notifier', 'position', 'top-right');
                                    //alertify.notify(err);
                                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                    //StopAjaxLoader("#bodyBusiness-group");
                                }
                            })
                        }
                        //LoadPagination('#BGtblmain', data);
                        // StopAjaxLoader("#bodyBusiness-group");


                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    //alertify.notify(err);
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
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

                })
                //}
                //else {
                //    $('#ResrsSendApprovalModal').modal('hide');
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.error("Can't send as there are no Approvers present in the system.");
                //}
                // StartLoader("#bodyBusiness-group");

            }



        }

        function CheckApproverComment() {
            var OppID = $('#hdnOROpportunityId').val();
            var BgID = $("#cboBG").val();
            var LID = $("#cboOU").val();
            var RID = $("#cboDU").val();
            var GID = $("#cboDT").val();
            $('#txtComment').val("");
            var OP_Parameters = { OpportunityID: OppID, BusinessGroupID: BgID, LocationID: LID, ResourcePoolID: RID, GroupID: GID };
            var strHTML = "";
            // StartLoader("#bodyBusiness-group");
            if (ApproverList != null && ApproverList.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_OpportunityRequest/CheckForComments',
                    type: "POST",
                    data: JSON.stringify(OP_Parameters),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (OP_Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(OP_Parameters) ? OP_Parameters : JSON.stringify(OP_Parameters)));
                        }
                    },
                    success: function (data) {
                        if (data == false) {
                            $('#ResrsSendApprovalModal').modal('show');
                            $("#txtapproverComments").addClass("clsShowHide");
                            $("#lblapproverComments").addClass("clsShowHide");
                        }
                        else if (data == "2") {
                            $('#ResrsSendApprovalModal').modal('hide');
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("Resource plan dates should be between 'Approx.Start Date' and 'Valid Till Date.'");
                        }
                        else if (data == "Selected Business Group is Inactive.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $("#cboBG").focus();
                        }
                        else if (data == "Selected Organization Unit is Inactive.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $("#cboOU").focus();
                        }
                        else if (data == "Selected Delivery Unit is Inactive.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $("#cboDU").focus();
                        }
                        else if (data == "Selected Delivery Team is Inactive.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $("#cboDT").focus();
                        }
                        else {
                            $('#ResrsSendApprovalModal').modal('show');
                            $("#txtapproverComments").removeClass("clsShowHide");
                            $("#lblapproverComments").removeClass("clsShowHide");
                            $('#txtapproverComments').attr("disabled", true);

                            $('#txtapproverComments').val(data);
                        }
                        //LoadPagination('#BGtblmain', data);
                        // StopAjaxLoader("#bodyBusiness-group");
                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    //alertify.notify(err);
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
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

                })
            } else {
                $('#ResrsSendApprovalModal').modal('hide');
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Can't send as there are no Approvers present in the system.");
            }

        }
        var toStatus;
        function CheckSenderComment(statusflag) {
            $('#txtapproverejectComment').val("");
            if (statusflag == 0) {
                toStatus = "A";
            }
            else {
                toStatus = "R";
            }
            var OppID = $('#hdnOROpportunityId').val();
            $('#txtComment').val("");
            var OP_Parameters = { OpportunityID: OppID };
            var strHTML = "";
            // StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/CheckForSenderComments',
                type: "POST",
                data: JSON.stringify(OP_Parameters),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (OP_Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OP_Parameters) ? OP_Parameters : JSON.stringify(OP_Parameters)));
                    }
                },
                success: function (data) {

                    $('#txtSenderComments').attr("disabled", true);
                    $('#txtSenderComments').val(data);
                    $("#btnRevision").addClass("clsShowHide");

                    //CheckForApproveAndReject(SessionEmployeeId, 1)
                    //LoadPagination('#BGtblmain', data);
                    // StopAjaxLoader("#bodyBusiness-group");


                },
                //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

        }

        function ApproveOrReject() {
            if ($('#txtapproverejectComment').val().trim() == "" || $('#txtapproverejectComment').val().trim() == null || $('#txtapproverejectComment').val().trim() == undefined) {
                $("#txtapproverejectComment").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter Comment");
            }
            else {
                var OppID = $('#hdnOROpportunityId').val();

                var OP_Parameters = { OpportunityID: OppID };
                var strHTML = "";
                // StartLoader("#bodyBusiness-group");
                $.ajax({
                    url: strUrl + '/api/RM_OpportunityRequest/GetStatusOfOpportunityRequest',
                    type: "POST",
                    data: JSON.stringify(OP_Parameters),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (OP_Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(OP_Parameters) ? OP_Parameters : JSON.stringify(OP_Parameters)));
                        }
                    },
                    success: function (data) {
                        GetOpportunityRequests();
                        var Fromstatus = data;
                        var Tostatus = toStatus;
                        var Comment = $('#txtapproverejectComment').val().replace(/'/g, "''");
                        var OP_Params = { statusChangedBy: SessionEmployeeId, OpportunityID: OppID, Comment: Comment, FromStatus: Fromstatus, ToStatus: Tostatus };
                        $.ajax({
                            url: strUrl + '/api/RM_OpportunityRequest/SendForApproval',
                            type: "POST",
                            data: JSON.stringify(OP_Params),
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                                if (OP_Params) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(OP_Params) ? OP_Params : JSON.stringify(OP_Params)));
                                }
                            },
                            success: function (data) {
                                var IsDemandApprover = $("#hdnOPR_IsDemandApprover").val();

                                $('#ResrsApproveModal').modal('hide');
                                if (toStatus == "A") {
                                    document.getElementById("ApprovalStatus").innerHTML = "Approved";
                                    $("#btnRevision").removeClass("clsShowHide");
                                    $("#btnSendForApproval").addClass("clsShowHide");
                                    $('#tabResourcePlan').addClass("DisableContent");
                                }
                                else {
                                    document.getElementById("ApprovalStatus").innerHTML = "Rejected";
                                    $("#btnRevision").addClass("clsShowHide");
                                    $("#btnSendForApproval").removeClass("clsShowHide");
                                    $("#btnSaveOPR").removeClass("clsShowHide");
                                    $("#btnSaveAddOPR").removeClass("clsShowHide");

                                }
                                $("#btnApprove").addClass("clsShowHide");
                                $("#btnReject").addClass("clsShowHide");
                                GetOpportunityRequests();
                                //Added by Mahesh on 15 July 2021 for refresh issue
                                var IsDemandApproverFlag = $("#hdnOPR_IsDemandApprover").val();
                                GetOPRById(OppID, 'Admin', IsDemandApproverFlag);                                
                                //End of Added by Mahesh on 15 July 2021 for refresh issue
                                window.open('../Email/SendEmail.aspx?MessageID=494&OpportunityID=' + OppID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                            },
                            error: function (err) {
                                //alertify.set('notifier', 'position', 'top-right');
                                //alertify.notify(err);
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                //StopAjaxLoader("#bodyBusiness-group");
                            }
                        })


                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    //alertify.notify(err);
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
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                })
            }


        }

        //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
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

        function LoadPagination(tblId, data) {
            $.fn.DataTable.ext.pager.numbers_length = 10;
            $(tblId).dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": false,
                "scrollResize": true,
                "scrollcollapse": true,
                //Added by imran on 19-08-2022
                pageLength: 10,
                //End of comment by imran on 19-08-2022
                //"scrollY": 'auto',
                // "autoWidth": false,
                // "bSort":true,
                //   "bPaginate": true,
                //"pageLength": 15,
                //"bInfo": false, //hide paging info
                //"pagingType": "full_info",   //full_numbers
                "iDisplayLength": 10,
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

        function ExportORDemandInfo(ReportFormat) {
            var opportunityId = $("#hdnOproppId").val();
            //var taskparameters = { intProxyUserID: '<%= Session("intUserID") %>', employeeID: '<%= Session("intUserID") %>', ReportFormat: ".pdf" }
            var taskparameters = { employeeID: '<%= Session("intUserID") %>', ReportFormat: ReportFormat, OpportunityID: opportunityId }

            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/ExportDocument',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (taskparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? taskparameters : JSON.stringify(taskparameters)));
                    }
                },
                success: function (data) {
                    //alert("Success");
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
                //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })
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

        //Added By Rutuja D. For Bind Filter Placeholder on 15 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }
        //End of Added By Rutuja D. For Bind Filter Placeholder on 15 July 2021

        function closeFilterPanel() {
            $("#filterpanel").removeClass('show');
        }

        //Added by Ashwini M on 27-3-2023
        $(document).on("mouseout", 'th span, .ui-corner-all', function () {
            $(".tooltip").remove();
        });
        //End of added by Ashwini M on 27-3-2023
    </script>

</body>

</html>
