<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_WorkProfile.aspx.vb" Inherits="PbNIT.RM_WorkProfile" %>

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
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
   --%> <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
   <%-- <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

    

</head>
<style type="text/css">
    #WPListTbl_wrapper .dataTables_scrollHeadInner, #WPListTbl_wrapper table{width:100%!important}
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
        .table thead tr th:last-child {
            padding-right: 8px !important;
        }
        /*Added by pradip on 9-7-21*/
        /*Added by pradip on 20-7-2021*/
        .dataTables_scrollHeadInner {
            width: 100% !important;
        }

            .dataTables_scrollHeadInner table {
                width: 100% !important;
            }
        /*End Added by Pradip*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed">
    <div class="" id="body-WorkProfile"></div>
    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-0 text-right graybg" style="display:table">
            <h5 class="pgtitle pull-left">Work Profile</h5>
            <a href="javascript:;" class="mainclearalllink" onclick="closeFilterPanel()" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline pull-right">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-bs-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
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
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="checkFiltervalidationForWP();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFilter()">Apply</button>
                                </div>
                                <br />

                                <div class="row">
                                    <div class="col-sm-4 form-group">
                                        <label>Parameter Group</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboWPFilterParameterGroupID">
                                                    <option value="=">=</option>
                                                    <option value="<>"><></option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                <%--<select class="form-control input-sm">
                                                    <option>&nbsp;</option>
                                                    <option>Work Profile</option>
                                                </select>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtWPFilterParameterGroupID", "usp_Sel_ParameterGroups " & 5,,, "class='form-control'",, ) %>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-4 form-group">
                                        <label>Parameter Value</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboWPFilterParameterValue">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">Ends With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Starts With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtWPFilterParameterValue", "txtWPFilterParameterValue", "form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:=" onkeypress='return OnDoublePress(event),AvoidSpace(this)'") %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 form-group">
                                        <label>Order Number</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboWPFilterOrderNumber">
                                                    <option value="=">=</option>
                                                    <option value="<="><=</option>
                                                    <option value="<>"><></option>
                                                    <option value="<"><</option>
                                                    <option value=">">></option>
                                                    <option value=">=">>=</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtWPFilterOrderNumber", "txtWPFilterOrderNumber", "form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onkeypress='return Field_OnKeyPressCheck(event)'") %>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="col-sm-4 form-group">
                                        <label>Description</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboWPFilterParameterDescription">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">Ends With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Starts With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextArea("txtWPFilterParameterDescription", "txtWPFilterParameterDescription",, cssClass:="form-control", widthInPixel:=0, maxLength:=500, ToBeInserted:=" onkeypress='return OnDoublePress(event),AvoidSpace(this)'") %>
                                            </div>

                                        </div>
                                    </div>

                                </div>

                                <%--<div class="clearfix"></div>--%>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>
        <!--end filter panel-->

        <div class="container-fluid pt-1 pb-1 text-right">
            <button class="btn borderbtn addbtn mr-5" id="btnAddWP"  onclick="addWp()" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Add Work Profile"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
            <button class="btn borderbtn deletebtn" id="DeleteWP" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete" onclick="DeleteWPDetailsAfterConfirm()">Delete</button>
                <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Back to Resource Configuration">Back</a>--%>
                <%--End of Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>

        </div>
        <%--<div class="clearfix"></div>--%>
        <div class="content pt-0 pb-0"><!--modified by pradip on 9-7-21-->
            <div class="RPMtblouter">

                <table id="WPListTbl" class="table table-bordered" style="width: 100%;">
                    <thead>
                        <tr>
                            <th class="text-center" width="100">Order Number</th>
                            <th class="text-center" width="20%">Parameter Value</th>
                            <th class="text-left" width="50%">Description</th>
                            <th class="text-center" width="80">
                                <div class="custom_chckbox">
                                    <input id="WPListCheck0" class="chckHead" type="checkbox">
                                    <label for="WPListCheck0"></label>
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="tblWorkProfileMain">
                    </tbody>
                </table>
            </div>
             <%--<div class="clearfix"></div>--%>
        </div>


        <div class="Resourcedetailpanel">
            <input type="hidden" id="hdnWP_UniqueIDTab" name="hdnWP_UniqueIDTab" value="">

            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li><a href="#RBGdetails" class="active" data-bs-toggle="tab" id="">Details</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">

                    <div id="RBGdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button class="btn btnyellow mr-5" id="" onclick="SaveWorkProfileDetails(0)">Save</button>
                            <button class="btn btnyellow mr-5" id="btnSaveWPDetails" onclick="SaveWorkProfileDetails(1)">Save And Add</button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>
                        <p class="text-right"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                        <div class="row">
                            <div class="col-sm-4 form-group">
                                <label class="required">Parameter Group</label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboParameterGroup", "usp_Sel_ParameterGroups " & 5,,, "class='form-control' disabled",,, ) %>
                            </div>
                            <div class="col-sm-4 form-group">
                                <label class="required">Parameter Value</label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtParameterValue", "txtParameterValue", cssClass:="form-control", widthInPixel:=0, maxLength:=50) %>
                            </div>
                            <div class="col-sm-4 form-group">
                                <label class="required">Order Number</label>
                                <% 'CommonFunctions.HTMLControls.DrawTextBox("txtOrderNumber", "txtOrderNumber", cssClass:="form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)'") %>
                             <% CommonFunctions.HTMLControls.DrawTextBox("txtOrderNumber", "txtOrderNumber", cssClass:="form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)' oncopy='return false' onpaste='return false' autocomplete='off'") %>

                            </div>
                            <div class="col-sm-8">
                                <label class="">Description</label>
                                <%--                               <% CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", cssClass:="form-control", widthInPixel:=0, maxLength:=500) %>--%>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Enter Description (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Description (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>

        <!-- Save filter Modal start here-->
        <div class="modal custmodal WPSavefilter_filter fade" id="WPSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modalsmall ui-draggable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="WPSavefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-right required">Filter Name :</label>
                                            <span class="col-md-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtWPFilterName", "txtWPFilterName", "form-control",, maxLength:=100, ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>

                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow pull-left" onclick="SaveWPFilterDetails()">Save</button>
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
                                    <button class="btn borderbtn pull-left uncheckbtn" data-bs-dismiss="modal">No</button>
                                    <button class="btn btnyellow" data-bs-toggle="modal" data-bs-original-title="" data-bs-dismiss="modal" title="" onclick="confirmDelete()">Yes</button>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>    
       <%--End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021--%>
    
    <!-- REQUIRED JS SCRIPTS -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
   <%-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>  
    <script src="../../../Plugins/alertify/alertify.min.js"></script>
     <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <div class="modal custmodal fade" id="DeleteConfirmMModal" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Status</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="notebox">
                        <strong>Note:</strong> Work Profile which is in use cannot be deleted.<br />
                        <p id="showdeleterow"></p>
                    </div>

                    <div class="text-right">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <script>
        //Added By Madhuri.K for Remove tooltip 
        $('body').on('click', function () {
            $('.tooltip').remove();
        });

      /*  $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();*/
		//Added By Riddhesh Patil on 07-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of  Added By Riddhesh Patil

        function addWp() {
            $('#hdnWP_UniqueIDTab').val(0);
            $('#txtParameterValue').val("");
            $('#txtOrderNumber').val("");
            $('#txtDescription').val("");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'fast');
            //used for disable grid
            $(".RPMtblouter .dataTables_scrollBody,.backbtn, .addbtn, .paginate_button, .deletebtn, .filter, #WPListTbl_wrapper .dataTables_scrollHead").addClass("DisableContent").parent().css("cursor", "no-drop");
        }

        function editWP() {
            $('#tblWorkProfileMain').on('click', '.BGdetalilink', function () {
                var $row = $(this).closest("tr");
                $tds = $row.find("td");
                var hdnParameterId = $row.find('#hdn_ParameterID').val();
                $('#hdnWP_UniqueIDTab').val(hdnParameterId);
                $.each($tds, function (index, obj) {
                    var hiddenField = $(this).find("input[type='hidden']").val();
                    if (hiddenField != 'undefined' && hiddenField != null) {
                        var eventId = hiddenField;
                        // $('#hdn_ParameterID').html(eventId);

                    }

                    if (index == 1) {
                        $('#txtParameterValue').val($(this).text().trim());

                    }
                    if (index == 0) {
                        $('#txtOrderNumber').val($(this).text());
                    }
                    if (index == 2) {
                        $('#txtDescription').val($(this).text());
                    }
                    //$(".dataTables_scrollBody").css("height", "auto!important");
                    $(".Resourcedetailpanel").show();
                    $('html,body').animate({
                        scrollTop: $(".Resourcedetailpanel").offset().top - 60
                    }, 'fast');
                    //used for disable grid
                    $(".RPMtblouter .dataTables_scrollBody, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter, #WPListTbl_wrapper .dataTables_scrollHead").addClass("DisableContent").parent().css("cursor", "no-drop");
                });
            });
        }
        //$(".BGdetalilink").click(function () {
        //    $(this).closest('tr').addClass('rowhiglight');
        //});


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $(".RPMtblouter,.dataTables_scrollBody, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter, #WPListTbl_wrapper .dataTables_scrollHead").removeClass("DisableContent").parent().css("cursor", "auto");

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
        var workProfileTable;
        $(document).ready(function () {
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            BindPlaceholder("txtWPFilterParameterGroupID", "Parameter Group");
            if (blnAddAccess == "False") {
                $("#btnAddWP").addClass("clsShowHide");
                $('#btnSaveWPDetails').attr("disabled", true);

            }
            else {
                $("#btnAddWP").removeClass("clsShowHide");
                $('#btnSaveWPDetails').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#DeleteWP").addClass("clsShowHide");
            }
            else {
                $("#DeleteWP").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {
                GetMaximumItemsToShowInList();
                GetMyWPFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);
                    FilterApplied();

                } else {
                    GetWorkProfile(null);
                    FilterNotApplied();
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }

           

        });


        //Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
            //$('table').columns.adjust();// added by pradip on 20-7-2021
            $($.fn.dataTable.tables(true)).css('width', '100%');
            $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
         //End of Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
        //datatable
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            workProfileTable = $('#WPListTbl').dataTable({
                "dtat": data,
                //"sScrollY": (0.5 * $(window).height()), //commented by pradip on 20-7-2021
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
                "bScrollCollapse": true,
                "bAutoWidth": true,
                "sScrollX": "100%",
                "sScrollXInner": "100%",
                //Added by imran on 19-08-2022
                pageLength: 10,
                //End of comment by imran on 19-08-2022
                 "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [3] }] //Added By Pradip P.
            });

        }
        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);
        $('#WPListTbl').DataTable().columns.adjust().draw();


        $('#txtWPFilterOrderNumber').bind('copy paste', function (e) {
            e.preventDefault();
        });
        //for filter criteria
        function OnDoublePress(e) {
            var keyCode = e.which ? e.which : e.keyCode
            var flag = true;
            if (keyCode == 34 || keyCode == 44) {
                flag = false;
            }
            return flag;
        }


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
       

        function checkValidation() {
            if ($("#txtParameterValue").val().trim() == undefined || $("#txtParameterValue").val().trim() == "" || $("#txtParameterValue").val().trim() == null) {
                $("#txtParameterValue").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter Parameter Value");
                return false;
            }
            //else if ($("#txtParameterValue").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtParameterValue").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Parameter Value cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtParameterValue").val().trim(), WebConfigSpecialCharacters) == true) {

                //Added by Aditya J. on 08-11-2024
                validateflag = false;
                //End of Added by Aditya J. on 08-11-2024

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Parameter Value should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtParameterValue").focus();
                return false;
            }
			//End of Comment and Added By Riddhesh Patil
            else if ($("#txtOrderNumber").val().trim() == undefined || $("#txtOrderNumber").val().trim() == "" || $("#txtOrderNumber").val().trim() == null) {
                $("#txtOrderNumber").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter Order Number");
                return false;
            }
            else if ($("#txtOrderNumber").val().trim() != null && $("#txtOrderNumber").val().trim().match(/^(-?\d*)((\.(\d{0,2})?)?)$/i) == null) {
                $("#txtOrderNumber").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("Please enter only numeric values.");
                alertify.error("Please enter numeric value greater than 0.");
                return false;
            }
            else if ($("#txtOrderNumber").val().trim() != null && $("#txtOrderNumber").val() == 0) {
                $("#txtOrderNumber").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Order number should not be 0.");
                return false;
            }
            //else if ($("#txtDescription").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtDescription").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Description cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
            else if (checkSpecialCharacter($("#txtDescription").val().trim(), WebConfigSpecialCharacters) == true) {

                //Added by Aditya J. on 08-11-2024
                validateflag = false;
                //End of Added by Aditya J. on 08-11-2024

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtDescription").focus();
                return false;
            }
            else {
                validateflag = true;
                return true;
            }
        }
        //SAVEWP
        var validateflag
        function SaveWorkProfileDetails(isFromSaveAndclick) {
            //debugger;
            checkValidation();
            if (validateflag == true) {
                var parameterId = $("#hdnWP_UniqueIDTab").val();
                var parameterGroupId = $("#cboParameterGroup ").val();
                var parameterValue = $("#txtParameterValue ").val().replace(/'/g, "''");
                var orderNumber = $("#txtOrderNumber ").val();
                var description = $("#txtDescription ").val().replace(/'/g, "''");
                var Paramid = parameterId > 0 ? parameterId : 0
                var Details = {
                    ParameterID: parseInt(Paramid),
                    ParameterGroupID: parseInt(parameterGroupId),
                    ParameterValue: parameterValue,
                    OrderNumber: parseInt(orderNumber),
                    ParameterDescription: description,
                    CreatedBy: encodeURI(UserName)
                };
                //console.log("Details", Details);
                $.ajax({
                    url: strUrl + '/api/RM_WorkProfile/SaveWorkProfileDetails',
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
                        GetWorkProfile();

                        if (isFromSaveAndclick == 0) {
                            // alert(data);
                            if (data == "Parameter value already exist.") {
                                $(".RPMtblouter,.backbtn, .addbtn,.deletebtn, .filter,.mainclearalllink").addClass("DisableContent");

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $("#txtParameterValue").focus();
                            }
                            else if (data == "Order number already exist.") {
                                $(".RPMtblouter,.backbtn, .addbtn,.deletebtn, .filter,.mainclearalllink").addClass("DisableContent");

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $("#txtOrderNumber").focus();
                            }
                            else {
                                //onClose();
                                $(".RPMtblouter,.backbtn, .addbtn,.deletebtn, .filter,.mainclearalllink").removeClass("DisableContent");

                                $(".Resourcedetailpanel").hide();
                                $('#Resourcedetailpanel').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                            }
                        }
                        else {
                            if (data == "Parameter value already exist.") {
                                $(".RPMtblouter,.backbtn, .addbtn,.deletebtn, .filter,.mainclearalllink").addClass("DisableContent");

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $("#txtParameterValue").focus();

                            }
                            else if (data == "Order number already exist.") {
                                $(".RPMtblouter,.backbtn, .addbtn,.deletebtn, .filter,.mainclearalllink").addClass("DisableContent");

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                                $("#txtOrderNumber").focus();
                            }
                            else {
                                onClose();
                                $(".RPMtblouter,.backbtn, .addbtn,.deletebtn, .filter,.mainclearalllink").addClass("DisableContent");

                                // $(".Resourcedetailpanel").hide();
                                $('#Resourcedetailpanel').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                            }
                        }

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            console.log(thrownError);
                            alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            //CurrentGRPTabObject.GrpManager = 'false';
                            GetWorkProfile();
                            // CurrentGRPTabObject.GrpManager = 'true';
                            StopAjaxLoader("#body-WorkProfile");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        StopAjaxLoader("#body-WorkProfile");
                        if (isFromSaveAndclick == 0) {
                            $('#Resourcedetailpanel').modal('hide');
                        }
                    }
                })
            } else {
                return false;
            }
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
                        console.log(thrownError);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(xhr.responseJSON.Message);
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
            $('#WPListTbl_wrapper .dataTables_scroll').css({ 'height': tblheight - 210, "overflow-y": "auto" });

            var tblheight2 = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight2 - 80 });
        }//modified script by pradip on 20-7-2021
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });
         //Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
        $('#WPListTbl').DataTable().columns.adjust().draw();

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
         //End of Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var allPages = workProfileTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#WPListTbl").dataTable().fnGetNodes();
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
        function onClose() {
            $('#hdnWP_UniqueIDTab').val(0);
            $('#txtParameterValue').val("");
            $('#txtParameterValue').val("");
            $('#txtOrderNumber').val("");
            $('#txtDescription').val("");
        }
        var SelectedEmpID = [];
        function GetSelectedWorkProfile(currentObject) {
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

            if (workProfileTable.$('input:checked').length == workProfileTable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
            }
        }
        function GetWorkProfile(WPFilterParms)
        {
            //Added by imran on 19-08-2022
            if (WPFilterParms == null || WPFilterParms == "null" || WPFilterParms == "") {
                var WPFilterParms =
                {
                    WPWhereClause: ""
                }
            }
            //End of comment by imran on 19-08-2022
            SelectedEmpID = [];
            var strHTML = "";
            StartLoader("#body-WorkProfile");
            //var where = {ProWhereClause:PROFilterParms.ProWhereClause}
            $.ajax({
                url: strUrl + '/api/RM_WorkProfile/GetWorkProfile',
                type: "POST",
                data: JSON.stringify(WPFilterParms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (WPFilterParms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(WPFilterParms) ? WPFilterParms : JSON.stringify(WPFilterParms)));
                    }
                },
                success: function (data) {
                    var List = data;

                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            if (blnEditAccess == "True") {
                                strHTML += '<tr><td class="text-center"> <input type="hidden" name="hdn_ParameterID" id="hdn_ParameterID" value= ' + obj.ParameterID + '>' + obj.OrderNumber + '</td><td class="text-center"><a href="javascript:;" class="BGdetalilink" onclick="editWP()"</a>' + obj.ParameterValue + '</td><td class="text-left wrapword">' + obj.ParameterDescription + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedWorkProfile(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                            }
                            else {
                                strHTML += '<tr><td class="text-center"> <input type="hidden" name="hdn_ParameterID" id="hdn_ParameterID" value= ' + obj.ParameterID + '>' + obj.OrderNumber + '</td><td class="text-center">' + obj.ParameterValue + '</td><td class="text-left wrapword">' + obj.ParameterDescription + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedWorkProfile(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                            }

                        });
                    }

                    $('#WPListTbl').dataTable().fnDestroy();
                    $("#tblWorkProfileMain").html(strHTML);
                    LoadPagination(data);
                    StopAjaxLoader("#body-WorkProfile");
                    $(".chckHead").prop("checked", false);
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    StopAjaxLoader("#body-WorkProfile");
                }
            })

        }
        function DeleteWPDetailsAfterConfirm() {
            var strHTML = "";
            var selectedWPParameterID = SelectedEmpID.toString();
            if (selectedWPParameterID.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_WorkProfile/DeleteWPDetails',
                    type: "POST",
                    data: JSON.stringify(selectedWPParameterID),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#body-WorkProfile");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedWPParameterID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedWPParameterID) ? selectedWPParameterID : JSON.stringify(selectedWPParameterID)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //}

                        StopAjaxLoader("#body-WorkProfile");
                        GetWorkProfile();
                         //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        //strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                         //End of Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterow').html(strHTML);
                        $('#DeleteConfirmMModal').modal('show');
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            console.log(thrownError);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(xhr.responseJSON.Message);
                        }
                        else if (xhr.statusText == "OK") {  //200
                            GetWorkProfile();
                            $('#DeleteConfirmMModal').modal('hide');
                            //alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify("Deleted");
                        }

                        StopAjaxLoader("#body-WorkProfile");
                        $('#DeleteConfirmMModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedEmpID = [];
            selectedWPParameterID = "";
        }
        function ApplyFilter() {
            var filterFlag = true;
            var GroupID = $("#txtWPFilterParameterGroupID").val() == "" ? null : $("#txtWPFilterParameterGroupID").val();
            var GroupName = $("#txtWPFilterParameterValue").val() == "" ? null : $("#txtWPFilterParameterValue").val();
            var OrderNo = $("#txtWPFilterOrderNumber").val() == "" ? null : $("#txtWPFilterOrderNumber").val();
            var Desc = $("#txtWPFilterParameterDescription").val() == "" ? null : $("#txtWPFilterParameterDescription").val();
            //alert(GroupID+ ","+ GroupName+","+ OrderNo +","+ Desc);
            if ((GroupID == null || GroupID == 'undefined' || GroupID == 0) && (GroupName == null || GroupName == 'undefined' || GroupName == ' ') && (OrderNo == null || OrderNo == 'undefined') && (Desc == null || Desc == 'undefined' || Desc == ' ')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                filterFlag = false;
                return false;
            }
            if ($("#txtWPFilterParameterDescription").val().trim().match(/[/\:*?<>|,"+-]/)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description cannot contain any of these /\:*?<>|,"+- characters.');
                $('#WPSavefilter').modal('hide');
                filterFlag = false;
                return false;
            }
            if (filterFlag == true) {
                currentFilterID = 0;
                var filter = "";
                var AllWPFilter = ["ParameterGroupID", "ParameterValue", "OrderNumber", "ParameterDescription"];
                //var isActiveFilter = $('#chkDTFilterActive').is(":checked");
                var filterWhereClause2 = GenerateWPBasicFilterQuery("WP", AllWPFilter);
                //filterWhereClause = filterWhereClause2.replace(/"/g, "\''");
                var filterWhereClause = (filterWhereClause2).replace(/"/g, "\'");
                filter = { UniqueID: '0', WPWhereClause: encodeURIComponent(filterWhereClause) }

                FilterApplied();
                GetWorkProfile(filter);
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");
            } else {
                return false;
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
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboWPFilterOrderNumber", "txtWPFilterOrderNumber");
            }
            if (arrFields[0] == "ParameterValue") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboWPFilterParameterValue", "txtWPFilterParameterValue");
            }
            if (arrFields[0] == "ParameterGroupID") {

                var currOpToolCategory = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                //setFilterComboValue("txtWPFilterParameterGroupID", currOpToolCategory);
                setFilterComboValue("cboWPFilterParameterGroupID", currOpToolCategory);
                setFilterComboValue("txtWPFilterParameterGroupID", currValue);
            }
            if (arrFields[0] == "ParameterDescription") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboWPFilterParameterDescription", "txtWPFilterParameterDescription");

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
                if (OpComboName == "cboWPFilterOrderNumber") {
                    setFilterComboValue(OpComboName, "=");
                }
                if (OpComboName == "cboWPFilterParameterValue") {
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

            //Commented & added by mahesh on  27 july 2021
            //$("#" + ValueComboName).val(currValue);
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }
        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtWPFilterName').val("");
            }
        }
        function ClearFilterDetails(flag) {
            $("#txtWPFilterParameterGroupID").val("");
            if ($("#cboWPFilterOrderNumber").val() != "=") {
                setFilterComboValue("cboWPFilterOrderNumber", "=");
            }
            if ($("#txtWPFilterOrderNumber").val() != "") {
                $("#txtWPFilterOrderNumber").val("");
            }
            if ($("#txtWPFilterParameterValue").val() != "") {
                $("#txtWPFilterParameterValue").val("");
            }
            if ($("#cboWPFilterParameterValue").val() != "Contains") {
                setFilterComboValue("cboWPFilterParameterValue", "Contains");
            }
            $("#txtWPFilterName").val("");

            $("#txtWPFilterParameterDescription").val("");

            //Added By Reshma Chavan on 31st Jan 2022          
             if ($("#cboWPFilterParameterDescription").val() != "Contains") {
                setFilterComboValue("cboWPFilterParameterDescription", "Contains");
            }
            $("#cboWPFilterParameterGroupID").val("=");
            //End of Added By Reshma Chavan on 31st Jan 2022

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
               // $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
        }

        $('.fas,.customradio').click(function () {
            $('.tooltip').removeClass('show');

        });

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
                $(this).attr("data-bs-original-title", "Apply filter");
            });
            $('[data-bs-toggle="tooltip"]').tooltip();

            fltPersonResponsible = "";
            currentappliedfilter = 0;
            currentFilterID = 0;
            currentappliedfilterclause = "";
            ClearFilterDetails("");
            GetWPDetails(null);
            GetMyWPFilter(0);
        });

        function GetWPDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                //var whereClauseFormated = whereClause.replace(/'/g, "\''");
                filter = { UniqueID: '0', WPWhereClause: encodeURIComponent(whereClause) };
            }

            GetWorkProfile(filter);
        }
        //filter validation
        function checkFiltervalidationForWP() {
            var GroupID = $("#txtWPFilterParameterGroupID").val() == "" ? null : $("#txtWPFilterParameterGroupID").val();
            var GroupName = $("#txtWPFilterParameterValue").val() == "" ? null : $("#txtWPFilterParameterValue").val();
            var OrderNo = $("#txtWPFilterOrderNumber").val() == "" ? null : $("#txtWPFilterOrderNumber").val();
            var Desc = $("#txtWPFilterParameterDescription").val() == "" ? null : $("#txtWPFilterParameterDescription").val();
            //alert(GroupID+ ","+ GroupName+","+ OrderNo +","+ Desc);
            if ((GroupID == null || GroupID == 'undefined' || GroupID == 0) && (GroupName == null || GroupName == 'undefined' || GroupName == ' ') && (OrderNo == null || OrderNo == 'undefined') && (Desc == null || Desc == 'undefined' || Desc == ' ')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                $('#WPSavefilter').modal('hide');
            }
            else if ($("#txtWPFilterParameterDescription").val().trim().match(/[/\:*?<>|,"+-]/)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description cannot contain any of these /\:*?<>|,"+- characters.');
                $('#WPSavefilter').modal('hide');
            }
            else {
                //alert("SHOW");
                $('#WPSavefilter').modal('show');
            }
        }
        function AvoidSpace(input) {
            if (/^\s/.test(input.value))
                input.value = '';
        }
        function SaveWPFilterDetails() {
            var fltFilterName = $("#txtWPFilterName").val();
            if (fltFilterName == "" || fltFilterName == " ") {
                $("#savefilterbtn").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name');

                $("#txtWPFilterName").focus();

            }
            //else if (fltFilterName.trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#savefilterbtn").removeAttr("data-bs-dismiss");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Filter name cannot contain any of these /\:*?<>|,"+- characters.');
            //    $("#txtWPFilterName").focus();
            //}
            else if (checkSpecialCharacter(fltFilterName.trim(), WebConfigSpecialCharacters) == true) {
                $("#savefilterbtn").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtWPFilterName").focus();
            }
			//End of Comment Added By Riddhesh Patil
            else {
                var filterExists = 0;
                var AllWPFilter = ["ParameterGroupID", "ParameterValue", "OrderNumber", "ParameterDescription"];
                //var isActiveFilter = 'True';/// $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GenerateWPBasicFilterQuery("WP", AllWPFilter);
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
                            $('#WPSavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            ApplyFilter();
                            FilterApplied();
                            GetMyWPFilter(0);
                            savedFilterName = fltFilterName;
                            $("#txtWPFilterName").val("");
                            //clearTooltip();
                            // ClearFilterDetails("");
                        }


                    },
                    error: function (xhr, errorThrown) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    },
                });
                //}
            }
        }
        function GetMyWPFilter(flag) {
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
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                    }
                                    else {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-bs-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                    }
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }

                                strHTML += "</div>";
                            }
                            else {
                                strHTML += "<div class='custom_chckbox_markblue'>";
                                if (blnApply == true) {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-bs-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }
                            }

                            strHTML += "<span onclick='OpenBasicFilter()' class='edit_filter'>";

                            strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-bs-placement='bottom' title='Edit filter' id='" + ObjMyFilter.FilterId + "' class='fas fa-pencil-alt' onclick='EditFilter(this.id);'></i>";

                            strHTML += "</span>";

                            strHTML += "<span>";
                            if (blnApply == true) {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id,3);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3)></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                            }
                            else {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                                //strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id);'></i>";
                                strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;)></i>";
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
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
            clearTooltip();
        }


        function ExistWPFilter(filtername) {

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
                            GetWorkProfile();
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyWPFilter(0);
                        currentappliedfilter = 0;
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
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
                        $("#txtWPFilterName").val(currentFilterName);
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
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }
        function ApplySavedFilter(FilterID, isDefault,isFromDefault) {
            //Changed  by mahesh on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {
                GetWorkProfile();
                GetMyWPFilter(isDefault);
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
                            GetWPDetails(Querytext);
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
                            GetMyWPFilter(0);

                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
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
                    GetMyWPFilter(0);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }
        function GenerateWPBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    strvalue = ($("#txt" + module + "Filter" + filterField[i]).val()).replace(/"/g, "'");;
                    var strCHK = $('#chk' + module + 'Filter' + filterField[i]).is(":checked");
                    // console.log(strOp);
                    if ($('#txtWPFilterParameterGroupID').val() == "" || $('#txtWPFilterParameterGroupID').val() == undefined) {
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


         //Added By Rutuja D. For Bind Filter Placeholder on 15 July 2021
            function BindPlaceholder(ID, Caption) {
                var textval = "Select " + Caption;
                if (document.getElementById(ID) != null) {
                    document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                    $("#" + ID + " option[value='']").prop('selected', true);
                }
            }
        //End of Added By Rutuja D. For Bind Filter Placeholder on 15 July 2021

        //Added by Dipali V On 1st Feb 2022 For Validation Alert
         var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function Field_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode
            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57))
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    $("#txtOrderNumber").focus();
                    alertify.set('notifier', 'position', 'top-right');
                   // alertify.error("Please enter only numeric values");
                    alertify.error("Please enter numeric value greater than 0");
                }
            }
            return ret;
        }
         //End of Added by Dipali V On 1st Feb 2022 For Validation Alert


        function closeFilterPanel() {
            $("#filterpanel").removeClass('show');
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
    </script>

</body>

</html>
