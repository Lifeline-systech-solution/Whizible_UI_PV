<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_proficiency.aspx.vb" Inherits="PbNIT.RM_proficiency" %>

<!DOCTYPE html>
<html> 
     <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%>
<head runat="server">
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!--  Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
 --%> <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">--%>
 <%--   <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
  <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
 <%--   <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    <link href="../../../Whizible2.0-new/dist/css/BS5_migration.css" rel="stylesheet" />

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

        /*body#bodycCertification-Details {
            padding-right: 0 !important;
        }*/

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
        /* Added by imran on 26-08-2022*/
        .table thead tr th:last-child{ padding-right:8px!important;}
        .dataTables_scrollHeadInner {width: 100% !important;}
        .dataTables_scrollHeadInner table {width: 100% !important;}
        /* Added by imran on 26-08-2022*/
.pagination{ margin-bottom:0!important;}

    </style>

</head>

<body class="hold-transition skin-blue-light sidebar-mini fixed" >
    
    <div class="" id="body-Proficiency"> </div>
        <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-1 text-end graybg">
            <h5 class="pgtitle float-start">Proficiency </h5>
           <a href="javascript:;" class="mainclearalllink" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>

            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
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
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="checkFiltervalidationForPRO();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFlter()">Apply</button>
                                </div>
                                <br />

                                <div class="row">
                                    <div class="col-sm-4 mb-3">
                                        <label>Parameter Group</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                               <select class="form-select input-sm" id="cboPROFilterParameterGroupID">
                                                    <option value="=">=</option>
                                                    <option value="<>"><></option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                               <%-- <select class="form-control input-sm">
                                                    <option>&nbsp;</option>
                                                    <option>Proficiency</option>
                                                </select>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtPROFilterParameterGroupID", "usp_Sel_ParameterGroups " & 7,,, "class='form-select'",, ) %>

                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-4 mb-3">
                                        <label>Parameter Value</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                               <select class="form-select input-sm" id="cboPROFilterParameterValue">
                                                        <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                    </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                     <% CommonFunctions.HTMLControls.DrawTextBox("txtPROFilterParameterValue", "txtPROFilterParameterValue", "form-control", ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-4 mb-3">
                                        <label>Order Number</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                               <select class="form-select input-sm" id="cboPROFilterOrderNumber">
                                                    <option value="=">=</option>
                                                    <option value="<="><=</option>
                                                    <option value="<>"><></option>
                                                    <option value="<"><</option>
                                                    <option value=">">></option>
                                                    <option value=">=">>=</option>
                                              </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                 <% CommonFunctions.HTMLControls.DrawTextBox("txtPROFilterOrderNumber", "txtPROFilterOrderNumber", "form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onkeypress='return Field_OnKeyPressCheck(event)'") %>

                                            </div>

                                        </div>
                                    </div>

                                    <div class="col-sm-4 mb-3">
                                        <label>Description</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboPROFilterParameterDescription">
                                                    <option value="Contains">Contains</option>
                                                        <option value="Ends With">Ends With</option>
                                                        <option value="Exact Word">Exact Word</option>
                                                        <option value="Not Contains">Not Contains</option>
                                                        <option value="Starts With">Starts With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                <%--<textarea class="form-control">&nbsp;</textarea>--%>
                                               <% CommonFunctions.HTMLControls.DrawTextArea("txtPROFilterParameterDescription", "txtPROFilterParameterDescription",, cssClass:="form-control", widthInPixel:=0, ToBeInserted:="onkeypress='return AvoidSpace(this)'") %>
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
            <button class="btn borderbtn mr-5" id="btnAddProf" onclick="addProficiency()" data-bs-trigger="hover" data-placement="bottom" title="Add Proficiency"><i class="fa fa-plus" aria-hidden="true"></i> Add</button>
            <button class="btn borderbtn deletebtn" id="DeleteProf" data-bs-toggle="tooltip" data-placement="bottom" title="Delete" onclick="DeleteProficiencyDetailsAfterConfirm();">Delete</button>
            <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>            
            <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-placement="bottom" title="Back to Resource Plan">Back</a>--%>
            <%--ENd of Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            
        </div>

        <div class="content pt-0">
            <table id="tblprof" class="table table-bordered" style="width:100%;">
                <thead>
                    <tr>
                        <th class="" width="150">Parameter Value</th>
                        <th class="text-start">Description</th>
                        <th class="" width="150">Order Number</th>
                        <th width="50">
                            <div class="custom_chckbox">
                                <input id="ProficiencyListCheck0" class="chckHead" type="checkbox">
                                <label for="ProficiencyListCheck0"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="tblProficiency">
                   
                </tbody>
            </table>
        </div>


        <div class="Resourcedetailpanel">
          <input type="hidden" id="hdnPRO_UniqueIDTab" name="hdnPRO_UniqueIDTab" value="">

            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li class="nav-item"><a href="#RBGdetails" class="nav-link active" data-bs-toggle="tab" id="">Details</a><div></div></li>
                </ul>
                <div class="tab-content">

                    <div id="RBGdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">                            
                            <button class="btn btnyellow mr-5" id="" onclick="SaveProficiencyDetails(0);">Save</button>
                            <button class="btn btnyellow mr-5" id="btnSaveProficiencyDetails" onclick="SaveProficiencyDetails(1);">Save And Add</button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                <label class="required">Parameter Group</label>
                                <%--<select class="form-control" disabled>
                                    <option>Profeciency</option>
                                    <option></option>
                                </select>--%>

                                 <% CommonFunctions.HTMLControls.DrawComboBox("cboParameterGroup", "usp_Sel_ParameterGroups " & 7,,, "class='form-select' disabled",,, ) %>

                            </div>
                            <div class="col-sm-4">
                                <label class="required">Parameter Value</label>
                               <%-- <input type="text" class="form-control" value="BG Code" />--%>
                              <% CommonFunctions.HTMLControls.DrawTextBox("txtParameterValue", "txtParameterValue", cssClass:="form-control", widthInPixel:=0, maxLength:=50) %>

                            </div>
                            <div class="col-sm-4">
                                <label class="required">Order Number</label>
                                <%--<input type="text" class="form-control" value="" />--%>
                                
                               <% CommonFunctions.HTMLControls.DrawTextBox("txtOrderNumber", "txtOrderNumber", cssClass:="form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)' oncopy='return false' onpaste='return false' autocomplete='off' ") %>

                            </div>
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">                            
                            <div class="col-sm-8">
                                <label class="">Description</label>
                               <%-- <textarea class="form-control"></textarea>--%>
                                <%--Commented and Added By Reshma Chavan on 28th Jan 2022 getting crash charaters more than 500 --%>
                                <%--<% CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", cssClass:="form-control", widthInPixel:=0, maxLength:=500) %>--%>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Enter Description (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Description (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                                <%--End of Commented And Added By Reshma Chavan on 28th Jan 2022 getting crash charaters more than 500 --%>
                            </div>
                        </div>
                        </div>
                        

                    </div>

                </div>
            </div>
        </div>

        <!-- Save filter Modal start here-->
        <div class="modal custmodal ProSavefilter_filter fade" id="ProSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modalsmall ui-draggable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="ProSavefilterfilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end required">Filter Name :</label>
                                            <div class="col-md-8">
                                              <% CommonFunctions.HTMLControls.DrawTextBox("txtPROFilterName", "txtPROFilterName", "form-control",, maxLength:=100, ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>

                                                <div class="btnrow">
                                                    <button class="btn btnyellow float-start" id="btnSaveFilter" onclick="SavePROFilterDetails()">Save</button>
                                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end" onclick="cancelsaveapply()">Cancel</button>
                                                </div>
                                            </div>
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
    </div>

    <%--Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021--%>     
    <div id="deleteConfirmAlert" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-bs-dismiss="modal">
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
    

   <!-- REQUIRED JS SCRIPTS -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
  --%>  <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
    
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
                      <%--Commented and Modified By RehanC for Deletion pop-up Issue on 28th Mar 2023--%>
                    <%--<div class="form-group row">
                        <strong>Note:</strong> Proficiency which is in use cannot be deleted.<br />--%>
                    <div class="notebox">
                        <strong>Note:</strong> Proficiency which is in use cannot be deleted.<br />
                        <%--End Of Comment By RehanC--%>
                        <p id="showdeleterow"></p>
                    </div>
                    <%--<div class="form-group row">
                        Are you sure, you want to delete the selected records?
                    </div>--%>

                    <div class="text-end">
                       <%-- <button class="btn btnyellow" onclick=" DeleteProficiencyDetailsAfterConfirm()">Yes</button>--%>
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>


    <script>
        //Added By Riddhesh Patil on 07-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of  Added By Riddhesh Patil

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        function addProficiency() {
            $('[data-toggle="tooltip"]').tooltip('dispose');
            $('#hdnPRO_UniqueIDTab').val(0);
            $('#txtParameterValue').val("");
            $('#txtParameterValue').val("");
            $('#txtOrderNumber').val("");
            $('#txtDescription').val("");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $("#profiencyListTbl_wrapper .dataTables_scrollBody, .paginate_button, .backbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
        }


        function editProficiency() {
            $('#tblProficiency').on('click', '.BGdetalilink', function () {
                var $row = $(this).closest("tr");
                $tds = $row.find("td");
                var hdnParameterId = $row.find('#hdn_ParameterID').val();
                $('#hdnPRO_UniqueIDTab').val(hdnParameterId);               
                $.each($tds, function (index, obj) {
                    var hiddenField = $(this).find("input[type='hidden']").val();
                    if (hiddenField != 'undefined' && hiddenField != null) {
                        var eventId = hiddenField;
                       // $('#hdn_ParameterID').html(eventId);

                    }
                   
                    //if (hdnParameterId != 'undefined' && hdnParameterId != null) {
                    //    $("#cboParameterGroup").val(hdnParameterId);
                    //}
                    if (index == 0) {
                        $('#txtParameterValue').val($(this).text().trim());

                    }
                    if (index == 2) {
                        $('#txtOrderNumber').val($(this).text());
                    }
                    if (index == 1) {
                        $('#txtDescription').val($(this).text());
                    }
                   
                    //$(".dataTables_scrollBody").css("height", "auto!important");
                    $(".Resourcedetailpanel").show();
                    $('html,body').animate({
                        scrollTop: $(".Resourcedetailpanel").offset().top - 60
                    }, 'slow');
                    //used for disable grid
                    $("#profiencyListTbl_wrapper .dataTables_scrollBody, .paginate_button, .backbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
                });
            });
        }
        //$(".BGdetalilink").click(function () {
        //    $(this).closest('tr').addClass('rowhiglight');
        //});


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#profiencyListTbl_wrapper .dataTables_scrollBody, .paginate_button, .backbtn, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

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
        var proficiencyTable;
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip({ placement: 'right', html: true, trigger: 'hover' });
            $('.btn').tooltip({ trigger: 'hover' });

            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (blnAddAccess == "False") {
                $("#btnAddProf").addClass("clsShowHide");
                $('#btnSaveProficiencyDetails').attr("disabled", true);
                
            }
            else {
                $("#btnAddProf").removeClass("clsShowHide");
                $('#btnSaveProficiencyDetails').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#DeleteProf").addClass("clsShowHide");
            }
            else {
                $("#DeleteProf").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {
            GetMaximumItemsToShowInList();
                GetMyPROFilter(0);
               
            if (currentDefaultFilterID > 0) {
                ApplySavedFilter(currentDefaultFilterID, 2);
                FilterApplied();

            } else {
                //Commented & Added By Dipali V On 30th March 2023 For Filter Issue
              //  GetProficiency(null);
                GetProficiency("");
                //End of Commented & Added By Dipali V On 30th March 2023 For Filter Issue
              
                FilterNotApplied();
            }
        }else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
            //GetProficiency();
             //Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
            BindPlaceholder("txtPROFilterParameterGroupID", "Parameter Group");         
            //End of Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
        });
        
         function LoadPagination(data) {
            
            $.fn.DataTable.ext.pager.numbers_length = 5;
             proficiencyTable =  $('#tblprof').dataTable({
                "dtat": data,
                 /*"sScrollY": (0.5 * $(window).height()),*/
               "sScrollY": true,
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
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [3] }]// Added By Pradip on 20 July 2021
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
        $('#profiencyListTbl').DataTable().columns.adjust().draw();

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
            $('#tblprof_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 220, "overflow-y": "auto" });

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
         //var selectedProficiency = [];
        $(".chckHead").change(function () {
            var allPages = proficiencyTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#tblprof").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedEmpID.push(parseInt($(rows[i]).find("#hdn_ParameterID").val()));
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
        
        function checkUncheck() {

            if (proficiencyTable.$('input:checked').length == proficiencyTable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
            }
        }

        function GetProficiency(PROFilterParms) {
          
            //Added by imran on 19-08-2022
            if (PROFilterParms == null || PROFilterParms == "null" || PROFilterParms == "")
            {
                var PROFilterParms =
                {
                    ProWhereClause: ""
                }
            }
            //End of comment by imran on 19-08-2022
            SelectedEmpID = [];
            var strHTML = "";
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            StartLoader("#body-Proficiency");
            //var where = {ProWhereClause:PROFilterParms.ProWhereClause}
            $.ajax({
                url: strUrl + '/api/RM_Proficiency/GetProficiency',
                type: "POST",
                data: JSON.stringify(PROFilterParms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                   xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (PROFilterParms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PROFilterParms) ? PROFilterParms : JSON.stringify(PROFilterParms)));
                    }
                },
                success: function (data) {
                    var List = data;
                    //console.log("List",List);
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            if (blnEditAccess == "True") {
                                strHTML += '<tr><td class="text-center"> <a href="javascript:;" class="BGdetalilink" onclick="editProficiency()"</a><input type="hidden" name="hdn_ParameterID" id="hdn_ParameterID" value= ' + obj.ParameterID + '>' + obj.ParameterValue + '</td><td class="text-start">' + obj.ParameterDescription + '</td><td class="text-center">' + obj.OrderNumber + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedProficiency(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                            }
                            else {
                                strHTML += '<tr><td class="text-center"> <input type="hidden" name="hdn_ParameterID" id="hdn_ParameterID" value= ' + obj.ParameterID + '>' + obj.ParameterValue + '</td><td class="text-start">' + obj.ParameterDescription + '</td><td class="text-center">' + obj.OrderNumber + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedProficiency(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                            }

                        });
                    }

                    $('#tblprof').dataTable().fnDestroy();
                    $("#tblProficiency").html(strHTML);
                    LoadPagination(data);
                    StopAjaxLoader("#body-Proficiency");
                    $(".chckHead").prop("checked", false);
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-Proficiency");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.responseText);
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                           // window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-Proficiency");
                },
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
            })

        }
        //disabled copy and paste
$('#txtPROFilterOrderNumber').bind('copy paste', function (e) {
        e.preventDefault();
    });
        //for filter criteria
        function Field_OnKeyPressCheck(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    //alertify.set('notifier', 'position', 'top-right');
                    //alertify.error("Please enter only numeric values");
                }
               
            }
            return ret;
        }

        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function Field_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    $("#txtOrderNumber").focus();
                   
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.error("Please enter only numeric values");
                    alertify.error("Please enter numeric value greater than 0");
                }
            }
            return ret;
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

             if ($("#txtParameterValue").val().trim() == undefined || $("#txtParameterValue").val().trim() == "" || $("#txtParameterValue").val().trim() == null) {
                 $("#txtParameterValue").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter Parameter Value");
                return false;
             }
             //Added By Riddhesh Patil on 07-NOV-2022 
             else if (checkSpecialCharacter($("#txtParameterValue").val().trim(), WebConfigSpecialCharacters) == true) {

                 //Added by Aditya J. on 08-11-2024
                 validateflag = false;
                 //End of Added by Aditya J. on 08-11-2024

                 alertify.set('notifier', 'position', 'top-right');
                 alertify.error('Parameter Value should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                 $("#txtParameterValue").focus();
                 return false;
             }
			//End of  Added By Riddhesh Patil
             else if ($("#txtOrderNumber").val().trim() == undefined || $("#txtOrderNumber").val().trim() == "" || $("#txtOrderNumber").val().trim() == null) {
                 $("#txtOrderNumber").focus();
                 validateflag = false;
                 alertify.set('notifier', 'position', 'top-right');
                 //alertify.error("Please enter Order Number");
                 alertify.error("Please enter numeric value greater than 0");
                 return false;
             }
                 else if ($("#txtOrderNumber").val().trim() != null && $("#txtOrderNumber").val().trim().match(/^(-?\d*)((\.(\d{0,2})?)?)$/i) == null) {
                $("#txtOrderNumber").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter only numeric values.");
                return false;
             }
             //Added By Riddhesh Patil on 07-NOV-2022 
             else if (checkSpecialCharacter($("#txtDescription").val().trim(), WebConfigSpecialCharacters) == true) {

                 //Added by Aditya J. on 08-11-2024
                 validateflag = false;
                 //End of Added by Aditya J. on 08-11-2024

                 alertify.set('notifier', 'position', 'top-right');
                 alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                 $("#txtDescription").focus();
                 return false;
             }
			//End of  Added By Riddhesh Patil
            else {
                validateflag = true;
                return true;
            }
        }
        var validateflag
        function SaveProficiencyDetails(isFromSaveAndclick) {
            //debugger;
            checkValidation();
            if (validateflag == true) {
                var parameterId = $("#hdnPRO_UniqueIDTab").val();
                var parameterGroupId = $("#cboParameterGroup ").val();
                var parameterValue = $("#txtParameterValue ").val().replace(/'/g, "''");
                var orderNumber = $("#txtOrderNumber ").val();
                var description = $("#txtDescription ").val().replace(/'/g, "''");
                var Details = {
                    ParameterID: parameterId > 0 ? parameterId : 0,
                    ParameterGroupID: parameterGroupId,
                    ParameterValue: parameterValue,
                    OrderNumber: orderNumber,
                    ParameterDescription: description,
                    CreatedBy: encodeURI(UserName)
                };

                $.ajax({
                    url: strUrl + '/api/RM_Proficiency/SaveProficiencyDetails',
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
                        GetProficiency();

                        if (isFromSaveAndclick == 0) {
                            if (data == "Parameter value already exist." || data == "Order number already exist.") {

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {

                                //onClose();
                                //commeneted and Added by Aditya J. on 08-11-2024
                                //$('#Resourcedetailpanel').modal('hide');                                
                                $(".Resourcedetailpanel").hide();
                                //End of Added by Aditya J. on 08-11-2024

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                            }
                        }
                        else {
                            if (data == "Parameter value already exist." || data == "Order number already exist.") {

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                onClose();
                                //$('#Resourcedetailpanel').modal('hide');
                               //commeneted and Added by Aditya J. on 08-11-2024
                                $(".Resourcedetailpanel").hide();
                                //End of Added by Aditya J. on 08-11-2024
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                            }
                        }
                        //StopAjaxLoader("#bodyGlobal-Resource");
                        // alertify.set('notifier', 'position', 'top-right');
                        //alertify.success(data);
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
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            //CurrentGRPTabObject.GrpManager = 'false';
                            GetProficiency();
                            // CurrentGRPTabObject.GrpManager = 'true';
                            StopAjaxLoader("#body-Proficiency");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                     
                        StopAjaxLoader("#body-Proficiency");
                        if (isFromSaveAndclick == 0) {
                            $('#Resourcedetailpanel').modal('hide');
                        }
                    }
                })
            } else {
                return false;
            }
              //else {
              //      alertify.set('notifier', 'position', 'top-right');
              //      alertify.notify("Parameter Value is mandatory");
              //  }
        }
        function onClose() {
             $('#hdnPRO_UniqueIDTab').val(0);
                            $('#txtParameterValue').val("");
                            $('#txtParameterValue').val("");
                            $('#txtOrderNumber').val("");
                            $('#txtDescription').val("");
        }
         var SelectedEmpID = [];
       // var selectedProficiencyParameterID = '';
         function GetSelectedProficiency(currentObject) {
                var row = $(currentObject).closest("tr");
                if (row.find('input[type="checkbox"]').is(':checked')) {
                    SelectedEmpID.push(parseInt(row.find('#hdn_ParameterID').val()));
                }
                else {
                    if (SelectedEmpID != 'undefined' && SelectedEmpID.length > 0) {
                        var removeEmp = row.find('#hdn_ParameterID').val();
                        SelectedEmpID.remove(parseInt(removeEmp));
                    }
                }
                
        }
         Array.prototype.remove = function() {
                var what, a = arguments, L = a.length, ax;
                while (L && this.length) {
                    what = a[--L];
                    while ((ax = this.indexOf(what)) !== -1) {
                        this.splice(ax, 1);
                    }
                }
                return this;
        };

        //function DeleteProficiencyDetails() {
        //    var isSelectedResource = GetSelectedProficiency();
        //    if (isSelectedResource.length > 0) {
        //        $('#DeleteConfirmMModal').modal('show');

        //    } else {
        //        alertify.set('notifier', 'position', 'top-right');
        //        alertify.error(DeleteRecord);
        //        return false;
        //    }
        //}

        function DeleteProficiencyDetailsAfterConfirm() {
            var strHTML = "";
            var selectedProficiencyParameterID = SelectedEmpID.toString();
            if (selectedProficiencyParameterID.length > 0) {
            $.ajax({
                url: strUrl + '/api/RM_Proficiency/DeleteProficiencyDetails',
                type: "POST",
                data: JSON.stringify(selectedProficiencyParameterID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    StartLoader("#body-Proficiency");
                   xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (selectedProficiencyParameterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(selectedProficiencyParameterID) ? selectedProficiencyParameterID : JSON.stringify(selectedProficiencyParameterID)));
                    }
                },
                success: function (data) {
                    //if (data != "") {
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.error(data);
                    //}

                    StopAjaxLoader("#body-Proficiency");
                    GetProficiency();
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
                    }
                    else if (xhr.statusText == "OK") {  //200
                        GetProficiency();
                        $('#DeleteConfirmMModal').modal('hide');
                        //alertify.set('notifier', 'position', 'top-right');
                        // alertify.notify("Deleted");
                    }
                    // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                

                    StopAjaxLoader("#body-Proficiency");
                    $('#DeleteConfirmMModal').modal('hide');
                }
                })
                } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedEmpID = [];
            //selectedProficiency=[];
            selectedProficiencyParameterID = "";
        }
        
        function ApplyFlter() {
            var filterFlag = true;           
            var GroupID = $("#txtPROFilterParameterGroupID").val() == "" ? null:$("#txtPROFilterParameterGroupID").val();
            var GroupName = $("#txtPROFilterParameterValue").val() == "" ? null : $("#txtPROFilterParameterValue").val();
            var OrderNo = $("#txtPROFilterOrderNumber").val() == "" ? null : $("#txtPROFilterOrderNumber").val();
            var Desc = $("#txtPROFilterParameterDescription").val() == "" ? null : $("#txtPROFilterParameterDescription").val();

            if ((GroupID == null || GroupID == 'undefined' || GroupID == 0 || GroupID == ' ') && (GroupName == null || GroupName == 'undefined' || GroupName == ' ') && (OrderNo == null || OrderNo == 'undefined' || OrderNo == ' ') && (Desc == null || Desc == 'undefined' || Desc == ' ')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                filterFlag = false;
                return false;
            }
            if (filterFlag == true) {
                currentFilterID = 0;
                var filter = "";
                var AllProFilter = ["ParameterGroupID", "ParameterValue", "OrderNumber", "ParameterDescription"];
                var filterWhereClause2 = GeneratePROBasicFilterQuery("PRO", AllProFilter);
                var filterWhereClause = (filterWhereClause2).replace(/"/g, "\'");
                //Commented & Added By Dipali V On 30th March 2023 For Filter Issue
                //filter = { UniqueID: '0', ProWhereClause: encodeURIComponent(filterWhereClause) }
                filter = { UniqueID: '0', ProWhereClause: filterWhereClause }
                //End of Commented & Added By Dipali V On 30th March 2023 For Filter Issue
                FilterApplied();
                GetProficiency(filter);
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
            for (var i = 0; i < arr.length; i++) {
                //alert(arr[i]);
            }

            var arrFields = currWhereClause.split(" ");
            arrFields = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);
            if (arrFields[0] == "OrderNumber") {
                //Commented & Added By Dipali V On 30th March 2023 For Filter binding Issue 
                //setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPROFilterOrderNumber", "txtPROFilterOrderNumber");

                var currOpToolCategory = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                //setFilterComboValue("txtPROFilterParameterGroupID", currOpToolCategory);
                setFilterComboValue("cboPROFilterOrderNumber", currOpToolCategory);
                setFilterComboValue("txtPROFilterOrderNumber", currValue);
                //End of Commented & Added By Dipali V On 30th March 2023 For Filter binding Issue 
            }
            if (arrFields[0] == "ParameterValue") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPROFilterParameterValue", "txtPROFilterParameterValue");
            }
            if (arrFields[0] == "ParameterGroupID") {
              //setFilterOpComboFieldValue(currWhereClause, arrFields, "txtPROFilterParameterGroupID", "txtPROFilterParameterGroupID");
                
                var currOpToolCategory = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                //setFilterComboValue("txtPROFilterParameterGroupID", currOpToolCategory);
                setFilterComboValue("cboPROFilterParameterGroupID", currOpToolCategory);
                setFilterComboValue("txtPROFilterParameterGroupID", currValue);
            }
            if (arrFields[0] == "ParameterDescription") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPROFilterParameterDescription", "txtPROFilterParameterDescription");

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
            //Added By Reshma Chavan on 31st Jan 2022
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
            //End of Added By Reshma Chavan on 31st Jan 2022
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
            //$("#" + ValueComboName).val(currValue);
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }

        function cancelsaveapply() {
             if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID=="") {
              $('#txtPROFilterName').val("");
            }
        }
        function ClearFilterDetails(flag) {
             $("#txtPROFilterParameterGroupID").val("");
            if ($("#cboPROFilterOrderNumber").val() != "Contains") {
                setFilterComboValue("cboPROFilterOrderNumber", "Contains");
            }
            if ($("#txtPROFilterOrderNumber").val() != "") {
                $("#txtPROFilterOrderNumber").val("");
            }
            if ($("#txtPROFilterParameterValue").val() != "") {
                $("#txtPROFilterParameterValue").val("");
            }
            if ($("#cboPROFilterParameterValue").val() != "Contains") {
                setFilterComboValue("cboPROFilterParameterValue", "Contains");
            }
            if ($("#cboPROFilterParameterDescription").val() != "Contains") {
                setFilterComboValue("cboPROFilterParameterDescription", "Contains");
            }
            
             $("#txtPROFilterName").val("");
         
            $("#txtPROFilterParameterDescription").val("");
            //Added By Reshma chavan on 31 Jan 2022 to set combo default value
            $("#cboPROFilterOrderNumber").val("="); 
            $("#cboPROFilterParameterGroupID").val("=");
            //End of Added By Reshma chavan on 31 Jan 2022 to set combo default value
            savedFilterName = "";

            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {

                    $(this).removeAttr("checked");
                });
            }

        }
        function clearTooltip() {




            $('[data-bs-toggle="tooltip"], [data-bs-toggle="collapse"], [data-bs-toggle="dropdown"],[data-bs-toggle="modal"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [data-bs-toggle="collapse"], [data-bs-toggle="dropdown"],[data-bs-toggle="modal"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [data-bs-toggle="collapse"], [data-bs-toggle="dropdown"],[data-bs-toggle="modal"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [data-bs-toggle="collapse"], [data-bs-toggle="dropdown"],[data-bs-toggle="modal"], [title]:not([data-bs-toggle="popover"])').tooltip('hide');
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
            GetPRODetails(null);
            GetMyPROFilter(0); // Added By Mahesh 21 July 2021
        });

        function GetPRODetails(whereClause) {
            //debugger;
            var filter = "";
            if (whereClause != null) {
                //var whereClauseFormated = whereClause.replace(/'/g, "\''");
                //Commented & Added By Dipali V On 30th March 2023 For Filter Issue
                filter = { UniqueID: '0', ProWhereClause: encodeURIComponent(whereClause) };
                //filter = { UniqueID: '0', ProWhereClause: whereClause };
                //End of Commented & Added By Dipali V On 30th March 2023 For Filter Issue
            }
           
            GetProficiency(filter);
        }
        //filter validation
         function checkFiltervalidationForPRO()
         {
            var GroupID = $("#txtPROFilterParameterGroupID").val() == "" ? null:$("#txtPROFilterParameterGroupID").val();
            var GroupName = $("#txtPROFilterParameterValue").val() == "" ? null : $("#txtPROFilterParameterValue").val();
            var OrderNo = $("#txtPROFilterOrderNumber").val() == "" ? null : $("#txtPROFilterOrderNumber").val();
            var Desc = $("#txtPROFilterParameterDescription").val() == "" ? null : $("#txtPROFilterParameterDescription").val();
            //alert(GroupID+ ","+ GroupName+","+ OrderNo +","+ Desc);
            if ((GroupID == null || GroupID == 'undefined' || GroupID == 0) && (GroupName == null || GroupName == 'undefined' || GroupName == ' ') && (OrderNo == null || OrderNo == 'undefined' || OrderNo == ' ') && (Desc == null || Desc == 'undefined' || Desc == ' '))
            {                
                alertify.set('notifier', 'position', 'top-right');
                 alertify.error('Apply filter on at least one field');
                 $('#ProSavefilter').modal('hide');
            }
            else {                
                $('#ProSavefilter').modal('show');
            }
        }
        function AvoidSpace(input) {
            if (/^\s/.test(input.value))
                input.value = '';
        }
        function SavePROFilterDetails() {
            var fltFilterName = $("#txtPROFilterName").val();            
            if (fltFilterName == "" || fltFilterName == " ") {
                //$('#BgSavefilter').modal('show');
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name');
                //$('#BgSavefilter').modal('show')

                $("#txtPROFilterName").focus();

                //return false
            }

              //Commnet and Added By Riddhesh Patil on 12-NOV-2022 
            //else if ($("#txtPROFilterName").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtPROFilterName").focus();
            //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Filtername cannot contain any of these /\:*?<>|,"+- characters.');
            //}
            else if (checkSpecialCharacter($("#txtPROFilterName").val().trim(), WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPROFilterName").focus();

            }
			//End of Comment Added By Riddhesh Patil
            else {
                var filterExists = 0;
                //if (savedFilterName == "") {
                //    filterExists = ExistPROFilter(fltFilterName);
                //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                //    $('#ProSavefilter').modal('show');
                //}

                //if (filterExists == 0) {
                //    $("#btnSaveFilter").attr("data-bs-dismiss", "modal");
                var AllProFilter = ["ParameterGroupID", "ParameterValue", "OrderNumber", "ParameterDescription"];
                //var isActiveFilter = 'True';/// $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GeneratePROBasicFilterQuery("PRO", AllProFilter);
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
                            $('#ProSavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            ApplyFlter();
                            FilterApplied();
                            GetMyPROFilter(0);
                            savedFilterName = fltFilterName;
                            $("#txtPROFilterName").val("");
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
        function GetMyPROFilter(flag) {
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
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                    }
                                    else {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                    }
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }

                                strHTML += "</div>";
                            }
                            else {
                                strHTML += "<div class='custom_chckbox_markblue'>";
                                if (blnApply == true) {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }
                            }

                            strHTML += "<span onclick='OpenBasicFilter()' class='edit_filter'>";

                            strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-placement='bottom' title='Edit filter' id='" + ObjMyFilter.FilterId + "' class='fas fa-pencil-alt' onclick='EditFilter(this.id);'></i>";

                            strHTML += "</span>";

                            strHTML += "<span>";
                            if (blnApply == true) {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id,3);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3)></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                            }
                            else {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;)></i>";
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
                        //Added by imran on 27-01-2023
                        $("#MyFiltersdropdown").removeClass("show");
                        //End of comment by imran on 27-01-2023
                    }
                    else {
                        $("#MyFiltersdropdown").addClass("clsShowHide");
                        $("#MyFiltersdropdown").removeClass("dropdown-menu");
                    }
                },
                //Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
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
       

        function ExistPROFilter(filtername) {

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
                    isFilterExists = 1;
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
            return isFilterExists;
        }

        //Delete filter
            //Commented & Added By Rutuja D. For Filter Issue on 7 July 2021
        //function DeleteFilter(FilterID,IsApplyed) {
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
                            GetProficiency();
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyPROFilter(0);
                        currentappliedfilter = 0;
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
        }

        function EditFilter(FilterID) {
            //debugger;
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
                    //debugger;
                    for (var i = 0; i < result.length; i++) {
                        var ObjFilterDtls = result[i];

                        var currentFilterName = ObjFilterDtls.FilterName;
                        currentFilterID = ObjFilterDtls.FilterId;
                        $("#txtPROFilterName").val(currentFilterName);
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
            //Changed  by mahesh on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {
                GetProficiency();
                GetMyPROFilter(isDefault);
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
                            GetPRODetails(Querytext);
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
                            GetMyPROFilter(0);
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
                        //alertify.success('Default');
                        // FilterNotApplied();  
                        ApplySavedFilter(FilterID, 3, true);//changed by mahesh on 21 july 2021
                        alertify.success('Default Filter Is Successfully Removed!');
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        FilterNotApplied();
                    } 
                    GetMyPROFilter(0);
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
        function GeneratePROBasicFilterQuery(module, filterField) {
            try {
               // debugger
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();
                    var strCHK = $('#chk' + module + 'Filter' + filterField[i]).is(":checked");
                    // console.log(strOp);
                    if ($('#txtPROFilterParameterGroupID').val() == "" || $('#txtPROFilterParameterGroupID').val() == undefined) {
                        var strDesc = null;
                    }
                     //Added By Chetan M on 28 July 2021 For IssueID = 29339
                    strvalue = strvalue.replace(/"/g, '""');
                    //End of Added By Chetan M on 28 July 2021 For IssueID = 29339
                    if (strvalue != "" && strvalue != undefined) {

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
                                strqtext += filterField[i] + " = " + '"' + strCHK + '"';
                            }
                            else {
                                //  alert("sddf");
                                strqtext += " AND " + filterField[i] + " ";
                                strqtext += " <> " + '"' + strCHK + '"';
                            }

                        }
                        else {
                            // alert("lastelse");
                            strqtext += filterField[i] + "=" + '"' + strCHK + '"';
                        }
                    }
                    if (strOp == "<>" && strCHK == true) {
                      //   alert(strqtext);
                        if (strvalue == "" || strvalue == undefined) {
                           // alert("if");
                            if (strDesc == null && strDesc == undefined && strqtext=="") {
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
               // console.log("strqtext",strqtext);
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
        //Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }
        //End of Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
    </script>

</body>

</html>
