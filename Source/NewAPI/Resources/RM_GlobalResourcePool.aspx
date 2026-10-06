<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_GlobalResourcePool.aspx.vb" Inherits="PbNIT.RM_GlobalResourcePool" %>

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
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
  <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
  <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

 

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
        /*.DisableContent:not(.Resourcedetailpanel):hover{ cursor:not-allowed;}*/
        /*.GRPtblwraps .dataTables_scrollBody.DisableContent{ height:auto!important}*/
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

        body#bodyGlobal-Resource {
            padding-right: 0 !important;
        }

        /*.alertify-notifier li {
            word-break: normal !important;
            white-space: normal !important;
            background-color: red !important;
        }

        .alertifySuccess li {
            word-break: normal !important;
            white-space: normal !important;
            background-color: darkseagreen !important;
        }

        .alertify-notifier .ajs-message {
            width: 500px !important;
            height: 60px;
            word-break: break-word;
            background-color: red !important;
        }*/

        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999 !important;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            /*word-break: break-all;*/
        }


        #GRPtblmain_wrapper .dataTables_paginate {
            margin-top: 20px;
        }

        #GRPtblmain_wrapper table {
            width: 100% !important;
        }

        #GRPtbl_wrapper .dataTables_paginate {
            margin-top: 20px;
        }

        #GRPtbl_wrapper table {
            width: 100% !important;
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

.graphcontainerinner canvas{ width:30%;}/*Added by pradip on 31-3-2023*/
.bgwhite{ padding-bottom:10px;}
.Resourcedetailpanel{ min-height:50vh;}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodyGlobal-Resource">

    <div class="bgwhite clearfix">

        <div class="container-fluid pt-1 pb-1 mb-1 text-end graybg" style="display:table">
            <h5 class="pgtitle float-start">Global Resource Pool</h5>
            <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Back to Resource Configuration">Back</a>--%>
            <%--End of Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <a href="javascript:;" class="mainclearalllink" onclick="closeFilterPanel()" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>

            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel"  id="AdvanceFilterIcon" autocomplete="off"><i class="fas fa-filter" data-bs-toggle="tooltip" title="Filter" data-bs-placement="bottom" data-container="body"></i></button>
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
                        <li class="" id="tabpresetfilter">
                            <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                        </li>


                    </ul>
                </div>

                <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="basicfilters" class="tab-pane stackbasicfilter">
                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" onclick="checkFiltervalidationForGRP();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFlter()">Apply</button>
                                </div>
                                <br />
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Global Resource Pool Code</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboGRPFilterGlobalResourcePoolCode">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">End With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Start With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtGRPFilterGlobalResourcePoolCode", "txtGRPFilterGlobalResourcePoolCode", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Global Resource Pool Name</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboGRPFilterGlobalResourcePoolName">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">End With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Start With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtGRPFilterGlobalResourcePoolName", "txtGRPFilterGlobalResourcePoolName", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %>
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

        <div class="content pt-1">
            <div class="GRPtblwraps">
                <table class="table table-bordered GRPtbl" style="width: 100%;" id="GRPtbl">
                    <thead>
                        <tr>
                            <th class="text-start">Global Resource Pool Code</th>
                            <th class="text-start">Global Resource Pool Name</th>
                        </tr>
                    </thead>
                    <tbody id="tblGlobalResourcePool">
                    </tbody>
                </table>
            </div>
        </div>


        <div class="Resourcedetailpanel">
            <input type="hidden" id="hdnGRP_UniqueIDTab" name="hdnGRP_UniqueIDTab">
            <input type="hidden" id="hdnGRP_GlobalResourcePoolTab" name="hdnGRP_GlobalResourcePoolTab">
            <input type="hidden" id="hdnGRP_GlobalResourcePoolIsActive" name="hdnGRP_GlobalResourcePoolIsActive">
            <input type="hidden" id="hdnGRP_MangerIDTab" name="hdnGRP_MangerIDTab" value="0">


            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li><a href="#GRPdetails" class="active" data-bs-toggle="tab" id="">Details</a><div></div>
                    </li>
                    <li class="" onclick="ShowGRPManager();"><a href="#GRPMangrs" data-bs-toggle="tab" id="GrpPollManagerTab">Global Resource Pool Manager</a><div></div>
                    </li>
                    <li class="" onclick="ShowGraph();"><a href="#GRPgrph" data-bs-toggle="tab" id="">By Role</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">
                    <div id="GRPdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                        </div>

                        <div class="row">
                            <div class="col-sm-4">
                                <label class="required">Global Resource Pool Code</label>
                                <%--    <input type="text" class="form-control" value="GRP" disabled />--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("CboResource", "usp_SEL_ProjectValue", value:="GRP", IsDisabled:=True, cssClass:="form-control") %>
                            </div>

                            <div class="col-sm-4">
                                <label class="required">Global Resource Pool Name</label>
                                <%-- <input type="text" class="form-control" value="Global Resource Pool" disabled />--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("CboResource", "usp_SEL_ProjectValue", value:="Global Resource Pool", IsDisabled:=True, cssClass:="form-control") %>
                            </div>
                        </div>

                    </div>

                    <div id="GRPMangrs" class="tab-pane">
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button type="submit" class="btn borderbtn mr-5" id="AddGRP" data-bs-toggle="modal" data-bs-target="#AddGRPMModal" onclick="GRPEnableManagerlist()"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                            <button class="btn borderbtn mr-5" id="DeleteGRP" onclick="DeleteGRPManager();">Delete</button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                        </div>

                        <table class="table table-bordered GRPdetailTbl" style="width: 100%;" id="GRPtblmain">
                            <thead>
                                <tr>
                                    <th>Manager</th>
                                    <th>Is Primary Responsible</th>
                                    <th>
                                        <div class="custom_chckbox">
                                            <input id="GRPmngrcheck0" class="chckHead" type="checkbox">
                                            <label for="GRPmngrcheck0"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tblGlobalResourcePoolManager">
                                <%--<tr>
                                        <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#AddGBPMModal">Amit Patil</a></td>
                                        <td>Yes</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input id="GRPmngrcheck1" class="chcktbl" type="checkbox">
                                                <label for="GRPmngrcheck1"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#AddGBPMModal">Pradip Pradhan</a></td>
                                        <td>Yes</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input id="GRPmngrcheck2" class="chcktbl" type="checkbox">
                                                <label for="GRPmngrcheck2"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#AddGBPMModal">Lorem Ipsum</a></td>
                                        <td>Yes</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input id="GRPmngrcheck3" class="chcktbl" type="checkbox">
                                                <label for="GRPmngrcheck3"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#AddGBPMModal">Amit Patil</a></td>
                                        <td>Yes</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input id="GRPmngrcheck4" class="chcktbl" type="checkbox">
                                                <label for="GRPmngrcheck4"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#AddGBPMModal">John K</a></td>
                                        <td>Yes</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input id="GRPmngrcheck5" class="chcktbl" type="checkbox">
                                                <label for="GRPmngrcheck5"></label>
                                            </div>
                                        </td>
                                    </tr>--%>
                            </tbody>
                        </table>
                    </div>
                    <div id="GRPgrph" class="tab-pane">
                        <p class="float-start">Resources by Role</p>
                        <div class="detailsubtabsbtn pt-1 pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>
                        <div class="graphcontainer">
                            <div class="graphcontainerinner">
                                 <canvas id="RRChart" width="200" height="200"></canvas>
                            </div>
                           
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="clearfix"></div>
    </div>


    <!--add modal start here-->
    <div class="modal custmodal fade" id="AddGRPMModal" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Global Resource Pool Manager</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="" id="hdn_GRPmngr" value="" />
                    <div class="form-group">
                        <label class="required">Manager</label>
                        <%-- <% CommonFunctions.HTMLControls.DrawComboBox("CboManager", "usp_Whizible2_Sel_tbl_PM_Employee_Medium",,, "class='form-control'", True,, ) %>--%>
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboManager", "Select 0,'' ",,, "class='form-control'",,, True) %>
                    </div>
                    <div class="form-group">
                        <div class="custom_chckbox">
                            <input id="AddGBPMCheck1" name="AddGBPMCheck1" class="clAddGBPMCheck1" type="checkbox" checked="checked">
                            <label for="AddGBPMCheck1">Is Primary Responsible</label>
                        </div>
                    </div>
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        <button class="btn btnyellow" onclick="SaveManagerDetails(0);">Save</button>
                        <button class="btn btnyellow" id="btnSaveManagerDetails" onclick="SaveManagerDetails(1);">Save And Add</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Add modal end here-->
    <div class="modal custmodal GrpSavefilter_filter fade" id="GrpSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Save Filter As</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="GrpSavefilterfilterbox" class="box-panel">

                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-end">Filter Name <span id="MandatoryFilterName" style="color: red">* </span> :</label>
                                        <span class="col-md-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtGRPFilterName", "txtGRPFilterName", "form-control",, maxLength:=100) %>
                                            <div class="btnrow">
                                                <button data-bs-dismiss="modal" class="btn btnyellow float-start savefilter" id="btnSaveFilter" onclick="SaveGRPFilterDetails()">Save</button>
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

    <div class="modal custmodal fade" id="DeleteConfirmGRPMModal" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="notebox">
                        <strong>Note:</strong>Manager with Primary Responsible can not be deleted. <br />  <br />
                           
                        Are you sure, you want to delete the selected records?
                    </div>

                    <div class="text-end">
                        <button class="btn btnyellow" onclick=" DeleteGrpManagerAfterConfirm()">Yes</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal">No</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

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
    

   <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>  
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>  --%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script> 
<%--    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
       <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>

    <script>
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        //Initialize bootstrap tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl, {
                trigger: 'hover'
            });
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



        //Added By Riddhesh Patil on 10-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil

        var noOfRowsPerPage = 10;
        var DeleteRecord = "Please select at least one record to delete.";
        var NoDataFound = "No data found.";
        var CurrentGRPTabObject = { Details: 'false', GrpManager: 'false', RoleGraph: 'false' };
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();


        function editResource() {
            //alert(id);
            //document.getElementById('hdn_GRPmngr').val(id);
            //var GRPname = document.getElementById('hdn_GRPmngr').val();
            //alert("GRPname", GRPname);
            //$(".dataTables_scrollBody").css("height", "auto!important");
            //used for disable grid 
            $(".GRPtblwraps .dataTables_scrollBody, .backbtn, .filter, .paginate_button, #GRPtbl_wrapper .dataTables_scrollHead").addClass("DisableContent").parent().css("cursor", "not-allowed");

            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top -= 60
            }, 'fast');
            $('#GrpPollManagerTab').click()
        }

        $('#tblGlobalResourcePoolManager').on('click', '.clGRPEditManager', function () {
            var isCheckOrNOt = "No";
            CurrentGRPTabObject = { Details: 'false', GrpManager: 'false', RoleGraph: 'false' };
            var $row = $(this).closest("tr");
            var hiddenGRPManagerID = $row.find("#hdn_GRPmanagerId").val();
            $('#hdnGRP_MangerIDTab').val(hiddenGRPManagerID);
            FillBGManager(hiddenGRPManagerID)
            $tds = $row.find("td");

            $.each($tds, function (index, obj) {

                var hiddenGRPUniqueID = $(this).find("#hdnGRP_UniqueID").val();
                var isResposible = $row.find('#hdn_GRPYesNo').val();
                if (hiddenGRPManagerID != 'undefined' && hiddenGRPManagerID != null) {

                    //$(".selectpicker #CboManager").val(hiddenGRPManagerID);
                    $("#CboManager").val(hiddenGRPManagerID);
                    // $('#CboManager').attr("disabled", true);
                    //$('#btnSaveManagerDetails').attr("disabled", true);
                    //alert("hiddenBGMUniqueID" + hiddenBGMManagerID);
                    //alert($("#CboManager").val());
                }
                if (hiddenGRPUniqueID != 'undefined' && hiddenGRPUniqueID != null) {
                    $("#hdnGRP_UniqueIDTab").val(hiddenGRPUniqueID);
                    //$('select[name^="CboBgManager"] option[value=' + hiddenBGMManagerID+']').attr("selected", "selected");

                }
                if (isResposible == "Yes") {
                    $('#AddGBPMCheck1').prop('checked', true);
                }
                else {
                    $('#AddGBPMCheck1').prop("checked", false);
                    //alert('jjKK');
                }

                $('#AddGRPMModal').modal('show');
            });



        });

        function cancledetailpanel() {
            $('#GRPmngrcheck0').prop("checked", false); // Added By RehanC for DeleteAll checkbox getting checked issue on 30th Mar 2023
 }

        function GRPEditManager() {

        }
        $(".GBPdetalilink").click(function () {

            $(this).closest('tr').addClass('rowhiglight');
        });

        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $(".GRPtblwraps .dataTables_scrollBody, .backbtn, .filter, .paginate_button, #GRPtbl_wrapper .dataTables_scrollHead").removeClass("DisableContent").parent("div").css("cursor", "auto");
            CurrentGRPTabObject = { Details: 'false', GrpManager: 'false', RoleGraph: 'false' };
        });

        var strUrl = '';
        var DeleteConfirm = "Are you sure, you want to delete the selected records?";
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
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
        var TagID = '<%= m_TagId%>';

        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';

        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        })

        $(document).ready(function () {
            
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            CurrentGRPTabObject = { Details: 'false', GrpManager: 'false', RoleGraph: 'false' };
            if (blnAddAccess == "False") {
                $("#AddGRP").addClass("clsShowHide");
                $('#btnSaveManagerDetails').attr("disabled", true);

            }
            else {
                $("#AddGRP").removeClass("clsShowHide");
                $('#btnSaveManagerDetails').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#DeleteGRP").addClass("clsShowHide");
            }
            else {
                $("#DeleteGRP").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {
                GetMyGRPFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);

                } else {
                    GetGlobalResourcePool(null);
                    FilterNotApplied();
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";
            }
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

      
       
        })

        function GRPEnableManagerlist() {
            $('#CboManager').attr("disabled", false);
            $('#btnSaveManagerDetails').attr("disabled", false);
            $('#CboManager').val("");
            $('#AddGBPMCheck1').prop('checked', false);
            FillBGManager(0);
        }

        function LoadPagination(data) {
            //var businessGroupTable;
            $.fn.DataTable.ext.pager.numbers_length = 5;
            $('#GRPtbl').dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": '100',
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
                //  "dom": '<"float-end top"p >rt<"clear">',
            });

        }

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        function resizeSection() {
            var tblheight = $(window).height();
            $('.GRPtblwraps .dataTables_scrollBody').css({ 'height': tblheight - 240, "overflow-y": "auto" });

            //var tblheight = $(window).height();
            //$('.Resourcedetailpanel').css({ 'height': tblheight - 80 }); //commented by pradip on 27-3-2023
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


        function checkUncheck() {
            //alert(123);
            //alert($(".chcktbl").length);
            //alert($(".chcktbl:checked").length);
            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
            }
        }

        //Resource by Rolls chart
        var GrpChart;
        function PlotRoleGraph(LabelList, ColorList, DataList) {
            var Grpctx = document.getElementById("RRChart").getContext('2d');
            if (GrpChart) BgChart.destroy();
            GrpChart = new Chart(Grpctx, {
                type: 'pie',
                data: {
                    labels: LabelList,
                    datasets: [{
                        backgroundColor: ColorList,
                        data: DataList,
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'left',
                            align: "start",
                        }
                    },   //Added by pradip on 31-3-2023
                }
            });
        }

        function GetGlobalResourcePool(GrpFilterParms)
        {
            //Added by imran on 19-08-2022
            if (GrpFilterParms == null || GrpFilterParms == "null" || GrpFilterParms == "") {
                var GrpFilterParms =
                {
                    GRPWhereClause: ""
                }
            }
            //End of comment by imran on 19-08-2022
            var strHTML = "";
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            StartLoader("#bodyGlobal-Resource");
            $.ajax({
                url: strUrl + '/api/RM_GlobalResourcePool/GetGlobalResourcePool',
                type: "POST",
                data: JSON.stringify(GrpFilterParms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (GrpFilterParms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(GrpFilterParms) ? GrpFilterParms : JSON.stringify(GrpFilterParms)));
                    }
                },
                success: function (data) {
                    var MyGlobalResourcePools = data;

                    $.each(MyGlobalResourcePools, function (index, obj) {
                        strHTML += '<tr><td class="text-start"> ' + obj.GlobalResourcePoolCode + ' </td> <td class="text-start"> <a href="javascript:;" class="BGdetalilink" onclick="editResource(this)"</a>' + obj.GlobalResourcePoolName + ' </td><input type="hidden" name="hdnGRP_GlobalResourcePoolID" id="hdnGRP_GlobalResourcePoolID" value= ' + obj.GlobalResourcePoolID + '></td></tr>';
                        // $("#tblBusinessGroups bodyBusiness-group").append(row);
                        //console.log("strHTML", strHTML);
                    });
                    $('#GRPtbl').dataTable().fnDestroy();
                    $("#tblGlobalResourcePool").html(strHTML);
                    LoadPagination(data);
                    StopAjaxLoader("#bodyGlobal-Resource");
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyGlobal-Resource");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyGlobal-Resource");
                },
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                

            })

        }
        function ShowGRPManager() {
            if (CurrentGRPTabObject != null && CurrentGRPTabObject.GrpManager == 'false') {
                var GResPoolID = $("#hdnGRP_GlobalResourcePoolID").val();
                // alert(GResPoolID);
                GetGlobalResourcePoolManager(GResPoolID);
                CurrentGRPTabObject.GrpManager = 'true';
            }
        }

        function GetGlobalResourcePoolManager(GlobalResourcePoolID) {
            $("#hdnGRP_UniqueIDTab").val(0);
            $("#hdnGRP_UniqueID").value = 0;
            $("#hdnGRP_UniqueIDTab").value = 0;

            //console.log("aaa",GlobalResourcePoolID);
            var GRPmngrParsms = { GlobalResourcePoolID: GlobalResourcePoolID };
            var strHTML = "";
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            StartLoader("#bodyGlobal-Resource");
            $.ajax({
                url: strUrl + '/api/RM_GlobalResourcePool/GetGlobalResourcePoolManager',
                type: "POST",
                data: JSON.stringify(GRPmngrParsms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (GRPmngrParsms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(GRPmngrParsms) ? GRPmngrParsms : JSON.stringify(GRPmngrParsms)));
                    }
                },
                success: function (data) {
                    var MyGlobalResourcePoolsManager = data;
                    //console.log("data", data);
                    if (MyGlobalResourcePoolsManager.length > 0) {
                        $.each(MyGlobalResourcePoolsManager, function (index, obj) {
                            var strIsPrimaryResponsible = '';
                            if (obj.IsPrimaryResponsible === true) {
                                strIsPrimaryResponsible = 'Yes'
                            } else {
                                strIsPrimaryResponsible = 'No'
                            }
                            if (blnEditAccess == "True") {
                                strHTML += '<tr><td class="text-center"><a href="javascript:;"  class="clGRPEditManager" onclick="GRPEditManager(this)"</a> <input type="hidden" name="hdn_GRPmanagerId" id="hdn_GRPmanagerId" value= ' + obj.ManagerID + '><input type="hidden" name="hdnGRP_UniqueID" id="hdnGRP_UniqueID" value= ' + obj.UniqueID + '>' + obj.Manager + ' </td> <td class="text-center"><input type="hidden" name="hdn_GRPYesNo" id="hdn_GRPYesNo" value= ' + strIsPrimaryResponsible + '>' + strIsPrimaryResponsible + ' </td><td><input onclick="checkUncheck()" class="chcktbl chkGRPManager custom_chckbox" type="checkbox" style="width:18px; height:18px"></td> </tr>';
                            } else {
                                strHTML += '<tr><td class="text-center"><input type="hidden" name="hdn_GRPmanagerId" id="hdn_GRPmanagerId" value= ' + obj.ManagerID + '><input type="hidden" name="hdnGRP_UniqueID" id="hdnGRP_UniqueID" value= ' + obj.UniqueID + '>' + obj.Manager + ' </td> <td class="text-center"><input onclick="checkUncheck()" type="hidden" name="hdn_GRPYesNo" id="hdn_GRPYesNo" value= ' + strIsPrimaryResponsible + '>' + strIsPrimaryResponsible + ' </td><td><input class="chcktbl chkGRPManager custom_chckbox" type="checkbox" style="width:18px; height:18px"></td> </tr>';

                            }
                            //console.log("strHTML", strHTML);
                            // $("#tblBusinessGroups bodyBusiness-group").append(row);
                        });
                    }
                    else {
                        strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    }
                    //$('#GRPtblmain').dataTable().fnDestroy();
                    $("#tblGlobalResourcePoolManager").html(strHTML);
                    //LoadPaginationForGRPmanager(data);
                    StopAjaxLoader("#bodyGlobal-Resource");
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
                    StopAjaxLoader("#bodyGlobal-Resource");
                }
            })

        }

        function SaveManagerDetails(isFromSaveAndclick) {
            $('#GRPmngrcheck0').prop("checked", false); // Added By RehanC for DeleteAll checkbox getting checked issue on 30th Mar 2023

            var managerID = $("#hdnGRP_MangerIDTab").val();
            var newManagerID = $("#CboManager").val();
            if (newManagerID.length > 0 && newManagerID > 0) {
                var uniqueID = $("#hdnGRP_UniqueIDTab").val();
                var gRPId = $("#hdnGRP_GlobalResourcePoolID").val();

                var isPrimaryResponsible = $("#AddGBPMCheck1").is(":checked");
                //Added by imran on 19-08-2022
                if (isPrimaryResponsible == true) {
                    isPrimaryResponsible = 1;
                }
                else {
                    isPrimaryResponsible = 0;
                }
                //End of comment by imran on 19-08-2022
                var manager = {
                    UniqueID: uniqueID > 0 ? uniqueID : 0,
                    GlobalResourcePoolID: gRPId,
                    ManagerID: uniqueID > 0 ? managerID : newManagerID,
                    NewManagerID: newManagerID,
                    IsPrimaryResponsible: isPrimaryResponsible
                };
                
<%--            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';--%>
                $.ajax({
                    url: strUrl + '/api/RM_GlobalResourcePool/SaveGRPManagerDetails',
                    method: 'Post',
                    data: JSON.stringify(manager),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (manager) {
                            xhr.setRequestHeader("Params", encryptString(isJson(manager) ? manager : JSON.stringify(manager)));
                        }
                    },
                    success: function (data) {
                        CurrentGRPTabObject.GrpManager = 'false';
                        ShowGRPManager();
                        CurrentGRPTabObject.GrpManager = 'true';

                        if (isFromSaveAndclick == 0) {
                            if (data == "Manager already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                // $('#CboManager').val("");
                                $('#AddGRPMModal').modal('show');
                            } else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                $('#AddGRPMModal').modal('hide');
                            }


                        }
                        else {
                            if (data == "Manager already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                //$('#AddGRPMModal').modal('show');
                            }
                            else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                $('#CboManager').val("");
                                $('#AddGBPMCheck1').prop('checked', false);
                            }

                        }
                        //if (isFromSaveAndclick == 1) {
                        //    $('#CboManager').val("");
                        //    $('#AddGBPMCheck1').prop('checked', false);
                        //}
                        //StopAjaxLoader("#bodyGlobal-Resource");
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
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            CurrentGRPTabObject.GrpManager = 'false';
                            ShowGRPManager();
                            CurrentGRPTabObject.GrpManager = 'true';
                            //StopAjaxLoader("#bodyGlobal-Resource");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        StopAjaxLoader("#bodyGlobal-Resource");
                        if (isFromSaveAndclick == 0) {
                            $('#AddGRPMModal').modal('hide');
                        }
                    }
                })
            } else {
                //$('#AddBGMModal').modal('show');
                $("#CboManager").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Manager");
            }

        }
        function GetGetMaximumItemsToShowInList() {
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
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(thrownError);
                    }


                }
            })

        }



        function GetSelectedGRPResources() {
            var selectedGRPUniqueId = '';
            $('#tblGlobalResourcePoolManager').find('tr').each(function () {
                var row = $(this);
                if (row.find('input[type="checkbox"]').is(':checked')) {
                    selectedGRPUniqueId += row.find('#hdnGRP_UniqueID').val() + ',';
                    //console.log("selectedGRPUniqueId", selectedGRPUniqueId);
                }
            });
            if (selectedGRPUniqueId.length > 0) {
                selectedGRPUniqueId = selectedGRPUniqueId.substring(0, selectedGRPUniqueId.length - 1);
            }
            return selectedGRPUniqueId;
        }
        function DeleteGRPManager() {
            var isSelectedResource = GetSelectedGRPResources();
            if (isSelectedResource.length > 0) {
                $('#DeleteConfirmGRPMModal').modal('show');

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }

        function DeleteGrpManagerAfterConfirm() {
            debugger;
            $('#GRPmngrcheck0').prop("checked", false); // Added By RehanC for DeleteAll checkbox getting checked issue on 30th Mar 2023
            var isSelectedResource = GetSelectedGRPResources();
            $.ajax({
                url: strUrl + '/api/RM_GlobalResourcePool/DeleteGRPManager',
                type: "POST",
                data: JSON.stringify(isSelectedResource),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    StartLoader("#bodyGlobal-Resource");
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (isSelectedResource) {
                        xhr.setRequestHeader("Params", encryptString(isJson(isSelectedResource) ? isSelectedResource : JSON.stringify(isSelectedResource)));
                    }
                },
                success: function (data) {
                    if (data != "") {
                        alertify.set('notifier', 'position', 'top-right');
                        /*Commented and Modified By RehanC for alert colour issue on 31th Mar 2023*/
                        /*alertify.success(data);*/
                        alertify.error(data);
                        /*End of Comment By RehanC for alert colour issue on 31th Mar 2023*/
                    }

                    StopAjaxLoader("#bodyGlobal-Resource");
                    CurrentGRPTabObject.GrpManager = 'false';
                    ShowGRPManager();
                    CurrentGRPTabObject.GrpManager = 'true';
                    $('#DeleteConfirmGRPMModal').modal('hide');
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
                        CurrentGRPTabObject.GrpManager = 'false';
                        ShowGRPManager();
                        CurrentGRPTabObject.GrpManager = 'true';
                        $('#DeleteConfirmBGMModal').modal('hide');
                        //alertify.set('notifier', 'position', 'top-right');
                        // alertify.notify("Deleted");
                    }
                    //else {
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.notify(thrownError);
                    //    StopAjaxLoader("#bodyBusiness-group");
                    //}

                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    StopAjaxLoader("#bodyGlobal-Resource");
                    $('#DeleteConfirmGRPMModal').modal('hide');
                }
            })
        }


        function ShowGraph() {

            if (CurrentGRPTabObject.RoleGraph == "false") {
                GetGRPResourceRoleGraph();
                CurrentGRPTabObject.RoleGraph = 'true';
            }
        }

        if (CurrentGRPTabObject.RoleGraph == 'false') {
            function GetGRPResourceRoleGraph() {
                CurrentGRPTabObject.RoleGraph = 'true';
                var strHTML = "";
                var strHTML = "";
                StartLoader("#bodyGlobal-Resource");
                $.ajax({
                    url: strUrl + '/api/RM_GlobalResourcePool/GetGResourceRoleGraph',
                    type: "POST",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    },
                    success: function (data) {
                        var GResourcesGraph = data;
                        if (GResourcesGraph.length > 0) {
                            StopAjaxLoader("#bodyGlobal-Resource");
                            //console.log(GResourcesGraph);
                            PlotRoleGraph(GResourcesGraph[0]['LstLabel'], GResourcesGraph[0]['LstColor'], GResourcesGraph[0]['LstData'])
                        } else {
                            PlotRoleGraph(0, 0, 0);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("There is no details available.");
                            StopAjaxLoader("#bodyGlobal-Resource");
                        }
                    },
                    // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    StopAjaxLoader("#bodyGlobal-Resource");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        StopAjaxLoader("#bodyGlobal-Resource");
                    },
                    // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                

                })
            }
        }



        //Fil bg manager on add and edit (with level changed mang)
        function FillBGManager(EmpID) {
            var strHTML = "";
            var objManagerID = { ManagerID: EmpID }
            $.ajax({
                url: strUrl + '/api/RM_BusinessGroup/GetToFillBGManagers',
                type: "POST",
                data: JSON.stringify(objManagerID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objManagerID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objManagerID) ? objManagerID : JSON.stringify(objManagerID)));
                    }
                },
                success: function (data) {
                    //$("#cboOPRFilterLocationID").empty();
                    strHTML += "<option value='0'>Select Manager</option>";//Select Manager Added By Rutuja on 23 Feb 2022
                    $.each(data, function (index, obj) {
                        strHTML += ('<option value=' + obj.EmployeeID + ' >' + obj.UserName + '</option>');
                    })
                    $("#CboManager").html(strHTML);
                    $("#CboManager").val(EmpID);

                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
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
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
            })
        }
        //fILTER
        function GenerateGRPBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    // var strOp = $('#cbo' + module + 'Filter' + filterField[i] + ' option:selected').val();
                    //alert($("#txt" + module + "Filter" + filterField[i]));
                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();

                    // strvalue = $("#txtBGFilterBgGroupName").val();
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
            if (arrFields[0] == "GlobalResourcePoolCode") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboGRPFilterGlobalResourcePoolCode", "txtGRPFilterGlobalResourcePoolCode");
            }
            if (arrFields[0] == "GlobalResourcePoolName") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboGRPFilterGlobalResourcePoolName", "txtGRPFilterGlobalResourcePoolName");
            }
        }
        function setFilterComboValue(fieldName, fieldValue, flag) {
            //if (flag == undefined) {
            //    $("#" + fieldName).removeClass("selectpicker");
            $("#" + fieldName).val(fieldValue);
            //    $("#" + fieldName).addClass("selectpicker");
            //    $('.selectpicker').selectpicker('refresh');
            //}
            //if (flag == "class") {
            //    $("." + fieldName).removeClass("selectpicker");
            //    $("." + fieldName).val(fieldValue);
            //    $("." + fieldName).addClass("selectpicker");
            //    $('.selectpicker').selectpicker('refresh');
            //}
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

            //$("#" + ValueComboName).val(currValue);
             //Commented & added by mahesh on  27 july 2021
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }

        function ClearFilterDetails(flag) {
            if ($("#cboGRPFilterGlobalResourcePoolCode").val() != "Contains") {
                setFilterComboValue("cboGRPFilterGlobalResourcePoolCode", "Contains");
            }
            if ($("#txtGRPFilterGlobalResourcePoolCode").val() != "") {
                $("#txtGRPFilterGlobalResourcePoolCode").val("");
            }
            if ($("#txtGRPFilterGlobalResourcePoolName").val() != "") {
                $("#txtGRPFilterGlobalResourcePoolName").val("");
            }
            if ($("#cboGRPFilterGlobalResourcePoolName").val() != "Contains") {
                setFilterComboValue("cboGRPFilterGlobalResourcePoolName", "Contains");
            }
            $('#txtGRPFilterName').val('');
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
            GetGRPDetails(null);
        });

        function ApplyFlter() {

            
                currentFilterID = 0;
                //if ($('#txtGRPFilterGlobalResourcePoolCode').val() == "" && $('#txtGRPFilterGlobalResourcePoolName').val() == "") {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.error('Enter at least one filter value');
                //} else {
                var filter = "";
                //if (filterwhereclause != 'undefined' && filterwhereclause != null) {
                var AllBgFilter = ["GlobalResourcePoolCode", "GlobalResourcePoolName"];
                //var isActiveFilter = $('#chkGrpFilterIsActive').is(":checked");
            var filterWhereClause2 = GenerateGRPBasicFilterQuery("GRP", AllBgFilter);
            //Added By Reshma Chavan on 25th Nov 2021. getting Correct alert
            if (filterWhereClause2 == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
            } else {
             //End of Added By Reshma Chavan on 25th Nov 2021.getting Correct alert
                //var savwww = filterWhereClause2.toString().replace(/\''/g, "'");
                filterWhereClause = filterWhereClause2.replace(/"/g, "\'");
                //Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                //filter = { UniqueID: '0', IsActive: 'false', GRPWhereClause: encodeURI(filterWhereClause) }
                filter = { UniqueID: '0', IsActive: 'false', GRPWhereClause: encodeURIComponent(filterWhereClause) }
                //End of Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                FilterApplied();
                //}

                //SaveBGFilterDetails();
                GetGlobalResourcePool(filter);
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");
            }

        }
        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtGRPFilterName').val("");
            }
        }

        function GetGRPDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                // var whereClauseFormated = whereClause.replace(/'/g, "\''");
                //Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                //filter = { UniqueID: '0', IsActive: 'true', GRPWhereClause: encodeURI(whereClause) };
                filter = { UniqueID: '0', IsActive: 'true', GRPWhereClause: encodeURIComponent(whereClause) };
                //End of Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
            }
            GetGlobalResourcePool(filter);
            GetMyGRPFilter(0);
        }
        function checkFiltervalidationForGRP() {
            var GRPCode = $("#txtGRPFilterGlobalResourcePoolCode").val() == "" ? null : $("#txtGRPFilterGlobalResourcePoolCode").val();
            var GRPName = $("#txtGRPFilterGlobalResourcePoolName").val() == "" ? null : $("#txtGRPFilterGlobalResourcePoolName").val();
            //alert(GRPCode+ ","+ GRPName);
            if ((GRPCode == null || GRPCode == 'undefined') && (GRPName == null || GRPName == 'undefined')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
                $('#GrpSavefilter').modal('hide');
            }
            else {
                $('#GrpSavefilter').modal('show');
            }
        }

        //Added By Riddhesh Patil on 12-NOV-2022 
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
        var savedFilterName = "";
        function SaveGRPFilterDetails() {
            //alert("HJHJDF");
            //Commented and added by imran on 18-08-2022
            var fltFilterName = $("#txtGRPFilterName").val();
            var fltFilterName = $("#txtGRPFilterName").val().trim();
            //End of comment by imran on 18-08-2022

            //debugger;
            //$('#BgSavefilter').modal('show');
            // $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            if (fltFilterName == "") {
                //$('#BgSavefilter').modal('show');
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter filter name');
                //$('#BgSavefilter').modal('show')

                $("#txtGRPFilterName").focus();

                //return false
            }
             //Added By Riddhesh Patil on 12-NOV-2022 
            else if (checkSpecialCharacter(fltFilterName.trim(), WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtGRPFilterName").focus();

            }
			//End of Comment Added By Riddhesh Patil
            else {
                var filterExists = 0;
                //if (savedFilterName == "") {
                //    filterExists = ExistGRPFilter(fltFilterName);
                //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                //    $('#GrpSavefilter').modal('show');
                //}

                //if (filterExists == 0) {
                //    $("#btnSaveFilter").attr("data-bs-dismiss", "modal");
                var AllBgFilter = ["GlobalResourcePoolCode", "GlobalResourcePoolName"];
                //var isActiveFilter = 'True';/// $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GenerateGRPBasicFilterQuery("GRP", AllBgFilter);
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
                            $('#GrpSavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            GetMyGRPFilter(0);
                            ApplyFlter();
                            FilterApplied();

                            savedFilterName = fltFilterName;
                            $("#txtGRPFilterName").val('');
                            //clearTooltip();
                            // ClearFilterDetails("");
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
                //}
            }
        }
        function GetMyGRPFilter(flag) {
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
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id,3);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3)></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                            }
                            else {
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

        function ExistGRPFilter(filtername) {

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
                error: function (xhr, errorThrown) {
                    isFilterExists = 1;
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
            return isFilterExists;
        }

        //Delete filter
            //Commented & Added By Rutuja D. For Filter Issue on 7 July 2021
       // function DeleteFilter(FilterID, IsApplyed) {
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
                            // var GetGRPWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                            GetGRPDetails();
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyGRPFilter(0);
                        currentappliedfilter = 0;
                    }
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                // }
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
                        $("#txtGRPFilterName").val(currentFilterName);
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
        function ApplySavedFilter(FilterID, isDefault, isFromDefault) {
            //Added By Rutuja D. on 23 Feb 2022 for alert missing
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            //End of Added By Rutuja D. on 23 Feb 2022 for alert missing
            if (isDefault == 3) {
                // var GetGRPWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                GetGRPDetails();
                GetMyGRPFilter(isDefault);
                FilterNotApplied();
                ClearFilterDetails(""); // Added By Reshma Chavan on 31st Jan 2022 for clearing filter
                $('#AdvanceFilterIcon').attr("aria-expanded", false);
                //Added By Rutuja D. on 23 Feb 2022 for alert missing
                if ((isFromDefault === false || isFromDefault == 'false') && (isDefault == 3)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Filter removed successfully.");
                }
                //End of Added By Rutuja D. on 23 Feb 2022 for alert missing
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
                            GetGRPDetails(Querytext);
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
                            GetMyGRPFilter(0);
                        }
                    },
                    //Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
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
                    //alert(removeDefault);
                    if (removeDefault == 0) {
                        //alertify.success('Success');
                        // ApplySavedFilter(FilterID, 2);
                        ApplySavedFilter(FilterID, 2, true); //changed by mahesh on 21 july 2021
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        //alertify.success('Default');
                        //FilterNotApplied();
                        ApplySavedFilter(FilterID, 3, true);//changed by mahesh on 21 july 2021
                        alertify.success('Default Filter Is Successfully Removed!');
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        FilterNotApplied();
                    }
                    GetMyGRPFilter(0);
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
        //Commented By RehanC for duplicate function on 30th Mar 2023
        //function cancledetailpanel() {

        //}

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
