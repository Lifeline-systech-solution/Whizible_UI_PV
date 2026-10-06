<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_ResourcePoolMaster.aspx.vb" Inherits="PbNIT.RM_ResourcePoolMaster" %>

<!DOCTYPE html>
<html>
        <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Processes")%> 
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Processes</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>



<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    <link href="../../../Whizible2.0-new/dist/css/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />

  

</head>
  <style type="text/css">
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important
        }

        a.clearalllink {
            font-weight: 700;
            margin: 7px 0 0 8px;
            display: none
        }

        .filter.float-end {
            margin: 2px 0 0 8px
        }

        table tr th {
            vertical-align: middle !important;
        }

            table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
                margin-right: 0
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

        .notebox {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px
        }



        /*Detailpanel*/
        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px
        }

        .pgdetailinner {
            padding: 10px
        }

        .Resourcedetailpanel .tab-pane {
            padding: 20px 0
        }

        tr.rowhiglight {
            background: #c3dbff
        }

        .DisableContent {
            pointer-events: none;
            opacity: .5
        }

            .DisableContent:hover {
                cursor: no-drop
            }

        .dataTables_scrollBody.DisableContent {
            height: auto !important
        }

        ul.nav.nav-tabs.detailsubtabs {
            background: #f5f5f5;
            margin: -11px -11px 0;
            padding: 10px 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0
        }

        .nav.detailsubtabs > li > a:hover, .nav.nav.detailsubtabs > li > a:active, .nav.nav.detailsubtabs > li > a:focus {
            background: #fff;
            color: #1359ac;
        }

        .multiselect-native-select .btn-group {
            width: 100%
        }

            .multiselect-native-select .btn-group button {
                width: 100%;
                min-height: 34px;
                text-align: left;
                overflow: hidden;
                text-overflow: ellipsis
            }

                .multiselect-native-select .btn-group button b.caret {
                    display: none;
                }

        .multiselect-native-select .multiselect-container {
            width: 100%
        }

        .multiselect-native-select .dropdown-menu > .active > a, .multiselect-native-select .dropdown-menu > .active > a:focus, .multiselect-native-select .dropdown-menu > .active > a:hover {
            background-color: #f0f1f5;
            color: #464a4c
        }

        .multiselect-native-select .btn-group button span.multiselect-selected-text {
            width: 90%;
            display: inline-block;
            overflow: hidden;
            text-overflow: ellipsis
        }

        .modalpgHead {
            background: #4263c1;
            color: #fff;
            font-family: 'Roboto', sans-serif;
            font-size: 20px;
        }

        /*.custom_chckbox label:before {
            padding: 7px;
        }*/

        .tooltip {
            z-index: 9999;
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

        .alertify-notifier {
            /*Added by imran on 18-08-2022*/
            color: #fff;
            background: rgba(217, 92, 92, 0,95);
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0,5);
            /*End of comment by imran on 18-08-2022*/
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999 !important;
            /*Commented by imran on 18-08-2022*/
            /*  -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);*/
            word-break: break-all;
            height: auto !important;
        }

        .modal .filterpanel {
            border: 1px solid #ddd;
            border-radius: 4px;
            margin: 0 0 15px;
            background: #fafafa
        }

        .tablewidthtblResourceSelection {
            width: 100% !important;
        }

        .dataTables_scrollHeadInner {
            width: 100% !important;
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
        /*added by pradip on 9-7-21*/
        .pb-0 {
            padding-bottom: 0px !important;
        }
        /*.table thead tr th:last-child .custom_chckbox{ margin-left:-8px;}*/
        /*added by pradip on 9-7-21*/
        .tablewidthtblResourceSelection th:not(:last-child) {
            min-width: 100px;
        }

        .RPMtbl {
            width: 100% !important;
        }

        .tablewidthtblResourceSelection tr th:not(:last-child) {
            min-width: 150px;
        }

        .tablewidthtblResourceSelection tr th:last-child {
            min-width: 80px;
        }

        .filterpanel .cust_tabpanel .dropdown-menu.show {
            display: block;
        }

        .filterpanel .MyFiltersdropdown li label, .filterpanel .MyFiltersdropdown li > div {
            display: inline-block;
        }

        .filterpanel .caret {
            display: none
        }
        /**Added By Dipali V On 31st March 2023 For UI Issue*/
        .form-select, .btn {
            font-size: 14px;
            -webkit-appearance: auto;
        }
         /**End of Added By Dipali V On 31st March 2023 For UI Issue*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" >
    <%--  /*Added & Commented By Madhuri.K On 21-Aug-2024 For Loader Issues*/--%>
    <div class="" id="body-RPM"></div>
    <div class="bgwhite clearfix">
        <div class="container-fluid pt-1 pb-1 mb-1 text-end graybg">
            <h5 class="pgtitle float-start">Resource Pool Master</h5>
            <span data-bs-toggle="modal" data-bs-target="#AddRPMpopup" data-bs-container="body">
                <a href="javascript:;" class="btn borderbtn mr-5 AddRPMbtn" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Add Resource Pool" id="AddbtnRPM"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
            </span>
            <button class="btn borderbtn mr-5 DelRPMbtn" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Delete" onclick="DeleteDetailsAfterConfirm();" id="DeletebtnRPM">Delete</button>
            <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Back To Resource Configuration">Back</a>--%>
            <%--End of Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
        </div>

        <div class="content pt-1 pb-0">
            <!--Added class by pradip on 9-7-21-->
            <div class="RPMtblouter">
                <table class="table table-bordered RPMtbl" id="tblResourcePoolMaster" style="width: 100%;">
                    <thead>
                        <tr>
                            <th class="text-center" width="100">Code</th>
                            <th class="text-start" width="150">Resource Pool</th>
                            <th class="text-start">Description</th>
                            <th width="50">
                                <div class="custom_chckbox">
                                    <input id="RPMListCheck0" class="chckHead" type="checkbox">
                                    <label for="RPMListCheck0"></label>
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="tblResourcePool">
                    </tbody>
                </table>
            </div>
        </div>


        <div class="Resourcedetailpanel">
            <input type="hidden" id="hdnRPM_DeliveryUnitIDTab" name="hdnRPM_DeliveryUnitIDTab">

            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li class="nav-item"><a href="#RRPMDetail" class="nav-link active" data-bs-toggle="tab" id="">Details</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#RRPMResources" class="nav-link" data-bs-toggle="tab" id="" onclick="ShowRPMResources();">Resources <span class="badge" id="ResCount"></span></a>
                        <div></div>
                    </li>
                    <li class="nav-item"><a href="#RRPMmanagers" class="nav-link" data-bs-toggle="tab" id="" onclick="ShowRPMManager();">Managers <span class="badge" id="MgrCount"></span></a>
                        <div></div>
                    </li>
                </ul>
                <div class="tab-content">
                    <div id="RRPMDetail" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <a href="javascript:;" class="btn btnyellow mr-5" onclick="editResourcePool(0)">Save</a>
                            <%--<a href="javascript:;" class="btn btnyellow mr-5" onclick="">Save And Add</a>--%>
                            <%-- <span data-bs-toggle="modal" data-bs-target="#AddRPMpopup" data-bs-container="body" id="spnAddResourcePool">--%>
                            <span data-bs-toggle="modal" data-bs-container="body" id="spnAddResourcePool">
                                <a href="javascript:;" id="btnaAddResourcePool" class="btn btnyellow mr-5" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Add Resource Pool" onclick="editResourcePool(1)">Save and Add</a>
                            </span>
                            <button class="btn borderbtn canceldetailpanel" id="" onclick="cancelDetails()">Cancel</button>
                        </div>

                        <div class="form-group mb-3 ">
                            <div class="row">
                                <div class="col-sm-2">
                                    <label for="email" class="required">Code : </label>
                                    <%CommonFunctions.HTMLControls.DrawTextBox("txtEditCode", "txtEditCode", cssClass:="form-control", widthInPixel:=0, maxLength:=10)%>
                                </div>
                                <div class="col-sm-3">
                                    <label for="ResourcePool" class="required">Resource Pool : </label>
                                    <%CommonFunctions.HTMLControls.DrawTextBox("txtEditResourcePool", "txtEditResourcePool", cssClass:="form-control", widthInPixel:=0, maxLength:=100)%>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Skill Set : </label>
                                    <select id="plnReviewer" type="text" class="form-select multiselect multiselect-icon multiselectdropdown" multiple="multiple" role="multiselect">
                                    </select>

                                </div>
                                <div class="col-sm-3">
                                    <label for="email">Other Attribute : </label>
                                    <%CommonFunctions.HTMLControls.DrawTextBox("txtEditOtherAttribute", "txtEditOtherAttribute", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-12">
                                    <label for="email">Description : </label>
                                    <% CommonFunctions.HTMLControls.DrawTextArea("txtEditDescription", "txtEditDescription", "Enter Summary (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Summary (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>


                    </div>
                    <div id="RRPMResources" class="tab-pane">
                        <div class="row pb-1">
                            <div class="col-sm-12">
                                <div class="detailsubtabsbtn text-end">

                                    <a class="btn borderbtn mr-5" id="btnAddRsrsSelection" data-bs-toggle="modal" data-bs-target="#AddRESModal" onclick="AddRsrsSelection()"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
                                    <button class="btn borderbtn mr-5" id="btnDeleteResourcesDetails" onclick="DeleteResourcesDetails();">Delete</button>
                                    <button class="btn borderbtn canceldetailpanel" id="" onclick="cancelDetails()">Cancel</button>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <div class="row pt-1 pb-1">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <label for="email">Business Group : </label>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRPMFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-select"" onChange=""FillOU(this.value),CboRPMResource_OnChange(this.value)""",,,, ,)%>
                                        </div>
                                        <div class="col-sm-4">
                                            <label for="email">Organization Unit : </label>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRPMFilterLocationID", "Select '' ",,, "class=""form-select"" onChange=""CboRPMResource_OnChange(this.value)""",,,, , ) %>
                                        </div>
                                        <div class="col-sm-4">
                                            <label for="email">Active Resources : </label>
                                            <select id="cboRPMFilterIsResourceActive" class="form-select" style="width: 210px" onchange="CboRPMResource_OnChange(this.value)">
                                                <option value="0">Select Active Resources</option>
                                                <option value="Yes">Yes</option>
                                                <option value="No">No</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <table class="table table-bordered RRPMResourcesTbl" style="width: 100%;" id="ResourcesTbl">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>Role</th>
                                    <th>Reporting To</th>
                                    <th>Email ID</th>
                                    <th>Resume</th>
                                    <th>
                                        <div class="custom_chckbox">
                                            <input id="RPMResrsListCheck0" style="width: 18px; height: 18px" class="chckHead1" type="checkbox">
                                            <label for="RPMResrsListCheck0"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tblRPMResources">
                            </tbody>
                        </table>
                    </div>

                    <div id="RRPMmanagers" class="tab-pane">
                        <div class="row pb-1">
                            <div class="col-sm-12">
                                <div class="detailsubtabsbtn text-end">
                                    <button type="submit" class="btn borderbtn mr-5" id="AddRDUManager" data-bs-toggle="modal" data-bs-target="#AddRESMModal" onclick="AddRsrsManger()"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                                    <button class="btn borderbtn mr-5" id="btnDeleteManagersDetails" onclick="DeleteManagersDetails();">Delete</button>
                                    <button class="btn borderbtn canceldetailpanel" id="">Cancel</button>
                                </div>
                            </div>
                        </div>

                        <table class="table table-bordered RRPMmanagersTbl" style="width: 100%;" id="ManagersTbl">
                            <thead>
                                <tr>
                                    <th class="text-start">Resource Pool Manager</th>
                                    <th>Email ID</th>
                                    <th>
                                        <div class="custom_chckbox">
                                            <input id="RPMmngrcheck0" style="width: 18px; height: 18px" class="chckHead2" type="checkbox">
                                            <label for="RPMmngrcheck0"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tblRPMmanagers">
                            </tbody>
                        </table>

                    </div>

                </div>
            </div>
        </div>


        <div class="clearfix"></div>
    </div>
    <%--    ADD MANAGERS SELECTION MODAL--%>
    <div class="modal custmodal fade" id="AddRESMModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Add Resource Manager Selection</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="OnCloseMangerAdd()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="bgwhite">
                        <div class="pt-1 pb-1">
                            <div class="col-sm-12">
                                <div class="detailsubtabsbtn text-end">
                                    <a href="javascript:;" class="btn btnyellow" id="btnShowselectedManager" onclick="ShowSelectedManager()">Show Selected Resource</a>
                                    <button class="btn borderbtn" onclick="saveSelectedManagers();">Save</button>
                                    <a href="javascript:;" class="MGRclearalllink" data-bs-toggle="tooltip" data-bs-placement="bottom"><strong>Clear All</strong></a>
                                    <div class="filter inline float-end">
                                        <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" id="AdvanceFilterIconForManagers" title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <!--filter panel-->
                        <div id="filterpanel" class="filterpanel collapse">
                            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                                <div class="cust_tabpanel">
                                    <ul class="nav nav-tabs">
                                        <li class="dropdown">
                                            <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">My Filters  </a>
                                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                            </ul>
                                        </li>
                                        <li class="" id="tabpresetfilter">
                                            <a href="#basicfiltersForManagers" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                                        </li>


                                    </ul>
                                </div>

                                <div class="Fwrapper ">
                                    <div class="tab-content">
                                        <div id="basicfiltersForManagers" class="tab-pane stackbasicfilter">
                                            <div class="filterpanelbody">
                                                <div class="text-center hidden-xs centerbtn">
                                                    <button class="btn btnyellow" id="svfilterbtnForManagers" onclick="checkFiltervalidationForManagers();">Save and Apply</button>
                                                    <button class="btn btnyellow" onclick="ApplyFilter()">Apply</button>
                                                </div>
                                                <br />


                                                <div class="form-group form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label>Role</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboMGRFilterRoleId", "usp_Whizible2_Sel_tbl_PM_Role_High_Medium",,, "class='form-select'",,,, ,) %>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <label>Designation</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboMGRFilterDesignationID", "usp_Whizible2_sel_tbl_PM_DesignationMaster_DesignationName",,, "class='form-select'",,,, ,) %>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <label>Department</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboMGRFilterDepartmentID", "usp_Whizible2_sel_Department_tbl_pm_Departmentmaster",,, "class='form-select'",,,, ,) %>
                                                        </div>
                                                        <div class="clearfix"></div>
                                                    </div>
                                                </div>
                                                <div class="form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label>Business Group</label>

                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboMGRFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-select"" onChange=""FillFilterOUForFilterResourceMang(this.value)""", False,,, ,)%>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <label>Organization Unit</label>

                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboMGRFilterLocationID", "Select '' ",,, "class='form-select'",,, ) %>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <label>Resource Name</label>
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtMGRFilterEmployeeName", "txtMGRFilterEmployeeName", "form-select",,,,,, ,,,, "  ",, ,,,,, True) %>
                                                        </div>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>


                                                <div class="clearfix"></div>

                                            </div>
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </div>
                        <!--end filter panel-->
                        <!-- filter panel for save-->
                        <div class="modal custmodal RPMmgrSavefilter_filter fade" id="RPMmgrSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="">Save Filter As</h5>
                                        <button type="button" class="close" onclick="onCloseSaveMGR()" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <div id="RPMmgrSavefilterfilterbox" class="box-panel">

                                            <div class="box-body graybg">
                                                <div class="form-group mb-0">
                                                    <div class="row">
                                                        <div class="col-md-12 row">
                                                            <label class="control-label col-md-4 p-0 text-end">Filter Name <span id="MandatoryFilterName1" style="color: red">* </span>:</label>
                                                            <span class="col-md-8">
                                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtMGRFilterName", "txtMGRFilterName", "form-control",, maxLength:=100) %>
                                                                <div class="btnrow">
                                                                    <button class="btn btnyellow float-start savefilter" id="btnMGRSaveFilter" onclick="SaveMGRFilterDetails()">Save</button>
                                                                    <button class="btn canclesaveasbtn borderbtn float-end" onclick="onCloseSaveMGR()">Cancel</button>
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
                        <!-- End filter panel for save-->

                        <div class="content pt-0">

                            <table class="table table-bordered tablewidthtblResourceSelection" id="AddRPMTbl">
                                <thead>
                                    <tr>
                                        <th>Resource Name</th>
                                        <th>Business Group</th>
                                        <th>Organization Unit</th>
                                        <th>Role</th>
                                        <th>Designation</th>
                                        <th>
                                            <div class="custom_chckbox" style="margin-right: 5px;">
                                                <input id="addResourceSelectionCheck" class="chckHead3" type="checkbox">
                                                <label for="addResourceSelectionCheck"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="tblResourceManagerSelection">
                                </tbody>
                            </table>

                        </div>



                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--    END MANAGERS SELECTION MODAL--%>

    <!--Add Resource SLECTION Modal-->
    <div class="modal custmodal fade" id="AddRESModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Add Resource Selection</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="OnCloseResourceAdd()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <%--<div class="modal-body" style="height: 600px; overflow-x: auto;">--%>
                <div class="modal-body" style="height: 450px; overflow-x: auto;">
                    <div class="bgwhite">
                        <div class="pt-1 pb-1">
                            <div class="col-sm-12">
                                <div class="detailsubtabsbtn text-end">


                                    <a class="btn btnyellow" href="#" id="btnShowselectedResource" onclick="ShowSelectedResource()">Show Selected Resource</a>
                                    <button class="btn borderbtn" onclick="saveSelectedResource()">Save</button>
                                    <a href="javascript:;" class="mainclearalllink" data-bs-toggle="tooltip" data-bs-placement="bottom"><strong>Clear All</strong></a>
                                    <div class="filter inline float-end">
                                        <button data-bs-toggle="collapse" data-bs-target="#filterpanel1" data-bs-placement="bottom" id="AdvanceFilterIconForResources" title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <!--filter panel-->
                        <div id="filterpanel1" class="filterpanel collapse">
                            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                                <div class="cust_tabpanel">
                                    <ul class="nav nav-tabs">
                                        <li class="dropdown">
                                            <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">My Filters </a>
                                            <ul id="MyFiltersdropdown1" class="dropdown-menu MyFiltersdropdown" role="menu">
                                            </ul>
                                        </li>
                                        <li class="">
                                            <a href="#basicfiltersRES" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                                        </li>


                                    </ul>
                                </div>

                                <div class="Fwrapper">
                                    <div class="tab-content">
                                        <div id="basicfiltersRES" class="tab-pane stackbasicfilter">
                                            <div class="filterpanelbody">
                                                <div class="text-center hidden-xs centerbtn">
                                                    <button class="btn btnyellow" id="svfilterbtnRes" onclick="checkFiltervalidationForResources();">Save and Apply</button>
                                                    <button class="btn btnyellow" onclick="applyFilterResWhere();">Apply</button>

                                                </div>
                                                <br />

                                                <div class="form-group mb-3">
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-sm-3">
                                                                <label>Business Group</label>
                                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-select"" onChange=""FillOURSFilter(this.value)""",,,, ,) %>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label>Organization Unit</label>
                                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterLocationID", "Select '' ",,, "class=""form-select"" onChange=""FillDURSFilter(this.value)""",,,, , ) %>
                                                                <%-- <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterLocationID", "usp_sel_tbl_PM_Location_Location ",,, "class='form-control'", True,,, , ) %>--%>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label>Delivery Unit</label>
                                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterResourcePoolID", "Select '' ",,, "class=""form-select"" onChange=""FillDTRSFilter(this.value)""",,,, ,) %>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label>Delivery Team</label>
                                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterGroupID", "usp_sel_tbl_PM_GroupMaster_GroupID",,, "class='form-select'",,,, , ) %>
                                                            </div>
                                                            <div class="clearfix"></div>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-3">
                                                            <label>Role</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterPostID", "usp_Whizible2_Sel_tbl_RM_Role",,, "class='form-select'",,,, ,) %>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <label>Designation</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterDesignationID", "usp_Whizible2_sel_tbl_PM_DesignationMaster_DesignationName",,, "class='form-select'",,,, ,) %>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <label>Department</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterDepartmentID", "usp_Whizible2_sel_Department_tbl_pm_Departmentmaster",,, "class='form-select'",,,, ,) %>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <label>Grade</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterGradeID", "usp_Whizible2_sel_tbl_PM_GradeMaster_GradeID",,, "class='form-select'",,,, ,) %>
                                                        </div>
                                                    </div>

                                                    <div class="clearfix"></div>
                                                </div>

                                                <div class="form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-3">
                                                            <label>Experience</label>
                                                            <div class="row">
                                                                <div class="col-sm-5">
                                                                    <select style="width: 60px !important" class="form-select input-sm" id="cboTotalExpSel">
                                                                        <option value="Less" ><</option>
                                                                        <option value="LessEqual"><=</option>
                                                                        <option value="Greater">></option>
                                                                        <option value="=">=</option>
                                                                    </select>

                                                                </div>
                                                                <div class="col-sm-7 pl-0">
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterTotalExp", "usp_Whizible2_Sel_WorkExperience",,, "class='form-select'", False,,, ,) %>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="col-sm-3">
                                                            <label>Skill</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterToolID", "usp_Whizible2_sel_tbl_PM_Tools_Skills",,, "class='form-select'", False,,, , ) %>
                                                        </div>

                                                        <div class="col-sm-3">
                                                            <label>Certification</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterCertificationID", "usp_Whizible2_sel_tbl_PM_Certifications_CertificationName",,, "class='form-select'", False,,, ,) %>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <label>Qualification</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterQualificationID", "usp_Whizible2_sel_tbl_PM_Qualifications_QualificationID",,, "class='form-select'", False,,, ,) %>
                                                        </div>
                                                    </div>

                                                    <div class="clearfix"></div>
                                                </div>

                                                <div class="form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-3">
                                                            <label>Project</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterProjectID", "usp_Whizible2_sel_tbl_PM_Project_ProjectName_hr",,, "class='form-select'", False,,, , ) %>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <label>Resource Pool</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterRPMID", "usp_Whizible2_sel_tbl_PM_ResourcePoolMaster_ResourcePoolID",,, "class='form-select'", False,,, ,) %>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <label>Visa Country</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterCountryID", "usp_Whizible2_sel_tbl_pm_countrymaster_CountryName",,, "class='form-select'", False,,, ,) %>
                                                        </div>
                                                    </div>


                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="form-group form-group mb-3" style="width: 100%;">
                                                    <div class="row">
                                                        <div class="col-sm-3">
                                                            <label>Visa Type</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRESFilterVisaTypeID", "usp_Whizible2_sel_tbl_PM_VisaTypeMaster_VisaType",,, "class='form-select'", False,,, ,) %>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <div>

                                                                <label for="RPMAddResrsFltrPassportCheck1">Passport</label>
                                                                <select id="cboRESFilterPassportNumber" class="form-select" style="width: 210px">
                                                                    <option value=""></option>
                                                                    <option value="IS NOT NULL">Yes</option>
                                                                    <option value="IS NULL">No</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-3">&nbsp;</div>
                                                        <div class="col-sm-3">&nbsp;</div>
                                                        <div class="col-sm-3">&nbsp;</div>
                                                    </div>

                                                    <div class="clearfix"></div>
                                                </div>


                                                <div class="clearfix"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </div>

                        <!--end filter panel-->

                        <!-- filter panel for save-->
                        <div class="modal fade" id="SklSavefilter" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="">Save Filter As</h5>
                                        <button type="button" class="close" onclick="onCloseSaveRes();" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="box-panel">

                                            <div class="box-body graybg">
                                                <div class="form-group mb-0">
                                                    <div class="row">
                                                        <div class="col-md-12 row">
                                                            <label class="control-label col-md-4 p-0 text-end">Filter Name <span id="MandatoryFilterName" style="color: red">* </span>:</label>
                                                            <span class="col-md-8">
                                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtOPRFilterName", "txtOPRFilterName", "form-control",, maxLength:=100) %>
                                                                <div class="btnrow">
                                                                    <button class="btn btnyellow float-start savefilter" id="btnSaveFilter" onclick="SaveOPRFilterDetails()">Save</button>
                                                                    <button class="btn canclesaveasbtn borderbtn float-end" onclick="onCloseSaveRes()">Cancel</button>
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
                    </div>
                    <!-- End filter panel for save-->

                    <div class="content pt-0">

                        <table class="table table-bordered tablewidthtblResourceSelection" id="tblResourceSelectionMain">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>User Name</th>
                                    <th>Employee Code</th>
                                    <th>Role</th>
                                    <th>Total Experience</th>
                                    <%-- <th>Experience with us<span>Yrs</span></th>--%>
                                    <th>Experience with us</th>
                                    <th>Primary Skills</th>
                                    <th>
                                        <div class="custom_chckbox">
                                            <input id="ResourceSelectionCheck" class="chckHead4" type="checkbox">
                                            <label for="ResourceSelectionCheck"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tblResourceSelection">
                            </tbody>
                        </table>

                    </div>



                    <%--<div class="clearfix"></div>--%>
                </div>
            </div>
        </div>
    </div>



    <!--Add Resource pool master Modal-->
    <div class="modal custmodal fade" id="AddRPMpopup" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Add Resource Pool Master</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="onClose()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group mb-3">
                        <div class="row">
                            <div class="col-sm-2">
                                <label class="required">Code</label>
                                <%CommonFunctions.HTMLControls.DrawTextBox("txtCode", "txtCode", cssClass:="form-control", widthInPixel:=0, maxLength:=10)%>
                            </div>
                            <div class="col-sm-5">
                                <label class="required">Resource Pool</label>
                                <%CommonFunctions.HTMLControls.DrawTextBox("txtResourcePool", "txtResourcePool", cssClass:="form-control", widthInPixel:=0, maxLength:=100)%>
                            </div>
                            <div class="col-sm-5">
                                <label>Other Attribute</label>
                                <%CommonFunctions.HTMLControls.DrawTextBox("txtOtherAttribute", "txtOtherAttribute", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <div class="form-group mb-3">
                        <div class="row">
                            <div class="col-sm-12">
                                <label>Description</label>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Enter Summary (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Summary (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                            </div>
                        </div>

                        <div class="clearfix"></div>
                    </div>

                    <br />
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal" onclick="onClose()">Close</button>
                        <button class="btn btnyellow" onclick="saveResourcePool(0)">Save</button>
                        <button class="btn btnyellow" onclick="saveResourcePool(1)">Save And Add</button>

                    </div>

                </div>



            </div>
        </div>
    </div>
    <!--End modal-->

    <!--add modal start here-->
    <div class="modal custmodal fade" id="AddRPMModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Add Resources</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <%--<div class="modal-body">
                    <table id="" class="table table-bordered" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>Resource Name</th>
                                <th>User Name</th>
                                <th>Employee Code</th>
                                <th>Role</th>
                                <th>Total Experience<span>Yrs</span></th>
                                <th>Experience with us<span>Yrs</span></th>
                                <th>Primary Skills</th>
                                <th>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck0" class="chckHead5" type="checkbox">
                                        <label for="RPMAddResrsCheck0"></label>
                                    </div>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Abhi1</td>
                                <td>Abhi1</td>
                                <td>Employee Code</td>
                                <td>Role</td>
                                <td class="text-end">0.30</td>
                                <td class="text-end">0.30</td>
                                <td>-</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck1" class="chcktbl" type="checkbox">
                                        <label for="RPMAddResrsCheck1"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Abhi1</td>
                                <td>Abhi1</td>
                                <td>Employee Code</td>
                                <td>Role</td>
                                <td class="text-end">0.30</td>
                                <td class="text-end">0.30</td>
                                <td>-</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck1" class="chcktbl" type="checkbox">
                                        <label for="RPMAddResrsCheck1"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Abhi1</td>
                                <td>Abhi1</td>
                                <td>Employee Code</td>
                                <td>Role</td>
                                <td class="text-end">0.30</td>
                                <td class="text-end">0.30</td>
                                <td>-</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck1" class="chcktbl" type="checkbox">
                                        <label for="RPMAddResrsCheck1"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Abhi1</td>
                                <td>Abhi1</td>
                                <td>Employee Code</td>
                                <td>Role</td>
                                <td class="text-end">0.30</td>
                                <td class="text-end">0.30</td>
                                <td>-</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck1" class="chcktbl" type="checkbox">
                                        <label for="RPMAddResrsCheck1"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Abhi1</td>
                                <td>Abhi1</td>
                                <td>Employee Code</td>
                                <td>Role</td>
                                <td class="text-end">0.30</td>
                                <td class="text-end">0.30</td>
                                <td>-</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck1" class="chcktbl" type="checkbox">
                                        <label for="RPMAddResrsCheck1"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Abhi1</td>
                                <td>Abhi1</td>
                                <td>Employee Code</td>
                                <td>Role</td>
                                <td class="text-end">0.30</td>
                                <td class="text-end">0.30</td>
                                <td>-</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck1" class="chcktbl" type="checkbox">
                                        <label for="RPMAddResrsCheck1"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Abhi1</td>
                                <td>Abhi1</td>
                                <td>Employee Code</td>
                                <td>Role</td>
                                <td class="text-end">0.30</td>
                                <td class="text-end">0.30</td>
                                <td>-</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck1" class="chcktbl" type="checkbox">
                                        <label for="RPMAddResrsCheck1"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Abhi1</td>
                                <td>Abhi1</td>
                                <td>Employee Code</td>
                                <td>Role</td>
                                <td class="text-end">0.30</td>
                                <td class="text-end">0.30</td>
                                <td>-</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck1" class="chcktbl" type="checkbox">
                                        <label for="RPMAddResrsCheck1"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Abhi1</td>
                                <td>Abhi1</td>
                                <td>Employee Code</td>
                                <td>Role</td>
                                <td class="text-end">0.30</td>
                                <td class="text-end">0.30</td>
                                <td>-</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck1" class="chcktbl" type="checkbox">
                                        <label for="RPMAddResrsCheck1"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Abhi1</td>
                                <td>Abhi1</td>
                                <td>Employee Code</td>
                                <td>Role</td>
                                <td class="text-end">0.30</td>
                                <td class="text-end">0.30</td>
                                <td>-</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck1" class="chcktbl" type="checkbox">
                                        <label for="RPMAddResrsCheck1"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Abhi1</td>
                                <td>Abhi1</td>
                                <td>Employee Code</td>
                                <td>Role</td>
                                <td class="text-end">0.30</td>
                                <td class="text-end">0.30</td>
                                <td>-</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck1" class="chcktbl" type="checkbox">
                                        <label for="RPMAddResrsCheck1"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Abhi1</td>
                                <td>Abhi1</td>
                                <td>Employee Code</td>
                                <td>Role</td>
                                <td class="text-end">0.30</td>
                                <td class="text-end">0.30</td>
                                <td>-</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="RPMAddResrsCheck1" class="chcktbl" type="checkbox">
                                        <label for="RPMAddResrsCheck1"></label>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                </div>--%>

                <div class="modal-footer">
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        <button class="btn btnyellow" data-bs-dismiss="modal">Show Selected Resource</button>
                        <button class="btn btnyellow" data-bs-dismiss="modal">Select</button>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!--Add modal end here-->

    <!-- REQUIRED JS SCRIPTS -->
   <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/bootstrap-multiselect.js"></script>
<%--    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>


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
                    <%-- <div class="form-group row">
                       <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <%--Commented and Modified By RehanC for Deletion pop-up Issue on 28th Mar 2023--%>
                    <%--                    <div class="form-group row">
                        <strong>Note:</strong> Resource pool which is in use cannot be deleted.<br />--%>
                    <div class="notebox">
                        <strong>Note:</strong> Resource pool which is in use cannot be deleted.<br />
                        <%--End Of Comment By RehanC--%>
                        <p id="showdeleterow"></p>
                    </div>

                    <div class="text-end">
                        <%--  <button class="btn btnyellow" onclick=" DeleteDetailsAfterConfirm()">Yes</button>--%>
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <%--    delete ResourceConfirmation  --%>
    <div class="modal custmodal fade" id="DeleteConfirmResourceModal" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%-- <div class="form-group row">
                       <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <div class="form-group row">
                        Are you sure, you want to delete the selected records?
                    </div>

                    <div class="text-end">
                        <button class="btn btnyellow" onclick=" DeleteConfirmResourceDetails()">Yes</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal">No</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <%--delete ManagersConfirmation--%>
    <div class="modal custmodal fade" id="DeleteConfirmManagersModal" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%-- <div class="form-group row">
                       <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <div class="form-group row">
                        Are you sure, you want to delete the selected records?
                    </div>

                    <div class="text-end">
                        <button class="btn btnyellow" onclick=" DeleteConfirmManagersDetails()">Yes</button>
                        <button class="btn borderbtn" data-bs-dismiss="modal">No</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <%--Added by Rutuja D on 6th July 2021--%>
    <div id="deleteConfirmAlert" class="modal fade custmodal" tabindex="-1" role="dialog" aria-hidden="true">
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
                    <p id="deleteConfirmMsg">
                        <center>Are you sure to delete the selected filter?</center>
                    </p>
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

    <div id="deleteConfirmAlert1" class="modal fade custmodal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                    <h4 class="modal-title">Delete Confirmation</h4>
                </div>
                <div class="modal-body">
                    <input type="text" id="DFilterID1" hidden="hidden" />
                    <input type="text" id="DFilterName1" hidden="hidden" />
                    <input type="text" id="DIsApplyed1" hidden="hidden" />
                    <p id="deleteConfirmMsg1">
                        <center>Are you sure to delete the selected filter?</center>
                    </p>
                </div>
                <div class="modal-footer">
                    <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal">No</button>
                    <button class="btn btnyellow" data-bs-toggle="modal" data-original-title="" data-bs-dismiss="modal" title="" onclick="confirmDelete1()">Yes</button>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>

    <%--End of Added by Rutuja D on 6th July 2021--%>

    <script>
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

        //Added By Riddhesh Patil on 07-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        //End of  Added By Riddhesh Patil

        var strUrl = '';
        var CurrentTabObject = { Details: 'false', Resources: 'false', Manager: 'false' };
        var ResourceCount = 0;
        var ManagersCount = 0;
        var NoDataFound = "No data found.";
        //Commented & Added By Dipali V On 6th April 2023 For Alert Isusue
       // var DeleteRecord = "Please select at least one record to delete.";
        var DeleteRecord = "Please select at least one record.";
        //End of Commented & Added By Dipali V On 6th April 2023 For Alert Isusue
        var DeleteConfirm = "Are you sure, you want to delete the selected records?";
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var blnCreateContingencyTask = false;
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var TagID = '<%= m_TagId%>';
        var ManagerTagID = 3901;

        var noOfRowsPerPage = 10;
        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';
        var selectedSkillIds = '';
        var showMessage = "Please select at least one record";
        var showSelectedList = [];
        var showSelectedListFormanagers = [];
        var OPRtable;
        var resourceTable;
        var managerTable;
        var resourceSelectionTable;
        var managerSelectionTable;
        var RPMatser = {
            ResourcePoolID: "",
            ResourcePoolCode: "",
            ResourcePoolName: "",
            Description: "",
            OtherAttribute: "",
            CreatedBy: "",
            ModifiedBy: "",
            SkillIds: ""
        };


        $(document).ready(function () {

            //Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
            AllBindPlaceHolderFun();
            //End of Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021

            clearTooltip();
            Multiselectddl();
            $('select[multiple]').multiselect();
            $('.multiselect').removeAttr('title'); //added by pradip on 17-7-2021 
            //GetMaximumItemsToShowInList();
            if (blnViewAccess == "True") {
                GetMaximumItemsToShowInList();
                GetSkills();
                GetResourcePool();
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }

            if (blnAddAccess == "False") {
                DisableEnableBtn(1)
            }
            else {
                DisableEnableBtn(0)
            }
            if (blnDeleteAccess == "False") {
                $("#DeletebtnRPM").addClass("clsShowHide");
                $('#btnDeleteResourcesDetails').addClass("clsShowHide");
                $('#btnDeleteManagersDetails').addClass("clsShowHide");
            }
            else {
                $("#DeletebtnRPM").removeClass("clsShowHide");
                $('#btnDeleteResourcesDetails').removeClass("clsShowHide");
                $('#btnDeleteManagersDetails').removeClass("clsShowHide");
            }

            $('.RPMtbl').resize();
        });

        function DisableEnableBtn(isTrue) {

            if (isTrue == '1') {
                $("#AddbtnRPM").addClass("clsShowHide");
                $('#spnAddResourcePool').addClass("clsShowHide");
                //$('#btnaAddResourcePool').attr("disabled", true);
                $('#btnAddRsrsSelection').addClass("clsShowHide");
                $('#AddRDUManager').addClass("clsShowHide");



            } else {

                $("#AddbtnRPM").removeClass("clsShowHide");
                $('#spnAddResourcePool').removeClass("clsShowHide");
                $('#btnAddRsrsSelection').removeClass("clsShowHide");
                $('#AddRDUManager').attr("disabled", false);

            }

        }

        function ClearFilterDetails(flag) {
            $("#cboRESFilterBusinessGroupID").val("0");
            $("#cboRESFilterLocationID").val("");
            $("#cboRESFilterResourcePoolID").val("");
            $("#cboRESFilterGroupID").val("");
            $("#cboRESFilterPostID").val("");
            $("#cboRESFilterDesignationID").val("");
            $("#cboRESFilterDepartmentID").val("");
            $("#cboRESFilterGradeID").val("");
            $("#cboRESFilterToolID").val("");
            $("#cboRESFilterTotalExp").val("");
            $("#cboRESFilterCertificationID").val("");
            $("#cboRESFilterQualificationID").val("");
            $("#cboRESFilterProjectID").val("");
            $("#cboRESFilterRPMID").val("");
            $("#cboRESFilterCountryID").val("");
            $("#cboRESFilterVisaTypeID").val("0");
            $("#cboRESFilterPassportNumber").val("");
            $("#cboTotalExpSel").val("Less");
            savedFilterName = "";
            $('#txtOPRFilterName').val("");
            FillOURSFilter(0);
            FillDURSFilter(0);
            FillDTRSFilter(0);
            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {
                    //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                    //$(this).removeAttr("checked");
                    $(this).prop("checked", false);
                    //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                   
                });
            }

        }
        //Apply saved filter   
        function ApplySavedFilter(FilterID, isDefault, isFromDefault) {
            //Changed  by mahesh on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {
                GetResourcesForSelection(RPMatser.ResourcePoolID)
                GetMyFilter(isDefault);
                FilterNotApplied();
                $('#AdvanceFilterIconForResources').attr("aria-expanded", false);
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
                            GetSklDetails(Querytext);
                        }
                        FilterApplied();
                        //GetBGDetails(Querytext);
                        // call business group getRiskDetails(currentselectedProjectID, 0, "", "defaultfilterapply", Querytext);
                        if (currentDefaultFilterID > 0) {
                            FilterApplied();
                        }
                        //  GetMyFilter(1);
                        if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                            GetMyFilter(0);
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
                if (isDefault == undefined) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Filter applied successfully.");
                }
            }
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
                        $("#txtOPRFilterName").val(currentFilterName);
                        savedFilterName = currentFilterName;
                        var fields = ObjFilterDtls.QueryText.toString().split('|');

                        var currWhereClauseOne = fields[0];
                        var currWhereClauseSec = fields[1];
                        if (currWhereClauseOne != undefined && currWhereClauseOne != null && currWhereClauseOne != "") {
                            if (currWhereClauseOne.toString().indexOf("AND") != -1) {
                                var arrFields = currWhereClauseOne.split("AND");
                                try {
                                    for (var i = 0; i < arrFields.length; i++) {
                                        setfiltervaluesOne(arrFields[i]);
                                    }
                                }
                                catch (ex) {
                                    //alert(ex.message);
                                }
                            }
                            else {
                                if (currWhereClauseOne != undefined && currWhereClauseOne != null && currWhereClauseOne != " ") {
                                    var currWhereClause = currWhereClauseOne.toString();
                                    setfiltervaluesOne(currWhereClause);
                                }
                            }
                        }
                        //FOR currWhereClauseSec
                        if (currWhereClauseSec != undefined && currWhereClauseSec != null && currWhereClauseSec != "") {

                            if (currWhereClauseSec.toString().indexOf("AND") != -1) {
                                var arrFields = currWhereClauseSec.split("AND");
                                try {
                                    for (var i = 0; i < arrFields.length; i++) {
                                        setfiltervaluesSec(arrFields[i]);
                                    }
                                }
                                catch (ex) {
                                    //alert(ex.message);
                                }
                            }
                            else {
                                if (currWhereClauseSec != undefined && currWhereClauseSec != null && currWhereClauseSec != " ") {
                                    var currWhereClause = currWhereClauseSec.toString();
                                    setfiltervaluesSec(currWhereClause);
                                }
                            }
                        }
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

        function setfiltervaluesOne(QueryTextOne) {
            var currWhereClause = QueryTextOne.toString().trim();

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
            if (arrFields[0] == "BusinessGroupID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                if (currValue.substring(1, 2) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterBusinessGroupID").val(parseInt(currValue));
            }
            if (arrFields[0] == "LocationID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterLocationID").val(currValue);
            }
            if (arrFields[0] == "ResourcePoolID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterResourcePoolID").val(currValue);
            }
            if (arrFields[0] == "GroupID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterGroupID").val(currValue);
            }
            if (arrFields[0] == "PostID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterPostID").val(currValue);
            }
            if (arrFields[0] == "DesignationID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterDesignationID").val(currValue);
            }
            if (arrFields[0] == "DepartmentID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterDepartmentID").val(currValue);
            }
            if (arrFields[0] == "GradeID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterGradeID").val(currValue);
            }

            if (arrFields[0] == "TotalExp") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboTotalExpSel", "cboRESFilterTotalExp");
            }
            if (arrFields[0] == "PassportNumber") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterPassportNumber").val(currValue);
            }

        }

        function setfiltervaluesSec(QueryTextSec) {
            var currWhereClause = QueryTextSec.toString().trim();

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

            if (arrFields[0] == "ToolID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterToolID").val(currValue);
            }
            if (arrFields[0] == "CertificationID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterCertificationID").val(currValue);
            }
            if (arrFields[0] == "QualificationID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterQualificationID").val(currValue);
            }
            if (arrFields[0] == "ProjectID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterProjectID").val(currValue);
            }
            if (arrFields[0] == "RPMID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterRPMID").val(currValue);
            }
            if (arrFields[0] == "CountryID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterCountryID").val(currValue);
            }
            if (arrFields[0] == "VisaTypeID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#cboRESFilterVisaTypeID").val(currValue);
            }

        }

        function setFilterOpComboFieldValue(currWhereClause, arrFields, OpComboName, ValueComboName) {

            if (arrFields[1] == "<") {
                setFilterComboValue(OpComboName, "Less");
            }
            if (arrFields[1] == "<=") {
                setFilterComboValue(OpComboName, "LessEqual");
            }
            if (arrFields[1] == ">") {
                setFilterComboValue(OpComboName, "Greater");
            }
            if (arrFields[1] == "=") {
                setFilterComboValue(OpComboName, "=");
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

            $("#" + ValueComboName).val(currValue);

        }
        function setFilterComboValue(fieldName, fieldValue, flag) {
            $("#" + fieldName).val(fieldValue);
        }
        function clearTooltip() {
            $('body').tooltip({
                selector: '[title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[title]:not([data-bs-toggle="popover"])', function () {
                $('[title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
        }

        function FilterApplied() {
            $(".mainclearalllink").removeClass("clsShowHide");
            $(".filter >  button").addClass("clsFilterHighlight");

        }

        function FilterNotApplied() {
            $(".mainclearalllink").addClass("clsShowHide");
            $(".filter >  button").removeClass("clsFilterHighlight");
            $('#AdvanceFilterIconForResources').attr("aria-expanded", false);
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
            if ($('.filterpanel1').hasClass("show")) {
                $('.filterpanel1').removeClass("show");
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
            GetSklDetails(null);
            GetMyFilter(0);//Added By Mahesh on 21 july 2021
            GetMyMGRFilter(0);//Added By Mahesh on 21 july 2021
        });

        function GetSklDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                filter = whereClause.toString().replace(/\'/g, '"');
                //  var whereClauseFormated = whereClause.replace(/'/g, "\''");
            }
            GetResourcesForSelection(RPMatser.ResourcePoolID, filter);
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
                    $("#MyFiltersdropdown1").empty();
                    if ($("#MyFiltersdropdown1").hasClass("dropdown-menu")) {

                    }
                    else {
                        $("#MyFiltersdropdown1").addClass("dropdown-menu");
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

                        $("#MyFiltersdropdown1").html(strHTML);
                        if (strHTML != "" && defaultFilterId != 0 && flag != 0 && flag != 3) {
                            ApplySavedFilter(defaultFilterId, 1);
                        }
                        //else {
                        //    GetBusinessGroups(null);
                        //}

                        $("#MyFiltersdropdown1").removeClass("clsShowHide");
                    }
                    else {
                        $("#MyFiltersdropdown1").addClass("clsShowHide");
                        $("#MyFiltersdropdown1").removeClass("dropdown-menu");
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
                        ApplySavedFilter(FilterID, 2, true);//changed by mahesh on 21 july 2021
                        /**Added By Dipali V On 31st March 2023 For UI Issue*/
                        //alertify.success('Filter Is Successfully Set As Default!');
                        alertify.success("Default Filter Set successfully.");
                        /**En dof Added By Dipali V On 31st March 2023 For UI Issue*/
                        // ApplySavedFilter(FilterID, 2);
                        $('#AdvanceFilterIconForResources').attr("aria-expanded", true);
                        FilterApplied();

                    }
                    else {
                        ApplySavedFilter(FilterID, 3, true);//changed by mahesh on 21 july 2021
                        /**Added By Dipali V On 31st March 2023 For UI Issue*/
                        //alertify.success('Default Filter Is Successfully Removed!');
                        alertify.success("Default Filter Removed Successfully");
                        /**End of Added By Dipali V On 31st March 2023 For UI Issue*/
                        //FilterNotApplied();
                        //GetMyFilter(0);
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIconForResources').attr("aria-expanded", false);
                        FilterNotApplied();
                    }
                    currentappliedfilter = 0



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
                            GetResourcesForSelection(RPMatser.ResourcePoolID);
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyFilter(0);
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

        function checkFiltervalidationForResources() {
            //debugger;
            var BgID = $("#cboRESFilterBusinessGroupID").val() == "" ? null : $("#cboRESFilterBusinessGroupID").val();
            var locationID = $("#cboRESFilterLocationID").val() == "" ? null : $("#cboRESFilterLocationID").val();
            var RpID = $("#cboRESFilterResourcePoolID").val() == "" ? null : $("#cboRESFilterResourcePoolID").val();
            var GroupID = $("#cboRESFilterGroupID").val() == "" ? null : $("#cboRESFilterGroupID").val();
            var RoleDesc = $("#cboRESFilterPostID").val() == "" ? null : $("#cboRESFilterPostID").val();
            var DesignationID = $("#cboRESFilterDesignationID").val() == "" ? null : $("#cboRESFilterDesignationID").val();
            var DepartmentID = $("#cboRESFilterDepartmentID").val() == "" ? null : $("#cboRESFilterDepartmentID").val();
            var GradeID = $("#cboRESFilterGradeID").val() == "" ? null : $("#cboRESFilterGradeID").val();
            var ToolID = $("#cboRESFilterToolID").val() == "" ? null : $("#cboRESFilterToolID").val();
            var TotalExp = $("#cboRESFilterTotalExp").val() == "" ? null : $("#cboRESFilterTotalExp").val();
            var CertificationID = $("#cboRESFilterCertificationID").val() == "" ? null : $("#cboRESFilterCertificationID").val();
            var QualificationID = $("#cboRESFilterQualificationID").val() == "" ? null : $("#cboRESFilterQualificationID").val();
            var ProjectID = $("#cboRESFilterProjectID").val() == "" ? null : $("#cboRESFilterProjectID").val();
            var RPMId = $("#cboRESFilterRPMID").val() == "" ? null : $("#cboRESFilterRPMID").val();
            var CountryID = $("#cboRESFilterCountryID").val() == "" ? null : $("#cboRESFilterCountryID").val();
            var VisaTypeID = $("#cboRESFilterVisaTypeID").val() == "" ? null : $("#cboRESFilterVisaTypeID").val();
            var PassportNo = $("#cboRESFilterPassportNumber").val() == "" ? null : $("#cboRESFilterPassportNumber").val();

            if ((BgID == null || BgID == 'undefined' || BgID == 0) && (locationID == null || locationID == 'undefined' || locationID == 0) && (RpID == null || RpID == 'undefined' || RpID == 0)
                && (GroupID == null || GroupID == 'undefined' || GroupID == 0) && (RoleDesc == null || RoleDesc == 'undefined' || RoleDesc == 0) && (DesignationID == null || DesignationID == 'undefined' || DesignationID == 0)
                && (DepartmentID == null || DepartmentID == 'undefined' || DepartmentID == 0) && (GradeID == null || GradeID == 'undefined' || GradeID == 0) && (ToolID == null || ToolID == 'undefined' || ToolID == 0)
                && (TotalExp == null || TotalExp == 'undefined' || TotalExp == 0) && (CertificationID == null || CertificationID == 'undefined' || CertificationID == 0) && (QualificationID == null || QualificationID == 'undefined' || QualificationID == 0)
                && (ProjectID == null || ProjectID == 'undefined' || ProjectID == 0) && (RPMId == null || RPMId == 'undefined' || RPMId == 0) && (CountryID == null || CountryID == 'undefined' || CountryID == 0)
                && (VisaTypeID == null || VisaTypeID == 'undefined' || VisaTypeID == 0) && (PassportNo == null || PassportNo == 'undefined' || PassportNo == 0)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
                //Commented by imran on 18-08-2022
                //$('#SklSavefilter').modal('hide');
                //End of comment by imran on 18-08-2022
            }
            else {

                $('#SklSavefilter').modal('show');
                //document.addEventListener("DOMContentLoaded", function (event) {
                //    $('#SklSavefilter').modal('show');
                //});


            }



        }

        //Filter REsource Section
        function SaveOPRFilterDetails() {
            //Added by imran on 18-08-2022
            var fltFilterName = $("#txtOPRFilterName").val();
            var fltFilterName = $("#txtOPRFilterName").val().trim();
            //End of comment by imran on 18-08-2022
            if (fltFilterName == "") {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter filtername');

                $("#txtOPRFilterName").focus();
            }
            else {
                var filterExists = 0;
                var AllRESFilterFirst = ["BusinessGroupID", "LocationID", "ResourcePoolID", "GroupID", "PostID", "DesignationID", "DepartmentID", "GradeID", "TotalExp", "PassportNumber"];
                var AllRESFilterSecond = ["ToolID", "CertificationID", "QualificationID", "ProjectID", "RPMID", "CountryID", "VisaTypeID"];
                var filterClause1 = GenerateBasicFilterQueryRESFirst("RES", AllRESFilterFirst);
                var filterClause2 = GenerateBasicFilterQueryRESSecond("RES", AllRESFilterSecond);
                //filterWhereClause.toString().replace(/\''/g, "'");
                var filterClauseFirst = filterClause1.toString().replace(/\"/g, "'");
                var filterClauseSecond = filterClause2.toString().replace(/\"/g, "'");

                var filterClauseFinal = filterClauseFirst + ' | ' + filterClauseSecond;
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
                    WhereClause: encodeURI(filterClauseFinal),
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
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                        }
                        else {
                            if (data != undefined && data != "") {
                                currentFilterID = data;
                                currentappliedfilter = currentFilterID;
                            }
                            $('#SklSavefilter').modal('hide');
                            FilterApplied();
                            GetMyFilter(0);
                            applyFilterResWhere();
                            savedFilterName = fltFilterName;

                            $("#txtOPRFilterName").val('');
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
        function onCloseSaveRes() {
            $('#SklSavefilter').modal('hide');
            // ClearFilterDetails("");
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtOPRFilterName').val("");
            }
        }

        function OnCloseResourceAdd() {
            currentDefaultFilterID = 0;
            ApplySavedFilter(currentDefaultFilterID, 0);
            ClearFilterDetails("");
            $(".mainclearalllink").addClass("clsShowHide");
        }

        function GenerateBasicFilterQueryRESFirst(module, filterField) {
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    if (strOp != null && strOp != 'undefined' && strOp != "") {
                        strvalue = strOp
                    }
                    if (filterField[i] == "PassportNumber" && strvalue != "" && strvalue != undefined) {
                        if (strqtext != "") strqtext += " AND ";
                        strqtext += filterField[i] + " " + strvalue;
                    }
                    else if (strvalue != "" && strvalue != undefined && strvalue != "0") {

                        if (strqtext != "") strqtext += " AND ";
                        if (strOp != "0") {
                            if ($('#cboTotalExpSel').val() == "Less" && filterField[i] == "TotalExp") {

                                strqtext += filterField[i] + " < ";
                                strqtext += ' "' + strvalue + '"';
                            }
                            else if ($('#cboTotalExpSel').val() == "LessEqual" && filterField[i] == "TotalExp") {

                                strqtext += filterField[i] + " <= ";
                                strqtext += ' "' + strvalue + '"';
                            }
                            else if ($('#cboTotalExpSel').val() == "Greater" && filterField[i] == "TotalExp") {

                                strqtext += filterField[i] + " > ";
                                strqtext += ' "' + strvalue + '"';
                            }
                            else {
                                strqtext += filterField[i] + " = ";
                                //strqtext += " ''%" + strvalue + "%''";
                                strqtext += '"' + strvalue + '"';
                            }

                        }
                        else {
                            strqtext += filterField[i] + " ";
                            if ($.isNumeric(strvalue) == false) {
                                strqtext += strOp + " ''" + strvalue + "''";
                            }
                            else {
                                strqtext += strOp + ' "' + strvalue + '"';
                            }
                            //}
                        }
                    }
                }

                strqtext = strqtext.replace('Over', '[Over]')
                strqtext = strqtext.replace(/'/g, "''");
                //strqtext = strqtext.replace(/"/g, "''");
                //console.log("FIRST", strqtext);
                return strqtext;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        function GenerateBasicFilterQueryRESSecond(module, filterField) {
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
                    }
                }

                strqtext = strqtext.replace('Over', '[Over]')
                strqtext = strqtext.replace(/'/g, "''");
                return strqtext;
                return strqtext;
            }
            catch (ex) {
            }
        }

        function applyFilterResWhere() {
            currentFilterID = 0;
            var AllRESFilterFirst = ["BusinessGroupID", "LocationID", "ResourcePoolID", "GroupID", "PostID", "DesignationID", "DepartmentID", "GradeID", "TotalExp", "PassportNumber"];
            var AllRESFilterSecond = ["ToolID", "CertificationID", "QualificationID", "ProjectID", "RPMID", "CountryID", "VisaTypeID"];
            var filterClauseFirst = GenerateBasicFilterQueryRESFirst("RES", AllRESFilterFirst);
            var filterClauseSecond = GenerateBasicFilterQueryRESSecond("RES", AllRESFilterSecond);
            var filterClauseFinal = filterClauseFirst + ' | ' + filterClauseSecond;

            if (filterClauseFirst == '' && filterClauseSecond == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
            } else {
                GetResourcesForSelection(RPMatser.ResourcePoolID, filterClauseFinal);
                FilterApplied();
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");
            }
        }
        //End REsource Section

        function FillOU(value) {
            //Added By Rutuja D. for Onchange of BG OU set Properly on 14 July 2021
            var SelOU = $("#cboRPMFilterLocationID").val();
            //End of Added By Rutuja D. for Onchange of BG OU set Properly on 14 July 2021
            var objBGCODE = { BusinessGroupID: value }
            if (value == null) {
                value = "0";
            }
            var strHTML = "";
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetOrgUnitForFilter',
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
                    strHTML += "<option value='0' selected>Select Organization Unit</option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    }

                    $("#cboRPMFilterLocationID").html(strHTML);
                    //Added By Rutuja D. for Onchange of BG OU set Properly on 14 July 2021
                    if (SelOU != '') {
                        $("#cboRPMFilterLocationID").val(SelOU);
                        if ($("#cboRPMFilterLocationID").val() == '' || $("#cboRPMFilterLocationID").val() == null || $("#cboRPMFilterLocationID").val() == undefined) {
                            $("#cboRPMFilterLocationID").val('0');
                        }
                    } else {
                        $("#cboRPMFilterLocationID").val('0');
                    }
                    //End of Added By Rutuja D. for Onchange of BG OU set Properly on 14 July 2021

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
                          //  window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue              
            })

        }

        function FillOURSFilter(value) {
            if (value == null) {
                value = "0";
            }
            var objBGCODE = { BusinessGroupID: value }

            var strHTML = "";
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetOrgUnitForFilter',
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
                    strHTML += "<option value='0'>Select Organization Unit</option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    }
                    $("#cboRESFilterLocationID").html(strHTML);

                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue              
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

        function FillDURSFilter(value, param) {
            var strHTML = "";
            var objLocationID = { LocationID: value }
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetResourcePoolForLocation',
                type: "POST",
                data: JSON.stringify(objLocationID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objLocationID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objLocationID) ? objLocationID : JSON.stringify(objLocationID)));
                    }
                },
                success: function (data) {
                    strHTML += "<option value='0'>Select Delivery Unit</option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.ResourcePoolID + ' >' + listComponent.ResourcePoolName + '</option>');
                    }
                    $("#cboRESFilterResourcePoolID").html(strHTML);
                    if (param != null && param > 0 && param != undefined) {
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
            })

        }

        function FillFilterOUForFilter(params) {
            var strHTML = "";
            if (params == null) {
                params = "0";
            }
            var objBGCODE = { BusinessGroupID: params }
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetOrgUnitForFilter',
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
                    strHTML += "<option value='0'></option>";
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

        function FillFilterOUForFilterResourceMang(params) {
            var strHTML = "";
            var BgID = $('#CboMGRFilterBusinessGroupID').val();
            //Added by imran on 19-08-2022
            if (BgID == "") {
                BgID = 0;
            }

            if (BgID == "0" || BgID == null) {
                BgID = 0;
            }
            //End of comment by imran on 19-08-2022
            var objBGCODE = { BusinessGroupID: BgID }

            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetOrgUnitForFilter',
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
                    strHTML += "<option value='0'>Select Organization Unit</option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    }
                    if (params != null && params > 0 && params != undefined)
                        $("#CboMGRFilterLocationID").val(params);

                    $("#CboMGRFilterLocationID").html(strHTML);

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

        function FillDTRSFilter(value, param) {
            var strHTML = "";
            var objDTLocationID = { LocationID: value }
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetDeliveryTeam',
                type: "POST",
                data: JSON.stringify(objDTLocationID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objDTLocationID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objDTLocationID) ? objDTLocationID : JSON.stringify(objDTLocationID)));
                    }
                },
                success: function (data) {
                    strHTML += "<option value='0'>Select Delivery Team</option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];

                        strHTML += ('<option value=' + listComponent.GroupID + ' >' + listComponent.GroupName + '</option>');
                    }
                    $("#cboRESFilterGroupID").html(strHTML);
                    if (param != null && param > 0 && param != undefined) {
                        //$("#cboDT").val(param);
                    }

                },
                //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue              
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
        function initializeDependateFilterCboForRSModel() {
            FillOU(0);
        }

        function GetSkills() {
            var param = {
                SklWhereClause: ""
            };
            var strHTML = "";
            $.ajax({
                url: strUrl + '/api/RM_Skill/GetSkills',
                type: "Post",
                data: JSON.stringify(param),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    $('#plnReviewer').html('');
                    $.each(data, function () {
                        $('#plnReviewer').append($("<option></option>").val(this['ToolID']).html(this['Description']));
                    });
                    $('#plnReviewer').multiselect('rebuild');
                    Multiselectddl();
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue              
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-center');
                //    alertify.error(err);
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
        function cancelDetails() {
            $(".RPMtblouter").removeClass("DisableContent").parent().css("cursor", "no-drop");
            $("#selectedSkills").val(0);
            $("#cboRPMFilterBusinessGroupID").val(0);
            $("#cboRPMFilterLocationID").val(0);
            $("#cboRPMFilterIsResourceActive").val(0);
            //Added By Dipali V On 29th March 2023 For Hide Skill 
            $(".multiselect-container dropdown-menu").removeClass('show');
            //End of Added By Dipali V On 29th March 2023 For Hide Skill
        }
        function onClose() {
            $("#selectedSkills").val(0);
            $("#txtCode").val("");
            $("#txtResourcePool").val("");
            $("#txtOtherAttribute").val("");
            $("#txtDescription").val("");
            //Added By Dipali V On 29th March 2023 For Hide Skill 
            $(".multiselect-container dropdown-menu").removeClass('show');
            //End of Added By Dipali V On 29th March 2023 For Hide Skill
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
            if ($("#txtCode").val() == undefined || !($("#txtCode").val()).trim()) {
                $("#txtCode").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter resource pool code");
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 07-NOV-2022 

            //else if ($("#txtCode").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtCode").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Code cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}


            else if (checkSpecialCharacter($("#txtCode").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Code should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtCode").focus();
                chkval = 1;
                return chkval;
            }
            //End of Commnet Added By Riddhesh Patil
            else if ($("#txtResourcePool").val() == undefined || !($("#txtResourcePool").val()).trim()) {
                $("#txtResourcePool").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter resource pool name");
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 07-NOV-2022 

            //else if ($("#txtResourcePool").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtResourcePool").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Resource Pool cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}

            else if (checkSpecialCharacter($("#txtResourcePool").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Resource Pool should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtResourcePool").focus();
                return false;
            }
            //End of Commnet Added By Riddhesh Patil
            else if (($("#txtCode").val()).startsWith(" ")) {
                $("#txtCode").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Resource pool code should not start with space");
                return false;
            }
            else if (($("#txtResourcePool").val()).startsWith(" ")) {
                $("#txtResourcePool").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Resource pool name should not start with space");
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 07-NOV-2022

            //else if ($("#txtOtherAttribute").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtOtherAttribute").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Other Attribute cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtOtherAttribute").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Other Attribute should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtOtherAttribute").focus();
                return false;
            }
            //End of Commnet Added By Riddhesh Patil
            //Added By Riddhesh Patil on 07-NOV-2022
            else if (checkSpecialCharacter($("#txtDescription").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtDescription").focus();
                return false;
            }
            //End of Added By Riddhesh Patil
            else {
                validateflag = true;
                return true;
            }
        }

        var validateflag
        function saveResourcePool(isFromSaveClick) {
            checkValidation();
            if (validateflag == true) {
                RPMatser.ResourcePoolCode = $("#txtCode").val().replace(/'/g, "''");;
                RPMatser.ResourcePoolName = $("#txtResourcePool").val().replace(/'/g, "''");;
                RPMatser.OtherAttribute = $("#txtOtherAttribute").val().replace(/'/g, "''");;
                RPMatser.Description = $("#txtDescription").val().replace(/'/g, "''");
                RPMatser.IntUserId = SessionEmployeeId;
                RPMatser.CreatedBy = UserName;
                //added by imran on 19-08-2022
                RPMatser.ResourcePoolID = 0;
                //End of comment by imran
                $.ajax({
                    url: strUrl + '/api/RM_ResourcePoolMaster/SaveResourcePoolMaster',
                    type: "POST",
                    data: JSON.stringify(RPMatser),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (RPMatser) {
                            xhr.setRequestHeader("Params", encryptString(isJson(RPMatser) ? RPMatser : JSON.stringify(RPMatser)));
                        }
                    },
                    success: function (data) {
                        GetResourcePool();

                        if (isFromSaveClick == 0) {
                            //$("#AddRPMpopup").modal('hide');
                            if (data == "Resource Pool Code already exist." || data == "Resource Pool Name already exist.") {
                                //Added by Chetan M on 14 Jul 2021
                                if (data.indexOf('Resource Pool Name') != -1) {
                                    $("#txtResourcePool").focus();
                                } else {
                                    $("#txtCode").focus();
                                }
                                //End of Added by Chetan M on 14 Jul 2021
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                $("#AddRPMpopup").modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                onClose();
                            }
                        }
                        else {
                            if (data == "Resource Pool Code already exist." || data == "Resource Pool Name already exist.") {
                                //Added by Chetan M on 14 Jul 2021
                                if (data.indexOf('Resource Pool Name') != -1) {
                                    $("#txtResourcePool").focus();
                                } else {
                                    $("#txtCode").focus();
                                }
                                //End of Added by Chetan M on 14 Jul 2021
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);

                            }
                            else {
                                onClose();
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                            }
                        }

                        $(".Resourcedetailpanel").hide();
                        $(".backbtn, .paginate_button, .AddRPMbtn, .DelRPMbtn").removeClass("DisableContent").parent().css("cursor", "auto");

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
                    }
                });

            } else {
                return false;
            }
        }

        function checkEditValidation() {
            if ($("#txtEditCode").val() == undefined || $("#txtEditCode").val() == "") {
                $("#txtEditCode").focus();
                validateEditflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter resource pool code");
                return false;
            }
            //else if ($("#txtEditCode").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtEditCode").focus();
            //    validateEditflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Code cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtEditCode").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Code should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtEditCode").focus();
                validateEditflag = false;
                return false;
            }
            else if ($("#txtEditResourcePool").val() == undefined || $("#txtEditResourcePool").val() == "") {
                $("#txtEditResourcePool").focus();
                validateEditflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter resource pool name");
                return false;
            }
            //else if ($("#txtEditResourcePool").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtEditResourcePool").focus();
            //    validateEditflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Resource Pool cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtEditResourcePool").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Resource Pool should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtEditResourcePool").focus();
                validateEditflag = false;
                return false;
            }
            else if (selectedSkillIds == null || selectedSkillIds == undefined || selectedSkillIds == "") {
                $('#plnReviewer').focus();
                validateEditflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select skill set");
                return false;
            }
            //else if ($("#txtEditOtherAttribute").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtEditOtherAttribute").focus();
            //    validateEditflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Other Attribute cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtEditOtherAttribute").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Other Attribute should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtEditOtherAttribute").focus();
                validateEditflag = false;
                return false;
            }
            else if ($("#txtEditDescription").val() != "") {
                if (checkSpecialCharacter($("#txtEditDescription").val().trim(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtEditDescription").focus();
                    validateEditflag = false;
                    return false;
                }
            }
            else {
                validateEditflag = true;
                return true;
            }
        }

        //Commented & Added By Dipali V On 27th March 2023 For Skill saving Issue
        //var validateEditflag;
        var validateEditflag = true;
        //End of Commented & Added By Dipali V On 27th March 2023 For Skill saving Issue
        function editResourcePool(isFromSaveClick) {
            checkEditValidation();
            if (validateEditflag == true) {
                RPMatser.SkillIds = selectedSkillIds;
                RPMatser.ResourcePoolCode = $("#txtEditCode").val().replace(/'/g, "''");
                RPMatser.ResourcePoolName = $("#txtEditResourcePool").val().replace(/'/g, "''");
                RPMatser.OtherAttribute = $("#txtEditOtherAttribute").val().replace(/'/g, "''");
                RPMatser.Description = $("#txtEditDescription").val().replace(/'/g, "''");
                RPMatser.IntUserId = SessionEmployeeId;
                RPMatser.CreatedBy = UserName;
                $.ajax({
                    url: strUrl + '/api/RM_ResourcePoolMaster/UpdateResourcePoolMaster',
                    type: "POST",
                    data: JSON.stringify(RPMatser),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (RPMatser) {
                            xhr.setRequestHeader("Params", encryptString(isJson(RPMatser) ? RPMatser : JSON.stringify(RPMatser)));
                        }
                    },
                    success: function (data) {
                        GetResourcePool();
                        onClose();
                        if (data == "Resource Pool Name already exist.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $("#txtResourcePool").focus();  //Added by Chetan M on 14 Jul 2021
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                            //Added By Dipali V On 29th March 2023 For Hide Skill 
                            $(".multiselect-container dropdown-menu").removeClass('show');
                            //End of Added By Dipali V On 29th March 2023 For Hide Skill 

                        }
                        if (isFromSaveClick == 0) {
                            $("#RRPMDetail").modal('hide');
                            $(".RPMtblouter").addClass("DisableContent").parent().css("cursor", "auto");
                        }
                        else if (isFromSaveClick == 1 && data == "Resource Pool Name already exist.") {
                            $("#AddRPMpopup").modal('hide');
                            $("#txtResourcePool").focus(); //Added by Chetan M on 14 Jul 2021
                        }
                        else {
                            onClose();
                            $("#AddRPMpopup").modal('show');
                            //Added By Dipali V On 29th March 2023 For Hide Skill 
                            $(".multiselect-container dropdown-menu").removeClass('show');
                            //End of Added By Dipali V On 29th March 2023 For Hide Skill
                            $(".RPMtblouter").removeClass("DisableContent").parent().css("cursor", "auto");
                        }
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
                    }
                });

            } else {
                return false;
            }
        }
        document.getElementById('plnReviewer').onchange = function () {
            var selectedIDS = [];
            for (var i = 0; i < document.getElementById('plnReviewer').options.length; i++) {
                if (document.getElementById('plnReviewer').options[i].selected) {
                    selectedIDS.push(document.getElementById('plnReviewer').options[i].value);
                }
            }

            selectedSkillIds = selectedIDS.toString();
        }

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();
        $(".table").resize();

        function editRPMUI() {
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid 
            $(".RPMtblouter .dataTables_scrollBody, .backbtn, .paginate_button,.AddRPMbtn, .DelRPMbtn").addClass("DisableContent").parent().css("cursor", "no-drop");
            $(".table").resize();
        }

        function editRPM() {
            Multiselectddl();
            editRPMUI();
            $('[title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            //set Values
            $('#tblResourcePool').on('click', '.RPMdetalilink', function () {
                var $row = $(this).closest("tr");
                $tds = $row.find("td");
                var hdnRPMId = $row.find('#hdn_ResourcePoolID').val();

                //Commented & Added By Rutuja D. on 16 July 2021 For IssueID = 26728
                //var txtOT = $row.find('#hdnOT').val();
                var txtOT = unescape($row.find('#hdnOT').val());
                //End of Commented & Added By Rutuja D. on 16 July 2021 For IssueID = 26728

                var selectedSkills = $row.find('#hdnSkillIDs').val();
                if (selectedSkills == null || selectedSkills.length == 0 || selectedSkills == "") {

                    selectedSkillIds = "";
                }
                else {
                    selectedSkillIds = selectedSkills;
                }
                // if()
                var reviewerArray = selectedSkills.split(',');

                $("#plnReviewer option").each(function (i, val) {

                    var optionText = $(this).text();
                    var optionValue = $(this).val();
                    if (jQuery.inArray(optionValue, reviewerArray) != "-1") {

                        $("#plnReviewer").multiselect('select', [optionValue]);
                    }
                    else {
                        $("#plnReviewer").multiselect('deselect', [optionValue]);
                    }
                });
                $.each($tds, function (index, obj) {
                    if (index == 0) {
                        $('#txtEditCode').val($(this).text().trim());
                        $('#txtEditCode').attr("disabled", true);
                    }
                    if (index == 1) {
                        $('#txtEditResourcePool').val($(this).text().trim());
                    }
                    if (index == 2) {
                        $('#txtEditDescription').val($(this).text());
                    }
                    $('#txtEditOtherAttribute').val(txtOT);
                    RPMatser.ResourcePoolID = hdnRPMId;
                });
            });
        }
        $(".RPMdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $(".RPMtblouter .dataTables_scrollBody, .backbtn, .paginate_button, .AddRPMbtn, .DelRPMbtn").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".detailsubtabs li:first-child a").tab("show");
            $(".table").resize();
        });

        function Multiselectddl() {
            $('#plnReviewer').multiselect({
                includeSelectAllOption: true,
                //countSelectedText: false,
                //nSelectedText: true,
                //Added and modifed by pradip on 17-7-2021
                countSelectedText: 'Selected',
                nSelectedText: 'Selected',
                allSelectedText: false,
                selectAllJustVisible: true,
                numberDisplayed: 3,
                maxHeight: 250,
                nonSelectedText: 'Please Select Skills ',
                delimiterText: ', ',
                onSelectAll: function () {
                    $('button[class="multiselect"]').attr('title', false);

                },
                buttonTitle: function () { },
            });

            $('.multiselect-container label').prop('title', ''); //Added and modifed by pradip on 17-7-2021         
        }

        function GetResourceResume(EmployeeID) {
            window.open('../Resources/Resume.aspx?EmployeeID=' + EmployeeID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100');

        }
        //datatable
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 10;
            OPRtable = $('#tblResourcePoolMaster').dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": false,
                "scrollY": true,
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
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [3] }]// Added By Pradip on 20 July 2021
            });

        }


        function LoadPaginationForManagers(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            managerTable = $('#ManagersTbl').dataTable({
                "dtat": data,
                "sScrollY": (0.5 * $(window).height()),
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
                "bScrollCollapse": true,
                "bAutoWidth": true,
                "sScrollX": "100%",
                "sScrollXInner": "100%",
                //Added by imran on 19-08-2022
                pageLength: 10,
                //End of comment by imran on 19-08-2022
            });

        }

        function LoadPaginationForResources(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            resourceTable = $('#ResourcesTbl').dataTable({
                "dtat": data,
                "sScrollY": (0.5 * $(window).height()),
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
                "bScrollCollapse": true,
                "bAutoWidth": true,
                "sScrollX": "100%",
                "sScrollXInner": "100%",
                //Added by imran on 30-08-2022
                pageLength: 10,
                //End of comment by imran on 30-08-2022
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [5] }]// Added By Pradip on 20 July 2021
            });

        }

        function LoadAddResourcePagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            managerSelectionTable = $('#AddRPMTbl').dataTable({
                "dtat": data,
                "sScrollY": (0.5 * $(window).height()),
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
                "bScrollCollapse": true,
                "bAutoWidth": true,
                "sScrollX": "100%",
                "sScrollXInner": "100%",
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [5] }]// Added By Pradip on 20 July 2021
            });
            $('table').resize(); //added by pradip on 14-7-2021
        }

        //resource count
        function GetRPMResourceCount(ResourcePoolID) {
            var param = { ResourcePoolID: ResourcePoolID }
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetResourceCount',
                type: "POST",
                data: JSON.stringify(param),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {

                    ResourceCount = data;
                    $("#ResCount").text(ResourceCount);
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
                    //StopAjaxLoader("#body-RPM");
                }
            })
            return ResourceCount;

        }
        //Managers count
        function GetRPMManagersCount(ResourcePoolID) {
            var param = { ResourcePoolID: ResourcePoolID }
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetManagersCount',
                type: "POST",
                data: JSON.stringify(param),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {

                    ManagersCount = data;
                    $("#MgrCount").text(ManagersCount);
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
                    //StopAjaxLoader("#body-RPM");
                }
            })
            //return ManagersCount;

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


                }
            })

        }

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {

            $(".table").resize();

        });
        $(".modal").on('hide.bs.modal', function () {
            $(".table").resize();
        });
        $(".modal").on('hidden.bs.modal', function () {
            $(".table").resize();
        });


        function resizeSection() {
            var tblheight = $(window).height();
            $('.RPMtblouter .dataTables_scrollBody').css({ 'height': tblheight - 166, "overflow-y": "auto" });//modifiy by pradip on 9-7-2021

        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });




        $("#filterpanel").on("show.bs.collapse", function () {
            // $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            //$(".clearalllink").hide();
        });

        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var allPages = OPRtable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#tblResourcePoolMaster").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedEmpID.push(parseInt($(rows[i]).find("#hdn_ResourcePoolID").val()));
                    }

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedEmpID = [];
                }
            }
        });
        $(".chckHead1").change(function () {
            var allPages = resourceTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#ResourcesTbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedResourceDetailID.push(parseInt($(rows[i]).find("#hdn_ResourcePoolDetailID").val()));
                    }
                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedResourceDetailID = [];
                }
            }
        });
        $(".chckHead2").change(function () {
            var allPages = managerTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#ManagersTbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedManagerDetailID.push(parseInt($(rows[i]).find("#hdn_ResourcePoolManagerID").val()));
                    }
                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedManagerDetailID = [];
                }
            }
        });
        $(".chckHead3").change(function () {
            var allPages = managerSelectionTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#AddRPMTbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedEmpIDForManager.push(parseInt($(rows[i]).find("#hdn_EmployeeIDForManager").val()));
                    }
                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedEmpIDForManager = [];
                }
            }
        });
        $(".chckHead4").change(function () {
            var allPages = resourceSelectionTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#tblResourceSelectionMain").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedEmpIDRes.push(parseInt($(rows[i]).find("#hdn_EmployeeID").val()));
                    }
                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedEmpIDRes = [];
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


        function checkUncheck() {

            if (OPRtable.$('input:checked').length == OPRtable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                //$(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
                //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
            }
        }

        function checkUncheckResource() {

            if (resourceTable.$('input:checked').length == resourceTable.fnGetNodes().length) {
                $(".chckHead1").prop("checked", true);
            } else {
                //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                /* $(".chckHead1").removeAttr("checked");*/
                $(".chckHead1").prop("checked", false);
                //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                // SelectedResourceDetailID = [];
            }
        }

        function checkUncheckManagers() {

            if (managerTable.$('input:checked').length == managerTable.fnGetNodes().length) {
                $(".chckHead2").prop("checked", true);
            } else {
                //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
               // $(".chckHead2").removeAttr("checked");
                $(".chckHead2").prop("checked", false);
                //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                // SelectedManagerDetailID = [];
            }
        }



        function checkUncheckManagersSelection() {

            if (managerSelectionTable.$('input:checked').length == managerSelectionTable.fnGetNodes().length) {
                $(".chckHead3").prop("checked", true);
            } else {
                //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
               // $(".chckHead3").removeAttr("checked");
                $(".chckHead3").prop("checked", false);
                //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
            }
        }

        function checkUncheckResourceSelection() {
            if (resourceSelectionTable.$('input:checked').length == resourceSelectionTable.fnGetNodes().length) {
                $(".chckHead4").prop("checked", true);
            } else {
                //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
               // $(".chckHead4").removeAttr("checked");
                $(".chckHead4").prop("checked", false);
                //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                // SelectedManagerDetailID = [];
            }
        }

        function AddRsrsSelection() {
            $('#btnShowselectedResource').html("Show Selected Resource");
            var poolID = RPMatser.ResourcePoolID;
            FillOURSFilter(0);
            FillDURSFilter(0);
            FillDTRSFilter(0);

            GetMyFilter(0);
            if (currentDefaultFilterID > 0) {
                ApplySavedFilter(currentDefaultFilterID, 2);
                FilterApplied();

            } else {
                GetSklDetails(null);
                FilterNotApplied();
                $('#filterpanel1').attr("aria-expanded", false);
                $('#filterpanel1').removeClass("in");
                //  $('#AdvanceFilterIconForResources').attr("aria-expanded", false);
                ClearFilterDetails();
            }



            // var myWindow = window.open('AddResourceSelection.aspx?RpmID='+poolID+'', "", "width=1024,height=600");
            // window.open('AddResourceSelection.aspx?RpmID=' + poolID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=1024,height=600');
            //GetResourcesForSelection(poolID);
        }

        function AddRsrsManger() {
          
            $('#btnShowselectedManager').html("Show Selected Resource");
            var poolID = RPMatser.ResourcePoolID;
            FillFilterOUForFilterResourceMang();
            GetMyMGRFilter(0);
            if (currentDefaultFilterID > 0) {
                ApplySavedMGRFilter(currentDefaultFilterID, 2);
                MGRFilterApplied();

            } else {
                GetMGRDetails(null);
                MGRFilterNotApplied();
                $('#filterpanel').attr("aria-expanded", false);
                $('#filterpanel').removeClass("in");
                ClearMGRFilterDetails();
            }


        }

        //Get ResourcePool
        function GetResourcePool() {
            SelectedEmpID = [];
            var strHTML = "";
            var RPMGetObj = { CreatedBy: UserName, EmployeeID: SessionEmployeeId };

            StartLoader("#body-RPM");
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetResourcePool',
                type: "POST",
                data: JSON.stringify(RPMGetObj),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (RPMGetObj) {
                        xhr.setRequestHeader("Params", encryptString(isJson(RPMGetObj) ? RPMGetObj : JSON.stringify(RPMGetObj)));
                    }
                },
                success: function (data) {
                    var ResourcePools = data;
                    $.each(ResourcePools, function (index, obj) {
                        if (blnEditAccess == "True") {
                            //Commented & Added By Rutuja D. on 16 July 2021 For IssueID = 26728
                            //strHTML += '<tr><td class="text-center"><input type="hidden" name="hdn_ResourcePoolID" id="hdn_ResourcePoolID" value= ' + obj.ResourcePoolID + '><a href="javascript:;" class="RPMdetalilink" onclick="editRPM();"</a> ' + obj.ResourcePoolCode + ' </td> <td class="text-start wrapword"> ' + obj.ResourcePoolName + ' </td><td class="text-start wrapword">' + obj.Description + '</td><td><input type="hidden" id="hdnOT" name="hdnOT" value= ' + obj.OtherAttribute + '><input type="hidden" id="hdnSkillIDs" name="hdnSkillIDs" value= ' + obj.SkillIds + '><div class="custom_chckbox"><input id="chkMain_' + index + '" onclick="checkUncheck();GetSelectedResourcePoolID(this);" class="chcktbl" type="checkbox"><label for="chkMain_' + index + '"></label></div></td></tr>';
                            strHTML += '<tr><td class="text-center"><input type="hidden" name="hdn_ResourcePoolID" id="hdn_ResourcePoolID" value= ' + obj.ResourcePoolID + '><a href="javascript:;" class="RPMdetalilink" onclick="editRPM();"</a> ' + obj.ResourcePoolCode + ' </td> <td class="text-start wrapword"> ' + obj.ResourcePoolName + ' </td><td class="text-start wrapword">' + obj.Description + '</td><td><input type="hidden" id="hdnOT" name="hdnOT" value= ' + escape(obj.OtherAttribute) + '><input type="hidden" id="hdnSkillIDs" name="hdnSkillIDs" value= ' + obj.SkillIds + '><div class="custom_chckbox"><input id="chkMain_' + index + '" onclick="checkUncheck();GetSelectedResourcePoolID(this);" class="chcktbl" type="checkbox"><label for="chkMain_' + index + '"></label></div></td></tr>';
                            //End of Commented & Added By Rutuja D. on 16 July 2021 For IssueID = 26728
                        }
                        else {
                            //Commented & Added By Rutuja D. on 16 July 2021 For IssueID = 26728
                            //strHTML += '<tr><td class="text-center"><input type="hidden" name="hdn_ResourcePoolID" id="hdn_ResourcePoolID" value= ' + obj.ResourcePoolID + '>' + obj.ResourcePoolCode + ' </td> <td class="text-start wrapword"> ' + obj.ResourcePoolName + ' </td><td class="text-start wrapword">' + obj.Description + '</td><td><input type="hidden" id="hdnOT" name="hdnOT" value= ' + obj.OtherAttribute + '><input type="hidden" id="hdnSkillIDs" name="hdnSkillIDs" value= ' + obj.SkillIds + '><div class="custom_chckbox"><input id="chkMain_' + index + '" onclick="checkUncheck();GetSelectedResourcePoolID(this);" class="chcktbl" type="checkbox"><label for="chkMain_' + index + '"></label></div></td></tr>';
                            strHTML += '<tr><td class="text-center"><input type="hidden" name="hdn_ResourcePoolID" id="hdn_ResourcePoolID" value= ' + obj.ResourcePoolID + '>' + obj.ResourcePoolCode + ' </td> <td class="text-start wrapword"> ' + obj.ResourcePoolName + ' </td><td class="text-start wrapword">' + obj.Description + '</td><td><input type="hidden" id="hdnOT" name="hdnOT" value= ' + escape(obj.OtherAttribute) + '><input type="hidden" id="hdnSkillIDs" name="hdnSkillIDs" value= ' + obj.SkillIds + '><div class="custom_chckbox"><input id="chkMain_' + index + '" onclick="checkUncheck();GetSelectedResourcePoolID(this);" class="chcktbl" type="checkbox"><label for="chkMain_' + index + '"></label></div></td></tr>';
                            //End of Commented & Added By Rutuja D. on 16 July 2021 For IssueID = 26728
                        }
                    });
                    $('#tblResourcePoolMaster').dataTable().fnDestroy();
                    $("#tblResourcePool").html(strHTML);
                    LoadPagination(data);
                    StopAjaxLoader("#body-RPM");
                    $(".chckHead").prop("checked", false);
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-RPM");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-RPM");
                },
                // End of Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                

            })

        }
        var SelectedEmpID = [];
        function GetSelectedResourcePoolID(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedEmpID.push(parseInt(row.find('#hdn_ResourcePoolID').val()));
            }
            else {
                if (SelectedEmpID != 'undefined' && SelectedEmpID.length > 0) {
                    var removeEmp = row.find('#hdn_ResourcePoolID').val();
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


        function DeleteDetailsAfterConfirm() {
            var strHTML = "";
            var isSelectedResource = SelectedEmpID.toString();
            if (isSelectedResource.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_ResourcePoolMaster/DeleteResourcePoolMaster',
                    type: "POST",
                    data: JSON.stringify(isSelectedResource),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#body-RPM");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (isSelectedResource) {
                            xhr.setRequestHeader("Params", encryptString(isJson(isSelectedResource) ? isSelectedResource : JSON.stringify(isSelectedResource)));
                        }
                    },
                    success: function (data) {
                        StopAjaxLoader("#body-RPM");
                        GetResourcePool();
                        //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        //strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                        //End of Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterow').html(strHTML);
                        $('#DeleteConfirmMModal').modal('show');
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
                        else if (xhr.statusText == "OK") {  //200
                            GetResourcePool();
                            $('#DeleteConfirmMModal').modal('hide');
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success('Record(s) deleted succesfully.');
                        }

                        StopAjaxLoader("#body-RPM");
                        $('#DeleteConfirmMModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedEmpID = [];
            isSelectedResource = "";
        }

        //FOR DELETING RESOURCES
        var SelectedResourceDetailID = [];
        function GetSelectedResourcePoolDetailID(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedResourceDetailID.push(parseInt(row.find('#hdn_ResourcePoolDetailID').val()));
            }
            else {
                if (SelectedResourceDetailID != 'undefined' && SelectedResourceDetailID.length > 0) {
                    var removeEmp = row.find('#hdn_ResourcePoolDetailID').val();
                    SelectedResourceDetailID.remove(parseInt(removeEmp));
                }
            }

        }

        function DeleteResourcesDetails() {
            var isSelectedResource = SelectedResourceDetailID;
            if (isSelectedResource.length > 0) {
                $('#DeleteConfirmResourceModal').modal('show');
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }

        function DeleteConfirmResourceDetails() {
            var isSelectedResourceDetails = SelectedResourceDetailID.toString();
            if (isSelectedResourceDetails.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_ResourcePoolMaster/DeleteResourcePoolDetail',
                    type: "POST",
                    data: JSON.stringify(isSelectedResourceDetails),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#body-RPM");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (isSelectedResourceDetails) {
                            xhr.setRequestHeader("Params", encryptString(isJson(isSelectedResourceDetails) ? isSelectedResourceDetails : JSON.stringify(isSelectedResourceDetails)));
                        }
                    },
                    success: function (data) {
                        if (data != "") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                        }

                        StopAjaxLoader("#body-RPM");
                        ShowRPMResources();
                        $('#DeleteConfirmResourceModal').modal('hide');
                        // SelectedEmpID = [];

                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success('Record(s) deleted succesfully');
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
                            ShowRPMResources();
                            $('#DeleteConfirmResourceModal').modal('hide');
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                        }

                        StopAjaxLoader("#body-RPM");
                        $('#DeleteConfirmResourceModal').modal('hide');
                    }
                })
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedResourceDetailID = [];
            isSelectedResourceDetails = "";
            SelectedEmpIDRes = [];
        }

        //FOR DELETING MANAGERS
        var SelectedManagerDetailID = [];
        function GetSelectedResourcePoolManagerID(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedManagerDetailID.push(parseInt(row.find('#hdn_ResourcePoolManagerID').val()));
            }
            else {
                if (SelectedManagerDetailID != 'undefined' && SelectedManagerDetailID.length > 0) {
                    var removeEmp = row.find('#hdn_ResourcePoolManagerID').val();
                    SelectedManagerDetailID.remove(parseInt(removeEmp));
                }
            }
        }

        function DeleteManagersDetails() {
            var isSelectedManagerDetails = SelectedManagerDetailID;
            if (isSelectedManagerDetails.length > 0) {
                $('#DeleteConfirmManagersModal').modal('show');
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }


        function DeleteConfirmManagersDetails() {
            var isSelectedManger = SelectedManagerDetailID.toString();
            if (isSelectedManger.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_ResourcePoolMaster/DeleteManagersDetail',
                    type: "POST",
                    data: JSON.stringify(isSelectedManger),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#body-RPM");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (isSelectedManger) {
                            xhr.setRequestHeader("Params", encryptString(isJson(isSelectedManger) ? isSelectedManger : JSON.stringify(isSelectedManger)));
                        }
                    },
                    success: function (data) {
                        if (data != "") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data);
                        }

                        StopAjaxLoader("#body-RPM");
                        ShowRPMManager();
                        $('#DeleteConfirmManagersModal').modal('hide');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success('Record(s) deleted succesfully.');
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
                            ShowRPMManager();
                            $('#DeleteConfirmManagersModal').modal('hide');
                        }

                        StopAjaxLoader("#body-RPM");
                        $('#DeleteConfirmManagersModal').modal('hide');
                    }
                })
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedManagerDetailID = [];
            isSelectedManger = "";
            SelectedEmpIDForManager = [];
        }

        function ShowRPMResources() {
         
            FillOU(0);
            $("#cboRPMFilterBusinessGroupID").val(0);
            var bgId = $("#cboRPMFilterBusinessGroupID").val();
            CboRPMResource_OnChange(bgId);

            StopAjaxLoader("#body-RPM");
        }
        function GenerateBasicFilterQueryRes(module, filterField) {
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
                        //if (strvalue != "" && strvalue != undefined) {
                        if (strqtext != "") strqtext += " AND ";
                        if (strOp != "0") {
                            if (filterField[i] == "IsResourceActive" && strOp == 'Yes') {
                                strvalue = 1;
                            }
                            if (filterField[i] == "IsResourceActive" && strOp == 'No') {
                                strvalue = 0;
                            }
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
                //console.log("strqtext", strqtext);
                return strqtext;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        function ApplyResFilter() {
            currentFilterID = 0;
            var filterWhereClause;
            var AllResFilter = ["BusinessGroupID", "LocationID", "IsResourceActive"];
            var filterWhereClause2 = GenerateBasicFilterQueryRes("RPM", AllResFilter);
            filterWhereClause = filterWhereClause2.replace(/"/g, "\''");
            if (filterWhereClause != null) {
                GetRPMResouces(RPMatser.ResourcePoolID, filterWhereClause);
            }
            else {
                GetRPMResouces(RPMatser.ResourcePoolID);
            }

        }

        function CboRPMResource_OnChange(bgId) {
            if (bgId == undefined || bgId == null || bgId == "") {
                //Added By Rutuja D. for Onchange of BG OU set Properly on 14 July 2021
                $("#cboRPMFilterLocationID").val('');
                //End of Added By Rutuja D. for Onchange of BG OU set Properly on 14 July 2021
                FillOU(0);
                //ApplyResFilter();
            }
            ApplyResFilter();
        }

        function GetRPMResouces(ResourcePoolID, filterWhereClause) {
            SelectedResourceDetailID = [];
            SelectedEmpIDRes = [];
            var strHTML = "";
            var RPM_ResourceParameters = { ResourcePoolID: ResourcePoolID, WhereClause: filterWhereClause };
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            StartLoader("#body-RPM");
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetRPMResources',
                type: "POST",
                data: JSON.stringify(RPM_ResourceParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (RPM_ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(RPM_ResourceParameters) ? RPM_ResourceParameters : JSON.stringify(RPM_ResourceParameters)));
                    }
                },
                success: function (data) {
                    var MyData = data;
                    if (MyData != null && MyData.length > 0) {
                        // $('#ResCount').text(MyData.length);
                        $.each(MyData, function (index, obj) {
                            strHTML += '<tr><td><input type="hidden" name="hdn_ResourcePoolDetailID" id="hdn_ResourcePoolDetailID" value= ' + obj.ResourcePoolDetailID + '>' + obj.EmployeeName + '</td><td>' + obj.RoleDescription + '</td><td>' + obj.ReportingTo + '</td><td>' + obj.EmailID + '</td><td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResumeModal" onclick="GetResourceResume(' + obj.EmployeeID + ')"> Resume </a></td><td><div class="custom_chckbox"><input id="chkResorces_' + index + '" onclick="checkUncheckResource();GetSelectedResourcePoolDetailID(this);" class="chcktbl1" type="checkbox"><label for="chkResorces_' + index + '"></label></div></td></tr>';
                        });
                    }
                    //else {
                    //    strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    //}
                    $('#ResourcesTbl').dataTable().fnDestroy();
                    $("#tblRPMResources").html(strHTML);
                    LoadPaginationForResources(data);
                    StopAjaxLoader("#body-RPM");
                    $(".chckHead1").prop("checked", false);
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
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(thrownError);
                    }
                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    StopAjaxLoader("#body-RPM");
                }
            })
        }

        function ShowRPMManager() {
            var ResID = RPMatser.ResourcePoolID;
            GetAllManagers(ResID);
            StopAjaxLoader("#body-RPM");
        }

        function GetAllManagers(ResourcePoolID) {
            SelectedEmpIDForManager = [];
            SelectedManagerDetailID = [];
            var strHTML = "";
            var RPMMangerParameter = { ResourcePoolID: ResourcePoolID };
            StartLoader("#body-RPM");
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetRPMManagers',
                type: "POST",
                data: JSON.stringify(RPMMangerParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (RPMMangerParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(RPMMangerParameter) ? RPMMangerParameter : JSON.stringify(RPMMangerParameter)));
                    }
                },
                success: function (data) {
                    var MyRPMManager = data;
                    if (MyRPMManager != null && MyRPMManager.length > 0) {
                        // $('#MgrCount').text(MyRPMManager.length);
                        $.each(MyRPMManager, function (index, obj) {
                            strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_ResourcePoolManagerID" id="hdn_ResourcePoolManagerID" value= ' + obj.ResourcePoolManagerID + '><input type="hidden" name="hdnDUM_UniqueID" id="hdnDUM_UniqueID" value= ' + obj.UniqueID + '>' + obj.ManagerName + '</td><td class="text-center">' + obj.EmailID + '</td><td><div class="custom_chckbox"><input id="chkManagers_' + index + '" onclick="checkUncheckManagers();GetSelectedResourcePoolManagerID(this);" class="chcktbl2" type="checkbox"><label for="chkManagers_' + index + '"></label></div></td></tr>';
                        });
                    }
                    //  else {
                    //    strHTML += '<tr><td class="text-center" colspan="3">' + NoDataFound + '</td></tr>';
                    //}
                    $('#ManagersTbl').dataTable().fnDestroy();
                    $("#tblRPMmanagers").html(strHTML);
                    LoadPaginationForManagers(data);
                    StopAjaxLoader("#body-RPM");
                    $(".chckHead2").prop("checked", false);
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
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(thrownError);
                    }
                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    StopAjaxLoader("#body-RPM");
                }
            })
        }

        //manager popup function
        function ReloadTableWithSearchValuesForManagers(resourceList, EmpIds, isFromSelected) {
            var strHTML = "";
            $("#tblResourceManagerSelection").html('');

            if (resourceList != null && resourceList.length > 0) {

                $.each(resourceList, function (index, obj) {
                    //var AlllocatedEmp;
                    var AlllocatedEmp = '<div class="custom_chckbox"><input id="chkMgrSelection_' + index + '" type="checkbox" class="chcktbl3" onclick="PushSBCheckedEmpIDSForManagers(this)"><label for="chkMgrSelection_' + index + '"></label></div>';
                    //var AlllocatedEmpChecked = '<input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)" checkd>';
                    if (EmpIds != null && EmpIds.length > 0) {
                        $.each(EmpIds, function (index, objEmp) {
                            if (obj.EmployeeID == objEmp) {
                                SelectedEmpIDForManager.push(objEmp);
                                //$('#btnORShowselectedResource').html("Show All Resources"); //Show Selected Resource
                                AlllocatedEmp = '<div class="custom_chckbox"><input id="chkMgrSelection_' + index + '" type="checkbox" class="chcktbl3" onclick="PushSBCheckedEmpIDSForManagers(this)" checked><label for="chkMgrSelection_' + index + '"></label></div>';
                            }
                            else {
                                // alert();
                                // AlllocatedEmp = '<input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)">';
                            }


                        })
                    }

                    if (isFromSelected == 1) {
                        strHTML += '<tr><td class="text-center"><input type="hidden" name="hdn_EmployeeIDForManager" id="hdn_EmployeeIDForManager" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + '</td><td class="text-center">' + obj.BusinessGroup + '</td><td class="text-center">' + obj.Location + '</td><td class="text-center">' + obj.RoleDescription + '</td><td class="text-center">' + obj.DesignationName + '</td><td><div class="custom_chckbox"><input id="chkMgrSelection_' + index + '" type="checkbox" class="chcktbl3" onclick="PushSBCheckedEmpIDSForManagers(this)" checked><label for="chkMgrSelection_' + index + '"></label></td></tr>';

                    } else {

                        strHTML += '<tr><td class="text-center"><input type="hidden" name="hdn_EmployeeIDForManager" id="hdn_EmployeeIDForManager" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + '</td><td class="text-center">' + obj.BusinessGroup + '</td><td class="text-center">' + obj.Location + '</td><td class="text-center">' + obj.RoleDescription + '</td><td class="text-center">' + obj.DesignationName + '</td><td class="text-center">' + AlllocatedEmp + '</td></tr>';
                    }

                    //}

                });
                $('#AddRPMTbl').dataTable().fnDestroy();
                $("#tblResourceManagerSelection").html(strHTML);
                LoadAddResourcePagination(resourceList);
                $(".chckHead3").prop("checked", false);
            } else {
                //strHTML += '<tr><td class="text-center"colspan="6">' + NoDataFound + ' </td></tr>';
                strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + ' </td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td></tr>';
                $('#AddRPMTbl').dataTable().fnDestroy();
                $("#tblResourceManagerSelection").html(strHTML);
                LoadAddResourcePagination(resourceList);
                $(".chckHead3").prop("checked", false);
            }

        }


        var SelectedEmpIDForManager = [];
        function PushSBCheckedEmpIDSForManagers(objEmployeeList) {
            var row = $(objEmployeeList).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedEmpIDForManager.push(parseInt(row.find('#hdn_EmployeeIDForManager').val()));
            } else {
                if (SelectedEmpIDForManager != 'undefined' && SelectedEmpIDForManager.length > 0) {
                    var removeEmp = row.find('#hdn_EmployeeIDForManager').val();
                    SelectedEmpIDForManager.remove(parseInt(removeEmp));
                }
            }
            //}
            if (managerSelectionTable.$('input:checked').length == managerSelectionTable.fnGetNodes().length) {
                $(".chckHead3").prop("checked", true);
            } else {
                //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                //$(".chckHead3").removeAttr("checked");
                $(".chckHead3").prop("checked", false);
                //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
            }
        }

        function ShowSelectedManager() {
            var CurrentBtnText = $('#btnShowselectedManager').html();
            if (SelectedEmpIDForManager.length > 0 && CurrentBtnText == "Show Selected Resource") {
                var SelectedResourceList = showSelectedListFormanagers.filter(function (x) { return SelectedEmpIDForManager.includes(x.EmployeeID) });
                ReloadTableWithSearchValuesForManagers(SelectedResourceList, null, 1);
                $('#btnShowselectedManager').html("Show All Resources");
            }
            else if (CurrentBtnText == "Show All Resources") {
                $('#btnShowselectedManager').html("Show Selected Resource");
                ReloadTableWithCheckedManager(showSelectedListFormanagers, SelectedEmpIDForManager)
            }
            else if (SelectedEmpIDForManager.length == 0 || SelectedEmpIDForManager == '') {

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one record');
            }

            if (managerSelectionTable.$('input:checked').length == managerSelectionTable.fnGetNodes().length) {
                $(".chckHead3").prop("checked", true);
            } else {
                //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
               // $(".chckHead3").removeAttr("checked");
                $(".chckHead3").prop("checked", false);
                //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
            }
        }

        function ReloadTableWithCheckedManager(showSelectedList, SelectedEmpIDForManager) {
            var strHTML = "";
            if (showSelectedList != null && showSelectedList.length > 0) {

                $.each(showSelectedList, function (index, obj) {
                    //var AlllocatedEmp;
                    var AlllocatedEmp = '<div class="custom_chckbox"><input id="chkMgrSelection_' + index + '" type="checkbox" class="chcktbl3" onclick="PushSBCheckedEmpIDSForManagers(this)"><label for="chkMgrSelection_' + index + '"></label>';
                    //var AlllocatedEmpChecked = '<input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)" checkd>';
                    if (SelectedEmpIDForManager != null && SelectedEmpIDForManager.length > 0) {
                        $.each(SelectedEmpIDForManager, function (index, objEmp) {
                            if (obj.EmployeeID == objEmp) {
                                AlllocatedEmp = '<div class="custom_chckbox"><input id="chkMgrSelection_' + index + '" type="checkbox" class="chcktbl3" onclick="PushSBCheckedEmpIDSForManagers(this)" checked><label for="chkMgrSelection_' + index + '"></label></div>';
                            }
                            else {
                                // alert();
                                // AlllocatedEmp = '<input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)">';
                            }
                        })
                    }
                    strHTML += '<tr><td class="text-center"><input type="hidden" name="hdn_EmployeeIDForManager" id="hdn_EmployeeIDForManager" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + '</td><td class="text-center">' + obj.BusinessGroup + '</td><td class="text-center">' + obj.Location + '</td><td class="text-center">' + obj.RoleDescription + '</td><td class="text-center">' + obj.DesignationName + '</td><td class="text-center">' + AlllocatedEmp + '</td></tr>';
                });
                $('#AddRPMTbl').dataTable().fnDestroy();
                $("#tblResourceManagerSelection").html(strHTML);
                LoadAddResourcePagination(showSelectedList);
                $(".chckHead3").prop("checked", false);
            }

        }

        var IsShowSelectedForManagers;
        function GetSelectionManagers(RPoolID, MGRFilterClause) {
            var SelectedParametersForManagers = { ResourcePoolID: "", WhereClause: "" };
            var strHTML = "";
            //SelectedEmpIDForManager = [];
            showSelectedListFormanagers = [];
            SelectedParametersForManagers.ResourcePoolID = RPoolID;
            SelectedParametersForManagers.WhereClause = MGRFilterClause;
            StartLoader("#body-RPM");
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetSelectionResourceDemand',
                type: "POST",
                data: JSON.stringify(SelectedParametersForManagers),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (SelectedParametersForManagers) {
                        xhr.setRequestHeader("Params", encryptString(isJson(SelectedParametersForManagers) ? SelectedParametersForManagers : JSON.stringify(SelectedParametersForManagers)));
                    }
                },
                success: function (data) {
                    showSelectedListFormanagers = data.resourcesList;
                    if (showSelectedListFormanagers.length > 0) {
                        ReloadTableWithSearchValuesForManagers(showSelectedListFormanagers, data.EmpIds);
                        if (managerSelectionTable.$('input:checked').length == managerSelectionTable.fnGetNodes().length) {
                            $(".chckHead3").prop("checked", true);
                        } else {
                            //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                            //$(".chckHead3").removeAttr("checked");
                            $(".chckHead3").prop("checked", false);
                            //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                        }
                    }
                    else {
                        ReloadTableWithSearchValuesForManagers(showSelectedListFormanagers);
                    }
                    StopAjaxLoader("#body-RPM");
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-top');
                //    alertify.error(err);
                //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#body-RPM");
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



        function saveSelectedManagers() {
            var saveParametersForMGR = { ResourcePoolID: "", EmployeeID: "", From: "" };
            StartLoader("#body-RPM");
            var isSelected = SelectedEmpIDForManager.toString();
            if (isSelected.length > 0) {
                saveParametersForMGR.ResourcePoolID = RPMatser.ResourcePoolID;
                saveParametersForMGR.EmployeeID = isSelected;
                saveParametersForMGR.From = "MGR";
                $.ajax({
                    url: strUrl + '/api/RM_ResourcePoolMaster/SaveSelectedResource',
                    type: "POST",
                    data: JSON.stringify(saveParametersForMGR),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (saveParametersForMGR) {
                            xhr.setRequestHeader("Params", encryptString(isJson(saveParametersForMGR) ? saveParametersForMGR : JSON.stringify(saveParametersForMGR)));
                        }
                    },
                    success: function (data) {
                        ShowRPMManager();
                        onClose();
                        //if (isFromSaveClick == 0) {
                        $("#AddRESMModal").modal('hide');
                        //}
                        StopAjaxLoader("#body-RPM");
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
                            StopAjaxLoader("#body-RPM");
                        }
                    }
                });

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(showMessage);
                return false;
            }
            SelectedEmpIDForManager = [];
            isSelected = "";
        }

        //rESOURCE POPUP FUNCTIONS//
        var SelectedParameters = { ResourcePoolID: "", WhereClause: "" };
        var IsShowSelected;
        function GetResourcesForSelection(RPoolID, WhereClauseFinal) {
            var strHTML = "";
            $("#tblResourceSelection").html('');
            // SelectedEmpIDRes = [];
            showSelectedList = [];
            SelectedParameters.ResourcePoolID = RPoolID;
            SelectedParameters.WhereClause = WhereClauseFinal;
            StartLoader("#body-RPM");
            $.ajax({
                url: strUrl + '/api/RM_ResourcePoolMaster/GetResourcesForSelection',
                type: "POST",
                data: JSON.stringify(SelectedParameters),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (SelectedParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(SelectedParameters) ? SelectedParameters : JSON.stringify(SelectedParameters)));
                    }
                },
                success: function (data) {
                    showSelectedList = data.resourcesList;
                    if (showSelectedList.length > 0) {
                        ReloadTableWithSearchValues(showSelectedList, data.EmpIds);
                        if (resourceSelectionTable.$('input:checked').length == resourceSelectionTable.fnGetNodes().length) {
                            $(".chckHead4").prop("checked", true);
                        } else {
                            //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                            //$(".chckHead4").removeAttr("checked");
                            $(".chckHead4").prop("checked", false);
                            //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                        }
                    }
                    else {
                        ReloadTableWithSearchValues(showSelectedList);
                    }
                    StopAjaxLoader("#body-RPM");
                },
                // Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    // StopAjaxLoader("#body-Resource");
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
        function ReloadTableWithSearchValues(resourceList, EmpIds, isFromSelected) {
            var strHTML = "";
            $("#tblResourceSelection").html('');
            if (resourceList != null && resourceList.length > 0) {

                $.each(resourceList, function (index, obj) {


                    //var AlllocatedEmp;
                    var AlllocatedEmp = '<div class="custom_chckbox"><input  id="chkResSel_' + index + '" type="checkbox" class="chcktbl4" onclick="PushSBCheckedEmpIDS(this)"><label for="chkResSel_' + index + '"></label></div>';
                    //var AlllocatedEmpChecked = '<input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)" checkd>';
                    if (EmpIds != null && EmpIds.length > 0) {
                        $.each(EmpIds, function (index, objEmp) {
                            if (obj.EmployeeID == objEmp) {
                                SelectedEmpIDRes.push(objEmp);
                                //$('#btnORShowselectedResource').html("Show All Resources"); //Show Selected Resource
                                AlllocatedEmp = '<div class="custom_chckbox"><input id="chkResSel_' + index + '" type="checkbox" class="chcktbl4" onclick="PushSBCheckedEmpIDS(this)" checked><label for="chkResSel_' + index + '"></label></div>';
                            }
                            else {
                                // alert();
                                // AlllocatedEmp = '<input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)">';
                            }


                        })
                    }

                    if (isFromSelected == 1) {
                        strHTML += '<tr><td class="text-center"><input type="hidden" name="hdn_EmployeeID" id="hdn_EmployeeID" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + ' </td> <td class="text-center"> ' + obj.UserName + ' </td><td class="text-center">' + obj.EmployeeCode + '</td><td class="text-center">' + obj.RoleDescription + '</td><td class="text-center">' + obj.TotalExpText + '</td><td class="text-center">' + obj.CurrentExpText + '</td><td class="text-center">' + obj.PrimarySkills + '</td><td><div class="custom_chckbox"><input id="chkResSel_' + index + '" type="checkbox" class="chcktbl4" onclick="PushSBCheckedEmpIDS(this)" checked><label for="chkResSel_' + index + '"></label></div></td></tr>';

                    } else {

                        strHTML += '<tr><td class="text-center"><input type="hidden" name="hdn_EmployeeID" id="hdn_EmployeeID" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + ' </td> <td class="text-center"> ' + obj.UserName + ' </td><td class="text-center">' + obj.EmployeeCode + '</td><td class="text-center">' + obj.RoleDescription + '</td><td class="text-center">' + obj.TotalExpText + '</td><td class="text-center">' + obj.CurrentExpText + '</td><td class="text-center">' + obj.PrimarySkills + '</td><td class="text-center">' + AlllocatedEmp + '</td></tr>';
                    }
                });
                $('#tblResourceSelectionMain').dataTable().fnDestroy();
                $("#tblResourceSelection").html(strHTML)

                LoadResourcePagination(resourceList);
                $(".chckHead4").prop("checked", false);
            }
            else {
                strHTML += '<tr><td class="text-center"colspan="8">' + NoDataFound + ' </td></tr>';
                $('#tblResourceSelectionMain').dataTable().fnDestroy();
                $("#tblResourceSelection").html(strHTML);
                $(".chckHead4").prop("checked", false);
            }

        }


        var SelectedEmpIDRes = [];
        function PushSBCheckedEmpIDS(objEmployeeList) {
            var row = $(objEmployeeList).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedEmpIDRes.push(parseInt(row.find('#hdn_EmployeeID').val()));
            } else {
                if (SelectedEmpIDRes != 'undefined' && SelectedEmpIDRes.length > 0) {
                    var removeEmp = row.find('#hdn_EmployeeID').val();
                    SelectedEmpIDRes.remove(parseInt(removeEmp));
                }
            }
            if (resourceSelectionTable.$('input:checked').length == resourceSelectionTable.fnGetNodes().length) {
                $(".chckHead4").prop("checked", true);
            } else {
                //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                //$(".chckHead4").removeAttr("checked");
                $(".chckHead4").prop("checked", false);
                //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
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
        Array.prototype.includes = function (match) {
            return this.indexOf(match) !== -1;
        }
        function ShowSelectedResource() {
            var CurrentBtnText = $('#btnShowselectedResource').html();
            if (SelectedEmpIDRes.length > 0 && CurrentBtnText == "Show Selected Resource") {
                var SelectedResourceList = showSelectedList.filter(function (x) { return SelectedEmpIDRes.includes(x.EmployeeID) });
                ReloadTableWithSearchValues(SelectedResourceList, null, 1);
                $('#btnShowselectedResource').html("Show All Resources");
            }
            else if (CurrentBtnText == "Show All Resources") {
                $('#btnShowselectedResource').html("Show Selected Resource");
                ReloadTableWithCheckedResorces(showSelectedList, SelectedEmpIDRes)
            }
            else if (SelectedEmpIDRes.length == 0 || SelectedEmpIDRes == '') {

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one record');
            }
            if (resourceSelectionTable.$('input:checked').length == resourceSelectionTable.fnGetNodes().length) {
                $(".chckHead4").prop("checked", true);
            } else {
                //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                //$(".chckHead4").removeAttr("checked");
                $(".chckHead4").prop("checked", false);
                //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
            }
        }

        function ReloadTableWithCheckedResorces(showSelectedList, SelectedEmpIDRes) {
            var strHTML = "";

            if (showSelectedList != null && showSelectedList.length > 0) {

                $.each(showSelectedList, function (index, obj) {
                    //var AlllocatedEmp;
                    var AlllocatedEmp = '<div class="custom_chckbox"><input id="chkResChecked_' + index + '" type="checkbox" class="chcktbl4" onclick="PushSBCheckedEmpIDS(this)"><label for="chkResChecked_' + index + '"></label></div>';
                    //var AlllocatedEmpChecked = '<input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)" checkd>';
                    if (SelectedEmpIDRes != null && SelectedEmpIDRes.length > 0) {
                        $.each(SelectedEmpIDRes, function (index, objEmp) {
                            if (obj.EmployeeID == objEmp) {
                                //  SelectedEmpID.push(objEmp);
                                //$('#btnORShowselectedResource').html("Show All Resources"); //Show Selected Resource
                                AlllocatedEmp = '<div class="custom_chckbox"><input id="chkResChecked_' + index + '" type="checkbox" class="chcktbl4" onclick="PushSBCheckedEmpIDS(this)" checked><label for="chkResChecked_' + index + '"></label></div>';
                            }
                            else {
                                // alert();
                                // AlllocatedEmp = '<input type="checkbox"  style="width:18px; height:18px" class="chckHeadSoftbooking" onclick="PushSBCheckedEmpIDS(this)">';
                            }


                        })
                    }

                    //Commented and added by Chetan M on 16 July 2021 for worng experiance displaying
                    //strHTML += '<tr><td class="text-center"><input type="hidden" name="hdn_EmployeeID" id="hdn_EmployeeID" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + ' </td> <td class="text-center"> ' + obj.UserName + ' </td><td class="text-center">' + obj.EmployeeCode + '</td><td class="text-center">' + obj.RoleDescription + '</td><td class="text-center">' + obj.TotalExp + '</td><td class="text-center">' + obj.CurrentExp + '</td><td class="text-center">' + obj.PrimarySkills + '</td><td class="text-center">' + AlllocatedEmp + '</td></tr>';
                    strHTML += '<tr><td class="text-center"><input type="hidden" name="hdn_EmployeeID" id="hdn_EmployeeID" value= ' + obj.EmployeeID + '>' + obj.EmployeeName + ' </td> <td class="text-center"> ' + obj.UserName + ' </td><td class="text-center">' + obj.EmployeeCode + '</td><td class="text-center">' + obj.RoleDescription + '</td><td class="text-center">' + obj.TotalExpText + '</td><td class="text-center">' + obj.CurrentExpText + '</td><td class="text-center">' + obj.PrimarySkills + '</td><td class="text-center">' + AlllocatedEmp + '</td></tr>';
                    //End of commented and added by Chetan M on 16 July 2021 for worng experiance displaying
                });
                $('#tblResourceSelectionMain').dataTable().fnDestroy();
                $("#tblResourceSelection").html(strHTML)
                LoadResourcePagination(showSelectedList);
                $(".chckHead4").prop("checked", false);
            }

        }

        function saveSelectedResource() {
            var saveParameters = { ResourcePoolID: "", EmployeeID: "", From: "" };
            StartLoader("#body-RPM");

            var isSelected = SelectedEmpIDRes.toString();
            if (isSelected.length > 0) {
                saveParameters.ResourcePoolID = RPMatser.ResourcePoolID;
                saveParameters.EmployeeID = isSelected;
                saveParameters.From = "RES";
                $.ajax({
                    url: strUrl + '/api/RM_ResourcePoolMaster/SaveSelectedResource',
                    type: "POST",
                    data: JSON.stringify(saveParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (saveParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(saveParameters) ? saveParameters : JSON.stringify(saveParameters)));
                        }
                    },
                    success: function (data) {
                        ShowRPMResources();
                        onClose();
                        //if (isFromSaveClick == 0) {
                        $("#AddRESModal").modal('hide');
                        //Added By Rutuja D. on 26 July 2021
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("Resource Added Successfully.");
                        //End of Added By Rutuja D. on 26 July 2021
                        StopAjaxLoader("#body-RPM");
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
                            StopAjaxLoader("#body-RPM");
                        }
                    }
                });

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(showMessage);
                return false;
            }
            SelectedEmpIDRes = [];
            isSelected = "";
        }
        function LoadResourcePagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            resourceSelectionTable = $('#tblResourceSelectionMain').dataTable({
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
                //  "dom": '<"float-end top"p >rt<"clear">',
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [7] }]// Added By Pradip on 20 July 2021

            });
            $('table').resize(); //Added by pradip on 14-7-2021

        }

        //Start filter for managers
        function ApplyFilter() {
            var filter = "";
            currentFilterID = 0;
            var AllMGRFilter = ["RoleId", "DesignationID", "DepartmentID", "BusinessGroupID", "LocationID", "EmployeeName"];
            //var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
            var filterWhereClause2 = GenerateMGRBasicFilterQuery("MGR", AllMGRFilter);
            if (filterWhereClause2 == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
            } else {
                GetSelectionManagers(RPMatser.ResourcePoolID, filterWhereClause2)
                MGRFilterApplied();
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");
            }
        }
        function GetMGRDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                var whereClauseFormated = whereClause.replace(/'/g, '"');
                //filter = whereClause.toString().replace(/\'/g, '"');
            }
            GetSelectionManagers(RPMatser.ResourcePoolID, whereClauseFormated);
        }
        function GenerateMGRBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                var txtBoxvalue = 0;
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#Cbo' + module + 'Filter' + filterField[i]).val();
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
        //fILTER VALIDATION
        function checkFiltervalidationForManagers() {
            var roleId = $("#CboMGRFilterRoleId").val() == "" ? null : $("#CboMGRFilterRoleId").val();
            var DesignationID = $("#CboMGRFilterDesignationID").val() == "" ? null : $("#CboMGRFilterDesignationID").val();
            var DepartmentID = $("#CboMGRFilterDepartmentID").val() == "" ? null : $("#CboMGRFilterDepartmentID").val();
            var bgID = $("#CboMGRFilterBuisnessGroupID").val() == "" ? null : $("#CboMGRFilterBuisnessGroupID").val();
            var locationID = $("#CboMGRFilterLocationID").val() == "" ? null : $("#CboMGRFilterLocationID").val();
            var employeeName = $("#txtMGRFilterEmployeeName").val() == "" ? null : $("#txtMGRFilterEmployeeName").val();
            if ((roleId == null || roleId == 'undefined' || roleId == 0) && (DesignationID == null || DesignationID == 'undefined' || DesignationID == 0) && (DepartmentID == null || DepartmentID == 'undefined' || DepartmentID == 0) && (bgID == null || bgID == 'undefined' || bgID == 0) && (locationID == null || locationID == 'undefined' || locationID == 0) && (employeeName == null || employeeName == 'undefined')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
                $('#RPMmgrSavefilter').modal('hide');
            }
            else {

                //var myModal = new bootstrap.Modal(document.getElementById('#RPMmgrSavefilter'), {})
                //myModal.show();
                $('#RPMmgrSavefilter').modal('show');

            }
        }



        function SaveMGRFilterDetails() {
            var fltFilterName = $("#txtMGRFilterName").val();
            if (fltFilterName == "") {
                $("#btnMGRSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter filter name');

                $("#txtMGRFilterName").focus();
            }
            else {
                var filterExists = 0;
                var AllMGRFilter = ["RoleId", "DesignationID", "DepartmentID", "BusinessGroupID", "LocationID", "EmployeeName"];
                var filterWhereClause2 = GenerateMGRBasicFilterQuery("MGR", AllMGRFilter);
                var filterWhereClause;
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
                    TagID: encodeURI(ManagerTagID),
                    ProjectID: 0,
                    EmployeeID: encodeURI(SessionEmployeeId),
                    FilterName: encodeURI(fltFilterName),
                    LoginType: encodeURI(SessionLoginType),
                    CreatedBy: encodeURI(UserName),
                    WhereClause: encodeURI(filterWhereClause),
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
                            $('#RPMmgrSavefilter').modal('hide');
                            MGRFilterApplied();
                            GetMyMGRFilter(0);
                            ApplyFilter();
                            savedFilterName = fltFilterName;
                            $("#txtMGRFilterName").val('');
                            //clearTooltip();
                            // ClearMGRFilterDetails("");
                        }



                    },
                    //Commented & Integrate By Rutuja D. on 9 July 2021 for Session Expired Issue                
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

        function onCloseSaveMGR() {
            $('#RPMmgrSavefilter').modal('hide');
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtMGRFilterName').val("");
            }
        }
        function OnCloseMangerAdd() {
            currentDefaultFilterID = 0;
            ApplySavedMGRFilter(currentDefaultFilterID, 0);
            ClearMGRFilterDetails("");
            $(".MGRclearalllink").addClass("clsShowHide");

        }

        //Exists Filters
        function ExistMGRFilter(filtername) {

            var isFilterExists = 0;
            var Parameters = {
                FilterName: encodeURI(filtername),
                TagID: encodeURI(ManagerTagID),
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
        //function DeleteMGRFilter(FilterID, IsApplyed) {
        function DeleteMGRFilter(FilterID, FilterName, IsApplyed) {
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
                            GetSelectionManagers(RPMatser.ResourcePoolID);
                        }
                        ClearMGRFilterDetails("");
                        MGRFilterNotApplied();
                        GetMyMGRFilter(0);
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
        function SetDefaultMGRFilter(FilterID, flag) {
            var removeDefault = 0;
            if (flag == "default") {
                removeDefault = 1;
            }
            var Parameters = {
                ProjectID: 0,
                LoginType: encodeURI(SessionLoginType),
                EmployeeID: encodeURI(SessionEmployeeId),
                TagID: encodeURI(ManagerTagID),
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
                        //alertify.success('Success');

                        ApplySavedMGRFilter(FilterID, 2, true);//Changed By Mahesh on 22 July 2021
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIconForManagers').attr("aria-expanded", true);
                        MGRFilterApplied();
                    }
                    else {
                        ApplySavedMGRFilter(FilterID, 3, true);//Changed By Mahesh on 22 July 2021
                        //alertify.success('Default Filter Is Successfully Removed!');
                        alertify.success("Default Filter Removed Successfully");
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIconForManagers').attr("aria-expanded", false);
                        MGRFilterNotApplied();
                    }
                    //GetMyMGRFilter(0);
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

        function GetMyMGRFilter(flag) {
            var Parameters = {
                ProjectID: 0,
                TagID: encodeURI(ManagerTagID),
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

                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-bs-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='radio' name='project2' onclick='SetDefaultMGRFilter(this.id,&quot;default&quot;)' checked='checked'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-bs-placement='right' title='Remove Default filter' class='checkmark'></span>";
                                strHTML += "</label>";

                            }
                            else {
                                strHTML += "<label class='customradio'>";
                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-bs-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='radio' name='project2' onclick='SetDefaultMGRFilter(this.id,&quot;&quot;)'>";
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
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedMGRFilter(this.id,3)'></label>";
                                    }
                                    else {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedMGRFilter(this.id)'></label>";
                                    }
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedMGRFilter(this.id)'></label>";
                                }

                                strHTML += "</div>";
                            }
                            else {
                                strHTML += "<div class='custom_chckbox_markblue'>";
                                if (blnApply == true) {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedMGRFilter(this.id,3)'></label>";
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedMGRFilter(this.id)'></label>";
                                }
                            }

                            strHTML += "<span onclick='OpenBasicFilterforMGR()' class='edit_filter'>";

                            strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Edit filter' id='" + ObjMyFilter.FilterId + "' class='fas fa-pencil-alt' onclick='EditMGRFilter(this.id);'></i>";

                            strHTML += "</span>";

                            strHTML += "<span>";
                            if (blnApply == true) {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id,3);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='btnDeleteMGRFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3);'></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                            }
                            else {
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteMGRFilter(this.id);'></i>";
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteMGRFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;);></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                            }

                            strHTML += "</span>";

                            strHTML += "</div>";

                            strHTML += "</li>";

                        }

                        $("#MyFiltersdropdown").html(strHTML);
                        if (strHTML != "" && defaultFilterId != 0 && flag != 0 && flag != 3) {
                            ApplySavedMGRFilter(defaultFilterId, 1);
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

        //Edit Filter
        function EditMGRFilter(FilterID) {
            savedFilterName = "";
            ClearMGRFilterDetails("edit");
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
                        $("#txtMGRFilterName").val(currentFilterName);
                        savedFilterName = currentFilterName;
                        if (ObjFilterDtls.QueryText.toString().indexOf("AND") != -1) {

                            var arrFields = ObjFilterDtls.QueryText.split("AND");
                            try {
                                for (var i = 0; i < arrFields.length; i++) {
                                    setMGRfiltervalues(arrFields[i]);
                                }
                            }
                            catch (ex) {
                                //alert(ex.message);
                            }
                        }
                        else {
                            var currWhereClause = ObjFilterDtls.QueryText.toString();
                            setMGRfiltervalues(currWhereClause);
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
        function cancelsaveapplyMGR() {
            $('#txtMGRFilterName').val("");
        }
        function ClearMGRFilterDetails(flag) {
            $("#CboMGRFilterRoleId").val("");
            $("#CboMGRFilterDesignationID").val("");
            $("#CboMGRFilterDepartmentID").val("");
            $("#CboMGRFilterBusinessGroupID").val("0");
            $("#CboMGRFilterLocationID").val("");
            $("#txtMGRFilterEmployeeName").val("");
            savedFilterName = "";
            $('#txtMGRFilterName').val("");
            FillFilterOUForFilterResourceMang(0);
            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {
                    //Commented & Added By Dipali V On 10th April 2023 For Checkbox issue
                    // $(this).removeAttr("checked");
                    $(this).prop("checked", false);
                    //End of Commented & Added By Dipali V On 10th April 2023 For Checkbox issue

                });
            }

        }
        //Apply saved filter   
        function ApplySavedMGRFilter(FilterID, isDefault, isFromDefault) {
            //Changed  by mahesh on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {
                GetSelectionManagers(RPMatser.ResourcePoolID);
                GetMyMGRFilter(isDefault);
                MGRFilterNotApplied();
                $('#AdvanceFilterIconForManagers').attr("aria-expanded", false);
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
                            GetMGRDetails(Querytext);
                        }
                        MGRFilterApplied();
                        //GetBGDetails(Querytext);
                        // call business group getRiskDetails(currentselectedProjectID, 0, "", "defaultfilterapply", Querytext);
                        if (currentDefaultFilterID > 0) {
                            MGRFilterApplied();
                        }
                        //  GetMyFilter(1);
                        if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                            GetMyMGRFilter(0);
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

        function setMGRfiltervalues(QueryText) {
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
            }

            var arrFields = currWhereClause.split(" ");
            arrFields = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);

            if (arrFields[0] == "RoleId") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#CboMGRFilterRoleId").val(currValue);
                //FillFilterOU();
            }

            if (arrFields[0] == "DesignationID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#CboMGRFilterDesignationID").val(currValue);
                //FillFilterOU();
            }
            if (arrFields[0] == "DepartmentID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#CboMGRFilterDepartmentID").val(currValue);
                //FillFilterOU();
            }
            if (arrFields[0] == "BusinessGroupID") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#CboMGRFilterBusinessGroupID").val(currValue);
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
                //FillFilterOU(currValue);
                $("#CboMGRFilterLocationID").val(currValue);
            }
            if (arrFields[0] == "EmployeeName") {
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                $("#txtMGRFilterEmployeeName").val(currValue.replace(/%/g, ""));

            }

        }


        function MGRFilterApplied() {
            $(".MGRclearalllink").removeClass("clsShowHide");
            $(".filter >  button").addClass("clsFilterHighlight");
        }

        function MGRFilterNotApplied() {
            $(".MGRclearalllink").addClass("clsShowHide");
            $(".filter >  button").removeClass("clsFilterHighlight");
            $('#AdvanceFilterIconForManagers').attr("aria-expanded", false);
        }
        function OpenBasicFilterforMGR() {
            //Start Script for edit basic filter           
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
            //End Script for edit basic filter
        }
        $(".MGRclearalllink").click(function () {
            $(".filter").removeClass("active");
            //$('.filterpanel').collapse('toggle');                

            MGRFilterNotApplied();
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
            currentappliedfilterclause = "";
            ClearMGRFilterDetails(""); ("");
            GetMGRDetails(null);
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

        function btnDeleteMGRFilter(FilterID, FilterName, Flag) {
            FilterName = unescape(FilterName).trim();
            $('#DFilterID1').val(FilterID);
            $('#DFilterName1').val(FilterName);
            $('#DIsApplyed1').val(Flag);
            $('#deleteConfirmAlert1').modal('show');
        }

        function confirmDelete1() {
            var FilterID = $('#DFilterID1').val();
            var FilterName = $('#DFilterName1').val();
            var FilterIsApplyed = $('#DIsApplyed1').val();
            if (FilterIsApplyed == 3) {
                DeleteMGRFilter(FilterID, FilterName, 3);
            } else {
                DeleteMGRFilter(FilterID, FilterName);
            }
        }
        //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021

        //Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                //Added By Dipali V On 6th April 2023 For Placeholder Issue
                if (ID == "cboRESFilterBusinessGroupID" || ID == "cboRPMFilterBusinessGroupID" || ID == "CboMGRFilterBusinessGroupID" || ID =="cboRESFilterVisaTypeID") {
                    document.getElementById(ID).insertBefore(new Option(textval, '0'), document.getElementById(ID).firstChild);
                    $("#" + ID + " option[value='0']").prop('selected', true);
                    //End of Added By Dipali V On 6th April 2023 For Placeholder Issue
                } else {
                    document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);
                    $("#" + ID + " option[value='']").prop('selected', true);
                  
                }
               
            }
        }
        function AllBindPlaceHolderFun() {
            BindPlaceholder("cboRPMFilterBusinessGroupID", "Business Group");
            BindPlaceholder("CboMGRFilterRoleId", "Role");
            BindPlaceholder("CboMGRFilterDesignationID", "Designation");
            BindPlaceholder("CboMGRFilterDepartmentID", "Department");
            BindPlaceholder("CboMGRFilterBusinessGroupID", "Business Group");

            BindPlaceholder("cboRESFilterBusinessGroupID", "Business Group");
            BindPlaceholder("cboRESFilterPostID", "Role");
            BindPlaceholder("cboRESFilterDesignationID", "Designation");
            BindPlaceholder("cboRESFilterDepartmentID", "Department");
            BindPlaceholder("cboRESFilterGradeID", "Grade");
            BindPlaceholder("cboRESFilterTotalExp", "Experience");
            BindPlaceholder("cboRESFilterToolID", "Skill");
            BindPlaceholder("cboRESFilterCertificationID", "Certification");
            BindPlaceholder("cboRESFilterQualificationID", "Qualification");
            BindPlaceholder("cboRESFilterProjectID", "Project");
            BindPlaceholder("cboRESFilterRPMID", "Resource Pool");
            BindPlaceholder("cboRESFilterVisaTypeID", "Visa Type");
            BindPlaceholder("cboRESFilterCountryID", "Visa Country");
            BindPlaceholder("cboRESFilterPassportNumber", "Passport");
        }
        //End of Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021

        //added by Ashwini M.on 23-3-2023
        $("#MyFiltersdropdown").click(function () {
            $('.tooltip').removeClass('show');
        });
        $("#MyFiltersdropdown").hover(function () {
            $('.tooltip').removeClass('show');
        });
        //End Of added by Ashwini M.On 23-3-2023

    </script>

</body>

</html>
