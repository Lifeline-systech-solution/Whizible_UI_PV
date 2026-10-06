<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_ResourceDemandStatus.aspx.vb" Inherits="PbNIT.RM_ResourceDemandStatus" %>

<!DOCTYPE html>
<html>  
      <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource Demand Status")%>
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource Demand Status</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
  --%>  <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=3">


   
</head>
     <style type="text/css">
         .issfilter_actiondropdown {
             position: relative;
             top: 0px;
             right: 0;
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

        .mr-5 {
            margin-right: 5px;
        }

        table.dataTable thead .delete-check:after {
            display: none;
        }
        /*table tr th:last-child .custom_chckbox label:before {
			margin-right: -20px;
			}
			.delete-check .custom_chckbox input:checked + label:after{
			left:8px;
			}*/
        .d-lg-none {
            display: none
        }

        @media only screen and (max-width: 992px) {
            .d-block {
                display: block;
            }

            .d-none {
                display: none;
            }
        }

        .custom_chckbox input:checked + label:after {
            top: 4px;
        }

        .filter button[aria-expanded="true"] {
            background: none;
        }

        .alertify-notifier {
            z-index: 9999;
        }
        #basicfilters .row .col-sm-4 {
    padding-right: 0;
}
        #basicfilters .form-select{ 
           /* appearance: auto!important;*//*Commented By RehanC for Deopdown Issue on 28th Mar 2023*/
            padding-right: 12px!important;}

 /*Added style for BS5 changes*/
.list-to-filter .search-box{margin:0 0 10px}
.list-to-filter .search-box .input-group-addon{display:table-cell;padding:10px;border:1px solid #d2d6de;background:#eee;margin:0}
button#addattachnebtrow{font-size:11.5px!important}
.IB_filterlist label + .form-select{width:110px!important;margin-right:5px}
.IB_filterlist .form-select,.IB_filterlist .form-control,.IB_filterlist .input-group{display:inline-block;width:200px;height:30px;vertical-align:top;font-size:12px!important}
.IB_filterlist .form-group label{min-width:140px;font-size:11.5px;text-align:right}
.IB_filterlist .form-group{margin-bottom:5px}
.stackbasicfilter .box .form-group{display:inline-block;vertical-align:middle}
.form-control.input-sm{height:30px}
.input-group-btn button.btn.btncalendar{background:#eee}

.clsFilterHighlight {
            background: #1359a6 !important;
            color: #ffffff !important;
        }
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="RDSBody">
    <% If m_ViewAccess = True Then %>
    <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 mb-1 text-end graybg clearfix">
            <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_ResourceDemandStatus") %></h5>
            <a href="javascript:;" class="clearalllink" style="" onclick="ClearAll()" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong><%= MyBase.GetResourceString("C_ClearAll") %></strong></a>
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
                            <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false" onclick="AllStageFilters()"><%= MyBase.GetResourceString("C_MyFilters") %>  </a>
                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                            </ul>
                        </li>
                        <li class="">
                            <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true"><%= MyBase.GetResourceString("C_BasicFilters") %></a>
                        </li>
                    </ul>
                </div>
                <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="basicfilters" class="tab-pane">
                            <div class="filterpanelbody">
                                <div class="text-center hidden-sm centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn" onclick="btnSaveAndApplyFilter_Onclick()"><%= MyBase.GetResourceString("C_SaveandApply") %></button>
                                    <button class="btn btnyellow" onclick="StatusbtnApplyFilter()"><%= MyBase.GetResourceString("C_Apply") %></button>
                                </div>
                                <br>
                                <div class="row mb-3">
                                    <div class="col-sm-4 form-group">
                                        <label><%= MyBase.GetResourceString("C_ResourceDemandStatus") %></label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRDSFilterOpportunityStatus", "Exec usp_Whizible2_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select input-sm'",) %>
                                            </div>
                                            <div class="col-sm-8 pl-1">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRDSFilterOpportunityStatus", "txtRDSFilterOpportunityStatus", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='100'", ,, True,,,,) %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 form-group">
                                        <label><%= MyBase.GetResourceString("C_DisplayOrder") %></label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRDSFilterOpportunityStatusOrder", "Exec usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select input-sm'",) %>
                                            </div>
                                            <div class="col-sm-8 pl-1">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRDSFilterOpportunityStatusOrder", "txtRDSFilterOpportunityStatusOrder", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='8' onkeypress='return /[0-9]/i.test(event.key)'", ,, True,,,,) %>
                                            </div>
                                        </div>
                                    </div>
                                  
                                    <div class="col-sm-4 form-group">   
                                        <label>&nbsp;</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRDSFilterMapToReadyForClosure", "Exec usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select input-sm'",) %>
                                            </div>
                                            <div class="col-sm-8 pl-1" style="display: flex;">
                                                <div class="custom_chckbox">
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkRDSFilterMapToReadyForClosure", "chkRDSFilterMapToReadyForClosure") %>                              
                                                    <%-- Commented and Modified By RehanC for checkbox issue on 28th Mar 2023 --%> 
                                                    <%--<label><%= MyBase.GetResourceString("C_MapToReadyForClosure") %></label>--%>
                                                    <label for ="chkRDSFilterMapToReadyForClosure"><%= MyBase.GetResourceString("C_MapToReadyForClosure") %></label>
                                                    <%-- End of Comment By RehanC for checkbox issue on 28th Mar 2023 --%>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-2">   
                                    <div class="col-sm-4 form-group">                   
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRDSFilterMapToOpportunityInitiated", "Exec usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select input-sm'",) %>
                                            </div>
                                            <div class="col-sm-6 pl-1" style="display: flex;">
                                                <div class="custom_chckbox">
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkRDSFilterMapToOpportunityInitiated", "chkRDSFilterMapToOpportunityInitiated") %>
                                                    <%-- Commented and Modified By RehanC for checkbox issue on 28th Mar 2023 --%> 
                                                    <%--<label><%= MyBase.GetResourceString("C_MapToInitiated") %></label>--%>
                                                         <label for="chkRDSFilterMapToOpportunityInitiated"><%= MyBase.GetResourceString("C_MapToInitiated") %></label>
                                                    <%-- End of Comment By RehanC for checkbox issue on 28th Mar 2023 --%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                            <div class="col-sm-4 form-group">                              
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRDSFilterMapToOpportunityOnHold", "Exec usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select input-sm'",) %>
                                            </div>
                                            <div class="col-sm-6 pl-1" style="display: flex;">
                                                <div class="custom_chckbox">
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkRDSFilterMapToOpportunityOnHold", "chkRDSFilterMapToOpportunityOnHold") %>
                                                    <%-- Commented and Modified By RehanC for checkbox issue on 28th Mar 2023 --%> 
                                                           <%--<label><%= MyBase.GetResourceString("C_MapToOnHold") %></label>--%>
                                                           <label for="chkRDSFilterMapToOpportunityOnHold"><%= MyBase.GetResourceString("C_MapToOnHold") %></label>
                                                    <%-- End of Comment By RehanC for checkbox issue on 28th Mar 2023 --%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-sm-4 form-group">                                 
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRDSFilterMapToReopen", "Exec usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select input-sm'",) %>
                                            </div>
                                            <div class="col-sm-6 pl-1" style="display: flex;">
                                                <div class="custom_chckbox">
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkRDSFilterMapToReopen", "chkRDSFilterMapToReopen") %>
                                                    <%-- Commented and Modified By RehanC for checkbox issue on 28th Mar 2023 --%> 
                                                    <%--<label><%= MyBase.GetResourceString("C_MapToReopen") %></label>--%>
                                                    <label for="chkRDSFilterMapToReopen"><%= MyBase.GetResourceString("C_MapToReopen") %></label>
                                                    <%-- End of Comment By RehanC for checkbox issue on 28th Mar 2023 --%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </div >                                  
                                <div class="row mt-2">
                                               <div class="col-sm-4 form-group d-none">                                    
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRDSFilterMapToDrop", "Exec usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select input-sm'",) %>
                                            </div>
                                            <div class="col-sm-6 pl-1" style="display: flex;">
                                                <div class="custom_chckbox">
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkRDSFilterMapToDrop", "chkRDSFilterMapToDrop") %>
                                                    <%-- Commented and Modified By RehanC for checkbox issue on 28th Mar 2023 --%>
                                                    <%--<label><%= MyBase.GetResourceString("C_MapToDrop") %></label>--%>
                                                    <label for="chkRDSFilterMapToDrop"><%= MyBase.GetResourceString("C_MapToDrop") %></label>
                                                    <%-- End of Comment By RehanC for checkbox issue on 28th Mar 2023 --%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                   </div>
                         
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end filter panel-->
        <div class="container-fluid pt-1 pb-1 text-end">
            <% If m_AddAccess = True Then %>
            <button class="btn borderbtn mr-5 addbtn" id="addbtn" onclick="addRDSdetail()" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Add"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></button>
            <% End If %>
            <% If m_DeleteAccess = True Then %>
            <button class="btn borderbtn deletebtn" id="deletebtn" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete" onclick="Deleteconfirmationmodal()"><%= MyBase.GetResourceString("C_Delete") %></button>
            <% End If %>
        </div>
        <div class="content pt-0 clearfix">
            <table id="RDSListTbl" class="table table-bordered RDSListTbl" style="width: 100%;">
                <thead>
                    <tr>
                        <th width="120" align="center"><%= MyBase.GetResourceString("C_DisplayOrder") %></th>
                        <th class="text-start"><%= MyBase.GetResourceString("C_ResourceDemandStatus") %></th>
                        <th width="50" class="delete-check">
                            <div class="custom_chckbox">
                                <input id="CheckSelectAll" class="chckHead" type="checkbox">
                                <label for="CheckSelectAll"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="RDSListTblBody">
                </tbody>
            </table>
        </div>
        <div class="Resourcedetailpanel">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li class="active">
                        <a href="#RDSdetails" data-bs-toggle="tab" id=""><%= MyBase.GetResourceString("C_Details") %></a>
                        <div></div>
                    </li>
                </ul>
                <div class="tab-content">
                    <div id="RDSdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-end">
                            <button class="btn btnyellow mr-5" id="BtnSave" onclick="SaveDemandStatusDetails()"><%= MyBase.GetResourceString("C_Save") %></button>
                            <button class="btn btnyellow mr-5" id="BtnSaveAndAdd" onclick="SaveAndAddDemandStatusDetails()"><%= MyBase.GetResourceString("C_SaveAndAdd") %></button>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_Cancel") %></button>
                        </div>
                        <p class="text-end"><strong>(<font color="red">*</font> Mandatory)</strong></p>
                        <div class="row">
                            <div class="col-sm-3 form-group">
                                <label class="required"><%= MyBase.GetResourceString("C_ResourceDemandStatus") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtDemandStatus", "txtDemandStatus",, "form-control",,,,, , , 300,,,,,,,, "autocomplete='Off' maxlength='100'",,,,,,,,,,) %>
                            </div>
                            <div class="col-sm-3 form-group">
                                <label class="required"><%= MyBase.GetResourceString("C_DisplayOrder") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtDisplayOrder", "txtDisplayOrder",, "form-control",,,,, , , 300,,,,,,,, "autocomplete='Off' maxlength='8' onkeypress='return /[0-9]/i.test(event.key)' onPaste='return false'",,,,,,,,,,) %>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-3 form-group">
                                <label class="">&nbsp;</label>
                                <div class="custom_chckbox">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkClosureCheck", "chkClosureCheck") %>
                                    <label for="chkClosureCheck"><%= MyBase.GetResourceString("C_MapToReadyForClosure") %></label>
                                </div>
                            </div>
                            <div class="col-sm-3 form-group">
                                <label class="">&nbsp;</label>
                                <div class="custom_chckbox">
                                    <%--<input id="initiatedCheck" class="chcktbl" type="checkbox">--%>
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkInitiatedCheck", "chkinitiatedCheck") %>

                                    <label for="chkinitiatedCheck"><%= MyBase.GetResourceString("C_MapToInitiated") %></label>
                                </div>
                            </div>
                            <div class="col-sm-3 form-group">
                                <label class="">&nbsp;</label>
                                <div class="custom_chckbox">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkOnHoldCheck", "chkOnHoldCheck") %>
                                    <label for="chkOnHoldCheck"><%= MyBase.GetResourceString("C_MapToOnHold") %></label>
                                </div>
                            </div>
                            <div class="col-sm-3 form-group">
                                <label class="">&nbsp;</label>
                                <div class="custom_chckbox">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkReopenCheck", "chkReopenCheck") %>
                                    <label for="chkReopenCheck"><%= MyBase.GetResourceString("C_MapToReopen") %></label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-3 form-group">
                                <label class="">&nbsp;</label>
                                <div class="custom_chckbox">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkDropCheck", "chkDropCheck") %>
                                    <label for="chkDropCheck"><%= MyBase.GetResourceString("C_MapToDrop") %></label>
                                </div>
                            </div>
                            <input type="hidden" id="hdnDemandStatusID" name="hdnDemandStatusID" value="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Save filter Modal start here-->
        <div class="modal custmodal Issuesavefilter fade" id="RDSsavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="Issuesavrefilterbox" class="box-panel">
                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label required col-md-4 p-0 text-end">Filter Name :</label>
                                            <span class="col-md-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='100'", ,, True,,,,) %><br />
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow float-start" onclick="SaveFilterValidation()">Save</button>
                                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end">Cancel</button>
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

        <!--Delete confrimation modal start here -->
        <div class="modal custmodal fade" id="Deleteconfirmationmodal" aria-hidden="true" data-bs-dismiss="modal" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modalsmall ui-draggable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_ConfirmDelete") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center">
                            <span id="CheckModal"></span>
                            <p><%= MyBase.GetResourceString("C_DeleteNote") %></p>
                        </div>
                        <br />
                        <div class="">
                            <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn" onclick=""><%= MyBase.GetResourceString("C_No") %></a>
                            <a href="javascript:;" data-bs-dismiss="modal" class="btn btnyellow  float-end" onclick="DeleteStatus()"><%= MyBase.GetResourceString("C_Yes") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Delete confrimation modal -->


        <div class="clearfix"></div>
    </div>
    <% Else %>
    <div id="NotAuthorized">
        <h4>You are not authorized to view this record. </h4>
    </div>
    <% End If %>
    <!-- REQUIRED JS SCRIPTS -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js"></script>

    <script>
        //Remove tooltip Script added By Madhuri.K On 20-Aug-2024 Start here
        $('body').on('click', function () {
            $('.tooltip').remove();
        });
          //Remove tooltip Script added By Madhuri.K On 20-Aug-2024 End here

        /*$("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();*/

        function addRDSdetail() {
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $("#RDSListTbl_wrapper .dataTables_scrollBody, .backbtn, .paginate_button, .addbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            $(".table").resize();
            $("#hdnDemandStatusID").val('');
            ClearDetailTab();
        }

        function editRDSDetails(StatusID) {
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $("#RDSListTbl_wrapper .dataTables_scrollBody, .backbtn, .paginate_button, .addbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            $(".table").resize();
            BindDemandStatusDetails(StatusID, "Null");
        }

        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#RDSListTbl_wrapper .dataTables_scrollBody, .backbtn, .paginate_button, .addbtn, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();

        });

        //datatable
        $('#RDSListTbl').dataTable({
            //"ajax": '/api/data',
            "scrollY": true,
            "scrollX": true,
            //"scroller": true,
            "pageLength": 10,
            //"paging": false,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true
        });

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);
        $('#RDSListTbl').DataTable().columns.adjust().draw();

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
            $('#RDSListTbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 220, "overflow-y": "auto" });

            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });


        $("#filterpanel").on("show.bs.collapse", function () {
            //$(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            //$(".clearalllink").hide();
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
    </script>

    <script>
        //Added By Riddhesh Patil on 10-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        alertify.set('notifier', 'position', 'top-right');
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var LoginType = '<%= Session("LoginType") %>';
        var ajaxResult = "";
        var GlobalApplyID = "";
        var GlobalQueryText = "";
        var savedFilterName = "";
        var GlobalFilterID = "";
        var GlobalFilterName = "";
        var FilterID = "";
        var flag = 0;
        var GlobalFilterFlag = "";
        var DefaultFilterID = "";
        var selectedqid = "";
        var AllFields = ["OpportunityStatus", "OpportunityStatusOrder", "MapToReadyForClosure", "MapToOpportunityInitiated", "MapToOpportunityOnHold", "MapToReopen", "MapToDrop"];
        $(document).ready(function () {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            }); $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
            //$('table tr').removeClass('rowhiglight');
            //$(".Resourcedetailpanel").hide();
            //$("#RDSListTbl_wrapper .dataTables_scrollBody, .backbtn, .paginate_button, .addbtn, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            //$(".table").resize();
            GetDefaultFilter();
            // GetDemandStatusList();
        });

        function GetDemandStatusList(QueryText) {
            if (QueryText == undefined || QueryText == '' || QueryText == null) {
                QueryText = "Null";
                $("#ClearAllFilter").hide();
                $(".filterpanel").removeClass('in');
                ClearBasicFilter("RDS");
                GlobalApplyID = '';

            }
            else {
                QueryText = QueryText;
            }
            //StartLoader("#RDSBody");
            $("#RDSListTbl").dataTable().fnDestroy();

           /* var Parameters = { QueryText: encodeURI(QueryText) }*/
            var WBSParameters = {
                QueryText: encodeURI(QueryText)
            }

            var param = JSON.stringify(WBSParameters);

            var strResult = AJAXCallWithResult("/api/RM_ResourceDemandStatus/GetDemandStatusList", param, false);
            $("#RDSListTblBody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var OpportunityStatus = strResult[i]["OpportunityStatus"];
                var OpportunityStatusOrder = strResult[i]["OpportunityStatusOrder"];
                var OpportunityStatusID = strResult[i]["OpportunityStatusID"];

                strHTML += '<tr>'
                strHTML += '<td align="center">' + OpportunityStatusOrder + '</td>'
                <% If m_EditAccess = True Then %>
                strHTML += '<td class="text-start"><a href="javascript:;" onclick="editRDSDetails(' + OpportunityStatusID + ')">' + OpportunityStatus + '</a></td>'
                <% Else %>
                strHTML += '<td>' + OpportunityStatus + '</td>'
                <% End If %>
                strHTML += '<td>'
                strHTML += '<div class="custom_chckbox">'
                strHTML += '<input id="RDSListCheck_' + OpportunityStatusID + '" name="checkstatus"class="chcktbl" type="checkbox" value="' + OpportunityStatusID + '"/>'
                strHTML += '<label for="RDSListCheck_' + OpportunityStatusID + '"></label>'
                strHTML += '</div>'
                strHTML += '</td>'
                strHTML += '</tr>'

            }
            $("#RDSListTblBody").html("")
            $("#RDSListTblBody").html(strHTML);

            $('#RDSListTbl').dataTable({
                "scrollY": true,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true
            });
            $(".table").resize();
            //StopAjaxLoader("#RDSBody");
        }

        function BindDemandStatusDetails(StatusID, QueryText) {
            $("#hdnDemandStatusID").val(StatusID);
            if (QueryText == '') {
                QueryText = "Null";
            }
            var Parameter = {
                QueryText: encodeURI(QueryText),
                StatusID: encodeURI(StatusID)
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/RM_ResourceDemandStatus/GetDemandStatusList", param, false);
            for (var i = 0; i < Result.length; i++) {
                var IsInitiated = Result[i]["MapToOpportunityInitiated"];
                var IsOnHold = Result[i]["MapToOpportunityOnHold"];
                var OrderNo = Result[i]["OpportunityStatusOrder"];
                var StatusName = Result[i]["OpportunityStatus"];
                var IsReadyForClosure = Result[i]["MapToReadyForClosure"];
                var IsReopen = Result[i]["MapToReopen"];
                var IsDrop = Result[i]["MapToDrop"];

                $("#txtDemandStatus").val(StatusName);
                $("#txtDisplayOrder").val(OrderNo);

                if (IsInitiated == "1") {
                    $("#chkinitiatedCheck").prop('checked', true);
                } else {
                    $("#chkinitiatedCheck").prop('checked', false);
                }

                if (IsOnHold == "1") {
                    $("#chkOnHoldCheck").prop('checked', true);
                } else {
                    $("#chkOnHoldCheck").prop('checked', false);
                }

                if (IsReadyForClosure == "1") {
                    $("#chkClosureCheck").prop('checked', true);
                } else {
                    $("#chkClosureCheck").prop('checked', false);
                }

                if (IsReopen == "1") {
                    $("#chkReopenCheck").prop('checked', true);
                } else {
                    $("#chkReopenCheck").prop('checked', false);
                }

                if (IsDrop == "1") {
                    $("#chkDropCheck").prop('checked', true);
                } else {
                    $("#chkDropCheck").prop('checked', false);
                }
            }

        }

        function SaveDemandStatusDetails() {
            if (ValidateStatusDetails() == true) {

                var StatusName = $("#txtDemandStatus").val();
                var OrderNo = $("#txtDisplayOrder").val();
                if ($('#chkDropCheck').is(":checked")) {
                    var IsDrop = true;
                }
                else {
                    var IsDrop = false;
                }
                if ($('#chkReopenCheck').is(":checked")) {
                    var IsReopen = true;
                }
                else {
                    var IsReopen = false;
                }
                if ($('#chkClosureCheck').is(":checked")) {
                    var IsClosure = true;
                }
                else {
                    var IsClosure = false;
                }
                if ($('#chkinitiatedCheck').is(":checked")) {
                    var IsInitiated = true;
                }
                else {
                    var IsInitiated = false;
                }
                if ($('#chkOnHoldCheck').is(":checked")) {
                    var IsOnHold = true;
                }
                else {
                    var IsOnHold = false;
                }

                var StatusID = $("#hdnDemandStatusID").val();
                var Parameter = {
                    OrderNo: encodeURI(OrderNo),
                    StatusName: StatusName,
                    IsDrop: encodeURI(IsDrop),
                    IsReopen: encodeURI(IsReopen),
                    IsClosure: encodeURI(IsClosure),
                    IsInitiated: encodeURI(IsInitiated),
                    IsOnHold: encodeURI(IsOnHold),
                    StatusID: encodeURI(StatusID),
                    UserName: encodeURI(UserName),
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/RM_ResourceDemandStatus/SaveOrUpdateDemandStatus", param, false);
                if (Result == "<%= MyBase.GetResourceString("A_RDSUpdated") %>") {
                    alertify.success(Result);
                } else {
                    alertify.success("<%= MyBase.GetResourceString("A_RDSAdded") %>");
                    $("#hdnDemandStatusID").val(Result);
                }
                GetDemandStatusList(GlobalQueryText);
            }
        }


        function SaveAndAddDemandStatusDetails() {
            if (ValidateStatusDetails() == true) {
                SaveDemandStatusDetails();
                ClearDetailTab();
                $("#hdnDemandStatusID").val('');
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

        function ValidateStatusDetails() {

            var DemandStatus = $("#txtDemandStatus").val();
            var OrderNo = $("#txtDisplayOrder").val();

            if (isBlank(DemandStatus)) {
                alertify.error("<%= MyBase.GetResourceString("A_StatusBlank") %>")
                $("#txtDemandStatus").focus();
                return false;
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            if (checkSpecialCharacter(DemandStatus, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Resource Demand Status should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtDemandStatus").focus();
                return false;
            }
			//End of Added By Riddhesh Patil
            else if (isBlank(OrderNo)) {
                alertify.error("<%= MyBase.GetResourceString("A_OrderNoBlank") %>")
                $("#txtDisplayOrder").focus();
                return false;
            } else if (ValidateStatusNameOrderNO() == false) {
                return false;
            }
            else {
                return true;
            }
            return true;
        }

        function ValidateStatusNameOrderNO() {
            var StatusID = $("#hdnDemandStatusID").val();
            var OrderNo = $("#txtDisplayOrder").val();
            var DemandStatus = $("#txtDemandStatus").val();
            DemandStatus = DemandStatus.replace(/'/g, "''");
            var Parameter = {
                StatusID: encodeURI(StatusID),
                OrderNo: encodeURI(OrderNo),
                StatusName: encodeURI(DemandStatus),
            }
            var param = JSON.stringify(Parameter);
            var strResult = AJAXCallWithResult("/api/RM_ResourceDemandStatus/ValidateStatusNameOrderNO", param, false);
            if (strResult == "'Resource Demand Status' already exists.") {
                alertify.error(strResult);
                $("#txtDemandStatus").focus();
                return false;
            }
            //Commented and Added By Riddhesh Patil on 17 April 2023
           // else if (strResult == "This order number is already applied.") {
            else if (strResult == "This order number is already exists.") {
                //End of Commented and Added By Riddhesh Patil on 17 April 2023
                alertify.error(strResult);
                $("#txtDisplayOrder").focus();
                return false;
            }
            else {
                return true;
            }
        }

        function Deleteconfirmationmodal() {
            var StatusIDs = "";
            var table = $('#RDSListTbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            StatusIDs = $('input[name=checkstatus]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            if (StatusIDs.length != 0) {
                $("#Deleteconfirmationmodal").modal('show');
            } else {
                alertify.error("<%= MyBase.GetResourceString("A_SelectOne") %>");
                return false;
            }
        }

        function DeleteStatus() {
            var curResult = "";
            var table = $('#RDSListTbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            var StatusIDs = $('input[name=checkstatus]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            var arrStatusIDs = StatusIDs.split(',');
            for (var i = 0; i < arrStatusIDs.length; i++) {
                var StatusID = arrStatusIDs[i];
                var param = JSON.stringify(encodeURI(StatusID));
                var result = AJAXCallWithResult("/api/RM_ResourceDemandStatus/DeleteStatus", param, false);
                if (result != undefined) {
                    if (result != "") {
                        if (curResult == "") {
                            curResult = result + "\n";
                        }
                        else {
                            curResult = curResult + "&&" + result + "\n";
                        }
                    }
                }
            }
            if (curResult != undefined && curResult != null && curResult != "") {
                curResult = curResult.replace(/\n/g, "<br />");
                var ErrorResult = "";
                var SuccessResult = "";
                var Data = curResult.split("&&");
                for (var i = 0; i < Data.length; i++) {
                    if (Data[i].indexOf("cannot") > -1) {
                        ErrorResult += Data[i];
                    }
                    else {
                        SuccessResult += Data[i];
                    }

                }
                if (SuccessResult != '') {
                    alertify.success("<%= MyBase.GetResourceString("A_StatusDel") %>");
                }
                if (ErrorResult != '') {
                    alertify.error(ErrorResult);
                }
            }
            GetDemandStatusList(GlobalQueryText);
            $(".chckHead").prop("checked", false);
        }


        $("#chkDropCheck").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $("#chkReopenCheck").prop('checked', false);
                $("#chkClosureCheck").prop('checked', false);
                $("#chkinitiatedCheck").prop('checked', false);
                $("#chkOnHoldCheck").prop('checked', false);

            } else {
            }
        });
        $("#chkReopenCheck").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $("#chkDropCheck").prop('checked', false);
                $("#chkClosureCheck").prop('checked', false);
                $("#chkinitiatedCheck").prop('checked', false);
                $("#chkOnHoldCheck").prop('checked', false);

            } else {
            }
        });
        $("#chkClosureCheck").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $("#chkReopenCheck").prop('checked', false);
                $("#chkDropCheck").prop('checked', false);
                $("#chkinitiatedCheck").prop('checked', false);
                $("#chkOnHoldCheck").prop('checked', false);

            } else {
            }
        });
        $("#chkinitiatedCheck").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $("#chkReopenCheck").prop('checked', false);
                $("#chkClosureCheck").prop('checked', false);
                $("#chkDropCheck").prop('checked', false);
                $("#chkOnHoldCheck").prop('checked', false);

            } else {
            }
        });
        $("#chkOnHoldCheck").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $("#chkReopenCheck").prop('checked', false);
                $("#chkClosureCheck").prop('checked', false);
                $("#chkinitiatedCheck").prop('checked', false);
                $("#chkDropCheck").prop('checked', false);
            } else {
            }
        });

        function ClearDetailTab() {
            $("#txtDemandStatus").val('');
            $("#txtDisplayOrder").val('');
            $("#chkDropCheck").prop('checked', false);
            $("#chkReopenCheck").prop('checked', false);
            $("#chkClosureCheck").prop('checked', false);
            $("#chkinitiatedCheck").prop('checked', false);
            $("#chkOnHoldCheck").prop('checked', false);
        }

        //this use for if uncheck one of the Checkbox then remove check of Select all
        $(document).on('change', '.chcktbl', function () {

            var table = $("#RDSListTbl").DataTable();
            var checked = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl').length;
            var checked1 = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl:checked').length;
            if (checked == checked1) {
                $(".chckHead").prop("checked", true);
            }
            else {
                $(".chckHead").prop("checked", false);
            }
        });

        //Check Or Uncheck All checkBox
        $('#CheckSelectAll').click(function () {

            var table = $('#RDSListTbl').DataTable();
            if ($(this).prop("checked") == true) {

                var rows1 = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows1).each(function () {
                    this.checked = true;
                });

            }
            else if ($(this).prop("checked") == false) {
                var rows2 = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows2).each(function () {
                    this.checked = false;
                });
            }
        });

        //AjaxCall Function
        function AJAXCallWithResult(url, param, async) {
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                          //  window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                },
            });
            return ajaxResult;
        }


        //Filter Part Start From Here
        // Create Filter Query
        function GenerateBasicFilterQuery(module, AllFields) {
            var strqtext = "";
            for (var i = 0; i < AllFields.length; i++) {
                var strvalue = '';
                var strOp = $('select#cbo' + module + 'Filter' + AllFields[i] + ' option:selected').val();
                var strCHK = $('#chk' + module + 'Filter' + AllFields[i]).is(":checked");
                if ($("#txt" + module + "Filter" + AllFields[i]).val() != null) {
                    strvalue = $("#txt" + module + "Filter" + AllFields[i]).val().trim();
                }
                if (strvalue != "" && strvalue != "0" && strvalue != null && strvalue != "null") {
                    if (strqtext != "") strqtext += " AND ";
                    if (strOp == "Contains") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += ' "%' + strvalue + '%"';
                    }
                    else if (strOp == "Ends With") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += ' "%' + strvalue + '"';
                    }
                    else if (strOp == "Exact Word") {
                        strqtext += AllFields[i] + " = ";
                        strqtext += ' "' + strvalue + '"';
                    }
                    else if (strOp == "Not Contains") {
                        strqtext += AllFields[i] + " ";
                        strqtext += ' NOT LIKE "%' + strvalue + '%"';
                    }
                    else if (strOp == "Starts With") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += ' "' + strvalue + '%"';
                    }
                    else {
                        strqtext += AllFields[i] + " ";
                        strqtext += strOp + ' "' + strvalue + '"';
                    }
                }

                if (strOp == "=" && strCHK == true) {
                    if (strqtext != "" && strqtext != '' && strqtext != null && strqtext != undefined) {
                        strqtext += ' AND '
                    }
                    if (strvalue == "" || strvalue == undefined) {
                        strqtext += AllFields[i] + " = " + '"' + strCHK + '"';
                    }
                    else {
                        strqtext += AllFields[i] + "=" + '"' + strCHK + '"';
                    }
                }
                if (strOp == "<>" && strCHK == true) {
                    if (strqtext != "" && strqtext != '' && strqtext != null && strqtext != undefined) {
                        strqtext += ' AND '
                    }
                    if (strvalue == "" || strvalue == undefined) {
                        strqtext += AllFields[i] + " <> " + '"' + strCHK + '"';
                    }
                    else {
                        strqtext += AllFields[i] + "<>" + '"' + strCHK + '"';
                    }
                }

            }
            strqtext = strqtext.replace('Over', '[Over]');
            strqtext = strqtext.replace(/'/g, "''");
            return strqtext;
        }

        //Only Apply Filter
        function StatusbtnApplyFilter() {
            var QueryText = "";
            QueryText = GenerateBasicFilterQuery('RDS', AllFields);
            if (QueryText == "") {
                alertify.error("<%= MyBase.GetResourceString("A_SelOneFilter") %>");
            } else {
                alertify.success("<%= MyBase.GetResourceString("A_FilterApplied") %>");
                GetDemandStatusList(QueryText);
                $("#filterpanel").removeClass("in");
                $("#AdvanceFilterIcon").addClass("activefilter");
                $(".clearalllink").css("display", "inline-block");
                //Commented and Added By Riddhesh Patil on 13 April 2023
                //$(".filter .fa-filter").css("color", "#1359a6");
                $(".filter .fa-filter").css("color", "#ffffff");
                $("#AdvanceFilterIcon").css("background", "#1359a6");
                //End of Commented and Added By Riddhesh Patil on 13 April 2023
            }
        }

        function btnSaveAndApplyFilter_Onclick() {
            var QueryText = "";
            QueryText = GenerateBasicFilterQuery('RDS', AllFields);
            if (QueryText == "") {
                alertify.error("<%= MyBase.GetResourceString("A_SelOneFilter") %>");
            } else {
                $("#RDSsavefilter").modal('show');
                $(".canclesaveasbtn").click(function () {
                    $("#txtFilterName").val('');
                });
            }
        }

        //Function to save the filter and Apply the filter 
        function SaveFilterValidation() {
            var FilterName = $("#txtFilterName").val().trim();
            FilterID = GlobalFilterID;
            if (FilterName != GlobalFilterName) {
                FilterID = 0;
            }

            FilterName = FilterName.replace(/'/g, "''");
            if (FilterName != "" && FilterName != null) {

                var filterExists = 0;
                if (savedFilterName == "") {
                    filterExists = checkDuplicateFilter(GlobalFilterFlag, GlobalFilterID, FilterName, 3862);
                }
                if (filterExists == 0) {
                    if (checkSpecialCharacter(FilterName.trim(), WebConfigSpecialCharacters) == true) {
                        $("#savefilterbtn").removeAttr("data-bs-dismiss");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtFilterName").focus();
                        return false;

                    }
                    //End of Comment and Added By Riddhesh Patil
                    else {
                        SavedFilters(FilterName);
                        //$("#txtFilterName").val("");
                        $("#RDSsavefilter").modal('hide');
                    }
                }
                
            }
            else {
                alertify.error("<%= MyBase.GetResourceString("A_FilterNameBlank") %>");
                $("#txtFilterName").focus();
            }

        }


        //For Duplicated Filter
        function checkDuplicateFilter(Flag, FilterID, filtername, TagID) {
            var isFilterExists = 0;
            var Parameters = {
                Flag: encodeURI(Flag),
                FilterID: encodeURI(FilterID),
                FilterName: encodeURI(filtername),
                TagID: encodeURI(TagID),
                UserID: UserID,
            }
            var param = JSON.stringify(Parameters);
            var data = AJAXCallWithResult("/api/RM_ResourceDemandStatus/chkFilterExists", param, false);
            if (data == 0) {
                isFilterExists = 0;
            }
            else if (data == 1) {
                alertify.error("<%= MyBase.GetResourceString("A_FNameAlredyExist") %>");
                $("#txtFilterName").focus();
                isFilterExists = 1;
            }
            return isFilterExists;
        }

        //SaveAndApply Filter Functionality
        function SavedFilters(FilterName) {

            // var FilterName = $("#txtFilterName").val();

            if (FilterName != GlobalFilterName && FilterID == "0") {
                Flag = 0;
            }
            else {
                Flag = 1;
            }
            var QueryText = GenerateBasicFilterQuery('RDS', AllFields);

            if (QueryText != '') {
                Parameter = {
                    TagID: 3862,
                    UserID: encodeURI(UserID),
                    FilterName: encodeURI(FilterName),
                    LoginType: encodeURI(LoginType),
                    QueryText: encodeURI(QueryText),
                    UserName: encodeURI(UserName),
                    Flag: encodeURI(Flag),
                    FilterID: encodeURI(FilterID)

                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/RM_ResourceDemandStatus/SavedFilters", param, false);

                if (strResult != null) {
                    GlobalFilterName = FilterName;
                    GlobalFilterID = strResult;
                    GlobalApplyID = strResult;
                    GlobalApplyID = "Apply" + GlobalApplyID
                    FilterID = strResult;
                   // selectedqid = GlobalApplyID;
                    $('.filterpanelModule').removeClass('in');
                    //Comment and Added By Riddhesh Patil on 14 April 2023
                    // ApplyCheckFilter(GlobalApplyID);
                    ApplyCheckFilter(GlobalApplyID, 1);
                    $("#txtFilterName").val('');
                    //End of Comment and Added By Riddhesh Patil on 14 April 2023
                    alertify.success("<%= MyBase.GetResourceString("A_FilterApplied") %>");
                    $(".clearalllink").css("display", "inline-block");
                    $("#filterpanel").removeClass("in");
                    $("#AdvanceFilterIcon").removeClass("activefilter");
                }
            }
        }

        // Getting QueryText From Perticular FilterID
        function ApplyCheckFilter(ApplyID, flag) {

            if (GlobalApplyID == "") {

                GlobalApplyID = ApplyID;

            }
            else if (GlobalApplyID != ApplyID) {

                GlobalApplyID = ApplyID;

            }
            else {

                ApplyID = GlobalApplyID;
            }
            var FilterID = ApplyID.replace("Apply", "");

            if (FilterID != undefined) {
                Parameter = {
                    FilterID: encodeURI(FilterID),
                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/RM_ResourceDemandStatus/GetWhereClauseFilter", param, false);
                if (flag != 1) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Filter applied successfully.");
                }
                var QueryText = strResult;
                selectedqid = ApplyID.replace('Apply', '');
                if (QueryText != null) {
                    QueryText = QueryText.toString().replace(/'/g, "''");
                }
                GlobalQueryText = QueryText;
                GetDemandStatusList(QueryText)
                var sibling = $('label[id^="Apply"]')
                if ($("#" + ApplyID).parent().find("input").prop("checked") == true) {

                    $("#" + ApplyID).parent().find("input").prop("checked", true);
                    $("#" + ApplyID).removeAttr("data-original-title", "");
                    $("#" + ApplyID).attr("data-original-title", "Applied Filter");

                }
                else if ($("#" + ApplyID).parent().find("input").prop("checked") == false) {

                    $(sibling).each(function () {
                        var IsApplyFilter = 0;
                        var id = this.id;
                        if (ApplyID == this.id) {
                            IsApplyFilter = 1;
                            $("#" + id).parent().find("input").prop("checked", true);
                            $("#" + ApplyID).removeAttr("data-original-title", "");
                            $("#" + ApplyID).attr("data-original-title", "Applied Filter");
                        }

                        else if ("Default" + ApplyID == this.id) {
                            if (IsApplyFilter != 1) {
                                $("#" + id).parent().find("input").prop("checked", true);
                                $("#" + ApplyID).removeAttr("data-original-title", "");
                                $("#" + ApplyID).attr("data-original-title", "Applied Filter");
                            }
                        }
                        else {
                            $("#" + id).parent().find("input").prop("checked", false);
                            $("#" + ApplyID).removeAttr("data-original-title", "");
                            $("#" + ApplyID).attr("data-original-title", "Applied Filter");
                        }
                    });
                }
                $(".clearalllink").css("display", "inline-block");
                $(".filter button").css("background", "#1359a6");
                $(".fa-filter").css("color", "#FFFFFF");

            }
        }

        // List Of All Module Filters
        function AllStageFilters() {

            Parameter = {
                TagID: 3862,
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID)
            }

            var param = JSON.stringify(Parameter);
            var strResult = AJAXCallWithResult("/api/RM_ResourceDemandStatus/AllStageFilters", param, false);
            MyFiltersList(strResult);

        }
        
        // Plotting Filter In My Filter DropDown
        function MyFiltersList(result) {
            var Setid = parseInt(selectedqid);
            var strHTML = "";
            for (var i = 0; i < result.length; i++) {

                var FilterID = result[i]["FilterId"];
                var FilterName = result[i]["FilterName"];
                var QueryText = result[i]["QueryText"];
                if (result[i].SetDefault == true) { DefaultFilterID = FilterID; }
                strHTML += ' <li>'
                if (result[i].SetDefault == true) {
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2" checked="checked" onclick="SetDefaultFilter(this.id,&quot;default&quot;)">'
                    strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Remove Default Filter" class="checkmark"></span>'
                    strHTML += '</label>'
                    strHTML += '<label class="">'
                    strHTML += '<span for="project2" class="radiotextsty filtername">' + FilterName + '</span>'
                    strHTML += '</label>'
                    strHTML += '<div class="issfilter_actiondropdown">'
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="ModuleselproOne" checked="" type="checkbox" name="">'
                    if (FilterID == Setid) {
                        strHTML += '<input id="ModuleselproOne" checked="" type="checkbox" name="">'
                        strHTML += '<label data-bs-toggle="tooltip" data-container="body" data-bs-placement="bottom" title="Applied filter" for="IssueselproOne" id="Applied' + FilterID + '" onclick="ClearAllApplyFilter()" class="filterid"></label>'
                    }
                    else {
                        strHTML += '<input id="Apply' + FilterID + '" type="checkbox" name="" />'
                        strHTML += '<label data-bs-toggle="tooltip" data-container="body" data-bs-placement="bottom" title="Apply filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckFilter(this.id)" class="filterid"></label>'
                    }
                    strHTML += '</div>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-container="body" data-bs-placement="bottom" title="Edit Filter" class="fas fa-pencil-alt" id="Edit' + FilterID + '" onclick="EditFilter(this.id)"></i></span>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-container="body" data-bs-placement="bottom" title="Delete Filter" class="far fa-trash-alt" id="Default' + FilterID + '" onclick="DefaultDeleteFilter(this.id)"></i></span>'
                }
                else {
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2" onclick="SetDefaultFilter(this.id)">'
                    strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default Filter" class="checkmark"></span>'
                    strHTML += '</label>'
                    strHTML += '<label class="">'
                    strHTML += '<span for="project2" class="radiotextsty filtername">' + FilterName + '</span>'
                    strHTML += '</label>'
                    strHTML += '<div class="issfilter_actiondropdown">'
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="ModuleselproOne" type="checkbox" name="">'
                    if (FilterID == Setid) {
                        strHTML += '<input id="ModuleselproOne" checked="" type="checkbox" name="">'
                        strHTML += '<label data-bs-toggle="tooltip" data-container="body" data-bs-placement="bottom" title="Applied filter" for="IssueselproOne" id="Applied' + FilterID + '" onclick="ClearAllApplyFilter()" class="filterid"></label>'
                    }
                    else {
                        strHTML += '<input id="Apply' + FilterID + '" type="checkbox" name="" />'
                        strHTML += '<label data-bs-toggle="tooltip" data-container="body" data-bs-placement="bottom" title="Apply Filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckFilter(this.id)" class="filterid"></label>'
                    }
                    strHTML += '</div>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-container="body" data-bs-placement="bottom" title="Edit Filter" class="fas fa-pencil-alt" id="Edit' + FilterID + '" onclick="EditFilter(this.id)"></i></span>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-container="body" data-bs-placement="bottom" title="Delete Filter" class="far fa-trash-alt" id="' + FilterID + '" onclick="DefaultDeleteFilter(this.id)"></i></span>'
                }
                strHTML += '</div>'
                strHTML += '</li>'
            }
            $("#MyFiltersdropdown").html(strHTML);
            $('[data-bs-toggle="tooltip"]').tooltip();
            //Comment and Added By Riddhesh Patil on 14 April 2023
            //if (GlobalApplyID != null && GlobalApplyID != "") {
            //   ApplyCheckFilter(GlobalApplyID);
            //}
            //else {
            //    ClearFilterApplied();
            //}

            if (GlobalApplyID == null && GlobalApplyID == "") {
                ClearFilterApplied();
            }
            //End of Comment and Added By Riddhesh Patil on 14 April 2023

        }

        //To clear the applied filter arrow after click on clear filter button
        function ClearFilterApplied() {
            var sibling = $('label[id^="Apply"]');
            $(sibling).each(function () {
                var id = this.id;
                if ($("#" + id).parent().find("input").prop("checked") == true) {
                    $("#" + id).parent().find("input").prop("checked", false);
                    $("#" + id).removeAttr("data-original-title", "");
                    $("#" + id).attr("data-original-title", "Apply Filter");
                }
            });
        }

        //Delete Filter 
        function DefaultDeleteFilter(DefaultID) {
            var NewDeleteFilterID = DefaultID.replace("Default", "");
            if (DefaultFilterID == NewDeleteFilterID || DefaultFilterID == GlobalFilterID) {
                GlobalQueryText = null;
            }
            if (DefaultID.indexOf("Default") > -1) {
                //var FilterID = DefaultID.replace("Default", "");
                var FilterID = GlobalFilterID;
                DeleteFilter(FilterID);
                GetDemandStatusList(GlobalQueryText);
                $('.filterpanelModule').removeClass('in');
                $(".clearalllink").css({ "display": "none" });
                $(".filter").css("color", "transperent");
                $(".filter .fa-filter").css("color", "#464a4c");
            }
            else {
                DeleteFilter(DefaultID);
                GetDefaultFilter();
            }
            $(".filterpanel ").removeClass('in');

        }

        function DeleteFilter(FilterID) {
            if (FilterID != undefined) {
                Parameter = {
                    FilterID: encodeURI(FilterID),
                }

                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/RM_ResourceDemandStatus/DeleteFilter", param, false);

                alertify.success("<%= MyBase.GetResourceString("A_FilterDelete") %>");
                ClearBasicFilter("RDS");
                AllStageFilters();

            }
            $(".filter button").css("background", "none");
            $(".fa-filter").css("color", "#464a4c");
        }

        //Get the default filter
        function GetDefaultFilter() {

            Parameter = {
                TagID: 3862,
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID)
            }

            var param = JSON.stringify(Parameter);
            var strResult = AJAXCallWithResult("/api/RM_ResourceDemandStatus/GetDefaultFilter", param, false);

            FilterID = strResult.FilterID;
            var QueryText = strResult.QueryText;
            if (QueryText != null) {
                GlobalApplyID = "Apply" + FilterID;
                QueryText = QueryText.toString().replace(/'/g, "''");
                GlobalQueryText = QueryText;
                $(".clearalllink").css("display", "inline-block");
                $(".filter button").css("background", "#1359ac");
                $(".fa-filter").css("color", "#ffffff");
                GlobalFilterID = FilterID;

            }
            else {
                $(".clearalllink").css({ "display": "none" });
                $(".filter").css("color", "transperent");
                $(".filter .fa-filter").css("color", "#464a4c");
            }

            GetDemandStatusList(QueryText);
        }


        //Clear Applied Filter
        function ClearBasicFilter(IdCaption) {

            $("[id*=cbo" + IdCaption + "Filter]").each(function (obj) {
                var cbo = this.id;
                $("#" + cbo + " option:first").prop('selected', 'selected');
            });
            $("[id*=txt" + IdCaption + "Filter]").each(function (obj) {
                var txt = this.id;
                if ($("#" + txt)[0].nodeName == "INPUT" || $("#" + txt)[0].nodeName == "TEXTAREA") {
                    $("#" + txt).val('').change();
                }
                else {
                    $("#" + txt + " option:first").prop('selected', 'selected');
                }
            });

        }

        //SetDefault Filter         
        function SetDefaultFilter(DefaultFilterID, flag) {
            var removeDefault = 0;
            if (flag == "default") {
                removeDefault = 1;
            }
            var FilterID = DefaultFilterID.replace("Default", "");
            if (FilterID != undefined) {
                Parameter = {
                    LoginType: encodeURI(LoginType),
                    UserID: encodeURI(UserID),
                    TagID: 3862,
                    FilterID: encodeURI(FilterID),
                    Flag: removeDefault

                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/RM_ResourceDemandStatus/SetDefaultFilter", param, false);
                if (removeDefault == 0) {
                    FilterID = "Apply" + FilterID;
                    //Comment and Added By Riddhesh Patil on 14 April 2023
                    //ApplyCheckFilter(FilterID);
                    ApplyCheckFilter(FilterID, 1);
                    //End of Comment and Added By Riddhesh Patil on 14 April 2023
                    alertify.success("<%= MyBase.GetResourceString("A_SetdefaultFilter") %>");
                    $(".filterpanel ").removeClass('in');
                    $(".clearalllink").css("display", "inline-block");
                    $(".filter button").css("background", "#1359ac");
                    $(".fa-filter").css("color", "#ffffff");

                } else {
                    FilterID = "Apply" + FilterID;
                    //Comment and Added By Riddhesh Patil on 14 April 2023
                    //ApplyCheckFilter(FilterID);
                    ApplyCheckFilter(FilterID, 1);
                    selectedqid="";
                    //End of Comment and Added By Riddhesh Patil on 14 April 2023
                    GlobalQueryText = null;
                    GetDemandStatusList(null);
                    alertify.success("<%= MyBase.GetResourceString("A_RemovedDefaultFilter") %>");
                    $(".filterpanel ").removeClass('in');
                    $(".clearalllink").css({ "display": "none" });
                    $(".filter button").css("background", "none");
                    $(".fa-filter").css("color", "#464a4c");
                }
            }
        }

        //Edit ModuleFilter 
        function EditFilter(EditID) {
            Flag = 1;
            FilterID = EditID.replace("Edit", "");
            if (FilterID != "") {
                GlobalFilterID = FilterID;
                GlobalFilterFlag = 1;

                var param = JSON.stringify(encodeURI(FilterID));
                var result = AJAXCallWithResult("/api/RM_ResourceDemandStatus/EditFilterData", param, false);
                for (var i = 0; i < result.length; i++) {
                    var QueryText = result[i].WhereClause;
                    GlobalFilterName = result[i].FilterName;
                }
                BindBasicFilters(QueryText, "RDS");
                $("#txtFilterName").val(GlobalFilterName);
                //Click on Edit SaveAndApply Section Will Be Display
                $(".filterpanel").addClass("in");
                $(".filterpanelbody").addClass("active");
                $('.nav-tabs li:last-child').addClass('active');
                $('#basicfilters').addClass('active');

            }
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
            $('#chk' + module + 'Filter' + field).prop('checked', val);
        }

        function ClearAll() {
            ClearBasicFilter('RDS')
            GetDemandStatusList(null);
            $(".clearalllink").hide();
            GlobalApplyID = "";
            GlobalQueryText = "";
            savedFilterName = "";
            GlobalFilterID = "";
            GlobalFilterName = "";
            FilterID = "";
            selectedqid = "";
            $(".filter .fa-filter").css("color", "#464a4c");
            //Added By Riddhesh Patil on 7th April 2023 for clear checkbox issue
            $("#chkRDSFilterMapToReadyForClosure").prop('checked', false);
            $("#chkRDSFilterMapToOpportunityInitiated").prop('checked', false);
            $("#chkRDSFilterMapToOpportunityOnHold").prop('checked', false);
            $("#chkRDSFilterMapToReopen").prop('checked', false);
            //Added By Riddhesh Patil on 7th April 2023 for clear checkbox issue
            $(".filterpanel").removeClass('in');
            //Commented and Modified By RehanC for filter issue on 29th Mar 2023
            //$(".filter .fa-filter").css("color", "#464a4c");
            $("#AdvanceFilterIcon").css("background", "");
            //End of Comment By RehanC
        }

        function ClearAllApplyFilter() {
            alertify.set('notifier', 'position', 'top-right');
            alertify.success("Filter removed successfully.");
            ClearAll();
        }


        //Filter End Here

    </script>
</body>
</html>
