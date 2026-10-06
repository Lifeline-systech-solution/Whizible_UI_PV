<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_IR_Related_Settings.aspx.vb" Inherits="PbNIT.PM_IR_Related_Settings" %>

<!DOCTYPE html>
<html>
   <!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
  <%CommonFunctions.General.PlotPageHeadTag("Project")%>
<head>
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
        <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">
  
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">

<%--    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

    
</head>
    <style>
        body {
            background: #fff;
        }

     
        #tblIRRelatedSettingsProjectHistory_wrapper table tr th .dataTables_info {
            float: left;
        }

        #tblIRRelatedSettingsProjectHistory_wrapper .dataTables_paginate {
            margin-top: 0px;
            margin-bottom: 20px;
        }

        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        #tblIRRelatedSettingsProjectHistory tr th {
            min-width: 120px;
        }

        #tblIRRelatedSettingsProjectHistory .dataTables_info {
            float: left;
            margin-top: 0;
        }
        .alertify-notifier {
            z-index: 9999 !important;
        }
        table#tblSalesPersonsDetails, table#tblIRApprovers, table#tblInvoiceGenerator {
            width: 97% !important;
            margin: 10px auto;}

        /*Added By Dipali V On 29th Jun 2021 For Note CSS */
        .left-side-save {
            color: red;
            font-size: 10px;
            font-weight: 100;
            text-align: left;
            margin-left: 20px;
        }
         /*End of Added By Dipali V On 29th Jun 2021 For Note CSS */

         /*Added By Gauri On 20th Aug 2024 For show history button accordion CSS */
         @media (min-width: 992px){
            .collapsed {
                display: inline-block;
            }
         }
         /*End of Gauri On 20th Aug 2024 For show history button accordion CSS */
    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="BodyIRSettings">
    <div id="divProjectIRRelatedSettings">
        <div class="tab-pane pstbl_itrelated practicesettinglist in active" id="pstbl_itRelated" style="border-top: 1px solid #ddd;">
            <div class="modalpgHead  pt-1 pb-1 col-sm-12 mb-10">
                <span><%= MyBase.GetResourceString("C_IR_Related_Settings") %></span>
            </div>
            <%--Added By Omkar P On 15.01.2020 For showing current project name --%>
            <h5 class="float-start pl-20 clearfix">Project Name : <span id="spnProjectName"></span></h5>
             <%--End Of Added By Omkar P On 15.01.2020 For showing current project name --%>
            <div class="right-side-save mb-10">
               
                <a href="javascript:;" class="btn borderbtn mr-5" data-bs-toggle="collapse" data-bs-target="#IRrelatedshowHis" onclick="ShowModifiedByAndField();"><%= MyBase.GetResourceString("C_Show_History") %></a>

                <% If m_PM_IRRelatedSettingsEditAccess = True Then %>
                <a href="#" class="btn btnyellow" onclick="IRRelatingSettingsbtnSaveClick()">Save</a>
                <% End If %>
            </div>
           <%--  /*Added By Dipali V On 29th Jun 2021 For Note  */--%>
             <h5 class="left-side-save mb-10" >Note: Once the IR is created under selected project, Billing Currency Can not be changed.</h5>
           <%-- /*End of Added By Dipali V On 29th Jun 2021 For Note  */--%>
            <div class="hiddenRow subCustomField text-start">
                <div class="accordian-body collapse" id="IRrelatedshowHis" aria-expanded="false" style="height: 20px;">
                    <div class="history-wrap accordian-body form-group pt-0" id="IRhistoryMain" aria-expanded="true" style="">

                        <div class="page-main-head ">
                            <h4><%= MyBase.GetResourceString("C_IR_Related_Settings_History") %></h4>
                        </div>
                        <div class="right-side-save">
                            <a href="#" class="btn borderbtn mb-10" data-bs-toggle="collapse" data-bs-target="#IRrelatedshowHis" aria-expanded="true"><%= MyBase.GetResourceString("C_Close") %></a>
                        </div>
                       <%-- <div class="note-wrap note-wrap-txt">
                            <p></p>
                        </div>--%>
                        <div class="row form-group pl-30">
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_Modified_Field") %></label>
                               
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboIRRelatedSettingsModifiedField", "usp_Whizible2_Sel_tbl_Whizible2_PM_IRRelatedSettings_AuditTrail_GetFieldName " & "3091,0," & Request.QueryString("ProjectID") & "," & Request.QueryString("ProjectID"),,,, True, , "'form-select' onchange='cboIRRelatedSettingsModifiedFieldOrModifiedBy()' ",,,) %>
                            </div>
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_Modified_By") %></label>
                                
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboIRRelatedSettingsModifiedBy", "Select ''",,,, False, , "'form-select' onchange='cboIRRelatedSettingsModifiedFieldOrModifiedBy()' ",,,) %>
                           
                            </div>
                        </div>

                        <div class="col-sm-12">
                            <table id="tblIRRelatedSettingsProjectHistory" class="table table-bordered" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th width="60%"><%= MyBase.GetResourceString("C_Modified_Field") %></th>
                                        <th width="13%"><%= MyBase.GetResourceString("C_Modified_Date") %></th>
                                        <th width="13%"><%= MyBase.GetResourceString("C_Old_Value") %></th>
                                        <th width="13%"><%= MyBase.GetResourceString("C_New_Value") %></th>
                                        <th width="13%"><%= MyBase.GetResourceString("C_Modified_By") %></th>
                                    </tr>
                                </thead>
                                <tbody id="tblbdyIRRelatedSettingsProjectHistory">
                                   
                                </tbody>
                            </table>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>

                </div>
                <div class="clearfix"></div>
            </div>
            <br />
            <br />
            <div class="clearfix"></div>

            <div class="row main-itrelated-form">
                <div class="col-sm-4">
                    <div class="itrealated-form">
                        <label class="required"><%= MyBase.GetResourceString("C_Company") %></label>
                        <div class="custom-dropdown">
                           
                            <% CommonFunctions.HTMLControls.DrawComboBox("cboIRRelatedSettingsCompany", "usp_Whizible2_sel_tbl_PM_CompanyMaster_GetCompanyList ",,,, False, , "class='form-select ' ",,,) %>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="itrealated-form">
                        <label class="required"><%= MyBase.GetResourceString("C_Billing_Currency") %></label>
                        <div class="custom-dropdown">
                           
                            <% CommonFunctions.HTMLControls.DrawComboBox("cboIRRelatedSettingsBillingCurrency", "usp_Whizible2_Select_BaseCurrecny " & Request.QueryString("ProjectID"),,,, False, , "class='form-select ",,,) %>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="itrealated-form">
                        <label class="required">Project/Product</label>
                        <div class="custom-dropdown">
                           
                            <% CommonFunctions.HTMLControls.DrawComboBox("cboIRRelatedSettingsProjectOrProduct", "usp_Whizible2_Sel_RFI_ProjectOrProduct ",,,, False, , "class='form-select ",,,) %>
                        </div>
                    </div>
                </div>
            </div>
            <div class="inner-tabing">
                <ul class="nav nav-tabs">
                    <li class="active"><a class="active" data-bs-toggle="tab" href="#salesCommission">Sales Commission Settings</a></li>
                    <li><a data-bs-toggle="tab" href="#IRapprover">IR Approvers</a></li>
                    <li><a data-bs-toggle="tab" href="#invoGen">Invoice Generators</a></li>
                </ul>
                <div class="tab-content">
                    <div id="salesCommission" class="tab-pane fade in active show">
                        <div class="right-side-save">
                            <a href="javascript:;" class="btn borderbtn mr-5" onclick="IRRelatedSettingsSalesPersonbtnAddClick()"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
                            <button id="delete-row" class="btn borderbtn" onclick="IRRelatedSettingsSalesPersonbtnDeleteClick()">Delete</button>
                        </div>
                        <table id="tblSalesPersonsDetails" class="table table-stripped table-bordered">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>Sales Commission (%)</th>
                                    <th class="sm-wid">
                                        <div class="custom_chckbox">
                                            <input id="resourceAll" class="chckHead" type="checkbox">
                                            <label for="resourceAll"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tblbdySalesPersonsDetails">
                                <%--<tr>
                                <td colspan="3" class="text-center">There are no items to show in this view.</td>
                            </tr>--%>
                            </tbody>
                        </table>
                    </div>
                    <div id="IRapprover" class="tab-pane fade">
                        <div class="right-side-save">
                            <a href="javascript:;" class="btn borderbtn mr-5" id="" onclick="IRRelatedSettingsIRApproversbtnAddClick()"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
                            <button id="delete-row1" class="btn borderbtn" onclick="IRRelatedSettingsIRApproversbtnDeleteClick()">Delete</button>
                        </div>
                        <table id="tblIRApprovers" class="table table-stripped table-bordered">
                            <thead>
                                <tr>
                                    <th>IR Approver</th>
                                    <th class="sm-wid">
                                        <div class="custom_chckbox">
                                            <input id="innIrAll" class="chckHead" type="checkbox">
                                            <label for="innIrAll"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tblbdyIRApprovers">
                               
                            </tbody>
                        </table>
                    </div>
                    <div id="invoGen" class="tab-pane fade">
                        <div class="right-side-save">
                            <a href="javascript:;" class="btn borderbtn mr-5" id="" onclick="IRRelatedSettingsInvoiceGeneratorbtnAddClick()"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>
                            <button id="delete-row2" class="btn borderbtn" onclick="IRRelatedSettingsInvoiceGeneratorbtnDeleteClick()">Delete</button>
                        </div>
                        <table id="tblInvoiceGenerator" class="table table-stripped table-bordered">
                            <thead>
                                <tr>
                                    <th>Invoice Generator</th>
                                    <th class="sm-wid">
                                        <div class="custom_chckbox">
                                            <input id="innInvoGenAll" class="chckHead" type="checkbox">
                                            <label for="innInvoGenAll"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tblbdyInvoiceGenerator">
                               
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!--Add new site modal end here-->


        <!--Add new project os start here-->
        <div class="modal custmodal fade" id="addsales" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Sales Commission Settings</h5>
                        <button type="button" class="close" onclick="IRRelatedSettingsAddSalesPersonModelbtnCloseClick()" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row mb-3">
                                <span id="spnIRRelatedSettingProjectSalesPersonID"></span>
                                <div class="form-group col-sm-6">
                                    <label class="control-label required">Sales Person</label>
                                    
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboSalesPerson", "Select 0,'--selet IssueID--'", ,,, True, , "'  form-select' ",,,) %>
                                </div>
                                <div class="col-sm-6">
                                    <label class="control-label required">Sales Commission (%)</label>
                                   
                                   
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtSalesCommission", "txtSalesCommission", "form-control",, 3,,,,,,,, "Autocomplete='off'",,, True,,,,) %>
                                    <%--End Of Added By Usha Pandit On 12.06.2020 for setting max length--%>
                                </div>
                            </div>
                            <div class="">
                                <div class="row">
                                    <div class="col-sm-12 btns-center btn-grp-new">
                                        <button class="btn borderbtn" onclick="IRRelatedSettingsAddSalesPersonModelbtnCloseClick()">Close</button>
                                        <button class="btn btnyellow float-end ml-1" onclick="IRRelatedSettingsAddSalesPersonModelbtnSaveClick()">Save</button>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add new sales commission settings end here-->

        <!--Add new IR Approvers start here-->
        <div class="modal custmodal fade" id="addIR" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">IR Approvers</h5>
                        <button type="button" class="close" onclick="IRRelatedSettingsAddIRApproversModelbtnCloseClick()" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <span id="spnIRRelatedSettingProjectIRApproversID"></span>
                            <div class="row mb-3">
                                <div class="col-sm-3"></div>
                                <div class="form-group col-sm-6">
                                    <label class="control-label required">IR Approver</label>
                                  
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboIRApprovers", "Select 0,'--selet IssueID--'", ,,, True, , "'  form-select' ",,,) %>
                                </div>
                            </div>
                        </div>
                        <div class="">
                            <div class="row">
                                <div class="col-sm-12 btns-center btn-grp-new">
                                    <button class="btn borderbtn" onclick="IRRelatedSettingsAddIRApproversModelbtnCloseClick()">Close</button>
                                    <button class="btn btnyellow float-end ml-1" onclick="IRRelatedSettingsAddIRApproversModelbtnSaveClick()">Save</button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add new IR Approvers end here-->

        <!--Add new Invoice Generators start here-->
        <div class="modal custmodal fade" id="addInvoice" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Invoice Generators</h5>
                        <button type="button" class="close" onclick="IRRelatedSettingsAddInvoiceGeneratorModelbtnCloseClick()" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <span id="spnIRRelatedSettingProjectInvoiceGeneratorsID"></span>
                            <div class="row mb-3">
                                <div class="col-sm-3"></div>
                                <div class="form-group col-sm-6">
                                    <label class="control-label required">Invoice Generator</label>
                                   
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboInvoiceGenerator", "Select 0,'--selet IssueID--'", ,,, True, , "'  form-select' ",,,) %>
                                </div>
                            </div>
                            <div class="">
                                <div class="row">
                                    <div class="col-sm-12 btns-center btn-grp-new">
                                        <button class="btn borderbtn" onclick="IRRelatedSettingsAddInvoiceGeneratorModelbtnCloseClick()">Close</button>
                                        <button class="btn btnyellow float-end ml-1" onclick="IRRelatedSettingsAddInvoiceGeneratorModelbtnSaveClick()">Save</button>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add new Invoice Generators end here-->

        <!--Add_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="CPaddSubtaskModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Add New Sub Task</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row mb-3">
                                <label class="control-label col-sm-4">Sub Task Type</label>
                                <div class="col-sm-8">
                                    <select class="form-select selectpicker">
                                        <option>Risk Analysis</option>
                                        <option>Requirement Analysis</option>
                                        <option>Feasibility Study</option>
                                        <option>Documentation</option>
                                        <option>Defect Analysis</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <div class="row">
                                <label class="control-label col-sm-4">&nbsp;</label>
                                <div class="col-sm-8">
                                    <button data-dismiss="modal" class="btn borderbtn">Close</button>
                                    <button data-dismiss="modal" class="btn btnyellow float-end ml-1">Save</button>
                                    <button data-dismiss="modal" class="btn btnyellow float-end">Save and Add</button>

                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--Add_new_Sub_tasktype_modal_end_here-->

        <!--Delete_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="CPdelSubtaskModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Delete Sub Task</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <h5>
                                <center>Are you sure you want to delete these records?</center>
                            </h5>
                        </div>
                        <br />
                        <center>
                                    <button data-dismiss="modal" class="btn borderbtn">No</button>
                                    <button data-dismiss="modal" class="btn btnyellow ml-1">Yes</button>
                                </center>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--Delete_new_Sub_tasktype_modal_end_here-->


        <!--  DELETE IR Related Settings Modal Start here-->
        <div id="deleteProjectIRRelatedSettingsSalesPersoninfomodal" class="modal fade custmodal" role="dialog">
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%= MyBase.GetResourceString("C_Delete") %></h4>
                    </div>

                    <div class="modal-body">

                        <span id="DeleteProjectOSId"></span>

                        <p align="center"><%= MyBase.GetResourceString("C_Delete_Confirmation") %></p>

                        <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" onclick="cancelProjectIRRelatedSettingsSalesPersonDelted()"><%= MyBase.GetResourceString("C_No") %></button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteProjectIRRelatedSettingsSalesPersonData()" data-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %></button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- DELETE IR Related Settings Modal end here-->


        <!--  DELETE IR Related Settings IR Approvers Modal Start here-->
        <div id="deleteProjectIRRelatedSettingsIRApproversinfomodal" class="modal fade custmodal" role="dialog">
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%= MyBase.GetResourceString("C_Delete") %></h4>
                    </div>

                    <div class="modal-body">

                        <span id="DeleteProjectOSId"></span>

                        <p align="center"><%= MyBase.GetResourceString("C_Delete_Confirmation") %></p>

                        <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" onclick="cancelProjectIRRelatedSettingsIRApproversDeleted()"><%= MyBase.GetResourceString("C_No") %></button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteProjectIRRelatedSettingsIRApproversData()" data-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %></button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- DELETE IR Related Settings IR Approvers Modal end here-->

        <!--  DELETE IR Related Settings Invoice Generators Modal Start here-->
        <div id="deleteProjectIRRelatedSettingsInvoiceGeneratorsinfomodal" class="modal fade custmodal" role="dialog">
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%= MyBase.GetResourceString("C_Delete") %></h4>
                    </div>

                    <div class="modal-body">

                        <span id="DeleteProjectOSId"></span>

                        <p align="center"><%= MyBase.GetResourceString("C_Delete_Confirmation") %></p>

                        <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" onclick="cancelProjectIRRelatedSettingsInvoiceGeneratorsDeleted()"><%= MyBase.GetResourceString("C_No") %></button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteProjectIRRelatedSettingsInvoiceGeneratorsData()" data-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %></button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- DELETE IR Related Settings InvoiceGenerators Modal end here-->

             <!-- REQUIRED JS SCRIPTS -->
<!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
  <%--  <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script> 
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <!-- alertify -->
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js"></script>

    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js"></script>--%>
    <script src="../../General/CommonFunctions.js"></script>

        <script>
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString()%>';
            var ProjectID = "<%= Request.QueryString("ProjectID").ToString() %>";
            var UserID = "<%= Session("intUserID").ToString() %>";
            var LoginType = "<%= Session("LoginType").ToString() %>";
            var UserName = "<%= Session("strUserName").ToString() %>";
            var RoleID = "<%= Session("intPostID").ToString() %>";
            var SalesCommissionSettingsAddAccess = "<%=m_PM_IRRelatedSettingsAddAccess%>";
            var SalesCommissionSettingsEditAccess = "<%=m_PM_IRRelatedSettingsEditAccess%>";
            var SalesCommissionSettingsDeleteAccess = "<%=m_PM_IRRelatedSettingsDeleteAccess%>";
            var SalesCommissionSettingsViewAccess = "<%=m_PM_IRRelatedSettingsViewAccess%>";

            var IRApproversAddAccess = "<%=m_PM_IRRelatedSettingsAddAccess%>";
            var IRApproversEditAccess = "<%=m_PM_IRRelatedSettingsEditAccess%>";
            var IRApproversDeleteAccess = "<%=m_PM_IRRelatedSettingsDeleteAccess%>";
            var IRApproversViewAccess = "<%=m_PM_IRRelatedSettingsViewAccess%>";

            var InvoiceGeneratorsAddAccess = "<%=m_PM_IRRelatedSettingsAddAccess%>";
            var InvoiceGeneratorsEditAccess = "<%=m_PM_IRRelatedSettingsEditAccess%>";
            var InvoiceGeneratorsDeleteAccess = "<%=m_PM_IRRelatedSettingsDeleteAccess%>";
            var InvoiceGeneratorsViewAccess = "<%=m_PM_IRRelatedSettingsViewAccess%>";
            var ViewAccess = "<%= m_PM_IRRelatedSettingsViewAccess %>";

            //$('.editor1').wysihtml5();
            //change date format
            var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            var uDatepicker = $.datepicker._updateDatepicker;
            $.datepicker._updateDatepicker = function () {
                var ret = uDatepicker.apply(this, arguments);
                var $sel = this.dpDiv.find('select');
                $sel.find('option').each(function (i) {
                    $(this).text(months[i]);
                });
                return ret;
            };

            //datepicker

            $('#newprostartdate, #newproenddate').datepicker({
                autoclose: true,
                changeMonth: true,
                dateFormat: 'dd M yy'
            });


            $('#RRdate').datepicker({
                autoclose: true,
            });

            $(document).ready(function () {
              
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divProjectIRRelatedSettings").html(bodyHTML);
                    return;
                }
                //$("#configureAppAll").click(function () {
                //    $(".configurechck").prop('checked', $(this).prop('checked'));
                //});
                //$(".closeAcco").click(function () {
                //    $(this).closest(".accordian-body").removeClass("In");
                //});

                $("#tblSalesPersonsDetails > thead > tr > th.sm-wid>div.custom_chckbox>input#resourceAll").click(function () {
                    // $(".expensechck").prop('checked', $(this).prop('checked'));
                    if ($(this).prop("checked")) {
                        $('#tblbdySalesPersonsDetails input[type="checkbox"]').prop('checked', true);
                    } else {
                        $('#tblbdySalesPersonsDetails input[type="checkbox"]').prop('checked', false);
                    }
                });

                $("#tblIRApprovers > thead > tr > th.sm-wid > div>input#innIrAll").click(function () {
                    // $(".expensechck").prop('checked', $(this).prop('checked'));
                    if ($(this).prop("checked")) {
                        $('#tblbdyIRApprovers input[type="checkbox"]').prop('checked', true);
                    } else {
                        $('#tblbdyIRApprovers input[type="checkbox"]').prop('checked', false);
                    }
                });

                $("#tblInvoiceGenerator > thead > tr > th.sm-wid > div>input#innInvoGenAll").click(function () {
                    // $(".expensechck").prop('checked', $(this).prop('checked'));
                    if ($(this).prop("checked")) {
                        $('#tblbdyInvoiceGenerator input[type="checkbox"]').prop('checked', true);
                    } else {
                        $('#tblbdyInvoiceGenerator input[type="checkbox"]').prop('checked', false);
                    }
                });
               
                GetProjectHistroyDetails(ProjectID, 3091, '', '');
                GetProjectIRRelaetedSettingsGetDetailsSpecificProject(ProjectID);
                GetProjectIRRelaetedSettingsNodeAccess();
                IRRelatedSettingAccessWisePloting();
                GetProjectSalesPersonsDetails(ProjectID);
                GetProjectIRApproversDetails(ProjectID);
                GetProjectInvoiceGeneratorDetails(ProjectID);
                // Added By Rutuja D. 6 Jan 2020 for Fill Modified Field & Modified By
                FillModifiedFieldCombo();
                FillModifiedByCombo();
                 // End Added By Rutuja D. 6 Jan 2020 for Fill Modified Field & Modified By
                //Added By Omkar P On 15.01.2020 For showing current project name
                getProjectName(ProjectID);
                //End Of Added By Omkar P On 15.01.2020 For showing current project name
            });

            function GetProjectIRRelaetedSettingsGetDetailsSpecificProject(ProjectId) {
                //var ProjectId = ProjectId;
                // $("#tblprojectos").dataTable().fnDestroy();
                //var configureApprovers = {
                //    ProjectId: encodeURI(ProjectId),
                //    ReportToId:encodeURI(ReportTo),
                //    RoleId:encodeURI(Role),
                //};
                var projectosdata = {
                    ProjectID: ProjectId
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetProjectIRRelaetedSettingsGetDetailsSpecificProject',
                    method: 'Post',
                    data: JSON.stringify(projectosdata),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (projectosdata) {
                            xhr.setRequestHeader("Params", encryptString(isJson(projectosdata) ? projectosdata : JSON.stringify(projectosdata)));
                        }
                    },
                    success: function (result) {
                        console.log(result);
                        //debugger

                        var ProjectDetails = result.ProjectDetails;


                        for (var i = 0; i < ProjectDetails.length; i++) {
                            //debugger;
                            //Commented & Added By Dipali V On 29th Jun 2021 to Get Billing Currency
                           // var BaseCurrency = ProjectDetails[i]["BaseCurrency"];
                            var BaseCurrency = ProjectDetails[i]["BillingCurrencyID"];
                             //End of Commented & Added By Dipali V On 29th Jun 2021 to Get Billing Currency
                            var CompanyID = ProjectDetails[i]["CompanyID"];
                            var ProjectOrProduct = ProjectDetails[i]["ProjectOrProduct"];
                            //alert(BaseCurrency);
                            $("#pstbl_itRelated > div.row.main-itrelated-form > div> div > div>select#cboIRRelatedSettingsCompany Option[value='" + CompanyID + "']").prop('selected', true);
                            $("#pstbl_itRelated > div.row.main-itrelated-form > div> div > div>select#cboIRRelatedSettingsProjectOrProduct option[value='" + ProjectOrProduct + "']").prop('selected', true);
                            $("#pstbl_itRelated > div.row.main-itrelated-form > div> div > div>select#cboIRRelatedSettingsBillingCurrency option[value='" + BaseCurrency + "']").prop('selected', true);
                        }

                    },
                    error: function (err) {
                        console.log(err.responseText)
                        //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }
            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                try {
                    var newpath = opener.window.location.href;
                    if (newpath.indexOf('FromWhereProjectId') == -1) {
                        newpath = opener.window.location.href.replace('#', '?');
                        newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ToIRRelatedSettings%>'&Mode=Edit&update=done";                        
                    }
                    newpath = newpath.toString().replace("&update=done", "");
                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");

                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ToIRRelatedSettings%>');
                    newpath = newpath.toString().replace("FromWhereProjectId=" + currentFromWhereProjectId, "FromWhereProjectId=" + '<%= Request.QueryString("ProjectID") %>');
                    newpath = newpath.toString().replace("FromWhereData=D", "FromWhereData=C");
                    if (newpath.indexOf("Add#") != -1) {
                        newpath = newpath.toString().replace("Add#", "Edit&update=done");
                    }
                    else if (newpath.indexOf("Edit#") != -1) {
                        newpath = newpath.toString().replace("Edit#", "Edit&update=done");
                    }
                    else if (newpath.indexOf("Edit") != -1) {
                        newpath = newpath.toString().replace("Edit", "Edit&update=done");
                    }
                    opener.window.location.replace(newpath);
                }
                catch (ex) {
                    //alert(ex.message);
                }
            }
            function IRRelatingSettingsbtnSaveClick() {
                try {
                    var flag = true;
                    //var EmployeeId = $('#main-tab-inner-1 > div.approverfilter-wrap > div > div > div > div>select#cboTimesheetNewApprover option:selected').val();
                    var CompanyID = $("#pstbl_itRelated > div.row.main-itrelated-form > div> div > div>select#cboIRRelatedSettingsCompany option:selected").val();
                    var ProjectOrProduct = $("#pstbl_itRelated > div.row.main-itrelated-form > div> div > div>select#cboIRRelatedSettingsProjectOrProduct option:selected").val();
                    var BillingCurrencyID = $("#pstbl_itRelated > div.row.main-itrelated-form > div> div > div>select#cboIRRelatedSettingsBillingCurrency option:selected").val();

                    if (CompanyID == 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                        alertify.error("Please Select Company");
                        //alertify.error(message);
                        $("#pstbl_itRelated > div.row.main-itrelated-form > div> div > div>select#cboIRRelatedSettingsCompany").focus();
                        flag = false;
                        return false;
                    }
                    if (BillingCurrencyID == 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                        alertify.error("Please Select Billing Currency");
                        //alertify.error(message);
                        $("#pstbl_itRelated > div.row.main-itrelated-form > div> div > div>select#cboIRRelatedSettingsBillingCurrency").focus();
                        flag = false;
                        return false;
                    }

                    if (ProjectOrProduct == "Select Project/Product") {
                        alertify.set('notifier', 'position', 'top-right');
                        // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                        alertify.error("Please Select Project Or Product");
                        //alertify.error(message);
                        $("#pstbl_itRelated > div.row.main-itrelated-form > div> div > div>select#cboIRRelatedSettingsProjectOrProduct").focus();
                        flag = false;
                        return false;
                    }
                    if (flag == true) {


                        //tblTimeshetApproversCheckBoxChecked();

                        // console.log(arrApproverIds);
                        var irrelatedsettings = {
                            ProjectId: encodeURI(ProjectID),
                            CompanyID: encodeURI(CompanyID),
                            BaseCurrency: encodeURI(BillingCurrencyID),
                            ProjectOrProduct: encodeURI(ProjectOrProduct),
                            ModifiedBy: encodeURI(UserName)

                        };
                        // console.log(configureApprovers);

                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetProjectIRRelaetedSettingsUpdateSpecificProjectDetails',
                            method: 'Post',
                            data: JSON.stringify(irrelatedsettings),
                            dataType: 'json',
                            async: false,
                            contentType: "application/json",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (irrelatedsettings) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                                }
                            },
                            success: function (result) {
                                console.log(result);
                                alertify.set('notifier', 'position', 'top-right');
                                //Commented and added by Chetan M on 4th Aug 2020 for Issue ID = 25794
                         <%--var message = '<%= MyBase.GetResourceString("C_Timesheet_Approver_set_successfully") %>';--%>
                                alertify.success('<%= MyBase.GetResourceString("A_IR_Related_Settings") %>');
                                //End of Commented and added by Chetan M on 4th Aug 2020 for Issue ID = 25794
                                //C_IR_Related_Settings_Message
                                GetProjectIRRelaetedSettingsGetDetailsSpecificProject(ProjectID);
                                GetProjectHistroyDetails(ProjectID, 3091, '', '');
                                ShowModifiedByAndField();
                                refreshMyParent();
                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                }
                catch (ex) {
                    //alert(ex.message);
                }
            }

            function GetProjectIRRelaetedSettingsNodeAccess() {

                var irrelatedsettings = {
                    ProjectId: encodeURI(ProjectID),
                    RoleID: encodeURI(RoleID),
                    UserID: encodeURI(UserID),
                    LoginType: encodeURI(LoginType),
                    TagID: 3091

                };
                // console.log(configureApprovers);

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectIRRelaetedSettingsNodeAccess',
                    method: 'Post',
                    data: JSON.stringify(irrelatedsettings),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (irrelatedsettings) {
                            xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                        }
                    },
                    success: function (result) {
                        console.log(result);
                        var SalesCommissionSettingsAccess = result.SalesCommissionSettingsAccess;
                        for (var i = 0; i < SalesCommissionSettingsAccess.length; i++) {
                            SalesCommissionSettingsAddAccess = SalesCommissionSettingsAccess[i]["A"];
                            SalesCommissionSettingsDeleteAccess = SalesCommissionSettingsAccess[i]["D"];
                            SalesCommissionSettingsEditAccess = SalesCommissionSettingsAccess[i]["E"];
                            SalesCommissionSettingsViewAccess = SalesCommissionSettingsAccess[i]["V"];
                        }

                        var IRApproversAccess = result.IRApproversAccess;
                        for (var i = 0; i < IRApproversAccess.length; i++) {
                            IRApproversAddAccess = IRApproversAccess[i]["A"];
                            IRApproversDeleteAccess = IRApproversAccess[i]["D"];
                            IRApproversEditAccess = IRApproversAccess[i]["E"];
                            IRApproversViewAccess = IRApproversAccess[i]["V"];
                        }

                        var InvoiceGeneratorsAccess = result.InvoiceGeneratorsAccess;
                        for (var i = 0; i < InvoiceGeneratorsAccess.length; i++) {
                            InvoiceGeneratorsAddAccess = InvoiceGeneratorsAccess[i]["A"];
                            InvoiceGeneratorsDeleteAccess = InvoiceGeneratorsAccess[i]["D"];
                            InvoiceGeneratorsEditAccess = InvoiceGeneratorsAccess[i]["E"];
                            InvoiceGeneratorsViewAccess = InvoiceGeneratorsAccess[i]["V"];
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            function IRRelatedSettingAccessWisePloting() {

                if (SalesCommissionSettingsEditAccess == "False") {
                    $("#salesCommission > div > a").hide();
                }
                if (SalesCommissionSettingsDeleteAccess == "False") {
                    $("#salesCommission > div > #delete-row").hide();
                }
                if (IRApproversEditAccess == "False") {
                    $("#IRapprover > div > a").hide();
                }
                if (IRApproversDeleteAccess == "False") {
                    $("#IRapprover > div > #delete-row").hide();
                    $("#IRapprover > div > #delete-row1").hide();
                }
                if (InvoiceGeneratorsEditAccess == "False") {
                    $("#invoGen > div > a").hide();
                }
                if (InvoiceGeneratorsDeleteAccess == "False") {
                    $("#invoGen > div > #delete-row").hide();
                    $("#invoGen > div > #delete-row2").hide();
                }
            }

             //Added by Chetan M. on 19th Dec 
            var GblDate = "";
            var GblFieldName = "";
            //End of addition by Chetan M. om 19th Dec 2019

           

             function GetProjectHistroyDetails(ProjectId, TagId, FieldValue, ModifiedBy) {
                //var ProjectId = ProjectId;
                $("#tblIRRelatedSettingsProjectHistory").dataTable().fnDestroy();
                var irrelatedsettings = {
                    ProjectId: encodeURI(ProjectId),
                    TagID: encodeURI(TagId),
                    FieldValue: encodeURI(FieldValue),
                    ModifiedBy: encodeURI(ModifiedBy)

                };
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetProjectHistroyDetails',
                    method: 'Post',
                    data: JSON.stringify(irrelatedsettings),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (irrelatedsettings) {
                            xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                        }
                    },
                    success: function (result) {
                        var ProjectHistroy = result.ProjectHistroyTemp;
                        var strHTML = "";
                        // console.log();
                        $("#tblbdyIRRelatedSettingsProjectHistory").empty();                       
                                   
                        for (var i = 0; i < ProjectHistroy.length; i++) {
                            var FieldName = ProjectHistroy[i]["FieldName"];
                            var ModifiedDate = ProjectHistroy[i]["ModifiedDate"];
                            var Value = ProjectHistroy[i]["Value"];
                            var NewValue = ProjectHistroy[i]["NewValue"];
                            var ModifiedBy = ProjectHistroy[i]["ModifiedBy"];
                            //Added By Usha Pandit On 10.06.2020 For changing caption from BaseCurrency To Billing Currency
                            if (FieldName == "BaseCurrency") {
                                FieldName = "Billing Currency";
                            }
                            //End Of Added By Usha Pandit On 10.06.2020 For changing caption from BaseCurrency To Billing Currency
                            //Added by Chetan M. on 19th Dec 

                            strHTML = "";
                            if (i > 0) {
                                GblDate = ProjectHistroy[i - 1]["ModifiedDate"];;
                                GblFieldName = ProjectHistroy[i - 1]["FieldName"];
                            }                           
                            
                            if (GblDate == ModifiedDate && GblFieldName == FieldName) {
                                
                            }
                            else {
                                if (NewValue != null) {
                                    strHTML += "<tr>"
                                    strHTML += "<td>" + FieldName + "</td>"
                                    strHTML += "<td>" + ModifiedDate + "</td>"
                                    //commented by dipali v on 26th dec 2023 for Handal Null Values
                                    //strHTML += "<td>" + Value + "</td>"
                                    if (Value != null) {
                                        strHTML += "<td>" + Value + "</td>"
                                    } else {
                                        strHTML += "<td></td>"
                                    }
                                    //commented by dipali v on 26th dec 2023 for Handal Null Values
                                    if (NewValue != null) {
                                        strHTML += "<td>" + NewValue + "</td>"
                                    } else {
                                        strHTML += "<td></td>"
                                    }
                                    strHTML += "<td>" + ModifiedBy + "</td>"
                                    strHTML += " </tr>"

                                    $("#tblbdyIRRelatedSettingsProjectHistory").append(strHTML);
                                }
                            } 
                            
                            //End of addition by Chetan M. om 19th Dec 2019
                        }                        
                        
                        stdTable1 = $("#tblIRRelatedSettingsProjectHistory").DataTable({
                            //"scrollY": false,
                            //"scrollX":false,
                            "pageLength": 3,
                            "lengthChange": false,
                            "bFilter": false,
                            //"ordering": true,
                            "ordering": false, //commented by dipali v on 26th dec 2023 for remove ordering clause
                            "responsive": true,
                            "retrieve": true,

                        });

                        stdTable1.columns.adjust().draw();
                        $(".dataTables_scrollHeadInner").css({ "width": "100%" });
                        $(".table ").css({ "width": "100%" });


                        $('.history-wrap').on('shown.bs.collapse', function () {
                            $($.fn.dataTable.tables(true)).DataTable()
                                .columns.adjust();
                        });
                        $('.history-wrap').on('hidden.bs.collapse', function () {
                            $($.fn.dataTable.tables(true)).DataTable()
                                .columns.adjust();
                        });





                        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                            //alert(11);
                            $($.fn.dataTable.tables(true)).DataTable()
                                .columns.adjust();
                        });

                        //Added By Usha Pandit On 11.06.2020 For setting alignment of table if no data exists                        
                        if (ProjectHistroy.length == 0) {
                            $("#tblbdyIRRelatedSettingsProjectHistory tr td").prop("colspan", 5);
                        }
                        //End Of Added By Usha Pandit On 11.06.2020 For setting alignment of table if no data exists

                        //  $("#tblTimesheetHistory").css('width','100%');
                        // $("#tblIRRelatedSettingsProjectHistory ").css('width','100%');


                        //$("#tblTimeshetApprovers ").css('width','100%');


                        //$("#taskclosurtbl").attr("class", "taskclosurtbl");
                        //$("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled").css("outline", "0px");

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }
            //////////////////////////Sales Persons Settings////////////////////

            function GetProjectSalesPersonsDetails(ProjectId) {
                //var ProjectId = ProjectId;
                // $("#tblprojectos").dataTable().fnDestroy();
                var irrelatedsettings = {
                    ProjectId: encodeURI(ProjectId)

                };
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectSalesPersonsDetails',
                    method: 'Post',
                    data: JSON.stringify(irrelatedsettings),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (irrelatedsettings) {
                            xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                        }
                    },
                    success: function (result) {
                        console.log(result);
                        //debugger

                        var SalesPersonsDetails = result.SalesPersonsDetails;
                        var strHTML = "";
                        // console.log();
                        $("#tblbdySalesPersonsDetails").empty();
                        arrProjectSalesPersonIds = [];

                        if (SalesPersonsDetails.length != 0) {


                            for (var i = 0; i < SalesPersonsDetails.length; i++) {
                                var ProjectSalesPersonID = SalesPersonsDetails[i]["ProjectSalesPersonID"];
                                var SalesPersonID = SalesPersonsDetails[i]["SalesPersonID"];
                                var EmployeeName = SalesPersonsDetails[i]["EmployeeName"];
                                var SalesCommissionPercentage = SalesPersonsDetails[i]["SalesCommissionPercentage"];

                                strHTML += " <tr>"
                                if (SalesCommissionSettingsEditAccess == "True") {
                                    strHTML += "<td > <a id='SPID" + ProjectSalesPersonID + "," + SalesPersonID + "," + SalesCommissionPercentage + "' href='javascript:;' onclick='UpdatedSalesPersonsDetails(this.id)' >" + EmployeeName + "</a></td>"
                                } else {
                                    strHTML += "<td > " + EmployeeName + "</td>"
                                }

                                strHTML += "<td>" + SalesCommissionPercentage + "</td>"

                                strHTML += "<td>"
                                strHTML += "             <div class='custom_chckbox'>"
                                strHTML += "<input id='chkSPT" + ProjectSalesPersonID + "' class='chckHead configurechck' type='checkbox' onchange = 'IRRelatedSettingsSPTchkbxclickevent(this.id)'>"
                                strHTML += " <label for='chkSPT" + ProjectSalesPersonID + "'></label>"
                                strHTML += " </div>"
                                strHTML += "</td>"
                                strHTML += "     </tr>"



                            }
                        } else {
                            strHTML += "<tr> <td colspan='3'  height='5'><center>There are no items to show in this view.</center></td> </tr>";
                        }

                        $("#tblbdySalesPersonsDetails").html(strHTML);

                        //$("#tblTimeshetApprovers ").css('width','100%');


                        //$("#taskclosurtbl").attr("class", "taskclosurtbl");
                        //$("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled").css("outline", "0px");

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }


            function BindDropDownListcboSalesPerson(ProjectId, ProjectSalesPersonID) {
                var irrelatedsettings = {
                    ProjectId: encodeURI(ProjectId),
                    ProjectSalesPersonID: encodeURI(ProjectSalesPersonID)

                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectIRRelaetedSettingsDDLSalesPersonsList',
                    method: 'Post',
                    data: JSON.stringify(irrelatedsettings),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (irrelatedsettings) {
                            xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                        }
                    },
                    success: function (result) {
                        console.log(result);

                        var strResult = result.SalesPersonslist;
                        $("#addsales > div > div > div.modal-body > div > div.row > div.form-group.col-sm-6 >select#cboSalesPerson").empty();
                        if (strResult != undefined) {
                            var selHTML = "";
                            //selHTML += "<option  value=0 >--Select Category --</option>";
                            //selHTML += "<option  value=0 >--Select Category --</option>";
                            selHTML += "<option value=0> Select Sales Person </option>";
                            for (var i = 0; i < strResult.length; i++) {
                                ////debugger;
                                var EmployeeID = strResult[i]["EmployeeID"];
                                var EmployeeName = strResult[i]["EmployeeName"];
                                // var ReportingTo = d.ReportingTo;
                                //var EmployeeName = d.EmployeeName;
                                //var Category = d.Category;
                                selHTML += "<option  value='" + EmployeeID + "'  >" + EmployeeName + "</option>";
                            }
                            // StopAjaxLoader("#bodyIssueList");

                            // $("#txtPhaseFilterResponsiblePerson").html(selHTML);
                            $("#addsales > div > div > div.modal-body > div > div.row > div.form-group.col-sm-6 >select#cboSalesPerson").html(selHTML);
                            //$("#addsales > div > div > div.modal-body > div > div.row > div.form-group.col-sm-6 >select#cboSalesPerson").addClass("selectpicker");


                        }
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        $('#tblSalesPersonsDetails > thead > tr > th.sm-wid>div.custom_chckbox>input#resourceAll').prop('checked', false);

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });


            }
            function IRRelatedSettingsSalesPersonbtnAddClick() {
                $("#addsales > div > div > div.modal-body > div > div.row > div>input#txtSalesCommission").val('');
                $("#spnIRRelatedSettingProjectSalesPersonID").removeAttr("value");
                $('#spnIRRelatedSettingProjectSalesPersonID').attr('value', 0);
                // AddOption();
                BindDropDownListcboSalesPerson(ProjectID, 0);
                $("#addsales").modal("show");

            }

            function IRRelatedSettingsAddSalesPersonModelbtnCloseClick() {
                $("#spnIRRelatedSettingProjectSalesPersonID").removeAttr("value");
                $("#addsales > div > div > div.modal-body > div > div.row > div>input#txtSalesCommission").val('');
                //$('#spnIRRelatedSettingProjectSalesPersonID').attr('value', 0);
                // AddOption();
                //BindDropDownListcboSalesPerson(ProjectID, 0);
                $("#addsales").modal("hide"); //Commented By Dipali V On 20th May 2020 For Issue ID 23055

            }
            function IRRelatedSettingsAddSalesPersonModelbtnSaveClick() {
                var flag = true;
                var ProjectSalesPersonID = $("#spnIRRelatedSettingProjectSalesPersonID").attr("value");
                var SalesPersonID = $("#addsales > div > div > div.modal-body > div > div.row > div.form-group.col-sm-6 >select#cboSalesPerson option:selected").val();
                var SalesCommissionPercentage = $("#addsales > div > div > div.modal-body > div > div.row > div>input#txtSalesCommission").val();

                if (SalesPersonID == 0) {
                    //IRRelatedSettingsAddSalesPersonModelbtnCloseClick();
                    alertify.set('notifier', 'position', 'top-right');
                    // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                    alertify.error("Please Select Sales Person");
                    //alertify.error(message);
                    $("#addsales > div > div > div.modal-body > div > div.row > div.form-group.col-sm-6 >select#cboSalesPerson").focus();
                    flag = false;
                    return false;
                }

                if (SalesCommissionPercentage.length == 0) {
                    //IRRelatedSettingsAddSalesPersonModelbtnCloseClick();
                    alertify.set('notifier', 'position', 'top-right');
                    // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                    alertify.error("Please Enter Sales Commission Percentage");
                    //alertify.error(message);
                    $("#addsales > div > div > div.modal-body > div > div.row > div>input#txtSalesCommission").focus();
                    flag = false;
                    return false;
                }

                //Added By Reshma Chavan on 24th Oct 2020 For Sales Commission Validation greater than 100
                 if (SalesCommissionPercentage > 100) {                    
                    alertify.set('notifier', 'position', 'top-right');                  
                    alertify.error("The value of 'Sales Commission (%)' should be in the range of (1-100).");                   
                    $("#addsales > div > div > div.modal-body > div > div.row > div>input#txtSalesCommission").focus();
                    flag = false;
                    return false;
                }
                 //End of Added By Reshma Chavan on 24th Oct 2020 For Sales Commission Validation greater than 100
                var result = isNormalInteger(SalesCommissionPercentage);

                if (result == false || parseFloat(SalesCommissionPercentage) < 0.0) {
                    //IRRelatedSettingsAddSalesPersonModelbtnCloseClick();
                    alertify.set('notifier', 'position', 'top-right');
                    // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                    alertify.error("Please Enter Positive Integer Value");
                    //alertify.error(message);
                    $("#addsales > div > div > div.modal-body > div > div.row > div>input#txtSalesCommission").focus();
                    flag = false;
                    return false;
                }
                if (flag == true) {

                    var irrelatedsettings = {
                        ProjectId: encodeURI(ProjectID),
                        ProjectSalesPersonID: encodeURI(ProjectSalesPersonID),
                        SalesPersonID: encodeURI(SalesPersonID),
                        SalesCommissionPercentage: encodeURI(SalesCommissionPercentage)

                    };
					StartLoader("#BodyIRSettings");
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectIRRelaetedSettingsInsertOrUpdateSalesPersons',
                        method: 'Post',
                        data: JSON.stringify(irrelatedsettings),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (irrelatedsettings) {
                                xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                            }
                        },
                        success: function (result) {
                            console.log(result);
                            alertify.set('notifier', 'position', 'top-right');
                            // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                            if (ProjectSalesPersonID == 0) {
                                alertify.success("Sales Commission Settings Saved Successfully");
                            } else {
                                alertify.success("Sales Commission Settings Updated Successfully");
                            }

                            IRRelatedSettingsAddSalesPersonModelbtnCloseClick();
                            GetProjectSalesPersonsDetails(ProjectID);
                            //Added By Usha Pandit On 12.06.2020 For refreshing Sales Person drop down on save
                            BindDropDownListcboSalesPerson(ProjectID, SalesPersonID);
                            //End Of Added By Usha Pandit On 12.06.2020 For refreshing Sales Person drop down on save
							StopAjaxLoader("#BodyIRSettings");
                        },
                        error: function (err) {
							StopAjaxLoader("#BodyIRSettings");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });



                }

            }

            function isNormalInteger(str) {
                return /^[-+]?[0-9]*\.?[0-9]+$/.test(str);
            }

            function UpdatedSalesPersonsDetails(id) {
                //SPID11,467,11.25
                //alert(id);
                $("#addsales > div > div > div.modal-body > div > div.row > div>input#txtSalesCommission").val('');
                var updtID = id;
                updtID = updtID.replace('SPID', '');
                var value = updtID.split(',');
                console.log(value);
                $("#spnIRRelatedSettingProjectSalesPersonID").removeAttr("value");
                var ProjectSalesPersonID = parseInt(value[0]);
                BindDropDownListcboSalesPerson(ProjectID, ProjectSalesPersonID);
                $('#spnIRRelatedSettingProjectSalesPersonID').attr('value', value[0]);
                var EmpID = parseInt(value[1]);
                $("#addsales > div > div > div.modal-body > div > div.row > div.form-group.col-sm-6 >select#cboSalesPerson option[value='" + EmpID + "']").prop('selected', true);
                $("#addsales > div > div > div.modal-body > div > div.row > div>input#txtSalesCommission").val(value[2]);
                $("#addsales").modal("show");
            }

            var arrProjectSalesPersonIds = [];
            function tblSalesPersonsDetailsCheckBoxChecked() {

                $('#tblSalesPersonsDetails > tbody> tr').each(function (index, value) {
                    // //debugger
                    var message = "";
                    //var File;
                    //var Date = "";
                    var allColumns = $(this).find('td');

                    $(allColumns).each(function (i, v) {

                        //console.log(this);

                        if (i == 2) {
                            var id = $(this).find('input[type=checkbox]').attr("id");
                            // console.log(id);


                            if ($(this).find('input[type="checkbox"]').is(':checked')) {
                                //console.log("checked");
                                id = id.replace('chkSPT', '');
                                id = parseInt(id);
                                //var search_value = id;
                                if (arrProjectSalesPersonIds.indexOf(id) == -1) {

                                    arrProjectSalesPersonIds.push(id);
                                }

                            }
                            //console.log(id);

                        }

                    });
                });
            }

            function IRRelatedSettingsSPTchkbxclickevent(id) {
                IRRelatedSettingsSPTAllchkbxchekedoruncheckd();
            }
            function IRRelatedSettingsSPTAllchkbxchekedoruncheckd() {
                var ck_box_cnt = $('#tblbdySalesPersonsDetails input[type="checkbox"]').length;
                var chk_box_checked_cnt = $('#tblbdySalesPersonsDetails input[type="checkbox"]:checked').length;
                if (ck_box_cnt == chk_box_checked_cnt) {
                    $('#tblSalesPersonsDetails > thead > tr > th.sm-wid>div.custom_chckbox>input#resourceAll').prop('checked', true);
                } else {
                    $('#tblSalesPersonsDetails > thead > tr > th.sm-wid>div.custom_chckbox>input#resourceAll').prop('checked', false);
                }
            }

            function IRRelatedSettingsSalesPersonbtnDeleteClick() {
                tblSalesPersonsDetailsCheckBoxChecked();
                if (arrProjectSalesPersonIds.length == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                   // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';

                    alertify.error("Please Select Atleast One Record To Delete.");
                } else {
                    $("#deleteProjectIRRelatedSettingsSalesPersoninfomodal").modal('show');
                }

            }
            function cancelProjectIRRelatedSettingsSalesPersonDelted() {
                arrProjectSalesPersonIds = [];
                $("#deleteProjectIRRelatedSettingsSalesPersoninfomodal").modal('hide');
            }
            function DeleteProjectIRRelatedSettingsSalesPersonData() {
                //var irrelatedsettings = {
                //        ProjectId: encodeURI(ProjectID),
                //        ProjectSalesPersonID: encodeURI(ProjectSalesPersonID),
                //        SalesPersonID: encodeURI(SalesPersonID),
                //    SalesCommissionPercentage: encodeURI(SalesCommissionPercentage)
                //        //ProjectSalesPersonIDs

                //    };
                //console.log(arrProjectSalesPersonIds);
                var irrelatedsettings = {

                    ProjectSalesPersonIDs: arrProjectSalesPersonIds

                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectIRRelaetedSettingsDeleteSalesPersons',
                    method: 'Post',
                    data: JSON.stringify(irrelatedsettings),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        //if (irrelatedsettings) {
                        //    xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                        //}
                    },
                    success: function (result) {
                        console.log(result);
                        alertify.set('notifier', 'position', 'top-right');
                        // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                        if (result != null && result != undefined && result != "") {
                            
                            if (result.toString().indexOf("deleted successfully") != -1) {
                                alertify.success(result);
                            }
                            else {
                                alertify.error(result);
                            }
                        }
                        cancelProjectIRRelatedSettingsSalesPersonDelted();
                        //IRRelatedSettingsAddSalesPersonModelbtnCloseClick();
                        GetProjectSalesPersonsDetails(ProjectID);
                        $('#tblSalesPersonsDetails > thead > tr > th.sm-wid>div.custom_chckbox>input#resourceAll').prop('checked', false);


                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }

            ////////////////////IR Approvers//////////////////////////////////////////

            function GetProjectIRApproversDetails(ProjectId) {
                //var ProjectId = ProjectId;
                // $("#tblprojectos").dataTable().fnDestroy();
                var irrelatedsettings = {
                    ProjectId: encodeURI(ProjectId)

                };
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectIRApproversDetails',
                    method: 'Post',
                    data: JSON.stringify(irrelatedsettings),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (irrelatedsettings) {
                            xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                        }
                    },
                    success: function (result) {
                        console.log(result);
                        //debugger

                        var IRApprovers = result.IRApprovers;
                        var strHTML = "";
                        // console.log();
                        $("#tblbdyIRApprovers").empty();
                        arrProjectIRApproversIds = [];
                       // debugger;
                        if (IRApprovers.length != 0) {
                            for (var i = 0; i < IRApprovers.length; i++) {
                                var ID = IRApprovers[i]["ID"];
                                var ApproverID = IRApprovers[i]["ApproverID"];
                                var UserName = IRApprovers[i]["UserName"];
                                
                                //var SalesCommissionPercentage = SalesPersonsDetails[i]["SalesCommissionPercentage"];
                                if (ApproverID != 0) {//Added By Dipali V On 9th Nov 2023 For IR Approver
                                    strHTML += " <tr>"
                                    if (IRApproversEditAccess == "True") {
                                        strHTML += "<td > <a id='IRAID" + ID + "," + ApproverID + "' href='javascript:;' onclick='UpdatedIRApproversDetails(this.id)' >" + UserName + "</a></td>"
                                    } else {
                                        strHTML += "<td > " + UserName + "</td>"
                                    }

                                    //strHTML += "<td>" + SalesCommissionPercentage + "</td>"

                                    strHTML += "<td>"
                                    strHTML += "             <div class='custom_chckbox'>"
                                    strHTML += "<input id='chkIRA" + ID + "' class='chckHead configurechck' type='checkbox' onchange = 'IRRelatedSettingsIRAchkbxclickevent(this.id)'>"
                                    strHTML += " <label for='chkIRA" + ID + "'></label>"
                                    strHTML += " </div>"
                                    strHTML += "</td>"
                                    strHTML += "     </tr>"

                                }
                                else { //Added By Dipali V On 9th Nov 2023 For IR Approver
                                    strHTML += "<tr> <td colspan='2'  height='5'><center>There are no items to show in this view.</center></td> </tr>";
                                }

                            }
                        } else {
                            strHTML += "<tr> <td colspan='2'  height='5'><center>There are no items to show in this view.</center></td> </tr>";
                        }

                        $("#tblbdyIRApprovers").html(strHTML);

                        //$("#tblTimeshetApprovers ").css('width','100%');


                        //$("#taskclosurtbl").attr("class", "taskclosurtbl");
                        //$("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled").css("outline", "0px");

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            function BindDropDownListcboIRApprovers(ProjectId, ID) {
                var irrelatedsettings = {
                    ProjectId: encodeURI(ProjectId),
                    ID: encodeURI(ID)

                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectIRRelaetedSettingsDDLRole_RFIApproverList',
                    method: 'Post',
                    data: JSON.stringify(irrelatedsettings),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (irrelatedsettings) {
                            xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                        }
                    },
                    success: function (result) {
                        console.log(result);

                        var strResult = result.Role_RFIApprover;
                        $("#addIR > div > div > div.modal-body > div > div.row > div>select#cboIRApprovers").empty();
                        if (strResult != undefined) {
                            var selHTML = "";
                            //selHTML += "<option  value=0 >--Select Category --</option>";
                            //selHTML += "<option  value=0 >--Select Category --</option>";
                            selHTML += "<option value = 0> Select IR Approver</option>";
                            for (var i = 0; i < strResult.length; i++) {
                                ////debugger;
                                var EmployeeID = strResult[i]["EmployeeID"];
                                var UserName = strResult[i]["UserName"];
                                // var ReportingTo = d.ReportingTo;
                                //var EmployeeName = d.EmployeeName;
                                //var Category = d.Category;
                                selHTML += "<option  value='" + EmployeeID + "'  >" + UserName + "</option>";
                            }
                            // StopAjaxLoader("#bodyIssueList");

                            // $("#txtPhaseFilterResponsiblePerson").html(selHTML);
                            $("#addIR > div > div > div.modal-body > div > div.row > div>select#cboIRApprovers").html(selHTML);
                            //$("#addsales > div > div > div.modal-body > div > div.row > div.form-group.col-sm-6 >select#cboSalesPerson").addClass("selectpicker");


                        }
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        $('#tblIRApprovers > thead > tr > th.sm-wid > div>input#innIrAll').prop('checked', false);

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });


            }

            function IRRelatedSettingsIRApproversbtnAddClick() {

                $("#spnIRRelatedSettingProjectIRApproversID").removeAttr("value");
                $('#spnIRRelatedSettingProjectIRApproversID').attr('value', 0);
                // AddOption();
                BindDropDownListcboIRApprovers(ProjectID, 0);
                $("#addIR").modal("show");

            }

            function IRRelatedSettingsAddIRApproversModelbtnCloseClick() {
                $("#spnIRRelatedSettingProjectIRApproversID").removeAttr("value");
                //$("#addsales > div > div > div.modal-body > div > div.row > div>input#txtSalesCommission").val('');
                //$('#spnIRRelatedSettingProjectSalesPersonID').attr('value', 0);
                // AddOption();
                //BindDropDownListcboSalesPerson(ProjectID, 0);
                $("#addIR").modal("hide");

            }

            function IRRelatedSettingsAddIRApproversModelbtnSaveClick() {
                var flag = true;
                var ID = $("#spnIRRelatedSettingProjectIRApproversID").attr("value");
                var ApproverID = $("#addIR > div > div > div.modal-body > div > div.row > div>select#cboIRApprovers option:selected").val();
                
                if (ApproverID == 0) {
                    
                    alertify.set('notifier', 'position', 'top-right');
                   // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                 alertify.error("Please Select IR Approver");
                 //alertify.error(message);
                    $("#cboIRApprovers").focus();
                 //$("#addIR > div > div > div.modal-body > div > div.row > div > div > select#cboIRApprovers").focus();
                 flag = false;
                 return false;
             }


             if (flag == true) {

                 var irrelatedsettings = {
                     ProjectId: encodeURI(ProjectID),
                     ID: encodeURI(ID),
                     ApproverID: encodeURI(ApproverID)

                 };
				 StartLoader("#BodyIRSettings");
                 $.ajax({
                     url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectIRRelaetedSettingsInsertOrUpdateIRApprovers',
                     method: 'Post',
                     data: JSON.stringify(irrelatedsettings),
                     dataType: 'json',
                     async: false,
                     contentType: "application/json",
                     beforeSend: function (xhr) {
                         xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                         if (irrelatedsettings) {
                             xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                         }
                     },
                     success: function (result) {
                         console.log(result);
                         alertify.set('notifier', 'position', 'top-right');
                         // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                         if (ID == 0) {
                             alertify.success("IR Approver Saved Successfully");
                         } else {
                             alertify.success("IR Approver Updated Successfully");
                         }

                         IRRelatedSettingsAddIRApproversModelbtnCloseClick();
                         GetProjectIRApproversDetails(ProjectID);
                         //Added By Usha Pandit On 12.06.2020 For refreshing Sales Person drop down on save
                         BindDropDownListcboIRApprovers(ProjectID, ID);
                        //End Of Added By Usha Pandit On 12.06.2020 For refreshing Sales Person drop down on save
						StopAjaxLoader("#BodyIRSettings");
                         refreshMyParent();
                     },
                     error: function (err) {
						 StopAjaxLoader("#BodyIRSettings");
                         window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                     }
                 });

                }

            }


            function UpdatedIRApproversDetails(id) {
                //SPID11,467,11.25
                //alert(id);

                var updtID = id;
                updtID = updtID.replace('IRAID', '');
                var value = updtID.split(',');
                console.log(value);
                $("#spnIRRelatedSettingProjectIRApproversID").removeAttr("value");
                var ID = parseInt(value[0]);
                BindDropDownListcboIRApprovers(ProjectID, ID);
                $('#spnIRRelatedSettingProjectIRApproversID').attr('value', value[0]);
                var EmpID = parseInt(value[1]);
                $("#addIR > div > div > div.modal-body > div > div.row > div>select#cboIRApprovers option[value='" + EmpID + "']").prop('selected', true);

                $("#addIR").modal("show");
            }

            var arrProjectIRApproversIds = [];

            function tblIRApproversDetailsCheckBoxChecked() {

                $('#tblIRApprovers > tbody> tr').each(function (index, value) {
                    // //debugger
                    var message = "";
                    //var File;
                    //var Date = "";
                    var allColumns = $(this).find('td');

                    $(allColumns).each(function (i, v) {

                        //console.log(this);

                        if (i == 1) {
                            var id = $(this).find('input[type=checkbox]').attr("id");
                            // console.log(id);


                            if ($(this).find('input[type="checkbox"]').is(':checked')) {
                                //console.log("checked");
                                id = id.replace('chkIRA', '');
                                id = parseInt(id);
                                //var search_value = id;
                                if (arrProjectIRApproversIds.indexOf(id) == -1) {

                                    arrProjectIRApproversIds.push(id);
                                }

                            }
                            //console.log(id);

                        }

                    });
                });
            }

            function IRRelatedSettingsIRAchkbxclickevent(id) {
                IRRelatedSettingsIARAllchkbxchekedoruncheckd();
            }
            function IRRelatedSettingsIARAllchkbxchekedoruncheckd() {
                var ck_box_cnt = $('#tblbdyIRApprovers input[type="checkbox"]').length;
                var chk_box_checked_cnt = $('#tblbdyIRApprovers input[type="checkbox"]:checked').length;
                if (ck_box_cnt == chk_box_checked_cnt) {
                    $('#tblIRApprovers > thead > tr > th.sm-wid > div>input#innIrAll').prop('checked', true);
                } else {
                    $('#tblIRApprovers > thead > tr > th.sm-wid > div>input#innIrAll').prop('checked', false);
                }
            }

            function IRRelatedSettingsIRApproversbtnDeleteClick() {
                tblIRApproversDetailsCheckBoxChecked();
                if (arrProjectIRApproversIds.length == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                   // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';

                    alertify.error("Please Select Atleat One Record To Delete");
                } else {
                    $("#deleteProjectIRRelatedSettingsIRApproversinfomodal").modal('show');
                }

            }
            function cancelProjectIRRelatedSettingsIRApproversDeleted() {
                arrProjectIRApproversIds = [];
                $("#deleteProjectIRRelatedSettingsIRApproversinfomodal").modal('hide');
            }
            function DeleteProjectIRRelatedSettingsIRApproversData() {

                var irrelatedsettings = {

                    IDs: arrProjectIRApproversIds

                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectIRRelaetedSettingsDeleteIRApprovers',
                    method: 'Post',
                    data: JSON.stringify(irrelatedsettings),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        //if (irrelatedsettings) {
                        //    xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                        //}
                    },
                    success: function (result) {
                        console.log(result);
                        alertify.set('notifier', 'position', 'top-right');
                        // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';

                        alertify.success("IR Approver Deleted Successfully");

                        cancelProjectIRRelatedSettingsIRApproversDeleted();
                        //IRRelatedSettingsAddSalesPersonModelbtnCloseClick();
                        GetProjectIRApproversDetails(ProjectID);
                        $('#tblIRApprovers > thead > tr > th.sm-wid > div>input#innIrAll').prop('checked', false);
                        refreshMyParent();
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }

            //////////////////////////////////////////Invoice Generator ///////////////////////////////////

            function GetProjectInvoiceGeneratorDetails(ProjectId) {
                //var ProjectId = ProjectId;
                // $("#tblprojectos").dataTable().fnDestroy();
                var irrelatedsettings = {
                    ProjectId: encodeURI(ProjectId)

                };
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectInvoiceGeneratorsDetails',
                    method: 'Post',
                    data: JSON.stringify(irrelatedsettings),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (irrelatedsettings) {
                            xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                        }
                    },
                    success: function (result) {
                        console.log(result);
                        //debugger

                        var InvoiceGenerators = result.InvoiceGenerators;
                        var strHTML = "";
                        // console.log();
                        $("#tblbdyInvoiceGenerator").empty();
                        arrProjectInvoiceGeneratorIds = [];

                        if (InvoiceGenerators.length != 0) {


                            for (var i = 0; i < InvoiceGenerators.length; i++) {
                                var ID = InvoiceGenerators[i]["ID"];
                                var GeneratorID = InvoiceGenerators[i]["GeneratorID"];
                                var UserName = InvoiceGenerators[i]["UserName"];
                                //var SalesCommissionPercentage = SalesPersonsDetails[i]["SalesCommissionPercentage"];
                                if (GeneratorID != 0) {
                                    //Added By Dipali V On 9th Nov 2023 For IR Approver
                                    strHTML += " <tr>"
                                    if (InvoiceGeneratorsEditAccess == "True") {
                                        strHTML += "<td > <a id='IGID" + ID + "," + GeneratorID + "' href='javascript:;' onclick='UpdatedInvoiceGeneratorsDetails(this.id)' >" + UserName + "</a></td>"
                                    } else {
                                        strHTML += "<td > " + UserName + "</td>"
                                    }

                                    //strHTML += "<td>" + SalesCommissionPercentage + "</td>"

                                    strHTML += "<td>"
                                    strHTML += "             <div class='custom_chckbox'>"
                                    strHTML += "<input id='chkIG" + ID + "' class='chckHead configurechck' type='checkbox' onchange = 'IRRelatedSettingsIGchkbxclickevent(this.id)'>"
                                    strHTML += " <label for='chkIG" + ID + "'></label>"
                                    strHTML += " </div>"
                                    strHTML += "</td>"
                                    strHTML += "     </tr>"



                                }
                                else {
                                    strHTML += "<tr> <td colspan='2'  height='5'><center>There are no items to show in this view.</center></td> </tr>";
                                }
                            }
                            
                        } else {
                            strHTML += "<tr> <td colspan='2'  height='5'><center>There are no items to show in this view.</center></td> </tr>";
                        }

                        $("#tblbdyInvoiceGenerator").html(strHTML);

                        //$("#tblTimeshetApprovers ").css('width','100%');


                        //$("#taskclosurtbl").attr("class", "taskclosurtbl");
                        //$("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled").css("outline", "0px");

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            function BindDropDownListcboInvoiceGenerator(ProjectId, ID) {
                var irrelatedsettings = {
                    ProjectId: encodeURI(ProjectId),
                    ID: encodeURI(ID)

                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectIRRelaetedSettingsDDLAccountPersonList',
                    method: 'Post',
                    data: JSON.stringify(irrelatedsettings),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (irrelatedsettings) {
                            xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                        }
                    },
                    success: function (result) {
                        console.log(result);

                        var strResult = result.PM_AccountPersonList;
                        $("#addInvoice > div > div > div.modal-body > div > div.row > div>select#cboInvoiceGenerator").empty();
                        if (strResult != undefined) {
                            var selHTML = "";
                            //selHTML += "<option  value=0 >--Select Category --</option>";
                            //selHTML += "<option  value=0 >--Select Category --</option>";
                            selHTML += "<option value=0> Select Invoice Generator </option>";
                            for (var i = 0; i < strResult.length; i++) {
                                ////debugger;
                                var EmployeeID = strResult[i]["EMPLOYEEID"];
                                var UserName = strResult[i]["USERNAME"];
                                // var ReportingTo = d.ReportingTo;
                                //var EmployeeName = d.EmployeeName;
                                //var Category = d.Category;
                                selHTML += "<option  value='" + EmployeeID + "'  >" + UserName + "</option>";
                            }
                            // StopAjaxLoader("#bodyIssueList");

                            // $("#txtPhaseFilterResponsiblePerson").html(selHTML);
                            $("#addInvoice > div > div > div.modal-body > div > div.row > div>select#cboInvoiceGenerator").html(selHTML);
                            //$("#addsales > div > div > div.modal-body > div > div.row > div.form-group.col-sm-6 >select#cboSalesPerson").addClass("selectpicker");


                        }
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        $('#tblInvoiceGenerator > thead > tr > th.sm-wid > div>input#innInvoGenAll').prop('checked', false);

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });


            }


            function IRRelatedSettingsInvoiceGeneratorbtnAddClick() {

                $("#spnIRRelatedSettingProjectInvoiceGeneratorsID").removeAttr("value");
                $('#spnIRRelatedSettingProjectInvoiceGeneratorsID').attr('value', 0);
                // AddOption();
                BindDropDownListcboInvoiceGenerator(ProjectID, 0);
                $("#addInvoice").modal("show");

            }

            function IRRelatedSettingsAddInvoiceGeneratorModelbtnCloseClick() {
                $("#spnIRRelatedSettingProjectInvoiceGeneratorsID").removeAttr("value");
                //$("#addsales > div > div > div.modal-body > div > div.row > div>input#txtSalesCommission").val('');
                //$('#spnIRRelatedSettingProjectSalesPersonID').attr('value', 0);
                // AddOption();
                //BindDropDownListcboSalesPerson(ProjectID, 0);
                $("#addInvoice").modal("hide");

            }


            function IRRelatedSettingsAddInvoiceGeneratorModelbtnSaveClick() {
                var flag = true;
                var ID = $("#spnIRRelatedSettingProjectInvoiceGeneratorsID").attr("value");
                var GeneratorID = $("#addInvoice > div > div > div.modal-body > div > div.row > div>select#cboInvoiceGenerator option:selected").val();



                if (GeneratorID == 0) {                    
                    alertify.set('notifier', 'position', 'top-right');
                   // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                alertify.error("Please Select  Invoice Generator");
                //alertify.error(message);
                $("#addInvoice > div > div > div.modal-body > div > div.row > div>select#cboInvoiceGenerator").focus();
                flag = false;
                return false;
            }


            if (flag == true) {


                var irrelatedsettings = {
                    ProjectId: encodeURI(ProjectID),
                    ID: encodeURI(ID),
                    GeneratorID: encodeURI(GeneratorID),

                    UserID: encodeURI(UserID),//Added By Dipali V On 16th Nov 2023 For Capture History

                };
				StartLoader("#BodyIRSettings");
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectIRRelaetedSettingsInsertOrUpdateInvoiceGenerators',
                    method: 'Post',
                    data: JSON.stringify(irrelatedsettings),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (irrelatedsettings) {
                            xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                        }
                    },
                    success: function (result) {
                        console.log(result);
                        alertify.set('notifier', 'position', 'top-right');
                   // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                            if (ID == 0) {
                                alertify.success("Invoice Generators Saved Successfully");
                            } else {
                                alertify.success("Invoice Generators Updated Successfully");
                            }

                            IRRelatedSettingsAddInvoiceGeneratorModelbtnCloseClick();
                            GetProjectInvoiceGeneratorDetails(ProjectID);
							StopAjaxLoader("#BodyIRSettings");
                        },
                        error: function (err) {
							StopAjaxLoader("#BodyIRSettings");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });



                }

            }

            function UpdatedInvoiceGeneratorsDetails(id) {
                //SPID11,467,11.25
                //alert(id);

                var updtID = id;
                updtID = updtID.replace('IGID', '');
                var value = updtID.split(',');
                console.log(value);
                $("#spnIRRelatedSettingProjectInvoiceGeneratorsID").removeAttr("value");
                var ID = parseInt(value[0]);
                BindDropDownListcboInvoiceGenerator(ProjectID, ID);
                $('#spnIRRelatedSettingProjectInvoiceGeneratorsID').attr('value', value[0]);
                var EmpID = parseInt(value[1]);
                $("#addInvoice > div > div > div.modal-body > div > div.row > div>select#cboInvoiceGenerator option[value='" + EmpID + "']").prop('selected', true);

                $("#addInvoice").modal("show");
            }

            var arrProjectInvoiceGeneratorIds = [];

            function tblInvoiceGeneratorDetailsCheckBoxChecked() {

                $('#tblInvoiceGenerator > tbody> tr').each(function (index, value) {
                    // //debugger
                    var message = "";
                    //var File;
                    //var Date = "";
                    var allColumns = $(this).find('td');

                    $(allColumns).each(function (i, v) {

                        //console.log(this);

                        if (i == 1) {
                            var id = $(this).find('input[type=checkbox]').attr("id");
                            // console.log(id);


                            if ($(this).find('input[type="checkbox"]').is(':checked')) {
                                //console.log("checked");
                                id = id.replace('chkIG', '');
                                id = parseInt(id);
                                //var search_value = id;
                                if (arrProjectInvoiceGeneratorIds.indexOf(id) == -1) {

                                    arrProjectInvoiceGeneratorIds.push(id);
                                }

                            }
                            //console.log(id);

                        }

                    });
                });
            }

            function IRRelatedSettingsIGchkbxclickevent(id) {
                IRRelatedSettingsIGAllchkbxchekedoruncheckd();
            }
            function IRRelatedSettingsIGAllchkbxchekedoruncheckd() {
                var ck_box_cnt = $('#tblbdyInvoiceGenerator input[type="checkbox"]').length;
                var chk_box_checked_cnt = $('#tblbdyInvoiceGenerator input[type="checkbox"]:checked').length;
                if (ck_box_cnt == chk_box_checked_cnt) {
                    $('#tblInvoiceGenerator > thead > tr > th.sm-wid > div>input#innInvoGenAll').prop('checked', true);
                } else {
                    $('#tblInvoiceGenerator > thead > tr > th.sm-wid > div>input#innInvoGenAll').prop('checked', false);
                }
            }

            function IRRelatedSettingsInvoiceGeneratorbtnDeleteClick() {
                tblInvoiceGeneratorDetailsCheckBoxChecked();
                if (arrProjectInvoiceGeneratorIds.length == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                   // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';

                    alertify.error("Please Select Atleast One Record To Delete.");
                } else {
                    $("#deleteProjectIRRelatedSettingsInvoiceGeneratorsinfomodal").modal('show');
                }

            }
            function cancelProjectIRRelatedSettingsInvoiceGeneratorsDeleted() {
                arrProjectInvoiceGeneratorIds = [];
                $("#deleteProjectIRRelatedSettingsInvoiceGeneratorsinfomodal").modal('hide');
            }
            function DeleteProjectIRRelatedSettingsInvoiceGeneratorsData() {

                var irrelatedsettings = {

                    IDs: arrProjectInvoiceGeneratorIds

                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings//GetProjectIRRelaetedSettingsDeleteInvoiceGenerators',
                    method: 'Post',
                    data: JSON.stringify(irrelatedsettings),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        //if (irrelatedsettings) {
                        //    xhr.setRequestHeader("Params", encryptString(isJson(irrelatedsettings) ? irrelatedsettings : JSON.stringify(irrelatedsettings)));
                        //}
                    },
                    success: function (result) {
                        console.log(result);
                        alertify.set('notifier', 'position', 'top-right');
                   // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';

                        alertify.success("Invoice Generator Deleted Successfully");

                        cancelProjectIRRelatedSettingsInvoiceGeneratorsDeleted();
                        //IRRelatedSettingsAddSalesPersonModelbtnCloseClick();
                        GetProjectInvoiceGeneratorDetails(ProjectID);
                        $('#tblInvoiceGenerator > thead > tr > th.sm-wid > div>input#innInvoGenAll').prop('checked', false);


                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }

            function cboIRRelatedSettingsModifiedFieldOrModifiedBy() {
                GblDate = "";
                GblFieldName = "";
                var ModifiedField = $('#IRhistoryMain > div.row.form-group.pl-30 > div>select#cboIRRelatedSettingsModifiedField option:selected').val();
                var ModifiedBy = $('#IRhistoryMain > div.row.form-group.pl-30 > div>select#cboIRRelatedSettingsModifiedBy option:selected').val();
                GetProjectHistroyDetails(ProjectID, 3091, ModifiedField, ModifiedBy);
            }

            //Added By Rutuja D. 6 Jan 2020 For Modified Firld Drop Down Binding            

            function ShowModifiedByAndField() {
                FillModifiedFieldCombo();
                FillModifiedByCombo();
            }
            function FillModifiedFieldCombo()
            {
                var projectosdata = {
                    ProjectID: ProjectID
                } 
                $.ajax({                  
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/FillModifiedFieldCombo',
                    type: "POST",
                    data: JSON.stringify(projectosdata),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (projectosdata) {
                            xhr.setRequestHeader("Params", encryptString(isJson(projectosdata) ? projectosdata : JSON.stringify(projectosdata)));
                        }
                    },
                    success: function (result) {                        
                        var objCboOU = document.getElementById('cboIRRelatedSettingsModifiedField');
                        if (objCboOU != null) {
                            $("#cboIRRelatedSettingsModifiedField").empty();
                            $("#cboIRRelatedSettingsModifiedField").append('<option value="">Select Modified Field</option>');
                            for (var i = 0; i < result.length; i++) {
                                var ObjStatus = result[i];
                                var objOption = document.createElement("OPTION");
                                objCboOU.options.add(objOption);
                                objOption.text = ObjStatus.FieldName;
                            }
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }

            function FillModifiedByCombo() {
                //Commented and Added By RehanC for incorrect parameter passed(ProjectId) on 5th April 2023
                //var projectosdata = {
                //    ProjectID: ProjectId
                //}
                var projectosdata = parseInt(ProjectID);
                //End of Comment by RehanC on 5th April 2023
                $.ajax({                  
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/FillModifiedByCombo',
                    type: "POST",
                    data: JSON.stringify(projectosdata),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (projectosdata) {
                            xhr.setRequestHeader("Params", encryptString(isJson(projectosdata) ? projectosdata : JSON.stringify(projectosdata)));
                        }
                    },
                    success: function (result) {                        
                        var objCboOU = document.getElementById('cboIRRelatedSettingsModifiedBy');
                        if (objCboOU != null) {
                            $("#cboIRRelatedSettingsModifiedBy").empty();
                            $("#cboIRRelatedSettingsModifiedBy").append('<option value="">Select Modified By</option>');
                            for (var i = 0; i < result.length; i++) {
                                var ObjStatus = result[i];
                                var objOption = document.createElement("OPTION");
                                objCboOU.options.add(objOption);
                                objOption.text = ObjStatus.ModifiedBy;
                            }
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }

            //End Added By Rutuja D. 6 Jan 2020 For Modified Firld Drop Down Binding
            //Added By Omkar P On 15.01.2020 For showing current project name
            function getProjectName(ProjectId) {
                //var ProjectId = ProjectId;
                var projectosdata = {
                    ProjectID: ProjectId
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetProjectName',
                    method: 'Post',
                    data: JSON.stringify(projectosdata),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (projectosdata) {
                            xhr.setRequestHeader("Params", encryptString(isJson(projectosdata) ? projectosdata : JSON.stringify(projectosdata)));
                        }
                    },
                    success: function (result) {
                        //console.log(result);
                        $("#spnProjectName").text(result);

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }
            //End Of Added By Omkar P On 15.01.2020 For showing current project name
            $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                $($.fn.dataTable.tables(true)).DataTable()
                    .columns.adjust();
            });
            $('a[data-bs-toggle="collapse"]').on('shown.bs.tab', function (e) {
                $($.fn.dataTable.tables(true)).DataTable()
                    .columns.adjust();
            });
        </script>
    </div>
</body>

</html>
