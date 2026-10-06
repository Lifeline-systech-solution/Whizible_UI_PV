<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_SkillCategory.aspx.vb" Inherits="PbNIT.RM_SkillCategory" %>

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
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
   --%> <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
 --%>   <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
  <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    <link href="../../../Whizible2.0-new/dist/css/BS5_migration.css" rel="stylesheet" />    

    

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

        /*New css*/
        #SCListTbl tr td:nth-child(2n) {
            text-align: left;
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
.form-group small{ line-height:normal; display:block; margin-top:5px;}	
.pagination {margin-bottom: 0px!important;}
.form-control, .btn {
    /* Modified By Madhuri.K On 26-03-2026 */
    font-size: 11.5px;
    -webkit-appearance: auto;
}
/*Added By RehanC for pagination Issue on 30th Mar 2023*/
.Resourcedetailpanel .tab-pane {
    padding: 40px 0;
}
/*End Of Comment By RehanC on 30th Mar 2023*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed">
    <div class=""  id="body-SkillCategory"></div>
   <%-- Commented and Aded By RehanC for Ui Issue on 30th Mar 2023 --%>
   <%-- <div class="bgwhite">--%>
    <div class="bgwhite clearfix">
   <%-- End Of Comment By RehanC on 30th MAr 2023 --%>
        <div class="container-fluid pt-1 pb-1 text-end graybg">
            <h5 class="pgtitle float-start">Skill Category</h5>
            <a href="javascript:;" class="mainclearalllink"  onclick="closeFilterPanel()" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
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
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="checkFiltervalidationForSC();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFilter()">Apply</button>
                                </div>
                                <br />

                                <div class="form-group">
                                    <div class="row">
                                    <div class="col-sm-6">
                                        <label>Skill Category</label>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <select class=" form-control input-sm" id="cboSCFilterCategoryName">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">Ends With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Starts With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtSCFilterCategoryName", "txtSCFilterCategoryName", "form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:=" onkeypress='return OnDoublePress(event)'") %>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Description</label>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <select class="form-control input-sm" id="cboSCFilterDescription">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">Ends With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Starts With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-9 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextArea("txtSCFilterDescription", "txtSCFilterDescription",, cssClass:="form-control", widthInPixel:=0, maxLength:=500, ToBeInserted:=" onkeypress='return OnDoublePress(event),AvoidSpace(this)'") %>
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
        </div>
        <!--end filter panel-->

        <div class="container-fluid pt-1 pb-1">
            <%--            <div class="float-start" style="padding-top:5px;"><small><i class="fas fa-square" style="color:red"></i> Red Color indicates applied filters</small></div>--%>
            <div class="text-end">
                <button class="btn borderbtn mr-5 addbtn" id="btnAddSC" onclick="addSkillCategory()"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
                <button class="btn borderbtn deletebtn" id="DeleteSC" onclick="DeleteSCDetailsAfterConfirm()">Delete</button>
                <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
                <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Back to Resource Plan">Back</a>--%>
                <%--End of Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            </div>
        </div>

        <div class="content pt-0">
            <div class="SCtblouter">
                <table id="SCListTbl" class="table table-bordered QTbllist" style="width: 100%;">
                    <thead>
                        <tr>
                            <th class="text-start col-sm-2" >Skill Category</th>
                            <th class="text-start col-sm-5">Description</th>
                            <th class="col-sm-1">
                                <div class="custom_chckbox">
                                    <input id="SCListCheck0" class="chckHead" type="checkbox">
                                    <label for="SCListCheck0"></label>
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="tblSkillCategoryMain">
                    </tbody>
                </table>
            </div>
        </div>


        <div class="Resourcedetailpanel">
            <input type="hidden" id="hdnSC_UniqueIDTab" name="hdnSC_UniqueIDTab" value="">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li class="nav-item"><a href="#RSdetails" class="nav-link active" data-bs-toggle="tab" id="SCDetailsTab">Details</a><div></div>
                    </li>
                    <li class="nav-item"><a href="#RSSkills"  class="nav-link" data-bs-toggle="tab" id="SCSkillsTab" onclick="ShowSkills();">Skills</a><div></div>
                    </li>
                </ul>
                <div class="tab-content">

                    <div id="RSdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn btnyellow mr-5" id="" onclick="SaveSkillCateroryDetails(0);">Save</button>
                            <button class="btn btnyellow mr-5" id="btnSaveSCDetails" onclick="SaveSkillCateroryDetails(1);">Save And Add</button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                        <div class="row">
                            <div class="col-sm-4 form-group">
                                <label class="required">Skill Category</label>
                                <%-- <input id="inputskillcategory" type="text" class="form-control" value="" />--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtSkillCategoryValue", "txtSkillCategoryValue", cssClass:="form-control", widthInPixel:=0, maxLength:=50) %>
                            </div>
                            <div class="col-sm-4 form-group">
                                <label class="">Description</label>
                                <%--   <textarea id="inputskillDesc" class="form-control">
                                </textarea>--%>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Enter Description (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Description (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, False,,,,,,,,) %>
                            </div>

                        </div>

                    </div>

                    <div id="RSSkills" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn btnyellow mr-5" id="" onclick="saveSelectedSkills();">Save</button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="">Cancel</button>
                        </div>
                        <table id="selectskillTbl" class="table table-bordered" style="width: 100%">
                            <thead>
                                <tr>
                                    <th class="text-start">Skills</th>
                                    <th width="80">
                                        <div class="custom_chckbox">
                                            <input id="SCSelectSkillCheck0" class="chckHead1" type="checkbox">
                                            <label for="SCSelectSkillCheck0" style="margin-left: -6px;"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tblSkillTab">
                            </tbody>
                        </table>

                    </div>

                </div>
            </div>
        </div>

        <!-- Save filter Modal start here-->
        <div class="modal custmodal SCsave_filter fade" id="SCsavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="SCsavefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end required">Filter Name :</label>
                                            <div class="col-md-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtSCFilterName", "txtSCFilterName", "form-control",, maxLength:=100, ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow float-start" onclick="SaveSCFilterDetails()">Save</button>
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
    
    <!-- REQUIRED JS SCRIPTS -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
  <%--  <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/datatables/dataTables.bootstrap.min.js"></script>
   <%-- <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

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
                        <strong>Note:</strong> Skill Category which is in use cannot be deleted.<br />--%>
                        <div class="notebox">
                        <strong>Note:</strong> Skill Category which is in use cannot be deleted.<br />
                    <%--End Of Comment By RehanC--%>
                        <p id="showdeleterow"></p>
                    </div>

                    <div class="text-end">
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
        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"))
        tooltipTriggerList.forEach(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });


        function addSkillCategory() {
            $('#hdnSC_UniqueIDTab').val(0);
            $('#txtSkillCategoryValue').val("");
            $('#txtDescription').val("");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $("#QListTbl_wrapper .dataTables_scrollBody, #SCListTbl_wrapper .paginate_button, #QListTbl_wrapper .custom_chckbox label, .addbtn, .backbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            $(".table").resize();
            $('#SCDetailsTab').click()
            $('#SCSkillsTab').addClass("DisableContent");
        }

        function editSkillCategory() {
            $('#tblSkillCategoryMain').on('click', '.BGdetalilink', function () {
                var $row = $(this).closest("tr");
                $tds = $row.find("td");
                var hdnCategoryId = $row.find('#hdn_Tools_CategoryID').val();
                $('#hdnSC_UniqueIDTab').val(hdnCategoryId);
                $.each($tds, function (index, obj) {
                    var hiddenField = $(this).find("input[type='hidden']").val();
                    if (hiddenField != 'undefined' && hiddenField != null) {
                        var eventId = hiddenField;
                        // $('#hdn_ParameterID').html(eventId);

                    }

                    if (index == 0) {
                        $('#txtSkillCategoryValue').val($(this).text().trim());

                    }
                    if (index == 1) {
                        $('#txtDescription').val($(this).text());
                    }
                    SCMatser.Tools_CategoryID = hdnCategoryId;
                    //$(".dataTables_scrollBody").css("height", "auto!important");
                    $(".Resourcedetailpanel").show();
                    $('html,body').animate({
                        scrollTop: $(".Resourcedetailpanel").offset().top - 60
                    }, 'slow');
                    //used for disable grid
                    $(".SCtblouter .dataTables_scrollBody, #QListTbl_wrapper .custom_chckbox label, #SCListTbl_wrapper .paginate_button, .addbtn, .backbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
                    $(".table").resize();
                });
            });
            $('#SCDetailsTab').click()
            $('#SCSkillsTab').removeClass("DisableContent");
        }
        //$(".BGdetalilink").click(function () {
        //    $(this).closest('tr').addClass('rowhiglight');
        //});


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $(".SCtblouter, .dataTables_scrollBody,.addbtn, #SCListTbl_wrapper .paginate_button, .backbtn, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();
            CurrentTabObject = { Details: 'false', Skills: 'false' }
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
        var skillCategoryTable;
        var skillTable;
        var showMessage = "Please select at least one record";
        var CurrentTabObject = { Details: 'false', Skills: 'false' };
        var SCMatser = {
            Tools_CategoryID: "",
            CategoryName: "",
            Description: "",
            CreatedBy: "",
            ModifiedBy: ""
        };
        $(document).ready(function () {
            CurrentTabObject = { Details: 'false', Skills: 'false' };
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (blnAddAccess == "False") {
                $("#btnAddSC").addClass("clsShowHide");
                $('#btnSaveSCDetails').attr("disabled", true);

            }
            else {
                $("#btnAddSC").removeClass("clsShowHide");
                $('#btnSaveSCDetails').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#DeleteSC").addClass("clsShowHide");
            }
            else {
                $("#DeleteSC").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {
                GetMaximumItemsToShowInList();
                GetMySCFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);
                    FilterApplied();

                } else {
                    GetSkillCategories(null);
                    FilterNotApplied();
                }
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
        });

        //datatable
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            skillCategoryTable = $('#SCListTbl').dataTable({
                "dtat": data,
                //"sScrollY": (0.5 * $(window).height()),
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
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [2] }]// Added By Pradip on 20 July 2021
            });
        }

        function LoadPaginationforSkils(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            skillTable = $('#selectskillTbl').dataTable({
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
                //Added by imran on 19-08-2022
                pageLength: 10,
                //End of comment by imran on 19-08-2022
            });
        }

        //    "sScrollY":  ( 0.6 * $(window).height() ),
        //"bPaginate": false,
        //"bJQueryUI": true,
        //"bScrollCollapse": true,
        //"bAutoWidth": true,
        //"sScrollX": "100%",
        //"sScrollXInner": "100%"


        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);
        $('#SCListTbl').DataTable().columns.adjust().draw();

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
            $('.SCtblouter .dataTables_scrollBody').css({ 'height': tblheight - 120, "overflow-y": "auto" });

            //var tblheight = $(window).height();
            //$('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }

        function resizeSection() {
            var tblheight = $(window).height();
            $('#SCListTbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 200, "overflow-y": "auto" });

            var tblheight2 = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight2 - 90 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });
        //Added By Madhuri.K on 20 Aug 2024 For To Adjust Column of datatable
        $('#SCListTbl').DataTable().columns.adjust().draw();

        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });
        /*Added By Madhuri.K On 04-Sep-2024 for clearAll function comment start here*/
        function closeFilterPanel() {
            $("#filterpanel").removeClass('show');
        }
        /*Added By Madhuri.K On 04-Sep-2024 for clearAll function comment end here*/
        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var allPages = skillCategoryTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#SCListTbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedSCID.push(parseInt($(rows[i]).find("#hdn_Tools_CategoryID").val()));
                    }

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedSCID = [];
                }
            }
        });

        //// Changing state of CheckAll checkbox
        //$(".chcktbl").click(function () {

        //    if ($(".chcktbl").length == $(".chcktbl:checked").length) {
        //        $(".chckHead").prop("checked", true);
        //    } else {
        //        $(".chckHead").removeAttr("checked");
        //    }

        //});

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
                        // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue //console.log(thrownError);
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
        function onClose() {
            $('#hdnSC_UniqueIDTab').val(0);
            $('#txtSkillCategoryValue').val("");
            $('#txtDescription').val("");
        }
        var SelectedSCID = [];
        function GetSelectedSkillCategory(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedSCID.push(parseInt(row.find('#hdn_Tools_CategoryID').val()));
            }
            else {
                if (SelectedSCID != 'undefined' && SelectedSCID.length > 0) {
                    var removeEmp = row.find('#hdn_Tools_CategoryID').val();
                    SelectedSCID.remove(parseInt(removeEmp));
                }
            }

        }
        var SelectedSkillID = [];
        function GetSelectedSkillID(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedSkillID.push(parseInt(row.find('#hdn_ToolID').val()));
            }
            else {
                if (SelectedSkillID != 'undefined' && SelectedSkillID.length > 0) {
                    var removeEmp = row.find('#hdn_ToolID').val();
                    SelectedSkillID.remove(parseInt(removeEmp));
                }
            }
        }

        $(".chckHead1").change(function () {
            ChkSelectedSkill = []//Added By Dipali V On 14th April 2023 For Skill Category Saving Issue
            var allPages = skillTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#selectskillTbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedSkillID.push(parseInt($(rows[i]).find("#hdn_ToolID").val()));
                    }
                
                    $('#tblSkillTab input[Class=chcktbl1]:checked').map(function () {
                        ChkSelectedSkill.push(this.value);//Added By Dipali V On 14th April 2023 For Skill Category Saving Issue
                    }).get().join();
                   // alert(ChkSelectedSkill.toString());

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedSkillID = [];
                    ChkSelectedSkill = [];//Added By Dipali V On 14th April 2023 For Skill Category Saving Issue
                   
                }
            }
        });

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
            if (skillCategoryTable.$('input:checked').length == skillCategoryTable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").prop("checked", false);
            }
        }
        function checkUncheckforSkill() {

            if (skillTable.$('input:checked').length == skillTable.fnGetNodes().length) {
                $(".chckHead1").prop("checked", true);
            } else {
                $(".chckHead1").prop("checked", false);
            }
            ChkSelectedSkill = []//Added By Dipali V On 14th April 2023 For Skill Category Saving Issue
          
            $('#tblSkillTab input[Class=chcktbl1]:checked').map(function () {
                ChkSelectedSkill.push(this.value);
            }).get().join();//Added By Dipali V On 14th April 2023 For Skill Category Saving Issue
            
           
        }

        function GetSkillCategories(SCFilterParms) {
            //Added by imran on 19-08-2022
            if (SCFilterParms == null || SCFilterParms == "null" || SCFilterParms == "") {
                var SCFilterParms =
                {
                    SCWhereClause: ""
                }
            }
            //End of comment by imran on 19-08-2022
            SelectedSCID = [];
            var strHTML = "";
            StartLoader("#body-SkillCategory");
            $.ajax({
                url: strUrl + '/api/RM_SkillCategory/GetSkillCategorys',
                type: "POST",
                data: JSON.stringify(SCFilterParms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (SCFilterParms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(SCFilterParms) ? SCFilterParms : JSON.stringify(SCFilterParms)));
                    }
                },
                success: function (data) {
                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            if (blnEditAccess == "True") {
                                strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_Tools_CategoryID" id="hdn_Tools_CategoryID" value= ' + obj.Tools_CategoryID + '><a href="javascript:;" class="BGdetalilink" onclick="editSkillCategory()"</a>' + obj.CategoryName + '</td><td class="text-start wrapword">' + obj.Description + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedSkillCategory(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                            }
                            else {
                                strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_Tools_CategoryID" id="hdn_Tools_CategoryID" value= ' + obj.Tools_CategoryID + '>' + obj.CategoryName + '</td><td class="text-start wrapword">' + obj.Description + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedSkillCategory(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                            }

                        });
                    }

                    $('#SCListTbl').dataTable().fnDestroy();
                    $("#tblSkillCategoryMain").html(strHTML);
                    LoadPagination(data);
                    StopAjaxLoader("#body-SkillCategory");
                    //$(".chckHead").prop("checked", false);
                    checkUncheck();
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-SkillCategory");
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
		//End of Added By Riddhesh Patil

        function checkValidation() {
            if ($("#txtSkillCategoryValue").val().trim() == undefined || $("#txtSkillCategoryValue").val().trim() == "" || $("#txtSkillCategoryValue").val().trim() == null) {
                $("#txtSkillCategoryValue").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter Skill Category Value");
                return false;
            }
            //Comment and Added By Riddhesh Patil on 07-NOV-2022
            //else if ($("#txtSkillCategoryValue").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtSkillCategoryValue").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Skill Category Value cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
             
            else if (checkSpecialCharacter($("#txtSkillCategoryValue").val().trim(), WebConfigSpecialCharacters) == true) {

                //Added by Aditya J. on 08-11-2024
                validateflag = false;
                //End of Added by Aditya J. on 08-11-2024

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Skill Category Value should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtSkillCategoryValue").focus();
                return false;
            }
            else if (checkSpecialCharacter($("#txtDescription").val().trim(), WebConfigSpecialCharacters) == true) {

                //Added by Aditya J. on 08-11-2024
                validateflag = false;
                //End of Added by Aditya J. on 08-11-2024

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtDescription").focus();
                return false;
            }
			//End of Comment and Added By Riddhesh Patil

            //else if ($("#txtDescription").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtDescription").focus();
            //    validateflag = false;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Description cannot contain any of these /\:*?<>|,"+- characters.');
            //    return false;
            //}
            else {
                validateflag = true;
                return true;
            }
        }
        var validateflag;
        function SaveSkillCateroryDetails(isFromSaveAndclick) {
            checkValidation();
            if (validateflag == true) {
                var categoryId = $("#hdnSC_UniqueIDTab").val();
                var categoryValue = $("#txtSkillCategoryValue ").val().replace(/'/g, "''");
                var description = $("#txtDescription ").val().replace(/'/g, "''");

                var Details = {
                    Tools_CategoryID: categoryId > 0 ? categoryId : 0,
                    CategoryName: categoryValue,
                    Description: description,
                    CreatedBy: encodeURI(UserName)

                };
                $.ajax({
                    url: strUrl + '/api/RM_SkillCategory/SaveSkillCategory',
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
                        GetSkillCategories();

                        if (isFromSaveAndclick == 0) {
                            //console.log(data);
                            if (data == "Skill Category already exist.") {
                                $(".SCtblouter,.backbtn,.addbtn,.deletebtn,.filter,.mainclearalllink").addClass("DisableContent");

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                //onClose();
                                $(".SCtblouter,.backbtn,.addbtn,.deletebtn,.filter,.mainclearalllink").removeClass("DisableContent");

                                $(".Resourcedetailpanel").hide();
                                $('#Resourcedetailpanel').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                $(".chckHead").prop("checked", false); //Added By RehanC for DeleteAll checkbox getting checked issue on 30th Mar 2023
                            }
                        }
                        else {
                            if (data == "Skill Category already exist.") {
                                $(".SCtblouter,.backbtn,.addbtn,.deletebtn,.filter,.mainclearalllink").addClass("DisableContent");

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                onClose();
                                $(".SCtblouter,.backbtn,.addbtn,.deletebtn,.filter,.mainclearalllink").addClass("DisableContent");
                                $("#txtSkillCategoryValue").focus();
                                $("#hdnSC_UniqueIDTab").val(0);
                                //$(".Resourcedetailpanel").hide();
                                $('#Resourcedetailpanel').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                $(".chckHead").prop("checked", false); //Added By RehanC for DeleteAll checkbox getting checked issue on 30th Mar 2023
                            }
                            $('#SCSkillsTab').addClass("DisableContent");
                        }

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
                            //CurrentGRPTabObject.GrpManager = 'false';
                            GetSkillCategories();
                            // CurrentGRPTabObject.GrpManager = 'true';
                            StopAjaxLoader("#body-SkillCategory");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        StopAjaxLoader("#body-SkillCategory");
                        //if (isFromSaveAndclick == 0) {
                        //    $('#Resourcedetailpanel').modal('hide');
                        //}
                    }
                })
            } else {
                return false;
            }
        }

        function DeleteSCDetailsAfterConfirm() {
            var strHTML = "";
            var selectedScategoryID = SelectedSCID.toString();
            if (selectedScategoryID.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_SkillCategory/DeleteSkillCategory',
                    type: "POST",
                    data: JSON.stringify(selectedScategoryID),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#body-SkillCategory");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedScategoryID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedScategoryID) ? selectedScategoryID : JSON.stringify(selectedScategoryID)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //}

                        StopAjaxLoader("#body-SkillCategory");
                        GetSkillCategories();
                         //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        //strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                         //End of Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterow').html(strHTML);
                        $('#DeleteConfirmMModal').modal('show');
                        $(".chckHead").prop("checked", false); //Added By RehanC for DeleteAll checkbox getting checked issue on 30th Mar 2023
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
                            GetSkillCategories();
                            $('#DeleteConfirmMModal').modal('hide');
                            //alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify("Deleted");
                        }

                        StopAjaxLoader("#body-SkillCategory");
                        $('#DeleteConfirmMModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedSCID = [];
            selectedScategoryID = "";
        }

        function ShowSkills() {
            if (CurrentTabObject != null && CurrentTabObject.Skills == "false") {
                var ID = SCMatser.Tools_CategoryID;
                GetSkills(ID);
                CurrentTabObject.Skills = 'true';
            }
        }
        var AllSkill = [];//Added By Dipali V On 14th April 2023 For Skill Category Saving Issue
        var ChkSelectedSkill = [];//Added By Dipali V On 14th April 2023 For Skill Category Saving Issue
        function GetSkills(ID) {
            var strHTML = "";
            CurrentTabObject.Skills = 'true';
            SelectedSkillID = [];
            // var SCParameter = { Tools_CategoryID: ID };
            StartLoader("#body-SkillCategory");
            $.ajax({
                url: strUrl + '/api/RM_SkillCategory/GetSkillS',
                type: "POST",
                data: JSON.stringify(ID),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (ID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ID) ? ID : JSON.stringify(ID)));
                    }
                },
                success: function (data) {
                    var List = data;
                    if (List.length > 0) {
                        $.each(List, function (index, obj) {
                            if (obj.SelCheckBox == true) {
                                strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_ToolID" id="hdn_ToolID" value= ' + obj.ToolID + '>' + obj.Description + '</td><td><div class="custom_chckbox"><input id="chkskills_' + index + '" value= ' + obj.ToolID + ' onclick="checkUncheckforSkill();GetSelectedSkillID(this);" class="chcktbl1" type="checkbox" checked><label for="chkskills_' + index + '"></label></div></td></tr>';
                            }
                            else {
                                strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_ToolID" id="hdn_ToolID" value= ' + obj.ToolID + '>' + obj.Description + '</td><td><div class="custom_chckbox"><input id="chkskills_' + index + '" value= ' + obj.ToolID + ' onclick="checkUncheckforSkill();GetSelectedSkillID(this);" class="chcktbl1" type="checkbox"><label for="chkskills_' + index + '"></label></div></td></tr>';

                            }
                        });
                    }

                    $('#selectskillTbl').dataTable().fnDestroy();
                    $("#tblSkillTab").html(strHTML);
                    LoadPaginationforSkils(data);
                    StopAjaxLoader("#body-SkillCategory");
                    //$(".chckHead1").prop("checked", false);
                    checkUncheckforSkill();
                    
                    $('#tblSkillTab input[Class=chcktbl1]').map(function () {
                        AllSkill.push(this.value);
                    }).get().join();
                 
                   
                  
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#body-SkillCategory");
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

        function saveSelectedSkills() {
            var saveParameters = { ToolID: "", Tools_CategoryID: "", Description: "", SelCheckBox: "", AllToolID: "" };
            //var isSelected = SelectedSkillID.toString();
            var isSelected = ChkSelectedSkill.toString();//Added By Dipali V On 14th April 2023 For Skill Category Saving Issue
            // if (isSelected.length > 0) {
            saveParameters.Tools_CategoryID = SCMatser.Tools_CategoryID;
            saveParameters.ToolID = isSelected;
            saveParameters.AllToolID = AllSkill.toString();//Added By Dipali V On 14th April 2023 For Skill Category Saving Issue
            StartLoader("#body-SkillCategory");
            $.ajax({
                url: strUrl + '/api/RM_SkillCategory/UpdateSkillWithCategory',
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
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success(data);
                    ShowSkills();
                    //onClose();
                    //if (isFromSaveClick == 0) {
                    //$("#AddRESMModal").modal('hide');
                    //}
                    StopAjaxLoader("#body-SkillCategory");
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
                        StopAjaxLoader("#body-SkillCategory");
                    }
                }
            });

            //} else {
            //   alertify.set('notifier', 'position', 'top-right');
            //   alertify.error(showMessage);
            //  return false;
            // }
            SelectedSkillID = [];
            isSelected = "";
        }

        $('#txtSCFilterCategoryName').bind('copy paste', function (e) {
            e.preventDefault();
        });
        $('#txtSCFilterDescription').bind('copy paste', function (e) {
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
        //FILTER SECTION
        function ApplyFilter() {
            var filterFlag = true;
            var Category = $("#txtSCFilterCategoryName").val() == "" ? null : $("#txtSCFilterCategoryName").val();
            var Desc = $("#txtSCFilterDescription").val() == "" ? null : $("#txtSCFilterDescription").val();
            if ((Category == null || Category == 'undefined' || Category == ' ') && (Desc == null || Desc == 'undefined' || Desc == ' ')) {
                alertify.set('notifier', 'position', 'top-right');
                //Added By Reshma chavan on 29th Nov 2021 for disapper alert
                //alertify.error('Apply filter on at least one field');
                setTimeout(function () { alertify.error('Apply filter on at least one field'); }, 2000);
                //End of Added By Reshma chavan on 29th Nov 2021 for disapper alert
                filterFlag = false;
                return false;
            }

            if (filterFlag == true) {
                currentFilterID = 0;
                var filter = "";
                var AllSCFilter = ["CategoryName", "Description"];
                var filterWhereClause2 = GenerateSCBasicFilterQuery("SC", AllSCFilter);
                //filterWhereClause = filterWhereClause2.replace(/"/g, "\''");
                filterWhereClause = filterWhereClause2.replace(/"/g, "\'");
                filter = { UniqueID: '0', SCWhereClause: encodeURIComponent(filterWhereClause) }
                FilterApplied();
                GetSkillCategories(filter);
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

            if (arrFields[0] == "CategoryName") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboSCFilterCategoryName", "txtSCFilterCategoryName");
            }
            if (arrFields[0] == "Description") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboSCFilterDescription", "txtSCFilterDescription");

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
                $('#txtSCFilterName').val("");
            }
        }
        function ClearFilterDetails(flag) {
            if ($("#txtSCFilterCategoryName").val() != "") {
                $("#txtSCFilterCategoryName").val("");
            }
            if ($("#cboSCFilterCategoryName").val() != "Contains") {
                setFilterComboValue("cboSCFilterCategoryName", "Contains");
            }
            $("#txtSCFilterName").val("");

            if ($("#txtSCFilterDescription").val() != "") {
                $("#txtSCFilterDescription").val("");
            }
            if ($("#cboSCFilterDescription").val() != "Contains") {
                setFilterComboValue("cboSCFilterDescription", "Contains");
            }


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
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
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
            GetSCDetails(null);
            GetMySCFilter(0);
        });

        function GetSCDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                //var whereClauseFormated = whereClause.replace(/'/g, "\''");
                filter = { UniqueID: '0', SCWhereClause: encodeURIComponent(whereClause) };
            }

            GetSkillCategories(filter);
        }
        //filter validation
        function checkFiltervalidationForSC() {
            var Category = $("#txtSCFilterCategoryName").val() == "" ? null : $("#txtSCFilterCategoryName").val();
            var Desc = $("#txtSCFilterDescription").val() == "" ? null : $("#txtSCFilterDescription").val();
            if ((Category == null || Category == 'undefined' || Category == ' ') && (Desc == null || Desc == 'undefined' || Desc == ' ')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                $('#SCsavefilter').modal('hide');
            }

            else {
                //alert("SHOW");
                $('#SCsavefilter').modal('show');
            }
        }
        function AvoidSpace(input) {
            if (/^\s/.test(input.value))
                input.value = '';
        }
        function SaveSCFilterDetails() {
            var fltFilterName = $("#txtSCFilterName").val();
            if (fltFilterName == "" || fltFilterName == " ") {
                $("#savefilterbtn").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name');

                $("#txtSCFilterName").focus();

            }
            //Commnet and Added By Riddhesh Patil on 12-NOV-2022 
            //else if (fltFilterName.trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#savefilterbtn").removeAttr("data-bs-dismiss");
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Filter name cannot contain any of these /\:*?<>|,"+- characters.');

            //    $("#txtSCFilterName").focus();
            //}
            else if (checkSpecialCharacter(fltFilterName.trim(), WebConfigSpecialCharacters) == true) {
                $("#savefilterbtn").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtSCFilterName").focus();

            }
			//End of Comment Added By Riddhesh Patil
            else {
                var filterExists = 0;
                var AllSCFilter = ["CategoryName", "Description"];
                var filterWhereClause;
                var filterWhereClause2 = GenerateSCBasicFilterQuery("SC", AllSCFilter);
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
                            $('#SCsavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            ApplyFilter();
                            FilterApplied();
                            GetMySCFilter(0);
                            savedFilterName = fltFilterName;
                            $("#txtSCFilterName").val("");
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
        function GetMySCFilter(flag) {
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
                                strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3)></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                            }
                            else {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
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
                        //Added by dipali V On 30th March 2023 For Filter Issue

                        $("#MyFiltersdropdown").removeClass("show");
                        //End of comment by dipali V On 30th March 2023 For Filter Issue
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


        function ExistSCFilter(filtername) {

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
                    if (ajaxOptions == "error") {
                        isFilterExists = 1;
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
                            GetSkillCategories();
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMySCFilter(0);
                        currentappliedfilter = 0;
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
                        $("#txtSCFilterName").val(currentFilterName);
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
        function ApplySavedFilter(FilterID, isDefault,isFromDefault) {
            //Changed  by mahesh on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {
                GetSkillCategories();
                GetMySCFilter(isDefault);
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
                            GetSCDetails(Querytext);
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
                            GetMySCFilter(0);

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
                    GetMySCFilter(0);
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
        function GenerateSCBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();

                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();
                    //if ($('#txtSCFilterSkillCategory').val() == "" || $('#txtSCFilterSkillCategory').val() == undefined) {
                    //    var strDesc = null;
                    //}
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
                                strqtext += strOp + " ''" + strvalue + "''";
                            }
                            else {
                                strqtext += strOp + " " + strvalue + "";
                                // strqtext += strOp + ' "' + strvalue + '"';
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


    </script>

</body>

</html>
