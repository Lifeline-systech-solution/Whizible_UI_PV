<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_OrganizationUnit.aspx.vb" Inherits="PbNIT.RM_OrganizationUnit" %>

<!DOCTYPE html> 
<html>
     <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 

<head runat="server"> 

    <%--<meta charset="utf-8" /> 
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap.min.css?v=0" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1" />
    <link href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1" />
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
   


</head>
    
    <style type="text/css">
        .clsShowHide {
            display: none !important;
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

        /*.alertify-notifier ajs-top ajs-right {
            background-color: red !important;
        }*/

        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            /*word-break: break-all;*/
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
            border-radius: 4px; min-height:60vh;
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

        body#bodyBusiness-group {
            padding-right: 0 !important;
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

        .clsFilterHighlight {
            background: #1359a6 !important;
            color: #ffffff !important;
        }

        .editFilter {
            color: #1359a6;
            border: 1px;
            border-style: dotted;
            background: aliceblue;
        }

        .filterpanel .issfilter_actiondropdown {
            float: right;
        }

        .filterpanel .MyFiltersdropdown li span i {
            font-size: 14px;
            cursor: pointer;
            padding: 9px;
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

div#OUtblmain_wrapper {overflow: hidden;}
html, body {scroll-behavior: smooth;}
.graphcontainer canvas{/*width:30%!important;*//* width:200px!important;*/ } /*modified ruby pradip content 31-3-2023*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" >
      <%--Commented By Madhuri.K on 21-Aug-2024 For On Loader start here--%>
    <div class="" id="bodyBusiness-group"></div>
    <%--Commented By Madhuri.K on 21-Aug-2024 For On Loader end here--%>
        <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 mb-1 text-end graybg">
            <h5 class="pgtitle float-start">Organization Unit</h5>
            <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Back to Resource Configuration">Back</a>--%>
            <%--End of Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <a href="javascript:;" class="mainclearalllink" style="" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
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
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" onclick="checkFiltervalidationForOU();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFlter()">Apply</button>
                                </div>
                                <br />


                                <div class="row mb-0">
                                    <div class="col-sm-4">
                                        <label>Organization Unit Code</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboOUFilterLocationCode">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">End With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Start With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">

                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtOUFilterLocationCode", "txtOUFilterLocationCode", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Organization Unit Name</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboOUFilterLocation">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">End With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Start With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">

                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtOUFilterLocation", "txtOUFilterLocation", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>&nbsp;</label>
                                 <%--Commented & Added By Rutuja D. on 7 July 2021--%>
                                        <%--<div class="row">
                                            <div class="col-xs-12">
                                                <div class="custom_chckbox">
                                                    <%CommonFunctions.HTMLControls.DrawCheckBox("chkBgFilterIsActive", "chkBgFilterIsActive", "custom_chckbox clsCheckBox", False, , , "style='width: 30px;height:15px;'", , , , , , )%>
                                                    <label for="chkBgFilterIsActive">IsActive</label>
                                                </div>
                                            </div>


                                        </div>--%>
                                        <label>IsActive</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboOUFilterActive">
                                                    <option value="=">=</option>
                                                    <option value="<>"><></option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                 <% CommonFunctions.HTMLControls.DrawComboBox("txtOUFilterActive", "usp_Whizible2_IsComfirmed",,, "class='form-select' ",,,, ,) %>                                               
                                            </div>
                                    </div>
                                    </div>
                                    <%--End of Commented & Added By Rutuja D.--%>
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
            <table class="table table-bordered GRPtbl" style="width: 100%;" id="OUtblmain">
                <thead>
                    <tr>
                        <th class="text-center" width="150">Organization Unit Code</th>
                        <th class="text-start">Organization Unit Name</th>
                        <th class="" width="100">Is Active</th>
                    </tr>
                </thead>
                <tbody id="tblOrganizationUnit">
                </tbody>
            </table>
            <div class="clearfix"></div>
        </div>


        <div class="Resourcedetailpanel">
            <input type="hidden" id="hdnOU_OrganizationUnitIDTab" name="hdnOU_OrganizationUnitIDTab">
            <input type="hidden" id="hdnBGM_UniqueIDTab" name="hdnBGM_UniqueIDTab">
            <input type="hidden" id="hdnOU_OldMangerId" name="hdnOU_OldMangerId">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li class="nav-item"><a href="#ROUdetails" class="nav-link active" data-bs-toggle="tab">Details</a><div></div>
                    </li>
                    <li class="nav-item" onclick="ShowOUDeliveryUnits()"><a href="#ROUDelUnit" class="nav-link" data-bs-toggle="tab" id="OUDeliveryTab">Delivery Units</a><div></div>
                    </li>
                    <li class="nav-item" onclick="ShowOUManager();"><a href="#ROUMangers" class="nav-link" data-bs-toggle="tab" id="">Organization Unit Managers</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#ROUResources" data-bs-toggle="tab" class="nav-link" id="" onclick="showOUResources();">Resources</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#RBGGraph" data-bs-toggle="tab" id="" class="nav-link" onclick="ShowGraph()">By Role</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">
                    <div id="ROUdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                        </div>

                        <div class="row">
                            <div class="col-sm-4">
                                <label class="required">Organization Unit Code</label>
                                <input type='text' class='form-control' value="" id="BgDtl_BgCode" disabled />

                            </div>
                            <div class="col-sm-4">
                                <label class="required">Organization Unit Name</label>
                                <input type='text' class='form-control' value='Admin & HR & Finance' id="BgDtl_BgName" disabled />

                            </div>
                            <div class="col-sm-4">
                                <label class="dblock">&nbsp;</label>
                                <strong>Is Active :
                                    <label class="clBgDtl_BgActive text-bold" id="BgDtl_BgActive"></label>
                                </strong>
                            </div>
                        </div>

                    </div>
                    <div id="ROUDelUnit" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                        </div>
                        <table class="table table-bordered" id="tblOUDeliveryUnits">
                            <thead>
                                <tr>
                                    <th class="text-start">Delivery Unit</th>
                                    <th width="250">Delivery Unit Code</th>
                                </tr>
                            </thead>
                            <tbody id="tblOrganizationUnitDeliveryUnit">
                            </tbody>
                        </table>
                    </div>
                    <div id="ROUMangers" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button type="submit" class="btn borderbtn mr-5" id="AddROUManager" data-bs-toggle="modal" data-bs-target="#AddOUMModal" onclick="SetFlag()"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                            <button class="btn borderbtn mr-5" id="OUMDelete" onclick="DeleteOUManager()">Delete</button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                        </div>
                        <table class="table table-bordered" id="tblOUManagers">
                            <thead>
                                <tr>
                                    <th class="" width="250">Manager</th>
                                    <th width="200">Is Primary Responsible</th>
                                    <th class="text-start">Responsibilities</th>
                                    <th width="50">
                                        <div class="custom_chckbox">
                                            <input id="BGMcheck0" class="chckHead" type="checkbox">
                                            <label for="BGMcheck0"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tblOrganizationUnitManager">
                            </tbody>
                        </table>
                    </div>
                    <div id="ROUResources" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                        </div>
                        <div class="pt-1 pb-1 form-inline">

                            <div class="form-group col-sm-5 mb-0">
                                <div class="row">
                                    <label class="col-sm-4" for="email">Role Description : </label>
                                    <div class="col-sm-8">
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboBGResource", "usp_Whizible2_Sel_tbl_PM_Role_Roles ",,, "class='form-select issueselectprojects' onChange='javascript:CboOUResource_OnChange(this.value);'",,,) %>
                                    </div>
                                
                                <%--<%CommonFunctions.HTMLControls.DrawComboBox("CboOUResource", "Select  RoleID,RoleDescription From tbl_PM_Role Where IsUserGroup=0 Order By RoleDescription ",,, "class='form-control' style=width:400px' onChange='javascript:CboOUResource_OnChange(this.value);'",,, ) %>--%>
                              
                                </div>
                                
                                
                            </div>
                        </div>
                        <div class="table-responsive rsrsouter"><!--Added class by pradip-->
                        <table class="table table-bordered" id="tblOUResorces">
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
                            <tbody id="tblOrganizationResources">
                            </tbody>
                        </table>
                             </div>
                    </div>
                    <div id="RBGGraph" class="tab-pane">
                        <p class="float-start">Resources by Role</p>
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                        </div>
                        <div class="graphcontainer">
                            <div class="graphcontainerinner">
                                <canvas id="ROUChart" width="200" height="300"></canvas>
                            </div> <!--Added by pradip on 31-3-2023-->                            
                        </div>
                    </div>

                </div>
            </div>
        </div>


        <div class="clearfix"></div>
    </div>


    <!--add modal start here-->
    <div class="modal custmodal fade" id="AddOUMModal">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Organization Unit Managers</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group mb-3">
                        <div class="row">
                             <label class="required pl-0">Manager</label>
                        <%-- <% CommonFunctions.HTMLControls.DrawComboBox("CboOUManagers", "usp_Whizible2_Sel_tbl_PM_Employee_Medium",,, "class='form-control' ", True,,) %>--%>
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboOUManagers", "Select 0,'' ",,, "class='form-select'",,, True) %>
                        </div>                       
                    </div>
                    <input type="hidden" id="hdnOU_OrgManagerUniqueID" name="hdnOU_OrgManagerUniqueID">
                    <div class="form-group mb-3">
                        <div class="row">
                            <div class="custom_chckbox p-0">
                            <input id="ChkAddOUPMCheckManager" class="chcktblPr" type="checkbox">
                            <label for="ChkAddOUPMCheckManager">Is Primary Responsible</label>
                        </div>
                        </div>
                        
                    </div>
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        <button class="btn btnyellow" onclick="saveOUManagers(0)">Save</button>
                        <button class="btn btnyellow" id="btnSaveUpdateOUManage" onclick="saveOUManagers(1)">Save And Add</button>

                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Add modal end here-->
    <!--resume modal start here-->
    <%--<div class="modal custmodal fade" id="ResumeModal" aria-hidden="true" data-bs-dismiss="modal">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Resume</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="resumecontainer">
                        <div class="resumeHeader">
                            <div class="row">
                                <div class="col-xs-12 col-sm-3 text-center">
                                    <figure>
                                        <img style="margin: 0 auto; display: inline-block !important" id="employeeImage" class="img-circle img-responsive" alt="">
                                    </figure>
                                </div>

                                <div class="col-xs-12 col-sm-9">
                                    <div class="resumehdright graybg">
                                        <div class="CandidateName float-start" id="employeeName">
                                        </div>
                                        <div class="candidateContctinfo float-end" id="employeeInformation">
                                        </div>
                                        <div class="clearfix"></div>
                                        <hr style="margin: 10px 0; border-color: #ddd;" />
                                        Certification and Qualification Details
                                        <div id="certificationlist">
                                        </div>
                                        <div id="qualificationlist">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="resumebody">
                            <table class="table table-stripped table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th colspan="2" class="resumetblTitle text-start">Technical Skills</th>
                                    </tr>

                                </thead>
                                <tbody id="tbltechnicalskills">
                                </tbody>
                            </table>

                            <table class="table table-stripped table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th colspan="2" class="resumetblTitle text-start">Previous Work Experience</th>
                                    </tr>

                                </thead>
                                <tbody id="tblpreviousworkexp">
                                </tbody>
                            </table>

                            <table class="table table-stripped table-bordered" style="width: 100%; margin-bottom: 0;">
                                <thead>
                                    <tr>
                                        <th colspan="5" class="resumetblTitle text-start">Current Assignments</th>
                                    </tr>
                                    <tr class="bankrow">
                                        <td colspan="5">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <th class="text-start">Project Name</th>
                                        <th>Duration<span>(Years)</span></th>
                                        <th>Team<span>Size</span></th>
                                        <th>Role</th>
                                    </tr>
                                </thead>
                                <tbody id="tblEmployeeAssignment">
                                </tbody>
                            </table>

                            <table class="table table-stripped table-bordered" style="width: 100%; margin-bottom: 0;">
                                <thead>
                                    <tr>
                                        <th colspan="5" class="resumetblTitle text-start">Previous Assignments</th>
                                    </tr>
                                    <tr class="bankrow">
                                        <td colspan="5">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <th class="text-start">Project Name</th>
                                        <th>Duration<span>(Years)</span></th>
                                        <th>Team<span>Size</span></th>
                                        <th>Role</th>
                                        <th>Skills Utilized</th>
                                    </tr>
                                </thead>
                                <tbody id="tblEmployeePreviousAssignment">
                                </tbody>
                            </table>

                            <br />
                            <div class="text-center">
                                <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>--%>
    <!--resume modal end here-->

    <%-- filter model for save--%>
    <div class="modal custmodal OuSavefilter_filter fade" id="OuSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Save Filter As</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="OuSavefilterfilterbox" class="box-panel">

                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-end required">Filter Name :</label>
                                        <span class="col-md-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtOUFilterName", "txtOUFilterName", "form-control",, maxLength:=100) %>
                                            <div class="btnrow">
                                                <button class="btn btnyellow float-start savefilter" id="btnSaveFilter" onclick="SaveOUFilterDetails()">Save</button>
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

    <%--Delete confirmation model--%>
    <div class="modal custmodal fade" id="DeleteConfirmBGMModal" aria-hidden="true" data-bs-dismiss="modal">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="notebox">
                        <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.<br />
                        <br />
                        Are you sure, you want to delete the selected records?
                    </div>

                    <div class="text-end">
                        <button class="btn btnyellow" onclick=" DeleteOUManagerAfterConfirm()">Yes</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal">No</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <%--Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021--%>     
    <div id="deleteConfirmAlert" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-bs-dismiss="modal">
                        <div class="modal-dialog ui-draggable">
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
     <%--End of Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021--%>
    


    <!-- REQUIRED JS SCRIPTS -->
    
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
  <%--  <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>--%>
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/jquery.freezeheader.js"></script>
<%--    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>
        //Remove tooltip
        $('body').on('click', function () {
            $('.tooltip').remove();
        });

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
        var DeleteRecord = "Please select at least one record to delete.";
        function CboOUManagers_OnChange(RoleID) {
            var bgID = $("#hdnOU_OrganizationUnitIDTab").val();
            if (RoleID.length > 0) {
                GetOrganizationResouces(RoleID, bgID)
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Role Description");
            }

        }


       function cancledetailpanel()
        {  
            //Added by imran to Clear previous Chart Fill Color on 12-10-2021
             PlotRoleGraph(0, 0, 0);
            //End By imran 12-10-2021
        }

        var noOfRowsPerPage = 10;

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });


        function editOU() {

            //var strHTML = "<input type='text' class='form-control' value='Admin & HR & Finance' disabled />";
            //$("#OrganizationName").html(strHTML);
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
              
            }, 'fast');
            //used for disable grid
            $("#OUtblmain_wrapper .dataTables_scrollHead, #OUtblmain_wrapper .dataTables_scrollBody, .backbtn, .filter, .paginate_button").addClass("DisableContent").parent().css("cursor", "no-drop");
        }


        $('#tblOrganizationUnit').on('click', '.BGdetalilink', function () {

            var ref_this = $(".Resourcedetailpanel ul.tabs li a.active");
            var ref_this2 = $(".Resourcedetailpanel ul.tabs li a.active aria-expanded");

            var $row = $(this).closest("tr");
            $tds = $row.find("td");
            $.each($tds, function (index, obj) {
                var hiddenField = $(this).find("input[type='hidden']").val();
                if (hiddenField != 'undefined' && hiddenField != null) {
                    $("#hdnOU_OrganizationUnitIDTab").val(hiddenField);
                }
                if (index == 0) {
                    $('#BgDtl_BgCode').val($(this).text());

                }
                if (index == 1) {
                    $('#BgDtl_BgName').val($(this).text());
                    //$("#hdnBG_BusinessGroupIsActive").val($(this).text());
                }

                if (index == 2) {
                    $('.clBgDtl_BgActive').html($(this).text());
                    if ($(this).text() == 'No') {
                        $("#AddROUManager").addClass("clsShowHide");
                    }
                    else {
                        if (blnAddAccess == "True" && $(this).text() == "Yes") {
                            $("#AddROUManager").removeClass("clsShowHide");
                        }
                    }
                    //$("#hdnBG_BusinessGroupIsActive").val($(this).text());
                }
                //console.log($(this).text());
                // alert($(this).text());// Prints out the text within the <td>
            });

            /// $('#BgDtl_BgCode').val($("#hdnBG_BusinessGroupCode").val());
            //BgDtl_BgName

            $(this).closest('tr').addClass('rowhiglight');
            $('#OUDeliveryTab').click()

        });
        $(".OUdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });

        $('#tblOrganizationUnitManager').on('click', '.clBGEditManager', function () {
            CurrentTabObject = { Details: 'false', DelUnit: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };
            var $row = $(this).closest("tr");

            $tds = $row.find("td");
            $.each($tds, function (index, obj) {
                //var hiddenBGMManagerID = $(this).find("#hdnBGM_ManagerId").val();
                var hiddenBGMUniqueID = $(this).find("#hdnBGM_UniqueID").val();
                //$('#hdnOU_OldMangerId').val(hiddenBGMUniqueID);
                //if (hiddenBGMManagerID != 'undefined' && hiddenBGMManagerID != null) {

                //    $(".selectpicker #CboBgManager").val(hiddenBGMManagerID);
                //    //alert("hiddenBGMUniqueID" + hiddenBGMManagerID);
                //    alert($("#CboBgManager").val());
                //}
                if (hiddenBGMUniqueID != 'undefined' && hiddenBGMUniqueID != null) {
                    $("#hdnBGM_UniqueIDTab").val(hiddenBGMUniqueID);
                    //$('select[name^="CboBgManager"] option[value=' + hiddenBGMManagerID+']').attr("selected", "selected");

                }
                // $('#CboBgManager').val(hiddenBGMManagerID)
                if (index == 1) {
                    //alert($(this).text());
                }
                if (index == 2) {
                    //alert($(this).text());
                }
                $('#AddBGMModal').modal('show');
            });



        });


        $('.canceldetailpanel').click(function () {

            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#OUtblmain_wrapper .dataTables_scrollHead, #OUtblmain_wrapper .dataTables_scrollBody, .backbtn, .filter, .paginate_button").removeClass("DisableContent").parent().css("cursor", "auto");
            CurrentTabObject = { Details: 'false', DelUnit: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };

        });
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var SessionLoginType = '<%= Session("LoginType") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var TagID = '<%= m_TagId%>';
        var filterWhereClause = "";

        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;


        var CurrentTabObject = { Details: 'false', DelUnit: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };
        $(document).ready(function () {
          
            //Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
            BindPlaceholder("txtOUFilterActive", "IsActive");
            //End of Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
            
            CurrentTabObject = { Details: 'false', DelUnit: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };

            if (blnAddAccess == "False") {
                $("#AddROUManager").addClass("clsShowHide");
                $('#btnSaveUpdateOUManage').attr("disabled", true);
            }
            else {
                $("#AddROUManager").removeClass("clsShowHide");
                $('#btnSaveUpdateOUManage').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#OUMDelete").addClass("clsShowHide");
            }
            else {
                $("#OUMDelete").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {
                GetMyOUFilter(0);
                if (currentDefaultFilterID > 0) {
                    //GetMyBGFilter(1);
                    ApplySavedFilter(currentDefaultFilterID, 2);

                } else {
                    FilterNotApplied();
                    GetOrganizationUnits(null);
                }
            }
            else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";
            }
            //GetOrganizationUnits();
            //GetMyOUFilter(1);

        });



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
            $('#OUtblmain_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 170, "overflow-y": "auto" });

            //var tblheight = $(window).height();
            //$('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
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
        //$(".chcktbl").click(function () {

        //    if ($(".chcktbl").length == $(".chcktbl:checked").length) {
        //        $(".chckHead").prop("checked", true);
        //    } else {
        //        $(".chckHead").removeAttr("checked");
        //    }

        //});

        function checkUncheck() {
            //alert(123);

            // alert($(".chcktbl").length);
            if (($(".chcktbl").length) == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
            }
        }


        //Resource by Rolls chart
        //var ctx = document.getElementById("ROUChart").getContext('2d');
        //var myChart = new Chart(ctx, {
        //    type: 'pie',
        //    data: {
        //        labels: ["Aplication Administrator", "software Engineer", "Team Leader", "Finance Manager", "IT Support Executive", "Automation Role"],
        //        datasets: [{
        //            backgroundColor: [
        //                "#2ecc71",
        //                "#3498db",
        //                "#95a5a6",
        //                "#2ecc71",
        //                "#3498db",
        //                "#95a5a6"
        //            ],
        //            data: [12, 19, 3, 24, 20, 10]
        //        }]
        //    },
        //    options: {
        //        legend: {
        //            position: 'left',
        //            align: "start",
        //        }
        //    }
        //});


        function GetOrganizationUnits(OuFilterParameter) {
            var strHTML = "";
            if (OuFilterParameter == null) {
                // OuFilterParameter.ManagerID = SessionEmployeeId;
                OuFilterParameter = { UniqueID: '0', IsActive: 'false', BGWhereClause: null, ManagerID: SessionEmployeeId }
            }


            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OrganizationUnit/GetOrganizationUnitData',
                type: "POST",
                data: JSON.stringify(OuFilterParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));

                    if (OuFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OuFilterParameter) ? OuFilterParameter : JSON.stringify(OuFilterParameter)));
                    }
                },
                success: function (data) {
                    var MyOrganizationUnit = data;
                    $.each(MyOrganizationUnit, function (index, obj) {
                        var strActive = '';
                        if (obj.Active === true) {
                            strActive = 'Yes'
                        } else {
                            strActive = 'No'
                        }

                        // strHTML += '<tr><td class="text-start"><input type="hidden" name="hdnOG_OrganizationUnitId" id="hdnOG_OrganizationUnitId" value= ' + obj.LocationID + '> <a href="javascript:;" class="BGdetalilink" onclick="editOU(this);"</a>' + obj.Location + ' </td> <td> ' + obj.LocationCode + ' </td> <td>' + strActive + '</td> </tr>';
                        strHTML += '<tr><td> ' + obj.LocationCode + ' </td><td class="text-start"><input type="hidden" name="hdnOG_OrganizationUnitId" id="hdnOG_OrganizationUnitId" value= ' + obj.LocationID + '> <a href="javascript:;" class="BGdetalilink" onclick="editOU(this);"</a>' + obj.Location + ' </td> <td>' + strActive + '</td> </tr>';
                    });
                    $('#OUtblmain').dataTable().fnDestroy();
                    $("#tblOrganizationUnit").html(strHTML);
                    LoadPagination('#OUtblmain', data);
                    StopAjaxLoader("#bodyBusiness-group");
                },
                        // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
               // error: function (err) {
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

                    //alertify.set('notifier', 'position', 'top-top');
                    //alertify.notify(err);
                    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    StopAjaxLoader("#bodyBusiness-group");
                }
            })

        }


        function GetOrganizationUnitManagers(OUPoolID) {
            $(".chckHead").prop('checked', false);
            var strHTML = "";
            $("#hdnOU_OrgManagerUniqueID").val(0);
            var OuOuParameter = { OUPoolID: OUPoolID };
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OrganizationUnit/GetOrganizationUnitManagerData',
                type: "POST",
                data: JSON.stringify(OuOuParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));


                    if (OuOuParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OuOuParameter) ? OuOuParameter : JSON.stringify(OuOuParameter)));
                    }
                },
                success: function (data) {
                    var MyOrganizationUnitManager = data;
                    $.each(MyOrganizationUnitManager, function (index, obj) {
                        var strResponsible = '';
                        if (obj.IsPrimaryResponsible === true) {
                            strResponsible = 'Yes'
                        } else {

                            strResponsible = 'No'
                        }

                        if (blnEditAccess == "True") {
                            strHTML += '<tr><td><a href="javascript:;" class="clBGEditManager" data-bs-toggle="modal" data-bs-target="#AddOUMModal" onclick="GetOUManager(' + obj.UniqueID + ')">' + obj.EmployeeName + '</a><input type="hidden" name="hdnBGM_UniqueID" id="hdnBGM_UniqueID" value= ' + obj.OUPoolID + '><input type="hidden" name="hdnOUM_UniqueID" id="hdnOUM_UniqueID" value= ' + obj.UniqueID + '></td><td>' + strResponsible + '</td><td class="text-start">' + obj.Responsibilities + '</td><td><input onclick="checkUncheck()" class="chcktbl chkBGManager custom_chckbox" type="checkbox" style="width:18px; height:18px"></td></tr>';
                        }
                        else {
                            strHTML += '<tr><td><input type="hidden" name="hdnBGM_UniqueID" id="hdnBGM_UniqueID" value= ' + obj.OUPoolID + '><input type="hidden" name="hdnOUM_UniqueID" id="hdnOUM_UniqueID" value= ' + obj.UniqueID + '>' + obj.EmployeeName + '</td><td>' + strResponsible + '</td><td class="text-start">' + obj.Responsibilities + '</td><td><input onclick="checkUncheck()" class="chcktbl chkBGManager custom_chckbox" type="checkbox" style="width:18px; height:18px"></td></tr>';
                        }
                    });

                    // $('#tblOUManagers#tblOUManagers').dataTable().fnDestroy();
                    $("#tblOrganizationUnitManager").html(strHTML);
                    // LoadPagination('#tblOUManagers', data);
                    StopAjaxLoader("#bodyBusiness-group");
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyBusiness-group");
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



        function GetOrganizationResouces(RoleID, OUPoolID) {
            CurrentTabObject.Resource = 'true';
            var strHTML = "";

            var OuOuParameter = { OUPoolID: OUPoolID, RoleID: RoleID };
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OrganizationUnit/GetOrganizationResouceData',
                type: "POST",
                data: JSON.stringify(OuOuParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    
                    if (OuOuParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OuOuParameter) ? OuOuParameter : JSON.stringify(OuOuParameter)));
                    }
                },
                success: function (data) {
                    var MyOrganizationRoles = data;
                    if (data.length > 0) { // Added by Chetan M on 6 Jul 2021 for Issue Fixing
                        $.each(MyOrganizationRoles, function (index, obj) {
                            var strActive = '';


                            strHTML += '<tr><td>' + obj.EmployeeName + '</td><td>' + obj.RoleDescription + '</td><td>' + obj.Location + '</td><td>' + obj.Department + '</td><td>' + obj.EmailID + '</td><td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResumeModal" onclick="GetResourceResume(' + obj.EmployeeID + ')">' + obj.Resume + '</a></td></tr>';
                            // $("#tblBusinessGroups bodyBusiness-group").append(row);
                        });

                    }
                    // Added by Chetan M on 6 Jul 2021 for Issue Fixing
                    else {
                         strHTML += '<tr><td class="text-center" colspan="6">No data found.</td></tr>';
                    }
                    // End of Added by Chetan M on 6 Jul 2021 for Issue Fixing
                    // $('#tblOUResorces#tblOUResorces').dataTable().fnDestroy();
                    $("#tblOrganizationResources").html(strHTML);
                    //  LoadPagination('#tblOUResorces', data);
                    StopAjaxLoader("#bodyBusiness-group");
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyBusiness-group");
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

        }

        ///Resourses call
        function CboOUResource_OnChange(roleID) {
            var bgOrgID = $("#hdnOU_OrganizationUnitIDTab").val();
            if (roleID.length > 0) {
                GetOrganizationResouces(roleID, bgOrgID);
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Role Description");
            }

        }

        var bgID = $("#hdnBG_BusinessGroupIDTab").val();


        function ShowOUManager() {
            if (CurrentTabObject != null && CurrentTabObject.Manager == "false") {
                var bgOrgID = $("#hdnOU_OrganizationUnitIDTab").val();
                GetOrganizationUnitManagers(bgOrgID);
                CurrentTabObject.Manager = 'true';
            }
        }

        function showOUResources() {
            if (CurrentTabObject != null && CurrentTabObject.Resource == "false") {
                $("#CboBGResource").val('0'); // Added by Chetan M on 6 Jul 2021 for Issue Fixing
                var RoleId = $("#CboBGResource").val();
                CboOUResource_OnChange(RoleId);
                CurrentTabObject.Resource = 'true';
            }
        }

        function ShowOUDeliveryUnits() {

            if (CurrentTabObject != null && CurrentTabObject.DelUnit == "false") {
                var bgOrgID = $("#hdnOU_OrganizationUnitIDTab").val();
                GetOrganizationUnitDeliveryUnits(bgOrgID);
                CurrentTabObject.OrgUnit = 'true';
            }

        }

        function SetFlag() {
            document.getElementById("hdnOU_OrgManagerUniqueID").value = 0;
            document.getElementById("CboOUManagers").value = 0;
            //  $('#CboOUManagers').attr("disabled", false);
            // $('#btnSaveUpdateOUManage').attr("disabled", false);
            $("#ChkAddOUPMCheckManager").prop("checked", false);
            FillBGManager(0);
        }

        //New code for OU Update by Khushboo
        function saveOUManagers(isFromSaveAndclick) {
            var managerID = $("#hdnOU_OldMangerId").val();
            var newManagerID = $("#CboOUManagers").val();

            if (newManagerID > 0) {
                var uniqueID = $("#hdnOU_OrgManagerUniqueID").val();
                //var hiddenBGMUniqueID = $(this).find("#hdnBGM_UniqueID").val();

                var isPrimaryResponsible = $("#ChkAddOUPMCheckManager").is(":checked");
                //added by imran on 19-08-2022
                if (isPrimaryResponsible == "") {
                    isPrimaryResponsible = 0;
                }
                //End of comment by imran on 19-08-2022

                //var isChecked = $("#ChkAddGBPMCheckManager").is(":checked");
                var bgOrgID = $("#hdnOU_OrganizationUnitIDTab").val();
                var OU_ManagerParameters = {
                    UniqueID: uniqueID > 0 ? uniqueID : 0,
                    OrganizationUnitID: bgOrgID,
                    ManagerID: uniqueID > 0 ? managerID : newManagerID,
                    NewManagerID: newManagerID,
                    IsPrimaryResponsible: isPrimaryResponsible
                }

                $.ajax({
                    url: strUrl + '/api/RM_OrganizationUnit/SaveOUManagers',
                    type: "POST",
                    data: JSON.stringify(OU_ManagerParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));

                        if (OU_ManagerParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(OU_ManagerParameters) ? OU_ManagerParameters : JSON.stringify(OU_ManagerParameters)));
                        }
                    },
                    success: function (data) {
                        CurrentTabObject.Manager = 'false';
                        ShowOUManager();
                        CurrentTabObject.Manager = 'true';
                        //$('#AddOUMModal').modal('hide');
                        if (isFromSaveAndclick == 0) {
                            if (data == "Manager already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                // $('#CboOUManagers').val("");
                                $('#AddOUMModal').modal('show');
                            } else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                $('#AddOUMModal').modal('hide');
                            }

                        }
                        else {
                            if (data == "Manager already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);

                            }
                            else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                $('#ChkAddOUPMCheckManager').prop("checked", false);
                                $('#CboOUManagers').val("");
                            }

                        }

                        //if (isFromSaveAndclick == 1) {
                        //    $('#ChkAddOUPMCheckManager').prop("checked", false);
                        //    $('#CboOUManagers').val("");
                        //}
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.success(data);
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
                        else if (xhr.statusText == "Created") {
                            // alertify.set('notifier', 'position', 'top-right');
                            //alertify.notify(xhr.statusText + "/ updated");
                            CurrentTabObject.Manager = 'false';
                            ShowOUManager();
                            CurrentTabObject.Manager = 'true';
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        StopAjaxLoader("#bodyBusiness-group");
                        if (isFromSaveAndclick == 0) {
                            $('#AddOUMModal').modal('hide');
                        }
                    }

                })

            } else {
                //alert("DSD");
                //$('#AddBGMModal').modal('show');
                $("#CboOUManagers").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select Manager");
                //alertify.error("Please select Manager");
            }
        }
        //End of code by KHUSHBOO

        function SaveUpdateOUManager(isFromSave) {

            var uniqueID = $("#hdnOU_OrgManagerUniqueID").val();

            if (uniqueID > 0) {
                UpdateOUManager(uniqueID, isFromSave);
            } else {
                SaveOUManager(isFromSave);
            }
        }
        function SaveOUManager(isFromSave) {
            //var hiddenBGMUniqueID = $(this).find("#hdnBGM_UniqueID").val()
            var managerID = $("#hdnOU_MangerIDTab").val();
            var newManagerID = $("#CboOUManagers ").val();
            var isPrimaryResponsible = $("#ChkAddOUPMCheckManager").is(":checked");
            if (newManagerID.length > 0 && newManagerID > 0) {

                //var isChecked = $("#ChkAddGBPMCheckManager").is(":checked");
                var bgOrgID = $("#hdnOU_OrganizationUnitIDTab").val();
                var bgManagerParmas = {
                    OrganizationUnitID: bgOrgID,
                    ManagerID: managerID,
                    IsPrimaryResponsible: isPrimaryResponsible
                }
                var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
                $.ajax({
                    url: strUrl + '/api/RM_OrganizationUnit/SaveOUManager',
                    type: "POST",
                    data: JSON.stringify(bgManagerParmas),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));

                        if (bgManagerParmas) {
                            xhr.setRequestHeader("Params", encryptString(isJson(bgManagerParmas) ? bgManagerParmas : JSON.stringify(bgManagerParmas)));
                        }
                    },
                    success: function (data) {
                        CurrentTabObject.Manager = 'false';
                        ShowOUManager();
                        CurrentTabObject.Manager = 'true';
                        //$('#AddOUMModal').modal('hide');
                        if (isFromSave == 0) {
                            $('#AddOUMModal').modal('hide');
                        }
                        if (isFromSave == 1) {
                            $('#ChkAddOUPMCheckManager').prop("checked", false);
                            $('#CboOUManagers').val("");
                        }
                    },
                    //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    alertify.set('notifier', 'position', 'top-top');
                    //    alertify.error(err);
                    //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""

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
                if (isFromSave == 0) {
                    $('#AddOUMModal').modal('hide');
                }
            } else {
                //$('#AddOUMModal').modal('show');
                $("#CboOUManagers").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Manager");
            }

        }

        function UpdateOUManager(UniqueID, isFromSave) {

            //var hiddenBGMUniqueID = $(this).find("#hdnBGM_UniqueID").val();
            var managerID = $("#CboOUManagers ").val();
            var isPrimaryResponsible = $("#ChkAddOUPMCheckManager").is(":checked");

            //var isChecked = $("#ChkAddGBPMCheckManager").is(":checked");
            var bgOrgID = $("#hdnOU_OrganizationUnitIDTab").val();
            var bgManagerParmas = {
                UniqueID: UniqueID,
                ManagerID: managerID,
                IsPrimaryResponsible: isPrimaryResponsible
            }
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            $.ajax({
                url: strUrl + '/api/RM_OrganizationUnit/UpdateOUManager',
                type: "POST",
                data: JSON.stringify(bgManagerParmas),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));

                    if (bgManagerParmas) {
                        xhr.setRequestHeader("Params", encryptString(isJson(bgManagerParmas) ? bgManagerParmas : JSON.stringify(bgManagerParmas)));
                    }
                },
                success: function (data) {
                    CurrentTabObject.Manager = 'false';
                    ShowOUManager();
                    CurrentTabObject.Manager = 'true';
                    if (isFromSave == 0) {
                        $('#AddOUMModal').modal('hide');
                    }
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""

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
            if (isFromSave == 0) {
                $('#AddOUMModal').modal('hide');
            }

        }

        ///get checked values
        function GetSelectedOUResources() {
            var selectedOUUniqueId = '';
            $('#tblOrganizationUnitManager').find('tr').each(function () {
                var row = $(this);
                if (row.find('input[type="checkbox"]').is(':checked')) {
                    selectedOUUniqueId += row.find('#hdnOUM_UniqueID').val() + ',';
                }
            });
            if (selectedOUUniqueId.length > 0) {
                selectedOUUniqueId = selectedOUUniqueId.substring(0, selectedOUUniqueId.length - 1);
            }
            return selectedOUUniqueId;
        }

        function DeleteOUManager() {
            var isSelectedResource = GetSelectedOUResources();
            if (isSelectedResource.length > 0) {
                $('#DeleteConfirmBGMModal').modal('show');

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }

        function DeleteOUManagerAfterConfirm() {
            var isSelectedResource = GetSelectedOUResources();
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (isSelectedResource.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_OrganizationUnit/DeleteOUManager',
                    type: "POST",
                    data: JSON.stringify(isSelectedResource),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));

                        if (isSelectedResource) {
                            xhr.setRequestHeader("Params", encryptString(isJson(isSelectedResource) ? isSelectedResource : JSON.stringify(isSelectedResource)));
                        }
                    },
                    success: function (data) {
                        if (data != "") {
                            alertify.set('notifier', 'position', 'top-right');
                            //Commented & Added By Rutuja D. For Issue ID = 26451
                            //alertify.success(data);
                            if (data.indexOf('Primary') > -1) {
                                /*Commented and Modified By RehanC for alert colour issue on 31th Mar 2023*/
                                /* alertify.success('Manager is Primary Responsible.');*/
                                alertify.error('Manager is Primary Responsible.');
                        /*End of Comment By RehanC for alert colour issue on 31th Mar 2023*/                                
                            }
                            if (data.indexOf('Deleted') > -1) {
                                alertify.success('Record Deleted Successfully.');
                            }
                            //End of Commented & Added By Rutuja D. For Issue ID = 26451
                        }
                        StopAjaxLoader("#bodyBusiness-group");
                        CurrentTabObject.Manager = 'false';
                        ShowOUManager();
                        CurrentTabObject.Manager = 'true';
                        $('#DeleteConfirmBGMModal').modal('hide');
                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    $('#DeleteConfirmBGMModal').modal('hide');
                    //    StopAjaxLoader("#bodyBusiness-group");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        StopAjaxLoader("#bodyBusiness-group");
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }

        function ShowGraph() {

            if (CurrentTabObject.RoleGraph == "false") {
                var bgOrgID = $("#hdnOU_OrganizationUnitIDTab").val();
                GetOUResourceRoleGraph(bgOrgID);
                CurrentTabObject.RoleGraph = 'true';

            }
        }

        if (CurrentTabObject.RoleGraph == 'false') {
            function GetOUResourceRoleGraph(OrganizationUnitID) {
                CurrentTabObject.RoleGraph = 'true';
                var strHTML = "";
                var OuOuParameter = { OrganizationUnitID: OrganizationUnitID };
                StartLoader("#bodyBusiness-group");
                var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
                $.ajax({
                    url: strUrl + '/api/RM_OrganizationUnit/GetOUResourceRoleGraph',
                    type: "POST",
                    data: JSON.stringify(OuOuParameter),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));

                        if (OuOuParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(OuOuParameter) ? OuOuParameter : JSON.stringify(OuOuParameter)));
                        }
                    },
                    success: function (data) {
                        var OUResourcesGraph = data;
                        if (OUResourcesGraph.length > 0) {
                            PlotRoleGraph(OUResourcesGraph[0]['LstLabel'], OUResourcesGraph[0]['LstColor'], OUResourcesGraph[0]['LstData'])
                        } else {
                            PlotRoleGraph(0, 0, 0);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("There is no details available.");
                            StopAjaxLoader("#bodyBusiness-group");
                        }

                        StopAjaxLoader("#bodyBusiness-group");
                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    alertify.set('notifier', 'position', 'top-top');
                    //    alertify.error(err);
                    //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    StopAjaxLoader("#bodyBusiness-group");
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        StopAjaxLoader("#bodyBusiness-group");
                    },
                    // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

                })
            }
        }
        var OuChart;
        function PlotRoleGraph(LabelList, ColorList, DataList) {

            var Ouctx = document.getElementById("ROUChart").getContext('2d');
            
            if (OuChart) OuChart.destroy();
            OuChart = new Chart(Ouctx, {
                type: 'pie',
                data: {
                    labels: LabelList,
                    datasets: [{
                        backgroundColor: ColorList,
                        data: DataList
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'left',
                            align: "start",
                        }
                    }, //Added by pradip on 31-3-2023
                    
                }
            });
        }


        function GetOrganizationUnitDeliveryUnits(OUPoolID) {
            CurrentTabObject.DelUnit = 'true';
            var strHTML = "";
            var OuOuParameter = { OUPoolID: OUPoolID };
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OrganizationUnit/GetOrganizationUnitDeliveryData',
                type: "POST",
                data: JSON.stringify(OuOuParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));

                    if (OuOuParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OuOuParameter) ? OuOuParameter : JSON.stringify(OuOuParameter)));
                    }
                },
                success: function (data) {
                    var MyOrganizationUnitManager = data;
                    $.each(MyOrganizationUnitManager, function (index, obj) {

                        strHTML += '<tr><td class="text-start">' + obj.ResourcePoolName + '</td><td>' + obj.ResourcePoolCode + '</td></tr>';
                        // $("#tblBusinessGroups bodyBusiness-group").append(row);
                    });
                    // $('#tblOUDeliveryUnits#tblOUDeliveryUnits').dataTable().fnDestroy();
                    $("#tblOrganizationUnitDeliveryUnit").html(strHTML);
                    //  LoadPagination('#tblOUDeliveryUnits', data);
                    StopAjaxLoader("#bodyBusiness-group");
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyBusiness-group");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyBusiness-group");
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

        }




        function GetOUManager(UniqueID) {
            var OuOuParameter = { UniqueID: UniqueID };

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            //StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OrganizationUnit/GetOUManager',
                type: "POST",
                data: JSON.stringify(OuOuParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));

                    if (OuOuParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OuOuParameter) ? OuOuParameter : JSON.stringify(OuOuParameter)));
                    }
                },
                success: function (data) {
                    var MyOrganizationUnitManager = data;
                    document.getElementById("CboOUManagers").value = MyOrganizationUnitManager.ManagerID;
                    FillBGManager(MyOrganizationUnitManager.ManagerID);
                    document.getElementById("hdnOU_OldMangerId").value = MyOrganizationUnitManager.ManagerID;
                    // document.getElementById("ChkAddOUPMCheckManager").value = MyOrganizationUnitManager.IsPrimaryResponsible;
                    // $("#CboOUManagers").val() = MyOrganizationUnitManager.ManagerID;
                    // $("#ChkAddOUPMCheckManager").val() = MyOrganizationUnitManager.IsPrimaryResponsible;
                    document.getElementById("hdnOU_OrgManagerUniqueID").value = UniqueID;
                    //$("#hdnOU_OrgManagerUniqueID").val() = UniqueID;

                    // $("#tblOrganizationUnitDeliveryUnit").html(strHTML);
                    // $('#CboOUManagers').prop('disabled', true);
                    // $('#btnSaveUpdateOUManage').attr("disabled", true);
                    if (MyOrganizationUnitManager.IsPrimaryResponsible == true) {
                        $('#ChkAddOUPMCheckManager').prop('checked', true);
                    }
                    else {
                        $("#ChkAddOUPMCheckManager").prop("checked", false);
                    }

                },
                //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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

            })

        }

        function GetResourceResume(EmployeeID) {

            window.open('../Resources/Resume.aspx?EmployeeID=' + EmployeeID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100');
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
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(thrownError);
                    }

                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    StopAjaxLoader("#bodyGlobal-Resource");
                }
            })

        }

        function LoadPagination(tblId, data) {
            //var businessGroupTable;
            //---tblId  BGtblmain
            $.fn.DataTable.ext.pager.numbers_length = 5;
            $(tblId).dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": '100',
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
                //  "dom": '<"float-end top"p >rt<"clear">',
            });

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
                    //Comment And Added by imran on 23-02-2022 For placeholder display blank
                    //strHTML += "<option value='0'></option>";
                    strHTML += "<option value='0'> Select Manager</option>";
                    //End by imran on 23-02-2022 For placeholder display blank
                    $.each(data, function (index, obj) {
                        strHTML += ('<option value=' + obj.EmployeeID + ' >' + obj.UserName + '</option>');
                    })
                    $("#CboOUManagers").html(strHTML);
                    $("#CboOUManagers").val(EmpID);

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

            })
        }

        ///Start Filter coding


        function ApplyFlter() {
            currentFilterID = 0;
            //if ($('#txtOUFilterLocation').val() == "") {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Enter at least one filter value');
            //} else {
            var filter = "";
            //if (filterwhereclause != 'undefined' && filterwhereclause != null) {

            //Commented & Added By Rutuja D. on 7 July 2021
            //var AllBgFilter = ["LocationCode", "Location"];
            //var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
            var AllBgFilter = ["LocationCode", "Location", "Active"];
            //End of Commented & Added By Rutuja D. on 7 July 202--%>

            var filterWhereClause2 = GenerateBGBasicFilterQuery("OU", AllBgFilter);
            <%--Commented & Added By Rutuja D.--%>
            // var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
            if (filterWhereClause2 == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
            } else {
             <%--End of Commented & Added By Rutuja D.--%>
                if (filterWhereClause2 != "" && filterWhereClause2 != null && filterWhereClause2 != 'undefined') {
                    // filterWhereClause2 += "AND Active=" + ' "' + isActiveFilter + '"';
                    filterWhereClause2 += "AND ManagerID=" + ' "' + SessionEmployeeId + '"';
                } else {
                    // filterWhereClause2 += "Active=" + ' "' + isActiveFilter + '"';
                    filterWhereClause2 += "AND ManagerID=" + ' "' + SessionEmployeeId + '"';
                }
                //filterWhereClause2 += "AND Active=" + ' "' + isActiveFilter + '"';
                //filterWhereClause2 += "AND ManagerID=" + ' "' + SessionEmployeeId + '"';

                filterWhereClause = filterWhereClause2.replace(/"/g, "\'");
                //Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                //filter = { UniqueID: '0', IsActive: 'false', OUWhereClause: encodeURI(filterWhereClause), ManagerID: SessionEmployeeId }
                filter = { UniqueID: '0', IsActive: 'false', OUWhereClause: encodeURIComponent(filterWhereClause), ManagerID: SessionEmployeeId }
                //End of Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                //}

                //SaveBGFilterDetails();
                GetOrganizationUnits(filter);
                FilterApplied();
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");
                //}
            }
        }

        function GenerateBGBasicFilterQuery(module, filterField) {

            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    //cboBGFilterBgCode
                    //cboBGFilterBgName
                    //var name = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();

                    // var strOp = $('#cbo' + module + 'Filter' + filterField[i] + ' option:selected').val();
                    //alert($("#txt" + module + "Filter" + filterField[i]));
                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();
                    //Added By Chetan M on 28 July 2021 For IssueID = 29339
                    strvalue = strvalue.replace(/"/g, '""');
                    //End of Added By Chetan M on 28 July 2021 For IssueID = 29339
                    // strvalue = $("#txtBGFilterBgGroupName").val();
                    //Commented & Added By Rutuja D.
                    // if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                    if (strvalue != "" && strvalue != undefined) {
                        //End of Commented & Added By Rutuja D.

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
        //Filter valodation
        function checkFiltervalidationForOU() {
            var LocationCode = $("#txtOUFilterLocationCode").val() == "" ? null : $("#txtOUFilterLocationCode").val();
            var LocationName = $("#txtOUFilterLocation").val() == "" ? null : $("#txtOUFilterLocation").val();

            //Commented & Added By Rutuja D. on 7 July 2021
           // var isActive = $("#chkBgFilterIsActive").is(":checked");
            //if ((LocationCode == null || LocationCode == 'undefined') && (LocationName == null || LocationName == 'undefined') && (isActive == false)) {
            var isActive = $("#txtOUFilterActive").val() == "" ? null : $("#txtOUFilterActive").val();
            if ((LocationCode == null || LocationCode == 'undefined') && (LocationName == null || LocationName == 'undefined') && (isActive == null || isActive == 'undefined')) {
            //End of Commented & Added By Rutuja D. on 7 July 2021

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
                $('#OuSavefilter').modal('hide');
            }
            else {
                $('#OuSavefilter').modal('show');
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
        function SaveOUFilterDetails() {
            var fltFilterName = $("#txtOUFilterName").val();

            if (fltFilterName == "") {
                //$('#BgSavefilter').modal('show');
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                //Commented and added by imran on 23-02-2022
                //alertify.error('Please enter filtername');
                alertify.error('Please Enter Filter Name');
                //End Comment by imran on 23-02-2022
                //$('#BgSavefilter').modal('show')

                $("#txtOUFilterName").focus();

                //return false
            }
            //Added By Riddhesh Patil on 12-NOV-2022 
            else if (checkSpecialCharacter(fltFilterName.trim(), WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtOUFilterName").focus();

            }
			//End of Comment Added By Riddhesh Patil
            else {
                var filterExists = 0;
                // if (savedFilterName == "") {
                //   filterExists = ExistOUFilter(fltFilterName);
                //$("#btnSaveFilter").removeAttr("data-bs-dismiss");
                //$('#OuSavefilter').modal('show');
                // }
                //alert(currentFilterID);
                //if (filterExists == 0) {
                // $("#btnSaveFilter").attr("data-bs-dismiss", "modal");

                //Commented & Added By Rutuja D. on 7 July 2021
                //var AllBgFilter = ["LocationCode", "Location"];
                //var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
                var AllBgFilter = ["LocationCode", "Location", "Active"];
                //End of Commented & Added By Rutuja D. on 7 July 2021

                var filterWhereClause;
                var filterWhereClause2 = GenerateBGBasicFilterQuery("OU", AllBgFilter);
                // var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
                //filterWhereClause2 += "AND Active=" + ' "' + isActiveFilter + '"';
                //filterWhereClause2 += "AND ManagerID=" + ' "' + SessionEmployeeId + '"';
                if (filterWhereClause2 != "" && filterWhereClause2 != null && filterWhereClause2 != 'undefined') {
                    //filterWhereClause2 += "AND Active=" + ' "' + isActiveFilter + '"';
                    filterWhereClause2 += "AND ManagerID=" + ' "' + SessionEmployeeId + '"';
                } else {
                    // filterWhereClause2 += "Active=" + ' "' + isActiveFilter + '"';
                    filterWhereClause2 += "AND ManagerID=" + ' "' + SessionEmployeeId + '"';
                }
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

                            $('#OuSavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            // ApplySavedFilter(currentFilterID, 2);
                            ApplyFlter();
                            FilterApplied();
                            GetMyOUFilter(0);
                            savedFilterName = fltFilterName;
                            $("#txtOUFilterName").val('');
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

        function ExistOUFilter(filtername) {

            var isFilterExists = 0;
            var Parameters = {
                FilterName: encodeURI(currentFilterID),
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

        function FilterApplied() {
            $(".mainclearalllink").removeClass("clsShowHide");
            $(".filter >  button").addClass("clsFilterHighlight");
        }

        function FilterNotApplied() {
            $(".mainclearalllink").addClass("clsShowHide");
            $(".filter >  button").removeClass("clsFilterHighlight");
            $('#AdvanceFilterIcon').attr("aria-expanded", false);
        }

        function GetMyOUFilter(flag) {
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
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id,3);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3)></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021
                            }
                            else {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;)></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021
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

        //Apply saved filter
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';
        function ApplySavedFilter(FilterID, isDefault, isFromDefault) {
            //Changed  by mahesh on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            } if (isDefault == 3) {
                var GetOUWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                GetOUDetails(GetOUWitManager);
                GetMyOUFilter(isDefault);
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
                            GetOUDetails(Querytext);
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
                        if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                            GetMyOUFilter(0);
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

        function GetOUDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                // var whereClauseFormated = whereClause.replace(/'/g, "\''");
                //Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                //filter = { UniqueID: '0', IsActive: 'true', OUWhereClause: encodeURI(whereClause), ManagerID: SessionEmployeeId }
                filter = { UniqueID: '0', IsActive: 'true', OUWhereClause: encodeURIComponent(whereClause), ManagerID: SessionEmployeeId }
                //End of Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
            }
            GetOrganizationUnits(filter);
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
                            var GetOUWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                            GetOUDetails(GetOUWitManager);
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyOUFilter(0);
                        currentappliedfilter = 0;
                    }
                },
                //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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
                        $("#txtOUFilterName").val(currentFilterName);
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
                        ApplySavedFilter(FilterID, 2, true);//Changed  by mahesh on 21 july 2021 
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        //alertify.success('Default');

                        ApplySavedFilter(FilterID, 3, true);//Changed  by mahesh on 21 july 2021 
                        alertify.success('Default Filter Is Successfully Removed!');

                        currentappliedfilter = 0;

                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        FilterNotApplied();

                    }
                    GetMyOUFilter(0);
                },
                //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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
            if (arrFields[0] == "Location") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboOUFilterLocation", "txtOUFilterLocation");
            }
            if (arrFields[0] == "LocationCode") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboOUFilterLocationCode", "txtOUFilterLocationCode");
            }
            //Added By Rutuja D. on 7 July 2021
            if (arrFields[0] == "Active") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboOUFilterActive", "txtOUFilterActive");
                 if (arrFields[1] == "=") {
                    setFilterComboValue("cboOUFilterActive", "=");
                }
                if (arrFields[1] == "<>") {
                    setFilterComboValue("cboOUFilterActive", "<>");
                }
            }
            //End of Added By Rutuja D. on 7 July 2021
            if (arrFields[0] == "Active=") {
                //if (arrFields[1] == "'true'" && currWhereClause.indexOf("'") != -1 && currWhereClause.indexOf("'") != -1)
                if (arrFields[1] == "'true'") {
                    $('#chkBgFilterIsActive').prop('checked', true);

                } else {
                    $('#chkBgFilterIsActive').prop('checked', false);
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

            //$("#" + ValueComboName).val(currValue);
             //Commented & added by mahesh on  27 july 2021
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }
        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtOUFilterName').val("");
            }
        }
        function ClearFilterDetails(flag) {
            if ($("#cboOUFilterLocation").val() != "Contains") {
                setFilterComboValue("cboOUFilterLocation", "Contains");
            }
            if ($("#txtOUFilterLocation").val() != "") {
                $("#txtOUFilterLocation").val("");
            }
            if ($("#txtOUFilterLocationCode").val() != "") {
                $("#txtOUFilterLocationCode").val("");
            }
            //Added By Reshma Chavan on 31st jan 2022
            if ($("#cboOUFilterLocationCode").val() != "Contains") {
                 setFilterComboValue("cboOUFilterLocationCode", "Contains");
            }
            //End of Added By Reshma Chavan on 31st jan 2022
            $('#txtOUFilterName').val('');
            savedFilterName = "";

            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {

                    $(this).removeAttr("checked");
                });
            }

            //Added By Rutuja D, on 7 July 2021
            $('#cboOUFilterActive').val('=');
            $('#txtOUFilterActive').val('');
            //End of Added By Rutuja D, on 7 July 2021
            

            //if (flag == "") {
            //    if ($("#tabpresetfilter").hasclass("active")) {
            //        $("#tabpresetfilter").removeclass("active");
            //    }
            //    if ($("#presetfilter").hasclass("active")) {
            //        $("#presetfilter").removeclass("active");
            //    }
            //    $(".filter").removeclass("active");
            //    if ($('.filterpanel').hasclass("in")) {
            //        $('.filterpanel').removeclass("in");
            //    }
            //}
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
            if ($('.filterpanel').hasClass("show")) {
                $('.filterpanel').removeClass("show");
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
            GetOrganizationUnits(null);
            GetMyOUFilter(0);//Added By Mahesh on 21 JUly 2021
        });

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

        //Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }
        //End of Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021


    </script>

</body>
</html>
