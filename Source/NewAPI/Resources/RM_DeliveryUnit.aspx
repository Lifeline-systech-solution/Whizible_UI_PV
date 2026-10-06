<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_DeliveryUnit.aspx.vb" Inherits="PbNIT.RM_DeliveryUnit" %>

<!DOCTYPE html> 
 
<html>
      <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head runat="server"> 

 <%--   <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalablchcktble=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
   <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
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
        }

        .alertify-notifier ajs-top ajs-right {
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

        body#bodyBusiness-group {
            padding-right: 0 !important;
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
        /*Added by pradip on 6-7-2021*/
        .rsrsouter{ max-height:55vh;}
        .rsrsouter thead th{ position:sticky; top:0;}/*End Added by pradip on 6-7-2021*/

        .graphcontainerinner canvas{width:30%;}

    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" >
    <%--  /*Added & Commented By Madhuri.K On 22-Aug-2024 For Loader Issues*/--%>
    <div class="" id="bodyBusiness-group"></div>
        <div class="bgwhite clearfix">
        <div class="container-fluid pt-1 pb-1 mb-0 text-end graybg" style="display:table">
            <h5 class="pgtitle float-start">Delivery Unit</h5>
            <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Back To Resource Configuration">Back</a>--%>
            <%--End of Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <a href="javascript:;" class="mainclearalllink" onclick="closeFilterPanel()" style="" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
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
                                <%-- <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="project2" type="checkbox" name="project2" onchange="cbChange(this)" data-original-title="" title=""> <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="project2" class="radiotextsty filtername">Project 2 and 3</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproOne" type="checkbox" name="">
                                            <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproOne" data-original-title="Apply filter"></label>
                                        </div> <span class="edit_filter"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                    </div>
                                </li>
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="task" type="checkbox" name="task" onchange="cbChange(this)" data-original-title="" title=""> <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="task" class="radiotextsty">Task and milestones</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproTwo" type="checkbox" name="">
                                            <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproTwo" data-original-title="Apply filter"></label>
                                        </div> <span class="edit_filter"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                    </div>
                                </li>
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="groupcompany" type="checkbox" name="groupcompany" onchange="cbChange(this)" data-original-title="" title=""> <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="groupcompany" class="radiotextsty">For group company</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproThree" type="checkbox" name="">
                                            <label data-bs-container="body" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" for="IssueselproThree" data-original-title="Apply filter"></label>
                                        </div> <span class="edit_filter"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                    </div>
                                </li>--%>
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
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" onclick="checkFiltervalidationForDU();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFlter()">Apply</button>
                                </div>
                                <br />

                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Delivery Unit Code</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboDUFilterResourcePoolCode">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">Ends With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Starts With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtDUFilterResourcePoolCode", "txtDUFilterResourcePoolCode", "form-control", ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Delivery Unit Name</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboDUFilterResourcePoolName">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">Ends With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Starts With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtDUFilterResourcePoolName", "txtDUFilterResourcePoolName", "form-control", ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
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
                                                <select class="form-control input-sm" id="cboDUFilterActive">
                                                    <option value="=">=</option>
                                                    <option value="<>"><></option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                 <% CommonFunctions.HTMLControls.DrawComboBox("txtDUFilterActive", "usp_Whizible2_IsComfirmed",,, "class='form-control' ",,,, ,) %>                                               
                                            </div>
                                    </div>
                                    
                                    <%--End of Commented & Added By Rutuja D.--%>
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

        <div class="content pt-1 pb-0 mt-2"><!--Added class by pradip on 9-7-21-->
            <table class="table table-bordered GRPtbl" style="width: 100%;" id="DUtblmain">
                <thead>
                    <tr>
                        <th class="text-start" width="200">Delivery Unit Code</th>
                        <th class="text-start">Delivery Unit Name</th>
                        <th class="" width="100">Is Active</th>
                    </tr>
                </thead>
                <tbody id="tblDeliveryUnit">
                </tbody>
            </table>
        </div>


        <div class="Resourcedetailpanel">
            <input type="hidden" id="hdnDU_DeliveryUnitIDTab" name="hdnDU_DeliveryUnitIDTabo">
            <input type="hidden" id="hdnDUM_UniqueIDTab" name="hdnDUM_UniqueIDTab">
            <input type="hidden" id="hdnDU_OldMangerId" name="hdnDU_OldMangerId">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li><a href="#RDUdetails" class="active" data-bs-toggle="tab" id="DUDeliveryTeamsDetails">Details</a><div></div>
                    </li>
                    <li class=""><a href="#RDUDelTerms" data-bs-toggle="tab" id="DUDeliveryTeamsTab" onclick="ShowDUDeliveryTeams()">Delivery Teams</a><div></div>
                    </li>
                    <li class=""><a href="#RDUMangers" data-bs-toggle="tab" id="" onclick="ShowDUManager()">Delivery Unit Managers</a><div></div>
                    </li>
                    <li class=""><a href="#RDUResources" data-bs-toggle="tab" id="" onclick="showDUResources();">Resources</a><div></div>
                    </li>
                    <li class=""><a href="#RDUGraph" data-bs-toggle="tab" id="" onclick="ShowGraph()">By Role</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">

                    <div id="RDUdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                        </div>

                        <div class="row">
                            <div class="col-sm-4">
                                <label class="required">Delivery Unit Code</label>
                                <input type="text" class="form-control" value="Admin & HR & Finance" id="DuDtl_DuCode" disabled />
                            </div>
                            <div class="col-sm-4">
                                <label class="required">Delivery Unit Name</label>

                                <input type="text" class="form-control" value="Dev Unit" id="DuDtl_DuName" disabled />
                            </div>
                            <div class="col-sm-4">
                                <label class="dblock">&nbsp;</label>
                                <strong>Is Active :
                                    <label class="ClDuDtl_DuActive text-bold" id="DuDtl_DuActive"></label>
                                </strong>
                            </div>
                        </div>

                    </div>
                    <div id="RDUDelTerms" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                        </div>
                        <!--removed div by pradip on 9-7-21-->  
                        <table class="table table-bordered Detilsubgridtbl" style="width:100%;" id="MaintblDUDeliveyTeams"><!--added class by pradip on 9-7-21-->
                                <thead>
                                    <tr>
                                        <%-- Commented and added by Chetan M on 6 Jul 2021 for Issue Fixing --%>
                                        <%--<th class="text-start">Delivery Team Name</th>
                                        <th class="text-start">Delivery Team Head</th>--%>
                                        <th width="250">Delivery Team Code</th>
                                        <th class="text-start">Delivery Team Name</th>
                                        <th class="text-start">Delivery Team Head</th>
                                        <%--End of Commented and added by Chetan M on 6 Jul 2021 for Issue Fixing --%>
                                    </tr>
                                </thead>
                                <tbody id="tblDUDeliveyTeams">
                                </tbody>
                            </table>
                       
                    </div>
                    <div id="RDUMangers" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button type="submit" class="btn borderbtn mr-5" id="AddRDUManager" data-bs-toggle="modal" data-bs-target="#AddDUMModal" onclick="SetFlag()"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                            <button class="btn borderbtn mr-5" id="DUMDelete" onclick="DeleteDUManager()">Delete</button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                        </div>
                        <!--removed div by pradip on 9-7-21-->
                        <table class="table table-bordered Detilsubgridtbl" style="width:100%;" id="MaintblDUManagers"><!--added class by pradip on 9-7-21-->
                                <thead>
                                    <tr>
                                        <th class="" width="150">Manager</th>
                                        <th width="170">Is Primary Responsible</th>
                                        <th class="text-start">Responsibilities</th>
                                        <th width="50">
                                            <div class="custom_chckbox">
                                                <input id="DUMcheck0" class="chckHead" type="checkbox">
                                                <label for="DUMcheck0"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="tblDUManagers">
                                </tbody>
                            </table>
                    </div>
                    <div id="RDUResources" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                        </div>
                        <div class="pt-1 pb-1 form-inline">
                            <div class="form-group">
                                <label for="email">Role Description : </label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("CboDUResource", "usp_Whizible2_Sel_tbl_PM_Role_Roles ",,, "class='form-control issueselectprojects' onChange='javascript:CboDUResource_OnChange(this.value);'",,,) %>
                            </div>
                        </div>
                         <%--<div style="min-height: 350px; height: 140px; overflow-y: auto">--%>
                      <!--removed div by pradip on 9-7-21-->
                        
                        <table class="table table-bordered Detilsubgridtbl" style="width:100%;" id="MaintblDeliveryResources"><!--added class by pradip on 9-7-21-->
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
                                <tbody id="tblDeliveryResources">
                                </tbody>
                            </table>
                       
                    </div>
                    <div id="RDUGraph" class="tab-pane">
                        <p class="float-start">Resources by Roles</p>
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                        </div>
                        <div class="graphcontainer">
                            <div class="graphcontainerinner">
<canvas id="RDuChart" width="200" height="200"></canvas>
                            </div>
                            
                        </div>
                    </div>

                </div>
        </div>
    </div>


    <div class="clearfix"></div>
    </div>

    <!--resume modal start here-->
    <%--<div class="modal custmodal fade" id="ResumeModal" aria-hidden="true" data-dismiss="modal">
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
                                        <img style="margin:0 auto;display: inline-block !important"  id="employeeImage" class="img-circle img-responsive" alt="">
                                    </figure>
                                </div>

                                <div class="col-xs-12 col-sm-9">
                                    <div class="resumehdright graybg">
                                        <div class="CandidateName float-start"  id="employeeName">
                                           
                                        </div>
                                        <div class="candidateContctinfo float-end" id="employeeInformation">
                                            
                                        </div>
                                        <div class="clearfix"></div>
                                        <hr style="margin:10px 0; border-color:#ddd;" />
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
                            <table class="table table-stripped table-bordered" style="width:100%;">
                                <thead>
                                    <tr>
                                        <th colspan="2" class="resumetblTitle text-start">Technical Skills</th>
                                    </tr>

                                </thead>
                                <tbody id="tbltechnicalskills">
                                   
                                  
                                </tbody>
                            </table>

                            <table class="table table-stripped table-bordered" style="width:100%; margin-bottom:0;">
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
    <!--add modal start here-->
    <div class="modal custmodal fade" id="AddDUMModal" aria-hidden="true" data-dismiss="modal">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delivery Unit Managers</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="required">Manager</label>
                        <%-- <% CommonFunctions.HTMLControls.DrawComboBox("CboDUManagers", "usp_Whizible2_Sel_tbl_PM_Employee_Medium",,, "class='form-control' ", True,,) %>--%>
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboDUManagers", "Select 0,'' ",,, "class='form-control'",,, True) %>
                    </div>
                    <input type="hidden" id="hdnDU_ManagerUniqueID" name="hdnDU_ManagerUniqueID">
                    <div class="form-group">
                        <div class="custom_chckbox">
                            <input id="ChkAddDUPMCheckManager" class="chcktblPr" type="checkbox">
                            <label for="ChkAddDUPMCheckManager">Is Primary Responsible</label>
                        </div>
                    </div>
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        <%-- <button class="btn btnyellow"  onclick="SaveUpdateDUManager(0)">Save</button>
                        <button class="btn btnyellow"  id="btnSaveUpdateDUManage" onclick="SaveUpdateDUManager(1)">Save And Add</button>--%>
                        <button class="btn btnyellow" onclick="saveDUManagers(0)">Save</button>
                        <button class="btn btnyellow" id="btnSaveUpdateDUManage" onclick="saveDUManagers(1)">Save And Add</button>

                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Add modal end here-->

    <%-- filter model for save--%>
    <div class="modal custmodal BgSavefilter_filter fade" id="BgSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Save Filter As</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="BgSavefilterfilterbox" class="box-panel">

                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-end required">Filter Name :</label>
                                        <span class="col-md-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtBGFilterName", "txtBGFilterName", "form-control",, maxLength:=100, ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtBGFilterName", "txtBGFilterName", "form-control",,,,,, ,,,,,,, True,,,,) %>--%>
                                            <div class="btnrow">
                                                <button class="btn btnyellow float-start savefilter" id="btnSaveFilter" onclick="SaveBGFilterDetails()">Save</button>
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
    <div class="modal custmodal fade" id="DeleteConfirmDUMModal" aria-hidden="true" data-dismiss="modal">
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
                        <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.<br />
                    <br />
                        Are you sure, you want to delete the selected records?
                    </div>

                    <div class="text-end">
                        <button class="btn btnyellow" onclick=" DeleteDUManagerAfterConfirm()">Yes</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal">No</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

     <%--Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021--%>     
    <div id="deleteConfirmAlert" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-dismiss="modal">
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
     <%--End of Commented & Added By Rutuja D. For Filter Delete Issue on on 7 July 2021--%>
    

    <!-- REQUIRED JS SCRIPTS -->
 <%--   <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
   <%-- <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script> 
<%--    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>

        //Added By Madhuri.K for Remove tooltip 
        $('body').on('click', function () {
            $('.tooltip').remove();
        });

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


        //Added By Riddhesh Patil on 10-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil

        var DeleteRecord = "Please select at least one record to delete.";
        var CurrentTabObject = { Details: 'false', DelTeam: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };
        var noOfRowsPerPage = 10;
        var NoDataFound = "No data found.";

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        function editDU(Ou) {

            if (Ou == "No") {
                $("#AddRDUManager").addClass("clsShowHide");
            }
            else {
                if (blnAddAccess == "True" && $(this).text() == "Yes") {
                    $("#AddRDUManager").removeClass("clsShowHide");
                }

            }
            $(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'fast');
            //used for disable grid
            $("#DUtblmain_wrapper .dataTables_scrollBody, .backbtn, .filter, .paginate_button, .dataTable").addClass("DisableContent").parent().css("cursor", "no-drop");
        }


        $('#tblDeliveryUnit').on('click', '.DUdetalilink', function () {
            CurrentTabObject = { Details: 'false', DelTeam: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };
            var $row = $(this).closest("tr");
            $tds = $row.find("td");
            $.each($tds, function (index, obj) {

                var hiddenField = $(this).find("input[type='hidden']").val();
                if (hiddenField != 'undefined' && hiddenField != null) {
                    $("#hdnDU_DeliveryUnitIDTab").val(hiddenField);
                }



                if (index == 0) {
                    $('#DuDtl_DuCode').val($(this).text());

                }
                if (index == 1) {

                    $('#DuDtl_DuName').val($(this).text());

                }
                if (index == 2) {
                    $('.ClDuDtl_DuActive').html($(this).text());

                }

            });



            $(this).closest('tr').addClass('rowhiglight');
            $('#DUDeliveryTeamsDetails').click()

        });

        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtBGFilterName').val("");
            }
        }

        function cancledetailpanel()
        {
            $("#AddRDUManager").removeClass("clsShowHide");
            //Added by imran to Clear previous Chart Fill Color on 12-10-2021
             PlotRoleGraph(0, 0, 0);
            //End By imran 12-10-2021
        }


        function SetFlag() {
            document.getElementById("hdnDU_ManagerUniqueID").value = 0;
            document.getElementById("CboDUManagers").value = 0;
            $('#CboDUManagers').attr("disabled", false);
            $('#btnSaveUpdateDUManage').attr("disabled", false);
            $("#ChkAddDUPMCheckManager").prop("checked", false);
            FillBGManager(0);
        }

        //$(".DUdetalilink").click(function () {
        //    $(this).closest('tr').addClass('rowhiglight');
        //});


        $('#tblDUManagers').on('click', '.clDUEditManager', function () {
            CurrentTabObject = { Details: 'false', DelTeam: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };
            var $row = $(this).closest("tr");
            $tds = $row.find("td");
            $.each($tds, function (index, obj) {

                var hiddenDUMUniqueID = $(this).find("#hdnDUM_UniqueID").val();

                if (hiddenDUMUniqueID != 'undefined' && hiddenDUMUniqueID != null) {
                    $("#hdnDUM_UniqueIDTab").val(hiddenDUMUniqueID);

                }

                $('#AddBGMModal').modal('show');
            });



        });

        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#DUtblmain_wrapper .dataTables_scrollBody, .backbtn, .filter, .paginate_button, .dataTable").removeClass("DisableContent").parent().css("cursor", "auto");
            CurrentTabObject = { Details: 'false', DelTeam: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };
        });
        var NoDataFound = "No data found.";
        var DeleteRecord = "Please select at least one record to delete.";
        var DeleteConfirm = "Are you sure, you want to delete the selected records?";

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
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
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';

        $(document).ready(function () {
            CurrentTabObject = { Details: 'false', DelTeam: 'false', Manager: 'false', Resource: 'false', RoleGraph: 'false' };
            // GetDeliveryUnits();
            //Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
            BindPlaceholder("txtDUFilterActive", "IsActive");
            //End of Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
            if (blnAddAccess == "False") {
                $("#AddRDUManager").addClass("clsShowHide");
                $('#btnSaveUpdateDUManage').attr("disabled", true);

            }
            else {
                $("#AddRDUManager").removeClass("clsShowHide");
                $('#btnSaveUpdateDUManage').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#DUMDelete").addClass("clsShowHide");
            }
            else {
                $("#DUMDelete").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {
                GetMaximumItemsToShowInList();
                GetMyDUFilter(0);
                if (currentDefaultFilterID > 0) {
                    //GetMyBGFilter(1);
                    ApplySavedFilter(currentDefaultFilterID, 2);

                } else {
                    GetDeliveryUnits(null);
                    FilterNotApplied();
                }

            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";
            }


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

//$('.Detilsubgridtbl').dataTable({
//            //"ajax": '/api/data',
//            "scrollY": '40vh',
//            "scrollX": true,
//            //"scroller": true,
//            "pageLength": 5,
//            //"paging": false,
//            "lengthChange": false,
//            "bFilter": false,
//            "ordering": false,
//            "responsive": true,
//            "destroy": false,
//            "retrieve": true,
//            "responsive": true
//            //"scrollable":true,
//            //"scrollCollapse": true
//        });

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        function resizeSection() {
            var tblheight = $(window).height();
           $('#DUtblmain_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 170, "overflow-y": "auto" });

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
            if (($(".chcktbl").length) == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
            }
        }

        //$(".chckHead").change(function () {
        //    var allPages = $("#MaintblDUManagers").dataTable().fnGetNodes();
        //    if (allPages.length > 0) {
        //        var checked = $(this).is(':checked');
        //        if (checked) {
        //            $('input[type="checkbox"]', allPages).prop('checked', true);
        //        } else {
        //            $('input[type="checkbox"]', allPages).prop('checked', false);
        //        }
        //    }
        //});
        //Resource by Rolls chart
        //var ctx = document.getElementById("RDuChart").getContext('2d');
        //var myChart = new Chart(ctx, {
        //    type: 'pie',
        //    data: {
        //        labels: ["Sales Executive", "Test Engineer", "Automation Role"],
        //        datasets: [{
        //            backgroundColor: [
        //                "#2ecc71",
        //                "#3498db",
        //                "#95a5a6"
        //            ],
        //            data: [12, 19, 3]
        //        }]
        //    },
        //    options: {
        //        legend: {
        //            position: 'left',
        //            align: "start",
        //        }
        //    }
        //});


        ///Resourses call
        function CboDUResource_OnChange(roleID) {
            var duID = $("#hdnDU_DeliveryUnitIDTab").val();
            if (roleID.length > 0) {
                GetDUResouces(roleID, duID);
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Role Description");
            }

        }
        //New code for DU Update by Shital
        function saveDUManagers(isFromSaveAndclick) {
            var managerID = $("#hdnDU_OldMangerId").val();
            var newManagerID = $("#CboDUManagers ").val();
            if (newManagerID > 0) {
                var uniqueID = $("#hdnDU_ManagerUniqueID").val();
                //var hiddenBGMUniqueID = $(this).find("#hdnBGM_UniqueID").val();

                var isPrimaryResponsible = $("#ChkAddDUPMCheckManager").is(":checked");
                //Added by imran on 19-08-2022
                if (isPrimaryResponsible == "") {
                    isPrimaryResponsible = 0;
                }
                //End of comment by imran on 19-08-2022

                //var isChecked = $("#ChkAddGBPMCheckManager").is(":checked");
                var duID = $("#hdnDU_DeliveryUnitIDTab").val();
                var DU_ManagerParameters = {
                    UniqueID: uniqueID > 0 ? uniqueID : 0,
                    ResourcePoolID: duID,
                    ManagerID: uniqueID > 0 ? managerID : newManagerID,
                    NewManagerID: newManagerID,
                    IsPrimaryResponsible: isPrimaryResponsible
                }

                $.ajax({
                    url: strUrl + '/api/RM_DeliveryUnit/SaveDUManagers',
                    type: "POST",
                    data: JSON.stringify(DU_ManagerParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (DU_ManagerParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(DU_ManagerParameters) ? DU_ManagerParameters : JSON.stringify(DU_ManagerParameters)));
                        }
                    },
                    success: function (data) {
                        //console.log(data);
                        CurrentTabObject.Manager = 'false';
                        ShowDUManager();
                        CurrentTabObject.Manager = 'true';
                        if (isFromSaveAndclick == 0) {
                            if (data == "Manager already exist") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                // $('#CboDUManagers').val("");
                                $('#AddDUMModal').modal('show');
                            } else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                $('#AddDUMModal').modal('hide');
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
                                $('#CboDUManagers').val("");
                                $("#ChkAddDUPMCheckManager").prop("checked", false);
                            }

                        }
                        //if (isFromSaveAndclick == 1) {
                        //    $('#CboDUManagers').val("");
                        //    $("#ChkAddDUPMCheckManager").prop("checked", false);
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
                            ShowDUManager();
                            CurrentTabObject.Manager = 'true';
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        StopAjaxLoader("#bodyBusiness-group");
                        if (isFromSaveAndclick == 0) {
                            $('#AddDUMModal').modal('hide');
                        }
                    }

                })

            } else {
                //alert("DSD");
                //$('#AddBGMModal').modal('show');
                $("#CboDUManagers").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select Manager");
                //alertify.error("Please select Manager");
            }
        }
        //End of code by shital

        function SaveUpdateDUManager(isFromSave) {

            var uniqueID = $("#hdnDU_ManagerUniqueID").val();

            if (uniqueID > 0) {
                UpdateDUManager(uniqueID, isFromSave);
            } else {
                SaveDUManager(isFromSave);
            }
        }

        function SaveDUManager(isFromSave) {

            var managerID = $("#CboDUManagers ").val();
            var isPrimaryResponsible = $("#ChkAddDUPMCheckManager").is(":checked");

            if (managerID > 0 && managerID != "null") {
                var duID = $("#hdnDU_DeliveryUnitIDTab").val();
                var DU_ManagerParameters = {
                    ResourcePoolID: duID,
                    ManagerID: managerID,
                    IsPrimaryResponsible: isPrimaryResponsible
                }
                var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
                $.ajax({
                    url: strUrl + '/api/RM_DeliveryUnit/SaveDUManager',
                    type: "POST",
                    data: JSON.stringify(DU_ManagerParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (DU_ManagerParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(DU_ManagerParameters) ? DU_ManagerParameters : JSON.stringify(DU_ManagerParameters)));
                        }
                    },
                    success: function (data) {
                        CurrentTabObject.Manager = 'false';
                        ShowDUManager();
                        CurrentTabObject.Manager = 'true';
                        if (isFromSave == 0) {
                            $('#AddDUMModal').modal('hide');
                        }
                        if (isFromSave == 1) {
                            $('#CboDUManagers').val("");
                            $("#ChkAddDUPMCheckManager").prop("checked", false);
                        }
                        if (data == "Manager already exist.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);

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
                    $('#AddDUMModal').modal('hide');
                }
            }
            else {
                //$('#AddOUMModal').modal('show');
                $("#CboDUManagers").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Manager");
            }
        }

        function UpdateDUManager(UniqueID, isFromSave) {

            var managerID = $("#CboDUManagers ").val();
            var isPrimaryResponsible = $("#ChkAddDUPMCheckManager").is(":checked");

            var DU_ManagerParameters = {
                UniqueID: UniqueID,
                ManagerID: managerID,
                IsPrimaryResponsible: isPrimaryResponsible
            }
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (managerID > 0 && managerID != "null") {
                $.ajax({
                    url: strUrl + '/api/RM_DeliveryUnit/UpdateDUManager',
                    type: "POST",
                    data: JSON.stringify(DU_ManagerParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (DU_ManagerParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(DU_ManagerParameters) ? DU_ManagerParameters : JSON.stringify(DU_ManagerParameters)));
                        }
                    },
                    success: function (data) {
                        CurrentTabObject.Manager = 'false';
                        ShowDUManager();
                        CurrentTabObject.Manager = 'true';
                        if (isFromSave == 0) {
                            $('#AddDUMModal').modal('hide');
                        }
                        if (isFromSave == 1) {
                            $('#CboDUManagers').val("");
                            $("#ChkAddDUPMCheckManager").prop("checked", false);
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
                    $('#AddDUMModal').modal('hide');
                }
            }
            else {
                //$('#AddOUMModal').modal('show');
                $("#CboDUManagers").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select Manager");
            }



        }




        function GetDUResouces(RoleID, ResourcePoolID) {
            CurrentTabObject.Resource = 'true';
            var strHTML = "";
            var DU_ResourceParameters = { ResourcePoolID: ResourcePoolID, RoleID: RoleID };

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_DeliveryUnit/GetDUResources',
                type: "POST",
                data: JSON.stringify(DU_ResourceParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (DU_ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DU_ResourceParameters) ? DU_ResourceParameters : JSON.stringify(DU_ResourceParameters)));
                    }
                },
                success: function (data) {
                    
                    var MyOrganizationRoles = data;
                    if (data.length > 0) { // Added by Chetan M on 6 Jul 2021 for Issue Fixing
                        $.each(MyOrganizationRoles, function (index, obj) {

                            strHTML += '<tr><td>' + obj.EmployeeName + '</td><td>' + obj.RoleDescription + '</td><td>' + obj.Location + '</td><td>' + obj.Department + '</td><td>' + obj.EmailID + '</td><td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResumeModal" onclick="GetResourceResume(' + obj.EmployeeID + ')">' + obj.Resume + '</a></td></tr>';
                            // $("#tblBusinessGroups bodyBusiness-group").append(row);
                        });
                    }
                    // Added by Chetan M on 6 Jul 2021 for Issue Fixing
                    //else {
                    //    strHTML += '<tr><td colspan="6">No data available in table</td></tr>';
                    //}
                    // End of Added by Chetan M on 6 Jul 2021 for Issue Fixing
                    //$('#MaintblDeliveryResources').dataTable().fnDestroy();
                    $("#tblDeliveryResources").html(strHTML);
                    //Added By Rutuja D. On 19 July 2021 For IssueID= 27952
                    //$('#MaintblDeliveryResources').dataTable({
                    //    "scrollY": '40vh',
                    //    "scrollX": true,
                    //    "pageLength": 5,
                    //    "lengthChange": false,
                    //    "bFilter": false,
                    //    "ordering": false,
                    //    "responsive": true,
                    //    "destroy": false,
                    //    "retrieve": true,
                    //    "responsive": true
                    //});
                    //End of Added By Rutuja D. On 19 July 2021 For IssueID= 27952
                    //  LoadPagination('#tblOUResorces', data);
                    StopAjaxLoader("#bodyBusiness-group");
                },
                //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue     
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

        ///get checked values
        function GetSelectedOUResources() {
            var selectedOUUniqueId = '';
            $('#tblDUManagers').find('tr').each(function () {
                var row = $(this);
                if (row.find('input[type="checkbox"]').is(':checked')) {
                    selectedOUUniqueId += row.find('#hdnDUM_UniqueID').val() + ',';
                }
            });
            if (selectedOUUniqueId.length > 0) {
                selectedOUUniqueId = selectedOUUniqueId.substring(0, selectedOUUniqueId.length - 1);
            }
            return selectedOUUniqueId;
        }

        function DeleteDUManager() {
            var isSelectedResource = GetSelectedOUResources();
            if (isSelectedResource.length > 0) {
                $('#DeleteConfirmDUMModal').modal('show');

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }
        function DeleteDUManagerAfterConfirm() {
            var isSelectedResource = GetSelectedOUResources();
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (isSelectedResource.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_DeliveryUnit/DeleteDUanager',
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
                                /*alertify.success('Manager is Primary Responsible.');*/
                                alertify.error('Manager is Primary Responsible.');
                               /*End of Comment By RehanC for alert colour issue on 31th Mar 2023*/
                            }
                            if (data.indexOf('Deleted') > -1) {
                                alertify.success('Record Deleted Successfully.');
                            }
                            //End of Commented & Added By Rutuja D. For Issue ID = 26451

                        }                         
                        CurrentTabObject.Manager = 'false';
                        ShowDUManager();
                        CurrentTabObject.Manager = 'true';
                        $('#DeleteConfirmDUMModal').modal('hide');
                    },
                    //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue     
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    $('#DeleteConfirmDUMModal').modal('hide');
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
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }

        function GetDeliveryUnits(DuFilterParameter) {
            var strHTML = "";
            //var managerId = 61;
            if (DuFilterParameter == null) {
                // OuFilterParameter.ManagerID = SessionEmployeeId;
                DuFilterParameter = { UniqueID: '0', IsActive: 'false', DUWhereClause: null, ManagerID: SessionEmployeeId }
            }
            //var DuOuParameter = { ManagerID: managerId };
            //var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_DeliveryUnit/GetDeliveryUnitData',
                type: "POST",
                data: JSON.stringify(DuFilterParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (DuFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DuFilterParameter) ? DuFilterParameter : JSON.stringify(DuFilterParameter)));
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

                        strHTML += '<tr><td class="text-start"><input type="hidden" name="hdnDU_DeliveryUnitId" id="hdnDU_DeliveryUnitId" value= ' + obj.ResourcePoolID + '> ' + obj.ResourcePoolCode + '</td><td class="text-start"><a href="javascript:;" id=' + strActive + ' class="DUdetalilink" onclick="editDU(this.id)">' + obj.ResourcePoolName + '</a></td><td class="">' + strActive + '</td></tr>';
                    });
                    $('#DUtblmain').dataTable().fnDestroy();
                    $("#tblDeliveryUnit").html(strHTML);
                    LoadPagination('#DUtblmain', data);
                    StopAjaxLoader("#bodyBusiness-group");
                },
                //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue     
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
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue     
            })

        }

        function ShowDUDeliveryTeams() {
            if (CurrentTabObject != null && CurrentTabObject.DelTeam == "false") {
                var duID = $("#hdnDU_DeliveryUnitIDTab").val();
                GetDeliveryUnitDeliveryTeams(duID);
                CurrentTabObject.DelTeam = 'true';
            }

        }

        function ShowDUManager() {
            if (CurrentTabObject != null && CurrentTabObject.Manager == "false") {
                var duID = $("#hdnDU_DeliveryUnitIDTab").val();
                GetAllDuManagers(duID);
                CurrentTabObject.Manager = 'true';
            }


        }

        function showDUResources() {
            if (CurrentTabObject != null && CurrentTabObject.Resource == "false") {
                $("#CboDUResource").val('0'); // Added by Chetan M on 6 Jul 2021 for Issue Fixing
                var RoleId = $("#CboDUResource").val();
                CboDUResource_OnChange(RoleId);
                CurrentTabObject.Resource = 'true';
            }
        }

        function ShowGraph() {
            if (CurrentTabObject != null && CurrentTabObject.RoleGraph == "false") {
                var duID = $("#hdnDU_DeliveryUnitIDTab").val();
                GetDUResourceRoleGraph(duID);
                CurrentTabObject.RoleGraph = 'true';
            }
        }


        function GetDeliveryUnitDeliveryTeams(DeliveryUnitID) {
            //Added By Rutuja D. On 19 July 2021 For IssueID= 27952
            //$('#MaintblDUDeliveyTeams').dataTable().fnDestroy();
            //End of Added By Rutuja D. On 19 July 2021 For IssueID= 27952
            CurrentTabObject.DelTeam = 'true';
            var strHTML = "";
            var DuOuParameter = { ResourcePoolID: DeliveryUnitID };
            StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_DeliveryUnit/GetDUDeliveryTeams',
                type: "POST",
                data: JSON.stringify(DuOuParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (DuOuParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DuOuParameter) ? DuOuParameter : JSON.stringify(DuOuParameter)));
                    }
                },
                success: function (data) {
                    var MyDUDeliveryTeam = data;
                    if (MyDUDeliveryTeam.length > 0) {
                        $.each(MyDUDeliveryTeam, function (index, obj) {
                            if (obj.ResourceHead == null) {
                                obj.ResourceHead = '';
                            }
                            //Commented and added by Chetan M on 6 Jul 2021 for Issue Fixing
                            //strHTML += '<tr><td class="text-start">' + obj.GroupName + '</td><td  class="text-start">' + obj.ResourceHead + '</td><td>' + obj.GroupCode + '</td></tr>';
                            strHTML += '<tr><td>' + obj.GroupCode + '</td><td class="text-start">' + obj.GroupName + '</td><td  class="text-start">' + obj.ResourceHead + '</td></tr>';
                            //End of Commented and added by Chetan M on 6 Jul 2021 for Issue Fixing
                        });
                    }
                    //else {
                    //    strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    //}
                    $("#tblDUDeliveyTeams").html(strHTML);
                    //Added By Rutuja D. On 19 July 2021 For IssueID= 27952
                    //$('#MaintblDUDeliveyTeams').dataTable({
                    //    "scrollY": '40vh',
                    //    "scrollX": true,
                    //    "pageLength": 5,
                    //    "lengthChange": false,
                    //    "bFilter": false,
                    //    "ordering": false,
                    //    "responsive": true,
                    //    "destroy": false,
                    //    "retrieve": true,
                    //    "responsive": true
                    //});
                    //End of Added By Rutuja D. On 19 July 2021 For IssueID= 27952

                    StopAjaxLoader("#bodyBusiness-group");
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue     
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
                    StopAjaxLoader("#bodyBusiness-group");
                }
            })
        }

        function GetAllDuManagers(ResourcePoolID) {
            $("#hdnDU_ManagerUniqueID").val(0);
            var strHTML = "";
            var DuMangerParameter = { ResourcePoolID: ResourcePoolID };
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_DeliveryUnit/GetDUManagers',
                type: "POST",
                data: JSON.stringify(DuMangerParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (DuMangerParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DuMangerParameter) ? DuMangerParameter : JSON.stringify(DuMangerParameter)));
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
                            strHTML += '<tr><td><a href="javascript:;" class="clDUEditManager" data-bs-toggle="modal" data-bs-target="#AddDUMModal" onclick="GetDUManager(' + obj.UniqueID + ')">' + obj.Manager + '</a><input type="hidden" name="hdnDUM_ResourcePoolID" id="hdnDUM_ResourcePoolID" value= ' + obj.ResourcePoolID + '><input type="hidden" name="hdnDUM_UniqueID" id="hdnDUM_UniqueID" value= ' + obj.UniqueID + '></td><td>' + strResponsible + '</td><td class="text-start">' + obj.Responsibilities + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck()" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                        }
                        else {
                            strHTML += '<tr><td><input type="hidden" name="hdnDUM_ResourcePoolID" id="hdnDUM_ResourcePoolID" value= ' + obj.ResourcePoolID + '><input type="hidden" name="hdnDUM_UniqueID" id="hdnDUM_UniqueID" value= ' + obj.UniqueID + '>' + obj.Manager + '</td><td>' + strResponsible + '</td><td class="text-start">' + obj.Responsibilities + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck()" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                        }
                    });

                     //$('#MaintblDUManagers').dataTable().fnDestroy();
                    $("#tblDUManagers").html(strHTML);
                    // LoadPagination('#tblOUManagers', data);
                    //Added By Rutuja D. On 19 July 2021 For IssueID= 27952
                    //$('#MaintblDUManagers').dataTable({
                    //    "scrollY": '40vh',
                    //    "scrollX": true,
                    //    "pageLength": 5,
                    //    "lengthChange": false,
                    //    "bFilter": false,
                    //    "ordering": false,
                    //    "responsive": true,
                    //    "destroy": false,
                    //    "retrieve": true,
                    //    "responsive": true,
                    //    "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [3] }]// Added By Pradip on 20 July 2021
                    //});
                    //End of Added By Rutuja D. On 19 July 2021 For IssueID= 27952

                    StopAjaxLoader("#bodyBusiness-group");
                    $(".chckHead").prop("checked", false);
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



        function GetDUManager(UniqueID) {
            var DU_ResourceParameters = { UniqueID: UniqueID };
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            //StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_DeliveryUnit/GetDUManager',
                type: "POST",
                data: JSON.stringify(DU_ResourceParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (DU_ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DU_ResourceParameters) ? DU_ResourceParameters : JSON.stringify(DU_ResourceParameters)));
                    }
                },
                success: function (data) {
                    var MyDeliveryUnitManager = data;
                    document.getElementById("CboDUManagers").value = MyDeliveryUnitManager.ManagerID;
                    document.getElementById("hdnDU_OldMangerId").value = MyDeliveryUnitManager.ManagerID;
                    FillBGManager(MyDeliveryUnitManager.ManagerID);
                    //document.getElementById("ChkAddDUPMCheckManager").value = MyDeliveryUnitManager.IsPrimaryResponsible;
                    document.getElementById("hdnDU_ManagerUniqueID").value = UniqueID;

                    //  $('#CboDUManagers').prop('disabled', true);
                    // $('#btnSaveUpdateDUManage').attr("disabled", true);
                    if (MyDeliveryUnitManager.IsPrimaryResponsible == true) {
                        $('#ChkAddDUPMCheckManager').prop('checked', true);
                    }
                    else {
                        $("#ChkAddDUPMCheckManager").prop("checked", false);
                    }

                    // $("#tblOrganizationUnitDeliveryUnit").html(strHTML);
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

        if (CurrentTabObject.RoleGraph == 'false') {
            function GetDUResourceRoleGraph(ResourcePoolID) {
                CurrentTabObject.RoleGraph = 'true';
                var strHTML = "";
                var DU_GraphParameters = { ResourcePoolID: ResourcePoolID };
                StartLoader("#bodyBusiness-group");
                $.ajax({
                    url: strUrl + '/api/RM_DeliveryUnit/GetDUResourceRoleGraph',
                    type: "POST",
                    data: JSON.stringify(DU_GraphParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    },
                    success: function (data) {
                        var BGResourcesGraph = data;
                        if (BGResourcesGraph.length > 0 && BGResourcesGraph[0]['LstData'].length > 0) {
                            StopAjaxLoader("#bodyBusiness-group");
                            PlotRoleGraph(BGResourcesGraph[0]['LstLabel'], BGResourcesGraph[0]['LstColor'], BGResourcesGraph[0]['LstData'])

                        } else {
                            PlotRoleGraph(0, 0, 0);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("There is no details available.");
                            StopAjaxLoader("#bodyBusiness-group");
                        }
                    },
                    // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
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
        var DtChart;
        function PlotRoleGraph(LabelList, ColorList, DataList) {

            var Dtctx = document.getElementById("RDuChart").getContext('2d');
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

        function GetResourceResume(EmployeeID) {
            window.open('../Resources/Resume.aspx?EmployeeID=' + EmployeeID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100');
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
                    $("#CboDUManagers").html(strHTML);
                    $("#CboDUManagers").val(EmpID);

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

        //var filterWhereClause = "";



        function ApplyFlter() {
            currentFilterID = 0;
            //if ($('#txtDUFilterResourcePoolCode').val() == "" && $('#txtDUFilterResourcePoolName').val() == "") {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Enter at least one filter value');
            //} else {
            var filter = "";
            //if (filterwhereclause != 'undefined' && filterwhereclause != null) {

            //Commented & Added By Rutuja D. on 7 July 2021
            //var AllBgFilter = ["ResourcePoolCode", "ResourcePoolName"];
            //var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
            var AllBgFilter = ["ResourcePoolCode", "ResourcePoolName", "Active"];
            //End of Commented & Added By Rutuja D. on 7 July 2021

            var filterWhereClause2 = GenerateDUBasicFilterQuery("DU", AllBgFilter);

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
                filterWhereClause = filterWhereClause2.replace(/"/g, "\'");
                filter = { UniqueID: '0', IsActive: 'false', DUWhereClause: encodeURIComponent(filterWhereClause), ManagerID: SessionEmployeeId }
                FilterApplied();
                //}

                //SaveBGFilterDetails();
                GetDeliveryUnits(filter);
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");
                //}
            }
        }


        function GetDUDetails(whereClause) {
            var filter = null;
            if (whereClause != null) {
                // var whereClauseFormated = whereClause.replace(/'/g, "\''");
                filter = { UniqueID: '0', IsActive: 'true', DUWhereClause: encodeURIComponent(whereClause), ManagerID: SessionEmployeeId }
            }
            GetDeliveryUnits(filter);
        }
        //FILTER vALIDATION
        function checkFiltervalidationForDU() {
            var DUCode = $("#txtDUFilterResourcePoolCode ").val() == "" ? null : $("#txtDUFilterResourcePoolCode ").val();
            var DUName = $("#txtDUFilterResourcePoolName ").val() == "" ? null : $("#txtDUFilterResourcePoolName ").val();

            //Commented & Added By Rutuja D. on 7 July 2021
            //var isActive = $("#chkBgFilterIsActive").is(":checked");
            //if ((DUCode == null || DUCode == 'undefined' || DUCode == ' ') && (DUName == null || DUName == 'undefined' || DUName == ' ') && (isActive == false)) {
            var isActive = $("#txtDUFilterActive ").val() == "" ? null : $("#txtDUFilterActive ").val();
            if ((DUCode == null || DUCode == 'undefined' || DUCode == ' ') && (DUName == null || DUName == 'undefined' || DUName == ' ') && (isActive == null || isActive == 'undefined' || isActive == ' ')) {
                //End of Commented & Added By Rutuja D. on 7 July 202--%>
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                $('#BgSavefilter').modal('hide');
            }
            else {
                $('#BgSavefilter').modal('show');
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

        var savedFilterName = "";
        function SaveBGFilterDetails() {
            var fltFilterName = $("#txtBGFilterName").val();
            //$('#BgSavefilter').modal('show');
            // $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            if (fltFilterName == "" || fltFilterName == " ") {
                //$('#BgSavefilter').modal('show');
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please Enter Filter Name');
                //$('#BgSavefilter').modal('show')

                $("#txtBGFilterName").focus();

                //return false
            }
            //Added By Riddhesh Patil on 12-NOV-2022 
            else if (checkSpecialCharacter(fltFilterName.trim(), WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtBGFilterName").focus();

            }
			//End of Comment Added By Riddhesh Patil
            else {
                var filterExists = 0;
                //if (savedFilterName == "") {
                //    filterExists = ExistBGFilter(fltFilterName);
                //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                //    $('#BgSavefilter').modal('show');
                //}

                //if (filterExists == 0) {
                // $("#btnSaveFilter").attr("data-bs-dismiss", "modal");

                //Commented & Added By Rutuja D. on 7 July 202--%>
                //var AllBgFilter = ["ResourcePoolCode", "ResourcePoolName"];
                //var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
                var AllBgFilter = ["ResourcePoolCode", "ResourcePoolName", "Active"];
                //End of Commented & Added By Rutuja D. on 7 July 202--%>

                var filterWhereClause;
                var filterWhereClause2 = GenerateDUBasicFilterQuery("DU", AllBgFilter);

                //  var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");

                if (filterWhereClause2 != "" && filterWhereClause2 != null && filterWhereClause2 != 'undefined') {
                    // filterWhereClause2 += "AND Active=" + ' "' + isActiveFilter + '"';
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
                            $('#BgSavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            GetMyDUFilter(0);
                            ApplyFlter();
                            FilterApplied();

                            savedFilterName = fltFilterName;
                            $("#txtBGFilterName").val('');
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
                //}
            }
        }

        function GetMyDUFilter(flag) {
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
                                strHTML += "<span data-bs-toggle='tooltip' data-bs-placement='right' title='Remove Default filter' data-bs-container='body' class='checkmark'></span>";
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

                            GetDUDetails(null);
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyDUFilter(0);
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
                        $("#txtBGFilterName").val(currentFilterName);
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

        //Apply saved filter   
        function ApplySavedFilter(FilterID, isDefault, isFromDefault) {
            //added by mahesh on 22 july 2021
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {
                // var GetBGWitManager = "ManagerID=" + ' "' + SessionEmployeeId + '"';
                GetDUDetails(null);
                GetMyDUFilter(isDefault);
                FilterNotApplied();
                ClearFilterDetails(""); // Added By Reshma Chavan on 31st Jan 2022 for clearing filter
                $('#AdvanceFilterIcon').attr("aria-expanded", false);
                //added by mahesh on 22 july 2021
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
                            GetDUDetails(Querytext);
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
                            GetMyDUFilter(0);
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
                        ApplySavedFilter(FilterID, 2, true);//Changed BY Mahesh on 22 July 2021
                        alertify.success('Filter Is Successfully Set As Default!');
                        //alertify.success('Success');
                        //ApplySavedFilter(FilterID, 2);
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        ApplySavedFilter(FilterID, 3, true);//Changed BY Mahesh on 22 July 2021
                        alertify.success('Default Filter Is Successfully Removed!');
                        //alertify.success('Default');
                        //FilterNotApplied();
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        currentappliedfilter = 0;
                        FilterNotApplied();
                    }
                    GetMyDUFilter(0);
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

        function GenerateDUBasicFilterQuery(module, filterField) {
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

                    // strvalue = $("#txtBGFilterBgGroupName").val();

                    //Commented & Added By Rutuja D. on 7 July 2021
                    //       if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                    if (strvalue != "" && strvalue != undefined) {
                        //End of Commented & Added By Rutuja D. on 7 July 2021

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
                                //strqtext += strOp + " " + strvalue + "";
                                strqtext += strOp + ' "' + strvalue + '"';
                            }
                        }
                    }
                }
                console.log('strqtext');
                console.log(strqtext);
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
            if (arrFields[0] == "ResourcePoolCode") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboDUFilterResourcePoolCode", "txtDUFilterResourcePoolCode");
            }
            if (arrFields[0] == "ResourcePoolName") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboDUFilterResourcePoolName", "txtDUFilterResourcePoolName");
            }
            //Added By Rutuja D. on 7 July 2021
            if (arrFields[0] == "Active") {               
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboDUFilterActive", "txtDUFilterActive");
                 if (arrFields[1] == "=") {
                    setFilterComboValue("cboDUFilterActive", "=");
                }
                if (arrFields[1] == "<>") {
                    setFilterComboValue("cboDUFilterActive", "<>");
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

            //Commented & added by mahesh on  27 july 2021
            // $("#" + ValueComboName).val(currValue);
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }

        function ClearFilterDetails(flag) {
            if ($("#cboDUFilterResourcePoolCode").val() != "Contains") {
                setFilterComboValue("cboDUFilterResourcePoolCode", "Contains");
            }
            if ($("#txtDUFilterResourcePoolCode").val() != "") {
                $("#txtDUFilterResourcePoolCode").val("");
            }
            if ($("#txtDUFilterResourcePoolName").val() != "") {
                $("#txtDUFilterResourcePoolName").val("");
            }
            if ($("#cboDUFilterResourcePoolName").val() != "Contains") {
                setFilterComboValue("cboDUFilterResourcePoolName", "Contains");
            }
            $('#txtBGFilterName').val('');
            savedFilterName = "";

            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {

                    $(this).removeAttr("checked");
                });
            }

            //Added By Rutuja D, on 7 July 2021           
            $('#cboDUFilterActive').val('=');
            $('#txtDUFilterActive').val('');
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
            GetDeliveryUnits(null);
            GetMyDUFilter(0);
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
        //End of Commented & Added By Rutuja D. For Filter Delete Issue on 6 July 2021

        //Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }
        //End of Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021

        function closeFilterPanel() {
            $("#filterpanel").removeClass('show');
        }
    </script>

</body>
</html>
