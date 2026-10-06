<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_DeliveryTeam.aspx.vb" Inherits="PbNIT.RM_DeliveryTeam" %>

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
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
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
            min-height:60vh;
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

        /*Resume Style*/
        /*.content-wrapper{background:#eee!important}*/
        #ResumeModal .modal-body {
            padding: 0;
        }

        .resumecontainer {
            max-width: 100%;
            margin: 0px auto;
            border: 1px solid #ddd;
            box-shadow: 0 1px 4px rgba(0,0,0,0.1);
            background: #fff;
            border-radius: 4px
        }

        .resumeHeader {
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

            .resumeHeader figure {
                margin: 0 0 0 35px;
                border: 1px solid #ddd;
                height: 160px;
                width: 160px;
                line-height: 160px;
                background: #f5f5f5;
                border-radius: 100%;
            }

        .resumehdright.graybg {
            padding: 15px
        }

        .resumetblTitle {
            background: #4263c1 !important;
            color: #fff !important;
            font-size: 16px;
            font-weight: 400;
            padding: 4px 8px !important
        }

        .CandidateName h4 {
            color: #1359a6
        }

        .ResumeAsignmentDetails {
            display: block;
            text-align: left
        }

        .RProname strong {
            color: #1359ac !important
        }

        .resumebody {
            padding: 15px
        }

        .table-bordered tbody th {
            background: #e7edf0
        }

        .bankrow td {
            padding: 0 !important;
            height: 5px !important;
            border: none !important;
            line-height: 5px !important
        }

        .candidateContctinfo p {
            margin-bottom: 0;
            line-height: 18px;
            text-align: right
        }

            .candidateContctinfo p label {
                width: 100px
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

        body#bodyDelivery-Unit {
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


        #DUtblmain_wrapper .dataTables_paginate {
            margin-top: -25px;
        }

        #DUtblmain_wrapper table {
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
         /*Added by pradip on 6-7-2021*/
        .rsrsouter{ max-height:55vh;}
        .rsrsouter thead th{ position:sticky; top:0;}/*End Added by pradip on 6-7-2021*/

        .stackbasicfilter .form-group{display:inline-flex!important}
        .graphcontainerinner canvas{ width:30%;}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed">


    <div class=""  id="bodyDelivery-Unit"></div>
        <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 mb-0 text-end graybg" style="display:table">
            <h5 class="pgtitle float-start">Delivery Team</h5>
            <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Back to Resource Configuration">Back</a>--%>
           <%--ENd of Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <a href="javascript:;" class="mainclearalllink" onclick="closeFilterPanel()" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" id="AdvanceFilterIcon" title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
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
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="checkFiltervalidationForDT();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFlter()">Apply</button>
                                </div>
                                <br />

                                <div class="row">
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            <label>Delivery Team Code</label>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboDTFilterGroupCode">
                                                        <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-6 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtDTFilterGroupCode", "txtDTFilterGroupCode", "form-control", ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <label>Delivery Team Name</label>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboDTFilterGroupName">
                                                        <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-6 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtDTFilterGroupName", "txtDTFilterGroupName", "form-control", ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            <label>Delivery Team Head</label>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboDTFilterResourceHeadID">
                                                        <option value="=">=</option>
                                                        <option value="<>"><></option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-6 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtDTFilterResourceHeadID", "usp_Sel_tbl_PM_Employee_TeamManager",,, "class='form-control'",,,) %>


                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <label>Is Active</label>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <select class="form-control input-sm" id="cboDTFilterActive">
                                                        <option value="=">=</option>
                                                        <option value="<>"><></option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <div class="custom_chckbox">
                                                        <%CommonFunctions.HTMLControls.DrawCheckBox("chkDTFilterActive", "chkDTFilterActive", "custom_chckbox clsCheckBox", False, , , "style='width: 30px;height:15px;'", , , , , , )%>
                                                        <label for="chkDTFilterActive">IsActive</label>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
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
            <table class="table table-bordered GRPtbl" style="width: 100%;" id="DUtblmain">
                <thead>
                    <tr>
                        <th class="text-start" width="200">Delivery Team Code</th>
                        <th class="text-start">Delivery Team Name</th>
                        <th class="" width="100">Is Active</th>
                    </tr>
                </thead>
                <tbody id="DTtable">
                    <%-- <tr>
                        <td class="text-start">100</td>
                        <td class="text-start"><a href="javascript:;" class="DTdetalilink" onclick="editDT()">Development Team</a></td>
                        <td class="">Yes</td>
                    </tr>
                    <tr>
                        <td class="text-start">17</td>
                        <td class="text-start"><a href="javascript:;" class="DTdetalilink" onclick="editDT()">East Banglore Team</a></td>
                        <td class="">Yes</td>
                    </tr>
                    <tr>
                        <td class="text-start">2</td>
                        <td class="text-start"><a href="javascript:;" class="DTdetalilink" onclick="editDT()">TEST Pune</a></td>
                        <td class="">Yes</td>
                    </tr>
                    <tr>
                        <td class="text-start">65</td>
                        <td class="text-start"><a href="javascript:;" class="DTdetalilink" onclick="editDT()">North Banglore Team</a></td>
                        <td class="">Yes</td>
                    </tr>
                    <tr>
                        <td class="text-start">40</td>
                        <td class="text-start"><a href="javascript:;" class="DTdetalilink" onclick="editDT()">Testing Team</a></td>
                        <td class="">Yes</td>
                    </tr>
                    <tr>
                        <td class="text-start">95</td>
                        <td class="text-start"><a href="javascript:;" class="DTdetalilink" onclick="editDT()">South Banglore Team</a></td>
                        <td class="">Yes</td>
                    </tr>--%>
                </tbody>
            </table>
        </div>


        <div class="Resourcedetailpanel">
            <input type="hidden" id="hdnDT_DeliveryGroupIDTab" name="hdnDT_DeliveryGroupIDTab">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li><a href="#RDTDetails" class="active" data-bs-toggle="tab" id="DTDetailsTab">Details</a><div></div>
                    </li>
                    <li class=""><a href="#RDTResources" data-bs-toggle="tab" id="DTResourceTab" onclick="ShowResources();">Resources</a><div></div>
                    </li>
                    <li class=""><a href="#RDTGraph" data-bs-toggle="tab" id="" onclick="ShowGraph()">By Role</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">
                    <div id="RDTDetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>

                        <div class="row">
                            <div class="col-sm-2">
                                <label class="required">Delivery Team Code</label>
                                <input type="text" class="form-control" value="Admin & HR & Finance" id="DUDtl_GroupCode" disabled />
                            </div>
                            <div class="col-sm-4">
                                <label class="required">Delivery Team Name</label>
                                <input type="text" class="form-control" value="MAGARPATTA" id="DUDtl_GroupName" disabled />
                            </div>
                            <div class="col-sm-4">
                                <label class="required">Delivery Team Head</label>
                                <%--<select class="form-control selectpicker clDUDtl_HeadName" id="DUDtl_HeadName" disabled>
                                </select>--%>
                                <%CommonFunctions.HTMLControls.DrawComboBox("CboDT", "usp_Sel_tbl_PM_Employee_High_Medium",,, "class='form-control issueselectprojects' disabled", True,,) %> <%--Disabled class Added by Rutuja D. on 23 Feb 2022 for IssueID = 32140--%>
                            </div>
                            <div class="col-sm-2">
                                <label class="dblock">&nbsp;</label>
                                <strong>Is Active :
                                    <label class="clDuDtl_DuActive" id="DuDtl_DuActive"></label>
                                </strong>

                            </div>
                        </div>

                    </div>
                    <div id="RDTResources" class="tab-pane">
                        <div class="row pt-1 pb-1">
                            <div class="col-sm-6">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <label for="email">Role Description : </label>
                                        <%CommonFunctions.HTMLControls.DrawComboBox("CboDTResource", "usp_Whizible2_Sel_tbl_PM_Role_Roles ",,, "class='form-control issueselectprojects'  onChange='javascript:CboDTResource_OnChange(this.value);'",,,) %>
                                        <%--                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboBGResource", "Select  RoleID,RoleDescription From tbl_PM_Role Where IsUserGroup=0 Order By RoleDescription ",,, "class='form-control issueselectprojects' onChange='javascript:CboBGResource_OnChange(this.value);'", True,,) %>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="detailsubtabsbtn text-end">
                                    <button class="btn borderbtn canceldetailpanel" id="" " style="margin-top: 5px;">Cancel</button>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive rsrsouter"><!--Added class by pradip-->
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Employee Name</th>
                                    <th>Role Description</th>
                                    <th>Location</th>
                                    <th>Department</th>
                                    <th>Email ID</th>
                                    <th>Resume</th>
                                </tr>
                            </thead>
                            <tbody id="DTmanagers">
                                <%--<tr>
                                    <td>SHAM</td>
                                    <td>Automation Role</td>
                                    <td>Admin & HR & Finance</td>
                                    <td>DEPT MASTER</td>
                                    <td>sham@gmail.com</td>
                                    <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResumeModal">Resume</a></td>
                                </tr>
                                <tr>
                                    <td>Pradip</td>
                                    <td>Design Role</td>
                                    <td>Developement</td>
                                    <td>Development and Delivery</td>
                                    <td>pradip@gmail.com</td>
                                    <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResumeModal">Resume</a></td>
                                </tr>
                                <tr>
                                    <td>SHAM</td>
                                    <td>Automation Role</td>
                                    <td>Admin & HR & Finance</td>
                                    <td>DEPT MASTER</td>
                                    <td>sham@gmail.com</td>
                                    <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResumeModal">Resume</a></td>
                                </tr>
                                <tr>
                                    <td>Pradip</td>
                                    <td>Design Role</td>
                                    <td>Developement</td>
                                    <td>Development and Delivery</td>
                                    <td>pradip@gmail.com</td>
                                    <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResumeModal">Resume</a></td>
                                </tr>
                                <tr>
                                    <td>SHAM</td>
                                    <td>Automation Role</td>
                                    <td>Admin & HR & Finance</td>
                                    <td>DEPT MASTER</td>
                                    <td>sham@gmail.com</td>
                                    <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResumeModal">Resume</a></td>
                                </tr>
                                <tr>
                                    <td>Pradip</td>
                                    <td>Design Role</td>
                                    <td>Developement</td>
                                    <td>Development and Delivery</td>
                                    <td>pradip@gmail.com</td>
                                    <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResumeModal">Resume</a></td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                    </div>
                    <div id="RDTGraph" class="tab-pane">
                        <p class="float-start">Resources by Role</p>
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" >Cancel</button>
                        </div>
                        <div class="graphcontainer">
                            <div class="graphcontainerinner">
                                <canvas id="RDTChart" width="200" height="200"></canvas>
                            </div>                            
                        </div>
                    </div>

                </div>
            </div>
        </div>


        <div class="clearfix"></div>
    </div>
    <%-- filter model for save--%>
    <div class="modal custmodal DtSavefilter_filter fade" id="DtSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Save Filter As</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="DtSavefilterfilterbox" class="box-panel">

                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-end required">Filter Name :</label>
                                        <span class="col-md-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtDTFilterName", "txtDTFilterName", "form-control",, maxLength:=100, ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                                            <div class="btnrow">
                                                <button class="btn btnyellow float-start savefilter" id="btnSaveFilter" onclick="SaveDTFilterDetails()">Save</button>
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

    <!--add modal start here-->
    <div class="modal custmodal fade" id="AddDTMModal" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Business Group Managers</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <label class="required">Manager</label>
                        <select id="AddGBPM1" class="selectpicker form-control">
                            <option>John C</option>
                            <option>Robert K</option>
                            <option>Ken Dawyer</option>
                            <option>Tom Desouza</option>
                        </select>
                    </div>
                    <div class="form-group row">
                        <div class="custom_chckbox">
                            <input id="AddGBPMCheck1" class="chcktbl" type="checkbox">
                            <label for="AddGBPMCheck1">Is Primary Responsible</label>
                        </div>
                    </div>
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
    <%--Added by Rutuja D on 6th July 2021--%>
     <div id="deleteConfirmAlert" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modalsmall ui-draggable">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                                    <h5 class="modal-title">Delete Confirmation</h5>
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
    <!--resume modal start here-->
    
    <!--resume modal end here-->
    <!-- REQUIRED JS SCRIPTS -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>    <!--style-custome-->
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>
        //var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"))
        //var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        //    return new bootstrap.Tooltip(tooltipTriggerEl)
        //});


        //Added By Madhuri.K for Remove tooltip 
        $('body').on('click', function () {
            $('.tooltip').remove();
        });

        //Initialize bootstrap tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl, {
                trigger: 'hover'
            });
        });

        //Added By Riddhesh Patil on 10-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil
        var noOfRowsPerPage = 10;
        var CurrentDTTabObject = { Details: 'false', Resources: 'false', ByRole: 'false' };
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



        function editDT(GrpId) {
            $("#hdnDT_DeliveryGroupIDTab").val(GrpId);
            //$(".dataTables_scrollBody").css("height", "auto!important");

            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'fast');
            //used for disable grid
            $(".dataTables_scrollBody, .backbtn, .filter, .paginate_button, .dataTable").addClass("DisableContent").parent().css("cursor", "no-drop");

            var Parsms = { GroupID: GrpId };
            $.ajax({
                url: strUrl + '/api/RM_DeliveryTeam/GetById',
                type: "POST",
                data: JSON.stringify(Parsms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parsms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parsms) ? Parsms : JSON.stringify(Parsms)));
                    }
                },
                success: function (data) {
                    var TeamHead = data;
                    DTteamHead = TeamHead.EmployeeID;
                    $("#CboDT").val(TeamHead.EmployeeID);
                   // $('#CboDT').attr("disabled", true);

                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyDelivery-Unit");
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
        $('#DTtable').on('click', '.DTdetalilink', function () {
            CurrentDTTabObject = { Details: 'false', Resources: 'false', ByRole: 'false' };
            var $row = $(this).closest("tr");
            var HEADid = $("#hdnDT_DeliveryGroupIDTab").val();
            $tds = $row.find("td");

            $.each($tds, function (index, obj) {
                var hiddenField = $(this).find("input[type='hidden']").val();
                if (hiddenField != 'undefined' && hiddenField != null) {
                    $("#hdnDT_DeliveryGroupIDTab").val(hiddenField);

                }
                if (index == 0) {
                    $('#DUDtl_GroupCode').val($(this).text());
                    //$("#hdnBG_BusinessGroupCode").val();
                }
                if (index == 1) {
                    $('#DUDtl_GroupName').val($(this).text());
                    //$("#hdnBG_BusinessGroupIsActive").val($(this).text());
                }
                if (index == 2) {
                    $('.clDuDtl_DuActive').html($(this).text());
                    //$("#hdnBG_BusinessGroupIsActive").val($(this).text());
                }

            });
            $(this).closest('tr').addClass('rowhiglight');
            $('#DTDetailsTab').click()

        });


        $(".DTdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $(".dataTables_scrollBody, .backbtn, .filter, .paginate_button, .dataTable").removeClass("DisableContent").parent().css("cursor", "auto");
            CurrentDTTabObject = { Details: 'false', Resources: 'false', ByRole: 'false' };
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

        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var DTteamHead = 0;
        $(document).ready(function () {
            CurrentDTTabObject = { Details: 'false', Resources: 'false', ByRole: 'false' };
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (blnViewAccess == "True") {
                GetMyDTFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);

                } else {
                    GetDeliveryTeam(null);
                    FilterNotApplied();
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
            //Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
            BindPlaceholder("txtDTFilterResourceHeadID", "Delivery Team Head");
            //End of Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
            //GetDeliveryTeam(null);
        });

        function LoadPagination(data) {
            //var businessGroupTable;
            $.fn.DataTable.ext.pager.numbers_length = 5;
            $('#DUtblmain').dataTable({
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
        //datatable
        $('.GRPtbl').dataTable({
            //"ajax": '/api/data',
            "scrollY": true,
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

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        function resizeSection() {
            var tblheight = $(window).height();
            $('#DUtblmain_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 165, "overflow-y": "auto" });

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
                $(".chckHead").prop("checked", false);
            }

        });


        //Resource by Rolls chart
        var DtChart;
        function PlotRoleGraph(LabelList, ColorList, DataList) {
            var Dtctx = document.getElementById("RDTChart").getContext('2d');
            if (DtChart) DtChart.destroy();
            DtChart = new Chart(Dtctx, {
                type: 'pie',
                data: {
                    labels: LabelList,
                    datasets: [{
                        backgroundColor: ColorList,
                        data: DataList
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'left',
                            align: "start",
                        }
                    },
                    
                }
            });
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
                        //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.error(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
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
        function CboDTResource_OnChange(RoleID) {
            //alert(RoleID);
            var DTgrpID = $("#hdnDT_DeliveryGroupIDTab").val();
            if (RoleID.length > 0) {
                GetDeliveryTeamResouces(DTgrpID, RoleID)
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Role Description");
            }

        }

        function GetDeliveryTeam(DtFilterParms) {
            //console.log("DtFilterParms",DtFilterParms);
            var strHTML = "";
            var ResourceHeadID = SessionEmployeeId;
            // alert(ResourceHeadID);
            var FilterParms = { ResourceHeadID: ResourceHeadID };

            if (DtFilterParms != null) {
                var FilterParms = { DTWhereClause: DtFilterParms.DTWhereClause, ResourceHeadID: ResourceHeadID };
            }

            StartLoader("#bodyDelivery-Unit");
            $.ajax({
                url: strUrl + '/api/RM_DeliveryTeam/GetDeliveryTeam',
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
                    var MyDeliveryUnit = data;
                    $.each(MyDeliveryUnit, function (index, obj) {
                        var strActive = '';
                        if (obj.Active === true) {
                            strActive = 'Yes'
                        } else {
                            strActive = 'No'
                        }
                        strHTML += '<tr><td class="text-start"> ' + obj.GroupCode + ' </td> <td class="text-start"> <a href="javascript:;" class="DTdetalilink" onclick="editDT(' + obj.GroupID + ')"</a>' + obj.GroupName + ' </td><input type="hidden" name="hdnDT_DeliveryGroupID" id="hdnDT_DeliveryGroupID" value= ' + obj.GroupID + '></td><td class="text-center"> ' + strActive + ' </td></tr>';
                        // console.log(strHTML);
                    });
                    $('#DUtblmain').dataTable().fnDestroy();
                    $("#DTtable").html(strHTML);
                    LoadPagination(data);
                    StopAjaxLoader("#bodyDelivery-Unit");
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyDelivery-Unit");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyDelivery-Unit");
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            })
        }
        if (CurrentDTTabObject.Resources == 'false') {
            function GetDeliveryTeamResouces(GroupID, RoleID) {
                CurrentDTTabObject.Resources = 'true';
                //alert(GroupID);
                var DTParsms = { GroupID: GroupID, RoleID: RoleID };
                var strHTML = "";
                StartLoader("#bodyDelivery-Unit");
                $.ajax({
                    url: strUrl + '/api/RM_DeliveryTeam/GetDeliveryTeamResouceData',
                    type: "POST",
                    data: JSON.stringify(DTParsms),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (DTParsms) {
                            xhr.setRequestHeader("Params", encryptString(isJson(DTParsms) ? DTParsms : JSON.stringify(DTParsms)));
                        }
                    },
                    success: function (data) {
                        var MyOrganizationRoles = data;
                        //console.log("MyOrganizationRoles", MyOrganizationRoles);
                        if (data.length > 0) { // Added by Chetan M on 6 Jul 2021 for Issue Fixing
                            $.each(MyOrganizationRoles, function (index, obj) {
                                strHTML += '<tr><td>' + obj.EmployeeName + '</td><td>' + obj.RoleDescription + '</td><td>' + obj.Location + '</td><td>' + obj.Department + '</td><td>' + obj.EmailID + '</td><td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResumeModal" onclick="GetDTResourceResume(' + obj.EmployeeID + ')">' + obj.Resume + '</a></td></tr>';
                                // $("#tblBusinessGroups bodyBusiness-group").append(row);
                            });
                        }
                        //Added by Chetan M on 6 Jul 2021 for Issue Fixing
                        else {
                            strHTML += '<tr><td class="text-center" colspan="6">No data found.</td></tr>';
                        }
                        // End of Added by Chetan M on 6 Jul 2021 for Issue Fixing
                        $("#DTmanagers").html(strHTML);
                        StopAjaxLoader("#bodyDelivery-Unit");
                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    StopAjaxLoader("#bodyDelivery-Unit");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                        StopAjaxLoader("#bodyDelivery-Unit");
                    }
                })

            }
        }
        function ShowResources() {
            if (CurrentDTTabObject.Resources == 'false') {
                $("#CboDTResource").val('0'); // Added by Chetan M on 6 Jul 2021 for Issue Fixing
                var RoleId = $('#CboDTResource').val();
                CboDTResource_OnChange(RoleId);
                CurrentDTTabObject.Resources = 'true';
            }
        }

        function ShowGraph() {
            if (CurrentDTTabObject != null && CurrentDTTabObject.ByRole == 'false') {
                var DTGrpID = $("#hdnDT_DeliveryGroupIDTab").val();
                //alert(DTGrpID);            
                GetDTResourceRoleGraph(DTGrpID);
                CurrentDTTabObject.ByRole = 'true';
            }
        }
        if (CurrentDTTabObject.ByRole == 'false') {
            function GetDTResourceRoleGraph(GroupID) {
                CurrentDTTabObject.ByRole = 'true';
                StartLoader("#bodyDelivery-Unit");
                var dtRoleParsms = { GroupID: GroupID };
                $.ajax({
                    url: strUrl + '/api/RM_DeliveryTeam/GetDeliveryTeamResoucePoolGraph',
                    type: "POST",
                    data: JSON.stringify(dtRoleParsms),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (dtRoleParsms) {
                            xhr.setRequestHeader("Params", encryptString(isJson(dtRoleParsms) ? dtRoleParsms : JSON.stringify(dtRoleParsms)));
                        }
                    },
                    success: function (data) {
                        var DTResourcesGraph = data;
                        if (DTResourcesGraph.length > 0) {
                            StopAjaxLoader("#bodyDelivery-Unit");
                            PlotRoleGraph(DTResourcesGraph[0]['LstLabel'], DTResourcesGraph[0]['LstColor'], DTResourcesGraph[0]['LstData'])
                        } else {
                            PlotRoleGraph(0, 0, 0);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("There is no details available.");
                            StopAjaxLoader("#bodyDelivery-Unit");
                        }
                    },
                    // Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    StopAjaxLoader("#bodyDelivery-Unit");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        StopAjaxLoader("#bodyDelivery-Unit");
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                })
            }
        }
        function GetDTResourceResume(EmployeeID) {
            window.open('../Resources/Resume.aspx?EmployeeID=' + EmployeeID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100');
            //var strHTML = "";      
            //var Parameter = { EmployeeID: EmployeeID };

            //StartLoader("#bodyDelivery-Unit");
            //$.ajax({
            //    url: strUrl+'/api/RM_OrganizationUnit/GetResourceResume',
            //    type: "POST",
            //    data: JSON.stringify(Parameter),
            //    contentType: "application/json;charset-utf=8",
            //    beforeSend: function (xhr) {
            //        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
            //    },
            //    success: function (data) {
            //        var MyEmployeeResume = data;
            //        // if (MyEmployeeResume.ProfileImage == null || MyEmployeeResume.ProfileImage == '') {
            //        //    $('#employeeImage').prop('src', "../../../Whizible2.0-new/dist/img/blankprofile.png");
            //        //}
            //        //else {
            //        //    $('#employeeImage').prop('src', "../../" + MyEmployeeResume.ProfileImage);

            //        //}
            //        //if (MyEmployeeResume.EmployeeInfo != null) {
            //        //    strHTML += '<h4 style="margin-top:0">' + MyEmployeeResume.EmployeeInfo.EmployeeName + '</h4><span>Business Development Manager</span>';
            //        //    $("#employeeName").html(strHTML);

            //        //    var strEmployeInfoHTML = '<p style="margin-bottom:0"><label>Date of Birth : </label><span>' + MyEmployeeResume.EmployeeInfo.DOB + '</span></p><p style="margin-bottom:0"><label>Phone No : </label><span>' + MyEmployeeResume.EmployeeInfo.Phone + '</span></p><p style="margin-bottom:0"><label>Email ID : </label><span><a href="mailto:quality05@lifeline-sys.com"></a>' + MyEmployeeResume.EmployeeInfo.EmailID + '</span></p>';
            //        //    $("#employeeInformation").html(strEmployeInfoHTML);
            //        //}
            //        //if (MyEmployeeResume.EmployeeSkillslst != null && MyEmployeeResume.EmployeeSkillslst.length > 0) {

            //        //    var strEmployeeSkillHTML = '<tr class="bankrow"><td colspan="2">&nbsp;</td></tr>';
            //        //    $.each(MyEmployeeResume.EmployeeSkillslst, function (index, obj) {

            //        //        strEmployeeSkillHTML += '<tr><th>' + obj.TechnicalSkills + '</th> <td class="text-start">' + obj.YearsOfExperiance + '</td> </tr>';

            //        //    });
            //        //    $("#tbltechnicalskills").html(strEmployeeSkillHTML);
            //        //}

            //        //if (MyEmployeeResume.CurrentAssignments != null && MyEmployeeResume.CurrentAssignments.length > 0) {
            //        //    var strEmployeeAssignmentHTML = '';

            //        //    $.each(MyEmployeeResume.CurrentAssignments, function (index, obj) {

            //        //        strEmployeeAssignmentHTML += '<tr><td class="RProname text-start"><strong>' + obj.ProjectName + ' (' + obj.Duration + ')</strong><span class="ResumeAsignmentDetails">' + obj.Description + '</span></td><td>From ' + obj.ActualStartDate + '</td><td>' + obj.TeamSize + '</td>  <td>' + obj.RoleDescription + '</td> </tr>';

            //        //    });
            //        //    $("#tblEmployeeAssignment").html(strEmployeeAssignmentHTML);
            //        //}

            //         if (MyEmployeeResume.ProfileImage == null || MyEmployeeResume.ProfileImage == '') {
            //            $('#employeeImage').prop('src', "../../../Whizible2.0-new/dist/img/blankprofile.png");
            //        }
            //        else {
            //            $('#employeeImage').prop('src', "../../" + MyEmployeeResume.ProfileImage);

            //        }
            //        if (MyEmployeeResume.EmployeeInfo != null) {
            //            strHTML += '<h4 style="margin-top:0">' + MyEmployeeResume.EmployeeInfo.EmployeeName + '</h4><span>'+MyEmployeeResume.EmployeeInfo.Designation+'</span>';
            //            $("#employeeName").html(strHTML);

            //            var strEmployeInfoHTML = '<p style="margin-bottom:0"><label>Date of Birth : </label><span>' + MyEmployeeResume.EmployeeInfo.DOB + '</span></p><p style="margin-bottom:0"><label>Phone No : </label><span>' + MyEmployeeResume.EmployeeInfo.Phone + '</span></p><p style="margin-bottom:0"><label>Email ID : </label><span><a href="mailto:quality05@lifeline-sys.com"></a>' + MyEmployeeResume.EmployeeInfo.EmailID + '</span></p>';
            //            $("#employeeInformation").html(strEmployeInfoHTML);
            //        }
            //        if (MyEmployeeResume.EmployeeSkillslst != null && MyEmployeeResume.EmployeeSkillslst.length > 0) {

            //            var strEmployeeSkillHTML = '<tr class="bankrow"><td colspan="2">&nbsp;</td></tr>';
            //            $.each(MyEmployeeResume.EmployeeSkillslst, function (index, obj) {

            //                strEmployeeSkillHTML += '<tr><th>' + obj.Tool + '</th> <td class="text-start">Experience of '   + obj.YearsOfExperiance +' Years and '+obj.MonthsOfExperiance+' Months.</td> </tr>';

            //            });
            //            $("#tbltechnicalskills").html(strEmployeeSkillHTML);
            //        }

            //        if (MyEmployeeResume.CurrentAssignments != null && MyEmployeeResume.CurrentAssignments.length > 0) {
            //            var strEmployeeAssignmentHTML = '';

            //            $.each(MyEmployeeResume.CurrentAssignments, function (index, obj) {

            //                strEmployeeAssignmentHTML += '<tr><td class="RProname text-start"><strong>' + obj.ProjectName + ' (' + obj.Duration + ')</strong><span class="ResumeAsignmentDetails">' + obj.Description + '</span></td><td>From ' + obj.ActualStartDate + '</td><td>' + obj.TeamSize + '</td>  <td>' + obj.RoleDescription + '</td> </tr>';

            //            });
            //            $("#tblEmployeeAssignment").html(strEmployeeAssignmentHTML);
            //        }


            //        if (MyEmployeeResume.EmployeeCertificationlst != null && MyEmployeeResume.EmployeeCertificationlst.length > 0) {
            //            var strCertificationHTML = '<ul>';
            //            $.each(MyEmployeeResume.EmployeeCertificationlst, function (index, obj) {

            //                strCertificationHTML += '<li> Completed ' + obj.CertificationName + ' on '+obj.CertDate+' with score '+obj.ActualScore+' out of '+obj.TotalScore+'.It is valid upto '+ obj.CertValidDate+'.</li>';
            //                //strCertificationHTML += '<li>' + Completed + obj.CertificationName + on + obj.CertificationDate + 'with score' + obj.ActualScore + '. It is valid upto + obj.ValidUpto .' + '</li>';

            //            });
            //            strCertificationHTML += '</ul>';
            //            $("#certificationlist").html(strCertificationHTML);
            //        }

            //        if (MyEmployeeResume.EmployeeQualificationlst != null && MyEmployeeResume.EmployeeQualificationlst.length > 0) {
            //            var strQualificationHTML = '<ul>';
            //            $.each(MyEmployeeResume.EmployeeQualificationlst, function (index, obj) {

            //                // strQualificationHTML += '<li>' + Completed + obj.QualificationName + from + obj.University + ' with score ' + obj.Percentage + '</li>';
            //                strQualificationHTML += '<li>' + obj.QualificationDetails + '</li>';

            //            });
            //            strQualificationHTML += '</ul>';
            //            $("#qualificationlist").html(strQualificationHTML);
            //        }

            //        StopAjaxLoader("#bodyDelivery-Unit");
            //    },
            //    error: function (err) {
            //        console.log(err);
            //        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            //        StopAjaxLoader("#bodyDelivery-Unit");
            //    }
            //});
        }


        ///Start Filter coding

        //var filterWhereClause = "";



        function ApplyFlter() {
            var isActive = $("#chkDTFilterActive").is(":checked");
            if (isActive == false && $('#txtDTFilterGroupCode').val() == "" && $('#txtDTFilterGroupName').val() == "" && $('#txtDTFilterResourceHeadID').val() == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
            } else {

                currentFilterID = 0;
                var filter = "";
                var AllDtFilter = ["GroupCode", "GroupName", "ResourceHeadID", "Active"];
                //var isActiveFilter = $('#chkDTFilterActive').is(":checked");
                var filterWhereClause2 = GenerateDTBasicFilterQuery("DT", AllDtFilter);

                filterWhereClause = filterWhereClause2.replace(/"/g, "\'");
                filter = { UniqueID: '0', DTWhereClause: encodeURIComponent(filterWhereClause) }
                FilterApplied();

                GetDeliveryTeam(filter);
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
            //var arr = str.match(/(\([^\)]+\)|\S+|\s+)/);
            //var arr = str.match(/('.*?'|[^',\s]+[^(.*?),\s]+)(?=\s*,|\s*$)/g);
            //for (var i = 0; i < arr.length; i++) {
            //    //alert(arr[i]);
            //}

            var arrFields = currWhereClause.split(" ");

            arrFields = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);


            if (arrFields[0] == "GroupCode") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboDTFilterGroupCode", "txtDTFilterGroupCode");
            }
            if (arrFields[0] == "GroupName") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboDTFilterGroupName", "txtDTFilterGroupName");
            }
            if (arrFields[0] == "ResourceHeadID") {
                var currOpToolCategory = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                setFilterComboValue("cboDTFilterResourceHeadID", currOpToolCategory);
                setFilterComboValue("txtDTFilterResourceHeadID", currValue);
            }
            if (arrFields[0] == "Active") {

                var currOpReq = arrFields[1].toString().trim();
                var currValue1 = arrFields[2].toString().trim();

                setFilterComboValue("cboDTFilterActive", currOpReq)
                if (currValue1 == "'true'") {

                    $('#chkDTFilterActive').prop("checked", true);
                }
                else {
                    $('#chkDTFilterActive').prop("checked", false);
                }


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


            //Commented & added by mahesh on  27 july 2021
            // $("#" + ValueComboName).val(currValue);
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }
        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtDTFilterName').val("");
            }
        }
        function ClearFilterDetails(flag) {
            if ($("#cboDTFilterGroupCode").val() != "Contains") {
                setFilterComboValue("cboDTFilterGroupCode", "Contains");
            }
            if ($("#txtDTFilterGroupCode").val() != "") {
                $("#txtDTFilterGroupCode").val("");
            }
            if ($("#txtDTFilterGroupName").val() != "") {
                $("#txtDTFilterGroupName").val("");
            }
            if ($("#cboDTFilterGroupName").val() != "Contains") {
                setFilterComboValue("cboDTFilterGroupName", "Contains");
            }
            $('#txtDTFilterName').val('');
            $("#txtDTFilterResourceHeadID").val("");
            $("#chkDTFilterActive").prop('checked', false);

            //Added by Reshma chavan on 31st Dec 2022
            $("#cboDTFilterResourceHeadID").val("=");
            $("#cboDTFilterActive").val("=");
            //End of Added by Reshma chavan on 31st Dec 2022

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
            GetDTDetails(null);
            GetMyDTFilter(0);//Added By Mahesh on 22 july 2021
        });

        function GetDTDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                //   var whereClauseFormated = whereClause.replace(/'/g, "\''");
                filter = { UniqueID: '0', DTWhereClause: encodeURIComponent(whereClause) };
            }
            //console.log("whereClause", whereClause);
            //console.log("filter", filter);
            GetDeliveryTeam(filter);
        }
        //FILTER VALIDATION
        function checkFiltervalidationForDT() {
            var grpCode = $("#txtDTFilterGroupCode").val() == "" ? null : $("#txtDTFilterGroupCode").val();
            var grpName = $("#txtDTFilterGroupName").val() == "" ? null : $("#txtDTFilterGroupName").val();
            var teamHead = $("#txtDTFilterResourceHeadID").val() == "" ? null : $("#txtDTFilterResourceHeadID").val();
            var isActive = $("#chkDTFilterActive").is(":checked");
            //alert(grpCode+ ","+ grpName+","+ teamHead +","+ isActive);
            //console.log("roleId :", roleId);
            if ((grpCode == null || grpCode == 'undefined' || grpCode == ' ') && (grpName == null || grpName == 'undefined' || grpName == ' ') && (teamHead == null || teamHead == 'undefined' || teamHead == 0) && (isActive == false)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                $('#DtSavefilter').modal('hide');
            }
            else {
                $('#DtSavefilter').modal('show');
            }
        }
        function AvoidSpace(input) {
            if (/^\s/.test(input.value))
                input.value = '';
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

        function SaveDTFilterDetails() {
            var fltFilterName = $("#txtDTFilterName").val();
            if (fltFilterName == "" || fltFilterName == " ") {
                //$('#BgSavefilter').modal('show');
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name');
                //$('#BgSavefilter').modal('show')

                $("#txtDTFilterName").focus();

                //return false
            }
            //Added By Riddhesh Patil on 12-NOV-2022 
            else if (checkSpecialCharacter(fltFilterName.trim(), WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtDTFilterName").focus();

            }
            //End of Comment Added By Riddhesh Patil
            else {
                var filterExists = 0;
                //if (savedFilterName == "") {
                //    filterExists = ExistDTFilter(fltFilterName);
                //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                //    $('#DtSavefilter').modal('show');
                //}

                //if (filterExists == 0) {
                //    $("#btnSaveFilter").attr("data-bs-dismiss", "modal");
                var AllDtFilter = ["GroupCode", "GroupName", "ResourceHeadID", "Active"];
                //var isActiveFilter = 'True';/// $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GenerateDTBasicFilterQuery("DT", AllDtFilter);
                filterWhereClause = filterWhereClause2.replace(/"/g, "\'");
                //console.log('filterWhereClause');
                //console.log(filterWhereClause);

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
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            $('#DtSavefilter').modal('hide');
                            FilterApplied();
                            GetMyDTFilter(0);
                            ApplyFlter();
                            savedFilterName = fltFilterName;
                            $("#txtDTFilterName").val('');
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
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    }
                });
                //}
            }
        }
        function GetMyDTFilter(flag) {
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
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                },
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
            clearTooltip();
        }

        function ExistDTFilter(filtername) {

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
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
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
                            //var GetBGWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                            GetDTDetails();
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyDTFilter(0);
                        currentappliedfilter = 0;
                    }
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
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
                        $("#txtDTFilterName").val(currentFilterName);
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
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
        }

        //Apply saved filter
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';
        function ApplySavedFilter(FilterID, isDefault, isFromDefault) {
            //Changed  by mahesh on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {
                // var GetBGWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                GetDTDetails();
                GetMyDTFilter(isDefault);
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
                            GetDTDetails(Querytext);
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
                            GetMyDTFilter(0);
                        }
                    },
                    //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
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
                        ApplySavedFilter(FilterID, 2, true);//changes by Mahesh on 22 july 2021
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        //alertify.success('Default');
                        //FilterNotApplied();

                        ApplySavedFilter(FilterID, 3, true);//changes by Mahesh on 22 july 2021
                        alertify.success('Default Filter Is Successfully Removed!');
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        FilterNotApplied();
                    }
                    GetMyDTFilter(0);
                },
                //Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
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
                }
                //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
            });
        }
        function GenerateDTBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();
                    var strCHK = $('#chk' + module + 'Filter' + filterField[i]).is(":checked");
                    // console.log(strOp);
                    if ($('#txtDTFilterGroupCode').val() == "" || $('#txtDTFilterGroupCode').val() == undefined) {
                        var strDesc = null;
                    }
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
                        //    else if (strOp == "=" && strCHK == "true") {
                        //        alert(1);
                        //     strqtext += filterField[i]+"="+"'" + strCHK+"'";
                        //    }
                        //    else if (strOp == "<>" && strCHK == "true") {
                        //     strqtext += filterField[i]+"="+"'" + strCHK+"'";
                        //}
                        else {
                            //Commented & Added By Rutuja D. on 15 July 2021 for IssueID = 27948
                            //strqtext += filterField[i] + " ";
                            if (filterField[i] == "ResourceHeadID") {
                                //strqtext += " ISNULL(ResourceHeadID,0) "
                                strqtext += " ResourceHeadID "
                            } else {
                                strqtext += filterField[i] + " ";
                            }
                            //Commented & Added By Rutuja D. on 15 July 2021 for IssueID = 27948

                            if ($.isNumeric(strvalue) == false) {
                                // strqtext += strOp + " ''" + strvalue + "''";
                                strqtext += strOp + " ''" + strvalue + "''";

                                //  strqtext += strOp + " '" + strvalue + "'";
                            }
                            else {

                                //strqtext += strOp + " " + strvalue + "";
                                strqtext += strOp + ' "' + strvalue + '"';
                            }
                        }
                    }

                    if (strOp == "=" && strCHK == true) {
                        // alert(strqtext);
                        if (strvalue == "" || strvalue == undefined) {
                            // alert("if");
                            if (strDesc == null && strDesc == undefined && strqtext == "") {
                                //  alert("strdes");
                                strqtext += filterField[i] + " = " + '"' + strCHK + '"';
                            }
                            else {
                                // alert("sddf");
                                strqtext += " AND " + filterField[i] + " ";
                                strqtext += " = " + '"' + strCHK + '"';
                            }

                        }
                        else {
                            //  alert("lastelse");
                            strqtext += filterField[i] + "=" + '"' + strCHK + '"';
                        }
                    }
                    if (strOp == "<>" && strCHK == true) {
                        //   alert(strqtext);
                        if (strvalue == "" || strvalue == undefined) {
                            // alert("if");
                            if (strDesc == null && strDesc == undefined && strqtext == "") {
                                // alert("strdes");
                                strqtext += filterField[i] + " <> " + '"' + strCHK + '"';
                            }
                            else {
                                //  alert("sddf");
                                strqtext += " AND " + filterField[i] + " ";
                                strqtext += " <> " + '"' + strCHK + '"';
                            }

                        }
                        else {
                            // alert("lastelse");
                            strqtext += filterField[i] + "<>" + '"' + strCHK + '"';
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
        //Added By Chetan M. For Bind Filter Placeholder on 14 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }
        //End of Added By Chetan M. For Bind Filter Placeholder on 14 July 2021

        function closeFilterPanel() {
            $("#filterpanel").removeClass('show');
        }
    </script>

</body>

</html>
