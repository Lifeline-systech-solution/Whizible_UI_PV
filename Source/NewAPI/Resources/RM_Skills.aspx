<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_Skills.aspx.vb" Inherits="PbNIT.RM_Skills" %>

<!DOCTYPE html>
<html>
       <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%>
<head runat="server">
  <%--  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!--  Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
   --%> <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
  --%>  <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link href="../../../Whizible2.0-new/dist/css/BS5_migration.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

   

</head>
     <style type="text/css">
        .btnrow {
            margin-top: 20px;
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

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

 

        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999 !important;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            /*word-break: break-all;*/
            /*height:auto!important;*/
        }

        #pgskilltbl_wrapper .dataTables_paginate {
            margin-top: 20px;
        }

        #pgskilltbl_wrapper table {
            width: 100% !important;
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

        .filter button[aria-expanded="true"] {
            background: NONE;
            color: #4263c1;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }
		
.form-group small{ line-height:normal; display:block; margin-top:5px;}	
.pagination {margin-bottom: 0px!important;}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodySkill">

    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-1 text-end graybg">
            <h5 class="pgtitle float-start">Resource Skills</h5>

           <%-- <a href="javascript:;" class="btn borderbtn backbtn" data-bs-toggle="modal" data-bs-target="#AddSkillModal" data-bs-placement="bottom" title="Add Resource Skill" id="AddSkill"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
            <a href="javascript:;" class="btn borderbtn" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete" onclick="DeleteSkillAfterConfirm()" id="DeleteSkill">Delete</a>--%>

                <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Back to Resource Configuration">Back</a>--%>
                <%--End of Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
            <a href="javascript:;" class="mainclearalllink" style="" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
			 
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
                            <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">My Filters </a>
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
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="checkFiltervalidationForSkills();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFlter()">Apply</button>
                                </div>
                                <br />



                                <div class="form-group mb-3">
                                    <div class="row">
 <div class="col-sm-4">
                                        <label>Skills</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboSklFilterDescription">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">End With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Start With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtSklFilterDescription", "txtSklFilterDescription", "form-control",,,,,, ,,,, "  ",, ,,,,, True) %>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <label>Required for Metrics Calculation</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboSklFilterRequiredForMatricCalc">
                                                    <option value="=">=</option>
                                                    <option value="<>"><></option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                <div class="custom_chckbox">
                                                    <%-- <%CommonFunctions.HTMLControls.DrawCheckBox("chkBgFilterIsActive", "chkBgFilterIsActive", "custom_chckbox clsCheckBox", False, , , "style='width: 30px;height:15px;'", , , , , , )%>--%>
                                                    <%--Commented & Added By Rutuja D.--%>
                                                    <%--<%CommonFunctions.HTMLControls.DrawCheckBox("chkSklFilterRequiredForMatricCalc", "chkSklFilterRequiredForMatricCalc", "custom_chckbox clsCheckBox", False, , , "style='width: 30px;height:15px;'", , , , , , )%>--%>
                                                    <%--<label for="chkSklFilterRequiredForMatricCalc"></label>--%>
                                                 <% CommonFunctions.HTMLControls.DrawComboBox("txtSklFilterRequiredForMatricCalc", "usp_Whizible2_IsComfirmed",,, "class='form-select' ",,,, ,) %>
                                                    <%--End of Commented & Added By Rutuja D.--%>
                                            
                                                
                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <label>Skill Category</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboSklFilterTools_CategoryID">
                                                    <option value="=">=</option>
                                                    <option value="<>"><></option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                <%--<select class="form-control input-sm">
                                                    <option>Development</option>
                                                    <option>Office Tool</option>
                                                    <option>Soft Skills</option>
                                                    <option>Testing</option>
                                                </select>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtSklFilterTools_CategoryID", "usp_Whizible2_sel_tbl_PM_Tools_Category_CategoryName",,, "class='form-select' ",,,, ,) %>
                                            </div>

                                        </div>
                                    </div>

                                    </div>
                                   
                                </div>

                                <div class="form-group mb-3">
                                    <div class="row">
                                        <div class="col-sm-4">
                                        <label>Resource Request Validity Days</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-select input-sm" id="cboSklFilterConfiguredDays">
                                                    <option value="=">=</option>
                                                    <option value="<>"><></option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtConfigureDays", "idtxtConfigureDays", cssClass:="form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)'")%><small>After validity, the assigned request will no longer be valid for allocation.</small>--%>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtSklFilterConfiguredDays", "txtSklFilterConfiguredDays", "form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onkeypress='return Field_OnKeyPressCheck(event)'") %>
                                            </div>

                                        </div>
                                        <small>After validity, the assigned request will no longer be valid for allocation.</small>
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

        <%-- filter model for save--%>
        <div class="modal custmodal SklSavefilter_filter fade" id="SklSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
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
                                            <%--<label class="control-label col-md-4 p-0 text-end">Filter Name:</label>--%>
                                            <label class="control-label col-md-4 p-0 text-end">Filter Name <span style="color:red"> * </span> :</label>
                                            <span class="col-md-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtSklFilterName", "txtSklFilterName", "form-control",, maxLength:=100) %>
                                                <div class="btnrow">
                                                    <button class="btn btnyellow float-start savefilter" id="btnSaveFilter" onclick="SaveSklFilterDetails()">Save</button>
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
        <!--end save filter-->

        <!--end filter panel-->

        <%--Added by imran on 18-08-2022--%>
        <div class="container-fluid pt-1 pb-1 text-end">
            <a href="javascript:;" class="btn borderbtn backbtn" data-bs-toggle="modal" data-bs-target="#AddSkillModal" data-bs-placement="bottom" title="Add Resource Skill" id="AddSkill"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
            <a href="javascript:;" class="btn borderbtn" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete" onclick="DeleteSkillAfterConfirm()" id="DeleteSkill">Delete</a>
        </div>
        <%--End of Comment by imran on 18-08-2022--%>

        <div class="content pt-1 pb-0">
            <table class="table table-bordered" style="width: 100%;" id="tblSkill">
                <thead>
                    <tr>
                        <th class="text-left">Skills</th>
                        <th class="text-center" width="220">Resource Request Validity Days</th>
                        <th class="text-center" width="150">Skill Category</th>
                        <th width="50" class="text-center">
                            <div class="custom_chckbox">
                                <input id="RsrsSkillListcheck0" class="chckHead" type="checkbox">
                                <label for="RsrsSkillListcheck0"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="tblSkills">
                </tbody>
            </table>
        </div>

        <div class="clearfix"></div>
    </div>


    <!-- ./wrapper -->
    <!--add modal start here-->
    <div class="modal custmodal fade" id="AddSkillModal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Add Skill</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="Close();">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group mb-3">
                        <div class="row">
                            <div class="col-sm-6">
                            <label class="required">Skill</label>
                            <!-- <input type="text" class="form-control" />-->
                            <%CommonFunctions.HTMLControls.DrawTextBox("txtSkill", "idtxtSkill", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                        </div>
                        <div class="col-sm-6">
                            <label class="">&nbsp;</label>
                            <div class="custom_chckbox">
                                <input type="checkbox" id="idchkReqMCalc">
                                <label for="idchkReqMCalc">Required for Metrics Calculation</label>
                                <%-- <% CommonFunctions.HTMLControls.DrawCheckBox("chkReqMCalc", "idchkReqMCalc", "class='clsCheckBox'", True, "", True)  %>--%>
                            </div>
                        </div>
                        </div>                        
                    </div>

                    <div class="form-group mb-3">
                        <div class="row">
                        <div class="col-sm-6">
                            <label class="required">Resource Request Validity Days</label>
                            <%CommonFunctions.HTMLControls.DrawTextBox("txtConfigureDays", "idtxtConfigureDays", cssClass:="form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)'")%><small>After validity, the assigned request will no longer be valid for allocation.</small>
                        </div>
                        <div class="col-sm-6" id="idCboSkill">
                            <label>Skill Category</label>
                            <% CommonFunctions.HTMLControls.DrawComboBox("CboSkills", "usp_Whizible2_sel_tbl_PM_Tools_Category_CategoryName",,, "class='form-select'", True,,) %>
                            <%-- <% CommonFunctions.HTMLControls.DrawComboBox("CboSkills", "usp_Sel_tbl_PM_Employee_High_Medium",,, "class='form-control' ", True,,) %>--%>
                        </div>
                        </div>
                        
                    </div>

                    <br />
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal" onclick="Close()">Close</button>
                        <button class="btn btnyellow" onclick="SaveParameters(0)">Save</button>
                        <button class="btn btnyellow" onclick="SaveParameters(1)">Save And Add</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Add modal end here-->

    <!--Edit modal start here-->
    <div class="modal custmodal fade" id="EditSkillModal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Edit Skill</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group mb-3">
                        <div class="row">
                        <div class="col-sm-6">
                            <%-- <span style="display: none;" id="hdnToolId"></span>--%>
                            <input type="hidden" name="hdnToolId" id="hdnToolId" />
                            <label class="required">Skill</label>
                            <%-- <input type="text" class="form-control" id="idtxtskill" />--%>
                            <%CommonFunctions.HTMLControls.DrawTextBox("txtSkill", "idtxtskill", cssClass:="form-control", widthInPixel:=0, maxLength:=50)%>
                        </div>
                        <div class="col-sm-6">
                            <label class="">&nbsp;</label>
                            <div class="custom_chckbox">
                                <input id="idEditchkReqMCalc" type="checkbox">
                                <label for="idEditchkReqMCalc">Required for Metrics Calculation</label>
                            </div>
                        </div>
                        </div>
                        
                    </div>

                    <div class="form-group mb-3">
                        <div class="row">
                        <div class="col-sm-6">
                            <label class="required">Resource Request Validity Days</label>
                            <%CommonFunctions.HTMLControls.DrawTextBox("txtConfigureDays", "idtxtconfigrays", cssClass:="form-control", widthInPixel:=0, maxLength:=5, ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)'")%><small>After validity, the assigned request will no longer be valid for allocation.</small>
                        </div>
                        <div class="col-sm-6">
                            <label>Skill Category</label>
                            <% CommonFunctions.HTMLControls.DrawComboBox("CboEditSkills", "usp_Whizible2_sel_tbl_PM_Tools_Category_CategoryName",,, "class='form-select'", True,,) %>
                            <%-- <% CommonFunctions.HTMLControls.DrawComboBox("CboEditSkills", "usp_Whizible2_sel_tbl_PM_Tools_Category_CategoryName",,, "class='form-control selectpicker'",,,) %>--%>
                        </div>
                        </div>
                        
                    </div>

                    <br />
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        <button class="btn btnyellow" onclick="saveEditParameters(0)">Save</button>
                        <button class="btn btnyellow" id="btnsaveEditParameters" onclick="saveEditParameters(1)">Save And Add</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Edit modal end here-->

    <%--Delete confirmation model--%>
    <div class="modal custmodal fade" id="DeleteConfirmSkillMModal" aria-hidden="true" data-bs-dismiss="modal">
        <div class="modal-dialog modalsmall ui-draggable" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Status</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="notebox">
                        <strong>Note:</strong>  Skill which is in use cannot be deleted.<br />
                        <p id="showdeleterow"></p>
                    </div>
                    <%--<div class="form-group row">
                        Are you sure, you want to delete the selected records?
                    </div>--%>

                    <div class="text-end">
                        <%--                        <button class="btn btnyellow" onclick="DeleteSkillAfterConfirm()">Yes</button>--%>
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
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
 <%--   <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>  --%> 
   <%-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/datatables/dataTables.bootstrap.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script> 
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>
   

    <script>
        //Added By Riddhesh Patil on 07-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of  Added By Riddhesh Patil
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();
        var strUrl = '';
        var DeleteRecord = "Please select at least one record to delete.";
        var skilltable;
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

            if (blnViewAccess == "True") {
                GetGetMaximumItemsToShowInList();
                GetMyFilter(0);
                //Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
                BindPlaceholder("txtSklFilterRequiredForMatricCalc", "Required for Metrics Calculation");
                BindPlaceholder("txtSklFilterTools_CategoryID", "Skill Category");
                //End of Added By Rutuja D. For Bind Filter Placeholder on 14 July 2021
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

        //Aceess permissions
       <%-- var SessionLoginType = '<%= Session("LoginType") %>';
        alert(SessionLoginType);--%>
        var noOfRowsPerPage = 10;
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';

        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var TagID = '<%= m_TagId%>';
        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';

        if (blnAddAccess == "False") {
            $("#AddSkill").addClass("clsShowHide");
            $('#btnsaveEditParameters').attr("disabled", true);

        }
        else {
            $("#AddSkill").removeClass("clsShowHide");
            $('#btnsaveEditParameters').attr("disabled", false);
        }
        if (blnDeleteAccess == "False") {
            $("#DeleteSkill").addClass("clsShowHide");
        }
        else {
            $("#DeleteSkill").removeClass("clsShowHide");
        }


        var skill = {
            ToolID: "",
            Description: "",
            ConfiguredDays: "",
            Tools_CategoryID: "",
            RequiredForMatricCalc: "",
            CreatedBy: "",
            ModifiedBy: ""
        };
        function editSkill() {
            $('#tblSkills').on('click', '.BGdetalilink', function () {
                var $row = $(this).closest("tr");
                $tds = $row.find("td");
                var chkReqMatrix = $row.find('#hdn_ReqMatrix').val();
                var hdnToolCatId = $row.find('#hdn_ToolsCategory').val();
                var hdnToolId = $row.find('#hdnSkill_ToolID').val();
                $.each($tds, function (index, obj) {
                    //var hiddenField = $(this).find("input[type='hidden']").val();
                    //if (hiddenField != 'undefined' && hiddenField != null) {
                    //    var eventId = hiddenField;
                    //    $('#hdnToolId').html(eventId);

                    //}
                    if (hdnToolCatId != 'undefined' && hdnToolCatId != null) {
                        $("#CboEditSkills").val(hdnToolCatId);
                    }
                    if (index == 0) {
                        $('#idtxtskill').val($(this).text().trim());

                    }
                    if (index == 1) {
                        $('#idtxtconfigrays').val($(this).text().trim());
                    }
                    if (chkReqMatrix == 'true') {
                        $('[id="idEditchkReqMCalc"]').prop("checked", true);
                    }
                    else {
                        $('[id="idEditchkReqMCalc"]').prop("checked", false);
                    }
                    $('#hdnToolId').val(hdnToolId);
                    $('#EditSkillModal').modal('show');

                });
            });
        }
        function Close() {
            document.getElementById('CboEditSkills').value = "";
            document.getElementById('CboSkills').value = "";
            document.getElementById('idtxtSkill').value = "";
            document.getElementById('idtxtskill').value = "";
            document.getElementById('idtxtConfigureDays').value = "";
            $("#idchkReqMCalc").prop("checked", false);
            $("#idEditchkReqMCalc").prop("checked", false);
            document.getElementById('idtxtconfigrays').value = "";
        }

        //Added by Aditya J. on 08-11-2024
        $('#AddSkillModal').on('hidden.bs.modal', function () {
            Close();
        });
        //End of Added by Aditya J. on 08-11-2024

        //GETSkills
        function GetSkills(SklFilterParms) {
            //Added by imran on 19-08-2022
            if (SklFilterParms == null || SklFilterParms == "null" || SklFilterParms == "") {
                var SklFilterParms =
                {
                    SklWhereClause: ""
                }
            }
            //End of comment by imran on 19-08-2022
            SelectedEmpID = [];
            var strHTML = "";
            document.getElementById('idtxtSkill').value = "";
            document.getElementById('CboEditSkills').value = "";
            document.getElementById('CboSkills').value = "";
            document.getElementById('idtxtConfigureDays').value = "";
            $("#idchkReqMCalc").prop("checked", false);
            StartLoader("#bodySkill");
            $.ajax({
                url: strUrl + '/api/RM_Skill/GetSkills',
                type: "Post",
                data: JSON.stringify(SklFilterParms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));

                    if (SklFilterParms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(SklFilterParms) ? SklFilterParms : JSON.stringify(SklFilterParms)));
                    }
                },
                success: function (data) {
                    var MySkills = data;
                    $.each(MySkills, function (index, obj) {
                        if (blnEditAccess == "True") {
                            strHTML += '<tr><td class="text-left"><input type="hidden" name="hdnSkill_ToolID" id="hdnSkill_ToolID" value= ' + obj.ToolID + '><a href="javascript:;" class="BGdetalilink" onclick="editSkill(this)"</a>' + obj.Description + ' </td> <td class="text-center"> ' + obj.ConfiguredDays + ' </td><td class="text-center"> ' + obj.CategoryName + ' </td><td> <input onclick="checkUncheck();GetSelectedSkills(this);" type="checkbox" id="idchkdelete" class="text-center custom_chckbox chcktbl" style="width:18px; height:18px;margin-left:7px;"></td><input type="hidden" name="hdn_ReqMatrix" id="hdn_ReqMatrix" value= ' + obj.RequiredForMatricCalc + '> <input type="hidden" name="hdn_ToolsCategory" id="hdn_ToolsCategory" value=' + obj.Tools_CategoryID + '></tr > ';
                        }
                        else {
                            strHTML += '<tr><td class="text-left"><input type="hidden" name="hdnSkill_ToolID" id="hdnSkill_ToolID" value= ' + obj.ToolID + '>' + obj.Description + ' </td> <td class="text-center"> ' + obj.ConfiguredDays + ' </td><td class="text-center"> ' + obj.CategoryName + ' </td><td> <input onclick="checkUncheck();GetSelectedSkills(this);" type="checkbox" id="idchkdelete" class="text-center custom_chckbox chcktbl" style="width:18px; height:18px;margin-left:7px;"></td><input type="hidden" name="hdn_ReqMatrix" id="hdn_ReqMatrix" value= ' + obj.RequiredForMatricCalc + '> <input type="hidden" name="hdn_ToolsCategory" id="hdn_ToolsCategory" value=' + obj.Tools_CategoryID + '></tr > ';

                        }

                    });
                    $('#tblSkill').dataTable().fnDestroy();
                    $("#tblSkills").html(strHTML);
                    LoadPagination(data);
                    StopAjaxLoader("#bodySkill");
                    $(".chckHead").prop("checked", false);
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
                //error: function (err) {
                //    alertify.set('notifier', 'position', 'top-center');
                //    alertify.notify(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodySkill");
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodySkill");
                },
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue   
            })

        }

        //Validation
        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function Field_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    $("#idtxtConfigureDays").focus();
                    $("#idtxtconfigrays").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please enter only numeric values");
                }

            }
            return ret;
        }
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

        //disabled copy and paste
        $('#txtSklFilterConfiguredDays').bind('copy paste', function (e) {
            e.preventDefault();
        });

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
            if ($("#idtxtSkill").val().trim() == undefined || $("#idtxtSkill").val().trim() == "" || $("#idtxtSkill").val().trim() == null) {
                $("#idtxtSkill").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter skill");
                return false;
            }
            //Added By Riddhesh Patil on 07-NOV-2022 
            else if (checkSpecialCharacter($("#idtxtSkill").val().trim(), WebConfigSpecialCharacters) == true) {

                //Added by Aditya J. on 08-11-2024
                validateflag = false;
                //End of Added by Aditya J. on 08-11-2024

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Skill should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#idtxtSkill").focus();
               
                return false;
            }
			//End of  Added By Riddhesh Patil

            else if ($("#idtxtConfigureDays").val().trim() == undefined || $("#idtxtConfigureDays").val().trim() == "" || $("#idtxtConfigureDays").val().trim() == null) {
                $("#idtxtConfigureDays").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter resource request validity days.");
                return false;
            }
            else if ($("#idtxtConfigureDays").val().trim() != null && $("#idtxtConfigureDays").val().trim().match(/^(-?\d*)((\.(\d{0,2})?)?)$/i) == null) {
                $("#idtxtConfigureDays").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter only numeric values.");
                return false;
            }

            else {
                validateflag = true;
                return true;
            }
        }
        var validateflag
        function SaveParameters(isFromSaveAndclick) {
           
            checkValidation();
            if (validateflag == true) {
                if ($("#idchkReqMCalc").is(':checked')) {
                    skill.RequiredForMatricCalc = 1;
                } else {
                    skill.RequiredForMatricCalc = 0;
                }
                skill.ToolID = 0;
                //Commented By Dipali V On 23th Nov 2021 For Remove Space
                skill.Description = document.getElementById('idtxtSkill').value.replace(/'/g, "''").trim();
                // skill.Description = document.getElementById('idtxtSkill').value.replace(/'/g, "''")
                 //End of Commented By Dipali V On 23th Nov 2021 For Remove Space
                //alert(skill.Description);
                skill.ConfiguredDays = document.getElementById('idtxtConfigureDays').value;
                skill.Tools_CategoryID = document.getElementById('CboSkills').value;
                //Added by imran on 19-08-2022
                if (skill.Tools_CategoryID == "" || skill.Tools_CategoryID == null) {
                    skill.Tools_CategoryID = 0;
                }
               //End of comment by imran on 19-08-2022
                skill.CreatedBy = UserName;                
                $.ajax({
                    url: strUrl + '/api/RM_Skill/CreateSkills',
                    type: "POST",
                    data: JSON.stringify(skill),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (skill) {
                            xhr.setRequestHeader("Params", encryptString(isJson(skill) ? skill : JSON.stringify(skill)));
                        }
                    },
                    success: function (data) {
                        if (isFromSaveAndclick == 0) {
                            if (data == "Skill already exist.") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                $('#AddSkillModal').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                GetSkills();
                                Close();
                            }
                        }
                        else {
                            if (data == "Skill already exist.") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                $('#AddSkillModal').modal('show');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                GetSkills();
                                Close();
                            }
                        }

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                        //if (ajaxOptions == "error") {
                        //    console.log(thrownError);
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(xhr.responseJSON.Message);
                        //}
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                    }
                })
                // }
                //if (isFromSaveAndclick == 1) {
                //    document.getElementById('idtxtSkill').value = "";
                //    document.getElementById('idtxtConfigureDays').value = "";
                //    $("#idchkReqMCalc").prop("checked", false);
                //    document.getElementById('CboEditSkills').value = "";
                //    document.getElementById('CboSkills').value = "";
                //}
            }
            else {
                return false;
            }


        }

        function checkEditValidation() {
            if ($("#idtxtskill").val().trim() == undefined || $("#idtxtskill").val().trim() == "" || $("#idtxtskill").val().trim() == null) {
                $("#idtxtskill").focus();
                validateeditflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter skill");
                return false;
            }
            else if ($("#idtxtskill").val().trim().match(/[<>]/)) {
                // alert("sds");
                $("#idtxtskill").focus();
                validateeditflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Skill Should not contain '<' or '>' character.");
                return false;
            }
            else if ($("#idtxtconfigrays").val().trim() == undefined || $("#idtxtconfigrays").val().trim() == "" || $("#idtxtconfigrays").val().trim() == null) {
                $("#idtxtconfigrays").focus();
                validateeditflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter resource request validity days");
                return false;
            }
            else if ($("#idtxtconfigrays").val().trim() != null && $("#idtxtconfigrays").val().trim().match(/^(-?\d*)((\.(\d{0,2})?)?)$/i) == null) {
                $("#idtxtconfigrays").focus();
                validateeditflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please enter only numeric values.");
                return false;
            }
            else if (checkSpecialCharacter($("#idtxtskill").val().trim(), WebConfigSpecialCharacters) == true) {

                //Added by Aditya J. on 08-11-2024
                validateeditflag = false;
                //End of Added by Aditya J. on 08-11-2024

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Skill should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#idtxtskill").focus();

            }
            else {
                validateeditflag = true;
                return true;
            }
        }
        var validateeditflag
        function saveEditParameters(isFromEditClick) {
           
            checkEditValidation();
            if (validateeditflag == true) {
                if ($("#idEditchkReqMCalc").is(':checked')) {
                    skill.RequiredForMatricCalc = 1;
                } else {
                    skill.RequiredForMatricCalc = 0;
                }
                skill.ToolID = document.getElementById('hdnToolId').value;
                skill.Description = document.getElementById('idtxtskill').value.replace(/'/g, "''");
                skill.ConfiguredDays = document.getElementById('idtxtconfigrays').value;
                skill.Tools_CategoryID = document.getElementById('CboEditSkills').value;
                //Added by imran on 19-08-2022
                if (skill.Tools_CategoryID == "" || skill.Tools_CategoryID == null) {
                    skill.Tools_CategoryID = 0;
                }
               //End of comment by imran on 19-08-2022
                skill.ModifiedBy = UserName;
                skill.CreatedBy = UserName;
                
                $.ajax({
                    url: strUrl + '/api/RM_Skill/CreateSkills',
                    type: "POST",
                    data: JSON.stringify(skill),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (skill) {
                            xhr.setRequestHeader("Params", encryptString(isJson(skill) ? skill : JSON.stringify(skill)));
                        }
                    },
                    success: function (data) {

                        if (isFromEditClick == 0) {

                            if (data == "Skill already exist.") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                $('#EditSkillModal').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                GetSkills();
                                Close();
                            }
                        }
                        else {
                            if (data == "Skill already exist.") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                document.getElementById('hdnToolId').value = 0;
                                $('#EditSkillModal').modal('show');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(data);
                                GetSkills();
                                Close();
                            }
                        }

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue
                        //if (ajaxOptions == "error") {
                        //    console.log(thrownError);
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(xhr.responseJSON.Message);
                        //}
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue

                    }
                })
                //if (isFromEditClick == 1) {
                //    document.getElementById('hdnToolId').value = 0;
                //    document.getElementById('idtxtskill').value = "";
                //    document.getElementById('idtxtconfigrays').value = "";
                //    $("#idEditchkReqMCalc").prop("checked", false);
                //    document.getElementById('CboEditSkills').value = "";
                //}
            }
            else {
                return false;
            }
        }

        function DeleteSkillAfterConfirm() {
            var strHTML = "";
            var selectedSkillUniqueId = SelectedEmpID.toString();
            if (selectedSkillUniqueId.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_Skill/DeleteSkills',
                    type: "Post",
                    data: JSON.stringify(selectedSkillUniqueId),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedSkillUniqueId) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedSkillUniqueId) ? selectedSkillUniqueId : JSON.stringify(selectedSkillUniqueId)));
                        }
                    },
                    success: function (data) {
                        //console.log(data.deletedCount);
                        //console.log(data.notDeletedCount);
                        //if (data == "Skill  deleted successfully.") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.success(data);
                        //}
                        //else {
                        //      alertify.set('notifier', 'position', 'top-right');
                        //      alertify.error(data);
                        //}
                        GetSkills();
                         //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                       // strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                         //End of Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterow').html(strHTML);
                        $('#DeleteConfirmSkillMModal').modal('show');

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                        //if (ajaxOptions == "error") {
                        //    // console.log(thrownError);
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(xhr.responseJSON.Message);
                        //    $('#DeleteConfirmSkillMModal').modal('hide');
                        //}
                        //else if (xhr.statusText == "OK") {  //200
                        //    GetSkills();
                        //    //alertify.set('notifier', 'position', 'top-right');
                        //    // alertify.notify("Deleted");
                        //}
                        //else {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(thrownError);
                        //}

                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                        // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                


                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        // StopAjaxLoader("#bodyBusiness-group");
                    }
                })

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedEmpID = [];
            selectedSkillUniqueId = "";
        }

        //function DeleteSkills() {
        //    var isSelectedResource = GetSelectedSkills()
        //    if (isSelectedResource.length > 0) {
        //        //$('#DeleteConfirmSkillMModal').modal('show');
        //        DeleteSkillAfterConfirm();

        //    } else {
        //        alertify.set('notifier', 'position', 'top-right');
        //        alertify.error(DeleteRecord);
        //        return false;
        //    }
        //}

        //function GetSelectedSkills() {
        //    // if (confirm("Do you want to delete selected skills!")) {
        //    var selectedSkillUniqueId = '';
        //    $('#tblSkills').find('tr').each(function () {
        //        var row = $(this);
        //        if (row.find('input[type="checkbox"]').is(':checked')) {
        //            selectedSkillUniqueId += row.find('#hdnSkill_ToolID').val() + ',';
        //        }
        //    });
        //    if (selectedSkillUniqueId.length > 0) {
        //        selectedSkillUniqueId = selectedSkillUniqueId.substring(0, selectedSkillUniqueId.length - 1);
        //    }

        //    // }
        //    // else {
        //    return selectedSkillUniqueId;
        //    //  }
        //}

        var SelectedEmpID = [];
        // var selectedSkillUniqueId = '';
        function GetSelectedSkills(currentObject) {
            //  debugger;
            // if (confirm("Do you want to delete selected skills!")) {
            //if (currentObject != undefined && currentObject != "" && currentObject != null) {
            //alert("s");
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedEmpID.push(parseInt(row.find('#hdnSkill_ToolID').val()));
                // console.log("SelectedEmpID", SelectedEmpID);
                // selectedSkillUniqueId = SelectedEmpID.toString();
            }
            else {

                if (SelectedEmpID != 'undefined' && SelectedEmpID.length > 0) {

                    var removeEmp = row.find('#hdnSkill_ToolID').val();
                    // SelectedEmpID = SelectedEmpID.remove(parseInt(removeEmp));
                    SelectedEmpID.remove(parseInt(removeEmp));
                }

            }

            // }
            //else {
            //    //alert('g');
            //   // alert(selectedskills);
            //    selectedSkillUniqueId = selectedskills;
            //}
            //  selectedSkillUniqueId = SelectedEmpID.toString();
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
        //datatable
        function LoadPagination(data) {
            // console.log("console",data);
            //var businessGroupTable;
            $.fn.DataTable.ext.pager.numbers_length = 5;
            skilltable = $('#tblSkill').dataTable({
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
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [3] }]// Added By Dipali V On 21st Feb 2022 For issueid 32121
        
            });

        }

        function GetGetMaximumItemsToShowInList() {
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
                    // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                    //if (ajaxOptions == "error") {
                    //    console.log(thrownError);
                    //    //alertify.set('notifier', 'position', 'top-right');
                    //    // alertify.notify(xhr.responseJSON.Message);
                    //}
                    //else {
                    //    // alertify.set('notifier', 'position', 'top-right');
                    //    // alertify.notify(thrownError);
                    //}

                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //StopAjaxLoader("#bodyGlobal-Resource");

                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                }
            })

        }
        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        function resizeSection() {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 215, "overflow-y": "auto" });

           
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

        //var selectedSkills = [];
        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {

            var allPages = skilltable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#tblSkill").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedEmpID.push(parseInt($(rows[i]).find("#hdnSkill_ToolID").val()));

                    }

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedEmpID = [];
                    // selectedSkillUniqueId = "";
                }
            }
        });

        // Changing state of CheckAll checkbox
        $(".chcktbl").click(function () {

            if ($(".chcktbl").length == skilltable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
            }

        });



        function checkUncheck() {

            //console.log(skilltable.fnGetNodes());
            //alert($(".chcktbl:checked").length);
            if (skilltable.$('input:checked').length == skilltable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
            }
        }

        //Filers starts
        //Save and apply Filters

        var filterWhereClause = "";
        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;


        function GetSklDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                // var whereClauseFormated = whereClause.replace(/'/g, "\''");
                //filter = { UniqueID: '0', IsActive: 'true', BGWhereClause: whereClauseFormated };
                //Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                //filter = { UniqueID: '0', SklWhereClause: encodeURI(whereClause) };
                filter = { UniqueID: '0', SklWhereClause: encodeURIComponent(whereClause) };
                //End of Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
            }
            GetSkills(filter);
        }
        //FILTER VALIDATION
        function checkFiltervalidationForSkills() {
            var Desc = $("#txtSklFilterDescription").val() == "" ? null : $("#txtSklFilterDescription").val();
            <%--Commented & Added By Rutuja D.--%>
            //var isActive = $("#chkSklFilterRequiredForMatricCalc").is(":checked");            
            var isActive = $("#txtSklFilterRequiredForMatricCalc").val() == "" ? null : $("#txtSklFilterRequiredForMatricCalc").val();
           <%--End of Commented & Added By Rutuja D.--%>
            var categoryID = $("#txtSklFilterTools_CategoryID").val() == "" ? null : $("#txtSklFilterTools_CategoryID").val();
            var Days = $("#txtSklFilterConfiguredDays").val() == "" ? null : $("#txtSklFilterConfiguredDays").val();

            //alert(Desc+ ","+ isActive+","+ categoryID +","+ Days);
            //console.log("roleId :", roleId);
            <%--Commented & Added By Rutuja D.--%>
            //if ((Desc == null || Desc == 'undefined') && (categoryID == null || categoryID == 'undefined') && (Days == null || Days == 'undefined' || Days == 0) && (isActive == false)) {
            if ((Desc == null || Desc == 'undefined') && (categoryID == null || categoryID == 'undefined') && (Days == null || Days == 'undefined' || Days == 0) && (isActive == null || isActive == 'undefined')) {
           <%--End of Commented & Added By Rutuja D.--%>
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one filter');
                $('#SklSavefilter').modal('hide');
            }
            else {
                $('#SklSavefilter').modal('show');
            }
        }

        function SaveSklFilterDetails() {
            var fltFilterName = $("#txtSklFilterName").val();
            if (fltFilterName == "") {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please Enter Filter Name');

                $("#txtSklFilterName").focus();
            }
            else if (checkSpecialCharacter(fltFilterName, WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtSklFilterName").focus();
              
            }
			//End of Comment Added By Riddhesh Patil
            else {
                var filterExists = 0;
                //if (savedFilterName == "") {
                //    filterExists = ExistBGFilter(fltFilterName);
                //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                //    $('#SklSavefilter').modal('show');
                //}

                //if (filterExists == 0) {
                //    $("#btnSaveFilter").attr("data-bs-dismiss", "modal");
                //var AllBgFilter = ["Description", "ConfiguredDays"];
                var AllSklFilter = ["Description", "ConfiguredDays", "Tools_CategoryID", "RequiredForMatricCalc"];
                //  var isActiveFilter = 'True';/// $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GenerateBGBasicFilterQuery("Skl", AllSklFilter);
                // var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
                //filterWhereClause2 += "AND Active=" + ' "' + isActiveFilter + '"';
                // console.log(filterWhereClause2);
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
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            FilterApplied();
                            GetMyFilter(0);
                            ApplyFlter();
                            savedFilterName = fltFilterName;
                            $("#txtSklFilterName").val("");
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
        //End Exists Filters

        //Generate Filter Query

        function GenerateBGBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();
                    var strCHK = $('#chk' + module + 'Filter' + filterField[i]).is(":checked");
                    // console.log(strOp);
                    if ($('#txtSklFilterDescription').val() == "" || $('#txtSklFilterDescription').val() == undefined) {
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
                        //    else if (strOp == "=" && strCHK == "true") {
                        //        alert(1);
                        //     strqtext += filterField[i]+"="+"'" + strCHK+"'";
                        //    }
                        //    else if (strOp == "<>" && strCHK == "true") {
                        //     strqtext += filterField[i]+"="+"'" + strCHK+"'";
                        //}
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
                // console.log('strqtext');
                //  console.log(strqtext);
                strqtext = strqtext.replace('Over', '[Over]')
                strqtext = strqtext.replace(/'/g, "''");
                //strqtext = strqtext.replace(/"/g, "''");
                return strqtext;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        //End Generate Filter Query

        //Start ApplyFilter
        function ApplyFlter() {
            var isActive = $("#chkSklFilterRequiredForMatricCalc").is(":checked");
           <%--End of Commented & Added By Rutuja D.--%>
           // if (isActive == false && $('#txtSklFilterDescription').val() == "" && $('#txtSklFilterTools_CategoryID').val() == "" && $('#txtSklFilterConfiguredDays').val() == '') {
            if ($("#txtSklFilterRequiredForMatricCalc").val() == "" && $('#txtSklFilterDescription').val() == "" && $('#txtSklFilterTools_CategoryID').val() == "" && $('#txtSklFilterConfiguredDays').val() == '') {
           <%--End of Commented & Added By Rutuja D.--%>
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
            } else {

                currentFilterID = 0;
                var filter = "";
                var AllSklFilter = ["Description", "ConfiguredDays", "Tools_CategoryID", "RequiredForMatricCalc"];
                var filterWhereClause2 = GenerateBGBasicFilterQuery("Skl", AllSklFilter);
                //filterWhereClause = filterWhereClause2.replace(/"/g, "\''");
                var filterWhereClause = filterWhereClause2.replace(/"/g, "\'");
                //Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                //filter = { UniqueID: '0', SklWhereClause: encodeURI(filterWhereClause) }
                filter = { UniqueID: '0', SklWhereClause: encodeURIComponent(filterWhereClause) }
                //End of Commented & Added By Rutuja D. on 19 July 2021 For IssueID=27067
                GetSkills(filter);
                FilterApplied();
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");
            }
        }
        //End ApplyFilter

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
                            GetSkills();
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyFilter(0);
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
                        ApplySavedFilter(FilterID, 2, true);//changed by mahesh on 21 july 2021
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        //alertify.success('Default');
                        // FilterNotApplied();
                        // GetMyFilter(0);
                        ApplySavedFilter(FilterID, 3, true);//changed by mahesh on 21 july 2021
                        alertify.success('Default Filter Is Successfully Removed!');
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        FilterNotApplied();
                    }
                    GetMyFilter(0);
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
                        $("#txtSklFilterName").val(currentFilterName);
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

        function cancelsaveapply() {
            if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID == "") {
                $('#txtSklFilterName').val("");
            }

        }
        function ClearFilterDetails(flag) {
            if ($("#cboSklFilterDescription").val() != "Contains") {
                setFilterComboValue("cboSklFilterDescription", "Contains");
            }
            if ($("#txtSklFilterDescription").val() != "") {
                $("#txtSklFilterDescription").val("");
            }
            if ($("#txtSklFilterConfiguredDays").val() != "") {
                $("#txtSklFilterConfiguredDays").val("");
            }
            //if ($("#cboSklFilterConfiguredDays").val() != "Contains") {
            //    setFilterComboValue("cboSklFilterConfiguredDays", "Contains");
            //}
            $("#txtSklFilterTools_CategoryID").val("");
           <%--Commented & Added By Rutuja D.--%>
            //$("#chkSklFilterRequiredForMatricCalc").prop('checked', false);
             $("#txtSklFilterRequiredForMatricCalc").val("");
             $("#cboSklFilterRequiredForMatricCalc").val("=");
           <%--End of Commented & Added By Rutuja D.--%>

            //Added By Reshma Chavan on 31st Jan 2022
             $("#cboSklFilterConfiguredDays").val("=");
             $("#cboSklFilterTools_CategoryID").val("=");
            //End of Added By Reshma Chavan on 31st Jan 2022
            savedFilterName = "";
            $('#txtSklFilterName').val('');

            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {

                    $(this).removeAttr("checked");
                });
            }
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
            if (arrFields[0] == "Description") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboSklFilterDescription", "txtSklFilterDescription");
            }
            if (arrFields[0] == "ConfiguredDays") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboSklFilterConfiguredDays", "txtSklFilterConfiguredDays");
            }


            if (arrFields[0] == "Tools_CategoryID") {
                var currOpToolCategory = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }
                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                setFilterComboValue("cboSklFilterTools_CategoryID", currOpToolCategory);
                setFilterComboValue("txtSklFilterTools_CategoryID", currValue);
            }
            if (arrFields[0] == "RequiredForMatricCalc") {
                var currOpReq = arrFields[1].toString().trim();
                var currValue1 = arrFields[2].toString().trim();
                if (currValue1.substring(currValue1.length - 1) == "'") {
                    currValue1 = currValue1.substring(0, currValue1.length - 1);
                }
                if (currValue1.substring(0, 1) == "'") {
                    currValue1 = currValue1.substring(1);
                }
                setFilterComboValue("cboSklFilterRequiredForMatricCalc", currOpReq)
           <%--End of Commented & Added By Rutuja D.--%>
                setFilterComboValue("txtSklFilterRequiredForMatricCalc", currValue1)
                //if (currValue1 == "'true'") {
                //    $('#chkSklFilterRequiredForMatricCalc').prop("checked", true);
                //}
                //else {
                //    $('#chkSklFilterRequiredForMatricCalc').prop("checked", false);
                //}
           <%--End of Commented & Added By Rutuja D.--%>

            }
        }

        function setFilterComboValue(fieldName, fieldValue, flag) {
            //if (flag == undefined) {
            //    $("#" + fieldName).removeClass("selectpicker");
            $("#" + fieldName).val(fieldValue);
            //  //  $("#" + fieldName).addClass("selectpicker");
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
            if (arrFields[1] == "<>") {
                setFilterComboValue(OpComboName, "<>");
            }
            //if (arrFields[1] == "=") {
            //    alert('jj');
            //    setFilterComboValue(OpComboName, "=");
            //}
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
        //Apply saved filter   
        function ApplySavedFilter(FilterID, isDefault, isFromDefault) {
            //Changed  by mahesh on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }

            if (isDefault == 3) {
                GetSkills();
                GetMyFilter(isDefault);
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
                        if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                            GetMyFilter(0);
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
            GetSklDetails(null);
            GetMyFilter(0);//Added By Mahesh on 21 July 2021
        });
        //Filters End

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


