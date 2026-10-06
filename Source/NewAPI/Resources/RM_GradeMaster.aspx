<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_GradeMaster.aspx.vb" Inherits="PbNIT.RM_GradeMaster" %>

<!DOCTYPE html>
<html>
     <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%>
<head runat="server">
 <%--   <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>--%>
    <!--   Tell the browser to be responsive to screen width -->
<%--    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">--%>
   <%-- <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
  <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
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

        /*.clsShowHide {
            display: none !important;
        }*/

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
        .wrapword {
            white-space: pre-wrap; /* CSS3 */
            word-wrap: break-word; /* Internet Explorer 5.5+ */
            /*word-break: break-all;*/
            white-space: normal;
        }
        /*.wrapword {*/
            /*white-space: pre-wrap; /* CSS3 */
            /*word-wrap: break-word;*/ /* Internet Explorer 5.5+ */
            /*word-break: break-all;
            word-wrap:normal;*/

            /*white-space: pre-wrap;
            word-break: break-all;
  word-wrap: break-word;
  overflow-wrap: break-word;
  -webkit-hyphens: auto;
  -moz-hyphens: auto;
  -ms-hyphens: auto;
  hyphens: auto;*/

        /*}*/
        /*.restorelines{
  word-break: unset;
  word-wrap: unset;
  overflow-wrap: unset;
  -webkit-hyphens: unset;
  -moz-hyphens: unset;
  -ms-hyphens: unset;
  hyphens: unset;
  white-space: normal;
}*/
       /*added by  mahesh on 20 july 2021*/
        .hidden {
            display: none;
        }
       .dataTables_filter{
            display:none;

        } 
        /*end added by  mahesh on 20 july 2021*/

        
.table thead tr th:last-child{ padding-right:8px!important;}/*Added by pradip on 9-7-21*/
/*Added by pradip on 20-7-2021*/
.dataTables_scrollHeadInner {width: 100% !important;}
.dataTables_scrollHeadInner table {width: 100% !important;}
/*End Added by Pradip*/



/*css version change default style*/
.pb-1 {padding-bottom: 10px!important;}
.pt-1 {padding-top: 10px!important;}
.table-fixed-header thead tr th, .table thead tr th{ padding:8px;}
body{ /* Modified By Madhuri.K On 26-03-2026 */
    font-size:11.5px!important;
}
.form-control, .btn, a, p,input,select.form-select{
    /* Modified By Madhuri.K On 26-03-2026 */
    font-size:11.5px!important;
}
.table {border-spacing:0 0px;}
table.dataTable thead .sorting:after{ top:8px;}
/*End css version change default style*/

.custmodal .modal-content .modal-header .close{background: transparent; top:8px;}
  .preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;            
            border-radius: 15px;
            background: #ddd; 
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }
    .clsShowHide {
            display: none !important;
        }

#tblGradeMasterMain td a {
    text-decoration: none;
}
.pagination li a{ font-size:14px;}
a{ text-decoration:none;}
.custmodal .modal-content .modal-header .close{background: transparent; top:8px;}
.form-control, .form-select{ font-size:14px;}

.detailsubtabs .nav-link.active a {
    background: #fff;
    border-color: #ddd;
}
div.dataTables_wrapper div.dataTables_paginate {
    margin: 10px 0px 10px;
}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="body-GradeMaster">
        <div id="body-GradeMaster1"> </div>
    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-1 text-end graybg">
            <h5 class="pgtitle float-start">Grade Master</h5>
            <a href="#" class="mainclearalllink" data-bs-toggle="tooltip" data-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div><div class="clearfix"></div>
        </div>

        <!--filter panel-->
        <div id="filterpanel" class="filterpanel collapse">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                <div class="cust_tabpanel">
                    <ul class="nav nav-tabs">
                        <li class="dropdown">
                            <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">My Filters</a>
                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                            </ul>
                        </li>
                        <li class="tabpresetfilter">
                            <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                        </li>


                    </ul>
                </div>

                <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="basicfilters" class="tab-pane stackbasicfilter">
                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="checkFiltervalidationForGM()">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFilter()">Apply</button>
                                </div>
                                <br />

                                <div class="row">
                                    <div class="col-sm-4 form-group">
                                        <label>Grade</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboGMFilterGrade">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">Ends With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Starts With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">

                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtGMFilterGrade", "txtGMFilterGrade", "form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:=" onkeypress='return OnDoublePress(event),AvoidSpace(this)'") %>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-3 form-group">
                                        <label>Weightage</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboGMFilterweightage">
                                                    <option value="=">=</option>
                                                    <option value="<="><=</option>
                                                    <option value="<>"><></option>
                                                    <option value="<"><</option>
                                                    <option value=">">></option>
                                                    <option value=">=">>=</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtGMFilterweightage", "txtGMFilterweightage", "form-control", widthInPixel:=0, maxLength:=3, ToBeInserted:=" onkeypress='return OnDoublePress(event),isNumberKey(event,this)'") %>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="col-sm-5 form-group">
                                        <label>Description</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboGMFilterGradeDescription">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">Ends With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Starts With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextArea("txtGMFilterGradeDescription", "txtGMFilterGradeDescription", cssClass:="form-control", widthInPixel:=0, maxLength:=500, ToBeInserted:=" onkeypress='return OnDoublePress(event),AvoidSpace(this)'") %>
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
            <a class="btn borderbtn addbtn mr-5" id="btnAddGM" data-bs-toggle="tooltip" data-placement="bottom" title="Add Grade" onclick="AddGM()"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
            <button class="btn borderbtn deletebtn" id="DeleteGM" data-bs-toggle="tooltip" data-placement="bottom" title="Delete" onclick="DeleteGMDetailsAfterConfirm()">Delete</button>
            <%--Commented BY Rutuja D. on 1 July 2021 FOr Hide Back Button--%>
            <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-placement="bottom" title="Back to Resource Configuration">Back</a>--%>
           <%--End of Commented BY Rutuja D. on 1 July 2021 FOr Hide Back Button--%>
        </div>

        <div class="content pt-0">
            <div class="Gradetblouter">
            <table id="GMListTbl" class="table table-bordered GmTbllist" style="width: 100%;">
                <thead>
                    <tr>
                        <th class="" width="150">Grade</th>
                        <th class="text-start">Description</th>
                        <th class="" width="150">Weightage</th>
                        <th width="50">
                            <div class="custom_chckbox">
                                <input id="GMListCheck0" class="chckHead" type="checkbox">
                                <label for="GMListCheck0"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="tblGradeMasterMain">
                </tbody>
            </table>
                </div>
        </div>


        <div class="Resourcedetailpanel">
            <input type="hidden" id="hdnGM_UniqueIDTab" name="hdnGM_UniqueIDTab" value="">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li class="nav-item"><a href="#Gmdetails" class="nav-link" data-bs-toggle="tab" id="">Details</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">

                    <div id="Gmdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn btnyellow mr-5" id="" onclick="SaveGradeMasterDetails(0)">Save</button>
                            <button class="btn btnyellow mr-5" id="btnSaveGMDetails" onclick="SaveGradeMasterDetails(1)">Save And Add</button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                        <div class="row">
                            <div class="col-sm-4 form-group">
                                <label class="required">Grade</label>
                                <%--<input type="text" class="form-control" value="QG name" />--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtGrade", "txtGrade", cssClass:="form-control", widthInPixel:=0, maxLength:=50) %>
                            </div>
                            <div class="col-sm-2 form-group">
                                <label class="required">Weightage</label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtWeightage", "txtWeightage", cssClass:="form-control", widthInPixel:=0, maxLength:=3) %>
                            </div>
                            <div class="col-sm-6">
                                <label class="">Description</label>
                                <%--                                <% CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", cssClass:="form-control", widthInPixel:=0, maxLength:=5) %>--%>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Enter Description (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Description (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                            </div>

                        </div>

                    </div>

                </div>
            </div>
        </div>

        <!-- Save filter Modal start here-->
        <div class="modal custmodal GMSave_filter fade" id="GMSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modalsmall ui-draggable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="GMSavefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end required">Filter Name :</label>
                                            <span class="col-md-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtGMFilterName", "txtGMFilterName", "form-control",, maxLength:=100, ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow float-start" onclick="SaveGMFilterDetails()">Save</button>
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

        <div class="clearfix"></div>
    </div>


    <!-- REQUIRED JS SCRIPTS -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.paginate.info.js" type="text/javascript"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>--%>
    <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <%--<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

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
                    <div class="notebox ">
                        <strong>Note:</strong> Grade which is in use cannot be deleted.<br />
                        <p id="showdeleterow"></p>
                    </div>

                    <div class="text-end">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    
       <%--Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021--%>     
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
    
       <%--End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021--%>
    
    <script>

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
		//Added by Riddhesh Patil on 09-NOV-2022
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        //End of Added by Riddhesh Patil on 09-NOV-2022


        //Added by pradip on 14-11-2022 for loader issue
        function StartLoader(bodyID) {
            //logtime('start loader');
            $(bodyID).addClass('preloader');
        }

        function StopLoader(bodyID) {
            jQuery(window).load(function () {
                $(bodyID).removeClass("center");
                $(bodyID).removeClass("preloader");
            });
        }

        function StopAjaxLoader(bodyID) {
            $(bodyID).removeClass("center");
            $(bodyID).removeClass("preloader");


        }

//End added by pradip


        function AddGM() {
            $('#hdnGM_UniqueIDTab').val(0);
            $('#txtGrade').val("");
            $('#txtWeightage').val("");
            $('#txtDescription').val("");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $(".Gradetblouter .dataTables_scrollBody,.backbtn, .addbtn, .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            //$(".table").resize();
        }

        function editGrademasterDetails() {
            $('#tblGradeMasterMain').on('click', '.detalilink', function () {
                var $row = $(this).closest("tr");
                $tds = $row.find("td");
                var hdnGradeId = $row.find('#hdn_GradeID').val();
                $('#hdnGM_UniqueIDTab').val(hdnGradeId);
                $.each($tds, function (index, obj) {
                    var hiddenField = $(this).find("input[type='hidden']").val();
                    if (hiddenField != 'undefined' && hiddenField != null) {
                        var eventId = hiddenField;
                        // $('#hdn_ParameterID').html(eventId);

                    }

                    if (index == 0) {
                        $('#txtGrade').val($(this).text().trim());

                    }
                    if (index == 2) {
                        var A1 = $(this).text();
                        var A = A1.toString().split(".")[0];
                        var B = A1.toString().split(".")[1];
                        if (B > 0) {
                            $('#txtWeightage').val(A1);
                        } else {
                            ($('#txtWeightage').val(A));
                        }
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
                    $(".Gradetblouter .dataTables_scrollBody, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
                    //$(".table").resize();
                });
            });
$('table').columns.adjust();// added by pradip on 20-7-2021
        }
        //$(".detalilink").click(function () {
        //    $(this).closest('tr').addClass('rowhiglight');
        //});


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $(".Gradetblouter, .dataTables_scrollBody, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

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
        var gradeMasterTable;

        $(document).ready(function ()
        {
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            $('.btn, a').tooltip({ trigger: 'hover' });
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });

            $(document).on("click", function () {
                $(".tooltip").removeClass('show');
            });

            if (blnAddAccess == "False") {
                $("#btnAddGM").addClass("clsShowHide");
                $('#btnSaveGMDetails').attr("disabled", true);

            }
            else {
                $("#btnAddGM").removeClass("clsShowHide");
                $('#btnSaveGMDetails').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#DeleteGM").addClass("clsShowHide");
            }
            else {
                $("#DeleteGM").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {
                //Added by mahesh on 20 july 2021
                $(".bgwhite").removeClass("hidden");
               
                GetMaximumItemsToShowInList();
                GetMyGMFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);
                    FilterApplied();

                } else {
                    GetGradeMaster(null);
                    FilterNotApplied();
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }

            //GetMaximumItemsToShowInList();
            //GetGradeMaster(null);
//$('table').columns.adjust();// added by pradip on 20-7-2021
            $($.fn.dataTable.tables( true ) ).css('width', '100%');
        $($.fn.dataTable.tables( true ) ).DataTable().columns.adjust().draw();
$.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
        });


        //datatable
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            gradeMasterTable = $('#GMListTbl').dataTable({
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

            });

        }
        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);
        $('#GMListTbl').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });
$(".collapse").on('hid.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 197, "overflow-y": "auto" });

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
            var allPages = gradeMasterTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#GMListTbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedEmpID.push(parseInt($(rows[i]).find("#hdn_GradeID").val()));
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
        function onClose() {
            $('#hdnGM_UniqueIDTab').val(0);
            $('#txtGrade').val("");
            $('#txtWeightage').val("");
            $('#txtDescription').val("");
        }
        var SelectedEmpID = [];
        function GetSelectedGradeMaster(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedEmpID.push(parseInt(row.find('#hdn_GradeID').val()));
            }
            else {
                if (SelectedEmpID != 'undefined' && SelectedEmpID.length > 0) {
                    var removeEmp = row.find('#hdn_GradeID').val();
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

            if (gradeMasterTable.$('input:checked').length == gradeMasterTable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else 
            {   //Commented and Modified By RehanC for checkbox issue on 7th april 2023
                //$(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
                //End of Comment By RehanC on 7th April 2023
            }
        }
        function GetGradeMaster(GMFilterParms)
        {
            //Added by imran on 19-08-2022
            if (GMFilterParms == null || GMFilterParms == "null" || GMFilterParms == "")
            {
                var GMFilterParms =
                {
                    GMWhereClause :""
                }                 
            }
            //End of comment by imran on 19-08-2022

            SelectedEmpID = [];
            var strHTML = "";
            StartLoader("#body-GradeMaster1");
            //var where = {ProWhereClause:PROFilterParms.ProWhereClause}
            $.ajax({
                url: strUrl + '/api/RM_GradeMaster/GetGradeMaster',
                type: "POST",
                data: JSON.stringify(GMFilterParms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    //Added by imran on 19-08-2022
                    if (GMFilterParms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(GMFilterParms) ? GMFilterParms : JSON.stringify(GMFilterParms)));
                    }
                    //End of comment
                },
                success: function (data) {
                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            if (blnEditAccess == "True") {
                                strHTML += '<tr><td class="text-center"><a href="javascript:;" class="detalilink" onclick="editGrademasterDetails()"</a> <input type="hidden" name="hdn_GradeID" id="hdn_GradeID" value= ' + obj.GradeID + '>' + obj.Grade + '</td><td class="text-start wrapword">' + obj.GradeDescription + '</td><td class="text-center">' + obj.weightage + '</td><td><div class="custom_chckbox"><input id="ID' + index + '" onclick="checkUncheck();GetSelectedGradeMaster(this);" class="chcktbl" type="checkbox"><label for="ID' + index + '"></label></div></td></tr>';
                            }
                            else {
                                strHTML += '<tr><td class="text-center"> <input type="hidden" name="hdn_GradeID" id="hdn_GradeID" value= ' + obj.GradeID + '>' + obj.Grade + '</td><td class="text-start wrapword">' + obj.GradeDescription + '</td><td class="text-center">' + obj.weightage + '</td><td><div class="custom_chckbox"><input id="ID' + index + '" onclick="checkUncheck();GetSelectedGradeMaster(this);" class="chcktbl" type="checkbox"><label for="ID' + index + '"></label></div></td></tr>';
                            }

                        });
                    }

                    $('#GMListTbl').dataTable().fnDestroy();
                    $("#tblGradeMasterMain").html(strHTML);
                    //changed by mahesh on 20 july 2021
                    setTimeout(function () {
                        LoadPagination(data);
                    }, 800);
                    StopAjaxLoader("#body-GradeMaster1");
                    $(".chckHead").prop("checked", false);
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
                    StopAjaxLoader("#body-GradeMaster1");
                }
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
            });

        }
        //disabled copy and paste
        $('#txtGMFilterweightage').bind('copy paste', function (e) {
            e.preventDefault();
        });
        function OnDoublePress(e) {
            var keyCode = e.which ? e.which : e.keyCode
            var flag = true;
            if (keyCode == 34 || keyCode == 44) {
                flag = false;
            }
            return flag;
        }        
         function isNumberKey(evt, obj) {

            var charCode = (evt.which) ? evt.which : event.keyCode
            var value = obj.value;
            var dotcontains = value.indexOf(".") != -1;
            if (dotcontains)
                if (charCode == 46) return false;
            if (charCode == 46) return true;
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
        function checkValidation() {
            if ($("#txtGrade").val().trim() == undefined || $("#txtGrade").val().trim() == "" || $("#txtGrade").val().trim() == null) {
                $("#txtGrade").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Grade should not be left blank");
                return false;
            }
            else if (checkSpecialCharacter($("#txtGrade").val().trim(), WebConfigSpecialCharacters) == true) {

                //Added by Aditya J. on 08-11-2024 
                validateflag = false;
                //Added by Aditya J. on 08-11-2024 

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Grade should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtGrade").focus();
                return false;
            }
            //else if ($("#txtGrade").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtGrade").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Grade cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
            else if ($("#txtWeightage").val().trim() == undefined || $("#txtWeightage").val().trim() == "" || $("#txtWeightage").val().trim() == null) {
                $("#txtWeightage").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Weightage field should not be left blank");
                return false;
            }
            else if ($("#txtWeightage").val().trim() != null && $("#txtWeightage").val().trim().match(/^(-?\d*)((\.(\d{0,2})?)?)$/i) == null) {
                $("#txtWeightage").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter only numeric values for Weightage field.");
                return false;
            }
            else if ($("#txtWeightage").val() < 1 || $("#txtWeightage").val() > 100) {
                $("#txtWeightage").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Weightage should be between 1-100.");
                return false;
            }
            //Added By Riddhesh Patil on 07-NOV-2022 
            else if (checkSpecialCharacter($("#txtDescription").val().trim(), WebConfigSpecialCharacters) == true) {
                //Added by Aditya J. on 08-11-2024 
                validateflag = false;
                //Added by Aditya J. on 08-11-2024
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
        function SaveGradeMasterDetails(isFromSaveAndclick) {
            //debugger;
            checkValidation();
            if (validateflag == true) {
                var GradeID = $("#hdnGM_UniqueIDTab").val();
                //alert(GradeID);
                var Grade = $("#txtGrade").val().replace(/'/g, "''");
                var weightage = $("#txtWeightage").val();
                var description = $("#txtDescription ").val().replace(/'/g, "''");

                var Details = {
                    GradeID: GradeID > 0 ? GradeID : 0,
                    Grade: Grade,
                    weightage: weightage,
                    GradeDescription: description,
                    CreatedBy: encodeURI(UserName)

                };
                //console.log("Details", Details);
                $.ajax({
                    url: strUrl + '/api/RM_GradeMaster/SaveGradeMasterDetails',
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
                        GetGradeMaster();

                        if (isFromSaveAndclick == 0) {
                            //alert(data);
                            if (data == "Grade already exist.") {
                                $(".Gradetblouter,.backbtn,.addbtn,.deletebtn,.filter,.mainclearalllink").addClass("DisableContent");

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                //onClose();
                                $(".Gradetblouter,.backbtn,.addbtn,.deletebtn,.filter,.mainclearalllink").removeClass("DisableContent");

                                $(".Resourcedetailpanel").hide();
                                $('#Resourcedetailpanel').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                            }
                        }
                        else {
                            if (data == "Grade already exist.") {
                                $(".Gradetblouter,.backbtn,.addbtn,.deletebtn,.filter,.mainclearalllink").addClass("DisableContent");

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                onClose();
                                $(".Gradetblouter,.backbtn,.addbtn,.deletebtn,.filter,.mainclearalllink").addClass("DisableContent");

                                //$(".Resourcedetailpanel").hide();
                                $('#Resourcedetailpanel').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                            }
                        }

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
                            GetGradeMaster();
                            // CurrentGRPTabObject.GrpManager = 'true';
                            StopAjaxLoader("#body-GradeMaster1");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""

                        StopAjaxLoader("#body-GradeMaster1");

                    }
                });
            } else {
                return false;
            }
            $('table').columns.adjust();// added by pradip on 20-7-2021
        }

        function DeleteGMDetailsAfterConfirm() {
            var strHTML = "";
            var selectedGMGradeID = SelectedEmpID.toString();
            if (selectedGMGradeID.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_GradeMaster/DeleteGMDetails',
                    type: "POST",
                    data: JSON.stringify(selectedGMGradeID),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#body-GradeMaster1");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedGMGradeID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedGMGradeID) ? selectedGMGradeID : JSON.stringify(selectedGMGradeID)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //}

                        StopAjaxLoader("#body-GradeMaster1");
                        GetGradeMaster();
                        //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        //strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                        //End of Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterow').html(strHTML);
                        $('#DeleteConfirmMModal').modal('show');
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
                            GetGradeMaster();
                            $('#DeleteConfirmMModal').modal('hide');
                            //alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify("Deleted");
                        }

                        StopAjaxLoader("#body-GradeMaster1");
                        $('#DeleteConfirmMModal').modal('hide');
                    }
                });
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedEmpID = [];
            selectedGMGradeID = "";
        }
        function ApplyFilter() {
            var filterFlag = true;           
            var Grade = $("#txtGMFilterGrade").val() == "" ? null : $("#txtGMFilterGrade").val();
            var weightage = $("#txtGMFilterweightage").val() == "" ? null : $("#txtGMFilterweightage").val();
            var Desc = $("#txtGMFilterGradeDescription").val() == "" ? null : $("#txtGMFilterGradeDescription").val();
            
            if ((Grade == null || Grade == 'undefined' || Grade == ' ' ) && (weightage == null || weightage == 'undefined' || weightage == 0) && (Desc == null || Desc == 'undefined' || Desc == ' ')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                filterFlag = false;
                return false;
            }
            if (filterFlag == true) {
                currentFilterID = 0;
                var filter = "";
                var AllGMFilter = ["Grade", "weightage", "GradeDescription"];
                //var isActiveFilter = $('#chkDTFilterActive').is(":checked");
                var filterWhereClause2 = GenerateGMBasicFilterQuery("GM", AllGMFilter);
                var filterWhereClause = (filterWhereClause2).replace(/"/g, "\'");
                //console.log(filterWhereClause);
                filter = { UniqueID: '0', GMWhereClause: encodeURIComponent(filterWhereClause) }


                FilterApplied();
                GetGradeMaster(filter);
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
            if (arrFields[0] == "Grade") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboGMFilterGrade", "txtGMFilterGrade");
            }
            if (arrFields[0] == "weightage") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboGMFilterweightage", "txtGMFilterweightage");
            }
            //if (arrFields[0] == "ParameterGroupID") {

            //    var currOpToolCategory = arrFields[1].toString().trim();
            //    var currValue = arrFields[2].toString().trim();
            //    if (currValue.substring(currValue.length - 1) == "'") {
            //        currValue = currValue.substring(0, currValue.length - 1);
            //    }
            //    if (currValue.substring(0, 1) == "'") {
            //        currValue = currValue.substring(1);
            //    }
            //    setFilterComboValue("txtWPFilterParameterGroupID", currOpToolCategory);
            //    setFilterComboValue("txtWPFilterParameterGroupID", currValue);
            //}
            if (arrFields[0] == "GradeDescription") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboGMFilterGradeDescription", "txtGMFilterGradeDescription");

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
                if (OpComboName == "cboGMFilterweightage") {
                    setFilterComboValue(OpComboName, "=");
                }
                if (OpComboName == "cboGMFilterGrade") {
                    setFilterComboValue(OpComboName, "Exact Word");
                }
                if (OpComboName == "cboGMFilterGradeDescription") {
                    setFilterComboValue(OpComboName, "Exact Word");
                }
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
            //Added by Chetan M on 19 July 2021 for apostrophe in Filter name issue
            //if (currValue.indexOf("''") > -1) {
            //    currValue = currValue.replace(/''/g, "'");
            //}
            //End of Added by Chetan M on 19 July 2021 for apostrophe in Filter name issue
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
                $('#txtGMFilterName').val("");
            }
        }

        function ClearFilterDetails(flag) {
            // $("#txtWPFilterParameterGroupID").val("");
            if ($("#cboGMFilterGrade").val() != "Contains") {
                setFilterComboValue("cboGMFilterGrade", "Contains");
            }
            if ($("#txtGMFilterGrade").val() != "") {
                $("#txtGMFilterGrade").val("");
            }
            if ($("#txtGMFilterweightage").val() != "") {
                $("#txtGMFilterweightage").val("");
            }
            if ($("#cboGMFilterGradeDescription").val() != "Contains") {
                setFilterComboValue("cboGMFilterGradeDescription", "Contains");
            }
            if ($("#cboGMFilterweightage").val() != "=") {
                setFilterComboValue("cboGMFilterweightage", "=");
            }
            $("#txtGMFilterName").val("");
            $("#txtGMFilterGradeDescription").val("");


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
            if ($('.filterpanel').hasClass("show")) {
                $('.filterpanel').removeClass("show");
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
            GetGMDetails(null);
            //changed by mahesh on 21 july 2021
            GetMyGMFilter(0);
            //End changed by mahesh on 21 july 2021
        });

        function GetGMDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                // var whereClauseFormated = whereClause.replace(/'/g, "\''");
                filter = { UniqueID: '0', GMWhereClause: encodeURIComponent(whereClause) };
            }

            GetGradeMaster(filter);
        }
        //filter validation
        var filterFlage;
        function checkFiltervalidationForGM() {
            var Grade = $("#txtGMFilterGrade").val() == "" ? null : $("#txtGMFilterGrade").val();
            var weightage = $("#txtGMFilterweightage").val() == "" ? null : $("#txtGMFilterweightage").val();
            var Desc = $("#txtGMFilterGradeDescription").val() == "" ? null : $("#txtGMFilterGradeDescription").val();
            //alert(GroupID+ ","+ GroupName+","+ OrderNo +","+ Desc);
            if ((Grade == null || Grade == 'undefined' || Grade ==' ') && (weightage == null || weightage == 'undefined' || weightage == 0) && (Desc == null || Desc == 'undefined' || Desc ==' ')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                $('#GMSavefilter').modal('hide');
                filterFlag = false;
                return filterFlag;
            }
            else {
                //alert("SHOW");
                $('#GMSavefilter').modal('show');
                filterFlag = true;
                return filterFlag;
            }
        }
        function AvoidSpace(input) {
            if (/^\s/.test(input.value))
                input.value = '';
        }

        function SaveGMFilterDetails() {
            var fltFilterName = $("#txtGMFilterName").val();
            if (fltFilterName == "" || fltFilterName == " ") {
                $("#savefilterbtn").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name');

                $("#txtGMFilterName").focus();

            }
            //else if (fltFilterName.trim().match(/[/\:*?<>|,"+-]/))
            //{
            //     $("#savefilterbtn").removeAttr("data-bs-dismiss");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Filter name cannot contain any of these /\:*?<>|,"+- characters.');
            //    $("#txtGMFilterName").focus();
            //}
            else if (checkSpecialCharacter(fltFilterName, WebConfigSpecialCharacters) == true) {
                $("#savefilterbtn").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtGMFilterName").focus();
            }
			//End of Comment Added By Riddhesh Patil
            else {
                var filterExists = 0;
                var AllGMFilter = ["Grade", "weightage", "GradeDescription"];
                //var isActiveFilter = 'True';/// $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GenerateGMBasicFilterQuery("GM", AllGMFilter);
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
                            $("#savefilterbtn").removeAttr("data-bs-dismiss");
                        }
                        else {
                            if (data != undefined && data != "") {
                                currentFilterID = data;
                                currentappliedfilter = currentFilterID;
                            }
                            $('#GMSavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            ApplyFilter();
                            FilterApplied();
                            GetMyGMFilter(0);
                            savedFilterName = fltFilterName;
                            $("#txtGMFilterName").val("");
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
        function GetMyGMFilter(flag) {
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
                                //strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id,3);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3)></i>";
                            }
                            else {
                                //strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;)></i>";
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


        function ExistGMFilter(filtername) {

            var isFilterExists = 0;
            var Parameters = {
                FilterName: encodeURI(filtername),
                TagID: encodeURI(TagID),
                ProjectID: null,
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
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
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
        //Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on on 7 July 2021
       // function DeleteFilter(FilterID, IsApplyed) {
        function DeleteFilter(FilterID,FilterName, IsApplyed) {
        //End of Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on on 7 July 2021
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
                       // alertify.success('Filter deleted successfully');
                        if (FilterName.indexOf("'") > -1) { 
                            FilterName = FilterName.replace(/''/g, "'");                            
                        }
                        alertify.success("'" + FilterName + "'" + ' Filter deleted successfully');
                        //End of Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on 7 July 2021
                        if (IsApplyed == 3) {
                            GetGradeMaster();
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyGMFilter(0);
                        currentappliedfilter = 0;
                    }
                },
                //Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue
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
                        $("#txtGMFilterName").val(currentFilterName);
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
                //Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue
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
                GetGradeMaster();
                GetMyGMFilter(isDefault);
                FilterNotApplied();
                ClearFilterDetails(""); // Added By Reshma Chavan on 28th Jan 2022 for clearing filter
                $('#AdvanceFilterIcon').attr("aria-expanded", false);
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
                            GetGMDetails(Querytext);
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
                        //GetBGDetails(Querytext);
                        // call business group getRiskDetails(currentselectedProjectID, 0, "", "defaultfilterapply", Querytext);
                        if (currentDefaultFilterID > 0) {
                            FilterApplied();
                        }
                        if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                            GetMyGMFilter(0);
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
                    }
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
                        ApplySavedFilter(FilterID, 2,true);// Added by Mahesh 21 July 2021
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        //alertify.success('Default');
                        // FilterNotApplied();  
                        ApplySavedFilter(FilterID, 3,true);// Added by Mahesh 20 July 2021
                        alertify.success('Default Filter Is Successfully Removed!');
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        FilterNotApplied();
                    }
                    GetMyGMFilter(0);
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
                    }
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue
            
            });
        }
        function GenerateGMBasicFilterQuery(module, filterField) {
            try {
                 
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    strvalue = ($("#txt" + module + "Filter" + filterField[i]).val()).replace(/"/g, "'");
                    var strCHK = $('#chk' + module + 'Filter' + filterField[i]).is(":checked");
                    // console.log(strOp);
                    //if ($('#txtGMFilterGrade').val() == "" || $('#txtGMFilterGrade').val() == undefined) {
                    //    var strDesc = null;
                    //}
                    //Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                    strvalue = strvalue.replace(/"/g, '""');
                    //End of Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
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


        //Added by Riddhesh Patil for Special Character Validation on 09-NOV-2022 
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
        //End of Added by Riddhesh Patil for Special Character Validation
    </script>

</body>

</html>
